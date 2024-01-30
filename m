Return-Path: <linux-kernel+bounces-44476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8298422CD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D57DBB2D914
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCE56D1C7;
	Tue, 30 Jan 2024 11:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OWRMTAsW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EF96BB45;
	Tue, 30 Jan 2024 11:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613210; cv=none; b=W/Bz7qD9yhXwNmf8NX+welOPR/5cZp3/URhktajXq5mzfq2Xvhs563CmYKW3JeO6Jh3572tswo+c7efIg9/R+0zpxXxQCTiqodMBwOAUXDpgANT+wzpW2Njde48uV97eX6D2dn2Z3PjPApGFhsNNwi1vBl/ZDSpJWYO2LmWbObc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613210; c=relaxed/simple;
	bh=o6+Qv1XSc0r+DjzQ+UN0Go47sR7OYXlbbTVApQEvHdM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Q4QkmwUpZGsvYy1bfD3H6sST4Denh/f9trtqVULb4OK56ZNEtwLLRliHAhItmgVk5/ucnph37AiaP6mmD5Nn4S05Oc7kPOY2q4YKmBoT8N3Wu15IjXtBCU1uUHcAUNrcPnmttkG1ugxau6E8T03VgFNrov2zfbJv2F8AISAGi+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OWRMTAsW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U9Subu021047;
	Tue, 30 Jan 2024 11:12:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=c1BeU21acqQL
	zZJuqF68xS9O05SDPWdTDcRcFxY/38g=; b=OWRMTAsWnkKImj/9LnuWiTySySXF
	uXk2g82g+Myo6CihJAEdo3c67Zi2KFwoffH9nIndKVJeZqnUy0wK2+FY9HszOorf
	waOXBfilSLLAN0LTf3vprUbTPfNlq5sAp+ZtrtUrB5NeJFmRsL/l7IIrzwshBpWq
	2xnenLJ5peM/IimVZT0Ni/1YnyNraEdCE3kDTf0iABJLOSduMHBQ80OqBzr5DaD8
	VklyHcJeN7UbPehh9s4XAS5W5Fyc68J2pU8plAqd0KAyVc3UrpiBRK6hO7rP3BLq
	6+uTLoEPzkBW+8VM+rsVnAEFYcv5iSqzXP6uuggGbv9pKnK9RB0ruw8/gQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxupk8jhf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 11:12:42 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 40UBCdSF021685;
	Tue, 30 Jan 2024 11:12:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3vvtwkst75-1;
	Tue, 30 Jan 2024 11:12:39 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40UBCdhL021680;
	Tue, 30 Jan 2024 11:12:39 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-snehshah-hyd.qualcomm.com [10.147.246.35])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 40UBCcOD021676;
	Tue, 30 Jan 2024 11:12:39 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2319345)
	id 72D145013A3; Tue, 30 Jan 2024 16:42:37 +0530 (+0530)
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Sneh Shah <quic_snehshah@quicinc.com>, kernel@quicinc.com,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH net-next v3] net: stmmac: dwmac-qcom-ethqos: Add support for 2.5G SGMII
Date: Tue, 30 Jan 2024 16:42:34 +0530
Message-Id: <20240130111234.1244-1-quic_snehshah@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 51Ok5m-SS5P1ZlilOA2gsYNrEpR3IESr
X-Proofpoint-ORIG-GUID: 51Ok5m-SS5P1ZlilOA2gsYNrEpR3IESr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_05,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401190000 definitions=main-2401300082
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Serdes phy needs to operate at 2500 mode for 2.5G speed and 1000
mode for 1G/100M/10M speed.
Added changes to configure serdes phy and mac based on link speed.
Changing serdes phy speed involves multiple register writes for
serdes block. To avoid redundant write opertions only update serdes
phy when new speed is different.

