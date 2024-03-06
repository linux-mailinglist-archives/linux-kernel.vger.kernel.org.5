Return-Path: <linux-kernel+bounces-94220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB49873B93
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 168E028A318
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85A1140E3C;
	Wed,  6 Mar 2024 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cyVfXuFz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E2C13F44D;
	Wed,  6 Mar 2024 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740889; cv=none; b=NB+4NzUMKioz79OC0JaV2btXJrJd+HKFLlQsHObRDQ312/qRQ23yBjX61ENvR898LctE6uMh101OIil2um55+73Rw7BWPLvDI1YVM/T0ayWrV+QhDu3FjZX6Rb9orrO9rq81AIm76GmsNamG43ve7pjdpqJLpeWQY93+QHlRmIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740889; c=relaxed/simple;
	bh=2P5SJN0mZupkQUYJMPK1FJ8A0y8TZeDvivA+SQJ6m7M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIqYDld+8x1I/QJEbN78tBT9nDdlDtB/zaPgJXLNvHB2gX34I55OvQIkNvtWtgR0ybhK8craZRAXl34WQxQ5WtBOsujQyN5fU0ui1XIp93C4qXexXiLrBTnbv94HunQ2B16n586poa7vQQUuvaS5xdd1OhDOaSLN1O2esWESqT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cyVfXuFz; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709740888; x=1741276888;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=2P5SJN0mZupkQUYJMPK1FJ8A0y8TZeDvivA+SQJ6m7M=;
  b=cyVfXuFzZLJuOZXDxjRN0ni+ABVzu3Zy3f69kAgEjKSb/mxj50hdfL80
   0expzLn/8CxKpXhHHGtDPjR8PEsag+VT27Z6y6yYWFLnBGWse4AvoqI6L
   Sz/RwstgjuHnIx1xhKMkeK+Foa6c+/tJROxd8fUpP7DMdRZFGpY8a7dLH
   zp7ITFF+g5Wglnm+ss7LKnMR2GyY15Fara6aeHHa6db9Jk0dl0vwOVGo9
   r/rXaDqEgUzsqH3ek4rxv2j6Q1mLxch7uyQbC1ilnOanLo2CnVdiW+NK/
   ioouy+AQNDnYV5elQxUWuyZDMGRdczYLP6R+unoEupMMLqU7/OVhY+dXT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="15504050"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="15504050"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 08:01:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="937045132"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="937045132"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 06 Mar 2024 08:01:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 25F10184; Wed,  6 Mar 2024 18:01:25 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] spi: Fix multiple issues with Chip Select variables and comments
Date: Wed,  6 Mar 2024 17:59:42 +0200
Message-ID: <20240306160114.3471398-4-andriy.shevchenko@linux.intel.com>
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

There are the following issues with the current code:
- inconsistent use of 0xFF and -1 for invalid chip select pin
- inconsistent plain or BIT() use
- wrong types used for last_cs_* fields
- wrong multi-line comment style
- misleading or hard-to-understand comments

Fix all of these here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c       | 74 +++++++++++++++++++----------------------
 include/linux/spi/spi.h | 15 +++++----
 2 files changed, 42 insertions(+), 47 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index eb7e3ddf909b..f18738ae95f8 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -608,6 +608,22 @@ static void spi_dev_set_name(struct spi_device *spi)
 		     spi_get_chipselect(spi, 0));
 }
 
+/*
+ * Zero(0) is a valid physical CS value and can be located at any
+ * logical CS in the spi->chip_select[]. If all the physical CS
+ * are initialized to 0 then It would be difficult to differentiate
+ * between a valid physical CS 0 & an unused logical CS whose physical
+ * CS can be 0. As a solution to this issue initialize all the CS to -1.
+ * Now all the unused logical CS will have -1 physical CS value & can be
+ * ignored while performing physical CS validity checks.
+ */
+#define SPI_INVALID_CS		((s8)-1)
+
+static inline bool is_valid_cs(s8 chip_select)
+{
+	return chip_select != SPI_INVALID_CS;
+}
+
 static inline int spi_dev_check_cs(struct device *dev,
 				   struct spi_device *spi, u8 idx,
 				   struct spi_device *new_spi, u8 new_idx)
