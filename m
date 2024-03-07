Return-Path: <linux-kernel+bounces-95661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B858750EA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E1371F22820
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607C712E1DF;
	Thu,  7 Mar 2024 13:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FaRxF0bX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C5312D765;
	Thu,  7 Mar 2024 13:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709819479; cv=none; b=RJZcQCl8/kpjoetgaLI7oujYyY5huIyXWRon3ClY1iu9dI3AaLdM24o48gPL/TZjm6u3ALlKWMGVLdRhDoKLlUq83LxhNve3a+oo34lFLQsFyPCDvWXUELI1voNGagABK3LlC2t0qRrYpai26fMOomhZhqoTm3tiWAENksQ/Sik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709819479; c=relaxed/simple;
	bh=Zl1ZwjdCwvGQxetgUvY4jVAUPX49ROq+BTSxqfQpADs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQn3TNvd58j/Dyhh/mLt1yGxrYrZPCOb4dv14Di4EGyP6iSPP1CTZQ44z27QKOPQqARuLnLzqyZolI2mQ6rQTenjtw4T4AHn8gEyQxV8beuhDYeWHB+2+xSYgnJWPZPD4YQEuQDEtAKFYFWhrZHlXILevt2GwO78pPUbktrc7Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FaRxF0bX; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709819478; x=1741355478;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zl1ZwjdCwvGQxetgUvY4jVAUPX49ROq+BTSxqfQpADs=;
  b=FaRxF0bXabzcjrcsHXw6bhWwTCfZowcwmlvnL4WO/y6wFS2RkrRl8PNK
   BWKqW0aeHyJfNh+kBy6dTz103ox/C3MO9h04v6ygipmU/m1Kx///0OxOD
   DyshsuPJIeMoQ6aOOlCOtSXsEQf22kcwEg+RUhbZv+JDIy6n8IbfePhJN
   M3UucgKOq32VjXBN6YL0OVfKJoNc2n+17dCeWkOc+iJCyLSrn6kVf9XoO
   Vm6J7D3SqXrvofkPrC4NYN2BXnwSog0YSwNi8/ZuBY5G/9mzb13D3wRiv
   U8r6RND67kItwlLaVxAZHzVUHYWAx+sXBzASqqFAFXKJLRizyJhvSx2ZV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="26960323"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="26960323"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 05:51:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="937046158"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="937046158"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 05:51:12 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 157ED5BB; Thu,  7 Mar 2024 15:51:11 +0200 (EET)
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
Subject: [PATCH v1 2/3] ARM: sa1100: Open code gpio_request_array()
Date: Thu,  7 Mar 2024 15:49:04 +0200
Message-ID: <20240307135109.3778316-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240307135109.3778316-1-andriy.shevchenko@linux.intel.com>
References: <20240307135109.3778316-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to prerare for removal of gpio_request_array(), open code
the latter. Note, we are not using gpio_request_one() as it's also
deprecated, hence reducing legacy API usage to the very basic ones.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/arm/mach-sa1100/h3600.c | 47 +++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-sa1100/h3600.c b/arch/arm/mach-sa1100/h3600.c
index 5e25dfa752e9..1cfc0b1fa41c 100644
--- a/arch/arm/mach-sa1100/h3600.c
+++ b/arch/arm/mach-sa1100/h3600.c
@@ -20,16 +20,6 @@
 
 #include "generic.h"
 
-/*
- * helper for sa1100fb
- */
-static struct gpio h3600_lcd_gpio[] = {
-	{ H3XXX_EGPIO_LCD_ON,	GPIOF_OUT_INIT_LOW,	"LCD power" },
-	{ H3600_EGPIO_LCD_PCI,	GPIOF_OUT_INIT_LOW,	"LCD control" },
-	{ H3600_EGPIO_LCD_5V_ON, GPIOF_OUT_INIT_LOW,	"LCD 5v" },
-	{ H3600_EGPIO_LVDD_ON,	GPIOF_OUT_INIT_LOW,	"LCD 9v/-6.5v" },
-};
-
 static bool h3600_lcd_request(void)
 {
 	static bool h3600_lcd_ok;
@@ -38,7 +28,42 @@ static bool h3600_lcd_request(void)
 	if (h3600_lcd_ok)
 		return true;
 
-	rc = gpio_request_array(h3600_lcd_gpio, ARRAY_SIZE(h3600_lcd_gpio));
+	rc = gpio_request(H3XXX_EGPIO_LCD_ON, "LCD power");
+	if (rc)
+		goto out;
+	rc = gpio_direction_output(H3XXX_EGPIO_LCD_ON, 0);
+	if (rc)
+		goto out_free_on;
+	rc = gpio_request(H3600_EGPIO_LCD_PCI, "LCD control");
+	if (rc)
+		goto out_free_on;
+	rc = gpio_direction_output(H3600_EGPIO_LCD_PCI, 0);
+	if (rc)
+		goto out_free_pci;
+	rc = gpio_request(H3600_EGPIO_LCD_5V_ON, "LCD 5v");
+	if (rc)
+		goto out_free_pci;
+	rc = gpio_direction_output(H3600_EGPIO_LCD_5V_ON, 0);
+	if (rc)
+		goto out_free_5v_on;
+	rc = gpio_request(H3600_EGPIO_LVDD_ON, "LCD 9v/-6.5v");
+	if (rc)
+		goto out_free_5v_on;
+	rc = gpio_direction_output(H3600_EGPIO_LVDD_ON, 0);
+	if (rc)
+		goto out_free_lvdd_on;
+
+	goto out;
+
+out_free_lvdd_on:
+	gpio_free(H3600_EGPIO_LVDD_ON);
+out_free_5v_on:
+	gpio_free(H3600_EGPIO_LCD_5V_ON);
+out_free_pci:
+	gpio_free(H3600_EGPIO_LCD_PCI);
+out_free_on:
+	gpio_free(H3XXX_EGPIO_LCD_ON);
+out:
 	if (rc)
 		pr_err("%s: can't request GPIOs\n", __func__);
 	else
-- 
2.43.0.rc1.1.gbec44491f096


