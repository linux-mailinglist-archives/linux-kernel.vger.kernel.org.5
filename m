Return-Path: <linux-kernel+bounces-20694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0249982838F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2605B1C23203
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EACD35F19;
	Tue,  9 Jan 2024 09:58:12 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6074535890
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 09:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rN8rs-0007j2-R6; Tue, 09 Jan 2024 10:57:56 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rN8rq-001Rg0-HP; Tue, 09 Jan 2024 10:57:54 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rN8rq-007r0S-1T;
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
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: [RFC net-next v2 2/3] net: dsa: microchip: Remove redundant optimization in ksz8_w_phy_bmcr
Date: Tue,  9 Jan 2024 10:57:52 +0100
Message-Id: <20240109095753.1872010-3-o.rempel@pengutronix.de>
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

Remove the manual checks for register value changes in the
ksz8_w_phy_bmcr function. Instead, rely on regmap_update_bits() for
optimizing register updates.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/microchip/ksz8795.c | 96 +++++++++--------------------
 1 file changed, 29 insertions(+), 67 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index 1269dde832bd..51e0194453df 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -956,115 +956,77 @@ static int ksz8_w_phy_ctrl(struct ksz_device *dev, int port, u16 val)
  */
 static int ksz8_w_phy_bmcr(struct ksz_device *dev, u16 port, u16 val)
 {
+	u8 restart, speed, ctrl, restart_mask;
 	const u16 *regs = dev->info->regs;
-	u8 restart, ctrl, speed, data;
 	int ret;
 
 	/* Do not support PHY reset function. */
 	if (val & BMCR_RESET)
 		return 0;
 
-	ret = ksz_pread8(dev, port, regs[P_SPEED_STATUS], &speed);
-	if (ret)
-		return ret;
-
-	data = speed;
+	speed = 0;
 	if (val & KSZ886X_BMCR_HP_MDIX)
-		data |= PORT_HP_MDIX;
-	else
-		data &= ~PORT_HP_MDIX;
-
-	if (data != speed) {
-		ret = ksz_pwrite8(dev, port, regs[P_SPEED_STATUS], data);
-		if (ret)
-			return ret;
-	}
+		speed |= PORT_HP_MDIX;
 
-	ret = ksz_pread8(dev, port, regs[P_FORCE_CTRL], &ctrl);
+	ret = ksz_prmw8(dev, port, regs[P_SPEED_STATUS], PORT_HP_MDIX, speed);
 	if (ret)
 		return ret;
 
-	data = ctrl;
+	ctrl = 0;
 	if (ksz_is_ksz88x3(dev)) {
 		if ((val & BMCR_ANENABLE))
-			data |= PORT_AUTO_NEG_ENABLE;
-		else
-			data &= ~PORT_AUTO_NEG_ENABLE;
+			ctrl |= PORT_AUTO_NEG_ENABLE;
 	} else {
 		if (!(val & BMCR_ANENABLE))
-			data |= PORT_AUTO_NEG_DISABLE;
-		else
-			data &= ~PORT_AUTO_NEG_DISABLE;
+			ctrl |= PORT_AUTO_NEG_DISABLE;
 
 		/* Fiber port does not support auto-negotiation. */
 		if (dev->ports[port].fiber)
-			data |= PORT_AUTO_NEG_DISABLE;
+			ctrl |= PORT_AUTO_NEG_DISABLE;
 	}
 
 	if (val & BMCR_SPEED100)
-		data |= PORT_FORCE_100_MBIT;
-	else
-		data &= ~PORT_FORCE_100_MBIT;
+		ctrl |= PORT_FORCE_100_MBIT;
 
 	if (val & BMCR_FULLDPLX)
-		data |= PORT_FORCE_FULL_DUPLEX;
-	else
-		data &= ~PORT_FORCE_FULL_DUPLEX;
-
-	if (data != ctrl) {
-		ret = ksz_pwrite8(dev, port, regs[P_FORCE_CTRL], data);
-		if (ret)
-			return ret;
-	}
+		ctrl |= PORT_FORCE_FULL_DUPLEX;
 
-	ret = ksz_pread8(dev, port, regs[P_NEG_RESTART_CTRL], &restart);
+	ret = ksz_prmw8(dev, port, regs[P_FORCE_CTRL], PORT_FORCE_100_MBIT |
+		 /* PORT_AUTO_NEG_ENABLE and PORT_AUTO_NEG_DISABLE are the same
+		  * bits
+		  */
+		 PORT_FORCE_FULL_DUPLEX | PORT_AUTO_NEG_ENABLE, ctrl);
 	if (ret)
 		return ret;
 
-	data = restart;
+	restart = 0;
+	restart_mask = PORT_LED_OFF | PORT_TX_DISABLE | PORT_AUTO_NEG_RESTART |
+		PORT_POWER_DOWN | PORT_AUTO_MDIX_DISABLE | PORT_FORCE_MDIX |
+		PORT_PHY_LOOPBACK;
+
 	if (val & KSZ886X_BMCR_DISABLE_LED)
-		data |= PORT_LED_OFF;
-	else
-		data &= ~PORT_LED_OFF;
+		restart |= PORT_LED_OFF;
 
 	if (val & KSZ886X_BMCR_DISABLE_TRANSMIT)
-		data |= PORT_TX_DISABLE;
-	else
-		data &= ~PORT_TX_DISABLE;
+		restart |= PORT_TX_DISABLE;
 
 	if (val & BMCR_ANRESTART)
-		data |= PORT_AUTO_NEG_RESTART;
-	else
-		data &= ~(PORT_AUTO_NEG_RESTART);
+		restart |= PORT_AUTO_NEG_RESTART;
 
 	if (val & BMCR_PDOWN)
-		data |= PORT_POWER_DOWN;
-	else
-		data &= ~PORT_POWER_DOWN;
+		restart |= PORT_POWER_DOWN;
 
 	if (val & KSZ886X_BMCR_DISABLE_AUTO_MDIX)
-		data |= PORT_AUTO_MDIX_DISABLE;
-	else
-		data &= ~PORT_AUTO_MDIX_DISABLE;
+		restart |= PORT_AUTO_MDIX_DISABLE;
 
 	if (val & KSZ886X_BMCR_FORCE_MDI)
-		data |= PORT_FORCE_MDIX;
-	else
-		data &= ~PORT_FORCE_MDIX;
+		restart |= PORT_FORCE_MDIX;
 
 	if (val & BMCR_LOOPBACK)
-		data |= PORT_PHY_LOOPBACK;
-	else
-		data &= ~PORT_PHY_LOOPBACK;
-
-	if (data != restart) {
-		ret = ksz_pwrite8(dev, port, regs[P_NEG_RESTART_CTRL],
-				  data);
-		if (ret)
-			return ret;
-	}
+		restart |= PORT_PHY_LOOPBACK;
 
-	return 0;
+	return ksz_prmw8(dev, port, regs[P_NEG_RESTART_CTRL], restart_mask,
+			 restart);
 }
 
 int ksz8_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
-- 
2.39.2


