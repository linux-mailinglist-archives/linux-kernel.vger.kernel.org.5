Return-Path: <linux-kernel+bounces-4669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1A4818075
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 719011F24BAF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92FB848E;
	Tue, 19 Dec 2023 04:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kEexX142"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D60D5393;
	Tue, 19 Dec 2023 04:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702959754; x=1734495754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZQqaSDCmjnykVV5agVbBRicUXn0yEMnSuoI5xtPJuvU=;
  b=kEexX142tjQaTKbpMrKCfMacBdZ/WT5eBp5scDHqdjFgjBPiumlqa5RN
   vP+/JOVS7nOSCwbUj6sG9wqEzHWsz2PORWB4XWfavsqRdRAje+xl7qz77
   qeeS1QjJB28rtwy9ZtRGIml92DTQnqCrybZhHqmi00VJbFg1bm7vEZZNd
   uVW5zjWBpVlCVYLv7Z8m9CoNcdreWrTj1euJqfBPy1qokGFBxDBAqa/vO
   kvb9k/2Brqlu7MjnutO9Oj1/FgTCbG6QRPrudIeYEpGUIcRgfaoa+EOD1
   13FCtoLQLqVqUtF2oQKsEHd4hnJvnarNWcvyxFl8nqYZpOs5xHBbbtr37
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="2455977"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="2455977"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 20:22:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="919503104"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="919503104"
Received: from mnichels-mobl1.amr.corp.intel.com (HELO rjingar-desk5.intel.com) ([10.212.29.225])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 20:22:30 -0800
From: rjingar <rajvi.jingar@linux.intel.com>
To: irenic.rajneesh@gmail.com,
	david.e.box@intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rajvi.jingar@linux.intel.com
Subject: [PATCH 3/8] platform/x86/intel/pmc: Add regmap for Tiger Lake H PCH
Date: Mon, 18 Dec 2023 20:22:11 -0800
Message-Id: <20231219042216.2592029-3-rajvi.jingar@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219042216.2592029-1-rajvi.jingar@linux.intel.com>
References: <20231219042216.2592029-1-rajvi.jingar@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rajvi Jingar <rajvi.jingar@linux.intel.com>

