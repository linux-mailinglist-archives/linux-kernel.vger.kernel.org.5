Return-Path: <linux-kernel+bounces-77694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 107D0860912
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 337D11C22527
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA24C126;
	Fri, 23 Feb 2024 02:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXb6lPth"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E54B65F
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 02:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708657026; cv=none; b=j2waeK05O92BrxVtuEHK3vhc9cB9Y8byu00NiB5KF6EOF+UvNPGeKNp88QpWq1GmYsMbi+ikIPEpLo5pqfuTxE7wspPiujrNCUXy36Kv0na/SPIRo8rfHfpVLEvGosg11WhQCjWhmPUoFhRJAUbLLeU0TjdDxsxJr8seFtgOYV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708657026; c=relaxed/simple;
	bh=ONI4bNAssRBpKlVO1FPuEcfyYX+4JFIm+oC0BS/xsrw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fPQ6WXMRTPmV7ncsGgyPAh2kvYQtvfA4o47DwoGowrpbfvRqHd2Nz/hudWLkGitmADp8wSTJJEOjWkNx9iwJQcN18pDkHYmWqYDa+JKij8evkhjacOqHKkujxqYFKNwpgOgxSyR1c9eemvqV4oEeTDFzrwDB5BbRNyReLsxHxQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXb6lPth; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-59fdcf8ebbcso254654eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708657024; x=1709261824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4C5LzKaxMdJMs4/73l902cX1acMeKlg0P8Cx6/Y9jGU=;
        b=FXb6lPth7azcDvgzu8092ic9l4lr2tj0UsKW0TEqHbEpZoH4J56y1R2/q7cjXx7qbT
         gj0a8MtjRqaa7T0au/quN+b+N10v3nxBjBj+PPsQVLswX/qsCFNYas9qKs9chwZAXmya
         vpMhD66BBagoaCNCU7G+UtxbGAnBLS/q+KxxBEdAN9lANuKUlzJ76/FJo+sFDB+ndBOK
         MZzdM6z7d7BPAoYa56uVd6quWMClA1LWsvIOK0iE1MH2RtaqJDw5q9zF+iPU81C0on4D
         bbUbxTklzXTHKP5itPI34t/UBc5S9AxZ4TglMrnvUsfPya1w2skmeKqnveqZiz1S7NE5
         YnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708657024; x=1709261824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4C5LzKaxMdJMs4/73l902cX1acMeKlg0P8Cx6/Y9jGU=;
        b=VEjz58ozWInkl/RXmpctdbcX/N4+lPHMBMGmmDkf5/Gxf6R0CrKP3Xl100IxWqFWRX
         VXzt+shBUIcOGkB6V6w2UObCKx5g4545RA9JIkWkOaKb79HijGV8drYlbdub/tL3Ml6m
         oFT9GqLg5vDrBMj/7ccMUJUAYNlAxsUVxvfClP7Nb2xq551zM5OHM5CLpKra+dNO8CRY
         taeS0TFPeD8kYPwtnlN3z8V2OWny6WItVaXE+nDtF1Owp9LAsS6yO6f+YTX3b3ZS+N1D
         ro1UxH3oJvp7+X2pJ+GT8/z5H97lSbBV2b45W2VQmktlwJqz8AMw3IXj1Sb3c2Lka2ly
         WcVQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2/oDrejMRKF4fIdHWvDKp5HJ/S8uR26hoyV+RhdVC+gRoNRn0rucmcNOOjQnnfavzlfr6AUR0VkFZVTUj/ajE4gj6E5yzAqCuHFWV
X-Gm-Message-State: AOJu0YznezJnHX7m0+k11P8p12/kYd2GYZfcWIuNWatAlFTT1Z9mpxZE
	tYHjXFaP9rK6bcRRd9bhRXXLnau42/psXLpjKx4Zs+XduR1ovPeBZqop4j7VzEuZsyhl
X-Google-Smtp-Source: AGHT+IEr9StlvsniywfgevDU7wEb4EQBEWK/dkHP6akPHSD6r1tPTuLV3OIQ5Tf0OaDY6AOVG/YVgg==
X-Received: by 2002:a05:6358:724e:b0:178:c51c:7af5 with SMTP id i14-20020a056358724e00b00178c51c7af5mr688442rwa.32.1708657023647;
        Thu, 22 Feb 2024 18:57:03 -0800 (PST)
