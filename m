Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC57176AB76
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjHAIzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjHAIy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:54:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAFE1FCB;
        Tue,  1 Aug 2023 01:54:36 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37189xQq000878;
        Tue, 1 Aug 2023 08:54:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=+k5tzeDtSBfpScsuZE53PB9FXKFEgp+Cp9QVJmts9Jw=;
 b=IbY1wl2A5xYQzKxgwxuq/FrplovaSDgs30+zat2ZKxzk2GJ7mDktq8/yqwDkxpvTURWZ
 2GVhVbT3EzB5hsmPzEjrdmcugclVD9/tELD4qPnOJP1BjEJNXcQ6bicML1ovWs5Y3atG
 wrUBF41tGdPJ1LHBQoeda/lrmvzKfRwpInwhFvNlfqrbxOsuHBDNVLw+VW5g9AbA6i21
 9rUaDCsrkSO0E6AcaDUKT86qJC++E9cNM6Iy8jKIqOWCJ33A+8vIF+TN7pgbqjbjWR0r
 yUqOsqz80xcOoYEziaeCKKfEXVbpIhaAxH51noIYUqKczyAoaONZ3ONSgsa4vXgU0NpC 9w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6d8gthc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 08:54:25 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3718sNeJ007334
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 1 Aug 2023 08:54:23 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 1 Aug 2023 01:54:19 -0700
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <p.zabel@pengutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>, Luo Jie <quic_luoj@quicinc.com>
Subject: [PATCH 3/3] clk: qcom: add clock controller driver for qca8386/qca8084
Date:   Tue, 1 Aug 2023 16:53:52 +0800
Message-ID: <20230801085352.22873-4-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230801085352.22873-1-quic_luoj@quicinc.com>
References: <20230801085352.22873-1-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: O3ZWkOLP0KhfSqC59uS_ZMdQwd-lTQ5U
X-Proofpoint-GUID: O3ZWkOLP0KhfSqC59uS_ZMdQwd-lTQ5U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_03,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308010080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock & reset controller driver for qca8386/qca8084.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/clk/qcom/Kconfig       |    8 +
 drivers/clk/qcom/Makefile      |    1 +
 drivers/clk/qcom/nsscc-qca8k.c | 2205 ++++++++++++++++++++++++++++++++
 3 files changed, 2214 insertions(+)
 create mode 100644 drivers/clk/qcom/nsscc-qca8k.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 263e55d75e3f..a17e8fa5a7e1 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -195,6 +195,14 @@ config IPQ_GCC_9574
 	  i2c, USB, SD/eMMC, etc. Select this for the root clock
 	  of ipq9574.
 
+config IPQ_NSSCC_QCA8K
+        tristate "QCA8K(QCA8386 or QCA8084) NSS Clock Controller"
+        help
+          Support for NSS(Network SubSystem) clock controller on
+	  qca8386/qca8084 chip.
+	  Say Y if you want to use network function of switch or PHY
+	  function. Select this for the root clock of qca8xxx.
+
 config MSM_GCC_8660
 	tristate "MSM8660 Global Clock Controller"
 	depends on ARM || COMPILE_TEST
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index e6e294274c35..17238177c39d 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_IPQ_GCC_6018) += gcc-ipq6018.o
 obj-$(CONFIG_IPQ_GCC_806X) += gcc-ipq806x.o
 obj-$(CONFIG_IPQ_GCC_8074) += gcc-ipq8074.o
 obj-$(CONFIG_IPQ_GCC_9574) += gcc-ipq9574.o
+obj-$(CONFIG_IPQ_NSSCC_QCA8K) += nsscc-qca8k.o
 obj-$(CONFIG_IPQ_LCC_806X) += lcc-ipq806x.o
 obj-$(CONFIG_MDM_GCC_9607) += gcc-mdm9607.o
 obj-$(CONFIG_MDM_GCC_9615) += gcc-mdm9615.o
diff --git a/drivers/clk/qcom/nsscc-qca8k.c b/drivers/clk/qcom/nsscc-qca8k.c
new file mode 100644
index 000000000000..1bc8480b3a0b
--- /dev/null
+++ b/drivers/clk/qcom/nsscc-qca8k.c
@@ -0,0 +1,2205 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/phy.h>
+
+#include <dt-bindings/clock/qcom,nsscc-qca8k.h>
+#include <dt-bindings/reset/qcom,nsscc-qca8k.h>
+
+#include "clk-branch.h"
+#include "clk-rcg.h"
+#include "clk-regmap.h"
+#include "clk-regmap-divider.h"
+#include "clk-regmap-mux.h"
+#include "common.h"
+#include "reset.h"
+
+#define QCA8K_HIGH_ADDR_PREFIX	0x18
+#define QCA8K_LOW_ADDR_PREFIX	0x10
+#define QCA8K_CFG_PAGE_REG	0xc
+#define QCA8K_CLK_REG_BASE	0x800000
+
+struct qcom_cc {
+	struct qcom_reset_controller reset;
+	struct clk_regmap **rclks;
+	size_t num_rclks;
+};
+
+enum {
+	DT_XO,
+	DT_UNIPHY0_RX_CLK,
+	DT_UNIPHY0_TX_CLK,
+	DT_UNIPHY1_RX_CLK,
+	DT_UNIPHY1_TX_CLK,
+	DT_UNIPHY1_RX312P5M_CLK,
+	DT_UNIPHY1_TX312P5M_CLK,
+};
+
+enum {
+	P_XO,
+	P_UNIPHY0_RX,
+	P_UNIPHY0_TX,
+	P_UNIPHY1_RX,
+	P_UNIPHY1_TX,
+	P_UNIPHY1_RX312P5M,
+	P_UNIPHY1_TX312P5M,
+	P_MAC4_RX_DIV,
+	P_MAC4_TX_DIV,
+	P_MAC5_RX_DIV,
+	P_MAC5_TX_DIV,
+};
+
+static const struct clk_parent_data nss_cc_uniphy1_tx312p5m_data[] = {
+	{ .index = DT_XO },
+	{ .index = DT_UNIPHY1_TX312P5M_CLK },
+};
+
+static const struct parent_map nss_cc_uniphy1_tx312p5m_map[] = {
+	{ P_XO, 0 },
+	{ P_UNIPHY1_TX312P5M, 1 },
+};
+
+static const struct freq_tbl ftbl_gcc_switch_core_clk_src[] = {
+	F(50000000, P_XO, 1, 0, 0),
+	F(312500000, P_UNIPHY1_TX312P5M, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 nss_cc_switch_core_clk_src = {
+	.cmd_rcgr = 0x0,
+	.freq_tbl = ftbl_gcc_switch_core_clk_src,
+	.hid_width = 5,
+	.parent_map = nss_cc_uniphy1_tx312p5m_map,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_switch_core_clk_src",
+		.parent_data = nss_cc_uniphy1_tx312p5m_data,
+		.num_parents = ARRAY_SIZE(nss_cc_uniphy1_tx312p5m_data),
+		.flags = CLK_ENABLE_MUTEX_LOCK,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_branch nss_cc_switch_core_clk = {
+	.halt_reg = 0x8,
+	.clkr = {
+		.enable_reg = 0x8,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_switch_core_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_switch_core_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			/* Can be disabled in PHY mode for power saving */
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_apb_bridge_clk = {
+	.halt_reg = 0x10,
+	.clkr = {
+		.enable_reg = 0x10,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_apb_bridge_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_switch_core_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static const struct clk_parent_data nss_cc_uniphy1_tx_data[] = {
+	{ .index = DT_XO },
+	{ .index = DT_UNIPHY1_TX_CLK },
+};
+
+static const struct parent_map nss_cc_uniphy1_tx_map[] = {
+	{ P_XO, 0 },
+	{ P_UNIPHY1_TX, 2 },
+};
+
+static const struct freq_tbl ftbl_gcc_mac0_tx_clk_src[] = {
+	F(50000000, P_XO, 1, 0, 0),
+	F(125000000, P_UNIPHY1_TX, 1, 0, 0),
+	F(312500000, P_UNIPHY1_TX, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 nss_cc_mac0_tx_clk_src = {
+	.cmd_rcgr = 0x14,
+	.freq_tbl = ftbl_gcc_mac0_tx_clk_src,
+	.hid_width = 5,
+	.parent_map = nss_cc_uniphy1_tx_map,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_mac0_tx_clk_src",
+		.parent_data = nss_cc_uniphy1_tx_data,
+		.num_parents = ARRAY_SIZE(nss_cc_uniphy1_tx_data),
+		.flags = CLK_ENABLE_MUTEX_LOCK,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_mac0_tx_div_clk_src = {
+	.reg = 0x1c,
+	.shift = 0,
+	.width = 4,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac0_tx_div_clk_src",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac0_tx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_regmap_div_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac0_tx_clk = {
+	.halt_reg = 0x20,
+	.clkr = {
+		.enable_reg = 0x20,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac0_tx_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac0_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac0_tx_srds1_clk = {
+	.halt_reg = 0x24,
+	.clkr = {
+		.enable_reg = 0x24,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac0_tx_srds1_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac0_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static const struct clk_parent_data nss_cc_uniphy1_rx_tx_data[] = {
+	{ .index = DT_XO },
+	{ .index = DT_UNIPHY1_RX_CLK },
+	{ .index = DT_UNIPHY1_TX_CLK },
+};
+
+static const struct parent_map nss_cc_uniphy1_rx_tx_map[] = {
+	{ P_XO, 0 },
+	{ P_UNIPHY1_RX, 1 },
+	{ P_UNIPHY1_TX, 2 },
+};
+
+static const struct freq_tbl ftbl_gcc_mac0_rx_clk_src[] = {
+	F(50000000, P_XO, 1, 0, 0),
+	F(125000000, P_UNIPHY1_RX, 1, 0, 0),
+	F(125000000, P_UNIPHY1_TX, 1, 0, 0),
+	F(312500000, P_UNIPHY1_RX, 1, 0, 0),
+	F(312500000, P_UNIPHY1_TX, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 nss_cc_mac0_rx_clk_src = {
+	.cmd_rcgr = 0x28,
+	.freq_tbl = ftbl_gcc_mac0_rx_clk_src,
+	.hid_width = 5,
+	.parent_map = nss_cc_uniphy1_rx_tx_map,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_mac0_rx_clk_src",
+		.parent_data = nss_cc_uniphy1_rx_tx_data,
+		.num_parents = ARRAY_SIZE(nss_cc_uniphy1_rx_tx_data),
+		.flags = CLK_ENABLE_MUTEX_LOCK,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_mac0_rx_div_clk_src = {
+	.reg = 0x30,
+	.shift = 0,
+	.width = 4,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac0_rx_div_clk_src",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac0_rx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_regmap_div_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac0_rx_clk = {
+	.halt_reg = 0x34,
+	.clkr = {
+		.enable_reg = 0x34,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac0_rx_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac0_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac0_rx_srds1_clk = {
+	.halt_reg = 0x3c,
+	.clkr = {
+		.enable_reg = 0x3c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac0_rx_srds1_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac0_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static const struct clk_parent_data nss_cc_uniphy1_rx_tx312p5m_data[] = {
+	{ .index = DT_XO },
+	{ .index = DT_UNIPHY1_TX312P5M_CLK },
+	{ .index = DT_UNIPHY1_RX312P5M_CLK },
+};
+
+static const struct parent_map nss_cc_uniphy1_rx_tx312p5m_map[] = {
+	{ P_XO, 0 },
+	{ P_UNIPHY1_TX312P5M, 6 },
+	{ P_UNIPHY1_RX312P5M, 7 },
+};
+
+static const struct freq_tbl ftbl_gcc_mac1_tx_clk_src[] = {
+	F(25000000, P_UNIPHY1_TX312P5M, 12.5, 0, 0),
+	F(25000000, P_UNIPHY1_RX312P5M, 12.5, 0, 0),
+	F(50000000, P_XO, 1, 0, 0),
+	F(125000000, P_UNIPHY1_TX312P5M, 2.5, 0, 0),
+	F(125000000, P_UNIPHY1_RX312P5M, 2.5, 0, 0),
+	F(312500000, P_UNIPHY1_TX312P5M, 1, 0, 0),
+	F(312500000, P_UNIPHY1_RX312P5M, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 nss_cc_mac1_tx_clk_src = {
+	.cmd_rcgr = 0x40,
+	.freq_tbl = ftbl_gcc_mac1_tx_clk_src,
+	.hid_width = 5,
+	.parent_map = nss_cc_uniphy1_rx_tx312p5m_map,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_mac1_tx_clk_src",
+		.parent_data = nss_cc_uniphy1_rx_tx312p5m_data,
+		.num_parents = ARRAY_SIZE(nss_cc_uniphy1_rx_tx312p5m_data),
+		.flags = CLK_ENABLE_MUTEX_LOCK,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_mac1_tx_div_clk_src = {
+	.reg = 0x48,
+	.shift = 0,
+	.width = 4,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac1_tx_div_clk_src",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac1_tx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_regmap_div_ops,
+		},
+	},
+};
+
+static struct clk_regmap_div nss_cc_mac1_srds1_ch0_xgmii_rx_div_clk_src = {
+	.reg = 0x4c,
+	.shift = 0,
+	.width = 4,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac1_srds1_ch0_xgmii_rx_div_clk_src",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac1_tx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_regmap_div_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac1_srds1_ch0_rx_clk = {
+	.halt_reg = 0x50,
+	.clkr = {
+		.enable_reg = 0x50,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac1_srds1_ch0_rx_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac1_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac1_tx_clk = {
+	.halt_reg = 0x54,
+	.clkr = {
+		.enable_reg = 0x54,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac1_tx_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac1_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac1_gephy0_tx_clk = {
+	.halt_reg = 0x58,
+	.clkr = {
+		.enable_reg = 0x58,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac1_gephy0_tx_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac1_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac1_srds1_ch0_xgmii_rx_clk = {
+	.halt_reg = 0x5c,
+	.clkr = {
+		.enable_reg = 0x5c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac1_srds1_ch0_xgmii_rx_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac1_srds1_ch0_xgmii_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static const struct clk_parent_data nss_cc_uniphy1_tx312p5m_prx_data[] = {
+	{ .index = DT_XO },
+	{ .index = DT_UNIPHY1_TX312P5M_CLK },
+};
+
+static const struct parent_map nss_cc_uniphy1_tx312p5m_prx_map[] = {
+	{ P_XO, 0 },
+	{ P_UNIPHY1_TX312P5M, 6 },
+};
+
+static const struct freq_tbl ftbl_gcc_mac1_rx_clk_src[] = {
+	F(25000000, P_UNIPHY1_TX312P5M, 12.5, 0, 0),
+	F(50000000, P_XO, 1, 0, 0),
+	F(125000000, P_UNIPHY1_TX312P5M, 2.5, 0, 0),
+	F(312500000, P_UNIPHY1_TX312P5M, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 nss_cc_mac1_rx_clk_src = {
+	.cmd_rcgr = 0x60,
+	.freq_tbl = ftbl_gcc_mac1_rx_clk_src,
+	.hid_width = 5,
+	.parent_map = nss_cc_uniphy1_tx312p5m_prx_map,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_mac1_rx_clk_src",
+		.parent_data = nss_cc_uniphy1_tx312p5m_prx_data,
+		.num_parents = ARRAY_SIZE(nss_cc_uniphy1_tx312p5m_prx_data),
+		.flags = CLK_ENABLE_MUTEX_LOCK,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_mac1_rx_div_clk_src = {
+	.reg = 0x68,
+	.shift = 0,
+	.width = 4,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac1_rx_div_clk_src",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac1_rx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_regmap_div_ops,
+		},
+	},
+};
+
+static struct clk_regmap_div nss_cc_mac1_srds1_ch0_xgmii_tx_div_clk_src = {
+	.reg = 0x6c,
+	.shift = 0,
+	.width = 4,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac1_srds1_ch0_xgmii_tx_div_clk_src",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac1_rx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_regmap_div_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac1_srds1_ch0_tx_clk = {
+	.halt_reg = 0x70,
+	.clkr = {
+		.enable_reg = 0x70,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac1_srds1_ch0_tx_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac1_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac1_rx_clk = {
+	.halt_reg = 0x74,
+	.clkr = {
+		.enable_reg = 0x74,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac1_rx_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac1_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac1_gephy0_rx_clk = {
+	.halt_reg = 0x78,
+	.clkr = {
+		.enable_reg = 0x78,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac1_gephy0_rx_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac1_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac1_srds1_ch0_xgmii_tx_clk = {
+	.halt_reg = 0x7c,
+	.clkr = {
+		.enable_reg = 0x7c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac1_srds1_ch0_xgmii_tx_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac1_srds1_ch0_xgmii_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_rcg2 nss_cc_mac2_tx_clk_src = {
+	.cmd_rcgr = 0x80,
+	.freq_tbl = ftbl_gcc_mac1_tx_clk_src,
+	.hid_width = 5,
+	.parent_map = nss_cc_uniphy1_rx_tx312p5m_map,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_mac2_tx_clk_src",
+		.parent_data = nss_cc_uniphy1_rx_tx312p5m_data,
+		.num_parents = ARRAY_SIZE(nss_cc_uniphy1_rx_tx312p5m_data),
+		.flags = CLK_ENABLE_MUTEX_LOCK,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_mac2_tx_div_clk_src = {
+	.reg = 0x88,
+	.shift = 0,
+	.width = 4,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac2_tx_div_clk_src",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac2_tx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_regmap_div_ops,
+		},
+	},
+};
+
+static struct clk_regmap_div nss_cc_mac2_srds1_ch1_xgmii_rx_div_clk_src = {
+	.reg = 0x8c,
+	.shift = 0,
+	.width = 4,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac2_srds1_ch1_xgmii_rx_div_clk_src",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac2_tx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_regmap_div_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac2_srds1_ch1_rx_clk = {
+	.halt_reg = 0x90,
+	.clkr = {
+		.enable_reg = 0x90,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac2_srds1_ch1_rx_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac2_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac2_tx_clk = {
+	.halt_reg = 0x94,
+	.clkr = {
+		.enable_reg = 0x94,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac2_tx_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac2_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac2_gephy1_tx_clk = {
+	.halt_reg = 0x98,
+	.clkr = {
+		.enable_reg = 0x98,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac2_gephy1_tx_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac2_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac2_srds1_ch1_xgmii_rx_clk = {
+	.halt_reg = 0x9c,
+	.clkr = {
+		.enable_reg = 0x9c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac2_srds1_ch1_xgmii_rx_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac2_srds1_ch1_xgmii_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_rcg2 nss_cc_mac2_rx_clk_src = {
+	.cmd_rcgr = 0xa0,
+	.freq_tbl = ftbl_gcc_mac1_rx_clk_src,
+	.hid_width = 5,
+	.parent_map = nss_cc_uniphy1_tx312p5m_prx_map,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_mac2_rx_clk_src",
+		.parent_data = nss_cc_uniphy1_tx312p5m_prx_data,
+		.num_parents = ARRAY_SIZE(nss_cc_uniphy1_tx312p5m_prx_data),
+		.flags = CLK_ENABLE_MUTEX_LOCK,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_mac2_rx_div_clk_src = {
+	.reg = 0xa8,
+	.shift = 0,
+	.width = 4,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac2_rx_div_clk_src",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac2_rx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_regmap_div_ops,
+		},
+	},
+};
+
+static struct clk_regmap_div nss_cc_mac2_srds1_ch1_xgmii_tx_div_clk_src = {
+	.reg = 0xac,
+	.shift = 0,
+	.width = 4,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac2_srds1_ch1_xgmii_tx_div_clk_src",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac2_rx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_regmap_div_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac2_srds1_ch1_tx_clk = {
+	.halt_reg = 0xb0,
+	.clkr = {
+		.enable_reg = 0xb0,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac2_srds1_ch1_tx_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac2_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac2_rx_clk = {
+	.halt_reg = 0xb4,
+	.clkr = {
+		.enable_reg = 0xb4,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac2_rx_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac2_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac2_gephy1_rx_clk = {
+	.halt_reg = 0xb8,
+	.clkr = {
+		.enable_reg = 0xb8,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac2_gephy1_rx_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac2_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac2_srds1_ch1_xgmii_tx_clk = {
+	.halt_reg = 0xbc,
+	.clkr = {
+		.enable_reg = 0xbc,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac2_srds1_ch1_xgmii_tx_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac2_srds1_ch1_xgmii_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_rcg2 nss_cc_mac3_tx_clk_src = {
+	.cmd_rcgr = 0xc0,
+	.freq_tbl = ftbl_gcc_mac1_tx_clk_src,
+	.hid_width = 5,
+	.parent_map = nss_cc_uniphy1_rx_tx312p5m_map,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_mac3_tx_clk_src",
+		.parent_data = nss_cc_uniphy1_rx_tx312p5m_data,
+		.num_parents = ARRAY_SIZE(nss_cc_uniphy1_rx_tx312p5m_data),
+		.flags = CLK_ENABLE_MUTEX_LOCK,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_mac3_tx_div_clk_src = {
+	.reg = 0xc8,
+	.shift = 0,
+	.width = 4,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac3_tx_div_clk_src",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac3_tx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_regmap_div_ops,
+		},
+	},
+};
+
+static struct clk_regmap_div nss_cc_mac3_srds1_ch2_xgmii_rx_div_clk_src = {
+	.reg = 0xcc,
+	.shift = 0,
+	.width = 4,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac3_srds1_ch2_xgmii_rx_div_clk_src",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac3_tx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_regmap_div_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac3_srds1_ch2_rx_clk = {
+	.halt_reg = 0xd0,
+	.clkr = {
+		.enable_reg = 0xd0,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac3_srds1_ch2_rx_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac3_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac3_tx_clk = {
+	.halt_reg = 0xd4,
+	.clkr = {
+		.enable_reg = 0xd4,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac3_tx_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac3_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac3_gephy2_tx_clk = {
+	.halt_reg = 0xd8,
+	.clkr = {
+		.enable_reg = 0xd8,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac3_gephy2_tx_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac3_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac3_srds1_ch2_xgmii_rx_clk = {
+	.halt_reg = 0xdc,
+	.clkr = {
+		.enable_reg = 0xdc,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac3_srds1_ch2_xgmii_rx_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac3_srds1_ch2_xgmii_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_rcg2 nss_cc_mac3_rx_clk_src = {
+	.cmd_rcgr = 0xe0,
+	.freq_tbl = ftbl_gcc_mac1_rx_clk_src,
+	.hid_width = 5,
+	.parent_map = nss_cc_uniphy1_tx312p5m_prx_map,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_mac3_rx_clk_src",
+		.parent_data = nss_cc_uniphy1_tx312p5m_prx_data,
+		.num_parents = ARRAY_SIZE(nss_cc_uniphy1_tx312p5m_prx_data),
+		.flags = CLK_ENABLE_MUTEX_LOCK,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_mac3_rx_div_clk_src = {
+	.reg = 0xe8,
+	.shift = 0,
+	.width = 4,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac3_rx_div_clk_src",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac3_rx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_regmap_div_ops,
+		},
+	},
+};
+
+static struct clk_regmap_div nss_cc_mac3_srds1_ch2_xgmii_tx_div_clk_src = {
+	.reg = 0xec,
+	.shift = 0,
+	.width = 4,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac3_srds1_ch2_xgmii_tx_div_clk_src",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac3_rx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_regmap_div_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac3_srds1_ch2_tx_clk = {
+	.halt_reg = 0xf0,
+	.clkr = {
+		.enable_reg = 0xf0,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac3_srds1_ch2_tx_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac3_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac3_rx_clk = {
+	.halt_reg = 0xf4,
+	.clkr = {
+		.enable_reg = 0xf4,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac3_rx_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac3_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac3_gephy2_rx_clk = {
+	.halt_reg = 0xf8,
+	.clkr = {
+		.enable_reg = 0xf8,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac3_gephy2_rx_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac3_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac3_srds1_ch2_xgmii_tx_clk = {
+	.halt_reg = 0xfc,
+	.clkr = {
+		.enable_reg = 0xfc,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac3_srds1_ch2_xgmii_tx_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac3_srds1_ch2_xgmii_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static const struct clk_parent_data nss_cc_uniphy0_rx_uniphy1_rx_tx312p5m_data[] = {
+	{ .index = DT_XO },
+	{ .index = DT_UNIPHY1_TX312P5M_CLK },
+	{ .index = DT_UNIPHY1_RX312P5M_CLK },
+};
+
+static const struct parent_map nss_cc_uniphy0_rx_uniphy1_rx_tx312p5m_map[] = {
+	{ P_XO, 0 },
+	{ P_UNIPHY1_TX312P5M, 3 },
+	{ P_UNIPHY1_RX312P5M, 7 },
+};
+
+static const struct freq_tbl ftbl_gcc_mac4_tx_clk_src[] = {
+	F(25000000, P_UNIPHY1_TX312P5M, 12.5, 0, 0),
+	F(25000000, P_UNIPHY1_RX312P5M, 12.5, 0, 0),
+	F(50000000, P_XO, 1, 0, 0),
+	F(125000000, P_UNIPHY1_TX312P5M, 2.5, 0, 0),
+	F(125000000, P_UNIPHY1_RX312P5M, 2.5, 0, 0),
+	F(312500000, P_UNIPHY1_TX312P5M, 1, 0, 0),
+	F(312500000, P_UNIPHY1_RX312P5M, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 nss_cc_mac4_tx_clk_src = {
+	.cmd_rcgr = 0x100,
+	.freq_tbl = ftbl_gcc_mac4_tx_clk_src,
+	.hid_width = 5,
+	.parent_map = nss_cc_uniphy0_rx_uniphy1_rx_tx312p5m_map,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_mac4_tx_clk_src",
+		.parent_data = nss_cc_uniphy0_rx_uniphy1_rx_tx312p5m_data,
+		.num_parents = ARRAY_SIZE(nss_cc_uniphy0_rx_uniphy1_rx_tx312p5m_data),
+		.flags = CLK_ENABLE_MUTEX_LOCK,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_mac4_tx_div_clk_src = {
+	.reg = 0x108,
+	.shift = 0,
+	.width = 4,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac4_tx_div_clk_src",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac4_tx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_regmap_div_ops,
+		},
+	},
+};
+
+static struct clk_regmap_div nss_cc_mac4_srds1_ch3_xgmii_rx_div_clk_src = {
+	.reg = 0x10c,
+	.shift = 0,
+	.width = 4,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac4_srds1_ch3_xgmii_rx_div_clk_src",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac4_tx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_regmap_div_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac4_srds1_ch3_rx_clk = {
+	.halt_reg = 0x110,
+	.clkr = {
+		.enable_reg = 0x110,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac4_srds1_ch3_rx_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac4_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac4_tx_clk = {
+	.halt_reg = 0x114,
+	.clkr = {
+		.enable_reg = 0x114,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac4_tx_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac4_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac4_gephy3_tx_clk = {
+	.halt_reg = 0x118,
+	.clkr = {
+		.enable_reg = 0x118,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac4_gephy3_tx_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac4_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac4_srds1_ch3_xgmii_rx_clk = {
+	.halt_reg = 0x11c,
+	.clkr = {
+		.enable_reg = 0x11c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac4_srds1_ch3_xgmii_rx_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac4_srds1_ch3_xgmii_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static const struct clk_parent_data nss_cc_uniphy0_tx_uniphy1_tx312p5m_data[] = {
+	{ .index = DT_XO },
+	{ .index = DT_UNIPHY1_TX312P5M_CLK },
+};
+
+static const struct parent_map nss_cc_uniphy0_tx_uniphy1_tx312p5m_map[] = {
+	{ P_XO, 0 },
+	{ P_UNIPHY1_TX312P5M, 3 },
+};
+
+static const struct freq_tbl ftbl_gcc_mac4_rx_clk_src[] = {
+	F(25000000, P_UNIPHY1_TX312P5M, 12.5, 0, 0),
+	F(50000000, P_XO, 1, 0, 0),
+	F(125000000, P_UNIPHY1_TX312P5M, 2.5, 0, 0),
+	F(312500000, P_UNIPHY1_TX312P5M, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 nss_cc_mac4_rx_clk_src = {
+	.cmd_rcgr = 0x120,
+	.freq_tbl = ftbl_gcc_mac4_rx_clk_src,
+	.hid_width = 5,
+	.parent_map = nss_cc_uniphy0_tx_uniphy1_tx312p5m_map,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_mac4_rx_clk_src",
+		.parent_data = nss_cc_uniphy0_tx_uniphy1_tx312p5m_data,
+		.num_parents = ARRAY_SIZE(nss_cc_uniphy0_tx_uniphy1_tx312p5m_data),
+		.flags = CLK_ENABLE_MUTEX_LOCK,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_mac4_rx_div_clk_src = {
+	.reg = 0x128,
+	.shift = 0,
+	.width = 4,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac4_rx_div_clk_src",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac4_rx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_regmap_div_ops,
+		},
+	},
+};
+
+static struct clk_regmap_div nss_cc_mac4_srds1_ch3_xgmii_tx_div_clk_src = {
+	.reg = 0x12c,
+	.shift = 0,
+	.width = 4,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac4_srds1_ch3_xgmii_tx_div_clk_src",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac4_rx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_regmap_div_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac4_srds1_ch3_tx_clk = {
+	.halt_reg = 0x130,
+	.clkr = {
+		.enable_reg = 0x130,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac4_srds1_ch3_tx_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac4_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac4_rx_clk = {
+	.halt_reg = 0x134,
+	.clkr = {
+		.enable_reg = 0x134,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac4_rx_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac4_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac4_gephy3_rx_clk = {
+	.halt_reg = 0x138,
+	.clkr = {
+		.enable_reg = 0x138,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac4_gephy3_rx_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac4_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac4_srds1_ch3_xgmii_tx_clk = {
+	.halt_reg = 0x13c,
+	.clkr = {
+		.enable_reg = 0x13c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac4_srds1_ch3_xgmii_tx_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac4_srds1_ch3_xgmii_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static const struct clk_parent_data nss_cc_uniphy0_tx_data[] = {
+	{ .index = DT_XO },
+	{ .index = DT_UNIPHY0_TX_CLK },
+};
+
+static const struct parent_map nss_cc_uniphy0_tx_map[] = {
+	{ P_XO, 0 },
+	{ P_UNIPHY0_TX, 2 },
+};
+
+static const struct freq_tbl ftbl_gcc_mac5_tx_clk_src[] = {
+	F(50000000, P_XO, 1, 0, 0),
+	F(125000000, P_UNIPHY0_TX, 1, 0, 0),
+	F(312500000, P_UNIPHY0_TX, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 nss_cc_mac5_tx_clk_src = {
+	.cmd_rcgr = 0x140,
+	.freq_tbl = ftbl_gcc_mac5_tx_clk_src,
+	.hid_width = 5,
+	.parent_map = nss_cc_uniphy0_tx_map,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_mac5_tx_clk_src",
+		.parent_data = nss_cc_uniphy0_tx_data,
+		.num_parents = ARRAY_SIZE(nss_cc_uniphy0_tx_data),
+		.flags = CLK_ENABLE_MUTEX_LOCK,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_mac5_tx_div_clk_src = {
+	.reg = 0x148,
+	.shift = 0,
+	.width = 4,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac5_tx_div_clk_src",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac5_tx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_regmap_div_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac5_tx_clk = {
+	.halt_reg = 0x14c,
+	.clkr = {
+		.enable_reg = 0x14c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac5_tx_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac5_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static const struct clk_parent_data nss_cc_uniphy0_rx_tx_data[] = {
+	{ .index = DT_XO },
+	{ .index = DT_UNIPHY0_RX_CLK },
+	{ .index = DT_UNIPHY0_TX_CLK },
+};
+
+static const struct parent_map nss_cc_uniphy0_rx_tx_map[] = {
+	{ P_XO, 0 },
+	{ P_UNIPHY0_RX, 1 },
+	{ P_UNIPHY0_TX, 2 },
+};
+
+static const struct freq_tbl ftbl_gcc_mac5_rx_clk_src[] = {
+	F(50000000, P_XO, 1, 0, 0),
+	F(125000000, P_UNIPHY0_RX, 1, 0, 0),
+	F(125000000, P_UNIPHY0_TX, 1, 0, 0),
+	F(312500000, P_UNIPHY0_RX, 1, 0, 0),
+	F(312500000, P_UNIPHY0_TX, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 nss_cc_mac5_rx_clk_src = {
+	.cmd_rcgr = 0x154,
+	.freq_tbl = ftbl_gcc_mac5_rx_clk_src,
+	.hid_width = 5,
+	.parent_map = nss_cc_uniphy0_rx_tx_map,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_mac5_rx_clk_src",
+		.parent_data = nss_cc_uniphy0_rx_tx_data,
+		.num_parents = ARRAY_SIZE(nss_cc_uniphy0_rx_tx_data),
+		.flags = CLK_ENABLE_MUTEX_LOCK,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_mac5_rx_div_clk_src = {
+	.reg = 0x15c,
+	.shift = 0,
+	.width = 4,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac5_rx_div_clk_src",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac5_rx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_regmap_div_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac5_rx_clk = {
+	.halt_reg = 0x160,
+	.clkr = {
+		.enable_reg = 0x160,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac5_rx_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac5_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static const struct parent_map nss_cc_mac4_rx_div_mac5_tx_div_map[] = {
+	{ P_MAC4_RX_DIV, 0 },
+	{ P_MAC5_TX_DIV, 1 },
+};
+
+static struct clk_regmap_mux nss_cc_mac5_tx_srds0_clk_src = {
+	.reg = 0x300,
+	.shift = 0,
+	.width = 1,
+	.parent_map = nss_cc_mac4_rx_div_mac5_tx_div_map,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac5_tx_srds0_clk_src",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac4_rx_div_clk_src.clkr.hw,
+				&nss_cc_mac5_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 2,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac5_tx_srds0_clk = {
+	.halt_reg = 0x150,
+	.clkr = {
+		.enable_reg = 0x150,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac5_tx_srds0_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac5_tx_srds0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static const struct parent_map nss_cc_mac4_tx_div_mac5_rx_div_map[] = {
+	{ P_MAC4_TX_DIV, 0 },
+	{ P_MAC5_RX_DIV, 1 },
+};
+
+static struct clk_regmap_mux nss_cc_mac5_rx_srds0_clk_src = {
+	.reg = 0x300,
+	.shift = 1,
+	.width = 1,
+	.parent_map = nss_cc_mac4_tx_div_mac5_rx_div_map,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac5_rx_srds0_clk_src",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac4_tx_div_clk_src.clkr.hw,
+				&nss_cc_mac5_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 2,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mac5_rx_srds0_clk = {
+	.halt_reg = 0x164,
+	.clkr = {
+		.enable_reg = 0x164,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mac5_rx_srds0_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_mac5_rx_srds0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static const struct parent_map nss_cc_uniphy1_tx312p5m_map2[] = {
+	{ P_XO, 0 },
+	{ P_UNIPHY1_TX312P5M, 2 },
+};
+
+static const struct freq_tbl ftbl_gcc_ahb_clk_src[] = {
+	F(50000000, P_XO, 1, 0, 0),
+	F(104170000, P_UNIPHY1_TX312P5M, 3, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 nss_cc_ahb_clk_src = {
+	.cmd_rcgr = 0x168,
+	.freq_tbl = ftbl_gcc_ahb_clk_src,
+	.hid_width = 5,
+	.parent_map = nss_cc_uniphy1_tx312p5m_map2,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_ahb_clk_src",
+		.parent_data = nss_cc_uniphy1_tx312p5m_data,
+		.num_parents = ARRAY_SIZE(nss_cc_uniphy1_tx312p5m_data),
+		.flags = CLK_ENABLE_MUTEX_LOCK,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_branch nss_cc_ahb_clk = {
+	.halt_reg = 0x170,
+	.clkr = {
+		.enable_reg = 0x170,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_ahb_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_sec_ctrl_ahb_clk = {
+	.halt_reg = 0x174,
+	.clkr = {
+		.enable_reg = 0x174,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_sec_ctrl_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_ahb_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_tlmm_clk = {
+	.halt_reg = 0x178,
+	.clkr = {
+		.enable_reg = 0x178,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_tlmm_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_ahb_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_tlmm_ahb_clk = {
+	.halt_reg = 0x190,
+	.clkr = {
+		.enable_reg = 0x190,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_tlmm_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_ahb_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_cnoc_ahb_clk = {
+	.halt_reg = 0x194,
+	.clkr = {
+		.enable_reg = 0x194,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_cnoc_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_ahb_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mdio_ahb_clk = {
+	.halt_reg = 0x198,
+	.clkr = {
+		.enable_reg = 0x198,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mdio_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_ahb_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_mdio_master_ahb_clk = {
+	.halt_reg = 0x19c,
+	.clkr = {
+		.enable_reg = 0x19c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_mdio_master_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_ahb_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static const struct clk_parent_data nss_cc_xo_data[] = {
+	{ .index = DT_XO },
+};
+
+static const struct parent_map nss_cc_xo_map[] = {
+	{ P_XO, 0 },
+};
+
+static const struct freq_tbl ftbl_gcc_sys_clk_src[] = {
+	F(25000000, P_XO, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 nss_cc_sys_clk_src = {
+	.cmd_rcgr = 0x1a0,
+	.freq_tbl = ftbl_gcc_sys_clk_src,
+	.hid_width = 5,
+	.parent_map = nss_cc_xo_map,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_sys_clk_src",
+		.parent_data = nss_cc_xo_data,
+		.num_parents = ARRAY_SIZE(nss_cc_xo_data),
+		.flags = CLK_ENABLE_MUTEX_LOCK,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_branch nss_cc_srds0_sys_clk = {
+	.halt_reg = 0x1a8,
+	.clkr = {
+		.enable_reg = 0x1a8,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_srds0_sys_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_sys_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			/* Can be disabled in PHY mode for power saving */
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_srds1_sys_clk = {
+	.halt_reg = 0x1ac,
+	.clkr = {
+		.enable_reg = 0x1ac,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_srds1_sys_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_sys_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_gephy0_sys_clk = {
+	.halt_reg = 0x1b0,
+	.clkr = {
+		.enable_reg = 0x1b0,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_gephy0_sys_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_sys_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_gephy1_sys_clk = {
+	.halt_reg = 0x1b4,
+	.clkr = {
+		.enable_reg = 0x1b4,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_gephy1_sys_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_sys_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_gephy2_sys_clk = {
+	.halt_reg = 0x1b8,
+	.clkr = {
+		.enable_reg = 0x1b8,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_gephy2_sys_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_sys_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_gephy3_sys_clk = {
+	.halt_reg = 0x1bc,
+	.clkr = {
+		.enable_reg = 0x1bc,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_gephy3_sys_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&nss_cc_sys_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_ENABLE_MUTEX_LOCK | CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_regmap *nss_cc_qca8k_clocks[] = {
+	[NSS_CC_SWITCH_CORE_CLK_SRC] = &nss_cc_switch_core_clk_src.clkr,
+	[NSS_CC_SWITCH_CORE_CLK] = &nss_cc_switch_core_clk.clkr,
+	[NSS_CC_APB_BRIDGE_CLK] = &nss_cc_apb_bridge_clk.clkr,
+	[NSS_CC_MAC0_TX_CLK_SRC] = &nss_cc_mac0_tx_clk_src.clkr,
+	[NSS_CC_MAC0_TX_DIV_CLK_SRC] = &nss_cc_mac0_tx_div_clk_src.clkr,
+	[NSS_CC_MAC0_TX_CLK] = &nss_cc_mac0_tx_clk.clkr,
+	[NSS_CC_MAC0_TX_SRDS1_CLK] = &nss_cc_mac0_tx_srds1_clk.clkr,
+	[NSS_CC_MAC0_RX_CLK_SRC] = &nss_cc_mac0_rx_clk_src.clkr,
+	[NSS_CC_MAC0_RX_DIV_CLK_SRC] = &nss_cc_mac0_rx_div_clk_src.clkr,
+	[NSS_CC_MAC0_RX_CLK] = &nss_cc_mac0_rx_clk.clkr,
+	[NSS_CC_MAC0_RX_SRDS1_CLK] = &nss_cc_mac0_rx_srds1_clk.clkr,
+	[NSS_CC_MAC1_TX_CLK_SRC] = &nss_cc_mac1_tx_clk_src.clkr,
+	[NSS_CC_MAC1_TX_DIV_CLK_SRC] = &nss_cc_mac1_tx_div_clk_src.clkr,
+	[NSS_CC_MAC1_SRDS1_CH0_XGMII_RX_DIV_CLK_SRC] =
+		&nss_cc_mac1_srds1_ch0_xgmii_rx_div_clk_src.clkr,
+	[NSS_CC_MAC1_SRDS1_CH0_RX_CLK] = &nss_cc_mac1_srds1_ch0_rx_clk.clkr,
+	[NSS_CC_MAC1_TX_CLK] = &nss_cc_mac1_tx_clk.clkr,
+	[NSS_CC_MAC1_GEPHY0_TX_CLK] = &nss_cc_mac1_gephy0_tx_clk.clkr,
+	[NSS_CC_MAC1_SRDS1_CH0_XGMII_RX_CLK] = &nss_cc_mac1_srds1_ch0_xgmii_rx_clk.clkr,
+	[NSS_CC_MAC1_RX_CLK_SRC] = &nss_cc_mac1_rx_clk_src.clkr,
+	[NSS_CC_MAC1_RX_DIV_CLK_SRC] = &nss_cc_mac1_rx_div_clk_src.clkr,
+	[NSS_CC_MAC1_SRDS1_CH0_XGMII_TX_DIV_CLK_SRC] =
+		&nss_cc_mac1_srds1_ch0_xgmii_tx_div_clk_src.clkr,
+	[NSS_CC_MAC1_SRDS1_CH0_TX_CLK] = &nss_cc_mac1_srds1_ch0_tx_clk.clkr,
+	[NSS_CC_MAC1_RX_CLK] = &nss_cc_mac1_rx_clk.clkr,
+	[NSS_CC_MAC1_GEPHY0_RX_CLK] = &nss_cc_mac1_gephy0_rx_clk.clkr,
+	[NSS_CC_MAC1_SRDS1_CH0_XGMII_TX_CLK] = &nss_cc_mac1_srds1_ch0_xgmii_tx_clk.clkr,
+	[NSS_CC_MAC2_TX_CLK_SRC] = &nss_cc_mac2_tx_clk_src.clkr,
+	[NSS_CC_MAC2_TX_DIV_CLK_SRC] = &nss_cc_mac2_tx_div_clk_src.clkr,
+	[NSS_CC_MAC2_SRDS1_CH1_XGMII_RX_DIV_CLK_SRC] =
+		&nss_cc_mac2_srds1_ch1_xgmii_rx_div_clk_src.clkr,
+	[NSS_CC_MAC2_SRDS1_CH1_RX_CLK] = &nss_cc_mac2_srds1_ch1_rx_clk.clkr,
+	[NSS_CC_MAC2_TX_CLK] = &nss_cc_mac2_tx_clk.clkr,
+	[NSS_CC_MAC2_GEPHY1_TX_CLK] = &nss_cc_mac2_gephy1_tx_clk.clkr,
+	[NSS_CC_MAC2_SRDS1_CH1_XGMII_RX_CLK] = &nss_cc_mac2_srds1_ch1_xgmii_rx_clk.clkr,
+	[NSS_CC_MAC2_RX_CLK_SRC] = &nss_cc_mac2_rx_clk_src.clkr,
+	[NSS_CC_MAC2_RX_DIV_CLK_SRC] = &nss_cc_mac2_rx_div_clk_src.clkr,
+	[NSS_CC_MAC2_SRDS1_CH1_XGMII_TX_DIV_CLK_SRC] =
+		&nss_cc_mac2_srds1_ch1_xgmii_tx_div_clk_src.clkr,
+	[NSS_CC_MAC2_SRDS1_CH1_TX_CLK] = &nss_cc_mac2_srds1_ch1_tx_clk.clkr,
+	[NSS_CC_MAC2_RX_CLK] = &nss_cc_mac2_rx_clk.clkr,
+	[NSS_CC_MAC2_GEPHY1_RX_CLK] = &nss_cc_mac2_gephy1_rx_clk.clkr,
+	[NSS_CC_MAC2_SRDS1_CH1_XGMII_TX_CLK] = &nss_cc_mac2_srds1_ch1_xgmii_tx_clk.clkr,
+	[NSS_CC_MAC3_TX_CLK_SRC] = &nss_cc_mac3_tx_clk_src.clkr,
+	[NSS_CC_MAC3_TX_DIV_CLK_SRC] = &nss_cc_mac3_tx_div_clk_src.clkr,
+	[NSS_CC_MAC3_SRDS1_CH2_XGMII_RX_DIV_CLK_SRC] =
+		&nss_cc_mac3_srds1_ch2_xgmii_rx_div_clk_src.clkr,
+	[NSS_CC_MAC3_SRDS1_CH2_RX_CLK] = &nss_cc_mac3_srds1_ch2_rx_clk.clkr,
+	[NSS_CC_MAC3_TX_CLK] = &nss_cc_mac3_tx_clk.clkr,
+	[NSS_CC_MAC3_GEPHY2_TX_CLK] = &nss_cc_mac3_gephy2_tx_clk.clkr,
+	[NSS_CC_MAC3_SRDS1_CH2_XGMII_RX_CLK] = &nss_cc_mac3_srds1_ch2_xgmii_rx_clk.clkr,
+	[NSS_CC_MAC3_RX_CLK_SRC] = &nss_cc_mac3_rx_clk_src.clkr,
+	[NSS_CC_MAC3_RX_DIV_CLK_SRC] = &nss_cc_mac3_rx_div_clk_src.clkr,
+	[NSS_CC_MAC3_SRDS1_CH2_XGMII_TX_DIV_CLK_SRC] =
+		&nss_cc_mac3_srds1_ch2_xgmii_tx_div_clk_src.clkr,
+	[NSS_CC_MAC3_SRDS1_CH2_TX_CLK] = &nss_cc_mac3_srds1_ch2_tx_clk.clkr,
+	[NSS_CC_MAC3_RX_CLK] = &nss_cc_mac3_rx_clk.clkr,
+	[NSS_CC_MAC3_GEPHY2_RX_CLK] = &nss_cc_mac3_gephy2_rx_clk.clkr,
+	[NSS_CC_MAC3_SRDS1_CH2_XGMII_TX_CLK] = &nss_cc_mac3_srds1_ch2_xgmii_tx_clk.clkr,
+	[NSS_CC_MAC4_TX_CLK_SRC] = &nss_cc_mac4_tx_clk_src.clkr,
+	[NSS_CC_MAC4_TX_DIV_CLK_SRC] = &nss_cc_mac4_tx_div_clk_src.clkr,
+	[NSS_CC_MAC4_SRDS1_CH2_XGMII_RX_DIV_CLK_SRC] =
+		&nss_cc_mac4_srds1_ch3_xgmii_rx_div_clk_src.clkr,
+	[NSS_CC_MAC4_SRDS1_CH3_RX_CLK] = &nss_cc_mac4_srds1_ch3_rx_clk.clkr,
+	[NSS_CC_MAC4_TX_CLK] = &nss_cc_mac4_tx_clk.clkr,
+	[NSS_CC_MAC4_GEPHY3_TX_CLK] = &nss_cc_mac4_gephy3_tx_clk.clkr,
+	[NSS_CC_MAC4_SRDS1_CH3_XGMII_RX_CLK] = &nss_cc_mac4_srds1_ch3_xgmii_rx_clk.clkr,
+	[NSS_CC_MAC4_RX_CLK_SRC] = &nss_cc_mac4_rx_clk_src.clkr,
+	[NSS_CC_MAC4_RX_DIV_CLK_SRC] = &nss_cc_mac4_rx_div_clk_src.clkr,
+	[NSS_CC_MAC4_SRDS1_CH2_XGMII_TX_DIV_CLK_SRC] =
+		&nss_cc_mac4_srds1_ch3_xgmii_tx_div_clk_src.clkr,
+	[NSS_CC_MAC4_SRDS1_CH3_TX_CLK] = &nss_cc_mac4_srds1_ch3_tx_clk.clkr,
+	[NSS_CC_MAC4_RX_CLK] = &nss_cc_mac4_rx_clk.clkr,
+	[NSS_CC_MAC4_GEPHY3_RX_CLK] = &nss_cc_mac4_gephy3_rx_clk.clkr,
+	[NSS_CC_MAC4_SRDS1_CH3_XGMII_TX_CLK] = &nss_cc_mac4_srds1_ch3_xgmii_tx_clk.clkr,
+	[NSS_CC_MAC5_TX_CLK_SRC] = &nss_cc_mac5_tx_clk_src.clkr,
+	[NSS_CC_MAC5_TX_DIV_CLK_SRC] = &nss_cc_mac5_tx_div_clk_src.clkr,
+	[NSS_CC_MAC5_TX_SRDS0_CLK] = &nss_cc_mac5_tx_srds0_clk.clkr,
+	[NSS_CC_MAC5_TX_CLK] = &nss_cc_mac5_tx_clk.clkr,
+	[NSS_CC_MAC5_RX_CLK_SRC] = &nss_cc_mac5_rx_clk_src.clkr,
+	[NSS_CC_MAC5_RX_DIV_CLK_SRC] = &nss_cc_mac5_rx_div_clk_src.clkr,
+	[NSS_CC_MAC5_RX_SRDS0_CLK] = &nss_cc_mac5_rx_srds0_clk.clkr,
+	[NSS_CC_MAC5_RX_CLK] = &nss_cc_mac5_rx_clk.clkr,
+	[NSS_CC_MAC5_TX_SRDS0_CLK_SRC] = &nss_cc_mac5_tx_srds0_clk_src.clkr,
+	[NSS_CC_MAC5_RX_SRDS0_CLK_SRC] = &nss_cc_mac5_rx_srds0_clk_src.clkr,
+	[NSS_CC_AHB_CLK_SRC] = &nss_cc_ahb_clk_src.clkr,
+	[NSS_CC_AHB_CLK] = &nss_cc_ahb_clk.clkr,
+	[NSS_CC_SEC_CTRL_AHB_CLK] = &nss_cc_sec_ctrl_ahb_clk.clkr,
+	[NSS_CC_TLMM_CLK] = &nss_cc_tlmm_clk.clkr,
+	[NSS_CC_TLMM_AHB_CLK] = &nss_cc_tlmm_ahb_clk.clkr,
+	[NSS_CC_CNOC_AHB_CLK] = &nss_cc_cnoc_ahb_clk.clkr,
+	[NSS_CC_MDIO_AHB_CLK] = &nss_cc_mdio_ahb_clk.clkr,
+	[NSS_CC_MDIO_MASTER_AHB_CLK] = &nss_cc_mdio_master_ahb_clk.clkr,
+	[NSS_CC_SYS_CLK_SRC] = &nss_cc_sys_clk_src.clkr,
+	[NSS_CC_SRDS0_SYS_CLK] = &nss_cc_srds0_sys_clk.clkr,
+	[NSS_CC_SRDS1_SYS_CLK] = &nss_cc_srds1_sys_clk.clkr,
+	[NSS_CC_GEPHY0_SYS_CLK] = &nss_cc_gephy0_sys_clk.clkr,
+	[NSS_CC_GEPHY1_SYS_CLK] = &nss_cc_gephy1_sys_clk.clkr,
+	[NSS_CC_GEPHY2_SYS_CLK] = &nss_cc_gephy2_sys_clk.clkr,
+	[NSS_CC_GEPHY3_SYS_CLK] = &nss_cc_gephy3_sys_clk.clkr,
+};
+
+static const struct qcom_reset_map nss_cc_qca8k_resets[] = {
+	[NSS_CC_SWITCH_CORE_ARES] = { 0xC, 2 },
+	[NSS_CC_APB_BRIDGE_ARES] = { 0x10, 2 },
+	[NSS_CC_MAC0_TX_ARES] = { 0x20, 2 },
+	[NSS_CC_MAC0_TX_SRDS1_ARES] = { 0x24, 2 },
+	[NSS_CC_MAC0_RX_ARES] = { 0x34, 2 },
+	[NSS_CC_MAC0_RX_SRDS1_ARES] = { 0x3C, 2 },
+	[NSS_CC_MAC1_SRDS1_CH0_RX_ARES] = { 0x50, 2 },
+	[NSS_CC_MAC1_TX_ARES] = { 0x54, 2 },
+	[NSS_CC_MAC1_GEPHY0_TX_ARES] = { 0x58, 2 },
+	[NSS_CC_MAC1_SRDS1_CH0_XGMII_RX_ARES] = { 0x5C, 2 },
+	[NSS_CC_MAC1_SRDS1_CH0_TX_ARES] = { 0x70, 2 },
+	[NSS_CC_MAC1_RX_ARES] = { 0x74, 2 },
+	[NSS_CC_MAC1_GEPHY0_RX_ARES] = { 0x78, 2 },
+	[NSS_CC_MAC1_SRDS1_CH0_XGMII_TX_ARES] = { 0x7C, 2 },
+	[NSS_CC_MAC2_SRDS1_CH1_RX_ARES] = { 0x90, 2 },
+	[NSS_CC_MAC2_TX_ARES] = { 0x94, 2 },
+	[NSS_CC_MAC2_GEPHY1_TX_ARES] = { 0x98, 2 },
+	[NSS_CC_MAC2_SRDS1_CH1_XGMII_RX_ARES] = { 0x9C, 2 },
+	[NSS_CC_MAC2_SRDS1_CH1_TX_ARES] = { 0xB0, 2 },
+	[NSS_CC_MAC2_RX_ARES] = { 0xB4, 2 },
+	[NSS_CC_MAC2_GEPHY1_RX_ARES] = { 0xB8, 2 },
+	[NSS_CC_MAC2_SRDS1_CH1_XGMII_TX_ARES] = { 0xBC, 2 },
+	[NSS_CC_MAC3_SRDS1_CH2_RX_ARES] = { 0xD0, 2 },
+	[NSS_CC_MAC3_TX_ARES] = { 0xD4, 2 },
+	[NSS_CC_MAC3_GEPHY2_TX_ARES] = { 0xD8, 2 },
+	[NSS_CC_MAC3_SRDS1_CH2_XGMII_RX_ARES] = { 0xDC, 2 },
+	[NSS_CC_MAC3_SRDS1_CH2_TX_ARES] = { 0xF0, 2 },
+	[NSS_CC_MAC3_RX_ARES] = { 0xF4, 2 },
+	[NSS_CC_MAC3_GEPHY2_RX_ARES] = { 0xF8, 2 },
+	[NSS_CC_MAC3_SRDS1_CH2_XGMII_TX_ARES] = { 0xFC, 2 },
+	[NSS_CC_MAC4_SRDS1_CH3_RX_ARES] = { 0x110, 2 },
+	[NSS_CC_MAC4_TX_ARES] = { 0x114, 2 },
+	[NSS_CC_MAC4_GEPHY3_TX_ARES] = { 0x118, 2 },
+	[NSS_CC_MAC4_SRDS1_CH3_XGMII_RX_ARES] = { 0x11C, 2 },
+	[NSS_CC_MAC4_SRDS1_CH3_TX_ARES] = { 0x130, 2 },
+	[NSS_CC_MAC4_RX_ARES] = { 0x134, 2 },
+	[NSS_CC_MAC4_GEPHY3_RX_ARES] = { 0x138, 2 },
+	[NSS_CC_MAC4_SRDS1_CH3_XGMII_TX_ARES] = { 0x13C, 2 },
+	[NSS_CC_MAC5_TX_ARES] = { 0x14C, 2 },
+	[NSS_CC_MAC5_TX_SRDS0_ARES] = { 0x150, 2 },
+	[NSS_CC_MAC5_RX_ARES] = { 0x160, 2 },
+	[NSS_CC_MAC5_RX_SRDS0_ARES] = { 0x164, 2 },
+	[NSS_CC_AHB_ARES] = { 0x170, 2 },
+	[NSS_CC_SEC_CTRL_AHB_ARES] = { 0x174, 2 },
+	[NSS_CC_TLMM_ARES] = { 0x178, 2 },
+	[NSS_CC_TLMM_AHB_ARES] = { 0x190, 2 },
+	[NSS_CC_CNOC_AHB_ARES] = { 0x194, 2 }, /* reset CNOC AHB & APB */
+	[NSS_CC_MDIO_AHB_ARES] = { 0x198, 2 },
+	[NSS_CC_MDIO_MASTER_AHB_ARES] = { 0x19C, 2 },
+	[NSS_CC_SRDS0_SYS_ARES] = { 0x1A8, 2 },
+	[NSS_CC_SRDS1_SYS_ARES] = { 0x1AC, 2 },
+	[NSS_CC_GEPHY0_SYS_ARES] = { 0x1B0, 2 },
+	[NSS_CC_GEPHY1_SYS_ARES] = { 0x1B4, 2 },
+	[NSS_CC_GEPHY2_SYS_ARES] = { 0x1B8, 2 },
+	[NSS_CC_GEPHY3_SYS_ARES] = { 0x1BC, 2 },
+	[NSS_CC_SEC_CTRL_ARES] = { 0x1C8, 2 },
+	[NSS_CC_SEC_CTRL_SENSE_ARES] = { 0x1D0, 2 },
+	[NSS_CC_SLEEP_ARES] = { 0x1E0, 2 },
+	[NSS_CC_DEBUG_ARES] = { 0x1E8, 2 },
+	[NSS_CC_GEPHY0_ARES] = { 0x304, 0 },
+	[NSS_CC_GEPHY1_ARES] = { 0x304, 1 },
+	[NSS_CC_GEPHY2_ARES] = { 0x304, 2 },
+	[NSS_CC_GEPHY3_ARES] = { 0x304, 3 },
+	[NSS_CC_DSP_ARES] = { 0x304, 4 },
+	[NSS_CC_GLOBAL_ARES] = { 0x308, 0 },
+	[NSS_CC_XPCS_ARES] = { 0x30C, 0 },
+};
+
+static inline void split_addr(u32 regaddr, u16 *r1, u16 *r2, u16 *page)
+{
+	*r1 = regaddr & 0x1c;
+
+	regaddr >>= 5;
+	*r2 = regaddr & 0x7;
+
+	regaddr >>= 3;
+	*page = regaddr & 0xffff;
+}
+
+int qca8k_mii_read(struct mii_bus *bus, u16 switch_phy_id, u32 reg, u32 *val)
+{
+	int ret;
+
+	ret = bus->read(bus, switch_phy_id, reg);
+	if (ret >= 0) {
+		*val = ret;
+		ret = bus->read(bus, switch_phy_id, (reg | BIT(1)));
+		*val |= ret << 16;
+	}
+
+	if (ret < 0) {
+		dev_err_ratelimited(&bus->dev, "fail to read qca8k mii register\n");
+
+		*val = 0;
+		return ret;
+	}
+
+	return 0;
+}
+
+void qca8k_mii_write(struct mii_bus *bus, u16 switch_phy_id, u32 reg, u32 val)
+{
+	int ret;
+	u16 lo, hi;
+
+	lo = val & 0xffff;
+	hi = (u16)(val >> 16);
+
+	ret = bus->write(bus, switch_phy_id, reg, lo);
+	if (ret >= 0)
+		ret = bus->write(bus, switch_phy_id, (reg | BIT(1)), hi);
+
+	if (ret < 0)
+		dev_err_ratelimited(&bus->dev, "fail to write qca8k mii register\n");
+}
+
+int qca8k_mii_page_set(struct mii_bus *bus, u16 switch_phy_id, u32 reg, u16 page)
+{
+	int ret;
+
+	ret = bus->write(bus, switch_phy_id, reg, page);
+	if (ret < 0)
+		dev_err_ratelimited(&bus->dev, "fail to set page\n");
+
+	return ret;
+}
+
+int qca8k_regmap_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct mii_bus *bus = context;
+	u16 r1, r2, page;
+	int ret;
+
+	reg += QCA8K_CLK_REG_BASE;
+	split_addr(reg, &r1, &r2, &page);
+
+	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
+	ret = qca8k_mii_page_set(bus, QCA8K_HIGH_ADDR_PREFIX, QCA8K_CFG_PAGE_REG, page);
+	if (ret < 0)
+		goto qca8k_read_exit;
+
+	ret = qca8k_mii_read(bus, QCA8K_LOW_ADDR_PREFIX | r2, r1, val);
+
+qca8k_read_exit:
+	mutex_unlock(&bus->mdio_lock);
+	return ret;
+};
+
+int qca8k_regmap_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct mii_bus *bus = context;
+	u16 r1, r2, page;
+	int ret;
+
+	reg += QCA8K_CLK_REG_BASE;
+	split_addr(reg, &r1, &r2, &page);
+
+	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
+	ret = qca8k_mii_page_set(bus, QCA8K_HIGH_ADDR_PREFIX, QCA8K_CFG_PAGE_REG, page);
+	if (ret < 0)
+		goto qca8k_write_exit;
+
+	qca8k_mii_write(bus, QCA8K_LOW_ADDR_PREFIX | r2, r1, val);
+
+qca8k_write_exit:
+	mutex_unlock(&bus->mdio_lock);
+	return ret;
+};
+
+int qca8k_regmap_update_bits(void *context, unsigned int reg, unsigned int mask, unsigned int value)
+{
+	struct mii_bus *bus = context;
+	u16 r1, r2, page;
+	int ret;
+	u32 val;
+
+	reg += QCA8K_CLK_REG_BASE;
+	split_addr(reg, &r1, &r2, &page);
+
+	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
+	ret = qca8k_mii_page_set(bus, QCA8K_HIGH_ADDR_PREFIX, QCA8K_CFG_PAGE_REG, page);
+	if (ret < 0)
+		goto qca8k_update_exit;
+
+	ret = qca8k_mii_read(bus, QCA8K_LOW_ADDR_PREFIX | r2, r1, &val);
+	if (ret < 0)
+		goto qca8k_update_exit;
+
+	val &= ~mask;
+	val |= value;
+	qca8k_mii_write(bus, QCA8K_LOW_ADDR_PREFIX | r2, r1, val);
+
+qca8k_update_exit:
+	mutex_unlock(&bus->mdio_lock);
+	return ret;
+}
+
+static const struct regmap_config nss_cc_qca8k_regmap_config = {
+	.reg_bits = 12,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x30C,
+	.reg_read = qca8k_regmap_read,
+	.reg_write = qca8k_regmap_write,
+	.reg_update_bits = qca8k_regmap_update_bits,
+	.disable_locking = true,
+	.cache_type = REGCACHE_NONE,
+};
+
+static const struct qcom_cc_desc nss_cc_qca8k_desc = {
+	.config = &nss_cc_qca8k_regmap_config,
+	.clks = nss_cc_qca8k_clocks,
+	.num_clks = ARRAY_SIZE(nss_cc_qca8k_clocks),
+	.resets = nss_cc_qca8k_resets,
+	.num_resets = ARRAY_SIZE(nss_cc_qca8k_resets),
+};
+
+struct clk_hw *qcom_qca8k_clk_hw_get(struct of_phandle_args *clkspec, void *data)
+{
+	struct qcom_cc *cc = data;
+	unsigned int idx = clkspec->args[0];
+
+	if (idx >= cc->num_rclks) {
+		pr_err("%s: invalid index %u\n", __func__, idx);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return cc->rclks[idx] ? &cc->rclks[idx]->hw : ERR_PTR(-ENOENT);
+}
+
+static int nss_cc_qca8k_probe(struct mdio_device *mdiodev)
+{
+	struct device *dev = &mdiodev->dev;
+	struct regmap *regmap;
+	struct qcom_reset_controller *reset;
+	struct qcom_cc_desc desc = nss_cc_qca8k_desc;
+	size_t num_clks = desc.num_clks;
+	struct clk_regmap **rclks = desc.clks;
+	struct qcom_cc *cc;
+	int ret, i;
+
+	cc = devm_kzalloc(dev, sizeof(*cc), GFP_KERNEL);
+	if (!cc)
+		return -ENOMEM;
+
+	cc->rclks = rclks;
+	cc->num_rclks = num_clks;
+	reset = &cc->reset;
+
+	regmap = devm_regmap_init(dev, NULL, mdiodev->bus, desc.config);
+
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "Failed to init MDIO regmap\n");
+		return PTR_ERR(regmap);
+	}
+
+	reset->rcdev.of_node = dev->of_node;
+	reset->rcdev.dev = dev;
+	reset->rcdev.ops = &qcom_reset_ops;
+	reset->rcdev.owner = dev->driver->owner;
+	reset->rcdev.nr_resets = desc.num_resets;
+	reset->regmap = regmap;
+	reset->reset_map = desc.resets;
+
+	ret = devm_reset_controller_register(dev, &reset->rcdev);
+	if (ret) {
+		dev_err(dev, "Failed to register QCA8K reset controller: %d\n", ret);
+		return ret;
+	}
+
+	for (i = 0; i < num_clks; i++) {
+		if (!rclks[i])
+			continue;
+
+		ret = devm_clk_register_regmap(dev, rclks[i]);
+		if (ret) {
+			dev_err(dev, "Failed to regmap register for QCA8K clock: %d\n", ret);
+			return ret;
+		}
+	}
+
+	ret = devm_of_clk_add_hw_provider(dev, qcom_qca8k_clk_hw_get, cc);
+	if (ret) {
+		dev_err(dev, "Failed to register provider for QCA8K clock: %d\n", ret);
+		return ret;
+	}
+
+	dev_info(dev, "Registered NSSCC QCA8K clocks\n");
+	return ret;
+}
+
+static const struct of_device_id nss_cc_qca8k_match_table[] = {
+	{ .compatible = "qcom,nsscc-qca8k" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, nss_cc_qca8k_match_table);
+
+static struct mdio_driver nss_cc_qca8k_driver = {
+	.mdiodrv.driver = {
+		.name = "qcom,nsscc-qca8k",
+		.of_match_table	= nss_cc_qca8k_match_table,
+	},
+	.probe = nss_cc_qca8k_probe,
+};
+
+mdio_module_driver(nss_cc_qca8k_driver);
+
+MODULE_DESCRIPTION("QCOM NSS_CC QCA8K Driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