@@ -618,7 +634,7 @@ static inline int spi_dev_check_cs(struct device *dev,
 	cs = spi_get_chipselect(spi, idx);
 	for (idx_new = new_idx; idx_new < SPI_CS_CNT_MAX; idx_new++) {
 		cs_new = spi_get_chipselect(new_spi, idx_new);
-		if (cs != 0xFF && cs_new != 0xFF && cs == cs_new) {
+		if (is_valid_cs(cs) && is_valid_cs(cs_new) && cs == cs_new) {
 			dev_err(dev, "chipselect %u already in use\n", cs_new);
 			return -EBUSY;
 		}
@@ -658,7 +674,7 @@ static int __spi_add_device(struct spi_device *spi)
 	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
 		/* Chipselects are numbered 0..max; validate. */
 		cs = spi_get_chipselect(spi, idx);
-		if (cs != 0xFF && cs >= ctlr->num_chipselect) {
+		if (is_valid_cs(cs) && cs >= ctlr->num_chipselect) {
 			dev_err(dev, "cs%d >= max %d\n", spi_get_chipselect(spi, idx),
 				ctlr->num_chipselect);
 			return -EINVAL;
@@ -698,7 +714,7 @@ static int __spi_add_device(struct spi_device *spi)
 
 		for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
 			cs = spi_get_chipselect(spi, idx);
-			if (cs != 0xFF)
+			if (is_valid_cs(cs))
 				spi_set_csgpiod(spi, idx, ctlr->cs_gpiods[cs]);
 		}
 	}
@@ -756,17 +772,8 @@ static void spi_set_all_cs_unused(struct spi_device *spi)
 {
 	u8 idx;
 
-	/*
-	 * Zero(0) is a valid physical CS value and can be located at any
-	 * logical CS in the spi->chip_select[]. If all the physical CS
-	 * are initialized to 0 then It would be difficult to differentiate
-	 * between a valid physical CS 0 & an unused logical CS whose physical
-	 * CS can be 0. As a solution to this issue initialize all the CS to 0xFF.
-	 * Now all the unused logical CS will have 0xFF physical CS value & can be
-	 * ignore while performing physical CS validity checks.
-	 */
 	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
-		spi_set_chipselect(spi, idx, 0xFF);
+		spi_set_chipselect(spi, idx, SPI_INVALID_CS);
 }
 
 /**
@@ -1021,7 +1028,7 @@ static inline bool spi_is_last_cs(struct spi_device *spi)
 	bool last = false;
 
 	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
-		if ((spi->cs_index_mask >> idx) & 0x01) {
+		if (spi->cs_index_mask & BIT(idx)) {
 			if (spi->controller->last_cs[idx] == spi_get_chipselect(spi, idx))
 				last = true;
 		}
@@ -1050,7 +1057,7 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 
 	spi->controller->last_cs_index_mask = spi->cs_index_mask;
 	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
-		spi->controller->last_cs[idx] = enable ? spi_get_chipselect(spi, 0) : -1;
+		spi->controller->last_cs[idx] = enable ? spi_get_chipselect(spi, 0) : SPI_INVALID_CS;
 	spi->controller->last_cs_mode_high = spi->mode & SPI_CS_HIGH;
 
 	if (spi->mode & SPI_CS_HIGH)
@@ -1072,8 +1079,7 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 			 * into account.
 			 */
 			for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
-				if (((spi->cs_index_mask >> idx) & 0x01) &&
-				    spi_get_csgpiod(spi, idx)) {
+				if ((spi->cs_index_mask & BIT(idx)) && spi_get_csgpiod(spi, idx)) {
 					if (has_acpi_companion(&spi->dev))
 						gpiod_set_value_cansleep(spi_get_csgpiod(spi, idx),
 									 !enable);
@@ -2456,14 +2462,10 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
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
@@ -2587,14 +2589,10 @@ struct spi_device *spi_new_ancillary_device(struct spi_device *spi,
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
 
@@ -2841,14 +2839,10 @@ struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
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
@@ -3346,9 +3340,9 @@ int spi_register_controller(struct spi_controller *ctlr)
 		goto free_bus_id;
 	}
 
-	/* Setting last_cs to -1 means no chip selected */
+	/* Setting last_cs to SPI_INVALID_CS means no chip selected */
 	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
-		ctlr->last_cs[idx] = -1;
+		ctlr->last_cs[idx] = SPI_INVALID_CS;
 
 	status = device_add(&ctlr->dev);
 	if (status < 0)
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index e400d454b3f0..81ca62e608c1 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -226,7 +226,8 @@ struct spi_device {
 	/* The statistics */
 	struct spi_statistics __percpu	*pcpu_statistics;
 
-	/* Bit mask of the chipselect(s) that the driver need to use from
+	/*
+	 * Bit mask of the chipselect(s) that the driver need to use from
 	 * the chipselect array.When the controller is capable to handle
 	 * multiple chip selects & memories are connected in parallel
 	 * then more than one bit need to be set in cs_index_mask.
@@ -448,9 +449,11 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  *	the @cur_msg_completion. This flag is used to signal the context that
  *	is running spi_finalize_current_message() that it needs to complete()
  * @cur_msg_mapped: message has been mapped for DMA
+ * @fallback: fallback to PIO if DMA transfer return failure with
+ *	SPI_TRANS_FAIL_NO_START.
+ * @last_cs_mode_high: was (mode & SPI_CS_HIGH) true on the last call to set_cs.
  * @last_cs: the last chip_select that is recorded by set_cs, -1 on non chip
  *           selected
- * @last_cs_mode_high: was (mode & SPI_CS_HIGH) true on the last call to set_cs.
  * @xfer_completion: used by core transfer_one_message()
  * @busy: message pump is busy
  * @running: message pump is running
@@ -527,8 +530,6 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  *	If the driver does not set this, the SPI core takes the snapshot as
  *	close to the driver hand-over as possible.
  * @irq_flags: Interrupt enable state during PTP system timestamping
- * @fallback: fallback to PIO if DMA transfer return failure with
- *	SPI_TRANS_FAIL_NO_START.
  * @queue_empty: signal green light for opportunistically skipping the queue
  *	for spi_sync transfers.
  * @must_async: disable all fast paths in the core
@@ -708,10 +709,10 @@ struct spi_controller {
 	bool				rt;
 	bool				auto_runtime_pm;
 	bool				cur_msg_mapped;
-	char				last_cs[SPI_CS_CNT_MAX];
-	char				last_cs_index_mask;
-	bool				last_cs_mode_high;
 	bool                            fallback;
+	bool				last_cs_mode_high;
+	s8				last_cs[SPI_CS_CNT_MAX];
+	u32				last_cs_index_mask : SPI_CS_CNT_MAX;
 	struct completion               xfer_completion;
 	size_t				max_dma_len;
 
-- 
2.43.0.rc1.1.gbec44491f096


