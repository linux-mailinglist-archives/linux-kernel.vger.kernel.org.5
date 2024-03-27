Return-Path: <linux-kernel+bounces-121902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE63488EF2F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AE45B23BED
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36165152529;
	Wed, 27 Mar 2024 19:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PHFrnOoj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ADD14D6E3;
	Wed, 27 Mar 2024 19:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711567910; cv=none; b=N0T15JZSXyO/eCDkTFBmil/IXFnl9C+iTSzHneOW4W7r8HMkfH34qS/64ckpx76/9dDF84hOjDBytw9IINp23QFqXnk+0WWzqgpk4qEFnLfSNxrUkuZR7++khx5/237N6Y5graPdrIpx/hECyZEoAzzzwSFRad0E0xbFmWGbPLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711567910; c=relaxed/simple;
	bh=/NCY6D6sJSA8qtx+EX1W99OV2q8Lk5IqUKEVfKBSw0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ODP/6roYvojpSx3NxvoQ+lXrdm8qoP1oBhXt5xs0/f7ZC6lLQTW48gStS/UBqfAJxTofgsPD7rquu3wwH0J1hSfVwxfWZnuB242ZKc0KrK1O3JhqOt573ha4E9i97pbEN94gXO2vF9cXb/M7u/T58BYvX4Vw8RTwEn8CWBToKkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PHFrnOoj; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711567908; x=1743103908;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/NCY6D6sJSA8qtx+EX1W99OV2q8Lk5IqUKEVfKBSw0Q=;
  b=PHFrnOojUFYeEOghuBYYfygBG61DCO+XZixbM5jugJN/C+E2DrErS0Ag
   tx3Zl0A/QMYk5mS7feC75JPf9wkTMrgCJFcp7QR0XoeR+8Wjxzgf+44T+
   u9fR780IperdvtREv9BH+1BEBxEVWxSEJXKqxKez9T9qlVwEnJNiFbeGz
   zGxSqf60oEytVsaeEjZIj9itRC7q4UvGgvTQRn7CdUICQt83jhHdqiRRJ
   rrYqaeOQd3wyi5ioSL8bsR3prnCynyN5KEPUGqWa9mylBYJIv7hMZeGQO
   47lsalhtmktXlH8OhsBJQ3G+s2CCMbGWCaVfCbJokmKq/8M7jT+Fat9dJ
   w==;
X-CSE-ConnectionGUID: M8k0y7pzRMaM1fcZl+hPRQ==
X-CSE-MsgGUID: BzUxu8a9QDSTFM7ohgqprQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="24187286"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="24187286"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 12:31:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="937075025"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="937075025"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Mar 2024 12:31:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A15722F0; Wed, 27 Mar 2024 21:31:42 +0200 (EET)
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
Subject: [PATCH v2 3/9] spi: pxa2xx: Extract pxa2xx_spi_init_ssp() helper
Date: Wed, 27 Mar 2024 21:29:22 +0200
Message-ID: <20240327193138.2385910-4-andriy.shevchenko@linux.intel.com>
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

Refactor pxa2xx_spi_init_pdata() by extracting a new
pxa2xx_spi_init_ssp() helper which makes code less
twisted. It will be easier to continue refactoring for
a new coming modification.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 66 +++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 28 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 75d208087748..e7072727c25c 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1314,19 +1314,50 @@ static bool pxa2xx_spi_idma_filter(struct dma_chan *chan, void *param)
 	return param == chan->device->dev;
 }
 
+static int
+pxa2xx_spi_init_ssp(struct platform_device *pdev, struct ssp_device *ssp, enum pxa_ssp_type type)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	int status;
+	u64 uid;
+
+	ssp->mmio_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(ssp->mmio_base))
+		return PTR_ERR(ssp->mmio_base);
+
+	ssp->phys_base = res->start;
+
+	ssp->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(ssp->clk))
+		return PTR_ERR(ssp->clk);
+
+	ssp->irq = platform_get_irq(pdev, 0);
+	if (ssp->irq < 0)
+		return ssp->irq;
+
+	ssp->type = type;
+	ssp->dev = dev;
+
+	status = acpi_dev_uid_to_integer(ACPI_COMPANION(dev), &uid);
+	if (status)
+		ssp->port_id = -1;
+	else
+		ssp->port_id = uid;
+
+	return 0;
+}
+
 static struct pxa2xx_spi_controller *
 pxa2xx_spi_init_pdata(struct platform_device *pdev)
 {
 	struct pxa2xx_spi_controller *pdata;
 	struct device *dev = &pdev->dev;
 	struct device *parent = dev->parent;
-	struct ssp_device *ssp;
-	struct resource *res;
 	enum pxa_ssp_type type = SSP_UNDEFINED;
 	const void *match;
 	bool is_lpss_priv;
 	int status;
-	u64 uid;
 
 	is_lpss_priv = platform_get_resource_byname(pdev, IORESOURCE_MEM, "lpss_priv");
 
@@ -1351,14 +1382,6 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	if (!pdata)
 		return ERR_PTR(-ENOMEM);
 
-	ssp = &pdata->ssp;
-
-	ssp->mmio_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
-	if (IS_ERR(ssp->mmio_base))
-		return ERR_CAST(ssp->mmio_base);
-
-	ssp->phys_base = res->start;
-
 	/* Platforms with iDMA 64-bit */
 	if (is_lpss_priv) {
 		pdata->tx_param = parent;
@@ -1366,28 +1389,15 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 		pdata->dma_filter = pxa2xx_spi_idma_filter;
 	}
 
-	ssp->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(ssp->clk))
-		return ERR_CAST(ssp->clk);
-
-	ssp->irq = platform_get_irq(pdev, 0);
-	if (ssp->irq < 0)
-		return ERR_PTR(ssp->irq);
-
-	ssp->type = type;
-	ssp->dev = dev;
-
-	status = acpi_dev_uid_to_integer(ACPI_COMPANION(dev), &uid);
-	if (status)
-		ssp->port_id = -1;
-	else
-		ssp->port_id = uid;
-
 	pdata->is_target = device_property_read_bool(dev, "spi-slave");
 	pdata->num_chipselect = 1;
 	pdata->enable_dma = true;
 	pdata->dma_burst_size = 1;
 
+	status = pxa2xx_spi_init_ssp(pdev, &pdata->ssp, type);
+	if (status)
+		return ERR_PTR(status);
+
 	return pdata;
 }
 
-- 
2.43.0.rc1.1.gbec44491f096


