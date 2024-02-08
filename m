Return-Path: <linux-kernel+bounces-57811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAE684DDA8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B0CD28B402
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D502379DDA;
	Thu,  8 Feb 2024 09:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="gB1MT/Ge"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468AE78B4A
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386393; cv=none; b=WCtPaB7a9KXxREmOKcdLNn1nHXb8AxHf7DuAy/pftw7Uca78tvsA8szUWTJb3GOkIIpZ9xm4FprMUJ1p8O4OJ4dvINBy64Iy0pGWHJlj0cLOf/pfeHqoztoe/2MoTdKkkEl9+akji8XdBMeNhKRrl2DA2OR121Ex+vleUcj5zUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386393; c=relaxed/simple;
	bh=KjuEOV2DTy6W3rRBoC+IRpehjM/uvenxd3UaC9zFfmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c39YsIV3e2GHFR2BDxPKgI0Lu6CujHJLQ1E3UxdUN9+abxrV+8BD0E2v58dpt0NuKfrg1PCbpAz/mmZTMrsMvU8C7OQXluD4aYu/9nRpP2mMIwNXRphEv6SlLUYk8gxSVLxA1XdMliWKtNPoNT69rBQLVqHWuUmbmqz0uGpJb5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=gB1MT/Ge; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51168572090so2654511e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 01:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707386389; x=1707991189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TyblqrzdktkrOu3Ks/tkxPwfRHlxiz4guYvygTG0Ma4=;
        b=gB1MT/GeiQabI6+7pb7AJk5rqr5su0AfjqN2cPVKAlFTiWh5a4rzl4l39UoSJ10uVM
         xBtfbKo30B7ZimPotL/v+pIiq1c44EWz3ORDGipHqgz42/c9TksilH5VF+8W0HO1LTwq
         8e/8xLuzkntBzDJjPlSusPHv+19BFKQI/1FTS8Bp3oWjtMn1UUzYeIca4mLTzpz5wJT8
         Jl+Iz2bcAieAKv7nJecXvKcEfi9xPrq0VfCPhzgJXC88mjO1CZjYuMEtP9g+htKRLMwX
         JIAxqLnO5GQDWoq0TwPx70VQBJvthytc1ohsNhsFbljPpa3uMGB3S44yoCorrfVJkvNI
         teUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707386389; x=1707991189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TyblqrzdktkrOu3Ks/tkxPwfRHlxiz4guYvygTG0Ma4=;
        b=Dx9lA1y5XZTpAToA6mA7mdM+MXIzR34jZPMBj+ekU3sc8mV1He0/owYRKvXnTAKDq1
         nRJN1JiqOMez0HE0UPdW/80sggqDq+FP0dmVND0ZRSoGJPsjr7dxyWlhRxLDej3GyZaY
         Xfqeu5FLMQKJK1zV+IpKT18JFbmSfXHqb01UfDOADATaZmPvZw5pd3zbScHQCFexcdB2
         EeRNepZzPo92raErIpzSuCohMLB8fyqDQXa3gMDiQOdsxe/nbXhZm9IZPsaiPu4By2mh
         hTYnInJvqig06I4ObQbNdxHibMSzxSUp3m1cPg+RXDKh/Zh9RubcKTPQJJ599XXZbevU
         9vLw==
X-Gm-Message-State: AOJu0Yy7wFhlH9/RihDIDfope5rx4+5k+i+WBlRMvmvNj/FM5VYgG/MO
	7DBqxsJ7fYK87y1sSjBN0o+7V5v7JVRrnEXLbaWau0/ufJ3EvVRTx1JSyixFI24=
