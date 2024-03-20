Return-Path: <linux-kernel+bounces-109016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44222881364
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 517281C22599
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4F447A63;
	Wed, 20 Mar 2024 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J49o7YFA"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0CB42073
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710945324; cv=none; b=IUCT/tT6YFsHmf6CVfAixOrz0ka9f/Qn94kMFLNeFbHhbRvgo5KHhxLDpQ+cHBewL96PRK2iwW4PKoMFMtac90FDCO4YPyppFzbYoytkSOaMtiGJQhLm/bjtodqwshYRjW5i0J7HNzZpaVWVglT0NzBiNRG0lpq5jh90fHtUASg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710945324; c=relaxed/simple;
	bh=HDnfRJlgj/BVeNv1RHLUhkTDcxcrJLIcGY9skjSzNw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uHwrkDe+JvtEK0rOhg0r7bYHpjq4JRJZN1rkde8XUU3RqaP7PVv8mLHtByaQx5hip7XMbGsDMV91XOyBd0SEwvIBWe/veMGdEfK0nrtjexbhKwYIgLbai+fspesgT5lTcrfodBRtP6pyUJ/qAbyEQgU+kIhmvPg5WpOloTFye7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J49o7YFA; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-609fb19ae76so72785087b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 07:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710945322; x=1711550122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQw4LqJtRSTxnpuasR1+89w7OEc9fb41JI6MyxKAeVQ=;
        b=J49o7YFAskxmDvqLQbY19MpMmeiA5zrgLNmwdiDmms3qqhvOkEFdiYYkSd2jhBZ2S+
         ss2r3223eE5xfy+h/9KBDR7bpNUFZU91Eq8MnDHvz+Llo93+5LUSz85Lj4HWmUeRowXb
         blSQAJCPxPbsDvH1edBZKcK/sYsTy16+TUMP1oFN/+zOLwmkeKiKXCkD+fN8UFSUnW54
         qAb/owLUDDYWXLG29h8YHS8tePgs74HBrzprQgfK5+BtCSb57ul/YV5IgcDkYWd27pbm
         aXypMx5NB2VrHksAugUHehEEvjiuXTdTbkcIjf858X1nTRHkGuRIUVDSS3lmmTZ0WkIp
         M7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710945322; x=1711550122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQw4LqJtRSTxnpuasR1+89w7OEc9fb41JI6MyxKAeVQ=;
        b=vHnGVnlcBRwbZ+RxXKnLua74kP3AWQDYN7gkQOdbaE31pwnDZAT7V96g68y9H43kzp
         jP6kRMKPcPlTQHX3Oe1KubUWA/kcJVLhiNpXJAcsh7Oh9jKplVRJjpHW2rdBYMyRXy5n
         8Dy93BapREEr3a4D4JH7qVeEnELYydjty8ircID6iYWWTVe0tkkGS+oCd6HdF+XOuexP
         yuHB+rECEZEzfUf6K0zUYb3Y/f2OV31j1CeBaQBUeKFnR6WvRPUab3tBe0j1SKbg6myY
         ej0Z/nevF+NGZgz49BiSqkOOiUg9x5QiY3sg34cXJYCHoQtYzzBI1NuJVyrLsPbUTULx
         Tmug==
X-Forwarded-Encrypted: i=1; AJvYcCWxRMh4ZYCi10lFb+hpkYprlgOyVBdysIqQPg6SKNm4xrMKMe3+MdaUoyb8W/FyfQAlY0+wA9MjAIkXH0SQYrL0pDW3ejaNWFf1UdiN
X-Gm-Message-State: AOJu0YyqZ6fdzwmymVDAY3xSouNtZlibZJUSnI8P+sby5sW1c11xj0vf
	1KQCgrQvmr20cZDKXNqEMzCxPM5ITyN7Toz0I3tJn8aMMGhYgrxDJPivywMCn3XZSSggdTW6jXe
	lRP2abilmJbsk+XjQgWeMfWR+QK4=
X-Google-Smtp-Source: AGHT+IGo3Od7BLDoZc9OLt3q5G0qUriehLBxvf8AaigJfsUa3Fd14cqK0AugjnxYKErz+59Bc578lIgIJEm+uLVoIhA=
X-Received: by 2002:a81:ac1c:0:b0:60f:d6fc:74f3 with SMTP id
 k28-20020a81ac1c000000b0060fd6fc74f3mr14431030ywh.7.1710945320287; Wed, 20
 Mar 2024 07:35:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
 <20240311150058.1122862-7-ryan.roberts@arm.com> <CAGsJ_4wpjqRsn7ouO=Ut9oMBLSh803=XuSPX6gJ5nQ3jyqh3hQ@mail.gmail.com>
 <a75ec640-d025-45ee-b74d-305aaa3cc1ce@arm.com> <CAK1f24k1AuHDdrLFNLvwdoOy=xJTVkVdfY4+SN+KW5-EiMSa9Q@mail.gmail.com>
 <7ba06704-2090-4eb2-9534-c4d467cc085a@arm.com>
