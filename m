Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9902B7F5B23
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjKWJhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKWJhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:37:52 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F241A4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 01:37:55 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50aab20e828so897589e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 01:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700732273; x=1701337073; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OZAfhO4KgnkBDD08sObhUKJ1ppADzDCKAjigAvfm3O0=;
        b=DbijjyPkLqHEO6O8Ji2sXSRoSSI91FFz/MSRxedJ4FLJllrfEhahLUsNAnZYNBy1F4
         fHpNWuNINNpdh079gf7+8CBYZrux36vtygRo1jXLd6PiLh6yKdqPQ2VwjIIOhOvAMS8r
         hM3SuPVB5u+lSqB4oqlDB+N9gR5F52F61EwqVvJg7b1ZblSsemiaEUcMCH3W+fPUDuS4
         BRZJgxSdH3om2oYZi6YRFVxqKO5yJMEsvrDzo47qcCe9W2EYiDs1PNJv/T62y/x+14W7
         z8YHnLHtBuhJyMZpzvi11+3yNJkGc7K6ynMcrIOcqp+I7o5lu8c98DO0oluiPo0uEjvf
         1jmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700732273; x=1701337073;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OZAfhO4KgnkBDD08sObhUKJ1ppADzDCKAjigAvfm3O0=;
        b=Rkzd0u0nvahRGSbXTzt3H6Uh+JFAglPHHUDllWpzgwmc14eJJ/CH6cJcbqiaJJ2a/S
         HYHmehqr74kbnV0ooJNMJ/GYHd/I0vA+PZv+U2JzqUryk4qDsu7poyg8TUKWhWdzUxg8
         IoZEMBlTcfH37FyN6sSUAdi5dGzttirre5Pngu1sibi2tMo3cd+JmVv9ds9DcAwFEfos
         uTcGo0BD6QirgFzB8xoKdMqLtVSnDNj0KK0xqcc82q1xAA9cs6PMX6J4yzX1hdLZzJlJ
         WCXXRnJbZVPNYM7Zu4G7FTAKMcWA4zSkB6SfYwFmsS27nXJ5fEUjHfWLnx/jJ4KjXcRD
         OM3g==
X-Gm-Message-State: AOJu0YyNG3hZRhFtrb2cH2R2P+9BW7m5zCcY/4BT+7YPvKzz5qHxdy6t
        p4KbrPGjXp+nIaZoxnBkvjW3uDep6pzkaidioNU=
X-Google-Smtp-Source: AGHT+IE4KFNPj71t7LzUMLrsmrNTA9KI3MQlDM/l0UKBOvx+4gac9BZROsN8X7lgp4kEk8jSXY1Oow==
X-Received: by 2002:a19:2d43:0:b0:503:1913:ed8e with SMTP id t3-20020a192d43000000b005031913ed8emr3313563lft.61.1700732273009;
        Thu, 23 Nov 2023 01:37:53 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id i14-20020a056512006e00b0050a711c197dsm138014lfo.232.2023.11.23.01.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 01:37:52 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Nov 2023 10:37:48 +0100
Subject: [PATCH RFC] net: dsa: mv88e6xxx: Support LED control
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231123-mv88e6xxx-leds-v1-1-3c379b3d23fb@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGsdX2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDQyNj3dwyC4tUs4qKCt2c1JRi3SSLJMskY0OztDRLCyWgpoKi1LTMCrC
 B0UpBbs5KsbW1AOZY/aBlAAAA
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Tim Harvey <tharvey@gateworks.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds control over the hardware LEDs in the Marvell
MV88E6xxx DSA switch and enables it for MV88E6352.

This fixes an imminent problem on the Inteno XG6846 which
has a WAN LED that simply do not work with hardware
defaults: driver amendment is necessary.

The patch is modeled after Christian Marangis LED support
code for the QCA8k DSA switch, I got help with the register
definitions from Tim Harvey.

After this patch it is possible to activate hardware link
indication like this (or with a similar script):

  cd /sys/class/leds/Marvell\ 88E6352:05:00:green:wan/
  echo netdev > trigger
  echo 1 > link

This makes the green link indicator come up on any link
speed. It is also possible to be more elaborate, like this:

  cd /sys/class/leds/Marvell\ 88E6352:05:00:green:wan/
  echo netdev > trigger
  echo 1 > link_1000
  cd /sys/class/leds/Marvell\ 88E6352:05:01:amber:wan/
  echo netdev > trigger
  echo 1 > link_100

Making the green LED come on for a gigabit link and the
amber LED come on for a 100 mbit link.

After the previous series rewriting the MV88E6xxx DT
bindings to use YAML a "leds" subnode is already valid
for each port, in my scratch device tree it looks like
this:

   leds {
     #address-cells = <1>;
     #size-cells = <0>;

     led@0 {
       reg = <0>;
       color = <LED_COLOR_ID_GREEN>;
       function = LED_FUNCTION_LAN;
       default-state = "off";
       linux,default-trigger = "netdev";
     };
     led@1 {
       reg = <1>;
       color = <LED_COLOR_ID_AMBER>;
       function = LED_FUNCTION_LAN;
       default-state = "off";
     };
   };

This DT config is not yet configuring everything: the netdev
default trigger is assigned by the hw acceleration callbacks are
not called, and there is no way to set the netdev sub-trigger
type from the device tree, such as if you want a gigabit link
indicator. This has to be done from userspace at this point.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/dsa/mv88e6xxx/Makefile |   1 +
 drivers/net/dsa/mv88e6xxx/chip.c   |  36 +-
 drivers/net/dsa/mv88e6xxx/chip.h   |  12 +
 drivers/net/dsa/mv88e6xxx/leds.c   | 741 +++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/port.c   |   1 +
 drivers/net/dsa/mv88e6xxx/port.h   | 125 +++++++
 6 files changed, 914 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/Makefile b/drivers/net/dsa/mv88e6xxx/Makefile
index a9a9651187db..6720d9303914 100644
--- a/drivers/net/dsa/mv88e6xxx/Makefile
+++ b/drivers/net/dsa/mv88e6xxx/Makefile
@@ -9,6 +9,7 @@ mv88e6xxx-objs += global2.o
 mv88e6xxx-objs += global2_avb.o
 mv88e6xxx-objs += global2_scratch.o
 mv88e6xxx-$(CONFIG_NET_DSA_MV88E6XXX_PTP) += hwtstamp.o
