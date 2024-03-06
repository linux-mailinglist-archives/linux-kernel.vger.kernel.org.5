Return-Path: <linux-kernel+bounces-93257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B12C8872D1E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40C611F2899F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F4C13FF6;
	Wed,  6 Mar 2024 02:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SMmCPwTL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4A3101D5
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 02:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709693924; cv=none; b=uCBQXS50gr1cJZ/de98AAXrP2ZXzBHNqCtsG+q0+/zUhqtuEL4US8rqk/H/2h3YqDNV3qil752iGu9L6PZEYSVznxatKFIUOAtTF8pc9qdZ+ZugsPCwkc48ZmCozBEH+rv35Xs1DZ5hJ1GXOlGz71EuD3dCP0qaQQXEFebQ4WKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709693924; c=relaxed/simple;
	bh=u5XzMlnY4+tTSryX0rYuMqOLUdw+8I1od7UBF8OxdRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hpbx3RzcKzIXx9+khHS2/uyBB+DyjaPDrrgByho2fFDbe4+yllP0etDgaiG2Zf36vSuNDjgrYKUEx7JzHtwqOmhYB8gHbNiwHNT2Kd/sFV99MybTa4/0J13cV8dfVyx7+59idF+/XGdhJ6e46ThJnDN0JJ2kQx4VnRMPDFKd4/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SMmCPwTL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709693921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d6Feb/kkhpCYsSkkmMKP8hofHJvVLIgNb/bdVhbvDgc=;
	b=SMmCPwTL48XtSvUxOUYVIo4q631fh2JiuKfQT+nXHr/q27Adf9yEUPvcQ86xlXXuytcE/Z
	j1jaz/8CKRxaHHEPBZvUdxdsfwG8hGs7XUZ+2wJQoKL8I34ZrNIoQvXYBcfql4We4K+B7h
	TdIDNW5Pc2aecfDw7+vFtSAmDHOmxdQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-48gyDewVMoKW3Rwm2DJGVg-1; Tue, 05 Mar 2024 21:58:36 -0500
X-MC-Unique: 48gyDewVMoKW3Rwm2DJGVg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1EFCA80F7E4;
	Wed,  6 Mar 2024 02:58:36 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.36])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9BE611121306;
	Wed,  6 Mar 2024 02:58:31 +0000 (UTC)
From: Kate Hsuan <hpa@redhat.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	linux-leds@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>,
	linux-kernel@vger.kernel.org
Cc: Kate Hsuan <hpa@redhat.com>
Subject: [PATCH v4 2/2] leds: rgb: leds-ktd202x: Get device properties through fwnode to support ACPI
Date: Wed,  6 Mar 2024 10:58:01 +0800
Message-ID: <20240306025801.8814-3-hpa@redhat.com>
In-Reply-To: <20240306025801.8814-1-hpa@redhat.com>
References: <20240306025801.8814-1-hpa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

This LED controller also installed on a Xiaomi pad2 and it is a x86
platform. The original driver is based on device tree and can't be
used for this ACPI based system. This patch migrated the driver to
use fwnode to access the properties. Moreover, the fwnode API
supports device tree so this work won't effect the original
implementations.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/leds/rgb/Kconfig        |  1 -
 drivers/leds/rgb/leds-ktd202x.c | 60 ++++++++++++++++++++++-----------
 2 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/drivers/leds/rgb/Kconfig b/drivers/leds/rgb/Kconfig
