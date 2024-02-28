Return-Path: <linux-kernel+bounces-85719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A32DE86B9D9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD502862D8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF667002E;
	Wed, 28 Feb 2024 21:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ix2qCsmT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11278627F;
	Wed, 28 Feb 2024 21:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709155680; cv=none; b=WbU3L+/Em8BEjJdzr/hbKruEJAWmmFf0tApcSKL22MX4bt3ci+Fz/j6BHJRKCprQHcLnIAI2WqIzpOzjVpRYM1xCsg9Z0bxUG5uFpYfn6vIH6ZxvtONlhz5Y9FBboOIA1ZSZ5TlQIcYnbF7m1bhs8Tq4TJF+P/rJjL6ezADwTX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709155680; c=relaxed/simple;
	bh=KRZqXDKyf7LxgmLLihGCD0ad2l3K3+mPreZGWpFnqew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CJ+MrZdT9wKwvqS2zCbLj4RvEurpDrCmgjoB5al/j2xZtFY+IjFRXqsbyMnpOQwzzxjAyJk4pabqEXKSBaJoeWeYshICo2WuFfVK7xc1yjeFpLhxioWrKLGYUxu9pLYOoQkVWUk+gbne2Z6RrlcmIqMcVslJsEGFrcApJ8GsjCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ix2qCsmT; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709155679; x=1740691679;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KRZqXDKyf7LxgmLLihGCD0ad2l3K3+mPreZGWpFnqew=;
  b=Ix2qCsmTButdSq+S0q0741RB5i7fCrAh98mfjVKdft+fEhb0y6+qHw98
   7ozm90LZNNQUs4pYbZVrsL34wO+AbUI51v7sOz7ahqOTTiVKg5ALE27Ms
   wIEB8v3Ef5hYiZDH6U17/pJNi1NWC6J16dvOMuMFro+71nRkoZKRD8+qv
   VJr2AUnIhnD2iqrMb5w1Vnoc2UI6bSxFFT2l+ixLPVj0e3KYFMotxUiTh
   miRb6eXfCOko2CS51JVByc7Myi1/sjLNIjB5MepSIkVLTLMK0WIIv5ONo
   trjYw7O3W4zQM/uIE3xw5EjF9Fmaqr73QwZTKUORGMri6gdgW2O9M6jtD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3710276"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="3710276"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 13:27:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="937034692"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="937034692"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2024 13:27:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D285B1C5; Wed, 28 Feb 2024 23:27:54 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/1] iio: light: isl29018: Drop ACPI specifics from the code
Date: Wed, 28 Feb 2024 23:27:46 +0200
Message-ID: <20240228212746.3709512-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the module to be property provider agnostic. The ACPI
APIs are not required and can be replaced by respective agnostic
ones.

Include mod_devicetable.h explicitly to replace the dropped of.h
which included mod_devicetable.h indirectly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/light/isl29018.c | 44 +++++++++++++-----------------------
 1 file changed, 16 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
index 43484c18b101..fe7b9ad7ff35 100644
--- a/drivers/iio/light/isl29018.c
+++ b/drivers/iio/light/isl29018.c
@@ -8,17 +8,19 @@
  * Copyright (c) 2010, NVIDIA Corporation.
  */
 
-#include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/err.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/delay.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
+
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-#include <linux/acpi.h>
 
 #define ISL29018_CONV_TIME_MS		100
 
@@ -523,9 +525,9 @@ static const struct attribute_group isl29023_group = {
 };
 
 enum {
-	isl29018,
-	isl29023,
-	isl29035,
+	isl29018 = 1,
+	isl29023 = 2,
+	isl29035 = 3,
 };
 
 static int isl29018_chip_init(struct isl29018_chip *chip)
@@ -687,20 +689,6 @@ static const struct isl29018_chip_info isl29018_chip_info_tbl[] = {
 	},
 };
 
-static const char *isl29018_match_acpi_device(struct device *dev, int *data)
-{
-	const struct acpi_device_id *id;
-
-	id = acpi_match_device(dev->driver->acpi_match_table, dev);
-
-	if (!id)
-		return NULL;
-
-	*data = (int)id->driver_data;
-
-	return dev_name(dev);
-}
-
 static void isl29018_disable_regulator_action(void *_data)
 {
 	struct isl29018_chip *chip = _data;
@@ -718,6 +706,7 @@ static int isl29018_probe(struct i2c_client *client)
 	struct iio_dev *indio_dev;
 	int err;
 	const char *name = NULL;
+	const void *match;
 	int dev_id = 0;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
@@ -728,14 +717,15 @@ static int isl29018_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, indio_dev);
 
-	if (id) {
+	match = device_get_match_data(dev);
+	if (match) {
+		name = dev_name(dev);
+		dev_id = (int)(uintptr_t)match;
+	} else if (id) {
 		name = id->name;
 		dev_id = id->driver_data;
 	}
 
-	if (ACPI_HANDLE(&client->dev))
-		name = isl29018_match_acpi_device(&client->dev, &dev_id);
-
 	mutex_init(&chip->lock);
 
 	chip->type = dev_id;
@@ -832,15 +822,13 @@ static int isl29018_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(isl29018_pm_ops, isl29018_suspend,
 				isl29018_resume);
 
-#ifdef CONFIG_ACPI
 static const struct acpi_device_id isl29018_acpi_match[] = {
 	{"ISL29018", isl29018},
 	{"ISL29023", isl29023},
 	{"ISL29035", isl29035},
-	{},
+	{}
 };
 MODULE_DEVICE_TABLE(acpi, isl29018_acpi_match);
-#endif
 
 static const struct i2c_device_id isl29018_id[] = {
 	{"isl29018", isl29018},
@@ -854,14 +842,14 @@ static const struct of_device_id isl29018_of_match[] = {
 	{ .compatible = "isil,isl29018", },
 	{ .compatible = "isil,isl29023", },
 	{ .compatible = "isil,isl29035", },
-	{ },
+	{}
 };
 MODULE_DEVICE_TABLE(of, isl29018_of_match);
 
 static struct i2c_driver isl29018_driver = {
 	.driver	 = {
 			.name = "isl29018",
-			.acpi_match_table = ACPI_PTR(isl29018_acpi_match),
+			.acpi_match_table = isl29018_acpi_match,
 			.pm = pm_sleep_ptr(&isl29018_pm_ops),
 			.of_match_table = isl29018_of_match,
 		    },
-- 
2.43.0.rc1.1.gbec44491f096


