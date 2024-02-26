Return-Path: <linux-kernel+bounces-80585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C0D8669F4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79D461C21750
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487891BDD3;
	Mon, 26 Feb 2024 06:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="erWq4jzw"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFCA1BDC3
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 06:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708928210; cv=none; b=YSl36icCbGmnU/OCBvA7iCjQ0M1D1/wZiHp25HikA3n46SoR/mLwAL51d+Z1YICnjHx8SUMZ+T8ED6s3yTWZz5mI2hLqYbZHwLQrfVbYi1w869poO0rWcem7oT/VWpWFzG2BNZRwQEk0LsEJtXltCL+zlbwoGUZiFJchDBOEDpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708928210; c=relaxed/simple;
	bh=3rBIaCLeiMrOTKEPU1XjdOhrMPC8eqLJA91bVDCdWxc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q6YYhdFajW8fRzly1hR+j1hA9aUYkUvnHZ/pQsD3nAKRxQqixk4C2AyNLZ4bIO43u7+DYPGgyKfO27vTZ9N/TZX7ghaKQ3fbhsIG3aDpsZKji45OBwwt/KDJoo6/UlM+f+Q+aSN/EtsS2U2ifveXdpzA77kiSaVdR6Hqwyvcreo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=erWq4jzw; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708928205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JjaYHgkRo+HArDofTwXCP2Sm8MgjiGUr89MTdaF6Ww0=;
	b=erWq4jzwylx2F5LwcHTFRRi1LaL22vPSdQgqSa9s/ncuRq6AYcokRUmNqvU1wIRo+VnlCT
	3sEuGQnMcaL9q3kROep68Nn+7t/1w3cqIebFKZKe7+o/Eblu7aE9kgqGZe5L/tMnN6vTk+
	2qj+XDLflJoOx3rh1z1H9mExC1rq2R4=
From: Yajun Deng <yajun.deng@linux.dev>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	lstoakes@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH v2] mm/mmap: convert all mas except mas_detach to vma iterator
Date: Mon, 26 Feb 2024 14:16:24 +0800
Message-Id: <20240226061624.860382-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

There are two types of iterators mas and vmi in the current code. If the
maple tree comes from the mm struct, we can use the vma iterator. Avoid
using mas directly as possible.

Keep using mas for the mt_detach tree, since it doesn't come from the mm
struct.

Remove as many mas uses as feasible, but we will still have a few that
must be passed through in unmap_vmas() and free_pgtables().

Also introduce vma_iter_reset, vma_iter_{prev, next}_range_limit and
vma_iter_area_{lowest, highest} helper functions for using vma interator.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
v2: Add vma_iter_reset() and vma_iter_{prev, next}_range_limit() helper functions.
v1: https://lore.kernel.org/all/9f76ce23-67b1-ccbe-a722-1db0e8f0a408@linux.dev/
---
 mm/internal.h |  29 +++++++++++++
 mm/mmap.c     | 113 +++++++++++++++++++++++++-------------------------
 2 files changed, 85 insertions(+), 57 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index c89fea8bf77f..c813eb58122c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1149,6 +1149,35 @@ static inline void vma_iter_config(struct vma_iterator *vmi,
 	__mas_set_range(&vmi->mas, index, last - 1);
 }
 
+static inline void vma_iter_reset(struct vma_iterator *vmi)
+{
+	mas_reset(&vmi->mas);
+}
+
+static inline
+struct vm_area_struct *vma_iter_prev_range_limit(struct vma_iterator *vmi, unsigned long min)
+{
+	return mas_prev_range(&vmi->mas, min);
+}
+
+static inline
+struct vm_area_struct *vma_iter_next_range_limit(struct vma_iterator *vmi, unsigned long max)
+{
+	return mas_next_range(&vmi->mas, max);
+}
+
+static inline int vma_iter_area_lowest(struct vma_iterator *vmi, unsigned long min,
+				       unsigned long max, unsigned long size)
+{
+	return mas_empty_area(&vmi->mas, min, max - 1, size);
+}
+
+static inline int vma_iter_area_highest(struct vma_iterator *vmi, unsigned long min,
+					unsigned long max, unsigned long size)
+{
+	return mas_empty_area_rev(&vmi->mas, min, max - 1, size);
+}
+
 /*
  * VMA Iterator functions shared between nommu and mmap
  */
