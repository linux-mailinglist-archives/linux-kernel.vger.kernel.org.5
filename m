Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD6F792E6D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 21:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241830AbjIETK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 15:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241849AbjIETK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 15:10:56 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0709CFE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 12:10:29 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-5008d16cc36so4818412e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 12:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693940967; x=1694545767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2GE4FHHqs6bBZBv794WL9eWtt6b/gcHhoE6C2vLyfs=;
        b=SF2LBPt+91NzfPcbLEokW4iozFCnnP8x1sSgqNf1ZauU8+jsBq5m+O9k3ECU00gmLF
         LLyXBipLpUbOoXfwyCVBw6ZfDbaT2lKURsY7PJ4hsIKaNGOtG6QPeFtseztfeRm7ECy7
         MIrCF7ixQ2sNmm7rcpYq11EXC+o9Jk8MkQojs4mcZwEzTh/MapUivponm3dP2vofkfMV
         AsIKNel99hmyrNqS9HqBZ8w8T+r9WiHT+fiBjUbcgDUlRDvQc/L8PZjhHCL1zp7uisdr
         GHgMbjSehcqiD8d0aU131a8D3jrIUAdJE31Caqr4gjwvbXqAJwHMmO+K+dmeMGHyvVNA
         qDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693940967; x=1694545767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2GE4FHHqs6bBZBv794WL9eWtt6b/gcHhoE6C2vLyfs=;
        b=MMEIfeH3+fcOmnBVy+rHiAQ3kv4lglAfE/V4vHS2QMuFvKJ2gEyd/nF44RNU3wGTu2
         aL0n0GdtEWKQoO/L+iJgbFfLvaB5JKiNM3O9PkPmf/4sR2hMp2ijFoJkdwGhOLl5a12U
         /9Zrw2MxpNDiFTo1abLmd1GympAc+MSqgndjCwBgDH6ZYTb3cTD5uVdY59TrcWQZgCCY
         WYJ/c8O76moqnB4iUI2zK2FciLmfaZtKc0ps88eRNNEt5ejaUyRxJ23nzj3NNeqlqhSW
         YTZJIbZEvITLKVxY55x1xhubomZs/0LfYb6j9938JvUhW9Bb6WCv9KgTn3EHh+Yf43+x
         KYuw==
X-Gm-Message-State: AOJu0Yx49xrseIHZwInodOvCqOUCgrZOZUio3yQLXt4z9gYCYVypmmJx
        3E9ha9wmMKcKOBsLoKSZXN2n9F/LKgGxEwfMwLs=
X-Google-Smtp-Source: AGHT+IEMv51XL5FvHHG3cRgXKYfBtpCzIaG0xueCnriuyRygrFNOOQC3x8IGQeLMqwqbAjFRM5ODiw==
X-Received: by 2002:adf:ce8c:0:b0:31c:762b:ceb3 with SMTP id r12-20020adfce8c000000b0031c762bceb3mr489509wrn.48.1693940007276;
        Tue, 05 Sep 2023 11:53:27 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7a54:5dbc:6d09:48b7])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c249100b003fbc30825fbsm17550010wms.39.2023.09.05.11.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 11:53:26 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 01/21] gpiolib: make gpio_device_get() and gpio_device_put() public
Date:   Tue,  5 Sep 2023 20:52:49 +0200
Message-Id: <20230905185309.131295-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230905185309.131295-1-brgl@bgdev.pl>
References: <20230905185309.131295-1-brgl@bgdev.pl>
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

