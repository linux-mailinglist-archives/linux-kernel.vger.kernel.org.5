Return-Path: <linux-kernel+bounces-10263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB1181D1E2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6076B285FCD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D469466;
	Sat, 23 Dec 2023 03:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jblK7pU5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A540F15D1;
	Sat, 23 Dec 2023 03:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703301954; x=1734837954;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=KTLQW3bIzICXGmk2rNHHL9SlhBkrC3fIYxcE4SasHFg=;
  b=jblK7pU5kfRqYnHGKajog4QddWWAEtpPZStmfbN6OWoPBCTdlHyqnoE1
   Ilf9PYQv/4y6Ja1qukaB/0ed7d0pwbV6b++XKM4y2p2ZQUCpwZA1urhz7
   XifO0qZEdKdVtV9XBcxx06gFzWkdtu5lc9H61DHU+HZTKbZIPf079ISSv
   6sy+0RLtB0l4m9NrodBBvDdhZunIPNn/YApTP+2mzBC3AggVXo6XuIbXJ
   I8H4/VxcTFcqLXc/MHfZ2jNvK+r4PhqdI4Sod1ryjcVblvvNTzsuG4n0Z
   CGmJdDS/z97hyCywhHbBBN37UWRQQCrANHfMhPfHQ00e3Abyryafvn3Jn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="395922873"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="395922873"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 19:25:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="1024436820"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="1024436820"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 19:25:52 -0800
Received: from debox1-desk4.intel.com (unknown [10.209.86.110])
	by linux.intel.com (Postfix) with ESMTP id 2470E580C4B;
	Fri, 22 Dec 2023 19:25:52 -0800 (PST)
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	rajvi.jingar@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] platform/x86/intel/pmc: Move GBE LTR ignore to suspend callback
Date: Fri, 22 Dec 2023 19:25:45 -0800
Message-Id: <20231223032548.1680738-6-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231223032548.1680738-1-david.e.box@linux.intel.com>
References: <20231223032548.1680738-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 804951203aa5 ("platform/x86:intel/pmc: Combine core_init() and
core_configure()") caused a network performance regression due to the GBE
LTR ignore that it added at probe. This was needed in order to allow the
SoC to enter the deepest Package C state. To fix the regression and at
least support PC10 during suspend, move the LTR ignore from probe to the
suspend callback, and enable it again on resume. This solution will allow
PC10 during suspend but restrict Package C entry at runtime to no deeper
than PC8/9 while a network cable it attach to the PCH LAN.

Fixes: 804951203aa5 ("platform/x86:intel/pmc: Combine core_init() and core_configure()")
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/adl.c  |  9 +++------
 drivers/platform/x86/intel/pmc/cnp.c  | 26 ++++++++++++++++++++------
 drivers/platform/x86/intel/pmc/core.h |  3 +++
 drivers/platform/x86/intel/pmc/mtl.c  |  9 +++------
 drivers/platform/x86/intel/pmc/tgl.c  |  8 +++-----
 5 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/adl.c b/drivers/platform/x86/intel/pmc/adl.c
index fbe0678f766c..e7878558fd90 100644
--- a/drivers/platform/x86/intel/pmc/adl.c
+++ b/drivers/platform/x86/intel/pmc/adl.c
@@ -316,6 +316,9 @@ int adl_core_init(struct pmc_dev *pmcdev)
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
 	int ret;
 
+	pmcdev->suspend = cnl_suspend;
+	pmcdev->resume = cnl_resume;
+
 	pmc->map = &adl_reg_map;
 	ret = get_primary_reg_base(pmc);
 	if (ret)
@@ -323,11 +326,5 @@ int adl_core_init(struct pmc_dev *pmcdev)
 
 	pmc_core_get_low_power_modes(pmcdev);
 
-	/* Due to a hardware limitation, the GBE LTR blocks PC10
-	 * when a cable is attached. Tell the PMC to ignore it.
-	 */
-	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
-	pmc_core_send_ltr_ignore(pmcdev, 3, 1);
-
 	return 0;
 }
diff --git a/drivers/platform/x86/intel/pmc/cnp.c b/drivers/platform/x86/intel/pmc/cnp.c
index 80f73242f9dd..dd72974bf71e 100644
--- a/drivers/platform/x86/intel/pmc/cnp.c
+++ b/drivers/platform/x86/intel/pmc/cnp.c
@@ -204,11 +204,31 @@ const struct pmc_reg_map cnp_reg_map = {
 	.etr3_offset = ETR3_OFFSET,
 };
 
