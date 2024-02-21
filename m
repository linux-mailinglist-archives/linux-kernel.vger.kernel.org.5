Return-Path: <linux-kernel+bounces-75553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA46C85EB15
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37D7C1F2828F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66B312FF8D;
	Wed, 21 Feb 2024 21:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HNyHBZD0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36C74A1D;
	Wed, 21 Feb 2024 21:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708551137; cv=none; b=Yk0vpahscdrBEzW9QuyYu65h9IrzivEWdHxCj08DMhFJwG4fD/ozJpO4/YVagnQFCT277vRi708HwlGpRrtxdRf1JnyP7lISewc8+nTyJXAgvsShn2+ULWZmQFynEvA9MzT801a+EHGpu3lcZ0ETxNGsbbXejYebqgnuIhyHkXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708551137; c=relaxed/simple;
	bh=5Uva8YDEN0rUVt5C1u0wSwbUxfvQOEp4RjJAzCn+7P4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=edjxW2JPDgHhKZoQP+82FaXpKMGfIh3lXPT99Hd78pn7Yaird2Z+Af90dbcdUUMODZWY0o3PCjLWqAwInfHOIifzz49/morEpn8AjYfQ/eh2Us7b4TTHBxatmNCubpBuHH6KWwMm67GbP/2C5juxY8zjhLgVe3/ahihqOUAmwPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HNyHBZD0; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708551136; x=1740087136;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5Uva8YDEN0rUVt5C1u0wSwbUxfvQOEp4RjJAzCn+7P4=;
  b=HNyHBZD0o29CRNTY98faoJ2MaPpBIpW50KURWpv3A1x4KJHWHXluX3Rg
   mjuVGG38iioCYeb+u/nYF9Ogt9+Ctt91qp3b7ZKmMm9DMQNWiPthkrsN0
   KqUH0wJ22rK1l09ZTSH/O1UXX6RiAPJGjjtX8q+Hyrd1HbR8xhGvgefCU
   v2ocMksJVQXeEx1qpMBw8zAVCRSceVRo0VuT/z125+9VsNSSw7JnmIge5
   2jSCSgNDQNAbAFzxH3OwwEAcEOZ7hxT/K6m2H4CyRmPyRZVJ/m4SwjA/y
   KuEZs4HxjwmPG1aiUDIkGTHs/hgFAFb8z224Gob5r5xg8FqL6sVXWM7Ws
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2850744"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="2850744"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 13:32:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="936706090"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="936706090"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 21 Feb 2024 13:32:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D3C771FD; Wed, 21 Feb 2024 23:32:11 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [rfc, PATCH v1 1/1] gpiolib: Get rid of never false gpio_is_valid() calls
Date: Wed, 21 Feb 2024 23:31:56 +0200
Message-ID: <20240221213208.17914-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the cases when gpio_is_valid() is called with unsigned parameter
the result is always true in the GPIO library code, hence the check
for false won't ever be true. Get rid of such calls.

While at it, move GPIO device base to be unsigned to clearly show
it won't ever be negative. This requires a new definition for the
maximum GPIO number in the system.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-legacy.c | 10 +++++-----
 drivers/gpio/gpiolib-sysfs.c  |  2 +-
 drivers/gpio/gpiolib.c        | 19 +++++++++----------
 drivers/gpio/gpiolib.h        |  2 +-
 include/linux/gpio.h          |  6 ++++++
 5 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/gpiolib-legacy.c b/drivers/gpio/gpiolib-legacy.c
index b138682fec3d..3392e758d36f 100644
--- a/drivers/gpio/gpiolib-legacy.c
+++ b/drivers/gpio/gpiolib-legacy.c
@@ -28,10 +28,9 @@ int gpio_request_one(unsigned gpio, unsigned long flags, const char *label)
 	struct gpio_desc *desc;
 	int err;
 
-	desc = gpio_to_desc(gpio);
-
 	/* Compatibility: assume unavailable "valid" GPIOs will appear later */
-	if (!desc && gpio_is_valid(gpio))
+	desc = gpio_to_desc(gpio);
+	if (!desc)
 		return -EPROBE_DEFER;
 
 	err = gpiod_request(desc, label);
@@ -63,10 +62,11 @@ EXPORT_SYMBOL_GPL(gpio_request_one);
  */
 int gpio_request(unsigned gpio, const char *label)
 {
-	struct gpio_desc *desc = gpio_to_desc(gpio);
+	struct gpio_desc *desc;
 
 	/* Compatibility: assume unavailable "valid" GPIOs will appear later */
-	if (!desc && gpio_is_valid(gpio))
+	desc = gpio_to_desc(gpio);
+	if (!desc)
 		return -EPROBE_DEFER;
 
 	return gpiod_request(desc, label);
diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 67fc09a57f26..cc5674937dd2 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -412,7 +412,7 @@ static ssize_t base_show(struct device *dev,
 {
 	const struct gpio_device *gdev = dev_get_drvdata(dev);
 
-	return sysfs_emit(buf, "%d\n", gdev->base);
+	return sysfs_emit(buf, "%u\n", gdev->base);
 }
 static DEVICE_ATTR_RO(base);
 
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 351b9d0f5682..1e70306d2c75 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -150,9 +150,6 @@ struct gpio_desc *gpio_to_desc(unsigned gpio)
 		}
 	}
 
