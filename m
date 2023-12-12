Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD4380EADD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346407AbjLLLwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346385AbjLLLw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:52:29 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54928ED;
        Tue, 12 Dec 2023 03:52:35 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BCA5ZZv017172;
        Tue, 12 Dec 2023 11:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        qcppdkim1; bh=m4nJgTCxtS3Z9eeaD6Mti1C/kz7EN1wZJ9K0j7cQ9OA=; b=C0
        4ubFVQiIVMyBlZs64Sof7NmLPe7wsBAYCNBiU49F1KBV+AKv6JrGcoaVYi26KfhX
        wu/e7vbAGKHc7v0kRTjE2VYXysHAokN/xaXtLIYFOl9qGiRgXcSBA9ThCLoLeuRp
        SV4azCQQfeNjCNvenJ3Hi9KJ9qNPlvQE5Hk04AVKP24S1ijd7MVsdO3Wm1Rby7uw
        sVs9b4xge4/rRgmGPaXxYq4Ten6UavrmPemvbxtkcAZG8B5fu7ORxoUWwPxx8fTr
        XWdriJOS5KtEcRZgTNRQ2zp1xQKLxnk0ZcegMLHIpY7nNS7H1e0t8KAHgabSXaa2
        OvbvsnzqX5IMeQC+EDXA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uxnf706vw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 11:52:25 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BCBqOQw017127
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 11:52:24 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 12 Dec 2023 03:52:18 -0800
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
        <linux@armlinux.org.uk>, <robert.marko@sartura.hr>
CC:     <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
Subject: [PATCH v2 3/5] net: mdio: ipq4019: configure CMN PLL clock for ipq5332
Date:   Tue, 12 Dec 2023 19:51:48 +0800
Message-ID: <20231212115151.20016-4-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231212115151.20016-1-quic_luoj@quicinc.com>
References: <20231212115151.20016-1-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hUbbc-LDvDjm3DVwlOECWuGjlKuy36_8
X-Proofpoint-GUID: hUbbc-LDvDjm3DVwlOECWuGjlKuy36_8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 spamscore=0 phishscore=0 clxscore=1015 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312120095
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reference clock of CMN PLL block is selectable, the internal
48MHZ is used by default.

The output clock of CMN PLL block is for providing the clock
source of ethernet device(such as qca8084), there are 1 * 25MHZ
and 3 * 50MHZ output clocks available for the ethernet devices.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/mdio/mdio-ipq4019.c | 137 +++++++++++++++++++++++++++++++-
 1 file changed, 136 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-ipq4019.c b/drivers/net/mdio/mdio-ipq4019.c
