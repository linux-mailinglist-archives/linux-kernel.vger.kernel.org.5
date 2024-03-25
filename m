Return-Path: <linux-kernel+bounces-117240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E7C88A901
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8D7C1F66D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC00412FB35;
	Mon, 25 Mar 2024 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KFfeCClY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ADE84FD8;
	Mon, 25 Mar 2024 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711376484; cv=none; b=oP7wb1BNrnaKAWnWs6tMgTkx7gkstM9bWUo8aZMAKJXMXw9JVVjSOLn1kxE7uw+GNWnMTbo01NSBJUUUfGirB6BRNEZ0Vi2Z7QNE+CY9qSSS1a/G5d3ALYIHs8M2xzdZZcrecm7IsAgQpwWnLzjF5sF19ppNtEgHYvCHCAbH20c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711376484; c=relaxed/simple;
	bh=zO/SdrfhF6UzSZrQoEGUuyMdVnlo03Kah+CLPwIYCrw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Y3o334FF1vtAXS/sqMh8ReMfKT61il375JBXXScmMXAUg44s5Un9R2gK+jgabmFIcVfKsAgFj6AFc5cRj9rWLCAHWu6S/GI2ODm3HhFDRBvSSrWDYR3PppcYRozd2Q1JsJEWmGVGN08nCflYFGDSxaeBTA4S4yZb9G+DX1GtF3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KFfeCClY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711376482; x=1742912482;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zO/SdrfhF6UzSZrQoEGUuyMdVnlo03Kah+CLPwIYCrw=;
  b=KFfeCClY4cllCbsPNoA/ViAXc54hJbixiiaX1rOjopN4H2EkG69lP/P/
   X4KtcnpCAsmsTmJe8JolX+5eavNqeNADAAIFHQLVDoJKg8aJA9b0QrZYb
   vKV/DtsS7i3OOQetNZ2sZGO4k4SGevs65XRHS1dQsdiQWHT0aUpahs9i7
   sWJM/iyxn6OkgO4cD7Lp9jkGD6Y6wuABC4TjaMTBtx4HxctVNPFtKJOYv
   dbrArNlu19rx6IW4L+6UfwCJeSlUgocx4dvg280BblzHAAtJpwk4ow3lZ
   WlSWaF8igPsRLYICGuEbOxy5Cy1WUgslA6DhUdX9F6SgbcFT9kkcqGvf2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6210318"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="6210318"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 07:21:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="937070498"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="937070498"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2024 07:21:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2BA37101; Mon, 25 Mar 2024 16:21:19 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v2 1/1] spi: rspi: Get rid of unused struct rspi_plat_data
Date: Mon, 25 Mar 2024 16:20:04 +0200
Message-ID: <20240325142118.3210915-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No in-kernel users of struct rspi_plat_data. If required,
the software nodes should be used for such users. For now
just get rid of it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: fixed compilation error (Mark)
 drivers/spi/spi-rspi.c   | 12 +-----------
 include/linux/spi/rspi.h | 18 ------------------
 2 files changed, 1 insertion(+), 29 deletions(-)
 delete mode 100644 include/linux/spi/rspi.h

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 8e81f1a8623f..7f95d22fb1ac 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -24,7 +24,6 @@
 #include <linux/reset.h>
 #include <linux/sh_dma.h>
 #include <linux/spi/spi.h>
-#include <linux/spi/rspi.h>
 #include <linux/spinlock.h>
 
 #define RSPI_SPCR		0x00	/* Control Register */
@@ -1131,16 +1130,12 @@ static struct dma_chan *rspi_request_dma_chan(struct device *dev,
 static int rspi_request_dma(struct device *dev, struct spi_controller *ctlr,
 			    const struct resource *res)
 {
-	const struct rspi_plat_data *rspi_pd = dev_get_platdata(dev);
 	unsigned int dma_tx_id, dma_rx_id;
 
 	if (dev->of_node) {
 		/* In the OF case we will get the slave IDs from the DT */
 		dma_tx_id = 0;
 		dma_rx_id = 0;
-	} else if (rspi_pd && rspi_pd->dma_tx_id && rspi_pd->dma_rx_id) {
-		dma_tx_id = rspi_pd->dma_tx_id;
-		dma_rx_id = rspi_pd->dma_rx_id;
 	} else {
 		/* The driver assumes no error. */
 		return 0;
@@ -1290,7 +1285,6 @@ static int rspi_probe(struct platform_device *pdev)
 	struct spi_controller *ctlr;
 	struct rspi_data *rspi;
 	int ret;
-	const struct rspi_plat_data *rspi_pd;
 	const struct spi_ops *ops;
 	unsigned long clksrc;
 
@@ -1305,11 +1299,7 @@ static int rspi_probe(struct platform_device *pdev)
 			goto error1;
 	} else {
 		ops = (struct spi_ops *)pdev->id_entry->driver_data;
-		rspi_pd = dev_get_platdata(&pdev->dev);
-		if (rspi_pd && rspi_pd->num_chipselect)
-			ctlr->num_chipselect = rspi_pd->num_chipselect;
-		else
-			ctlr->num_chipselect = 2; /* default */
+		ctlr->num_chipselect = 2; /* default */
 	}
 
 	rspi = spi_controller_get_devdata(ctlr);
diff --git a/include/linux/spi/rspi.h b/include/linux/spi/rspi.h
deleted file mode 100644
index dbdfcc7a3db2..000000000000
--- a/include/linux/spi/rspi.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Renesas SPI driver
- *
- * Copyright (C) 2012  Renesas Solutions Corp.
- */
-
-#ifndef __LINUX_SPI_RENESAS_SPI_H__
-#define __LINUX_SPI_RENESAS_SPI_H__
-
-struct rspi_plat_data {
-	unsigned int dma_tx_id;
-	unsigned int dma_rx_id;
-
-	u16 num_chipselect;
-};
-
-#endif
-- 
2.43.0.rc1.1.gbec44491f096


