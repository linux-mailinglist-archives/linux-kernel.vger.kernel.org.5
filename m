Return-Path: <linux-kernel+bounces-164719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D811D8B81A1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 22:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520C71F239AB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C401BED86;
	Tue, 30 Apr 2024 20:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VnQqwCcC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E601219DF5F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 20:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714509659; cv=none; b=bdMrFNQpCfwnzHAMACj5ppxiygg55RFnXYpDX4OyODHmW/PDOnV82fLJkUCZeuSaRWYrMOJ9/FGMi80VgB273gCxtwn8CTSZzB6YhjPR9Z55K7ZlLxEOQz4fk2/E/CA1BlfchLclMed1srOcRtSKpw4p2MJw2HbpIgt2dtpRSwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714509659; c=relaxed/simple;
	bh=s2teqHkSCL4uWbpb45KCyW7j7hKCwXNJuAVEbr6+omE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZweoqYKMcMX5dQ47OdQq7aPeYlwq20qtLCr8Ro9wrqLNtv/aOkBKH5IGrku9LXBvG2au267CGbwJREWzHKZtf4AWtb9myToPHP8Vt4d4x/541u3706a/5ZQHZcuHCLXwhKH3H6p6hIrIYwKlCqQmuQumpND3nTYdjAx3Xv8qGrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VnQqwCcC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714509656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vOAuKWIwQi6S2JtNyAUQzZVVkPkPSxcwLLbIo1CKxCo=;
	b=VnQqwCcCsf3GLX4RKXaIICaVIiRd/PobnbGI+Svat5LvRxvFY5V+o1RW5M74D2Qy2kpOZ5
	HpQzz32R9ErP0ez76x7K3dV9HdgIMmoFKEIzdHLe9pJxsgOCs2qdxU3NDXuZMtNXwC/V6c
	aa8ucqj8QnsNjOZMeliaqM/RadDEsVM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-1amwTavyN7Ot0XE5cRcD2A-1; Tue, 30 Apr 2024 16:40:53 -0400
X-MC-Unique: 1amwTavyN7Ot0XE5cRcD2A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE26480E95D;
	Tue, 30 Apr 2024 20:40:52 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.75])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CDAC6C15771;
	Tue, 30 Apr 2024 20:40:47 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v1 1/2] mm/memory: cleanly support zeropage in vm_insert_page*(), vm_map_pages*() and vmf_insert_mixed()
Date: Tue, 30 Apr 2024 22:40:43 +0200
Message-ID: <20240430204044.52755-2-david@redhat.com>
In-Reply-To: <20240430204044.52755-1-david@redhat.com>
References: <20240430204044.52755-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

For now we only get the (small) zeropage mapped to user space in four
cases (excluding VM_PFNMAP mappings, such as /proc/vmstat):

(1) Read page faults in anonymous VMAs (MAP_PRIVATE|MAP_ANON):
    do_anonymous_page() will not refcount it and map it pte_mkspecial()
(2) UFFDIO_ZEROPAGE on anonymous VMA or COW mapping of shmem
    (MAP_PRIVATE). mfill_atomic_pte_zeropage() will not refcount it and
    map it pte_mkspecial().
(3) KSM in mergeable VMA (anonymous VMA or COW mapping).
    cmp_and_merge_page() will not refcount it and map it
    pte_mkspecial().
(4) FSDAX as an optimization for holes.
    vmf_insert_mixed()->__vm_insert_mixed() might end up calling
    insert_page() without CONFIG_ARCH_HAS_PTE_SPECIAL, refcounting the
    zeropage and not mapping it pte_mkspecial(). With
    CONFIG_ARCH_HAS_PTE_SPECIAL, we'll call insert_pfn() where we will
    not refcount it and map it pte_mkspecial().

