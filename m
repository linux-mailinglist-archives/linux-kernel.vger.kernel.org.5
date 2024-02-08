Return-Path: <linux-kernel+bounces-58540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBE384E7CF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F9A028FFAB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DCB200AA;
	Thu,  8 Feb 2024 18:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X5VtM6Ch"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56321C6A8;
	Thu,  8 Feb 2024 18:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707417751; cv=none; b=f+cUK1CFvmyijDDth7RAIm1iWNqa+zOhzZOnl40XIYcp/RLcQY/ODQtW0fUsaHbjYo5fraJqpx699Q+0sZpoYZIQjqeFmihdSczZ4nGe5RzwSygBUYD/zQ0ZLdFDD/AsJjoa5manWcGjNDXxTb1/eTPS1NALrlL4FxxO2nnr9TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707417751; c=relaxed/simple;
	bh=R8VW3vdNVBtgOG4uxMk33o384NOmy+Axf/iYx44RjkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ppXCBF6+JeUsFvpfvXXYqVQowvCIaNUn5NqCs1T+xuy717D9bYmjtp24Dwa8qgkHo5gecP1gp10+8PQxo+nQjEM6gjxjzRVaaX00lehkSPCtnALaySWcQSitrkbKMXaIarJG+L2VTUj95dA8q6bo0d+BvbIDS88KHhBNHWRQrPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X5VtM6Ch; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707417750; x=1738953750;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R8VW3vdNVBtgOG4uxMk33o384NOmy+Axf/iYx44RjkM=;
  b=X5VtM6ChXofAWnqeuLCM8wH5Yey5vC1v6V+AG/kKic8w2fbggxTdfZXJ
   R9q3RYF4CIiVtmnx00U2QN13D4qy5vkUdPud2PxSCjGWCdj6IfBXn45bj
   9sKKgCxw0Ggq810hjUT/8sAJ6XOJn9pTidbN6obbDHI+aKo6ru+gkzB65
   2JRLVY65i+zm95cjvTWpt7qGjBAvTeHxMXEvM7LWFbv8AIACukyP1513p
   4IMYfjSVPPZBEhdJV2vXqG9Fpr81k7jzOirYPE56PT7+3duxu4M9iSXsw
   xklsYSVz2sDmr8+fSkj4daLZM+s55SSM3FMHZ4wX8BR9hxTl7NaR7yQn/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1184538"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1184538"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:42:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934213664"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="934213664"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2024 10:42:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D63C91529; Thu,  8 Feb 2024 20:26:09 +0200 (EET)
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
Date: Thu,  8 Feb 2024 20:24:47 +0200
Message-ID: <20240208182608.2224191-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240208182608.2224191-1-andriy.shevchenko@linux.intel.com>
References: <20240208182608.2224191-1-andriy.shevchenko@linux.intel.com>
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


