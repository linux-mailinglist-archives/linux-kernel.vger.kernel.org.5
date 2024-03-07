Return-Path: <linux-kernel+bounces-96042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48485875675
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F06E0282783
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4850513540A;
	Thu,  7 Mar 2024 18:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcTIGJUH"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3062B135A78
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 18:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709837704; cv=none; b=chtnh8wujl40Ibl9rwxJSztx7DNvp28vwzhsL1CQ9pdl3JNSSWsjX3WSsYZDYpizqNaYvCRBWbAHlLPwNBF7e274Eq+tMVipl4+U3XMEKm1ugc6bqRmrlLGFMpPYKtnE8LFcKwTbOdOAxhYFsdtYaO84emPcK9A5rjPbIdEV20w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709837704; c=relaxed/simple;
	bh=rerC+7AS6AroFLGM0fpA5t23ITfW+/hLfNv3Qk/pJ18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WEcgZmtaxJ0KkJOsSoQUUVDSgh9CusMcttQBaJCf/vD5Tej5B4xbKWiIzL3Ay48E2nPJdq6/SpIwRyko8j4HyZ+8Msvq2jbwYctyJGjhbqaWSHVwJqGl7k7Sut7rb/2HwQyuAjMZOhLm27S0uop3OEk5yac+WhGUz5VUEH1r6Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZcTIGJUH; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-472d1912f80so360907137.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 10:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709837701; x=1710442501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgHLRC2kt2AJHtjPm8sAWCUV3DyQy9OV+QLe8onGTf0=;
        b=ZcTIGJUHp0RipLhg2r+nIHe3L137RKGnP+2d34HZjIkEpbH1eOnn8cE0r9AuLJIkS8
         /c2lNQJ/6voBpmAkQ/DtlDTzIv1g0tXDYQ0yoKRytNev6lBDtRC5kRoFTOJImLQrj3tr
         aCNKTqPYGdgTzN8mKnpC6ToFLong19hJNSf7Uw6IrgOjisMf5HHuZ1XFqtAM9JqnzgsQ
         nmRa6J1hQ9lwwEBXFtyPCyyn0zFqXlSGHye6D5/7KsLlXQFP7Zf4UEVDdgx2IIrPLIZL
         25rvP5McJbTcx6GPWKiLqDaou+ftxR6brsoe9SZGmE8HRAoWOEoEsrEaCvu1E2ve+bOZ
         +1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709837701; x=1710442501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgHLRC2kt2AJHtjPm8sAWCUV3DyQy9OV+QLe8onGTf0=;
        b=bvbygZiIrr1kbZXg7G6T83pVDCZdI1eMJ4FS63KwNBgkz+Bbnx7ATMXxMLhswlzptC
         tQSAT3q+Kt0BY/fuLe6b8fAnWssEB0FW/4fdyX7gqLXWTMmULuho0qgI0quxHhYLniy/
         EPTt53seShj0DeEEmENe5jC3dDXPQQIqPeedLBR9H0Kj2kn6zfZNskRyiPQLQp+54TAJ
         z6A40R/H6nIknbCo/Zs8KuJTj/RpFEP+uFDoKGAZMREG9cuL54bO3BqfgdyqzyxfWyEu
         DX3luevrU02oU5RDOzov0E3A/WyrX+mhehFdMT8NtvzXJbkSr68SaIIY2Qi09ulBnnrE
         PPSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXamVGxSqtF1tgl5nJy+SrkRH7BwamX9aGyMHUuaPuvv+e3/kHXdcUvP5kc4FAE2sFBOZ8GQnomYPVhJiDHbD5xYhtUp529GzXeo/KY
X-Gm-Message-State: AOJu0YyOLbpF0UoedbcrkA4qWY+j0RGCroXCd+0FJ9eQEeMGjIKjk7Cq
	t1fE+cQmXSCzajEj6d9DThmq/4qJl+TE5iNauQ+GTXCsF576zT6ProEdSJyo4R4/XwZUAuA+6l0
	bliMhp6kJPcPbxWk65CkfjAzR/P0=
