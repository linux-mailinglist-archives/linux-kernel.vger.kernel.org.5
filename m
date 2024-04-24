Return-Path: <linux-kernel+bounces-156412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DB28B0282
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A4C5B23207
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2499156F21;
	Wed, 24 Apr 2024 06:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bF8+tozz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C16B156C53
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941607; cv=none; b=m3BpQ4pOsN6ql1jtYYR++hTQizMhzeiUSOuDWphUz579jiTt075xaskJQn7tJnhhJRXHKRyjGuLTTpkGNjhNCymL4MtYGYlCOZ8DBFq5Y0nBVBxHJUlyxN2u32aHg+uCCOqJ4zARGoSK5FQqEplI4yT3VgDnv+Ohq5RdfIcFwSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941607; c=relaxed/simple;
	bh=ci92G/ou2uH85ciA1lCqnKer9QpBSxLGMQcuzQL2UYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LHLjp44/DyVFOlfYKJBwcAbXgcPBvSl02KeYanxJ6CzQAi09yhPcDhJJpCuzo7xMI7H7lMlJnSPn3YMqKU5VSt1uTHij32Nspydpvdy8yd6sWh2rAgQ63ywpYQ84SxJRyzb+ZUbFgVzrr+2D79PoUeGon2Qy9MsaZ1SS8LtKZxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bF8+tozz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713941605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wlyAgauEYi0BjAtdrpMyEHFGdd2VOJ0uxMs2Qc1nZ18=;
	b=bF8+tozzh3Po6JyY6Jzl/3WRWbRZvg92ucZr+gs3GIvhHTEpqRYt/x32yXwKBaPyD6HGcX
	uV4gQaZGEIOOCLAAUWCOy5uikLGubnfbCuZ9CaZ3fEF9hM9jWi92oHM1O9RFa4lUeb8XCp
	okt7hSAINT3PG+3kKzl6MkFRA+EMHt4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-_w9v8rVIOBWydJPxEHNWpw-1; Wed,
 24 Apr 2024 02:53:20 -0400
X-MC-Unique: _w9v8rVIOBWydJPxEHNWpw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69B2A1C0C650;
	Wed, 24 Apr 2024 06:53:19 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.73])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 96A61C13FA3;
	Wed, 24 Apr 2024 06:53:13 +0000 (UTC)
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
Subject: [PATCH v7 1/6] leds: rgb: leds-ktd202x: Get device properties through fwnode to support ACPI
Date: Wed, 24 Apr 2024 14:52:07 +0800
Message-ID: <20240424065212.263784-2-hpa@redhat.com>
In-Reply-To: <20240424065212.263784-1-hpa@redhat.com>
References: <20240424065212.263784-1-hpa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

This LED controller is installed on a Xiaomi pad2 and it is an x86
platform. The original driver is based on the device tree and can't be
used for this ACPI based system. This patch migrated the driver to use
fwnode to access the properties. Moreover, the fwnode API supports the
device tree so this work won't affect the original implementations.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
Tested-by: André Apitzsch <git@apitzsch.eu> # on BQ Aquaris M5
---
 drivers/leds/rgb/Kconfig        |  1 -
 drivers/leds/rgb/leds-ktd202x.c | 64 +++++++++++++++++----------------
 2 files changed, 34 insertions(+), 31 deletions(-)

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
index 514965795a10..f1c810c415a4 100644
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
 
