Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FE87B0800
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjI0PTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbjI0PTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:19:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09632126
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 08:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695827958; x=1727363958;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZpwehE9umF+E2WRJZPjrRmVCii85Hu05XDSIsfB4XV0=;
  b=nq1Jx8Kfy6eRKmoQSkgTOFDmN1RS+Q2ushdmvF4r7QsbGRzMb5//r+c1
   NI43EXXxXALuvyXYLxn1Mg8qhjfTz2GQob9qL8zKNZZui9tA86mkIsAxk
   GiMXZPIv18mSiosyLRg7zMv+kVCJYq2AjKg5c2p5+evJkYVaV+yeaNJNe
   Q/zJ+tGEUnzR9DGyw9u1Rkx14lwK/FtHKeL31ruUZS4CDh9Yyvo2do2qJ
   V8U0SRttOeDyF2G8bKnpjAmSUyq+Fr52BpGLh5oIchSiT7LB7cmmNV+9y
   2ff3NCP4eaCuEQ8e0RxvB+vZBgWmOD/A5ffFtGuYTffEyKvEWXy97z/r6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="362098924"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="362098924"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 08:19:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="819461136"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="819461136"
Received: from cascade.sh.intel.com ([10.239.48.35])
  by fmsmga004.fm.intel.com with ESMTP; 27 Sep 2023 08:19:15 -0700
From:   Jingqi Liu <Jingqi.liu@intel.com>
To:     iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
        Tian Kevin <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, Jingqi Liu <Jingqi.liu@intel.com>
Subject: [PATH v3 3/3] iommu/vt-d: debugfs: Support dumping a specified page table
Date:   Wed, 27 Sep 2023 23:15:36 +0800
Message-Id: <20230927151536.67319-4-Jingqi.liu@intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230927151536.67319-1-Jingqi.liu@intel.com>
References: <20230927151536.67319-1-Jingqi.liu@intel.com>
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
   /sys/kernel/debug/iommu/intel/0000:00:1f.0/0/domain_translation_struct

2) Dump the page table of device "0000:00:0a.0" with PASID "1" that
   supports scalable mode.
   $ sudo cat
   /sys/kernel/debug/iommu/intel/0000:00:0a.0/1/domain_translation_struct

Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jingqi Liu <Jingqi.liu@intel.com>
---
 drivers/iommu/intel/debugfs.c | 163 +++++++++++++++++++++++++---------
 1 file changed, 121 insertions(+), 42 deletions(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index 50dea53ba87c..a0e7f2b4d4d1 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -352,58 +352,137 @@ static void pgtable_walk_level(struct seq_file *m, struct dma_pte *pde,
 	}
 }
 
-static int __show_device_domain_translation(struct device *dev, void *data)
+static int domain_translation_struct_show(struct seq_file *m, void *unused)
 {
-	struct dmar_domain *domain;
-	struct seq_file *m = data;
-	u64 path[6] = { 0 };
+	struct device_domain_info *info;
+	struct show_domain_info *sinfo;
+	bool scalable, found = false;
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+	u16 devfn, bus, seg;
 
-	domain = to_dmar_domain(iommu_get_domain_for_dev(dev));
-	if (!domain)
-		return 0;
+	if (!m || !m->private) {
+		seq_puts(m, "Invalid device or pasid!\n");
+		return -EINVAL;
+	}
 
-	seq_printf(m, "Device %s @0x%llx\n", dev_name(dev),
-		   (u64)virt_to_phys(domain->pgd));
-	seq_puts(m, "IOVA_PFN\t\tPML5E\t\t\tPML4E\t\t\tPDPE\t\t\tPDE\t\t\tPTE\n");
+	sinfo = (struct show_domain_info*)m->private;
+	if (!sinfo->dev ||
+	    !dev_iommu_priv_get(sinfo->dev) ||
+	    (sinfo->pasid == IOMMU_PASID_INVALID)) {
+		seq_puts(m, "Please specify device or pasid!\n");
+		return -ENODEV;
+	}
 
-	pgtable_walk_level(m, domain->pgd, domain->agaw + 2, 0, path);
-	seq_putc(m, '\n');
+	info = dev_iommu_priv_get(sinfo->dev);
+	bus = info->bus;
+	devfn = info->devfn;
+	seg = info->segment;
 
-	/* Don't iterate */
-	return 1;
-}
+	rcu_read_lock();
+	for_each_active_iommu(iommu, drhd) {
+		struct context_entry *context;
+		u64 pgd, path[6] = { 0 };
+		u32 sts, agaw;
 
-static int show_device_domain_translation(struct device *dev, void *data)
-{
-	struct iommu_group *group;
+		if (seg != iommu->segment)
+			continue;
 
-	device_lock(dev);
-	group = iommu_group_get(dev);
-	device_unlock(dev);
-	if (!group)
-		return 0;
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
 
-	/*
-	 * The group->mutex is held across the callback, which will
-	 * block calls to iommu_attach/detach_group/device. Hence,
-	 * the domain of the device will not change during traversal.
-	 *
-	 * All devices in an iommu group share a single domain, hence
-	 * we only dump the domain of the first device. Even though,
-	 * this code still possibly races with the iommu_unmap()
-	 * interface. This could be solved by RCU-freeing the page
-	 * table pages in the iommu_unmap() path.
-	 */
-	iommu_group_for_each_dev(group, data, __show_device_domain_translation);
-	iommu_group_put(group);
+		/*
+		 * The iommu->lock is held across the callback, which will
+		 * block calls to domain_attach/domain_detach. Hence,
+		 * the domain of the device will not change during traversal.
+		 *
+		 * Traversing page table possibly races with the iommu_unmap()
+		 * interface. This could be solved by RCU-freeing the page
+		 * table pages in the iommu_unmap() path.
+		 */
+		spin_lock(&iommu->lock);
 
-	return 0;
-}
+		context = iommu_context_addr(iommu, bus, devfn, 0);
+		if (!context || !context_present(context))
+			goto iommu_unlock;
 
-static int domain_translation_struct_show(struct seq_file *m, void *unused)
-{
-	return bus_for_each_dev(&pci_bus_type, NULL, m,
-				show_device_domain_translation);
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
+			dir_idx = sinfo->pasid >> PASID_PDE_SHIFT;
+			tbl_idx = sinfo->pasid & PASID_PTE_MASK;
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
+				case PASID_ENTRY_PGTT_FL_ONLY:
+					pgd = pasid_tbl_entry->val[2];
+					break;
+				case PASID_ENTRY_PGTT_SL_ONLY:
+				case PASID_ENTRY_PGTT_NESTED:
+					pgd = pasid_tbl_entry->val[0];
+					break;
+				default:
+					goto iommu_unlock;
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
+			seq_printf(m, "with pasid %x @0x%llx\n", sinfo->pasid, pgd);
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
+	}
+	rcu_read_unlock();
+
+	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(domain_translation_struct);
 
-- 
2.21.3

