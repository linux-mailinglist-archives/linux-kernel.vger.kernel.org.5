Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B2C779079
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbjHKNLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbjHKNLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:11:12 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF6930E3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:11:10 -0700 (PDT)
Received: from kwepemi500019.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RMkcb69drzqSfv;
        Fri, 11 Aug 2023 21:08:15 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500019.china.huawei.com
 (7.221.188.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 21:11:07 +0800
From:   Zhang Zekun <zhangzekun11@huawei.com>
To:     <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>
CC:     <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <baolu.lu@linux.intel.com>, <robh@kernel.org>,
        <nicolinc@nvidia.com>, <john.g.garry@oracle.com>,
        <kevin.tian@intel.com>
Subject: [RESEND PATCH 2/2] iommu/iova: allocate iova_rcache->depot dynamicly
Date:   Fri, 11 Aug 2023 21:02:46 +0800
Message-ID: <20230811130246.42719-3-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230811130246.42719-1-zhangzekun11@huawei.com>
References: <20230811130246.42719-1-zhangzekun11@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500019.china.huawei.com (7.221.188.117)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In fio test with 4k,read,and allowed cpus to 0-255, we observe a performance
decrease of IOPS. The normal IOPS can reach up to 1980k, but we can only
get about 1600k.

abormal IOPS:
Jobs: 12 (f=12): [R(12)][99.3%][r=6220MiB/s][r=1592k IOPS][eta 00m:12s]
Jobs: 12 (f=12): [R(12)][99.4%][r=6215MiB/s][r=1591k IOPS][eta 00m:11s]
Jobs: 12 (f=12): [R(12)][99.4%][r=6335MiB/s][r=1622k IOPS][eta 00m:10s]
Jobs: 12 (f=12): [R(12)][99.5%][r=6194MiB/s][r=1586k IOPS][eta 00m:09s]
Jobs: 12 (f=12): [R(12)][99.6%][r=6173MiB/s][r=1580k IOPS][eta 00m:08s]
Jobs: 12 (f=12): [R(12)][99.6%][r=5984MiB/s][r=1532k IOPS][eta 00m:07s]
Jobs: 12 (f=12): [R(12)][99.7%][r=6374MiB/s][r=1632k IOPS][eta 00m:06s]
Jobs: 12 (f=12): [R(12)][99.7%][r=6343MiB/s][r=1624k IOPS][eta 00m:05s]

normal IOPS:
Jobs: 12 (f=12): [R(12)][99.3%][r=7736MiB/s][r=1980k IOPS][eta 00m:12s]
Jobs: 12 (f=12): [R(12)][99.4%][r=7744MiB/s][r=1982k IOPS][eta 00m:11s]
Jobs: 12 (f=12): [R(12)][99.4%][r=7737MiB/s][r=1981k IOPS][eta 00m:10s]
Jobs: 12 (f=12): [R(12)][99.5%][r=7735MiB/s][r=1980k IOPS][eta 00m:09s]
Jobs: 12 (f=12): [R(12)][99.6%][r=7741MiB/s][r=1982k IOPS][eta 00m:08s]
Jobs: 12 (f=12): [R(12)][99.6%][r=7740MiB/s][r=1982k IOPS][eta 00m:07s]
Jobs: 12 (f=12): [R(12)][99.7%][r=7736MiB/s][r=1981k IOPS][eta 00m:06s]
Jobs: 12 (f=12): [R(12)][99.7%][r=7736MiB/s][r=1980k IOPS][eta 00m:05s]

The current struct of iova_rcache will have iova_cpu_rcache for every
cpu, and these iova_cpu_rcaches use a common buffer iova_rcache->depot to
exchange iovas among iova_cpu_rcaches. A machine with 256 cpus will have
256 iova_cpu_rcaches and 1 iova_rcache->depot per iova_domain. However,
the max size of iova_rcache->depot is fixed to MAX_GLOBAL_MAGS which equals
to 32, and can't grow with the number of cpus, and this can cause problem
in some condition.

Some drivers will only free iovas in their irq call back function. For
the driver in this case it has 16 thread irqs to free iova, but these
irq call back function will only free iovas on 16 certain cpus(cpu{0,16,
32...,240}). Thread irq which smp affinity is 0-15, will only free iova on
cpu 0. However, the driver will alloc iova on all cpus(cpu{0-255}), cpus
without free iova in local cpu_rcache need to get free iovas from
iova_rcache->depot. The current size of iova_rcache->depot max size is 32,
and it seems to be too small for 256 users (16 cpus will put iovas to
iova_rcache->depot and 240 cpus will try to get iova from it). Set
iova_rcache->depot grow with the num of possible cpus, and the decrease
of IOPS disappear.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/iommu/iova.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 3c784a28e9ed..df37a4501e98 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -238,6 +238,7 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 
 static struct kmem_cache *iova_cache;
 static unsigned int iova_cache_users;
+static unsigned int max_global_mags;
 static DEFINE_MUTEX(iova_cache_mutex);
 
 static struct iova *alloc_iova_mem(void)
@@ -625,7 +626,6 @@ EXPORT_SYMBOL_GPL(reserve_iova);
  * will be wasted.
  */
 #define IOVA_MAG_SIZE 127
-#define MAX_GLOBAL_MAGS 32	/* magazines per bin */
 
 struct iova_magazine {
 	unsigned long size;
@@ -641,7 +641,7 @@ struct iova_cpu_rcache {
 struct iova_rcache {
 	spinlock_t lock;
 	unsigned long depot_size;
-	struct iova_magazine *depot[MAX_GLOBAL_MAGS];
+	struct iova_magazine **depot;
 	struct iova_cpu_rcache __percpu *cpu_rcaches;
 };
 
@@ -722,6 +722,13 @@ int iova_domain_init_rcaches(struct iova_domain *iovad)
 	unsigned int cpu;
 	int i, ret;
 
+	/*
+	 * the size of max global mags should growth with the num of
+	 * cpus
+	 */
+	if (!max_global_mags)
+		max_global_mags = max_t(unsigned int, 32, num_possible_cpus());
+
 	iovad->rcaches = kcalloc(IOVA_RANGE_CACHE_MAX_SIZE,
 				 sizeof(struct iova_rcache),
 				 GFP_KERNEL);
@@ -733,6 +740,12 @@ int iova_domain_init_rcaches(struct iova_domain *iovad)
 		struct iova_rcache *rcache;
 
 		rcache = &iovad->rcaches[i];
+		rcache->depot = kcalloc(max_global_mags, sizeof(struct iova_magazine *),
+					GFP_KERNEL);
+		if (!rcache->depot) {
+			ret = -ENOMEM;
+			goto out_err;
+		}
 		spin_lock_init(&rcache->lock);
 		rcache->depot_size = 0;
 		rcache->cpu_rcaches = __alloc_percpu(sizeof(*cpu_rcache),
@@ -798,7 +811,7 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
 
 		if (new_mag) {
 			spin_lock(&rcache->lock);
-			if (rcache->depot_size < MAX_GLOBAL_MAGS) {
+			if (rcache->depot_size < max_global_mags) {
 				rcache->depot[rcache->depot_size++] =
 						cpu_rcache->loaded;
 			} else {
@@ -903,8 +916,12 @@ static void free_iova_rcaches(struct iova_domain *iovad)
 
 	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
 		rcache = &iovad->rcaches[i];
-		if (!rcache->cpu_rcaches)
+		if (!rcache->depot)
+			break;
+		if (!rcache->cpu_rcaches) {
+			kfree(rcache->depot);
 			break;
+		}
 		for_each_possible_cpu(cpu) {
 			cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
 			if (!cpu_rcache->loaded)
@@ -917,6 +934,7 @@ static void free_iova_rcaches(struct iova_domain *iovad)
 		free_percpu(rcache->cpu_rcaches);
 		for (j = 0; j < rcache->depot_size; ++j)
 			iova_magazine_free(rcache->depot[j]);
+		kfree(rcache->depot);
 	}
 
 	kfree(iovad->rcaches);
-- 
2.17.1

