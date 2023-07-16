Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB94754DE0
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 10:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjGPIuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 04:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjGPIuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 04:50:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47201AB;
        Sun, 16 Jul 2023 01:50:07 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36G8fjVB031603;
        Sun, 16 Jul 2023 08:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=/ndyXYHsSWtHbq/vkmawRY1l1WopnPMK1gduIuWEinE=;
 b=kAya+T/SgD5IFcUmTsQGYFqrQxQDs/GEsh+o8BokZxAuLGzqSAm50gF7rHBVypCtLjQ+
 jDw0xaWq6unEq60mpm+S2+cHNNVUolykCc69mJuNxMOa6SFxZi5CCPQPYFF9m1qalpnH
 k1is+cHk7/faCEPii+xTXy97lLfJ2QsZWCGSPlK3w6jRFPflGjLDf2ItM7uHH/tOUVcQ
 B8J8Bs5CwJ1LUCjvVs7nmSRgFOslHOEJLQROH39+YM3fNQfIZHxWIr/Y0qSDf+umbtYD
 usYcl1b2S3DsfD9kWzVSyIfcneYVADiKhB8aFb5dRs7IyzYeyKETWPsGzht9kzLsqSG3 PQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3run0es9rt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Jul 2023 08:49:54 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36G8nriq018196
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Jul 2023 08:49:53 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sun, 16 Jul 2023 01:49:51 -0700
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Luo Jie <quic_luoj@quicinc.com>
Subject: [PATCH v3 1/6] net: phy: at803x: support qca8081 genphy_c45_pma_read_abilities
Date:   Sun, 16 Jul 2023 16:49:19 +0800
Message-ID: <20230716084924.9714-2-quic_luoj@quicinc.com>
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
X-Proofpoint-GUID: 6yv1Zv_kFXwwSCUaMvnG9A_nnqSaiolI
X-Proofpoint-ORIG-GUID: 6yv1Zv_kFXwwSCUaMvnG9A_nnqSaiolI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-15_14,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 impostorscore=0 adultscore=0 spamscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=993
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307160082
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qca8081 PHY supports to use genphy_c45_pma_read_abilities for
getting the PHY features supported except for the autoneg ability

but autoneg ability exists in MDIO_STAT1 instead of MMD7.1, add it
manually after calling genphy_c45_pma_read_abilities.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/at803x.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index c1f307d90518..11388ef3f7ef 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -897,15 +897,6 @@ static int at803x_get_features(struct phy_device *phydev)
 	if (err)
 		return err;
 
-	if (phydev->drv->phy_id == QCA8081_PHY_ID) {
-		err = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_NG_EXTABLE);
-		if (err < 0)
-			return err;
-
-		linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->supported,
-				err & MDIO_PMA_NG_EXTABLE_2_5GBT);
-	}
-
 	if (phydev->drv->phy_id != ATH8031_PHY_ID)
 		return 0;
 
@@ -1991,6 +1982,23 @@ static int qca808x_cable_test_get_status(struct phy_device *phydev, bool *finish
 	return 0;
 }
 
+static int qca808x_get_features(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = genphy_c45_pma_read_abilities(phydev);
+	if (ret)
+		return ret;
+
+	/* The autoneg ability is not existed in bit3 of MMD7.1,
+	 * but it is supported by qca808x PHY, so we add it here
+	 * manually.
+	 */
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, phydev->supported);
+
+	return 0;
+}
+
 static struct phy_driver at803x_driver[] = {
 {
 	/* Qualcomm Atheros AR8035 */
@@ -2160,7 +2168,7 @@ static struct phy_driver at803x_driver[] = {
 	.set_tunable		= at803x_set_tunable,
 	.set_wol		= at803x_set_wol,
 	.get_wol		= at803x_get_wol,
-	.get_features		= at803x_get_features,
+	.get_features		= qca808x_get_features,
 	.config_aneg		= at803x_config_aneg,
 	.suspend		= genphy_suspend,
 	.resume			= genphy_resume,
-- 
2.17.1

