Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A897979E730
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240544AbjIMLu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240528AbjIMLuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:50:24 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7823719AF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:50:20 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40037db2fe7so71829145e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694605819; x=1695210619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzyriHXDyGfsqSRGhB6U9l6fcpz9mRdaLbPmEard1K0=;
        b=wlAimHdr0JCDmOb03eTk5kgHiJqcEUNDbeZJ17Ujyb8Bulg1333oDjT+W/JAqjYg5R
         nAT7fWijaClkmMZOXkVBGTtoluxqI6Z0z7OhNUjguWteV4O2JZCeVrhkz5YKjTyz7iZl
         d0tWbaipDjCQUMogpTM30YSWslaRmlF1S7Xlw7EzgcyXsmValJ9zR/vPu8lb4CAnddEh
         IFK5uFQXqT6ZlZ1wE8PeibMEnIb6wX2KFbNuVnMuEvTkV3454cGKU6kAoKfObFQzlqFx
         cONcCEmSZnvbMzK9tno4pPDzt/8IN91qnFHwixCtechAHiD8MGhlyS+jWXl8kzIv/y7Y
         A3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694605819; x=1695210619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzyriHXDyGfsqSRGhB6U9l6fcpz9mRdaLbPmEard1K0=;
        b=Z9IVsXEkuF1gC8X/bU/kkGBbreRG3V2KpWI5aNnaj75z8Vs7R7z6CJYpnlPQtsExTL
         31oH/OA++HmDInRWHbvZV2DCGxIYcLaotTzvjKjCuE1JewJnL+nImS4EfG0hhuaHZfua
         cEaeconH+DxBXv+DlnuavvYD745XWqZKXPXjF5eLMBgUWQXy5i8bJS3rufpUC5rRqfy7
         xPlNDbG8nscQ7IHPPcqUssec60yorZoYSQB7fSyshze1K1wZchqW3Un5RPtYAya7IRO9
         NvwBC/yg2Vy0B0SqI9KKRL3yO8WCwHDiQUp5tuqrCYIaodE0SvjZJOaz5EOqToJme+RZ
         6mfQ==
X-Gm-Message-State: AOJu0Yxyv7oJq2dsK7mknFQEdpSUSOUsKVW1DBkpE8TToSDqcTl3hz8O
        kuvu3Ix59ioIy7+YQ3izjVAmpw==
X-Google-Smtp-Source: AGHT+IHc3Nnqh7FxXn5j82zlMwGGyFk0UEacPknUOdO1EfjviMuMeXi35mpFtRpdkqCvV2719fQtUA==
X-Received: by 2002:a5d:620a:0:b0:313:f61c:42ab with SMTP id y10-20020a5d620a000000b00313f61c42abmr1731997wru.56.1694605818963;
        Wed, 13 Sep 2023 04:50:18 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:3b50:bca5:a754:7463])
        by smtp.gmail.com with ESMTPSA id j14-20020adfd20e000000b0031fc4c31d77sm1932689wrh.88.2023.09.13.04.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 04:50:18 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Daniel Scally <djrscally@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mtd@lists.infradead.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/5] gpiolib: provide gpiod_set_active_[low/high]()
Date:   Wed, 13 Sep 2023 13:49:57 +0200
Message-Id: <20230913115001.23183-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230913115001.23183-1-brgl@bgdev.pl>
References: <20230913115001.23183-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Out current interface for changing line polarity is quite cumbersome to
use as it only "toggles" the current state instead of deterministically
setting it. Because of that all but one user in the kernel first need
check the current state anyway. Let's provide two new functions that
allow users to set this value explicitly with the aim of removing the
existing function.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c        | 22 ++++++++++++++++++++++
 include/linux/gpio/consumer.h | 14 ++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index edffa0d2acaa..131965814a7c 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2725,6 +2725,28 @@ void gpiod_toggle_active_low(struct gpio_desc *desc)
 }
 EXPORT_SYMBOL_GPL(gpiod_toggle_active_low);
 
+/**
+ * gpiod_set_active_low() - set the GPIO as active-low
+ * @desc: the GPIO descriptor to set the active-low setting for
+ */
+void gpiod_set_active_low(struct gpio_desc *desc)
+{
+	VALIDATE_DESC_VOID(desc);
+	set_bit(FLAG_ACTIVE_LOW, &desc->flags);
+}
+EXPORT_SYMBOL_GPL(gpiod_set_active_low);
+
+/**
+ * gpiod_set_active_high() - set the GPIO as active-high
+ * @desc: the GPIO descriptor to set the active-low setting for
+ */
+void gpiod_set_active_high(struct gpio_desc *desc)
+{
+	VALIDATE_DESC_VOID(desc);
+	clear_bit(FLAG_ACTIVE_LOW, &desc->flags);
+}
+EXPORT_SYMBOL_GPL(gpiod_set_active_high);
+
 static int gpio_chip_get_value(struct gpio_chip *gc, const struct gpio_desc *desc)
 {
 	return gc->get ? gc->get(gc, gpio_chip_hwgpio(desc)) : -EIO;
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 6cc345440a5b..ddbf0d8e4a75 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -160,6 +160,8 @@ int gpiod_set_raw_array_value_cansleep(unsigned int array_size,
 int gpiod_set_config(struct gpio_desc *desc, unsigned long config);
 int gpiod_set_debounce(struct gpio_desc *desc, unsigned int debounce);
 void gpiod_toggle_active_low(struct gpio_desc *desc);
+void gpiod_set_active_low(struct gpio_desc *desc);
+void gpiod_set_active_high(struct gpio_desc *desc);
 
 int gpiod_is_active_low(const struct gpio_desc *desc);
 int gpiod_cansleep(const struct gpio_desc *desc);
@@ -499,6 +501,18 @@ static inline void gpiod_toggle_active_low(struct gpio_desc *desc)
 	WARN_ON(desc);
 }
 
+static inline void gpiod_set_active_low(struct gpio_desc *desc
+{
+	/* GPIO can never have been requested */
+	WARN_ON(desc);
+}
+
+static inline void gpiod_set_active_high(struct gpio_desc *desc)
+{
+	/* GPIO can never have been requested */
+	WARN_ON(desc);
+}
+
 static inline int gpiod_is_active_low(const struct gpio_desc *desc)
 {
 	/* GPIO can never have been requested */
-- 
2.39.2

