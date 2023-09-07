Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CB57973A8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238549AbjIGP2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241096AbjIGP2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:28:09 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA36198E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:27:46 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bcb54226e7so12860851fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 08:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694100411; x=1694705211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWPps9q7CEJq96bHnOFu416k4mJ9kfxW5sLbFk5Yxo4=;
        b=pbexbxd3pI+FtFeNFFIjOZiPyTpS1MDrc9Vp1gM3vheKICMgrd6nV1MRdV2qNijQSQ
         htvq7zgeU6gmUDa0D89sUuc2Pj3oc4bqOZz9oXGeOjWrqIWNheZ2XyFt8ASIHy34RRk6
         3CroJ+0QLqWHNV6vCPabfhQm6wBU09NlEXff5o/DLp8NCyB1WdytE5Lxs24hJ4/WnYIr
         bguOLtisfIja6zQAPb6Ucy0yw9KyaibsIomVDHFKL7oZKmCCnG3jvwbBQP+9Ee18xSGq
         ZCIJkzmY5H0Ib8IAyDDw807Bc2r+E6OmSeV0Nzdegt0lfYChis3RgbmvrO6nVPV/8D2m
         aFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100411; x=1694705211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWPps9q7CEJq96bHnOFu416k4mJ9kfxW5sLbFk5Yxo4=;
        b=bgQI9vtB2xxak2ZmgrUL29KwoBsf+hLQ1svh/AfkKg6OaSOa7cG8te06+9JQ1TbdjZ
         /csQceJtDN8iuFdI2Eb0HVOpav+14yIMA61lCnKCv3Wq23BDYu2js99ZOUbnzQFrGhDJ
         RwqDlQZwomVQg26G8ObKnS13PfvaEo1ANb/Wz+ChawByDXR3pvaYUhVXE0wGUbjwUzpd
         xK4HsNRsz3JociUYJyqKKXYcFZpABSdIPeJnL4uU6Anu7uo4JIxnw/lBFdpyyw6HZkZR
         yxrnSTdOccD/9izGtloDmoqzNpIfJcWjLJJOgvxCXZq9qoYK/1dy9ldV7R0vR6fWsDLl
         XDqw==
X-Gm-Message-State: AOJu0YyK4eqj6z50awZeylPLJodOkRVfPbsFPp1elf1s4m4RQ+NU6igA
        CLu9P0Bn0VZ+oifYdE4zVzhQPSNMERt9O0BMv0w=
X-Google-Smtp-Source: AGHT+IHSSQPay0nZxYl504c1/I5ZSMW+6yvqaJiKuZ+uWRiSAz+fxXCyqA+3MtRZRy/7Ggos7+QkOQ==
X-Received: by 2002:adf:fd87:0:b0:318:416:a56a with SMTP id d7-20020adffd87000000b003180416a56amr2402815wrr.13.1694098356640;
        Thu, 07 Sep 2023 07:52:36 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:56f5:e2d4:1e04:b28e])
        by smtp.gmail.com with ESMTPSA id 2-20020a05600c020200b003feef82bbefsm2757588wmi.29.2023.09.07.07.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 07:52:36 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 5/5] gpio: mockup: don't access internal GPIOLIB structures
Date:   Thu,  7 Sep 2023 16:52:30 +0200
Message-Id: <20230907145230.44085-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230907145230.44085-1-brgl@bgdev.pl>
References: <20230907145230.44085-1-brgl@bgdev.pl>
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

Don't include gpiolib.h. Track the request status of lines locally
instead. In order to retrieve the device name use the fact that
gpio-mockup supports only a single GPIO device per platform device and
call device_find_any_child().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-mockup.c | 39 +++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 44684ff4462f..4870e267a402 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -11,6 +11,7 @@
 
 #include <linux/cleanup.h>
 #include <linux/debugfs.h>
+#include <linux/device.h>
 #include <linux/gpio/driver.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -25,8 +26,6 @@
 #include <linux/string_helpers.h>
 #include <linux/uaccess.h>
 
