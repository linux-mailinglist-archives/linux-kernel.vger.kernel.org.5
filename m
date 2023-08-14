Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A8F77BF63
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 19:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjHNRyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 13:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjHNRxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:53:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45F241711
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 10:53:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54E43143D;
        Mon, 14 Aug 2023 10:54:22 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 117363F762;
        Mon, 14 Aug 2023 10:53:38 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, john.g.garry@oracle.com,
        zhangzekun11@huawei.com
Subject: [PATCH 1/2] iommu/iova: Make the rcache depot scale better
Date:   Mon, 14 Aug 2023 18:53:33 +0100
Message-Id: <2c3a0f6b381ae5f743c1b28bbc6eae486160f3b7.1692033783.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1692033783.git.robin.murphy@arm.com>
References: <cover.1692033783.git.robin.murphy@arm.com>
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

The algorithm in the original paper specifies the storage of full
magazines in the depot as an unbounded list rather than a fixed-size
array. It turns out to be pretty straightforward to do this in our
implementation with no significant loss of efficiency. This allows
the depot to scale up to the working set sizes of larger systems,
while also potentially saving some memory on smaller ones too.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iova.c | 65 ++++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 10b964600948..d2de6fb0e9f4 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -625,10 +625,16 @@ EXPORT_SYMBOL_GPL(reserve_iova);
  * will be wasted.
  */
 #define IOVA_MAG_SIZE 127
-#define MAX_GLOBAL_MAGS 32	/* magazines per bin */
 
 struct iova_magazine {
-	unsigned long size;
+	/*
+	 * Only full magazines are inserted into the depot, so we can avoid
+	 * a separate list head and preserve maximum space-efficiency.
+	 */
+	union {
+		unsigned long size;
+		struct iova_magazine *next;
+	};
 	unsigned long pfns[IOVA_MAG_SIZE];
 };
 
@@ -640,8 +646,7 @@ struct iova_cpu_rcache {
 
 struct iova_rcache {
 	spinlock_t lock;
-	unsigned long depot_size;
-	struct iova_magazine *depot[MAX_GLOBAL_MAGS];
+	struct iova_magazine *depot;
 	struct iova_cpu_rcache __percpu *cpu_rcaches;
 };
 
@@ -717,6 +722,21 @@ static void iova_magazine_push(struct iova_magazine *mag, unsigned long pfn)
 	mag->pfns[mag->size++] = pfn;
 }
 
+static struct iova_magazine *iova_depot_pop(struct iova_rcache *rcache)
+{
+	struct iova_magazine *mag = rcache->depot;
+
+	rcache->depot = mag->next;
+	mag->size = IOVA_MAG_SIZE;
+	return mag;
+}
+
+static void iova_depot_push(struct iova_rcache *rcache, struct iova_magazine *mag)
+{
+	mag->next = rcache->depot;
+	rcache->depot = mag;
+}
+
 int iova_domain_init_rcaches(struct iova_domain *iovad)
 {
 	unsigned int cpu;
@@ -734,7 +754,6 @@ int iova_domain_init_rcaches(struct iova_domain *iovad)
 
 		rcache = &iovad->rcaches[i];
 		spin_lock_init(&rcache->lock);
-		rcache->depot_size = 0;
 		rcache->cpu_rcaches = __alloc_percpu(sizeof(*cpu_rcache),
 						     cache_line_size());
 		if (!rcache->cpu_rcaches) {
@@ -776,7 +795,6 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
 				 struct iova_rcache *rcache,
 				 unsigned long iova_pfn)
 {
-	struct iova_magazine *mag_to_free = NULL;
 	struct iova_cpu_rcache *cpu_rcache;
 	bool can_insert = false;
 	unsigned long flags;
@@ -794,12 +812,7 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
 
 		if (new_mag) {
 			spin_lock(&rcache->lock);
-			if (rcache->depot_size < MAX_GLOBAL_MAGS) {
-				rcache->depot[rcache->depot_size++] =
-						cpu_rcache->loaded;
-			} else {
-				mag_to_free = cpu_rcache->loaded;
-			}
+			iova_depot_push(rcache, cpu_rcache->loaded);
 			spin_unlock(&rcache->lock);
 
 			cpu_rcache->loaded = new_mag;
@@ -812,11 +825,6 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
 
 	spin_unlock_irqrestore(&cpu_rcache->lock, flags);
 
-	if (mag_to_free) {
-		iova_magazine_free_pfns(mag_to_free, iovad);
-		iova_magazine_free(mag_to_free);
-	}
-
 	return can_insert;
 }
 
@@ -854,9 +862,9 @@ static unsigned long __iova_rcache_get(struct iova_rcache *rcache,
 		has_pfn = true;
 	} else {
 		spin_lock(&rcache->lock);
-		if (rcache->depot_size > 0) {
+		if (rcache->depot) {
 			iova_magazine_free(cpu_rcache->loaded);
-			cpu_rcache->loaded = rcache->depot[--rcache->depot_size];
+			cpu_rcache->loaded = iova_depot_pop(rcache);
 			has_pfn = true;
 		}
 		spin_unlock(&rcache->lock);
@@ -894,10 +902,10 @@ static void free_iova_rcaches(struct iova_domain *iovad)
 {
 	struct iova_rcache *rcache;
 	struct iova_cpu_rcache *cpu_rcache;
+	struct iova_magazine *mag;
 	unsigned int cpu;
-	int i, j;
 
-	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
+	for (int i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
 		rcache = &iovad->rcaches[i];
 		if (!rcache->cpu_rcaches)
 			break;
@@ -907,8 +915,8 @@ static void free_iova_rcaches(struct iova_domain *iovad)
 			iova_magazine_free(cpu_rcache->prev);
 		}
 		free_percpu(rcache->cpu_rcaches);
-		for (j = 0; j < rcache->depot_size; ++j)
-			iova_magazine_free(rcache->depot[j]);
+		while ((mag = iova_depot_pop(rcache)))
+			iova_magazine_free(mag);
 	}
 
 	kfree(iovad->rcaches);
@@ -941,17 +949,16 @@ static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad)
 static void free_global_cached_iovas(struct iova_domain *iovad)
 {
 	struct iova_rcache *rcache;
+	struct iova_magazine *mag;
 	unsigned long flags;
-	int i, j;
 
-	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
+	for (int i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
 		rcache = &iovad->rcaches[i];
 		spin_lock_irqsave(&rcache->lock, flags);
-		for (j = 0; j < rcache->depot_size; ++j) {
-			iova_magazine_free_pfns(rcache->depot[j], iovad);
-			iova_magazine_free(rcache->depot[j]);
+		while ((mag = iova_depot_pop(rcache))) {
+			iova_magazine_free_pfns(mag, iovad);
+			iova_magazine_free(mag);
 		}
-		rcache->depot_size = 0;
 		spin_unlock_irqrestore(&rcache->lock, flags);
 	}
 }
-- 
2.39.2.101.g768bb238c484.dirty

