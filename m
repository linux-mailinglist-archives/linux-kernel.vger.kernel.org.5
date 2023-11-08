Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345787E55A3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 12:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344527AbjKHLfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 06:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbjKHLfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 06:35:22 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834CB18E;
        Wed,  8 Nov 2023 03:35:20 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8BWFuu015415;
        Wed, 8 Nov 2023 11:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=GrB9/H/l5aOxGCY1NFujRRp90fJh11KaZT064mhhhRk=;
 b=eYGDf/zpyfGTQ1yx4Ahnpsd0dTl6hPI/Fsy5doP+wlbOa50mKK4mOa7PyJSV8/h9C8Fy
 J/BSvl/YJmzptG08X8IC4s06NCPhWuteWMIALwRiDBAMgoKG82E7Z1YvvXoaQD+OyLfJ
 G6Ma5hpPVzRsjIbFFODRzRP8ADviapb/EUDzI7yb+XP4YRDFi8yXPsU4Y4uqkSOADkkT
 AyyKvBxJ5/sGJXqx3pSeQI/zEQ+/9zde2OWbdCVN2qwtxx2rrYRW59Z9+ZfggTzcSZnE
 vfeNPy7yYRueDePtuWbjAlDl3DwpLWz7mikyxKFF1OrJ6K4tLvWHXhWidFOtBTtyKkaN 3g== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u7w33sf1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 11:35:11 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A8BZAYj032330
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Nov 2023 11:35:10 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 8 Nov 2023 03:35:07 -0800
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/3] net: phy: qca8084: add qca8084_link_change_notify
Date:   Wed, 8 Nov 2023 19:34:45 +0800
Message-ID: <20231108113445.24825-4-quic_luoj@quicinc.com>
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
X-Proofpoint-ORIG-GUID: zHjVdxIiVJF4zJw9oCauT2heV9lQolGG
X-Proofpoint-GUID: zHjVdxIiVJF4zJw9oCauT2heV9lQolGG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311080097
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
index 6bea6e31caaa..4906775770b3 100644
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
@@ -2103,6 +2110,35 @@ static int qca8084_config_init(struct phy_device *phydev)
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
+	/* If the PHY works on PHY_INTERFACE_MODE_QUSGMII mode, the fifo needs to
+	 * be kept as reset state in link down status.
+	 */
+	if (phydev->interface != PHY_INTERFACE_MODE_QUSGMII || phydev->link) {
+		msleep(50);
+		ret = phy_modify(phydev, QCA8084_FIFO_CONTROL,
+				 QCA8084_FIFO_MAC_2_PHY | QCA8084_FIFO_PHY_2_MAC,
+				 QCA8084_FIFO_MAC_2_PHY | QCA8084_FIFO_PHY_2_MAC);
+		if (ret)
+			return;
+	}
+
+	/* Enable IPG 10 to 11 tuning on link speed 1000M of QUSGMII mode. */
+	if (phydev->interface == PHY_INTERFACE_MODE_QUSGMII)
+		phy_modify_mmd(phydev, MDIO_MMD_AN, QCA8084_MMD7_IPG_OP,
+			       QCA8084_IPG_10_TO_11_EN,
+			       phydev->speed == SPEED_1000 ? QCA8084_IPG_10_TO_11_EN : 0);
+}
+
 static struct phy_driver at803x_driver[] = {
 {
 	/* Qualcomm Atheros AR8035 */
@@ -2301,6 +2337,7 @@ static struct phy_driver at803x_driver[] = {
 	.cable_test_start	= qca808x_cable_test_start,
 	.cable_test_get_status	= qca808x_cable_test_get_status,
 	.config_init		= qca8084_config_init,
+	.link_change_notify	= qca8084_link_change_notify,
 }, };
 
 module_phy_driver(at803x_driver);
-- 
2.42.0

