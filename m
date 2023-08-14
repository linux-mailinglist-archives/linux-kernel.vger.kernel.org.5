Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F234777BF62
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 19:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjHNRyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 13:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjHNRxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:53:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85F56172B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 10:53:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C2DF1477;
        Mon, 14 Aug 2023 10:54:23 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 48FF93F762;
        Mon, 14 Aug 2023 10:53:40 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, john.g.garry@oracle.com,
        zhangzekun11@huawei.com
Subject: [PATCH 2/2] iommu/iova: Manage the depot list size
Date:   Mon, 14 Aug 2023 18:53:34 +0100
Message-Id: <abc5a322584f5c8a44f7a0a7f709899053c5df01.1692033783.git.robin.murphy@arm.com>
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

Automatically scaling the depot up to suit the peak capacity of a
workload is all well and good, but it would be nice to have a way to
scale it back down again if the workload changes. To that end, add
automatic reclaim that will gradually free unused magazines if the
depot size remains above a reasonable threshold for long enough.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iova.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index d2de6fb0e9f4..76a7d694708e 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -11,6 +11,7 @@
 #include <linux/smp.h>
 #include <linux/bitops.h>
 #include <linux/cpu.h>
+#include <linux/workqueue.h>
 
 /* The anchor node sits above the top of the usable address space */
 #define IOVA_ANCHOR	~0UL
@@ -626,6 +627,8 @@ EXPORT_SYMBOL_GPL(reserve_iova);
  */
 #define IOVA_MAG_SIZE 127
 
+#define IOVA_DEPOT_DELAY msecs_to_jiffies(100)
+
 struct iova_magazine {
 	/*
 	 * Only full magazines are inserted into the depot, so we can avoid
@@ -646,8 +649,11 @@ struct iova_cpu_rcache {
 
 struct iova_rcache {
 	spinlock_t lock;
+	unsigned int depot_size;
 	struct iova_magazine *depot;
 	struct iova_cpu_rcache __percpu *cpu_rcaches;
+	struct iova_domain *iovad;
+	struct delayed_work work;
 };
 
 static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
@@ -728,6 +734,7 @@ static struct iova_magazine *iova_depot_pop(struct iova_rcache *rcache)
 
 	rcache->depot = mag->next;
 	mag->size = IOVA_MAG_SIZE;
+	rcache->depot_size--;
 	return mag;
 }
 
@@ -735,6 +742,24 @@ static void iova_depot_push(struct iova_rcache *rcache, struct iova_magazine *ma
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
+
+	spin_lock(&rcache->lock);
+	if (rcache->depot_size > num_online_cpus())
+		mag = iova_depot_pop(rcache);
+	spin_unlock(&rcache->lock);
+
+	if (mag) {
+		iova_magazine_free_pfns(mag, rcache->iovad);
+		iova_magazine_free(mag);
+		schedule_delayed_work(&rcache->work, msecs_to_jiffies(IOVA_DEPOT_DELAY));
+	}
 }
 
 int iova_domain_init_rcaches(struct iova_domain *iovad)
@@ -754,6 +779,8 @@ int iova_domain_init_rcaches(struct iova_domain *iovad)
 
 		rcache = &iovad->rcaches[i];
 		spin_lock_init(&rcache->lock);
+		rcache->iovad = iovad;
+		INIT_DELAYED_WORK(&rcache->work, iova_depot_work_func);
 		rcache->cpu_rcaches = __alloc_percpu(sizeof(*cpu_rcache),
 						     cache_line_size());
 		if (!rcache->cpu_rcaches) {
@@ -814,6 +841,7 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
 			spin_lock(&rcache->lock);
 			iova_depot_push(rcache, cpu_rcache->loaded);
 			spin_unlock(&rcache->lock);
+			schedule_delayed_work(&rcache->work, IOVA_DEPOT_DELAY);
 
 			cpu_rcache->loaded = new_mag;
 			can_insert = true;
@@ -915,6 +943,7 @@ static void free_iova_rcaches(struct iova_domain *iovad)
 			iova_magazine_free(cpu_rcache->prev);
 		}
 		free_percpu(rcache->cpu_rcaches);
+		cancel_delayed_work_sync(&rcache->work);
 		while ((mag = iova_depot_pop(rcache)))
 			iova_magazine_free(mag);
 	}
-- 
2.39.2.101.g768bb238c484.dirty