Signed-off-by: Sneh Shah <quic_snehshah@quicinc.com>
---
v3 changelog:
- updated commit message
---
v2 changelog:
- updated stmmac_pcs_ane to support autoneg disable
- Update serdes speed to 1000 for 100M and 10M also
---
 .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 27 +++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_pcs.h  |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 31631e3f89d0..3ead32cd49a4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -106,6 +106,7 @@ struct qcom_ethqos {
 	struct clk *link_clk;
 	struct phy *serdes_phy;
 	unsigned int speed;
+	int serdes_speed;
 	phy_interface_t phy_mode;
 
 	const struct ethqos_emac_por *por;
@@ -608,17 +609,38 @@ static int ethqos_configure_sgmii(struct qcom_ethqos *ethqos)
 {
 	int val;
 
+	struct platform_device *pdev = ethqos->pdev;
+	struct net_device *dev = platform_get_drvdata(pdev);
+	struct stmmac_priv *priv = netdev_priv(dev);
 	val = readl(ethqos->mac_base + MAC_CTRL_REG);
 
 	switch (ethqos->speed) {
+	case SPEED_2500:
+		val &= ~ETHQOS_MAC_CTRL_PORT_SEL;
+		rgmii_updatel(ethqos, RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
+			      RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
+			      RGMII_IO_MACRO_CONFIG2);
+		if (ethqos->serdes_speed != SPEED_2500)
+			phy_set_speed(ethqos->serdes_phy, SPEED_2500);
+		ethqos->serdes_speed = SPEED_2500;
+		stmmac_pcs_ctrl_ane(priv, priv->ioaddr, 0, 0, 0);
+		break;
 	case SPEED_1000:
 		val &= ~ETHQOS_MAC_CTRL_PORT_SEL;
 		rgmii_updatel(ethqos, RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
 			      RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
 			      RGMII_IO_MACRO_CONFIG2);
+		if (ethqos->serdes_speed != SPEED_1000)
+			phy_set_speed(ethqos->serdes_phy, SPEED_1000);
+		ethqos->serdes_speed = SPEED_1000;
+		stmmac_pcs_ctrl_ane(priv, priv->ioaddr, 1, 0, 0);
 		break;
 	case SPEED_100:
 		val |= ETHQOS_MAC_CTRL_PORT_SEL | ETHQOS_MAC_CTRL_SPEED_MODE;
+		if (ethqos->serdes_speed != SPEED_1000)
+			phy_set_speed(ethqos->serdes_phy, SPEED_1000);
+		ethqos->serdes_speed = SPEED_1000;
+		stmmac_pcs_ctrl_ane(priv, priv->ioaddr, 1, 0, 0);
 		break;
 	case SPEED_10:
 		val |= ETHQOS_MAC_CTRL_PORT_SEL;
@@ -627,6 +649,10 @@ static int ethqos_configure_sgmii(struct qcom_ethqos *ethqos)
 			      FIELD_PREP(RGMII_CONFIG_SGMII_CLK_DVDR,
 					 SGMII_10M_RX_CLK_DVDR),
 			      RGMII_IO_MACRO_CONFIG);
+		if (ethqos->serdes_speed != SPEED_1000)
+			phy_set_speed(ethqos->serdes_phy, ethqos->speed);
+		ethqos->serdes_speed = SPEED_1000;
+		stmmac_pcs_ctrl_ane(priv, priv->ioaddr, 1, 0, 0);
 		break;
 	}
 
@@ -799,6 +825,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 				     "Failed to get serdes phy\n");
 
 	ethqos->speed = SPEED_1000;
+	ethqos->serdes_speed = SPEED_1000;
 	ethqos_update_link_clk(ethqos, SPEED_1000);
 	ethqos_set_func_clk_en(ethqos);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
index aefc121464b5..13a30e6df4c1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
@@ -110,6 +110,8 @@ static inline void dwmac_ctrl_ane(void __iomem *ioaddr, u32 reg, bool ane,
 	/* Enable and restart the Auto-Negotiation */
 	if (ane)
 		value |= GMAC_AN_CTRL_ANE | GMAC_AN_CTRL_RAN;
+	else
+		value &= ~GMAC_AN_CTRL_ANE;
 
 	/* In case of MAC-2-MAC connection, block is configured to operate
 	 * according to MAC conf register.
-- 
2.17.1


