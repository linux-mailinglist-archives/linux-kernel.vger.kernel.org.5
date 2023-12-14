Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1255812BF2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443459AbjLNJsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235595AbjLNJsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:48:41 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441D711A;
        Thu, 14 Dec 2023 01:48:47 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE5uPrq000888;
        Thu, 14 Dec 2023 09:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        qcppdkim1; bh=xFzkCDqolDHuGop0ghdEPVtTSSDKjiEFcdJpsmCuDfI=; b=OK
        nX+WKNn9E9GWJRwZ8+SQ0OwpAJH0r1IofwbYfMJEWZPbRIEowDfzr9TS3RYxxqoU
        Zo+4+5UEq5WbN4jc6SX/I119B/dzYaTHAsg1lcbEffg+2uYoO4Li6VJP3MCFH+X5
        PPhr3CBUxhkQgDl/iz7nlO+j7QSZ5zmeCjUal/GH52gQbdHMf1qcnw79fN8O8nbM
        L3VNfsuRduhAWe78yAAfor2BegH6O6ClFfx1QCGRkSleP+DXwYwGuJXOm0e2ylCj
        hjxI6zA4ZQnEDeeBzFVVZJp1fOJZ2bnMsSnBIh0P8Ax64/t/H2g0QrXKy85Pr9Wn
        9LCEp8J9S7KPNO63j/7w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uyq9t0yaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 09:48:33 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BE9mWxU000756
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 09:48:32 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 01:48:27 -0800
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>,
        <p.zabel@pengutronix.de>, <f.fainelli@gmail.com>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v7 01/14] net: phy: introduce core support for phy-mode = "10g-qxgmii"
Date:   Thu, 14 Dec 2023 17:48:00 +0800
Message-ID: <20231214094813.24690-2-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231214094813.24690-1-quic_luoj@quicinc.com>
References: <20231214094813.24690-1-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mRC-5l0o1gY7iX8XrLRYTKmeJvyCyIGC
X-Proofpoint-GUID: mRC-5l0o1gY7iX8XrLRYTKmeJvyCyIGC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312140065
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
 Documentation/networking/phy.rst |  6 ++++++
 drivers/net/phy/phy-core.c       |  1 +
 drivers/net/phy/phylink.c        | 11 +++++++++--
 include/linux/phy.h              |  4 ++++
 include/linux/phylink.h          |  2 ++
 5 files changed, 22 insertions(+), 2 deletions(-)

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
index 48d3bd3e9fc7..938faac14930 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -231,6 +231,7 @@ static int phylink_interface_max_speed(phy_interface_t interface)
 		return SPEED_1000;
 
 	case PHY_INTERFACE_MODE_2500BASEX:
+	case PHY_INTERFACE_MODE_10G_QXGMII:
 		return SPEED_2500;
 
 	case PHY_INTERFACE_MODE_5GBASER:
@@ -500,7 +501,11 @@ static unsigned long phylink_get_capabilities(phy_interface_t interface,
 
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
@@ -941,6 +946,7 @@ static int phylink_parse_mode(struct phylink *pl,
 			phylink_set(pl->supported, 25000baseSR_Full);
 			fallthrough;
 		case PHY_INTERFACE_MODE_USXGMII:
+		case PHY_INTERFACE_MODE_10G_QXGMII:
 		case PHY_INTERFACE_MODE_10GKR:
 		case PHY_INTERFACE_MODE_10GBASER:
 			phylink_set(pl->supported, 10baseT_Half);
@@ -1837,7 +1843,8 @@ static int phylink_validate_phy(struct phylink *pl, struct phy_device *phy,
 	if (phy->is_c45 && state->rate_matching == RATE_MATCH_NONE &&
 	    state->interface != PHY_INTERFACE_MODE_RXAUI &&
 	    state->interface != PHY_INTERFACE_MODE_XAUI &&
-	    state->interface != PHY_INTERFACE_MODE_USXGMII)
+	    state->interface != PHY_INTERFACE_MODE_USXGMII &&
+	    state->interface != PHY_INTERFACE_MODE_10G_QXGMII)
 		state->interface = PHY_INTERFACE_MODE_NA;
 
 	return phylink_validate(pl, supported, state);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 6e7ebcc50b85..7697d94ac330 100644
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
index 875439ab45de..92bd2726cc8a 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -128,6 +128,7 @@ static inline unsigned int phylink_pcs_neg_mode(unsigned int mode,
 	case PHY_INTERFACE_MODE_QSGMII:
 	case PHY_INTERFACE_MODE_QUSGMII:
 	case PHY_INTERFACE_MODE_USXGMII:
+	case PHY_INTERFACE_MODE_10G_QXGMII:
 		/* These protocols are designed for use with a PHY which
 		 * communicates its negotiation result back to the MAC via
 		 * inband communication. Note: there exist PHYs that run
@@ -680,6 +681,7 @@ static inline int phylink_get_link_timer_ns(phy_interface_t interface)
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_QSGMII:
 	case PHY_INTERFACE_MODE_USXGMII:
+	case PHY_INTERFACE_MODE_10G_QXGMII:
 		return 1600000;
 
 	case PHY_INTERFACE_MODE_1000BASEX:
-- 
2.42.0

