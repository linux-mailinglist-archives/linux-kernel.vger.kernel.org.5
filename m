Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A377D6FD7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343552AbjJYOqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbjJYOqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:46:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DAE91DC
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:45:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30C9B1474;
        Wed, 25 Oct 2023 07:46:41 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 139993F7C5;
        Wed, 25 Oct 2023 07:45:57 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v3 2/4] mm: swap: Remove struct percpu_cluster
Date:   Wed, 25 Oct 2023 15:45:44 +0100
Message-Id: <20231025144546.577640-3-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231025144546.577640-1-ryan.roberts@arm.com>
References: <20231025144546.577640-1-ryan.roberts@arm.com>
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

struct percpu_cluster stores the index of cpu's current cluster and the
offset of the next entry that will be allocated for the cpu. These two
pieces of information are redundant because the cluster index is just
(offset / SWAPFILE_CLUSTER). The only reason for explicitly keeping the
cluster index is because the structure used for it also has a flag to
indicate "no cluster". However this data structure also contains a spin
lock, which is never used in this context, as a side effect the code
copies the spinlock_t structure, which is questionable coding practice
in my view.

So let's clean this up and store only the next offset, and use a
sentinal value (SWAP_NEXT_NULL) to indicate "no cluster". SWAP_NEXT_NULL
is chosen to be 0, because 0 will never be seen legitimately; The first
page in the swap file is the swap header, which is always marked bad to
prevent it from being allocated as an entry. This also prevents the
cluster to which it belongs being marked free, so it will never appear
on the free list.

