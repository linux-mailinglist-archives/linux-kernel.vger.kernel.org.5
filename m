Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E77D7B5421
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237416AbjJBNck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237376AbjJBNcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:32:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3F494;
        Mon,  2 Oct 2023 06:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696253553; x=1727789553;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IAF3ppOCz/aKQLdQ1DG/jiVmbimLG/74kbOGxZWwpS8=;
  b=JbhMa85JLfTKUbnBkegAt91KAyBCW7SYAHX4/QjGeElPRgVCT4C5xhvg
   JOe2mv6Yl4Rh5Z30/67AQzrVb8YeVW4U2IGmJ6eZferMwGt8Q+hK4n368
   krHRLFp90cNLuzuVGs62xRshSURGz5mWDTXAcSvzEFjFHXe/ODzzDJrFa
   Ls5Fr6HS5AlEF2mhcdd+DYI+5z6zbiTHBAUnrnQxnlDyrYpnt/o+37IcS
   IYtqoUcpZo8kq86DxgB3dpgvlUiuELcvrZZWiQNnd1HZ99JvpRJv0pd1B
   C7FUcwgmGj+XoxrQJ6TrI5HlgT9vXh/KEjiR8pizmUOsL2l+GwH5QuxBk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="379923423"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="379923423"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 06:26:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="754048987"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="754048987"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 02 Oct 2023 06:26:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 216472FF; Mon,  2 Oct 2023 16:26:41 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 1/2] amba: bus: balance firmware node reference counting
Date:   Mon,  2 Oct 2023 16:26:34 +0300
Message-Id: <20231002132635.2595382-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

v2: fixed compilation error (LKP), all dependencies are in v6.6-rcX (Rob)

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
index 09e72967b8ab..a24c152bfaac 100644
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
+	fwnode_handle_put(dev_fwnode(&d->dev));
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

