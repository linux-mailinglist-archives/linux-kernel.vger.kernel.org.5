Return-Path: <linux-kernel+bounces-136583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D2489D5BE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29C0B1C22C75
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1E680022;
	Tue,  9 Apr 2024 09:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQfXw2X1"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597727E774
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 09:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712655713; cv=none; b=iSNB3SpPJYF2SdoVL5pjA/nU1ieJe6eFbwNPtE3icZYzo7CqWw9PVAJzkKm53E30JVp8hMu1ROcof+Jt4Y7XQo9nKvl7ZKZoG0Amp1IM6qVLM63m38VvN07knMiqoTCNfYHQebvQ2LXX7nWZOnFkz+hdbHTyIg9qmMJ3zBVhty0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712655713; c=relaxed/simple;
	bh=mxANU4kms7x/peRX2j5eS6ATJdO+a9w830QFvWHy83I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B3bqsrCDOWhzeJr7i/6bk8nZ5oNpSVkQ0JZ3pDGMEYuP4bESoeUjPvz78PJbWErj5S9bI7LCvUOxg+BSZYxqq63mtQviNpv/BvwLPr4JCjGrx/dkNAkxGxidVGapwuW9XswPaAg75NBGMWtR5NefuKAaxaSenqWw+RmdTLzQO9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQfXw2X1; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7db44846727so1445957241.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 02:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712655710; x=1713260510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e75nlwa4RFxqNbzR1xYnRqzE3pogwi/N6HklJl3ZIUs=;
        b=QQfXw2X1od9isfoY+wAZFRImCj9NzbmFwGzd2BSv/VSgs88vM+cFArYXY7qva++IOo
         bpLxGOSWmqPfgYv0ZMmbptOhMgGKzm3gj6PNBf9cpn1wxeGUfGC87VGN+XgSyF1hRV0T
         bTzawrhswM4FesQxgLv7h3fOFvp+sDhpgzvHXJNamDC2vKkOBYwIs7ebLlZSopPzoJkS
         H7Ipt3xlDaM13sB1Nw0ncgXF12WxA0dqSaSwG71UmFJ4gqz9GDZBfKCGxVw/obhXPNiA
         yjrZoBUksGUxRYF7K54tCZkoqXSumWJZVshfomgGXhRq2ebiDDtBzxxgz4Cdch6y865E
         QPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712655710; x=1713260510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e75nlwa4RFxqNbzR1xYnRqzE3pogwi/N6HklJl3ZIUs=;
        b=qdZZlph786RBPgeQPxiLs8lEAZEaOd3oLLmllmYKIxq5+eJeH/5kGwYxZld813OMfj
         0Cu81RAfRTAZbEEHHZfjjTzt/gr6rd8nK2WTbsRssDg544m7WZSxTM79yUt+beqMV0Vh
         tEujn0QpOQfUMXlub+3n+pXPdilpVFeS3NVlXQyvZ9P2TkRi2n40WDWVMIFnUKJGa9SF
         FA+JUIwqa6mdeQfbUEkLp9bX1MihHeqv2V1GZoV9biiITPhO8W7N9GZhBrqtc6kYlTVx
         CO5ebnc7mTt0swEPSBcNMgKXgekq4MledD/KLhAHDIBgoJWiT746qqWsUtFSa769Ekin
         Owcw==
X-Forwarded-Encrypted: i=1; AJvYcCUN8rQCKjElm5EGzJDMoflS+qugrIjGsUT0d1Ib6GuN8zrsuPL7qKEPIN+irWHuzfwSGAYOZ2gTI0gTSdxnvZUxnL+8jWEU0RWcoco3
X-Gm-Message-State: AOJu0YwVPxnaQ3uO9cdakV1gbDWOxWWV5SSxf5shQe4BfkJMBX4wYpQ6
	TH283QLu1N/Zfy2fxmq4klXxiHiKChIvuMVKBhHV6gIfcYfYu09SNAp9tN6EG1wkRdWJPCwT7hw
	hXzkn/18DLa46yRHTIIQaXwc5IQk=
