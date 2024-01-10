Return-Path: <linux-kernel+bounces-22127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 789848299BC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD3D6B2462A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23684CE11;
	Wed, 10 Jan 2024 11:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mcDjQXmM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB24481DE;
	Wed, 10 Jan 2024 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A8doh8031233;
	Wed, 10 Jan 2024 11:44:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=da/DI8o+6ToMwY70Otmo0GbDm02pZQ6m/g1KRkyU7nQ=; b=mc
	DjQXmM3m5+xIh5buRZabp1YP8caZujDIxzqmcPGuhmluEYcH6QF/bofcGoPtkyHM
	mpG8IFFhQphz/ChiXOg3IvKQr/OfZ8GVfPGJ/35rRyqlUQsbPNFihZxIOlCBnKBF
	2ErQSh2Jn8lER0Oze/UW7kf+gywvt3K94YWQtZh6eqaZz8/kMGfr+OfXWfjE6o7R
	/bPvbsRTGijhKKeuDlEY2MGNyVOdOj1MVKNcxy+MF+bypc+WacE1vwqD2FPLYcD/
	mBxhB9xrg3dMDC9wvdN4Uv9bp4Srmi+ogUxBTT3cKbhcHAggSp7Lcmz02OQkhApe
	Lt0n5ZN4JBqypddqvxRQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhq2h0g24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:44:07 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40ABi6Hu009108
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:44:06 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 03:43:56 -0800
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
Subject: [PATCH net-next 18/20] net: ethernet: qualcomm: Add PPE MAC support for phylink
Date: Wed, 10 Jan 2024 19:40:30 +0800
Message-ID: <20240110114033.32575-19-quic_luoj@quicinc.com>
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
X-Proofpoint-GUID: DMeM8tfRKtKaHPLHeJRcTZKeHduT7KHU
X-Proofpoint-ORIG-GUID: DMeM8tfRKtKaHPLHeJRcTZKeHduT7KHU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100096

From: Lei Wei <quic_leiwei@quicinc.com>

This driver adds support for PPE MAC initialization and MAC
operations which used by phylink.

Signed-off-by: Lei Wei <quic_leiwei@quicinc.com>
Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/ethernet/qualcomm/Kconfig        |   3 +
 drivers/net/ethernet/qualcomm/ppe/ppe.c      | 904 +++++++++++++++++++
 drivers/net/ethernet/qualcomm/ppe/ppe.h      |  33 +
 drivers/net/ethernet/qualcomm/ppe/ppe_regs.h | 112 +++
 include/linux/soc/qcom/ppe.h                 |  33 +
 5 files changed, 1085 insertions(+)

diff --git a/drivers/net/ethernet/qualcomm/Kconfig b/drivers/net/ethernet/qualcomm/Kconfig
index fe826c508f64..261f6b8c0d2e 100644
--- a/drivers/net/ethernet/qualcomm/Kconfig
+++ b/drivers/net/ethernet/qualcomm/Kconfig
@@ -65,6 +65,9 @@ config QCOM_PPE
 	tristate "Qualcomm Technologies, Inc. PPE Ethernet support"
 	depends on HAS_IOMEM && OF
 	depends on COMMON_CLK
+	select PHYLINK
+	select HWMON
+	select SFP
 	help
 	  This driver supports the Qualcomm Technologies, Inc. packet
 	  process engine(PPE) available with IPQ SoC. The PPE houses
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.c b/drivers/net/ethernet/qualcomm/ppe/ppe.c
index 21040efe71fc..d241ff3eab84 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe.c
@@ -13,6 +13,8 @@
 #include <linux/regmap.h>
 #include <linux/platform_device.h>
 #include <linux/if_ether.h>
+#include <linux/of_net.h>
+#include <linux/rtnetlink.h>
 #include <linux/soc/qcom/ppe.h>
 #include "ppe.h"
 #include "ppe_regs.h"
@@ -197,6 +199,19 @@ struct reset_control **ppe_reset_get(struct ppe_device *ppe_dev)
 	return ppe_dev_priv->rst;
 }
 
+static struct ppe_port *ppe_port_get(struct ppe_device *ppe_dev, int port)
+{
+	struct ppe_ports *ppe_ports = (struct ppe_ports *)ppe_dev->ports;
+	int i = 0;
+
+	for (i = 0; i < ppe_ports->num; i++) {
+		if (ppe_ports->port[i].port_id == port)
+			return &ppe_ports->port[i];
+	}
+
+	return NULL;
+}
+
 static int ppe_clock_set_enable(struct ppe_device *ppe_dev,
 				enum ppe_clk_id clk_id, unsigned long rate)
 {
@@ -302,6 +317,869 @@ static int ppe_clock_config(struct platform_device *pdev)
 	return 0;
 }
 
