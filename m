Return-Path: <linux-kernel+bounces-92373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CF4871F2C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD542B25300
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF225C8EB;
	Tue,  5 Mar 2024 12:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VfAiCd7I"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C905C605
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 12:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641659; cv=none; b=hhQ1VJZule1k5BreVZ7gw0jUZc/ku1WOIj4F+yUeWjQZ7uxDFtrQbIjisNmN8IbOF8nLKSQthqi6PXaOnxvcetdZ6+wV9MLrOKEUsnBqkbI1YXQS4hZl82qRx9rxTnjU+iVcBaqQJaV/rN0qM4arD7+Z6j1fCabeQQIChtafzZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641659; c=relaxed/simple;
	bh=VouZ/6ufeu12LgA8puasFbjIcELZDxJkCgL7ecRZX+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mE5uRF+71tU3b3C3r1k5uwT9kCChQ8UEk6nhwQXLBcYQu4cDDCGN1PCUN1Dvi6gNheYwHdu8Ed5305irLmv206RO4NTdGaDH68Ei6/l4dmJq40fcHfK+63e2JQ4oABlapiUNhOFRDTLLuZk5GYh992/ZIXP3wVXhf+TbrceLs1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VfAiCd7I; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709641657; x=1741177657;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VouZ/6ufeu12LgA8puasFbjIcELZDxJkCgL7ecRZX+U=;
  b=VfAiCd7IIcJg5idN/ks5Z9mRqUSRiuyH9diKZVfMUjN7I233rdwNSKV/
   svIqvK6iXH1rnUaWzOJnP0C+FSPzIDsKZRn2zKFDwC2gIbYp0tVctYXGq
   op/SjK9cSeq4RP0o5h/QLI5KXbNyLD72hUIGNVjGdtSz2Gn8AEq9dz0bQ
   jvBo/LZHmW/kFHBXhAu1j8xaTIcRAipmzvbXkMlrnvY7BpQJQRX5EGVl8
   ideiqdyOZYWKhkkRpJ9LlmdRhBaJFj6RFG85rXYNa+oL8mn/Xfn8uUbG9
   8ZMKyGYrH8iCm5VtfCoLAltK/9a0lexInrFZ5yKCBLg1dgZ+dQ0o+MQ6D
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="21648495"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="21648495"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 04:27:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9330135"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 05 Mar 2024 04:27:36 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Ethan Zhao <haifeng.zhao@linux.intel.com>,
	Eric Badger <ebadger@purestorage.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] iommu/vt-d: Setup scalable mode context entry in probe path
Date: Tue,  5 Mar 2024 20:21:19 +0800
Message-Id: <20240305122121.211482-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305122121.211482-1-baolu.lu@linux.intel.com>
References: <20240305122121.211482-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240305013305.204605-4-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/pasid.h |   1 +
 drivers/iommu/intel/iommu.c |  12 ++++
 drivers/iommu/intel/pasid.c | 138 ++++++++++++++++++++++++++++++++++++
 3 files changed, 151 insertions(+)

diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index 42fda97fd851..da9978fef7ac 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -318,5 +318,6 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
 				 bool fault_ignore);
 void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
 					  struct device *dev, u32 pasid);
+int intel_pasid_setup_sm_context(struct device *dev);
 void intel_pasid_teardown_sm_context(struct device *dev);
 #endif /* __INTEL_PASID_H */
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f74d42d3258f..9b96d36b9d2a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4073,6 +4073,10 @@ int prepare_domain_attach_device(struct iommu_domain *domain,
 		dmar_domain->agaw--;
 	}
 
+	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev) &&
+	    context_copied(iommu, info->bus, info->devfn))
+		return intel_pasid_setup_sm_context(dev);
+
 	return 0;
 }
 
@@ -4386,11 +4390,19 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 			dev_err(dev, "PASID table allocation failed\n");
 			goto clear_rbtree;
 		}
+
+		if (!context_copied(iommu, info->bus, info->devfn)) {
+			ret = intel_pasid_setup_sm_context(dev);
+			if (ret)
+				goto free_table;
+		}
 	}
 
 	intel_iommu_debugfs_create_dev(info);
 
 	return &iommu->iommu;
+free_table:
+	intel_pasid_free_table(dev);
 clear_rbtree:
 	device_rbtree_remove(info);
 free:
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index a51e895d9a17..11f0b856d74c 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -734,3 +734,141 @@ void intel_pasid_teardown_sm_context(struct device *dev)
 
 	pci_for_each_dma_alias(to_pci_dev(dev), pci_pasid_table_teardown, dev);
 }
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
+	__iommu_flush_cache(iommu, context, sizeof(*context));
+
+	return 0;
+}
+
+static int device_pasid_table_setup(struct device *dev, u8 bus, u8 devfn)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+	struct context_entry *context;
+
+	spin_lock(&iommu->lock);
+	context = iommu_context_addr(iommu, bus, devfn, true);
+	if (!context) {
+		spin_unlock(&iommu->lock);
+		return -ENOMEM;
+	}
+
+	if (context_present(context) && !context_copied(iommu, bus, devfn)) {
+		spin_unlock(&iommu->lock);
+		return 0;
+	}
+
+	if (context_copied(iommu, bus, devfn)) {
+		context_clear_entry(context);
+		__iommu_flush_cache(iommu, context, sizeof(*context));
+
+		/*
+		 * For kdump cases, old valid entries may be cached due to
+		 * the in-flight DMA and copied pgtable, but there is no
+		 * unmapping behaviour for them, thus we need explicit cache
+		 * flushes for all affected domain IDs and PASIDs used in
+		 * the copied PASID table. Given that we have no idea about
+		 * which domain IDs and PASIDs were used in the copied tables,
+		 * upgrade them to global PASID and IOTLB cache invalidation.
+		 */
+		iommu->flush.flush_context(iommu, 0,
+					   PCI_DEVID(bus, devfn),
+					   DMA_CCMD_MASK_NOBIT,
+					   DMA_CCMD_DEVICE_INVL);
+		qi_flush_pasid_cache(iommu, 0, QI_PC_GLOBAL, 0);
+		iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
+		devtlb_invalidation_with_pasid(iommu, dev, IOMMU_NO_PASID);
+
+		/*
+		 * At this point, the device is supposed to finish reset at
+		 * its driver probe stage, so no in-flight DMA will exist,
+		 * and we don't need to worry anymore hereafter.
+		 */
+		clear_context_copied(iommu, bus, devfn);
+	}
+
+	context_entry_set_pasid_table(context, dev);
+	spin_unlock(&iommu->lock);
+
+	/*
+	 * It's a non-present to present mapping. If hardware doesn't cache
+	 * non-present entry we don't need to flush the caches. If it does
+	 * cache non-present entries, then it does so in the special
+	 * domain #0, which we have to flush:
+	 */
+	if (cap_caching_mode(iommu->cap)) {
+		iommu->flush.flush_context(iommu, 0,
+					   PCI_DEVID(bus, devfn),
+					   DMA_CCMD_MASK_NOBIT,
+					   DMA_CCMD_DEVICE_INVL);
+		iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_DSI_FLUSH);
+	}
+
+	return 0;
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
+ * and its alias requester ID for DMA.
+ */
+int intel_pasid_setup_sm_context(struct device *dev)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+
+	if (!dev_is_pci(dev))
+		return device_pasid_table_setup(dev, info->bus, info->devfn);
+
+	return pci_for_each_dma_alias(to_pci_dev(dev), pci_pasid_table_setup, dev);
+}
-- 
2.34.1


