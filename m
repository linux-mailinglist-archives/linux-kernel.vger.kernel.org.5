Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CE07C52F6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346463AbjJKMJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbjJKMJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:09:11 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DE3AF
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:08 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-406618d080eso64747075e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697026147; x=1697630947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLxWzsIb/h+CtHtFpC9R9DLEmU6wwVMInqduuyQJkso=;
        b=dLelOsK9m7X8sHfydnMZFLizhjXbUITC8K3t0pjBvoceFlwNHjEqWuTYYF+HZR5WaL
         5OLQoP6/8O2G2Eto4dwDXTfiWjoqbo9flmcaorgGB4ybgXpzn6Bfsg7QPxthBCSN0x3e
         +tmcmPFMq6xDBipMTv7VWEB9K7aa1mFhrHh8b5B4oHODW/5G6LKCeLcHmvRt5w7HzRNs
         1C7gu+DdEnTGcVGSMmOmG6QcduWqUpv2bD47vSZ68/DuCckD/wV/8qAvN5HXydwnNvq9
         bQXJOVSwQ430EuekXcKP009Sf8eDP0SgIgMHFr+cI1iub2VdF4A3HeZAc0GB9XYlKFBZ
         JaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026147; x=1697630947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLxWzsIb/h+CtHtFpC9R9DLEmU6wwVMInqduuyQJkso=;
        b=bKISHMQ4iI1ePTNMH7fbKtX6dyx9j+4yoKw5q8enbSEwRD8lKokj/6oVG3rqNy976e
         bf31VYjb0mKulo/Wqzm4SKaSGizovOVitzISbewSUpqL4SmazJO5RVse4vsZQBNmfU4V
         HSmtydNCwBqQmXiZpQbDx6c6/nEegazRTmJGKIvhnM/dl4qkg5V9uwLVjHXgzbFTzwkB
         5dbH39yUrzcqJG037orDDTU6xsdTpqmJ3vrNWuNEgdlGH2nF/gDY3v4hPGPoeyz/Wn2Y
         9DT9dmmH1Pq4joW9zGS/Z7yrt4t5gKzrE7kdgLkXplrozF3hlGgYryar4epobKvWp1qn
         prpQ==
X-Gm-Message-State: AOJu0YzCHS/2km47h0mkj1HCQPmntrzYyUWemHQtk9zzo993Rkka4tIE
        k0cxCvKynv3i7PrlN9YamlIBjw==
X-Google-Smtp-Source: AGHT+IEtAJtjs9TScDr6HPr7E5inr7CeT1vgsubwLxPnFk6lkyDnL+1vHi/sCFYaaT9ek5+PLRmoxQ==
X-Received: by 2002:a7b:c4cb:0:b0:401:cb45:3fb8 with SMTP id g11-20020a7bc4cb000000b00401cb453fb8mr18579499wmk.38.1697026146967;
        Wed, 11 Oct 2023 05:09:06 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e551:3946:26fc:f94])
        by smtp.gmail.com with ESMTPSA id w21-20020a05600c015500b0040652e8ca13sm19012253wmm.43.2023.10.11.05.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:09:06 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 02/62] pinctrl: provide new GPIO-to-pinctrl glue helpers
Date:   Wed, 11 Oct 2023 14:07:30 +0200
Message-Id: <20231011120830.49324-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011120830.49324-1-brgl@bgdev.pl>
References: <20231011120830.49324-1-brgl@bgdev.pl>
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
index 2bf95d8f30cc..13a6fa85c462 100644
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