-#include "gpiolib.h"
-
 #define GPIO_MOCKUP_MAX_GC	10
 /*
  * We're storing two values per chip: the GPIO base and the number
@@ -42,11 +41,13 @@
  * @value:     Configures status of the gpio as 0(low) or 1(high)
  * @pull:      Configures the current pull of the GPIO as 0 (pull-down) or
  *             1 (pull-up)
+ * @requested: Request status of this GPIO
  */
 struct gpio_mockup_line_status {
 	int dir;
 	int value;
 	int pull;
+	bool requested;
 };
 
 struct gpio_mockup_chip {
@@ -146,14 +147,12 @@ static void gpio_mockup_set_multiple(struct gpio_chip *gc,
 static int gpio_mockup_apply_pull(struct gpio_mockup_chip *chip,
 				  unsigned int offset, int value)
 {
-	struct gpio_chip *gc = &chip->gc;
-	struct gpio_desc *desc = gpiochip_get_desc(gc, offset);
+	struct gpio_mockup_line_status *line = &chip->lines[offset];
 	int curr, irq, irq_type, ret = 0;
 
 	guard(mutex)(&chip->lock);
 
-	if (test_bit(FLAG_REQUESTED, &desc->flags) &&
-	    !test_bit(FLAG_IS_OUT, &desc->flags)) {
+	if (line->requested && line->dir == GPIO_LINE_DIRECTION_IN) {
 		curr = __gpio_mockup_get(chip, offset);
 		if (curr == value)
 			goto out;
@@ -181,8 +180,7 @@ static int gpio_mockup_apply_pull(struct gpio_mockup_chip *chip,
 
 set_value:
 	/* Change the value unless we're actively driving the line. */
-	if (!test_bit(FLAG_REQUESTED, &desc->flags) ||
-	    !test_bit(FLAG_IS_OUT, &desc->flags))
+	if (!line->requested || line->dir == GPIO_LINE_DIRECTION_IN)
 		__gpio_mockup_set(chip, offset, value);
 
 out:
@@ -247,10 +245,23 @@ static int gpio_mockup_to_irq(struct gpio_chip *gc, unsigned int offset)
 	return irq_create_mapping(chip->irq_sim_domain, offset);
 }
 
+static int gpio_mockup_request(struct gpio_chip *gc, unsigned int offset)
+{
+	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
+
+	scoped_guard(mutex, &chip->lock)
+		chip->lines[offset].requested = true;
+
+	return 0;
+}
+
 static void gpio_mockup_free(struct gpio_chip *gc, unsigned int offset)
 {
 	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
 
+	guard(mutex)(&chip->lock);
+
+	chip->lines[offset].requested = false;
 	__gpio_mockup_set(chip, offset, chip->lines[offset].pull);
 }
 
@@ -343,6 +354,7 @@ static const struct file_operations gpio_mockup_debugfs_ops = {
 static void gpio_mockup_debugfs_setup(struct device *dev,
 				      struct gpio_mockup_chip *chip)
 {
+	struct device *child __free(put_device) = NULL;
 	struct gpio_mockup_dbgfs_private *priv;
 	struct gpio_chip *gc;
 	const char *devname;
@@ -350,8 +362,16 @@ static void gpio_mockup_debugfs_setup(struct device *dev,
 	int i;
 
 	gc = &chip->gc;
-	devname = dev_name(&gc->gpiodev->dev);
 
+	/*
+	 * There can only be a single GPIO device per platform device in
+	 * gpio-mockup so using device_find_any_child() is OK.
+	 */
+	child = device_find_any_child(dev);
+	if (!child)
+		return;
+
+	devname = dev_name(child);
 	chip->dbg_dir = debugfs_create_dir(devname, gpio_mockup_dbg_dir);
 
 	for (i = 0; i < gc->ngpio; i++) {
@@ -435,6 +455,7 @@ static int gpio_mockup_probe(struct platform_device *pdev)
 	gc->get_direction = gpio_mockup_get_direction;
 	gc->set_config = gpio_mockup_set_config;
 	gc->to_irq = gpio_mockup_to_irq;
+	gc->request = gpio_mockup_request;
 	gc->free = gpio_mockup_free;
 
 	chip->lines = devm_kcalloc(dev, gc->ngpio,
-- 
2.39.2

