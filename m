Return-Path: <linux-kernel+bounces-95908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A12098754D1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CE7D28726A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38989131731;
	Thu,  7 Mar 2024 17:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FHzFWdm/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00884130AD4;
	Thu,  7 Mar 2024 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709831091; cv=none; b=DLsIUClnQgF0UmswkKo2pS1RlLhmbTeOzsty3RADNmptvjqWxM85fBwuSdiM8BD3VnU17Tapfa23lBhCUeEHGqZe4u9WbOEm6G7qnkqEjquaSg79f25PHai40Q2+7DwYnm8120Z/GifT8joDnCTOh4EtO4e1bCxkR/POkeL2Dcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709831091; c=relaxed/simple;
	bh=cv+rxy5QtxrIBZi0IThzTINv+rwro5NUmSO5y8zDSgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7Q49fAr74+DEvHq5t4CNc53YKfdhznGxTQfM/KZGfWMc/CYcEEEAC6gjZy6byvk5QacVMDcnXvrYp24TF8vqYeA349Ms5ZObzDIL8Yn8Bgn10hUNzlcrx/db9zEKFPO/vLlJWzGmLKvOetwGFQjIPlrj6EK8ZQNKMRJug93YUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FHzFWdm/; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709831090; x=1741367090;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cv+rxy5QtxrIBZi0IThzTINv+rwro5NUmSO5y8zDSgA=;
  b=FHzFWdm/vNREdZgG0ygjjiftLmRcxyV7tdvbFacKlJNXozwNIa7UwBLQ
   VwY66bpc7/PYciKLJvo4z8hUqMy5aNRUncRLuPFQVKjZ7HYh1Sx1/104q
   0Yqfn1hbUvEU8E6+mCEhBCoCyHgRxvCjk7y+wpmAZpk6FxVACRW54rRjI
   tum32LESuc8gJZyZJ2PEu7qT9B2spgTeuUylQS2IvB0MKl/2bZv9AVS0C
   HxrbxLOeLcwp3a5Zrlcglyl5yugxA3VVu4wdL004P3kOetmRVMsD9h7Ww
   3UUs3bBHBL1rVpp99kz1IkNUsJsDG8JTt63AtKFXJcLFp1BQwFBh1shMV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4392430"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="4392430"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 09:04:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="937046413"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="937046413"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 09:04:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 76576152; Thu,  7 Mar 2024 19:04:42 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 2/3] spi: pxa2xx: Make num_chipselect 8-bit in the struct pxa2xx_spi_controller
Date: Thu,  7 Mar 2024 19:03:16 +0200
Message-ID: <20240307170441.3884452-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240307170441.3884452-1-andriy.shevchenko@linux.intel.com>
References: <20240307170441.3884452-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no use for whole 16-bit for the number of chip select pins.
Drop it to 8 bits.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/spi/pxa2xx_spi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/spi/pxa2xx_spi.h b/include/linux/spi/pxa2xx_spi.h
index 56aba2f737b1..e5a4a045fb67 100644
--- a/include/linux/spi/pxa2xx_spi.h
+++ b/include/linux/spi/pxa2xx_spi.h
@@ -17,7 +17,7 @@ struct dma_chan;
  * (resides in device.platform_data).
  */
 struct pxa2xx_spi_controller {
-	u16 num_chipselect;
+	u8 num_chipselect;
 	u8 enable_dma;
 	u8 dma_burst_size;
 	bool is_target;
-- 
2.43.0.rc1.1.gbec44491f096