diff --git a/mm/mmap.c b/mm/mmap.c
index 7a33365bd0da..7e43550a7ca6 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1115,21 +1115,21 @@ static struct anon_vma *reusable_anon_vma(struct vm_area_struct *old, struct vm_
  */
 struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *vma)
 {
-	MA_STATE(mas, &vma->vm_mm->mm_mt, vma->vm_end, vma->vm_end);
 	struct anon_vma *anon_vma = NULL;
 	struct vm_area_struct *prev, *next;
+	VMA_ITERATOR(vmi, vma->vm_mm, vma->vm_end);
 
 	/* Try next first. */
-	next = mas_walk(&mas);
+	next = vma_iter_load(&vmi);
 	if (next) {
 		anon_vma = reusable_anon_vma(next, vma, next);
 		if (anon_vma)
 			return anon_vma;
 	}
 
-	prev = mas_prev(&mas, 0);
+	prev = vma_prev(&vmi);
 	VM_BUG_ON_VMA(prev != vma, vma);
-	prev = mas_prev(&mas, 0);
+	prev = vma_prev(&vmi);
 	/* Try prev next. */
 	if (prev)
 		anon_vma = reusable_anon_vma(prev, prev, vma);
@@ -1580,8 +1580,7 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 	unsigned long length, gap;
 	unsigned long low_limit, high_limit;
 	struct vm_area_struct *tmp;
-
-	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
+	VMA_ITERATOR(vmi, current->mm, 0);
 
 	/* Adjust search length to account for worst case alignment overhead */
 	length = info->length + info->align_mask;
@@ -1593,23 +1592,23 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 		low_limit = mmap_min_addr;
 	high_limit = info->high_limit;
 retry:
-	if (mas_empty_area(&mas, low_limit, high_limit - 1, length))
+	if (vma_iter_area_lowest(&vmi, low_limit, high_limit, length))
 		return -ENOMEM;
 
-	gap = mas.index;
+	gap = vma_iter_addr(&vmi);
 	gap += (info->align_offset - gap) & info->align_mask;
-	tmp = mas_next(&mas, ULONG_MAX);
+	tmp = vma_next(&vmi);
 	if (tmp && (tmp->vm_flags & VM_STARTGAP_FLAGS)) { /* Avoid prev check if possible */
 		if (vm_start_gap(tmp) < gap + length - 1) {
 			low_limit = tmp->vm_end;
-			mas_reset(&mas);
+			vma_iter_reset(&vmi);
 			goto retry;
 		}
 	} else {
-		tmp = mas_prev(&mas, 0);
+		tmp = vma_prev(&vmi);
 		if (tmp && vm_end_gap(tmp) > gap) {
 			low_limit = vm_end_gap(tmp);
-			mas_reset(&mas);
+			vma_iter_reset(&vmi);
 			goto retry;
 		}
 	}
@@ -1632,8 +1631,8 @@ static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 	unsigned long length, gap, gap_end;
 	unsigned long low_limit, high_limit;
 	struct vm_area_struct *tmp;
+	VMA_ITERATOR(vmi, current->mm, 0);
 
-	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
 	/* Adjust search length to account for worst case alignment overhead */
 	length = info->length + info->align_mask;
 	if (length < info->length)
@@ -1644,24 +1643,24 @@ static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 		low_limit = mmap_min_addr;
 	high_limit = info->high_limit;
 retry:
-	if (mas_empty_area_rev(&mas, low_limit, high_limit - 1, length))
+	if (vma_iter_area_highest(&vmi, low_limit, high_limit, length))
 		return -ENOMEM;
 
-	gap = mas.last + 1 - info->length;
+	gap = vma_iter_end(&vmi) - info->length;
 	gap -= (gap - info->align_offset) & info->align_mask;
-	gap_end = mas.last;
-	tmp = mas_next(&mas, ULONG_MAX);
+	gap_end = vma_iter_end(&vmi);
+	tmp = vma_next(&vmi);
 	if (tmp && (tmp->vm_flags & VM_STARTGAP_FLAGS)) { /* Avoid prev check if possible */
-		if (vm_start_gap(tmp) <= gap_end) {
+		if (vm_start_gap(tmp) < gap_end) {
 			high_limit = vm_start_gap(tmp);
-			mas_reset(&mas);
+			vma_iter_reset(&vmi);
 			goto retry;
 		}
 	} else {
-		tmp = mas_prev(&mas, 0);
+		tmp = vma_prev(&vmi);
 		if (tmp && vm_end_gap(tmp) > gap) {
 			high_limit = tmp->vm_start;
-			mas_reset(&mas);
+			vma_iter_reset(&vmi);
 			goto retry;
 		}
 	}
@@ -1916,12 +1915,12 @@ find_vma_prev(struct mm_struct *mm, unsigned long addr,
 			struct vm_area_struct **pprev)
 {
 	struct vm_area_struct *vma;
-	MA_STATE(mas, &mm->mm_mt, addr, addr);
+	VMA_ITERATOR(vmi, mm, addr);
 
-	vma = mas_walk(&mas);
-	*pprev = mas_prev(&mas, 0);
+	vma = vma_iter_load(&vmi);
+	*pprev = vma_prev(&vmi);
 	if (!vma)
-		vma = mas_next(&mas, ULONG_MAX);
+		vma = vma_next(&vmi);
 	return vma;
 }
 
@@ -1975,7 +1974,7 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 	struct vm_area_struct *next;
 	unsigned long gap_addr;
 	int error = 0;
-	MA_STATE(mas, &mm->mm_mt, vma->vm_start, address);
+	VMA_ITERATOR(vmi, mm, vma->vm_start);
 
 	if (!(vma->vm_flags & VM_GROWSUP))
 		return -EFAULT;
@@ -2001,15 +2000,15 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 	}
 
 	if (next)
-		mas_prev_range(&mas, address);
+		vma_iter_prev_range_limit(&vmi, address);
 
-	__mas_set_range(&mas, vma->vm_start, address - 1);
-	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+	vma_iter_config(&vmi, vma->vm_start, address);
+	if (vma_iter_prealloc(&vmi, vma))
 		return -ENOMEM;
 
 	/* We must make sure the anon_vma is allocated. */
 	if (unlikely(anon_vma_prepare(vma))) {
-		mas_destroy(&mas);
+		vma_iter_free(&vmi);
 		return -ENOMEM;
 	}
 
@@ -2049,7 +2048,7 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 				anon_vma_interval_tree_pre_update_vma(vma);
 				vma->vm_end = address;
 				/* Overwrite old entry in mtree. */
-				mas_store_prealloc(&mas, vma);
+				vma_iter_store(&vmi, vma);
 				anon_vma_interval_tree_post_update_vma(vma);
 				spin_unlock(&mm->page_table_lock);
 
@@ -2058,7 +2057,7 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 		}
 	}
 	anon_vma_unlock_write(vma->anon_vma);
