Return-Path: <linux-kernel+bounces-31925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F18D2833677
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 22:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3B2D281CF6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 21:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCB214F95;
	Sat, 20 Jan 2024 21:27:31 +0000 (UTC)
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B725A13FE2;
	Sat, 20 Jan 2024 21:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705786050; cv=none; b=fGvzQEsxgh/B3zV6Pi3rd4vVuaykYlQBE2bAogcukFmILpJc+xDEIEUvJybEokrh7XgadjbOvlT+ZI3RCHVKpikA5zupVCCD4GPcoi8HxRtdJcxBXPZkqqRfykBbiajoFbiN7KVrwF6lorUpTPdPZYXO/zRff4L95q457Rey0bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705786050; c=relaxed/simple;
	bh=FC1EjKKMu309UuB+RKeyqY3SuL54ONyCm0c9CWTGi94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AlPdDDYRYd1ZbRQ3BjHdGTXHls9i+8vpUxgOGclZQaCCgzUhkGGvqqy+K2NJ8eUDVm0UQiESbKiYuj36lgSSA5i5R+naDNRShAE1MsrsEfvcj0e9WBk9UoJnqu2iQNpQCQZPCRMmmRD1/c+xxUzPiqLedJ8jYyY9wfgGHkHdQIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id A801786C62;
	Sat, 20 Jan 2024 22:27:26 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Sat, 20 Jan 2024 22:26:45 +0100
Subject: [PATCH v3 3/3] backlight: Add Kinetic KTD2801 backlight support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240120-ktd2801-v3-3-fe2cbafffb21@skole.hr>
References: <20240120-ktd2801-v3-0-fe2cbafffb21@skole.hr>
In-Reply-To: <20240120-ktd2801-v3-0-fe2cbafffb21@skole.hr>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: Karel Balej <balejk@matfyz.cz>, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=7161;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=FC1EjKKMu309UuB+RKeyqY3SuL54ONyCm0c9CWTGi94=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlrDqXA8eeM1rneiarkBVOYjFzaCB2FaXFAQs9p
 n+qHN5uiYaJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZaw6lwAKCRCaEZ6wQi2W
 4UJkD/4tqCl58QQWHnetlBPLGttzp8B5bT6TS+OcDmEDyNHEPkSX5ZHB0YikL/Yiy1huO4s5phO
 jekA5tYJjzS3OnhWWiwCpd1+cFrp+htdAsrS9ab1lwCFFR9Om6nwoSaJuQ3AhtwKH1u4qgvClnJ
 FzRbQcrxk1qaWJy5ssxTEMXgI0pkUZEEqUa/3JYjDj6t9rofP8DImLvoo+aGvktm72qLJssnLWF
 QhoPQJaL8+A5VNk4R5AJA2EcDjgAHDFyG/eJTzA0mEYC51icvdS8LQJ9pKkPQ1jA/Lrymdldfqf
 7EoGK9JlUGlNnN3sqHiHAWmxe6HBWLfveV5kkjMe7AdwUwRQzUFqogMZceoOQHi9R9/ph2rga2q
 kL4LqZyaavvNMvaDJFO0y82q1cWLegOArF2DLT3I8yIrbmXQM4gBCKI30M63uOfwgAQIlNYnswM
 xAbnvJJZpObm/CRepA4Mo9upFFXXn8i0MiR8QgBO9V2xSfS+3zABMTqcgn/x2oEXth35TmqiC9D
 cpAe3Q6kNYwQZSHS3J5Bo19z6JIdRs9kSp7UBlhNe2P/NE4EtC21zOTyCX82d086EMg3fHHJSnN
 A7+Lue2TziTrHn1OHESMWw+F+ZaB2AauFVfmnOmU0J0PvAE5v0XzZ51unNvKUV/6yGg2f2da1l8
 ZrdFrpCM+ld7VcA==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

KTD2801 is a LED backlight driver IC found in samsung,coreprimevelte.
The brightness can be set using PWM or the ExpressWire protocol. Add
support for the KTD2801.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 MAINTAINERS                                 |   6 ++
 drivers/video/backlight/Kconfig             |   8 ++
 drivers/video/backlight/Makefile            |   1 +
 drivers/video/backlight/ktd2801-backlight.c | 143 ++++++++++++++++++++++++++++
 4 files changed, 158 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 87b12d2448a0..dddffbd8d2a0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11891,6 +11891,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/leds/backlight/kinetic,ktd253.yaml
 F:	drivers/video/backlight/ktd253-backlight.c
 
