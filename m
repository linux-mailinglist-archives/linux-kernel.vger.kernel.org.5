Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626CF80440B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 02:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346301AbjLEB04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 20:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbjLEB0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 20:26:49 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D546127
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 17:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701739614; x=1733275614;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GFKeHdIylAj+4b4uIVEJnbm29OkKM9wsrhT6h9/WUk4=;
  b=FiXM6H/6pC823aIk9+mjocYa0KQX9YJezgwZgUFoxPg6ArtAgNTX9t82
   9flPusC2nA2/SdwtPaNKhnMMvORAvY4l40eoHUuIVwvu11O+m4KbGmA1x
   yYa8NUOkIGkjaiCPO0uA5Ysy+CVuslkOhzRkurDrBCJ5t4VEbYg+E7L9f
   uj1o+W2xmx9oNINmOIVRcmX1I2UHBK2aUMFH3ihfzd27CxICxKtEVe/zz
   /kfGJSbt1GuCaYV/dtLJeeRm4dyFQyRtJ3Ov4DqNCd5b3dAbxwDAMqqyE
   PN/HUwtUFpV1un5+uhZLKbFEvheR986Db92x3uu+yKu1YqrYb01KulkiU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="460313362"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="460313362"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 17:26:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="1102276309"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="1102276309"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 04 Dec 2023 17:26:51 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 5/6] iommu/vt-d: Add support for static identity domain
Date:   Tue,  5 Dec 2023 09:22:02 +0800
Message-Id: <20231205012203.244584-6-baolu.lu@linux.intel.com>
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

Add a global static identity domain with guaranteed attach semantics.

Software determines VT-d hardware support for pass-through translation by
inspecting the capability register. If pass-through translation is not
supported, the device is instructed to use DMA domain for its default
domain. While most recent VT-d hardware implementations support pass-
through translation, this capability is only lacking in some early VT-d
implementations.

With the static identity domain in place, the domain field of per-device
iommu driver data can be either a pointer to a DMA translation domain, or
NULL, indicating that the static identity domain is attached. Refine some
code to accommodate this change.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 122 +++++++++++++++++++++++++++++++++---
 drivers/iommu/intel/svm.c   |   2 +-
 2 files changed, 116 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7022cc183120..3c747d19495e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1282,7 +1282,8 @@ static void iommu_enable_pci_caps(struct device_domain_info *info)
 	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
 	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
 		info->ats_enabled = 1;
-		domain_update_iotlb(info->domain);
+		if (info->domain)
+			domain_update_iotlb(info->domain);
 	}
 }
 
@@ -1298,7 +1299,8 @@ static void iommu_disable_pci_caps(struct device_domain_info *info)
 	if (info->ats_enabled) {
 		pci_disable_ats(pdev);
 		info->ats_enabled = 0;
-		domain_update_iotlb(info->domain);
+		if (info->domain)
+			domain_update_iotlb(info->domain);
 	}
 
 	if (info->pasid_enabled) {
@@ -1549,8 +1551,7 @@ static int iommu_init_domains(struct intel_iommu *iommu)
 	 * second-level or nested translation. We reserve a domain id for
 	 * this purpose.
 	 */
-	if (sm_supported(iommu))
-		set_bit(FLPT_DEFAULT_DID, iommu->domain_ids);
+	set_bit(FLPT_DEFAULT_DID, iommu->domain_ids);
 
 	return 0;
 }
@@ -3614,6 +3615,9 @@ static void dmar_remove_one_dev_info(struct device *dev)
 		domain_context_clear(info);
 	}
 
+	if (!domain)
+		return;
+
 	spin_lock_irqsave(&domain->lock, flags);
 	list_del(&info->link);
 	spin_unlock_irqrestore(&domain->lock, flags);
