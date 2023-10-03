Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF907B6C26
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240237AbjJCOvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240195AbjJCOv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:51:29 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA74A1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:51:25 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-405524e6768so9942675e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 07:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696344684; x=1696949484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1EqDAqCtBZo7z2kLkJw7lL/39F321nZ+hBeSnpopZ4=;
        b=DP2d5evg8RtAb17yHhsEp3qKo1t4rhF+2w4AzVJLqvnM/OdRCymOQFSSjAT/0MhTol
         DdbyN7xG1UWtq8BHc2vtk0eZ6acIfavd9xfmz4K8jPXwVLTlDOmThlGZ4DIDqPwZ59vc
         OjF9ol31iLwPXMrja0cCEW4doGyG0P8kstygs7kUG84n2PyQsNYiXjblqbwTHr4lUPmx
         eQ3SLXlPrSh6VhlxrJa+R0QIiV1JCUmd9VRR9ncq2T1PNm5Q2pSNOvHaaaT8owoO7NnB
         9mvzmipwTnruPJeROvR4ZD9bOGc+EeoPlTUjOm7SiEVfyBpckWfF0/xbZ6F+eqfgYGqW
         ImCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696344684; x=1696949484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1EqDAqCtBZo7z2kLkJw7lL/39F321nZ+hBeSnpopZ4=;
        b=I3K/zL6nYjUVZUSrmWRv3/+Zv+sQHp06H0FNH9U/5yNOkscjBkbCaCL/LlOW34qryW
         MwYx8yN8+GK1GLhPWchQENSDcMXZ3t50Rn6+2XrYqjgYDq1HxCj0GKx7WgA5OF/gxcey
         d+27RW8ibI/kYV/W3AJfrl/m5U3aBqmwLrSCiw6HdaQbPgp7xEsKRVkqDAHRK4jOMErx
         VGW6+vZSSS94Jq+UYOUjtQIZ4zKDJ3Q6hu8XgPggiTh6xdrhmu81E9jUs/5dL40mRIo9
         46BZj/X5Q0ww5xwFsfTnUSa/gIJVdTcogSFI+QIfeeP+UdQoS4twrz3gyP/fvZiv+eyz
         kFHg==
X-Gm-Message-State: AOJu0YwQ4sATal5u8j9eAXJq8d57nK8jZtlkiwSKosnwU1xasi6NNS3I
        Z5bi+W366o6BaM+Su0Mj4w0wN1ISi8CW5bdL/5E=
X-Google-Smtp-Source: AGHT+IE45u3d6FCnLBmAspL/qXP4y25PYnMCd8R73QpVttBd8FY+RzS2nR9kUUmu7P+pQXxCBPAjmA==
X-Received: by 2002:a7b:cbc9:0:b0:405:1ba2:4fcb with SMTP id n9-20020a7bcbc9000000b004051ba24fcbmr13493031wmi.16.1696344683602;
        Tue, 03 Oct 2023 07:51:23 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:1f2d:3479:a5de:fa35])
        by smtp.gmail.com with ESMTPSA id c15-20020a05600c0acf00b003fe29f6b61bsm1462773wmr.46.2023.10.03.07.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 07:51:22 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 02/36] pinctrl: provide new GPIO-to-pinctrl glue helpers
Date:   Tue,  3 Oct 2023 16:50:40 +0200
Message-Id: <20231003145114.21637-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003145114.21637-1-brgl@bgdev.pl>
References: <20231003145114.21637-1-brgl@bgdev.pl>
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

Currently the pinctrl GPIO helpers all take a number from the global
GPIO numberspace - of which we're trying to get rid of as argument.

These helpers are almost universally called from GPIOLIB driver
callbacks which take a pointer to the backing gpio_chip and the
controller-relative offset as arguments.

Let's provide improved variants of these functions that match the
GPIOLIB signatures as the first step in removing the older flavor.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/core.c           | 107 ++++++++++++++++++++++---------
 include/linux/pinctrl/consumer.h |  46 +++++++++++++
 2 files changed, 124 insertions(+), 29 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index e2f7519bef04..679f48c5beeb 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -23,6 +23,7 @@
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 
+#include <linux/gpio/driver.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pinctrl/devinfo.h>
 #include <linux/pinctrl/machine.h>
@@ -781,14 +782,13 @@ bool pinctrl_gpio_can_use_line(unsigned gpio)
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
@@ -817,13 +817,21 @@ int pinctrl_gpio_request(unsigned gpio)
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
@@ -846,6 +854,21 @@ void pinctrl_gpio_free(unsigned gpio)
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
@@ -869,14 +892,7 @@ static int pinctrl_gpio_direction(unsigned gpio, bool input)
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
@@ -884,13 +900,21 @@ int pinctrl_gpio_direction_input(unsigned gpio)
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
@@ -898,14 +922,22 @@ int pinctrl_gpio_direction_output(unsigned gpio)
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
@@ -926,6 +958,23 @@ int pinctrl_gpio_set_config(unsigned gpio, unsigned long config)
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

