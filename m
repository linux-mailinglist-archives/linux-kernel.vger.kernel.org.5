Return-Path: <linux-kernel+bounces-86483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8676086C614
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A95341C23EC0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE14629E7;
	Thu, 29 Feb 2024 09:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FggeuqGx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6329D6280C
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709200454; cv=none; b=mJuaOV0XSl551Lp10OwHnFdV3/mScnpqemGHaCWkREtTiwb6yR67HssS+Wdpa02rXISbq+rLn1nySWtlfGfHsDxtps1JGIU2onxp/w9X1ru2OZqo33g+Zo5y/ymXKWcZUa/2pMIz037R2kYas3MQ8iwutItOzFxCqifikFJbMKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709200454; c=relaxed/simple;
	bh=1y1kzMNvTw+aD/9+2tRwPci04f7XSrht398+2nU9MLM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r3LnPrRqNhRT+9EaJshiZRMp7wSThOZS5VeQj+bVBdOmFhmbsFmfmf00iNdEKDeCRhzFA0m82yO3b6fy5lY2Nhe7E4ilGUj/aX7rQ1TW79R+G7bmR6ewlCKX90eubl0RPBJD+8Aa6y7Gtx1i4ZiyPRgMsgK2ZdMrkQnKG9XkKpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FggeuqGx; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709200452; x=1740736452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1y1kzMNvTw+aD/9+2tRwPci04f7XSrht398+2nU9MLM=;
  b=FggeuqGxJpuJRllHmXJQ+brfmvjcXcJgCIE94rcF0zDADuY1K5HvB0Yx
   ekw7nlijFSEOVeRKKkuDmgZso5ciw/a1nxEvAKPH/cju/GuPLPWfYt9xN
   3KsJxGohupH1HsU0b4mv/UbmYGPKA9WX9unnuaeKnt0GM7BzQ6//85w9q
   HJyfpBdZ402tAmMWBBn8wnPDuZ4ityK2upDA8APA4Y3ZBhwgBDZhj7NRY
   72pFkdAjlhSQLZt8Tx6TeDbR6NNoDOSLNSNNnGSw/RotsJhgqIe+r7fP5
   +6maXcT+zvw25JkKfj9wv5XXD5FGFiHp1yP1Vf9R8T9YcpYxthxFE+/Fs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="7480776"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7480776"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 01:54:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7695763"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 29 Feb 2024 01:54:10 -0800
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
Subject: [PATCH 1/3] iommu/vt-d: Setup scalable mode context entry in probe path
Date: Thu, 29 Feb 2024 17:48:02 +0800
Message-Id: <20240229094804.121610-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229094804.121610-1-baolu.lu@linux.intel.com>
References: <20240229094804.121610-1-baolu.lu@linux.intel.com>
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
---
 drivers/iommu/intel/pasid.h |   1 +
 drivers/iommu/intel/iommu.c |  12 ++++
 drivers/iommu/intel/pasid.c | 116 ++++++++++++++++++++++++++++++++++++
 3 files changed, 129 insertions(+)

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
index 52068cf52fe2..4ea8f35bd460 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -750,3 +750,119 @@ void intel_pasid_teardown_sm_context(struct device *dev)
 
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
+	/*
+	 * For kdump case, at this point, the device is supposed to finish
+	 * reset at its driver probe stage, so no in-flight DMA will exist,
+	 * and we don't need to worry anymore hereafter.
+	 */
+	if (context_copied(iommu, bus, devfn)) {
+		context_clear_entry(context);
+		if (!ecap_coherent(iommu->ecap))
+			clflush_cache_range(context, sizeof(*context));
+		sm_context_flush_caches(dev);
+		clear_context_copied(iommu, bus, devfn);
+	}
+
+	context_entry_set_pasid_table(context, dev);
+	spin_unlock(&iommu->lock);
+
+	/*
+	 * It's a non-present to present mapping. If hardware doesn't cache
+	 * non-present entry we don't need to flush the caches.
+	 */
+	if (cap_caching_mode(iommu->cap))
+		sm_context_flush_caches(dev);
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


