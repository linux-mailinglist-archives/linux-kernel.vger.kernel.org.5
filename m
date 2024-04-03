Return-Path: <linux-kernel+bounces-130271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B240897627
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C7281C285A4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEFC154C03;
	Wed,  3 Apr 2024 17:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lZ0H/IOx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88511153507;
	Wed,  3 Apr 2024 17:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164561; cv=none; b=MxAjn/f+4DtDk3W5uk/tSMMMxu+4qT+H2T/u2RjkMDip67fS52dbMx2PvpFOJlCAeDwenC4wrMJHposIKkqK4nml9j/wMg3ezBrM2s+yOO6B/YfuBJ4AhfEbIhd9+ePfIuLu6tnadabwZUyE9NBDrNvXm0B0I5uYvYxLcwjMHKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164561; c=relaxed/simple;
	bh=PM761U8KlFurCf4B7pY6nAuxa2K6lOSBEcR+3UzRD20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XywLQszwqcsO7zOHkKe+0NgQ5Tu+3MX3Ot8HqjP8ofONraz9AjOcqvF0NdE8KD2+3d2VXI1ruJKN5Z/j6msWZeqQZkanSHG/NOgMG+OUuAY1D6H2u7YJq3zxgURM22xWbS+3ixXb7vVoG0Zj/ax0Z5XO7J0WE3LCoXRBNpMqOBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lZ0H/IOx; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712164561; x=1743700561;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PM761U8KlFurCf4B7pY6nAuxa2K6lOSBEcR+3UzRD20=;
  b=lZ0H/IOxp/ZD6oNtttO2WOo+m1yiGKvuAL5RPbXbTbdwHyD/qxzRydSb
   oSQuMbB8krRV/Hh4S9aZPdns1+pGJmhuiEzEhtDwHKfjJdJj4P4Y9LVzz
   85YoJGJFF5PR1Qn6yR3CFpMYGcNxvStfmOjeTBdIeIHrqt76LyVzVTPZa
   4vsmzNaiSHu8ILzbEmnCzutrlJlB1Ga57fkLz9V4nJOxJhZOIB5O4p/S5
   XC8R/NUDz/8yST1QzO73lRbhKKhcK1l5ElUCwizXrEg+aWMlBKs9cfoKI
   vmZorbU1k2CLRz9BAyGOTiIbI2fY5Z5uDQ84Izd/ZXMOGbBCla5e2QTEv
   w==;
X-CSE-ConnectionGUID: ZrWsYpGyQEu6KZegQ3Ascg==
X-CSE-MsgGUID: ERtfGtX0TYGC14gL/KHPoQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18863562"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18863562"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 10:15:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="937085340"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="937085340"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Apr 2024 10:15:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id BE03D670; Wed,  3 Apr 2024 20:15:53 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 4/5] spi: pxa2xx: Remove timeout field from struct chip_data
Date: Wed,  3 Apr 2024 20:06:38 +0300
Message-ID: <20240403171550.1074644-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240403171550.1074644-1-andriy.shevchenko@linux.intel.com>
References: <20240403171550.1074644-1-andriy.shevchenko@linux.intel.com>
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
2.43.0.rc1.1.gbec44491f096


