Return-Path: <linux-kernel+bounces-3081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CE8816722
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C551F213C1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C826179F7;
	Mon, 18 Dec 2023 07:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gO4kYuKu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC2F1FB2;
	Mon, 18 Dec 2023 07:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BI6W2th032313;
	Mon, 18 Dec 2023 07:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=V3p1JFE4C6ua
	8k53+rwVOsLfLC5EdBhsrQCkXO9H+28=; b=gO4kYuKujzcT8NP7HPlW1SoJGLXV
	fY/lcdE3Jq65e0NtDOh7zqKB7ZRcKU3coLW4fQ9R2srjwKCcRlQim8MaZn095+/f
	3pNUP+TNFRkGGg7Y0+gcw262YMTCoSTX/AdwphqLGlaYx3614qRHNqb+Mm9xDKDr
	ULNIS97+q7eXM1TuN5Y2430/7PBqUw6VXVHxL1+1ZVXeMvWB8bhjgYH5UJEaDl4x
	wuVDE+XN2HpRQNQYwRPPhk7ZqT2ADxQYF+StnMW7TLwXfzCLD9ZsAzFdPf6rctr9
	JwFXHtcZjel4nqOuXV0eLaf8X0RzXjci9/ILR0cT0UfZ9+Ms4ronnLrLVg==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2gw0r2gu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 07:11:24 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BI7BLno004919;
	Mon, 18 Dec 2023 07:11:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3v14ykxp2e-1;
	Mon, 18 Dec 2023 07:11:21 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BI7BLPF004913;
	Mon, 18 Dec 2023 07:11:21 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-snehshah-hyd.qualcomm.com [10.147.246.35])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3BI7BKnM004911;
	Mon, 18 Dec 2023 07:11:21 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2319345)
	id 9CACB5001DB; Mon, 18 Dec 2023 12:41:19 +0530 (+0530)
From: Sneh Shah <quic_snehshah@quicinc.com>
To: Vinod Koul <vkoul@kernel.org>, Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Halaney <ahalaney@redhat.com>
Cc: Sneh Shah <quic_snehshah@quicinc.com>, kernel@quicinc.com
Subject: [PATCH net-next] net: stmmac: dwmac-qcom-ethqos: Add support for 2.5G SGMII
Date: Mon, 18 Dec 2023 12:41:18 +0530
Message-Id: <20231218071118.21879-1-quic_snehshah@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oXJQX_IlBXkALNAjyU-vo8QDVoD6Vehy
X-Proofpoint-ORIG-GUID: oXJQX_IlBXkALNAjyU-vo8QDVoD6Vehy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180049
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Serdes phy needs to operate at 2500 mode for 2.5G speed and 1000
mode for 1G/100M/10M speed.
Added changes to configure serdes phy and mac based on link speed.

Signed-off-by: Sneh Shah <quic_snehshah@quicinc.com>
---
 .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 31 +++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index d3bf42d0fceb..b3a28dc19161 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -21,6 +21,7 @@
 #define RGMII_IO_MACRO_CONFIG2		0x1C
 #define RGMII_IO_MACRO_DEBUG1		0x20
 #define EMAC_SYSTEM_LOW_POWER_DEBUG	0x28
+#define ETHQOS_MAC_AN_CTRL		0xE0
 
 /* RGMII_IO_MACRO_CONFIG fields */
 #define RGMII_CONFIG_FUNC_CLK_EN		BIT(30)
@@ -78,6 +79,10 @@
 #define ETHQOS_MAC_CTRL_SPEED_MODE		BIT(14)
 #define ETHQOS_MAC_CTRL_PORT_SEL		BIT(15)
 
+/*ETHQOS_MAC_AN_CTRL bits */
+#define ETHQOS_MAC_AN_CTRL_RAN			BIT(9)
+#define ETHQOS_MAC_AN_CTRL_ANE			BIT(12)
+
 struct ethqos_emac_por {
 	unsigned int offset;
 	unsigned int value;
@@ -109,6 +114,7 @@ struct qcom_ethqos {
 	unsigned int num_por;
 	bool rgmii_config_loopback_en;
 	bool has_emac_ge_3;
+	unsigned int serdes_speed;
 };
 
 static int rgmii_readl(struct qcom_ethqos *ethqos, unsigned int offset)
@@ -600,27 +606,47 @@ static int ethqos_configure_rgmii(struct qcom_ethqos *ethqos)
 
 static int ethqos_configure_sgmii(struct qcom_ethqos *ethqos)
 {
-	int val;
-
+	int val, mac_an_value;
 	val = readl(ethqos->mac_base + MAC_CTRL_REG);
+	mac_an_value = readl(ethqos->mac_base + ETHQOS_MAC_AN_CTRL);
 
 	switch (ethqos->speed) {
+	case SPEED_2500:
+		val &= ~ETHQOS_MAC_CTRL_PORT_SEL;
+		rgmii_updatel(ethqos, RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
+			      RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
+			      RGMII_IO_MACRO_CONFIG2);
+		if (ethqos->serdes_speed != SPEED_2500)
+			phy_set_speed(ethqos->serdes_phy, ethqos->speed);
+		mac_an_value &= ~ETHQOS_MAC_AN_CTRL_ANE;
+		break;
 	case SPEED_1000:
 		val &= ~ETHQOS_MAC_CTRL_PORT_SEL;
 		rgmii_updatel(ethqos, RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
 			      RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
 			      RGMII_IO_MACRO_CONFIG2);
+		if (ethqos->serdes_speed != SPEED_1000)
+			phy_set_speed(ethqos->serdes_phy, ethqos->speed);
+		mac_an_value |= ETHQOS_MAC_AN_CTRL_RAN | ETHQOS_MAC_AN_CTRL_ANE;
 		break;
 	case SPEED_100:
 		val |= ETHQOS_MAC_CTRL_PORT_SEL | ETHQOS_MAC_CTRL_SPEED_MODE;
+		if (ethqos->serdes_speed != SPEED_1000)
+			phy_set_speed(ethqos->serdes_phy, ethqos->speed);
+		mac_an_value |= ETHQOS_MAC_AN_CTRL_RAN | ETHQOS_MAC_AN_CTRL_ANE;
 		break;
 	case SPEED_10:
 		val |= ETHQOS_MAC_CTRL_PORT_SEL;
 		val &= ~ETHQOS_MAC_CTRL_SPEED_MODE;
+		if (ethqos->serdes_speed != SPEED_1000)
+			phy_set_speed(ethqos->serdes_phy, ethqos->speed);
+		mac_an_value |= ETHQOS_MAC_AN_CTRL_RAN | ETHQOS_MAC_AN_CTRL_ANE;
 		break;
 	}
 
 	writel(val, ethqos->mac_base + MAC_CTRL_REG);
+	writel(mac_an_value, ethqos->mac_base + ETHQOS_MAC_AN_CTRL);
+	ethqos->serdes_speed = ethqos->speed;
 
 	return val;
 }
@@ -789,6 +815,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 				     "Failed to get serdes phy\n");
 
 	ethqos->speed = SPEED_1000;
+	ethqos->serdes_speed = SPEED_1000;
 	ethqos_update_link_clk(ethqos, SPEED_1000);
 	ethqos_set_func_clk_en(ethqos);
 
-- 
2.17.1


