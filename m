Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03CF79D645
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236785AbjILQ2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236769AbjILQ2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:28:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9850A1703
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:28:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89091C15;
        Tue, 12 Sep 2023 09:28:56 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1CBE73F738;
        Tue, 12 Sep 2023 09:28:17 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, zhangzekun11@huawei.com,
        john.g.garry@oracle.com, dheerajkumar.srivastava@amd.com,
        jsnitsel@redhat.com
Subject: [PATCH v3 2/2] iommu/iova: Manage the depot list size
Date:   Tue, 12 Sep 2023 17:28:06 +0100
Message-Id: <03170665c56d89c6ce6081246b47f68d4e483308.1694535580.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1694535580.git.robin.murphy@arm.com>
References: <cover.1694535580.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Automatically scaling the depot up to suit the peak capacity of a
workload is all well and good, but it would be nice to have a way to
scale it back down again if the workload changes. To that end, add
backround reclaim that will gradually free surplus magazines if the
depot size remains above a reasonable threshold for long enough.

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v3: Make sure iova_depot_work_func() locking is IRQ-safe

 drivers/iommu/iova.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index dd2309e9a6c5..d30e453d0fb4 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -11,6 +11,7 @@
 #include <linux/smp.h>
 #include <linux/bitops.h>
 #include <linux/cpu.h>
+#include <linux/workqueue.h>
 
 /* The anchor node sits above the top of the usable address space */
 #define IOVA_ANCHOR	~0UL
@@ -627,6 +628,8 @@ EXPORT_SYMBOL_GPL(reserve_iova);
  */
 #define IOVA_MAG_SIZE 127
 
+#define IOVA_DEPOT_DELAY msecs_to_jiffies(100)
+
 struct iova_magazine {
 	union {
 		unsigned long size;
@@ -644,8 +647,11 @@ struct iova_cpu_rcache {
 
 struct iova_rcache {
 	spinlock_t lock;
+	unsigned int depot_size;
 	struct iova_magazine *depot;
 	struct iova_cpu_rcache __percpu *cpu_rcaches;
+	struct iova_domain *iovad;
+	struct delayed_work work;
 };
 
 static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
@@ -726,6 +732,7 @@ static struct iova_magazine *iova_depot_pop(struct iova_rcache *rcache)
 
 	rcache->depot = mag->next;
 	mag->size = IOVA_MAG_SIZE;
+	rcache->depot_size--;
 	return mag;
 }
 
@@ -733,6 +740,25 @@ static void iova_depot_push(struct iova_rcache *rcache, struct iova_magazine *ma
 {
 	mag->next = rcache->depot;
 	rcache->depot = mag;
+	rcache->depot_size++;
+}
+
+static void iova_depot_work_func(struct work_struct *work)
+{
+	struct iova_rcache *rcache = container_of(work, typeof(*rcache), work.work);
+	struct iova_magazine *mag = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&rcache->lock, flags);
+	if (rcache->depot_size > num_online_cpus())
+		mag = iova_depot_pop(rcache);
+	spin_unlock_irqrestore(&rcache->lock, flags);
+
+	if (mag) {
+		iova_magazine_free_pfns(mag, rcache->iovad);
+		iova_magazine_free(mag);
+		schedule_delayed_work(&rcache->work, IOVA_DEPOT_DELAY);
+	}
 }
 
 int iova_domain_init_rcaches(struct iova_domain *iovad)
@@ -752,6 +778,8 @@ int iova_domain_init_rcaches(struct iova_domain *iovad)
 
 		rcache = &iovad->rcaches[i];
 		spin_lock_init(&rcache->lock);
+		rcache->iovad = iovad;
+		INIT_DELAYED_WORK(&rcache->work, iova_depot_work_func);
 		rcache->cpu_rcaches = __alloc_percpu(sizeof(*cpu_rcache),
 						     cache_line_size());
 		if (!rcache->cpu_rcaches) {
@@ -812,6 +840,7 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
 			spin_lock(&rcache->lock);
 			iova_depot_push(rcache, cpu_rcache->loaded);
 			spin_unlock(&rcache->lock);
+			schedule_delayed_work(&rcache->work, IOVA_DEPOT_DELAY);
 
 			cpu_rcache->loaded = new_mag;
 			can_insert = true;
@@ -912,6 +941,7 @@ static void free_iova_rcaches(struct iova_domain *iovad)
 			iova_magazine_free(cpu_rcache->prev);
 		}
 		free_percpu(rcache->cpu_rcaches);
+		cancel_delayed_work_sync(&rcache->work);
 		while (rcache->depot)
 			iova_magazine_free(iova_depot_pop(rcache));
 	}
-- 
2.39.2.101.g768bb238c484.dirty