-	mas_destroy(&mas);
+	vma_iter_free(&vmi);
 	validate_mm(mm);
 	return error;
 }
@@ -2071,9 +2070,9 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_start);
 	struct vm_area_struct *prev;
 	int error = 0;
+	VMA_ITERATOR(vmi, mm, vma->vm_start);
 
 	if (!(vma->vm_flags & VM_GROWSDOWN))
 		return -EFAULT;
@@ -2083,7 +2082,7 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 		return -EPERM;
 
 	/* Enforce stack_guard_gap */
-	prev = mas_prev(&mas, 0);
+	prev = vma_prev(&vmi);
 	/* Check that both stack segments have the same anon_vma? */
 	if (prev) {
 		if (!(prev->vm_flags & VM_GROWSDOWN) &&
@@ -2093,15 +2092,15 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 	}
 
 	if (prev)
-		mas_next_range(&mas, vma->vm_start);
+		vma_iter_next_range_limit(&vmi, vma->vm_start);
 
-	__mas_set_range(&mas, address, vma->vm_end - 1);
-	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+	vma_iter_config(&vmi, address, vma->vm_end);
+	if (vma_iter_prealloc(&vmi, vma))
 		return -ENOMEM;
 
 	/* We must make sure the anon_vma is allocated. */
 	if (unlikely(anon_vma_prepare(vma))) {
-		mas_destroy(&mas);
+		vma_iter_free(&vmi);
 		return -ENOMEM;
 	}
 
@@ -2142,7 +2141,7 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 				vma->vm_start = address;
 				vma->vm_pgoff -= grow;
 				/* Overwrite old entry in mtree. */
-				mas_store_prealloc(&mas, vma);
+				vma_iter_store(&vmi, vma);
 				anon_vma_interval_tree_post_update_vma(vma);
 				spin_unlock(&mm->page_table_lock);
 
@@ -2151,7 +2150,7 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 		}
 	}
 	anon_vma_unlock_write(vma->anon_vma);
-	mas_destroy(&mas);
+	vma_iter_free(&vmi);
 	validate_mm(mm);
 	return error;
 }
@@ -3246,7 +3245,7 @@ void exit_mmap(struct mm_struct *mm)
 	struct mmu_gather tlb;
 	struct vm_area_struct *vma;
 	unsigned long nr_accounted = 0;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	VMA_ITERATOR(vmi, mm, 0);
 	int count = 0;
 
 	/* mm's last user has gone, and its about to be pulled down */
@@ -3255,7 +3254,7 @@ void exit_mmap(struct mm_struct *mm)
 	mmap_read_lock(mm);
 	arch_exit_mmap(mm);
 
