Return-Path: <linux-kernel+bounces-119671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF04288CBCB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FD36340157
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3741A86246;
	Tue, 26 Mar 2024 18:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SMgJr31m"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338FD129A81;
	Tue, 26 Mar 2024 18:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476781; cv=none; b=mJh/p8WoWDKbwjadux6NLFp8MyPEQNL2JPwLROfirTZnZwDaSfLN2KT6cQKoHiRbwafuAB9ypwIghKHDqwoyY0TVMt7LJorpBg5sdLzC6WMizsP2HDAQnO6/gP2IEoi1b1J+2Nu8dRO/FP929Z7FqqSrPs58LOl3eJSjTtrX9Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476781; c=relaxed/simple;
	bh=XtV1Y6RFIP1Hj+p62eOwVbm/HSH/THX2gCTDKKDMo7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cIbwqmz3uEMk61WwygfL5B1aoLjP8qm58TZKvPQxaVh82fZQjsEl3x3DrepHHu78ZKvDp/DcxGRui/frMWr00bH1sh+j+5j6SJbAKSQzQzRQLz7nddDjtZsbr4S3gOdGfpfFBpOs4dasELwPjw22rA1s6fpBOhdTBN6tEc3qsB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SMgJr31m; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711476777; x=1743012777;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XtV1Y6RFIP1Hj+p62eOwVbm/HSH/THX2gCTDKKDMo7I=;
  b=SMgJr31mZr94RlFBNfjcamy/4l6ADGda9MdTtgCdcyek7X82kghDLBLy
   o9Vhx1icmmdf6nLFHSogYZctNQllbieCW8ykeqvEkX4bz+6uOsL6IKIHG
   8vPE/t6H+7Y2Q8XjxQBx5DMrUo1G+2F4dElm/bKryw8CBI+Jup0LjDPk9
   /3HrEwTFNFSAbh5s8xZEo5rk2uUhT75oCcMrIi20SIYn8FpinP/GNaDvw
   S6611/Hm3bCNBBNmBaYeNb7JY4ZZdqeUY2t1VsTVtu/R8PX/0Q/BrXjgS
   onLgLKY8wijtGckRwMuu6zDCGXrHDhmdRHthBtNPeyozaqLSEOuLh3CrZ
   A==;
X-CSE-ConnectionGUID: n4D1dZDHTUa25DkSLHWLmg==
X-CSE-MsgGUID: T9d6i9ZqRrGPhStteMjQTg==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="10325999"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="10325999"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 11:12:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="937072948"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="937072948"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Mar 2024 11:12:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4C1EB524; Tue, 26 Mar 2024 20:12:52 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Kent Gibson <warthog618@gmail.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 2/2] gpiolib: Up to date the kernel documentation
Date: Tue, 26 Mar 2024 20:11:21 +0200
Message-ID: <20240326181247.1419138-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240326181247.1419138-1-andriy.shevchenko@linux.intel.com>
References: <20240326181247.1419138-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are several issues:

- Reference to the non-existing or only single functions out of possible
  callees

- No return section

$ scripts/kernel-doc -v -none -Wall drivers/gpio/gpiolib* 2>&1 | grep -w warning | wc -l
67

- Reference to NULL as %NULL in a few cases

- Explicit reference to error codes as Exxx or %Exxx and
  numbers with leading %

- Spelling of gpio, irq, SOC (in different capitalization)

- Unaligned style of irqchip, gpiochip references

- Unaligned style of NOTE, FIXME, and TODO

Fix all these. While at it, fix multi-line comment style as well.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c   |  45 ++--
 drivers/gpio/gpiolib-cdev.c   |  15 +-
 drivers/gpio/gpiolib-devres.c |  85 ++++++--
 drivers/gpio/gpiolib-legacy.c |   3 +
 drivers/gpio/gpiolib-of.c     | 102 +++++----
 drivers/gpio/gpiolib-swnode.c |   8 +-
 drivers/gpio/gpiolib-sysfs.c  |  41 ++--
 drivers/gpio/gpiolib.c        | 383 +++++++++++++++++++++-------------
 drivers/gpio/gpiolib.h        |   8 +-
 9 files changed, 434 insertions(+), 256 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 7f140df40f35..dfcfa23e7a59 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -136,8 +136,12 @@ static int acpi_gpiochip_find(struct gpio_chip *gc, const void *data)
  * @path:	ACPI GPIO controller full path name, (e.g. "\\_SB.GPO1")
  * @pin:	ACPI GPIO pin number (0-based, controller-relative)
  *
- * Return: GPIO descriptor to use with Linux generic GPIO API, or ERR_PTR
- * error value. Specifically returns %-EPROBE_DEFER if the referenced GPIO
+ * Returns:
+ * GPIO descriptor to use with Linux generic GPIO API.
+ * If the GPIO cannot be translated or there is an error an ERR_PTR is
+ * returned.
+ *
+ * Specifically returns -EPROBE_DEFER if the referenced GPIO
  * controller does not have GPIO chip registered at the moment. This is to
  * support probe deferral.
  */
@@ -156,7 +160,7 @@ static struct gpio_desc *acpi_get_gpiod(char *path, unsigned int pin)
 		return ERR_PTR(-EPROBE_DEFER);
 
 	/*
-	 * FIXME: keep track of the reference to the GPIO device somehow
+	 * FIXME: Keep track of the reference to the GPIO device somehow
 	 * instead of putting it here.
 	 */
 	return gpio_device_get_desc(gdev, pin);