+void cnl_suspend(struct pmc_dev *pmcdev)
+{
+	/*
+	 * Due to a hardware limitation, the GBE LTR blocks PC10
+	 * when a cable is attached. To unblock PC10 during suspend,
+	 * tell the PMC to ignore it.
+	 */
+	pmc_core_send_ltr_ignore(pmcdev, 3, 1);
+}
+
+int cnl_resume(struct pmc_dev *pmcdev)
+{
+	pmc_core_send_ltr_ignore(pmcdev, 3, 0);
+
+	return pmc_core_resume_common(pmcdev);
+}
+
 int cnp_core_init(struct pmc_dev *pmcdev)
 {
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
 	int ret;
 
+	pmcdev->suspend = cnl_suspend;
+	pmcdev->resume = cnl_resume;
+
 	pmc->map = &cnp_reg_map;
 	ret = get_primary_reg_base(pmc);
 	if (ret)
@@ -216,11 +236,5 @@ int cnp_core_init(struct pmc_dev *pmcdev)
 
 	pmc_core_get_low_power_modes(pmcdev);
 
-	/* Due to a hardware limitation, the GBE LTR blocks PC10
-	 * when a cable is attached. Tell the PMC to ignore it.
-	 */
-	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
-	pmc_core_send_ltr_ignore(pmcdev, 3, 1);
-
 	return 0;
 }
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 90f2dbc4df72..ce7b1cd2b194 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -589,6 +589,9 @@ int mtl_core_init(struct pmc_dev *pmcdev);
 int arl_core_init(struct pmc_dev *pmcdev);
 int lnl_core_init(struct pmc_dev *pmcdev);
 
+void cnl_suspend(struct pmc_dev *pmcdev);
+int cnl_resume(struct pmc_dev *pmcdev);
+
 #define pmc_for_each_mode(i, mode, pmcdev)		\
 	for (i = 0, mode = pmcdev->lpm_en_modes[i];	\
 	     i < pmcdev->num_lpm_modes;			\
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index ef78d14fc27f..c7d15d864039 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -986,6 +986,8 @@ static void mtl_d3_fixup(void)
 static int mtl_resume(struct pmc_dev *pmcdev)
 {
 	mtl_d3_fixup();
+	pmc_core_send_ltr_ignore(pmcdev, 3, 0);
+
 	return pmc_core_resume_common(pmcdev);
 }
 
@@ -998,6 +1000,7 @@ int mtl_core_init(struct pmc_dev *pmcdev)
 
 	mtl_d3_fixup();
 
+	pmcdev->suspend = cnl_suspend;
 	pmcdev->resume = mtl_resume;
 	pmcdev->regmap_list = mtl_pmc_info_list;
 
@@ -1019,12 +1022,6 @@ int mtl_core_init(struct pmc_dev *pmcdev)
 	pmc_core_get_low_power_modes(pmcdev);
 	pmc_core_punit_pmt_init(pmcdev, MTL_PMT_DMU_GUID);
 
-	/* Due to a hardware limitation, the GBE LTR blocks PC10
-	 * when a cable is attached. Tell the PMC to ignore it.
-	 */
-	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
-	pmc_core_send_ltr_ignore(pmcdev, 3, 1);
-
 	if (ssram_init)
 		return pmc_core_ssram_get_lpm_reqs(pmcdev);
 
diff --git a/drivers/platform/x86/intel/pmc/tgl.c b/drivers/platform/x86/intel/pmc/tgl.c
index 8213961975fc..e0580de18077 100644
--- a/drivers/platform/x86/intel/pmc/tgl.c
+++ b/drivers/platform/x86/intel/pmc/tgl.c
@@ -305,17 +305,15 @@ int tgl_core_generic_init(struct pmc_dev *pmcdev, int pch_tp)
 	else
 		pmc->map = &tgl_reg_map;
 
+	pmcdev->suspend = cnl_suspend;
+	pmcdev->resume = cnl_resume;
+
 	ret = get_primary_reg_base(pmc);
 	if (ret)
 		return ret;
 
 	pmc_core_get_low_power_modes(pmcdev);
 	pmc_core_get_tgl_lpm_reqs(pmcdev->pdev);
-	/* Due to a hardware limitation, the GBE LTR blocks PC10
-	 * when a cable is attached. Tell the PMC to ignore it.
-	 */
-	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
-	pmc_core_send_ltr_ignore(pmcdev, 3, 1);
 
 	return 0;
 }
-- 
2.34.1


