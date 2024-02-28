Return-Path: <linux-kernel+bounces-85546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C13D86B776
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B64286F50
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238C674417;
	Wed, 28 Feb 2024 18:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YwkGRSfs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EFE71ECB;
	Wed, 28 Feb 2024 18:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709145862; cv=none; b=ExqFVdBUjauqLp0oDA+jdTvr0PKSNcFFkK4JaawyVIQJf3WhabxW8tf20WY+EywhTmEbQhlhxpAYHrDCtI5oVrdvNtKZ42Wf0KqNEhFr+HCBwUguVzJaNlA4NLgMZEwsYJ/n/NM0WHU1kO3iPUAcDg0Fk/J+y4//G7MB1C7crZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709145862; c=relaxed/simple;
	bh=8biQmZJ8AhqJZfhGvVVU/px0ynI0ARYoFmb5PEgvufc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JaXmVNN2xvan+R1pq3u+crUDhnFo7KC8TZOVPOLIiieECajSxIotvJULCSpCzw0CHQF7OZl+idZjT+b1VwUXiBD2Jx+VAu3w1TzXWNfdVMnIrNnb2SW3/gAxNLvz3TEQTRPnp/LVgB3Lifq/W/KOgS5K9qH9gXIHd+4g4CcSOHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YwkGRSfs; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709145861; x=1740681861;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8biQmZJ8AhqJZfhGvVVU/px0ynI0ARYoFmb5PEgvufc=;
  b=YwkGRSfs//SpbofC6jSrEClgrXKfRM5cXB+XdFE/ein8bf+ZO2lzXgCv
   S7cNPUpVmNUr1L+krVN1N2HmuNHlkvTo2AUzDDKR8lX+o//hKHURxzlHD
   W05yNKBAogpdT+EBpGCW34+9l7DAoInowCSG8fK61PF9+HV/Zfd7FM15M
   1iN+Q47tzYJ5Cjx3iDOajGlu6XTyT64YDgOT0UfgL/itYT1sAvr8dvQVI
   4yH2NyHNkTmYz4sxMbgL1YQuekzgh6HgDtyo2XWKoAiMTLfyVQDZdMTtV
   VIb4hTjkrKqVWKXUc3C+YSAYRWxsyrToqX9mto1fNEhXOCWRFIM69HKVE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="21023739"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="21023739"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 10:44:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="937034567"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="937034567"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2024 10:44:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2A521284; Wed, 28 Feb 2024 20:44:14 +0200 (EET)
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
Subject: [PATCH v1 2/2] gpiolib-acpi: Make acpi_gpio_count() take firmware node as a parameter
Date: Wed, 28 Feb 2024 20:40:47 +0200
Message-ID: <20240228184412.3591847-3-andriy.shevchenko@linux.intel.com>
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

Make acpi_gpio_count() take firmware node as a parameter in order
to be aligned with other functions and decouple form unused device
pointer. The latter helps to create a common fwnode_gpio_count()
in the future.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 13 ++++++-------
 drivers/gpio/gpiolib-acpi.h |  4 ++--
 drivers/gpio/gpiolib.c      |  2 +-
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 899cd505073e..7f140df40f35 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1402,17 +1402,17 @@ static int acpi_find_gpio_count(struct acpi_resource *ares, void *data)
 }
 
 /**
- * acpi_gpio_count - count the GPIOs associated with a device / function
- * @dev:	GPIO consumer, can be %NULL for system-global GPIOs
+ * acpi_gpio_count - count the GPIOs associated with a firmware node / function
+ * @fwnode:	firmware node of the GPIO consumer
  * @con_id:	function within the GPIO consumer
  *
  * Return:
- * The number of GPIOs associated with a device / function or %-ENOENT,
+ * The number of GPIOs associated with a firmware node / function or %-ENOENT,
  * if no GPIO has been assigned to the requested function.
  */
-int acpi_gpio_count(struct device *dev, const char *con_id)
+int acpi_gpio_count(const struct fwnode_handle *fwnode, const char *con_id)
 {
-	struct acpi_device *adev = ACPI_COMPANION(dev);
+	struct acpi_device *adev = to_acpi_device_node(fwnode);
 	const union acpi_object *obj;
 	const struct acpi_gpio_mapping *gm;
 	int count = -ENOENT;
@@ -1429,8 +1429,7 @@ int acpi_gpio_count(struct device *dev, const char *con_id)
 			snprintf(propname, sizeof(propname), "%s",
 				 gpio_suffixes[i]);
 
-		ret = acpi_dev_get_property(adev, propname, ACPI_TYPE_ANY,
-					    &obj);
+		ret = acpi_dev_get_property(adev, propname, ACPI_TYPE_ANY, &obj);
 		if (ret == 0) {
 			if (obj->type == ACPI_TYPE_LOCAL_REFERENCE)
 				count = 1;
diff --git a/drivers/gpio/gpiolib-acpi.h b/drivers/gpio/gpiolib-acpi.h
index 0fcd7e14d7f9..6f295ea580fe 100644
--- a/drivers/gpio/gpiolib-acpi.h
+++ b/drivers/gpio/gpiolib-acpi.h
@@ -33,7 +33,7 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
 				 enum gpiod_flags *dflags,
 				 unsigned long *lookupflags);
 
-int acpi_gpio_count(struct device *dev, const char *con_id);
+int acpi_gpio_count(const struct fwnode_handle *fwnode, const char *con_id);
 #else
 static inline void acpi_gpiochip_add(struct gpio_chip *chip) { }
 static inline void acpi_gpiochip_remove(struct gpio_chip *chip) { }
@@ -51,7 +51,7 @@ acpi_find_gpio(struct fwnode_handle *fwnode, const char *con_id,
 {
 	return ERR_PTR(-ENOENT);
 }
-static inline int acpi_gpio_count(struct device *dev, const char *con_id)
+static inline int acpi_gpio_count(const struct fwnode_handle *fwnode, const char *con_id)
 {
 	return -ENODEV;
 }
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index a93271b3d538..e6c5c7894553 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4287,7 +4287,7 @@ int gpiod_count(struct device *dev, const char *con_id)
 	if (is_of_node(fwnode))
 		count = of_gpio_count(fwnode, con_id);
 	else if (is_acpi_node(fwnode))
-		count = acpi_gpio_count(dev, con_id);
+		count = acpi_gpio_count(fwnode, con_id);
 	else if (is_software_node(fwnode))
 		count = swnode_gpio_count(fwnode, con_id);
 
-- 
2.43.0.rc1.1.gbec44491f096


