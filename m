Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E17756784
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjGQPTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjGQPTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:19:23 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2280C10E7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:19:20 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f9fdb0ef35so7519361e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689607158; x=1692199158;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+KuPxi1C9v4ead/OACB04tCRB3cg6PlY88neux9MKiA=;
        b=EaOiMiPGl0szt/u6qKnLFCt30b8Wg/W8aK13JrTNCd564obk0rB+4MOCLzhg9DITvo
         P0XTAcSjbaYOBHVEf3jtvPNZXjHS+IGpqqYv1j1uisTe5w4MjUrjbi5rpsLnv8CsUALb
         7bQ12iAMHRV4kBrzpUys58T1VI6yByH6d9SCJDljgVMisP8TPdkZJ7WQUDDyzF1vFcO9
         dI0j/NBLen/VqrvWhZwvXt+XG/ZEKeuPSwMxo4AYR+yu/IRA8i8VCMs/2nWk8A0qW12P
         KgfNZI43plk7LEtSTKUIJ4woWRVTOPDLFgid3ynvEbOdbryAJFCrBxpzICRafZ7rvjPP
         dFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689607158; x=1692199158;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KuPxi1C9v4ead/OACB04tCRB3cg6PlY88neux9MKiA=;
        b=MtNFCuSSj2pU+mfn/DgrRwQorjsL/YYTyvQ1jw9GainCUm1vnv77ZkDS5GsWCILffM
         vTVTDTJDBCLDBm+guRCyz1dRUtYIm+fdjwYP8AUUDqms38zPbZpv3+iVCfgn19WtsICr
         1smtZc6TZD/DqU0z8iLuW3hgVwnFDoqLaVfzWtAtu8OMXolkzanqU3WO2t4YzCngyK7F
         4SOhU2TZ7tN+gfpEQKCBufYqAxBYraRvrSWng+/VMvW3i58paSUr+49Ob7cCSawWbYsh
         gmlDSlLcnNJe5vo3tjeyFzF2IHCouIt46R5r2emnIr8reiCA3sp/T6S08h/9QDfPlnJV
         TP0g==
X-Gm-Message-State: ABy/qLZ7wahDUFIXxve9Ox3zm/ZyoWqMHmOFeERS9DDRnws2I+yi8uIG
        1/Dmq9ISw7Sb9d3vtXoYEttyCQ==
X-Google-Smtp-Source: APBJJlGS0BoLKRIohSP2V+ZDI59LSw+/TuRNizZszu2Ewo+hjR4KjhizENM/BpOcGgr6tCpNGWDLVw==
X-Received: by 2002:ac2:548b:0:b0:4f9:72a5:2b76 with SMTP id t11-20020ac2548b000000b004f972a52b76mr7826843lfk.65.1689607158068;
        Mon, 17 Jul 2023 08:19:18 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id z7-20020ac24187000000b004f26d63f823sm2873949lfh.237.2023.07.17.08.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 08:19:17 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 17 Jul 2023 17:19:12 +0200
Subject: [PATCH 05/15] clk: qcom: gpucc-sm6375: Unregister critical clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-topic-branch_aon_cleanup-v1-5-27784d27a4f4@linaro.org>
References: <20230717-topic-branch_aon_cleanup-v1-0-27784d27a4f4@linaro.org>
In-Reply-To: <20230717-topic-branch_aon_cleanup-v1-0-27784d27a4f4@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689607149; l=9588;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=qrPiFGkb35Smv+A56ju84eBm0qjbLG5DXe1UpLsgD14=;
 b=40ig1X5bIzfGx13qAC9tEY/MyfhAPa/1IYBhtQWC94fSClVve1HzxtI5vFtPMFoiS+HUMkpsm
 +WQzaSk1LAvCMiQ0XbDPTV1GoRKu3CTzr5mj0otBeV8VZXlBAFge8c5
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some clocks need to be always-on, but we don't really do anything
with them, other than calling enable() once and telling Linux they're
enabled.

Unregister them to save a couple of bytes and, perhaps more
importantly, allow for runtime suspend of the clock controller device,
as CLK_IS_CRITICAL prevents the latter.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/gcc-sm6375.c   | 105 ++++++++++++++++++++++++++++++++++------
 drivers/clk/qcom/gpucc-sm6375.c |  38 +++------------
 2 files changed, 97 insertions(+), 46 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm6375.c b/drivers/clk/qcom/gcc-sm6375.c
index 4b2de545d3f8..a8eb7a47e284 100644
--- a/drivers/clk/qcom/gcc-sm6375.c
+++ b/drivers/clk/qcom/gcc-sm6375.c
@@ -1743,6 +1743,21 @@ static struct clk_branch gcc_cam_throttle_rt_clk = {
 	},
 };
 
+static struct clk_branch gcc_camera_ahb_clk = {
+	.halt_reg = 0x17008,
+	.halt_check = BRANCH_HALT_DELAY,
+	.hwcg_reg = 0x17008,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x17008,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_camera_ahb_clk",
+			.ops = &clk_branch2_aon_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_camss_axi_clk = {
 	.halt_reg = 0x58044,
 	.halt_check = BRANCH_HALT,
@@ -2293,6 +2308,21 @@ static struct clk_branch gcc_cfg_noc_usb3_prim_axi_clk = {
 	},
 };
 
+static struct clk_branch gcc_disp_ahb_clk = {
+	.halt_reg = 0x1700c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x1700c,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x1700c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_disp_ahb_clk",
+			.ops = &clk_branch2_aon_ops,
+		},
+	},
+};
+
 static struct clk_regmap_div gcc_disp_gpll0_clk_src = {
 	.reg = 0x17058,
 	.shift = 0,
@@ -2423,6 +2453,21 @@ static struct clk_branch gcc_gp3_clk = {
 	},
 };
 
+static struct clk_branch gcc_gpu_cfg_ahb_clk = {
+	.halt_reg = 0x36004,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x36004,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x36004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_gpu_cfg_ahb_clk",
+			.ops = &clk_branch2_aon_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_gpu_gpll0_clk_src = {
 	.halt_check = BRANCH_HALT_DELAY,
 	.clkr = {
@@ -3046,6 +3091,26 @@ static struct clk_branch gcc_sdcc2_apps_clk = {
 	},
 };
 
+static struct clk_branch gcc_sys_noc_cpuss_ahb_clk = {
+	.halt_reg = 0x2b06c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x2b06c,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x79004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_sys_noc_cpuss_ahb_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_cpuss_ahb_postdiv_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_aon_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_sys_noc_ufs_phy_axi_clk = {
 	.halt_reg = 0x45098,
 	.halt_check = BRANCH_HALT,
@@ -3365,6 +3430,21 @@ static struct clk_branch gcc_venus_ctl_axi_clk = {
 	},
 };
 
+static struct clk_branch gcc_video_ahb_clk = {
+	.halt_reg = 0x17004,
+	.halt_check = BRANCH_HALT_DELAY,
+	.hwcg_reg = 0x17004,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x17004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_video_ahb_clk",
+			.ops = &clk_branch2_aon_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_video_axi0_clk = {
 	.halt_reg = 0x1701c,
 	.halt_check = BRANCH_HALT_VOTED,
@@ -3531,6 +3611,7 @@ static struct clk_regmap *gcc_sm6375_clocks[] = {
 	[GCC_BOOT_ROM_AHB_CLK] = &gcc_boot_rom_ahb_clk.clkr,
 	[GCC_CAM_THROTTLE_NRT_CLK] = &gcc_cam_throttle_nrt_clk.clkr,
 	[GCC_CAM_THROTTLE_RT_CLK] = &gcc_cam_throttle_rt_clk.clkr,
+	[GCC_CAMERA_AHB_CLK] = &gcc_camera_ahb_clk.clkr,
 	[GCC_CAMSS_AXI_CLK] = &gcc_camss_axi_clk.clkr,
 	[GCC_CAMSS_AXI_CLK_SRC] = &gcc_camss_axi_clk_src.clkr,
 	[GCC_CAMSS_CCI_0_CLK] = &gcc_camss_cci_0_clk.clkr,
@@ -3586,6 +3667,7 @@ static struct clk_regmap *gcc_sm6375_clocks[] = {
 	[GCC_CFG_NOC_USB3_PRIM_AXI_CLK] = &gcc_cfg_noc_usb3_prim_axi_clk.clkr,
 	[GCC_CPUSS_AHB_CLK_SRC] = &gcc_cpuss_ahb_clk_src.clkr,
 	[GCC_CPUSS_AHB_POSTDIV_CLK_SRC] = &gcc_cpuss_ahb_postdiv_clk_src.clkr,
+	[GCC_DISP_AHB_CLK] = &gcc_disp_ahb_clk.clkr,
 	[GCC_DISP_GPLL0_CLK_SRC] = &gcc_disp_gpll0_clk_src.clkr,
 	[GCC_DISP_GPLL0_DIV_CLK_SRC] = &gcc_disp_gpll0_div_clk_src.clkr,
 	[GCC_DISP_HF_AXI_CLK] = &gcc_disp_hf_axi_clk.clkr,
@@ -3597,6 +3679,7 @@ static struct clk_regmap *gcc_sm6375_clocks[] = {
 	[GCC_GP2_CLK_SRC] = &gcc_gp2_clk_src.clkr,
 	[GCC_GP3_CLK] = &gcc_gp3_clk.clkr,
 	[GCC_GP3_CLK_SRC] = &gcc_gp3_clk_src.clkr,
+	[GCC_GPU_CFG_AHB_CLK] = &gcc_gpu_cfg_ahb_clk.clkr,
 	[GCC_GPU_GPLL0_CLK_SRC] = &gcc_gpu_gpll0_clk_src.clkr,
 	[GCC_GPU_GPLL0_DIV_CLK_SRC] = &gcc_gpu_gpll0_div_clk_src.clkr,
 	[GCC_GPU_MEMNOC_GFX_CLK] = &gcc_gpu_memnoc_gfx_clk.clkr,
@@ -3652,6 +3735,7 @@ static struct clk_regmap *gcc_sm6375_clocks[] = {
 	[GCC_SDCC2_AHB_CLK] = &gcc_sdcc2_ahb_clk.clkr,
 	[GCC_SDCC2_APPS_CLK] = &gcc_sdcc2_apps_clk.clkr,
 	[GCC_SDCC2_APPS_CLK_SRC] = &gcc_sdcc2_apps_clk_src.clkr,
+	[GCC_SYS_NOC_CPUSS_AHB_CLK] = &gcc_sys_noc_cpuss_ahb_clk.clkr,
 	[GCC_SYS_NOC_UFS_PHY_AXI_CLK] = &gcc_sys_noc_ufs_phy_axi_clk.clkr,
 	[GCC_SYS_NOC_USB3_PRIM_AXI_CLK] = &gcc_sys_noc_usb3_prim_axi_clk.clkr,
 	[GCC_UFS_PHY_AHB_CLK] = &gcc_ufs_phy_ahb_clk.clkr,
@@ -3678,6 +3762,7 @@ static struct clk_regmap *gcc_sm6375_clocks[] = {
 	[GCC_VCODEC0_AXI_CLK] = &gcc_vcodec0_axi_clk.clkr,
 	[GCC_VENUS_AHB_CLK] = &gcc_venus_ahb_clk.clkr,
 	[GCC_VENUS_CTL_AXI_CLK] = &gcc_venus_ctl_axi_clk.clkr,
+	[GCC_VIDEO_AHB_CLK] = &gcc_video_ahb_clk.clkr,
 	[GCC_VIDEO_AXI0_CLK] = &gcc_video_axi0_clk.clkr,
 	[GCC_VIDEO_THROTTLE_CORE_CLK] = &gcc_video_throttle_core_clk.clkr,
 	[GCC_VIDEO_VCODEC0_SYS_CLK] = &gcc_video_vcodec0_sys_clk.clkr,
@@ -3805,23 +3890,11 @@ static int gcc_sm6375_probe(struct platform_device *pdev)
 
 	/*
 	 * Keep the following clocks always on:
-	 * GCC_CAMERA_XO_CLK
-	 * GCC_CPUSS_GNOC_CLK
-	 * GCC_DISP_XO_CLK
-	 * GCC_CAMERA_AHB_CLK
-	 * GCC_DISP_AHB_CLK
-	 * GCC_GPU_CFG_AHB_CLK
-	 * GCC_SYS_NOC_CPUSS_AHB_CLK
-	 * GCC_VIDEO_AHB_CLK
+	 * GCC_CAMERA_XO_CLK, GCC_CPUSS_GNOC_CLK, GCC_DISP_XO_CLK
 	 */
-	qcom_branch_set_clk_en(regmap, 0x17028);
-	qcom_branch_set_clk_en(regmap, 0x2b004);
-	qcom_branch_set_clk_en(regmap, 0x1702c);
-	qcom_branch_set_clk_en(regmap, 0x17008);
-	qcom_branch_set_clk_en(regmap, 0x1700c);
-	qcom_branch_set_clk_en(regmap, 0x36004);
-	qcom_branch_set_clk_en(regmap, 0x2b06c);
-	qcom_branch_set_clk_en(regmap, 0x17004);
+	regmap_update_bits(regmap, 0x17028, BIT(0), BIT(0));
+	regmap_update_bits(regmap, 0x2b004, BIT(0), BIT(0));
+	regmap_update_bits(regmap, 0x1702c, BIT(0), BIT(0));
 
 	clk_lucid_pll_configure(&gpll10, regmap, &gpll10_config);
 	clk_lucid_pll_configure(&gpll11, regmap, &gpll11_config);
diff --git a/drivers/clk/qcom/gpucc-sm6375.c b/drivers/clk/qcom/gpucc-sm6375.c
index 2d863dc3d83b..d70c6ed0440b 100644
--- a/drivers/clk/qcom/gpucc-sm6375.c
+++ b/drivers/clk/qcom/gpucc-sm6375.c
@@ -182,20 +182,6 @@ static struct clk_rcg2 gpucc_gx_gfx3d_clk_src = {
 	},
 };
 
-static struct clk_branch gpucc_ahb_clk = {
-	.halt_reg = 0x1078,
-	.halt_check = BRANCH_HALT_DELAY,
-	.clkr = {
-		.enable_reg = 0x1078,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "gpucc_ahb_clk",
-			.flags = CLK_IS_CRITICAL,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gpucc_cx_gfx3d_clk = {
 	.halt_reg = 0x10a4,
 	.halt_check = BRANCH_HALT_DELAY,
@@ -293,20 +279,6 @@ static struct clk_branch gpucc_cxo_clk = {
 	},
 };
 
-static struct clk_branch gpucc_gx_cxo_clk = {
-	.halt_reg = 0x1060,
-	.halt_check = BRANCH_HALT_DELAY,
-	.clkr = {
-		.enable_reg = 0x1060,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "gpucc_gx_cxo_clk",
-			.flags = CLK_IS_CRITICAL,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gpucc_gx_gfx3d_clk = {
 	.halt_reg = 0x1054,
 	.halt_check = BRANCH_HALT_DELAY,
@@ -380,7 +352,6 @@ static struct gdsc gpu_gx_gdsc = {
 };
 
 static struct clk_regmap *gpucc_sm6375_clocks[] = {
-	[GPU_CC_AHB_CLK] = &gpucc_ahb_clk.clkr,
 	[GPU_CC_CX_GFX3D_CLK] = &gpucc_cx_gfx3d_clk.clkr,
 	[GPU_CC_CX_GFX3D_SLV_CLK] = &gpucc_cx_gfx3d_slv_clk.clkr,
 	[GPU_CC_CX_GMU_CLK] = &gpucc_cx_gmu_clk.clkr,
@@ -388,7 +359,6 @@ static struct clk_regmap *gpucc_sm6375_clocks[] = {
 	[GPU_CC_CXO_AON_CLK] = &gpucc_cxo_aon_clk.clkr,
 	[GPU_CC_CXO_CLK] = &gpucc_cxo_clk.clkr,
 	[GPU_CC_GMU_CLK_SRC] = &gpucc_gmu_clk_src.clkr,
-	[GPU_CC_GX_CXO_CLK] = &gpucc_gx_cxo_clk.clkr,
 	[GPU_CC_GX_GFX3D_CLK] = &gpucc_gx_gfx3d_clk.clkr,
 	[GPU_CC_GX_GFX3D_CLK_SRC] = &gpucc_gx_gfx3d_clk_src.clkr,
 	[GPU_CC_GX_GMU_CLK] = &gpucc_gx_gmu_clk.clkr,
@@ -454,6 +424,14 @@ static int gpucc_sm6375_probe(struct platform_device *pdev)
 	clk_lucid_pll_configure(&gpucc_pll0, regmap, &gpucc_pll0_config);
 	clk_lucid_pll_configure(&gpucc_pll1, regmap, &gpucc_pll1_config);
 
+	/*
+	 * Keep clocks always enabled:
+	 *	gpucc_ahb_clk
+	 *	gpucc_gx_cxo_clk
+	 */
+	qcom_branch_set_clk_en(regmap, 0x1078);
+	qcom_branch_set_clk_en(regmap, 0x1060);
+
 	ret = qcom_cc_really_probe(pdev, &gpucc_sm6375_desc, regmap);
 	pm_runtime_put(&pdev->dev);
 

-- 
2.41.0