X-Google-Smtp-Source: AGHT+IFKrU4IbiGWPR31h+jDsMjUbsv3xibBiJoMps6UGegTLCB20cs+Kh3Bcr+daKDwtGZvG6CSw1xTycpi5rsz+dE=
X-Received: by 2002:a05:6122:1d05:b0:4d4:21cc:5f4f with SMTP id
 gc5-20020a0561221d0500b004d421cc5f4fmr7129356vkb.11.1712655710067; Tue, 09
 Apr 2024 02:41:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408183946.2991168-1-ryan.roberts@arm.com>
 <20240408183946.2991168-3-ryan.roberts@arm.com> <CAGsJ_4xMaO8AWMGc4Od-FLWBhhT-u8f7QbR11VsqD0uqH3Kp6g@mail.gmail.com>
 <CAGsJ_4wpu2Nq0y3z7LYjPLJ1ZBi+BNRNKkyUPsXKDAg1POLjLA@mail.gmail.com> <44e23a4d-97e7-4d84-848a-f9325b7b76c0@redhat.com>
In-Reply-To: <44e23a4d-97e7-4d84-848a-f9325b7b76c0@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 9 Apr 2024 21:41:39 +1200
Message-ID: <CAGsJ_4wvjVAK+HBDo86xs4zv18QcCNzVRctr1gYMWwtYGNHvDg@mail.gmail.com>
Subject: Re: [PATCH v7 2/7] mm: swap: free_swap_and_cache_nr() as batched free_swap_and_cache()
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>, 
	Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Chris Li <chrisl@kernel.org>, 
	Lance Yang <ioworker0@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 9:24=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 09.04.24 11:22, Barry Song wrote:
> > On Tue, Apr 9, 2024 at 8:51=E2=80=AFPM Barry Song <21cnbao@gmail.com> w=
rote:
> >>
> >> On Tue, Apr 9, 2024 at 6:40=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>>
> >>> Now that we no longer have a convenient flag in the cluster to determ=
ine
> >>> if a folio is large, free_swap_and_cache() will take a reference and
> >>> lock a large folio much more often, which could lead to contention an=
d
> >>> (e.g.) failure to split large folios, etc.
> >>>
> >>> Let's solve that problem by batch freeing swap and cache with a new
> >>> function, free_swap_and_cache_nr(), to free a contiguous range of swa=
p
> >>> entries together. This allows us to first drop a reference to each sw=
ap
> >>> slot before we try to release the cache folio. This means we only try=
 to
> >>> release the folio once, only taking the reference and lock once - muc=
h
> >>> better than the previous 512 times for the 2M THP case.
> >>>
> >>> Contiguous swap entries are gathered in zap_pte_range() and
> >>> madvise_free_pte_range() in a similar way to how present ptes are
> >>> already gathered in zap_pte_range().
> >>>
> >>> While we are at it, let's simplify by converting the return type of b=
oth
> >>> functions to void. The return value was used only by zap_pte_range() =
to
> >>> print a bad pte, and was ignored by everyone else, so the extra
> >>> reporting wasn't exactly guaranteed. We will still get the warning wi=
th
> >>> most of the information from get_swap_device(). With the batch versio=
n,
> >>> we wouldn't know which pte was bad anyway so could print the wrong on=
e.
> >>>
> >>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >>> ---
> >>>   include/linux/pgtable.h | 29 ++++++++++++
> >>>   include/linux/swap.h    | 12 +++--
> >>>   mm/internal.h           | 63 ++++++++++++++++++++++++++
> >>>   mm/madvise.c            | 12 +++--
> >>>   mm/memory.c             | 13 +++---
> >>>   mm/swapfile.c           | 97 +++++++++++++++++++++++++++++++++-----=
---
> >>>   6 files changed, 195 insertions(+), 31 deletions(-)
> >>>
> >>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> >>> index a3fc8150b047..75096025fe52 100644
> >>> --- a/include/linux/pgtable.h
> >>> +++ b/include/linux/pgtable.h
> >>> @@ -708,6 +708,35 @@ static inline void pte_clear_not_present_full(st=
ruct mm_struct *mm,
> >>>   }
> >>>   #endif
> >>>
> >>> +#ifndef clear_not_present_full_ptes
> >>> +/**
> >>> + * clear_not_present_full_ptes - Clear multiple not present PTEs whi=
ch are
> >>> + *                              consecutive in the pgtable.
> >>> + * @mm: Address space the ptes represent.
> >>> + * @addr: Address of the first pte.
> >>> + * @ptep: Page table pointer for the first entry.
> >>> + * @nr: Number of entries to clear.
> >>> + * @full: Whether we are clearing a full mm.
> >>> + *
> >>> + * May be overridden by the architecture; otherwise, implemented as =
a simple
> >>> + * loop over pte_clear_not_present_full().
> >>> + *
> >>> + * Context: The caller holds the page table lock.  The PTEs are all =
not present.
> >>> + * The PTEs are all in the same PMD.
> >>> + */
> >>> +static inline void clear_not_present_full_ptes(struct mm_struct *mm,
> >>> +               unsigned long addr, pte_t *ptep, unsigned int nr, int=
 full)
