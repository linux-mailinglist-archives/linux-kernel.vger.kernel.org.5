Return-Path: <linux-kernel+bounces-90180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD75386FB6F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2819EB22191
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0559B1798C;
	Mon,  4 Mar 2024 08:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oka7TYIe"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E3A17731
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540102; cv=none; b=tvMlfWdEgqa5F+eUiHewZFBHpFRV6Lbc5LJZajLQZkVQI95/70IlOM7uoiSWl4SFkWe9U6tTbKMC9mXPX4JwvT7gRA9WqNUcwZBo7hhLRpBKZM4ANUxCazNO/HyZrTVme3YmYbs6y4Zpl7G0AkkOk2arokb2U7EFt4jdy+OF1gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540102; c=relaxed/simple;
	bh=qJPCusJ04ma2IPDts7aPIAhRV53b4FPmjk2hD0OS2RQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CuHNjREKLh0txdgDvnW2Snif7qQ+HLV/wlZW7JGexjgAEE+77ikxE5ov17/6uO2tkAJGotVsem95weC0Bn6NFelNRrbK1ZVqrGl2lFXXmoSw8Q64NIbGLSLlm0OaK8mrSviHMrrDYJL0trtWQ8CTJM1Up+EBWKJJfIWNkheGRBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oka7TYIe; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c1adc90830so2570183b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 00:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709540100; x=1710144900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAJqxwL1m9o2obT3SwA5MTdLBPpoaZY5B/QAJ6xv5j8=;
        b=Oka7TYIeZTjtj0Jjn8q/UYoM9aL+z2hJJNIU73PtM0LNRISK4dw2e+4xQugwJVRjFg
         hOs5QUBhB2v7XQxSJAD6vP5ArzS8D8BmK5eP5XbVNyW0YB6M86Ob/VJs8w2NlKS2QxIc
         5Pg4LtUXMWGIbTvRK1PP056QxB2cMNzq2PMmZcBwms9FHpVyMVqMfe5/xm89/wonTUsC
         MVv2xIZEl9YSoOluU+kbml1f/OklpN5GTrr35Amlhbe0gKOpgO+frG2RgnbJ8I/2vMod
         /8fLY53WS4saOvRL65DmE4QrN08qSvgDVUEd1T4dVH/zIZDpQ3hKObOsKsVjGeVNlaZn
         tZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709540100; x=1710144900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAJqxwL1m9o2obT3SwA5MTdLBPpoaZY5B/QAJ6xv5j8=;
        b=t81bCGQakg/oBPj4SNxB/paZKuXT5qJAye8dPXenSU1qQlvOe/C7XRA+o3c+xb8DU6
         2I+X5bP5O7D3FcOrZVQtw5TrZR/kkys9EXAyLf8PrnxtSiqCPCBGSDGpB5drCIwEykRX
         5THWJwkj8NXPfoUKZAeB41cRxJg2YHMChaxuc08EP+2BDZ/n5g0oD/9VtbxdstJpZsPY
         G69NOmFvJ1Cm9l9qkc4Uda8+hXsmjASyZ6ka5/AGv44VOlLk6f0WZ9yYN04vf0nKOBpc
         mNYX1hNtiJuD6MwQGMHKl8gvMNk1OeQ9fSpIHcU9SihnSIDVEs0NSfV5X70M/dWdmvep
         Cdyg==
X-Forwarded-Encrypted: i=1; AJvYcCUKjkR5k5RtHAJAyI9TvPsuhcteNgFuNnqwk7m72EOgKNp7AdygVr+YQPplPpj4EdXSdnKPc28jlHD07WG2RxIFdlk7QqgYsjFD2PKj
X-Gm-Message-State: AOJu0YySPxHca66lXica159pyaxkg8RliS1dwAixQl1hG2zfNGfBblo3
	JCbIRvUYAUZMvwhGyA3x3+n0Zpn2JmQFuHdcTVlsGB3cQ/mu5fEI
X-Google-Smtp-Source: AGHT+IH6AIE3OmLeVTX7JovqJlGUGKUv2cWCft66hk/1+/3mqzDatNzNe/9A2nspzbNZTbVsGn1pPA==
X-Received: by 2002:a05:6870:e91:b0:21e:d80d:3f13 with SMTP id mm17-20020a0568700e9100b0021ed80d3f13mr11743190oab.58.1709540099802;
        Mon, 04 Mar 2024 00:14:59 -0800 (PST)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id ka42-20020a056a0093aa00b006e558a67374sm6686387pfb.0.2024.03.04.00.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 00:14:59 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	ryan.roberts@arm.com
