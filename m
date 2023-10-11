Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3377C539C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346859AbjJKMVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbjJKMUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:20:39 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4579010C7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:54 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40535597f01so63262975e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697026177; x=1697630977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jk+oITkQNupgMAZK1L53SbV604DG6cKlw2d4UZaGR8E=;
        b=vGB2fWNUfB6rXfZM2uWASPWG3kRfG/RI8WjFzU4q6h471j4kcA3aDX4RZ+NCyH21TO
         aRHo57nae2LTE7cMAmxRhfBn7rjRsxct2WZrw+UNq6AwRhxk77lBhjuRRa7qYPv+SSzl
         5zvKQAaBQfvlxgLiB8VojttNhZrv5nFYLvhNJX0gtNeUPEI+Im1fNlRZNbGnwXvunSyT
         k0CgR0vyf7eYBvlTN0q/YI5JuTi5WMSaqOGgYT2DyGelPCd6djKWyoqMxXQ4Woh6toqH
         yDGDXVfb9cTKN2yCf9s3gNGDkubMQfQPEWoDcRl1lfS/TH72BXgk/DbxEVsToYAFfS1L
         jnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026177; x=1697630977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jk+oITkQNupgMAZK1L53SbV604DG6cKlw2d4UZaGR8E=;
        b=Rgi2nRtEly602zSGZxPBnNq4WABDRpp7WBWomjFBlQOChvsPXzNrtFCMr3+NecO0I8
         MFjuvTAnYMoh114Zpkc6B3JMTqAYFClXfHaIqipp3pzVDMxY2c9r6SPsrWcMCWcgBvJc
         bgYa4XokDBiI+Vvih1Ja7gh7l5pvKHwCclGml3X13j7XzFYBSIMqMOsFKFCMt2C9eleq
         b4nH78/zu7efalQ5gCzXOriMs2gLci2xnD+XtciMn55ZHGMzos6Pc9A8CjZ9nDXHwkX4
         sNao0tZjuL9uQQWtP6pqWgQbgXRHBGhFOKZ0uNw0OQaDXl8fG1L/wbSzOdgkjmz6AmBG
         ubUQ==
X-Gm-Message-State: AOJu0Ywu/vTSctCWMVhG3fHKy/jU7ZSmg1ORYACDWMu84VAHU9GIY0zH
        lcC3AVr7T0BnXvOu1Ulxy89EBhAUDG9Kq5o9d+Q=
X-Google-Smtp-Source: AGHT+IEVSqwGOkpON7diwN9rayVk6RMzR4q3otbXEDJhqWGRRMUVbg7tEPOP3xkxloOtkWRa0ft0hw==
X-Received: by 2002:a05:600c:2242:b0:401:be70:53b6 with SMTP id a2-20020a05600c224200b00401be7053b6mr18605733wmm.15.1697026177415;
        Wed, 11 Oct 2023 05:09:37 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e551:3946:26fc:f94])
        by smtp.gmail.com with ESMTPSA id w21-20020a05600c015500b0040652e8ca13sm19012253wmm.43.2023.10.11.05.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:09:36 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 33/62] pinctrl: remove pinctrl_gpio_direction_input()
Date:   Wed, 11 Oct 2023 14:08:01 +0200
Message-Id: <20231011120830.49324-34-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011120830.49324-1-brgl@bgdev.pl>
References: <20231011120830.49324-1-brgl@bgdev.pl>
MIME-Version: 1.0
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

There are no more users of pinctrl_gpio_direction_input() so remove it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/core.c           | 9 +--------
 include/linux/pinctrl/consumer.h | 1 -
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 6e163841d145..1d3afc7d1656 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -873,13 +873,6 @@ static int pinctrl_gpio_direction(unsigned gpio, bool input)
 	return ret;
 }
 
-/* This function is deprecated and will be removed. Don't use. */
-int pinctrl_gpio_direction_input(unsigned gpio)
-{
-	return pinctrl_gpio_direction(gpio, true);
-}
-EXPORT_SYMBOL_GPL(pinctrl_gpio_direction_input);
-
 /**
  * pinctrl_gpio_direction_input_new() - request a GPIO pin to go into input mode
  * @gc: GPIO chip structure from the GPIO subsystem
@@ -891,7 +884,7 @@ EXPORT_SYMBOL_GPL(pinctrl_gpio_direction_input);
  */
 int pinctrl_gpio_direction_input_new(struct gpio_chip *gc, unsigned int offset)
 {
-	return pinctrl_gpio_direction_input(gc->base + offset);
+	return pinctrl_gpio_direction(gc->base + offset, true);
 }
 EXPORT_SYMBOL_GPL(pinctrl_gpio_direction_input_new);
 
diff --git a/include/linux/pinctrl/consumer.h b/include/linux/pinctrl/consumer.h
index 467f02b0aa98..f9cf70887242 100644
--- a/include/linux/pinctrl/consumer.h
+++ b/include/linux/pinctrl/consumer.h
@@ -29,7 +29,6 @@ struct pinctrl_state;
 bool pinctrl_gpio_can_use_line_new(struct gpio_chip *gc, unsigned int offset);
 int pinctrl_gpio_request_new(struct gpio_chip *gc, unsigned int offset);
 void pinctrl_gpio_free_new(struct gpio_chip *gc, unsigned int offset);
-int pinctrl_gpio_direction_input(unsigned gpio);
 int pinctrl_gpio_direction_input_new(struct gpio_chip *gc,
 				     unsigned int offset);
 int pinctrl_gpio_direction_output(unsigned gpio);
-- 
2.39.2

