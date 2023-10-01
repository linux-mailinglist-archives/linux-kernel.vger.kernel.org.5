Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1AB7B44DB
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 02:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbjJAA6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 20:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbjJAA6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 20:58:12 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096FEE5
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 17:58:05 -0700 (PDT)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qmklZ-0008G8-0d;
        Sat, 30 Sep 2023 20:57:01 -0400
From:   riel@surriel.com
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@meta.com, linux-mm@kvack.org,
        akpm@linux-foundation.org, muchun.song@linux.dev,
        mike.kravetz@oracle.com, leit@meta.com, willy@infradead.org,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 3/3] hugetlbfs: replace hugetlb_vma_lock with invalidate_lock
Date:   Sat, 30 Sep 2023 20:55:50 -0400
Message-ID: <20231001005659.2185316-4-riel@surriel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231001005659.2185316-1-riel@surriel.com>
References: <20231001005659.2185316-1-riel@surriel.com>
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

Replace the custom hugetlbfs VMA locking code with the recently
introduced invalidate_lock. This greatly simplifies things.

However, this is a large enough change that it should probably go in
separately from the other changes.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Rik van Riel <riel@surriel.com>
---
 fs/hugetlbfs/inode.c    |  68 +-----------
 include/linux/fs.h      |   6 ++
 include/linux/hugetlb.h |  21 +---
 mm/hugetlb.c            | 227 ++++------------------------------------
 4 files changed, 32 insertions(+), 290 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 316c4cebd3f3..711fd3f5d86f 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -485,7 +485,6 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
 					struct folio *folio, pgoff_t index)
 {
 	struct rb_root_cached *root = &mapping->i_mmap;
-	struct hugetlb_vma_lock *vma_lock;
 	struct page *page = &folio->page;
 	struct vm_area_struct *vma;
 	unsigned long v_start;
@@ -495,9 +494,9 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
 	start = index * pages_per_huge_page(h);
 	end = (index + 1) * pages_per_huge_page(h);
 
+	filemap_invalidate_lock(mapping);
 	i_mmap_lock_write(mapping);
-retry:
-	vma_lock = NULL;
+
 	vma_interval_tree_foreach(vma, root, start, end - 1) {
 		v_start = vma_offset_start(vma, start);
 		v_end = vma_offset_end(vma, end);
@@ -505,62 +504,13 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
 		if (!hugetlb_vma_maps_page(vma, v_start, page))
 			continue;
 
-		if (!hugetlb_vma_trylock_write(vma)) {
-			vma_lock = vma->vm_private_data;
-			/*
-			 * If we can not get vma lock, we need to drop
-			 * immap_sema and take locks in order.  First,
-			 * take a ref on the vma_lock structure so that
-			 * we can be guaranteed it will not go away when
-			 * dropping immap_sema.
-			 */
-			kref_get(&vma_lock->refs);
-			break;
-		}
-
 		unmap_hugepage_range(vma, v_start, v_end, NULL,
 				     ZAP_FLAG_DROP_MARKER);
 		hugetlb_vma_unlock_write(vma);
 	}
 
+	filemap_invalidate_unlock(mapping);
 	i_mmap_unlock_write(mapping);
-
-	if (vma_lock) {
-		/*
-		 * Wait on vma_lock.  We know it is still valid as we have
-		 * a reference.  We must 'open code' vma locking as we do
-		 * not know if vma_lock is still attached to vma.
-		 */
-		down_write(&vma_lock->rw_sema);
-		i_mmap_lock_write(mapping);
-
-		vma = vma_lock->vma;
-		if (!vma) {
-			/*
-			 * If lock is no longer attached to vma, then just
-			 * unlock, drop our reference and retry looking for
-			 * other vmas.
-			 */
-			up_write(&vma_lock->rw_sema);
-			kref_put(&vma_lock->refs, hugetlb_vma_lock_release);
-			goto retry;
-		}
-
-		/*
-		 * vma_lock is still attached to vma.  Check to see if vma
-		 * still maps page and if so, unmap.
-		 */
-		v_start = vma_offset_start(vma, start);
-		v_end = vma_offset_end(vma, end);
-		if (hugetlb_vma_maps_page(vma, v_start, page))
-			unmap_hugepage_range(vma, v_start, v_end, NULL,
-					     ZAP_FLAG_DROP_MARKER);
-
-		kref_put(&vma_lock->refs, hugetlb_vma_lock_release);
-		hugetlb_vma_unlock_write(vma);
-
-		goto retry;
-	}
 }
 
 static void