Tiger Lake H PCH is same as Tiger Lake LP PCH from the driver
perspective with the addition of the PSON residency counter. Add regmap
for TGP H to add PSON register offsets for Tiger Lake H PCH.

Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 10 +++---
 drivers/platform/x86/intel/pmc/core.h |  6 ++++
 drivers/platform/x86/intel/pmc/tgl.c  | 48 ++++++++++++++++++++++++++-
 3 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 91e5e500eb41..e95105ad1243 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1216,15 +1216,15 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_NNPI,	icl_core_init),
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		cnp_core_init),
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		cnp_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		tgl_core_init),
+	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		tgl_l_core_init),
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		tgl_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,	tgl_core_init),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,	tgl_l_core_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	icl_core_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		tgl_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		tgl_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,	tgl_core_init),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		tgl_l_core_init),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,	tgl_l_core_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		adl_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        tgl_core_init),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        tgl_l_core_init),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		adl_core_init),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	adl_core_init),
 	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,	mtl_core_init),
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 91cb34a6505c..d09962940ad6 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -223,6 +223,10 @@ enum ppfear_regs {
 #define TGL_LPM_PRI_OFFSET			0x1C7C
 #define TGL_LPM_NUM_MAPS			6
 
+/* Tigerlake PSON residency register */
+#define TGL_PSON_RESIDENCY_OFFSET		0x18f8
+#define TGL_PSON_RES_COUNTER_STEP		0x7A
+
 /* Extended Test Mode Register 3 (CNL and later) */
 #define ETR3_OFFSET				0x1048
 #define ETR3_CF9GR				BIT(20)
@@ -507,6 +511,8 @@ int spt_core_init(struct pmc_dev *pmcdev);
 int cnp_core_init(struct pmc_dev *pmcdev);
 int icl_core_init(struct pmc_dev *pmcdev);
 int tgl_core_init(struct pmc_dev *pmcdev);
+int tgl_l_core_init(struct pmc_dev *pmcdev);
+int tgl_core_generic_init(struct pmc_dev *pmcdev, int pch_tp);
 int adl_core_init(struct pmc_dev *pmcdev);
 int mtl_core_init(struct pmc_dev *pmcdev);
 
diff --git a/drivers/platform/x86/intel/pmc/tgl.c b/drivers/platform/x86/intel/pmc/tgl.c
index d5f1d2223c5a..91fd725951e5 100644
--- a/drivers/platform/x86/intel/pmc/tgl.c
+++ b/drivers/platform/x86/intel/pmc/tgl.c
@@ -13,6 +13,11 @@
 #define ACPI_S0IX_DSM_UUID		"57a6512e-3979-4e9d-9708-ff13b2508972"
 #define ACPI_GET_LOW_MODE_REGISTERS	1
 
+enum pch_type {
+	PCH_H,
+	PCH_LP
+};
+
 const struct pmc_bit_map tgl_pfear_map[] = {
 	{"PSF9",		BIT(0)},
 	{"RES_66",		BIT(1)},
@@ -205,6 +210,33 @@ const struct pmc_reg_map tgl_reg_map = {
 	.etr3_offset = ETR3_OFFSET,
 };
 
+const struct pmc_reg_map tgl_h_reg_map = {
+	.pfear_sts = ext_tgl_pfear_map,
+	.slp_s0_offset = CNP_PMC_SLP_S0_RES_COUNTER_OFFSET,
+	.slp_s0_res_counter_step = TGL_PMC_SLP_S0_RES_COUNTER_STEP,
+	.ltr_show_sts = cnp_ltr_show_map,
+	.msr_sts = msr_map,
+	.ltr_ignore_offset = CNP_PMC_LTR_IGNORE_OFFSET,
+	.regmap_length = CNP_PMC_MMIO_REG_LEN,
+	.ppfear0_offset = CNP_PMC_HOST_PPFEAR0A,
+	.ppfear_buckets = ICL_PPFEAR_NUM_ENTRIES,
+	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
+	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
+	.ltr_ignore_max = TGL_NUM_IP_IGN_ALLOWED,
+	.lpm_num_maps = TGL_LPM_NUM_MAPS,
+	.lpm_res_counter_step_x2 = TGL_PMC_LPM_RES_COUNTER_STEP_X2,
+	.lpm_sts_latch_en_offset = TGL_LPM_STS_LATCH_EN_OFFSET,
+	.lpm_en_offset = TGL_LPM_EN_OFFSET,
+	.lpm_priority_offset = TGL_LPM_PRI_OFFSET,
+	.lpm_residency_offset = TGL_LPM_RESIDENCY_OFFSET,
+	.lpm_sts = tgl_lpm_maps,
+	.lpm_status_offset = TGL_LPM_STATUS_OFFSET,
+	.lpm_live_status_offset = TGL_LPM_LIVE_STATUS_OFFSET,
+	.etr3_offset = ETR3_OFFSET,
+	.pson_residency_offset = TGL_PSON_RESIDENCY_OFFSET,
+	.pson_residency_counter_step = TGL_PSON_RES_COUNTER_STEP,
+};
+
 void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev)
 {
 	struct pmc_dev *pmcdev = platform_get_drvdata(pdev);
@@ -253,12 +285,26 @@ void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev)
 	ACPI_FREE(out_obj);
 }
 
+int tgl_l_core_init(struct pmc_dev *pmcdev)
+{
+	return tgl_core_generic_init(pmcdev, PCH_LP);
+}
+
 int tgl_core_init(struct pmc_dev *pmcdev)
+{
+	return tgl_core_generic_init(pmcdev, PCH_H);
+}
+
+int tgl_core_generic_init(struct pmc_dev *pmcdev, int pch_tp)
 {
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
 	int ret;
 
-	pmc->map = &tgl_reg_map;
+	if (pch_tp == PCH_H)
+		pmc->map = &tgl_h_reg_map;
+	else
+		pmc->map = &tgl_reg_map;
+
 	ret = get_primary_reg_base(pmc);
 	if (ret)
 		return ret;
-- 
2.34.1


