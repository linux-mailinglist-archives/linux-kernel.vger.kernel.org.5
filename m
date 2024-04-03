Return-Path: <linux-kernel+bounces-130269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 738FD897623
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA5528FD80
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BFD153578;
	Wed,  3 Apr 2024 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ef5rHMTE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F052A152DE1;
	Wed,  3 Apr 2024 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164560; cv=none; b=jgCRNRB3TQVDbylInPkyHveSr4HHbPe8YwYNq/A24HBa3FjqpJubuXSklZr/tcV75zTNHwf8QKUc8xo56c2jxXIdiT0+imyTmDXZ/ULKut+u5Yt2kFuidaRJxhxWff75c+1e563xbw9jwC4bgnFCXzbzt0q9hMQwKnfeLg2HlPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164560; c=relaxed/simple;
	bh=GwuZHVBOSboMBOsVLsZWRQAybgsz5rDWta39aVm4WuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hj4/7vdSncLH6fIV9iyNoP034NHwfmJ+mJeVTLHNrhqI5GfhN60ryBBwCpX8WlW9RN1rI0m3rCqNTFNIQEU9ZYeRve5H9cqihm/3XKfILygeQU7W14wdWh/C1PeSmhvyaEZrz/dyYlxMl2QGYuR+Dq1vJISfbArh93lMEnHUeuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ef5rHMTE; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712164559; x=1743700559;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GwuZHVBOSboMBOsVLsZWRQAybgsz5rDWta39aVm4WuQ=;
  b=Ef5rHMTEst3MHnkUAoOsGD84oK+SJUN6RfSL+SiYqGr4dqu/Z5tsCq8m
   olmo0Tggs1VISCqGy675iwYNhcviahZdv/DzA0oRXmeGhcgMMDiFGnixH
   HySy9sSMQtUIN1WPedNGo/HQ4Qq5mI9SXWvQyzy8jZcoqYg5tRqn4sYEJ
   x3OqJeg7wEiu2xMYKQhL1hQCdWKYa6vyEmv4KSwRjD8xsX5U1nueU5nOB
   /d/yvaYnFsR+gNYB3GDtmOdwtg3qMzvSd2fBQA4AynONs4Cie+UbQJUJG
   R5BzWJE6AHJyRpviB12sIgHTBbRX1rl22+2StDnQDg5aiMgGusvW6/dPt
   A==;
X-CSE-ConnectionGUID: YULmrdBYS2uWDQIU9GXo2g==
X-CSE-MsgGUID: 6iZE7dEYSyOLIU0Dhulukw==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18863550"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18863550"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 10:15:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="937085339"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="937085339"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Apr 2024 10:15:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9931FF4; Wed,  3 Apr 2024 20:15:53 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 1/5] spi: pxa2xx: Move number of CS pins validation out of condition
Date: Wed,  3 Apr 2024 20:06:35 +0300
Message-ID: <20240403171550.1074644-2-andriy.shevchenko@linux.intel.com>
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

There is no need to allocate chip_data and then validate number of
CS pins as it will have the same effect. Hence move number of CS pins
validation out of condition in setup().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 1348249f8178..cc0e54f8d2c3 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1200,6 +1200,13 @@ static int setup(struct spi_device *spi)
 		break;
 	}
 
+	if (drv_data->ssp_type == CE4100_SSP) {
+		if (spi_get_chipselect(spi, 0) > 4) {
+			dev_err(&spi->dev, "failed setup: cs number must not be > 4.\n");
+			return -EINVAL;
+		}
+	}
+
 	/* Only allocate on the first setup */
 	chip = spi_get_ctldata(spi);
 	if (!chip) {
@@ -1207,14 +1214,6 @@ static int setup(struct spi_device *spi)
 		if (!chip)
 			return -ENOMEM;
 
-		if (drv_data->ssp_type == CE4100_SSP) {
-			if (spi_get_chipselect(spi, 0) > 4) {
-				dev_err(&spi->dev,
-					"failed setup: cs number must not be > 4.\n");
-				kfree(chip);
-				return -EINVAL;
-			}
-		}
 		chip->enable_dma = drv_data->controller_info->enable_dma;
 		chip->timeout = TIMOUT_DFLT;
 	}
-- 
2.43.0.rc1.1.gbec44491f096


