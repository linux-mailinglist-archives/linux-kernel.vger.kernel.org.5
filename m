Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B007C9DE8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 05:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjJPDcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 23:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjJPDcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 23:32:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDCBE3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 20:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697427134; x=1728963134;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gcS2gVf871BMvktYqKffgfurRtP/g/aQmfhIpspVA+k=;
  b=nYZz+8s1JikdFzxWQxgLnU/Ag0VvFo0WTPT+SqU2sKoFoEwuVfQWeh7b
   YgsqaWO182mvp6QVPjNm5RK8yDty9Dz+xDD5NGEaSh8c8j/Cs4thPgZws
   6xoFA7fotMIQ+6o4I4EZLC/0IMPky9Zi/ASmLla5mlR2d3/uHoqjnz8jp
   Of92nqUileIswnyHRDaCGjTwjjB8HFED2cH88sRt7IKOmsXcYYpwQ8Cjv
   vIHmI+knag/tzZqZUTkzuzGdoN6HQgWO5bDgo70f44RUFqk34GA3rbQUX
   rA/9YmG5ZHAtmWKoqvLYFdiC0V/9AXpkSvORnNrOdAGei09cVc50Xn+1K
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="365701133"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="365701133"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 20:32:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="705444260"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="705444260"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga003.jf.intel.com with ESMTP; 15 Oct 2023 20:32:12 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jingqi Liu <Jingqi.liu@intel.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] iommu/vt-d: debugfs: Create/remove debugfs file per {device, pasid}
Date:   Mon, 16 Oct 2023 11:28:29 +0800
Message-Id: <20231016032830.101321-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016032830.101321-1-baolu.lu@linux.intel.com>
References: <20231016032830.101321-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jingqi Liu <Jingqi.liu@intel.com>

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
Link: https://lore.kernel.org/r/20231013135811.73953-3-Jingqi.liu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h   | 14 +++++++++
 drivers/iommu/intel/debugfs.c | 53 +++++++++++++++++++++++++++++++----
 drivers/iommu/intel/iommu.c   |  7 +++++
 3 files changed, 69 insertions(+), 5 deletions(-)

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
-- 
2.34.1

