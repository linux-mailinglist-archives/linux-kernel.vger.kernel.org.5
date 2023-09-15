Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB717A21C9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 17:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbjIOPDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 11:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235489AbjIOPDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:03:39 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4976A268A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 08:03:33 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40472c3faadso19934865e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 08:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694790211; x=1695395011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxu4Stw3TnchTs3E1ZMW4avWovvpHjhxTZTeZz76j+U=;
        b=KgZsQgbaJxxknrew3W1dWx0u4Kyp/JlGh5TB440VWDQPUGXDMBCYVMTU5KHA3ndDf0
         IsEn6f+SpJaS+riGd5ASGo1SEL9MYiM9qnInMYQhmHZEsfVoJQ+ro1BnrHnUzuMTkW4+
         tagAZsxXh9s+bt0vv5uQZLiFT2eHwytY8QYeF65U9kxU3ac/vS5mx8drDw+9Ar/mTd+I
         dxpzAnF3YrxHqoJTHZBwfG9/4M4Yij8r4QfoJKkHNONxeNPqLXFe3R1H8hHWv3bHDkOO
         WdGxoZdghmu1bIVbo1xvD4rK9L/9WnHoacnoDfV+3nOfnJbvKLfJCSI1whOu7bjBzgME
         LQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694790211; x=1695395011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxu4Stw3TnchTs3E1ZMW4avWovvpHjhxTZTeZz76j+U=;
        b=jbT+IsZSthctz3G28uAMje2XxyI2eOf/nKJIQUR1YnnQmYRQ6BidBLr1F9esP1Jg1i
         iG5PMHWnjhkfGmruFSSlboeY9drV6IY5Lq69yzm/QaaRdTD+rKq8lacx3PBnFaX4kvBc
         ziIGAtIqnmYFXkdQ6ShUtz47qSdBDBjZ1GQPxRRdTAgKHjLSCos0LkpNeB5dnQ6VQcDN
         II8kPEY2JOEl6Ewjz/XRGwBME2HtphaQvIgjS2YlbluSRguFMddVw5NuFO2DLqS0pDMy
         a6KHPPYmYas3bjt/W3s++s2MlNoOh99gOp5ptVODZoyRjY4B69mzT75NiJK9HNwEkZ7K
         nPwA==
X-Gm-Message-State: AOJu0YyItdKLwZltDiQFCe2X/hpx5EHHi8XJUKMMe3wkyjbPuUcgycZ8
        YhWuorK5L4uBGo0do98mguKiOQ==
X-Google-Smtp-Source: AGHT+IEi8q6lvXBgZqOFvzjqXtX1Hg6TltZCZKdPEvd0Tp42WI2DjfKN8Be7Pi4kAX8uyF+ILCSwrQ==
X-Received: by 2002:a1c:ed10:0:b0:401:daf2:2737 with SMTP id l16-20020a1ced10000000b00401daf22737mr1945005wmh.30.1694790211489;
        Fri, 15 Sep 2023 08:03:31 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:aa19:4569:aeeb:c0d3])
        by smtp.gmail.com with ESMTPSA id hn40-20020a05600ca3a800b003fef19bb55csm4853369wmb.34.2023.09.15.08.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 08:03:30 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 01/11] gpiolib: make gpio_device_get() and gpio_device_put() public
Date:   Fri, 15 Sep 2023 17:03:16 +0200
Message-Id: <20230915150327.81918-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230915150327.81918-1-brgl@bgdev.pl>
References: <20230915150327.81918-1-brgl@bgdev.pl>
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

In order to start migrating away from accessing struct gpio_chip by
users other than their owners, let's first make the reference management
functions for the opaque struct gpio_device public in the driver.h
header.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib.c      | 24 ++++++++++++++++++++++++
 drivers/gpio/gpiolib.h      | 10 ----------
 include/linux/gpio/driver.h |  3 +++
 3 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index edffa0d2acaa..f84ad54d8dbd 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1058,6 +1058,30 @@ static struct gpio_chip *find_chip_by_name(const char *name)
 	return gpiochip_find((void *)name, gpiochip_match_name);
 }
 
+/**
+ * gpio_device_get() - Increase the reference count of this GPIO device
+ * @gdev: GPIO device to increase the refcount for
+ *
+ * Returns:
+ * Pointer to @gdev.
+ */
+struct gpio_device *gpio_device_get(struct gpio_device *gdev)
+{
+	return to_gpio_device(get_device(&gdev->dev));
+}
+EXPORT_SYMBOL_GPL(gpio_device_get);
+
+/**
+ * gpio_device_put() - Decrease the reference count of this GPIO device and
+ *                     possibly free all resources associated with it.
+ * @gdev: GPIO device to decrease the reference count for
+ */
+void gpio_device_put(struct gpio_device *gdev)
+{
+	put_device(&gdev->dev);
+}
+EXPORT_SYMBOL_GPL(gpio_device_put);
+
 #ifdef CONFIG_GPIOLIB_IRQCHIP
 
 /*
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 9bff5c2cf720..3ccacf3c1288 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -86,16 +86,6 @@ static inline struct gpio_device *to_gpio_device(struct device *dev)
 	return container_of(dev, struct gpio_device, dev);
 }
 
-static inline struct gpio_device *gpio_device_get(struct gpio_device *gdev)
-{
-	return to_gpio_device(get_device(&gdev->dev));
-}
-
-static inline void gpio_device_put(struct gpio_device *gdev)
-{
-	put_device(&gdev->dev);
-}
-
 /* gpio suffixes used for ACPI and device tree lookup */
 static __maybe_unused const char * const gpio_suffixes[] = { "gpios", "gpio" };
 
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 8f0859ba7065..a2060dc3344b 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -606,6 +606,9 @@ int devm_gpiochip_add_data_with_key(struct device *dev, struct gpio_chip *gc,
 struct gpio_chip *gpiochip_find(void *data,
 				int (*match)(struct gpio_chip *gc, void *data));
 
+struct gpio_device *gpio_device_get(struct gpio_device *gdev);
+void gpio_device_put(struct gpio_device *gdev);
+
 bool gpiochip_line_is_irq(struct gpio_chip *gc, unsigned int offset);
 int gpiochip_reqres_irq(struct gpio_chip *gc, unsigned int offset);
 void gpiochip_relres_irq(struct gpio_chip *gc, unsigned int offset);
-- 
2.39.2