@@ -381,16 +381,19 @@ static int ktd202x_blink_mc_set(struct led_classdev *cdev,
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
 	int num_channels;
 	int i = 0;
 
-	num_channels = of_get_available_child_count(np);
+	num_channels = 0;
+	fwnode_for_each_available_child_node(fwnode, child)
+		num_channels++;
+
 	if (!num_channels || num_channels > chip->num_leds)
 		return -EINVAL;
 
@@ -398,22 +401,22 @@ static int ktd202x_setup_led_rgb(struct ktd202x *chip, struct device_node *np,
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
 
@@ -433,16 +436,16 @@ static int ktd202x_setup_led_rgb(struct ktd202x *chip, struct device_node *np,
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
@@ -454,7 +457,7 @@ static int ktd202x_setup_led_single(struct ktd202x *chip, struct device_node *np
 	return devm_led_classdev_register_ext(chip->dev, &led->cdev, init_data);
 }
 
-static int ktd202x_add_led(struct ktd202x *chip, struct device_node *np, unsigned int index)
+static int ktd202x_add_led(struct ktd202x *chip, struct fwnode_handle *fwnode, unsigned int index)
 {
 	struct ktd202x_led *led = &chip->leds[index];
 	struct led_init_data init_data = {};
@@ -463,21 +466,21 @@ static int ktd202x_add_led(struct ktd202x *chip, struct device_node *np, unsigne
 	int ret;
 
 	/* Color property is optional in single color case */
-	ret = of_property_read_u32(np, "color", &color);
+	ret = fwnode_property_read_u32(fwnode, "color", &color);
 	if (ret < 0 && ret != -EINVAL) {
-		dev_err(chip->dev, "failed to parse 'color' of %pOF\n", np);
+		dev_err(chip->dev, "failed to parse 'color' of %pfw\n", fwnode);
 		return ret;
 	}
 
 	led->chip = chip;
-	init_data.fwnode = of_fwnode_handle(np);
+	init_data.fwnode = fwnode;
 
 	if (color == LED_COLOR_ID_RGB) {
 		cdev = &led->mcdev.led_cdev;
-		ret = ktd202x_setup_led_rgb(chip, np, led, &init_data);
+		ret = ktd202x_setup_led_rgb(chip, fwnode, led, &init_data);
 	} else {
 		cdev = &led->cdev;
-		ret = ktd202x_setup_led_single(chip, np, led, &init_data);
+		ret = ktd202x_setup_led_single(chip, fwnode, led, &init_data);
 	}
 
 	if (ret) {
@@ -490,15 +493,14 @@ static int ktd202x_add_led(struct ktd202x *chip, struct device_node *np, unsigne
 	return 0;
 }
 
-static int ktd202x_probe_dt(struct ktd202x *chip)
+static int ktd202x_probe_fw(struct ktd202x *chip)
 {
-	struct device_node *np = dev_of_node(chip->dev), *child;
+	struct fwnode_handle *child;
+	struct device *dev = chip->dev;
 	int count;
 	int i = 0;
 
-	chip->num_leds = (int)(unsigned long)of_device_get_match_data(chip->dev);
-
-	count = of_get_available_child_count(np);
+	count = device_get_child_node_count(dev);
 	if (!count || count > chip->num_leds)
 		return -EINVAL;
 
@@ -507,11 +509,11 @@ static int ktd202x_probe_dt(struct ktd202x *chip)
 	/* Allow the device to execute the complete reset */
 	usleep_range(200, 300);
 
-	for_each_available_child_of_node(np, child) {
+	device_for_each_child_node(dev, child) {
 		int ret = ktd202x_add_led(chip, child, i);
 
 		if (ret) {
-			of_node_put(child);
+			fwnode_handle_put(child);
 			return ret;
 		}
 		i++;
@@ -554,6 +556,8 @@ static int ktd202x_probe(struct i2c_client *client)
 		return ret;
 	}
 
+	chip->num_leds = (unsigned long)i2c_get_match_data(client);
+
 	chip->regulators[0].supply = "vin";
 	chip->regulators[1].supply = "vio";
 	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(chip->regulators), chip->regulators);
@@ -568,7 +572,7 @@ static int ktd202x_probe(struct i2c_client *client)
 		return ret;
 	}
 
-	ret = ktd202x_probe_dt(chip);
+	ret = ktd202x_probe_fw(chip);
 	if (ret < 0) {
 		regulator_bulk_disable(ARRAY_SIZE(chip->regulators), chip->regulators);
 		return ret;
@@ -605,7 +609,7 @@ static void ktd202x_shutdown(struct i2c_client *client)
 static const struct of_device_id ktd202x_match_table[] = {
 	{ .compatible = "kinetic,ktd2026", .data = (void *)KTD2026_NUM_LEDS },
 	{ .compatible = "kinetic,ktd2027", .data = (void *)KTD2027_NUM_LEDS },
-	{},
+	{}
 };
 MODULE_DEVICE_TABLE(of, ktd202x_match_table);
 
-- 
2.44.0


