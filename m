Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB82E7F324B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbjKUPYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234401AbjKUPYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:24:42 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FF0E7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:24:38 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1r5Sc0-000607-I4; Tue, 21 Nov 2023 16:24:28 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1r5Sbz-00Ac93-DS; Tue, 21 Nov 2023 16:24:27 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <ore@pengutronix.de>)
        id 1r5Sbz-00HZfk-18;
        Tue, 21 Nov 2023 16:24:27 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com
Subject: [PATCH net-next v1 1/3] net: dsa: microchip: ksz8: move BMCR specific code to separate function
Date:   Tue, 21 Nov 2023 16:24:24 +0100
Message-Id: <20231121152426.4188456-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Isolate the Basic Mode Control Register (BMCR) operations in the ksz8795
driver by moving the BMCR-related code segments from the ksz8_r_phy()
and ksz8_w_phy() functions to newly created ksz8_r_phy_bmcr() and
ksz8_w_phy_bmcr() functions.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz8795.c | 351 ++++++++++++++++++----------
 1 file changed, 227 insertions(+), 124 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index 4bf4d67557dc..835157815937 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -676,9 +676,98 @@ static int ksz8_r_phy_ctrl(struct ksz_device *dev, int port, u16 *val)
 	return 0;
 }
 
+/**
+ * ksz8_r_phy_bmcr - Translates and reads from the SMI interface to a MIIM PHY
+ *		     Basic mode control register (Reg. 0).
+ * @dev: The KSZ device instance.
+ * @port: The port number to be read.
+ * @val: The value read from the SMI interface.
+ *
+ * This function reads the SMI interface and translates the hardware register
+ * bit values into their corresponding control settings for a MIIM PHY Basic
+ * mode control register.
+ *
+ * MIIM Bit Mapping Comparison between KSZ8794 and KSZ8873
+ * -------------------------------------------------------------------
+ * MIIM Bit                    | KSZ8794 Reg/Bit             | KSZ8873 Reg/Bit
+ * ----------------------------+-----------------------------+----------------
+ * Bit 15 - Soft Reset         | 0xF/4                       | Not supported
+ * Bit 14 - Loopback           | 0xD/0 (MAC), 0xF/7 (PHY)    ~ 0xD/0 (PHY)
+ * Bit 13 - Force 100          | 0xC/6                       = 0xC/6
+ * Bit 12 - AN Enable          | 0xC/7 (reverse logic)       ~ 0xC/7
+ * Bit 11 - Power Down         | 0xD/3                       = 0xD/3
+ * Bit 10 - PHY Isolate        | 0xF/5                       | Not supported
+ * Bit 9 - Restart AN          | 0xD/5                       = 0xD/5
+ * Bit 8 - Force Full-Duplex   | 0xC/5                       = 0xC/5
+ * Bit 7 - Collision Test/Res. | Not supported               | Not supported
+ * Bit 6 - Reserved            | Not supported               | Not supported
+ * Bit 5 - Hp_mdix             | 0x9/7                       ~ 0xF/7
+ * Bit 4 - Force MDI           | 0xD/1                       = 0xD/1
+ * Bit 3 - Disable MDIX        | 0xD/2                       = 0xD/2
+ * Bit 2 - Disable Far-End F.  | ????                        | 0xD/4
+ * Bit 1 - Disable Transmit    | 0xD/6                       = 0xD/6
+ * Bit 0 - Disable LED         | 0xD/7                       = 0xD/7
+ * -------------------------------------------------------------------
+ *
+ * Return: 0 on success, error code on failure.
+ */
+static int ksz8_r_phy_bmcr(struct ksz_device *dev, int port, u16 *val)
+{
+	const u16 *regs = dev->info->regs;
+	u8 restart, speed, ctrl;
+	int ret;
+
+	*val = 0;
+
+	ret = ksz_pread8(dev, port, regs[P_NEG_RESTART_CTRL], &restart);
+	if (ret)
+		return ret;
+
+	ret = ksz_pread8(dev, port, regs[P_SPEED_STATUS], &speed);
+	if (ret)
+		return ret;
+
+	ret = ksz_pread8(dev, port, regs[P_FORCE_CTRL], &ctrl);
+	if (ret)
+		return ret;
+
+	if (restart & PORT_PHY_LOOPBACK)
+		*val |= BMCR_LOOPBACK;
+
+	if (ctrl & PORT_FORCE_100_MBIT)
+		*val |= BMCR_SPEED100;
+
+	if (ksz_is_ksz88x3(dev)) {
+		if ((ctrl & PORT_AUTO_NEG_ENABLE))
+			*val |= BMCR_ANENABLE;
+	} else {
+		if (!(ctrl & PORT_AUTO_NEG_DISABLE))
+			*val |= BMCR_ANENABLE;
+	}
+
+	if (restart & PORT_POWER_DOWN)
+		*val |= BMCR_PDOWN;
+	if (restart & PORT_AUTO_NEG_RESTART)
+		*val |= BMCR_ANRESTART;
+	if (ctrl & PORT_FORCE_FULL_DUPLEX)
+		*val |= BMCR_FULLDPLX;
+	if (speed & PORT_HP_MDIX)
+		*val |= KSZ886X_BMCR_HP_MDIX;
+	if (restart & PORT_FORCE_MDIX)
+		*val |= KSZ886X_BMCR_FORCE_MDI;
+	if (restart & PORT_AUTO_MDIX_DISABLE)
+		*val |= KSZ886X_BMCR_DISABLE_AUTO_MDIX;
+	if (restart & PORT_TX_DISABLE)
+		*val |= KSZ886X_BMCR_DISABLE_TRANSMIT;
+	if (restart & PORT_LED_OFF)
+		*val |= KSZ886X_BMCR_DISABLE_LED;
+
+	return 0;
+}
+
 int ksz8_r_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 *val)
 {
-	u8 restart, speed, ctrl, link;
+	u8 ctrl, link;
 	int processed = true;
 	const u16 *regs;
 	u8 val1, val2;
@@ -690,45 +779,9 @@ int ksz8_r_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 *val)
 
 	switch (reg) {
 	case MII_BMCR:
-		ret = ksz_pread8(dev, p, regs[P_NEG_RESTART_CTRL], &restart);
-		if (ret)
-			return ret;
-
-		ret = ksz_pread8(dev, p, regs[P_SPEED_STATUS], &speed);
-		if (ret)
-			return ret;
-
-		ret = ksz_pread8(dev, p, regs[P_FORCE_CTRL], &ctrl);
+		ret = ksz8_r_phy_bmcr(dev, p, &data);
 		if (ret)
 			return ret;
-
-		if (restart & PORT_PHY_LOOPBACK)
-			data |= BMCR_LOOPBACK;
-		if (ctrl & PORT_FORCE_100_MBIT)
-			data |= BMCR_SPEED100;
-		if (ksz_is_ksz88x3(dev)) {
-			if ((ctrl & PORT_AUTO_NEG_ENABLE))
-				data |= BMCR_ANENABLE;
-		} else {
-			if (!(ctrl & PORT_AUTO_NEG_DISABLE))
-				data |= BMCR_ANENABLE;
-		}
-		if (restart & PORT_POWER_DOWN)
-			data |= BMCR_PDOWN;
-		if (restart & PORT_AUTO_NEG_RESTART)
-			data |= BMCR_ANRESTART;
-		if (ctrl & PORT_FORCE_FULL_DUPLEX)
-			data |= BMCR_FULLDPLX;
-		if (speed & PORT_HP_MDIX)
-			data |= KSZ886X_BMCR_HP_MDIX;
-		if (restart & PORT_FORCE_MDIX)
-			data |= KSZ886X_BMCR_FORCE_MDI;
-		if (restart & PORT_AUTO_MDIX_DISABLE)
-			data |= KSZ886X_BMCR_DISABLE_AUTO_MDIX;
-		if (restart & PORT_TX_DISABLE)
-			data |= KSZ886X_BMCR_DISABLE_TRANSMIT;
-		if (restart & PORT_LED_OFF)
-			data |= KSZ886X_BMCR_DISABLE_LED;
 		break;
 	case MII_BMSR:
 		ret = ksz_pread8(dev, p, regs[P_LINK_STATUS], &link);
@@ -860,113 +913,163 @@ static int ksz8_w_phy_ctrl(struct ksz_device *dev, int port, u16 val)
 	return ret;
 }
 
