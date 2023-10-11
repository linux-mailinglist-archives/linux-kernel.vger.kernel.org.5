Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FD37C530A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346777AbjJKMJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346581AbjJKMJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:09:18 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562F1AF
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:16 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bffc55af02so80541821fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697026154; x=1697630954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfWYSE8ThvfQSJQ9/Fq2M/H6j3nV1pBrLUi6/wp2wmg=;
        b=tzFX/is9VS1PymKIzrZiv/FgNTtMCukISseTFFjMgX8/+RkW+p0J3HA13/hO7WHGAm
         NRbhIzKa+KqaEzinW1fJKO8J2iwIrl0JtY9KVqksELDFS+lhWbo/rM+C0iIPmBfrvGJ/
         DuigJLpqvoqEbH0qqubQkY9EF8xLydZKRuPa4TRDyDr9RRUJgRero0FlvBYTYA0QlNKe
         LR7kJ1uUKSJpqP0UZMn3b4t4cnoBJg9vW1ggJhRPMZkOyDZWpn4K78Mr4BBzCW43sXjK
         91IgFD4j40zwO5xyQDkIriT4vEZt3rtiZgh6GYOREfDaHgmAZlxusmijgD6+GRmdQW5t
         nlfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026154; x=1697630954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XfWYSE8ThvfQSJQ9/Fq2M/H6j3nV1pBrLUi6/wp2wmg=;
        b=DnGRVuPEsinLrTkhu9pkXySdr5HRHR7OStr7wS4nRihXvT3Oj2fnd9ujRIW8VW8wzb
         mjeKWsF379vkSS8vEhO172WuDr1yfJUqDyxrT0ROUATmt+2u0v2lmbnbHuTU+8A6DobH
         nt/kJzo/1IQUTmMIbtTiPCwanW9Mgj1Ws4j2PYk7ww06q2dRsCbDICA/VCMWveLAOdnO
         W2z6L98Wpwr5alMLY2mlMzMvIeYTljp7JBjOolvU19mkVQ5Kkep/tAYY289zQDRrksF9
         kktgXdxvgIUrKagP7tJU3ovFdRENz2IPUx7rDTPdc+yFodPyG3tOzhwHRF3cnfj7ViJJ
         5zDw==
X-Gm-Message-State: AOJu0YwurziCtrCHMRFamXbdKMg0BPL/j9/5dUw6i32zYkd3nwXeYIJ1
        jY9tRDBVVpGUNCXkL0RdBnYPYA==
X-Google-Smtp-Source: AGHT+IEZWqkFOSiHfQttc06r8Pg7H6JvB/CJxt/WCg1zCQDClW6HVyW+fiMET9eKmPPIs1YIG4NNAg==
X-Received: by 2002:a2e:9f07:0:b0:2bc:fdec:a3f6 with SMTP id u7-20020a2e9f07000000b002bcfdeca3f6mr17612215ljk.48.1697026154618;
        Wed, 11 Oct 2023 05:09:14 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e551:3946:26fc:f94])
        by smtp.gmail.com with ESMTPSA id w21-20020a05600c015500b0040652e8ca13sm19012253wmm.43.2023.10.11.05.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:09:14 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 08/62] gpio: aspeed: use new pinctrl GPIO helpers
Date:   Wed, 11 Oct 2023 14:07:36 +0200
Message-Id: <20231011120830.49324-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011120830.49324-1-brgl@bgdev.pl>
References: <20231011120830.49324-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

