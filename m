Return-Path: <linux-kernel+bounces-34090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7E783733D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D20A51C2922C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C92F4123E;
	Mon, 22 Jan 2024 19:51:46 +0000 (UTC)
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88F63FB33;
	Mon, 22 Jan 2024 19:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705953105; cv=none; b=nRchK+0xiBTzs2OgKODeorDjfnb6jfLtRclqd7E57fxR9EYZuAGk4c098cFJUwPtXDmmiA1dd6jY/0BdhRlNZMpbdNnY5kkwNFs5DbExNPylDXCorIfHqVRCSBebUYINnZESemG+y8the9AW6zjTf3USaDai/D+/+aENMlpCoG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705953105; c=relaxed/simple;
	bh=5fQOXzMx0sk8VbcIHgQr1j5EvAtZ+SFCQYKkGVxpjwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xt5nKFindA7oidiIOukj1G80G4OYwApqtyIjAXv6rHuCS9XkjHDPRUc4t5EBv+C4JkotHgC2UJCzYOUep+QMkSrM8oYxEXUcyCm2gBakkM01T9AoZ+oUUZU6FvrD5Bjl3H/cFmk/qwcgQE1t4lPeBxyrNgyK1SucOjTmXh7RWbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 7EEC085970;
	Mon, 22 Jan 2024 20:51:41 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Mon, 22 Jan 2024 20:50:59 +0100
Subject: [PATCH v4 3/3] backlight: Add Kinetic KTD2801 backlight support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240122-ktd2801-v4-3-33c986a3eb68@skole.hr>
References: <20240122-ktd2801-v4-0-33c986a3eb68@skole.hr>
In-Reply-To: <20240122-ktd2801-v4-0-33c986a3eb68@skole.hr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6449;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=5fQOXzMx0sk8VbcIHgQr1j5EvAtZ+SFCQYKkGVxpjwQ=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlrsck71V1SHKFF5Fndc5m9LwAhxluGt6iuSrqj
 IeJCCf8H3GJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZa7HJAAKCRCaEZ6wQi2W
 4RrUD/4q1q+fvjmFi87rZXxY30ZZb8xlXQr9AqNVHJdGddHm96yN3cEwj+pP3hdwpkkk+x+jLwV
 i79VDHNQ5A/ltb9lKFn7/IHbpdYYOIOV4JeXjWa8hrEJNc5M3P7cFNH2JhJa+e8HPIofWovhog9
 v6YjwZgqu6oEwywumapJsNFRIgQStOZuSbtaOVlEcuvGlHaReLfJ4QzNw/xTkqM80boyF2pV4qS
 Cwf0Q76p0gf7qiYrac3nJe2G7nkpOru4hFactSINrMe14eLSdZvngCfXPFgZ5AjOKs0vXRklDjS
 7p+wlKCwHNm5S2nImfYNUq9iPrHAbZQ140PJSd8lieBEV+7O4iqo1PYFWaaF9HalveIQxIFSfHp
 EowMFexZau05bMsAZfdHil0W1AlPgdy5eIcEq4WrbiD4QAX/6i7oP2Ivb4OjB8Rm0OM9xmvVdWz
 lhwA+Rc7DI6BaVN4sNiL2clAM7aLGJ9uvfxPp4uOtujBSRKe5dRakjTi5sNNVYlAypMewApUAUS
 P40YUucfmG0205GM0ZAqSIrl1l9dhPPD354hpCMYSYBCFTAvDaqCT+f8lH39aDxlaxZQMV7W8PV
 pvPczZ5zyzwCN+6xR6k4FZYjr7hlH5N42eY7DPzxaaOghP88zL1X4d9QFZTtQF2kuRUZAJY9fng
 /qswvQA6ccnCSOQ==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

KTD2801 is a LED backlight driver IC found in samsung,coreprimevelte.
The brightness can be set using PWM or the ExpressWire protocol. Add
support for the KTD2801.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 MAINTAINERS                                 |   6 ++
 drivers/video/backlight/Kconfig             |   7 ++
 drivers/video/backlight/Makefile            |   1 +
 drivers/video/backlight/ktd2801-backlight.c | 128 ++++++++++++++++++++++++++++
 4 files changed, 142 insertions(+)

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
index 51387b1ef012..bba9d8ffccff 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -183,6 +183,13 @@ config BACKLIGHT_KTD253
 	  which is a 1-wire GPIO-controlled backlight found in some mobile
 	  phones.
 
+config BACKLIGHT_KTD2801
+	tristate "Backlight Driver for Kinetic KTD2801"
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
index 000000000000..c020acff40f1
--- /dev/null
+++ b/drivers/video/backlight/ktd2801-backlight.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Datasheet:
+ * https://www.kinet-ic.com/uploads/web/KTD2801/KTD2801-04b.pdf
+ */
+#include <linux/backlight.h>
+#include <linux/gpio/consumer.h>
+#include <linux/leds-expresswire.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+
+#define KTD2801_DEFAULT_BRIGHTNESS	100
+#define KTD2801_MAX_BRIGHTNESS		255
+
+/* These values have been extracted from Samsung's driver. */
+const struct expresswire_timing ktd2801_timing = {
+	.poweroff_us = 2600,
+	.detect_delay_us = 150,
+	.detect_us = 270,
+	.data_start_us = 5,
+	.short_bitset_us = 5,
+	.long_bitset_us = 15,
+	.end_of_data_low_us = 10,
+	.end_of_data_high_us = 350
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
+	expresswire_write_u8(&ktd2801->props, brightness);
+
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