index a6a21f564673..f245dbd9a163 100644
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
index 514965795a10..fb0d7c102dea 100644
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
+static int ktd202x_setup_led_rgb(struct ktd202x *chip, struct fwnode_handle *np,
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
+	fwnode_for_each_available_child_node(np, child) {
+		num_channels++;
+	}
 	if (!num_channels || num_channels > chip->num_leds)
 		return -EINVAL;
 
@@ -398,22 +400,22 @@ static int ktd202x_setup_led_rgb(struct ktd202x *chip, struct device_node *np,
 	if (!info)
 		return -ENOMEM;
 
-	for_each_available_child_of_node(np, child) {
+	fwnode_for_each_available_child_node(np, child) {
 		u32 mono_color;
 		u32 reg;
 		int ret;
 
-		ret = of_property_read_u32(child, "reg", &reg);
+		ret = fwnode_property_read_u32(child, "reg", &reg);
 		if (ret != 0 || reg >= chip->num_leds) {
 			dev_err(chip->dev, "invalid 'reg' of %pOFn\n", child);
-			of_node_put(child);
+			fwnode_handle_put(child);
 			return -EINVAL;
 		}
 
-		ret = of_property_read_u32(child, "color", &mono_color);
+		ret = fwnode_property_read_u32(child, "color", &mono_color);
 		if (ret < 0 && ret != -EINVAL) {
 			dev_err(chip->dev, "failed to parse 'color' of %pOF\n", child);
-			of_node_put(child);
+			fwnode_handle_put(child);
 			return ret;
 		}
 
@@ -433,14 +435,14 @@ static int ktd202x_setup_led_rgb(struct ktd202x *chip, struct device_node *np,
 	return devm_led_classdev_multicolor_register_ext(chip->dev, &led->mcdev, init_data);
 }
 
-static int ktd202x_setup_led_single(struct ktd202x *chip, struct device_node *np,
+static int ktd202x_setup_led_single(struct ktd202x *chip, struct fwnode_handle *np,
 				    struct ktd202x_led *led, struct led_init_data *init_data)
 {
 	struct led_classdev *cdev;
 	u32 reg;
 	int ret;
 
-	ret = of_property_read_u32(np, "reg", &reg);
+	ret = fwnode_property_read_u32(np, "reg", &reg);
 	if (ret != 0 || reg >= chip->num_leds) {
 		dev_err(chip->dev, "invalid 'reg' of %pOFn\n", np);
 		return -EINVAL;
@@ -454,7 +456,7 @@ static int ktd202x_setup_led_single(struct ktd202x *chip, struct device_node *np
 	return devm_led_classdev_register_ext(chip->dev, &led->cdev, init_data);
 }
 
-static int ktd202x_add_led(struct ktd202x *chip, struct device_node *np, unsigned int index)
+static int ktd202x_add_led(struct ktd202x *chip, struct fwnode_handle *np, unsigned int index)
 {
 	struct ktd202x_led *led = &chip->leds[index];
 	struct led_init_data init_data = {};
@@ -463,14 +465,14 @@ static int ktd202x_add_led(struct ktd202x *chip, struct device_node *np, unsigne
 	int ret;
 
 	/* Color property is optional in single color case */
-	ret = of_property_read_u32(np, "color", &color);
+	ret = fwnode_property_read_u32(np, "color", &color);
 	if (ret < 0 && ret != -EINVAL) {
 		dev_err(chip->dev, "failed to parse 'color' of %pOF\n", np);
 		return ret;
 	}
 
 	led->chip = chip;
-	init_data.fwnode = of_fwnode_handle(np);
+	init_data.fwnode = np;
 
 	if (color == LED_COLOR_ID_RGB) {
 		cdev = &led->mcdev.led_cdev;
@@ -492,26 +494,30 @@ static int ktd202x_add_led(struct ktd202x *chip, struct device_node *np, unsigne
 
 static int ktd202x_probe_dt(struct ktd202x *chip)
 {
-	struct device_node *np = dev_of_node(chip->dev), *child;
+	struct fwnode_handle *child, *np;
+	struct device *dev = chip->dev;
 	int count;
 	int i = 0;
 
-	chip->num_leds = (int)(unsigned long)of_device_get_match_data(chip->dev);
+	count = device_get_child_node_count(dev);
 
-	count = of_get_available_child_count(np);
 	if (!count || count > chip->num_leds)
 		return -EINVAL;
 
+	np = dev_fwnode(chip->dev);
+	if (!np)
+		return -ENODEV;
+
 	regmap_write(chip->regmap, KTD202X_REG_RESET_CONTROL, KTD202X_RSTR_RESET);
 
 	/* Allow the device to execute the complete reset */
 	usleep_range(200, 300);
 
-	for_each_available_child_of_node(np, child) {
+	fwnode_for_each_available_child_node(np, child) {
 		int ret = ktd202x_add_led(chip, child, i);
 
 		if (ret) {
-			of_node_put(child);
+			fwnode_handle_put(child);
 			return ret;
 		}
 		i++;
@@ -568,6 +574,8 @@ static int ktd202x_probe(struct i2c_client *client)
 		return ret;
 	}
 
+	chip->num_leds = (unsigned long)i2c_get_match_data(client);
+
 	ret = ktd202x_probe_dt(chip);
 	if (ret < 0) {
 		regulator_bulk_disable(ARRAY_SIZE(chip->regulators), chip->regulators);
@@ -602,21 +610,33 @@ static void ktd202x_shutdown(struct i2c_client *client)
 	regmap_write(chip->regmap, KTD202X_REG_RESET_CONTROL, KTD202X_RSTR_RESET);
 }
 
+static const struct i2c_device_id ktd202x_id[] = {
+	{"ktd2026", KTD2026_NUM_LEDS},
+	{"ktd2027", KTD2027_NUM_LEDS},
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, ktd202x_id);
+
+#ifndef CONFIG_ACPI
 static const struct of_device_id ktd202x_match_table[] = {
 	{ .compatible = "kinetic,ktd2026", .data = (void *)KTD2026_NUM_LEDS },
 	{ .compatible = "kinetic,ktd2027", .data = (void *)KTD2027_NUM_LEDS },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ktd202x_match_table);
+#endif
 
 static struct i2c_driver ktd202x_driver = {
 	.driver = {
 		.name = "leds-ktd202x",
+#ifndef CONFIG_ACPI
 		.of_match_table = ktd202x_match_table,
+#endif
 	},
 	.probe = ktd202x_probe,
 	.remove = ktd202x_remove,
 	.shutdown = ktd202x_shutdown,
+	.id_table = ktd202x_id,
 };
 module_i2c_driver(ktd202x_driver);
 
-- 
2.43.2


