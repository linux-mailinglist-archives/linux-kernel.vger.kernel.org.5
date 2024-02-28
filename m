Return-Path: <linux-kernel+bounces-85701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF94986B981
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D069B21238
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104FC86259;
	Wed, 28 Feb 2024 20:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LH6m4Epl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAA186245;
	Wed, 28 Feb 2024 20:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709153973; cv=none; b=W4Ph33ifJ2Dc99ROkNNLV4reXYj4/qej0czX/JRAdOABMUo2SWT7VZ8k+qCIyVaubD1UtcJqcNcbN7QYCokHIh+xIrrB/x78rq9MNHb4s2VH7U4qSVnBTdFpupZ+7wvkyAoVGbsuNCCiB4NTK/1E2gDqOeRJu320mPcdvb4zqrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709153973; c=relaxed/simple;
	bh=s1h62JPTJyLTei5gZpaIUHL0sKAJLHq8C1bsqb1sRxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RIQ+2Pm4TtDD40WQAcWFBz+eIBCXqeZ6hlI7R6bYtbf4qhu9Vih26b6rWP1VjTJiz2vWEfUI5frIs9EISDln6oOF1NjrN+pm0GtjCFADvPRacUG85/d+e4e9S5j2WfKEEBaFg9gQ2cd821qewFhSLJv4hSopBJG7/n3vQ90l1x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LH6m4Epl; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709153972; x=1740689972;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s1h62JPTJyLTei5gZpaIUHL0sKAJLHq8C1bsqb1sRxM=;
  b=LH6m4EplhJRfcFTVloQecUPRx89ZpOAKOYAsLmyiOb5UQAa/7BpwqvSd
   sP2ua0ncgh6IpGk+FvxYKwNzzP+QgXJliMYsWR8IAbR/xTgNmcqh8d8uu
   0h0L/sMzLiBq6rPp5FUzCwI+LKdng0OL5usAF1EdObb8J7fYYrq/mk45a
   pM/5C/eYxas4cEX8Et0+MRaBtE+rIQGZtvzs+ny094JwY8WDrUeLHn8lE
   RFGZIA2jaNCMtSX5V9yVe5khnodcQgIsuN+9YQR2WKc9buBUtkVN2FVfX
   v2dSDVqpCjQtmy3n582nwExUNPcQY/6irtj8BESfgJNxqvYvAd579LGa1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3430170"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="3430170"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 12:59:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="937034667"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="937034667"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2024 12:59:29 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 59F691C5; Wed, 28 Feb 2024 22:59:28 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/1] iio: adc: twl4030-madc: Make use of device properties
Date: Wed, 28 Feb 2024 22:59:27 +0200
Message-ID: <20240228205927.3681321-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the module to be property provider agnostic and allow
it to be used on non-OF platforms.

Include mod_devicetable.h explicitly to replace the dropped of.h
which included mod_devicetable.h indirectly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/twl4030-madc.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
index 4a247ca25a44..a7b6b81014de 100644
--- a/drivers/iio/adc/twl4030-madc.c
+++ b/drivers/iio/adc/twl4030-madc.c
@@ -19,10 +19,12 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/mfd/twl.h>
-#include <linux/module.h>
 #include <linux/stddef.h>
 #include <linux/mutex.h>
 #include <linux/bitops.h>
@@ -30,7 +32,6 @@
 #include <linux/types.h>
 #include <linux/gfp.h>
 #include <linux/err.h>
-#include <linux/of.h>
 #include <linux/regulator/consumer.h>
 
 #include <linux/iio/iio.h>
@@ -746,7 +747,6 @@ static int twl4030_madc_probe(struct platform_device *pdev)
 {
 	struct twl4030_madc_data *madc;
 	struct twl4030_madc_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct device_node *np = pdev->dev.of_node;
 	int irq, ret;
 	u8 regval;
 	struct iio_dev *iio_dev = NULL;
@@ -779,7 +779,7 @@ static int twl4030_madc_probe(struct platform_device *pdev)
 	if (pdata)
 		madc->use_second_irq = (pdata->irq_line != 1);
 	else
-		madc->use_second_irq = of_property_read_bool(np,
+		madc->use_second_irq = device_property_read_bool(&pdev->dev,
 				       "ti,system-uses-second-madc-irq");
 
 	madc->imr = madc->use_second_irq ? TWL4030_MADC_IMR2 :
@@ -905,20 +905,18 @@ static void twl4030_madc_remove(struct platform_device *pdev)
 	regulator_disable(madc->usb3v1);
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id twl_madc_of_match[] = {
 	{ .compatible = "ti,twl4030-madc", },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, twl_madc_of_match);
-#endif
 
 static struct platform_driver twl4030_madc_driver = {
 	.probe = twl4030_madc_probe,
 	.remove_new = twl4030_madc_remove,
 	.driver = {
 		   .name = "twl4030_madc",
-		   .of_match_table = of_match_ptr(twl_madc_of_match),
+		   .of_match_table = twl_madc_of_match,
 	},
 };
 
-- 
2.43.0.rc1.1.gbec44491f096


