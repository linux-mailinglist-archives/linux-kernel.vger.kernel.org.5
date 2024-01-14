Return-Path: <linux-kernel+bounces-25505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EED2282D13D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 16:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A371B1F2178F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 15:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364B7CA69;
	Sun, 14 Jan 2024 15:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P6vUiQ/z"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E94524B;
	Sun, 14 Jan 2024 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705246088; x=1736782088;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HHwu/+ttKG6+gQ16tPnQoTnLOBcKuPt3xGBj8B08rW8=;
  b=P6vUiQ/z8+ClUM7MsCyEGN1OUnmuQNa+KxhMopg0SkJM7RyQ1FN1GqF3
   Ex1g8eIOQ9PaRBJcqw1TcR+o+ZsZwyxbwVsqoPSIasDp/waa+jcW+hplO
   d7sYUA+ThVp8OJjgm4p13DLOqskf2zNKPLb2O8Cv1g9tIcuM0TZWru2xe
   HeV1jOnkYfdogEmVIIAyUR8GU6wjumRzPs/ioJT2RytNlhyxEg+jC/gLY
   S37Sa0beihIys/vdVatI5QWqxFp6C/sYqRX2yvA7M+QVYp46WW0QvGVV5
   4NVvBnJwR4x7ppM9i1W0JACCBHYzZk/8p6F4NPfkHw74IlfKSlpmiQnYW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="6829681"
X-IronPort-AV: E=Sophos;i="6.04,194,1695711600"; 
   d="scan'208";a="6829681"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 07:28:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="956601547"
X-IronPort-AV: E=Sophos;i="6.04,194,1695711600"; 
   d="scan'208";a="956601547"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 14 Jan 2024 07:28:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4D3D039B; Sun, 14 Jan 2024 17:28:02 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH v1 4/4] backlight: hx8357: Utilise temporary variable for struct device
Date: Sun, 14 Jan 2024 17:25:11 +0200
Message-ID: <20240114152759.1040563-5-andriy.shevchenko@linux.intel.com>
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

We have a temporary variable to keep pointer to struct device.
Utilise it inside the ->probe() implementation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/video/backlight/hx8357.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/hx8357.c b/drivers/video/backlight/hx8357.c
index fbe02fd73272..e4dc76f25f8e 100644
--- a/drivers/video/backlight/hx8357.c
+++ b/drivers/video/backlight/hx8357.c
@@ -574,7 +574,7 @@ static int hx8357_probe(struct spi_device *spi)
 	hx8357_init init;
 	int i, ret;
 
-	lcd = devm_kzalloc(&spi->dev, sizeof(*lcd), GFP_KERNEL);
+	lcd = devm_kzalloc(dev, sizeof(*lcd), GFP_KERNEL);
 	if (!lcd)
 		return -ENOMEM;
 
@@ -604,8 +604,7 @@ static int hx8357_probe(struct spi_device *spi)
 			gpiod_set_consumer_name(lcd->im_pins->desc[i], "im_pins");
 	}
 
-	lcdev = devm_lcd_device_register(&spi->dev, "mxsfb", &spi->dev, lcd,
-					&hx8357_ops);
+	lcdev = devm_lcd_device_register(dev, "mxsfb", dev, lcd, &hx8357_ops);
 	if (IS_ERR(lcdev)) {
 		ret = PTR_ERR(lcdev);
 		return ret;
@@ -618,7 +617,7 @@ static int hx8357_probe(struct spi_device *spi)
 	if (ret)
 		return dev_err_probe(dev, ret, "Couldn't initialize panel\n");
 
-	dev_info(&spi->dev, "Panel probed\n");
+	dev_info(dev, "Panel probed\n");
 
 	return 0;
 }
-- 
2.43.0.rc1.1.gbec44491f096


