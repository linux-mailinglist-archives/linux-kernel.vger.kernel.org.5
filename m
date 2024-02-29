Return-Path: <linux-kernel+bounces-86876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E918286CC1B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198711C21AFF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BED2137773;
	Thu, 29 Feb 2024 14:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LHQ4tyJt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C26137747;
	Thu, 29 Feb 2024 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709218390; cv=none; b=pAbPwFclxXzkYFYtsmZ2TEJpx65iF/21YbjpX+HW2O3Z0+SwqR6KiiewkG7JtLxIHE308jWE6F1yC5tFmHspgYDahAZBAfZNn1WmC31doPtj2CJsmkyQgnvew3W4RMBYWE9gWdmSPA406XtN2aUal/nyQaL53QsiVgep/RNvv8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709218390; c=relaxed/simple;
	bh=wWSgyr0hdjqLu+2X6KWDqneEgrO6SAcjS23aDbCvptw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LYnqHy5SkoO0B6nvdDLJcFuYqBjONnB/qSKXDzY1/PAdfM2EDG2TPHS1qYGnFM8xPMoZEdOxpzkgAr97giJ91darU+FVtWpkIxqvoW4fp9gXrZcxFB2AUQS19LSlamS5JMYdOjr6L8bvYHxAkhnJcw3E2qA/4S4LNI8e7jM5EvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LHQ4tyJt; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709218389; x=1740754389;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wWSgyr0hdjqLu+2X6KWDqneEgrO6SAcjS23aDbCvptw=;
  b=LHQ4tyJtQ54gHnskyX9RlFs7Ax2bVstc7zYnZ6CRdG5ABvNfA4Yt5lx4
   X7g8dkxrRGeSYdQ05vHPI6/vetT4Jl4+SUICU5Dx1X+/ynE+z8RHi/v8i
   AEQA2dFVylhP0f6w7Lvtn6bYSXvCLC0mBPDClq537OqrhF5ibGbcl2ocq
   jLRUUYQqvyjgWuTSL2SZrTB+L7h3Ou7NE+XWAHbJi7+60RhvWFJqQ/dva
   5Qkp+X0Shv05wYj4e4rw9xiuYwMhxIDucPR4udVeCDbek+C/5AWYe+jrF
   3WBDlmcKLETnxlxIIE22a8hz7ArwsC6rK0Lls2sx4dCtphRJQ1AvE4jYB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14326500"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="14326500"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 06:53:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="937036060"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="937036060"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 29 Feb 2024 06:53:06 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E458E19F; Thu, 29 Feb 2024 16:53:04 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Subject: [PATCH v2 1/2] gpiolib-of: Make of_gpio_get_count() take firmware node as a parameter
Date: Thu, 29 Feb 2024 16:51:38 +0200
Message-ID: <20240229145303.3801332-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240229145303.3801332-1-andriy.shevchenko@linux.intel.com>
References: <20240229145303.3801332-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make of_gpio_get_count() take firmware node as a parameter in order
to be aligned with other functions and decouple from unused device
pointer. The latter helps to create a common fwnode_gpio_count()
in the future.

While at it, rename to be of_gpio_count() to be aligned with the others.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-of.c | 13 ++++++-------
 drivers/gpio/gpiolib-of.h |  5 +++--
 drivers/gpio/gpiolib.c    |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index e35a9c7da4ee..c0eae8924074 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -68,7 +68,7 @@ static int of_gpio_named_count(const struct device_node *np,
 
 /**
  * of_gpio_spi_cs_get_count() - special GPIO counting for SPI
- * @dev:    Consuming device
+ * @np:    Consuming device node
  * @con_id: Function within the GPIO consumer
  *
  * Some elder GPIO controllers need special quirks. Currently we handle
@@ -78,10 +78,8 @@ static int of_gpio_named_count(const struct device_node *np,
  * the counting of "cs-gpios" to count "gpios" transparent to the
  * driver.
  */
-static int of_gpio_spi_cs_get_count(struct device *dev, const char *con_id)
+static int of_gpio_spi_cs_get_count(const struct device_node *np, const char *con_id)
 {
-	struct device_node *np = dev->of_node;
-
 	if (!IS_ENABLED(CONFIG_SPI_MASTER))
 		return 0;
 	if (!con_id || strcmp(con_id, "cs"))
@@ -93,13 +91,14 @@ static int of_gpio_spi_cs_get_count(struct device *dev, const char *con_id)
 	return of_gpio_named_count(np, "gpios");
 }
 
-int of_gpio_get_count(struct device *dev, const char *con_id)
+int of_gpio_count(const struct fwnode_handle *fwnode, const char *con_id)
 {
+	const struct device_node *np = to_of_node(fwnode);
 	int ret;
 	char propname[32];
 	unsigned int i;
 
-	ret = of_gpio_spi_cs_get_count(dev, con_id);
+	ret = of_gpio_spi_cs_get_count(np, con_id);
 	if (ret > 0)
 		return ret;
 
@@ -111,7 +110,7 @@ int of_gpio_get_count(struct device *dev, const char *con_id)
 			snprintf(propname, sizeof(propname), "%s",
 				 gpio_suffixes[i]);
 
-		ret = of_gpio_named_count(dev->of_node, propname);
+		ret = of_gpio_named_count(np, propname);
 		if (ret > 0)
 			break;
 	}
diff --git a/drivers/gpio/gpiolib-of.h b/drivers/gpio/gpiolib-of.h
index 6b3a5347c5d9..19988c1354fa 100644
--- a/drivers/gpio/gpiolib-of.h
+++ b/drivers/gpio/gpiolib-of.h
@@ -9,6 +9,7 @@
 #include <linux/notifier.h>
 
 struct device;
+struct fwnode_handle;
 
 struct gpio_chip;
 struct gpio_desc;
@@ -21,7 +22,7 @@ struct gpio_desc *of_find_gpio(struct device_node *np,
 			       unsigned long *lookupflags);
 int of_gpiochip_add(struct gpio_chip *gc);
 void of_gpiochip_remove(struct gpio_chip *gc);
-int of_gpio_get_count(struct device *dev, const char *con_id);
+int of_gpio_count(const struct fwnode_handle *fwnode, const char *con_id);
 #else
 static inline struct gpio_desc *of_find_gpio(struct device_node *np,
 					     const char *con_id,
@@ -32,7 +33,7 @@ static inline struct gpio_desc *of_find_gpio(struct device_node *np,
 }
 static inline int of_gpiochip_add(struct gpio_chip *gc) { return 0; }
 static inline void of_gpiochip_remove(struct gpio_chip *gc) { }
-static inline int of_gpio_get_count(struct device *dev, const char *con_id)
+static inline int of_gpio_count(const struct fwnode_handle *fwnode, const char *con_id)
 {
 	return 0;
 }
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 5fa3bf7b55bd..a93271b3d538 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4285,7 +4285,7 @@ int gpiod_count(struct device *dev, const char *con_id)
 	int count = -ENOENT;
 
 	if (is_of_node(fwnode))
-		count = of_gpio_get_count(dev, con_id);
+		count = of_gpio_count(fwnode, con_id);
 	else if (is_acpi_node(fwnode))
 		count = acpi_gpio_count(dev, con_id);
 	else if (is_software_node(fwnode))
-- 
2.43.0.rc1.1.gbec44491f096


