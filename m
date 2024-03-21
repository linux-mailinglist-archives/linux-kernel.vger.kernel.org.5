Return-Path: <linux-kernel+bounces-109542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A99F881AAE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6FD3B212C6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1D61877;
	Thu, 21 Mar 2024 01:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFis4wfp"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4014A1D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 01:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710985139; cv=none; b=XvqK9Eenmus3SwFKwmAcACoJUdeQGLE2tCaADT3RaSRlQABLaOhGWnt8dSgICHvdTK/MAmHnE8Qz+PnooMcWVkZnUQOdBk6+vZ9Be3l8otfm0OKbe52h71nMIHCqihgJgLn6OKWrJdKnHqdn+32dYm62U2YiHzBMyVXZLk4vmOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710985139; c=relaxed/simple;
	bh=yRzL2Lj2+b5pTFlTcQ8rgkCMVIAJOxL7fzvVeILFPpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ksh9YWnMWhe+ISzZIKZEhfwpZgn+m8Iu82pzoU8LLtB8CpCS/XSgQMra4APBrdI2voORvZTUc4iCxCcOQKVclLChqwwXOrOSUmSt/rxceBmQCE+gj45vP1gJly46+LVB4mCnK5mDQaup+mD15OV8ySp2lDHBInDpxNUIKLrJat8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFis4wfp; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc6cbe1ac75so393757276.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710985136; x=1711589936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PbxvN/eptl8J7guLXsZRG6QV4UBWnSMiGDtR2pNZ6ks=;
        b=JFis4wfpS5kwMJ1kNgeTVw6Jj93M/mxiaaWyF/4sxIrfQhDgNEHk3u+xkkNVW2/mS9
         qWHqlgAV+an8vyFWVYUj5sKnuu4f5JlQa817dvHSQhRCUY0RI5aHUS8J03cyh+P+cKIF
         GEA4NNajOghgzPtzaz8PfJmKQvYYQtcr6ormZaxtKDAj1/Xqd0iYi0lxO1UfMe+9Z+Yb
         zHtGTBOQz4hCZqo3vsxi3Rmd9jNpXi3nilyBK33DrwnHtxGuCtbjTu/rddzfk9dBomrv
         iH5g+nfp4qyffE4Se1L3aZjsSLbZE/o+54e1DDnf5uGYgARN7ErjgC/MNGMz5Dm3CAlj
         s3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710985136; x=1711589936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PbxvN/eptl8J7guLXsZRG6QV4UBWnSMiGDtR2pNZ6ks=;
        b=iLOm/ObcFHPlGjbboELyRgoY6OC3TBGeEXlF3AYsSQCONrwNNblEbaKAR6cOq1PX0g
         Cfl/4o3TSOHA7XGcAtOVikjWFr1RIxSCeCRd/+9KI5QN6kV3BdVXY3Cj+FclWgMsIw5l
         COFR4e9h/tyZSij4wqqyLCKX0ZTYU3O4HLTrhahdHlLdufCzhjQecTHNpDY97WsB/tbO
         6+9uTXA4MeVyVPDax9b/y+T2zUMLpLdRVEouOyTNeUz9wfASGYa21kIafGAaO7u49kUb
         pn3/duDV/dBWvAXmcUasFrWDcHSKQ+pyUtggqE+o157F7IhpXp3UMA4ek0SixiWOtZhc
         MkTw==
X-Forwarded-Encrypted: i=1; AJvYcCUdjm81Gg3rJ2NKsJAqXYpGlzyMQas9InHSP6ifvfoN071NPBsZ492Gw4JZRnNP/ovEzVIrMXHTBLTiQSTxtFdy7IHuLInWXVF2tgWD
X-Gm-Message-State: AOJu0YyKpUS2cYQp6ZRq97s2RswTU/PO33ygrrN+bYz4IPIZX7/B7AKj
	nruPrzBtZrBGblxumUAJzs5+ITwMzn8J07whr3v/Z0VEhns0NP5OZbE9NNRgHwv4njzNOYzKKi8
	GhqvYc1ywj/8Z2wmtwUJCRjLrvzE=
