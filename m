Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BF67C62EE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376938AbjJLCjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 22:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376806AbjJLCiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:38:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E833C6;
        Wed, 11 Oct 2023 19:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697078328; x=1728614328;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=ur94IR6OdCejLPVD9UGB+HF3JbE3eQmG5tryg1LLLJs=;
  b=YeaAO9+AClEfp0mKxC76fYRLtBvysQ9WwxYJVavY06cJO2yrxaMwBQ20
   j5p4RNkyQlJCvZMmoh8OOAHRsbd9ugxqYuzfLs9aRysLiQLxg+u5ybSVb
   znY3Ydb3Ua8dhkxyN6NACO9eH4w1WRCaqafRce3igWFmSUY2fMC1y5RXw
   p4EQ8dOpKZ8AY+oF1XwmCmqD+RgybQWUx4FNLe6qvWaJM5gzv9M78Y/Sf
   CAifQ+a4lHRKOim9daFmVUjNMCcOhdMNqpll5hVCROVZyOChqcO2L8VGn
   IP++SONoI7S2ST+34MDc1hMBqt2pT0MX4fXgmyCPz2isQwfBMeGuMIA4u
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="3402636"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="3402636"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 19:38:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="783507874"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="783507874"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 19:38:43 -0700
Received: from debox1-desk4.intel.com (unknown [10.209.105.238])
        by linux.intel.com (Postfix) with ESMTP id 0A719580DBE;
        Wed, 11 Oct 2023 19:38:43 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: [PATCH V3 15/16] platform/x86/intel/pmc: Add debug attribute for Die C6 counter
Date:   Wed, 11 Oct 2023 19:38:39 -0700
Message-Id: <20231012023840.3845703-16-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012023840.3845703-1-david.e.box@linux.intel.com>
References: <20231012023840.3845703-1-david.e.box@linux.intel.com>
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

Add a "die_c6_us_show" debugfs attribute.  Reads the counter value using
Intel Platform Monitoring Technology (PMT) driver API. This counter is
useful for determining the idle residency of CPUs in the compute tile.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
V3 - Split previous PATCH V2 13. Separates implementation (this patch) from
     platform specific use (next patch)

V2 - Remove use of __func__
   - Use HZ_PER_MHZ
   - Fix missing newlines in printks

 drivers/platform/x86/intel/pmc/core.c | 55 +++++++++++++++++++++++++++
 drivers/platform/x86/intel/pmc/core.h |  4 ++
 2 files changed, 59 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index df2bcead1723..b90ee8c896f4 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -20,6 +20,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
+#include <linux/units.h>
 
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
@@ -27,6 +28,7 @@
 #include <asm/tsc.h>
 
 #include "core.h"
+#include "../pmt/telemetry.h"
 
 /* Maximum number of modes supported by platfoms that has low power mode capability */
 const char *pmc_lpm_modes[] = {
@@ -822,6 +824,47 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
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
+		dev_warn_once(&pmcdev->pdev->dev, "Bad crystal frequency\n");
+		return -EINVAL;
+	}
+
+	ret = pmt_telem_read(pmcdev->punit_ep, pmcdev->die_c6_offset,
+			     &count, 1);
+	if (ret)
+		return ret;
+
+	die_c6_res = div64_u64(count * HZ_PER_MHZ, pmcdev->crystal_freq);
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
 
-- 
2.34.1

