Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECE37B7686
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 04:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241311AbjJDCDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 22:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241024AbjJDCD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 22:03:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990D9DD;
        Tue,  3 Oct 2023 19:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696384978; x=1727920978;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=7Q2q0Z6iXtFx5UqoGdq3vKePDkPpKrqMemgre9m9eLE=;
  b=FWf+ktGyxJ3DB0SHkLt1RahfxPmSk0YrckU4btRT2oJgk8FyrWmsdRGM
   TdB+BdEvSgjUhnekyBGM7M/qibsiupQRGRNoyLIKufBhAx7HrDkYOQM17
   0ItHH/zTvmJ4vdGPVSr3mxQUYdd8iNJ6BdtEVa+3VR0ogMdfia467KGDK
   w4BDr27fn05I+utbukGbDlT2xfQNLMkxzfLMzDprWbxgiV5nuCOFQ6XQP
   NsTnliwaJ0ci3J/ym0dgoyNajEkgqebkB6EoI/Rk0qZ/1Y/rpuuTmRKc5
   DBKVHY4rVgPxwk5ZWaKRbkKdKCDje6TBmkREesE4g+pjFE+H8LIO/nPAT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1625872"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="1625872"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 19:02:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="700926301"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="700926301"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 19:02:23 -0700
Received: from debox1-desk4.intel.com (unknown [10.209.24.172])
        by linux.intel.com (Postfix) with ESMTP id 62109580CBC;
        Tue,  3 Oct 2023 19:02:23 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: [PATCH V2 09/13] platform/x86/intel/pmc: Find and register PMC telemetry entries
Date:   Tue,  3 Oct 2023 19:02:18 -0700
Message-Id: <20231004020222.193445-10-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004020222.193445-1-david.e.box@linux.intel.com>
References: <20231004020222.193445-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
---
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
index ab5cc07fb177..b2abaf106bc5 100644
--- a/drivers/platform/x86/intel/pmc/core_ssram.c
+++ b/drivers/platform/x86/intel/pmc/core_ssram.c
@@ -12,6 +12,8 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 
 #include "core.h"
+#include "../vsec.h"
+#include "../pmt/telemetry.h"
 
 #define SSRAM_HDR_SIZE		0x100
 #define SSRAM_PWRM_OFFSET	0x14
@@ -21,6 +23,49 @@
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
@@ -97,6 +142,9 @@ pmc_core_get_secondary_pmc(struct pmc_dev *pmcdev, int pmc_idx, u32 offset)
 	pwrm_base = get_base(secondary_ssram, SSRAM_PWRM_OFFSET);
 	devid = readw(secondary_ssram + SSRAM_DEVID_OFFSET);
 
+	/* Find and register and PMC telemetry entries */
+	pmc_add_pmt(pmcdev, ssram_base, main_ssram);
+
 	map = pmc_core_find_regmap(pmcdev->regmap_list, devid);
 	if (!map) {
 		ret = -ENODEV;
@@ -136,6 +184,9 @@ pmc_core_get_primary_pmc(struct pmc_dev *pmcdev)
 	pwrm_base = get_base(ssram, SSRAM_PWRM_OFFSET);
 	devid = readw(ssram + SSRAM_DEVID_OFFSET);
 
+	/* Find and register and PMC telemetry entries */
+	pmc_add_pmt(pmcdev, ssram_base, ssram);
+
 	map = pmc_core_find_regmap(pmcdev->regmap_list, devid);
 	if (!map) {
 		ret = -ENODEV;
@@ -182,3 +233,4 @@ int pmc_core_ssram_init(struct pmc_dev *pmcdev)
 
 	return ret;
 }
+MODULE_IMPORT_NS(INTEL_VSEC);
-- 
2.34.1

