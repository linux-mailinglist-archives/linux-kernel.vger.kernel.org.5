Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FE67B6C60
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240282AbjJCOw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240386AbjJCOwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:52:17 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C28C10D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:51:50 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40652e5718cso10186875e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 07:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696344707; x=1696949507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ttv9l7AK7Knp4l/GqCaoUCjtsDLaLIelMZbGV7bhxeo=;
        b=cAZN2WKLpNX4+vzDS3hhOXjZYwJ1LQez5OxVtsF17+tRjprWtjfSPou/rRNxABufEb
         nDqy9p+TdOnndzERe4N67bURAl4xr7d35XxwJW2ge/H9r+zQrsGYR8E8h/PNIJiZBsN2
         amkdTWudMQxNGtEg2oQG8noh87BRZVX4vzjInimBg+R8qQA+09YLtBhThSvZRdQtF6Qm
         pszt2XDZTe1pCPNhEh/JwyD6Dy7XuCccPq6rqzulZMtu9/ZMEi4sdu0i7yQPl6qWoQ2s
         sM/kW+6D4MHHzwhkT8Nm33tzRO7S0zsixTo6GdvLbZp3WJEmunT9uiuJ45CCxsOn1eH4
         Esrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696344707; x=1696949507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ttv9l7AK7Knp4l/GqCaoUCjtsDLaLIelMZbGV7bhxeo=;
        b=t/GB6zRfw1nbZLNGpCiQijG45nuX7J53QQdDnyaGcD8n8s1b6sZnL8Gbi55eBPnIJ8
         eWB3GU9vTmiHQIt4QKAMCD1qoT25bc8CqfD4aaFsGNTHSJiUHlzI/PKnU7gNVZvP7poT
         SLVxi0CnTEsHwo46Hxz1P/pBe8v5Rg0dHN4RzTnyAxZG44fsuXJJCsyJyMR9/hHSBwAb
         e0TSpihKl0fu3FIWsLmyIwWkZ5ippwnQsYZ2UcKl7KLFYW8y4/DbbXgzrxACKkvRbZH9
         KVZKSGDhB7TapkB9RWc7yGHsuk+7jbzsK9pLcrSdbzamlWPxUa4coCFsr8R8j4ZkJ+GV
         QGIA==
X-Gm-Message-State: AOJu0Yzb14rr0EX/qXdWDvssUAiQ26pUtpxozbI5BP2IDziirX68YjE6
        eiUcEubOmMHhJlOhCgM3dBqoHw==
X-Google-Smtp-Source: AGHT+IF4Sqae3S2JXgw5XfInr/b/E6r9hKOqimVWLtg56qa2ZvO2xsV73K05dbMamUYbN7hI4BOMNw==
X-Received: by 2002:a05:600c:2189:b0:405:7400:1e4c with SMTP id e9-20020a05600c218900b0040574001e4cmr12334144wme.35.1696344707573;
        Tue, 03 Oct 2023 07:51:47 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:1f2d:3479:a5de:fa35])
        by smtp.gmail.com with ESMTPSA id c15-20020a05600c0acf00b003fe29f6b61bsm1462773wmr.46.2023.10.03.07.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 07:51:47 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 30/36] pinctrl: remove old GPIO helpers
