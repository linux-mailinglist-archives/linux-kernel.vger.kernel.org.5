Return-Path: <linux-kernel+bounces-4672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E5D81807B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCE961F24C6F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29828C8C2;
	Tue, 19 Dec 2023 04:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cg0WA5Xl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9B8746A;
	Tue, 19 Dec 2023 04:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702959755; x=1734495755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jltCEd9D388uWH/f50L5sLaMPT/8Tdel3k13skTpw5w=;
  b=cg0WA5XlVCkodpiEa24dNeskL8UsGpByjRYIdfPP53BuCdsR09ZXwgjY
   2+j6NZGhUa2dxa4Vayh1uZ2I1QqiEMJ/NZgeDSXLoSSEpHDXqTMPPtpG7
   o1HfLdKgVLsOjLpxEPf+iD/D11kzMMg2fImbk+brNpBAdFe9EHUD2FQ77
   cj1R0wsomu5OqiFeaxtbtF4HnbufnZS70mxfpD/fdgkCKM88b9BRsFq2k
   R5Bi5P7ancOnLMi5WRwDOt/gWqUvPUvGe138sOKy6YqodSnqRA6yKZB/1
   4os4kZnTQDOyfiuYsD4/VWPSd/YdwipDCVlJmUBXej2vjaTPwllYP2TEe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="2455986"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="2455986"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 20:22:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="919503115"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="919503115"
Received: from mnichels-mobl1.amr.corp.intel.com (HELO rjingar-desk5.intel.com) ([10.212.29.225])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 20:22:31 -0800
From: rjingar <rajvi.jingar@linux.intel.com>
To: irenic.rajneesh@gmail.com,
	david.e.box@intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rajvi.jingar@linux.intel.com
Subject: [PATCH 5/8] platform/x86/intel/pmc: Move common code to core.c
Date: Mon, 18 Dec 2023 20:22:13 -0800
Message-Id: <20231219042216.2592029-5-rajvi.jingar@linux.intel.com>
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

Functions like mtl_set_device_d3() and mtl_punit_pmt_init() were added for
Meteor Lake. To be able to use them in Arrow Lake and future platforms,
move them to core.c.

Also, to support different guids, add guid argument in
pmc_core_punit_pmt_init() and to support different PCI function numbers,
add func arg in pmc_core_ssram_init().

Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c       | 45 ++++++++++++++++
 drivers/platform/x86/intel/pmc/core.h       |  8 ++-
 drivers/platform/x86/intel/pmc/core_ssram.c |  4 +-
 drivers/platform/x86/intel/pmc/mtl.c        | 60 +++------------------
 4 files changed, 60 insertions(+), 57 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index e95105ad1243..ac446b0f2192 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1106,6 +1106,51 @@ int get_primary_reg_base(struct pmc *pmc)
 	return 0;
 }
 
+void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, u32 guid)
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
+	ep = pmt_telem_find_and_register_endpoint(pcidev, guid, 0);
+	pci_dev_put(pcidev);
+	if (IS_ERR(ep)) {
+		dev_err(&pmcdev->pdev->dev,
+			"pmc_core: couldn't get DMU telem endpoint %ld",
+			PTR_ERR(ep));
+		return;
+	}
+
+	pmcdev->punit_ep = ep;
+
+	pmcdev->has_die_c6 = true;
+	pmcdev->die_c6_offset = MTL_PMT_DMU_DIE_C6_OFFSET;
+}
+
+void pmc_core_set_device_d3(unsigned int device)
+{
+	struct pci_dev *pcidev;
+
+	pcidev = pci_get_device(PCI_VENDOR_ID_INTEL, device, NULL);
+	if (pcidev) {
+		if (!device_trylock(&pcidev->dev)) {
+			pci_dev_put(pcidev);
+			return;
+		}
+		if (!pcidev->dev.driver) {
+			dev_info(&pcidev->dev, "Setting to D3hot\n");
+			pci_set_power_state(pcidev, PCI_D3hot);
+		}
+		device_unlock(&pcidev->dev);
+		pci_dev_put(pcidev);
+	}
+}
+
 static bool pmc_core_is_pson_residency_enabled(struct pmc_dev *pmcdev)
 {
 	struct platform_device *pdev = pmcdev->pdev;
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index d09962940ad6..e678a1205514 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -268,6 +268,10 @@ enum ppfear_regs {
 #define MTL_SOCM_PPFEAR_NUM_ENTRIES		8
 #define MTL_IOE_PPFEAR_NUM_ENTRIES		10
 
+/* Die C6 from PUNIT telemetry */
+#define MTL_PMT_DMU_DIE_C6_OFFSET		15
+#define MTL_PMT_DMU_GUID			0x1A067102
+
 extern const char *pmc_lpm_modes[];
 
 struct pmc_bit_map {
@@ -504,8 +508,10 @@ extern int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value);
 int pmc_core_resume_common(struct pmc_dev *pmcdev);
 int get_primary_reg_base(struct pmc *pmc);
 extern void pmc_core_get_low_power_modes(struct pmc_dev *pmcdev);
+extern void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, u32 guid);
+extern void pmc_core_set_device_d3(unsigned int device);
 
-extern int pmc_core_ssram_init(struct pmc_dev *pmcdev);
+extern int pmc_core_ssram_init(struct pmc_dev *pmcdev, int func);
 
 int spt_core_init(struct pmc_dev *pmcdev);
 int cnp_core_init(struct pmc_dev *pmcdev);
diff --git a/drivers/platform/x86/intel/pmc/core_ssram.c b/drivers/platform/x86/intel/pmc/core_ssram.c
index 55e54207987c..1bde86c54eb9 100644
--- a/drivers/platform/x86/intel/pmc/core_ssram.c
+++ b/drivers/platform/x86/intel/pmc/core_ssram.c
@@ -290,12 +290,12 @@ pmc_core_ssram_get_pmc(struct pmc_dev *pmcdev, int pmc_idx, u32 offset)
 	return pmc_core_pmc_add(pmcdev, pwrm_base, map, pmc_idx);
 }
 