-	if (!gpio_is_valid(gpio))
-		pr_warn("invalid GPIO %d\n", gpio);
-
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(gpio_to_desc);
@@ -297,10 +294,10 @@ struct gpio_chip *gpio_device_get_chip(struct gpio_device *gdev)
 EXPORT_SYMBOL_GPL(gpio_device_get_chip);
 
 /* dynamic allocation of GPIOs, e.g. on a hotplugged device */
-static int gpiochip_find_base_unlocked(int ngpio)
+static int gpiochip_find_base_unlocked(u16 ngpio)
 {
+	unsigned int base = GPIO_DYNAMIC_BASE;
 	struct gpio_device *gdev;
-	int base = GPIO_DYNAMIC_BASE;
 
 	list_for_each_entry_srcu(gdev, &gpio_devices, list,
 				 lockdep_is_held(&gpio_devices_lock)) {
@@ -311,9 +308,11 @@ static int gpiochip_find_base_unlocked(int ngpio)
 		base = gdev->base + gdev->ngpio;
 		if (base < GPIO_DYNAMIC_BASE)
 			base = GPIO_DYNAMIC_BASE;
+		if (base > GPIO_DYNAMIC_MAX - ngpio)
+			break;
 	}
 
-	if (gpio_is_valid(base)) {
+	if (base <= GPIO_DYNAMIC_MAX - ngpio) {
 		pr_debug("%s: found new base at %d\n", __func__, base);
 		return base;
 	} else {
@@ -746,7 +745,7 @@ static int gpiochip_setup_dev(struct gpio_device *gdev)
 	if (ret)
 		goto err_remove_device;
 
-	dev_dbg(&gdev->dev, "registered GPIOs %d to %d on %s\n", gdev->base,
+	dev_dbg(&gdev->dev, "registered GPIOs %u to %u on %s\n", gdev->base,
 		gdev->base + gdev->ngpio - 1, gdev->label);
 
 	return 0;
@@ -4797,14 +4796,14 @@ static void gpiolib_dbg_show(struct seq_file *s, struct gpio_device *gdev)
 			value = gpio_chip_get_value(gc, desc);
 			is_irq = test_bit(FLAG_USED_AS_IRQ, &desc->flags);
 			active_low = test_bit(FLAG_ACTIVE_LOW, &desc->flags);
-			seq_printf(s, " gpio-%-3d (%-20.20s|%-20.20s) %s %s %s%s\n",
+			seq_printf(s, " gpio-%-3u (%-20.20s|%-20.20s) %s %s %s%s\n",
 				   gpio, desc->name ?: "", gpiod_get_label(desc),
 				   is_out ? "out" : "in ",
 				   value >= 0 ? (value ? "hi" : "lo") : "?  ",
 				   is_irq ? "IRQ " : "",
 				   active_low ? "ACTIVE LOW" : "");
 		} else if (desc->name) {
-			seq_printf(s, " gpio-%-3d (%-20.20s)\n", gpio, desc->name);
+			seq_printf(s, " gpio-%-3u (%-20.20s)\n", gpio, desc->name);
 		}
 
 		gpio++;
@@ -4876,7 +4875,7 @@ static int gpiolib_seq_show(struct seq_file *s, void *v)
 		return 0;
 	}
 
-	seq_printf(s, "%s%s: GPIOs %d-%d", priv->newline ? "\n" : "",
+	seq_printf(s, "%s%s: GPIOs %u-%u", priv->newline ? "\n" : "",
 		   dev_name(&gdev->dev),
 		   gdev->base, gdev->base + gdev->ngpio - 1);
 	parent = gc->parent;
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index ada36aa0f81a..49715607c0db 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -61,7 +61,7 @@ struct gpio_device {
 	struct module		*owner;
 	struct gpio_chip __rcu	*chip;
 	struct gpio_desc	*descs;
-	int			base;
+	unsigned int		base;
 	u16			ngpio;
 	bool			can_sleep;
 	const char		*label;
diff --git a/include/linux/gpio.h b/include/linux/gpio.h
index 4aaedcf424ce..56ac7e7a2889 100644
--- a/include/linux/gpio.h
+++ b/include/linux/gpio.h
@@ -74,6 +74,12 @@ static inline bool gpio_is_valid(int number)
  * Until they are all fixed, leave 0-512 space for them.
  */
 #define GPIO_DYNAMIC_BASE	512
+/*
+ * Define the maximum of the possible GPIO in the global numberspace.
+ * While the GPIO base and numbers are positive, we limit it with signed
+ * maximum as a lot of code is using negative values for special cases.
+ */
+#define GPIO_DYNAMIC_MAX	INT_MAX
 
 /* Always use the library code for GPIO management calls,
  * or when sleeping may be involved.
-- 
2.43.0.rc1.1.gbec44491f096


