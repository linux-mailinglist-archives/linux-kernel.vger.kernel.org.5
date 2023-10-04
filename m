Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7064F7B767D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 04:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240818AbjJDCCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 22:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240715AbjJDCC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 22:02:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B76BA7;
        Tue,  3 Oct 2023 19:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696384945; x=1727920945;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=PGmAHpcZ/3xlkBDMrGBHKlFQ7UOs9q+mJoPrNimoQDs=;
  b=Zvs3GR0wFSixdyWnMA4aDoobMi8gbfHHU+lBsXtd4dUQUC5hCHgmGSMr
   e/Kml+RLP7gTzX+yJWNtqKth0et74gElmg+xrBA6oGC+fysoDVzkn319a
   X+vCur/h6jxS7J9KvhuEIxL7VMrXPlIOL4Pbs1cw6PW+4ENvZ11gXhxuh
   EsehGh/6h0GtfVRDbzdwWFkWNN6ziZ9tRraVGXpAY4nIodol1y03RlweR
   xEADQ9DfZuzcE4J1q4RlIxL2ObTAPqDaiG58jdINCdHmrx4bmLarTSM80
   7X/nqobRk9LhgcCRgcofqI1B6F/dUkmXvDzwWJMPA6p8xhxHKEjDvNxfS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="413947549"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="413947549"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 19:02:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="841596676"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="841596676"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 19:02:23 -0700
Received: from debox1-desk4.intel.com (unknown [10.209.24.172])
        by linux.intel.com (Postfix) with ESMTP id 27CC7580C73;
        Tue,  3 Oct 2023 19:02:23 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: [PATCH V2 07/13] platform/x86:intel/pmc: Call pmc_get_low_power_modes from platform init
Date:   Tue,  3 Oct 2023 19:02:16 -0700
Message-Id: <20231004020222.193445-8-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004020222.193445-1-david.e.box@linux.intel.com>
References: <20231004020222.193445-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xi Pardee <xi.pardee@intel.com>

In order to setup a table of low power mode requirements for Meteor Lake,
pmc_core_get_low_power_modes() will need to be run from platform init code
so that the enabled modes are known, allowing the use of the
pmc_for_each_mode helper. Make the function global and call it from the
platform init code.

Signed-off-by: Xi Pardee <xi.pardee@intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
V2 - Added clearer explanation for the change in the changelog

 drivers/platform/x86/intel/pmc/adl.c  |  2 ++
 drivers/platform/x86/intel/pmc/cnp.c  |  2 ++
 drivers/platform/x86/intel/pmc/core.c |  7 +++----
 drivers/platform/x86/intel/pmc/core.h |  1 +
 drivers/platform/x86/intel/pmc/icl.c  | 10 +++++++++-
 drivers/platform/x86/intel/pmc/mtl.c  |  4 +++-
 drivers/platform/x86/intel/pmc/spt.c  | 10 +++++++++-
 drivers/platform/x86/intel/pmc/tgl.c  |  1 +
 8 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/adl.c b/drivers/platform/x86/intel/pmc/adl.c
index 5006008e01be..64c492391ede 100644
--- a/drivers/platform/x86/intel/pmc/adl.c
+++ b/drivers/platform/x86/intel/pmc/adl.c
@@ -319,6 +319,8 @@ int adl_core_init(struct pmc_dev *pmcdev)
 	if (ret)
 		return ret;
 
+	pmc_core_get_low_power_modes(pmcdev);
+
 	/* Due to a hardware limitation, the GBE LTR blocks PC10
 	 * when a cable is attached. Tell the PMC to ignore it.
 	 */
diff --git a/drivers/platform/x86/intel/pmc/cnp.c b/drivers/platform/x86/intel/pmc/cnp.c
index 420aaa1d7c76..59298f184d0e 100644
--- a/drivers/platform/x86/intel/pmc/cnp.c
+++ b/drivers/platform/x86/intel/pmc/cnp.c
@@ -214,6 +214,8 @@ int cnp_core_init(struct pmc_dev *pmcdev)
 	if (ret)
 		return ret;
 
+	pmc_core_get_low_power_modes(pmcdev);
+
 	/* Due to a hardware limitation, the GBE LTR blocks PC10
 	 * when a cable is attached. Tell the PMC to ignore it.
 	 */
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 5a36b3f77bc5..e58c8cc286a3 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -966,9 +966,8 @@ static bool pmc_core_pri_verify(u32 lpm_pri, u8 *mode_order)
 	return true;
 }
 
