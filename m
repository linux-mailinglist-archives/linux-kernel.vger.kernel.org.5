Return-Path: <linux-kernel+bounces-24725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AB582C15B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 279DE1C21953
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66CF6DCE4;
	Fri, 12 Jan 2024 14:07:36 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591846D1BD
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rOIBr-0000z9-A2; Fri, 12 Jan 2024 15:07:19 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rOIBp-002AeX-Vt; Fri, 12 Jan 2024 15:07:18 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rOIBp-00BOUA-2v;
	Fri, 12 Jan 2024 15:07:17 +0100
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
Subject: [RFC net-next v3 3/3] net: dsa: microchip: implement PHY loopback configuration for KSZ8794 and KSZ8873
Date: Fri, 12 Jan 2024 15:07:16 +0100
Message-Id: <20240112140716.2715664-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112140716.2715664-1-o.rempel@pengutronix.de>
References: <20240112140716.2715664-1-o.rempel@pengutronix.de>
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
 drivers/net/dsa/microchip/ksz8795.c     | 76 ++++++++++++++++++++++---
 drivers/net/dsa/microchip/ksz8795_reg.h |  1 +
 2 files changed, 70 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index 51e0194453df..50351cef6ca5 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -632,6 +632,57 @@ static void ksz8_w_vlan_table(struct ksz_device *dev, u16 vid, u16 vlan)
 	ksz8_w_table(dev, TABLE_VLAN, addr, buf);
 }
 
+/**
+ * ksz879x_get_loopback - KSZ879x specific function to get loopback
+ *                        configuration status for a specific port
+ * @dev: Pointer to the device structure
+ * @port: Port number to query
+ * @val: Pointer to store the result
+ *
+ * This function reads the SMI registers to determine whether loopback mode
+ * is enabled for a specific port.
+ *
+ * Return: 0 on success, error code on failure.
+ */
+static int ksz879x_get_loopback(struct ksz_device *dev, u16 port,
+				u16 *val)
+{
+	u8 stat3;
+	int ret;
+
+	ret = ksz_pread8(dev, port, REG_PORT_STATUS_3, &stat3);
+	if (ret)
+		return ret;
+
+	if (stat3 & PORT_PHY_LOOPBACK)
+		*val |= BMCR_LOOPBACK;
+
+	return 0;
+}
+
+/**
+ * ksz879x_set_loopback - KSZ879x specific function  to set loopback mode for
+ *			  a specific port
+ * @dev: Pointer to the device structure.
+ * @port: Port number to modify.
+ * @val: Value indicating whether to enable or disable loopback mode.
+ *
+ * This function translates loopback bit of the BMCR register into the
+ * corresponding hardware register bit value and writes it to the SMI interface.
+ *
+ * Return: 0 on success, error code on failure.
+ */
+static int ksz879x_set_loopback(struct ksz_device *dev, u16 port, u16 val)
+{
+	u8 stat3 = 0;
+
+	if (val & BMCR_LOOPBACK)
+		stat3 |= PORT_PHY_LOOPBACK;
+
+	return ksz_prmw8(dev, port, REG_PORT_STATUS_3, PORT_PHY_LOOPBACK,
+			 stat3);
+}
+
 /**
  * ksz8_r_phy_ctrl - Translates and reads from the SMI interface to a MIIM PHY
  *		     Control register (Reg. 31).
@@ -731,16 +782,20 @@ static int ksz8_r_phy_bmcr(struct ksz_device *dev, u16 port, u16 *val)
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
+		ret = ksz879x_get_loopback(dev, port, val);
+		if (ret)
+			return ret;
+
 		if (!(ctrl & PORT_AUTO_NEG_DISABLE))
 			*val |= BMCR_ANENABLE;
 	}
@@ -1001,8 +1056,7 @@ static int ksz8_w_phy_bmcr(struct ksz_device *dev, u16 port, u16 val)
 
 	restart = 0;
 	restart_mask = PORT_LED_OFF | PORT_TX_DISABLE | PORT_AUTO_NEG_RESTART |
-		PORT_POWER_DOWN | PORT_AUTO_MDIX_DISABLE | PORT_FORCE_MDIX |
-		PORT_PHY_LOOPBACK;
+		PORT_POWER_DOWN | PORT_AUTO_MDIX_DISABLE | PORT_FORCE_MDIX;
 
 	if (val & KSZ886X_BMCR_DISABLE_LED)
 		restart |= PORT_LED_OFF;
@@ -1022,8 +1076,16 @@ static int ksz8_w_phy_bmcr(struct ksz_device *dev, u16 port, u16 val)
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
+		ret = ksz879x_set_loopback(dev, port, val);
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


