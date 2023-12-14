Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88787812C2E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443657AbjLNJuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443649AbjLNJuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:50:05 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194F31BCD;
        Thu, 14 Dec 2023 01:49:39 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE9Q7hb029781;
        Thu, 14 Dec 2023 09:49:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        qcppdkim1; bh=B1iNr8ZoSL+9Nsxcj5DA5N199o4zb2A3hGCzRlJGaGY=; b=pU
        qDr1IAs4uZrFHYTL27NM3OUYM3gyIXR8ZKA3wuNVjZqJr3nUvtYhkoJwiX8v9Y59
        ExADBYObOiIyjQsKfF5AbdWTCUqWSnnD13WphIZzNsHP0oQBWWeXbjwb8S0WAiPq
        Rb49NIkB5cQj1GXZD89bkroAvXIBsb/hO2/1xQPT+h4wqn4r1ZuSmLsEIdc6+D6L
        XraXgJxZ5xgadAB1vQfAc/NsVWrPriw+1on2Tb22DXFOqSFtk1h5WmU8GMAonWlc
        H5NOM5kNYHxff2yYAkTUXlN57dlaVITJ/0Z4AbJz7AsW9dn4UQUTULvnkWzsLxJk
        k27pEMtv54bjjT7Ke1Xg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uyp0p92wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 09:49:26 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BE9nPBq007224
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 09:49:25 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 01:49:21 -0800
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>,
        <p.zabel@pengutronix.de>, <f.fainelli@gmail.com>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v7 13/14] net: phy: at803x: configure qca8084 work mode
Date:   Thu, 14 Dec 2023 17:48:12 +0800
Message-ID: <20231214094813.24690-14-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231214094813.24690-1-quic_luoj@quicinc.com>
References: <20231214094813.24690-1-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JJmBKfLAsNLue1oyIUYX3IljNaKN31xX
X-Proofpoint-GUID: JJmBKfLAsNLue1oyIUYX3IljNaKN31xX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312140065
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 4499d78891d2..6bc80704949a 100644
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
@@ -1231,6 +1238,46 @@ static int qca8084_common_clock_init(struct phy_device *phydev)
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
@@ -1247,7 +1294,11 @@ static int qca8084_probe(struct phy_device *phydev)
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

