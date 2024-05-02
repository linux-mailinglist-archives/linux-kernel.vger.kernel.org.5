Return-Path: <linux-kernel+bounces-166772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9708B9F56
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29EA82884CF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379D116FF37;
	Thu,  2 May 2024 17:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B+Kqv2Ad"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4DB16F919;
	Thu,  2 May 2024 17:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714670137; cv=none; b=qdi3IXrvSJIXXUOPKs9RqI+5HxJMGx4Kkot7pbvtkOUc9xyDMZcRrYDEs9PMl+VBrJvcnkyobbijFOZP3BFKDkg/AaW9g9LoKvkWco0GEsN/oYy56H1PMeY6YH8SKuPAslNcdrbmWG4oEUIoI4PA7UHBIcVWUsJ3eOauJO+feqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714670137; c=relaxed/simple;
	bh=FxCQSfOwSoVaJ9cIiOaEfhOOsDhub2N5bNvr17xm9VE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WY7CGDQgAdf77xJmDSBhdnCDWQYPGZqKL9dU9Ttzg1ZoqgAq+YGRPhaIMx+958PHHI/ED/c2C3ESiMa6yxFlX+QpcQogewHQcBKM0faqWc9JUvkJIf/lkBRIVwem8y6TxHzs8jSYS7BNwhPZYSdhLtP6YwtyfKOQtZMuxkmdcHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B+Kqv2Ad; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714670135; x=1746206135;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FxCQSfOwSoVaJ9cIiOaEfhOOsDhub2N5bNvr17xm9VE=;
  b=B+Kqv2AdKa3q5wqDAtrOsjVuzkXgyfu/6P9nmx9KqhwrFkJ+gRGasmSR
   ls5000BtzQFSrh6DuYTYW1woyXDKFxQPIMMadwxGzjBEFMxxGxXD5kvEk
   n2U7OeGs6xSWQE35r1wktfKvDyl6krSWS3sgY4uzRQtVGMc/JGXCHd5GW
   f+p1gIcwfIcgvw9G2dRPC3zaSrzYfRlwhOGgncZ5bkoDdFdh02h8QhA/w
   l9Io3gAEEPVq4HMmlM0iuGezxG4D98eZ8OPBXtxe/hEgCg6Fled4/l6T9
   Ju/yET/iOMzlxHKQJ2Q2dRH3oOpRkfdEya27MB0bf1fSCj6ItJpEhxt1A
   g==;
X-CSE-ConnectionGUID: c4LSDASjRvesA9uPeVh/Ng==
X-CSE-MsgGUID: nGv6XDXgShauzMkbMrIS9w==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10992810"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10992810"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 10:15:30 -0700
X-CSE-ConnectionGUID: ugKweYkvRZ6TnT2Sfnxotg==
X-CSE-MsgGUID: ZaqU60ZXS6aGgMeePm0TOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="50382848"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 02 May 2024 10:15:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id AEC31161; Thu,  2 May 2024 20:15:27 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] spi: bitbang: Add missing MODULE_DESCRIPTION()
Date: Thu,  2 May 2024 20:15:18 +0300
Message-ID: <20240502171518.2792895-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The modpost script is not happy

  WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spi/spi-bitbang.o

because there is a missing module description.

Add it to the module.

While at it, update the terminology in Kconfig section to be in align
with added description along with the code comments.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/Kconfig       |  4 ++--
 drivers/spi/spi-bitbang.c | 18 +++++++++---------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 17325e0b7bd5..eb283824f174 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -216,11 +216,11 @@ config SPI_BCMBCA_HSSPI
 	  explicitly.
 
 config SPI_BITBANG
-	tristate "Utilities for Bitbanging SPI masters"
+	tristate "Utilities for Bitbanging SPI host controllers"
 	help
 	  With a few GPIO pins, your system can bitbang the SPI protocol.
 	  Select this to get SPI support through I/O pins (GPIO, parallel
-	  port, etc).  Or, some systems' SPI master controller drivers use
+	  port, etc).  Or, some systems' SPI host controller drivers use
 	  this code to manage the per-word or per-transfer accesses to the
 	  hardware shift registers.
 
diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
index c11af39c9842..ca5cc67555c5 100644
--- a/drivers/spi/spi-bitbang.c
+++ b/drivers/spi/spi-bitbang.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * polling/bitbanging SPI master controller driver utilities
+ * Polling/bitbanging SPI host controller controller driver utilities
  */
 
 #include <linux/spinlock.h>
@@ -394,12 +394,12 @@ int spi_bitbang_init(struct spi_bitbang *bitbang)
 EXPORT_SYMBOL_GPL(spi_bitbang_init);
 
 /**
- * spi_bitbang_start - start up a polled/bitbanging SPI master driver
+ * spi_bitbang_start - start up a polled/bitbanging SPI host controller driver
  * @bitbang: driver handle
  *
  * Caller should have zero-initialized all parts of the structure, and then
- * provided callbacks for chip selection and I/O loops.  If the master has
- * a transfer method, its final step should call spi_bitbang_transfer; or,
+ * provided callbacks for chip selection and I/O loops.  If the host controller has
+ * a transfer method, its final step should call spi_bitbang_transfer(); or,
  * that's the default if the transfer routine is not initialized.  It should
  * also set up the bus number and number of chipselects.
  *
@@ -407,9 +407,9 @@ EXPORT_SYMBOL_GPL(spi_bitbang_init);
  * hardware that basically exposes a shift register) or per-spi_transfer
  * (which takes better advantage of hardware like fifos or DMA engines).
  *
- * Drivers using per-word I/O loops should use (or call) spi_bitbang_setup,
- * spi_bitbang_cleanup and spi_bitbang_setup_transfer to handle those spi
- * master methods.  Those methods are the defaults if the bitbang->txrx_bufs
+ * Drivers using per-word I/O loops should use (or call) spi_bitbang_setup(),
+ * spi_bitbang_cleanup() and spi_bitbang_setup_transfer() to handle those SPI
+ * host controller methods.  Those methods are the defaults if the bitbang->txrx_bufs
  * routine isn't initialized.
  *
  * This routine registers the spi_controller, which will process requests in a
@@ -418,7 +418,7 @@ EXPORT_SYMBOL_GPL(spi_bitbang_init);
  *
  * On success, this routine will take a reference to the controller. The caller
  * is responsible for calling spi_bitbang_stop() to decrement the reference and
- * spi_controller_put() as counterpart of spi_alloc_master() to prevent a memory
+ * spi_controller_put() as counterpart of spi_alloc_host() to prevent a memory
  * leak.
  */
 int spi_bitbang_start(struct spi_bitbang *bitbang)
@@ -451,4 +451,4 @@ void spi_bitbang_stop(struct spi_bitbang *bitbang)
 EXPORT_SYMBOL_GPL(spi_bitbang_stop);
 
 MODULE_LICENSE("GPL");
-
+MODULE_DESCRIPTION("Utilities for Bitbanging SPI host controllers");
-- 
2.43.0.rc1.1336.g36b5255a03ac


