Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E9E808FDC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443722AbjLGSXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443711AbjLGSXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:23:08 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D1A1711;
        Thu,  7 Dec 2023 10:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701973392; x=1733509392;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CMmR5sSp9pmlIzsd9ubZrV13Ldr8URHh9yutCNFrV4I=;
  b=It8sKdzTjOFtBDBjFbWGlOVN0hd/v5AibVMWQowOW4N7k7NpSHr/5mIp
   W5C3T5dXnr+iqf6V30lHpOHWUfrYSb42e13k/ieIXjkWCB7ASSkNcjnMP
   b9/HUeAjwozj9MBIhdvuJ/7rtfFv5UftI9nA2oi6qvx6bRaDw37s1i2ns
   APmaBsWiv0ZW5i2qsHbmo3EXUjQGp+6jTKDokoCRbPSuoZvR1AkRXWjK0
   fY7XXA+RY37t8/2L15hZjwHjZLy3CwkHmvBRnHAMB0Ex8qVbQINlxT0qB
   9bgWnJbYe9iBmUYpO7IIuXIA8za1RqXA/KmRA1Ua9EsILRBzc5e+y3nY4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1104825"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="1104825"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 10:23:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="800811390"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="800811390"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 10:23:11 -0800
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.33])
        by linux.intel.com (Postfix) with ESMTP id A131D580D4F;
        Thu,  7 Dec 2023 10:23:11 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     jahutchinson99@googlemail.com, david.e.box@linux.intel.com,
        hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
        xi.pardee@intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, rajvi.jingar@linux.intel.com
Subject: [PATCH] platform/x86/intel/pmc: Remove GBE LTR ignore
Date:   Thu,  7 Dec 2023 10:23:11 -0800
Message-Id: <20231207182311.2080972-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 804951203aa5 ("platform/x86:intel/pmc: Combine core_init() and
core_configure()") moved the GBE LTR ignore workaround from core.c to PCH
code and added it new for Cannon Lake PCH in cnp.c. This introduced a
network performance regression on a CNP PCH system [1] which has been
observed on other PCH architectures during testing. Remove the probe-time
GBE LTR ignore for all platforms. While this will prevent performance
degradation, it will also limit the deepest SoC Package C state that can be
entered at runtime while a LAN cable is attached.

Reported-by: James Hutchinson <jahutchinson99@googlemail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218143 [1]
Fixes: 804951203aa5 ("platform/x86:intel/pmc: Combine core_init() and core_configure()")
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Tested-by: James Hutchinson <jahutchinson99@googlemail.com>
---
 drivers/platform/x86/intel/pmc/adl.c  | 6 ------
 drivers/platform/x86/intel/pmc/cnp.c  | 6 ------
 drivers/platform/x86/intel/pmc/core.c | 2 +-
 drivers/platform/x86/intel/pmc/core.h | 1 -
 drivers/platform/x86/intel/pmc/mtl.c  | 6 ------
 drivers/platform/x86/intel/pmc/tgl.c  | 5 -----
 6 files changed, 1 insertion(+), 25 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/adl.c b/drivers/platform/x86/intel/pmc/adl.c
index 64c492391ede..e4a421ca64be 100644
--- a/drivers/platform/x86/intel/pmc/adl.c
+++ b/drivers/platform/x86/intel/pmc/adl.c
@@ -321,11 +321,5 @@ int adl_core_init(struct pmc_dev *pmcdev)
 
 	pmc_core_get_low_power_modes(pmcdev);
 
-	/* Due to a hardware limitation, the GBE LTR blocks PC10
-	 * when a cable is attached. Tell the PMC to ignore it.
-	 */
-	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
-	pmc_core_send_ltr_ignore(pmcdev, 3);
-
 	return 0;
 }
diff --git a/drivers/platform/x86/intel/pmc/cnp.c b/drivers/platform/x86/intel/pmc/cnp.c
index 59298f184d0e..416d3a0c3615 100644
--- a/drivers/platform/x86/intel/pmc/cnp.c
+++ b/drivers/platform/x86/intel/pmc/cnp.c
@@ -216,11 +216,5 @@ int cnp_core_init(struct pmc_dev *pmcdev)
 
 	pmc_core_get_low_power_modes(pmcdev);
 
-	/* Due to a hardware limitation, the GBE LTR blocks PC10
-	 * when a cable is attached. Tell the PMC to ignore it.
-	 */
-	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
-	pmc_core_send_ltr_ignore(pmcdev, 3);
-
 	return 0;
 }
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 983e3a8f4910..7c6a74957d57 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -462,7 +462,7 @@ static int pmc_core_pll_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(pmc_core_pll);
 
-int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value)
+static int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value)
 {
 	struct pmc *pmc;
 	const struct pmc_reg_map *map;
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 6d7673145f90..3bbdb41a754f 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -493,7 +493,6 @@ extern const struct pmc_reg_map mtl_ioem_reg_map;
 
 extern void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev);
 extern int pmc_core_ssram_get_lpm_reqs(struct pmc_dev *pmcdev);
-extern int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value);
 
 int pmc_core_resume_common(struct pmc_dev *pmcdev);
 int get_primary_reg_base(struct pmc *pmc);
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index 38c2f946ec23..33d32a76c43a 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -1065,11 +1065,5 @@ int mtl_core_init(struct pmc_dev *pmcdev)
 	pmc_core_get_low_power_modes(pmcdev);
 	mtl_punit_pmt_init(pmcdev);
 
-	/* Due to a hardware limitation, the GBE LTR blocks PC10
-	 * when a cable is attached. Tell the PMC to ignore it.
-	 */
-	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
-	pmc_core_send_ltr_ignore(pmcdev, 3);
-
 	return pmc_core_ssram_get_lpm_reqs(pmcdev);
 }
diff --git a/drivers/platform/x86/intel/pmc/tgl.c b/drivers/platform/x86/intel/pmc/tgl.c
index d5f1d2223c5a..7e6f5739a197 100644
--- a/drivers/platform/x86/intel/pmc/tgl.c
+++ b/drivers/platform/x86/intel/pmc/tgl.c
@@ -265,11 +265,6 @@ int tgl_core_init(struct pmc_dev *pmcdev)
 
 	pmc_core_get_low_power_modes(pmcdev);
 	pmc_core_get_tgl_lpm_reqs(pmcdev->pdev);
-	/* Due to a hardware limitation, the GBE LTR blocks PC10
-	 * when a cable is attached. Tell the PMC to ignore it.
-	 */
-	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
-	pmc_core_send_ltr_ignore(pmcdev, 3);
 
 	return 0;
 }

base-commit: 35ddd61cf023b5deb2b7e9f1627abef053281c0a
-- 
2.25.1

