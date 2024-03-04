Return-Path: <linux-kernel+bounces-90751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E420B870469
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22AED1C212AA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DBF4653A;
	Mon,  4 Mar 2024 14:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mLQ7elNH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C251E484;
	Mon,  4 Mar 2024 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709563245; cv=none; b=V52WmP08tdP8XEHXHZvoYjef6UjPUdeY7Pw2HYN633kju1u5a3bYagT5Tbgkru8sDKD6/VJ1Qj1pcHqqzSdJ/omcA/qH5y312eNREoIDXT1ht/w1ndw6TNREPIpHdtdCs0Zt6YpMrdbBfIPbbnmhx4i4vTxWZHN4jBeqmyAlTqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709563245; c=relaxed/simple;
	bh=zIjlGZfedJV9OUraq9VXgB71J74hXHMlhetn5zUkDYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NN8ZWYAAcu0JQcvVv/A1EROtLk6jBPJM7AuAblqgT5FPQCM+KaZkykrn4R4iZF19tjyJ0+6/qkyKW0jp0kyAfS0U4HlNNtV3X+fiOpDBDgryOw24XxiUWWalFcN2Y9XFbtId7tNco9E6gaYmm9PGJ5eWoBjY0I0TSBjAFTVOPIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mLQ7elNH; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709563243; x=1741099243;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zIjlGZfedJV9OUraq9VXgB71J74hXHMlhetn5zUkDYY=;
  b=mLQ7elNHI8fwuBeu4AYTe6OpbLIKWl8hK8wbHP33G/7uU8n5JEY5frpb
   qAYnHCBJM98RPbR3NemmPky+UEhhgabmAaFE4OOr6AbqFFvzv7lDnpFNh
   /UtQ6l1x7UaMTuncvQkhWqYW0VQfN76tKRlzP438BPj48/qOQbg5WxMeH
   H/BMOa+fTMYiwmOJL7w53oC+WUNzMHTed4gbUHVXZUiy5CX7LDhaoyFzD
   Vp+RglKXEgkR0pMl7ob4XsME1TcXPhjXWzr5FBMFLO1S1FodQT6QTO0hs
   NIcF+yshUdMakT/npTuW8bd3zRUXG2JL2iqZ5uV0HfUq+OZW0gOYKZKLo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="4218619"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="4218619"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 06:40:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="937040615"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="937040615"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2024 06:40:40 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E9A1715C; Mon,  4 Mar 2024 16:40:38 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 1/1] iio: adc: twl4030-madc: Make use of device properties
Date: Mon,  4 Mar 2024 16:40:06 +0200
Message-ID: <20240304144037.1036390-1-andriy.shevchenko@linux.intel.com>
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
v2: converted leftover (Jonathan)
 drivers/iio/adc/twl4030-madc.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
index 4a247ca25a44..0253064fadec 100644
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
@@ -744,14 +745,14 @@ static int twl4030_madc_set_power(struct twl4030_madc_data *madc, int on)
  */
 static int twl4030_madc_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
+	struct twl4030_madc_platform_data *pdata = dev_get_platdata(dev);
 	struct twl4030_madc_data *madc;
-	struct twl4030_madc_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct device_node *np = pdev->dev.of_node;
 	int irq, ret;
 	u8 regval;
 	struct iio_dev *iio_dev = NULL;
 
-	if (!pdata && !np) {
+	if (!pdata && !dev_fwnode(dev)) {
 		dev_err(&pdev->dev, "neither platform data nor Device Tree node available\n");
 		return -EINVAL;
 	}
@@ -779,7 +780,7 @@ static int twl4030_madc_probe(struct platform_device *pdev)
 	if (pdata)
 		madc->use_second_irq = (pdata->irq_line != 1);
 	else
-		madc->use_second_irq = of_property_read_bool(np,
+		madc->use_second_irq = device_property_read_bool(dev,
 				       "ti,system-uses-second-madc-irq");
 
 	madc->imr = madc->use_second_irq ? TWL4030_MADC_IMR2 :
@@ -905,20 +906,18 @@ static void twl4030_madc_remove(struct platform_device *pdev)
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


