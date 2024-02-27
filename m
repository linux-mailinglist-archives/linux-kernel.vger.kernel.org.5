Return-Path: <linux-kernel+bounces-82974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4C8868C78
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81D1528DB38
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8EF13849E;
	Tue, 27 Feb 2024 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LFhQM41E"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28A313699F;
	Tue, 27 Feb 2024 09:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709026813; cv=none; b=t2osUZE5JD+pDlmGrag5UxONo0ILG/0Gww5g+uJBDFerDK0c1KtJm7ENfaf92jhPvBdbTyDNdkBlTXDaXOJSOEN8YIcLQ50cx/nDIGR4m4Jql6cI8n8HJbVUJ3PZaZCchGnCnjMg73f80omqhG6qamVGAClZqPVdxe3L46PGr8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709026813; c=relaxed/simple;
	bh=uqtJGHKVHC/j4i5cKjZOrsQelhUV4vYr6TiYM/bYruQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aq7Hz5sq0u0JTToxLkV3axBr2EDpYTE0DMeDCHQdzuKzWD9Z+XREv+Y3z9kSuVeI9bNprTOKuCUjqkEJjUABBLMS2u1l6BMnOiZwv2kk6b6gUaesHzXfheKpw349kE7f0n1ikMyapE8FiZI7Le9fj01LaP7Cx8vl5H0sSVVE4BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LFhQM41E; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 01A8B1BF212;
	Tue, 27 Feb 2024 09:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709026808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FpCvRT3LuSD1Mcc/k7iKXm6hU1A4RCeIB4aBNCXWOa0=;
	b=LFhQM41EcxzoRb4uelw7/FQMFlnzcKBFo75Y8VbXklZMIKxCtW7EgB3D7ah+XlO1xhtmzE
	E9Mla+lSf+f1RypQ07S60o1BB2k2N0VlH6Zje+yNeKJEcTlhWf6qaE32hmzwuH0VWKL3lw
	XjLlAxeoVjhAxYEmjYnOpsW0krn/a4v9dQvqI6yQ0cuEl6k3JeJG1mR1fohr8Q6Gsfrgc3
	Vgh3nCxajIgBGz/QHnrRsRSJXzA/ZsKZOdKoZtLRU498V/1YX6CnssX3rpp+biOMPkncOs
	BIhx+bRhb+Lhpf/WuxDLa5VW9CV4WYw2uiJFCyE4/lxXuRmkgozTppFZ3an33A==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-leds@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com,
	maxime.chevallier@bootlin.com,
	christophercordahi@nanometrics.ca
Subject: [PATCH v2 3/6] net: phy: DP83640: Add LED handling
Date: Tue, 27 Feb 2024 10:39:42 +0100
Message-ID: <20240227093945.21525-4-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227093945.21525-1-bastien.curutchet@bootlin.com>
References: <20240227093945.21525-1-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

The PHY have three LED : Activity LED, Speed LED and Link LED. The PHY
offers three configuration modes for them. The driver does not handle them.

Add LED handling through the /sys/class/leds interface.
On every mode the Speed LED indicates the speed (10Mbps or 100 Mbps) and
the Link LED indicates whether the link is good or not. Link LED will also
reflects link activity in mode 2 and 3. The Activity LED can reflect the
link activity (mode 1), the link's duplex (mode 2) or collisions on the
link (mode 3).
Only the Activity LED can have its hardware configuration updated, it
has an impact on Link LED as activity reflexion is added on it on modes
2 and 3

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 drivers/net/phy/dp83640.c     | 176 ++++++++++++++++++++++++++++++++++
 drivers/net/phy/dp83640_reg.h |  11 +++
 2 files changed, 187 insertions(+)

diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
index 5c42c47dc564..c46c81ef0ad0 100644
--- a/drivers/net/phy/dp83640.c
+++ b/drivers/net/phy/dp83640.c
@@ -59,6 +59,22 @@
 				   MII_DP83640_MISR_SPD_INT |\
 				   MII_DP83640_MISR_LINK_INT)
 
