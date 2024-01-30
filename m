Return-Path: <linux-kernel+bounces-44628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8413D84254B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDF651F27CA1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3E26BB57;
	Tue, 30 Jan 2024 12:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="y+AkX2c1"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8719C6A03C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618924; cv=none; b=Rh5tB7/+PZSewP9SzlLk2ls8ESHDJHk9u2YRFc1mGC9LjYk9yqhPbtHkTwl/uDBTUT7H4f4MVNsVH7PF0R7xY9+25z0LlJ8RUvjMC07ma/9tkUszIuPjDmGbnX52s3b/c+aaPaHmG+NRISwfmHiwSwq+Ma6/4+FojjOSV5QSDK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618924; c=relaxed/simple;
	bh=86Y+AQ3y8n9w/i3PI5/p7q/gCkmb53F9yvtd/1pyEI0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vFfRBogIc+E7FVippqk+x98qZnxCyy+fRsFErOg2nIOyHeEZBtXvyPqCYi9PofxluUuFpzXAqkeRfPOGy6e0bKZLuOaaM/RBqYdySz05o9X7o2bp+ci+BOslFi2jUpBNLuv5BI/n7qvzKpD9pYj85vjz9zg4Ug5Wc4Tuse/7saM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=y+AkX2c1; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e800461baso52658655e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 04:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706618921; x=1707223721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ISdQKhUHMbel1ayot3kDVw2CcPuKldTF7psGraEV5g=;
        b=y+AkX2c1TnVzv9UIr/kgjU8zLrK6dMRPTwAUAWfe29ypgt4O+fGBzpWgGGpChh9FOW
         NG8m1ndYm8YTHw7HALE/y2Mjm9wCadFVq4Q0qxIJcgTz3Oomm4J2b6toTtopqK790VL1
         WOCovK0VFkM2dV7+9i49K80Y5+UwjMDuwNNBwfBmFrDWJUFthDN8Ygo/vKYuM82dj+90
         N3gQly+Y928S4gkOUJwf/jMgVx+Sr6O1mnX2SuEsSIktryhrVkPs5ptrvxlBy9onrRTF
         LQFOixNC2nbS8tzVXEaCUjC8gS+77gis2NkpQDrh/3ruNg/cvDaSPLZK6/73H8YNLIIT
         2gLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706618921; x=1707223721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ISdQKhUHMbel1ayot3kDVw2CcPuKldTF7psGraEV5g=;
        b=bXdelZ0DkDTtD4UZDvUNo6xPCQ9nJ0jA9Dk95eg9Jd0tyyv1yu+r4GJdNmN3VgskZM
         IROvkh8GbvPDweyOTFLrXBrSKeV0jA2392daT2uozu5MXBqGWPolCGbsWome6ZGpxM7L
         q3C+FXDX61Ctca75xNe7H58xJA5Q2sV2/9mGBAP7M3wIlJGBs0ZPrLtGwF4hL1BSgv1X
         AV+oQQsibNmXNuaCFdZCgieBhw5F5wnlqBaAXTTGpVft74TWvR7KTWQLiTXDuvOUbU6T
         8QCuhxxfAtkgsPSb/OpfvftfWXnvubZOzdIMkhk5BcthVJlPMYcS8EsnXvPGwGkZBQR1
         oSVQ==
X-Gm-Message-State: AOJu0Yx7a6r5nKUrzQfUWBBfC5WgFjdoZSjRKHYAHoOFLXbuMXMtGlbp
	gS/aWXvrbw4Py5DDBfYI/7YEVXtwhiGE7h30QEkWC6q9SDKJ7Jq2ea3Atdnilm0=
