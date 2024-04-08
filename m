Return-Path: <linux-kernel+bounces-136005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C34289CED4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB7A285F7E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6860D14A4C7;
	Mon,  8 Apr 2024 23:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IgxfjYsP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E0A143C65;
	Mon,  8 Apr 2024 23:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712618263; cv=none; b=hsm1vy/0Pw5uRDdzPbknD+2EqiePv1yso4EhwM0pSiKITwAEUe/9wFpyGvGufABlyCt3eKWplh11ec1uIXdVuaGhMp+Hr6FEfGDAqYN/IuddxX7R56idm4WkAu0WVh5NfREnPkKAobPCaqNqJzLCVMmVI2c0SspLq4JJtms6MRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712618263; c=relaxed/simple;
	bh=ku0oWaKaZLcC5BgVxP1Kxt1DJs54baHBFAjVJTeOkDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IqlhYFgf22Eq+xw2c6b/OmYdJyiCJY1ysVeWGWV/zx1GPIzfMXwjE6taerArKvCiRdy16HPTw1RLohv7fcAhHNQxZCtdYaQQqdDG4tCleErlvjkspSr8IUQpExTFa+U7Z3EPhj4mTsBZrCqA/uaeH1s2UF5xCRDkuLl7bxfOkS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IgxfjYsP; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712618262; x=1744154262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ku0oWaKaZLcC5BgVxP1Kxt1DJs54baHBFAjVJTeOkDo=;
  b=IgxfjYsPppSPIYMkUBiIPk4d6gs8a7b3Q3/fnFpHWQW947+k8fCF1T+s
   bFdIBOXG/nia5jgOuLXyJ/vwP/cI3m3cbzLqTHGEUQ9Y6sYDTeHZyXFVu
   zp7l/8aPsQ71jcxHksQZ8IMv3VUQN8azSi5ufbHfQpp3It0/qWmeBe6eQ
   w69nLpbL1j6raEVCkZXMaO4qBlEdHU3KOMO1ed9s1MkwTjz+NgeaPeL9g
   UHMXnQe0CNOv3OXWWTvWBSvOFK2X9WaorwXujDKdAzi/QHWmYLlOrgGkq
   KBjhisCtIQlM3Nl/J4ijlvlZYCHabgY9mx8vWJxM0iaI5OI5KqvP/rti0
   g==;
X-CSE-ConnectionGUID: +//eCBanTH62gYX9dgNv/A==
X-CSE-MsgGUID: JA32oFg5QIaSLYYV37AcuQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7831118"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="7831118"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 16:17:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="937092376"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="937092376"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Apr 2024 16:17:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id CB70BE3; Tue,  9 Apr 2024 02:17:33 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Kent Gibson <warthog618@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH v2 1/2] gpiolib: Fix a mess with the GPIO_* flags
Date: Tue,  9 Apr 2024 02:12:50 +0300
Message-ID: <20240408231727.396452-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240408231727.396452-1-andriy.shevchenko@linux.intel.com>
References: <20240408231727.396452-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GPIO_* flag definitions are *almost* duplicated in two files
(with unmatches OPEN_SOURCE / OPEN_DRAIN). Moreover, some code relies
on one set of definitions while the rest is on the other. Clean up
this mess by providing only one source of the definitions to all.

Fixes: b424808115cb ("brcm80211: brcmsmac: Move LEDs to GPIO descriptors")
Fixes: 5923ea6c2ce6 ("gpio: pass lookup and descriptor flags to request_own")
Fixes: fed7026adc7c ("gpiolib: Make use of enum gpio_lookup_flags consistent")
Fixes: 4c0facddb7d8 ("gpio: core: Decouple open drain/source flag with active low/high")
Fixes: 69d301fdd196 ("gpio: add DT bindings for existing consumer flags")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-of.c                     |  5 ++---
 drivers/gpio/gpiolib.c                        |  8 +++-----
 .../broadcom/brcm80211/brcmsmac/led.c         |  2 +-
 include/linux/gpio/driver.h                   |  3 +--
 include/linux/gpio/machine.h                  | 20 +++++--------------
 5 files changed, 12 insertions(+), 26 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index cb0cefaec37e..2f251b08173c 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -434,7 +434,7 @@ int of_get_named_gpio(const struct device_node *np, const char *propname,
 }
 EXPORT_SYMBOL_GPL(of_get_named_gpio);
 