+#define DP83640_ACTLED_IDX	0
+#define DP83640_LNKLED_IDX	1
+#define DP83640_SPDLED_IDX	2
+/* LNKLED = ON for Good Link, OFF for No Link */
+/* SPDLED = ON in 100 Mb/s, OFF in 10 Mb/s */
+/* ACTLED = ON for Activity, OFF for No Activity */
+#define DP83640_LED_MODE_1	1
+/* LNKLED = ON for Good Link, Blink for Activity */
+/* SPDLED = ON in 100 Mb/s, OFF in 10 Mb/s */
+/* ACTLED = ON for Collision, OFF for No Collision */
+#define DP83640_LED_MODE_2	2
+/* LNKLED = ON for Good Link, Blink for Activity */
+/* SPDLED = ON in 100 Mb/s, OFF in 10 Mb/s */
+/* ACTLED = ON for Full-Duplex, OFF for Half-Duplex */
+#define DP83640_LED_MODE_3	3
+
 /* phyter seems to miss the mark by 16 ns */
 #define ADJTIME_FIX	16
 
@@ -1515,6 +1531,161 @@ static void dp83640_remove(struct phy_device *phydev)
 	kfree(dp83640);
 }
 
+static int dp83640_led_brightness_set(struct phy_device *phydev, u8 index,
+				      enum led_brightness brightness)
+{
+	int val;
+
+	if (index > DP83640_SPDLED_IDX)
+		return -EINVAL;
+
+	phy_write(phydev, PAGESEL, 0);
+
+	val = phy_read(phydev, LEDCR) & ~DP83640_LED_DIS(index);
+	val |= DP83640_LED_DRV(index);
+	if (brightness)
+		val |= DP83640_LED_VAL(index);
+	else
+		val &= ~DP83640_LED_VAL(index);
+	phy_write(phydev, LEDCR, val);
+
+	return 0;
+}
+
+/**
+ * dp83640_led_mode - Check the trigger netdev rules and compute the associated
+ *                    configuration mode
+ * @index: The targeted LED
+ * @rules: Rules to be checked
+ *
+ * Returns the mode that is to be set in LED_CFNG. If the rules are not
+ * supported by the PHY, returns -ENOTSUPP. If the rules are supported but don't
+ * impact the LED configuration, returns 0
+ */
+static int dp83640_led_mode(u8 index, unsigned long rules)
+{
+	/* Only changes on ACTLED have an impact on LED Mode configuration */
+	switch (index) {
+	case DP83640_ACTLED_IDX:
+		switch (rules) {
+		case BIT(TRIGGER_NETDEV_TX) | BIT(TRIGGER_NETDEV_RX):
+			return DP83640_LED_MODE_1;
+		case BIT(TRIGGER_NETDEV_COLLISION):
+			return DP83640_LED_MODE_2;
+		case BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
+		     BIT(TRIGGER_NETDEV_HALF_DUPLEX):
+			return DP83640_LED_MODE_3;
+		default:
+			return -EOPNOTSUPP;
+		}
+
+	case DP83640_SPDLED_IDX:
+		/* SPDLED has the same function in every mode */
+		switch (rules) {
+		case BIT(TRIGGER_NETDEV_LINK_10) | BIT(TRIGGER_NETDEV_LINK_100):
+			return 0;
+		default:
+			return -EOPNOTSUPP;
+		}
+
+	case DP83640_LNKLED_IDX:
+		/* LNKLED has the same function in every mode */
+		switch (rules) {
+		case BIT(TRIGGER_NETDEV_LINK):
+			return 0;
+		default:
+			return -EOPNOTSUPP;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int dp83640_led_hw_is_supported(struct phy_device *phydev, u8 index,
+				       unsigned long rules)
+{
+	int ret;
+
+	ret = dp83640_led_mode(index, rules);
+
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int dp83640_led_hw_control_set(struct phy_device *phydev, u8 index,
+				      unsigned long rules)
+{
+	int mode, val;
+
+	mode = dp83640_led_mode(index, rules);
+	if (mode < 0)
+		return mode;
+
+	if (mode) {
+		phy_write(phydev, PAGESEL, 0);
+		val = phy_read(phydev, PHYCR) & ~(LED_CNFG_1 | LED_CNFG_0);
+		switch (mode) {
+		case DP83640_LED_MODE_1:
+			val |= LED_CNFG_0;
+		break;
+		case DP83640_LED_MODE_2:
+			/* Keeping LED_CNFG_1 and LED_CNFG_0 unset */
+			break;
+		case DP83640_LED_MODE_3:
+			val |= LED_CNFG_1;
+			break;
+		default:
+			return -EINVAL;
+		}
+		phy_write(phydev, PHYCR, val);
+	}
+
+	val = phy_read(phydev, LEDCR);
+	val &= ~(DP83640_LED_DIS(index) | DP83640_LED_DRV(index));
+	phy_write(phydev, LEDCR, val);
+
+	return 0;
+}
+
+static int dp83640_led_hw_control_get(struct phy_device *phydev, u8 index,
+				      unsigned long *rules)
+{
+	int val;
+
+	switch (index) {
+	case DP83640_ACTLED_IDX:
+		phy_write(phydev, PAGESEL, 0);
+		val = phy_read(phydev, PHYCR);
+		if (val & LED_CNFG_0) {
+			/* Mode 1 */
+			*rules = BIT(TRIGGER_NETDEV_TX) | BIT(TRIGGER_NETDEV_RX);
+		} else if (val & LED_CNFG_1) {
+			/* Mode 3 */
+			*rules = BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
+				 BIT(TRIGGER_NETDEV_HALF_DUPLEX);
+		} else {
+			/* Mode 2 */
+			*rules = BIT(TRIGGER_NETDEV_COLLISION);
+		}
+		break;
+
+	case DP83640_LNKLED_IDX:
+		*rules = BIT(TRIGGER_NETDEV_LINK);
+		break;
+
+	case DP83640_SPDLED_IDX:
+		*rules = BIT(TRIGGER_NETDEV_LINK_10) |
+			 BIT(TRIGGER_NETDEV_LINK_100);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static struct phy_driver dp83640_driver = {
 	.phy_id		= DP83640_PHY_ID,
 	.phy_id_mask	= 0xfffffff0,
@@ -1526,6 +1697,11 @@ static struct phy_driver dp83640_driver = {
 	.config_init	= dp83640_config_init,
 	.config_intr    = dp83640_config_intr,
 	.handle_interrupt = dp83640_handle_interrupt,
+
+	.led_brightness_set = dp83640_led_brightness_set,
+	.led_hw_is_supported = dp83640_led_hw_is_supported,
+	.led_hw_control_set = dp83640_led_hw_control_set,
+	.led_hw_control_get = dp83640_led_hw_control_get,
 };
 
 static int __init dp83640_init(void)
diff --git a/drivers/net/phy/dp83640_reg.h b/drivers/net/phy/dp83640_reg.h
index daae7fa58fb8..09dd2d2527c7 100644
--- a/drivers/net/phy/dp83640_reg.h
+++ b/drivers/net/phy/dp83640_reg.h
@@ -6,6 +6,8 @@
 #define HAVE_DP83640_REGISTERS
 
 /* #define PAGE0                  0x0000 */
+#define LEDCR                     0x0018 /* PHY Control Register */
+#define PHYCR                     0x0019 /* PHY Control Register */
 #define PHYCR2                    0x001c /* PHY Control Register 2 */
 
 #define PAGE4                     0x0004
@@ -50,6 +52,15 @@
 #define PTP_GPIOMON               0x001e /* PTP GPIO Monitor Register */
 #define PTP_RXHASH                0x001f /* PTP Receive Hash Register */
 
+/* Bit definitions for the LEDCR register */
+#define DP83640_LED_DIS(x)        BIT((x) + 9) /* Disable LED */
+#define DP83640_LED_DRV(x)        BIT((x) + 3) /* Force LED val to output */
+#define DP83640_LED_VAL(x)        BIT((x))     /* LED val */
+
+/* Bit definitions for the PHYCR register */
+#define LED_CNFG_0	          BIT(5)  /* LED configuration, bit 0 */
+#define LED_CNFG_1	          BIT(6)  /* LED configuration, bit 1 */
+
 /* Bit definitions for the PHYCR2 register */
 #define BC_WRITE                  (1<<11) /* Broadcast Write Enable */
 
-- 
2.43.0


