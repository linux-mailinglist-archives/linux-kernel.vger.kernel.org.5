Return-Path: <linux-kernel+bounces-97304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3AA876885
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39EC228679C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB1E57322;
	Fri,  8 Mar 2024 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TN37HMDF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABC23BBE0;
	Fri,  8 Mar 2024 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709915373; cv=none; b=aSZEJL297zZa2HjVMlH8VVVur6VFIjyElAcBb9vAgm1j9o0ZJ0Y3RhDzyEJRQGUZtB9CINLW+yXimVDXqH0ygLOvWsR+NdePNoSsj0N63czIom93nNRwBIW9Nntz/h4r7sT/pJ6Jsy50xy54uhBD0pM56wnJN0kcNrO8nMsbVDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709915373; c=relaxed/simple;
	bh=fIeQk5Wp5I84wTiwz4DvoHCEPwiTAvPIYfShGQ0P904=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F/Sh8k/4wv8GEfYc9oxKGeRat6JtMB67hKAOjOLyc34U6uzrmgdpPRQ0cf//VAN8PhmuV9SLHdYywAkaDIcOcdCnCuKL2mg0Z/H2INh2j3rGWwtWulgwaEqOcMixW1mVxTDi37cAvCAK1YYIp9Vx+vbzM3WK3deIPRDbF8OvcNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TN37HMDF; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709915373; x=1741451373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fIeQk5Wp5I84wTiwz4DvoHCEPwiTAvPIYfShGQ0P904=;
  b=TN37HMDFGaY/u98w+SRRk0i7k/0O4ZndpJuAcc7L7tymr4ItlPLl8sRs
   HU9PxnBOBH9BZqwT6/f1FH8aZZBBw0z0JTJSE1JU6lo3rjqdaaHGgpvlC
   vohe025GliQ87EKjLTUW0APzSSuvYlONVTM61bI9U+XU0x2LIgZBiQeqU
   BKvLkk13+6v4zPJGwCxKQWHzEzk9Gn32PU0nTE+VaZpCZ/3IszgIUJN9Q
   OvTp3+kh3ydbAL4VxMo9NkHXh7kKX3DQ+SjLpw/V9RX2an2vfikNXlmlO
   RVmIffepsoTcfO6eL6IS36EpkTcqU3MuFtthx/z1kf9S3uhjxHPhgBLSK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11007"; a="4806761"
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="4806761"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 08:29:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11007"; a="937047684"
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="937047684"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Mar 2024 08:29:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id AE67C86; Fri,  8 Mar 2024 18:29:25 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>
Subject: [PATCH v2 1/3] spi: xilinx: Fix kernel documentation in the xilinx_spi.h
Date: Fri,  8 Mar 2024 18:27:46 +0200
Message-ID: <20240308162920.46816-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240308162920.46816-1-andriy.shevchenko@linux.intel.com>
References: <20240308162920.46816-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While updating the data structure layout the kernel documentation
became outdated. Synchronize kernel documentation with the actual
data structure layout.

Fixes: 1dd46599f83a ("spi: xilinx: add force_irq for QSPI mode")
Fixes: 082339bc63cc ("spi: spi-xilinx: Add run run-time endian detection")
Reviewed-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/spi/xilinx_spi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/spi/xilinx_spi.h b/include/linux/spi/xilinx_spi.h
index 3934ce789d87..fd6add419e94 100644
--- a/include/linux/spi/xilinx_spi.h
+++ b/include/linux/spi/xilinx_spi.h
@@ -5,10 +5,10 @@
 /**
  * struct xspi_platform_data - Platform data of the Xilinx SPI driver
  * @num_chipselect:	Number of chip select by the IP.
- * @little_endian:	If registers should be accessed little endian or not.
  * @bits_per_word:	Number of bits per word.
  * @devices:		Devices to add when the driver is probed.
  * @num_devices:	Number of devices in the devices array.
+ * @force_irq:		If set, forces QSPI transaction requirements.
  */
 struct xspi_platform_data {
 	u16 num_chipselect;
-- 
2.43.0.rc1.1.gbec44491f096


