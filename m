Return-Path: <linux-kernel+bounces-38-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E4B813B0F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C52B2842EA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52D36A34F;
	Thu, 14 Dec 2023 19:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FcnCBpb7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43B56A32B;
	Thu, 14 Dec 2023 19:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702583533; x=1734119533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qcQw69A7AidYEiGOIpRXKv0GkQT63sTQFqosUiEkvrg=;
  b=FcnCBpb7fsU+3HpimY/ApyEw7CaECxd3c85eY1faY1J49lm29q24yrd1
   D77vL4BLtavReBZ1roYd7GptYHf1MWXfNBG3csGXfqnNU2T2PNHrM9M0K
   zS3pC4BTXTY6zNTGwZYKcBZTW/JLZWfYx+Z5g/u8cLj4YXncSeILd95PP
   scKwll0hMusjLYhRCQBOpqOLfg39nNJx8BL6lAMROOuubYKe/xs/ZwVty
   qGRbI4XNAsVw6K1ZX5gcMExLi0unzXfRkJMBO4bWOQpScI+VP2/lIHXfC
   xlD3XDTsWCTiEYWOmYBgsqzqgM4DmkJJCI+mFUgePNiDxNP9PqBt7snLI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="394047201"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="394047201"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 11:52:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="778006680"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="778006680"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 14 Dec 2023 11:52:00 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 7968713A; Thu, 14 Dec 2023 21:51:59 +0200 (EET)
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
Subject: [PATCH v1 1/2] backlight: mp3309c: Make use of device properties
Date: Thu, 14 Dec 2023 21:51:13 +0200
Message-ID: <20231214195158.1335727-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231214195158.1335727-1-andriy.shevchenko@linux.intel.com>
References: <20231214195158.1335727-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the module to be property provider agnostic and allow
it to be used on non-OF platforms.

Add mod_devicetable.h include.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/video/backlight/mp3309c.c | 38 ++++++++++++-------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/drivers/video/backlight/mp3309c.c b/drivers/video/backlight/mp3309c.c
index 34d71259fac1..d9b08f191999 100644
--- a/drivers/video/backlight/mp3309c.c
+++ b/drivers/video/backlight/mp3309c.c
@@ -15,6 +15,8 @@
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
 #include <linux/pwm.h>
 #include <linux/regmap.h>
 
@@ -202,15 +204,12 @@ static const struct backlight_ops mp3309c_bl_ops = {
 static int pm3309c_parse_dt_node(struct mp3309c_chip *chip,
 				 struct mp3309c_platform_data *pdata)
 {
-	struct device_node *node = chip->dev->of_node;
-	struct property *prop_pwms;
-	struct property *prop_levels = NULL;
-	int length = 0;
 	int ret, i;
 	unsigned int num_levels, tmp_value;
+	struct device *dev = chip->dev;
 
-	if (!node) {
-		dev_err(chip->dev, "failed to get DT node\n");
+	if (!dev_fwnode(dev)) {
+		dev_err(dev, "failed to get firmware node\n");
 		return -ENODEV;
 	}
 
@@ -224,8 +223,7 @@ static int pm3309c_parse_dt_node(struct mp3309c_chip *chip,
 	 * found in the backlight node, the mode switches to PWM mode.
 	 */
 	pdata->dimming_mode = DIMMING_ANALOG_I2C;
-	prop_pwms = of_find_property(node, "pwms", &length);
-	if (prop_pwms) {
+	if (device_property_present(dev, "pwms")) {
 		chip->pwmd = devm_pwm_get(chip->dev, NULL);
 		if (IS_ERR(chip->pwmd))
 			return dev_err_probe(chip->dev, PTR_ERR(chip->pwmd),
@@ -257,11 +255,9 @@ static int pm3309c_parse_dt_node(struct mp3309c_chip *chip,
 		/*
 		 * PWM control mode: check for brightness level in DT
 		 */
-		prop_levels = of_find_property(node, "brightness-levels",
-					       &length);
-		if (prop_levels) {
+		if (device_property_present(dev, "brightness-levels")) {
 			/* Read brightness levels from DT */
-			num_levels = length / sizeof(u32);
+			num_levels = device_property_count_u32(dev, "brightness-levels");
 			if (num_levels < 2)
 				return -EINVAL;
 		} else {
@@ -275,10 +271,9 @@ static int pm3309c_parse_dt_node(struct mp3309c_chip *chip,
 				     sizeof(*pdata->levels), GFP_KERNEL);
 	if (!pdata->levels)
 		return -ENOMEM;
-	if (prop_levels) {
-		ret = of_property_read_u32_array(node, "brightness-levels",
-						 pdata->levels,
-						 num_levels);
+	if (device_property_present(dev, "brightness-levels")) {
+		ret = device_property_read_u32_array(dev, "brightness-levels",
+						     pdata->levels, num_levels);
 		if (ret < 0)
 			return ret;
 	} else {
@@ -288,8 +283,7 @@ static int pm3309c_parse_dt_node(struct mp3309c_chip *chip,
 
 	pdata->max_brightness = num_levels - 1;
 
-	ret = of_property_read_u32(node, "default-brightness",
-				   &pdata->default_brightness);
+	ret = device_property_read_u32(dev, "default-brightness", &pdata->default_brightness);
 	if (ret)
 		pdata->default_brightness = pdata->max_brightness;
 	if (pdata->default_brightness > pdata->max_brightness) {
@@ -310,8 +304,8 @@ static int pm3309c_parse_dt_node(struct mp3309c_chip *chip,
 	 * If missing, the default value for OVP is 35.5V
 	 */
 	pdata->over_voltage_protection = REG_I2C_1_OVP1;
-	if (!of_property_read_u32(node, "mps,overvoltage-protection-microvolt",
-				  &tmp_value)) {
+	ret = device_property_read_u32(dev, "mps,overvoltage-protection-microvolt", &tmp_value);
+	if (!ret) {
 		switch (tmp_value) {
 		case 13500000:
 			pdata->over_voltage_protection = 0x00;
@@ -328,9 +322,7 @@ static int pm3309c_parse_dt_node(struct mp3309c_chip *chip,
 	}
 
 	/* Synchronous (default) and non-synchronous mode */
-	pdata->sync_mode = true;
-	if (of_property_read_bool(node, "mps,no-sync-mode"))
-		pdata->sync_mode = false;
+	pdata->sync_mode = !device_property_read_bool(dev, "mps,no-sync-mode");
 
 	return 0;
 }
-- 
2.43.0.rc1.1.gbec44491f096


