Return-Path: <linux-kernel+bounces-92374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D756F871F2F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07E161C25015
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7A05A4C8;
	Tue,  5 Mar 2024 12:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ns2kMi84"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7E55C8E5
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 12:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641661; cv=none; b=Wt0HSw/HR2wC0+dL77SUDzs7jeyFqrvw6ej4k08OZYbJvzkvzOABrAItJWS+GZ5O54kuEtshAtD9T4gWH3vpYi9p8nq96OmNfj/bI2MAeNFy3SuhYgdnUMDTWXBRxsrfWYmhFA0eRxlKBDLiXOi96yIisDZ0xsIN69+UEdzR61k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641661; c=relaxed/simple;
	bh=WvckCYx3o4P91nUGVJiGEmiOvgJ5nL7dKzsLf3U9+Qw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NX08V2tVFcQTYAFqUlQjKvI0Iak7mfhcexb169T67Btkr4D/FmmYM1zbljFwGRNGhy5Va20t8q9fkNOVreiEAoEvlpBt3tJHpSPAkZLRv/zuIg3Y4SVquPXmDzzFDzDk/n1+7bT7p8R1JpJO6LDBD+7xaTzhCdR5kcBWjj0RA0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ns2kMi84; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709641659; x=1741177659;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WvckCYx3o4P91nUGVJiGEmiOvgJ5nL7dKzsLf3U9+Qw=;
  b=Ns2kMi8461y/bEfVFMcrCk4XHiBW+fwG4PcUkWijLDPsJiTE/QRj5l1o
   kSTRH8rJ9Navo1qz9P8AQDr5sJC6m9ouFVYX86OOzmgvXze5f2Bt3bcsZ
   kr8Ehdn0aeAF36q7d/Rpb1594xackWenWFQcdG+2/5ooN78AKQt1QQOdr
   Kov2r3ZOesEtOvPzfmUrby/GYt80uDYYLG6CGETCLv18eGF2ki6Sw3d3Q
   CPISHbhKbLl/JrcPnx5QyxIOdKM7YxlKsOx3bDJd04M+K9Ke0RbT0l7+K
   34myT/9Z7P22Lnm/dLTMdl6Mz6QgOYnkaBgzC95GBt5nTTDouAwmbZlN9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="21648515"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="21648515"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 04:27:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9330144"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 05 Mar 2024 04:27:38 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Ethan Zhao <haifeng.zhao@linux.intel.com>,
	Eric Badger <ebadger@purestorage.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] iommu/vt-d: Remove scalable mode context entry setup from attach_dev
Date: Tue,  5 Mar 2024 20:21:20 +0800
Message-Id: <20240305122121.211482-8-baolu.lu@linux.intel.com>
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

The scalable mode context entry is now setup in the probe_device path,
eliminating the need to configure it in the attach_dev path. Removes the
redundant code from the attach_dev path to avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240305013305.204605-5-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 156 ++++++++++--------------------------
 1 file changed, 44 insertions(+), 112 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9b96d36b9d2a..d682eb6ad4d2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1850,34 +1850,17 @@ static void domain_exit(struct dmar_domain *domain)
 	kfree(domain);
 }
 
-/*
- * Get the PASID directory size for scalable mode context entry.
- * Value of X in the PDTS field of a scalable mode context entry
- * indicates PASID directory with 2^(X + 7) entries.
- */
-static unsigned long context_get_sm_pds(struct pasid_table *table)
-{
-	unsigned long pds, max_pde;
-
-	max_pde = table->max_pasid >> PASID_PDE_SHIFT;
-	pds = find_first_bit(&max_pde, MAX_NR_PASID_BITS);
-	if (pds < 7)
-		return 0;
-
-	return pds - 7;
-}
-
 static int domain_context_mapping_one(struct dmar_domain *domain,
 				      struct intel_iommu *iommu,
-				      struct pasid_table *table,
 				      u8 bus, u8 devfn)
 {
 	struct device_domain_info *info =
 			domain_lookup_dev_info(domain, iommu, bus, devfn);
 	u16 did = domain_id_iommu(domain, iommu);
 	int translation = CONTEXT_TT_MULTI_LEVEL;
+	struct dma_pte *pgd = domain->pgd;
 	struct context_entry *context;
-	int ret;
+	int agaw, ret;
 
 	if (hw_pass_through && domain_type_is_si(domain))
 		translation = CONTEXT_TT_PASS_THROUGH;
@@ -1920,65 +1903,37 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	}
 
 	context_clear_entry(context);
+	context_set_domain_id(context, did);
 
