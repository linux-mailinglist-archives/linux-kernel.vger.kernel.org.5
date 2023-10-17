Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF6F7CC22E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbjJQME6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbjJQMEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:04:54 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D615EA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:04:52 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-405497850dbso54303265e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697544291; x=1698149091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDPPG8QeEjXolFjUXbjhpSbzoHQO2mUvJPEw2R2sG4g=;
        b=EMPeZQHXva58CabESQC4WX509CTrFCqwZD4pFfpnDQj6xrDSB9l8JYqXEaf577H9CL
         WK03UhFLZBS/7YaIAe78nXwMYH45y0GHTENfpmuJldtjZyeD4pmQocllK4alOGnBq27W
         x0qqv1K2ThNNRR7HQk/ur2OZfcPQTIWO0EjdoDYyWswW7V3utWI2z2ouE/gwp/J+eiHy
         QZDmUVPbbXoz6geRsM6yPQvUpczwlnK7LkonOe9jhfX87h7dj1nux6UTTjvXjrEoP4tD
         u1C9LcX20zaDmDdoAUgrXZtLx+mKSGnLz/F2Lg1mmRvS6Eey0qU4vEMErQLywHehafzd
         gjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697544291; x=1698149091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDPPG8QeEjXolFjUXbjhpSbzoHQO2mUvJPEw2R2sG4g=;
        b=V9sVblpWweZlk0xpzKAnp9IgnIxqV8kPWVlZVIgjRBaM9Z7q1Q4SUu333WKiwKONJd
         AuEIJVUngcric70bmvMPcMrnITf00Nro8oVdo86vOTH1zt7XlVKaFtZIGP019+p76yFc
         fWmlwrY27dym0Ou8PwpyTmUn6ciqHj5LyQWEO+1gFF8bGarvwn4wb3glRdg43IPDz/im
         LhIRkuMV9T3S0M94J35+442/STmkBPmZu7aOcMmv+P7ccRbvSimwhwGKfOuQtd1561m3
         MoSOjruAmnt4jPzIkQ2CRuSlaDJLVT0bNRRKYSXBW42j9eu6IH/2ZU6EgWFQUsNgn4xr
         +oCg==
X-Gm-Message-State: AOJu0Yyft1Y7JWdz8qF/FWT2nk3x0u5W6uvPwObliV/avoVJ0EE3ay5d
        FEQa5c19BEUP/SPhNNomOz1eog==
X-Google-Smtp-Source: AGHT+IFVX4szWxW17yEip5UZ2AuD3RpKciAgXfA8C/yANBf8pa18lBqBy8fz2bpXonFqAnv8ANWJEQ==
X-Received: by 2002:a05:600c:510d:b0:407:8f23:ce2 with SMTP id o13-20020a05600c510d00b004078f230ce2mr1531828wms.31.1697544290532;
        Tue, 17 Oct 2023 05:04:50 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b00405442edc69sm1353859wmm.14.2023.10.17.05.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:04:49 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 02/73] pinctrl: provide new GPIO-to-pinctrl glue helpers
Date:   Tue, 17 Oct 2023 14:03:20 +0200
Message-Id: <20231017120431.68847-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017120431.68847-1-brgl@bgdev.pl>
References: <20231017120431.68847-1-brgl@bgdev.pl>
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

Currently the pinctrl GPIO helpers all take a number from the global
GPIO numberspace - of which we're trying to get rid of as argument.

These helpers are almost universally called from GPIOLIB driver
callbacks which take a pointer to the backing gpio_chip and the
controller-relative offset as arguments.

Let's provide improved variants of these functions that match the
GPIOLIB signatures as the first step in removing the older flavor.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/core.c           | 108 ++++++++++++++++++++++---------
 include/linux/pinctrl/consumer.h |  46 +++++++++++++
 2 files changed, 125 insertions(+), 29 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 9900f8e9e321..6cd22829544c 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -23,6 +23,8 @@
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 
+#include <linux/gpio/driver.h>
+
 #include <linux/pinctrl/consumer.h>
 #include <linux/pinctrl/devinfo.h>
 #include <linux/pinctrl/machine.h>
