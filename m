Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B56F7C54B2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346586AbjJKNCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234884AbjJKNCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:02:18 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1EDB0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:02:15 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-325e9cd483eso6449406f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697029334; x=1697634134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOhmKBxnjPWo6ddzFX5PM60asyFhIGEHrRKZVC90wiM=;
        b=gHlFgqI3ABxAxpZZcg/h8K2970YKKRpIJbmBqDjj8m6GmthEHqePRB8SyiV3V4Jdvt
         BLiUpOX8y5u543L5X2pQTz3q0ze3DZR/sHttB3nzHOT5ZSKLIpNSkfN2ts+gU8ZcxU12
         Zt7OP2RiYo1UbuMyvJY5nVjeL1jGdLcHYtyG1a5I/GKUUon9yGZd/j9kNwhDmuZfX05K
         kmJHfcx9NiO331BgKqund/NaA2q7KxEGaPGPSjctLjOuhXSaxba6NyuVDo4TgQ5lsamQ
         POPUvBcvrccg4xRlrGU2AsaPN72QU8Xr2NYVQla52TjHncGRNMwc25nKEeKtPYDkU+Zc
         sUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697029334; x=1697634134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOhmKBxnjPWo6ddzFX5PM60asyFhIGEHrRKZVC90wiM=;
        b=W8GJXQma5zYvZ9Emk8a1E8V0YU6VqLXKN+L/WIki0+P55Ckg3ATvvhtbWOrZOg9klV
         dLVQ0fqhoTNrLNLevXSySBSWz5mHB5nLtE9N9msgoNgLTDaGrhKA6vHHg/FPThVCiAyN
         x9WKKgQdB90zM9ZXXlO3o/RJHptbjLZrcrbvitzwHFRJUkiF07C/zBO5K+fcCMJdZHth
         jQNVctnQ5KbCqP4IFVxHNl1T8NmB2A0v9BSEmsClcLKgkiTnWiH5+W0ZnxPUIhSEe47Z
         lzpuItWIzYcHqyzKMSgREr7cO3JEWQPG5bGj4+dK+WGeIpugxqAVNREoR7xbTkKczJYd
         ZL4w==
X-Gm-Message-State: AOJu0YyF0kJPrpoRHQ1YxFToU/Mu5Lf5FG/JSYRIeNTm3LgATVsD49yk
        slJhgVUnZMlc10voOJ+PZHPtCg==
X-Google-Smtp-Source: AGHT+IG1ury2Xk2zMZ3J3z9yMYpHMD/S3uprCdExUEscuR0frxJAWI6bhpv+Tb8sn704HMfhO27rNQ==
X-Received: by 2002:a5d:4c50:0:b0:31f:dc60:13b5 with SMTP id n16-20020a5d4c50000000b0031fdc6013b5mr18364953wrt.25.1697029333084;
        Wed, 11 Oct 2023 06:02:13 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e551:3946:26fc:f94])
        by smtp.gmail.com with ESMTPSA id s13-20020adfeccd000000b003198a9d758dsm15455375wro.78.2023.10.11.06.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 06:02:12 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 3/3] i2c: mux: gpio: don't fiddle with GPIOLIB internals
Date:   Wed, 11 Oct 2023 15:02:04 +0200
Message-Id: <20231011130204.52265-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011130204.52265-1-brgl@bgdev.pl>
References: <20231011130204.52265-1-brgl@bgdev.pl>
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

Use the relevant API functions to retrieve the address of the
underlying struct device instead of accessing GPIOLIB private structures
manually.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/i2c/muxes/i2c-mux-gpio.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index 5d5cbe0130cd..48a872a8196b 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -14,8 +14,7 @@
 #include <linux/slab.h>
 #include <linux/bits.h>
 #include <linux/gpio/consumer.h>
-/* FIXME: stop poking around inside gpiolib */
-#include "../../gpio/gpiolib.h"
+#include <linux/gpio/driver.h>
 
 struct gpiomux {
 	struct i2c_mux_gpio_platform_data data;
@@ -176,7 +175,8 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 	}
 
 	for (i = 0; i < ngpios; i++) {
-		struct device *gpio_dev;
+		struct gpio_device *gdev;
+		struct device *dev;
 		struct gpio_desc *gpiod;
 		enum gpiod_flags flag;
 
@@ -195,9 +195,9 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 		if (!muxc->mux_locked)
 			continue;
 
-		/* FIXME: find a proper way to access the GPIO device */
-		gpio_dev = &gpiod->gdev->dev;
-		muxc->mux_locked = i2c_root_adapter(gpio_dev) == root;
+		gdev = gpiod_to_gpio_device(gpiod);
+		dev = gpio_device_to_device(gdev);
+		muxc->mux_locked = i2c_root_adapter(dev) == root;
 	}
 
 	if (muxc->mux_locked)
-- 
2.39.2

