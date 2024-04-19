Return-Path: <linux-kernel+bounces-151790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 631D18AB3E4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F651C22419
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF93513C90B;
	Fri, 19 Apr 2024 16:55:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D9413A3E0;
	Fri, 19 Apr 2024 16:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545736; cv=none; b=lW5DB8/3CUoN9X5hy/GDha4dGd7DWRcbYO3XlpwcjQLHoIAvDkMSuSChN+SfITBwyCBv7SRDqQR3u4Egq0Xnj1LtDAt0/pEKKAvvN8bQf1z4zTsjAN8GJWgTSPrWbcxcjZIrRoZqGLhtgK7tLSBvxqJPIhSb8BlVvnCKOdlzhgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545736; c=relaxed/simple;
	bh=9jhirLv7iFZZlHFpcdCqaP971VgQ37rdRzrXP/2bKJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f+B7pmJo2Bi+WR7iuE9keVVQFP5/e4jYrfoAbKyjd207IAan62d3V64drXMOnSNM/M54YNwHVY9j+E4BQBQBe5r9q9QtLgp9meE97dCOhFnGJyc4wNNNe4FYugiDOd6UsCd8GB3251s8vlMuf5pjjyeDrvWGVWDkpdCk7UXJMlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37F502F;
	Fri, 19 Apr 2024 09:56:02 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 230393F792;
	Fri, 19 Apr 2024 09:55:29 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: Joerg Roedel <joro@8bytes.org>,
	Christoph Hellwig <hch@lst.de>
Cc: Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v4 6/7] iommu/dma: Centralise iommu_setup_dma_ops()
Date: Fri, 19 Apr 2024 17:54:45 +0100
Message-Id: <bebea331c1d688b34d9862eefd5ede47503961b8.1713523152.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1713523152.git.robin.murphy@arm.com>
References: <cover.1713523152.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's somewhat hard to see, but arm64's arch_setup_dma_ops() should only
ever call iommu_setup_dma_ops() after a successful iommu_probe_device(),
which means there should be no harm in achieving the same order of
operations by running it off the back of iommu_probe_device() itself.
This then puts it in line with the x86 and s390 .probe_finalize bodges,
letting us pull it all into the main flow properly. As a bonus this lets
us fold in and de-scope the PCI workaround setup as well.

At this point we can also then pull the call up inside the group mutex,
and avoid having to think about whether iommu_group_store_type() could
theoretically race and free the domain if iommu_setup_dma_ops() ran just
*before* iommu_device_use_default_domain() claims it... Furthermore we
replace one .probe_finalize call completely, since the only remaining
implementations are now one which only needs to run once for the initial
boot-time probe, and two which themselves render that path unreachable.

This leaves us a big step closer to realistically being able to unpick
the variety of different things that iommu_setup_dma_ops() has been
muddling together, and further streamline iommu-dma into core API flows
in future.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com> # For Intel IOMMU
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
v2: Shuffle around to make sure the iommu_group_do_probe_finalize() case
    is covered as well, with bonus side-effects as above.
v3: *Really* do that, remembering the other two probe_finalize sites too.
---
 arch/arm64/mm/dma-mapping.c  |  2 --
 drivers/iommu/amd/iommu.c    |  8 --------
 drivers/iommu/dma-iommu.c    | 18 ++++++------------
 drivers/iommu/dma-iommu.h    | 14 ++++++--------
 drivers/iommu/intel/iommu.c  |  7 -------
 drivers/iommu/iommu.c        | 20 +++++++-------------
 drivers/iommu/s390-iommu.c   |  6 ------
 drivers/iommu/virtio-iommu.c | 10 ----------
 include/linux/iommu.h        |  7 -------
 9 files changed, 19 insertions(+), 73 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 61886e43e3a1..313d8938a2f0 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -58,8 +58,6 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 		   ARCH_DMA_MINALIGN, cls);
 
 	dev->dma_coherent = coherent;
-	if (device_iommu_mapped(dev))
-		iommu_setup_dma_ops(dev, dma_base, dma_base + size - 1);
 
 	xen_setup_dma_ops(dev);
 }
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d35c1b8c8e65..085abf098fa9 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2175,13 +2175,6 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 	return iommu_dev;
 }
 
