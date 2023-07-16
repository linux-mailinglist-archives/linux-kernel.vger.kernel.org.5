Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D94B754DE6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 10:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjGPIu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 04:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjGPIuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 04:50:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A3D172B;
        Sun, 16 Jul 2023 01:50:17 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36G8o4XL003214;
        Sun, 16 Jul 2023 08:50:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=+Xrs7DZCC/z2iXTf8yNfUWldVKLycDsXp36wq/LoYQU=;
 b=AV9Jki7oG8Eix2Ks2f7kYRFJEQ60PB2BQOb1sFhIbzNiAoqGjeZUg4vB9kR8h6BJlP18
 YTauEmDd0SY22UbhxqXoifeK+2x9Ig27uJxqFqvrb0dvE+nXISr2IwLUSVSdIkG8XGTn
 5Os5s9WH9Wq3vZopEN7e1vd/G3yTEEPgAJx+H40uIY+LyQPMt5lkpES1RwEw+vUi9sNw
 usPT72hhRit6OGyglYW/ocLmHg/lEhV01VGS98PQp2Ac7iV7z1+q1Aaze4lfehfQrYbZ
 pg93lISrL28nRM63XWW2ZTXWLK9RmShBZxsavKW8hRM383xToC1l6AVxdLimgw3OgBPv 3w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3run0e9a3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Jul 2023 08:50:04 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36G8o3dl025290
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Jul 2023 08:50:03 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sun, 16 Jul 2023 01:50:01 -0700
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Luo Jie <quic_luoj@quicinc.com>
Subject: [PATCH v3 5/6] net: phy: at803x: remove qca8081 1G fast retrain and slave seed config
Date:   Sun, 16 Jul 2023 16:49:23 +0800
Message-ID: <20230716084924.9714-6-quic_luoj@quicinc.com>
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
X-Proofpoint-GUID: rS7KPF3qShlEPrjwV5gzRVV3SwpesB_Q
X-Proofpoint-ORIG-GUID: rS7KPF3qShlEPrjwV5gzRVV3SwpesB_Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-15_14,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 clxscore=1015 mlxscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

The fast retrain and slave seed configs are only applicable when the 2.5G
ability is supported.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/phy/at803x.c | 50 +++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index cb4c45c81a85..a141f133b8aa 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -1750,6 +1750,11 @@ static bool qca808x_is_prefer_master(struct phy_device *phydev)
 		(phydev->master_slave_get == MASTER_SLAVE_CFG_MASTER_PREFERRED);
 }
 
+static bool qca808x_has_fast_retrain_or_slave_seed(struct phy_device *phydev)
+{
+	return linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->supported);
+}
+
 static int qca808x_config_init(struct phy_device *phydev)
 {
 	int ret;
@@ -1766,20 +1771,24 @@ static int qca808x_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	/* Config the fast retrain for the link 2500M */
-	ret = qca808x_phy_fast_retrain_config(phydev);
-	if (ret)
-		return ret;
-
-	ret = genphy_read_master_slave(phydev);
-	if (ret < 0)
-		return ret;
-
-	if (!qca808x_is_prefer_master(phydev)) {
-		/* Enable seed and configure lower ramdom seed to make phy linked as slave mode */
-		ret = qca808x_phy_ms_seed_enable(phydev, true);
+	if (qca808x_has_fast_retrain_or_slave_seed(phydev)) {
+		/* Config the fast retrain for the link 2500M */
+		ret = qca808x_phy_fast_retrain_config(phydev);
 		if (ret)
 			return ret;
+
+		ret = genphy_read_master_slave(phydev);
+		if (ret < 0)
+			return ret;
+
+		if (!qca808x_is_prefer_master(phydev)) {
+			/* Enable seed and configure lower ramdom seed to make phy
+			 * linked as slave mode.
+			 */
+			ret = qca808x_phy_ms_seed_enable(phydev, true);
+			if (ret)
+				return ret;
+		}
 	}
 
 	/* Configure adc threshold as 100mv for the link 10M */
@@ -1821,11 +1830,13 @@ static int qca808x_read_status(struct phy_device *phydev)
 		 * value is configured as the same value, the link can't be up and no link change
 		 * occurs.
 		 */
-		if (phydev->master_slave_state == MASTER_SLAVE_STATE_ERR ||
-				qca808x_is_prefer_master(phydev)) {
-			qca808x_phy_ms_seed_enable(phydev, false);
-		} else {
-			qca808x_phy_ms_seed_enable(phydev, true);
+		if (qca808x_has_fast_retrain_or_slave_seed(phydev)) {
+			if (phydev->master_slave_state == MASTER_SLAVE_STATE_ERR ||
+					qca808x_is_prefer_master(phydev)) {
+				qca808x_phy_ms_seed_enable(phydev, false);
+			} else {
+				qca808x_phy_ms_seed_enable(phydev, true);
+			}
 		}
 	}
 
@@ -1840,7 +1851,10 @@ static int qca808x_soft_reset(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
-	return qca808x_phy_ms_seed_enable(phydev, true);
+	if (qca808x_has_fast_retrain_or_slave_seed(phydev))
+		ret = qca808x_phy_ms_seed_enable(phydev, true);
+
+	return ret;
 }
 
 static bool qca808x_cdt_fault_length_valid(int cdt_code)
-- 
2.17.1

