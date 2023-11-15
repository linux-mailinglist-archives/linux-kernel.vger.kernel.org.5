Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123D67EC4C8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344127AbjKOOJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbjKOOJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:09:29 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEF61BD;
        Wed, 15 Nov 2023 06:09:25 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFCPKVU021426;
        Wed, 15 Nov 2023 14:09:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=CStCQLyV26Qh7F2VS8xy3Pn/7qiPWAVlSsA3UlBkTsM=;
 b=WfbbhF6rWrHaDLEG2QKhbLUTZVse4nDiokUq/MQss+Ffz/taaIJRcgl/+kPbzBeasnBk
 8amSrbruZp0vuG7RbHG/Vsg0s6FnAxS/FoZV1NLxy7bAviBum35xX48DwZblCeteAqbs
 X0zbjsby0nyfO7mTYzP+W6+vZ8289rTiSv/+EpQEdK4gtDB+zZs5tASabMBksfnyi+I6
 6z1sx8DfPpy4xrC+/aLSbRNfWaXRXl7aTwbcR2UP/qDrFLkpKitr83UPugSTUKpDtS8q
 72x/ZvAfJ1GUjzm1jsuEskHhZJaob3FLsuE30CdnSbCNS2R8snqGmgi8cdq/VFIpGMYu Cw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ucubs8m6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 14:09:11 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AFE8hnf006439
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 14:08:43 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 15 Nov 2023 06:08:40 -0800
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v3 1/6] net: phylink: move phylink_pcs_neg_mode() to phylink.c
Date:   Wed, 15 Nov 2023 22:06:25 +0800
Message-ID: <20231115140630.10858-2-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115140630.10858-1-quic_luoj@quicinc.com>
References: <20231115140630.10858-1-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rcuT2Rurk_3x0Oxw1a63LkR82UtloGJl
X-Proofpoint-GUID: rcuT2Rurk_3x0Oxw1a63LkR82UtloGJl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_13,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 mlxscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150110
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Russell points out that there is no user of phylink_pcs_neg_mode()
outside of phylink.c, nor is there planned to be any, so we can just
move it there.

Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/phy/phylink.c | 65 ++++++++++++++++++++++++++++++++++++++
 include/linux/phylink.h   | 66 ---------------------------------------
 2 files changed, 65 insertions(+), 66 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 25c19496a336..162f51b0986a 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -162,6 +162,71 @@ static const char *phylink_an_mode_str(unsigned int mode)
 	return mode < ARRAY_SIZE(modestr) ? modestr[mode] : "unknown";
 }
 
