Return-Path: <linux-kernel+bounces-91748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F676871601
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9929DB23B39
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A1F45BF1;
	Tue,  5 Mar 2024 06:48:20 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9934F8833
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 06:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709621299; cv=none; b=f1pVBEbe+Kzi73EXuX5hYKQEOemHCqLqdO8gZUVqXBPIQS1k9fnsnh+9O/B3j7wkgNr7c8n7Udwhz+5jzivnBYBDsc8dZbkRyTJW8omikhpJatfTkd/xtS5F4grt9962CcpvtXF3eUDIu3q1EuNvJXESVr+SMy6Tm/bq4i3R0UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709621299; c=relaxed/simple;
	bh=Eb71CMUfoqz8tgPsMfTeC8hXAbbak0gEbsPXcQz2r5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T50KWk+sCTXrKUJiggL0cH9RrUSQEBu8DhsQ7fYpLQRAiDObPxE480K3C0JiU5W4YVs5MA3hK02GPhYOEuh171lc5zxOgmz/2FBvP6QO9M4+ErLGJ2N54w/pdRm66qQpjd8JF81XQKeISuI8SnWFoxO6gksCn/+FcELEh1xo64M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rhOar-0000OZ-Ml; Tue, 05 Mar 2024 07:48:05 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rhOap-004V4J-BM; Tue, 05 Mar 2024 07:48:03 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rhOap-00AOti-0t;
	Tue, 05 Mar 2024 07:48:03 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net v2 1/1] net: dsa: microchip: make sure drive strength configuration is not lost by soft reset
Date: Tue,  5 Mar 2024 07:48:02 +0100
Message-Id: <20240305064802.2478971-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This driver has two separate reset sequence in different places:
- gpio/HW reset on start of ksz_switch_register()
- SW reset on start of ksz_setup()

The second one will overwrite drive strength configuration made in the
ksz_switch_register().

To fix it, move ksz_parse_drive_strength() from ksz_switch_register() to
ksz_setup().

Fixes: d67d7247f641 ("net: dsa: microchip: Add drive strength configuration")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v2:
- move code to avoid forward declaration

 drivers/net/dsa/microchip/ksz_common.c | 488 ++++++++++++-------------
 1 file changed, 244 insertions(+), 244 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index d58cc685478b1..030b167764b39 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2260,6 +2260,246 @@ static int ksz_pirq_setup(struct ksz_device *dev, u8 p)
 	return ksz_irq_common_setup(dev, pirq);
 }
 
