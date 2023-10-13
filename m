Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BB47C8765
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbjJMOEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjJMOEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:04:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9F295
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697205847; x=1728741847;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GdoVLgn6xyujFvF9/jEaVemFQ4kZTnFMaRtkIlR8N7U=;
  b=YqzzF/oH2m3N/wyeWAX1lfoi34CVN/LnPukMSZpOYggZqY9aB/vli8G6
   gZHUsej0WX5y9XOU/Km4qMUcujHPPrGhZVdOOMgFgIvs96FjJYjLVxENu
   sO96Lj/FteCD94N3jppBRvNJPbQgl0phAUmSRfUnLtiVeUtVZzJTUCYJ1
   exKOmH4o1Yj4xdWzY8aCRjBk+hZVqs01+t0my/l6vJOXKAhnOwtYAyWTt
   SuWdCUG71uhMnIhYEaHIy98WWWOLUTSAW1xpSAhKrp841tuFweeCezCCr
   IWD85q2EgmnBNswSqQWAcC18hBwZk+mCQQ5TOASW/DwOIYTOTbmSAD1jl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="384049380"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="384049380"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 07:04:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="1086156479"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="1086156479"
Received: from cascade.sh.intel.com ([10.239.48.35])
  by fmsmga005.fm.intel.com with ESMTP; 13 Oct 2023 07:04:04 -0700
From:   Jingqi Liu <Jingqi.liu@intel.com>
To:     iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
        Tian Kevin <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, Jingqi Liu <Jingqi.liu@intel.com>
Subject: [PATH v5 3/3] iommu/vt-d: debugfs: Support dumping a specified page table
Date:   Fri, 13 Oct 2023 21:58:11 +0800
Message-Id: <20231013135811.73953-4-Jingqi.liu@intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20231013135811.73953-1-Jingqi.liu@intel.com>
References: <20231013135811.73953-1-Jingqi.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original debugfs only dumps all page tables without pasid. With
pasid supported, the page table with pasid also needs to be dumped.

This patch supports dumping a specified page table in legacy mode or
scalable mode with or without a specified pasid.

For legacy mode, according to bus number and DEVFN, traverse the root
table and context table to get the pointer of page table in the
context table entry, then dump the specified page table.

For scalable mode, according to bus number, DEVFN and pasid, traverse
the root table, context table, pasid directory and pasid table to get
the pointer of page table in the pasid table entry, then dump the
specified page table..

Examples are as follows:
1) Dump the page table of device "0000:00:1f.0" that only supports
   legacy mode.
   $ sudo cat
   /sys/kernel/debug/iommu/intel/0000:00:1f.0/domain_translation_struct

2) Dump the page table of device "0000:00:0a.0" with PASID "1" that
   supports scalable mode.
   $ sudo cat
   /sys/kernel/debug/iommu/intel/0000:00:0a.0/1/domain_translation_struct

Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jingqi Liu <Jingqi.liu@intel.com>
---
 drivers/iommu/intel/debugfs.c | 154 ++++++++++++++++++++++++++--------
 1 file changed, 120 insertions(+), 34 deletions(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index 8a18a7be5215..239136727ac4 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -347,58 +347,141 @@ static void pgtable_walk_level(struct seq_file *m, struct dma_pte *pde,
 	}
 }
 
