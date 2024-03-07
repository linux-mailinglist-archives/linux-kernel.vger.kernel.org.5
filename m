Return-Path: <linux-kernel+bounces-95843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4238753E2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D7A81F23E4E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B27A12FB0E;
	Thu,  7 Mar 2024 16:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bJEdE6kG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470BA12F398;
	Thu,  7 Mar 2024 16:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709827725; cv=none; b=lJU4XS8rqW7798paNRMxFhxhm/HSYIFU2844BGnaynjpl/Vhe5GatUspvz6pHAIqNG08oZRp0UD7/vmjTg08f3y+rNldSBpBl+cNF4Cax163FVofLl37cozYy3XqgKNxTiv0Yry5eZbYf/TBkTUtbObIE+SSVSD1E5F+ZROx0hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709827725; c=relaxed/simple;
	bh=F1OHiv4WucxkGAgCSYrb8qP+gH5ZMgabEBIad4Z4yrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uUFjSMdI57XVR1wYH51916DDRRxFOkaYZ246eHVXKFpaOwy33mRn1SgrqAX7Y4WIplGGGzgzLrevBqbzhpftpAdgMwMEuRBLnBpxi+4vPggKJ04SL9ZoSopABL3ut/1nnRZQ8mQxvpBxR7gzVnV+cDUUctX/4phCqDxM3eb75Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bJEdE6kG; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709827724; x=1741363724;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F1OHiv4WucxkGAgCSYrb8qP+gH5ZMgabEBIad4Z4yrg=;
  b=bJEdE6kGoEMFWNc56TSz0rc8fZz/BgHUpODiHU0ZdUSDIcafFR242o4s
   5B36Dnc5IxSvpaxTodV6oBzHvSKky89s+5O/xjQEyt4jvtMrScwCQysc+
   Szeia2CM9RVSDFx5Vu4wDDsYCxoTwP38NQ2+b3dMNPgVSbCqyeZsZo4/Q
   0L2QKHv3dGiVtbkjEHsVqNinUtPJvMPIDBplqYHK1O4M4Qg5NIJioGr46
   MYHJAlEiEoXk9zkIlgnIIBGDy3ACE68Q7QBNE8hrIP6uEf96stwd6inSL
   prEWY7RaUHf9qQeatIzgO0rBhFyqe9RrwENppH7SRWufOuyHavdvsAcJw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15227308"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="15227308"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 08:08:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="937046345"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="937046345"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 08:08:25 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 797B83F1; Thu,  7 Mar 2024 18:08:24 +0200 (EET)
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
Subject: [PATCH v1 2/2] spi: pxa2xx: Make num_chipselect 8-bit in the struct pxa2xx_spi_controller
Date: Thu,  7 Mar 2024 18:07:39 +0200
Message-ID: <20240307160823.3800932-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240307160823.3800932-1-andriy.shevchenko@linux.intel.com>
References: <20240307160823.3800932-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no use for whole 16-bit for the number of chip select pins.
Drop it to 8 bits.

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


