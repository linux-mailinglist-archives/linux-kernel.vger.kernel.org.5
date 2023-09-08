Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7ED9798EF7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241867AbjIHTRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbjIHTRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:17:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8ED3BC;
        Fri,  8 Sep 2023 12:17:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418BFC43215;
        Fri,  8 Sep 2023 18:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694197294;
        bh=imGbdW/kqhSp3BhftH7mXd/5L5VUrZohm40wn3y+3f0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cZD88jXQVUs7B/Kzif8lNUy4EB7fX2f5VLXdefBFC2jUjh4Nv7sAw78cU2VSe5TTB
         bBg2/radO/Mwi9uPrJX+O8oluFvS256Tj1zpbZp6iilB4Y4A3/+PO5e27diwoakcLd
         iOxX0CHBrISUYsHkh1v0e/SbZWAd49Dgu9+wabiIv8LS1GwRbDvy1fafstk+HZ1Rdl
         NcXUapncsKfzZhm/+hk1CAFdeSJCmbi/bbEZk+ug3DY8kBv89B74FQs7kugM9TPx5i
         g+RfW3eOgoGvVTQpeE1mFlnSp9jZ1TEW2C9RtFaNBdaP2CNAORAyhSjcqkrTWeqFic
         6Gs35LuwDrhtA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Antipov <dmantipov@yandex.ru>,
        Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 2/8] wifi: mwifiex: fix fortify warning
Date:   Fri,  8 Sep 2023 14:21:21 -0400
Message-Id: <20230908182127.3461199-2-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908182127.3461199-1-sashal@kernel.org>
References: <20230908182127.3461199-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.325
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit dcce94b80a954a8968ff29fafcfb066d6197fa9a ]

When compiling with gcc 13.1 and CONFIG_FORTIFY_SOURCE=y,
I've noticed the following:

In function ‘fortify_memcpy_chk’,
    inlined from ‘mwifiex_construct_tdls_action_frame’ at drivers/net/wireless/marvell/mwifiex/tdls.c:765:3,
    inlined from ‘mwifiex_send_tdls_action_frame’ at drivers/net/wireless/marvell/mwifiex/tdls.c:856:6:
./include/linux/fortify-string.h:529:25: warning: call to ‘__read_overflow2_field’
declared with attribute warning: detected read beyond size of field (2nd parameter);
maybe use struct_group()? [-Wattribute-warning]
  529 |                         __read_overflow2_field(q_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The compiler actually complains on:

memmove(pos + ETH_ALEN, &mgmt->u.action.category,
	sizeof(mgmt->u.action.u.tdls_discover_resp));

and it happens because the fortification logic interprets this
as an attempt to overread 1-byte 'u.action.category' member of
'struct ieee80211_mgmt'. To silence this warning, it's enough
to pass an address of 'u.action' itself instead of an address
of its first member.

This also fixes an improper usage of 'sizeof()'. Since 'skb' is
extended with 'sizeof(mgmt->u.action.u.tdls_discover_resp) + 1'
bytes (where 1 is actually 'sizeof(mgmt->u.action.category)'),
I assume that the same number of bytes should be copied.

Suggested-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230629085115.180499-2-dmantipov@yandex.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/mwifiex/tdls.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/tdls.c b/drivers/net/wireless/marvell/mwifiex/tdls.c
index 80d20fb6f3480..a69b4983747f3 100644
--- a/drivers/net/wireless/marvell/mwifiex/tdls.c
+++ b/drivers/net/wireless/marvell/mwifiex/tdls.c
@@ -737,6 +737,7 @@ mwifiex_construct_tdls_action_frame(struct mwifiex_private *priv,
 	int ret;
 	u16 capab;
 	struct ieee80211_ht_cap *ht_cap;
+	unsigned int extra;
 	u8 radio, *pos;
 
 	capab = priv->curr_bss_params.bss_descriptor.cap_info_bitmap;
@@ -755,7 +756,10 @@ mwifiex_construct_tdls_action_frame(struct mwifiex_private *priv,
 
 	switch (action_code) {
 	case WLAN_PUB_ACTION_TDLS_DISCOVER_RES:
-		skb_put(skb, sizeof(mgmt->u.action.u.tdls_discover_resp) + 1);
+		/* See the layout of 'struct ieee80211_mgmt'. */
+		extra = sizeof(mgmt->u.action.u.tdls_discover_resp) +
+			sizeof(mgmt->u.action.category);
+		skb_put(skb, extra);
 		mgmt->u.action.category = WLAN_CATEGORY_PUBLIC;
 		mgmt->u.action.u.tdls_discover_resp.action_code =
 					      WLAN_PUB_ACTION_TDLS_DISCOVER_RES;
@@ -764,8 +768,7 @@ mwifiex_construct_tdls_action_frame(struct mwifiex_private *priv,
 		mgmt->u.action.u.tdls_discover_resp.capability =
 							     cpu_to_le16(capab);
 		/* move back for addr4 */
-		memmove(pos + ETH_ALEN, &mgmt->u.action.category,
-			sizeof(mgmt->u.action.u.tdls_discover_resp));
+		memmove(pos + ETH_ALEN, &mgmt->u.action, extra);
 		/* init address 4 */
 		memcpy(pos, bc_addr, ETH_ALEN);
 
-- 
2.40.1

