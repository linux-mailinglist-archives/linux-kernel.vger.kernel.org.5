Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1053E7ABB24
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 23:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjIVVbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 17:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjIVVam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 17:30:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63A2136;
        Fri, 22 Sep 2023 14:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695418235; x=1726954235;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=WfK7ZHVA2wFzt1NZqESMIwsrJ1vJQnZD6txRV7FIyGI=;
  b=HfFO9EHJtDBYljpXsGJXFhqUlNEganL/pmOGKbf/juhRfApfV8pOx10u
   t376+q66TrsLiTpOl7GYLdrmb6mUh70vciPAPXg9783mWJxANOsBcgaBa
   tK5EcbSFgb7JAqctImFeiOLyX06FuSV2+toJOAslpyduf2jL6ko54SEnr
   fc6spoViR/CfOn0d/Qk59ru6WWya9+PPw4dJ4z3AnbfOBNcm5impDVXa6
   hCbVRUqiL7qu6ePHJPeaU5Sv0cOeCABYba9mDPucdFJgoddUj+dyZ4B1H
   nBluroNBv2Pe0drVZdSZm52UdDzW7LuV8IdYRlNXzIeeqrd0SnuYPeHLu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="379828423"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="379828423"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 14:30:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="813237857"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="813237857"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 14:30:34 -0700
Received: from debox1-desk4.intel.com (unknown [10.212.188.234])
        by linux.intel.com (Postfix) with ESMTP id 14989580BB9;
        Fri, 22 Sep 2023 14:30:34 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, david.e.box@linux.intel.com,
        platform-driver-x86@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
        rajvi.jingar@linux.intel.com
Subject: [PATCH 11/11] platform/x86/intel/pmc: Add debug attribute for Die C6 counter
Date:   Fri, 22 Sep 2023 14:30:32 -0700
Message-Id: <20230922213032.1770590-12-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922213032.1770590-1-david.e.box@linux.intel.com>
References: <20230922213032.1770590-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a "die_c6_us_show" counter in debugs and add support for Meteor Lake.
Reads the counter value using Intel Platform Monitoring Technology (PMT)
driver API. This counter is useful for determining the idle residency of
CPUs in the compute tile.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 55 +++++++++++++++++++++++++++
 drivers/platform/x86/intel/pmc/core.h |  4 ++
 drivers/platform/x86/intel/pmc/mtl.c  | 32 ++++++++++++++++
 3 files changed, 91 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index df2bcead1723..790ed9481529 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -27,6 +27,7 @@
 #include <asm/tsc.h>
 
 #include "core.h"
+#include "../pmt/telemetry.h"
 
 /* Maximum number of modes supported by platfoms that has low power mode capability */
 const char *pmc_lpm_modes[] = {
@@ -822,6 +823,48 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_req_regs);
 
+static unsigned int pmc_core_get_crystal_freq(void)
+{
+	unsigned int eax_denominator, ebx_numerator, ecx_hz, edx;
+
+	if (boot_cpu_data.cpuid_level < 0x15)
+		return 0;
+
+	eax_denominator = ebx_numerator = ecx_hz = edx = 0;
+
+	/* CPUID 15H TSC/Crystal ratio, plus optionally Crystal Hz */
+	cpuid(0x15, &eax_denominator, &ebx_numerator, &ecx_hz, &edx);
+
+	if (ebx_numerator == 0 || eax_denominator == 0)
+		return 0;
+
+	return ecx_hz;
+}
+
+static int pmc_core_die_c6_us_show(struct seq_file *s, void *unused)
+{
+	struct pmc_dev *pmcdev = s->private;
+	u64 die_c6_res, count;
+	int ret;
+
+	if (!pmcdev->crystal_freq) {
+		dev_warn_once(&pmcdev->pdev->dev, "%s: Bad crystal frequency\n",
+			      __func__);
+		return -EINVAL;
+	}
+
+	ret = pmt_telem_read(pmcdev->punit_ep, pmcdev->die_c6_offset,
+			     &count, 1);
+	if (ret)
+		return ret;
+
+	die_c6_res = div64_u64(count * 1000000ULL, pmcdev->crystal_freq);
+	seq_printf(s, "%llu\n", die_c6_res);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(pmc_core_die_c6_us);
+
 static int pmc_core_lpm_latch_mode_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
@@ -1118,6 +1161,12 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
 				    pmcdev->dbgfs_dir, pmcdev,
 				    &pmc_core_substate_req_regs_fops);
 	}
