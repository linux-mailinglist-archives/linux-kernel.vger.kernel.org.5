Return-Path: <linux-kernel+bounces-84135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC72A86A2AD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D02F28336D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622C955788;
	Tue, 27 Feb 2024 22:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b77OaArc"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D335576E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709073600; cv=none; b=t4IwWOtdFSsBgiAB50Kt6rT+uldGn2911HGtJmHH/NmxaGb/VX6VWzwoy+g+gn6locbOdvBZmwNvaR2/z6EkSMWs4DncCKB64n0h5UgWz4ETTjPBRxppegwhAij54Rn72+Ogqz2UjiEBrLexTWmWeyQLwYSxEa4P222B3t4Bf6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709073600; c=relaxed/simple;
	bh=R0I98wFiIbO4xoCEAHXxJyyh9gbZq8lMBswbkQJZERg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1hlynJJ0D+jlLJRE9dfCWKJcCYGD1hticwYMxcKRXTJCqWkrl+pcxPsvuAZ+T9rGu4g9uRJyLoTHoFxI7XokoMnEdctmKiLY3LrVJNEehpu3H7x4jcubKGmOOf7R7D6W9R76akaRX/aJZ1oqGmY2PeuZdt+tWh5FoWdpFxnA0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b77OaArc; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-787a8430006so312677585a.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709073597; x=1709678397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxUpWMCR8hNEAFIKta+eZ/m4DyipBT2mnf3KVgcZ+mE=;
        b=b77OaArcYuU2onapv8Qvk7rmOgs6N1pCyygbdkQzchW+gAuCIe4OMxAAgVBsUFX5Ns
         1LsRYB2yk6Y62OPRYc26fIPU74Ih6TnxW8g5e4VdSNpxEovvL8iCMS80LyZA1hYkWRDz
         7BOIldzbUV239Dki3BoXr2GaPtLSPhprwzrAaGHn0aKBRgEzX03RWdGb8qqt/3L11Rek
         vHMv0TqZFWlFq2RQMZ2PykgBOZik1zfIO/V9iTPAQniMYilu4shT+BDLPL6HbRjiP425
         3XQUh45Y1fWhoZARCo5SnqW8G/F1NOFh1sYUb35tO2a/ZgXRjmVFTSm3Ebl5J+mJvsB3
         3gbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709073597; x=1709678397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AxUpWMCR8hNEAFIKta+eZ/m4DyipBT2mnf3KVgcZ+mE=;
        b=sgD10RO2LpdCAEP9PQr/jMzyZILEcYfANXIwYFNMk62+ZdEBQ1KvUIzvH/w0g6tAk/
         NZYrrIwfZz8u92ERMZw3tVy80dIJ4VZhVfAYgLwI52S/iIi/EQy46EQx8/RL5zlwiVTu
         /pC6jziwzM8oM2Kijr8SWEtAl2GFjSdulDFVf6pUS6m/6uc4nc3j+7gfR47Uc6DYsDgZ
         qIJZ5nf/WLpKV4Z+I1JH46uZREgZNFGreET5TwIKMsrb+Is1WxThAPUXz6CZoNFCZW02
         VEzj5pksuxMV8cmoDvGNivi0RlFxv3N2Pc+wr1R7tSokjAc3sSZyYYlQm8+5FWU4ggjh
         IEXw==
X-Forwarded-Encrypted: i=1; AJvYcCXUnnYE5jbVfRSn6TK+FbVmDfBOYbqXomgolL1SKFy7nl2fs34rS3QvF37gdYEcPwRszU1313q/HYVt/8OfFPzNyPrC/hlwJH8fTnVJ
X-Gm-Message-State: AOJu0YxuBaJAzuihDhsgRPd5SvTnaXZL/OTk83cMzZvz3nOxLmcXCo/9
	S1//nefcqGg5gg/8l4n03xcLiQzYFRsmXBTJ8CE4bGOzF/xUx0aCos5EBTw7T5JClZ1GY8uXjUw
	nfayGTb8W/vHnwCCwGuA0Te4SA2Q=
