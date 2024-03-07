Return-Path: <linux-kernel+bounces-95905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6EC8754CB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 762A61C2139B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2353E12FF9D;
	Thu,  7 Mar 2024 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kS6W9KBK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5563129A75;
	Thu,  7 Mar 2024 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709831088; cv=none; b=EArJnmkObMlVgXQQDnEL0SlVUpLdw8m9+zUko0l+lkkob9JuOC2x6Q+QncTmsbLxpOf/NT7/n4SZ69QD5a53yTu2ARa3QaRaUOVz3oX9GsOCVtSN8AdMPYKHLxUThA7U0LUPkMYOpG/brS+DqdZTx8u0aigYES2HTacBAr3qxoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709831088; c=relaxed/simple;
	bh=vqUkO8TtEYU+TZ1zaI0tn3WCnsWhPGw/MLt7JIPaVqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ASa6hKRAG/GAGzZHyNQiYg0EiNo1m9BI8R+a+YbzjHQIliRYpVMmuZ67EtQUr+i45fFVrs1ccuQfd73FL8g/uzyHWYi4uLcMxJp2quoCwYFAduxEySEUDn25P9E6JleSZnLL2XwNaM6ZkY3ZBvWRdlyN4sU2bmKAk2B9yDLObos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kS6W9KBK; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709831087; x=1741367087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vqUkO8TtEYU+TZ1zaI0tn3WCnsWhPGw/MLt7JIPaVqM=;
  b=kS6W9KBKAyWjVbB4xCfLAsv/kozJrzACtgWKkj3t6PT9FJaOkZH8Oe5B
   +q/hJl7Vv6w9mABfGnVINbRS/uN5bNdDYe+3Yli8sMiiJN1urDiU90LTX
   k3H0g15dnt3dAjfH5J3cHCObb6cbJTwB6RubKNxcrd3Z+1JNApR7DL9WJ
   bu2onRgAlQftZBY0+JEWyMfAXIO1eYabkauJHGDHz+WM3SYIKaXP2OCkx
   dmox60SkSUNImlJSsKUNmeksmnb4bN9VmvMcOjNGFJ6Gw3DB1vEDTVABg
   W01GCSHztr+9ACLAOWn6HfqC6zfSMYtT77U1PCTD24coMU+FVcmkf5kD8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4392413"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="4392413"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 09:04:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="937046411"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="937046411"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 09:04:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 670D093; Thu,  7 Mar 2024 19:04:42 +0200 (EET)
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
Subject: [PATCH v2 1/3] spi: pxa2xx: Kill pxa2xx_set_spi_info()
Date: Thu,  7 Mar 2024 19:03:15 +0200
Message-ID: <20240307170441.3884452-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240307170441.3884452-1-andriy.shevchenko@linux.intel.com>
References: <20240307170441.3884452-1-andriy.shevchenko@linux.intel.com>
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
 arch/arm/mach-pxa/spitz.c      | 14 +++++++++++++-
 include/linux/spi/pxa2xx_spi.h |  8 --------
 3 files changed, 13 insertions(+), 27 deletions(-)

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
index cc691b199429..be7a3574e951 100644
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
@@ -592,7 +595,16 @@ static void __init spitz_spi_init(void)
 
 	gpiod_add_lookup_table(&spitz_ads7846_gpio_table);
 	gpiod_add_lookup_table(&spitz_spi_gpio_table);
-	pxa2xx_set_spi_info(2, &spitz_spi_info);
+
+	/* pxa2xx-spi platform-device ID equals respective SSP platform-device ID + 1 */
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


