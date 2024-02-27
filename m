Return-Path: <linux-kernel+bounces-82978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE8C868C87
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22B5AB25F9F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEDF13A24E;
	Tue, 27 Feb 2024 09:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ele8Kxd/"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED461384A9;
	Tue, 27 Feb 2024 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709026817; cv=none; b=JqQ03QaEtymczjWvWTHfGawlgwFNUYhqCBaXwpe/PxL46yC6WYbGq0VEcNnZ2FlJuHmKLsqQhJctJfiB1VSMnze4mh8QYGa3v/ARBDx2CQhUGEkO/oNZxB0yBlkQWmXy8R3ktNh5D6H/UCqmhW8syNjatMcZKasEz+69YA1NBa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709026817; c=relaxed/simple;
	bh=WKyTm9tvEpOHc9SUmAoFjXDcY9NXpqkPz111tBhUrs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LiYrgGId+YFjBL8BV1Ik1rOhzaaosfEtetQNUj1Lbogm5T193omDE3+YfhmkT6ILK++cQNkl12lxwCni6IyG0aDzk5/lfbZTwkp+xMFufDodL0i+MRM99lelKKtf+eCndSqrD3vGnCcg6QDrXWXE7tb2zuiD0kEPwpt6Vm63WA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ele8Kxd/; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 500A91BF21B;
	Tue, 27 Feb 2024 09:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709026813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rgaNBK3volcj4FhXmaNO+Po++qQCUID/slrT9VBh2II=;
	b=ele8Kxd/pDw2DVnj7w1ZSTVzt5dJp44Z34mJh3wAoCCb1F8Uowblgmmil72EwgmkzjIbbq
	BnV0zkfG0sko4SN3vb3/BWQ/gGE3L68HdzcY2vqoe79/DT+2DyGyv2Yr6dAGkh5Q8VVSuB
	PvND6VZRvmeiIZUB8ODZVYVHr1W5pqL9g0E5v3GoDa2QO1eIq+yfgPuPqjaMkqKqZpAssh
	ZwlzFMmrhJzAeju2hJO5tc4OKbrrq1B1wFgI31ZAwpE54t+edRu4BFKmyTSr1n1G22TrXu
	mg5xISlvcK4u7ko++V1NXOoQ4jc5fEgEYKuEsupodVlBQ1ZvcE57gIFjl7rCYg==
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
Subject: [PATCH v2 6/6] net: phy: DP83640: Add fiber mode enabling/disabling from device tree
Date: Tue, 27 Feb 2024 10:39:45 +0100
Message-ID: <20240227093945.21525-7-bastien.curutchet@bootlin.com>
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

The PHY is able to use copper or fiber. The fiber mode can be enabled or
disabled by hardware strap. If hardware strap is incorrect, PHY can't
establish link.

Add a DT attribute 'ti,fiber-mode' that can be use to override the
hardware strap configuration. If the property is not present, hardware
strap configuration is left as is.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 drivers/net/phy/dp83640.c     | 55 +++++++++++++++++++++++++++++++++++
 drivers/net/phy/dp83640_reg.h |  5 ++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
index b371dea23937..886f2bc3710d 100644
--- a/drivers/net/phy/dp83640.c
+++ b/drivers/net/phy/dp83640.c
@@ -16,6 +16,7 @@
 #include <linux/net_tstamp.h>
 #include <linux/netdevice.h>
 #include <linux/if_vlan.h>
+#include <linux/of.h>
 #include <linux/phy.h>
 #include <linux/ptp_classify.h>
 #include <linux/ptp_clock_kernel.h>
@@ -141,6 +142,11 @@ struct dp83640_private {
 	/* queues of incoming and outgoing packets */
 	struct sk_buff_head rx_queue;
 	struct sk_buff_head tx_queue;
+
+#define FIBER_MODE_DEFAULT	0
+#define FIBER_MODE_ENABLE	1
+#define FIBER_MODE_DISABLE	2
+	int fiber;
 };
 
 struct dp83640_clock {
@@ -1141,6 +1147,17 @@ static int dp83640_config_init(struct phy_device *phydev)
 	val = phy_read(phydev, PCFCR) & ~PCF_EN;
 	phy_write(phydev, PCFCR, val);
 
+	if (dp83640->fiber != FIBER_MODE_DEFAULT) {
+		val = phy_read(phydev, PCSR) & ~FX_EN;
+		if (dp83640->fiber == FIBER_MODE_ENABLE)
+			val |= FX_EN;
+		phy_write(phydev, PCSR, val);
+
+		/* Write SOFT_RESET bit to ensure configuration */
+		val = phy_read(phydev, PHYCR2) | SOFT_RESET;
+		phy_write(phydev, PHYCR2, val);
+	}
+
 	return 0;
 }
 
