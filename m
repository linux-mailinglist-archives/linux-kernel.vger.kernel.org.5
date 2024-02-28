Return-Path: <linux-kernel+bounces-85677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FD486B915
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E9728A3A8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CCA74418;
	Wed, 28 Feb 2024 20:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AjyD/Uqi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB63B1DDF4;
	Wed, 28 Feb 2024 20:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709152231; cv=none; b=oR7PgUrhdkw+KRKbqMFm51dBLA28KD8w6dKz2f4Be1wspwXwCG8DrfJ42sZjOJxLZVfz4NP4YRZvOjm7MXImxxVK2D7B10lvaI0rVaOCF1Qj0Bd7Zn8NGYJGkCtKfMiB1T+4cT1Y9iyO5F5jS4PospD880Uynnv6FuMxiD7a26Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709152231; c=relaxed/simple;
	bh=WdFugmdSwuXnw/qKz9yLmhGuWa9vJjJ2n+gkaBqe/8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dGkj+QNOj+lKhSPZd15Cy6DTXB4cPCABL39+vjWu1rTsjcG5L8GInl5T7vsFOHBatCBumzntSsKL1y4HaNiEihZ28+PBUMlMOiy1sfd+8kvA2O0k71J0OSks+H1JZPqjM43cEblafB1kyUZ17gQYhucbqN3jGH+dtn2q0Iqst0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AjyD/Uqi; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709152230; x=1740688230;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WdFugmdSwuXnw/qKz9yLmhGuWa9vJjJ2n+gkaBqe/8Q=;
  b=AjyD/UqiZOhgkgdcDiNVEK4BjCbAptorlv1NkCeDnkoYKiBCLz65IUBS
   QnNxw+wYKFzBsQSSlaH7greCtaJDy2Grti85J+b8skZr7fisLVz7ArBOw
   ykmtjMCGmeKRB3+TaZPfhqPxrYkjybZ1j1GJgrpy16uYDhrH1bsXFqi6/
   cif5x4cW7f1D4z/6Xz5YquLZ4u0H1GiuyZfKmBc2iwGKEFQFymF1z9iHK
   /suNvojQ61kSyKv61wzSuoYG7aW1ebbjfhgvhwcRCVHrHjDQa3Dx24uiy
   DYqOMNjAcc4hrddQhGoDh+CwEtg20RKG5akP8jCC7txiT9qIuUQrbeTJX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3426795"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="3426795"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 12:30:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="937034655"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="937034655"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2024 12:30:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id ED4661C5; Wed, 28 Feb 2024 22:30:25 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: adc: spear_adc: Make use of device properties
Date: Wed, 28 Feb 2024 22:30:23 +0200
Message-ID: <20240228203023.3609181-1-andriy.shevchenko@linux.intel.com>
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
 drivers/iio/adc/spear_adc.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
index 71362c2ddf89..b6dd096391c1 100644
--- a/drivers/iio/adc/spear_adc.c
+++ b/drivers/iio/adc/spear_adc.c
@@ -5,8 +5,10 @@
  * Copyright 2012 Stefan Roese <sr@denx.de>
  */
 
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
@@ -15,8 +17,6 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/completion.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -70,7 +70,7 @@ struct adc_regs_spear6xx {
 };
 
 struct spear_adc_state {
-	struct device_node *np;
+	struct device *dev;
 	struct adc_regs_spear3xx __iomem *adc_base_spear3xx;
 	struct adc_regs_spear6xx __iomem *adc_base_spear6xx;
 	struct clk *clk;
@@ -123,7 +123,7 @@ static void spear_adc_set_ctrl(struct spear_adc_state *st, int n,
 
 static u32 spear_adc_get_average(struct spear_adc_state *st)
 {
-	if (of_device_is_compatible(st->np, "st,spear600-adc")) {
+	if (device_is_compatible(st->dev, "st,spear600-adc")) {
 		return __raw_readl(&st->adc_base_spear6xx->average.msb) &
 			SPEAR_ADC_DATA_MASK;
 	} else {
@@ -134,7 +134,7 @@ static u32 spear_adc_get_average(struct spear_adc_state *st)
 
 static void spear_adc_set_scanrate(struct spear_adc_state *st, u32 rate)
 {
-	if (of_device_is_compatible(st->np, "st,spear600-adc")) {
+	if (device_is_compatible(st->dev, "st,spear600-adc")) {
 		__raw_writel(SPEAR600_ADC_SCAN_RATE_LO(rate),
 			     &st->adc_base_spear6xx->scan_rate_lo);
 		__raw_writel(SPEAR600_ADC_SCAN_RATE_HI(rate),
@@ -266,7 +266,6 @@ static const struct iio_info spear_adc_info = {
 
 static int spear_adc_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
 	struct spear_adc_state *st;
 	struct iio_dev *indio_dev = NULL;
@@ -279,11 +278,10 @@ static int spear_adc_probe(struct platform_device *pdev)
 				     "failed allocating iio device\n");
 
 	st = iio_priv(indio_dev);
+	st->dev = dev;
 
 	mutex_init(&st->lock);
 
-	st->np = np;
-
 	/*
 	 * SPEAr600 has a different register layout than other SPEAr SoC's
 	 * (e.g. SPEAr3xx). Let's provide two register base addresses
@@ -310,8 +308,7 @@ static int spear_adc_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "failed requesting interrupt\n");
 
-	if (of_property_read_u32(np, "sampling-frequency",
-				 &st->sampling_freq))
+	if (device_property_read_u32(dev, "sampling-frequency", &st->sampling_freq))
 		return dev_err_probe(dev, -EINVAL,
 				     "sampling-frequency missing in DT\n");
 
@@ -319,13 +316,13 @@ static int spear_adc_probe(struct platform_device *pdev)
 	 * Optional avg_samples defaults to 0, resulting in single data
 	 * conversion
 	 */
-	of_property_read_u32(np, "average-samples", &st->avg_samples);
+	device_property_read_u32(dev, "average-samples", &st->avg_samples);
 
 	/*
 	 * Optional vref_external defaults to 0, resulting in internal vref
 	 * selection
 	 */
-	of_property_read_u32(np, "vref-external", &st->vref_external);
+	device_property_read_u32(dev, "vref-external", &st->vref_external);
 
 	spear_adc_configure(st);
 
@@ -346,19 +343,17 @@ static int spear_adc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id spear_adc_dt_ids[] = {
 	{ .compatible = "st,spear600-adc", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, spear_adc_dt_ids);
-#endif
 
 static struct platform_driver spear_adc_driver = {
 	.probe		= spear_adc_probe,
 	.driver		= {
 		.name	= SPEAR_ADC_MOD_NAME,
-		.of_match_table = of_match_ptr(spear_adc_dt_ids),
+		.of_match_table = spear_adc_dt_ids,
 	},
 };
 
-- 
2.43.0.rc1.1.gbec44491f096


