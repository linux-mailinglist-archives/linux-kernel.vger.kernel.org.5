Return-Path: <linux-kernel+bounces-95830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 059C987539D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF2BF1C234EA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427F512F59C;
	Thu,  7 Mar 2024 15:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aogAz55Y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377EF12F390;
	Thu,  7 Mar 2024 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709826318; cv=none; b=uI+E1w9wP4gD1/KHyt0DFKMwbefpZAKx9FElqd8GPIPx0Y7x4DtM7IsNSx62semzUKfLt4y6RKWc+3ZKOhoOyjVkrOR+u1y+3BpSAy/U6sVHWUKsn6dLGuPqi1uIRVsfUJ80VFqLxSdTHdIsdzAjukDYZHZ2qI8C6yuLFQhYF18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709826318; c=relaxed/simple;
	bh=mj0GXkXy9Xs5y8Ltp8TCGwDRTY+Y95OlKnsw/V6zXtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pknVQ8TJxjJqqEz22q0Nd4poRPwKv6MSfOXalob7++DQpjci3ZYYF0RXJJ7WehDo1HptXs1VWCfY0Me03XLcSnmOoP+buVXKiwDtFnHSmT1TS5sr+q40OPZVlAbI+zl1KJd5qd2Uc8O4ZgvG9Yyj3qZ/ofzRCKGZgAiPW7k8XGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aogAz55Y; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709826317; x=1741362317;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mj0GXkXy9Xs5y8Ltp8TCGwDRTY+Y95OlKnsw/V6zXtA=;
  b=aogAz55Y4LgVy4tFKytrr9+WAqXBYAtkiDfFdYxdBzSZ5NYFb4CTKkSR
   sKifNBK3excT7V2gvJRd/vknt0RP69dvz5qFy8PajpCPbSIvq3ug8SkoI
   Xlq/8IV93SOo65052ahWUJQG8GJ2VMCZsbVAvipmTyqln7+zcgg9xOu0o
   3NT8SNuXJdLeRqKhVhhVON3rv+ouALukFx5KHUJSIEOE4F3517uNIpopN
   siM3lG005o2quhOFq2bOxvPmwXXKMkMdYlOIr32Wy9QWzf0aJ6Ra3FV5R
   LDnONwfRPj9OK/sFZ40OQA3iEcaKONgH3JIQ+ypngyG8xPnYsEqoIczgN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15221965"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="15221965"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 07:45:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="937046336"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="937046336"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 07:45:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E64465BB; Thu,  7 Mar 2024 17:45:11 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>
Subject: [PATCH v1 3/3] spi: xilinx: Make num_chipselect 8-bit in the struct xspi_platform_data
Date: Thu,  7 Mar 2024 17:43:59 +0200
Message-ID: <20240307154510.3795380-4-andriy.shevchenko@linux.intel.com>
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

There is no use for whole 16-bit for the number of chip select pins.
Drop it to 8 bits and reshuffle the data structure layout to avoid
unnecessary paddings.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/spi/xilinx_spi.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/spi/xilinx_spi.h b/include/linux/spi/xilinx_spi.h
index 4ba8f53ce570..a638ba2a55bd 100644
--- a/include/linux/spi/xilinx_spi.h
+++ b/include/linux/spi/xilinx_spi.h
@@ -8,18 +8,18 @@ struct spi_board_info;
 
 /**
  * struct xspi_platform_data - Platform data of the Xilinx SPI driver
+ * @force_irq:		If set, forces QSPI transaction requirements.
  * @num_chipselect:	Number of chip select by the IP.
  * @bits_per_word:	Number of bits per word.
- * @devices:		Devices to add when the driver is probed.
  * @num_devices:	Number of devices in the devices array.
- * @force_irq:		If set, forces QSPI transaction requirements.
+ * @devices:		Devices to add when the driver is probed.
  */
 struct xspi_platform_data {
-	u16 num_chipselect;
-	u8 bits_per_word;
-	struct spi_board_info *devices;
-	u8 num_devices;
 	bool force_irq;
+	u8 num_chipselect;
+	u8 bits_per_word;
+	u8 num_devices;
+	struct spi_board_info *devices;
 };
 
 #endif /* __LINUX_SPI_XILINX_SPI_H */
-- 
2.43.0.rc1.1.gbec44491f096


