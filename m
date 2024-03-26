Return-Path: <linux-kernel+bounces-119661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F087E88CBB1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABBD53270D8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203C513C3CD;
	Tue, 26 Mar 2024 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VNm5xQkK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41A68664C;
	Tue, 26 Mar 2024 18:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476644; cv=none; b=oOIO87Vxa4Bu/jzJnj0JTOzadhMGYji/m/0gujzz5Kt6l6e3JjC22Gt7ktYtVMim+/nmbUjk8YOAtAQMwfF94iNIMaP5lomXrWo+tp3SeIztv/O8QqpxlYtBgeGC2pwBnDURJFJXzmQE+M/6N6xowFubBIIcaueBjqn+Yl8Pen0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476644; c=relaxed/simple;
	bh=/NCY6D6sJSA8qtx+EX1W99OV2q8Lk5IqUKEVfKBSw0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F22aaFFYA/dPQhRgMzetAf/AsVAqzOCkkyD4k/LqqgFoI2U8KSEjAOb8+9i/PWlj60wOdS2UNBNs2w79RF2blEmSkTqVBp90npzflMHjkL0H29w+vKtd2IzLwMux9mhQSeAZf8XBfMT10u3aSBROU/8ehucx1J2w3eq+yJ2L95k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VNm5xQkK; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711476643; x=1743012643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/NCY6D6sJSA8qtx+EX1W99OV2q8Lk5IqUKEVfKBSw0Q=;
  b=VNm5xQkK4YS/xSFfqr6DLvxqq2JixVs52DOLS8cWAGRHgtLeal0QwfJL
   s9Syg5m0rWGIFjcLPa0VvZvjatQdshqSgDdNJtRpkVHRscjalO4OrJhth
   NvUesRCtQVNGq4VY1ZeBbbrEZ9xNCY7PPPun18k/InrTNqkiD8WA2Gay/
   cJlWyG6i3j48qWQE0vLahTsDAS5Y83Q2WSsMSjZso+fMr0HdFn3Pjl379
   Fsx2X2ZARTi7W0vDPxJaJmdWe7Ynm4A8d29bAIII/5KgZNq7N/uCq7lan
   +fBTmGKzoWVnbB87xHe/e3Y4ii6IdcKccYekIo+AtjLb3cw+AoOreu/58
   Q==;
X-CSE-ConnectionGUID: vwvQ+QUaSvibO7eEhUnUzQ==
X-CSE-MsgGUID: 0+f84V86Qeu7uIkjSsXnCw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="10325690"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="10325690"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 11:10:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="937072939"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="937072939"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Mar 2024 11:10:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 015F2643; Tue, 26 Mar 2024 20:10:34 +0200 (EET)
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
Subject: [PATCH v1 04/10] spi: pxa2xx: Extract pxa2xx_spi_init_ssp() helper
Date: Tue, 26 Mar 2024 20:07:54 +0200
Message-ID: <20240326181027.1418989-5-andriy.shevchenko@linux.intel.com>
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


