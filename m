Return-Path: <linux-kernel+bounces-57791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BC184DD77
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53AAA1F271CD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C466DCF9;
	Thu,  8 Feb 2024 09:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="YSkCSXKc"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B6A6BFC5
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386371; cv=none; b=QKXl1We+v3cXE+zD4ScH9fAP5k/xYSYK/ZEBaHACsFOG6cxO/1jRr/7xAPfZHwssW8p6RG9yVy2lwR5U2qZ+hyvwH+M3cRZPUQ4iegnlF81eBzM3/XiDpa3DaF/gu9A1tYFLEQ74IQ09voD9q/geGOaHT2mzQFDSZjx8sopxZWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386371; c=relaxed/simple;
	bh=r7k4ThFPIPCjUTp97jNbdGjayzkEWqIqnJHfC4InmdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fz7vfXutTsmWa2qIi9DmcQeTUu7o1Fvd1rGMlcB1p9dqrTPTLp11+re5SlEuaP8xNCEQK0H3afX7V/4z8YBTcZmJqayK+EoYyT0tLZpMRPx7RHy8EPLutp089C+q02rI+a62grfY5ycYnZu3XK55I7pm2Vsbj/lMNanJ72wFJQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=YSkCSXKc; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4103b399487so3161845e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 01:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707386367; x=1707991167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3h4gjaBErcezBWvS2amIavTmPxCKq+fozW11laYHipY=;
        b=YSkCSXKc79FNb+prYA2dZLxyjdXDLi9+S9tPmkthcnR81KHdAMy/C/c/ZNJhkZAY4y
         7CXWrHrtWTxw5NagrpVt7g094KwWBNjGHM8IDEnhIX4OflEyeZugDEMnAgVQHR3JueC6
         iy97aBq96tvomAywDYvyV54jSqWqT+uK1dt2jqoSU7BeCMa5HYKJ3vqM64XZbmwbJXZW
         Cqu6ADMTZsVW+ZYbdowrO0qH8cSK10YxC5Nb61aOPZI9ZrrpLH1BiYMMQQBR0cLIqcDS
         PxWgqxY2HyQyc/rZdO0rwDqDFVP1hWBoXiRkxFnhGWKlBDsc9CGWthl34mEDSZ9s4N2q
         zPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707386367; x=1707991167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3h4gjaBErcezBWvS2amIavTmPxCKq+fozW11laYHipY=;
        b=dfZRpj1nUL6272he8iQW4Bpf6kHR63kRz5Y+IyUC1vTlUSubBcfp5B33TkPVZKdBIy
         GhGIvea9VFjx4iMXX+J2ZgvNlzFS68RnZuGGzSBh4Pcc9x3UPgcUvgwl5xwnLpA5BbvJ
         iMcV43Wp3vlTHxxv3Xfyntgfy0MAXJJkmb62T/26h/gWeUB4cUpu383HnCw3dUy7JPs9
         bG+9d3u8+VATMaFioEBRBYUPD1O71G95KzOcD/JrgkLo9W6GhjvCdaKHf51z/kKnCaCv
         ni80V9eYDzM7516lJwHUiZdERKTj6EZXtqVlVNZQAlnNunREaTDY08GhW6gp5z0uuRDH
         cwfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7IeCcUGxRdpgn/v2TbdoO0eitcK1kKPi+9F72EXpyQJP+BZX+hlZhu2hENSMfY6lsUxhsnyz48VCujeHQX2/XA36T4nlBog6EXvqR
X-Gm-Message-State: AOJu0YzIpOgPZHO9xEkA9y+ZdUm3glfoOGDTtc3v4BF2UFzUtzkJoIts
	sV80Cex9FuskvVwfngfOvoMdkQZBH6yc6l/KRbiBgd4w7/oWGW4IRGOyNvXa5Eo=
