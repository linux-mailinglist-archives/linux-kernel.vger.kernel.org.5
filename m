Return-Path: <linux-kernel+bounces-101361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A623587A5F7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 568C4281B13
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5B23D0D9;
	Wed, 13 Mar 2024 10:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qd5FEAKI"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE073199BA
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 10:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710326254; cv=none; b=WD1CSYHGTE/NkLhOMa6+HcIci16XEtnmZA4+V1JxDdHsxRivtjcqPBqK5Slj/cH6QHoK+vSXzXzBo5znA3yO7q3XX6Rnq7nhyHny7o/sgdMSX6Q64LOkUuuKh1XFzaqC5+kYyVgjA4PO4tZPVU39H5a+25nIZQmGcBAVgRnGz4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710326254; c=relaxed/simple;
	bh=mhrq0qntUzbh1FnywoVcDodLpFwB2AoohYWNV2IzP3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hEmifrVDGaL+gWDMgQu6mp5wDICyU1eJW+GNsnrc12Yj1OiKlII8RDbweGJBwcLaFAWSNNQuS+E+om/DkoCZSDrkmwukBk2DxMs6UuD3srbQc2MI6AeSOcrhbnTNDaJ+x0WoWh9c7DlgnJsiD/EiupeVdj1Z/I+FNxMObAu1SIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qd5FEAKI; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7dbb7f8016eso437176241.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 03:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710326251; x=1710931051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCYFlkZ7ngILjlabGFnEccTfsaoVeZ0IKreojfnJ8PE=;
        b=Qd5FEAKIMIhkkxo8ywfefuDbD8NFlBe9ITmN7Z00VvOK13ZwcwGkjrE+isU+dygFaV
         U/sUZCzTO/sUCxogmETsEl1SlXrGMiU/YoVoT7cDEK3KrmaKNcNc9ISp8Fth11MGtlR8
         aa0hoRjzTDOY+ByywBB1BtpYHEx7Uf+G5qfPFZkShaYlbtjM+2Hx1I4W9A058M3pNzQ7
         UzHtkGaRlgjRK/Y/bIZLe8fxWgxJ5Y5gXtZUb8qy19o/0srY1+/zASD5EUB67LxOrm3K
         a5AW7+TLMynKgTemeVrfPrx/sBGGUmTcEr7NpGlyOUaGJ/mkzzHEkdvoNJgqGq2g7y9h
         LJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710326251; x=1710931051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cCYFlkZ7ngILjlabGFnEccTfsaoVeZ0IKreojfnJ8PE=;
        b=kvhckwK2VVP+Ma3m9Zgwnh7PR3Cq6dZAEfO5soI0OqZw0QNiryq5fcCWyvTKOoJApH
         D/Rv8DPGOK3vaPS6wuzOg5N3hEy6J1jQoYIp44DgZielclvv4549o8fQmZrGFSWYUFEZ
         O185iMACwf4wBkEEKp2xXBGGjEhNOphihklrAoy8xwhtjWjNQyqrmHsifUAGd06sKHbE
         +kpmPRsVRv/83/LQtAmNvt1TvUWZS32gf48/Ta9sQDtvA2/wT2VSbeq1kmvcLjZu+cf7
         oLwRzVAnrZA/2T+79A4X7dLRZHnQbGN6AtGuPmWNWCi2tzeXPfDiR23MAGM2E+WFeN4c
         71XA==
X-Forwarded-Encrypted: i=1; AJvYcCWnbLx+usn9MTS+1LedbAYXN4pQJpIEl3p06hmu2Ri3UKH8aiV5vTjHNvpCcw+QI6cnkvuKH6tq+mMmxv96u//1oQTOZlzRp0ChFw9f
X-Gm-Message-State: AOJu0Yy2JUVwpkVBQ2bvot0G5uE4DppXAhVx9ns5jjJTTt5wnaOP3Uwg
	7D1hMWF+7QaQ3CfyJ9pouWJaN4f6/UOH96TqWE2pWNFJgpPNoZKueG2Zz+WlxG18EzT5wPlK7mQ
	t1kiW579WCTayAgfNlW+PZCfLp+o=
X-Google-Smtp-Source: AGHT+IEelr0D88mw7GjjdiDzBCc5iIgK/be9AwLVn+7bjZsDaYGkyFeadHgCw5YMgzA+ryEtl5cSmb6mLYUsSByEW6g=
X-Received: by 2002:a67:f288:0:b0:474:c786:87a4 with SMTP id
 m8-20020a67f288000000b00474c78687a4mr1478158vsk.3.1710326251332; Wed, 13 Mar
 2024 03:37:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
 <20240311150058.1122862-7-ryan.roberts@arm.com> <CAGsJ_4wpjqRsn7ouO=Ut9oMBLSh803=XuSPX6gJ5nQ3jyqh3hQ@mail.gmail.com>
 <a75ec640-d025-45ee-b74d-305aaa3cc1ce@arm.com> <CAGsJ_4wodFkL4YZ1iQveUjK6QL7sNajyayBq4hJ3-GPoWJ6foQ@mail.gmail.com>
 <00a3ba1d-98e1-409b-ae6e-7fbcbdcd74d5@arm.com>
