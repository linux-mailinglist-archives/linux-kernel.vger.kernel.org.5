Return-Path: <linux-kernel+bounces-95504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE27874E7B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D991283F0B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FB11292F3;
	Thu,  7 Mar 2024 12:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkJb82vd"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAA7128378
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 12:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709812926; cv=none; b=a7GVTZUvcxtsAwgNIO5MtQ8JR8mhhSBx9j7In3gVA1tDxSz5Qczpv3V5iHlGZz0NPGQD0+NCldiYQyQ24Tf+oCcEA5PjjS6iR0DMXRYpCQIFfRi2uybrSph7b/92sghsvEqlO/5CSHvHAIekmQ40KAXYuZS5Ymqamlzw0RvPllM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709812926; c=relaxed/simple;
	bh=WCiVFaCGQBloZhn7fg80Wd2TCYW4jklCLafPsC/TH2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H8aYk/QgjoF0lCYLMlI+fIEUuEF9fJZ07ZomQf/uED4w5E7Qg9IdRCaV9kYIJbgG+LZenAQhV9pLctJ/rUtpHyc8kRt5LXA6JRXiVWrqDH1ekKNUgJ3w3PQZO44m7c4U5DlHl5H/nezSdIz/tVLc+JTZYKjCniOXpZD8lSsnO5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkJb82vd; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4d346e4242fso315205e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 04:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709812923; x=1710417723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiRVLLKTXZwQKsZIjiQH5O7OCbSj9iMZpcubEGTHRPU=;
        b=PkJb82vd1JGJjWHWATtEAtCZTRFzmNNv+0DGfer3XnGP9xCsuQJt/x9kwxGiS7nD+f
         iypS3lpvZnEJUJZdqv1CcGANUMJtq/MwgyH1TrLKFtcShZlL3fSB8PEx9IYO74iXtby7
         vy648W70JI8NxNLmPpxrfDiddskny5/XSde7p+YK5q7k58HsqFsn+MSge1/IPofj8Llb
         uHUofsujAljMpQhGvBLUbGKUvkmyP9V1VCEykT6jG1FyqvC7+56Z7CVklUre4cKAtY23
         AqBNucWKfXQB9ZK1Jyz2cOhzp9ZiS3eBzEeo33wM+oeuUZ6Nc4OkaIGqGoi+1ilzFUbR
         b0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709812923; x=1710417723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yiRVLLKTXZwQKsZIjiQH5O7OCbSj9iMZpcubEGTHRPU=;
        b=TkgD9VW9HHWbhmdVkPznjSB5bTFNGGtz4bYeD3V8rCnvGZ0PHXiyBaPfKPW0axYzgW
         a0I6QuelFk9dczxQp9rXR8YPWg2uv7XQg3sNolLYDt/35GyHfvZ11dT36H8FdCJmrlOX
         iNa28CqEJgJVQL/qMlp/fQfmQWMCb80Zv22bBVIMuMz8FCCNSm1vzLXeZOPv2TqZlNWJ
         BvtimF7SeFfAKurCRosLGdZjhCELWXarNl3lE5ZUz/4PUws6O1m4SWQAEohWVkxrGW3c
         5CPHMy/VrJgtyLl9mAO+oo7G2I2IEBrbAEUp1Y5yMd6kNf5JyazsVkYsdaa8JdWjveIg
         sxJA==
X-Forwarded-Encrypted: i=1; AJvYcCVITMT1zLpXCp3F/7SFkNyt1BJMZlWBhlpFZ+ypCYnrOvZ/GHbQp1cBMqMrLcicPvBA2Aol7m+lSXRMgs6pLoxkE1u2sky6NmgzlQHw
X-Gm-Message-State: AOJu0YwyawmLS9ZIecSgiBrz7oLVrpdT4G1BAmRqcFRtBemjVSdOhgzu
	hXdjYBiXLszUL8DceSe0PLdauW0uEuIizexxMojFmeHXN9jLdpoedyYC1+G5xu4txLkomohPyKd
	7U+BImD/HPALiMvL4EAh2Ge4kcBQ=
X-Google-Smtp-Source: AGHT+IE56D95vkcppYlIaSiMWmuIKbFmdc2jgyWmasyu8Vr8sUr86KEcUK/2DCaU+6D4jFwZiI93hxtcs7gn9xnTs+s=
X-Received: by 2002:a05:6122:17a7:b0:4c9:75c3:e79b with SMTP id
 o39-20020a05612217a700b004c975c3e79bmr8433911vkf.6.1709812922947; Thu, 07 Mar
 2024 04:02:02 -0800 (PST)
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
 <b174d4e1-e1ef-4766-91bc-de822eee30fb@redhat.com>
