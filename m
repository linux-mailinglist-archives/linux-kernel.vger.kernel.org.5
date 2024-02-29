Return-Path: <linux-kernel+bounces-86481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E20B86C610
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7370285B66
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099F162801;
	Thu, 29 Feb 2024 09:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TJMoyXAj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847766281E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709200342; cv=none; b=AYFwk+IHX/yO4SaOdGqZqn+IBajip1KPffx+V5IgYCXmCZGRy7z0QtUAN8oNf9l64GQTYGz1OLupzhRJiZjbhnV0S8nt1n7Yeq2Ai5rOL8LViaB/sfJrSbmb/KdpTQ7rLzkPjyNHhdpdTEw1PxfTkIbob8zWajKJk52MTQgf4fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709200342; c=relaxed/simple;
	bh=lKzo68tQ2/euX957y2t0ouNXm48fmjaBIyuo8kUBY4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t0o4E14zosOSfQDwYmbdvZRBGZJLFLmMTQ/d9gHSAxlPyLaBVTDxJz1XtlabZHg+3zKDaRZY+AnvXYJVN30bvWf6R6qRLoPBQBvfFKt9I2tumTJ7LjrNeWha+2gIIFXJh2Lxzj5fcIJs+AeXvR2Hvip7zx31bOoGGQlDWL9e5Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TJMoyXAj; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709200340; x=1740736340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lKzo68tQ2/euX957y2t0ouNXm48fmjaBIyuo8kUBY4I=;
  b=TJMoyXAjNVvmZcCJ75BAr0bqcobLu4D7JWO63zrSSqMoQRh9vsbtZ3j6
   H84JgMoHL+KKWdfwlObweU1MsEmw6YvorBqolMukqeqIYaIr/2Zu7HUdR
   veumDIGofq5WOFydaoHoJF/027VTcnmpE6a6wD3zfPvWdNXf6ea0YJnBm
   JLp8L4uvNvoGhaYkL/c95ZJnjG42p6FRk9ajTiIV2Ea9gPn6Nt14rpYgE
   oscgwJtq65WdtrJUJVA4R6Q+T7EjW4ZHeaJEdlxOzelSiL1m8xXwWAgK+
   BpnMrNyGxVpBqWjYFAumg8I2tmZ/5cBMrohWo6UAWfxLrMWOClnhSvMZy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14366693"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="14366693"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 01:52:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="38811022"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa001.fm.intel.com with ESMTP; 29 Feb 2024 01:52:18 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Eric Badger <ebadger@purestorage.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 2/2] iommu/vt-d: Fix NULL domain on device release
Date: Thu, 29 Feb 2024 17:46:13 +0800
Message-Id: <20240229094613.121575-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229094613.121575-1-baolu.lu@linux.intel.com>
References: <20240229094613.121575-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the kdump kernel, the IOMMU operates in deferred_attach mode. In this
mode, info->domain may not yet be assigned by the time the release_device
function is called. It leads to the following crash in the crash kernel:

    BUG: kernel NULL pointer dereference, address: 000000000000003c
    ...
    RIP: 0010:do_raw_spin_lock+0xa/0xa0
    ...
    _raw_spin_lock_irqsave+0x1b/0x30
    intel_iommu_release_device+0x96/0x170
    iommu_deinit_device+0x39/0xf0
    __iommu_group_remove_device+0xa0/0xd0
    iommu_bus_notifier+0x55/0xb0
    notifier_call_chain+0x5a/0xd0
    blocking_notifier_call_chain+0x41/0x60
    bus_notify+0x34/0x50
    device_del+0x269/0x3d0
    pci_remove_bus_device+0x77/0x100
    p2sb_bar+0xae/0x1d0
    ...
    i801_probe+0x423/0x740

Use the release_domain mechanism to fix it. The scalable mode context
entry which is not part of release_domain should be cleared in
release_device().

Fixes: 586081d3f6b1 ("iommu/vt-d: Remove DEFER_DEVICE_DOMAIN_INFO")
Reported-by: Eric Badger <ebadger@purestorage.com>
Closes: https://lore.kernel.org/r/20240113181713.1817855-1-ebadger@purestorage.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.h |  1 +
 drivers/iommu/intel/iommu.c | 31 +++-----------
 drivers/iommu/intel/pasid.c | 83 +++++++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index 487ede039bdd..42fda97fd851 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -318,4 +318,5 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
 				 bool fault_ignore);
 void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
 					  struct device *dev, u32 pasid);
+void intel_pasid_teardown_sm_context(struct device *dev);
 #endif /* __INTEL_PASID_H */
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cc3994efd362..f74d42d3258f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3869,30 +3869,6 @@ static void domain_context_clear(struct device_domain_info *info)
 			       &domain_context_clear_one_cb, info);
 }
 
