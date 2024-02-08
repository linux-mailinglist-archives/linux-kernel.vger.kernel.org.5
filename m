Return-Path: <linux-kernel+bounces-57812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADCB84DDAC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 400041C27D69
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD897B3DE;
	Thu,  8 Feb 2024 09:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="qbWC0M9w"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4584E76403
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386393; cv=none; b=sP5gjyz0RKgzWI4eubbXHLd/L90h/QFNLlFugyxaOpkLMKEED03bLSmcqHUDraux4SnAgNFzTGSkSX0mdnVasRQWMdM/nNpTQdbVQzgjfjpyv0sjZxS94MWGBnlaU21IbBQVA+UC4+Ixfwjc1lHUT0zYFdZ88eSISn48b4uzOEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386393; c=relaxed/simple;
	bh=xS/4OdoDE5ZEccFWNqfOzxqqoxMbELyyd+PWeEwUUdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qThge7c5SZq2jO/OHlklLmtJXJgeypyt80edjly9UkXy7Su4IUEXpbiaA41sX2PfBgKT1WiC1FezwqBcVWPN6UmCTxPqW0rtgLTBbsy8DGnm4ECEUa/ThHUkEZgSwiXadeUzIyvPuETY4FTqF7Blj6a2Dpxrq+SoJUG4aDdViUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=qbWC0M9w; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3392b045e0aso1005381f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 01:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707386388; x=1707991188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Evr1zkQTxWocQOGuDvfMfIJc+Cjuk/spUXcqLuZqEv8=;
        b=qbWC0M9wnaNcCjtJBEiYNlQIoTHAmhMd/oJpCn0CCPWyGDUWg9oqHh/10LyWtuHwL3
         wJAAI6iqRXdT5flb5DCgieRK2WuZP79px4T/E7u1g32JJkqmbnaQu1A7Azz9CxyjmQxc
         ZYXkaqwIRLH86xUXLmJ4lRRGheL82T3tdprOWKde+aMP1pR8PMHhyeLAqxHOR+gKrSLm
         OpsVHmi7PtEEQANcUbJFbwbrZbPb70+zS8L26X7hlTfwz0NpiL62wkBL+Z34F5J/UYyO
         K0/iaa3teNWHT1b2z7yei8DhOEZ7aj++nD6hWCdEREZWP7ZX5OVW3WoqkJhjNH3DWHuy
         cPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707386388; x=1707991188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Evr1zkQTxWocQOGuDvfMfIJc+Cjuk/spUXcqLuZqEv8=;
        b=VgCPyQFxGLSV8wHrelnaI2+rG4AAz5CEaxjLislWY7uttFh5rr6aHXvcGF8DoAdaU1
         6p7WPlIpGEs4KX9ekhTdYX7qJld9XFco2yk29nsS9Hf4aB5oEjbxS86wX5yTZS1ODLcN
         fI4y8bBj2+r9xTUXA523K2ZQsIBwcBPQKT9dIpCg2essKU5rRHbAA6GXJ/PrmWTFnTse
         ns4Biqq8ohiyKnDzIe77MbLhKkASHylVL1BO/Pbe0n0EIdGcmjaP4a1r3I+BlmMZipIS
         hh8BEjONuCul4BzWleJcdPM1WWwibmwdIFmycYnbSCVN9idXPuln0kXYfyH3QeFFALUR
         ErFA==
X-Gm-Message-State: AOJu0YxhXN7KG8D1paN2r40q2+Rju50A0iOZt1+0KSFnV48sUZFJVnD0
	h3A44zcW4ly89pju6YGKUw6xQNUXWYFkfpCjJDXFxNoBNe6a6t9M37CG7oqK640Ahp0h6RX9Dpr
	E
X-Google-Smtp-Source: AGHT+IE2kndSqOqMwW3qrnRsGs6HYNyjJsINkxFtiW+0AsGSr3MX2QzD2Lq5TFRVdkcKW0jQ2J8qow==
X-Received: by 2002:a5d:4576:0:b0:33b:2da1:fdd8 with SMTP id a22-20020a5d4576000000b0033b2da1fdd8mr5802411wrc.20.1707386388148;
        Thu, 08 Feb 2024 01:59:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV5YZCZeou2O2fmQmzQhWIqludXa6ICqVy+70PVrX7xFtCnll7GL+LcC/K7Wc/znKxTCXwSVckFScPDm6z+YcNgze4o0eYRo8nDRriyNlAzEVwPJA5Ejp6NpITWTwJWdsen3dW4kOorbhUzBGvjR5QAMw9O6+ghufVHDKIohqSh/zD1eHytqW9Co/H4ifqrzEEuYgFHbt8YBQG+nGhK8F5LlkhCEDrR4kvj4wkqslPPz9U1ERq153Dpj7MZBq9KpOW41g3UCz/rjLYw3GAch37INPwNDvcAR43QRIB5Z8S8py3ngafXl6B9OFuCd2ehUsu4uDnIunryxMGanKJdSPPvpOmEjSARJQ==
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:44bd:e160:131:19a4])
        by smtp.gmail.com with ESMTPSA id x17-20020a5d60d1000000b0033af5086c2dsm3265963wrt.58.2024.02.08.01.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 01:59:47 -0800 (PST)
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
Subject: [PATCH v3 22/24] gpio: protect the pointer to gpio_chip in gpio_device with SRCU
Date: Thu,  8 Feb 2024 10:59:18 +0100
Message-Id: <20240208095920.8035-23-brgl@bgdev.pl>
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

Ensure we cannot crash if the GPIO device gets unregistered (and the
chip pointer set to NULL) during any of the API calls.

To that end: wait for all users of gdev->chip to exit their read-only
SRCU critical sections in gpiochip_remove().