@@ -578,20 +528,10 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
 		unsigned long v_start;
 		unsigned long v_end;
 
-		if (!hugetlb_vma_trylock_write(vma))
-			continue;
-
 		v_start = vma_offset_start(vma, start);
 		v_end = vma_offset_end(vma, end);
 
 		unmap_hugepage_range(vma, v_start, v_end, NULL, zap_flags);
-
-		/*
-		 * Note that vma lock only exists for shared/non-private
-		 * vmas.  Therefore, lock is not held when calling
-		 * unmap_hugepage_range for private vmas.
-		 */
-		hugetlb_vma_unlock_write(vma);
 	}
 }
 
@@ -725,10 +665,12 @@ static void hugetlb_vmtruncate(struct inode *inode, loff_t offset)
 	pgoff = offset >> PAGE_SHIFT;
 
 	i_size_write(inode, offset);
+	filemap_invalidate_lock(mapping);
 	i_mmap_lock_write(mapping);
 	if (!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root))
 		hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0,
 				      ZAP_FLAG_DROP_MARKER);
+	filemap_invalidate_unlock(mapping);
 	i_mmap_unlock_write(mapping);
 	remove_inode_hugepages(inode, offset, LLONG_MAX);
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4aeb3fa11927..b455a8913db4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -847,6 +847,12 @@ static inline void filemap_invalidate_lock(struct address_space *mapping)
 	down_write(&mapping->invalidate_lock);
 }
 
+static inline int filemap_invalidate_trylock(
+					struct address_space *mapping)
+{
+	return down_write_trylock(&mapping->invalidate_lock);
+}
+
 static inline void filemap_invalidate_unlock(struct address_space *mapping)
 {
 	up_write(&mapping->invalidate_lock);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index d9ec500cfef9..2908c47e7bf2 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -60,7 +60,6 @@ struct resv_map {
 	long adds_in_progress;
 	struct list_head region_cache;
 	long region_cache_count;
-	struct rw_semaphore rw_sema;
 #ifdef CONFIG_CGROUP_HUGETLB
 	/*
 	 * On private mappings, the counter to uncharge reservations is stored
@@ -107,12 +106,6 @@ struct file_region {
 #endif
 };
 
-struct hugetlb_vma_lock {
-	struct kref refs;
-	struct rw_semaphore rw_sema;
-	struct vm_area_struct *vma;
-};
-
 extern struct resv_map *resv_map_alloc(void);
 void resv_map_release(struct kref *ref);
 
@@ -1277,17 +1270,9 @@ hugetlb_walk(struct vm_area_struct *vma, unsigned long addr, unsigned long sz)
 {
 #if defined(CONFIG_HUGETLB_PAGE) && \
 	defined(CONFIG_ARCH_WANT_HUGE_PMD_SHARE) && defined(CONFIG_LOCKDEP)
-	struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
-
-	/*
-	 * If pmd sharing possible, locking needed to safely walk the
-	 * hugetlb pgtables.  More information can be found at the comment
-	 * above huge_pte_offset() in the same file.
-	 *
-	 * NOTE: lockdep_is_held() is only defined with CONFIG_LOCKDEP.
-	 */
-	if (__vma_shareable_lock(vma))
-		WARN_ON_ONCE(!lockdep_is_held(&vma_lock->rw_sema) &&
+	if (vma->vm_file)
+		WARN_ON_ONCE(!lockdep_is_held(
+				 &vma->vm_file->f_mapping->invalidate_lock) &&
 			     !lockdep_is_held(
 				 &vma->vm_file->f_mapping->i_mmap_rwsem));
 #endif
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 397a26f70deb..749f38537e4d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -92,9 +92,6 @@ struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
 
 /* Forward declaration */
 static int hugetlb_acct_memory(struct hstate *h, long delta);
-static void hugetlb_vma_lock_free(struct vm_area_struct *vma);
-static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma);
-static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma);
 static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end);
 static struct resv_map *vma_resv_map(struct vm_area_struct *vma);