X-Google-Smtp-Source: AGHT+IE5JZEvxwuTlIj46DsBROoKNidH+KSkPjumTYTmU5HAW4otdlZg4czZ9z2qqNHjOm/5r+QY8Q==
X-Received: by 2002:ac2:4116:0:b0:511:617a:3130 with SMTP id b22-20020ac24116000000b00511617a3130mr3899511lfi.35.1707386389457;
        Thu, 08 Feb 2024 01:59:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWsJjPanROTA8lPm9oZXRbP9FFnvouA8CoVl+/rKHJjV6K7cqHDtuwMWoZ8WJN5qNPdUiMtI7cphUZN4erNsfA8iOFd2JVopKNPJPy1hJ85KbG+TVvp51fRlMv0qfufl7o+krP55N39IKQaQtmXSXxPkjayigSZQjpag9vINi3JIV/4kpGbTxqO1cMLuM1en8W6EaUCfuvvcbx0xTonazyB+5W1Rp++ZqQckNqWAftT7zrbmib2Qknh2pgw0Dx5HPKG0t4HgPROsDefVKlzzDnmmuzwAVOiTQNxIQzzsMnmuVeSp+nKDzHxqhYt3ZzZxiGlm2jNrNQbXHJP4FJGXZwnIM0l9Asj9w==
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:44bd:e160:131:19a4])
        by smtp.gmail.com with ESMTPSA id x17-20020a5d60d1000000b0033af5086c2dsm3265963wrt.58.2024.02.08.01.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 01:59:48 -0800 (PST)
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
Subject: [PATCH v3 23/24] gpio: remove the RW semaphore from the GPIO device
Date: Thu,  8 Feb 2024 10:59:19 +0100
Message-Id: <20240208095920.8035-24-brgl@bgdev.pl>
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

With all accesses to gdev->chip being protected with SRCU, we can now
remove the RW-semaphore specific to the character device which
fullfilled the same role up to this point.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib-cdev.c | 1 -
 drivers/gpio/gpiolib.c      | 4 ----
 drivers/gpio/gpiolib.h      | 5 -----
 3 files changed, 10 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index ccdeed013f6b..9323b357df43 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -24,7 +24,6 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/poll.h>
 #include <linux/rbtree.h>
-#include <linux/rwsem.h>
 #include <linux/seq_file.h>
 #include <linux/spinlock.h>
 #include <linux/timekeeping.h>
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index a14717a3e222..97829f0c8487 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -963,7 +963,6 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 
 	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->line_state_notifier);
 	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->device_notifier);
-	init_rwsem(&gdev->sem);
 
 	ret = init_srcu_struct(&gdev->srcu);
 	if (ret)
@@ -1102,8 +1101,6 @@ void gpiochip_remove(struct gpio_chip *gc)
 	struct gpio_device *gdev = gc->gpiodev;
 	unsigned int i;
 
-	down_write(&gdev->sem);
-
 	/* FIXME: should the legacy sysfs handling be moved to gpio_device? */
 	gpiochip_sysfs_unregister(gdev);
 	gpiochip_free_hogs(gc);
@@ -1142,7 +1139,6 @@ void gpiochip_remove(struct gpio_chip *gc)
 	 * gone.
 	 */
 	gcdev_unregister(gdev);
-	up_write(&gdev->sem);
 	gpio_device_put(gdev);
 }
 EXPORT_SYMBOL_GPL(gpiochip_remove);
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index b3810f7d286a..07443d26cbca 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -16,7 +16,6 @@
 #include <linux/gpio/driver.h>
 #include <linux/module.h>
 #include <linux/notifier.h>
-#include <linux/rwsem.h>
 #include <linux/srcu.h>
 
 #define GPIOCHIP_NAME	"gpiochip"
@@ -46,9 +45,6 @@
  *                       requested, released or reconfigured
  * @device_notifier: used to notify character device wait queues about the GPIO
  *                   device being unregistered
- * @sem: protects the structure from a NULL-pointer dereference of @chip by
- *       user-space operations when the device gets unregistered during
- *       a hot-unplug event
  * @srcu: protects the pointer to the underlying GPIO chip
  * @pin_ranges: range of pins served by the GPIO driver
  *
@@ -73,7 +69,6 @@ struct gpio_device {
 	struct list_head        list;
 	struct blocking_notifier_head line_state_notifier;
 	struct blocking_notifier_head device_notifier;
-	struct rw_semaphore	sem;
 	struct srcu_struct	srcu;
 
 #ifdef CONFIG_PINCTRL
-- 
2.40.1