@@ -3822,11 +3826,9 @@ int prepare_domain_attach_device(struct iommu_domain *domain,
 static int intel_iommu_attach_device(struct iommu_domain *domain,
 				     struct device *dev)
 {
-	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	int ret;
 
-	if (info->domain)
-		device_block_translation(dev);
+	device_block_translation(dev);
 
 	ret = prepare_domain_attach_device(domain, dev);
 	if (ret)
@@ -4431,6 +4433,9 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 		goto out_tear_down;
 	}
 
+	if (domain->type == IOMMU_DOMAIN_IDENTITY)
+		goto out_tear_down;
+
 	dmar_domain = to_dmar_domain(domain);
 	spin_lock_irqsave(&dmar_domain->lock, flags);
 	list_for_each_entry(curr, &dmar_domain->dev_pasids, link_domain) {
@@ -4605,8 +4610,111 @@ static const struct iommu_dirty_ops intel_dirty_ops = {
 	.read_and_clear_dirty = intel_iommu_read_and_clear_dirty,
 };
 
+static int context_setup_pass_through(struct device *dev, u8 bus, u8 devfn)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+	struct context_entry *context;
+
+	spin_lock(&iommu->lock);
+	context = iommu_context_addr(iommu, bus, devfn, 1);
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
+	copied_context_tear_down(iommu, context, bus, devfn);
+	context_clear_entry(context);
+	context_set_domain_id(context, FLPT_DEFAULT_DID);
+
+	/*
+	 * In pass through mode, AW must be programmed to indicate the largest
+	 * AGAW value supported by hardware. And ASR is ignored by hardware.
+	 */
+	context_set_address_width(context, iommu->msagaw);
+	context_set_translation_type(context, CONTEXT_TT_PASS_THROUGH);
+	context_set_fault_enable(context);
+	context_set_present(context);
+	if (!ecap_coherent(iommu->ecap))
+		clflush_cache_range(context, sizeof(*context));
+	context_present_cache_flush(iommu, FLPT_DEFAULT_DID, bus, devfn);
+	spin_unlock(&iommu->lock);
+
+	return 0;
+}
+
+static int context_setup_pass_through_cb(struct pci_dev *pdev, u16 alias, void *data)
+{
+	struct device *dev = data;
+
+	if (dev != &pdev->dev)
+		return 0;
+
+	return context_setup_pass_through(dev, PCI_BUS_NUM(alias), alias & 0xff);
+}
+
+static int device_setup_pass_through(struct device *dev)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+
+	if (!dev_is_pci(dev))
+		return context_setup_pass_through(dev, info->bus, info->devfn);
+
+	return pci_for_each_dma_alias(to_pci_dev(dev),
+				      context_setup_pass_through_cb, dev);
+}
+
+static int identity_domain_attach_dev(struct iommu_domain *domain,
+				      struct device *dev)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+	int ret;
+
+	device_block_translation(dev);
+
+	if (dev_is_real_dma_subdevice(dev))
+		return 0;
+
+	if (sm_supported(iommu)) {
+		ret = intel_pasid_setup_pass_through(iommu, dev, IOMMU_NO_PASID);
+		if (!ret)
+			iommu_enable_pci_caps(info);
+	} else {
+		ret = device_setup_pass_through(dev);
+	}
+
+	return ret;
+}
+
+static int identity_domain_set_dev_pasid(struct iommu_domain *domain,
+					 struct device *dev, ioasid_t pasid)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+
+	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
+		return -EOPNOTSUPP;
+
+	return intel_pasid_setup_pass_through(iommu, dev, pasid);
+}
+
+static struct iommu_domain identity_domain = {
+	.type = IOMMU_DOMAIN_IDENTITY,
+	.ops = &(const struct iommu_domain_ops) {
+		.attach_dev	= identity_domain_attach_dev,
+		.set_dev_pasid	= identity_domain_set_dev_pasid,
+	},
+};
+
 const struct iommu_ops intel_iommu_ops = {
 	.blocked_domain		= &blocking_domain,
+	.identity_domain	= &identity_domain,
 	.capable		= intel_iommu_capable,
 	.hw_info		= intel_iommu_hw_info,
 	.domain_alloc		= intel_iommu_domain_alloc,
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 442ff9905ca9..d78beb132f5b 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -493,7 +493,7 @@ void intel_drain_pasid_prq(struct device *dev, u32 pasid)
 	domain = info->domain;
 	pdev = to_pci_dev(dev);
 	sid = PCI_DEVID(info->bus, info->devfn);
-	did = domain_id_iommu(domain, iommu);
+	did = domain ? domain_id_iommu(domain, iommu) : FLPT_DEFAULT_DID;
 	qdep = pci_ats_queue_depth(pdev);
 
 	/*
-- 
2.34.1

