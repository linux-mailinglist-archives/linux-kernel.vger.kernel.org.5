Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C463F7F58A1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 07:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbjKWGtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 01:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbjKWGsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 01:48:52 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDC110D3;
        Wed, 22 Nov 2023 22:48:48 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AN65cke014164;
        Thu, 23 Nov 2023 06:48:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=UEDQP3Prvx8S0b0yfONQc3Kx5v24UiGVtZLEOHHme0g=;
 b=niyL6N/MuuhSYiV8Rck5cmdJXJ4f78qOMrj8fLxkWblzMLO+SjX/8HEJipd0YtKQYM28
 kNuS+iUJP1S7HyjIuxdLsOVGcYE8dLX0ldvYJgjkxlxG3biWljvR9UgL0ylFcXHjZwVO
 GpDGHXXmSYoO/ux88tl8Dmj6zcMYCw8BzG7KL6yJ+ekAS1SFo18rAh51PtBKqMD/RPlN
 p9XUGRxbkNoypWOudg6CGTxhJHKgUOlIBiNc8ULIAJgxfbBGI9Sq+Mw+mtOPV0tnp2vu
 50TTzBwac7nqJAMX6drHooNYYFVQNxIzolMmXZSfdIMMuhurwvcdNUFCB+JNApyWiSLt 8A== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uh8mwbh4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 06:48:36 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AN6maYC025194
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 06:48:36 GMT
Received: from hu-imrashai-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 22 Nov 2023 22:48:30 -0800
From:   Imran Shaik <quic_imrashai@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Taniya Das <quic_tdas@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, Ajit Pandey <quic_ajipan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
Subject: [PATCH V5 3/4] clk: qcom: Add ECPRICC driver support for QDU1000 and QRU1000
Date:   Thu, 23 Nov 2023 12:17:34 +0530
Message-ID: <20231123064735.2979802-4-quic_imrashai@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231123064735.2979802-1-quic_imrashai@quicinc.com>
References: <20231123064735.2979802-1-quic_imrashai@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WpD1s9Nf23SmtfR3QIqBhAxaYYaMu7Pk
X-Proofpoint-ORIG-GUID: WpD1s9Nf23SmtfR3QIqBhAxaYYaMu7Pk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_03,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 mlxlogscore=917
 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311230046
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ECPRI Clock Controller (ECPRICC) support for QDU1000 and QRU1000 SoCs.

Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/Kconfig           |    9 +
 drivers/clk/qcom/Makefile          |    1 +
 drivers/clk/qcom/ecpricc-qdu1000.c | 2456 ++++++++++++++++++++++++++++
 3 files changed, 2466 insertions(+)
 create mode 100644 drivers/clk/qcom/ecpricc-qdu1000.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index ad1acd9b7426..9e54afc67519 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -668,6 +668,15 @@ config QDU_GCC_1000
 	  QRU1000 devices. Say Y if you want to use peripheral
 	  devices such as UART, SPI, I2C, USB, SD, PCIe, etc.
 
+config QDU_ECPRICC_1000
+	tristate "QDU1000/QRU1000 ECPRI Clock Controller"
+	depends on ARM64 || COMPILE_TEST
+	select QDU_GCC_1000
+	help
+	  Support for the ECPRI clock controller on QDU1000 and
+	  QRU1000 devices. Say Y if you want to support the ECPRI
+	  clock controller functionality such as Ethernet.
+
 config SDM_GCC_845
 	tristate "SDM845/SDM670 Global Clock Controller"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 17edd73f9839..607ed0fabf36 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -65,6 +65,7 @@ obj-$(CONFIG_QCM_DISPCC_2290) += dispcc-qcm2290.o
 obj-$(CONFIG_QCS_GCC_404) += gcc-qcs404.o
 obj-$(CONFIG_QCS_Q6SSTOP_404) += q6sstop-qcs404.o
 obj-$(CONFIG_QCS_TURING_404) += turingcc-qcs404.o
+obj-$(CONFIG_QDU_ECPRICC_1000) += ecpricc-qdu1000.o
 obj-$(CONFIG_QDU_GCC_1000) += gcc-qdu1000.o
 obj-$(CONFIG_SC_CAMCC_7180) += camcc-sc7180.o
 obj-$(CONFIG_SC_CAMCC_7280) += camcc-sc7280.o
diff --git a/drivers/clk/qcom/ecpricc-qdu1000.c b/drivers/clk/qcom/ecpricc-qdu1000.c
new file mode 100644
index 000000000000..c628054a7025
--- /dev/null
+++ b/drivers/clk/qcom/ecpricc-qdu1000.c
@@ -0,0 +1,2456 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/clock/qcom,qdu1000-ecpricc.h>
+
+#include "clk-alpha-pll.h"
+#include "clk-branch.h"
+#include "clk-rcg.h"
+#include "clk-regmap.h"
+#include "clk-regmap-divider.h"
+#include "clk-regmap-mux.h"
+#include "common.h"
+#include "reset.h"
+
+enum {
+	DT_BI_TCXO,
+	DT_GCC_ECPRI_CC_GPLL0_OUT_MAIN,
+	DT_GCC_ECPRI_CC_GPLL1_OUT_EVEN,
+	DT_GCC_ECPRI_CC_GPLL2_OUT_MAIN,
+	DT_GCC_ECPRI_CC_GPLL3_OUT_MAIN,
+	DT_GCC_ECPRI_CC_GPLL4_OUT_MAIN,
+	DT_GCC_ECPRI_CC_GPLL5_OUT_EVEN,
+};
+
+enum {
+	P_BI_TCXO,
+	P_ECPRI_CC_PLL0_OUT_MAIN,
+	P_ECPRI_CC_PLL1_OUT_MAIN,
+	P_GCC_ECPRI_CC_GPLL0_OUT_MAIN,
+	P_GCC_ECPRI_CC_GPLL1_OUT_EVEN,
+	P_GCC_ECPRI_CC_GPLL2_OUT_MAIN,
+	P_GCC_ECPRI_CC_GPLL3_OUT_MAIN,
+	P_GCC_ECPRI_CC_GPLL4_OUT_MAIN,
+	P_GCC_ECPRI_CC_GPLL5_OUT_EVEN,
+};
+
+static const struct pll_vco lucid_evo_vco[] = {
+	{ 249600000, 2020000000, 0 },
+};
+
+/* 700 MHz configuration */
+static const struct alpha_pll_config ecpri_cc_pll0_config = {
+	.l = 0x24,
+	.alpha = 0x7555,
+	.config_ctl_val = 0x20485699,
+	.config_ctl_hi_val = 0x00182261,
+	.config_ctl_hi1_val = 0x32aa299c,
+	.user_ctl_val = 0x00000000,
+	.user_ctl_hi_val = 0x00000805,
+};
+
+static struct clk_alpha_pll ecpri_cc_pll0 = {
+	.offset = 0x0,
+	.vco_table = lucid_evo_vco,
+	.num_vco = ARRAY_SIZE(lucid_evo_vco),
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_EVO],
+	.clkr = {
+		.enable_reg = 0x0,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_pll0",
+			.parent_data = &(const struct clk_parent_data) {
+				.index = DT_BI_TCXO,
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fixed_lucid_evo_ops,
+		},
+	},
+};
+
+/* 806 MHz configuration */
+static const struct alpha_pll_config ecpri_cc_pll1_config = {
+	.l = 0x29,
+	.alpha = 0xfaaa,
+	.config_ctl_val = 0x20485699,
+	.config_ctl_hi_val = 0x00182261,
+	.config_ctl_hi1_val = 0x32aa299c,
+	.user_ctl_val = 0x00000000,
+	.user_ctl_hi_val = 0x00000805,
+};
+
+static struct clk_alpha_pll ecpri_cc_pll1 = {
+	.offset = 0x1000,
+	.vco_table = lucid_evo_vco,
+	.num_vco = ARRAY_SIZE(lucid_evo_vco),
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_EVO],
+	.clkr = {
+		.enable_reg = 0x0,
+		.enable_mask = BIT(1),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_pll1",
+			.parent_data = &(const struct clk_parent_data) {
+				.index = DT_BI_TCXO,
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fixed_lucid_evo_ops,
+		},
+	},
+};
+
+static const struct parent_map ecpri_cc_parent_map_0[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_GCC_ECPRI_CC_GPLL0_OUT_MAIN, 1 },
+	{ P_GCC_ECPRI_CC_GPLL2_OUT_MAIN, 2 },
+	{ P_GCC_ECPRI_CC_GPLL5_OUT_EVEN, 3 },
+	{ P_ECPRI_CC_PLL1_OUT_MAIN, 4 },
+	{ P_GCC_ECPRI_CC_GPLL4_OUT_MAIN, 5 },
+	{ P_ECPRI_CC_PLL0_OUT_MAIN, 6 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_0[] = {
+	{ .index = DT_BI_TCXO },
+	{ .index = DT_GCC_ECPRI_CC_GPLL0_OUT_MAIN },
+	{ .index = DT_GCC_ECPRI_CC_GPLL2_OUT_MAIN },
+	{ .index = DT_GCC_ECPRI_CC_GPLL5_OUT_EVEN },
+	{ .hw = &ecpri_cc_pll1.clkr.hw },
+	{ .index = DT_GCC_ECPRI_CC_GPLL4_OUT_MAIN },
+	{ .hw = &ecpri_cc_pll0.clkr.hw },
+};
+
+static const struct parent_map ecpri_cc_parent_map_1[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_GCC_ECPRI_CC_GPLL0_OUT_MAIN, 1 },
+	{ P_GCC_ECPRI_CC_GPLL1_OUT_EVEN, 2 },
+	{ P_GCC_ECPRI_CC_GPLL3_OUT_MAIN, 3 },
+	{ P_ECPRI_CC_PLL1_OUT_MAIN, 4 },
+	{ P_GCC_ECPRI_CC_GPLL4_OUT_MAIN, 5 },
+	{ P_ECPRI_CC_PLL0_OUT_MAIN, 6 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_1[] = {
+	{ .index = DT_BI_TCXO },
+	{ .index = DT_GCC_ECPRI_CC_GPLL0_OUT_MAIN },
+	{ .index = DT_GCC_ECPRI_CC_GPLL1_OUT_EVEN },
+	{ .index = DT_GCC_ECPRI_CC_GPLL3_OUT_MAIN },
+	{ .hw = &ecpri_cc_pll1.clkr.hw },
+	{ .index = DT_GCC_ECPRI_CC_GPLL4_OUT_MAIN },
+	{ .hw = &ecpri_cc_pll0.clkr.hw },
+};
+
+static const struct parent_map ecpri_cc_parent_map_2[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_GCC_ECPRI_CC_GPLL0_OUT_MAIN, 1 },
+	{ P_GCC_ECPRI_CC_GPLL5_OUT_EVEN, 3 },
+	{ P_ECPRI_CC_PLL1_OUT_MAIN, 4 },
+	{ P_GCC_ECPRI_CC_GPLL4_OUT_MAIN, 5 },
+	{ P_ECPRI_CC_PLL0_OUT_MAIN, 6 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_2[] = {
+	{ .index = DT_BI_TCXO },
+	{ .index = DT_GCC_ECPRI_CC_GPLL0_OUT_MAIN },
+	{ .index = DT_GCC_ECPRI_CC_GPLL5_OUT_EVEN },
+	{ .hw = &ecpri_cc_pll1.clkr.hw },
+	{ .index = DT_GCC_ECPRI_CC_GPLL4_OUT_MAIN },
+	{ .hw = &ecpri_cc_pll0.clkr.hw },
+};
+
+static const struct freq_tbl ftbl_ecpri_cc_ecpri_clk_src[] = {
+	F(466500000, P_GCC_ECPRI_CC_GPLL5_OUT_EVEN, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 ecpri_cc_ecpri_clk_src = {
+	.cmd_rcgr = 0x9034,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = ecpri_cc_parent_map_2,
+	.freq_tbl = ftbl_ecpri_cc_ecpri_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "ecpri_cc_ecpri_clk_src",
+		.parent_data = ecpri_cc_parent_data_2,
+		.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_2),
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_ecpri_cc_ecpri_dma_clk_src[] = {
+	F(466500000, P_GCC_ECPRI_CC_GPLL5_OUT_EVEN, 1, 0, 0),
+	F(500000000, P_GCC_ECPRI_CC_GPLL2_OUT_MAIN, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 ecpri_cc_ecpri_dma_clk_src = {
+	.cmd_rcgr = 0x9080,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = ecpri_cc_parent_map_0,
+	.freq_tbl = ftbl_ecpri_cc_ecpri_dma_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "ecpri_cc_ecpri_dma_clk_src",
+		.parent_data = ecpri_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_0),
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_ecpri_cc_ecpri_fast_clk_src[] = {
+	F(500000000, P_GCC_ECPRI_CC_GPLL2_OUT_MAIN, 1, 0, 0),
+	F(600000000, P_GCC_ECPRI_CC_GPLL0_OUT_MAIN, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 ecpri_cc_ecpri_fast_clk_src = {
+	.cmd_rcgr = 0x904c,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = ecpri_cc_parent_map_0,
+	.freq_tbl = ftbl_ecpri_cc_ecpri_fast_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "ecpri_cc_ecpri_fast_clk_src",
+		.parent_data = ecpri_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_0),
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_ecpri_cc_ecpri_oran_clk_src[] = {
+	F(500000000, P_GCC_ECPRI_CC_GPLL2_OUT_MAIN, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 ecpri_cc_ecpri_oran_clk_src = {
+	.cmd_rcgr = 0x9064,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = ecpri_cc_parent_map_0,
+	.freq_tbl = ftbl_ecpri_cc_ecpri_oran_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "ecpri_cc_ecpri_oran_clk_src",
+		.parent_data = ecpri_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_0),
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_ecpri_cc_eth_100g_c2c0_hm_ff_clk_src[] = {
+	F(201500000, P_ECPRI_CC_PLL1_OUT_MAIN, 4, 0, 0),
+	F(403000000, P_ECPRI_CC_PLL1_OUT_MAIN, 2, 0, 0),
+	F(466500000, P_GCC_ECPRI_CC_GPLL5_OUT_EVEN, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 ecpri_cc_eth_100g_c2c0_hm_ff_clk_src = {
+	.cmd_rcgr = 0x81b0,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = ecpri_cc_parent_map_0,
+	.freq_tbl = ftbl_ecpri_cc_eth_100g_c2c0_hm_ff_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "ecpri_cc_eth_100g_c2c0_hm_ff_clk_src",
+		.parent_data = ecpri_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_0),
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_ecpri_cc_eth_100g_c2c_hm_macsec_clk_src[] = {
+	F(100000000, P_GCC_ECPRI_CC_GPLL0_OUT_MAIN, 6, 0, 0),
+	F(200000000, P_GCC_ECPRI_CC_GPLL0_OUT_MAIN, 3, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 ecpri_cc_eth_100g_c2c_hm_macsec_clk_src = {
+	.cmd_rcgr = 0x8150,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = ecpri_cc_parent_map_0,
+	.freq_tbl = ftbl_ecpri_cc_eth_100g_c2c_hm_macsec_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "ecpri_cc_eth_100g_c2c_hm_macsec_clk_src",
+		.parent_data = ecpri_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_0),
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static struct clk_rcg2 ecpri_cc_eth_100g_dbg_c2c_hm_ff_clk_src = {
+	.cmd_rcgr = 0x81c8,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = ecpri_cc_parent_map_0,
+	.freq_tbl = ftbl_ecpri_cc_eth_100g_c2c0_hm_ff_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "ecpri_cc_eth_100g_dbg_c2c_hm_ff_clk_src",
+		.parent_data = ecpri_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_0),
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static struct clk_rcg2 ecpri_cc_eth_100g_fh0_hm_ff_clk_src = {
+	.cmd_rcgr = 0x8168,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = ecpri_cc_parent_map_0,
+	.freq_tbl = ftbl_ecpri_cc_eth_100g_c2c0_hm_ff_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "ecpri_cc_eth_100g_fh0_hm_ff_clk_src",
+		.parent_data = ecpri_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_0),
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static struct clk_rcg2 ecpri_cc_eth_100g_fh0_macsec_clk_src = {
+	.cmd_rcgr = 0x8108,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = ecpri_cc_parent_map_0,
+	.freq_tbl = ftbl_ecpri_cc_eth_100g_c2c_hm_macsec_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "ecpri_cc_eth_100g_fh0_macsec_clk_src",
+		.parent_data = ecpri_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_0),
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static struct clk_rcg2 ecpri_cc_eth_100g_fh1_hm_ff_clk_src = {
+	.cmd_rcgr = 0x8180,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = ecpri_cc_parent_map_0,
+	.freq_tbl = ftbl_ecpri_cc_ecpri_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "ecpri_cc_eth_100g_fh1_hm_ff_clk_src",
+		.parent_data = ecpri_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_0),
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_ecpri_cc_eth_100g_fh1_macsec_clk_src[] = {
+	F(200000000, P_GCC_ECPRI_CC_GPLL0_OUT_MAIN, 3, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 ecpri_cc_eth_100g_fh1_macsec_clk_src = {
+	.cmd_rcgr = 0x8120,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = ecpri_cc_parent_map_0,
+	.freq_tbl = ftbl_ecpri_cc_eth_100g_fh1_macsec_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "ecpri_cc_eth_100g_fh1_macsec_clk_src",
+		.parent_data = ecpri_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_0),
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static struct clk_rcg2 ecpri_cc_eth_100g_fh2_hm_ff_clk_src = {
+	.cmd_rcgr = 0x8198,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = ecpri_cc_parent_map_0,
+	.freq_tbl = ftbl_ecpri_cc_eth_100g_c2c0_hm_ff_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "ecpri_cc_eth_100g_fh2_hm_ff_clk_src",
+		.parent_data = ecpri_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_0),
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static struct clk_rcg2 ecpri_cc_eth_100g_fh2_macsec_clk_src = {
+	.cmd_rcgr = 0x8138,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = ecpri_cc_parent_map_0,
+	.freq_tbl = ftbl_ecpri_cc_eth_100g_fh1_macsec_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "ecpri_cc_eth_100g_fh2_macsec_clk_src",
+		.parent_data = ecpri_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_0),
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_ecpri_cc_eth_100g_mac_c2c_hm_ref_clk_src[] = {
+	F(533000000, P_GCC_ECPRI_CC_GPLL1_OUT_EVEN, 1, 0, 0),
+	F(700000000, P_GCC_ECPRI_CC_GPLL3_OUT_MAIN, 1, 0, 0),
+	F(806000000, P_GCC_ECPRI_CC_GPLL4_OUT_MAIN, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 ecpri_cc_eth_100g_mac_c2c_hm_ref_clk_src = {
+	.cmd_rcgr = 0x8228,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = ecpri_cc_parent_map_1,
+	.freq_tbl = ftbl_ecpri_cc_eth_100g_mac_c2c_hm_ref_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "ecpri_cc_eth_100g_mac_c2c_hm_ref_clk_src",
+		.parent_data = ecpri_cc_parent_data_1,
+		.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_1),
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static struct clk_rcg2 ecpri_cc_eth_100g_mac_dbg_c2c_hm_ref_clk_src = {
+	.cmd_rcgr = 0x8240,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = ecpri_cc_parent_map_1,
+	.freq_tbl = ftbl_ecpri_cc_eth_100g_mac_c2c_hm_ref_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "ecpri_cc_eth_100g_mac_dbg_c2c_hm_ref_clk_src",
+		.parent_data = ecpri_cc_parent_data_1,
+		.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_1),
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static struct clk_rcg2 ecpri_cc_eth_100g_mac_fh0_hm_ref_clk_src = {
+	.cmd_rcgr = 0x81e0,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = ecpri_cc_parent_map_1,
+	.freq_tbl = ftbl_ecpri_cc_eth_100g_mac_c2c_hm_ref_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "ecpri_cc_eth_100g_mac_fh0_hm_ref_clk_src",
+		.parent_data = ecpri_cc_parent_data_1,
+		.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_1),
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static struct clk_rcg2 ecpri_cc_eth_100g_mac_fh1_hm_ref_clk_src = {
+	.cmd_rcgr = 0x81f8,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = ecpri_cc_parent_map_1,
+	.freq_tbl = ftbl_ecpri_cc_eth_100g_mac_c2c_hm_ref_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "ecpri_cc_eth_100g_mac_fh1_hm_ref_clk_src",
+		.parent_data = ecpri_cc_parent_data_1,
+		.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_1),
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static struct clk_rcg2 ecpri_cc_eth_100g_mac_fh2_hm_ref_clk_src = {
+	.cmd_rcgr = 0x8210,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = ecpri_cc_parent_map_1,
+	.freq_tbl = ftbl_ecpri_cc_eth_100g_mac_c2c_hm_ref_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "ecpri_cc_eth_100g_mac_fh2_hm_ref_clk_src",
+		.parent_data = ecpri_cc_parent_data_1,
+		.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_1),
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_ecpri_cc_mss_emac_clk_src[] = {
+	F(403000000, P_GCC_ECPRI_CC_GPLL4_OUT_MAIN, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 ecpri_cc_mss_emac_clk_src = {
+	.cmd_rcgr = 0xe00c,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = ecpri_cc_parent_map_2,
+	.freq_tbl = ftbl_ecpri_cc_mss_emac_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "ecpri_cc_mss_emac_clk_src",
+		.parent_data = ecpri_cc_parent_data_2,
+		.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_2),
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static struct clk_regmap_div ecpri_cc_ecpri_fast_div2_clk_src = {
+	.reg = 0x907c,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "ecpri_cc_ecpri_fast_div2_clk_src",
+		.parent_hws = (const struct clk_hw*[]) {
+			&ecpri_cc_ecpri_fast_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ro_ops,
+	},
+};
+
+static struct clk_regmap_div ecpri_cc_eth_100g_c2c_hm_ff_0_div_clk_src = {
+	.reg = 0x8290,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "ecpri_cc_eth_100g_c2c_hm_ff_0_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]) {
+			&ecpri_cc_eth_100g_c2c0_hm_ff_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ro_ops,
+	},
+};
+
+static struct clk_regmap_div ecpri_cc_eth_100g_c2c_hm_ff_1_div_clk_src = {
+	.reg = 0x8294,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "ecpri_cc_eth_100g_c2c_hm_ff_1_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]) {
+			&ecpri_cc_eth_100g_c2c0_hm_ff_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ro_ops,
+	},
+};
+
+static struct clk_regmap_div ecpri_cc_eth_100g_dbg_c2c_hm_ff_0_div_clk_src = {
+	.reg = 0x8298,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "ecpri_cc_eth_100g_dbg_c2c_hm_ff_0_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]) {
+			&ecpri_cc_eth_100g_dbg_c2c_hm_ff_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ro_ops,
+	},
+};
+
+static struct clk_regmap_div ecpri_cc_eth_100g_dbg_c2c_hm_ff_1_div_clk_src = {
+	.reg = 0x829c,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "ecpri_cc_eth_100g_dbg_c2c_hm_ff_1_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]) {
+			&ecpri_cc_eth_100g_dbg_c2c_hm_ff_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ro_ops,
+	},
+};
+
+static struct clk_regmap_div ecpri_cc_eth_100g_fh_0_hm_ff_0_div_clk_src = {
+	.reg = 0x8260,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "ecpri_cc_eth_100g_fh_0_hm_ff_0_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]) {
+			&ecpri_cc_eth_100g_fh0_hm_ff_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ro_ops,
+	},
+};
+
+static struct clk_regmap_div ecpri_cc_eth_100g_fh_0_hm_ff_1_div_clk_src = {
+	.reg = 0x8264,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "ecpri_cc_eth_100g_fh_0_hm_ff_1_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]) {
+			&ecpri_cc_eth_100g_fh0_hm_ff_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ro_ops,
+	},
+};
+
+static struct clk_regmap_div ecpri_cc_eth_100g_fh_0_hm_ff_2_div_clk_src = {
+	.reg = 0x8268,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "ecpri_cc_eth_100g_fh_0_hm_ff_2_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]) {
+			&ecpri_cc_eth_100g_fh0_hm_ff_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ro_ops,
+	},
+};
+
+static struct clk_regmap_div ecpri_cc_eth_100g_fh_0_hm_ff_3_div_clk_src = {
+	.reg = 0x826c,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "ecpri_cc_eth_100g_fh_0_hm_ff_3_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]) {
+			&ecpri_cc_eth_100g_fh0_hm_ff_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ro_ops,
+	},
+};
+
+static struct clk_regmap_div ecpri_cc_eth_100g_fh_1_hm_ff_0_div_clk_src = {
+	.reg = 0x8270,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "ecpri_cc_eth_100g_fh_1_hm_ff_0_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]) {
+			&ecpri_cc_eth_100g_fh1_hm_ff_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ro_ops,
+	},
+};
+
+static struct clk_regmap_div ecpri_cc_eth_100g_fh_1_hm_ff_1_div_clk_src = {
+	.reg = 0x8274,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "ecpri_cc_eth_100g_fh_1_hm_ff_1_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]) {
+			&ecpri_cc_eth_100g_fh1_hm_ff_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ro_ops,
+	},
+};
+
+static struct clk_regmap_div ecpri_cc_eth_100g_fh_1_hm_ff_2_div_clk_src = {
+	.reg = 0x8278,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "ecpri_cc_eth_100g_fh_1_hm_ff_2_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]) {
+			&ecpri_cc_eth_100g_fh1_hm_ff_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ro_ops,
+	},
+};
+
+static struct clk_regmap_div ecpri_cc_eth_100g_fh_1_hm_ff_3_div_clk_src = {
+	.reg = 0x827c,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "ecpri_cc_eth_100g_fh_1_hm_ff_3_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]) {
+			&ecpri_cc_eth_100g_fh1_hm_ff_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ro_ops,
+	},
+};
+
+static struct clk_regmap_div ecpri_cc_eth_100g_fh_2_hm_ff_0_div_clk_src = {
+	.reg = 0x8280,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "ecpri_cc_eth_100g_fh_2_hm_ff_0_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]) {
+			&ecpri_cc_eth_100g_fh2_hm_ff_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ro_ops,
+	},
+};
+
+static struct clk_regmap_div ecpri_cc_eth_100g_fh_2_hm_ff_1_div_clk_src = {
+	.reg = 0x8284,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "ecpri_cc_eth_100g_fh_2_hm_ff_1_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]) {
+			&ecpri_cc_eth_100g_fh2_hm_ff_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ro_ops,
+	},
+};
+
+static struct clk_regmap_div ecpri_cc_eth_100g_fh_2_hm_ff_2_div_clk_src = {
+	.reg = 0x8288,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "ecpri_cc_eth_100g_fh_2_hm_ff_2_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]) {
+			&ecpri_cc_eth_100g_fh2_hm_ff_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ro_ops,
+	},
+};
+
+static struct clk_regmap_div ecpri_cc_eth_100g_fh_2_hm_ff_3_div_clk_src = {
+	.reg = 0x828c,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "ecpri_cc_eth_100g_fh_2_hm_ff_3_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]) {
+			&ecpri_cc_eth_100g_fh2_hm_ff_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ro_ops,
+	},
+};
+
+static struct clk_branch ecpri_cc_ecpri_cg_clk = {
+	.halt_reg = 0x900c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x900c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_ecpri_cg_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_ecpri_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_ecpri_dma_clk = {
+	.halt_reg = 0x902c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x902c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_ecpri_dma_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_ecpri_dma_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_ecpri_dma_noc_clk = {
+	.halt_reg = 0xf004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xf004,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_ecpri_dma_noc_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_ecpri_dma_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_ecpri_fast_clk = {
+	.halt_reg = 0x9014,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x9014,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_ecpri_fast_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_ecpri_fast_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_ecpri_fast_div2_clk = {
+	.halt_reg = 0x901c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x901c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_ecpri_fast_div2_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_ecpri_fast_div2_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_ecpri_fast_div2_noc_clk = {
+	.halt_reg = 0xf008,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xf008,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_ecpri_fast_div2_noc_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_ecpri_fast_div2_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_ecpri_fr_clk = {
+	.halt_reg = 0x9004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x9004,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_ecpri_fr_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_ecpri_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_ecpri_oran_div2_clk = {
+	.halt_reg = 0x9024,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x9024,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_ecpri_oran_div2_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_ecpri_oran_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_eth_100g_c2c0_udp_fifo_clk = {
+	.halt_reg = 0x80cc,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x80cc,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_100g_c2c0_udp_fifo_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_ecpri_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_eth_100g_c2c1_udp_fifo_clk = {
+	.halt_reg = 0x80d0,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x80d0,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_100g_c2c1_udp_fifo_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_ecpri_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_mem_branch ecpri_cc_eth_100g_c2c_0_hm_ff_0_clk = {
+	.mem_enable_reg = 0x8410,
+	.mem_ack_reg = 0x8424,
+	.mem_enable_ack_mask = BIT(0),
+	.branch = {
+		.halt_reg = 0x80b4,
+		.halt_check = BRANCH_HALT,
+		.clkr = {
+			.enable_reg = 0x80b4,
+			.enable_mask = BIT(0),
+			.hw.init = &(const struct clk_init_data) {
+				.name = "ecpri_cc_eth_100g_c2c_0_hm_ff_0_clk",
+				.parent_hws = (const struct clk_hw*[]) {
+					&ecpri_cc_eth_100g_c2c_hm_ff_0_div_clk_src.clkr.hw,
+				},
+				.num_parents = 1,
+				.flags = CLK_SET_RATE_PARENT,
+				.ops = &clk_branch2_mem_ops,
+			},
+		},
+	},
+};
+
+static struct clk_mem_branch ecpri_cc_eth_100g_c2c_0_hm_ff_1_clk = {
+	.mem_enable_reg = 0x8410,
+	.mem_ack_reg = 0x8424,
+	.mem_enable_ack_mask = BIT(1),
+	.branch = {
+		.halt_reg = 0x80bc,
+		.halt_check = BRANCH_HALT,
+		.clkr = {
+			.enable_reg = 0x80bc,
+			.enable_mask = BIT(0),
+			.hw.init = &(const struct clk_init_data) {
+				.name = "ecpri_cc_eth_100g_c2c_0_hm_ff_1_clk",
+				.parent_hws = (const struct clk_hw*[]) {
+					&ecpri_cc_eth_100g_c2c_hm_ff_1_div_clk_src.clkr.hw,
+				},
+				.num_parents = 1,
+				.flags = CLK_SET_RATE_PARENT,
+				.ops = &clk_branch2_mem_ops,
+			},
+		},
+	},
+};
+
+static struct clk_mem_branch ecpri_cc_eth_100g_c2c_hm_macsec_clk = {
+	.mem_enable_reg = 0x8410,
+	.mem_ack_reg = 0x8424,
+	.mem_enable_ack_mask = BIT(4),
+	.branch = {
+		.halt_reg = 0x80ac,
+		.halt_check = BRANCH_HALT,
+		.clkr = {
+			.enable_reg = 0x80ac,
+			.enable_mask = BIT(0),
+			.hw.init = &(const struct clk_init_data) {
+				.name = "ecpri_cc_eth_100g_c2c_hm_macsec_clk",
+				.parent_hws = (const struct clk_hw*[]) {
+					&ecpri_cc_eth_100g_c2c_hm_macsec_clk_src.clkr.hw,
+				},
+				.num_parents = 1,
+				.flags = CLK_SET_RATE_PARENT,
+				.ops = &clk_branch2_mem_ops,
+			},
+		},
+	},
+};
+
+static struct clk_mem_branch ecpri_cc_eth_100g_dbg_c2c_hm_ff_0_clk = {
+	.mem_enable_reg = 0x8414,
+	.mem_ack_reg = 0x8428,
+	.mem_enable_ack_mask = BIT(0),
+	.branch = {
+		.halt_reg = 0x80d8,
+		.halt_check = BRANCH_HALT,
+		.clkr = {
+			.enable_reg = 0x80d8,
+			.enable_mask = BIT(0),
+			.hw.init = &(const struct clk_init_data) {
+				.name = "ecpri_cc_eth_100g_dbg_c2c_hm_ff_0_clk",
+				.parent_hws = (const struct clk_hw*[]) {
+					&ecpri_cc_eth_100g_dbg_c2c_hm_ff_0_div_clk_src.clkr.hw,
+				},
+				.num_parents = 1,
+				.flags = CLK_SET_RATE_PARENT,
+				.ops = &clk_branch2_mem_ops,
+			},
+		},
+	},
+};
+
+static struct clk_mem_branch ecpri_cc_eth_100g_dbg_c2c_hm_ff_1_clk = {
+	.mem_enable_reg = 0x8414,
+	.mem_ack_reg = 0x8428,
+	.mem_enable_ack_mask = BIT(1),
+	.branch = {
+		.halt_reg = 0x80e0,
+		.halt_check = BRANCH_HALT,
+		.clkr = {
+			.enable_reg = 0x80e0,
+			.enable_mask = BIT(0),
+			.hw.init = &(const struct clk_init_data) {
+				.name = "ecpri_cc_eth_100g_dbg_c2c_hm_ff_1_clk",
+				.parent_hws = (const struct clk_hw*[]) {
+					&ecpri_cc_eth_100g_dbg_c2c_hm_ff_1_div_clk_src.clkr.hw,
+				},
+				.num_parents = 1,
+				.flags = CLK_SET_RATE_PARENT,
+				.ops = &clk_branch2_mem_ops,
+			},
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_eth_100g_dbg_c2c_udp_fifo_clk = {
+	.halt_reg = 0x80f0,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x80f0,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_100g_dbg_c2c_udp_fifo_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_ecpri_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_mem_branch ecpri_cc_eth_100g_fh_0_hm_ff_0_clk = {
+	.mem_enable_reg = 0x8404,
+	.mem_ack_reg = 0x8418,
+	.mem_enable_ack_mask = BIT(0),
+	.branch = {
+		.halt_reg = 0x800c,
+		.halt_check = BRANCH_HALT,
+		.clkr = {
+			.enable_reg = 0x800c,
+			.enable_mask = BIT(0),
+			.hw.init = &(const struct clk_init_data) {
+				.name = "ecpri_cc_eth_100g_fh_0_hm_ff_0_clk",
+				.parent_hws = (const struct clk_hw*[]) {
+					&ecpri_cc_eth_100g_fh_0_hm_ff_0_div_clk_src.clkr.hw,
+				},
+				.num_parents = 1,
+				.flags = CLK_SET_RATE_PARENT,
+				.ops = &clk_branch2_mem_ops,
+			},
+		},
+	},
+};
+
+static struct clk_mem_branch ecpri_cc_eth_100g_fh_0_hm_ff_1_clk = {
+	.mem_enable_reg = 0x8404,
+	.mem_ack_reg = 0x8418,
+	.mem_enable_ack_mask = BIT(1),
+	.branch = {
+		.halt_reg = 0x8014,
+		.halt_check = BRANCH_HALT,
+		.clkr = {
+			.enable_reg = 0x8014,
+			.enable_mask = BIT(0),
+			.hw.init = &(const struct clk_init_data) {
+				.name = "ecpri_cc_eth_100g_fh_0_hm_ff_1_clk",
+				.parent_hws = (const struct clk_hw*[]) {
+					&ecpri_cc_eth_100g_fh_0_hm_ff_1_div_clk_src.clkr.hw,
+				},
+				.num_parents = 1,
+				.flags = CLK_SET_RATE_PARENT,
+				.ops = &clk_branch2_mem_ops,
+			},
+		},
+	},
+};
+
+static struct clk_mem_branch ecpri_cc_eth_100g_fh_0_hm_ff_2_clk = {
+	.mem_enable_reg = 0x8404,
+	.mem_ack_reg = 0x8418,
+	.mem_enable_ack_mask = BIT(2),
+	.branch = {
+		.halt_reg = 0x801c,
+		.halt_check = BRANCH_HALT,
+		.clkr = {
+			.enable_reg = 0x801c,
+			.enable_mask = BIT(0),
+			.hw.init = &(const struct clk_init_data) {
+				.name = "ecpri_cc_eth_100g_fh_0_hm_ff_2_clk",
+				.parent_hws = (const struct clk_hw*[]) {
+					&ecpri_cc_eth_100g_fh_0_hm_ff_2_div_clk_src.clkr.hw,
+				},
+				.num_parents = 1,
+				.flags = CLK_SET_RATE_PARENT,
+				.ops = &clk_branch2_mem_ops,
+			},
+		},
+	},
+};
+
+static struct clk_mem_branch ecpri_cc_eth_100g_fh_0_hm_ff_3_clk = {
+	.mem_enable_reg = 0x8404,
+	.mem_ack_reg = 0x8418,
+	.mem_enable_ack_mask = BIT(3),
+	.branch = {
+		.halt_reg = 0x8024,
+		.halt_check = BRANCH_HALT,
+		.clkr = {
+			.enable_reg = 0x8024,
+			.enable_mask = BIT(0),
+			.hw.init = &(const struct clk_init_data) {
+				.name = "ecpri_cc_eth_100g_fh_0_hm_ff_3_clk",
+				.parent_hws = (const struct clk_hw*[]) {
+					&ecpri_cc_eth_100g_fh_0_hm_ff_3_div_clk_src.clkr.hw,
+				},
+				.num_parents = 1,
+				.flags = CLK_SET_RATE_PARENT,
+				.ops = &clk_branch2_mem_ops,
+			},
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_eth_100g_fh_0_udp_fifo_clk = {
+	.halt_reg = 0x8034,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x8034,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_100g_fh_0_udp_fifo_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_ecpri_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_mem_branch ecpri_cc_eth_100g_fh_1_hm_ff_0_clk = {
+	.mem_enable_reg = 0x8408,
+	.mem_ack_reg = 0x841c,
+	.mem_enable_ack_mask = BIT(0),
+	.branch = {
+		.halt_reg = 0x8044,
+		.halt_check = BRANCH_HALT,
+		.clkr = {
+			.enable_reg = 0x8044,
+			.enable_mask = BIT(0),
+			.hw.init = &(const struct clk_init_data) {
+				.name = "ecpri_cc_eth_100g_fh_1_hm_ff_0_clk",
+				.parent_hws = (const struct clk_hw*[]) {
+					&ecpri_cc_eth_100g_fh_1_hm_ff_0_div_clk_src.clkr.hw,
+				},
+				.num_parents = 1,
+				.flags = CLK_SET_RATE_PARENT,
+				.ops = &clk_branch2_mem_ops,
+			},
+		},
+	},
+};
+
+static struct clk_mem_branch ecpri_cc_eth_100g_fh_1_hm_ff_1_clk = {
+	.mem_enable_reg = 0x8408,
+	.mem_ack_reg = 0x841c,
+	.mem_enable_ack_mask = BIT(1),
+	.branch = {
+		.halt_reg = 0x804c,
+		.halt_check = BRANCH_HALT,
+		.clkr = {
+			.enable_reg = 0x804c,
+			.enable_mask = BIT(0),
+			.hw.init = &(const struct clk_init_data) {
+				.name = "ecpri_cc_eth_100g_fh_1_hm_ff_1_clk",
+				.parent_hws = (const struct clk_hw*[]) {
+					&ecpri_cc_eth_100g_fh_1_hm_ff_1_div_clk_src.clkr.hw,
+				},
+				.num_parents = 1,
+				.flags = CLK_SET_RATE_PARENT,
+				.ops = &clk_branch2_mem_ops,
+			},
+		},
+	},
+};
+
+static struct clk_mem_branch ecpri_cc_eth_100g_fh_1_hm_ff_2_clk = {
+	.mem_enable_reg = 0x8408,
+	.mem_ack_reg = 0x841c,
+	.mem_enable_ack_mask = BIT(2),
+	.branch = {
+		.halt_reg = 0x8054,
+		.halt_check = BRANCH_HALT,
+		.clkr = {
+			.enable_reg = 0x8054,
+			.enable_mask = BIT(0),
+			.hw.init = &(const struct clk_init_data) {
+				.name = "ecpri_cc_eth_100g_fh_1_hm_ff_2_clk",
+				.parent_hws = (const struct clk_hw*[]) {
+					&ecpri_cc_eth_100g_fh_1_hm_ff_2_div_clk_src.clkr.hw,
+				},
+				.num_parents = 1,
+				.flags = CLK_SET_RATE_PARENT,
+				.ops = &clk_branch2_mem_ops,
+			},
+		},
+	},
+};
+
+static struct clk_mem_branch ecpri_cc_eth_100g_fh_1_hm_ff_3_clk = {
+	.mem_enable_reg = 0x8408,
+	.mem_ack_reg = 0x841c,
+	.mem_enable_ack_mask = BIT(3),
+	.branch = {
+		.halt_reg = 0x805c,
+		.halt_check = BRANCH_HALT,
+		.clkr = {
+			.enable_reg = 0x805c,
+			.enable_mask = BIT(0),
+			.hw.init = &(const struct clk_init_data) {
+				.name = "ecpri_cc_eth_100g_fh_1_hm_ff_3_clk",
+				.parent_hws = (const struct clk_hw*[]) {
+					&ecpri_cc_eth_100g_fh_1_hm_ff_3_div_clk_src.clkr.hw,
+				},
+				.num_parents = 1,
+				.flags = CLK_SET_RATE_PARENT,
+				.ops = &clk_branch2_mem_ops,
+			},
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_eth_100g_fh_1_udp_fifo_clk = {
+	.halt_reg = 0x806c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x806c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_100g_fh_1_udp_fifo_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_ecpri_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_mem_branch ecpri_cc_eth_100g_fh_2_hm_ff_0_clk = {
+	.mem_enable_reg = 0x840c,
+	.mem_ack_reg = 0x8420,
+	.mem_enable_ack_mask = BIT(0),
+	.branch = {
+		.halt_reg = 0x807c,
+		.halt_check = BRANCH_HALT,
+		.clkr = {
+			.enable_reg = 0x807c,
+			.enable_mask = BIT(0),
+			.hw.init = &(const struct clk_init_data) {
+				.name = "ecpri_cc_eth_100g_fh_2_hm_ff_0_clk",
+				.parent_hws = (const struct clk_hw*[]) {
+					&ecpri_cc_eth_100g_fh_2_hm_ff_0_div_clk_src.clkr.hw,
+				},
+				.num_parents = 1,
+				.flags = CLK_SET_RATE_PARENT,
+				.ops = &clk_branch2_mem_ops,
+			},
+		},
+	},
+};
+
+static struct clk_mem_branch ecpri_cc_eth_100g_fh_2_hm_ff_1_clk = {
+	.mem_enable_reg = 0x840c,
+	.mem_ack_reg = 0x8420,
+	.mem_enable_ack_mask = BIT(1),
+	.branch = {
+		.halt_reg = 0x8084,
+		.halt_check = BRANCH_HALT,
+		.clkr = {
+			.enable_reg = 0x8084,
+			.enable_mask = BIT(0),
+			.hw.init = &(const struct clk_init_data) {
+				.name = "ecpri_cc_eth_100g_fh_2_hm_ff_1_clk",
+				.parent_hws = (const struct clk_hw*[]) {
+					&ecpri_cc_eth_100g_fh_2_hm_ff_1_div_clk_src.clkr.hw,
+				},
+				.num_parents = 1,
+				.flags = CLK_SET_RATE_PARENT,
+				.ops = &clk_branch2_mem_ops,
+			},
+		},
+	},
+};
+
+static struct clk_mem_branch ecpri_cc_eth_100g_fh_2_hm_ff_2_clk = {
+	.mem_enable_reg = 0x840c,
+	.mem_ack_reg = 0x8420,
+	.mem_enable_ack_mask = BIT(2),
+	.branch = {
+		.halt_reg = 0x808c,
+		.halt_check = BRANCH_HALT,
+		.clkr = {
+			.enable_reg = 0x808c,
+			.enable_mask = BIT(0),
+			.hw.init = &(const struct clk_init_data) {
+				.name = "ecpri_cc_eth_100g_fh_2_hm_ff_2_clk",
+				.parent_hws = (const struct clk_hw*[]) {
+					&ecpri_cc_eth_100g_fh_2_hm_ff_2_div_clk_src.clkr.hw,
+				},
+				.num_parents = 1,
+				.flags = CLK_SET_RATE_PARENT,
+				.ops = &clk_branch2_mem_ops,
+			},
+		},
+	},
+};
+
+static struct clk_mem_branch ecpri_cc_eth_100g_fh_2_hm_ff_3_clk = {
+	.mem_enable_reg = 0x840c,
+	.mem_ack_reg = 0x8420,
+	.mem_enable_ack_mask = BIT(3),
+	.branch = {
+		.halt_reg = 0x8094,
+		.halt_check = BRANCH_HALT,
+		.clkr = {
+			.enable_reg = 0x8094,
+			.enable_mask = BIT(0),
+			.hw.init = &(const struct clk_init_data) {
+				.name = "ecpri_cc_eth_100g_fh_2_hm_ff_3_clk",
+				.parent_hws = (const struct clk_hw*[]) {
+					&ecpri_cc_eth_100g_fh_2_hm_ff_3_div_clk_src.clkr.hw,
+				},
+				.num_parents = 1,
+				.flags = CLK_SET_RATE_PARENT,
+				.ops = &clk_branch2_mem_ops,
+			},
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_eth_100g_fh_2_udp_fifo_clk = {
+	.halt_reg = 0x80a4,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x80a4,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_100g_fh_2_udp_fifo_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_ecpri_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_mem_branch ecpri_cc_eth_100g_fh_macsec_0_clk = {
+	.mem_enable_reg = 0x8404,
+	.mem_ack_reg = 0x8418,
+	.mem_enable_ack_mask = BIT(4),
+	.branch = {
+		.halt_reg = 0x8004,
+		.halt_check = BRANCH_HALT,
+		.clkr = {
+			.enable_reg = 0x8004,
+			.enable_mask = BIT(0),
+			.hw.init = &(const struct clk_init_data) {
+				.name = "ecpri_cc_eth_100g_fh_macsec_0_clk",
+				.parent_hws = (const struct clk_hw*[]) {
+					&ecpri_cc_eth_100g_fh0_macsec_clk_src.clkr.hw,
+				},
+				.num_parents = 1,
+				.flags = CLK_SET_RATE_PARENT,
+				.ops = &clk_branch2_mem_ops,
+			},
+		},
+	},
+};
+
+static struct clk_mem_branch ecpri_cc_eth_100g_fh_macsec_1_clk = {
+	.mem_enable_reg = 0x8408,
+	.mem_ack_reg = 0x841c,
+	.mem_enable_ack_mask = BIT(4),
+	.branch = {
+		.halt_reg = 0x803c,
+		.halt_check = BRANCH_HALT,
+		.clkr = {
+			.enable_reg = 0x803c,
+			.enable_mask = BIT(0),
+			.hw.init = &(const struct clk_init_data) {
+				.name = "ecpri_cc_eth_100g_fh_macsec_1_clk",
+				.parent_hws = (const struct clk_hw*[]) {
+					&ecpri_cc_eth_100g_fh1_macsec_clk_src.clkr.hw,
+				},
+				.num_parents = 1,
+				.flags = CLK_SET_RATE_PARENT,
+				.ops = &clk_branch2_mem_ops,
+			},
+		},
+	},
+};
+
+static struct clk_mem_branch ecpri_cc_eth_100g_fh_macsec_2_clk = {
+	.mem_enable_reg = 0x840c,
+	.mem_ack_reg = 0x8420,
+	.mem_enable_ack_mask = BIT(4),
+	.branch = {
+		.halt_reg = 0x8074,
+		.halt_check = BRANCH_HALT,
+		.clkr = {
+			.enable_reg = 0x8074,
+			.enable_mask = BIT(0),
+			.hw.init = &(const struct clk_init_data) {
+				.name = "ecpri_cc_eth_100g_fh_macsec_2_clk",
+				.parent_hws = (const struct clk_hw*[]) {
+					&ecpri_cc_eth_100g_fh2_macsec_clk_src.clkr.hw,
+				},
+				.num_parents = 1,
+				.flags = CLK_SET_RATE_PARENT,
+				.ops = &clk_branch2_mem_ops,
+			},
+		},
+	},
+};
+
+static struct clk_mem_branch ecpri_cc_eth_100g_mac_c2c_hm_ref_clk = {
+	.mem_enable_reg = 0x8410,
+	.mem_ack_reg = 0x8424,
+	.mem_enable_ack_mask = BIT(5),
+	.branch = {
+		.halt_reg = 0x80c4,
+		.halt_check = BRANCH_HALT,
+		.clkr = {
+			.enable_reg = 0x80c4,
+			.enable_mask = BIT(0),
+			.hw.init = &(const struct clk_init_data) {
+				.name = "ecpri_cc_eth_100g_mac_c2c_hm_ref_clk",
+				.parent_hws = (const struct clk_hw*[]) {
+					&ecpri_cc_eth_100g_mac_c2c_hm_ref_clk_src.clkr.hw,
+				},
+				.num_parents = 1,
+				.flags = CLK_SET_RATE_PARENT,
+				.ops = &clk_branch2_mem_ops,
+			},
+		},
+	},
+};
+
+static struct clk_mem_branch ecpri_cc_eth_100g_mac_dbg_c2c_hm_ref_clk = {
+	.mem_enable_reg = 0x8414,
+	.mem_ack_reg = 0x8428,
+	.mem_enable_ack_mask = BIT(5),
+	.branch = {
+		.halt_reg = 0x80e8,
+		.halt_check = BRANCH_HALT,
+		.clkr = {
+			.enable_reg = 0x80e8,
+			.enable_mask = BIT(0),
+			.hw.init = &(const struct clk_init_data) {
+				.name = "ecpri_cc_eth_100g_mac_dbg_c2c_hm_ref_clk",
+				.parent_hws = (const struct clk_hw*[]) {
+					&ecpri_cc_eth_100g_mac_dbg_c2c_hm_ref_clk_src.clkr.hw,
+				},
+				.num_parents = 1,
+				.flags = CLK_SET_RATE_PARENT,
+				.ops = &clk_branch2_mem_ops,
+			},
+		},
+	},
+};
+
+static struct clk_mem_branch ecpri_cc_eth_100g_mac_fh0_hm_ref_clk = {
+	.mem_enable_reg = 0x8404,
+	.mem_ack_reg = 0x8418,
+	.mem_enable_ack_mask = BIT(5),
+	.branch = {
+		.halt_reg = 0x802c,
+		.halt_check = BRANCH_HALT,
+		.clkr = {
+			.enable_reg = 0x802c,
+			.enable_mask = BIT(0),
+			.hw.init = &(const struct clk_init_data) {
+				.name = "ecpri_cc_eth_100g_mac_fh0_hm_ref_clk",
+				.parent_hws = (const struct clk_hw*[]) {
+					&ecpri_cc_eth_100g_mac_fh0_hm_ref_clk_src.clkr.hw,
+				},
+				.num_parents = 1,
+				.flags = CLK_SET_RATE_PARENT,
+				.ops = &clk_branch2_mem_ops,
+			},
+		},
+	},
+};
+
+static struct clk_mem_branch ecpri_cc_eth_100g_mac_fh1_hm_ref_clk = {
+	.mem_enable_reg = 0x8408,
+	.mem_ack_reg = 0x841c,
+	.mem_enable_ack_mask = BIT(5),
+	.branch = {
+		.halt_reg = 0x8064,
+		.halt_check = BRANCH_HALT,
+		.clkr = {
+			.enable_reg = 0x8064,
+			.enable_mask = BIT(0),
+			.hw.init = &(const struct clk_init_data) {
+				.name = "ecpri_cc_eth_100g_mac_fh1_hm_ref_clk",
+				.parent_hws = (const struct clk_hw*[]) {
+					&ecpri_cc_eth_100g_mac_fh1_hm_ref_clk_src.clkr.hw,
+				},
+				.num_parents = 1,
+				.flags = CLK_SET_RATE_PARENT,
+				.ops = &clk_branch2_mem_ops,
+			},
+		},
+	},
+};
+
+static struct clk_mem_branch ecpri_cc_eth_100g_mac_fh2_hm_ref_clk = {
+	.mem_enable_reg = 0x840c,
+	.mem_ack_reg = 0x8420,
+	.mem_enable_ack_mask = BIT(5),
+	.branch = {
+		.halt_reg = 0x809c,
+		.halt_check = BRANCH_HALT,
+		.clkr = {
+			.enable_reg = 0x809c,
+			.enable_mask = BIT(0),
+			.hw.init = &(const struct clk_init_data) {
+				.name = "ecpri_cc_eth_100g_mac_fh2_hm_ref_clk",
+				.parent_hws = (const struct clk_hw*[]) {
+					&ecpri_cc_eth_100g_mac_fh2_hm_ref_clk_src.clkr.hw,
+				},
+				.num_parents = 1,
+				.flags = CLK_SET_RATE_PARENT,
+				.ops = &clk_branch2_mem_ops,
+			},
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_eth_dbg_nfapi_axi_clk = {
+	.halt_reg = 0x80f4,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x80f4,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_dbg_nfapi_axi_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_ecpri_dma_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_eth_dbg_noc_axi_clk = {
+	.halt_reg = 0x80fc,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x80fc,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_dbg_noc_axi_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_mss_emac_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_mem_branch ecpri_cc_eth_phy_0_ock_sram_clk = {
+	.mem_enable_reg = 0x8404,
+	.mem_ack_reg = 0x8418,
+	.mem_enable_ack_mask = BIT(6),
+	.branch = {
+		.halt_reg = 0xd140,
+		.halt_check = BRANCH_HALT,
+		.clkr = {
+			.enable_reg = 0xd140,
+			.enable_mask = BIT(0),
+			.hw.init = &(const struct clk_init_data) {
+				.name = "ecpri_cc_eth_phy_0_ock_sram_clk",
+				.ops = &clk_branch2_mem_ops,
+			},
+		},
+	},
+};
+
+static struct clk_mem_branch ecpri_cc_eth_phy_1_ock_sram_clk = {
+	.mem_enable_reg = 0x8408,
+	.mem_ack_reg = 0x841C,
+	.mem_enable_ack_mask = BIT(6),
+	.branch = {
+		.halt_reg = 0xd148,
+		.halt_check = BRANCH_HALT,
+		.clkr = {
+			.enable_reg = 0xd148,
+			.enable_mask = BIT(0),
+			.hw.init = &(const struct clk_init_data) {
+				.name = "ecpri_cc_eth_phy_1_ock_sram_clk",
+				.ops = &clk_branch2_mem_ops,
+			},
+		},
+	},
+};
+
+static struct clk_mem_branch ecpri_cc_eth_phy_2_ock_sram_clk = {
+	.mem_enable_reg = 0x840c,
+	.mem_ack_reg = 0x8420,
+	.mem_enable_ack_mask = BIT(6),
+	.branch = {
+		.halt_reg = 0xd150,
+		.halt_check = BRANCH_HALT,
+		.clkr = {
+			.enable_reg = 0xd150,
+			.enable_mask = BIT(0),
+			.hw.init = &(const struct clk_init_data) {
+				.name = "ecpri_cc_eth_phy_2_ock_sram_clk",
+				.ops = &clk_branch2_mem_ops,
+			},
+		},
+	},
+};
+
+static struct clk_mem_branch ecpri_cc_eth_phy_3_ock_sram_clk = {
+	.mem_enable_reg = 0x8410,
+	.mem_ack_reg = 0x8424,
+	.mem_enable_ack_mask = BIT(6),
+	.branch = {
+		.halt_reg = 0xd158,
+		.halt_check = BRANCH_HALT,
+		.clkr = {
+			.enable_reg = 0xd158,
+			.enable_mask = BIT(0),
+			.hw.init = &(const struct clk_init_data) {
+				.name = "ecpri_cc_eth_phy_3_ock_sram_clk",
+				.ops = &clk_branch2_mem_ops,
+			},
+		},
+	},
+};
+
+static struct clk_mem_branch ecpri_cc_eth_phy_4_ock_sram_clk = {
+	.mem_enable_reg = 0x8414,
+	.mem_ack_reg = 0x8428,
+	.mem_enable_ack_mask = BIT(6),
+	.branch = {
+		.halt_reg = 0xd160,
+		.halt_check = BRANCH_HALT,
+		.clkr = {
+			.enable_reg = 0xd160,
+			.enable_mask = BIT(0),
+			.hw.init = &(const struct clk_init_data) {
+				.name = "ecpri_cc_eth_phy_4_ock_sram_clk",
+				.ops = &clk_branch2_mem_ops,
+			},
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_mss_emac_clk = {
+	.halt_reg = 0xe008,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xe008,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_mss_emac_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_mss_emac_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_mss_oran_clk = {
+	.halt_reg = 0xe004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xe004,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_mss_oran_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_ecpri_oran_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy0_lane0_rx_clk = {
+	.halt_reg = 0xd000,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd000,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy0_lane0_rx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy0_lane0_tx_clk = {
+	.halt_reg = 0xd050,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd050,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy0_lane0_tx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy0_lane1_rx_clk = {
+	.halt_reg = 0xd004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd004,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy0_lane1_rx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy0_lane1_tx_clk = {
+	.halt_reg = 0xd054,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd054,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy0_lane1_tx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy0_lane2_rx_clk = {
+	.halt_reg = 0xd008,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd008,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy0_lane2_rx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy0_lane2_tx_clk = {
+	.halt_reg = 0xd058,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd058,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy0_lane2_tx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy0_lane3_rx_clk = {
+	.halt_reg = 0xd00c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd00c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy0_lane3_rx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy0_lane3_tx_clk = {
+	.halt_reg = 0xd05c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd05c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy0_lane3_tx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy1_lane0_rx_clk = {
+	.halt_reg = 0xd010,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd010,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy1_lane0_rx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy1_lane0_tx_clk = {
+	.halt_reg = 0xd060,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd060,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy1_lane0_tx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy1_lane1_rx_clk = {
+	.halt_reg = 0xd014,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd014,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy1_lane1_rx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy1_lane1_tx_clk = {
+	.halt_reg = 0xd064,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd064,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy1_lane1_tx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy1_lane2_rx_clk = {
+	.halt_reg = 0xd018,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd018,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy1_lane2_rx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy1_lane2_tx_clk = {
+	.halt_reg = 0xd068,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd068,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy1_lane2_tx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy1_lane3_rx_clk = {
+	.halt_reg = 0xd01c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd01c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy1_lane3_rx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy1_lane3_tx_clk = {
+	.halt_reg = 0xd06c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd06c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy1_lane3_tx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy2_lane0_rx_clk = {
+	.halt_reg = 0xd020,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd020,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy2_lane0_rx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy2_lane0_tx_clk = {
+	.halt_reg = 0xd070,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd070,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy2_lane0_tx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy2_lane1_rx_clk = {
+	.halt_reg = 0xd024,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd024,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy2_lane1_rx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy2_lane1_tx_clk = {
+	.halt_reg = 0xd074,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd074,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy2_lane1_tx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy2_lane2_rx_clk = {
+	.halt_reg = 0xd028,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd028,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy2_lane2_rx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy2_lane2_tx_clk = {
+	.halt_reg = 0xd078,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd078,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy2_lane2_tx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy2_lane3_rx_clk = {
+	.halt_reg = 0xd02c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd02c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy2_lane3_rx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy2_lane3_tx_clk = {
+	.halt_reg = 0xd07c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd07c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy2_lane3_tx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy3_lane0_rx_clk = {
+	.halt_reg = 0xd030,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd030,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy3_lane0_rx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy3_lane0_tx_clk = {
+	.halt_reg = 0xd080,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd080,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy3_lane0_tx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy3_lane1_rx_clk = {
+	.halt_reg = 0xd034,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd034,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy3_lane1_rx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy3_lane1_tx_clk = {
+	.halt_reg = 0xd084,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd084,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy3_lane1_tx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy3_lane2_rx_clk = {
+	.halt_reg = 0xd038,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd038,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy3_lane2_rx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy3_lane2_tx_clk = {
+	.halt_reg = 0xd088,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd088,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy3_lane2_tx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy3_lane3_rx_clk = {
+	.halt_reg = 0xd03c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd03c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy3_lane3_rx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy3_lane3_tx_clk = {
+	.halt_reg = 0xd08c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd08c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy3_lane3_tx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy4_lane0_rx_clk = {
+	.halt_reg = 0xd040,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd040,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy4_lane0_rx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy4_lane0_tx_clk = {
+	.halt_reg = 0xd090,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd090,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy4_lane0_tx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy4_lane1_rx_clk = {
+	.halt_reg = 0xd044,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd044,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy4_lane1_rx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy4_lane1_tx_clk = {
+	.halt_reg = 0xd094,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd094,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy4_lane1_tx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy4_lane2_rx_clk = {
+	.halt_reg = 0xd048,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd048,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy4_lane2_rx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy4_lane2_tx_clk = {
+	.halt_reg = 0xd098,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd098,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy4_lane2_tx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy4_lane3_rx_clk = {
+	.halt_reg = 0xd04c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd04c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy4_lane3_rx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_phy4_lane3_tx_clk = {
+	.halt_reg = 0xd09c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xd09c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy4_lane3_tx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_regmap *ecpri_cc_qdu1000_clocks[] = {
+	[ECPRI_CC_ECPRI_CG_CLK] = &ecpri_cc_ecpri_cg_clk.clkr,
+	[ECPRI_CC_ECPRI_CLK_SRC] = &ecpri_cc_ecpri_clk_src.clkr,
+	[ECPRI_CC_ECPRI_DMA_CLK] = &ecpri_cc_ecpri_dma_clk.clkr,
+	[ECPRI_CC_ECPRI_DMA_CLK_SRC] = &ecpri_cc_ecpri_dma_clk_src.clkr,
+	[ECPRI_CC_ECPRI_DMA_NOC_CLK] = &ecpri_cc_ecpri_dma_noc_clk.clkr,
+	[ECPRI_CC_ECPRI_FAST_CLK] = &ecpri_cc_ecpri_fast_clk.clkr,
+	[ECPRI_CC_ECPRI_FAST_CLK_SRC] = &ecpri_cc_ecpri_fast_clk_src.clkr,
+	[ECPRI_CC_ECPRI_FAST_DIV2_CLK] = &ecpri_cc_ecpri_fast_div2_clk.clkr,
+	[ECPRI_CC_ECPRI_FAST_DIV2_CLK_SRC] = &ecpri_cc_ecpri_fast_div2_clk_src.clkr,
+	[ECPRI_CC_ECPRI_FAST_DIV2_NOC_CLK] = &ecpri_cc_ecpri_fast_div2_noc_clk.clkr,
+	[ECPRI_CC_ECPRI_FR_CLK] = &ecpri_cc_ecpri_fr_clk.clkr,
+	[ECPRI_CC_ECPRI_ORAN_CLK_SRC] = &ecpri_cc_ecpri_oran_clk_src.clkr,
+	[ECPRI_CC_ECPRI_ORAN_DIV2_CLK] = &ecpri_cc_ecpri_oran_div2_clk.clkr,
+	[ECPRI_CC_ETH_100G_C2C0_HM_FF_CLK_SRC] = &ecpri_cc_eth_100g_c2c0_hm_ff_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_C2C0_UDP_FIFO_CLK] = &ecpri_cc_eth_100g_c2c0_udp_fifo_clk.clkr,
+	[ECPRI_CC_ETH_100G_C2C1_UDP_FIFO_CLK] = &ecpri_cc_eth_100g_c2c1_udp_fifo_clk.clkr,
+	[ECPRI_CC_ETH_100G_C2C_0_HM_FF_0_CLK] = &ecpri_cc_eth_100g_c2c_0_hm_ff_0_clk.branch.clkr,
+	[ECPRI_CC_ETH_100G_C2C_0_HM_FF_1_CLK] = &ecpri_cc_eth_100g_c2c_0_hm_ff_1_clk.branch.clkr,
+	[ECPRI_CC_ETH_100G_C2C_HM_FF_0_DIV_CLK_SRC] =
+		&ecpri_cc_eth_100g_c2c_hm_ff_0_div_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_C2C_HM_FF_1_DIV_CLK_SRC] =
+		&ecpri_cc_eth_100g_c2c_hm_ff_1_div_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_C2C_HM_MACSEC_CLK] = &ecpri_cc_eth_100g_c2c_hm_macsec_clk.branch.clkr,
+	[ECPRI_CC_ETH_100G_C2C_HM_MACSEC_CLK_SRC] = &ecpri_cc_eth_100g_c2c_hm_macsec_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_DBG_C2C_HM_FF_0_CLK] =
+		&ecpri_cc_eth_100g_dbg_c2c_hm_ff_0_clk.branch.clkr,
+	[ECPRI_CC_ETH_100G_DBG_C2C_HM_FF_0_DIV_CLK_SRC] =
+		&ecpri_cc_eth_100g_dbg_c2c_hm_ff_0_div_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_DBG_C2C_HM_FF_1_CLK] =
+		&ecpri_cc_eth_100g_dbg_c2c_hm_ff_1_clk.branch.clkr,
+	[ECPRI_CC_ETH_100G_DBG_C2C_HM_FF_1_DIV_CLK_SRC] =
+		&ecpri_cc_eth_100g_dbg_c2c_hm_ff_1_div_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_DBG_C2C_HM_FF_CLK_SRC] = &ecpri_cc_eth_100g_dbg_c2c_hm_ff_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_DBG_C2C_UDP_FIFO_CLK] = &ecpri_cc_eth_100g_dbg_c2c_udp_fifo_clk.clkr,
+	[ECPRI_CC_ETH_100G_FH0_HM_FF_CLK_SRC] = &ecpri_cc_eth_100g_fh0_hm_ff_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_FH0_MACSEC_CLK_SRC] = &ecpri_cc_eth_100g_fh0_macsec_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_FH1_HM_FF_CLK_SRC] = &ecpri_cc_eth_100g_fh1_hm_ff_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_FH1_MACSEC_CLK_SRC] = &ecpri_cc_eth_100g_fh1_macsec_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_FH2_HM_FF_CLK_SRC] = &ecpri_cc_eth_100g_fh2_hm_ff_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_FH2_MACSEC_CLK_SRC] = &ecpri_cc_eth_100g_fh2_macsec_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_FH_0_HM_FF_0_CLK] = &ecpri_cc_eth_100g_fh_0_hm_ff_0_clk.branch.clkr,
+	[ECPRI_CC_ETH_100G_FH_0_HM_FF_0_DIV_CLK_SRC] =
+		&ecpri_cc_eth_100g_fh_0_hm_ff_0_div_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_FH_0_HM_FF_1_CLK] = &ecpri_cc_eth_100g_fh_0_hm_ff_1_clk.branch.clkr,
+	[ECPRI_CC_ETH_100G_FH_0_HM_FF_1_DIV_CLK_SRC] =
+		&ecpri_cc_eth_100g_fh_0_hm_ff_1_div_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_FH_0_HM_FF_2_CLK] = &ecpri_cc_eth_100g_fh_0_hm_ff_2_clk.branch.clkr,
+	[ECPRI_CC_ETH_100G_FH_0_HM_FF_2_DIV_CLK_SRC] =
+		&ecpri_cc_eth_100g_fh_0_hm_ff_2_div_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_FH_0_HM_FF_3_CLK] = &ecpri_cc_eth_100g_fh_0_hm_ff_3_clk.branch.clkr,
+	[ECPRI_CC_ETH_100G_FH_0_HM_FF_3_DIV_CLK_SRC] =
+		&ecpri_cc_eth_100g_fh_0_hm_ff_3_div_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_FH_0_UDP_FIFO_CLK] = &ecpri_cc_eth_100g_fh_0_udp_fifo_clk.clkr,
+	[ECPRI_CC_ETH_100G_FH_1_HM_FF_0_CLK] = &ecpri_cc_eth_100g_fh_1_hm_ff_0_clk.branch.clkr,
+	[ECPRI_CC_ETH_100G_FH_1_HM_FF_0_DIV_CLK_SRC] =
+		&ecpri_cc_eth_100g_fh_1_hm_ff_0_div_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_FH_1_HM_FF_1_CLK] = &ecpri_cc_eth_100g_fh_1_hm_ff_1_clk.branch.clkr,
+	[ECPRI_CC_ETH_100G_FH_1_HM_FF_1_DIV_CLK_SRC] =
+		&ecpri_cc_eth_100g_fh_1_hm_ff_1_div_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_FH_1_HM_FF_2_CLK] = &ecpri_cc_eth_100g_fh_1_hm_ff_2_clk.branch.clkr,
+	[ECPRI_CC_ETH_100G_FH_1_HM_FF_2_DIV_CLK_SRC] =
+		&ecpri_cc_eth_100g_fh_1_hm_ff_2_div_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_FH_1_HM_FF_3_CLK] = &ecpri_cc_eth_100g_fh_1_hm_ff_3_clk.branch.clkr,
+	[ECPRI_CC_ETH_100G_FH_1_HM_FF_3_DIV_CLK_SRC] =
+		&ecpri_cc_eth_100g_fh_1_hm_ff_3_div_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_FH_1_UDP_FIFO_CLK] = &ecpri_cc_eth_100g_fh_1_udp_fifo_clk.clkr,
+	[ECPRI_CC_ETH_100G_FH_2_HM_FF_0_CLK] = &ecpri_cc_eth_100g_fh_2_hm_ff_0_clk.branch.clkr,
+	[ECPRI_CC_ETH_100G_FH_2_HM_FF_0_DIV_CLK_SRC] =
+		&ecpri_cc_eth_100g_fh_2_hm_ff_0_div_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_FH_2_HM_FF_1_CLK] = &ecpri_cc_eth_100g_fh_2_hm_ff_1_clk.branch.clkr,
+	[ECPRI_CC_ETH_100G_FH_2_HM_FF_1_DIV_CLK_SRC] =
+		&ecpri_cc_eth_100g_fh_2_hm_ff_1_div_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_FH_2_HM_FF_2_CLK] = &ecpri_cc_eth_100g_fh_2_hm_ff_2_clk.branch.clkr,
+	[ECPRI_CC_ETH_100G_FH_2_HM_FF_2_DIV_CLK_SRC] =
+		&ecpri_cc_eth_100g_fh_2_hm_ff_2_div_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_FH_2_HM_FF_3_CLK] = &ecpri_cc_eth_100g_fh_2_hm_ff_3_clk.branch.clkr,
+	[ECPRI_CC_ETH_100G_FH_2_HM_FF_3_DIV_CLK_SRC] =
+		&ecpri_cc_eth_100g_fh_2_hm_ff_3_div_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_FH_2_UDP_FIFO_CLK] = &ecpri_cc_eth_100g_fh_2_udp_fifo_clk.clkr,
+	[ECPRI_CC_ETH_100G_FH_MACSEC_0_CLK] = &ecpri_cc_eth_100g_fh_macsec_0_clk.branch.clkr,
+	[ECPRI_CC_ETH_100G_FH_MACSEC_1_CLK] = &ecpri_cc_eth_100g_fh_macsec_1_clk.branch.clkr,
+	[ECPRI_CC_ETH_100G_FH_MACSEC_2_CLK] = &ecpri_cc_eth_100g_fh_macsec_2_clk.branch.clkr,
+	[ECPRI_CC_ETH_100G_MAC_C2C_HM_REF_CLK] = &ecpri_cc_eth_100g_mac_c2c_hm_ref_clk.branch.clkr,
+	[ECPRI_CC_ETH_100G_MAC_C2C_HM_REF_CLK_SRC] = &ecpri_cc_eth_100g_mac_c2c_hm_ref_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_MAC_DBG_C2C_HM_REF_CLK] =
+		&ecpri_cc_eth_100g_mac_dbg_c2c_hm_ref_clk.branch.clkr,
+	[ECPRI_CC_ETH_100G_MAC_DBG_C2C_HM_REF_CLK_SRC] =
+		&ecpri_cc_eth_100g_mac_dbg_c2c_hm_ref_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_MAC_FH0_HM_REF_CLK] = &ecpri_cc_eth_100g_mac_fh0_hm_ref_clk.branch.clkr,
+	[ECPRI_CC_ETH_100G_MAC_FH0_HM_REF_CLK_SRC] = &ecpri_cc_eth_100g_mac_fh0_hm_ref_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_MAC_FH1_HM_REF_CLK] = &ecpri_cc_eth_100g_mac_fh1_hm_ref_clk.branch.clkr,
+	[ECPRI_CC_ETH_100G_MAC_FH1_HM_REF_CLK_SRC] = &ecpri_cc_eth_100g_mac_fh1_hm_ref_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_MAC_FH2_HM_REF_CLK] = &ecpri_cc_eth_100g_mac_fh2_hm_ref_clk.branch.clkr,
+	[ECPRI_CC_ETH_100G_MAC_FH2_HM_REF_CLK_SRC] = &ecpri_cc_eth_100g_mac_fh2_hm_ref_clk_src.clkr,
+	[ECPRI_CC_ETH_DBG_NFAPI_AXI_CLK] = &ecpri_cc_eth_dbg_nfapi_axi_clk.clkr,
+	[ECPRI_CC_ETH_DBG_NOC_AXI_CLK] = &ecpri_cc_eth_dbg_noc_axi_clk.clkr,
+	[ECPRI_CC_ETH_PHY_0_OCK_SRAM_CLK] = &ecpri_cc_eth_phy_0_ock_sram_clk.branch.clkr,
+	[ECPRI_CC_ETH_PHY_1_OCK_SRAM_CLK] = &ecpri_cc_eth_phy_1_ock_sram_clk.branch.clkr,
+	[ECPRI_CC_ETH_PHY_2_OCK_SRAM_CLK] = &ecpri_cc_eth_phy_2_ock_sram_clk.branch.clkr,
+	[ECPRI_CC_ETH_PHY_3_OCK_SRAM_CLK] = &ecpri_cc_eth_phy_3_ock_sram_clk.branch.clkr,
+	[ECPRI_CC_ETH_PHY_4_OCK_SRAM_CLK] = &ecpri_cc_eth_phy_4_ock_sram_clk.branch.clkr,
+	[ECPRI_CC_MSS_EMAC_CLK] = &ecpri_cc_mss_emac_clk.clkr,
+	[ECPRI_CC_MSS_EMAC_CLK_SRC] = &ecpri_cc_mss_emac_clk_src.clkr,
+	[ECPRI_CC_MSS_ORAN_CLK] = &ecpri_cc_mss_oran_clk.clkr,
+	[ECPRI_CC_PHY0_LANE0_RX_CLK] = &ecpri_cc_phy0_lane0_rx_clk.clkr,
+	[ECPRI_CC_PHY0_LANE0_TX_CLK] = &ecpri_cc_phy0_lane0_tx_clk.clkr,
+	[ECPRI_CC_PHY0_LANE1_RX_CLK] = &ecpri_cc_phy0_lane1_rx_clk.clkr,
+	[ECPRI_CC_PHY0_LANE1_TX_CLK] = &ecpri_cc_phy0_lane1_tx_clk.clkr,
+	[ECPRI_CC_PHY0_LANE2_RX_CLK] = &ecpri_cc_phy0_lane2_rx_clk.clkr,
+	[ECPRI_CC_PHY0_LANE2_TX_CLK] = &ecpri_cc_phy0_lane2_tx_clk.clkr,
+	[ECPRI_CC_PHY0_LANE3_RX_CLK] = &ecpri_cc_phy0_lane3_rx_clk.clkr,
+	[ECPRI_CC_PHY0_LANE3_TX_CLK] = &ecpri_cc_phy0_lane3_tx_clk.clkr,
+	[ECPRI_CC_PHY1_LANE0_RX_CLK] = &ecpri_cc_phy1_lane0_rx_clk.clkr,
+	[ECPRI_CC_PHY1_LANE0_TX_CLK] = &ecpri_cc_phy1_lane0_tx_clk.clkr,
+	[ECPRI_CC_PHY1_LANE1_RX_CLK] = &ecpri_cc_phy1_lane1_rx_clk.clkr,
+	[ECPRI_CC_PHY1_LANE1_TX_CLK] = &ecpri_cc_phy1_lane1_tx_clk.clkr,
+	[ECPRI_CC_PHY1_LANE2_RX_CLK] = &ecpri_cc_phy1_lane2_rx_clk.clkr,
+	[ECPRI_CC_PHY1_LANE2_TX_CLK] = &ecpri_cc_phy1_lane2_tx_clk.clkr,
+	[ECPRI_CC_PHY1_LANE3_RX_CLK] = &ecpri_cc_phy1_lane3_rx_clk.clkr,
+	[ECPRI_CC_PHY1_LANE3_TX_CLK] = &ecpri_cc_phy1_lane3_tx_clk.clkr,
+	[ECPRI_CC_PHY2_LANE0_RX_CLK] = &ecpri_cc_phy2_lane0_rx_clk.clkr,
+	[ECPRI_CC_PHY2_LANE0_TX_CLK] = &ecpri_cc_phy2_lane0_tx_clk.clkr,
+	[ECPRI_CC_PHY2_LANE1_RX_CLK] = &ecpri_cc_phy2_lane1_rx_clk.clkr,
+	[ECPRI_CC_PHY2_LANE1_TX_CLK] = &ecpri_cc_phy2_lane1_tx_clk.clkr,
+	[ECPRI_CC_PHY2_LANE2_RX_CLK] = &ecpri_cc_phy2_lane2_rx_clk.clkr,
+	[ECPRI_CC_PHY2_LANE2_TX_CLK] = &ecpri_cc_phy2_lane2_tx_clk.clkr,
+	[ECPRI_CC_PHY2_LANE3_RX_CLK] = &ecpri_cc_phy2_lane3_rx_clk.clkr,
+	[ECPRI_CC_PHY2_LANE3_TX_CLK] = &ecpri_cc_phy2_lane3_tx_clk.clkr,
+	[ECPRI_CC_PHY3_LANE0_RX_CLK] = &ecpri_cc_phy3_lane0_rx_clk.clkr,
+	[ECPRI_CC_PHY3_LANE0_TX_CLK] = &ecpri_cc_phy3_lane0_tx_clk.clkr,
+	[ECPRI_CC_PHY3_LANE1_RX_CLK] = &ecpri_cc_phy3_lane1_rx_clk.clkr,
+	[ECPRI_CC_PHY3_LANE1_TX_CLK] = &ecpri_cc_phy3_lane1_tx_clk.clkr,
+	[ECPRI_CC_PHY3_LANE2_RX_CLK] = &ecpri_cc_phy3_lane2_rx_clk.clkr,
+	[ECPRI_CC_PHY3_LANE2_TX_CLK] = &ecpri_cc_phy3_lane2_tx_clk.clkr,
+	[ECPRI_CC_PHY3_LANE3_RX_CLK] = &ecpri_cc_phy3_lane3_rx_clk.clkr,
+	[ECPRI_CC_PHY3_LANE3_TX_CLK] = &ecpri_cc_phy3_lane3_tx_clk.clkr,
+	[ECPRI_CC_PHY4_LANE0_RX_CLK] = &ecpri_cc_phy4_lane0_rx_clk.clkr,
+	[ECPRI_CC_PHY4_LANE0_TX_CLK] = &ecpri_cc_phy4_lane0_tx_clk.clkr,
+	[ECPRI_CC_PHY4_LANE1_RX_CLK] = &ecpri_cc_phy4_lane1_rx_clk.clkr,
+	[ECPRI_CC_PHY4_LANE1_TX_CLK] = &ecpri_cc_phy4_lane1_tx_clk.clkr,
+	[ECPRI_CC_PHY4_LANE2_RX_CLK] = &ecpri_cc_phy4_lane2_rx_clk.clkr,
+	[ECPRI_CC_PHY4_LANE2_TX_CLK] = &ecpri_cc_phy4_lane2_tx_clk.clkr,
+	[ECPRI_CC_PHY4_LANE3_RX_CLK] = &ecpri_cc_phy4_lane3_rx_clk.clkr,
+	[ECPRI_CC_PHY4_LANE3_TX_CLK] = &ecpri_cc_phy4_lane3_tx_clk.clkr,
+	[ECPRI_CC_PLL0] = &ecpri_cc_pll0.clkr,
+	[ECPRI_CC_PLL1] = &ecpri_cc_pll1.clkr,
+};
+
+static const struct qcom_reset_map ecpri_cc_qdu1000_resets[] = {
+	[ECPRI_CC_CLK_CTL_TOP_ECPRI_CC_ECPRI_SS_BCR] = { 0x9000 },
+	[ECPRI_CC_CLK_CTL_TOP_ECPRI_CC_ETH_C2C_BCR] = { 0x80a8 },
+	[ECPRI_CC_CLK_CTL_TOP_ECPRI_CC_ETH_FH0_BCR] = { 0x8000 },
+	[ECPRI_CC_CLK_CTL_TOP_ECPRI_CC_ETH_FH1_BCR] = { 0x8038 },
+	[ECPRI_CC_CLK_CTL_TOP_ECPRI_CC_ETH_FH2_BCR] = { 0x8070 },
+	[ECPRI_CC_CLK_CTL_TOP_ECPRI_CC_ETH_WRAPPER_TOP_BCR] = { 0x8104 },
+	[ECPRI_CC_CLK_CTL_TOP_ECPRI_CC_MODEM_BCR] = { 0xe000 },
+	[ECPRI_CC_CLK_CTL_TOP_ECPRI_CC_NOC_BCR] = { 0xf000 },
+};
+
+static const struct regmap_config ecpri_cc_qdu1000_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x31bf0,
+	.fast_io = true,
+};
+
+static const struct qcom_cc_desc ecpri_cc_qdu1000_desc = {
+	.config = &ecpri_cc_qdu1000_regmap_config,
+	.clks = ecpri_cc_qdu1000_clocks,
+	.num_clks = ARRAY_SIZE(ecpri_cc_qdu1000_clocks),
+	.resets = ecpri_cc_qdu1000_resets,
+	.num_resets = ARRAY_SIZE(ecpri_cc_qdu1000_resets),
+};
+
+static const struct of_device_id ecpri_cc_qdu1000_match_table[] = {
+	{ .compatible = "qcom,qdu1000-ecpricc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ecpri_cc_qdu1000_match_table);
+
+static int ecpri_cc_qdu1000_probe(struct platform_device *pdev)
+{
+	struct regmap *regmap;
+
+	regmap = qcom_cc_map(pdev, &ecpri_cc_qdu1000_desc);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	clk_lucid_evo_pll_configure(&ecpri_cc_pll0, regmap, &ecpri_cc_pll0_config);
+	clk_lucid_evo_pll_configure(&ecpri_cc_pll1, regmap, &ecpri_cc_pll1_config);
+
+	return qcom_cc_really_probe(pdev, &ecpri_cc_qdu1000_desc, regmap);
+}
+
+static struct platform_driver ecpri_cc_qdu1000_driver = {
+	.probe = ecpri_cc_qdu1000_probe,
+	.driver = {
+		.name = "ecpri_cc-qdu1000",
+		.of_match_table = ecpri_cc_qdu1000_match_table,
+	},
+};
+
+module_platform_driver(ecpri_cc_qdu1000_driver);
+
+MODULE_DESCRIPTION("QTI ECPRICC QDU1000 Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

