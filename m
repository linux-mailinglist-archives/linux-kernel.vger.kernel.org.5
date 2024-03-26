Return-Path: <linux-kernel+bounces-119667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C998C88CBBB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C691F84F6A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B3E85293;
	Tue, 26 Mar 2024 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PjUe2jSY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465E613CC4A;
	Tue, 26 Mar 2024 18:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476648; cv=none; b=tqsOBgo6r3dP1ei3HXKI4plVW3/HL9fEInY1nXdq/82RMm2vna3/ye3NqwL4tJU4/TYeFKbZ1mfj9DkvPC4y8j6ZDPlRMadXfNVhmopZGbLr1OwOSULpEIgnWIXdW1sYf5le4kg1x3SUJJ9MEexZz8M6LawXArgNTiUfCvKBvcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476648; c=relaxed/simple;
	bh=y3OFV8ojkqypOZZ1eY8yTN0O6AaepbldILI9QHFUGRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/4oWDrvbRnGgegb0kiivrWHxDRRjg1NVoxCNtEqkUiaGggyet4hOQr4IiRzr6U00U1TCf73ahBRrzLoNfGjL/aCpzfGapKNVd/1Vi0dmsMjy+9tGeDaqfzs0Fll3vJk5qUbGmMd0Zq5wkSLBT1+O6zbgflUkVaiJKqCe4ICojE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PjUe2jSY; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711476646; x=1743012646;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y3OFV8ojkqypOZZ1eY8yTN0O6AaepbldILI9QHFUGRI=;
  b=PjUe2jSYSRkeah+XZE4iL6B9YK8fKX2NBOSV1vZy3uWnGC4qk7sxeB9n
   HhQZtZj4nnJ/CuGQjazTzJdLnCCtsAQ0EjrZ0+z/0KgJkdg+ugnsdHvoX
   HwvuoZna0BQhnA8p9p+ImBxPBTJndBgeAZMDRJGWfSbor0l4iYr2f3k1U
   Gmc5WHwmKdpihkLO4rQRavnJBjlUV4Z3q6XxrjqQ7n7gyPt1+3nefYX+2
   j8iKW/MaagXbFTN+kmYdKLCYVLmRudpGhvzi/Z1hGMPhANABLWXnhy0gJ
   1xfsg0OXc+cAa7e7cn3jgM2ruo2u0HR+uN0UZmbhcDlycYTaRIXjYaAb9
   Q==;
X-CSE-ConnectionGUID: XGp6xilJRSu/1HfJGBsI4Q==
X-CSE-MsgGUID: q5JPCNn5QDOP8/a5LD9QKQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="10325741"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="10325741"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 11:10:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="937072943"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="937072943"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Mar 2024 11:10:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3A02FE3C; Tue, 26 Mar 2024 20:10:35 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v1 08/10] spi: pxa2xx: Move contents of linux/spi/pxa2xx_spi.h to a local one
Date: Tue, 26 Mar 2024 20:07:58 +0200
Message-ID: <20240326181027.1418989-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240326181027.1418989-1-andriy.shevchenko@linux.intel.com>
References: <20240326181027.1418989-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no user of the linux/spi/pxa2xx_spi.h. Move its contents
to the drivers/spi/spi-pxa2xx.h.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx-dma.c   |  1 -
 drivers/spi/spi-pxa2xx-pci.c   |  4 +--
 drivers/spi/spi-pxa2xx.c       |  1 -
 drivers/spi/spi-pxa2xx.h       | 36 ++++++++++++++++++++++++-
 include/linux/spi/pxa2xx_spi.h | 48 ----------------------------------
 5 files changed, 37 insertions(+), 53 deletions(-)
 delete mode 100644 include/linux/spi/pxa2xx_spi.h

diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
index be563f0dd03a..26416ced6505 100644
--- a/drivers/spi/spi-pxa2xx-dma.c
+++ b/drivers/spi/spi-pxa2xx-dma.c
@@ -12,7 +12,6 @@
 #include <linux/scatterlist.h>
 #include <linux/sizes.h>
 
