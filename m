Return-Path: <linux-kernel+bounces-136677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E8C89D6FD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CACD285BCE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8538529C;
	Tue,  9 Apr 2024 10:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFAQaD2t"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CB184D3A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 10:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712658606; cv=none; b=NO8uuo/bnawZT6n8IKMRnJUieQX5nMfGFGgn07LBxXdx+BYBHmT4+AUGCxDAuGYsWx8XXheATUDUP7N5LZvz9KeB8uC/Ec5BRTOkDwVu9BH3iYK/g+6X0JyFAZYIFuVTB/eVX7kS0q7++rMJ3NMxYddawOi+5SdOvtomDfRP3BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712658606; c=relaxed/simple;
	bh=mKdSQsd5dg7AFtJs9mvWMFNnsj1IF28XZm84Rx6D3Qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CIcLHW9IcYBMpFHnwV1y0BbWv/N6lz5T/Mvh1lxq8v+T7Z4BQc4AnNYvp/DlTqTC5cCoRZulEy51HylMtlKu1IEW9eXQF/o7n+WAWORHG4MBlFh2/jq2XUZFR87ws1kojsfUT2hl6bNMxO8RHWRthcfVLodtefX5KI0sJpxFQjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFAQaD2t; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-479e45cc9e7so1230076137.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 03:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712658604; x=1713263404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsGoKaeRkKgjEDjNb3s/lpnka/plaKuqGEcl6UDIdVU=;
        b=bFAQaD2tv3trWQJd1iF1M/QAsAnT44l8ZwkyQsFHFsZAC2CixnXbA6hEncxlJh9Eb7
         OrKntCcZbsU1DT+NH5HoxR0Fs05u8WtqTa+cpS0w3muga9b5KS+EULu16liOEkzW7yJd
         ik9e+bKWWjEdtTUAhrfr/gb60NKi/Sc3AjYwJ/55SqEYX0lnurqQA4fcFnUW+8NudcEc
         mUMagxs6Bm1l3zAPGe2kid0N5nmbpFs+WfIlG1kcnSuAMUkM7pusIw8Nte9r2RLG+9Ac
         7BlzNVOJQ+uffiGStC8L0TGjSOgL1SOCTl6nMQLqiO8MLSvRjpedsV+IAEh9j4PwJ+HJ
         ctVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712658604; x=1713263404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dsGoKaeRkKgjEDjNb3s/lpnka/plaKuqGEcl6UDIdVU=;
        b=tp1HTtvcSz9vqWhhpP4sgWSNBnlNk2y7N8O4molVeUWzS1oRCyvUuH4K1f6Fw/YpX+
         gUuO1plZPQHhwMId8urV+EcGODop+sKdm+w0nEvDWNn2+lIYYrmSY53rpCS/KQorP8Is
         TL6dwpOt23ZlkTZayyCDp2YDSCnG5nan3on3j5Tlhc5oVf5Fd+fJIjD13RnRB3MVFcYJ
         pQoxne9bhfjj/0N2PqV7iSYSyVBnKTtWEuiVoyplthEzX3Sp1yoWcDGs1YPIthvDbU6L
         juI+PNSvp7qJZhFhIdGQA/nBfx2KqEzWHQYWba3bhBtiNNEE8k5wA4IN03sppslroRQo
         RqEg==
X-Forwarded-Encrypted: i=1; AJvYcCVhapz0M/i42LuqQzFCtVKMnOmtenXPxNpiAXzV0XwVBzvs35gsdWMzJHBeSWPLqnaULDkMDY06yBNXe2zFTrQgK9mRvDPmWw/BXgM3
X-Gm-Message-State: AOJu0YxBIU0N92DERtQF1oc1Qw2nogBaCt5ybfGFGn+DEBukLm21+Mq0
	eOeX1+0vXCNZeJQoIrieJB5Za+jSYgMWjCTtq8Ffk7MrzmKtmVt5yhEFuDHIzJ+65fRkxJ0PsF1
	M0j50xQFYW7sB1t+uvZ3LaxdLbok=
X-Google-Smtp-Source: AGHT+IHosp1ukWRmHjxX7dz7334NnaNrsDrOU2y6hy8Y2FNjF8zXS0KN8m4FS49RYGMkaOw0/alNyvfG/SWeJVZysE0=
X-Received: by 2002:a05:6102:3f06:b0:475:ffc3:3b3e with SMTP id
 k6-20020a0561023f0600b00475ffc33b3emr12261655vsv.29.1712658603916; Tue, 09
 Apr 2024 03:30:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408183946.2991168-1-ryan.roberts@arm.com>
 <20240408183946.2991168-3-ryan.roberts@arm.com> <CAGsJ_4xMaO8AWMGc4Od-FLWBhhT-u8f7QbR11VsqD0uqH3Kp6g@mail.gmail.com>
 <CAGsJ_4wpu2Nq0y3z7LYjPLJ1ZBi+BNRNKkyUPsXKDAg1POLjLA@mail.gmail.com>
 <44e23a4d-97e7-4d84-848a-f9325b7b76c0@redhat.com> <CAGsJ_4wvjVAK+HBDo86xs4zv18QcCNzVRctr1gYMWwtYGNHvDg@mail.gmail.com>
 <b18a5a7b-f787-4be8-a617-e86a56c140e6@arm.com>
