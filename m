Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24557DAB2D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 07:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjJ2GUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 02:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ2GUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 02:20:36 -0400
Received: from mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04982D6;
        Sat, 28 Oct 2023 23:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1698560418; bh=qkH0hoxix0W1srCfxT3o6bMfHO+j7quxmIDTZEAOTLM=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=P+F4rsue55ve3yP71nL/K9TkBblBVjp4lTbL2EWIRQe38pryyYPppz9FnTs7M0tlj
         0lGK/1UuOYsvF5dVcteeOFHirN+z077Aa4/O17bMiiu8dLjLTPdwR5OoZ+4UIMM2i4
         DygHe90/YiNTlAXecp1KrvJTTeIOBjuVdow2BCI8=
Received: by b221-4.in.mailobj.net [192.168.90.24] with ESMTP
        via ip-22.mailoo.org [213.182.54.22]
        Sun, 29 Oct 2023 07:20:18 +0100 (CET)
X-EA-Auth: NMyIht0Q8IYjkH4jdyANC7mMHTrWBYHyJn7HHRXd4kJjO4Joig9hcY0T7c7ojr7YcfBM12+AB1fYEcMFnbuhm4d8kxwVkT+zWXysMdLjSU0=
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
Cc:     Vincent Knecht <vincent.knecht@mailoo.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v2 2/2] clk: qcom: gcc-msm8939: Add missing CSI2 related clocks
Date:   Sun, 29 Oct 2023 07:19:48 +0100
Message-ID: <20231029061948.505883-2-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231029061948.505883-1-vincent.knecht@mailoo.org>
References: <20231029061948.505883-1-vincent.knecht@mailoo.org>
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

Add them in now and rename ftbl_gcc_camss_csi0_1_clk
to account for csi2 also using it.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
v2:
- renamed ftbl_gcc_camss_csi0_1_clk to reflect the change (Konrad, Bryan)
- split bindings change to a distinct patch (Krzysztof)
v1: https://lore.kernel.org/linux-arm-msm/e44c751a-f0f5-42d8-aa99-743b349fdf9b@linaro.org/T/
---
 drivers/clk/qcom/gcc-msm8939.c | 110 ++++++++++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/gcc-msm8939.c b/drivers/clk/qcom/gcc-msm8939.c
index e4a44377b75f..70113b322834 100644
--- a/drivers/clk/qcom/gcc-msm8939.c
+++ b/drivers/clk/qcom/gcc-msm8939.c
@@ -696,7 +696,7 @@ static struct clk_rcg2 apss_ahb_clk_src = {
 	},
 };
 
-static const struct freq_tbl ftbl_gcc_camss_csi0_1_clk[] = {
+static const struct freq_tbl ftbl_gcc_camss_csi0_1_2_clk[] = {
 	F(100000000, P_GPLL0, 8, 0,	0),
 	F(200000000, P_GPLL0, 4, 0,	0),
 	{ }
@@ -706,7 +706,7 @@ static struct clk_rcg2 csi0_clk_src = {
 	.cmd_rcgr = 0x4e020,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_map,
-	.freq_tbl = ftbl_gcc_camss_csi0_1_clk,
+	.freq_tbl = ftbl_gcc_camss_csi0_1_2_clk,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "csi0_clk_src",
 		.parent_data = gcc_xo_gpll0_parent_data,
@@ -719,7 +719,7 @@ static struct clk_rcg2 csi1_clk_src = {
 	.cmd_rcgr = 0x4f020,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_map,
-	.freq_tbl = ftbl_gcc_camss_csi0_1_clk,
+	.freq_tbl = ftbl_gcc_camss_csi0_1_2_clk,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "csi1_clk_src",
 		.parent_data = gcc_xo_gpll0_parent_data,
@@ -728,6 +728,19 @@ static struct clk_rcg2 csi1_clk_src = {
 	},
 };
 
+static struct clk_rcg2 csi2_clk_src = {
+	.cmd_rcgr = 0x3c020,
+	.hid_width = 5,
+	.parent_map = gcc_xo_gpll0_map,
+	.freq_tbl = ftbl_gcc_camss_csi0_1_2_clk,
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
-- 
2.41.0



