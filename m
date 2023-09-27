Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957657B06CD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 16:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjI0O3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 10:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjI0O3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:29:42 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE22180
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 07:29:40 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-307d58b3efbso9564626f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 07:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695824979; x=1696429779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTcEgfPoq9MntpjrBDVs2nRvtCmOFJGrOAf8mTlZ6ic=;
        b=yMGNr1kd3hLtrwjjnHhdG5D7rrhYIkgDkk4BxMJ6QcP26LpenmcAAuDPnHf2x5ArVt
         EgoK3A847GtHVbvzEw6m7lGUfHRpOEIlkETZaMT+0uBkyCCc4cyRTx91CSDrdjS6dx7b
         VlMWCtmFop9dmPdfsGynvahT/rsGD39zjTGZG7j1M8Fvb/t7eVpGu2Ni5rRpS5ixnY+X
         WhqaNKJgs/c145/0CyW2xlyasxa8FgO3ISVEs8QG8/OwNGCUU4xeLtMiM4Pzo2mG5FKp
         TXYoUbHI/YlQ9AGP8ed46DMSFpQzaXCONn4HUeRWYpoMXkQJ9LXrJNn97R0Q0r+K3i++
         tpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695824979; x=1696429779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTcEgfPoq9MntpjrBDVs2nRvtCmOFJGrOAf8mTlZ6ic=;
        b=QD8g5xtOM4kqcWSKfo44WQ4W/mhWFG4juOEydK21eHBLW+i7wOdPcTY7jgTrQEh298
         WejTTaxiQDO/3NpnjfIwphC1BEAqdhN3f8TR+SecsG6mPQJERp3JY4QoBzIhEISlwg0A
         dsCdo5aW84urrnFZJZPcGMIV7xMh/R5Feqnp2yECFg1ImdOE6p/zBX5aDKJJEidT8uE+
         paoaTr0PccrGHhwQJLwAjgM4ZXg4OV2sNEKxvhG9zpQdt3ZFpqHZ7ceZNZwVAwAiBWfM
         JDGjCje1AiohU36O6pwl1dq6M2QOm5lAalDiT4sZHlX0rGWj3CmqER0SSGnJI3xVK34T
         SVTw==
X-Gm-Message-State: AOJu0YyCbtXeicnocwfDTpidCr5ERMxOg/ThFlwFYEaPYjSAWsI5En3u
        55+nDCgeru1vKRKPkLJ6zm3ivw==
X-Google-Smtp-Source: AGHT+IGD00aBYBGbXwpAnwYAy0l31qfM0fAkxtSPt2jFAgPU61yc4YyTZH8mLIyu6+7WPpclnEKlJg==
X-Received: by 2002:a5d:5582:0:b0:31a:ddf0:93b with SMTP id i2-20020a5d5582000000b0031addf0093bmr1944891wrv.33.1695824978901;
        Wed, 27 Sep 2023 07:29:38 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4bb6:1525:9e22:4a15])
        by smtp.gmail.com with ESMTPSA id v2-20020a1cf702000000b003feae747ff2sm20448303wmh.35.2023.09.27.07.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 07:29:38 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 04/11] gpiolib: provide gpio_device_find_by_label()
Date:   Wed, 27 Sep 2023 16:29:24 +0200
Message-Id: <20230927142931.19798-5-brgl@bgdev.pl>
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

By far the most common way of looking up GPIO devices is using their
label. Provide a helpers for that to avoid every user implementing their
own matching function.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib.c      | 21 +++++++++++++++++++++
 include/linux/gpio/driver.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 0371d23f0a46..9f20311e4c1a 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -20,6 +20,7 @@
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/string.h>
 
 #include <linux/gpio.h>
 #include <linux/gpio/driver.h>
@@ -1081,6 +1082,26 @@ struct gpio_device *gpio_device_find(void *data,
 }
 EXPORT_SYMBOL_GPL(gpio_device_find);
 
+static int gpio_chip_match_by_label(struct gpio_chip *gc, void *label)
+{
+	return gc->label && !strcmp(gc->label, label);
+}
+
+/**
+ * gpio_device_find_by_label() - wrapper around gpio_device_find() finding the
+ *                               GPIO device by its backing chip's label
+ * @label: Label to lookup
+ *
+ * Returns:
+ * Reference to the GPIO device or NULL. Reference must be released with
+ * gpio_device_put().
+ */
+struct gpio_device *gpio_device_find_by_label(const char *label)
+{
+	return gpio_device_find((void *)label, gpio_chip_match_by_label);
+}
+EXPORT_SYMBOL_GPL(gpio_device_find_by_label);
+
 static int gpiochip_match_name(struct gpio_chip *gc, void *data)
 {
 	const char *name = data;
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 6ad1f1a8ef2e..24996cba6465 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -610,6 +610,7 @@ struct gpio_chip *gpiochip_find(void *data,
 
 struct gpio_device *gpio_device_find(void *data,
 				int (*match)(struct gpio_chip *gc, void *data));
+struct gpio_device *gpio_device_find_by_label(const char *label);
 
 struct gpio_device *gpio_device_get(struct gpio_device *gdev);
 void gpio_device_put(struct gpio_device *gdev);
-- 
2.39.2

