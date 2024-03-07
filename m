Return-Path: <linux-kernel+bounces-95417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E79D874D60
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA87B1F226AE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C805128801;
	Thu,  7 Mar 2024 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEu79M3Q"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF325DDC9
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 11:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709810823; cv=none; b=AWtmpIAXnkS6/Fv+A0HgzNIe8Z/8lt46J8p8ltJdwpEuKTVSAOAGsVlMfSrJg1UafWv3GQezN2vmD+6ZRxg0a4dLp1fy1ZkeYtLQ+it5BjTERwj0HzBcAd7NylrW2kmigJ7TXTu+HcxJlTA7Zgqg0UDXHudR3LlZFrRVuXD6YS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709810823; c=relaxed/simple;
	bh=yFF6VH1Utbj+f5rFbaTcpma/tVlp89UdMvSo9P14+Xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kz+EhUEkroeDjswGK/ixzU8mEafrKDYk3PWAjQsxDwPiBqz0POJPzWc8nl/rIKYnPxeyDCgR7XYF0KbFGoDyzNUusJAi07DWAUK0HFLbMFWL/GMTPqLGa9qfFW1zOQqUpclMOC6kGk1IdZtbqcWDVDrcnJ8eWLLuwwQSN8IXBjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEu79M3Q; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4d3638771f3so81517e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 03:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709810820; x=1710415620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5/UYxQ+V8iWd+wFm7wUJaiQxt6gTceVRV1QKSz0IOs=;
        b=gEu79M3Qz5k6bKOeByaNGkWvmWWWrhW4+fHtGcuYHTWx1rVNYT5Bb2fro3Hn+Zivh8
         xGRZxdW4dMVtYXkmMpzoiwkiXk6dcJc1ODxvNoxv5CYBQN7Vt1gPT8V3+FLQJUhJM7mM
         N/8OhjVGmL09F5c99DsuNLmdCHbK9Tie6oQ5NeQcpa14zH+/l1eU9LYapJxbssm5BrvV
         sB8ZBZzdhB0hNoTDY4HUsvG+F5AFNXT78k/lo7GX1n5qRhp69sOKPANwB9PwoqcYvq7B
         vBIZCQLjmiWu5vPIcXTroPCbsdTmI8RF+bndo0FR+k1ZNALQ3kHKh1BFO7vK0j7qOP/d
         SCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709810820; x=1710415620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5/UYxQ+V8iWd+wFm7wUJaiQxt6gTceVRV1QKSz0IOs=;
        b=XBjKud2wKoPzMibI0xxsIfV75tVR507mxCRqOI+JWWKqQYUGsp3CtxudEVs6AdF+Hc
         q7jROZmM8KlnJFiDqrAl58JCyDyQ/fvGcSg5jZwsX9RteG7hLbqS5VdBflKuw9QHi8An
         fUCz662K8kHdTAB0hNGjPwGPMQ1Hd5W4enYldd0ywZXAL436tjWPMB2Vp3qRaBdf388m
         8ulKuom/rrLUcnHPaGtfyT6aal6YeKJHd7w8NH2zY6SrRZKNedEjoK+oWQr96F+rM8JJ
         gUjQrbTqb1Tmgw/TS6/Gxv5jOsFpZA2Jq2M/ukR6KxqAYO19GItKNgI37m42OC/YNgw9
         wmwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXTId9QAgspOr1n5he8dgrgW9+HqFO8GaobJh+0sx3OUvxBXu8fPeFb3msPSoG92ncqXVMK1iTIrqKDXDgcWl3ezAVwKhdgDvBwv44
X-Gm-Message-State: AOJu0YwzdkJ1ArXhDplLOILQYk54kD7bhWwyOHDA3iXzloqRf6qHJOlY
	uV3gMACMne/m0MtwZpz/6UwNu3y6GAKvgfv2HX8j0K7Z4TBhPlfiaNi16HshLCv9lB2iMDL9Xsm
	JUBQ97moF2hhgepyr4pZBw7E6iZU=
