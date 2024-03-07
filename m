Return-Path: <linux-kernel+bounces-95662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F19868750F0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EC2A1F252DA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2AF12EBE3;
	Thu,  7 Mar 2024 13:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N/JF4jwE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2C612D77D;
	Thu,  7 Mar 2024 13:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709819480; cv=none; b=IQFNfMxv7Ef59V10wmTJJgdv4B8mPLjkKM4oUlQio/QpecgTQ1AFXbzd88LuBwFPnPkMha20Plt161dWdxdMwLoyVB8pEmcFd9EPugc0S3khJxMBXslqKl7+JUhdh0XQvUJm+y1FVOb8B4BPAjcOkWcNifaCqkHu0X3oB3aueZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709819480; c=relaxed/simple;
	bh=vxAMR3WP5wNBsRHuWQ+Nqapd0iPc9Ozj7J5mgbE7KXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pz1awZ0AbE5nG9fRhIxks+pNce2drpy3A78fSCIUoxNMrNZjDBg7QfLZueDG4mTUkExLfTsIJO/FuOBaBa1+Hj2yDF4mc/63fGxfzmRPm9zruEr8e/vjQ1G4qW3OK/z3qdNwo4fWgBxx4WZY7tYVsxT20vArswyegEgTwqN5uIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N/JF4jwE; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709819479; x=1741355479;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vxAMR3WP5wNBsRHuWQ+Nqapd0iPc9Ozj7J5mgbE7KXE=;
  b=N/JF4jwElPeqTRY28xOaenPTs3oRZihXLi+0ik8U2SZHBHcKkYLYNXd7
   pUDO9pj1eB3sxn5X8g6QVwwk3NDVFBkI1DAxTa+fHFp+4wdJBmneI7b7p
   SZHhY2hu2JqZxde1DTG8shtvdq8vqyMh83vtE9XzhOY0Qfs56cDoWUTHf
   Xh0LV7VirOC6tB8yZ8oT7T3bpQ251ilhKB63sQOqd4xIfA00yE6mlDxVo
   +fF0gnp/ZF5MLaauolxiFRQyRRLH2/1A4Vnp5eek2eya7PWtKYMia/EKM
   Z5vTi0fnm6ra6a6iQms4qK+KxXPxyMFmoqu/F6nL5hxlCuHJvlaerJ570
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="26960337"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="26960337"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 05:51:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="937046159"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="937046159"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 05:51:12 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 213A4697; Thu,  7 Mar 2024 15:51:11 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Jonathan Corbet <corbet@lwn.net>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Hu Haowen <2023002089@link.tyut.edu.cn>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH v1 3/3] gpiolib: legacy: Remove unused gpio_request_array() and gpio_free_array()
Date: Thu,  7 Mar 2024 15:49:05 +0200
Message-ID: <20240307135109.3778316-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240307135109.3778316-1-andriy.shevchenko@linux.intel.com>
References: <20240307135109.3778316-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

No more users.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/driver-api/gpio/legacy.rst      | 16 --------
 .../zh_CN/driver-api/gpio/legacy.rst          | 16 --------
 Documentation/translations/zh_TW/gpio.txt     | 17 --------
 drivers/gpio/gpiolib-legacy.c                 | 39 -------------------
 include/linux/gpio.h                          | 15 -------
 5 files changed, 103 deletions(-)

diff --git a/Documentation/driver-api/gpio/legacy.rst b/Documentation/driver-api/gpio/legacy.rst
index b6505914791c..534dfe95d128 100644
--- a/Documentation/driver-api/gpio/legacy.rst
+++ b/Documentation/driver-api/gpio/legacy.rst
@@ -225,8 +225,6 @@ setup or driver probe/teardown code, so this is an easy constraint.)::
                 gpio_request()
 
         ## 	gpio_request_one()
-        ##	gpio_request_array()
-        ## 	gpio_free_array()
 
                 gpio_free()
 
@@ -295,14 +293,6 @@ are claimed, three additional calls are defined::
 	 */
 	int gpio_request_one(unsigned gpio, unsigned long flags, const char *label);
 
-	/* request multiple GPIOs in a single call
-	 */
-	int gpio_request_array(struct gpio *array, size_t num);
-
-	/* release multiple GPIOs in a single call
-	 */
-	void gpio_free_array(struct gpio *array, size_t num);
-
 where 'flags' is currently defined to specify the following properties:
 
 	* GPIOF_DIR_IN		- to configure direction as input
@@ -341,12 +331,6 @@ A typical example of usage::
 	if (err)
 		...
 
-	err = gpio_request_array(leds_gpios, ARRAY_SIZE(leds_gpios));
-	if (err)
-		...
-
-	gpio_free_array(leds_gpios, ARRAY_SIZE(leds_gpios));
-
 
 GPIOs mapped to IRQs
 --------------------
diff --git a/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst b/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst
index aeccff777170..0faf042001d2 100644
--- a/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst
+++ b/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst
@@ -208,8 +208,6 @@ GPIO 值的命令需要等待其信息排到队首才发送命令，再获得其
                 gpio_request()
 
         ## 	gpio_request_one()
-        ##	gpio_request_array()
-        ## 	gpio_free_array()
 
                 gpio_free()
 
@@ -272,14 +270,6 @@ gpio_request()前将这类细节配置好，例如使用引脚控制子系统的
 	 */
 	int gpio_request_one(unsigned gpio, unsigned long flags, const char *label);
 
