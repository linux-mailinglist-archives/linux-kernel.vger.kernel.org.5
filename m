Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A367B06D2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 16:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjI0O3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 10:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjI0O3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:29:43 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70316180
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 07:29:42 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-405361bb9f7so114650845e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 07:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695824981; x=1696429781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7cnFQaXE5hgNGVsFuhD31Dbn34C6HVkTSPK79EhhMo=;
        b=tC786oomOp9enwi6Np8ApnZ28cXmNnrL49M8rxAn6ZaocPCrDJwgmiCuvSNBldGGdR
         /ptSvgYl85A90cuDupuz6zw91SEhvwPLtFfZNO0VwGUtSsseXB1sf+RoaMJ8OF6QxC5h
         apa8qVJVyfq7ZeQhVMZfRU+n6nKo45EC48r+4y0VfEPpH0ooiOiEfHeJe9Gs5UHSwHBD
         TSlsXtoXaiuqHwTHWnzc0Lk5lO9Er+Tm5X6eejMXZiTMhRK0oY6fsmUBv4MoTMZbf1vp
         2fUXBdNtbwEqxrDiuBjRbqzIsOeCu2OPXxdOcN66lf+wZ98CwE2m7jhcEJDWkZ1mYQlI
         ecfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695824981; x=1696429781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7cnFQaXE5hgNGVsFuhD31Dbn34C6HVkTSPK79EhhMo=;
        b=io6nhDmPK05E8xUh/kBd8fNTOGY34oluSjvoE51nwCFVCtHpf5WEg4jAwvuBWHIyUz
         H4BJCmdPYl1QzZhbDv3cdgle87a3yLR0M5zIsa0YGYv8A18qqb8EhBOWWV1aijgAJD8E
         CEbO4h2hV4G/4m0X/vi+cRuCoLYIMwfPXSrwCknMHHUDdrwIbkXd4Igj68h9XS3qpEH+
         xXp3clOESApLU7jHFvanRofX7RDBFrfFMOjHCozOTi9hrgdk1WE2LY0ym5TKmMGwh9k/
         SAex3Ss6js4pmibwx9he8aUx+JQqQIyjL7p7xGf1Q+kc+cE9Ipw+Q+FQHpiaMm0GRrCG
         3qBw==
X-Gm-Message-State: AOJu0YxXndJy2aVXCL/yv07NKSGDuXJpBHGEQA6dR3YSOeajVh6AosPY
        cwEecv0uGkhgJsI9+69WSORVKA==
X-Google-Smtp-Source: AGHT+IHv5NSu6YCJ/7S57e2fsDhaAnO5tbf5QNh9VBd/TY/2Ebo1ZLGBtJSYkkd4Gw0pg4BMxRB0Fg==
X-Received: by 2002:a7b:c8c7:0:b0:405:75f0:fd31 with SMTP id f7-20020a7bc8c7000000b0040575f0fd31mr2054487wml.31.1695824980880;
        Wed, 27 Sep 2023 07:29:40 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4bb6:1525:9e22:4a15])
        by smtp.gmail.com with ESMTPSA id v2-20020a1cf702000000b003feae747ff2sm20448303wmh.35.2023.09.27.07.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 07:29:40 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 06/11] gpiolib: reluctantly provide gpio_device_get_chip()
Date:   Wed, 27 Sep 2023 16:29:26 +0200
Message-Id: <20230927142931.19798-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230927142931.19798-1-brgl@bgdev.pl>
References: <20230927142931.19798-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The process of converting all unauthorized users of struct gpio_chip to
using dedicated struct gpio_device function will be long so in the
meantime we must provide a way of retrieving the pointer to struct
gpio_chip from a GPIO device.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib.c      | 21 +++++++++++++++++++++
 include/linux/gpio/driver.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 7d2574b3dbe5..e26cbd10a246 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -220,6 +220,27 @@ struct gpio_chip *gpiod_to_chip(const struct gpio_desc *desc)
 }
 EXPORT_SYMBOL_GPL(gpiod_to_chip);
 
+/**
+ * gpio_device_get_chip() - Get the gpio_chip implementation of this GPIO device
+ * @gdev: GPIO device
+ *
+ * Returns:
+ * Address of the GPIO chip backing this device.
+ *
+ * Until we can get rid of all non-driver users of struct gpio_chip, we must
+ * provide a way of retrieving the pointer to it from struct gpio_device. This
+ * is *NOT* safe as the GPIO API is considered to be hot-unpluggable and the
+ * chip can dissapear at any moment (unlike reference-counted struct
+ * gpio_device).
+ *
+ * Use at your own risk.
+ */
+struct gpio_chip *gpio_device_get_chip(struct gpio_device *gdev)
+{
+	return gdev->chip;
+}
+EXPORT_SYMBOL_GPL(gpio_device_get_chip);
+
 /* dynamic allocation of GPIOs, e.g. on a hotplugged device */
 static int gpiochip_find_base(int ngpio)
 {
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 3fdf3f14bb13..f8ad7f40100c 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -773,6 +773,8 @@ struct gpio_desc *gpiochip_get_desc(struct gpio_chip *gc, unsigned int hwnum);
 struct gpio_desc *
 gpio_device_get_desc(struct gpio_device *gdev, unsigned int hwnum);
 
+struct gpio_chip *gpio_device_get_chip(struct gpio_device *gdev);
+
 #ifdef CONFIG_GPIOLIB
 
 /* lock/unlock as IRQ */
-- 
2.39.2