Cc: chengming.zhou@linux.dev,
	chrisl@kernel.org,
	david@redhat.com,
	hannes@cmpxchg.org,
	kasong@tencent.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	nphamcs@gmail.com,
	shy828301@gmail.com,
	steven.price@arm.com,
	surenb@google.com,
	wangkefeng.wang@huawei.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	Chuanhua Han <hanchuanhua@oppo.com>,
	Barry Song <v-songbaohua@oppo.com>
Subject: [RFC PATCH v3 5/5] mm: support large folios swapin as a whole
Date: Mon,  4 Mar 2024 21:13:48 +1300
Message-Id: <20240304081348.197341-6-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304081348.197341-1-21cnbao@gmail.com>
References: <20240304081348.197341-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuanhua Han <hanchuanhua@oppo.com>

On an embedded system like Android, more than half of anon memory is
actually in swap devices such as zRAM. For example, while an app is
switched to background, its most memory might be swapped-out.

Now we have mTHP features, unfortunately, if we don't support large folios
swap-in, once those large folios are swapped-out, we immediately lose the
performance gain we can get through large folios and hardware optimization
such as CONT-PTE.

This patch brings up mTHP swap-in support. Right now, we limit mTHP swap-in
to those contiguous swaps which were likely swapped out from mTHP as a
whole.

Meanwhile, the current implementation only covers the SWAP_SYCHRONOUS
case. It doesn't support swapin_readahead as large folios yet since this
kind of shared memory is much less than memory mapped by single process.

Right now, we are re-faulting large folios which are still in swapcache as a
whole, this can effectively decrease extra loops and early-exitings which we
have increased in arch_swap_restore() while supporting MTE restore for folios
rather than page. On the other hand, it can also decrease do_swap_page as
PTEs used to be set one by one even we hit a large folio in swapcache.

Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
Co-developed-by: Barry Song <v-songbaohua@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/memory.c | 250 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 212 insertions(+), 38 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index e0d34d705e07..501ede745ef3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3907,6 +3907,136 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
 	return VM_FAULT_SIGBUS;
 }
 
+/*
+ * check a range of PTEs are completely swap entries with
+ * contiguous swap offsets and the same SWAP_HAS_CACHE.
+ * pte must be first one in the range
+ */
+static bool is_pte_range_contig_swap(pte_t *pte, int nr_pages)
+{
+	int i;
+	struct swap_info_struct *si;
+	swp_entry_t entry;
+	unsigned type;
+	pgoff_t start_offset;
+	char has_cache;
+
+	entry = pte_to_swp_entry(ptep_get_lockless(pte));
+	if (non_swap_entry(entry))
+		return false;
+	start_offset = swp_offset(entry);
+	if (start_offset % nr_pages)
+		return false;
+
+	si = swp_swap_info(entry);
+	type = swp_type(entry);
+	has_cache = si->swap_map[start_offset] & SWAP_HAS_CACHE;
+	for (i = 1; i < nr_pages; i++) {
+		entry = pte_to_swp_entry(ptep_get_lockless(pte + i));
+		if (non_swap_entry(entry))
+			return false;
+		if (swp_offset(entry) != start_offset + i)
+			return false;
+		if (swp_type(entry) != type)
+			return false;
+		/*
+		 * while allocating a large folio and doing swap_read_folio for the
+		 * SWP_SYNCHRONOUS_IO path, which is the case the being faulted pte
+		 * doesn't have swapcache. We need to ensure all PTEs have no cache
+		 * as well, otherwise, we might go to swap devices while the content
+		 * is in swapcache
+		 */
+		if ((si->swap_map[start_offset + i] & SWAP_HAS_CACHE) != has_cache)
+			return false;
+	}
+
+	return true;
+}
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+/*
+ * Get a list of all the (large) orders below PMD_ORDER that are enabled
+ * for this vma. Then filter out the orders that can't be allocated over
+ * the faulting address and still be fully contained in the vma.
+ */
+static inline unsigned long get_alloc_folio_orders(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	unsigned long orders;
+
+	orders = thp_vma_allowable_orders(vma, vma->vm_flags, false, true, true,
+					  BIT(PMD_ORDER) - 1);
+	orders = thp_vma_suitable_orders(vma, vmf->address, orders);
+	return orders;
+}
+#endif
+
+static struct folio *alloc_swap_folio(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	unsigned long orders;
+	struct folio *folio;
+	unsigned long addr;
+	pte_t *pte;
+	gfp_t gfp;
+	int order;
+
+	/*
+	 * If uffd is active for the vma we need per-page fault fidelity to
+	 * maintain the uffd semantics.
+	 */
+	if (unlikely(userfaultfd_armed(vma)))
+		goto fallback;
+
+	/*
+	 * a large folio being swapped-in could be partially in
+	 * zswap and partially in swap devices, zswap doesn't
+	 * support large folios yet, we might get corrupted
+	 * zero-filled data by reading all subpages from swap
+	 * devices while some of them are actually in zswap
+	 */
+	if (is_zswap_enabled())
+		goto fallback;
+
+	orders = get_alloc_folio_orders(vmf);
+	if (!orders)
+		goto fallback;
+
+	pte = pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
+	if (unlikely(!pte))
+		goto fallback;
+
+	/*
+	 * For do_swap_page, find the highest order where the aligned range is
+	 * completely swap entries with contiguous swap offsets.
+	 */
+	order = highest_order(orders);
+	while (orders) {
+		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
+		if (is_pte_range_contig_swap(pte + pte_index(addr), 1 << order))
+			break;
+		order = next_order(&orders, order);
+	}
+
+	pte_unmap(pte);
+
+	/* Try allocating the highest of the remaining orders. */
+	gfp = vma_thp_gfp_mask(vma);
+	while (orders) {
+		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
+		folio = vma_alloc_folio(gfp, order, vma, addr, true);
+		if (folio)
+			return folio;
+		order = next_order(&orders, order);
+	}
+
+fallback:
+#endif
+	return vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vmf->address, false);
+}
+
+
 /*
  * We enter with non-exclusive mmap_lock (to exclude vma changes,
  * but allow concurrent faults), and pte mapped but not yet locked.
@@ -3928,6 +4058,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	pte_t pte;
 	vm_fault_t ret = 0;
 	void *shadow = NULL;
+	int nr_pages = 1;
+	unsigned long start_address;
+	pte_t *start_pte;
 
 	if (!pte_unmap_same(vmf))
 		goto out;
@@ -3991,35 +4124,41 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (!folio) {
 		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
 		    __swap_count(entry) == 1) {
-			/*
-			 * Prevent parallel swapin from proceeding with
-			 * the cache flag. Otherwise, another thread may
-			 * finish swapin first, free the entry, and swapout
-			 * reusing the same entry. It's undetectable as
-			 * pte_same() returns true due to entry reuse.
-			 */
-			if (swapcache_prepare(entry)) {
-				/* Relax a bit to prevent rapid repeated page faults */
-				schedule_timeout_uninterruptible(1);
-				goto out;
-			}
-			need_clear_cache = true;
-
 			/* skip swapcache */