X-Google-Smtp-Source: AGHT+IF6JC7sHUsGz6eFmseFmwmTXyU02gOD/gXBx8x0uSObFTkB8UHCs+PFgXMlb/gUFVBUysAm0hXu6i46/zbbdxs=
X-Received: by 2002:a25:9f07:0:b0:dc7:4645:83ab with SMTP id
 n7-20020a259f07000000b00dc7464583abmr989665ybq.0.1710985136089; Wed, 20 Mar
 2024 18:38:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
 <20240311150058.1122862-7-ryan.roberts@arm.com> <CAGsJ_4wpjqRsn7ouO=Ut9oMBLSh803=XuSPX6gJ5nQ3jyqh3hQ@mail.gmail.com>
 <a75ec640-d025-45ee-b74d-305aaa3cc1ce@arm.com> <CAK1f24k1AuHDdrLFNLvwdoOy=xJTVkVdfY4+SN+KW5-EiMSa9Q@mail.gmail.com>
 <7ba06704-2090-4eb2-9534-c4d467cc085a@arm.com> <CAK1f24=yDVwOC31sNMaoZ6K2q1X8vA7p4CtS7nW5WXCm19iEdg@mail.gmail.com>
 <add3b9fc-f08a-4bd4-b01e-4409e81d5a2d@arm.com>
In-Reply-To: <add3b9fc-f08a-4bd4-b01e-4409e81d5a2d@arm.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 21 Mar 2024 09:38:44 +0800
Message-ID: <CAK1f24kRXZtKckRFxJfQCNSHJOHy4_nv67T+BfWeWyVtEggdNQ@mail.gmail.com>
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

On Thu, Mar 21, 2024 at 1:38=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 20/03/2024 14:35, Lance Yang wrote:
> > On Wed, Mar 20, 2024 at 9:49=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>
> >> Hi Lance, Barry,
> >>
> >> Sorry - I totally missed this when you originally sent it!
> >
> > No worries at all :)
> >
> >>
> >>
> >> On 13/03/2024 14:02, Lance Yang wrote:
> >>> On Wed, Mar 13, 2024 at 5:03=E2=80=AFPM Ryan Roberts <ryan.roberts@ar=
m.com> wrote:
> >>>>
> >>>> On 13/03/2024 07:19, Barry Song wrote:
> >>>>> On Tue, Mar 12, 2024 at 4:01=E2=80=AFAM Ryan Roberts <ryan.roberts@=
arm.com> wrote:
> >>>>>>
> >>>>>> Rework madvise_cold_or_pageout_pte_range() to avoid splitting any =
large
> >>>>>> folio that is fully and contiguously mapped in the pageout/cold vm
> >>>>>> range. This change means that large folios will be maintained all =
the
> >>>>>> way to swap storage. This both improves performance during swap-ou=
t, by
> >>>>>> eliding the cost of splitting the folio, and sets us up nicely for
> >>>>>> maintaining the large folio when it is swapped back in (to be cove=
red in
> >>>>>> a separate series).
> >>>>>>
> >>>>>> Folios that are not fully mapped in the target range are still spl=
it,
> >>>>>> but note that behavior is changed so that if the split fails for a=
ny
> >>>>>> reason (folio locked, shared, etc) we now leave it as is and move =
to the
> >>>>>> next pte in the range and continue work on the proceeding folios.
> >>>>>> Previously any failure of this sort would cause the entire operati=
on to
> >>>>>> give up and no folios mapped at higher addresses were paged out or=
 made
