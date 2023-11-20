Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80A47F121F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbjKTLec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbjKTLeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:34:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AB7A7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700480058; x=1732016058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6xRpfIwAcngpnwa9c8V3XoSGyTL3xX5Z/sBDIadwOT4=;
  b=SeSHNJTrLVipKGMX2bxEP7qfvcxyLquazr2Q15YDfCs9cJuNH9O1lrbn
   4PBx6lA2WAnGD08JZUqHVWsaz+0IEvxB1MOiyPWWRFk8Xf0vA51KHo7qo
   QvPpMFsGWSH6W5PzhttJrY/87GCRt4Es4Tk5Q1LCmpEXCiaK1ReVsPkAu
   aWHPzFKXY/I02QD6S4uqFX2LP4Nj+foBH5rXaVgESRfyOKmHslp+1/QFh
   J7mlngqrh75LkV2zGi/8VKhyIm7D1juHZWxdrAglsSilCFAQwM68wYI6E
   TbqtjsUtk/3XtOgOAFG266I2uPjATID/5TP4MqFeiKyGNY8bEWm9yTP1Z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="376634979"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="376634979"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:34:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="856963612"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="856963612"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Nov 2023 03:34:05 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/5] iommu/vt-d: Setup scalable mode context entry in probe path
Date:   Mon, 20 Nov 2023 19:29:40 +0800
Message-Id: <20231120112944.142741-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120112944.142741-1-baolu.lu@linux.intel.com>
References: <20231120112944.142741-1-baolu.lu@linux.intel.com>
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

In contrast to legacy mode, the DMA translation table is configured in
the PASID table entry instead of the context entry for scalable mode.
For this reason, it is more appropriate to set up the scalable mode
context entry in the device_probe callback and direct it to the
appropriate PASID table.

The iommu domain attach/detach operations only affect the PASID table
entry. Therefore, there is no need to modify the context entry when
configuring the translation type and page table.

The only exception is the kdump case, where context entry setup is
postponed until the device driver invokes the first DMA interface.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.h |   1 +
 drivers/iommu/intel/iommu.c |  17 +++-
 drivers/iommu/intel/pasid.c | 180 ++++++++++++++++++++++++++++++++++++
 3 files changed, 195 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index 8d40d4c66e31..58d7049081b9 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -319,4 +319,5 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
 				 bool fault_ignore);
 void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
 					  struct device *dev, u32 pasid);
+int intel_pasid_setup_sm_context(struct device *dev, bool deferred);
 #endif /* __INTEL_PASID_H */
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5092330f6a10..e34a32cd2b9a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4270,15 +4270,26 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 		ret = intel_pasid_alloc_table(dev);
 		if (ret) {
 			dev_err(dev, "PASID table allocation failed\n");
-			dev_iommu_priv_set(dev, NULL);
-			kfree(info);
-			return ERR_PTR(ret);
+			goto err_clear_priv;
+		}
+
+		ret = intel_pasid_setup_sm_context(dev, false);
+		if (ret) {
+			dev_err(dev, "Scalable context entry setup failed\n");
+			goto err_free_table;
 		}
 	}
 
 	intel_iommu_debugfs_create_dev(info);
 
 	return &iommu->iommu;
+err_free_table:
+	intel_pasid_free_table(dev);
+err_clear_priv:
+	dev_iommu_priv_set(dev, NULL);
+	kfree(info);
+
+return ERR_PTR(ret);
 }
 
 static void intel_iommu_release_device(struct device *dev)
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 3239cefa4c33..9e505060617a 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -304,6 +304,11 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 		return -EINVAL;
 	}
 
+	if (intel_pasid_setup_sm_context(dev, true)) {
+		dev_err(dev, "Context entry is not configured\n");
+		return -ENODEV;
+	}
+
 	spin_lock(&iommu->lock);
 	pte = intel_pasid_get_entry(dev, pasid);
 	if (!pte) {
@@ -384,6 +389,11 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 		return -EINVAL;
 	}
 
