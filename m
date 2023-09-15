Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CE57A21D5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 17:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbjIOPD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 11:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235812AbjIOPDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:03:43 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DBA2710
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 08:03:37 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-401b5516104so24345365e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 08:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694790216; x=1695395016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mbb2H4Qaojfy2/yoEXeeCLJJ5JJqMUu7q1KHHOeyZs=;
        b=ovMx446miCN6Bwk7LD/i2LL5q2bLysDLpQ+dTbG+IKl1TjuOCpLSFEiyS/Oae5NSXD
         3UY8l5dAZvXNCjJJ0PUH/KvaKJhhOrSbjyb/9jRhNH2ZfsXi4ET6RlyyaXYqT7+dSCSJ
         GP6ZQOcLvwxpBxDgrhxdFwGXEXXb29pCIEBEtyFYWPPpohjq7CKxkztLjp/4f7UmIaP0
         pt7YTcoMmtqXNqdA2K/FQQJTshDpjiyO3yVMrnPQ7uwnJjRljcGCSAhD6BTnawkrpbid
         B8e6IIuDpnJy22c7WCi8KwppYXhhXjjokmswfOpuXzCi668Azc61ZlrzjQcJEe/7A+EP
         U5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694790216; x=1695395016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mbb2H4Qaojfy2/yoEXeeCLJJ5JJqMUu7q1KHHOeyZs=;
        b=ptH3+akgcdaZv0KuIdmZBdXdPleI/fo8VVwyfC+19S6OGqJHIqMlDOyFoS8JHyARHs
         LIgW+GGjkqs7G06uxbzq6umjUAjLdWos3BwBObshDQ3F9sQF5H4+iqcIQzo1Y5SEnLWY
         MuTVjJRogkxxL+y9oOsvZdzib+9bN0qRQo1xFANPyn2+XfA1Hw+HixE0uhNLcNwpIbHi
         rKTe0pE+RLA5XKPnRO5mpPH+tR5qxKzLeB/Kz+9ZFXu6+Y0vbq/rsYuKmjHVtWSBba54
         mm5AkhqRf1KOJ9bB0f+3S8S6TrZclyZNLmATOMhovF8hLMIiQGlDsJrJK5ac+fbMVyuc
         0XQQ==
X-Gm-Message-State: AOJu0Yw8H2LdjDJIxTqLmgusE1Jyu2cUrOkylx+kYbVfMuQCZ3f9rkOf
        Hg8Ol3errcME5pdG/j2M09rMqA==
X-Google-Smtp-Source: AGHT+IE7w7rvkAqt9LsFb5VoS3s1ONi46Bhgi4weHSWjB07Xjn7CSLlj1ODMfCRa6uss3s6EJUrvBQ==
X-Received: by 2002:a05:600c:2311:b0:402:e68f:888a with SMTP id 17-20020a05600c231100b00402e68f888amr2189966wmo.3.1694790215910;
        Fri, 15 Sep 2023 08:03:35 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:aa19:4569:aeeb:c0d3])
        by smtp.gmail.com with ESMTPSA id hn40-20020a05600ca3a800b003fef19bb55csm4853369wmb.34.2023.09.15.08.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 08:03:35 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 05/11] gpiolib: provide gpio_device_get_desc()
Date:   Fri, 15 Sep 2023 17:03:20 +0200
Message-Id: <20230915150327.81918-6-brgl@bgdev.pl>
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

Getting the GPIO descriptor directly from the gpio_chip struct is
dangerous as we don't take the reference to the underlying GPIO device.
In order to start working towards removing gpiochip_get_desc(), let's
provide a safer variant that works with an existing reference to struct
gpio_device.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib.c      | 46 +++++++++++++++++++++++++++----------
 include/linux/gpio/driver.h |  2 ++
 2 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 9f20311e4c1a..7d2574b3dbe5 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -147,27 +147,49 @@ struct gpio_desc *gpio_to_desc(unsigned gpio)
 }
 EXPORT_SYMBOL_GPL(gpio_to_desc);
 
-/**
- * gpiochip_get_desc - get the GPIO descriptor corresponding to the given
- *                     hardware number for this chip
- * @gc: GPIO chip
- * @hwnum: hardware number of the GPIO for this chip
- *
- * Returns:
- * A pointer to the GPIO descriptor or ``ERR_PTR(-EINVAL)`` if no GPIO exists
- * in the given chip for the specified hardware number.
- */
+/* This function is deprecated and will be removed soon, don't use. */
 struct gpio_desc *gpiochip_get_desc(struct gpio_chip *gc,
 				    unsigned int hwnum)
 {
-	struct gpio_device *gdev = gc->gpiodev;
+	return gpio_device_get_desc(gc->gpiodev, hwnum);
+}
+EXPORT_SYMBOL_GPL(gpiochip_get_desc);
+
+/**
+ * gpio_device_get_desc() - get the GPIO descriptor corresponding to the given
+ *                          hardware number for this GPIO device
+ * @gdev: GPIO device to get the descriptor from
+ * @hwnum: hardware number of the GPIO for this chip
+ *
+ * Returns:
+ * A pointer to the GPIO descriptor or %EINVAL if no GPIO exists in the given
+ * chip for the specified hardware number or %ENODEV if the underlying chip
+ * already vanished.
+ *
+ * The reference count of struct gpio_device is *NOT* increased like when the
+ * GPIO is being requested for exclusive usage. It's up to the caller to make
+ * sure the GPIO device will stay alive together with the descriptor returned
+ * by this function.
+ */
+struct gpio_desc *
+gpio_device_get_desc(struct gpio_device *gdev, unsigned int hwnum)
+{
+	struct gpio_chip *gc;
+
+	/*
+	 * FIXME: This will be locked once we protect gdev->chip everywhere
+	 * with SRCU.
+	 */
+	gc = gdev->chip;
+	if (!gc)
+		return ERR_PTR(-ENODEV);
 
 	if (hwnum >= gdev->ngpio)
 		return ERR_PTR(-EINVAL);
 
 	return &gdev->descs[hwnum];
 }
-EXPORT_SYMBOL_GPL(gpiochip_get_desc);
+EXPORT_SYMBOL_GPL(gpio_device_get_desc);
 
 /**
  * desc_to_gpio - convert a GPIO descriptor to the integer namespace
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 24996cba6465..3fdf3f14bb13 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -770,6 +770,8 @@ struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *gc,
 void gpiochip_free_own_desc(struct gpio_desc *desc);
 
 struct gpio_desc *gpiochip_get_desc(struct gpio_chip *gc, unsigned int hwnum);
+struct gpio_desc *
+gpio_device_get_desc(struct gpio_device *gdev, unsigned int hwnum);
 
 #ifdef CONFIG_GPIOLIB
 
-- 
2.39.2