-#include <linux/spi/pxa2xx_spi.h>
 #include <linux/spi/spi.h>
 
 #include "spi-pxa2xx.h"
diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 861b21c63504..e11a613bc340 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -10,11 +10,11 @@
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 
-#include <linux/spi/pxa2xx_spi.h>
-
 #include <linux/dmaengine.h>
 #include <linux/platform_data/dma-dw.h>
 
+#include "spi-pxa2xx.h"
+
 #define PCI_DEVICE_ID_INTEL_QUARK_X1000		0x0935
 #define PCI_DEVICE_ID_INTEL_BYT			0x0f0e
 #define PCI_DEVICE_ID_INTEL_MRFLD		0x1194
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index f4435c39d096..e22d9d29c7e9 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -24,7 +24,6 @@
 #include <linux/property.h>
 #include <linux/slab.h>
 
-#include <linux/spi/pxa2xx_spi.h>
 #include <linux/spi/spi.h>
 
 #include "spi-pxa2xx.h"
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 45cdbbc71c4b..08296729ea80 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -7,6 +7,7 @@
 #ifndef SPI_PXA2XX_H
 #define SPI_PXA2XX_H
 
+#include <linux/dmaengine.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/types.h>
@@ -15,7 +16,40 @@
 #include <linux/pxa2xx_ssp.h>
 
 struct gpio_desc;
-struct pxa2xx_spi_controller;
+
+/*
+ * The platform data for SSP controller devices
+ * (resides in device.platform_data).
+ */
+struct pxa2xx_spi_controller {
+	u8 num_chipselect;
+	u8 enable_dma;
+	u8 dma_burst_size;
+	bool is_target;
+
+	/* DMA engine specific config */
+	dma_filter_fn dma_filter;
+	void *tx_param;
+	void *rx_param;
+
+	/* For non-PXA arches */
+	struct ssp_device ssp;
+};
+
+/*
+ * The controller specific data for SPI target devices
+ * (resides in spi_board_info.controller_data),
+ * copied to spi_device.platform_data ... mostly for
+ * DMA tuning.
+ */
+struct pxa2xx_spi_chip {
+	u8 tx_threshold;
+	u8 tx_hi_threshold;
+	u8 rx_threshold;
+	u8 dma_burst_size;
+	u32 timeout;
+};
+
 struct spi_controller;
 struct spi_device;
 struct spi_transfer;
diff --git a/include/linux/spi/pxa2xx_spi.h b/include/linux/spi/pxa2xx_spi.h
deleted file mode 100644
index e5a4a045fb67..000000000000
--- a/include/linux/spi/pxa2xx_spi.h
+++ /dev/null
@@ -1,48 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2005 Stephen Street / StreetFire Sound Labs
- */
-#ifndef __LINUX_SPI_PXA2XX_SPI_H
-#define __LINUX_SPI_PXA2XX_SPI_H
-
-#include <linux/dmaengine.h>
-#include <linux/types.h>
-
-#include <linux/pxa2xx_ssp.h>
-
-struct dma_chan;
-
-/*
- * The platform data for SSP controller devices
- * (resides in device.platform_data).
- */
-struct pxa2xx_spi_controller {
-	u8 num_chipselect;
-	u8 enable_dma;
-	u8 dma_burst_size;
-	bool is_target;
-
-	/* DMA engine specific config */
-	dma_filter_fn dma_filter;
-	void *tx_param;
-	void *rx_param;
-
-	/* For non-PXA arches */
-	struct ssp_device ssp;
-};
-
-/*
- * The controller specific data for SPI target devices
- * (resides in spi_board_info.controller_data),
- * copied to spi_device.platform_data ... mostly for
- * DMA tuning.
- */
-struct pxa2xx_spi_chip {
-	u8 tx_threshold;
-	u8 tx_hi_threshold;
-	u8 rx_threshold;
-	u8 dma_burst_size;
-	u32 timeout;
-};
-
-#endif	/* __LINUX_SPI_PXA2XX_SPI_H */
-- 
2.43.0.rc1.1.gbec44491f096


