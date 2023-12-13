Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A57811AC5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379331AbjLMRSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235575AbjLMRSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:18:42 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B19910E;
        Wed, 13 Dec 2023 09:18:47 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B94C1576;
        Wed, 13 Dec 2023 09:19:33 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4A4373F762;
        Wed, 13 Dec 2023 09:18:43 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>
Cc:     Vineet Gupta <vgupta@kernel.org>,
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
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
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
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: [PATCH v2 6/7] iommu/dma: Centralise iommu_setup_dma_ops()
Date:   Wed, 13 Dec 2023 17:17:59 +0000
Message-Id: <5d89190b35720bf5b66621f46b6d3c85323d8eab.1702486837.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1702486837.git.robin.murphy@arm.com>
References: <cover.1702486837.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's somewhat hard to see, but arm64's arch_setup_dma_ops() should only
ever call iommu_setup_dma_ops() after a successful iommu_probe_device(),
which means there should be no harm in achieving the same orer of
operations by running it off the back of iommu_probe_device() itself.
This then puts it in line with the x86 and s390 .probe_finalize bodges,
letting us pull it all into the main flow properly. As a bonus this lets
us fold in and de-scope the PCI workaround setup as well.

At this point we can also then pull the call inside the group mutex, and
avoid having to think about whether iommu_group_store_type() could
theroetically race and free the domain where iommu_setup_dma_ops() may
currently run just *before* iommu_device_use_default_domain() claims it.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
v2: Shuffle around to make sure the iommu_group_do_probe_finalize() cases
    are covered as well, with bonus side-effects as above.
---
 arch/arm64/mm/dma-mapping.c  |  2 --
 drivers/iommu/amd/iommu.c    |  8 --------
 drivers/iommu/dma-iommu.c    | 18 ++++++------------
 drivers/iommu/dma-iommu.h    | 14 ++++++--------
 drivers/iommu/intel/iommu.c  |  7 -------
 drivers/iommu/iommu.c        |  6 +++---
 drivers/iommu/s390-iommu.c   |  6 ------
 drivers/iommu/virtio-iommu.c | 10 ----------
 include/linux/iommu.h        |  7 -------
 9 files changed, 15 insertions(+), 63 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 3cb101e8cb29..96ff791199e8 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -58,8 +58,6 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 		   ARCH_DMA_MINALIGN, cls);
 
 	dev->dma_coherent = coherent;
-	if (iommu)
-		iommu_setup_dma_ops(dev, dma_base, dma_base + size - 1);
 
 	xen_setup_dma_ops(dev);
 }
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index fcc987f5d4ed..9418808009ba 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1985,13 +1985,6 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
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
@@ -2646,7 +2639,6 @@ const struct iommu_ops amd_iommu_ops = {
 	.domain_alloc_user = amd_iommu_domain_alloc_user,
 	.probe_device = amd_iommu_probe_device,
 	.release_device = amd_iommu_release_device,
-	.probe_finalize = amd_iommu_probe_finalize,
 	.device_group = amd_iommu_device_group,
 	.get_resv_regions = amd_iommu_get_resv_regions,
 	.is_attach_deferred = amd_iommu_is_attach_deferred,
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 27a167f4cd3e..d808c8dcf5cb 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1724,25 +1724,20 @@ static const struct dma_map_ops iommu_dma_ops = {
 	.opt_mapping_size	= iommu_dma_opt_mapping_size,
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
@@ -1750,7 +1745,6 @@ void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
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
index 3531b956556c..f7347ed41e89 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4480,12 +4480,6 @@ static void intel_iommu_release_device(struct device *dev)
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
@@ -4937,7 +4931,6 @@ const struct iommu_ops intel_iommu_ops = {
 	.domain_alloc		= intel_iommu_domain_alloc,
 	.domain_alloc_user	= intel_iommu_domain_alloc_user,
 	.probe_device		= intel_iommu_probe_device,
-	.probe_finalize		= intel_iommu_probe_finalize,
 	.release_device		= intel_iommu_release_device,
 	.get_resv_regions	= intel_iommu_get_resv_regions,
 	.device_group		= intel_iommu_device_group,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 824989874dee..43f630d0530e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -560,10 +560,10 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 		if (list_empty(&group->entry))
 			list_add_tail(&group->entry, group_list);
 	}
-	mutex_unlock(&group->mutex);
 
-	if (dev_is_pci(dev))
-		iommu_dma_set_pci_32bit_workaround(dev);
+	iommu_setup_dma_ops(dev);
+
+	mutex_unlock(&group->mutex);
 
 	return 0;
 
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
index 9bcffdde6175..5a558456946b 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -998,15 +998,6 @@ static struct iommu_device *viommu_probe_device(struct device *dev)
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
@@ -1043,7 +1034,6 @@ static struct iommu_ops viommu_ops = {
 	.capable		= viommu_capable,
 	.domain_alloc		= viommu_domain_alloc,
 	.probe_device		= viommu_probe_device,
-	.probe_finalize		= viommu_probe_finalize,
 	.release_device		= viommu_release_device,
 	.device_group		= viommu_device_group,
 	.get_resv_regions	= viommu_get_resv_regions,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 20ed3a4fc5e0..3a3bf8afb8ca 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1283,9 +1283,6 @@ static inline void iommu_debugfs_setup(void) {}
 #ifdef CONFIG_IOMMU_DMA
 #include <linux/msi.h>
 
-/* Setup call for arch DMA mapping code */
-void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit);
-
 int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
 
 int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr);
@@ -1296,10 +1293,6 @@ void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_msg *msg);
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

