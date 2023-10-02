Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C877B5481
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237546AbjJBNti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237515AbjJBNta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:49:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E0A9D9
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 06:49:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D950CC15;
        Mon,  2 Oct 2023 06:50:04 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8FC013F762;
        Mon,  2 Oct 2023 06:49:25 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux.dev, jgg@nvidia.com, baolu.lu@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/7] iommu: Switch __iommu_domain_alloc() to device ops
Date:   Mon,  2 Oct 2023 14:49:12 +0100
Message-Id: <458dd0ed839541693a49da33239b33cf4c48b8ec.1696253096.git.robin.murphy@arm.com>
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
v4: Reinstate correct bus_for_each_dev() handling from v2
---
 drivers/iommu/iommu.c | 48 ++++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7c79a58ef010..c5b5408d1dd7 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -95,8 +95,8 @@ static const char * const iommu_group_resv_type_string[] = {
 static int iommu_bus_notifier(struct notifier_block *nb,
 			      unsigned long action, void *data);
 static void iommu_release_device(struct device *dev);
-static struct iommu_domain *
-__iommu_group_domain_alloc(struct iommu_group *group, unsigned int type);
+static struct iommu_domain *__iommu_domain_alloc(struct device *dev,
+						 unsigned type);
 static int __iommu_attach_device(struct iommu_domain *domain,
 				 struct device *dev);
 static int __iommu_attach_group(struct iommu_domain *domain,
@@ -1763,7 +1763,7 @@ __iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
 {
 	if (group->default_domain && group->default_domain->type == req_type)
 		return group->default_domain;
-	return __iommu_group_domain_alloc(group, req_type);
+	return __iommu_domain_alloc(iommu_group_first_dev(group), req_type);
 }
 
 /*
@@ -2082,10 +2082,10 @@ void iommu_set_fault_handler(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_set_fault_handler);
 
-static struct iommu_domain *__iommu_domain_alloc(const struct iommu_ops *ops,
-						 struct device *dev,
-						 unsigned int type)
+static struct iommu_domain *__iommu_domain_alloc(struct device *dev,
+						 unsigned type)
 {
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 	struct iommu_domain *domain;
 	unsigned int alloc_type = type & IOMMU_DOMAIN_ALLOC_FLAGS;
 
@@ -2120,20 +2120,30 @@ static struct iommu_domain *__iommu_domain_alloc(const struct iommu_ops *ops,
 	return domain;
 }
 
-static struct iommu_domain *
-__iommu_group_domain_alloc(struct iommu_group *group, unsigned int type)
+static int __iommu_domain_alloc_dev(struct device *dev, void *data)
 {
-	struct device *dev = iommu_group_first_dev(group);
+	struct device **alloc_dev = data;
 
-	return __iommu_domain_alloc(dev_iommu_ops(dev), dev, type);
+	if (!dev_has_iommu(dev))
+		return 0;
+
+	WARN_ONCE(*alloc_dev && dev_iommu_ops(dev) != dev_iommu_ops(*alloc_dev),
+		  "Multiple IOMMU drivers present, which the public IOMMU API can't fully support yet. You may still need to disable one or more to get the expected result here, sorry!\n");
+
+	*alloc_dev = dev;
+	return 0;
 }
 
 struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus)
 {
-	if (bus == NULL || bus->iommu_ops == NULL)
+	struct device *dev = NULL;
+
+	/* We always check the whole bus, so the return value isn't useful */
+	bus_for_each_dev(bus, NULL, &dev, __iommu_domain_alloc_dev);
+	if (!dev)
 		return NULL;
-	return __iommu_domain_alloc(bus->iommu_ops, NULL,
-				    IOMMU_DOMAIN_UNMANAGED);
+
+	return __iommu_domain_alloc(dev, IOMMU_DOMAIN_UNMANAGED);
 }
 EXPORT_SYMBOL_GPL(iommu_domain_alloc);
 
@@ -3256,18 +3266,22 @@ void iommu_device_unuse_default_domain(struct device *dev)
 
 static int __iommu_group_alloc_blocking_domain(struct iommu_group *group)
 {
+	struct device *dev = iommu_group_first_dev(group);
+
 	if (group->blocking_domain)
 		return 0;
 
-	group->blocking_domain =
-		__iommu_group_domain_alloc(group, IOMMU_DOMAIN_BLOCKED);
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
-		group->blocking_domain = __iommu_group_domain_alloc(
-			group, IOMMU_DOMAIN_UNMANAGED);
+		group->blocking_domain = __iommu_domain_alloc(dev, IOMMU_DOMAIN_UNMANAGED);
 		if (!group->blocking_domain)
 			return -EINVAL;
 	}
-- 
2.39.2.101.g768bb238c484.dirty