> >>> +{
> >>> +       for (;;) {
> >>> +               pte_clear_not_present_full(mm, addr, ptep, full);
> >>> +               if (--nr =3D=3D 0)
> >>> +                       break;
> >>> +               ptep++;
> >>> +               addr +=3D PAGE_SIZE;
> >>> +       }
> >>> +}
> >>> +#endif
> >>> +
> >>>   #ifndef __HAVE_ARCH_PTEP_CLEAR_FLUSH
> >>>   extern pte_t ptep_clear_flush(struct vm_area_struct *vma,
> >>>                                unsigned long address,
> >>> diff --git a/include/linux/swap.h b/include/linux/swap.h
> >>> index f6f78198f000..5737236dc3ce 100644
> >>> --- a/include/linux/swap.h
> >>> +++ b/include/linux/swap.h
> >>> @@ -471,7 +471,7 @@ extern int swap_duplicate(swp_entry_t);
> >>>   extern int swapcache_prepare(swp_entry_t);
> >>>   extern void swap_free(swp_entry_t);
> >>>   extern void swapcache_free_entries(swp_entry_t *entries, int n);
> >>> -extern int free_swap_and_cache(swp_entry_t);
> >>> +extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
> >>>   int swap_type_of(dev_t device, sector_t offset);
> >>>   int find_first_swap(dev_t *device);
> >>>   extern unsigned int count_swap_pages(int, int);
> >>> @@ -520,8 +520,9 @@ static inline void put_swap_device(struct swap_in=
fo_struct *si)
> >>>   #define free_pages_and_swap_cache(pages, nr) \
> >>>          release_pages((pages), (nr));
> >>>
> >>> -/* used to sanity check ptes in zap_pte_range when CONFIG_SWAP=3D0 *=
/
> >>> -#define free_swap_and_cache(e) is_pfn_swap_entry(e)
> >>> +static inline void free_swap_and_cache_nr(swp_entry_t entry, int nr)
> >>> +{
> >>> +}
> >>>
> >>>   static inline void free_swap_cache(struct folio *folio)
> >>>   {
> >>> @@ -589,6 +590,11 @@ static inline int add_swap_extent(struct swap_in=
fo_struct *sis,
> >>>   }
> >>>   #endif /* CONFIG_SWAP */
> >>>
> >>> +static inline void free_swap_and_cache(swp_entry_t entry)
> >>> +{
> >>> +       free_swap_and_cache_nr(entry, 1);
> >>> +}
> >>> +
> >>>   #ifdef CONFIG_MEMCG
> >>>   static inline int mem_cgroup_swappiness(struct mem_cgroup *memcg)
> >>>   {
> >>> diff --git a/mm/internal.h b/mm/internal.h
> >>> index 3bdc8693b54f..de68705624b0 100644
> >>> --- a/mm/internal.h
> >>> +++ b/mm/internal.h
> >>> @@ -11,6 +11,8 @@
> >>>   #include <linux/mm.h>
> >>>   #include <linux/pagemap.h>
> >>>   #include <linux/rmap.h>
> >>> +#include <linux/swap.h>
> >>> +#include <linux/swapops.h>
> >>>   #include <linux/tracepoint-defs.h>
> >>>
> >>>   struct folio_batch;
> >>> @@ -189,6 +191,67 @@ static inline int folio_pte_batch(struct folio *=
folio, unsigned long addr,
> >>>
> >>>          return min(ptep - start_ptep, max_nr);
> >>>   }
> >>> +
> >>> +/**
> >>> + * pte_next_swp_offset - Increment the swap entry offset field of a =
swap pte.
> >>> + * @pte: The initial pte state; is_swap_pte(pte) must be true.
> >>> + *
> >>> + * Increments the swap offset, while maintaining all other fields, i=
ncluding
> >>> + * swap type, and any swp pte bits. The resulting pte is returned.
> >>> + */
> >>> +static inline pte_t pte_next_swp_offset(pte_t pte)
> >>> +{
> >>> +       swp_entry_t entry =3D pte_to_swp_entry(pte);
> >>> +       pte_t new =3D __swp_entry_to_pte(__swp_entry(swp_type(entry),
> >>> +                                                  swp_offset(entry) =
+ 1));
> >>> +
> >>> +       if (pte_swp_soft_dirty(pte))
> >>> +               new =3D pte_swp_mksoft_dirty(new);
> >>> +       if (pte_swp_exclusive(pte))
> >>> +               new =3D pte_swp_mkexclusive(new);
> >>> +       if (pte_swp_uffd_wp(pte))
> >>> +               new =3D pte_swp_mkuffd_wp(new);
> >>
> >> I don't quite understand this. If this page table entry is exclusive,
> >> will its subsequent page table entry also be exclusive without
> >> question?
> >> in try_to_unmap_one, exclusive is per-subpage but not per-folio:
> >>
> >>                  anon_exclusive =3D folio_test_anon(folio) &&
> >>                                   PageAnonExclusive(subpage);
> >>
> >> same questions also for diry, wp etc.
> >
> > Sorry for the noise. you are right. based on your new version, I think =
I should
> > entirely drop:
> >
> > [PATCH v2 3/5] mm: swap_pte_batch: add an output argument to reture if
> > all swap entries are exclusive
>
> Yes. If we ever want to ignore some bits, we should likely add flags to
> change the behavior, like for folio_pte_batch().
>
> For swapin, you really want the exclusive bits to match, though.

I am not quite sure I definitely need exclusive bits to match. i can either
drop my 3/5 or ignore the exclusive bit as below (if anyone is not shared,
swpin won't reuse the large folio, but it can still entirely map it read-on=
ly):

diff --git a/mm/internal.h b/mm/internal.h
index cae39c372bfc..5726e729c9ee 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -253,10 +253,22 @@ static inline int swap_pte_batch(pte_t
*start_ptep, int max_nr, pte_t pte,
                *any_shared |=3D !pte_swp_exclusive(pte);

        while (ptep < end_ptep) {
+               pte_t ignore_exclusive_pte;
+               pte_t ignore_exclusive_expected_pte;
                pte =3D ptep_get(ptep);

-               if (!pte_same(pte, expected_pte))
-                       break;
+               if (any_shared) {
+                       ignore_exclusive_pte =3D pte;
+                       ignore_exclusive_expected_pte =3D expected_pte;
+                       ignore_exclusive_pte =3D
pte_swp_clear_exclusive(ignore_exclusive_pte);
+                       ignore_exclusive_expected_pte =3D
pte_swp_clear_exclusive(expected_pte);
+
+                       if (!pte_same(ignore_exclusive_pte,
ignore_exclusive_expected_pte))
+                               break;
+               } else {
+                       if (!pte_same(pte, expected_pte))
+                               break;
+               }

                if (any_shared)
                        *any_shared |=3D !pte_swp_exclusive(pte);

> softdirty and uffd-wp as well at least initially for simplicity.

yes for this.

By the way, I wonder if you and Ryan have a moment to review swpin
refault patchset
v2 :-)

[PATCH v2 0/5] large folios swap-in: handle refault cases first
https://lore.kernel.org/linux-mm/20240409082631.187483-1-21cnbao@gmail.com/


>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry

