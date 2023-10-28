Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F0E7DA6DE
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 14:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjJ1MLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 08:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJ1MLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 08:11:13 -0400
X-Greylist: delayed 159 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 28 Oct 2023 05:11:08 PDT
Received: from mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990EEF0;
        Sat, 28 Oct 2023 05:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1698495056; bh=yxb6zphCiYkg1BMNfJoJYLGbGEtFPFGmsEthVt0RmgE=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Transfer-Encoding;
        b=gzOm6C8RgfWW200kRZxvKY57EJPqrd+GoSuiec/YbssAkYVGsB/j9vctklefTdZTQ
         1YcB2PABM3jnlHrQPExEi0NN2LO+uwtCbyqgU4IzPHmHprIu2he0/DWybKjlpyhPUI
         7oOM9eNRG7YtaO6ssSRRIly49xxllis+inE2yJxU=
Received: by b221-2.in.mailobj.net [192.168.90.22] with ESMTP
        via ip-22.mailoo.org [213.182.54.22]
        Sat, 28 Oct 2023 14:10:56 +0200 (CEST)
X-EA-Auth: dugBy9wIT2iBVLJu1SI60csL07/ZUymv4lZ45nAesMiPN9y+zAvHoUPGQ5G/fRoY1CSNDg/dMYyWW09v3Yv/m2eTUwo/EGp9viYN0qfvNWQ=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Vincent Knecht <vincent.knecht@mailoo.org>
Subject: [PATCH] clk: qcom: gcc-msm8939: Add missing CSI2 related clocks
Date:   Sat, 28 Oct 2023 14:10:47 +0200
Message-ID: <20231028121047.317550-1-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding in the indexes for this clock-controller we missed
GCC_CAMSS_CSI2_AHB_CLK, GCC_CAMSS_CSI2_CLK, GCC_CAMSS_CSI2PHY_CLK,
GCC_CAMSS_CSI2PIX_CLK and GCC_CAMSS_CSI2RDI_CLK.

Add them in now.

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
No fixes tag because camss is a not-yet-enabled feature for msm8939.

Also didn't rename ftbl_gcc_camss_csi0_1_clk now that csi2 uses it
to avoid not-required-churn... should it be done anyway ?
---
 drivers/clk/qcom/gcc-msm8939.c               | 104 +++++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-msm8939.h |   6 ++
 2 files changed, 110 insertions(+)

diff --git a/drivers/clk/qcom/gcc-msm8939.c b/drivers/clk/qcom/gcc-msm8939.c
index e4a44377b75f..ad6599fffef3 100644
--- a/drivers/clk/qcom/gcc-msm8939.c
+++ b/drivers/clk/qcom/gcc-msm8939.c
@@ -728,6 +728,19 @@ static struct clk_rcg2 csi1_clk_src = {
 	},
 };
 
+static struct clk_rcg2 csi2_clk_src = {
+	.cmd_rcgr = 0x3c020,
+	.hid_width = 5,
+	.parent_map = gcc_xo_gpll0_map,
+	.freq_tbl = ftbl_gcc_camss_csi0_1_clk,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "csi2_clk_src",
+		.parent_data = gcc_xo_gpll0_parent_data,
+		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_parent_data),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
 static const struct freq_tbl ftbl_gcc_oxili_gfx3d_clk[] = {
 	F(19200000, P_XO, 1, 0, 0),
 	F(50000000, P_GPLL0, 16, 0, 0),
@@ -2385,6 +2398,91 @@ static struct clk_branch gcc_camss_csi1rdi_clk = {
 	},
 };
 
+static struct clk_branch gcc_camss_csi2_ahb_clk = {
+	.halt_reg = 0x3c040,
+	.clkr = {
+		.enable_reg = 0x3c040,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_camss_csi2_ahb_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&camss_ahb_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_csi2_clk = {
+	.halt_reg = 0x3c03c,
+	.clkr = {
+		.enable_reg = 0x3c03c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_camss_csi2_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&csi2_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_csi2phy_clk = {
+	.halt_reg = 0x3c048,
+	.clkr = {
+		.enable_reg = 0x3c048,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_camss_csi2phy_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&csi2_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_csi2pix_clk = {
+	.halt_reg = 0x3c058,
+	.clkr = {
+		.enable_reg = 0x3c058,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_camss_csi2pix_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&csi2_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camss_csi2rdi_clk = {
+	.halt_reg = 0x3c050,
+	.clkr = {
+		.enable_reg = 0x3c050,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_camss_csi2rdi_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&csi2_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_camss_csi_vfe0_clk = {
 	.halt_reg = 0x58050,
 	.clkr = {
@@ -3682,6 +3780,7 @@ static struct clk_regmap *gcc_msm8939_clocks[] = {
 	[APSS_AHB_CLK_SRC] = &apss_ahb_clk_src.clkr,
 	[CSI0_CLK_SRC] = &csi0_clk_src.clkr,
 	[CSI1_CLK_SRC] = &csi1_clk_src.clkr,
+	[CSI2_CLK_SRC] = &csi2_clk_src.clkr,
 	[GFX3D_CLK_SRC] = &gfx3d_clk_src.clkr,
 	[VFE0_CLK_SRC] = &vfe0_clk_src.clkr,
 	[BLSP1_QUP1_I2C_APPS_CLK_SRC] = &blsp1_qup1_i2c_apps_clk_src.clkr,
@@ -3751,6 +3850,11 @@ static struct clk_regmap *gcc_msm8939_clocks[] = {
 	[GCC_CAMSS_CSI1PHY_CLK] = &gcc_camss_csi1phy_clk.clkr,
 	[GCC_CAMSS_CSI1PIX_CLK] = &gcc_camss_csi1pix_clk.clkr,
 	[GCC_CAMSS_CSI1RDI_CLK] = &gcc_camss_csi1rdi_clk.clkr,
+	[GCC_CAMSS_CSI2_AHB_CLK] = &gcc_camss_csi2_ahb_clk.clkr,
+	[GCC_CAMSS_CSI2_CLK] = &gcc_camss_csi2_clk.clkr,
+	[GCC_CAMSS_CSI2PHY_CLK] = &gcc_camss_csi2phy_clk.clkr,
+	[GCC_CAMSS_CSI2PIX_CLK] = &gcc_camss_csi2pix_clk.clkr,
+	[GCC_CAMSS_CSI2RDI_CLK] = &gcc_camss_csi2rdi_clk.clkr,
 	[GCC_CAMSS_CSI_VFE0_CLK] = &gcc_camss_csi_vfe0_clk.clkr,
 	[GCC_CAMSS_GP0_CLK] = &gcc_camss_gp0_clk.clkr,
 	[GCC_CAMSS_GP1_CLK] = &gcc_camss_gp1_clk.clkr,
diff --git a/include/dt-bindings/clock/qcom,gcc-msm8939.h b/include/dt-bindings/clock/qcom,gcc-msm8939.h
index 2d545ed0d35a..9a9bc55b49af 100644
--- a/include/dt-bindings/clock/qcom,gcc-msm8939.h
+++ b/include/dt-bindings/clock/qcom,gcc-msm8939.h
@@ -193,6 +193,12 @@
 #define GCC_VENUS0_CORE1_VCODEC0_CLK		184
 #define GCC_OXILI_TIMER_CLK			185
 #define SYSTEM_MM_NOC_BFDCD_CLK_SRC		186
+#define CSI2_CLK_SRC				187
+#define GCC_CAMSS_CSI2_AHB_CLK			188
+#define GCC_CAMSS_CSI2_CLK			189
+#define GCC_CAMSS_CSI2PHY_CLK			190
+#define GCC_CAMSS_CSI2PIX_CLK			191
+#define GCC_CAMSS_CSI2RDI_CLK			192
 
 /* Indexes for GDSCs */
 #define BIMC_GDSC				0
-- 
2.41.0



