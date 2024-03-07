Return-Path: <linux-kernel+bounces-95798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D9D8752BA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E962A1C24491
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5BC1EA7C;
	Thu,  7 Mar 2024 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMml1yPC"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED47C12EBCC
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709824132; cv=none; b=uauo/0heFLWIAxtwKSYy4phYBjNeKEM7Bqc7BYDKt7Ek+ewKvi+pMFX3q65co4Run7jgSahqTbAvQhu3LELIABNk+WyG0LuBnXTpymsRQL+IHCg+EHpUWcnqUsN2Nuc6YBM4jCNaEybMBV8Wl16TyZEmoDEWWpcIg+Q1YfKyFPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709824132; c=relaxed/simple;
	bh=rziv5UfgTVd+ykWhjE+E4eB4GSsEHZt8yfR3sT+K/zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uUrLKPJqOWlpqj/9nIfesWw1T2NNPY3KiBEhqmeIT1xG01CrWXzcwC8cHdjViYR7SeapykiGXu9vsQf74rOeCRSEpsNCSgNI1laTU/5xWWhDeeLqHswz2Yh6zT2ghE64KQlszJ7CrvHbzadfkF8tuifDOFDayRDBjokhfNzeQo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMml1yPC; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc74435c428so1003811276.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 07:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709824130; x=1710428930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YlZ1y2d1rN0MdS0vuikv6RYqGjgGQiGTPJJ6x+BlbmU=;
        b=UMml1yPC9iw8wzOvu5YiKHiDC0MFX21gwRjPeTrybARmAog487rAh03KLDNiJ9rvyn
         QNkkrzzh89kh/EoX0Kev1ryTy5old1hmyhnkX9GphB6gyQcxNqOLQAjEPJ3oE8+TrlIX
         0KebUIKf+OBdsUlme7sUQv/5Fw7zZEQtPJwRYNtEjGO+GhouHcxAG8fs0Mt/JD6C3FOV
         Kz5vc2WWxJULfz1iq4eFn2l1LZkWGrtN+Ud2PRaVjaB9AJ8mZNY2bKy+NAi9GV0pfxeA
         KOuUGbeqeCw63sxrkhad4nkL8CzxTfZDn7EygixDQZhT1OftNtRCkkN1fxzTZ4OQ3Euu
         Aj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709824130; x=1710428930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YlZ1y2d1rN0MdS0vuikv6RYqGjgGQiGTPJJ6x+BlbmU=;
        b=pV61b/5lYrlZg+Urw/j7tUJXpHG1lu9bi1XyBnTGaGyUZA8AhEpr/fvd+I7K+1ghC/
         k/4lksXkHQI9+PGyKXcJUwPkIWbNkfivV55tkbcuY7Ze9myeYqvSI5nC9irfBt3pkGqt
         hC9P71qZtUqD9i8fedWBfORaov435Zd8D3+He52iNZZoO2BiC4D7NIGnQ0ay8eXXxFvJ
         KlKiXVOC6Q1EyEK9qUrKedudXVjcuWmI17i4j8tw8wiNcPl13+tsyJnlwHrFdGVoTFsp
         Blq1wEoXtuyMKpvBx6I8sOsY95yiatcAKyRcozULqVtz0kjH3zzOa4n2NTwV6zGNkNAm
         e+sA==
X-Forwarded-Encrypted: i=1; AJvYcCU2UrXiJEGo4YWmHLG85P93lGVgTba0aKCmZ/Jrm2/zz0FLzIaR2SOhBgiJN4s+o3XyyaWVpvfbUPg1Z5Gof2hMyYhPGvi367iADLAt
X-Gm-Message-State: AOJu0YyRmUACiUycXP/K1ScAlnwNccPW7QcS0RpY7m/XSBS58svKEn7I
	Hf9RWWRjCmSLkFZ8YXUp5RaVXk9J7isrdrSJCgKRB0tMGQttAyaUJ86ob9xJs2rGkQPmBf0t9bd
	OnWs3s4XTcC/tOOPd/u2dFX5Xz5c=
