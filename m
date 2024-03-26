Return-Path: <linux-kernel+bounces-119665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6669888CBB8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB416327868
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BCD84D3C;
	Tue, 26 Mar 2024 18:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V81tnPsn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AB9129A99;
	Tue, 26 Mar 2024 18:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476646; cv=none; b=Kg49Q2Icl+YVuYqcUfnVHhvueeyoUn74XsNkKjnZdEkAciBTQeoslyskXywpuRm3XodW7md7k3n3viaZ8qbQD91fmUH7KHA3rOlEVAsuDgqdLGQ/k+4vV18NYDFiEYgMnyMSavVWffs01zL9m0pIkQAcfilbQiTqDBLgW1EOoys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476646; c=relaxed/simple;
	bh=j5gvoDGybQmWLbfFLzUmE6T0bPJCKLuCLg7N7OevHog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bDxuDaiMNQrXJUk1IL8fGcBzfQBus6zBNvG0xXQ3p6/OF7zIU2JnkUrI68d4CsZNdo1zhHeERkuW4YxevxjrUeQc2DAp3DKxbMJd4puWxW3OgGbpW5CNtddA4KCR3o7/HMa6KfIDT6TZ50E+D3cTMLbU5qu3OChTbFm0afgHi4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V81tnPsn; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711476645; x=1743012645;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j5gvoDGybQmWLbfFLzUmE6T0bPJCKLuCLg7N7OevHog=;
  b=V81tnPsnWsBYKM5V6stk5ohMtCsKSmk/ze72ZMGZxkSd64xFiLFIuFe4
   Awa/eQh1lEriIo/TuG5meuKmGprsRaSxdhvlqLuWECg4w5TdUveDmCbmI
   84KHxmUGCBMXfts3bxn6uIRdfUjkZ5Z5Q++1dpPHyHGOhB1fgBeNwGzPf
   dNDYkdyHlUfknPAuYF9yDGGCrZ2droBQ7r4rXnYnPp4V0ng74rTNRp6FE
   ZWT5Bf+L3S49fIAZRgAdwiKSYzTlvueJc8YJy/2R0Iz9sIP4XxcbpJxRY
   LrKLjFeXjffyE0TMz4So0yiqNjzFLswtGfJl1WfTxXHwuN5V7iaz6n0B2
   g==;
X-CSE-ConnectionGUID: rvZaIYPPRp2SbnpFsnBjBQ==
X-CSE-MsgGUID: TFJ+b62nQgeOOLQKd8rPHg==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="10325726"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="10325726"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 11:10:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="937072944"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="937072944"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Mar 2024 11:10:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 49E4EF06; Tue, 26 Mar 2024 20:10:35 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH v1 10/10] spi: pxa2xx: Don't use "proxy" headers
Date: Tue, 26 Mar 2024 20:08:00 +0200
Message-ID: <20240326181027.1418989-11-andriy.shevchenko@linux.intel.com>
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
index e22d9d29c7e9..86d0f1064a45 100644
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
2.43.0.rc1.1.gbec44491f096


