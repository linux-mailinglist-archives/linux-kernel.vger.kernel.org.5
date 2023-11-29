Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157DE7FE308
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343694AbjK2WWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343528AbjK2WVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:21:41 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAD6193;
        Wed, 29 Nov 2023 14:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701296503; x=1732832503;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=5UoZQm+5mlrVi2iED5gw7GUDbpPxS++v3tW390wcYxA=;
  b=Lx27ZCfasTNeE20rYeXWujjuEiSQeiUUyxguIz3YM6xmrjhflixiIx1D
   gYr1RH8hU5NTN4KVTrfc/GeQQiFT9RiKcuWvlc7maNddgl/0bMf7TMc4H
   ZG2bAz951Cf6EZ73aFtby4yRbpg38aIXHjMvk83vWvHtPPImPJNroTK7w
   QLrEi529sMxYsSQP9GnvtPdJp2MEfgWqp7Ono1/ZikSx/ppb5smniZrjM
   D0Jo5ZWyXr0w1ORTTXQO0nweP6JkVMiaJ1J3Miqf0jLIdE4Yl1FNQGaAD
   ry8v6jn82SVeLPrwAY9defvj+UcemXoq4sDqFdc3jm2V+bwh4VHqrcDIp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="11937015"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="11937015"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 14:21:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="798070438"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="798070438"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 14:21:34 -0800
Received: from debox1-desk4.lan (unknown [10.209.108.167])
        by linux.intel.com (Postfix) with ESMTP id 74964580ABB;
        Wed, 29 Nov 2023 14:21:34 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: [PATCH V6 15/20] platform/x86/intel/pmc: Find and register PMC telemetry entries
Date:   Wed, 29 Nov 2023 14:21:27 -0800
Message-Id: <20231129222132.2331261-16-david.e.box@linux.intel.com>
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

The PMC SSRAM device contains counters that are structured in Intel
Platform Monitoring Technology (PMT) telemetry regions. Look for and
register these telemetry regions from the driver so that they may be read
using the Intel PMT ABI.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
V6 - No change

V5 - no change

V4 - no change

V3 - no change

V2 - no change

 drivers/platform/x86/intel/pmc/Kconfig      |  1 +
 drivers/platform/x86/intel/pmc/core_ssram.c | 49 +++++++++++++++++++++
 2 files changed, 50 insertions(+)

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
index c1b984255571..9ca720f9cbb2 100644
--- a/drivers/platform/x86/intel/pmc/core_ssram.c
+++ b/drivers/platform/x86/intel/pmc/core_ssram.c
@@ -13,6 +13,8 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 
 #include "core.h"
+#include "../vsec.h"
+#include "../pmt/telemetry.h"
 
 #define SSRAM_HDR_SIZE		0x100
 #define SSRAM_PWRM_OFFSET	0x14
@@ -24,6 +26,49 @@
 
 DEFINE_FREE(pmc_core_iounmap, void __iomem *, iounmap(_T));
 
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
@@ -101,6 +146,9 @@ pmc_core_ssram_get_pmc(struct pmc_dev *pmcdev, int pmc_idx, u32 offset)
 	pwrm_base = get_base(ssram, SSRAM_PWRM_OFFSET);
 	devid = readw(ssram + SSRAM_DEVID_OFFSET);
 
+	/* Find and register and PMC telemetry entries */
+	pmc_add_pmt(pmcdev, ssram_base, ssram);
+
 	map = pmc_core_find_regmap(pmcdev->regmap_list, devid);
 	if (!map)
 		return -ENODEV;
@@ -140,3 +188,4 @@ int pmc_core_ssram_init(struct pmc_dev *pmcdev)
 
 	return ret;
 }
+MODULE_IMPORT_NS(INTEL_VSEC);
-- 
2.34.1