@@ -203,10 +207,12 @@ bool acpi_gpio_get_irq_resource(struct acpi_resource *ares,
 EXPORT_SYMBOL_GPL(acpi_gpio_get_irq_resource);
 
 /**
- * acpi_gpio_get_io_resource - Fetch details of an ACPI resource if it is a GPIO
- *			       I/O resource or return False if not.
+ * acpi_gpio_get_io_resource - Fetch details of an ACPI resource if it is a GpioIo resource
  * @ares:	Pointer to the ACPI resource to fetch
  * @agpio:	Pointer to a &struct acpi_resource_gpio to store the output pointer
+ *
+ * Returns:
+ * true if GpioIo resource is found, false otherwise.
  */
 bool acpi_gpio_get_io_resource(struct acpi_resource *ares,
 			       struct acpi_resource_gpio **agpio)
@@ -487,7 +493,7 @@ static acpi_status acpi_gpiochip_alloc_event(struct acpi_resource *ares,
 }
 
 /**
- * acpi_gpiochip_request_interrupts() - Register isr for gpio chip ACPI events
+ * acpi_gpiochip_request_interrupts() - Register isr for GPIO chip ACPI events
  * @chip:      GPIO chip
  *
  * ACPI5 platforms can use GPIO signaled ACPI events. These GPIO interrupts are
@@ -664,7 +670,7 @@ __acpi_gpio_update_gpiod_flags(enum gpiod_flags *flags, enum gpiod_flags update)
 		 * Check if caller supplied incompatible GPIO initialization
 		 * flags.
 		 *
-		 * Return %-EINVAL to notify that firmware has different
+		 * Return -EINVAL to notify that firmware has different
 		 * settings and we are going to use them.
 		 */
 		if (((*flags & GPIOD_FLAGS_BIT_DIR_SET) && (diff & GPIOD_FLAGS_BIT_DIR_OUT)) ||
@@ -764,7 +770,7 @@ static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
 		/*
 		 * Polarity and triggering are only specified for GpioInt
 		 * resource.
-		 * Note: we expect here:
+		 * NOTE: We expect here:
 		 * - ACPI_ACTIVE_LOW == GPIO_ACTIVE_LOW
 		 * - ACPI_ACTIVE_HIGH == GPIO_ACTIVE_HIGH
 		 */
@@ -847,22 +853,24 @@ static int acpi_gpio_property_lookup(struct fwnode_handle *fwnode,
  * acpi_get_gpiod_by_index() - get a GPIO descriptor from device resources
  * @adev: pointer to a ACPI device to get GPIO from
  * @propname: Property name of the GPIO (optional)
- * @index: index of GpioIo/GpioInt resource (starting from %0)
+ * @index: index of GpioIo/GpioInt resource (starting from 0)
  * @info: info pointer to fill in (optional)
  *
  * Function goes through ACPI resources for @adev and based on @index looks
  * up a GpioIo/GpioInt resource, translates it to the Linux GPIO descriptor,
  * and returns it. @index matches GpioIo/GpioInt resources only so if there
- * are total %3 GPIO resources, the index goes from %0 to %2.
+ * are total 3 GPIO resources, the index goes from 0 to 2.
  *
  * If @propname is specified the GPIO is looked using device property. In
  * that case @index is used to select the GPIO entry in the property value
  * (in case of multiple).
  *
- * If the GPIO cannot be translated or there is an error, an ERR_PTR is
+ * Returns:
+ * GPIO descriptor to use with Linux generic GPIO API.
+ * If the GPIO cannot be translated or there is an error an ERR_PTR is
  * returned.
  *
- * Note: if the GPIO resource has multiple entries in the pin list, this
+ * NOTE: If the GPIO resource has multiple entries in the pin list, this
  * function only returns the first.
  */
 static struct gpio_desc *acpi_get_gpiod_by_index(struct acpi_device *adev,
@@ -903,13 +911,15 @@ static struct gpio_desc *acpi_get_gpiod_by_index(struct acpi_device *adev,
  * acpi_get_gpiod_from_data() - get a GPIO descriptor from ACPI data node
  * @fwnode: pointer to an ACPI firmware node to get the GPIO information from
  * @propname: Property name of the GPIO
- * @index: index of GpioIo/GpioInt resource (starting from %0)
+ * @index: index of GpioIo/GpioInt resource (starting from 0)
  * @info: info pointer to fill in (optional)
  *
  * This function uses the property-based GPIO lookup to get to the GPIO
  * resource with the relevant information from a data-only ACPI firmware node
  * and uses that to obtain the GPIO descriptor to return.
  *
+ * Returns:
+ * GPIO descriptor to use with Linux generic GPIO API.
  * If the GPIO cannot be translated or there is an error an ERR_PTR is
  * returned.
  */
@@ -1007,7 +1017,7 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
  * acpi_dev_gpio_irq_wake_get_by() - Find GpioInt and translate it to Linux IRQ number
  * @adev: pointer to a ACPI device to get IRQ from
  * @name: optional name of GpioInt resource
- * @index: index of GpioInt resource (starting from %0)
+ * @index: index of GpioInt resource (starting from 0)
  * @wake_capable: Set to true if the IRQ is wake capable
  *
  * If the device has one or more GpioInt resources, this function can be
@@ -1023,7 +1033,8 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
  * The GPIO is considered wake capable if the GpioInt resource specifies
  * SharedAndWake or ExclusiveAndWake.
  *
- * Return: Linux IRQ number (> %0) on success, negative errno on failure.
+ * Returns:
+ * Linux IRQ number (> 0) on success, negative errno on failure.
  */
 int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *name, int index,
 				  bool *wake_capable)
@@ -1406,8 +1417,8 @@ static int acpi_find_gpio_count(struct acpi_resource *ares, void *data)
  * @fwnode:	firmware node of the GPIO consumer
  * @con_id:	function within the GPIO consumer
  *
- * Return:
- * The number of GPIOs associated with a firmware node / function or %-ENOENT,
+ * Returns:
+ * The number of GPIOs associated with a firmware node / function or -ENOENT,
  * if no GPIO has been assigned to the requested function.
  */
 int acpi_gpio_count(const struct fwnode_handle *fwnode, const char *con_id)
diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index f384fa278764..b4369a8b4381 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -54,7 +54,8 @@ static_assert(IS_ALIGNED(sizeof(struct gpio_v2_line_info_changed), 8));
 static_assert(IS_ALIGNED(sizeof(struct gpio_v2_line_event), 8));
 static_assert(IS_ALIGNED(sizeof(struct gpio_v2_line_values), 8));
 
-/* Character device interface to GPIO.
+/*
+ * Character device interface to GPIO.
  *
  * The GPIO character device, /dev/gpiochipN, provides userspace an
  * interface to gpiolib GPIOs via ioctl()s.
@@ -531,7 +532,7 @@ static DEFINE_SPINLOCK(supinfo_lock);
  * @event_buffer_size: the number of elements allocated in @events
  * @events: KFIFO for the GPIO events
  * @seqno: the sequence number for edge events generated on all lines in
- * this line request.  Note that this is not used when @num_lines is 1, as
+ * this line request.  NOTE: This is not used when @num_lines is 1, as
  * the line_seqno is then the same and is cheaper to calculate.
  * @config_mutex: mutex for serializing ioctl() calls to ensure consistency
  * of configuration, particularly multi-step accesses to desc flags and
@@ -2684,7 +2685,9 @@ static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
  * gpio_chrdev_open() - open the chardev for ioctl operations
  * @inode: inode for this chardev
  * @file: file struct for storing private data
- * Returns 0 on success
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 static int gpio_chrdev_open(struct inode *inode, struct file *file)
 {
@@ -2695,7 +2698,7 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 
 	guard(srcu)(&gdev->srcu);
 
-	/* Fail on open if the backing gpiochip is gone */
+	/* Fail on open if the backing GPIO chip is gone */
 	if (!rcu_access_pointer(gdev->chip))
 		return -ENODEV;
 
@@ -2750,7 +2753,9 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
  * gpio_chrdev_release() - close chardev after ioctl operations
  * @inode: inode for this chardev
  * @file: file struct for storing private data
- * Returns 0 on success
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 static int gpio_chrdev_release(struct inode *inode, struct file *file)
 {
diff --git a/drivers/gpio/gpiolib-devres.c b/drivers/gpio/gpiolib-devres.c
index 4987e62dcb3d..20e3eae785b6 100644
--- a/drivers/gpio/gpiolib-devres.c
+++ b/drivers/gpio/gpiolib-devres.c
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * devres.c - managed gpio resources
+ * Managed GPIO resources.
  * This file is based on kernel/irq/devres.c
  *
  * Copyright (c) 2011 John Crispin <john@phrozen.org>
@@ -52,6 +52,11 @@ static int devm_gpiod_match_array(struct device *dev, void *res, void *data)
  * Managed gpiod_get(). GPIO descriptors returned from this function are
  * automatically disposed on driver detach. See gpiod_get() for detailed
  * information about behavior and return values.
+ *
+ * Returns:
+ * The GPIO descriptor corresponding to the function @con_id of device
+ * dev, -ENOENT if no GPIO has been assigned to the requested function, or
+ * another IS_ERR() code if an error occurred while trying to acquire the GPIO.
  */
 struct gpio_desc *__must_check devm_gpiod_get(struct device *dev,
 					      const char *con_id,
@@ -70,6 +75,11 @@ EXPORT_SYMBOL_GPL(devm_gpiod_get);
  * Managed gpiod_get_optional(). GPIO descriptors returned from this function
  * are automatically disposed on driver detach. See gpiod_get_optional() for
  * detailed information about behavior and return values.
+ *
+ * Returns:
+ * The GPIO descriptor corresponding to the function @con_id of device
+ * dev, NULL if no GPIO has been assigned to the requested function, or
+ * another IS_ERR() code if an error occurred while trying to acquire the GPIO.
  */
 struct gpio_desc *__must_check devm_gpiod_get_optional(struct device *dev,
 						       const char *con_id,
@@ -89,6 +99,11 @@ EXPORT_SYMBOL_GPL(devm_gpiod_get_optional);
  * Managed gpiod_get_index(). GPIO descriptors returned from this function are
  * automatically disposed on driver detach. See gpiod_get_index() for detailed
  * information about behavior and return values.
+ *
+ * Returns:
+ * The GPIO descriptor corresponding to the function @con_id of device
+ * dev, -ENOENT if no GPIO has been assigned to the requested function, or
+ * another IS_ERR() code if an error occurred while trying to acquire the GPIO.
  */
 struct gpio_desc *__must_check devm_gpiod_get_index(struct device *dev,
 						    const char *con_id,
@@ -141,8 +156,10 @@ EXPORT_SYMBOL_GPL(devm_gpiod_get_index);
  * GPIO descriptors returned from this function are automatically disposed on
  * driver detach.
  *
- * On successful request the GPIO pin is configured in accordance with
- * provided @flags.
+ * Returns:
+ * The GPIO descriptor corresponding to the function @con_id of device
+ * dev, -ENOENT if no GPIO has been assigned to the requested function, or
+ * another IS_ERR() code if an error occurred while trying to acquire the GPIO.
  */
 struct gpio_desc *devm_fwnode_gpiod_get_index(struct device *dev,
 					      struct fwnode_handle *fwnode,
@@ -182,6 +199,11 @@ EXPORT_SYMBOL_GPL(devm_fwnode_gpiod_get_index);
  * function are automatically disposed on driver detach. See
  * gpiod_get_index_optional() for detailed information about behavior and
  * return values.
+ *
+ * Returns:
+ * The GPIO descriptor corresponding to the function @con_id of device
+ * dev, NULL if no GPIO has been assigned to the requested function, or
+ * another IS_ERR() code if an error occurred while trying to acquire the GPIO.
  */
 struct gpio_desc *__must_check devm_gpiod_get_index_optional(struct device *dev,
 							     const char *con_id,
@@ -207,6 +229,12 @@ EXPORT_SYMBOL_GPL(devm_gpiod_get_index_optional);
  * Managed gpiod_get_array(). GPIO descriptors returned from this function are
  * automatically disposed on driver detach. See gpiod_get_array() for detailed
  * information about behavior and return values.
+ *
+ * Returns:
+ * The GPIO descriptors corresponding to the function @con_id of device
+ * dev, -ENOENT if no GPIO has been assigned to the requested function,
+ * or another IS_ERR() code if an error occurred while trying to acquire
+ * the GPIOs.
  */
 struct gpio_descs *__must_check devm_gpiod_get_array(struct device *dev,
 						     const char *con_id,
@@ -243,6 +271,12 @@ EXPORT_SYMBOL_GPL(devm_gpiod_get_array);
  * function are automatically disposed on driver detach.
  * See gpiod_get_array_optional() for detailed information about behavior and
  * return values.
+ *
+ * Returns:
+ * The GPIO descriptors corresponding to the function @con_id of device
+ * dev, NULL if no GPIO has been assigned to the requested function,
+ * or another IS_ERR() code if an error occurred while trying to acquire
+ * the GPIOs.
  */
 struct gpio_descs *__must_check
 devm_gpiod_get_array_optional(struct device *dev, const char *con_id,
@@ -275,7 +309,7 @@ void devm_gpiod_put(struct device *dev, struct gpio_desc *desc)
 EXPORT_SYMBOL_GPL(devm_gpiod_put);
 
 /**
- * devm_gpiod_unhinge - Remove resource management from a gpio descriptor
+ * devm_gpiod_unhinge - Remove resource management from a GPIO descriptor
  * @dev:	GPIO consumer
  * @desc:	GPIO descriptor to remove resource management from
  *
@@ -283,7 +317,6 @@ EXPORT_SYMBOL_GPL(devm_gpiod_put);
  * you want to hand over lifecycle management of a descriptor to another
  * mechanism.
  */
-
 void devm_gpiod_unhinge(struct device *dev, struct gpio_desc *desc)
 {
 	int ret;
@@ -328,15 +361,20 @@ static void devm_gpio_release(struct device *dev, void *res)
 }
 
 /**
- *      devm_gpio_request - request a GPIO for a managed device
- *      @dev: device to request the GPIO for
- *      @gpio: GPIO to allocate
- *      @label: the name of the requested GPIO
+ * devm_gpio_request - request a GPIO for a managed device
+ * @dev: device to request the GPIO for
+ * @gpio: GPIO to allocate
+ * @label: the name of the requested GPIO
  *
- *      Except for the extra @dev argument, this function takes the
- *      same arguments and performs the same function as
- *      gpio_request().  GPIOs requested with this function will be
- *      automatically freed on driver detach.
+ * Except for the extra @dev argument, this function takes the
+ * same arguments and performs the same function as gpio_request().
+ * GPIOs requested with this function will be automatically freed
+ * on driver detach.
+ *
+ * **DEPRECATED** This function is deprecated and must not be used in new code.
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int devm_gpio_request(struct device *dev, unsigned gpio, const char *label)
 {
@@ -361,11 +399,16 @@ int devm_gpio_request(struct device *dev, unsigned gpio, const char *label)
 EXPORT_SYMBOL_GPL(devm_gpio_request);
 
 /**
- *	devm_gpio_request_one - request a single GPIO with initial setup
- *	@dev:   device to request for
- *	@gpio:	the GPIO number
- *	@flags:	GPIO configuration as specified by GPIOF_*
- *	@label:	a literal description string of this GPIO
+ * devm_gpio_request_one - request a single GPIO with initial setup
+ * @dev: device to request for
+ * @gpio: the GPIO number
+ * @flags: GPIO configuration as specified by GPIOF_*
+ * @label: a literal description string of this GPIO
+ *
+ * **DEPRECATED** This function is deprecated and must not be used in new code.
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int devm_gpio_request_one(struct device *dev, unsigned gpio,
 			  unsigned long flags, const char *label)
@@ -399,15 +442,15 @@ static void devm_gpio_chip_release(void *data)
 
 /**
  * devm_gpiochip_add_data_with_key() - Resource managed gpiochip_add_data_with_key()
- * @dev: pointer to the device that gpio_chip belongs to.
+ * @dev: pointer to the device that GPIO chip belongs to.
  * @gc: the GPIO chip to register
  * @data: driver-private data associated with this chip
  * @lock_key: lockdep class for IRQ lock
  * @request_key: lockdep class for IRQ request
  *
- * Context: potentially before irqs will work
+ * Context: potentially before IRQs will work
  *
- * The gpio chip automatically be released when the device is unbound.
+ * The GPIO chip automatically be released when the device is unbound.
  *
  * Returns:
  * A negative errno if the chip can't be registered, such as because the
diff --git a/drivers/gpio/gpiolib-legacy.c b/drivers/gpio/gpiolib-legacy.c
index 5a9911ae9125..d27142418f9f 100644
--- a/drivers/gpio/gpiolib-legacy.c
+++ b/drivers/gpio/gpiolib-legacy.c
@@ -22,6 +22,9 @@ EXPORT_SYMBOL_GPL(gpio_free);
  * @label:	a literal description string of this GPIO
  *
  * **DEPRECATED** This function is deprecated and must not be used in new code.
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpio_request_one(unsigned gpio, unsigned long flags, const char *label)
 {
diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index cb0cefaec37e..7c0e2528d097 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -43,22 +43,25 @@ enum of_gpio_flags {
 /**
  * of_gpio_named_count() - Count GPIOs for a device
  * @np:		device node to count GPIOs for
- * @propname:	property name containing gpio specifier(s)
+ * @propname:	property name containing GPIO specifier(s)
  *
  * The function returns the count of GPIOs specified for a node.
- * Note that the empty GPIO specifiers count too. Returns either
- *   Number of gpios defined in property,
- *   -EINVAL for an incorrectly formed gpios property, or
- *   -ENOENT for a missing gpios property
+ * NOTE: The empty GPIO specifiers count too.
  *
- * Example:
- * gpios = <0
- *          &gpio1 1 2
- *          0
- *          &gpio2 3 4>;
+ * Returns:
+ * Either number of GPIOs defined in the property, or
+ * *  -EINVAL for an incorrectly formed "gpios" property, or
+ * *  -ENOENT for a missing "gpios" property.
+ *
+ * Example::
+ *
+ *     gpios = <0
+ *              &gpio1 1 2
+ *              0
+ *              &gpio2 3 4>;
  *
  * The above example defines four GPIOs, two of which are not specified.
- * This function will return '4'
+ * This function will return '4'.
  */
 static int of_gpio_named_count(const struct device_node *np,
 			       const char *propname)
@@ -77,6 +80,11 @@ static int of_gpio_named_count(const struct device_node *np,
  * "gpios" for the chip select lines. If we detect this, we redirect
  * the counting of "cs-gpios" to count "gpios" transparent to the
  * driver.
+ *
+ * Returns:
+ * Either number of GPIOs defined in the property, or
+ * *  -EINVAL for an incorrectly formed "gpios" property, or
+ * *  -ENOENT for a missing "gpios" property.
  */
 static int of_gpio_spi_cs_get_count(const struct device_node *np,
 				    const char *con_id)
@@ -151,7 +159,7 @@ static struct gpio_desc *of_xlate_and_get_gpiod_flags(struct gpio_chip *chip,
 }
 
 /*
- * Overrides stated polarity of a gpio line and warns when there is a
+ * Overrides stated polarity of a GPIO line and warns when there is a
  * discrepancy.
  */
 static void of_gpio_quirk_polarity(const struct device_node *np,
@@ -174,7 +182,7 @@ static void of_gpio_quirk_polarity(const struct device_node *np,
 
 /*
  * This quirk does static polarity overrides in cases where existing
- * DTS specified incorrect polarity.
+ * device tree specified incorrect polarity.
  */
 static void of_gpio_try_fixup_polarity(const struct device_node *np,
 				       const char *propname,
@@ -275,7 +283,7 @@ static void of_gpio_set_polarity_by_property(const struct device_node *np,
 #if IS_ENABLED(CONFIG_MMC_ATMELMCI)
 	/*
 	 * The Atmel HSMCI has compatible property in the parent node and
-	 * gpio property in a child node
+	 * GPIO property in a child node.
 	 */
 	if (of_device_is_compatible(np->parent, "atmel,hsmci")) {
 		np_compat = np->parent;
@@ -361,11 +369,12 @@ static void of_gpio_flags_quirks(const struct device_node *np,
 /**
  * of_get_named_gpiod_flags() - Get a GPIO descriptor and flags for GPIO API
  * @np:		device node to get GPIO from
- * @propname:	property name containing gpio specifier(s)
+ * @propname:	property name containing GPIO specifier(s)
  * @index:	index of the GPIO
  * @flags:	a flags pointer to fill in
  *
- * Returns GPIO descriptor to use with Linux GPIO API, or one of the errno
+ * Returns:
+ * GPIO descriptor to use with Linux GPIO API, or one of the errno
  * value on the error condition. If @flags is not NULL the function also fills
  * in flags for the GPIO.
  */
@@ -412,12 +421,13 @@ static struct gpio_desc *of_get_named_gpiod_flags(const struct device_node *np,
 /**
  * of_get_named_gpio() - Get a GPIO number to use with GPIO API
  * @np:		device node to get GPIO from
- * @propname:	Name of property containing gpio specifier(s)
+ * @propname:	Name of property containing GPIO specifier(s)
  * @index:	index of the GPIO
  *
  * **DEPRECATED** This function is deprecated and must not be used in new code.
  *
- * Returns GPIO number to use with Linux generic GPIO API, or one of the errno
+ * Returns:
+ * GPIO number to use with Linux generic GPIO API, or one of the errno
  * value on the error condition.
  */
 int of_get_named_gpio(const struct device_node *np, const char *propname,
@@ -475,7 +485,7 @@ static struct gpio_desc *of_find_gpio_rename(struct device_node *np,
 		/*
 		 * Compatible string can be set to NULL in case where
 		 * matching to a particular compatible is not practical,
-		 * but it should only be done for gpio names that have
+		 * but it should only be done for GPIO names that have
 		 * vendor prefix to reduce risk of false positives.
 		 * Addition of such entries is strongly discouraged.
 		 */
@@ -587,7 +597,7 @@ static struct gpio_desc *of_find_gpio_rename(struct device_node *np,
 		legacy_id = gpios[i].legacy_id ?: gpios[i].con_id;
 		desc = of_get_named_gpiod_flags(np, legacy_id, idx, of_flags);
 		if (!gpiod_not_found(desc)) {
-			pr_info("%s uses legacy gpio name '%s' instead of '%s-gpios'\n",
+			pr_info("%s uses legacy GPIO name '%s' instead of '%s-gpios'\n",
 				of_node_full_name(np), legacy_id, con_id);
 			return desc;
 		}
@@ -622,7 +632,7 @@ static struct gpio_desc *of_find_mt2701_gpio(struct device_node *np,
 
 	desc = of_get_named_gpiod_flags(np, legacy_id, 0, of_flags);
 	if (!gpiod_not_found(desc))
-		pr_info("%s is using legacy gpio name '%s' instead of '%s-gpios'\n",
+		pr_info("%s is using legacy GPIO name '%s' instead of '%s-gpios'\n",
 			of_node_full_name(np), legacy_id, con_id);
 
 	return desc;
@@ -654,7 +664,6 @@ static struct gpio_desc *of_find_trigger_gpio(struct device_node *np,
 	return desc;
 }
 
-
 typedef struct gpio_desc *(*of_find_gpio_quirk)(struct device_node *np,
 						const char *con_id,
 						unsigned int idx,
@@ -708,11 +717,11 @@ struct gpio_desc *of_find_gpio(struct device_node *np, const char *con_id,
  * @chip:	GPIO chip whose hog is parsed
  * @idx:	Index of the GPIO to parse
  * @name:	GPIO line name
- * @lflags:	bitmask of gpio_lookup_flags GPIO_* values - returned from
- *		of_find_gpio() or of_parse_own_gpio()
+ * @lflags:	bitmask of gpio_lookup_flags GPIO_* values - returned from *_find_gpio()
  * @dflags:	gpiod_flags - optional GPIO initialization flags
  *
- * Returns GPIO descriptor to use with Linux GPIO API, or one of the errno
+ * Returns:
+ * GPIO descriptor to use with Linux GPIO API, or one of the errno
  * value on the error condition.
  */
 static struct gpio_desc *of_parse_own_gpio(struct device_node *np,
@@ -777,10 +786,11 @@ static struct gpio_desc *of_parse_own_gpio(struct device_node *np,
 
 /**
  * of_gpiochip_add_hog - Add all hogs in a hog device node
- * @chip:	gpio chip to act on
+ * @chip:	GPIO chip to act on
  * @hog:	device node describing the hogs
  *
- * Returns error if it fails otherwise 0 on success.
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 static int of_gpiochip_add_hog(struct gpio_chip *chip, struct device_node *hog)
 {
@@ -809,12 +819,14 @@ static int of_gpiochip_add_hog(struct gpio_chip *chip, struct device_node *hog)
 }
 
 /**
- * of_gpiochip_scan_gpios - Scan gpio-controller for gpio definitions
- * @chip:	gpio chip to act on
+ * of_gpiochip_scan_gpios - Scan gpio-controller for GPIO definitions
+ * @chip:	GPIO chip to act on
  *
- * This is only used by of_gpiochip_add to request/set GPIO initial
+ * This is only used by of_gpiochip_add() to request/set GPIO initial
  * configuration.
- * It returns error if it fails otherwise 0 on success.
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 static int of_gpiochip_scan_gpios(struct gpio_chip *chip)
 {
@@ -840,7 +852,7 @@ static int of_gpiochip_scan_gpios(struct gpio_chip *chip)
 #ifdef CONFIG_OF_DYNAMIC
 /**
  * of_gpiochip_remove_hog - Remove all hogs in a hog device node
- * @chip:	gpio chip to act on
+ * @chip:	GPIO chip to act on
  * @hog:	device node describing the hogs
  */
 static void of_gpiochip_remove_hog(struct gpio_chip *chip,
@@ -920,13 +932,16 @@ struct notifier_block gpio_of_notifier = {
 
 /**
  * of_gpio_simple_xlate - translate gpiospec to the GPIO number and flags
- * @gc:		pointer to the gpio_chip structure
+ * @gc:		pointer to the struct gpio_chip
  * @gpiospec:	GPIO specifier as found in the device tree
  * @flags:	a flags pointer to fill in
  *
  * This is simple translation function, suitable for the most 1:1 mapped
  * GPIO chips. This function performs only one sanity check: whether GPIO
- * is less than ngpios (that is specified in the gpio_chip).
+ * is less than ngpios (that is specified in the @gc).
+ *
+ * Returns:
+ * GPIO number (>= 0) on success, negative errno on failure.
  */
 static int of_gpio_simple_xlate(struct gpio_chip *gc,
 				const struct of_phandle_args *gpiospec,
@@ -934,7 +949,7 @@ static int of_gpio_simple_xlate(struct gpio_chip *gc,
 {
 	/*
 	 * We're discouraging gpio_cells < 2, since that way you'll have to
-	 * write your own xlate function (that will have to retrieve the GPIO
+	 * write your own .xlate function (that will have to retrieve the GPIO
 	 * number and the flags from a single gpio cell -- this is possible,
 	 * but not recommended).
 	 */
@@ -960,22 +975,27 @@ static int of_gpio_simple_xlate(struct gpio_chip *gc,
 /**
  * of_mm_gpiochip_add_data - Add memory mapped GPIO chip (bank)
  * @np:		device node of the GPIO chip
- * @mm_gc:	pointer to the of_mm_gpio_chip allocated structure
+ * @mm_gc:	pointer to the allocated struct of_mm_gpio_chip
  * @data:	driver data to store in the struct gpio_chip
  *
- * To use this function you should allocate and fill mm_gc with:
+ * **DEPRECATED** This function is deprecated and must not be used in new code.
  *
- * 1) In the gpio_chip structure:
+ * To use this function you should allocate and fill @mm_gc with:
+ *
+ * 1) In the struct gpio_chip:
  *    - all the callbacks
  *    - of_gpio_n_cells
  *    - of_xlate callback (optional)
  *
- * 3) In the of_mm_gpio_chip structure:
+ * 3) In the struct of_mm_gpio_chip:
  *    - save_regs callback (optional)
  *
  * If succeeded, this function will map bank's memory and will
  * do all necessary work for you. Then you'll able to use .regs
  * to manage GPIOs from the callbacks.
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int of_mm_gpiochip_add_data(struct device_node *np,
 			    struct of_mm_gpio_chip *mm_gc,
@@ -1018,7 +1038,9 @@ EXPORT_SYMBOL_GPL(of_mm_gpiochip_add_data);
 
 /**
  * of_mm_gpiochip_remove - Remove memory mapped GPIO chip (bank)
- * @mm_gc:	pointer to the of_mm_gpio_chip allocated structure
+ * @mm_gc:	pointer to the allocated struct of_mm_gpio_chip
+ *
+ * **DEPRECATED** This function is deprecated and must not be used in new code.
  */
 void of_mm_gpiochip_remove(struct of_mm_gpio_chip *mm_gc)
 {
diff --git a/drivers/gpio/gpiolib-swnode.c b/drivers/gpio/gpiolib-swnode.c
index fa52bdb1a29a..100fc18a468c 100644
--- a/drivers/gpio/gpiolib-swnode.c
+++ b/drivers/gpio/gpiolib-swnode.c
@@ -21,7 +21,7 @@ static void swnode_format_propname(const char *con_id, char *propname,
 				   size_t max_size)
 {
 	/*
-	 * Note we do not need to try both -gpios and -gpio suffixes,
+	 * NOTE: We do not need to try both -gpios and -gpio suffixes,
 	 * as, unlike OF and ACPI, we can fix software nodes to conform
 	 * to the proper binding.
 	 */
@@ -92,12 +92,12 @@ struct gpio_desc *swnode_find_gpio(struct fwnode_handle *fwnode,
 
 /**
  * swnode_gpio_count - count the GPIOs associated with a device / function
- * @fwnode:	firmware node of the GPIO consumer, can be %NULL for
+ * @fwnode:	firmware node of the GPIO consumer, can be NULL for
  *		system-global GPIOs
  * @con_id:	function within the GPIO consumer
  *
- * Return:
- * The number of GPIOs associated with a device / function or %-ENOENT,
+ * Returns:
+ * The number of GPIOs associated with a device / function or -ENOENT,
  * if no GPIO has been assigned to the requested function.
  */
 int swnode_gpio_count(const struct fwnode_handle *fwnode, const char *con_id)
diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 26202586fd39..94f75ebca32f 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -44,8 +44,8 @@ struct gpiod_data {
 };
 
 /*
- * Lock to serialise gpiod export and unexport, and prevent re-export of
- * gpiod whose chip is being unregistered.
+ * Lock to serialise GPIO export and unexport, and prevent re-export of
+ * GPIO whose chip is being unregistered.
  */
 static DEFINE_MUTEX(sysfs_lock);
 
@@ -193,12 +193,12 @@ static int gpio_sysfs_request_irq(struct device *dev, unsigned char flags)
 			IRQF_TRIGGER_FALLING : IRQF_TRIGGER_RISING;
 
 	/*
-	 * FIXME: This should be done in the irq_request_resources callback
-	 *        when the irq is requested, but a few drivers currently fail
-	 *        to do so.
+	 * FIXME: This should be done in the .irq_request_resources callback
+	 * when the IRQ is requested, but a few drivers currently fail
+	 * to do so.
 	 *
-	 *        Remove this redundant call (along with the corresponding
-	 *        unlock) when those drivers have been fixed.
+	 * Remove this redundant call (along with the corresponding
+	 * unlock) when those drivers have been fixed.
 	 */
 	ret = gpiochip_lock_as_irq(guard.gc, gpio_chip_hwgpio(desc));
 	if (ret < 0)
@@ -222,7 +222,7 @@ static int gpio_sysfs_request_irq(struct device *dev, unsigned char flags)
 }
 
 /*
- * Caller holds gpiod-data mutex (unless called after class-device
+ * Caller holds gpiod_data mutex (unless called after class-device
  * deregistration).
  */
 static void gpio_sysfs_free_irq(struct device *dev)
@@ -299,7 +299,7 @@ static ssize_t edge_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(edge);
 
-/* Caller holds gpiod-data mutex. */
+/* Caller holds gpiod_data mutex. */
 static int gpio_sysfs_set_active_low(struct device *dev, int value)
 {
 	struct gpiod_data *data = dev_get_drvdata(dev);
@@ -477,7 +477,8 @@ static ssize_t export_store(const struct class *class,
 		return -EINVAL;
 	}
 
-	/* No extra locking here; FLAG_SYSFS just signifies that the
+	/*
+	 * No extra locking here; FLAG_SYSFS just signifies that the
 	 * request and export were done by on behalf of userspace, so
 	 * they may be undone on its behalf too.
 	 */
@@ -526,7 +527,8 @@ static ssize_t unexport_store(const struct class *class,
 
 	status = -EINVAL;
 
-	/* No extra locking here; FLAG_SYSFS just signifies that the
+	/*
+	 * No extra locking here; FLAG_SYSFS just signifies that the
 	 * request and export were done by on behalf of userspace, so
 	 * they may be undone on its behalf too.
 	 */
@@ -568,7 +570,8 @@ static struct class gpio_class = {
  * will see "direction" sysfs attribute which may be used to change
  * the gpio's direction.  A "value" attribute will always be provided.
  *
- * Returns zero on success, else an error.
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiod_export(struct gpio_desc *desc, bool direction_may_change)
 {
@@ -667,7 +670,8 @@ static int match_export(struct device *dev, const void *desc)
  * Set up a symlink from /sys/.../dev/name to /sys/class/gpio/gpioN
  * node. Caller is responsible for unlinking.
  *
- * Returns zero on success, else an error.
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiod_export_link(struct device *dev, const char *name,
 		      struct gpio_desc *desc)
@@ -723,7 +727,7 @@ void gpiod_unexport(struct gpio_desc *desc)
 	device_unregister(dev);
 
 	/*
-	 * Release irq after deregistration to prevent race with edge_store.
+	 * Release IRQ after deregistration to prevent race with edge_store.
 	 */
 	if (data->irq_flags)
 		gpio_sysfs_free_irq(dev);
@@ -747,7 +751,7 @@ int gpiochip_sysfs_register(struct gpio_device *gdev)
 	struct device *dev;
 
 	/*
-	 * Many systems add gpio chips for SOC support very early,
+	 * Many systems add GPIO chips for SoC support very early,
 	 * before driver model support is available.  In those cases we
 	 * register later, in gpiolib_sysfs_init() ... here we just
 	 * verify that _some_ field of gpio_class got initialized.
@@ -795,7 +799,7 @@ void gpiochip_sysfs_unregister(struct gpio_device *gdev)
 
 		device_unregister(gdev->mockdev);
 
-		/* prevent further gpiod exports */
+		/* prevent further GPIO exports */
 		gdev->mockdev = NULL;
 	}
 
@@ -805,7 +809,7 @@ void gpiochip_sysfs_unregister(struct gpio_device *gdev)
 	if (!chip)
 		return;
 
-	/* unregister gpiod class devices owned by sysfs */
+	/* unregister GPIO class devices owned by sysfs */
 	for_each_gpio_desc_with_flag(chip, desc, FLAG_SYSFS) {
 		gpiod_unexport(desc);
 		gpiod_free(desc);
@@ -840,7 +844,8 @@ static int __init gpiolib_sysfs_init(void)
 	if (status < 0)
 		return status;
 
-	/* Scan and register the gpio_chips which registered very
+	/*
+	 * Scan and register the gpio_chips which registered very
 	 * early (e.g. before the class_register above was called).
 	 *
 	 * We run before arch_initcall() so chip->dev nodes can have
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index f749ece2d3cd..29c9374f8843 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -41,10 +41,11 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/gpio.h>
 
-/* Implementation infrastructure for GPIO interfaces.
+/*
+ * Implementation infrastructure for GPIO interfaces.
  *
  * The GPIO programming interface allows for inlining speed-critical
- * get/set operations for common cases, so that access to SOC-integrated
+ * get/set operations for common cases, so that access to SoC-integrated
  * GPIOs can sometimes cost only an instruction or two per bit.
  */
 
@@ -72,7 +73,7 @@ static const struct bus_type gpio_bus_type = {
 };
 
 /*
- * Number of GPIOs to use for the fast path in set array
+ * Number of GPIOs to use for the fast path in set array.
  */
 #define FASTPATH_NGPIO CONFIG_GPIOLIB_FASTPATH_LIMIT
 
@@ -134,7 +135,7 @@ static int desc_set_label(struct gpio_desc *desc, const char *label)
  * @gpio: global GPIO number
  *
  * Returns:
- * The GPIO descriptor associated with the given GPIO, or %NULL if no GPIO
+ * The GPIO descriptor associated with the given GPIO, or NULL if no GPIO
  * with the given number exists in the system.
  */
 struct gpio_desc *gpio_to_desc(unsigned gpio)
@@ -169,8 +170,8 @@ EXPORT_SYMBOL_GPL(gpiochip_get_desc);
  * @hwnum: hardware number of the GPIO for this chip
  *
  * Returns:
- * A pointer to the GPIO descriptor or %EINVAL if no GPIO exists in the given
- * chip for the specified hardware number or %ENODEV if the underlying chip
+ * A pointer to the GPIO descriptor or -EINVAL if no GPIO exists in the given
+ * chip for the specified hardware number or -ENODEV if the underlying chip
  * already vanished.
  *
  * The reference count of struct gpio_device is *NOT* increased like when the
@@ -204,7 +205,6 @@ int desc_to_gpio(const struct gpio_desc *desc)
 }
 EXPORT_SYMBOL_GPL(desc_to_gpio);
 
-
 /**
  * gpiod_to_chip - Return the GPIO chip to which a GPIO descriptor belongs
  * @desc:	descriptor to return the chip of
@@ -213,6 +213,9 @@ EXPORT_SYMBOL_GPL(desc_to_gpio);
  * This function is unsafe and should not be used. Using the chip address
  * without taking the SRCU read lock may result in dereferencing a dangling
  * pointer.
+ *
+ * Returns:
+ * Address of the GPIO chip backing this device.
  */
 struct gpio_chip *gpiod_to_chip(const struct gpio_desc *desc)
 {
@@ -272,7 +275,7 @@ const char *gpio_device_get_label(struct gpio_device *gdev)
 EXPORT_SYMBOL(gpio_device_get_label);
 
 /**
- * gpio_device_get_chip() - Get the gpio_chip implementation of this GPIO device
+ * gpio_device_get_chip() - Get the GPIO chip implementation of this GPIO device
  * @gdev: GPIO device
  *
  * Returns:
@@ -325,7 +328,8 @@ static int gpiochip_find_base_unlocked(u16 ngpio)
  * gpiod_get_direction - return the current direction of a GPIO
  * @desc:	GPIO to get the direction of
  *
- * Returns 0 for output, 1 for input, or an error code in case of error.
+ * Returns:
+ * 0 for output, 1 for input, or an error code in case of error.
  *
  * This function may sleep if gpiod_cansleep() is true.
  */
@@ -380,10 +384,10 @@ EXPORT_SYMBOL_GPL(gpiod_get_direction);
 
 /*
  * Add a new chip to the global chips list, keeping the list of chips sorted
- * by range(means [base, base + ngpio - 1]) order.
+ * by range (means [base, base + ngpio - 1]) order.
  *
- * Return -EBUSY if the new chip overlaps with some other chip's integer
- * space.
+ * Returns:
+ * -EBUSY if the new chip overlaps with some other chip's integer space.
  */
 static int gpiodev_add_to_list_unlocked(struct gpio_device *gdev)
 {
@@ -430,8 +434,8 @@ static int gpiodev_add_to_list_unlocked(struct gpio_device *gdev)
 }
 
 /*
- * Convert a GPIO name to its descriptor
- * Note that there is no guarantee that GPIO names are globally unique!
+ * Convert a GPIO name to its descriptor.
+ * NOTE: There is no guarantee that GPIO names are globally unique!
  * Hence this function will return, if it exists, a reference to the first GPIO
  * line found that matches the given name.
  */
@@ -467,7 +471,7 @@ static struct gpio_desc *gpio_name_to_desc(const char * const name)
  * Take the names from gc->names and assign them to their GPIO descriptors.
  * Warn if a name is already used for a GPIO line on a different GPIO chip.
  *
- * Note that:
+ * NOTE:
  *   1. Non-unique names are still accepted,
  *   2. Name collisions within the same GPIO chip are not reported.
  */
@@ -517,11 +521,11 @@ static int gpiochip_set_names(struct gpio_chip *chip)
 
 	/*
 	 * When offset is set in the driver side we assume the driver internally
-	 * is using more than one gpiochip per the same device. We have to stop
+	 * is using more than one GPIO chip per the same device. We have to stop
 	 * setting friendly names if the specified ones with 'gpio-line-names'
 	 * are less than the offset in the device itself. This means all the
 	 * lines are not present for every single pin within all the internal
-	 * gpiochips.
+	 * GPIO chips.
 	 */
 	if (count <= chip->offset) {
 		dev_warn(dev, "gpio-line-names too short (length %d), cannot map names for the gpiochip at offset %u\n",
@@ -542,8 +546,8 @@ static int gpiochip_set_names(struct gpio_chip *chip)
 	}
 
 	/*
-	 * When more that one gpiochip per device is used, 'count' can
-	 * contain at most number gpiochips x chip->ngpio. We have to
+	 * When more that one GPIO chip per device is used, 'count' can
+	 * contain at most number GPIO chips x chip->ngpio. We have to
 	 * correctly distribute all defined lines taking into account
 	 * chip->offset as starting point from where we will assign
 	 * the names to pins from the 'names' array. Since property
@@ -1096,10 +1100,10 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 EXPORT_SYMBOL_GPL(gpiochip_add_data_with_key);
 
 /**
- * gpiochip_remove() - unregister a gpio_chip
+ * gpiochip_remove() - unregister a GPIO chip
  * @gc: the chip to unregister
  *
- * A gpio_chip with any GPIOs still requested may not be removed.
+ * A GPIO chip with any GPIOs still requested may not be removed.
  */
 void gpiochip_remove(struct gpio_chip *gc)
 {
@@ -1128,7 +1132,7 @@ void gpiochip_remove(struct gpio_chip *gc)
 	gpiochip_set_data(gc, NULL);
 
 	/*
-	 * The gpiochip side puts its use of the device to rest here:
+	 * The GPIO chip side puts its use of the device to rest here:
 	 * if there are no userspace clients, the chardev and device will
 	 * be removed, else it will be dangling until the last user is
 	 * gone.
@@ -1141,7 +1145,7 @@ EXPORT_SYMBOL_GPL(gpiochip_remove);
 /**
  * gpio_device_find() - find a specific GPIO device
  * @data: data to pass to match function
- * @match: Callback function to check gpio_chip
+ * @match: Callback function to check struct gpio_chip
  *
  * Returns:
  * New reference to struct gpio_device.
@@ -1152,9 +1156,9 @@ EXPORT_SYMBOL_GPL(gpiochip_remove);
  * returns non-zero, this function will return to the caller and not iterate
  * over any more gpio_devices.
  *
- * The callback takes the GPIO chip structure as argument. During the execution
- * of the callback function the chip is protected from being freed. TODO: This
- * actually has yet to be implemented.
+ * The callback takes the struct gpio_chip as argument. During the execution
+ * of the callback function the chip is protected from being freed.
+ * TODO: this actually has yet to be implemented.
  *
  * If the function returns non-NULL, the returned reference must be freed by
  * the caller using gpio_device_put().
@@ -1273,7 +1277,7 @@ EXPORT_SYMBOL_GPL(gpio_device_to_device);
 #ifdef CONFIG_GPIOLIB_IRQCHIP
 
 /*
- * The following is irqchip helper code for gpiochips.
+ * The following is irqchip helper code for GPIO chips.
  */
 
 static int gpiochip_irqchip_init_hw(struct gpio_chip *gc)
@@ -1321,9 +1325,8 @@ static bool gpiochip_irqchip_irq_valid(const struct gpio_chip *gc,
 #ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
 
 /**
- * gpiochip_set_hierarchical_irqchip() - connects a hierarchical irqchip
- * to a gpiochip
- * @gc: the gpiochip to set the irqchip hierarchical handler to
+ * gpiochip_set_hierarchical_irqchip() - connects a hierarchical irqchip to a GPIO chip
+ * @gc: the GPIO chip to set the irqchip hierarchical handler to
  * @irqchip: the irqchip to handle this level of the hierarchy, the interrupt
  * will then percolate up to the parent
  */
@@ -1336,7 +1339,7 @@ static void gpiochip_set_hierarchical_irqchip(struct gpio_chip *gc,
 
 	/*
 	 * This is for legacy and boardfile "irqchip" fwnodes: allocate
-	 * irqs upfront instead of dynamically since we don't have the
+	 * IRQs upfront instead of dynamically since we don't have the
 	 * dynamic type of allocation that hardware description languages
 	 * provide. Once all GPIO drivers using board files are gone from
 	 * the kernel we can delete this code, but for a transitional period
@@ -1396,9 +1399,8 @@ static int gpiochip_hierarchy_irq_domain_translate(struct irq_domain *d,
 						   unsigned int *type)
 {
 	/* We support standard DT translation */
-	if (is_of_node(fwspec->fwnode) && fwspec->param_count == 2) {
+	if (is_of_node(fwspec->fwnode) && fwspec->param_count == 2)
 		return irq_domain_translate_twocell(d, fwspec, hwirq, type);
-	}
 
 	/* This is for board files and others not using DT */
 	if (is_fwnode_irqchip(fwspec->fwnode)) {
@@ -1449,7 +1451,7 @@ static int gpiochip_hierarchy_irq_domain_alloc(struct irq_domain *d,
 	chip_dbg(gc, "found parent hwirq %u\n", parent_hwirq);
 
 	/*
-	 * We set handle_bad_irq because the .set_type() should
+	 * Driver has to set handle_bad_irq() because the .set_type() should
 	 * always be invoked and set the right type of handler.
 	 */
 	irq_domain_set_info(d,
@@ -1473,7 +1475,7 @@ static int gpiochip_hierarchy_irq_domain_alloc(struct irq_domain *d,
 	ret = irq_domain_alloc_irqs_parent(d, irq, 1, &gpio_parent_fwspec);
 	/*
 	 * If the parent irqdomain is msi, the interrupts have already
-	 * been allocated, so the EEXIST is good.
+	 * been allocated, so the -EEXIST is good.
 	 */
 	if (irq_domain_is_msi(d->parent) && (ret == -EEXIST))
 		ret = 0;
@@ -1493,13 +1495,16 @@ static unsigned int gpiochip_child_offset_to_irq_noop(struct gpio_chip *gc,
 
 /**
  * gpiochip_irq_domain_activate() - Lock a GPIO to be used as an IRQ
- * @domain: The IRQ domain used by this IRQ chip
+ * @domain: The IRQ domain used by this irqchip
  * @data: Outermost irq_data associated with the IRQ
  * @reserve: If set, only reserve an interrupt vector instead of assigning one
  *
  * This function is a wrapper that calls gpiochip_lock_as_irq() and is to be
  * used as the activate function for the &struct irq_domain_ops. The host_data
  * for the IRQ domain must be the &struct gpio_chip.
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 static int gpiochip_irq_domain_activate(struct irq_domain *domain,
 					struct irq_data *data, bool reserve)
@@ -1512,7 +1517,7 @@ static int gpiochip_irq_domain_activate(struct irq_domain *domain,
 
 /**
  * gpiochip_irq_domain_deactivate() - Unlock a GPIO used as an IRQ
- * @domain: The IRQ domain used by this IRQ chip
+ * @domain: The IRQ domain used by this irqchip
  * @data: Outermost irq_data associated with the IRQ
  *
  * This function is a wrapper that will call gpiochip_unlock_as_irq() and is to
@@ -1638,12 +1643,15 @@ static bool gpiochip_hierarchy_is_hierarchical(struct gpio_chip *gc)
 /**
  * gpiochip_irq_map() - maps an IRQ into a GPIO irqchip
  * @d: the irqdomain used by this irqchip
- * @irq: the global irq number used by this GPIO irqchip irq
- * @hwirq: the local IRQ/GPIO line offset on this gpiochip
+ * @irq: the global IRQ number used by this GPIO irqchip IRQ
+ * @hwirq: the local IRQ/GPIO line offset on this GPIO chip
  *
  * This function will set up the mapping for a certain IRQ line on a
- * gpiochip by assigning the gpiochip as chip data, and using the irqchip
- * stored inside the gpiochip.
+ * GPIO chip by assigning the struct gpio_chip as chip data, and using the irqchip
+ * stored inside the struct gpio_chip.
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 static int gpiochip_irq_map(struct irq_domain *d, unsigned int irq,
 			    irq_hw_number_t hwirq)
@@ -1656,7 +1664,7 @@ static int gpiochip_irq_map(struct irq_domain *d, unsigned int irq,
 
 	irq_set_chip_data(irq, gc);
 	/*
-	 * This lock class tells lockdep that GPIO irqs are in a different
+	 * This lock class tells lockdep that GPIO IRQs are in a different
 	 * category than their parents, so it won't report false recursion.
 	 */
 	irq_set_lockdep_class(irq, gc->irq.lock_key, gc->irq.request_key);
@@ -1722,7 +1730,7 @@ static int gpiochip_to_irq(struct gpio_chip *gc, unsigned int offset)
 	/*
 	 * Avoid race condition with other code, which tries to lookup
 	 * an IRQ before the irqchip has been properly registered,
-	 * i.e. while gpiochip is still being brought up.
+	 * i.e. while GPIO chip is still being brought up.
 	 */
 	if (!gc->irq.initialized)
 		return -EPROBE_DEFER;
@@ -1874,10 +1882,13 @@ static int gpiochip_irqchip_add_allocated_domain(struct gpio_chip *gc,
 }
 
 /**
- * gpiochip_add_irqchip() - adds an IRQ chip to a GPIO chip
- * @gc: the GPIO chip to add the IRQ chip to
+ * gpiochip_add_irqchip() - adds an irqchip to a GPIO chip
+ * @gc: the GPIO chip to add the irqchip to
  * @lock_key: lockdep class for IRQ lock
  * @request_key: lockdep class for IRQ request
+ *
+ * Returns:
+ * 0 on success, or a negative error-code on failure.
  */
 static int gpiochip_add_irqchip(struct gpio_chip *gc,
 				struct lock_class_key *lock_key,
@@ -1914,11 +1925,10 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
 	gc->irq.request_key = request_key;
 
 	/* If a parent irqdomain is provided, let's build a hierarchy */
-	if (gpiochip_hierarchy_is_hierarchical(gc)) {
+	if (gpiochip_hierarchy_is_hierarchical(gc))
 		domain = gpiochip_hierarchy_create_domain(gc);
-	} else {
+	else
 		domain = gpiochip_simple_create_domain(gc);
-	}
 	if (IS_ERR(domain))
 		return PTR_ERR(domain);
 
@@ -1932,8 +1942,8 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
 				data = gc->irq.parent_handler_data ?: gc;
 
 			/*
-			 * The parent IRQ chip is already using the chip_data
-			 * for this IRQ chip, so our callbacks simply use the
+			 * The parent irqchip is already using the chip_data
+			 * for this irqchip, so our callbacks simply use the
 			 * handler_data.
 			 */
 			irq_set_chained_handler_and_data(gc->irq.parents[i],
@@ -1954,10 +1964,10 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
 }
 
 /**
- * gpiochip_irqchip_remove() - removes an irqchip added to a gpiochip
- * @gc: the gpiochip to remove the irqchip from
+ * gpiochip_irqchip_remove() - removes an irqchip added to a struct gpio_chip
+ * @gc: the struct gpio_chip to remove the irqchip from
  *
- * This is called only from gpiochip_remove()
+ * This is called only from gpiochip_remove().
  */
 static void gpiochip_irqchip_remove(struct gpio_chip *gc)
 {
@@ -2008,11 +2018,14 @@ static void gpiochip_irqchip_remove(struct gpio_chip *gc)
 }
 
 /**
- * gpiochip_irqchip_add_domain() - adds an irqdomain to a gpiochip
- * @gc: the gpiochip to add the irqchip to
- * @domain: the irqdomain to add to the gpiochip
+ * gpiochip_irqchip_add_domain() - adds an irqdomain to a struct gpio_chip
+ * @gc: the struct gpio_chip to add the irqchip to
+ * @domain: the irqdomain to add to the struct gpio_chip
  *
- * This function adds an IRQ domain to the gpiochip.
+ * This function adds an IRQ domain to the struct gpio_chip.
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiochip_irqchip_add_domain(struct gpio_chip *gc,
 				struct irq_domain *domain)
@@ -2046,9 +2059,12 @@ static inline void gpiochip_irqchip_free_valid_mask(struct gpio_chip *gc)
 #endif /* CONFIG_GPIOLIB_IRQCHIP */
 
 /**
- * gpiochip_generic_request() - request the gpio function for a pin
- * @gc: the gpiochip owning the GPIO
+ * gpiochip_generic_request() - request the GPIO function for a pin
+ * @gc: the GPIO chip owning the GPIO
  * @offset: the offset of the GPIO to request for GPIO function
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiochip_generic_request(struct gpio_chip *gc, unsigned int offset)
 {
@@ -2062,8 +2078,8 @@ int gpiochip_generic_request(struct gpio_chip *gc, unsigned int offset)
 EXPORT_SYMBOL_GPL(gpiochip_generic_request);
 
 /**
- * gpiochip_generic_free() - free the gpio function from a pin
- * @gc: the gpiochip to request the gpio function for
+ * gpiochip_generic_free() - free the GPIO function from a pin
+ * @gc: the GPIO chip to request the GPIO function for
  * @offset: the offset of the GPIO to free from GPIO function
  */
 void gpiochip_generic_free(struct gpio_chip *gc, unsigned int offset)
@@ -2079,9 +2095,12 @@ EXPORT_SYMBOL_GPL(gpiochip_generic_free);
 
 /**
  * gpiochip_generic_config() - apply configuration for a pin
- * @gc: the gpiochip owning the GPIO
+ * @gc: the GPIO chip owning the GPIO
  * @offset: the offset of the GPIO to apply the configuration
  * @config: the configuration to be applied
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiochip_generic_config(struct gpio_chip *gc, unsigned int offset,
 			    unsigned long config)
@@ -2099,15 +2118,18 @@ EXPORT_SYMBOL_GPL(gpiochip_generic_config);
 
 /**
  * gpiochip_add_pingroup_range() - add a range for GPIO <-> pin mapping
- * @gc: the gpiochip to add the range for
+ * @gc: the GPIO chip to add the range for
  * @pctldev: the pin controller to map to
- * @gpio_offset: the start offset in the current gpio_chip number space
+ * @gpio_offset: the start offset in the current @gc number space
  * @pin_group: name of the pin group inside the pin controller
  *
  * Calling this function directly from a DeviceTree-supported
  * pinctrl driver is DEPRECATED. Please see Section 2.1 of
  * Documentation/devicetree/bindings/gpio/gpio.txt on how to
- * bind pinctrl and gpio drivers via the "gpio-ranges" property.
+ * bind pinctrl and GPIO drivers via the "gpio-ranges" property.
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiochip_add_pingroup_range(struct gpio_chip *gc,
 			struct pinctrl_dev *pctldev,
@@ -2152,20 +2174,20 @@ EXPORT_SYMBOL_GPL(gpiochip_add_pingroup_range);
 
 /**
  * gpiochip_add_pin_range() - add a range for GPIO <-> pin mapping
- * @gc: the gpiochip to add the range for
+ * @gc: the GPIO chip to add the range for
  * @pinctl_name: the dev_name() of the pin controller to map to
- * @gpio_offset: the start offset in the current gpio_chip number space
+ * @gpio_offset: the start offset in the current @gc number space
  * @pin_offset: the start offset in the pin controller number space
  * @npins: the number of pins from the offset of each pin space (GPIO and
  *	pin controller) to accumulate in this range
  *
- * Returns:
- * 0 on success, or a negative error-code on failure.
- *
  * Calling this function directly from a DeviceTree-supported
  * pinctrl driver is DEPRECATED. Please see Section 2.1 of
  * Documentation/devicetree/bindings/gpio/gpio.txt on how to
- * bind pinctrl and gpio drivers via the "gpio-ranges" property.
+ * bind pinctrl and GPIO drivers via the "gpio-ranges" property.
+ *
+ * Returns:
+ * 0 on success, or a negative error-code on failure.
  */
 int gpiochip_add_pin_range(struct gpio_chip *gc, const char *pinctl_name,
 			   unsigned int gpio_offset, unsigned int pin_offset,
@@ -2227,7 +2249,8 @@ EXPORT_SYMBOL_GPL(gpiochip_remove_pin_ranges);
 
 #endif /* CONFIG_PINCTRL */
 
-/* These "optional" allocation calls help prevent drivers from stomping
+/*
+ * These "optional" allocation calls help prevent drivers from stomping
  * on each other, and help provide better diagnostics in debugfs.
  * They're called even less than the "set direction" calls.
  */
@@ -2243,10 +2266,11 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
 	if (test_and_set_bit(FLAG_REQUESTED, &desc->flags))
 		return -EBUSY;
 
-	/* NOTE:  gpio_request() can be called in early boot,
-	 * before IRQs are enabled, for non-sleeping (SOC) GPIOs.
+	/*
+	 * NOTE:
+	 * gpio_request() can be called in early boot, before IRQs are enabled,
+	 * for non-sleeping (SoC) GPIOs.
 	 */
-
 	if (guard.gc->request) {
 		offset = gpio_chip_hwgpio(desc);
 		if (gpiochip_line_is_valid(guard.gc, offset))
@@ -2373,7 +2397,7 @@ void gpiod_free(struct gpio_desc *desc)
  * Returns:
  * Pointer to a copy of the consumer label if the line is requested or NULL
  * if it's not. If a valid pointer was returned, it must be freed using
- * kfree(). In case of a memory allocation error, the function returns %ENOMEM.
+ * kfree(). In case of a memory allocation error, the function returns -ENOMEM.
  *
  * Must not be called from atomic context.
  */
@@ -2475,10 +2499,9 @@ EXPORT_SYMBOL_GPL(gpiochip_free_own_desc);
  *
  * As a rule these aren't called more than once (except for drivers
  * using the open-drain emulation idiom) so these are natural places
- * to accumulate extra debugging checks.  Note that we can't (yet)
+ * to accumulate extra debugging checks.  NOTE: We can't (yet)
  * rely on gpio_request() having been called beforehand.
  */
-
 static int gpio_do_set_config(struct gpio_chip *gc, unsigned int offset,
 			      unsigned long config)
 {
@@ -2569,7 +2592,8 @@ static int gpio_set_bias(struct gpio_desc *desc)
  * The function calls the certain GPIO driver to set debounce timeout
  * in the hardware.
  *
- * Returns 0 on success, or negative error code otherwise.
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpio_set_debounce_timeout(struct gpio_desc *desc, unsigned int debounce)
 {
@@ -2585,7 +2609,8 @@ int gpio_set_debounce_timeout(struct gpio_desc *desc, unsigned int debounce)
  * Set the direction of the passed GPIO to input, such as gpiod_get_value() can
  * be called safely on it.
  *
- * Return 0 in case of success, else an error code.
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiod_direction_input(struct gpio_desc *desc)
 {
@@ -2646,7 +2671,7 @@ static int gpiod_direction_output_raw_commit(struct gpio_desc *desc, int value)
 		return -ENODEV;
 
 	/*
-	 * It's OK not to specify .direction_output() if the gpiochip is
+	 * It's OK not to specify .direction_output() if the GPIO chip is
 	 * output-only, but if there is then not even a .set() operation it
 	 * is pretty tricky to drive the output line.
 	 */
@@ -2692,7 +2717,8 @@ static int gpiod_direction_output_raw_commit(struct gpio_desc *desc, int value)
  * be called safely on it. The initial value of the output must be specified
  * as raw value on the physical line without regard for the ACTIVE_LOW status.
  *
- * Return 0 in case of success, else an error code.
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiod_direction_output_raw(struct gpio_desc *desc, int value)
 {
@@ -2711,7 +2737,8 @@ EXPORT_SYMBOL_GPL(gpiod_direction_output_raw);
  * as the logical value of the GPIO, i.e. taking its ACTIVE_LOW status into
  * account.
  *
- * Return 0 in case of success, else an error code.
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiod_direction_output(struct gpio_desc *desc, int value)
 {
@@ -2784,7 +2811,8 @@ EXPORT_SYMBOL_GPL(gpiod_direction_output);
  * @desc: GPIO to enable.
  * @flags: Flags related to GPIO edge.
  *
- * Return 0 in case of success, else negative error code.
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiod_enable_hw_timestamp_ns(struct gpio_desc *desc, unsigned long flags)
 {
@@ -2816,7 +2844,8 @@ EXPORT_SYMBOL_GPL(gpiod_enable_hw_timestamp_ns);
  * @desc: GPIO to disable.
  * @flags: Flags related to GPIO edge, same value as used during enable call.
  *
- * Return 0 in case of success, else negative error code.
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiod_disable_hw_timestamp_ns(struct gpio_desc *desc, unsigned long flags)
 {
@@ -2848,7 +2877,7 @@ EXPORT_SYMBOL_GPL(gpiod_disable_hw_timestamp_ns);
  * @config: Same packed config format as generic pinconf
  *
  * Returns:
- * 0 on success, %-ENOTSUPP if the controller doesn't support setting the
+ * 0 on success, -ENOTSUPP if the controller doesn't support setting the
  * configuration.
  */
 int gpiod_set_config(struct gpio_desc *desc, unsigned long config)
@@ -2869,7 +2898,7 @@ EXPORT_SYMBOL_GPL(gpiod_set_config);
  * @debounce: debounce time in microseconds
  *
  * Returns:
- * 0 on success, %-ENOTSUPP if the controller doesn't support setting the
+ * 0 on success, -ENOTSUPP if the controller doesn't support setting the
  * debounce time.
  */
 int gpiod_set_debounce(struct gpio_desc *desc, unsigned int debounce)
@@ -2906,9 +2935,10 @@ int gpiod_set_transitory(struct gpio_desc *desc, bool transitory)
 
 /**
  * gpiod_is_active_low - test whether a GPIO is active-low or not
- * @desc: the gpio descriptor to test
+ * @desc: the GPIO descriptor to test
  *
- * Returns 1 if the GPIO is active-low, 0 otherwise.
+ * Returns:
+ * 1 if the GPIO is active-low, 0 otherwise.
  */
 int gpiod_is_active_low(const struct gpio_desc *desc)
 {
@@ -2919,7 +2949,7 @@ EXPORT_SYMBOL_GPL(gpiod_is_active_low);
 
 /**
  * gpiod_toggle_active_low - toggle whether a GPIO is active-low or not
- * @desc: the gpio descriptor to change
+ * @desc: the GPIO descriptor to change
  */
 void gpiod_toggle_active_low(struct gpio_desc *desc)
 {
@@ -2933,7 +2963,8 @@ static int gpio_chip_get_value(struct gpio_chip *gc, const struct gpio_desc *des
 	return gc->get ? gc->get(gc, gpio_chip_hwgpio(desc)) : -EIO;
 }
 
-/* I/O calls are only valid after configuration completed; the relevant
+/*
+ * I/O calls are only valid after configuration completed; the relevant
  * "is this a valid GPIO" error checks should already have been done.
  *
  * "Get" operations are often inlinable as reading a pin value register,
@@ -2947,7 +2978,7 @@ static int gpio_chip_get_value(struct gpio_chip *gc, const struct gpio_desc *des
  *
  * IMPORTANT!!!  The hot paths -- get/set value -- assume that callers
  * have requested the GPIO.  That can include implicit requesting by
- * a direction setting call.  Marking a gpio as requested locks its chip
+ * a direction setting call.  Marking a GPIO as requested locks its chip
  * in memory, guaranteeing that these table lookups need no more locking
  * and that gpiochip_remove() will fail.
  *
@@ -2961,7 +2992,7 @@ static int gpiod_get_raw_value_commit(const struct gpio_desc *desc)
 	struct gpio_chip *gc;
 	int value;
 
-	/* FIXME Unable to use gpio_chip_guard due to const desc. */
+	/* FIXME: Unable to use gpio_chip_guard() due to const desc. */
 	gdev = desc->gdev;
 
 	guard(srcu)(&gdev->srcu);
@@ -3120,10 +3151,11 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 }
 
 /**
- * gpiod_get_raw_value() - return a gpio's raw value
- * @desc: gpio whose value will be returned
+ * gpiod_get_raw_value() - return a GPIO's raw value
+ * @desc: GPIO whose value will be returned
  *
- * Return the GPIO's raw value, i.e. the value of the physical line disregarding
+ * Returns:
+ * The GPIO's raw value, i.e. the value of the physical line disregarding
  * its ACTIVE_LOW status, or negative errno on failure.
  *
  * This function can be called from contexts where we cannot sleep, and will
@@ -3139,10 +3171,11 @@ int gpiod_get_raw_value(const struct gpio_desc *desc)
 EXPORT_SYMBOL_GPL(gpiod_get_raw_value);
 
 /**
- * gpiod_get_value() - return a gpio's value
- * @desc: gpio whose value will be returned
+ * gpiod_get_value() - return a GPIO's value
+ * @desc: GPIO whose value will be returned
  *
- * Return the GPIO's logical value, i.e. taking the ACTIVE_LOW status into
+ * Returns:
+ * The GPIO's logical value, i.e. taking the ACTIVE_LOW status into
  * account, or negative errno on failure.
  *
  * This function can be called from contexts where we cannot sleep, and will
@@ -3175,11 +3208,13 @@ EXPORT_SYMBOL_GPL(gpiod_get_value);
  * @value_bitmap: bitmap to store the read values
  *
  * Read the raw values of the GPIOs, i.e. the values of the physical lines
- * without regard for their ACTIVE_LOW status.  Return 0 in case of success,
- * else an error code.
+ * without regard for their ACTIVE_LOW status.
  *
  * This function can be called from contexts where we cannot sleep,
  * and it will complain if the GPIO chip functions potentially sleep.
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiod_get_raw_array_value(unsigned int array_size,
 			      struct gpio_desc **desc_array,
@@ -3202,10 +3237,13 @@ EXPORT_SYMBOL_GPL(gpiod_get_raw_array_value);
  * @value_bitmap: bitmap to store the read values
  *
  * Read the logical values of the GPIOs, i.e. taking their ACTIVE_LOW status
- * into account.  Return 0 in case of success, else an error code.
+ * into account.
  *
  * This function can be called from contexts where we cannot sleep,
  * and it will complain if the GPIO chip functions potentially sleep.
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiod_get_array_value(unsigned int array_size,
 			  struct gpio_desc **desc_array,
@@ -3221,8 +3259,8 @@ int gpiod_get_array_value(unsigned int array_size,
 EXPORT_SYMBOL_GPL(gpiod_get_array_value);
 
 /*
- *  gpio_set_open_drain_value_commit() - Set the open drain gpio's value.
- * @desc: gpio descriptor whose state need to be set.
+ *  gpio_set_open_drain_value_commit() - Set the open drain GPIO's value.
+ * @desc: GPIO descriptor whose state need to be set.
  * @value: Non-zero for setting it HIGH otherwise it will set to LOW.
  */
 static void gpio_set_open_drain_value_commit(struct gpio_desc *desc, bool value)
@@ -3248,8 +3286,8 @@ static void gpio_set_open_drain_value_commit(struct gpio_desc *desc, bool value)
 }
 
 /*
- *  _gpio_set_open_source_value() - Set the open source gpio's value.
- * @desc: gpio descriptor whose state need to be set.
+ *  _gpio_set_open_source_value() - Set the open source GPIO's value.
+ * @desc: GPIO descriptor whose state need to be set.
  * @value: Non-zero for setting it HIGH otherwise it will set to LOW.
  */
 static void gpio_set_open_source_value_commit(struct gpio_desc *desc, bool value)
@@ -3421,8 +3459,8 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 }
 
 /**
- * gpiod_set_raw_value() - assign a gpio's raw value
- * @desc: gpio whose value will be assigned
+ * gpiod_set_raw_value() - assign a GPIO's raw value
+ * @desc: GPIO whose value will be assigned
  * @value: value to assign
  *
  * Set the raw value of the GPIO, i.e. the value of its physical line without
@@ -3462,8 +3500,8 @@ static void gpiod_set_value_nocheck(struct gpio_desc *desc, int value)
 }
 
 /**
- * gpiod_set_value() - assign a gpio's value
- * @desc: gpio whose value will be assigned
+ * gpiod_set_value() - assign a GPIO's value
+ * @desc: GPIO whose value will be assigned
  * @value: value to assign
  *
  * Set the logical value of the GPIO, i.e. taking its ACTIVE_LOW,
@@ -3493,6 +3531,9 @@ EXPORT_SYMBOL_GPL(gpiod_set_value);
  *
  * This function can be called from contexts where we cannot sleep, and will
  * complain if the GPIO chip functions potentially sleep.
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiod_set_raw_array_value(unsigned int array_size,
 			      struct gpio_desc **desc_array,
@@ -3518,6 +3559,9 @@ EXPORT_SYMBOL_GPL(gpiod_set_raw_array_value);
  *
  * This function can be called from contexts where we cannot sleep, and will
  * complain if the GPIO chip functions potentially sleep.
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiod_set_array_value(unsigned int array_size,
 			  struct gpio_desc **desc_array,
@@ -3533,9 +3577,11 @@ int gpiod_set_array_value(unsigned int array_size,
 EXPORT_SYMBOL_GPL(gpiod_set_array_value);
 
 /**
- * gpiod_cansleep() - report whether gpio value access may sleep
- * @desc: gpio to check
+ * gpiod_cansleep() - report whether GPIO value access may sleep
+ * @desc: GPIO to check
  *
+ * Returns:
+ * 0 for non-sleepable, 1 for sleepable, or an error code in case of error.
  */
 int gpiod_cansleep(const struct gpio_desc *desc)
 {
@@ -3546,8 +3592,11 @@ EXPORT_SYMBOL_GPL(gpiod_cansleep);
 
 /**
  * gpiod_set_consumer_name() - set the consumer name for the descriptor
- * @desc: gpio to set the consumer name on
+ * @desc: GPIO to set the consumer name on
  * @name: the new consumer name
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiod_set_consumer_name(struct gpio_desc *desc, const char *name)
 {
@@ -3559,10 +3608,10 @@ EXPORT_SYMBOL_GPL(gpiod_set_consumer_name);
 
 /**
  * gpiod_to_irq() - return the IRQ corresponding to a GPIO
- * @desc: gpio whose IRQ will be returned (already requested)
+ * @desc: GPIO whose IRQ will be returned (already requested)
  *
- * Return the IRQ corresponding to the passed GPIO, or an error code in case of
- * error.
+ * Returns:
+ * The IRQ corresponding to the passed GPIO, or an error code in case of error.
  */
 int gpiod_to_irq(const struct gpio_desc *desc)
 {
@@ -3579,7 +3628,7 @@ int gpiod_to_irq(const struct gpio_desc *desc)
 		return -EINVAL;
 
 	gdev = desc->gdev;
-	/* FIXME Cannot use gpio_chip_guard due to const desc. */
+	/* FIXME: Cannot use gpio_chip_guard() due to const desc. */
 	guard(srcu)(&gdev->srcu);
 	gc = srcu_dereference(gdev->chip, &gdev->srcu);
 	if (!gc)
@@ -3600,7 +3649,7 @@ int gpiod_to_irq(const struct gpio_desc *desc)
 		/*
 		 * Avoid race condition with other code, which tries to lookup
 		 * an IRQ before the irqchip has been properly registered,
-		 * i.e. while gpiochip is still being brought up.
+		 * i.e. while GPIO chip is still being brought up.
 		 */
 		return -EPROBE_DEFER;
 	}
@@ -3616,6 +3665,9 @@ EXPORT_SYMBOL_GPL(gpiod_to_irq);
  *
  * This is used directly by GPIO drivers that want to lock down
  * a certain GPIO line to be used for IRQs.
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiochip_lock_as_irq(struct gpio_chip *gc, unsigned int offset)
 {
@@ -3764,10 +3816,11 @@ bool gpiochip_line_is_persistent(struct gpio_chip *gc, unsigned int offset)
 EXPORT_SYMBOL_GPL(gpiochip_line_is_persistent);
 
 /**
- * gpiod_get_raw_value_cansleep() - return a gpio's raw value
- * @desc: gpio whose value will be returned
+ * gpiod_get_raw_value_cansleep() - return a GPIO's raw value
+ * @desc: GPIO whose value will be returned
  *
- * Return the GPIO's raw value, i.e. the value of the physical line disregarding
+ * Returns:
+ * The GPIO's raw value, i.e. the value of the physical line disregarding
  * its ACTIVE_LOW status, or negative errno on failure.
  *
  * This function is to be called from contexts that can sleep.
@@ -3781,10 +3834,11 @@ int gpiod_get_raw_value_cansleep(const struct gpio_desc *desc)
 EXPORT_SYMBOL_GPL(gpiod_get_raw_value_cansleep);
 
 /**
- * gpiod_get_value_cansleep() - return a gpio's value
- * @desc: gpio whose value will be returned
+ * gpiod_get_value_cansleep() - return a GPIO's value
+ * @desc: GPIO whose value will be returned
  *
- * Return the GPIO's logical value, i.e. taking the ACTIVE_LOW status into
+ * Returns:
+ * The GPIO's logical value, i.e. taking the ACTIVE_LOW status into
  * account, or negative errno on failure.
  *
  * This function is to be called from contexts that can sleep.
@@ -3814,10 +3868,12 @@ EXPORT_SYMBOL_GPL(gpiod_get_value_cansleep);
  * @value_bitmap: bitmap to store the read values
  *
  * Read the raw values of the GPIOs, i.e. the values of the physical lines
- * without regard for their ACTIVE_LOW status.  Return 0 in case of success,
- * else an error code.
+ * without regard for their ACTIVE_LOW status.
  *
  * This function is to be called from contexts that can sleep.
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiod_get_raw_array_value_cansleep(unsigned int array_size,
 				       struct gpio_desc **desc_array,
@@ -3841,9 +3897,12 @@ EXPORT_SYMBOL_GPL(gpiod_get_raw_array_value_cansleep);
  * @value_bitmap: bitmap to store the read values
  *
  * Read the logical values of the GPIOs, i.e. taking their ACTIVE_LOW status
- * into account.  Return 0 in case of success, else an error code.
+ * into account.
  *
  * This function is to be called from contexts that can sleep.
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiod_get_array_value_cansleep(unsigned int array_size,
 				   struct gpio_desc **desc_array,
@@ -3860,8 +3919,8 @@ int gpiod_get_array_value_cansleep(unsigned int array_size,
 EXPORT_SYMBOL_GPL(gpiod_get_array_value_cansleep);
 
 /**
- * gpiod_set_raw_value_cansleep() - assign a gpio's raw value
- * @desc: gpio whose value will be assigned
+ * gpiod_set_raw_value_cansleep() - assign a GPIO's raw value
+ * @desc: GPIO whose value will be assigned
  * @value: value to assign
  *
  * Set the raw value of the GPIO, i.e. the value of its physical line without
@@ -3878,8 +3937,8 @@ void gpiod_set_raw_value_cansleep(struct gpio_desc *desc, int value)
 EXPORT_SYMBOL_GPL(gpiod_set_raw_value_cansleep);
 
 /**
- * gpiod_set_value_cansleep() - assign a gpio's value
- * @desc: gpio whose value will be assigned
+ * gpiod_set_value_cansleep() - assign a GPIO's value
+ * @desc: GPIO whose value will be assigned
  * @value: value to assign
  *
  * Set the logical value of the GPIO, i.e. taking its ACTIVE_LOW status into
@@ -3906,6 +3965,9 @@ EXPORT_SYMBOL_GPL(gpiod_set_value_cansleep);
  * without regard for their ACTIVE_LOW status.
  *
  * This function is to be called from contexts that can sleep.
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiod_set_raw_array_value_cansleep(unsigned int array_size,
 				       struct gpio_desc **desc_array,
@@ -3948,6 +4010,9 @@ void gpiod_add_lookup_tables(struct gpiod_lookup_table **tables, size_t n)
  * into account.
  *
  * This function is to be called from contexts that can sleep.
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiod_set_array_value_cansleep(unsigned int array_size,
 				   struct gpio_desc **desc_array,
@@ -3999,7 +4064,7 @@ EXPORT_SYMBOL_GPL(gpiod_remove_lookup_table);
 
 /**
  * gpiod_add_hogs() - register a set of GPIO hogs from machine code
- * @hogs: table of gpio hog entries with a zeroed sentinel at the end
+ * @hogs: table of GPIO hog entries with a zeroed sentinel at the end
  */
 void gpiod_add_hogs(struct gpiod_hog *hogs)
 {
@@ -4281,9 +4346,12 @@ EXPORT_SYMBOL_GPL(fwnode_gpiod_get_index);
 
 /**
  * gpiod_count - return the number of GPIOs associated with a device / function
- *		or -ENOENT if no GPIO has been assigned to the requested function
  * @dev:	GPIO consumer, can be NULL for system-global GPIOs
  * @con_id:	function within the GPIO consumer
+ *
+ * Returns:
+ * The number of GPIOs associated with a device / function or -ENOENT if no
+ * GPIO has been assigned to the requested function.
  */
 int gpiod_count(struct device *dev, const char *con_id)
 {
@@ -4310,7 +4378,8 @@ EXPORT_SYMBOL_GPL(gpiod_count);
  * @con_id:	function within the GPIO consumer
  * @flags:	optional GPIO initialization flags
  *
- * Return the GPIO descriptor corresponding to the function con_id of device
+ * Returns:
+ * The GPIO descriptor corresponding to the function @con_id of device
  * dev, -ENOENT if no GPIO has been assigned to the requested function, or
  * another IS_ERR() code if an error occurred while trying to acquire the GPIO.
  */
@@ -4330,6 +4399,11 @@ EXPORT_SYMBOL_GPL(gpiod_get);
  * This is equivalent to gpiod_get(), except that when no GPIO was assigned to
  * the requested function it will return NULL. This is convenient for drivers
  * that need to handle optional GPIOs.
+ *
+ * Returns:
+ * The GPIO descriptor corresponding to the function @con_id of device
+ * dev, NULL if no GPIO has been assigned to the requested function, or
+ * another IS_ERR() code if an error occurred while trying to acquire the GPIO.
  */
 struct gpio_desc *__must_check gpiod_get_optional(struct device *dev,
 						  const char *con_id,
@@ -4339,16 +4413,15 @@ struct gpio_desc *__must_check gpiod_get_optional(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(gpiod_get_optional);
 
-
 /**
  * gpiod_configure_flags - helper function to configure a given GPIO
- * @desc:	gpio whose value will be assigned
+ * @desc:	GPIO whose value will be assigned
  * @con_id:	function within the GPIO consumer
- * @lflags:	bitmask of gpio_lookup_flags GPIO_* values - returned from
- *		of_find_gpio() or of_get_gpio_hog()
+ * @lflags:	bitmask of gpio_lookup_flags GPIO_* values - returned from *_find_gpio()
  * @dflags:	gpiod_flags - optional GPIO initialization flags
  *
- * Return 0 on success, -ENOENT if no GPIO has been assigned to the
+ * Returns:
+ * 0 on success, -ENOENT if no GPIO has been assigned to the
  * requested function and/or index, or another IS_ERR() code if an error
  * occurred while trying to acquire the GPIO.
  */
@@ -4423,7 +4496,8 @@ int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
  * This variant of gpiod_get() allows to access GPIOs other than the first
  * defined one for functions that define several GPIOs.
  *
- * Return a valid GPIO descriptor, -ENOENT if no GPIO has been assigned to the
+ * Returns:
+ * A valid GPIO descriptor, -ENOENT if no GPIO has been assigned to the
  * requested function and/or index, or another IS_ERR() code if an error
  * occurred while trying to acquire the GPIO.
  */
@@ -4451,6 +4525,11 @@ EXPORT_SYMBOL_GPL(gpiod_get_index);
  * This is equivalent to gpiod_get_index(), except that when no GPIO with the
  * specified index was assigned to the requested function it will return NULL.
  * This is convenient for drivers that need to handle optional GPIOs.
+ *
+ * Returns:
+ * A valid GPIO descriptor, NULL if no GPIO has been assigned to the
+ * requested function and/or index, or another IS_ERR() code if an error
+ * occurred while trying to acquire the GPIO.
  */
 struct gpio_desc *__must_check gpiod_get_index_optional(struct device *dev,
 							const char *con_id,
@@ -4469,11 +4548,13 @@ EXPORT_SYMBOL_GPL(gpiod_get_index_optional);
 
 /**
  * gpiod_hog - Hog the specified GPIO desc given the provided flags
- * @desc:	gpio whose value will be assigned
+ * @desc:	GPIO whose value will be assigned
  * @name:	gpio line name
- * @lflags:	bitmask of gpio_lookup_flags GPIO_* values - returned from
- *		of_find_gpio() or of_get_gpio_hog()
+ * @lflags:	bitmask of gpio_lookup_flags GPIO_* values - returned from *_find_gpio()
  * @dflags:	gpiod_flags - optional GPIO initialization flags
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiod_hog(struct gpio_desc *desc, const char *name,
 	      unsigned long lflags, enum gpiod_flags dflags)
@@ -4512,7 +4593,7 @@ int gpiod_hog(struct gpio_desc *desc, const char *name,
 
 /**
  * gpiochip_free_hogs - Scan gpio-controller chip and release GPIO hog
- * @gc:	gpio chip to act on
+ * @gc:	GPIO chip to act on
  */
 static void gpiochip_free_hogs(struct gpio_chip *gc)
 {
@@ -4530,9 +4611,11 @@ static void gpiochip_free_hogs(struct gpio_chip *gc)
  *
  * This function acquires all the GPIOs defined under a given function.
  *
- * Return a struct gpio_descs containing an array of descriptors, -ENOENT if
- * no GPIO has been assigned to the requested function, or another IS_ERR()
- * code if an error occurred while trying to acquire the GPIOs.
+ * Returns:
+ * The GPIO descriptors corresponding to the function @con_id of device
+ * dev, -ENOENT if no GPIO has been assigned to the requested function,
+ * or another IS_ERR() code if an error occurred while trying to acquire
+ * the GPIOs.
  */
 struct gpio_descs *__must_check gpiod_get_array(struct device *dev,
 						const char *con_id,
@@ -4658,6 +4741,12 @@ EXPORT_SYMBOL_GPL(gpiod_get_array);
  *
  * This is equivalent to gpiod_get_array(), except that when no GPIO was
  * assigned to the requested function it will return NULL.
+ *
+ * Returns:
+ * The GPIO descriptors corresponding to the function @con_id of device
+ * dev, NULL if no GPIO has been assigned to the requested function,
+ * or another IS_ERR() code if an error occurred while trying to acquire
+ * the GPIOs.
  */
 struct gpio_descs *__must_check gpiod_get_array_optional(struct device *dev,
 							const char *con_id,
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 7f94580efdbc..cb950a3384e3 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -28,7 +28,7 @@
  * @mockdev: class device used by the deprecated sysfs interface (may be
  * NULL)
  * @owner: helps prevent removal of modules exporting active GPIOs
- * @chip: pointer to the corresponding gpiochip, holding static
+ * @chip: pointer to the corresponding struct gpio_chip, holding static
  * data for this device
  * @descs: array of ngpio descriptors.
  * @ngpio: the number of GPIO lines on this GPIO device, equal to the size
@@ -73,10 +73,10 @@ struct gpio_device {
 
 #ifdef CONFIG_PINCTRL
 	/*
-	 * If CONFIG_PINCTRL is enabled, then gpio controllers can optionally
+	 * If CONFIG_PINCTRL is enabled, then GPIO chips can optionally
 	 * describe the actual pin range which they serve in an SoC. This
 	 * information would be used by pinctrl subsystem to configure
-	 * corresponding pins for gpio usage.
+	 * corresponding pins for GPIO usage.
 	 */
 	struct list_head pin_ranges;
 #endif
@@ -240,7 +240,7 @@ int gpiochip_get_ngpios(struct gpio_chip *gc, struct device *dev);
 const char *gpiod_get_label(struct gpio_desc *desc);
 
 /*
- * Return the GPIO number of the passed descriptor relative to its chip
+ * Return the GPIO number of the passed descriptor relative to its chip.
  */
 static inline int gpio_chip_hwgpio(const struct gpio_desc *desc)
 {
-- 
2.43.0.rc1.1.gbec44491f096


