Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80117FE2E4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbjK2WVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjK2WVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:21:32 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D5DA8;
        Wed, 29 Nov 2023 14:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701296498; x=1732832498;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=nb3VedcwG3zdZSHIcLy4eRGg0Oi6buv/79ezprDIXEo=;
  b=Sk7D/fImxnXI6Q1/nFNsi4roG6uHyNu8/uyyYDDu2jB3sDbtSo6mXsHC
   qNfGzk6Y730hDuQxAamK/XbCHiZ1vjys2FF0YP6jOxL2whBDdvRWNlHdx
   /sjKMkW4n0NRJBYk75xgJk8gVn5ZHOOGwcfyDcctJhVbymUH+7bR6vNha
   Dv/B42mSUcVet1kLA/YGCS97LOTDcvyhfrvAzd4vb7hRBgA8TBTylhthY
   HFRaOQZInaI82fY2ZlXuUy7008RzaAfgRzuQe5p23Gfr/dM3lZod5xNSG
   yqsJSREc6IzmDMrKS0/lkOKyGKmY/6C8Rtc9JIW0PcLl/PrqBiER3fMG/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="11937003"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="11937003"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 14:21:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="798070429"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="798070429"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 14:21:34 -0800
Received: from debox1-desk4.lan (unknown [10.209.108.167])
        by linux.intel.com (Postfix) with ESMTP id 39C33580C4B;
        Wed, 29 Nov 2023 14:21:34 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: [PATCH V6 13/20] platform/x86/intel/pmc: Cleanup SSRAM discovery
Date:   Wed, 29 Nov 2023 14:21:25 -0800
Message-Id: <20231129222132.2331261-14-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129222132.2331261-1-david.e.box@linux.intel.com>
References: <20231129222132.2331261-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the code handling SSRAM discovery. Handle all resource allocation
and cleanup in pmc_core_ssram_get_pmc(). Return the error status from this
function but only fail the init if we fail to discover the primary PMC.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
V6 - Drops patch adding cleanup helpers for iounmap() and ioport_unmap()
     to io.h until s390 build issue is resolved. Add pmc_core specific
     DEFINE_FREE helper for iounmap() for now.

V5 - Use single function to handle SSRAM discovery of all PMCs.

V4 - Add checking the return value from pmc_core_sram_init() to mtl.c
   - Use iounmap cleanup from io.h

V3 - New patch split from previous PATCH 2
   - Update changelog
   - Use cleanup.h to cleanup ioremap

V2 - no change

 drivers/platform/x86/intel/pmc/core_ssram.c | 62 +++++++++++----------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core_ssram.c b/drivers/platform/x86/intel/pmc/core_ssram.c
index 815950713e25..c1b984255571 100644
--- a/drivers/platform/x86/intel/pmc/core_ssram.c
+++ b/drivers/platform/x86/intel/pmc/core_ssram.c
@@ -8,6 +8,7 @@
  *
  */
 
+#include <linux/cleanup.h>
 #include <linux/pci.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 
@@ -21,6 +22,8 @@
 #define SSRAM_IOE_OFFSET	0x68
 #define SSRAM_DEVID_OFFSET	0x70
 
+DEFINE_FREE(pmc_core_iounmap, void __iomem *, iounmap(_T));
+
 static const struct pmc_reg_map *pmc_core_find_regmap(struct pmc_info *list, u16 devid)
 {
 	for (; list->map; ++list)
@@ -65,44 +68,49 @@ pmc_core_pmc_add(struct pmc_dev *pmcdev, u64 pwrm_base,
 	return 0;
 }
 
-static void
-pmc_core_ssram_get_pmc(struct pmc_dev *pmcdev, void __iomem *ssram, u32 offset,
-		       int pmc_idx)
+static int
+pmc_core_ssram_get_pmc(struct pmc_dev *pmcdev, int pmc_idx, u32 offset)
 {
-	u64 pwrm_base;
+	struct pci_dev *ssram_pcidev = pmcdev->ssram_pcidev;
+	void __iomem __free(pmc_core_iounmap) *tmp_ssram = NULL;
+	void __iomem __free(pmc_core_iounmap) *ssram = NULL;
+	const struct pmc_reg_map *map;
+	u64 ssram_base, pwrm_base;
 	u16 devid;
 
-	if (pmc_idx != PMC_IDX_SOC) {
-		u64 ssram_base = get_base(ssram, offset);
+	if (!pmcdev->regmap_list)
+		return -ENOENT;
 
-		if (!ssram_base)
-			return;
+	ssram_base = ssram_pcidev->resource[0].start;
+	tmp_ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
 
+	if (pmc_idx != PMC_IDX_MAIN) {
+		/*
+		 * The secondary PMC BARS (which are behind hidden PCI devices)
+		 * are read from fixed offsets in MMIO of the primary PMC BAR.
+		 */
+		ssram_base = get_base(tmp_ssram, offset);
 		ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
 		if (!ssram)
-			return;
+			return -ENOMEM;
+
+	} else {
+		ssram = no_free_ptr(tmp_ssram);
 	}
 
 	pwrm_base = get_base(ssram, SSRAM_PWRM_OFFSET);
 	devid = readw(ssram + SSRAM_DEVID_OFFSET);
 
-	if (pmcdev->regmap_list) {
-		const struct pmc_reg_map *map;
+	map = pmc_core_find_regmap(pmcdev->regmap_list, devid);
+	if (!map)
+		return -ENODEV;
 
-		map = pmc_core_find_regmap(pmcdev->regmap_list, devid);
-		if (map)
-			pmc_core_pmc_add(pmcdev, pwrm_base, map, pmc_idx);
-	}
-
-	if (pmc_idx != PMC_IDX_SOC)
-		iounmap(ssram);
+	return pmc_core_pmc_add(pmcdev, pwrm_base, map, PMC_IDX_MAIN);
 }
 
 int pmc_core_ssram_init(struct pmc_dev *pmcdev)
 {
-	void __iomem *ssram;
 	struct pci_dev *pcidev;
-	u64 ssram_base;
 	int ret;
 
 	pcidev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(20, 2));
@@ -113,18 +121,14 @@ int pmc_core_ssram_init(struct pmc_dev *pmcdev)
 	if (ret)
 		goto release_dev;
 
-	ssram_base = pcidev->resource[0].start;
-	ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
-	if (!ssram)
-		goto disable_dev;
-
 	pmcdev->ssram_pcidev = pcidev;
 
-	pmc_core_ssram_get_pmc(pmcdev, ssram, 0, PMC_IDX_SOC);
-	pmc_core_ssram_get_pmc(pmcdev, ssram, SSRAM_IOE_OFFSET, PMC_IDX_IOE);
-	pmc_core_ssram_get_pmc(pmcdev, ssram, SSRAM_PCH_OFFSET, PMC_IDX_PCH);
+	ret = pmc_core_ssram_get_pmc(pmcdev, PMC_IDX_MAIN, 0);
+	if (ret)
+		goto disable_dev;
 
-	iounmap(ssram);
+	pmc_core_ssram_get_pmc(pmcdev, PMC_IDX_IOE, SSRAM_IOE_OFFSET);
+	pmc_core_ssram_get_pmc(pmcdev, PMC_IDX_PCH, SSRAM_PCH_OFFSET);
 
 	return 0;
 
-- 
2.34.1

