Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75ECC7A240C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbjIOQ6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbjIOQ63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:58:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91805211E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:58:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A023C15;
        Fri, 15 Sep 2023 09:59:00 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2912D3F5A1;
        Fri, 15 Sep 2023 09:58:22 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jgg@nvidia.com,
        baolu.lu@linux.intel.com
Subject: [PATCH v3 1/7] iommu: Factor out some helpers
Date:   Fri, 15 Sep 2023 17:58:05 +0100
Message-Id: <a24acdd821a87ddab2ed4f5dc4e5ba047e126404.1694693889.git.robin.murphy@arm.com>
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
---
 drivers/iommu/iommu.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3bfc56df4f78..4566d0001cd3 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -363,6 +363,15 @@ static void dev_iommu_free(struct device *dev)
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
@@ -614,7 +623,7 @@ static void __iommu_group_remove_device(struct device *dev)
 
 		list_del(&device->list);
 		__iommu_group_free_device(group, device);
-		if (dev->iommu && dev->iommu->iommu_dev)
+		if (dev_has_iommu(dev))
 			iommu_deinit_device(dev);
 		else
 			dev->iommu_group = NULL;
@@ -1218,6 +1227,12 @@ void iommu_group_remove_device(struct device *dev)
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
@@ -1745,9 +1760,7 @@ __iommu_group_alloc_default_domain(const struct bus_type *bus,
 static struct iommu_domain *
 iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
 {
-	const struct bus_type *bus =
-		list_first_entry(&group->devices, struct group_device, list)
-			->dev->bus;
+	const struct bus_type *bus = iommu_group_first_dev(group)->bus;
 	struct iommu_domain *dom;
 
 	lockdep_assert_held(&group->mutex);
@@ -1912,7 +1925,7 @@ bool device_iommu_capable(struct device *dev, enum iommu_cap cap)
 {
 	const struct iommu_ops *ops;
 
-	if (!dev->iommu || !dev->iommu->iommu_dev)
+	if (!dev_has_iommu(dev))
 		return false;
 
 	ops = dev_iommu_ops(dev);
@@ -2903,8 +2916,8 @@ EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
  */
 int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features feat)
 {
-	if (dev->iommu && dev->iommu->iommu_dev) {
-		const struct iommu_ops *ops = dev->iommu->iommu_dev->ops;
+	if (dev_has_iommu(dev)) {
+		const struct iommu_ops *ops = dev_iommu_ops(dev);
 
 		if (ops->dev_enable_feat)
 			return ops->dev_enable_feat(dev, feat);
@@ -2919,8 +2932,8 @@ EXPORT_SYMBOL_GPL(iommu_dev_enable_feature);
  */
 int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
 {
-	if (dev->iommu && dev->iommu->iommu_dev) {
-		const struct iommu_ops *ops = dev->iommu->iommu_dev->ops;
+	if (dev_has_iommu(dev)) {
+		const struct iommu_ops *ops = dev_iommu_ops(dev);
 
 		if (ops->dev_disable_feat)
 			return ops->dev_disable_feat(dev, feat);
@@ -3190,21 +3203,18 @@ void iommu_device_unuse_default_domain(struct device *dev)
 
 static int __iommu_group_alloc_blocking_domain(struct iommu_group *group)
 {
-	struct group_device *dev =
-		list_first_entry(&group->devices, struct group_device, list);
+	struct device *dev = iommu_group_first_dev(group);
 
 	if (group->blocking_domain)
 		return 0;
 
-	group->blocking_domain =
-		__iommu_domain_alloc(dev->dev->bus, IOMMU_DOMAIN_BLOCKED);
+	group->blocking_domain = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_BLOCKED);
 	if (!group->blocking_domain) {
 		/*
 		 * For drivers that do not yet understand IOMMU_DOMAIN_BLOCKED
 		 * create an empty domain instead.
 		 */
-		group->blocking_domain = __iommu_domain_alloc(
-			dev->dev->bus, IOMMU_DOMAIN_UNMANAGED);
+		group->blocking_domain = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_UNMANAGED);
 		if (!group->blocking_domain)
 			return -EINVAL;
 	}
-- 
2.39.2.101.g768bb238c484.dirty