-int pmc_core_ssram_init(struct pmc_dev *pmcdev)
+int pmc_core_ssram_init(struct pmc_dev *pmcdev, int func)
 {
 	struct pci_dev *pcidev;
 	int ret;
 
-	pcidev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(20, 2));
+	pcidev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(20, func));
 	if (!pcidev)
 		return -ENODEV;
 
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index fb59dffccf28..d2470f800298 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -17,10 +17,6 @@
 #define IOEM_LPM_REQ_GUID	0x4357464
 #define IOEP_LPM_REQ_GUID	0x5077612
 
-/* Die C6 from PUNIT telemetry */
-#define MTL_PMT_DMU_DIE_C6_OFFSET	15
-#define MTL_PMT_DMU_GUID		0x1A067102
-
 static const u8 MTL_LPM_REG_INDEX[] = {0, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 20};
 
 /*
@@ -973,63 +969,18 @@ static struct pmc_info mtl_pmc_info_list[] = {
 	{}
 };
 
-static void mtl_punit_pmt_init(struct pmc_dev *pmcdev)
-{
-	struct telem_endpoint *ep;
-	struct pci_dev *pcidev;
-
-	pcidev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(10, 0));
-	if (!pcidev) {
-		dev_err(&pmcdev->pdev->dev, "PUNIT PMT device not found.\n");
-		return;
-	}
-
-	ep = pmt_telem_find_and_register_endpoint(pcidev, MTL_PMT_DMU_GUID, 0);
-	pci_dev_put(pcidev);
-	if (IS_ERR(ep)) {
-		dev_err(&pmcdev->pdev->dev,
-			"pmc_core: couldn't get DMU telem endpoint, %ld\n",
-			PTR_ERR(ep));
-		return;
-	}
-
-	pmcdev->punit_ep = ep;
-
-	pmcdev->has_die_c6 = true;
-	pmcdev->die_c6_offset = MTL_PMT_DMU_DIE_C6_OFFSET;
-}
-
 #define MTL_GNA_PCI_DEV	0x7e4c
 #define MTL_IPU_PCI_DEV	0x7d19
 #define MTL_VPU_PCI_DEV	0x7d1d
-static void mtl_set_device_d3(unsigned int device)
-{
-	struct pci_dev *pcidev;
-
-	pcidev = pci_get_device(PCI_VENDOR_ID_INTEL, device, NULL);
-	if (pcidev) {
-		if (!device_trylock(&pcidev->dev)) {
-			pci_dev_put(pcidev);
-			return;
-		}
-		if (!pcidev->dev.driver) {
-			dev_info(&pcidev->dev, "Setting to D3hot\n");
-			pci_set_power_state(pcidev, PCI_D3hot);
-		}
-		device_unlock(&pcidev->dev);
-		pci_dev_put(pcidev);
-	}
-}
-
 /*
  * Set power state of select devices that do not have drivers to D3
  * so that they do not block Package C entry.
  */
 static void mtl_d3_fixup(void)
 {
-	mtl_set_device_d3(MTL_GNA_PCI_DEV);
-	mtl_set_device_d3(MTL_IPU_PCI_DEV);
-	mtl_set_device_d3(MTL_VPU_PCI_DEV);
+	pmc_core_set_device_d3(MTL_GNA_PCI_DEV);
+	pmc_core_set_device_d3(MTL_IPU_PCI_DEV);
+	pmc_core_set_device_d3(MTL_VPU_PCI_DEV);
 }
 
 static int mtl_resume(struct pmc_dev *pmcdev)
@@ -1042,6 +993,7 @@ int mtl_core_init(struct pmc_dev *pmcdev)
 {
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
 	int ret;
+	int func = 2;
 
 	mtl_d3_fixup();
 
@@ -1052,7 +1004,7 @@ int mtl_core_init(struct pmc_dev *pmcdev)
 	 * If ssram init fails use legacy method to at least get the
 	 * primary PMC
 	 */
-	ret = pmc_core_ssram_init(pmcdev);
+	ret = pmc_core_ssram_init(pmcdev, func);
 	if (ret) {
 		dev_warn(&pmcdev->pdev->dev,
 			 "ssram init failed, %d, using legacy init\n", ret);
@@ -1063,7 +1015,7 @@ int mtl_core_init(struct pmc_dev *pmcdev)
 	}
 
 	pmc_core_get_low_power_modes(pmcdev);
-	mtl_punit_pmt_init(pmcdev);
+	pmc_core_punit_pmt_init(pmcdev, MTL_PMT_DMU_GUID);
 
 	/* Due to a hardware limitation, the GBE LTR blocks PC10
 	 * when a cable is attached. Tell the PMC to ignore it.
-- 
2.34.1