+static int ppe_port_mac_reset(struct ppe_device *ppe_dev, int port)
+{
+	struct ppe_data *ppe_dev_priv = ppe_dev->ppe_priv;
+
+	reset_control_assert(ppe_dev_priv->rst[PPE_NSS_PORT1_MAC_RST + port - 1]);
+	if (ppe_dev_priv->ppe_type == PPE_TYPE_APPE) {
+		reset_control_assert(ppe_dev_priv->rst[PPE_NSS_PORT1_RST + port]);
+	} else if (ppe_dev_priv->ppe_type == PPE_TYPE_MPPE) {
+		reset_control_assert(ppe_dev_priv->rst[PPE_NSS_PORT1_RX_RST + ((port - 1) << 1)]);
+		reset_control_assert(ppe_dev_priv->rst[PPE_NSS_PORT1_TX_RST + ((port - 1) << 1)]);
+	}
+	fsleep(150000);
+
+	reset_control_deassert(ppe_dev_priv->rst[PPE_NSS_PORT1_MAC_RST + port - 1]);
+	if (ppe_dev_priv->ppe_type == PPE_TYPE_APPE) {
+		reset_control_deassert(ppe_dev_priv->rst[PPE_NSS_PORT1_RST + port]);
+	} else if (ppe_dev_priv->ppe_type == PPE_TYPE_MPPE) {
+		reset_control_deassert(ppe_dev_priv->rst[PPE_NSS_PORT1_RX_RST + ((port - 1) << 1)]);
+		reset_control_deassert(ppe_dev_priv->rst[PPE_NSS_PORT1_TX_RST + ((port - 1) << 1)]);
+	}
+	fsleep(150000);
+
+	return 0;
+}
+
+static int ppe_gcc_port_speed_clk_set(struct ppe_device *ppe_dev,
+				      int port, int speed, phy_interface_t interface)
+{
+	struct ppe_data *ppe_dev_priv = ppe_dev->ppe_priv;
+	enum ppe_clk_id rx_id, tx_id;
+	unsigned long rate = 0;
+	int err = 0;
+
+	rx_id = PPE_NSS_PORT1_RX_CLK + ((port - 1) << 1);
+	tx_id = PPE_NSS_PORT1_TX_CLK + ((port - 1) << 1);
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_USXGMII:
+	case PHY_INTERFACE_MODE_10GKR:
+	case PHY_INTERFACE_MODE_QUSGMII:
+	case PHY_INTERFACE_MODE_10GBASER:
+		if (speed == SPEED_10)
+			rate = 1250000;
+		else if (speed == SPEED_100)
+			rate = 12500000;
+		else if (speed == SPEED_1000)
+			rate = 125000000;
+		else if (speed == SPEED_2500)
+			rate = 78125000;
+		else if (speed == SPEED_5000)
+			rate = 156250000;
+		else if (speed == SPEED_10000)
+			rate = 312500000;
+		break;
+	case PHY_INTERFACE_MODE_2500BASEX:
+		if (speed == SPEED_2500)
+			rate = 312500000;
+		break;
+	case PHY_INTERFACE_MODE_QSGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_SGMII:
+		if (speed == SPEED_10)
+			rate = 2500000;
+		else if (speed == SPEED_100)
+			rate = 25000000;
+		else if (speed == SPEED_1000)
+			rate = 125000000;
+		break;
+	default:
+		break;
+	}
+
+	if (!IS_ERR(ppe_dev_priv->clk[rx_id])) {
+		err = clk_set_rate(ppe_dev_priv->clk[rx_id], rate);
+		if (err) {
+			dev_err(ppe_dev->dev,
+				"Failed to set ppe port %d speed rx clk(%d)\n",
+				port, rx_id);
+			return err;
+		}
+	}
+
+	if (!IS_ERR(ppe_dev_priv->clk[tx_id])) {
+		err = clk_set_rate(ppe_dev_priv->clk[tx_id], rate);
+		if (err) {
+			dev_err(ppe_dev->dev,
+				"Failed to set ppe port %d speed rx clk(%d)\n",
+				port, rx_id);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static int ppe_mac_speed_set(struct ppe_device *ppe_dev,
+			     int port, int speed, phy_interface_t interface)
+{
+	struct ppe_port *ppe_port = ppe_port_get(ppe_dev, port);
+	u32 val;
+
+	if (!ppe_port) {
+		dev_err(ppe_dev->dev, "Failed to find ppe port %d\n", port);
+		return -ENOENT;
+	}
+
+	if (ppe_port->mac_type == PPE_MAC_TYPE_GMAC) {
+		ppe_read(ppe_dev,
+			 PPE_PORT_GMAC_ADDR(port) + GMAC_SPEED,
+			 &val);
+		val &= ~GMAC_SPEED_MASK;
+		switch (speed) {
+		case SPEED_10:
+			val |= GMAC_SPEED_10;
+			break;
+		case SPEED_100:
+			val |= GMAC_SPEED_100;
+			break;
+		case SPEED_1000:
+			val |= GMAC_SPEED_1000;
+			break;
+		default:
+			break;
+		}
+		ppe_write(ppe_dev,
+			  PPE_PORT_GMAC_ADDR(port) + GMAC_SPEED,
+			  val);
+	} else if (ppe_port->mac_type == PPE_MAC_TYPE_XGMAC) {
+		ppe_read(ppe_dev,
+			 PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_CONFIGURATION,
+			 &val);
+		val &= ~XGMAC_SPEED_MASK;
+		switch (speed) {
+		case SPEED_10000:
+			if (interface == PHY_INTERFACE_MODE_USXGMII ||
+			    interface == PHY_INTERFACE_MODE_QUSGMII)
+				val |= XGMAC_SPEED_10000_USXGMII;
+			else
+				val |= XGMAC_SPEED_10000;
+			break;
+		case SPEED_5000:
+			val |= XGMAC_SPEED_5000;
+			break;
+		case SPEED_2500:
+			if (interface == PHY_INTERFACE_MODE_USXGMII ||
+			    interface == PHY_INTERFACE_MODE_QUSGMII)
+				val |= XGMAC_SPEED_2500_USXGMII;
+			else
+				val |= XGMAC_SPEED_2500;
+			break;
+		case SPEED_1000:
+			val |= XGMAC_SPEED_1000;
+			break;
+		case SPEED_100:
+			val |= XGMAC_SPEED_100;
+			break;
+		case SPEED_10:
+			val |= XGMAC_SPEED_10;
+			break;
+		default:
+			break;
+		}
+		ppe_write(ppe_dev,
+			  PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_CONFIGURATION,
+			  val);
+	}
+
+	return 0;
+}
+
+static int ppe_mac_duplex_set(struct ppe_device *ppe_dev, int port, int duplex)
+{
+	struct ppe_port *ppe_port = ppe_port_get(ppe_dev, port);
+	u32 val;
+
+	if (!ppe_port) {
+		dev_err(ppe_dev->dev, "Failed to find ppe port %d\n", port);
+		return -ENOENT;
+	}
+
+	if (ppe_port->mac_type == PPE_MAC_TYPE_GMAC) {
+		ppe_read(ppe_dev,
+			 PPE_PORT_GMAC_ADDR(port) + GMAC_ENABLE,
+			 &val);
+		if (duplex == DUPLEX_FULL)
+			val |= GMAC_DUPLEX_FULL;
+		else
+			val &= ~GMAC_DUPLEX_FULL;
+		ppe_write(ppe_dev,
+			  PPE_PORT_GMAC_ADDR(port) + GMAC_ENABLE,
+			  val);
+	}
+
+	return 0;
+}
+
+static int ppe_mac_txfc_status_set(struct ppe_device *ppe_dev, int port, bool enable)
+{
+	struct ppe_port *ppe_port = ppe_port_get(ppe_dev, port);
+	u32 val;
+
+	if (!ppe_port) {
+		dev_err(ppe_dev->dev, "Failed to find ppe port %d\n", port);
+		return -ENOENT;
+	}
+
+	if (ppe_port->mac_type == PPE_MAC_TYPE_GMAC) {
+		ppe_read(ppe_dev,
+			 PPE_PORT_GMAC_ADDR(port) + GMAC_ENABLE,
+			 &val);
+		if (enable)
+			val |= GMAC_TX_FLOW_EN;
+		else
+			val &= ~GMAC_TX_FLOW_EN;
+		ppe_write(ppe_dev,
+			  PPE_PORT_GMAC_ADDR(port) + GMAC_ENABLE,
+			  val);
+	} else if (ppe_port->mac_type == PPE_MAC_TYPE_XGMAC) {
+		ppe_read(ppe_dev,
+			 PPE_PORT_XGMAC_ADDR(port) + XGMAC_Q0_TX_FLOW_CTRL,
+			 &val);
+		if (enable) {
+			val &= ~XGMAC_PT_MASK;
+			val |= (XGMAC_PAUSE_TIME | XGMAC_TFE);
+		} else {
+			val &= ~XGMAC_TFE;
+		}
+		ppe_write(ppe_dev,
+			  PPE_PORT_XGMAC_ADDR(port) + XGMAC_Q0_TX_FLOW_CTRL,
+			  val);
+	}
+
+	ppe_read(ppe_dev,
+		 PPE_BM_PORT_FC_MODE + PPE_BM_PORT_FC_MODE_INC * (port + 7),
+		 &val);
+	if (enable)
+		val |= PPE_BM_PORT_FC_MODE_EN;
+	else
+		val &= ~PPE_BM_PORT_FC_MODE_EN;
+	ppe_write(ppe_dev,
+		  PPE_BM_PORT_FC_MODE + PPE_BM_PORT_FC_MODE_INC * (port + 7),
+		  val);
+
+	return 0;
+}
+
+static int ppe_mac_rxfc_status_set(struct ppe_device *ppe_dev, int port, bool enable)
+{
+	struct ppe_port *ppe_port = ppe_port_get(ppe_dev, port);
+	u32 val;
+
+	if (!ppe_port) {
+		dev_err(ppe_dev->dev, "Failed to find ppe port %d\n", port);
+		return -ENOENT;
+	}
+
+	if (ppe_port->mac_type == PPE_MAC_TYPE_GMAC) {
+		ppe_read(ppe_dev,
+			 PPE_PORT_GMAC_ADDR(port) + GMAC_ENABLE,
+			 &val);
+		if (enable)
+			val |= GMAC_RX_FLOW_EN;
+		else
+			val &= ~GMAC_RX_FLOW_EN;
+		ppe_write(ppe_dev,
+			  PPE_PORT_GMAC_ADDR(port) + GMAC_ENABLE,
+			  val);
+	} else if (ppe_port->mac_type == PPE_MAC_TYPE_XGMAC) {
+		ppe_read(ppe_dev,
+			 PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_FLOW_CTRL,
+			 &val);
+		if (enable)
+			val |= XGMAC_RFE;
+		else
+			val &= ~XGMAC_RFE;
+		ppe_write(ppe_dev,
+			  PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_FLOW_CTRL,
+			  val);
+	}
+
+	return 0;
+}
+
+static int ppe_mac_txmac_en_set(struct ppe_device *ppe_dev, int port, bool enable)
+{
+	struct ppe_port *ppe_port = ppe_port_get(ppe_dev, port);
+	u32 val;
+
+	if (!ppe_port) {
+		dev_err(ppe_dev->dev, "Failed to find ppe port %d\n", port);
+		return -ENOENT;
+	}
+
+	if (ppe_port->mac_type == PPE_MAC_TYPE_GMAC) {
+		ppe_read(ppe_dev,
+			 PPE_PORT_GMAC_ADDR(port) + GMAC_ENABLE,
+			 &val);
+		if (enable)
+			val |= GMAC_TXMAC_EN;
+		else
+			val &= ~GMAC_TXMAC_EN;
+		ppe_write(ppe_dev,
+			  PPE_PORT_GMAC_ADDR(port) + GMAC_ENABLE,
+			  val);
+	} else if (ppe_port->mac_type == PPE_MAC_TYPE_XGMAC) {
+		ppe_read(ppe_dev,
+			 PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_CONFIGURATION,
+			 &val);
+		if (enable)
+			val |= XGMAC_TE;
+		else
+			val &= ~XGMAC_TE;
+		ppe_write(ppe_dev,
+			  PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_CONFIGURATION,
+			  val);
+	}
+
+	return 0;
+}
+
+static int ppe_mac_rxmac_en_set(struct ppe_device *ppe_dev, int port, bool enable)
+{
+	struct ppe_port *ppe_port = ppe_port_get(ppe_dev, port);
+	u32 val;
+
+	if (!ppe_port) {
+		dev_err(ppe_dev->dev, "Failed to find ppe port %d\n", port);
+		return -ENOENT;
+	}
+
+	if (ppe_port->mac_type == PPE_MAC_TYPE_GMAC) {
+		ppe_read(ppe_dev,
+			 PPE_PORT_GMAC_ADDR(port) + GMAC_ENABLE,
+			 &val);
+		if (enable)
+			val |= GMAC_RXMAC_EN;
+		else
+			val &= ~GMAC_RXMAC_EN;
+		ppe_write(ppe_dev,
+			  PPE_PORT_GMAC_ADDR(port) + GMAC_ENABLE,
+			  val);
+	} else if (ppe_port->mac_type == PPE_MAC_TYPE_XGMAC) {
+		ppe_read(ppe_dev,
+			 PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_CONFIGURATION,
+			 &val);
+		if (enable)
+			val |= XGMAC_RE;
+		else
+			val &= ~XGMAC_RE;
+		ppe_write(ppe_dev,
+			  PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_CONFIGURATION,
+			  val);
+	}
+
+	return 0;
+}
+
+static int ppe_port_bridge_txmac_en_set(struct ppe_device *ppe_dev, int port, bool enable)
+{
+	u32 val;
+
+	ppe_read(ppe_dev,
+		 PPE_PORT_BRIDGE_CTRL + PPE_PORT_BRIDGE_CTRL_INC * port,
+		 &val);
+
+	if (enable)
+		val |= PPE_PORT_BRIDGE_CTRL_TXMAC_EN;
+	else
+		val &= ~PPE_PORT_BRIDGE_CTRL_TXMAC_EN;
+
+	ppe_write(ppe_dev,
+		  PPE_PORT_BRIDGE_CTRL + PPE_PORT_BRIDGE_CTRL_INC * port,
+		  val);
+
+	return 0;
+}
+
+static void ppe_phylink_mac_config(struct ppe_device *ppe_dev, int port,
+				   unsigned int mode, const struct phylink_link_state *state)
+{
+	struct ppe_port *ppe_port = ppe_port_get(ppe_dev, port);
+	int mac_type;
+	u32 val;
+
+	if (!ppe_port) {
+		dev_err(ppe_dev->dev, "Failed to find ppe port %d\n", port);
+		return;
+	}
+
+	switch (state->interface) {
+	case PHY_INTERFACE_MODE_USXGMII:
+	case PHY_INTERFACE_MODE_2500BASEX:
+	case PHY_INTERFACE_MODE_10GBASER:
+	case PHY_INTERFACE_MODE_QUSGMII:
+		mac_type = PPE_MAC_TYPE_XGMAC;
+		break;
+	default:
+		mac_type = PPE_MAC_TYPE_GMAC;
+		break;
+	}
+
+	if (ppe_port->mac_type != mac_type) {
+		/* Reset port mac for gmac */
+		if (mac_type == PPE_MAC_TYPE_GMAC)
+			ppe_port_mac_reset(ppe_dev, port);
+
+		/* Port mux to select gmac or xgmac */
+		mutex_lock(&ppe_dev->reg_mutex);
+		ppe_read(ppe_dev, PPE_PORT_MUX_CTRL, &val);
+		if (mac_type == PPE_MAC_TYPE_GMAC)
+			val &= ~PPE_PORT_MAC_SEL(port);
+		else
+			val |= PPE_PORT_MAC_SEL(port);
+		if (port == PPE_PORT5)
+			val |= PPE_PORT5_PCS_SEL;
+
+		ppe_write(ppe_dev, PPE_PORT_MUX_CTRL, val);
+		mutex_unlock(&ppe_dev->reg_mutex);
+		ppe_port->mac_type = mac_type;
+	}
+
+	/* Reset ppe port link status when interface changes,
+	 * this allows PPE MAC and UNIPHY to be configured
+	 * according to the port link up status in ppe phylink
+	 * mac link up.
+	 */
+	if (state->interface != ppe_port->interface) {
+		ppe_port->speed = SPEED_UNKNOWN;
+		ppe_port->duplex = DUPLEX_UNKNOWN;
+		ppe_port->pause = MLO_PAUSE_NONE;
+		ppe_port->interface = state->interface;
+	}
+
+	dev_info(ppe_dev->dev, "PPE port %d mac config: interface %s, mac_type %d\n",
+		 port, phy_modes(state->interface), mac_type);
+}
+
+static struct phylink_pcs *ppe_phylink_mac_select_pcs(struct ppe_device *ppe_dev,
+						      int port, phy_interface_t interface)
+{
+	struct ppe_uniphy *uniphy = (struct ppe_uniphy *)ppe_dev->uniphy;
+	int ppe_type = ppe_type_get(ppe_dev);
+	int index;
+
+	switch (port) {
+	case PPE_PORT6:
+		index = 2;
+		break;
+	case PPE_PORT5:
+		index = 1;
+		break;
+	case PPE_PORT4:
+	case PPE_PORT3:
+		index = 0;
+		break;
+	case PPE_PORT2:
+		if (ppe_type == PPE_TYPE_MPPE)
+			index = 1;
+		else if (ppe_type == PPE_TYPE_APPE)
+			index = 0;
+		break;
+	case PPE_PORT1:
+		index = 0;
+		break;
+	default:
+		index = -1;
+		break;
+	}
+
+	if (index >= 0)
+		return &uniphy[index].pcs;
+	else
+		return NULL;
+}
+
+static void ppe_phylink_mac_link_up(struct ppe_device *ppe_dev, int port,
+				    struct phy_device *phy,
+				    unsigned int mode, phy_interface_t interface,
+				    int speed, int duplex, bool tx_pause, bool rx_pause)
+{
+	struct phylink_pcs *pcs = ppe_phylink_mac_select_pcs(ppe_dev, port, interface);
+	struct ppe_uniphy *uniphy = pcs_to_ppe_uniphy(pcs);
+	struct ppe_port *ppe_port = ppe_port_get(ppe_dev, port);
+
+	/* Wait uniphy auto-negotiation completion */
+	ppe_uniphy_autoneg_complete_check(uniphy, port);
+
+	if (speed != ppe_port->speed ||
+	    duplex != ppe_port->duplex ||
+		tx_pause != !!(ppe_port->pause & MLO_PAUSE_TX) ||
+		rx_pause != !!(ppe_port->pause & MLO_PAUSE_RX)) {
+		/* Disable gcc uniphy port clk */
+		ppe_uniphy_port_gcc_clock_en_set(uniphy, port, false);
+
+		if (speed != ppe_port->speed) {
+			/* Set gcc port speed clock */
+			ppe_gcc_port_speed_clk_set(ppe_dev, port, speed, interface);
+			fsleep(10000);
+			/* Set uniphy channel speed */
+			ppe_uniphy_speed_set(uniphy, port, speed);
+			/* Set mac speed */
+			ppe_mac_speed_set(ppe_dev, port, speed, interface);
+			ppe_port->speed = speed;
+		}
+
+		if (duplex != ppe_port->duplex) {
+			/* Set uniphy channel duplex */
+			ppe_uniphy_duplex_set(uniphy, port, duplex);
+			/* Set mac duplex */
+			ppe_mac_duplex_set(ppe_dev, port, duplex);
+			ppe_port->duplex = duplex;
+		}
+
+		if (tx_pause != !!(ppe_port->pause & MLO_PAUSE_TX)) {
+			/* Set mac tx flow ctrl */
+			ppe_mac_txfc_status_set(ppe_dev, port, tx_pause);
+			if (tx_pause)
+				ppe_port->pause |= MLO_PAUSE_TX;
+			else
+				ppe_port->pause &= ~MLO_PAUSE_TX;
+		}
+
+		if (rx_pause != !!(ppe_port->pause & MLO_PAUSE_RX)) {
+			/* Set mac rx flow ctrl */
+			ppe_mac_rxfc_status_set(ppe_dev, port, rx_pause);
+			if (rx_pause)
+				ppe_port->pause |= MLO_PAUSE_RX;
+			else
+				ppe_port->pause &= ~MLO_PAUSE_RX;
+		}
+
+		/* Enable gcc uniphy port clk */
+		ppe_uniphy_port_gcc_clock_en_set(uniphy, port, true);
+
+		/* Reset uniphy channel adapter */
+		ppe_uniphy_adapter_reset(uniphy, port);
+	}
+
+	/* Enable ppe mac tx and rx */
+	ppe_mac_txmac_en_set(ppe_dev, port, true);
+	ppe_mac_rxmac_en_set(ppe_dev, port, true);
+
+	/* Enable ppe bridge port tx mac */
+	ppe_port_bridge_txmac_en_set(ppe_dev, port, true);
+
+	dev_info(ppe_dev->dev,
+		 "PPE port %d interface %s link up - %s%s - pause tx %d rx %d\n",
+		 port, phy_modes(interface), phy_speed_to_str(speed),
+		 phy_duplex_to_str(duplex), tx_pause, rx_pause);
+}
+
+static void ppe_phylink_mac_link_down(struct ppe_device *ppe_dev, int port,
+				      unsigned int mode, phy_interface_t interface)
+{
+	struct ppe_port *ppe_port = ppe_port_get(ppe_dev, port);
+
+	if (!ppe_port)
+		dev_err(ppe_dev->dev, "Failed to find ppe port %d\n", port);
+
+	/* Disable ppe port bridge tx mac */
+	ppe_port_bridge_txmac_en_set(ppe_dev, port, false);
+
+	/* Disable ppe mac rx */
+	ppe_mac_rxmac_en_set(ppe_dev, port, false);
+	fsleep(10000);
+
+	/* Disable ppe mac tx */
+	ppe_mac_txmac_en_set(ppe_dev, port, false);
+
+	dev_info(ppe_dev->dev, "PPE port %d interface %s link down\n",
+		 port, phy_modes(interface));
+}
+
+static int ppe_mac_init(struct platform_device *pdev)
+{
+	struct device_node *ports_node, *port_node;
+	struct ppe_device *ppe_dev = platform_get_drvdata(pdev);
+	struct ppe_ports *ppe_ports = NULL;
+	phy_interface_t phy_mode = PHY_INTERFACE_MODE_NA;
+	int i = 0, port = 0, err = 0, port_num = 0;
+
+	ports_node = of_get_child_by_name(pdev->dev.of_node, "qcom,port_phyinfo");
+	if (!ports_node) {
+		dev_err(&pdev->dev, "Failed to get qcom port phy info node\n");
+		return -ENODEV;
+	}
+
+	port_num = of_get_child_count(ports_node);
+
+	ppe_ports = devm_kzalloc(&pdev->dev,
+				 struct_size(ppe_ports, port, port_num),
+				 GFP_KERNEL);
+	if (!ppe_ports) {
+		err = -ENOMEM;
+		goto err_ports_node_put;
+	}
+
+	ppe_dev->ports = ppe_ports;
+	ppe_ports->num = port_num;
+
+	for_each_available_child_of_node(ports_node, port_node) {
+		err = of_property_read_u32(port_node, "port_id", &port);
+		if (err) {
+			dev_err(&pdev->dev, "Failed to get port id\n");
+			goto err_port_node_put;
+		}
+
+		err = of_get_phy_mode(port_node, &phy_mode);
+		if (err) {
+			dev_err(&pdev->dev, "Failed to get phy mode\n");
+			goto err_port_node_put;
+		}
+
+		ppe_ports->port[i].ppe_dev = ppe_dev;
+		ppe_ports->port[i].port_id = port;
+		ppe_ports->port[i].np = port_node;
+		ppe_ports->port[i].interface = phy_mode;
+		ppe_ports->port[i].mac_type = PPE_MAC_TYPE_NA;
+		ppe_ports->port[i].speed = SPEED_UNKNOWN;
+		ppe_ports->port[i].duplex = DUPLEX_UNKNOWN;
+		ppe_ports->port[i].pause = MLO_PAUSE_NONE;
+		i++;
+
+		/* Port gmac HW initialization */
+		ppe_mask(ppe_dev,
+			 PPE_PORT_GMAC_ADDR(port) + GMAC_ENABLE,
+			 GMAC_MAC_EN, 0);
+
+		ppe_mask(ppe_dev,
+			 PPE_PORT_GMAC_ADDR(port) + GMAC_MAC_JUMBO_SIZE,
+			 GMAC_JUMBO_SIZE_MASK,
+			 FIELD_PREP(GMAC_JUMBO_SIZE_MASK, MAC_MAX_FRAME_SIZE));
+
+		ppe_mask(ppe_dev,
+			 PPE_PORT_GMAC_ADDR(port) + GMAC_MAC_CTRL2,
+			 GMAC_INIT_CTRL2_FIELD, GMAC_INIT_CTRL2);
+
+		ppe_mask(ppe_dev,
+			 PPE_PORT_GMAC_ADDR(port) + GMAC_MAC_DBG_CTRL,
+			 GMAC_HIGH_IPG_MASK,
+			 FIELD_PREP(GMAC_HIGH_IPG_MASK, GMAC_IPG_CHECK));
+
+		ppe_mask(ppe_dev,
+			 PPE_PORT_GMAC_ADDR(port) + GMAC_MAC_MIB_CTRL,
+			 MAC_MIB_EN | MAC_MIB_RD_CLR | MAC_MIB_RESET,
+			 MAC_MIB_EN | MAC_MIB_RD_CLR | MAC_MIB_RESET);
+
+		ppe_mask(ppe_dev,
+			 PPE_PORT_GMAC_ADDR(port) + GMAC_MAC_MIB_CTRL,
+			 MAC_MIB_RESET, 0);
+
+		/* Port xgmac HW initialization */
+		ppe_mask(ppe_dev,
+			 PPE_PORT_XGMAC_ADDR(port) + XGMAC_TX_CONFIGURATION,
+			 XGMAC_INIT_TX_CONFIG_FIELD, XGMAC_INIT_TX_CONFIG);
+
+		ppe_mask(ppe_dev,
+			 PPE_PORT_XGMAC_ADDR(port) + XGMAC_RX_CONFIGURATION,
+			 XGMAC_INIT_RX_CONFIG_FIELD, XGMAC_INIT_RX_CONFIG);
+
+		ppe_mask(ppe_dev,
+			 PPE_PORT_XGMAC_ADDR(port) + XGMAC_WATCHDOG_TIMEOUT,
+			 XGMAC_INIT_WATCHDOG_FIELD, XGMAC_INIT_WATCHDOG);
+
+		ppe_mask(ppe_dev,
+			 PPE_PORT_XGMAC_ADDR(port) + XGMAC_PACKET_FILTER,
+			 XGMAC_INIT_FILTER_FIELD, XGMAC_INIT_FILTER);
+
+		ppe_mask(ppe_dev,
+			 PPE_PORT_XGMAC_ADDR(port) + XGMAC_MMC_CONTROL,
+			 XGMAC_MCF | XGMAC_CNTRST, XGMAC_CNTRST);
+	}
+
+	of_node_put(ports_node);
+	dev_info(ppe_dev->dev, "QCOM PPE MAC init success\n");
+	return 0;
+
+err_port_node_put:
+	of_node_put(port_node);
+err_ports_node_put:
+	of_node_put(ports_node);
+	return err;
+}
+
+static void ppe_mac_config(struct phylink_config *config, unsigned int mode,
+			   const struct phylink_link_state *state)
+{
+	struct ppe_device *ppe_dev = NULL;
+	struct ppe_port *ppe_port = container_of(config,
+						 struct ppe_port,
+						 phylink_config);
+
+	if (!ppe_port)
+		dev_err(ppe_dev->dev, "Failed to find ppe port\n");
+
+	ppe_dev = ppe_port->ppe_dev;
+
+	if (ppe_dev && ppe_dev->ppe_ops &&
+	    ppe_dev->ppe_ops->phylink_mac_config) {
+		ppe_dev->ppe_ops->phylink_mac_config(ppe_dev,
+						     ppe_port->port_id,
+						     mode, state);
+	} else {
+		dev_err(ppe_dev->dev,
+			"Failed to find ppe device mac config operation\n");
+	}
+}
+
+static void ppe_mac_link_down(struct phylink_config *config, unsigned int mode,
+			      phy_interface_t interface)
+{
+	struct ppe_device *ppe_dev = NULL;
+	struct ppe_port *ppe_port = container_of(config,
+						 struct ppe_port,
+						 phylink_config);
+
+	if (!ppe_port)
+		dev_err(ppe_dev->dev, "Failed to find ppe port\n");
+
+	ppe_dev = ppe_port->ppe_dev;
+
+	if (ppe_dev && ppe_dev->ppe_ops &&
+	    ppe_dev->ppe_ops->phylink_mac_link_down) {
+		ppe_dev->ppe_ops->phylink_mac_link_down(ppe_dev,
+							ppe_port->port_id,
+							mode, interface);
+	} else {
+		dev_err(ppe_dev->dev,
+			"Failed to find ppe device link down operation\n");
+	}
+}
+
+static void ppe_mac_link_up(struct phylink_config *config,
+			    struct phy_device *phy,
+			    unsigned int mode, phy_interface_t interface,
+			    int speed, int duplex, bool tx_pause, bool rx_pause)
+{
+	struct ppe_device *ppe_dev = NULL;
+	struct ppe_port *ppe_port = container_of(config,
+						 struct ppe_port,
+						 phylink_config);
+
+	if (!ppe_port)
+		dev_err(ppe_dev->dev, "Failed to find ppe port\n");
+
+	ppe_dev = ppe_port->ppe_dev;
+
+	if (ppe_dev && ppe_dev->ppe_ops &&
+	    ppe_dev->ppe_ops->phylink_mac_link_up) {
+		ppe_dev->ppe_ops->phylink_mac_link_up(ppe_dev,
+						      ppe_port->port_id,
+						      phy, mode, interface,
+						      speed, duplex,
+						      tx_pause, rx_pause);
+	} else {
+		dev_err(ppe_dev->dev,
+			"Failed to find ppe device link up operation\n");
+	}
+}
+
+static struct phylink_pcs *ppe_mac_select_pcs(struct phylink_config *config,
+					      phy_interface_t interface)
+{
+	struct ppe_device *ppe_dev = NULL;
+	struct ppe_port *ppe_port = container_of(config,
+						 struct ppe_port,
+						 phylink_config);
+
+	if (!ppe_port) {
+		dev_err(ppe_dev->dev, "Failed to find ppe port");
+		return NULL;
+	}
+
+	ppe_dev = ppe_port->ppe_dev;
+
+	if (ppe_dev && ppe_dev->ppe_ops &&
+	    ppe_dev->ppe_ops->phylink_mac_select_pcs) {
+		return ppe_dev->ppe_ops->phylink_mac_select_pcs(ppe_dev,
+								ppe_port->port_id,
+								interface);
+	} else {
+		dev_err(ppe_dev->dev,
+			"Failed to find ppe device pcs select operation\n");
+		return NULL;
+	}
+}
+
+static const struct phylink_mac_ops ppe_phylink_ops = {
+	.mac_config = ppe_mac_config,
+	.mac_link_down = ppe_mac_link_down,
+	.mac_link_up = ppe_mac_link_up,
+	.mac_select_pcs = ppe_mac_select_pcs,
+};
+
+static struct phylink *ppe_phylink_setup(struct ppe_device *ppe_dev,
+					 struct net_device *netdev,
+					 int port)
+{
+	struct ppe_port *ppe_port = ppe_port_get(ppe_dev, port);
+	int err;
+
+	if (!ppe_port) {
+		dev_err(ppe_dev->dev, "Failed to find ppe port %d\n", port);
+		return NULL;
+	}
+
+	/* per port phylink capability */
+	ppe_port->phylink_config.dev = &netdev->dev;
+	ppe_port->phylink_config.type = PHYLINK_NETDEV;
+	ppe_port->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+		MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD | MAC_5000FD | MAC_10000FD;
+	__set_bit(PHY_INTERFACE_MODE_SGMII,
+		  ppe_port->phylink_config.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+		  ppe_port->phylink_config.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+		  ppe_port->phylink_config.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_USXGMII,
+		  ppe_port->phylink_config.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_10GBASER,
+		  ppe_port->phylink_config.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_QSGMII,
+		  ppe_port->phylink_config.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_QUSGMII,
+		  ppe_port->phylink_config.supported_interfaces);
+
+	/* create phylink */
+	ppe_port->phylink = phylink_create(&ppe_port->phylink_config,
+					   of_fwnode_handle(ppe_port->np),
+					   ppe_port->interface, &ppe_phylink_ops);
+	if (IS_ERR(ppe_port->phylink)) {
+		dev_err(ppe_dev->dev, "Failed to create phylink for port %d\n", port);
+		return NULL;
+	}
+
+	/* connect phylink */
+	err = phylink_of_phy_connect(ppe_port->phylink, ppe_port->np, 0);
+	if (err) {
+		dev_err(ppe_dev->dev, "Failed to connect phylink for port %d\n", port);
+		phylink_destroy(ppe_port->phylink);
+		ppe_port->phylink = NULL;
+		return NULL;
+	}
+
+	return ppe_port->phylink;
+}
+
+static void ppe_phylink_destroy(struct ppe_device *ppe_dev, int port)
+{
+	struct ppe_port *ppe_port = ppe_port_get(ppe_dev, port);
+
+	if (!ppe_port)
+		dev_err(ppe_dev->dev, "Failed to find ppe port %d\n", port);
+
+	if (ppe_port->phylink) {
+		rtnl_lock();
+		phylink_disconnect_phy(ppe_port->phylink);
+		rtnl_unlock();
+		phylink_destroy(ppe_port->phylink);
+		ppe_port->phylink = NULL;
+	}
+}
+
 bool ppe_is_probed(struct platform_device *pdev)
 {
 	struct ppe_device *ppe_dev = platform_get_drvdata(pdev);
@@ -352,6 +1230,12 @@ static int ppe_port_maxframe_set(struct ppe_device *ppe_dev,
 }
 
 static struct ppe_device_ops qcom_ppe_ops = {
+	.phylink_setup = ppe_phylink_setup,
+	.phylink_destroy = ppe_phylink_destroy,
+	.phylink_mac_config = ppe_phylink_mac_config,
+	.phylink_mac_link_up = ppe_phylink_mac_link_up,
+	.phylink_mac_link_down = ppe_phylink_mac_link_down,
+	.phylink_mac_select_pcs = ppe_phylink_mac_select_pcs,
 	.set_maxframe = ppe_port_maxframe_set,
 };
 
@@ -1407,6 +2291,7 @@ static int qcom_ppe_probe(struct platform_device *pdev)
 				     PTR_ERR(ppe_dev->ppe_priv),
 				     "Fail to init ppe data\n");
 
+	mutex_init(&ppe_dev->reg_mutex);
 	platform_set_drvdata(pdev, ppe_dev);
 	ret = ppe_clock_config(pdev);
 	if (ret)
@@ -1426,6 +2311,10 @@ static int qcom_ppe_probe(struct platform_device *pdev)
 				     ret,
 				     "ppe device hw init failed\n");
 
+	ret = ppe_mac_init(pdev);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "ppe mac initialization failed\n");
+
 	ppe_dev->uniphy = ppe_uniphy_setup(pdev);
 	if (IS_ERR(ppe_dev->uniphy))
 		return dev_err_probe(&pdev->dev, ret, "ppe uniphy initialization failed\n");
