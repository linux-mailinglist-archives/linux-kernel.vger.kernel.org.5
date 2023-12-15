Return-Path: <linux-kernel+bounces-543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB538142AE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EED41C22471
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF6A12E72;
	Fri, 15 Dec 2023 07:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BM+dOhc9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A600D107B4;
	Fri, 15 Dec 2023 07:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BF3orro031304;
	Fri, 15 Dec 2023 07:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=yrH4I9MLB1rBoTIeqw2Ara0pvTd3qHEwJTMWIE48IO0=; b=BM
	+dOhc9y/FU4QTkNzcJjmXG5RsYmPubZvunktO1r6l43xgYZH6fNPW1Ch35HNZcRb
	wHbqEiEllCpRb0100ogqv6AhoOLfluHI358A9exuOQzLHtG9Rk0P1Zg8TCexf5+N
	L+35o548qws67/2j/v/Jt2zIKavxOfri/xlrSy0+GPLaXJFtd9mJIErya4RcThcO
	EBsOvKEXiKHQ3fKOxSul1swjGgHvEwFoxBv61v6s276AGELgTZ7yThJC9k4dV2rm
	ZdEye+yn1OtpOlswhhdyIT6qQV3JE9Xg7mqPJPqkxYOYppcyZ7ZhxtIlqhcz4WS2
	5BjckeGAQSQdktPLgJZw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uysrpu5u7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 07:40:31 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BF7eVC7022277
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 07:40:31 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 23:40:26 -0800
From: Luo Jie <quic_luoj@quicinc.com>
To: <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>,
        <p.zabel@pengutronix.de>, <f.fainelli@gmail.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Russell King
	<rmk+kernel@armlinux.org.uk>
Subject: [PATCH v8 01/14] net: phy: introduce core support for phy-mode = "10g-qxgmii"
Date: Fri, 15 Dec 2023 15:39:51 +0800
Message-ID: <20231215074005.26976-2-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231215074005.26976-1-quic_luoj@quicinc.com>
References: <20231215074005.26976-1-quic_luoj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eC44DPYKKp4gnutReU_KR3V7XSv0_AGw
X-Proofpoint-GUID: eC44DPYKKp4gnutReU_KR3V7XSv0_AGw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1011 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312150047

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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
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
index dbb5e13e3e1b..87859a32f6ef 100644
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