-			folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
-						vma, vmf->address, false);
+			folio = alloc_swap_folio(vmf);
 			page = &folio->page;
 			if (folio) {
 				__folio_set_locked(folio);
 				__folio_set_swapbacked(folio);
 
+				if (folio_test_large(folio)) {
+					nr_pages = folio_nr_pages(folio);
+					entry.val = ALIGN_DOWN(entry.val, nr_pages);
+				}
+
+				/*
+				 * Prevent parallel swapin from proceeding with
+				 * the cache flag. Otherwise, another thread may
+				 * finish swapin first, free the entry, and swapout
+				 * reusing the same entry. It's undetectable as
+				 * pte_same() returns true due to entry reuse.
+				 */
+				if (swapcache_prepare_nr(entry, nr_pages)) {
+					/* Relax a bit to prevent rapid repeated page faults */
+					schedule_timeout_uninterruptible(1);
+					goto out;
+				}
+				need_clear_cache = true;
+
 				if (mem_cgroup_swapin_charge_folio(folio,
 							vma->vm_mm, GFP_KERNEL,
 							entry)) {
 					ret = VM_FAULT_OOM;
 					goto out_page;
 				}
-				mem_cgroup_swapin_uncharge_swap(entry);
+
+				for (swp_entry_t e = entry; e.val < entry.val + nr_pages; e.val++)
+					mem_cgroup_swapin_uncharge_swap(e);
 
 				shadow = get_shadow_from_swap_cache(entry);
 				if (shadow)
@@ -4118,6 +4257,42 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	 */
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
 			&vmf->ptl);
+
+	start_address = vmf->address;
+	start_pte = vmf->pte;
+	if (start_pte && folio_test_large(folio)) {
+		unsigned long nr = folio_nr_pages(folio);
+		unsigned long addr = ALIGN_DOWN(vmf->address, nr * PAGE_SIZE);
+		pte_t *aligned_pte = vmf->pte - (vmf->address - addr) / PAGE_SIZE;
+
+		/*
+		 * case 1: we are allocating large_folio, try to map it as a whole
+		 * iff the swap entries are still entirely mapped;
+		 * case 2: we hit a large folio in swapcache, and all swap entries
+		 * are still entirely mapped, try to map a large folio as a whole.
+		 * otherwise, map only the faulting page within the large folio
+		 * which is swapcache
+		 */
+		if (!is_pte_range_contig_swap(aligned_pte, nr)) {
+			if (nr_pages > 1) /* ptes have changed for case 1 */
+				goto out_nomap;
+			goto check_pte;
+		}
+
+		start_address = addr;
+		start_pte = aligned_pte;
+		/*
+		 * the below has been done before swap_read_folio()
+		 * for case 1
+		 */
+		if (unlikely(folio == swapcache)) {
+			nr_pages = nr;
+			entry.val = ALIGN_DOWN(entry.val, nr_pages);
+			page = &folio->page;
+		}
+	}
+
+check_pte:
 	if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->orig_pte)))
 		goto out_nomap;
 
