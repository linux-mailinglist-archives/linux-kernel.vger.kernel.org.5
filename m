Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A4F792DDC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239470AbjIESzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjIESzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:55:04 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B82EB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 11:54:32 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bd0d135ca3so48395901fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 11:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693940011; x=1694544811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLtpoodGmmx9hsi2x1jr+x7uccK8YI9bvvMsLPIMWWk=;
        b=IM1y1C5/h9J9OClqPYVGP+jRj/ThPYBREJ/bb6lAFewDjfgn88STmUF4rMVoau2zZZ
         8rByxo81NSnQYJoD/EpnM3qBMPtBtrFv3f/RpbSuVcj77aU5dWtG8u9pAmLbvg9GhRi0
         hUZBnGKZ4ri9mDlY18o4IddGyvGrJtvQCDzcs5KIOcA0ODPKPJxB1cQap2pbkGG7//G0
         LjouH2Ab8tg1aABuo7UKnkLPjluzZrcxQFCoGMgMsb+fFn6IWdve9SYgB+id0GuNMazH
         5+v4e6PeHbTnS+IPzJMLIFov7D+EfCnLObLgiwY+oG4jdTHJtHHemaT03LMqjzMeaGDC
         7g3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693940011; x=1694544811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fLtpoodGmmx9hsi2x1jr+x7uccK8YI9bvvMsLPIMWWk=;
        b=Em+smUTaaFsr1ZmH5D6muOLPDDvlXkntzbZO+nBOWhtABFqhUqQ8I873FyFonWu0Jj
         0oWt/VRwbreQLUKVT+UfyoJ8vYj9g2uxyoY9WlrwNU5kxzQgEyk7o54bowuYFD6olv+q
         mEQ39dq/K0X4Eenma3iflTYgNH1hmobvCnSumw/yJO97DEk9eMEO6Ueuz9EIC/KOirMS
         w5hYvZ4Wy+IaNyQ7HvxPlk20D3I9966sPgTXPN8vWK4XqyPygIIL9jz9Y6ZwYUQVoTQD
         06Nj5eiN1d2Gn9gcXp9QFSHABsXIwhAbB0mS0t637m4UOqxDAT+cJTnjIpuaviWgGz09
         Opwg==
X-Gm-Message-State: AOJu0YxXtFIeLBwau+OG6Cdqw2zk7Ez5XoDRAEOCSktJt3J3XXD7vItR
        nDSCt9kRbWlbUIYf0krEcPSjVQ==
X-Google-Smtp-Source: AGHT+IFpB/13m0/nwakUzQdaNfC4LZV+lJxvCkU4V9X8PY52XKoEKpYjuE+lOSYCuwIRrrXtGPQ9RA==
X-Received: by 2002:a2e:9f04:0:b0:2b9:ecab:d924 with SMTP id u4-20020a2e9f04000000b002b9ecabd924mr463291ljk.18.1693940010976;
        Tue, 05 Sep 2023 11:53:30 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7a54:5dbc:6d09:48b7])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c249100b003fbc30825fbsm17550010wms.39.2023.09.05.11.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 11:53:30 -0700 (PDT)
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
Subject: [PATCH 04/21] gpiolib: provide gpio_device_get_desc()
Date:   Tue,  5 Sep 2023 20:52:52 +0200
Message-Id: <20230905185309.131295-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230905185309.131295-1-brgl@bgdev.pl>
References: <20230905185309.131295-1-brgl@bgdev.pl>
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

Getting the GPIO descriptor directly from the gpio_chip struct is
dangerous as we don't take the reference to the underlying GPIO device.
In order to start working towards removing gpiochip_get_desc(), let's
provide a safer variant that works with an existing reference to struct
gpio_device.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c      | 45 +++++++++++++++++++++++++++----------
 include/linux/gpio/driver.h |  2 ++
 2 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 74b837671d30..4a9af6bfc6d4 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -147,27 +147,48 @@ struct gpio_desc *gpio_to_desc(unsigned gpio)
 }
 EXPORT_SYMBOL_GPL(gpio_to_desc);
 
-/**
- * gpiochip_get_desc - get the GPIO descriptor corresponding to the given
- *                     hardware number for this chip
- * @gc: GPIO chip
- * @hwnum: hardware number of the GPIO for this chip
- *
- * Returns:
- * A pointer to the GPIO descriptor or ``ERR_PTR(-EINVAL)`` if no GPIO exists
- * in the given chip for the specified hardware number.
- */
+/* This function is deprecated and will be removed soon, don't use. */
 struct gpio_desc *gpiochip_get_desc(struct gpio_chip *gc,
 				    unsigned int hwnum)
 {
-	struct gpio_device *gdev = gc->gpiodev;
+	return gpio_device_get_desc(gc->gpiodev, hwnum);
+}
+EXPORT_SYMBOL_GPL(gpiochip_get_desc);
+
+/**
+ * gpio_device_get_desc() - get the GPIO descriptor corresponding to the given
+ *                          hardware number for this GPIO device
+ * @gdev: GPIO device to get the descriptor from
+ * @hwnum: hardware number of the GPIO for this chip
+ *
+ * Returns:
+ * A pointer to the GPIO descriptor or ``ERR_PTR(-EINVAL)`` if no GPIO exists
+ * in the given chip for the specified hardware number or ``ERR_PTR(-ENODEV)``
+ * if the underlying chip already vanished.
+ *
+ * The reference count of struct gpio_device is *NOT* increased like when the
+ * GPIO is being requested for exclusive usage. It's up to the caller to make
+ * sure the GPIO device will stay alive together with the descriptor returned
+ * by this function.
+ */
+struct gpio_desc *
+gpio_device_get_desc(struct gpio_device *gdev, unsigned int hwnum)
+{
+	struct gpio_chip *gc = gdev->chip;
+
+	/*
+	 * FIXME: This will be locked once we protect gdev->chip everywhere
+	 * with SRCU.
+	 */
+	if (!gc)
+		return ERR_PTR(-ENODEV);
 
 	if (hwnum >= gdev->ngpio)
 		return ERR_PTR(-EINVAL);
 
 	return &gdev->descs[hwnum];
 }
-EXPORT_SYMBOL_GPL(gpiochip_get_desc);
+EXPORT_SYMBOL_GPL(gpio_device_get_desc);
 
 /**
  * desc_to_gpio - convert a GPIO descriptor to the integer namespace
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 92f7143bad3e..a769baf3d731 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -766,6 +766,8 @@ struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *gc,
 void gpiochip_free_own_desc(struct gpio_desc *desc);
 
 struct gpio_desc *gpiochip_get_desc(struct gpio_chip *gc, unsigned int hwnum);
+struct gpio_desc *
+gpio_device_get_desc(struct gpio_device *gdev, unsigned int hwnum);
 
 #ifdef CONFIG_GPIOLIB
 
-- 
2.39.2