+KTD2801 BACKLIGHT DRIVER
+M:	Duje Mihanović <duje.mihanovic@skole.hr>
+S:	Maintained
+F:	Documentation/devicetree/bindings/leds/backlight/kinetic,ktd2801.yaml
+F:	drivers/video/backlight/ktd2801-backlight.c
+
 KTEST
 M:	Steven Rostedt <rostedt@goodmis.org>
 M:	John Hawley <warthog9@eaglescrag.net>
diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 51387b1ef012..585a5a713759 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -183,6 +183,14 @@ config BACKLIGHT_KTD253
 	  which is a 1-wire GPIO-controlled backlight found in some mobile
 	  phones.
 
+config BACKLIGHT_KTD2801
+	tristate "Backlight Driver for Kinetic KTD2801"
+	depends on GPIOLIB || COMPILE_TEST
+	select LEDS_EXPRESSWIRE
+	help
+	  Say Y to enable the backlight driver for the Kinetic KTD2801 1-wire
+	  GPIO-controlled backlight found in Samsung Galaxy Core Prime VE LTE.
+
 config BACKLIGHT_KTZ8866
 	tristate "Backlight Driver for Kinetic KTZ8866"
 	depends on I2C
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index f72e1c3c59e9..b33b647f31ca 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_BACKLIGHT_HP680)		+= hp680_bl.o
 obj-$(CONFIG_BACKLIGHT_HP700)		+= jornada720_bl.o
 obj-$(CONFIG_BACKLIGHT_IPAQ_MICRO)	+= ipaq_micro_bl.o
 obj-$(CONFIG_BACKLIGHT_KTD253)		+= ktd253-backlight.o
+obj-$(CONFIG_BACKLIGHT_KTD2801)		+= ktd2801-backlight.o
 obj-$(CONFIG_BACKLIGHT_KTZ8866)		+= ktz8866.o
 obj-$(CONFIG_BACKLIGHT_LM3533)		+= lm3533_bl.o
 obj-$(CONFIG_BACKLIGHT_LM3630A)		+= lm3630a_bl.o