In-Reply-To: <00a3ba1d-98e1-409b-ae6e-7fbcbdcd74d5@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 13 Mar 2024 23:37:19 +1300
Message-ID: <CAGsJ_4xpiyCaNmSK4P3PitKeOsDBmOzf-4AZPnHcv4S=-TmtzQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] mm: madvise: Avoid split during MADV_PAGEOUT and MADV_COLD
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Lance Yang <ioworker0@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Chris Li <chrisl@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 10:36=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> On 13/03/2024 09:16, Barry Song wrote:
> > On Wed, Mar 13, 2024 at 10:03=E2=80=AFPM Ryan Roberts <ryan.roberts@arm=
com> wrote:
> >>
> >> On 13/03/2024 07:19, Barry Song wrote:
> >>> On Tue, Mar 12, 2024 at 4:01=E2=80=AFAM Ryan Roberts <ryan.roberts@ar=
m.com> wrote:
> >>>>
> >>>> Rework madvise_cold_or_pageout_pte_range() to avoid splitting any la=
rge
> >>>> folio that is fully and contiguously mapped in the pageout/cold vm
> >>>> range. This change means that large folios will be maintained all th=
e
> >>>> way to swap storage. This both improves performance during swap-out,=
 by
> >>>> eliding the cost of splitting the folio, and sets us up nicely for
> >>>> maintaining the large folio when it is swapped back in (to be covere=
d in
> >>>> a separate series).
> >>>>
> >>>> Folios that are not fully mapped in the target range are still split=
,
> >>>> but note that behavior is changed so that if the split fails for any
> >>>> reason (folio locked, shared, etc) we now leave it as is and move to=
 the
> >>>> next pte in the range and continue work on the proceeding folios.
> >>>> Previously any failure of this sort would cause the entire operation=
 to
