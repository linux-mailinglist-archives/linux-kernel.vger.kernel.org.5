Return-Path: <linux-kernel+bounces-103957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AF587C704
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D65A1C2178F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 01:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B357612E;
	Fri, 15 Mar 2024 01:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XH27IWgt"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597B84C8F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 01:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710465402; cv=none; b=nDXeDa51IBWN41GMX10dIMeCBUqCoMj3dBYb7uHwn6RcK3wz0dRQ4TspzYaQeCwBUVonf5+WQaxPD/vZLcrssHeemj/mzkKQrlh+gXTWi6Q1heKVqCRv+rzVJS9kWzjst2hS1FDQ6yHjcQRjrWHXRHC3c263JwFNtzMbuH98s24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710465402; c=relaxed/simple;
	bh=P5XiFD9ZDCFVCw/x0S9lLQFdkuUYboXOL/7pwn+/Bs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MbKTjpkva6fZlSq3RW35HLjLDngs/HSaRHqteIZLmWBX2F6kLScX77l80nQnOrG4jU0dF3nasn8zsTYbn4MyxuXC4+wIYfmgEu09RKvbuzzX3QUG+V9og5t+pkOD9Tv1+LvSzy0liEDLm9XiV0YwK0F/xMp+/vUsCtnzhpVgDuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XH27IWgt; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso2059434a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 18:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710465399; x=1711070199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIc1Yq9fmCTIP9ZhxrQAZUCknWldct9RGS/QVjXvgZM=;
        b=XH27IWgtGYvX1bWa4w/YmqlgaxNNoQjqcTEKdN6HKymlnh/F1lrXVmux1AcXysmj3g
         VW2lTl21a3eF7fS3HVNlxT7Gm6hygJ6HvamhFGxLD7WG24dmz+13e8TyUpli2rrS1z1l
         3fqKPeSSVz3bB+g6rX6q+kKN+2p7UH+1n+Gk3gWnYsn/gE3jYxwez4AHuEYMTH6UjZM2
         ffup1mMl7uVejT0h1zueRHjDnh/iFEzm91y4LfalJmN/7JIFPzJ3zWxAQq6yKJfVWdXb
         3HqvX5MngIkHWv1LrXg97g9bR6ZRqtG5oZ16JZd2bNFhKQQz05x4gnVNoUX895Ncrwnq
         B1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710465399; x=1711070199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fIc1Yq9fmCTIP9ZhxrQAZUCknWldct9RGS/QVjXvgZM=;
        b=rG9SXBCYXVXlbT++mTEBMdpbnTJpb9HvsVUkHUyTzKp1S7aLvRSCekQv7eWhXFZR1Q
         TDSA3VX5hASe9UA1Cl7aUC4t7kBJBHHtVoXNMgsfW9cvbF04LuskL7VPrjfjPgsgOfAo
         3T5pw13J9+0i8G3PzwmfCKka1vVg7G9EGwYTQKPelHL91GnMTp8gTOhqLHGZT0rrCR96
         l1vjJ98tQvUXDClkxhSqAMFBl3nWptQop4jOdWPJCI6ve+DxlyPKS7GMTdsxIm0OTDkU
         +NfcmKTlFQcF3+vU/tn4JsI1bL//JCIF2aeICcGD/uyfkq9h4sNA8pGjnYgbBEh8fmZf
         j+PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt8Da0mVa+K61ovlSuHu/1o2WUKePPu/J4IpAZuEVgP3OAJCtLS8cqhZeXa1nQreaUQ+ruJqO5muXONHKvjROi9I5O7NHwtmgyr3hL
X-Gm-Message-State: AOJu0YyCsN8yxumS7omjvbM8Q9bisCvcFaIo3ry7nKU2Br/ICU6Bec+6
	ZppovhDGUuZbNSYz4UwXgowi7xhFKuX+8odpHYuwA64D6K260ariXMd730hprglrWAX9oPjR/dM
	S07H+E2Fjn07CLWzbwYNC2/8p2RU=