@@ -264,170 +261,41 @@ static inline struct hugepage_subpool *subpool_vma(struct vm_area_struct *vma)
  */
 void hugetlb_vma_lock_read(struct vm_area_struct *vma)
 {
-	if (__vma_shareable_lock(vma)) {
-		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
-
-		down_read(&vma_lock->rw_sema);
-	} else if (__vma_private_lock(vma)) {
-		struct resv_map *resv_map = vma_resv_map(vma);
-
-		down_read(&resv_map->rw_sema);
-	}
+	if (vma->vm_file)
+		filemap_invalidate_lock_shared(vma->vm_file->f_mapping);
 }
 
 void hugetlb_vma_unlock_read(struct vm_area_struct *vma)
 {
-	if (__vma_shareable_lock(vma)) {
-		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
-
-		up_read(&vma_lock->rw_sema);
-	} else if (__vma_private_lock(vma)) {
-		struct resv_map *resv_map = vma_resv_map(vma);
-
-		up_read(&resv_map->rw_sema);
-	}
+	if (vma->vm_file)
+		filemap_invalidate_unlock_shared(vma->vm_file->f_mapping);
 }
 
 void hugetlb_vma_lock_write(struct vm_area_struct *vma)
 {
-	if (__vma_shareable_lock(vma)) {
-		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
-
-		down_write(&vma_lock->rw_sema);
-	} else if (__vma_private_lock(vma)) {
-		struct resv_map *resv_map = vma_resv_map(vma);
-
-		down_write(&resv_map->rw_sema);
-	}
+	if (vma->vm_file)
+		filemap_invalidate_lock(vma->vm_file->f_mapping);
 }
 
 void hugetlb_vma_unlock_write(struct vm_area_struct *vma)
 {
-	if (__vma_shareable_lock(vma)) {
-		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
-
-		up_write(&vma_lock->rw_sema);
-	} else if (__vma_private_lock(vma)) {
-		struct resv_map *resv_map = vma_resv_map(vma);
-
-		up_write(&resv_map->rw_sema);
-	}
+	if (vma->vm_file)
+		filemap_invalidate_unlock(vma->vm_file->f_mapping);
 }
 
 int hugetlb_vma_trylock_write(struct vm_area_struct *vma)
 {
 
-	if (__vma_shareable_lock(vma)) {
-		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
-
-		return down_write_trylock(&vma_lock->rw_sema);
-	} else if (__vma_private_lock(vma)) {
-		struct resv_map *resv_map = vma_resv_map(vma);
-
-		return down_write_trylock(&resv_map->rw_sema);
-	}
+	if (vma->vm_file)
+		return filemap_invalidate_trylock(vma->vm_file->f_mapping);
 
 	return 1;
 }
 
 void hugetlb_vma_assert_locked(struct vm_area_struct *vma)
 {
-	if (__vma_shareable_lock(vma)) {
-		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
-
-		lockdep_assert_held(&vma_lock->rw_sema);
-	} else if (__vma_private_lock(vma)) {
-		struct resv_map *resv_map = vma_resv_map(vma);
-
-		lockdep_assert_held(&resv_map->rw_sema);
-	}
-}
-
-void hugetlb_vma_lock_release(struct kref *kref)
-{
-	struct hugetlb_vma_lock *vma_lock = container_of(kref,
-			struct hugetlb_vma_lock, refs);
-
-	kfree(vma_lock);
-}
-
-static void __hugetlb_vma_unlock_write_put(struct hugetlb_vma_lock *vma_lock)
-{
-	struct vm_area_struct *vma = vma_lock->vma;
-
-	/*
-	 * vma_lock structure may or not be released as a result of put,
-	 * it certainly will no longer be attached to vma so clear pointer.
-	 * Semaphore synchronizes access to vma_lock->vma field.
-	 */
-	vma_lock->vma = NULL;
-	vma->vm_private_data = NULL;
-	up_write(&vma_lock->rw_sema);
-	kref_put(&vma_lock->refs, hugetlb_vma_lock_release);
-}
-
-static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma)
-{
-	if (__vma_shareable_lock(vma)) {
-		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
-
-		__hugetlb_vma_unlock_write_put(vma_lock);
-	} else if (__vma_private_lock(vma)) {
-		struct resv_map *resv_map = vma_resv_map(vma);
-
-		/* no free for anon vmas, but still need to unlock */
-		up_write(&resv_map->rw_sema);
-	}
-}
-
-static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
-{
-	/*
-	 * Only present in sharable vmas.
-	 */
-	if (!vma || !__vma_shareable_lock(vma))
-		return;
-
-	if (vma->vm_private_data) {
-		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
-
-		down_write(&vma_lock->rw_sema);
-		__hugetlb_vma_unlock_write_put(vma_lock);
-	}
-}
-
-static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
-{
-	struct hugetlb_vma_lock *vma_lock;
-
-	/* Only establish in (flags) sharable vmas */
-	if (!vma || !(vma->vm_flags & VM_MAYSHARE))
-		return;
-
-	/* Should never get here with non-NULL vm_private_data */
-	if (vma->vm_private_data)
-		return;
-
-	vma_lock = kmalloc(sizeof(*vma_lock), GFP_KERNEL);
-	if (!vma_lock) {
-		/*
-		 * If we can not allocate structure, then vma can not
-		 * participate in pmd sharing.  This is only a possible
-		 * performance enhancement and memory saving issue.
-		 * However, the lock is also used to synchronize page
-		 * faults with truncation.  If the lock is not present,
-		 * unlikely races could leave pages in a file past i_size
-		 * until the file is removed.  Warn in the unlikely case of
-		 * allocation failure.
-		 */
-		pr_warn_once("HugeTLB: unable to allocate vma specific lock\n");
-		return;
-	}
-
-	kref_init(&vma_lock->refs);
-	init_rwsem(&vma_lock->rw_sema);
-	vma_lock->vma = vma;
-	vma->vm_private_data = vma_lock;
+	if (vma->vm_file)
+		lockdep_assert_held(&vma->vm_file->f_mapping->invalidate_lock);
 }
 
 /* Helper that removes a struct file_region from the resv_map cache and returns
@@ -1100,7 +968,6 @@ struct resv_map *resv_map_alloc(void)
 	kref_init(&resv_map->refs);
 	spin_lock_init(&resv_map->lock);
 	INIT_LIST_HEAD(&resv_map->regions);
-	init_rwsem(&resv_map->rw_sema);
 
 	resv_map->adds_in_progress = 0;
 	/*
@@ -1195,22 +1062,11 @@ void hugetlb_dup_vma_private(struct vm_area_struct *vma)
 	VM_BUG_ON_VMA(!is_vm_hugetlb_page(vma), vma);
 	/*
 	 * Clear vm_private_data
-	 * - For shared mappings this is a per-vma semaphore that may be
-	 *   allocated in a subsequent call to hugetlb_vm_op_open.
-	 *   Before clearing, make sure pointer is not associated with vma
-	 *   as this will leak the structure.  This is the case when called
-	 *   via clear_vma_resv_huge_pages() and hugetlb_vm_op_open has already
-	 *   been called to allocate a new structure.
 	 * - For MAP_PRIVATE mappings, this is the reserve map which does
 	 *   not apply to children.  Faults generated by the children are
 	 *   not guaranteed to succeed, even if read-only.
 	 */