Date:   Tue,  3 Oct 2023 16:51:08 +0200
Message-Id: <20231003145114.21637-31-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003145114.21637-1-brgl@bgdev.pl>
References: <20231003145114.21637-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Old variants of pinctrl GPIO helpers are no longer used. Let's remove
them as well as convert all static functions in pinctrl/core.c that
still deal with global GPIO numbers to using the gpio_chip + offset
pairs.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/core.c           | 242 ++++++++++++-------------------
 include/linux/pinctrl/consumer.h |  35 -----
 2 files changed, 94 insertions(+), 183 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 679f48c5beeb..5bad56ed8176 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -268,7 +268,8 @@ static int pinctrl_register_pins(struct pinctrl_dev *pctldev,
 /**
  * gpio_to_pin() - GPIO range GPIO number to pin number translation
  * @range: GPIO range used for the translation
- * @gpio: gpio pin to translate to a pin number
+ * @gc: GPIO chip structure from the GPIO subsystem
+ * @offset: hardware offset of the GPIO relative to the controller
  *
  * Finds the pin number for a given GPIO using the specified GPIO range
  * as a base for translation. The distinction between linear GPIO ranges
@@ -279,25 +280,28 @@ static int pinctrl_register_pins(struct pinctrl_dev *pctldev,
  * result of successful pinctrl_get_device_gpio_range calls)!
  */
 static inline int gpio_to_pin(struct pinctrl_gpio_range *range,
-				unsigned int gpio)
+			      struct gpio_chip *gc, unsigned int offset)
 {
-	unsigned int offset = gpio - range->base;
+	unsigned int pin = gc->base + offset - range->base;
+
 	if (range->pins)
-		return range->pins[offset];
+		return range->pins[pin];
 	else
-		return range->pin_base + offset;
+		return range->pin_base + pin;
 }
 
 /**
  * pinctrl_match_gpio_range() - check if a certain GPIO pin is in range
  * @pctldev: pin controller device to check
- * @gpio: gpio pin to check taken from the global GPIO pin space
+ * @gc: GPIO chip structure from the GPIO subsystem
+ * @offset: hardware offset of the GPIO relative to the controller
  *
  * Tries to match a GPIO pin number to the ranges handled by a certain pin
  * controller, return the range or NULL
  */
 static struct pinctrl_gpio_range *