X-Google-Smtp-Source: AGHT+IHXNUoPy01DYVR00y8eISBVc3CKWA6X8r7dK+P6hFiyV5u2E6n6qulq1DOa+2uB/wSbL2cJ0fQCQsZLczQxrNE=
X-Received: by 2002:a05:6402:458a:b0:565:9ac6:a9e5 with SMTP id
 ig10-20020a056402458a00b005659ac6a9e5mr2400352edb.21.1710465398507; Thu, 14
 Mar 2024 18:16:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304081348.197341-1-21cnbao@gmail.com> <20240304081348.197341-6-21cnbao@gmail.com>
 <c9702789-5772-4750-a609-e44a5bbd8468@arm.com> <CANzGp4+p3xSo9uX2i7K2bSZ3VKEQQChAVzdmBD3O2qXq_cE2yA@mail.gmail.com>
 <85b59657-9660-41a2-b091-0c6ec4a6ef16@arm.com>
In-Reply-To: <85b59657-9660-41a2-b091-0c6ec4a6ef16@arm.com>
From: Chuanhua Han <chuanhuahan@gmail.com>
Date: Fri, 15 Mar 2024 09:16:26 +0800
Message-ID: <CANzGp4+g2_UJcnUab_c0o109nx9rZmXLrtwuZnxzXwsoU6nk6w@mail.gmail.com>
Subject: Re: [RFC PATCH v3 5/5] mm: support large folios swapin as a whole
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	chengming.zhou@linux.dev, chrisl@kernel.org, david@redhat.com, 
	hannes@cmpxchg.org, kasong@tencent.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, mhocko@suse.com, nphamcs@gmail.com, 
	shy828301@gmail.com, steven.price@arm.com, surenb@google.com, 
	wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org, 
	ying.huang@intel.com, yosryahmed@google.com, yuzhao@google.com, 
	Chuanhua Han <hanchuanhua@oppo.com>, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ryan Roberts <ryan.roberts@arm.com> =E4=BA=8E2024=E5=B9=B43=E6=9C=8814=E6=
=97=A5=E5=91=A8=E5=9B=9B 21:57=E5=86=99=E9=81=93=EF=BC=9A
>
> On 14/03/2024 12:56, Chuanhua Han wrote:
> > Ryan Roberts <ryan.roberts@arm.com> =E4=BA=8E2024=E5=B9=B43=E6=9C=8813=
=E6=97=A5=E5=91=A8=E4=B8=89 00:33=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 04/03/2024 08:13, Barry Song wrote:
> >>> From: Chuanhua Han <hanchuanhua@oppo.com>
> >>>
> >>> On an embedded system like Android, more than half of anon memory is
> >>> actually in swap devices such as zRAM. For example, while an app is
> >>> switched to background, its most memory might be swapped-out.
> >>>
> >>> Now we have mTHP features, unfortunately, if we don't support large f=
olios
> >>> swap-in, once those large folios are swapped-out, we immediately lose=
 the
