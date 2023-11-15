Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453A77EC4C2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344134AbjKOOJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344122AbjKOOJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:09:02 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267AEAC;
        Wed, 15 Nov 2023 06:08:59 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFDrhGU015437;
        Wed, 15 Nov 2023 14:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=ACeIv0gd2tHOeUGVi71LfYiWOVkoF4WrCPcf1rDwtuk=;
 b=ZTSOYblDPA5SkhcFPxLH56PogfO/UuP+egXq4bkl5qqC7EGUBdxKdeWR0yjeRj9pU89F
 jTMbP89Ma33pm89zGL0pjbfUNRbVjjAkMeVFVfxog0KkECciaR2Zg8ax/ASLA86Yvodf
 xVqk4/Erc4LiQv0CPpvTRYii9H+tDBfjFtjiyS0sBEqkIS2b1HRIekBOJIvDKOwBJNgU
 qktbOM6YTdnxUhPAYV3HBDcr/U0HAKFuvttVh6ooJwXU2HdzDbexYigHR14D+efNJZo1
 MlWMLYIVKC324mnyIFgWFTV8hm8DJih/UtWtk3TW2PpWU3sbfq+ng1+AW0JOJsICnb/d CA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uck901m9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 14:08:47 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AFE8ke7015987
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 14:08:46 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 15 Nov 2023 06:08:43 -0800
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v3 2/6] net: phy: introduce core support for phy-mode = "10g-qxgmii"
Date:   Wed, 15 Nov 2023 22:06:26 +0800
Message-ID: <20231115140630.10858-3-quic_luoj@quicinc.com>
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
X-Proofpoint-GUID: aAi4rUSm8-zhoJVbyLcwMYkvYJOM742r
X-Proofpoint-ORIG-GUID: aAi4rUSm8-zhoJVbyLcwMYkvYJOM742r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_13,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 clxscore=1015 suspectscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150109
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

10G-QXGMII is a MAC-to-PHY interface defined by the USXGMII multiport
specification. It uses the same signaling as USXGMII, but it multiplexes
4 ports over the link, resulting in a maximum speed of 2.5G per port.

Some in-tree SoCs like the NXP LS1028A use "usxgmii" when they mean
either the single-port USXGMII or the quad-port 10G-QXGMII variant, and
they could get away just fine with that thus far. But there is a need to
distinguish between the 2 as far as SerDes drivers are concerned.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 .../devicetree/bindings/net/ethernet-controller.yaml |  1 +
 Documentation/networking/phy.rst                     |  6 ++++++
 drivers/net/phy/phy-core.c                           |  1 +
 drivers/net/phy/phylink.c                            | 12 ++++++++++--
 include/linux/phy.h                                  |  4 ++++
 include/linux/phylink.h                              |  1 +
 6 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 9f6a5ccbcefe..044880d804db 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -104,6 +104,7 @@ properties:
       - usxgmii
       - 10gbase-r
       - 25gbase-r
+      - 10g-qxgmii
 
   phy-mode:
     $ref: "#/properties/phy-connection-type"
diff --git a/Documentation/networking/phy.rst b/Documentation/networking/phy.rst
index 1283240d7620..f64641417c54 100644
--- a/Documentation/networking/phy.rst
+++ b/Documentation/networking/phy.rst
@@ -327,6 +327,12 @@ Some of the interface modes are described below:
     This is the Penta SGMII mode, it is similar to QSGMII but it combines 5
     SGMII lines into a single link compared to 4 on QSGMII.
 
+``PHY_INTERFACE_MODE_10G_QXGMII``
+    Represents the 10G-QXGMII PHY-MAC interface as defined by the Cisco USXGMII
+    Multiport Copper Interface document. It supports 4 ports over a 10.3125 GHz
+    SerDes lane, each port having speeds of 2.5G / 1G / 100M / 10M achieved
+    through symbol replication. The PCS expects the standard USXGMII code word.
+
 Pause frames / flow control
 ===========================
 
diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 966c93cbe616..1cd58723d6d0 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -141,6 +141,7 @@ int phy_interface_num_ports(phy_interface_t interface)
 		return 1;
 	case PHY_INTERFACE_MODE_QSGMII:
 	case PHY_INTERFACE_MODE_QUSGMII:
