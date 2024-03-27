Return-Path: <linux-kernel+bounces-121906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE9C88EF36
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60D48B24855
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E491534EC;
	Wed, 27 Mar 2024 19:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IzIxRQdM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC2715252A;
	Wed, 27 Mar 2024 19:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711567912; cv=none; b=fT5VjcJoSDy+jYBnGJyq7PXiVBsW9+42SLeRZ7ul6/6HaNjrwnOK8P4CiZiRVQdMBNQlv1S2PRBu+cV9tixqsX4YFUeqFGK4Qn4vSmCbOzHws6wxvQzXCiaPfYcYED2zZF8X6ia67VykffWtpZeeRRulo1p+kzVGc37qXzPdJyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711567912; c=relaxed/simple;
	bh=lzLjtivrQxAS+WqTg89dinGS46hcsyGbp0QSkCiy2Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozhBjYPNDgrIeGLUo33Uo18nRxqhWhtdX1Z7K1XsO/E5itVvXchoDJnODhmt3k287QK8EeDU9nv8a4Cg7KFdCjL6NxYkU2r0LWXZIG/D5IQs5ue+CGU+Q68vyZ/nJfe/yVeiIQguugG+XkyWaS9iI5bbvXEjoPvHdz8+7Up0CYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IzIxRQdM; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711567910; x=1743103910;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lzLjtivrQxAS+WqTg89dinGS46hcsyGbp0QSkCiy2Ns=;
  b=IzIxRQdMMqmuVjlIbFYhylGaDuRGNkkO1PZtV9Bv/Lca2vvwDueVJw2S
   NtiUReIBdg4BYzcUNXIy6e2hQiio7RHiQUE4xz2qcFzbna+ttv+lt1Erg
   WehSkxtkHKl8cWZ8BWBc0puFhgTk+z2kqSeUHBiguWlLGfJ6CLi3l7+Ip
   U8WMQABlJ5RElH/e+d1AdFN8B1JKFDu8NWXLcKxseCjhH/2BkjoF0xZ1W
   nQVQpkGWGscHe+1qvOTgVY3J+01Clf1ydOimtJPuCd1W3Ky5she2FC3/k
   mab8i7sGEEY/BA/rKdblI2+xm6hdZX6IxsGmP1XVGmZg+HhXAhdwq8PV3
   A==;
X-CSE-ConnectionGUID: aOvVydyZT3WuJjS3NKcd8A==
X-CSE-MsgGUID: 7CZ0QEtXQfaso0uLwMUjsQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="24187337"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="24187337"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 12:31:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="937075028"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="937075028"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Mar 2024 12:31:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C04E2643; Wed, 27 Mar 2024 21:31:42 +0200 (EET)
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
Subject: [PATCH v2 5/9] spi: pxa2xx: Allow number of chip select pins to be read from property
Date: Wed, 27 Mar 2024 21:29:24 +0200
Message-ID: <20240327193138.2385910-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240327193138.2385910-1-andriy.shevchenko@linux.intel.com>
References: <20240327193138.2385910-1-andriy.shevchenko@linux.intel.com>
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


