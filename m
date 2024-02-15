Return-Path: <linux-kernel+bounces-66875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 788098562F4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02DF31F230C2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45FB12E1C3;
	Thu, 15 Feb 2024 12:18:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABED12D740
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 12:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707999494; cv=none; b=WadgaHtKqyII6HkmWi9qSKijysK8b3jRDCBtnY13EpddcK6k5C2+3U9zuC3uY7KJpsodoPQpuHOuFXbWPv6J+O9nRm45Rl6MZiKABvo5D40Ctom9lE67Zf3wNQWXTmSO9D4Q0GHiSssy/8yBcwBNGcL3Nd52TYvraxuHltjDo8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707999494; c=relaxed/simple;
	bh=/tuiT3Py4+8Z0/xPKrapDWvOvRSoeEqJvjCHSWeUIPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MOoK/RNmPcefnmiX9EaLf8n7Xb3z1IaznIwPcEOpq3XIcvawvt4gwdAGmJAxRWVAGuYnNhXoX9iui0oR7n6W29tWoAPA7E+U61O6RdFpVJP7LBu7Blp+ePb9v8VwxbiemD1l1Jda3+UvDq/g2YpmWtNTHeLYMejAFNA9P2A7Erg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACE0F14BF;
	Thu, 15 Feb 2024 04:18:52 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F9763F766;
	Thu, 15 Feb 2024 04:18:09 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: David Hildenbrand <david@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 3/4] mm/memory: Use ptep_get_lockless_norecency() for orig_pte
Date: Thu, 15 Feb 2024 12:17:55 +0000
Message-Id: <20240215121756.2734131-4-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240215121756.2734131-1-ryan.roberts@arm.com>
References: <20240215121756.2734131-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's convert handle_pte_fault()'s use of ptep_get_lockless() to
ptep_get_lockless_norecency() to save orig_pte.

There are a number of places that follow this model:

    orig_pte = ptep_get_lockless(ptep)
    ...
    <lock>
    if (!pte_same(orig_pte, ptep_get(ptep)))
            // RACE!
    ...
    <unlock>

So we need to be careful to convert all of those to use
pte_same_norecency() so that the access and dirty bits are excluded from
the comparison.

Additionally there are a couple of places that genuinely rely on the
access and dirty bits of orig_pte, but with some careful refactoring, we
can use ptep_get() once we are holding the lock to achieve equivalent
logic.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 mm/memory.c | 55 +++++++++++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 8e65fa1884f1..075245314ec3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3014,7 +3014,7 @@ static inline int pte_unmap_same(struct vm_fault *vmf)
 #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPTION)
 	if (sizeof(pte_t) > sizeof(unsigned long)) {
 		spin_lock(vmf->ptl);
-		same = pte_same(ptep_get(vmf->pte), vmf->orig_pte);
+		same = pte_same_norecency(ptep_get(vmf->pte), vmf->orig_pte);
 		spin_unlock(vmf->ptl);
 	}
 #endif
