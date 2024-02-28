Return-Path: <linux-kernel+bounces-85545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DFB86B774
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC5828710E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0335174414;
	Wed, 28 Feb 2024 18:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fM8uzBi0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FFE71EC4;
	Wed, 28 Feb 2024 18:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709145862; cv=none; b=NT3Rq8dE4QsufYb+SFFGpHyMfKUkL1hBhaY6leAsAXBQ8nHrP46hzrrktoHF6fG4bXlpNqYGMOwn4lNdxjswVUW2/skeoxwtcR77TPR/K04O77HF5DTGTVCa3UixcPsXollKlcl4uvushmOQd6Fdd5z7D4ZiC9PMP36Y8tPxBLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709145862; c=relaxed/simple;
	bh=xSiXX6AESAZ90Y56jbiUou7HsIyzjfLMjTWugNAhrBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8K9xo1vbwqA3EUMS/yvphAE1TCf3CBtFSRiLP823KVWz93fxnDZPBjCCRxZ2Krzmq8O1wVwgN6FRDzgwZjSp6/PhpmLHI4ov6uKMysgHZisMuk3mermf6WxH/cv5erhEE2r/9mepecVrv+38mvagqCtwcpGkxZUqyFaRbgqVZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fM8uzBi0; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709145860; x=1740681860;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xSiXX6AESAZ90Y56jbiUou7HsIyzjfLMjTWugNAhrBg=;
  b=fM8uzBi0p95/NvqrQertqOfsbUwAf9QDV3tOdrURwDHF5ydH1431YCBh
   n4Fib6OaZc3mU/fK60IHK7wHBQjCDs2pFVE+ttAEcqeOhe26NNewWlYEA
   tF6ZfChup3R/yAwnwG8hxqTVr3tclh7qFBzqq/QUJz7/+o7QeXTUZGCFV
   qdVPpLKSOnVxZvIZP0fU6pC7O8EBkRTBJVywuP7q2hlPNidUnlqFiW0Sy
   /tn9+ibk9xxNursBTmqN3uUYNGT+rqX7yW8pSXkPu8igB3WBBuaSpersc
   5O8sYl5cRYCnVecOjK2VHMMOrc/1Bse+DjdLwqlXZdehMufNAMFSeUdB+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="21023737"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="21023737"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 10:44:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="937034566"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="937034566"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2024 10:44:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 19F7D192; Wed, 28 Feb 2024 20:44:14 +0200 (EET)
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
Subject: [PATCH v1 1/2] gpiolib-of: Make of_gpio_get_count() take firmware node as a parameter
Date: Wed, 28 Feb 2024 20:40:46 +0200
Message-ID: <20240228184412.3591847-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240228184412.3591847-1-andriy.shevchenko@linux.intel.com>
References: <20240228184412.3591847-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make of_gpio_get_count() take firmware node as a parameter in order
to be aligned with other functions and decouple form unused device
pointer. The latter helps to create a common fwnode_gpio_count()
in the future.

While at it, rename to be of_gpio_count() to be aligned with the others.

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


