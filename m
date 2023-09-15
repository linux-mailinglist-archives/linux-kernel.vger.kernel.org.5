Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04B67A240D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbjIOQ6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbjIOQ6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:58:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B73119BC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:58:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C6AC12FC;
        Fri, 15 Sep 2023 09:59:03 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0BB753F5A1;
        Fri, 15 Sep 2023 09:58:24 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jgg@nvidia.com,
        baolu.lu@linux.intel.com
Subject: [PATCH v3 2/7] iommu: Decouple iommu_present() from bus ops
Date:   Fri, 15 Sep 2023 17:58:06 +0100
Message-Id: <b7cd933aa7774ad687c695ebe5e00c17178a7542.1694693889.git.robin.murphy@arm.com>
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

Much as I'd like to remove iommu_present(), the final remaining users
are proving stubbornly difficult to clean up, so kick that can down
the road and just rework it to preserve the current behaviour without
depending on bus ops.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---

v3: Tweak to use the ops-based check rather than group-based, to
    properly match the existing behaviour
---
 drivers/iommu/iommu.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4566d0001cd3..2f29ee9dea64 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1907,9 +1907,24 @@ int bus_iommu_probe(const struct bus_type *bus)
 	return 0;
 }
 
+static int __iommu_present(struct device *dev, void *unused)
+{
+	return dev_has_iommu(dev);
+}
+
+/**
+ * iommu_present() - make platform-specific assumptions about an IOMMU
+ * @bus: bus to check
+ *
+ * Do not use this function. You want device_iommu_mapped() instead.
+ *
+ * Return: true if some IOMMU is present for some device on the given bus. In
+ * general it may not be the only IOMMU, and it may not be for the device you
+ * are ultimately interested in.
+ */
 bool iommu_present(const struct bus_type *bus)
 {
-	return bus->iommu_ops != NULL;
+	return bus_for_each_dev(bus, NULL, NULL, __iommu_present) > 0;
 }
 EXPORT_SYMBOL_GPL(iommu_present);
 
-- 
2.39.2.101.g768bb238c484.dirty

