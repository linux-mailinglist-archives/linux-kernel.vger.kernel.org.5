Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4CC7B1CD6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 14:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjI1Mqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 08:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbjI1Mqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 08:46:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E002D1B0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 05:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695905157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ACdKckhs2IGUtv5AveDwU/IL9fYWvBeI2aPkdMd1dhI=;
        b=DSQY5BTLdfcwI5qb2dk3MHNeyooYqDVH4RTZU8vN8xeMwpDYGhkkq3WYbMYqxKn1hApip3
        zycOWVWi97P/U4PpzlKtcefyTCRQJI0XXDIDjfH0Ls9OzSQSE8GqFvgXQfN89+1pLOqDbC
        mh6/OXbc1tzyFR8jztJrfbw1dcDKoQQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-wFRXiqBZP6iloEPlFgOSug-1; Thu, 28 Sep 2023 08:45:55 -0400
X-MC-Unique: wFRXiqBZP6iloEPlFgOSug-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9a9d7a801a3so1128204866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 05:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695905154; x=1696509954;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ACdKckhs2IGUtv5AveDwU/IL9fYWvBeI2aPkdMd1dhI=;
        b=UErEfsWGtQMgzhCvBmSSB/MUIcxSE1bqSlAJuGM9DWRAkIfOPaXAKgH5Y9hCa44H0D
         rQQFNzPyxaTvrEUSTxy0ZLIsWeR4FtkaOH7Q7rpGpKdci7lq7AfSQQyfWPYXE8Wlyb6t
         HDtinJfPFpNz6bCPqeqpdfdmeC4J2AZxfA6IuCs6bagwAk0mXExUXYfkqVVRQSjdViOa
         Jf1IYJndqyvozzS3jpUeFuPAzL+DZEs7TBot+2OhWhQOqAm8uHHww1eyn9DOXG4tKFeV
         ecr/lgXNniD4b/eNOPggR7v9XXW0aJVNxXD0+SGpZwlzQ2hVCFGuGU/hk7WDDxncfJ8f
         3dQg==
X-Gm-Message-State: AOJu0Yyo7JZj2bW80Aa1dBChpAbAtW8M+l2A/KkzDgSvz5FS9qRes+uy
        wD+wvw2rhOJF+HrXsUqFQ9yKUbQw0NBRadtbchZg3twlwY44LmWq+wjTcrDab9gAPwocOwy3lES
        vcN33SulpP+KRh/Pyzr0N4bCk
X-Received: by 2002:a17:906:3150:b0:9ae:696c:2c43 with SMTP id e16-20020a170906315000b009ae696c2c43mr1183240eje.28.1695905154402;
        Thu, 28 Sep 2023 05:45:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQnYwpJz4FRm5OEctCUqntpuOgB3RgSDa5zxu4Q3oNPpnc3WMFQcTzGCzOVBYL6EaWeUHW8A==
X-Received: by 2002:a17:906:3150:b0:9ae:696c:2c43 with SMTP id e16-20020a170906315000b009ae696c2c43mr1183223eje.28.1695905154189;
        Thu, 28 Sep 2023 05:45:54 -0700 (PDT)
Received: from [192.168.1.217] ([109.36.138.103])
        by smtp.gmail.com with ESMTPSA id lw13-20020a170906bccd00b0098884f86e41sm10683387ejb.123.2023.09.28.05.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 05:45:53 -0700 (PDT)
Message-ID: <93be52fc-fa87-423f-dde2-1b0b758ab632@redhat.com>
Date:   Thu, 28 Sep 2023 14:45:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: [PATCH v2 5/5] gpio: acpi: remove acpi_get_and_request_gpiod()
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Scally <djrscally@gmail.com>,
        Mark Gross <markgross@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230926145943.42814-1-brgl@bgdev.pl>
 <e6817d30-b443-1a73-efae-84415604b19f@redhat.com>
In-Reply-To: <e6817d30-b443-1a73-efae-84415604b19f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With no more users, we can remove acpi_get_and_request_gpiod().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Link: https://lore.kernel.org/r/20230926145943.42814-5-brgl@bgdev.pl
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpio/gpiolib-acpi.c   | 28 ----------------------------
 include/linux/gpio/consumer.h |  8 --------
 2 files changed, 36 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 17a86bdd9609..89ff93f3b579 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -158,34 +158,6 @@ static struct gpio_desc *acpi_get_gpiod(char *path, unsigned int pin)
 	return gpiochip_get_desc(chip, pin);
 }
 
-/**
- * acpi_get_and_request_gpiod - Translate ACPI GPIO pin to GPIO descriptor and
- *                              hold a refcount to the GPIO device.
- * @path:      ACPI GPIO controller full path name, (e.g. "\\_SB.GPO1")
- * @pin:       ACPI GPIO pin number (0-based, controller-relative)
- * @label:     Label to pass to gpiod_request()
- *
- * This function is a simple pass-through to acpi_get_gpiod(), except that
- * as it is intended for use outside of the GPIO layer (in a similar fashion to
- * gpiod_get_index() for example) it also holds a reference to the GPIO device.
- */
-struct gpio_desc *acpi_get_and_request_gpiod(char *path, unsigned int pin, char *label)
-{
-	struct gpio_desc *gpio;
-	int ret;
-
-	gpio = acpi_get_gpiod(path, pin);
-	if (IS_ERR(gpio))
-		return gpio;
-
-	ret = gpiod_request(gpio, label);
-	if (ret)
-		return ERR_PTR(ret);
-
-	return gpio;
-}
-EXPORT_SYMBOL_GPL(acpi_get_and_request_gpiod);
-
 static irqreturn_t acpi_gpio_irq_handler(int irq, void *data)
 {
 	struct acpi_gpio_event *event = data;
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 1c4385a00f88..9d1f598b8971 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -614,8 +614,6 @@ void acpi_dev_remove_driver_gpios(struct acpi_device *adev);
 int devm_acpi_dev_add_driver_gpios(struct device *dev,
 				   const struct acpi_gpio_mapping *gpios);
 
-struct gpio_desc *acpi_get_and_request_gpiod(char *path, unsigned int pin, char *label);
-
 #else  /* CONFIG_GPIOLIB && CONFIG_ACPI */
 
 #include <linux/err.h>
@@ -633,12 +631,6 @@ static inline int devm_acpi_dev_add_driver_gpios(struct device *dev,
 	return -ENXIO;
 }
 
-static inline struct gpio_desc *acpi_get_and_request_gpiod(char *path, unsigned int pin,
-							   char *label)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
 #endif /* CONFIG_GPIOLIB && CONFIG_ACPI */
 
 
-- 
2.41.0

