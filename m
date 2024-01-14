Return-Path: <linux-kernel+bounces-25503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D0082D13B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 16:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 061C71C20E0D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 15:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D862D6D39;
	Sun, 14 Jan 2024 15:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gixEha1f"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78433D65;
	Sun, 14 Jan 2024 15:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705246087; x=1736782087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KtcwDtLKAtATSufVVVCnn6c5MCnYP7WhV++Dk6UXa9k=;
  b=gixEha1f9cr4TByba64mmJewzG5z+e+4cYiXZhbaW+QIoSFmjduCgzob
   qnftY0v7QYFfqJwyt1knS+mjJ6+C1Un7awmgieKkiYWbtOLKGoaSWOauU
   2x3vmo6yakdqwJOZtmjPT4pFPF8fybCmFu/jskDghqXYf09LEcj/I/PH9
   pRBqfXgxNLalqG++LNiKDC98T/vdt+ZxFervB/JM4hVibLGfU1NY551hx
   amMGKaVxLpK6igaa6CZkY2IgOZutjcCYYF4/uwxhJ7Hb3fAvFVWx+ioPv
   IqeVmW8VRgYlSVhuwRk7TESF3HuEoZ5sr0Ud7gZYmgLYFwMxmjjD67aFt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="12835866"
X-IronPort-AV: E=Sophos;i="6.04,194,1695711600"; 
   d="scan'208";a="12835866"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 07:28:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="1030429355"
X-IronPort-AV: E=Sophos;i="6.04,194,1695711600"; 
   d="scan'208";a="1030429355"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 14 Jan 2024 07:28:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 47AC83EA; Sun, 14 Jan 2024 17:28:02 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH v1 3/4] backlight: hx8357: Make use of dev_err_probe()
Date: Sun, 14 Jan 2024 17:25:10 +0200
Message-ID: <20240114152759.1040563-4-andriy.shevchenko@linux.intel.com>
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

Simplify the error handling in probe function by switching from
dev_err() to dev_err_probe().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/video/backlight/hx8357.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/video/backlight/hx8357.c b/drivers/video/backlight/hx8357.c
index 8709d9141cfb..fbe02fd73272 100644
--- a/drivers/video/backlight/hx8357.c
+++ b/drivers/video/backlight/hx8357.c
@@ -579,10 +579,8 @@ static int hx8357_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	ret = spi_setup(spi);
-	if (ret < 0) {
-		dev_err(&spi->dev, "SPI setup failed.\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "SPI setup failed.\n");
 
 	lcd->spi = spi;
 
@@ -617,10 +615,8 @@ static int hx8357_probe(struct spi_device *spi)
 	hx8357_lcd_reset(lcdev);
 
 	ret = init(lcdev);
-	if (ret) {
-		dev_err(&spi->dev, "Couldn't initialize panel\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Couldn't initialize panel\n");
 
 	dev_info(&spi->dev, "Panel probed\n");
 
-- 
2.43.0.rc1.1.gbec44491f096


