Return-Path: <linux-kernel+bounces-148371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1388A819D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D4961C22A69
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1455213E3F4;
	Wed, 17 Apr 2024 11:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OOh3VPBG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F065313CFB1;
	Wed, 17 Apr 2024 11:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713351832; cv=none; b=opAx4rHjd1Xu4uc4baIfG20bLFXvBpSp6TFaPrFRUu2s/3k7FIyDw1gh0Cn0cLzG5WsTpbaNxtzi2n4PkOMJRHRBQ47kGwfyhhNg6gjB4a/kDdYkTfANMcggALCy8278lors2flxBrRoINAqgxusSPQ0JzrPSUu7IVQF+rUOO0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713351832; c=relaxed/simple;
	bh=fTowosBJawg2jktG1ze451cVnqPzvsaV6zeLVnumwuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fHCvJeH4uqM1RDsxao8/25EcbAsndmyJrgthKzF5Hs/Jxh0Rzi72DzikT7T/DwYDmkwIkutnzbrvsUU/LNTKxl9Wbd2QaMvactGZPqRlYaB9GKLk8fmiuUnrHFCIWYzOKXIoQVo8VcorJ8gWkJ7DYnOpjIaPNOvsjYekMbjChw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OOh3VPBG; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713351829; x=1744887829;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fTowosBJawg2jktG1ze451cVnqPzvsaV6zeLVnumwuA=;
  b=OOh3VPBGlDCbF2REGLlSMNjLPdtmALVUnByowv5WNbKfjI11z1tbgcfR
   Jjk6+iJgU3Qyn4cNhF0PuN+umt++jgoVhwqj6Xmna70sSZoYhiZLRzrtn
   EOue2MD+CgLWM+wphGFCWWSaxFus75lvebzcetylpsVtsZrphwkxh7TF3
   z1OMsbiICqVwqpexb2/PdXp9hdW1Wf595PGGSo9Q06TGeS9BF2ByNylsm
   KTtU/Exg0PmHCxeot+i5P5AH+u7I41X4bnrDDpFHeKGTaXY7QZU70zdMj
   w9OPyck67wif5TL8UVRsw+4TaA1VNa3RSQIanM5igfTsbs/L0Bwq56S/5
   g==;
X-CSE-ConnectionGUID: Y72OuRhxQ3WPgMwVbpRhhA==
X-CSE-MsgGUID: mL5UuXUKShmo6Nj0jUyrWw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8698171"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="8698171"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 04:03:43 -0700
X-CSE-ConnectionGUID: WpLsJvJ1SNiayBxDZVMrRw==
X-CSE-MsgGUID: n7HqInwdROGiMLC6JgpESw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="22653280"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 17 Apr 2024 04:03:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9232D134D; Wed, 17 Apr 2024 14:03:36 +0300 (EEST)
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
Subject: [PATCH v3 5/9] spi: pxa2xx: Don't use "proxy" headers
Date: Wed, 17 Apr 2024 13:54:32 +0300
Message-ID: <20240417110334.2671228-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240417110334.2671228-1-andriy.shevchenko@linux.intel.com>
References: <20240417110334.2671228-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update header inclusions to follow IWYU (Include What You Use)
principle.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx-dma.c | 10 ++++++++--
 drivers/spi/spi-pxa2xx-pci.c |  6 ++++++
 drivers/spi/spi-pxa2xx.c     | 10 +++++++---
 drivers/spi/spi-pxa2xx.h     |  3 +--
 4 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
index 26416ced6505..751cb0f77b62 100644
--- a/drivers/spi/spi-pxa2xx-dma.c
+++ b/drivers/spi/spi-pxa2xx-dma.c
@@ -6,16 +6,22 @@
  * Author: Mika Westerberg <mika.westerberg@linux.intel.com>
  */
 
-#include <linux/device.h>
+#include <linux/atomic.h>
+#include <linux/dev_printk.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
+#include <linux/errno.h>
+#include <linux/irqreturn.h>
 #include <linux/scatterlist.h>
-#include <linux/sizes.h>
+#include <linux/string.h>
+#include <linux/types.h>
 
 #include <linux/spi/spi.h>
 
 #include "spi-pxa2xx.h"
 
+struct device;
+
 static void pxa2xx_spi_dma_transfer_complete(struct driver_data *drv_data,
 					     bool error)
 {
diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index e11a613bc340..6d2efdb0e95f 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -6,9 +6,15 @@
  * Copyright (C) 2016, 2021 Intel Corporation
  */
 #include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/err.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/sprintf.h>
+#include <linux/string.h>
+#include <linux/types.h>
 
 #include <linux/dmaengine.h>
 #include <linux/platform_data/dma-dw.h>
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 82633682b581..cc0e54f8d2c3 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -5,24 +5,28 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/atomic.h>
 #include <linux/bitops.h>
+#include <linux/bug.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/dmaengine.h>
 #include <linux/err.h>
-#include <linux/errno.h>
 #include <linux/gpio/consumer.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/ioport.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/math64.h>
+#include <linux/minmax.h>
 #include <linux/mod_devicetable.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/slab.h>
+#include <linux/types.h>
 
 #include <linux/spi/spi.h>
 
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 08296729ea80..f1097c96c50f 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -8,8 +8,7 @@
 #define SPI_PXA2XX_H
 
 #include <linux/dmaengine.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
+#include <linux/irqreturn.h>
 #include <linux/types.h>
 #include <linux/sizes.h>
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


