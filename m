Return-Path: <linux-kernel+bounces-130268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A2E897621
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635A81F2A856
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9D61534F2;
	Wed,  3 Apr 2024 17:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SDAAOw2Q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738A515253C;
	Wed,  3 Apr 2024 17:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164558; cv=none; b=U5Iv3c18Tt13cLHV9EBoPIX2yp+x/A5nBH45goeGVWsAAP1/FKRqz4R+AmuVLik9nIUFIrCBm/9cQZhlNBDx76w5/78XiRMRcSOtDc1qpmchaBEJxWwmky5G2s5g5vbNhg0ILGUAy95Jixz3eobOWkHvU1nHsbm5ciclH+CC3sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164558; c=relaxed/simple;
	bh=QAzx1E0qxAXDPG02iR8YPBeHMYqiPk9cu41jsTna2jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dirdWXerbtEx2GOnucsNxjln3m0oW+YpxlghwDBI68g9vSvEqc5lK1XCHu7dLyt3sO7Hi6QoibZxirx9yGlS67hwmyxPK28BaGVIjCTcrqG6QTZ0HiBRrc1XCQlTgW8FwCxtS0p4u0OKPNvGH1oOcpdUgfpuQgHsbk6q7mGv3nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SDAAOw2Q; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712164558; x=1743700558;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QAzx1E0qxAXDPG02iR8YPBeHMYqiPk9cu41jsTna2jo=;
  b=SDAAOw2QamXNc/6LU5lbUbWv8EIqbKRtyjwuMdkqYiihoCwAvvlS3MEd
   r3YVR+Yz/8Yc2xN4g2EKqXpL47txGpn0qim1eSP6ilQ5NqTpGd8NB5bFu
   iXAtrIuyLQnf2oKXrKevbp3OSx38L3/8JhyxSC15+V2yZmWre14AAGYya
   HRVenAIqiIIvH3596T76s07r+UGx0lrZOAnPnUTwrffUhhHRE8SMU4m41
   wG10UWqGL4YGbP7ZaeZNPkf/aZkrFakKjh/68Ny8uHvJDP+BfX+5DK/x+
   +7rLCDcLsG/eT5AprnmkwRZvfqoc4/Su8BwUnwBQciIbpDaKY7NbvtAqw
   g==;
X-CSE-ConnectionGUID: yuc1hlB/TIGqew0/HUF1/Q==
X-CSE-MsgGUID: Hc18hjsmRJquoCW/EaW+pw==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18863544"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18863544"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 10:15:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="937085337"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="937085337"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Apr 2024 10:15:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A8DAB57D; Wed,  3 Apr 2024 20:15:53 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 2/5] spi: pxa2xx: Drop struct pxa2xx_spi_chip
Date: Wed,  3 Apr 2024 20:06:36 +0300
Message-ID: <20240403171550.1074644-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240403171550.1074644-1-andriy.shevchenko@linux.intel.com>
References: <20240403171550.1074644-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No more users.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx-dma.c |  9 ++-------
 drivers/spi/spi-pxa2xx.c     | 25 -------------------------
 drivers/spi/spi-pxa2xx.h     | 14 --------------
 3 files changed, 2 insertions(+), 46 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
index 751cb0f77b62..d77279c3acd8 100644
--- a/drivers/spi/spi-pxa2xx-dma.c
+++ b/drivers/spi/spi-pxa2xx-dma.c
@@ -231,16 +231,11 @@ int pxa2xx_spi_set_dma_burst_and_threshold(struct chip_data *chip,
 					   u8 bits_per_word, u32 *burst_code,
 					   u32 *threshold)
 {
-	struct pxa2xx_spi_chip *chip_info = spi->controller_data;
 	struct driver_data *drv_data = spi_controller_get_devdata(spi->controller);
 	u32 dma_burst_size = drv_data->controller_info->dma_burst_size;
 
-	/*
-	 * If the DMA burst size is given in chip_info we use that,
-	 * otherwise we use the default. Also we use the default FIFO
-	 * thresholds for now.
-	 */
-	*burst_code = chip_info ? chip_info->dma_burst_size : dma_burst_size;
+	/* We use the default the DMA burst size and FIFO thresholds for now */
+	*burst_code = dma_burst_size;
 	*threshold = SSCR1_RxTresh(RX_THRESH_DFLT)
 		   | SSCR1_TxTresh(TX_THRESH_DFLT);
 
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index cc0e54f8d2c3..00aa33c937bf 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1154,7 +1154,6 @@ static int pxa2xx_spi_unprepare_transfer(struct spi_controller *controller)
 
 static int setup(struct spi_device *spi)
 {
-	struct pxa2xx_spi_chip *chip_info;
 	struct chip_data *chip;
 	const struct lpss_config *config;
 	struct driver_data *drv_data =
@@ -1218,25 +1217,6 @@ static int setup(struct spi_device *spi)
 		chip->timeout = TIMOUT_DFLT;
 	}
 
-	/*
-	 * Protocol drivers may change the chip settings, so...
-	 * if chip_info exists, use it.
-	 */
-	chip_info = spi->controller_data;
-
-	/* chip_info isn't always needed */
-	if (chip_info) {
-		if (chip_info->timeout)
-			chip->timeout = chip_info->timeout;
-		if (chip_info->tx_threshold)
-			tx_thres = chip_info->tx_threshold;
-		if (chip_info->tx_hi_threshold)
-			tx_hi_thres = chip_info->tx_hi_threshold;
-		if (chip_info->rx_threshold)
-			rx_thres = chip_info->rx_threshold;
-		chip->dma_threshold = 0;
-	}
-
 	chip->cr1 = 0;
 	if (spi_controller_is_target(drv_data->controller)) {
 		chip->cr1 |= SSCR1_SCFR;
@@ -1256,11 +1236,6 @@ static int setup(struct spi_device *spi)
 		chip->lpss_tx_threshold = tx_thres;
 	}
 
-	/*
-	 * Set DMA burst and threshold outside of chip_info path so that if
-	 * chip_info goes away after setting chip->enable_dma, the burst and
-	 * threshold can still respond to changes in bits_per_word.
-	 */
 	if (chip->enable_dma) {
 		/* Set up legal burst and threshold for DMA */
 		if (pxa2xx_spi_set_dma_burst_and_threshold(chip, spi,
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index f1097c96c50f..ae9c99bc9f6c 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -35,20 +35,6 @@ struct pxa2xx_spi_controller {
 	struct ssp_device ssp;
 };
 
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
 struct spi_controller;
 struct spi_device;
 struct spi_transfer;
-- 
2.43.0.rc1.1.gbec44491f096


