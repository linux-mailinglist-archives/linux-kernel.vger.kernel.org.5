Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350367740C7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbjHHRKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbjHHRKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:10:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76A96670F;
        Tue,  8 Aug 2023 09:04:05 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3784pYlh001169;
        Tue, 8 Aug 2023 05:15:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=nUrQ0D6fnq8jEPjNXK7/Dy3i5UGkVml9Bgmkhc089HA=;
 b=bLooe0cy9o3DMmVvpw+yaHR0eSk/NTakGtZd6nQS4t9UtAcNd5OfANXu5adqX+K3Jx06
 IXCcsPJ9JL20bLoI6uvYFJ1YW0OHgEfsYg2SDG3sMla6Yrfp1gXDTChf42zH1z2MmsEI
 APT6VA/pc5jjJWIIS6r2rcuMkw0rtQcxuARd+/+1wihC/kS6Bpw7tYyOgyQOwRiWWLwR
 v5hY2INdp0wtt/GTi/zOjHIn8p5E8ZiruyUGZU86ogPflGU6B9FfGbZrCf62EZ85xAeB
 5Fy+SOL8ZqsPQuD5SpekN8ly2GG64CaB2xGJL9c9nyyaBZ5Emq28VvK8bxEIY0X4D4DC MQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sb6pqgujp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 05:15:04 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3785F3D1012628
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Aug 2023 05:15:03 GMT
Received: from hu-imrashai-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 7 Aug 2023 22:14:58 -0700
From:   Imran Shaik <quic_imrashai@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     Taniya Das <quic_tdas@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
Subject: [PATCH 3/4] clk: qcom: Add ECPRICC driver support for QDU1000 and QRU1000
Date:   Tue, 8 Aug 2023 10:44:06 +0530
Message-ID: <20230808051407.647395-4-quic_imrashai@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230808051407.647395-1-quic_imrashai@quicinc.com>
References: <20230808051407.647395-1-quic_imrashai@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: G6QVu1ooiwFHeJf_dxEP-SuDGvEJFAqb
X-Proofpoint-ORIG-GUID: G6QVu1ooiwFHeJf_dxEP-SuDGvEJFAqb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_03,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308080046
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ECPRI Clock Controller (ECPRICC) support for QDU1000 and QRU1000 SoCs.

Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
---
 drivers/clk/qcom/Kconfig           |    8 +
 drivers/clk/qcom/Makefile          |    1 +
 drivers/clk/qcom/ecpricc-qdu1000.c | 3808 ++++++++++++++++++++++++++++
 3 files changed, 3817 insertions(+)
 create mode 100644 drivers/clk/qcom/ecpricc-qdu1000.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 04b55ab829d9..6d5889cd773a 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -659,6 +659,14 @@ config QDU_GCC_1000
 	  QRU1000 devices. Say Y if you want to use peripheral
 	  devices such as UART, SPI, I2C, USB, SD, PCIe, etc.
 
+config QDU_ECPRICC_1000
+	tristate "QDU1000/QRU1000 ECPRI Clock Controller"
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
index b5553be134f0..2adcd492c6f4 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -64,6 +64,7 @@ obj-$(CONFIG_QCM_DISPCC_2290) += dispcc-qcm2290.o
 obj-$(CONFIG_QCS_GCC_404) += gcc-qcs404.o
 obj-$(CONFIG_QCS_Q6SSTOP_404) += q6sstop-qcs404.o
 obj-$(CONFIG_QCS_TURING_404) += turingcc-qcs404.o
+obj-$(CONFIG_QDU_ECPRICC_1000) += ecpricc-qdu1000.o
 obj-$(CONFIG_QDU_GCC_1000) += gcc-qdu1000.o
 obj-$(CONFIG_SC_CAMCC_7180) += camcc-sc7180.o
 obj-$(CONFIG_SC_CAMCC_7280) += camcc-sc7280.o
