Return-Path: <linux-kernel+bounces-10959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F7881DF47
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 09:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27202281B1E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 08:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C58C10A02;
	Mon, 25 Dec 2023 08:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XtG1c2gY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B438185A;
	Mon, 25 Dec 2023 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BP6n4X5002523;
	Mon, 25 Dec 2023 08:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=XRiz7Dj2lwKbsNvmLwEtwS/An8GjKcSc1OuBpac68TE=; b=Xt
	G1c2gYSkeP9y2ycV+bFkFB5DT3NpWtiqIYUPQhvO8Kw4HKjgflztyKKnbNu0pT6+
	Xvsq81eTK7Hu7B5+1fonOIPsBEsu7VLbGejTKm+yClWaNvIGPKOSB4qgPdOZpW3N
	Yy5RS+4Z/XgIv1TlDBpCpSaFlGt5rV+0prRnQ9VDQ6SZVbm2V/MPfwHVZu/Im3pT
	j0TwwJ14VKnVqfMG6q4J6+BaWToaB63zpYB1l+FqcJ3M2+8v5Vf0iO4OOGVPdR8Z
	M0gxhuIG3NLPormfmbtcT/i4p7qcHVGPeVrmqcdYghACe/32EK5uHBWUCfWW+zUq
	CRaK4gy4dav03mzZdpcA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v5qs5k9gy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Dec 2023 08:44:56 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BP8it5A025535
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Dec 2023 08:44:55 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 25 Dec 2023 00:44:50 -0800
From: Luo Jie <quic_luoj@quicinc.com>
To: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <robert.marko@sartura.hr>
CC: <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
Subject: [PATCH v4 3/5] net: mdio: ipq4019: configure CMN PLL clock for ipq5332
Date: Mon, 25 Dec 2023 16:44:22 +0800
Message-ID: <20231225084424.30986-4-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231225084424.30986-1-quic_luoj@quicinc.com>
References: <20231225084424.30986-1-quic_luoj@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Btyxz-feKik-IrlyUuEczTzCqHcLPh4a
X-Proofpoint-GUID: Btyxz-feKik-IrlyUuEczTzCqHcLPh4a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312250066

The reference clock of CMN PLL block is selectable, the internal
48MHZ is used by default.

The output clock of CMN PLL block is for providing the clock
source of ethernet device(such as qca8084), there are 1 * 25MHZ
and 3 * 50MHZ output clocks available for the ethernet devices.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/mdio/mdio-ipq4019.c | 129 +++++++++++++++++++++++++++++++-
 1 file changed, 128 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-ipq4019.c b/drivers/net/mdio/mdio-ipq4019.c
index e24b0e688b10..e4862ac02026 100644
--- a/drivers/net/mdio/mdio-ipq4019.c
+++ b/drivers/net/mdio/mdio-ipq4019.c
@@ -44,6 +44,17 @@
 /* Maximum SOC PCS(uniphy) number on IPQ platform */
 #define ETH_LDO_RDY_CNT				3
 