In-Reply-To: <7ba06704-2090-4eb2-9534-c4d467cc085a@arm.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Wed, 20 Mar 2024 22:35:08 +0800
Message-ID: <CAK1f24=yDVwOC31sNMaoZ6K2q1X8vA7p4CtS7nW5WXCm19iEdg@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] mm: madvise: Avoid split during MADV_PAGEOUT and MADV_COLD
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Barry Song <21cnbao@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Chris Li <chrisl@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 9:49=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> Hi Lance, Barry,
>
> Sorry - I totally missed this when you originally sent it!

No worries at all :)

>
>
> On 13/03/2024 14:02, Lance Yang wrote:
> > On Wed, Mar 13, 2024 at 5:03=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.=
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
> >>                 nr =3D folio_pte_batch(folio, addr, pte, ptent, max_nr=
,
> >>                                      fpb_flags, NULL);
> >>
> >> If we are not mapping the first page of the folio, then it can't be a =
full
> >> mapping, so no need to call folio_pte_batch(). Just split it.
> >
> >                  if (folio_test_large(folio)) {
> > [...]
> >                        nr =3D folio_pte_batch(folio, addr, pte, ptent, =
max_nr,
> >                                             fpb_flags, NULL);
> > +                       if (folio_estimated_sharers(folio) > 1)
> > +                               continue;
> >
> > Could we use folio_estimated_sharers as an early exit point here?
>
> I'm not sure what this is saving where you have it? Did you mean to put i=
t
> before folio_pte_batch()? Currently it is just saving a single conditiona=
l.

Apologies for the confusion. I made a diff to provide clarity.

diff --git a/mm/madvise.c b/mm/madvise.c
index 56c7ba7bd558..c3458fdea82a 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -462,12 +462,11 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *p=
md,

                        nr =3D folio_pte_batch(folio, addr, pte, ptent, max=
_nr,
                                             fpb_flags, NULL);
-
// Could we use folio_estimated_sharers as an early exit point here?
+                       if (folio_estimated_sharers(folio) > 1)
+                               continue;
                        if (nr < folio_nr_pages(folio)) {
                                int err;

-                               if (folio_estimated_sharers(folio) > 1)
-                                       continue;
                                if (pageout_anon_only_filter &&
!folio_test_anon(folio))
                                        continue;
                                if (!folio_trylock(folio))

>
> But now that I think about it a bit more, I remember why I was originally
> unconditionally calling folio_pte_batch(). Given its a large folio, if th=
e split
> fails, we can move the cursor to the pte where the next folio begins so w=
e don't
> have to iterate through one pte at a time which would cause us to keep ca=
lling
> folio_estimated_sharers(), folio_test_anon(), etc on the same folio until=
 we get
> to the next boundary.
>
> Of course the common case at this point will be for the split to succeed,=
 but
> then we are going to iterate over ever single PTE anyway - one way or ano=
ther
> they are all fetched into cache. So I feel like its neater not to add the
> conditionals for calling folio_pte_batch(), and just leave this as I have=
 it here.
>
> >
> >                        if (nr < folio_nr_pages(folio)) {
> >                                int err;
> >
> > -                               if (folio_estimated_sharers(folio) > 1)
> > -                                       continue;
> > [...]
> >
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
> >
> > IIRC, some of the architecture(ex, PPC) don't update TLB with set_pte_a=
t and
> > tlb_remove_tlb_entry. So, didn't we consider remapping the PTE with old=
 after
> > pte clearing?
>
> Sorry Lance, I don't understand this question, can you rephrase? Are you =
saying
> there is a good reason to do the original clear-mkold-set for some arches=
?

IIRC, some of the architecture(ex, PPC)  don't update TLB with
ptep_test_and_clear_young()
and tlb_remove_tlb_entry().

In my new patch[1], I use refresh_full_ptes() and
tlb_remove_tlb_entries() to batch-update the
access and dirty bits.

[1] https://lore.kernel.org/linux-mm/20240316102952.39233-1-ioworker0@gmail=
com

Thanks,
Lance

>
> >
> > Thanks,
> > Lance
> >
> >
> >
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
> >>
>

