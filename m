Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C440A7B54B7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237520AbjJBNt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237515AbjJBNt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:49:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 774BCB0
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 06:49:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF49BDA7;
        Mon,  2 Oct 2023 06:50:01 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 658D23F762;
        Mon,  2 Oct 2023 06:49:22 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux.dev, jgg@nvidia.com, baolu.lu@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/7] iommu: Factor out some helpers
Date:   Mon,  2 Oct 2023 14:49:09 +0100
Message-Id: <e55b277bb433d115eede2318a13c0e57c94d61b7.1696253096.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1696253096.git.robin.murphy@arm.com>
References: <cover.1696253096.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pattern for picking the first device out of the group list is
repeated a few times now, so it's clearly worth factoring out, which
also helps hide the iommu_group_dev detail from places that don't need
to know. Similarly, the safety check for dev_iommu_ops() at certain
public interfaces starts looking a bit repetitive, and might not be
completely obvious at first glance, so let's factor that out for clarity
as well, in preparation for more uses of both.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---

v3: Rename dev_iommu_ops_valid() to reflect what it's actually checking,
    rather than an implied consequence.
v4: Rebase, also catch the sneaky one in iommu_get_group_resv_regions()
    which wasn't the full pattern (but really should be since it guards
    the dev_iommu_ops() invocation in iommu_get_resv_regions()).
---
 drivers/iommu/iommu.c | 56 ++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 1ecac2b5c54f..f7793d1b5c3e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -368,6 +368,15 @@ static void dev_iommu_free(struct device *dev)
 	kfree(param);
 }
 
+/*
+ * Internal equivalent of device_iommu_mapped() for when we care that a device
+ * actually has API ops, and don't want false positives from VFIO-only groups.
+ */
+static bool dev_has_iommu(struct device *dev)
+{
+	return dev->iommu && dev->iommu->iommu_dev;
+}
+
 static u32 dev_iommu_get_max_pasids(struct device *dev)
 {
 	u32 max_pasids = 0, bits = 0;
@@ -620,7 +629,7 @@ static void __iommu_group_remove_device(struct device *dev)
 
 		list_del(&device->list);
 		__iommu_group_free_device(group, device);
-		if (dev->iommu && dev->iommu->iommu_dev)
+		if (dev_has_iommu(dev))
 			iommu_deinit_device(dev);
 		else
 			dev->iommu_group = NULL;
@@ -819,7 +828,7 @@ int iommu_get_group_resv_regions(struct iommu_group *group,
 		 * Non-API groups still expose reserved_regions in sysfs,
 		 * so filter out calls that get here that way.
 		 */
-		if (!device->dev->iommu)
+		if (!dev_has_iommu(device->dev))
 			break;
 
 		INIT_LIST_HEAD(&dev_resv_regions);
@@ -1224,6 +1233,12 @@ void iommu_group_remove_device(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_group_remove_device);
 
+static struct device *iommu_group_first_dev(struct iommu_group *group)
+{
+	lockdep_assert_held(&group->mutex);
+	return list_first_entry(&group->devices, struct group_device, list)->dev;
+}
+
 /**
  * iommu_group_for_each_dev - iterate over each device in the group
  * @group: the group
@@ -1751,23 +1766,6 @@ __iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
 	return __iommu_group_domain_alloc(group, req_type);
 }
 
-/*
- * Returns the iommu_ops for the devices in an iommu group.
- *
- * It is assumed that all devices in an iommu group are managed by a single
- * IOMMU unit. Therefore, this returns the dev_iommu_ops of the first device
- * in the group.
- */
-static const struct iommu_ops *group_iommu_ops(struct iommu_group *group)
-{
-	struct group_device *device =
-		list_first_entry(&group->devices, struct group_device, list);
-
-	lockdep_assert_held(&group->mutex);
-
-	return dev_iommu_ops(device->dev);
-}
-
 /*
  * req_type of 0 means "auto" which means to select a domain based on
  * iommu_def_domain_type or what the driver actually supports.
@@ -1775,7 +1773,7 @@ static const struct iommu_ops *group_iommu_ops(struct iommu_group *group)
 static struct iommu_domain *
 iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
 {
-	const struct iommu_ops *ops = group_iommu_ops(group);
+	const struct iommu_ops *ops = dev_iommu_ops(iommu_group_first_dev(group));
 	struct iommu_domain *dom;
 
 	lockdep_assert_held(&group->mutex);
@@ -1853,7 +1851,7 @@ static int iommu_bus_notifier(struct notifier_block *nb,
 static int iommu_get_def_domain_type(struct iommu_group *group,
 				     struct device *dev, int cur_type)
 {
-	const struct iommu_ops *ops = group_iommu_ops(group);
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 	int type;
 
 	if (!ops->def_domain_type)
@@ -2008,7 +2006,7 @@ bool device_iommu_capable(struct device *dev, enum iommu_cap cap)
 {
 	const struct iommu_ops *ops;
 
-	if (!dev->iommu || !dev->iommu->iommu_dev)
+	if (!dev_has_iommu(dev))
 		return false;
 
 	ops = dev_iommu_ops(dev);
@@ -2105,11 +2103,9 @@ static struct iommu_domain *__iommu_domain_alloc(const struct iommu_ops *ops,
 static struct iommu_domain *
 __iommu_group_domain_alloc(struct iommu_group *group, unsigned int type)
 {
-	struct device *dev =
-		list_first_entry(&group->devices, struct group_device, list)
-			->dev;
+	struct device *dev = iommu_group_first_dev(group);
 
-	return __iommu_domain_alloc(group_iommu_ops(group), dev, type);
+	return __iommu_domain_alloc(dev_iommu_ops(dev), dev, type);
 }
 
 struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus)
@@ -2960,8 +2956,8 @@ EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
  */
 int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features feat)
 {
-	if (dev->iommu && dev->iommu->iommu_dev) {
-		const struct iommu_ops *ops = dev->iommu->iommu_dev->ops;
+	if (dev_has_iommu(dev)) {
+		const struct iommu_ops *ops = dev_iommu_ops(dev);
 
 		if (ops->dev_enable_feat)
 			return ops->dev_enable_feat(dev, feat);
@@ -2976,8 +2972,8 @@ EXPORT_SYMBOL_GPL(iommu_dev_enable_feature);
  */
 int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
 {
-	if (dev->iommu && dev->iommu->iommu_dev) {
-		const struct iommu_ops *ops = dev->iommu->iommu_dev->ops;
+	if (dev_has_iommu(dev)) {
+		const struct iommu_ops *ops = dev_iommu_ops(dev);
 
 		if (ops->dev_disable_feat)
 			return ops->dev_disable_feat(dev, feat);
-- 
2.39.2.101.g768bb238c484.dirty

