Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF8E79CD59
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbjILKIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbjILKHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:07:49 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E247310D8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 03:07:44 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-401d2e11dacso40979525e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 03:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694513263; x=1695118063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuDRdpEcQdOPJO6ECwwAIvUZv3DHwFUskaWy08I+lxE=;
        b=R+pdXZJsbg36bQS1IruCjbSCZYbDuBqAePFsDwMNtU+HYxXzxTzsvwl1OO6VhRPnQ4
         j9TiBLLmFlzEMZ2Apyz5XnHZJgSkzjPB2vbaT/X5gHDKej6KL0CSdFwYITThK3ojrRoF
         +keT6Fyg2/WrzL2wuuugSin5ZHdZtCqhbHwFXCAh9gLtreUKHEKO6aRGmeWvAsu3wRzx
         V1zd3uNPJd6umy4UdJaFbEEWRX3q8ZmefA/aO3mT+Q5eEhAhgOU6ScK/irf+xxUAsjml
         BHwe2e2QvsW0sN1AIhiYoYhSa7vODFkCXvCXJnfmUD9oPvxaKr7/WOyr+nIn0y7eAqkR
         EsmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694513263; x=1695118063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vuDRdpEcQdOPJO6ECwwAIvUZv3DHwFUskaWy08I+lxE=;
        b=oO1fAZTsa2TDHHWsXvCzkyu3mvothcfzuUgxy3CCydfodyWsuzyBS5g0OahQM54wBK
         7SISdbJo3iO/G28vgHVCaJMRy7HZEGBF8SREb5erybirsIQW0lZCjuS+GVFXZK+FQ4+W
         JetrgtR2ndV4Eix2qK2OVTqwZjkJWxfoVIXmH0eYoXwfhfMMJWVB9TI+ivbogeI5j8BK
         a/4LjRKJvno6zhAISMcnoFbJJ2y8kCANAvDKOU60v/iWlvg+b6zf7UlVkTcMD6Ln9B89
         Ui8vv4UybOY0HWtZ4U4hey3z1aYDzanidC3sYQVX02H6ZN5dktsTvfjjjc/Gw1+ueKjL
         1R9w==
X-Gm-Message-State: AOJu0YzimcN3y6KCQ2CdnqBNC99UTHOw60WfMSVyqh5eElIpbAD7XSjz
        sp6VpWNw6OlHA5Um7kh88EnM2A==
X-Google-Smtp-Source: AGHT+IHcZIGJJ9r3+wTUOrgnZTM/fZOZHsWqZAXQxLGYEGgNMLSjHxrTMHQMpFSrR8HRTFvJP12vHw==
X-Received: by 2002:a5d:525c:0:b0:318:720c:bb3 with SMTP id k28-20020a5d525c000000b00318720c0bb3mr1373602wrc.20.1694513263436;
        Tue, 12 Sep 2023 03:07:43 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:907f:4cd7:f0ae:6b2a])
        by smtp.gmail.com with ESMTPSA id h5-20020adfe985000000b0031ae8d86af4sm12351417wrm.103.2023.09.12.03.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 03:07:43 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 09/11] gpio: acpi: replace gpiochip_find() with gpio_device_find()
Date:   Tue, 12 Sep 2023 12:07:25 +0200
Message-Id: <20230912100727.23197-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912100727.23197-1-brgl@bgdev.pl>
References: <20230912100727.23197-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We're porting all users of gpiochip_find() to using gpio_device_find().
Update the ACPI GPIO code.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib-acpi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 17a86bdd9609..ec618962a5cb 100644
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
 
@@ -151,11 +151,15 @@ static struct gpio_desc *acpi_get_gpiod(char *path, unsigned int pin)
 	if (ACPI_FAILURE(status))
 		return ERR_PTR(-ENODEV);
 
-	chip = gpiochip_find(handle, acpi_gpiochip_find);
-	if (!chip)
+	gdev = gpio_device_find(handle, acpi_gpiochip_find);
+	if (!gdev)
 		return ERR_PTR(-EPROBE_DEFER);
 
-	return gpiochip_get_desc(chip, pin);
+	/*
+	 * FIXME: keep track of this reference somehow instead of putting it
+	 * here.
+	 */
+	return gpio_device_get_desc(gdev, pin);
 }
 
 /**
-- 
2.39.2

