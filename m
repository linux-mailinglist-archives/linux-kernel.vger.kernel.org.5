Return-Path: <linux-kernel+bounces-25485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EA982D0F6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 15:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 776081F2169B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 14:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF721FBE;
	Sun, 14 Jan 2024 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GCu70Qar"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EC92100;
	Sun, 14 Jan 2024 14:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705243170; x=1736779170;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LjxdR67V7tYCeQiHxVhdjSjgVoL8PIzrrKcwukyWZSQ=;
  b=GCu70Qar8nZTPI52VrH3J2cjzmtQ634TI8FW6ZWDSW5b8BnZ12+H5MA6
   G+XO2mUrLSiRh27jBeJp2cOI3R9sNd26ULTbKFiaRGgHsEMFCGkQigewZ
   4DWDhr6rNgyYBYTHuDv0OBh+y2GqG71nPT6WJsVX8aV+vwsvcY9mdcUId
   S8beCJm0cO5cakkHVeAbWt0Dxk7rZNPPK5wxF1ToR0mKWvz0EaYZIk4nq
   mSc6ywpR+sdX/JbwcWUxe63m0QK/9op/7AcjAuo1u/8ufqLmXuydAQT8G
   +8MOZLamgISyvzAETfWd0f9PEfc5MrZg/7EspqEvIxmW0Sxues/cbIzkF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="465845314"
X-IronPort-AV: E=Sophos;i="6.04,194,1695711600"; 
   d="scan'208";a="465845314"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 06:39:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="1114692658"
X-IronPort-AV: E=Sophos;i="6.04,194,1695711600"; 
   d="scan'208";a="1114692658"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jan 2024 06:39:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 839D72AC; Sun, 14 Jan 2024 16:39:25 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v1 1/1] backlight: hx8357: Fix potential NULL pointer dereference
Date: Sun, 14 Jan 2024 16:39:21 +0200
Message-ID: <20240114143921.550736-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "im" pins are optional. Add missing check in the hx8357_probe().

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/642e1230-3358-4006-a17f-3f297897ae74@moroto.mountain
Fixes: 7d84a63a39b7 ("backlight: hx8357: Convert to agnostic GPIO API")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/video/backlight/hx8357.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/hx8357.c b/drivers/video/backlight/hx8357.c
index d7298376cf74..bf18337ff0c2 100644
--- a/drivers/video/backlight/hx8357.c
+++ b/drivers/video/backlight/hx8357.c
@@ -609,11 +609,13 @@ static int hx8357_probe(struct spi_device *spi)
 	lcd->im_pins = devm_gpiod_get_array_optional(dev, "im", GPIOD_OUT_LOW);
 	if (IS_ERR(lcd->im_pins))
 		return dev_err_probe(dev, PTR_ERR(lcd->im_pins), "failed to request im GPIOs\n");
-	if (lcd->im_pins->ndescs < HX8357_NUM_IM_PINS)
-		return dev_err_probe(dev, -EINVAL, "not enough im GPIOs\n");
+	if (lcd->im_pins) {
+		if (lcd->im_pins->ndescs < HX8357_NUM_IM_PINS)
+			return dev_err_probe(dev, -EINVAL, "not enough im GPIOs\n");
 
-	for (i = 0; i < HX8357_NUM_IM_PINS; i++)
-		gpiod_set_consumer_name(lcd->im_pins->desc[i], "im_pins");
+		for (i = 0; i < HX8357_NUM_IM_PINS; i++)
+			gpiod_set_consumer_name(lcd->im_pins->desc[i], "im_pins");
+	}
 
 	lcdev = devm_lcd_device_register(&spi->dev, "mxsfb", &spi->dev, lcd,
 					&hx8357_ops);
-- 
2.43.0.rc1.1.gbec44491f096