> >>>>>> cold. Given large folios are becoming more common, this old behavi=
or
> >>>>>> would have likely lead to wasted opportunities.
> >>>>>>
> >>>>>> While we are at it, change the code that clears young from the pte=
s to
> >>>>>> use ptep_test_and_clear_young(), which is more efficent than
> >>>>>> get_and_clear/modify/set, especially for contpte mappings on arm64=
,
> >>>>>> where the old approach would require unfolding/refolding and the n=
ew
> >>>>>> approach can be done in place.
> >>>>>>
> >>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >>>>>
> >>>>> This looks so much better than our initial RFC.
> >>>>> Thank you for your excellent work!
> >>>>
> >>>> Thanks - its a team effort - I had your PoC and David's previous bat=
ching work
> >>>> to use as a template.
> >>>>
> >>>>>
> >>>>>> ---
> >>>>>>  mm/madvise.c | 89 ++++++++++++++++++++++++++++++-----------------=
-----
> >>>>>>  1 file changed, 51 insertions(+), 38 deletions(-)
> >>>>>>
> >>>>>> diff --git a/mm/madvise.c b/mm/madvise.c
> >>>>>> index 547dcd1f7a39..56c7ba7bd558 100644
> >>>>>> --- a/mm/madvise.c
> >>>>>> +++ b/mm/madvise.c
> >>>>>> @@ -336,6 +336,7 @@ static int madvise_cold_or_pageout_pte_range(p=
md_t *pmd,
> >>>>>>         LIST_HEAD(folio_list);
> >>>>>>         bool pageout_anon_only_filter;
> >>>>>>         unsigned int batch_count =3D 0;
> >>>>>> +       int nr;
> >>>>>>
> >>>>>>         if (fatal_signal_pending(current))
> >>>>>>                 return -EINTR;
> >>>>>> @@ -423,7 +424,8 @@ static int madvise_cold_or_pageout_pte_range(p=
md_t *pmd,
> >>>>>>                 return 0;
> >>>>>>         flush_tlb_batched_pending(mm);
> >>>>>>         arch_enter_lazy_mmu_mode();
> >>>>>> -       for (; addr < end; pte++, addr +=3D PAGE_SIZE) {
> >>>>>> +       for (; addr < end; pte +=3D nr, addr +=3D nr * PAGE_SIZE) =
{
> >>>>>> +               nr =3D 1;
> >>>>>>                 ptent =3D ptep_get(pte);
> >>>>>>
> >>>>>>                 if (++batch_count =3D=3D SWAP_CLUSTER_MAX) {
> >>>>>> @@ -447,55 +449,66 @@ static int madvise_cold_or_pageout_pte_range=
(pmd_t *pmd,
> >>>>>>                         continue;
> >>>>>>
> >>>>>>                 /*
> >>>>>> -                * Creating a THP page is expensive so split it on=
ly if we
> >>>>>> -                * are sure it's worth. Split it if we are only ow=
ner.
> >>>>>> +                * If we encounter a large folio, only split it if=
 it is not
> >>>>>> +                * fully mapped within the range we are operating =
on. Otherwise
> >>>>>> +                * leave it as is so that it can be swapped out wh=
ole. If we
> >>>>>> +                * fail to split a folio, leave it in place and ad=
vance to the
> >>>>>> +                * next pte in the range.
> >>>>>>                  */
> >>>>>>                 if (folio_test_large(folio)) {
> >>>>>> -                       int err;
> >>>>>> -
> >>>>>> -                       if (folio_estimated_sharers(folio) > 1)
> >>>>>> -                               break;
> >>>>>> -                       if (pageout_anon_only_filter && !folio_tes=
t_anon(folio))
> >>>>>> -                               break;
> >>>>>> -                       if (!folio_trylock(folio))
> >>>>>> -                               break;
> >>>>>> -                       folio_get(folio);
> >>>>>> -                       arch_leave_lazy_mmu_mode();
> >>>>>> -                       pte_unmap_unlock(start_pte, ptl);
> >>>>>> -                       start_pte =3D NULL;
> >>>>>> -                       err =3D split_folio(folio);
> >>>>>> -                       folio_unlock(folio);
> >>>>>> -                       folio_put(folio);
> >>>>>> -                       if (err)
> >>>>>> -                               break;
> >>>>>> -                       start_pte =3D pte =3D
> >>>>>> -                               pte_offset_map_lock(mm, pmd, addr,=
 &ptl);
> >>>>>> -                       if (!start_pte)
> >>>>>> -                               break;
> >>>>>> -                       arch_enter_lazy_mmu_mode();
> >>>>>> -                       pte--;
> >>>>>> -                       addr -=3D PAGE_SIZE;
> >>>>>> -                       continue;
> >>>>>> +                       const fpb_t fpb_flags =3D FPB_IGNORE_DIRTY=
 |
> >>>>>> +                                               FPB_IGNORE_SOFT_DI=
RTY;
> >>>>>> +                       int max_nr =3D (end - addr) / PAGE_SIZE;
> >>>>>> +
> >>>>>> +                       nr =3D folio_pte_batch(folio, addr, pte, p=
tent, max_nr,
> >>>>>> +                                            fpb_flags, NULL);
> >>>>>
> >>>>> I wonder if we have a quick way to avoid folio_pte_batch() if users
> >>>>> are doing madvise() on a portion of a large folio.
> >>>>
> >>>> Good idea. Something like this?:
> >>>>
> >>>>         if (pte_pfn(pte) =3D=3D folio_pfn(folio)
> >>>>                 nr =3D folio_pte_batch(folio, addr, pte, ptent, max_=
nr,
> >>>>                                      fpb_flags, NULL);
> >>>>
> >>>> If we are not mapping the first page of the folio, then it can't be =
a full
> >>>> mapping, so no need to call folio_pte_batch(). Just split it.
> >>>
> >>>                  if (folio_test_large(folio)) {
> >>> [...]
> >>>                        nr =3D folio_pte_batch(folio, addr, pte, ptent=
, max_nr,
> >>>                                             fpb_flags, NULL);
> >>> +                       if (folio_estimated_sharers(folio) > 1)
> >>> +                               continue;
> >>>
> >>> Could we use folio_estimated_sharers as an early exit point here?
> >>
> >> I'm not sure what this is saving where you have it? Did you mean to pu=
t it
> >> before folio_pte_batch()? Currently it is just saving a single conditi=
onal.
> >
> > Apologies for the confusion. I made a diff to provide clarity.
> >
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 56c7ba7bd558..c3458fdea82a 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -462,12 +462,11 @@ static int madvise_cold_or_pageout_pte_range(pmd_=
t *pmd,
> >
> >                         nr =3D folio_pte_batch(folio, addr, pte, ptent,=
 max_nr,
> >                                              fpb_flags, NULL);
> > -
> > // Could we use folio_estimated_sharers as an early exit point here?
> > +                       if (folio_estimated_sharers(folio) > 1)
> > +                               continue;
> >                         if (nr < folio_nr_pages(folio)) {
> >                                 int err;
> >
> > -                               if (folio_estimated_sharers(folio) > 1)
> > -                                       continue;
> >                                 if (pageout_anon_only_filter &&
> > !folio_test_anon(folio))
> >                                         continue;
> >                                 if (!folio_trylock(folio))
>
>
> I'm still not really getting it; with my code, if nr < the folio size, we=
 will
> try to split and if we estimate that the folio is not exclusive we will a=
void
> locking the folio, etc. If nr =3D=3D folio size, we will proceed to the p=
recise
> exclusivity check (which is cheap once we know the folio is fully mapped =
by this
> process).
>
> With your change, we will always do the estimated exclusive check then pr=
oceed
> to the precise check; seems like duplication to me?

Agreed. The estimated exclusive check is indeed redundant with my change.

>
> >
> >>
> >> But now that I think about it a bit more, I remember why I was origina=
lly
> >> unconditionally calling folio_pte_batch(). Given its a large folio, if=
 the split
> >> fails, we can move the cursor to the pte where the next folio begins s=
o we don't
> >> have to iterate through one pte at a time which would cause us to keep=
 calling
> >> folio_estimated_sharers(), folio_test_anon(), etc on the same folio un=
til we get
> >> to the next boundary.
> >>
> >> Of course the common case at this point will be for the split to succe=
ed, but
> >> then we are going to iterate over ever single PTE anyway - one way or =
another
> >> they are all fetched into cache. So I feel like its neater not to add =
the
> >> conditionals for calling folio_pte_batch(), and just leave this as I h=
ave it here.
> >>
> >>>
> >>>                        if (nr < folio_nr_pages(folio)) {
> >>>                                int err;
> >>>
> >>> -                               if (folio_estimated_sharers(folio) > =
1)
> >>> -                                       continue;
> >>> [...]
> >>>
> >>>>
> >>>>>
> >>>>>> +
> >>>>>> +                       if (nr < folio_nr_pages(folio)) {
> >>>>>> +                               int err;
> >>>>>> +
> >>>>>> +                               if (folio_estimated_sharers(folio)=
 > 1)
> >>>>>> +                                       continue;
> >>>>>> +                               if (pageout_anon_only_filter && !f=
olio_test_anon(folio))
> >>>>>> +                                       continue;
> >>>>>> +                               if (!folio_trylock(folio))
> >>>>>> +                                       continue;
> >>>>>> +                               folio_get(folio);
> >>>>>> +                               arch_leave_lazy_mmu_mode();
> >>>>>> +                               pte_unmap_unlock(start_pte, ptl);
> >>>>>> +                               start_pte =3D NULL;
> >>>>>> +                               err =3D split_folio(folio);
> >>>>>> +                               folio_unlock(folio);
> >>>>>> +                               folio_put(folio);
> >>>>>> +                               if (err)
> >>>>>> +                                       continue;
> >>>>>> +                               start_pte =3D pte =3D
> >>>>>> +                                       pte_offset_map_lock(mm, pm=
d, addr, &ptl);
> >>>>>> +                               if (!start_pte)
> >>>>>> +                                       break;
> >>>>>> +                               arch_enter_lazy_mmu_mode();
> >>>>>> +                               nr =3D 0;
> >>>>>> +                               continue;
> >>>>>> +                       }
> >>>>>>                 }
> >>>>>>
> >>>>>>                 /*
> >>>>>>                  * Do not interfere with other mappings of this fo=
lio and
> >>>>>> -                * non-LRU folio.
> >>>>>> +                * non-LRU folio. If we have a large folio at this=
 point, we
> >>>>>> +                * know it is fully mapped so if its mapcount is t=
he same as its
> >>>>>> +                * number of pages, it must be exclusive.
> >>>>>>                  */
> >>>>>> -               if (!folio_test_lru(folio) || folio_mapcount(folio=
) !=3D 1)
> >>>>>> +               if (!folio_test_lru(folio) ||
> >>>>>> +                   folio_mapcount(folio) !=3D folio_nr_pages(foli=
o))
> >>>>>>                         continue;
> >>>>>
> >>>>> This looks so perfect and is exactly what I wanted to achieve.
> >>>>>
> >>>>>>
> >>>>>>                 if (pageout_anon_only_filter && !folio_test_anon(f=
olio))
> >>>>>>                         continue;
> >>>>>>
> >>>>>> -               VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
> >>>>>> -
> >>>>>> -               if (!pageout && pte_young(ptent)) {
> >>>>>> -                       ptent =3D ptep_get_and_clear_full(mm, addr=
, pte,
> >>>>>> -                                                       tlb->fullm=
m);
> >>>>>> -                       ptent =3D pte_mkold(ptent);
> >>>>>> -                       set_pte_at(mm, addr, pte, ptent);
> >>>>>> -                       tlb_remove_tlb_entry(tlb, pte, addr);
> >>>>>> +               if (!pageout) {
> >>>>>> +                       for (; nr !=3D 0; nr--, pte++, addr +=3D P=
AGE_SIZE) {
> >>>>>> +                               if (ptep_test_and_clear_young(vma,=
 addr, pte))
> >>>>>> +                                       tlb_remove_tlb_entry(tlb, =
pte, addr);
> >>>
> >>> IIRC, some of the architecture(ex, PPC) don't update TLB with set_pte=
_at and
> >>> tlb_remove_tlb_entry. So, didn't we consider remapping the PTE with o=
ld after
> >>> pte clearing?
> >>
> >> Sorry Lance, I don't understand this question, can you rephrase? Are y=
ou saying
> >> there is a good reason to do the original clear-mkold-set for some arc=
hes?
> >
> > IIRC, some of the architecture(ex, PPC)  don't update TLB with
> > ptep_test_and_clear_young()
> > and tlb_remove_tlb_entry().
>
> Err, I assumed tlb_remove_tlb_entry() meant "invalidate the TLB entry for=
 this
> address please" - albeit its deferred and batched. I'll look into this.
>
> >
> > In my new patch[1], I use refresh_full_ptes() and
> > tlb_remove_tlb_entries() to batch-update the
> > access and dirty bits.
>
> I want to avoid the per-pte clear-modify-set approach, because this doesn=
't
> perform well on arm64 when using contpte mappings; it will cause the cont=
pe
> mapping to be unfolded by the first clear that touches the contpte block,=
 then
> refolded by the last set to touch the block. That's expensive.
> ptep_test_and_clear_young() doesn't suffer that problem.

Thanks for explaining. I got it.

I think that other architectures will benefit from the per-pte clear-modify=
-set
approach. IMO, refresh_full_ptes() can be overridden by arm64.

Thanks,
Lance
>
> >
> > [1] https://lore.kernel.org/linux-mm/20240316102952.39233-1-ioworker0@g=
mail.com
> >
> > Thanks,
> > Lance
> >
> >>
> >>>
> >>> Thanks,
> >>> Lance
> >>>
> >>>
> >>>
> >>>>>> +                       }
> >>>>>
> >>>>> This looks so smart. if it is not pageout, we have increased pte
> >>>>> and addr here; so nr is 0 and we don't need to increase again in
> >>>>> for (; addr < end; pte +=3D nr, addr +=3D nr * PAGE_SIZE)
> >>>>>
> >>>>> otherwise, nr won't be 0. so we will increase addr and
> >>>>> pte by nr.
> >>>>
> >>>> Indeed. I'm hoping that Lance is able to follow a similar pattern fo=
r
> >>>> madvise_free_pte_range().
> >>>>
> >>>>
> >>>>>
> >>>>>
> >>>>>>                 }
> >>>>>>
> >>>>>>                 /*
> >>>>>> --
> >>>>>> 2.25.1
> >>>>>>
> >>>>>
> >>>>> Overall, LGTM,
> >>>>>
> >>>>> Reviewed-by: Barry Song <v-songbaohua@oppo.com>
> >>>>
> >>>> Thanks!
> >>>>
> >>>>
> >>
>

