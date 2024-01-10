Return-Path: <linux-kernel+bounces-22126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E88D8299BB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB3D1F23088
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D244CE0F;
	Wed, 10 Jan 2024 11:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PZcGDNpU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B36547F63;
	Wed, 10 Jan 2024 11:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40AAhJ54012660;
	Wed, 10 Jan 2024 11:43:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=mR0EQunaFH97FyG1JaAfwzha9HvZ8unUPHG4d5bgYm8=; b=PZ
	cGDNpUKDe0AjzqPjYeNAInfGqMBFuLQZtG6RnN53FNRRNFNwtHKjvrET54D40tKz
	HLNb4F3FlbHx3CxU7t2YLWxl5nBLlAPuQnsNZBqduz1gBW4cUKWiMy6ZGiSOK3D1
	BVTfh6feWBqkuQ56XgZ6EU2AVXpD7lpJ1QvAxtE2O76xVaH/BpsgrklFB2hfZsNb
	OuYRXtkA31XlZf4cTtDkJOoim202vpPoKPNVcO0XONwdeGQpcpoJngnf/SNTFhjx
	GxF/M6awEQMG9xHSl4t6mhFKTkIXvvaqgjQHmXw1vY80c254P7YEJoODo8BaIdfS
	QpbWlHLaQF8N8gLw5ODA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhsqyr4by-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:43:58 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40ABhuXu020445
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:43:56 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 03:43:46 -0800
From: Luo Jie <quic_luoj@quicinc.com>
To: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <linux@armlinux.org.uk>,
        <shannon.nelson@amd.com>, <anthony.l.nguyen@intel.com>,
        <jasowang@redhat.com>, <brett.creeley@amd.com>,
        <rrameshbabu@nvidia.com>, <joshua.a.hay@intel.com>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <neil.armstrong@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <nfraprado@collabora.com>,
        <m.szyprowski@samsung.com>, <u-kumar1@ti.com>,
        <jacob.e.keller@intel.com>, <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <ryazanov.s.a@gmail.com>, <ansuelsmth@gmail.com>,
        <quic_kkumarcs@quicinc.com>, <quic_suruchia@quicinc.com>,
        <quic_soni@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_souravp@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_leiwei@quicinc.com>
Subject: [PATCH net-next 17/20] net: ethernet: qualcomm: Add PPE UNIPHY support for phylink
Date: Wed, 10 Jan 2024 19:40:29 +0800
Message-ID: <20240110114033.32575-18-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240110114033.32575-1-quic_luoj@quicinc.com>
References: <20240110114033.32575-1-quic_luoj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UzY1SN_vGJVQmRfWn1VIHp-WRDy6hzEd
X-Proofpoint-ORIG-GUID: UzY1SN_vGJVQmRfWn1VIHp-WRDy6hzEd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100096

From: Lei Wei <quic_leiwei@quicinc.com>

This driver adds support for PPE UNIPHY initialization and UNIPHY
PCS operations which used by phylink.

PPE supports maximum 6 GMAC or XGMAC ports which can be connected
with maximum 3 UNIPHYs. The UNIPHY registers and provides raw clock
to feeds NCCSS clocks to provide different clocks to PPE ports in
different link speed.

Signed-off-by: Lei Wei <quic_leiwei@quicinc.com>
Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/ethernet/qualcomm/ppe/Makefile    |   2 +-
 drivers/net/ethernet/qualcomm/ppe/ppe.c       |  25 +
 drivers/net/ethernet/qualcomm/ppe/ppe.h       |   2 +
 .../net/ethernet/qualcomm/ppe/ppe_uniphy.c    | 789 ++++++++++++++++++
 .../net/ethernet/qualcomm/ppe/ppe_uniphy.h    | 227 +++++
 include/linux/soc/qcom/ppe.h                  |   1 +
 6 files changed, 1045 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/qualcomm/ppe/ppe_uniphy.c
 create mode 100644 drivers/net/ethernet/qualcomm/ppe/ppe_uniphy.h

diff --git a/drivers/net/ethernet/qualcomm/ppe/Makefile b/drivers/net/ethernet/qualcomm/ppe/Makefile
index 516ea23443ab..487f62d5e38c 100644
--- a/drivers/net/ethernet/qualcomm/ppe/Makefile
+++ b/drivers/net/ethernet/qualcomm/ppe/Makefile
@@ -4,4 +4,4 @@
 #
 
 obj-$(CONFIG_QCOM_PPE) += qcom-ppe.o
-qcom-ppe-objs := ppe.o ppe_ops.o ppe_debugfs.o
+qcom-ppe-objs := ppe.o ppe_ops.o ppe_debugfs.o ppe_uniphy.o
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.c b/drivers/net/ethernet/qualcomm/ppe/ppe.c
index 04f80589c05b..21040efe71fc 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe.c
@@ -18,6 +18,7 @@
 #include "ppe_regs.h"
 #include "ppe_ops.h"
 #include "ppe_debugfs.h"
+#include "ppe_uniphy.h"
 
 #define PPE_SCHEDULER_PORT_NUM		8
 #define MPPE_SCHEDULER_PORT_NUM		3
@@ -176,6 +177,26 @@ int ppe_type_get(struct ppe_device *ppe_dev)
 	return ppe_dev_priv->ppe_type;
 }
 
+struct clk **ppe_clock_get(struct ppe_device *ppe_dev)
+{
+	struct ppe_data *ppe_dev_priv = ppe_dev->ppe_priv;
+
+	if (!ppe_dev_priv)
+		return NULL;
+
+	return ppe_dev_priv->clk;
+}
+
+struct reset_control **ppe_reset_get(struct ppe_device *ppe_dev)
+{
+	struct ppe_data *ppe_dev_priv = ppe_dev->ppe_priv;
+
+	if (!ppe_dev_priv)
+		return NULL;
+
+	return ppe_dev_priv->rst;
+}
+
 static int ppe_clock_set_enable(struct ppe_device *ppe_dev,
 				enum ppe_clk_id clk_id, unsigned long rate)
 {
@@ -1405,6 +1426,10 @@ static int qcom_ppe_probe(struct platform_device *pdev)
 				     ret,
 				     "ppe device hw init failed\n");
 
+	ppe_dev->uniphy = ppe_uniphy_setup(pdev);
+	if (IS_ERR(ppe_dev->uniphy))
+		return dev_err_probe(&pdev->dev, ret, "ppe uniphy initialization failed\n");
+
 	ppe_dev->ppe_ops = &qcom_ppe_ops;
 	ppe_dev->is_ppe_probed = true;
 	ppe_debugfs_setup(ppe_dev);
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.h b/drivers/net/ethernet/qualcomm/ppe/ppe.h
index 828d467540c9..45b70f47cd21 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe.h
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe.h
@@ -173,6 +173,8 @@ struct ppe_scheduler_port_resource {
 };
 
 int ppe_type_get(struct ppe_device *ppe_dev);