-int ksz8_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
+/**
+ * ksz8_w_phy_bmcr - Translates and writes to the SMI interface from a MIIM PHY
+ *		     Basic mode control register (Reg. 0).
+ * @dev: The KSZ device instance.
+ * @port: The port number to be configured.
+ * @val: The register value to be written.
+ *
+ * This function translates control settings from a MIIM PHY Basic mode control
+ * register into their corresponding hardware register bit values for the SMI
+ * interface.
+ *
+ * MIIM Bit Mapping Comparison between KSZ8794 and KSZ8873
+ * -------------------------------------------------------------------
+ * MIIM Bit                    | KSZ8794 Reg/Bit             | KSZ8873 Reg/Bit
+ * ----------------------------+-----------------------------+----------------
+ * Bit 15 - Soft Reset         | 0xF/4                       | Not supported
+ * Bit 14 - Loopback           | 0xD/0 (MAC), 0xF/7 (PHY)    ~ 0xD/0 (PHY)
+ * Bit 13 - Force 100          | 0xC/6                       = 0xC/6
+ * Bit 12 - AN Enable          | 0xC/7 (reverse logic)       ~ 0xC/7
+ * Bit 11 - Power Down         | 0xD/3                       = 0xD/3
+ * Bit 10 - PHY Isolate        | 0xF/5                       | Not supported
+ * Bit 9 - Restart AN          | 0xD/5                       = 0xD/5
+ * Bit 8 - Force Full-Duplex   | 0xC/5                       = 0xC/5
+ * Bit 7 - Collision Test/Res. | Not supported               | Not supported
+ * Bit 6 - Reserved            | Not supported               | Not supported
+ * Bit 5 - Hp_mdix             | 0x9/7                       ~ 0xF/7
+ * Bit 4 - Force MDI           | 0xD/1                       = 0xD/1
+ * Bit 3 - Disable MDIX        | 0xD/2                       = 0xD/2
+ * Bit 2 - Disable Far-End F.  | ????                        | 0xD/4
+ * Bit 1 - Disable Transmit    | 0xD/6                       = 0xD/6
+ * Bit 0 - Disable LED         | 0xD/7                       = 0xD/7
+ * -------------------------------------------------------------------
+ *
+ * Return: 0 on success, error code on failure.
+ */
+static int ksz8_w_phy_bmcr(struct ksz_device *dev, int port, u16 val)
 {
-	u8 restart, speed, ctrl, data;
-	const u16 *regs;
-	u8 p = phy;
+	const u16 *regs = dev->info->regs;
+	u8 restart, ctrl, speed, data;
 	int ret;
 
-	regs = dev->info->regs;
+	/* Do not support PHY reset function. */
+	if (val & BMCR_RESET)
+		return 0;
 
-	switch (reg) {
-	case MII_BMCR:
+	ret = ksz_pread8(dev, port, regs[P_SPEED_STATUS], &speed);
+	if (ret)
+		return ret;
 
-		/* Do not support PHY reset function. */
-		if (val & BMCR_RESET)
-			break;
-		ret = ksz_pread8(dev, p, regs[P_SPEED_STATUS], &speed);
+	data = speed;
+	if (val & KSZ886X_BMCR_HP_MDIX)
+		data |= PORT_HP_MDIX;
+	else
+		data &= ~PORT_HP_MDIX;
+
+	if (data != speed) {
+		ret = ksz_pwrite8(dev, port, regs[P_SPEED_STATUS], data);
 		if (ret)
 			return ret;
+	}
+
+	ret = ksz_pread8(dev, port, regs[P_FORCE_CTRL], &ctrl);
+	if (ret)
+		return ret;
 
-		data = speed;
-		if (val & KSZ886X_BMCR_HP_MDIX)
-			data |= PORT_HP_MDIX;
+	data = ctrl;
+	if (ksz_is_ksz88x3(dev)) {
+		if ((val & BMCR_ANENABLE))
+			data |= PORT_AUTO_NEG_ENABLE;
+		else
+			data &= ~PORT_AUTO_NEG_ENABLE;
+	} else {
+		if (!(val & BMCR_ANENABLE))
+			data |= PORT_AUTO_NEG_DISABLE;
 		else
-			data &= ~PORT_HP_MDIX;
+			data &= ~PORT_AUTO_NEG_DISABLE;
 
-		if (data != speed) {
-			ret = ksz_pwrite8(dev, p, regs[P_SPEED_STATUS], data);
-			if (ret)
-				return ret;
-		}
+		/* Fiber port does not support auto-negotiation. */
+		if (dev->ports[port].fiber)
+			data |= PORT_AUTO_NEG_DISABLE;
+	}
 
-		ret = ksz_pread8(dev, p, regs[P_FORCE_CTRL], &ctrl);
+	if (val & BMCR_SPEED100)
+		data |= PORT_FORCE_100_MBIT;
+	else
+		data &= ~PORT_FORCE_100_MBIT;
+	if (val & BMCR_FULLDPLX)
+		data |= PORT_FORCE_FULL_DUPLEX;
+	else
+		data &= ~PORT_FORCE_FULL_DUPLEX;
+
+	if (data != ctrl) {
+		ret = ksz_pwrite8(dev, port, regs[P_FORCE_CTRL], data);
 		if (ret)
 			return ret;
+	}
 
-		data = ctrl;
-		if (ksz_is_ksz88x3(dev)) {
-			if ((val & BMCR_ANENABLE))
-				data |= PORT_AUTO_NEG_ENABLE;
-			else
-				data &= ~PORT_AUTO_NEG_ENABLE;
-		} else {
-			if (!(val & BMCR_ANENABLE))
-				data |= PORT_AUTO_NEG_DISABLE;
-			else
-				data &= ~PORT_AUTO_NEG_DISABLE;
-
-			/* Fiber port does not support auto-negotiation. */
-			if (dev->ports[p].fiber)
-				data |= PORT_AUTO_NEG_DISABLE;
-		}
+	ret = ksz_pread8(dev, port, regs[P_NEG_RESTART_CTRL], &restart);
+	if (ret)
+		return ret;
 
-		if (val & BMCR_SPEED100)
-			data |= PORT_FORCE_100_MBIT;
-		else
-			data &= ~PORT_FORCE_100_MBIT;
-		if (val & BMCR_FULLDPLX)
-			data |= PORT_FORCE_FULL_DUPLEX;
-		else
-			data &= ~PORT_FORCE_FULL_DUPLEX;
+	data = restart;
+	if (val & KSZ886X_BMCR_DISABLE_LED)
+		data |= PORT_LED_OFF;
+	else
+		data &= ~PORT_LED_OFF;
+	if (val & KSZ886X_BMCR_DISABLE_TRANSMIT)
+		data |= PORT_TX_DISABLE;
+	else
+		data &= ~PORT_TX_DISABLE;
+	if (val & BMCR_ANRESTART)
+		data |= PORT_AUTO_NEG_RESTART;
+	else
+		data &= ~(PORT_AUTO_NEG_RESTART);
+	if (val & BMCR_PDOWN)
+		data |= PORT_POWER_DOWN;
+	else
+		data &= ~PORT_POWER_DOWN;
+	if (val & KSZ886X_BMCR_DISABLE_AUTO_MDIX)
+		data |= PORT_AUTO_MDIX_DISABLE;
+	else
+		data &= ~PORT_AUTO_MDIX_DISABLE;
+	if (val & KSZ886X_BMCR_FORCE_MDI)
+		data |= PORT_FORCE_MDIX;
+	else
+		data &= ~PORT_FORCE_MDIX;
+	if (val & BMCR_LOOPBACK)
+		data |= PORT_PHY_LOOPBACK;
+	else
+		data &= ~PORT_PHY_LOOPBACK;
 
-		if (data != ctrl) {
-			ret = ksz_pwrite8(dev, p, regs[P_FORCE_CTRL], data);
-			if (ret)
-				return ret;
-		}
+	if (data != restart) {
+		ret = ksz_pwrite8(dev, port, regs[P_NEG_RESTART_CTRL],
+				  data);
+		if (ret)
+			return ret;
+	}
 
-		ret = ksz_pread8(dev, p, regs[P_NEG_RESTART_CTRL], &restart);
+	return 0;
+}
+
+int ksz8_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
+{
+	u8 ctrl, data;
+	const u16 *regs;
+	u8 p = phy;
+	int ret;
+
+	regs = dev->info->regs;
+
+	switch (reg) {
+	case MII_BMCR:
+		ret = ksz8_w_phy_bmcr(dev, p, val);
 		if (ret)
 			return ret;
 
-		data = restart;
-		if (val & KSZ886X_BMCR_DISABLE_LED)
-			data |= PORT_LED_OFF;
-		else
-			data &= ~PORT_LED_OFF;
-		if (val & KSZ886X_BMCR_DISABLE_TRANSMIT)
-			data |= PORT_TX_DISABLE;
-		else
-			data &= ~PORT_TX_DISABLE;
-		if (val & BMCR_ANRESTART)
-			data |= PORT_AUTO_NEG_RESTART;
-		else
-			data &= ~(PORT_AUTO_NEG_RESTART);
-		if (val & BMCR_PDOWN)
-			data |= PORT_POWER_DOWN;
-		else
-			data &= ~PORT_POWER_DOWN;
-		if (val & KSZ886X_BMCR_DISABLE_AUTO_MDIX)
-			data |= PORT_AUTO_MDIX_DISABLE;
-		else
-			data &= ~PORT_AUTO_MDIX_DISABLE;
-		if (val & KSZ886X_BMCR_FORCE_MDI)
-			data |= PORT_FORCE_MDIX;
-		else
-			data &= ~PORT_FORCE_MDIX;
-		if (val & BMCR_LOOPBACK)
-			data |= PORT_PHY_LOOPBACK;
-		else
-			data &= ~PORT_PHY_LOOPBACK;
 
-		if (data != restart) {
-			ret = ksz_pwrite8(dev, p, regs[P_NEG_RESTART_CTRL],
-					  data);
-			if (ret)
-				return ret;
-		}
 		break;
 	case MII_ADVERTISE:
 		ret = ksz_pread8(dev, p, regs[P_LOCAL_CTRL], &ctrl);
-- 
2.39.2

