Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9E77FAA79
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 20:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbjK0TiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 14:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbjK0Thm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 14:37:42 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E132B1BF7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 11:37:25 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40b402c36c4so16679975e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 11:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701113844; x=1701718644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbXS8xhN2Z8/mFL31QOwkSaE5s+nQ2d8sT8MHI9qIzo=;
        b=nlDZFu4MjsZgCgbnIaA3c8fNAD5rqjyaGItcqGe3G1Ql8aXOvocmJWYraAHUHoRrB3
         LuzEvQ0C6OL5c/MCVQOdczI/RljFQ584q5Mr1d+BXT6QLenQowkGTInKaKS5vAwt6GoH
         uu32iuc7SzKxHyd7Lu1WMncA2SKkP/RBpQkx2EkDzGSLy58opDqCoY8wRVEoE+LfXwCL
         +dko60yhLEZajsBxM7zgOil+XyeKu1+cdhScUzIgjM8nUES/BFvw4V4YUCSXxSPiB/rT
         mEf57H7fGOrC2B0MuZtI0yzjHphW7lN89HT1OCgoPTzE9909oKFGwhrT0vLjpa3p6NW8
         Ze/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701113844; x=1701718644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FbXS8xhN2Z8/mFL31QOwkSaE5s+nQ2d8sT8MHI9qIzo=;
        b=K9CSU0iyb2FRL4x7dbCvodjltSaxc51NBBBrg2h1tcPe9U0KkxSQuCuSJ/PBgCEUps
         kM26D/56YvKR/1Gy5ts5TSwGT/kNFINbNVYOrWxRW7CRWTpdntK8SBVnUgW2F7mO/qL+
         QMY2pwGVbIV61j3GSKAD9dqJlVG6riFedkChjAPAPAt5OhT1zzWMdmxBrfUHjHFMmBAF
         FeySvTE7GEMrrFb/fFDO294s6/W6zjXTnwI8NU373FHo25+aIG8q7UflA094rN2zWyTt
         1ApMFAQVzX2sTjhGZDGU+77stG53FcGiW46jeMT3RA8o4oLpkzja6FdVmHQbLN7pucAE
         hNzQ==
X-Gm-Message-State: AOJu0Ywg92YYNxwzffgJJhYrLWeiRBdtNzAqlmIq6Vgqt27h6E5TkNUb
        5BnoHNg7gBDt4txLFdrVxq6f3Q==
X-Google-Smtp-Source: AGHT+IFLgPHIh5GaozJXydmPU2/M2hEaN5UuMpdlwwN+wEik0XGeZlG6RxrPPIh7UFRniiWtDY7/4g==
X-Received: by 2002:a05:600c:458a:b0:40b:385f:24b5 with SMTP id r10-20020a05600c458a00b0040b385f24b5mr9196960wmo.15.1701113844006;
        Mon, 27 Nov 2023 11:37:24 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:bf33:77c7:8131:5e64])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b0040b3632e993sm15016610wmq.46.2023.11.27.11.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 11:37:23 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/2] gpio: use a mutex to protect the list of GPIO devices
Date:   Mon, 27 Nov 2023 20:37:16 +0100
Message-Id: <20231127193716.63143-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231127193716.63143-1-brgl@bgdev.pl>
References: <20231127193716.63143-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 drivers/gpio/gpiolib.c       | 158 ++++++++++++++++++-----------------
 drivers/gpio/gpiolib.h       |   1 -
 4 files changed, 89 insertions(+), 102 deletions(-)

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
index a5faaea6915d..f0a51d465df9 100644
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
 
@@ -412,26 +411,21 @@ static int gpiodev_add_to_list(struct gpio_device *gdev)
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
@@ -896,48 +908,44 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 
 	gdev->ngpio = gc->ngpio;
 
-	spin_lock_irqsave(&gpio_lock, flags);
-
-	/*
-	 * TODO: this allocates a Linux GPIO number base in the global
-	 * GPIO numberspace for this chip. In the long run we want to
-	 * get *rid* of this numberspace and use only descriptors, but
-	 * it may be a pipe dream. It will not happen before we get rid
-	 * of the sysfs interface anyways.
-	 */
-	base = gc->base;
-	if (base < 0) {
-		base = gpiochip_find_base(gc->ngpio);
+	scoped_guard(mutex, &gpio_devices_lock) {
+		/*
+		 * TODO: this allocates a Linux GPIO number base in the global
+		 * GPIO numberspace for this chip. In the long run we want to
+		 * get *rid* of this numberspace and use only descriptors, but
+		 * it may be a pipe dream. It will not happen before we get rid
+		 * of the sysfs interface anyways.
+		 */
+		base = gc->base;
 		if (base < 0) {
-			spin_unlock_irqrestore(&gpio_lock, flags);
-			ret = base;
-			base = 0;
+			base = gpiochip_find_base(gc->ngpio);
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
+		ret = gpiodev_add_to_list(gdev);
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
-	ret = gpiodev_add_to_list(gdev);
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
@@ -1029,9 +1037,8 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
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
@@ -4741,35 +4748,32 @@ static void gpiolib_dbg_show(struct seq_file *s, struct gpio_device *gdev)
 
 static void *gpiolib_seq_start(struct seq_file *s, loff_t *pos)
 {
-	unsigned long flags;
 	struct gpio_device *gdev = NULL;
 	loff_t index = *pos;
 
 	s->private = "";
 
-	spin_lock_irqsave(&gpio_lock, flags);
+	guard(mutex)(&gpio_devices_lock);
+
 	list_for_each_entry(gdev, &gpio_devices, list)
-		if (index-- == 0) {
-			spin_unlock_irqrestore(&gpio_lock, flags);
+		if (index-- == 0)
 			return gdev;
-		}
-	spin_unlock_irqrestore(&gpio_lock, flags);
 
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