Received: from localhost.localdomain ([2a13:82c1:b816::1])
        by smtp.gmail.com with ESMTPSA id h26-20020a63121a000000b005dc8702f0a9sm9941770pgl.1.2024.02.22.18.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 18:57:03 -0800 (PST)
From: YeeLi <seven.yi.lee@gmail.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	yeeli <seven.yi.lee@gmail.com>
Subject: [PATCH] iommu/vt-d: Replace ioasid_t with unsigned int
Date: Fri, 23 Feb 2024 10:56:56 +0800
Message-Id: <20240223025656.733674-1-seven.yi.lee@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: yeeli <seven.yi.lee@gmail.com>

The sense of ioasid_t type is not clear after remove IOASID infrastructure.
And, developers are confused about the ambiguity between ioasid_t type
and ioas_id val (in iommufd).

Signed-off-by: yeeli <seven.yi.lee@gmail.com>
---
 Documentation/userspace-api/iommu.rst         |  2 +-
 drivers/dma/idxd/cdev.c                       |  2 +-
 drivers/dma/idxd/idxd.h                       |  4 +--
 drivers/dma/idxd/init.c                       |  2 +-
 drivers/iommu/amd/iommu.c                     |  8 +++---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  4 +--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  4 +--
 drivers/iommu/intel/debugfs.c                 |  2 +-
 drivers/iommu/intel/iommu.c                   |  4 +--
 drivers/iommu/intel/iommu.h                   |  6 ++---
 drivers/iommu/intel/svm.c                     | 10 +++----
 drivers/iommu/iommu-sva.c                     |  2 +-
 drivers/iommu/iommu.c                         | 14 +++++-----
 include/linux/iommu.h                         | 27 +++++++++----------
 15 files changed, 46 insertions(+), 47 deletions(-)

diff --git a/Documentation/userspace-api/iommu.rst b/Documentation/userspace-api/iommu.rst
index d3108c1519d5..71839af9fae2 100644
--- a/Documentation/userspace-api/iommu.rst
+++ b/Documentation/userspace-api/iommu.rst
@@ -206,4 +206,4 @@ Userspace caller ::
 In-kernel caller ::
 
   int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
-                              struct device *dev, ioasid_t ioasid);
+                              struct device *dev, unsigned int ioasid);
diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 77f8885cf407..165f17b6a81f 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -644,7 +644,7 @@ void idxd_cdev_remove(void)
  *
  * Return: number of bytes copied.
  */
