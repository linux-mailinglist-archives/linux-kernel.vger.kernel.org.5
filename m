Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2651797B5C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343648AbjIGSNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343672AbjIGSNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:13:48 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33DF1BFB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:13:25 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bce552508fso21830361fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 11:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694110403; x=1694715203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jrJxxgqMDIlX40G2ZHPAdOSiHgl3iXSpX7T+iydVbUo=;
        b=Ql7yxF5M5KrJEwoAvEI40tklOIQT5Bu71uI2q8dZHX7Az66Hq8AkzuexxEHY7/9uap
         HSTo+JzG32/QbW68S+QMhBZkP7OJc5hxdBRyQMq1+KmCXBbN1FsIzVNs9j11LIUsFdzj
         r/gR9lInH9/97tu6CrHGjCCcSsp7/rPQ6XadOvHpC6FV4+82vR6tTIV8H64gpbrWoQo8
         qq3w9OtU1ShRAekHRmgs2zboZfK62+38u9GPUt0f118zaE9NdIm5X/cXVkeJ6rqtJod3
         Q1Ial2a/mm8hz9adGRjsNa0f1eXI/Xtq1evZufXClxV+FILupTZ0qoFv8Jfc8X1mu56/
         JCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694110403; x=1694715203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jrJxxgqMDIlX40G2ZHPAdOSiHgl3iXSpX7T+iydVbUo=;
        b=cC4i76FC6vMalEWDZDe0yjKNcQ1zZ49ILjwljkCOgU7C5dvof0UOncpsd9DFfUBRcj
         oLRebiSQt2rt0pb7Fho5gSjSRctkMBcRUsZ/R/+rSeXFi076XOvdWFJN5mGN/hE2UQhR
         YCV9mxkMhNZCj+EHTMYaw/YXO1mofhZV6Rwto9rMu5RBASIDoyowRqCfRTAOmFOMaAoV
         txg2DpocEcJOSfD9tGps1pK0gCauLplX5fR/RvYsb1pRMM6bq/Rf/m80RqD5UzJX5E7Z
         x6FIA0oskn/bU+SX+qWw11Ogybx4obXMxoEd+X1gpHVuHlmCqJSrb90VrrOcYey/719w
         21rA==
X-Gm-Message-State: AOJu0Yz/3UnmxQcfu11Uq5UvkK4qm1iz88IU9cTTjqz4e4rTft9I7nZ4
        0+JUiRwscpBLHquAtj4o45vjJQjcrh6lun5lWhI=
X-Google-Smtp-Source: AGHT+IHfOlZoBHNbQ4z9MAlkM2JnSNSn7D8E6L5HvvLEK81m48vwy7orP4FvgLozLADf+b/PMIAqmg==
X-Received: by 2002:a1c:7c0e:0:b0:3fe:d7c8:e0d with SMTP id x14-20020a1c7c0e000000b003fed7c80e0dmr3962212wmc.34.1694075277988;
        Thu, 07 Sep 2023 01:27:57 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:56f5:e2d4:1e04:b28e])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c029100b003fee6e170f9sm1781804wmk.45.2023.09.07.01.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 01:27:57 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4] gpio: sim: don't fiddle with GPIOLIB private members
Date:   Thu,  7 Sep 2023 10:27:51 +0200
Message-Id: <20230907082751.22996-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

v3 -> v4:
- use device_find_child() (not bus_device_find_by_fwnode() as it's
  pointless to iterate over all platform devices)
