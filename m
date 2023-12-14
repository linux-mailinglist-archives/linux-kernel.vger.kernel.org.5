Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6530812AFA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbjLNJDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235605AbjLNJDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:03:41 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D156114;
        Thu, 14 Dec 2023 01:03:47 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE4pbdt006907;
        Thu, 14 Dec 2023 09:03:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        qcppdkim1; bh=FFW+RKQFRS3hNZWC4B1zbsHCDFZ2KKuoWG+X51zxpU8=; b=Sp
        /bI2FgMYb0a6OAboQd4RcayNFTvHpzYXVAjj/ksDjszrkAOCK4avd6UvhTFlCmpO
        KNs9CvmRsUt+qAeqLEUvpUb2k5byBH3yzmmkaNTZsxyNIQJQ8aMfqCicP4F9rMO/
        QFQdO75EPaYkn1UnIPSadoxYnI4D17XD6CLAZ91pZ1NITFn7ewnuufPXu3lASU8i
        QbkIDjbPQ04Y1M81OzZwMx7+k2ORAsEIoBi3ieOyshztuwEJ1YbsUA15EPLR70Ke
        R1i8mB4WCqRszg0OMotC0IOqAIaUZsugBIWtEo47iPha0lvfXOlsYZQbjEvcvlXt
        skE430uAgxI1IGUM/nFQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uyq9t0v1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 09:03:30 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BE93Tsc005427
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 09:03:29 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 01:03:24 -0800
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
Subject: [PATCH v3 1/5] net: mdio: ipq4019: move eth_ldo_rdy before MDIO bus register
Date:   Thu, 14 Dec 2023 17:03:00 +0800
Message-ID: <20231214090304.16884-2-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231214090304.16884-1-quic_luoj@quicinc.com>
References: <20231214090304.16884-1-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xtu0ot2WrfsMo5KY90KYO2yt00yo2Ppp
X-Proofpoint-GUID: xtu0ot2WrfsMo5KY90KYO2yt00yo2Ppp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312140058
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ethernet LDO provides the clock for the ethernet PHY that
is connected with PCS, each LDO enables the clock output to
each PCS, after the clock output enablement, the PHY GPIO reset
can take effect.

For the PHY taking the MDIO bus level GPIO reset, the ethernet
LDO should be enabled before the MDIO bus register.

For example, the qca8084 PHY takes the MDIO bus level GPIO
reset for quad PHYs, there is another reason for qca8084 PHY
using MDIO bus level GPIO reset instead of PHY level GPIO
reset as below.

The work sequence of qca8084:
1. enable ethernet LDO.
2. GPIO reset on quad PHYs.
3. register clock provider based on MDIO device of qca8084.
4. PHY probe function called for initializing common clocks.
5. PHY capabilities acquirement.

If qca8084 takes PHY level GPIO reset in the step 4, the clock
provider of qca8084 can't be registered correctly, since the
clock parent(reading the current qca8084 hardware registers in
step 3) of the registered clocks is deserted after GPIO reset.

There are two PCS(UNIPHY) supported in SOC side on ipq5332,
and three PCS(UNIPHY) supported on ipq9574.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/mdio/mdio-ipq4019.c | 51 +++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/net/mdio/mdio-ipq4019.c b/drivers/net/mdio/mdio-ipq4019.c
index abd8b508ec16..5273864fabb3 100644
--- a/drivers/net/mdio/mdio-ipq4019.c
+++ b/drivers/net/mdio/mdio-ipq4019.c
@@ -37,9 +37,12 @@
 
 #define IPQ_PHY_SET_DELAY_US	100000
 
+/* Maximum SOC PCS(uniphy) number on IPQ platform */
+#define ETH_LDO_RDY_CNT				3
+
 struct ipq4019_mdio_data {
-	void __iomem	*membase;
-	void __iomem *eth_ldo_rdy;
+	void __iomem *membase;
+	void __iomem *eth_ldo_rdy[ETH_LDO_RDY_CNT];
 	struct clk *mdio_clk;
 };
 
@@ -206,19 +209,8 @@ static int ipq4019_mdio_write_c22(struct mii_bus *bus, int mii_id, int regnum,
 static int ipq_mdio_reset(struct mii_bus *bus)
 {
 	struct ipq4019_mdio_data *priv = bus->priv;
-	u32 val;
 	int ret;
 
-	/* To indicate CMN_PLL that ethernet_ldo has been ready if platform resource 1
-	 * is specified in the device tree.
-	 */
-	if (priv->eth_ldo_rdy) {
-		val = readl(priv->eth_ldo_rdy);
-		val |= BIT(0);
-		writel(val, priv->eth_ldo_rdy);
-		fsleep(IPQ_PHY_SET_DELAY_US);
-	}
-
 	/* Configure MDIO clock source frequency if clock is specified in the device tree */
 	ret = clk_set_rate(priv->mdio_clk, IPQ_MDIO_CLK_RATE);
 	if (ret)
@@ -236,7 +228,7 @@ static int ipq4019_mdio_probe(struct platform_device *pdev)
 	struct ipq4019_mdio_data *priv;
 	struct mii_bus *bus;
 	struct resource *res;
-	int ret;
+	int ret, index;
 
 	bus = devm_mdiobus_alloc_size(&pdev->dev, sizeof(*priv));
 	if (!bus)
@@ -252,11 +244,32 @@ static int ipq4019_mdio_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->mdio_clk))
 		return PTR_ERR(priv->mdio_clk);
 
-	/* The platform resource is provided on the chipset IPQ5018 */
-	/* This resource is optional */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (res)
-		priv->eth_ldo_rdy = devm_ioremap_resource(&pdev->dev, res);
+	/* These platform resources are provided on the chipset IPQ5018 or
+	 * IPQ5332.
+	 */
+	/* This resource are optional */
+	for (index = 0; index < ETH_LDO_RDY_CNT; index++) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, index + 1);
+		if (res) {
+			priv->eth_ldo_rdy[index] = devm_ioremap(&pdev->dev,
+								res->start,
+								resource_size(res));
+
+			/* The ethernet LDO enable is necessary to reset PHY
+			 * by GPIO, some PHY(such as qca8084) GPIO reset uses
+			 * the MDIO level reset, so this function should be
+			 * called before the MDIO bus register.
+			 */
+			if (priv->eth_ldo_rdy[index]) {
+				u32 val;
+
+				val = readl(priv->eth_ldo_rdy[index]);
+				val |= BIT(0);
+				writel(val, priv->eth_ldo_rdy[index]);
+				fsleep(IPQ_PHY_SET_DELAY_US);
+			}
+		}
+	}
 
 	bus->name = "ipq4019_mdio";
 	bus->read = ipq4019_mdio_read_c22;
-- 
2.42.0

