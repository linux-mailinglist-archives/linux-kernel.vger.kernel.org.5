Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701A277605C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjHINO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjHINO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:14:58 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E351B6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 06:14:56 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe5c0e587eso29879175e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 06:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691586895; x=1692191695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3Ybb2FgdkTDicbWlwszL66Kaa7Bhjwd5UZF0n1ZlYU=;
        b=YGfKLJWbikDgDCPh43lkyXfyG7m/INsSEOsokG7LUdRNb0Ce3qEGe4qfLow2dPBarl
         W4RphEXUQ67rv3Q0IzlrHW09Un32L/QJ4LNVNCL0LGYG02V1V8jAjFMtIBKy9OcZIvo/
         3xzr12oy3+Kn7RF5ZS1wtFevih3gu9+Lfw7+XBNX/TWva+10UkaP2sMJIAn+x0Hr6TTl
         iFNfAaNOOrHgvdYcFjjAKWkZlH1JifVGlVczI/VVldQLASXxHBIALYbxxWU7SVhJF+uB
         HBN0Dnde7qoRBeVan9jIKbgsQUlQsH0SWpiWbak5wtSvtQS1WmigYTkaUYMLUtzThVjA
         4mGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691586895; x=1692191695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3Ybb2FgdkTDicbWlwszL66Kaa7Bhjwd5UZF0n1ZlYU=;
        b=AB8gqAhWeCCYLIrNmJM8m6WPMMXBvhtk+R6cS3V//Z8cykiFIuSOO/fcyncnPbaOjB
         5hkjUnwluXwN+M+AL/dByZQsPFu4LT9OC7EpQZOQ5jWjjYy8Th7mj5qDRmjv6rB6RKUk
         wHmqs8XZIBhO1teLeuEKk1PE+gUTAeKYouIfdNvmJ+KrCS9C1fF42LtPDEwcQkRhFeEd
         JHU5iGMaheqDAkUFxUefYrZWkQUPs/Qptq+13dxi0Z3UXw+hUGex3J7iwDo2dcge/oEC
         cWsyyNxV9KS0O2LBR0Ho9T4rpUqIXctf+yfsXLMi2UXqURNjVV7cmYpPjKij1Yjbztl6
         /qjQ==
X-Gm-Message-State: AOJu0YxdBX/3BKcU0Cf+bgU1HpTYwF/Oi7TfoKnnXSvqD2Uab2lPz/Sb
        qZXCvzrVG8/cFH9FkldaXEDT5g==
X-Google-Smtp-Source: AGHT+IFy6t1uFb0QHfBIsPhoSCLyrkNDhxAHQRrjkrIUeQs+hKOBkGojbzqbcMH/C4krHGG/xxrIsg==
X-Received: by 2002:a05:6000:5:b0:317:65de:4389 with SMTP id h5-20020a056000000500b0031765de4389mr1714589wrx.61.1691586894464;
        Wed, 09 Aug 2023 06:14:54 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:bf0d:f784:9c7e:dd22])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d67c1000000b0031134bcdacdsm16741185wrw.42.2023.08.09.06.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 06:14:53 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/2] gpio: sim: simplify code with cleanup helpers
Date:   Wed,  9 Aug 2023 15:14:42 +0200
Message-Id: <20230809131442.25524-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230809131442.25524-1-brgl@bgdev.pl>
References: <20230809131442.25524-1-brgl@bgdev.pl>
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

