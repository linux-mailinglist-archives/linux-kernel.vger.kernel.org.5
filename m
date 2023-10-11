Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B55D7C4D79
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345722AbjJKIpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345613AbjJKIox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:44:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5755798
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697013890; x=1728549890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KDze0gEBy2skdPru+95cqJLcOzr2zcPTIx0NJLUkVVU=;
  b=EJjbxEw+E6P5TxRy7GWY3v2W5wDyheSe71tffc6B1n2B0BMOiBT1zhYQ
   ZgXF4cCnRCzO32ReZH5nl/iRBoqYMfsqTy8/A72K5bjc/61nP+yb1L280
   TjDxIQpedwaDxYt6O4pC7jZqSqgrmg+ItiUjLBVt/uDcFqKXzz419361Y
   XTm2GUm4hQUYaEXkJ2b8RUn7MtsJQCqrDGVXu+HEYl8Rs76uYtzn64NkI
   EIPDKSaqUeARF+A3McJ3+FhXo1SKBJWKDMOAzEktzINniIC+IuFjE1TD/
   2Jnyt0l4SQ5EmS9GmZMsj6illxZcFitlxh8YSmXKCTDa8LrGD1CasmVJm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="383474580"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="383474580"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 01:44:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="877587379"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="877587379"
Received: from cascade.sh.intel.com ([10.239.48.35])
  by orsmga004.jf.intel.com with ESMTP; 11 Oct 2023 01:44:47 -0700
From:   Jingqi Liu <Jingqi.liu@intel.com>
To:     iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
        Tian Kevin <kevin.tian@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, Jingqi Liu <Jingqi.liu@intel.com>
Subject: [PATH v4 2/3] iommu/vt-d: debugfs: Create/remove debugfs file per {device, pasid}
Date:   Wed, 11 Oct 2023 16:39:14 +0800
Message-Id: <20231011083915.36706-3-Jingqi.liu@intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20231011083915.36706-1-Jingqi.liu@intel.com>
References: <20231011083915.36706-1-Jingqi.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a debugfs directory per pair of {device, pasid} if the mappings of
its page table are created and destroyed by the iommu_map/unmap()
interfaces. i.e. /sys/kernel/debug/iommu/intel/<device source id>/<pasid>.
Create a debugfs file in the directory for users to dump the page
table corresponding to {device, pasid}. e.g.
/sys/kernel/debug/iommu/intel/0000:00:02.0/1/domain_translation_struct.
For the default domain without pasid, it creates a debugfs file in the
debugfs device directory for users to dump its page table. e.g.
/sys/kernel/debug/iommu/intel/0000:00:02.0/domain_translation_struct.

When attaching device without pasid, create a debugfs file in the
debugfs device directory for users to dump the page table of default
domain. When attaching a domain to a pasid of device, create a debugfs
file in the pasid debugfs directory for users to dump the page table
of the specified pasid.

When detaching without pasid, remove the debugfs file in the device
debugfs directory. When detaching with pasid, remove the specified
pasid debugfs directory and file. Remove the debugfs device directory
of the device when releasing a device.
e.g. /sys/kernel/debug/iommu/intel/0000:00:01.0

Signed-off-by: Jingqi Liu <Jingqi.liu@intel.com>
---
 drivers/iommu/intel/debugfs.c | 105 ++++++++++++++++++++++++++++++++--
 drivers/iommu/intel/iommu.c   |  11 ++++
 drivers/iommu/intel/iommu.h   |  18 ++++++
 3 files changed, 129 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index e2a3c37943a0..30bc1e06abbc 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -111,6 +111,8 @@ static const struct iommu_regset iommu_regs_64[] = {
 	IOMMU_REGSET_ENTRY(VCRSP),
 };
 
