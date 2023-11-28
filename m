Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9F47FB842
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344296AbjK1KmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbjK1KmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:42:14 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D628D45
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:42:19 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7A151692;
        Tue, 28 Nov 2023 02:43:06 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6B8FF3F73F;
        Tue, 28 Nov 2023 02:42:18 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, jgg@ziepe.ca, kevin.tian@intel.com
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iommufd/selftest: Use normal IOMMU registration
Date:   Tue, 28 Nov 2023 10:42:12 +0000
Message-Id: <44ee6854da69e86b208f49752f60a4c18205c32a.1701165201.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1701165201.git.robin.murphy@arm.com>
References: <cover.1701165201.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IOMMU core now supports coexistence of fwspec-based drivers, which
the mock driver now is, so let's bring the mock bus into iommu_buses,
drop the special interface, and use the normal registration flow. The
one concession we have to make is to ensure that the mock bus is
registered early enough so that bus_for_each_dev() doesn't error out
for other IOMMU drivers registering before iommufd_test_init() runs.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iommu-priv.h           |  7 -----
 drivers/iommu/iommu.c                | 46 +++-------------------------
 drivers/iommu/iommufd/iommufd_test.h |  2 ++
 drivers/iommu/iommufd/selftest.c     | 36 ++++++++--------------
 4 files changed, 18 insertions(+), 73 deletions(-)

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index 2024a2313348..663bd4fa166f 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -20,11 +20,4 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
 int iommu_group_replace_domain(struct iommu_group *group,
 			       struct iommu_domain *new_domain);
 
-int iommu_device_register_bus(struct iommu_device *iommu,
-			      const struct iommu_ops *ops, struct bus_type *bus,
-			      struct notifier_block *nb);
-void iommu_device_unregister_bus(struct iommu_device *iommu,
-				 struct bus_type *bus,
-				 struct notifier_block *nb);
-
 #endif /* __LINUX_IOMMU_PRIV_H */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 824989874dee..559999cfd9d4 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -35,8 +35,8 @@
 
 #include "dma-iommu.h"
 #include "iommu-priv.h"
-
 #include "iommu-sva.h"
+#include "iommufd/iommufd_test.h"
 
 static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
