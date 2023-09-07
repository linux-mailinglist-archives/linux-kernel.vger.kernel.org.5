Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B1379735B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236023AbjIGPXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjIGPWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:22:21 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B651C1BEC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:21:51 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bceb02fd2bso18371211fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 08:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694100110; x=1694704910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ADDhL3Y9ChksGd5FuRK3cdw+MrzNNwwXAMmsBve8eY=;
        b=GEHjmt64A6uG/CyH+6nVq+m0eBpkZrsgRMj5JoyhpLAg4t0EDD0/WyZY/EbvMygZSB
         O6VR1YHCSNdquqfBu9hLzEiPE2+pxFb0nAxtGaEVlFIMlmVY43SgcnNnZVoGehnV83gI
         AzXzf6UVvotJsYMqXiil1VO222EF9pyAhf6AThX8ZFkCOuK7gAMy0rxTLlGGQZ9dLEIC
         u1g0i5CCpb1Cupz1yBWx6WW2fg+epIiMk9kms7nm/yIVdnVey7p4zY+ZRsZeCKutWMHR
         fPxSaPAEqZVsvK5rGXTVxo8yOJYR6SZItFcIK7It9r6cjDsPrD35z+OEn2bK8OP7cICk
         /ufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100110; x=1694704910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ADDhL3Y9ChksGd5FuRK3cdw+MrzNNwwXAMmsBve8eY=;
        b=RC6dJKNWU136bKMLq4srh8qIlOe0FilOMrqgqGlylC5qWpjcdtDL6QpyFVmoCZCv1o
         iz07Edf0FGqdL/Tf6sUdoJEOpjW96HsVTdAJ/TVgsmr0xj2FZNvJSZg67XOfR6YihD6T
         4AqfkDBlS/uIerqrALug8fFNNgUYWHNid0s/aH3+g8TS+T3faqBTJpRg405lDOgSYDd3
         X5DXD6Kk4TJiSWOyiBTx7AITA1gYOidhTgCZJ9+nnmaRmtQLK4ZqrO3hkVBVvVlEk+/L
         MVWuhI/vEtvVmE5Kdz5R7VHk4wya1Mdo5Rwq6a5wieedD08OqD0LVi+2Gt+at5Pdvyby
         D8LQ==
X-Gm-Message-State: AOJu0Yy5MAXitZE5miGHHsJNzBOQwGB50m9sl/gca8v7CFR0qxTU99dQ
        E8+issLkNP1am5VgVg1UuNdaRP7uz8TjbkPATs8=
X-Google-Smtp-Source: AGHT+IGYRLf7GpXbSfX9yL4OLNbiYEdnhHMAnQCxOV6DjnXOpS1Z/JCpHYk+r7prOvveef7RE/lcMg==
X-Received: by 2002:a05:600c:2809:b0:3fe:dcd0:2e10 with SMTP id m9-20020a05600c280900b003fedcd02e10mr5150331wmb.17.1694098355761;
        Thu, 07 Sep 2023 07:52:35 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:56f5:e2d4:1e04:b28e])
        by smtp.gmail.com with ESMTPSA id 2-20020a05600c020200b003feef82bbefsm2757588wmi.29.2023.09.07.07.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 07:52:35 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 4/5] gpio: mockup: simplify code by using cleanup helpers
Date:   Thu,  7 Sep 2023 16:52:29 +0200
Message-Id: <20230907145230.44085-4-brgl@bgdev.pl>
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

Use lock from linux/cleanup.h and simplify locking paths.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-mockup.c | 45 ++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index ff1a263f1b05..44684ff4462f 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -9,6 +9,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/cleanup.h>
 #include <linux/debugfs.h>
 #include <linux/gpio/driver.h>
 #include <linux/interrupt.h>
@@ -92,9 +93,8 @@ static int gpio_mockup_get(struct gpio_chip *gc, unsigned int offset)
 	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
 	int val;
 
-	mutex_lock(&chip->lock);
-	val = __gpio_mockup_get(chip, offset);
-	mutex_unlock(&chip->lock);
+	scoped_guard(mutex, &chip->lock)
+		val = __gpio_mockup_get(chip, offset);
 
 	return val;
 }
