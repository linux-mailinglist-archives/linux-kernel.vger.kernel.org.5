Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C68080A701
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574236AbjLHPNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574320AbjLHPMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:12:48 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88982103
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:12:11 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1rBcWH-0001Lh-Gc; Fri, 08 Dec 2023 16:12:01 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1rBcWG-00ERqP-5p; Fri, 08 Dec 2023 16:12:00 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <ore@pengutronix.de>)
        id 1rBcWG-00BiHM-0N;
        Fri, 08 Dec 2023 16:12:00 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH net-next v1 1/2] net: phy: c45: add genphy_c45_pma_read_ext_abilities() function
Date:   Fri,  8 Dec 2023 16:11:58 +0100
Message-Id: <20231208151159.2791794-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move part of the genphy_c45_pma_read_abilities() code to a separate
function.

Some PHYs do not implement PMA/PMD status 2 register (Register 1.8) but
do implement PMA/PMD extended ability register (Register 1.11). To make
use of it, we need to be able to access this part of code separately.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/phy-c45.c | 129 ++++++++++++++++++++++----------------
 include/linux/phy.h       |   1 +
 2 files changed, 75 insertions(+), 55 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 8e6fd4962c48..747d14bf152c 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -919,6 +919,79 @@ int genphy_c45_pma_baset1_read_abilities(struct phy_device *phydev)
 }
 EXPORT_SYMBOL_GPL(genphy_c45_pma_baset1_read_abilities);
 
+/**
+ * genphy_c45_pma_read_ext_abilities - read supported link modes from PMA
+ * @phydev: target phy_device struct
+ *
+ * Read the supported link modes from the PMA/PMD extended ability register
+ * (Register 1.11).
+ */
+int genphy_c45_pma_read_ext_abilities(struct phy_device *phydev)
+{
+	int val;
+
+	val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_EXTABLE);
+	if (val < 0)
+		return val;
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseLRM_Full_BIT,
+			 phydev->supported,
+			 val & MDIO_PMA_EXTABLE_10GBLRM);
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
+			 phydev->supported,
+			 val & MDIO_PMA_EXTABLE_10GBT);
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT,
+			 phydev->supported,
+			 val & MDIO_PMA_EXTABLE_10GBKX4);
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseKR_Full_BIT,
+			 phydev->supported,
+			 val & MDIO_PMA_EXTABLE_10GBKR);
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+			 phydev->supported,
+			 val & MDIO_PMA_EXTABLE_1000BT);
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
+			 phydev->supported,
+			 val & MDIO_PMA_EXTABLE_1000BKX);
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
+			 phydev->supported,
+			 val & MDIO_PMA_EXTABLE_100BTX);
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT,
+			 phydev->supported,
+			 val & MDIO_PMA_EXTABLE_100BTX);
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT,
+			 phydev->supported,
+			 val & MDIO_PMA_EXTABLE_10BT);
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT,
+			 phydev->supported,
+			 val & MDIO_PMA_EXTABLE_10BT);
+
+	if (val & MDIO_PMA_EXTABLE_NBT) {
+		val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD,
+				   MDIO_PMA_NG_EXTABLE);
+		if (val < 0)
+			return val;
+
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+				 phydev->supported,
+				 val & MDIO_PMA_NG_EXTABLE_2_5GBT);
+
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+				 phydev->supported,
+				 val & MDIO_PMA_NG_EXTABLE_5GBT);
+	}
+
+	if (val & MDIO_PMA_EXTABLE_BT1) {
+		val = genphy_c45_pma_baset1_read_abilities(phydev);
+		if (val < 0)
+			return val;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(genphy_c45_pma_read_ext_abilities);
+
 /**
  * genphy_c45_pma_read_abilities - read supported link modes from PMA
  * @phydev: target phy_device struct
@@ -962,63 +1035,9 @@ int genphy_c45_pma_read_abilities(struct phy_device *phydev)
 			 val & MDIO_PMA_STAT2_10GBER);
 
 	if (val & MDIO_PMA_STAT2_EXTABLE) {
-		val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_EXTABLE);
+		val = genphy_c45_pma_read_ext_abilities(phydev);
 		if (val < 0)
 			return val;
-
-		linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseLRM_Full_BIT,
-				 phydev->supported,
-				 val & MDIO_PMA_EXTABLE_10GBLRM);
-		linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
-				 phydev->supported,
-				 val & MDIO_PMA_EXTABLE_10GBT);
-		linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT,
-				 phydev->supported,
-				 val & MDIO_PMA_EXTABLE_10GBKX4);
-		linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseKR_Full_BIT,
-				 phydev->supported,
-				 val & MDIO_PMA_EXTABLE_10GBKR);
-		linkmode_mod_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
-				 phydev->supported,
-				 val & MDIO_PMA_EXTABLE_1000BT);
-		linkmode_mod_bit(ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
-				 phydev->supported,
-				 val & MDIO_PMA_EXTABLE_1000BKX);
-
-		linkmode_mod_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
-				 phydev->supported,
-				 val & MDIO_PMA_EXTABLE_100BTX);
-		linkmode_mod_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT,
-				 phydev->supported,
-				 val & MDIO_PMA_EXTABLE_100BTX);
-
-		linkmode_mod_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT,
-				 phydev->supported,
-				 val & MDIO_PMA_EXTABLE_10BT);
-		linkmode_mod_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT,
-				 phydev->supported,
-				 val & MDIO_PMA_EXTABLE_10BT);
-
-		if (val & MDIO_PMA_EXTABLE_NBT) {
-			val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD,
-					   MDIO_PMA_NG_EXTABLE);
-			if (val < 0)
-				return val;
-
-			linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
-					 phydev->supported,
-					 val & MDIO_PMA_NG_EXTABLE_2_5GBT);
-
-			linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
-					 phydev->supported,
-					 val & MDIO_PMA_NG_EXTABLE_5GBT);
-		}
-
-		if (val & MDIO_PMA_EXTABLE_BT1) {
-			val = genphy_c45_pma_baset1_read_abilities(phydev);
-			if (val < 0)
-				return val;
-		}
 	}
 
 	/* This is optional functionality. If not supported, we may get an error
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 6e7ebcc50b85..dbb5e13e3e1b 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1866,6 +1866,7 @@ int genphy_c45_an_config_aneg(struct phy_device *phydev);
 int genphy_c45_an_disable_aneg(struct phy_device *phydev);
 int genphy_c45_read_mdix(struct phy_device *phydev);
 int genphy_c45_pma_read_abilities(struct phy_device *phydev);
+int genphy_c45_pma_read_ext_abilities(struct phy_device *phydev);
 int genphy_c45_pma_baset1_read_abilities(struct phy_device *phydev);
 int genphy_c45_read_eee_abilities(struct phy_device *phydev);
 int genphy_c45_pma_baset1_read_master_slave(struct phy_device *phydev);
-- 
2.39.2

