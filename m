Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE7A7CC0D5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 12:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343700AbjJQKmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 06:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbjJQKmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:42:52 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B6AB0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 03:42:48 -0700 (PDT)
X-UUID: f78b398fc5b0488687c6865f72c1d3f0-20231017
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:76ffdbd8-1677-4506-b63a-68ddef809464,IP:15,
        URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
        TION:release,TS:-25
X-CID-INFO: VERSION:1.1.32,REQID:76ffdbd8-1677-4506-b63a-68ddef809464,IP:15,UR
        L:0,TC:0,Content:-25,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:-25
X-CID-META: VersionHash:5f78ec9,CLOUDID:b76f08c0-14cc-44ca-b657-2d2783296e72,B
        ulkID:231017184101ZBFZ2WG9,BulkQuantity:1,Recheck:0,SF:66|38|24|17|19|44|1
        02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL
        :0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: f78b398fc5b0488687c6865f72c1d3f0-20231017
X-User: chentao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1169852561; Tue, 17 Oct 2023 18:42:37 +0800
From:   "Kunwu.Chan" <chentao@kylinos.cn>
To:     daniel@ffwll.ch, airlied@gmail.com, Xinhui.Pan@amd.com,
        christian.koenig@amd.com, alexander.deucher@amd.com
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, kunwu.chan@hotmail.com,
        "Kunwu.Chan" <chentao@kylinos.cn>
Subject: [PATCH] drm/radeon:  Remove the useless variable 'disable_plloff_in_l1'
Date:   Tue, 17 Oct 2023 18:42:01 +0800
Message-Id: <20231017104201.49386-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because the disable_plloff_in_l1 variable is always false, the if judgment
 on line 9696 is always true. Remove this variable and this if statement.

Fixes: 7235711a43b6 ("drm/radeon: add support for ASPM on CIK asics")
Signed-off-by: Kunwu.Chan <chentao@kylinos.cn>
---
 drivers/gpu/drm/radeon/cik.c | 134 +++++++++++++++++------------------
 1 file changed, 66 insertions(+), 68 deletions(-)

diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
index 10be30366c2b..62a9c1126bb3 100644
--- a/drivers/gpu/drm/radeon/cik.c
+++ b/drivers/gpu/drm/radeon/cik.c
@@ -9652,7 +9652,7 @@ static void cik_pcie_gen3_enable(struct radeon_device *rdev)
 static void cik_program_aspm(struct radeon_device *rdev)
 {
 	u32 data, orig;
-	bool disable_l0s = false, disable_l1 = false, disable_plloff_in_l1 = false;
+	bool disable_l0s = false, disable_l1 = false;
 	bool disable_clkreq = false;
 
 	if (radeon_aspm == 0)
@@ -9693,86 +9693,84 @@ static void cik_program_aspm(struct radeon_device *rdev)
 		if (orig != data)
 			WREG32_PCIE_PORT(PCIE_LC_CNTL, data);
 
-		if (!disable_plloff_in_l1) {
-			bool clk_req_support;
+		bool clk_req_support;
 
-			orig = data = RREG32_PCIE_PORT(PB0_PIF_PWRDOWN_0);
-			data &= ~(PLL_POWER_STATE_IN_OFF_0_MASK | PLL_POWER_STATE_IN_TXS2_0_MASK);
-			data |= PLL_POWER_STATE_IN_OFF_0(7) | PLL_POWER_STATE_IN_TXS2_0(7);
-			if (orig != data)
-				WREG32_PCIE_PORT(PB0_PIF_PWRDOWN_0, data);
+		orig = data = RREG32_PCIE_PORT(PB0_PIF_PWRDOWN_0);
+		data &= ~(PLL_POWER_STATE_IN_OFF_0_MASK | PLL_POWER_STATE_IN_TXS2_0_MASK);
+		data |= PLL_POWER_STATE_IN_OFF_0(7) | PLL_POWER_STATE_IN_TXS2_0(7);
+		if (orig != data)
+			WREG32_PCIE_PORT(PB0_PIF_PWRDOWN_0, data);
 
-			orig = data = RREG32_PCIE_PORT(PB0_PIF_PWRDOWN_1);
-			data &= ~(PLL_POWER_STATE_IN_OFF_1_MASK | PLL_POWER_STATE_IN_TXS2_1_MASK);
-			data |= PLL_POWER_STATE_IN_OFF_1(7) | PLL_POWER_STATE_IN_TXS2_1(7);
-			if (orig != data)
-				WREG32_PCIE_PORT(PB0_PIF_PWRDOWN_1, data);
+		orig = data = RREG32_PCIE_PORT(PB0_PIF_PWRDOWN_1);
+		data &= ~(PLL_POWER_STATE_IN_OFF_1_MASK | PLL_POWER_STATE_IN_TXS2_1_MASK);
+		data |= PLL_POWER_STATE_IN_OFF_1(7) | PLL_POWER_STATE_IN_TXS2_1(7);
+		if (orig != data)
+			WREG32_PCIE_PORT(PB0_PIF_PWRDOWN_1, data);
 
-			orig = data = RREG32_PCIE_PORT(PB1_PIF_PWRDOWN_0);
-			data &= ~(PLL_POWER_STATE_IN_OFF_0_MASK | PLL_POWER_STATE_IN_TXS2_0_MASK);
-			data |= PLL_POWER_STATE_IN_OFF_0(7) | PLL_POWER_STATE_IN_TXS2_0(7);
-			if (orig != data)
-				WREG32_PCIE_PORT(PB1_PIF_PWRDOWN_0, data);
+		orig = data = RREG32_PCIE_PORT(PB1_PIF_PWRDOWN_0);
+		data &= ~(PLL_POWER_STATE_IN_OFF_0_MASK | PLL_POWER_STATE_IN_TXS2_0_MASK);
+		data |= PLL_POWER_STATE_IN_OFF_0(7) | PLL_POWER_STATE_IN_TXS2_0(7);
+		if (orig != data)
+			WREG32_PCIE_PORT(PB1_PIF_PWRDOWN_0, data);
 
-			orig = data = RREG32_PCIE_PORT(PB1_PIF_PWRDOWN_1);
-			data &= ~(PLL_POWER_STATE_IN_OFF_1_MASK | PLL_POWER_STATE_IN_TXS2_1_MASK);
-			data |= PLL_POWER_STATE_IN_OFF_1(7) | PLL_POWER_STATE_IN_TXS2_1(7);
-			if (orig != data)
-				WREG32_PCIE_PORT(PB1_PIF_PWRDOWN_1, data);
+		orig = data = RREG32_PCIE_PORT(PB1_PIF_PWRDOWN_1);
+		data &= ~(PLL_POWER_STATE_IN_OFF_1_MASK | PLL_POWER_STATE_IN_TXS2_1_MASK);
+		data |= PLL_POWER_STATE_IN_OFF_1(7) | PLL_POWER_STATE_IN_TXS2_1(7);
+		if (orig != data)
+			WREG32_PCIE_PORT(PB1_PIF_PWRDOWN_1, data);
 
-			orig = data = RREG32_PCIE_PORT(PCIE_LC_LINK_WIDTH_CNTL);
-			data &= ~LC_DYN_LANES_PWR_STATE_MASK;
-			data |= LC_DYN_LANES_PWR_STATE(3);
-			if (orig != data)
-				WREG32_PCIE_PORT(PCIE_LC_LINK_WIDTH_CNTL, data);
+		orig = data = RREG32_PCIE_PORT(PCIE_LC_LINK_WIDTH_CNTL);
+		data &= ~LC_DYN_LANES_PWR_STATE_MASK;
+		data |= LC_DYN_LANES_PWR_STATE(3);
+		if (orig != data)
+			WREG32_PCIE_PORT(PCIE_LC_LINK_WIDTH_CNTL, data);
 
-			if (!disable_clkreq &&
-			    !pci_is_root_bus(rdev->pdev->bus)) {
-				struct pci_dev *root = rdev->pdev->bus->self;
-				u32 lnkcap;
+		if (!disable_clkreq &&
+			!pci_is_root_bus(rdev->pdev->bus)) {
+			struct pci_dev *root = rdev->pdev->bus->self;
+			u32 lnkcap;
 
-				clk_req_support = false;
-				pcie_capability_read_dword(root, PCI_EXP_LNKCAP, &lnkcap);
-				if (lnkcap & PCI_EXP_LNKCAP_CLKPM)
-					clk_req_support = true;
-			} else {
-				clk_req_support = false;
-			}
+			clk_req_support = false;
+			pcie_capability_read_dword(root, PCI_EXP_LNKCAP, &lnkcap);
+			if (lnkcap & PCI_EXP_LNKCAP_CLKPM)
+				clk_req_support = true;
+		} else {
+			clk_req_support = false;
+		}
 
-			if (clk_req_support) {
-				orig = data = RREG32_PCIE_PORT(PCIE_LC_CNTL2);
-				data |= LC_ALLOW_PDWN_IN_L1 | LC_ALLOW_PDWN_IN_L23;
-				if (orig != data)
-					WREG32_PCIE_PORT(PCIE_LC_CNTL2, data);
+		if (clk_req_support) {
+			orig = data = RREG32_PCIE_PORT(PCIE_LC_CNTL2);
+			data |= LC_ALLOW_PDWN_IN_L1 | LC_ALLOW_PDWN_IN_L23;
+			if (orig != data)
+				WREG32_PCIE_PORT(PCIE_LC_CNTL2, data);
 
-				orig = data = RREG32_SMC(THM_CLK_CNTL);
-				data &= ~(CMON_CLK_SEL_MASK | TMON_CLK_SEL_MASK);
-				data |= CMON_CLK_SEL(1) | TMON_CLK_SEL(1);
-				if (orig != data)
-					WREG32_SMC(THM_CLK_CNTL, data);
+			orig = data = RREG32_SMC(THM_CLK_CNTL);
+			data &= ~(CMON_CLK_SEL_MASK | TMON_CLK_SEL_MASK);
+			data |= CMON_CLK_SEL(1) | TMON_CLK_SEL(1);
+			if (orig != data)
+				WREG32_SMC(THM_CLK_CNTL, data);
 
-				orig = data = RREG32_SMC(MISC_CLK_CTRL);
-				data &= ~(DEEP_SLEEP_CLK_SEL_MASK | ZCLK_SEL_MASK);
-				data |= DEEP_SLEEP_CLK_SEL(1) | ZCLK_SEL(1);
-				if (orig != data)
-					WREG32_SMC(MISC_CLK_CTRL, data);
+			orig = data = RREG32_SMC(MISC_CLK_CTRL);
+			data &= ~(DEEP_SLEEP_CLK_SEL_MASK | ZCLK_SEL_MASK);
+			data |= DEEP_SLEEP_CLK_SEL(1) | ZCLK_SEL(1);
+			if (orig != data)
+				WREG32_SMC(MISC_CLK_CTRL, data);
 
-				orig = data = RREG32_SMC(CG_CLKPIN_CNTL);
-				data &= ~BCLK_AS_XCLK;
-				if (orig != data)
-					WREG32_SMC(CG_CLKPIN_CNTL, data);
+			orig = data = RREG32_SMC(CG_CLKPIN_CNTL);
+			data &= ~BCLK_AS_XCLK;
+			if (orig != data)
+				WREG32_SMC(CG_CLKPIN_CNTL, data);
 
-				orig = data = RREG32_SMC(CG_CLKPIN_CNTL_2);
-				data &= ~FORCE_BIF_REFCLK_EN;
-				if (orig != data)
-					WREG32_SMC(CG_CLKPIN_CNTL_2, data);
+			orig = data = RREG32_SMC(CG_CLKPIN_CNTL_2);
+			data &= ~FORCE_BIF_REFCLK_EN;
+			if (orig != data)
+				WREG32_SMC(CG_CLKPIN_CNTL_2, data);
 
-				orig = data = RREG32_SMC(MPLL_BYPASSCLK_SEL);
-				data &= ~MPLL_CLKOUT_SEL_MASK;
-				data |= MPLL_CLKOUT_SEL(4);
-				if (orig != data)
-					WREG32_SMC(MPLL_BYPASSCLK_SEL, data);
-			}
+			orig = data = RREG32_SMC(MPLL_BYPASSCLK_SEL);
+			data &= ~MPLL_CLKOUT_SEL_MASK;
+			data |= MPLL_CLKOUT_SEL(4);
+			if (orig != data)
+				WREG32_SMC(MPLL_BYPASSCLK_SEL, data);
 		}
 	} else {
 		if (orig != data)
-- 
2.25.1