X-Google-Smtp-Source: AGHT+IGWn4BPiCCxI47pc0kQWYu/XZls9SyCDrIX1E8/QuR2urA7cmgjpCAIHRmwQbXkxheO43JsFg==
X-Received: by 2002:a7b:c4c5:0:b0:40e:cf0f:5fc9 with SMTP id g5-20020a7bc4c5000000b0040ecf0f5fc9mr6490225wmk.31.1706618920639;
        Tue, 30 Jan 2024 04:48:40 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:abc8:f77e:abeb:129c])
        by smtp.gmail.com with ESMTPSA id en8-20020a056000420800b0033940016d6esm6625337wrb.93.2024.01.30.04.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:48:40 -0800 (PST)
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
Subject: [PATCH 01/22] gpio: protect the list of GPIO devices with SRCU
Date: Tue, 30 Jan 2024 13:48:07 +0100
Message-Id: <20240130124828.14678-2-brgl@bgdev.pl>
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

We're working towards removing the "multi-function" GPIO spinlock that's
implemented terribly wrong. We tried using an RW-semaphore to protect
the list of GPIO devices but it turned out that we still have old code
using legacy GPIO calls that need to translate the global GPIO number to
the address of the associated descriptor and - to that end - traverse
the list while holding the lock. If we change the spinlock to a sleeping
lock then we'll end up with "scheduling while atomic" bugs.

Let's allow lockless traversal of the list using SRCU and only use the
mutex when modyfing the list.

While at it: let's protect the period between when we start the lookup
and when we finally request the descriptor (increasing the reference
count of the GPIO device) with the SRCU read lock.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 203 +++++++++++++++++++++--------------------
 1 file changed, 104 insertions(+), 99 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index d50a786f8176..69979de76485 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2,6 +2,7 @@
 
 #include <linux/acpi.h>
 #include <linux/bitmap.h>
+#include <linux/cleanup.h>
 #include <linux/compat.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
@@ -14,12 +15,14 @@
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
+#include <linux/lockdep.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/srcu.h>
 #include <linux/string.h>
 
 #include <linux/gpio.h>
@@ -81,7 +84,12 @@ DEFINE_SPINLOCK(gpio_lock);
 
 static DEFINE_MUTEX(gpio_lookup_lock);
 static LIST_HEAD(gpio_lookup_list);
+
 LIST_HEAD(gpio_devices);
+/* Protects the GPIO device list against concurrent modifications. */
+static DEFINE_MUTEX(gpio_devices_lock);
+/* Ensures coherence during read-only accesses to the list of GPIO devices. */
+DEFINE_STATIC_SRCU(gpio_devices_srcu);
 
 static DEFINE_MUTEX(gpio_machine_hogs_mutex);
 static LIST_HEAD(gpio_machine_hogs);
@@ -113,20 +121,16 @@ static inline void desc_set_label(struct gpio_desc *d, const char *label)
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
+	scoped_guard(srcu, &gpio_devices_srcu) {
+		list_for_each_entry_srcu(gdev, &gpio_devices, list,
+				srcu_read_lock_held(&gpio_devices_srcu)) {
+			if (gdev->base <= gpio &&
+			    gdev->base + gdev->ngpio > gpio)
+				return &gdev->descs[gpio - gdev->base];
 		}
 	}
 
-	spin_unlock_irqrestore(&gpio_lock, flags);
-
 	if (!gpio_is_valid(gpio))
 		pr_warn("invalid GPIO %d\n", gpio);
 
@@ -282,7 +286,8 @@ static int gpiochip_find_base_unlocked(int ngpio)
 	struct gpio_device *gdev;
 	int base = GPIO_DYNAMIC_BASE;
 
