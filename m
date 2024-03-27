Return-Path: <linux-kernel+bounces-121909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8C188EF3D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32C5D1F325BE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D829153587;
	Wed, 27 Mar 2024 19:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NDsKTrJf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA151152E13;
	Wed, 27 Mar 2024 19:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711567914; cv=none; b=oYTC342Lt//IF7XYB58Di5esR53kLTXAs1iuhulL3dbkKaVTekOA1ZAQhi0SANm968Rd2WEEWDuL4OjBV/NncXMYDvkOWux4oxT+cxKLjYrcPpOgoFoDg58sJFecDBn8D3adxpPVZRTL5sYNn/QI+6DfwCElF5ON5O1bi3oVc7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711567914; c=relaxed/simple;
	bh=H2+f29cgQEQ3T7alzF7pBJizvVEK6UHSDOHh2UhgE0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eK8lazkhiUe14yniaU7GjgX40PeF9W9nweOpPRnIgUCQ5f9O7dvooctcKj2Y5x9ObepfjAPM/4O6V0tIEZCR4a1y7vpDer9uMF55aIsqWIE0u6lPyfP2EEqGCst+YzoB9FoVYGXEedhvz/BYWXzr2mGlFYfdUdhQvSTluQ2nnMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NDsKTrJf; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711567912; x=1743103912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H2+f29cgQEQ3T7alzF7pBJizvVEK6UHSDOHh2UhgE0c=;
  b=NDsKTrJfVP5mvz2sY91ApzrYfD6tN/h6GY0oQniL4i76C+AMlJVQ5Qo+
   BNJfbZjmZ/uRQyq3tEUVel+q6Tlixp8VAYjHJFJrZEPdkvORMO1cukC+M
   8Dv4/uaUA4a8R84GGYzsnOsRogBuTh4AXYtfjRyya2tBqhztTA1OoOAUu
   3Gwvz0tab3W/Nb44V4I8UXFdaf1Y5Sf0Ji2XRCDM9PVgVjYsZF/OFAoqB
   NAwDJCdwjsrTCesLCxYvHwfqaCgZ+7XuTmBQ8o2H3XjYCc7S6HhRKorMy
   3HK4Psi9byaLmwgHVsYW7oq/L6JhwTlmHdUs9v5zN3Q65nxoMgliWVsFb
   A==;
X-CSE-ConnectionGUID: X71LatsAQia/p0+mdGKWKg==
X-CSE-MsgGUID: FDy+TLKGS3Glp1xSmPYRag==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="24187324"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="24187324"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 12:31:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="937075027"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="937075027"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Mar 2024 12:31:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C5F135A8; Wed, 27 Mar 2024 21:31:42 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH v2 6/9] spi: pxa2xx: Provide num-cs for Sharp PDAs via device properties
Date: Wed, 27 Mar 2024 21:29:25 +0200
Message-ID: <20240327193138.2385910-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240327193138.2385910-1-andriy.shevchenko@linux.intel.com>
References: <20240327193138.2385910-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since driver can parse num-cs device property, replace platform data
with this new approach. This pursues the following objectives:

- getting rid of the public header that barely used outside of
  the SPI subsystem (more specifically the SPI PXA2xx drivers)

- making a trampoline for the driver to support non-default number
  of the chip select pins in case the original code is going to be
  converted to Device Tree model

It's not expected to have more users in board files except this one.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/arm/mach-pxa/spitz.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 318402ad685e..3c5f5a3cb480 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -18,10 +18,10 @@
 #include <linux/i2c.h>
 #include <linux/platform_data/i2c-pxa.h>
 #include <linux/platform_data/pca953x.h>
+#include <linux/property.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 #include <linux/spi/corgi_lcd.h>
-#include <linux/spi/pxa2xx_spi.h>
 #include <linux/mtd/sharpsl.h>
 #include <linux/mtd/physmap.h>
 #include <linux/input-event-codes.h>
@@ -569,10 +569,6 @@ static struct spi_board_info spitz_spi_devices[] = {
 	},
 };
 
-static struct pxa2xx_spi_controller spitz_spi_info = {
-	.num_chipselect	= 3,
-};
-
 static struct gpiod_lookup_table spitz_spi_gpio_table = {
 	.dev_id = "spi2",
 	.table = {
@@ -583,10 +579,20 @@ static struct gpiod_lookup_table spitz_spi_gpio_table = {
 	},
 };
 
+static const struct property_entry spitz_spi_properties[] = {
+	PROPERTY_ENTRY_U32("num-cs", 3),
+	{ }
+};
+
+static const struct software_node spitz_spi_node = {
+	.properties = spitz_spi_properties,
+};
+
 static void __init spitz_spi_init(void)
 {
 	struct platform_device *pd;
 	int id = 2;
+	int err;
 
 	if (machine_is_akita())
 		gpiod_add_lookup_table(&akita_lcdcon_gpio_table);
@@ -601,8 +607,13 @@ static void __init spitz_spi_init(void)
 	if (pd == NULL) {
 		pr_err("pxa2xx-spi: failed to allocate device id %d\n", id);
 	} else {
-		pd->dev.platform_data = &spitz_spi_info;
-		platform_device_add(pd);
+		err = device_add_software_node(&pd->dev, &spitz_spi_node);
+		if (err) {
+			platform_device_put(pd);
+			pr_err("pxa2xx-spi: failed to add software node\n");
+		} else {
+			platform_device_add(pd);
+		}
 	}
 
 	spi_register_board_info(ARRAY_AND_SIZE(spitz_spi_devices));
-- 
2.43.0.rc1.1.gbec44491f096


