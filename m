Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0769804013
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbjLDUhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346335AbjLDUhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:37:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55710189
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:35:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B87C433BC;
        Mon,  4 Dec 2023 20:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701722134;
        bh=i49s+DcY45DOcgp3WZwxJD37Nuiyf9nVIer8Ct53ez0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=crkR8a/anvbWyM1ILL6d2LQFwgvPJkGLuAr3r4vDVcxcXoDQYIBdI2Uqc1L0kTA/h
         ETxvX+zSepRO6pD4hm8AL4xEB3K2722ZcPkeW79Tufmx66bi0d0hq8G3poJIue/I/k
         Hrl7/HRTMrqPYUdVuZZ/ylEhDYCl6UVk2y7deCZ/y3qiH8ii4JtZDcgyP1/L4EX4yN
         QL89PqTK7/3RkhioLHhXlH5hl10sjcM1t5N8h5menRjBZAX2eDIL7sGDLfjVQEteQW
         slkeCTU5e5UY32mIkb/8603+bRc9arXibLm7+vProgvJKkfW8AYCZEiOxbBs2sBPk1
         L4q/xUN3IBN8w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael-CY Lee <michael-cy.lee@mediatek.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>, johannes@sipsolutions.net,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 06/17] wifi: avoid offset calculation on NULL pointer
Date:   Mon,  4 Dec 2023 15:34:51 -0500
Message-ID: <20231204203514.2093855-6-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203514.2093855-1-sashal@kernel.org>
References: <20231204203514.2093855-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.65
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
index 870ae4cd82029..dce105f67b4d8 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2658,12 +2658,14 @@ ieee80211_he_oper_size(const u8 *he_oper_ie)
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

