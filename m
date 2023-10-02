Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75607B549F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237552AbjJBNtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237527AbjJBNt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:49:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94706B7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 06:49:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB5E01474;
        Mon,  2 Oct 2023 06:50:03 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 81A533F762;
        Mon,  2 Oct 2023 06:49:24 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux.dev, jgg@nvidia.com, baolu.lu@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/7] iommu: Validate that devices match domains
Date:   Mon,  2 Oct 2023 14:49:11 +0100
Message-Id: <4dfa51b034327432793640189aa516038d3449e1.1696253096.git.robin.murphy@arm.com>
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

Before we can allow drivers to coexist, we need to make sure that one
driver's domain ops can't misinterpret another driver's dev_iommu_priv
data. To that end, add a token to the domain so we can remember how it
was allocated - for now this may as well be the device ops, since they
still correlate 1:1 with drivers. We can trust ourselves for internal
default domain attachment, so add checks to cover all the public attach
interfaces.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---

v4: Cover iommu_attach_device_pasid() as well, and improve robustness
    against theoretical attempts to attach a noiommu group.
---
 drivers/iommu/iommu.c | 10 ++++++++++
 include/linux/iommu.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ef7feb0acc34..7c79a58ef010 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2102,6 +2102,7 @@ static struct iommu_domain *__iommu_domain_alloc(const struct iommu_ops *ops,
 		return NULL;
 
 	domain->type = type;
+	domain->owner = ops;
 	/*
 	 * If not already set, assume all sizes by default; the driver
 	 * may override this later
@@ -2267,10 +2268,16 @@ struct iommu_domain *iommu_get_dma_domain(struct device *dev)
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
 
@@ -3468,6 +3475,9 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	if (!group)
 		return -ENODEV;
 
+	if (!dev_has_iommu(dev) || dev_iommu_ops(dev) != domain->owner)
+		return -EINVAL;
+
 	mutex_lock(&group->mutex);
 	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain, GFP_KERNEL);
 	if (curr) {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2d2802fb2c74..5c9560813d05 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -99,6 +99,7 @@ struct iommu_domain_geometry {
 struct iommu_domain {
 	unsigned type;
 	const struct iommu_domain_ops *ops;
+	const struct iommu_ops *owner; /* Whose domain_alloc we came from */
 	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
 	struct iommu_domain_geometry geometry;
 	struct iommu_dma_cookie *iova_cookie;
-- 
2.39.2.101.g768bb238c484.dirty

