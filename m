Return-Path: <linux-kernel+bounces-95792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64298752A7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC6431C2260B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C1412F593;
	Thu,  7 Mar 2024 15:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FLMn7+z/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38D712DDBA;
	Thu,  7 Mar 2024 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709823784; cv=none; b=gn2kiRQU9rXsZ4p13MhtAwiJBCP7t7cJbOTGOA47U4WI0XOQbS2FWAUSd6vjmA+SdE0HWutMr9Uv+i7XiUHxQMRR8u9y3kalv20lG2hEDOY6kCy1qdjJEhbTF8V0qqTvHM1aYZLnx2M6+AhIMkFe5q0d+5HB96aTjEFQC7xGrak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709823784; c=relaxed/simple;
	bh=Thbo6fqN781SvZRIGgY3Lf5UsS91S+L+RdrRfcust1U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZoriGc6wI3AP6chKCCkAWgGEaobaqFgA/AISylLHe1b/5jV99yaS2lRN379S20p6B7tDf+4uZG/wGvTk29mn+fqVHPrqmjuPyHyDEIb6o8QoR5Eu0XDi/An5DCKHMjkqi2nL3gW1zlkZvc7pbARz7d87PuZsTPu3H4bqFUiVMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FLMn7+z/; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709823783; x=1741359783;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Thbo6fqN781SvZRIGgY3Lf5UsS91S+L+RdrRfcust1U=;
  b=FLMn7+z/fo48Ih8mDgW3/hJfzf/6aKShOQqBTwLiVdcuUpu5GoFKaILd
   R0XUY5u3nF9a2gIqLkGXkan7gq1s/R+5jCZaHOUzjxW9bIBpyWrGiNsXU
   WmyNtq9YYPE+OglZ6Isb2Q2RoAxdlhdzHsLYt2f97I1i0Wckvj26dkRf0
   mnUaICjKqNCqUWAD3BD5+MIk6V2No2hYxszvUdnOsf2ilV2qNoTNUAjb6
   Zf7DWWBOzg5Ml5ZwEyIGJgchCSNL5zhHFD4BdluJPCbrIlcOJ2OnWBgqo
   Hh9kYJSYxqcds55vOZyq0ViBaf9WHO3nfHGe14N7tC5w8in+oU9xff+jz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4351050"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="4351050"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 07:03:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="937046327"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="937046327"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 07:02:59 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 274A54E9; Thu,  7 Mar 2024 17:02:58 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] spi: Fix types of the last chip select storage variables
Date: Thu,  7 Mar 2024 17:01:00 +0200
Message-ID: <20240307150256.3789138-3-andriy.shevchenko@linux.intel.com>
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

First of all, last_cs_index_mask should be aligned with the original
cs_index_mask, which is 16-bit (for now) wide. Use the same pattern
for the last_cs_index_mask.

Second, last_cs can be negative and since 'char' is equal to 'unsigned
char' in the kernel, it's incorrect, strictly speaking, to assign
signed number to it. Use s8 type as it's done for *_native_cs ones.

With this change, regroup a bit the ordering to avoid too much memory
space to be wasted due to paddings. Shuffle kernel documentation
accordignly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/spi/spi.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index e400d454b3f0..c459809efee4 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -448,9 +448,11 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
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
@@ -527,8 +529,6 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  *	If the driver does not set this, the SPI core takes the snapshot as
  *	close to the driver hand-over as possible.
  * @irq_flags: Interrupt enable state during PTP system timestamping
- * @fallback: fallback to PIO if DMA transfer return failure with
- *	SPI_TRANS_FAIL_NO_START.
  * @queue_empty: signal green light for opportunistically skipping the queue
  *	for spi_sync transfers.
  * @must_async: disable all fast paths in the core
@@ -708,10 +708,10 @@ struct spi_controller {
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


