Return-Path: <linux-kernel+bounces-95747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1204875205
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 664E6287FBD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D347812D775;
	Thu,  7 Mar 2024 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KTkmu1YY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566091C68F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 14:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709822211; cv=none; b=t2+bYx59mAd6PMyCdjwiftddJURSMXdIMCFClI+lRS8ajnF9xDtzlSBZSOwbi2rVBPT7DgoMFLguGHCKE7KsAt0fmIRsL7q/ZC2HkwiF975zvdz9U5U3MLJHOS3epEuLP55V1JytzY+mwdKihAD5f1DbnHoh7nzITE2FOA2TuEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709822211; c=relaxed/simple;
	bh=5S2VXHGhxOzxNWvUFy88OLCLWKC5Vjs6OqaCwuy/fjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ej/4zTuHFCZShPF8ZzMv5nhm6a8V8zJuF/QLfyPFEZWuyGIDrYBGSgzOKLxmt7txBIkCO1q/GHWRzbDMfqhZ2mr5carYAxaNMNAIymMErCXj1DiTo6cLCpqSkYrj137VLVl6QCci5ZQrWl5l5evMjqchAQl1NQyjpElo6f+aaXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KTkmu1YY; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709822209; x=1741358209;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5S2VXHGhxOzxNWvUFy88OLCLWKC5Vjs6OqaCwuy/fjo=;
  b=KTkmu1YYNfj4Y7p5AwRTp8y1l2j/mAVmQztHCH5l/DyPUOSgDj4QSK/G
   grppEdPjY9BgjWNZnSUKp1qU0JBHYaj0nlUWgaa6gSDp9UYNPx5BFZOZ7
   7nrYFuoI9t3fzPJtdWqWUmvoKun+1R53B/FRXNuFN8V2WR/G3IuqP9JG6
   nn8MExaVonmJ+fSqiyimp1XJ8dIMRKVJ0411ZVqUxTp+c3K35qvcQC48+
   batLbMo3MLVaRnYJRvgCLH8T+Xis9nVw2tjNqXD/9MHPtfnL98BlgVGpr
   G8oek9dfZCmCtrjtIlad883YKpic6Pxu2Aw1BDAWeBmholVV9Kish2X4k
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4348207"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="4348207"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 06:36:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="937046239"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="937046239"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 06:36:47 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id EC2333C0; Thu,  7 Mar 2024 16:36:45 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/5] w1: gpio: Make use of device properties
Date: Thu,  7 Mar 2024 16:35:47 +0200
Message-ID: <20240307143644.3787260-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240307143644.3787260-1-andriy.shevchenko@linux.intel.com>
References: <20240307143644.3787260-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the module to be property provider agnostic and allow
it to be used on non-OF platforms.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/w1/masters/w1-gpio.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/w1/masters/w1-gpio.c b/drivers/w1/masters/w1-gpio.c
index 34128e6bbbfa..8ea53c757c99 100644
--- a/drivers/w1/masters/w1-gpio.c
+++ b/drivers/w1/masters/w1-gpio.c
@@ -6,13 +6,13 @@
  */
 
 #include <linux/init.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/gpio/consumer.h>
-#include <linux/of_platform.h>
 #include <linux/err.h>
-#include <linux/of.h>
 #include <linux/delay.h>
 
 #include <linux/w1.h>
@@ -63,20 +63,11 @@ static u8 w1_gpio_read_bit(void *data)
 	return gpiod_get_value(ddata->gpiod) ? 1 : 0;
 }
 
-#if defined(CONFIG_OF)
-static const struct of_device_id w1_gpio_dt_ids[] = {
-	{ .compatible = "w1-gpio" },
-	{}
-};
-MODULE_DEVICE_TABLE(of, w1_gpio_dt_ids);
-#endif
-
 static int w1_gpio_probe(struct platform_device *pdev)
 {
 	struct w1_bus_master *master;
 	struct w1_gpio_ddata *ddata;
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
 	/* Enforce open drain mode by default */
 	enum gpiod_flags gflags = GPIOD_OUT_LOW_OPEN_DRAIN;
 	int err;
@@ -91,7 +82,7 @@ static int w1_gpio_probe(struct platform_device *pdev)
 	 * driver it high/low like we are in full control of the line and
 	 * open drain will happen transparently.
 	 */
-	if (of_property_present(np, "linux,open-drain"))
+	if (device_property_present(dev, "linux,open-drain"))
 		gflags = GPIOD_OUT_LOW;
 
 	master = devm_kzalloc(dev, sizeof(struct w1_bus_master),
@@ -152,10 +143,16 @@ static void w1_gpio_remove(struct platform_device *pdev)
 	w1_remove_master_device(master);
 }
 
+static const struct of_device_id w1_gpio_dt_ids[] = {
+	{ .compatible = "w1-gpio" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, w1_gpio_dt_ids);
+
 static struct platform_driver w1_gpio_driver = {
 	.driver = {
 		.name	= "w1-gpio",
-		.of_match_table = of_match_ptr(w1_gpio_dt_ids),
+		.of_match_table = w1_gpio_dt_ids,
 	},
 	.probe = w1_gpio_probe,
 	.remove_new = w1_gpio_remove,
-- 
2.43.0.rc1.1.gbec44491f096