@@ -1440,6 +1457,39 @@ static int dp83640_ts_info(struct mii_timestamper *mii_ts,
 	return 0;
 }
 
+#ifdef CONFIG_OF_MDIO
+static int dp83640_of_init(struct phy_device *phydev)
+{
+	struct dp83640_private *dp83640 = phydev->priv;
+	struct device *dev = &phydev->mdio.dev;
+	struct device_node *of_node = dev->of_node;
+	const char *fiber;
+	int ret;
+
+	if (of_property_present(of_node, "ti,fiber-mode")) {
+		ret = of_property_read_string(of_node, "ti,fiber-mode", &fiber);
+		if (ret)
+			return ret;
+
+		dp83640->fiber = FIBER_MODE_DEFAULT;
+		if (!strncmp(fiber, "enable", 6))
+			dp83640->fiber = FIBER_MODE_ENABLE;
+		else if (!strncmp(fiber, "disable", 7))
+			dp83640->fiber = FIBER_MODE_DISABLE;
+		else
+			return -EINVAL;
+	}
+
+	return 0;
+}
+#else
+static int dp83640_of_init(struct phy_device *phydev)
+{
+	dp83640->fiber = FIBER_MODE_DEFAULT;
+	return 0;
+}
+#endif /* CONFIG_OF_MDIO */
+
 static int dp83640_probe(struct phy_device *phydev)
 {
 	struct dp83640_clock *clock;
@@ -1472,6 +1522,10 @@ static int dp83640_probe(struct phy_device *phydev)
 	phydev->mii_ts = &dp83640->mii_ts;
 	phydev->priv = dp83640;
 
+	err = dp83640_of_init(phydev);
+	if (err < 0)
+		goto of_failed;
+
 	spin_lock_init(&dp83640->rx_lock);
 	skb_queue_head_init(&dp83640->rx_queue);
 	skb_queue_head_init(&dp83640->tx_queue);
@@ -1494,6 +1548,7 @@ static int dp83640_probe(struct phy_device *phydev)
 
 no_register:
 	clock->chosen = NULL;
+of_failed:
 	kfree(dp83640);
 no_memory:
 	dp83640_clock_put(clock);
diff --git a/drivers/net/phy/dp83640_reg.h b/drivers/net/phy/dp83640_reg.h
index b5adb8958c08..cbecf04da5a5 100644
--- a/drivers/net/phy/dp83640_reg.h
+++ b/drivers/net/phy/dp83640_reg.h
@@ -6,6 +6,7 @@
 #define HAVE_DP83640_REGISTERS
 
 /* #define PAGE0                  0x0000 */
+#define PCSR                      0x0016 /* PCS Configuration and Status Register */
 #define LEDCR                     0x0018 /* PHY Control Register */
 #define PHYCR                     0x0019 /* PHY Control Register */
 #define PHYCR2                    0x001c /* PHY Control Register 2 */
@@ -54,6 +55,9 @@
 #define PTP_GPIOMON               0x001e /* PTP GPIO Monitor Register */
 #define PTP_RXHASH                0x001f /* PTP Receive Hash Register */
 
+/* Bit definitions for the PCSR register */
+#define FX_EN		          BIT(6)  /* Enable FX Fiber Mode */
+
 /* Bit definitions for the LEDCR register */
 #define DP83640_LED_DIS(x)        BIT((x) + 9) /* Disable LED */
 #define DP83640_LED_DRV(x)        BIT((x) + 3) /* Force LED val to output */
@@ -64,6 +68,7 @@
 #define LED_CNFG_1	          BIT(6)  /* LED configuration, bit 1 */
 
 /* Bit definitions for the PHYCR2 register */
+#define SOFT_RESET		  BIT(9)  /* Soft Reset */
 #define BC_WRITE                  (1<<11) /* Broadcast Write Enable */
 
 /* Bit definitions for the EDCR register */
-- 
2.43.0