@@ -3062,11 +3062,14 @@ static inline int __wp_page_copy_user(struct page *dst, struct page *src,
 	 * take a double page fault, so mark it accessed here.
 	 */
 	vmf->pte = NULL;
-	if (!arch_has_hw_pte_young() && !pte_young(vmf->orig_pte)) {
+	if (!arch_has_hw_pte_young()) {
 		pte_t entry;

 		vmf->pte = pte_offset_map_lock(mm, vmf->pmd, addr, &vmf->ptl);
-		if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
+		if (likely(vmf->pte))
+			entry = ptep_get(vmf->pte);
+		if (unlikely(!vmf->pte ||
+			     !pte_same_norecency(entry, vmf->orig_pte))) {
 			/*
 			 * Other thread has already handled the fault
 			 * and update local tlb only
@@ -3077,9 +3080,11 @@ static inline int __wp_page_copy_user(struct page *dst, struct page *src,
 			goto pte_unlock;
 		}

-		entry = pte_mkyoung(vmf->orig_pte);
-		if (ptep_set_access_flags(vma, addr, vmf->pte, entry, 0))
-			update_mmu_cache_range(vmf, vma, addr, vmf->pte, 1);
+		if (!pte_young(entry)) {
+			entry = pte_mkyoung(entry);
+			if (ptep_set_access_flags(vma, addr, vmf->pte, entry, 0))
+				update_mmu_cache_range(vmf, vma, addr, vmf->pte, 1);
+		}
 	}

 	/*
@@ -3094,7 +3099,8 @@ static inline int __wp_page_copy_user(struct page *dst, struct page *src,

 		/* Re-validate under PTL if the page is still mapped */
 		vmf->pte = pte_offset_map_lock(mm, vmf->pmd, addr, &vmf->ptl);
-		if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
+		if (unlikely(!vmf->pte ||
+			     !pte_same_norecency(ptep_get(vmf->pte), vmf->orig_pte))) {
 			/* The PTE changed under us, update local tlb */
 			if (vmf->pte)
 				update_mmu_tlb(vma, addr, vmf->pte);
@@ -3369,14 +3375,17 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 	 * Re-check the pte - we dropped the lock
 	 */
 	vmf->pte = pte_offset_map_lock(mm, vmf->pmd, vmf->address, &vmf->ptl);
-	if (likely(vmf->pte && pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
+	if (likely(vmf->pte))
+		entry = ptep_get(vmf->pte);
+	if (likely(vmf->pte && pte_same_norecency(entry, vmf->orig_pte))) {
 		if (old_folio) {
 			if (!folio_test_anon(old_folio)) {
 				dec_mm_counter(mm, mm_counter_file(old_folio));
 				inc_mm_counter(mm, MM_ANONPAGES);
 			}
 		} else {
-			ksm_might_unmap_zero_page(mm, vmf->orig_pte);
+			/* Needs dirty bit so can't use vmf->orig_pte. */
+			ksm_might_unmap_zero_page(mm, entry);
 			inc_mm_counter(mm, MM_ANONPAGES);
 		}
 		flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
@@ -3494,7 +3503,7 @@ static vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf, struct folio *folio
 	 * We might have raced with another page fault while we released the
 	 * pte_offset_map_lock.
 	 */
-	if (!pte_same(ptep_get(vmf->pte), vmf->orig_pte)) {
+	if (!pte_same_norecency(ptep_get(vmf->pte), vmf->orig_pte)) {
 		update_mmu_tlb(vmf->vma, vmf->address, vmf->pte);
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 		return VM_FAULT_NOPAGE;
@@ -3883,7 +3892,8 @@ static vm_fault_t remove_device_exclusive_entry(struct vm_fault *vmf)

 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
 				&vmf->ptl);
-	if (likely(vmf->pte && pte_same(ptep_get(vmf->pte), vmf->orig_pte)))
+	if (likely(vmf->pte &&
+		   pte_same_norecency(ptep_get(vmf->pte), vmf->orig_pte)))
 		restore_exclusive_pte(vma, vmf->page, vmf->address, vmf->pte);

 	if (vmf->pte)
@@ -3928,7 +3938,7 @@ static vm_fault_t pte_marker_clear(struct vm_fault *vmf)
 	 * quickly from a PTE_MARKER_UFFD_WP into PTE_MARKER_POISONED.
 	 * So is_pte_marker() check is not enough to safely drop the pte.
 	 */
-	if (pte_same(vmf->orig_pte, ptep_get(vmf->pte)))
+	if (pte_same_norecency(vmf->orig_pte, ptep_get(vmf->pte)))
 		pte_clear(vmf->vma->vm_mm, vmf->address, vmf->pte);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	return 0;
@@ -4028,8 +4038,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
 					vmf->address, &vmf->ptl);
 			if (unlikely(!vmf->pte ||
-				     !pte_same(ptep_get(vmf->pte),
-							vmf->orig_pte)))
+				     !pte_same_norecency(ptep_get(vmf->pte),
+							 vmf->orig_pte)))
 				goto unlock;

 			/*
@@ -4117,7 +4127,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
 					vmf->address, &vmf->ptl);
 			if (likely(vmf->pte &&
-				   pte_same(ptep_get(vmf->pte), vmf->orig_pte)))
+				   pte_same_norecency(ptep_get(vmf->pte),
+						      vmf->orig_pte)))
 				ret = VM_FAULT_OOM;
 			goto unlock;
 		}
@@ -4187,7 +4198,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	 */
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
 			&vmf->ptl);
-	if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->orig_pte)))
+	if (unlikely(!vmf->pte ||
+		     !pte_same_norecency(ptep_get(vmf->pte), vmf->orig_pte)))
 		goto out_nomap;

 	if (unlikely(!folio_test_uptodate(folio))) {
@@ -4747,7 +4759,7 @@ void set_pte_range(struct vm_fault *vmf, struct folio *folio,
 static bool vmf_pte_changed(struct vm_fault *vmf)
 {
 	if (vmf->flags & FAULT_FLAG_ORIG_PTE_VALID)
-		return !pte_same(ptep_get(vmf->pte), vmf->orig_pte);
+		return !pte_same_norecency(ptep_get(vmf->pte), vmf->orig_pte);

 	return !pte_none(ptep_get(vmf->pte));
 }
@@ -5125,7 +5137,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	 * the pfn may be screwed if the read is non atomic.
 	 */
 	spin_lock(vmf->ptl);
-	if (unlikely(!pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
+	if (unlikely(!pte_same_norecency(ptep_get(vmf->pte), vmf->orig_pte))) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 		goto out;
 	}
@@ -5197,7 +5209,8 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 					       vmf->address, &vmf->ptl);
 		if (unlikely(!vmf->pte))
 			goto out;
-		if (unlikely(!pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
+		if (unlikely(!pte_same_norecency(ptep_get(vmf->pte),
+							  vmf->orig_pte))) {
 			pte_unmap_unlock(vmf->pte, vmf->ptl);
 			goto out;
 		}
@@ -5343,7 +5356,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 						 vmf->address, &vmf->ptl);
 		if (unlikely(!vmf->pte))
 			return 0;
-		vmf->orig_pte = ptep_get_lockless(vmf->pte);
+		vmf->orig_pte = ptep_get_lockless_norecency(vmf->pte);
 		vmf->flags |= FAULT_FLAG_ORIG_PTE_VALID;

 		if (pte_none(vmf->orig_pte)) {
@@ -5363,7 +5376,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)

 	spin_lock(vmf->ptl);
 	entry = vmf->orig_pte;
-	if (unlikely(!pte_same(ptep_get(vmf->pte), entry))) {
+	if (unlikely(!pte_same_norecency(ptep_get(vmf->pte), entry))) {
 		update_mmu_tlb(vmf->vma, vmf->address, vmf->pte);
 		goto unlock;
 	}
--
2.25.1


