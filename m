Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B747E3BBA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbjKGMJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbjKGMIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:08:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F892102;
        Tue,  7 Nov 2023 04:08:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E73C43391;
        Tue,  7 Nov 2023 12:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699358887;
        bh=m4GR3HEp/0QZHpgM7Xx9QUuUGlCZyWMpGXU8UeBqoPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rfAvLFc8sp3WBbtTixmbNfjbIrw/29m8+auk8S08Giwz/MDtV/ehJ4DCGlA+wy/y0
         1XWjJ/X+JBXuk02pS+IpjUInfiFK6z4/D7+OPriRfcb8+r3cASwtQB/oVrsEoYRh7L
         h2otiQ7IZffR/mwWEZnCCEH5IYbjOmI8v3yULlD3YDLAsxSadlweY2vVOC6Q9hw4n4
         l/UVqTTL8RbYL2wxW5+Wr7fahBdtsMTX3BGLigTrtlQerTW/WCI7xvqt9yksLfL8rh
         RoGgrbdoqJbVxQKZK1FeeYbFjVBQWgtWHF+l4GH9WAS5O41rF8lbp1Guya1FMh3UmV
         4+pBHFq5NoHiw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ma Ke <make_ruc2021@163.com>, Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        quic_jjohnson@quicinc.com, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 18/31] wifi: ath12k: mhi: fix potential memory leak in ath12k_mhi_register()
Date:   Tue,  7 Nov 2023 07:06:05 -0500
Message-ID: <20231107120704.3756327-18-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107120704.3756327-1-sashal@kernel.org>
References: <20231107120704.3756327-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ma Ke <make_ruc2021@163.com>

[ Upstream commit 47c27aa7ded4b8ead19b3487cc42a6185b762903 ]

mhi_alloc_controller() allocates a memory space for mhi_ctrl. When some
errors occur, mhi_ctrl should be freed by mhi_free_controller() and set
ab_pci->mhi_ctrl = NULL.

We can fix it by calling mhi_free_controller() when the failure happens
and set ab_pci->mhi_ctrl = NULL in all of the places where we call
mhi_free_controller().

Signed-off-by: Ma Ke <make_ruc2021@163.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230922021036.3604157-1-make_ruc2021@163.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/mhi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mhi.c b/drivers/net/wireless/ath/ath12k/mhi.c
index 42f1140baa4fe..f83d3e09ae366 100644
--- a/drivers/net/wireless/ath/ath12k/mhi.c
+++ b/drivers/net/wireless/ath/ath12k/mhi.c
@@ -370,8 +370,7 @@ int ath12k_mhi_register(struct ath12k_pci *ab_pci)
 	ret = ath12k_mhi_get_msi(ab_pci);
 	if (ret) {
 		ath12k_err(ab, "failed to get msi for mhi\n");
-		mhi_free_controller(mhi_ctrl);
-		return ret;
+		goto free_controller;
 	}
 
 	mhi_ctrl->iova_start = 0;
@@ -388,11 +387,15 @@ int ath12k_mhi_register(struct ath12k_pci *ab_pci)
 	ret = mhi_register_controller(mhi_ctrl, ab->hw_params->mhi_config);
 	if (ret) {
 		ath12k_err(ab, "failed to register to mhi bus, err = %d\n", ret);
-		mhi_free_controller(mhi_ctrl);
-		return ret;
+		goto free_controller;
 	}
 
 	return 0;
+
+free_controller:
+	mhi_free_controller(mhi_ctrl);
+	ab_pci->mhi_ctrl = NULL;
+	return ret;
 }
 
 void ath12k_mhi_unregister(struct ath12k_pci *ab_pci)
-- 
2.42.0

