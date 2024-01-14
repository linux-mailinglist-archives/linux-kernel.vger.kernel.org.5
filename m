Return-Path: <linux-kernel+bounces-25502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1C882D137
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 16:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BECB282227
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 15:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C15539C;
	Sun, 14 Jan 2024 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k5CtHXcP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848A32581;
	Sun, 14 Jan 2024 15:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705246086; x=1736782086;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2P1HUQEL9BH9iq7NRkO7iC2HHKfx0MlaeZdmt4UObTc=;
  b=k5CtHXcPKs5UZh4vG/xKnxY5aMXq/idlYz7640AsZXFkSPxy2NAGknkC
   GFI3aMs74hH64Ot9UYkTdeLBdco5Y4ziEap0AeKUMozioYCPqIPKRegQj
   DHTD0383RYzSwreClcFXoBDPjOVMDVoYkxWF962zy3743JTK0qcH31q4u
   2Lccl5mfY30HLsnL93wW3KtG4Vr4tQE1zJQbJz2OXgO/il9zsmGB/O9Ai
   gKtbMOcy5aXCy1mntIkiTxT8j4bJe9uK+cHqOQzxJg65f0u8f13r4SvAW
   1NzIRjAYY7aSNSeB6XLoe/Xv+RZiE3m8JTsmpXtRD+QILUaVxZTTU4/lu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="6829674"
X-IronPort-AV: E=Sophos;i="6.04,194,1695711600"; 
   d="scan'208";a="6829674"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 07:28:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="956601546"
X-IronPort-AV: E=Sophos;i="6.04,194,1695711600"; 
   d="scan'208";a="956601546"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 14 Jan 2024 07:28:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 239071A3; Sun, 14 Jan 2024 17:28:02 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH v1 1/4] backlight: hx8357: Make use of device properties
Date: Sun, 14 Jan 2024 17:25:08 +0200
Message-ID: <20240114152759.1040563-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240114152759.1040563-1-andriy.shevchenko@linux.intel.com>
References: <20240114152759.1040563-1-andriy.shevchenko@linux.intel.com>
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

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/video/backlight/hx8357.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/video/backlight/hx8357.c b/drivers/video/backlight/hx8357.c
index bf18337ff0c2..c7fd10d55c5d 100644
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
 
+typedef int (*hx8357_init)(struct lcd_device *);
+
 static const struct of_device_id hx8357_dt_ids[] = {
 	{
 		.compatible = "himax,hx8357",
@@ -582,7 +584,7 @@ static int hx8357_probe(struct spi_device *spi)
 	struct device *dev = &spi->dev;
 	struct lcd_device *lcdev;
 	struct hx8357_data *lcd;
-	const struct of_device_id *match;
+	hx8357_init init;
 	int i, ret;
 
 	lcd = devm_kzalloc(&spi->dev, sizeof(*lcd), GFP_KERNEL);
@@ -597,8 +599,8 @@ static int hx8357_probe(struct spi_device *spi)
 
 	lcd->spi = spi;
 
-	match = of_match_device(hx8357_dt_ids, &spi->dev);
-	if (!match || !match->data)
+	init = device_get_match_data(dev);
+	if (!init)
 		return -EINVAL;
 
 	lcd->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
@@ -627,7 +629,7 @@ static int hx8357_probe(struct spi_device *spi)
 
 	hx8357_lcd_reset(lcdev);
 
-	ret = ((int (*)(struct lcd_device *))match->data)(lcdev);
+	ret = init(lcdev);
 	if (ret) {
 		dev_err(&spi->dev, "Couldn't initialize panel\n");
 		return ret;
-- 
2.43.0.rc1.1.gbec44491f096


