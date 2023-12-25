Return-Path: <linux-kernel+bounces-10957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A3E81DF3F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 09:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8949B1F21EB3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 08:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7A38C12;
	Mon, 25 Dec 2023 08:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R1o5uZ72"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A756CA7A;
	Mon, 25 Dec 2023 08:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BP7A3II019837;
	Mon, 25 Dec 2023 08:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=FFW+RKQFRS3hNZWC4B1zbsHCDFZ2KKuoWG+X51zxpU8=; b=R1
	o5uZ72Yx+TD33LivsZtncTRKRn5FyBJXVyGIiT0gzw8R4wKl9EUGILvXVmN2ETHp
	fLzeWEq9LYzzmI5N4uASSxiEie1MNxkPFgMRNGxn1dOgviazM14LtcSp3rwvBxWK
	UJus/JxXoHy9QxSAFSl8jQ133cEP9zYfriSTLnP3VKg6zVu5SQQ3rOhEkF497N/h
	6dRrhIJtXOHQMPjMCupJKLuoxYKxhb1eYoAaZi+DkE3mmghx/5GF3zixvtwqIFjE
	6+fVhu89C+Uc6c4/trYLwNgq6shNAEAfyOgonXti3L2u/cLzUUOBcDBjAsnUDYzA
	uZ2Riv18yifi6XE1Pw7g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v5mwr3fc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Dec 2023 08:44:47 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BP8ikZI025490
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Dec 2023 08:44:46 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 25 Dec 2023 00:44:41 -0800
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
Subject: [PATCH v4 1/5] net: mdio: ipq4019: move eth_ldo_rdy before MDIO bus register
Date: Mon, 25 Dec 2023 16:44:20 +0800
Message-ID: <20231225084424.30986-2-quic_luoj@quicinc.com>
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
X-Proofpoint-GUID: jg7JjeldXH8xeTi_Hr6Pn8KZS3S8PW8F
X-Proofpoint-ORIG-GUID: jg7JjeldXH8xeTi_Hr6Pn8KZS3S8PW8F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312250066

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


