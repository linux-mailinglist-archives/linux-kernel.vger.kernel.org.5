Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E057A2410
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbjIOQ6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234662AbjIOQ6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:58:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 386F819BC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:58:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C1FB139F;
        Fri, 15 Sep 2023 09:59:07 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DCAF13F5A1;
        Fri, 15 Sep 2023 09:58:28 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jgg@nvidia.com,
        baolu.lu@linux.intel.com
Subject: [PATCH v3 4/7] iommu: Switch __iommu_domain_alloc() to device ops
Date:   Fri, 15 Sep 2023 17:58:08 +0100
Message-Id: <404d8395cf4252c6fe6d98f317f3570127451778.1694693889.git.robin.murphy@arm.com>
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

In all the places we allocate default domains, we have (or can easily
get hold of) a device from which to resolve the right IOMMU ops; only
the public iommu_domain_alloc() interface actually depends on bus ops.
Reworking the public API is a big enough mission in its own right, but
in the meantime we can still decouple it from bus ops internally to move
forward.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---

v3: Make sure blocking domains are covered as well
---
 drivers/iommu/iommu.c | 50 +++++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f4cc91227b22..29ebb4b57df4 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -96,7 +96,7 @@ static const char * const iommu_group_resv_type_string[] = {
 static int iommu_bus_notifier(struct notifier_block *nb,
 			      unsigned long action, void *data);
 static void iommu_release_device(struct device *dev);
-static struct iommu_domain *__iommu_domain_alloc(const struct bus_type *bus,
+static struct iommu_domain *__iommu_domain_alloc(struct device *dev,
 						 unsigned type);
 static int __iommu_attach_device(struct iommu_domain *domain,
 				 struct device *dev);
@@ -1745,12 +1745,11 @@ static int iommu_get_def_domain_type(struct device *dev)
 }
 
 static struct iommu_domain *
-__iommu_group_alloc_default_domain(const struct bus_type *bus,
-				   struct iommu_group *group, int req_type)
+__iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
 {
 	if (group->default_domain && group->default_domain->type == req_type)
 		return group->default_domain;
-	return __iommu_domain_alloc(bus, req_type);
+	return __iommu_domain_alloc(iommu_group_first_dev(group), req_type);
 }
 
 /*
@@ -1760,23 +1759,22 @@ __iommu_group_alloc_default_domain(const struct bus_type *bus,
 static struct iommu_domain *
 iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
 {
-	const struct bus_type *bus = iommu_group_first_dev(group)->bus;
 	struct iommu_domain *dom;
 
 	lockdep_assert_held(&group->mutex);
 
 	if (req_type)
-		return __iommu_group_alloc_default_domain(bus, group, req_type);
+		return __iommu_group_alloc_default_domain(group, req_type);
 
 	/* The driver gave no guidance on what type to use, try the default */
-	dom = __iommu_group_alloc_default_domain(bus, group, iommu_def_domain_type);
+	dom = __iommu_group_alloc_default_domain(group, iommu_def_domain_type);
 	if (dom)
 		return dom;
 
 	/* Otherwise IDENTITY and DMA_FQ defaults will try DMA */
 	if (iommu_def_domain_type == IOMMU_DOMAIN_DMA)
 		return NULL;
-	dom = __iommu_group_alloc_default_domain(bus, group, IOMMU_DOMAIN_DMA);
+	dom = __iommu_group_alloc_default_domain(group, IOMMU_DOMAIN_DMA);
 	if (!dom)
 		return NULL;
 
@@ -1997,16 +1995,13 @@ void iommu_set_fault_handler(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_set_fault_handler);
 
-static struct iommu_domain *__iommu_domain_alloc(const struct bus_type *bus,
+static struct iommu_domain *__iommu_domain_alloc(struct device *dev,
 						 unsigned type)
 {
-	const struct iommu_ops *ops = bus ? bus->iommu_ops : NULL;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 	struct iommu_domain *domain;
 	unsigned int alloc_type = type & IOMMU_DOMAIN_ALLOC_FLAGS;
 
-	if (!ops)
-		return NULL;
-
 	domain = ops->domain_alloc(alloc_type);
 	if (!domain)
 		return NULL;
@@ -2030,9 +2025,28 @@ static struct iommu_domain *__iommu_domain_alloc(const struct bus_type *bus,
 	return domain;
 }
 
+static int __iommu_domain_alloc_dev(struct device *dev, void *data)
+{
+	struct device **alloc_dev = data;
+
+	if (!dev_has_iommu(dev))
+		return 0;
+
+	WARN_ONCE(*alloc_dev && dev_iommu_ops(dev) != dev_iommu_ops(*alloc_dev),
+		  "Multiple IOMMU drivers present, which the public IOMMU API can't fully support yet. You may still need to disable one or more to get the expected result here, sorry!\n");
+
+	*alloc_dev = dev;
+	return 0;
+}
+
 struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus)
 {
-	return __iommu_domain_alloc(bus, IOMMU_DOMAIN_UNMANAGED);
+	struct device *dev = NULL;
+
+	if (bus_for_each_dev(bus, NULL, &dev, __iommu_domain_alloc_dev))
+		return NULL;
+
+	return __iommu_domain_alloc(dev, IOMMU_DOMAIN_UNMANAGED);
 }
 EXPORT_SYMBOL_GPL(iommu_domain_alloc);
 
@@ -3228,13 +3242,17 @@ static int __iommu_group_alloc_blocking_domain(struct iommu_group *group)
 	if (group->blocking_domain)
 		return 0;
 
-	group->blocking_domain = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_BLOCKED);
+	/* noiommu groups should never be here */
+	if (WARN_ON(!dev_has_iommu(dev)))
+		return -ENODEV;
+
+	group->blocking_domain = __iommu_domain_alloc(dev, IOMMU_DOMAIN_BLOCKED);
 	if (!group->blocking_domain) {
 		/*
 		 * For drivers that do not yet understand IOMMU_DOMAIN_BLOCKED
 		 * create an empty domain instead.
 		 */
-		group->blocking_domain = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_UNMANAGED);
+		group->blocking_domain = __iommu_domain_alloc(dev, IOMMU_DOMAIN_UNMANAGED);
 		if (!group->blocking_domain)
 			return -EINVAL;
 	}
-- 
2.39.2.101.g768bb238c484.dirty