diff --git a/drivers/video/backlight/ktd2801-backlight.c b/drivers/video/backlight/ktd2801-backlight.c
new file mode 100644
index 000000000000..7b9d1a93aa71
--- /dev/null
+++ b/drivers/video/backlight/ktd2801-backlight.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Datasheet:
+ * https://www.kinet-ic.com/uploads/web/KTD2801/KTD2801-04b.pdf
+ */
+#include <linux/backlight.h>
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/leds-expresswire.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+
+/* These values have been extracted from Samsung's driver. */
+#define KTD2801_EXPRESSWIRE_DETECT_DELAY_US	150
+#define KTD2801_EXPRESSWIRE_DETECT_US		270
+#define KTD2801_SHORT_BITSET_US			5
+#define KTD2801_LONG_BITSET_US			(3 * KTD2801_SHORT_BITSET_US)
+#define KTD2801_DATA_START_US			5
+#define KTD2801_END_OF_DATA_LOW_US		10
+#define KTD2801_END_OF_DATA_HIGH_US		350
+#define KTD2801_PWR_DOWN_DELAY_US		2600
+
+#define KTD2801_DEFAULT_BRIGHTNESS	100
+#define KTD2801_MAX_BRIGHTNESS		255
+
+const struct expresswire_timing ktd2801_timing = {
+	.poweroff_us = KTD2801_PWR_DOWN_DELAY_US,
+	.detect_delay_us = KTD2801_EXPRESSWIRE_DETECT_DELAY_US,
+	.detect_us = KTD2801_EXPRESSWIRE_DETECT_US,
+	.data_start_us = KTD2801_DATA_START_US,
+	.short_bitset_us = KTD2801_SHORT_BITSET_US,
+	.long_bitset_us = KTD2801_LONG_BITSET_US,
+	.end_of_data_low_us = KTD2801_END_OF_DATA_LOW_US,
+	.end_of_data_high_us = KTD2801_END_OF_DATA_HIGH_US
+};
+
+struct ktd2801_backlight {
+	struct expresswire_common_props props;
+	struct backlight_device *bd;
+	bool was_on;
+};
+
+static int ktd2801_update_status(struct backlight_device *bd)
+{
+	struct ktd2801_backlight *ktd2801 = bl_get_data(bd);
+	u8 brightness = (u8) backlight_get_brightness(bd);
+
+	if (backlight_is_blank(bd)) {
+		expresswire_power_off(&ktd2801->props);
+		ktd2801->was_on = false;
+		return 0;
+	}
+
+	if (!ktd2801->was_on) {
+		expresswire_enable(&ktd2801->props);
+		ktd2801->was_on = true;
+	}
+
+	expresswire_start(&ktd2801->props);
+
+	for (int i = 7; i >= 0; i--)
+		expresswire_set_bit(&ktd2801->props, !!(brightness & BIT(i)));
+
+	expresswire_end(&ktd2801->props);
+	return 0;
+}
+
+static const struct backlight_ops ktd2801_backlight_ops = {
+	.update_status = ktd2801_update_status,
+};
+
+static int ktd2801_backlight_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct backlight_device *bd;
+	struct ktd2801_backlight *ktd2801;
+	u32 brightness, max_brightness;
+	int ret;
+
+	ktd2801 = devm_kzalloc(dev, sizeof(*ktd2801), GFP_KERNEL);
+	if (!ktd2801)
+		return -ENOMEM;
+	ktd2801->was_on = true;
+	ktd2801->props.timing = ktd2801_timing;
+
+	ret = device_property_read_u32(dev, "max-brightness", &max_brightness);
+	if (ret)
+		max_brightness = KTD2801_MAX_BRIGHTNESS;
+	if (max_brightness > KTD2801_MAX_BRIGHTNESS) {
+		dev_err(dev, "illegal max brightness specified\n");
+		max_brightness = KTD2801_MAX_BRIGHTNESS;
+	}
+
+	ret = device_property_read_u32(dev, "default-brightness", &brightness);
+	if (ret)
+		brightness = KTD2801_DEFAULT_BRIGHTNESS;
+	if (brightness > max_brightness) {
+		dev_err(dev, "default brightness exceeds max\n");
+		brightness = max_brightness;
+	}
+
+	ktd2801->props.ctrl_gpio = devm_gpiod_get(dev, "ctrl", GPIOD_OUT_HIGH);
+	if (IS_ERR(ktd2801->props.ctrl_gpio))
+		return dev_err_probe(dev, PTR_ERR(ktd2801->props.ctrl_gpio),
+				"failed to get backlight GPIO");
+	gpiod_set_consumer_name(ktd2801->props.ctrl_gpio, dev_name(dev));
+
+	bd = devm_backlight_device_register(dev, dev_name(dev), dev, ktd2801,
+			&ktd2801_backlight_ops, NULL);
+	if (IS_ERR(bd))
+		return dev_err_probe(dev, PTR_ERR(bd),
+				"failed to register backlight");
+
+	bd->props.max_brightness = max_brightness;
+	bd->props.brightness = brightness;
+
+	ktd2801->bd = bd;
+	platform_set_drvdata(pdev, bd);
+	backlight_update_status(bd);
+
+	return 0;
+}
+
+static const struct of_device_id ktd2801_of_match[] = {
+	{ .compatible = "kinetic,ktd2801" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ktd2801_of_match);
+
+static struct platform_driver ktd2801_backlight_driver = {
+	.driver = {
+		.name = "ktd2801-backlight",
+		.of_match_table = ktd2801_of_match,
+	},
+	.probe = ktd2801_backlight_probe,
+};
+module_platform_driver(ktd2801_backlight_driver);
+
+MODULE_IMPORT_NS(EXPRESSWIRE);
+MODULE_AUTHOR("Duje Mihanović <duje.mihanovic@skole.hr>");
+MODULE_DESCRIPTION("Kinetic KTD2801 Backlight Driver");
+MODULE_LICENSE("GPL");

-- 
2.43.0