+static struct dentry *intel_iommu_debug;
+
 static int iommu_regset_show(struct seq_file *m, void *unused)
 {
 	struct dmar_drhd_unit *drhd;
@@ -673,16 +675,12 @@ static const struct file_operations dmar_perf_latency_fops = {
 
 void __init intel_iommu_debugfs_init(void)
 {
-	struct dentry *intel_iommu_debug = debugfs_create_dir("intel",
-						iommu_debugfs_dir);
+	intel_iommu_debug = debugfs_create_dir("intel", iommu_debugfs_dir);
 
 	debugfs_create_file("iommu_regset", 0444, intel_iommu_debug, NULL,
 			    &iommu_regset_fops);
 	debugfs_create_file("dmar_translation_struct", 0444, intel_iommu_debug,
 			    NULL, &dmar_translation_struct_fops);
-	debugfs_create_file("domain_translation_struct", 0444,
-			    intel_iommu_debug, NULL,
-			    &domain_translation_struct_fops);
 	debugfs_create_file("invalidation_queue", 0444, intel_iommu_debug,
 			    NULL, &invalidation_queue_fops);
 #ifdef CONFIG_IRQ_REMAP
@@ -692,3 +690,100 @@ void __init intel_iommu_debugfs_init(void)
 	debugfs_create_file("dmar_perf_latency", 0644, intel_iommu_debug,
 			    NULL, &dmar_perf_latency_fops);
 }
+
+/* Create a debugfs directory for each device. */
+void intel_iommu_debugfs_create_dev(struct device *dev)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+
+	info->debugfs_dentry = debugfs_create_dir(dev_name(dev),
+						  intel_iommu_debug);
+}
+
+/* Remove the device debugfs directory. */
+void intel_iommu_debugfs_remove_dev(struct device *dev)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+
+	if (!info || IS_ERR_OR_NULL(info->debugfs_dentry))
+		return;
+
+	debugfs_remove_recursive(info->debugfs_dentry);
+}
+
+/*
+ * Create a debugfs directory per pair of {device, pasid},
+ * then create the corresponding debugfs file in this directory
+ * for users to dump its page table. e.g.
+ * /sys/kernel/debug/iommu/intel/0000:00:01.0/1/domain_translation_struct
+ * For the default domain of the device, create a debugfs file in the
+ * debugfs device directory for users to dump its page table. e.g.
+ * /sys/kernel/debug/iommu/intel/0000:00:01.0/domain_translation_struct
+ */
+void intel_iommu_debugfs_create_dev_pasid(struct iommu_domain *domain,
+					  struct device_domain_info *info,
+					  struct dev_pasid_info *dev_pasid)
+{
+	struct dentry *parent;
+	void *data;
+
+	if (!info || IS_ERR_OR_NULL(info->debugfs_dentry))
+		return;
+
+	/*
+	 * The debugfs only dumps the page tables whose mappings are created
+	 * and destroyed by the iommu_map/unmap() interfaces. Check the
+	 * mapping type of the domain before creating debugfs directory.
+	 */
+	if (!domain ||
+	    !(domain->type & __IOMMU_DOMAIN_PAGING))
+		return;
+
+	if (dev_pasid) {
+		char dir_name[10];
+
+		sprintf(dir_name, "%x", dev_pasid->pasid);
+		dev_pasid->debugfs_dentry = debugfs_create_dir(dir_name,
+							info->debugfs_dentry);
+		if (IS_ERR(dev_pasid->debugfs_dentry))
+			return;
+
+		data = dev_pasid;
+		parent = dev_pasid->debugfs_dentry;
+	} else {
+		data = info;
+		parent = info->debugfs_dentry;
+	}
+
+	debugfs_create_file("domain_translation_struct", 0444, parent,
+			    data, &domain_translation_struct_fops);
+}
+
+/*
+ * Remove the corresponding debugfs directory and file.
+ * If a pair {device, pasid} is specified, remove the debugfs
+ * directory of the specified pasid.
+ * If they are not specified, remove the debugfs file of the
+ * default domain.
+ */
+void intel_iommu_debugfs_remove_dev_pasid(struct device *dev,
+					  struct dev_pasid_info *dev_pasid)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+
+	if (!info || IS_ERR_OR_NULL(info->debugfs_dentry))
+		return;
+
+	if (dev_pasid)
+		debugfs_remove_recursive(dev_pasid->debugfs_dentry);
+	else {
+		struct dentry *dentry;
+
+		dentry = debugfs_lookup("domain_translation_struct",
+					info->debugfs_dentry);
+		if (dentry) {
+			debugfs_remove(dentry);
+			dput(dentry);
+		}
+	}
+}
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index dd8ff358867d..aef58217f253 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2488,6 +2488,8 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 
 	iommu_enable_pci_caps(info);
 
