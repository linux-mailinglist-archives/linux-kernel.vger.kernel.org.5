Return-Path: <linux-kernel+bounces-44647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD753842576
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CA5F1F2DC4B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8846BB23;
	Tue, 30 Jan 2024 12:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="YIinZcNs"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7431B12836C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618942; cv=none; b=oVIqCrEpaT/7t7J1qn92YTUa6/rASw8pCOGQqy3nKANRg634eCv5b/KBJvl0etDvZgQpzQhLdvOqh+GUAX9ecowzRr6+J5kW5R+cCFPdPMRRWOJ34OgDb0vYRQfKxCYJ2O4gevveTdtQ5LiIPKSNcJpJqDF7oN1TpsyVbInkhgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618942; c=relaxed/simple;
	bh=y9mdJHqkaJUTPblXcly6RD1fCpjLZEY1HOEBZsvdUy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SRQZn8zl8/HPHLu1xxzFJ3VxBK5+Qgwhuw9NDHUQTv6HZlznn/zUyx97wk6p6BOmtB77XxklShOkP91tOKTyeDNXaqQiFeDjxM764JOeWpl6RXo2REJQnM2UZM8mJpy+c9ZsKvho27o2tRpQLn1d5EuX5nI8MDznrIo3Y0pT5eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=YIinZcNs; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40faff092a2so875135e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 04:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706618938; x=1707223738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+7x9YO1lMNTbJtrZYjZqq7/6UWxc+FmomVSwe39sqw=;
        b=YIinZcNsqPEy81Gl2SmLxuF/QbclyVZTpBaT+3vjopxOT1+N7bd79WtQKhVDQC79TV
         N33fSjggTlbOm3iW7trvEZzfUKYuF+p+xOIRFVfrvymPiPJ0q9YXMWCOJTodIRFDXTx2
         dpwVsTFUn1xgYVvZETmVxGeh8yD/Qpy5Vkpa36xzwcJeiljBI3QdQqzxiTc2X2ADdyet
         F0NOFId0mB47RA565ScRWpk7SdG07Ac5X97OROwL6wNqMAhwZun/7o/+0jFKy/ESm5Ql
         jnYqizYW82qiTxThL86+/3ITXOr+4PQMXQWK6HEnSqOrDfTNMNw5pPUWR6LiHHguCYrY
         m3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706618938; x=1707223738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+7x9YO1lMNTbJtrZYjZqq7/6UWxc+FmomVSwe39sqw=;
        b=S5GycRDjWvEj2jVc0scnyPRZ3aCUO5xnWWMGokQcrNLKYd7CUHeTeN39h2LNmvTCx2
         nAS1Ge6LGUuaP6ABZapq5ZN/Ve2P2EULCY9kgxJdT7hBXtCflMOc+bVr4VUuVSHCDMUK
         68/1PFiXd022oFnPocpPtz78zjX52e/u2Jyr9uSuMhKeUqj53B0Ww8yj2KJioWrIPGrU
         Vlz7cgIXQsPG72oT0jApbngFmb+IoiJaUZuAQqhuQDn/Q6gGrFBfkZ90ceq76AziyH45
         +Py3isszGl0/rOhYwR1m4yKWD9aWuHIHKg/GwB6ymd7ZV3JN9FUoGkUH9vkJ0cxEhdwI
         TVuA==
X-Gm-Message-State: AOJu0YzCGfwa4awxI+XBTm9ww/mbRa9Q1ibg50mMKy67IyecYUzc9efr
	zHUWCgldDgGSnNIeihe4PIrwcNma+Kmcd1+zgdnfCVo2AKPfwGZURtEOeimtYPQ=
X-Google-Smtp-Source: AGHT+IEEr8wDxX1uSMJ2oJD7I0dywg9cWju58YwinGwvFLRbrn+pfeZgAWOvlI9Gx/bV0A2sUcKFmg==
X-Received: by 2002:a5d:648e:0:b0:33a:f27d:c0c with SMTP id o14-20020a5d648e000000b0033af27d0c0cmr3606488wri.57.1706618937722;
        Tue, 30 Jan 2024 04:48:57 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:abc8:f77e:abeb:129c])
        by smtp.gmail.com with ESMTPSA id en8-20020a056000420800b0033940016d6esm6625337wrb.93.2024.01.30.04.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:48:57 -0800 (PST)
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
Subject: [PATCH 20/22] gpio: protect the pointer to gpio_chip in gpio_device with SRCU
Date: Tue, 30 Jan 2024 13:48:26 +0100
Message-Id: <20240130124828.14678-21-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240130124828.14678-1-brgl@bgdev.pl>
References: <20240130124828.14678-1-brgl@bgdev.pl>
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
---
 drivers/gpio/gpiolib-cdev.c  |  53 ++++----
 drivers/gpio/gpiolib-sysfs.c |  78 ++++++++---
 drivers/gpio/gpiolib.c       | 251 +++++++++++++++++++++++------------
 drivers/gpio/gpiolib.h       |  20 +++
 4 files changed, 276 insertions(+), 126 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index e993c6a7215a..9aaddcc08e29 100644
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
diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 654a5bc53047..c45b71adff2c 100644
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
 
