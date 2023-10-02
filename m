Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C362E7B54AB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237495AbjJBNta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237514AbjJBNt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:49:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8896FD7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 06:49:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD10B143D;
        Mon,  2 Oct 2023 06:50:02 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7384A3F762;
        Mon,  2 Oct 2023 06:49:23 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux.dev, jgg@nvidia.com, baolu.lu@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/7] iommu: Decouple iommu_present() from bus ops
Date:   Mon,  2 Oct 2023 14:49:10 +0100
Message-Id: <c734557f46fa5ea79b766ce847b003e31096d0bb.1696253096.git.robin.murphy@arm.com>
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

Much as I'd like to remove iommu_present(), the final remaining users
are proving stubbornly difficult to clean up, so kick that can down the
road and just rework it to preserve the current behaviour without
depending on bus ops. Since commit 57365a04c921 ("iommu: Move bus setup
to IOMMU device registration"), any registered IOMMU instance is already
considered "present" for every entry in iommu_buses, so it's simply a
case of validating the bus and checking we have at least once IOMMU.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---

v3: Tweak to use the ops-based check rather than group-based, to
    properly match the existing behaviour
v4: Just look for IOMMU instances instead of managed devices
---
 drivers/iommu/iommu.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f7793d1b5c3e..ef7feb0acc34 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1988,9 +1988,28 @@ int bus_iommu_probe(const struct bus_type *bus)
 	return 0;
 }
 
+/**
+ * iommu_present() - make platform-specific assumptions about an IOMMU
+ * @bus: bus to check
+ *
+ * Do not use this function. You want device_iommu_mapped() instead.
+ *
+ * Return: true if some IOMMU is present and aware of devices on the given bus;
+ * in general it may not be the only IOMMU, and it may not have anything to do
+ * with whatever device you are ultimately interested in.
+ */
 bool iommu_present(const struct bus_type *bus)
 {
-	return bus->iommu_ops != NULL;
+	bool ret = false;
+
+	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
+		if (iommu_buses[i] == bus) {
+			spin_lock(&iommu_device_lock);
+			ret = !list_empty(&iommu_device_list);
+			spin_unlock(&iommu_device_lock);
+		}
+	}
+	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_present);
 
-- 
2.39.2.101.g768bb238c484.dirty