-int idxd_copy_cr(struct idxd_wq *wq, ioasid_t pasid, unsigned long addr,
+int idxd_copy_cr(struct idxd_wq *wq, unsigned int pasid, unsigned long addr,
 		 void *cr, int len)
 {
 	struct device *dev = &wq->idxd->pdev->dev;
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 47de3f93ff1e..eda0b7b3f1ac 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -95,7 +95,7 @@ struct idxd_irq_entry {
 	 */
 	spinlock_t list_lock;
 	int int_handle;
-	ioasid_t pasid;
+	unsigned int pasid;
 };
 
 struct idxd_group {
@@ -792,7 +792,7 @@ void idxd_cdev_remove(void);
 int idxd_cdev_get_major(struct idxd_device *idxd);
 int idxd_wq_add_cdev(struct idxd_wq *wq);
 void idxd_wq_del_cdev(struct idxd_wq *wq);
-int idxd_copy_cr(struct idxd_wq *wq, ioasid_t pasid, unsigned long addr,
+int idxd_copy_cr(struct idxd_wq *wq, unsigned int pasid, unsigned long addr,
 		 void *buf, int len);
 void idxd_user_counter_increment(struct idxd_wq *wq, u32 pasid, int index);
 
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 14df1f1347a8..5fec390e5cae 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -554,7 +554,7 @@ static int idxd_enable_system_pasid(struct idxd_device *idxd)
 	struct pci_dev *pdev = idxd->pdev;
 	struct device *dev = &pdev->dev;
 	struct iommu_domain *domain;
-	ioasid_t pasid;
+	unsigned int pasid;
 	int ret;
 
 	/*
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4283dd8191f0..21d583b8c76e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1128,7 +1128,7 @@ static inline u64 build_inv_address(u64 address, size_t size)
 
 static void build_inv_iommu_pages(struct iommu_cmd *cmd, u64 address,
 				  size_t size, u16 domid,
-				  ioasid_t pasid, bool gn)
+				  unsigned int pasid, bool gn)
 {
 	u64 inv_address = build_inv_address(address, size);
 
@@ -1148,7 +1148,7 @@ static void build_inv_iommu_pages(struct iommu_cmd *cmd, u64 address,
 
 static void build_inv_iotlb_pages(struct iommu_cmd *cmd, u16 devid, int qdep,
 				  u64 address, size_t size,
-				  ioasid_t pasid, bool gn)
+				  unsigned int pasid, bool gn)
 {
 	u64 inv_address = build_inv_address(address, size);
 
@@ -1386,7 +1386,7 @@ void amd_iommu_flush_all_caches(struct amd_iommu *iommu)
  * Command send function for flushing on-device TLB
  */
 static int device_flush_iotlb(struct iommu_dev_data *dev_data, u64 address,
-			      size_t size, ioasid_t pasid, bool gn)
+			      size_t size, unsigned int pasid, bool gn)
 {
 	struct amd_iommu *iommu;
 	struct iommu_cmd cmd;
@@ -1464,7 +1464,7 @@ static void __domain_flush_pages(struct protection_domain *domain,
 	struct iommu_dev_data *dev_data;
 	struct iommu_cmd cmd;
 	int ret = 0, i;
-	ioasid_t pasid = IOMMU_NO_PASID;
+	unsigned int pasid = IOMMU_NO_PASID;
 	bool gn = false;
 
 	if (pdom_is_v2_pgtbl_mode(domain))
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 05722121f00e..aae90efc980d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -561,7 +561,7 @@ void arm_smmu_sva_notifier_synchronize(void)
 }
 
 void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
-				   struct device *dev, ioasid_t id)
+				   struct device *dev, unsigned int id)
 {
 	struct mm_struct *mm = domain->mm;
 	struct arm_smmu_bond *bond = NULL, *t;
@@ -584,7 +584,7 @@ void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
 }
 
 static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
-				      struct device *dev, ioasid_t id)
+				      struct device *dev, unsigned int id)
 {
 	int ret = 0;
 	struct mm_struct *mm = domain->mm;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 0ffb1cf17e0b..cef536b2c63d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2832,7 +2832,7 @@ static int arm_smmu_def_domain_type(struct device *dev)
 	return 0;
 }
 
-static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
+static void arm_smmu_remove_dev_pasid(struct device *dev, unsigned int pasid)
 {
 	struct iommu_domain *domain;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 65fb388d5173..af7585da1bec 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -768,7 +768,7 @@ bool arm_smmu_master_iopf_supported(struct arm_smmu_master *master);
 void arm_smmu_sva_notifier_synchronize(void);
 struct iommu_domain *arm_smmu_sva_domain_alloc(void);
 void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
-				   struct device *dev, ioasid_t id);
+				   struct device *dev, unsigned int id);
 #else /* CONFIG_ARM_SMMU_V3_SVA */
 static inline bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
 {
@@ -809,7 +809,7 @@ static inline struct iommu_domain *arm_smmu_sva_domain_alloc(void)
 
 static inline void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
 						 struct device *dev,
-						 ioasid_t id)
+						 unsigned int id)
 {
 }
 #endif /* CONFIG_ARM_SMMU_V3_SVA */
diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index 86b506af7daa..26cf4cd2a7e9 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -346,7 +346,7 @@ static void pgtable_walk_level(struct seq_file *m, struct dma_pte *pde,
 
 static int domain_translation_struct_show(struct seq_file *m,
 					  struct device_domain_info *info,
-					  ioasid_t pasid)
+					  unsigned int pasid)
 {
 	bool scalable, found = false;
 	struct dmar_drhd_unit *drhd;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6fb5f6fceea1..837c3b665e26 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4544,7 +4544,7 @@ static int intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 	return 0;
 }
 
-static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
+static void intel_iommu_remove_dev_pasid(struct device *dev, unsigned int pasid)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct dev_pasid_info *curr, *dev_pasid = NULL;
@@ -4588,7 +4588,7 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 }
 
 static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