index 582e41ab0990..8d3c6bae379f 100644
--- a/drivers/net/mdio/mdio-ipq4019.c
+++ b/drivers/net/mdio/mdio-ipq4019.c
@@ -44,6 +44,25 @@
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
+#define CMN_REFCLK_INTERNAL_48MHZ		0
+#define CMN_REFCLK_EXTERNAL_25MHZ		1
+#define CMN_REFCLK_EXTERNAL_31250KHZ		2
+#define CMN_REFCLK_EXTERNAL_40MHZ		3
+#define CMN_REFCLK_EXTERNAL_48MHZ		4
+#define CMN_REFCLK_EXTERNAL_50MHZ		5
+#define CMN_REFCLK_INTERNAL_96MHZ		6
+
 enum mdio_clk_id {
 	MDIO_CLK_MDIO_AHB,
 	MDIO_CLK_UNIPHY0_AHB,
@@ -55,6 +74,7 @@ enum mdio_clk_id {
 
 struct ipq4019_mdio_data {
 	void __iomem *membase;
+	void __iomem *cmn_membase;
 	void __iomem *eth_ldo_rdy[ETH_LDO_RDY_CNT];
 	struct clk *clk[MDIO_CLK_CNT];
 };
@@ -227,12 +247,116 @@ static int ipq4019_mdio_write_c22(struct mii_bus *bus, int mii_id, int regnum,
 	return 0;
 }
 
+/* For the CMN PLL block, the reference clock can be configured according to
+ * the device tree property "cmn-reference-clock", the internal 48MHZ is used
+ * by default on the ipq533 platform.
+ *
+ * The output clock of CMN PLL block is provided to the ethernet devices,
+ * threre are 4 CMN PLL output clocks (1*25MHZ + 3*50MHZ) enabled by default.
+ *
+ * Such as the output 50M clock for the qca8084 ethernet PHY.
+ */
+static int ipq_cmn_clock_config(struct mii_bus *bus)
+{
+	int ret;
+	u32 reg_val, src_sel, ref_clk;
+	struct ipq4019_mdio_data *priv;
+
+	priv = bus->priv;
+	if (priv->cmn_membase) {
+		reg_val = readl(priv->cmn_membase + CMN_PLL_REFERENCE_CLOCK);
+
+		/* Select reference clock source */
+		ret = of_property_read_u32(bus->parent->of_node,
+					   "cmn-reference-clock",
+					   &ref_clk);
+		if (!ret) {
+			switch (ref_clk) {
+			case CMN_REFCLK_INTERNAL_48MHZ:
+				reg_val &= ~(CMN_PLL_REFCLK_EXTERNAL |
+					     CMN_PLL_REFCLK_INDEX);
+				reg_val |= FIELD_PREP(CMN_PLL_REFCLK_INDEX, 7);
+				break;
+			case CMN_REFCLK_EXTERNAL_25MHZ:
+				reg_val &= ~(CMN_PLL_REFCLK_EXTERNAL |
+					     CMN_PLL_REFCLK_INDEX);
+				reg_val |= (CMN_PLL_REFCLK_EXTERNAL |
+					    FIELD_PREP(CMN_PLL_REFCLK_INDEX, 3));
+				break;
+			case CMN_REFCLK_EXTERNAL_31250KHZ:
+				reg_val &= ~(CMN_PLL_REFCLK_EXTERNAL |
+					     CMN_PLL_REFCLK_INDEX);
+				reg_val |= (CMN_PLL_REFCLK_EXTERNAL |
+					    FIELD_PREP(CMN_PLL_REFCLK_INDEX, 4));
+				break;
+			case CMN_REFCLK_EXTERNAL_40MHZ:
+				reg_val &= ~(CMN_PLL_REFCLK_EXTERNAL |
+					     CMN_PLL_REFCLK_INDEX);
+				reg_val |= (CMN_PLL_REFCLK_EXTERNAL |
+					    FIELD_PREP(CMN_PLL_REFCLK_INDEX, 6));
+				break;
+			case CMN_REFCLK_EXTERNAL_48MHZ:
+				reg_val &= ~(CMN_PLL_REFCLK_EXTERNAL |
+					     CMN_PLL_REFCLK_INDEX);
+				reg_val |= (CMN_PLL_REFCLK_EXTERNAL |
+					    FIELD_PREP(CMN_PLL_REFCLK_INDEX, 7));
+				break;
+			case CMN_REFCLK_EXTERNAL_50MHZ:
+				reg_val &= ~(CMN_PLL_REFCLK_EXTERNAL |
+					     CMN_PLL_REFCLK_INDEX);
+				reg_val |= (CMN_PLL_REFCLK_EXTERNAL |
+					    FIELD_PREP(CMN_PLL_REFCLK_INDEX, 8));
+				break;
+			case CMN_REFCLK_INTERNAL_96MHZ:
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
+			/* If the cmn-reference-clock is not specified,
+			 * the internal 48MHZ is selected by default.
+			 */
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
 	int ret, index;
 	unsigned long rate;
 
+	ret = ipq_cmn_clock_config(bus);
+	if (ret)
+		return ret;
+
 	/* For the platform ipq5332, there are two SoC uniphies available
 	 * for connecting with ethernet PHY, the SoC uniphy gcc clock
 	 * should be enabled for resetting the connected device such
@@ -296,7 +420,7 @@ static int ipq4019_mdio_probe(struct platform_device *pdev)
 	/* This resource are optional */
 	for (index = 0; index < ETH_LDO_RDY_CNT; index++) {
 		res = platform_get_resource(pdev, IORESOURCE_MEM, index + 1);
-		if (res) {
+		if (res && strcmp(res->name, "cmn_blk")) {
 			priv->eth_ldo_rdy[index] = devm_ioremap(&pdev->dev,
 								res->start,
 								resource_size(res));
@@ -317,6 +441,17 @@ static int ipq4019_mdio_probe(struct platform_device *pdev)
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

