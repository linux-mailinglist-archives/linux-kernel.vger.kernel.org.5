Return-Path: <linux-kernel+bounces-164619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EDC8B8032
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C97AE1C2251F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA6C190679;
	Tue, 30 Apr 2024 18:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b="GBzs8RFd"
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0962F172BD7;
	Tue, 30 Apr 2024 18:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714503522; cv=none; b=hXZ77p/KDHHBC8Dhab6gx0bkgdJH5XoeaowFn5OeNzIQP0glQTIpydd0GxC3H4L8GSUwfLatouOK/1KPhUWO79ZPhGyltCO7LC2rcmZa1ZVGQlKsu4r23DagV+lA54qodzi8C0AkQwO70GJcqiKLsrsnLmY3Lm5eJZhTZ8I4vOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714503522; c=relaxed/simple;
	bh=SjoD3RHTmmZDzZCM8lZd9retaoQx53its6hidF7gw88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmRkEAp9WIBicjuEJIpN74NjAwWb4IxxHQ7okGNIIuPm/rZeOYsFf8YmlMv+1dbM8uDf1RP+ayFlHYj2FMneZK1KgArDbrqlEuwAdZAj45MrbKo2ZexrAoVX0YJ0c2MbEsR/d+l9xoqRWankf+Fq/sSfZafpi8zrSMDYlHFrW6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org; spf=pass smtp.mailfrom=morinfr.org; dkim=pass (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b=GBzs8RFd; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morinfr.org
Received: from bender.morinfr.org (unknown [82.66.66.112])
	by smtp2-g21.free.fr (Postfix) with ESMTPS id 7FBF020039E;
	Tue, 30 Apr 2024 20:58:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
	; s=20170427; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=HhSudDUSa3R+U3u8VO33W0XCYKfrmMlncMYuFLeBf+A=; b=GBzs8RFdCI2UkY8eb7smXBPhxE
	+dJA4kENbq0FIv9Dygi4+I51i9W8VXH2X6Q46es+W5df9ZveIqiD1SLChOKqoQSCutBgKsgvhHjeT
	kG3oQqqdKIBhqJ07K6HDEZAnbeIixzVKMrvhMlSGufC248AWZJzrHT78Kc2sovaS+u+8=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.96)
	(envelope-from <guillaume@morinfr.org>)
	id 1s1sgR-004hBY-2u;
	Tue, 30 Apr 2024 20:58:31 +0200
Date: Tue, 30 Apr 2024 20:58:31 +0200
From: Guillaume Morin <guillaume@morinfr.org>
To: David Hildenbrand <david@redhat.com>
Cc: Guillaume Morin <guillaume@morinfr.org>, oleg@redhat.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	muchun.song@linux.dev
Subject: Re: [RFC][PATCH] uprobe: support for private hugetlb mappings
Message-ID: <ZjE_V0j8mYpNaW8K@bender.morinfr.org>
References: <8d5314ac-5afe-41d4-9d27-9512cd96d21c@redhat.com>
 <ZilvOi7ceSXmwkNq@bender.morinfr.org>
 <b1cf78f8-8480-4451-bbf8-78694ebd0438@redhat.com>
 <Zip0fEliGeL0qmID@bender.morinfr.org>
 <e84a82b8-b788-499c-be79-e6dcb64ac969@redhat.com>
 <Zirw0uINbP6GxFiK@bender.morinfr.org>
 <385d3516-95bb-4ff9-9d60-ac4e46104130@redhat.com>
 <ZiwGovSHiVCF7z6y@bender.morinfr.org>
 <ZjEMoHkbloHVeJ0h@bender.morinfr.org>
 <35c88b38-96e6-4092-a7e0-fd22f6d784cc@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35c88b38-96e6-4092-a7e0-fd22f6d784cc@redhat.com>

On 30 Apr 20:21, David Hildenbrand wrote:
> Sorry for not replying earlier, was busy with other stuff. I'll try getiing
> that stuff into shape and send it out soonish.

No worries. Let me know what you think of the FOLL_FORCE patch when you
have a sec.

> > I went with using one write uprobe function with some additional
> > branches. I went back and forth between that and making them 2 different
> > functions.
> 
> All the folio_test_hugetlb() special casing is a bit suboptimal. Likely we
> want a separate variant, because we should be sing hugetlb PTE functions
> consistently (e.g., huge_pte_uffd_wp() vs pte_uffd_wp(), softdirty does not
> exist etc.)

