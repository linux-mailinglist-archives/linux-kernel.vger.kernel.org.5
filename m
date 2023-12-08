Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7D080A080
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573497AbjLHKU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573490AbjLHKU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:20:26 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661D81706
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:20:31 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50c02628291so1959730e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 02:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702030829; x=1702635629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5z7BIkfWdq3iOxehOcCgzM2TU/UC34N0jjt3CjwoFs=;
        b=SIq0iawXr7p+R+HOY6wJw3DixdQ/+hNqhMeQMc216jiuy/HMPJw2hqaIiTyViSrUg0
         6RAWlj9zXiE1VgDHjdq+50xy8HVJpF0sWuycEYjrJA+ZBHwww0KqMvSjIxrKITrjyyb/
         qdaa9uju+DjxQltUsbzBnxWJmJCVgELviPo/qr0lblq2xXkeTrIdi3x+jG+Cq2MFMcon
         piUB0L0Z/4X/Zpw1S4dpzh68tcC9oYDJErhtAT6539QVTJkGw/OfdJWnwLCMbPg8O6We
         HNm1PotKyG2QvKi9fToq8yO0UZG/y3e/PxnGnP2MlxGHckk0u320Tssz8xvtj1Z9VO+D
         EfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702030829; x=1702635629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G5z7BIkfWdq3iOxehOcCgzM2TU/UC34N0jjt3CjwoFs=;
        b=raDZgmoyKJb1CPnFqOkdBPV1OlmSJa8N4hAkytvzkH1wOjVw7hjqavaCsq1T/G2IIE
         vGbgWFKHKACRN1u3IN1CwstPBwqq+E7lsAonbux0T1NSm6oVe0C2RG/pggbNZCgTmPZh
         Jn0JqR4FJSU8K9sS7RzA5RZnx+Zc+3CAGbLTKR9is5DD5iWVL3xJqhdfymYywIxabzsm
         63Lv+hQ8tgetoIK3XULWBgmC6+IA1lWIWaFm+UV+52bLW+E8bjpRE1ag95pN8W2A0USo
         jnonZe0gNhbeY1RStVgo9MCj78cRZD9zulnIM4VO7Bixz8ZJe3b1CJTzy3AFeQ7SdwnL
         H+kA==
X-Gm-Message-State: AOJu0YwOdJoz/Ln0P8R/kX2L3O2pccxiZQ2mylfSxbCRxqZ2cJYqBNHm
        Xt1vTbvHnGfN4+pllSOV9OmCmQ==
X-Google-Smtp-Source: AGHT+IHArGyg6Yj4ihrKd7fUbeVm8xu/1FZHZfsUt3uLXfKlnJIpDRzu5naXMX0JaA5w142RiQzwpA==
X-Received: by 2002:a05:6512:3e01:b0:50b:e77d:32e4 with SMTP id i1-20020a0565123e0100b0050be77d32e4mr2694162lfv.60.1702030829480;
        Fri, 08 Dec 2023 02:20:29 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b162:2510:4488:c0c3])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d4850000000b003334926fb81sm1678026wrs.90.2023.12.08.02.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 02:20:27 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 2/2] gpiolib: use a mutex to protect the list of GPIO devices
Date:   Fri,  8 Dec 2023 11:20:20 +0100
Message-Id: <20231208102020.36390-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231208102020.36390-1-brgl@bgdev.pl>
References: <20231208102020.36390-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The global list of GPIO devices is never modified or accessed from
atomic context so it's fine to protect it using a mutex. Add a new
global lock dedicated to the gpio_devices list and use it whenever
accessing or modifying it.