X-Google-Smtp-Source: AGHT+IFdTuHON9nkrzb7RAhAEtzVpHmbHVNlIsaXCT+pDle3g3V7khbmZVflduF0KlkwzHdh+hbgdHwpWqbI4F3gq58=
X-Received: by 2002:a05:6102:3588:b0:473:c48:60d9 with SMTP id
 h8-20020a056102358800b004730c4860d9mr396446vsu.25.1709837700910; Thu, 07 Mar
 2024 10:55:00 -0800 (PST)
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
 <CAGsJ_4za-2xpg21phWi2WWLF1iPXhoc1xM__FDTwYYBBKsTPgw@mail.gmail.com>
 <a07deb2c-49e1-4324-8e70-e897605faa9d@redhat.com> <b1bf4b62-8e9b-470f-a300-d13c24177688@arm.com>
 <b174d4e1-e1ef-4766-91bc-de822eee30fb@redhat.com> <CAGsJ_4xXS0MsxRVTbf74DY_boQVUE2oP=AP6JmdXZSqsAOZzRQ@mail.gmail.com>
 <f3b1cb43-cb33-4db4-a3dd-0c787e30b113@arm.com>
In-Reply-To: <f3b1cb43-cb33-4db4-a3dd-0c787e30b113@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 8 Mar 2024 02:54:49 +0800
Message-ID: <CAGsJ_4wGe9SdMvojw_2XchEttrbww3RttoOENoF-O4bLWUd_rw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>, Lance Yang <ioworker0@gmail.com>, 
	Vishal Moola <vishal.moola@gmail.com>, akpm@linux-foundation.org, zokeefe@google.com, 
	shy828301@gmail.com, mhocko@suse.com, fengwei.yin@intel.com, 
	xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com, 
	peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 12:31=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 07/03/2024 12:01, Barry Song wrote:
