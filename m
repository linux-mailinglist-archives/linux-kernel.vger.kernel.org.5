Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D749D79D294
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbjILNon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235666AbjILNoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:44:38 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B758C10D0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:44:34 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-500b66f8b27so9780342e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694526273; x=1695131073; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hcRqYFKU8stwmYS/VPO0R5cxdC9+AAdNewrnsh3GP6U=;
        b=BkGqA9W00MRrnnwScpgkBd6OF3+uPZny4j2d7t3y9KfWZHMBFaUBb9y6ahf9vr/c+I
         ustg5Ib+nbBtydBVL6CQfZ29v14Vg9w7MbuXBHitVfYgOQXz+xXedE70c/VGXbdH7W3I
         VCVIuqrKzS2192RbTesaxLQkAP+kQscPjmnd56D7vTp9p0qob/WBT6nOCNP1FTxFMgN3
         2s5I4EfiQaVfLBxQA6IK8e/m33nOhwxBlLrpXGJBTkKQUjER5jD3C7bWSWij+S1Em9uK
         W1xZougum30i5OqBc3J7+k8PysXM7GD9XpxC4Q12rHOS2N4r/FXph9/0/AmwZfDMOujZ
         tcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694526273; x=1695131073;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hcRqYFKU8stwmYS/VPO0R5cxdC9+AAdNewrnsh3GP6U=;
        b=HlZas89Ye4GdaYrcq/gTrJBqpc6DnLx80o8m9ou9XptQQWdNxPg51PhGfkMnv+zxhn
         HXgzTwM4b9JSTq+rmCjX0Sgk0nlttiam2gaO7/mpAn65iGA3vgSzLLEzLPc+F7tuILZA
         /m9MaoZ9TPFhsL5KbtzX4L4YIMylOflwlykURtYvcN4fMK+IK7pVmeNSZvI8LnnMrXbY
         SuZjb47mXdUOv93XVnHRamAa3WUiHmRHXR6iOYxqNRzcey02xqh7GqG6uXLUFSVOdBZS
         6+CiI9wj/I4UJ9aSfMGAnL4JVs3eXhplpuKBqBXxVPF22vo8gFTF6qMbIaJg1nvJB6t5
         9++A==
X-Gm-Message-State: AOJu0YyPrsYOSy3CLxtbQbqugFN3CESWZELz5opkps1nQDAioECi62yl
        C1rx+N+aX7UOsteVQW6dgnVsrA==
X-Google-Smtp-Source: AGHT+IG4IlRYErCpjGS9EXM2LF9vk3I04puuma43DWXA88rAPczCd0fzsspSmsLQXJBxmdjXZGwsbA==
X-Received: by 2002:a19:435d:0:b0:500:a408:dbd with SMTP id m29-20020a19435d000000b00500a4080dbdmr9094218lfj.55.1694526273069;
        Tue, 12 Sep 2023 06:44:33 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id y6-20020ac255a6000000b00500a2091e30sm1755020lfg.115.2023.09.12.06.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:44:32 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 Sep 2023 15:44:31 +0200
Subject: [PATCH 2/2] leds: triggers: gpio: Rewrite to use trigger-sources
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-gpio-led-trigger-dt-v1-2-1b50e3756dda@linaro.org>
References: <20230912-gpio-led-trigger-dt-v1-0-1b50e3756dda@linaro.org>
In-Reply-To: <20230912-gpio-led-trigger-dt-v1-0-1b50e3756dda@linaro.org>
To:     =?utf-8?q?Jan_Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By providing a GPIO line as "trigger-sources" in the FWNODE
(such as from the device tree) and combining with the
GPIO trigger, we can support a GPIO LED trigger in a natural
way from the hardware description instead of using the
custom sysfs and deprecated global GPIO numberspace.

Example:

gpio: gpio@0 {
    compatible "my-gpio";
    gpio-controller;
    #gpio-cells = <2>;
    interrupt-controller;
    #interrupt-cells = <2>;
    #trigger-source-cells = <2>;
};

leds {
    compatible = "gpio-leds";
    led-my-gpio {
        label = "device:blue:myled";
        gpios = <&gpio 0 GPIO_ACTIVE_HIGH>;
        default-state = "off";
        linux,default-trigger = "gpio";
        trigger-sources = <&gpio 1 GPIO_ACTIVE_HIGH>;
    };
};

Make this the norm, unmark the driver as broken.