For brevity: add a guard class which can be instantiated at the top of
every function requiring read-only access to the chip pointer and use it
in all API calls taking a GPIO descriptor as argument. In places where
we only deal with the GPIO device - use regular guard() helpers and
rcu_dereference() for chip access. Do the same in API calls taking a
const pointer to gpio_desc.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib-cdev.c  |  63 +++++----
 drivers/gpio/gpiolib-sysfs.c |  57 +++++---
 drivers/gpio/gpiolib.c       | 257 +++++++++++++++++++++++------------
 drivers/gpio/gpiolib.h       |  22 ++-
 4 files changed, 271 insertions(+), 128 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index e993c6a7215a..ccdeed013f6b 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -205,9 +205,9 @@ static long linehandle_ioctl(struct file *file, unsigned int cmd,
 	unsigned int i;
 	int ret;
 
-	guard(rwsem_read)(&lh->gdev->sem);
+	guard(srcu)(&lh->gdev->srcu);
 
-	if (!lh->gdev->chip)
+	if (!rcu_dereference(lh->gdev->chip))
 		return -ENODEV;
 
 	switch (cmd) {
@@ -1520,9 +1520,9 @@ static long linereq_ioctl(struct file *file, unsigned int cmd,
 	struct linereq *lr = file->private_data;
 	void __user *ip = (void __user *)arg;
 
-	guard(rwsem_read)(&lr->gdev->sem);
+	guard(srcu)(&lr->gdev->srcu);
 
-	if (!lr->gdev->chip)
+	if (!rcu_dereference(lr->gdev->chip))
 		return -ENODEV;
 
 	switch (cmd) {
@@ -1551,9 +1551,9 @@ static __poll_t linereq_poll(struct file *file,
 	struct linereq *lr = file->private_data;
 	__poll_t events = 0;
 
-	guard(rwsem_read)(&lr->gdev->sem);
+	guard(srcu)(&lr->gdev->srcu);
 
-	if (!lr->gdev->chip)
+	if (!rcu_dereference(lr->gdev->chip))
 		return EPOLLHUP | EPOLLERR;
 
 	poll_wait(file, &lr->wait, wait);
@@ -1573,9 +1573,9 @@ static ssize_t linereq_read(struct file *file, char __user *buf,
 	ssize_t bytes_read = 0;
 	int ret;
 
-	guard(rwsem_read)(&lr->gdev->sem);
+	guard(srcu)(&lr->gdev->srcu);
 
-	if (!lr->gdev->chip)
+	if (!rcu_dereference(lr->gdev->chip))
 		return -ENODEV;
 
 	if (count < sizeof(le))
@@ -1874,9 +1874,9 @@ static __poll_t lineevent_poll(struct file *file,
 	struct lineevent_state *le = file->private_data;
 	__poll_t events = 0;
 
-	guard(rwsem_read)(&le->gdev->sem);
+	guard(srcu)(&le->gdev->srcu);
 
-	if (!le->gdev->chip)
+	if (!rcu_dereference(le->gdev->chip))
 		return EPOLLHUP | EPOLLERR;
 
 	poll_wait(file, &le->wait, wait);
@@ -1912,9 +1912,9 @@ static ssize_t lineevent_read(struct file *file, char __user *buf,
 	ssize_t ge_size;
 	int ret;
 
-	guard(rwsem_read)(&le->gdev->sem);
+	guard(srcu)(&le->gdev->srcu);
 
-	if (!le->gdev->chip)
+	if (!rcu_dereference(le->gdev->chip))
 		return -ENODEV;
 
 	/*
@@ -1995,9 +1995,9 @@ static long lineevent_ioctl(struct file *file, unsigned int cmd,
 	void __user *ip = (void __user *)arg;
 	struct gpiohandle_data ghd;
 
-	guard(rwsem_read)(&le->gdev->sem);
+	guard(srcu)(&le->gdev->srcu);
 
-	if (!le->gdev->chip)
+	if (!rcu_dereference(le->gdev->chip))
 		return -ENODEV;
 
 	/*
@@ -2295,10 +2295,13 @@ static void gpio_v2_line_info_changed_to_v1(
 static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
 				  struct gpio_v2_line_info *info)
 {
-	struct gpio_chip *gc = desc->gdev->chip;
 	unsigned long dflags;
 	const char *label;
 
+	CLASS(gpio_chip_guard, guard)(desc);
+	if (!guard.gc)
+		return;
+
 	memset(info, 0, sizeof(*info));
 	info->offset = gpio_chip_hwgpio(desc);
 
@@ -2331,8 +2334,8 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
 	    test_bit(FLAG_USED_AS_IRQ, &dflags) ||
 	    test_bit(FLAG_EXPORT, &dflags) ||
 	    test_bit(FLAG_SYSFS, &dflags) ||
-	    !gpiochip_line_is_valid(gc, info->offset) ||
-	    !pinctrl_gpio_can_use_line(gc, info->offset))
+	    !gpiochip_line_is_valid(guard.gc, info->offset) ||
+	    !pinctrl_gpio_can_use_line(guard.gc, info->offset))
 		info->flags |= GPIO_V2_LINE_FLAG_USED;
 
 	if (test_bit(FLAG_IS_OUT, &dflags))
@@ -2505,10 +2508,10 @@ static long gpio_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	struct gpio_device *gdev = cdev->gdev;
 	void __user *ip = (void __user *)arg;
 
-	guard(rwsem_read)(&gdev->sem);
+	guard(srcu)(&gdev->srcu);
 
 	/* We fail any subsequent ioctl():s when the chip is gone */
-	if (!gdev->chip)
+	if (!rcu_dereference(gdev->chip))
 		return -ENODEV;
 
 	/* Fill in the struct and pass to userspace */
@@ -2591,9 +2594,9 @@ static __poll_t lineinfo_watch_poll(struct file *file,
 	struct gpio_chardev_data *cdev = file->private_data;
 	__poll_t events = 0;
 
-	guard(rwsem_read)(&cdev->gdev->sem);
+	guard(srcu)(&cdev->gdev->srcu);
 
-	if (!cdev->gdev->chip)
+	if (!rcu_dereference(cdev->gdev->chip))
 		return EPOLLHUP | EPOLLERR;
 
 	poll_wait(file, &cdev->wait, pollt);
@@ -2614,9 +2617,9 @@ static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
 	int ret;
 	size_t event_size;
 
-	guard(rwsem_read)(&cdev->gdev->sem);
+	guard(srcu)(&cdev->gdev->srcu);
 
-	if (!cdev->gdev->chip)
+	if (!rcu_dereference(cdev->gdev->chip))
 		return -ENODEV;
 
 #ifndef CONFIG_GPIO_CDEV_V1
@@ -2691,10 +2694,10 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 	struct gpio_chardev_data *cdev;
 	int ret = -ENOMEM;
 
-	guard(rwsem_read)(&gdev->sem);
+	guard(srcu)(&gdev->srcu);
 
 	/* Fail on open if the backing gpiochip is gone */
-	if (!gdev->chip)
+	if (!rcu_dereference(gdev->chip))
 		return -ENODEV;
 
 	cdev = kzalloc(sizeof(*cdev), GFP_KERNEL);
@@ -2781,6 +2784,7 @@ static const struct file_operations gpio_fileops = {
 
 int gpiolib_cdev_register(struct gpio_device *gdev, dev_t devt)
 {
+	struct gpio_chip *gc;
 	int ret;
 
 	cdev_init(&gdev->chrdev, &gpio_fileops);
@@ -2791,8 +2795,13 @@ int gpiolib_cdev_register(struct gpio_device *gdev, dev_t devt)
 	if (ret)
 		return ret;
 
-	chip_dbg(gdev->chip, "added GPIO chardev (%d:%d)\n",
-		 MAJOR(devt), gdev->id);
+	guard(srcu)(&gdev->srcu);
+
+	gc = rcu_dereference(gdev->chip);
+	if (!gc)
+		return -ENODEV;
+
+	chip_dbg(gc, "added GPIO chardev (%d:%d)\n", MAJOR(devt), gdev->id);
 
 	return 0;
 }
diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 2e3edf41e853..9f7b5e20fc25 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -171,6 +171,10 @@ static int gpio_sysfs_request_irq(struct device *dev, unsigned char flags)
 	unsigned long irq_flags;
 	int ret;
 
+	CLASS(gpio_chip_guard, guard)(desc);
+	if (!guard.gc)
+		return -ENODEV;
+
 	data->irq = gpiod_to_irq(desc);
 	if (data->irq < 0)
 		return -EIO;
@@ -195,7 +199,7 @@ static int gpio_sysfs_request_irq(struct device *dev, unsigned char flags)
 	 *        Remove this redundant call (along with the corresponding
 	 *        unlock) when those drivers have been fixed.
 	 */
-	ret = gpiochip_lock_as_irq(desc->gdev->chip, gpio_chip_hwgpio(desc));
+	ret = gpiochip_lock_as_irq(guard.gc, gpio_chip_hwgpio(desc));
 	if (ret < 0)
 		goto err_put_kn;
 
@@ -209,7 +213,7 @@ static int gpio_sysfs_request_irq(struct device *dev, unsigned char flags)
 	return 0;
 
 err_unlock:
-	gpiochip_unlock_as_irq(desc->gdev->chip, gpio_chip_hwgpio(desc));
+	gpiochip_unlock_as_irq(guard.gc, gpio_chip_hwgpio(desc));
 err_put_kn:
 	sysfs_put(data->value_kn);
 
@@ -225,9 +229,13 @@ static void gpio_sysfs_free_irq(struct device *dev)
 	struct gpiod_data *data = dev_get_drvdata(dev);
 	struct gpio_desc *desc = data->desc;
 
+	CLASS(gpio_chip_guard, guard)(desc);
+	if (!guard.gc)
+		return;
+
 	data->irq_flags = 0;
 	free_irq(data->irq, data);
-	gpiochip_unlock_as_irq(desc->gdev->chip, gpio_chip_hwgpio(desc));
+	gpiochip_unlock_as_irq(guard.gc, gpio_chip_hwgpio(desc));
 	sysfs_put(data->value_kn);
 }
 
@@ -444,13 +452,12 @@ static ssize_t export_store(const struct class *class,
 				const char *buf, size_t len)
 {
 	struct gpio_desc *desc;
-	struct gpio_chip *gc;
 	int status, offset;
 	long gpio;
 
 	status = kstrtol(buf, 0, &gpio);
-	if (status < 0)
-		goto done;
+	if (status)
+		return status;
 
 	desc = gpio_to_desc(gpio);
 	/* reject invalid GPIOs */
@@ -458,9 +465,13 @@ static ssize_t export_store(const struct class *class,
 		pr_warn("%s: invalid GPIO %ld\n", __func__, gpio);
 		return -EINVAL;
 	}
-	gc = desc->gdev->chip;
+
+	CLASS(gpio_chip_guard, guard)(desc);
+	if (!guard.gc)
+		return -ENODEV;
+
 	offset = gpio_chip_hwgpio(desc);
-	if (!gpiochip_line_is_valid(gc, offset)) {
+	if (!gpiochip_line_is_valid(guard.gc, offset)) {
 		pr_warn("%s: GPIO %ld masked\n", __func__, gpio);
 		return -EINVAL;
 	}
@@ -563,7 +574,6 @@ int gpiod_export(struct gpio_desc *desc, bool direction_may_change)
 	const char *ioname = NULL;
 	struct gpio_device *gdev;
 	struct gpiod_data *data;
-	struct gpio_chip *chip;
 	struct device *dev;
 	int status, offset;
 
@@ -578,16 +588,19 @@ int gpiod_export(struct gpio_desc *desc, bool direction_may_change)
 		return -EINVAL;
 	}
 
+	CLASS(gpio_chip_guard, guard)(desc);
+	if (!guard.gc)
+		return -ENODEV;
+
 	if (!test_and_set_bit(FLAG_EXPORT, &desc->flags))
 		return -EPERM;
 
 	gdev = desc->gdev;
-	chip = gdev->chip;
 
 	mutex_lock(&sysfs_lock);
 
 	/* check if chip is being removed */
-	if (!chip || !gdev->mockdev) {
+	if (!gdev->mockdev) {
 		status = -ENODEV;
 		goto err_unlock;
 	}
@@ -606,14 +619,14 @@ int gpiod_export(struct gpio_desc *desc, bool direction_may_change)
 
 	data->desc = desc;
 	mutex_init(&data->mutex);
-	if (chip->direction_input && chip->direction_output)
+	if (guard.gc->direction_input && guard.gc->direction_output)
 		data->direction_can_change = direction_may_change;
 	else
 		data->direction_can_change = false;
 
 	offset = gpio_chip_hwgpio(desc);
-	if (chip->names && chip->names[offset])
-		ioname = chip->names[offset];
+	if (guard.gc->names && guard.gc->names[offset])
+		ioname = guard.gc->names[offset];
 
 	dev = device_create_with_groups(&gpio_class, &gdev->dev,
 					MKDEV(0, 0), data, gpio_groups,
@@ -728,7 +741,7 @@ EXPORT_SYMBOL_GPL(gpiod_unexport);
 
 int gpiochip_sysfs_register(struct gpio_device *gdev)
 {
-	struct gpio_chip *chip = gdev->chip;
+	struct gpio_chip *chip;
 	struct device *parent;
 	struct device *dev;
 
@@ -741,6 +754,12 @@ int gpiochip_sysfs_register(struct gpio_device *gdev)
 	if (!class_is_registered(&gpio_class))
 		return 0;
 
+	guard(srcu)(&gdev->srcu);
+
+	chip = rcu_dereference(gdev->chip);
+	if (!chip)
+		return -ENODEV;
+
 	/*
 	 * For sysfs backward compatibility we need to preserve this
 	 * preferred parenting to the gpio_chip parent field, if set.
@@ -767,7 +786,7 @@ int gpiochip_sysfs_register(struct gpio_device *gdev)
 void gpiochip_sysfs_unregister(struct gpio_device *gdev)
 {
 	struct gpio_desc *desc;
-	struct gpio_chip *chip = gdev->chip;
+	struct gpio_chip *chip;
 
 	scoped_guard(mutex, &sysfs_lock) {
 		if (!gdev->mockdev)
@@ -779,6 +798,12 @@ void gpiochip_sysfs_unregister(struct gpio_device *gdev)
 		gdev->mockdev = NULL;
 	}
 
+	guard(srcu)(&gdev->srcu);
+
+	chip = rcu_dereference(gdev->chip);
+	if (chip)
+		return;
+
 	/* unregister gpiod class devices owned by sysfs */
 	for_each_gpio_desc_with_flag(chip, desc, FLAG_SYSFS) {
 		gpiod_unexport(desc);
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 9b1907f3e400..a14717a3e222 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -216,7 +216,7 @@ struct gpio_chip *gpiod_to_chip(const struct gpio_desc *desc)
 {
 	if (!desc)
 		return NULL;
-	return desc->gdev->chip;
+	return rcu_dereference(desc->gdev->chip);
 }
 EXPORT_SYMBOL_GPL(gpiod_to_chip);
 
@@ -285,7 +285,7 @@ EXPORT_SYMBOL(gpio_device_get_label);
  */
 struct gpio_chip *gpio_device_get_chip(struct gpio_device *gdev)
 {
-	return gdev->chip;
+	return rcu_dereference(gdev->chip);
 }
 EXPORT_SYMBOL_GPL(gpio_device_get_chip);
 
@@ -325,12 +325,21 @@ static int gpiochip_find_base_unlocked(int ngpio)
  */
 int gpiod_get_direction(struct gpio_desc *desc)
 {
-	struct gpio_chip *gc;
 	unsigned long flags;
 	unsigned int offset;
 	int ret;
 
-	gc = gpiod_to_chip(desc);
+	/*
+	 * We cannot use VALIDATE_DESC() as we must not return 0 for a NULL
+	 * descriptor like we usually do.
+	 */
+	if (!desc || IS_ERR(desc))
+		return -EINVAL;
+
+	CLASS(gpio_chip_guard, guard)(desc);
+	if (!guard.gc)
+		return -ENODEV;
+
 	offset = gpio_chip_hwgpio(desc);
 	flags = READ_ONCE(desc->flags);
 
@@ -342,10 +351,10 @@ int gpiod_get_direction(struct gpio_desc *desc)
 	    test_bit(FLAG_IS_OUT, &flags))
 		return 0;
 
-	if (!gc->get_direction)
+	if (!guard.gc->get_direction)
 		return -ENOTSUPP;
 
-	ret = gc->get_direction(gc, offset);
+	ret = guard.gc->get_direction(guard.gc, offset);
 	if (ret < 0)
 		return ret;
 
@@ -421,6 +430,7 @@ static struct gpio_desc *gpio_name_to_desc(const char * const name)
 {
 	struct gpio_device *gdev;
 	struct gpio_desc *desc;
+	struct gpio_chip *gc;
 
 	if (!name)
 		return NULL;
@@ -429,7 +439,13 @@ static struct gpio_desc *gpio_name_to_desc(const char * const name)
 
 	list_for_each_entry_srcu(gdev, &gpio_devices, list,
 				 srcu_read_lock_held(&gpio_devices_srcu)) {
-		for_each_gpio_desc(gdev->chip, desc) {
+		guard(srcu)(&gdev->srcu);
+
+		gc = rcu_dereference(gdev->chip);
+		if (!gc)
+			continue;
+
+		for_each_gpio_desc(gc, desc) {
 			if (desc->name && !strcmp(desc->name, name))
 				return desc;
 		}
@@ -853,7 +869,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	gdev->dev.type = &gpio_dev_type;
 	gdev->dev.bus = &gpio_bus_type;
 	gdev->dev.parent = gc->parent;
-	gdev->chip = gc;
+	rcu_assign_pointer(gdev->chip, gc);
 
 	gc->gpiodev = gdev;
 	gpiochip_set_data(gc, data);
@@ -1097,7 +1113,8 @@ void gpiochip_remove(struct gpio_chip *gc)
 	synchronize_srcu(&gpio_devices_srcu);
 
 	/* Numb the device, cancelling all outstanding operations */
-	gdev->chip = NULL;
+	rcu_assign_pointer(gdev->chip, NULL);
+	synchronize_srcu(&gdev->srcu);
 	gpiochip_irqchip_remove(gc);
 	acpi_gpiochip_remove(gc);
 	of_gpiochip_remove(gc);
@@ -1156,6 +1173,7 @@ struct gpio_device *gpio_device_find(void *data,
 						  void *data))
 {
 	struct gpio_device *gdev;
+	struct gpio_chip *gc;
 
 	/*
 	 * Not yet but in the future the spinlock below will become a mutex.
@@ -1166,8 +1184,13 @@ struct gpio_device *gpio_device_find(void *data,
 
 	guard(srcu)(&gpio_devices_srcu);
 
-	list_for_each_entry(gdev, &gpio_devices, list) {
-		if (gdev->chip && match(gdev->chip, data))
+	list_for_each_entry_srcu(gdev, &gpio_devices, list,
+				 srcu_read_lock_held(&gpio_devices_srcu)) {
+		guard(srcu)(&gdev->srcu);
+
+		gc = rcu_dereference(gdev->chip);
+
+		if (gc && match(gc, data))
 			return gpio_device_get(gdev);
 	}
 
@@ -2214,10 +2237,13 @@ EXPORT_SYMBOL_GPL(gpiochip_remove_pin_ranges);
  */
 static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
 {
-	struct gpio_chip *gc = desc->gdev->chip;
 	unsigned int offset;
 	int ret;
 
+	CLASS(gpio_chip_guard, guard)(desc);
+	if (!guard.gc)
+		return -ENODEV;
+
 	if (test_and_set_bit(FLAG_REQUESTED, &desc->flags))
 		return -EBUSY;
 
@@ -2231,17 +2257,17 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
 	 * before IRQs are enabled, for non-sleeping (SOC) GPIOs.
 	 */
 
-	if (gc->request) {
+	if (guard.gc->request) {
 		offset = gpio_chip_hwgpio(desc);
-		if (gpiochip_line_is_valid(gc, offset))
-			ret = gc->request(gc, offset);
+		if (gpiochip_line_is_valid(guard.gc, offset))
+			ret = guard.gc->request(guard.gc, offset);
 		else
 			ret = -EINVAL;
 		if (ret)
 			goto out_clear_bit;
 	}
 
-	if (gc->get_direction)
+	if (guard.gc->get_direction)
 		gpiod_get_direction(desc);
 
 	ret = desc_set_label(desc, label ? : "?");
@@ -2308,18 +2334,18 @@ int gpiod_request(struct gpio_desc *desc, const char *label)
 
 static bool gpiod_free_commit(struct gpio_desc *desc)
 {
-	struct gpio_chip *gc;
 	unsigned long flags;
 	bool ret = false;
 
 	might_sleep();
 
-	gc = desc->gdev->chip;
+	CLASS(gpio_chip_guard, guard)(desc);
+
 	flags = READ_ONCE(desc->flags);
 
-	if (gc && test_bit(FLAG_REQUESTED, &flags)) {
-		if (gc->free)
-			gc->free(gc, gpio_chip_hwgpio(desc));
+	if (guard.gc && test_bit(FLAG_REQUESTED, &flags)) {
+		if (guard.gc->free)
+			guard.gc->free(guard.gc, gpio_chip_hwgpio(desc));
 
 		clear_bit(FLAG_ACTIVE_LOW, &flags);
 		clear_bit(FLAG_REQUESTED, &flags);
@@ -2476,11 +2502,14 @@ static int gpio_set_config_with_argument(struct gpio_desc *desc,
 					 enum pin_config_param mode,
 					 u32 argument)
 {
-	struct gpio_chip *gc = desc->gdev->chip;
 	unsigned long config;
 
+	CLASS(gpio_chip_guard, guard)(desc);
+	if (!guard.gc)
+		return -ENODEV;
+
 	config = pinconf_to_config_packed(mode, argument);
-	return gpio_do_set_config(gc, gpio_chip_hwgpio(desc), config);
+	return gpio_do_set_config(guard.gc, gpio_chip_hwgpio(desc), config);
 }
 
 static int gpio_set_config_with_argument_optional(struct gpio_desc *desc,
@@ -2570,18 +2599,20 @@ int gpio_set_debounce_timeout(struct gpio_desc *desc, unsigned int debounce)
  */
 int gpiod_direction_input(struct gpio_desc *desc)
 {
-	struct gpio_chip *gc;
 	int ret = 0;
 
 	VALIDATE_DESC(desc);
-	gc = desc->gdev->chip;
+
+	CLASS(gpio_chip_guard, guard)(desc);
+	if (!guard.gc)
+		return -ENODEV;
 
 	/*
 	 * It is legal to have no .get() and .direction_input() specified if
 	 * the chip is output-only, but you can't specify .direction_input()
 	 * and not support the .get() operation, that doesn't make sense.
 	 */
-	if (!gc->get && gc->direction_input) {
+	if (!guard.gc->get && guard.gc->direction_input) {
 		gpiod_warn(desc,
 			   "%s: missing get() but have direction_input()\n",
 			   __func__);
@@ -2594,10 +2625,12 @@ int gpiod_direction_input(struct gpio_desc *desc)
 	 * direction (if .get_direction() is supported) else we silently
 	 * assume we are in input mode after this.
 	 */
-	if (gc->direction_input) {
-		ret = gc->direction_input(gc, gpio_chip_hwgpio(desc));
-	} else if (gc->get_direction &&
-		  (gc->get_direction(gc, gpio_chip_hwgpio(desc)) != 1)) {
+	if (guard.gc->direction_input) {
+		ret = guard.gc->direction_input(guard.gc,
+						gpio_chip_hwgpio(desc));
+	} else if (guard.gc->get_direction &&
+		  (guard.gc->get_direction(guard.gc,
+					   gpio_chip_hwgpio(desc)) != 1)) {
 		gpiod_warn(desc,
 			   "%s: missing direction_input() operation and line is output\n",
 			   __func__);
@@ -2616,28 +2649,31 @@ EXPORT_SYMBOL_GPL(gpiod_direction_input);
 
 static int gpiod_direction_output_raw_commit(struct gpio_desc *desc, int value)
 {
-	struct gpio_chip *gc = desc->gdev->chip;
-	int val = !!value;
-	int ret = 0;
+	int val = !!value, ret = 0;
+
+	CLASS(gpio_chip_guard, guard)(desc);
+	if (!guard.gc)
+		return -ENODEV;
 
 	/*
 	 * It's OK not to specify .direction_output() if the gpiochip is
 	 * output-only, but if there is then not even a .set() operation it
 	 * is pretty tricky to drive the output line.
 	 */
-	if (!gc->set && !gc->direction_output) {
+	if (!guard.gc->set && !guard.gc->direction_output) {
 		gpiod_warn(desc,
 			   "%s: missing set() and direction_output() operations\n",
 			   __func__);
 		return -EIO;
 	}
 
-	if (gc->direction_output) {
-		ret = gc->direction_output(gc, gpio_chip_hwgpio(desc), val);
+	if (guard.gc->direction_output) {
+		ret = guard.gc->direction_output(guard.gc,
+						 gpio_chip_hwgpio(desc), val);
 	} else {
 		/* Check that we are in output mode if we can */
-		if (gc->get_direction &&
-		    gc->get_direction(gc, gpio_chip_hwgpio(desc))) {
+		if (guard.gc->get_direction &&
+		    guard.gc->get_direction(guard.gc, gpio_chip_hwgpio(desc))) {
 			gpiod_warn(desc,
 				"%s: missing direction_output() operation\n",
 				__func__);
@@ -2647,7 +2683,7 @@ static int gpiod_direction_output_raw_commit(struct gpio_desc *desc, int value)
 		 * If we can't actively set the direction, we are some
 		 * output-only chip, so just drive the output as desired.
 		 */
-		gc->set(gc, gpio_chip_hwgpio(desc), val);
+		guard.gc->set(guard.gc, gpio_chip_hwgpio(desc), val);
 	}
 
 	if (!ret)
@@ -2763,17 +2799,20 @@ EXPORT_SYMBOL_GPL(gpiod_direction_output);
 int gpiod_enable_hw_timestamp_ns(struct gpio_desc *desc, unsigned long flags)
 {
 	int ret = 0;
-	struct gpio_chip *gc;
 
 	VALIDATE_DESC(desc);
 
-	gc = desc->gdev->chip;
-	if (!gc->en_hw_timestamp) {
+	CLASS(gpio_chip_guard, guard)(desc);
+	if (!guard.gc)
+		return -ENODEV;
+
+	if (!guard.gc->en_hw_timestamp) {
 		gpiod_warn(desc, "%s: hw ts not supported\n", __func__);
 		return -ENOTSUPP;
 	}
 
-	ret = gc->en_hw_timestamp(gc, gpio_chip_hwgpio(desc), flags);
+	ret = guard.gc->en_hw_timestamp(guard.gc,
+					gpio_chip_hwgpio(desc), flags);
 	if (ret)
 		gpiod_warn(desc, "%s: hw ts request failed\n", __func__);
 
@@ -2792,17 +2831,20 @@ EXPORT_SYMBOL_GPL(gpiod_enable_hw_timestamp_ns);
 int gpiod_disable_hw_timestamp_ns(struct gpio_desc *desc, unsigned long flags)
 {
 	int ret = 0;
-	struct gpio_chip *gc;
 
 	VALIDATE_DESC(desc);
 
-	gc = desc->gdev->chip;
-	if (!gc->dis_hw_timestamp) {
+	CLASS(gpio_chip_guard, guard)(desc);
+	if (!guard.gc)
+		return -ENODEV;
+
+	if (!guard.gc->dis_hw_timestamp) {
 		gpiod_warn(desc, "%s: hw ts not supported\n", __func__);
 		return -ENOTSUPP;
 	}
 
-	ret = gc->dis_hw_timestamp(gc, gpio_chip_hwgpio(desc), flags);
+	ret = guard.gc->dis_hw_timestamp(guard.gc, gpio_chip_hwgpio(desc),
+					 flags);
 	if (ret)
 		gpiod_warn(desc, "%s: hw ts release failed\n", __func__);
 
@@ -2821,12 +2863,13 @@ EXPORT_SYMBOL_GPL(gpiod_disable_hw_timestamp_ns);
  */
 int gpiod_set_config(struct gpio_desc *desc, unsigned long config)
 {
-	struct gpio_chip *gc;
-
 	VALIDATE_DESC(desc);
-	gc = desc->gdev->chip;
 
-	return gpio_do_set_config(gc, gpio_chip_hwgpio(desc), config);
+	CLASS(gpio_chip_guard, guard)(desc);
+	if (!guard.gc)
+		return -ENODEV;
+
+	return gpio_do_set_config(guard.gc, gpio_chip_hwgpio(desc), config);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_config);
 
@@ -2924,10 +2967,19 @@ static int gpio_chip_get_value(struct gpio_chip *gc, const struct gpio_desc *des
 
 static int gpiod_get_raw_value_commit(const struct gpio_desc *desc)
 {
+	struct gpio_device *gdev;
 	struct gpio_chip *gc;
 	int value;
 
-	gc = desc->gdev->chip;
+	/* FIXME Unable to use gpio_chip_guard due to const desc. */
+	gdev = desc->gdev;
+
+	guard(srcu)(&gdev->srcu);
+
+	gc = rcu_dereference(gdev->chip);
+	if (!gc)
+		return -ENODEV;
+
 	value = gpio_chip_get_value(gc, desc);
 	value = value < 0 ? value : !!value;
 	trace_gpio_value(desc_to_gpio(desc), 1, value);
@@ -2953,6 +3005,14 @@ static int gpio_chip_get_multiple(struct gpio_chip *gc,
 	return -EIO;
 }
 
+/* The 'other' chip must be protected with its GPIO device's SRCU. */
+static bool gpio_device_chip_cmp(struct gpio_device *gdev, struct gpio_chip *gc)
+{
+	guard(srcu)(&gdev->srcu);
+
+	return gc == rcu_dereference(gdev->chip);
+}
+
 int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 				  unsigned int array_size,
 				  struct gpio_desc **desc_array,
@@ -2990,33 +3050,36 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 	}
 
 	while (i < array_size) {
-		struct gpio_chip *gc = desc_array[i]->gdev->chip;
 		DECLARE_BITMAP(fastpath_mask, FASTPATH_NGPIO);
 		DECLARE_BITMAP(fastpath_bits, FASTPATH_NGPIO);
 		unsigned long *mask, *bits;
 		int first, j;
 
-		if (likely(gc->ngpio <= FASTPATH_NGPIO)) {
+		CLASS(gpio_chip_guard, guard)(desc_array[i]);
+		if (!guard.gc)
+			return -ENODEV;
+
+		if (likely(guard.gc->ngpio <= FASTPATH_NGPIO)) {
 			mask = fastpath_mask;
 			bits = fastpath_bits;
 		} else {
 			gfp_t flags = can_sleep ? GFP_KERNEL : GFP_ATOMIC;
 
-			mask = bitmap_alloc(gc->ngpio, flags);
+			mask = bitmap_alloc(guard.gc->ngpio, flags);
 			if (!mask)
 				return -ENOMEM;
 
-			bits = bitmap_alloc(gc->ngpio, flags);
+			bits = bitmap_alloc(guard.gc->ngpio, flags);
 			if (!bits) {
 				bitmap_free(mask);
 				return -ENOMEM;
 			}
 		}
 
-		bitmap_zero(mask, gc->ngpio);
+		bitmap_zero(mask, guard.gc->ngpio);
 
 		if (!can_sleep)
-			WARN_ON(gc->can_sleep);
+			WARN_ON(guard.gc->can_sleep);
 
 		/* collect all inputs belonging to the same chip */
 		first = i;
@@ -3031,9 +3094,9 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 				i = find_next_zero_bit(array_info->get_mask,
 						       array_size, i);
 		} while ((i < array_size) &&
-			 (desc_array[i]->gdev->chip == gc));
+			 gpio_device_chip_cmp(desc_array[i]->gdev, guard.gc));
 
-		ret = gpio_chip_get_multiple(gc, mask, bits);
+		ret = gpio_chip_get_multiple(guard.gc, mask, bits);
 		if (ret) {
 			if (mask != fastpath_mask)
 				bitmap_free(mask);
@@ -3174,14 +3237,16 @@ EXPORT_SYMBOL_GPL(gpiod_get_array_value);
  */
 static void gpio_set_open_drain_value_commit(struct gpio_desc *desc, bool value)
 {
-	int ret = 0;
-	struct gpio_chip *gc = desc->gdev->chip;
-	int offset = gpio_chip_hwgpio(desc);
+	int ret = 0, offset = gpio_chip_hwgpio(desc);
+
+	CLASS(gpio_chip_guard, guard)(desc);
+	if (!guard.gc)
+		return;
 
 	if (value) {
-		ret = gc->direction_input(gc, offset);
+		ret = guard.gc->direction_input(guard.gc, offset);
 	} else {
-		ret = gc->direction_output(gc, offset, 0);
+		ret = guard.gc->direction_output(guard.gc, offset, 0);
 		if (!ret)
 			set_bit(FLAG_IS_OUT, &desc->flags);
 	}
@@ -3199,16 +3264,18 @@ static void gpio_set_open_drain_value_commit(struct gpio_desc *desc, bool value)
  */
 static void gpio_set_open_source_value_commit(struct gpio_desc *desc, bool value)
 {
-	int ret = 0;
-	struct gpio_chip *gc = desc->gdev->chip;
-	int offset = gpio_chip_hwgpio(desc);
+	int ret = 0, offset = gpio_chip_hwgpio(desc);
+
+	CLASS(gpio_chip_guard, guard)(desc);
+	if (!guard.gc)
+		return;
 
 	if (value) {
-		ret = gc->direction_output(gc, offset, 1);
+		ret = guard.gc->direction_output(guard.gc, offset, 1);
 		if (!ret)
 			set_bit(FLAG_IS_OUT, &desc->flags);
 	} else {
-		ret = gc->direction_input(gc, offset);
+		ret = guard.gc->direction_input(guard.gc, offset);
 	}
 	trace_gpio_direction(desc_to_gpio(desc), !value, ret);
 	if (ret < 0)
@@ -3219,11 +3286,12 @@ static void gpio_set_open_source_value_commit(struct gpio_desc *desc, bool value
 
 static void gpiod_set_raw_value_commit(struct gpio_desc *desc, bool value)
 {
-	struct gpio_chip *gc;
+	CLASS(gpio_chip_guard, guard)(desc);
+	if (!guard.gc)
+		return;
 
-	gc = desc->gdev->chip;
 	trace_gpio_value(desc_to_gpio(desc), 0, value);
-	gc->set(gc, gpio_chip_hwgpio(desc), value);
+	guard.gc->set(guard.gc, gpio_chip_hwgpio(desc), value);
 }
 
 /*
@@ -3284,33 +3352,36 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 	}
 
 	while (i < array_size) {
-		struct gpio_chip *gc = desc_array[i]->gdev->chip;
 		DECLARE_BITMAP(fastpath_mask, FASTPATH_NGPIO);
 		DECLARE_BITMAP(fastpath_bits, FASTPATH_NGPIO);
 		unsigned long *mask, *bits;
 		int count = 0;
 
-		if (likely(gc->ngpio <= FASTPATH_NGPIO)) {
+		CLASS(gpio_chip_guard, guard)(desc_array[i]);
+		if (!guard.gc)
+			return -ENODEV;
+
+		if (likely(guard.gc->ngpio <= FASTPATH_NGPIO)) {
 			mask = fastpath_mask;
 			bits = fastpath_bits;
 		} else {
 			gfp_t flags = can_sleep ? GFP_KERNEL : GFP_ATOMIC;
 
-			mask = bitmap_alloc(gc->ngpio, flags);
+			mask = bitmap_alloc(guard.gc->ngpio, flags);
 			if (!mask)
 				return -ENOMEM;
 
-			bits = bitmap_alloc(gc->ngpio, flags);
+			bits = bitmap_alloc(guard.gc->ngpio, flags);
 			if (!bits) {
 				bitmap_free(mask);
 				return -ENOMEM;
 			}
 		}
 
-		bitmap_zero(mask, gc->ngpio);
+		bitmap_zero(mask, guard.gc->ngpio);
 
 		if (!can_sleep)
-			WARN_ON(gc->can_sleep);
+			WARN_ON(guard.gc->can_sleep);
 
 		do {
 			struct gpio_desc *desc = desc_array[i];
@@ -3346,10 +3417,10 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 				i = find_next_zero_bit(array_info->set_mask,
 						       array_size, i);
 		} while ((i < array_size) &&
-			 (desc_array[i]->gdev->chip == gc));
+			 gpio_device_chip_cmp(desc_array[i]->gdev, guard.gc));
 		/* push collected bits to outputs */
 		if (count != 0)
-			gpio_chip_set_multiple(gc, mask, bits);
+			gpio_chip_set_multiple(guard.gc, mask, bits);
 
 		if (mask != fastpath_mask)
 			bitmap_free(mask);
@@ -3505,6 +3576,7 @@ EXPORT_SYMBOL_GPL(gpiod_set_consumer_name);
  */
 int gpiod_to_irq(const struct gpio_desc *desc)
 {
+	struct gpio_device *gdev;
 	struct gpio_chip *gc;
 	int offset;
 
@@ -3516,7 +3588,13 @@ int gpiod_to_irq(const struct gpio_desc *desc)
 	if (!desc || IS_ERR(desc))
 		return -EINVAL;
 
-	gc = desc->gdev->chip;
+	gdev = desc->gdev;
+	/* FIXME Cannot use gpio_chip_guard due to const desc. */
+	guard(srcu)(&gdev->srcu);
+	gc = rcu_dereference(gdev->chip);
+	if (!gc)
+		return -ENODEV;
+
 	offset = gpio_chip_hwgpio(desc);
 	if (gc->to_irq) {
 		int retirq = gc->to_irq(gc, offset);
@@ -4696,12 +4774,20 @@ core_initcall(gpiolib_dev_init);
 
 static void gpiolib_dbg_show(struct seq_file *s, struct gpio_device *gdev)
 {
-	struct gpio_chip *gc = gdev->chip;
 	bool active_low, is_irq, is_out;
 	unsigned int gpio = gdev->base;
 	struct gpio_desc *desc;
+	struct gpio_chip *gc;
 	int value;
 
+	guard(srcu)(&gdev->srcu);
+
+	gc = rcu_dereference(gdev->chip);
+	if (!gc) {
+		seq_puts(s, "Underlying GPIO chip is gone\n");
+		return;
+	}
+
 	for_each_gpio_desc(gc, desc) {
 		guard(srcu)(&desc->srcu);
 		if (test_bit(FLAG_REQUESTED, &desc->flags)) {
@@ -4776,9 +4862,12 @@ static int gpiolib_seq_show(struct seq_file *s, void *v)
 {
 	struct gpiolib_seq_priv *priv = s->private;
 	struct gpio_device *gdev = v;
-	struct gpio_chip *gc = gdev->chip;
+	struct gpio_chip *gc;
 	struct device *parent;
 
+	guard(srcu)(&gdev->srcu);
+
+	gc = rcu_dereference(gdev->chip);
 	if (!gc) {
 		seq_printf(s, "%s%s: (dangling chip)",
 			   priv->newline ? "\n" : "",
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 35d71e30c546..b3810f7d286a 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -63,7 +63,7 @@ struct gpio_device {
 	int			id;
 	struct device		*mockdev;
 	struct module		*owner;
-	struct gpio_chip	*chip;
+	struct gpio_chip __rcu	*chip;
 	struct gpio_desc	*descs;
 	int			base;
 	u16			ngpio;
@@ -193,6 +193,26 @@ struct gpio_desc {
 
 #define gpiod_not_found(desc)		(IS_ERR(desc) && PTR_ERR(desc) == -ENOENT)
 
+struct gpio_chip_guard {
+	struct gpio_device *gdev;
+	struct gpio_chip *gc;
+	int idx;
+};
+
+DEFINE_CLASS(gpio_chip_guard,
+	     struct gpio_chip_guard,
+	     srcu_read_unlock(&_T.gdev->srcu, _T.idx),
+	     ({
+		struct gpio_chip_guard _guard;
+
+		_guard.gdev = desc->gdev;
+		_guard.idx = srcu_read_lock(&_guard.gdev->srcu);
+		_guard.gc = rcu_dereference(_guard.gdev->chip);
+
+		_guard;
+	     }),
+	     struct gpio_desc *desc)
+
 int gpiod_request(struct gpio_desc *desc, const char *label);
 void gpiod_free(struct gpio_desc *desc);
 
-- 
2.40.1


