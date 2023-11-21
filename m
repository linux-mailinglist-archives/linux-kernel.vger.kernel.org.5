Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B98C7F3590
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbjKUSFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbjKUSEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:04:44 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B51F61716
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 10:04:19 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5139A1AED;
        Tue, 21 Nov 2023 10:05:06 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 855FA3F6C4;
        Tue, 21 Nov 2023 10:04:18 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux.dev, jgg@nvidia.com, baolu.lu@linux.intel.com,
        linux-kernel@vger.kernel.org, jsnitsel@redhat.com
Subject: [PATCH v6 4/7] iommu: Decouple iommu_domain_alloc() from bus ops
Date:   Tue, 21 Nov 2023 18:04:00 +0000
Message-Id: <6c7313009aae0e39ae2855920990ebf85af4662f.1700589539.git.robin.murphy@arm.com>
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

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---

v5: Rewrite, de-scoping to just retrieve ops under the same assumptions
    as the existing code.
---
 drivers/iommu/iommu.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8e4436c606d3..88aeae0acd9b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2143,12 +2143,31 @@ __iommu_group_domain_alloc(struct iommu_group *group, unsigned int type)
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

