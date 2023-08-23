Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8153C78623F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 23:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237334AbjHWVX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 17:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234548AbjHWVX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 17:23:26 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B76C10C8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 14:23:24 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-5007abb15e9so6455184e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 14:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1692825802; x=1693430602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCyOWk315MjZGxocWN7FVy6YgQBrW4jjk6j3HuEtPcg=;
        b=HqDu5/k7h5AKi5rWm+6EEWb/8Hs9Kkcn02IAL/PADtVQhlpZQGyiHh2IeSTVBzUD9w
         8lHYdxcWG5/Rp8w5nCuz2k/Quq8OgbdD1DIXfYp2K8C1uzCtf1mZwFtfOyzJV2whPfhU
         +frvEfokyX8Oa6kJk+hllDVEbp7V6Yhq3hcfvMW6OBWbwSMy03ZJNmyyrLZIj7ZB4NYc
         LbDnlO12iVaOAUiOzut7obe8gclqzYQDz3H5ZHVceSwzyY7OPe4MedyzF0pxUpeAKv9U
         nednggDod5izuIqK8qCbdyS6SVDSya+upVqYxeKVvdp7xJ7wQNTKrCmIRm+RhlF6JZTq
         QYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692825802; x=1693430602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZCyOWk315MjZGxocWN7FVy6YgQBrW4jjk6j3HuEtPcg=;
        b=F+F2rwm8jLrePgWI+Y/cnADqLbIoUNS/4346czH9+dAK9gUwIoBI/PPfhL8n0yXg01
         XGAmmjRdG98evDpkFkr1mZyQEqgxbZQ+rN7ksjljk6WOW9toGmp/r+sExao8s9JZ7W4K
         5tE0AsmXU89bAzmWGZr1gOxs82EJAuiqV25hAhtkQ4rq3Biglnz4wITIuTpGUHsh3Uwz
         /BfXWqZJh6Y9eeMpce7wD53YVhme2/e4eaMU9jJib//3Tpwjq94bOBRLxLbFeAhiB5bi
         QCGdsyT39vK005CUOjXUu0GN4SsCZURy0Y0NQ3YT5A1aVTdJQhQzwOzlbKBEuT90ZHMu
         SYNA==
X-Gm-Message-State: AOJu0Yy+GQ+B9vNiVpsfxLSoOkjxDyXPhFjFUH35wXyFgDihWQt4DsN+
        IQ8MpQp1L/Vl6TbTiq+vnbPDdw==
X-Google-Smtp-Source: AGHT+IFWLcoQ9yFZz5y1bxGXDZKh8AhF7aEPKsJhTeShSI0jx6IJQvvoTXzjPWJlknxJ9p3fOUDYEQ==
X-Received: by 2002:a19:6d1b:0:b0:4fb:89cd:9616 with SMTP id i27-20020a196d1b000000b004fb89cd9616mr8757794lfc.0.1692825802307;
        Wed, 23 Aug 2023 14:23:22 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id b12-20020aa7c90c000000b005254b41f507sm9608171edt.32.2023.08.23.14.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 14:23:21 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: [PATCH] leds: max5970: Add support for max5970
Date:   Wed, 23 Aug 2023 23:23:07 +0200
Message-ID: <20230823212309.1463769-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

The MAX5970 is hot swap controller and has 4 indication LED.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/leds/Kconfig        |  11 +++
 drivers/leds/Makefile       |   1 +
 drivers/leds/leds-max5970.c | 129 ++++++++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+)
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
index 000000000000..5be1b927f39e
--- /dev/null
+++ b/drivers/leds/leds-max5970.c
@@ -0,0 +1,129 @@
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
+	if (!ddata->regmap)
+		return -ENODEV;
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
+static int max5970_setup_led(struct max5970_led *ddata, struct regmap *regmap,
+			     struct device_node *nc, u32 reg)
+{
+	int ret;
+
+	if (of_property_read_string(nc, "label", &ddata->cdev.name))
+		ddata->cdev.name = nc->name;
+
+	ddata->cdev.max_brightness = 1;
+	ddata->cdev.brightness_set_blocking = max5970_led_set_brightness;
+	ddata->cdev.default_trigger = "none";
+
+	ret = devm_led_classdev_register(ddata->dev, &ddata->cdev);
+	if (ret)
+		dev_err(ddata->dev, "Error initializing LED %s", ddata->cdev.name);
+
+	return ret;
+}
+
+static int max5970_led_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev_of_node(dev->parent);
+	struct regmap *regmap;
+	struct device_node *led_node;
+	struct device_node *child;
+	struct max5970_led *ddata[MAX5970_NUM_LEDS];
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
+		ddata[num_leds] = devm_kzalloc(dev, sizeof(struct max5970_led), GFP_KERNEL);
+		if (!ddata[num_leds]) {
+			ret = -ENOMEM;
+			goto exit;
+		}
+
+		ddata[num_leds]->index = reg;
+		ddata[num_leds]->regmap = regmap;
+		ddata[num_leds]->dev = dev;
+
+		ret = max5970_setup_led(ddata[num_leds], regmap, child, reg);
+		if (ret < 0) {
+			dev_err(dev, "Failed to initialize LED %u\n", reg);
+			goto exit;
+		}
+		num_leds++;
+	}
+
+	return ret;
+
+exit:
+	for (int j = 0; j < num_leds; j++)
+		devm_led_classdev_unregister(dev, &ddata[j]->cdev);
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
+MODULE_DESCRIPTION("MAX5970_hot-swap controller LED driver");
+MODULE_LICENSE("GPL");

base-commit: baca986e1f2c31f8e4b2a6d99d47c3bc844033e8
-- 
2.41.0