-				     struct device *dev, ioasid_t pasid)
+				     struct device *dev, unsigned int pasid)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index d02f916d8e59..132ca4a0cac6 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -757,7 +757,7 @@ struct device_domain_info {
 struct dev_pasid_info {
 	struct list_head link_domain;	/* link to domain siblings */
 	struct device *dev;
-	ioasid_t pasid;
+	unsigned int pasid;
 #ifdef CONFIG_INTEL_IOMMU_DEBUGFS
 	struct dentry *debugfs_dentry; /* pointer to pasid directory dentry */
 #endif
@@ -1082,7 +1082,7 @@ int intel_svm_finish_prq(struct intel_iommu *iommu);
 int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
 			    struct iommu_page_response *msg);
 struct iommu_domain *intel_svm_domain_alloc(void);
-void intel_svm_remove_dev_pasid(struct device *dev, ioasid_t pasid);
+void intel_svm_remove_dev_pasid(struct device *dev, unsigned int pasid);
 void intel_drain_pasid_prq(struct device *dev, u32 pasid);
 
 struct intel_svm_dev {
@@ -1108,7 +1108,7 @@ static inline struct iommu_domain *intel_svm_domain_alloc(void)
 	return NULL;
 }
 
-static inline void intel_svm_remove_dev_pasid(struct device *dev, ioasid_t pasid)
+static inline void intel_svm_remove_dev_pasid(struct device *dev, unsigned int pasid)
 {
 }
 #endif
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 40edd282903f..d0fd1b9d22dd 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -28,18 +28,18 @@
 static irqreturn_t prq_event_thread(int irq, void *d);
 
 static DEFINE_XARRAY_ALLOC(pasid_private_array);
-static int pasid_private_add(ioasid_t pasid, void *priv)
+static int pasid_private_add(unsigned int pasid, void *priv)
 {
 	return xa_alloc(&pasid_private_array, &pasid, priv,
 			XA_LIMIT(pasid, pasid), GFP_ATOMIC);
 }
 
-static void pasid_private_remove(ioasid_t pasid)
+static void pasid_private_remove(unsigned int pasid)
 {
 	xa_erase(&pasid_private_array, pasid);
 }
 
-static void *pasid_private_find(ioasid_t pasid)
+static void *pasid_private_find(unsigned int pasid)
 {
 	return xa_load(&pasid_private_array, pasid);
 }
@@ -316,7 +316,7 @@ static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
 }
 
 static int intel_svm_bind_mm(struct intel_iommu *iommu, struct device *dev,
-			     struct iommu_domain *domain, ioasid_t pasid)
+			     struct iommu_domain *domain, unsigned int pasid)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct mm_struct *mm = domain->mm;
@@ -805,7 +805,7 @@ int intel_svm_page_response(struct device *dev,
 }
 
 static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
