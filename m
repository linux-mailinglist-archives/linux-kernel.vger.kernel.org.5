Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80756753202
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 08:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbjGNGcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 02:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235220AbjGNGcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:32:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855F83586;
        Thu, 13 Jul 2023 23:32:27 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36E4vd7L019961;
        Fri, 14 Jul 2023 06:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Ml4+WHlQSULnscG7I40vu8n7nKP9AuS5jcWoS0k+KLc=;
 b=YDelQHjASDZxDoAXqGW3OWGfgxRhczUr7KQsw/y5HmUlqGXUtsJW3IW8aKnc1pGfL+wg
 v2Oj1BS3kS8SQfmXwPL6sIxOKt5uBGM5R9XrPryLZ/b5Fee2Y3iRlsbQ9MGIUbfherJ4
 99iFqZuT/DYYjp9TPZHdwBU8eCeOZGzRJbySn8zGigkrdlHVifvK5bf8OCzn0K75IBV5
 tsRkypFQyD/Ch7GTyRPPI27Dpv1AP+IQHpyrJBFIVDp+heeAVY2gu5EBKDcqxW9DBe/5
 Hew91+u5XZui+xVNiwvQw1eaYjwJZ+ThHfOFuHbYCR8Xl51maGAbYWjDMzTEo7gEYlFC gw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtpts12cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 06:32:11 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36E6WBkI009581
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 06:32:11 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 13 Jul 2023 23:32:08 -0700
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Luo Jie <quic_luoj@quicinc.com>
Subject: [PATCH v2 5/6] net: phy: at803x: remove qca8081 1G fast retrain and slave seed config
Date:   Fri, 14 Jul 2023 14:31:35 +0800
Message-ID: <20230714063136.21368-6-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230714063136.21368-1-quic_luoj@quicinc.com>
References: <20230714063136.21368-1-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XtLfC2fwbZ8Xfvdvwq2MygQ3C5uWPWIg
X-Proofpoint-ORIG-GUID: XtLfC2fwbZ8Xfvdvwq2MygQ3C5uWPWIg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_03,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140059
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fast retrain and master slave seed configs are only applicable when
the 2.5G capability is supported.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/phy/at803x.c | 45 ++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index cb4c45c81a85..5e9d2a4d8bbc 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -1766,20 +1766,24 @@ static int qca808x_config_init(struct phy_device *phydev)
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
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->supported)) {
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
@@ -1821,11 +1825,13 @@ static int qca808x_read_status(struct phy_device *phydev)
 		 * value is configured as the same value, the link can't be up and no link change
 		 * occurs.
 		 */
-		if (phydev->master_slave_state == MASTER_SLAVE_STATE_ERR ||
-				qca808x_is_prefer_master(phydev)) {
-			qca808x_phy_ms_seed_enable(phydev, false);
-		} else {
-			qca808x_phy_ms_seed_enable(phydev, true);
+		if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->supported)) {
+			if (phydev->master_slave_state == MASTER_SLAVE_STATE_ERR ||
+					qca808x_is_prefer_master(phydev)) {
+				qca808x_phy_ms_seed_enable(phydev, false);
+			} else {
+				qca808x_phy_ms_seed_enable(phydev, true);
+			}
 		}
 	}
 
@@ -1840,7 +1846,10 @@ static int qca808x_soft_reset(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
-	return qca808x_phy_ms_seed_enable(phydev, true);
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->supported))
+		ret = qca808x_phy_ms_seed_enable(phydev, true);
+
+	return ret;
 }
 
 static bool qca808x_cdt_fault_length_valid(int cdt_code)
-- 
2.17.1

