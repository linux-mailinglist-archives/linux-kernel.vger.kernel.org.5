Return-Path: <linux-kernel+bounces-95791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A868752B3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF5D6B2871C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3FE12F38C;
	Thu,  7 Mar 2024 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QUg5kOZn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9AE12E1DF;
	Thu,  7 Mar 2024 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709823784; cv=none; b=HaE7wTT09WF7UZEg8hpTQWHG6KE+Zl0W/rqrxrZnt5JIyeR9bmxQ5Ua6r00+OHOAoMv/BQf6fwH5qU+GV5T2iCFc/CSoqNKT7SbFD5Npiye5YROiqHb7EuwOvIXfoNCqGPMWye/3/WW3KzCOKIsq6Q+gNzY3eyFuRyT1xYW4CvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709823784; c=relaxed/simple;
	bh=P9YTbKPgpDAvqkYJxWhzj7konCfTC4G8/afKB0W4bt4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8SfHN5bxvJmaYBwbJc10oqtbyGOdsUbhnHXqb7HSAxPl6b9jcjfMC8cGnlOUE2qKY3UfNf5c64XCaG4ly7a7nlbuVH4PaYz6aPKZs/LCldox6rQSNGfnHGHDRpiR0UKtSkL1TNXTa00fADYlPQPJ+bAqs2JNBvZX2oYaurAJ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QUg5kOZn; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709823783; x=1741359783;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=P9YTbKPgpDAvqkYJxWhzj7konCfTC4G8/afKB0W4bt4=;
  b=QUg5kOZn4/el6wGSEmQ0XHq6dKvfahT2yCjEQzlKpuGHzHLgGdirYp3q
   q3qoBzIpCrdmCvdB9T9T+Cv3+9Z6p3ikWjIypLHAHTIMl0qO3ChdomASq
   ATNAFYUWh65ezgIr0xp0PWd6Atf+u1QsGai706j8NccdE/f5s+6NeoAVE
   aALcP6uBIrNH0eHfHrF7PlOQfx2hrhFKH4Nrju89cAU4v4pQvsF9g7Ph7
   Cf9ApmLCT5BLWo3A+Pbo2WOhdvzytulfY/K80wbSsBYev2Sm7QbJhU9fz
   gfFjl8MxN3rRCNnUM1crUKF5BfbJ41cTG5BHYshE2AqjQfOFogUDnSJ/I
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4351048"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="4351048"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 07:03:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="937046326"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="937046326"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 07:02:59 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 189B3193; Thu,  7 Mar 2024 17:02:58 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] spi: Consistently use BIT for cs_index_mask
Date: Thu,  7 Mar 2024 17:00:59 +0200
Message-ID: <20240307150256.3789138-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240307150256.3789138-1-andriy.shevchenko@linux.intel.com>
References: <20240307150256.3789138-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the parts related to the chip select are using BIT() macro
the rest are using plain numbers. Unify all of them to use BIT().

While at it, make the (repetitive) comment clearer when assigning
cs_index_mask during SPI target device enumeration.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 35 +++++++++++------------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index eb7e3ddf909b..4ab155f698c8 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1021,7 +1021,7 @@ static inline bool spi_is_last_cs(struct spi_device *spi)
 	bool last = false;
 
 	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
-		if ((spi->cs_index_mask >> idx) & 0x01) {
+		if (spi->cs_index_mask & BIT(idx)) {
 			if (spi->controller->last_cs[idx] == spi_get_chipselect(spi, idx))
 				last = true;
 		}
@@ -1072,8 +1072,7 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 			 * into account.
 			 */
 			for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
-				if (((spi->cs_index_mask >> idx) & 0x01) &&
-				    spi_get_csgpiod(spi, idx)) {
+				if ((spi->cs_index_mask & BIT(idx)) && spi_get_csgpiod(spi, idx)) {
 					if (has_acpi_companion(&spi->dev))
 						gpiod_set_value_cansleep(spi_get_csgpiod(spi, idx),
 									 !enable);
@@ -2456,14 +2455,10 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		spi_set_chipselect(spi, idx, cs[idx]);
 
 	/*
-	 * spi->chip_select[i] gives the corresponding physical CS for logical CS i
-	 * logical CS number is represented by setting the ith bit in spi->cs_index_mask
-	 * So, for example, if spi->cs_index_mask = 0x01 then logical CS number is 0 and
-	 * spi->chip_select[0] will give the physical CS.
-	 * By default spi->chip_select[0] will hold the physical CS number so, set
-	 * spi->cs_index_mask as 0x01.
+	 * By default spi->chip_select[0] will hold the physical CS number,
+	 * so set bit 0 in spi->cs_index_mask.
 	 */
-	spi->cs_index_mask = 0x01;
+	spi->cs_index_mask = BIT(0);
 
 	/* Device speed */
 	if (!of_property_read_u32(nc, "spi-max-frequency", &value))
@@ -2587,14 +2582,10 @@ struct spi_device *spi_new_ancillary_device(struct spi_device *spi,
 	ancillary->max_speed_hz = spi->max_speed_hz;
 	ancillary->mode = spi->mode;
 	/*
-	 * spi->chip_select[i] gives the corresponding physical CS for logical CS i
-	 * logical CS number is represented by setting the ith bit in spi->cs_index_mask
-	 * So, for example, if spi->cs_index_mask = 0x01 then logical CS number is 0 and
-	 * spi->chip_select[0] will give the physical CS.
-	 * By default spi->chip_select[0] will hold the physical CS number so, set
-	 * spi->cs_index_mask as 0x01.
+	 * By default spi->chip_select[0] will hold the physical CS number,
+	 * so set bit 0 in spi->cs_index_mask.
 	 */
-	ancillary->cs_index_mask = 0x01;
+	ancillary->cs_index_mask = BIT(0);
 
 	WARN_ON(!mutex_is_locked(&ctlr->add_lock));
 
@@ -2841,14 +2832,10 @@ struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
 	spi->irq		= lookup.irq;
 	spi->bits_per_word	= lookup.bits_per_word;
 	/*
-	 * spi->chip_select[i] gives the corresponding physical CS for logical CS i
-	 * logical CS number is represented by setting the ith bit in spi->cs_index_mask
-	 * So, for example, if spi->cs_index_mask = 0x01 then logical CS number is 0 and
-	 * spi->chip_select[0] will give the physical CS.
-	 * By default spi->chip_select[0] will hold the physical CS number so, set
-	 * spi->cs_index_mask as 0x01.
+	 * By default spi->chip_select[0] will hold the physical CS number,
+	 * so set bit 0 in spi->cs_index_mask.
 	 */
-	spi->cs_index_mask	= 0x01;
+	spi->cs_index_mask	= BIT(0);
 
 	return spi;
 }
-- 
2.43.0.rc1.1.gbec44491f096