> >>> performance gain we can get through large folios and hardware optimiz=
ation
> >>> such as CONT-PTE.
> >>>
> >>> This patch brings up mTHP swap-in support. Right now, we limit mTHP s=
wap-in
> >>> to those contiguous swaps which were likely swapped out from mTHP as =
a
> >>> whole.
> >>>
> >>> Meanwhile, the current implementation only covers the SWAP_SYCHRONOUS
> >>> case. It doesn't support swapin_readahead as large folios yet since t=
his
> >>> kind of shared memory is much less than memory mapped by single proce=
ss.
> >>>
> >>> Right now, we are re-faulting large folios which are still in swapcac=
he as a
> >>> whole, this can effectively decrease extra loops and early-exitings w=
hich we
> >>> have increased in arch_swap_restore() while supporting MTE restore fo=
r folios
> >>> rather than page. On the other hand, it can also decrease do_swap_pag=
e as
> >>> PTEs used to be set one by one even we hit a large folio in swapcache=
.
> >>>
> >>> Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> >>> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> >>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >>> ---
> >>>  mm/memory.c | 250 ++++++++++++++++++++++++++++++++++++++++++++------=
--
> >>>  1 file changed, 212 insertions(+), 38 deletions(-)
> >>>
> >>> diff --git a/mm/memory.c b/mm/memory.c
> >>> index e0d34d705e07..501ede745ef3 100644
> >>> --- a/mm/memory.c
> >>> +++ b/mm/memory.c
> >>> @@ -3907,6 +3907,136 @@ static vm_fault_t handle_pte_marker(struct vm=
_fault *vmf)
> >>>       return VM_FAULT_SIGBUS;
> >>>  }
> >>>
> >>> +/*
> >>> + * check a range of PTEs are completely swap entries with
> >>> + * contiguous swap offsets and the same SWAP_HAS_CACHE.
> >>> + * pte must be first one in the range
> >>> + */
> >>> +static bool is_pte_range_contig_swap(pte_t *pte, int nr_pages)
> >>> +{
> >>> +     int i;
> >>> +     struct swap_info_struct *si;
> >>> +     swp_entry_t entry;
> >>> +     unsigned type;
> >>> +     pgoff_t start_offset;
> >>> +     char has_cache;
> >>> +
> >>> +     entry =3D pte_to_swp_entry(ptep_get_lockless(pte));
> >>
> >> Given you are getting entry locklessly, I expect it could change under=
 you? So
> >> probably need to check that its a swap entry, etc. first?
> > The following non_swap_entry checks to see if it is a swap entry.
>
> No, it checks if something already known to be a "swap entry" type is act=
ually
> describing a swap entry, or a non-swap entry (e.g. migration entry, hwpoi=
son
> entry, etc.) Swap entries with type >=3D MAX_SWAPFILES don't actually des=
cribe swap:
>
> static inline int non_swap_entry(swp_entry_t entry)
> {
>         return swp_type(entry) >=3D MAX_SWAPFILES;
> }
>
>
> So you need to do something like:
>
> pte =3D ptep_get_lockless(pte);
> if (pte_none(pte) || !pte_present(pte))
>         return false;
> entry =3D pte_to_swp_entry(pte);
> if (non_swap_entry(entry))
>         return false;
> ...
>
Indeed, this will more accurate, thank you very much for your advise!
> >>
> >>> +     if (non_swap_entry(entry))
> >>> +             return false;
> >>> +     start_offset =3D swp_offset(entry);
> >>> +     if (start_offset % nr_pages)
> >>> +             return false;
> >>> +
> >>> +     si =3D swp_swap_info(entry);
> >>
> >> What ensures si remains valid (i.e. swapoff can't happen)? If swapoff =
can race,
> >> then swap_map may have been freed when you read it below. Holding the =
PTL can
> >> sometimes prevent it, but I don't think you're holding that here (you'=
re using
> >> ptep_get_lockless(). Perhaps get_swap_device()/put_swap_device() can h=
elp?
> > Thank you for your review,you are righit! this place reaally needs
> > get_swap_device()/put_swap_device().
> >>
> >>> +     type =3D swp_type(entry);
> >>> +     has_cache =3D si->swap_map[start_offset] & SWAP_HAS_CACHE;
> >>> +     for (i =3D 1; i < nr_pages; i++) {
> >>> +             entry =3D pte_to_swp_entry(ptep_get_lockless(pte + i));
> >>> +             if (non_swap_entry(entry))
> >>> +                     return false;
> >>> +             if (swp_offset(entry) !=3D start_offset + i)
> >>> +                     return false;
> >>> +             if (swp_type(entry) !=3D type)
> >>> +                     return false;
> >>> +             /*
> >>> +              * while allocating a large folio and doing swap_read_f=
olio for the
> >>> +              * SWP_SYNCHRONOUS_IO path, which is the case the being=
 faulted pte
> >>> +              * doesn't have swapcache. We need to ensure all PTEs h=
ave no cache
> >>> +              * as well, otherwise, we might go to swap devices whil=
e the content
> >>> +              * is in swapcache
> >>> +              */
> >>> +             if ((si->swap_map[start_offset + i] & SWAP_HAS_CACHE) !=
=3D has_cache)
> >>> +                     return false;
> >>> +     }
> >>> +
> >>> +     return true;
> >>> +}
> >>
> >> I created swap_pte_batch() for the swap-out series [1]. I wonder if th=
at could
> >> be extended for the SWAP_HAS_CACHE checks? Possibly not because it ass=
umes the
> >> PTL is held, and you are lockless here. Thought it might be of interes=
t though.
> >>
> >> [1] https://lore.kernel.org/linux-mm/20240311150058.1122862-3-ryan.rob=
erts@arm.com/
> >>
> > Thanks. It's probably simily to ours, but as you said we are lockless
> > here, and we need to check has_cache.
> >>> +
> >>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >>> +/*
> >>> + * Get a list of all the (large) orders below PMD_ORDER that are ena=
bled
> >>> + * for this vma. Then filter out the orders that can't be allocated =
over
> >>> + * the faulting address and still be fully contained in the vma.
> >>> + */
> >>> +static inline unsigned long get_alloc_folio_orders(struct vm_fault *=
vmf)
> >>> +{
> >>> +     struct vm_area_struct *vma =3D vmf->vma;
> >>> +     unsigned long orders;
> >>> +
> >>> +     orders =3D thp_vma_allowable_orders(vma, vma->vm_flags, false, =
true, true,
> >>> +                                       BIT(PMD_ORDER) - 1);
> >>> +     orders =3D thp_vma_suitable_orders(vma, vmf->address, orders);
> >>> +     return orders;
> >>> +}
> >>> +#endif
> >>> +
> >>> +static struct folio *alloc_swap_folio(struct vm_fault *vmf)
> >>> +{
> >>> +     struct vm_area_struct *vma =3D vmf->vma;
> >>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >>> +     unsigned long orders;
> >>> +     struct folio *folio;
> >>> +     unsigned long addr;
> >>> +     pte_t *pte;
> >>> +     gfp_t gfp;
> >>> +     int order;
> >>> +
> >>> +     /*
> >>> +      * If uffd is active for the vma we need per-page fault fidelit=
y to
> >>> +      * maintain the uffd semantics.
> >>> +      */
> >>> +     if (unlikely(userfaultfd_armed(vma)))
> >>> +             goto fallback;
> >>> +
> >>> +     /*
> >>> +      * a large folio being swapped-in could be partially in
> >>> +      * zswap and partially in swap devices, zswap doesn't
> >>> +      * support large folios yet, we might get corrupted
> >>> +      * zero-filled data by reading all subpages from swap
> >>> +      * devices while some of them are actually in zswap
> >>> +      */
> >>> +     if (is_zswap_enabled())
> >>> +             goto fallback;
> >>> +
> >>> +     orders =3D get_alloc_folio_orders(vmf);
> >>> +     if (!orders)
> >>> +             goto fallback;
> >>> +
> >>> +     pte =3D pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
> >>
> >> Could also briefly take PTL here, then is_pte_range_contig_swap() coul=
d be
> >> merged with an enhanced swap_pte_batch()?
> > Yes, it's easy to use a lock here, but I'm wondering if it's
> > necessary, because when we actually set pte in do_swap_page, we'll
> > hold PTL to check if the pte changes.
> >>
> >>> +     if (unlikely(!pte))
> >>> +             goto fallback;
> >>> +
> >>> +     /*
> >>> +      * For do_swap_page, find the highest order where the aligned r=
ange is
> >>> +      * completely swap entries with contiguous swap offsets.
> >>> +      */
> >>> +     order =3D highest_order(orders);
> >>> +     while (orders) {
> >>> +             addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> >>> +             if (is_pte_range_contig_swap(pte + pte_index(addr), 1 <=
< order))
> >>> +                     break;
> >>> +             order =3D next_order(&orders, order);
> >>> +     }
> >>
> >> So in the common case, swap-in will pull in the same size of folio as =
was
> >> swapped-out. Is that definitely the right policy for all folio sizes? =
Certainly
> >> it makes sense for "small" large folios (e.g. up to 64K IMHO). But I'm=
 not sure
> >> it makes sense for 2M THP; As the size increases the chances of actual=
ly needing
> >> all of the folio reduces so chances are we are wasting IO. There are s=
imilar
> >> arguments for CoW, where we currently copy 1 page per fault - it proba=
bly makes
> >> sense to copy the whole folio up to a certain size.
> > For 2M THP, IO overhead may not necessarily be large? :)
> > 1.If 2M THP are continuously stored in the swap device, the IO
> > overhead may not be very large (such as submitting bio with one
> > bio_vec at a time).
> > 2.If the process really needs this 2M data, one page-fault may perform
> > much better than multiple.
> > 3.For swap devices like zram,using 2M THP might also improve
> > decompression efficiency.
> >
> > On the other hand, if the process only needs a small part of the 2M
> > data (such as only frequent use of 4K page, the rest of the data is
> > never accessed), This is indeed give a lark to catch a kite!  :(
>
> Yes indeed. It's not always clear-cut what the best thing to do is. It wo=
uld be
> good to hear from others on this.
>
> >>
> >> Thanks,
> >> Ryan
> >>
> >>> +
> >>> +     pte_unmap(pte);
> >>> +
> >>> +     /* Try allocating the highest of the remaining orders. */
> >>> +     gfp =3D vma_thp_gfp_mask(vma);
> >>> +     while (orders) {
> >>> +             addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> >>> +             folio =3D vma_alloc_folio(gfp, order, vma, addr, true);
> >>> +             if (folio)
> >>> +                     return folio;
> >>> +             order =3D next_order(&orders, order);
> >>> +     }
> >>> +
> >>> +fallback:
> >>> +#endif
> >>> +     return vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vmf->addre=
ss, false);
> >>> +}
> >>> +
> >>> +
> >>>  /*
> >>>   * We enter with non-exclusive mmap_lock (to exclude vma changes,
> >>>   * but allow concurrent faults), and pte mapped but not yet locked.
> >>> @@ -3928,6 +4058,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>>       pte_t pte;
> >>>       vm_fault_t ret =3D 0;
> >>>       void *shadow =3D NULL;
> >>> +     int nr_pages =3D 1;
> >>> +     unsigned long start_address;
> >>> +     pte_t *start_pte;
> >>>
> >>>       if (!pte_unmap_same(vmf))
> >>>               goto out;
> >>> @@ -3991,35 +4124,41 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>>       if (!folio) {
> >>>               if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> >>>                   __swap_count(entry) =3D=3D 1) {
> >>> -                     /*
> >>> -                      * Prevent parallel swapin from proceeding with
> >>> -                      * the cache flag. Otherwise, another thread ma=
y
> >>> -                      * finish swapin first, free the entry, and swa=
pout
> >>> -                      * reusing the same entry. It's undetectable as
> >>> -                      * pte_same() returns true due to entry reuse.
> >>> -                      */
> >>> -                     if (swapcache_prepare(entry)) {
> >>> -                             /* Relax a bit to prevent rapid repeate=
d page faults */
> >>> -                             schedule_timeout_uninterruptible(1);
> >>> -                             goto out;
> >>> -                     }
> >>> -                     need_clear_cache =3D true;
> >>> -
> >>>                       /* skip swapcache */
> >>> -                     folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE,=
 0,
> >>> -                                             vma, vmf->address, fals=
e);
> >>> +                     folio =3D alloc_swap_folio(vmf);
> >>>                       page =3D &folio->page;
> >>>                       if (folio) {
> >>>                               __folio_set_locked(folio);
> >>>                               __folio_set_swapbacked(folio);
> >>>
> >>> +                             if (folio_test_large(folio)) {
> >>> +                                     nr_pages =3D folio_nr_pages(fol=
io);
> >>> +                                     entry.val =3D ALIGN_DOWN(entry.=
val, nr_pages);
> >>> +                             }
> >>> +
> >>> +                             /*
> >>> +                              * Prevent parallel swapin from proceed=
ing with
> >>> +                              * the cache flag. Otherwise, another t=
hread may
> >>> +                              * finish swapin first, free the entry,=
 and swapout
> >>> +                              * reusing the same entry. It's undetec=
table as
> >>> +                              * pte_same() returns true due to entry=
 reuse.
> >>> +                              */
> >>> +                             if (swapcache_prepare_nr(entry, nr_page=
s)) {
> >>> +                                     /* Relax a bit to prevent rapid=
 repeated page faults */
> >>> +                                     schedule_timeout_uninterruptibl=
e(1);
> >>> +                                     goto out;
> >>> +                             }
> >>> +                             need_clear_cache =3D true;
> >>> +
> >>>                               if (mem_cgroup_swapin_charge_folio(foli=
o,
> >>>                                                       vma->vm_mm, GFP=
_KERNEL,
> >>>                                                       entry)) {
> >>>                                       ret =3D VM_FAULT_OOM;
> >>>                                       goto out_page;
> >>>                               }
> >>> -                             mem_cgroup_swapin_uncharge_swap(entry);
> >>> +
> >>> +                             for (swp_entry_t e =3D entry; e.val < e=
ntry.val + nr_pages; e.val++)
> >>> +                                     mem_cgroup_swapin_uncharge_swap=
(e);
> >>>
> >>>                               shadow =3D get_shadow_from_swap_cache(e=
ntry);
> >>>                               if (shadow)
> >>> @@ -4118,6 +4257,42 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>>        */
> >>>       vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->add=
ress,
> >>>                       &vmf->ptl);
> >>> +
> >>> +     start_address =3D vmf->address;
> >>> +     start_pte =3D vmf->pte;
> >>> +     if (start_pte && folio_test_large(folio)) {
> >>> +             unsigned long nr =3D folio_nr_pages(folio);
> >>> +             unsigned long addr =3D ALIGN_DOWN(vmf->address, nr * PA=
GE_SIZE);
> >>> +             pte_t *aligned_pte =3D vmf->pte - (vmf->address - addr)=
 / PAGE_SIZE;
> >>> +
> >>> +             /*
> >>> +              * case 1: we are allocating large_folio, try to map it=
 as a whole
> >>> +              * iff the swap entries are still entirely mapped;
> >>> +              * case 2: we hit a large folio in swapcache, and all s=
wap entries
> >>> +              * are still entirely mapped, try to map a large folio =
as a whole.
> >>> +              * otherwise, map only the faulting page within the lar=
ge folio
> >>> +              * which is swapcache
> >>> +              */
> >>> +             if (!is_pte_range_contig_swap(aligned_pte, nr)) {
> >>> +                     if (nr_pages > 1) /* ptes have changed for case=
 1 */
> >>> +                             goto out_nomap;
> >>> +                     goto check_pte;
> >>> +             }
> >>> +
> >>> +             start_address =3D addr;
> >>> +             start_pte =3D aligned_pte;
> >>> +             /*
> >>> +              * the below has been done before swap_read_folio()
> >>> +              * for case 1
> >>> +              */
> >>> +             if (unlikely(folio =3D=3D swapcache)) {
> >>> +                     nr_pages =3D nr;
> >>> +                     entry.val =3D ALIGN_DOWN(entry.val, nr_pages);
> >>> +                     page =3D &folio->page;
> >>> +             }
> >>> +     }
> >>> +
> >>> +check_pte:
> >>>       if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->or=
ig_pte)))
> >>>               goto out_nomap;
> >>>
> >>> @@ -4185,12 +4360,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>>        * We're already holding a reference on the page but haven't ma=
pped it
> >>>        * yet.
> >>>        */
> >>> -     swap_free(entry);
> >>> +     swap_nr_free(entry, nr_pages);
> >>>       if (should_try_to_free_swap(folio, vma, vmf->flags))
> >>>               folio_free_swap(folio);
> >>>
> >>> -     inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
> >>> -     dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
> >>> +     folio_ref_add(folio, nr_pages - 1);
> >>> +     add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
> >>> +     add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
> >>> +
> >>>       pte =3D mk_pte(page, vma->vm_page_prot);
> >>>
> >>>       /*
> >>> @@ -4200,14 +4377,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>>        * exclusivity.
> >>>        */
> >>>       if (!folio_test_ksm(folio) &&
> >>> -         (exclusive || folio_ref_count(folio) =3D=3D 1)) {
> >>> +         (exclusive || folio_ref_count(folio) =3D=3D nr_pages)) {
> >>>               if (vmf->flags & FAULT_FLAG_WRITE) {
> >>>                       pte =3D maybe_mkwrite(pte_mkdirty(pte), vma);
> >>>                       vmf->flags &=3D ~FAULT_FLAG_WRITE;
> >>>               }
> >>>               rmap_flags |=3D RMAP_EXCLUSIVE;
> >>>       }
> >>> -     flush_icache_page(vma, page);
> >>> +     flush_icache_pages(vma, page, nr_pages);
> >>>       if (pte_swp_soft_dirty(vmf->orig_pte))
> >>>               pte =3D pte_mksoft_dirty(pte);
> >>>       if (pte_swp_uffd_wp(vmf->orig_pte))
> >>> @@ -4216,17 +4393,19 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>>
> >>>       /* ksm created a completely new copy */
> >>>       if (unlikely(folio !=3D swapcache && swapcache)) {
> >>> -             folio_add_new_anon_rmap(folio, vma, vmf->address);
> >>> +             folio_add_new_anon_rmap(folio, vma, start_address);
> >>>               folio_add_lru_vma(folio, vma);
> >>> +     } else if (!folio_test_anon(folio)) {
> >>> +             folio_add_new_anon_rmap(folio, vma, start_address);
> >>>       } else {
> >>> -             folio_add_anon_rmap_pte(folio, page, vma, vmf->address,
> >>> +             folio_add_anon_rmap_ptes(folio, page, nr_pages, vma, st=
art_address,
> >>>                                       rmap_flags);
> >>>       }
> >>>
> >>>       VM_BUG_ON(!folio_test_anon(folio) ||
> >>>                       (pte_write(pte) && !PageAnonExclusive(page)));
> >>> -     set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
> >>> -     arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig=
_pte);
> >>> +     set_ptes(vma->vm_mm, start_address, start_pte, pte, nr_pages);
> >>> +     arch_do_swap_page(vma->vm_mm, vma, start_address, pte, vmf->ori=
g_pte);
> >>>
> >>>       folio_unlock(folio);
> >>>       if (folio !=3D swapcache && swapcache) {
> >>> @@ -4243,6 +4422,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>>       }
> >>>
> >>>       if (vmf->flags & FAULT_FLAG_WRITE) {
> >>> +             if (nr_pages > 1)
> >>> +                     vmf->orig_pte =3D ptep_get(vmf->pte);
> >>> +
> >>>               ret |=3D do_wp_page(vmf);
> >>>               if (ret & VM_FAULT_ERROR)
> >>>                       ret &=3D VM_FAULT_ERROR;
> >>> @@ -4250,14 +4432,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>>       }
> >>>
> >>>       /* No need to invalidate - it was non-present before */
> >>> -     update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
> >>> +     update_mmu_cache_range(vmf, vma, start_address, start_pte, nr_p=
ages);
> >>>  unlock:
> >>>       if (vmf->pte)
> >>>               pte_unmap_unlock(vmf->pte, vmf->ptl);
> >>>  out:
> >>>       /* Clear the swap cache pin for direct swapin after PTL unlock =
*/
> >>>       if (need_clear_cache)
> >>> -             swapcache_clear(si, entry);
> >>> +             swapcache_clear_nr(si, entry, nr_pages);
> >>>       if (si)
> >>>               put_swap_device(si);
> >>>       return ret;
> >>> @@ -4273,7 +4455,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>>               folio_put(swapcache);
> >>>       }
> >>>       if (need_clear_cache)
> >>> -             swapcache_clear(si, entry);
> >>> +             swapcache_clear_nr(si, entry, nr_pages);
> >>>       if (si)
> >>>               put_swap_device(si);
> >>>       return ret;
> >>> @@ -4309,15 +4491,7 @@ static struct folio *alloc_anon_folio(struct v=
m_fault *vmf)
> >>>       if (unlikely(userfaultfd_armed(vma)))
> >>>               goto fallback;
> >>>
> >>> -     /*
> >>> -      * Get a list of all the (large) orders below PMD_ORDER that ar=
e enabled
> >>> -      * for this vma. Then filter out the orders that can't be alloc=
ated over
> >>> -      * the faulting address and still be fully contained in the vma=
.
> >>> -      */
> >>> -     orders =3D thp_vma_allowable_orders(vma, vma->vm_flags, false, =
true, true,
> >>> -                                       BIT(PMD_ORDER) - 1);
> >>> -     orders =3D thp_vma_suitable_orders(vma, vmf->address, orders);
> >>> -
> >>> +     orders =3D get_alloc_folio_orders(vmf);
> >>>       if (!orders)
> >>>               goto fallback;
> >>>
> >>
> >>
> >
> >
>


--=20
Thanks,
Chuanhua