In-Reply-To: <b18a5a7b-f787-4be8-a617-e86a56c140e6@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 9 Apr 2024 22:29:52 +1200
Message-ID: <CAGsJ_4xU1zYNvBObrKDOqRY7RE0R63d1VeTyRnKa8LPZt3rijw@mail.gmail.com>
Subject: Re: [PATCH v7 2/7] mm: swap: free_swap_and_cache_nr() as batched free_swap_and_cache()
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>, 
	Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Chris Li <chrisl@kernel.org>, 
	Lance Yang <ioworker0@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 9:55=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 09/04/2024 10:41, Barry Song wrote:
> > On Tue, Apr 9, 2024 at 9:24=E2=80=AFPM David Hildenbrand <david@redhat.=
com> wrote:
> >>
> >> On 09.04.24 11:22, Barry Song wrote:
> >>> On Tue, Apr 9, 2024 at 8:51=E2=80=AFPM Barry Song <21cnbao@gmail.com>=
 wrote:
> >>>>
> >>>> On Tue, Apr 9, 2024 at 6:40=E2=80=AFAM Ryan Roberts <ryan.roberts@ar=
m.com> wrote:
> >>>>>
> >>>>> Now that we no longer have a convenient flag in the cluster to dete=
rmine
> >>>>> if a folio is large, free_swap_and_cache() will take a reference an=
d
> >>>>> lock a large folio much more often, which could lead to contention =
and
> >>>>> (e.g.) failure to split large folios, etc.
> >>>>>
> >>>>> Let's solve that problem by batch freeing swap and cache with a new
> >>>>> function, free_swap_and_cache_nr(), to free a contiguous range of s=
wap
> >>>>> entries together. This allows us to first drop a reference to each =
swap
> >>>>> slot before we try to release the cache folio. This means we only t=
ry to
> >>>>> release the folio once, only taking the reference and lock once - m=
uch
> >>>>> better than the previous 512 times for the 2M THP case.
> >>>>>
> >>>>> Contiguous swap entries are gathered in zap_pte_range() and
> >>>>> madvise_free_pte_range() in a similar way to how present ptes are
> >>>>> already gathered in zap_pte_range().
> >>>>>
> >>>>> While we are at it, let's simplify by converting the return type of=
 both
