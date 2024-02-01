Return-Path: <linux-kernel+bounces-48360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B117C845AE4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C2022939EF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7673162168;
	Thu,  1 Feb 2024 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mokQ+Tka"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0535F494;
	Thu,  1 Feb 2024 15:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800007; cv=none; b=LJfw5jcw449tlc219mVFIR5hLgKi7qk3BJMyNkBzZfhW3eXne+ZGjihEN8sKddufte56OS0QCybm++Gko6GS6TLjduPgUD/QXMGEpiMHPDknr9COS/eJ9heNrRRrGMacreHFuBn/nN6T8ldVl6v2uU+dFae1QPmwM4ZPzUD1EuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800007; c=relaxed/simple;
	bh=owxSNrvDkg3gD50cec2iQ+m3WCWKt4TbmkW4j3XR5ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pXz0OqZLyVp0kQNkUXYuwm6IPQkR5vdICjv6rGMNIy1Bxlhle4vj2qI4UgZy3ptT22J1Xo+bde9iYWZC4uVp1s8Tqs1Xl/YM+B5bxrzLyyk0io7eF2zxDud4aRa6s2ZqAKV1RaDpNw0afahTbnZOCvYMtYLXz/vJ8Gji6hg188g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mokQ+Tka; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706800006; x=1738336006;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=owxSNrvDkg3gD50cec2iQ+m3WCWKt4TbmkW4j3XR5ow=;
  b=mokQ+Tkaa4s4+O29luDCr7zIUxriHwR6W5OuZ8ygz4o/ertOjqB7PkQk
   j4we5K7nJv5E+OjqEz0nwMVosVbhKC8aevHfLhRFLSTWMZHXtlwcdO0IQ
   zjf3MBXw5WNrVdzrOSpe+/ParfdKbBDMp5NsuqLGXMnJKKAi5FTVFH1OF
   53Al2VrVUo0olhAJZN2lQzHKsVCtmsikaVC7qIhC0DqpwgMbU1U6o5EHd
   PvBQvsKrqwKeDwVJBGSYaoolvCLw6nWplLfbrX3yp347obY5EdQ4VG0x/
   sEbioocg885EhniutOaIM+6LtTUeoTYsu4X5tjikQZ5u9mJgB7A3xxbkF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="403525484"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="403525484"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 07:06:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="859168148"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="859168148"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 01 Feb 2024 07:06:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 19175BA3; Thu,  1 Feb 2024 16:49:53 +0200 (EET)
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
Subject: [PATCH v2 4/4] backlight: hx8357: Utilise temporary variable for struct device
Date: Thu,  1 Feb 2024 16:47:45 +0200
Message-ID: <20240201144951.294215-5-andriy.shevchenko@linux.intel.com>
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

We have a temporary variable to keep pointer to struct device.
Utilise it inside the ->probe() implementation.

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/video/backlight/hx8357.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/hx8357.c b/drivers/video/backlight/hx8357.c
index 70a62755805a..339d9128fbde 100644
--- a/drivers/video/backlight/hx8357.c
+++ b/drivers/video/backlight/hx8357.c
@@ -574,7 +574,7 @@ static int hx8357_probe(struct spi_device *spi)
 	hx8357_init_fn init_fn;
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


