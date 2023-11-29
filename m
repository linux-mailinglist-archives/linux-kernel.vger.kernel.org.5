Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795977FD94B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbjK2OY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbjK2OYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:24:38 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E039010EF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:24:33 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40b4a8db314so20176045e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701267872; x=1701872672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4MUC5eIDni/buanxrUZQlfU7mM7/HRQ/uDUqZDkwLQ=;
        b=2JS/SOydiknEuqmFOYDnpQfOVtxGkBRZY8XxDaZBUM0fS0jUw1xbvXhpHfg+ll24M+
         s25G4Ll0kIQpwCF0XCy+nAE+JIF2QWIln1/wSFxrrBfryHwX/0aZTgaQ7RYgWWIfenok
         hyYs9xJNsYbwURFUyXfa/ELuGq3jtb5rPSaKBoe6wlBohBeQo0IJWmS6x0EFq5XT0QiB
         AmsmqOwI6Sq0N5SVE1qH+xcHsuOxZKPR4hiSbacH950E/4SPQ0KUQ4eUz+DMiwqlrTq4
         KalbYjiJlpeLI0ccbYVXBCu+o7KLSieBN9tP4rDswlK6XAQ6trVmVDOHg0K4rw4rzWPP
         0iJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701267872; x=1701872672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4MUC5eIDni/buanxrUZQlfU7mM7/HRQ/uDUqZDkwLQ=;
        b=NLKrrzY+sr3ziaT/jmWXDxhvBKc5Oe1nBnlh+783p3INckONTegRKb57/vrSrFuFYU
         pdIa48M9rNl44ohhQXveNv/ihZ7GpkVg8ZOpUZvg6OfMqLu4GtYjD0kM2igZeACTVTpW
         YbIPay1xdZpE9DDzPAV2I8b1F30nqC+eCqDqsISuiSN9wtzeV7S3BsdiPsJICZaX/L1s
         WnGyC6bfFSQU9oyhSoYkpWUwusQ9bMQsTpFuZulDJ4PVtE3ZKyjYkrzo0NkCjGRy0DYE
         7nz3oQxKNjRUdBrw8oZSgn2w1zuso+h0ZUTsKFGaKuy39gpOolxaC7TtRTz4e7DE/QQC
         ldRA==
X-Gm-Message-State: AOJu0Yw87rokzTRIiBnsAt5+vs6+WbNmI4RY/thIUcSFJvScrDRyG25m
        7K9KCo5c5nEgaBS0UWBv1b715GsUvQ2gpbqdBVE=
X-Google-Smtp-Source: AGHT+IEIhjE3hyoM/RXTc0cdiJwPMiOTEp4g658vnqp6nZCY6jMei2HDNMvjcMgAUPil9kSpdJQRzA==
X-Received: by 2002:a05:600c:3ca0:b0:40b:37d9:b646 with SMTP id bg32-20020a05600c3ca000b0040b37d9b646mr11047907wmb.3.1701267872204;
        Wed, 29 Nov 2023 06:24:32 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4520:2f25:4d3a:4adf])
        by smtp.gmail.com with ESMTPSA id n40-20020a05600c3ba800b0040b34720206sm2406848wms.12.2023.11.29.06.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:24:31 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 10/10] gpiolib: remove gpiochip_is_requested()
Date:   Wed, 29 Nov 2023 15:24:11 +0100
Message-Id: <20231129142411.76863-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231129142411.76863-1-brgl@bgdev.pl>
References: <20231129142411.76863-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We have no external users of gpiochip_is_requested(). Let's remove it
and replace its internal calls with direct testing of the REQUESTED flag.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c      | 46 ++++++++++---------------------------
 include/linux/gpio/driver.h |  1 -
 2 files changed, 12 insertions(+), 35 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 8e932e6a6a8d..3070a4f7bbb1 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1085,7 +1085,7 @@ void gpiochip_remove(struct gpio_chip *gc)
 
 	spin_lock_irqsave(&gpio_lock, flags);
 	for (i = 0; i < gdev->ngpio; i++) {
-		if (gpiochip_is_requested(gc, i))
+		if (test_bit(FLAG_REQUESTED, &gdev->descs[i].flags))
 			break;
 	}
 	spin_unlock_irqrestore(&gpio_lock, flags);
@@ -2373,33 +2373,6 @@ void gpiod_free(struct gpio_desc *desc)
 	gpio_device_put(desc->gdev);
 }
 
-/**
- * gpiochip_is_requested - return string iff signal was requested
- * @gc: controller managing the signal
- * @offset: of signal within controller's 0..(ngpio - 1) range
- *
- * Returns NULL if the GPIO is not currently requested, else a string.
- * The string returned is the label passed to gpio_request(); if none has been
- * passed it is a meaningless, non-NULL constant.
- *
- * This function is for use by GPIO controller drivers.  The label can
- * help with diagnostics, and knowing that the signal is used as a GPIO
- * can help avoid accidentally multiplexing it to another controller.
- */
-const char *gpiochip_is_requested(struct gpio_chip *gc, unsigned int offset)
-{
-	struct gpio_desc *desc;
-
-	desc = gpiochip_get_desc(gc, offset);
-	if (IS_ERR(desc))
-		return NULL;
-
-	if (test_bit(FLAG_REQUESTED, &desc->flags) == 0)
-		return NULL;
-	return desc->label;
-}
-EXPORT_SYMBOL_GPL(gpiochip_is_requested);
-
 /**
  * gpiochip_dup_line_label - Get a copy of the consumer label.
  * @gc: GPIO chip controlling this line.
@@ -2414,16 +2387,21 @@ EXPORT_SYMBOL_GPL(gpiochip_is_requested);
  */
 char *gpiochip_dup_line_label(struct gpio_chip *gc, unsigned int offset)
 {
-	const char *label;
+	struct gpio_desc *desc;
 	char *cpy;
 
-	label = gpiochip_is_requested(gc, offset);
-	if (!label)
+	desc = gpiochip_get_desc(gc, offset);
+	if (IS_ERR(desc))
 		return NULL;
 
-	cpy = kstrdup(label, GFP_KERNEL);
-	if (!cpy)
-		return ERR_PTR(-ENOMEM);
+	scoped_guard(spinlock_irqsave, &gpio_lock) {
+		if (!test_bit(FLAG_REQUESTED, &desc->flags))
+			return NULL;
+
+		cpy = kstrdup(desc->label, GFP_KERNEL);
+		if (!cpy)
+			return ERR_PTR(-ENOMEM);
+	}
 
 	return cpy;
 }
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 6405f6d454af..1679e6fa5469 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -531,7 +531,6 @@ struct gpio_chip {
 #endif /* CONFIG_OF_GPIO */
 };
 
-const char *gpiochip_is_requested(struct gpio_chip *gc, unsigned int offset);
 char *gpiochip_dup_line_label(struct gpio_chip *gc, unsigned int offset);
 
 /**
-- 
2.40.1

