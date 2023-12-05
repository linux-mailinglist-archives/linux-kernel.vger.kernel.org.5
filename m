Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249E880440C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 02:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343905AbjLEB1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 20:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346337AbjLEB05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 20:26:57 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F1418A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 17:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701739617; x=1733275617;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u1gb+xXuSLrs67n4B6W8q40HRhcbFjefDWfMBwrFYbE=;
  b=WwosC1tF7difF/42duQS89tBujS6p6/yB5253cwVNu2HyBSOTBFuR7k7
   JYij1OibK//jlsxs3NkXGi43TGMr94PjhjJLE2vpg4Pcprh7zqBoXvWIY
   u3rHMGye3cNkQWj/q6yRxpe2F/b75p5XziV4E0ZpOcqxbxMqXnwGF967r
   VAyRGm68sE/CVoysVWSZM0P7Hwz3cboURO/Evdw4AxNiww8TLplZ3P1Y+
   KwHH69epjJuA5FSmBIh/SipqQNpY6mBoTMCZ5MGavpRQrZRrnLdalkc8Z
   w4F8bb+Z+y1c4mXwgSgMNlbfqibPcBjAVEIJNniJgeEFtvmJqTOugnVpX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="460313368"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="460313368"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 17:26:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="1102276337"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="1102276337"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 04 Dec 2023 17:26:53 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 6/6] iommu/vt-d: Cleanup si_domain
Date:   Tue,  5 Dec 2023 09:22:03 +0800
Message-Id: <20231205012203.244584-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205012203.244584-1-baolu.lu@linux.intel.com>
References: <20231205012203.244584-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The static identity domain has been introduced, rendering the si_domain
obsolete. Remove si_domain and cleanup the code accordingly.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 118 +++++++-----------------------------
 1 file changed, 23 insertions(+), 95 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 3c747d19495e..91443b34111b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -97,15 +97,6 @@ static phys_addr_t root_entry_uctp(struct root_entry *re)
 	return re->hi & VTD_PAGE_MASK;
 }
 
-/*
- * This domain is a statically identity mapping domain.
- *	1. This domain creats a static 1:1 mapping to all usable memory.
- * 	2. It maps to each iommu if successful.
- *	3. Each iommu mapps to this domain if successful.
- */
-static struct dmar_domain *si_domain;
-static int hw_pass_through = 1;
-
 struct dmar_rmrr_unit {
 	struct list_head list;		/* list of rmrr units	*/
 	struct acpi_dmar_header *hdr;	/* ACPI header		*/
@@ -240,11 +231,6 @@ void free_pgtable_page(void *vaddr)
 	free_page((unsigned long)vaddr);
 }
 
