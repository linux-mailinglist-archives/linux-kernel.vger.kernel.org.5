Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE44812C09
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443541AbjLNJsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443532AbjLNJsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:48:51 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B335118;
        Thu, 14 Dec 2023 01:48:55 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE5d0lK018068;
        Thu, 14 Dec 2023 09:48:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        qcppdkim1; bh=gZ/G1pFW0dLa+8o+dWcun5klmauXu0uQjqsi4LtQX7Q=; b=Sj
        o6Lk4rsYuaoUSPimAUc94NrhgZqDwq+IEaFD3OG49W3DoEetkpMHS6Q1hMZCouaS
        aEc3fCd5RgI1XCop9qS1rRnRMXkRvtL9vr1MRJlijnKBo6JVl8ZMgcBn6H3E5UZ/
        ZZb3/X7uLgaOlwjpIXhMFl5iEWlUZyBTOldodMW4dWXOmKHHOD448TDcAMAoJyYm
        sAmC/0Taf9FPJcaOWVa7WfitsstVbN0HCRWcqE89T1vxFeFQ8PVMoHa02Cd8UoTx
        DsFA4w8RBmu8/9gwhjO8OQ+ZI4Tf/WwDeLU9otxE8MBhKqKTgseTX+6SMuEdhUX4
        af2sFsa0QoUl9I3uCL2Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uynre130q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 09:48:41 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BE9me0E008508
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 09:48:40 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 01:48:36 -0800
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>,
        <p.zabel@pengutronix.de>, <f.fainelli@gmail.com>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v7 03/14] net: phy: at803x: add QCA8084 ethernet phy support
Date:   Thu, 14 Dec 2023 17:48:02 +0800
Message-ID: <20231214094813.24690-4-quic_luoj@quicinc.com>
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
X-Proofpoint-ORIG-GUID: RhP1EfKtgo2pdt8Zq9Sf4r5t1XhGbXFR
X-Proofpoint-GUID: RhP1EfKtgo2pdt8Zq9Sf4r5t1XhGbXFR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=965
 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Add qca8084 PHY support, which is four-port PHY with maximum
link capability 2.5G, the features of each port is almost same
as QCA8081 and slave seed config is not needed.

Three kind of interface modes supported by qca8084.
PHY_INTERFACE_MODE_10G_QXGMII, PHY_INTERFACE_MODE_2500BASEX and
PHY_INTERFACE_MODE_SGMII.

The PCS(serdes) and clock are also needed to be configured to
bringup qca8084 PHY, which will be added in the pcs driver.

The additional CDT configurations used for qca8084.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/phy/at803x.c | 49 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 37fb033e1c29..8dfdf2ff56a5 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -176,6 +176,7 @@
 #define AT8030_PHY_ID_MASK			0xffffffef
 
 #define QCA8081_PHY_ID				0x004dd101
+#define QCA8084_PHY_ID				0x004dd180
 
 #define QCA8327_A_PHY_ID			0x004dd033
 #define QCA8327_B_PHY_ID			0x004dd034
@@ -1760,6 +1761,9 @@ static bool qca808x_is_prefer_master(struct phy_device *phydev)
 
 static bool qca808x_has_fast_retrain_or_slave_seed(struct phy_device *phydev)
 {
+	if (phydev_id_compare(phydev, QCA8084_PHY_ID))
+		return false;
+
 	return linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->supported);
 }
 
@@ -1824,6 +1828,23 @@ static int qca808x_read_status(struct phy_device *phydev)
 		return ret;
 
 	if (phydev->link) {
+		/* There are two PCSs available for QCA8084, which support the
+		 * following interface modes.
+		 *
+		 * 1. PHY_INTERFACE_MODE_10G_QXGMII utilizes PCS1 for all
+		 * available 4 ports, which is for all link speeds.
+		 *
+		 * 2. PHY_INTERFACE_MODE_2500BASEX utilizes PCS0 for the
+		 * fourth port, which is only for the link speed 2500M same
+		 * as QCA8081.
+		 *
+		 * 3. PHY_INTERFACE_MODE_SGMII utilizes PCS0 for the fourth
+		 * port, which is for the link speed 10M, 100M and 1000M same
+		 * as QCA8081.
+		 */
+		if (phydev->interface == PHY_INTERFACE_MODE_10G_QXGMII)
+			return 0;
+
 		if (phydev->speed == SPEED_2500)
 			phydev->interface = PHY_INTERFACE_MODE_2500BASEX;
 		else
@@ -1958,6 +1979,14 @@ static int qca808x_cable_test_start(struct phy_device *phydev)
 	phy_write_mmd(phydev, MDIO_MMD_PCS, 0x807a, 0xc060);
 	phy_write_mmd(phydev, MDIO_MMD_PCS, 0x807e, 0xb060);
 
+	if (phydev_id_compare(phydev, QCA8084_PHY_ID)) {
+		/* Adjust the positive and negative pulse thereshold of CDT */
+		phy_write_mmd(phydev, MDIO_MMD_PCS, 0x8075, 0xa060);
+
+		/* Disable the near echo bypass */
+		phy_modify_mmd(phydev, MDIO_MMD_PCS, 0x807f, BIT(15), 0);
+	}
+
 	return 0;
 }
 
@@ -2227,6 +2256,25 @@ static struct phy_driver at803x_driver[] = {
 	.cable_test_start	= qca808x_cable_test_start,
 	.cable_test_get_status	= qca808x_cable_test_get_status,
 	.link_change_notify	= qca808x_link_change_notify,
+}, {
+	/* Qualcomm QCA8084 */
+	PHY_ID_MATCH_MODEL(QCA8084_PHY_ID),
+	.name			= "Qualcomm QCA8084",
+	.flags			= PHY_POLL_CABLE_TEST,
+	.config_intr		= at803x_config_intr,
+	.handle_interrupt	= at803x_handle_interrupt,
+	.get_tunable		= at803x_get_tunable,
+	.set_tunable		= at803x_set_tunable,
+	.set_wol		= at803x_set_wol,
+	.get_wol		= at803x_get_wol,
+	.get_features		= qca808x_get_features,
+	.config_aneg		= at803x_config_aneg,
+	.suspend		= genphy_suspend,
+	.resume			= genphy_resume,
+	.read_status		= qca808x_read_status,
+	.soft_reset		= qca808x_soft_reset,
+	.cable_test_start	= qca808x_cable_test_start,
+	.cable_test_get_status	= qca808x_cable_test_get_status,
 }, };
 
 module_phy_driver(at803x_driver);
@@ -2242,6 +2290,7 @@ static struct mdio_device_id __maybe_unused atheros_tbl[] = {
 	{ PHY_ID_MATCH_EXACT(QCA8327_B_PHY_ID) },
 	{ PHY_ID_MATCH_EXACT(QCA9561_PHY_ID) },
 	{ PHY_ID_MATCH_EXACT(QCA8081_PHY_ID) },
+	{ PHY_ID_MATCH_MODEL(QCA8084_PHY_ID) },
 	{ }
 };
 
-- 
2.42.0