> >>>>> functions to void. The return value was used only by zap_pte_range(=
) to
> >>>>> print a bad pte, and was ignored by everyone else, so the extra
> >>>>> reporting wasn't exactly guaranteed. We will still get the warning =
with
> >>>>> most of the information from get_swap_device(). With the batch vers=
ion,
> >>>>> we wouldn't know which pte was bad anyway so could print the wrong =
one.
> >>>>>
> >>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >>>>> ---
> >>>>>   include/linux/pgtable.h | 29 ++++++++++++
> >>>>>   include/linux/swap.h    | 12 +++--
> >>>>>   mm/internal.h           | 63 ++++++++++++++++++++++++++
> >>>>>   mm/madvise.c            | 12 +++--
> >>>>>   mm/memory.c             | 13 +++---
> >>>>>   mm/swapfile.c           | 97 +++++++++++++++++++++++++++++++++---=
-----
> >>>>>   6 files changed, 195 insertions(+), 31 deletions(-)
> >>>>>
> >>>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> >>>>> index a3fc8150b047..75096025fe52 100644
> >>>>> --- a/include/linux/pgtable.h
> >>>>> +++ b/include/linux/pgtable.h
> >>>>> @@ -708,6 +708,35 @@ static inline void pte_clear_not_present_full(=
struct mm_struct *mm,
> >>>>>   }
> >>>>>   #endif
> >>>>>
> >>>>> +#ifndef clear_not_present_full_ptes
> >>>>> +/**
> >>>>> + * clear_not_present_full_ptes - Clear multiple not present PTEs w=
hich are
> >>>>> + *                              consecutive in the pgtable.
> >>>>> + * @mm: Address space the ptes represent.
> >>>>> + * @addr: Address of the first pte.
> >>>>> + * @ptep: Page table pointer for the first entry.
> >>>>> + * @nr: Number of entries to clear.
> >>>>> + * @full: Whether we are clearing a full mm.
> >>>>> + *
> >>>>> + * May be overridden by the architecture; otherwise, implemented a=
s a simple
> >>>>> + * loop over pte_clear_not_present_full().
> >>>>> + *
> >>>>> + * Context: The caller holds the page table lock.  The PTEs are al=
l not present.
> >>>>> + * The PTEs are all in the same PMD.
> >>>>> + */
> >>>>> +static inline void clear_not_present_full_ptes(struct mm_struct *m=
m,
> >>>>> +               unsigned long addr, pte_t *ptep, unsigned int nr, i=
nt full)
> >>>>> +{
> >>>>> +       for (;;) {
> >>>>> +               pte_clear_not_present_full(mm, addr, ptep, full);
> >>>>> +               if (--nr =3D=3D 0)
> >>>>> +                       break;
> >>>>> +               ptep++;
> >>>>> +               addr +=3D PAGE_SIZE;
> >>>>> +       }
> >>>>> +}
> >>>>> +#endif
> >>>>> +
> >>>>>   #ifndef __HAVE_ARCH_PTEP_CLEAR_FLUSH
> >>>>>   extern pte_t ptep_clear_flush(struct vm_area_struct *vma,
> >>>>>                                unsigned long address,
> >>>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
> >>>>> index f6f78198f000..5737236dc3ce 100644
> >>>>> --- a/include/linux/swap.h
> >>>>> +++ b/include/linux/swap.h
> >>>>> @@ -471,7 +471,7 @@ extern int swap_duplicate(swp_entry_t);
> >>>>>   extern int swapcache_prepare(swp_entry_t);
> >>>>>   extern void swap_free(swp_entry_t);
> >>>>>   extern void swapcache_free_entries(swp_entry_t *entries, int n);
> >>>>> -extern int free_swap_and_cache(swp_entry_t);
> >>>>> +extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
> >>>>>   int swap_type_of(dev_t device, sector_t offset);
> >>>>>   int find_first_swap(dev_t *device);
> >>>>>   extern unsigned int count_swap_pages(int, int);
> >>>>> @@ -520,8 +520,9 @@ static inline void put_swap_device(struct swap_=
info_struct *si)
> >>>>>   #define free_pages_and_swap_cache(pages, nr) \
> >>>>>          release_pages((pages), (nr));
> >>>>>
> >>>>> -/* used to sanity check ptes in zap_pte_range when CONFIG_SWAP=3D0=
 */
> >>>>> -#define free_swap_and_cache(e) is_pfn_swap_entry(e)
> >>>>> +static inline void free_swap_and_cache_nr(swp_entry_t entry, int n=
r)
> >>>>> +{
> >>>>> +}
> >>>>>
> >>>>>   static inline void free_swap_cache(struct folio *folio)
> >>>>>   {
> >>>>> @@ -589,6 +590,11 @@ static inline int add_swap_extent(struct swap_=
info_struct *sis,
> >>>>>   }
> >>>>>   #endif /* CONFIG_SWAP */
> >>>>>
> >>>>> +static inline void free_swap_and_cache(swp_entry_t entry)
> >>>>> +{
> >>>>> +       free_swap_and_cache_nr(entry, 1);
> >>>>> +}
> >>>>> +
> >>>>>   #ifdef CONFIG_MEMCG
> >>>>>   static inline int mem_cgroup_swappiness(struct mem_cgroup *memcg)
> >>>>>   {
> >>>>> diff --git a/mm/internal.h b/mm/internal.h
> >>>>> index 3bdc8693b54f..de68705624b0 100644
> >>>>> --- a/mm/internal.h
> >>>>> +++ b/mm/internal.h
> >>>>> @@ -11,6 +11,8 @@
> >>>>>   #include <linux/mm.h>
> >>>>>   #include <linux/pagemap.h>
> >>>>>   #include <linux/rmap.h>
> >>>>> +#include <linux/swap.h>
> >>>>> +#include <linux/swapops.h>
> >>>>>   #include <linux/tracepoint-defs.h>
> >>>>>
> >>>>>   struct folio_batch;
> >>>>> @@ -189,6 +191,67 @@ static inline int folio_pte_batch(struct folio=
 *folio, unsigned long addr,
> >>>>>
> >>>>>          return min(ptep - start_ptep, max_nr);
> >>>>>   }
> >>>>> +
> >>>>> +/**
> >>>>> + * pte_next_swp_offset - Increment the swap entry offset field of =
a swap pte.
> >>>>> + * @pte: The initial pte state; is_swap_pte(pte) must be true.
> >>>>> + *
> >>>>> + * Increments the swap offset, while maintaining all other fields,=
 including
> >>>>> + * swap type, and any swp pte bits. The resulting pte is returned.
> >>>>> + */
> >>>>> +static inline pte_t pte_next_swp_offset(pte_t pte)
> >>>>> +{
> >>>>> +       swp_entry_t entry =3D pte_to_swp_entry(pte);
> >>>>> +       pte_t new =3D __swp_entry_to_pte(__swp_entry(swp_type(entry=
),
> >>>>> +                                                  swp_offset(entry=
) + 1));
> >>>>> +
> >>>>> +       if (pte_swp_soft_dirty(pte))
> >>>>> +               new =3D pte_swp_mksoft_dirty(new);
> >>>>> +       if (pte_swp_exclusive(pte))
> >>>>> +               new =3D pte_swp_mkexclusive(new);
> >>>>> +       if (pte_swp_uffd_wp(pte))
> >>>>> +               new =3D pte_swp_mkuffd_wp(new);
> >>>>
> >>>> I don't quite understand this. If this page table entry is exclusive=
,
> >>>> will its subsequent page table entry also be exclusive without
> >>>> question?
> >>>> in try_to_unmap_one, exclusive is per-subpage but not per-folio:
> >>>>
> >>>>                  anon_exclusive =3D folio_test_anon(folio) &&
> >>>>                                   PageAnonExclusive(subpage);
> >>>>
> >>>> same questions also for diry, wp etc.
> >>>
> >>> Sorry for the noise. you are right. based on your new version, I thin=
k I should
> >>> entirely drop:
> >>>
> >>> [PATCH v2 3/5] mm: swap_pte_batch: add an output argument to reture i=
f
> >>> all swap entries are exclusive
> >>
> >> Yes. If we ever want to ignore some bits, we should likely add flags t=
o
> >> change the behavior, like for folio_pte_batch().
> >>
> >> For swapin, you really want the exclusive bits to match, though.
> >
> > I am not quite sure I definitely need exclusive bits to match. i can ei=
ther
> > drop my 3/5 or ignore the exclusive bit as below (if anyone is not shar=
ed,
> > swpin won't reuse the large folio, but it can still entirely map it rea=
d-only):
> >
> > diff --git a/mm/internal.h b/mm/internal.h
> > index cae39c372bfc..5726e729c9ee 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -253,10 +253,22 @@ static inline int swap_pte_batch(pte_t
> > *start_ptep, int max_nr, pte_t pte,
> >                 *any_shared |=3D !pte_swp_exclusive(pte);
> >
> >         while (ptep < end_ptep) {
> > +               pte_t ignore_exclusive_pte;
> > +               pte_t ignore_exclusive_expected_pte;
> >                 pte =3D ptep_get(ptep);
> >
> > -               if (!pte_same(pte, expected_pte))
> > -                       break;
> > +               if (any_shared) {
> > +                       ignore_exclusive_pte =3D pte;
> > +                       ignore_exclusive_expected_pte =3D expected_pte;
> > +                       ignore_exclusive_pte =3D
> > pte_swp_clear_exclusive(ignore_exclusive_pte);
> > +                       ignore_exclusive_expected_pte =3D
> > pte_swp_clear_exclusive(expected_pte);
> > +
> > +                       if (!pte_same(ignore_exclusive_pte,
> > ignore_exclusive_expected_pte))
> > +                               break;
> > +               } else {
> > +                       if (!pte_same(pte, expected_pte))
> > +                               break;
> > +               }
> >
> >                 if (any_shared)
> >                         *any_shared |=3D !pte_swp_exclusive(pte);
>
> I'll leave David to comment on this proposal; I'm not sure I understand a=
ll the
> details. The code change does look a bit "busy" though - sometimes that c=
an be
> an indicator :)

indeed. I wrote it in one minute.

I'm confident that the code can be written in a manner similar to
__pte_batch_clear_ignored. I was only proposing the approach,
not selling the code :-)

>
> >
> >> softdirty and uffd-wp as well at least initially for simplicity.
> >
> > yes for this.
> >
> > By the way, I wonder if you and Ryan have a moment to review swpin
> > refault patchset
> > v2 :-)
>
> It's on my todo list! I'm very keen to get as much large swap-out and swa=
p-in
> support into v6.10 as we can. Hoping to get to it inthe next couple of da=
ys.
>
> >
> > [PATCH v2 0/5] large folios swap-in: handle refault cases first
> > https://lore.kernel.org/linux-mm/20240409082631.187483-1-21cnbao@gmail.=
com/
> >
> >
> >>
> >> --
> >> Cheers,
> >>
> >> David / dhildenb
> >>
> >

Thanks
Barry
>

