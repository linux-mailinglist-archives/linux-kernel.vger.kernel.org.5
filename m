Return-Path: <linux-kernel+bounces-132015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18165898EBD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C595B28248B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B012C12D1FA;
	Thu,  4 Apr 2024 19:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZRWrqi0v"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F17133424;
	Thu,  4 Apr 2024 19:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712258013; cv=none; b=QZkjaaS/m1A6agLTB4/ecUrVNW04k+5n62Jv8K7mSzih9/5NtkrkSNc/dbhXZTPvg9PS0BPKm/fXWtJySPxaXkF2gl3Rh0EApV2AOoQncav9FSA0k8hsrl4EAIjHaSD0un3brodz8L+EmM0+YWkoZS+ubPvE8B3Wp/X7ghWU498=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712258013; c=relaxed/simple;
	bh=BeJDiaZ5Jkmnb3C7Z91MeyQopFXvWSPHUzMeaIHYLXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NetrDN6+yCf98DG3G0TsEl0orB31wG7Cwk9p5F0QlNiJwvzgb48x9WJrrJav7U1exgegrbkcwrlQRSB5vbg9rA/Ak6Zels2glQukoafClVJkvWYtwHoRNUdQ9GdRHFKk8sDlR6WVnZRNOl0xcXsHvqdP5758R2ZthgBGdivwLmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZRWrqi0v; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712258011; x=1743794011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BeJDiaZ5Jkmnb3C7Z91MeyQopFXvWSPHUzMeaIHYLXA=;
  b=ZRWrqi0v9tDH9F7jlahe2pOmKgIv++mGtBf5OrAALTbHstfYOOxUFevM
   p2j6IR7SS1ThukrsiqIbpRpY9eDaBZk6s7tevVoWanoCFScG9Y1+K3LSO
   6GmYvIXTYhoB1Sn85gSb7q/mBglIt2wR03IoHumW9D6Xr15C+okgpFWr1
   nwUnBpwuivwxUWEe5VCoLx7J9GnbUj1ugDgIFRGtAWavanz6Sx3baStbd
   P0OgGwGYuDZWYxIMPpPldqcEM+Oy/kJwgbsy57O2ZLRwE5o60URkTkUvu
   YN84jcWrKznybwBay5sB/boSEq+Jvc6SffC6JhxQ6r6RyGpCungtr9Mt2
   g==;
X-CSE-ConnectionGUID: GDo3op+3S42zpGFkogNzbA==
X-CSE-MsgGUID: 1OX68lXzSqe19th3iDsj0A==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="18709374"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18709374"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 12:13:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="937087027"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="937087027"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Apr 2024 12:13:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8E125B56; Thu,  4 Apr 2024 22:13:25 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 2/2] hwmon: (pwm-fan) Make use of device properties
Date: Thu,  4 Apr 2024 22:11:39 +0300
Message-ID: <20240404191323.3547465-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240404191323.3547465-1-andriy.shevchenko@linux.intel.com>
References: <20240404191323.3547465-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert the module to be property provider agnostic and allow
it to be used on non-OF platforms.

Add mod_devicetable.h include.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/hwmon/Kconfig   |  2 +-
 drivers/hwmon/pwm-fan.c | 21 ++++++++++-----------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 83945397b6eb..960539bd40ab 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1778,7 +1778,7 @@ config SENSORS_PT5161L
 
 config SENSORS_PWM_FAN
 	tristate "PWM fan"
-	depends on (PWM && OF) || COMPILE_TEST
+	depends on PWM || COMPILE_TEST
 	depends on THERMAL || THERMAL=n
 	help
 	  If you say yes here you get support for fans connected to PWM lines.
diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index bf902610cd07..a1712649b07e 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -9,10 +9,11 @@
 
 #include <linux/hwmon.h>
 #include <linux/interrupt.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/pwm.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sysfs.h>
@@ -421,16 +422,14 @@ static const struct thermal_cooling_device_ops pwm_fan_cooling_ops = {
 	.set_cur_state = pwm_fan_set_cur_state,
 };
 
-static int pwm_fan_of_get_cooling_data(struct device *dev,
-				       struct pwm_fan_ctx *ctx)
+static int pwm_fan_get_cooling_data(struct device *dev, struct pwm_fan_ctx *ctx)
 {
-	struct device_node *np = dev->of_node;
 	int num, i, ret;
 
-	if (!of_property_present(np, "cooling-levels"))
+	if (!device_property_present(dev, "cooling-levels"))
 		return 0;
 
-	ret = of_property_count_u32_elems(np, "cooling-levels");
+	ret = device_property_count_u32(dev, "cooling-levels");
 	if (ret <= 0) {
 		dev_err(dev, "Wrong data!\n");
 		return ret ? : -EINVAL;
@@ -442,8 +441,8 @@ static int pwm_fan_of_get_cooling_data(struct device *dev,
 	if (!ctx->pwm_fan_cooling_levels)
 		return -ENOMEM;
 
-	ret = of_property_read_u32_array(np, "cooling-levels",
-					 ctx->pwm_fan_cooling_levels, num);
+	ret = device_property_read_u32_array(dev, "cooling-levels",
+					     ctx->pwm_fan_cooling_levels, num);
 	if (ret) {
 		dev_err(dev, "Property 'cooling-levels' cannot be read!\n");
 		return ret;
@@ -574,8 +573,8 @@ static int pwm_fan_probe(struct platform_device *pdev)
 		for (i = 0; i < ctx->tach_count; i++)
 			ctx->pulses_per_revolution[i] = 2;
 
-		of_property_read_u32_array(dev->of_node, "pulses-per-revolution",
-					   ctx->pulses_per_revolution, ctx->tach_count);
+		device_property_read_u32_array(dev, "pulses-per-revolution",
+					       ctx->pulses_per_revolution, ctx->tach_count);
 	}
 
 	channels = devm_kcalloc(dev, channel_count + 1,
@@ -630,7 +629,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
 		return PTR_ERR(hwmon);
 	}
 
-	ret = pwm_fan_of_get_cooling_data(dev, ctx);
+	ret = pwm_fan_get_cooling_data(dev, ctx);
 	if (ret)
 		return ret;
 
-- 
2.43.0.rc1.1.gbec44491f096


