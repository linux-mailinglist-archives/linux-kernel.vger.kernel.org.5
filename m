Return-Path: <linux-kernel+bounces-48537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80251845D58
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9C321F27FF4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038564C79;
	Thu,  1 Feb 2024 16:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a6zOFB0Y"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184364C6C;
	Thu,  1 Feb 2024 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706805235; cv=none; b=lbnAhJSXsSq9PwPEH1xdi5cMoRq7olYqYW/V9VrFyzcLJvfPDfOvzx2O1YIZ7evEheE/rAMuxx9G8vq31KDb16m5srrKWY21tRp5BDNQMvMiTmiasFdAavbjoWMlkOgB+M9tg9itv8TAeoz6eN0An6kK8lwS1Y9Ww7RwmceuN6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706805235; c=relaxed/simple;
	bh=Y4tGleDCKLWtxFwW/vft+m/ukBpChbYl89eQXzMV72U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FnjqWufN4tUas0/aivIHPHuR+uy5acHsIxeWJimZk+Fx2XAKrVyAJihKd7c2l97pMTyK4sHm/x7daJodbYmjtzNzSJhXOpsGBv5CoXLKbNnmgHKbMGmZe7aqZcsP14+j/cb4iYNravYS63l7iKHA5ypDUah4BX8Wrg/AEpdtynI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a6zOFB0Y; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706805233; x=1738341233;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y4tGleDCKLWtxFwW/vft+m/ukBpChbYl89eQXzMV72U=;
  b=a6zOFB0YS7Xb50kcscGV0/RRu/D6+hjzoZtuEsRPxizC0n/QrHTbHNsv
   HBFGnwnbHN3p2p8yuTH0t3hMoygjN92CPqu8KXqXxcETdVGo/Io+BkFph
   wqPzLfjV6NANyF7qhgPEhAk+yZWpPycHSX230pMZApcvliWe/5j0NPO3D
   3+r8zWksdCiNaLVbAPHmmnMnxAgGtN7QFCFBIG4KKawyJLCHAq1n4QT1z
   nQIpMknsG/FEbOSEcGokczCpcafs0+sQbxNLJBLnIIcUKkU/zHh0Jb4Rg
   Op+3/pJKqH+vi2zFMu0kMoiSaLYZOMQ43uw6Pp9q9EbK6u3cHG6BKluT9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="468167634"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="468167634"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 08:31:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="908292478"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="908292478"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 01 Feb 2024 08:31:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DEA06C41; Thu,  1 Feb 2024 17:15:42 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Flavio Suligoi <f.suligoi@asem.it>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH v2 3/3] backlight: mp3309c: Utilise temporary variable for struct device
Date: Thu,  1 Feb 2024 17:14:15 +0200
Message-ID: <20240201151537.367218-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240201151537.367218-1-andriy.shevchenko@linux.intel.com>
References: <20240201151537.367218-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have a temporary variable to keep pointer to struct device.
Utilise it where it makes sense.

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Tested-by: Flavio Suligoi <f.suligoi@asem.it>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/video/backlight/mp3309c.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/video/backlight/mp3309c.c b/drivers/video/backlight/mp3309c.c
index 2d6bd1a180b3..e7abefd175a4 100644
--- a/drivers/video/backlight/mp3309c.c
+++ b/drivers/video/backlight/mp3309c.c
@@ -222,10 +222,9 @@ static int mp3309c_parse_fwnode(struct mp3309c_chip *chip,
 	 */
 	pdata->dimming_mode = DIMMING_ANALOG_I2C;
 	if (device_property_present(dev, "pwms")) {
-		chip->pwmd = devm_pwm_get(chip->dev, NULL);
+		chip->pwmd = devm_pwm_get(dev, NULL);
 		if (IS_ERR(chip->pwmd))
-			return dev_err_probe(chip->dev, PTR_ERR(chip->pwmd),
-					     "error getting pwm data\n");
+			return dev_err_probe(dev, PTR_ERR(chip->pwmd), "error getting pwm data\n");
 		pdata->dimming_mode = DIMMING_PWM;
 		pwm_apply_args(chip->pwmd);
 	}
@@ -243,11 +242,9 @@ static int mp3309c_parse_fwnode(struct mp3309c_chip *chip,
 		num_levels = ANALOG_I2C_NUM_LEVELS;
 
 		/* Enable GPIO used in I2C dimming mode only */
-		chip->enable_gpio = devm_gpiod_get(chip->dev, "enable",
-						   GPIOD_OUT_HIGH);
+		chip->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_HIGH);
 		if (IS_ERR(chip->enable_gpio))
-			return dev_err_probe(chip->dev,
-					     PTR_ERR(chip->enable_gpio),
+			return dev_err_probe(dev, PTR_ERR(chip->enable_gpio),
 					     "error getting enable gpio\n");
 	} else {
 		/*
@@ -265,8 +262,7 @@ static int mp3309c_parse_fwnode(struct mp3309c_chip *chip,
 	}
 
 	/* Fill brightness levels array */
-	pdata->levels = devm_kcalloc(chip->dev, num_levels,
-				     sizeof(*pdata->levels), GFP_KERNEL);
+	pdata->levels = devm_kcalloc(dev, num_levels, sizeof(*pdata->levels), GFP_KERNEL);
 	if (!pdata->levels)
 		return -ENOMEM;
 	if (device_property_present(dev, "brightness-levels")) {
@@ -336,21 +332,21 @@ static int mp3309c_probe(struct i2c_client *client)
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return dev_err_probe(dev, -EOPNOTSUPP, "failed to check i2c functionality\n");
 
-	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
 
-	chip->dev = &client->dev;
+	chip->dev = dev;
 
 	chip->regmap = devm_regmap_init_i2c(client, &mp3309c_regmap);
 	if (IS_ERR(chip->regmap))
-		return dev_err_probe(&client->dev, PTR_ERR(chip->regmap),
+		return dev_err_probe(dev, PTR_ERR(chip->regmap),
 				     "failed to allocate register map\n");
 
 	i2c_set_clientdata(client, chip);
 
 	if (!pdata) {
-		pdata = devm_kzalloc(chip->dev, sizeof(*pdata), GFP_KERNEL);
+		pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 		if (!pdata)
 			return -ENOMEM;
 
@@ -367,11 +363,10 @@ static int mp3309c_probe(struct i2c_client *client)
 	props.type = BACKLIGHT_RAW;
 	props.power = FB_BLANK_UNBLANK;
 	props.fb_blank = FB_BLANK_UNBLANK;
-	chip->bl = devm_backlight_device_register(chip->dev, "mp3309c",
-						  chip->dev, chip,
+	chip->bl = devm_backlight_device_register(dev, "mp3309c", dev, chip,
 						  &mp3309c_bl_ops, &props);
 	if (IS_ERR(chip->bl))
-		return dev_err_probe(chip->dev, PTR_ERR(chip->bl),
+		return dev_err_probe(dev, PTR_ERR(chip->bl),
 				     "error registering backlight device\n");
 
 	/* In PWM dimming mode, enable pwm device */
@@ -383,8 +378,7 @@ static int mp3309c_probe(struct i2c_client *client)
 		pwmstate.enabled = true;
 		ret = pwm_apply_state(chip->pwmd, &pwmstate);
 		if (ret)
-			return dev_err_probe(chip->dev, ret,
-					     "error setting pwm device\n");
+			return dev_err_probe(dev, ret, "error setting pwm device\n");
 	}
 
 	chip->pdata->status = FIRST_POWER_ON;
-- 
2.43.0.rc1.1.gbec44491f096


