Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE86787558
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242540AbjHXQ1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242634AbjHXQ1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:27:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2541FDC;
        Thu, 24 Aug 2023 09:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692894433; x=1724430433;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3+6axy8YcbF+Ei/Mg+uSsW6D9Griah2YTRGSppLrtTc=;
  b=Erys65rh0m/XHetNKeDgy6jmropszDhw0lTqTuKlSXPKKNJOouCgXD4u
   qxMQ+/HuxgBPBE6egI/0SsSF6OEcmU/AVQkcxQCed3Jv90YT/FpJg8svG
   ZLj9uOob+aWkkXty0VpJ7P/AvKk/GU/QbD3H+e+gINLhpszfBM7tkHCY/
   5qUcKDLX4OmjtMLuiLhusZ8ezGkUjX9kp96IlGn5zK2kFh4CES8QK/Llz
   GVKEMxilkq/YGT9f+zwbjuxtCrBrwwtJEPkwR52CIobhPHWaxRVE542+Z
   /tMChkJafW7cndu8zqOwljMXDVWwJJcCbyK1lxn7hIHVpehnOUZ6Ft7b1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="438440670"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="438440670"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 09:27:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="860780586"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="860780586"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 24 Aug 2023 09:27:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8B73BF4; Thu, 24 Aug 2023 19:27:06 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Rob Herring <robh@kernel.org>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Peng Fan <peng.fan@nxp.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] amba: bus: balance firmware node reference counting
Date:   Thu, 24 Aug 2023 19:26:54 +0300
Message-Id: <20230824162654.2890992-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the ACPI code doesn't bump the reference count of
the firmware node, while OF counter part does. Not that it's
a problem right now, since ACPI doesn't really use the reference
counting for firmware nodes, it still makes sense to make code
robust against any changes done there. For this,
 - switch ACPI case to use device_set_node() to be unified with OF
 - move reference counting to amba_device_add()
 - switch to use firmware nodes instead of OF ones

In the result we will have reference counting done in the same module
for all callers independently on the nature of firmware node behind.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/arm64/amba.c | 2 +-
 drivers/amba/bus.c        | 5 ++++-
 drivers/of/platform.c     | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/arm64/amba.c b/drivers/acpi/arm64/amba.c
index 60be8ee1dbdc..171b5c2c7edd 100644
--- a/drivers/acpi/arm64/amba.c
+++ b/drivers/acpi/arm64/amba.c
@@ -101,7 +101,7 @@ static int amba_handler_attach(struct acpi_device *adev,
 	if (parent)
 		dev->dev.parent = acpi_get_first_physical_node(parent);
 
-	ACPI_COMPANION_SET(&dev->dev, adev);
+	device_set_node(&dev->dev, acpi_fwnode_handle(adev));
 
 	ret = amba_device_add(dev, &iomem_resource);
 	if (ret) {
diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 09e72967b8ab..05d0209a6347 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -18,6 +18,7 @@
 #include <linux/limits.h>
 #include <linux/clk/clk-conf.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/reset.h>
 #include <linux/of_irq.h>
 #include <linux/of_device.h>
@@ -528,7 +529,7 @@ static void amba_device_release(struct device *dev)
 {
 	struct amba_device *d = to_amba_device(dev);
 
-	of_node_put(d->dev.of_node);
+	fwnode_handle_put(dev_fwnode(&d->dev);
 	if (d->res.parent)
 		release_resource(&d->res);
 	mutex_destroy(&d->periphid_lock);
@@ -548,6 +549,8 @@ int amba_device_add(struct amba_device *dev, struct resource *parent)
 {
 	int ret;
 
+	fwnode_handle_get(dev_fwnode(&dev->dev));
+
 	ret = request_resource(parent, &dev->res);
 	if (ret)
 		return ret;
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index f235ab55b91e..126d265aa7d8 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -273,7 +273,7 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 	dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
 
 	/* setup generic device info */
-	device_set_node(&dev->dev, of_fwnode_handle(of_node_get(node)));
+	device_set_node(&dev->dev, of_fwnode_handle(node));
 	dev->dev.parent = parent ? : &platform_bus;
 	dev->dev.platform_data = platform_data;
 	if (bus_id)
-- 
2.40.0.1.gaa8946217a0b