diff --git a/drivers/clk/qcom/ecpricc-qdu1000.c b/drivers/clk/qcom/ecpricc-qdu1000.c
new file mode 100644
index 000000000000..bb8d5813b578
--- /dev/null
+++ b/drivers/clk/qcom/ecpricc-qdu1000.c
@@ -0,0 +1,3808 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of.h>
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
+	DT_ETH_PHY_0_LANE0_RX_CLK,
+	DT_ETH_PHY_0_LANE0_TX_CLK,
+	DT_ETH_PHY_0_LANE1_RX_CLK,
+	DT_ETH_PHY_0_LANE1_TX_CLK,
+	DT_ETH_PHY_0_LANE2_RX_CLK,
+	DT_ETH_PHY_0_LANE2_TX_CLK,
+	DT_ETH_PHY_0_LANE3_RX_CLK,
+	DT_ETH_PHY_0_LANE3_TX_CLK,
+	DT_ETH_PHY_0_OCK_SRAM_CLK,
+	DT_ETH_PHY_1_LANE0_RX_CLK,
+	DT_ETH_PHY_1_LANE0_TX_CLK,
+	DT_ETH_PHY_1_LANE1_RX_CLK,
+	DT_ETH_PHY_1_LANE1_TX_CLK,
+	DT_ETH_PHY_1_LANE2_RX_CLK,
+	DT_ETH_PHY_1_LANE2_TX_CLK,
+	DT_ETH_PHY_1_LANE3_RX_CLK,
+	DT_ETH_PHY_1_LANE3_TX_CLK,
+	DT_ETH_PHY_1_OCK_SRAM_CLK,
+	DT_ETH_PHY_2_LANE0_RX_CLK,
+	DT_ETH_PHY_2_LANE0_TX_CLK,
+	DT_ETH_PHY_2_LANE1_RX_CLK,
+	DT_ETH_PHY_2_LANE1_TX_CLK,
+	DT_ETH_PHY_2_LANE2_RX_CLK,
+	DT_ETH_PHY_2_LANE2_TX_CLK,
+	DT_ETH_PHY_2_LANE3_RX_CLK,
+	DT_ETH_PHY_2_LANE3_TX_CLK,
+	DT_ETH_PHY_2_OCK_SRAM_CLK,
+	DT_ETH_PHY_3_LANE0_RX_CLK,
+	DT_ETH_PHY_3_LANE0_TX_CLK,
+	DT_ETH_PHY_3_LANE1_RX_CLK,
+	DT_ETH_PHY_3_LANE1_TX_CLK,
+	DT_ETH_PHY_3_LANE2_RX_CLK,
+	DT_ETH_PHY_3_LANE2_TX_CLK,
+	DT_ETH_PHY_3_LANE3_RX_CLK,
+	DT_ETH_PHY_3_LANE3_TX_CLK,
+	DT_ETH_PHY_3_OCK_SRAM_CLK,
+	DT_ETH_PHY_4_LANE0_RX_CLK,
+	DT_ETH_PHY_4_LANE0_TX_CLK,
+	DT_ETH_PHY_4_LANE1_RX_CLK,
+	DT_ETH_PHY_4_LANE1_TX_CLK,
+	DT_ETH_PHY_4_LANE2_RX_CLK,
+	DT_ETH_PHY_4_LANE2_TX_CLK,
+	DT_ETH_PHY_4_LANE3_RX_CLK,
+	DT_ETH_PHY_4_LANE3_TX_CLK,
+	DT_ETH_PHY_4_OCK_SRAM_CLK,
+};
+
+enum {
+	P_BI_TCXO,
+	P_ECPRI_CC_PLL0_OUT_MAIN,
+	P_ECPRI_CC_PLL1_OUT_MAIN,
+	P_ETH_PHY_0_LANE0_RX_CLK,
+	P_ETH_PHY_0_LANE0_TX_CLK,
+	P_ETH_PHY_0_LANE1_RX_CLK,
+	P_ETH_PHY_0_LANE1_TX_CLK,
+	P_ETH_PHY_0_LANE2_RX_CLK,
+	P_ETH_PHY_0_LANE2_TX_CLK,
+	P_ETH_PHY_0_LANE3_RX_CLK,
+	P_ETH_PHY_0_LANE3_TX_CLK,
+	P_ETH_PHY_0_OCK_SRAM_CLK,
+	P_ETH_PHY_1_LANE0_RX_CLK,
+	P_ETH_PHY_1_LANE0_TX_CLK,
+	P_ETH_PHY_1_LANE1_RX_CLK,
+	P_ETH_PHY_1_LANE1_TX_CLK,
+	P_ETH_PHY_1_LANE2_RX_CLK,
+	P_ETH_PHY_1_LANE2_TX_CLK,
+	P_ETH_PHY_1_LANE3_RX_CLK,
+	P_ETH_PHY_1_LANE3_TX_CLK,
+	P_ETH_PHY_1_OCK_SRAM_CLK,
+	P_ETH_PHY_2_LANE0_RX_CLK,
+	P_ETH_PHY_2_LANE0_TX_CLK,
+	P_ETH_PHY_2_LANE1_RX_CLK,
+	P_ETH_PHY_2_LANE1_TX_CLK,
+	P_ETH_PHY_2_LANE2_RX_CLK,
+	P_ETH_PHY_2_LANE2_TX_CLK,
+	P_ETH_PHY_2_LANE3_RX_CLK,
+	P_ETH_PHY_2_LANE3_TX_CLK,
+	P_ETH_PHY_2_OCK_SRAM_CLK,
+	P_ETH_PHY_3_LANE0_RX_CLK,
+	P_ETH_PHY_3_LANE0_TX_CLK,
+	P_ETH_PHY_3_LANE1_RX_CLK,
+	P_ETH_PHY_3_LANE1_TX_CLK,
+	P_ETH_PHY_3_LANE2_RX_CLK,
+	P_ETH_PHY_3_LANE2_TX_CLK,
+	P_ETH_PHY_3_LANE3_RX_CLK,
+	P_ETH_PHY_3_LANE3_TX_CLK,
+	P_ETH_PHY_3_OCK_SRAM_CLK,
+	P_ETH_PHY_4_LANE0_RX_CLK,
+	P_ETH_PHY_4_LANE0_TX_CLK,
+	P_ETH_PHY_4_LANE1_RX_CLK,
+	P_ETH_PHY_4_LANE1_TX_CLK,
+	P_ETH_PHY_4_LANE2_RX_CLK,
+	P_ETH_PHY_4_LANE2_TX_CLK,
+	P_ETH_PHY_4_LANE3_RX_CLK,
+	P_ETH_PHY_4_LANE3_TX_CLK,
+	P_ETH_PHY_4_OCK_SRAM_CLK,
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
+static struct alpha_pll_config ecpri_cc_pll0_config = {
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
+static const struct parent_map ecpri_cc_parent_map_3[] = {
+	{ P_ETH_PHY_0_OCK_SRAM_CLK, 0 },
+	{ P_ECPRI_CC_PLL0_OUT_MAIN, 1 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_3[] = {
+	{ .index = DT_ETH_PHY_0_OCK_SRAM_CLK },
+	{ .hw = &ecpri_cc_pll0.clkr.hw },
+};
+
+static const struct parent_map ecpri_cc_parent_map_4[] = {
+	{ P_ETH_PHY_1_OCK_SRAM_CLK, 0 },
+	{ P_ECPRI_CC_PLL0_OUT_MAIN, 1 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_4[] = {
+	{ .index = DT_ETH_PHY_1_OCK_SRAM_CLK },
+	{ .hw = &ecpri_cc_pll0.clkr.hw },
+};
+
+static const struct parent_map ecpri_cc_parent_map_5[] = {
+	{ P_ETH_PHY_2_OCK_SRAM_CLK, 0 },
+	{ P_ECPRI_CC_PLL0_OUT_MAIN, 1 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_5[] = {
+	{ .index = DT_ETH_PHY_2_OCK_SRAM_CLK },
+	{ .hw = &ecpri_cc_pll0.clkr.hw },
+};
+
+static const struct parent_map ecpri_cc_parent_map_6[] = {
+	{ P_ETH_PHY_3_OCK_SRAM_CLK, 0 },
+	{ P_ECPRI_CC_PLL0_OUT_MAIN, 1 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_6[] = {
+	{ .index = DT_ETH_PHY_3_OCK_SRAM_CLK },
+	{ .hw = &ecpri_cc_pll0.clkr.hw },
+};
+
+static const struct parent_map ecpri_cc_parent_map_7[] = {
+	{ P_ETH_PHY_4_OCK_SRAM_CLK, 0 },
+	{ P_ECPRI_CC_PLL0_OUT_MAIN, 1 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_7[] = {
+	{ .index = DT_ETH_PHY_4_OCK_SRAM_CLK },
+	{ .hw = &ecpri_cc_pll0.clkr.hw },
+};
+
+static const struct parent_map ecpri_cc_parent_map_8[] = {
+	{ P_ETH_PHY_0_LANE0_RX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_8[] = {
+	{ .index = DT_ETH_PHY_0_LANE0_RX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_9[] = {
+	{ P_ETH_PHY_0_LANE0_TX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_9[] = {
+	{ .index = DT_ETH_PHY_0_LANE0_TX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_10[] = {
+	{ P_ETH_PHY_0_LANE1_RX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_10[] = {
+	{ .index = DT_ETH_PHY_0_LANE1_RX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_11[] = {
+	{ P_ETH_PHY_0_LANE1_TX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_11[] = {
+	{ .index = DT_ETH_PHY_0_LANE1_TX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_12[] = {
+	{ P_ETH_PHY_0_LANE2_RX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_12[] = {
+	{ .index = DT_ETH_PHY_0_LANE2_RX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_13[] = {
+	{ P_ETH_PHY_0_LANE2_TX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_13[] = {
+	{ .index = DT_ETH_PHY_0_LANE2_TX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_14[] = {
+	{ P_ETH_PHY_0_LANE3_RX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_14[] = {
+	{ .index = DT_ETH_PHY_0_LANE3_RX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_15[] = {
+	{ P_ETH_PHY_0_LANE3_TX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_15[] = {
+	{ .index = DT_ETH_PHY_0_LANE3_TX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_16[] = {
+	{ P_ETH_PHY_1_LANE0_RX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_16[] = {
+	{ .index = DT_ETH_PHY_1_LANE0_RX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_17[] = {
+	{ P_ETH_PHY_1_LANE0_TX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_17[] = {
+	{ .index = DT_ETH_PHY_1_LANE0_TX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_18[] = {
+	{ P_ETH_PHY_1_LANE1_RX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_18[] = {
+	{ .index = DT_ETH_PHY_1_LANE1_RX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_19[] = {
+	{ P_ETH_PHY_1_LANE1_TX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_19[] = {
+	{ .index = DT_ETH_PHY_1_LANE1_TX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_20[] = {
+	{ P_ETH_PHY_1_LANE2_RX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_20[] = {
+	{ .index = DT_ETH_PHY_1_LANE2_RX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_21[] = {
+	{ P_ETH_PHY_1_LANE2_TX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_21[] = {
+	{ .index = DT_ETH_PHY_1_LANE2_TX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_22[] = {
+	{ P_ETH_PHY_1_LANE3_RX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_22[] = {
+	{ .index = DT_ETH_PHY_1_LANE3_RX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_23[] = {
+	{ P_ETH_PHY_1_LANE3_TX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_23[] = {
+	{ .index = DT_ETH_PHY_1_LANE3_TX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_24[] = {
+	{ P_ETH_PHY_2_LANE0_RX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_24[] = {
+	{ .index = DT_ETH_PHY_2_LANE0_RX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_25[] = {
+	{ P_ETH_PHY_2_LANE0_TX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_25[] = {
+	{ .index = DT_ETH_PHY_2_LANE0_TX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_26[] = {
+	{ P_ETH_PHY_2_LANE1_RX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_26[] = {
+	{ .index = DT_ETH_PHY_2_LANE1_RX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_27[] = {
+	{ P_ETH_PHY_2_LANE1_TX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_27[] = {
+	{ .index = DT_ETH_PHY_2_LANE1_TX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_28[] = {
+	{ P_ETH_PHY_2_LANE2_RX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_28[] = {
+	{ .index = DT_ETH_PHY_2_LANE2_RX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_29[] = {
+	{ P_ETH_PHY_2_LANE2_TX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_29[] = {
+	{ .index = DT_ETH_PHY_2_LANE2_TX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_30[] = {
+	{ P_ETH_PHY_2_LANE3_RX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_30[] = {
+	{ .index = DT_ETH_PHY_2_LANE3_RX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_31[] = {
+	{ P_ETH_PHY_2_LANE3_TX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_31[] = {
+	{ .index = DT_ETH_PHY_2_LANE3_TX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_32[] = {
+	{ P_ETH_PHY_3_LANE0_RX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_32[] = {
+	{ .index = DT_ETH_PHY_3_LANE0_RX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_33[] = {
+	{ P_ETH_PHY_3_LANE0_TX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_33[] = {
+	{ .index = DT_ETH_PHY_3_LANE0_TX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_34[] = {
+	{ P_ETH_PHY_3_LANE1_RX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_34[] = {
+	{ .index = DT_ETH_PHY_3_LANE1_RX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_35[] = {
+	{ P_ETH_PHY_3_LANE1_TX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_35[] = {
+	{ .index = DT_ETH_PHY_3_LANE1_TX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_36[] = {
+	{ P_ETH_PHY_3_LANE2_RX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_36[] = {
+	{ .index = DT_ETH_PHY_3_LANE2_RX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_37[] = {
+	{ P_ETH_PHY_3_LANE2_TX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_37[] = {
+	{ .index = DT_ETH_PHY_3_LANE2_TX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_38[] = {
+	{ P_ETH_PHY_3_LANE3_RX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_38[] = {
+	{ .index = DT_ETH_PHY_3_LANE3_RX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_39[] = {
+	{ P_ETH_PHY_3_LANE3_TX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_39[] = {
+	{ .index = DT_ETH_PHY_3_LANE3_TX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_40[] = {
+	{ P_ETH_PHY_4_LANE0_RX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_40[] = {
+	{ .index = DT_ETH_PHY_4_LANE0_RX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_41[] = {
+	{ P_ETH_PHY_4_LANE0_TX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_41[] = {
+	{ .index = DT_ETH_PHY_4_LANE0_TX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_42[] = {
+	{ P_ETH_PHY_4_LANE1_RX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_42[] = {
+	{ .index = DT_ETH_PHY_4_LANE1_RX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_43[] = {
+	{ P_ETH_PHY_4_LANE1_TX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_43[] = {
+	{ .index = DT_ETH_PHY_4_LANE1_TX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_44[] = {
+	{ P_ETH_PHY_4_LANE2_RX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_44[] = {
+	{ .index = DT_ETH_PHY_4_LANE2_RX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_45[] = {
+	{ P_ETH_PHY_4_LANE2_TX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_45[] = {
+	{ .index = DT_ETH_PHY_4_LANE2_TX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_46[] = {
+	{ P_ETH_PHY_4_LANE3_RX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_46[] = {
+	{ .index = DT_ETH_PHY_4_LANE3_RX_CLK },
+};
+
+static const struct parent_map ecpri_cc_parent_map_47[] = {
+	{ P_ETH_PHY_4_LANE3_TX_CLK, 0 },
+};
+
+static const struct clk_parent_data ecpri_cc_parent_data_47[] = {
+	{ .index = DT_ETH_PHY_4_LANE3_TX_CLK },
+};
+
+static struct clk_regmap_mux ecpri_cc_eth_phy_0_ock_sram_mux_clk_src = {
+	.reg = 0xd168,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_3,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_phy_0_ock_sram_mux_clk_src",
+			.parent_data = ecpri_cc_parent_data_3,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_3),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_eth_phy_1_ock_sram_mux_clk_src = {
+	.reg = 0xd16c,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_4,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_phy_1_ock_sram_mux_clk_src",
+			.parent_data = ecpri_cc_parent_data_4,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_4),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_eth_phy_2_ock_sram_mux_clk_src = {
+	.reg = 0xd170,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_5,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_phy_2_ock_sram_mux_clk_src",
+			.parent_data = ecpri_cc_parent_data_5,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_5),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_eth_phy_3_ock_sram_mux_clk_src = {
+	.reg = 0xd174,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_6,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_phy_3_ock_sram_mux_clk_src",
+			.parent_data = ecpri_cc_parent_data_6,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_6),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_eth_phy_4_ock_sram_mux_clk_src = {
+	.reg = 0xd178,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_7,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_phy_4_ock_sram_mux_clk_src",
+			.parent_data = ecpri_cc_parent_data_7,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_7),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy0_lane0_rx_clk_src = {
+	.reg = 0xd0a0,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_8,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy0_lane0_rx_clk_src",
+			.parent_data = ecpri_cc_parent_data_8,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_8),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy0_lane0_tx_clk_src = {
+	.reg = 0xd0f0,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_9,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy0_lane0_tx_clk_src",
+			.parent_data = ecpri_cc_parent_data_9,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_9),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy0_lane1_rx_clk_src = {
+	.reg = 0xd0a4,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_10,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy0_lane1_rx_clk_src",
+			.parent_data = ecpri_cc_parent_data_10,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_10),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy0_lane1_tx_clk_src = {
+	.reg = 0xd0f4,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_11,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy0_lane1_tx_clk_src",
+			.parent_data = ecpri_cc_parent_data_11,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_11),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy0_lane2_rx_clk_src = {
+	.reg = 0xd0a8,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_12,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy0_lane2_rx_clk_src",
+			.parent_data = ecpri_cc_parent_data_12,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_12),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy0_lane2_tx_clk_src = {
+	.reg = 0xd0f8,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_13,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy0_lane2_tx_clk_src",
+			.parent_data = ecpri_cc_parent_data_13,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_13),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy0_lane3_rx_clk_src = {
+	.reg = 0xd0ac,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_14,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy0_lane3_rx_clk_src",
+			.parent_data = ecpri_cc_parent_data_14,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_14),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy0_lane3_tx_clk_src = {
+	.reg = 0xd0fc,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_15,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy0_lane3_tx_clk_src",
+			.parent_data = ecpri_cc_parent_data_15,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_15),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy1_lane0_rx_clk_src = {
+	.reg = 0xd0b0,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_16,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy1_lane0_rx_clk_src",
+			.parent_data = ecpri_cc_parent_data_16,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_16),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy1_lane0_tx_clk_src = {
+	.reg = 0xd100,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_17,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy1_lane0_tx_clk_src",
+			.parent_data = ecpri_cc_parent_data_17,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_17),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy1_lane1_rx_clk_src = {
+	.reg = 0xd0b4,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_18,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy1_lane1_rx_clk_src",
+			.parent_data = ecpri_cc_parent_data_18,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_18),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy1_lane1_tx_clk_src = {
+	.reg = 0xd104,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_19,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy1_lane1_tx_clk_src",
+			.parent_data = ecpri_cc_parent_data_19,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_19),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy1_lane2_rx_clk_src = {
+	.reg = 0xd0b8,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_20,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy1_lane2_rx_clk_src",
+			.parent_data = ecpri_cc_parent_data_20,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_20),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy1_lane2_tx_clk_src = {
+	.reg = 0xd108,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_21,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy1_lane2_tx_clk_src",
+			.parent_data = ecpri_cc_parent_data_21,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_21),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy1_lane3_rx_clk_src = {
+	.reg = 0xd0bc,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_22,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy1_lane3_rx_clk_src",
+			.parent_data = ecpri_cc_parent_data_22,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_22),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy1_lane3_tx_clk_src = {
+	.reg = 0xd10c,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_23,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy1_lane3_tx_clk_src",
+			.parent_data = ecpri_cc_parent_data_23,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_23),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy2_lane0_rx_clk_src = {
+	.reg = 0xd0c0,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_24,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy2_lane0_rx_clk_src",
+			.parent_data = ecpri_cc_parent_data_24,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_24),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy2_lane0_tx_clk_src = {
+	.reg = 0xd110,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_25,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy2_lane0_tx_clk_src",
+			.parent_data = ecpri_cc_parent_data_25,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_25),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy2_lane1_rx_clk_src = {
+	.reg = 0xd0c4,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_26,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy2_lane1_rx_clk_src",
+			.parent_data = ecpri_cc_parent_data_26,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_26),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy2_lane1_tx_clk_src = {
+	.reg = 0xd114,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_27,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy2_lane1_tx_clk_src",
+			.parent_data = ecpri_cc_parent_data_27,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_27),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy2_lane2_rx_clk_src = {
+	.reg = 0xd0c8,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_28,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy2_lane2_rx_clk_src",
+			.parent_data = ecpri_cc_parent_data_28,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_28),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy2_lane2_tx_clk_src = {
+	.reg = 0xd118,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_29,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy2_lane2_tx_clk_src",
+			.parent_data = ecpri_cc_parent_data_29,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_29),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy2_lane3_rx_clk_src = {
+	.reg = 0xd0cc,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_30,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy2_lane3_rx_clk_src",
+			.parent_data = ecpri_cc_parent_data_30,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_30),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy2_lane3_tx_clk_src = {
+	.reg = 0xd11c,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_31,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy2_lane3_tx_clk_src",
+			.parent_data = ecpri_cc_parent_data_31,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_31),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy3_lane0_rx_clk_src = {
+	.reg = 0xd0d0,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_32,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy3_lane0_rx_clk_src",
+			.parent_data = ecpri_cc_parent_data_32,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_32),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy3_lane0_tx_clk_src = {
+	.reg = 0xd120,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_33,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy3_lane0_tx_clk_src",
+			.parent_data = ecpri_cc_parent_data_33,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_33),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy3_lane1_rx_clk_src = {
+	.reg = 0xd0d4,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_34,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy3_lane1_rx_clk_src",
+			.parent_data = ecpri_cc_parent_data_34,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_34),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy3_lane1_tx_clk_src = {
+	.reg = 0xd124,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_35,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy3_lane1_tx_clk_src",
+			.parent_data = ecpri_cc_parent_data_35,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_35),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy3_lane2_rx_clk_src = {
+	.reg = 0xd0d8,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_36,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy3_lane2_rx_clk_src",
+			.parent_data = ecpri_cc_parent_data_36,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_36),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy3_lane2_tx_clk_src = {
+	.reg = 0xd128,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_37,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy3_lane2_tx_clk_src",
+			.parent_data = ecpri_cc_parent_data_37,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_37),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy3_lane3_rx_clk_src = {
+	.reg = 0xd0dc,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_38,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy3_lane3_rx_clk_src",
+			.parent_data = ecpri_cc_parent_data_38,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_38),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy3_lane3_tx_clk_src = {
+	.reg = 0xd12c,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_39,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy3_lane3_tx_clk_src",
+			.parent_data = ecpri_cc_parent_data_39,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_39),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy4_lane0_rx_clk_src = {
+	.reg = 0xd0e0,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_40,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy4_lane0_rx_clk_src",
+			.parent_data = ecpri_cc_parent_data_40,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_40),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy4_lane0_tx_clk_src = {
+	.reg = 0xd130,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_41,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy4_lane0_tx_clk_src",
+			.parent_data = ecpri_cc_parent_data_41,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_41),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy4_lane1_rx_clk_src = {
+	.reg = 0xd0e4,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_42,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy4_lane1_rx_clk_src",
+			.parent_data = ecpri_cc_parent_data_42,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_42),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy4_lane1_tx_clk_src = {
+	.reg = 0xd134,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_43,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy4_lane1_tx_clk_src",
+			.parent_data = ecpri_cc_parent_data_43,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_43),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy4_lane2_rx_clk_src = {
+	.reg = 0xd0e8,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_44,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy4_lane2_rx_clk_src",
+			.parent_data = ecpri_cc_parent_data_44,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_44),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy4_lane2_tx_clk_src = {
+	.reg = 0xd138,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_45,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy4_lane2_tx_clk_src",
+			.parent_data = ecpri_cc_parent_data_45,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_45),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy4_lane3_rx_clk_src = {
+	.reg = 0xd0ec,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_46,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy4_lane3_rx_clk_src",
+			.parent_data = ecpri_cc_parent_data_46,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_46),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux ecpri_cc_phy4_lane3_tx_clk_src = {
+	.reg = 0xd13c,
+	.shift = 0,
+	.width = 2,
+	.parent_map = ecpri_cc_parent_map_47,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_phy4_lane3_tx_clk_src",
+			.parent_data = ecpri_cc_parent_data_47,
+			.num_parents = ARRAY_SIZE(ecpri_cc_parent_data_47),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
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
+static struct clk_branch ecpri_cc_eth_100g_c2c_0_hm_ff_0_clk = {
+	.halt_reg = 0x80b4,
+	.halt_check = BRANCH_HALT,
+	.mem_enable_reg = 0x8410,
+	.mem_ack_reg = 0x8424,
+	.mem_enable_ack_bit = BIT(0),
+	.clkr = {
+		.enable_reg = 0x80b4,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_100g_c2c_0_hm_ff_0_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_eth_100g_c2c_hm_ff_0_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_mem_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_eth_100g_c2c_0_hm_ff_1_clk = {
+	.halt_reg = 0x80bc,
+	.halt_check = BRANCH_HALT,
+	.mem_enable_reg = 0x8410,
+	.mem_ack_reg = 0x8424,
+	.mem_enable_ack_bit = BIT(1),
+	.clkr = {
+		.enable_reg = 0x80bc,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_100g_c2c_0_hm_ff_1_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_eth_100g_c2c_hm_ff_1_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_mem_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_eth_100g_c2c_hm_macsec_clk = {
+	.halt_reg = 0x80ac,
+	.halt_check = BRANCH_HALT,
+	.mem_enable_reg = 0x8410,
+	.mem_ack_reg = 0x8424,
+	.mem_enable_ack_bit = BIT(4),
+	.clkr = {
+		.enable_reg = 0x80ac,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_100g_c2c_hm_macsec_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_eth_100g_c2c_hm_macsec_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_mem_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_eth_100g_dbg_c2c_hm_ff_0_clk = {
+	.halt_reg = 0x80d8,
+	.halt_check = BRANCH_HALT,
+	.mem_enable_reg = 0x8414,
+	.mem_ack_reg = 0x8428,
+	.mem_enable_ack_bit = BIT(0),
+	.clkr = {
+		.enable_reg = 0x80d8,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_100g_dbg_c2c_hm_ff_0_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_eth_100g_dbg_c2c_hm_ff_0_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_mem_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_eth_100g_dbg_c2c_hm_ff_1_clk = {
+	.halt_reg = 0x80e0,
+	.halt_check = BRANCH_HALT,
+	.mem_enable_reg = 0x8414,
+	.mem_ack_reg = 0x8428,
+	.mem_enable_ack_bit = BIT(1),
+	.clkr = {
+		.enable_reg = 0x80e0,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_100g_dbg_c2c_hm_ff_1_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_eth_100g_dbg_c2c_hm_ff_1_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_mem_ops,
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
+static struct clk_branch ecpri_cc_eth_100g_fh_0_hm_ff_0_clk = {
+	.halt_reg = 0x800c,
+	.halt_check = BRANCH_HALT,
+	.mem_enable_reg = 0x8404,
+	.mem_ack_reg = 0x8418,
+	.mem_enable_ack_bit = BIT(0),
+	.clkr = {
+		.enable_reg = 0x800c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_100g_fh_0_hm_ff_0_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_eth_100g_fh_0_hm_ff_0_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_mem_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_eth_100g_fh_0_hm_ff_1_clk = {
+	.halt_reg = 0x8014,
+	.halt_check = BRANCH_HALT,
+	.mem_enable_reg = 0x8404,
+	.mem_ack_reg = 0x8418,
+	.mem_enable_ack_bit = BIT(1),
+	.clkr = {
+		.enable_reg = 0x8014,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_100g_fh_0_hm_ff_1_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_eth_100g_fh_0_hm_ff_1_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_mem_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_eth_100g_fh_0_hm_ff_2_clk = {
+	.halt_reg = 0x801c,
+	.halt_check = BRANCH_HALT,
+	.mem_enable_reg = 0x8404,
+	.mem_ack_reg = 0x8418,
+	.mem_enable_ack_bit = BIT(2),
+	.clkr = {
+		.enable_reg = 0x801c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_100g_fh_0_hm_ff_2_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_eth_100g_fh_0_hm_ff_2_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_mem_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_eth_100g_fh_0_hm_ff_3_clk = {
+	.halt_reg = 0x8024,
+	.halt_check = BRANCH_HALT,
+	.mem_enable_reg = 0x8404,
+	.mem_ack_reg = 0x8418,
+	.mem_enable_ack_bit = BIT(3),
+	.clkr = {
+		.enable_reg = 0x8024,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_100g_fh_0_hm_ff_3_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_eth_100g_fh_0_hm_ff_3_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_mem_ops,
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
+static struct clk_branch ecpri_cc_eth_100g_fh_1_hm_ff_0_clk = {
+	.halt_reg = 0x8044,
+	.halt_check = BRANCH_HALT,
+	.mem_enable_reg = 0x8408,
+	.mem_ack_reg = 0x841C,
+	.mem_enable_ack_bit = BIT(0),
+	.clkr = {
+		.enable_reg = 0x8044,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_100g_fh_1_hm_ff_0_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_eth_100g_fh_1_hm_ff_0_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_mem_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_eth_100g_fh_1_hm_ff_1_clk = {
+	.halt_reg = 0x804c,
+	.halt_check = BRANCH_HALT,
+	.mem_enable_reg = 0x8408,
+	.mem_ack_reg = 0x841C,
+	.mem_enable_ack_bit = BIT(1),
+	.clkr = {
+		.enable_reg = 0x804c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_100g_fh_1_hm_ff_1_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_eth_100g_fh_1_hm_ff_1_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_mem_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_eth_100g_fh_1_hm_ff_2_clk = {
+	.halt_reg = 0x8054,
+	.halt_check = BRANCH_HALT,
+	.mem_enable_reg = 0x8408,
+	.mem_ack_reg = 0x841C,
+	.mem_enable_ack_bit = BIT(2),
+	.clkr = {
+		.enable_reg = 0x8054,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_100g_fh_1_hm_ff_2_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_eth_100g_fh_1_hm_ff_2_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_mem_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_eth_100g_fh_1_hm_ff_3_clk = {
+	.halt_reg = 0x805c,
+	.halt_check = BRANCH_HALT,
+	.mem_enable_reg = 0x8408,
+	.mem_ack_reg = 0x841C,
+	.mem_enable_ack_bit = BIT(3),
+	.clkr = {
+		.enable_reg = 0x805c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_100g_fh_1_hm_ff_3_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_eth_100g_fh_1_hm_ff_3_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_mem_ops,
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
+static struct clk_branch ecpri_cc_eth_100g_fh_2_hm_ff_0_clk = {
+	.halt_reg = 0x807c,
+	.halt_check = BRANCH_HALT,
+	.mem_enable_reg = 0x840C,
+	.mem_ack_reg = 0x8420,
+	.mem_enable_ack_bit = BIT(0),
+	.clkr = {
+		.enable_reg = 0x807c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_100g_fh_2_hm_ff_0_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_eth_100g_fh_2_hm_ff_0_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_mem_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_eth_100g_fh_2_hm_ff_1_clk = {
+	.halt_reg = 0x8084,
+	.halt_check = BRANCH_HALT,
+	.mem_enable_reg = 0x840C,
+	.mem_ack_reg = 0x8420,
+	.mem_enable_ack_bit = BIT(1),
+	.clkr = {
+		.enable_reg = 0x8084,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_100g_fh_2_hm_ff_1_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_eth_100g_fh_2_hm_ff_1_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_mem_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_eth_100g_fh_2_hm_ff_2_clk = {
+	.halt_reg = 0x808c,
+	.halt_check = BRANCH_HALT,
+	.mem_enable_reg = 0x840C,
+	.mem_ack_reg = 0x8420,
+	.mem_enable_ack_bit = BIT(2),
+	.clkr = {
+		.enable_reg = 0x808c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_100g_fh_2_hm_ff_2_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_eth_100g_fh_2_hm_ff_2_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_mem_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_eth_100g_fh_2_hm_ff_3_clk = {
+	.halt_reg = 0x8094,
+	.halt_check = BRANCH_HALT,
+	.mem_enable_reg = 0x840C,
+	.mem_ack_reg = 0x8420,
+	.mem_enable_ack_bit = BIT(3),
+	.clkr = {
+		.enable_reg = 0x8094,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_100g_fh_2_hm_ff_3_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_eth_100g_fh_2_hm_ff_3_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_mem_ops,
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
+static struct clk_branch ecpri_cc_eth_100g_fh_macsec_0_clk = {
+	.halt_reg = 0x8004,
+	.halt_check = BRANCH_HALT,
+	.mem_enable_reg = 0x8404,
+	.mem_ack_reg = 0x8418,
+	.mem_enable_ack_bit = BIT(4),
+	.clkr = {
+		.enable_reg = 0x8004,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_100g_fh_macsec_0_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_eth_100g_fh0_macsec_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_mem_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_eth_100g_fh_macsec_1_clk = {
+	.halt_reg = 0x803c,
+	.halt_check = BRANCH_HALT,
+	.mem_enable_reg = 0x8408,
+	.mem_ack_reg = 0x841C,
+	.mem_enable_ack_bit = BIT(4),
+	.clkr = {
+		.enable_reg = 0x803c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_100g_fh_macsec_1_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_eth_100g_fh1_macsec_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_mem_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_eth_100g_fh_macsec_2_clk = {
+	.halt_reg = 0x8074,
+	.halt_check = BRANCH_HALT,
+	.mem_enable_reg = 0x840C,
+	.mem_ack_reg = 0x8420,
+	.mem_enable_ack_bit = BIT(4),
+	.clkr = {
+		.enable_reg = 0x8074,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_100g_fh_macsec_2_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_eth_100g_fh2_macsec_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_mem_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_eth_100g_mac_c2c_hm_ref_clk = {
+	.halt_reg = 0x80c4,
+	.halt_check = BRANCH_HALT,
+	.mem_enable_reg = 0x8410,
+	.mem_ack_reg = 0x8424,
+	.mem_enable_ack_bit = BIT(5),
+	.clkr = {
+		.enable_reg = 0x80c4,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_100g_mac_c2c_hm_ref_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_eth_100g_mac_c2c_hm_ref_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_mem_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_eth_100g_mac_dbg_c2c_hm_ref_clk = {
+	.halt_reg = 0x80e8,
+	.halt_check = BRANCH_HALT,
+	.mem_enable_reg = 0x8414,
+	.mem_ack_reg = 0x8428,
+	.mem_enable_ack_bit = BIT(5),
+	.clkr = {
+		.enable_reg = 0x80e8,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_100g_mac_dbg_c2c_hm_ref_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_eth_100g_mac_dbg_c2c_hm_ref_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_mem_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_eth_100g_mac_fh0_hm_ref_clk = {
+	.halt_reg = 0x802c,
+	.halt_check = BRANCH_HALT,
+	.mem_enable_reg = 0x8404,
+	.mem_ack_reg = 0x8418,
+	.mem_enable_ack_bit = BIT(5),
+	.clkr = {
+		.enable_reg = 0x802c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_100g_mac_fh0_hm_ref_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_eth_100g_mac_fh0_hm_ref_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_mem_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_eth_100g_mac_fh1_hm_ref_clk = {
+	.halt_reg = 0x8064,
+	.halt_check = BRANCH_HALT,
+	.mem_enable_reg = 0x8408,
+	.mem_ack_reg = 0x841C,
+	.mem_enable_ack_bit = BIT(5),
+	.clkr = {
+		.enable_reg = 0x8064,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_100g_mac_fh1_hm_ref_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_eth_100g_mac_fh1_hm_ref_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_mem_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_eth_100g_mac_fh2_hm_ref_clk = {
+	.halt_reg = 0x809c,
+	.halt_check = BRANCH_HALT,
+	.mem_enable_reg = 0x840C,
+	.mem_ack_reg = 0x8420,
+	.mem_enable_ack_bit = BIT(5),
+	.clkr = {
+		.enable_reg = 0x809c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_100g_mac_fh2_hm_ref_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_eth_100g_mac_fh2_hm_ref_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_mem_ops,
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
+static struct clk_branch ecpri_cc_eth_phy_0_ock_sram_clk = {
+	.halt_reg = 0xd140,
+	.halt_check = BRANCH_HALT,
+	.mem_enable_reg = 0x8404,
+	.mem_ack_reg = 0x8418,
+	.mem_enable_ack_bit = BIT(6),
+	.clkr = {
+		.enable_reg = 0xd140,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_phy_0_ock_sram_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_eth_phy_0_ock_sram_mux_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_mem_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_eth_phy_1_ock_sram_clk = {
+	.halt_reg = 0xd148,
+	.halt_check = BRANCH_HALT,
+	.mem_enable_reg = 0x8408,
+	.mem_ack_reg = 0x841C,
+	.mem_enable_ack_bit = BIT(6),
+	.clkr = {
+		.enable_reg = 0xd148,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_phy_1_ock_sram_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_eth_phy_1_ock_sram_mux_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_mem_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_eth_phy_2_ock_sram_clk = {
+	.halt_reg = 0xd150,
+	.halt_check = BRANCH_HALT,
+	.mem_enable_reg = 0x840C,
+	.mem_ack_reg = 0x8420,
+	.mem_enable_ack_bit = BIT(6),
+	.clkr = {
+		.enable_reg = 0xd150,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_phy_2_ock_sram_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_eth_phy_2_ock_sram_mux_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_mem_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_eth_phy_3_ock_sram_clk = {
+	.halt_reg = 0xd158,
+	.halt_check = BRANCH_HALT,
+	.mem_enable_reg = 0x8410,
+	.mem_ack_reg = 0x8424,
+	.mem_enable_ack_bit = BIT(6),
+	.clkr = {
+		.enable_reg = 0xd158,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_phy_3_ock_sram_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_eth_phy_3_ock_sram_mux_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_mem_ops,
+		},
+	},
+};
+
+static struct clk_branch ecpri_cc_eth_phy_4_ock_sram_clk = {
+	.halt_reg = 0xd160,
+	.halt_check = BRANCH_HALT,
+	.mem_enable_reg = 0x8414,
+	.mem_ack_reg = 0x8428,
+	.mem_enable_ack_bit = BIT(6),
+	.clkr = {
+		.enable_reg = 0xd160,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "ecpri_cc_eth_phy_4_ock_sram_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_eth_phy_4_ock_sram_mux_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_mem_ops,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy0_lane0_rx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy0_lane0_tx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy0_lane1_rx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy0_lane1_tx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy0_lane2_rx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy0_lane2_tx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy0_lane3_rx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy0_lane3_tx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy1_lane0_rx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy1_lane0_tx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy1_lane1_rx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy1_lane1_tx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy1_lane2_rx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy1_lane2_tx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy1_lane3_rx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy1_lane3_tx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy2_lane0_rx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy2_lane0_tx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy2_lane1_rx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy2_lane1_tx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy2_lane2_rx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy2_lane2_tx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy2_lane3_rx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy2_lane3_tx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy3_lane0_rx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy3_lane0_tx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy3_lane1_rx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy3_lane1_tx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy3_lane2_rx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy3_lane2_tx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy3_lane3_rx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy3_lane3_tx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy4_lane0_rx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy4_lane0_tx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy4_lane1_rx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy4_lane1_tx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy4_lane2_rx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy4_lane2_tx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy4_lane3_rx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&ecpri_cc_phy4_lane3_tx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
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
+	[ECPRI_CC_ETH_100G_C2C_0_HM_FF_0_CLK] = &ecpri_cc_eth_100g_c2c_0_hm_ff_0_clk.clkr,
+	[ECPRI_CC_ETH_100G_C2C_0_HM_FF_1_CLK] = &ecpri_cc_eth_100g_c2c_0_hm_ff_1_clk.clkr,
+	[ECPRI_CC_ETH_100G_C2C_HM_FF_0_DIV_CLK_SRC] =
+		&ecpri_cc_eth_100g_c2c_hm_ff_0_div_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_C2C_HM_FF_1_DIV_CLK_SRC] =
+		&ecpri_cc_eth_100g_c2c_hm_ff_1_div_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_C2C_HM_MACSEC_CLK] = &ecpri_cc_eth_100g_c2c_hm_macsec_clk.clkr,
+	[ECPRI_CC_ETH_100G_C2C_HM_MACSEC_CLK_SRC] = &ecpri_cc_eth_100g_c2c_hm_macsec_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_DBG_C2C_HM_FF_0_CLK] = &ecpri_cc_eth_100g_dbg_c2c_hm_ff_0_clk.clkr,
+	[ECPRI_CC_ETH_100G_DBG_C2C_HM_FF_0_DIV_CLK_SRC] =
+		&ecpri_cc_eth_100g_dbg_c2c_hm_ff_0_div_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_DBG_C2C_HM_FF_1_CLK] = &ecpri_cc_eth_100g_dbg_c2c_hm_ff_1_clk.clkr,
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
+	[ECPRI_CC_ETH_100G_FH_0_HM_FF_0_CLK] = &ecpri_cc_eth_100g_fh_0_hm_ff_0_clk.clkr,
+	[ECPRI_CC_ETH_100G_FH_0_HM_FF_0_DIV_CLK_SRC] =
+		&ecpri_cc_eth_100g_fh_0_hm_ff_0_div_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_FH_0_HM_FF_1_CLK] = &ecpri_cc_eth_100g_fh_0_hm_ff_1_clk.clkr,
+	[ECPRI_CC_ETH_100G_FH_0_HM_FF_1_DIV_CLK_SRC] =
+		&ecpri_cc_eth_100g_fh_0_hm_ff_1_div_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_FH_0_HM_FF_2_CLK] = &ecpri_cc_eth_100g_fh_0_hm_ff_2_clk.clkr,
+	[ECPRI_CC_ETH_100G_FH_0_HM_FF_2_DIV_CLK_SRC] =
+		&ecpri_cc_eth_100g_fh_0_hm_ff_2_div_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_FH_0_HM_FF_3_CLK] = &ecpri_cc_eth_100g_fh_0_hm_ff_3_clk.clkr,
+	[ECPRI_CC_ETH_100G_FH_0_HM_FF_3_DIV_CLK_SRC] =
+		&ecpri_cc_eth_100g_fh_0_hm_ff_3_div_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_FH_0_UDP_FIFO_CLK] = &ecpri_cc_eth_100g_fh_0_udp_fifo_clk.clkr,
+	[ECPRI_CC_ETH_100G_FH_1_HM_FF_0_CLK] = &ecpri_cc_eth_100g_fh_1_hm_ff_0_clk.clkr,
+	[ECPRI_CC_ETH_100G_FH_1_HM_FF_0_DIV_CLK_SRC] =
+		&ecpri_cc_eth_100g_fh_1_hm_ff_0_div_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_FH_1_HM_FF_1_CLK] = &ecpri_cc_eth_100g_fh_1_hm_ff_1_clk.clkr,
+	[ECPRI_CC_ETH_100G_FH_1_HM_FF_1_DIV_CLK_SRC] =
+		&ecpri_cc_eth_100g_fh_1_hm_ff_1_div_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_FH_1_HM_FF_2_CLK] = &ecpri_cc_eth_100g_fh_1_hm_ff_2_clk.clkr,
+	[ECPRI_CC_ETH_100G_FH_1_HM_FF_2_DIV_CLK_SRC] =
+		&ecpri_cc_eth_100g_fh_1_hm_ff_2_div_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_FH_1_HM_FF_3_CLK] = &ecpri_cc_eth_100g_fh_1_hm_ff_3_clk.clkr,
+	[ECPRI_CC_ETH_100G_FH_1_HM_FF_3_DIV_CLK_SRC] =
+		&ecpri_cc_eth_100g_fh_1_hm_ff_3_div_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_FH_1_UDP_FIFO_CLK] = &ecpri_cc_eth_100g_fh_1_udp_fifo_clk.clkr,
+	[ECPRI_CC_ETH_100G_FH_2_HM_FF_0_CLK] = &ecpri_cc_eth_100g_fh_2_hm_ff_0_clk.clkr,
+	[ECPRI_CC_ETH_100G_FH_2_HM_FF_0_DIV_CLK_SRC] =
+		&ecpri_cc_eth_100g_fh_2_hm_ff_0_div_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_FH_2_HM_FF_1_CLK] = &ecpri_cc_eth_100g_fh_2_hm_ff_1_clk.clkr,
+	[ECPRI_CC_ETH_100G_FH_2_HM_FF_1_DIV_CLK_SRC] =
+		&ecpri_cc_eth_100g_fh_2_hm_ff_1_div_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_FH_2_HM_FF_2_CLK] = &ecpri_cc_eth_100g_fh_2_hm_ff_2_clk.clkr,
+	[ECPRI_CC_ETH_100G_FH_2_HM_FF_2_DIV_CLK_SRC] =
+		&ecpri_cc_eth_100g_fh_2_hm_ff_2_div_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_FH_2_HM_FF_3_CLK] = &ecpri_cc_eth_100g_fh_2_hm_ff_3_clk.clkr,
+	[ECPRI_CC_ETH_100G_FH_2_HM_FF_3_DIV_CLK_SRC] =
+		&ecpri_cc_eth_100g_fh_2_hm_ff_3_div_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_FH_2_UDP_FIFO_CLK] = &ecpri_cc_eth_100g_fh_2_udp_fifo_clk.clkr,
+	[ECPRI_CC_ETH_100G_FH_MACSEC_0_CLK] = &ecpri_cc_eth_100g_fh_macsec_0_clk.clkr,
+	[ECPRI_CC_ETH_100G_FH_MACSEC_1_CLK] = &ecpri_cc_eth_100g_fh_macsec_1_clk.clkr,
+	[ECPRI_CC_ETH_100G_FH_MACSEC_2_CLK] = &ecpri_cc_eth_100g_fh_macsec_2_clk.clkr,
+	[ECPRI_CC_ETH_100G_MAC_C2C_HM_REF_CLK] = &ecpri_cc_eth_100g_mac_c2c_hm_ref_clk.clkr,
+	[ECPRI_CC_ETH_100G_MAC_C2C_HM_REF_CLK_SRC] = &ecpri_cc_eth_100g_mac_c2c_hm_ref_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_MAC_DBG_C2C_HM_REF_CLK] = &ecpri_cc_eth_100g_mac_dbg_c2c_hm_ref_clk.clkr,
+	[ECPRI_CC_ETH_100G_MAC_DBG_C2C_HM_REF_CLK_SRC] =
+		&ecpri_cc_eth_100g_mac_dbg_c2c_hm_ref_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_MAC_FH0_HM_REF_CLK] = &ecpri_cc_eth_100g_mac_fh0_hm_ref_clk.clkr,
+	[ECPRI_CC_ETH_100G_MAC_FH0_HM_REF_CLK_SRC] = &ecpri_cc_eth_100g_mac_fh0_hm_ref_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_MAC_FH1_HM_REF_CLK] = &ecpri_cc_eth_100g_mac_fh1_hm_ref_clk.clkr,
+	[ECPRI_CC_ETH_100G_MAC_FH1_HM_REF_CLK_SRC] = &ecpri_cc_eth_100g_mac_fh1_hm_ref_clk_src.clkr,
+	[ECPRI_CC_ETH_100G_MAC_FH2_HM_REF_CLK] = &ecpri_cc_eth_100g_mac_fh2_hm_ref_clk.clkr,
+	[ECPRI_CC_ETH_100G_MAC_FH2_HM_REF_CLK_SRC] = &ecpri_cc_eth_100g_mac_fh2_hm_ref_clk_src.clkr,
+	[ECPRI_CC_ETH_DBG_NFAPI_AXI_CLK] = &ecpri_cc_eth_dbg_nfapi_axi_clk.clkr,
+	[ECPRI_CC_ETH_DBG_NOC_AXI_CLK] = &ecpri_cc_eth_dbg_noc_axi_clk.clkr,
+	[ECPRI_CC_ETH_PHY_0_OCK_SRAM_CLK] = &ecpri_cc_eth_phy_0_ock_sram_clk.clkr,
+	[ECPRI_CC_ETH_PHY_0_OCK_SRAM_MUX_CLK_SRC] = &ecpri_cc_eth_phy_0_ock_sram_mux_clk_src.clkr,
+	[ECPRI_CC_ETH_PHY_1_OCK_SRAM_CLK] = &ecpri_cc_eth_phy_1_ock_sram_clk.clkr,
+	[ECPRI_CC_ETH_PHY_1_OCK_SRAM_MUX_CLK_SRC] = &ecpri_cc_eth_phy_1_ock_sram_mux_clk_src.clkr,
+	[ECPRI_CC_ETH_PHY_2_OCK_SRAM_CLK] = &ecpri_cc_eth_phy_2_ock_sram_clk.clkr,
+	[ECPRI_CC_ETH_PHY_2_OCK_SRAM_MUX_CLK_SRC] = &ecpri_cc_eth_phy_2_ock_sram_mux_clk_src.clkr,
+	[ECPRI_CC_ETH_PHY_3_OCK_SRAM_CLK] = &ecpri_cc_eth_phy_3_ock_sram_clk.clkr,
+	[ECPRI_CC_ETH_PHY_3_OCK_SRAM_MUX_CLK_SRC] = &ecpri_cc_eth_phy_3_ock_sram_mux_clk_src.clkr,
+	[ECPRI_CC_ETH_PHY_4_OCK_SRAM_CLK] = &ecpri_cc_eth_phy_4_ock_sram_clk.clkr,
+	[ECPRI_CC_ETH_PHY_4_OCK_SRAM_MUX_CLK_SRC] = &ecpri_cc_eth_phy_4_ock_sram_mux_clk_src.clkr,
+	[ECPRI_CC_MSS_EMAC_CLK] = &ecpri_cc_mss_emac_clk.clkr,
+	[ECPRI_CC_MSS_EMAC_CLK_SRC] = &ecpri_cc_mss_emac_clk_src.clkr,
+	[ECPRI_CC_MSS_ORAN_CLK] = &ecpri_cc_mss_oran_clk.clkr,
+	[ECPRI_CC_PHY0_LANE0_RX_CLK] = &ecpri_cc_phy0_lane0_rx_clk.clkr,
+	[ECPRI_CC_PHY0_LANE0_RX_CLK_SRC] = &ecpri_cc_phy0_lane0_rx_clk_src.clkr,
+	[ECPRI_CC_PHY0_LANE0_TX_CLK] = &ecpri_cc_phy0_lane0_tx_clk.clkr,
+	[ECPRI_CC_PHY0_LANE0_TX_CLK_SRC] = &ecpri_cc_phy0_lane0_tx_clk_src.clkr,
+	[ECPRI_CC_PHY0_LANE1_RX_CLK] = &ecpri_cc_phy0_lane1_rx_clk.clkr,
+	[ECPRI_CC_PHY0_LANE1_RX_CLK_SRC] = &ecpri_cc_phy0_lane1_rx_clk_src.clkr,
+	[ECPRI_CC_PHY0_LANE1_TX_CLK] = &ecpri_cc_phy0_lane1_tx_clk.clkr,
+	[ECPRI_CC_PHY0_LANE1_TX_CLK_SRC] = &ecpri_cc_phy0_lane1_tx_clk_src.clkr,
+	[ECPRI_CC_PHY0_LANE2_RX_CLK] = &ecpri_cc_phy0_lane2_rx_clk.clkr,
+	[ECPRI_CC_PHY0_LANE2_RX_CLK_SRC] = &ecpri_cc_phy0_lane2_rx_clk_src.clkr,
+	[ECPRI_CC_PHY0_LANE2_TX_CLK] = &ecpri_cc_phy0_lane2_tx_clk.clkr,
+	[ECPRI_CC_PHY0_LANE2_TX_CLK_SRC] = &ecpri_cc_phy0_lane2_tx_clk_src.clkr,
+	[ECPRI_CC_PHY0_LANE3_RX_CLK] = &ecpri_cc_phy0_lane3_rx_clk.clkr,
+	[ECPRI_CC_PHY0_LANE3_RX_CLK_SRC] = &ecpri_cc_phy0_lane3_rx_clk_src.clkr,
+	[ECPRI_CC_PHY0_LANE3_TX_CLK] = &ecpri_cc_phy0_lane3_tx_clk.clkr,
+	[ECPRI_CC_PHY0_LANE3_TX_CLK_SRC] = &ecpri_cc_phy0_lane3_tx_clk_src.clkr,
+	[ECPRI_CC_PHY1_LANE0_RX_CLK] = &ecpri_cc_phy1_lane0_rx_clk.clkr,
+	[ECPRI_CC_PHY1_LANE0_RX_CLK_SRC] = &ecpri_cc_phy1_lane0_rx_clk_src.clkr,
+	[ECPRI_CC_PHY1_LANE0_TX_CLK] = &ecpri_cc_phy1_lane0_tx_clk.clkr,
+	[ECPRI_CC_PHY1_LANE0_TX_CLK_SRC] = &ecpri_cc_phy1_lane0_tx_clk_src.clkr,
+	[ECPRI_CC_PHY1_LANE1_RX_CLK] = &ecpri_cc_phy1_lane1_rx_clk.clkr,
+	[ECPRI_CC_PHY1_LANE1_RX_CLK_SRC] = &ecpri_cc_phy1_lane1_rx_clk_src.clkr,
+	[ECPRI_CC_PHY1_LANE1_TX_CLK] = &ecpri_cc_phy1_lane1_tx_clk.clkr,
+	[ECPRI_CC_PHY1_LANE1_TX_CLK_SRC] = &ecpri_cc_phy1_lane1_tx_clk_src.clkr,
+	[ECPRI_CC_PHY1_LANE2_RX_CLK] = &ecpri_cc_phy1_lane2_rx_clk.clkr,
+	[ECPRI_CC_PHY1_LANE2_RX_CLK_SRC] = &ecpri_cc_phy1_lane2_rx_clk_src.clkr,
+	[ECPRI_CC_PHY1_LANE2_TX_CLK] = &ecpri_cc_phy1_lane2_tx_clk.clkr,
+	[ECPRI_CC_PHY1_LANE2_TX_CLK_SRC] = &ecpri_cc_phy1_lane2_tx_clk_src.clkr,
+	[ECPRI_CC_PHY1_LANE3_RX_CLK] = &ecpri_cc_phy1_lane3_rx_clk.clkr,
+	[ECPRI_CC_PHY1_LANE3_RX_CLK_SRC] = &ecpri_cc_phy1_lane3_rx_clk_src.clkr,
+	[ECPRI_CC_PHY1_LANE3_TX_CLK] = &ecpri_cc_phy1_lane3_tx_clk.clkr,
+	[ECPRI_CC_PHY1_LANE3_TX_CLK_SRC] = &ecpri_cc_phy1_lane3_tx_clk_src.clkr,
+	[ECPRI_CC_PHY2_LANE0_RX_CLK] = &ecpri_cc_phy2_lane0_rx_clk.clkr,
+	[ECPRI_CC_PHY2_LANE0_RX_CLK_SRC] = &ecpri_cc_phy2_lane0_rx_clk_src.clkr,
+	[ECPRI_CC_PHY2_LANE0_TX_CLK] = &ecpri_cc_phy2_lane0_tx_clk.clkr,
+	[ECPRI_CC_PHY2_LANE0_TX_CLK_SRC] = &ecpri_cc_phy2_lane0_tx_clk_src.clkr,
+	[ECPRI_CC_PHY2_LANE1_RX_CLK] = &ecpri_cc_phy2_lane1_rx_clk.clkr,
+	[ECPRI_CC_PHY2_LANE1_RX_CLK_SRC] = &ecpri_cc_phy2_lane1_rx_clk_src.clkr,
+	[ECPRI_CC_PHY2_LANE1_TX_CLK] = &ecpri_cc_phy2_lane1_tx_clk.clkr,
+	[ECPRI_CC_PHY2_LANE1_TX_CLK_SRC] = &ecpri_cc_phy2_lane1_tx_clk_src.clkr,
+	[ECPRI_CC_PHY2_LANE2_RX_CLK] = &ecpri_cc_phy2_lane2_rx_clk.clkr,
+	[ECPRI_CC_PHY2_LANE2_RX_CLK_SRC] = &ecpri_cc_phy2_lane2_rx_clk_src.clkr,
+	[ECPRI_CC_PHY2_LANE2_TX_CLK] = &ecpri_cc_phy2_lane2_tx_clk.clkr,
+	[ECPRI_CC_PHY2_LANE2_TX_CLK_SRC] = &ecpri_cc_phy2_lane2_tx_clk_src.clkr,
+	[ECPRI_CC_PHY2_LANE3_RX_CLK] = &ecpri_cc_phy2_lane3_rx_clk.clkr,
+	[ECPRI_CC_PHY2_LANE3_RX_CLK_SRC] = &ecpri_cc_phy2_lane3_rx_clk_src.clkr,
+	[ECPRI_CC_PHY2_LANE3_TX_CLK] = &ecpri_cc_phy2_lane3_tx_clk.clkr,
+	[ECPRI_CC_PHY2_LANE3_TX_CLK_SRC] = &ecpri_cc_phy2_lane3_tx_clk_src.clkr,
+	[ECPRI_CC_PHY3_LANE0_RX_CLK] = &ecpri_cc_phy3_lane0_rx_clk.clkr,
+	[ECPRI_CC_PHY3_LANE0_RX_CLK_SRC] = &ecpri_cc_phy3_lane0_rx_clk_src.clkr,
+	[ECPRI_CC_PHY3_LANE0_TX_CLK] = &ecpri_cc_phy3_lane0_tx_clk.clkr,
+	[ECPRI_CC_PHY3_LANE0_TX_CLK_SRC] = &ecpri_cc_phy3_lane0_tx_clk_src.clkr,
+	[ECPRI_CC_PHY3_LANE1_RX_CLK] = &ecpri_cc_phy3_lane1_rx_clk.clkr,
+	[ECPRI_CC_PHY3_LANE1_RX_CLK_SRC] = &ecpri_cc_phy3_lane1_rx_clk_src.clkr,
+	[ECPRI_CC_PHY3_LANE1_TX_CLK] = &ecpri_cc_phy3_lane1_tx_clk.clkr,
+	[ECPRI_CC_PHY3_LANE1_TX_CLK_SRC] = &ecpri_cc_phy3_lane1_tx_clk_src.clkr,
+	[ECPRI_CC_PHY3_LANE2_RX_CLK] = &ecpri_cc_phy3_lane2_rx_clk.clkr,
+	[ECPRI_CC_PHY3_LANE2_RX_CLK_SRC] = &ecpri_cc_phy3_lane2_rx_clk_src.clkr,
+	[ECPRI_CC_PHY3_LANE2_TX_CLK] = &ecpri_cc_phy3_lane2_tx_clk.clkr,
+	[ECPRI_CC_PHY3_LANE2_TX_CLK_SRC] = &ecpri_cc_phy3_lane2_tx_clk_src.clkr,
+	[ECPRI_CC_PHY3_LANE3_RX_CLK] = &ecpri_cc_phy3_lane3_rx_clk.clkr,
+	[ECPRI_CC_PHY3_LANE3_RX_CLK_SRC] = &ecpri_cc_phy3_lane3_rx_clk_src.clkr,
+	[ECPRI_CC_PHY3_LANE3_TX_CLK] = &ecpri_cc_phy3_lane3_tx_clk.clkr,
+	[ECPRI_CC_PHY3_LANE3_TX_CLK_SRC] = &ecpri_cc_phy3_lane3_tx_clk_src.clkr,
+	[ECPRI_CC_PHY4_LANE0_RX_CLK] = &ecpri_cc_phy4_lane0_rx_clk.clkr,
+	[ECPRI_CC_PHY4_LANE0_RX_CLK_SRC] = &ecpri_cc_phy4_lane0_rx_clk_src.clkr,
+	[ECPRI_CC_PHY4_LANE0_TX_CLK] = &ecpri_cc_phy4_lane0_tx_clk.clkr,
+	[ECPRI_CC_PHY4_LANE0_TX_CLK_SRC] = &ecpri_cc_phy4_lane0_tx_clk_src.clkr,
+	[ECPRI_CC_PHY4_LANE1_RX_CLK] = &ecpri_cc_phy4_lane1_rx_clk.clkr,
+	[ECPRI_CC_PHY4_LANE1_RX_CLK_SRC] = &ecpri_cc_phy4_lane1_rx_clk_src.clkr,
+	[ECPRI_CC_PHY4_LANE1_TX_CLK] = &ecpri_cc_phy4_lane1_tx_clk.clkr,
+	[ECPRI_CC_PHY4_LANE1_TX_CLK_SRC] = &ecpri_cc_phy4_lane1_tx_clk_src.clkr,
+	[ECPRI_CC_PHY4_LANE2_RX_CLK] = &ecpri_cc_phy4_lane2_rx_clk.clkr,
+	[ECPRI_CC_PHY4_LANE2_RX_CLK_SRC] = &ecpri_cc_phy4_lane2_rx_clk_src.clkr,
+	[ECPRI_CC_PHY4_LANE2_TX_CLK] = &ecpri_cc_phy4_lane2_tx_clk.clkr,
+	[ECPRI_CC_PHY4_LANE2_TX_CLK_SRC] = &ecpri_cc_phy4_lane2_tx_clk_src.clkr,
+	[ECPRI_CC_PHY4_LANE3_RX_CLK] = &ecpri_cc_phy4_lane3_rx_clk.clkr,
+	[ECPRI_CC_PHY4_LANE3_RX_CLK_SRC] = &ecpri_cc_phy4_lane3_rx_clk_src.clkr,
+	[ECPRI_CC_PHY4_LANE3_TX_CLK] = &ecpri_cc_phy4_lane3_tx_clk.clkr,
+	[ECPRI_CC_PHY4_LANE3_TX_CLK_SRC] = &ecpri_cc_phy4_lane3_tx_clk_src.clkr,
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
+static int __init ecpri_cc_qdu1000_init(void)
+{
+	return platform_driver_register(&ecpri_cc_qdu1000_driver);
+}
+subsys_initcall(ecpri_cc_qdu1000_init);
+
+static void __exit ecpri_cc_qdu1000_exit(void)
+{
+	platform_driver_unregister(&ecpri_cc_qdu1000_driver);
+}
+module_exit(ecpri_cc_qdu1000_exit);
+
+MODULE_DESCRIPTION("QTI ECPRICC QDU1000 Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

