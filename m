Return-Path: <linux-kernel+bounces-121462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9FB88E835
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D49BF2A6106
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E5C13BC36;
	Wed, 27 Mar 2024 14:45:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B5E13BC15
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711550757; cv=none; b=hHzuim9Odv2Wjb+2TyqZ3n292QUPcOkemnJJnXRdEN5symwViXFBXIZvHFRoF0ObIoLP3GAg9BV7358eDM4h7p4ljmObj6iFVJC/GIMi/3ir3DApN7axn/ELhU1V2VrFDPq9g1PYBSrR2l91X5+MLJEbMcL2vRngSf3bm5L34mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711550757; c=relaxed/simple;
	bh=z5PdeyWO+lFBMDuowaiTcYm4KvvUjVe25RHFQtP5+ec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ad/v2kGwQ+Q75YD53B9K2XtTVR/o6zVEpbexJcqoZcr3FBk/MXhlS/u25+wrtWm6DOOgKBvgKNve1OLXDM0ODK3SAB1L8RpcfVu6DvMax+oWUbDQVCSg5+Yx7B/KOVJQtXVjZ7NFbF+0HG6pCqcpPRnZKM4fj4w92J7EjbP/rYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C84B62F4;
	Wed, 27 Mar 2024 07:46:28 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDFE73F64C;
	Wed, 27 Mar 2024 07:45:52 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Huang Ying <ying.huang@intel.com>,
	Gao Xiang <xiang@kernel.org>,
	Yu Zhao <yuzhao@google.com>,
	Yang Shi <shy828301@gmail.com>,
	Michal Hocko <mhocko@suse.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Barry Song <21cnbao@gmail.com>,
	Chris Li <chrisl@kernel.org>,
	Lance Yang <ioworker0@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/6] mm: swap: Simplify struct percpu_cluster
Date: Wed, 27 Mar 2024 14:45:34 +0000
Message-Id: <20240327144537.4165578-4-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240327144537.4165578-1-ryan.roberts@arm.com>
References: <20240327144537.4165578-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
sentinal value (SWAP_NEXT_INVALID) to indicate "no cluster".
SWAP_NEXT_INVALID is chosen to be 0, because 0 will never be seen
legitimately; The first page in the swap file is the swap header, which
is always marked bad to prevent it from being allocated as an entry.
This also prevents the cluster to which it belongs being marked free, so
it will never appear on the free list.

This change saves 16 bytes per cpu. And given we are shortly going to
extend this mechanism to be per-cpu-AND-per-order, we will end up saving
16 * 9 = 144 bytes per cpu, which adds up if you have 256 cpus in the
system.

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/linux/swap.h |  9 ++++++++-
 mm/swapfile.c        | 22 +++++++++++-----------
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 5737236dc3ce..5e1e4f5bf0cb 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -260,13 +260,20 @@ struct swap_cluster_info {
 #define CLUSTER_FLAG_FREE 1 /* This cluster is free */
 #define CLUSTER_FLAG_NEXT_NULL 2 /* This cluster has no next cluster */
 
+/*
+ * The first page in the swap file is the swap header, which is always marked
+ * bad to prevent it from being allocated as an entry. This also prevents the
+ * cluster to which it belongs being marked free. Therefore 0 is safe to use as
+ * a sentinel to indicate next is not valid in percpu_cluster.
+ */
+#define SWAP_NEXT_INVALID	0
+
 /*
  * We assign a cluster to each CPU, so each CPU can allocate swap entry from
  * its own cluster and swapout sequentially. The purpose is to optimize swapout
  * throughput.
  */
 struct percpu_cluster {
-	struct swap_cluster_info index; /* Current cluster index */
 	unsigned int next; /* Likely next allocation offset */
 };
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index cedfc82d37e5..1393966b77af 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -609,7 +609,7 @@ scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
 		return false;
 
 	percpu_cluster = this_cpu_ptr(si->percpu_cluster);
-	cluster_set_null(&percpu_cluster->index);
+	percpu_cluster->next = SWAP_NEXT_INVALID;
 	return true;
 }
 
@@ -622,14 +622,14 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
 {
 	struct percpu_cluster *cluster;
 	struct swap_cluster_info *ci;
-	unsigned long tmp, max;
+	unsigned int tmp, max;
 
 new_cluster:
 	cluster = this_cpu_ptr(si->percpu_cluster);
-	if (cluster_is_null(&cluster->index)) {
+	tmp = cluster->next;
+	if (tmp == SWAP_NEXT_INVALID) {
 		if (!cluster_list_empty(&si->free_clusters)) {
-			cluster->index = si->free_clusters.head;
-			cluster->next = cluster_next(&cluster->index) *
+			tmp = cluster_next(&si->free_clusters.head) *
 					SWAPFILE_CLUSTER;
 		} else if (!cluster_list_empty(&si->discard_clusters)) {
 			/*
@@ -649,9 +649,7 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
 	 * Other CPUs can use our cluster if they can't find a free cluster,
 	 * check if there is still free entry in the cluster
 	 */
-	tmp = cluster->next;
-	max = min_t(unsigned long, si->max,
-		    (cluster_next(&cluster->index) + 1) * SWAPFILE_CLUSTER);
+	max = min_t(unsigned long, si->max, ALIGN(tmp + 1, SWAPFILE_CLUSTER));
 	if (tmp < max) {
 		ci = lock_cluster(si, tmp);
 		while (tmp < max) {
@@ -662,12 +660,13 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
 		unlock_cluster(ci);
 	}
 	if (tmp >= max) {
-		cluster_set_null(&cluster->index);
+		cluster->next = SWAP_NEXT_INVALID;
 		goto new_cluster;
 	}
-	cluster->next = tmp + 1;
 	*offset = tmp;
 	*scan_base = tmp;
+	tmp += 1;
+	cluster->next = tmp < max ? tmp : SWAP_NEXT_INVALID;
 	return true;
 }
 
@@ -3138,8 +3137,9 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		}
 		for_each_possible_cpu(cpu) {
 			struct percpu_cluster *cluster;
+
 			cluster = per_cpu_ptr(p->percpu_cluster, cpu);
-			cluster_set_null(&cluster->index);
+			cluster->next = SWAP_NEXT_INVALID;
 		}
 	} else {
 		atomic_inc(&nr_rotate_swap);
-- 
2.25.1


