Return-Path: <linux-kernel+bounces-96481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9842875CBE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 04:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1B11C20A96
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 03:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B5D2C1A9;
	Fri,  8 Mar 2024 03:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HGhvAMmP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C836A23741;
	Fri,  8 Mar 2024 03:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709868733; cv=none; b=LAEzH7n55IttQZffvQjldL6R7NvZmUCOwSUYm0vrVCwD9T/YcDnh20mAb9wi8hEdOHSpRbCK42BrPZjf4P+dDuKQAF7jipTQjylTQrePHTYKGgLdjzMuIzNkQStoOuwFQlLPOykOzoH4SzKhd4HEK/JTcWBfjmPNBfKzzThJh0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709868733; c=relaxed/simple;
	bh=xz2mbi7zbvu6CWgXtWvwpyh3AAA+1Dz5a4MEwUxajnA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Q70kFHYz8NjXs3UPYeq0eHdRD4PI5ddHmOY0PcDarOObT+AkhGoQ5DxufM4fIjT+S2ZifcVV0SdxeAeMl/13x2EQ4q9iFbmROwF/h7mLTDa8EJIUGUgoFkpWhpbYLWR7PmaIxDxLQ8NdkiGW+dXoxWoUJqcScy7u8ZVJYfCmea8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HGhvAMmP; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709868732; x=1741404732;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xz2mbi7zbvu6CWgXtWvwpyh3AAA+1Dz5a4MEwUxajnA=;
  b=HGhvAMmP4A0F00387OxCq2Ocsf3s5N33WO2lMOkrAuMVjSWCrKxrH7yz
   2iZm8hzkNPl4WRRwrp4S8wCJla8xQH901D+nhNsOXBw0Pag/1KH/cAAEt
   X0PtQOCYG9b5yG1bhWO2cwV6a2fixQQVmZiFT74A9g0RsIMsv9W3u5h3p
   aAavztoYQq8apCn4V3XVEQqlHicYSGyplmNlmXEeWbOOul0yq69mj+t0z
   B6p2uMdZR5mvnXWnrnQxKhZanAaAkAFQzfES2CXJ85Mf6DMTOvo1BoowQ
   D+KGb8rIvKzCTKZ2tk3mrbiptO0lPI7/Ygk40A6WvQPXkObVDb32xGSsO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="5172342"
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="5172342"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 19:32:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="10324634"
Received: from kkgame1-x299-aorus-gaming-3-pro.itwn.intel.com ([10.225.75.87])
  by orviesa010.jf.intel.com with ESMTP; 07 Mar 2024 19:32:09 -0800
From: Kane Chen <kane.chen@intel.com>
To: kane.chen@intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	david.e.box@intel.com,
	kane.chen@intel.corp-partner.google.com
Subject: [PATCH v2 1/1] platform/x86/intel/pmc: Improve PKGC residency counters debug
Date: Fri,  8 Mar 2024 11:31:27 +0800
Message-Id: <20240308033127.1013053-1-kane.chen@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The current code only prints PKGC-10 residency when the PKGC-10
is not reached in previous 'freeze' attempt. To debug PKGC-10 issues, we
also need to know other PKGC residency counters to better triage issues.
Ex:
1. When system is stuck in PC2, it can be caused short LTR from device.
2. When system is stuck in PC8, it can be caused by display engine.

To better triage issues, all PKGC residency are needed when issues happen.

Example log:
 CPU did not enter Package C10!!! (Package C10 cnt=0x0)
 Prev Package C2 cnt = 0x2191a325de, Current Package C2 cnt = 0x21aba30724
 Prev Package C3 cnt = 0x0, Current Package C3 cnt = 0x0
 Prev Package C6 cnt = 0x0, Current Package C6 cnt = 0x0
 Prev Package C7 cnt = 0x0, Current Package C7 cnt = 0x0
 Prev Package C8 cnt = 0x0, Current Package C8 cnt = 0x0
 Prev Package C9 cnt = 0x0, Current Package C9 cnt = 0x0
 Prev Package C10 cnt = 0x0, Current Package C10 cnt = 0x0

With this log, we can know whether it's a stuck PC2 issue, and we can
check whether the short LTR from device causes the issue.

Signed-off-by: Kane Chen <kane.chen@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

---
v1->v2: Fixed grammar issue in commit message.
        Change int to unsigned int
        Better description for pkgc_res_cnt
---
 drivers/platform/x86/intel/pmc/core.c | 47 ++++++++++++++++++++-------
 drivers/platform/x86/intel/pmc/core.h |  7 ++--
 2 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 8f9c036809c79..10c96c1a850af 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1389,6 +1389,15 @@ static int pmc_core_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	pmcdev->pmcs[PMC_IDX_MAIN] = primary_pmc;
 
