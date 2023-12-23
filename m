Return-Path: <linux-kernel+bounces-10265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A2681D1E4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01E3BB2368E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639EBCA58;
	Sat, 23 Dec 2023 03:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gKpdjXBB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EA24433;
	Sat, 23 Dec 2023 03:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703301955; x=1734837955;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Y+fquDIVwAXRVSyA/bkxUrrh3S3GNQuoNqunFaD+RiA=;
  b=gKpdjXBBonHZNDxEzaPSwMB3zLZ4+4tmUKZ7Y+PJiFpGCJAyVE0J1AJ4
   B4eDA3LRAurYI4SRzxheUYrdu48QQlzxutFBhtb4cOWsmp8+GsGsxjT8C
   +lKm/N7VA3HEUxou2UTWv7+4z5M10hCVv9IDoeZpfloQiptp73RQQcS5J
   HcbzRI+oFh/kf6KckBO2p/AC19X20UyBWq2kwtoXjmEHLIkYSoEXsjA0n
   Jw1RWkz37qF9WBFnitTyNHsWC4DpH7ruafc6xSKRBdPOhWSZRQoIgilRV
   XyVmRYGNpl76vm8ra83XzwYcK5dzLhYGF3Gqxoq11g4T9MU9tcHly/g7q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="395922875"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="395922875"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 19:25:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="1024436819"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="1024436819"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 19:25:52 -0800
Received: from debox1-desk4.intel.com (unknown [10.209.86.110])
	by linux.intel.com (Postfix) with ESMTP id E98CD580CC6;
	Fri, 22 Dec 2023 19:25:51 -0800 (PST)
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	rajvi.jingar@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] platform/x86/intel/pmc: Allow reenabling LTRs
Date: Fri, 22 Dec 2023 19:25:44 -0800
Message-Id: <20231223032548.1680738-5-david.e.box@linux.intel.com>
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
LTR ignore that it added during probe. The fix will move the ignore to
occur at suspend-time (so as to not affect suspend power). This will
require the ability to enable the LTR again on resume. Modify
pmc_core_send_ltr_ignore() to allow enabling an LTR.

Fixes: 804951203aa5 ("platform/x86:intel/pmc: Combine core_init() and core_configure()")
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/adl.c  | 2 +-
 drivers/platform/x86/intel/pmc/cnp.c  | 2 +-
 drivers/platform/x86/intel/pmc/core.c | 9 ++++++---
 drivers/platform/x86/intel/pmc/core.h | 3 ++-
 drivers/platform/x86/intel/pmc/mtl.c  | 2 +-
 drivers/platform/x86/intel/pmc/tgl.c  | 2 +-
 6 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/adl.c b/drivers/platform/x86/intel/pmc/adl.c
index 882f2d5d8937..fbe0678f766c 100644
--- a/drivers/platform/x86/intel/pmc/adl.c
+++ b/drivers/platform/x86/intel/pmc/adl.c
@@ -327,7 +327,7 @@ int adl_core_init(struct pmc_dev *pmcdev)
 	 * when a cable is attached. Tell the PMC to ignore it.
 	 */
 	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
-	pmc_core_send_ltr_ignore(pmcdev, 3);
+	pmc_core_send_ltr_ignore(pmcdev, 3, 1);
 
 	return 0;
 }
diff --git a/drivers/platform/x86/intel/pmc/cnp.c b/drivers/platform/x86/intel/pmc/cnp.c
index 59298f184d0e..80f73242f9dd 100644
--- a/drivers/platform/x86/intel/pmc/cnp.c
+++ b/drivers/platform/x86/intel/pmc/cnp.c
@@ -220,7 +220,7 @@ int cnp_core_init(struct pmc_dev *pmcdev)
 	 * when a cable is attached. Tell the PMC to ignore it.
 	 */
 	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
-	pmc_core_send_ltr_ignore(pmcdev, 3);
+	pmc_core_send_ltr_ignore(pmcdev, 3, 1);
 
 	return 0;
 }
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 31905003bb05..aa44c6612af9 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -476,7 +476,7 @@ static int pmc_core_pll_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(pmc_core_pll);
 
-int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value)
+int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value, int ignore)
 {
 	struct pmc *pmc;
 	const struct pmc_reg_map *map;
@@ -514,7 +514,10 @@ int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value)
 	mutex_lock(&pmcdev->lock);
 
 	reg = pmc_core_reg_read(pmc, map->ltr_ignore_offset);
-	reg |= BIT(ltr_index);
+	if (ignore)
+		reg |= BIT(ltr_index);
+	else
+		reg &= ~BIT(ltr_index);
 	pmc_core_reg_write(pmc, map->ltr_ignore_offset, reg);
 
 	mutex_unlock(&pmcdev->lock);
@@ -537,7 +540,7 @@ static ssize_t pmc_core_ltr_ignore_write(struct file *file,
 	if (err)
 		return err;
 
-	err = pmc_core_send_ltr_ignore(pmcdev, value);
+	err = pmc_core_send_ltr_ignore(pmcdev, value, 1);
 
 	return err == 0 ? count : err;
 }
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index ce9b9efc9790..90f2dbc4df72 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -567,7 +567,8 @@ extern const struct pmc_reg_map arl_pchs_reg_map;
 
 extern void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev);
 extern int pmc_core_ssram_get_lpm_reqs(struct pmc_dev *pmcdev);
-extern int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value);
+extern int
+pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value, int ignore);
 
 int pmc_core_resume_common(struct pmc_dev *pmcdev);
 int get_primary_reg_base(struct pmc *pmc);
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index e75431325dda..ef78d14fc27f 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -1023,7 +1023,7 @@ int mtl_core_init(struct pmc_dev *pmcdev)
 	 * when a cable is attached. Tell the PMC to ignore it.
 	 */
 	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
-	pmc_core_send_ltr_ignore(pmcdev, 3);
+	pmc_core_send_ltr_ignore(pmcdev, 3, 1);
 
 	if (ssram_init)
 		return pmc_core_ssram_get_lpm_reqs(pmcdev);
diff --git a/drivers/platform/x86/intel/pmc/tgl.c b/drivers/platform/x86/intel/pmc/tgl.c
index 91fd725951e5..8213961975fc 100644
--- a/drivers/platform/x86/intel/pmc/tgl.c
+++ b/drivers/platform/x86/intel/pmc/tgl.c
@@ -315,7 +315,7 @@ int tgl_core_generic_init(struct pmc_dev *pmcdev, int pch_tp)
 	 * when a cable is attached. Tell the PMC to ignore it.
 	 */
 	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
-	pmc_core_send_ltr_ignore(pmcdev, 3);
+	pmc_core_send_ltr_ignore(pmcdev, 3, 1);
 
 	return 0;
 }
-- 
2.34.1


