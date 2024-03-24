Return-Path: <linux-kernel+bounces-112718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04123887D51
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 16:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 279871C20B0D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 15:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F49B18622;
	Sun, 24 Mar 2024 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ua2U+Szm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24BB18E3A
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711292541; cv=none; b=WD6tgOWUxZP1fzSHxQGNpYqjSmfq8kZBWklEkWjBqySvnxZNhAyh5dwfsE7SXGDUDoV9k4wwgWLP54tRgZzm5ZMWhkBIQnGOXLav8w5goQ41FVN1EysI8+8hDnhlBYUUIIZKzbcJmWlaehvIHP0epZoQMQHojL6jIeezw1/oszw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711292541; c=relaxed/simple;
	bh=8wviMhjez8ynGNwxq6Vg2dxfdPvyQOxfXdc24FAdb7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T5SqDlwd52AuObbAyZ4ZYsFL5XRg6XacZ0udxlpv9MoYuXctg6sJ6Lo9q+f2ORxSgwmgPKts2/b5Bl2FCquNKsHowT2WFzJhPT1IyNO7ETQhXEu8hIi1y31GIMLy6mIk4f3LU/MFvhRFp7bYewRJcsQ6CKc4bwSr32RL3mxD5JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ua2U+Szm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711292538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Juxh0o/TxvNt1GDxQbgCsHCyOLSlssRhx4+JL5fURqc=;
	b=Ua2U+SzmznwBS7UWcnw875tHKsRpknDQHDNa6yNkzAQRtwhnloJEaFVg41X4u/RttHGZZA
	pvUeKz75SwNhUYNYCD963JaAZzOx66L23SK2515immYW0Il7t7WWkf/Rr0P1QDcik264R9
	AuyuOTxYQTd+0afeyPY4tqkst8zVToA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-aVjBiEaCPj-8hqSNNQQKxA-1; Sun,
 24 Mar 2024 11:02:13 -0400
X-MC-Unique: aVjBiEaCPj-8hqSNNQQKxA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 989C02804802;
	Sun, 24 Mar 2024 15:02:12 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.75])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DE3AB40C6DAE;
	Sun, 24 Mar 2024 15:02:06 +0000 (UTC)
From: Kate Hsuan <hpa@redhat.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	linux-leds@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Kate Hsuan <hpa@redhat.com>
Subject: [PATCH v5 RESEND 2/6] leds: rgb: leds-ktd202x: Get device properties through fwnode to support ACPI
Date: Sun, 24 Mar 2024 23:01:03 +0800
Message-ID: <20240324150107.976025-3-hpa@redhat.com>
In-Reply-To: <20240324150107.976025-1-hpa@redhat.com>
References: <20240324150107.976025-1-hpa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

This LED controller also installed on a Xiaomi pad2 and it is a x86
platform. The original driver is based on device tree and can't be
used for this ACPI based system. This patch migrated the driver to
use fwnode to access the properties. Moreover, the fwnode API
supports device tree so this work won't effect the original
implementations.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/leds/rgb/Kconfig        |  1 -
 drivers/leds/rgb/leds-ktd202x.c | 75 ++++++++++++++++++++-------------
 2 files changed, 46 insertions(+), 30 deletions(-)

diff --git a/drivers/leds/rgb/Kconfig b/drivers/leds/rgb/Kconfig
index e66bd21b9852..14d6b294a786 100644
--- a/drivers/leds/rgb/Kconfig
+++ b/drivers/leds/rgb/Kconfig
@@ -17,7 +17,6 @@ config LEDS_GROUP_MULTICOLOR
 config LEDS_KTD202X
 	tristate "LED support for KTD202x Chips"
 	depends on I2C
-	depends on OF
 	select REGMAP_I2C
 	help
 	  This option enables support for the Kinetic KTD2026/KTD2027
diff --git a/drivers/leds/rgb/leds-ktd202x.c b/drivers/leds/rgb/leds-ktd202x.c
index 514965795a10..a75c300040c7 100644
--- a/drivers/leds/rgb/leds-ktd202x.c
+++ b/drivers/leds/rgb/leds-ktd202x.c
@@ -99,7 +99,7 @@ struct ktd202x {
 	struct device *dev;
 	struct regmap *regmap;
 	bool enabled;
-	int num_leds;
+	unsigned long num_leds;
 	struct ktd202x_led leds[] __counted_by(num_leds);
 };
 