- use device_match_fwnode() for matching the device by fwnode

 drivers/gpio/gpio-sim.c | 75 ++++++++++++++++++++++++++++++-----------
 1 file changed, 56 insertions(+), 19 deletions(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index 271db3639a78..a58387f2cdc6 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -12,6 +12,8 @@
 #include <linux/completion.h>
 #include <linux/configfs.h>
 #include <linux/device.h>
+#include <linux/device/bus.h>
+#include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
 #include <linux/gpio/machine.h>
 #include <linux/idr.h>
@@ -30,8 +32,6 @@
 #include <linux/string_helpers.h>
 #include <linux/sysfs.h>
 
-#include "gpiolib.h"
-
 #define GPIO_SIM_NGPIO_MAX	1024
 #define GPIO_SIM_PROP_MAX	4 /* Max 3 properties + sentinel. */
 #define GPIO_SIM_NUM_ATTRS	3 /* value, pull and sentinel */
@@ -40,6 +40,8 @@ static DEFINE_IDA(gpio_sim_ida);
 
 struct gpio_sim_chip {
 	struct gpio_chip gc;
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
@@ -180,8 +177,8 @@ static int gpio_sim_get_direction(struct gpio_chip *gc, unsigned int offset)
 	return direction ? GPIO_LINE_DIRECTION_IN : GPIO_LINE_DIRECTION_OUT;
 }
 
-static int gpio_sim_set_config(struct gpio_chip *gc,
-				  unsigned int offset, unsigned long config)
+static int gpio_sim_set_config(struct gpio_chip *gc, unsigned int offset,
+			       unsigned long config)
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
@@ -282,6 +291,13 @@ static void gpio_sim_mutex_destroy(void *data)
 	mutex_destroy(lock);
 }
 
+static void gpio_sim_put_device(void *data)
+{
+	struct device *dev = data;
+
+	put_device(dev);
+}
+
 static void gpio_sim_dispose_mappings(void *data)
 {
 	struct gpio_sim_chip *chip = data;
@@ -295,7 +311,7 @@ static void gpio_sim_sysfs_remove(void *data)
 {
 	struct gpio_sim_chip *chip = data;
 
-	sysfs_remove_groups(&chip->gc.gpiodev->dev.kobj, chip->attr_groups);
+	sysfs_remove_groups(&chip->dev->kobj, chip->attr_groups);
 }
 
 static int gpio_sim_setup_sysfs(struct gpio_sim_chip *chip)
@@ -352,14 +368,22 @@ static int gpio_sim_setup_sysfs(struct gpio_sim_chip *chip)
 		chip->attr_groups[i] = attr_group;
 	}
 
-	ret = sysfs_create_groups(&chip->gc.gpiodev->dev.kobj,
-				  chip->attr_groups);
+	ret = sysfs_create_groups(&chip->dev->kobj, chip->attr_groups);
 	if (ret)
 		return ret;
 
 	return devm_add_action_or_reset(dev, gpio_sim_sysfs_remove, chip);
 }
 
+static int gpio_sim_dev_match_fwnode(struct device *dev, void *data)
+{
+	/*
+	 * We can't pass this directly to device_find_child() due to pointer
+	 * type mismatch.
+	 */
+	return device_match_fwnode(dev, data);
+}
+
 static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
 {
 	struct gpio_sim_chip *chip;
@@ -387,6 +411,10 @@ static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
 	if (!chip)
 		return -ENOMEM;
 
+	chip->request_map = devm_bitmap_zalloc(dev, num_lines, GFP_KERNEL);
+	if (!chip->request_map)
+		return -ENOMEM;
+
 	chip->direction_map = devm_bitmap_alloc(dev, num_lines, GFP_KERNEL);
 	if (!chip->direction_map)
 		return -ENOMEM;
@@ -432,6 +460,7 @@ static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
 	gc->get_direction = gpio_sim_get_direction;
 	gc->set_config = gpio_sim_set_config;
 	gc->to_irq = gpio_sim_to_irq;
+	gc->request = gpio_sim_request;
 	gc->free = gpio_sim_free;
 	gc->can_sleep = true;
 
@@ -439,8 +468,16 @@ static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
 	if (ret)
 		return ret;
 
-	/* Used by sysfs and configfs callbacks. */
-	dev_set_drvdata(&gc->gpiodev->dev, chip);
+	chip->dev = device_find_child(dev, swnode, gpio_sim_dev_match_fwnode);
+	if (!chip->dev)
+		return -ENODEV;
+
+	ret = devm_add_action_or_reset(dev, gpio_sim_put_device, chip->dev);
+	if (ret)
+		return ret;
+
+	/* Used by sysfs callbacks. */
+	dev_set_drvdata(chip->dev, chip);
 
 	return gpio_sim_setup_sysfs(chip);
 }
-- 
2.39.2