@@ -1440,10 +2329,25 @@ static int qcom_ppe_probe(struct platform_device *pdev)
 static int qcom_ppe_remove(struct platform_device *pdev)
 {
 	struct ppe_device *ppe_dev;
+	struct ppe_ports *ppe_ports;
+	struct ppe_data *ppe_dev_priv;
+	int i, port;
 
 	ppe_dev = platform_get_drvdata(pdev);
+	ppe_dev_priv = ppe_dev->ppe_priv;
+	ppe_ports = (struct ppe_ports *)ppe_dev->ports;
+
 	ppe_debugfs_teardown(ppe_dev);
 
+	for (i = 0; i < ppe_ports->num; i++) {
+		/* Reset ppe port parent clock to XO clock */
+		port = ppe_ports->port[i].port_id;
+		clk_set_rate(ppe_dev_priv->clk[PPE_NSS_PORT1_RX_CLK + ((port - 1) << 1)],
+			     P_XO_CLOCK_RATE);
+		clk_set_rate(ppe_dev_priv->clk[PPE_NSS_PORT1_TX_CLK + ((port - 1) << 1)],
+			     P_XO_CLOCK_RATE);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.h b/drivers/net/ethernet/qualcomm/ppe/ppe.h
index 45b70f47cd21..532d53c05bf9 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe.h
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe.h
@@ -21,6 +21,9 @@
 #define PPE_PORT6		6
 #define PPE_PORT7		7
 
+/* PPE Port XO Clock Rate */
+#define P_XO_CLOCK_RATE		24000000
+
 enum ppe_clk_id {
 	/* clocks for CMN PLL */
 	PPE_CMN_AHB_CLK,
@@ -152,6 +155,14 @@ enum {
 	PPE_ACTION_REDIRECTED_TO_CPU
 };
 
+/* PPE MAC Type */
+enum {
+	PPE_MAC_TYPE_NA,
+	PPE_MAC_TYPE_GMAC,
+	PPE_MAC_TYPE_XGMAC,
+	PPE_MAC_TYPE_MAX
+};
+
 /* PPE private data of different PPE type device */
 struct ppe_data {
 	int ppe_type;
@@ -172,6 +183,28 @@ struct ppe_scheduler_port_resource {
 	int l1edrr[2];
 };
 
+/* PPE per port data type to record port settings such as phylink
+ * setting, mac type, interface mode and link speed.
+ */
+struct ppe_port {
+	struct phylink *phylink;
+	struct phylink_config phylink_config;
+	struct device_node *np;
+	struct ppe_device *ppe_dev;
+	phy_interface_t interface;
+	int mac_type;
+	int port_id;
+	int speed;
+	int duplex;
+	int pause;
+};
+
+/* PPE ports data type */
+struct ppe_ports {
+	unsigned int num;
+	struct ppe_port port[];
+};
+
 int ppe_type_get(struct ppe_device *ppe_dev);
 struct clk **ppe_clock_get(struct ppe_device *ppe_dev);
 struct reset_control **ppe_reset_get(struct ppe_device *ppe_dev);
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
index 13115405bad9..43cd067c8c73 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
@@ -7,6 +7,16 @@
 #ifndef __PPE_REGS_H__
 #define __PPE_REGS_H__
 
+#define PPE_PORT_MUX_CTRL					0x10
+#define PPE_PORT6_MAC_SEL					BIT(13)
+#define PPE_PORT5_MAC_SEL					BIT(12)
+#define PPE_PORT4_MAC_SEL					BIT(11)
+#define PPE_PORT3_MAC_SEL					BIT(10)
+#define PPE_PORT2_MAC_SEL					BIT(9)
+#define PPE_PORT1_MAC_SEL					BIT(8)
+#define PPE_PORT5_PCS_SEL					BIT(4)
+#define PPE_PORT_MAC_SEL(x)					(PPE_PORT1_MAC_SEL << ((x) - 1))
+
 #define PPE_BM_TDM_CTRL						0xb000
 #define PPE_BM_TDM_CTRL_NUM					1
 #define PPE_BM_TDM_CTRL_INC					4
@@ -819,4 +829,106 @@ union ppe_ac_grp_cfg_u {
 #define PPE_ENQ_OPR_TBL_INC					0x10
 #define PPE_ENQ_OPR_TBL_ENQ_DISABLE				BIT(0)
 
+/* PPE MAC Address */
+#define PPE_PORT_GMAC_ADDR(x)					(0x001000 + ((x) - 1) * 0x200)
+#define PPE_PORT_XGMAC_ADDR(x)					(0x500000 + ((x) - 1) * 0x4000)
+
+/* GMAC Registers */
+#define GMAC_ENABLE						0x0
+#define GMAC_TX_FLOW_EN						BIT(6)
+#define GMAC_RX_FLOW_EN						BIT(5)
+#define GMAC_DUPLEX_FULL					BIT(4)
+#define GMAC_TXMAC_EN						BIT(1)
+#define GMAC_RXMAC_EN						BIT(0)
+#define GMAC_MAC_EN						(GMAC_RXMAC_EN | GMAC_TXMAC_EN)
+
+#define GMAC_SPEED						0x4
+#define GMAC_SPEED_MASK						GENMASK(1, 0)
+#define GMAC_SPEED_10						0
+#define GMAC_SPEED_100						1
+#define GMAC_SPEED_1000						2
+
+#define GMAC_MAC_CTRL2						0x18
+#define GMAC_TX_THD_MASK					GENMASK(27, 24)
+#define GMAC_MAXFR_MASK						GENMASK(21, 8)
+#define GMAC_CRS_SEL						BIT(6)
+#define GMAC_TX_THD						0x1
+#define GMAC_INIT_CTRL2_FIELD					(GMAC_MAXFR_MASK | \
+								GMAC_CRS_SEL | GMAC_TX_THD_MASK)
+#define GMAC_INIT_CTRL2						(FIELD_PREP(GMAC_MAXFR_MASK, \
+				MAC_MAX_FRAME_SIZE) | FIELD_PREP(GMAC_TX_THD_MASK, GMAC_TX_THD))
+
+#define GMAC_MAC_DBG_CTRL					0x1c
+#define GMAC_HIGH_IPG_MASK					GENMASK(15, 8)
+#define GMAC_IPG_CHECK						0xc
+
+#define GMAC_MAC_JUMBO_SIZE					0x30
+#define GMAC_JUMBO_SIZE_MASK					GENMASK(13, 0)
+#define MAC_MAX_FRAME_SIZE					0x3000
+
+#define GMAC_MAC_MIB_CTRL					0x34
+#define MAC_MIB_RD_CLR						BIT(2)
+#define MAC_MIB_RESET						BIT(1)
+#define MAC_MIB_EN						BIT(0)
+
+/* XGMAC Registers */
+#define XGMAC_TX_CONFIGURATION					0x0
+#define XGMAC_SPEED_MASK					GENMASK(31, 29)
+#define XGMAC_SPEED_10000_USXGMII				FIELD_PREP(XGMAC_SPEED_MASK, 4)
+#define XGMAC_SPEED_10000					FIELD_PREP(XGMAC_SPEED_MASK, 0)
+#define XGMAC_SPEED_5000					FIELD_PREP(XGMAC_SPEED_MASK, 5)
+#define XGMAC_SPEED_2500_USXGMII				FIELD_PREP(XGMAC_SPEED_MASK, 6)
+#define XGMAC_SPEED_2500					FIELD_PREP(XGMAC_SPEED_MASK, 2)
+#define XGMAC_SPEED_1000					FIELD_PREP(XGMAC_SPEED_MASK, 3)
+#define XGMAC_SPEED_100						XGMAC_SPEED_1000
+#define XGMAC_SPEED_10						XGMAC_SPEED_1000
+
+#define XGMAC_JD						BIT(16)
+#define XGMAC_TE						BIT(0)
+#define XGMAC_INIT_TX_CONFIG_FIELD				(XGMAC_JD | XGMAC_TE)
+#define XGMAC_INIT_TX_CONFIG					XGMAC_JD
+
+#define XGMAC_RX_CONFIGURATION					0x4
+#define XGMAC_GPSL_MASK						GENMASK(29, 16)
+#define XGMAC_WD						BIT(7)
+#define XGMAC_GPSLCE						BIT(6)
+#define XGMAC_CST						BIT(2)
+#define XGMAC_ACS						BIT(1)
+#define XGMAC_RE						BIT(0)
+#define XGMAC_INIT_RX_CONFIG_FIELD				(XGMAC_RE | XGMAC_ACS | \
+					XGMAC_CST | XGMAC_WD | XGMAC_GPSLCE | XGMAC_GPSL_MASK)
+#define XGMAC_INIT_RX_CONFIG					(XGMAC_ACS | XGMAC_CST | \
+				XGMAC_GPSLCE | FIELD_PREP(XGMAC_GPSL_MASK, MAC_MAX_FRAME_SIZE))
+
+#define XGMAC_PACKET_FILTER					0x8
+#define XGMAC_RA						BIT(31)
+#define XGMAC_PCF_MASK						GENMASK(7, 6)
+#define XGMAC_PR						BIT(0)
+#define XGMAC_PASS_CONTROL_PACKET				0x2
+#define XGMAC_INIT_FILTER_FIELD					(XGMAC_RA | XGMAC_PR | \
+									XGMAC_PCF_MASK)
+#define XGMAC_INIT_FILTER					(XGMAC_RA | XGMAC_PR | \
+								FIELD_PREP(XGMAC_PCF_MASK, \
+									XGMAC_PASS_CONTROL_PACKET))
+
+#define XGMAC_WATCHDOG_TIMEOUT					0xc
+#define XGMAC_PWE						BIT(8)
+#define XGMAC_WTO_MASK						GENMASK(3, 0)
+#define XGMAC_WTO_LIMIT_13K					0xb
+#define XGMAC_INIT_WATCHDOG_FIELD				(XGMAC_PWE | XGMAC_WTO_MASK)
+#define XGMAC_INIT_WATCHDOG					(XGMAC_PWE | \
+						FIELD_PREP(XGMAC_WTO_MASK, XGMAC_WTO_LIMIT_13K))
+
+#define XGMAC_Q0_TX_FLOW_CTRL					0x70
+#define XGMAC_PT_MASK						GENMASK(31, 16)
+#define XGMAC_PAUSE_TIME					FIELD_PREP(XGMAC_PT_MASK, 0xffff)
+#define XGMAC_TFE						BIT(1)
+
+#define XGMAC_RX_FLOW_CTRL					0x90
+#define XGMAC_RFE						BIT(0)
+
+#define XGMAC_MMC_CONTROL					0x800
+#define XGMAC_MCF						BIT(3)
+#define XGMAC_CNTRST						BIT(0)
+
 #endif