-	if (vma->vm_flags & VM_MAYSHARE) {
-		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
-
-		if (vma_lock && vma_lock->vma != vma)
-			vma->vm_private_data = NULL;
-	} else
+	if (!(vma->vm_flags & VM_MAYSHARE))
 		vma->vm_private_data = NULL;
 }
 
@@ -4846,25 +4702,6 @@ static void hugetlb_vm_op_open(struct vm_area_struct *vma)
 		resv_map_dup_hugetlb_cgroup_uncharge_info(resv);
 		kref_get(&resv->refs);
 	}
-
-	/*
-	 * vma_lock structure for sharable mappings is vma specific.
-	 * Clear old pointer (if copied via vm_area_dup) and allocate
-	 * new structure.  Before clearing, make sure vma_lock is not
-	 * for this vma.
-	 */
-	if (vma->vm_flags & VM_MAYSHARE) {
-		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
-
-		if (vma_lock) {
-			if (vma_lock->vma != vma) {
-				vma->vm_private_data = NULL;
-				hugetlb_vma_lock_alloc(vma);
-			} else
-				pr_warn("HugeTLB: vma_lock already exists in %s.\n", __func__);
-		} else
-			hugetlb_vma_lock_alloc(vma);
-	}
 }
 
 static void hugetlb_vm_op_close(struct vm_area_struct *vma)
