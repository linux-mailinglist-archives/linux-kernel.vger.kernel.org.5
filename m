Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231F87C5310
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346731AbjJKMJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346626AbjJKMJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:09:19 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C5F91
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:17 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-405417465aaso64888165e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697026155; x=1697630955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHYUxdKvRRrRVIPNu6faP+9JX1VoSOdz9zilghn0NZE=;
        b=VTgj27QwHi0NqaYQ400IzTTHqwpk+jo8AkG59RHLJVrES/qn+5nO0VR9rOOPtcw3gp
         V+XpmO/Jep5HGvUXT0qnEGQChSVXJiKYOC7kW9+YTWjoYk8ascqOEIUAwpWLK/EZfvtn
         Zo3VxIpNJqq5VOGk5WNd1q6On1fFjrF/fybjgfvieQyJ17SS4xyfq0LOTom0TR9x3ABk
         uzFt0k12tdly9chetE66YGdvH+KJAYCoEv8ygKFKkEWa7cfk4xPQa9dhNh0q8chIMVaX
         bA2StM7PA8m8+uMNj6f3BQeVo/Ed1IZoCM4VRsEDeChwAfk+EcM5Lf+9kBxDPfjy4EgQ
         KE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026155; x=1697630955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHYUxdKvRRrRVIPNu6faP+9JX1VoSOdz9zilghn0NZE=;
        b=Cwr5+DqworxjObACnfLytWAOUCLB7aQs8IaNIvA8EuZmJMcMh+OBGv6mSe57/T58Ua
         ToXwLZk5a+Mapr25Y5tbNzAvTYs4KOQDat96qha9GAVBArirbvZTRX/7OuLraYHWoUhs
         xa8vCz9mDqR9EcnLm5UQZpGRoD4JLZVQOfpu6GZgxcdFtxGy2Wp+/h8pK1JNi7nrVCYe
         5B1j50bEEoOfo2zXL+eRPkK8GHr7fnzjKM4Wy135bck44WSMbOQsZ8VF4pz9OhU0/RPe
         +u2TAjuARd8fTE2yiw/ofJKcGVSJw1vpBGKFlOfU8s9b8lH+PuffR7QcEzoEt2qxJn66
         aNZQ==
X-Gm-Message-State: AOJu0YwBPSrWpVVIQyCqoMWh/33RwGntAcmTHrhQBDbR2JMN948XjQao
        /58rTjlrTOspnTUpbdYvlnNziQ==
X-Google-Smtp-Source: AGHT+IEEnuCLIHwoNV8TUUhx7VIfUqzxzC9qENpIxGm4GdINwA/xpTWHqV+OXqtUhkBp66PCIkgrTw==
X-Received: by 2002:a05:600c:207:b0:405:1c19:476d with SMTP id 7-20020a05600c020700b004051c19476dmr17931892wmi.39.1697026155503;
        Wed, 11 Oct 2023 05:09:15 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e551:3946:26fc:f94])
        by smtp.gmail.com with ESMTPSA id w21-20020a05600c015500b0040652e8ca13sm19012253wmm.43.2023.10.11.05.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:09:15 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 09/62] gpio: mvebu: use new pinctrl GPIO helpers
Date:   Wed, 11 Oct 2023 14:07:37 +0200
Message-Id: <20231011120830.49324-10-brgl@bgdev.pl>
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
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/gpio/gpio-mvebu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 8f80ca8ec1ed..d7eae6f0430d 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -346,7 +346,7 @@ static int mvebu_gpio_direction_input(struct gpio_chip *chip, unsigned int pin)
 	 * Check with the pinctrl driver whether this pin is usable as
 	 * an input GPIO
 	 */
-	ret = pinctrl_gpio_direction_input(chip->base + pin);
+	ret = pinctrl_gpio_direction_input_new(chip, pin);
 	if (ret)
 		return ret;
 
@@ -366,7 +366,7 @@ static int mvebu_gpio_direction_output(struct gpio_chip *chip, unsigned int pin,
 	 * Check with the pinctrl driver whether this pin is usable as
 	 * an output GPIO
 	 */
-	ret = pinctrl_gpio_direction_output(chip->base + pin);
+	ret = pinctrl_gpio_direction_output_new(chip, pin);
 	if (ret)
 		return ret;
 
-- 
2.39.2