-static void dmar_remove_one_dev_info(struct device *dev)
-{
-	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	struct dmar_domain *domain = info->domain;
-	struct intel_iommu *iommu = info->iommu;
-	unsigned long flags;
-
-	if (!dev_is_real_dma_subdevice(info->dev)) {
-		if (dev_is_pci(info->dev) && sm_supported(iommu))
-			intel_pasid_tear_down_entry(iommu, info->dev,
-					IOMMU_NO_PASID, false);
-
-		iommu_disable_pci_caps(info);
-		domain_context_clear(info);
-	}
-
-	spin_lock_irqsave(&domain->lock, flags);
-	list_del(&info->link);
-	spin_unlock_irqrestore(&domain->lock, flags);
-
-	domain_detach_iommu(domain, iommu);
-	info->domain = NULL;
-}
-
 /*
  * Clear the page table pointer in context or pasid table entries so that
  * all DMA requests without PASID from the device are blocked. If the page
@@ -4431,7 +4407,11 @@ static void intel_iommu_release_device(struct device *dev)
 	mutex_lock(&iommu->iopf_lock);
 	device_rbtree_remove(info);
 	mutex_unlock(&iommu->iopf_lock);
-	dmar_remove_one_dev_info(dev);
+
+	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev) &&
+	    !context_copied(iommu, info->bus, info->devfn))
+		intel_pasid_teardown_sm_context(dev);
+
 	intel_pasid_free_table(dev);
 	intel_iommu_debugfs_remove_dev(info);
 	kfree(info);
@@ -4922,6 +4902,7 @@ static const struct iommu_dirty_ops intel_dirty_ops = {
 
 const struct iommu_ops intel_iommu_ops = {
 	.blocked_domain		= &blocking_domain,
+	.release_domain		= &blocking_domain,
 	.capable		= intel_iommu_capable,
 	.hw_info		= intel_iommu_hw_info,
 	.domain_alloc		= intel_iommu_domain_alloc,
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 108158e2b907..52068cf52fe2 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -667,3 +667,86 @@ int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device *dev,
 
 	return 0;
 }
+
+/*
+ * Interfaces to setup or teardown a pasid table to the scalable-mode
+ * context table entry:
+ */
+
+/*
+ * Cache invalidation for changes to a scalable-mode context table
+ * entry.
+ *
+ * Section 6.5.3.3 of the VT-d spec:
+ * - Device-selective context-cache invalidation;
+ * - Domain-selective PASID-cache invalidation to affected domains
+ *   (can be skipped if all PASID entries were not-present);
+ * - Domain-selective IOTLB invalidation to affected domains;
+ * - Global Device-TLB invalidation to affected functions.
+ *
+ * Note that RWBF (Required Write-Buffer Flushing) capability has
+ * been deprecated for scable mode. Section 11.4.2 of the VT-d spec:
+ *
+ * HRWBF: Hardware implementations reporting Scalable Mode Translation
+ * Support (SMTS) as Set also report this field as Clear.
+ */
+static void sm_context_flush_caches(struct device *dev)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+
+	iommu->flush.flush_context(iommu, 0, PCI_DEVID(info->bus, info->devfn),
+				   DMA_CCMD_MASK_NOBIT, DMA_CCMD_DEVICE_INVL);
+	qi_flush_pasid_cache(iommu, 0, QI_PC_GLOBAL, 0);
+	iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
+	devtlb_invalidation_with_pasid(iommu, dev, IOMMU_NO_PASID);
+}
+
+static void context_entry_teardown_pasid_table(struct intel_iommu *iommu,
+					       struct context_entry *context)
+{
+	context_clear_entry(context);
+	if (!ecap_coherent(iommu->ecap))
+		clflush_cache_range(context, sizeof(*context));
+}
+
+static void device_pasid_table_teardown(struct device *dev, u8 bus, u8 devfn)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+	struct context_entry *context;
+
+	spin_lock(&iommu->lock);
+	context = iommu_context_addr(iommu, bus, devfn, false);
+	if (!context) {
+		spin_unlock(&iommu->lock);
+		return;
+	}
+
+	context_entry_teardown_pasid_table(iommu, context);
+	spin_unlock(&iommu->lock);
+
+	sm_context_flush_caches(dev);
+}
+
+static int pci_pasid_table_teardown(struct pci_dev *pdev, u16 alias, void *data)
+{
+	struct device *dev = data;
+
+	if (dev == &pdev->dev)
+		device_pasid_table_teardown(dev, PCI_BUS_NUM(alias), alias & 0xff);
+
+	return 0;
+}
+
+void intel_pasid_teardown_sm_context(struct device *dev)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+
+	if (!dev_is_pci(dev)) {
+		device_pasid_table_teardown(dev, info->bus, info->devfn);
+		return;
+	}
+
+	pci_for_each_dma_alias(to_pci_dev(dev), pci_pasid_table_teardown, dev);
+}
-- 
2.34.1


