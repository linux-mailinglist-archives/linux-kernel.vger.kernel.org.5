Return-Path: <linux-kernel+bounces-48406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CA5845B87
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57FAA1C2625C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D522A779E1;
	Thu,  1 Feb 2024 15:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MquRwpcH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B04779E0;
	Thu,  1 Feb 2024 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801206; cv=none; b=edJK5fuD8NbH9K4qf/nSPIjw2t8JAHERnp7sCHs38TJnxrZ3CSVr0ut2QD3Y7lZoG4I8SZ0isK7c8Nwm9LSsvnfL/wUHch++5Ug5aHC31NWwvCnkmqds/hz2WuHHs9asD/YInXU7eNbw4DmVo7lkZzTWajwBORSL44/IkBQM7H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801206; c=relaxed/simple;
	bh=P7V8arI0O5w8uxp8JSCtlJ4wD8r1rt7mth6lt0GJXKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s713L4ZHqvcjUW1SpZFrAAV96EQE3liSjcFJs35y9m4MOQQRgoj9QqG/cVcEBrIV8FcjC4mbfLhAaXZ465oCxSU6v1EuB8uir+s45Smk3OwU41DE6TwnBSBmjFmyLdEoHd219XGLmciIh8Ealshowl2ct6Yvv/d5YlFVkungd2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MquRwpcH; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706801204; x=1738337204;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P7V8arI0O5w8uxp8JSCtlJ4wD8r1rt7mth6lt0GJXKE=;
  b=MquRwpcHV2Y+NXWBkVSMHDNiU3jdsiONq0+h0o85jC4HlE1viEI8lWC/
   MFtCbSqGiGWGynBeZAxtGK9ZVOqCB400LOhi7ZwzeUh4n3fQa5Szj0od2
   Ei4ZdRFaqxjRTVW8s0UcnjgVYsFLhxgn7C3N2/x0RqZEDs3KeoFNlUUcR
   iQMMh+b3s3BrpQzeZy4LmJs+XliuUP13GYaDHHnOda7hprYEQt4mIXD0w
   UizpvNktAseB56hO3hD9sLJTxZRkrds4YSaRq6LTLM0gieslUiKvn8xiZ
   z5ZxZAMcDTQ/N4tYCfdnLMNyWphCQywAzKrHQpRNljw6Qb7P31e+iDt7a
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="140708"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="140708"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 07:26:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="908275360"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="908275360"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 01 Feb 2024 07:26:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id ED67B9FD; Thu,  1 Feb 2024 16:49:52 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v2 1/4] backlight: hx8357: Make use of device properties
Date: Thu,  1 Feb 2024 16:47:42 +0200
Message-ID: <20240201144951.294215-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240201144951.294215-1-andriy.shevchenko@linux.intel.com>
References: <20240201144951.294215-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the module to be property provider agnostic and allow
it to be used on non-OF platforms.

Include mod_devicetable.h explicitly to replace the dropped of.h
which included mod_devicetable.h indirectly.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/video/backlight/hx8357.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/video/backlight/hx8357.c b/drivers/video/backlight/hx8357.c
index bf18337ff0c2..ac65609e5d84 100644
--- a/drivers/video/backlight/hx8357.c
+++ b/drivers/video/backlight/hx8357.c
@@ -8,9 +8,9 @@
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/lcd.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/property.h>
 #include <linux/spi/spi.h>
 
 #define HX8357_NUM_IM_PINS	3
@@ -564,6 +564,8 @@ static struct lcd_ops hx8357_ops = {
 	.get_power	= hx8357_get_power,
 };
 
+typedef int (*hx8357_init_fn)(struct lcd_device *);
+
 static const struct of_device_id hx8357_dt_ids[] = {
 	{
 		.compatible = "himax,hx8357",
@@ -582,7 +584,7 @@ static int hx8357_probe(struct spi_device *spi)
 	struct device *dev = &spi->dev;
 	struct lcd_device *lcdev;
 	struct hx8357_data *lcd;
-	const struct of_device_id *match;
+	hx8357_init_fn init_fn;
 	int i, ret;
 
 	lcd = devm_kzalloc(&spi->dev, sizeof(*lcd), GFP_KERNEL);
@@ -597,8 +599,8 @@ static int hx8357_probe(struct spi_device *spi)
 
 	lcd->spi = spi;
 
-	match = of_match_device(hx8357_dt_ids, &spi->dev);
-	if (!match || !match->data)
+	init_fn = device_get_match_data(dev);
+	if (!init_fn)
 		return -EINVAL;
 
 	lcd->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
@@ -627,7 +629,7 @@ static int hx8357_probe(struct spi_device *spi)
 
 	hx8357_lcd_reset(lcdev);
 
-	ret = ((int (*)(struct lcd_device *))match->data)(lcdev);
+	ret = init_fn(lcdev);
 	if (ret) {
 		dev_err(&spi->dev, "Couldn't initialize panel\n");
 		return ret;
-- 
2.43.0.rc1.1.gbec44491f096


