Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B987EC903
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjKOQuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjKOQuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:50:09 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB0519F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:50:05 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-77bcbc14899so338490785a.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1700067005; x=1700671805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vc2uuTZzlGTGKEpxHmVUvwPiBGhZ61eMxIga50Is5Fw=;
        b=XkuusTBHn8B2hnTOerw4/6xlZ9ZWIUFmQ1oKhS1SW9ZDRGpHrhhn4uZ0uNT8qqIPYe
         oDSFpAQTP9qlq4NXMxzXHCUC9gvHVbUSW9hBAO/SkvdAAFi/5fF8gk9tM+E9knrT9Nd4
         ju62hBBll4lyXxs+13o1+IOUQTA8tuGVrXKXm2W3whWF2OdyxSUMCLahGnB5CfyqgdbB
         Q+T20NGEuVBEsbihPPsjIJhHLg82orZiEDlFmuL6BD7ZMdOqjGU6/6zSdo3+wfgnrAJM
         o9v4y211rCxztIA0vD4qSHw2k1iRciUrkp5OQRv28H25pfn+rq4lnLqepo5lPC/Btfmx
         mvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700067005; x=1700671805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vc2uuTZzlGTGKEpxHmVUvwPiBGhZ61eMxIga50Is5Fw=;
        b=kk8WjCXljgtRs9atKItZzvCwJqvrJbAC8ner4Z/RvVS7YihsCbmz1XAIz9OUmN+Vo2
         4qVGN/MBWqd8mPNZcE7dA4dT00duZCfIzsXbB8QPF2F311gi2x0jeT1cm/gyrd4J21SV
         VjlqGbBEy32nYeEQjFAqvUphJkZRjolJRybQCg6JkViT2uy2lvdjvHAEEtGIY6wK+0t/
         c4TpmrLpOBH5UwF3iWYAJsmqH+OXUY8EpB+fXsMavYZv08hxkjp6HaCWcmBOuqd/UkU5
         iYs58oeiV++EPXmiqpRahEsUsIzFx7F9Me3sFHkzOBaxqXz33+9m7OyO3eMZQRIM279J
         UhRA==
X-Gm-Message-State: AOJu0Yzk6WOcr1lQrAX7hsWqKrxJhwwEQgG8hArwfIhariA5XMrGSgTo
        LeeYA5iZAJqRDefg996EnAjinQ==
X-Google-Smtp-Source: AGHT+IFz4DMZPFCc0axXCLers6mb90y64kt+KnZAZ09JG9DWqdGGF4MW6AF1dSPrKb6dRAw/PuIyvg==
X-Received: by 2002:a05:6214:4104:b0:65d:4840:6eb4 with SMTP id kc4-20020a056214410400b0065d48406eb4mr7154624qvb.6.1700067004848;
        Wed, 15 Nov 2023 08:50:04 -0800 (PST)
Received: from brgl-uxlite.. ([12.186.190.1])
        by smtp.gmail.com with ESMTPSA id mn16-20020a0562145ed000b00670a8921170sm658781qvb.112.2023.11.15.08.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 08:50:04 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/3] gpiolib: provide gpio_devie_get_label()
Date:   Wed, 15 Nov 2023 17:49:59 +0100
Message-Id: <20231115165001.2932350-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231115165001.2932350-1-brgl@bgdev.pl>
References: <20231115165001.2932350-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Provide a getter for the GPIO device label string so that users don't
have to dereference struct gpio_chip directly.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c      | 14 ++++++++++++++
 include/linux/gpio/driver.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 95d2a7b2ea3e..a5faaea6915d 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -254,6 +254,20 @@ int gpio_device_get_base(struct gpio_device *gdev)
 }
 EXPORT_SYMBOL_GPL(gpio_device_get_base);
 
+/**
+ * gpio_device_get_label() - Get the label of this GPIO device
+ * @gdev: GPIO device
+ *
+ * Returns:
+ * Pointer to the string containing the GPIO device label. The string's
+ * lifetime is tied to that of the underlying GPIO device.
+ */
+const char *gpio_device_get_label(struct gpio_device *gdev)
+{
+	return gdev->label;
+}
+EXPORT_SYMBOL(gpio_device_get_label);
+
 /**
  * gpio_device_get_chip() - Get the gpio_chip implementation of this GPIO device
  * @gdev: GPIO device
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 0aed62f0c633..100c329dc986 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -786,6 +786,7 @@ struct gpio_device *gpiod_to_gpio_device(struct gpio_desc *desc);
 
 /* struct gpio_device getters */
 int gpio_device_get_base(struct gpio_device *gdev);
+const char *gpio_device_get_label(struct gpio_device *gdev);
 
 #else /* CONFIG_GPIOLIB */
 
-- 
2.40.1

