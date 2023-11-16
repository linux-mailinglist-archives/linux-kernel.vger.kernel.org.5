Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D175B7ED90F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 02:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344470AbjKPBzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 20:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjKPBzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 20:55:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152D8193
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700099708; x=1731635708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DMLi3DhFO/bE1M8TdcfIIPan3UqkswMnGDv87IlMJ10=;
  b=JRAwvPykLAbhXqFMUxwt5sZvrA8gBGemY9JzLQVZP70UqW7pQFdXEnVR
   hrfptTJTilScMf/Ikxy/U4RSzt22C65Xsaac5UJlNoT6Qby30C+4x89AS
   xkEkwFwtdMYEzpYzZ0/0FG4RjAS2jh4Iiaz/shGeCzD5FibodxkcCUON9
   E48v8dnfthAGxHtZemc+CKxkUoFlvGq5ppmwyCUJZ7nwvBJAEgNvCcCl0
   lf4zJ2PwiqG5ndEoPk9vZTaUYjXKzxR+RQcZYPU4rTv83DW2FuepGLUu0
   FwzrOflQ86Bk//RECfJqqyPCNMgPpesBZiuGYOcVsoiOqZmpaRbXS6Rez
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="381387682"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="381387682"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 17:55:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="13395419"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa001.fm.intel.com with ESMTP; 15 Nov 2023 17:55:05 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/4] iommu/vt-d: Introduce dev_to_iommu()
Date:   Thu, 16 Nov 2023 09:50:45 +0800
Message-Id: <20231116015048.29675-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231116015048.29675-1-baolu.lu@linux.intel.com>
References: <20231116015048.29675-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device_to_iommu() helper was originally designed to look up the DMAR
ACPI table to retrieve the iommu device and the request ID for a given
device. However, it was also being used in other places where there was
no need to lookup the ACPI table at all.

Introduce a new helper dev_to_iommu() which returns the iommu device saved
in the per-device iommu driver data. This function can be used after the
iommu_probe_device() returns success.

Rename the original device_to_iommu() function to a more meaningful name,
device_lookup_iommu(), to avoid mis-using it.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h | 11 ++++++++++-
 drivers/iommu/intel/iommu.c | 28 ++++++++--------------------
 drivers/iommu/intel/svm.c   | 20 +++-----------------
 3 files changed, 21 insertions(+), 38 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 65d37a138c75..049d6af6aae8 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -851,6 +851,16 @@ static inline bool context_present(struct context_entry *context)
 	return (context->lo & 1);
 }
 
+static inline struct intel_iommu *dev_to_iommu(struct device *dev)
+{
+	/*
+	 * Assume that valid per-device iommu structure must be installed
+	 * if iommu_probe_device() has succeeded. This helper could only
+	 * be used after device is probed.
+	 */
+	return ((struct device_domain_info *)dev_iommu_priv_get(dev))->iommu;
+}
+
 struct dmar_drhd_unit *dmar_find_matched_drhd_unit(struct pci_dev *dev);
 
 int dmar_enable_qi(struct intel_iommu *iommu);
@@ -897,7 +907,6 @@ int dmar_ir_support(void);
 void *alloc_pgtable_page(int node, gfp_t gfp);
 void free_pgtable_page(void *vaddr);
 void iommu_flush_write_buffer(struct intel_iommu *iommu);
-struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn);
 struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *parent,
 					       const struct iommu_user_data *user_data);
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 3531b956556c..b50ade814e94 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -703,7 +703,7 @@ static bool iommu_is_dummy(struct intel_iommu *iommu, struct device *dev)
 	return false;
 }
 
-struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn)
+static struct intel_iommu *device_lookup_iommu(struct device *dev, u8 *bus, u8 *devfn)
 {
 	struct dmar_drhd_unit *drhd = NULL;
 	struct pci_dev *pdev = NULL;
@@ -2081,14 +2081,11 @@ static int domain_context_mapping_cb(struct pci_dev *pdev,
 static int
 domain_context_mapping(struct dmar_domain *domain, struct device *dev)
 {
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct domain_context_mapping_data data;
+	struct intel_iommu *iommu = info->iommu;
+	u8 bus = info->bus, devfn = info->devfn;
 	struct pasid_table *table;
-	struct intel_iommu *iommu;
-	u8 bus, devfn;
-
-	iommu = device_to_iommu(dev, &bus, &devfn);
-	if (!iommu)
-		return -ENODEV;
 
 	table = intel_pasid_get_table(dev);
 
@@ -2447,15 +2444,10 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 				     struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	struct intel_iommu *iommu;
+	struct intel_iommu *iommu = info->iommu;
 	unsigned long flags;
-	u8 bus, devfn;
 	int ret;
 
-	iommu = device_to_iommu(dev, &bus, &devfn);
-	if (!iommu)
-		return -ENODEV;
-
 	ret = domain_attach_iommu(domain, iommu);
 	if (ret)
 		return ret;
@@ -4117,13 +4109,9 @@ int prepare_domain_attach_device(struct iommu_domain *domain,
 				 struct device *dev)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
-	struct intel_iommu *iommu;
+	struct intel_iommu *iommu = dev_to_iommu(dev);
 	int addr_width;
 
-	iommu = device_to_iommu(dev, NULL, NULL);
-	if (!iommu)
-		return -ENODEV;
-
 	if (dmar_domain->force_snooping && !ecap_sc_support(iommu->ecap))
 		return -EINVAL;
 
@@ -4399,7 +4387,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 	u8 bus, devfn;
 	int ret;
 
-	iommu = device_to_iommu(dev, &bus, &devfn);
+	iommu = device_lookup_iommu(dev, &bus, &devfn);
 	if (!iommu || !iommu->iommu.ops)
 		return ERR_PTR(-ENODEV);
 
@@ -4735,8 +4723,8 @@ static int intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 
 static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 {
-	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
 	struct dev_pasid_info *curr, *dev_pasid = NULL;
+	struct intel_iommu *iommu = dev_to_iommu(dev);
 	struct dmar_domain *dmar_domain;
 	struct iommu_domain *domain;
 	unsigned long flags;
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 50a481c895b8..cc138e3ed4a6 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -366,14 +366,9 @@ static int intel_svm_bind_mm(struct intel_iommu *iommu, struct device *dev,
 void intel_svm_remove_dev_pasid(struct device *dev, u32 pasid)
 {
 	struct intel_svm_dev *sdev;
-	struct intel_iommu *iommu;
 	struct intel_svm *svm;
 	struct mm_struct *mm;
 
-	iommu = device_to_iommu(dev, NULL, NULL);
-	if (!iommu)
-		return;
-
 	if (pasid_to_svm_sdev(dev, pasid, &svm, &sdev))
 		return;
 	mm = svm->mm;
@@ -724,25 +719,16 @@ int intel_svm_page_response(struct device *dev,
 			    struct iommu_fault_event *evt,
 			    struct iommu_page_response *msg)
 {
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+	u8 bus = info->bus, devfn = info->devfn;
 	struct iommu_fault_page_request *prm;
-	struct intel_iommu *iommu;
 	bool private_present;
 	bool pasid_present;
 	bool last_page;
-	u8 bus, devfn;
 	int ret = 0;
 	u16 sid;
 
-	if (!dev || !dev_is_pci(dev))
-		return -ENODEV;
-
-	iommu = device_to_iommu(dev, &bus, &devfn);
-	if (!iommu)
-		return -ENODEV;
-
-	if (!msg || !evt)
-		return -EINVAL;
-
 	prm = &evt->fault.prm;
 	sid = PCI_DEVID(bus, devfn);
 	pasid_present = prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
-- 
2.34.1

