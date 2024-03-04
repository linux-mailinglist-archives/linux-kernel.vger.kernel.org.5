Return-Path: <linux-kernel+bounces-91125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F428709D1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D181628406C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDEF78B44;
	Mon,  4 Mar 2024 18:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n2ZanZRA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7552E78685;
	Mon,  4 Mar 2024 18:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709578131; cv=none; b=KH7K2AmmiFSDIwzXHD3zT2n7wbf3k6b+lxyS0r4QSp28oNRH2mBWUnI9Jzy1yNwe45/a7tyE3CzRkV062KUSsycXlJnQBPMUbt/Lm/0S/adVIW3hs+Ja4+SRyVBM6yieAXoFC3PdCNZCja5nfJXid+2/xuE/oa9B1M5nSYzlu3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709578131; c=relaxed/simple;
	bh=fYmngNNcLL/DUCwVmE72NM3WEdjO17xRToQnYe/vSlg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=raSAcnu4/aaC7qHAJ1q8+aCv+BXH4JYers3rdZ/agt6ehC3hpVMA7BOtFPhFmHMRjyj2DLCrv2/Rmc0uuPKd9FQxm2EAAHWb4qyf4YEk4mnQ5zTwio2dcwDnTXBPMHN9vV5j31fcEMdUaozN0rFjBU44IQNWPUNM9DCFsryQnAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n2ZanZRA; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709578130; x=1741114130;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fYmngNNcLL/DUCwVmE72NM3WEdjO17xRToQnYe/vSlg=;
  b=n2ZanZRAD5Z2D5ULwG560LMAduGpPy+XRBDX6A2yhxZQsjilexYXk8yE
   M8lRg+rKVWVFHfmv78trZGfdGgFIsk+arNTEKGEeONX/MmTYnp5DZXCz5
   jRqTjZSB7Eea8qL7/CbPLo9XE30P2Ab/TXvKcXwd7LzWK1BkPmTkfjtbC
   K7LeSm3HzIHceKEzA4otZjlV6xsZJiT7u1DzPAiuGlvXMLkPC7jmb886q
   9Jq8xq2+vt7WTDRXLiN7V9JWQjCDByRbfkRaWDKV1tuRFfAz4WzJ582sA
   aSMkiTYeqVds8ghmH6mRQCrXTqcwZjQcDUAk5cEudkURjBaT1rAk6P34k
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4014736"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="4014736"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 10:48:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="937040962"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="937040962"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2024 10:48:35 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E93AC15C; Mon,  4 Mar 2024 20:48:33 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v1 1/1] mmc: mmc_spi: Don't mention DMA direction
Date: Mon,  4 Mar 2024 20:48:30 +0200
Message-ID: <20240304184830.1319526-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since driver doesn't handle any DMA requests, drop any use of DMA bits,
such as DMA direction. Instead, use MMC_DATA_WRITE flag directly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/mmc_spi.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index b8dda8160c4e..922275de0593 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -15,7 +15,6 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/bio.h>
-#include <linux/dma-direction.h>
 #include <linux/crc7.h>
 #include <linux/crc-itu-t.h>
 #include <linux/scatterlist.h>
@@ -510,10 +509,7 @@ mmc_spi_command_send(struct mmc_spi_host *host,
  * so we explicitly initialize it to all ones on RX paths.
  */
 static void
-mmc_spi_setup_data_message(
-	struct mmc_spi_host	*host,
-	bool			multiple,
-	enum dma_data_direction	direction)
+mmc_spi_setup_data_message(struct mmc_spi_host *host, bool multiple, bool write)
 {
 	struct spi_transfer	*t;
 	struct scratch		*scratch = host->data;
@@ -523,7 +519,7 @@ mmc_spi_setup_data_message(
 	/* for reads, readblock() skips 0xff bytes before finding
 	 * the token; for writes, this transfer issues that token.
 	 */
-	if (direction == DMA_TO_DEVICE) {
+	if (write) {
 		t = &host->token;
 		memset(t, 0, sizeof(*t));
 		t->len = 1;
@@ -547,7 +543,7 @@ mmc_spi_setup_data_message(
 	t = &host->crc;
 	memset(t, 0, sizeof(*t));
 	t->len = 2;
-	if (direction == DMA_TO_DEVICE) {
+	if (write) {
 		/* the actual CRC may get written later */
 		t->tx_buf = &scratch->crc_val;
 	} else {
@@ -570,10 +566,10 @@ mmc_spi_setup_data_message(
 	 * the next token (next data block, or STOP_TRAN).  We can try to
 	 * minimize I/O ops by using a single read to collect end-of-busy.
 	 */
-	if (multiple || direction == DMA_TO_DEVICE) {
+	if (multiple || write) {
 		t = &host->early_status;
 		memset(t, 0, sizeof(*t));
-		t->len = (direction == DMA_TO_DEVICE) ? sizeof(scratch->status) : 1;
+		t->len = write ? sizeof(scratch->status) : 1;
 		t->tx_buf = host->ones;
 		t->rx_buf = scratch->status;
 		t->cs_change = 1;
@@ -777,15 +773,15 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
 {
 	struct spi_device	*spi = host->spi;
 	struct spi_transfer	*t;
-	enum dma_data_direction	direction = mmc_get_dma_dir(data);
 	struct scatterlist	*sg;
 	unsigned		n_sg;
 	bool			multiple = (data->blocks > 1);
-	const char		*write_or_read = (direction == DMA_TO_DEVICE) ? "write" : "read";
+	bool			write = (data->flags & MMC_DATA_WRITE);
+	const char		*write_or_read = write ? "write" : "read";
 	u32			clock_rate;
 	unsigned long		timeout;
 
-	mmc_spi_setup_data_message(host, multiple, direction);
+	mmc_spi_setup_data_message(host, multiple, write);
 	t = &host->t;
 
 	if (t->speed_hz)
@@ -807,7 +803,7 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
 
 		/* allow pio too; we don't allow highmem */
 		kmap_addr = kmap(sg_page(sg));
-		if (direction == DMA_TO_DEVICE)
+		if (write)
 			t->tx_buf = kmap_addr + sg->offset;
 		else
 			t->rx_buf = kmap_addr + sg->offset;
@@ -818,7 +814,7 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
 
 			dev_dbg(&spi->dev, "    %s block, %d bytes\n", write_or_read, t->len);
 
-			if (direction == DMA_TO_DEVICE)
+			if (write)
 				status = mmc_spi_writeblock(host, t, timeout);
 			else
 				status = mmc_spi_readblock(host, t, timeout);
@@ -833,7 +829,9 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
 		}
 
 		/* discard mappings */
-		if (direction == DMA_FROM_DEVICE)
+		if (write)
+			/* nothing to do */;
+		else
 			flush_dcache_page(sg_page(sg));
 		kunmap(sg_page(sg));
 
@@ -850,7 +848,7 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
 	 * that can affect the STOP_TRAN logic.   Complete (and current)
 	 * MMC specs should sort that out before Linux starts using CMD23.
 	 */
-	if (direction == DMA_TO_DEVICE && multiple) {
+	if (write && multiple) {
 		struct scratch	*scratch = host->data;
 		int		tmp;
 		const unsigned	statlen = sizeof(scratch->status);
-- 
2.43.0.rc1.1.gbec44491f096


