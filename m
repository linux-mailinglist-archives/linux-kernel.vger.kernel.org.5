Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8AD7CC2F8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbjJQMVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbjJQMUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:20:53 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493EF269E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:45 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c51388ccebso38607761fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697544344; x=1698149144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o1iLMtevXqv9Kk30l8xkOyL7j4m4nBnZ6GmTsolOeXI=;
        b=O97EudNVovcb0qpaj6WbMdhCSA2OhxBf31LcRXLw95bnn6b2/b/PqyGGXTSZAkCiVK
         DuqWwWt//1a1beR0XKEMbo3kkI6FNJOrqV0LUWRU/v9rtvtb0dsDo8QCM1aHVmpEZMHf
         zNPId+qTRkQOKb4Mh442kdD3LslFrk+18ou/fpkjfIUqBju3XG3V0gPf917RfBaZLOZJ
         oNLR4AD14I8VRTAhmWmgBFa0NANtrCeJlQ6VFxKhJfV+f2ZqvYCf6xLTEjYwP/AkA0qM
         yWUIl1QTtK9uR5kIig7o4zjd8uD7XM1nkXMKTn0UUz3LJP0P96jzJ2sbSxFdSr4lCI/o
         toMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697544344; x=1698149144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o1iLMtevXqv9Kk30l8xkOyL7j4m4nBnZ6GmTsolOeXI=;
        b=a0Wyj1KAKTJh879IjFVI/xJWsMGsjpuHd+2VlSLDBQ+ZNiL7v/v9PNbkBkNPhYeYWU
         GqssKRZJ1S6GnfoLg6YuAzVhvYrltHFKUn5hrZxwQYO43mZ9f7Ko812zvgDRpGePE50/
         rxj5XslLjpT1yDlekrBs4tTiIDHzdKFqHop8R9F6rnLStVPdSXiBC9VdXAKjfvjltc/4
         AQViq9C2Fx2xYBdrRjP2Ms2rVYE3meH7p6i8qmcIQUUSXKmdhU/9zFiVsfSdzeNj8AD8
         qf3A6FwfYJyPX7aJL0BxxWK3HfrAYVJCMxLlOYcM8Goaoh6uBH+RiUnxmAnoBIzVzG4d
         n8bw==
X-Gm-Message-State: AOJu0YypyWA0qKGyYMdG1stA4Es0P3TNxbPhfj7qDOc2/HNk5/Mpq10Y
        EgR2rEOIyvw9KiGX/Bjhoq3Rqg==
X-Google-Smtp-Source: AGHT+IGIhyvVVbD8TxHXLHtevk8gNVe0Lr5ecjDDfhwX8W5M+5ZF9ZmG97gs+TOH9v37zALtgq7KMg==
X-Received: by 2002:a2e:8ec5:0:b0:2c5:19ea:b6ac with SMTP id e5-20020a2e8ec5000000b002c519eab6acmr1587986ljl.21.1697544343973;
        Tue, 17 Oct 2023 05:05:43 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b00405442edc69sm1353859wmm.14.2023.10.17.05.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:05:43 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 57/73] pinctrl: ingenic: drop the wrapper around pinctrl_gpio_direction_input()
Date:   Tue, 17 Oct 2023 14:04:15 +0200
Message-Id: <20231017120431.68847-58-brgl@bgdev.pl>
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

pinctrl_gpio_direction_input() now has the same signature as the
wrapper around it so we can drop them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/pinctrl-ingenic.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index ca58c9db5c2c..ee718f6e2556 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -3560,12 +3560,6 @@ static int ingenic_gpio_get(struct gpio_chip *gc, unsigned int offset)
 	return (int) ingenic_gpio_get_value(jzgc, offset);
 }
 
-static int ingenic_gpio_direction_input(struct gpio_chip *gc,
-		unsigned int offset)
-{
-	return pinctrl_gpio_direction_input(gc, offset);
-}
-
 static int ingenic_gpio_direction_output(struct gpio_chip *gc,
 		unsigned int offset, int value)
 {
@@ -3680,7 +3674,7 @@ static int ingenic_gpio_irq_request(struct irq_data *data)
 	irq_hw_number_t irq = irqd_to_hwirq(data);
 	int ret;
 
-	ret = ingenic_gpio_direction_input(gpio_chip, irq);
+	ret = pinctrl_gpio_direction_input(gpio_chip, irq);
 	if (ret)
 		return ret;
 
@@ -4197,7 +4191,7 @@ static int __init ingenic_gpio_probe(struct ingenic_pinctrl *jzpc,
 
 	jzgc->gc.set = ingenic_gpio_set;
 	jzgc->gc.get = ingenic_gpio_get;
-	jzgc->gc.direction_input = ingenic_gpio_direction_input;
+	jzgc->gc.direction_input = pinctrl_gpio_direction_input;
 	jzgc->gc.direction_output = ingenic_gpio_direction_output;
 	jzgc->gc.get_direction = ingenic_gpio_get_direction;
 	jzgc->gc.request = gpiochip_generic_request;
-- 
2.39.2

