Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558637AA123
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjIUU6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjIUU56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:57:58 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE15B0A02
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:09:01 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso154238866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1695319740; x=1695924540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wgDb/GvUJRDeTAWhgCNYXkshWaDqlO9sUbFq2NNyoqk=;
        b=E68PRGtsUK6vCcwYq0u/7z2hJ7TN6sMDpwVVqZ1IVjBA3L16zFSyYFf0p1KfAPsBxL
         TrRtH/Vt58Nuxua4cgbAf3L1QLVJciDMb/Frz0pJNuPOh8Q7Ijy5w4klye2FCPdREhNT
         cF7FCudzB1NSlkPXj25EaA6SWRoFJhMVH3J66jq2RIDiNHe+JYl4lDQF1Y5VOLj9J0/M
         Fs5yB7EbA7CC5HpO47mXbEpaufFzZzxUOHZ6CLAUAOqdGvzkR6uxT2Uj6tqV0rMx68+Y
         zeioU1YvLPxkmXGzAZz4hug5xeleWa3PNOpG5Nt6qicg5idGvbIIKJcZyZfmkwJnZz+G
         5z8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695319740; x=1695924540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wgDb/GvUJRDeTAWhgCNYXkshWaDqlO9sUbFq2NNyoqk=;
        b=wl/+5OzwJrnvLjHsDBFdiR43JrIHktxpYPXW7lTMMvnugGITNwzVzyIZl3mzWHNuPC
         dtEUxAnVfwHo0gIIj4ymGCz3+DN/+Nptl+sF8I5L5esK7GAeCA6xIErEJCVOg950cEFk
         B8ala23Gj9TMFWhAL2dkhWncisf987rAJGHdGZeW6ohDwhEUeIRbwHiT72WYCBbhan0o
         5zX86fWxpIGBg6G+O+TNMMiVQxH85HroSREOSuFOpNx9o42oAhxT9LOMUWXYt+gJffH+
         5xdFHngokwUZIzqdowU0BTy543CUKOyndo6YV8EZ5cD2qsnAb9J2JVDAFywsU6cKZWQc
         9dDQ==
X-Gm-Message-State: AOJu0YziM/+BuEw9fObLfioyhVp3NC9Ok6za8eCqAkCcBl7HUec8hCHw
        gAd9zzkhWh4Y850ALqpoBnlcKks3/OwW6uR8aQqz8A==
X-Google-Smtp-Source: AGHT+IE8HhpUDjsNc4xO+TH3cyTLgNCzMLRTPDIy70yYHezJS1iRSH/LKM1N6ooHMpYFct92MSaX2g==
X-Received: by 2002:adf:ffcd:0:b0:321:2dbc:589f with SMTP id x13-20020adfffcd000000b003212dbc589fmr3840694wrs.16.1695287578675;
        Thu, 21 Sep 2023 02:12:58 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id v11-20020a5d610b000000b0031435731dfasm1192458wrt.35.2023.09.21.02.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 02:12:57 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: [PATCH v4] leds: max5970: Add support for max5970
Date:   Thu, 21 Sep 2023 11:12:53 +0200
Message-ID: <20230921091255.3792179-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

The MAX5970 is hot swap controller and has 4 indication LED.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
Reviewed-by: Lee Jones <lee@kernel.org>
---
Changes in V4:
- Compact declaration of variable to single line
- Use sizeof(*ddata) instead of sizeof(struct max5970_led).
- Use the shorter 'dev' version whilst it's available
Changes in V3:
- Drop array for ddata variable.
Changes in V2:
- Add of_node_put before return.
- Code cleanup
- Refactor code & remove max5970_setup_led function.
---
 drivers/leds/Kconfig        |  11 ++++
 drivers/leds/Makefile       |   1 +
 drivers/leds/leds-max5970.c | 109 ++++++++++++++++++++++++++++++++++++
 3 files changed, 121 insertions(+)
 create mode 100644 drivers/leds/leds-max5970.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index b92208eccdea..03ef527cc545 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -637,6 +637,17 @@ config LEDS_ADP5520
 	  To compile this driver as a module, choose M here: the module will
 	  be called leds-adp5520.
 