In-Reply-To: <b174d4e1-e1ef-4766-91bc-de822eee30fb@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 7 Mar 2024 20:01:51 +0800
Message-ID: <CAGsJ_4xXS0MsxRVTbf74DY_boQVUE2oP=AP6JmdXZSqsAOZzRQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Lance Yang <ioworker0@gmail.com>, 
	Vishal Moola <vishal.moola@gmail.com>, akpm@linux-foundation.org, zokeefe@google.com, 
	shy828301@gmail.com, mhocko@suse.com, fengwei.yin@intel.com, 
	xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com, 
	peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 7:45=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 07.03.24 12:42, Ryan Roberts wrote:
> > On 07/03/2024 11:31, David Hildenbrand wrote:
> >> On 07.03.24 12:26, Barry Song wrote:
> >>> On Thu, Mar 7, 2024 at 7:13=E2=80=AFPM Ryan Roberts <ryan.roberts@arm=
com> wrote:
> >>>>
> >>>> On 07/03/2024 10:54, David Hildenbrand wrote:
> >>>>> On 07.03.24 11:54, David Hildenbrand wrote:
> >>>>>> On 07.03.24 11:50, Ryan Roberts wrote:
> >>>>>>> On 07/03/2024 09:33, Barry Song wrote:
> >>>>>>>> On Thu, Mar 7, 2024 at 10:07=E2=80=AFPM Ryan Roberts <ryan.rober=
ts@arm.com> wrote:
> >>>>>>>>>
> >>>>>>>>> On 07/03/2024 08:10, Barry Song wrote:
> >>>>>>>>>> On Thu, Mar 7, 2024 at 9:00=E2=80=AFPM Lance Yang <ioworker0@g=
mail.com> wrote:
> >>>>>>>>>>>
> >>>>>>>>>>> Hey Barry,
> >>>>>>>>>>>
> >>>>>>>>>>> Thanks for taking time to review!
> >>>>>>>>>>>
> >>>>>>>>>>> On Thu, Mar 7, 2024 at 3:00=E2=80=AFPM Barry Song <21cnbao@gm=
ail.com> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> On Thu, Mar 7, 2024 at 7:15=E2=80=AFPM Lance Yang <ioworker0=
@gmail.com> wrote:
> >>>>>>>>>>>>>
> >>>>>>>>>>> [...]
> >>>>>>>>>>>>> +static inline bool can_mark_large_folio_lazyfree(unsigned =
long addr,
> >>>>>>>>>>>>> +                                                struct fol=
io *folio,
> >>>>>>>>>>>>> pte_t *start_pte)
> >>>>>>>>>>>>> +{
> >>>>>>>>>>>>> +       int nr_pages =3D folio_nr_pages(folio);
> >>>>>>>>>>>>> +       fpb_t flags =3D FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_=
DIRTY;
> >>>>>>>>>>>>> +
> >>>>>>>>>>>>> +       for (int i =3D 0; i < nr_pages; i++)
> >>>>>>>>>>>>> +               if (page_mapcount(folio_page(folio, i)) !=
=3D 1)
> >>>>>>>>>>>>> +                       return false;
> >>>>>>>>>>>>
> >>>>>>>>>>>> we have moved to folio_estimated_sharers though it is not pr=
ecise, so
> >>>>>>>>>>>> we don't do
> >>>>>>>>>>>> this check with lots of loops and depending on the subpage's=
 mapcount.
> >>>>>>>>>>>
> >>>>>>>>>>> If we don't check the subpage=E2=80=99s mapcount, and there i=
s a cow folio
> >>>>>>>>>>> associated
> >>>>>>>>>>> with this folio and the cow folio has smaller size than this =
folio,
> >>>>>>>>>>> should we still
> >>>>>>>>>>> mark this folio as lazyfree?
> >>>>>>>>>>
> >>>>>>>>>> I agree, this is true. However, we've somehow accepted the fac=
t that
> >>>>>>>>>> folio_likely_mapped_shared
> >>>>>>>>>> can result in false negatives or false positives to balance th=
e
> >>>>>>>>>> overhead.  So I really don't know :-)
> >>>>>>>>>>
> >>>>>>>>>> Maybe David and Vishal can give some comments here.
> >>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>>> BTW, do we need to rebase our work against David's changes[1=
]?
> >>>>>>>>>>>> [1]
> >>>>>>>>>>>> https://lore.kernel.org/linux-mm/20240227201548.857831-1-dav=
id@redhat.com/
> >>>>>>>>>>>
> >>>>>>>>>>> Yes, we should rebase our work against David=E2=80=99s change=
s.
> >>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>>> +
> >>>>>>>>>>>>> +       return nr_pages =3D=3D folio_pte_batch(folio, addr,=
 start_pte,
> >>>>>>>>>>>>> +                                        ptep_get(start_pte=
), nr_pages,
> >>>>>>>>>>>>> flags, NULL);
> >>>>>>>>>>>>> +}
> >>>>>>>>>>>>> +
> >>>>>>>>>>>>>      static int madvise_free_pte_range(pmd_t *pmd, unsigned=
 long addr,
> >>>>>>>>>>>>>                                     unsigned long end, stru=
ct mm_walk
> >>>>>>>>>>>>> *walk)
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> @@ -676,11 +690,45 @@ static int madvise_free_pte_range(pmd=
_t *pmd,
> >>>>>>>>>>>>> unsigned long addr,
> >>>>>>>>>>>>>                      */
> >>>>>>>>>>>>>                     if (folio_test_large(folio)) {
> >>>>>>>>>>>>>                             int err;
> >>>>>>>>>>>>> +                       unsigned long next_addr, align;
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> -                       if (folio_estimated_sharers(folio) =
!=3D 1)
> >>>>>>>>>>>>> -                               break;
> >>>>>>>>>>>>> -                       if (!folio_trylock(folio))
> >>>>>>>>>>>>> -                               break;
> >>>>>>>>>>>>> +                       if (folio_estimated_sharers(folio) =
!=3D 1 ||
> >>>>>>>>>>>>> +                           !folio_trylock(folio))
> >>>>>>>>>>>>> +                               goto skip_large_folio;
> >>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> I don't think we can skip all the PTEs for nr_pages, as some=
 of them
> >>>>>>>>>>>> might be
> >>>>>>>>>>>> pointing to other folios.
> >>>>>>>>>>>>
> >>>>>>>>>>>> for example, for a large folio with 16PTEs, you do MADV_DONT=
NEED(15-16),
> >>>>>>>>>>>> and write the memory of PTE15 and PTE16, you get page faults=
, thus PTE15
> >>>>>>>>>>>> and PTE16 will point to two different small folios. We can o=
nly skip
> >>>>>>>>>>>> when we
> >>>>>>>>>>>> are sure nr_pages =3D=3D folio_pte_batch() is sure.
> >>>>>>>>>>>
> >>>>>>>>>>> Agreed. Thanks for pointing that out.
> >>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>>> +
> >>>>>>>>>>>>> +                       align =3D folio_nr_pages(folio) * P=
AGE_SIZE;
> >>>>>>>>>>>>> +                       next_addr =3D ALIGN_DOWN(addr + ali=
gn, align);
> >>>>>>>>>>>>> +
> >>>>>>>>>>>>> +                       /*
> >>>>>>>>>>>>> +                        * If we mark only the subpages as =
lazyfree, or
> >>>>>>>>>>>>> +                        * cannot mark the entire large fol=
io as
> >>>>>>>>>>>>> lazyfree,
> >>>>>>>>>>>>> +                        * then just split it.
> >>>>>>>>>>>>> +                        */
> >>>>>>>>>>>>> +                       if (next_addr > end || next_addr - =
addr !=3D
> >>>>>>>>>>>>> align ||
> >>>>>>>>>>>>> +                           !can_mark_large_folio_lazyfree(=
addr, folio,
> >>>>>>>>>>>>> pte))
> >>>>>>>>>>>>> +                               goto split_large_folio;
> >>>>>>>>>>>>> +
> >>>>>>>>>>>>> +                       /*
> >>>>>>>>>>>>> +                        * Avoid unnecessary folio splittin=
g if the
> >>>>>>>>>>>>> large
> >>>>>>>>>>>>> +                        * folio is entirely within the giv=
en range.
> >>>>>>>>>>>>> +                        */
> >>>>>>>>>>>>> +                       folio_clear_dirty(folio);
> >>>>>>>>>>>>> +                       folio_unlock(folio);
> >>>>>>>>>>>>> +                       for (; addr !=3D next_addr; pte++, =
addr +=3D
> >>>>>>>>>>>>> PAGE_SIZE) {
> >>>>>>>>>>>>> +                               ptent =3D ptep_get(pte);
> >>>>>>>>>>>>> +                               if (pte_young(ptent) ||
> >>>>>>>>>>>>> pte_dirty(ptent)) {
> >>>>>>>>>>>>> +                                       ptent =3D
> >>>>>>>>>>>>> ptep_get_and_clear_full(
> >>>>>>>>>>>>> +                                               mm, addr, p=
te,
> >>>>>>>>>>>>> tlb->fullmm);
> >>>>>>>>>>>>> +                                       ptent =3D pte_mkold=
(ptent);
> >>>>>>>>>>>>> +                                       ptent =3D pte_mkcle=
an(ptent);
> >>>>>>>>>>>>> +                                       set_pte_at(mm, addr=
, pte,
> >>>>>>>>>>>>> ptent);
> >>>>>>>>>>>>> +                                       tlb_remove_tlb_entr=
y(tlb, pte,
> >>>>>>>>>>>>> addr);
> >>>>>>>>>>>>> +                               }
> >>>>>>>>>>>>
> >>>>>>>>>>>> Can we do this in batches? for a CONT-PTE mapped large folio=
, you are
> >>>>>>>>>>>> unfolding
> >>>>>>>>>>>> and folding again. It seems quite expensive.
> >>>>>>>>>
> >>>>>>>>> I'm not convinced we should be doing this in batches. We want t=
he initial
> >>>>>>>>> folio_pte_batch() to be as loose as possible regarding permissi=
ons so
> >>>>>>>>> that we
> >>>>>>>>> reduce our chances of splitting folios to the min. (e.g. ignore=
 SW bits
> >>>>>>>>> like
> >>>>>>>>> soft dirty, etc). I think it might be possible that some PTEs a=
re RO and
> >>>>>>>>> other
> >>>>>>>>> RW too (e.g. due to cow - although with the current cow impl, p=
robably not.
> >>>>>>>>> But
> >>>>>>>>> its fragile to assume that). Anyway, if we do an initial batch =
that ignores
> >>>>>>>>> all
> >>>>>>>>
> >>>>>>>> You are correct. I believe this scenario could indeed occur. For=
 instance,
> >>>>>>>> if process A forks process B and then unmaps itself, leaving B a=
s the
> >>>>>>>> sole process owning the large folio.  The current wp_page_reuse(=
) function
> >>>>>>>> will reuse PTE one by one while the specific subpage is written.
> >>>>>>>
> >>>>>>> Hmm - I thought it would only reuse if the total mapcount for the=
 folio
> >>>>>>> was 1.
> >>>>>>> And since it is a large folio with each page mapped once in proc =
B, I thought
> >>>>>>> every subpage write would cause a copy except the last one? I hav=
en't
> >>>>>>> looked at
> >>>>>>> the code for a while. But I had it in my head that this is an are=
a we need to
> >>>>>>> improve for mTHP.
> >>>
> >>> So sad I am wrong again =F0=9F=98=A2
> >>>
> >>>>>>
> >>>>>> wp_page_reuse() will currently reuse a PTE part of a large folio o=
nly if
> >>>>>> a single PTE remains mapped (refcount =3D=3D 0).
> >>>>>
> >>>>> ^ =3D=3D 1
> >>>
> >>> seems this needs improvement. it is a waste the last subpage can
> >>
> >> My take that is WIP:
> >>
> >> https://lore.kernel.org/all/20231124132626.235350-1-david@redhat.com/T=
/#u
> >>
> >>> reuse the whole large folio. i was doing it in a quite different way,
> >>> if the large folio had only one subpage left, i would do copy and
> >>> released the large folio[1]. and if i could reuse the whole large fol=
io
> >>> with CONT-PTE, i would reuse the whole large folio[2]. in mainline,
> >>> we don't have this cont-pte luxury exposed to mm, so i guess we can
> >>> not do [2] easily, but [1] seems to be an optimization.
> >>
> >> Yeah, I had essentially the same idea: just free up the large folio if=
 most of
> >> the stuff is unmapped. But that's rather a corner-case optimization, s=
o I did
> >> not proceed with that.
> >>
> >
> > I'm not sure it's a corner case, really? - process forks, then both par=
ent and
> > child and write to all pages in what was previously a fully & contiguou=
sly
> > mapped large folio?
>
> Well, with 2 MiB my assumption was that while it can happen, it's rather
> rare. With smaller THP it might get more likely, agreed.
>
> >
> > Reggardless, why is it an optimization to do the copy for the last subp=
age and
> > syncrhonously free the large folio? It's already partially mapped so is=
 on the
> > deferred split list and can be split if memory is tight.

we don't want reclamation overhead later. and we want memories immediately
available to others. reclamation will always cause latency and affect User
experience. split_folio is not cheap :-) if the number of this kind of
large folios
is huge, the waste can be huge for some while.

it is not a corner case for large folio swap-in. while someone writes
one subpage, I swap-in a large folio, wp_reuse will immediately
be called. This can cause waste quite often. One outcome of this
discussion is that I realize I should investigate this issue immediately
in the swap-in series as my off-tree code has optimized reuse but
mainline hasn't.

>
> At least for 2 MiB THP, it might make sense to make that large folio
> available immediately again, even without memory pressure. Even
> compaction would not compact it.

It is also true for 64KiB. as we want other processes to allocate
64KiB successfully as much as possible, and reduce the rate of
falling back to small folios. by releasing 64KiB directly to buddy
rather than splitting and returning 15*4KiB in shrinker, we reduce
buddy fragmentation too.

>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry

