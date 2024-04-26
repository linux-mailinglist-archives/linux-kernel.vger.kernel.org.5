Return-Path: <linux-kernel+bounces-160644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E378B4088
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A90721C22A83
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFA120B0E;
	Fri, 26 Apr 2024 19:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b="sEyCf1dc"
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000FF2134B;
	Fri, 26 Apr 2024 19:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714161326; cv=none; b=kCgoaXyTvdRgLWtT1eVKkdRBX5tioAhf2ztoWbduUI91UUoy8cJKl4iorY4/0estXk90fEDWYQo5RO9+eqrVgp+x7F/UD88pS6hUbeY6xr4QQ/mI0v6FBpDyx8kv4zDwlnzTz4CMrEfFKFeRWF94Ko180ikPaJyBlz/NNB/SSZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714161326; c=relaxed/simple;
	bh=k6UQFx+FTVMFJB3uoLV1FRJmRY1OSXJK9xUJp82a9rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dv/IQTUBAdYCboQAc7tR40xHP8JrZx/w0FfCELMBsEM4Z4LziXJJo0T/+LbQplxKZPSJF96BLiyFv0KXeoiBlfJPCwcPOHlSFDDN455efajLkPETmjWqGyEztKgHyjsM69IKEGphoQkRfa/NjzjO6b+e/tt9E2eSYPqayD/snsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org; spf=pass smtp.mailfrom=morinfr.org; dkim=pass (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b=sEyCf1dc; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morinfr.org
Received: from bender.morinfr.org (unknown [82.66.66.112])
	by smtp2-g21.free.fr (Postfix) with ESMTPS id 5317F200385;
	Fri, 26 Apr 2024 21:55:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
	; s=20170427; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Hual/gYi1Gb3z8aH4NPYPYWI7tKJTt9jd8NxI2iy/xg=; b=sEyCf1dcY3yEKaMrBL3MVi6CCd
	EjG86WhQepwMM2qiqmiNRqU/Pg/8bsYZ8nOX48t61+nPKOoiJDa2k0deUyfssC4crS1eeIebBGi8S
	YofGl+soNqiLaAGU5l3Rr6nTaZMST6sFZUgzVi/hnYgfl8UipDFpMY0wqy5UtYxvE6D0=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.96)
	(envelope-from <guillaume@morinfr.org>)
	id 1s0Rf8-00294d-1f;
	Fri, 26 Apr 2024 21:55:14 +0200
Date: Fri, 26 Apr 2024 21:55:14 +0200
From: Guillaume Morin <guillaume@morinfr.org>
To: David Hildenbrand <david@redhat.com>
Cc: Guillaume Morin <guillaume@morinfr.org>, oleg@redhat.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	muchun.song@linux.dev
Subject: Re: [RFC][PATCH] uprobe: support for private hugetlb mappings
Message-ID: <ZiwGovSHiVCF7z6y@bender.morinfr.org>
References: <ZiaoZlGc_8ZV3736@bender.morinfr.org>
 <22fcde31-16c4-42d0-ad99-568173ec4dd0@redhat.com>
 <ZibOQI9kwzE98n12@bender.morinfr.org>
 <8d5314ac-5afe-41d4-9d27-9512cd96d21c@redhat.com>
 <ZilvOi7ceSXmwkNq@bender.morinfr.org>
 <b1cf78f8-8480-4451-bbf8-78694ebd0438@redhat.com>
 <Zip0fEliGeL0qmID@bender.morinfr.org>
 <e84a82b8-b788-499c-be79-e6dcb64ac969@redhat.com>
 <Zirw0uINbP6GxFiK@bender.morinfr.org>
 <385d3516-95bb-4ff9-9d60-ac4e46104130@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <385d3516-95bb-4ff9-9d60-ac4e46104130@redhat.com>

On 26 Apr  9:19, David Hildenbrand wrote:
> A couple of points:
> 
> a) Don't use page_mapcount(). Either folio_mapcount(), but likely you want
> to check PageAnonExclusive.
> 
> b) If you're not following the can_follow_write_pte/_pmd model, you are
> doing something wrong :)
> 
> c) The code was heavily changed in mm/mm-unstable. It was merged with t
> the common code.
> 
> Likely, in mm/mm-unstable, the existing can_follow_write_pte and
> can_follow_write_pmd checks will already cover what you want in most cases.
> 
> We'd need a can_follow_write_pud() to cover follow_huge_pud() and
> (unfortunately) something to handle follow_hugepd() as well similarly.
> 
> Copy-pasting what we do in can_follow_write_pte() and adjusting for
> different PTE types is the right thing to do. Maybe now it's time to factor
> out the common checks into a separate helper.

I tried to get the hugepd stuff right but this was the first I heard
about it :-) Afaict follow_huge_pmd and friends were already DTRT

diff --git a/mm/gup.c b/mm/gup.c
index 2f7baf96f65..9df97ea555f 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -517,6 +517,34 @@ static int record_subpages(struct page *page, unsigned long sz,
 }
 #endif	/* CONFIG_ARCH_HAS_HUGEPD || CONFIG_HAVE_GUP_FAST */
 
+/* Common code for can_follow_write_* */
+static inline bool can_follow_write_common(struct page *page,
+					   struct vm_area_struct *vma,
+					   unsigned int flags)
+{
+	/* Maybe FOLL_FORCE is set to override it? */
+	if (!(flags & FOLL_FORCE))
+		return false;
+
+	/* But FOLL_FORCE has no effect on shared mappings */
+	if (vma->vm_flags & (VM_MAYSHARE | VM_SHARED))
+		return false;
+
+	/* ... or read-only private ones */
+	if (!(vma->vm_flags & VM_MAYWRITE))
+		return false;
+
+	/* ... or already writable ones that just need to take a write fault */
+	if (vma->vm_flags & VM_WRITE)
+		return false;
+
+	/*
+	 * See can_change_pte_writable(): we broke COW and could map the page
+	 * writable if we have an exclusive anonymous page ...
+	 */
+	return page && PageAnon(page) && PageAnonExclusive(page);
+}
+
 #ifdef CONFIG_ARCH_HAS_HUGEPD
 static unsigned long hugepte_addr_end(unsigned long addr, unsigned long end,
 				      unsigned long sz)
@@ -525,6 +553,17 @@ static unsigned long hugepte_addr_end(unsigned long addr, unsigned long end,
 	return (__boundary - 1 < end - 1) ? __boundary : end;
 }
 
+static inline bool can_follow_write_hugepd(pte_t pte, struct page* page,
+					   struct vm_area_struct *vma,
+					   unsigned int flags)
+{
+	/* If the pte is writable, we can write to the page. */
+	if (pte_access_permitted(pte, flags & FOLL_WRITE))
+		return true;
+
+	return can_follow_write_common(page, vma, flags);
+}
+
 static int gup_fast_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 		unsigned long end, unsigned int flags, struct page **pages,
 		int *nr)
@@ -541,13 +580,13 @@ static int gup_fast_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 
 	pte = huge_ptep_get(ptep);
 
-	if (!pte_access_permitted(pte, flags & FOLL_WRITE))
-		return 0;
-
 	/* hugepages are never "special" */
 	VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
 
 	page = pte_page(pte);
+	if (!can_follow_write_hugepd(pte, page, vma, flags))
+		return 0;
+
 	refs = record_subpages(page, sz, addr, end, pages + *nr);
 
 	folio = try_grab_folio(page, refs, flags);
@@ -668,7 +707,25 @@ static struct page *no_page_table(struct vm_area_struct *vma,
 	return NULL;
 }
 
+
+
 #ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
+/* FOLL_FORCE can write to even unwritable PUDs in COW mappings. */
+static inline bool can_follow_write_pud(pud_t pud, struct page *page,
+					struct vm_area_struct *vma,
+					unsigned int flags)
+{
+	/* If the pud is writable, we can write to the page. */
+	if (pud_write(pud))
+		return true;
+
+	if (!can_follow_write_common(page, vma, flags))
+		return false;
+
+	/* ... and a write-fault isn't required for other reasons. */
+	return !vma_soft_dirty_enabled(vma) || pud_soft_dirty(pud);
+}
+
 static struct page *follow_huge_pud(struct vm_area_struct *vma,
 				    unsigned long addr, pud_t *pudp,
 				    int flags, struct follow_page_context *ctx)
@@ -681,7 +738,8 @@ static struct page *follow_huge_pud(struct vm_area_struct *vma,
 
 	assert_spin_locked(pud_lockptr(mm, pudp));
 
-	if ((flags & FOLL_WRITE) && !pud_write(pud))
+	if ((flags & FOLL_WRITE) &&
+	    !can_follow_write_pud(pud, page, vma, flags))
 		return NULL;
 
 	if (!pud_present(pud))
@@ -733,27 +791,7 @@ static inline bool can_follow_write_pmd(pmd_t pmd, struct page *page,
 	if (pmd_write(pmd))
 		return true;
 
-	/* Maybe FOLL_FORCE is set to override it? */
-	if (!(flags & FOLL_FORCE))
-		return false;
-
-	/* But FOLL_FORCE has no effect on shared mappings */
-	if (vma->vm_flags & (VM_MAYSHARE | VM_SHARED))
-		return false;
-
-	/* ... or read-only private ones */
-	if (!(vma->vm_flags & VM_MAYWRITE))
-		return false;
-
-	/* ... or already writable ones that just need to take a write fault */
-	if (vma->vm_flags & VM_WRITE)
-		return false;
-
-	/*
-	 * See can_change_pte_writable(): we broke COW and could map the page
-	 * writable if we have an exclusive anonymous page ...
-	 */
-	if (!page || !PageAnon(page) || !PageAnonExclusive(page))
+	if (!can_follow_write_common(page, vma, flags))
 		return false;
 
 	/* ... and a write-fault isn't required for other reasons. */
@@ -854,27 +892,7 @@ static inline bool can_follow_write_pte(pte_t pte, struct page *page,
 	if (pte_write(pte))
 		return true;
 
-	/* Maybe FOLL_FORCE is set to override it? */
-	if (!(flags & FOLL_FORCE))
-		return false;
-
-	/* But FOLL_FORCE has no effect on shared mappings */
-	if (vma->vm_flags & (VM_MAYSHARE | VM_SHARED))
-		return false;
-
-	/* ... or read-only private ones */
-	if (!(vma->vm_flags & VM_MAYWRITE))
-		return false;
-
-	/* ... or already writable ones that just need to take a write fault */
-	if (vma->vm_flags & VM_WRITE)
-		return false;
-
-	/*
-	 * See can_change_pte_writable(): we broke COW and could map the page
-	 * writable if we have an exclusive anonymous page ...
-	 */
-	if (!page || !PageAnon(page) || !PageAnonExclusive(page))
+	if (!can_follow_write_common(page, vma, flags))
 		return false;
 
 	/* ... and a write-fault isn't required for other reasons. */
@@ -1374,9 +1392,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 		if (!(vm_flags & VM_WRITE) || (vm_flags & VM_SHADOW_STACK)) {
 			if (!(gup_flags & FOLL_FORCE))
 				return -EFAULT;
-			/* hugetlb does not support FOLL_FORCE|FOLL_WRITE. */
-			if (is_vm_hugetlb_page(vma))
-				return -EFAULT;
+
 			/*
 			 * We used to let the write,force case do COW in a
 			 * VM_MAYWRITE VM_SHARED !VM_WRITE vma, so ptrace could
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 417fc5cdb6e..099a71ee028 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5320,6 +5320,13 @@ static void set_huge_ptep_writable(struct vm_area_struct *vma,
 		update_mmu_cache(vma, address, ptep);
 }
 
+static void set_huge_ptep_maybe_writable(struct vm_area_struct *vma,
+					 unsigned long address, pte_t *ptep)
+{
+	if (vma->vm_flags & VM_WRITE)
+		set_huge_ptep_writable(vma, address, ptep);
+}
+
 bool is_hugetlb_entry_migration(pte_t pte)
 {
 	swp_entry_t swp;
@@ -5942,13 +5949,6 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
 	if (!unshare && huge_pte_uffd_wp(pte))
 		return 0;
 
-	/*
-	 * hugetlb does not support FOLL_FORCE-style write faults that keep the
-	 * PTE mapped R/O such as maybe_mkwrite() would do.
-	 */
-	if (WARN_ON_ONCE(!unshare && !(vma->vm_flags & VM_WRITE)))
-		return VM_FAULT_SIGSEGV;
-
 	/* Let's take out MAP_SHARED mappings first. */
 	if (vma->vm_flags & VM_MAYSHARE) {
 		set_huge_ptep_writable(vma, vmf->address, vmf->pte);
@@ -5970,7 +5970,7 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
 			SetPageAnonExclusive(&old_folio->page);
 		}
 		if (likely(!unshare))
-			set_huge_ptep_writable(vma, vmf->address, vmf->pte);
+			set_huge_ptep_maybe_writable(vma, vmf->address, vmf->pte);
 
 		delayacct_wpcopy_end();
 		return 0;
@@ -6076,7 +6076,8 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
 	spin_lock(vmf->ptl);
 	vmf->pte = hugetlb_walk(vma, vmf->address, huge_page_size(h));
 	if (likely(vmf->pte && pte_same(huge_ptep_get(vmf->pte), pte))) {
-		pte_t newpte = make_huge_pte(vma, &new_folio->page, !unshare);
+		const bool writable = !unshare && (vma->vm_flags & VM_WRITE);
+		pte_t newpte = make_huge_pte(vma, &new_folio->page, writable);
 
 		/* Break COW or unshare */
 		huge_ptep_clear_flush(vma, vmf->address, vmf->pte);


-- 
Guillaume Morin <guillaume@morinfr.org>

