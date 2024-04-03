Return-Path: <linux-kernel+bounces-129681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BC2896E5E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29391C2616D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E23E143863;
	Wed,  3 Apr 2024 11:40:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9A61465A3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712144451; cv=none; b=AR7fHsOjplLOchH5q3WY+nexIBWyhMBTpVtm3U33j+efD7jaIR5oAPJXOcziUuTEh9V16CSe7ZbWKOKHCcxFWIKFtZK4IetrJ08UVIJLsCv3f3xGnEQibBsYYcwMZHSwGJ5JcVN2WLtJBe+lYfUx03ITlBJif161IgbFQN+VbFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712144451; c=relaxed/simple;
	bh=twH6ON+xsWMUD6u5uSxiQM5SA3pcFrAU6cllZBUcdYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SMmZ0Ap/OVOZCr4zpUo/KsXbI40zxlhJaZOMU0AHFutJv9MhYh2Fizx0CS8xvnLqkpkyByg3OkbNe9ifP9/icjXenFgewmBvoVx/gUW0EitPy4OiH0a7QYsIu5WIRDKBmpfRG72zKLF33opqHapCYysjuVsDeoMaEsoCHv5mhuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C97E1650;
	Wed,  3 Apr 2024 04:41:20 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A0113F64C;
	Wed,  3 Apr 2024 04:40:47 -0700 (PDT)
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
Subject: [PATCH v6 3/6] mm: swap: Simplify struct percpu_cluster
Date: Wed,  3 Apr 2024 12:40:29 +0100
Message-Id: <20240403114032.1162100-4-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240403114032.1162100-1-ryan.roberts@arm.com>
References: <20240403114032.1162100-1-ryan.roberts@arm.com>
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
index d059de6896c1..c95986b9cb9c 100644
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
 
@@ -3150,8 +3149,9 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
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


