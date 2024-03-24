Return-Path: <linux-kernel+bounces-113189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C5888822B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41F74B21F23
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7029179651;
	Sun, 24 Mar 2024 22:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AV1fgDND"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25D45B696;
	Sun, 24 Mar 2024 22:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319992; cv=none; b=ST3DdXVNCpOJbEfMW2HG9YUrZCWPD5QsSYIRecuSlis5iamOhCbJ/COg7rXNt1jlq+C3eA0ke6kFBKAKL99P1/ZE6e+briA+yL9MHnxYlJcOJmN+UNWHmxlrvvp/mSLXrnrhSNP5VdptxopGgdCqXMpFIkhisF5xz7FyHlYkorY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319992; c=relaxed/simple;
	bh=I1bDq07OqvrWsJM/pOX7OqiGpg3Lu/to4BRLZ/VJ0z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qe1tMosAxWBaRelbyX6L4Z7L2jQdMZ84st10gt3GXqKOLrWiSKfdinN8VKHr2TNKJRUBMA+h8z7oTEJwDcgIdxexFP2/yhz7ajfC5ijtRJlwTHKMuN0yjmZ5aWOZSWhbH36XGj2Z+277ds9PCFeb35G+EZrc16IuzDDltvADonI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AV1fgDND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB3FC433C7;
	Sun, 24 Mar 2024 22:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319992;
	bh=I1bDq07OqvrWsJM/pOX7OqiGpg3Lu/to4BRLZ/VJ0z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AV1fgDNDezG+E/8BnDPmqava8j2+fFifNBxaDUSYLK2Gt3AXLwtR4lBV0nLlz7BCN
	 daLzzTDtprfx77zw90iOPO25VYlOWVIEbyvCSZ2C8DOd0E8YW0FujB12Ud9hT41cDm
	 aMa4a31iKT6fLyUU2MZ9GKvxQ0NuGbaZKN1tzXCD8cRSt9yxRYydWarVg7btohz/OG
	 6Rg9hcApb0CEJ2K9k3csfu46WKyB+g/oY7g1Gg/VoRuT4Mothhub9Vo5kPzqYY+rFh
	 pOFT8lLg+s2mYHaDMRh/7leXd5rhIJIj7gXWfkE6yZCHM9+QumkfD/QlHiX3IidGyY
	 V6IqJZpEyujew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Eric Badger <ebadger@purestorage.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 298/715] iommu/vt-d: Fix NULL domain on device release
Date: Sun, 24 Mar 2024 18:27:57 -0400
Message-ID: <20240324223455.1342824-299-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Lu Baolu <baolu.lu@linux.intel.com>

[ Upstream commit 81e921fd321614c2ad8ac333b041aae1da7a1c6d ]

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
entry which is not part of release domain should be cleared in
release_device().

Fixes: 586081d3f6b1 ("iommu/vt-d: Remove DEFER_DEVICE_DOMAIN_INFO")
Reported-by: Eric Badger <ebadger@purestorage.com>
Closes: https://lore.kernel.org/r/20240113181713.1817855-1-ebadger@purestorage.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240305013305.204605-3-baolu.lu@linux.intel.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel/iommu.c | 31 ++++--------------
 drivers/iommu/intel/pasid.c | 64 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/pasid.h |  1 +
 3 files changed, 71 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 31b5d852ba732..5dba58f322f03 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3874,30 +3874,6 @@ static void domain_context_clear(struct device_domain_info *info)
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
@@ -4436,7 +4412,11 @@ static void intel_iommu_release_device(struct device *dev)
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
@@ -4942,6 +4922,7 @@ static const struct iommu_dirty_ops intel_dirty_ops = {
 
 const struct iommu_ops intel_iommu_ops = {
 	.blocked_domain		= &blocking_domain,
+	.release_domain		= &blocking_domain,
 	.capable		= intel_iommu_capable,
 	.hw_info		= intel_iommu_hw_info,
 	.domain_alloc		= intel_iommu_domain_alloc,
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 746c7abe2237d..a51e895d9a178 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -670,3 +670,67 @@ int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device *dev,
 
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
diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index 487ede039bdde..42fda97fd8516 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -318,4 +318,5 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
 				 bool fault_ignore);
 void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
 					  struct device *dev, u32 pasid);
+void intel_pasid_teardown_sm_context(struct device *dev);
 #endif /* __INTEL_PASID_H */
-- 
2.43.0


