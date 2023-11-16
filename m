Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4580C7EE06F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 13:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345003AbjKPMK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 07:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345221AbjKPLZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:25:42 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EAE173F;
        Thu, 16 Nov 2023 03:25:34 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG7pCbS022329;
        Thu, 16 Nov 2023 11:25:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=uxMZ5i08IIj1P3XHjsuTSAB7PjcYnIlgE+t3bDDRN3U=;
 b=X0HKQvkA4gYoCY213I3W79n2ZXn4q/U3vQlWUzX1U9JUzB3bg8ssTvctzbPDamCGMjV8
 qPYB/g833aC74W76WOS0jViuJzM9hxZmb+9b/dmuwJD80QCkRMca9VfC2p3+CLSCSYj5
 Qwwuq859tcDz5Ru7PvEkXs5aXOu3q0VsvpAWu3qnZLDBx27p7dlaS48IVsBXNjmw+/u4
 xWmj3yD2sYrJxOXPr8BLpzorIKxhib6RTUsPGvnambPITA5xXqDj+WiI/8vBH/N/WumW
 H8ClTOKQh5AOJ6vlCHrFx5eFPvHvbXEMgcHGwFCH0VW9L5AAOGYTGJcjQd4Sf9XXYUsr UQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ud6echdjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 11:25:23 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AGBPMU5015808
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 11:25:22 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 16 Nov 2023 03:25:19 -0800
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v4 6/6] net: phy: qca8084: add qca8084_link_change_notify
Date:   Thu, 16 Nov 2023 19:24:37 +0800
Message-ID: <20231116112437.10578-7-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231116112437.10578-1-quic_luoj@quicinc.com>
References: <20231116112437.10578-1-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: crkXeUhecqFpROZv1m_EzhT65ICmF4yk
X-Proofpoint-ORIG-GUID: crkXeUhecqFpROZv1m_EzhT65ICmF4yk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_09,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311160091
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the link is changed, qca8084 needs to do the fifo reset and
adjust the IPG level for the qusgmii link speed 1000M.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/phy/at803x.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 06a068ca5539..7267ce858937 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -289,6 +289,13 @@
 #define QCA8084_MSE_THRESHOLD			0x800a
 #define QCA8084_MSE_THRESHOLD_2P5G_VAL		0x51c6
 
+#define QCA8084_FIFO_CONTROL			0x19
+#define QCA8084_FIFO_MAC_2_PHY			BIT(1)
+#define QCA8084_FIFO_PHY_2_MAC			BIT(0)
+
+#define QCA8084_MMD7_IPG_OP			0x901d
+#define QCA8084_IPG_10_TO_11_EN			BIT(0)
+
 MODULE_DESCRIPTION("Qualcomm Atheros AR803x and QCA808X PHY driver");
 MODULE_AUTHOR("Matus Ujhelyi");
 MODULE_LICENSE("GPL");
@@ -2109,6 +2116,35 @@ static int qca8084_config_init(struct phy_device *phydev)
 			     QCA8084_MSE_THRESHOLD, QCA8084_MSE_THRESHOLD_2P5G_VAL);
 }
 
+static void qca8084_link_change_notify(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = phy_modify(phydev, QCA8084_FIFO_CONTROL,
+			 QCA8084_FIFO_MAC_2_PHY | QCA8084_FIFO_PHY_2_MAC,
+			 0);
+	if (ret)
+		return;
+
+	/* If the PHY works on PHY_INTERFACE_MODE_10G_QXGMII mode, the fifo needs to
+	 * be kept as reset state in link down status.
+	 */
+	if (phydev->interface != PHY_INTERFACE_MODE_10G_QXGMII || phydev->link) {
+		msleep(50);
+		ret = phy_modify(phydev, QCA8084_FIFO_CONTROL,
+				 QCA8084_FIFO_MAC_2_PHY | QCA8084_FIFO_PHY_2_MAC,
+				 QCA8084_FIFO_MAC_2_PHY | QCA8084_FIFO_PHY_2_MAC);
+		if (ret)
+			return;
+	}
+
+	/* Enable IPG 10 to 11 tuning on link speed 1000M of QUSGMII mode. */
+	if (phydev->interface == PHY_INTERFACE_MODE_10G_QXGMII)
+		phy_modify_mmd(phydev, MDIO_MMD_AN, QCA8084_MMD7_IPG_OP,
+			       QCA8084_IPG_10_TO_11_EN,
+			       phydev->speed == SPEED_1000 ? QCA8084_IPG_10_TO_11_EN : 0);
+}
+
 static struct phy_driver at803x_driver[] = {
 {
 	/* Qualcomm Atheros AR8035 */
@@ -2307,6 +2343,7 @@ static struct phy_driver at803x_driver[] = {
 	.cable_test_start	= qca808x_cable_test_start,
 	.cable_test_get_status	= qca808x_cable_test_get_status,
 	.config_init		= qca8084_config_init,
+	.link_change_notify	= qca8084_link_change_notify,
 }, };
 
 module_phy_driver(at803x_driver);
-- 
2.42.0

