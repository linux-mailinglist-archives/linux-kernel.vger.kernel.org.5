Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08727CC24D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343548AbjJQMGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbjJQMFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:05:31 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4270319D
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:06 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40806e4106dso2990605e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697544305; x=1698149105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CbdpxA2yoiqOdTkvvgzFYeQ0S/2apw7f0m7nJ4Vrkk=;
        b=Ksc0BEO0uniL77xulNSoapsduPfB59WZzHCJqulnsaAO8aKENVK2w88gANTm8Eg0b1
         ujs8YOH6PDK90DJNCTM9nxQTDgq+6dCiHGZ1/J7Q77UWP38soZL6xUpjD1s7+Gss9mDk
         7PM5Lzo2Ffutm1IfOdO66jTlIKRDbmdTGhOorNYmqaiu8wSfbxjLVa0CB5zBiLMElUrq
         T0/rgizoyDrOcPOoDpwUoq98ZuT/Gz5U2TRm3ihqxSIDOHMgwlpaOHtgfNn0tNXhuQ5M
         h5g08XrVn6+UyMlpcdFql4o3SXVHyyaluu+lcazHpbQlaU3DWtSGfOf4uwTTMWpHsK/1
         UFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697544305; x=1698149105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CbdpxA2yoiqOdTkvvgzFYeQ0S/2apw7f0m7nJ4Vrkk=;
        b=KnjDSQI52FrCXg+d/QGRxa0iQ2UvpBMQkit69KRq5beg0YXt0onBp5rJuiBK0Uzt2K
         LPPW1saRtkaf1NfaMSgMgBoD/FQzD2V09rPKO0dq6yW/QJNObGfZn1VKx53NSA1u2+fv
         FFMZSWyP1xTS7jXncQQWqlOPNUZeZzPeBSWJHeL6HHooyHqf9Tu1GAHQQ5uADxXa3HXe
         zCH362QV77DLbA+Sp6JtUGeGJwiIEjlni731WTYy9Tp2wlUE0ZIPxPo9xEqNb6m/QNBm
         nt9awGJpFIUy2jY/H/KtVF7AsMIvwFVibyGNLNm/3N4RAgjIA4fkspXuto44JMh7y1nD
         vveg==
X-Gm-Message-State: AOJu0YxgSQ5flR0s2gsJzXtLgWe6bB2+MFnX/wgSzojPK0eVnUrB84nc
        e7LG+aKvGXeVzZ8OU0Q6dtL0zg==
X-Google-Smtp-Source: AGHT+IFf+OmIb8KXJS2ZkopH1GoMeY8rCnnDQP9EsEwpiPcrwzJmSCB/WSLyz86HviPM31NGQkLsOw==
X-Received: by 2002:a05:600c:6012:b0:3fe:d67d:5040 with SMTP id az18-20020a05600c601200b003fed67d5040mr1766789wmb.5.1697544305075;
        Tue, 17 Oct 2023 05:05:05 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b00405442edc69sm1353859wmm.14.2023.10.17.05.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:05:04 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 16/73] pinctrl: bcm: use new pinctrl GPIO helpers
Date:   Tue, 17 Oct 2023 14:03:34 +0200
Message-Id: <20231017120431.68847-17-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017120431.68847-1-brgl@bgdev.pl>
References: <20231017120431.68847-1-brgl@bgdev.pl>
MIME-Version: 1.0
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
---
 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
index bc7bb9876e57..fb98c3e14743 100644
--- a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
+++ b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
@@ -330,24 +330,22 @@ static const struct irq_chip iproc_gpio_irq_chip = {
 static int iproc_gpio_request(struct gpio_chip *gc, unsigned offset)
 {
 	struct iproc_gpio *chip = gpiochip_get_data(gc);
-	unsigned gpio = gc->base + offset;
 
 	/* not all Iproc GPIO pins can be muxed individually */
 	if (!chip->pinmux_is_supported)
 		return 0;
 
-	return pinctrl_gpio_request(gpio);
+	return pinctrl_gpio_request_new(gc, offset);
 }
 
 static void iproc_gpio_free(struct gpio_chip *gc, unsigned offset)
 {
 	struct iproc_gpio *chip = gpiochip_get_data(gc);
-	unsigned gpio = gc->base + offset;
 
 	if (!chip->pinmux_is_supported)
 		return;
 
-	pinctrl_gpio_free(gpio);
+	pinctrl_gpio_free_new(gc, offset);
 }
 
 static int iproc_gpio_direction_input(struct gpio_chip *gc, unsigned gpio)
-- 
2.39.2