+/**
+ * ksz_drive_strength_to_reg() - Convert drive strength value to corresponding
+ *				 register value.
+ * @array:	The array of drive strength values to search.
+ * @array_size:	The size of the array.
+ * @microamp:	The drive strength value in microamp to be converted.
+ *
+ * This function searches the array of drive strength values for the given
+ * microamp value and returns the corresponding register value for that drive.
+ *
+ * Returns: If found, the corresponding register value for that drive strength
+ * is returned. Otherwise, -EINVAL is returned indicating an invalid value.
+ */
+static int ksz_drive_strength_to_reg(const struct ksz_drive_strength *array,
+				     size_t array_size, int microamp)
+{
+	int i;
+
+	for (i = 0; i < array_size; i++) {
+		if (array[i].microamp == microamp)
+			return array[i].reg_val;
+	}
+
+	return -EINVAL;
+}
+
+/**
+ * ksz_drive_strength_error() - Report invalid drive strength value
+ * @dev:	ksz device
+ * @array:	The array of drive strength values to search.
+ * @array_size:	The size of the array.
+ * @microamp:	Invalid drive strength value in microamp
+ *
+ * This function logs an error message when an unsupported drive strength value
+ * is detected. It lists out all the supported drive strength values for
+ * reference in the error message.
+ */
+static void ksz_drive_strength_error(struct ksz_device *dev,
+				     const struct ksz_drive_strength *array,
+				     size_t array_size, int microamp)
+{
+	char supported_values[100];
+	size_t remaining_size;
+	int added_len;
+	char *ptr;
+	int i;
+
+	remaining_size = sizeof(supported_values);
+	ptr = supported_values;
+
+	for (i = 0; i < array_size; i++) {
+		added_len = snprintf(ptr, remaining_size,
+				     i == 0 ? "%d" : ", %d", array[i].microamp);
+
+		if (added_len >= remaining_size)
+			break;
+
+		ptr += added_len;
+		remaining_size -= added_len;
+	}
+
+	dev_err(dev->dev, "Invalid drive strength %d, supported values are %s\n",
+		microamp, supported_values);
+}
+
+/**
+ * ksz9477_drive_strength_write() - Set the drive strength for specific KSZ9477
+ *				    chip variants.
+ * @dev:       ksz device
+ * @props:     Array of drive strength properties to be applied
+ * @num_props: Number of properties in the array
+ *
+ * This function configures the drive strength for various KSZ9477 chip variants
+ * based on the provided properties. It handles chip-specific nuances and
+ * ensures only valid drive strengths are written to the respective chip.
+ *
+ * Return: 0 on successful configuration, a negative error code on failure.
+ */
+static int ksz9477_drive_strength_write(struct ksz_device *dev,
+					struct ksz_driver_strength_prop *props,
+					int num_props)
+{
+	size_t array_size = ARRAY_SIZE(ksz9477_drive_strengths);
+	int i, ret, reg;
+	u8 mask = 0;
+	u8 val = 0;
+
+	if (props[KSZ_DRIVER_STRENGTH_IO].value != -1)
+		dev_warn(dev->dev, "%s is not supported by this chip variant\n",
+			 props[KSZ_DRIVER_STRENGTH_IO].name);
+
+	if (dev->chip_id == KSZ8795_CHIP_ID ||
+	    dev->chip_id == KSZ8794_CHIP_ID ||
+	    dev->chip_id == KSZ8765_CHIP_ID)
+		reg = KSZ8795_REG_SW_CTRL_20;
+	else
+		reg = KSZ9477_REG_SW_IO_STRENGTH;
+
+	for (i = 0; i < num_props; i++) {
+		if (props[i].value == -1)
+			continue;
+
+		ret = ksz_drive_strength_to_reg(ksz9477_drive_strengths,
+						array_size, props[i].value);
+		if (ret < 0) {
+			ksz_drive_strength_error(dev, ksz9477_drive_strengths,
+						 array_size, props[i].value);
+			return ret;
+		}
+
+		mask |= SW_DRIVE_STRENGTH_M << props[i].offset;
+		val |= ret << props[i].offset;
+	}
+
+	return ksz_rmw8(dev, reg, mask, val);
+}
+
+/**
+ * ksz8830_drive_strength_write() - Set the drive strength configuration for
+ *				    KSZ8830 compatible chip variants.
+ * @dev:       ksz device
+ * @props:     Array of drive strength properties to be set
+ * @num_props: Number of properties in the array
+ *
+ * This function applies the specified drive strength settings to KSZ8830 chip
+ * variants (KSZ8873, KSZ8863).
+ * It ensures the configurations align with what the chip variant supports and
+ * warns or errors out on unsupported settings.
+ *
+ * Return: 0 on success, error code otherwise
+ */
+static int ksz8830_drive_strength_write(struct ksz_device *dev,
+					struct ksz_driver_strength_prop *props,
+					int num_props)
+{
+	size_t array_size = ARRAY_SIZE(ksz8830_drive_strengths);
+	int microamp;
+	int i, ret;
+
+	for (i = 0; i < num_props; i++) {
+		if (props[i].value == -1 || i == KSZ_DRIVER_STRENGTH_IO)
+			continue;
+
+		dev_warn(dev->dev, "%s is not supported by this chip variant\n",
+			 props[i].name);
+	}
+
+	microamp = props[KSZ_DRIVER_STRENGTH_IO].value;
+	ret = ksz_drive_strength_to_reg(ksz8830_drive_strengths, array_size,
+					microamp);
+	if (ret < 0) {
+		ksz_drive_strength_error(dev, ksz8830_drive_strengths,
+					 array_size, microamp);
+		return ret;
+	}
+
+	return ksz_rmw8(dev, KSZ8873_REG_GLOBAL_CTRL_12,
+			KSZ8873_DRIVE_STRENGTH_16MA, ret);
+}
+
+/**
+ * ksz_parse_drive_strength() - Extract and apply drive strength configurations
+ *				from device tree properties.
+ * @dev:	ksz device
+ *
+ * This function reads the specified drive strength properties from the
+ * device tree, validates against the supported chip variants, and sets
+ * them accordingly. An error should be critical here, as the drive strength
+ * settings are crucial for EMI compliance.
+ *
+ * Return: 0 on success, error code otherwise
+ */
+static int ksz_parse_drive_strength(struct ksz_device *dev)
+{
+	struct ksz_driver_strength_prop of_props[] = {
+		[KSZ_DRIVER_STRENGTH_HI] = {
+			.name = "microchip,hi-drive-strength-microamp",
+			.offset = SW_HI_SPEED_DRIVE_STRENGTH_S,
+			.value = -1,
+		},
+		[KSZ_DRIVER_STRENGTH_LO] = {
+			.name = "microchip,lo-drive-strength-microamp",
+			.offset = SW_LO_SPEED_DRIVE_STRENGTH_S,
+			.value = -1,
+		},
+		[KSZ_DRIVER_STRENGTH_IO] = {
+			.name = "microchip,io-drive-strength-microamp",
+			.offset = 0, /* don't care */
+			.value = -1,
+		},
+	};
+	struct device_node *np = dev->dev->of_node;
+	bool have_any_prop = false;
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(of_props); i++) {
+		ret = of_property_read_u32(np, of_props[i].name,
+					   &of_props[i].value);
+		if (ret && ret != -EINVAL)
+			dev_warn(dev->dev, "Failed to read %s\n",
+				 of_props[i].name);
+		if (ret)
+			continue;
+
+		have_any_prop = true;
+	}
+
+	if (!have_any_prop)
+		return 0;
+
+	switch (dev->chip_id) {
+	case KSZ8830_CHIP_ID:
+		return ksz8830_drive_strength_write(dev, of_props,
+						    ARRAY_SIZE(of_props));
+	case KSZ8795_CHIP_ID:
+	case KSZ8794_CHIP_ID:
+	case KSZ8765_CHIP_ID:
+	case KSZ8563_CHIP_ID:
+	case KSZ8567_CHIP_ID:
+	case KSZ9477_CHIP_ID:
+	case KSZ9563_CHIP_ID:
+	case KSZ9567_CHIP_ID:
+	case KSZ9893_CHIP_ID:
+	case KSZ9896_CHIP_ID:
+	case KSZ9897_CHIP_ID:
+		return ksz9477_drive_strength_write(dev, of_props,
+						    ARRAY_SIZE(of_props));
+	default:
+		for (i = 0; i < ARRAY_SIZE(of_props); i++) {
+			if (of_props[i].value == -1)
+				continue;
+
+			dev_warn(dev->dev, "%s is not supported by this chip variant\n",
+				 of_props[i].name);
+		}
+	}
+
+	return 0;
+}
+
 static int ksz_setup(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
@@ -2281,6 +2521,10 @@ static int ksz_setup(struct dsa_switch *ds)
 		return ret;
 	}
 
