Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF237E030B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 13:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376757AbjKCMgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 08:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376554AbjKCMgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 08:36:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE94D4F;
        Fri,  3 Nov 2023 05:36:14 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3BP841009823;
        Fri, 3 Nov 2023 12:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=xXusRQbm4m28+UlBOW+vODwkm5i55zyiI+PcrVbxQZg=;
 b=GHGUFl7zHJMigAUKnF1oAjFDpFMWG4dfm3BG5G/3E/aKgbjzy+YOMbW0HHhFSJ6QWr4U
 vYIuOIJFOc7NqRPCZj45+2FreV/ALnKLrWeR4u1TGARGjwF+EemDBP6xw99UvrUz3NLc
 JC8xEx9t/n8MKejJ4nPWl18tRhQcrojzyI1jbmRFFHuTCy+OdqTw/Vyi/2Iz9yihmvPZ
 kRJJw87KmmOuf+d3ewyjD5wcsBxHfrh2T2wq8rK2wrMpPYppL4x2czt2VZaZ3VFve3ZM
 0GeRdsq/9os0v5oV5j/nMNhILwh15lZc8IrgdbPAyA2MSQWitqfvPYcaKtPE957/yiro LA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u4cw9tejh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 12:35:54 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A3CZr3K015831
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Nov 2023 12:35:53 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 3 Nov 2023 05:35:51 -0700
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] net: phy: at803x: add QCA8084 ethernet phy support
Date:   Fri, 3 Nov 2023 20:35:37 +0800
Message-ID: <20231103123538.15735-1-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ibQeycliF0kq73Jw_3m6JwQoSF2A8b9z
X-Proofpoint-ORIG-GUID: ibQeycliF0kq73Jw_3m6JwQoSF2A8b9z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_12,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 mlxscore=0 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311030106
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

There are some initialization configurations needed.
1. Configuring qca8084 related initializations including
MSE detect threshold and ADC clock edge invert.
2. Add the additional configurations for the CDT feature.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/phy/at803x.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 37fb033e1c29..4124eb76d835 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -176,6 +176,8 @@
 #define AT8030_PHY_ID_MASK			0xffffffef
 
 #define QCA8081_PHY_ID				0x004dd101
+#define QCA8081_PHY_MASK			0xffffff00
+#define QCA8084_PHY_ID				0x004dd180
 
 #define QCA8327_A_PHY_ID			0x004dd033
 #define QCA8327_B_PHY_ID			0x004dd034
@@ -279,6 +281,15 @@
 #define QCA8081_PHY_SERDES_MMD1_FIFO_CTRL	0x9072
 #define QCA8081_PHY_FIFO_RSTN			BIT(11)
 
+/* QCA8084 ADC clock edge */
+#define QCA8084_ADC_CLK_SEL			0x8b80
+#define QCA8084_ADC_CLK_SEL_ACLK		GENMASK(7, 4)
+#define QCA8084_ADC_CLK_SEL_ACLK_FALL		0xf
+#define QCA8084_ADC_CLK_SEL_ACLK_RISE		0x0
+
+#define QCA8084_MSE_THRESHOLD			0x800a
+#define QCA8084_MSE_THRESHOLD_2P5G_VAL		0x51c6
+
 MODULE_DESCRIPTION("Qualcomm Atheros AR803x and QCA808X PHY driver");
 MODULE_AUTHOR("Matus Ujhelyi");
 MODULE_LICENSE("GPL");
@@ -1760,6 +1771,9 @@ static bool qca808x_is_prefer_master(struct phy_device *phydev)
 
 static bool qca808x_has_fast_retrain_or_slave_seed(struct phy_device *phydev)
 {
+	if (phydev->phy_id == QCA8084_PHY_ID)
+		return false;
+
 	return linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->supported);
 }
 
@@ -1767,6 +1781,20 @@ static int qca808x_config_init(struct phy_device *phydev)
 {
 	int ret;
 
+	if (phydev->phy_id == QCA8084_PHY_ID) {
+		/* Invert ADC clock edge */
+		ret = at803x_debug_reg_mask(phydev, QCA8084_ADC_CLK_SEL,
+					    QCA8084_ADC_CLK_SEL_ACLK,
+					    FIELD_PREP(QCA8084_ADC_CLK_SEL_ACLK,
+						       QCA8084_ADC_CLK_SEL_ACLK_FALL));
+		if (ret < 0)
+			return ret;
+
+		/* Adjust MSE threshold value to avoid link issue with some link partner */
+		return phy_write_mmd(phydev, MDIO_MMD_PMAPMD,
+				QCA8084_MSE_THRESHOLD, QCA8084_MSE_THRESHOLD_2P5G_VAL);
+	}
+
 	/* Active adc&vga on 802.3az for the link 1000M and 100M */
 	ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, QCA808X_PHY_MMD3_ADDR_CLD_CTRL7,
 			QCA808X_8023AZ_AFE_CTRL_MASK, QCA808X_8023AZ_AFE_EN);
@@ -1958,6 +1986,11 @@ static int qca808x_cable_test_start(struct phy_device *phydev)
 	phy_write_mmd(phydev, MDIO_MMD_PCS, 0x807a, 0xc060);
 	phy_write_mmd(phydev, MDIO_MMD_PCS, 0x807e, 0xb060);
 
+	if (phydev->phy_id == QCA8084_PHY_ID) {
+		phy_write_mmd(phydev, MDIO_MMD_PCS, 0x8075, 0xa060);
+		phy_write_mmd(phydev, MDIO_MMD_PCS, 0x807f, 0x1eb0);
+	}
+
 	return 0;
 }
 
@@ -2207,8 +2240,9 @@ static struct phy_driver at803x_driver[] = {
 	.resume			= qca83xx_resume,
 }, {
 	/* Qualcomm QCA8081 */
-	PHY_ID_MATCH_EXACT(QCA8081_PHY_ID),
-	.name			= "Qualcomm QCA8081",
+	.phy_id			= QCA8081_PHY_ID,
+	.phy_id_mask		= QCA8081_PHY_MASK,
+	.name			= "Qualcomm QCA808X",
 	.flags			= PHY_POLL_CABLE_TEST,
 	.probe			= at803x_probe,
 	.config_intr		= at803x_config_intr,
@@ -2241,7 +2275,7 @@ static struct mdio_device_id __maybe_unused atheros_tbl[] = {
 	{ PHY_ID_MATCH_EXACT(QCA8327_A_PHY_ID) },
 	{ PHY_ID_MATCH_EXACT(QCA8327_B_PHY_ID) },
 	{ PHY_ID_MATCH_EXACT(QCA9561_PHY_ID) },
-	{ PHY_ID_MATCH_EXACT(QCA8081_PHY_ID) },
+	{ QCA8081_PHY_ID, QCA8081_PHY_MASK},
 	{ }
 };
 
-- 
2.42.0

