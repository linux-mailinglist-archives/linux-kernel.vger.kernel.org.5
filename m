Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553BD7D2E6F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbjJWJeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjJWJeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:34:08 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76834FC
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:34:06 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qurJi-0000DG-0l; Mon, 23 Oct 2023 11:33:46 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qurJh-003fwx-3U; Mon, 23 Oct 2023 11:33:45 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <ore@pengutronix.de>)
        id 1qurJg-009wdo-3D;
        Mon, 23 Oct 2023 11:33:45 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org
Subject: [PATCH net-next v7 8/9] net: dsa: microchip: Refactor switch shutdown routine for WoL preparation
Date:   Mon, 23 Oct 2023 11:33:42 +0200
Message-Id: <20231023093343.2370248-9-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231023093343.2370248-1-o.rempel@pengutronix.de>
References: <20231023093343.2370248-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Centralize the switch shutdown routine in a dedicated function,
ksz_switch_shutdown(), to enhance code maintainability and reduce
redundancy. This change abstracts the common shutdown operations
previously duplicated in ksz9477_i2c_shutdown() and ksz_spi_shutdown().

This refactoring is a preparatory step for an upcoming patch to avoid
reset on shutdown if Wake-on-LAN (WoL) is enabled.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/microchip/ksz9477_i2c.c |  5 +----
 drivers/net/dsa/microchip/ksz_common.c  | 19 +++++++++++++++++++
 drivers/net/dsa/microchip/ksz_common.h  |  1 +
 drivers/net/dsa/microchip/ksz_spi.c     |  5 +----
 4 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz9477_i2c.c b/drivers/net/dsa/microchip/ksz9477_i2c.c
index 2710afad4f3a..cac4a607e54a 100644
--- a/drivers/net/dsa/microchip/ksz9477_i2c.c
+++ b/drivers/net/dsa/microchip/ksz9477_i2c.c
@@ -66,10 +66,7 @@ static void ksz9477_i2c_shutdown(struct i2c_client *i2c)
 	if (!dev)
 		return;
 
-	if (dev->dev_ops->reset)
-		dev->dev_ops->reset(dev);
-
-	dsa_switch_shutdown(dev->ds);
+	ksz_switch_shutdown(dev);
 
 	i2c_set_clientdata(i2c, NULL);
 }
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 58ba1e6ff75f..7d0c7a32b8d7 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3845,6 +3845,25 @@ struct ksz_device *ksz_switch_alloc(struct device *base, void *priv)
 }
 EXPORT_SYMBOL(ksz_switch_alloc);
 
+/**
+ * ksz_switch_shutdown - Shutdown routine for the switch device.
+ * @dev: The switch device structure.
+ *
+ * This function is responsible for initiating a shutdown sequence for the
+ * switch device. It invokes the reset operation defined in the device
+ * operations, if available, to reset the switch. Subsequently, it calls the
+ * DSA framework's shutdown function to ensure a proper shutdown of the DSA
+ * switch.
+ */
+void ksz_switch_shutdown(struct ksz_device *dev)
+{
+	if (dev->dev_ops->reset)
+		dev->dev_ops->reset(dev);
+
+	dsa_switch_shutdown(dev->ds);
+}
+EXPORT_SYMBOL(ksz_switch_shutdown);
+
 static void ksz_parse_rgmii_delay(struct ksz_device *dev, int port_num,
 				  struct device_node *port_dn)
 {
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 06996813f9a8..14b4828f80a1 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -400,6 +400,7 @@ extern const struct ksz_chip_data ksz_switch_chips[];
 int ksz_switch_macaddr_get(struct dsa_switch *ds, int port,
 			   struct netlink_ext_ack *extack);
 void ksz_switch_macaddr_put(struct dsa_switch *ds);
+void ksz_switch_shutdown(struct ksz_device *dev);
 
 /* Common register access functions */
 static inline struct regmap *ksz_regmap_8(struct ksz_device *dev)
diff --git a/drivers/net/dsa/microchip/ksz_spi.c b/drivers/net/dsa/microchip/ksz_spi.c
index 279338451621..6f6d878e742c 100644
--- a/drivers/net/dsa/microchip/ksz_spi.c
+++ b/drivers/net/dsa/microchip/ksz_spi.c
@@ -114,10 +114,7 @@ static void ksz_spi_shutdown(struct spi_device *spi)
 	if (!dev)
 		return;
 
-	if (dev->dev_ops->reset)
-		dev->dev_ops->reset(dev);
-
-	dsa_switch_shutdown(dev->ds);
+	ksz_switch_shutdown(dev);
 
 	spi_set_drvdata(spi, NULL);
 }
-- 
2.39.2