@@ -781,14 +783,13 @@ bool pinctrl_gpio_can_use_line(unsigned gpio)
 }
 EXPORT_SYMBOL_GPL(pinctrl_gpio_can_use_line);
 
-/**
- * pinctrl_gpio_request() - request a single pin to be used as GPIO
- * @gpio: the GPIO pin number from the GPIO subsystem number space
- *
- * This function should *ONLY* be used from gpiolib-based GPIO drivers,
- * as part of their gpio_request() semantics, platforms and individual drivers
- * shall *NOT* request GPIO pins to be muxed in.
- */
+bool pinctrl_gpio_can_use_line_new(struct gpio_chip *gc, unsigned int offset)
+{
+	return pinctrl_gpio_can_use_line(gc->base + offset);
+}
+EXPORT_SYMBOL_GPL(pinctrl_gpio_can_use_line_new);
+
+/* This function is deprecated and will be removed. Don't use. */
 int pinctrl_gpio_request(unsigned gpio)
 {
 	struct pinctrl_dev *pctldev;
@@ -817,13 +818,21 @@ int pinctrl_gpio_request(unsigned gpio)
 EXPORT_SYMBOL_GPL(pinctrl_gpio_request);
 
 /**
- * pinctrl_gpio_free() - free control on a single pin, currently used as GPIO
- * @gpio: the GPIO pin number from the GPIO subsystem number space
+ * pinctrl_gpio_request_new() - request a single pin to be used as GPIO
+ * @gc: GPIO chip structure from the GPIO subsystem
+ * @offset: hardware offset of the GPIO relative to the controller
  *
  * This function should *ONLY* be used from gpiolib-based GPIO drivers,
- * as part of their gpio_free() semantics, platforms and individual drivers
- * shall *NOT* request GPIO pins to be muxed out.
+ * as part of their gpio_request() semantics, platforms and individual drivers
+ * shall *NOT* request GPIO pins to be muxed in.
  */
+int pinctrl_gpio_request_new(struct gpio_chip *gc, unsigned int offset)
+{
+	return pinctrl_gpio_request(gc->base + offset);
+}
+EXPORT_SYMBOL_GPL(pinctrl_gpio_request_new);
+
+/* This function is deprecated and will be removed. Don't use. */
 void pinctrl_gpio_free(unsigned gpio)
 {
 	struct pinctrl_dev *pctldev;
@@ -846,6 +855,21 @@ void pinctrl_gpio_free(unsigned gpio)
 }
 EXPORT_SYMBOL_GPL(pinctrl_gpio_free);
 
+/**
+ * pinctrl_gpio_free_new() - free control on a single pin, currently used as GPIO
+ * @gc: GPIO chip structure from the GPIO subsystem
+ * @offset: hardware offset of the GPIO relative to the controller
+ *
+ * This function should *ONLY* be used from gpiolib-based GPIO drivers,
+ * as part of their gpio_request() semantics, platforms and individual drivers
+ * shall *NOT* request GPIO pins to be muxed in.
+ */
+void pinctrl_gpio_free_new(struct gpio_chip *gc, unsigned int offset)
+{
+	return pinctrl_gpio_free(gc->base + offset);
+}
+EXPORT_SYMBOL_GPL(pinctrl_gpio_free_new);
+
 static int pinctrl_gpio_direction(unsigned gpio, bool input)
 {
 	struct pinctrl_dev *pctldev;
@@ -869,14 +893,7 @@ static int pinctrl_gpio_direction(unsigned gpio, bool input)
 	return ret;
 }
 
-/**
- * pinctrl_gpio_direction_input() - request a GPIO pin to go into input mode
- * @gpio: the GPIO pin number from the GPIO subsystem number space
- *
- * This function should *ONLY* be used from gpiolib-based GPIO drivers,
- * as part of their gpio_direction_input() semantics, platforms and individual
- * drivers shall *NOT* touch pin control GPIO calls.
- */
+/* This function is deprecated and will be removed. Don't use. */
 int pinctrl_gpio_direction_input(unsigned gpio)
 {
 	return pinctrl_gpio_direction(gpio, true);
@@ -884,13 +901,21 @@ int pinctrl_gpio_direction_input(unsigned gpio)
 EXPORT_SYMBOL_GPL(pinctrl_gpio_direction_input);
 
 /**
- * pinctrl_gpio_direction_output() - request a GPIO pin to go into output mode
- * @gpio: the GPIO pin number from the GPIO subsystem number space
+ * pinctrl_gpio_direction_input_new() - request a GPIO pin to go into input mode
+ * @gc: GPIO chip structure from the GPIO subsystem
+ * @offset: hardware offset of the GPIO relative to the controller
  *
  * This function should *ONLY* be used from gpiolib-based GPIO drivers,
- * as part of their gpio_direction_output() semantics, platforms and individual
+ * as part of their gpio_direction_input() semantics, platforms and individual
  * drivers shall *NOT* touch pin control GPIO calls.
  */
+int pinctrl_gpio_direction_input_new(struct gpio_chip *gc, unsigned int offset)
+{
+	return pinctrl_gpio_direction_input(gc->base + offset);
+}
+EXPORT_SYMBOL_GPL(pinctrl_gpio_direction_input_new);
+
+/* This function is deprecated and will be removed. Don't use. */
 int pinctrl_gpio_direction_output(unsigned gpio)
 {
 	return pinctrl_gpio_direction(gpio, false);
@@ -898,14 +923,22 @@ int pinctrl_gpio_direction_output(unsigned gpio)
 EXPORT_SYMBOL_GPL(pinctrl_gpio_direction_output);
 
 /**
- * pinctrl_gpio_set_config() - Apply config to given GPIO pin
- * @gpio: the GPIO pin number from the GPIO subsystem number space
- * @config: the configuration to apply to the GPIO
+ * pinctrl_gpio_direction_output_new() - request a GPIO pin to go into output
+ *                                       mode
+ * @gc: GPIO chip structure from the GPIO subsystem
+ * @offset: hardware offset of the GPIO relative to the controller
  *
- * This function should *ONLY* be used from gpiolib-based GPIO drivers, if
- * they need to call the underlying pin controller to change GPIO config
- * (for example set debounce time).
+ * This function should *ONLY* be used from gpiolib-based GPIO drivers,
+ * as part of their gpio_direction_output() semantics, platforms and individual
+ * drivers shall *NOT* touch pin control GPIO calls.
  */
+int pinctrl_gpio_direction_output_new(struct gpio_chip *gc, unsigned int offset)
+{
+	return pinctrl_gpio_direction_output(gc->base + offset);
+}
+EXPORT_SYMBOL_GPL(pinctrl_gpio_direction_output_new);
+
+/* This function is deprecated and will be removed. Don't use. */
 int pinctrl_gpio_set_config(unsigned gpio, unsigned long config)
 {
 	unsigned long configs[] = { config };
@@ -926,6 +959,23 @@ int pinctrl_gpio_set_config(unsigned gpio, unsigned long config)
 }
 EXPORT_SYMBOL_GPL(pinctrl_gpio_set_config);
 
+/**
+ * pinctrl_gpio_set_config_new() - Apply config to given GPIO pin
+ * @gc: GPIO chip structure from the GPIO subsystem
+ * @offset: hardware offset of the GPIO relative to the controller
+ * @config: the configuration to apply to the GPIO
+ *
+ * This function should *ONLY* be used from gpiolib-based GPIO drivers, if
+ * they need to call the underlying pin controller to change GPIO config
+ * (for example set debounce time).
+ */
+int pinctrl_gpio_set_config_new(struct gpio_chip *gc, unsigned int offset,
+				unsigned long config)
+{
+	return pinctrl_gpio_set_config(gc->base + offset, config);
+}
+EXPORT_SYMBOL_GPL(pinctrl_gpio_set_config_new);
+
 static struct pinctrl_state *find_state(struct pinctrl *p,
 					const char *name)
 {
diff --git a/include/linux/pinctrl/consumer.h b/include/linux/pinctrl/consumer.h
index 22eef0a513ce..c95c13983376 100644
--- a/include/linux/pinctrl/consumer.h
+++ b/include/linux/pinctrl/consumer.h
@@ -17,6 +17,7 @@
 #include <linux/pinctrl/pinctrl-state.h>
 
 struct device;
+struct gpio_chip;
 
 /* This struct is private to the core and should be regarded as a cookie */
 struct pinctrl;
@@ -26,11 +27,20 @@ struct pinctrl_state;
 
 /* External interface to pin control */
 bool pinctrl_gpio_can_use_line(unsigned gpio);
+bool pinctrl_gpio_can_use_line_new(struct gpio_chip *gc, unsigned int offset);
 int pinctrl_gpio_request(unsigned gpio);
+int pinctrl_gpio_request_new(struct gpio_chip *gc, unsigned int offset);
 void pinctrl_gpio_free(unsigned gpio);
+void pinctrl_gpio_free_new(struct gpio_chip *gc, unsigned int offset);
 int pinctrl_gpio_direction_input(unsigned gpio);
+int pinctrl_gpio_direction_input_new(struct gpio_chip *gc,
+				     unsigned int offset);
 int pinctrl_gpio_direction_output(unsigned gpio);
+int pinctrl_gpio_direction_output_new(struct gpio_chip *gc,
+				      unsigned int offset);
 int pinctrl_gpio_set_config(unsigned gpio, unsigned long config);
+int pinctrl_gpio_set_config_new(struct gpio_chip *gc, unsigned int offset,
+				unsigned long config);
 
 struct pinctrl * __must_check pinctrl_get(struct device *dev);
 void pinctrl_put(struct pinctrl *p);
@@ -68,30 +78,66 @@ static inline bool pinctrl_gpio_can_use_line(unsigned gpio)
 	return true;
 }
 
+static inline bool
+pinctrl_gpio_can_use_line_new(struct gpio_chip *gc, unsigned int offset)
+{
+	return true;
+}
+
 static inline int pinctrl_gpio_request(unsigned gpio)
 {
 	return 0;
 }
 
+static inline int
+pinctrl_gpio_request_new(struct gpio_chip *gc, unsigned int offset)
+{
+	return 0;
+}
+
 static inline void pinctrl_gpio_free(unsigned gpio)
 {
 }
 
+static inline void
+pinctrl_gpio_free_new(struct gpio_chip *gc, unsigned int offset)
+{
+}
+
 static inline int pinctrl_gpio_direction_input(unsigned gpio)
 {
 	return 0;
 }
 
+static inline int
+pinctrl_gpio_direction_input_new(struct gpio_chip *gc, unsigned int offset)
+{
+	return 0;
+}
+
 static inline int pinctrl_gpio_direction_output(unsigned gpio)
 {
 	return 0;
 }
 
+static inline int
+pinctrl_gpio_direction_output_new(struct gpio_chip *gc, unsigned int offset)
+{
+	return 0;
+}
+
 static inline int pinctrl_gpio_set_config(unsigned gpio, unsigned long config)
 {
 	return 0;
 }
 
+static inline int
+pinctrl_gpio_set_config_new(struct gpio_chip *gc, unsigned int offset,
+			    unsigned long config)
+{
+	return 0;
+}
+
 static inline struct pinctrl * __must_check pinctrl_get(struct device *dev)
 {
 	return NULL;
-- 
2.39.2

