Return-Path: <linux-kernel+bounces-57810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD11984DDA5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 543A8B24E81
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D63762F0;
	Thu,  8 Feb 2024 09:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="tXSp842q"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA1A7691A
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386391; cv=none; b=UDqzqzSiUEC9D2rnu9T1s4rEy8nn15ikMaPf2Ms3JFjt79vI4/78ey7WkA1TQ8eBR0A7m8WVlHlzEriKv3bPxGCimB8VOWBZTBPEms9Q7s2P1jJkqnTJjIU0gWydzRCfkwX/FgSoLbNV26mWIr442kgAMnZCOwixKkQOwGs6DfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386391; c=relaxed/simple;
	bh=ix1NDNjlZCgQ+AyPAHUAD23avjxqKqI95b0uzY3jkfo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RvkBIlVwtpifQs+9+RwQPwcr3U5adRJ5mQzEAUbyEgtVREWDzF39d4ccvTJWjXHIEGHR/kIvImEd1fCaIcoLWIeuS6dpUwHidXqOMiYhTsGOYhbXQJQsQHTAlIByPOQnCtxQIb4FRp/389juZYhH10+3kATpaMVBQ7ghaw2J1CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=tXSp842q; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51171c9f4c0so149512e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 01:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707386387; x=1707991187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miEDCzzmUK7ZFiY500smqwcP1l0x+JqtxelPsuadET4=;
        b=tXSp842qD9Pz+jkpwOWfJkue+qMBR/rEaClQUoLEuU5gJ71adSj9UUJq3TMANRIOxY
         fKNqag9BENGfbPM/dyjOsePEzKNlcDuyUw22Gx5kqpOtUrV9wNgxudi5Yb6xRM4/W+yJ
         +R9xKxeXTCNZeFKE+JqFSkz6xWxxo1YRYUsoOc4jgHJN9Tzh1ElVUo56TT1F00815tsi
         DEMS7+8PSLrphN2JOvjTQN8/5YxuKctFKODip42Aihu+a+Ro/FnylPtajk2LyU7AqOFI
         mStAK2FpT041kNQPGVK7Hdf38EztMcE88qgGPywnkZt3li9xjOWi0o13y1ucv5G9ocx9
         BXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707386387; x=1707991187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miEDCzzmUK7ZFiY500smqwcP1l0x+JqtxelPsuadET4=;
        b=e2WuYoXLgmfTWoKYovWPZQQxnGhqsWlckou6Ru67c4WglmkUMSaON3ZSqQAygm5HIl
         Jkz7ZrzKeIyZZIVti4CLfCaXLaHBJfL7eVRczk2dazLOOTzYFa/8vUhMU9v9P5k1K6vs
         gl5ggdn8z9pF+qlq3Z2eGvaKvlg/frQ+DE40MSbNNqu2ktJs7PmhQGIEYevNykb1qdkm
         JZjtiM7zYhHk0MRiQ5TwkMl44oPg7skIRKAgPnqbTuXdwVpKK5gXtayf+f6i650KTZht
         2LBCF1KqRbBTMH5CJwLVRCS130zjEXnwo5OfPLuT1n4Y3MGiPwhvGK2Sj+jRcD5OnhKV
         zcZQ==
X-Gm-Message-State: AOJu0Yzs3sItvF/y5gydZoEGfw8D6Xo6QTbs5c7VZU6w+6NB8WRERtML
	Nkn4IQ6fCWS0lVw2TbV9muculkcr7n8zacgcauL8Ii/x5YTel4leojA17XvIEiI=
X-Google-Smtp-Source: AGHT+IEdpn6LGQp8OBAFzoOjlSEX9Ftw8yJ2XbLP1JUnK7lkUl5Y5jb8ffeZO4cAFqabnXqCUjG7fg==
X-Received: by 2002:a05:6512:684:b0:511:62f5:9068 with SMTP id t4-20020a056512068400b0051162f59068mr4182575lfe.11.1707386387052;
        Thu, 08 Feb 2024 01:59:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWlasTr89EWG4MCypFP9JeKiFH4l+rVCnhBP8Uo4QVe68AxuApbgrgW9oW3GoWVf+5jPSkyRN7ulizA1N4OppzGlNkotGDWwR/XZd+JjJn8gGtZjf2A1Zh4DLokunxBbft2LRdhcMHryl67aBjshmGtpSxhBKfCSAJ+j0811gHTMqqwakknQWjNl8e1nz6N2KBOo/v1uorgrarthg2vKVxIfektlpDMxESFKooB9I6HLCqV/XN0Z9ZxyQxBjfHQd18sOGnDOv0Ng8JdsoujCNfY5ujCfH95F6EFiU397n05myztc5c7Pl0akzZLoL9oFBBjWntMQHYQcZz9LJ8ykg6RmI3gDr9LjA==
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:44bd:e160:131:19a4])
        by smtp.gmail.com with ESMTPSA id x17-20020a5d60d1000000b0033af5086c2dsm3265963wrt.58.2024.02.08.01.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 01:59:46 -0800 (PST)
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
Subject: [PATCH v3 21/24] gpio: add SRCU infrastructure to struct gpio_device
Date: Thu,  8 Feb 2024 10:59:17 +0100
Message-Id: <20240208095920.8035-22-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240208095920.8035-1-brgl@bgdev.pl>
References: <20240208095920.8035-1-brgl@bgdev.pl>
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
index 6b696087c7f5..9b1907f3e400 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -680,6 +680,7 @@ static void gpiodev_release(struct device *dev)
 	ida_free(&gpio_ida, gdev->id);
 	kfree_const(gdev->label);
 	kfree(gdev->descs);
+	cleanup_srcu_struct(&gdev->srcu);
 	kfree(gdev);
 }
 
@@ -948,6 +949,10 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->device_notifier);
 	init_rwsem(&gdev->sem);
 
+	ret = init_srcu_struct(&gdev->srcu);
+	if (ret)
+		goto err_remove_from_list;
+
 #ifdef CONFIG_PINCTRL
 	INIT_LIST_HEAD(&gdev->pin_ranges);
 #endif
@@ -955,15 +960,15 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
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
@@ -1043,6 +1048,8 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
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