-	if (sm_supported(iommu)) {
-		unsigned long pds;
-
-		/* Setup the PASID DIR pointer: */
-		pds = context_get_sm_pds(table);
-		context->lo = (u64)virt_to_phys(table->table) |
-				context_pdts(pds);
-
-		/* Setup the RID_PASID field: */
-		context_set_sm_rid2pasid(context, IOMMU_NO_PASID);
-
+	if (translation != CONTEXT_TT_PASS_THROUGH) {
 		/*
-		 * Setup the Device-TLB enable bit and Page request
-		 * Enable bit:
+		 * Skip top levels of page tables for iommu which has
+		 * less agaw than default. Unnecessary for PT mode.
 		 */
+		for (agaw = domain->agaw; agaw > iommu->agaw; agaw--) {
+			ret = -ENOMEM;
+			pgd = phys_to_virt(dma_pte_addr(pgd));
+			if (!dma_pte_present(pgd))
+				goto out_unlock;
+		}
+
 		if (info && info->ats_supported)
-			context_set_sm_dte(context);
-		if (info && info->pri_supported)
-			context_set_sm_pre(context);
-		if (info && info->pasid_supported)
-			context_set_pasid(context);
+			translation = CONTEXT_TT_DEV_IOTLB;
+		else
+			translation = CONTEXT_TT_MULTI_LEVEL;
+
+		context_set_address_root(context, virt_to_phys(pgd));
+		context_set_address_width(context, agaw);
 	} else {
-		struct dma_pte *pgd = domain->pgd;
-		int agaw;
-
-		context_set_domain_id(context, did);
-
-		if (translation != CONTEXT_TT_PASS_THROUGH) {
-			/*
-			 * Skip top levels of page tables for iommu which has
-			 * less agaw than default. Unnecessary for PT mode.
-			 */
-			for (agaw = domain->agaw; agaw > iommu->agaw; agaw--) {
-				ret = -ENOMEM;
-				pgd = phys_to_virt(dma_pte_addr(pgd));
-				if (!dma_pte_present(pgd))
-					goto out_unlock;
-			}
-
-			if (info && info->ats_supported)
-				translation = CONTEXT_TT_DEV_IOTLB;
-			else
-				translation = CONTEXT_TT_MULTI_LEVEL;
-
-			context_set_address_root(context, virt_to_phys(pgd));
-			context_set_address_width(context, agaw);
-		} else {
-			/*
-			 * In pass through mode, AW must be programmed to
-			 * indicate the largest AGAW value supported by
-			 * hardware. And ASR is ignored by hardware.
-			 */
-			context_set_address_width(context, iommu->msagaw);
-		}
-
-		context_set_translation_type(context, translation);
+		/*
+		 * In pass through mode, AW must be programmed to
+		 * indicate the largest AGAW value supported by
+		 * hardware. And ASR is ignored by hardware.
+		 */
+		context_set_address_width(context, iommu->msagaw);
 	}
 
+	context_set_translation_type(context, translation);
 	context_set_fault_enable(context);
 	context_set_present(context);
 	if (!ecap_coherent(iommu->ecap))
@@ -2008,43 +1963,29 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	return ret;
 }
 
-struct domain_context_mapping_data {
-	struct dmar_domain *domain;
-	struct intel_iommu *iommu;
-	struct pasid_table *table;
-};
-
 static int domain_context_mapping_cb(struct pci_dev *pdev,
 				     u16 alias, void *opaque)
 {
-	struct domain_context_mapping_data *data = opaque;
+	struct device_domain_info *info = dev_iommu_priv_get(&pdev->dev);
+	struct intel_iommu *iommu = info->iommu;
+	struct dmar_domain *domain = opaque;
 
-	return domain_context_mapping_one(data->domain, data->iommu,
-					  data->table, PCI_BUS_NUM(alias),
-					  alias & 0xff);
+	return domain_context_mapping_one(domain, iommu,
+					  PCI_BUS_NUM(alias), alias & 0xff);
 }
 
 static int
 domain_context_mapping(struct dmar_domain *domain, struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	struct domain_context_mapping_data data;
 	struct intel_iommu *iommu = info->iommu;
 	u8 bus = info->bus, devfn = info->devfn;
-	struct pasid_table *table;
-
-	table = intel_pasid_get_table(dev);
 
 	if (!dev_is_pci(dev))
-		return domain_context_mapping_one(domain, iommu, table,
-						  bus, devfn);
-
-	data.domain = domain;
-	data.iommu = iommu;
-	data.table = table;
+		return domain_context_mapping_one(domain, iommu, bus, devfn);
 
 	return pci_for_each_dma_alias(to_pci_dev(dev),
-				      &domain_context_mapping_cb, &data);
+				      domain_context_mapping_cb, domain);
 }
 
 /* Returns a number of VTD pages, but aligned to MM page size */
@@ -2404,28 +2345,19 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 	list_add(&info->link, &domain->devices);
 	spin_unlock_irqrestore(&domain->lock, flags);
 
-	/* PASID table is mandatory for a PCI device in scalable mode. */
-	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
-		/* Setup the PASID entry for requests without PASID: */
-		if (hw_pass_through && domain_type_is_si(domain))
-			ret = intel_pasid_setup_pass_through(iommu,
-					dev, IOMMU_NO_PASID);
-		else if (domain->use_first_level)
-			ret = domain_setup_first_level(iommu, domain, dev,
-					IOMMU_NO_PASID);
-		else
-			ret = intel_pasid_setup_second_level(iommu, domain,
-					dev, IOMMU_NO_PASID);
-		if (ret) {
-			dev_err(dev, "Setup RID2PASID failed\n");
-			device_block_translation(dev);
-			return ret;
-		}
-	}
+	if (dev_is_real_dma_subdevice(dev))
+		return 0;
+
+	if (!sm_supported(iommu))
+		ret = domain_context_mapping(domain, dev);
+	else if (hw_pass_through && domain_type_is_si(domain))
+		ret = intel_pasid_setup_pass_through(iommu, dev, IOMMU_NO_PASID);
+	else if (domain->use_first_level)
+		ret = domain_setup_first_level(iommu, domain, dev, IOMMU_NO_PASID);
+	else
+		ret = intel_pasid_setup_second_level(iommu, domain, dev, IOMMU_NO_PASID);
 
-	ret = domain_context_mapping(domain, dev);
 	if (ret) {
-		dev_err(dev, "Domain context map failed\n");
 		device_block_translation(dev);
 		return ret;
 	}
-- 
2.34.1