Use macros defined in linux/cleanup.h to automate resource lifetime
control in the gpio-simulator.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-sim.c | 224 ++++++++++++++--------------------------
 1 file changed, 79 insertions(+), 145 deletions(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index dc4097dc0fbc..715e79dc3978 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/bitmap.h>
+#include <linux/cleanup.h>
 #include <linux/completion.h>
 #include <linux/configfs.h>
 #include <linux/device.h>
@@ -68,7 +69,7 @@ static int gpio_sim_apply_pull(struct gpio_sim_chip *chip,
 	gc = &chip->gc;
 	desc = &gc->gpiodev->descs[offset];
 
-	mutex_lock(&chip->lock);
+	guard(mutex)(&chip->lock);
 
 	if (test_bit(FLAG_REQUESTED, &desc->flags) &&
 	    !test_bit(FLAG_IS_OUT, &desc->flags)) {
@@ -104,7 +105,6 @@ static int gpio_sim_apply_pull(struct gpio_sim_chip *chip,
 
 set_pull:
 	__assign_bit(offset, chip->pull_map, value);
-	mutex_unlock(&chip->lock);
 	return 0;
 }
 
@@ -113,9 +113,8 @@ static int gpio_sim_get(struct gpio_chip *gc, unsigned int offset)
 	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
 	int ret;
 
-	mutex_lock(&chip->lock);
-	ret = !!test_bit(offset, chip->value_map);
-	mutex_unlock(&chip->lock);
+	scoped_guard(mutex, &chip->lock)
+		ret = !!test_bit(offset, chip->value_map);
 
 	return ret;
 }
@@ -124,9 +123,8 @@ static void gpio_sim_set(struct gpio_chip *gc, unsigned int offset, int value)
 {
 	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
 
-	mutex_lock(&chip->lock);
-	__assign_bit(offset, chip->value_map, value);
-	mutex_unlock(&chip->lock);
+	scoped_guard(mutex, &chip->lock)
+		__assign_bit(offset, chip->value_map, value);
 }
 
 static int gpio_sim_get_multiple(struct gpio_chip *gc,
@@ -134,9 +132,8 @@ static int gpio_sim_get_multiple(struct gpio_chip *gc,
 {
 	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
 
-	mutex_lock(&chip->lock);
-	bitmap_replace(bits, bits, chip->value_map, mask, gc->ngpio);
-	mutex_unlock(&chip->lock);
+	scoped_guard(mutex, &chip->lock)
+		bitmap_replace(bits, bits, chip->value_map, mask, gc->ngpio);
 
 	return 0;
 }
@@ -146,9 +143,9 @@ static void gpio_sim_set_multiple(struct gpio_chip *gc,
 {
 	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
 
-	mutex_lock(&chip->lock);
-	bitmap_replace(chip->value_map, chip->value_map, bits, mask, gc->ngpio);
-	mutex_unlock(&chip->lock);
+	scoped_guard(mutex, &chip->lock)
+		bitmap_replace(chip->value_map, chip->value_map, bits, mask,
+			       gc->ngpio);
 }
 
 static int gpio_sim_direction_output(struct gpio_chip *gc,
@@ -156,10 +153,10 @@ static int gpio_sim_direction_output(struct gpio_chip *gc,
 {
 	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
 
-	mutex_lock(&chip->lock);
-	__clear_bit(offset, chip->direction_map);
-	__assign_bit(offset, chip->value_map, value);
-	mutex_unlock(&chip->lock);
+	scoped_guard(mutex, &chip->lock) {
+		__clear_bit(offset, chip->direction_map);
+		__assign_bit(offset, chip->value_map, value);
+	}
 
 	return 0;
 }
@@ -168,9 +165,8 @@ static int gpio_sim_direction_input(struct gpio_chip *gc, unsigned int offset)
 {
 	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
 
-	mutex_lock(&chip->lock);
-	__set_bit(offset, chip->direction_map);
-	mutex_unlock(&chip->lock);
+	scoped_guard(mutex, &chip->lock)
+		__set_bit(offset, chip->direction_map);
 
 	return 0;
 }
@@ -180,9 +176,8 @@ static int gpio_sim_get_direction(struct gpio_chip *gc, unsigned int offset)
 	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
 	int direction;
 
-	mutex_lock(&chip->lock);
-	direction = !!test_bit(offset, chip->direction_map);
-	mutex_unlock(&chip->lock);
+	scoped_guard(mutex, &chip->lock)
+		direction = !!test_bit(offset, chip->direction_map);
 
 	return direction ? GPIO_LINE_DIRECTION_IN : GPIO_LINE_DIRECTION_OUT;
 }
@@ -215,9 +210,9 @@ static void gpio_sim_free(struct gpio_chip *gc, unsigned int offset)
 {
 	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
 
-	mutex_lock(&chip->lock);
-	__assign_bit(offset, chip->value_map, !!test_bit(offset, chip->pull_map));
-	mutex_unlock(&chip->lock);
+	scoped_guard(mutex, &chip->lock)
+		__assign_bit(offset, chip->value_map,
+			     !!test_bit(offset, chip->pull_map));
 }
 
 static ssize_t gpio_sim_sysfs_val_show(struct device *dev,
@@ -227,9 +222,8 @@ static ssize_t gpio_sim_sysfs_val_show(struct device *dev,
 	struct gpio_sim_chip *chip = dev_get_drvdata(dev);
 	int val;
 
-	mutex_lock(&chip->lock);
-	val = !!test_bit(line_attr->offset, chip->value_map);
-	mutex_unlock(&chip->lock);
+	scoped_guard(mutex, &chip->lock)
+		val = !!test_bit(line_attr->offset, chip->value_map);
 
 	return sysfs_emit(buf, "%d\n", val);
 }
@@ -258,9 +252,8 @@ static ssize_t gpio_sim_sysfs_pull_show(struct device *dev,
 	struct gpio_sim_chip *chip = dev_get_drvdata(dev);
 	int pull;
 
-	mutex_lock(&chip->lock);
-	pull = !!test_bit(line_attr->offset, chip->pull_map);
-	mutex_unlock(&chip->lock);
+	scoped_guard(mutex, &chip->lock)
+		pull = !!test_bit(line_attr->offset, chip->pull_map);
 
 	return sysfs_emit(buf, "%s\n", gpio_sim_sysfs_pull_strings[pull]);
 }
@@ -661,13 +654,13 @@ static ssize_t gpio_sim_device_config_dev_name_show(struct config_item *item,
 	struct platform_device *pdev;
 	int ret;
 
-	mutex_lock(&dev->lock);
+	guard(mutex)(&dev->lock);
+
 	pdev = dev->pdev;
 	if (pdev)
 		ret = sprintf(page, "%s\n", dev_name(&pdev->dev));
 	else
 		ret = sprintf(page, "gpio-sim.%d\n", dev->id);
-	mutex_unlock(&dev->lock);
 
 	return ret;
 }
@@ -680,9 +673,8 @@ gpio_sim_device_config_live_show(struct config_item *item, char *page)
 	struct gpio_sim_device *dev = to_gpio_sim_device(item);
 	bool live;
 
-	mutex_lock(&dev->lock);
-	live = gpio_sim_device_is_live_unlocked(dev);
-	mutex_unlock(&dev->lock);
+	scoped_guard(mutex, &dev->lock)
+		live = gpio_sim_device_is_live_unlocked(dev);
 
 	return sprintf(page, "%c\n", live ? '1' : '0');
 }
@@ -837,8 +829,8 @@ gpio_sim_make_bank_swnode(struct gpio_sim_bank *bank,
 {
 	struct property_entry properties[GPIO_SIM_PROP_MAX];
 	unsigned int prop_idx = 0, line_names_size = 0;
+	char **line_names __free(kfree) = NULL;
 	struct fwnode_handle *swnode;
-	char **line_names;
 
 	memset(properties, 0, sizeof(properties));
 
@@ -858,7 +850,6 @@ gpio_sim_make_bank_swnode(struct gpio_sim_bank *bank,
 						line_names, line_names_size);
 
 	swnode = fwnode_create_software_node(properties, parent);
-	kfree(line_names);
 	return swnode;
 }
 
@@ -984,7 +975,7 @@ gpio_sim_device_config_live_store(struct config_item *item,
 	if (ret)
 		return ret;
 
-	mutex_lock(&dev->lock);
+	guard(mutex)(&dev->lock);
 
 	if ((!live && !gpio_sim_device_is_live_unlocked(dev)) ||
 	    (live && gpio_sim_device_is_live_unlocked(dev)))
@@ -994,8 +985,6 @@ gpio_sim_device_config_live_store(struct config_item *item,
 	else
 		gpio_sim_device_deactivate_unlocked(dev);
 
-	mutex_unlock(&dev->lock);
-
 	return ret ?: count;
 }
 
@@ -1034,13 +1023,13 @@ static ssize_t gpio_sim_bank_config_chip_name_show(struct config_item *item,
 	struct gpio_sim_chip_name_ctx ctx = { bank->swnode, page };
 	int ret;
 
-	mutex_lock(&dev->lock);
+	guard(mutex)(&dev->lock);
+
 	if (gpio_sim_device_is_live_unlocked(dev))
 		ret = device_for_each_child(&dev->pdev->dev, &ctx,
 					    gpio_sim_emit_chip_name);
 	else
 		ret = sprintf(page, "none\n");
-	mutex_unlock(&dev->lock);
 
 	return ret;
 }
@@ -1054,9 +1043,8 @@ gpio_sim_bank_config_label_show(struct config_item *item, char *page)
 	struct gpio_sim_device *dev = gpio_sim_bank_get_device(bank);
 	int ret;
 
-	mutex_lock(&dev->lock);
-	ret = sprintf(page, "%s\n", bank->label ?: "");
-	mutex_unlock(&dev->lock);
+	scoped_guard(mutex, &dev->lock)
+		ret = sprintf(page, "%s\n", bank->label ?: "");
 
 	return ret;
 }
@@ -1068,23 +1056,18 @@ static ssize_t gpio_sim_bank_config_label_store(struct config_item *item,
 	struct gpio_sim_device *dev = gpio_sim_bank_get_device(bank);
 	char *trimmed;
 
-	mutex_lock(&dev->lock);
+	guard(mutex)(&dev->lock);
 
-	if (gpio_sim_device_is_live_unlocked(dev)) {
-		mutex_unlock(&dev->lock);
+	if (gpio_sim_device_is_live_unlocked(dev))
 		return -EBUSY;
-	}
 
 	trimmed = gpio_sim_strdup_trimmed(page, count);
-	if (!trimmed) {
-		mutex_unlock(&dev->lock);
+	if (!trimmed)
 		return -ENOMEM;
-	}
 
 	kfree(bank->label);
 	bank->label = trimmed;
 
-	mutex_unlock(&dev->lock);
 	return count;
 }
 
@@ -1097,9 +1080,8 @@ gpio_sim_bank_config_num_lines_show(struct config_item *item, char *page)
 	struct gpio_sim_device *dev = gpio_sim_bank_get_device(bank);
 	int ret;
 
-	mutex_lock(&dev->lock);
-	ret = sprintf(page, "%u\n", bank->num_lines);
-	mutex_unlock(&dev->lock);
+	scoped_guard(mutex, &dev->lock)
+		ret = sprintf(page, "%u\n", bank->num_lines);
 
 	return ret;
 }
@@ -1120,16 +1102,13 @@ gpio_sim_bank_config_num_lines_store(struct config_item *item,
 	if (num_lines == 0)
 		return -EINVAL;
 
-	mutex_lock(&dev->lock);
+	guard(mutex)(&dev->lock);
 
-	if (gpio_sim_device_is_live_unlocked(dev)) {
-		mutex_unlock(&dev->lock);
+	if (gpio_sim_device_is_live_unlocked(dev))
 		return -EBUSY;
-	}
 
 	bank->num_lines = num_lines;
 
-	mutex_unlock(&dev->lock);
 	return count;
 }
 
@@ -1149,9 +1128,8 @@ gpio_sim_line_config_name_show(struct config_item *item, char *page)
 	struct gpio_sim_device *dev = gpio_sim_line_get_device(line);
 	int ret;
 
-	mutex_lock(&dev->lock);
-	ret = sprintf(page, "%s\n", line->name ?: "");
-	mutex_unlock(&dev->lock);
+	scoped_guard(mutex, &dev->lock)
+		ret = sprintf(page, "%s\n", line->name ?: "");
 
 	return ret;
 }
@@ -1163,24 +1141,18 @@ static ssize_t gpio_sim_line_config_name_store(struct config_item *item,
 	struct gpio_sim_device *dev = gpio_sim_line_get_device(line);
 	char *trimmed;
 
-	mutex_lock(&dev->lock);
+	guard(mutex)(&dev->lock);
 
-	if (gpio_sim_device_is_live_unlocked(dev)) {
-		mutex_unlock(&dev->lock);
+	if (gpio_sim_device_is_live_unlocked(dev))
 		return -EBUSY;
-	}
 
 	trimmed = gpio_sim_strdup_trimmed(page, count);
-	if (!trimmed) {
-		mutex_unlock(&dev->lock);
+	if (!trimmed)
 		return -ENOMEM;
-	}
 
 	kfree(line->name);
 	line->name = trimmed;
 
-	mutex_unlock(&dev->lock);
-
 	return count;
 }
 
@@ -1198,9 +1170,8 @@ static ssize_t gpio_sim_hog_config_name_show(struct config_item *item,
 	struct gpio_sim_device *dev = gpio_sim_hog_get_device(hog);
 	int ret;
 
-	mutex_lock(&dev->lock);
-	ret = sprintf(page, "%s\n", hog->name ?: "");
-	mutex_unlock(&dev->lock);
+	scoped_guard(mutex, &dev->lock)
+		ret = sprintf(page, "%s\n", hog->name ?: "");
 
 	return ret;
 }
@@ -1212,24 +1183,18 @@ static ssize_t gpio_sim_hog_config_name_store(struct config_item *item,
 	struct gpio_sim_device *dev = gpio_sim_hog_get_device(hog);
 	char *trimmed;
 
-	mutex_lock(&dev->lock);
+	guard(mutex)(&dev->lock);
 
-	if (gpio_sim_device_is_live_unlocked(dev)) {
-		mutex_unlock(&dev->lock);
+	if (gpio_sim_device_is_live_unlocked(dev))
 		return -EBUSY;
-	}
 
 	trimmed = gpio_sim_strdup_trimmed(page, count);
-	if (!trimmed) {
-		mutex_unlock(&dev->lock);
+	if (!trimmed)
 		return -ENOMEM;
-	}
 
 	kfree(hog->name);
 	hog->name = trimmed;
 
-	mutex_unlock(&dev->lock);
-
 	return count;
 }
 
@@ -1243,9 +1208,8 @@ static ssize_t gpio_sim_hog_config_direction_show(struct config_item *item,
 	char *repr;
 	int dir;
 
-	mutex_lock(&dev->lock);
-	dir = hog->dir;
-	mutex_unlock(&dev->lock);
+	scoped_guard(mutex, &dev->lock)
+		dir = hog->dir;
 
 	switch (dir) {
 	case GPIOD_IN:
@@ -1274,12 +1238,10 @@ gpio_sim_hog_config_direction_store(struct config_item *item,
 	struct gpio_sim_device *dev = gpio_sim_hog_get_device(hog);
 	int dir;
 
-	mutex_lock(&dev->lock);
+	guard(mutex)(&dev->lock);
 
-	if (gpio_sim_device_is_live_unlocked(dev)) {
-		mutex_unlock(&dev->lock);
+	if (gpio_sim_device_is_live_unlocked(dev))
 		return -EBUSY;
-	}
 
 	if (sysfs_streq(page, "input"))
 		dir = GPIOD_IN;
@@ -1288,17 +1250,10 @@ gpio_sim_hog_config_direction_store(struct config_item *item,
 	else if (sysfs_streq(page, "output-low"))
 		dir = GPIOD_OUT_LOW;
 	else
-		dir = -EINVAL;
-
-	if (dir < 0) {
-		mutex_unlock(&dev->lock);
-		return dir;
-	}
+		return -EINVAL;
 
 	hog->dir = dir;
 
-	mutex_unlock(&dev->lock);
-
 	return count;
 }
 
@@ -1316,9 +1271,8 @@ static void gpio_sim_hog_config_item_release(struct config_item *item)
 	struct gpio_sim_line *line = hog->parent;
 	struct gpio_sim_device *dev = gpio_sim_hog_get_device(hog);
 
-	mutex_lock(&dev->lock);
-	line->hog = NULL;
-	mutex_unlock(&dev->lock);
+	scoped_guard(mutex, &dev->lock)
+		line->hog = NULL;
 
 	kfree(hog->name);
 	kfree(hog);
@@ -1344,13 +1298,11 @@ gpio_sim_line_config_make_hog_item(struct config_group *group, const char *name)
 	if (strcmp(name, "hog") != 0)
 		return ERR_PTR(-EINVAL);
 
-	mutex_lock(&dev->lock);
+	guard(mutex)(&dev->lock);
 
 	hog = kzalloc(sizeof(*hog), GFP_KERNEL);
-	if (!hog) {
-		mutex_unlock(&dev->lock);
+	if (!hog)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	config_item_init_type_name(&hog->item, name,
 				   &gpio_sim_hog_config_type);
@@ -1360,8 +1312,6 @@ gpio_sim_line_config_make_hog_item(struct config_group *group, const char *name)
 	hog->parent = line;
 	line->hog = hog;
 
-	mutex_unlock(&dev->lock);
-
 	return &hog->item;
 }
 
@@ -1370,9 +1320,8 @@ static void gpio_sim_line_config_group_release(struct config_item *item)
 	struct gpio_sim_line *line = to_gpio_sim_line(item);
 	struct gpio_sim_device *dev = gpio_sim_line_get_device(line);
 
-	mutex_lock(&dev->lock);
-	list_del(&line->siblings);
-	mutex_unlock(&dev->lock);
+	scoped_guard(mutex, &dev->lock)
+		list_del(&line->siblings);
 
 	kfree(line->name);
 	kfree(line);
@@ -1407,18 +1356,14 @@ gpio_sim_bank_config_make_line_group(struct config_group *group,
 	if (ret != 1 || nchar != strlen(name))
 		return ERR_PTR(-EINVAL);
 
-	mutex_lock(&dev->lock);
+	guard(mutex)(&dev->lock);
 
-	if (gpio_sim_device_is_live_unlocked(dev)) {
-		mutex_unlock(&dev->lock);
+	if (gpio_sim_device_is_live_unlocked(dev))
 		return ERR_PTR(-EBUSY);
-	}
 
 	line = kzalloc(sizeof(*line), GFP_KERNEL);
-	if (!line) {
-		mutex_unlock(&dev->lock);
+	if (!line)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	config_group_init_type_name(&line->group, name,
 				    &gpio_sim_line_config_type);
@@ -1427,8 +1372,6 @@ gpio_sim_bank_config_make_line_group(struct config_group *group,
 	line->offset = offset;
 	list_add_tail(&line->siblings, &bank->line_list);
 
-	mutex_unlock(&dev->lock);
-
 	return &line->group;
 }
 
@@ -1437,9 +1380,8 @@ static void gpio_sim_bank_config_group_release(struct config_item *item)
 	struct gpio_sim_bank *bank = to_gpio_sim_bank(item);
 	struct gpio_sim_device *dev = gpio_sim_bank_get_device(bank);
 
-	mutex_lock(&dev->lock);
-	list_del(&bank->siblings);
-	mutex_unlock(&dev->lock);
+	scoped_guard(mutex, &dev->lock)
+		list_del(&bank->siblings);
 
 	kfree(bank->label);
 	kfree(bank);
@@ -1467,18 +1409,14 @@ gpio_sim_device_config_make_bank_group(struct config_group *group,
 	struct gpio_sim_device *dev = to_gpio_sim_device(&group->cg_item);
 	struct gpio_sim_bank *bank;
 
-	mutex_lock(&dev->lock);
+	guard(mutex)(&dev->lock);
 
-	if (gpio_sim_device_is_live_unlocked(dev)) {
-		mutex_unlock(&dev->lock);
+	if (gpio_sim_device_is_live_unlocked(dev))
 		return ERR_PTR(-EBUSY);
-	}
 
 	bank = kzalloc(sizeof(*bank), GFP_KERNEL);
-	if (!bank) {
-		mutex_unlock(&dev->lock);
+	if (!bank)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	config_group_init_type_name(&bank->group, name,
 				    &gpio_sim_bank_config_group_type);
@@ -1487,8 +1425,6 @@ gpio_sim_device_config_make_bank_group(struct config_group *group,
 	INIT_LIST_HEAD(&bank->line_list);
 	list_add_tail(&bank->siblings, &dev->bank_list);
 
-	mutex_unlock(&dev->lock);
-
 	return &bank->group;
 }
 
@@ -1496,10 +1432,10 @@ static void gpio_sim_device_config_group_release(struct config_item *item)
 {
 	struct gpio_sim_device *dev = to_gpio_sim_device(item);
 
-	mutex_lock(&dev->lock);
-	if (gpio_sim_device_is_live_unlocked(dev))
-		gpio_sim_device_deactivate_unlocked(dev);
-	mutex_unlock(&dev->lock);
+	scoped_guard(mutex, &dev->lock) {
+		if (gpio_sim_device_is_live_unlocked(dev))
+			gpio_sim_device_deactivate_unlocked(dev);
+	}
 
 	mutex_destroy(&dev->lock);
 	ida_free(&gpio_sim_ida, dev->id);
@@ -1524,7 +1460,7 @@ static const struct config_item_type gpio_sim_device_config_group_type = {
 static struct config_group *
 gpio_sim_config_make_device_group(struct config_group *group, const char *name)
 {
-	struct gpio_sim_device *dev;
+	struct gpio_sim_device *dev __free(kfree) = NULL;
 	int id;
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
@@ -1532,10 +1468,8 @@ gpio_sim_config_make_device_group(struct config_group *group, const char *name)
 		return ERR_PTR(-ENOMEM);
 
 	id = ida_alloc(&gpio_sim_ida, GFP_KERNEL);
-	if (id < 0) {
-		kfree(dev);
+	if (id < 0)
 		return ERR_PTR(id);
-	}
 
 	config_group_init_type_name(&dev->group, name,
 				    &gpio_sim_device_config_group_type);
@@ -1546,7 +1480,7 @@ gpio_sim_config_make_device_group(struct config_group *group, const char *name)
 	dev->bus_notifier.notifier_call = gpio_sim_bus_notifier_call;
 	init_completion(&dev->probe_completion);
 
-	return &dev->group;
+	return &no_free_ptr(dev)->group;
 }
 
 static struct configfs_group_operations gpio_sim_config_group_ops = {
-- 
2.39.2

