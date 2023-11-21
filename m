Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03127F3594
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbjKUSFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbjKUSEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:04:44 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B94EF1710
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 10:04:18 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25AD316F2;
        Tue, 21 Nov 2023 10:05:05 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 595913F6C4;
        Tue, 21 Nov 2023 10:04:17 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux.dev, jgg@nvidia.com, baolu.lu@linux.intel.com,
        linux-kernel@vger.kernel.org, jsnitsel@redhat.com
Subject: [PATCH v6 3/7] iommu: Validate that devices match domains
Date:   Tue, 21 Nov 2023 18:03:59 +0000
Message-Id: <097c6f30480e4efe12195d00ba0e84ea4837fb4c.1700589539.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1700589539.git.robin.murphy@arm.com>
References: <cover.1700589539.git.robin.murphy@arm.com>
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

Before we can allow drivers to coexist, we need to make sure that one
driver's domain ops can't misinterpret another driver's dev_iommu_priv
data. To that end, add a token to the domain so we can remember how it
was allocated - for now this may as well be the device ops, since they
still correlate 1:1 with drivers. We can trust ourselves for internal
default domain attachment, so add checks to cover all the public attach
interfaces.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---

v4: Cover iommu_attach_device_pasid() as well, and improve robustness
    against theoretical attempts to attach a noiommu group.
v6: Cover new iommu_domain_alloc_user() sites as well. I don't entirely
    dislike the idea of tying this into the domain ops, but I'd rather
    do the simple thing for now and revisit that in future, since domain
    ops also deserve some other cleanup.
---
 drivers/iommu/iommu.c                | 10 ++++++++++
 drivers/iommu/iommufd/hw_pagetable.c |  2 ++
 include/linux/iommu.h                |  2 +-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7fafd073c33e..8e4436c606d3 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2117,6 +2117,7 @@ static struct iommu_domain *__iommu_domain_alloc(const struct iommu_ops *ops,
 		return NULL;
 
 	domain->type = type;
+	domain->owner = ops;
 	/*
 	 * If not already set, assume all sizes by default; the driver
 	 * may override this later
@@ -2282,10 +2283,16 @@ struct iommu_domain *iommu_get_dma_domain(struct device *dev)
 static int __iommu_attach_group(struct iommu_domain *domain,
 				struct iommu_group *group)
 {
+	struct device *dev;
+
 	if (group->domain && group->domain != group->default_domain &&
 	    group->domain != group->blocking_domain)
 		return -EBUSY;
 
+	dev = iommu_group_first_dev(group);
+	if (!dev_has_iommu(dev) || dev_iommu_ops(dev) != domain->owner)
+		return -EINVAL;
+
 	return __iommu_group_set_domain(group, domain);
 }
 
@@ -3477,6 +3484,9 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	if (!group)
 		return -ENODEV;
 
+	if (!dev_has_iommu(dev) || dev_iommu_ops(dev) != domain->owner)
+		return -EINVAL;
+
 	mutex_lock(&group->mutex);
 	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain, GFP_KERNEL);
 	if (curr) {
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 2abbeafdbd22..5be7f513b622 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -135,6 +135,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			hwpt->domain = NULL;
 			goto out_abort;
 		}
+		hwpt->domain->owner = ops;
 	} else {
 		hwpt->domain = iommu_domain_alloc(idev->dev->bus);
 		if (!hwpt->domain) {
@@ -233,6 +234,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 		hwpt->domain = NULL;
 		goto out_abort;
 	}
+	hwpt->domain->owner = ops;
 
 	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED)) {
 		rc = -EINVAL;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 7d87423663d4..51b18a4b5834 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -106,7 +106,7 @@ struct iommu_domain {
 	unsigned type;
 	const struct iommu_domain_ops *ops;
 	const struct iommu_dirty_ops *dirty_ops;
-
+	const struct iommu_ops *owner; /* Whose domain_alloc we came from */
 	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
 	struct iommu_domain_geometry geometry;
 	struct iommu_dma_cookie *iova_cookie;
-- 
2.39.2.101.g768bb238c484.dirty