> > On Thu, Mar 7, 2024 at 7:45=E2=80=AFPM David Hildenbrand <david@redhat.=
com> wrote:
> >>
> >> On 07.03.24 12:42, Ryan Roberts wrote:
> >>> On 07/03/2024 11:31, David Hildenbrand wrote:
> >>>> On 07.03.24 12:26, Barry Song wrote:
> >>>>> On Thu, Mar 7, 2024 at 7:13=E2=80=AFPM Ryan Roberts <ryan.roberts@a=
rm.com> wrote:
> >>>>>>
> >>>>>> On 07/03/2024 10:54, David Hildenbrand wrote:
> >>>>>>> On 07.03.24 11:54, David Hildenbrand wrote:
> >>>>>>>> On 07.03.24 11:50, Ryan Roberts wrote:
> >>>>>>>>> On 07/03/2024 09:33, Barry Song wrote:
> >>>>>>>>>> On Thu, Mar 7, 2024 at 10:07=E2=80=AFPM Ryan Roberts <ryan.rob=
erts@arm.com> wrote:
> >>>>>>>>>>>
> >>>>>>>>>>> On 07/03/2024 08:10, Barry Song wrote:
> >>>>>>>>>>>> On Thu, Mar 7, 2024 at 9:00=E2=80=AFPM Lance Yang <ioworker0=
@gmail.com> wrote:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Hey Barry,
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Thanks for taking time to review!
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> On Thu, Mar 7, 2024 at 3:00=E2=80=AFPM Barry Song <21cnbao@=
gmail.com> wrote:
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> On Thu, Mar 7, 2024 at 7:15=E2=80=AFPM Lance Yang <ioworke=
r0@gmail.com> wrote:
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>> [...]
> >>>>>>>>>>>>>>> +static inline bool can_mark_large_folio_lazyfree(unsigne=
d long addr,
> >>>>>>>>>>>>>>> +                                                struct f=
olio *folio,
> >>>>>>>>>>>>>>> pte_t *start_pte)
> >>>>>>>>>>>>>>> +{
> >>>>>>>>>>>>>>> +       int nr_pages =3D folio_nr_pages(folio);
> >>>>>>>>>>>>>>> +       fpb_t flags =3D FPB_IGNORE_DIRTY | FPB_IGNORE_SOF=
T_DIRTY;
> >>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>> +       for (int i =3D 0; i < nr_pages; i++)
> >>>>>>>>>>>>>>> +               if (page_mapcount(folio_page(folio, i)) !=
=3D 1)
> >>>>>>>>>>>>>>> +                       return false;
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> we have moved to folio_estimated_sharers though it is not =
precise, so
> >>>>>>>>>>>>>> we don't do
> >>>>>>>>>>>>>> this check with lots of loops and depending on the subpage=
's mapcount.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> If we don't check the subpage=E2=80=99s mapcount, and there=
 is a cow folio
> >>>>>>>>>>>>> associated
> >>>>>>>>>>>>> with this folio and the cow folio has smaller size than thi=
s folio,
> >>>>>>>>>>>>> should we still
> >>>>>>>>>>>>> mark this folio as lazyfree?
> >>>>>>>>>>>>
> >>>>>>>>>>>> I agree, this is true. However, we've somehow accepted the f=
act that
> >>>>>>>>>>>> folio_likely_mapped_shared
> >>>>>>>>>>>> can result in false negatives or false positives to balance =
the
> >>>>>>>>>>>> overhead.  So I really don't know :-)
> >>>>>>>>>>>>
> >>>>>>>>>>>> Maybe David and Vishal can give some comments here.
> >>>>>>>>>>>>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>> BTW, do we need to rebase our work against David's changes=
[1]?
> >>>>>>>>>>>>>> [1]
> >>>>>>>>>>>>>> https://lore.kernel.org/linux-mm/20240227201548.857831-1-d=
avid@redhat.com/
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Yes, we should rebase our work against David=E2=80=99s chan=
ges.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>> +       return nr_pages =3D=3D folio_pte_batch(folio, add=
r, start_pte,
> >>>>>>>>>>>>>>> +                                        ptep_get(start_p=
te), nr_pages,
> >>>>>>>>>>>>>>> flags, NULL);
> >>>>>>>>>>>>>>> +}
> >>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>      static int madvise_free_pte_range(pmd_t *pmd, unsign=
ed long addr,
> >>>>>>>>>>>>>>>                                     unsigned long end, st=
ruct mm_walk
> >>>>>>>>>>>>>>> *walk)
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> @@ -676,11 +690,45 @@ static int madvise_free_pte_range(p=
md_t *pmd,
> >>>>>>>>>>>>>>> unsigned long addr,
> >>>>>>>>>>>>>>>                      */
> >>>>>>>>>>>>>>>                     if (folio_test_large(folio)) {
> >>>>>>>>>>>>>>>                             int err;
> >>>>>>>>>>>>>>> +                       unsigned long next_addr, align;
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> -                       if (folio_estimated_sharers(folio=
) !=3D 1)
> >>>>>>>>>>>>>>> -                               break;
> >>>>>>>>>>>>>>> -                       if (!folio_trylock(folio))
> >>>>>>>>>>>>>>> -                               break;
> >>>>>>>>>>>>>>> +                       if (folio_estimated_sharers(folio=
) !=3D 1 ||
> >>>>>>>>>>>>>>> +                           !folio_trylock(folio))
> >>>>>>>>>>>>>>> +                               goto skip_large_folio;
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> I don't think we can skip all the PTEs for nr_pages, as so=
me of them
> >>>>>>>>>>>>>> might be
> >>>>>>>>>>>>>> pointing to other folios.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> for example, for a large folio with 16PTEs, you do MADV_DO=
NTNEED(15-16),
> >>>>>>>>>>>>>> and write the memory of PTE15 and PTE16, you get page faul=
ts, thus PTE15
> >>>>>>>>>>>>>> and PTE16 will point to two different small folios. We can=
 only skip
> >>>>>>>>>>>>>> when we
> >>>>>>>>>>>>>> are sure nr_pages =3D=3D folio_pte_batch() is sure.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Agreed. Thanks for pointing that out.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>> +                       align =3D folio_nr_pages(folio) *=
 PAGE_SIZE;
> >>>>>>>>>>>>>>> +                       next_addr =3D ALIGN_DOWN(addr + a=
lign, align);
> >>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>> +                       /*
> >>>>>>>>>>>>>>> +                        * If we mark only the subpages a=
s lazyfree, or
> >>>>>>>>>>>>>>> +                        * cannot mark the entire large f=
olio as
> >>>>>>>>>>>>>>> lazyfree,
> >>>>>>>>>>>>>>> +                        * then just split it.
> >>>>>>>>>>>>>>> +                        */
> >>>>>>>>>>>>>>> +                       if (next_addr > end || next_addr =
- addr !=3D
> >>>>>>>>>>>>>>> align ||
> >>>>>>>>>>>>>>> +                           !can_mark_large_folio_lazyfre=
e(addr, folio,
> >>>>>>>>>>>>>>> pte))
> >>>>>>>>>>>>>>> +                               goto split_large_folio;
> >>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>> +                       /*
> >>>>>>>>>>>>>>> +                        * Avoid unnecessary folio splitt=
ing if the
> >>>>>>>>>>>>>>> large
> >>>>>>>>>>>>>>> +                        * folio is entirely within the g=
iven range.
> >>>>>>>>>>>>>>> +                        */
> >>>>>>>>>>>>>>> +                       folio_clear_dirty(folio);
> >>>>>>>>>>>>>>> +                       folio_unlock(folio);
> >>>>>>>>>>>>>>> +                       for (; addr !=3D next_addr; pte++=
, addr +=3D
> >>>>>>>>>>>>>>> PAGE_SIZE) {
> >>>>>>>>>>>>>>> +                               ptent =3D ptep_get(pte);
> >>>>>>>>>>>>>>> +                               if (pte_young(ptent) ||
> >>>>>>>>>>>>>>> pte_dirty(ptent)) {
> >>>>>>>>>>>>>>> +                                       ptent =3D
> >>>>>>>>>>>>>>> ptep_get_and_clear_full(
> >>>>>>>>>>>>>>> +                                               mm, addr,=
 pte,
> >>>>>>>>>>>>>>> tlb->fullmm);
> >>>>>>>>>>>>>>> +                                       ptent =3D pte_mko=
ld(ptent);
> >>>>>>>>>>>>>>> +                                       ptent =3D pte_mkc=
lean(ptent);
> >>>>>>>>>>>>>>> +                                       set_pte_at(mm, ad=
dr, pte,
> >>>>>>>>>>>>>>> ptent);
> >>>>>>>>>>>>>>> +                                       tlb_remove_tlb_en=
try(tlb, pte,
> >>>>>>>>>>>>>>> addr);
> >>>>>>>>>>>>>>> +                               }
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Can we do this in batches? for a CONT-PTE mapped large fol=
io, you are
> >>>>>>>>>>>>>> unfolding
> >>>>>>>>>>>>>> and folding again. It seems quite expensive.
> >>>>>>>>>>>
> >>>>>>>>>>> I'm not convinced we should be doing this in batches. We want=
 the initial
> >>>>>>>>>>> folio_pte_batch() to be as loose as possible regarding permis=
sions so
> >>>>>>>>>>> that we
> >>>>>>>>>>> reduce our chances of splitting folios to the min. (e.g. igno=
re SW bits
> >>>>>>>>>>> like
> >>>>>>>>>>> soft dirty, etc). I think it might be possible that some PTEs=
 are RO and
> >>>>>>>>>>> other
> >>>>>>>>>>> RW too (e.g. due to cow - although with the current cow impl,=
 probably not.
> >>>>>>>>>>> But
> >>>>>>>>>>> its fragile to assume that). Anyway, if we do an initial batc=
h that ignores
> >>>>>>>>>>> all
> >>>>>>>>>>
> >>>>>>>>>> You are correct. I believe this scenario could indeed occur. F=
or instance,
> >>>>>>>>>> if process A forks process B and then unmaps itself, leaving B=
 as the
> >>>>>>>>>> sole process owning the large folio.  The current wp_page_reus=
e() function
> >>>>>>>>>> will reuse PTE one by one while the specific subpage is writte=
n.
> >>>>>>>>>
> >>>>>>>>> Hmm - I thought it would only reuse if the total mapcount for t=
he folio
> >>>>>>>>> was 1.
> >>>>>>>>> And since it is a large folio with each page mapped once in pro=
c B, I thought
> >>>>>>>>> every subpage write would cause a copy except the last one? I h=
aven't
> >>>>>>>>> looked at
> >>>>>>>>> the code for a while. But I had it in my head that this is an a=
rea we need to
> >>>>>>>>> improve for mTHP.
> >>>>>
> >>>>> So sad I am wrong again =F0=9F=98=A2
> >>>>>
> >>>>>>>>
> >>>>>>>> wp_page_reuse() will currently reuse a PTE part of a large folio=
 only if
> >>>>>>>> a single PTE remains mapped (refcount =3D=3D 0).
> >>>>>>>
> >>>>>>> ^ =3D=3D 1
> >>>>>
> >>>>> seems this needs improvement. it is a waste the last subpage can
> >>>>
> >>>> My take that is WIP:
> >>>>
> >>>> https://lore.kernel.org/all/20231124132626.235350-1-david@redhat.com=
/T/#u
> >>>>
> >>>>> reuse the whole large folio. i was doing it in a quite different wa=
y,
> >>>>> if the large folio had only one subpage left, i would do copy and
> >>>>> released the large folio[1]. and if i could reuse the whole large f=
olio
> >>>>> with CONT-PTE, i would reuse the whole large folio[2]. in mainline,
> >>>>> we don't have this cont-pte luxury exposed to mm, so i guess we can
> >>>>> not do [2] easily, but [1] seems to be an optimization.
> >>>>
> >>>> Yeah, I had essentially the same idea: just free up the large folio =
if most of
> >>>> the stuff is unmapped. But that's rather a corner-case optimization,=
 so I did
> >>>> not proceed with that.
> >>>>
> >>>
> >>> I'm not sure it's a corner case, really? - process forks, then both p=
arent and
> >>> child and write to all pages in what was previously a fully & contigu=
ously
> >>> mapped large folio?
> >>
> >> Well, with 2 MiB my assumption was that while it can happen, it's rath=
er
> >> rare. With smaller THP it might get more likely, agreed.
> >>
> >>>
> >>> Reggardless, why is it an optimization to do the copy for the last su=
bpage and
> >>> syncrhonously free the large folio? It's already partially mapped so =
is on the
> >>> deferred split list and can be split if memory is tight.
> >
> > we don't want reclamation overhead later. and we want memories immediat=
ely
> > available to others.
>
> But by that logic, you also don't want to leave the large folio partially=
 mapped
> all the way until the last subpage is CoWed. Surely you would want to rec=
laim it
> when you reach partial map status?

To some extent, I agree. But then we will have two many copies. The last
subpage is small, and a safe place to copy instead.

We actually had to tune userspace to decrease partial map as too much
partial map both unfolded CONT-PTE and wasted too much memory. if a
vma had too much partial map, we disabled mTHP on this VMA.

>
> > reclamation will always cause latency and affect User
> > experience. split_folio is not cheap :-)
>
> But neither is memcpy(4K) I'd imagine. But I get your point.

In a real product scenario, we need to consider the success rate of
allocating large folios.
Currently, it's only 7%, as reported here[1], with no method to keep
large folios intact in a
buddy system.

Yu's TAO[2] chose to release the large folio entirely after copying
the mapped parts
onto smaller folios in vmscan,

[1] https://lore.kernel.org/linux-mm/20240305083743.24950-1-21cnbao@gmail.c=
om/
[2] https://lore.kernel.org/linux-mm/20240229183436.4110845-1-yuzhao@google=
com/

>
> > if the number of this kind of
> > large folios
> > is huge, the waste can be huge for some while.
> >
> > it is not a corner case for large folio swap-in. while someone writes
> > one subpage, I swap-in a large folio, wp_reuse will immediately
> > be called. This can cause waste quite often. One outcome of this
> > discussion is that I realize I should investigate this issue immediatel=
y
> > in the swap-in series as my off-tree code has optimized reuse but
> > mainline hasn't.
> >
> >>
> >> At least for 2 MiB THP, it might make sense to make that large folio
> >> available immediately again, even without memory pressure. Even
> >> compaction would not compact it.
> >
> > It is also true for 64KiB. as we want other processes to allocate
> > 64KiB successfully as much as possible, and reduce the rate of
> > falling back to small folios. by releasing 64KiB directly to buddy
> > rather than splitting and returning 15*4KiB in shrinker, we reduce
> > buddy fragmentation too.
> >
> >>
> >> --
> >> Cheers,
> >>
> >> David / dhildenb

Thanks
Barry

