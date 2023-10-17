Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0936D7CC2ED
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343729AbjJQMUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343650AbjJQMUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:20:03 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172C81FEB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:35 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4083740f92dso1513165e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697544334; x=1698149134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlBZOMBlUKdAOFHUnVNJUA/QQF61w0Yv6D/2R5YhEYo=;
        b=Yj+z0YYQnnV27M13hDW8rHaOhWd/OSYedYCeuP1EdPquuBn4P6Qd7H4+AAIBD6+FoQ
         nwqiI1vuwHLGphoOmCVQVRw7T8Ld8D9gJxwnyoCYJsIEr9f1NPAYxv2HEvetYNWSNxcg
         0I3GXEeTvlf7Ocoh9XTexEpXJLT2HdBnN6OT7w4fOD3gf6DnJYoWafTCvi9TyLDANOmP
         y37U8Jc1RFrIh7cKA7/2tRIHUDR/dGgWZWzn3ubLfC4A9+RV/A1ACvcIkOqnx3PZ569p
         3r9+4m1a3r0maL2oPoAqx19yb52eXLvoKUi8vZ5jN+qlzdxaYw7PExl+PIJwUG0NG+AX
         1r2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697544334; x=1698149134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BlBZOMBlUKdAOFHUnVNJUA/QQF61w0Yv6D/2R5YhEYo=;
        b=ATuWjm6kcIy/DiH3mcyrHNJ4m6LX3eR3pFTnyHgSmuoIYWZDYMZr41g3P1JRAWkqo9
         HyHVQi4qt9YtK2NNolav3y4hgT1c7tiCaVxlJs7Qugc+8eYDqEsxS7W+XhrYztckWPks
         ICdSah7eebKUCsJTT9ldlOr1OWZSXrCHqtMVVIBkGBWvFrfD7/7U0zYo8YAXcoP24iUt
         yW+FLoc1Cu0MXSi5a6i6HSQHSwrWYl85Ft65GsBELqIjGEAD5QwBOyJN46jv1s5CE6H8
         fz8fCh3Gg9bvwnDrAH0dheJAapBU/3tDlElEbRxIVx+X+rj056Ts9/gWyz1D/THmsBcy
         dMWg==
X-Gm-Message-State: AOJu0YwYig812LxKWz6G26rzB9eLcOYDXQA5w/q17Mtb6rb4Hy41gRTd
        gqkKV3XDBIvqaQodzhnnxHnblg==
X-Google-Smtp-Source: AGHT+IHHo/SgTs5SbAYA1U38mF32tiSX6qdMgwB4BaLRtTdNYl2mocFbRqEMqxStSnYwPitZyNXo6g==
X-Received: by 2002:a05:600c:3590:b0:406:7074:301d with SMTP id p16-20020a05600c359000b004067074301dmr1623378wmq.11.1697544333763;
        Tue, 17 Oct 2023 05:05:33 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b00405442edc69sm1353859wmm.14.2023.10.17.05.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:05:33 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 47/73] treewide: rename pinctrl_gpio_set_config_new()
Date:   Tue, 17 Oct 2023 14:04:05 +0200
Message-Id: <20231017120431.68847-48-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017120431.68847-1-brgl@bgdev.pl>
References: <20231017120431.68847-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Now that pinctrl_gpio_set_config() is no longer used, let's drop the
'_new' suffix from its improved variant.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-aspeed.c       | 2 +-
 drivers/gpio/gpiolib.c           | 2 +-
 drivers/pinctrl/core.c           | 6 +++---
 include/linux/pinctrl/consumer.h | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index 4c417c8486dd..04c03402db6d 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -973,7 +973,7 @@ static int aspeed_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 	else if (param == PIN_CONFIG_BIAS_DISABLE ||
 			param == PIN_CONFIG_BIAS_PULL_DOWN ||
 			param == PIN_CONFIG_DRIVE_STRENGTH)
-		return pinctrl_gpio_set_config_new(chip, offset, config);
+		return pinctrl_gpio_set_config(chip, offset, config);
 	else if (param == PIN_CONFIG_DRIVE_OPEN_DRAIN ||
 			param == PIN_CONFIG_DRIVE_OPEN_SOURCE)
 		/* Return -ENOTSUPP to trigger emulation, as per datasheet */
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 53dce41d649a..729a30e494cd 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2065,7 +2065,7 @@ EXPORT_SYMBOL_GPL(gpiochip_generic_free);
 int gpiochip_generic_config(struct gpio_chip *gc, unsigned int offset,
 			    unsigned long config)
 {
-	return pinctrl_gpio_set_config_new(gc, offset, config);
+	return pinctrl_gpio_set_config(gc, offset, config);
 }
 EXPORT_SYMBOL_GPL(gpiochip_generic_config);
 
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 0c2c18536242..d4a615eb1c39 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -904,7 +904,7 @@ int pinctrl_gpio_direction_output(struct gpio_chip *gc, unsigned int offset)
 EXPORT_SYMBOL_GPL(pinctrl_gpio_direction_output);
 
 /**
- * pinctrl_gpio_set_config_new() - Apply config to given GPIO pin
+ * pinctrl_gpio_set_config() - Apply config to given GPIO pin
  * @gc: GPIO chip structure from the GPIO subsystem
  * @offset: hardware offset of the GPIO relative to the controller
  * @config: the configuration to apply to the GPIO
@@ -913,7 +913,7 @@ EXPORT_SYMBOL_GPL(pinctrl_gpio_direction_output);
  * they need to call the underlying pin controller to change GPIO config
  * (for example set debounce time).
  */
-int pinctrl_gpio_set_config_new(struct gpio_chip *gc, unsigned int offset,
+int pinctrl_gpio_set_config(struct gpio_chip *gc, unsigned int offset,
 				unsigned long config)
 {
 	unsigned long configs[] = { config };
@@ -933,7 +933,7 @@ int pinctrl_gpio_set_config_new(struct gpio_chip *gc, unsigned int offset,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(pinctrl_gpio_set_config_new);
+EXPORT_SYMBOL_GPL(pinctrl_gpio_set_config);
 
 static struct pinctrl_state *find_state(struct pinctrl *p,
 					const char *name)
diff --git a/include/linux/pinctrl/consumer.h b/include/linux/pinctrl/consumer.h
index e7d660e98e86..73de70362b98 100644
--- a/include/linux/pinctrl/consumer.h
+++ b/include/linux/pinctrl/consumer.h
@@ -33,7 +33,7 @@ int pinctrl_gpio_direction_input(struct gpio_chip *gc,
 				 unsigned int offset);
 int pinctrl_gpio_direction_output(struct gpio_chip *gc,
 				  unsigned int offset);
-int pinctrl_gpio_set_config_new(struct gpio_chip *gc, unsigned int offset,
+int pinctrl_gpio_set_config(struct gpio_chip *gc, unsigned int offset,
 				unsigned long config);
 
 struct pinctrl * __must_check pinctrl_get(struct device *dev);
@@ -97,7 +97,7 @@ pinctrl_gpio_direction_output(struct gpio_chip *gc, unsigned int offset)
 }
 
 static inline int
-pinctrl_gpio_set_config_new(struct gpio_chip *gc, unsigned int offset,
+pinctrl_gpio_set_config(struct gpio_chip *gc, unsigned int offset,
 			    unsigned long config)
 {
 	return 0;
-- 
2.39.2

