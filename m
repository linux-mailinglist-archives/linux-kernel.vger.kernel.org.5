Return-Path: <linux-kernel+bounces-3107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DEC816789
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FD061C20949
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DD0F9DC;
	Mon, 18 Dec 2023 07:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S/4s2jRE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC16D537
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702885176; x=1734421176;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xVp5DogoD1j0Uzdrhe+4lP3fnEZhmmMbK/MW+MXbM0o=;
  b=S/4s2jREslUFAVV6NFQbgdf1+jOgmdhW273yJye/vN3rpWJQuIy7EynH
   shF/FvpPnEkYnPVuRT8os77Rgs9oFYI9nZp0pfr6M7dt5kcDKoq5lVIz2
   6rvDZDVN6tLXlbnPNRdD2y5iJk6QRNQ+SKbKrr/j6hyuEoNCJ7ST4kkwD
   MiroPnNpzGyHQifQcSLdws12xl3rO7k9hvkihbpiwW/w//OdkGRy30E5u
   KFWWaXcbuhhMstIFeUIjsOmkPre3ChGSC2CUlzEK03FvIHUKOL2kkK1kf
   dR89u5+9bI68zAsaz9d8/nfobLescyEPxzEBQtFdVk4zsWoTrnnARmj2F
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="459793921"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="459793921"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 23:39:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="893723250"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="893723250"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga002.fm.intel.com with ESMTP; 17 Dec 2023 23:39:33 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] iommu/vt-d: Refactor device_to_iommu() to retrieve iommu directly
Date: Mon, 18 Dec 2023 15:34:42 +0800
Message-Id: <20231218073445.142401-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218073445.142401-1-baolu.lu@linux.intel.com>
References: <20231218073445.142401-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The device_to_iommu() helper was originally designed to look up the DMAR
ACPI table to retrieve the iommu device and the request ID for a given
device. However, it was also being used in other places where there was
no need to lookup the ACPI table at all.

Retrieve the iommu device directly from the per-device iommu private data
in functions called after device is probed.

Rename the original device_to_iommu() function to a more meaningful name,
device_lookup_iommu(), to avoid mis-using it.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20231116015048.29675-2-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.h |  1 -
 drivers/iommu/intel/iommu.c | 30 ++++++++++--------------------
 drivers/iommu/intel/svm.c   | 20 +++-----------------
 3 files changed, 13 insertions(+), 38 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index ce030c5b5772..42b8d3412115 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -900,7 +900,6 @@ int dmar_ir_support(void);
 void *alloc_pgtable_page(int node, gfp_t gfp);
 void free_pgtable_page(void *vaddr);
 void iommu_flush_write_buffer(struct intel_iommu *iommu);
-struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn);
 struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *parent,
 					       const struct iommu_user_data *user_data);
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 897159dba47d..874d35f760fb 100644
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
 
@@ -2449,15 +2446,10 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
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
@@ -4119,14 +4111,11 @@ static void intel_iommu_domain_free(struct iommu_domain *domain)
 int prepare_domain_attach_device(struct iommu_domain *domain,
 				 struct device *dev)
 {
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
-	struct intel_iommu *iommu;
+	struct intel_iommu *iommu = info->iommu;
 	int addr_width;
 
-	iommu = device_to_iommu(dev, NULL, NULL);
-	if (!iommu)
-		return -ENODEV;
-
 	if (dmar_domain->force_snooping && !ecap_sc_support(iommu->ecap))
 		return -EINVAL;
 
@@ -4403,7 +4392,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 	u8 bus, devfn;
 	int ret;
 
-	iommu = device_to_iommu(dev, &bus, &devfn);
+	iommu = device_lookup_iommu(dev, &bus, &devfn);
 	if (!iommu || !iommu->iommu.ops)
 		return ERR_PTR(-ENODEV);
 
@@ -4739,8 +4728,9 @@ static int intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 
 static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 {
-	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct dev_pasid_info *curr, *dev_pasid = NULL;
+	struct intel_iommu *iommu = info->iommu;
 	struct dmar_domain *dmar_domain;
 	struct iommu_domain *domain;
 	unsigned long flags;
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index ac12f76c1212..442ff9905ca9 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -392,14 +392,9 @@ static int intel_svm_bind_mm(struct intel_iommu *iommu, struct device *dev,
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
@@ -750,25 +745,16 @@ int intel_svm_page_response(struct device *dev,
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


