Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9191B7CC237
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343507AbjJQMFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234752AbjJQME6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:04:58 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA47AF2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:04:53 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c501bd6ff1so61887061fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697544292; x=1698149092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqSvTTUiCAxcdVsqPtP3QRiyb3qISoSChjkUUgG3668=;
        b=SueKBiqmIZUOBtnSpA7PCqgvsexnr/Z/EBBwRZ+sWrWr2fCH1iFKOWhJVE5U7KMUvO
         x5IcHqS1rUl8vEWKSWEyFvFDLjJpH4sNngHggnHs6X8r8XFbuk6580J07czQKupfKP3G
         2s7NIT1sc56DPfK80KZ+3kDnHNfcFJiLsukLGKILsSiTpCcNz7s+dMsp/YAglMufGRED
         Vaw8HbIbKAVznIqXfM60agbxJ7PFluJwEqLr3ZUlZKgIbmBMqkZ+0IIjdxKGJ+Sb/Lfj
         O4xPDOdd1SNJtxRu2BjzN1SGCH2dVaKWkrUUEJJypSp34PLxuf9IRzfNsYKncKcWYFPa
         AjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697544292; x=1698149092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eqSvTTUiCAxcdVsqPtP3QRiyb3qISoSChjkUUgG3668=;
        b=d0sxYCKQ+4f07+JAPc76t69e6zwjB1Upu00ZQxrMv3FSPFODf9p89SJ73FfXZQCE7D
         jiv9DVhvacxuyo07zg0qAZ7F/GJHQKayK5jUpQNqpHBp/JZ/roAcPfFsJNuVvTsvSIUr
         eBS1WC9+5W6IqHZCUbHwDFCWP+WeSobiS/XNDDqx7sXBtxSS7tu5ES0wmnBw+QlBjMP5
         HWVs6FH+6l6ZI83HvTe2iwI/fAqb8o8j+F3imsqY/9U4rn9Ch764bl+qLT0BkjyIes//
         gUTklCWP5Jb96uCsYs7J/eIcIHa5G94L0vRbWJhe9emkHiQ+gO3dBo7pCE1c6wSBwR3u
         9pBQ==
X-Gm-Message-State: AOJu0YyYrf2w5blWAJvzVzw57QY8sONN5D1Ld9eb+NGQuf4XA+feFrhB
        PC0t9EnAni+JK8yyYDdL9jbXlnwT5CbKkxQ6rLg=
X-Google-Smtp-Source: AGHT+IFdNGufBtvxHVT2PYigX8VGTwzhNOTUcTb1bos7CHU1BhiK+V/FOUi1kwpeYNQkD1kZB9oNJA==
X-Received: by 2002:a05:651c:b29:b0:2c5:380:2a10 with SMTP id b41-20020a05651c0b2900b002c503802a10mr1919281ljr.25.1697544292084;
        Tue, 17 Oct 2023 05:04:52 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b00405442edc69sm1353859wmm.14.2023.10.17.05.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:04:51 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 04/73] gpio: cdev: use pinctrl_gpio_can_use_line_new()
Date:   Tue, 17 Oct 2023 14:03:22 +0200
Message-Id: <20231017120431.68847-5-brgl@bgdev.pl>
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

Use the improved variant of pinctrl_gpio_can_use_line() which takes a
pointer to the gpio_chip and a controller-relative offset.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-cdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 31fc71a612c2..54ee075410db 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2287,8 +2287,7 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
 	 * FIXME: find a non-racy way to retrieve this information. Maybe a
 	 * lock common to both frameworks?
 	 */
-	ok_for_pinctrl =
-		pinctrl_gpio_can_use_line(gc->base + info->offset);
+	ok_for_pinctrl = pinctrl_gpio_can_use_line_new(gc, info->offset);
 
 	spin_lock_irqsave(&gpio_lock, flags);
 
-- 
2.39.2

