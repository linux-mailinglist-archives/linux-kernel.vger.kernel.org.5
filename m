Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A429F7CC22F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbjJQMFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbjJQME5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:04:57 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A5CF7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:04:53 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c518a1d83fso40408451fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697544291; x=1698149091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJdD7DyqFPsbeX9i2wGTnakQ0HgNh9JVzW41FU4431I=;
        b=2XsPkO5nb8BZE5s9wof5pYssgL9kKVX6kvC6p8KZh2/lGIKgmJ7Mo7xd6Komh8Lfp4
         eEuelPHpeNsdgoB2xQ9+j/N12DpBEJ1Fnbc7TvGZxt7+pXzDBKFOOEH45XRn/qdYX2U8
         1Ym/WaXxEu9VQOVYcPbkIjBN/V+xa8tpKeMFVsBWlM8vGs01CpSwfZEohxKr+qGNow7i
         ujkEIndtV/RwfUSG3tTdmWUOTE73BfKkC8f1gYAN5A+xuR6Idhyn+GB0GSjnMLD7hDqQ
         TscPvnr9/BFCfSep6FMSbd5qC0Uj3ZWN3qJaM5Ler87pyIPC4JquLiwtIAQGPp608NLD
         VIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697544291; x=1698149091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJdD7DyqFPsbeX9i2wGTnakQ0HgNh9JVzW41FU4431I=;
        b=EvPpS3ODVfompBDZGtfoKbt4T9FsxI9sxsA5fXELkQiF2wuZJp+WLbMKDrUzhzyx+F
         Fw5gDHk5oRPAN5TcSmD0WswEGEkFcZKyAvIrTYzgWanXKNF+UHehtl7IcpR98jQrkE8b
         Lc9VaR8eOqSOgT9okmyI0cI0cxDzfv81/PujkjkNaXC/xfL/ZnW+kuXQ4+vLjGAUlPdB
         I7KkBCa4v5ym+sjRyxV3UX05lh9F8Y4x2QBiu/sblaYuQ0UrR0ZPjbj5+7s9eB7/FyzD
         UOght5/UDBaMr1qqRC+pUEA+QHqxZ/pF9ZYZNi7xIYmzkLwQKaBOIgU+NR6I4Fr6GzRa
         dVPQ==
X-Gm-Message-State: AOJu0Yy8UHDq6Y71CZ0x29C1Iu4IJCGQGXekc4hztEU5xqzNY8TwrAFR
        eK1uQHYRzRxafwQg0DgX1LUZgA==
X-Google-Smtp-Source: AGHT+IExhqcdf/1IDWyAPkp4H4CzGnYQk+Cl1WQIoBRI+QOxlOzWXsSjWsKNbvBxqRISzeP31uvlcg==
X-Received: by 2002:a2e:9613:0:b0:2bf:7905:12c3 with SMTP id v19-20020a2e9613000000b002bf790512c3mr1427084ljh.40.1697544291285;
        Tue, 17 Oct 2023 05:04:51 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b00405442edc69sm1353859wmm.14.2023.10.17.05.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:04:50 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3 03/73] gpiolib: generic: use new pinctrl GPIO helpers
Date:   Tue, 17 Oct 2023 14:03:21 +0200
Message-Id: <20231017120431.68847-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017120431.68847-1-brgl@bgdev.pl>
References: <20231017120431.68847-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/gpio/gpiolib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index cbafcd95243e..37c1df78437f 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2036,7 +2036,7 @@ int gpiochip_generic_request(struct gpio_chip *gc, unsigned int offset)
 		return 0;
 #endif
 
-	return pinctrl_gpio_request(gc->gpiodev->base + offset);
+	return pinctrl_gpio_request_new(gc, offset);
 }
 EXPORT_SYMBOL_GPL(gpiochip_generic_request);
 
@@ -2052,7 +2052,7 @@ void gpiochip_generic_free(struct gpio_chip *gc, unsigned int offset)
 		return;
 #endif
 
-	pinctrl_gpio_free(gc->gpiodev->base + offset);
+	pinctrl_gpio_free_new(gc, offset);
 }
 EXPORT_SYMBOL_GPL(gpiochip_generic_free);
 
@@ -2065,7 +2065,7 @@ EXPORT_SYMBOL_GPL(gpiochip_generic_free);
 int gpiochip_generic_config(struct gpio_chip *gc, unsigned int offset,
 			    unsigned long config)
 {
-	return pinctrl_gpio_set_config(gc->gpiodev->base + offset, config);
+	return pinctrl_gpio_set_config_new(gc, offset, config);
 }
 EXPORT_SYMBOL_GPL(gpiochip_generic_config);
 
-- 
2.39.2