X-Google-Smtp-Source: AGHT+IE6IVoDMMSp9p1MaTPE0G9ltm+lL5xNYXrUIzXUdFX9G8XAi+8LYpoVHhbZ9LrjwLylG9cnl6Mx+I+iygk9dkQ=
X-Received: by 2002:a05:6122:2908:b0:4d3:36b9:2c26 with SMTP id
 fm8-20020a056122290800b004d336b92c26mr7853739vkb.14.1709810820624; Thu, 07
 Mar 2024 03:27:00 -0800 (PST)
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
In-Reply-To: <d24f8553-33f2-4ae7-a06d-badaf9462d84@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 7 Mar 2024 19:26:49 +0800
Message-ID: <CAGsJ_4za-2xpg21phWi2WWLF1iPXhoc1xM__FDTwYYBBKsTPgw@mail.gmail.com>
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

On Thu, Mar 7, 2024 at 7:13=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 07/03/2024 10:54, David Hildenbrand wrote:
> > On 07.03.24 11:54, David Hildenbrand wrote:
> >> On 07.03.24 11:50, Ryan Roberts wrote:
> >>> On 07/03/2024 09:33, Barry Song wrote:
> >>>> On Thu, Mar 7, 2024 at 10:07=E2=80=AFPM Ryan Roberts <ryan.roberts@a=
rm.com> wrote:
> >>>>>
> >>>>> On 07/03/2024 08:10, Barry Song wrote:
> >>>>>> On Thu, Mar 7, 2024 at 9:00=E2=80=AFPM Lance Yang <ioworker0@gmail=
com> wrote:
> >>>>>>>
> >>>>>>> Hey Barry,
> >>>>>>>
> >>>>>>> Thanks for taking time to review!
> >>>>>>>
> >>>>>>> On Thu, Mar 7, 2024 at 3:00=E2=80=AFPM Barry Song <21cnbao@gmail.=
com> wrote:
> >>>>>>>>
> >>>>>>>> On Thu, Mar 7, 2024 at 7:15=E2=80=AFPM Lance Yang <ioworker0@gma=
il.com> wrote:
> >>>>>>>>>
> >>>>>>> [...]
> >>>>>>>>> +static inline bool can_mark_large_folio_lazyfree(unsigned long=
 addr,
> >>>>>>>>> +                                                struct folio *=
folio,
> >>>>>>>>> pte_t *start_pte)
> >>>>>>>>> +{
> >>>>>>>>> +       int nr_pages =3D folio_nr_pages(folio);
> >>>>>>>>> +       fpb_t flags =3D FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRT=
Y;
> >>>>>>>>> +
> >>>>>>>>> +       for (int i =3D 0; i < nr_pages; i++)
> >>>>>>>>> +               if (page_mapcount(folio_page(folio, i)) !=3D 1)
> >>>>>>>>> +                       return false;
> >>>>>>>>
> >>>>>>>> we have moved to folio_estimated_sharers though it is not precis=
e, so
> >>>>>>>> we don't do
> >>>>>>>> this check with lots of loops and depending on the subpage's map=
count.
> >>>>>>>
> >>>>>>> If we don't check the subpage=E2=80=99s mapcount, and there is a =
cow folio
> >>>>>>> associated
> >>>>>>> with this folio and the cow folio has smaller size than this foli=
o,
> >>>>>>> should we still
> >>>>>>> mark this folio as lazyfree?
> >>>>>>
> >>>>>> I agree, this is true. However, we've somehow accepted the fact th=
at
> >>>>>> folio_likely_mapped_shared
> >>>>>> can result in false negatives or false positives to balance the
> >>>>>> overhead.  So I really don't know :-)
> >>>>>>
> >>>>>> Maybe David and Vishal can give some comments here.
> >>>>>>
> >>>>>>>
> >>>>>>>> BTW, do we need to rebase our work against David's changes[1]?
> >>>>>>>> [1]
> >>>>>>>> https://lore.kernel.org/linux-mm/20240227201548.857831-1-david@r=
edhat.com/
> >>>>>>>
> >>>>>>> Yes, we should rebase our work against David=E2=80=99s changes.
> >>>>>>>
> >>>>>>>>
> >>>>>>>>> +
> >>>>>>>>> +       return nr_pages =3D=3D folio_pte_batch(folio, addr, sta=
rt_pte,
> >>>>>>>>> +                                        ptep_get(start_pte), n=
r_pages,
> >>>>>>>>> flags, NULL);
> >>>>>>>>> +}
> >>>>>>>>> +
> >>>>>>>>>    static int madvise_free_pte_range(pmd_t *pmd, unsigned long =
addr,
> >>>>>>>>>                                   unsigned long end, struct mm_=
walk *walk)
> >>>>>>>>>
> >>>>>>>>> @@ -676,11 +690,45 @@ static int madvise_free_pte_range(pmd_t *=
pmd,
> >>>>>>>>> unsigned long addr,
> >>>>>>>>>                    */
> >>>>>>>>>                   if (folio_test_large(folio)) {
> >>>>>>>>>                           int err;
> >>>>>>>>> +                       unsigned long next_addr, align;
> >>>>>>>>>
> >>>>>>>>> -                       if (folio_estimated_sharers(folio) !=3D=
 1)
> >>>>>>>>> -                               break;
> >>>>>>>>> -                       if (!folio_trylock(folio))
> >>>>>>>>> -                               break;
> >>>>>>>>> +                       if (folio_estimated_sharers(folio) !=3D=
 1 ||
> >>>>>>>>> +                           !folio_trylock(folio))
> >>>>>>>>> +                               goto skip_large_folio;
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> I don't think we can skip all the PTEs for nr_pages, as some of =
them
> >>>>>>>> might be
> >>>>>>>> pointing to other folios.
> >>>>>>>>
> >>>>>>>> for example, for a large folio with 16PTEs, you do MADV_DONTNEED=
(15-16),
> >>>>>>>> and write the memory of PTE15 and PTE16, you get page faults, th=
us PTE15
> >>>>>>>> and PTE16 will point to two different small folios. We can only =
skip
> >>>>>>>> when we
> >>>>>>>> are sure nr_pages =3D=3D folio_pte_batch() is sure.
> >>>>>>>
> >>>>>>> Agreed. Thanks for pointing that out.
> >>>>>>>
> >>>>>>>>
> >>>>>>>>> +
> >>>>>>>>> +                       align =3D folio_nr_pages(folio) * PAGE_=
SIZE;
> >>>>>>>>> +                       next_addr =3D ALIGN_DOWN(addr + align, =
align);
> >>>>>>>>> +
> >>>>>>>>> +                       /*
> >>>>>>>>> +                        * If we mark only the subpages as lazy=
free, or
> >>>>>>>>> +                        * cannot mark the entire large folio a=
s lazyfree,
> >>>>>>>>> +                        * then just split it.
> >>>>>>>>> +                        */
> >>>>>>>>> +                       if (next_addr > end || next_addr - addr=
 !=3D
> >>>>>>>>> align ||
> >>>>>>>>> +                           !can_mark_large_folio_lazyfree(addr=
, folio,
> >>>>>>>>> pte))
> >>>>>>>>> +                               goto split_large_folio;
> >>>>>>>>> +
> >>>>>>>>> +                       /*
> >>>>>>>>> +                        * Avoid unnecessary folio splitting if=
 the large
> >>>>>>>>> +                        * folio is entirely within the given r=
ange.
> >>>>>>>>> +                        */
> >>>>>>>>> +                       folio_clear_dirty(folio);
> >>>>>>>>> +                       folio_unlock(folio);
> >>>>>>>>> +                       for (; addr !=3D next_addr; pte++, addr=
 +=3D
> >>>>>>>>> PAGE_SIZE) {
> >>>>>>>>> +                               ptent =3D ptep_get(pte);
> >>>>>>>>> +                               if (pte_young(ptent) ||
> >>>>>>>>> pte_dirty(ptent)) {
> >>>>>>>>> +                                       ptent =3D ptep_get_and_=
clear_full(
> >>>>>>>>> +                                               mm, addr, pte,
> >>>>>>>>> tlb->fullmm);
> >>>>>>>>> +                                       ptent =3D pte_mkold(pte=
nt);
> >>>>>>>>> +                                       ptent =3D pte_mkclean(p=
tent);
> >>>>>>>>> +                                       set_pte_at(mm, addr, pt=
e, ptent);
> >>>>>>>>> +                                       tlb_remove_tlb_entry(tl=
b, pte,
> >>>>>>>>> addr);
> >>>>>>>>> +                               }
> >>>>>>>>
> >>>>>>>> Can we do this in batches? for a CONT-PTE mapped large folio, yo=
u are
> >>>>>>>> unfolding
> >>>>>>>> and folding again. It seems quite expensive.
> >>>>>
> >>>>> I'm not convinced we should be doing this in batches. We want the i=
nitial
> >>>>> folio_pte_batch() to be as loose as possible regarding permissions =
so that we
> >>>>> reduce our chances of splitting folios to the min. (e.g. ignore SW =
bits like
> >>>>> soft dirty, etc). I think it might be possible that some PTEs are R=
O and other
> >>>>> RW too (e.g. due to cow - although with the current cow impl, proba=
bly not.
> >>>>> But
> >>>>> its fragile to assume that). Anyway, if we do an initial batch that=
 ignores
> >>>>> all
> >>>>
> >>>> You are correct. I believe this scenario could indeed occur. For ins=
tance,
> >>>> if process A forks process B and then unmaps itself, leaving B as th=
e
> >>>> sole process owning the large folio.  The current wp_page_reuse() fu=
nction
> >>>> will reuse PTE one by one while the specific subpage is written.
> >>>
> >>> Hmm - I thought it would only reuse if the total mapcount for the fol=
io was 1.
> >>> And since it is a large folio with each page mapped once in proc B, I=
 thought
> >>> every subpage write would cause a copy except the last one? I haven't=
 looked at
> >>> the code for a while. But I had it in my head that this is an area we=
 need to
> >>> improve for mTHP.

So sad I am wrong again =F0=9F=98=A2

> >>
> >> wp_page_reuse() will currently reuse a PTE part of a large folio only =
if
> >> a single PTE remains mapped (refcount =3D=3D 0).
> >
> > ^ =3D=3D 1

seems this needs improvement. it is a waste the last subpage can
reuse the whole large folio. i was doing it in a quite different way,
if the large folio had only one subpage left, i would do copy and
released the large folio[1]. and if i could reuse the whole large folio
with CONT-PTE, i would reuse the whole large folio[2]. in mainline,
we don't have this cont-pte luxury exposed to mm, so i guess we can
not do [2] easily, but [1] seems to be an optimization.

[1] https://github.com/OnePlusOSS/android_kernel_oneplus_sm8650/blob/oneplu=
s/sm8650_u_14.0.0_oneplus12/mm/memory.c#L3977
[2] https://github.com/OnePlusOSS/android_kernel_oneplus_sm8650/blob/oneplu=
s/sm8650_u_14.0.0_oneplus12/mm/memory.c#L3812

>
> Ahh yes. That's what I meant. I got the behacviour vagulely right though.
>
> Anyway, regardless, I'm not sure we want to batch here. Or if we do, we w=
ant to
> batch function that will only clear access and dirty.
>

Thanks
Barry

