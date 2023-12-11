Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F9F80C013
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 04:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbjLKDix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 22:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbjLKDil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 22:38:41 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EA211D;
        Sun, 10 Dec 2023 19:38:26 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BB3VsEr015033;
        Mon, 11 Dec 2023 03:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:date:subject:mime-version:content-type
        :content-transfer-encoding:message-id:references:in-reply-to:to
        :cc; s=qcppdkim1; bh=2X8q/urA3GwUBfD+OWepEs+Ctxz9D/0xSxxTR9mEVkc
        =; b=AGOXUWyJkDEgX/x3P2mMKsEbJrMY51TC9+FVjBvg9RVEsc4jab3Liq11I/O
        xZ/8MKb01czN7y1dsBE8irmFju9WHPedhdjz9C0BjucWps1cqZUc1WRz44j/k5k8
        64fN5yat+EHAygslxoNXZDEWfryEh6uRjg66mcxs0pUEnAPu/JrP+Y9eZ1Y5O1K/
        q/tQATwOUCzH8T0iwkis1Vtv1UJUzPYMBRTp4vD42gkpa9iJ+qxoUCMB4vQkJQ/h
        u762qsd8B+2As15voNaEsuKaAzOPGNiC4UFdQxUlKna9jez+DJcEm2VPvpIoHDqQ
        W1eS5hHNqOwrCdtf1Rj0iQGc6KA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uvnhdt5pv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 03:38:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BB3c8dA030421
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 03:38:08 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 10 Dec 2023 19:38:03 -0800
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date:   Mon, 11 Dec 2023 09:07:28 +0530
Subject: [PATCH v3 6/8] clk: qcom: add NSS clock Controller driver for
 Qualcomm IPQ5332
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231211-ipq5332-nsscc-v3-6-ad13bef9b137@quicinc.com>
References: <20231211-ipq5332-nsscc-v3-0-ad13bef9b137@quicinc.com>
In-Reply-To: <20231211-ipq5332-nsscc-v3-0-ad13bef9b137@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Kathiravan Thirumoorthy" <quic_kathirav@quicinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702265852; l=31768;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=bZc/xw0pC2tJlNlPXpICa3YAeW+35nXL3cR3aYEeH/s=;
 b=PeFhHw8TyNyuR8xcsdTWuh/iR/kMxIJIwuGHw6NY2M8tIBAfaUqTb2N4JWknR8jBe1fuYeFWM
 YqO07dqQFAHCvJPnYSgbruUrBhQIcSM+PZ2Pk2lyWm5xZskEiEfFs8m
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kgvVzrwStBewaJ2f3xelRmhVeAHZg-5I
X-Proofpoint-ORIG-GUID: kgvVzrwStBewaJ2f3xelRmhVeAHZg-5I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312110028
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Networking Sub System Clock Controller(NSSCC) driver for Qualcomm
IPQ5332 based devices.

Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
 drivers/clk/qcom/Kconfig         |    7 +
 drivers/clk/qcom/Makefile        |    1 +
 drivers/clk/qcom/nsscc-ipq5332.c | 1031 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 1039 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index dbc3950c5960..caea43e96f7d 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -162,6 +162,13 @@ config IPQ_GCC_5332
 	  Say Y if you want to use peripheral devices such as UART, SPI,
 	  i2c, USB, SD/eMMC, etc.
 
+config IPQ_NSSCC_5332
+	tristate "IPQ5332 NSS Clock Controller"
+	depends on ARM64 || COMPILE_TEST
+	depends on IPQ_GCC_5332
+	help
+	  Support for NSS clock controller on ipq5332 devices.
+
 config IPQ_GCC_6018
 	tristate "IPQ6018 Global Clock Controller"
 	help
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 17edd73f9839..3aab744ecc99 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_IPQ_GCC_806X) += gcc-ipq806x.o
 obj-$(CONFIG_IPQ_GCC_8074) += gcc-ipq8074.o
 obj-$(CONFIG_IPQ_GCC_9574) += gcc-ipq9574.o
 obj-$(CONFIG_IPQ_LCC_806X) += lcc-ipq806x.o
+obj-$(CONFIG_IPQ_NSSCC_5332) += nsscc-ipq5332.o
 obj-$(CONFIG_MDM_GCC_9607) += gcc-mdm9607.o
 obj-$(CONFIG_MDM_GCC_9615) += gcc-mdm9615.o
 obj-$(CONFIG_MSM_GCC_8660) += gcc-msm8660.o
diff --git a/drivers/clk/qcom/nsscc-ipq5332.c b/drivers/clk/qcom/nsscc-ipq5332.c
new file mode 100644
index 000000000000..c4a73447b1fa
--- /dev/null
+++ b/drivers/clk/qcom/nsscc-ipq5332.c
@@ -0,0 +1,1031 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022-2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/clock/qcom,ipq5332-nsscc.h>
+
+#include "clk-alpha-pll.h"
+#include "clk-branch.h"
+#include "clk-pll.h"
+#include "clk-rcg.h"
+#include "clk-regmap.h"
+#include "clk-regmap-divider.h"
+#include "clk-regmap-mux.h"
+#include "common.h"
+#include "reset.h"
+
+enum {
+	DT_CMN_PLL_NSS_CLK_200M,
+	DT_CMN_PLL_NSS_CLK_300M,
+	DT_GCC_GPLL0_OUT_AUX,
+	DT_UNIPHY0_NSS_TX_CLK,
+	DT_UNIPHY0_NSS_RX_CLK,
+	DT_UNIPHY1_NSS_TX_CLK,
+	DT_UNIPHY1_NSS_RX_CLK,
+	DT_XO,
+};
+
+enum {
+	P_CMN_PLL_NSS_CLK_200M,
+	P_CMN_PLL_NSS_CLK_300M,
+	P_GCC_GPLL0_OUT_AUX,
+	P_UNIPHY0_NSS_TX_CLK,
+	P_UNIPHY0_NSS_RX_CLK,
+	P_UNIPHY1_NSS_TX_CLK,
+	P_UNIPHY1_NSS_RX_CLK,
+	P_XO,
+};
+
+static const struct parent_map nss_cc_parent_map_0[] = {
+	{ P_XO, 0 },
+	{ P_GCC_GPLL0_OUT_AUX, 2 },
+	{ P_CMN_PLL_NSS_CLK_300M, 5 },
+	{ P_CMN_PLL_NSS_CLK_200M, 6 },
+};
+
+static const struct clk_parent_data nss_cc_parent_data_0[] = {
+	{ .index = DT_XO },
+	{ .index = DT_GCC_GPLL0_OUT_AUX },
+	{ .index = DT_CMN_PLL_NSS_CLK_300M },
+	{ .index = DT_CMN_PLL_NSS_CLK_200M },
+};
+
+static const struct parent_map nss_cc_parent_map_1[] = {
+	{ P_XO, 0 },
+	{ P_GCC_GPLL0_OUT_AUX, 2 },
+	{ P_UNIPHY0_NSS_RX_CLK, 3 },
+	{ P_UNIPHY0_NSS_TX_CLK, 4 },
+	{ P_CMN_PLL_NSS_CLK_300M, 5 },
+	{ P_CMN_PLL_NSS_CLK_200M, 6 },
+};
+
+static const struct clk_parent_data nss_cc_parent_data_1[] = {
+	{ .index = DT_XO },
+	{ .index = DT_GCC_GPLL0_OUT_AUX },
+	{ .index = DT_UNIPHY0_NSS_RX_CLK },
+	{ .index = DT_UNIPHY0_NSS_TX_CLK },
+	{ .index = DT_CMN_PLL_NSS_CLK_300M },
+	{ .index = DT_CMN_PLL_NSS_CLK_200M },
+};
+
+static const struct parent_map nss_cc_parent_map_2[] = {
+	{ P_XO, 0 },
+	{ P_GCC_GPLL0_OUT_AUX, 2 },
+	{ P_UNIPHY1_NSS_RX_CLK, 3 },
+	{ P_UNIPHY1_NSS_TX_CLK, 4 },
+	{ P_CMN_PLL_NSS_CLK_300M, 5 },
+	{ P_CMN_PLL_NSS_CLK_200M, 6 },
+};
+
+static const struct clk_parent_data nss_cc_parent_data_2[] = {
+	{ .index = DT_XO },
+	{ .index = DT_GCC_GPLL0_OUT_AUX },
+	{ .index = DT_UNIPHY1_NSS_RX_CLK },
+	{ .index = DT_UNIPHY1_NSS_TX_CLK },
+	{ .index = DT_CMN_PLL_NSS_CLK_300M },
+	{ .index = DT_CMN_PLL_NSS_CLK_200M },
+};
+
+static const struct freq_tbl ftbl_nss_cc_ce_clk_src[] = {
+	F(24000000, P_XO, 1, 0, 0),
+	F(200000000, P_CMN_PLL_NSS_CLK_200M, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 nss_cc_ce_clk_src = {
+	.cmd_rcgr = 0x518,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = nss_cc_parent_map_0,
+	.freq_tbl = ftbl_nss_cc_ce_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_ce_clk_src",
+		.parent_data = nss_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(nss_cc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_nss_cc_cfg_clk_src[] = {
+	F(100000000, P_GCC_GPLL0_OUT_AUX, 8, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 nss_cc_cfg_clk_src = {
+	.cmd_rcgr = 0x5e0,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = nss_cc_parent_map_0,
+	.freq_tbl = ftbl_nss_cc_cfg_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_cfg_clk_src",
+		.parent_data = nss_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(nss_cc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_nss_cc_eip_bfdcd_clk_src[] = {
+	F(300000000, P_CMN_PLL_NSS_CLK_300M, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 nss_cc_eip_bfdcd_clk_src = {
+	.cmd_rcgr = 0x57c,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = nss_cc_parent_map_0,
+	.freq_tbl = ftbl_nss_cc_eip_bfdcd_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_eip_bfdcd_clk_src",
+		.parent_data = nss_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(nss_cc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_conf ftbl_nss_cc_port1_rx_clk_src_25[] = {
+	C(P_UNIPHY0_NSS_RX_CLK, 12.5, 0, 0),
+	C(P_UNIPHY0_NSS_RX_CLK, 5, 0, 0),
+};
+
+static const struct freq_conf ftbl_nss_cc_port1_rx_clk_src_125[] = {
+	C(P_UNIPHY0_NSS_RX_CLK, 2.5, 0, 0),
+	C(P_UNIPHY0_NSS_RX_CLK, 1, 0, 0),
+};
+
+static const struct freq_multi_tbl ftbl_nss_cc_port1_rx_clk_src[] = {
+	FMS(24000000, P_XO, 1, 0, 0),
+	FM(25000000, ftbl_nss_cc_port1_rx_clk_src_25),
+	FMS(78125000, P_UNIPHY0_NSS_RX_CLK, 4, 0, 0),
+	FM(125000000, ftbl_nss_cc_port1_rx_clk_src_125),
+	FMS(156250000, P_UNIPHY0_NSS_RX_CLK, 2, 0, 0),
+	FMS(312500000, P_UNIPHY0_NSS_RX_CLK, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 nss_cc_port1_rx_clk_src = {
+	.cmd_rcgr = 0x450,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = nss_cc_parent_map_1,
+	.freq_multi_tbl = ftbl_nss_cc_port1_rx_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_port1_rx_clk_src",
+		.parent_data = nss_cc_parent_data_1,
+		.num_parents = ARRAY_SIZE(nss_cc_parent_data_1),
+		.ops = &clk_rcg2_fm_ops,
+	},
+};
+
+static const struct freq_conf ftbl_nss_cc_port1_tx_clk_src_25[] = {
+	C(P_UNIPHY0_NSS_TX_CLK, 12.5, 0, 0),
+	C(P_UNIPHY0_NSS_TX_CLK, 5, 0, 0),
+};
+
+static const struct freq_conf ftbl_nss_cc_port1_tx_clk_src_125[] = {
+	C(P_UNIPHY0_NSS_TX_CLK, 2.5, 0, 0),
+	C(P_UNIPHY0_NSS_TX_CLK, 1, 0, 0),
+};
+
+static const struct freq_multi_tbl ftbl_nss_cc_port1_tx_clk_src[] = {
+	FMS(24000000, P_XO, 1, 0, 0),
+	FM(25000000, ftbl_nss_cc_port1_tx_clk_src_25),
+	FMS(78125000, P_UNIPHY0_NSS_TX_CLK, 4, 0, 0),
+	FM(125000000, ftbl_nss_cc_port1_tx_clk_src_125),
+	FMS(156250000, P_UNIPHY0_NSS_TX_CLK, 2, 0, 0),
+	FMS(312500000, P_UNIPHY0_NSS_TX_CLK, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 nss_cc_port1_tx_clk_src = {
+	.cmd_rcgr = 0x45c,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = nss_cc_parent_map_1,
+	.freq_multi_tbl = ftbl_nss_cc_port1_tx_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_port1_tx_clk_src",
+		.parent_data = nss_cc_parent_data_1,
+		.num_parents = ARRAY_SIZE(nss_cc_parent_data_1),
+		.ops = &clk_rcg2_fm_ops,
+	},
+};
+
+static const struct freq_conf ftbl_nss_cc_port2_rx_clk_src_25[] = {
+	C(P_UNIPHY1_NSS_RX_CLK, 12.5, 0, 0),
+	C(P_UNIPHY1_NSS_RX_CLK, 5, 0, 0),
+};
+
+static const struct freq_conf ftbl_nss_cc_port2_rx_clk_src_125[] = {
+	C(P_UNIPHY1_NSS_RX_CLK, 2.5, 0, 0),
+	C(P_UNIPHY1_NSS_RX_CLK, 1, 0, 0),
+};
+
+static const struct freq_multi_tbl ftbl_nss_cc_port2_rx_clk_src[] = {
+	FMS(24000000, P_XO, 1, 0, 0),
+	FM(25000000, ftbl_nss_cc_port2_rx_clk_src_25),
+	FMS(78125000, P_UNIPHY1_NSS_RX_CLK, 4, 0, 0),
+	FM(125000000, ftbl_nss_cc_port2_rx_clk_src_125),
+	FMS(156250000, P_UNIPHY1_NSS_RX_CLK, 2, 0, 0),
+	FMS(312500000, P_UNIPHY1_NSS_RX_CLK, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 nss_cc_port2_rx_clk_src = {
+	.cmd_rcgr = 0x468,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = nss_cc_parent_map_2,
+	.freq_multi_tbl = ftbl_nss_cc_port2_rx_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_port2_rx_clk_src",
+		.parent_data = nss_cc_parent_data_2,
+		.num_parents = ARRAY_SIZE(nss_cc_parent_data_2),
+		.ops = &clk_rcg2_fm_ops,
+	},
+};
+
+static const struct freq_conf ftbl_nss_cc_port2_tx_clk_src_25[] = {
+	C(P_UNIPHY1_NSS_TX_CLK, 12.5, 0, 0),
+	C(P_UNIPHY1_NSS_TX_CLK, 5, 0, 0),
+};
+
+static const struct freq_conf ftbl_nss_cc_port2_tx_clk_src_125[] = {
+	C(P_UNIPHY1_NSS_TX_CLK, 2.5, 0, 0),
+	C(P_UNIPHY1_NSS_TX_CLK, 1, 0, 0),
+};
+
+static const struct freq_multi_tbl ftbl_nss_cc_port2_tx_clk_src[] = {
+	FMS(24000000, P_XO, 1, 0, 0),
+	FM(25000000, ftbl_nss_cc_port2_tx_clk_src_25),
+	FMS(78125000, P_UNIPHY1_NSS_TX_CLK, 4, 0, 0),
+	FM(125000000, ftbl_nss_cc_port2_tx_clk_src_125),
+	FMS(156250000, P_UNIPHY1_NSS_TX_CLK, 2, 0, 0),
+	FMS(312500000, P_UNIPHY1_NSS_TX_CLK, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 nss_cc_port2_tx_clk_src = {
+	.cmd_rcgr = 0x474,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = nss_cc_parent_map_2,
+	.freq_multi_tbl = ftbl_nss_cc_port2_tx_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_port2_tx_clk_src",
+		.parent_data = nss_cc_parent_data_2,
+		.num_parents = ARRAY_SIZE(nss_cc_parent_data_2),
+		.ops = &clk_rcg2_fm_ops,
+	},
+};
+
+static struct clk_rcg2 nss_cc_ppe_clk_src = {
+	.cmd_rcgr = 0x3e8,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = nss_cc_parent_map_0,
+	.freq_tbl = ftbl_nss_cc_ce_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_ppe_clk_src",
+		.parent_data = nss_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(nss_cc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_port1_rx_div_clk_src = {
+	.reg = 0x458,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_port1_rx_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]) {
+			&nss_cc_port1_rx_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_port1_tx_div_clk_src = {
+	.reg = 0x464,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_port1_tx_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]) {
+			&nss_cc_port1_tx_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_port2_rx_div_clk_src = {
+	.reg = 0x470,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_port2_rx_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]) {
+			&nss_cc_port2_rx_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_port2_tx_div_clk_src = {
+	.reg = 0x47c,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_port2_tx_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]) {
+			&nss_cc_port2_tx_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_xgmac0_ptp_ref_div_clk_src = {
+	.reg = 0x3f0,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_xgmac0_ptp_ref_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]) {
+			&nss_cc_ppe_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ro_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_xgmac1_ptp_ref_div_clk_src = {
+	.reg = 0x3f4,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_xgmac1_ptp_ref_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]) {
+			&nss_cc_ppe_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ro_ops,
+	},
+};
+
+static struct clk_branch nss_cc_ce_apb_clk = {
+	.halt_reg = 0x520,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x520,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_ce_apb_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&nss_cc_ce_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_ce_axi_clk = {
+	.halt_reg = 0x524,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x524,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_ce_axi_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&nss_cc_ce_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_debug_clk = {
+	.halt_reg = 0x644,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x644,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_debug_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_eip_clk = {
+	.halt_reg = 0x590,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x590,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_eip_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&nss_cc_eip_bfdcd_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_nss_csr_clk = {
+	.halt_reg = 0x5e8,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x5e8,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_nss_csr_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&nss_cc_cfg_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_nssnoc_ce_apb_clk = {
+	.halt_reg = 0x52c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x52c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_nssnoc_ce_apb_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&nss_cc_ce_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_nssnoc_ce_axi_clk = {
+	.halt_reg = 0x530,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x530,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_nssnoc_ce_axi_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&nss_cc_ce_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_nssnoc_eip_clk = {
+	.halt_reg = 0x598,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x598,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_nssnoc_eip_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&nss_cc_eip_bfdcd_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_nssnoc_nss_csr_clk = {
+	.halt_reg = 0x5ec,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x5ec,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_nssnoc_nss_csr_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&nss_cc_cfg_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_nssnoc_ppe_cfg_clk = {
+	.halt_reg = 0x424,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x424,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_nssnoc_ppe_cfg_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&nss_cc_ppe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_nssnoc_ppe_clk = {
+	.halt_reg = 0x420,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x420,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_nssnoc_ppe_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&nss_cc_ppe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_port1_mac_clk = {
+	.halt_reg = 0x428,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x428,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_port1_mac_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&nss_cc_ppe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_port1_rx_clk = {
+	.halt_reg = 0x480,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x480,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_port1_rx_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&nss_cc_port1_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_port1_tx_clk = {
+	.halt_reg = 0x488,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x488,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_port1_tx_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&nss_cc_port1_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_port2_mac_clk = {
+	.halt_reg = 0x430,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x430,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_port2_mac_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&nss_cc_ppe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_port2_rx_clk = {
+	.halt_reg = 0x490,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x490,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_port2_rx_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&nss_cc_port2_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_port2_tx_clk = {
+	.halt_reg = 0x498,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x498,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_port2_tx_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&nss_cc_port2_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_ppe_edma_cfg_clk = {
+	.halt_reg = 0x41c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x41c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_ppe_edma_cfg_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&nss_cc_ppe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_ppe_edma_clk = {
+	.halt_reg = 0x414,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x414,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_ppe_edma_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&nss_cc_ppe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_ppe_switch_btq_clk = {
+	.halt_reg = 0x400,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x400,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_ppe_switch_btq_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&nss_cc_ppe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_ppe_switch_cfg_clk = {
+	.halt_reg = 0x410,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x410,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_ppe_switch_cfg_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&nss_cc_ppe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_ppe_switch_clk = {
+	.halt_reg = 0x408,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x408,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_ppe_switch_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&nss_cc_ppe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_ppe_switch_ipe_clk = {
+	.halt_reg = 0x3f8,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3f8,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_ppe_switch_ipe_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&nss_cc_ppe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_uniphy_port1_rx_clk = {
+	.halt_reg = 0x4b4,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x4b4,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_uniphy_port1_rx_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&nss_cc_port1_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_uniphy_port1_tx_clk = {
+	.halt_reg = 0x4b8,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x4b8,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_uniphy_port1_tx_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&nss_cc_port1_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_uniphy_port2_rx_clk = {
+	.halt_reg = 0x4bc,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x4bc,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_uniphy_port2_rx_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&nss_cc_port2_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_uniphy_port2_tx_clk = {
+	.halt_reg = 0x4c0,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x4c0,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_uniphy_port2_tx_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&nss_cc_port2_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_xgmac0_ptp_ref_clk = {
+	.halt_reg = 0x438,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x438,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_xgmac0_ptp_ref_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&nss_cc_xgmac0_ptp_ref_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_xgmac1_ptp_ref_clk = {
+	.halt_reg = 0x43c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x43c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_xgmac1_ptp_ref_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&nss_cc_xgmac1_ptp_ref_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_regmap *nss_cc_ipq5332_clocks[] = {
+	[NSS_CC_CE_APB_CLK] = &nss_cc_ce_apb_clk.clkr,
+	[NSS_CC_CE_AXI_CLK] = &nss_cc_ce_axi_clk.clkr,
+	[NSS_CC_CE_CLK_SRC] = &nss_cc_ce_clk_src.clkr,
+	[NSS_CC_CFG_CLK_SRC] = &nss_cc_cfg_clk_src.clkr,
+	[NSS_CC_DEBUG_CLK] = &nss_cc_debug_clk.clkr,
+	[NSS_CC_EIP_BFDCD_CLK_SRC] = &nss_cc_eip_bfdcd_clk_src.clkr,
+	[NSS_CC_EIP_CLK] = &nss_cc_eip_clk.clkr,
+	[NSS_CC_NSS_CSR_CLK] = &nss_cc_nss_csr_clk.clkr,
+	[NSS_CC_NSSNOC_CE_APB_CLK] = &nss_cc_nssnoc_ce_apb_clk.clkr,
+	[NSS_CC_NSSNOC_CE_AXI_CLK] = &nss_cc_nssnoc_ce_axi_clk.clkr,
+	[NSS_CC_NSSNOC_EIP_CLK] = &nss_cc_nssnoc_eip_clk.clkr,
+	[NSS_CC_NSSNOC_NSS_CSR_CLK] = &nss_cc_nssnoc_nss_csr_clk.clkr,
+	[NSS_CC_NSSNOC_PPE_CFG_CLK] = &nss_cc_nssnoc_ppe_cfg_clk.clkr,
+	[NSS_CC_NSSNOC_PPE_CLK] = &nss_cc_nssnoc_ppe_clk.clkr,
+	[NSS_CC_PORT1_MAC_CLK] = &nss_cc_port1_mac_clk.clkr,
+	[NSS_CC_PORT1_RX_CLK] = &nss_cc_port1_rx_clk.clkr,
+	[NSS_CC_PORT1_RX_CLK_SRC] = &nss_cc_port1_rx_clk_src.clkr,
+	[NSS_CC_PORT1_RX_DIV_CLK_SRC] = &nss_cc_port1_rx_div_clk_src.clkr,
+	[NSS_CC_PORT1_TX_CLK] = &nss_cc_port1_tx_clk.clkr,
+	[NSS_CC_PORT1_TX_CLK_SRC] = &nss_cc_port1_tx_clk_src.clkr,
+	[NSS_CC_PORT1_TX_DIV_CLK_SRC] = &nss_cc_port1_tx_div_clk_src.clkr,
+	[NSS_CC_PORT2_MAC_CLK] = &nss_cc_port2_mac_clk.clkr,
+	[NSS_CC_PORT2_RX_CLK] = &nss_cc_port2_rx_clk.clkr,
+	[NSS_CC_PORT2_RX_CLK_SRC] = &nss_cc_port2_rx_clk_src.clkr,
+	[NSS_CC_PORT2_RX_DIV_CLK_SRC] = &nss_cc_port2_rx_div_clk_src.clkr,
+	[NSS_CC_PORT2_TX_CLK] = &nss_cc_port2_tx_clk.clkr,
+	[NSS_CC_PORT2_TX_CLK_SRC] = &nss_cc_port2_tx_clk_src.clkr,
+	[NSS_CC_PORT2_TX_DIV_CLK_SRC] = &nss_cc_port2_tx_div_clk_src.clkr,
+	[NSS_CC_PPE_CLK_SRC] = &nss_cc_ppe_clk_src.clkr,
+	[NSS_CC_PPE_EDMA_CFG_CLK] = &nss_cc_ppe_edma_cfg_clk.clkr,
+	[NSS_CC_PPE_EDMA_CLK] = &nss_cc_ppe_edma_clk.clkr,
+	[NSS_CC_PPE_SWITCH_BTQ_CLK] = &nss_cc_ppe_switch_btq_clk.clkr,
+	[NSS_CC_PPE_SWITCH_CFG_CLK] = &nss_cc_ppe_switch_cfg_clk.clkr,
+	[NSS_CC_PPE_SWITCH_CLK] = &nss_cc_ppe_switch_clk.clkr,
+	[NSS_CC_PPE_SWITCH_IPE_CLK] = &nss_cc_ppe_switch_ipe_clk.clkr,
+	[NSS_CC_UNIPHY_PORT1_RX_CLK] = &nss_cc_uniphy_port1_rx_clk.clkr,
+	[NSS_CC_UNIPHY_PORT1_TX_CLK] = &nss_cc_uniphy_port1_tx_clk.clkr,
+	[NSS_CC_UNIPHY_PORT2_RX_CLK] = &nss_cc_uniphy_port2_rx_clk.clkr,
+	[NSS_CC_UNIPHY_PORT2_TX_CLK] = &nss_cc_uniphy_port2_tx_clk.clkr,
+	[NSS_CC_XGMAC0_PTP_REF_CLK] = &nss_cc_xgmac0_ptp_ref_clk.clkr,
+	[NSS_CC_XGMAC0_PTP_REF_DIV_CLK_SRC] = &nss_cc_xgmac0_ptp_ref_div_clk_src.clkr,
+	[NSS_CC_XGMAC1_PTP_REF_CLK] = &nss_cc_xgmac1_ptp_ref_clk.clkr,
+	[NSS_CC_XGMAC1_PTP_REF_DIV_CLK_SRC] = &nss_cc_xgmac1_ptp_ref_div_clk_src.clkr,
+};
+
+static const struct qcom_reset_map nss_cc_ipq5332_resets[] = {
+	[NSS_CC_CE_APB_CLK_ARES] = { 0x520, 2 },
+	[NSS_CC_CE_AXI_CLK_ARES] = { 0x524, 2 },
+	[NSS_CC_DEBUG_CLK_ARES] = { 0x644, 2 },
+	[NSS_CC_EIP_CLK_ARES] = { 0x590, 2 },
+	[NSS_CC_NSS_CSR_CLK_ARES] = { 0x5e8, 2 },
+	[NSS_CC_NSSNOC_CE_APB_CLK_ARES] = { 0x52c, 2 },
+	[NSS_CC_NSSNOC_CE_AXI_CLK_ARES] = { 0x530, 2 },
+	[NSS_CC_NSSNOC_EIP_CLK_ARES] = { 0x598, 2 },
+	[NSS_CC_NSSNOC_NSS_CSR_CLK_ARES] = { 0x5ec, 2 },
+	[NSS_CC_NSSNOC_PPE_CLK_ARES] = { 0x420, 2 },
+	[NSS_CC_NSSNOC_PPE_CFG_CLK_ARES] = { 0x424, 2 },
+	[NSS_CC_PORT1_MAC_CLK_ARES] = { 0x428, 2 },
+	[NSS_CC_PORT1_RX_CLK_ARES] = { 0x480, 2 },
+	[NSS_CC_PORT1_TX_CLK_ARES] = { 0x488, 2 },
+	[NSS_CC_PORT2_MAC_CLK_ARES] = { 0x430, 2 },
+	[NSS_CC_PORT2_RX_CLK_ARES] = { 0x490, 2 },
+	[NSS_CC_PORT2_TX_CLK_ARES] = { 0x498, 2 },
+	[NSS_CC_PPE_BCR] = { 0x3e4 },
+	[NSS_CC_PPE_EDMA_CLK_ARES] = { 0x414, 2 },
+	[NSS_CC_PPE_EDMA_CFG_CLK_ARES] = { 0x41c, 2 },
+	[NSS_CC_PPE_SWITCH_BTQ_CLK_ARES] = { 0x400, 2 },
+	[NSS_CC_PPE_SWITCH_CLK_ARES] = { 0x408, 2 },
+	[NSS_CC_PPE_SWITCH_CFG_CLK_ARES] = { 0x410, 2 },
+	[NSS_CC_PPE_SWITCH_IPE_CLK_ARES] = { 0x3f8, 2 },
+	[NSS_CC_UNIPHY_PORT1_RX_CLK_ARES] = { 0x4b4, 2 },
+	[NSS_CC_UNIPHY_PORT1_TX_CLK_ARES] = { 0x4b8, 2 },
+	[NSS_CC_UNIPHY_PORT2_RX_CLK_ARES] = { 0x4bc, 2 },
+	[NSS_CC_UNIPHY_PORT2_TX_CLK_ARES] = { 0x4c0, 2 },
+	[NSS_CC_XGMAC0_PTP_REF_CLK_ARES] = { 0x438, 2 },
+	[NSS_CC_XGMAC1_PTP_REF_CLK_ARES] = { 0x43c, 2 },
+};
+
+static const struct regmap_config nss_cc_ipq5332_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x800,
+	.fast_io = true,
+};
+
+static const struct qcom_cc_desc nss_cc_ipq5332_desc = {
+	.config = &nss_cc_ipq5332_regmap_config,
+	.clks = nss_cc_ipq5332_clocks,
+	.num_clks = ARRAY_SIZE(nss_cc_ipq5332_clocks),
+	.resets = nss_cc_ipq5332_resets,
+	.num_resets = ARRAY_SIZE(nss_cc_ipq5332_resets),
+};
+
+static const struct of_device_id nss_cc_ipq5332_match_table[] = {
+	{ .compatible = "qcom,ipq5332-nsscc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, nss_cc_ipq5332_match_table);
+
+static int nss_cc_ipq5332_probe(struct platform_device *pdev)
+{
+	return qcom_cc_probe(pdev, &nss_cc_ipq5332_desc);
+}
+
+static struct platform_driver nss_cc_ipq5332_driver = {
+	.probe = nss_cc_ipq5332_probe,
+	.driver = {
+		.name = "qcom,ipq5332-nsscc",
+		.of_match_table = nss_cc_ipq5332_match_table,
+	},
+};
+module_platform_driver(nss_cc_ipq5332_driver);
+
+MODULE_DESCRIPTION("QTI NSSCC IPQ5332 Driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1