-static int domain_type_is_si(struct dmar_domain *domain)
-{
-	return domain->domain.type == IOMMU_DOMAIN_IDENTITY;
-}
-
 static int domain_pfn_supported(struct dmar_domain *domain, unsigned long pfn)
 {
 	int addr_width = agaw_to_width(domain->agaw) - VTD_PAGE_SHIFT;
@@ -1795,9 +1781,6 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	struct context_entry *context;
 	int agaw, ret;
 
-	if (hw_pass_through && domain_type_is_si(domain))
-		translation = CONTEXT_TT_PASS_THROUGH;
-
 	pr_debug("Set context mapping for %02x:%02x.%d\n",
 		bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
 
@@ -1816,34 +1799,24 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 
 	context_set_domain_id(context, did);
 
-	if (translation != CONTEXT_TT_PASS_THROUGH) {
-		/*
-		 * Skip top levels of page tables for iommu which has
-		 * less agaw than default. Unnecessary for PT mode.
-		 */
-		for (agaw = domain->agaw; agaw > iommu->agaw; agaw--) {
-			ret = -ENOMEM;
-			pgd = phys_to_virt(dma_pte_addr(pgd));
-			if (!dma_pte_present(pgd))
-				goto out_unlock;
-		}
-
-		if (info && info->ats_supported)
-			translation = CONTEXT_TT_DEV_IOTLB;
-		else
-			translation = CONTEXT_TT_MULTI_LEVEL;
-
-		context_set_address_root(context, virt_to_phys(pgd));
-		context_set_address_width(context, agaw);
-	} else {
-		/*
-		 * In pass through mode, AW must be programmed to
-		 * indicate the largest AGAW value supported by
-		 * hardware. And ASR is ignored by hardware.
-		 */
-		context_set_address_width(context, iommu->msagaw);
+	/*
+	 * Skip top levels of page tables for iommu which has
+	 * less agaw than default. Unnecessary for PT mode.
+	 */
+	for (agaw = domain->agaw; agaw > iommu->agaw; agaw--) {
+		ret = -ENOMEM;
+		pgd = phys_to_virt(dma_pte_addr(pgd));
+		if (!dma_pte_present(pgd))
+			goto out_unlock;
 	}
 
+	if (info && info->ats_supported)
+		translation = CONTEXT_TT_DEV_IOTLB;
+	else
+		translation = CONTEXT_TT_MULTI_LEVEL;
+
+	context_set_address_root(context, virt_to_phys(pgd));
+	context_set_address_width(context, agaw);
 	context_set_translation_type(context, translation);
 	context_set_fault_enable(context);
 	context_set_present(context);
@@ -2077,14 +2050,10 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 		return;
 	}
 
-	if (sm_supported(iommu)) {
-		if (hw_pass_through && domain_type_is_si(info->domain))
-			did_old = FLPT_DEFAULT_DID;
-		else
-			did_old = domain_id_iommu(info->domain, iommu);
-	} else {
-		did_old = context_domain_id(context);
-	}
+	if (info->domain)
+		did_old = domain_id_iommu(info->domain, iommu);
+	else
+		did_old = FLPT_DEFAULT_DID;
 
 	context_clear_entry(context);
 	__iommu_flush_cache(iommu, context, sizeof(*context));
@@ -2147,23 +2116,6 @@ static bool dev_is_real_dma_subdevice(struct device *dev)
 	       pci_real_dma_dev(to_pci_dev(dev)) != to_pci_dev(dev);
 }
 
-static int md_domain_init(struct dmar_domain *domain, int guest_width);
-
-static int __init si_domain_init(int hw)
-{
-	si_domain = alloc_domain(IOMMU_DOMAIN_IDENTITY);
-	if (!si_domain)
-		return -EFAULT;
-
-	if (md_domain_init(si_domain, DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
-		domain_exit(si_domain);
-		si_domain = NULL;
-		return -EFAULT;
-	}
-
-	return 0;
-}
-
 static int dmar_domain_attach_device(struct dmar_domain *domain,
 				     struct device *dev)
 {
@@ -2185,8 +2137,6 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 
 	if (!sm_supported(iommu))
 		ret = domain_context_mapping(domain, dev);
-	else if (hw_pass_through && domain_type_is_si(domain))
-		ret = intel_pasid_setup_pass_through(iommu, dev, IOMMU_NO_PASID);
 	else if (domain->use_first_level)
 		ret = domain_setup_first_level(iommu, domain, dev, IOMMU_NO_PASID);
 	else
@@ -2197,8 +2147,7 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 		return ret;
 	}
 
-	if (sm_supported(info->iommu) || !domain_type_is_si(info->domain))
-		iommu_enable_pci_caps(info);
+	iommu_enable_pci_caps(info);
 
 	return 0;
 }
@@ -2548,8 +2497,6 @@ static int __init init_dmars(void)
 			}
 		}
 
-		if (!ecap_pass_through(iommu->ecap))
-			hw_pass_through = 0;
 		intel_svm_check(iommu);
 	}
 
@@ -2572,10 +2519,6 @@ static int __init init_dmars(void)
 
 	check_tylersburg_isoch();
 
-	ret = si_domain_init(hw_pass_through);
-	if (ret)
-		goto free_iommu;
-
 	/*
 	 * for each drhd
 	 *   enable fault log
@@ -2621,10 +2564,6 @@ static int __init init_dmars(void)
 		disable_dmar_iommu(iommu);
 		free_dmar_iommu(iommu);
 	}
-	if (si_domain) {
-		domain_exit(si_domain);
-		si_domain = NULL;
-	}
 
 	return ret;
 }
@@ -2999,12 +2938,6 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	if (ret)
 		goto out;
 
-	if (hw_pass_through && !ecap_pass_through(iommu->ecap)) {
-		pr_warn("%s: Doesn't support hardware pass through.\n",
-			iommu->name);
-		return -ENXIO;
-	}
-
 	sp = domain_update_iommu_superpage(NULL, iommu) - 1;
 	if (sp >= 0 && !(cap_super_page_val(iommu->cap) & (1 << sp))) {
 		pr_warn("%s: Doesn't support large page.\n",
@@ -3718,8 +3651,6 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 		domain->geometry.force_aperture = true;
 
 		return domain;
-	case IOMMU_DOMAIN_IDENTITY:
-		return &si_domain->domain;
 	case IOMMU_DOMAIN_SVA:
 		return intel_svm_domain_alloc();
 	default:
@@ -3779,8 +3710,7 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
 
 static void intel_iommu_domain_free(struct iommu_domain *domain)
 {
-	if (domain != &si_domain->domain)
-		domain_exit(to_dmar_domain(domain));
+	domain_exit(to_dmar_domain(domain));
 }
 
 int prepare_domain_attach_device(struct iommu_domain *domain,
@@ -4487,9 +4417,7 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	if (ret)
 		goto out_free;
 
-	if (domain_type_is_si(dmar_domain))
-		ret = intel_pasid_setup_pass_through(iommu, dev, pasid);
-	else if (dmar_domain->use_first_level)
+	if (dmar_domain->use_first_level)
 		ret = domain_setup_first_level(iommu, dmar_domain,
 					       dev, pasid);
 	else
-- 
2.34.1