-	vma = mas_find(&mas, ULONG_MAX);
+	vma = vma_next(&vmi);
 	if (!vma || unlikely(xa_is_zero(vma))) {
 		/* Can happen if dup_mmap() received an OOM */
 		mmap_read_unlock(mm);
@@ -3268,7 +3267,7 @@ void exit_mmap(struct mm_struct *mm)
 	tlb_gather_mmu_fullmm(&tlb, mm);
 	/* update_hiwater_rss(mm) here? but nobody should be looking */
 	/* Use ULONG_MAX here to ensure all VMAs in the mm are unmapped */
-	unmap_vmas(&tlb, &mas, vma, 0, ULONG_MAX, ULONG_MAX, false);
+	unmap_vmas(&tlb, &vmi.mas, vma, 0, ULONG_MAX, ULONG_MAX, false);
 	mmap_read_unlock(mm);
 
 	/*
@@ -3278,8 +3277,8 @@ void exit_mmap(struct mm_struct *mm)
 	set_bit(MMF_OOM_SKIP, &mm->flags);
 	mmap_write_lock(mm);
 	mt_clear_in_rcu(&mm->mm_mt);
-	mas_set(&mas, vma->vm_end);
-	free_pgtables(&tlb, &mas, vma, FIRST_USER_ADDRESS,
+	vma_iter_set(&vmi, vma->vm_end);
+	free_pgtables(&tlb, &vmi.mas, vma, FIRST_USER_ADDRESS,
 		      USER_PGTABLES_CEILING, true);
 	tlb_finish_mmu(&tlb);
 
@@ -3288,14 +3287,14 @@ void exit_mmap(struct mm_struct *mm)
 	 * enabled, without holding any MM locks besides the unreachable
 	 * mmap_write_lock.
 	 */
-	mas_set(&mas, vma->vm_end);
+	vma_iter_set(&vmi, vma->vm_end);
 	do {
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted += vma_pages(vma);
 		remove_vma(vma, true);
 		count++;
 		cond_resched();
-		vma = mas_find(&mas, ULONG_MAX);
+		vma = vma_next(&vmi);
 	} while (vma && likely(!xa_is_zero(vma)));
 
 	BUG_ON(count != mm->map_count);
@@ -3717,7 +3716,7 @@ int mm_take_all_locks(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	struct anon_vma_chain *avc;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	VMA_ITERATOR(vmi, mm, 0);
 
 	mmap_assert_write_locked(mm);
 
@@ -3729,14 +3728,14 @@ int mm_take_all_locks(struct mm_struct *mm)
 	 * being written to until mmap_write_unlock() or mmap_write_downgrade()
 	 * is reached.
 	 */
-	mas_for_each(&mas, vma, ULONG_MAX) {
+	for_each_vma(vmi, vma) {
 		if (signal_pending(current))
 			goto out_unlock;
 		vma_start_write(vma);
 	}
 
-	mas_set(&mas, 0);
-	mas_for_each(&mas, vma, ULONG_MAX) {
+	vma_iter_init(&vmi, mm, 0);
+	for_each_vma(vmi, vma) {
 		if (signal_pending(current))
 			goto out_unlock;
 		if (vma->vm_file && vma->vm_file->f_mapping &&
@@ -3744,8 +3743,8 @@ int mm_take_all_locks(struct mm_struct *mm)
 			vm_lock_mapping(mm, vma->vm_file->f_mapping);
 	}
 
-	mas_set(&mas, 0);
-	mas_for_each(&mas, vma, ULONG_MAX) {
+	vma_iter_init(&vmi, mm, 0);
+	for_each_vma(vmi, vma) {
 		if (signal_pending(current))
 			goto out_unlock;
 		if (vma->vm_file && vma->vm_file->f_mapping &&
@@ -3753,8 +3752,8 @@ int mm_take_all_locks(struct mm_struct *mm)
 			vm_lock_mapping(mm, vma->vm_file->f_mapping);
 	}
 
-	mas_set(&mas, 0);
-	mas_for_each(&mas, vma, ULONG_MAX) {
+	vma_iter_init(&vmi, mm, 0);
+	for_each_vma(vmi, vma) {
 		if (signal_pending(current))
 			goto out_unlock;
 		if (vma->anon_vma)
@@ -3813,12 +3812,12 @@ void mm_drop_all_locks(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	struct anon_vma_chain *avc;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	VMA_ITERATOR(vmi, mm, 0);
 
 	mmap_assert_write_locked(mm);
 	BUG_ON(!mutex_is_locked(&mm_all_locks_mutex));
 
-	mas_for_each(&mas, vma, ULONG_MAX) {
+	for_each_vma(vmi, vma) {
 		if (vma->anon_vma)
 			list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
 				vm_unlock_anon_vma(avc->anon_vma);
-- 
2.25.1


