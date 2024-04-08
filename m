Return-Path: <linux-kernel+bounces-136019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CD689CEF7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC26BB24667
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28834148FFB;
	Mon,  8 Apr 2024 23:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nAH4ZiT8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C204A2EAE9;
	Mon,  8 Apr 2024 23:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712619130; cv=none; b=PLn/t66WPtL2NAXbuCKzh93AI9OfT0TmQukx20XKcE6pznxF3r1OAWaxefIeSMSXsKSZGRGNO3Gr86gOTgWhaaAGrdB4OeQ2R5ZggOoZiIJWoIvEk6hI+5N5EZxbgDOIkZziy+2fUGrxKRjrWwNmOcpliFVOpERUStOcORop1Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712619130; c=relaxed/simple;
	bh=yIZB8EQSaWasDjEcyEiSbsUsfMZm9fU7bYPjnokrYis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uUURFfJkbD21kLkBXBbH0AxJN2zsxbz6zgEHnJVISK/vB4gFzepxBIlxP+Fqm2uKQcRxNw8ORptB+zflN2zbC947WBshT5iiLc9CEWW14gejDpRfYsMJ6rJtoyTNgK1WTSDFmcpMFKaQUEuAowNDDPqnTvvVJgPsSwmSKJ6FoVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nAH4ZiT8; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712619129; x=1744155129;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yIZB8EQSaWasDjEcyEiSbsUsfMZm9fU7bYPjnokrYis=;
  b=nAH4ZiT8/uiUssxtKTw8xuwGOgVi6QlMORBROeqN6Sy/h9lcxWkQj4xS
   Zed7lmz1GDb2Im74QiurXfae6ORqtMBbAkM3biCPsKvANi2pek0e8Sp6O
   umdSr+X+t08q/3ZyRlkHHvpV4x/smwdMCWbFGQsQSaTUrdDcRs0pgAswo
   OU1nLfxMfBPbUSvH/TgjrQE482GxEZabb/Kb3NLmafLsHKuQF0pmIDjOE
   Yn3VYCE4FYoFSdQx3570fljf1XmU+8dzw5xIxn+KCj4AZIkK8d71hMcWz
   Lj9kuu6ttbnzEJ8or06iUIvc17I7I18onf3FxJNvoLpcRV+g9IXVne5zW
   w==;
X-CSE-ConnectionGUID: 1JwhNWEJQTCAOivomm22NQ==
X-CSE-MsgGUID: 21wDuZ1ZS2qJ7EFZI38ePg==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="19350648"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="19350648"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 16:32:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="937092379"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="937092379"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Apr 2024 16:32:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 288F112C; Tue,  9 Apr 2024 02:32:04 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1 1/1] Documentation: gpio: Replace leading TABs by spaces in the code blocks
Date: Tue,  9 Apr 2024 02:32:01 +0300
Message-ID: <20240408233201.419893-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code blocks are indented with two spaces, if the leading TAB
is occurred the syntax highlighting might be broken in some editors.
To prevent that unify all code blocks by using spaces instead of
leading TAB(s).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/driver-api/gpio/driver.rst | 28 ++++++++++++------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/driver-api/gpio/driver.rst b/Documentation/driver-api/gpio/driver.rst
index bf6319cc531b..e541bd2e898b 100644
--- a/Documentation/driver-api/gpio/driver.rst
+++ b/Documentation/driver-api/gpio/driver.rst
@@ -7,7 +7,7 @@ This document serves as a guide for writers of GPIO chip drivers.
 Each GPIO controller driver needs to include the following header, which defines
 the structures used to define a GPIO driver::
 
-	#include <linux/gpio/driver.h>
+  #include <linux/gpio/driver.h>
 
 
 Internal Representation of GPIOs
@@ -144,7 +144,7 @@ is not open, it will present a high-impedance (tristate) to the external rail::
      in ----||                   |/
             ||--+         in ----|
                 |                |\
-               GND	           GND
+               GND                 GND
 
 This configuration is normally used as a way to achieve one of two things:
 
@@ -550,10 +550,10 @@ the interrupt separately and go with it:
   struct my_gpio *g;
   struct gpio_irq_chip *girq;
 
-  ret = devm_request_threaded_irq(dev, irq, NULL,
-		irq_thread_fn, IRQF_ONESHOT, "my-chip", g);
+  ret = devm_request_threaded_irq(dev, irq, NULL, irq_thread_fn,
+                                  IRQF_ONESHOT, "my-chip", g);
   if (ret < 0)
-	return ret;
+      return ret;
 
   /* Get a pointer to the gpio_irq_chip */
   girq = &g->gc.irq;
@@ -681,12 +681,12 @@ certain operations and keep track of usage inside of the gpiolib subsystem.
 Input GPIOs can be used as IRQ signals. When this happens, a driver is requested
 to mark the GPIO as being used as an IRQ::
 
-	int gpiochip_lock_as_irq(struct gpio_chip *chip, unsigned int offset)
+  int gpiochip_lock_as_irq(struct gpio_chip *chip, unsigned int offset)
 
 This will prevent the use of non-irq related GPIO APIs until the GPIO IRQ lock
 is released::
 
-	void gpiochip_unlock_as_irq(struct gpio_chip *chip, unsigned int offset)
+  void gpiochip_unlock_as_irq(struct gpio_chip *chip, unsigned int offset)
 
 When implementing an irqchip inside a GPIO driver, these two functions should
 typically be called in the .startup() and .shutdown() callbacks from the
@@ -708,12 +708,12 @@ When a GPIO is used as an IRQ signal, then gpiolib also needs to know if
 the IRQ is enabled or disabled. In order to inform gpiolib about this,
 the irqchip driver should call::
 
-	void gpiochip_disable_irq(struct gpio_chip *chip, unsigned int offset)
+  void gpiochip_disable_irq(struct gpio_chip *chip, unsigned int offset)
 
 This allows drivers to drive the GPIO as an output while the IRQ is
 disabled. When the IRQ is enabled again, a driver should call::
 
-	void gpiochip_enable_irq(struct gpio_chip *chip, unsigned int offset)
+  void gpiochip_enable_irq(struct gpio_chip *chip, unsigned int offset)
 
 When implementing an irqchip inside a GPIO driver, these two functions should
 typically be called in the .irq_disable() and .irq_enable() callbacks from the
@@ -763,12 +763,12 @@ Sometimes it is useful to allow a GPIO chip driver to request its own GPIO
 descriptors through the gpiolib API. A GPIO driver can use the following
 functions to request and free descriptors::
 
-	struct gpio_desc *gpiochip_request_own_desc(struct gpio_desc *desc,
-						    u16 hwnum,
-						    const char *label,
-						    enum gpiod_flags flags)
+  struct gpio_desc *gpiochip_request_own_desc(struct gpio_desc *desc,
+                                              u16 hwnum,
+                                              const char *label,
+                                              enum gpiod_flags flags)
 
-	void gpiochip_free_own_desc(struct gpio_desc *desc)
+  void gpiochip_free_own_desc(struct gpio_desc *desc)
 
 Descriptors requested with gpiochip_request_own_desc() must be released with
 gpiochip_free_own_desc().
-- 
2.43.0.rc1.1.gbec44491f096


