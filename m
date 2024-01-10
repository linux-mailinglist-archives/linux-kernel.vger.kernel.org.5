Return-Path: <linux-kernel+bounces-22112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEFB829967
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10D7F285CDB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB7E4878B;
	Wed, 10 Jan 2024 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NbXHo+is"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BAA482EE;
	Wed, 10 Jan 2024 11:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40ABNgIE007536;
	Wed, 10 Jan 2024 11:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=FkGpydfMPT7wBnSFFXh3siyXPbnI28Lw73kyeEUx4PU=; b=Nb
	XHo+isNzliMk0fJPaNSW2Frn/sf4cucSQM+x3UOldnWG0cNZgvGghzXTMrk15WtA
	eE4I5Mr4ClHyWpgXlgct6f3zaM/KW2Oy4R3T1B0RJ4sD1nXC0FK6lcxPp42RQylb
	X6Ht0hbdf4aZ91BtLcTT2kjFLsoPXoU1iVqYw41shom0a8JmtMwINiS1jKopZ5s+
	iqcCCqxgIBNJ86cDInFLx4i/mJS5jZyypxN7MZxMf18BKcUZCUz9fhY3mDmkr21s
	vwwtqLOtz4d95qZe8DXbnAoU7qgLTaLzfFS1VhOW3UPeKP8zsKvPzNBLd6fQQiEm
	B+YSqBKkJ9iVVyMiX7fg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhnbnrny6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:41:37 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40ABfaak012703
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:41:36 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 03:41:25 -0800
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
Subject: [PATCH net-next 03/20] net: ethernet: qualcomm: Add qcom PPE driver
Date: Wed, 10 Jan 2024 19:40:15 +0800
Message-ID: <20240110114033.32575-4-quic_luoj@quicinc.com>
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
X-Proofpoint-ORIG-GUID: -ibXVu8zRhlk5FynOg7s355V2J0F_O4y
X-Proofpoint-GUID: -ibXVu8zRhlk5FynOg7s355V2J0F_O4y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401100095

This patch adds the base source files and Makefiles for the PPE driver,
platform driver and clock initialization routines.

The PPE(packet process engine) hardware block is available in Qualcomm
IPQ chipsets that support PPE architecture, such as IPQ9574 and IPQ5332.
The PPE includes integrated ethernet MAC and PCS(uniphy), which is used
to connect with external PHY devices by PCS. The PPE also includes various
packet processing offload capabilities such as routing and bridgng offload,
L2 switch capability, VLAN and tunnel processing offload.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 MAINTAINERS                                |   9 +
 drivers/net/ethernet/qualcomm/Kconfig      |  14 +
 drivers/net/ethernet/qualcomm/Makefile     |   1 +
 drivers/net/ethernet/qualcomm/ppe/Makefile |   7 +
 drivers/net/ethernet/qualcomm/ppe/ppe.c    | 389 +++++++++++++++++++++
 drivers/net/ethernet/qualcomm/ppe/ppe.h    | 143 ++++++++
 include/linux/soc/qcom/ppe.h               |  28 ++
 7 files changed, 591 insertions(+)
 create mode 100644 drivers/net/ethernet/qualcomm/ppe/Makefile
 create mode 100644 drivers/net/ethernet/qualcomm/ppe/ppe.c
 create mode 100644 drivers/net/ethernet/qualcomm/ppe/ppe.h
 create mode 100644 include/linux/soc/qcom/ppe.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 014ad90d0872..18413231d173 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17943,6 +17943,15 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
 F:	drivers/mtd/nand/raw/qcom_nandc.c
 
+QUALCOMM PPE DRIVER
+M:	Luo Jie <quic_luoj@quicinc.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/net/qcom,ppe.yaml
+F:	Documentation/networking/device_drivers/ethernet/qualcomm/ppe/ppe.rst
+F:	drivers/net/ethernet/qualcomm/ppe/
+F:	include/linux/soc/qcom/ppe.h
+
 QUALCOMM QSEECOM DRIVER
 M:	Maximilian Luz <luzmaximilian@gmail.com>
 L:	linux-arm-msm@vger.kernel.org
