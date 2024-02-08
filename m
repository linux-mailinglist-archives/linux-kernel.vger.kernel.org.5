Return-Path: <linux-kernel+bounces-58548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5BF84E7E8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A18CD1C24908
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9367628DCA;
	Thu,  8 Feb 2024 18:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I5aRwLhK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBBE2377B;
	Thu,  8 Feb 2024 18:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707417806; cv=none; b=sRXE4mwYOthdX8Qrd3yQFHS4zqiMEjIupdcvloRn+pBHWB/MY3Ej40MEPNyjTmH7i144wIQ0NEkqzRmevJ+jq6iRLS0lo25V7cl6UOGO4dnINlekZom6ZAeYsvjJ7eRFtc02yPzgh8EqX1ZCOHbdW5MbH03GaNUVHvPoVqf7qpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707417806; c=relaxed/simple;
	bh=R8VW3vdNVBtgOG4uxMk33o384NOmy+Axf/iYx44RjkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XmCnHO9SajiWAbmKjqX6BEjXUL7SdzBUfTLDFLOuX0+IqcuiFphfCTCSq17H20PyVhek1rCq9iOzdgrKRD7qfRjU3Z8x8xTjVX0dulyZ3c8kVIENB4/qEif8QAu327axsUMku9hsZc9B6vdjeB/TD27cfunAwPPaOU1s1OOxDKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I5aRwLhK; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707417805; x=1738953805;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R8VW3vdNVBtgOG4uxMk33o384NOmy+Axf/iYx44RjkM=;
  b=I5aRwLhKkYkDtKLnkUJ7d9CFAlZXjXYNuQucneKAlsz9RKWE7C+Wx/qN
   Qsiqwkm9rYDbUJx5sqSyGDx1+yvy5pYA1b/O96fKTc+6q5aNmXKc5fXP6
   WPUuhF0STqTpbfTA/Sq8g3K4pYFyU4NKOVubcG5M6I+fvRJW/Qtr67Sl8
   h1nVTeIvHzQw3cjVakB7fbk99C2Z/CCOhw6sT4CwcFe05jSOPhCXHQk+I
   IGa/KZavGDtonsGq+BIN47+QJ7WZYlwm8e9DTSSnTodvlF+/DGKJIyRhX
   IOh3ifIoWwDplI43ZkD1NeZ6hreBvDpM4EiBkQBqvUhfppnmPoAVwLZS+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1184696"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1184696"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:43:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934213721"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="934213721"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2024 10:43:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 40C421FF; Thu,  8 Feb 2024 20:43:16 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Daniel Thompson <daniel.thompson@linaro.org>,
	Flavio Suligoi <f.suligoi@asem.it>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH v3 2/3] backlight: mp3309c: use dev_err_probe() instead of dev_err()
Date: Thu,  8 Feb 2024 20:42:27 +0200
Message-ID: <20240208184313.2224579-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240208184313.2224579-1-andriy.shevchenko@linux.intel.com>
References: <20240208184313.2224579-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace dev_err() with dev_err_probe().

This helps in simplifing code and standardizing the error output.

Tested-by: Flavio Suligoi <f.suligoi@asem.it>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/video/backlight/mp3309c.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/video/backlight/mp3309c.c b/drivers/video/backlight/mp3309c.c
index 397f35dafc5e..426e9f2356ad 100644
--- a/drivers/video/backlight/mp3309c.c
+++ b/drivers/video/backlight/mp3309c.c
@@ -208,10 +208,8 @@ static int mp3309c_parse_fwnode(struct mp3309c_chip *chip,
 	unsigned int num_levels, tmp_value;
 	struct device *dev = chip->dev;
 
-	if (!dev_fwnode(dev)) {
-		dev_err(dev, "failed to get firmware node\n");
-		return -ENODEV;
-	}
+	if (!dev_fwnode(dev))
+		return dev_err_probe(dev, -ENODEV, "failed to get firmware node\n");
 
 	/*
 	 * Dimming mode: the MP3309C provides two dimming control mode:
@@ -287,8 +285,7 @@ static int mp3309c_parse_fwnode(struct mp3309c_chip *chip,
 	if (ret)
 		pdata->default_brightness = pdata->max_brightness;
 	if (pdata->default_brightness > pdata->max_brightness) {
-		dev_err(chip->dev,
-			"default brightness exceeds max brightness\n");
+		dev_err_probe(dev, -ERANGE, "default brightness exceeds max brightness\n");
 		pdata->default_brightness = pdata->max_brightness;
 	}
 
@@ -329,16 +326,15 @@ static int mp3309c_parse_fwnode(struct mp3309c_chip *chip,
 
 static int mp3309c_probe(struct i2c_client *client)
 {
-	struct mp3309c_platform_data *pdata = dev_get_platdata(&client->dev);
+	struct device *dev = &client->dev;
+	struct mp3309c_platform_data *pdata = dev_get_platdata(dev);
 	struct mp3309c_chip *chip;
 	struct backlight_properties props;
 	struct pwm_state pwmstate;
 	int ret;
 
-	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
-		dev_err(&client->dev, "failed to check i2c functionality\n");
-		return -EOPNOTSUPP;
-	}
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return dev_err_probe(dev, -EOPNOTSUPP, "failed to check i2c functionality\n");
 
 	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
-- 
2.43.0.rc1.1.gbec44491f096


