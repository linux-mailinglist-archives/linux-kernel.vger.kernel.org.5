Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD37792653
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238361AbjIEQFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353862AbjIEIYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 04:24:23 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E7ECCB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 01:24:18 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31c7912416bso2109335f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 01:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693902257; x=1694507057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=37Wb46QRhLkfUy6mtabtEvmTwG7hQsrkGmqZbmLQDlI=;
        b=05/IFVFHvEkk7PR9lXevsR6rIXXlqSjhy5iesXuVsKDfUFZBE6TgLaTD781GDbkDDO
         cB072bJb9ttdxL3xLHlyI+ctNGYNm/r8LjoeCSCQgy2N7VNI3/x1oLyZbZHQeamZqo3w
         FtA8QTnOeiJBIN20Jti5Y4F6EjQlIGwFZctVN6wVdEHbihl4OzvqSFeGh6yJvezGoxbz
         1CstwaopQTQxKsWYqvKwpYpdy9pE6a+69IOsMZTcvwSvyzMmvxizjw0OptEOxNqIsMwm
         QMTnAXKpIMzvr9RTfwPb4+SArnu7Mdsi301PAfLVikmvAGrU9lbgitV28bSWGSNwearI
         tC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693902257; x=1694507057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=37Wb46QRhLkfUy6mtabtEvmTwG7hQsrkGmqZbmLQDlI=;
        b=Hwq82fwAHM+C5lRZJxev5ne5L33R35SpDBaRX2wKZUMcK/rmgVlHiBn/hNMSNuOBXb
         XWM7fsvNMNKUDjy8x3XK/cv4/j3XX6yRN8jZ745o+PhFNgezrgsdnJ7FnOkyOQnW/DW9
         dFC6mKa8wUSW4XaMNzJS+2K8ufWQ7J9vTSlvSslrzA46tXr+O0dKHroBhAGLRJiWPAGt
         ydIUQKOTZvAZj005QirqTEQMMIoLv2Im92Ejyqk0TCUtTH9C2DCZu4MbZvHsnKd4eA7B
         TKFxYYS9j/cVHA9mwhp0oGdKEe9abYLwm5hYP3ZIgVsWTADC3G7FYEZNIcheECB/t48t
         yc8Q==
X-Gm-Message-State: AOJu0Yz6pS1y3meSaoWsBLjLDwzsXqI6y3ljSaTA2WtPkSuOM3YQWJck
        Diagh6KebDfN4yYsAsXBtUf8W3rrNMBFyHKEsA8=
X-Google-Smtp-Source: AGHT+IF5SvEjWYDh2J+BFnMqc4SxlIIJLgWa+aZl+0IXDpS8lOM00piRsWsEBPfQzh0wVDVsHB5pWg==
X-Received: by 2002:a5d:4b87:0:b0:319:6f0e:fc0e with SMTP id b7-20020a5d4b87000000b003196f0efc0emr10134767wrt.30.1693902256866;
        Tue, 05 Sep 2023 01:24:16 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7a54:5dbc:6d09:48b7])
        by smtp.gmail.com with ESMTPSA id s12-20020a5d4ecc000000b0031423a8f4f7sm16860750wrv.56.2023.09.05.01.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 01:24:16 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3] gpio: sim: don't fiddle with GPIOLIB private members
Date:   Tue,  5 Sep 2023 10:24:13 +0200
Message-Id: <20230905082413.21954-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We access internals of struct gpio_device and struct gpio_desc because
it's easier but it can actually be avoided and we're working towards a
better encapsulation of GPIO data structures across the kernel so let's
start at home.

Instead of checking gpio_desc flags, let's just track the requests of
GPIOs in the driver. We also already store the information about
direction of simulated lines.

For kobjects needed by sysfs callbacks: we can iterate over the children
devices of the top-level platform device and compare their fwnodes
against the one passed to the init function from probe.

While at it: fix one line break and remove the untrue part about
configfs callbacks using dev_get_drvdata() from a comment.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
v1 -> v2:
- use get_dev_from_fwnode() instead of dereferencing fwnode directly