X-Google-Smtp-Source: AGHT+IGDkLYfB32LpSCJw78OUjDKJrTPH3GKXcBt7MQVQHNUYkR1SiDLPQoaBx1AD5y09CFZJtxmPq0Op8GQTCRk0BY=
X-Received: by 2002:a25:cd42:0:b0:dcc:1c6c:430d with SMTP id
 d63-20020a25cd42000000b00dcc1c6c430dmr13738605ybf.12.1709824129467; Thu, 07
 Mar 2024 07:08:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307061425.21013-1-ioworker0@gmail.com> <CAGsJ_4xcRvZGdpPh1qcFTnTnDUbwz6WreQ=L_UO+oU2iFm9EPg@mail.gmail.com>
 <CAK1f24k2G_DSEjuqqqPyY0f7+btpYbjfoyMH7btLfP8nkasCTQ@mail.gmail.com>
 <CAGsJ_4xREM-P1mFqeM-s3-cJ9czb6PXwizb-3hOhwaF6+QM5QA@mail.gmail.com>
 <03458c20-5544-411b-9b8d-b4600a9b802f@arm.com> <CAGsJ_4zp1MXTjG=4gBO+J3owg7sHDgDJ8Ut51i1RBSnKnK0BfQ@mail.gmail.com>
 <501c9f77-1459-467a-8619-78e86b46d300@arm.com> <8f84c7d6-982a-4933-a7a7-3f640df64991@redhat.com>
 <e6bc142e-113d-4034-b92c-746b951a27ed@redhat.com> <d24f8553-33f2-4ae7-a06d-badaf9462d84@arm.com>
 <db46212b-000d-4e8e-87d2-90dbf0a6236a@redhat.com> <CAK1f24k8MgR-3sqpqZmg=aTF5Sh4if2o7qeW9zfGpGCSbHR2PA@mail.gmail.com>
 <63801377-2648-4c3b-b534-3cc5835f5cf6@redhat.com>
In-Reply-To: <63801377-2648-4c3b-b534-3cc5835f5cf6@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 7 Mar 2024 23:08:37 +0800
Message-ID: <CAK1f24nn1Ypxi2vxOzHEje=YG71=REd-QXqxA51pJ+dSqqcwQg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>, 
	Vishal Moola <vishal.moola@gmail.com>, akpm@linux-foundation.org, zokeefe@google.com, 
	shy828301@gmail.com, mhocko@suse.com, fengwei.yin@intel.com, 
	xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com, 
	peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks a lot, David!

Got it. I'll do my best.

Thanks,
Lance

