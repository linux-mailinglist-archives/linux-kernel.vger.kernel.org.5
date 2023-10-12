Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358997C6611
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377515AbjJLGzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377705AbjJLGzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:55:35 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEE3DD
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:55:32 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qqpb7-0000qa-RL; Thu, 12 Oct 2023 08:55:05 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qqpb6-0015L3-WB; Thu, 12 Oct 2023 08:55:05 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <ore@pengutronix.de>)
        id 1qqpb6-00CHm7-2z;
        Thu, 12 Oct 2023 08:55:04 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        kernel test robot <lkp@intel.com>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        netdev@vger.kernel.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH net-next v2 2/3] net: dsa: microchip: ksz8: Enable MIIM PHY Control reg access
Date:   Thu, 12 Oct 2023 08:55:01 +0200
Message-Id: <20231012065502.2928220-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231012065502.2928220-1-o.rempel@pengutronix.de>
References: <20231012065502.2928220-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide access to MIIM PHY Control register (Reg. 31) through
ksz8_r_phy_ctrl() and ksz8_w_phy_ctrl() functions. Necessary for
upcoming micrel.c patch to address forced link mode configuration.

Closes: https://lore.kernel.org/oe-kbuild-all/202310112224.iYgvjBUy-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz8795.c | 86 ++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index 91aba470fb2f..4bf4d67557dc 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -632,6 +632,50 @@ static void ksz8_w_vlan_table(struct ksz_device *dev, u16 vid, u16 vlan)
 	ksz8_w_table(dev, TABLE_VLAN, addr, buf);
 }
 
+/**
+ * ksz8_r_phy_ctrl - Translates and reads from the SMI interface to a MIIM PHY
+ *		     Control register (Reg. 31).
+ * @dev: The KSZ device instance.
+ * @port: The port number to be read.
+ * @val: The value read from the SMI interface.
+ *
+ * This function reads the SMI interface and translates the hardware register
+ * bit values into their corresponding control settings for a MIIM PHY Control
+ * register.
+ *
+ * Return: 0 on success, error code on failure.
+ */
+static int ksz8_r_phy_ctrl(struct ksz_device *dev, int port, u16 *val)
+{
+	const u16 *regs = dev->info->regs;
+	u8 reg_val;
+	int ret;
+
+	*val = 0;
+
+	ret = ksz_pread8(dev, port, regs[P_LINK_STATUS], &reg_val);
+	if (ret < 0)
+		return ret;
+
+	if (reg_val & PORT_MDIX_STATUS)
+		*val |= KSZ886X_CTRL_MDIX_STAT;
+
+	ret = ksz_pread8(dev, port, REG_PORT_LINK_MD_CTRL, &reg_val);
+	if (ret < 0)
+		return ret;
+
+	if (reg_val & PORT_FORCE_LINK)
+		*val |= KSZ886X_CTRL_FORCE_LINK;
+
+	if (reg_val & PORT_POWER_SAVING)
+		*val |= KSZ886X_CTRL_PWRSAVE;
+
+	if (reg_val & PORT_PHY_REMOTE_LOOPBACK)
+		*val |= KSZ886X_CTRL_REMOTE_LOOPBACK;
+
+	return 0;
+}
+
 int ksz8_r_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 *val)
 {
 	u8 restart, speed, ctrl, link;
@@ -769,12 +813,10 @@ int ksz8_r_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 *val)
 				FIELD_GET(PORT_CABLE_FAULT_COUNTER_L, val2));
 		break;
 	case PHY_REG_PHY_CTRL:
-		ret = ksz_pread8(dev, p, regs[P_LINK_STATUS], &link);
+		ret = ksz8_r_phy_ctrl(dev, p, &data);
 		if (ret)
 			return ret;
 
-		if (link & PORT_MDIX_STATUS)
-			data |= KSZ886X_CTRL_MDIX_STAT;
 		break;
 	default:
 		processed = false;
@@ -786,6 +828,38 @@ int ksz8_r_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 *val)
 	return 0;
 }
 
+/**
+ * ksz8_w_phy_ctrl - Translates and writes to the SMI interface from a MIIM PHY
+ *		     Control register (Reg. 31).
+ * @dev: The KSZ device instance.
+ * @port: The port number to be configured.
+ * @val: The register value to be written.
+ *
+ * This function translates control settings from a MIIM PHY Control register
+ * into their corresponding hardware register bit values for the SMI
+ * interface.
+ *
+ * Return: 0 on success, error code on failure.
+ */
+static int ksz8_w_phy_ctrl(struct ksz_device *dev, int port, u16 val)
+{
+	u8 reg_val = 0;
+	int ret;
+
+	if (val & KSZ886X_CTRL_FORCE_LINK)
+		reg_val |= PORT_FORCE_LINK;
+
+	if (val & KSZ886X_CTRL_PWRSAVE)
+		reg_val |= PORT_POWER_SAVING;
+
+	if (val & KSZ886X_CTRL_REMOTE_LOOPBACK)
+		reg_val |= PORT_PHY_REMOTE_LOOPBACK;
+
+	ret = ksz_prmw8(dev, port, REG_PORT_LINK_MD_CTRL, PORT_FORCE_LINK |
+			PORT_POWER_SAVING | PORT_PHY_REMOTE_LOOPBACK, reg_val);
+	return ret;
+}
+
 int ksz8_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
 {
 	u8 restart, speed, ctrl, data;
@@ -926,6 +1000,12 @@ int ksz8_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
 		if (val & PHY_START_CABLE_DIAG)
 			ksz_port_cfg(dev, p, REG_PORT_LINK_MD_CTRL, PORT_START_CABLE_DIAG, true);
 		break;
+
+	case PHY_REG_PHY_CTRL:
+		ret = ksz8_w_phy_ctrl(dev, p, val);
+		if (ret)
+			return ret;
+		break;
 	default:
 		break;
 	}
-- 
2.39.2