diff --git a/drivers/net/ethernet/qualcomm/Kconfig b/drivers/net/ethernet/qualcomm/Kconfig
index 9210ff360fdc..fe826c508f64 100644
--- a/drivers/net/ethernet/qualcomm/Kconfig
+++ b/drivers/net/ethernet/qualcomm/Kconfig
@@ -61,6 +61,20 @@ config QCOM_EMAC
 	  low power, Receive-Side Scaling (RSS), and IEEE 1588-2008
 	  Precision Clock Synchronization Protocol.
 
+config QCOM_PPE
+	tristate "Qualcomm Technologies, Inc. PPE Ethernet support"
+	depends on HAS_IOMEM && OF
+	depends on COMMON_CLK
+	help
+	  This driver supports the Qualcomm Technologies, Inc. packet
+	  process engine(PPE) available with IPQ SoC. The PPE houses
+	  the ethernet MACs and Ethernet DMA (EDMA) hardware blocks.
+	  It also supports L3 flow offload, L2 switch function, RSS
+	  and tunnel offload.
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called qcom-ppe.
+
 source "drivers/net/ethernet/qualcomm/rmnet/Kconfig"
 
 endif # NET_VENDOR_QUALCOMM
diff --git a/drivers/net/ethernet/qualcomm/Makefile b/drivers/net/ethernet/qualcomm/Makefile
index 9250976dd884..166a59aea363 100644
--- a/drivers/net/ethernet/qualcomm/Makefile
+++ b/drivers/net/ethernet/qualcomm/Makefile
@@ -11,4 +11,5 @@ qcauart-objs := qca_uart.o
 
 obj-y += emac/
 
+obj-$(CONFIG_QCOM_PPE) += ppe/
 obj-$(CONFIG_RMNET) += rmnet/
