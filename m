Return-Path: <linux-kernel+bounces-95829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FAC8753A4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01771B277DB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F6E12F39B;
	Thu,  7 Mar 2024 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RfM4SzXY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D43312D765;
	Thu,  7 Mar 2024 15:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709826317; cv=none; b=KcRuxuLLSs9UDNWQX762bZv77ebRUY426og8Vb1oXx4Fuj0JRSd0rfRLxvHuFtaNNkE3f/vib5okiylPJ4V9X1h9HC1KCiRmjfshG0SxkPHvzMZAIvRryKy/ziCIx9hP4Jdq1yYUEM/7Q+3/bT+hy8HY+VMijVQZ1CV0upS1Sx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709826317; c=relaxed/simple;
	bh=daUuIo7r71bWeft67R/wa5LvoARKP4ulf/SmFvlJLKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHWHTrIdKHIKRAATgJ1ZPHAJZT73Qek2Ue0KfeskK4X9gou8fxRoBMdXd9d9LHqW7XD8SoSR45Y6XtiMP9CTZ4swGEevywTI5pFCjr1wRlc6BCoXdt6e5O1QQTEO/hdjQsaSjhQT1rU0TqY4yiQJIUEMdsadRcM1jwVr/CLLciU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RfM4SzXY; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709826315; x=1741362315;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=daUuIo7r71bWeft67R/wa5LvoARKP4ulf/SmFvlJLKU=;
  b=RfM4SzXYQqoxOblRqaGXq8rSnJPQocyT0igTU9PnwywfUIh2cM0h4xmV
   DswDpXTvh8drpcLslvlYF0fMHTQLOMldSPFk8+UqM2cF5c5n8oVyzBby1
   7MaSAPltTdzodOWeKtvWDd/h3TIEpZq+LLPfpxa8sDHdgBERoGuMMkWdW
   nl7GBDCkg+px40gQTXUZrpW34VBJ4/Xfc48MIWOHBOIf/8YfxfKdNKV3D
   5RvXw5pURZ1f3q0qhQHyjodRc+LkT664bw6V1k2Q4BYjX1LkjGcle5Z2Q
   tfEpg8IMUq2MCS544TCIdFpmiODif712PK2KUwaifaMEQFa64RIpORIhQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15221955"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="15221955"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 07:45:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="937046333"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="937046333"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 07:45:12 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D5764193; Thu,  7 Mar 2024 17:45:11 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>
Subject: [PATCH v1 1/3] spi: xilinx: Fix kernel documentation in the xilinx_spi.h
Date: Thu,  7 Mar 2024 17:43:57 +0200
Message-ID: <20240307154510.3795380-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240307154510.3795380-1-andriy.shevchenko@linux.intel.com>
References: <20240307154510.3795380-1-andriy.shevchenko@linux.intel.com>
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