X-Google-Smtp-Source: AGHT+IFkV/tuFCbI22oDXoor9C0zNy8Th1SebeCooBao0OnTsmGPWe4ju6Sl+/5sWLtpi1jNhMTY1GOdiOPgvvqmb1I=
X-Received: by 2002:a05:6214:f23:b0:68f:22b1:8e24 with SMTP id
 iw3-20020a0562140f2300b0068f22b18e24mr4999226qvb.28.1709073597328; Tue, 27
 Feb 2024 14:39:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025144546.577640-1-ryan.roberts@arm.com> <20240118111036.72641-1-21cnbao@gmail.com>
 <20240118111036.72641-7-21cnbao@gmail.com> <bafb4ab0-ebf5-4736-8a9d-a70a06c92013@arm.com>
In-Reply-To: <bafb4ab0-ebf5-4736-8a9d-a70a06c92013@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 28 Feb 2024 11:39:46 +1300
Message-ID: <CAGsJ_4wHDi1mZVLCrOEKV_X85x3SmsuHbYdGuVJ8PG1Kpqnu+w@mail.gmail.com>
Subject: Re: [PATCH RFC 6/6] mm: madvise: don't split mTHP for MADV_PAGEOUT
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, mhocko@suse.com, shy828301@gmail.com, 
	wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org, 
	ying.huang@intel.com, yuzhao@google.com, surenb@google.com, 
	steven.price@arm.com, Chuanhua Han <hanchuanhua@oppo.com>, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 1:22=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> Hi Barry,
>
> I've scanned through this patch as part of trying to understand the races=
 you
> have reported (It's going to take me a while to fully understand it all :=
) ). In
> the meantime I have a few comments on this patch...
>
> On 18/01/2024 11:10, Barry Song wrote:
> > From: Chuanhua Han <hanchuanhua@oppo.com>
> >
> > MADV_PAGEOUT and MADV_FREE are common cases in Android. Ryan's patchset=
 has
> > supported swapping large folios out as a whole for vmscan case. This pa=
tch
> > extends the feature to madvise.
> >
> > If madvised range covers the whole large folio, we don't split it. Othe=
rwise,
> > we still need to split it.
> >
> > This patch doesn't depend on ARM64's CONT-PTE, alternatively, it define=
s one
> > helper named pte_range_cont_mapped() to check if all PTEs are contiguou=
sly
> > mapped to a large folio.
> >
> > Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> > Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  include/asm-generic/tlb.h | 10 +++++++
> >  include/linux/pgtable.h   | 60 +++++++++++++++++++++++++++++++++++++++
> >  mm/madvise.c              | 48 +++++++++++++++++++++++++++++++
> >  3 files changed, 118 insertions(+)
> >
> > diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> > index 129a3a759976..f894e22da5d6 100644
> > --- a/include/asm-generic/tlb.h
> > +++ b/include/asm-generic/tlb.h
> > @@ -608,6 +608,16 @@ static inline void tlb_flush_p4d_range(struct mmu_=
gather *tlb,
> >               __tlb_remove_tlb_entry(tlb, ptep, address);     \
> >       } while (0)
> >
> > +#define tlb_remove_nr_tlb_entry(tlb, ptep, address, nr)               =
       \
> > +     do {                                                            \
> > +             int i;                                                  \
> > +             tlb_flush_pte_range(tlb, address,                       \
> > +                             PAGE_SIZE * nr);                        \
> > +             for (i =3D 0; i < nr; i++)                               =
 \
> > +                     __tlb_remove_tlb_entry(tlb, ptep + i,           \
> > +                                     address + i * PAGE_SIZE);       \
> > +     } while (0)
>
> David has recently added tlb_remove_tlb_entries() which does the same thi=
ng.

cool. While sending the patchset, we were not depending on other work.
Nice to know David's work can help this case.