+/**
+ * phylink_pcs_neg_mode() - helper to determine PCS inband mode
+ * @mode: one of %MLO_AN_FIXED, %MLO_AN_PHY, %MLO_AN_INBAND.
+ * @interface: interface mode to be used
+ * @advertising: adertisement ethtool link mode mask
+ *
+ * Determines the negotiation mode to be used by the PCS, and returns
+ * one of:
+ *
+ * - %PHYLINK_PCS_NEG_NONE: interface mode does not support inband
+ * - %PHYLINK_PCS_NEG_OUTBAND: an out of band mode (e.g. reading the PHY)
+ *   will be used.
+ * - %PHYLINK_PCS_NEG_INBAND_DISABLED: inband mode selected but autoneg
+ *   disabled
+ * - %PHYLINK_PCS_NEG_INBAND_ENABLED: inband mode selected and autoneg enabled
+ *
+ * Note: this is for cases where the PCS itself is involved in negotiation
+ * (e.g. Clause 37, SGMII and similar) not Clause 73.
+ */
+static unsigned int phylink_pcs_neg_mode(unsigned int mode, phy_interface_t interface,
+					 const unsigned long *advertising)
+{
+	unsigned int neg_mode;
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_QSGMII:
+	case PHY_INTERFACE_MODE_QUSGMII:
+	case PHY_INTERFACE_MODE_USXGMII:
+		/* These protocols are designed for use with a PHY which
+		 * communicates its negotiation result back to the MAC via
+		 * inband communication. Note: there exist PHYs that run
+		 * with SGMII but do not send the inband data.
+		 */
+		if (!phylink_autoneg_inband(mode))
+			neg_mode = PHYLINK_PCS_NEG_OUTBAND;
+		else
+			neg_mode = PHYLINK_PCS_NEG_INBAND_ENABLED;
+		break;
+
+	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_2500BASEX:
+		/* 1000base-X is designed for use media-side for Fibre
+		 * connections, and thus the Autoneg bit needs to be
+		 * taken into account. We also do this for 2500base-X
+		 * as well, but drivers may not support this, so may
+		 * need to override this.
+		 */
+		if (!phylink_autoneg_inband(mode))
+			neg_mode = PHYLINK_PCS_NEG_OUTBAND;
+		else if (linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+					   advertising))
+			neg_mode = PHYLINK_PCS_NEG_INBAND_ENABLED;
+		else
+			neg_mode = PHYLINK_PCS_NEG_INBAND_DISABLED;
+		break;
+
+	default:
+		neg_mode = PHYLINK_PCS_NEG_NONE;
+		break;
+	}
+
+	return neg_mode;
+}
+
 static unsigned int phylink_interface_signal_rate(phy_interface_t interface)
 {
 	switch (interface) {
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 875439ab45de..d589f89c612c 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -98,72 +98,6 @@ static inline bool phylink_autoneg_inband(unsigned int mode)
 	return mode == MLO_AN_INBAND;
 }
 
-/**
- * phylink_pcs_neg_mode() - helper to determine PCS inband mode
- * @mode: one of %MLO_AN_FIXED, %MLO_AN_PHY, %MLO_AN_INBAND.
- * @interface: interface mode to be used
- * @advertising: adertisement ethtool link mode mask
- *
- * Determines the negotiation mode to be used by the PCS, and returns
- * one of:
- *
- * - %PHYLINK_PCS_NEG_NONE: interface mode does not support inband
- * - %PHYLINK_PCS_NEG_OUTBAND: an out of band mode (e.g. reading the PHY)
- *   will be used.
- * - %PHYLINK_PCS_NEG_INBAND_DISABLED: inband mode selected but autoneg
- *   disabled
- * - %PHYLINK_PCS_NEG_INBAND_ENABLED: inband mode selected and autoneg enabled
- *
- * Note: this is for cases where the PCS itself is involved in negotiation
- * (e.g. Clause 37, SGMII and similar) not Clause 73.
- */
-static inline unsigned int phylink_pcs_neg_mode(unsigned int mode,
-						phy_interface_t interface,
-						const unsigned long *advertising)
-{
-	unsigned int neg_mode;
-
-	switch (interface) {
-	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_QSGMII:
-	case PHY_INTERFACE_MODE_QUSGMII:
-	case PHY_INTERFACE_MODE_USXGMII:
-		/* These protocols are designed for use with a PHY which
-		 * communicates its negotiation result back to the MAC via
-		 * inband communication. Note: there exist PHYs that run
-		 * with SGMII but do not send the inband data.
-		 */
-		if (!phylink_autoneg_inband(mode))
-			neg_mode = PHYLINK_PCS_NEG_OUTBAND;
-		else
-			neg_mode = PHYLINK_PCS_NEG_INBAND_ENABLED;
-		break;
-
-	case PHY_INTERFACE_MODE_1000BASEX:
-	case PHY_INTERFACE_MODE_2500BASEX:
-		/* 1000base-X is designed for use media-side for Fibre
-		 * connections, and thus the Autoneg bit needs to be
-		 * taken into account. We also do this for 2500base-X
-		 * as well, but drivers may not support this, so may
-		 * need to override this.
-		 */
-		if (!phylink_autoneg_inband(mode))
-			neg_mode = PHYLINK_PCS_NEG_OUTBAND;
-		else if (linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
-					   advertising))
-			neg_mode = PHYLINK_PCS_NEG_INBAND_ENABLED;
-		else
-			neg_mode = PHYLINK_PCS_NEG_INBAND_DISABLED;
-		break;
-
-	default:
-		neg_mode = PHYLINK_PCS_NEG_NONE;
-		break;
-	}
-
-	return neg_mode;
-}
-
 /**
  * struct phylink_link_state - link state structure
  * @advertising: ethtool bitmask containing advertised link modes
-- 
2.42.0