This change saves 16 bytes per cpu. And given we are shortly going to
extend this mechanism to be per-cpu-AND-per-order, we will end up saving
16 * 9 = 144 bytes per cpu, which adds up if you have 256 cpus in the
system.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/linux/swap.h | 21 +++++++++++++--------
 mm/swapfile.c        | 43 +++++++++++++++++++------------------------
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index a073366a227c..0ca8aaa098ba 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -261,14 +261,12 @@ struct swap_cluster_info {
 #define CLUSTER_FLAG_NEXT_NULL 2 /* This cluster has no next cluster */
 
 /*
- * We assign a cluster to each CPU, so each CPU can allocate swap entry from
- * its own cluster and swapout sequentially. The purpose is to optimize swapout
- * throughput.
+ * The first page in the swap file is the swap header, which is always marked
+ * bad to prevent it from being allocated as an entry. This also prevents the
+ * cluster to which it belongs being marked free. Therefore 0 is safe to use as
+ * a sentinel to indicate cpu_next is not valid in swap_info_struct.
  */
-struct percpu_cluster {
-	struct swap_cluster_info index; /* Current cluster index */
-	unsigned int next; /* Likely next allocation offset */
-};
+#define SWAP_NEXT_NULL	0
 
 struct swap_cluster_list {
 	struct swap_cluster_info head;
@@ -295,7 +293,14 @@ struct swap_info_struct {
 	unsigned int cluster_next;	/* likely index for next allocation */
 	unsigned int cluster_nr;	/* countdown to next cluster search */
 	unsigned int __percpu *cluster_next_cpu; /*percpu index for next allocation */
-	struct percpu_cluster __percpu *percpu_cluster; /* per cpu's swap location */
+	unsigned int __percpu *cpu_next;/*
+					 * Likely next allocation offset. We
+					 * assign a cluster to each CPU, so each
+					 * CPU can allocate swap entry from its
+					 * own cluster and swapout sequentially.
+					 * The purpose is to optimize swapout
+					 * throughput.
+					 */
 	struct rb_root swap_extent_root;/* root of the swap extent rbtree */
 	struct block_device *bdev;	/* swap device or bdev of swap file */
 	struct file *swap_file;		/* seldom referenced */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index b83ad77e04c0..617e34b8cdbe 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -591,7 +591,6 @@ static bool
 scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
 	unsigned long offset)
 {
-	struct percpu_cluster *percpu_cluster;
 	bool conflict;
 
 	offset /= SWAPFILE_CLUSTER;
@@ -602,8 +601,7 @@ scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
 	if (!conflict)
 		return false;
 
-	percpu_cluster = this_cpu_ptr(si->percpu_cluster);
-	cluster_set_null(&percpu_cluster->index);
+	*this_cpu_ptr(si->cpu_next) = SWAP_NEXT_NULL;
 	return true;
 }
 
@@ -614,16 +612,16 @@ scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
 static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
 	unsigned long *offset, unsigned long *scan_base)
 {
-	struct percpu_cluster *cluster;
 	struct swap_cluster_info *ci;
-	unsigned long tmp, max;
+	unsigned int tmp, max;
+	unsigned int *cpu_next;
 
 new_cluster:
-	cluster = this_cpu_ptr(si->percpu_cluster);
-	if (cluster_is_null(&cluster->index)) {
+	cpu_next = this_cpu_ptr(si->cpu_next);
+	tmp = *cpu_next;
+	if (tmp == SWAP_NEXT_NULL) {
 		if (!cluster_list_empty(&si->free_clusters)) {
-			cluster->index = si->free_clusters.head;
-			cluster->next = cluster_next(&cluster->index) *
+			tmp = cluster_next(&si->free_clusters.head) *
 					SWAPFILE_CLUSTER;
 		} else if (!cluster_list_empty(&si->discard_clusters)) {
 			/*
@@ -643,9 +641,8 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
 	 * Other CPUs can use our cluster if they can't find a free cluster,
 	 * check if there is still free entry in the cluster
 	 */
-	tmp = cluster->next;
 	max = min_t(unsigned long, si->max,
-		    (cluster_next(&cluster->index) + 1) * SWAPFILE_CLUSTER);
+		    ALIGN_DOWN(tmp, SWAPFILE_CLUSTER) + SWAPFILE_CLUSTER);
 	if (tmp < max) {
 		ci = lock_cluster(si, tmp);
 		while (tmp < max) {
@@ -656,12 +653,13 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
 		unlock_cluster(ci);
 	}
 	if (tmp >= max) {
-		cluster_set_null(&cluster->index);
+		*cpu_next = SWAP_NEXT_NULL;
 		goto new_cluster;
 	}
-	cluster->next = tmp + 1;
 	*offset = tmp;
 	*scan_base = tmp;
+	tmp += 1;
+	*cpu_next = tmp < max ? tmp : SWAP_NEXT_NULL;
 	return true;
 }
 
@@ -2488,8 +2486,8 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	arch_swap_invalidate_area(p->type);
 	zswap_swapoff(p->type);
 	mutex_unlock(&swapon_mutex);
-	free_percpu(p->percpu_cluster);
-	p->percpu_cluster = NULL;
+	free_percpu(p->cpu_next);
+	p->cpu_next = NULL;
 	free_percpu(p->cluster_next_cpu);
 	p->cluster_next_cpu = NULL;
 	vfree(swap_map);
@@ -3073,16 +3071,13 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		for (ci = 0; ci < nr_cluster; ci++)
 			spin_lock_init(&((cluster_info + ci)->lock));
 
-		p->percpu_cluster = alloc_percpu(struct percpu_cluster);
-		if (!p->percpu_cluster) {
+		p->cpu_next = alloc_percpu(unsigned int);
+		if (!p->cpu_next) {
 			error = -ENOMEM;
 			goto bad_swap_unlock_inode;
 		}
-		for_each_possible_cpu(cpu) {
-			struct percpu_cluster *cluster;
-			cluster = per_cpu_ptr(p->percpu_cluster, cpu);
-			cluster_set_null(&cluster->index);
-		}
+		for_each_possible_cpu(cpu)
+			per_cpu(*p->cpu_next, cpu) = SWAP_NEXT_NULL;
 	} else {
 		atomic_inc(&nr_rotate_swap);
 		inced_nr_rotate_swap = true;
@@ -3171,8 +3166,8 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 bad_swap_unlock_inode:
 	inode_unlock(inode);
 bad_swap:
-	free_percpu(p->percpu_cluster);
-	p->percpu_cluster = NULL;
+	free_percpu(p->cpu_next);
+	p->cpu_next = NULL;
 	free_percpu(p->cluster_next_cpu);
 	p->cluster_next_cpu = NULL;
 	if (inode && S_ISBLK(inode->i_mode) && p->bdev) {
-- 
2.25.1

