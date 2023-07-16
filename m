Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45721754DE7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 10:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjGPIub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 04:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjGPIu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 04:50:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430D61986;
        Sun, 16 Jul 2023 01:50:18 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36G8kKmB031908;
        Sun, 16 Jul 2023 08:50:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=gKyyEjKOmIK56IjH0QQRMlIBK+WruELXAfpFleSezto=;
 b=BmpZCkoNx04vvTkQmmp9PqdbCf8WbWbeiP8pHcxecPbj4afz97abkUAmMAer+f6AHrz9
 C0ozTyIgBwxw/J1er5CbOxQGRPKRBSrp3/Hp36vIMQh6UnHRmmlDJDd0ZWmT98ZEjEKw
 hDCzbCYbxhA0atutgfQwq9x5HtEFzFBp3s/u7GqTc2uVhVl0is/EozNLaH5WURNM02P8
 Wfb/6o576VG8nFbilz6/xNCqxzb01u1AXPOTj3RrHTQl5Df8qAFxQwmvvJhmwghH8Rnc
 EKyn9W91lJyMFng8Kx/tBN66a16fr9/c3cWMHJGMKxv7jmjOEMscphwd2xJCb+0WUBDJ pw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3run0asade-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Jul 2023 08:50:07 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36G8o69O025308
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Jul 2023 08:50:06 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sun, 16 Jul 2023 01:50:03 -0700
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Luo Jie <quic_luoj@quicinc.com>
Subject: [PATCH v3 6/6] net: phy: at803x: add qca8081 fifo reset on the link changed
Date:   Sun, 16 Jul 2023 16:49:24 +0800
Message-ID: <20230716084924.9714-7-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230716084924.9714-1-quic_luoj@quicinc.com>
References: <20230716084924.9714-1-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _KKP5TfHYCSwr6QJDufH2mUGA8szGo_r
X-Proofpoint-ORIG-GUID: _KKP5TfHYCSwr6QJDufH2mUGA8szGo_r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-15_14,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307160081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qca8081 sgmii fifo needs to be reset on link down and
released on the link up in case of any abnormal issue
such as the packet blocked on the PHY.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/at803x.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index a141f133b8aa..13c4121fa309 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -276,6 +276,9 @@
 #define QCA808X_PHY_MMD7_CHIP_TYPE		0x901d
 #define QCA808X_PHY_CHIP_TYPE_1G		BIT(0)
 
+#define QCA8081_PHY_SERDES_MMD1_FIFO_CTRL	0x9072
+#define QCA8081_PHY_FIFO_RSTN			BIT(11)
+
 MODULE_DESCRIPTION("Qualcomm Atheros AR803x and QCA808X PHY driver");
 MODULE_AUTHOR("Matus Ujhelyi");
 MODULE_LICENSE("GPL");
@@ -2032,6 +2035,16 @@ static int qca808x_get_features(struct phy_device *phydev)
 	return 0;
 }
 
+static void qca808x_link_change_notify(struct phy_device *phydev)
+{
+	/* Assert interface sgmii fifo on link down, deassert it on link up,
+	 * the interface device address is always phy address added by 1.
+	 */
+	mdiobus_c45_modify_changed(phydev->mdio.bus, phydev->mdio.addr + 1,
+			MDIO_MMD_PMAPMD, QCA8081_PHY_SERDES_MMD1_FIFO_CTRL,
+			QCA8081_PHY_FIFO_RSTN, phydev->link ? QCA8081_PHY_FIFO_RSTN : 0);
+}
+
 static struct phy_driver at803x_driver[] = {
 {
 	/* Qualcomm Atheros AR8035 */
@@ -2210,6 +2223,7 @@ static struct phy_driver at803x_driver[] = {
 	.soft_reset		= qca808x_soft_reset,
 	.cable_test_start	= qca808x_cable_test_start,
 	.cable_test_get_status	= qca808x_cable_test_get_status,
+	.link_change_notify	= qca808x_link_change_notify,
 }, };
 
 module_phy_driver(at803x_driver);
-- 
2.17.1

