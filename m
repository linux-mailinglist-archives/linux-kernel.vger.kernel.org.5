Return-Path: <linux-kernel+bounces-52325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FE18496BD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D084B1C24E3C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32C21B957;
	Mon,  5 Feb 2024 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="EFOnRDkp"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664891802B
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707125687; cv=none; b=GYtyKbXi1AkRalecbGtja8xdMKqxmGHHdY3gUfpHR432wiaLl7C7enDVbSgIYredRrXdpK0umP9Yz4bXAAvDjhQLLaUHAhFwbi7RUv8aaRp3ORvXn3MKOdrvvlvYAWn+PhwwQrbVA4A4E+b6Uc+mXAJA5AG43PyPyK2oZNiqcHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707125687; c=relaxed/simple;
	bh=7mJd5R2FfiEUg4aI1+D/j4yKbEfikBS+gEjl/iwhNCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DJ+qBSU2M0uZZxrO1XGYbgapscZKtds2BDTMhEU1QMyQcowLxrSbkHdAzy/g6K37UWRaOnufoLj0yrvyhmqL0Bb/ZyR4/oa26cKadxty9vAmjpgTrN5bSxVMowP7FyF4Zj4AOnBSNM+6vJxPzwKvDcflIjHHnlB4enShSbRdG7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=EFOnRDkp; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-511490772f6so1392324e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 01:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707125683; x=1707730483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfCUtQSab/f+GEUcOlTEQIAjO6ADTWtbYYTnCznFDE8=;
        b=EFOnRDkp0AzyqNzWQHSJTgd0l2m0EZwSGebIvXeU0SQS/fsB0MV3tv1XH7eZbmeT1S
         6G6WUJKUmjUwfNh5E6uyZVnpbsg8mSomtUUZNMfjD4CZtZmgFhmIy/ZZV04KjYxDEfrJ
         v/VKFv3wpZIUAhxyILlfiayI2Kj3/xSkBvQ2u976iThf7XEsgNyQL2H82hGW5RAAccui
         IwkcqBsBWDyU4Iwftqb77vvNB/qg7qF+Tud8OTunSamKhNKSZI+KKNeHBpgHNf0FDOwI
         SeTFxuLW9IMMjrHzEdZfZc+wVM3wQYm7iU57gDaNGhZ3KULvhN7WELTX9GJL4gUpInud
         1VuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707125683; x=1707730483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfCUtQSab/f+GEUcOlTEQIAjO6ADTWtbYYTnCznFDE8=;
        b=HDPRbzjGcricz6aDNhySDpr3u8yVyqdhsseDIIpjbC0XlwrRVLVxYUNP1Gogh65i5/
         yExntzsV73TbWTU3/uSDUpMpw8DeulJAGpwh4uP1wDkzCFkS6NquwoDbnvLWkbTuClxF
         Cund1n0aBJOScj7B93eTeW2QUph/03ff+dmlvqF1TJATOwufVtvZLhcnGcT9+s1zqH9p
         p+mVTTnjl5VyhnsCuybtAh7iBsdJ1/JvnG4T/E49UsM/+N6+6ibIFgBYZD5exvcRqt/0
         WwcJc4qJ5woLxC7S5sF+3yrtJifkY3kh9sG9IXLQ0tdLRSE0hrzrtFAqJqjjJ9hlvka3
         uhIQ==
X-Gm-Message-State: AOJu0Yw+mYsNBrp/3YFsmb+c0QlG/lxqJaPQuvGcCLwWljwrdDpUGXtA
	PlKKLyUvmCy0sCqfribW4kKqeFHZikedRIR+PJw++m9wJPnlX1LBwrD2xjEId2I=