+	/* The last element in msr_map is empty */
+	pmcdev->num_of_pkgc = ARRAY_SIZE(msr_map) - 1;
+	pmcdev->pkgc_res_cnt = devm_kcalloc(&pdev->dev,
+					    pmcdev->num_of_pkgc,
+					    sizeof(*pmcdev->pkgc_res_cnt),
+					    GFP_KERNEL);
+	if (!pmcdev->pkgc_res_cnt)
+		return -ENOMEM;
+
 	/*
 	 * Coffee Lake has CPU ID of Kaby Lake and Cannon Lake PCH. So here
 	 * Sunrisepoint PCH regmap can't be used. Use Cannon Lake PCH regmap
@@ -1432,6 +1441,7 @@ static __maybe_unused int pmc_core_suspend(struct device *dev)
 {
 	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
+	unsigned int i;
 
 	if (pmcdev->suspend)
 		pmcdev->suspend(pmcdev);
@@ -1440,9 +1450,11 @@ static __maybe_unused int pmc_core_suspend(struct device *dev)
 	if (pm_suspend_via_firmware())
 		return 0;
 
-	/* Save PC10 residency for checking later */
-	if (rdmsrl_safe(MSR_PKG_C10_RESIDENCY, &pmcdev->pc10_counter))
-		return -EIO;
+	/* Save PKGC residency for checking later */
+	for (i = 0; i < pmcdev->num_of_pkgc; i++) {
+		if (rdmsrl_safe(msr_map[i].bit_mask, &pmcdev->pkgc_res_cnt[i]))
+			return -EIO;
+	}
 
 	/* Save S0ix residency for checking later */
 	if (pmc_core_dev_state_get(pmc, &pmcdev->s0ix_counter))
@@ -1451,14 +1463,15 @@ static __maybe_unused int pmc_core_suspend(struct device *dev)
 	return 0;
 }
 
-static inline bool pmc_core_is_pc10_failed(struct pmc_dev *pmcdev)
+static inline bool pmc_core_is_deepest_pkgc_failed(struct pmc_dev *pmcdev)
 {
-	u64 pc10_counter;
+	u32 deepest_pkgc_msr = msr_map[pmcdev->num_of_pkgc - 1].bit_mask;
+	u64 deepest_pkgc_residency;
 
-	if (rdmsrl_safe(MSR_PKG_C10_RESIDENCY, &pc10_counter))
+	if (rdmsrl_safe(deepest_pkgc_msr, &deepest_pkgc_residency))
 		return false;
 
-	if (pc10_counter == pmcdev->pc10_counter)
+	if (deepest_pkgc_residency == pmcdev->pkgc_res_cnt[pmcdev->num_of_pkgc - 1])
 		return true;
 
 	return false;
@@ -1497,10 +1510,22 @@ int pmc_core_resume_common(struct pmc_dev *pmcdev)
 	if (!warn_on_s0ix_failures)
 		return 0;
 
-	if (pmc_core_is_pc10_failed(pmcdev)) {
-		/* S0ix failed because of PC10 entry failure */
-		dev_info(dev, "CPU did not enter PC10!!! (PC10 cnt=0x%llx)\n",
-			 pmcdev->pc10_counter);
+	if (pmc_core_is_deepest_pkgc_failed(pmcdev)) {
+		/* S0ix failed because of deepest PKGC entry failure */
+		dev_info(dev, "CPU did not enter %s!!! (%s cnt=0x%llx)\n",
+			 msr_map[pmcdev->num_of_pkgc - 1].name,
+			 msr_map[pmcdev->num_of_pkgc - 1].name,
+			 pmcdev->pkgc_res_cnt[pmcdev->num_of_pkgc - 1]);
+
+		for (i = 0; i < pmcdev->num_of_pkgc; i++) {
+			u64 pc_cnt;
+
+			if (!rdmsrl_safe(msr_map[i].bit_mask, &pc_cnt)) {
+				dev_info(dev, "Prev %s cnt = 0x%llx, Current %s cnt = 0x%llx\n",
+					 msr_map[i].name, pmcdev->pkgc_res_cnt[i],
+					 msr_map[i].name, pc_cnt);
+			}
+		}
 		return 0;
 	}
 
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 54137faaae2b2..83504c49a0e31 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -385,7 +385,8 @@ struct pmc {
  * @pmc_xram_read_bit:	flag to indicate whether PMC XRAM shadow registers
  *			used to read MPHY PG and PLL status are available
  * @mutex_lock:		mutex to complete one transcation
- * @pc10_counter:	PC10 residency counter
+ * @pkgc_res_cnt:	Array of PKGC residency counters
+ * @num_of_pkgc:	Number of PKGC
  * @s0ix_counter:	S0ix residency (step adjusted)
  * @num_lpm_modes:	Count of enabled modes
  * @lpm_en_modes:	Array of enabled modes from lowest to highest priority
@@ -403,13 +404,15 @@ struct pmc_dev {
 	int pmc_xram_read_bit;
 	struct mutex lock; /* generic mutex lock for PMC Core */
 
-	u64 pc10_counter;
 	u64 s0ix_counter;
 	int num_lpm_modes;
 	int lpm_en_modes[LPM_MAX_NUM_MODES];
 	void (*suspend)(struct pmc_dev *pmcdev);
 	int (*resume)(struct pmc_dev *pmcdev);
 
+	u64 *pkgc_res_cnt;
+	u8 num_of_pkgc;
+
 	bool has_die_c6;
 	u32 die_c6_offset;
 	struct telem_endpoint *punit_ep;
-- 
2.34.1


