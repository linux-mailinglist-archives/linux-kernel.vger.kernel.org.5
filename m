Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB9D7CC243
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343532AbjJQMFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjJQMFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:05:19 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769FA12A
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:04 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40651a726acso50639765e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697544301; x=1698149101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfWYSE8ThvfQSJQ9/Fq2M/H6j3nV1pBrLUi6/wp2wmg=;
        b=I8/jxjVcGmbzuiyNmyRR5oYWm17jbLEIoWeIUS77KwUk7rdRb7RKMRpTsNGAjz9AhH
         5/oyNEPr+NgglaCqTeEfQRZrOUKaNE4ST30TVYApwl8u4w3CcmBajkshYrJyIMkOaWrK
         Y4pxdyMfjV6LFhKsbKvqW9CHPygu6FxPnz0prljvZ3OMLtN7bLnp6PQz3XVOXp66/u/Z
         Gj+SYqkJoRihDmjdzM5MjwcECuxEDHK3hJgxt71cQSactp1muplsVVp97pzAeRDees4F
         kr98t014kDZ5lHo9LnhLXqhPuyar1Ajt2vE2hmxv0LMAm/LEAFSyLkoEhgJXfnan9CXH
         KRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697544301; x=1698149101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XfWYSE8ThvfQSJQ9/Fq2M/H6j3nV1pBrLUi6/wp2wmg=;
        b=SZLIuYfwQ3/gfo79hS+T0//Msr35a9TBmrn9LtdQEN6h88ly5q0FYn5UUFlwwkh2eU
         X7xdNAmivTZOBnu3XLmcAoeLRbhwrzzwhK4igHekqX1RLyPdStrNt0tCot/1x1hp79+U
         HUC6TYGBn+i+6ldsf+cdXO1jdwafDVI48kvcSvrEHXv7aphykBPLrErpbXPoWKvdG4Ry
         XoRhMf6eXxgqg1mW8VgqvJrYYB7qbZqrqoUN5GwZg5G0E8cDtlockKn/Acjvsb8wI/j8
         bClRpa3ZuE9Ssm0wDWyz5Hn+tEI4nvpfZRAIy7mAopbqgPq9BIVYCqoS4Ij9RvLkY16c
         LB8Q==
X-Gm-Message-State: AOJu0YxHnB4IslHo3HQpi7SSf9I/u8L84WimRHugLBgquvUijXao895i
        WfdjXFG+00AeNlEaKqrPORIOvQ==
X-Google-Smtp-Source: AGHT+IHZg+Ea7NCU4m7eBzeT7ivGJI5rD+ML7hobIKQtqDtCWG5KVKYjI4E9NTJ9Gllb+IOWK+wUSQ==
X-Received: by 2002:a05:600c:4f85:b0:405:3a14:aa1a with SMTP id n5-20020a05600c4f8500b004053a14aa1amr1685911wmq.18.1697544296151;
        Tue, 17 Oct 2023 05:04:56 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b00405442edc69sm1353859wmm.14.2023.10.17.05.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:04:55 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v3 08/73] gpio: aspeed: use new pinctrl GPIO helpers
Date:   Tue, 17 Oct 2023 14:03:26 +0200
Message-Id: <20231017120431.68847-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017120431.68847-1-brgl@bgdev.pl>
References: <20231017120431.68847-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Replace the pinctrl helpers taking the global GPIO number as argument
with the improved variants that instead take a pointer to the GPIO chip
and the controller-relative offset.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/gpio/gpio-aspeed.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index 58f107194fda..d3aa1cfd4ace 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -750,12 +750,12 @@ static int aspeed_gpio_request(struct gpio_chip *chip, unsigned int offset)
 	if (!have_gpio(gpiochip_get_data(chip), offset))
 		return -ENODEV;
 
-	return pinctrl_gpio_request(chip->base + offset);
+	return pinctrl_gpio_request_new(chip, offset);
 }
 
 static void aspeed_gpio_free(struct gpio_chip *chip, unsigned int offset)
 {
-	pinctrl_gpio_free(chip->base + offset);
+	pinctrl_gpio_free_new(chip, offset);
 }
 
 static int usecs_to_cycles(struct aspeed_gpio *gpio, unsigned long usecs,
@@ -973,7 +973,7 @@ static int aspeed_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 	else if (param == PIN_CONFIG_BIAS_DISABLE ||
 			param == PIN_CONFIG_BIAS_PULL_DOWN ||
 			param == PIN_CONFIG_DRIVE_STRENGTH)
-		return pinctrl_gpio_set_config(chip->base + offset, config);
+		return pinctrl_gpio_set_config_new(chip, offset, config);
 	else if (param == PIN_CONFIG_DRIVE_OPEN_DRAIN ||
 			param == PIN_CONFIG_DRIVE_OPEN_SOURCE)
 		/* Return -ENOTSUPP to trigger emulation, as per datasheet */
-- 
2.39.2

