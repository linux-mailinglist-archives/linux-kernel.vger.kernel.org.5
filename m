Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FED7C85B5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjJMMYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjJMMYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:24:31 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03F4BD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:24:28 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qrHD6-00016D-4T; Fri, 13 Oct 2023 14:24:08 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qrHD4-001OKi-W2; Fri, 13 Oct 2023 14:24:07 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <ore@pengutronix.de>)
        id 1qrHD4-00FiNm-2y;
        Fri, 13 Oct 2023 14:24:06 +0200
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
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org
Subject: [PATCH net-next v3 2/7] net: dsa: microchip: Set unique MAC at startup for WoL support
Date:   Fri, 13 Oct 2023 14:24:00 +0200
Message-Id: <20231013122405.3745475-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231013122405.3745475-1-o.rempel@pengutronix.de>
References: <20231013122405.3745475-1-o.rempel@pengutronix.de>
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

Set a unique global MAC address for each switch on the network at system
startup by syncing the switch's global MAC address with the Ethernet
address of the DSA master interface. This is crucial for supporting
Wake-on-LAN (WoL) functionality, as it requires a unique address for
each switch.

Although the operation is performed only at system start and won't sync
if the master Ethernet address changes dynamically, it lays the
groundwork for WoL support by ensuring a unique MAC address for each
switch.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz_common.c | 69 +++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 02fab1adb27f..db0ef4ad181e 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2173,6 +2173,57 @@ static int ksz_pirq_setup(struct ksz_device *dev, u8 p)
 	return ksz_irq_common_setup(dev, pirq);
 }
 
+/**
+ * ksz_cmn_write_global_mac_addr - Write global MAC address to switch.
+ * @dev: The device structure.
+ * @addr: Pointer to MAC address.
+ *
+ * This function programs the switch's MAC address register with the given
+ * MAC address. The global MAC address is used as the source address in MAC
+ * pause control frames, for HSR self-address filtering, Wake-on-LAN (WoL),
+ * and for self-address filtering purposes.
+ *
+ * Return: 0 on success, or an error code on failure.
+ */
+static int ksz_cmn_write_global_mac_addr(struct ksz_device *dev,
+					 const unsigned char *addr)
+{
+	const u16 *regs = dev->info->regs;
+	int i, ret;
+
+	for (i = 0; i < ETH_ALEN; i++) {
+		ret = ksz_write8(dev, regs[REG_SW_MAC_ADDR] + i, addr[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * ksz_cmn_set_default_switch_mac_addr - Set the switch's global MAC address
+ *                                       from master port.
+ * @dev: The device structure.
+ *
+ * This function retrieves the MAC address from the master network device
+ * associated with the CPU port and writes it to the switch's global MAC
+ * address register.
+ *
+ * Return: 0 on success, or an error code on failure.
+ */
+static int ksz_cmn_set_default_switch_mac_addr(struct ksz_device *dev)
+{
+	struct dsa_switch *ds = dev->ds;
+	struct net_device *master;
+
+	/* use CPU port to get master net device because it is guaranteed
+	 * to be a valid port
+	 */
+	master = dsa_port_to_master(dsa_to_port(ds, dev->cpu_port));
+
+	return ksz_cmn_write_global_mac_addr(dev, master->dev_addr);
+}
+
 static int ksz_setup(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
@@ -2194,6 +2245,16 @@ static int ksz_setup(struct dsa_switch *ds)
 		return ret;
 	}
 
+	/* Set switch MAC address from master port.
+	 * In the current implementation, this operation is only
+	 * performed during system start and will not sync if the master
+	 * Ethernet address changes dynamically thereafter. The global MAC
+	 * address still can be overwritten for HSR use cases.
+	 */
+	ret = ksz_cmn_set_default_switch_mac_addr(dev);
+	if (ret)
+		return ret;
+
 	/* set broadcast storm protection 10% rate */
 	regmap_update_bits(ksz_regmap_16(dev), regs[S_BROADCAST_CTRL],
 			   BROADCAST_STORM_RATE,
@@ -3572,8 +3633,6 @@ static int ksz_switch_macaddr_get(struct dsa_switch *ds, int port,
 	const unsigned char *addr = slave->dev_addr;
 	struct ksz_switch_macaddr *switch_macaddr;
 	struct ksz_device *dev = ds->priv;
-	const u16 *regs = dev->info->regs;
-	int i;
 
 	/* Make sure concurrent MAC address changes are blocked */
 	ASSERT_RTNL();
@@ -3599,11 +3658,7 @@ static int ksz_switch_macaddr_get(struct dsa_switch *ds, int port,
 	refcount_set(&switch_macaddr->refcount, 1);
 	dev->switch_macaddr = switch_macaddr;
 
-	/* Program the switch MAC address to hardware */
-	for (i = 0; i < ETH_ALEN; i++)
-		ksz_write8(dev, regs[REG_SW_MAC_ADDR] + i, addr[i]);
-
-	return 0;
+	return ksz_cmn_write_global_mac_addr(dev, addr);
 }
 
 static void ksz_switch_macaddr_put(struct dsa_switch *ds)
-- 
2.39.2