Ok, I'll give this a whirl and send something probably tomorrow.

> > diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> > index 2f4e88552d3f..8a33e380f7ea 100644
> > --- a/fs/hugetlbfs/inode.c
> > +++ b/fs/hugetlbfs/inode.c
> > @@ -83,6 +83,10 @@ static const struct fs_parameter_spec hugetlb_fs_parameters[] = {
> >   	{}
> >   };
> > +bool hugetlbfs_mapping(struct address_space *mapping) {
> > +	return mapping->a_ops == &hugetlbfs_aops;
> 
> is_vm_hugetlb_page() might be what you are looking for.

I use hugetlbfs_mapping() in __uprobe_register() which does an early
return using the mapping only if it's not supported. There is no vma
that I can get at this point (afaict).

I could refactor so we check this when we have a vma but it looked
cleaner to introduce it since there is already shmem_mapping()

> >   }
> > -static void copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len)
> > +static void copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len, unsigned long page_mask)
> >   {
> >   	void *kaddr = kmap_atomic(page);
> > -	memcpy(dst, kaddr + (vaddr & ~PAGE_MASK), len);
> > +	memcpy(dst, kaddr + (vaddr & ~page_mask), len);
> >   	kunmap_atomic(kaddr);
> >   }
> 
> > -static void copy_to_page(struct page *page, unsigned long vaddr, const void *src, int len)
> > +static void copy_to_page(struct page *page, unsigned long vaddr, const void *src, int len, unsigned long page_mask)
> >   {
> >   	void *kaddr = kmap_atomic(page);
> > -	memcpy(kaddr + (vaddr & ~PAGE_MASK), src, len);
> > +	memcpy(kaddr + (vaddr & ~page_mask), src, len);
> >   	kunmap_atomic(kaddr);
> >   }
> 
> These two changes really are rather ugly ...
> 
> An why are they even required? We get a PAGE_SIZED-based subpage of a
> hugetlb page. We only kmap that one and copy within that one.
> 
> In other words, I don't think the copy_from_page() and copy_to_page()
> changes are even required when we consistently work on subpages and not
> suddenly on head pages.

The main reason is that the previous __replace_page worked directly on the full
HP page so adjusting after gup seemed to make more sense to me. But
now I guess it's not that useful (esp we're going with a different
version of write_uprobe). I'll fix