X-Google-Smtp-Source: AGHT+IHJkJ94IQ7PWLqxB/B6uFdyiIvTAXiyEB/Yhwl5pcr97TP4U/XK5DBNNor916s9aiQ2pkHWJg==
X-Received: by 2002:a5d:5f8d:0:b0:33b:28c0:7c98 with SMTP id dr13-20020a5d5f8d000000b0033b28c07c98mr6267038wrb.61.1707386366835;
        Thu, 08 Feb 2024 01:59:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWWcL0nDh5pbSrUAT13GEBj1In0xAgGJ/LT0gPXmbIp5+nHc6DOzF3gsxtx2+sJYnYMx1kR9z04buwvUg09lJfAFYVs/BJPPkEXqVfBeMVmb1IcqOmAQ3HtGVBobKSYD495B9+DwTu4yeZEN53imeGymPEcuo0tY/hQdxiZnCRI/21wzdLqYuQp9MKprjVm+d9Ru6OSvnQyzZsuCTRXIAd9b7OU2qh2rq55HaT9yweqOC+8gG5X3iG4RiGwKVeSnVLmmria1LwTR2BUY6pYNf+o14ZoKzvLf5led4KACkSRrnQzP9QG/0Zoy4jVUqy8uIcT/H4HBLg6/uuwMFH4NW45GRLO1x83Ww==
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:44bd:e160:131:19a4])
        by smtp.gmail.com with ESMTPSA id x17-20020a5d60d1000000b0033af5086c2dsm3265963wrt.58.2024.02.08.01.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 01:59:26 -0800 (PST)
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
Subject: [PATCH v3 01/24] gpio: protect the list of GPIO devices with SRCU
Date: Thu,  8 Feb 2024 10:58:57 +0100
Message-Id: <20240208095920.8035-2-brgl@bgdev.pl>
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
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib.c | 251 ++++++++++++++++++++++-------------------
 1 file changed, 137 insertions(+), 114 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 3cad49363a72..181faeeceb3f 100644
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
 
@@ -752,7 +756,10 @@ static void gpiochip_setup_devs(void)
 	struct gpio_device *gdev;
 	int ret;
 
