Return-Path: <linux-kernel+bounces-94218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0CD873B90
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD181F237EC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5310F140370;
	Wed,  6 Mar 2024 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="knfgAfjm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C4913F014;
	Wed,  6 Mar 2024 16:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740888; cv=none; b=HGpjG410fgGIFO1Rj0DQr2RgbpCUyccm2OJyW9hWTcnfIx1i7hnToqrYesk9ni0uaAZ28bqMkzxvvOthJTTdYqZiMehnnZAkVuwq1WqzHv4fDFBHCZz/PjYp4GcGe/4Bh9eZc5wMlVnzAwcE2Ul4XBp16zivNqILzrfvn+2+9RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740888; c=relaxed/simple;
	bh=P2l9CR4aujI1O60I6dNzMO2e/QBRzTm+RhT0rIrrIPk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OK/P81Ge9dJqUlU8572StTqZGk7qQxpkb1Ot/5xVdgXhh6sbAILMalwTzkHv06Kkvx7CjLjQyz6Duz+xNJLxx9onaoSdJpiMXlXb2GAow6N88H8oTadP9QU6TsNe7NtTd+/fKCNIAL23BEhcaImVveldvHzkuAzALlLVxT5H/kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=knfgAfjm; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709740887; x=1741276887;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=P2l9CR4aujI1O60I6dNzMO2e/QBRzTm+RhT0rIrrIPk=;
  b=knfgAfjmwELWSJzOFPU6nLrIx+t03LS2NkKIjuTGO7BBMVGFNuKfcQUW
   jvVcDJXnZZZrVjt45VrCOY5ZQCt4J0xLpyiclAnhoGYYLwt+9bFB4UyHA
   IpPUOn4Era+UBPMkuv08kf1stQesQxa9gg7ckpAuKdXe1cJiTlns6Cno9
   a2e07Cxdez8iMYJ66Eg+iIpvV7jcuzxSQ1WGvVdYUo5wdutYtJiD6tvNm
   5q7tZAK29SXikY4bvJvvPWFFOYVsGKBJHK0K/f2gfg//MIgwnRWaokbUY
   N/P5tk0rCGHJ6TIFAvtVIOKREbnPB+HXwHicAEyn6/+Ui1G3S6Vz+494x
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="15504038"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="15504038"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 08:01:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="937045130"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="937045130"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 06 Mar 2024 08:01:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id EAA003C0; Wed,  6 Mar 2024 18:01:23 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] spi: Exctract spi_set_all_cs_unused() helper
Date: Wed,  6 Mar 2024 17:59:40 +0200
Message-ID: <20240306160114.3471398-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240306160114.3471398-1-andriy.shevchenko@linux.intel.com>
References: <20240306160114.3471398-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems a few functions implement the similar for-loop to mark all
chip select pins unused. Let's deduplicate that code in order to have
a single place of that for better maintenance.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 74 +++++++++++++++--------------------------------
 1 file changed, 24 insertions(+), 50 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ba4d3fde2054..5e530fa790b0 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -745,6 +745,23 @@ int spi_add_device(struct spi_device *spi)
 }
 EXPORT_SYMBOL_GPL(spi_add_device);
 
+static void spi_set_all_cs_unused(struct spi_device *spi)
+{
+	u8 idx;
+
+	/*
+	 * Zero(0) is a valid physical CS value and can be located at any
+	 * logical CS in the spi->chip_select[]. If all the physical CS
+	 * are initialized to 0 then It would be difficult to differentiate
+	 * between a valid physical CS 0 & an unused logical CS whose physical
+	 * CS can be 0. As a solution to this issue initialize all the CS to 0xFF.
+	 * Now all the unused logical CS will have 0xFF physical CS value & can be
+	 * ignore while performing physical CS validity checks.
+	 */
+	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
+		spi_set_chipselect(spi, idx, 0xFF);
+}
+
 /**
  * spi_new_device - instantiate one new SPI device
  * @ctlr: Controller to which device is connected
@@ -764,7 +781,6 @@ struct spi_device *spi_new_device(struct spi_controller *ctlr,
 {
 	struct spi_device	*proxy;
 	int			status;
-	u8                      idx;
 
 	/*
 	 * NOTE:  caller did any chip->bus_num checks necessary.
@@ -780,19 +796,10 @@ struct spi_device *spi_new_device(struct spi_controller *ctlr,
 
 	WARN_ON(strlen(chip->modalias) >= sizeof(proxy->modalias));
 
-	/*
-	 * Zero(0) is a valid physical CS value and can be located at any
-	 * logical CS in the spi->chip_select[]. If all the physical CS
-	 * are initialized to 0 then It would be difficult to differentiate
-	 * between a valid physical CS 0 & an unused logical CS whose physical
-	 * CS can be 0. As a solution to this issue initialize all the CS to 0xFF.
-	 * Now all the unused logical CS will have 0xFF physical CS value & can be
-	 * ignore while performing physical CS validity checks.
-	 */
-	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
-		spi_set_chipselect(proxy, idx, 0xFF);
-
+	/* Use provided chip-select for proxy device */
+	spi_set_all_cs_unused(proxy);
 	spi_set_chipselect(proxy, 0, chip->chip_select);
