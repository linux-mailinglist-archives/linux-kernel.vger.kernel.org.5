Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C1975AFBB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjGTN0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjGTN0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:26:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11740210B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:26:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qMTfL-0007aN-QI; Thu, 20 Jul 2023 15:25:59 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qMTfK-000qcF-DI; Thu, 20 Jul 2023 15:25:58 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <ore@pengutronix.de>)
        id 1qMTfJ-000Ezt-15;
        Thu, 20 Jul 2023 15:25:57 +0200
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
Subject: [PATCH net-next v1 6/6] net: dsa: microchip: ksz9477: make switch MAC address configurable
Date:   Thu, 20 Jul 2023 15:25:56 +0200
Message-Id: <20230720132556.57562-7-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230720132556.57562-1-o.rempel@pengutronix.de>
References: <20230720132556.57562-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The switch MAC address is used for sending pause frames and for Wake on Magic
Packet. So, make use of local-mac-address property in the switch node
root and configure it in the HW.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz9477.c    | 8 ++++++++
 drivers/net/dsa/microchip/ksz_common.c | 7 +++++++
 drivers/net/dsa/microchip/ksz_common.h | 2 ++
 3 files changed, 17 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 1a3d7ae5970e2..f3c59f5fd4dc2 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1211,6 +1211,14 @@ int ksz9477_setup(struct dsa_switch *ds)
 	if (dev->wakeup_source)
 		ksz_write8(dev, REG_SW_PME_CTRL, PME_ENABLE);
 
+	if (is_valid_ether_addr(dev->mac_addr)) {
+		int i;
+
+		for (i = 0; i < ETH_ALEN; i++)
+			ksz_write8(dev, REG_SW_MAC_ADDR_0 + i,
+				   dev->mac_addr[i]);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 354cc5333675b..b6ad1f2dddf3b 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3686,6 +3686,8 @@ int ksz_switch_register(struct ksz_device *dev)
 	for (port_num = 0; port_num < dev->info->port_cnt; ++port_num)
 		dev->ports[port_num].interface = PHY_INTERFACE_MODE_NA;
 	if (dev->dev->of_node) {
+		const u8 *mac;
+
 		ret = of_get_phy_mode(dev->dev->of_node, &interface);
 		if (ret == 0)
 			dev->compat_interface = interface;
@@ -3720,6 +3722,11 @@ int ksz_switch_register(struct ksz_device *dev)
 
 		dev->wakeup_source = of_property_read_bool(dev->dev->of_node,
 							   "wakeup-source");
+
+		mac = of_get_property(dev->dev->of_node, "local-mac-address",
+				      NULL);
+		if (mac)
+			memcpy(dev->mac_addr, mac, ETH_ALEN);
 	}
 
 	ret = dsa_register_switch(dev->ds);
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index b67bb9b4631ea..adedc95c60fac 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -171,6 +171,8 @@ struct ksz_device {
 	struct mutex lock_irq;		/* IRQ Access */
 	struct ksz_irq girq;
 	struct ksz_ptp_data ptp_data;
+
+	u8 mac_addr[ETH_ALEN];
 };
 
 /* List of supported models */
-- 
2.39.2

