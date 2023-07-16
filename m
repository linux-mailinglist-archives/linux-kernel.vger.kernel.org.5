Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59207754DE2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 10:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjGPIuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 04:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjGPIuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 04:50:11 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45974D1;
        Sun, 16 Jul 2023 01:50:10 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36G8o0uC000391;
        Sun, 16 Jul 2023 08:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=CiLxrepfVwDMx74519uSMBuLfTc5nKS6s7Q4gMae6Zc=;
 b=Qu0IFN9CrvMxpRhiiFFssR5BXmZlLAeYYi9sJIWSk379+HWk+hgsAnymNvFlRZiCTgYm
 xJs2TG02ynYzv/4lM0861nRGxPzMkjns2ZATc3iPK0E1STS/U2X6XK2ZfvSF/l1JsRS4
 STvX4qNzUVA6040nx166+rhK6xonXj40SHaVVYY4i/k7t/w+2AXQvZEozd+1ixqqEKw1
 8vAHuvIqtxu+apSq51X2Q8vf2GwOezPJzSo0Yt/GvDE6ysLpZjBx05sit7fk14AHngOT
 D0xZmcOpUwB+CHdD4z6bNjdjJptwG1dUyYI06YRKOF69K03jWzk+qz1ThBCAfU7qyM84 eA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3run1k19bx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Jul 2023 08:49:59 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36G8nwv2018659
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Jul 2023 08:49:58 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sun, 16 Jul 2023 01:49:56 -0700
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Luo Jie <quic_luoj@quicinc.com>
Subject: [PATCH v3 3/6] net: phy: at803x: enable qca8081 slave seed conditionally
Date:   Sun, 16 Jul 2023 16:49:21 +0800
Message-ID: <20230716084924.9714-4-quic_luoj@quicinc.com>
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
X-Proofpoint-GUID: 6wyLjuxaXDlfwZqNpWC-kFZVlHDErEis
X-Proofpoint-ORIG-GUID: 6wyLjuxaXDlfwZqNpWC-kFZVlHDErEis
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-15_14,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307160081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qca8081 is the single port PHY, the slave prefer mode is used
by default.

if the phy master perfer mode is configured, the slave seed
configuration should not be enabled, since the slave seed
enablement is for making PHY linked as slave mode easily.

disable slave seed if the master mode is preferred.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/at803x.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 1d4aef60d51a..6cdc1b8f8c4d 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -1740,6 +1740,12 @@ static int qca808x_phy_ms_seed_enable(struct phy_device *phydev, bool enable)
 			QCA808X_MASTER_SLAVE_SEED_ENABLE);
 }
 
+static bool qca808x_is_prefer_master(struct phy_device *phydev)
+{
+	return (phydev->master_slave_get == MASTER_SLAVE_CFG_MASTER_FORCE) ||
+		(phydev->master_slave_get == MASTER_SLAVE_CFG_MASTER_PREFERRED);
+}
+
 static int qca808x_config_init(struct phy_device *phydev)
 {
 	int ret;
@@ -1761,11 +1767,17 @@ static int qca808x_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	/* Enable seed and configure lower ramdom seed to make phy linked as slave mode */
-	ret = qca808x_phy_ms_seed_enable(phydev, true);
-	if (ret)
+	ret = genphy_read_master_slave(phydev);
+	if (ret < 0)
 		return ret;
 
+	if (!qca808x_is_prefer_master(phydev)) {
+		/* Enable seed and configure lower ramdom seed to make phy linked as slave mode */
+		ret = qca808x_phy_ms_seed_enable(phydev, true);
+		if (ret)
+			return ret;
+	}
+
 	/* Configure adc threshold as 100mv for the link 10M */
 	return at803x_debug_reg_mask(phydev, QCA808X_PHY_DEBUG_ADC_THRESHOLD,
 			QCA808X_ADC_THRESHOLD_MASK, QCA808X_ADC_THRESHOLD_100MV);
@@ -1797,13 +1809,16 @@ static int qca808x_read_status(struct phy_device *phydev)
 			phydev->interface = PHY_INTERFACE_MODE_SGMII;
 	} else {
 		/* generate seed as a lower random value to make PHY linked as SLAVE easily,
-		 * except for master/slave configuration fault detected.
+		 * except for master/slave configuration fault detected or the master mode
+		 * preferred.
+		 *
 		 * the reason for not putting this code into the function link_change_notify is
 		 * the corner case where the link partner is also the qca8081 PHY and the seed
 		 * value is configured as the same value, the link can't be up and no link change
 		 * occurs.
 		 */
-		if (phydev->master_slave_state == MASTER_SLAVE_STATE_ERR) {
+		if (phydev->master_slave_state == MASTER_SLAVE_STATE_ERR ||
+				qca808x_is_prefer_master(phydev)) {
 			qca808x_phy_ms_seed_enable(phydev, false);
 		} else {
 			qca808x_phy_ms_seed_enable(phydev, true);
-- 
2.17.1

