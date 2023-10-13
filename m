Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8188C7C8768
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjJMOEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjJMOEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:04:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B348595
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697205845; x=1728741845;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=woZcGizHqGMuxdsTWPfygMZnJcyw/9NNvZJu26WAGmo=;
  b=Ge0bXdyo4wjc0gCIGcXbZcDn0XDFMx7uKI8P2P8hKkHNltXJEIAiEerA
   BU/eOB2Y+GkOw5ASglM30SY7iJA9gxGD19/UAd/V5drZYAgr8Y3Udt8Vm
   e63fbTo8zfqVtxYpvYtGrzUqZDzA6ZCmpcDm4rt7ibv2NiKfe2JmPGMpe
   Al6b8IYxGet8uxwCmuq0seue44n36bZXDo8a26dZbn/DUht10222fqb95
   X8FnM2IVuoyewqrNSL1HaeOHzR7pa/9xitibpzoRyvdgWmraWGrabKZo6
   ikqwFzQB9TQ8C2fCGbGccXIIV/iqwo0bgZn2sl44FuhRzzbjr1b1nK++I
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="384049360"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="384049360"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 07:04:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="1086156406"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="1086156406"
Received: from cascade.sh.intel.com ([10.239.48.35])
  by fmsmga005.fm.intel.com with ESMTP; 13 Oct 2023 07:04:01 -0700
From:   Jingqi Liu <Jingqi.liu@intel.com>
To:     iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
        Tian Kevin <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, Jingqi Liu <Jingqi.liu@intel.com>
Subject: [PATH v5 2/3] iommu/vt-d: debugfs: Create/remove debugfs file per {device, pasid}
Date:   Fri, 13 Oct 2023 21:58:10 +0800
Message-Id: <20231013135811.73953-3-Jingqi.liu@intel.com>
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

Add a debugfs directory per pair of {device, pasid} if the mappings of
its page table are created and destroyed by the iommu_map/unmap()
interfaces. i.e. /sys/kernel/debug/iommu/intel/<device source id>/<pasid>.
Create a debugfs file in the directory for users to dump the page
table corresponding to {device, pasid}. e.g.
/sys/kernel/debug/iommu/intel/0000:00:02.0/1/domain_translation_struct.
For the default domain without pasid, it creates a debugfs file in the
debugfs device directory for users to dump its page table. e.g.
/sys/kernel/debug/iommu/intel/0000:00:02.0/domain_translation_struct.

When setting a domain to a PASID of device, create a debugfs file in
the pasid debugfs directory for users to dump the page table of the
specified pasid. Remove the debugfs device directory of the device
when releasing a device. e.g.
/sys/kernel/debug/iommu/intel/0000:00:01.0

Signed-off-by: Jingqi Liu <Jingqi.liu@intel.com>
---
 drivers/iommu/intel/debugfs.c | 53 +++++++++++++++++++++++++++++++----
 drivers/iommu/intel/iommu.c   |  7 +++++
 drivers/iommu/intel/iommu.h   | 14 +++++++++
 3 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index 497c1561d3d2..8a18a7be5215 100644
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
@@ -671,16 +673,12 @@ static const struct file_operations dmar_perf_latency_fops = {
 
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
@@ -690,3 +688,48 @@ void __init intel_iommu_debugfs_init(void)
 	debugfs_create_file("dmar_perf_latency", 0644, intel_iommu_debug,
 			    NULL, &dmar_perf_latency_fops);
 }