X-Google-Smtp-Source: AGHT+IGbzkspZ2OxUbf5+9mtQYHG+0DglASi8UuDhWIORLHqIuJm4X1N/9W/AZO7TglbOMxo/nZ8Cw==
X-Received: by 2002:a05:6512:3b27:b0:511:2e7c:768f with SMTP id f39-20020a0565123b2700b005112e7c768fmr9577478lfv.46.1707125683608;
        Mon, 05 Feb 2024 01:34:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU40ycQ2gHSQqNLzlj+wixA3sX46WZJeEInwacBub0YUBh0qHj392LloTrzZIyWuLx667WiMDnJRNeTuP623WmzduvSr04AQZqLrZCkoB3AX5UAloP49CHvarI5HWcXvoYbWXPj2xIYdLPIekKoHs411woSyIg0B5WWKqO2OrmkRScRLnjkDBKJYdBINEhy/jf8QFsFWsRw7RLcMPM2b99dUjtU3zLHxrC8OuRF1lSEREI5QLQnG3GJvSL6luR99Thwo11m/SbBCroaL+2LXs0eyNNwi4BH9alZYSA5kVsQ8zP7TEfm/gebww/JNVS7pkxOHYyrOWHqIjyfpqzrXsRKute8BGH/Eg==
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d929:10db:5b5c:b49d])
        by smtp.gmail.com with ESMTPSA id f15-20020a05600c154f00b0040fc771c864sm7980397wmg.14.2024.02.05.01.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 01:34:43 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>,
	Alex Elder <elder@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Wolfram Sang <wsa@the-dreams.de>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 20/23] gpio: add SRCU infrastructure to struct gpio_device
Date: Mon,  5 Feb 2024 10:34:15 +0100
Message-Id: <20240205093418.39755-21-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240205093418.39755-1-brgl@bgdev.pl>
References: <20240205093418.39755-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add the SRCU struct to GPIO device. It will be used to serialize access
to the GPIO chip pointer. Initialize and clean it up where applicable.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib.c | 13 ++++++++++---
 drivers/gpio/gpiolib.h |  2 ++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 2f78fa9f8dbf..c49d7a156bdd 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -680,6 +680,7 @@ static void gpiodev_release(struct device *dev)
 	ida_free(&gpio_ida, gdev->id);
 	kfree_const(gdev->label);
 	kfree(gdev->descs);
+	cleanup_srcu_struct(&gdev->srcu);
 	kfree(gdev);
 }
 
@@ -943,6 +944,10 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->device_notifier);
 	init_rwsem(&gdev->sem);
 
+	ret = init_srcu_struct(&gdev->srcu);
+	if (ret)
+		goto err_remove_from_list;
+
 #ifdef CONFIG_PINCTRL
 	INIT_LIST_HEAD(&gdev->pin_ranges);
 #endif
@@ -950,15 +955,15 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	if (gc->names) {
 		ret = gpiochip_set_desc_names(gc);
 		if (ret)
-			goto err_remove_from_list;
+			goto err_cleanup_gdev_srcu;
 	}
 	ret = gpiochip_set_names(gc);
 	if (ret)
-		goto err_remove_from_list;
+		goto err_cleanup_gdev_srcu;
 
 	ret = gpiochip_init_valid_mask(gc);
 	if (ret)
-		goto err_remove_from_list;
+		goto err_cleanup_gdev_srcu;
 
 	ret = of_gpiochip_add(gc);
 	if (ret)
@@ -1038,6 +1043,8 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 		gpio_device_put(gdev);
 		goto err_print_message;
 	}
+err_cleanup_gdev_srcu:
+	cleanup_srcu_struct(&gdev->srcu);
 err_remove_from_list:
 	scoped_guard(mutex, &gpio_devices_lock)
 		list_del_rcu(&gdev->list);
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 43ff4931e2c3..35d71e30c546 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -49,6 +49,7 @@
  * @sem: protects the structure from a NULL-pointer dereference of @chip by
  *       user-space operations when the device gets unregistered during
  *       a hot-unplug event
+ * @srcu: protects the pointer to the underlying GPIO chip
  * @pin_ranges: range of pins served by the GPIO driver
  *
  * This state container holds most of the runtime variable data
@@ -73,6 +74,7 @@ struct gpio_device {
 	struct blocking_notifier_head line_state_notifier;
 	struct blocking_notifier_head device_notifier;
 	struct rw_semaphore	sem;
+	struct srcu_struct	srcu;
 
 #ifdef CONFIG_PINCTRL
 	/*
-- 
2.40.1


