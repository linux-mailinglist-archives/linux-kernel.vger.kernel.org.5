Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86B57B6C3F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240306AbjJCOwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240234AbjJCOvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:51:39 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380ACF4
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:51:36 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4064876e8b8so10427285e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 07:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696344694; x=1696949494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CbdpxA2yoiqOdTkvvgzFYeQ0S/2apw7f0m7nJ4Vrkk=;
        b=kHRvkPtq0x0OfpiSyujJgmard4wpaZEzlnRnJX6LBQnPNK/M908lVD6g3FgJQQ3Sh/
         +f9Nn5Jgb8ZQjr0TUo2s7Zewp8EwYRvPO2DU2h0t/hYMBPfdJp9jMvinju49CIoe9zpz
         S4QVOOyQ2TIjMf7u9csgNyyRgyhR85A5trg7tJVaSK6kNr4Aie9qVt+B2KX+j9GueGgd
         tKjY1fNSGmVjCBn02NsRbsT0cTrapiDYUsp0ob6wD5l3ki2GuUxa2X/Z+JrWhIGXQH8j
         AkN8vJHzSOEi8GXhpZdOYGPs1BHSkJEbVoiO7pHX/bt9h4KpGGmhCaqf2tYRmT0OZiWm
         Vqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696344694; x=1696949494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CbdpxA2yoiqOdTkvvgzFYeQ0S/2apw7f0m7nJ4Vrkk=;
        b=GvNsgsrKLqWa0D3+EHSijLVdquwLxAbO8RyJ9vyvBjK/7MMII7EfCzEMUig7+tAjq8
         7ptoHK9GOAcKchlF7IKPusaEq3AiAQtNKEBzLxCujZ9RSwlwQOyBMbA73k1vdkqzNpdm
         +/8tOjvcKFJ7AhiW+R3lv3D8nMvd/38QQCxD3/hjc8IIo7bJKHoabFeasv68xjC9U6Dr
         WvIxmtmDWTnd0AM9uzTTivoU/zod+1N51g3h92rbqWwmAvy21sglkYOGEAnpenBJ1cRF
         bxzF6SeTdyykSf+6egVg6kZFfD9uYfDykyMX+ZEcUKYRUNKv7aLUa46z93oHoJoosMZc
         /KOg==
X-Gm-Message-State: AOJu0YzhrQafTaKiMrpj2aSsXqEyih4Zn2auBo+kspvwFeSUfjAyjihi
        Ne6tofeYUf3Ko8N51o3UnEi3XkLo8NJqiEl9zT0=
X-Google-Smtp-Source: AGHT+IHIO4Q4ObYCwveHLK/qN/Dt6c8/C46Z6nToKkkl0hd3G74SWLbjVZAZ/OqYcTQKrKhuTim6RA==
X-Received: by 2002:a05:600c:1c1a:b0:406:53c0:3c71 with SMTP id j26-20020a05600c1c1a00b0040653c03c71mr12369767wms.37.1696344694718;
        Tue, 03 Oct 2023 07:51:34 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:1f2d:3479:a5de:fa35])
        by smtp.gmail.com with ESMTPSA id c15-20020a05600c0acf00b003fe29f6b61bsm1462773wmr.46.2023.10.03.07.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 07:51:34 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Subject: [PATCH 15/36] pinctrl: bcm: use new pinctrl GPIO helpers
Date:   Tue,  3 Oct 2023 16:50:53 +0200
Message-Id: <20231003145114.21637-16-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003145114.21637-1-brgl@bgdev.pl>
References: <20231003145114.21637-1-brgl@bgdev.pl>
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