-pinctrl_match_gpio_range(struct pinctrl_dev *pctldev, unsigned gpio)
+pinctrl_match_gpio_range(struct pinctrl_dev *pctldev, struct gpio_chip *gc,
+			 unsigned int offset)
 {
 	struct pinctrl_gpio_range *range;
 
@@ -305,8 +309,8 @@ pinctrl_match_gpio_range(struct pinctrl_dev *pctldev, unsigned gpio)
 	/* Loop over the ranges */
 	list_for_each_entry(range, &pctldev->gpio_ranges, node) {
 		/* Check if we're in the valid range */
-		if (gpio >= range->base &&
-		    gpio < range->base + range->npins) {
+		if (gc->base + offset >= range->base &&
+		    gc->base + offset < range->base + range->npins) {
 			mutex_unlock(&pctldev->mutex);
 			return range;
 		}
@@ -318,7 +322,8 @@ pinctrl_match_gpio_range(struct pinctrl_dev *pctldev, unsigned gpio)
 /**
  * pinctrl_ready_for_gpio_range() - check if other GPIO pins of
  * the same GPIO chip are in range
- * @gpio: gpio pin to check taken from the global GPIO pin space
+ * @gc: GPIO chip structure from the GPIO subsystem
+ * @offset: hardware offset of the GPIO relative to the controller
  *
  * This function is complement of pinctrl_match_gpio_range(). If the return
  * value of pinctrl_match_gpio_range() is NULL, this function could be used
@@ -329,19 +334,10 @@ pinctrl_match_gpio_range(struct pinctrl_dev *pctldev, unsigned gpio)
  * is false, it means that pinctrl device may not be ready.
  */
 #ifdef CONFIG_GPIOLIB
-static bool pinctrl_ready_for_gpio_range(unsigned gpio)
+static bool pinctrl_ready_for_gpio_range(struct gpio_chip *gc)
 {
 	struct pinctrl_dev *pctldev;
 	struct pinctrl_gpio_range *range = NULL;
-	/*
-	 * FIXME: "gpio" here is a number in the global GPIO numberspace.
-	 * get rid of this from the ranges eventually and get the GPIO
-	 * descriptor from the gpio_chip.
-	 */
-	struct gpio_chip *chip = gpiod_to_chip(gpio_to_desc(gpio));
-
-	if (WARN(!chip, "no gpio_chip for gpio%i?", gpio))
-		return false;
 
 	mutex_lock(&pinctrldev_list_mutex);
 
@@ -351,8 +347,8 @@ static bool pinctrl_ready_for_gpio_range(unsigned gpio)
 		mutex_lock(&pctldev->mutex);
 		list_for_each_entry(range, &pctldev->gpio_ranges, node) {
 			/* Check if any gpio range overlapped with gpio chip */
-			if (range->base + range->npins - 1 < chip->base ||
-			    range->base > chip->base + chip->ngpio - 1)
+			if (range->base + range->npins - 1 < gc->base ||
+			    range->base > gc->base + gc->ngpio - 1)
 				continue;
 			mutex_unlock(&pctldev->mutex);
 			mutex_unlock(&pinctrldev_list_mutex);
@@ -366,12 +362,13 @@ static bool pinctrl_ready_for_gpio_range(unsigned gpio)
 	return false;
 }
 #else
-static bool pinctrl_ready_for_gpio_range(unsigned gpio) { return true; }
+static bool pinctrl_ready_for_gpio_range(struct gpio_chip *gc) { return true; }
 #endif
 
 /**
  * pinctrl_get_device_gpio_range() - find device for GPIO range
- * @gpio: the pin to locate the pin controller for
+ * @gc: GPIO chip structure from the GPIO subsystem
+ * @offset: hardware offset of the GPIO relative to the controller
  * @outdev: the pin control device if found
  * @outrange: the GPIO range if found
  *
@@ -380,7 +377,8 @@ static bool pinctrl_ready_for_gpio_range(unsigned gpio) { return true; }
  * -EPROBE_DEFER if the GPIO range could not be found in any device since it
  * may still have not been registered.
  */
-static int pinctrl_get_device_gpio_range(unsigned gpio,
+static int pinctrl_get_device_gpio_range(struct gpio_chip *gc,
+					 unsigned int offset,
 					 struct pinctrl_dev **outdev,
 					 struct pinctrl_gpio_range **outrange)
 {
@@ -392,7 +390,7 @@ static int pinctrl_get_device_gpio_range(unsigned gpio,
 	list_for_each_entry(pctldev, &pinctrldev_list, node) {
 		struct pinctrl_gpio_range *range;
 
-		range = pinctrl_match_gpio_range(pctldev, gpio);
+		range = pinctrl_match_gpio_range(pctldev, gc, offset);
 		if (range) {
 			*outdev = pctldev;
 			*outrange = range;
@@ -754,10 +752,10 @@ int pinctrl_get_group_selector(struct pinctrl_dev *pctldev,
 	return -EINVAL;
 }
 
-bool pinctrl_gpio_can_use_line(unsigned gpio)
+bool pinctrl_gpio_can_use_line_new(struct gpio_chip *gc, unsigned int offset)
 {
-	struct pinctrl_dev *pctldev;
 	struct pinctrl_gpio_range *range;
+	struct pinctrl_dev *pctldev;
 	bool result;
 	int pin;
 
@@ -766,56 +764,19 @@ bool pinctrl_gpio_can_use_line(unsigned gpio)
 	 * we're probably dealing with GPIO driver
 	 * without a backing pin controller - bail out.
 	 */
-	if (pinctrl_get_device_gpio_range(gpio, &pctldev, &range))
+	if (pinctrl_get_device_gpio_range(gc, offset, &pctldev, &range))
 		return true;
 
-	mutex_lock(&pctldev->mutex);
-
-	/* Convert to the pin controllers number space */
-	pin = gpio_to_pin(range, gpio);
-
-	result = pinmux_can_be_used_for_gpio(pctldev, pin);
-
-	mutex_unlock(&pctldev->mutex);
+	scoped_guard(mutex, &pctldev->mutex) {
+		/* Convert to the pin controllers number space */
+		pin = gpio_to_pin(range, gc, offset);
+		result = pinmux_can_be_used_for_gpio(pctldev, pin);
+	}
 
 	return result;
 }
-EXPORT_SYMBOL_GPL(pinctrl_gpio_can_use_line);
-
-bool pinctrl_gpio_can_use_line_new(struct gpio_chip *gc, unsigned int offset)
-{
-	return pinctrl_gpio_can_use_line(gc->base + offset);
-}
 EXPORT_SYMBOL_GPL(pinctrl_gpio_can_use_line_new);
 
-/* This function is deprecated and will be removed. Don't use. */
-int pinctrl_gpio_request(unsigned gpio)
-{
-	struct pinctrl_dev *pctldev;
-	struct pinctrl_gpio_range *range;
-	int ret;
-	int pin;
-
-	ret = pinctrl_get_device_gpio_range(gpio, &pctldev, &range);
-	if (ret) {
-		if (pinctrl_ready_for_gpio_range(gpio))
-			ret = 0;
-		return ret;
-	}
-
-	mutex_lock(&pctldev->mutex);
-
-	/* Convert to the pin controllers number space */
-	pin = gpio_to_pin(range, gpio);
-
-	ret = pinmux_request_gpio(pctldev, range, pin, gpio);
-
-	mutex_unlock(&pctldev->mutex);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(pinctrl_gpio_request);
-
 /**
  * pinctrl_gpio_request_new() - request a single pin to be used as GPIO
  * @gc: GPIO chip structure from the GPIO subsystem
@@ -827,33 +788,29 @@ EXPORT_SYMBOL_GPL(pinctrl_gpio_request);
  */
 int pinctrl_gpio_request_new(struct gpio_chip *gc, unsigned int offset)
 {
-	return pinctrl_gpio_request(gc->base + offset);
+	struct pinctrl_gpio_range *range;
+	struct pinctrl_dev *pctldev;
+	int ret, pin;
+
+	ret = pinctrl_get_device_gpio_range(gc, offset, &pctldev, &range);
+	if (ret) {
+		if (pinctrl_ready_for_gpio_range(gc))
+			ret = 0;
+
+		return ret;
+	}
+
+	scoped_guard(mutex, &pctldev->mutex) {
+		/* Convert to the pin controllers number space */
+		pin = gpio_to_pin(range, gc, offset);
+		ret = pinmux_request_gpio(pctldev, range, pin,
+					  gc->base + offset);
+	}
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(pinctrl_gpio_request_new);
 
-/* This function is deprecated and will be removed. Don't use. */
-void pinctrl_gpio_free(unsigned gpio)
-{
-	struct pinctrl_dev *pctldev;
-	struct pinctrl_gpio_range *range;
-	int ret;
-	int pin;
-
-	ret = pinctrl_get_device_gpio_range(gpio, &pctldev, &range);
-	if (ret) {
-		return;
-	}
-	mutex_lock(&pctldev->mutex);
-
-	/* Convert to the pin controllers number space */
-	pin = gpio_to_pin(range, gpio);
-
-	pinmux_free_gpio(pctldev, pin, range);
-
-	mutex_unlock(&pctldev->mutex);
-}
-EXPORT_SYMBOL_GPL(pinctrl_gpio_free);
-
 /**
  * pinctrl_gpio_free_new() - free control on a single pin, currently used as GPIO
  * @gc: GPIO chip structure from the GPIO subsystem
@@ -865,40 +822,42 @@ EXPORT_SYMBOL_GPL(pinctrl_gpio_free);
  */
 void pinctrl_gpio_free_new(struct gpio_chip *gc, unsigned int offset)
 {
-	return pinctrl_gpio_free(gc->base + offset);
+	struct pinctrl_gpio_range *range;
+	struct pinctrl_dev *pctldev;
+	int ret, pin;
+
+	ret = pinctrl_get_device_gpio_range(gc, offset, &pctldev, &range);
+	if (ret)
+		return;
+
+	guard(mutex)(&pctldev->mutex);
+
+	/* Convert to the pin controllers number space */
+	pin = gpio_to_pin(range, gc, offset);
+	pinmux_free_gpio(pctldev, pin, range);
 }
 EXPORT_SYMBOL_GPL(pinctrl_gpio_free_new);
 
-static int pinctrl_gpio_direction(unsigned gpio, bool input)
+static int
+pinctrl_gpio_direction(struct gpio_chip *gc, unsigned int offset, bool input)
 {
-	struct pinctrl_dev *pctldev;
 	struct pinctrl_gpio_range *range;
-	int ret;
-	int pin;
+	struct pinctrl_dev *pctldev;
+	int ret, pin;
 
-	ret = pinctrl_get_device_gpio_range(gpio, &pctldev, &range);
-	if (ret) {
+	ret = pinctrl_get_device_gpio_range(gc, offset, &pctldev, &range);
+	if (ret)
 		return ret;
+
+	scoped_guard(mutex, &pctldev->mutex) {
+		/* Convert to the pin controllers number space */
+		pin = gpio_to_pin(range, gc, offset);
+		ret = pinmux_gpio_direction(pctldev, range, pin, input);
 	}
 
-	mutex_lock(&pctldev->mutex);
-
-	/* Convert to the pin controllers number space */
-	pin = gpio_to_pin(range, gpio);
-	ret = pinmux_gpio_direction(pctldev, range, pin, input);
-
-	mutex_unlock(&pctldev->mutex);
-
 	return ret;
 }
 
-/* This function is deprecated and will be removed. Don't use. */
-int pinctrl_gpio_direction_input(unsigned gpio)
-{
-	return pinctrl_gpio_direction(gpio, true);
-}
-EXPORT_SYMBOL_GPL(pinctrl_gpio_direction_input);
-
 /**
  * pinctrl_gpio_direction_input_new() - request a GPIO pin to go into input mode
  * @gc: GPIO chip structure from the GPIO subsystem
@@ -910,17 +869,10 @@ EXPORT_SYMBOL_GPL(pinctrl_gpio_direction_input);
  */
 int pinctrl_gpio_direction_input_new(struct gpio_chip *gc, unsigned int offset)
 {
-	return pinctrl_gpio_direction_input(gc->base + offset);
+	return pinctrl_gpio_direction(gc, offset, true);
 }
 EXPORT_SYMBOL_GPL(pinctrl_gpio_direction_input_new);
 
-/* This function is deprecated and will be removed. Don't use. */
-int pinctrl_gpio_direction_output(unsigned gpio)
-{
-	return pinctrl_gpio_direction(gpio, false);
-}
-EXPORT_SYMBOL_GPL(pinctrl_gpio_direction_output);
-
 /**
  * pinctrl_gpio_direction_output_new() - request a GPIO pin to go into output
  *                                       mode
@@ -933,31 +885,10 @@ EXPORT_SYMBOL_GPL(pinctrl_gpio_direction_output);
  */
 int pinctrl_gpio_direction_output_new(struct gpio_chip *gc, unsigned int offset)
 {
-	return pinctrl_gpio_direction_output(gc->base + offset);
+	return pinctrl_gpio_direction(gc, offset, false);
 }
 EXPORT_SYMBOL_GPL(pinctrl_gpio_direction_output_new);
 
-/* This function is deprecated and will be removed. Don't use. */
-int pinctrl_gpio_set_config(unsigned gpio, unsigned long config)
-{
-	unsigned long configs[] = { config };
-	struct pinctrl_gpio_range *range;
-	struct pinctrl_dev *pctldev;
-	int ret, pin;
-
-	ret = pinctrl_get_device_gpio_range(gpio, &pctldev, &range);
-	if (ret)
-		return ret;
-
-	mutex_lock(&pctldev->mutex);
-	pin = gpio_to_pin(range, gpio);
-	ret = pinconf_set_config(pctldev, pin, configs, ARRAY_SIZE(configs));
-	mutex_unlock(&pctldev->mutex);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(pinctrl_gpio_set_config);
-
 /**
  * pinctrl_gpio_set_config_new() - Apply config to given GPIO pin
  * @gc: GPIO chip structure from the GPIO subsystem
@@ -971,7 +902,22 @@ EXPORT_SYMBOL_GPL(pinctrl_gpio_set_config);
 int pinctrl_gpio_set_config_new(struct gpio_chip *gc, unsigned int offset,
 				unsigned long config)
 {
-	return pinctrl_gpio_set_config(gc->base + offset, config);
+	unsigned long configs[] = { config };
+	struct pinctrl_gpio_range *range;
+	struct pinctrl_dev *pctldev;
+	int ret, pin;
+
+	ret = pinctrl_get_device_gpio_range(gc, offset, &pctldev, &range);
+	if (ret)
+		return ret;
+
+	scoped_guard(mutex, &pctldev->mutex) {
+		pin = gpio_to_pin(range, gc, offset);
+		ret = pinconf_set_config(pctldev, pin, configs,
+					 ARRAY_SIZE(configs));
+	}
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(pinctrl_gpio_set_config_new);
 
diff --git a/include/linux/pinctrl/consumer.h b/include/linux/pinctrl/consumer.h
index c95c13983376..aa3a7a7ca52d 100644
--- a/include/linux/pinctrl/consumer.h
+++ b/include/linux/pinctrl/consumer.h
@@ -26,19 +26,13 @@ struct pinctrl_state;
 #ifdef CONFIG_PINCTRL
 
 /* External interface to pin control */
-bool pinctrl_gpio_can_use_line(unsigned gpio);
 bool pinctrl_gpio_can_use_line_new(struct gpio_chip *gc, unsigned int offset);
-int pinctrl_gpio_request(unsigned gpio);
 int pinctrl_gpio_request_new(struct gpio_chip *gc, unsigned int offset);
-void pinctrl_gpio_free(unsigned gpio);
 void pinctrl_gpio_free_new(struct gpio_chip *gc, unsigned int offset);
-int pinctrl_gpio_direction_input(unsigned gpio);
 int pinctrl_gpio_direction_input_new(struct gpio_chip *gc,
 				     unsigned int offset);
-int pinctrl_gpio_direction_output(unsigned gpio);
 int pinctrl_gpio_direction_output_new(struct gpio_chip *gc,
 				      unsigned int offset);
-int pinctrl_gpio_set_config(unsigned gpio, unsigned long config);
 int pinctrl_gpio_set_config_new(struct gpio_chip *gc, unsigned int offset,
 				unsigned long config);
 
@@ -73,64 +67,35 @@ static inline int pinctrl_pm_select_idle_state(struct device *dev)
 
 #else /* !CONFIG_PINCTRL */
 
-static inline bool pinctrl_gpio_can_use_line(unsigned gpio)
-{
-	return true;
-}
-
 static inline bool
 pinctrl_gpio_can_use_line_new(struct gpio_chip *gc, unsigned int offset)
 {
 	return true;
 }
 
-static inline int pinctrl_gpio_request(unsigned gpio)
-{
-	return 0;
-}
-
 static inline int
 pinctrl_gpio_request_new(struct gpio_chip *gc, unsigned int offset)
 {
 	return 0;
 }
 
-static inline void pinctrl_gpio_free(unsigned gpio)
-{
-}
-
 static inline void
 pinctrl_gpio_free_new(struct gpio_chip *gc, unsigned int offset)
 {
 }
 
-static inline int pinctrl_gpio_direction_input(unsigned gpio)
-{
-	return 0;
-}
-
 static inline int
 pinctrl_gpio_direction_input_new(struct gpio_chip *gc, unsigned int offset)
 {
 	return 0;
 }
 
-static inline int pinctrl_gpio_direction_output(unsigned gpio)
-{
-	return 0;
-}
-
 static inline int
 pinctrl_gpio_direction_output_new(struct gpio_chip *gc, unsigned int offset)
 {
 	return 0;
 }
 
-static inline int pinctrl_gpio_set_config(unsigned gpio, unsigned long config)
-{
-	return 0;
-}
-
 static inline int
 pinctrl_gpio_set_config_new(struct gpio_chip *gc, unsigned int offset,
 			    unsigned long config)
-- 
2.39.2

