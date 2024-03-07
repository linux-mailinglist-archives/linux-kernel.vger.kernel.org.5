Return-Path: <linux-kernel+bounces-95835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEC68753AE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34649B238C8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC73512F39F;
	Thu,  7 Mar 2024 15:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U58py4lD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1215312B15D;
	Thu,  7 Mar 2024 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709826671; cv=none; b=Epx1gRY03aABhNp+lOn5npp0QdX2aag3WTF6jFeF9UJxh4hXW9zBhTB1oZ7+OB1aYgzdEMzuxvlh1axyeKeiPOM6UlEL5PnN0P24AnJDM6hZUFimJCAD1Vaklx/BkHXd35J4/0JtRoBFCHsYIJPYK7JEWhGlI7I5uuWm/YAzdbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709826671; c=relaxed/simple;
	bh=IT42IOBMcG/xz5FeeeVmVDpApDqL4Ukl/vX42G/6Eb4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EN2NYAf4iJtq1kdI/bljffCnVrtDRB8kWmvn5V462q+vp9fl0fUKTVy3y+ukSQpM03TaYQmIWRLA2zSqP0rmngBV2oe2p+GulMpwai0HM+O88DmPFU1nwtLQIu68ewwZNEQh29hFmVGlS4eRK6yJVdt0I2ask+d5vptZ4YMLD9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U58py4lD; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709826669; x=1741362669;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IT42IOBMcG/xz5FeeeVmVDpApDqL4Ukl/vX42G/6Eb4=;
  b=U58py4lDrOKB3y15g8HChKsS7shuNYlm6YwJFGEria4fvYRqUNMFzjJ+
   DiH1K9HMSgLy/gFlhjA271z8L8eHAvuJrWZ2U5UL72SNws1zHbm3poTM4
   eZdy2gb10zkvRFWFEj+1Ax5DX5FHqRW4/mE3XeMVr0W9mh3nJQBp78qvV
   ooXXDz+eYparZbQiBKF1tR2K6o2ziuoXGBxjRUdgvBtlA7oAPvYvbVB51
   eZX5iuFM0ERZDl2+uckyqBvwf18gyrvRaWMjH1lvRJPcA+BWef0EBMn7B
   ITfQCiExw/l0T8H4VmoDYFlNKxOR5wA/ZVFHXmy0fFT99K+aCvUMQoubH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15222819"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="15222819"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 07:50:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="937046337"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="937046337"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 07:50:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 15D0A3C0; Thu,  7 Mar 2024 17:50:48 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v1 1/1] spi: rspi: Get rid of unused struct rspi_plat_data
Date: Thu,  7 Mar 2024 17:50:45 +0200
Message-ID: <20240307155045.3796045-1-andriy.shevchenko@linux.intel.com>
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
 drivers/spi/spi-rspi.c   | 11 +----------
 include/linux/spi/rspi.h | 18 ------------------
 2 files changed, 1 insertion(+), 28 deletions(-)
 delete mode 100644 include/linux/spi/rspi.h

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 8e81f1a8623f..54f61580c579 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1131,16 +1131,12 @@ static struct dma_chan *rspi_request_dma_chan(struct device *dev,
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
@@ -1290,7 +1286,6 @@ static int rspi_probe(struct platform_device *pdev)
 	struct spi_controller *ctlr;
 	struct rspi_data *rspi;
 	int ret;
-	const struct rspi_plat_data *rspi_pd;
 	const struct spi_ops *ops;
 	unsigned long clksrc;
 
@@ -1305,11 +1300,7 @@ static int rspi_probe(struct platform_device *pdev)
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