+
 	proxy->max_speed_hz = chip->max_speed_hz;
 	proxy->mode = chip->mode;
 	proxy->irq = chip->irq;
@@ -2418,17 +2425,7 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		return -EINVAL;
 	}
 
-	/*
-	 * Zero(0) is a valid physical CS value and can be located at any
-	 * logical CS in the spi->chip_select[]. If all the physical CS
-	 * are initialized to 0 then It would be difficult to differentiate
-	 * between a valid physical CS 0 & an unused logical CS whose physical
-	 * CS can be 0. As a solution to this issue initialize all the CS to 0xFF.
-	 * Now all the unused logical CS will have 0xFF physical CS value & can be
-	 * ignore while performing physical CS validity checks.
-	 */
-	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
-		spi_set_chipselect(spi, idx, 0xFF);
+	spi_set_all_cs_unused(spi);
 
 	/* Device address */
 	rc = of_property_read_variable_u32_array(nc, "reg", &cs[0], 1,
@@ -2565,7 +2562,6 @@ struct spi_device *spi_new_ancillary_device(struct spi_device *spi,
 	struct spi_controller *ctlr = spi->controller;
 	struct spi_device *ancillary;
 	int rc = 0;
-	u8 idx;
 
 	/* Alloc an spi_device */
 	ancillary = spi_alloc_device(ctlr);
@@ -2576,19 +2572,8 @@ struct spi_device *spi_new_ancillary_device(struct spi_device *spi,
 
 	strscpy(ancillary->modalias, "dummy", sizeof(ancillary->modalias));
 
-	/*
-	 * Zero(0) is a valid physical CS value and can be located at any
-	 * logical CS in the spi->chip_select[]. If all the physical CS
-	 * are initialized to 0 then It would be difficult to differentiate
-	 * between a valid physical CS 0 & an unused logical CS whose physical
-	 * CS can be 0. As a solution to this issue initialize all the CS to 0xFF.
-	 * Now all the unused logical CS will have 0xFF physical CS value & can be
-	 * ignore while performing physical CS validity checks.
-	 */
-	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
-		spi_set_chipselect(ancillary, idx, 0xFF);
-
 	/* Use provided chip-select for ancillary device */
+	spi_set_all_cs_unused(ancillary);
 	spi_set_chipselect(ancillary, 0, chip_select);
 
 	/* Take over SPI mode/speed from SPI main device */
@@ -2805,7 +2790,6 @@ struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
 	struct acpi_spi_lookup lookup = {};
 	struct spi_device *spi;
 	int ret;
-	u8 idx;
 
 	if (!ctlr && index == -1)
 		return ERR_PTR(-EINVAL);
@@ -2841,24 +2825,14 @@ struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	/*
-	 * Zero(0) is a valid physical CS value and can be located at any
-	 * logical CS in the spi->chip_select[]. If all the physical CS
-	 * are initialized to 0 then It would be difficult to differentiate
-	 * between a valid physical CS 0 & an unused logical CS whose physical
-	 * CS can be 0. As a solution to this issue initialize all the CS to 0xFF.
-	 * Now all the unused logical CS will have 0xFF physical CS value & can be
-	 * ignore while performing physical CS validity checks.
-	 */
-	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
-		spi_set_chipselect(spi, idx, 0xFF);
+	spi_set_all_cs_unused(spi);
+	spi_set_chipselect(spi, 0, lookup.chip_select);
 
 	ACPI_COMPANION_SET(&spi->dev, adev);
 	spi->max_speed_hz	= lookup.max_speed_hz;
 	spi->mode		|= lookup.mode;
 	spi->irq		= lookup.irq;
 	spi->bits_per_word	= lookup.bits_per_word;
-	spi_set_chipselect(spi, 0, lookup.chip_select);
 	/*
 	 * spi->chip_select[i] gives the corresponding physical CS for logical CS i
 	 * logical CS number is represented by setting the ith bit in spi->cs_index_mask
-- 
2.43.0.rc1.1.gbec44491f096