@@ -4185,12 +4360,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	 * We're already holding a reference on the page but haven't mapped it
 	 * yet.
 	 */
-	swap_free(entry);
+	swap_nr_free(entry, nr_pages);
 	if (should_try_to_free_swap(folio, vma, vmf->flags))
 		folio_free_swap(folio);
 
-	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
-	dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
+	folio_ref_add(folio, nr_pages - 1);
+	add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
+	add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
+
 	pte = mk_pte(page, vma->vm_page_prot);
 
 	/*
@@ -4200,14 +4377,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	 * exclusivity.
 	 */
 	if (!folio_test_ksm(folio) &&
-	    (exclusive || folio_ref_count(folio) == 1)) {
+	    (exclusive || folio_ref_count(folio) == nr_pages)) {
 		if (vmf->flags & FAULT_FLAG_WRITE) {
 			pte = maybe_mkwrite(pte_mkdirty(pte), vma);
 			vmf->flags &= ~FAULT_FLAG_WRITE;
 		}
 		rmap_flags |= RMAP_EXCLUSIVE;
 	}
-	flush_icache_page(vma, page);
+	flush_icache_pages(vma, page, nr_pages);
 	if (pte_swp_soft_dirty(vmf->orig_pte))
 		pte = pte_mksoft_dirty(pte);
 	if (pte_swp_uffd_wp(vmf->orig_pte))
@@ -4216,17 +4393,19 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 	/* ksm created a completely new copy */
 	if (unlikely(folio != swapcache && swapcache)) {
-		folio_add_new_anon_rmap(folio, vma, vmf->address);
+		folio_add_new_anon_rmap(folio, vma, start_address);
 		folio_add_lru_vma(folio, vma);
+	} else if (!folio_test_anon(folio)) {
+		folio_add_new_anon_rmap(folio, vma, start_address);
 	} else {
-		folio_add_anon_rmap_pte(folio, page, vma, vmf->address,
+		folio_add_anon_rmap_ptes(folio, page, nr_pages, vma, start_address,
 					rmap_flags);
 	}
 
 	VM_BUG_ON(!folio_test_anon(folio) ||
 			(pte_write(pte) && !PageAnonExclusive(page)));
-	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
-	arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
+	set_ptes(vma->vm_mm, start_address, start_pte, pte, nr_pages);
+	arch_do_swap_page(vma->vm_mm, vma, start_address, pte, vmf->orig_pte);
 
 	folio_unlock(folio);
 	if (folio != swapcache && swapcache) {
@@ -4243,6 +4422,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	}
 
 	if (vmf->flags & FAULT_FLAG_WRITE) {
+		if (nr_pages > 1)
+			vmf->orig_pte = ptep_get(vmf->pte);
+
 		ret |= do_wp_page(vmf);
 		if (ret & VM_FAULT_ERROR)
 			ret &= VM_FAULT_ERROR;
@@ -4250,14 +4432,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	}
 
 	/* No need to invalidate - it was non-present before */
-	update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
+	update_mmu_cache_range(vmf, vma, start_address, start_pte, nr_pages);
 unlock:
 	if (vmf->pte)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 out:
 	/* Clear the swap cache pin for direct swapin after PTL unlock */
 	if (need_clear_cache)
-		swapcache_clear(si, entry);
+		swapcache_clear_nr(si, entry, nr_pages);
 	if (si)
 		put_swap_device(si);
 	return ret;
@@ -4273,7 +4455,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		folio_put(swapcache);
 	}
 	if (need_clear_cache)
-		swapcache_clear(si, entry);
+		swapcache_clear_nr(si, entry, nr_pages);
 	if (si)
 		put_swap_device(si);
 	return ret;
@@ -4309,15 +4491,7 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 	if (unlikely(userfaultfd_armed(vma)))
 		goto fallback;
 
-	/*
-	 * Get a list of all the (large) orders below PMD_ORDER that are enabled
-	 * for this vma. Then filter out the orders that can't be allocated over
-	 * the faulting address and still be fully contained in the vma.
-	 */
-	orders = thp_vma_allowable_orders(vma, vma->vm_flags, false, true, true,
-					  BIT(PMD_ORDER) - 1);
-	orders = thp_vma_suitable_orders(vma, vmf->address, orders);
-
+	orders = get_alloc_folio_orders(vmf);
 	if (!orders)
 		goto fallback;
 
-- 
2.34.1