On Thu, Mar 7, 2024 at 10:58=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 07.03.24 15:41, Lance Yang wrote:
> > Hey Barry, Ryan, David,
> >
> > Thanks a lot for taking the time to explain and provide suggestions!
> > I really appreciate your time!
> >
> > IIUC, here's what we need to do for v3:
> >
> > If folio_likely_mapped_shared() is true, or if we cannot acquire
> > the folio lock, we simply skip the batched PTEs. Then, we compare
> > the number of batched PTEs against folio_mapcount(). Finally,
> > batch-update the access and dirty only.
> >
> > I'm not sure if I've understood correctly, could you please confirm?
> >
> > Thanks,
> > Lance
> >
> > On Thu, Mar 7, 2024 at 7:17=E2=80=AFPM David Hildenbrand <david@redhat.=
com> wrote:
> >>
> >> On 07.03.24 12:13, Ryan Roberts wrote:
> >>> On 07/03/2024 10:54, David Hildenbrand wrote:
> >>>> On 07.03.24 11:54, David Hildenbrand wrote:
> >>>>> On 07.03.24 11:50, Ryan Roberts wrote:
> >>>>>> On 07/03/2024 09:33, Barry Song wrote:
> >>>>>>> On Thu, Mar 7, 2024 at 10:07=E2=80=AFPM Ryan Roberts <ryan.robert=
s@arm.com> wrote:
> >>>>>>>>
> >>>>>>>> On 07/03/2024 08:10, Barry Song wrote:
> >>>>>>>>> On Thu, Mar 7, 2024 at 9:00=E2=80=AFPM Lance Yang <ioworker0@gm=
ail.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>> Hey Barry,
> >>>>>>>>>>
> >>>>>>>>>> Thanks for taking time to review!
> >>>>>>>>>>
> >>>>>>>>>> On Thu, Mar 7, 2024 at 3:00=E2=80=AFPM Barry Song <21cnbao@gma=
il.com> wrote:
> >>>>>>>>>>>
> >>>>>>>>>>> On Thu, Mar 7, 2024 at 7:15=E2=80=AFPM Lance Yang <ioworker0@=
gmail.com> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>> [...]
> >>>>>>>>>>>> +static inline bool can_mark_large_folio_lazyfree(unsigned l=
ong addr,
> >>>>>>>>>>>> +                                                struct foli=
o *folio,
> >>>>>>>>>>>> pte_t *start_pte)
> >>>>>>>>>>>> +{
> >>>>>>>>>>>> +       int nr_pages =3D folio_nr_pages(folio);
> >>>>>>>>>>>> +       fpb_t flags =3D FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_D=
IRTY;
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +       for (int i =3D 0; i < nr_pages; i++)
> >>>>>>>>>>>> +               if (page_mapcount(folio_page(folio, i)) !=3D=
 1)
> >>>>>>>>>>>> +                       return false;
> >>>>>>>>>>>
> >>>>>>>>>>> we have moved to folio_estimated_sharers though it is not pre=
cise, so
> >>>>>>>>>>> we don't do
> >>>>>>>>>>> this check with lots of loops and depending on the subpage's =
mapcount.
> >>>>>>>>>>
> >>>>>>>>>> If we don't check the subpage=E2=80=99s mapcount, and there is=
 a cow folio
> >>>>>>>>>> associated
> >>>>>>>>>> with this folio and the cow folio has smaller size than this f=
olio,
> >>>>>>>>>> should we still
> >>>>>>>>>> mark this folio as lazyfree?
> >>>>>>>>>
> >>>>>>>>> I agree, this is true. However, we've somehow accepted the fact=
 that
> >>>>>>>>> folio_likely_mapped_shared
> >>>>>>>>> can result in false negatives or false positives to balance the
> >>>>>>>>> overhead.  So I really don't know :-)
> >>>>>>>>>
> >>>>>>>>> Maybe David and Vishal can give some comments here.
> >>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>> BTW, do we need to rebase our work against David's changes[1]=
?
> >>>>>>>>>>> [1]
> >>>>>>>>>>> https://lore.kernel.org/linux-mm/20240227201548.857831-1-davi=
d@redhat.com/
> >>>>>>>>>>
> >>>>>>>>>> Yes, we should rebase our work against David=E2=80=99s changes=
.
> >>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +       return nr_pages =3D=3D folio_pte_batch(folio, addr, =
start_pte,
> >>>>>>>>>>>> +                                        ptep_get(start_pte)=
, nr_pages,
> >>>>>>>>>>>> flags, NULL);
> >>>>>>>>>>>> +}
> >>>>>>>>>>>> +
> >>>>>>>>>>>>      static int madvise_free_pte_range(pmd_t *pmd, unsigned =
long addr,
> >>>>>>>>>>>>                                     unsigned long end, struc=
t mm_walk *walk)
> >>>>>>>>>>>>
> >>>>>>>>>>>> @@ -676,11 +690,45 @@ static int madvise_free_pte_range(pmd_=
t *pmd,
> >>>>>>>>>>>> unsigned long addr,
> >>>>>>>>>>>>                      */
> >>>>>>>>>>>>                     if (folio_test_large(folio)) {
> >>>>>>>>>>>>                             int err;
> >>>>>>>>>>>> +                       unsigned long next_addr, align;
> >>>>>>>>>>>>
> >>>>>>>>>>>> -                       if (folio_estimated_sharers(folio) !=
=3D 1)
> >>>>>>>>>>>> -                               break;
> >>>>>>>>>>>> -                       if (!folio_trylock(folio))
> >>>>>>>>>>>> -                               break;
> >>>>>>>>>>>> +                       if (folio_estimated_sharers(folio) !=
=3D 1 ||
> >>>>>>>>>>>> +                           !folio_trylock(folio))
> >>>>>>>>>>>> +                               goto skip_large_folio;
> >>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> I don't think we can skip all the PTEs for nr_pages, as some =
of them
> >>>>>>>>>>> might be
> >>>>>>>>>>> pointing to other folios.
> >>>>>>>>>>>
> >>>>>>>>>>> for example, for a large folio with 16PTEs, you do MADV_DONTN=
EED(15-16),
> >>>>>>>>>>> and write the memory of PTE15 and PTE16, you get page faults,=
 thus PTE15
> >>>>>>>>>>> and PTE16 will point to two different small folios. We can on=
ly skip
> >>>>>>>>>>> when we
> >>>>>>>>>>> are sure nr_pages =3D=3D folio_pte_batch() is sure.
> >>>>>>>>>>
> >>>>>>>>>> Agreed. Thanks for pointing that out.
> >>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +                       align =3D folio_nr_pages(folio) * PA=
GE_SIZE;
> >>>>>>>>>>>> +                       next_addr =3D ALIGN_DOWN(addr + alig=
n, align);
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +                       /*
> >>>>>>>>>>>> +                        * If we mark only the subpages as l=
azyfree, or
> >>>>>>>>>>>> +                        * cannot mark the entire large foli=
o as lazyfree,
> >>>>>>>>>>>> +                        * then just split it.
> >>>>>>>>>>>> +                        */
> >>>>>>>>>>>> +                       if (next_addr > end || next_addr - a=
ddr !=3D
> >>>>>>>>>>>> align ||
> >>>>>>>>>>>> +                           !can_mark_large_folio_lazyfree(a=
ddr, folio,
> >>>>>>>>>>>> pte))
> >>>>>>>>>>>> +                               goto split_large_folio;
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +                       /*
> >>>>>>>>>>>> +                        * Avoid unnecessary folio splitting=
 if the large
> >>>>>>>>>>>> +                        * folio is entirely within the give=
n range.
> >>>>>>>>>>>> +                        */
> >>>>>>>>>>>> +                       folio_clear_dirty(folio);
> >>>>>>>>>>>> +                       folio_unlock(folio);
> >>>>>>>>>>>> +                       for (; addr !=3D next_addr; pte++, a=
ddr +=3D
> >>>>>>>>>>>> PAGE_SIZE) {
> >>>>>>>>>>>> +                               ptent =3D ptep_get(pte);
> >>>>>>>>>>>> +                               if (pte_young(ptent) ||
> >>>>>>>>>>>> pte_dirty(ptent)) {
> >>>>>>>>>>>> +                                       ptent =3D ptep_get_a=
nd_clear_full(
> >>>>>>>>>>>> +                                               mm, addr, pt=
e,
> >>>>>>>>>>>> tlb->fullmm);
> >>>>>>>>>>>> +                                       ptent =3D pte_mkold(=
ptent);
> >>>>>>>>>>>> +                                       ptent =3D pte_mkclea=
n(ptent);
> >>>>>>>>>>>> +                                       set_pte_at(mm, addr,=
 pte, ptent);
> >>>>>>>>>>>> +                                       tlb_remove_tlb_entry=
(tlb, pte,
> >>>>>>>>>>>> addr);
> >>>>>>>>>>>> +                               }
> >>>>>>>>>>>
> >>>>>>>>>>> Can we do this in batches? for a CONT-PTE mapped large folio,=
 you are
> >>>>>>>>>>> unfolding
> >>>>>>>>>>> and folding again. It seems quite expensive.
> >>>>>>>>
> >>>>>>>> I'm not convinced we should be doing this in batches. We want th=
e initial
> >>>>>>>> folio_pte_batch() to be as loose as possible regarding permissio=
ns so that we
> >>>>>>>> reduce our chances of splitting folios to the min. (e.g. ignore =
SW bits like
> >>>>>>>> soft dirty, etc). I think it might be possible that some PTEs ar=
e RO and other
> >>>>>>>> RW too (e.g. due to cow - although with the current cow impl, pr=
obably not.
> >>>>>>>> But
> >>>>>>>> its fragile to assume that). Anyway, if we do an initial batch t=
hat ignores
> >>>>>>>> all
> >>>>>>>
> >>>>>>> You are correct. I believe this scenario could indeed occur. For =
instance,
> >>>>>>> if process A forks process B and then unmaps itself, leaving B as=
 the
> >>>>>>> sole process owning the large folio.  The current wp_page_reuse()=
 function
> >>>>>>> will reuse PTE one by one while the specific subpage is written.
> >>>>>>
> >>>>>> Hmm - I thought it would only reuse if the total mapcount for the =
folio was 1.
> >>>>>> And since it is a large folio with each page mapped once in proc B=
, I thought
> >>>>>> every subpage write would cause a copy except the last one? I have=
n't looked at
> >>>>>> the code for a while. But I had it in my head that this is an area=
 we need to
> >>>>>> improve for mTHP.
> >>>>>
> >>>>> wp_page_reuse() will currently reuse a PTE part of a large folio on=
ly if
> >>>>> a single PTE remains mapped (refcount =3D=3D 0).
> >>>>
> >>>> ^ =3D=3D 1
> >>>
> >>> Ahh yes. That's what I meant. I got the behacviour vagulely right tho=
ugh.
> >>>
> >>> Anyway, regardless, I'm not sure we want to batch here. Or if we do, =
we want to
> >>> batch function that will only clear access and dirty.
> >>
> >> We likely want to detect a folio batch the "usual" way (as relaxed as
> >> possible), then do all the checks (#pte =3D=3D folio_mapcount() under =
folio
> >> lock), and finally batch-update the access and dirty only.
>
> Something like:
>
> 1) We might want to factor out the existing single-pte case and extend
> it to handle multiple PTEs (nr_pages). For the existing code, we would
> pass in "nr_pages".
>
> For example, instead of "folio_mapcount(folio) !=3D 1" you'd check
> "folio_mapcount(folio) !=3D nr_pages" in there. And we'd need functions t=
o
> abstract working on multiple ptes.
>
> 2) We'd add something like wrprotect_ptes(), that does the mkold+clean
> on multiple PTEs.
>
> Naming suggestion for such a function requested :)
>
> 3) Then, we might want to extend folio_pte_batch() by an *any_young and
> *any_dirty parameter that will get optimized out for other users. So you
> get that information right when scanning.
>
>
> Just a rough idea, devil is in the detail. But likely trying to abstrct
> the code to handle "multiple pages of the same folio" should come just
> naturally like we used to do for fork() and munmap() so far.
>
> --
> Cheers,
>
> David / dhildenb
>

