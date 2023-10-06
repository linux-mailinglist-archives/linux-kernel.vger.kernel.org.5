Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BB37BB0A5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 06:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjJFEAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 00:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjJFEAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 00:00:39 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08401E8
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 21:00:36 -0700 (PDT)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qoc0k-0000mf-3B;
        Fri, 06 Oct 2023 00:00:23 -0400
From:   riel@surriel.com
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@meta.com, linux-mm@kvack.org,
        akpm@linux-foundation.org, muchun.song@linux.dev,
        mike.kravetz@oracle.com, leit@meta.com, willy@infradead.org,
        Rik van Riel <riel@surriel.com>, stable@kernel.org
Subject: [PATCH 2/4] hugetlbfs: extend hugetlb_vma_lock to private VMAs
Date:   Thu,  5 Oct 2023 23:59:07 -0400
Message-ID: <20231006040020.3677377-3-riel@surriel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006040020.3677377-1-riel@surriel.com>
References: <20231006040020.3677377-1-riel@surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: riel@surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rik van Riel <riel@surriel.com>

Extend the locking scheme used to protect shared hugetlb mappings
from truncate vs page fault races, in order to protect private
hugetlb mappings (with resv_map) against MADV_DONTNEED.

Add a read-write semaphore to the resv_map data structure, and
use that from the hugetlb_vma_(un)lock_* functions, in preparation
for closing the race between MADV_DONTNEED and page faults.

Signed-off-by: Rik van Riel <riel@surriel.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Cc: stable@kernel.org
Fixes: 04ada095dcfc ("hugetlb: don't delete vma_lock in hugetlb MADV_DONTNEED processing")
---
 include/linux/hugetlb.h |  6 ++++++
 mm/hugetlb.c            | 41 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 5b2626063f4f..694928fa06a3 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -60,6 +60,7 @@ struct resv_map {
 	long adds_in_progress;
 	struct list_head region_cache;
 	long region_cache_count;
+	struct rw_semaphore rw_sema;
 #ifdef CONFIG_CGROUP_HUGETLB
 	/*
 	 * On private mappings, the counter to uncharge reservations is stored
@@ -1231,6 +1232,11 @@ static inline bool __vma_shareable_lock(struct vm_area_struct *vma)
 	return (vma->vm_flags & VM_MAYSHARE) && vma->vm_private_data;
 }
 
+static inline bool __vma_private_lock(struct vm_area_struct *vma)
+{
+	return (!(vma->vm_flags & VM_MAYSHARE)) && vma->vm_private_data;
+}
+
 /*
  * Safe version of huge_pte_offset() to check the locks.  See comments
  * above huge_pte_offset().
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a86e070d735b..dd3de6ec8f1a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -97,6 +97,7 @@ static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma);
 static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma);
 static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end);
+static struct resv_map *vma_resv_map(struct vm_area_struct *vma);
 
 static inline bool subpool_is_free(struct hugepage_subpool *spool)
 {
@@ -267,6 +268,10 @@ void hugetlb_vma_lock_read(struct vm_area_struct *vma)
 		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
 
 		down_read(&vma_lock->rw_sema);
+	} else if (__vma_private_lock(vma)) {
+		struct resv_map *resv_map = vma_resv_map(vma);
+
+		down_read(&resv_map->rw_sema);
 	}
 }
 
@@ -276,6 +281,10 @@ void hugetlb_vma_unlock_read(struct vm_area_struct *vma)
 		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
 
 		up_read(&vma_lock->rw_sema);
+	} else if (__vma_private_lock(vma)) {
+		struct resv_map *resv_map = vma_resv_map(vma);
+
+		up_read(&resv_map->rw_sema);
 	}
 }
 
@@ -285,6 +294,10 @@ void hugetlb_vma_lock_write(struct vm_area_struct *vma)
 		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
 
 		down_write(&vma_lock->rw_sema);
+	} else if (__vma_private_lock(vma)) {
+		struct resv_map *resv_map = vma_resv_map(vma);
+
+		down_write(&resv_map->rw_sema);
 	}
 }
 
@@ -294,17 +307,27 @@ void hugetlb_vma_unlock_write(struct vm_area_struct *vma)
 		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
 
 		up_write(&vma_lock->rw_sema);
+	} else if (__vma_private_lock(vma)) {
+		struct resv_map *resv_map = vma_resv_map(vma);
+
+		up_write(&resv_map->rw_sema);
 	}
 }
 
 int hugetlb_vma_trylock_write(struct vm_area_struct *vma)
 {
-	struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
 
-	if (!__vma_shareable_lock(vma))
-		return 1;
+	if (__vma_shareable_lock(vma)) {
+		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
 
-	return down_write_trylock(&vma_lock->rw_sema);
+		return down_write_trylock(&vma_lock->rw_sema);
+	} else if (__vma_private_lock(vma)) {
+		struct resv_map *resv_map = vma_resv_map(vma);
+
+		return down_write_trylock(&resv_map->rw_sema);
+	}
+
+	return 1;
 }
 
 void hugetlb_vma_assert_locked(struct vm_area_struct *vma)
@@ -313,6 +336,10 @@ void hugetlb_vma_assert_locked(struct vm_area_struct *vma)
 		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
 
 		lockdep_assert_held(&vma_lock->rw_sema);
+	} else if (__vma_private_lock(vma)) {
+		struct resv_map *resv_map = vma_resv_map(vma);
+
+		lockdep_assert_held(&resv_map->rw_sema);
 	}
 }
 
@@ -345,6 +372,11 @@ static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma)
 		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
 
 		__hugetlb_vma_unlock_write_put(vma_lock);
+	} else if (__vma_private_lock(vma)) {
+		struct resv_map *resv_map = vma_resv_map(vma);
+
+		/* no free for anon vmas, but still need to unlock */
+		up_write(&resv_map->rw_sema);
 	}
 }
 
@@ -1068,6 +1100,7 @@ struct resv_map *resv_map_alloc(void)
 	kref_init(&resv_map->refs);
 	spin_lock_init(&resv_map->lock);
 	INIT_LIST_HEAD(&resv_map->regions);
+	init_rwsem(&resv_map->rw_sema);
 
 	resv_map->adds_in_progress = 0;
 	/*
-- 
2.41.0

