Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5436C7CEBCD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbjJRXRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjJRXQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:16:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1CB126;
        Wed, 18 Oct 2023 16:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697670990; x=1729206990;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=cBxWhILcEvrnw3qtLsqkGhZTWl+k3D7+p8GKQFslz7M=;
  b=O/KR9lqz5iGRHqnD/PRxVEktOrmOctDfzh7kf+PXKipQwf/lEETXjiwM
   Mk3Z6YIkJ2lvrNWAG67Y5HFLIz8d5G7R06en8EGCN0Wv7RGQTRDvRdUYH
   u/JTo9WeO+1yPtNb0CE8EYN3FIpbQWS5fBQpBmsL9qZDdBeoUVclmNJPq
   pOnMUpPum1yXMZEi+THBd41K/lrLswYm4KvKk9dzAN559GQ2puDOiKn43
   rYvqx4eO2CViZUbZU/n5Db5KYLKTQSERlRQTSL3uCIq3s3zu252Ch6W1f
   o37qGQMxKUV92qenIyNuBiltnEE+BUgDst/HfsbnSIgknNkPe0dACx74R
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="452605965"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="452605965"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 16:16:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="756782185"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="756782185"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 16:16:26 -0700
Received: from debox1-desk4.lan (unknown [10.209.71.91])
        by linux.intel.com (Postfix) with ESMTP id 2681C580DD4;
        Wed, 18 Oct 2023 16:16:26 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: [PATCH V4 12/17] platform/x86/intel/pmc: Find and register PMC telemetry entries
Date:   Wed, 18 Oct 2023 16:16:19 -0700
Message-Id: <20231018231624.1044633-13-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018231624.1044633-1-david.e.box@linux.intel.com>
References: <20231018231624.1044633-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMC SSRAM device contains counters that are structured in Intel
Platform Monitoring Technology (PMT) telemetry regions. Look for and
register these telemetry regions from the driver so that they may be read
using the Intel PMT ABI.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
V4 - no change

V3 - no change

V2 - no change

 drivers/platform/x86/intel/pmc/Kconfig      |  1 +
 drivers/platform/x86/intel/pmc/core_ssram.c | 52 +++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/Kconfig b/drivers/platform/x86/intel/pmc/Kconfig
index b526597e4deb..d2f651fbec2c 100644
--- a/drivers/platform/x86/intel/pmc/Kconfig
+++ b/drivers/platform/x86/intel/pmc/Kconfig
@@ -7,6 +7,7 @@ config INTEL_PMC_CORE
 	tristate "Intel PMC Core driver"
 	depends on PCI
 	depends on ACPI
+	depends on INTEL_PMT_TELEMETRY
 	help
 	  The Intel Platform Controller Hub for Intel Core SoCs provides access
 	  to Power Management Controller registers via various interfaces. This
diff --git a/drivers/platform/x86/intel/pmc/core_ssram.c b/drivers/platform/x86/intel/pmc/core_ssram.c
index ccb3748dbed9..936aa0d5f452 100644
--- a/drivers/platform/x86/intel/pmc/core_ssram.c
+++ b/drivers/platform/x86/intel/pmc/core_ssram.c
@@ -13,6 +13,8 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 
 #include "core.h"
+#include "../vsec.h"
+#include "../pmt/telemetry.h"
 
 #define SSRAM_HDR_SIZE		0x100
 #define SSRAM_PWRM_OFFSET	0x14
@@ -22,6 +24,49 @@
 #define SSRAM_IOE_OFFSET	0x68
 #define SSRAM_DEVID_OFFSET	0x70
 
+static void
+pmc_add_pmt(struct pmc_dev *pmcdev, u64 ssram_base, void __iomem *ssram)
+{
+	struct pci_dev *pcidev = pmcdev->ssram_pcidev;
+	struct intel_vsec_platform_info info = {};
+	struct intel_vsec_header *headers[2] = {};
+	struct intel_vsec_header header;
+	void __iomem *dvsec;
+	u32 dvsec_offset;
+	u32 table, hdr;
+
+	ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
+	if (!ssram)
+		return;
+
+	dvsec_offset = readl(ssram + SSRAM_DVSEC_OFFSET);
+	iounmap(ssram);
+
+	dvsec = ioremap(ssram_base + dvsec_offset, SSRAM_DVSEC_SIZE);
+	if (!dvsec)
+		return;
+
+	hdr = readl(dvsec + PCI_DVSEC_HEADER1);
+	header.id = readw(dvsec + PCI_DVSEC_HEADER2);
+	header.rev = PCI_DVSEC_HEADER1_REV(hdr);
+	header.length = PCI_DVSEC_HEADER1_LEN(hdr);
+	header.num_entries = readb(dvsec + INTEL_DVSEC_ENTRIES);
+	header.entry_size = readb(dvsec + INTEL_DVSEC_SIZE);
+
+	table = readl(dvsec + INTEL_DVSEC_TABLE);
+	header.tbir = INTEL_DVSEC_TABLE_BAR(table);
+	header.offset = INTEL_DVSEC_TABLE_OFFSET(table);
+	iounmap(dvsec);
+
+	headers[0] = &header;
+	info.caps = VSEC_CAP_TELEMETRY;
+	info.headers = headers;
+	info.base_addr = ssram_base;
+	info.parent = &pmcdev->pdev->dev;
+
+	intel_vsec_register(pcidev, &info);
+}
+
 static const struct pmc_reg_map *pmc_core_find_regmap(struct pmc_info *list, u16 devid)
 {
 	for (; list->map; ++list)
@@ -96,6 +141,9 @@ pmc_core_get_secondary_pmc(struct pmc_dev *pmcdev, int pmc_idx, u32 offset)
 	pwrm_base = get_base(secondary_ssram, SSRAM_PWRM_OFFSET);
 	devid = readw(secondary_ssram + SSRAM_DEVID_OFFSET);
 
+	/* Find and register and PMC telemetry entries */
+	pmc_add_pmt(pmcdev, ssram_base, main_ssram);
+
 	map = pmc_core_find_regmap(pmcdev->regmap_list, devid);
 	if (!map)
 		return -ENODEV;
@@ -124,6 +172,9 @@ pmc_core_get_primary_pmc(struct pmc_dev *pmcdev)
 	pwrm_base = get_base(ssram, SSRAM_PWRM_OFFSET);
 	devid = readw(ssram + SSRAM_DEVID_OFFSET);
 
+	/* Find and register and PMC telemetry entries */
+	pmc_add_pmt(pmcdev, ssram_base, ssram);
+
 	map = pmc_core_find_regmap(pmcdev->regmap_list, devid);
 	if (!map)
 		return -ENODEV;
@@ -163,3 +214,4 @@ int pmc_core_ssram_init(struct pmc_dev *pmcdev)
 
 	return ret;
 }
+MODULE_IMPORT_NS(INTEL_VSEC);
-- 
2.34.1

