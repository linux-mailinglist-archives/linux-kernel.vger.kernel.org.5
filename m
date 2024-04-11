Return-Path: <linux-kernel+bounces-141399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 397918A1DBE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E1671C23F76
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0A953E35;
	Thu, 11 Apr 2024 17:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NsMKiE9v"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA03481D0;
	Thu, 11 Apr 2024 17:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712856403; cv=none; b=bMXZTxA6jGK54c7dBPSMdjd6cd0gwAximCRXYdhFARzEcv4FlqOMTqSshtE66rGEGwQKfD0OcKRFNo4vVMy+ezuvEUwl0XxLhwi9zKsb4FIct3EYpbGl6036JCvJI64tUDLBIwqZlYWi+bubcjDpdnnRqACF/oQV5aAhijmo4+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712856403; c=relaxed/simple;
	bh=u78Kx86bou/Qgx7a5ckaEBe5SvOXz81P3wk/GtmrwyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F052B+bbmNlaz5JOMMEdokBC2shKZRDXNMFvg3lJSzawNCLfdTYz0HZ/Vfj155JcjlJVbfnMuCq35ivsx7skiEP3aF25/yQ9KluBZTumSQGDMRCSHQT8RntMaaxbfeoi6Yxwg2GCN+/m4qBmL/MvEJiSGBKuSGSutwrSvslimn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NsMKiE9v; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712856403; x=1744392403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u78Kx86bou/Qgx7a5ckaEBe5SvOXz81P3wk/GtmrwyA=;
  b=NsMKiE9v0ZMskQyoOA+EmvLlz5l4FuOiSqs/SYivkOprx4VitNH6c1nV
   MGaAC0/HWsvvoeUj99QjpltURYDltsuvMY40gb9WrQJIZvpCGTBqtNZ4F
   O1ZoK8AQSD3pHqVgNKN9kwx7P4Hay8stBiTUHcAASPfLf9Chen6wN+rFM
   Tcg5JB046WOA3iqp0CZNOWhqntbP8vTVavgWvvFBJy81MgHRN4RijucWW
   Kjww3v6okCwYdoqcu4aYSir+tXQIAzt79jmw6ZeQPgMIVZkVKDTSEIXh3
   4+i40UHJwZaAEFaqpHoaNq7fEqgx9ZHTXSAEK53Y1XZZw2X/VJm0VH/CU
   A==;
X-CSE-ConnectionGUID: +EvSGvfATAyX92W2M8vrGg==
X-CSE-MsgGUID: Khutd0m1SuCm6l/2Sx5CMQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="18845018"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="18845018"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 10:26:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="937097274"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="937097274"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 11 Apr 2024 10:26:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3558B73E; Thu, 11 Apr 2024 20:26:34 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Thompson <davthompson@nvidia.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH v1 4/4] gpiolib: acpi: Pass con_id instead of property into acpi_dev_gpio_irq_get_by()
Date: Thu, 11 Apr 2024 20:22:32 +0300
Message-ID: <20240411172540.4122581-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240411172540.4122581-2-andriy.shevchenko@linux.intel.com>
References: <20240411172540.4122581-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass the con_id instead of property so that callers won't repeat
the GPIO suffixes to try.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-pca953x.c                           |  2 +-
 drivers/gpio/gpiolib-acpi.c                           | 11 +++++------
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c    |  2 +-
 drivers/pinctrl/pinctrl-cy8c95x0.c                    |  2 +-
 include/linux/acpi.h                                  |  8 ++++----
 5 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 00ffa168e405..77a2812f2974 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -144,7 +144,7 @@ static int pca953x_acpi_get_irq(struct device *dev)
 	if (ret)
 		dev_warn(dev, "can't add GPIO ACPI mapping\n");
 