-static void pmc_core_get_low_power_modes(struct platform_device *pdev)
+void pmc_core_get_low_power_modes(struct pmc_dev *pmcdev)
 {
-	struct pmc_dev *pmcdev = platform_get_drvdata(pdev);
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
 	u8 pri_order[LPM_MAX_NUM_MODES] = LPM_DEFAULT_PRI;
 	u8 mode_order[LPM_MAX_NUM_MODES];
@@ -1000,7 +999,8 @@ static void pmc_core_get_low_power_modes(struct platform_device *pdev)
 		for (mode = 0; mode < LPM_MAX_NUM_MODES; mode++)
 			pri_order[mode_order[mode]] = mode;
 	else
-		dev_warn(&pdev->dev, "Assuming a default substate order for this platform\n");
+		dev_warn(&pmcdev->pdev->dev,
+			 "Assuming a default substate order for this platform\n");
 
 	/*
 	 * Loop through all modes from lowest to highest priority,
@@ -1250,7 +1250,6 @@ static int pmc_core_probe(struct platform_device *pdev)
 	}
 
 	pmcdev->pmc_xram_read_bit = pmc_core_check_read_lock_bit(primary_pmc);
-	pmc_core_get_low_power_modes(pdev);
 	pmc_core_do_dmi_quirks(primary_pmc);
 
 	pmc_core_dbgfs_register(pmcdev);
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 0729f593c6a7..ccf24e0f5e50 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -490,6 +490,7 @@ extern int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value);
 
 int pmc_core_resume_common(struct pmc_dev *pmcdev);
 int get_primary_reg_base(struct pmc *pmc);
+extern void pmc_core_get_low_power_modes(struct pmc_dev *pmcdev);
 
 extern void pmc_core_ssram_init(struct pmc_dev *pmcdev);
 
diff --git a/drivers/platform/x86/intel/pmc/icl.c b/drivers/platform/x86/intel/pmc/icl.c
index d08e3174230d..71b0fd6cb7d8 100644
--- a/drivers/platform/x86/intel/pmc/icl.c
+++ b/drivers/platform/x86/intel/pmc/icl.c
@@ -53,7 +53,15 @@ const struct pmc_reg_map icl_reg_map = {
 int icl_core_init(struct pmc_dev *pmcdev)
 {
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
+	int ret;
 
 	pmc->map = &icl_reg_map;
-	return get_primary_reg_base(pmc);
+
+	ret = get_primary_reg_base(pmc);
+	if (ret)
+		return ret;
+
+	pmc_core_get_low_power_modes(pmcdev);
+
+	return ret;
 }
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index 2204bc666980..c3b5f4fe01d1 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -985,7 +985,7 @@ static int mtl_resume(struct pmc_dev *pmcdev)
 int mtl_core_init(struct pmc_dev *pmcdev)
 {
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
-	int ret = 0;
+	int ret;
 
 	mtl_d3_fixup();
 
@@ -1002,6 +1002,8 @@ int mtl_core_init(struct pmc_dev *pmcdev)
 			return ret;
 	}
 
+	pmc_core_get_low_power_modes(pmcdev);
+
 	/* Due to a hardware limitation, the GBE LTR blocks PC10
 	 * when a cable is attached. Tell the PMC to ignore it.
 	 */
diff --git a/drivers/platform/x86/intel/pmc/spt.c b/drivers/platform/x86/intel/pmc/spt.c
index 4b6f5cbda16c..ab993a69e33e 100644
--- a/drivers/platform/x86/intel/pmc/spt.c
+++ b/drivers/platform/x86/intel/pmc/spt.c
@@ -137,7 +137,15 @@ const struct pmc_reg_map spt_reg_map = {
 int spt_core_init(struct pmc_dev *pmcdev)
 {
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
+	int ret;
 
 	pmc->map = &spt_reg_map;
-	return get_primary_reg_base(pmc);
+
+	ret = get_primary_reg_base(pmc);
+	if (ret)
+		return ret;
+
+	pmc_core_get_low_power_modes(pmcdev);
+
+	return ret;
 }
diff --git a/drivers/platform/x86/intel/pmc/tgl.c b/drivers/platform/x86/intel/pmc/tgl.c
index 2449940102db..d5f1d2223c5a 100644
--- a/drivers/platform/x86/intel/pmc/tgl.c
+++ b/drivers/platform/x86/intel/pmc/tgl.c
@@ -263,6 +263,7 @@ int tgl_core_init(struct pmc_dev *pmcdev)
 	if (ret)
 		return ret;
 
+	pmc_core_get_low_power_modes(pmcdev);
 	pmc_core_get_tgl_lpm_reqs(pmcdev->pdev);
 	/* Due to a hardware limitation, the GBE LTR blocks PC10
 	 * when a cable is attached. Tell the PMC to ignore it.
-- 
2.34.1