>
> > +
> >  #define tlb_remove_huge_tlb_entry(h, tlb, ptep, address)     \
> >       do {                                                    \
> >               unsigned long _sz =3D huge_page_size(h);          \
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index 37fe83b0c358..da0c1cf447e3 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -320,6 +320,42 @@ static inline pgd_t pgdp_get(pgd_t *pgdp)
> >  }
> >  #endif
> >
> > +#ifndef pte_range_cont_mapped
> > +static inline bool pte_range_cont_mapped(unsigned long start_pfn,
> > +                                      pte_t *start_pte,
> > +                                      unsigned long start_addr,
> > +                                      int nr)
> > +{
> > +     int i;
> > +     pte_t pte_val;
> > +
> > +     for (i =3D 0; i < nr; i++) {
> > +             pte_val =3D ptep_get(start_pte + i);
> > +
> > +             if (pte_none(pte_val))
> > +                     return false;
> > +
> > +             if (pte_pfn(pte_val) !=3D (start_pfn + i))
> > +                     return false;
> > +     }
> > +
> > +     return true;
> > +}
> > +#endif
>
> David has recently added folio_pte_batch() which does a similar thing (as
> discussed in other context).

yes.

>
> > +
> > +#ifndef pte_range_young
> > +static inline bool pte_range_young(pte_t *start_pte, int nr)
> > +{
> > +     int i;
> > +
> > +     for (i =3D 0; i < nr; i++)
> > +             if (pte_young(ptep_get(start_pte + i)))
> > +                     return true;
> > +
> > +     return false;
> > +}
> > +#endif
>
> I wonder if this should come from folio_pte_batch()?

not quite sure folio_pte_batch can return young. but i guess
you already have a batched function to check if a large folio
is young?

