Return-Path: <linux-kernel+bounces-20696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F85828394
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A085E1F289EC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2018D36B15;
	Tue,  9 Jan 2024 09:58:17 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375C736AE4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 09:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rN8rr-0007j3-TQ; Tue, 09 Jan 2024 10:57:55 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rN8rq-001Rg1-Ht; Tue, 09 Jan 2024 10:57:54 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rN8rq-007r0c-1X;
	Tue, 09 Jan 2024 10:57:54 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: [RFC net-next v2 3/3] net: dsa: microchip: implement PHY loopback configuration for KSZ8794 and KSZ8873
Date: Tue,  9 Jan 2024 10:57:53 +0100
Message-Id: <20240109095753.1872010-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240109095753.1872010-1-o.rempel@pengutronix.de>
References: <20240109095753.1872010-1-o.rempel@pengutronix.de>
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

Correct the PHY loopback bit handling in the ksz8_w_phy_bmcr and
ksz8_r_phy_bmcr functions for KSZ8794 and KSZ8873 variants in the ksz8795
driver. Previously, the code erroneously used Bit 7 of port register 0xD
for both chip variants, which is actually for LED configuration. This
update ensures the correct registers and bits are used for the PHY
loopback feature:

- For KSZ8794: Use 0xF / Bit 7.
- For KSZ8873: Use 0xD / Bit 0.

The lack of loopback support was seen on KSZ8873 system by using
"ethtool -t lanX". After this patch, the ethtool selftest will work,
but only if port is not part of a bridge.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz8795.c     | 36 ++++++++++++++++++++-----
 drivers/net/dsa/microchip/ksz8795_reg.h |  1 +
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index 51e0194453df..1d8377640a3d 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -731,16 +731,25 @@ static int ksz8_r_phy_bmcr(struct ksz_device *dev, u16 port, u16 *val)
 	if (ret)
 		return ret;
 
-	if (restart & PORT_PHY_LOOPBACK)
-		*val |= BMCR_LOOPBACK;
-
 	if (ctrl & PORT_FORCE_100_MBIT)
 		*val |= BMCR_SPEED100;
 
 	if (ksz_is_ksz88x3(dev)) {
+		if (restart & KSZ8873_PORT_PHY_LOOPBACK)
+			*val |= BMCR_LOOPBACK;
+
 		if ((ctrl & PORT_AUTO_NEG_ENABLE))
 			*val |= BMCR_ANENABLE;
 	} else {
+		u8 stat3;
+
+		ret = ksz_pread8(dev, port, REG_PORT_STATUS_3, &stat3);
+		if (ret)
+			return ret;
+
+		if (stat3 & PORT_PHY_LOOPBACK)
+			*val |= BMCR_LOOPBACK;
+
 		if (!(ctrl & PORT_AUTO_NEG_DISABLE))
 			*val |= BMCR_ANENABLE;
 	}
@@ -1001,8 +1010,7 @@ static int ksz8_w_phy_bmcr(struct ksz_device *dev, u16 port, u16 val)
 
 	restart = 0;
 	restart_mask = PORT_LED_OFF | PORT_TX_DISABLE | PORT_AUTO_NEG_RESTART |
-		PORT_POWER_DOWN | PORT_AUTO_MDIX_DISABLE | PORT_FORCE_MDIX |
-		PORT_PHY_LOOPBACK;
+		PORT_POWER_DOWN | PORT_AUTO_MDIX_DISABLE | PORT_FORCE_MDIX;
 
 	if (val & KSZ886X_BMCR_DISABLE_LED)
 		restart |= PORT_LED_OFF;
@@ -1022,8 +1030,22 @@ static int ksz8_w_phy_bmcr(struct ksz_device *dev, u16 port, u16 val)
 	if (val & KSZ886X_BMCR_FORCE_MDI)
 		restart |= PORT_FORCE_MDIX;
 
-	if (val & BMCR_LOOPBACK)
-		restart |= PORT_PHY_LOOPBACK;
+	if (ksz_is_ksz88x3(dev)) {
+		restart_mask |= KSZ8873_PORT_PHY_LOOPBACK;
+
+		if (val & BMCR_LOOPBACK)
+			restart |= KSZ8873_PORT_PHY_LOOPBACK;
+	} else {
+		u8 stat3 = 0;
+
+		if (val & BMCR_LOOPBACK)
+			stat3 |= PORT_PHY_LOOPBACK;
+
+		ret = ksz_prmw8(dev, port, REG_PORT_STATUS_3, PORT_PHY_LOOPBACK,
+				stat3);
+		if (ret)
+			return ret;
+	}
 
 	return ksz_prmw8(dev, port, regs[P_NEG_RESTART_CTRL], restart_mask,
 			 restart);
diff --git a/drivers/net/dsa/microchip/ksz8795_reg.h b/drivers/net/dsa/microchip/ksz8795_reg.h
index beca974e0171..7c9341ef73b0 100644
--- a/drivers/net/dsa/microchip/ksz8795_reg.h
+++ b/drivers/net/dsa/microchip/ksz8795_reg.h
@@ -265,6 +265,7 @@
 #define PORT_AUTO_MDIX_DISABLE		BIT(2)
 #define PORT_FORCE_MDIX			BIT(1)
 #define PORT_MAC_LOOPBACK		BIT(0)
+#define KSZ8873_PORT_PHY_LOOPBACK	BIT(0)
 
 #define REG_PORT_1_STATUS_2		0x1E
 #define REG_PORT_2_STATUS_2		0x2E
-- 
2.39.2


