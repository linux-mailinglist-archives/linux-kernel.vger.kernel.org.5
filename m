Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996587B6B44
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239160AbjJCOVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbjJCOVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:21:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389CDA3
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696342888; x=1727878888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nH6/xElzhCRroKyKoQcnlrqGQ0XvxKY1U2fGl3KnTzo=;
  b=WmT8enK10Hll+hywdge9KRDcCKA7s593O2cduwicx8SyfrtbHfJUeOAm
   sCvPLTL5+JcLaFd8tVl2q6JViHE0LFhtryBz+zAjQSKlUh6hwnCKN3xXq
   dLxuRIP5LbnRyIEk2UpzBucBkWP0tJHZ1dBBdpyd7RL3ju67ygPxJ5Nas
   TyEiS5DzOBykVpYCFM9/AhIcokV2b5f8UJRjac8UMxLGIYL0WwEGfWEa1
   iWFhNZU9yO2Ce7z/UUGotTWVwchmF5lNt5eQWzYLdz5D+Cpibm5y/8qTH
   RfIRZILKtg8b5yzkXhmmNKUMkVR/mF0laoEiHrzoByUdER1/nXxPFH/uE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="469163013"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="469163013"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 07:21:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="866892441"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="866892441"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 03 Oct 2023 07:21:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4785E18A0; Tue,  3 Oct 2023 17:21:25 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/4] driver core: platform: Refactor error path in a couple places
Date:   Tue,  3 Oct 2023 17:21:20 +0300
Message-Id: <20231003142122.3072824-2-andriy.shevchenko@linux.intel.com>
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

The usual pattern is to bail out on the error case. Besides that
one of the labels is redundant as we may return directly. Refactor
platform_device_add() and platform_dma_configure() accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/platform.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index d81f05c4fccd..2b8645911d51 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -678,7 +678,7 @@ int platform_device_add(struct platform_device *pdev)
 		 */
 		ret = ida_alloc(&platform_devid_ida, GFP_KERNEL);
 		if (ret < 0)
-			goto err_out;
+			return ret;
 		pdev->id = ret;
 		pdev->id_auto = true;
 		dev_set_name(&pdev->dev, "%s.%d.auto", pdev->name, pdev->id);
@@ -712,8 +712,10 @@ int platform_device_add(struct platform_device *pdev)
 		 dev_name(&pdev->dev), dev_name(pdev->dev.parent));
 
 	ret = device_add(&pdev->dev);
-	if (ret == 0)
-		return ret;
+	if (ret)
+		goto failed;
+
+	return 0;
 
  failed:
 	if (pdev->id_auto) {
@@ -727,7 +729,6 @@ int platform_device_add(struct platform_device *pdev)
 			release_resource(r);
 	}
 
- err_out:
 	return ret;
 }
 EXPORT_SYMBOL_GPL(platform_device_add);
@@ -1453,12 +1454,12 @@ static int platform_dma_configure(struct device *dev)
 		attr = acpi_get_dma_attr(to_acpi_device_node(dev->fwnode));
 		ret = acpi_dma_configure(dev, attr);
 	}
+	if (ret || drv->driver_managed_dma)
+		return ret;
 
-	if (!ret && !drv->driver_managed_dma) {
-		ret = iommu_device_use_default_domain(dev);
-		if (ret)
-			arch_teardown_dma_ops(dev);
-	}
+	ret = iommu_device_use_default_domain(dev);
+	if (ret)
+		arch_teardown_dma_ops(dev);
 
 	return ret;
 }
-- 
2.40.0.1.gaa8946217a0b

