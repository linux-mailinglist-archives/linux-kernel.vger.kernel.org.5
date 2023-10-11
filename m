Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1397C5B07
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbjJKSPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbjJKSPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:15:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C69BC9E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:15:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 545E8150C;
        Wed, 11 Oct 2023 11:15:47 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B5E143F5A1;
        Wed, 11 Oct 2023 11:15:05 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux.dev, jgg@nvidia.com, baolu.lu@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/7] iommu: Decouple iommu_domain_alloc() from bus ops
Date:   Wed, 11 Oct 2023 19:14:51 +0100
Message-Id: <81a0a66d76b3826f1a0b55d7fbaf0986034c7abc.1697047261.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1697047261.git.robin.murphy@arm.com>
References: <cover.1697047261.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the final remaining piece of bus-dependent API, iommu_domain_alloc()
can now take responsibility for the "one iommu_ops per bus" rule for
itself. It turns out we can't safely make the internal allocation call
any more group-based or device-based yet - that will have to wait until
the external callers can pass the right thing - but we can at least get
as far as deriving "bus ops" based on which driver is actually managing
devices on the given bus, rather than whichever driver won the race to
register first.

This will then leave us able to convert the last of the core internals
over to the IOMMU-instance model, allow multiple drivers to register and
actually coexist (modulo the above limitation for unmanaged domain users
in the short term), and start trying to solve the long-standing
iommu_probe_device() mess.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---

v5: Rewrite, de-scoping to just retrieve ops under the same assumptions
    as the existing code.
---
 drivers/iommu/iommu.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 578292d3b152..18667dc2ff86 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2140,12 +2140,31 @@ __iommu_group_domain_alloc(struct iommu_group *group, unsigned int type)
 	return __iommu_domain_alloc(dev_iommu_ops(dev), dev, type);
 }
 
+static int __iommu_domain_alloc_dev(struct device *dev, void *data)
+{
+	const struct iommu_ops **ops = data;
+
+	if (!dev_has_iommu(dev))
+		return 0;
+
+	if (WARN_ONCE(*ops && *ops != dev_iommu_ops(dev),
+		      "Multiple IOMMU drivers present for bus %s, which the public IOMMU API can't fully support yet. You will still need to disable one or more for this to work, sorry!\n",
+		      dev_bus_name(dev)))
+		return -EBUSY;
+
+	*ops = dev_iommu_ops(dev);
+	return 0;
+}
+
 struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus)
 {
-	if (bus == NULL || bus->iommu_ops == NULL)
+	const struct iommu_ops *ops = NULL;
+	int err = bus_for_each_dev(bus, NULL, &ops, __iommu_domain_alloc_dev);
+
+	if (err || !ops)
 		return NULL;
-	return __iommu_domain_alloc(bus->iommu_ops, NULL,
-				    IOMMU_DOMAIN_UNMANAGED);
+
+	return __iommu_domain_alloc(ops, NULL, IOMMU_DOMAIN_UNMANAGED);
 }
 EXPORT_SYMBOL_GPL(iommu_domain_alloc);
 
-- 
2.39.2.101.g768bb238c484.dirty