diff --git a/include/linux/soc/qcom/ppe.h b/include/linux/soc/qcom/ppe.h
index d3cb18df33fa..40e69a262650 100644
--- a/include/linux/soc/qcom/ppe.h
+++ b/include/linux/soc/qcom/ppe.h
@@ -9,6 +9,7 @@
 #define __QCOM_PPE_H__
 
 #include <linux/platform_device.h>
+#include <linux/phylink.h>
 
 /* PPE platform private data, which is used by external driver like
  * Ethernet DMA driver.
@@ -20,6 +21,8 @@ struct ppe_device {
 	struct dentry *debugfs_root;
 	bool is_ppe_probed;
 	void *ppe_priv;
+	struct mutex reg_mutex; /* Protects ppe reg operation */
+	void *ports;
 	void *uniphy;
 };
 
@@ -27,6 +30,36 @@ struct ppe_device {
  * DMA driver to configure PPE.
  */
 struct ppe_device_ops {
+	/*
+	 * PHYLINK integration
+	 */
+	struct phylink *(*phylink_setup)(struct ppe_device *ppe_dev,
+					 struct net_device *netdev, int port);
+	void	(*phylink_destroy)(struct ppe_device *ppe_dev,
+				   int port);
+	void	(*phylink_mac_config)(struct ppe_device *ppe_dev,
+				      int port,
+				      unsigned int mode,
+				      const struct phylink_link_state *state);
+	void	(*phylink_mac_link_up)(struct ppe_device *ppe_dev,
+				       int port,
+				       struct phy_device *phy,
+				       unsigned int mode,
+				       phy_interface_t interface,
+				       int speed,
+				       int duplex,
+				       bool tx_pause,
+				       bool rx_pause);
+	void	(*phylink_mac_link_down)(struct ppe_device *ppe_dev,
+					 int port,
+					 unsigned int mode,
+					 phy_interface_t interface);
+	struct phylink_pcs *(*phylink_mac_select_pcs)(struct ppe_device *ppe_dev,
+						      int port,
+						      phy_interface_t interface);
+	/*
+	 * Port maximum frame size setting
+	 */
 	int	(*set_maxframe)(struct ppe_device *ppe_dev, int port,
 				int maxframe_size);
 };
-- 
2.42.0


