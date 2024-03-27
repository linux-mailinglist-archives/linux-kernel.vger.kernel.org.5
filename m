Return-Path: <linux-kernel+bounces-121903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E626388EF30
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07A6B1C2E6A5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C929B152DE1;
	Wed, 27 Mar 2024 19:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SF+XflXm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D4515250B;
	Wed, 27 Mar 2024 19:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711567911; cv=none; b=q9aaXb3++5Ad8uQjxfX8q+E3IHrokmxcEmnT3uldS+oYQKJwVcjozZNfY3L+bfwhANpeG6yIaWcnOJ4dtOm8idOK+Cqqo0pp87KMPNtPDT81vuGQn9VqK/qJvFp9hLFgplhlNQR721eIfPfVwxfrRwpThQNPUyRCVWh787R+YSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711567911; c=relaxed/simple;
	bh=jFzgo5+g95yyxQjjsoDzp1sVeyMA6hDbVV6LnWCwoqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxnXuArZvD1KGLnxwzUsBjvD2/lYI3ASg9DLaO3VewHe3n+v34rxEZde6DjKVp9jYqjevuXt60eVyVMv6c4VgLZ/9lOgo3BBX40WWvq5RRi5IIGYbcgcGbhDKdSXR/mrpEVWDegiiEimqvgL5uZqoyYhUhup1GeUjxDyeFSmThg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SF+XflXm; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711567909; x=1743103909;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jFzgo5+g95yyxQjjsoDzp1sVeyMA6hDbVV6LnWCwoqk=;
  b=SF+XflXmuBkbet4ftEMXMWxInBSFXpIZ5EETV2+fO9H7iCCPD14lqAAT
   q4UDLdkINK7C3tsgL5zSMuJyFnvKyfLXJ8pSDMrn41jqcpPZW9wIDBQrh
   t0sVkQKghEpkEYGSWFbW5qifpR0EwKTs8a3bDcGaX+D31eDOAU+3fQycr
   s+DYyzZRIUi7wy1fi7cMGnNAheNSf5LBPmQ4EupiMF6P15ekxv07FmS4+
   GpYTErGmbBarB8T2x9gXg11hZ8+6pIMmh646hieWtw8MOPrr5hTt2DeyV
   XiGoEXt+Gz5rVavLKa+9SYcSxlYsUIR7NVrlyO6Uha96o/m/0H5BJp59I
   w==;
X-CSE-ConnectionGUID: bTjCszQ8RfGsYp8ISDhKag==
X-CSE-MsgGUID: ky3U/v/dSEa8kMnX0JTwrQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="24187296"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="24187296"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 12:31:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="937075024"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="937075024"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Mar 2024 12:31:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id AB9E9524; Wed, 27 Mar 2024 21:31:42 +0200 (EET)
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
Subject: [PATCH v2 4/9] spi: pxa2xx: Skip SSP initialization if it's done elsewhere
Date: Wed, 27 Mar 2024 21:29:23 +0200
Message-ID: <20240327193138.2385910-5-andriy.shevchenko@linux.intel.com>
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

If SSP has been enumerated elsewhere, skip its initialization
in pxa2xx_spi_init_pdata().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index e7072727c25c..b01a18c89b6b 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1355,6 +1355,7 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device *parent = dev->parent;
 	enum pxa_ssp_type type = SSP_UNDEFINED;
+	struct ssp_device *ssp = NULL;
 	const void *match;
 	bool is_lpss_priv;
 	int status;
@@ -1372,6 +1373,10 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 			return ERR_PTR(status);
 
 		type = (enum pxa_ssp_type)value;
+	} else {
+		ssp = pxa_ssp_request(pdev->id, pdev->name);
+		if (ssp)
+			type = ssp->type;
 	}
 
 	/* Validate the SSP type correctness */
@@ -1394,6 +1399,10 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	pdata->enable_dma = true;
 	pdata->dma_burst_size = 1;
 
+	/* If SSP has been already enumerated, use it */
+	if (ssp)
+		return pdata;
+
 	status = pxa2xx_spi_init_ssp(pdev, &pdata->ssp, type);
 	if (status)
 		return ERR_PTR(status);
-- 
2.43.0.rc1.1.gbec44491f096