+
+	if (pmcdev->has_die_c6) {
+		debugfs_create_file("die_c6_us_show", 0444,
+				    pmcdev->dbgfs_dir, pmcdev,
+				    &pmc_core_die_c6_us_fops);
+	}
 }
 
 static const struct x86_cpu_id intel_pmc_core_ids[] = {
@@ -1212,6 +1261,10 @@ static void pmc_core_clean_structure(struct platform_device *pdev)
 		pci_dev_put(pmcdev->ssram_pcidev);
 		pci_disable_device(pmcdev->ssram_pcidev);
 	}
+
+	if (pmcdev->punit_ep)
+		pmt_telem_unregister_endpoint(pmcdev->punit_ep);
+
 	platform_set_drvdata(pdev, NULL);
 	mutex_destroy(&pmcdev->lock);
 }
@@ -1232,6 +1285,8 @@ static int pmc_core_probe(struct platform_device *pdev)
 	if (!pmcdev)
 		return -ENOMEM;
 
+	pmcdev->crystal_freq = pmc_core_get_crystal_freq();
+
 	platform_set_drvdata(pdev, pmcdev);
 	pmcdev->pdev = pdev;
 
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 85b6f6ae4995..6d7673145f90 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -16,6 +16,8 @@
 #include <linux/bits.h>
 #include <linux/platform_device.h>
 
+struct telem_endpoint;
+
 #define SLP_S0_RES_COUNTER_MASK			GENMASK(31, 0)
 
 #define PMC_BASE_ADDR_DEFAULT			0xFE000000
@@ -357,6 +359,7 @@ struct pmc {
  * @devs:		pointer to an array of pmc pointers
  * @pdev:		pointer to platform_device struct
  * @ssram_pcidev:	pointer to pci device struct for the PMC SSRAM
+ * @crystal_freq:	crystal frequency from cpuid
  * @dbgfs_dir:		path to debugfs interface
  * @pmc_xram_read_bit:	flag to indicate whether PMC XRAM shadow registers
  *			used to read MPHY PG and PLL status are available
@@ -374,6 +377,7 @@ struct pmc_dev {
 	struct dentry *dbgfs_dir;
 	struct platform_device *pdev;
 	struct pci_dev *ssram_pcidev;
+	unsigned int crystal_freq;
 	int pmc_xram_read_bit;
 	struct mutex lock; /* generic mutex lock for PMC Core */
 
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index c2ac50cfdd51..d791d4894c9d 100644
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
+		dev_err(&pmcdev->pdev->dev, "PUNIT PMT device not found.");
+		return;
+	}
+
+	ep = pmt_telem_find_and_register_endpoint(pcidev, MTL_PMT_DMU_GUID, 0);
+	if (IS_ERR(ep)) {
+		dev_err(&pmcdev->pdev->dev,
+			"pmc_core: couldn't get DMU telem endpoint %ld",
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
@@ -1030,6 +1061,7 @@ int mtl_core_init(struct pmc_dev *pmcdev)
 	}
 
 	pmc_core_get_low_power_modes(pmcdev);
+	mtl_punit_pmt_init(pmcdev);
 
 	/* Due to a hardware limitation, the GBE LTR blocks PC10
 	 * when a cable is attached. Tell the PMC to ignore it.
-- 
2.34.1

