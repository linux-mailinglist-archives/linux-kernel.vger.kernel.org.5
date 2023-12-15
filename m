Return-Path: <linux-kernel+bounces-550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6718142CA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AD4BB23060
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58BE2555B;
	Fri, 15 Dec 2023 07:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LGYpKm3L"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809DF15AD2;
	Fri, 15 Dec 2023 07:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BF6CUGu014168;
	Fri, 15 Dec 2023 07:41:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=RdEmD3F3bi1zawZ4fZPZaXG3kduxBS2lem2ZYGbtznE=; b=LG
	YpKm3LUCpHylDySCpBGuqqGGxA1B/9TO89APpKGqJykpZq17bxxY0eaYr31KgHMi
	kaPM0JP+Z4Gl3XGEuvQdsS4nVQ648yLL8Rzv5nB+pGSd/BMX2eoR7frHrnRS6BjR
	qs4MKb/GCMActx4kj7IsHz0nE/UbNEeL12iddzkhEglT8y2/M0P5hYuCbQvQx9/g
	VnimaVI2ekLTLG/3fQLPCeaRGqlZHMNDoQeX4GVgwW353urXx2hlPPXml2lhiQUN
	0rkzOAyXMIVhDS6OHHCrkf4dHxgqi8m9Mm/uThMNbNKHrsxhpdQCY0eN2kfhYXa4
	6DIv9+jlZvqUy6hCaRqA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0hb0073r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 07:41:07 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BF7f6I1017425
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 07:41:06 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 23:41:02 -0800
From: Luo Jie <quic_luoj@quicinc.com>
To: <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>,
        <p.zabel@pengutronix.de>, <f.fainelli@gmail.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v8 09/14] net: phy: at803x: set MDIO address of qca8084 PHY
Date: Fri, 15 Dec 2023 15:39:59 +0800
Message-ID: <20231215074005.26976-10-quic_luoj@quicinc.com>
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
X-Proofpoint-ORIG-GUID: sr5AobqIUzm8XPFAzPsebmS0KoR_PxX4
X-Proofpoint-GUID: sr5AobqIUzm8XPFAzPsebmS0KoR_PxX4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 spamscore=0 mlxlogscore=999
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312150047

Program the MDIO address of qca8084 PHY and PCS device
in the PHY probe function.

The MDIO address of qca8084 device is configured according
to the property "qcom,phy-addr-fixup" of phy node, which
defines the MDIO address for 4 PHYs and 3 PCSes, each MDIO
address occupies 5 bits in the config register.

The MDIO address of qca8084 should be configured correctly
before doing the clock initialization in the PHY probe function,
so the property "reg" can't be used to configure the MDIO address
of phy device one by one, the clock initialization will be configured
with all 4 PHY devices in one PHY probe function.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/phy/at803x.c | 61 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 4982bde5a8a5..c8830898ce2e 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -303,6 +303,18 @@
 #define QCA8084_HIGH_ADDR_PREFIX		0x18
 #define QCA8084_LOW_ADDR_PREFIX			0x10
 
+#define QCA8084_PCS_CFG				0xc90f014
+#define QCA8084_PCS_ADDR0_MASK			GENMASK(4, 0)
+#define QCA8084_PCS_ADDR1_MASK			GENMASK(9, 5)
+#define QCA8084_PCS_ADDR2_MASK			GENMASK(14, 10)
+
+#define QCA8084_EPHY_CFG			0xc90f018
+#define QCA8084_EPHY_ADDR0_MASK			GENMASK(4, 0)
+#define QCA8084_EPHY_ADDR1_MASK			GENMASK(9, 5)
+#define QCA8084_EPHY_ADDR2_MASK			GENMASK(14, 10)
+#define QCA8084_EPHY_ADDR3_MASK			GENMASK(19, 15)
+#define QCA8084_EPHY_LDO_EN			GENMASK(21, 20)
+
 MODULE_DESCRIPTION("Qualcomm Atheros AR803x and QCA808X PHY driver");
 MODULE_AUTHOR("Matus Ujhelyi");
 MODULE_LICENSE("GPL");
@@ -764,6 +776,51 @@ static int at803x_parse_dt(struct phy_device *phydev)
 	return 0;
 }
 
+static int qca8084_parse_and_set_phyaddr(struct phy_device *phydev)
+{
+	struct device_node *node;
+	u32 addr[7];
+	int ret;
+
+	node = phydev->mdio.dev.of_node;
+
+	/* The property "qcom,phy-addr-fixup" is only defined in one
+	 * PHY device tree node.
+	 */
+	ret = of_property_read_u32_array(node, "qcom,phy-addr-fixup",
+					 addr, ARRAY_SIZE(addr));
+	if (ret)
+		return ret == -EINVAL ? 0 : ret;
+
+	/* There are 4 PHYs and 3 PCSes on qca8084 chip, each device address
+	 * occupies 5 bits of the config register to customize the MDIO address.
+	 */
+	ret = qca8084_mii_modify(phydev, QCA8084_EPHY_CFG,
+				 QCA8084_EPHY_ADDR0_MASK |
+				 QCA8084_EPHY_ADDR1_MASK |
+				 QCA8084_EPHY_ADDR2_MASK |
+				 QCA8084_EPHY_ADDR3_MASK,
+				 FIELD_PREP(QCA8084_EPHY_ADDR0_MASK, addr[0]) |
+				 FIELD_PREP(QCA8084_EPHY_ADDR1_MASK, addr[1]) |
+				 FIELD_PREP(QCA8084_EPHY_ADDR2_MASK, addr[2]) |
+				 FIELD_PREP(QCA8084_EPHY_ADDR3_MASK, addr[3]));
+	if (ret)
+		return ret;
+
+	return qca8084_mii_modify(phydev, QCA8084_PCS_CFG,
+				  QCA8084_PCS_ADDR0_MASK |
+				  QCA8084_PCS_ADDR1_MASK |
+				  QCA8084_PCS_ADDR2_MASK,
+				  FIELD_PREP(QCA8084_PCS_ADDR0_MASK, addr[4]) |
+				  FIELD_PREP(QCA8084_PCS_ADDR1_MASK, addr[5]) |
+				  FIELD_PREP(QCA8084_PCS_ADDR2_MASK, addr[6]));
+}
+
+static int qca8084_probe(struct phy_device *phydev)
+{
+	return qca8084_parse_and_set_phyaddr(phydev);
+}
+
 static int at803x_probe(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
@@ -776,6 +833,9 @@ static int at803x_probe(struct phy_device *phydev)
 
 	phydev->priv = priv;
 
+	if (phydev_id_compare(phydev, QCA8084_PHY_ID))
+		return qca8084_probe(phydev);
+
 	ret = at803x_parse_dt(phydev);
 	if (ret)
 		return ret;
@@ -2510,6 +2570,7 @@ static struct phy_driver at803x_driver[] = {
 	PHY_ID_MATCH_MODEL(QCA8084_PHY_ID),
 	.name			= "Qualcomm QCA8084",
 	.flags			= PHY_POLL_CABLE_TEST,
+	.probe			= at803x_probe,
 	.config_intr		= at803x_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
 	.get_tunable		= at803x_get_tunable,
-- 
2.42.0


