Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA69791245
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242505AbjIDHeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjIDHeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:34:21 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BE1C7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:34:17 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bcc187e0b5so15744061fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 00:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693812856; x=1694417656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wt0Mmwz9w2PonkCnZSyYcOE7CQFgIX3d0lq7tuXYcFA=;
        b=DUwzWJhDk0pQLEBu1HxyEQTkMZwHbeqZg2I0QhunIUayyp9mklXF044JdBLVBPDWFS
         gBL/NGEMjfYL4LLg5Z322ytf7JPyifa6t8dgo8QCH75OglMzcQU5xdC91GYDNnl1d97y
         UVNN4cXQwk4VBjYKFtCPa6Wg3eCZTQmYLtO4XlpLZ34Ch/yInGedDDrnNGsdk7AV7+/+
         kum/Obh1TTH5kPBMVG8PD1jpkbydm5ubuYb0A/rZ3mgXYaen5kxSAmLkA/MDybmClQFz
         8OQta1e1w6e3wIMrR9JgiSTFzQQwFQFuPnuwq6uBx1yQxixNeOqzHTeC32R+XL5ByHCh
         rlkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693812856; x=1694417656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wt0Mmwz9w2PonkCnZSyYcOE7CQFgIX3d0lq7tuXYcFA=;
        b=bgL4ILzOKb9OzH/4J9ZKSuRH+RHLCT31VbVSt/PoyASVUv/b/TrQUXxkECpA6dMLoy
         b90CrO2q2V+kdktMkupZO4+ZuHfv1qX0AFcwindwx4lLOQvbOkOAe07LkLrclQGVR/4K
         bYUbCy9ru2x4ozIjCZP3Uyt+V3iZogL+maCqSRZnJ1PzzzJRzhUYNYPFy4f4FksQSFrb
         fqgcqKKoNaZAMoU7I3Vava7HVh9Su2dnR0r3W3Zx89xrp80+G4yzFr8P2i7eVuphLoB7
         iCpH2C9s9EiowJY5oDRctNiBIB7Koh7sV1KkX5Q76WoYDWumiDDd46OfwNG65BxuS7ZP
         xMJQ==
X-Gm-Message-State: AOJu0YwBEiXcJIL4nR9M+gkPwZdEcTe/XDsMXfRIDG+Xc/aiw7MrTCpg
        uzardasm7oyvdg6qcwN9HkICpg==
X-Google-Smtp-Source: AGHT+IE76IlVjrmCcuzbvddoZuP/7IrnWV6CjE0yh2OMoUlGlTUBHsyRYxM3MLs/lzfLfFqsUc7WQw==
X-Received: by 2002:a2e:9788:0:b0:2bc:e51e:b007 with SMTP id y8-20020a2e9788000000b002bce51eb007mr6380274lji.41.1693812856018;
        Mon, 04 Sep 2023 00:34:16 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7663:60b7:3a19:b5c4])
        by smtp.gmail.com with ESMTPSA id fj15-20020a05600c0c8f00b003fe2bea77ccsm13492733wmb.5.2023.09.04.00.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 00:34:15 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/2] gpiolib: rename gpio_set_debounce_timeout() for consistency
Date:   Mon,  4 Sep 2023 09:34:09 +0200
Message-Id: <20230904073410.5880-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
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

All other functions that manipulate a struct gpio_desc use the gpiod_
prefix. Follow this convention and rename gpio_set_debounce_timeout() to
gpiod_set_debounce_timeout().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-acpi.c | 5 +++--
 drivers/gpio/gpiolib.c      | 4 ++--
 drivers/gpio/gpiolib.h      | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index fbda452fb4d6..4a390d8f6544 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -341,7 +341,7 @@ static struct gpio_desc *acpi_request_own_gpiod(struct gpio_chip *chip,
 		return desc;
 
 	/* ACPI uses hundredths of milliseconds units */
-	ret = gpio_set_debounce_timeout(desc, agpio->debounce_timeout * 10);
+	ret = gpiod_set_debounce_timeout(desc, agpio->debounce_timeout * 10);
 	if (ret)
 		dev_warn(chip->parent,
 			 "Failed to set debounce-timeout for pin 0x%04X, err %d\n",
@@ -1087,7 +1087,8 @@ int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *name, in
 				return ret;
 
 			/* ACPI uses hundredths of milliseconds units */
-			ret = gpio_set_debounce_timeout(desc, info.debounce * 10);
+			ret = gpiod_set_debounce_timeout(desc,
+							 info.debounce * 10);
 			if (ret)
 				return ret;
 
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index edffa0d2acaa..6fab0f211e67 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2377,7 +2377,7 @@ static int gpio_set_bias(struct gpio_desc *desc)
 }
 
 /**
- * gpio_set_debounce_timeout() - Set debounce timeout
+ * gpiod_set_debounce_timeout() - Set debounce timeout
  * @desc:	GPIO descriptor to set the debounce timeout
  * @debounce:	Debounce timeout in microseconds
  *
@@ -2386,7 +2386,7 @@ static int gpio_set_bias(struct gpio_desc *desc)
  *
  * Returns 0 on success, or negative error code otherwise.
  */
-int gpio_set_debounce_timeout(struct gpio_desc *desc, unsigned int debounce)
+int gpiod_set_debounce_timeout(struct gpio_desc *desc, unsigned int debounce)
 {
 	return gpio_set_config_with_argument_optional(desc,
 						      PIN_CONFIG_INPUT_DEBOUNCE,
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 9bff5c2cf720..9ea5b88ad304 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -219,7 +219,7 @@ static inline int gpiod_request_user(struct gpio_desc *desc, const char *label)
 
 int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
 		unsigned long lflags, enum gpiod_flags dflags);
-int gpio_set_debounce_timeout(struct gpio_desc *desc, unsigned int debounce);
+int gpiod_set_debounce_timeout(struct gpio_desc *desc, unsigned int debounce);
 int gpiod_hog(struct gpio_desc *desc, const char *name,
 		unsigned long lflags, enum gpiod_flags dflags);
 int gpiochip_get_ngpios(struct gpio_chip *gc, struct device *dev);
-- 
2.39.2