-/* Converts gpio_lookup_flags into bitmask of GPIO_* values */
+/* Converts of_gpio_flags into bitmask of GPIO_* values */
 static unsigned long of_convert_gpio_flags(enum of_gpio_flags flags)
 {
 	unsigned long lflags = GPIO_LOOKUP_FLAGS_DEFAULT;
@@ -708,8 +708,7 @@ struct gpio_desc *of_find_gpio(struct device_node *np, const char *con_id,
  * @chip:	GPIO chip whose hog is parsed
  * @idx:	Index of the GPIO to parse
  * @name:	GPIO line name
- * @lflags:	bitmask of gpio_lookup_flags GPIO_* values - returned from
- *		of_find_gpio() or of_parse_own_gpio()
+ * @lflags:	bitmask of GPIO_* values - returned from *_find_gpio()
  * @dflags:	gpiod_flags - optional GPIO initialization flags
  *
  * Returns GPIO descriptor to use with Linux GPIO API, or one of the errno
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 69542c2a5b70..cb66506bebde 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2432,7 +2432,7 @@ static inline const char *function_name_or_default(const char *con_id)
 struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *gc,
 					    unsigned int hwnum,
 					    const char *label,
-					    enum gpio_lookup_flags lflags,
+					    unsigned long lflags,
 					    enum gpiod_flags dflags)
 {
 	struct gpio_desc *desc = gpiochip_get_desc(gc, hwnum);
@@ -4348,8 +4348,7 @@ EXPORT_SYMBOL_GPL(gpiod_get_optional);
  * gpiod_configure_flags - helper function to configure a given GPIO
  * @desc:	gpio whose value will be assigned
  * @con_id:	function within the GPIO consumer
- * @lflags:	bitmask of gpio_lookup_flags GPIO_* values - returned from
- *		of_find_gpio() or of_get_gpio_hog()
+ * @lflags:	bitmask of GPIO_* values - returned from *_find_gpio()
  * @dflags:	gpiod_flags - optional GPIO initialization flags
  *
  * Return 0 on success, -ENOENT if no GPIO has been assigned to the
@@ -4475,8 +4474,7 @@ EXPORT_SYMBOL_GPL(gpiod_get_index_optional);
  * gpiod_hog - Hog the specified GPIO desc given the provided flags
  * @desc:	gpio whose value will be assigned
  * @name:	gpio line name
- * @lflags:	bitmask of gpio_lookup_flags GPIO_* values - returned from
- *		of_find_gpio() or of_get_gpio_hog()
+ * @lflags:	bitmask of GPIO_* values - returned from *_find_gpio()
  * @dflags:	gpiod_flags - optional GPIO initialization flags
  */
 int gpiod_hog(struct gpio_desc *desc, const char *name,
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
index 9540a05247c2..be07d9ba8283 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
@@ -60,8 +60,8 @@ int brcms_led_register(struct brcms_info *wl)
 		&sprom->gpio1,
 		&sprom->gpio2,
 		&sprom->gpio3 };
+	unsigned long lflags = GPIO_ACTIVE_HIGH;
 	int hwnum = -1;
-	enum gpio_lookup_flags lflags = GPIO_ACTIVE_HIGH;
 
 	/* find radio enabled LED */
 	for (i = 0; i < BRCMS_LED_NO; i++) {
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index f8617eaf08ba..0c506c7485bd 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -31,7 +31,6 @@ struct gpio_chip;
 struct gpio_desc;
 struct gpio_device;
 
-enum gpio_lookup_flags;
 enum gpiod_flags;
 
 union gpio_irq_fwspec {
@@ -789,7 +788,7 @@ gpiochip_remove_pin_ranges(struct gpio_chip *gc)
 struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *gc,
 					    unsigned int hwnum,
 					    const char *label,
-					    enum gpio_lookup_flags lflags,
+					    unsigned long lflags,
 					    enum gpiod_flags dflags);
 void gpiochip_free_own_desc(struct gpio_desc *desc);
 
diff --git a/include/linux/gpio/machine.h b/include/linux/gpio/machine.h
index 44e5f162973e..8221ee91c6f2 100644
--- a/include/linux/gpio/machine.h
+++ b/include/linux/gpio/machine.h
@@ -2,21 +2,11 @@
 #ifndef __LINUX_GPIO_MACHINE_H
 #define __LINUX_GPIO_MACHINE_H
 
+#include <dt-bindings/gpio/gpio.h> /* for GPIO_* flags */
 #include <linux/types.h>
 
-enum gpio_lookup_flags {
-	GPIO_ACTIVE_HIGH		= (0 << 0),
-	GPIO_ACTIVE_LOW			= (1 << 0),
-	GPIO_OPEN_DRAIN			= (1 << 1),
-	GPIO_OPEN_SOURCE		= (1 << 2),
-	GPIO_PERSISTENT			= (0 << 3),
-	GPIO_TRANSITORY			= (1 << 3),
-	GPIO_PULL_UP			= (1 << 4),
-	GPIO_PULL_DOWN			= (1 << 5),
-	GPIO_PULL_DISABLE		= (1 << 6),
-
-	GPIO_LOOKUP_FLAGS_DEFAULT	= GPIO_ACTIVE_HIGH | GPIO_PERSISTENT,
-};
+/* Additional GPIO_* flags for internal use */
+#define GPIO_LOOKUP_FLAGS_DEFAULT	(GPIO_ACTIVE_HIGH | GPIO_PERSISTENT)
 
 /**
  * struct gpiod_lookup - lookup table
@@ -27,7 +17,7 @@ enum gpio_lookup_flags {
  *              U16_MAX to indicate that @key is a GPIO line name
  * @con_id: name of the GPIO from the device's point of view
  * @idx: index of the GPIO in case several GPIOs share the same name
- * @flags: bitmask of gpio_lookup_flags GPIO_* values
+ * @flags: bitmask of GPIO_* values
  *
  * gpiod_lookup is a lookup table for associating GPIOs to specific devices and
  * functions using platform data.
@@ -51,7 +41,7 @@ struct gpiod_lookup_table {
  * @chip_label: name of the chip the GPIO belongs to
  * @chip_hwnum: hardware number (i.e. relative to the chip) of the GPIO
  * @line_name: consumer name for the hogged line
- * @lflags: bitmask of gpio_lookup_flags GPIO_* values
+ * @lflags: bitmask of GPIO_* values
  * @dflags: GPIO flags used to specify the direction and value
  */
 struct gpiod_hog {
-- 
2.43.0.rc1.1.gbec44491f096


