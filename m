Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D847CC306
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbjJQMWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234514AbjJQMWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:22:30 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4651273C
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:55 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-405497850dbso54310505e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697544353; x=1698149153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHG7rxCq2i//+W4yV7nUKawChQHAlvElG2FQaJzxjCc=;
        b=2AVAlLyD9FUtIXez4bcoI60LAyIjPmwwmkRyufVmQ4GUX5Q56QcKWN06/sUQq6YBKA
         yaDzmZAs9r26yTMCJh27RVb0w941th+mCnYYdF+LFrbFxx5mzCyVx3M1BrUArs6ITAOW
         nngz6pXM680n5EMzj19bH0U1011JZF9tcIez/NpFny1hc6Rzgk5FxTzgPtUFW0HJaR1y
         MINfhKNpPvvtlIrZ4Opmc31dScPe5RqjWmYNgzZ6gOtK85XdQ8ZNSoYpUittgzQWtkCf
         HiqWjNog7yD4DMkGSGVgfm5iVZ4OPTd8vCcIyOZj+F5JRuZ1DiABDokf5aKe4up2KjaT
         7iDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697544353; x=1698149153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHG7rxCq2i//+W4yV7nUKawChQHAlvElG2FQaJzxjCc=;
        b=tW/IHUqcggGTE68Bvz3pQsfFbkBgDvTehBPv1diSBZiFOMQrsQgnZpqbE6xu2OI4Yb
         RSzSe4OPsFvqRTG+4IYJxO65/yxTrAySVHqrnrkwSoE4IdM6351EDoK8u9vd/pya6hzg
         QnUvti1t9mqzS9H3ocL/QJuRf9iwWvbXfvwHf4ucodIISVdEuk/1M6BtosvFrALtTbZ9
         q3iT/q3REdlv/fcGPKvSrfuCP5yZqb57D+tfx5C+uW3qjXc/mGkPOgRtkqRkpDOcyCjg
         5pvyxZd1ts1iKI7QrTs+szvPxpta4RKzXYI9hIvOxBQVoac7guvK1mYfjUUe9glCeB21
         215w==
X-Gm-Message-State: AOJu0YySv/evGbuVK8oRRAK6SYyD67VQIugHampIjIfXKg39a129oIZg
        7A5mL6Q+KqKbkiaDfnNjkeFHOQ==
X-Google-Smtp-Source: AGHT+IHWlh4sDTH1SG2bWxKx5NGny8dO2LAca7pX4mI/k9lxdTYSnlxOxcknmQlpQof7BRuNfggmEA==
X-Received: by 2002:a05:600c:350f:b0:405:3dbb:ec5a with SMTP id h15-20020a05600c350f00b004053dbbec5amr1558009wmq.1.1697544353151;
        Tue, 17 Oct 2023 05:05:53 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b00405442edc69sm1353859wmm.14.2023.10.17.05.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:05:52 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 68/73] pinctrl: starfive: jh7110: drop wrappers around pinctrl_gpio_request/free()
Date:   Tue, 17 Oct 2023 14:04:26 +0200
Message-Id: <20231017120431.68847-69-brgl@bgdev.pl>
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

pinctrl_gpio_*() helpers now have signatures corresponding with those of
the GPIOLIB callbacks. We can drop the wrappers.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
index 695c8c0a6e8b..9d71e8c13310 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
@@ -545,16 +545,6 @@ static const struct pinconf_ops jh7110_pinconf_ops = {
 	.is_generic		= true,
 };
 
-static int jh7110_gpio_request(struct gpio_chip *gc, unsigned int gpio)
-{
-	return pinctrl_gpio_request(gc, gpio);
-}
-
-static void jh7110_gpio_free(struct gpio_chip *gc, unsigned int gpio)
-{
-	pinctrl_gpio_free(gc, gpio);
-}
-
 static int jh7110_gpio_get_direction(struct gpio_chip *gc,
 				     unsigned int gpio)
 {
@@ -940,8 +930,8 @@ int jh7110_pinctrl_probe(struct platform_device *pdev)
 
 	sfp->gc.label = dev_name(dev);
 	sfp->gc.owner = THIS_MODULE;
-	sfp->gc.request = jh7110_gpio_request;
-	sfp->gc.free = jh7110_gpio_free;
+	sfp->gc.request = pinctrl_gpio_request;
+	sfp->gc.free = pinctrl_gpio_free;
 	sfp->gc.get_direction = jh7110_gpio_get_direction;
 	sfp->gc.direction_input = jh7110_gpio_direction_input;
 	sfp->gc.direction_output = jh7110_gpio_direction_output;
-- 
2.39.2