While at it: fold the sysfs registering of existing devices into
gpiolib.c and make gpio_devices static within its compilation unit.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-sysfs.c |  26 +-----
 drivers/gpio/gpiolib-sysfs.h |   6 ++
 drivers/gpio/gpiolib.c       | 162 ++++++++++++++++++-----------------
 drivers/gpio/gpiolib.h       |   1 -
 4 files changed, 92 insertions(+), 103 deletions(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 6f309a3b2d9a..c538568604e8 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -790,9 +790,7 @@ void gpiochip_sysfs_unregister(struct gpio_device *gdev)
 
 static int __init gpiolib_sysfs_init(void)
 {
-	int		status;
-	unsigned long	flags;
-	struct gpio_device *gdev;
+	int status;
 
 	status = class_register(&gpio_class);
 	if (status < 0)
@@ -804,26 +802,6 @@ static int __init gpiolib_sysfs_init(void)
 	 * We run before arch_initcall() so chip->dev nodes can have
 	 * registered, and so arch_initcall() can always gpiod_export().
 	 */
-	spin_lock_irqsave(&gpio_lock, flags);
-	list_for_each_entry(gdev, &gpio_devices, list) {
-		if (gdev->mockdev)
-			continue;
-
-		/*
-		 * TODO we yield gpio_lock here because
-		 * gpiochip_sysfs_register() acquires a mutex. This is unsafe
-		 * and needs to be fixed.
-		 *
-		 * Also it would be nice to use gpio_device_find() here so we
-		 * can keep gpio_chips local to gpiolib.c, but the yield of
-		 * gpio_lock prevents us from doing this.
-		 */
-		spin_unlock_irqrestore(&gpio_lock, flags);
-		status = gpiochip_sysfs_register(gdev);
-		spin_lock_irqsave(&gpio_lock, flags);
-	}
-	spin_unlock_irqrestore(&gpio_lock, flags);
-
-	return status;
+	return gpiochip_sysfs_register_all();
 }
 postcore_initcall(gpiolib_sysfs_init);
diff --git a/drivers/gpio/gpiolib-sysfs.h b/drivers/gpio/gpiolib-sysfs.h
index b794b396d6a5..ab157cec0b4b 100644
--- a/drivers/gpio/gpiolib-sysfs.h
+++ b/drivers/gpio/gpiolib-sysfs.h
@@ -8,6 +8,7 @@ struct gpio_device;
 #ifdef CONFIG_GPIO_SYSFS
 
 int gpiochip_sysfs_register(struct gpio_device *gdev);
+int gpiochip_sysfs_register_all(void);
 void gpiochip_sysfs_unregister(struct gpio_device *gdev);
 
 #else
@@ -17,6 +18,11 @@ static inline int gpiochip_sysfs_register(struct gpio_device *gdev)
 	return 0;
 }
 
+static inline int gpiochip_sysfs_register_all(void)
+{
+	return 0;
+}
+
 static inline void gpiochip_sysfs_unregister(struct gpio_device *gdev)
 {
 }
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 779f8b21bf05..9aaf1d11fdd9 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2,6 +2,7 @@
 
 #include <linux/acpi.h>
 #include <linux/bitmap.h>
+#include <linux/cleanup.h>
 #include <linux/compat.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
@@ -15,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/seq_file.h>
@@ -94,7 +96,9 @@ DEFINE_SPINLOCK(gpio_lock);
 
 static DEFINE_MUTEX(gpio_lookup_lock);
 static LIST_HEAD(gpio_lookup_list);
-LIST_HEAD(gpio_devices);
+
+static LIST_HEAD(gpio_devices);
+static DEFINE_MUTEX(gpio_devices_lock);
 
 static DEFINE_MUTEX(gpio_machine_hogs_mutex);
 static LIST_HEAD(gpio_machine_hogs);