+
+/*
+ * Create a debugfs directory for each device, and then create a
+ * debugfs file in this directory for users to dump the page table
+ * of the default domain. e.g.
+ * /sys/kernel/debug/iommu/intel/0000:00:01.0/domain_translation_struct
+ */
+void intel_iommu_debugfs_create_dev(struct device_domain_info *info)
+{
+	info->debugfs_dentry = debugfs_create_dir(dev_name(info->dev), intel_iommu_debug);
+
+	debugfs_create_file("domain_translation_struct", 0444, info->debugfs_dentry,
+			    NULL, &domain_translation_struct_fops);
+}
+
+/* Remove the device debugfs directory. */
+void intel_iommu_debugfs_remove_dev(struct device_domain_info *info)
+{
+	debugfs_remove_recursive(info->debugfs_dentry);
+}
+
+/*
+ * Create a debugfs directory per pair of {device, pasid}, then create the
+ * corresponding debugfs file in this directory for users to dump its page
+ * table. e.g.
+ * /sys/kernel/debug/iommu/intel/0000:00:01.0/1/domain_translation_struct
+ *
+ * The debugfs only dumps the page tables whose mappings are created and
+ * destroyed by the iommu_map/unmap() interfaces. Check the mapping type
+ * of the domain before creating debugfs directory.
+ */
+void intel_iommu_debugfs_create_dev_pasid(struct dev_pasid_info *dev_pasid)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev_pasid->dev);
+	char dir_name[10];
+
+	sprintf(dir_name, "%x", dev_pasid->pasid);
+	dev_pasid->debugfs_dentry = debugfs_create_dir(dir_name, info->debugfs_dentry);
+}
+
+/* Remove the device pasid debugfs directory. */
+void intel_iommu_debugfs_remove_dev_pasid(struct dev_pasid_info *dev_pasid)
+{
+	debugfs_remove_recursive(dev_pasid->debugfs_dentry);
+}
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 3685ba90ec88..d77d60bc418f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4409,6 +4409,8 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 		}
 	}
 
+	intel_iommu_debugfs_create_dev(info);
+
 	return &iommu->iommu;
 }
 
@@ -4418,6 +4420,7 @@ static void intel_iommu_release_device(struct device *dev)
 
 	dmar_remove_one_dev_info(dev);
 	intel_pasid_free_table(dev);
+	intel_iommu_debugfs_remove_dev(info);
 	dev_iommu_priv_set(dev, NULL);
 	kfree(info);
 	set_dma_ops(dev, NULL);
@@ -4710,6 +4713,7 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	spin_unlock_irqrestore(&dmar_domain->lock, flags);
 
 	domain_detach_iommu(dmar_domain, iommu);
+	intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
 	kfree(dev_pasid);
 out_tear_down:
 	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
@@ -4762,6 +4766,9 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
 	spin_unlock_irqrestore(&dmar_domain->lock, flags);
 
+	if (domain->type & __IOMMU_DOMAIN_PAGING)
+		intel_iommu_debugfs_create_dev_pasid(dev_pasid);
+
 	return 0;
 out_detach_iommu:
 	domain_detach_iommu(dmar_domain, iommu);
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 7dac94f62b4e..f9c1dd1ccff8 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -716,12 +716,18 @@ struct device_domain_info {
 	struct intel_iommu *iommu; /* IOMMU used by this device */
 	struct dmar_domain *domain; /* pointer to domain */
 	struct pasid_table *pasid_table; /* pasid table */
+#ifdef CONFIG_INTEL_IOMMU_DEBUGFS
+	struct dentry *debugfs_dentry; /* pointer to device directory dentry */
+#endif
 };
 
 struct dev_pasid_info {
 	struct list_head link_domain;	/* link to domain siblings */
 	struct device *dev;
 	ioasid_t pasid;
+#ifdef CONFIG_INTEL_IOMMU_DEBUGFS
+	struct dentry *debugfs_dentry; /* pointer to pasid directory dentry */
+#endif
 };
 
 static inline void __iommu_flush_cache(
@@ -883,8 +889,16 @@ static inline void intel_svm_remove_dev_pasid(struct device *dev, ioasid_t pasid
 
 #ifdef CONFIG_INTEL_IOMMU_DEBUGFS
 void intel_iommu_debugfs_init(void);
+void intel_iommu_debugfs_create_dev(struct device_domain_info *info);
+void intel_iommu_debugfs_remove_dev(struct device_domain_info *info);
+void intel_iommu_debugfs_create_dev_pasid(struct dev_pasid_info *dev_pasid);
+void intel_iommu_debugfs_remove_dev_pasid(struct dev_pasid_info *dev_pasid);
 #else
 static inline void intel_iommu_debugfs_init(void) {}
+static inline void intel_iommu_debugfs_create_dev(struct device_domain_info *info) {}
+static inline void intel_iommu_debugfs_remove_dev(struct device_domain_info *info) {}
+static inline void intel_iommu_debugfs_create_dev_pasid(struct dev_pasid_info *dev_pasid) {}
+static inline void intel_iommu_debugfs_remove_dev_pasid(struct dev_pasid_info *dev_pasid) {}
 #endif /* CONFIG_INTEL_IOMMU_DEBUGFS */
 
 extern const struct attribute_group *intel_iommu_groups[];
-- 
2.21.3