@@ -4875,8 +4712,6 @@ static void hugetlb_vm_op_close(struct vm_area_struct *vma)
 	unsigned long reserve, start, end;
 	long gbl_reserve;
 
-	hugetlb_vma_lock_free(vma);
-
 	resv = vma_resv_map(vma);
 	if (!resv || !is_vma_resv_set(vma, HPAGE_RESV_OWNER))
 		return;
@@ -5440,30 +5275,16 @@ void __hugetlb_zap_begin(struct vm_area_struct *vma,
 {
 	adjust_range_if_pmd_sharing_possible(vma, start, end);
 	hugetlb_vma_lock_write(vma);
-	i_mmap_lock_write(vma->vm_file->f_mapping);
+	if (vma->vm_file)
+		i_mmap_lock_write(vma->vm_file->f_mapping);
 }
 
 void __hugetlb_zap_end(struct vm_area_struct *vma,
 		       struct zap_details *details)
 {
-	zap_flags_t zap_flags = details ? details->zap_flags : 0;
-
-	if (zap_flags & ZAP_FLAG_UNMAP) {	/* final unmap */
-		/*
-		 * Unlock and free the vma lock before releasing i_mmap_rwsem.
-		 * When the vma_lock is freed, this makes the vma ineligible
-		 * for pmd sharing.  And, i_mmap_rwsem is required to set up
-		 * pmd sharing.  This is important as page tables for this
-		 * unmapped range will be asynchrously deleted.  If the page
-		 * tables are shared, there will be issues when accessed by
-		 * someone else.
-		 */
-		__hugetlb_vma_unlock_write_free(vma);
-		i_mmap_unlock_write(vma->vm_file->f_mapping);
-	} else {
+	if (vma->vm_file)
 		i_mmap_unlock_write(vma->vm_file->f_mapping);
-		hugetlb_vma_unlock_write(vma);
-	}
+	hugetlb_vma_unlock_write(vma);
 }
 
 void unmap_hugepage_range(struct vm_area_struct *vma, unsigned long start,
@@ -6706,12 +6527,6 @@ bool hugetlb_reserve_pages(struct inode *inode,
 		return false;
 	}
 
-	/*
-	 * vma specific semaphore used for pmd sharing and fault/truncation
-	 * synchronization
-	 */
-	hugetlb_vma_lock_alloc(vma);
-
 	/*
 	 * Only apply hugepage reservation if asked. At fault time, an
 	 * attempt will be made for VM_NORESERVE to allocate a page
@@ -6834,7 +6649,6 @@ bool hugetlb_reserve_pages(struct inode *inode,
 	hugetlb_cgroup_uncharge_cgroup_rsvd(hstate_index(h),
 					    chg * pages_per_huge_page(h), h_cg);
 out_err:
-	hugetlb_vma_lock_free(vma);
 	if (!vma || vma->vm_flags & VM_MAYSHARE)
 		/* Only call region_abort if the region_chg succeeded but the
 		 * region_add failed or didn't run.
@@ -6904,13 +6718,10 @@ static unsigned long page_table_shareable(struct vm_area_struct *svma,
 	/*
 	 * match the virtual addresses, permission and the alignment of the
 	 * page table page.
-	 *
-	 * Also, vma_lock (vm_private_data) is required for sharing.
 	 */
 	if (pmd_index(addr) != pmd_index(saddr) ||
 	    vm_flags != svm_flags ||
-	    !range_in_vma(svma, sbase, s_end) ||
-	    !svma->vm_private_data)
+	    !range_in_vma(svma, sbase, s_end))
 		return 0;
 
 	return saddr;
@@ -6930,8 +6741,6 @@ bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr)
 	 */
 	if (!(vma->vm_flags & VM_MAYSHARE))
 		return false;
-	if (!vma->vm_private_data)	/* vma lock required for sharing */
-		return false;
 	if (!range_in_vma(vma, start, end))
 		return false;
 	return true;
-- 
2.41.0