@@ -105,12 +105,12 @@ static int gpio_mockup_get_multiple(struct gpio_chip *gc,
 	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
 	unsigned int bit, val;
 
-	mutex_lock(&chip->lock);
-	for_each_set_bit(bit, mask, gc->ngpio) {
-		val = __gpio_mockup_get(chip, bit);
-		__assign_bit(bit, bits, val);
+	scoped_guard(mutex, &chip->lock) {
+		for_each_set_bit(bit, mask, gc->ngpio) {
+			val = __gpio_mockup_get(chip, bit);
+			__assign_bit(bit, bits, val);
+		}
 	}
-	mutex_unlock(&chip->lock);
 
 	return 0;
 }
@@ -126,9 +126,9 @@ static void gpio_mockup_set(struct gpio_chip *gc,
 {
 	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
 
-	mutex_lock(&chip->lock);
+	guard(mutex)(&chip->lock);
+
 	__gpio_mockup_set(chip, offset, value);
-	mutex_unlock(&chip->lock);
 }
 
 static void gpio_mockup_set_multiple(struct gpio_chip *gc,
@@ -137,10 +137,10 @@ static void gpio_mockup_set_multiple(struct gpio_chip *gc,
 	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
 	unsigned int bit;
 
-	mutex_lock(&chip->lock);
+	guard(mutex)(&chip->lock);
+
 	for_each_set_bit(bit, mask, gc->ngpio)
 		__gpio_mockup_set(chip, bit, test_bit(bit, bits));
-	mutex_unlock(&chip->lock);
 }
 
 static int gpio_mockup_apply_pull(struct gpio_mockup_chip *chip,
@@ -150,7 +150,7 @@ static int gpio_mockup_apply_pull(struct gpio_mockup_chip *chip,
 	struct gpio_desc *desc = gpiochip_get_desc(gc, offset);
 	int curr, irq, irq_type, ret = 0;
 
-	mutex_lock(&chip->lock);
+	guard(mutex)(&chip->lock);
 
 	if (test_bit(FLAG_REQUESTED, &desc->flags) &&
 	    !test_bit(FLAG_IS_OUT, &desc->flags)) {
@@ -187,7 +187,6 @@ static int gpio_mockup_apply_pull(struct gpio_mockup_chip *chip,
 
 out:
 	chip->lines[offset].pull = value;
-	mutex_unlock(&chip->lock);
 	return ret;
 }
 
@@ -212,10 +211,10 @@ static int gpio_mockup_dirout(struct gpio_chip *gc,
 {
 	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
 
-	mutex_lock(&chip->lock);
-	chip->lines[offset].dir = GPIO_LINE_DIRECTION_OUT;
-	__gpio_mockup_set(chip, offset, value);
-	mutex_unlock(&chip->lock);
+	scoped_guard(mutex, &chip->lock) {
+		chip->lines[offset].dir = GPIO_LINE_DIRECTION_OUT;
+		__gpio_mockup_set(chip, offset, value);
+	}
 
 	return 0;
 }
@@ -224,9 +223,8 @@ static int gpio_mockup_dirin(struct gpio_chip *gc, unsigned int offset)
 {
 	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
 
-	mutex_lock(&chip->lock);
-	chip->lines[offset].dir = GPIO_LINE_DIRECTION_IN;
-	mutex_unlock(&chip->lock);
+	scoped_guard(mutex, &chip->lock)
+		chip->lines[offset].dir = GPIO_LINE_DIRECTION_IN;
 
 	return 0;
 }
@@ -236,9 +234,8 @@ static int gpio_mockup_get_direction(struct gpio_chip *gc, unsigned int offset)
 	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
 	int direction;
 
-	mutex_lock(&chip->lock);
-	direction = chip->lines[offset].dir;
-	mutex_unlock(&chip->lock);
+	scoped_guard(mutex, &chip->lock)
+		direction = chip->lines[offset].dir;
 
 	return direction;
 }
-- 
2.39.2

