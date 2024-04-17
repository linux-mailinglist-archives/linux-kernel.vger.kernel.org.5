Return-Path: <linux-kernel+bounces-148372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 866298A819F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 403BC2863F4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9430D13EFE8;
	Wed, 17 Apr 2024 11:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lTSmCMF6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95E513D53B;
	Wed, 17 Apr 2024 11:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713351832; cv=none; b=byLMOhUh7iHFnaX4n8oeDnInhG3WQLg05S77eqRU/MBHh8cPQDBbXf5WmG8eyYcq68XJYQHjkuJo5Q33KCQXYlP44w0aXCKnTvwpVX5ec7eUlPOT/WWFI3gamZJoj2ZPuw2YdcUA72HcFiyanvL37UoM7qdB3b8qzk8Y8jNy6Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713351832; c=relaxed/simple;
	bh=9qZmuA7jLecFtZoV4feOe4GVLTIJuoKfF/zfVdw+9zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYJo8BOv6/LP4cDwuiGlzMv5GGLaii3wZInSJVchinoZngSRz5Y66DrMN9faLTB/la5rhZQY68uvOsVafLCuNAqFWUfQ+IQ1iM3NiQEoSuH7va9cKRg+idSJy7dwW/8OGAXAKsISraRYM8zPJM8ZE/00ulIQ3i2FqowppvkYaJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lTSmCMF6; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713351831; x=1744887831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9qZmuA7jLecFtZoV4feOe4GVLTIJuoKfF/zfVdw+9zo=;
  b=lTSmCMF61ASYxaPcxACUiPJ/srReKf4FVkkuV9O/eIvuP5WrhlN55RNl
   HdW6WHQB3rNQCG44738bH4jK6x+VpATsfucCoUV8O1G/skAoUIeg4fQsI
   GYGV011a14IKoDzCJaqTL4U4ZvD/1N/fap9UwExjwyVEwXmTvD7aZ0y3f
   8ASywVREDRGor0ouczqFaUlkWC6xWIeE4uVzgvPuNpmA7NgDd4HCzDp//
   Qi9JWVg9LUe64P4iPaE6TTATVILRrAvYKV/vdPcClkXsmGUCYEc8RCIdQ
   LZrRJD/y8uYFoXDHFc0xVOyTvtO3stY9zcRlWfndl1Q969//yW8lbbog6
   w==;
X-CSE-ConnectionGUID: /r2GSI1oQtK42qQfds5RNA==
X-CSE-MsgGUID: An3vu9AmSVK074CDC406nw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8698172"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="8698172"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 04:03:43 -0700
X-CSE-ConnectionGUID: 4bTWfvTES7mPrLoDdsjZqQ==
X-CSE-MsgGUID: ADbg6H6IQJWW1oHVrXNl+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="22653281"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 17 Apr 2024 04:03:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B7B1514F6; Wed, 17 Apr 2024 14:03:36 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH v3 8/9] spi: pxa2xx: Remove timeout field from struct chip_data
Date: Wed, 17 Apr 2024 13:54:35 +0300
Message-ID: <20240417110334.2671228-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240417110334.2671228-1-andriy.shevchenko@linux.intel.com>
References: <20240417110334.2671228-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The timeout field is used only once and assigned to a predefined
constant. Replace all that by using the constant directly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 4 +---
 drivers/spi/spi-pxa2xx.h | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 3ba0f5816f7f..030afb17e606 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1058,7 +1058,7 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *controller,
 		pxa_ssp_disable(drv_data->ssp);
 
 	if (!pxa25x_ssp_comp(drv_data))
-		pxa2xx_spi_write(drv_data, SSTO, chip->timeout);
+		pxa2xx_spi_write(drv_data, SSTO, TIMOUT_DFLT);
 
 	/* First set CR1 without interrupt and service enables */
 	pxa2xx_spi_update(drv_data, SSCR1, change_mask, cr1);
@@ -1200,8 +1200,6 @@ static int setup(struct spi_device *spi)
 		chip = kzalloc(sizeof(struct chip_data), GFP_KERNEL);
 		if (!chip)
 			return -ENOMEM;
-
-		chip->timeout = TIMOUT_DFLT;
 	}
 
 	chip->cr1 = 0;
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 10294ef209d9..5f741bb30240 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -78,7 +78,6 @@ struct driver_data {
 struct chip_data {
 	u32 cr1;
 	u32 dds_rate;
-	u32 timeout;
 	u32 threshold;
 	u16 lpss_rx_threshold;
 	u16 lpss_tx_threshold;
-- 
2.43.0.rc1.1336.g36b5255a03ac