@@ -165,6 +165,9 @@ static const struct bus_type * const iommu_buses[] = {
 #ifdef CONFIG_CDX_BUS
 	&cdx_bus_type,
 #endif
+#ifdef CONFIG_IOMMUFD_TEST
+	&iommufd_mock_bus_type,
+#endif
 };
 
 /*
@@ -289,47 +292,6 @@ void iommu_device_unregister(struct iommu_device *iommu)
 }
 EXPORT_SYMBOL_GPL(iommu_device_unregister);
 
-#if IS_ENABLED(CONFIG_IOMMUFD_TEST)
-void iommu_device_unregister_bus(struct iommu_device *iommu,
-				 struct bus_type *bus,
-				 struct notifier_block *nb)
-{
-	bus_unregister_notifier(bus, nb);
-	iommu_device_unregister(iommu);
-}
-EXPORT_SYMBOL_GPL(iommu_device_unregister_bus);
-
-/*
- * Register an iommu driver against a single bus. This is only used by iommufd
- * selftest to create a mock iommu driver. The caller must provide
- * some memory to hold a notifier_block.
- */
-int iommu_device_register_bus(struct iommu_device *iommu,
-			      const struct iommu_ops *ops, struct bus_type *bus,
-			      struct notifier_block *nb)
-{
-	int err;
-
-	iommu->ops = ops;
-	nb->notifier_call = iommu_bus_notifier;
-	err = bus_register_notifier(bus, nb);
-	if (err)
-		return err;
-
-	spin_lock(&iommu_device_lock);
-	list_add_tail(&iommu->list, &iommu_device_list);
-	spin_unlock(&iommu_device_lock);
-
-	err = bus_iommu_probe(bus);
-	if (err) {
-		iommu_device_unregister_bus(iommu, bus, nb);
-		return err;
-	}
-	return 0;
-}
-EXPORT_SYMBOL_GPL(iommu_device_register_bus);
-#endif
-
 static struct dev_iommu *dev_iommu_get(struct device *dev)
 {
 	struct dev_iommu *param = dev->iommu;
diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 7910fbe1962d..a2d2c55a9315 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -148,4 +148,6 @@ struct iommu_hwpt_selftest {
 	__u32 iotlb;
 };
 
+extern struct bus_type iommufd_mock_bus_type;
+
 #endif
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index f46ce0f8808d..bb09abb5bcbb 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -530,15 +530,8 @@ get_md_pagetable_nested(struct iommufd_ucmd *ucmd, u32 mockpt_id,
 	return hwpt;
 }
 
-struct mock_bus_type {
-	struct bus_type bus;
-	struct notifier_block nb;
-};
-
-static struct mock_bus_type iommufd_mock_bus_type = {
-	.bus = {
-		.name = "iommufd_mock",
-	},
+struct bus_type iommufd_mock_bus_type = {
+	.name = "iommufd_mock",
 };
 
 static atomic_t mock_dev_num;
@@ -566,7 +559,7 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 	device_initialize(&mdev->dev);
 	mdev->flags = dev_flags;
 	mdev->dev.release = mock_dev_release;
-	mdev->dev.bus = &iommufd_mock_bus_type.bus;
+	mdev->dev.bus = &iommufd_mock_bus_type;
 
 	rc = dev_set_name(&mdev->dev, "iommufd_mock%u",
 			  atomic_inc_return(&mock_dev_num));
@@ -1327,6 +1320,12 @@ bool iommufd_should_fail(void)
 	return should_fail(&fail_iommufd, 1);
 }
 
+int __init iommufd_bus_init(void)
+{
+	return bus_register(&iommufd_mock_bus_type);
+}
+subsys_initcall(iommufd_bus_init);
+
 int __init iommufd_test_init(void)
 {
 	struct platform_device_info pdevinfo = {
@@ -1343,27 +1342,19 @@ int __init iommufd_test_init(void)
 		goto err_dbgfs;
 	}
 
-	rc = bus_register(&iommufd_mock_bus_type.bus);
-	if (rc)
-		goto err_platform;
-
 	rc = iommu_device_sysfs_add(&mock_iommu_device,
 				    &selftest_iommu_dev->dev, NULL, "%s",
 				    dev_name(&selftest_iommu_dev->dev));
 	if (rc)
-		goto err_bus;
+		goto err_platform;
 
-	rc = iommu_device_register_bus(&mock_iommu_device, &mock_ops,
-				  &iommufd_mock_bus_type.bus,
-				  &iommufd_mock_bus_type.nb);
+	rc = iommu_device_register(&mock_iommu_device, &mock_ops, NULL);
 	if (rc)
 		goto err_sysfs;
 	return 0;
 
 err_sysfs:
 	iommu_device_sysfs_remove(&mock_iommu_device);
-err_bus:
-	bus_unregister(&iommufd_mock_bus_type.bus);
 err_platform:
 	platform_device_unregister(selftest_iommu_dev);
 err_dbgfs:
@@ -1374,10 +1365,7 @@ int __init iommufd_test_init(void)
 void iommufd_test_exit(void)
 {
 	iommu_device_sysfs_remove(&mock_iommu_device);
-	iommu_device_unregister_bus(&mock_iommu_device,
-				    &iommufd_mock_bus_type.bus,
-				    &iommufd_mock_bus_type.nb);
-	bus_unregister(&iommufd_mock_bus_type.bus);
+	iommu_device_unregister(&mock_iommu_device);
 	platform_device_unregister(selftest_iommu_dev);
 	debugfs_remove_recursive(dbgfs_root);
 }
-- 
2.39.2.101.g768bb238c484.dirty