-	/* 在单个函数中申请多个 GPIO
-	 */
-	int gpio_request_array(struct gpio *array, size_t num);
-
-	/* 在单个函数中释放多个 GPIO
-	 */
-	void gpio_free_array(struct gpio *array, size_t num);
-
 这里 'flags' 当前定义可指定以下属性:
 
 	* GPIOF_DIR_IN		- 配置方向为输入
@@ -317,12 +307,6 @@ gpio_request()前将这类细节配置好，例如使用引脚控制子系统的
 	if (err)
 		...
 
-	err = gpio_request_array(leds_gpios, ARRAY_SIZE(leds_gpios));
-	if (err)
-		...
-
-	gpio_free_array(leds_gpios, ARRAY_SIZE(leds_gpios));
-
 
 GPIO 映射到 IRQ
 ----------------
diff --git a/Documentation/translations/zh_TW/gpio.txt b/Documentation/translations/zh_TW/gpio.txt
index b9b48012c62e..77d69d381316 100644
--- a/Documentation/translations/zh_TW/gpio.txt
+++ b/Documentation/translations/zh_TW/gpio.txt
@@ -215,13 +215,10 @@ GPIO 值的命令需要等待其信息排到隊首才發送命令，再獲得其
 	gpio_request()
 
 ## 	gpio_request_one()
-##	gpio_request_array()
-## 	gpio_free_array()
 
 	gpio_free()
 
 
-
 聲明和釋放 GPIO
 ----------------------------
 爲了有助於捕獲系統配置錯誤,定義了兩個函數。
@@ -278,14 +275,6 @@ gpio_request()前將這類細節配置好，例如使用 pinctrl 子系統的映
 	 */
 	int gpio_request_one(unsigned gpio, unsigned long flags, const char *label);
 
-	/* 在單個函數中申請多個 GPIO
-	 */
-	int gpio_request_array(struct gpio *array, size_t num);
-
-	/* 在單個函數中釋放多個 GPIO
-	 */
-	void gpio_free_array(struct gpio *array, size_t num);
-
 這裡 'flags' 當前定義可指定以下屬性:
 
 	* GPIOF_DIR_IN		- 配置方向爲輸入
@@ -323,12 +312,6 @@ gpio_request()前將這類細節配置好，例如使用 pinctrl 子系統的映
 	if (err)
 		...
 
-	err = gpio_request_array(leds_gpios, ARRAY_SIZE(leds_gpios));
-	if (err)
-		...
-
-	gpio_free_array(leds_gpios, ARRAY_SIZE(leds_gpios));
-
 
 GPIO 映射到 IRQ
 --------------------
diff --git a/drivers/gpio/gpiolib-legacy.c b/drivers/gpio/gpiolib-legacy.c
index 3392e758d36f..5a9911ae9125 100644
--- a/drivers/gpio/gpiolib-legacy.c
+++ b/drivers/gpio/gpiolib-legacy.c
@@ -72,42 +72,3 @@ int gpio_request(unsigned gpio, const char *label)
 	return gpiod_request(desc, label);
 }
 EXPORT_SYMBOL_GPL(gpio_request);
-
-/**
- * gpio_request_array - request multiple GPIOs in a single call
- * @array:	array of the 'struct gpio'
- * @num:	how many GPIOs in the array
- *
- * **DEPRECATED** This function is deprecated and must not be used in new code.
- */
-int gpio_request_array(const struct gpio *array, size_t num)
-{
-	int i, err;
-
-	for (i = 0; i < num; i++, array++) {
-		err = gpio_request_one(array->gpio, array->flags, array->label);
-		if (err)
-			goto err_free;
-	}
-	return 0;
-
-err_free:
-	while (i--)
-		gpio_free((--array)->gpio);
-	return err;
-}
-EXPORT_SYMBOL_GPL(gpio_request_array);
-
-/**
- * gpio_free_array - release multiple GPIOs in a single call
- * @array:	array of the 'struct gpio'
- * @num:	how many GPIOs in the array
- *
- * **DEPRECATED** This function is deprecated and must not be used in new code.
- */
-void gpio_free_array(const struct gpio *array, size_t num)
-{
-	while (num--)
-		gpio_free((array++)->gpio);
-}
-EXPORT_SYMBOL_GPL(gpio_free_array);
diff --git a/include/linux/gpio.h b/include/linux/gpio.h
index f4e5406554bb..56ac7e7a2889 100644
--- a/include/linux/gpio.h
+++ b/include/linux/gpio.h
@@ -120,8 +120,6 @@ static inline int gpio_to_irq(unsigned gpio)
 }
 
 int gpio_request_one(unsigned gpio, unsigned long flags, const char *label);
-int gpio_request_array(const struct gpio *array, size_t num);
-void gpio_free_array(const struct gpio *array, size_t num);
 
 /* CONFIG_GPIOLIB: bindings for managed devices that want to request gpios */
 
@@ -152,11 +150,6 @@ static inline int gpio_request_one(unsigned gpio,
 	return -ENOSYS;
 }
 
-static inline int gpio_request_array(const struct gpio *array, size_t num)
-{
-	return -ENOSYS;
-}
-
 static inline void gpio_free(unsigned gpio)
 {
 	might_sleep();
@@ -165,14 +158,6 @@ static inline void gpio_free(unsigned gpio)
 	WARN_ON(1);
 }
 
-static inline void gpio_free_array(const struct gpio *array, size_t num)
-{
-	might_sleep();
-
-	/* GPIO can never have been requested */
-	WARN_ON(1);
-}
-
 static inline int gpio_direction_input(unsigned gpio)
 {
 	return -ENOSYS;
-- 
2.43.0.rc1.1.gbec44491f096