>
> > +
> >  #ifndef __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
> >  static inline int ptep_test_and_clear_young(struct vm_area_struct *vma=
,
> >                                           unsigned long address,
> > @@ -580,6 +616,23 @@ static inline pte_t ptep_get_and_clear_full(struct=
 mm_struct *mm,
> >  }
> >  #endif
> >
> > +#define __HAVE_ARCH_PTEP_GET_AND_CLEAR_RANGE_FULL
> > +static inline pte_t ptep_get_and_clear_range_full(struct mm_struct *mm=
,
> > +                                               unsigned long start_add=
r,
> > +                                               pte_t *start_pte,
> > +                                               int nr, int full)
> > +{
> > +     int i;
> > +     pte_t pte;
> > +
> > +     pte =3D ptep_get_and_clear_full(mm, start_addr, start_pte, full);
> > +
> > +     for (i =3D 1; i < nr; i++)
> > +             ptep_get_and_clear_full(mm, start_addr + i * PAGE_SIZE,
> > +                                     start_pte + i, full);
> > +
> > +     return pte;
> > +}
>
> David has recently added get_and_clear_full_ptes(). Your version isn't ga=
thering
> access/dirty, which may be ok for your case, but not ok in general.

ok. glad to know we can use get_and_clear_full_ptes().

>
> >
> >  /*
> >   * If two threads concurrently fault at the same page, the thread that
> > @@ -995,6 +1048,13 @@ static inline void arch_swap_restore(swp_entry_t =
entry, struct folio *folio)
> >  })
> >  #endif
> >
> > +#ifndef pte_nr_addr_end
> > +#define pte_nr_addr_end(addr, size, end)                             \
> > +({   unsigned long __boundary =3D ((addr) + size) & (~(size - 1));    =
 \
> > +     (__boundary - 1 < (end) - 1)? __boundary: (end);                \
> > +})
> > +#endif
> > +
> >  /*
> >   * When walking page tables, we usually want to skip any p?d_none entr=
ies;
> >   * and any p?d_bad entries - reporting the error before resetting to n=
one.
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 912155a94ed5..262460ac4b2e 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -452,6 +452,54 @@ static int madvise_cold_or_pageout_pte_range(pmd_t=
 *pmd,
> >               if (folio_test_large(folio)) {
> >                       int err;
> >
> > +                     if (!folio_test_pmd_mappable(folio)) {
> > +                             int nr_pages =3D folio_nr_pages(folio);
> > +                             unsigned long folio_size =3D PAGE_SIZE * =
nr_pages;
> > +                             unsigned long start_addr =3D ALIGN_DOWN(a=
ddr, nr_pages * PAGE_SIZE);;
>
> I doubt it is correct to align down here. Couldn't you be going outside t=
he
> bounds that the user supplied?

Yes, it can. This is ugly and suspicious but does not cause problems
if the large folio's virtadd is aligned , but it is wrong if virtual addres=
s is
not aligned as explained below.

>
> nit: you've defined folio_size, why not use it here?
> nit: double semi-colon.
>
> > +                             unsigned long start_pfn =3D page_to_pfn(f=
olio_page(folio, 0));
> > +                             pte_t *start_pte =3D pte - (addr - start_=
addr) / PAGE_SIZE;
>
> I think start_pte could be off the start of the pgtable and into random m=
emory

> in some corner cases (and outside the protection of the PTL)? You're assu=
ming
> that the folio is fully and contigously mapped and correctly aligned. mre=
map
> (and other things) could break that assumption.

actually we don't run under the assumption folio is fully and
contiguously mapped.
but the code does assume a large folio's virtual address is aligned with
nr_pages * PAGE_SIZE.

OTOH,  we have  if (next - addr !=3D folio_size) to split folios if
users just want to partially
reclaim a large folio, but I do agree we should move if (next - addr
!=3D folio_size)
before pte_range_cont_mapped().

as long as the virt addr is aligned, pte_range_cont_mapped() won't
cause a problem
for the code even before if (next - addr !=3D folio_size) (but ugly and
suspicious) as it is
still under the protection of PTL since we don't cross a PMD for a
pte-mapped large
folio.

but you are really right, we have cases like mremap which can remap an alig=
ned
large folio to an unaligned address. I actually placed a trace point
in kernel, running
lots of phones, didn't find this case was happening. so i feel mremap
is really rare.
Is it possible to split large folios and avoid complexity  instead if
we are remapping
to an unaligned address?

And, the code is really completely wrong if the large folio is
unaligned. we have to
remove the assumption if that is really happening. So shouldn't do ALIGN_DO=
WN.

>
> > +                             unsigned long next =3D pte_nr_addr_end(ad=
dr, folio_size, end);
> > +
> > +                             if (!pte_range_cont_mapped(start_pfn, sta=
rt_pte, start_addr, nr_pages))
> > +                                     goto split;
> > +
> > +                             if (next - addr !=3D folio_size) {
> > +                                     goto split;
> > +                             } else {
> > +                                     /* Do not interfere with other ma=
ppings of this page */
> > +                                     if (folio_estimated_sharers(folio=
) !=3D 1)
> > +                                             goto skip;
> > +
> > +                                     VM_BUG_ON(addr !=3D start_addr ||=
 pte !=3D start_pte);
> > +
> > +                                     if (pte_range_young(start_pte, nr=
_pages)) {
> > +                                             ptent =3D ptep_get_and_cl=
ear_range_full(mm, start_addr, start_pte,
> > +                                                                      =
             nr_pages, tlb->fullmm);
> > +                                             ptent =3D pte_mkold(ptent=
);
> > +
> > +                                             set_ptes(mm, start_addr, =
start_pte, ptent, nr_pages);
> > +                                             tlb_remove_nr_tlb_entry(t=
lb, start_pte, start_addr, nr_pages);
> > +                                     }
> > +
> > +                                     folio_clear_referenced(folio);
> > +                                     folio_test_clear_young(folio);
> > +                                     if (pageout) {
> > +                                             if (folio_isolate_lru(fol=
io)) {
> > +                                                     if (folio_test_un=
evictable(folio))
> > +                                                             folio_put=
back_lru(folio);
> > +                                                     else
> > +                                                             list_add(=
&folio->lru, &folio_list);
> > +                                             }
> > +                                     } else
> > +                                             folio_deactivate(folio);
> > +                             }
> > +skip:
> > +                             pte +=3D (next - PAGE_SIZE - (addr & PAGE=
_MASK))/PAGE_SIZE;
> > +                             addr =3D next - PAGE_SIZE;
> > +                             continue;
> > +
> > +                     }
> > +split:
> >                       if (folio_estimated_sharers(folio) !=3D 1)
> >                               break;
> >                       if (pageout_anon_only_filter && !folio_test_anon(=
folio))

Thanks
Barry