+struct clk **ppe_clock_get(struct ppe_device *ppe_dev);
+struct reset_control **ppe_reset_get(struct ppe_device *ppe_dev);
 
 int ppe_write(struct ppe_device *ppe_dev, u32 reg, unsigned int val);
 int ppe_read(struct ppe_device *ppe_dev, u32 reg, unsigned int *val);
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_uniphy.c b/drivers/net/ethernet/qualcomm/ppe/ppe_uniphy.c
new file mode 100644
index 000000000000..3a2b6fc77a9c
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_uniphy.c
@@ -0,0 +1,789 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/* PPE UNIPHY clock register and UNIPHY PCS operations for phylink.
+ *
+ * The PPE UNIPHY block is specifically used by PPE to connect the PPE MAC
+ * with the external PHYs or SFPs or Switches (fixed link). The PPE UNIPHY
+ * block includes serdes, PCS or XPCS and the control logic to support PPE
+ * ports to work in different interface mode and different link speed.
+ *
+ * The PPE UNIPHY block provides raw clock as the parent clock to NSSCC
+ * clocks and the NSSCC clocks can be configured to generate different
+ * port Tx and Rx clocks to PPE ports in different port link speed.
+ */
+
+#include <linux/clk.h>
+#include <linux/reset.h>
+#include <linux/clk-provider.h>
+#include <linux/soc/qcom/ppe.h>
+#include "ppe.h"
+#include "ppe_uniphy.h"
+
+/* UNIPHY clock direction */
+enum {
+	UNIPHY_RX = 0,
+	UNIPHY_TX,
+};
+
+/* UNIPHY clock data type */
+struct clk_uniphy {
+	struct clk_hw hw;
+	u8 index;
+	u8 dir;
+	unsigned long rate;
+};
+
+#define to_clk_uniphy(_hw)		container_of(_hw, struct clk_uniphy, hw)
+/* UNIPHY clock rate */
+#define UNIPHY_CLK_RATE_125M		125000000
+#define UNIPHY_CLK_RATE_312P5M		312500000
+
+static void ppe_uniphy_write(struct ppe_uniphy *uniphy, u32 val, u32 reg)
+{
+	if (reg >= UNIPHY_INDIRECT_ADDR_START) {
+		writel(FIELD_GET(UNIPHY_INDIRECT_ADDR_HIGH, reg),
+		       uniphy->base + UNIPHY_INDIRECT_AHB_ADDR);
+		writel(val, uniphy->base + UNIPHY_INDIRECT_DATA_ADDR(reg));
+	} else {
+		writel(val, uniphy->base + reg);
+	}
+}
+
+static u32 ppe_uniphy_read(struct ppe_uniphy *uniphy, u32 reg)
+{
+	if (reg >= UNIPHY_INDIRECT_ADDR_START) {
+		writel(FIELD_GET(UNIPHY_INDIRECT_ADDR_HIGH, reg),
+		       uniphy->base + UNIPHY_INDIRECT_AHB_ADDR);
+		return readl(uniphy->base + UNIPHY_INDIRECT_DATA_ADDR(reg));
+	} else {
+		return readl(uniphy->base + reg);
+	}
+}
+
+static int ppe_uniphy_mask(struct ppe_uniphy *uniphy, u32 reg, u32 mask, u32 set)
+{
+	u32 val;
+
+	val = ppe_uniphy_read(uniphy, reg);
+	val &= ~mask;
+	val |= set;
+	ppe_uniphy_write(uniphy, val, reg);
+
+	return 0;
+}
+
+static unsigned long clk_uniphy_recalc_rate(struct clk_hw *hw,
+					    unsigned long parent_rate)
+{
+	struct clk_uniphy *uniphy = to_clk_uniphy(hw);
+
+	return uniphy->rate;
+}
+
+static int clk_uniphy_determine_rate(struct clk_hw *hw,
+				     struct clk_rate_request *req)
+{
+	if (req->rate <= UNIPHY_CLK_RATE_125M)
+		req->rate = UNIPHY_CLK_RATE_125M;
+	else
+		req->rate = UNIPHY_CLK_RATE_312P5M;
+
+	return 0;
+}
+
+static int clk_uniphy_set_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long parent_rate)
+{
+	struct clk_uniphy *uniphy = to_clk_uniphy(hw);
+
+	if (rate != UNIPHY_CLK_RATE_125M && rate != UNIPHY_CLK_RATE_312P5M)
+		return -1;
+
+	uniphy->rate = rate;
+
+	return 0;
+}
+
+static const struct clk_ops clk_uniphy_ops = {
+	.recalc_rate = clk_uniphy_recalc_rate,
+	.determine_rate = clk_uniphy_determine_rate,
+	.set_rate = clk_uniphy_set_rate,
+};
+
+static struct clk_uniphy uniphy0_gcc_rx_clk = {
+	.hw.init = &(struct clk_init_data){
+		.name = "uniphy0_gcc_rx_clk",
+		.ops = &clk_uniphy_ops,
+	},
+	.index = 0,
+	.dir = UNIPHY_RX,
+	.rate = UNIPHY_CLK_RATE_125M,
+};
+
+static struct clk_uniphy uniphy0_gcc_tx_clk = {
+	.hw.init = &(struct clk_init_data){
+		.name = "uniphy0_gcc_tx_clk",
+		.ops = &clk_uniphy_ops,
+	},
+	.index = 0,
+	.dir = UNIPHY_TX,
+	.rate = UNIPHY_CLK_RATE_125M,
+};
+
+static struct clk_uniphy uniphy1_gcc_rx_clk = {
+	.hw.init = &(struct clk_init_data){
+		.name = "uniphy1_gcc_rx_clk",
+		.ops = &clk_uniphy_ops,
+	},
+	.index = 1,
+	.dir = UNIPHY_RX,
+	.rate = UNIPHY_CLK_RATE_312P5M,
+};
+
+static struct clk_uniphy uniphy1_gcc_tx_clk = {
+	.hw.init = &(struct clk_init_data){
+		.name = "uniphy1_gcc_tx_clk",
+		.ops = &clk_uniphy_ops,
+	},
+	.index = 1,
+	.dir = UNIPHY_TX,
+	.rate = UNIPHY_CLK_RATE_312P5M,
+};
+
+static struct clk_uniphy uniphy2_gcc_rx_clk = {
+	.hw.init = &(struct clk_init_data){
+		.name = "uniphy2_gcc_rx_clk",
+		.ops = &clk_uniphy_ops,
+	},
+	.index = 2,
+	.dir = UNIPHY_RX,
+	.rate = UNIPHY_CLK_RATE_312P5M,
+};
+
+static struct clk_uniphy uniphy2_gcc_tx_clk = {
+	.hw.init = &(struct clk_init_data){
+		.name = "uniphy2_gcc_tx_clk",
+		.ops = &clk_uniphy_ops,
+	},
+	.index = 2,
+	.dir = UNIPHY_TX,
+	.rate = UNIPHY_CLK_RATE_312P5M,
+};
+
+static struct clk_hw *uniphy_raw_clks[] = {
+	&uniphy0_gcc_rx_clk.hw, &uniphy0_gcc_tx_clk.hw,
+	&uniphy1_gcc_rx_clk.hw, &uniphy1_gcc_tx_clk.hw,
+	&uniphy2_gcc_rx_clk.hw, &uniphy2_gcc_tx_clk.hw,
+};
+
+int ppe_uniphy_port_gcc_clock_en_set(struct ppe_uniphy *uniphy, int port, bool enable)
+{
+	struct clk **clock = ppe_clock_get(uniphy->ppe_dev);
+	enum ppe_clk_id rx_id, tx_id;
+	int err = 0;
+
+	rx_id = PPE_UNIPHY_PORT1_RX_CLK + ((port - 1) << 1);
+	tx_id = PPE_UNIPHY_PORT1_TX_CLK + ((port - 1) << 1);
+
+	if (enable) {
+		if (!IS_ERR(clock[rx_id])) {
+			err = clk_prepare_enable(clock[rx_id]);
+			if (err) {
+				dev_err(uniphy->ppe_dev->dev,
+					"Failed to enable uniphy port %d rx_clk(%d)\n",
+					port, rx_id);
+				return err;
+			}
+		}
+
+		if (!IS_ERR(clock[tx_id])) {
+			err = clk_prepare_enable(clock[tx_id]);
+			if (err) {
+				dev_err(uniphy->ppe_dev->dev,
+					"Failed to enable uniphy port %d tx_clk(%d)\n",
+					port, tx_id);
+				return err;
+			}
+		}
+	} else {
+		clk_disable_unprepare(clock[rx_id]);
+		clk_disable_unprepare(clock[tx_id]);
+	}
+
+	return 0;
+}
+
+static int ppe_uniphy_interface_gcc_clock_en_set(struct ppe_uniphy *uniphy, bool enable)
+{
+	int ppe_type = ppe_type_get(uniphy->ppe_dev);
+	int port = 0;
+
+	switch (uniphy->index) {
+	case 2:
+		ppe_uniphy_port_gcc_clock_en_set(uniphy, PPE_PORT6, enable);
+		break;
+	case 1:
+		if (ppe_type == PPE_TYPE_APPE)
+			ppe_uniphy_port_gcc_clock_en_set(uniphy, PPE_PORT5, enable);
+		else if (ppe_type == PPE_TYPE_MPPE)
+			ppe_uniphy_port_gcc_clock_en_set(uniphy, PPE_PORT2, enable);
+		break;
+	case 0:
+		if (ppe_type == PPE_TYPE_APPE) {
+			for (port = PPE_PORT1; port <= PPE_PORT4; port++)
+				ppe_uniphy_port_gcc_clock_en_set(uniphy, port, enable);
+		} else if (ppe_type == PPE_TYPE_MPPE) {
+			ppe_uniphy_port_gcc_clock_en_set(uniphy, PPE_PORT1, enable);
+		}
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int ppe_uniphy_gcc_xpcs_reset(struct ppe_uniphy *uniphy, bool enable)
+{
+	struct reset_control **reset = ppe_reset_get(uniphy->ppe_dev);
+	enum ppe_rst_id id = PPE_UNIPHY0_XPCS_RST + uniphy->index;
+
+	if (IS_ERR(reset[id]))
+		return PTR_ERR(reset[id]);
+
+	if (enable)
+		return reset_control_assert(reset[id]);
+	else
+		return reset_control_deassert(reset[id]);
+}
+
+static int ppe_uniphy_gcc_software_reset(struct ppe_uniphy *uniphy)
+{
+	struct reset_control **reset = ppe_reset_get(uniphy->ppe_dev);
+	int ppe_type = ppe_type_get(uniphy->ppe_dev);
+	unsigned int index = uniphy->index;
+	int err = 0, port = 0;
+
+	/* Assert uniphy sys reset control */
+	if (!IS_ERR(reset[PPE_UNIPHY0_SYS_RST + index])) {
+		err = reset_control_assert(reset[PPE_UNIPHY0_SYS_RST + index]);
+		if (err)
+			return err;
+	}
+
+	/* Assert uniphy port reset control */
+	switch (ppe_type) {
+	case PPE_TYPE_APPE:
+		if (index == 0) {
+			for (port = PPE_PORT1; port <= PPE_PORT4; port++) {
+				if (!IS_ERR(reset[PPE_UNIPHY_PORT1_DIS + port - 1])) {
+					err = reset_control_assert(reset[PPE_UNIPHY_PORT1_DIS +
+								   port - 1]);
+					if (err)
+						return err;
+				}
+			}
+		} else {
+			if (!IS_ERR(reset[PPE_UNIPHY0_SOFT_RST + index])) {
+				err = reset_control_assert(reset[PPE_UNIPHY0_SOFT_RST + index]);
+				if (err)
+					return err;
+			}
+		}
+		break;
+	case PPE_TYPE_MPPE:
+		if (!IS_ERR(reset[PPE_UNIPHY_PORT1_RX_RST + (index << 1)])) {
+			err = reset_control_assert(reset[PPE_UNIPHY_PORT1_RX_RST + (index << 1)]);
+			if (err)
+				return err;
+		}
+
+		if (!IS_ERR(reset[PPE_UNIPHY_PORT1_TX_RST + (index << 1)])) {
+			err = reset_control_assert(reset[PPE_UNIPHY_PORT1_TX_RST + (index << 1)]);
+			if (err)
+				return err;
+		}
+		break;
+	default:
+		break;
+	}
+	fsleep(100000);
+
+	/* Deassert uniphy sys reset control */
+	if (!IS_ERR(reset[PPE_UNIPHY0_SYS_RST + index])) {
+		err = reset_control_deassert(reset[PPE_UNIPHY0_SYS_RST + index]);
+		if (err)
+			return err;
+	}
+
+	/* Deassert uniphy port reset control */
+	switch (ppe_type) {
+	case PPE_TYPE_APPE:
+		if (index == 0) {
+			for (port = PPE_PORT1; port <= PPE_PORT4; port++) {
+				if (!IS_ERR(reset[PPE_UNIPHY_PORT1_DIS + port - 1])) {
+					err = reset_control_deassert(reset[PPE_UNIPHY_PORT1_DIS +
+								     port - 1]);
+					if (err)
+						return err;
+				}
+			}
+		} else {
+			if (!IS_ERR(reset[PPE_UNIPHY0_SOFT_RST + index])) {
+				err = reset_control_deassert(reset[PPE_UNIPHY0_SOFT_RST + index]);
+				if (err)
+					return err;
+			}
+		}
+		break;
+	case PPE_TYPE_MPPE:
+		if (!IS_ERR(reset[PPE_UNIPHY_PORT1_RX_RST + (index << 1)])) {
+			err = reset_control_deassert(reset[PPE_UNIPHY_PORT1_RX_RST + (index << 1)]);
+			if (err)
+				return err;
+		}
+
+		if (!IS_ERR(reset[PPE_UNIPHY_PORT1_TX_RST + (index << 1)])) {
+			err = reset_control_deassert(reset[PPE_UNIPHY_PORT1_TX_RST + (index << 1)]);
+			if (err)
+				return err;
+		}
+		break;
+	default:
+		break;
+	}
+	fsleep(100000);
+
+	return err;
+}
+
+int ppe_uniphy_autoneg_complete_check(struct ppe_uniphy *uniphy, int port)
+{
+	u32 reg, val;
+	int channel, ret;
+
+	if (uniphy->interface == PHY_INTERFACE_MODE_USXGMII ||
+	    uniphy->interface == PHY_INTERFACE_MODE_QUSGMII) {
+		/* Only uniphy0 may have multi channels */
+		channel = (uniphy->index == 0) ? (port - 1) : 0;
+		reg = (channel == 0) ? VR_MII_AN_INTR_STS_ADDR :
+		       VR_MII_AN_INTR_STS_CHANNEL_ADDR(channel);
+
+		/* Wait auto negotiation complete */
+		ret = read_poll_timeout(ppe_uniphy_read, val,
+					(val & CL37_ANCMPLT_INTR),
+					1000, 100000, true,
+					uniphy, reg);
+		if (ret) {
+			dev_err(uniphy->ppe_dev->dev,
+				"uniphy %d auto negotiation timeout\n", uniphy->index);
+			return ret;
+		}
+
+		/* Clear auto negotiation complete interrupt */
+		ppe_uniphy_mask(uniphy, reg, CL37_ANCMPLT_INTR, 0);
+	}
+
+	return 0;
+}
+
+int ppe_uniphy_speed_set(struct ppe_uniphy *uniphy, int port, int speed)
+{
+	u32 reg, val;
+	int channel;
+
+	if (uniphy->interface == PHY_INTERFACE_MODE_USXGMII ||
+	    uniphy->interface == PHY_INTERFACE_MODE_QUSGMII) {
+		/* Only uniphy0 may have multiple channels */
+		channel = (uniphy->index == 0) ? (port - 1) : 0;
+
+		reg = (channel == 0) ? SR_MII_CTRL_ADDR :
+		       SR_MII_CTRL_CHANNEL_ADDR(channel);
+
+		switch (speed) {
+		case SPEED_100:
+			val = USXGMII_SPEED_100;
+			break;
+		case SPEED_1000:
+			val = USXGMII_SPEED_1000;
+			break;
+		case SPEED_2500:
+			val = USXGMII_SPEED_2500;
+			break;
+		case SPEED_5000:
+			val = USXGMII_SPEED_5000;
+			break;
+		case SPEED_10000:
+			val = USXGMII_SPEED_10000;
+			break;
+		case SPEED_10:
+			val = USXGMII_SPEED_10;
+			break;
+		default:
+			val = 0;
+			break;
+		}
+
+		ppe_uniphy_mask(uniphy, reg, USXGMII_SPEED_MASK, val);
+	}
+
+	return 0;
+}
+
+int ppe_uniphy_duplex_set(struct ppe_uniphy *uniphy, int port, int duplex)
+{
+	u32 reg;
+	int channel;
+
+	if (uniphy->interface == PHY_INTERFACE_MODE_USXGMII &&
+	    uniphy->interface == PHY_INTERFACE_MODE_QUSGMII) {
+		/* Only uniphy0 may have multiple channels */
+		channel = (uniphy->index == 0) ? (port - 1) : 0;
+
+		reg = (channel == 0) ? SR_MII_CTRL_ADDR :
+		       SR_MII_CTRL_CHANNEL_ADDR(channel);
+
+		ppe_uniphy_mask(uniphy, reg, USXGMII_DUPLEX_FULL,
+				(duplex == DUPLEX_FULL) ? USXGMII_DUPLEX_FULL : 0);
+	}
+
+	return 0;
+}
+
+int ppe_uniphy_adapter_reset(struct ppe_uniphy *uniphy, int port)
+{
+	int channel;
+
+	/* Only uniphy0 may have multiple channels */
+	channel = (uniphy->index == 0) ? (port - 1) : 0;
+
+	switch (uniphy->interface) {
+	case PHY_INTERFACE_MODE_USXGMII:
+	case PHY_INTERFACE_MODE_QUSGMII:
+		if (channel == 0)
+			ppe_uniphy_mask(uniphy,
+					VR_XS_PCS_DIG_CTRL1_ADDR,
+					USRA_RST, USRA_RST);
+		else
+			ppe_uniphy_mask(uniphy,
+					VR_MII_DIG_CTRL1_CHANNEL_ADDR(channel),
+					CHANNEL_USRA_RST, CHANNEL_USRA_RST);
+		break;
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_2500BASEX:
+	case PHY_INTERFACE_MODE_QSGMII:
+		ppe_uniphy_mask(uniphy,
+				UNIPHY_CHANNEL_INPUT_OUTPUT_4_ADDR(channel),
+				NEWADDEDFROMHERE_CH_ADP_SW_RSTN, 0);
+		ppe_uniphy_mask(uniphy,
+				UNIPHY_CHANNEL_INPUT_OUTPUT_4_ADDR(channel),
+				NEWADDEDFROMHERE_CH_ADP_SW_RSTN,
+				NEWADDEDFROMHERE_CH_ADP_SW_RSTN);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int ppe_pcs_config(struct phylink_pcs *pcs, unsigned int mode,
+			  phy_interface_t interface,
+			  const unsigned long *advertising,
+			  bool permit_pause_to_mac)
+{
+	struct ppe_uniphy *uniphy = pcs_to_ppe_uniphy(pcs);
+	unsigned long rate = 0;
+	int ret, channel = 0;
+	u32 val = 0;
+
+	if (uniphy->interface == interface)
+		return 0;
+
+	uniphy->interface = interface;
+
+	/* Disable gcc uniphy interface clock */
+	ppe_uniphy_interface_gcc_clock_en_set(uniphy, false);
+
+	/* Assert gcc uniphy xpcs reset control */
+	ppe_uniphy_gcc_xpcs_reset(uniphy, true);
+
+	/* Configure uniphy mode */
+	switch (interface) {
+	case PHY_INTERFACE_MODE_USXGMII:
+	case PHY_INTERFACE_MODE_10GBASER:
+	case PHY_INTERFACE_MODE_QUSGMII:
+		rate = UNIPHY_CLK_RATE_312P5M;
+		ppe_uniphy_mask(uniphy, UNIPHY_MODE_CTRL_ADDR,
+				USXGMII_MODE_CTRL_MASK, USXGMII_MODE_CTRL);
+		break;
+	case PHY_INTERFACE_MODE_2500BASEX:
+		rate = UNIPHY_CLK_RATE_312P5M;
+		ppe_uniphy_mask(uniphy, UNIPHY_MODE_CTRL_ADDR,
+				SGMIIPLUS_MODE_CTRL_MASK, SGMIIPLUS_MODE_CTRL);
+		break;
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+		rate = UNIPHY_CLK_RATE_125M;
+		ppe_uniphy_mask(uniphy, UNIPHY_MODE_CTRL_ADDR,
+				SGMII_MODE_CTRL_MASK, SGMII_MODE_CTRL);
+		break;
+	case PHY_INTERFACE_MODE_QSGMII:
+		rate = UNIPHY_CLK_RATE_125M;
+		ppe_uniphy_mask(uniphy, UNIPHY_MODE_CTRL_ADDR,
+				QSGMII_MODE_CTRL_MASK, QSGMII_MODE_CTRL);
+		break;
+	default:
+		break;
+	}
+
+	if (interface == PHY_INTERFACE_MODE_QUSGMII)
+		ppe_uniphy_mask(uniphy, UNIPHY_QP_USXG_OPITON1_ADDR,
+				GMII_SRC_SEL, GMII_SRC_SEL);
+
+	if (interface == PHY_INTERFACE_MODE_10GBASER)
+		ppe_uniphy_mask(uniphy, UNIPHY_LINK_DETECT_ADDR,
+				DETECT_LOS_FROM_SFP, UNIPHY_10GR_LINK_LOSS);
+
+	/* Reset uniphy gcc software reset control */
+	ppe_uniphy_gcc_software_reset(uniphy);
+
+	/* Wait uniphy calibration completion */
+	ret = read_poll_timeout(ppe_uniphy_read, val,
+				(val & MMD1_REG_CALIBRATION_DONE_REG),
+				1000, 100000, true,
+				uniphy, UNIPHY_OFFSET_CALIB_4_ADDR);
+	if (ret) {
+		dev_err(uniphy->ppe_dev->dev,
+			"uniphy %d calibration timeout\n", uniphy->index);
+		return ret;
+	}
+
+	/* Enable gcc uniphy interface clk */
+	ppe_uniphy_interface_gcc_clock_en_set(uniphy, true);
+
+	/* Deassert gcc uniphy xpcs reset control */
+	if (interface == PHY_INTERFACE_MODE_USXGMII ||
+	    interface == PHY_INTERFACE_MODE_10GBASER ||
+		interface == PHY_INTERFACE_MODE_QUSGMII)
+		ppe_uniphy_gcc_xpcs_reset(uniphy, false);
+
+	if (interface == PHY_INTERFACE_MODE_USXGMII ||
+	    interface == PHY_INTERFACE_MODE_QUSGMII) {
+		/* Wait 10gr link up */
+		ret = read_poll_timeout(ppe_uniphy_read, val,
+					(val & SR_XS_PCS_KR_STS1_PLU),
+					1000, 100000, true,
+					uniphy, SR_XS_PCS_KR_STS1_ADDR);
+		if (ret)
+			dev_warn(uniphy->ppe_dev->dev,
+				 "uniphy %d 10gr linkup timeout\n", uniphy->index);
+
+		/* Enable usxgmii */
+		ppe_uniphy_mask(uniphy, VR_XS_PCS_DIG_CTRL1_ADDR, USXGMII_EN, USXGMII_EN);
+
+		if (interface == PHY_INTERFACE_MODE_QUSGMII) {
+			/* XPCS set quxgmii mode */
+			ppe_uniphy_mask(uniphy, VR_XS_PCS_DIG_STS_ADDR, AM_COUNT, QUXGMII_AM_COUNT);
+			ppe_uniphy_mask(uniphy, VR_XS_PCS_KR_CTRL_ADDR, USXG_MODE, QUXGMII_MODE);
+			/* XPCS software reset */
+			ppe_uniphy_mask(uniphy, VR_XS_PCS_DIG_CTRL1_ADDR, VR_RST, VR_RST);
+		}
+
+		/* Enable autoneg complete interrupt and 10M/100M 8bit mii width */
+		ppe_uniphy_mask(uniphy, VR_MII_AN_CTRL_ADDR,
+				MII_AN_INTR_EN | MII_CTRL, MII_AN_INTR_EN | MII_CTRL);
+
+		if (interface == PHY_INTERFACE_MODE_QUSGMII) {
+			for (channel = 1; channel <= 3; channel++)
+				ppe_uniphy_mask(uniphy, VR_MII_AN_CTRL_CHANNEL_ADDR(channel),
+						MII_AN_INTR_EN | MII_CTRL,
+						MII_AN_INTR_EN | MII_CTRL);
+			/* Disable TICD */
+			ppe_uniphy_mask(uniphy, VR_XAUI_MODE_CTRL_ADDR, IPG_CHECK, IPG_CHECK);
+			for (channel = 1; channel <= 3; channel++)
+				ppe_uniphy_mask(uniphy, VR_XAUI_MODE_CTRL_CHANNEL_ADDR(channel),
+						IPG_CHECK, IPG_CHECK);
+		}
+
+		/* Enable autoneg ability and usxgmii 10g speed and full duplex */
+		ppe_uniphy_mask(uniphy, SR_MII_CTRL_ADDR,
+				USXGMII_SPEED_MASK | AN_ENABLE | USXGMII_DUPLEX_FULL,
+				USXGMII_SPEED_10000 | AN_ENABLE | USXGMII_DUPLEX_FULL);
+		if (interface == PHY_INTERFACE_MODE_QUSGMII) {
+			for (channel = 1; channel <= 3; channel++)
+				ppe_uniphy_mask(uniphy, SR_MII_CTRL_CHANNEL_ADDR(channel),
+						USXGMII_SPEED_MASK | AN_ENABLE |
+						USXGMII_DUPLEX_FULL,
+						USXGMII_SPEED_10000 | AN_ENABLE |
+						USXGMII_DUPLEX_FULL);
+
+			/* Enable eee transparent mode */
+			ppe_uniphy_mask(uniphy, VR_XS_PCS_EEE_MCTRL0_ADDR,
+					MULT_FACT_100NS | SIGN_BIT,
+					FIELD_PREP(MULT_FACT_100NS, 0x1) | SIGN_BIT);
+			ppe_uniphy_mask(uniphy, VR_XS_PCS_EEE_TXTIMER_ADDR,
+					TSL_RES | T1U_RES | TWL_RES,
+					UNIPHY_XPCS_TSL_TIMER |
+					UNIPHY_XPCS_T1U_TIMER | UNIPHY_XPCS_TWL_TIMER);
+			ppe_uniphy_mask(uniphy, VR_XS_PCS_EEE_RXTIMER_ADDR,
+					RES_100U | TWR_RES,
+					UNIPHY_XPCS_100US_TIMER | UNIPHY_XPCS_TWR_TIMER);
+
+			ppe_uniphy_mask(uniphy, VR_XS_PCS_EEE_MCTRL1_ADDR,
+					TRN_LPI | TRN_RXLPI, TRN_LPI | TRN_RXLPI);
+			ppe_uniphy_mask(uniphy, VR_XS_PCS_EEE_MCTRL0_ADDR,
+					LTX_EN | LRX_EN, LTX_EN | LRX_EN);
+		}
+	}
+
+	/* Set uniphy raw clk rate */
+	clk_set_rate(uniphy_raw_clks[(uniphy->index << 1) + UNIPHY_RX]->clk,
+		     rate);
+	clk_set_rate(uniphy_raw_clks[(uniphy->index << 1) + UNIPHY_TX]->clk,
+		     rate);
+
+	dev_info(uniphy->ppe_dev->dev,
+		 "ppe pcs config uniphy index %d, interface %s\n",
+		 uniphy->index, phy_modes(interface));
+
+	return 0;
+}
+
+static void ppe_pcs_get_state(struct phylink_pcs *pcs,
+			      struct phylink_link_state *state)
+{
+	struct ppe_uniphy *uniphy = pcs_to_ppe_uniphy(pcs);
+	u32 val;
+
+	switch (state->interface) {
+	case PHY_INTERFACE_MODE_10GBASER:
+		val = ppe_uniphy_read(uniphy, SR_XS_PCS_KR_STS1_ADDR);
+		state->link = (val & SR_XS_PCS_KR_STS1_PLU) ? 1 : 0;
+		state->duplex = DUPLEX_FULL;
+		state->speed = SPEED_10000;
+		state->pause |= (MLO_PAUSE_RX | MLO_PAUSE_TX);
+		break;
+	case PHY_INTERFACE_MODE_2500BASEX:
+		val = ppe_uniphy_read(uniphy, UNIPHY_CHANNEL0_INPUT_OUTPUT_6_ADDR);
+		state->link = (val & NEWADDEDFROMHERE_CH0_LINK_MAC) ? 1 : 0;
+		state->duplex = DUPLEX_FULL;
+		state->speed = SPEED_2500;
+		state->pause |= (MLO_PAUSE_RX | MLO_PAUSE_TX);
+		break;
+	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_SGMII:
+		val = ppe_uniphy_read(uniphy, UNIPHY_CHANNEL0_INPUT_OUTPUT_6_ADDR);
+		state->link = (val & NEWADDEDFROMHERE_CH0_LINK_MAC) ? 1 : 0;
+		state->duplex = (val & NEWADDEDFROMHERE_CH0_DUPLEX_MODE_MAC) ?
+			DUPLEX_FULL : DUPLEX_HALF;
+		if (FIELD_GET(NEWADDEDFROMHERE_CH0_SPEED_MODE_MAC, val) == UNIPHY_SPEED_10M)
+			state->speed = SPEED_10;
+		else if (FIELD_GET(NEWADDEDFROMHERE_CH0_SPEED_MODE_MAC, val) == UNIPHY_SPEED_100M)
+			state->speed = SPEED_100;
+		else if (FIELD_GET(NEWADDEDFROMHERE_CH0_SPEED_MODE_MAC, val) == UNIPHY_SPEED_1000M)
+			state->speed = SPEED_1000;
+		state->pause |= (MLO_PAUSE_RX | MLO_PAUSE_TX);
+		break;
+	default:
+		break;
+	}
+}
+
+static void ppe_pcs_an_restart(struct phylink_pcs *pcs)
+{
+}
+
+static const struct phylink_pcs_ops ppe_pcs_ops = {
+	.pcs_get_state = ppe_pcs_get_state,
+	.pcs_config = ppe_pcs_config,
+	.pcs_an_restart = ppe_pcs_an_restart,
+};
+
+static void uniphy_clk_release_provider(void *res)
+{
+	of_clk_del_provider(res);
+}
+
+struct ppe_uniphy *ppe_uniphy_setup(struct platform_device *pdev)
+{
+	struct clk_hw_onecell_data *uniphy_clk_data = NULL;
+	struct device_node *np;
+	struct ppe_device *ppe_dev = platform_get_drvdata(pdev);
+	struct ppe_uniphy *uniphy;
+	int i, ret, clk_num = 0;
+
+	np = of_get_child_by_name(pdev->dev.of_node, "qcom-uniphy");
+	if (!np) {
+		dev_err(&pdev->dev, "Failed to find uniphy node\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	/* Register uniphy raw clock */
+	clk_num = of_property_count_strings(np, "clock-output-names");
+	if (clk_num < 0) {
+		dev_err(&pdev->dev, "%pOFn: invalid clock output count\n", np);
+		goto err_node_put;
+	}
+
+	uniphy_clk_data = devm_kzalloc(&pdev->dev,
+				       struct_size(uniphy_clk_data, hws, clk_num),
+				       GFP_KERNEL);
+	if (!uniphy_clk_data) {
+		ret = -ENOMEM;
+		goto err_node_put;
+	}
+
+	uniphy_clk_data->num = clk_num;
+	for (i = 0; i < clk_num; i++) {
+		ret = of_property_read_string_index(np, "clock-output-names", i,
+						    (const char **)&uniphy_raw_clks[i]->init->name);
+		if (ret) {
+			dev_err(&pdev->dev, "invalid clock name @ %pOFn\n", np);
+			goto err_node_put;
+		}
+
+		ret = devm_clk_hw_register(&pdev->dev, uniphy_raw_clks[i]);
+		if (ret)
+			goto err_node_put;
+		uniphy_clk_data->hws[i] = uniphy_raw_clks[i];
+	}
+
+	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, uniphy_clk_data);
+	if (ret)
+		goto err_node_put;
+
+	ret = devm_add_action_or_reset(&pdev->dev, uniphy_clk_release_provider, np);
+	if (ret)
+		goto err_node_put;
+
+	/* Initialize each uniphy structure */
+	uniphy = devm_kzalloc(&pdev->dev, sizeof(*uniphy) * (clk_num >> 1), GFP_KERNEL);
+	if (!uniphy) {
+		ret = -ENOMEM;
+		goto err_node_put;
+	}
+
+	for (i = 0; i < (clk_num >> 1); i++) {
+		uniphy[i].base = devm_of_iomap(&pdev->dev, np, i, NULL);
+		if (IS_ERR(uniphy[i].base)) {
+			ret = PTR_ERR(uniphy[i].base);
+			goto err_node_put;
+		}
+		uniphy[i].index = i;
+		uniphy[i].interface = PHY_INTERFACE_MODE_NA;
+		uniphy[i].ppe_dev = ppe_dev;
+		uniphy[i].pcs.ops = &ppe_pcs_ops;
+		uniphy[i].pcs.poll = true;
+	}
+	of_node_put(np);
+	return uniphy;
+
+err_node_put:
+	of_node_put(np);
+	return ERR_PTR(ret);
+}
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_uniphy.h b/drivers/net/ethernet/qualcomm/ppe/ppe_uniphy.h
new file mode 100644
index 000000000000..ec547e520937
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_uniphy.h
@@ -0,0 +1,227 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/* PPE UNIPHY functions and UNIPHY hardware registers declarations. */
+
+#ifndef _PPE_UNIPHY_H_
+#define _PPE_UNIPHY_H_
+
+#include <linux/phylink.h>
+
+#define UNIPHY_INDIRECT_ADDR_START			0x8000
+#define UNIPHY_INDIRECT_AHB_ADDR			0x83fc
+#define UNIPHY_INDIRECT_ADDR_HIGH			GENMASK(20, 8)
+#define UNIPHY_INDIRECT_ADDR_LOW			GENMASK(7, 0)
+#define UNIPHY_INDIRECT_DATA_ADDR(reg)			(FIELD_PREP(GENMASK(15, 10), 0x20) | \
+							FIELD_PREP(GENMASK(9, 2), \
+							FIELD_GET(UNIPHY_INDIRECT_ADDR_LOW, reg)))
+
+/* [register] UNIPHY_MISC2 */
+#define UNIPHY_MISC2_ADDR				0x218
+#define PHY_MODE					GENMASK(6, 4)
+#define USXGMII_PHY_MODE				(FIELD_PREP(PHY_MODE, 0x7))
+#define SGMII_PLUS_PHY_MODE				(FIELD_PREP(PHY_MODE, 0x5))
+#define SGMII_PHY_MODE					(FIELD_PREP(PHY_MODE, 0x3))
+
+/* [register] UNIPHY_MODE_CTRL */
+#define UNIPHY_MODE_CTRL_ADDR				0x46c
+#define NEWADDEDFROMHERE_CH0_AUTONEG_MODE		BIT(0)
+#define NEWADDEDFROMHERE_CH1_CH0_SGMII			BIT(1)
+#define NEWADDEDFROMHERE_CH4_CH1_0_SGMII		BIT(2)
+#define NEWADDEDFROMHERE_SGMII_EVEN_LOW			BIT(3)
+#define NEWADDEDFROMHERE_CH0_MODE_CTRL_25M		GENMASK(6, 4)
+#define NEWADDEDFROMHERE_CH0_QSGMII_SGMII		BIT(8)
+#define NEWADDEDFROMHERE_CH0_PSGMII_QSGMII		BIT(9)
+#define NEWADDEDFROMHERE_SG_MODE			BIT(10)
+#define NEWADDEDFROMHERE_SGPLUS_MODE			BIT(11)
+#define NEWADDEDFROMHERE_XPCS_MODE			BIT(12)
+#define NEWADDEDFROMHERE_USXG_EN			BIT(13)
+#define NEWADDEDFROMHERE_SW_V17_V18			BIT(15)
+#define USXGMII_MODE_CTRL_MASK				GENMASK(12, 8)
+#define USXGMII_MODE_CTRL				NEWADDEDFROMHERE_XPCS_MODE
+#define TEN_GR_MODE_CTRL_MASK				GENMASK(12, 8)
+#define TEN_GR_MODE_CTRL				NEWADDEDFROMHERE_XPCS_MODE
+#define QUSGMII_MODE_CTRL_MASK				GENMASK(12, 8)
+#define QUSGMII_MODE_CTRL				NEWADDEDFROMHERE_XPCS_MODE
+#define SGMIIPLUS_MODE_CTRL_MASK			(NEWADDEDFROMHERE_CH0_AUTONEG_MODE | \
+								GENMASK(12, 8))
+#define SGMIIPLUS_MODE_CTRL				NEWADDEDFROMHERE_SGPLUS_MODE
+#define QSGMII_MODE_CTRL_MASK				(NEWADDEDFROMHERE_CH0_AUTONEG_MODE | \
+								GENMASK(12, 8))
+#define QSGMII_MODE_CTRL				NEWADDEDFROMHERE_CH0_PSGMII_QSGMII
+#define SGMII_MODE_CTRL_MASK				(NEWADDEDFROMHERE_CH0_AUTONEG_MODE | \
+								GENMASK(12, 8))
+#define SGMII_MODE_CTRL					NEWADDEDFROMHERE_SG_MODE
+
+/* [register] UNIPHY_CHANNEL_INPUT_OUTPUT_4 */
+#define UNIPHY_CHANNEL0_INPUT_OUTPUT_4_ADDR		0x480
+#define NEWADDEDFROMHERE_CH0_ADP_SW_RSTN		BIT(11)
+#define UNIPHY_CHANNEL1_INPUT_OUTPUT_4_ADDR		0x498
+#define NEWADDEDFROMHERE_CH1_ADP_SW_RSTN		BIT(11)
+#define UNIPHY_CHANNEL2_INPUT_OUTPUT_4_ADDR		0x4b0
+#define NEWADDEDFROMHERE_CH2_ADP_SW_RSTN		BIT(11)
+#define UNIPHY_CHANNEL3_INPUT_OUTPUT_4_ADDR		0x4c8
+#define NEWADDEDFROMHERE_CH3_ADP_SW_RSTN		BIT(11)
+#define UNIPHY_CHANNEL4_INPUT_OUTPUT_4_ADDR		0x4e0
+#define NEWADDEDFROMHERE_CH4_ADP_SW_RSTN		BIT(11)
+#define UNIPHY_CHANNEL_INPUT_OUTPUT_4_ADDR(x)		(0x480 + 0x18 * (x))
+#define NEWADDEDFROMHERE_CH_ADP_SW_RSTN			BIT(11)
+
+/* [register] UNIPHY_CHANNEL_INPUT_OUTPUT_6 */
+#define UNIPHY_CHANNEL0_INPUT_OUTPUT_6_ADDR		0x488
+#define NEWADDEDFROMHERE_CH0_LINK_MAC			BIT(7)
+#define NEWADDEDFROMHERE_CH0_DUPLEX_MODE_MAC		BIT(6)
+#define NEWADDEDFROMHERE_CH0_SPEED_MODE_MAC		GENMASK(5, 4)
+#define NEWADDEDFROMHERE_CH0_PAUSE_MAC			BIT(3)
+#define NEWADDEDFROMHERE_CH0_ASYM_PAUSE_MAC		BIT(2)
+#define NEWADDEDFROMHERE_CH0_TX_PAUSE_EN_MAC		BIT(1)
+#define NEWADDEDFROMHERE_CH0_RX_PAUSE_EN_MAC		BIT(0)
+#define UNIPHY_SPEED_10M				0
+#define UNIPHY_SPEED_100M				1
+#define UNIPHY_SPEED_1000M				2
+
+/* [register] UNIPHY_INSTANCE_LINK_DETECT */
+#define UNIPHY_LINK_DETECT_ADDR				0x570
+#define DETECT_LOS_FROM_SFP				GENMASK(8, 6)
+#define UNIPHY_10GR_LINK_LOSS				(FIELD_PREP(DETECT_LOS_FROM_SFP, 0x7))
+
+/* [register] UNIPHY_QP_USXG_OPITON1 */
+#define UNIPHY_QP_USXG_OPITON1_ADDR			0x584
+#define GMII_SRC_SEL					BIT(0)
+
+/* [register] UNIPHY_OFFSET_CALIB_4 */
+#define UNIPHY_OFFSET_CALIB_4_ADDR			0x1e0
+#define MMD1_REG_CALIBRATION_DONE_REG			BIT(7)
+#define UNIPHY_CALIBRATION_DONE				0x1
+
+/* [register] UNIPHY_PLL_RESET */
+#define UNIPHY_PLL_RESET_ADDR				0x780
+#define UPHY_ANA_EN_SW_RSTN				BIT(6)
+
+/* [register] SR_XS_PCS_KR_STS1 */
+#define SR_XS_PCS_KR_STS1_ADDR				0x30020
+#define SR_XS_PCS_KR_STS1_PLU				BIT(12)
+
+/* [register] VR_XS_PCS_DIG_CTRL1 */
+#define VR_XS_PCS_DIG_CTRL1_ADDR			0x38000
+#define USXGMII_EN					BIT(9)
+#define USRA_RST					BIT(10)
+#define VR_RST						BIT(15)
+
+/* [register] VR_XS_PCS_EEE_MCTRL0 */
+#define VR_XS_PCS_EEE_MCTRL0_ADDR			0x38006
+#define LTX_EN						BIT(0)
+#define LRX_EN						BIT(1)
+#define SIGN_BIT					BIT(6)
+#define MULT_FACT_100NS					GENMASK(11, 8)
+
+/* [register] VR_XS_PCS_KR_CTRL */
+#define VR_XS_PCS_KR_CTRL_ADDR	0x38007
+#define USXG_MODE					GENMASK(12, 10)
+#define QUXGMII_MODE					(FIELD_PREP(USXG_MODE, 0x5))
+
+/* [register] VR_XS_PCS_EEE_TXTIMER */
+#define VR_XS_PCS_EEE_TXTIMER_ADDR			0x38008
+#define TSL_RES						GENMASK(5, 0)
+#define T1U_RES						GENMASK(7, 6)
+#define TWL_RES						GENMASK(12, 8)
+#define UNIPHY_XPCS_TSL_TIMER				(FIELD_PREP(TSL_RES, 0xa))
+#define UNIPHY_XPCS_T1U_TIMER				(FIELD_PREP(TSL_RES, 0x3))
+#define UNIPHY_XPCS_TWL_TIMER				(FIELD_PREP(TSL_RES, 0x16))
+
+/* [register] VR_XS_PCS_EEE_RXTIMER  */
+#define VR_XS_PCS_EEE_RXTIMER_ADDR			0x38009
+#define RES_100U					GENMASK(7, 0)
+#define TWR_RES						GENMASK(13, 8)
+#define UNIPHY_XPCS_100US_TIMER				(FIELD_PREP(RES_100U, 0xc8))
+#define UNIPHY_XPCS_TWR_TIMER				(FIELD_PREP(RES_100U, 0x1c))
+
+/* [register] VR_XS_PCS_DIG_STS */
+#define VR_XS_PCS_DIG_STS_ADDR				0x3800a
+#define AM_COUNT					GENMASK(14, 0)
+#define QUXGMII_AM_COUNT				(FIELD_PREP(AM_COUNT, 0x6018))
+
+/* [register] VR_XS_PCS_EEE_MCTRL1 */
+#define VR_XS_PCS_EEE_MCTRL1_ADDR			0x3800b
+#define TRN_LPI						BIT(0)
+#define TRN_RXLPI					BIT(8)
+
+/* [register] VR_MII_1_DIG_CTRL1 */
+#define VR_MII_DIG_CTRL1_CHANNEL1_ADDR			0x1a8000
+#define VR_MII_DIG_CTRL1_CHANNEL2_ADDR			0x1b8000
+#define VR_MII_DIG_CTRL1_CHANNEL3_ADDR			0x1c8000
+#define VR_MII_DIG_CTRL1_CHANNEL_ADDR(x)		(0x1a8000 + 0x10000 * ((x) - 1))
+#define CHANNEL_USRA_RST				BIT(5)
+
+/* [register] VR_MII_AN_CTRL */
+#define VR_MII_AN_CTRL_ADDR				0x1f8001
+#define VR_MII_AN_CTRL_CHANNEL1_ADDR			0x1a8001
+#define VR_MII_AN_CTRL_CHANNEL2_ADDR			0x1b8001
+#define VR_MII_AN_CTRL_CHANNEL3_ADDR			0x1c8001
+#define VR_MII_AN_CTRL_CHANNEL_ADDR(x)			(0x1a8001 + 0x10000 * ((x) - 1))
+#define MII_AN_INTR_EN					BIT(0)
+#define MII_CTRL					BIT(8)
+
+/* [register] VR_MII_AN_INTR_STS */
+#define VR_MII_AN_INTR_STS_ADDR				0x1f8002
+#define VR_MII_AN_INTR_STS_CHANNEL1_ADDR		0x1a8002
+#define VR_MII_AN_INTR_STS_CHANNEL2_ADDR		0x1b8002
+#define VR_MII_AN_INTR_STS_CHANNEL3_ADDR		0x1c8002
+#define VR_MII_AN_INTR_STS_CHANNEL_ADDR(x)		(0x1a8002 + 0x10000 * ((x) - 1))
+#define CL37_ANCMPLT_INTR				BIT(0)
+
+/* [register] VR_XAUI_MODE_CTRL */
+#define VR_XAUI_MODE_CTRL_ADDR				0x1f8004
+#define VR_XAUI_MODE_CTRL_CHANNEL1_ADDR			0x1a8004
+#define VR_XAUI_MODE_CTRL_CHANNEL2_ADDR			0x1b8004
+#define VR_XAUI_MODE_CTRL_CHANNEL3_ADDR			0x1c8004
+#define VR_XAUI_MODE_CTRL_CHANNEL_ADDR(x)		(0x1a8004 + 0x10000 * ((x) - 1))
+#define IPG_CHECK					BIT(0)
+
+/* [register] SR_MII_CTRL */
+#define SR_MII_CTRL_ADDR				0x1f0000
+#define SR_MII_CTRL_CHANNEL1_ADDR			0x1a0000
+#define SR_MII_CTRL_CHANNEL2_ADDR			0x1b0000
+#define SR_MII_CTRL_CHANNEL3_ADDR			0x1c0000
+#define SR_MII_CTRL_CHANNEL_ADDR(x)			(0x1a0000 + 0x10000 * ((x) - 1))
+#define AN_ENABLE					BIT(12)
+#define USXGMII_DUPLEX_FULL				BIT(8)
+#define USXGMII_SPEED_MASK				(BIT(13) | BIT(6) | BIT(5))
+#define USXGMII_SPEED_10000				(BIT(13) | BIT(6))
+#define USXGMII_SPEED_5000				(BIT(13) | BIT(5))
+#define USXGMII_SPEED_2500				BIT(5)
+#define USXGMII_SPEED_1000				BIT(6)
+#define USXGMII_SPEED_100				BIT(13)
+#define USXGMII_SPEED_10				0
+
+/* PPE UNIPHY data type */
+struct ppe_uniphy {
+	void __iomem *base;
+	struct ppe_device *ppe_dev;
+	unsigned int index;
+	phy_interface_t interface;
+	struct phylink_pcs pcs;
+};
+
+#define pcs_to_ppe_uniphy(_pcs)				container_of(_pcs, struct ppe_uniphy, pcs)
+
+struct ppe_uniphy *ppe_uniphy_setup(struct platform_device *pdev);
+
+int ppe_uniphy_speed_set(struct ppe_uniphy *uniphy,
+			 int port, int speed);
+
+int ppe_uniphy_duplex_set(struct ppe_uniphy *uniphy,
+			  int port, int duplex);
+
+int ppe_uniphy_adapter_reset(struct ppe_uniphy *uniphy,
+			     int port);
+
+int ppe_uniphy_autoneg_complete_check(struct ppe_uniphy *uniphy,
+				      int port);
+
+int ppe_uniphy_port_gcc_clock_en_set(struct ppe_uniphy *uniphy,
+				     int port, bool enable);
+
+#endif /* _PPE_UNIPHY_H_ */
diff --git a/include/linux/soc/qcom/ppe.h b/include/linux/soc/qcom/ppe.h
index 268109c823ad..d3cb18df33fa 100644
--- a/include/linux/soc/qcom/ppe.h
+++ b/include/linux/soc/qcom/ppe.h
@@ -20,6 +20,7 @@ struct ppe_device {
 	struct dentry *debugfs_root;
 	bool is_ppe_probed;
 	void *ppe_priv;
+	void *uniphy;
 };
 
 /* PPE operations, which is used by the external driver like Ethernet
-- 
2.42.0