-static int __show_device_domain_translation(struct device *dev, void *data)
+static int domain_translation_struct_show(struct seq_file *m,
+					  struct device_domain_info *info,
+					  ioasid_t pasid)
 {
-	struct dmar_domain *domain;
-	struct seq_file *m = data;
-	u64 path[6] = { 0 };
-
-	domain = to_dmar_domain(iommu_get_domain_for_dev(dev));
-	if (!domain)
-		return 0;
+	bool scalable, found = false;
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+	u16 devfn, bus, seg;
 
-	seq_printf(m, "Device %s @0x%llx\n", dev_name(dev),
-		   (u64)virt_to_phys(domain->pgd));
-	seq_puts(m, "IOVA_PFN\t\tPML5E\t\t\tPML4E\t\t\tPDPE\t\t\tPDE\t\t\tPTE\n");
+	bus = info->bus;
+	devfn = info->devfn;
+	seg = info->segment;
 
-	pgtable_walk_level(m, domain->pgd, domain->agaw + 2, 0, path);
-	seq_putc(m, '\n');
+	rcu_read_lock();
+	for_each_active_iommu(iommu, drhd) {
+		struct context_entry *context;
+		u64 pgd, path[6] = { 0 };
+		u32 sts, agaw;
 
-	/* Don't iterate */
-	return 1;
-}
+		if (seg != iommu->segment)
+			continue;
 
-static int show_device_domain_translation(struct device *dev, void *data)
-{
-	struct iommu_group *group;
+		sts = dmar_readl(iommu->reg + DMAR_GSTS_REG);
+		if (!(sts & DMA_GSTS_TES)) {
+			seq_printf(m, "DMA Remapping is not enabled on %s\n",
+				   iommu->name);
+			continue;
+		}
+		if (dmar_readq(iommu->reg + DMAR_RTADDR_REG) & DMA_RTADDR_SMT)
+			scalable = true;
+		else
+			scalable = false;
 
-	group = iommu_group_get(dev);
-	if (group) {
 		/*
-		 * The group->mutex is held across the callback, which will
-		 * block calls to iommu_attach/detach_group/device. Hence,
+		 * The iommu->lock is held across the callback, which will
+		 * block calls to domain_attach/domain_detach. Hence,
 		 * the domain of the device will not change during traversal.
 		 *
-		 * All devices in an iommu group share a single domain, hence
-		 * we only dump the domain of the first device. Even though,
-		 * this code still possibly races with the iommu_unmap()
+		 * Traversing page table possibly races with the iommu_unmap()
 		 * interface. This could be solved by RCU-freeing the page
 		 * table pages in the iommu_unmap() path.
 		 */
-		iommu_group_for_each_dev(group, data,
-					 __show_device_domain_translation);
-		iommu_group_put(group);
+		spin_lock(&iommu->lock);
+
+		context = iommu_context_addr(iommu, bus, devfn, 0);
+		if (!context || !context_present(context))
+			goto iommu_unlock;
+
+		if (scalable) {	/* scalable mode */
+			struct pasid_dir_entry *dir_tbl, *dir_entry;
+			struct pasid_entry *pasid_tbl, *pasid_tbl_entry;
+			u16 pasid_dir_size, dir_idx, tbl_idx, pgtt;
+			u64 pasid_dir_ptr;
+
+			pasid_dir_ptr = context->lo & VTD_PAGE_MASK;
+			pasid_dir_size = get_pasid_dir_size(context);
+
+			/* Dump specified device domain mappings with PASID. */
+			dir_idx = pasid >> PASID_PDE_SHIFT;
+			tbl_idx = pasid & PASID_PTE_MASK;
+
+			dir_tbl = phys_to_virt(pasid_dir_ptr);
+			dir_entry = &dir_tbl[dir_idx];
+
+			pasid_tbl = get_pasid_table_from_pde(dir_entry);
+			if (!pasid_tbl)
+				goto iommu_unlock;
+
+			pasid_tbl_entry = &pasid_tbl[tbl_idx];
+			if (!pasid_pte_is_present(pasid_tbl_entry))
+				goto iommu_unlock;
+
+			/*
+			 * According to PASID Granular Translation Type(PGTT),
+			 * get the page table pointer.
+			 */
+			pgtt = (u16)(pasid_tbl_entry->val[0] & GENMASK_ULL(8, 6)) >> 6;
+			agaw = (u8)(pasid_tbl_entry->val[0] & GENMASK_ULL(4, 2)) >> 2;
+
+			switch (pgtt) {
+			case PASID_ENTRY_PGTT_FL_ONLY:
+				pgd = pasid_tbl_entry->val[2];
+				break;
+			case PASID_ENTRY_PGTT_SL_ONLY:
+			case PASID_ENTRY_PGTT_NESTED:
+				pgd = pasid_tbl_entry->val[0];
+				break;
+			default:
+				goto iommu_unlock;
+			}
+			pgd &= VTD_PAGE_MASK;
+		} else { /* legacy mode */
+			pgd = context->lo & VTD_PAGE_MASK;
+			agaw = context->hi & 7;
+		}
+
+		seq_printf(m, "Device %04x:%02x:%02x.%x ",
+			   iommu->segment, bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
+
+		if (scalable)
+			seq_printf(m, "with pasid %x @0x%llx\n", pasid, pgd);
+		else
+			seq_printf(m, "@0x%llx\n", pgd);
+
+		seq_printf(m, "%-17s\t%-18s\t%-18s\t%-18s\t%-18s\t%-s\n",
+			   "IOVA_PFN", "PML5E", "PML4E", "PDPE", "PDE", "PTE");
+		pgtable_walk_level(m, phys_to_virt(pgd), agaw + 2, 0, path);
+
+		found = true;
+iommu_unlock:
+		spin_unlock(&iommu->lock);
+		if (found)
+			break;
 	}
+	rcu_read_unlock();
 
 	return 0;
 }
 
-static int domain_translation_struct_show(struct seq_file *m, void *unused)
+static int dev_domain_translation_struct_show(struct seq_file *m, void *unused)
 {
-	return bus_for_each_dev(&pci_bus_type, NULL, m,
-				show_device_domain_translation);
+	struct device_domain_info *info = (struct device_domain_info *)m->private;
+
+	return domain_translation_struct_show(m, info, IOMMU_NO_PASID);
 }
-DEFINE_SHOW_ATTRIBUTE(domain_translation_struct);
+DEFINE_SHOW_ATTRIBUTE(dev_domain_translation_struct);
+
+static int pasid_domain_translation_struct_show(struct seq_file *m, void *unused)
+{
+	struct dev_pasid_info *dev_pasid = (struct dev_pasid_info *)m->private;
+	struct device_domain_info *info = dev_iommu_priv_get(dev_pasid->dev);
+
+	return domain_translation_struct_show(m, info, dev_pasid->pasid);
+}
+DEFINE_SHOW_ATTRIBUTE(pasid_domain_translation_struct);
 
 static void invalidation_queue_entry_show(struct seq_file *m,
 					  struct intel_iommu *iommu)
@@ -700,7 +783,7 @@ void intel_iommu_debugfs_create_dev(struct device_domain_info *info)
 	info->debugfs_dentry = debugfs_create_dir(dev_name(info->dev), intel_iommu_debug);
 
 	debugfs_create_file("domain_translation_struct", 0444, info->debugfs_dentry,
-			    NULL, &domain_translation_struct_fops);
+			    info, &dev_domain_translation_struct_fops);
 }
 
 /* Remove the device debugfs directory. */
@@ -726,6 +809,9 @@ void intel_iommu_debugfs_create_dev_pasid(struct dev_pasid_info *dev_pasid)
 
 	sprintf(dir_name, "%x", dev_pasid->pasid);
 	dev_pasid->debugfs_dentry = debugfs_create_dir(dir_name, info->debugfs_dentry);
+
+	debugfs_create_file("domain_translation_struct", 0444, dev_pasid->debugfs_dentry,
+			    dev_pasid, &pasid_domain_translation_struct_fops);
 }
 
 /* Remove the device pasid debugfs directory. */
-- 
2.21.3

