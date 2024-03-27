Return-Path: <linux-kernel+bounces-121910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5AB88EF3F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0555229DF4E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5492A153812;
	Wed, 27 Mar 2024 19:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DWWIWSIw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37F2153509;
	Wed, 27 Mar 2024 19:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711567915; cv=none; b=pQjb2SZ6JesHmBrzwQLnwltd6f35mLoLbdxsLzpDVvt3VD6GtHYSkq06VyURYfDXDrbdx+H3qZsw5wSKaoQr/JIj/bD4pfl/KlJr3pdBlg2hM69E1mNzMJW0jEIGtGbQpfZjNocflmlq6Mllbc8dzD2mS5HwWR6Hg29p7yibawE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711567915; c=relaxed/simple;
	bh=j5gvoDGybQmWLbfFLzUmE6T0bPJCKLuCLg7N7OevHog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jB1BQ/dHINlwmi11hIhLHNZZREwFa0tGFS4fjG03Nn7WZs8C06x9lSMYEBp70JWP0DdYO+1q8xJhflkmdpFqKpGD7jpfYAGjyKcGPbZKPhgZgztkFEQz1Akf6Ksrt7X6V1lktvvDj9325arjrLu8gYHB1JVXppkxfsOHB4Gyw80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DWWIWSIw; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711567913; x=1743103913;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j5gvoDGybQmWLbfFLzUmE6T0bPJCKLuCLg7N7OevHog=;
  b=DWWIWSIwt7n9keJSVSeIKrWnp753znnPj4J6QLjHO/FRaSkuT6eI6+bS
   Y2x/qnZqIlcl5gyCQzqQ5Aat6dKg2uFqSQHtoniFfto/x7QIDPA3x9tx/
   QLMO/ljUCu+kQ9ZMIpj6+/U5nJ3ucqib6BnCDLftKxOInp3W/R/BMfHZv
   W7LFtPdhSENODYj89PElSApxTzXKwhPr3c97iP8P5JfvfWU33mJhdxwfb
   2ohGYEVZ7rB+xpYsYVP96QmMKsCbVfjvtoRjjga85zeHgEw2kbsoTvSSk
   t3BuyWGOe11a1DH2WaUBZe8vV0JL98CZ269zXZEjehqOEsmuBoQl5P/GD
   Q==;
X-CSE-ConnectionGUID: D5LKvjZCTL23mU2M+HjRIA==
X-CSE-MsgGUID: X2iM317xSOul6PKwjZh1Jg==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="24187357"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="24187357"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 12:31:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="937075031"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="937075031"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Mar 2024 12:31:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id EBC4A8D9; Wed, 27 Mar 2024 21:31:42 +0200 (EET)
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
Subject: [PATCH v2 9/9] spi: pxa2xx: Don't use "proxy" headers
Date: Wed, 27 Mar 2024 21:29:28 +0200
Message-ID: <20240327193138.2385910-10-andriy.shevchenko@linux.intel.com>
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


