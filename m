Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2C37A240E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbjIOQ6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbjIOQ6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:58:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B25319BC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:58:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CD391FB;
        Fri, 15 Sep 2023 09:59:05 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F037E3F5A1;
        Fri, 15 Sep 2023 09:58:26 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jgg@nvidia.com,
        baolu.lu@linux.intel.com
Subject: [PATCH v3 3/7] iommu: Validate that devices match domains
Date:   Fri, 15 Sep 2023 17:58:07 +0100
Message-Id: <d29334e44c0e6489629dbe13c969c47d4285a877.1694693889.git.robin.murphy@arm.com>
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

Before we can allow drivers to coexist, we need to make sure that one
driver's domain ops can't misinterpret another driver's dev_iommu_priv
data. To that end, add a token to the domain so we can remember how it
was allocated - for now this may as well be the device ops, since they
still correlate 1:1 with drivers. We can trust ourselves for internal
default domain attachment, so add the check where it covers both the
external attach interfaces.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iommu.c | 13 +++++++++----
 include/linux/iommu.h |  1 +
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 2f29ee9dea64..f4cc91227b22 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2000,26 +2000,28 @@ EXPORT_SYMBOL_GPL(iommu_set_fault_handler);
 static struct iommu_domain *__iommu_domain_alloc(const struct bus_type *bus,
 						 unsigned type)
 {
+	const struct iommu_ops *ops = bus ? bus->iommu_ops : NULL;
 	struct iommu_domain *domain;
 	unsigned int alloc_type = type & IOMMU_DOMAIN_ALLOC_FLAGS;
 
-	if (bus == NULL || bus->iommu_ops == NULL)
+	if (!ops)
 		return NULL;
 
-	domain = bus->iommu_ops->domain_alloc(alloc_type);
+	domain = ops->domain_alloc(alloc_type);
 	if (!domain)
 		return NULL;
 
 	domain->type = type;
+	domain->owner = ops;
 	/*
 	 * If not already set, assume all sizes by default; the driver
 	 * may override this later
 	 */
 	if (!domain->pgsize_bitmap)
-		domain->pgsize_bitmap = bus->iommu_ops->pgsize_bitmap;
+		domain->pgsize_bitmap = ops->pgsize_bitmap;
 
 	if (!domain->ops)
-		domain->ops = bus->iommu_ops->default_domain_ops;
+		domain->ops = ops->default_domain_ops;
 
 	if (iommu_is_dma_domain(domain) && iommu_get_dma_cookie(domain)) {
 		iommu_domain_free(domain);
@@ -2176,6 +2178,9 @@ static int __iommu_attach_group(struct iommu_domain *domain,
 	    group->domain != group->blocking_domain)
 		return -EBUSY;
 
+	if (dev_iommu_ops(iommu_group_first_dev(group)) != domain->owner)
+		return -EINVAL;
+
 	return __iommu_group_set_domain(group, domain);
 }
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a249e10c8e9f..75ffcac199e3 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -95,6 +95,7 @@ struct iommu_domain_geometry {
 struct iommu_domain {
 	unsigned type;
 	const struct iommu_domain_ops *ops;
+	const struct iommu_ops *owner; /* Whose domain_alloc we came from */
 	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
 	struct iommu_domain_geometry geometry;
 	struct iommu_dma_cookie *iova_cookie;
-- 
2.39.2.101.g768bb238c484.dirty

