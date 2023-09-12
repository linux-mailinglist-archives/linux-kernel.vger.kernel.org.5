Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1510279CD45
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbjILKIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbjILKHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:07:43 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1D5172B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 03:07:39 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31fa15f4cc6so2158413f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 03:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694513257; x=1695118057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ooPiibuin/T1BXM3ci9G/toRB2k62lYI6dDd6XnUFKA=;
        b=JzQ9L+NIMBtxp4S6so12CVzTrS6VMV+PvLooJ2BjBkgHqO1plgvKW8RCbgKEloeGFD
         046DZjmXeH5knUu9bc6eutPrKq0yni51vumVr6ShmB12dLDrWw/MQWZC5vkBNr20ItW/
         DBy00PvwvdN24+s5uxIPwJp0PLfkcByOuT4FFQswwlY/y/ZzRb44/2u0nMMgFUII/hxt
         ACkRhcuQ0bjVj2RKBtnEM/ZYLN/UzbxefyZBSccVGY9MEZronwaft3F6VI9IYd6erjCW
         O6F5FWTIEJI2zKBrpUKG/6QK6+jY8ABAp3BzHUt9fCydufEMWx3OjW00/AemRiE4TOZB
         79LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694513257; x=1695118057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ooPiibuin/T1BXM3ci9G/toRB2k62lYI6dDd6XnUFKA=;
        b=E0/Fze5Vv0MR2dHM4Pj4dJQhopqmZ6OaKZnJnoXLZYhFbOZ9GSZJEZ1EG6+B3CwnOf
         /Zt6kqb8HYGCAnfSoCw7Om7EaYsIM1jcGZJc5ebraD1kAEtv+iA80sR4tYoxs/rzuBTp
         bCXHJv8YyLVMZdftsdLCX7dXAsdmVrYFVuKBKMqWG/1hYOfMbgtPv8QmiPga2bcjwotX
         0JPibTwwNn4Ec1/JWTnd3BI0xo0gjeJaMXDBb/ntu7LkGnlY99VPDmfHE1mEWKzLPZyK
         yBn2si6qRx49Kx7n2sjx0W4Ok/Ul2RHYuTHu195QLKRqZUKXibaDUJBaz50RhIdCV70j
         Fhjw==
X-Gm-Message-State: AOJu0Yy0rDFJ+4013akBf3iFi04HjztH3eaA0fUVwL8ov7ctFihW/wTO
        ZGd2ue0TFjN7xCvQjYAQY6q/fw==
X-Google-Smtp-Source: AGHT+IH6XDJfFYmBXwiNkL8kyXELSWjOJy6fzQulJyqX2CBJnihIyCKZaM/CWTqAl/+JXOsrNEi6LA==
X-Received: by 2002:a5d:560e:0:b0:314:1ebc:6e19 with SMTP id l14-20020a5d560e000000b003141ebc6e19mr9289691wrv.64.1694513257604;
        Tue, 12 Sep 2023 03:07:37 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:907f:4cd7:f0ae:6b2a])
        by smtp.gmail.com with ESMTPSA id h5-20020adfe985000000b0031ae8d86af4sm12351417wrm.103.2023.09.12.03.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 03:07:37 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 02/11] gpiolib: add support for scope-based management to gpio_device
Date:   Tue, 12 Sep 2023 12:07:18 +0200
Message-Id: <20230912100727.23197-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912100727.23197-1-brgl@bgdev.pl>
References: <20230912100727.23197-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 include/linux/gpio/driver.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index a2060dc3344b..a52c6cc5162b 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -609,6 +609,8 @@ struct gpio_chip *gpiochip_find(void *data,
 struct gpio_device *gpio_device_get(struct gpio_device *gdev);
 void gpio_device_put(struct gpio_device *gdev);
 
+DEFINE_FREE(gpio_device_put, struct gpio_device *, if (_T) gpio_device_put(_T));
+
 bool gpiochip_line_is_irq(struct gpio_chip *gc, unsigned int offset);
 int gpiochip_reqres_irq(struct gpio_chip *gc, unsigned int offset);
 void gpiochip_relres_irq(struct gpio_chip *gc, unsigned int offset);
-- 
2.39.2