+	ret = ksz_parse_drive_strength(dev);
+	if (ret)
+		return ret;
+
 	/* set broadcast storm protection 10% rate */
 	regmap_update_bits(ksz_regmap_16(dev), regs[S_BROADCAST_CTRL],
 			   BROADCAST_STORM_RATE,
@@ -4018,246 +4262,6 @@ static void ksz_parse_rgmii_delay(struct ksz_device *dev, int port_num,
 	dev->ports[port_num].rgmii_tx_val = tx_delay;
 }
 
-/**
- * ksz_drive_strength_to_reg() - Convert drive strength value to corresponding
- *				 register value.
- * @array:	The array of drive strength values to search.
- * @array_size:	The size of the array.
- * @microamp:	The drive strength value in microamp to be converted.
- *
- * This function searches the array of drive strength values for the given
- * microamp value and returns the corresponding register value for that drive.
- *
- * Returns: If found, the corresponding register value for that drive strength
- * is returned. Otherwise, -EINVAL is returned indicating an invalid value.
- */
-static int ksz_drive_strength_to_reg(const struct ksz_drive_strength *array,
-				     size_t array_size, int microamp)
-{
-	int i;
-
-	for (i = 0; i < array_size; i++) {
-		if (array[i].microamp == microamp)
-			return array[i].reg_val;
-	}
-
-	return -EINVAL;
-}
-
-/**
- * ksz_drive_strength_error() - Report invalid drive strength value
- * @dev:	ksz device
- * @array:	The array of drive strength values to search.
- * @array_size:	The size of the array.
- * @microamp:	Invalid drive strength value in microamp
- *
- * This function logs an error message when an unsupported drive strength value
- * is detected. It lists out all the supported drive strength values for
- * reference in the error message.
- */
-static void ksz_drive_strength_error(struct ksz_device *dev,
-				     const struct ksz_drive_strength *array,
-				     size_t array_size, int microamp)
-{
-	char supported_values[100];
-	size_t remaining_size;
-	int added_len;
-	char *ptr;
-	int i;
-
-	remaining_size = sizeof(supported_values);
-	ptr = supported_values;
-
-	for (i = 0; i < array_size; i++) {
-		added_len = snprintf(ptr, remaining_size,
-				     i == 0 ? "%d" : ", %d", array[i].microamp);
-
-		if (added_len >= remaining_size)
-			break;
-
-		ptr += added_len;
-		remaining_size -= added_len;
-	}
-
-	dev_err(dev->dev, "Invalid drive strength %d, supported values are %s\n",
-		microamp, supported_values);
-}
-
-/**
- * ksz9477_drive_strength_write() - Set the drive strength for specific KSZ9477
- *				    chip variants.
- * @dev:       ksz device
- * @props:     Array of drive strength properties to be applied
- * @num_props: Number of properties in the array
- *
- * This function configures the drive strength for various KSZ9477 chip variants
- * based on the provided properties. It handles chip-specific nuances and
- * ensures only valid drive strengths are written to the respective chip.
- *
- * Return: 0 on successful configuration, a negative error code on failure.
- */
-static int ksz9477_drive_strength_write(struct ksz_device *dev,
-					struct ksz_driver_strength_prop *props,
-					int num_props)
-{
-	size_t array_size = ARRAY_SIZE(ksz9477_drive_strengths);
-	int i, ret, reg;
-	u8 mask = 0;
-	u8 val = 0;
-
-	if (props[KSZ_DRIVER_STRENGTH_IO].value != -1)
-		dev_warn(dev->dev, "%s is not supported by this chip variant\n",
-			 props[KSZ_DRIVER_STRENGTH_IO].name);
-
-	if (dev->chip_id == KSZ8795_CHIP_ID ||
-	    dev->chip_id == KSZ8794_CHIP_ID ||
-	    dev->chip_id == KSZ8765_CHIP_ID)
-		reg = KSZ8795_REG_SW_CTRL_20;
-	else
-		reg = KSZ9477_REG_SW_IO_STRENGTH;
-
-	for (i = 0; i < num_props; i++) {
-		if (props[i].value == -1)
-			continue;
-
-		ret = ksz_drive_strength_to_reg(ksz9477_drive_strengths,
-						array_size, props[i].value);
-		if (ret < 0) {
-			ksz_drive_strength_error(dev, ksz9477_drive_strengths,
-						 array_size, props[i].value);
-			return ret;
-		}
-
-		mask |= SW_DRIVE_STRENGTH_M << props[i].offset;
-		val |= ret << props[i].offset;
-	}
-
-	return ksz_rmw8(dev, reg, mask, val);
-}
-
-/**
- * ksz8830_drive_strength_write() - Set the drive strength configuration for
- *				    KSZ8830 compatible chip variants.
- * @dev:       ksz device
- * @props:     Array of drive strength properties to be set
- * @num_props: Number of properties in the array
- *
- * This function applies the specified drive strength settings to KSZ8830 chip
- * variants (KSZ8873, KSZ8863).
- * It ensures the configurations align with what the chip variant supports and
- * warns or errors out on unsupported settings.
- *
- * Return: 0 on success, error code otherwise
- */
-static int ksz8830_drive_strength_write(struct ksz_device *dev,
-					struct ksz_driver_strength_prop *props,
-					int num_props)
-{
-	size_t array_size = ARRAY_SIZE(ksz8830_drive_strengths);
-	int microamp;
-	int i, ret;
-
-	for (i = 0; i < num_props; i++) {
-		if (props[i].value == -1 || i == KSZ_DRIVER_STRENGTH_IO)
-			continue;
-
-		dev_warn(dev->dev, "%s is not supported by this chip variant\n",
-			 props[i].name);
-	}
-
-	microamp = props[KSZ_DRIVER_STRENGTH_IO].value;
-	ret = ksz_drive_strength_to_reg(ksz8830_drive_strengths, array_size,
-					microamp);
-	if (ret < 0) {
-		ksz_drive_strength_error(dev, ksz8830_drive_strengths,
-					 array_size, microamp);
-		return ret;
-	}
-
-	return ksz_rmw8(dev, KSZ8873_REG_GLOBAL_CTRL_12,
-			KSZ8873_DRIVE_STRENGTH_16MA, ret);
-}
-
-/**
- * ksz_parse_drive_strength() - Extract and apply drive strength configurations
- *				from device tree properties.
- * @dev:	ksz device
- *
- * This function reads the specified drive strength properties from the
- * device tree, validates against the supported chip variants, and sets
- * them accordingly. An error should be critical here, as the drive strength
- * settings are crucial for EMI compliance.
- *
- * Return: 0 on success, error code otherwise
- */
-static int ksz_parse_drive_strength(struct ksz_device *dev)
-{
-	struct ksz_driver_strength_prop of_props[] = {
-		[KSZ_DRIVER_STRENGTH_HI] = {
-			.name = "microchip,hi-drive-strength-microamp",
-			.offset = SW_HI_SPEED_DRIVE_STRENGTH_S,
-			.value = -1,
-		},
-		[KSZ_DRIVER_STRENGTH_LO] = {
-			.name = "microchip,lo-drive-strength-microamp",
-			.offset = SW_LO_SPEED_DRIVE_STRENGTH_S,
-			.value = -1,
-		},
-		[KSZ_DRIVER_STRENGTH_IO] = {
-			.name = "microchip,io-drive-strength-microamp",
-			.offset = 0, /* don't care */
-			.value = -1,
-		},
-	};
-	struct device_node *np = dev->dev->of_node;
-	bool have_any_prop = false;
-	int i, ret;
-
-	for (i = 0; i < ARRAY_SIZE(of_props); i++) {
-		ret = of_property_read_u32(np, of_props[i].name,
-					   &of_props[i].value);
-		if (ret && ret != -EINVAL)
-			dev_warn(dev->dev, "Failed to read %s\n",
-				 of_props[i].name);
-		if (ret)
-			continue;
-
-		have_any_prop = true;
-	}
-
-	if (!have_any_prop)
-		return 0;
-
-	switch (dev->chip_id) {
-	case KSZ8830_CHIP_ID:
-		return ksz8830_drive_strength_write(dev, of_props,
-						    ARRAY_SIZE(of_props));
-	case KSZ8795_CHIP_ID:
-	case KSZ8794_CHIP_ID:
-	case KSZ8765_CHIP_ID:
-	case KSZ8563_CHIP_ID:
-	case KSZ8567_CHIP_ID:
-	case KSZ9477_CHIP_ID:
-	case KSZ9563_CHIP_ID:
-	case KSZ9567_CHIP_ID:
-	case KSZ9893_CHIP_ID:
-	case KSZ9896_CHIP_ID:
-	case KSZ9897_CHIP_ID:
-		return ksz9477_drive_strength_write(dev, of_props,
-						    ARRAY_SIZE(of_props));
-	default:
-		for (i = 0; i < ARRAY_SIZE(of_props); i++) {
-			if (of_props[i].value == -1)
-				continue;
-
-			dev_warn(dev->dev, "%s is not supported by this chip variant\n",
-				 of_props[i].name);
-		}
-	}
-
-	return 0;
-}
-
 int ksz_switch_register(struct ksz_device *dev)
 {
 	const struct ksz_chip_data *info;
@@ -4345,10 +4349,6 @@ int ksz_switch_register(struct ksz_device *dev)
 	for (port_num = 0; port_num < dev->info->port_cnt; ++port_num)
 		dev->ports[port_num].interface = PHY_INTERFACE_MODE_NA;
 	if (dev->dev->of_node) {
-		ret = ksz_parse_drive_strength(dev);
-		if (ret)
-			return ret;
-
 		ret = of_get_phy_mode(dev->dev->of_node, &interface);
 		if (ret == 0)
 			dev->compat_interface = interface;
-- 
2.39.2