-	ret = acpi_dev_gpio_irq_get_by(ACPI_COMPANION(dev), "irq-gpios", 0);
+	ret = acpi_dev_gpio_irq_get_by(ACPI_COMPANION(dev), "irq", 0);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 2b3fd43b13fc..909113312a1b 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1013,7 +1013,7 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
 /**
  * acpi_dev_gpio_irq_wake_get_by() - Find GpioInt and translate it to Linux IRQ number
  * @adev: pointer to a ACPI device to get IRQ from
- * @name: optional name of GpioInt resource
+ * @con_id: optional name of GpioInt resource
  * @index: index of GpioInt resource (starting from %0)
  * @wake_capable: Set to true if the IRQ is wake capable
  *
@@ -1024,15 +1024,15 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
  * The function is idempotent, though each time it runs it will configure GPIO
  * pin direction according to the flags in GpioInt resource.
  *
- * The function takes optional @name parameter. If the resource has a property
- * name, then only those will be taken into account.
+ * The function takes optional @con_id parameter. If the resource has
+ * a @con_id in a property, then only those will be taken into account.
  *
  * The GPIO is considered wake capable if the GpioInt resource specifies
  * SharedAndWake or ExclusiveAndWake.
  *
  * Return: Linux IRQ number (> %0) on success, negative errno on failure.
  */
-int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *name, int index,
+int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *con_id, int index,
 				  bool *wake_capable)
 {
 	int idx, i;
@@ -1043,9 +1043,8 @@ int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *name, in
 		struct acpi_gpio_info info;
 		struct gpio_desc *desc;
 
-		desc = acpi_get_gpiod_by_index(adev, name, i, &info);
-
 		/* Ignore -EPROBE_DEFER, it only matters if idx matches */
+		desc = __acpi_find_gpio(acpi_fwnode_handle(adev), con_id, i, true, &info);
 		if (IS_ERR(desc) && PTR_ERR(desc) != -EPROBE_DEFER)
 			return PTR_ERR(desc);
 
diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
index ba303868686a..b157f0f1c5a8 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
@@ -436,7 +436,7 @@ static int mlxbf_gige_probe(struct platform_device *pdev)
 	priv->rx_irq = platform_get_irq(pdev, MLXBF_GIGE_RECEIVE_PKT_INTR_IDX);
 	priv->llu_plu_irq = platform_get_irq(pdev, MLXBF_GIGE_LLU_PLU_INTR_IDX);
 
-	phy_irq = acpi_dev_gpio_irq_get_by(ACPI_COMPANION(&pdev->dev), "phy-gpios", 0);
+	phy_irq = acpi_dev_gpio_irq_get_by(ACPI_COMPANION(&pdev->dev), "phy", 0);
 	if (phy_irq < 0) {
 		dev_err(&pdev->dev, "Error getting PHY irq. Use polling instead");
 		phy_irq = PHY_POLL;
diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 67b5d160c027..981c569bd671 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -95,7 +95,7 @@ static int cy8c95x0_acpi_get_irq(struct device *dev)
 	if (ret)
 		dev_warn(dev, "can't add GPIO ACPI mapping\n");
 
-	ret = acpi_dev_gpio_irq_get_by(ACPI_COMPANION(dev), "irq-gpios", 0);
+	ret = acpi_dev_gpio_irq_get_by(ACPI_COMPANION(dev), "irq", 0);
 	if (ret < 0)
 		return ret;
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 34829f2c517a..35aff121f418 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1233,7 +1233,7 @@ bool acpi_gpio_get_irq_resource(struct acpi_resource *ares,
 				struct acpi_resource_gpio **agpio);
 bool acpi_gpio_get_io_resource(struct acpi_resource *ares,
 			       struct acpi_resource_gpio **agpio);
-int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *name, int index,
+int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *con_id, int index,
 				  bool *wake_capable);
 #else
 static inline bool acpi_gpio_get_irq_resource(struct acpi_resource *ares,
@@ -1246,7 +1246,7 @@ static inline bool acpi_gpio_get_io_resource(struct acpi_resource *ares,
 {
 	return false;
 }
-static inline int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *name,
+static inline int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *con_id,
 						int index, bool *wake_capable)
 {
 	return -ENXIO;
@@ -1259,10 +1259,10 @@ static inline int acpi_dev_gpio_irq_wake_get(struct acpi_device *adev, int index
 	return acpi_dev_gpio_irq_wake_get_by(adev, NULL, index, wake_capable);
 }
 
-static inline int acpi_dev_gpio_irq_get_by(struct acpi_device *adev, const char *name,
+static inline int acpi_dev_gpio_irq_get_by(struct acpi_device *adev, const char *con_id,
 					   int index)
 {
-	return acpi_dev_gpio_irq_wake_get_by(adev, name, index, NULL);
+	return acpi_dev_gpio_irq_wake_get_by(adev, con_id, index, NULL);
 }
 
 static inline int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
-- 
2.43.0.rc1.1336.g36b5255a03ac


