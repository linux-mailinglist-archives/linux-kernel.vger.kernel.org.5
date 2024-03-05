Return-Path: <linux-kernel+bounces-91502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 009F5871266
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2502F1C21DDC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A1F17C70;
	Tue,  5 Mar 2024 01:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gvg0v7IS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29726182AE
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 01:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709602765; cv=none; b=CewnJNvGo5XydY9kpqn23aJzijml01Oct28yi10RTdd/xAzcbWiuT63XStsrtHgUl/dLSSyFt9dvoazReFwUUPRxfHO+UNOEsutbdxLll8JfWOW7Zlh83WmnJWTR/DTq+CknCAmoPadkkgiMF2b0JxtYSxemOya1nRs82TOekew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709602765; c=relaxed/simple;
	bh=hCpSe1wQQmn4a4MF4QIzbrjshK2ebiCRBYaAnxsrxc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZMkViB0n2spG65U0SMgZ+9MMcAJVkDxI/mX0dnqQvN6yxYwOX/ujhtgtRDgVJqNE3nxJNFFLIfhqmt656qoQLjbI64LQpfTzOz6bNHo7ZQ3q8LTKe5FS7hnPzvZ6Ttf0ALEjGMEZMUVK2GhNVEKbx7wG3X3urmzLhZT2rkX/bQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gvg0v7IS; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709602762; x=1741138762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hCpSe1wQQmn4a4MF4QIzbrjshK2ebiCRBYaAnxsrxc4=;
  b=Gvg0v7ISX6bauHNGYknfOtwnnkGz65VvcQ34IKhZI5KgNrrYcnvK0drT
   FRUCh+Rt7g2vp+4DjQCBuSHpfNrNzdN1hdyL9W+n0pnvX4v1afo6C8Mp7
   oa97HcpWrLpZDBrOr2w6dbd0nBixgSeXEuQe+xraW6iV916T0/5RQNZgH
   4E+lwzVMePwJgwsM29ihUUcg3A3jXheRC7fP6c5NLgZM7VShFBmTc7MyO
   FDaeH/eeJYUjKZhx2x5NIkIAeZVleAnlRnuMEMIirxEfRHV02mz5/sYuT
   GwiWpA+FRP4gZUFRXrQKxTrIHbEZzsF8t1TEESTbtA5UbpI9POuZnwnW3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4286704"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4286704"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 17:39:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="13865453"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 04 Mar 2024 17:39:19 -0800
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
Subject: [PATCH v3 2/5] iommu/vt-d: Fix NULL domain on device release
Date: Tue,  5 Mar 2024 09:33:02 +0800
Message-Id: <20240305013305.204605-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305013305.204605-1-baolu.lu@linux.intel.com>
References: <20240305013305.204605-1-baolu.lu@linux.intel.com>
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
 drivers/iommu/intel/iommu.c | 31 ++++--------------
 drivers/iommu/intel/pasid.c | 64 +++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 25 deletions(-)

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
index 108158e2b907..9261ea986dbf 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -667,3 +667,67 @@ int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device *dev,
 
 	return 0;
 }
+
+/*
+ * Interfaces to setup or teardown a pasid table to the scalable-mode
+ * context table entry:
+ */
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
+	context_clear_entry(context);
+	__iommu_flush_cache(iommu, context, sizeof(*context));
+	spin_unlock(&iommu->lock);
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
+	 * The iommu has been parked in the blocking state. All domains have
+	 * been detached from the device or PASID. The PASID and IOTLB caches
+	 * have been invalidated during the domain detach path.
+	 */
+	iommu->flush.flush_context(iommu, 0, PCI_DEVID(bus, devfn),
+				   DMA_CCMD_MASK_NOBIT, DMA_CCMD_DEVICE_INVL);
+	devtlb_invalidation_with_pasid(iommu, dev, IOMMU_NO_PASID);
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


