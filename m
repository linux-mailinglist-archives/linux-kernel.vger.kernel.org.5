Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258E879CD50
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbjILKIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbjILKHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:07:47 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5464C10DC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 03:07:43 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-307d20548adso5486290f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 03:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694513262; x=1695118062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lK3han4CVz5LHUOmuD0tfQkarnpldPL2EDThSOp4uoo=;
        b=hKkpj9ebeywUDPpZfqGwEIXFBQG+IhXqeLEzQJ9UHbyxA+lMwhhFu56ute+bcz9UFy
         7TcTbGdAlXpHOjFqRn95P/fTqi7YqHot1pScejxHLqoEa9VrPINyM7SIiSESr2cUwYjQ
         UNgIBM/P9BwBFa5IJyAaEAUbx5ae4dQrYCKDPzMl0/b5IkijYDqJMWzISZmpXq6xZph7
         AHoegF2nXvUvs7kVPfHqEuVsElkLKDkmvUf7EuJPdotUqYOQAD75WmlxP2h1MSvmuuRU
         9LNnX4ejEWkf/Tu3uDxtI4YQp7zb2H8pzc4yVa3cCps3iOmKTbAqaGPcTk/+wrdpnn/D
         4phg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694513262; x=1695118062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lK3han4CVz5LHUOmuD0tfQkarnpldPL2EDThSOp4uoo=;
        b=HW8w7pAL25vmFEiLJB+R0RUuIQeDKZUcAEEIQl5jfzyFmKFLYbli90wKU6vVgXMNJT
         9koCd4TaDmsG4F2CQrKD+8LpjGKrBSrG/kht6Bn3c0zEnUl0KJfmgpM704FnFFtXF54y
         J9rwpBOMmThl85s4vVMsWLJsgfJReF6Uvqq4vyXGI0HKA1Uq+j1choHhVn2XcRtgfDOd
         6PgJavA6lsiDJ/8Q53gIwODSjHQ0hlQLVlUAt1QQxw3sVxsdxQxGK9Z2DX47leX9cXGn
         7779amzaa1bonI6aFUR/zHIMEqeY4goaXvN8/hRhBpcTvOhloQpHS1A2GlMjzi05eR1L
         Nofg==
X-Gm-Message-State: AOJu0YxBpCgPjyXjhbNYheRBe8pyZMwG4ALGvJEMRTiQqIvLIgQr5Csd
        tc9ANORmExvVuxcCWYHvwBcDJlUS8nLjGeOlE1U=
X-Google-Smtp-Source: AGHT+IHQaoqjxtbbCR/GgutlU02aJZq/Tzbxpk5PviNsqzIRCPSQARYZbf/TjHfrpO4UdF1ds2ob1Q==
X-Received: by 2002:a5d:4ac3:0:b0:317:6cc7:6b21 with SMTP id y3-20020a5d4ac3000000b003176cc76b21mr9864728wrs.69.1694513261863;
        Tue, 12 Sep 2023 03:07:41 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:907f:4cd7:f0ae:6b2a])
        by smtp.gmail.com with ESMTPSA id h5-20020adfe985000000b0031ae8d86af4sm12351417wrm.103.2023.09.12.03.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 03:07:41 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 07/11] gpiolib: replace find_chip_by_name() with gpio_device_find_by_label()
Date:   Tue, 12 Sep 2023 12:07:23 +0200
Message-Id: <20230912100727.23197-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912100727.23197-1-brgl@bgdev.pl>
References: <20230912100727.23197-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Remove all remaining uses of find_chip_by_name() (and subsequently:
gpiochip_find()) from gpiolib.c and use the new
gpio_device_find_by_label() instead.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 224e0d330009..a10d1d663524 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1144,18 +1144,6 @@ struct gpio_device *gpio_device_find_by_label(const char *label)
 }
 EXPORT_SYMBOL_GPL(gpio_device_find_by_label);
 
-static int gpiochip_match_name(struct gpio_chip *gc, void *data)
-{
-	const char *name = data;
-
-	return !strcmp(gc->label, name);
-}
-
-static struct gpio_chip *find_chip_by_name(const char *name)
-{
-	return gpiochip_find((void *)name, gpiochip_match_name);
-}
-
 /**
  * gpio_device_get() - Increase the reference count of this GPIO device
  * @gdev: GPIO device to increase the refcount for
@@ -3907,21 +3895,22 @@ EXPORT_SYMBOL_GPL(gpiod_remove_lookup_table);
  */
 void gpiod_add_hogs(struct gpiod_hog *hogs)
 {
-	struct gpio_chip *gc;
 	struct gpiod_hog *hog;
 
 	mutex_lock(&gpio_machine_hogs_mutex);
 
 	for (hog = &hogs[0]; hog->chip_label; hog++) {
+		struct gpio_device *gdev __free(gpio_device_put) = NULL;
+
 		list_add_tail(&hog->list, &gpio_machine_hogs);
 
 		/*
 		 * The chip may have been registered earlier, so check if it
 		 * exists and, if so, try to hog the line now.
 		 */
-		gc = find_chip_by_name(hog->chip_label);
-		if (gc)
-			gpiochip_machine_hog(gc, hog);
+		gdev = gpio_device_find_by_label(hog->chip_label);
+		if (gdev)
+			gpiochip_machine_hog(gpio_device_get_chip(gdev), hog);
 	}
 
 	mutex_unlock(&gpio_machine_hogs_mutex);
@@ -3976,13 +3965,16 @@ static struct gpio_desc *gpiod_find(struct device *dev, const char *con_id,
 	struct gpio_desc *desc = ERR_PTR(-ENOENT);
 	struct gpiod_lookup_table *table;
 	struct gpiod_lookup *p;
+	struct gpio_chip *gc;
 
 	table = gpiod_find_lookup_table(dev);
 	if (!table)
 		return desc;
 
 	for (p = &table->table[0]; p->key; p++) {
-		struct gpio_chip *gc;
+		struct gpio_device *gdev __free(gpio_device_put) = NULL;
+
+		gc = gpio_device_get_chip(gdev);
 
 		/* idx must always match exactly */
 		if (p->idx != idx)
@@ -4004,9 +3996,8 @@ static struct gpio_desc *gpiod_find(struct device *dev, const char *con_id,
 			return ERR_PTR(-EPROBE_DEFER);
 		}
 
-		gc = find_chip_by_name(p->key);
-
-		if (!gc) {
+		gdev = gpio_device_find_by_label(p->key);
+		if (!gdev) {
 			/*
 			 * As the lookup table indicates a chip with
 			 * p->key should exist, assume it may
@@ -4022,7 +4013,7 @@ static struct gpio_desc *gpiod_find(struct device *dev, const char *con_id,
 		if (gc->ngpio <= p->chip_hwnum) {
 			dev_err(dev,
 				"requested GPIO %u (%u) is out of range [0..%u] for chip %s\n",
-				idx, p->chip_hwnum, gc->ngpio - 1,
+				idx, p->chip_hwnum, gdev->chip->ngpio - 1,
 				gc->label);
 			return ERR_PTR(-EINVAL);
 		}
-- 
2.39.2

