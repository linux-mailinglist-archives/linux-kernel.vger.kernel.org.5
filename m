Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D353792E71
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 21:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241842AbjIETLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 15:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239704AbjIETLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 15:11:13 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D401AE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 12:10:43 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52a250aa012so4045058a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 12:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693940992; x=1694545792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8EoAIqFLJCxUpfLhsvBV4jgy9F1vQzmq/NZ2XWmhPM=;
        b=hEhQSp8BXXoyWbT2JJckSpVz0Uk5ZUxoFP0/hKqIAWOtxTkuaY+nwCpIGtcUuWY9u5
         dGoGp0xZ+OE0Io4lgw5soRLzeF40H1mR+Qjs03hLUTBy8H6x4k6cM6sHQNVMsiiOzi+C
         Wk53VAsVdE/Lt9orLGGUOv9kCnQXfr4rf1Ttiyz7x5ND/mT2HplmiTdqVmNKNKabS9Ck
         VS452WgAaWCFnh+O3/M8rKcpfnm3Rx7dVZBwIZib6RwghTwPJ0ITH+FFxtV3gNGLm7Q2
         V9u1gflzV99w9svm5lmerFipwD9EODtZaUNI9+PiGpysoPaqi1QieMjVeB4p7HZ3BvMy
         PhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693940992; x=1694545792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8EoAIqFLJCxUpfLhsvBV4jgy9F1vQzmq/NZ2XWmhPM=;
        b=BC3N0uJEmmeSAbK1OjoRN0coxTvEDC1JeRQQS6r/oPmkYPwn6HoTeJid/2vMF4NN5V
         s6SSGG3DAGKr75qvqShzRMqhpuyFqpaf/2All8QQRr+Wcb9ferw6VuBeBHw/9t9kJx91
         Ay424IQgtErlngemcDUZeG4aaWYbH8cXJFOYIgVAZDbNkcCdH9mqiYKpeHGZp3dGSjct
         ZVMoTS/mZEYh2tzE9Xgq3oGMk9O+/6qWXF4T5xCFd8bFNm5DoyM0HRVeMIPdkIyC/h/s
         fbR46h1mKnJN67gihJjZV7gINBPpGz1rnPZPLBEMe83ClpAwb0G9WnYCkCxCzSIRgjWJ
         xZnA==
X-Gm-Message-State: AOJu0YykL/R41M9Q8xQ9wNpcBFWA7Z5ToySJKeModoiOf4fh3di0taP+
        Tu0uXZQWvMFpljzPlTN6n29+IsQpmZt0ddTPERw=
X-Google-Smtp-Source: AGHT+IGdmweLsvxMkviAD6X4Rb7LNMdeCjqz2Ypd3y+SG6ZL6d4+T9L7pYZxfgxQTgv+RGIUJmtJEw==
X-Received: by 2002:a05:600c:2809:b0:3fe:dcd0:2e10 with SMTP id m9-20020a05600c280900b003fedcd02e10mr472155wmb.17.1693940027944;
        Tue, 05 Sep 2023 11:53:47 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7a54:5dbc:6d09:48b7])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c249100b003fbc30825fbsm17550010wms.39.2023.09.05.11.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 11:53:47 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 18/21] gpio: acpi: replace gpiochip_find() with gpio_device_find()
Date:   Tue,  5 Sep 2023 20:53:06 +0200
Message-Id: <20230905185309.131295-19-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230905185309.131295-1-brgl@bgdev.pl>
References: <20230905185309.131295-1-brgl@bgdev.pl>
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

We're porting all users of gpiochip_find() to using gpio_device_find().
Update the ACPI GPIO code.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-acpi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 5633e39396bc..15d3350123d9 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -143,7 +143,7 @@ static int acpi_gpiochip_find(struct gpio_chip *gc, void *data)
  */
 static struct gpio_desc *acpi_get_gpiod(char *path, unsigned int pin)
 {
-	struct gpio_chip *chip;
+	struct gpio_device *gdev __free(gpio_device_put) = NULL;
 	acpi_handle handle;
 	acpi_status status;
 
@@ -151,11 +151,11 @@ static struct gpio_desc *acpi_get_gpiod(char *path, unsigned int pin)
 	if (ACPI_FAILURE(status))
 		return ERR_PTR(-ENODEV);
 
-	chip = gpiochip_find(handle, acpi_gpiochip_find);
-	if (!chip)
+	gdev = gpio_device_find(handle, acpi_gpiochip_find);
+	if (!gdev)
 		return ERR_PTR(-EPROBE_DEFER);
 
-	return gpiochip_get_desc(chip, pin);
+	return gpiochip_get_desc(gdev->chip, pin);
 }
 
 /**
-- 
2.39.2

