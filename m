Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687837DA65D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 12:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjJ1KVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 06:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjJ1KVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 06:21:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09637E5
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 03:21:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F558143D;
        Sat, 28 Oct 2023 03:21:56 -0700 (PDT)
Received: from entos-ampere02.shanghai.arm.com (unknown [10.169.212.228])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4B7DE3F64C;
        Sat, 28 Oct 2023 03:21:12 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, nd@arm.com,
        Jia He <justin.he@arm.com>
Subject: [PATCH v4 1/2] dma-mapping: move dma_addressing_limited() out of line
Date:   Sat, 28 Oct 2023 10:20:58 +0000
Message-Id: <20231028102059.66891-2-justin.he@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231028102059.66891-1-justin.he@arm.com>
References: <20231028102059.66891-1-justin.he@arm.com>
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

This patch moves dma_addressing_limited() out of line, serving as a
preliminary step to prevent the introduction of a new publicly accessible
low-level helper when validating whether all system RAM is mapped within
the DMA mapping range.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jia He <justin.he@arm.com>
---
 include/linux/dma-mapping.h | 19 +++++--------------
 kernel/dma/mapping.c        | 15 +++++++++++++++
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f0ccca16a0ac..4a658de44ee9 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -144,6 +144,7 @@ bool dma_pci_p2pdma_supported(struct device *dev);
 int dma_set_mask(struct device *dev, u64 mask);
 int dma_set_coherent_mask(struct device *dev, u64 mask);
 u64 dma_get_required_mask(struct device *dev);
+bool dma_addressing_limited(struct device *dev);
 size_t dma_max_mapping_size(struct device *dev);
 size_t dma_opt_mapping_size(struct device *dev);
 bool dma_need_sync(struct device *dev, dma_addr_t dma_addr);
@@ -264,6 +265,10 @@ static inline u64 dma_get_required_mask(struct device *dev)
 {
 	return 0;
 }
+static inline bool dma_addressing_limited(struct device *dev)
+{
+	return false;
+}
 static inline size_t dma_max_mapping_size(struct device *dev)
 {
 	return 0;
@@ -465,20 +470,6 @@ static inline int dma_coerce_mask_and_coherent(struct device *dev, u64 mask)
 	return dma_set_mask_and_coherent(dev, mask);
 }
 
-/**
- * dma_addressing_limited - return if the device is addressing limited
- * @dev:	device to check
- *
- * Return %true if the devices DMA mask is too small to address all memory in
- * the system, else %false.  Lack of addressing bits is the prime reason for
- * bounce buffering, but might not be the only one.
- */
-static inline bool dma_addressing_limited(struct device *dev)
-{
-	return min_not_zero(dma_get_mask(dev), dev->bus_dma_limit) <
-			    dma_get_required_mask(dev);
-}
-
 static inline unsigned int dma_get_max_seg_size(struct device *dev)
 {
 	if (dev->dma_parms && dev->dma_parms->max_segment_size)
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index e323ca48f7f2..5bfe782f9a7f 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -793,6 +793,21 @@ int dma_set_coherent_mask(struct device *dev, u64 mask)
 }
 EXPORT_SYMBOL(dma_set_coherent_mask);
 
+/**
+ * dma_addressing_limited - return if the device is addressing limited
+ * @dev:	device to check
+ *
+ * Return %true if the devices DMA mask is too small to address all memory in
+ * the system, else %false.  Lack of addressing bits is the prime reason for
+ * bounce buffering, but might not be the only one.
+ */
+bool dma_addressing_limited(struct device *dev)
+{
+	return min_not_zero(dma_get_mask(dev), dev->bus_dma_limit) <
+			    dma_get_required_mask(dev);
+}
+EXPORT_SYMBOL(dma_addressing_limited);
+
 size_t dma_max_mapping_size(struct device *dev)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
-- 
2.25.1

