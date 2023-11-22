Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38C37F4B0F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344385AbjKVPi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344531AbjKVPiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:38:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150E519A7;
        Wed, 22 Nov 2023 07:36:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C442AC433CD;
        Wed, 22 Nov 2023 15:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700667359;
        bh=qMYe0ujzqXsUk0C5qySdnhJOisL1bIPCthnjXfv3pBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b+YneGy5jV6l7EgrzSrMVn3F5Bnd2utmfr47xJsYVNvIcRP5u/ejjnFGCYn73AE9l
         sH+4fJTmMXsyNRB3OGXnNkuA0VjsvB352YEDTkqxo1gel7kb05ZMXp+kAHfisyDnx1
         X0OSme9/S58XdduS7sk7NhxcMOJCSpEODYnKtJklIpzrijADKzVRlpxQYYvjWj1bDy
         3zDxIIV8DAgmiBIBq0tRETfe7FZIBacZk0fM+z+j6ehL9tDwbKAxqP39KR8CYyEj0q
         KgDJ7JFjv2Gh7ahq8hFiUTkweUJ1f/d+pBGRERZaw8nRzpKEH3yiZN6x8tJEZcBQu7
         7lvImhiIc+D7g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alex Pakhunov <alexey.pakhunov@spacex.com>,
        Vincent Wong <vincent.wong2@spacex.com>,
        Pavan Chebbi <pavan.chebbi@broadcom.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>, mchan@broadcom.com,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 5/7] tg3: Increment tx_dropped in tg3_tso_bug()
Date:   Wed, 22 Nov 2023 10:35:33 -0500
Message-ID: <20231122153541.853179-5-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122153541.853179-1-sashal@kernel.org>
References: <20231122153541.853179-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.201
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Pakhunov <alexey.pakhunov@spacex.com>

[ Upstream commit 17dd5efe5f36a96bd78012594fabe21efb01186b ]

tg3_tso_bug() drops a packet if it cannot be segmented for any reason.
The number of discarded frames should be incremented accordingly.

Signed-off-by: Alex Pakhunov <alexey.pakhunov@spacex.com>
Signed-off-by: Vincent Wong <vincent.wong2@spacex.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Link: https://lore.kernel.org/r/20231113182350.37472-2-alexey.pakhunov@spacex.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/tg3.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index a2c6c204fe9d4..b010f28b0abf4 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -7890,8 +7890,10 @@ static int tg3_tso_bug(struct tg3 *tp, struct tg3_napi *tnapi,
 
 	segs = skb_gso_segment(skb, tp->dev->features &
 				    ~(NETIF_F_TSO | NETIF_F_TSO6));
-	if (IS_ERR(segs) || !segs)
+	if (IS_ERR(segs) || !segs) {
+		tnapi->tx_dropped++;
 		goto tg3_tso_bug_end;
+	}
 
 	skb_list_walk_safe(segs, seg, next) {
 		skb_mark_not_on_list(seg);
-- 
2.42.0