-				   struct device *dev, ioasid_t pasid)
+				   struct device *dev, unsigned int pasid)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index c3fc9201d0be..86fc9183aa04 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -15,7 +15,7 @@ static DEFINE_MUTEX(iommu_sva_lock);
 static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm, struct device *dev)
 {
 	struct iommu_mm_data *iommu_mm;
-	ioasid_t pasid;
+	unsigned int pasid;
 
 	lockdep_assert_held(&iommu_sva_lock);
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d14413916f93..968b1fcbf4ce 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3497,7 +3497,7 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
 EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
 
 static int __iommu_set_group_pasid(struct iommu_domain *domain,
-				   struct iommu_group *group, ioasid_t pasid)
+				   struct iommu_group *group, unsigned int pasid)
 {
 	struct group_device *device;
 	int ret = 0;
@@ -3512,7 +3512,7 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
 }
 
 static void __iommu_remove_group_pasid(struct iommu_group *group,
-				       ioasid_t pasid)
+				       unsigned int pasid)
 {
 	struct group_device *device;
 	const struct iommu_ops *ops;
@@ -3532,7 +3532,7 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
  * Return: 0 on success, or an error.
  */
 int iommu_attach_device_pasid(struct iommu_domain *domain,
-			      struct device *dev, ioasid_t pasid)
+			      struct device *dev, unsigned int pasid)
 {
 	/* Caller must be a probed driver on dev */
 	struct iommu_group *group = dev->iommu_group;
@@ -3576,7 +3576,7 @@ EXPORT_SYMBOL_GPL(iommu_attach_device_pasid);
  * iommu_attach_device_pasid().
  */
 void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
-			       ioasid_t pasid)
+			       unsigned int pasid)
 {
 	/* Caller must be a probed driver on dev */
 	struct iommu_group *group = dev->iommu_group;
@@ -3603,7 +3603,7 @@ EXPORT_SYMBOL_GPL(iommu_detach_device_pasid);
  * Return: attached domain on success, NULL otherwise.
  */
 struct iommu_domain *iommu_get_domain_for_dev_pasid(struct device *dev,
-						    ioasid_t pasid,
+						    unsigned int pasid,
 						    unsigned int type)
 {
 	/* Caller must be a probed driver on dev */
@@ -3643,7 +3643,7 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 	return domain;
 }
 
-ioasid_t iommu_alloc_global_pasid(struct device *dev)
+unsigned int iommu_alloc_global_pasid(struct device *dev)
 {
 	int ret;
 
@@ -3661,7 +3661,7 @@ ioasid_t iommu_alloc_global_pasid(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_alloc_global_pasid);
 
-void iommu_free_global_pasid(ioasid_t pasid)
+void iommu_free_global_pasid(unsigned int pasid)
 {
 	if (WARN_ON(pasid == IOMMU_PASID_INVALID))
 		return;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 1ea2a820e1eb..2e164b6b1c96 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -217,7 +217,6 @@ enum iommu_dev_features {
 #define IOMMU_NO_PASID	(0U) /* Reserved for DMA w/o PASID */
 #define IOMMU_FIRST_GLOBAL_PASID	(1U) /*starting range for allocation */
 #define IOMMU_PASID_INVALID	(-1U)
-typedef unsigned int ioasid_t;
 
 #ifdef CONFIG_IOMMU_API
 
@@ -480,7 +479,7 @@ struct iommu_ops {
 			     struct iommu_page_response *msg);
 
 	int (*def_domain_type)(struct device *dev);
-	void (*remove_dev_pasid)(struct device *dev, ioasid_t pasid);
+	void (*remove_dev_pasid)(struct device *dev, unsigned int pasid);
 
 	const struct iommu_domain_ops *default_domain_ops;
 	unsigned long pgsize_bitmap;
@@ -531,7 +530,7 @@ struct iommu_ops {
 struct iommu_domain_ops {
 	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
 	int (*set_dev_pasid)(struct iommu_domain *domain, struct device *dev,
-			     ioasid_t pasid);
+			     unsigned int pasid);
 
 	int (*map_pages)(struct iommu_domain *domain, unsigned long iova,
 			 phys_addr_t paddr, size_t pgsize, size_t pgcount,
@@ -673,7 +672,7 @@ extern int iommu_attach_device(struct iommu_domain *domain,
 extern void iommu_detach_device(struct iommu_domain *domain,
 				struct device *dev);
 extern int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
-				   struct device *dev, ioasid_t pasid);
+				   struct device *dev, unsigned int pasid);
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
@@ -948,14 +947,14 @@ void iommu_device_release_dma_owner(struct device *dev);
 struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 					    struct mm_struct *mm);
 int iommu_attach_device_pasid(struct iommu_domain *domain,
-			      struct device *dev, ioasid_t pasid);
+			      struct device *dev, unsigned int pasid);
 void iommu_detach_device_pasid(struct iommu_domain *domain,
-			       struct device *dev, ioasid_t pasid);
+			       struct device *dev, unsigned int pasid);
 struct iommu_domain *
-iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid,
+iommu_get_domain_for_dev_pasid(struct device *dev, unsigned int pasid,
 			       unsigned int type);
-ioasid_t iommu_alloc_global_pasid(struct device *dev);
-void iommu_free_global_pasid(ioasid_t pasid);
+unsigned int iommu_alloc_global_pasid(struct device *dev);
+void iommu_free_global_pasid(unsigned int pasid);
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -1315,29 +1314,29 @@ iommu_sva_domain_alloc(struct device *dev, struct mm_struct *mm)
 }
 
 static inline int iommu_attach_device_pasid(struct iommu_domain *domain,
-					    struct device *dev, ioasid_t pasid)
+					    struct device *dev, unsigned int pasid)
 {
 	return -ENODEV;
 }
 
 static inline void iommu_detach_device_pasid(struct iommu_domain *domain,
-					     struct device *dev, ioasid_t pasid)
+					     struct device *dev, unsigned int pasid)
 {
 }
 
 static inline struct iommu_domain *
-iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid,
+iommu_get_domain_for_dev_pasid(struct device *dev, unsigned int pasid,
 			       unsigned int type)
 {
 	return NULL;
 }
 
-static inline ioasid_t iommu_alloc_global_pasid(struct device *dev)
+static inline unsigned int iommu_alloc_global_pasid(struct device *dev)
 {
 	return IOMMU_PASID_INVALID;
 }
 
-static inline void iommu_free_global_pasid(ioasid_t pasid) {}
+static inline void iommu_free_global_pasid(unsigned int pasid) {}
 #endif /* CONFIG_IOMMU_API */
 
 /**
-- 
2.34.1


