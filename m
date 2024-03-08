Return-Path: <linux-kernel+bounces-97305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B058876886
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C7271C21E6E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E497E57878;
	Fri,  8 Mar 2024 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OhP+f60Y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D11138DF9;
	Fri,  8 Mar 2024 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709915374; cv=none; b=Gibvp9KujpbEz71D5a/RPv0Pn8fbvFqx9rnLHTEsIuvxVIpIVJS+qmvdDKfAbZy2lwngpVxCsKZY8tr1Y0K/f+BT/w0rkxmfLGa7qjL99hgSbXkbvn3RxESXZGGR675gq1HihiaLkG3Hz/CDAYDVYqZPg0ckIZXmFwa0HXv4kLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709915374; c=relaxed/simple;
	bh=XXvje3DsPXFomNyXuJGV+9j2nWWkci2XhBpIRqsHwDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/iWVze2OuOsVsm623goSUkskGtJ7gfZ4xEIQV4biHAEovif2FchzLe3POWXm7qh7MpN1Px3b8FZ+dldG24TBfbE+gslNi6yKpQ25kakadGqI928IxfZ4gFvaOobXWsbduoxgU73V/qi0TLkdZ5zNgiTR44wg69KSA9vB4YpquM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OhP+f60Y; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709915373; x=1741451373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XXvje3DsPXFomNyXuJGV+9j2nWWkci2XhBpIRqsHwDM=;
  b=OhP+f60YfOyVYY72Ea0xl0cFzEMEVM7Ow9HY9KyO/yiXAK5c+3nxwVYl
   lrczekFWljkGAzqfmnwYbaHbmJKyxIHO9p/gGmkfWn1QH1F22cl/umUsj
   iKDUDBmmlcXvAkXZ8h5/YoeDkjezNw5ymRVEDzLL0rBw2i7KRP/WL/USU
   84zspYRxBXfhhX7Vv5oPonHQlKWq0790Z/lmyhyXAi9p6EyPjTrcAUCG/
   1whZhbcdZgKHgoTDWbewXyXVxdzj0y67yuMO+IPieIRmsmu2tEWu3WIPP
   F5k48+D6h0AfWWqE/GzEtjPcmCSQsPUPMBaM5aEpQx1l8BWrMDmuU9li7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11007"; a="4806765"
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="4806765"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 08:29:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11007"; a="937047685"
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="937047685"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Mar 2024 08:29:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B631921A; Fri,  8 Mar 2024 18:29:25 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>
Subject: [PATCH v2 2/3] spi: xilinx: Add necessary inclusion and forward declaration
Date: Fri,  8 Mar 2024 18:27:47 +0200
Message-ID: <20240308162920.46816-3-andriy.shevchenko@linux.intel.com>
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

xilinx_spi.h is mnissing inclusion and forward declaration, add them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/spi/xilinx_spi.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/spi/xilinx_spi.h b/include/linux/spi/xilinx_spi.h
index fd6add419e94..4ba8f53ce570 100644
--- a/include/linux/spi/xilinx_spi.h
+++ b/include/linux/spi/xilinx_spi.h
@@ -2,6 +2,10 @@
 #ifndef __LINUX_SPI_XILINX_SPI_H
 #define __LINUX_SPI_XILINX_SPI_H
 
+#include <linux/types.h>
+
+struct spi_board_info;
+
 /**
  * struct xspi_platform_data - Platform data of the Xilinx SPI driver
  * @num_chipselect:	Number of chip select by the IP.
-- 
2.43.0.rc1.1.gbec44491f096


