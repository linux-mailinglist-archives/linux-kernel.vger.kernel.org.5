Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44394797755
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjIGQYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238540AbjIGQHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:07:54 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A9DD172
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:00:46 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qeAfn-0005jK-EF; Thu, 07 Sep 2023 10:47:35 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qeAfm-004c0b-82; Thu, 07 Sep 2023 10:47:34 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qeAfl-0099Tl-9z; Thu, 07 Sep 2023 10:47:33 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] net: phy: dp83867: Add support for hardware blinking LEDs
Date:   Thu,  7 Sep 2023 10:47:31 +0200
Message-Id: <20230907084731.2181381-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
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

This implements the led_hw_* hooks to support hardware blinking LEDs on
the DP83867 phy. The driver supports all LED modes that have a
corresponding TRIGGER_NETDEV_* define. Error and collision do not have
a TRIGGER_NETDEV_* define, so these modes are currently not supported.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/phy/dp83867.c | 137 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index e397e7d642d92..5f08f9d38bd7a 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -159,6 +159,23 @@
 #define DP83867_LED_DRV_EN(x)	BIT((x) * 4)
 #define DP83867_LED_DRV_VAL(x)	BIT((x) * 4 + 1)
 
+#define DP83867_LED_FN(idx, val)	(((val) & 0xf) << ((idx) * 4))
+#define DP83867_LED_FN_MASK(idx)	(0xf << ((idx) * 4))
+#define DP83867_LED_FN_RX_ERR		0xe /* Receive Error */
+#define DP83867_LED_FN_RX_TX_ERR	0xd /* Receive Error or Transmit Error */
+#define DP83867_LED_FN_LINK_RX_TX	0xb /* Link established, blink for rx or tx activity */
+#define DP83867_LED_FN_FULL_DUPLEX	0xa /* Full duplex */
+#define DP83867_LED_FN_LINK_100_1000_BT	0x9 /* 100/1000BT link established */
+#define DP83867_LED_FN_LINK_10_100_BT	0x8 /* 10/100BT link established */
+#define DP83867_LED_FN_LINK_10_BT	0x7 /* 10BT link established */
+#define DP83867_LED_FN_LINK_100_BTX	0x6 /* 100 BTX link established */
+#define DP83867_LED_FN_LINK_1000_BT	0x5 /* 1000 BT link established */
+#define DP83867_LED_FN_COLLISION	0x4 /* Collision detected */
+#define DP83867_LED_FN_RX		0x3 /* Receive activity */
+#define DP83867_LED_FN_TX		0x2 /* Transmit activity */
+#define DP83867_LED_FN_RX_TX		0x1 /* Receive or Transmit activity */
+#define DP83867_LED_FN_LINK		0x0 /* Link established */
+
 enum {
 	DP83867_PORT_MIRROING_KEEP,
 	DP83867_PORT_MIRROING_EN,
@@ -1018,6 +1035,123 @@ dp83867_led_brightness_set(struct phy_device *phydev,
 			  val);
 }
 
