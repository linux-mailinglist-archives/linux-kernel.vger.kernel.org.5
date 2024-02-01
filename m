Return-Path: <linux-kernel+bounces-48390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB135845B58
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A764529471D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23693779E3;
	Thu,  1 Feb 2024 15:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nvwjmWx9"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B174A62160;
	Thu,  1 Feb 2024 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800911; cv=none; b=RlZEckPWSxwVfxpyE6fcj5LKYZ4DPjwZetbAmoyffp6oCJXuH18hG/JUzV+iO2ZGjbh4n2S6TBE50CObxhYvS7YwUWjustKB8XT5f6fzvsBDwjboQUS7LjYx7N2B/OhyKx+yYcns8U7ow0chH8MUl7tyG8KgFGfZ1SihBSUvbjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800911; c=relaxed/simple;
	bh=WQWD/KmFc0zx5MOPqiRy9ksCicyxu+6xfyIr/wR/bkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KSI00uikfDdZI8FFIzw/5mlCz9o5SJcIUlkafSocmpkq9utaBAqwopsW32C3Ookf3rLDcs2SpslcopcQ1X3fXaLDtDtBN/Mojxho2nGeN146TGUT8lFwtXW9Xnjm/FjQkB08dDApdstUkIVFxfUgak9PY+33K7yS0NV472rW6GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nvwjmWx9; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706800909; x=1738336909;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WQWD/KmFc0zx5MOPqiRy9ksCicyxu+6xfyIr/wR/bkY=;
  b=nvwjmWx9PGRKI1zvShK8l1eXlj5P0OPZmO4PZWQRcR2iGOK9yX2W6m8d
   w0ReZGcaulfKfcDKLcusKfhZ9I1bvme3TZRsYYZJXziOABb/xh0lUC3e+
   hR/2rX5GQfoFwn5PxmS019XtEjRe/s+zBNGN2UEbuKYNwtBwDzS5IR807
   yrJffSEn36JaI8YiWy4kfZcPvKDNIjBlbPfh4I6Zx4sm54fq8Nm+9gJR8
   8A9VhLsd4HqTq07kB63JJj039aAvz9/S1KlRaKuJWXxbdfTlZogr+X96O
   KRHUgtgG3+0q0MBK+qektJl/3ErF6ZiZDFyJdj0SJtyriez2iH93NG9J8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="402762439"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="402762439"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 07:21:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="788953700"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="788953700"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 01 Feb 2024 07:21:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D646EC07; Thu,  1 Feb 2024 17:15:42 +0200 (EET)
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
Subject: [PATCH v2 2/3] backlight: mp3309c: use dev_err_probe() instead of dev_err()
Date: Thu,  1 Feb 2024 17:14:14 +0200
Message-ID: <20240201151537.367218-3-andriy.shevchenko@linux.intel.com>
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

Replace dev_err() with dev_err_probe().

This helps in simplifing code and standardizing the error output.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/video/backlight/mp3309c.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/video/backlight/mp3309c.c b/drivers/video/backlight/mp3309c.c
index 762bd738c903..2d6bd1a180b3 100644
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


