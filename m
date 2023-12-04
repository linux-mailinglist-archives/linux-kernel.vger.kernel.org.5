Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681F7803F81
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346177AbjLDUeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346172AbjLDUds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:33:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1FD10FA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:33:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0F2C433CD;
        Mon,  4 Dec 2023 20:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701722028;
        bh=Oe/XzUk1VemmFJ9zSC9J3wWmOiOIwp2Vd4qep/nEW4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y1+Cq7vZZnfn8FrP6d4qzjKbHTW14/3YfgI67YrcoazmugWsMl28CFVUG7Lrmtu8o
         D1DuJIQ7iGf3LvAeX7LwH3O59ZAExBcFPWLb04sA3v6oJwbcmpaBXfjf1AM8WdC7sm
         +KJ6zkbez7o1nvQDOeJldh2d8vpZJkSitD21+wUnt2NX7Blzz0wW8Kko6/RxrxUKVD
         WWlP/bdqdUG39LY3L8whXj3gTv6SR8wMTizT3Gr2HF/v80/6FeX0v00+LhW9BIIUUH
         Atvb67AYnNoM/TI3xZTiYZnBpKzGL+MKN5Tyi1TBXP7yolpiHpZp8CsbZqCgN/fyoi
         7P7jCKDgf8PCg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael-CY Lee <michael-cy.lee@mediatek.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>, johannes@sipsolutions.net,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 12/32] wifi: avoid offset calculation on NULL pointer
Date:   Mon,  4 Dec 2023 15:32:32 -0500
Message-ID: <20231204203317.2092321-12-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203317.2092321-1-sashal@kernel.org>
References: <20231204203317.2092321-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael-CY Lee <michael-cy.lee@mediatek.com>

[ Upstream commit ef5828805842204dd0259ecfc132b5916c8a77ae ]

ieee80211_he_6ghz_oper() can be passed a NULL pointer
and checks for that, but already did the calculation
to inside of it before. Move it after the check.

Signed-off-by: Michael-CY Lee <michael-cy.lee@mediatek.com>
Link: https://lore.kernel.org/r/20231122030237.31276-1-michael-cy.lee@mediatek.com
[rewrite commit message]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/ieee80211.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index b24fb80782c5a..6971bf16031f1 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2790,12 +2790,14 @@ ieee80211_he_oper_size(const u8 *he_oper_ie)
 static inline const struct ieee80211_he_6ghz_oper *
 ieee80211_he_6ghz_oper(const struct ieee80211_he_operation *he_oper)
 {
-	const u8 *ret = (const void *)&he_oper->optional;
+	const u8 *ret;
 	u32 he_oper_params;
 
 	if (!he_oper)
 		return NULL;
 
+	ret = (const void *)&he_oper->optional;
+
 	he_oper_params = le32_to_cpu(he_oper->he_oper_params);
 
 	if (!(he_oper_params & IEEE80211_HE_OPERATION_6GHZ_OP_INFO))
-- 
2.42.0

