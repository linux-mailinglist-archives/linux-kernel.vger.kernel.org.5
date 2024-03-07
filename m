Return-Path: <linux-kernel+bounces-95187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16519874A68
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39C9A1C22A9A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA6982D8F;
	Thu,  7 Mar 2024 09:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JvUmQ7+w"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFEA633EE;
	Thu,  7 Mar 2024 09:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709802654; cv=none; b=sN9zt/88GwLaCdTk76C+rCLnv81c/iReExnRBMgYRSwHww8rAfbRFS/tWk9EYHoBZ3EBPTA7tHMW0yWwlx21s4HXWCh1ReiN4nrGrLt+ntmeKlXdljL6nTRR7P0A6X8j6hChDVytjRx2w89f4PiPrcfEbD30n4s2n/7EFcxLlZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709802654; c=relaxed/simple;
	bh=Sg2sBD2JSi21uxGvBsjrU3hX2XSVJ/v7s5qN/EmsXHI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=AgTth5xBgDnFDXptUClF6aE3YjUTXmxNhgTjNxDFPKAglODACMfFme8X7y1nQyJbM9mADyh1dHQ6DGjhhakHAy3h4Bxh9Qr/KZASYpFKIWnu8j5+tM6QWxTvMzTf9jAOtbP+uwWbiFw71TdvwGQHyzBXtBP6gk4ktM/ODZY0p7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JvUmQ7+w; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709802652; x=1741338652;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Sg2sBD2JSi21uxGvBsjrU3hX2XSVJ/v7s5qN/EmsXHI=;
  b=JvUmQ7+wzRy78fqEmNibV6OGBdM065w00e3B+RqOslSP/umQIfTG6hS8
   iu53wjehLHfT+qQfHodPcRhGweZlUm6sST6Ikhp0E1KOcdOXAlRiTAYOd
   4Qkmeo7APN0LK2MXyJbGSfcjJDmd4PjG0hiNrmrWGvSCi6yorsLBOc4rf
   fCErlVMUho3XXwRlHcwlsGNsKT/UYPfZuKbI9YUHpqaHW174LqaJVUCUV
   lKES6xzXDTCwg9PNHYNUXBRH33RA6gNsQKWN2hulveJbN3zfdL5KTNuR3
   qGlm0SSWa0XVjQXSrEb0i4xoRdrACbjnf65fufyr2ABTCrdub+CEqfy+Z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="5043979"
X-IronPort-AV: E=Sophos;i="6.06,211,1705392000"; 
   d="scan'208";a="5043979"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 01:10:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,211,1705392000"; 
   d="scan'208";a="9977833"
Received: from kkgame1-x299-aorus-gaming-3-pro.itwn.intel.com ([10.225.75.87])
  by fmviesa010.fm.intel.com with ESMTP; 07 Mar 2024 01:10:49 -0800
From: Kane Chen <kane.chen@intel.com>
To: kane.chen@intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	david.e.box@intel.com,
	kane.chen@intel.corp-partner.google.com
Subject: [PATCH 1/1] platform/x86/intel/pmc: Improve PKGC residency counters debug
Date: Thu,  7 Mar 2024 17:10:11 +0800
Message-Id: <20240307091011.877921-1-kane.chen@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current code only prints PKGC-10 residency when the PKGC-10
is not reached in previous 'freeze' attempt. To debug PKGC-10 issues, we
also need to know other PKGC residency counters to better triage issues.
Ex:
1. When system is stuck in PC2, it can be caused short LTR from device.
2. When system is stuck in PC8, it can be caused by display engine.

To better triage issues, all PKGC residency are needed when issues happens.

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
---
 drivers/platform/x86/intel/pmc/core.c | 47 ++++++++++++++++++++-------
 drivers/platform/x86/intel/pmc/core.h |  7 ++--
 2 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 8f9c036809c79..b8910b671667e 100644
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
+	int i;
 
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
index 54137faaae2b2..fd7ae76984ac7 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -385,7 +385,8 @@ struct pmc {
  * @pmc_xram_read_bit:	flag to indicate whether PMC XRAM shadow registers
  *			used to read MPHY PG and PLL status are available
  * @mutex_lock:		mutex to complete one transcation
- * @pc10_counter:	PC10 residency counter
+ * @pkgc_res_cnt:	PKGC residency counter
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