@@ -401,27 +409,48 @@ static const struct attribute_group *gpio_groups[] = {
 static ssize_t base_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	const struct gpio_device *gdev = dev_get_drvdata(dev);
+	struct gpio_device *gdev = dev_get_drvdata(dev);
+	struct gpio_chip *gc;
 
-	return sysfs_emit(buf, "%d\n", gdev->chip->base);
+	guard(srcu)(&gdev->srcu);
+
+	gc = rcu_dereference(gdev->chip);
+	if (!gc)
+		return -ENODEV;
+
+	return sysfs_emit(buf, "%d\n", gc->base);
 }
 static DEVICE_ATTR_RO(base);
 
 static ssize_t label_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	const struct gpio_device *gdev = dev_get_drvdata(dev);
+	struct gpio_device *gdev = dev_get_drvdata(dev);
+	struct gpio_chip *gc;
 
-	return sysfs_emit(buf, "%s\n", gdev->chip->label ?: "");
+	guard(srcu)(&gdev->srcu);
+
+	gc = rcu_dereference(gdev->chip);
+	if (!gc)
+		return -ENODEV;
+
+	return sysfs_emit(buf, "%s\n", gc->label ?: "");
 }
 static DEVICE_ATTR_RO(label);
 
 static ssize_t ngpio_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	const struct gpio_device *gdev = dev_get_drvdata(dev);
+	struct gpio_device *gdev = dev_get_drvdata(dev);
+	struct gpio_chip *gc;
 
-	return sysfs_emit(buf, "%u\n", gdev->chip->ngpio);
+	guard(srcu)(&gdev->srcu);
+
+	gc = rcu_dereference(gdev->chip);
+	if (!gc)
+		return -ENODEV;
+
+	return sysfs_emit(buf, "%u\n", gc->ngpio);
 }
 static DEVICE_ATTR_RO(ngpio);
 