+	if (intel_pasid_setup_sm_context(dev, true)) {
+		dev_err(dev, "Context entry is not configured\n");
+		return -ENODEV;
+	}
+
 	pgd = domain->pgd;
 	agaw = iommu_skip_agaw(domain, iommu, &pgd);
 	if (agaw < 0) {
@@ -505,6 +515,11 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 	u16 did = FLPT_DEFAULT_DID;
 	struct pasid_entry *pte;
 
+	if (intel_pasid_setup_sm_context(dev, true)) {
+		dev_err(dev, "Context entry is not configured\n");
+		return -ENODEV;
+	}
+
 	spin_lock(&iommu->lock);
 	pte = intel_pasid_get_entry(dev, pasid);
 	if (!pte) {
@@ -623,6 +638,11 @@ int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device *dev,
 		return -EINVAL;
 	}
 
+	if (intel_pasid_setup_sm_context(dev, true)) {
+		dev_err_ratelimited(dev, "Context entry is not configured\n");
+		return -ENODEV;
+	}
+
 	spin_lock(&iommu->lock);
 	pte = intel_pasid_get_entry(dev, pasid);
 	if (!pte) {
@@ -666,3 +686,163 @@ int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device *dev,
 
 	return 0;
 }
+
+/*
+ * Interface to set a pasid table to the scalable mode context table entry:
+ */
+
+/*
+ * Get the PASID directory size for scalable mode context entry.
+ * Value of X in the PDTS field of a scalable mode context entry
+ * indicates PASID directory with 2^(X + 7) entries.
+ */
+static unsigned long context_get_sm_pds(struct pasid_table *table)
+{
+	unsigned long pds, max_pde;
+
+	max_pde = table->max_pasid >> PASID_PDE_SHIFT;
+	pds = find_first_bit(&max_pde, MAX_NR_PASID_BITS);
+	if (pds < 7)
+		return 0;
+
+	return pds - 7;
+}
+
+static int context_entry_set_pasid_table(struct context_entry *context,
+					 struct device *dev)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct pasid_table *table = info->pasid_table;
+	struct intel_iommu *iommu = info->iommu;
+	unsigned long pds;
+
+	context_clear_entry(context);
+
+	pds = context_get_sm_pds(table);
+	context->lo = (u64)virt_to_phys(table->table) | context_pdts(pds);
+	context_set_sm_rid2pasid(context, IOMMU_NO_PASID);
+
+	if (info->ats_supported)
+		context_set_sm_dte(context);
+	if (info->pri_supported)
+		context_set_sm_pre(context);
+	if (info->pasid_supported)
+		context_set_pasid(context);
+
+	context_set_fault_enable(context);
+	context_set_present(context);
+	if (!ecap_coherent(iommu->ecap))
+		clflush_cache_range(context, sizeof(*context));
+
+	return 0;
+}
+
+static int device_pasid_table_setup(struct device *dev, u8 bus, u8 devfn)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+	struct context_entry *context;
+	int ret = 0;
+
+	spin_lock(&iommu->lock);
+	context = iommu_context_addr(iommu, bus, devfn, true);
+	if (!context) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
+
+	if (context_present(context) && !context_copied(iommu, bus, devfn))
+		goto out_unlock;
+
+	/*
+	 * Cache invalidation for changes to a scalable-mode context table
+	 * entry.
+	 *
+	 * Section 6.5.3.3 of the VT-d spec:
+	 * - Device-selective context-cache invalidation;
+	 * - Domain-selective PASID-cache invalidation to affected domains
+	 *   (can be skipped if all PASID entries were not-present);
+	 * - Domain-selective IOTLB invalidation to affected domains;
+	 * - Global Device-TLB invalidation to affected functions.
+	 *
+	 * For kdump cases, old valid entries may be cached due to the
+	 * in-flight DMA and copied pgtable, but there is no unmapping
+	 * behaviour for them, thus we need explicit cache flushes for all
+	 * affected domain IDs and PASIDs used in the copied PASID table.
+	 * Given that we have no idea about which domain IDs and PASIDs were
+	 * used in the copied tables, upgrade them to global PASID and IOTLB
+	 * cache invalidation.
+	 *
+	 * For kdump case, at this point, the device is supposed to finish
+	 * reset at its driver probe stage, so no in-flight DMA will exist,
+	 * and we don't need to worry anymore hereafter.
+	 */
+	if (context_copied(iommu, bus, devfn)) {
+		context_clear_entry(context);
+		clear_context_copied(iommu, bus, devfn);
+		iommu->flush.flush_context(iommu, 0,
+					   (((u16)bus) << 8) | devfn,
+					   DMA_CCMD_MASK_NOBIT,
+					   DMA_CCMD_DEVICE_INVL);
+		qi_flush_pasid_cache(iommu, 0, QI_PC_GLOBAL, 0);
+		iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
+		devtlb_invalidation_with_pasid(iommu, dev, IOMMU_NO_PASID);
+	}
+
+	context_entry_set_pasid_table(context, dev);
+
+	/*
+	 * It's a non-present to present mapping. If hardware doesn't cache
+	 * non-present entry we only need to flush the write-buffer. If the
+	 * _does_ cache non-present entries, then it does so in the special
+	 * domain ID #0, which we have to flush:
+	 */
+	if (cap_caching_mode(iommu->cap)) {
+		iommu->flush.flush_context(iommu, 0,
+					   (((u16)bus) << 8) | devfn,
+					   DMA_CCMD_MASK_NOBIT,
+					   DMA_CCMD_DEVICE_INVL);
+		iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
+	} else {
+		iommu_flush_write_buffer(iommu);
+	}
+
+out_unlock:
+	spin_unlock(&iommu->lock);
+	return ret;
+}
+
+static int pci_pasid_table_setup(struct pci_dev *pdev, u16 alias, void *data)
+{
+	struct device *dev = data;
+
+	if (dev != &pdev->dev)
+		return 0;
+
+	return device_pasid_table_setup(dev, PCI_BUS_NUM(alias), alias & 0xff);
+}
+
+/*
+ * Set the device's PASID table to its context table entry.
+ *
+ * The PASID table is set to the context entries of both device itself
+ * and its alias requester ID for DMA. If it is called in domain attach
+ * paths, set @deferred to true, false in other cases.
+ */
+int intel_pasid_setup_sm_context(struct device *dev, bool deferred)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+
+	/*
+	 * Skip pasid table setting up if context entry is copied and
+	 * function is not called in deferred attachment context.
+	 */
+	if (deferred ^ context_copied(iommu, info->bus, info->devfn))
+		return 0;
+
+	if (!dev_is_pci(dev))
+		return device_pasid_table_setup(dev, info->bus, info->devfn);
+
+	return pci_for_each_dma_alias(to_pci_dev(dev), pci_pasid_table_setup, dev);
+}
-- 
2.34.1

