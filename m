Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C757A2412
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjIOQ7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbjIOQ6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:58:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5D6C2126
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:58:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9FDF1FB;
        Fri, 15 Sep 2023 09:59:13 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0FA203F5A1;
        Fri, 15 Sep 2023 09:58:34 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jgg@nvidia.com,
        baolu.lu@linux.intel.com,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 6/7] iommu: Retire bus ops
Date:   Fri, 15 Sep 2023 17:58:10 +0100
Message-Id: <c43f24d2fce3f4e02bc9056a30021ee45e19e35b.1694693889.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1694693889.git.robin.murphy@arm.com>
References: <cover.1694693889.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the rest of the API internals converted, it's time to finally
tackle probe_device and how we bootstrap the per-device ops association
to begin with. This ends up being disappointingly straightforward, since
fwspec users are already doing it in order to find their of_xlate
callback, and it works out that we can easily do the equivalent for
other drivers too. Then shuffle the remaining awareness of iommu_ops
into the couple of core headers that still need it, and breathe a sigh
of relief.

Ding dong the bus ops are gone!

CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Christoph Hellwig <hch@lst.de>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iommu.c       | 30 ++++++++++++++++++------------
 include/acpi/acpi_bus.h     |  2 ++
 include/linux/device.h      |  1 -
 include/linux/device/bus.h  |  5 -----
 include/linux/dma-map-ops.h |  1 +
 5 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 29ebb4b57df4..d38c3023887a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -149,7 +149,7 @@ struct iommu_group_attribute iommu_group_attr_##_name =		\
 static LIST_HEAD(iommu_device_list);
 static DEFINE_SPINLOCK(iommu_device_lock);
 
-static struct bus_type * const iommu_buses[] = {
+static const struct bus_type * const iommu_buses[] = {
 	&platform_bus_type,
 #ifdef CONFIG_PCI
 	&pci_bus_type,
@@ -256,13 +256,6 @@ int iommu_device_register(struct iommu_device *iommu,
 	/* We need to be able to take module references appropriately */
 	if (WARN_ON(is_module_address((unsigned long)ops) && !ops->owner))
 		return -EINVAL;
-	/*
-	 * Temporarily enforce global restriction to a single driver. This was
-	 * already the de-facto behaviour, since any possible combination of
-	 * existing drivers would compete for at least the PCI or platform bus.
-	 */
-	if (iommu_buses[0]->iommu_ops && iommu_buses[0]->iommu_ops != ops)
-		return -EBUSY;
 
 	iommu->ops = ops;
 	if (hwdev)
@@ -272,10 +265,8 @@ int iommu_device_register(struct iommu_device *iommu,
 	list_add_tail(&iommu->list, &iommu_device_list);
 	spin_unlock(&iommu_device_lock);
 
-	for (int i = 0; i < ARRAY_SIZE(iommu_buses) && !err; i++) {
-		iommu_buses[i]->iommu_ops = ops;
+	for (int i = 0; i < ARRAY_SIZE(iommu_buses) && !err; i++)
 		err = bus_iommu_probe(iommu_buses[i]);
-	}
 	if (err)
 		iommu_device_unregister(iommu);
 	return err;
@@ -490,12 +481,27 @@ static void iommu_deinit_device(struct device *dev)
 
 static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops;
+	struct iommu_fwspec *fwspec;
 	struct iommu_group *group;
 	static DEFINE_MUTEX(iommu_probe_device_lock);
 	struct group_device *gdev;
 	int ret;
 
+	/*
+	 * For FDT-based systems and ACPI IORT/VIOT, drivers register IOMMU
+	 * instances with non-NULL fwnodes, and client devices should have been
+	 * identified with a fwspec by this point. Otherwise, we can currently
+	 * assume that only one of Intel, AMD, s390, PAMU or legacy SMMUv2 can
+	 * be present, and that any of their registered instances has suitable
+	 * ops for probing, and thus cheekily co-opt the same mechanism.
+	 */
+	fwspec = dev_iommu_fwspec_get(dev);
+	if (fwspec && fwspec->ops)
+		ops = fwspec->ops;
+	else
+		ops = iommu_ops_from_fwnode(NULL);
+
 	if (!ops)
 		return -ENODEV;
 	/*
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 254685085c82..13d959b3ba29 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -623,6 +623,8 @@ struct acpi_pci_root {
 
 /* helper */
 
+struct iommu_ops;
+
 bool acpi_dma_supported(const struct acpi_device *adev);
 enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev);
 int acpi_iommu_fwspec_init(struct device *dev, u32 id,
diff --git a/include/linux/device.h b/include/linux/device.h
index 56d93a1ffb7b..b78e66f3b34a 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -42,7 +42,6 @@ struct class;
 struct subsys_private;
 struct device_node;
 struct fwnode_handle;
-struct iommu_ops;
 struct iommu_group;
 struct dev_pin_info;
 struct dev_iommu;
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index ae10c4322754..e25aab08f873 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -62,9 +62,6 @@ struct fwnode_handle;
  *			this bus.
  * @pm:		Power management operations of this bus, callback the specific
  *		device driver's pm-ops.
- * @iommu_ops:  IOMMU specific operations for this bus, used to attach IOMMU
- *              driver implementations to a bus and allow the driver to do
- *              bus-specific setup
  * @need_parent_lock:	When probing or removing a device on this bus, the
  *			device core should lock the device's parent.
  *
@@ -104,8 +101,6 @@ struct bus_type {
 
 	const struct dev_pm_ops *pm;
 
-	const struct iommu_ops *iommu_ops;
-
 	bool need_parent_lock;
 };
 
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index f2fc203fb8a1..a52e508d1869 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 
 struct cma;
+struct iommu_ops;
 
 /*
  * Values for struct dma_map_ops.flags:
-- 
2.39.2.101.g768bb238c484.dirty