v2 -> v3:
- don't use fwnode internal fields, instead: iterate over the platform
  device's children and locate the GPIO device

 drivers/gpio/gpio-sim.c | 66 ++++++++++++++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 18 deletions(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index 271db3639a78..16a865e79559 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -12,6 +12,7 @@
 #include <linux/completion.h>
 #include <linux/configfs.h>
 #include <linux/device.h>
+#include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
 #include <linux/gpio/machine.h>
 #include <linux/idr.h>
@@ -30,8 +31,6 @@
 #include <linux/string_helpers.h>
 #include <linux/sysfs.h>
 
-#include "gpiolib.h"
-
 #define GPIO_SIM_NGPIO_MAX	1024
 #define GPIO_SIM_PROP_MAX	4 /* Max 3 properties + sentinel. */
 #define GPIO_SIM_NUM_ATTRS	3 /* value, pull and sentinel */
@@ -40,6 +39,9 @@ static DEFINE_IDA(gpio_sim_ida);
 
 struct gpio_sim_chip {
 	struct gpio_chip gc;
+	struct fwnode_handle *swnode;
+	struct device *dev;
+	unsigned long *request_map;
 	unsigned long *direction_map;
 	unsigned long *value_map;
 	unsigned long *pull_map;
@@ -63,16 +65,11 @@ static int gpio_sim_apply_pull(struct gpio_sim_chip *chip,
 			       unsigned int offset, int value)
 {
 	int irq, irq_type, ret;
-	struct gpio_desc *desc;
-	struct gpio_chip *gc;
-
-	gc = &chip->gc;
-	desc = &gc->gpiodev->descs[offset];
 
 	guard(mutex)(&chip->lock);
 
-	if (test_bit(FLAG_REQUESTED, &desc->flags) &&
-	    !test_bit(FLAG_IS_OUT, &desc->flags)) {
+	if (test_bit(offset, chip->request_map) &&
+	    test_bit(offset, chip->direction_map)) {
 		if (value == !!test_bit(offset, chip->value_map))
 			goto set_pull;
 
@@ -99,8 +96,8 @@ static int gpio_sim_apply_pull(struct gpio_sim_chip *chip,
 
 set_value:
 	/* Change the value unless we're actively driving the line. */
-	if (!test_bit(FLAG_REQUESTED, &desc->flags) ||
-	    !test_bit(FLAG_IS_OUT, &desc->flags))
+	if (!test_bit(offset, chip->request_map) ||
+	    test_bit(offset, chip->direction_map))
 		__assign_bit(offset, chip->value_map, value);
 
 set_pull:
@@ -181,7 +178,7 @@ static int gpio_sim_get_direction(struct gpio_chip *gc, unsigned int offset)
 }
 
 static int gpio_sim_set_config(struct gpio_chip *gc,
-				  unsigned int offset, unsigned long config)
+			       unsigned int offset, unsigned long config)
 {
 	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
 
@@ -204,13 +201,25 @@ static int gpio_sim_to_irq(struct gpio_chip *gc, unsigned int offset)
 	return irq_create_mapping(chip->irq_sim, offset);
 }
 
+static int gpio_sim_request(struct gpio_chip *gc, unsigned int offset)
+{
+	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
+
+	scoped_guard(mutex, &chip->lock)
+		__set_bit(offset, chip->request_map);
+
+	return 0;
+}
+
 static void gpio_sim_free(struct gpio_chip *gc, unsigned int offset)
 {
 	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
 
-	scoped_guard(mutex, &chip->lock)
+	scoped_guard(mutex, &chip->lock) {
 		__assign_bit(offset, chip->value_map,
 			     !!test_bit(offset, chip->pull_map));
+		__clear_bit(offset, chip->request_map);
+	}
 }
 
 static ssize_t gpio_sim_sysfs_val_show(struct device *dev,
@@ -295,7 +304,7 @@ static void gpio_sim_sysfs_remove(void *data)
 {
 	struct gpio_sim_chip *chip = data;
 
-	sysfs_remove_groups(&chip->gc.gpiodev->dev.kobj, chip->attr_groups);
+	sysfs_remove_groups(&chip->dev->kobj, chip->attr_groups);
 }
 
 static int gpio_sim_setup_sysfs(struct gpio_sim_chip *chip)
@@ -352,14 +361,25 @@ static int gpio_sim_setup_sysfs(struct gpio_sim_chip *chip)
 		chip->attr_groups[i] = attr_group;
 	}
 
-	ret = sysfs_create_groups(&chip->gc.gpiodev->dev.kobj,
-				  chip->attr_groups);
+	ret = sysfs_create_groups(&chip->dev->kobj, chip->attr_groups);
 	if (ret)
 		return ret;
 
 	return devm_add_action_or_reset(dev, gpio_sim_sysfs_remove, chip);
 }
 
+static int gpio_sim_chip_set_device(struct device *dev, void *data)
+{
+	struct gpio_sim_chip *chip = data;
+
+	if (chip->swnode == dev->fwnode) {
+		chip->dev = dev;
+		return 1;
+	}
+
+	return 0;
+}
+
 static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
 {
 	struct gpio_sim_chip *chip;
@@ -387,6 +407,10 @@ static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
 	if (!chip)
 		return -ENOMEM;
 
+	chip->request_map = devm_bitmap_zalloc(dev, num_lines, GFP_KERNEL);
+	if (!chip->request_map)
+		return -ENOMEM;
+
 	chip->direction_map = devm_bitmap_alloc(dev, num_lines, GFP_KERNEL);
 	if (!chip->direction_map)
 		return -ENOMEM;
@@ -432,6 +456,7 @@ static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
 	gc->get_direction = gpio_sim_get_direction;
 	gc->set_config = gpio_sim_set_config;
 	gc->to_irq = gpio_sim_to_irq;
+	gc->request = gpio_sim_request;
 	gc->free = gpio_sim_free;
 	gc->can_sleep = true;
 
@@ -439,8 +464,13 @@ static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
 	if (ret)
 		return ret;
 
-	/* Used by sysfs and configfs callbacks. */
-	dev_set_drvdata(&gc->gpiodev->dev, chip);
+	chip->swnode = swnode;
+	ret = device_for_each_child(dev, chip, gpio_sim_chip_set_device);
+	if (!ret)
+		return -ENODEV;
+
+	/* Used by sysfs callbacks. */
+	dev_set_drvdata(chip->dev, chip);
 
 	return gpio_sim_setup_sysfs(chip);
 }
-- 
2.39.2