-	list_for_each_entry(gdev, &gpio_devices, list) {
+	guard(srcu)(&gpio_devices_srcu);
+
+	list_for_each_entry_srcu(gdev, &gpio_devices, list,
+				 srcu_read_lock_held(&gpio_devices_srcu)) {
 		ret = gpiochip_setup_dev(gdev);
 		if (ret)
 			dev_err(&gdev->dev,
@@ -817,7 +824,6 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 			       struct lock_class_key *request_key)
 {
 	struct gpio_device *gdev;
-	unsigned long flags;
 	unsigned int i;
 	int base = 0;
 	int ret = 0;
@@ -883,49 +889,47 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 
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
@@ -1016,9 +1020,9 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
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
@@ -1057,6 +1061,11 @@ void gpiochip_remove(struct gpio_chip *gc)
 	/* FIXME: should the legacy sysfs handling be moved to gpio_device? */
 	gpiochip_sysfs_unregister(gdev);
 	gpiochip_free_hogs(gc);
+
+	scoped_guard(mutex, &gpio_devices_lock)
+		list_del_rcu(&gdev->list);
+	synchronize_srcu(&gpio_devices_srcu);
+
 	/* Numb the device, cancelling all outstanding operations */
 	gdev->chip = NULL;
 	gpiochip_irqchip_remove(gc);
@@ -1081,9 +1090,6 @@ void gpiochip_remove(struct gpio_chip *gc)
 		dev_crit(&gdev->dev,
 			 "REMOVING GPIOCHIP WITH GPIOS STILL REQUESTED\n");
 
-	scoped_guard(spinlock_irqsave, &gpio_lock)
-		list_del(&gdev->list);
-
 	/*
 	 * The gpiochip side puts its use of the device to rest here:
 	 * if there are no userspace clients, the chardev and device will
@@ -1130,7 +1136,7 @@ struct gpio_device *gpio_device_find(void *data,
 	 */
 	might_sleep();
 
-	guard(spinlock_irqsave)(&gpio_lock);
+	guard(srcu)(&gpio_devices_srcu);
 
 	list_for_each_entry(gdev, &gpio_devices, list) {
 		if (gdev->chip && match(gdev->chip, data))
@@ -4138,30 +4144,39 @@ static struct gpio_desc *gpiod_find_and_request(struct device *consumer,
 						bool platform_lookup_allowed)
 {
 	unsigned long lookupflags = GPIO_LOOKUP_FLAGS_DEFAULT;
-	struct gpio_desc *desc;
-	int ret;
-
-	desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx, &flags, &lookupflags);
-	if (gpiod_not_found(desc) && platform_lookup_allowed) {
-		/*
-		 * Either we are not using DT or ACPI, or their lookup did not
-		 * return a result. In that case, use platform lookup as a
-		 * fallback.
-		 */
-		dev_dbg(consumer, "using lookup tables for GPIO lookup\n");
-		desc = gpiod_find(consumer, con_id, idx, &lookupflags);
-	}
-
-	if (IS_ERR(desc)) {
-		dev_dbg(consumer, "No GPIO consumer %s found\n", con_id);
-		return desc;
-	}
-
 	/*
-	 * If a connection label was passed use that, else attempt to use
-	 * the device name as label
+	 * scoped_guard() is implemented as a for loop, meaning static
+	 * analyzers will complain about these two not being initialized.
 	 */
-	ret = gpiod_request(desc, label);
+	struct gpio_desc *desc = NULL;
+	int ret = 0;
+
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
+		/*
+		 * If a connection label was passed use that, else attempt to use
+		 * the device name as label
+		 */
+		ret = gpiod_request(desc, label);
+	}
 	if (ret) {
 		if (!(ret == -EBUSY && flags & GPIOD_FLAGS_BIT_NONEXCLUSIVE))
 			return ERR_PTR(ret);
@@ -4730,61 +4745,69 @@ static void gpiolib_dbg_show(struct seq_file *s, struct gpio_device *gdev)
 	}
 }
 
+struct gpiolib_seq_priv {
+	bool newline;
+	int idx;
+};
+
 static void *gpiolib_seq_start(struct seq_file *s, loff_t *pos)
 {
-	unsigned long flags;
-	struct gpio_device *gdev = NULL;
+	struct gpiolib_seq_priv *priv;
+	struct gpio_device *gdev;
 	loff_t index = *pos;
 
-	s->private = "";
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return NULL;
 
-	spin_lock_irqsave(&gpio_lock, flags);
-	list_for_each_entry(gdev, &gpio_devices, list)
-		if (index-- == 0) {
-			spin_unlock_irqrestore(&gpio_lock, flags);
+	s->private = priv;
+	priv->idx = srcu_read_lock(&gpio_devices_srcu);
+
+	list_for_each_entry_srcu(gdev, &gpio_devices, list,
+				 srcu_read_lock_held(&gpio_devices_srcu)) {
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
-	struct gpio_device *gdev = v;
-	void *ret = NULL;
+	struct gpiolib_seq_priv *priv = s->private;
+	struct gpio_device *gdev = v, *next;
 
-	spin_lock_irqsave(&gpio_lock, flags);
-	if (list_is_last(&gdev->list, &gpio_devices))
-		ret = NULL;
-	else
-		ret = list_first_entry(&gdev->list, struct gpio_device, list);
-	spin_unlock_irqrestore(&gpio_lock, flags);
-
-	s->private = "\n";
+	next = list_entry_rcu(gdev->list.next, struct gpio_device, list);
+	gdev = &next->list == &gpio_devices ? NULL : next;
+	priv->newline = true;
 	++*pos;
 
-	return ret;
+	return gdev;
 }
 
 static void gpiolib_seq_stop(struct seq_file *s, void *v)
 {
+	struct gpiolib_seq_priv *priv = s->private;
+
+	srcu_read_unlock(&gpio_devices_srcu, priv->idx);
+	kfree(priv);
 }
 
 static int gpiolib_seq_show(struct seq_file *s, void *v)
 {
+	struct gpiolib_seq_priv *priv = s->private;
 	struct gpio_device *gdev = v;
 	struct gpio_chip *gc = gdev->chip;
 	struct device *parent;
 
 	if (!gc) {
-		seq_printf(s, "%s%s: (dangling chip)", (char *)s->private,
+		seq_printf(s, "%s%s: (dangling chip)",
+			   priv->newline ? "\n" : "",
 			   dev_name(&gdev->dev));
 		return 0;
 	}
 
-	seq_printf(s, "%s%s: GPIOs %d-%d", (char *)s->private,
+	seq_printf(s, "%s%s: GPIOs %d-%d", priv->newline ? "\n" : "",
 		   dev_name(&gdev->dev),
 		   gdev->base, gdev->base + gdev->ngpio - 1);
 	parent = gc->parent;
-- 
2.40.1


