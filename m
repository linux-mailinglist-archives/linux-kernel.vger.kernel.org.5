Return-Path: <linux-kernel+bounces-159374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DFC8B2DD9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B8921F22481
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62C764C;
	Fri, 26 Apr 2024 00:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b="cZLMJjDA"
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F68E364;
	Fri, 26 Apr 2024 00:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714090210; cv=none; b=jFI3Lsne4aa9SnSsa8Ovenpi/HDx3ItQbsFi3yfcMSB1BgrSy9V4ly59oaEPAGRiaAcOhBhE3p+ogYFfyQ5smZ0J+u1lZRWUuScg/D00JEmD82f9qv7BHhNeCr+2xYZoSlnIbA9VAfpt/GWTwGxllDYmO2qeQLw2FF8Q5fR/GMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714090210; c=relaxed/simple;
	bh=dJtI9o4EFtZNVHQ+nTl9snF0td1+s6F3a0x4Z6jvHWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ue6z+dAE1s/D3OvNS8R3bYu1JIdsJ5tHKeDoIPloSxYl7VRj/C8+M5Pgw5+SabvyiIU4Kg1GI1QAXiZz2R4YuuWNZsSidF7a7doUFKhPZaVmcURKlgNX+VQv9KiKOCMAw2W9ycymU2SMUrviDGuP5p5NjsWSIyLsKVSHNjMWUw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org; spf=pass smtp.mailfrom=morinfr.org; dkim=pass (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b=cZLMJjDA; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morinfr.org
Received: from bender.morinfr.org (unknown [82.66.66.112])
	by smtp2-g21.free.fr (Postfix) with ESMTPS id E31342003B4;
	Fri, 26 Apr 2024 02:09:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
	; s=20170427; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=N6MeTijVraZtnAlr4I7UfZ/peAb7am+s8EPeA93kPNI=; b=cZLMJjDArvL10ffE2YMrqTH3Wy
	JrJA05nUJdSlJgehfNcCMR04i8YZzmsE+saToPPGB+XTxyELSXtExWD5i35JQA9edMTERbl8lXFCq
	/bG00Ct6upF8odr2ViSIfz+zQ6pYcS/LpCGetlMOaF5ixcCpWIg1PskR38z/929ZDcTE=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.96)
	(envelope-from <guillaume@morinfr.org>)
	id 1s09A2-001c5t-10;
	Fri, 26 Apr 2024 02:09:54 +0200
Date: Fri, 26 Apr 2024 02:09:54 +0200
From: Guillaume Morin <guillaume@morinfr.org>
To: David Hildenbrand <david@redhat.com>
Cc: Guillaume Morin <guillaume@morinfr.org>, oleg@redhat.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	muchun.song@linux.dev
Subject: Re: [RFC][PATCH] uprobe: support for private hugetlb mappings
Message-ID: <Zirw0uINbP6GxFiK@bender.morinfr.org>
References: <ZiK50qob9yl5e0Xz@bender.morinfr.org>
 <b70a3d3a-ea8b-4b20-964b-b019c146945a@redhat.com>
 <ZiaoZlGc_8ZV3736@bender.morinfr.org>
 <22fcde31-16c4-42d0-ad99-568173ec4dd0@redhat.com>
 <ZibOQI9kwzE98n12@bender.morinfr.org>
 <8d5314ac-5afe-41d4-9d27-9512cd96d21c@redhat.com>
 <ZilvOi7ceSXmwkNq@bender.morinfr.org>
 <b1cf78f8-8480-4451-bbf8-78694ebd0438@redhat.com>
 <Zip0fEliGeL0qmID@bender.morinfr.org>
 <e84a82b8-b788-499c-be79-e6dcb64ac969@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e84a82b8-b788-499c-be79-e6dcb64ac969@redhat.com>

On 25 Apr 21:56, David Hildenbrand wrote:
>
> On 25.04.24 17:19, Guillaume Morin wrote:
> > On 24 Apr 23:00, David Hildenbrand wrote:
> > > > One issue here is that FOLL_FORCE|FOLL_WRITE is not implemented for
> > > > hugetlb mappings. However this was also on my TODO and I have a draft
> > > > patch that implements it.
> > > 
> > > Yes, I documented it back then and added sanity checks in GUP code to fence
> > > it off. Shouldn't be too hard to implement (famous last words) and would be
> > > the cleaner thing to use here once I manage to switch over to
> > > FOLL_WRITE|FOLL_FORCE to break COW.
> > 
> > Yes, my patch seems to be working. The hugetlb code is pretty simple.
> > And it allows ptrace and the proc pid mem file to work on the executable
> > private hugetlb mappings.
> > 
> > There is one thing I am unclear about though. hugetlb enforces that
> > huge_pte_write() is true on FOLL_WRITE in both the fault and
> > follow_page_mask paths. I am not sure if we can simply assume in the
> > hugetlb code that if the pte is not writable and this is a write fault
> > then we're in the FOLL_FORCE|FOLL_WRITE case.  Or do we want to keep the
> > checks simply not enforce it for FOLL_FORCE|FOLL_WRITE?
> > 
> > The latter is more complicated in the fault path because there is no
> > FAULT_FLAG_FORCE flag.
> > 
> 
> I just pushed something to
> 	https://github.com/davidhildenbrand/linux/tree/uprobes_cow
> 
> Only very lightly tested so far. Expect the worst :)


I'll try it out and send you the hugetlb bits

> 
> I still detest having the zapping logic there, but to get it all right I
> don't see a clean way around that.
> 
> 
> For hugetlb, we'd primarily have to implement the
> mm_walk_ops->hugetlb_entry() callback (well, and FOLL_FORCE).

For FOLL_FORCE, heer is my draft. Let me know if this is what you had in
mind. 


diff --git a/mm/gup.c b/mm/gup.c
index 1611e73b1121..ac60e0ae64e8 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1056,9 +1056,6 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 		if (!(vm_flags & VM_WRITE) || (vm_flags & VM_SHADOW_STACK)) {
 			if (!(gup_flags & FOLL_FORCE))
 				return -EFAULT;
-			/* hugetlb does not support FOLL_FORCE|FOLL_WRITE. */
-			if (is_vm_hugetlb_page(vma))
-				return -EFAULT;
 			/*
 			 * We used to let the write,force case do COW in a
 			 * VM_MAYWRITE VM_SHARED !VM_WRITE vma, so ptrace could
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3548eae42cf9..73f86eddf888 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5941,7 +5941,8 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 		       struct folio *pagecache_folio, spinlock_t *ptl,
 		       struct vm_fault *vmf)
 {
-	const bool unshare = flags & FAULT_FLAG_UNSHARE;
+	const bool make_writable = !(flags & FAULT_FLAG_UNSHARE) &&
+		(vma->vm_flags & VM_WRITE);
 	pte_t pte = huge_ptep_get(ptep);
 	struct hstate *h = hstate_vma(vma);
 	struct folio *old_folio;
@@ -5959,16 +5960,9 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * can trigger this, because hugetlb_fault() will always resolve
 	 * uffd-wp bit first.
 	 */
-	if (!unshare && huge_pte_uffd_wp(pte))
+	if (make_writable && huge_pte_uffd_wp(pte))
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
 		set_huge_ptep_writable(vma, haddr, ptep);
@@ -5989,7 +5983,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 			folio_move_anon_rmap(old_folio, vma);
 			SetPageAnonExclusive(&old_folio->page);
 		}
-		if (likely(!unshare))
+		if (likely(make_writable))
 			set_huge_ptep_writable(vma, haddr, ptep);
 
 		delayacct_wpcopy_end();
@@ -6094,7 +6088,8 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	spin_lock(ptl);
 	ptep = hugetlb_walk(vma, haddr, huge_page_size(h));
 	if (likely(ptep && pte_same(huge_ptep_get(ptep), pte))) {
-		pte_t newpte = make_huge_pte(vma, &new_folio->page, !unshare);
+		pte_t newpte = make_huge_pte(vma, &new_folio->page,
+					     make_writable);
 
 		/* Break COW or unshare */
 		huge_ptep_clear_flush(vma, haddr, ptep);
@@ -6883,6 +6878,17 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 }
 #endif /* CONFIG_USERFAULTFD */
 
+static bool is_force_follow(struct vm_area_struct* vma, unsigned int flags,
+			     struct page* page) {
+	if (vma->vm_flags & VM_WRITE)
+		return false;
+
+	if (!(flags & FOLL_FORCE))
+		return false;
+
+	return page && PageAnon(page) && page_mapcount(page) == 1;
+}
+
 struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 				      unsigned long address, unsigned int flags,
 				      unsigned int *page_mask)
@@ -6907,11 +6913,11 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 
 		if (!huge_pte_write(entry)) {
 			if (flags & FOLL_WRITE) {
-				page = NULL;
-				goto out;
-			}
-
-			if (gup_must_unshare(vma, flags, page)) {
+				if (!is_force_follow(vma, flags, page)) {
+					page = NULL;
+					goto out;
+				}
+			} else if (gup_must_unshare(vma, flags, page)) {
 				/* Tell the caller to do unsharing */
 				page = ERR_PTR(-EMLINK);
 				goto out;

> 
> Likely vaddr and PAGE_SIZE in uprobe_write_opcode() would have to be
> expanded to cover the full hugetlb page.
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

-- 
Guillaume Morin <guillaume@morinfr.org>