In case (4), we might not have VM_MIXEDMAP set: while fs/fuse/dax.c sets
VM_MIXEDMAP, we removed it for ext4 fsdax in commit e1fb4a086495 ("dax:
remove VM_MIXEDMAP for fsdax and device dax") and for XFS in commit
e1fb4a086495 ("dax: remove VM_MIXEDMAP for fsdax and device dax").

Without CONFIG_ARCH_HAS_PTE_SPECIAL and with VM_MIXEDMAP, vm_normal_page()
would currently return the zeropage. We'll refcount the zeropage when
mapping and when unmapping.

Without CONFIG_ARCH_HAS_PTE_SPECIAL and without VM_MIXEDMAP,
vm_normal_page() would currently refuse to return the zeropage.
So we'd refcount it when mapping but not when unmapping it ... do we
have fsdax without CONFIG_ARCH_HAS_PTE_SPECIAL in practice? Hard to
tell.

Independent of that, we should never refcount the zeropage when we might
be holding that reference for a long time, because even without an
accounting imbalance we might overflow the refcount. As there is interest
in using the zeropage also in other VM_MIXEDMAP mappings, let's add clean
support for that in the cases where it makes sense:

(A) Never refcount the zeropage when mapping it:

In insert_page(), special-case the zeropage, do not refcount it, and
use pte_mkspecial(). Don't involve insert_pfn(), adjusting insert_page()
looks cleaner than branching off to insert_pfn().

(B) Never refcount the zeropage when unmapping it:

In vm_normal_page(), also don't return the zeropage in a
VM_MIXEDMAP mapping without CONFIG_ARCH_HAS_PTE_SPECIAL. Add a
VM_WARN_ON_ONCE() sanity check if we'd ever return the zeropage,
which could happen if someone forgets to set pte_mkspecial() when
mapping the zeropage. Document that.

(C) Allow the zeropage only where reasonable

s390x never wants the zeropage in some processes running legacy
KVM guests that make use of storage keys. So disallow that.

Further, using the zeropage in COW mappings is unproblematic (just what
we do for other COW mappings), because FAULT_FLAG_UNSHARE can just
unshare it and GUP with FOLL_LONGTERM would work as expected.

Similarly, mappings that can never have writable PTEs (implying no
write faults) are also not problematic, because nothing could end
up mapping the PTE writable by mistake later. But in case we could have
writable PTEs, we'll only allow the zeropage in FSDAX VMAs, that
are incompatible with GUP and are blocked there completely.

We'll always require the zeropage to be mapped with pte_special().
GUP-fast will reject the zeropage that way, but GUP-slow will allow
it. (Note that GUP does not refcount the zeropage with FOLL_PIN,
because there were issues with overflowing the refcount in the past).

Add sanity checks to can_change_pte_writable() and wp_page_reuse(), to
catch early during testing if we'd ever find a zeropage unexpectedly in
code that wants to upgrade write permissions.

Convert the BUG_ON in vm_mixed_ok() to an ordinary check and simply fail
with VM_FAULT_SIGBUS, like we do for other sanity checks. Drop the
stale comment regarding reserved pages from insert_page().

Note that:
* we won't mess with VM_PFNMAP mappings for now. remap_pfn_range() and
  vmf_insert_pfn() would allow the zeropage in some cases and
  not refcount it.
* vmf_insert_pfn*() will reject the zeropage in VM_MIXEDMAP
  mappings and we'll leave that alone for now. People can simply use
  one of the other interfaces.
* we won't bother with the huge zeropage for now. It's never
  PTE-mapped and also GUP does not special-case it yet.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c   | 92 +++++++++++++++++++++++++++++++++++++++------------
 mm/mprotect.c |  2 ++
 2 files changed, 73 insertions(+), 21 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index eea6e4984eaef..5fffc9bd3febd 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -575,10 +575,13 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
  * VM_MIXEDMAP mappings can likewise contain memory with or without "struct
  * page" backing, however the difference is that _all_ pages with a struct
  * page (that is, those where pfn_valid is true) are refcounted and considered
- * normal pages by the VM. The disadvantage is that pages are refcounted
- * (which can be slower and simply not an option for some PFNMAP users). The
- * advantage is that we don't have to follow the strict linearity rule of
- * PFNMAP mappings in order to support COWable mappings.
+ * normal pages by the VM. The only exception are zeropages, which are
+ * *never* refcounted.
+ *
+ * The disadvantage is that pages are refcounted (which can be slower and
+ * simply not an option for some PFNMAP users). The advantage is that we
+ * don't have to follow the strict linearity rule of PFNMAP mappings in
+ * order to support COWable mappings.
  *
  */
 struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
@@ -616,6 +619,8 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 		if (vma->vm_flags & VM_MIXEDMAP) {
 			if (!pfn_valid(pfn))
 				return NULL;
+			if (is_zero_pfn(pfn))
+				return NULL;
 			goto out;
 		} else {
 			unsigned long off;
@@ -641,6 +646,7 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 	 * eg. VDSO mappings can cause them to exist.
 	 */
 out:
+	VM_WARN_ON_ONCE(is_zero_pfn(pfn));
 	return pfn_to_page(pfn);
 }
 
@@ -1983,10 +1989,47 @@ pte_t *__get_locked_pte(struct mm_struct *mm, unsigned long addr,
 	return pte_alloc_map_lock(mm, pmd, addr, ptl);
 }
 
-static int validate_page_before_insert(struct page *page)
+static bool vm_mixed_zeropage_allowed(struct vm_area_struct *vma)
+{
+	VM_WARN_ON_ONCE(vma->vm_flags & VM_PFNMAP);
+	/*
+	 * Whoever wants to forbid the zeropage after some zeropages
+	 * might already have been mapped has to scan the page tables and
+	 * bail out on any zeropages. Zeropages in COW mappings can
+	 * be unshared using FAULT_FLAG_UNSHARE faults.
+	 */
+	if (mm_forbids_zeropage(vma->vm_mm))
+		return false;
+	/* zeropages in COW mappings are common and unproblematic. */
+	if (is_cow_mapping(vma->vm_flags))
+		return true;
+	/* Mappings that do not allow for writable PTEs are unproblematic. */
+	if (!(vma->vm_flags & (VM_WRITE | VM_MAYWRITE)))
+		return false;
+	/*
+	 * Why not allow any VMA that has vm_ops->pfn_mkwrite? GUP could
+	 * find the shared zeropage and longterm-pin it, which would
+	 * be problematic as soon as the zeropage gets replaced by a different
+	 * page due to vma->vm_ops->pfn_mkwrite, because what's mapped would
+	 * now differ to what GUP looked up. FSDAX is incompatible to
+	 * FOLL_LONGTERM and VM_IO is incompatible to GUP completely (see
+	 * check_vma_flags).
+	 */
+	return vma->vm_ops && vma->vm_ops->pfn_mkwrite &&
+	       (vma_is_fsdax(vma) || vma->vm_flags & VM_IO);
+}
+
+static int validate_page_before_insert(struct vm_area_struct *vma,
+				       struct page *page)
 {
 	struct folio *folio = page_folio(page);
 
+	if (unlikely(is_zero_folio(folio))) {
+		if (!vm_mixed_zeropage_allowed(vma))
+			return -EINVAL;
+		return 0;
+	}
+
 	if (folio_test_anon(folio) || folio_test_slab(folio) ||
 	    page_has_type(page))
 		return -EINVAL;
@@ -1998,24 +2041,23 @@ static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
 			unsigned long addr, struct page *page, pgprot_t prot)
 {
 	struct folio *folio = page_folio(page);
+	pte_t pteval;
 
 	if (!pte_none(ptep_get(pte)))
 		return -EBUSY;
 	/* Ok, finally just insert the thing.. */
-	folio_get(folio);
-	inc_mm_counter(vma->vm_mm, mm_counter_file(folio));
-	folio_add_file_rmap_pte(folio, page, vma);
-	set_pte_at(vma->vm_mm, addr, pte, mk_pte(page, prot));
+	pteval = mk_pte(page, prot);
+	if (unlikely(is_zero_folio(folio))) {
+		pteval = pte_mkspecial(pteval);
+	} else {
+		folio_get(folio);
+		inc_mm_counter(vma->vm_mm, mm_counter_file(folio));
+		folio_add_file_rmap_pte(folio, page, vma);
+	}
+	set_pte_at(vma->vm_mm, addr, pte, pteval);
 	return 0;
 }
 
-/*
- * This is the old fallback for page remapping.
- *
- * For historical reasons, it only allows reserved pages. Only
- * old drivers should use this, and they needed to mark their
- * pages reserved for the old functions anyway.
- */
 static int insert_page(struct vm_area_struct *vma, unsigned long addr,
 			struct page *page, pgprot_t prot)
 {
@@ -2023,7 +2065,7 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
 	pte_t *pte;
 	spinlock_t *ptl;
 
-	retval = validate_page_before_insert(page);
+	retval = validate_page_before_insert(vma, page);
 	if (retval)
 		goto out;
 	retval = -ENOMEM;
@@ -2043,7 +2085,7 @@ static int insert_page_in_batch_locked(struct vm_area_struct *vma, pte_t *pte,
 
 	if (!page_count(page))
 		return -EINVAL;
-	err = validate_page_before_insert(page);
+	err = validate_page_before_insert(vma, page);
 	if (err)
 		return err;
 	return insert_page_into_pte_locked(vma, pte, addr, page, prot);
@@ -2149,7 +2191,8 @@ EXPORT_SYMBOL(vm_insert_pages);
  * @page: source kernel page
  *
  * This allows drivers to insert individual pages they've allocated
- * into a user vma.
+ * into a user vma. The zeropage is supported in some VMAs,
+ * see vm_mixed_zeropage_allowed().
  *
  * The page has to be a nice clean _individual_ kernel allocation.
  * If you allocate a compound page, you need to have marked it as
@@ -2195,6 +2238,8 @@ EXPORT_SYMBOL(vm_insert_page);
  * @offset: user's requested vm_pgoff
  *
  * This allows drivers to map range of kernel pages into a user vma.
+ * The zeropage is supported in some VMAs, see
+ * vm_mixed_zeropage_allowed().
  *
  * Return: 0 on success and error code otherwise.
  */
@@ -2410,8 +2455,11 @@ vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 }
 EXPORT_SYMBOL(vmf_insert_pfn);
 
-static bool vm_mixed_ok(struct vm_area_struct *vma, pfn_t pfn)
+static bool vm_mixed_ok(struct vm_area_struct *vma, pfn_t pfn, bool mkwrite)
 {
+	if (unlikely(is_zero_pfn(pfn_t_to_pfn(pfn))) &&
+	    (mkwrite || !vm_mixed_zeropage_allowed(vma)))
+		return false;
 	/* these checks mirror the abort conditions in vm_normal_page */
 	if (vma->vm_flags & VM_MIXEDMAP)
 		return true;
@@ -2430,7 +2478,8 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 	pgprot_t pgprot = vma->vm_page_prot;
 	int err;
 
-	BUG_ON(!vm_mixed_ok(vma, pfn));
+	if (!vm_mixed_ok(vma, pfn, mkwrite))
+		return VM_FAULT_SIGBUS;
 
 	if (addr < vma->vm_start || addr >= vma->vm_end)
 		return VM_FAULT_SIGBUS;
@@ -3178,6 +3227,7 @@ static inline void wp_page_reuse(struct vm_fault *vmf, struct folio *folio)
 	pte_t entry;
 
 	VM_BUG_ON(!(vmf->flags & FAULT_FLAG_WRITE));
+	VM_WARN_ON(is_zero_pfn(pte_pfn(vmf->orig_pte)));
 
 	if (folio) {
 		VM_BUG_ON(folio_test_anon(folio) &&
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 8c6cd88252738..888ef66468dbd 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -71,6 +71,8 @@ bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
 		return page && PageAnon(page) && PageAnonExclusive(page);
 	}
 
+	VM_WARN_ON_ONCE(is_zero_pfn(pte_pfn(pte)) && pte_dirty(pte));
+
 	/*
 	 * Writable MAP_SHARED mapping: "clean" might indicate that the FS still
 	 * needs a real write-fault for writenotify
-- 
2.44.0


