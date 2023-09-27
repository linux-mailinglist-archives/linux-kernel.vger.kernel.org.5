Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4034D7B06C8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 16:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjI0O3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 10:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjI0O3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:29:39 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98681193
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 07:29:38 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-405417465aaso103913715e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 07:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695824977; x=1696429777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrpKHVqqTjrma0ET7OV7WLFI0tFo3wgKkZ5ACtzRvkE=;
        b=nmzlb36S3PRwkaDm7sCBLiyf9gzPtuYW5+71NYnSTODLPEkvxqD6eFEDjzLV/BhDEC
         ZZ3HJgr/KtREJEjzG/QfVqlti7zgG5zq2NwUZX2tH2VT3DpYf4IbeepDRN8b+vHzCKLB
         x2XB/rWcW48Sg7zVcYZuZdcbPLOulbTGmjvLRr5Nnzg1MI+0lxf8mQHd1m6Pbb7eBrad
         javetCA1nJuUJuTfqd+OLM9wXAiKFJwMBUT45iq9uHWeaXR17ko5Y44xEmdIQ0ktRnlD
         a4jeje0kXF50jGUabgvIbPB06qJ7HQ1SjN6erZPzou/YeS1CqjfzTO2jEXGtIdQzgOWF
         MCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695824977; x=1696429777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zrpKHVqqTjrma0ET7OV7WLFI0tFo3wgKkZ5ACtzRvkE=;
        b=amtyUfqbFtHk2dBS1Uoz6dEuq3JuVvvVDXg19Ycr0IgxjQ3VCGXSioinIHyBezf61U
         Lhs8g33T6mewlPXCDHEAFpQfjnVCdP0Rjcxi27x4lioDtWp7IhkrVy24SPkdemnS8xSj
         GSbe+sXTm7LNSnLcfZGRpM2zplgyx3MiXJlREB0qOtymDiIMS9U1BVS0r1b3MfMoPaQE
         7Apv2JJcNLNXVudpvptZYEl1O2rEyQ+Z5g8XTY/CAeJkWJg2/7ojN7i3eDPHmiZ80xY7
         5bTehbZTNcRcFeU9JyBmQ45/rXaHk0Ak7lX3CsqvOmg1z+uLUKt+kMZ2viI8Z+MwBoGq
         PH2g==
X-Gm-Message-State: AOJu0Yw6VM/zNH55i6EcSUh2RMxf4j+7dmDNwwu9bchZMYkKBHSsvUBi
        tkd9Dq87+F3VtdieZiSYdl12ZCeFinUZInZrX1k=
X-Google-Smtp-Source: AGHT+IF6eg+w62/RXPj0sQUskg5id/X4SSijgtC05ghaPIfi6qFHp0AB4DGHIGyu0H2TgbfYmlDZfQ==
X-Received: by 2002:a05:600c:21d4:b0:405:34e4:e756 with SMTP id x20-20020a05600c21d400b0040534e4e756mr2081697wmj.36.1695824977012;
        Wed, 27 Sep 2023 07:29:37 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4bb6:1525:9e22:4a15])
        by smtp.gmail.com with ESMTPSA id v2-20020a1cf702000000b003feae747ff2sm20448303wmh.35.2023.09.27.07.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 07:29:36 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 02/11] gpiolib: add support for scope-based management to gpio_device
Date:   Wed, 27 Sep 2023 16:29:22 +0200
Message-Id: <20230927142931.19798-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230927142931.19798-1-brgl@bgdev.pl>
References: <20230927142931.19798-1-brgl@bgdev.pl>
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

As the few users that need to get the reference to the GPIO device often
release it right after inspecting its properties, let's add support for
the automatic reference release to struct gpio_device.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/linux/gpio/driver.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index a2060dc3344b..1cedbc3d3200 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -3,6 +3,8 @@
 #define __LINUX_GPIO_DRIVER_H
 
 #include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/err.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/irqhandler.h>
@@ -609,6 +611,9 @@ struct gpio_chip *gpiochip_find(void *data,
 struct gpio_device *gpio_device_get(struct gpio_device *gdev);
 void gpio_device_put(struct gpio_device *gdev);
 
+DEFINE_FREE(gpio_device_put, struct gpio_device *,
+	    if (IS_ERR_OR_NULL(_T)) gpio_device_put(_T));
+
 bool gpiochip_line_is_irq(struct gpio_chip *gc, unsigned int offset);
 int gpiochip_reqres_irq(struct gpio_chip *gc, unsigned int offset);
 void gpiochip_relres_irq(struct gpio_chip *gc, unsigned int offset);
-- 
2.39.2

