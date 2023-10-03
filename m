Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CA77B6B48
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239745AbjJCOVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbjJCOVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:21:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2573A3
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696342892; x=1727878892;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j3kdwf0LdnLVTQ4FuaLUWwuPbn9T770CstnHU485LSs=;
  b=CJL3iuzM4HDmy2v9cwfJKuKDmEHE8OcUHmLjShPQjm719kQ6ixZmjHBc
   BzfIKN4KzGAeGeYvir033sIN3KfXBHF8dRn3j31qVJ726dkoALtG8Z+Zm
   TsbklLyVF/Ur3o9qMijlsp7sfwm1EwCPiL9XsUK4N6KI4fEAMfOv8hdLq
   J7bKv8WTpC7X6E4AIKGDZPXGzdfx7veYLPsJqDg787t13/VYZUzeOVGYR
   yaPrJSeUL6f8KoY2aiHb+txF977MsW7mT9zOTeF7OTJ1LU9mpCcDt14cc
   zr3jTf3bc4Qberx2r+GREdgUH0GqExONCIlSeIfDGkL5L/jUfNgI5mi4Y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="380162453"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="380162453"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 07:21:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="841374160"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="841374160"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Oct 2023 07:21:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5BFF318B4; Tue,  3 Oct 2023 17:21:25 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/4] driver core: platform: Unify the firmware node type check
Date:   Tue,  3 Oct 2023 17:21:22 +0300
Message-Id: <20231003142122.3072824-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231003142122.3072824-1-andriy.shevchenko@linux.intel.com>
References: <20231003142122.3072824-1-andriy.shevchenko@linux.intel.com>
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

OF and ACPI currently are using asymmetrical APIs to check
for the firmware node type. Unify them by using is_*_node()
against struct fwnode_handle pointer.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/platform.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 55891c11dd03..828908d1d5b9 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -178,18 +178,19 @@ int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
 	ret = dev->archdata.irqs[num];
 	goto out;
 #else
+	struct fwnode_handle *fwnode = dev_fwnode(&dev->dev);
 	struct resource *r;
 
-	if (IS_ENABLED(CONFIG_OF_IRQ) && dev->dev.of_node) {
-		ret = of_irq_get(dev->dev.of_node, num);
+	if (is_of_node(fwnode)) {
+		ret = of_irq_get(to_of_node(fwnode), num);
 		if (ret > 0 || ret == -EPROBE_DEFER)
 			goto out;
 	}
 
 	r = platform_get_resource(dev, IORESOURCE_IRQ, num);
-	if (has_acpi_companion(&dev->dev)) {
+	if (is_acpi_device_node(fwnode)) {
 		if (r && r->flags & IORESOURCE_DISABLED) {
-			ret = acpi_irq_get(ACPI_HANDLE(&dev->dev), num, r);
+			ret = acpi_irq_get(ACPI_HANDLE_FWNODE(fwnode), num, r);
 			if (ret)
 				goto out;
 		}
@@ -222,8 +223,8 @@ int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
 	 * the device will only expose one IRQ, and this fallback
 	 * allows a common code path across either kind of resource.
 	 */
-	if (num == 0 && has_acpi_companion(&dev->dev)) {
-		ret = acpi_dev_gpio_irq_get(ACPI_COMPANION(&dev->dev), num);
+	if (num == 0 && is_acpi_device_node(fwnode)) {
+		ret = acpi_dev_gpio_irq_get(to_acpi_device_node(fwnode), num);
 		/* Our callers expect -ENXIO for missing IRQs. */
 		if (ret >= 0 || ret == -EPROBE_DEFER)
 			goto out;
@@ -312,7 +313,7 @@ static void devm_platform_get_irqs_affinity_release(struct device *dev,
 	for (i = 0; i < ptr->count; i++) {
 		irq_dispose_mapping(ptr->irq[i]);
 
-		if (has_acpi_companion(dev))
+		if (is_acpi_device_node(dev_fwnode(dev)))
 			platform_disable_acpi_irq(to_platform_device(dev), i);
 	}
 }
@@ -1446,13 +1447,14 @@ static void platform_shutdown(struct device *_dev)
 static int platform_dma_configure(struct device *dev)
 {
 	struct platform_driver *drv = to_platform_driver(dev->driver);
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	enum dev_dma_attr attr;
 	int ret = 0;
 
-	if (dev->of_node) {
-		ret = of_dma_configure(dev, dev->of_node, true);
-	} else if (has_acpi_companion(dev)) {
-		attr = acpi_get_dma_attr(to_acpi_device_node(dev->fwnode));
+	if (is_of_node(fwnode)) {
+		ret = of_dma_configure(dev, to_of_node(fwnode), true);
+	} else if (is_acpi_device_node(fwnode)) {
+		attr = acpi_get_dma_attr(to_acpi_device_node(fwnode));
 		ret = acpi_dma_configure(dev, attr);
 	}
 	if (ret || drv->driver_managed_dma)
-- 
2.40.0.1.gaa8946217a0b

