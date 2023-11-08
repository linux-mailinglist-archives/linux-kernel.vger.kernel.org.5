Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DB37E559F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 12:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344503AbjKHLfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 06:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjKHLfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 06:35:20 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B42B0;
        Wed,  8 Nov 2023 03:35:18 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8BZ6gM010334;
        Wed, 8 Nov 2023 11:35:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=gEe8vKUE5d8vuTXVVQ+r0YFP2utTSyMT2wTA9gqZ50w=;
 b=PfQgj3hQPWCkne++lDK4K5kKudSr6VScuL8fSw300B0EMey40Q/asHt6JQ0nptoxAETr
 TA7rUSW8PjOELjjY2ooAuyY2vxEBiSOBCeo1IBEZ3qoQ7ZyR067yC0ahs4/WJ8YyOUEL
 7YOVglLQbneENiK+md0aII81YjGr6P6iYsqJHcsaQrIBFC423hwuACgN5qGq51W+JNfz
 V3Gqf9wjIgcqjBT0esNJ2N9GGbeGQ8dLtH5VR7uy4GzbDkvR3M8VZ9OY6ALD3LbmcsGr
 7MmjF+F4DVQoT19PxVjO+epkkKX0yLcd1xpHcV2xmiVIaVRbtpSyk0UqQZ8j1T+Trqpe Gw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u7xyu1992-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 11:35:06 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A8BZ5Hm028913
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Nov 2023 11:35:05 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 8 Nov 2023 03:35:03 -0800
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] net: phy: at803x: add QCA8084 ethernet phy support
Date:   Wed, 8 Nov 2023 19:34:43 +0800
Message-ID: <20231108113445.24825-2-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108113445.24825-1-quic_luoj@quicinc.com>
References: <20231108113445.24825-1-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YzXibLwLpka9_YHWTF91LExvTSbz_dyA
X-Proofpoint-GUID: YzXibLwLpka9_YHWTF91LExvTSbz_dyA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=779 adultscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080097
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add qca8084 PHY support, which is four-port PHY with maximum
link capability 2.5G, the features of each port is almost same
as QCA8081 and slave seed config is not needed.

Three kind of interface modes supported by qca8084.
PHY_INTERFACE_MODE_QUSGMII, PHY_INTERFACE_MODE_2500BASEX and
PHY_INTERFACE_MODE_SGMII.

The PCS(serdes) and clock are also needed to be configured to
bringup qca8084 PHY, which will be added in the pcs driver.

The additional CDT configurations used for qca8084.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/phy/at803x.c | 48 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 37fb033e1c29..f2a0d1688159 100644
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
 
@@ -1824,6 +1828,21 @@ static int qca808x_read_status(struct phy_device *phydev)
 		return ret;
 
 	if (phydev->link) {
+		/* There are two PCSs available for QCA8084, which support the following
+		 * interface modes.
+		 *
+		 * 1. PHY_INTERFACE_MODE_QUSGMII utilizes PCS1 for all available 4 ports,
+		 * which is for all link speeds.
+		 *
+		 * 2. PHY_INTERFACE_MODE_2500BASEX utilizes PCS0 for the fourth port,
+		 * which is only for the link speed 2500M same as QCA8081.
+		 *
+		 * 3. PHY_INTERFACE_MODE_SGMII utilizes PCS0 for the fourth port,
+		 * which is for the link speed 10M, 100M and 1000M same as QCA8081.
+		 */
+		if (phydev->interface == PHY_INTERFACE_MODE_QUSGMII)
+			return 0;
+
 		if (phydev->speed == SPEED_2500)
 			phydev->interface = PHY_INTERFACE_MODE_2500BASEX;
 		else
@@ -1958,6 +1977,14 @@ static int qca808x_cable_test_start(struct phy_device *phydev)
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
 
@@ -2227,6 +2254,26 @@ static struct phy_driver at803x_driver[] = {
 	.cable_test_start	= qca808x_cable_test_start,
 	.cable_test_get_status	= qca808x_cable_test_get_status,
 	.link_change_notify	= qca808x_link_change_notify,
+}, {
+	/* Qualcomm QCA8084 */
+	PHY_ID_MATCH_MODEL(QCA8084_PHY_ID),
+	.name			= "Qualcomm QCA8084",
+	.flags			= PHY_POLL_CABLE_TEST,
+	.probe			= at803x_probe,
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
@@ -2242,6 +2289,7 @@ static struct mdio_device_id __maybe_unused atheros_tbl[] = {
 	{ PHY_ID_MATCH_EXACT(QCA8327_B_PHY_ID) },
 	{ PHY_ID_MATCH_EXACT(QCA9561_PHY_ID) },
 	{ PHY_ID_MATCH_EXACT(QCA8081_PHY_ID) },
+	{ PHY_ID_MATCH_MODEL(QCA8084_PHY_ID) },
 	{ }
 };
 
-- 
2.42.0