+static int dp83867_led_mode(u8 index, unsigned long rules)
+{
+	if (index >= DP83867_LED_COUNT)
+		return -EINVAL;
+
+	switch (rules) {
+	case BIT(TRIGGER_NETDEV_LINK):
+		return DP83867_LED_FN_LINK;
+	case BIT(TRIGGER_NETDEV_LINK_10):
+		return DP83867_LED_FN_LINK_10_BT;
+	case BIT(TRIGGER_NETDEV_LINK_100):
+		return DP83867_LED_FN_LINK_100_BTX;
+	case BIT(TRIGGER_NETDEV_FULL_DUPLEX):
+		return DP83867_LED_FN_FULL_DUPLEX;
+	case BIT(TRIGGER_NETDEV_TX):
+		return DP83867_LED_FN_TX;
+	case BIT(TRIGGER_NETDEV_RX):
+		return DP83867_LED_FN_RX;
+	case BIT(TRIGGER_NETDEV_LINK_1000):
+		return DP83867_LED_FN_LINK_1000_BT;
+	case BIT(TRIGGER_NETDEV_TX) | BIT(TRIGGER_NETDEV_RX):
+		return DP83867_LED_FN_RX_TX;
+	case BIT(TRIGGER_NETDEV_LINK_100) | BIT(TRIGGER_NETDEV_LINK_1000):
+		return DP83867_LED_FN_LINK_100_1000_BT;
+	case BIT(TRIGGER_NETDEV_LINK_10) | BIT(TRIGGER_NETDEV_LINK_100):
+		return DP83867_LED_FN_LINK_10_100_BT;
+	case BIT(TRIGGER_NETDEV_LINK) | BIT(TRIGGER_NETDEV_TX) | BIT(TRIGGER_NETDEV_RX):
+		return DP83867_LED_FN_LINK_RX_TX;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int dp83867_led_hw_is_supported(struct phy_device *phydev, u8 index,
+				       unsigned long rules)
+{
+	int ret;
+
+	ret = dp83867_led_mode(index, rules);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int dp83867_led_hw_control_set(struct phy_device *phydev, u8 index,
+				      unsigned long rules)
+{
+	int mode, ret;
+
+	mode = dp83867_led_mode(index, rules);
+	if (mode < 0)
+		return mode;
+
+	ret = phy_modify(phydev, DP83867_LEDCR1, DP83867_LED_FN_MASK(index),
+			 DP83867_LED_FN(index, mode));
+	if (ret)
+		return ret;
+
+	return phy_modify(phydev, DP83867_LEDCR2, DP83867_LED_DRV_EN(index), 0);
+}
+
+static int dp83867_led_hw_control_get(struct phy_device *phydev, u8 index,
+				      unsigned long *rules)
+{
+	int val;
+
+	val = phy_read(phydev, DP83867_LEDCR1);
+	if (val < 0)
+		return val;
+
+	val &= DP83867_LED_FN_MASK(index);
+	val >>= index * 4;
+
+	switch (val) {
+	case DP83867_LED_FN_LINK:
+		*rules = BIT(TRIGGER_NETDEV_LINK);
+		break;
+	case DP83867_LED_FN_LINK_10_BT:
+		*rules = BIT(TRIGGER_NETDEV_LINK_10);
+		break;
+	case DP83867_LED_FN_LINK_100_BTX:
+		*rules = BIT(TRIGGER_NETDEV_LINK_100);
+		break;
+	case DP83867_LED_FN_FULL_DUPLEX:
+		*rules = BIT(TRIGGER_NETDEV_FULL_DUPLEX);
+		break;
+	case DP83867_LED_FN_TX:
+		*rules = BIT(TRIGGER_NETDEV_TX);
+		break;
+	case DP83867_LED_FN_RX:
+		*rules = BIT(TRIGGER_NETDEV_RX);
+		break;
+	case DP83867_LED_FN_LINK_1000_BT:
+		*rules = BIT(TRIGGER_NETDEV_LINK_1000);
+		break;
+	case DP83867_LED_FN_RX_TX:
+		*rules = BIT(TRIGGER_NETDEV_TX) | BIT(TRIGGER_NETDEV_RX);
+		break;
+	case DP83867_LED_FN_LINK_100_1000_BT:
+		*rules = BIT(TRIGGER_NETDEV_LINK_100) | BIT(TRIGGER_NETDEV_LINK_1000);
+		break;
+	case DP83867_LED_FN_LINK_10_100_BT:
+		*rules = BIT(TRIGGER_NETDEV_LINK_10) | BIT(TRIGGER_NETDEV_LINK_100);
+		break;
+	case DP83867_LED_FN_LINK_RX_TX:
+		*rules = BIT(TRIGGER_NETDEV_LINK) | BIT(TRIGGER_NETDEV_TX) |
+			 BIT(TRIGGER_NETDEV_RX);
+		break;
+	default:
+		*rules = 0;
+		break;
+	}
+
+	return 0;
+}
+
 static struct phy_driver dp83867_driver[] = {
 	{
 		.phy_id		= DP83867_PHY_ID,
@@ -1047,6 +1181,9 @@ static struct phy_driver dp83867_driver[] = {
 		.set_loopback	= dp83867_loopback,
 
 		.led_brightness_set = dp83867_led_brightness_set,
+		.led_hw_is_supported = dp83867_led_hw_is_supported,
+		.led_hw_control_set = dp83867_led_hw_control_set,
+		.led_hw_control_get = dp83867_led_hw_control_get,
 	},
 };
 module_phy_driver(dp83867_driver);
-- 
2.39.2

