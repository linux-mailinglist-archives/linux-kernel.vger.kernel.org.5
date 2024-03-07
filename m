Return-Path: <linux-kernel+bounces-95844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B208753E4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43CE8283E31
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E4C12FB32;
	Thu,  7 Mar 2024 16:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aAnUOpvg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1769212F5A0;
	Thu,  7 Mar 2024 16:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709827726; cv=none; b=ZYnoMRMud28gfk6Q8QefvFqauMcBj4aM5Ik41Rv4S0LcJzr0Ed1X5NNRM1W8Md6vnivCTouq2si68d8uiMExXkqTC6qRUbr3ErSSY00ym7LrR8BT/PE0AjWDt6U/8Ik6M55utICakrFkeP57K+TBcATQw6Va1FJhnZPOgM4eejw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709827726; c=relaxed/simple;
	bh=b54sMnveccHBtra98fGbKYy1sRxG2doqPjrqZUCNqmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FQZ6SNFJ1OilRJk7ITxBiyyfnyLE3ATFi6Q9Rnhj2ClO1H6tQFkfKjdwD0C+CPEGeGQ+u3rBMGLk1feN4tH5ApXhnNYyy9U4Nr8Np2zhRSC3X46kn3X7yo48tLvew7X95q3TMGppu0u+8XCOtwGcjGNWtSOuvj1QThxt8XaWXNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aAnUOpvg; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709827725; x=1741363725;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b54sMnveccHBtra98fGbKYy1sRxG2doqPjrqZUCNqmE=;
  b=aAnUOpvgCQW723cp4ADjRddxGgiJWe51CZeD+MmFBO5k497MjGEhwlY3
   2Kzv5RYTnGTQdA5YWYUyvUdfK8Ciau2zLkSXBMJmX3CiudDuZB0fW53PK
   dPWduyFWb87DJ8lltgf7l+hYjsMIxcDpOoFk0dYGsgoNUS+taP7wwH4xF
   k486/sdOIubmmdlFSgNJqDvKQ1Frqx94HNZ6IajEckpu1MrOWg2rmHPyj
   kdHBGTs5O9ShoETCEq7rPvUTBBgkcUOrIrbhx2w6TWQWT6GlhlzujX7QJ
   D+nHipNTFWj586SFvw/jxRekk6qtEF280bcB9kAO82Zle4qsCAvOGSkJ4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15227316"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="15227316"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 08:08:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="937046346"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="937046346"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 08:08:25 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 73696193; Thu,  7 Mar 2024 18:08:24 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 1/2] spi: pxa2xx: Kill pxa2xx_set_spi_info()
Date: Thu,  7 Mar 2024 18:07:38 +0200
Message-ID: <20240307160823.3800932-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240307160823.3800932-1-andriy.shevchenko@linux.intel.com>
References: <20240307160823.3800932-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is the only one user of the pxa2xx_set_spi_info(). Unexport it
and inline to the actual user.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/arm/mach-pxa/devices.c    | 18 ------------------
 arch/arm/mach-pxa/spitz.c      | 13 ++++++++++++-
 include/linux/spi/pxa2xx_spi.h |  8 --------
 3 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 661b3fc43275..1e4cd502340e 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -7,7 +7,6 @@
 #include <linux/clk-provider.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
-#include <linux/spi/pxa2xx_spi.h>
 #include <linux/platform_data/i2c-pxa.h>
 #include <linux/soc/pxa/cpu.h>
 
@@ -665,23 +664,6 @@ struct platform_device pxa27x_device_gpio = {
 	.resource	= pxa_resource_gpio,
 };
 
-/* pxa2xx-spi platform-device ID equals respective SSP platform-device ID + 1.
- * See comment in arch/arm/mach-pxa/ssp.c::ssp_probe() */
-void __init pxa2xx_set_spi_info(unsigned id, struct pxa2xx_spi_controller *info)
-{
-	struct platform_device *pd;
-
-	pd = platform_device_alloc("pxa2xx-spi", id);
-	if (pd == NULL) {
-		printk(KERN_ERR "pxa2xx-spi: failed to allocate device id %d\n",
-		       id);
-		return;
-	}
-
-	pd->dev.platform_data = info;
-	platform_device_add(pd);
-}
-
 static struct resource pxa_dma_resource[] = {
 	[0] = {
 		.start	= 0x40000000,
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index cc691b199429..70e4623907fa 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -585,6 +585,9 @@ static struct gpiod_lookup_table spitz_spi_gpio_table = {
 
 static void __init spitz_spi_init(void)
 {
+	struct platform_device *pd;
+	int id = 2;
+
 	if (machine_is_akita())
 		gpiod_add_lookup_table(&akita_lcdcon_gpio_table);
 	else
@@ -592,7 +595,15 @@ static void __init spitz_spi_init(void)
 
 	gpiod_add_lookup_table(&spitz_ads7846_gpio_table);
 	gpiod_add_lookup_table(&spitz_spi_gpio_table);
-	pxa2xx_set_spi_info(2, &spitz_spi_info);
+
+	pd = platform_device_alloc("pxa2xx-spi", id);
+	if (pd == NULL) {
+		pr_err("pxa2xx-spi: failed to allocate device id %d\n", id);
+	} else {
+		pd->dev.platform_data = info;
+		platform_device_add(pd);
+	}
+
 	spi_register_board_info(ARRAY_AND_SIZE(spitz_spi_devices));
 }
 #else
diff --git a/include/linux/spi/pxa2xx_spi.h b/include/linux/spi/pxa2xx_spi.h
index ca2cd4e30ead..56aba2f737b1 100644
--- a/include/linux/spi/pxa2xx_spi.h
+++ b/include/linux/spi/pxa2xx_spi.h
@@ -45,12 +45,4 @@ struct pxa2xx_spi_chip {
 	u32 timeout;
 };
 
-#if defined(CONFIG_ARCH_PXA) || defined(CONFIG_ARCH_MMP)
-
-#include <linux/clk.h>
-
-extern void pxa2xx_set_spi_info(unsigned id, struct pxa2xx_spi_controller *info);
-
-#endif
-
 #endif	/* __LINUX_SPI_PXA2XX_SPI_H */
-- 
2.43.0.rc1.1.gbec44491f096


