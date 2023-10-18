Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D997CEBD0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjJRXR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjJRXQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:16:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2DD137;
        Wed, 18 Oct 2023 16:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697670992; x=1729206992;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=tT6v07z/aEzJofzP9mclW5quS4WFjstuU/PBm1R8Ji0=;
  b=Gv8yrTTZ+SxAY6B32oUp0G2YTMPjh8BErssICi3WZI5UOJnceSKwBkSW
   XypJJ3XK50EjCIi+Ji/ulp5zMpS/vbLwrsSmNjyLEQK++NSxynjRtNavQ
   VVNj3jcwA8izoyoQ7I+4yz1cbj2c0SIKF/rvng/ctIm5LU62rI1taFatl
   eyQAU+ZNjPTqnJZAO+NOO9uMKYWaYocTaTw7seXOI8oeta9uHqtT3fOHj
   SDZjLawu+Xu27FXqYqb7pPXQqKE5Fb0wuNO4kgzX8UJExTN5U+FB0YBeu
   wLyH7+tVFFwYZ/Up1FmDL/XgNa8v9ofUaLMhKuPfaTeZqnYZIRzcAxuid
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="452605969"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="452605969"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 16:16:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="756782189"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="756782189"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 16:16:26 -0700
Received: from debox1-desk4.lan (unknown [10.209.71.91])
        by linux.intel.com (Postfix) with ESMTP id BBCBE580E33;
        Wed, 18 Oct 2023 16:16:26 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: [PATCH V4 17/17] platform/x86/intel/pmc: Show Die C6 counter on Meteor Lake
Date:   Wed, 18 Oct 2023 16:16:24 -0700
Message-Id: <20231018231624.1044633-18-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018231624.1044633-1-david.e.box@linux.intel.com>
References: <20231018231624.1044633-1-david.e.box@linux.intel.com>
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

Expose the Die C6 counter on Meteor Lake.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
V4 - no change

V3 - Split PATCH V2 13. Separates implementation (previous patch)
     from platform specific use (this patch)

 drivers/platform/x86/intel/pmc/mtl.c | 32 ++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index 7ceeae507f4c..38c2f946ec23 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -10,12 +10,17 @@
 
 #include <linux/pci.h>
 #include "core.h"
+#include "../pmt/telemetry.h"
 
 /* PMC SSRAM PMT Telemetry GUIDS */
 #define SOCP_LPM_REQ_GUID	0x2625030
 #define IOEM_LPM_REQ_GUID	0x4357464
 #define IOEP_LPM_REQ_GUID	0x5077612
 
+/* Die C6 from PUNIT telemetry */
+#define MTL_PMT_DMU_DIE_C6_OFFSET	15
+#define MTL_PMT_DMU_GUID		0x1A067102
+
 static const u8 MTL_LPM_REG_INDEX[] = {0, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 20};
 
 /*
@@ -968,6 +973,32 @@ static struct pmc_info mtl_pmc_info_list[] = {
 	{}
 };
 
+static void mtl_punit_pmt_init(struct pmc_dev *pmcdev)
+{
+	struct telem_endpoint *ep;
+	struct pci_dev *pcidev;
+
+	pcidev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(10, 0));
+	if (!pcidev) {
+		dev_err(&pmcdev->pdev->dev, "PUNIT PMT device not found.\n");
+		return;
+	}
+
+	ep = pmt_telem_find_and_register_endpoint(pcidev, MTL_PMT_DMU_GUID, 0);
+	if (IS_ERR(ep)) {
+		dev_err(&pmcdev->pdev->dev,
+			"pmc_core: couldn't get DMU telem endpoint, %ld\n",
+			PTR_ERR(ep));
+		return;
+	}
+
+	pci_dev_put(pcidev);
+	pmcdev->punit_ep = ep;
+
+	pmcdev->has_die_c6 = true;
+	pmcdev->die_c6_offset = MTL_PMT_DMU_DIE_C6_OFFSET;
+}
+
 #define MTL_GNA_PCI_DEV	0x7e4c
 #define MTL_IPU_PCI_DEV	0x7d19
 #define MTL_VPU_PCI_DEV	0x7d1d
@@ -1032,6 +1063,7 @@ int mtl_core_init(struct pmc_dev *pmcdev)
 	}
 
 	pmc_core_get_low_power_modes(pmcdev);
+	mtl_punit_pmt_init(pmcdev);
 
 	/* Due to a hardware limitation, the GBE LTR blocks PC10
 	 * when a cable is attached. Tell the PMC to ignore it.
-- 
2.34.1