Delete the sysfs handling of GPIOs.

Since GPIO descriptors inherently can describe inversion,
the inversion handling can just be deleted.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/leds/trigger/Kconfig        |   5 +-
 drivers/leds/trigger/ledtrig-gpio.c | 136 +++++++++++-------------------------
 2 files changed, 40 insertions(+), 101 deletions(-)

diff --git a/drivers/leds/trigger/Kconfig b/drivers/leds/trigger/Kconfig
index 2a57328eca20..d11d80176fc0 100644
--- a/drivers/leds/trigger/Kconfig
+++ b/drivers/leds/trigger/Kconfig
@@ -83,13 +83,10 @@ config LEDS_TRIGGER_ACTIVITY
 config LEDS_TRIGGER_GPIO
 	tristate "LED GPIO Trigger"
 	depends on GPIOLIB || COMPILE_TEST
-	depends on BROKEN
 	help
 	  This allows LEDs to be controlled by gpio events. It's good
 	  when using gpios as switches and triggering the needed LEDs
-	  from there. One use case is n810's keypad LEDs that could
-	  be triggered by this trigger when user slides up to show
-	  keypad.
+	  from there. Triggers are defined as device properties.
 
 	  If unsure, say N.
 
diff --git a/drivers/leds/trigger/ledtrig-gpio.c b/drivers/leds/trigger/ledtrig-gpio.c
index 0120faa3dafa..a9caab7998a9 100644
--- a/drivers/leds/trigger/ledtrig-gpio.c
+++ b/drivers/leds/trigger/ledtrig-gpio.c
@@ -3,12 +3,13 @@
  * ledtrig-gio.c - LED Trigger Based on GPIO events
  *
  * Copyright 2009 Felipe Balbi <me@felipebalbi.com>
+ * Copyright 2023 Linus Walleij <linus.walleij@linaro.org>
  */
 
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/leds.h>
 #include <linux/slab.h>
@@ -16,10 +17,8 @@
 
 struct gpio_trig_data {
 	struct led_classdev *led;
-
 	unsigned desired_brightness;	/* desired brightness when led is on */
-	unsigned inverted;		/* true when gpio is inverted */
-	unsigned gpio;			/* gpio that triggers the leds */
+	struct gpio_desc *gpiod;	/* gpio that triggers the led */
 };
 
 static irqreturn_t gpio_trig_irq(int irq, void *_led)
@@ -28,10 +27,7 @@ static irqreturn_t gpio_trig_irq(int irq, void *_led)
 	struct gpio_trig_data *gpio_data = led_get_trigger_data(led);
 	int tmp;
 
