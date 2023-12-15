Return-Path: <linux-kernel+bounces-553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9356E8142D6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48ADC1F225B7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB1F2DB6F;
	Fri, 15 Dec 2023 07:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YDGZ3btr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E609B2D7AA;
	Fri, 15 Dec 2023 07:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BF6Da2u015208;
	Fri, 15 Dec 2023 07:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=YrZo+c4DtXh15qYYe/RRRGILE2qQhvakcQbBlfaMAmg=; b=YD
	GZ3btr7i/H78GlHGu7CWLg+hF0LLAXanz5yBzbzdMj8bNr1diPaKRigUXo11fT3g
	pnwF2j2XlM8ZuHLWhZGxRyK/P4rO31F6TxDZOe/x4mLNBLdaX2H1xZ1VaJUBJb+l
	hQCP6n4FSx6iC1yUfXfJHV9lUqt2B7s7oEa2yUBtQPJ5dUxkcepVrbvFSihFhMY3
	06Gg1JjT38Hh7MxcrVDr2Id5TsFwRGseclE9FVGYjZGY7Nb4kD0cHCUuh4XCyEwf
	6oQeO/4cIVACrUZi8Fw4KcQCUt+RUHbqUuaMtpS1cADVFIY2Nt7EzK4geT83ELkp
	+a/TqxhGEPuBnIFx9CBg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0hb00745-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 07:41:20 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BF7fJZ5022331
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 07:41:19 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 23:41:15 -0800
From: Luo Jie <quic_luoj@quicinc.com>
To: <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>,
        <p.zabel@pengutronix.de>, <f.fainelli@gmail.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v8 12/14] net: phy: at803x: configure qca8084 common clocks
Date: Fri, 15 Dec 2023 15:40:02 +0800
Message-ID: <20231215074005.26976-13-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231215074005.26976-1-quic_luoj@quicinc.com>
References: <20231215074005.26976-1-quic_luoj@quicinc.com>
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
X-Proofpoint-ORIG-GUID: ydnC9ijGTP51n5Tjq2aUS8FJyQTbYZ78
X-Proofpoint-GUID: ydnC9ijGTP51n5Tjq2aUS8FJyQTbYZ78
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 spamscore=0 mlxlogscore=999
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312150047

After initial clock sequence, the clock source 312.5MHZ is
available, the common clocks based on clock source 312.5MHZ
needs to be configured, which includes APB bridge clock tree
with rate 312.5MHZ, AHB clock tree with 104.17MHZ.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/phy/at803x.c | 69 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 9885a728c72a..3ef4eacf40c7 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -340,6 +340,14 @@ static struct at803x_hw_stat qca83xx_hw_stats[] = {
 };
 
 enum {
+	APB_BRIDGE_CLK,
+	AHB_CLK,
+	SEC_CTRL_AHB_CLK,
+	TLMM_CLK,
+	TLMM_AHB_CLK,
+	CNOC_AHB_CLK,
+	MDIO_AHB_CLK,
+	MDIO_MASTER_AHB_CLK,
 	SRDS0_SYS_CLK,
 	SRDS1_SYS_CLK,
 	GEPHY0_SYS_CLK,
@@ -363,6 +371,14 @@ enum {
 };
 
 static const char *const qca8084_clock_name[] = {
+	"apb_bridge",
+	"ahb",
+	"sec_ctrl_ahb",
+	"tlmm",
+	"tlmm_ahb",
+	"cnoc_ahb",
+	"mdio_ahb",
+	"mdio_master_ahb",
 	"srds0_sys",
 	"srds1_sys",
 	"gephy0_sys",
@@ -975,6 +991,53 @@ static int qca8084_clock_config(struct phy_device *phydev)
 	return 0;
 }
 
+static int qca8084_common_clock_init(struct phy_device *phydev)
+{
+	struct at803x_priv *priv;
+	int ret = 0;
+
+	priv = phydev->priv;
+	/* Enable APB bridge tree clock */
+	ret = clk_set_rate(priv->clk[APB_BRIDGE_CLK], 312500000);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(priv->clk[APB_BRIDGE_CLK]);
+	if (ret)
+		return ret;
+
+	/* Enable AHB tree clocks */
+	ret = clk_set_rate(priv->clk[AHB_CLK], 104170000);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(priv->clk[AHB_CLK]);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(priv->clk[SEC_CTRL_AHB_CLK]);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(priv->clk[TLMM_CLK]);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(priv->clk[TLMM_AHB_CLK]);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(priv->clk[CNOC_AHB_CLK]);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(priv->clk[MDIO_AHB_CLK]);
+	if (ret)
+		return ret;
+
+	return clk_prepare_enable(priv->clk[MDIO_MASTER_AHB_CLK]);
+}
+
 static int qca8084_probe(struct phy_device *phydev)
 {
 	int ret;
@@ -987,7 +1050,11 @@ static int qca8084_probe(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	return qca8084_clock_config(phydev);
+	ret = qca8084_clock_config(phydev);
+	if (ret)
+		return ret;
+
+	return qca8084_common_clock_init(phydev);
 }
 
 static int at803x_probe(struct phy_device *phydev)
-- 
2.42.0


