Return-Path: <linux-kernel+bounces-141398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C59F8A1DBD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAF18288AC0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F27B5381A;
	Thu, 11 Apr 2024 17:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lXUpBEwj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D968D2BB1C;
	Thu, 11 Apr 2024 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712856403; cv=none; b=fsKFYvI/BHuXPKbBLRMSj9GSkuHYl6RKBM9Sln7YJsmw3DZkc8kqUzNPcEuId2GyDf/rZFtUNVy36p0BMOciptXXIR7PR+UyD2oEIPueMd+L29ZnK1AONWV94Mpsl6Niq9er8SyNj40tW6+80v6rn6ga51C6ePGV9itN1pGpIoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712856403; c=relaxed/simple;
	bh=GCmd6EWyeSI61/ahtWxVMlmLMfAP5vYzOKp2NSFA8/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJRwNbflxCE4pfb2GRrrk8MsaCD8fQJCMRYFTVoO+BVdCSk0U3gmgqcupmYu4vfdcGWxkSdtRmKp1F6momeKD4X7X6lCUPkttTQs70qsrrAxZJhfFiW9URW21FCUFrLAjy0pZaLH2ZEJgI0QNvjTZI8T6OnSWQzJqGYz4XIH1Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lXUpBEwj; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712856402; x=1744392402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GCmd6EWyeSI61/ahtWxVMlmLMfAP5vYzOKp2NSFA8/I=;
  b=lXUpBEwju9hHwDYAjqGVNgAjmo0NkZOY1QhOmqvKWy6+UB4UqtjAIW67
   AQdBo5iuUslUnKqawseAgZuhR+fQSLosCw0tLyVRfcMx6haf3KF0K4xBi
   x7D+wDCIQkTrvfYYYO1p8C8a76/MEhNg7tJi4sD3hBq81rkOZ9waJysEn
   w9ZSfkXMcGxN5AocoWMOVM1mYJHABf2vpdhXf0a16FjdyLg5l7nElXrzV
   r7D6q7lgYeckKGaKoOiU4r8MI//+82NKbK+HVeUj9J1nJSBqdW31nF+i/
   HazS+1inMFLuE2YUiyaN9CFBi865HOAMvU3gfg3Jjfk8J0tTNj6ilfKta
   w==;
X-CSE-ConnectionGUID: FNuNgM5kReSxgswtEStJpQ==
X-CSE-MsgGUID: APbE3zVKSHmKWiPsliT4tQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="18844992"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="18844992"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 10:26:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="937097271"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="937097271"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 11 Apr 2024 10:26:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0AE03161; Thu, 11 Apr 2024 20:26:33 +0300 (EEST)
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
Subject: [PATCH v1 1/4] gpiolib: acpi: Extract __acpi_find_gpio() helper
Date: Thu, 11 Apr 2024 20:22:29 +0300
Message-ID: <20240411172540.4122581-3-andriy.shevchenko@linux.intel.com>
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

We want to reuse it later on in the code. In particular, it helps
to clean up the users of acpi_dev_gpio_irq_wake_get_by().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index c2a33beeec50..d47b22ac3ecb 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -945,14 +945,11 @@ static bool acpi_can_fallback_to_crs(struct acpi_device *adev,
 	return con_id == NULL;
 }
 
-struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
-				 const char *con_id,
-				 unsigned int idx,
-				 enum gpiod_flags *dflags,
-				 unsigned long *lookupflags)
+static struct gpio_desc *
+__acpi_find_gpio(struct fwnode_handle *fwnode, const char *con_id, unsigned int idx,
+		 struct acpi_gpio_info *info)
 {
 	struct acpi_device *adev = to_acpi_device_node(fwnode);
-	struct acpi_gpio_info info;
 	struct gpio_desc *desc;
 	char propname[32];
 	int i;
@@ -969,10 +966,10 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
 
 		if (adev)
 			desc = acpi_get_gpiod_by_index(adev,
-						       propname, idx, &info);
+						       propname, idx, info);
 		else
 			desc = acpi_get_gpiod_from_data(fwnode,
-						        propname, idx, &info);
+							propname, idx, info);
 		if (PTR_ERR(desc) == -EPROBE_DEFER)
 			return ERR_CAST(desc);
 
@@ -985,11 +982,28 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
 		if (!adev || !acpi_can_fallback_to_crs(adev, con_id))
 			return ERR_PTR(-ENOENT);
 
-		desc = acpi_get_gpiod_by_index(adev, NULL, idx, &info);
+		desc = acpi_get_gpiod_by_index(adev, NULL, idx, info);
 		if (IS_ERR(desc))
 			return desc;
 	}
 
+	return desc;
+}
+
+struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
+				 const char *con_id,
+				 unsigned int idx,
+				 enum gpiod_flags *dflags,
+				 unsigned long *lookupflags)
+{
+	struct acpi_device *adev = to_acpi_device_node(fwnode);
+	struct acpi_gpio_info info;
+	struct gpio_desc *desc;
+
+	desc = __acpi_find_gpio(fwnode, con_id, idx, &info);
+	if (IS_ERR(desc))
+		return desc;
+
 	if (info.gpioint &&
 	    (*dflags == GPIOD_OUT_LOW || *dflags == GPIOD_OUT_HIGH)) {
 		dev_dbg(&adev->dev, "refusing GpioInt() entry when doing GPIOD_OUT_* lookup\n");
-- 
2.43.0.rc1.1336.g36b5255a03ac


