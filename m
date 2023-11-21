Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55617F3249
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbjKUPYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234324AbjKUPYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:24:42 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107CDDD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:24:36 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1r5Sc0-000609-I4; Tue, 21 Nov 2023 16:24:28 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1r5Sbz-00Ac95-EN; Tue, 21 Nov 2023 16:24:27 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <ore@pengutronix.de>)
        id 1r5Sbz-00HZg5-1F;
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
Subject: [PATCH net-next v1 3/3] net: dsa: microchip: Fix PHY loopback configuration for KSZ8794 and KSZ8873
Date:   Tue, 21 Nov 2023 16:24:26 +0100
Message-Id: <20231121152426.4188456-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231121152426.4188456-1-o.rempel@pengutronix.de>
References: <20231121152426.4188456-1-o.rempel@pengutronix.de>
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

Correct the PHY loopback bit handling in the ksz8_w_phy_bmcr and
ksz8_r_phy_bmcr functions for KSZ8794 and KSZ8873 variants in the ksz8795
driver. Previously, the code erroneously used Bit 7 of port register 0xD
for both chip variants, which is actually for LED configuration. This
update ensures the correct registers and bits are used for the PHY
loopback feature:

- For KSZ8794: Use 0xF / Bit 7.
- For KSZ8873: Use 0xD / Bit 0.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz8795.c     | 39 +++++++++++++++++++------
 drivers/net/dsa/microchip/ksz8795_reg.h |  1 +
 2 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index 4c1e21fd87da..5b223d472548 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -731,16 +731,25 @@ static int ksz8_r_phy_bmcr(struct ksz_device *dev, int port, u16 *val)
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
@@ -994,8 +1003,7 @@ static int ksz8_w_phy_bmcr(struct ksz_device *dev, int port, u16 val)
 
 	restart = 0;
 	restart_mask = PORT_LED_OFF | PORT_TX_DISABLE | PORT_AUTO_NEG_RESTART |
-		PORT_POWER_DOWN | PORT_AUTO_MDIX_DISABLE | PORT_FORCE_MDIX |
-		PORT_PHY_LOOPBACK;
+		PORT_POWER_DOWN | PORT_AUTO_MDIX_DISABLE | PORT_FORCE_MDIX;
 	if (val & KSZ886X_BMCR_DISABLE_LED)
 		restart |= PORT_LED_OFF;
 	if (val & KSZ886X_BMCR_DISABLE_TRANSMIT)
@@ -1008,8 +1016,23 @@ static int ksz8_w_phy_bmcr(struct ksz_device *dev, int port, u16 val)
 		restart |= PORT_AUTO_MDIX_DISABLE;
 	if (val & KSZ886X_BMCR_FORCE_MDI)
 		restart |= PORT_FORCE_MDIX;
-	if (val & BMCR_LOOPBACK)
-		restart |= PORT_PHY_LOOPBACK;
+
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
@@ -1029,8 +1052,6 @@ int ksz8_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
 		ret = ksz8_w_phy_bmcr(dev, p, val);
 		if (ret)
 			return ret;
-
-
 		break;
 	case MII_ADVERTISE:
 		ret = ksz_pread8(dev, p, regs[P_LOCAL_CTRL], &ctrl);
diff --git a/drivers/net/dsa/microchip/ksz8795_reg.h b/drivers/net/dsa/microchip/ksz8795_reg.h
index 3c9dae53e4d8..4c07e0e1fcca 100644
--- a/drivers/net/dsa/microchip/ksz8795_reg.h
+++ b/drivers/net/dsa/microchip/ksz8795_reg.h
@@ -262,6 +262,7 @@
 #define PORT_AUTO_MDIX_DISABLE		BIT(2)
 #define PORT_FORCE_MDIX			BIT(1)
 #define PORT_MAC_LOOPBACK		BIT(0)
+#define KSZ8873_PORT_PHY_LOOPBACK	BIT(0)
 
 #define REG_PORT_1_STATUS_2		0x1E
 #define REG_PORT_2_STATUS_2		0x2E
-- 
2.39.2