+#define CMN_PLL_REFERENCE_SOURCE_SEL		0x28
+#define CMN_PLL_REFCLK_SOURCE_DIV		GENMASK(9, 8)
+
+#define CMN_PLL_REFERENCE_CLOCK			0x784
+#define CMN_PLL_REFCLK_EXTERNAL			BIT(9)
+#define CMN_PLL_REFCLK_DIV			GENMASK(8, 4)
+#define CMN_PLL_REFCLK_INDEX			GENMASK(3, 0)
+
+#define CMN_PLL_POWER_ON_AND_RESET		0x780
+#define CMN_ANA_EN_SW_RSTN			BIT(6)
+
 enum mdio_clk_id {
 	MDIO_CLK_MDIO_AHB,
 	MDIO_CLK_UNIPHY0_AHB,
@@ -55,6 +66,7 @@ enum mdio_clk_id {
 
 struct ipq4019_mdio_data {
 	void __iomem *membase;
+	void __iomem *cmn_membase;
 	void __iomem *eth_ldo_rdy[ETH_LDO_RDY_CNT];
 	struct clk *clk[MDIO_CLK_CNT];
 };
@@ -227,12 +239,116 @@ static int ipq4019_mdio_write_c22(struct mii_bus *bus, int mii_id, int regnum,
 	return 0;
 }
 
+/* For the CMN PLL block, the reference clock can be configured according to
+ * the device tree property "qcom,cmn-ref-clock-frequency", the internal 48MHZ
+ * is used by default.
+ *
+ * The output clock of CMN PLL block is provided to the ethernet devices,
+ * threre are 4 CMN PLL output clocks (1*25MHZ + 3*50MHZ) enabled by default.
+ *
+ * Such as the output 50M clock for the qca8084 ethernet PHY.
+ */
+static int ipq_cmn_clock_config(struct mii_bus *bus)
+{
+	struct ipq4019_mdio_data *priv;
+	u32 reg_val, src_sel, ref_clk;
+	int ret;
+
+	priv = bus->priv;
+	if (priv->cmn_membase) {
+		reg_val = readl(priv->cmn_membase + CMN_PLL_REFERENCE_CLOCK);
+
+		/* Select reference clock source of CMN PLL block, which can
+		 * be from wifi module or the external xtal.
+		 *
+		 * If absent, the wifi internal 48MHz is used as the reference
+		 * clock source of CMN PLL block, if the 48MHZ is specified,
+		 * which means the xtal 48MHZ is selected.
+		 */
+		ret = of_property_read_u32(bus->parent->of_node,
+					   "qcom,cmn-ref-clock-frequency",
+					   &ref_clk);
+		if (!ret) {
+			switch (ref_clk) {
+			case 25000000:
+				reg_val &= ~(CMN_PLL_REFCLK_EXTERNAL |
+					     CMN_PLL_REFCLK_INDEX);
+				reg_val |= (CMN_PLL_REFCLK_EXTERNAL |
+					    FIELD_PREP(CMN_PLL_REFCLK_INDEX, 3));
+				break;
+			case 31250000:
+				reg_val &= ~(CMN_PLL_REFCLK_EXTERNAL |
+					     CMN_PLL_REFCLK_INDEX);
+				reg_val |= (CMN_PLL_REFCLK_EXTERNAL |
+					    FIELD_PREP(CMN_PLL_REFCLK_INDEX, 4));
+				break;
+			case 40000000:
+				reg_val &= ~(CMN_PLL_REFCLK_EXTERNAL |
+					     CMN_PLL_REFCLK_INDEX);
+				reg_val |= (CMN_PLL_REFCLK_EXTERNAL |
+					    FIELD_PREP(CMN_PLL_REFCLK_INDEX, 6));
+				break;
+			case 48000000:
+				reg_val &= ~(CMN_PLL_REFCLK_EXTERNAL |
+					     CMN_PLL_REFCLK_INDEX);
+				reg_val |= (CMN_PLL_REFCLK_EXTERNAL |
+					    FIELD_PREP(CMN_PLL_REFCLK_INDEX, 7));
+				break;
+			case 50000000:
+				reg_val &= ~(CMN_PLL_REFCLK_EXTERNAL |
+					     CMN_PLL_REFCLK_INDEX);
+				reg_val |= (CMN_PLL_REFCLK_EXTERNAL |
+					    FIELD_PREP(CMN_PLL_REFCLK_INDEX, 8));
+				break;
+			case 96000000:
+				src_sel = readl(priv->cmn_membase +
+						CMN_PLL_REFERENCE_SOURCE_SEL);
+				src_sel &= ~CMN_PLL_REFCLK_SOURCE_DIV;
+				src_sel |= FIELD_PREP(CMN_PLL_REFCLK_SOURCE_DIV, 0);
+				writel(src_sel, priv->cmn_membase +
+				       CMN_PLL_REFERENCE_SOURCE_SEL);
+
+				reg_val &= ~CMN_PLL_REFCLK_DIV;
+				reg_val |= FIELD_PREP(CMN_PLL_REFCLK_DIV, 2);
+				break;
+			default:
+				return -EINVAL;
+			}
+		} else if (ret == -EINVAL) {
+			/* the internal 48MHZ is selected by default. */
+			reg_val &= ~(CMN_PLL_REFCLK_EXTERNAL | CMN_PLL_REFCLK_INDEX);
+			reg_val |= FIELD_PREP(CMN_PLL_REFCLK_INDEX, 7);
+		} else {
+			return ret;
+		}
+
+		writel(reg_val, priv->cmn_membase + CMN_PLL_REFERENCE_CLOCK);
+
+		/* assert CMN PLL */
+		reg_val = readl(priv->cmn_membase + CMN_PLL_POWER_ON_AND_RESET);
+		reg_val &= ~CMN_ANA_EN_SW_RSTN;
+		writel(reg_val, priv->cmn_membase);
+		fsleep(IPQ_PHY_SET_DELAY_US);
+
+		/* deassert CMN PLL */
+		reg_val |= CMN_ANA_EN_SW_RSTN;
+		writel(reg_val, priv->cmn_membase + CMN_PLL_POWER_ON_AND_RESET);
+		fsleep(IPQ_PHY_SET_DELAY_US);
+	}
+
+	return 0;
+}
+
 static int ipq_mdio_reset(struct mii_bus *bus)
 {
 	struct ipq4019_mdio_data *priv = bus->priv;
 	unsigned long rate;
 	int ret, index;
 
+	ret = ipq_cmn_clock_config(bus);
+	if (ret)
+		return ret;
+
 	/* For the platform ipq5332, there are two SoC uniphies available
 	 * for connecting with ethernet PHY, the SoC uniphy gcc clock
 	 * should be enabled for resetting the connected device such
@@ -296,7 +412,7 @@ static int ipq4019_mdio_probe(struct platform_device *pdev)
 	/* This resource are optional */
 	for (index = 0; index < ETH_LDO_RDY_CNT; index++) {
 		res = platform_get_resource(pdev, IORESOURCE_MEM, index + 1);
-		if (res) {
+		if (res && strcmp(res->name, "cmn_blk")) {
 			priv->eth_ldo_rdy[index] = devm_ioremap(&pdev->dev,
 								res->start,
 								resource_size(res));
@@ -317,6 +433,17 @@ static int ipq4019_mdio_probe(struct platform_device *pdev)
 		}
 	}
 
+	/* The CMN block resource is for providing clock source to ethernet,
+	 * which can be optionally configured on the platform ipq9574 and
+	 * ipq5332.
+	 */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cmn_blk");
+	if (res) {
+		priv->cmn_membase = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(priv->cmn_membase))
+			return PTR_ERR(priv->cmn_membase);
+	}
+
 	for (index = 0; index < MDIO_CLK_CNT; index++) {
 		priv->clk[index] = devm_clk_get_optional(&pdev->dev,
 							 mdio_clk_name[index]);
-- 
2.42.0


