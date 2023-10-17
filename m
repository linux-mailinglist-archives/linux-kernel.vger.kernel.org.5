Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0C87CC2EB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbjJQMUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343855AbjJQMTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:19:50 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05932273E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:55 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4065dea9a33so52642165e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697544354; x=1698149154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUbVE7EnprLRCHg/IupG2aGO0MyUMAidx/+KUyiUqH8=;
        b=xMHDUv+fjSV9unbVsPuGNBL2e45kTOBSZiuAjMqcrWJYowvnPGFlSg9jjnYKdd0/Gq
         hEoHm25h+IMnYyeVLTMY2VNGh5T5LHE6+gsSaxs+evFxDalnzNidLQ0dh51Wfrj7RXNa
         vga4dqFozH9kcl+tjLicTtwTdDIiNrEshslikUnT3LILLfxgqRdBVrvbW5FmSujQx2Op
         3HjbiyhwnOfME1RqGbYIaeNa0jA3HOCxbXjb7vmOZItslVWkry48zeHDeymCBGdPhVeF
         a8OAszY6mxRrtMKLERK5rC+yffuzGbTIagvH5N4AxKo2zHnJqQtlZ1qev8IqSQy02KcH
         840g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697544354; x=1698149154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUbVE7EnprLRCHg/IupG2aGO0MyUMAidx/+KUyiUqH8=;
        b=lMk2TviH4uyjy0ZA7OdWAmVQoij3VTB1ksVGD54tCvb44iEDDiYkR/FewbZTiKFfz7
         CH2BbfhhB+76Df3QIiTg+qaC3X18ry0Ny0p+38yGfc5E3ICOggEGQQcOjXJSkxkkAokA
         f2iNuXHIFfgEiWuwaTvH/e9trMUJgFdQcwopIoYLMFPYjovCwPEEu9Eomy46kCQoD6sc
         0oZ1kapkScx5YewIt/jZRY4p3jnKCFuB8rrU9lAqM22sGD2QHcOyVtV7mFEC9UM5K48f
         1ZDakIeoRupqGxQYNfqTGL12NkSburP9Kj5HF2nitUS3jO8ove1Lzhl9rzSoPc6xmhjW
         PCLg==
X-Gm-Message-State: AOJu0YwH/MAR3IFqYbEPAHu+osAeNeLexEHayvHpyElEhuI2XEYNO+Jw
        5hspnifSvVTv6xF0ze4j20K/sA==
X-Google-Smtp-Source: AGHT+IEQJmajdRG259Azur9kK4aLJz58vsY+Ji8pyKRpIU01MvG8yUxaV5SJfIXAnU492LUJVpBCYQ==
X-Received: by 2002:a05:600c:1550:b0:405:4f78:e128 with SMTP id f16-20020a05600c155000b004054f78e128mr1627510wmg.4.1697544353982;
        Tue, 17 Oct 2023 05:05:53 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b00405442edc69sm1353859wmm.14.2023.10.17.05.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:05:53 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 69/73] pinctrl: stm32: drop wrappers around pinctrl_gpio_free/input()
Date:   Tue, 17 Oct 2023 14:04:27 +0200
Message-Id: <20231017120431.68847-70-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017120431.68847-1-brgl@bgdev.pl>
References: <20231017120431.68847-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

pinctrl_gpio_*() helpers now have signatures corresponding with those of
the GPIOLIB callbacks. We can drop the wrappers.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/stm32/pinctrl-stm32.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index 917b87acbf0d..64e8201c7eac 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -220,11 +220,6 @@ static int stm32_gpio_request(struct gpio_chip *chip, unsigned offset)
 	return pinctrl_gpio_request(chip, offset);
 }
 
-static void stm32_gpio_free(struct gpio_chip *chip, unsigned offset)
-{
-	pinctrl_gpio_free(chip, offset);
-}
-
 static int stm32_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
 	struct stm32_gpio_bank *bank = gpiochip_get_data(chip);
@@ -239,11 +234,6 @@ static void stm32_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 	__stm32_gpio_set(bank, offset, value);
 }
 
-static int stm32_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
-{
-	return pinctrl_gpio_direction_input(chip, offset);
-}
-
 static int stm32_gpio_direction_output(struct gpio_chip *chip,
 	unsigned offset, int value)
 {
@@ -316,10 +306,10 @@ static int stm32_gpio_init_valid_mask(struct gpio_chip *chip,
 
 static const struct gpio_chip stm32_gpio_template = {
 	.request		= stm32_gpio_request,
-	.free			= stm32_gpio_free,
+	.free			= pinctrl_gpio_free,
 	.get			= stm32_gpio_get,
 	.set			= stm32_gpio_set,
-	.direction_input	= stm32_gpio_direction_input,
+	.direction_input	= pinctrl_gpio_direction_input,
 	.direction_output	= stm32_gpio_direction_output,
 	.to_irq			= stm32_gpio_to_irq,
 	.get_direction		= stm32_gpio_get_direction,
@@ -381,7 +371,7 @@ static int stm32_gpio_irq_request_resources(struct irq_data *irq_data)
 	struct stm32_pinctrl *pctl = dev_get_drvdata(bank->gpio_chip.parent);
 	int ret;
 
-	ret = stm32_gpio_direction_input(&bank->gpio_chip, irq_data->hwirq);
+	ret = pinctrl_gpio_direction_input(&bank->gpio_chip, irq_data->hwirq);
 	if (ret)
 		return ret;
 
-- 
2.39.2