+mv88e6xxx-objs += leds.o
 mv88e6xxx-objs += pcs-6185.o
 mv88e6xxx-objs += pcs-6352.o
 mv88e6xxx-objs += pcs-639x.o
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 42b1acaca33a..a09d3a214469 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -27,6 +27,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_mdio.h>
 #include <linux/platform_data/mv88e6xxx.h>
+#include <linux/property.h>
 #include <linux/netdevice.h>
 #include <linux/gpio/consumer.h>
 #include <linux/phylink.h>
@@ -3153,14 +3154,44 @@ static int mv88e6xxx_setup_upstream_port(struct mv88e6xxx_chip *chip, int port)
 static int mv88e6xxx_setup_port(struct mv88e6xxx_chip *chip, int port)
 {
 	struct device_node *phy_handle = NULL;
+	struct fwnode_handle *ports_fwnode;
+	struct fwnode_handle *port_fwnode;
 	struct dsa_switch *ds = chip->ds;
+	struct mv88e6xxx_port *p;
 	struct dsa_port *dp;
 	int tx_amp;
 	int err;
 	u16 reg;
+	u32 val;
+
+	p = &chip->ports[port];
+	p->chip = chip;
+	p->port = port;
+
+	/* Look up corresponding fwnode if any */
+	ports_fwnode = device_get_named_child_node(chip->dev, "ethernet-ports");
+	if (!ports_fwnode)
+		ports_fwnode = device_get_named_child_node(chip->dev, "ports");
+	if (ports_fwnode) {
+		fwnode_for_each_child_node(ports_fwnode, port_fwnode) {
+			if (fwnode_property_read_u32(port_fwnode, "reg", &val))
+				continue;
+			if (val == port) {
+				p->fwnode = port_fwnode;
+				p->fiber = fwnode_property_present(port_fwnode, "sfp");
+				break;
+			}
+		}
+	} else {
+		dev_info(chip->dev,
+			 "no ethernet ports node defined for the device\n");
+	}
 
-	chip->ports[port].chip = chip;
-	chip->ports[port].port = port;
+	if (chip->info->ops->port_setup_leds) {
+		err = chip->info->ops->port_setup_leds(chip, port);
+		if (err && err != -EOPNOTSUPP)
+			return err;
+	}
 
 	err = mv88e6xxx_port_setup_mac(chip, port, LINK_UNFORCED,
 				       SPEED_UNFORCED, DUPLEX_UNFORCED,
@@ -5148,6 +5179,7 @@ static const struct mv88e6xxx_ops mv88e6352_ops = {
 	.port_disable_learn_limit = mv88e6xxx_port_disable_learn_limit,
 	.port_disable_pri_override = mv88e6xxx_port_disable_pri_override,
 	.port_get_cmode = mv88e6352_port_get_cmode,
+	.port_setup_leds = mv88e6xxx_port_setup_leds,
 	.port_setup_message_port = mv88e6xxx_setup_message_port,
 	.stats_snapshot = mv88e6320_g1_stats_snapshot,
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 44383a03ef2f..9de6a57e8ba9 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -13,7 +13,9 @@
 #include <linux/irq.h>
 #include <linux/gpio/consumer.h>
 #include <linux/kthread.h>
+#include <linux/leds.h>
 #include <linux/phy.h>
+#include <linux/property.h>
 #include <linux/ptp_clock_kernel.h>
 #include <linux/timecounter.h>
 #include <net/dsa.h>
@@ -275,6 +277,7 @@ struct mv88e6xxx_vlan {
 struct mv88e6xxx_port {
 	struct mv88e6xxx_chip *chip;
 	int port;
+	struct fwnode_handle *fwnode;
 	struct mv88e6xxx_vlan bridge_pvid;
 	u64 serdes_stats[2];
 	u64 atu_member_violation;
@@ -289,6 +292,12 @@ struct mv88e6xxx_port {
 	struct devlink_region *region;
 	void *pcs_private;
 
+	/* LED related information */
+	bool fiber;
+	struct led_classdev led0;
+	struct led_classdev led1;
+	u16 ledreg;
+
 	/* MacAuth Bypass control flag */
 	bool mab;
 };
@@ -555,6 +564,9 @@ struct mv88e6xxx_ops {
 			      phy_interface_t mode);
 	int (*port_get_cmode)(struct mv88e6xxx_chip *chip, int port, u8 *cmode);
 
+	/* LED control */
+	int (*port_setup_leds)(struct mv88e6xxx_chip *chip, int port);
+
 	/* Some devices have a per port register indicating what is
 	 * the upstream port this port should forward to.
 	 */
diff --git a/drivers/net/dsa/mv88e6xxx/leds.c b/drivers/net/dsa/mv88e6xxx/leds.c
new file mode 100644
index 000000000000..cc11773bdf9f
--- /dev/null
+++ b/drivers/net/dsa/mv88e6xxx/leds.c
@@ -0,0 +1,741 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/bitfield.h>
+#include <linux/leds.h>
+#include <linux/property.h>
+
+#include "chip.h"
+#include "global2.h"
+#include "port.h"
+
+/* Offset 0x16: LED control */
+
+static int mv88e6xxx_led_brightness_set(struct mv88e6xxx_port *p, int led,
+					int brightness)
+{
+	u16 reg;
+
+	reg = p->ledreg;
+
+	if (led == 1)
+		reg &= ~MV88E6XXX_PORT_LED_CONTROL_LED1_SEL_MASK;
+	else
+		reg &= ~MV88E6XXX_PORT_LED_CONTROL_LED0_SEL_MASK;
+
+	if (brightness) {
+		/* Selector 0x0f == Force LED ON */
+		if (led == 1)
+			reg |= MV88E6XXX_PORT_LED_CONTROL_LED1_SELF;
+		else
+			reg |= MV88E6XXX_PORT_LED_CONTROL_LED0_SELF;
+	} else {
+		/* Selector 0x0e == Force LED OFF */
+		if (led == 1)
+			reg |= MV88E6XXX_PORT_LED_CONTROL_LED1_SELE;
+		else
+			reg |= MV88E6XXX_PORT_LED_CONTROL_LED0_SELE;
+	}
+
+	p->ledreg = reg;
+
+	reg |= MV88E6XXX_PORT_LED_CONTROL_UPDATE;
+	reg |= MV88E6XXX_PORT_LED_CONTROL_POINTER_LED01_CTRL;
+
+	return mv88e6xxx_port_write(p->chip, p->port, MV88E6XXX_PORT_LED_CONTROL, reg);
+}
+
+static int mv88e6xxx_led0_brightness_set_blocking(struct led_classdev *ldev,
+						 enum led_brightness brightness)
+{
+	struct mv88e6xxx_port *p = container_of(ldev, struct mv88e6xxx_port, led0);
+	int err;
+
+	mv88e6xxx_reg_lock(p->chip);
+	err = mv88e6xxx_led_brightness_set(p, 0, brightness);
+	mv88e6xxx_reg_unlock(p->chip);
+
+	return err;
+}
+
+static int mv88e6xxx_led1_brightness_set_blocking(struct led_classdev *ldev,
+						 enum led_brightness brightness)
+{
+	struct mv88e6xxx_port *p = container_of(ldev, struct mv88e6xxx_port, led1);
+	int err;
+
+	mv88e6xxx_reg_lock(p->chip);
+	err = mv88e6xxx_led_brightness_set(p, 1, brightness);
+	mv88e6xxx_reg_unlock(p->chip);
+
+	return err;
+}
+
+struct mv88e6xxx_led_hwconfig {
+	int led;
+	u8 portmask;
+	unsigned long rules;
+	bool fiber;
+	bool blink_activity;
+	u16 selector;
+};
+
+/* The following is a lookup table to check what rules we can support on a
+ * certain LED given restrictions such as that some rules only work with fiber
+ * (SFP) connections and some blink on activity by default.
+ */
+#define MV88E6XXX_PORTS_0_3 (BIT(0)|BIT(1)|BIT(2)|BIT(3))
+#define MV88E6XXX_PORTS_4_5 (BIT(4)|BIT(5))
+#define MV88E6XXX_PORT_4 BIT(4)
+#define MV88E6XXX_PORT_5 BIT(5)
+
+/* Entries are listed in selector order */
+static const struct mv88e6xxx_led_hwconfig mv88e6xxx_led_hwconfigs[] = {
+	{
+		.led = 0,
+		.portmask = MV88E6XXX_PORT_4,
+		.rules = BIT(TRIGGER_NETDEV_LINK),
+		.blink_activity = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED0_SEL0,
+	},
+	{
+		.led = 1,
+		.portmask = MV88E6XXX_PORT_5,
+		.rules = BIT(TRIGGER_NETDEV_LINK_1000),
+		.blink_activity = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED1_SEL0,
+	},
+	{
+		.led = 0,
+		.portmask = MV88E6XXX_PORTS_0_3,
+		.rules = BIT(TRIGGER_NETDEV_LINK_100)|BIT(TRIGGER_NETDEV_LINK_1000),
+		.blink_activity = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED0_SEL1,
+	},
+	{
+		.led = 1,
+		.portmask = MV88E6XXX_PORTS_0_3,
+		.rules = BIT(TRIGGER_NETDEV_LINK_10)|BIT(TRIGGER_NETDEV_LINK_100),
+		.blink_activity = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED1_SEL1,
+	},
+	{
+		.led = 0,
+		.portmask = MV88E6XXX_PORTS_4_5,
+		.rules = BIT(TRIGGER_NETDEV_LINK_100),
+		.blink_activity = true,
+		.fiber = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED0_SEL1,
+	},
+	{
+		.led = 1,
+		.portmask = MV88E6XXX_PORTS_4_5,
+		.rules = BIT(TRIGGER_NETDEV_LINK_1000),
+		.blink_activity = true,
+		.fiber = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED1_SEL1,
+	},
+	{
+		.led = 0,
+		.portmask = MV88E6XXX_PORTS_0_3,
+		.rules = BIT(TRIGGER_NETDEV_LINK_1000),
+		.blink_activity = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED0_SEL2,
+	},
+	{
+		.led = 1,
+		.portmask = MV88E6XXX_PORTS_0_3,
+		.rules = BIT(TRIGGER_NETDEV_LINK_10)|BIT(TRIGGER_NETDEV_LINK_100),
+		.blink_activity = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED1_SEL2,
+	},
+	{
+		.led = 0,
+		.portmask = MV88E6XXX_PORTS_4_5,
+		.rules = BIT(TRIGGER_NETDEV_LINK_1000),
+		.blink_activity = true,
+		.fiber = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED0_SEL2,
+	},
+	{
+		.led = 1,
+		.portmask = MV88E6XXX_PORTS_4_5,
+		.rules = BIT(TRIGGER_NETDEV_LINK_100),
+		.blink_activity = true,
+		.fiber = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED1_SEL2,
+	},
+	{
+		.led = 0,
+		.portmask = MV88E6XXX_PORTS_0_3,
+		.rules = BIT(TRIGGER_NETDEV_LINK),
+		.blink_activity = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED0_SEL3,
+	},
+	{
+		.led = 1,
+		.portmask = MV88E6XXX_PORTS_0_3,
+		.rules = BIT(TRIGGER_NETDEV_LINK_1000),
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED1_SEL3,
+	},
+	{
+		.led = 1,
+		.portmask = MV88E6XXX_PORTS_4_5,
+		.rules = BIT(TRIGGER_NETDEV_LINK),
+		.fiber = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED1_SEL3,
+	},
+	{
+		.led = 1,
+		.portmask = MV88E6XXX_PORT_4,
+		.rules = BIT(TRIGGER_NETDEV_LINK),
+		.blink_activity = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED1_SEL4,
+	},
+	{
+		.led = 1,
+		.portmask = MV88E6XXX_PORT_5,
+		.rules = BIT(TRIGGER_NETDEV_LINK),
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED1_SEL5,
+	},
+	{
+		.led = 0,
+		.portmask = MV88E6XXX_PORTS_0_3,
+		.rules = BIT(TRIGGER_NETDEV_FULL_DUPLEX),
+		.blink_activity = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED0_SEL6,
+	},
+	{
+		.led = 1,
+		.portmask = MV88E6XXX_PORTS_0_3,
+		.rules = BIT(TRIGGER_NETDEV_LINK_10)|BIT(TRIGGER_NETDEV_LINK_1000),
+		.blink_activity = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED1_SEL6,
+	},
+	{
+		.led = 0,
+		.portmask = MV88E6XXX_PORT_4,
+		.rules = BIT(TRIGGER_NETDEV_FULL_DUPLEX),
+		.blink_activity = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED0_SEL6,
+	},
+	{
+		.led = 1,
+		.portmask = MV88E6XXX_PORT_5,
+		.rules = BIT(TRIGGER_NETDEV_FULL_DUPLEX),
+		.blink_activity = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED1_SEL6,
+	},
+	{
+		.led = 0,
+		.portmask = MV88E6XXX_PORTS_0_3,
+		.rules = BIT(TRIGGER_NETDEV_LINK_10)|BIT(TRIGGER_NETDEV_LINK_1000),
+		.blink_activity = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED0_SEL7,
+	},
+	{
+		.led = 1,
+		.portmask = MV88E6XXX_PORTS_0_3,
+		.rules = BIT(TRIGGER_NETDEV_LINK_10)|BIT(TRIGGER_NETDEV_LINK_1000),
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED1_SEL7,
+	},
+	{
+		.led = 0,
+		.portmask = MV88E6XXX_PORTS_0_3,
+		.rules = BIT(TRIGGER_NETDEV_LINK),
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED0_SEL8,
+	},
+	{
+		.led = 1,
+		.portmask = MV88E6XXX_PORTS_0_3,
+		.rules = BIT(TRIGGER_NETDEV_LINK),
+		.blink_activity = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED1_SEL8,
+	},
+	{
+		.led = 0,
+		.portmask = MV88E6XXX_PORT_5,
+		.rules = BIT(TRIGGER_NETDEV_LINK),
+		.blink_activity = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED0_SEL8,
+	},
+	{
+		.led = 0,
+		.portmask = MV88E6XXX_PORTS_0_3,
+		.rules = BIT(TRIGGER_NETDEV_LINK_10),
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED0_SEL9,
+	},
+	{
+		.led = 1,
+		.portmask = MV88E6XXX_PORTS_0_3,
+		.rules = BIT(TRIGGER_NETDEV_LINK_100),
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED1_SEL9,
+	},
+	{
+		.led = 0,
+		.portmask = MV88E6XXX_PORTS_0_3,
+		.rules = BIT(TRIGGER_NETDEV_LINK_10),
+		.blink_activity = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED0_SELA,
+	},
+	{
+		.led = 1,
+		.portmask = MV88E6XXX_PORTS_0_3,
+		.rules = BIT(TRIGGER_NETDEV_LINK_100),
+		.blink_activity = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED1_SELA,
+	},
+	{
+		.led = 0,
+		.portmask = MV88E6XXX_PORTS_0_3,
+		.rules = BIT(TRIGGER_NETDEV_LINK_100)|BIT(TRIGGER_NETDEV_LINK_1000),
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED0_SELB,
+	},
+	{
+		.led = 1,
+		.portmask = MV88E6XXX_PORTS_0_3,
+		.rules = BIT(TRIGGER_NETDEV_LINK_100)|BIT(TRIGGER_NETDEV_LINK_1000),
+		.blink_activity = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED1_SELB,
+	},
+};
+
+/* mv88e6xxx_led_match_selector() - look up the appropriate LED mode selector
+ * @p: port state container
+ * @led: LED number, 0 or 1
+ * @blink_activity: blink the LED (usually blink on indicated activity)
+ * @fiber: the link is connected to fiber such as SFP
+ * @rules: LED status flags from the LED classdev core
+ * @selector: fill in the selector in this parameter with an OR operation
+ */
+static int mv88e6xxx_led_match_selector(struct mv88e6xxx_port *p, int led, bool blink_activity,
+					bool fiber, unsigned long rules, u16 *selector)
+{
+	const struct mv88e6xxx_led_hwconfig *conf;
+	int i;
+
+	/* No rules means we turn the LED off */
+	if (!rules) {
+		if (led == 1)
+			*selector |= MV88E6XXX_PORT_LED_CONTROL_LED1_SELE;
+		else
+			*selector |= MV88E6XXX_PORT_LED_CONTROL_LED0_SELE;
+		return 0;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(mv88e6xxx_led_hwconfigs); i++) {
+		conf = &mv88e6xxx_led_hwconfigs[i];
+
+		if (conf->led != led)
+			continue;
+
+		if (!(conf->portmask & BIT(p->port)))
+			continue;
+
+		if (conf->blink_activity != blink_activity)
+			continue;
+
+		if (conf->fiber != fiber)
+			continue;
+
+		if (conf->rules == rules) {
+			*selector |= conf->selector;
+			return 0;
+		}
+	}
+
+	return -EOPNOTSUPP;
+}
+
+/* mv88e6xxx_led_get_selector() - get the appropriate LED mode selector
+ * @p: port state container
+ * @led: LED number, 0 or 1
+ * @fiber: the link is connected to fiber such as SFP
+ * @rules: LED status flags from the LED classdev core
+ * @selector: fill in the selector in this parameter with an OR operation
+ */
+static int mv88e6xxx_led_get_selector(struct mv88e6xxx_port *p, int led,
+				      bool fiber, unsigned long rules, u16 *selector)
+{
+	int err;
+
+	/* What happens here is that we first try to locate a trigger with solid
+	 * indicator (such as LED is on for a 1000 link) else we try a second
+	 * sweep to find something suitable with a trigger that will blink on
+	 * activity.
+	 */
+	err = mv88e6xxx_led_match_selector(p, led, false, fiber, rules, selector);
+	if (err)
+		return mv88e6xxx_led_match_selector(p, led, true, fiber, rules, selector);
+
+	return 0;
+}
+
+/* Sets up the hardware blinking period */
+static int mv88e6xxx_led_set_blinking_period(struct mv88e6xxx_port *p, int led,
+					     unsigned long *delay_on, unsigned long *delay_off)
+{
+	unsigned long period;
+	u16 reg;
+
+	period = *delay_on + *delay_off;
+
+	reg = 0;
+
+	switch (period) {
+	case 21:
+		reg |= MV88E6XXX_PORT_LED_CONTROL_0x06_BLINK_RATE_21MS;
+		break;
+	case 42:
+		reg |= MV88E6XXX_PORT_LED_CONTROL_0x06_BLINK_RATE_42MS;
+		break;
+	case 84:
+		reg |= MV88E6XXX_PORT_LED_CONTROL_0x06_BLINK_RATE_84MS;
+		break;
+	case 168:
+		reg |= MV88E6XXX_PORT_LED_CONTROL_0x06_BLINK_RATE_168MS;
+		break;
+	case 336:
+		reg |= MV88E6XXX_PORT_LED_CONTROL_0x06_BLINK_RATE_336MS;
+		break;
+	case 672:
+		reg |= MV88E6XXX_PORT_LED_CONTROL_0x06_BLINK_RATE_672MS;
+		break;
+	default:
+		/* Fall back to software blinking */
+		return -EINVAL;
+	}
+
+	/* This is essentially PWM duty cycle: how long time of the period
+	 * will the LED be on. Zero isn't great in most cases.
+	 */
+	switch (*delay_on) {
+	case 0:
+		/* This is usually pretty useless and will make the LED look OFF */
+		reg |= MV88E6XXX_PORT_LED_CONTROL_0x06_PULSE_STRETCH_NONE;
+		break;
+	case 21:
+		reg |= MV88E6XXX_PORT_LED_CONTROL_0x06_PULSE_STRETCH_21MS;
+		break;
+	case 42:
+		reg |= MV88E6XXX_PORT_LED_CONTROL_0x06_PULSE_STRETCH_42MS;
+		break;
+	case 84:
+		reg |= MV88E6XXX_PORT_LED_CONTROL_0x06_PULSE_STRETCH_84MS;
+		break;
+	case 168:
+		reg |= MV88E6XXX_PORT_LED_CONTROL_0x06_PULSE_STRETCH_168MS;
+		break;
+	default:
+		/* Just use something non-zero */
+		reg |= MV88E6XXX_PORT_LED_CONTROL_0x06_PULSE_STRETCH_21MS;
+		*delay_on = 21;
+		break;
+	}
+
+	reg |= MV88E6XXX_PORT_LED_CONTROL_UPDATE;
+	/* Set up blink rate */
+	reg |= MV88E6XXX_PORT_LED_CONTROL_POINTER_STRETCH_BLINK;
+
+	return mv88e6xxx_port_write(p->chip, p->port, MV88E6XXX_PORT_LED_CONTROL, reg);
+}
+
+static int mv88e6xxx_led_blink_set(struct mv88e6xxx_port *p, int led,
+				   unsigned long *delay_on, unsigned long *delay_off)
+{
+	u16 reg;
+	int err;
+
+	/* Choose a sensible default 336 ms (~3 Hz) */
+	if ((*delay_on == 0) && (*delay_off == 0)) {
+		*delay_on = 168;
+		*delay_off = 168;
+	}
+
+	/* No off delay is just on */
+	if (*delay_off == 0)
+		return mv88e6xxx_led_brightness_set(p, led, 1);
+
+	err = mv88e6xxx_led_set_blinking_period(p, led, delay_on, delay_off);
+	if (err)
+		return err;
+
+	reg = p->ledreg;
+
+	if (led == 1)
+		reg &= ~MV88E6XXX_PORT_LED_CONTROL_LED1_SEL_MASK;
+	else
+		reg &= ~MV88E6XXX_PORT_LED_CONTROL_LED0_SEL_MASK;
+
+	/* This will select the forced blinking status */
+	if (led == 1)
+		reg |= MV88E6XXX_PORT_LED_CONTROL_LED1_SELD;
+	else
+		reg |= MV88E6XXX_PORT_LED_CONTROL_LED0_SELD;
+
+	p->ledreg = reg;
+
+	reg |= MV88E6XXX_PORT_LED_CONTROL_UPDATE;
+	reg |= MV88E6XXX_PORT_LED_CONTROL_POINTER_LED01_CTRL;
+
+	return mv88e6xxx_port_write(p->chip, p->port, MV88E6XXX_PORT_LED_CONTROL, reg);
+}
+
+static int mv88e6xxx_led0_blink_set(struct led_classdev *ldev,
+				    unsigned long *delay_on,
+				    unsigned long *delay_off)
+{
+	struct mv88e6xxx_port *p = container_of(ldev, struct mv88e6xxx_port, led0);
+	int err;
+
+	mv88e6xxx_reg_lock(p->chip);
+	err = mv88e6xxx_led_blink_set(p, 0, delay_on, delay_off);
+	mv88e6xxx_reg_unlock(p->chip);
+
+	return err;
+}
+
+static int mv88e6xxx_led1_blink_set(struct led_classdev *ldev,
+				    unsigned long *delay_on,
+				    unsigned long *delay_off)
+{
+	struct mv88e6xxx_port *p = container_of(ldev, struct mv88e6xxx_port, led1);
+	int err;
+
+	mv88e6xxx_reg_lock(p->chip);
+	err = mv88e6xxx_led_blink_set(p, 1, delay_on, delay_off);
+	mv88e6xxx_reg_unlock(p->chip);
+
+	return err;
+}
+
+static int
+mv88e6xxx_led0_hw_control_is_supported(struct led_classdev *ldev, unsigned long rules)
+{
+	struct mv88e6xxx_port *p = container_of(ldev, struct mv88e6xxx_port, led0);
+	u16 selector = 0;
+
+	return mv88e6xxx_led_get_selector(p, 0, p->fiber, rules, &selector);
+}
+
+static int
+mv88e6xxx_led1_hw_control_is_supported(struct led_classdev *ldev, unsigned long rules)
+{
+	struct mv88e6xxx_port *p = container_of(ldev, struct mv88e6xxx_port, led1);
+	u16 selector = 0;
+
+	return mv88e6xxx_led_get_selector(p, 1, p->fiber, rules, &selector);
+}
+
+static int mv88e6xxx_led_hw_control_set(struct mv88e6xxx_port *p,
+					int led, unsigned long rules)
+{
+	u16 reg;
+	int err;
+
+	reg = p->ledreg;
+
+	if (led == 1)
+		reg &= ~MV88E6XXX_PORT_LED_CONTROL_LED1_SEL_MASK;
+	else
+		reg &= ~MV88E6XXX_PORT_LED_CONTROL_LED0_SEL_MASK;
+
+	err = mv88e6xxx_led_get_selector(p, led, p->fiber, rules, &reg);
+	if (err)
+		return err;
+
+	p->ledreg = reg;
+
+	reg |= MV88E6XXX_PORT_LED_CONTROL_UPDATE;
+	reg |= MV88E6XXX_PORT_LED_CONTROL_POINTER_LED01_CTRL;
+
+	if (led == 0)
+		dev_dbg(p->chip->dev, "LED 0 hw control on port %d trigger selector 0x%02x\n",
+			p->port,
+			(unsigned int)(p->ledreg & MV88E6XXX_PORT_LED_CONTROL_LED0_SEL_MASK));
+	else
+		dev_dbg(p->chip->dev, "LED 1 hw control on port %d trigger selector 0x%02x\n",
+			p->port,
+			(unsigned int)(p->ledreg & MV88E6XXX_PORT_LED_CONTROL_LED1_SEL_MASK) >> 4);
+
+	err = mv88e6xxx_port_write(p->chip, p->port, MV88E6XXX_PORT_LED_CONTROL, reg);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int
+mv88e6xxx_led_hw_control_get(struct mv88e6xxx_port *p, int led, unsigned long *rules)
+{
+	/* The hardware register cannot be read: no inital state determined */
+	return -EINVAL;
+}
+
+static int
+mv88e6xxx_led0_hw_control_set(struct led_classdev *ldev, unsigned long rules)
+{
+	struct mv88e6xxx_port *p = container_of(ldev, struct mv88e6xxx_port, led0);
+	int err;
+
+	mv88e6xxx_reg_lock(p->chip);
+	err = mv88e6xxx_led_hw_control_set(p, 0, rules);
+	mv88e6xxx_reg_unlock(p->chip);
+
+	return err;
+}
+
+static int
+mv88e6xxx_led1_hw_control_set(struct led_classdev *ldev, unsigned long rules)
+{
+	struct mv88e6xxx_port *p = container_of(ldev, struct mv88e6xxx_port, led1);
+	int err;
+
+	mv88e6xxx_reg_lock(p->chip);
+	err = mv88e6xxx_led_hw_control_set(p, 1, rules);
+	mv88e6xxx_reg_unlock(p->chip);
+
+	return err;
+}
+
+static int
+mv88e6xxx_led0_hw_control_get(struct led_classdev *ldev, unsigned long *rules)
+{
+	struct mv88e6xxx_port *p = container_of(ldev, struct mv88e6xxx_port, led0);
+
+	return mv88e6xxx_led_hw_control_get(p, 0, rules);
+}
+
+static int
+mv88e6xxx_led1_hw_control_get(struct led_classdev *ldev, unsigned long *rules)
+{
+	struct mv88e6xxx_port *p = container_of(ldev, struct mv88e6xxx_port, led1);
+
+	return mv88e6xxx_led_hw_control_get(p, 1, rules);
+}
+
+static struct device *mv88e6xxx_led_hw_control_get_device(struct mv88e6xxx_port *p)
+{
+	struct dsa_port *dp;
+
+	dp = dsa_to_port(p->chip->ds, p->port);
+	if (!dp)
+		return NULL;
+	if (dp->user)
+		return &dp->user->dev;
+	return NULL;
+}
+
+static struct device *
+mv88e6xxx_led0_hw_control_get_device(struct led_classdev *ldev)
+{
+	struct mv88e6xxx_port *p = container_of(ldev, struct mv88e6xxx_port, led0);
+
+	return mv88e6xxx_led_hw_control_get_device(p);
+}
+
+static struct device *
+mv88e6xxx_led1_hw_control_get_device(struct led_classdev *ldev)
+{
+	struct mv88e6xxx_port *p = container_of(ldev, struct mv88e6xxx_port, led1);
+
+	return mv88e6xxx_led_hw_control_get_device(p);
+}
+
+int mv88e6xxx_port_setup_leds(struct mv88e6xxx_chip *chip, int port)
+{
+	struct fwnode_handle *led = NULL, *leds = NULL;
+	struct led_init_data init_data = { };
+	unsigned long delay_off = 168;
+	unsigned long delay_on = 168;
+	enum led_default_state state;
+	struct mv88e6xxx_port *p;
+	struct led_classdev *l;
+	struct device *dev;
+	u32 led_num;
+	int ret;
+
+	/* LEDs are on ports 1,2,3,4, 5 and 6 (index 0..5), no more */
+	if (port > 5)
+		return -EOPNOTSUPP;
+
+	p = &chip->ports[port];
+	if (!p->fwnode)
+		return 0;
+	p->ledreg = 0;
+
+	dev = chip->dev;
+
+	leds = fwnode_get_named_child_node(p->fwnode, "leds");
+	if (!leds) {
+		dev_info(dev, "No Leds node specified in device tree for port %d!\n",
+			 port);
+		return 0;
+	}
+
+	fwnode_for_each_child_node(leds, led) {
+		/* Reg represent the led number of the port, max 2
+		 * LEDs can be connected to each port, in some designs
+		 * only one LED is connected.
+		 */
+		if (fwnode_property_read_u32(led, "reg", &led_num))
+			continue;
+		if (led_num > 1) {
+			dev_err(dev, "invalid LED specified port %d\n", port);
+			continue;
+		}
+
+		if (led_num == 0)
+			l = &p->led0;
+		else
+			l = &p->led1;
+
+		state = led_init_default_state_get(led);
+		switch (state) {
+		case LEDS_DEFSTATE_ON:
+			l->brightness = 1;
+			mv88e6xxx_led_brightness_set(p, led_num, 1);
+			break;
+		case LEDS_DEFSTATE_KEEP:
+			break;
+		default:
+			l->brightness = 0;
+			mv88e6xxx_led_brightness_set(p, led_num, 0);
+		}
+
+		/* Default blinking period for LEDs */
+		mv88e6xxx_led_set_blinking_period(p, led_num, &delay_on, &delay_off);
+
+		l->max_brightness = 1;
+		if (led_num == 0) {
+			l->brightness_set_blocking = mv88e6xxx_led0_brightness_set_blocking;
+			l->blink_set = mv88e6xxx_led0_blink_set;
+			l->hw_control_is_supported = mv88e6xxx_led0_hw_control_is_supported;
+			l->hw_control_set = mv88e6xxx_led0_hw_control_set;
+			l->hw_control_get = mv88e6xxx_led0_hw_control_get;
+			l->hw_control_get_device = mv88e6xxx_led0_hw_control_get_device;
+		} else {
+			l->brightness_set_blocking = mv88e6xxx_led1_brightness_set_blocking;
+			l->blink_set = mv88e6xxx_led1_blink_set;
+			l->hw_control_is_supported = mv88e6xxx_led1_hw_control_is_supported;
+			l->hw_control_set = mv88e6xxx_led1_hw_control_set;
+			l->hw_control_get = mv88e6xxx_led1_hw_control_get;
+			l->hw_control_get_device = mv88e6xxx_led1_hw_control_get_device;
+		}
+		l->hw_control_trigger = "netdev";
+
+		init_data.default_label = ":port";
+		init_data.fwnode = led;
+		init_data.devname_mandatory = true;
+		init_data.devicename = kasprintf(GFP_KERNEL, "%s:0%d:0%d", chip->info->name,
+						 port, led_num);
+		if (!init_data.devicename)
+			return -ENOMEM;
+
+		ret = devm_led_classdev_register_ext(dev, l, &init_data);
+		if (ret)
+			dev_err(dev, "Failed to init LED %d for port %d", led_num, port);
+
+		kfree(init_data.devicename);
+	}
+
+	return 0;
+}
diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
index 5394a8cf7bf1..d72bba1969f7 100644
--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -12,6 +12,7 @@
 #include <linux/if_bridge.h>
 #include <linux/phy.h>
 #include <linux/phylink.h>
+#include <linux/property.h>
 
 #include "chip.h"
 #include "global2.h"
diff --git a/drivers/net/dsa/mv88e6xxx/port.h b/drivers/net/dsa/mv88e6xxx/port.h
index 86deeb347cbc..723e5f46c7e1 100644
--- a/drivers/net/dsa/mv88e6xxx/port.h
+++ b/drivers/net/dsa/mv88e6xxx/port.h
@@ -294,6 +294,130 @@
 /* Offset 0x13: OutFiltered Counter */
 #define MV88E6XXX_PORT_OUT_FILTERED	0x13
 
+/* Offset 0x16: LED Control */
+#define MV88E6XXX_PORT_LED_CONTROL				0x16
+#define MV88E6XXX_PORT_LED_CONTROL_UPDATE			BIT(15)
+#define MV88E6XXX_PORT_LED_CONTROL_POINTER_MASK			GENMASK(14, 12)
+#define MV88E6XXX_PORT_LED_CONTROL_POINTER_LED01_CTRL		(0x00 << 12) /* Control for LED 0 and 1 */
+#define MV88E6XXX_PORT_LED_CONTROL_POINTER_STRETCH_BLINK	(0x06 << 12) /* Stetch and Blink Rate */
+#define MV88E6XXX_PORT_LED_CONTROL_POINTER_CNTL_SPECIAL		(0x07 << 12) /* Control for the Port's Special LED */
+#define MV88E6XXX_PORT_LED_CONTROL_DATA_MASK			GENMASK(10, 0)
+/* Selection masks valid for either port 1,2,3,4 or 5 */
+#define MV88E6XXX_PORT_LED_CONTROL_LED0_SEL_MASK		GENMASK(3, 0)
+#define MV88E6XXX_PORT_LED_CONTROL_LED1_SEL_MASK		GENMASK(7, 4)
+/* Selection control for LED 0 and 1, ports 5 and 6 only has LED 0
+ * Bits  Function
+ * 0..3  LED 0 control selector on ports 1-5
+ * 4..7  LED 1 control selector on ports 1-4 on port 5 this controls LED 0 of port 6
+ *
+ * Sel Port LED Function
+ * 0   1-4  0   Link/Act/Speed by Blink Rate (off=no link, on=link, blink=activity, blink speed=link speed)
+ *     1-4  1   Port 2's Special LED
+ *     5-6  0   Port 5 Link/Act (off=no link, on=link, blink=activity)
+ *     5-6  1   Port 6 Link/Act (off=no link, on=link 1000, blink=activity)
+ * 1   1-4  0   100/1000 Link/Act (off=no link, on=100 or 1000 link, blink=activity)
+ *     1-4  1   10/100 Link Act (off=no link, on=10 or 100 link, blink=activity)
+ *     5-6  0   Fiber 100 Link/Act (off=no link, on=link 100, blink=activity)
+ *     5-6  1   Fiber 1000 Link/Act (off=no link, on=link 1000, blink=activity)
+ * 2   1-4  0   1000 Link/Act (off=no link, on=link 1000, blink=activity)
+ *     1-4  1   10/100 Link/Act (off=no link, on=10 or 100 link, blink=activity)
+ *     5-6  0   Fiber 1000 Link/Act (off=no link, on=link 1000, blink=activity)
+ *     5-6  1   Fiber 100 Link/Act (off=no link, on=link 100, blink=activity)
+ * 3   1-4  0   Link/Act (off=no link, on=link, blink=activity)
+ *     1-4  1   1000 Link (off=no link, on=1000 link)
+ *     5-6  0   Port 0's Special LED
+ *     5-6  1   Fiber Link (off=no link, on=link)
+ * 4   1-4  0   Port 0's Special LED
+ *     1-4  1   Port 1's Special LED
+ *     5-6  0   Port 1's Special LED
+ *     5-6  1   Port 5 Link/Act (off=no link, on=link, blink=activity)
+ * 5   1-4  0   Reserved
+ *     1-4  1   Reserved
+ *     5-6  0   Port 2's Special LED
+ *     5-6  1   Port 6 Link (off=no link, on=link)
+ * 6   1-4  0   Duplex/Collision (off=half-duplex,on=full-duplex,blink=collision)
+ *     1-4  1   10/1000 Link/Act (off=no link, on=10 or 1000 link, blink=activity)
+ *     5-6  0   Port 5 Duplex/Collision (off=half-duplex, on=full-duplex, blink=col)
+ *     5-6  1   Port 6 Duplex/Collision (off=half-duplex, on=full-duplex, blink=col)
+ * 7   1-4  0   10/1000 Link/Act (off=no link, on=10 or 1000 link, blink=activity)
+ *     1-4  1   10/1000 Link (off=no link, on=10 or 1000 link)
+ *     5-6  0   Port 5 Link/Act/Speed by Blink rate (off=no link, on=link, blink=activity, blink speed=link speed)
+ *     5-6  1   Port 6 Link/Act/Speed by Blink rate (off=no link, on=link, blink=activity,  blink speed=link speed)
+ * 8   1-4  0   Link (off=no link, on=link)
+ *     1-4  1   Activity (off=no link, blink on=activity)
+ *     5-6  0   Port 6 Link/Act (off=no link, on=link, blink=activity)
+ *     5-6  1   Port 0's Special LED
+ * 9   1-4  0   10 Link (off=no link, on=10 link)
+ *     1-4  1   100 Link (off=no link, on=100 link)
+ *     5-6  0   Reserved
+ *     5-6  1   Port 1's Special LED
+ * a   1-4  0   10 Link/Act (off=no link, on=10 link, blink=activity)
+ *     1-4  1   100 Link/Act (off=no link, on=100 link, blink=activity)
+ *     5-6  0   Reserved
+ *     5-6  1   Port 2's Special LED
+ * b   1-4  0   100/1000 Link (off=no link, on=100 or 1000 link)
+ *     1-4  1   10/100 Link (off=no link, on=100 link, blink=activity)
+ *     5-6  0   Reserved
+ *     5-6  1   Reserved
+ * c     *  *   PTP Act (blink on=PTP activity)
+ * d     *  *   Force Blink
+ * e     *  *   Force Off
+ * f     *  *   Force On
+ */
+/* Select LED0 output */
+#define MV88E6XXX_PORT_LED_CONTROL_LED0_SEL0			0x0
+#define MV88E6XXX_PORT_LED_CONTROL_LED0_SEL1			0x1
+#define MV88E6XXX_PORT_LED_CONTROL_LED0_SEL2			0x2
+#define MV88E6XXX_PORT_LED_CONTROL_LED0_SEL3			0x3
+#define MV88E6XXX_PORT_LED_CONTROL_LED0_SEL4			0x4
+#define MV88E6XXX_PORT_LED_CONTROL_LED0_SEL5			0x5
+#define MV88E6XXX_PORT_LED_CONTROL_LED0_SEL6			0x6
+#define MV88E6XXX_PORT_LED_CONTROL_LED0_SEL7			0x7
+#define MV88E6XXX_PORT_LED_CONTROL_LED0_SEL8			0x8
+#define MV88E6XXX_PORT_LED_CONTROL_LED0_SEL9			0x9
+#define MV88E6XXX_PORT_LED_CONTROL_LED0_SELA			0xa
+#define MV88E6XXX_PORT_LED_CONTROL_LED0_SELB			0xb
+#define MV88E6XXX_PORT_LED_CONTROL_LED0_SELC			0xc
+#define MV88E6XXX_PORT_LED_CONTROL_LED0_SELD			0xd
+#define MV88E6XXX_PORT_LED_CONTROL_LED0_SELE			0xe
+#define MV88E6XXX_PORT_LED_CONTROL_LED0_SELF			0xf
+#define MV88E6XXX_PORT_LED_CONTROL_LED1_SEL0			(0x0 << 4)
+#define MV88E6XXX_PORT_LED_CONTROL_LED1_SEL1			(0x1 << 4)
+#define MV88E6XXX_PORT_LED_CONTROL_LED1_SEL2			(0x2 << 4)
+#define MV88E6XXX_PORT_LED_CONTROL_LED1_SEL3			(0x3 << 4)
+#define MV88E6XXX_PORT_LED_CONTROL_LED1_SEL4			(0x4 << 4)
+#define MV88E6XXX_PORT_LED_CONTROL_LED1_SEL5			(0x5 << 4)
+#define MV88E6XXX_PORT_LED_CONTROL_LED1_SEL6			(0x6 << 4)
+#define MV88E6XXX_PORT_LED_CONTROL_LED1_SEL7			(0x7 << 4)
+#define MV88E6XXX_PORT_LED_CONTROL_LED1_SEL8			(0x8 << 4)
+#define MV88E6XXX_PORT_LED_CONTROL_LED1_SEL9			(0x9 << 4)
+#define MV88E6XXX_PORT_LED_CONTROL_LED1_SELA			(0xa << 4)
+#define MV88E6XXX_PORT_LED_CONTROL_LED1_SELB			(0xb << 4)
+#define MV88E6XXX_PORT_LED_CONTROL_LED1_SELC			(0xc << 4)
+#define MV88E6XXX_PORT_LED_CONTROL_LED1_SELD			(0xd << 4)
+#define MV88E6XXX_PORT_LED_CONTROL_LED1_SELE			(0xe << 4)
+#define MV88E6XXX_PORT_LED_CONTROL_LED1_SELF			(0xf << 4)
+/* Stretch and Blink Rate Control (Index 0x06 of LED Control) */
+/* Pulse Stretch Selection for all LED's on this port */
+#define MV88E6XXX_PORT_LED_CONTROL_0x06_PULSE_STRETCH_NONE	(0 << 4)
+#define MV88E6XXX_PORT_LED_CONTROL_0x06_PULSE_STRETCH_21MS	(1 << 4)
+#define MV88E6XXX_PORT_LED_CONTROL_0x06_PULSE_STRETCH_42MS	(2 << 4)
+#define MV88E6XXX_PORT_LED_CONTROL_0x06_PULSE_STRETCH_84MS	(3 << 4)
+#define MV88E6XXX_PORT_LED_CONTROL_0x06_PULSE_STRETCH_168MS	(4 << 4)
+/* Blink Rate Selection for all LEDs on this port */
+#define MV88E6XXX_PORT_LED_CONTROL_0x06_BLINK_RATE_21MS		0
+#define MV88E6XXX_PORT_LED_CONTROL_0x06_BLINK_RATE_42MS		1
+#define MV88E6XXX_PORT_LED_CONTROL_0x06_BLINK_RATE_84MS		2
+#define MV88E6XXX_PORT_LED_CONTROL_0x06_BLINK_RATE_168MS	3
+#define MV88E6XXX_PORT_LED_CONTROL_0x06_BLINK_RATE_336MS	4
+#define MV88E6XXX_PORT_LED_CONTROL_0x06_BLINK_RATE_672MS	5
+ /* Control for Special LED (Index 0x7 of LED Control on Port0) */
+#define MV88E6XXX_PORT_LED_CONTROL_0x07_P0_LAN_LINKACT_SHIFT	0 /* bits 6:0 LAN Link Activity LED */
+/* Control for Special LED (Index 0x7 of LED Control on Port 1) */
+#define MV88E6XXX_PORT_LED_CONTROL_0x07_P1_WAN_LINKACT_SHIFT	0 /* bits 6:0 WAN Link Activity LED */
+/* Control for Special LED (Index 0x7 of LED Control on Port 2) */
+#define MV88E6XXX_PORT_LED_CONTROL_0x07_P2_PTP_ACT		0 /* bits 6:0 PTP Activity */
+
 /* Offset 0x18: IEEE Priority Mapping Table */
 #define MV88E6390_PORT_IEEE_PRIO_MAP_TABLE			0x18
 #define MV88E6390_PORT_IEEE_PRIO_MAP_TABLE_UPDATE		0x8000
@@ -442,6 +566,7 @@ int mv88e6393x_port_set_cmode(struct mv88e6xxx_chip *chip, int port,
 			      phy_interface_t mode);
 int mv88e6185_port_get_cmode(struct mv88e6xxx_chip *chip, int port, u8 *cmode);
 int mv88e6352_port_get_cmode(struct mv88e6xxx_chip *chip, int port, u8 *cmode);
+int mv88e6xxx_port_setup_leds(struct mv88e6xxx_chip *chip, int port);
 int mv88e6xxx_port_drop_untagged(struct mv88e6xxx_chip *chip, int port,
 				 bool drop_untagged);
 int mv88e6xxx_port_set_map_da(struct mv88e6xxx_chip *chip, int port, bool map);

---
base-commit: ae2dae528d50e7968ece0a00246e21c1d083d15f
change-id: 20231123-mv88e6xxx-leds-b8b9b316ff98

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

