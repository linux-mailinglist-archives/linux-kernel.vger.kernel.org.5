Return-Path: <linux-kernel+bounces-119662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF25C88CBB2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2201F845FE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9492113C9B6;
	Tue, 26 Mar 2024 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WhOsABV4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE20126F14;
	Tue, 26 Mar 2024 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476644; cv=none; b=hh01NlbAE7uZ2NJ5HqdiVzdImnWiuVnBNl7COimYaStSagPkr3PfrAHX6ypkQL6XPb2IQjxGTGrxEDgDTd9Et1c7xezvTeLWSXTlVe3KLbSs9mWCuwfMitdNhr9gXa/beVx5I8/IZyqw2i+RVN0OlsF6zeOnZpVghqx/+v5FKDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476644; c=relaxed/simple;
	bh=lzLjtivrQxAS+WqTg89dinGS46hcsyGbp0QSkCiy2Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OQnagieqQ0ZVZmOVcSFDixd4VWHE7+0PflLkTSee0Mg7IAiWflo8apyiHxh0/ii8MAo8j7Pszq1sIM06Yr1mXwZQgtjqxK4J9NfKH9qJO3CiAHS4Rq1lXzTHjaJZXIz+mbmn6U7vXXc29HGe3McTADhrGnUuQiP6lu0hQ4I2ESc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WhOsABV4; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711476643; x=1743012643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lzLjtivrQxAS+WqTg89dinGS46hcsyGbp0QSkCiy2Ns=;
  b=WhOsABV4zCqcgt58LYvl0Mt6DKVzQobLScubNdyWiJ0NkKboIrAY/WY/
   tJ8LPufZ7jfXyR275V9aOJMzC2oLzGIZ3hObZTMc976KIaOGH5DANzO2b
   soX6S9rbvaMxb/n19sI+VOyD9jZA+Vx61iskn7umu6EzHWJiISCaEOdzg
   X7BlO9A6se4CDozSAZJsRFyKxTGGRHqfL/XHhx7v6tGEKqsUUKfaWkyqu
   uApysZ4N3EwMWoiB0zi6mjKlmEc4SoHhtLWRz3eXqqIq2SDjTYOfiDYKB
   J+NVwWDN9rfp5Y5Q5KhlwJ6/kGHG/cBEulq6l6JqjMrTosWtnMtvjuljE
   g==;
X-CSE-ConnectionGUID: 6kDXFBCGRBWat5aZGPX0YA==
X-CSE-MsgGUID: +z+l5Fv9Tj6/EXkImhO0nw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="10325699"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="10325699"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 11:10:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="937072940"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="937072940"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Mar 2024 11:10:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1A1D25A8; Tue, 26 Mar 2024 20:10:35 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH v1 06/10] spi: pxa2xx: Allow number of chip select pins to be read from property
Date: Tue, 26 Mar 2024 20:07:56 +0200
Message-ID: <20240326181027.1418989-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240326181027.1418989-1-andriy.shevchenko@linux.intel.com>
References: <20240326181027.1418989-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some cases the number of the chip select pins might come from
the device property. Allow driver to use it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index b01a18c89b6b..f4435c39d096 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1358,6 +1358,7 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	struct ssp_device *ssp = NULL;
 	const void *match;
 	bool is_lpss_priv;
+	u32 num_cs = 1;
 	int status;
 
 	is_lpss_priv = platform_get_resource_byname(pdev, IORESOURCE_MEM, "lpss_priv");
@@ -1394,8 +1395,11 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 		pdata->dma_filter = pxa2xx_spi_idma_filter;
 	}
 
+	/* Read number of chip select pins, if provided */
+	device_property_read_u32(dev, "num-cs", &num_cs);
+
+	pdata->num_chipselect = num_cs;
 	pdata->is_target = device_property_read_bool(dev, "spi-slave");
-	pdata->num_chipselect = 1;
 	pdata->enable_dma = true;
 	pdata->dma_burst_size = 1;
 
-- 
2.43.0.rc1.1.gbec44491f096


