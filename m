Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A7F7F5746
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 05:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344672AbjKWEFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 23:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbjKWEDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 23:03:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0E4D4F;
        Wed, 22 Nov 2023 20:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700712241; x=1732248241;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=bTY6oidySEMa0Nzt+g/YWkffDxzQYR8+KdRFdCrHSZ4=;
  b=QGv/COj45We6y58HSStyHJQGaK/f4d8EF9GwZj55NjffXL+cmGahIgtv
   xkAFgQ18+kn0qi+/szC3n1OucaP1eb5TL8+xPLdnCsKSw/aqD1U48Aq/Z
   I09Hgrfhl7xdq9XzbZCOB6MBHoPYPXq+Oy2T2JNtQ4uTqIrZEVFKpYI0X
   YoCE3fd637C13S3vmkalAlc8/gp6xxv9LX+DW1NU/31xT8OSam+y45iUr
   4QRp/aYUT/rsq4oV/uAN1rfdbyw1bNt6IrTuXPTeopZza5jU/1uZuFJQR
   caRzDkqJhprmVtyuhtrULaGKkIFuHs9jFWzeYDEbA1Z17BPJsLOYVpEhF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="5334666"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="5334666"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 20:03:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="837671156"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="837671156"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 20:03:57 -0800
Received: from debox1-desk4.lan (snpatel1-mobl.amr.corp.intel.com [10.209.89.91])
        by linux.intel.com (Postfix) with ESMTP id EB1E8580D7B;
        Wed, 22 Nov 2023 20:03:56 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: [PATCH V5 13/20] platform/x86/intel/pmc: Cleanup SSRAM discovery
Date:   Wed, 22 Nov 2023 20:03:48 -0800
Message-Id: <20231123040355.82139-14-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231123040355.82139-1-david.e.box@linux.intel.com>
References: <20231123040355.82139-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the code handling SSRAM discovery. Handle all resource allocation
and cleanup in pmc_core_ssram_get_pmc(). Return the error status from this
function but only fail the init if we fail to discover the primary PMC.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
V5 - Use single function to handle SSRAM discovery of all PMCs.

V4 - Add checking the return value from pmc_core_sram_init() to mtl.c
   - Use iounmap cleanup from io.h

V3 - New patch split from previous PATCH 2
   - Update changelog
   - Use cleanup.h to cleanup ioremap

V2 - no change

 drivers/platform/x86/intel/pmc/core_ssram.c | 60 +++++++++++----------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core_ssram.c b/drivers/platform/x86/intel/pmc/core_ssram.c
index 815950713e25..cb44394d88ce 100644
--- a/drivers/platform/x86/intel/pmc/core_ssram.c
+++ b/drivers/platform/x86/intel/pmc/core_ssram.c
@@ -8,6 +8,7 @@
  *
  */
 
+#include <linux/cleanup.h>
 #include <linux/pci.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 
@@ -65,44 +66,49 @@ pmc_core_pmc_add(struct pmc_dev *pmcdev, u64 pwrm_base,
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
+	void __iomem __free(iounmap) *tmp_ssram = NULL;
+	void __iomem __free(iounmap) *ssram = NULL;
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
@@ -113,18 +119,14 @@ int pmc_core_ssram_init(struct pmc_dev *pmcdev)
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