@@ -126,20 +130,15 @@ static inline void desc_set_label(struct gpio_desc *d, const char *label)
 struct gpio_desc *gpio_to_desc(unsigned gpio)
 {
 	struct gpio_device *gdev;
-	unsigned long flags;
 
-	spin_lock_irqsave(&gpio_lock, flags);
-
-	list_for_each_entry(gdev, &gpio_devices, list) {
-		if (gdev->base <= gpio &&
-		    gdev->base + gdev->ngpio > gpio) {
-			spin_unlock_irqrestore(&gpio_lock, flags);
-			return &gdev->descs[gpio - gdev->base];
+	scoped_guard(mutex, &gpio_devices_lock) {
+		list_for_each_entry(gdev, &gpio_devices, list) {
+			if (gdev->base <= gpio &&
+			    gdev->base + gdev->ngpio > gpio)
+				return &gdev->descs[gpio - gdev->base];
 		}
 	}
 
-	spin_unlock_irqrestore(&gpio_lock, flags);
-
 	if (!gpio_is_valid(gpio))
 		pr_warn("invalid GPIO %d\n", gpio);
 
@@ -412,26 +411,21 @@ static int gpiodev_add_to_list_unlocked(struct gpio_device *gdev)
 static struct gpio_desc *gpio_name_to_desc(const char * const name)
 {
 	struct gpio_device *gdev;
-	unsigned long flags;
 
 	if (!name)
 		return NULL;
 
-	spin_lock_irqsave(&gpio_lock, flags);
+	guard(mutex)(&gpio_devices_lock);
 
 	list_for_each_entry(gdev, &gpio_devices, list) {
 		struct gpio_desc *desc;
 
 		for_each_gpio_desc(gdev->chip, desc) {
-			if (desc->name && !strcmp(desc->name, name)) {
-				spin_unlock_irqrestore(&gpio_lock, flags);
+			if (desc->name && !strcmp(desc->name, name))
 				return desc;
-			}
 		}
 	}
 
-	spin_unlock_irqrestore(&gpio_lock, flags);
-
 	return NULL;
 }
 
@@ -669,11 +663,9 @@ EXPORT_SYMBOL_GPL(gpiochip_line_is_valid);
 static void gpiodev_release(struct device *dev)
 {
 	struct gpio_device *gdev = to_gpio_device(dev);
-	unsigned long flags;
 
-	spin_lock_irqsave(&gpio_lock, flags);
-	list_del(&gdev->list);
-	spin_unlock_irqrestore(&gpio_lock, flags);
+	scoped_guard(mutex, &gpio_devices_lock)
+		list_del(&gdev->list);
 
 	ida_free(&gpio_ida, gdev->id);
 	kfree_const(gdev->label);
@@ -726,6 +718,27 @@ static int gpiochip_setup_dev(struct gpio_device *gdev)
 	return ret;
 }
 
+#if IS_ENABLED(CONFIG_GPIO_SYSFS)
+int gpiochip_sysfs_register_all(void)
+{
+	struct gpio_device *gdev;
+	int ret;
+
+	guard(mutex)(&gpio_devices_lock);
+
+	list_for_each_entry(gdev, &gpio_devices, list) {
+		if (gdev->mockdev)
+			continue;
+
+		ret = gpiochip_sysfs_register(gdev);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+#endif /* CONFIG_GPIO_SYSFS */
+
 static void gpiochip_machine_hog(struct gpio_chip *gc, struct gpiod_hog *hog)
 {
 	struct gpio_desc *desc;
@@ -831,7 +844,6 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 			       struct lock_class_key *request_key)
 {
 	struct gpio_device *gdev;
-	unsigned long flags;
 	unsigned int i;
 	int base = 0;
 	int ret = 0;
@@ -896,48 +908,45 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 
 	gdev->ngpio = gc->ngpio;
 
-	spin_lock_irqsave(&gpio_lock, flags);
+	scoped_guard(mutex, &gpio_devices_lock) {
+		/*
+		 * TODO: this allocates a Linux GPIO number base in the global
+		 * GPIO numberspace for this chip. In the long run we want to
+		 * get *rid* of this numberspace and use only descriptors, but
+		 * it may be a pipe dream. It will not happen before we get rid
+		 * of the sysfs interface anyways.
+		 */
+		base = gc->base;
 
-	/*
-	 * TODO: this allocates a Linux GPIO number base in the global
-	 * GPIO numberspace for this chip. In the long run we want to
-	 * get *rid* of this numberspace and use only descriptors, but
-	 * it may be a pipe dream. It will not happen before we get rid
-	 * of the sysfs interface anyways.
-	 */
-	base = gc->base;
-	if (base < 0) {
-		base = gpiochip_find_base_unlocked(gc->ngpio);
 		if (base < 0) {
-			spin_unlock_irqrestore(&gpio_lock, flags);
-			ret = base;
-			base = 0;
+			base = gpiochip_find_base_unlocked(gc->ngpio);
+			if (base < 0) {
+				ret = base;
+				base = 0;
+				goto err_free_label;
+			}
+			/*
+			 * TODO: it should not be necessary to reflect the assigned
+			 * base outside of the GPIO subsystem. Go over drivers and
+			 * see if anyone makes use of this, else drop this and assign
+			 * a poison instead.
+			 */
+			gc->base = base;
+		} else {
+			dev_warn(&gdev->dev,
+				 "Static allocation of GPIO base is deprecated, use dynamic allocation.\n");
+		}
+		gdev->base = base;
+
+		ret = gpiodev_add_to_list_unlocked(gdev);
+		if (ret) {
+			chip_err(gc, "GPIO integer space overlap, cannot add chip\n");
 			goto err_free_label;
 		}
-		/*
-		 * TODO: it should not be necessary to reflect the assigned
-		 * base outside of the GPIO subsystem. Go over drivers and
-		 * see if anyone makes use of this, else drop this and assign
-		 * a poison instead.
-		 */
-		gc->base = base;
-	} else {
-		dev_warn(&gdev->dev,
-			 "Static allocation of GPIO base is deprecated, use dynamic allocation.\n");
+
+		for (i = 0; i < gc->ngpio; i++)
+			gdev->descs[i].gdev = gdev;
 	}
-	gdev->base = base;
-
-	ret = gpiodev_add_to_list_unlocked(gdev);
-	if (ret) {
-		spin_unlock_irqrestore(&gpio_lock, flags);
-		chip_err(gc, "GPIO integer space overlap, cannot add chip\n");
-		goto err_free_label;
-	}
-
-	for (i = 0; i < gc->ngpio; i++)
-		gdev->descs[i].gdev = gdev;
-
-	spin_unlock_irqrestore(&gpio_lock, flags);
 
 	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->line_state_notifier);
 	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->device_notifier);
@@ -1029,9 +1038,8 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 		goto err_print_message;
 	}
 err_remove_from_list:
-	spin_lock_irqsave(&gpio_lock, flags);
-	list_del(&gdev->list);
-	spin_unlock_irqrestore(&gpio_lock, flags);
+	scoped_guard(mutex, &gpio_devices_lock)
+		list_del(&gdev->list);
 err_free_label:
 	kfree_const(gdev->label);
 err_free_descs:
@@ -1140,7 +1148,7 @@ struct gpio_device *gpio_device_find(void *data,
 	 */
 	might_sleep();
 
-	guard(spinlock_irqsave)(&gpio_lock);
+	guard(mutex)(&gpio_devices_lock);
 
 	list_for_each_entry(gdev, &gpio_devices, list) {
 		if (gdev->chip && match(gdev->chip, data))
@@ -4748,35 +4756,33 @@ static void gpiolib_dbg_show(struct seq_file *s, struct gpio_device *gdev)
 
 static void *gpiolib_seq_start(struct seq_file *s, loff_t *pos)
 {
-	unsigned long flags;
 	struct gpio_device *gdev = NULL;
 	loff_t index = *pos;
 
 	s->private = "";
 
-	spin_lock_irqsave(&gpio_lock, flags);
-	list_for_each_entry(gdev, &gpio_devices, list)
-		if (index-- == 0) {
-			spin_unlock_irqrestore(&gpio_lock, flags);
+	guard(mutex)(&gpio_devices_lock);
+
+	list_for_each_entry(gdev, &gpio_devices, list) {
+		if (index-- == 0)
 			return gdev;
-		}
-	spin_unlock_irqrestore(&gpio_lock, flags);
+	}
 
 	return NULL;
 }
 
 static void *gpiolib_seq_next(struct seq_file *s, void *v, loff_t *pos)
 {
-	unsigned long flags;
 	struct gpio_device *gdev = v;
 	void *ret = NULL;
 
-	spin_lock_irqsave(&gpio_lock, flags);
-	if (list_is_last(&gdev->list, &gpio_devices))
-		ret = NULL;
-	else
-		ret = list_first_entry(&gdev->list, struct gpio_device, list);
-	spin_unlock_irqrestore(&gpio_lock, flags);
+	scoped_guard(mutex, &gpio_devices_lock) {
+		if (list_is_last(&gdev->list, &gpio_devices))
+			ret = NULL;
+		else
+			ret = list_first_entry(&gdev->list, struct gpio_device,
+					       list);
+	}
 
 	s->private = "\n";
 	++*pos;
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 3ccacf3c1288..9278796db079 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -135,7 +135,6 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 int gpiod_set_transitory(struct gpio_desc *desc, bool transitory);
 
 extern spinlock_t gpio_lock;
-extern struct list_head gpio_devices;
 
 void gpiod_line_state_notify(struct gpio_desc *desc, unsigned long action);
 
-- 
2.40.1