-	list_for_each_entry(gdev, &gpio_devices, list) {
+	list_for_each_entry_srcu(gdev, &gpio_devices, list,
+				 lockdep_is_held(&gpio_devices_lock)) {
 		/* found a free space? */
 		if (gdev->base >= base + ngpio)
 			break;
@@ -354,23 +359,25 @@ static int gpiodev_add_to_list_unlocked(struct gpio_device *gdev)
 {
 	struct gpio_device *prev, *next;
 
+	lockdep_assert_held(&gpio_devices_lock);
+
 	if (list_empty(&gpio_devices)) {
 		/* initial entry in list */
-		list_add_tail(&gdev->list, &gpio_devices);
+		list_add_tail_rcu(&gdev->list, &gpio_devices);
 		return 0;
 	}
 
 	next = list_first_entry(&gpio_devices, struct gpio_device, list);
 	if (gdev->base + gdev->ngpio <= next->base) {
 		/* add before first entry */
-		list_add(&gdev->list, &gpio_devices);
+		list_add_rcu(&gdev->list, &gpio_devices);
 		return 0;
 	}
 
 	prev = list_last_entry(&gpio_devices, struct gpio_device, list);
 	if (prev->base + prev->ngpio <= gdev->base) {
 		/* add behind last entry */
-		list_add_tail(&gdev->list, &gpio_devices);
+		list_add_tail_rcu(&gdev->list, &gpio_devices);
 		return 0;
 	}
 
@@ -382,11 +389,13 @@ static int gpiodev_add_to_list_unlocked(struct gpio_device *gdev)
 		/* add between prev and next */
 		if (prev->base + prev->ngpio <= gdev->base
 				&& gdev->base + gdev->ngpio <= next->base) {
-			list_add(&gdev->list, &prev->list);
+			list_add_rcu(&gdev->list, &prev->list);
 			return 0;
 		}
 	}
 
+	synchronize_srcu(&gpio_devices_srcu);
+
 	return -EBUSY;
 }
 
@@ -399,26 +408,21 @@ static int gpiodev_add_to_list_unlocked(struct gpio_device *gdev)
 static struct gpio_desc *gpio_name_to_desc(const char * const name)
 {
 	struct gpio_device *gdev;
-	unsigned long flags;
+	struct gpio_desc *desc;
 
 	if (!name)
 		return NULL;
 
-	spin_lock_irqsave(&gpio_lock, flags);
-
-	list_for_each_entry(gdev, &gpio_devices, list) {
-		struct gpio_desc *desc;
+	guard(srcu)(&gpio_devices_srcu);
 
+	list_for_each_entry_srcu(gdev, &gpio_devices, list,
+				 srcu_read_lock_held(&gpio_devices_srcu)) {
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
 
@@ -813,7 +817,6 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 			       struct lock_class_key *request_key)
 {
 	struct gpio_device *gdev;
-	unsigned long flags;
 	unsigned int i;
 	int base = 0;
 	int ret = 0;
@@ -878,49 +881,47 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 
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
-		base = gpiochip_find_base_unlocked(gc->ngpio);
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
+			base = gpiochip_find_base_unlocked(gc->ngpio);
+			if (base < 0) {
+				ret = base;
+				base = 0;
+				goto err_free_label;
+			}
+
+			/*
+			 * TODO: it should not be necessary to reflect the
+			 * assigned base outside of the GPIO subsystem. Go over
+			 * drivers and see if anyone makes use of this, else
+			 * drop this and assign a poison instead.
+			 */
+			gc->base = base;
+		} else {
+			dev_warn(&gdev->dev,
+				 "Static allocation of GPIO base is deprecated, use dynamic allocation.\n");
+		}
+
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
-	}
-	gdev->base = base;
-
-	ret = gpiodev_add_to_list_unlocked(gdev);
-	if (ret) {
-		spin_unlock_irqrestore(&gpio_lock, flags);
-		chip_err(gc, "GPIO integer space overlap, cannot add chip\n");
-		goto err_free_label;
 	}
 
 	for (i = 0; i < gc->ngpio; i++)
 		gdev->descs[i].gdev = gdev;
 
-	spin_unlock_irqrestore(&gpio_lock, flags);
-
 	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->line_state_notifier);
 	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->device_notifier);
 	init_rwsem(&gdev->sem);
@@ -1011,9 +1012,9 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 		goto err_print_message;
 	}
 err_remove_from_list:
-	spin_lock_irqsave(&gpio_lock, flags);
-	list_del(&gdev->list);
-	spin_unlock_irqrestore(&gpio_lock, flags);
+	scoped_guard(mutex, &gpio_devices_lock)
+		list_del_rcu(&gdev->list);
+	synchronize_srcu(&gpio_devices_srcu);
 err_free_label:
 	kfree_const(gdev->label);
 err_free_descs:
@@ -1076,8 +1077,9 @@ void gpiochip_remove(struct gpio_chip *gc)
 		dev_crit(&gdev->dev,
 			 "REMOVING GPIOCHIP WITH GPIOS STILL REQUESTED\n");
 
-	scoped_guard(spinlock_irqsave, &gpio_lock)
-		list_del(&gdev->list);
+	scoped_guard(mutex, &gpio_devices_lock)
+		list_del_rcu(&gdev->list);
+	synchronize_srcu(&gpio_devices_srcu);
 
 	/*
 	 * The gpiochip side puts its use of the device to rest here:
@@ -1125,7 +1127,7 @@ struct gpio_device *gpio_device_find(void *data,
 	 */
 	might_sleep();
 
-	guard(spinlock_irqsave)(&gpio_lock);
+	guard(srcu)(&gpio_devices_srcu);
 
 	list_for_each_entry(gdev, &gpio_devices, list) {
 		if (gdev->chip && match(gdev->chip, data))
@@ -4136,27 +4138,32 @@ static struct gpio_desc *gpiod_find_and_request(struct device *consumer,
 	struct gpio_desc *desc;
 	int ret;
 
-	desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx, &flags, &lookupflags);
-	if (gpiod_not_found(desc) && platform_lookup_allowed) {
+	scoped_guard(srcu, &gpio_devices_srcu) {
+		desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx,
+					    &flags, &lookupflags);
+		if (gpiod_not_found(desc) && platform_lookup_allowed) {
+			/*
+			 * Either we are not using DT or ACPI, or their lookup
+			 * did not return a result. In that case, use platform
+			 * lookup as a fallback.
+			 */
+			dev_dbg(consumer,
+				"using lookup tables for GPIO lookup\n");
+			desc = gpiod_find(consumer, con_id, idx, &lookupflags);
+		}
+
+		if (IS_ERR(desc)) {
+			dev_dbg(consumer, "No GPIO consumer %s found\n",
+				con_id);
+			return desc;
+		}
+
 		/*
-		 * Either we are not using DT or ACPI, or their lookup did not
-		 * return a result. In that case, use platform lookup as a
-		 * fallback.
+		 * If a connection label was passed use that, else attempt to use
+		 * the device name as label
 		 */
-		dev_dbg(consumer, "using lookup tables for GPIO lookup\n");
-		desc = gpiod_find(consumer, con_id, idx, &lookupflags);
+		ret = gpiod_request(desc, label);
 	}
-
-	if (IS_ERR(desc)) {
-		dev_dbg(consumer, "No GPIO consumer %s found\n", con_id);
-		return desc;
-	}
-
-	/*
-	 * If a connection label was passed use that, else attempt to use
-	 * the device name as label
-	 */
-	ret = gpiod_request(desc, label);
 	if (ret) {
 		if (!(ret == -EBUSY && flags & GPIOD_FLAGS_BIT_NONEXCLUSIVE))
 			return ERR_PTR(ret);
@@ -4727,35 +4734,33 @@ static void gpiolib_dbg_show(struct seq_file *s, struct gpio_device *gdev)
 
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
+	guard(srcu)(&gpio_devices_srcu);
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
+	scoped_guard(srcu, &gpio_devices_srcu) {
+		if (list_is_last(&gdev->list, &gpio_devices))
+			ret = NULL;
+		else
+			ret = list_first_entry(&gdev->list, struct gpio_device,
+					       list);
+	}
 
 	s->private = "\n";
 	++*pos;
-- 
2.40.1