+config LEDS_MAX5970
+	tristate "LED Support for Maxim 5970"
+	depends on LEDS_CLASS
+	depends on MFD_MAX5970
+	help
+	  This option enables support for the Maxim MAX5970 & MAX5978 smart
+	  switch indication LEDs via the I2C bus.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called leds-max5970.
+
 config LEDS_MC13783
 	tristate "LED Support for MC13XXX PMIC"
 	depends on LEDS_CLASS
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index d7348e8bc019..6eaee0a753c6 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_LEDS_LP8501)		+= leds-lp8501.o
 obj-$(CONFIG_LEDS_LP8788)		+= leds-lp8788.o
 obj-$(CONFIG_LEDS_LP8860)		+= leds-lp8860.o
 obj-$(CONFIG_LEDS_LT3593)		+= leds-lt3593.o
+obj-$(CONFIG_LEDS_MAX5970)		+= leds-max5970.o
 obj-$(CONFIG_LEDS_MAX77650)		+= leds-max77650.o
 obj-$(CONFIG_LEDS_MAX8997)		+= leds-max8997.o
 obj-$(CONFIG_LEDS_MC13783)		+= leds-mc13783.o
diff --git a/drivers/leds/leds-max5970.c b/drivers/leds/leds-max5970.c
new file mode 100644
index 000000000000..5b87f078af85
--- /dev/null
+++ b/drivers/leds/leds-max5970.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device driver for leds in MAX5970 and MAX5978 IC
+ *
+ * Copyright (c) 2022 9elements GmbH
+ *
+ * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
+ */
+
+#include <linux/leds.h>
+#include <linux/mfd/max5970.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define ldev_to_maxled(c)       container_of(c, struct max5970_led, cdev)
+
+struct max5970_led {
+	struct device *dev;
+	struct regmap *regmap;
+	struct led_classdev cdev;
+	unsigned int index;
+};
+
+static int max5970_led_set_brightness(struct led_classdev *cdev,
+				      enum led_brightness brightness)
+{
+	struct max5970_led *ddata = ldev_to_maxled(cdev);
+	int ret, val;
+
+	/* Set/clear corresponding bit for given led index */
+	val = !brightness ? BIT(ddata->index) : 0;
+
+	ret = regmap_update_bits(ddata->regmap, MAX5970_REG_LED_FLASH, BIT(ddata->index), val);
+	if (ret < 0)
+		dev_err(cdev->dev, "failed to set brightness %d", ret);
+
+	return ret;
+}
+
+static int max5970_led_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev_of_node(dev->parent);
+	struct regmap *regmap;
+	struct device_node *led_node, *child;
+	struct max5970_led *ddata;
+	int ret = -ENODEV, num_leds = 0;
+
+	regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!regmap)
+		return -EPROBE_DEFER;
+
+	led_node = of_get_child_by_name(np, "leds");
+	if (!led_node)
+		return -ENODEV;
+
+	for_each_available_child_of_node(led_node, child) {
+		u32 reg;
+
+		if (of_property_read_u32(child, "reg", &reg))
+			continue;
+
+		if (reg >= MAX5970_NUM_LEDS) {
+			dev_err(dev, "invalid LED (%u >= %d)\n", reg, MAX5970_NUM_LEDS);
+			continue;
+		}
+
+		ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
+		if (!ddata) {
+			of_node_put(child);
+			return -ENOMEM;
+		}
+
+		ddata->index = reg;
+		ddata->regmap = regmap;
+		ddata->dev = dev;
+
+		if (of_property_read_string(child, "label", &ddata->cdev.name))
+			ddata->cdev.name = child->name;
+
+		ddata->cdev.max_brightness = 1;
+		ddata->cdev.brightness_set_blocking = max5970_led_set_brightness;
+		ddata->cdev.default_trigger = "none";
+
+		ret = devm_led_classdev_register(dev, &ddata->cdev);
+		if (ret < 0) {
+			of_node_put(child);
+			dev_err(dev, "Failed to initialize LED %u\n", reg);
+			return ret;
+		}
+		num_leds++;
+	}
+
+	return ret;
+}
+
+static struct platform_driver max5970_led_driver = {
+	.driver = {
+		.name = "max5970-led",
+	},
+	.probe = max5970_led_probe,
+};
+
+module_platform_driver(max5970_led_driver);
+MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
+MODULE_AUTHOR("Naresh Solanki <Naresh.Solanki@9elements.com>");
+MODULE_DESCRIPTION("MAX5970_hot-swap controller LED driver");
+MODULE_LICENSE("GPL");

base-commit: baca986e1f2c31f8e4b2a6d99d47c3bc844033e8
-- 
2.41.0