-	tmp = gpio_get_value_cansleep(gpio_data->gpio);
-	if (gpio_data->inverted)
-		tmp = !tmp;
-
+	tmp = gpiod_get_value_cansleep(gpio_data->gpiod);
 	if (tmp) {
 		if (gpio_data->desired_brightness)
 			led_set_brightness_nosleep(gpio_data->led,
@@ -73,93 +69,8 @@ static ssize_t gpio_trig_brightness_store(struct device *dev,
 static DEVICE_ATTR(desired_brightness, 0644, gpio_trig_brightness_show,
 		gpio_trig_brightness_store);
 
-static ssize_t gpio_trig_inverted_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct gpio_trig_data *gpio_data = led_trigger_get_drvdata(dev);
-
-	return sprintf(buf, "%u\n", gpio_data->inverted);
-}
-
-static ssize_t gpio_trig_inverted_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t n)
-{
-	struct led_classdev *led = led_trigger_get_led(dev);
-	struct gpio_trig_data *gpio_data = led_trigger_get_drvdata(dev);
-	unsigned long inverted;
-	int ret;
-
-	ret = kstrtoul(buf, 10, &inverted);
-	if (ret < 0)
-		return ret;
-
-	if (inverted > 1)
-		return -EINVAL;
-
-	gpio_data->inverted = inverted;
-
-	/* After inverting, we need to update the LED. */
-	if (gpio_is_valid(gpio_data->gpio))
-		gpio_trig_irq(0, led);
-
-	return n;
-}
-static DEVICE_ATTR(inverted, 0644, gpio_trig_inverted_show,
-		gpio_trig_inverted_store);
-
-static ssize_t gpio_trig_gpio_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct gpio_trig_data *gpio_data = led_trigger_get_drvdata(dev);
-
-	return sprintf(buf, "%u\n", gpio_data->gpio);
-}
-
-static ssize_t gpio_trig_gpio_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t n)
-{
-	struct led_classdev *led = led_trigger_get_led(dev);
-	struct gpio_trig_data *gpio_data = led_trigger_get_drvdata(dev);
-	unsigned gpio;
-	int ret;
-
-	ret = sscanf(buf, "%u", &gpio);
-	if (ret < 1) {
-		dev_err(dev, "couldn't read gpio number\n");
-		return -EINVAL;
-	}
-
-	if (gpio_data->gpio == gpio)
-		return n;
-
-	if (!gpio_is_valid(gpio)) {
-		if (gpio_is_valid(gpio_data->gpio))
-			free_irq(gpio_to_irq(gpio_data->gpio), led);
-		gpio_data->gpio = gpio;
-		return n;
-	}
-
-	ret = request_threaded_irq(gpio_to_irq(gpio), NULL, gpio_trig_irq,
-			IRQF_ONESHOT | IRQF_SHARED | IRQF_TRIGGER_RISING
-			| IRQF_TRIGGER_FALLING, "ledtrig-gpio", led);
-	if (ret) {
-		dev_err(dev, "request_irq failed with error %d\n", ret);
-	} else {
-		if (gpio_is_valid(gpio_data->gpio))
-			free_irq(gpio_to_irq(gpio_data->gpio), led);
-		gpio_data->gpio = gpio;
-		/* After changing the GPIO, we need to update the LED. */
-		gpio_trig_irq(0, led);
-	}
-
-	return ret ? ret : n;
-}
-static DEVICE_ATTR(gpio, 0644, gpio_trig_gpio_show, gpio_trig_gpio_store);
-
 static struct attribute *gpio_trig_attrs[] = {
 	&dev_attr_desired_brightness.attr,
-	&dev_attr_inverted.attr,
-	&dev_attr_gpio.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(gpio_trig);
@@ -167,16 +78,47 @@ ATTRIBUTE_GROUPS(gpio_trig);
 static int gpio_trig_activate(struct led_classdev *led)
 {
 	struct gpio_trig_data *gpio_data;
+	struct device *dev = led->dev;
+	int ret;
 
 	gpio_data = kzalloc(sizeof(*gpio_data), GFP_KERNEL);
 	if (!gpio_data)
 		return -ENOMEM;
 
-	gpio_data->led = led;
-	gpio_data->gpio = -ENOENT;
+	/*
+	 * The generic property "trigger-sources" is followed,
+	 * and we hope that this is a GPIO.
+	 */
+	gpio_data->gpiod = fwnode_gpiod_get_index(dev->fwnode,
+						  "trigger-sources",
+						  0, GPIOD_IN,
+						  "led-trigger");
+	if (IS_ERR(gpio_data->gpiod)) {
+		kfree(gpio_data);
+		return PTR_ERR(gpio_data->gpiod);
+	}
+	if (!gpio_data->gpiod) {
+		dev_err(dev, "no valid GPIO for the trigger\n");
+		kfree(gpio_data);
+		return -EINVAL;
+	}
 
+	gpio_data->led = led;
 	led_set_trigger_data(led, gpio_data);
 
+	ret = request_threaded_irq(gpiod_to_irq(gpio_data->gpiod), NULL, gpio_trig_irq,
+			IRQF_ONESHOT | IRQF_SHARED | IRQF_TRIGGER_RISING
+			| IRQF_TRIGGER_FALLING, "ledtrig-gpio", led);
+	if (ret) {
+		dev_err(dev, "request_irq failed with error %d\n", ret);
+		gpiod_put(gpio_data->gpiod);
+		kfree(gpio_data);
+		return ret;
+	}
+
+	/* Finally update the LED to initial status */
+	gpio_trig_irq(0, led);
+
 	return 0;
 }
 
@@ -184,8 +126,8 @@ static void gpio_trig_deactivate(struct led_classdev *led)
 {
 	struct gpio_trig_data *gpio_data = led_get_trigger_data(led);
 
-	if (gpio_is_valid(gpio_data->gpio))
-		free_irq(gpio_to_irq(gpio_data->gpio), led);
+	free_irq(gpiod_to_irq(gpio_data->gpiod), led);
+	gpiod_put(gpio_data->gpiod);
 	kfree(gpio_data);
 }
 

-- 
2.34.1