> >>>> give up and no folios mapped at higher addresses were paged out or m=
ade
> >>>> cold. Given large folios are becoming more common, this old behavior
> >>>> would have likely lead to wasted opportunities.
> >>>>
> >>>> While we are at it, change the code that clears young from the ptes =
to
> >>>> use ptep_test_and_clear_young(), which is more efficent than
> >>>> get_and_clear/modify/set, especially for contpte mappings on arm64,
> >>>> where the old approach would require unfolding/refolding and the new
> >>>> approach can be done in place.
> >>>>
> >>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >>>
> >>> This looks so much better than our initial RFC.
> >>> Thank you for your excellent work!
> >>
> >> Thanks - its a team effort - I had your PoC and David's previous batch=
ing work
> >> to use as a template.
> >>
> >>>
> >>>> ---
> >>>>  mm/madvise.c | 89 ++++++++++++++++++++++++++++++-------------------=
---
> >>>>  1 file changed, 51 insertions(+), 38 deletions(-)
> >>>>
> >>>> diff --git a/mm/madvise.c b/mm/madvise.c
> >>>> index 547dcd1f7a39..56c7ba7bd558 100644
> >>>> --- a/mm/madvise.c
> >>>> +++ b/mm/madvise.c
> >>>> @@ -336,6 +336,7 @@ static int madvise_cold_or_pageout_pte_range(pmd=
_t *pmd,
> >>>>         LIST_HEAD(folio_list);
> >>>>         bool pageout_anon_only_filter;
> >>>>         unsigned int batch_count =3D 0;
> >>>> +       int nr;
> >>>>
> >>>>         if (fatal_signal_pending(current))
> >>>>                 return -EINTR;
> >>>> @@ -423,7 +424,8 @@ static int madvise_cold_or_pageout_pte_range(pmd=
_t *pmd,
> >>>>                 return 0;
> >>>>         flush_tlb_batched_pending(mm);
> >>>>         arch_enter_lazy_mmu_mode();
> >>>> -       for (; addr < end; pte++, addr +=3D PAGE_SIZE) {
> >>>> +       for (; addr < end; pte +=3D nr, addr +=3D nr * PAGE_SIZE) {
> >>>> +               nr =3D 1;
> >>>>                 ptent =3D ptep_get(pte);
> >>>>
> >>>>                 if (++batch_count =3D=3D SWAP_CLUSTER_MAX) {
> >>>> @@ -447,55 +449,66 @@ static int madvise_cold_or_pageout_pte_range(p=
md_t *pmd,
> >>>>                         continue;
> >>>>
> >>>>                 /*
> >>>> -                * Creating a THP page is expensive so split it only=
 if we
> >>>> -                * are sure it's worth. Split it if we are only owne=
r.
> >>>> +                * If we encounter a large folio, only split it if i=
t is not
> >>>> +                * fully mapped within the range we are operating on=
 Otherwise
> >>>> +                * leave it as is so that it can be swapped out whol=
e. If we
> >>>> +                * fail to split a folio, leave it in place and adva=
nce to the
> >>>> +                * next pte in the range.
> >>>>                  */
> >>>>                 if (folio_test_large(folio)) {
> >>>> -                       int err;
> >>>> -
> >>>> -                       if (folio_estimated_sharers(folio) > 1)
> >>>> -                               break;
> >>>> -                       if (pageout_anon_only_filter && !folio_test_=
anon(folio))
> >>>> -                               break;
> >>>> -                       if (!folio_trylock(folio))
> >>>> -                               break;
> >>>> -                       folio_get(folio);
> >>>> -                       arch_leave_lazy_mmu_mode();
> >>>> -                       pte_unmap_unlock(start_pte, ptl);
> >>>> -                       start_pte =3D NULL;
> >>>> -                       err =3D split_folio(folio);
> >>>> -                       folio_unlock(folio);
> >>>> -                       folio_put(folio);
> >>>> -                       if (err)
> >>>> -                               break;
> >>>> -                       start_pte =3D pte =3D
> >>>> -                               pte_offset_map_lock(mm, pmd, addr, &=
ptl);
> >>>> -                       if (!start_pte)
> >>>> -                               break;
> >>>> -                       arch_enter_lazy_mmu_mode();
> >>>> -                       pte--;
> >>>> -                       addr -=3D PAGE_SIZE;
> >>>> -                       continue;
> >>>> +                       const fpb_t fpb_flags =3D FPB_IGNORE_DIRTY |
> >>>> +                                               FPB_IGNORE_SOFT_DIRT=
Y;
> >>>> +                       int max_nr =3D (end - addr) / PAGE_SIZE;
> >>>> +
> >>>> +                       nr =3D folio_pte_batch(folio, addr, pte, pte=
nt, max_nr,
> >>>> +                                            fpb_flags, NULL);
> >>>
> >>> I wonder if we have a quick way to avoid folio_pte_batch() if users
> >>> are doing madvise() on a portion of a large folio.
> >>
> >> Good idea. Something like this?:
> >>
> >>         if (pte_pfn(pte) =3D=3D folio_pfn(folio)
> >
> > what about
> >
> > "If (pte_pfn(pte) =3D=3D folio_pfn(folio) && max_nr >=3D nr_pages)"
> >
> >  just to account for cases where the user's end address falls within
> > the middle of a large folio?
>
> yes, even better. I'll add this for the next version.
>
> >
> >
> > BTW, another minor issue is here:
> >
> >                 if (++batch_count =3D=3D SWAP_CLUSTER_MAX) {
> >                         batch_count =3D 0;
> >                         if (need_resched()) {
> >                                 arch_leave_lazy_mmu_mode();
> >                                 pte_unmap_unlock(start_pte, ptl);
> >                                 cond_resched();
> >                                 goto restart;
> >                         }
> >                 }
> >
> > We are increasing 1 for nr ptes, thus, we are holding PTL longer
> > than small folios case? we used to increase 1 for each PTE.
> > Does it matter?
>
> I thought about that, but the vast majority of the work is per-folio, not
> per-pte. So I concluded it would be best to continue to increment per-fol=
io.

Okay. The original patch commit b2f557a21bc8 ("mm/madvise: add
cond_resched() in madvise_cold_or_pageout_pte_range()")
primarily addressed the real-time wake-up latency issue. MADV_PAGEOUT
and MADV_COLD are much less critical compared
to other scenarios where operations like do_anon_page or do_swap_page
necessarily need PTL to progress. Therefore, adopting
an approach that relatively aggressively releases the PTL seems to
neither harm MADV_PAGEOUT/COLD nor disadvantage
others.

We are slightly increasing the duration of holding the PTL due to the
iteration of folio_pte_batch() potentially taking longer than
the case of small folios, which do not require it. However, compared
to operations like folio_isolate_lru() and folio_deactivate(),
this increase seems negligible. Recently, we have actually removed
ptep_test_and_clear_young() for MADV_PAGEOUT,
which should also benefit real-time scenarios. Nonetheless, there is a
small risk with large folios, such as 1 MiB mTHP, where
we may need to loop 256 times in folio_pte_batch().

I would vote for increasing 'nr' or maybe max(log2(nr), 1) rather than
1 for two reasons:

1. We are not making MADV_PAGEOUT/COLD worse; in fact, we are
improving them by reducing the time taken to put the same
number of pages into the reclaim list.

2. MADV_PAGEOUT/COLD scenarios are not urgent compared to others that
genuinely require the PTL to progress. Moreover,
the majority of time spent on PAGEOUT is actually reclaim_pages().

> >
> >>                 nr =3D folio_pte_batch(folio, addr, pte, ptent, max_nr=
,
> >>                                      fpb_flags, NULL);
> >>
> >> If we are not mapping the first page of the folio, then it can't be a =
full
> >> mapping, so no need to call folio_pte_batch(). Just split it.
> >>
> >>>
> >>>> +
> >>>> +                       if (nr < folio_nr_pages(folio)) {
> >>>> +                               int err;
> >>>> +
> >>>> +                               if (folio_estimated_sharers(folio) >=
 1)
> >>>> +                                       continue;
> >>>> +                               if (pageout_anon_only_filter && !fol=
io_test_anon(folio))
> >>>> +                                       continue;
> >>>> +                               if (!folio_trylock(folio))
> >>>> +                                       continue;
> >>>> +                               folio_get(folio);
> >>>> +                               arch_leave_lazy_mmu_mode();
> >>>> +                               pte_unmap_unlock(start_pte, ptl);
> >>>> +                               start_pte =3D NULL;
> >>>> +                               err =3D split_folio(folio);
> >>>> +                               folio_unlock(folio);
> >>>> +                               folio_put(folio);
> >>>> +                               if (err)
> >>>> +                                       continue;
> >>>> +                               start_pte =3D pte =3D
> >>>> +                                       pte_offset_map_lock(mm, pmd,=
 addr, &ptl);
> >>>> +                               if (!start_pte)
> >>>> +                                       break;
> >>>> +                               arch_enter_lazy_mmu_mode();
> >>>> +                               nr =3D 0;
> >>>> +                               continue;
> >>>> +                       }
> >>>>                 }
> >>>>
> >>>>                 /*
> >>>>                  * Do not interfere with other mappings of this foli=
o and
> >>>> -                * non-LRU folio.
> >>>> +                * non-LRU folio. If we have a large folio at this p=
oint, we
> >>>> +                * know it is fully mapped so if its mapcount is the=
 same as its
> >>>> +                * number of pages, it must be exclusive.
> >>>>                  */
> >>>> -               if (!folio_test_lru(folio) || folio_mapcount(folio) =
!=3D 1)
> >>>> +               if (!folio_test_lru(folio) ||
> >>>> +                   folio_mapcount(folio) !=3D folio_nr_pages(folio)=
)
> >>>>                         continue;
> >>>
> >>> This looks so perfect and is exactly what I wanted to achieve.
> >>>
> >>>>
> >>>>                 if (pageout_anon_only_filter && !folio_test_anon(fol=
io))
> >>>>                         continue;
> >>>>
> >>>> -               VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
> >>>> -
> >>>> -               if (!pageout && pte_young(ptent)) {
> >>>> -                       ptent =3D ptep_get_and_clear_full(mm, addr, =
pte,
> >>>> -                                                       tlb->fullmm)=
;
> >>>> -                       ptent =3D pte_mkold(ptent);
> >>>> -                       set_pte_at(mm, addr, pte, ptent);
> >>>> -                       tlb_remove_tlb_entry(tlb, pte, addr);
> >>>> +               if (!pageout) {
> >>>> +                       for (; nr !=3D 0; nr--, pte++, addr +=3D PAG=
E_SIZE) {
> >>>> +                               if (ptep_test_and_clear_young(vma, a=
ddr, pte))
> >>>> +                                       tlb_remove_tlb_entry(tlb, pt=
e, addr);
> >>>> +                       }
> >>>
> >>> This looks so smart. if it is not pageout, we have increased pte
> >>> and addr here; so nr is 0 and we don't need to increase again in
> >>> for (; addr < end; pte +=3D nr, addr +=3D nr * PAGE_SIZE)
> >>>
> >>> otherwise, nr won't be 0. so we will increase addr and
> >>> pte by nr.
> >>
> >> Indeed. I'm hoping that Lance is able to follow a similar pattern for
> >> madvise_free_pte_range().
> >>
> >>
> >>>
> >>>
> >>>>                 }
> >>>>
> >>>>                 /*
> >>>> --
> >>>> 2.25.1
> >>>>
> >>>
> >>> Overall, LGTM,
> >>>
> >>> Reviewed-by: Barry Song <v-songbaohua@oppo.com>
> >>
> >> Thanks!
> >>

Thanks
Barry