diff --git a/drivers/net/ethernet/qualcomm/ppe/Makefile b/drivers/net/ethernet/qualcomm/ppe/Makefile
new file mode 100644
index 000000000000..795aff6501e4
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ppe/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for the Qualcomm SoCs built-in PPE device driver
+#
+
+obj-$(CONFIG_QCOM_PPE) += qcom-ppe.o
+qcom-ppe-objs := ppe.o
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.c b/drivers/net/ethernet/qualcomm/ppe/ppe.c
new file mode 100644
index 000000000000..23f9de105062
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe.c
@@ -0,0 +1,389 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/* PPE platform device probe, DTSI read and basic HW initialization functions
+ * such as BM, QM, TDM and scheduler configs.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <linux/platform_device.h>
+#include <linux/soc/qcom/ppe.h>
+#include "ppe.h"
+
+static const char * const ppe_clock_name[PPE_CLK_MAX] = {
+	"cmn_ahb",
+	"cmn_sys",
+	"uniphy0_sys",
+	"uniphy1_sys",
+	"uniphy2_sys",
+	"uniphy0_ahb",
+	"uniphy1_ahb",
+	"uniphy2_ahb",
+	"gcc_nsscc",
+	"gcc_nssnoc_nsscc",
+	"gcc_nssnoc_snoc",
+	"gcc_nssnoc_snoc_1",
+	"gcc_im_sleep",
+	"nss_ppe",
+	"nss_ppe_cfg",
+	"nssnoc_ppe",
+	"nssnoc_ppe_cfg",
+	"nss_edma",
+	"nss_edma_cfg",
+	"nss_ppe_ipe",
+	"nss_ppe_btq",
+	"port1_mac",
+	"port2_mac",
+	"port3_mac",
+	"port4_mac",
+	"port5_mac",
+	"port6_mac",
+	"nss_port1_rx",
+	"nss_port1_tx",
+	"nss_port2_rx",
+	"nss_port2_tx",
+	"nss_port3_rx",
+	"nss_port3_tx",
+	"nss_port4_rx",
+	"nss_port4_tx",
+	"nss_port5_rx",
+	"nss_port5_tx",
+	"nss_port6_rx",
+	"nss_port6_tx",
+	"uniphy_port1_rx",
+	"uniphy_port1_tx",
+	"uniphy_port2_rx",
+	"uniphy_port2_tx",
+	"uniphy_port3_rx",
+	"uniphy_port3_tx",
+	"uniphy_port4_rx",
+	"uniphy_port4_tx",
+	"uniphy_port5_rx",
+	"uniphy_port5_tx",
+	"uniphy_port6_rx",
+	"uniphy_port6_tx",
+	"nss_port5_rx_clk_src",
+	"nss_port5_tx_clk_src",
+};
+
+static const char * const ppe_reset_name[PPE_RST_MAX] = {
+	"ppe",
+	"uniphy0_sys",
+	"uniphy1_sys",
+	"uniphy2_sys",
+	"uniphy0_ahb",
+	"uniphy1_ahb",
+	"uniphy2_ahb",
+	"uniphy0_xpcs",
+	"uniphy1_xpcs",
+	"uniphy2_xpcs",
+	"uniphy0_soft",
+	"uniphy1_soft",
+	"uniphy2_soft",
+	"uniphy_port1_dis",
+	"uniphy_port2_dis",
+	"uniphy_port3_dis",
+	"uniphy_port4_dis",
+	"uniphy_port1_rx",
+	"uniphy_port1_tx",
+	"uniphy_port2_rx",
+	"uniphy_port2_tx",
+	"nss_port1_rx",
+	"nss_port1_tx",
+	"nss_port2_rx",
+	"nss_port2_tx",
+	"nss_port1",
+	"nss_port2",
+	"nss_port3",
+	"nss_port4",
+	"nss_port5",
+	"nss_port6",
+	"nss_port1_mac",
+	"nss_port2_mac",
+	"nss_port3_mac",
+	"nss_port4_mac",
+	"nss_port5_mac",
+	"nss_port6_mac",
+};
+
+int ppe_type_get(struct ppe_device *ppe_dev)
+{
+	struct ppe_data *ppe_dev_priv = ppe_dev->ppe_priv;
+
+	if (!ppe_dev_priv)
+		return PPE_TYPE_MAX;
+
+	return ppe_dev_priv->ppe_type;
+}
+
+static int ppe_clock_set_enable(struct ppe_device *ppe_dev,
+				enum ppe_clk_id clk_id, unsigned long rate)
+{
+	struct ppe_data *ppe_dev_priv = ppe_dev->ppe_priv;
+
+	if (clk_id >= PPE_CLK_MAX)
+		return -EINVAL;
+
+	if (rate != 0)
+		clk_set_rate(ppe_dev_priv->clk[clk_id], rate);
+
+	return clk_prepare_enable(ppe_dev_priv->clk[clk_id]);
+}
+
+static int ppe_fix_clock_init(struct ppe_device *ppe_dev)
+{
+	unsigned long noc_rate, ppe_rate;
+	enum ppe_clk_id clk_id;
+	int ppe_type = ppe_type_get(ppe_dev);
+
+	switch (ppe_type) {
+	case PPE_TYPE_APPE:
+		noc_rate = 342857143;
+		ppe_rate = 353000000;
+		break;
+	case PPE_TYPE_MPPE:
+		noc_rate = 266660000;
+		ppe_rate = 200000000;
+		ppe_clock_set_enable(ppe_dev, PPE_IM_SLEEP_CLK, 0);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ppe_clock_set_enable(ppe_dev, PPE_CMN_AHB_CLK, 0);
+	ppe_clock_set_enable(ppe_dev, PPE_CMN_SYS_CLK, 0);
+	ppe_clock_set_enable(ppe_dev, PPE_NSSCC_CLK, 100000000);
+	ppe_clock_set_enable(ppe_dev, PPE_NSSNOC_NSSCC_CLK, 100000000);
+
+	ppe_clock_set_enable(ppe_dev, PPE_NSSNOC_SNOC_CLK, noc_rate);
+	ppe_clock_set_enable(ppe_dev, PPE_NSSNOC_SNOC_1_CLK, noc_rate);
+
+	ppe_clock_set_enable(ppe_dev, PPE_UNIPHY0_SYS_CLK, 24000000);
+	ppe_clock_set_enable(ppe_dev, PPE_UNIPHY1_SYS_CLK, 24000000);
+	ppe_clock_set_enable(ppe_dev, PPE_UNIPHY0_AHB_CLK, 100000000);
+	ppe_clock_set_enable(ppe_dev, PPE_UNIPHY1_AHB_CLK, 100000000);
+
+	if (ppe_type == PPE_TYPE_APPE) {
+		ppe_clock_set_enable(ppe_dev, PPE_UNIPHY2_SYS_CLK, 24000000);
+		ppe_clock_set_enable(ppe_dev, PPE_UNIPHY2_AHB_CLK, 100000000);
+	}
+
+	ppe_clock_set_enable(ppe_dev, PPE_PORT1_MAC_CLK, ppe_rate);
+	ppe_clock_set_enable(ppe_dev, PPE_PORT2_MAC_CLK, ppe_rate);
+
+	if (ppe_type == PPE_TYPE_APPE) {
+		ppe_clock_set_enable(ppe_dev, PPE_PORT3_MAC_CLK, ppe_rate);
+		ppe_clock_set_enable(ppe_dev, PPE_PORT4_MAC_CLK, ppe_rate);
+		ppe_clock_set_enable(ppe_dev, PPE_PORT5_MAC_CLK, ppe_rate);
+		ppe_clock_set_enable(ppe_dev, PPE_PORT6_MAC_CLK, ppe_rate);
+	}
+
+	ppe_clock_set_enable(ppe_dev, PPE_PPE_CLK, ppe_rate);
+	ppe_clock_set_enable(ppe_dev, PPE_PPE_CFG_CLK, ppe_rate);
+	ppe_clock_set_enable(ppe_dev, PPE_NSSNOC_PPE_CLK, ppe_rate);
+	ppe_clock_set_enable(ppe_dev, PPE_NSSNOC_PPE_CFG_CLK, ppe_rate);
+	ppe_clock_set_enable(ppe_dev, PPE_EDMA_CLK, ppe_rate);
+	ppe_clock_set_enable(ppe_dev, PPE_EDMA_CFG_CLK, ppe_rate);
+	ppe_clock_set_enable(ppe_dev, PPE_PPE_IPE_CLK, ppe_rate);
+	ppe_clock_set_enable(ppe_dev, PPE_PPE_BTQ_CLK, ppe_rate);
+
+	/* Enable uniphy port clocks */
+	for (clk_id = PPE_NSS_PORT1_RX_CLK; clk_id <= PPE_UNIPHY_PORT6_TX_CLK; clk_id++)
+		ppe_clock_set_enable(ppe_dev, clk_id, 0);
+
+	return 0;
+}
+
+static int ppe_clock_config(struct platform_device *pdev)
+{
+	struct ppe_device *ppe_dev = platform_get_drvdata(pdev);
+	struct ppe_data *ppe_dev_priv = ppe_dev->ppe_priv;
+	int ret;
+
+	ret = ppe_fix_clock_init(ppe_dev);
+	if (ret)
+		return ret;
+
+	/* Reset PPE */
+	reset_control_assert(ppe_dev_priv->rst[PPE_RST_PPE_RST]);
+	fsleep(100000);
+	reset_control_deassert(ppe_dev_priv->rst[PPE_RST_PPE_RST]);
+	fsleep(100000);
+
+	/* Reset the ahb uniphy connected with the PHY chip */
+	if (ppe_type_get(ppe_dev) == PPE_TYPE_MPPE) {
+		reset_control_assert(ppe_dev_priv->rst[PPE_UNIPHY1_AHB_RST]);
+		fsleep(100000);
+		reset_control_deassert(ppe_dev_priv->rst[PPE_UNIPHY1_AHB_RST]);
+		fsleep(100000);
+	}
+
+	return 0;
+}
+
+bool ppe_is_probed(struct platform_device *pdev)
+{
+	struct ppe_device *ppe_dev = platform_get_drvdata(pdev);
+
+	return ppe_dev && ppe_dev->is_ppe_probed;
+}
+EXPORT_SYMBOL_GPL(ppe_is_probed);
+
+struct ppe_device *ppe_dev_get(struct platform_device *pdev)
+{
+	return platform_get_drvdata(pdev);
+}
+EXPORT_SYMBOL_GPL(ppe_dev_get);
+
+static const struct regmap_range ppe_readable_ranges[] = {
+	regmap_reg_range(0x0, 0x1FF), /* GLB */
+	regmap_reg_range(0x400, 0x5FF), /* LPI CSR */
+	regmap_reg_range(0x1000, 0x11FF), /* GMAC0 */
+	regmap_reg_range(0x1200, 0x13FF), /* GMAC1 */
+	regmap_reg_range(0x1400, 0x15FF), /* GMAC2 */
+	regmap_reg_range(0x1600, 0x17FF), /* GMAC3 */
+	regmap_reg_range(0x1800, 0x19FF), /* GMAC4 */
+	regmap_reg_range(0x1A00, 0x1BFF), /* GMAC5 */
+	regmap_reg_range(0xB000, 0xEFFF), /* PRX CSR */
+	regmap_reg_range(0xF000, 0x1EFFF), /* IPE IV */
+	regmap_reg_range(0x20000, 0x5FFFF), /* PTX CSR */
+	regmap_reg_range(0x60000, 0x9FFFF), /* IPE L2 CSR */
+	regmap_reg_range(0xB0000, 0xEFFFF), /* IPO CSR */
+	regmap_reg_range(0x100000, 0x17FFFF), /* IPE PC */
+	regmap_reg_range(0x180000, 0x1BFFFF), /* PRE IPO CSR */
+	regmap_reg_range(0x1D0000, 0x1DFFFF), /* TUNNEL PARSER CSR */
+	regmap_reg_range(0x1E0000, 0x1EFFFF), /* INGRESS PARSE CSR */
+	regmap_reg_range(0x200000, 0x2FFFFF), /* IPE L3 */
+	regmap_reg_range(0x300000, 0x3FFFFF), /* IPE TL */
+	regmap_reg_range(0x400000, 0x4FFFFF), /* TM */
+	regmap_reg_range(0x500000, 0x503FFF), /* XGMAC0 */
+	regmap_reg_range(0x504000, 0x507FFF), /* XGMAC1 */
+	regmap_reg_range(0x508000, 0x50BFFF), /* XGMAC2 */
+	regmap_reg_range(0x50C000, 0x50FFFF), /* XGMAC3 */
+	regmap_reg_range(0x510000, 0x513FFF), /* XGMAC4 */
+	regmap_reg_range(0x514000, 0x517FFF), /* XGMAC5 */
+	regmap_reg_range(0x600000, 0x6FFFFF), /* BM */
+	regmap_reg_range(0x800000, 0x9FFFFF), /* QM */
+};
+
+static const struct regmap_access_table ppe_reg_table = {
+	.yes_ranges = ppe_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ppe_readable_ranges),
+};
+
+static const struct regmap_config ppe_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.rd_table = &ppe_reg_table,
+	.wr_table = &ppe_reg_table,
+	.max_register = 0x9FFFFF,
+	.fast_io = true,
+};
+
+static struct ppe_data *ppe_data_init(struct platform_device *pdev)
+{
+	struct ppe_data *ppe_dev_priv;
+	int ret;
+
+	ppe_dev_priv = devm_kzalloc(&pdev->dev, sizeof(*ppe_dev_priv), GFP_KERNEL);
+	if (!ppe_dev_priv)
+		return ERR_PTR(-ENOMEM);
+
+	if (of_device_is_compatible(pdev->dev.of_node, "qcom,ipq9574-ppe"))
+		ppe_dev_priv->ppe_type = PPE_TYPE_APPE;
+	else if (of_device_is_compatible(pdev->dev.of_node, "qcom,ipq5332-ppe"))
+		ppe_dev_priv->ppe_type = PPE_TYPE_MPPE;
+	else
+		return ERR_PTR(-EINVAL);
+
+	for (ret = 0; ret < PPE_CLK_MAX; ret++) {
+		ppe_dev_priv->clk[ret] = devm_clk_get_optional(&pdev->dev,
+							       ppe_clock_name[ret]);
+
+		if (IS_ERR(ppe_dev_priv->clk[ret]))
+			dev_err(&pdev->dev, "Failed to get the clock: %s\n",
+				ppe_clock_name[ret]);
+	}
+
+	for (ret = 0; ret < PPE_RST_MAX; ret++) {
+		ppe_dev_priv->rst[ret] =
+			devm_reset_control_get_optional_exclusive(&pdev->dev,
+								  ppe_reset_name[ret]);
+		if (IS_ERR(ppe_dev_priv->rst[ret]))
+			dev_err(&pdev->dev, "Failed to get the reset %s!\n",
+				ppe_reset_name[ret]);
+	}
+
+	return ppe_dev_priv;
+}
+
+static int qcom_ppe_probe(struct platform_device *pdev)
+{
+	struct ppe_device *ppe_dev;
+	void __iomem *base;
+	int ret;
+
+	ppe_dev = devm_kzalloc(&pdev->dev, sizeof(*ppe_dev), GFP_KERNEL);
+	if (!ppe_dev)
+		return -ENOMEM;
+
+	ppe_dev->dev = &pdev->dev;
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return dev_err_probe(&pdev->dev,
+				     PTR_ERR(base),
+				     "Fail to ioremap\n");
+
+	ppe_dev->regmap = devm_regmap_init_mmio(&pdev->dev, base, &ppe_regmap_config);
+	if (IS_ERR(ppe_dev->regmap))
+		return dev_err_probe(&pdev->dev,
+				     PTR_ERR(ppe_dev->regmap),
+				     "Fail to regmap\n");
+
+	ppe_dev->ppe_priv = ppe_data_init(pdev);
+	if (IS_ERR(ppe_dev->ppe_priv))
+		return dev_err_probe(&pdev->dev,
+				     PTR_ERR(ppe_dev->ppe_priv),
+				     "Fail to init ppe data\n");
+
+	platform_set_drvdata(pdev, ppe_dev);
+	ret = ppe_clock_config(pdev);
+	if (ret)
+		return dev_err_probe(&pdev->dev,
+				     ret,
+				     "ppe clock config failed\n");
+
+	ppe_dev->is_ppe_probed = true;
+	return 0;
+}
+
+static int qcom_ppe_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static const struct of_device_id qcom_ppe_of_match[] = {
+	{ .compatible = "qcom,ipq9574-ppe", },
+	{ .compatible = "qcom,ipq5332-ppe", },
+	{},
+};
+
+static struct platform_driver qcom_ppe_driver = {
+	.driver = {
+		.name = "qcom_ppe",
+		.owner  = THIS_MODULE,
+		.of_match_table = qcom_ppe_of_match,
+	},
+	.probe	= qcom_ppe_probe,
+	.remove = qcom_ppe_remove,
+};
+module_platform_driver(qcom_ppe_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(of, qcom_ppe_of_match);
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.h b/drivers/net/ethernet/qualcomm/ppe/ppe.h
new file mode 100644
index 000000000000..f54406a6feb7
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe.h
@@ -0,0 +1,143 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/* PPE clock, reset and register read/write declarations. */
+
+#ifndef __PPE_H__
+#define __PPE_H__
+
+#include <linux/clk.h>
+#include <linux/reset.h>
+
+enum ppe_clk_id {
+	/* clocks for CMN PLL */
+	PPE_CMN_AHB_CLK,
+	PPE_CMN_SYS_CLK,
+	/* clocks for PPE integrated uniphy */
+	PPE_UNIPHY0_SYS_CLK,
+	PPE_UNIPHY1_SYS_CLK,
+	PPE_UNIPHY2_SYS_CLK,
+	PPE_UNIPHY0_AHB_CLK,
+	PPE_UNIPHY1_AHB_CLK,
+	PPE_UNIPHY2_AHB_CLK,
+	/* clocks for NSS NOC that is connected with PPE */
+	PPE_NSSCC_CLK,
+	PPE_NSSNOC_NSSCC_CLK,
+	PPE_NSSNOC_SNOC_CLK,
+	PPE_NSSNOC_SNOC_1_CLK,
+	/* clock for sleep that is needed for PPE reset */
+	PPE_IM_SLEEP_CLK,
+	/* clocks for PPE block */
+	PPE_PPE_CLK,
+	PPE_PPE_CFG_CLK,
+	PPE_NSSNOC_PPE_CLK,
+	PPE_NSSNOC_PPE_CFG_CLK,
+	/* clocks for EDMA to be enabled during the PPE initialization */
+	PPE_EDMA_CLK,
+	PPE_EDMA_CFG_CLK,
+	/* clocks for PPE IPE/BTQ modules */
+	PPE_PPE_IPE_CLK,
+	PPE_PPE_BTQ_CLK,
+	/* clocks for PPE integrated MAC */
+	PPE_PORT1_MAC_CLK,
+	PPE_PORT2_MAC_CLK,
+	PPE_PORT3_MAC_CLK,
+	PPE_PORT4_MAC_CLK,
+	PPE_PORT5_MAC_CLK,
+	PPE_PORT6_MAC_CLK,
+	/* clocks for PPE port */
+	PPE_NSS_PORT1_RX_CLK,
+	PPE_NSS_PORT1_TX_CLK,
+	PPE_NSS_PORT2_RX_CLK,
+	PPE_NSS_PORT2_TX_CLK,
+	PPE_NSS_PORT3_RX_CLK,
+	PPE_NSS_PORT3_TX_CLK,
+	PPE_NSS_PORT4_RX_CLK,
+	PPE_NSS_PORT4_TX_CLK,
+	PPE_NSS_PORT5_RX_CLK,
+	PPE_NSS_PORT5_TX_CLK,
+	PPE_NSS_PORT6_RX_CLK,
+	PPE_NSS_PORT6_TX_CLK,
+	/* clocks for PPE uniphy port */
+	PPE_UNIPHY_PORT1_RX_CLK,
+	PPE_UNIPHY_PORT1_TX_CLK,
+	PPE_UNIPHY_PORT2_RX_CLK,
+	PPE_UNIPHY_PORT2_TX_CLK,
+	PPE_UNIPHY_PORT3_RX_CLK,
+	PPE_UNIPHY_PORT3_TX_CLK,
+	PPE_UNIPHY_PORT4_RX_CLK,
+	PPE_UNIPHY_PORT4_TX_CLK,
+	PPE_UNIPHY_PORT5_RX_CLK,
+	PPE_UNIPHY_PORT5_TX_CLK,
+	PPE_UNIPHY_PORT6_RX_CLK,
+	PPE_UNIPHY_PORT6_TX_CLK,
+	/* source clock for PPE port5 */
+	PPE_NSS_PORT5_RX_CLK_SRC,
+	PPE_NSS_PORT5_TX_CLK_SRC,
+	PPE_CLK_MAX
+};
+
+enum ppe_rst_id {
+	/* reset for PPE block */
+	PPE_RST_PPE_RST,
+	/* resets for uniphy */
+	PPE_UNIPHY0_SYS_RST,
+	PPE_UNIPHY1_SYS_RST,
+	PPE_UNIPHY2_SYS_RST,
+	PPE_UNIPHY0_AHB_RST,
+	PPE_UNIPHY1_AHB_RST,
+	PPE_UNIPHY2_AHB_RST,
+	PPE_UNIPHY0_XPCS_RST,
+	PPE_UNIPHY1_XPCS_RST,
+	PPE_UNIPHY2_XPCS_RST,
+	PPE_UNIPHY0_SOFT_RST,
+	PPE_UNIPHY1_SOFT_RST,
+	PPE_UNIPHY2_SOFT_RST,
+	/* resets for uniphy port */
+	PPE_UNIPHY_PORT1_DIS,
+	PPE_UNIPHY_PORT2_DIS,
+	PPE_UNIPHY_PORT3_DIS,
+	PPE_UNIPHY_PORT4_DIS,
+	PPE_UNIPHY_PORT1_RX_RST,
+	PPE_UNIPHY_PORT1_TX_RST,
+	PPE_UNIPHY_PORT2_RX_RST,
+	PPE_UNIPHY_PORT2_TX_RST,
+	/* resets for PPE port */
+	PPE_NSS_PORT1_RX_RST,
+	PPE_NSS_PORT1_TX_RST,
+	PPE_NSS_PORT2_RX_RST,
+	PPE_NSS_PORT2_TX_RST,
+	PPE_NSS_PORT1_RST,
+	PPE_NSS_PORT2_RST,
+	PPE_NSS_PORT3_RST,
+	PPE_NSS_PORT4_RST,
+	PPE_NSS_PORT5_RST,
+	PPE_NSS_PORT6_RST,
+	/* resets for PPE MAC */
+	PPE_NSS_PORT1_MAC_RST,
+	PPE_NSS_PORT2_MAC_RST,
+	PPE_NSS_PORT3_MAC_RST,
+	PPE_NSS_PORT4_MAC_RST,
+	PPE_NSS_PORT5_MAC_RST,
+	PPE_NSS_PORT6_MAC_RST,
+	PPE_RST_MAX
+};
+
+/* Different PPE type used on the different IPQ SoC platform */
+enum {
+	PPE_TYPE_APPE,
+	PPE_TYPE_MPPE,
+	PPE_TYPE_MAX = 0xff,
+};
+
+/* PPE private data of different PPE type device */
+struct ppe_data {
+	int ppe_type;
+	struct clk *clk[PPE_CLK_MAX];
+	struct reset_control *rst[PPE_RST_MAX];
+};
+
+int ppe_type_get(struct ppe_device *ppe_dev);
+#endif
diff --git a/include/linux/soc/qcom/ppe.h b/include/linux/soc/qcom/ppe.h
new file mode 100644
index 000000000000..90566a8841b4
--- /dev/null
+++ b/include/linux/soc/qcom/ppe.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/* PPE operations to be used by ethernet driver */
+
+#ifndef __QCOM_PPE_H__
+#define __QCOM_PPE_H__
+
+#include <linux/platform_device.h>
+
+/* PPE platform private data, which is used by external driver like
+ * Ethernet DMA driver.
+ */
+struct ppe_device {
+	struct device *dev;
+	struct regmap *regmap;
+	bool is_ppe_probed;
+	void *ppe_priv;
+};
+
+/* Function used to check PPE platform dirver is registered correctly or not. */
+bool ppe_is_probed(struct platform_device *pdev);
+
+/* Function used to get the PPE device */
+struct ppe_device *ppe_dev_get(struct platform_device *pdev);
+#endif
-- 
2.42.0


