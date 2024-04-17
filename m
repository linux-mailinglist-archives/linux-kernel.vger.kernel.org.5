Return-Path: <linux-kernel+bounces-148929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F23F8A891E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8789A1C22DB7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706ED17108F;
	Wed, 17 Apr 2024 16:43:34 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9917B16FF5C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 16:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713372213; cv=none; b=I+fJg2uCjBOq3RdyiSEOY/E8eDeKh6dVyEpwJYvfZd03F6UVEoNcG4MPt3CBwZDOBLCVrunuOolpj+1Z1zEsd4QYOeTpyaoHiXLhe05Gi1xULY/Eug+hzo7H2SwrMjN1+ZeUNH0oQ/rP5iercET2bFsORhg7ZCZM23TtGi3eUZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713372213; c=relaxed/simple;
	bh=V5GIDFcd7puL39RgacgdDIHX1FFltse/qW+4H1jXSA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r5kufdqr42r2K4nUYfi5uBKRClFKfZqF0SY6MltYsY6sIeGm36wTXoqNrlQ8R5KLqgu86fUCTwAN2h7DrSDNEthTMPpyA5d1MzW6vmGH7Nn4Vj2r+FKUSLfr6BgDflK4eE2w8UX3OuLtZbgY99/vdZhBvk0q8tSZFh/INO8Vpj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rx8NT-0007N1-VQ; Wed, 17 Apr 2024 18:43:19 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rx8NR-00CpCb-QE; Wed, 17 Apr 2024 18:43:17 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rx8NR-007Me2-2O;
	Wed, 17 Apr 2024 18:43:17 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH net-next v1 2/4] net: phy: micrel: lan8841: set default PTP latency values
Date: Wed, 17 Apr 2024 18:43:14 +0200
Message-Id: <20240417164316.1755299-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240417164316.1755299-1-o.rempel@pengutronix.de>
References: <20240417164316.1755299-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Set default PTP latency values to provide realistic path delay
measurements and reflecting internal PHY latency asymetry.

This values are based on ptp4l measurements for the path delay against
identical PHY as link partner and latency asymmetry extracted from
documented SOF Latency values of this PHY.

Documented SOF Latency values are:
TX 138ns/RX 430ns @ 1000Mbps
TX 140ns/RX 615ns @ 100Mbps (fixed latency mode)
TX 140ns/RX 488-524ns @ 100Mbps (variable latency mode)
TX 654ns/227-2577ns @ 10Mbps

Calculated asymmetry:
292ns @ 1000Mbps
238ns @ 100Mbps
1923ns @ 10Mbps

Except of ptp4l based tests RGMII-PHY-PHY-RGMII path delay was measured
to verify if values are in sane range. Following LAN8841 + LAN8841 RGMII
delays are measured:
583ns @ 1000Mbps
1080ns @ 100Mbps
15200ns @ 10Mbps

Without configuring compensation registers ptp4l reported following
path delay results:
~467ns @ 1000Mbps
~544ns @ 100Mbps
~9688ns @ 10Mbps

Magnetic + Cable + Magnetic delay in this setup is about 5ns.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/micrel.c | 55 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index ddb50a0e2bc82..5831706e81623 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -3405,6 +3405,20 @@ static int lan8814_probe(struct phy_device *phydev)
 #define LAN8841_BTRX_POWER_DOWN_BTRX_CH_C	BIT(5)
 #define LAN8841_BTRX_POWER_DOWN_BTRX_CH_D	BIT(7)
 #define LAN8841_ADC_CHANNEL_MASK		198
+#define LAN8841_PTP_RX_LATENCY_10M		328
+#define LAN8841_PTP_TX_LATENCY_10M		329
+#define LAN8841_PTP_RX_LATENCY_100M		330
+#define LAN8841_PTP_TX_LATENCY_100M		331
+#define LAN8841_PTP_RX_LATENCY_1000M		332
+#define LAN8841_PTP_TX_LATENCY_1000M		333
+
+#define LAN8841_PTP_RX_LATENCY_10M_VAL		5803
+#define LAN8841_PTP_TX_LATENCY_10M_VAL		3880
+#define LAN8841_PTP_RX_LATENCY_100M_VAL		443
+#define LAN8841_PTP_TX_LATENCY_100M_VAL		95
+#define LAN8841_PTP_RX_LATENCY_1000M_VAL	377
+#define LAN8841_PTP_TX_LATENCY_1000M_VAL	85
+
 #define LAN8841_PTP_RX_PARSE_L2_ADDR_EN		370
 #define LAN8841_PTP_RX_PARSE_IP_ADDR_EN		371
 #define LAN8841_PTP_RX_VERSION			374
@@ -3421,6 +3435,45 @@ static int lan8814_probe(struct phy_device *phydev)
 #define LAN8841_PTP_INSERT_TS_EN		BIT(0)
 #define LAN8841_PTP_INSERT_TS_32BIT		BIT(1)
 
+static int lan8841_ptp_latency_init(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = phy_write_mmd(phydev, KSZ9131RN_MMD_COMMON_CTRL_REG,
+			    LAN8841_PTP_RX_LATENCY_10M,
+			    LAN8841_PTP_RX_LATENCY_10M_VAL);
+	if (ret)
+		return ret;
+
+	ret = phy_write_mmd(phydev, KSZ9131RN_MMD_COMMON_CTRL_REG,
+			    LAN8841_PTP_TX_LATENCY_10M,
+			    LAN8841_PTP_TX_LATENCY_10M_VAL);
+	if (ret)
+		return ret;
+
+	ret = phy_write_mmd(phydev, KSZ9131RN_MMD_COMMON_CTRL_REG,
+			    LAN8841_PTP_RX_LATENCY_100M,
+			    LAN8841_PTP_RX_LATENCY_100M_VAL);
+	if (ret)
+		return ret;
+
+	ret = phy_write_mmd(phydev, KSZ9131RN_MMD_COMMON_CTRL_REG,
+			    LAN8841_PTP_TX_LATENCY_100M,
+			    LAN8841_PTP_TX_LATENCY_100M_VAL);
+	if (ret)
+		return ret;
+
+	ret = phy_write_mmd(phydev, KSZ9131RN_MMD_COMMON_CTRL_REG,
+			    LAN8841_PTP_RX_LATENCY_1000M,
+			    LAN8841_PTP_RX_LATENCY_1000M_VAL);
+	if (ret)
+		return ret;
+
+	return phy_write_mmd(phydev, KSZ9131RN_MMD_COMMON_CTRL_REG,
+			     LAN8841_PTP_TX_LATENCY_1000M,
+			     LAN8841_PTP_TX_LATENCY_1000M_VAL);
+}
+
 static int lan8841_config_init(struct phy_device *phydev)
 {
 	int ret;
@@ -3500,7 +3553,7 @@ static int lan8841_config_init(struct phy_device *phydev)
 		      LAN8841_MMD0_REGISTER_17_DROP_OPT(2) |
 		      LAN8841_MMD0_REGISTER_17_XMIT_TOG_TX_DIS);
 
-	return 0;
+	return lan8841_ptp_latency_init(phydev);
 }
 
 #define LAN8841_OUTPUT_CTRL			25
-- 
2.39.2