@@ -444,7 +473,6 @@ static ssize_t export_store(const struct class *class,
 				const char *buf, size_t len)
 {
 	struct gpio_desc *desc;
-	struct gpio_chip *gc;
 	int status, offset;
 	long gpio;
 
@@ -458,9 +486,13 @@ static ssize_t export_store(const struct class *class,
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
@@ -563,7 +595,6 @@ int gpiod_export(struct gpio_desc *desc, bool direction_may_change)
 	const char *ioname = NULL;
 	struct gpio_device *gdev;
 	struct gpiod_data *data;
-	struct gpio_chip *chip;
 	struct device *dev;
 	int status, offset;
 
@@ -578,16 +609,19 @@ int gpiod_export(struct gpio_desc *desc, bool direction_may_change)
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
@@ -606,14 +640,14 @@ int gpiod_export(struct gpio_desc *desc, bool direction_may_change)
 
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
@@ -767,7 +801,7 @@ int gpiochip_sysfs_register(struct gpio_device *gdev)
 void gpiochip_sysfs_unregister(struct gpio_device *gdev)
 {
 	struct gpio_desc *desc;
-	struct gpio_chip *chip = gdev->chip;
+	struct gpio_chip *chip;
 
 	scoped_guard(mutex, &sysfs_lock) {
 		if (!gdev->mockdev)
@@ -779,6 +813,12 @@ void gpiochip_sysfs_unregister(struct gpio_device *gdev)
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
index a1a46f2127f8..9990d87e32fe 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -325,12 +325,21 @@ static int gpiochip_find_base_unlocked(int ngpio)
  */
 int gpiod_get_direction(struct gpio_desc *desc)
 {
-	struct gpio_chip *gc;
 	unsigned long flags;
 	unsigned int offset;
 	int ret;
 
-	gc = gpiod_to_chip(desc);
+	if (!desc)
+		/* Sane default is INPUT. */
+		return 1;
+
+	if (IS_ERR(desc))
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
@@ -844,7 +860,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 		return -ENOMEM;
 	gdev->dev.bus = &gpio_bus_type;
 	gdev->dev.parent = gc->parent;
-	gdev->chip = gc;
+	WRITE_ONCE(gdev->chip, gc);
 
 	gc->gpiodev = gdev;
 	gpiochip_set_data(gc, data);
@@ -1084,7 +1100,8 @@ void gpiochip_remove(struct gpio_chip *gc)
 	gpiochip_sysfs_unregister(gdev);
 	gpiochip_free_hogs(gc);
 	/* Numb the device, cancelling all outstanding operations */
-	gdev->chip = NULL;
+	rcu_assign_pointer(gdev->chip, NULL);
+	synchronize_srcu(&gdev->srcu);
 	gpiochip_irqchip_remove(gc);
 	acpi_gpiochip_remove(gc);
 	of_gpiochip_remove(gc);
@@ -1147,6 +1164,7 @@ struct gpio_device *gpio_device_find(void *data,
 						  void *data))
 {
 	struct gpio_device *gdev;
+	struct gpio_chip *gc;
 
 	/*
 	 * Not yet but in the future the spinlock below will become a mutex.
@@ -1157,8 +1175,13 @@ struct gpio_device *gpio_device_find(void *data,
 
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
 
@@ -2205,10 +2228,13 @@ EXPORT_SYMBOL_GPL(gpiochip_remove_pin_ranges);
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
 
@@ -2222,17 +2248,17 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
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
@@ -2299,18 +2325,18 @@ int gpiod_request(struct gpio_desc *desc, const char *label)
 
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
@@ -2467,11 +2493,14 @@ static int gpio_set_config_with_argument(struct gpio_desc *desc,
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
@@ -2561,18 +2590,20 @@ int gpio_set_debounce_timeout(struct gpio_desc *desc, unsigned int debounce)
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
@@ -2585,10 +2616,12 @@ int gpiod_direction_input(struct gpio_desc *desc)
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
@@ -2607,28 +2640,31 @@ EXPORT_SYMBOL_GPL(gpiod_direction_input);
 
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
@@ -2638,7 +2674,7 @@ static int gpiod_direction_output_raw_commit(struct gpio_desc *desc, int value)
 		 * If we can't actively set the direction, we are some
 		 * output-only chip, so just drive the output as desired.
 		 */
-		gc->set(gc, gpio_chip_hwgpio(desc), val);
+		guard.gc->set(guard.gc, gpio_chip_hwgpio(desc), val);
 	}
 
 	if (!ret)
@@ -2754,17 +2790,20 @@ EXPORT_SYMBOL_GPL(gpiod_direction_output);
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
 
@@ -2783,17 +2822,20 @@ EXPORT_SYMBOL_GPL(gpiod_enable_hw_timestamp_ns);
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
 
@@ -2812,12 +2854,13 @@ EXPORT_SYMBOL_GPL(gpiod_disable_hw_timestamp_ns);
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
 
@@ -2915,10 +2958,19 @@ static int gpio_chip_get_value(struct gpio_chip *gc, const struct gpio_desc *des
 
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
@@ -2944,6 +2996,14 @@ static int gpio_chip_get_multiple(struct gpio_chip *gc,
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
@@ -2981,33 +3041,36 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
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
@@ -3022,9 +3085,9 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
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
@@ -3165,14 +3228,16 @@ EXPORT_SYMBOL_GPL(gpiod_get_array_value);
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
@@ -3190,16 +3255,18 @@ static void gpio_set_open_drain_value_commit(struct gpio_desc *desc, bool value)
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
@@ -3210,11 +3277,12 @@ static void gpio_set_open_source_value_commit(struct gpio_desc *desc, bool value
 
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
@@ -3275,33 +3343,36 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
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
@@ -3337,10 +3408,10 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
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
@@ -3496,6 +3567,7 @@ EXPORT_SYMBOL_GPL(gpiod_set_consumer_name);
  */
 int gpiod_to_irq(const struct gpio_desc *desc)
 {
+	struct gpio_device *gdev;
 	struct gpio_chip *gc;
 	int offset;
 
@@ -3507,7 +3579,13 @@ int gpiod_to_irq(const struct gpio_desc *desc)
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
@@ -4683,12 +4761,18 @@ core_initcall(gpiolib_dev_init);
 
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
+	if (!gc)
+		seq_puts(s, "Underlying GPIO chip is gone\n");
+
 	for_each_gpio_desc(gc, desc) {
 		guard(srcu)(&desc->srcu);
 		if (test_bit(FLAG_REQUESTED, &desc->flags)) {
@@ -4754,9 +4838,12 @@ static void gpiolib_seq_stop(struct seq_file *s, void *v)
 static int gpiolib_seq_show(struct seq_file *s, void *v)
 {
 	struct gpio_device *gdev = v;
-	struct gpio_chip *gc = gdev->chip;
+	struct gpio_chip *gc;
 	struct device *parent;
 
+	guard(srcu)(&gdev->srcu);
+
+	gc = rcu_dereference(gdev->chip);
 	if (!gc) {
 		seq_printf(s, "%s%s: (dangling chip)", (char *)s->private,
 			   dev_name(&gdev->dev));
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 35d71e30c546..c96afc800bea 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
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