@@ -381,16 +381,18 @@ static int ktd202x_blink_mc_set(struct led_classdev *cdev,
 				 mc->num_colors);
 }
 
-static int ktd202x_setup_led_rgb(struct ktd202x *chip, struct device_node *np,
+static int ktd202x_setup_led_rgb(struct ktd202x *chip, struct fwnode_handle *fwnode,
 				 struct ktd202x_led *led, struct led_init_data *init_data)
 {
+	struct fwnode_handle *child;
 	struct led_classdev *cdev;
-	struct device_node *child;
 	struct mc_subled *info;
-	int num_channels;
+	int num_channels = 0;
 	int i = 0;
 
-	num_channels = of_get_available_child_count(np);
+	fwnode_for_each_available_child_node(fwnode, child) {
+		num_channels++;
+	}
 	if (!num_channels || num_channels > chip->num_leds)
 		return -EINVAL;
 
@@ -398,22 +400,22 @@ static int ktd202x_setup_led_rgb(struct ktd202x *chip, struct device_node *np,
 	if (!info)
 		return -ENOMEM;
 
-	for_each_available_child_of_node(np, child) {
+	fwnode_for_each_available_child_node(fwnode, child) {
 		u32 mono_color;
 		u32 reg;
 		int ret;
 
-		ret = of_property_read_u32(child, "reg", &reg);
+		ret = fwnode_property_read_u32(child, "reg", &reg);
 		if (ret != 0 || reg >= chip->num_leds) {
-			dev_err(chip->dev, "invalid 'reg' of %pOFn\n", child);
-			of_node_put(child);
-			return -EINVAL;
+			dev_err(chip->dev, "invalid 'reg' of %pfw\n", child);
+			fwnode_handle_put(child);
+			return ret;
 		}
 
-		ret = of_property_read_u32(child, "color", &mono_color);
+		ret = fwnode_property_read_u32(child, "color", &mono_color);
 		if (ret < 0 && ret != -EINVAL) {
-			dev_err(chip->dev, "failed to parse 'color' of %pOF\n", child);
-			of_node_put(child);
+			dev_err(chip->dev, "failed to parse 'color' of %pfw\n", child);
+			fwnode_handle_put(child);
 			return ret;
 		}
 
@@ -433,16 +435,16 @@ static int ktd202x_setup_led_rgb(struct ktd202x *chip, struct device_node *np,
 	return devm_led_classdev_multicolor_register_ext(chip->dev, &led->mcdev, init_data);
 }
 
-static int ktd202x_setup_led_single(struct ktd202x *chip, struct device_node *np,
+static int ktd202x_setup_led_single(struct ktd202x *chip, struct fwnode_handle *fwnode,
 				    struct ktd202x_led *led, struct led_init_data *init_data)
 {
 	struct led_classdev *cdev;
 	u32 reg;
 	int ret;
 
-	ret = of_property_read_u32(np, "reg", &reg);
+	ret = fwnode_property_read_u32(fwnode, "reg", &reg);
 	if (ret != 0 || reg >= chip->num_leds) {
-		dev_err(chip->dev, "invalid 'reg' of %pOFn\n", np);
+		dev_err(chip->dev, "invalid 'reg' of %pfw\n", fwnode);
 		return -EINVAL;
 	}
 	led->index = reg;
@@ -454,7 +456,9 @@ static int ktd202x_setup_led_single(struct ktd202x *chip, struct device_node *np
 	return devm_led_classdev_register_ext(chip->dev, &led->cdev, init_data);
 }
 
-static int ktd202x_add_led(struct ktd202x *chip, struct device_node *np, unsigned int index)
+static int ktd202x_add_led(struct ktd202x *chip,
+			   struct fwnode_handle *fwnode_color,
+			   unsigned int index)
 {
 	struct ktd202x_led *led = &chip->leds[index];
 	struct led_init_data init_data = {};
@@ -463,21 +467,21 @@ static int ktd202x_add_led(struct ktd202x *chip, struct device_node *np, unsigne
 	int ret;
 
 	/* Color property is optional in single color case */
-	ret = of_property_read_u32(np, "color", &color);
+	ret = fwnode_property_read_u32(fwnode_color, "color", &color);
 	if (ret < 0 && ret != -EINVAL) {
-		dev_err(chip->dev, "failed to parse 'color' of %pOF\n", np);
+		dev_err(chip->dev, "failed to parse 'color' of %pfw\n", fwnode_color);
 		return ret;
 	}
 
 	led->chip = chip;
-	init_data.fwnode = of_fwnode_handle(np);
+	init_data.fwnode = fwnode_color;
 
 	if (color == LED_COLOR_ID_RGB) {
 		cdev = &led->mcdev.led_cdev;
-		ret = ktd202x_setup_led_rgb(chip, np, led, &init_data);
+		ret = ktd202x_setup_led_rgb(chip, fwnode_color, led, &init_data);
 	} else {
 		cdev = &led->cdev;
-		ret = ktd202x_setup_led_single(chip, np, led, &init_data);
+		ret = ktd202x_setup_led_single(chip, fwnode_color, led, &init_data);
 	}
 
 	if (ret) {
@@ -492,26 +496,29 @@ static int ktd202x_add_led(struct ktd202x *chip, struct device_node *np, unsigne
 
 static int ktd202x_probe_dt(struct ktd202x *chip)
 {
-	struct device_node *np = dev_of_node(chip->dev), *child;
+	struct fwnode_handle *child, *fwnode;
+	struct device *dev = chip->dev;
 	int count;
 	int i = 0;
 
-	chip->num_leds = (int)(unsigned long)of_device_get_match_data(chip->dev);
-
-	count = of_get_available_child_count(np);
+	count = device_get_child_node_count(dev);
 	if (!count || count > chip->num_leds)
 		return -EINVAL;
 
+	fwnode = dev_fwnode(chip->dev);
+	if (!fwnode)
+		return -ENODEV;
+
 	regmap_write(chip->regmap, KTD202X_REG_RESET_CONTROL, KTD202X_RSTR_RESET);
 
 	/* Allow the device to execute the complete reset */
 	usleep_range(200, 300);
 
-	for_each_available_child_of_node(np, child) {
+	fwnode_for_each_available_child_node(fwnode, child) {
 		int ret = ktd202x_add_led(chip, child, i);
 
 		if (ret) {
-			of_node_put(child);
+			fwnode_handle_put(child);
 			return ret;
 		}
 		i++;
@@ -554,6 +561,8 @@ static int ktd202x_probe(struct i2c_client *client)
 		return ret;
 	}
 
+	chip->num_leds = (unsigned long)i2c_get_match_data(client);
+
 	chip->regulators[0].supply = "vin";
 	chip->regulators[1].supply = "vio";
 	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(chip->regulators), chip->regulators);
@@ -602,10 +611,17 @@ static void ktd202x_shutdown(struct i2c_client *client)
 	regmap_write(chip->regmap, KTD202X_REG_RESET_CONTROL, KTD202X_RSTR_RESET);
 }
 
+static const struct i2c_device_id ktd202x_id[] = {
+	{"ktd2026", KTD2026_NUM_LEDS},
+	{"ktd2027", KTD2027_NUM_LEDS},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, ktd202x_id);
+
 static const struct of_device_id ktd202x_match_table[] = {
 	{ .compatible = "kinetic,ktd2026", .data = (void *)KTD2026_NUM_LEDS },
 	{ .compatible = "kinetic,ktd2027", .data = (void *)KTD2027_NUM_LEDS },
-	{},
+	{}
 };
 MODULE_DEVICE_TABLE(of, ktd202x_match_table);
 
@@ -617,6 +633,7 @@ static struct i2c_driver ktd202x_driver = {
 	.probe = ktd202x_probe,
 	.remove = ktd202x_remove,
 	.shutdown = ktd202x_shutdown,
+	.id_table = ktd202x_id,
 };
 module_i2c_driver(ktd202x_driver);
 
-- 
2.44.0


