Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9055A7CC239
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbjJQMFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234891AbjJQMFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:05:02 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AE5107
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:00 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bfed7c4e6dso69721711fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697544298; x=1698149098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKklGkxfnAqinncSlSkchK2k3CX/0axnYu/+hfRNakU=;
        b=WSnxP7xBtD730Xep5nlPEijSvGnZHzTpNPlq1MNrfg/rm0sjZontk9k3cTBmDrGXHZ
         dg2okQU4obug0GHkGppX87hjISVsb29oegkbjOxRSJ5IFPNim0kFtbW0tGknQwYPpopo
         JrWKLBNuhVzck+wLPaHBL5PLNBCtlEZBC+FF/6AfaZMW1+JNIF7/26StgxvHvViqBECl
         wFG9jlRUeZiu2OdcYqCTBYSzULmlbCZy6LdXB/aFCNJpPo+oXMyBARmKZcowQBNteDiP
         nY5kxwsghCp1wn1NGbzSGdQxH9crdB8NNaFx8DewLQmwUf86I3xt9OgpXHQK0ZrL08V7
         ZKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697544298; x=1698149098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKklGkxfnAqinncSlSkchK2k3CX/0axnYu/+hfRNakU=;
        b=bBB5wX00Qf2bZW4rxuxZmrqXK/a5VZhg4Fn++b/zRCqAEyfa0JoUbu0sfOtFGkrPld
         wbnjHbTND93E4b6EOyj70N+bcPV3tMpdPNYdf1J/n67xZVjNMWUCmJ2pxPIar+it0LP9
         2Kn+EtybVxUcuFxqiCzFxldiE7INrSvOgow1/TmTse3NJNobrsY8QMuAQbIOw1e3OHlY
         IqmvILJlLYDMdXQkBWWDhFwMHQyE94xtyMtNdF4jLgu1lbE40XofjO+uv3htvklv0Wqt
         hS7hLqP46HBpkRnbFs09RZUMlxWh/SEGbzEogerItVgsWE7dQbZr/rZPOza6fgfMpoMW
         vYXA==
X-Gm-Message-State: AOJu0YwfUB50RDHLbhx1DbM9MSzb7SKTPdEOK2vtYJtxtwG5nrZ+LgeO
        ZaGuPaUJmlErmZch+Js0uYS3meLFPmqZH0WGDfk=
X-Google-Smtp-Source: AGHT+IFIoEycxqJm+0fa4YLHQ/Skq1X8nEXW95SRXywJZA6ysN644CwjpjhTVM4ZoIxEBTIIkDY6cA==
X-Received: by 2002:a2e:7e0b:0:b0:2bc:efa4:2c32 with SMTP id z11-20020a2e7e0b000000b002bcefa42c32mr1382001ljc.37.1697544298531;
        Tue, 17 Oct 2023 05:04:58 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b00405442edc69sm1353859wmm.14.2023.10.17.05.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:04:57 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v3 09/73] gpio: mvebu: use new pinctrl GPIO helpers
Date:   Tue, 17 Oct 2023 14:03:27 +0200
Message-Id: <20231017120431.68847-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017120431.68847-1-brgl@bgdev.pl>
References: <20231017120431.68847-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/gpio/gpio-mvebu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index e5f2c2d2a721..c0ca0aa7b5cd 100644
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