(...)
> >   {
> >   	struct uwo_data *data = walk->private;;
> >   	const bool is_register = !!is_swbp_insn(&data->opcode);
> > @@ -415,9 +417,12 @@ static int __write_opcode_pte(pte_t *ptep, unsigned long vaddr,
> >   	/* Unmap + flush the TLB, such that we can write atomically .*/
> >   	flush_cache_page(vma, vaddr, pte_pfn(pte));
> > -	pte = ptep_clear_flush(vma, vaddr, ptep);
> > +	if (folio_test_hugetlb(folio))
> > +		pte = huge_ptep_clear_flush(vma, vaddr, ptep);
> > +	else
> > +		pte = ptep_clear_flush(vma, vaddr, ptep);
> >   	copy_to_page(page, data->opcode_vaddr, &data->opcode,
> > -		     UPROBE_SWBP_INSN_SIZE);
> > +		     UPROBE_SWBP_INSN_SIZE, page_mask);
> >   	/* When unregistering, we may only zap a PTE if uffd is disabled ... */
> >   	if (is_register || userfaultfd_missing(vma))
> > @@ -443,13 +448,18 @@ static int __write_opcode_pte(pte_t *ptep, unsigned long vaddr,
> >   	if (!identical || folio_maybe_dma_pinned(folio))
> >   		goto remap;
> > -	/* Zap it and try to reclaim swap space. */
> > -	dec_mm_counter(mm, MM_ANONPAGES);
> > -	folio_remove_rmap_pte(folio, page, vma);
> > -	if (!folio_mapped(folio) && folio_test_swapcache(folio) &&
> > -	     folio_trylock(folio)) {
> > -		folio_free_swap(folio);
> > -		folio_unlock(folio);
> > +	if (folio_test_hugetlb(folio)) {
> > +		hugetlb_remove_rmap(folio);
> > +		large = false;
> > +	} else {
> > +		/* Zap it and try to reclaim swap space. */
> > +		dec_mm_counter(mm, MM_ANONPAGES);
> > +		folio_remove_rmap_pte(folio, page, vma);
> > +		if (!folio_mapped(folio) && folio_test_swapcache(folio) &&
> > +		folio_trylock(folio)) {
> > +			folio_free_swap(folio);
> > +			folio_unlock(folio);
> > +		}
> >   	}
> >   	folio_put(folio);
> > @@ -461,11 +471,29 @@ static int __write_opcode_pte(pte_t *ptep, unsigned long vaddr,
> >   	 */
> >   	smp_wmb();
> >   	/* We modified the page. Make sure to mark the PTE dirty. */
> > -	set_pte_at(mm, vaddr, ptep, pte_mkdirty(pte));
> > +	if (folio_test_hugetlb(folio))
> > +		set_huge_pte_at(mm , vaddr, ptep, huge_pte_mkdirty(pte),
> > +				(~page_mask) + 1);
> > +	else
> > +		set_pte_at(mm, vaddr, ptep, pte_mkdirty(pte));
> >   	return UWO_DONE;
> >   }
> > +static int __write_opcode_hugetlb(pte_t *ptep, unsigned long hmask,
> > +		unsigned long vaddr,
> > +		unsigned long next, struct mm_walk *walk)
> > +{
> > +	return __write_opcode(ptep, vaddr, hmask, walk);
> > +}
> > +
> > +static int __write_opcode_pte(pte_t *ptep, unsigned long vaddr,
> > +		unsigned long next, struct mm_walk *walk)
> > +{
> > +	return __write_opcode(ptep, vaddr, PAGE_MASK, walk);
> > +}
> > +
> >   static const struct mm_walk_ops write_opcode_ops = {
> > +	.hugetlb_entry		= __write_opcode_hugetlb,
> >   	.pte_entry		= __write_opcode_pte,
> >   	.walk_lock		= PGWALK_WRLOCK,
> >   };
> > @@ -492,7 +520,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> >   		unsigned long opcode_vaddr, uprobe_opcode_t opcode)
> >   {
> >   	struct uprobe *uprobe = container_of(auprobe, struct uprobe, arch);
> > -	const unsigned long vaddr = opcode_vaddr & PAGE_MASK;
> > +	unsigned long vaddr = opcode_vaddr & PAGE_MASK;
> >   	const bool is_register = !!is_swbp_insn(&opcode);
> >   	struct uwo_data data = {
> >   		.opcode = opcode,
> > @@ -503,6 +531,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> >   	struct mmu_notifier_range range;
> >   	int ret, ref_ctr_updated = 0;
> >   	struct page *page;
> > +	unsigned long page_size = PAGE_SIZE;
> >   	if (WARN_ON_ONCE(!is_cow_mapping(vma->vm_flags)))
> >   		return -EINVAL;
> > @@ -521,7 +550,14 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> >   	if (ret != 1)
> >   		goto out;
> > -	ret = verify_opcode(page, opcode_vaddr, &opcode);
> > +
> > +	if (is_vm_hugetlb_page(vma)) {
> > +		struct hstate *h = hstate_vma(vma);
> > +		page_size = huge_page_size(h);
> > +		vaddr &= huge_page_mask(h);
> > +		page = compound_head(page);
> 
> I think we should only adjust the range we pass to the mmu notifier and for
> walking the VMA range. But we should not adjust vaddr.
> 
> Further, we should not adjust the page if possible ... ideally, we'll treat
> hugetlb folios just like large folios here and operate on subpages.
> 
> Inside __write_opcode(), we can derive the the page of interest from
> data->opcode_vaddr.

Here you mean __write_opcode_hugetlb(), right? Since we're going with
the 2 independent variants. Just want to 100% sure I am following

> find_get_page() might need some though, if it won't return a subpage of a
> hugetlb folio. Should be solvable by a wrapper, though.

We can zero out the subbits with the huge page mask in the
vaddr_to_offset() in the hugetlb variant like I do in __copy_insn() and
that should work, no? Or you prefer a wrapper?

Guillaume.

-- 
Guillaume Morin <guillaume@morinfr.org>