+	case PHY_INTERFACE_MODE_10G_QXGMII:
 		return 4;
 	case PHY_INTERFACE_MODE_PSGMII:
 		return 5;
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 162f51b0986a..e9ab20bd6984 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -191,6 +191,7 @@ static unsigned int phylink_pcs_neg_mode(unsigned int mode, phy_interface_t inte
 	case PHY_INTERFACE_MODE_QSGMII:
 	case PHY_INTERFACE_MODE_QUSGMII:
 	case PHY_INTERFACE_MODE_USXGMII:
+	case PHY_INTERFACE_MODE_10G_QXGMII:
 		/* These protocols are designed for use with a PHY which
 		 * communicates its negotiation result back to the MAC via
 		 * inband communication. Note: there exist PHYs that run
@@ -283,6 +284,7 @@ static int phylink_interface_max_speed(phy_interface_t interface)
 		return SPEED_1000;
 
 	case PHY_INTERFACE_MODE_2500BASEX:
+	case PHY_INTERFACE_MODE_10G_QXGMII:
 		return SPEED_2500;
 
 	case PHY_INTERFACE_MODE_5GBASER:
@@ -552,7 +554,11 @@ static unsigned long phylink_get_capabilities(phy_interface_t interface,
 
 	switch (interface) {
 	case PHY_INTERFACE_MODE_USXGMII:
-		caps |= MAC_10000FD | MAC_5000FD | MAC_2500FD;
+		caps |= MAC_10000FD | MAC_5000FD;
+		fallthrough;
+
+	case PHY_INTERFACE_MODE_10G_QXGMII:
+		caps |= MAC_2500FD;
 		fallthrough;
 
 	case PHY_INTERFACE_MODE_RGMII_TXID:
@@ -972,6 +978,7 @@ static int phylink_parse_mode(struct phylink *pl,
 			phylink_set(pl->supported, 25000baseSR_Full);
 			fallthrough;
 		case PHY_INTERFACE_MODE_USXGMII:
+		case PHY_INTERFACE_MODE_10G_QXGMII:
 		case PHY_INTERFACE_MODE_10GKR:
 		case PHY_INTERFACE_MODE_10GBASER:
 			phylink_set(pl->supported, 10baseT_Half);
@@ -1844,7 +1851,8 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 	if (phy->is_c45 && config.rate_matching == RATE_MATCH_NONE &&
 	    interface != PHY_INTERFACE_MODE_RXAUI &&
 	    interface != PHY_INTERFACE_MODE_XAUI &&
-	    interface != PHY_INTERFACE_MODE_USXGMII)
+	    interface != PHY_INTERFACE_MODE_USXGMII &&
+	    interface != PHY_INTERFACE_MODE_10G_QXGMII)
 		config.interface = PHY_INTERFACE_MODE_NA;
 	else
 		config.interface = interface;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 3cc52826f18e..e0af0378e2a1 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -125,6 +125,7 @@ extern const int phy_10gbit_features_array[1];
  * @PHY_INTERFACE_MODE_10GKR: 10GBASE-KR - with Clause 73 AN
  * @PHY_INTERFACE_MODE_QUSGMII: Quad Universal SGMII
  * @PHY_INTERFACE_MODE_1000BASEKX: 1000Base-KX - with Clause 73 AN
+ * @PHY_INTERFACE_MODE_10G_QXGMII: 10G-QXGMII - 4 ports over 10G USXGMII
  * @PHY_INTERFACE_MODE_MAX: Book keeping
  *
  * Describes the interface between the MAC and PHY.
@@ -165,6 +166,7 @@ typedef enum {
 	PHY_INTERFACE_MODE_10GKR,
 	PHY_INTERFACE_MODE_QUSGMII,
 	PHY_INTERFACE_MODE_1000BASEKX,
+	PHY_INTERFACE_MODE_10G_QXGMII,
 	PHY_INTERFACE_MODE_MAX,
 } phy_interface_t;
 
@@ -286,6 +288,8 @@ static inline const char *phy_modes(phy_interface_t interface)
 		return "100base-x";
 	case PHY_INTERFACE_MODE_QUSGMII:
 		return "qusgmii";
+	case PHY_INTERFACE_MODE_10G_QXGMII:
+		return "10g-qxgmii";
 	default:
 		return "unknown";
 	}
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index d589f89c612c..d7e32c9f3ae1 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -614,6 +614,7 @@ static inline int phylink_get_link_timer_ns(phy_interface_t interface)
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_QSGMII:
 	case PHY_INTERFACE_MODE_USXGMII:
+	case PHY_INTERFACE_MODE_10G_QXGMII:
 		return 1600000;
 
 	case PHY_INTERFACE_MODE_1000BASEX:
-- 
2.42.0