-static void amd_iommu_probe_finalize(struct device *dev)
-{
-	/* Domains are initialized for this device - have a look what we ended up with */
-	set_dma_ops(dev, NULL);
-	iommu_setup_dma_ops(dev, 0, U64_MAX);
-}
-
 static void amd_iommu_release_device(struct device *dev)
 {
 	struct amd_iommu *iommu;
@@ -2784,7 +2777,6 @@ const struct iommu_ops amd_iommu_ops = {
 	.domain_alloc_user = amd_iommu_domain_alloc_user,
 	.probe_device = amd_iommu_probe_device,
 	.release_device = amd_iommu_release_device,
-	.probe_finalize = amd_iommu_probe_finalize,
 	.device_group = amd_iommu_device_group,
 	.get_resv_regions = amd_iommu_get_resv_regions,
 	.is_attach_deferred = amd_iommu_is_attach_deferred,
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f542eabaefa4..89a53c2f2cf9 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1741,25 +1741,20 @@ static const struct dma_map_ops iommu_dma_ops = {
 	.max_mapping_size       = iommu_dma_max_mapping_size,
 };
 
-/*
- * The IOMMU core code allocates the default DMA domain, which the underlying
- * IOMMU driver needs to support via the dma-iommu layer.
- */
-void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
+void iommu_setup_dma_ops(struct device *dev)
 {
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 
-	if (!domain)
-		goto out_err;
+	if (dev_is_pci(dev))
+		dev->iommu->pci_32bit_workaround = !iommu_dma_forcedac;
 
-	/*
-	 * The IOMMU core code allocates the default DMA domain, which the
-	 * underlying IOMMU driver needs to support via the dma-iommu layer.
-	 */
 	if (iommu_is_dma_domain(domain)) {
 		if (iommu_dma_init_domain(domain, dev))
 			goto out_err;
 		dev->dma_ops = &iommu_dma_ops;
+	} else if (dev->dma_ops == &iommu_dma_ops) {
+		/* Clean up if we've switched *from* a DMA domain */
+		dev->dma_ops = NULL;
 	}
 
 	return;
@@ -1767,7 +1762,6 @@ void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
 	 pr_warn("Failed to set up IOMMU for device %s; retaining platform DMA ops\n",
 		 dev_name(dev));
 }
-EXPORT_SYMBOL_GPL(iommu_setup_dma_ops);
 
 static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 		phys_addr_t msi_addr, struct iommu_domain *domain)
diff --git a/drivers/iommu/dma-iommu.h b/drivers/iommu/dma-iommu.h
index c829f1f82a99..c12d63457c76 100644
--- a/drivers/iommu/dma-iommu.h
+++ b/drivers/iommu/dma-iommu.h
@@ -9,6 +9,8 @@
 
 #ifdef CONFIG_IOMMU_DMA
 
+void iommu_setup_dma_ops(struct device *dev);
+
 int iommu_get_dma_cookie(struct iommu_domain *domain);
 void iommu_put_dma_cookie(struct iommu_domain *domain);
 
@@ -17,13 +19,13 @@ int iommu_dma_init_fq(struct iommu_domain *domain);
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
 extern bool iommu_dma_forcedac;
-static inline void iommu_dma_set_pci_32bit_workaround(struct device *dev)
-{
-	dev->iommu->pci_32bit_workaround = !iommu_dma_forcedac;
-}
 
 #else /* CONFIG_IOMMU_DMA */
 
+static inline void iommu_setup_dma_ops(struct device *dev)
+{
+}
+
 static inline int iommu_dma_init_fq(struct iommu_domain *domain)
 {
 	return -EINVAL;
@@ -42,9 +44,5 @@ static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_he
 {
 }
 
-static inline void iommu_dma_set_pci_32bit_workaround(struct device *dev)
-{
-}
-
 #endif	/* CONFIG_IOMMU_DMA */
 #endif	/* __DMA_IOMMU_H */
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 50eb9aed47cc..b2f6d8564463 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4349,12 +4349,6 @@ static void intel_iommu_release_device(struct device *dev)
 	set_dma_ops(dev, NULL);
 }
 
-static void intel_iommu_probe_finalize(struct device *dev)
-{
-	set_dma_ops(dev, NULL);
-	iommu_setup_dma_ops(dev, 0, U64_MAX);
-}
-
 static void intel_iommu_get_resv_regions(struct device *device,
 					 struct list_head *head)
 {
@@ -4839,7 +4833,6 @@ const struct iommu_ops intel_iommu_ops = {
 	.domain_alloc		= intel_iommu_domain_alloc,
 	.domain_alloc_user	= intel_iommu_domain_alloc_user,
 	.probe_device		= intel_iommu_probe_device,
-	.probe_finalize		= intel_iommu_probe_finalize,
 	.release_device		= intel_iommu_release_device,
 	.get_resv_regions	= intel_iommu_get_resv_regions,
 	.device_group		= intel_iommu_device_group,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index a95a483def2d..f01133b906e2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -581,10 +581,11 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 		if (list_empty(&group->entry))
 			list_add_tail(&group->entry, group_list);
 	}
-	mutex_unlock(&group->mutex);
 
-	if (dev_is_pci(dev))
-		iommu_dma_set_pci_32bit_workaround(dev);
+	if (group->default_domain)
+		iommu_setup_dma_ops(dev);
+
+	mutex_unlock(&group->mutex);
 
 	return 0;
 
@@ -1828,6 +1829,8 @@ int bus_iommu_probe(const struct bus_type *bus)
 			mutex_unlock(&group->mutex);
 			return ret;
 		}
+		for_each_group_device(group, gdev)
+			iommu_setup_dma_ops(gdev->dev);
 		mutex_unlock(&group->mutex);
 
 		/*
@@ -3066,18 +3069,9 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 	if (ret)
 		goto out_unlock;
 
-	/*
-	 * Release the mutex here because ops->probe_finalize() call-back of
-	 * some vendor IOMMU drivers calls arm_iommu_attach_device() which
-	 * in-turn might call back into IOMMU core code, where it tries to take
-	 * group->mutex, resulting in a deadlock.
-	 */
-	mutex_unlock(&group->mutex);
-
 	/* Make sure dma_ops is appropriatley set */
 	for_each_group_device(group, gdev)
-		iommu_group_do_probe_finalize(gdev->dev);
-	return count;
+		iommu_setup_dma_ops(gdev->dev);
 
 out_unlock:
 	mutex_unlock(&group->mutex);
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 9a5196f523de..d8eaa7ea380b 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -695,11 +695,6 @@ static size_t s390_iommu_unmap_pages(struct iommu_domain *domain,
 	return size;
 }
 
-static void s390_iommu_probe_finalize(struct device *dev)
-{
-	iommu_setup_dma_ops(dev, 0, U64_MAX);
-}
-
 struct zpci_iommu_ctrs *zpci_get_iommu_ctrs(struct zpci_dev *zdev)
 {
 	if (!zdev || !zdev->s390_domain)
@@ -785,7 +780,6 @@ static const struct iommu_ops s390_iommu_ops = {
 	.capable = s390_iommu_capable,
 	.domain_alloc_paging = s390_domain_alloc_paging,
 	.probe_device = s390_iommu_probe_device,
-	.probe_finalize = s390_iommu_probe_finalize,
 	.release_device = s390_iommu_release_device,
 	.device_group = generic_device_group,
 	.pgsize_bitmap = SZ_4K,
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 04048f64a2c0..8e776f6c6e35 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1025,15 +1025,6 @@ static struct iommu_device *viommu_probe_device(struct device *dev)
 	return ERR_PTR(ret);
 }
 
-static void viommu_probe_finalize(struct device *dev)
-{
-#ifndef CONFIG_ARCH_HAS_SETUP_DMA_OPS
-	/* First clear the DMA ops in case we're switching from a DMA domain */
-	set_dma_ops(dev, NULL);
-	iommu_setup_dma_ops(dev, 0, U64_MAX);
-#endif
-}
-
 static void viommu_release_device(struct device *dev)
 {
 	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
@@ -1073,7 +1064,6 @@ static struct iommu_ops viommu_ops = {
 	.capable		= viommu_capable,
 	.domain_alloc		= viommu_domain_alloc,
 	.probe_device		= viommu_probe_device,
-	.probe_finalize		= viommu_probe_finalize,
 	.release_device		= viommu_release_device,
 	.device_group		= viommu_device_group,
 	.get_resv_regions	= viommu_get_resv_regions,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 190173906ec9..ae6e5adebbd1 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1445,9 +1445,6 @@ static inline void iommu_debugfs_setup(void) {}
 #ifdef CONFIG_IOMMU_DMA
 #include <linux/msi.h>
 
-/* Setup call for arch DMA mapping code */
-void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit);
-
 int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
 
 int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr);
@@ -1458,10 +1455,6 @@ void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_msg *msg);
 struct msi_desc;
 struct msi_msg;
 
-static inline void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
-{
-}
-
 static inline int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
 {
 	return -ENODEV;
-- 
2.39.2.101.g768bb238c484.dirty


