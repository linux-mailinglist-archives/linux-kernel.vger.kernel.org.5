Return-Path: <linux-kernel+bounces-119663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A16F688CBB5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5816F1F84AE7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BD313CC60;
	Tue, 26 Mar 2024 18:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="As2Lq/oM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4823A127B47;
	Tue, 26 Mar 2024 18:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476645; cv=none; b=eS5mb16/nbwYFCx4Up8yKD9GSpV4P8tIx0H/WBY6JruGMqn8IadjFQDYcuie1qs9S3pMfE0oKPrNCv4wgeJjHdgNP7f9C+VHqFbvDwjKSMWWCXOBMFZ50tLjs+0fE/XK0W7qWsfWwIxDVpDfXISRv1EgSR5WcV9QeIvn4ijQiXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476645; c=relaxed/simple;
	bh=OHu0e1fzfnbbh01dHJSe36zf7TwpFULLxcAa0gHl81c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NOtwd9KJQD8MYH6WA5HGrvd2jdVqwbDCxylj0IC8Rytvja/IVk7+7m0EGqaHdV/+4rPVyipDV12wfnk0O8h99t6Ohu3/zbhi2eg9iHoDUqXi+u6cY3np1zTEcUvF644BY8XVdQDYbYuAxmzwbx+3DrPtBhujCuY2bH68LbdVmO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=As2Lq/oM; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711476644; x=1743012644;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OHu0e1fzfnbbh01dHJSe36zf7TwpFULLxcAa0gHl81c=;
  b=As2Lq/oMhSkiu8Tu5PeLxbR1h0Z/xZjRs+w76emK5jKmaUmWtB9/qmGQ
   uZ8WaIKUqqobQlB0r1jrfcYpGYWKX4g3P/ALMcgZIdewfTZMDlSXm/ipI
   g5lQ9s+y+WKTyNXiiTCskDps7pZ3DT0nOgAkfwrKK+Onq5kAm8T/OpdUR
   q3mADE15eTsDdfOHagYNhwW0amyNMCaGv/i320GBSQQPOYudfCa0EflbR
   7ly+Pk7ulnWwDkmUZvk0mRP4K7lUYWfTUx245ohiofl3owA4mozgyiVZi
   x2yTMdWipGox31wjHfVgpp5oMOKH2dlOwi5ygOd2sgj8Ns2f6dFAJr8vD
   g==;
X-CSE-ConnectionGUID: Mlw5AjbAQDat/tewN6/u1w==
X-CSE-MsgGUID: 6P8Vzni/RT2yq3G2AVU80A==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="10325711"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="10325711"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 11:10:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="937072942"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="937072942"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Mar 2024 11:10:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2A608E2E; Tue, 26 Mar 2024 20:10:35 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH v1 07/10] spi: pxa2xx: Provide num-cs for Sharp PDAs via device properties
Date: Tue, 26 Mar 2024 20:07:57 +0200
Message-ID: <20240326181027.1418989-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240326181027.1418989-1-andriy.shevchenko@linux.intel.com>
References: <20240326181027.1418989-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since driver can parse num-cs device property, replace platform data
with this new approach.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/arm/mach-pxa/spitz.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 318402ad685e..3c5f5a3cb480 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -18,10 +18,10 @@
 #include <linux/i2c.h>
 #include <linux/platform_data/i2c-pxa.h>
 #include <linux/platform_data/pca953x.h>
+#include <linux/property.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 #include <linux/spi/corgi_lcd.h>
-#include <linux/spi/pxa2xx_spi.h>
 #include <linux/mtd/sharpsl.h>
 #include <linux/mtd/physmap.h>
 #include <linux/input-event-codes.h>
@@ -569,10 +569,6 @@ static struct spi_board_info spitz_spi_devices[] = {
 	},
 };
 
-static struct pxa2xx_spi_controller spitz_spi_info = {
-	.num_chipselect	= 3,
-};
-
 static struct gpiod_lookup_table spitz_spi_gpio_table = {
 	.dev_id = "spi2",
 	.table = {
@@ -583,10 +579,20 @@ static struct gpiod_lookup_table spitz_spi_gpio_table = {
 	},
 };
 
+static const struct property_entry spitz_spi_properties[] = {
+	PROPERTY_ENTRY_U32("num-cs", 3),
+	{ }
+};
+
+static const struct software_node spitz_spi_node = {
+	.properties = spitz_spi_properties,
+};
+
 static void __init spitz_spi_init(void)
 {
 	struct platform_device *pd;
 	int id = 2;
+	int err;
 
 	if (machine_is_akita())
 		gpiod_add_lookup_table(&akita_lcdcon_gpio_table);
@@ -601,8 +607,13 @@ static void __init spitz_spi_init(void)
 	if (pd == NULL) {
 		pr_err("pxa2xx-spi: failed to allocate device id %d\n", id);
 	} else {
-		pd->dev.platform_data = &spitz_spi_info;
-		platform_device_add(pd);
+		err = device_add_software_node(&pd->dev, &spitz_spi_node);
+		if (err) {
+			platform_device_put(pd);
+			pr_err("pxa2xx-spi: failed to add software node\n");
+		} else {
+			platform_device_add(pd);
+		}
 	}
 
 	spi_register_board_info(ARRAY_AND_SIZE(spitz_spi_devices));
-- 
2.43.0.rc1.1.gbec44491f096