+	intel_iommu_debugfs_create_dev_pasid(&domain->domain, info, NULL);
+
 	return 0;
 }
 
@@ -3997,6 +3999,8 @@ static void device_block_translation(struct device *dev)
 
 	domain_detach_iommu(info->domain, iommu);
 	info->domain = NULL;
+
+	intel_iommu_debugfs_remove_dev_pasid(dev, NULL);
 }
 
 static int md_domain_init(struct dmar_domain *domain, int guest_width)
@@ -4424,6 +4428,8 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 		}
 	}
 
+	intel_iommu_debugfs_create_dev(dev);
+
 	return &iommu->iommu;
 }
 
@@ -4433,6 +4439,7 @@ static void intel_iommu_release_device(struct device *dev)
 
 	dmar_remove_one_dev_info(dev);
 	intel_pasid_free_table(dev);
+	intel_iommu_debugfs_remove_dev(dev);
 	dev_iommu_priv_set(dev, NULL);
 	kfree(info);
 	set_dma_ops(dev, NULL);
@@ -4725,6 +4732,8 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	spin_unlock_irqrestore(&dmar_domain->lock, flags);
 
 	domain_detach_iommu(dmar_domain, iommu);
+
+	intel_iommu_debugfs_remove_dev_pasid(dev, dev_pasid);
 	kfree(dev_pasid);
 out_tear_down:
 	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
@@ -4777,6 +4786,8 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
 	spin_unlock_irqrestore(&dmar_domain->lock, flags);
 
+	intel_iommu_debugfs_create_dev_pasid(domain, info, dev_pasid);
+
 	return 0;
 out_detach_iommu:
 	domain_detach_iommu(dmar_domain, iommu);
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index c18fb699c87a..61113a76e23a 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -716,12 +716,14 @@ struct device_domain_info {
 	struct intel_iommu *iommu; /* IOMMU used by this device */
 	struct dmar_domain *domain; /* pointer to domain */
 	struct pasid_table *pasid_table; /* pasid table */
+	struct dentry *debugfs_dentry; /* pointer to device directory dentry */
 };
 
 struct dev_pasid_info {
 	struct list_head link_domain;	/* link to domain siblings */
 	struct device *dev;
 	ioasid_t pasid;
+	struct dentry *debugfs_dentry; /* pointer to pasid directory dentry */
 };
 
 static inline void __iommu_flush_cache(
@@ -883,8 +885,24 @@ static inline void intel_svm_remove_dev_pasid(struct device *dev, ioasid_t pasid
 
 #ifdef CONFIG_INTEL_IOMMU_DEBUGFS
 void intel_iommu_debugfs_init(void);
+void intel_iommu_debugfs_create_dev(struct device *dev);
+void intel_iommu_debugfs_remove_dev(struct device *dev);
+void intel_iommu_debugfs_create_dev_pasid(struct iommu_domain *domain,
+					  struct device_domain_info *info,
+					  struct dev_pasid_info *dev_pasid);
+void intel_iommu_debugfs_remove_dev_pasid(struct device *dev,
+					  struct dev_pasid_info *dev_pasid);
 #else
 static inline void intel_iommu_debugfs_init(void) {}
+static inline void intel_iommu_debugfs_create_dev(struct device *dev) {}
+static inline void intel_iommu_debugfs_remove_dev(struct device *dev) {}
+static inline
+void intel_iommu_debugfs_create_dev_pasid(struct iommu_domain *domain,
+					  struct device_domain_info *info,
+					  struct dev_pasid_info *dev_pasid){}
+static inline
+void intel_iommu_debugfs_remove_dev_pasid(struct device *dev,
+					  struct dev_pasid_info *dev_pasid){}
 #endif /* CONFIG_INTEL_IOMMU_DEBUGFS */
 
 extern const struct attribute_group *intel_iommu_groups[];
-- 
2.21.3

