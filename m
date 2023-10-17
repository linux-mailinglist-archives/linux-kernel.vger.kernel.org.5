Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408927CC240
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbjJQMFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343545AbjJQMFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:05:19 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AE6107
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:04 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c503da4fd6so56571861fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697544301; x=1698149101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRDXdsqovOpFqQlW6NMXq89oYY2ugyvGcK/dIwIm0sQ=;
        b=AVXa3Tfzl3rav88xlFsyfnoFwSZsbQQt8eBC++dVnjBZZ9UfYBy6XsKBdKVY8FE4Ut
         XYYZGqnJTT9gJw7xyjkh5icGGhOYZJnSvRC0i4Rg4HyBMZD4vwxwXdSOM+TaLEMN6EDC
         JP1tRnuaxN56jpo2sP18sBmddk+ONOdYJQUcYjNbmm1U2g2BhZTDEwxGfWatCKL/OSEW
         FPZLr9hsEM0HnUVcOC/95k/cVxrBpFe5Poc0B6/0cN3LNn4faQoHuIKl00qCAkNuREvb
         RKORyYr4YBtRjNiII8d/DkgJ0hBInPqf5Gip9Rl1ZoDIrIRwzEWk/kL2EkCa15KqKOQH
         MhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697544301; x=1698149101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRDXdsqovOpFqQlW6NMXq89oYY2ugyvGcK/dIwIm0sQ=;
        b=LCcknYFKz06rs6xiZmfC7Ok8O5m8i9fd0pYKQwH8nAE3VuLkgE7zCe0IogIdyFpCOQ
         PxkxwiHi/97szV3d/KhiRp/V3Brz0Moh0Ab9cl3b+iyGh+QVQSOk/ekX/wCvs+rN7Wvd
         RtkFfxooPQPkuknSTN9eR4z2/Ikw+va8ul+Fy2J1hW1l0O/25tqgJGdrHnqyzbgQ8+Az
         x2+n8qggkkoiwdAnM5YZIy6MJrVzDCGaeEcm8m1BsuhKIU9JUPoixWyi7v66uR/SjnpS
         GflTKzyes5ytHdAFElFrujGwZX8M+4WDmPKdTvEH3wyf2gm8iQ/+t7R7KghDs6woZ3aG
         rWwg==
X-Gm-Message-State: AOJu0YzN+7Zh8+ys5ebnfkKUB/3y7RSoeR0HdokcU/4hwYHYGXBBRavK
        Gcb2kECHnAywtMWVmOAG/zds9Q==
X-Google-Smtp-Source: AGHT+IGFdSq5yv35rcnk3spnwirE3Sg8RRrCIpFX291tKimiy2IrcXTLdu2jVgFX3XJX1uSRtKRQbA==
X-Received: by 2002:a05:651c:54b:b0:2c5:106f:5416 with SMTP id q11-20020a05651c054b00b002c5106f5416mr1557572ljp.53.1697544301101;
        Tue, 17 Oct 2023 05:05:01 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b00405442edc69sm1353859wmm.14.2023.10.17.05.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:05:00 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 12/73] gpio: vf610: use new pinctrl GPIO helpers
Date:   Tue, 17 Oct 2023 14:03:30 +0200
Message-Id: <20231017120431.68847-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017120431.68847-1-brgl@bgdev.pl>
References: <20231017120431.68847-1-brgl@bgdev.pl>
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

Replace the pinctrl helpers taking the global GPIO number as argument
with the improved variants that instead take a pointer to the GPIO chip
and the controller-relative offset.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-vf610.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index a89ae84a1fa0..2c22a31ffbdc 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -130,7 +130,7 @@ static int vf610_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
 		vf610_gpio_writel(val, port->gpio_base + GPIO_PDDR);
 	}
 
-	return pinctrl_gpio_direction_input(chip->base + gpio);
+	return pinctrl_gpio_direction_input_new(chip, gpio);
 }
 
 static int vf610_gpio_direction_output(struct gpio_chip *chip, unsigned gpio,
@@ -148,7 +148,7 @@ static int vf610_gpio_direction_output(struct gpio_chip *chip, unsigned gpio,
 
 	vf610_gpio_set(chip, gpio, value);
 
-	return pinctrl_gpio_direction_output(chip->base + gpio);
+	return pinctrl_gpio_direction_output_new(chip, gpio);
 }
 
 static void vf610_gpio_irq_handler(struct irq_desc *desc)
-- 
2.39.2

