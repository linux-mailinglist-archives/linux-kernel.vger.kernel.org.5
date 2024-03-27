Return-Path: <linux-kernel+bounces-121908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DBA88EF3C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53271B24894
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FDE15357C;
	Wed, 27 Mar 2024 19:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OxQmHu7b"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7E5152DFE;
	Wed, 27 Mar 2024 19:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711567914; cv=none; b=ruJn8/ZCjKPeiAakbIqtqCgEFMHKtccBvfqgCMIJ/e9S5b/6NF1bDIOWGy1pl/RdhQuku1D5DCyjKuFFyM0ySdDjwAANKUybFcyJmrzih0tB/CwNvHNk1fhB6S7FL1UhSOUMrGXMAxZ0HIfB+tMzB/rvGb4LazMRJ+3eLvAAv2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711567914; c=relaxed/simple;
	bh=y3OFV8ojkqypOZZ1eY8yTN0O6AaepbldILI9QHFUGRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZObr1BlFTZwdxnqS3mdB5xHx1iDYc/ze0tv2CcNnWjN/g+VzxMBejiL6nl/adQWtpyO+tyhA4jL7a+9hoUz593nA2tEsNeS9nbAyzw8ScTf4+w1MQ9DLGHOoVebxiyianfY/NqBxzjTEzqa28jP3rI5cDOqfufvVQ7xFGNSoQww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OxQmHu7b; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711567911; x=1743103911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y3OFV8ojkqypOZZ1eY8yTN0O6AaepbldILI9QHFUGRI=;
  b=OxQmHu7bRaWpotklmuGW23zTDraonTlkx+uXTuNBO7b8RbX9CwATEbZx
   38eYWGWs3YhjeRVExiX+04fArcJ2sokT+tS9WxTtPPThX7Uws1cND5hFn
   Cfwgbpg7zz3nr3zc+FjJBf4+ryDD0N8AlirqZ6LsQvAj4h8bn9yLVhQP8
   FeUhccax5XQQUs9mtH32GD14iLT45MoIYCMwqt3/oodv/+xAxRL5xkWkr
   k79vrM0REv5iMAWwwg9V6+UO858muHdMA3SeSEM0wfXjjEKEjPTmuua+r
   AVPqjqtCkVcxkliicpSl2s6XsPStDXDem8VYt0n1riBNlUhP4rbVODMAj
   A==;
X-CSE-ConnectionGUID: q0Uxl6YUQb6AGtGbXTcHPw==
X-CSE-MsgGUID: 6mG1WueTTcOVm+PmPz9qSg==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="24187347"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="24187347"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 12:31:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="937075029"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="937075029"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Mar 2024 12:31:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id CFD966AF; Wed, 27 Mar 2024 21:31:42 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 7/9] spi: pxa2xx: Move contents of linux/spi/pxa2xx_spi.h to a local one
Date: Wed, 27 Mar 2024 21:29:26 +0200
Message-ID: <20240327193138.2385910-8-andriy.shevchenko@linux.intel.com>
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


