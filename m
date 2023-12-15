Return-Path: <linux-kernel+bounces-555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9968142DF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F59BB2282A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168E02DF65;
	Fri, 15 Dec 2023 07:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KHUNE3HD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5752B2DF97;
	Fri, 15 Dec 2023 07:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BF4LTQM022214;
	Fri, 15 Dec 2023 07:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=DpLGnFLCKSY0tJ27ExzgGixGS/RVtKjkJCrVDkkBLJ0=; b=KH
	UNE3HDKcHMRBVSYNiytUTttlTcnvr1j0lUMszAPsr5M11q76LwrA7gOfCJQBu9XC
	93sZx2SGi0NmEHyyAYs1oA+pS3gvcm39S+jAJpVPv84+DTVvU8a4bWNI4UvGl2sd
	IkhDAN1fZBSoN0kpKoBGb4XUQpZM/dNT8cxABG7ZSi8HmxxYPzOApkI7uFpGAgi8
	hjNkIzSkZwnCR7Q3595oI+NMPKzU1nElKmfruMAjmx45SqNaIUIyj+KVtyXzU7sP
	t+NzorRB1pwmAo+LVOdECGJARPMwhHx0BZFqxz8XsHXzF8Sn9qwKoYwuKChZVF3H
	gHpU5fGXSjwoNOwJQK+g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v090u1pbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 07:41:24 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BF7fNtn024955
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 07:41:23 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 23:41:19 -0800
From: Luo Jie <quic_luoj@quicinc.com>
To: <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>,
        <p.zabel@pengutronix.de>, <f.fainelli@gmail.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v8 13/14] net: phy: at803x: configure qca8084 work mode
Date: Fri, 15 Dec 2023 15:40:03 +0800
Message-ID: <20231215074005.26976-14-quic_luoj@quicinc.com>
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
X-Proofpoint-GUID: m2vpYiDdnsP8sPIVRPedSndbDS1d-WoS
X-Proofpoint-ORIG-GUID: m2vpYiDdnsP8sPIVRPedSndbDS1d-WoS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312150047

There are four kind of work modes supported by qca8084.
1. Quad PHYs work on 10g-qxgmii.
2. PHY1, PHY2, PHY3 wors on 10g-qxgmii, PHY4 works on sgmii.
3. Quad PHYs connected with internal MACs by GMII, which works
   on switch mode.
4. PHY1, PHY2, PHY3 connected with internal MACs by GMII, PHY4
   works on sgmii.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/phy/at803x.c | 53 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 3ef4eacf40c7..ac72b0551ed8 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -317,6 +317,13 @@
 #define QCA8084_EPHY_ADDR3_MASK			GENMASK(19, 15)
 #define QCA8084_EPHY_LDO_EN			GENMASK(21, 20)
 
+#define QCA8084_WORK_MODE_CFG			0xc90f030
+#define QCA8084_WORK_MODE_MASK			GENMASK(5, 0)
+#define QCA8084_WORK_MODE_QXGMII		(BIT(5) | GENMASK(3, 0))
+#define QCA8084_WORK_MODE_QXGMII_PORT4_SGMII	(BIT(5) | GENMASK(2, 0))
+#define QCA8084_WORK_MODE_SWITCH		BIT(4)
+#define QCA8084_WORK_MODE_SWITCH_PORT4_SGMII	BIT(5)
+
 MODULE_DESCRIPTION("Qualcomm Atheros AR803x and QCA808X PHY driver");
 MODULE_AUTHOR("Matus Ujhelyi");
 MODULE_LICENSE("GPL");
@@ -1038,6 +1045,46 @@ static int qca8084_common_clock_init(struct phy_device *phydev)
 	return clk_prepare_enable(priv->clk[MDIO_MASTER_AHB_CLK]);
 }
 
+static int qca8084_parse_and_set_work_mode(struct phy_device *phydev)
+{
+	struct device_node *node;
+	struct at803x_priv *priv;
+	u32 value, work_mode;
+	int ret;
+
+	node = phydev->mdio.dev.of_node;
+	priv = phydev->priv;
+
+	/* The property "qcom,phy-work-mode" is only defined in one
+	 * PHY device tree node.
+	 */
+	ret = of_property_read_u32(node, "qcom,phy-work-mode", &value);
+	if (ret)
+		return ret == -EINVAL ? 0 : ret;
+
+	switch (value) {
+	case 0:
+		work_mode = QCA8084_WORK_MODE_QXGMII;
+		break;
+	case 1:
+		work_mode = QCA8084_WORK_MODE_QXGMII_PORT4_SGMII;
+		break;
+	case 2:
+		work_mode = QCA8084_WORK_MODE_SWITCH;
+		break;
+	case 3:
+		work_mode = QCA8084_WORK_MODE_SWITCH_PORT4_SGMII;
+		break;
+	default:
+		phydev_err(phydev, "invalid qcom,phy-work-mode %d\n", value);
+		return -EINVAL;
+	}
+
+	return qca8084_mii_modify(phydev, QCA8084_WORK_MODE_CFG,
+				  QCA8084_WORK_MODE_MASK,
+				  FIELD_PREP(QCA8084_WORK_MODE_MASK, work_mode));
+}
+
 static int qca8084_probe(struct phy_device *phydev)
 {
 	int ret;
@@ -1054,7 +1101,11 @@ static int qca8084_probe(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	return qca8084_common_clock_init(phydev);
+	ret = qca8084_common_clock_init(phydev);
+	if (ret)
+		return ret;
+
+	return qca8084_parse_and_set_work_mode(phydev);
 }
 
 static int at803x_probe(struct phy_device *phydev)
-- 
2.42.0


