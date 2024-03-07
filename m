Return-Path: <linux-kernel+bounces-95755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD7E87521B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ADFDB299FE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28B61E879;
	Thu,  7 Mar 2024 14:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjAgIR+e"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A641E866
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709822513; cv=none; b=alar+x0Ji3wF1DEfQmuzbbg1xfHH3146aUXzoiLkoP/2mvJQs5OSIgXA9ibmGxzmaYCw85mlxB4HYO5UFrfRD2hyOKkXEzC+TtkKuNfXJajzVzreOZslCWc4qhaeCsSk0C1Dx9CIsI/5mHymKRfSdSUsqeZdmC9PQF1M8s0mv1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709822513; c=relaxed/simple;
	bh=BqjPest2vXT/k2vDdsQZawkPG6mzTE+3Ac/tfXOk/fA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DyrBVuSZyjeIs+HiBbeV86E0RFjzw19RZ1QydkRWHyALjznZ10MCMUVoRp5KcUReIYGK5sKdQ1ia6dKh8rLKIOJrXHeJ/Vkvgp6gnMlDa7pvkN774FcqAKwZK2TUuvOHzBdKZMZYzau4bcGzhTdAX+DYpSQBCNb3Ry2R+grnDJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjAgIR+e; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcbf82cdf05so949572276.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 06:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709822511; x=1710427311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4j+RBywVVOs9aYXXDFYhmAM4YOjedOfLhk9nCVzIHhQ=;
        b=JjAgIR+eA35UvEKjLcV4K9BH1zsXE2GYpp5UlamKZ6sM1pwUD0piZ9YdXmSjhHo6nj
         SVvTZnq9RYhWwG2KHzcg35srOZL6wGZu0F6Fa670SfFcvJgKqakSljUnzsn7dhouY3md
         PqZXJME2Ua/Rze+Iyca+O4qGW0OTXnmSjL47n0xOzQnEsUFlYFY27cZ0beywzvMUc3Wj
         Xl5Sxrv5vVB2Rf/YU5Vz281qmKLJgL/dZjBWPwPaeqr9vDeQY56uK/CmDieLw7z1dTNB
         muz3yB3hoM8R6IS8r1w2PGe78kSkWHNGlLzDj5AkTYILIRqJU1L95n0uTaeSi29lu/zL
         UWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709822511; x=1710427311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4j+RBywVVOs9aYXXDFYhmAM4YOjedOfLhk9nCVzIHhQ=;
        b=iiD48iBL/KdLsArl1Ud5Z+9LsbH0jxwYNYPMCeziP4n/jnHjOe4kp3n8MmXqfbm1V1
         HT7h0ta+fVNnBXblYOCF/WZRAay0l5qYJtN1G5dNsbmdhWYeU/dUP3+FA0/b/DUo2woU
         yHsEf+Pw0wnFI96PVuSN+0Ry7kKX5dgLl08yIRhDiIU8jMy7zQAunJ/ULAXWggZG0tvZ
         gbsLcTOVTEh8eGelR28f0INZJCWWrdLIU0uTkmio4lUkt7kujWvPZ2j28ZxWvMlh5jHR
         9l7rBCUDVnOYFRjdsUsGZSzxEV6XbGh0Xp5R8GeKhTjqeAkwzmMH33Q159rYmNQLsJ5G
         wKMw==
X-Forwarded-Encrypted: i=1; AJvYcCWU7OBqPp86RNqzZ7gDKSoq72MP/8NqFY/ORLvgMi1m1DsWQJRdzuqm70V3AWUR8w05xGwDvdZD5LltQHkneRWrw8+cGy6Pz7SDhgTG
X-Gm-Message-State: AOJu0YxIkPnX4hgXto6fDsH6W/3TwPsp20aKrz42/DgBq5oZnd1Xd4R8
	s7zM29zhAz7EIwwgeIIdHHCBlE1LveVL63KC5fpoJ+1iDgUUKZuHsIzMkZONkl8zRtg3NL2DIC9
	RVQX91oD3h3qiBETeoFz7/+3/jBU=
X-Google-Smtp-Source: AGHT+IEDxvCrrfvxOcu/4yY6zIqt5/u2anHJxDWo8f6Vd6sNy7uSR6/79RHkYg4iN0i4S+Qlxt7fQbIsnqmF0Go75VA=
X-Received: by 2002:a5b:810:0:b0:dcc:eb38:199c with SMTP id
 x16-20020a5b0810000000b00dcceb38199cmr16213392ybp.56.1709822510918; Thu, 07
 Mar 2024 06:41:50 -0800 (PST)
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
 <db46212b-000d-4e8e-87d2-90dbf0a6236a@redhat.com>
In-Reply-To: <db46212b-000d-4e8e-87d2-90dbf0a6236a@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 7 Mar 2024 22:41:39 +0800
Message-ID: <CAK1f24k8MgR-3sqpqZmg=aTF5Sh4if2o7qeW9zfGpGCSbHR2PA@mail.gmail.com>
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

Hey Barry, Ryan, David,

Thanks a lot for taking the time to explain and provide suggestions!
I really appreciate your time!

IIUC, here's what we need to do for v3:

If folio_likely_mapped_shared() is true, or if we cannot acquire
the folio lock, we simply skip the batched PTEs. Then, we compare
the number of batched PTEs against folio_mapcount(). Finally,
batch-update the access and dirty only.

I'm not sure if I've understood correctly, could you please confirm?

Thanks,
Lance

On Thu, Mar 7, 2024 at 7:17=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 07.03.24 12:13, Ryan Roberts wrote:
> > On 07/03/2024 10:54, David Hildenbrand wrote:
> >> On 07.03.24 11:54, David Hildenbrand wrote:
> >>> On 07.03.24 11:50, Ryan Roberts wrote:
> >>>> On 07/03/2024 09:33, Barry Song wrote:
> >>>>> On Thu, Mar 7, 2024 at 10:07=E2=80=AFPM Ryan Roberts <ryan.roberts@=
arm.com> wrote:
> >>>>>>
> >>>>>> On 07/03/2024 08:10, Barry Song wrote:
> >>>>>>> On Thu, Mar 7, 2024 at 9:00=E2=80=AFPM Lance Yang <ioworker0@gmai=
l.com> wrote:
> >>>>>>>>
> >>>>>>>> Hey Barry,
> >>>>>>>>
> >>>>>>>> Thanks for taking time to review!
> >>>>>>>>
> >>>>>>>> On Thu, Mar 7, 2024 at 3:00=E2=80=AFPM Barry Song <21cnbao@gmail=
com> wrote:
> >>>>>>>>>
> >>>>>>>>> On Thu, Mar 7, 2024 at 7:15=E2=80=AFPM Lance Yang <ioworker0@gm=
ail.com> wrote:
> >>>>>>>>>>
> >>>>>>>> [...]
> >>>>>>>>>> +static inline bool can_mark_large_folio_lazyfree(unsigned lon=
g addr,
> >>>>>>>>>> +                                                struct folio =
*folio,
> >>>>>>>>>> pte_t *start_pte)
> >>>>>>>>>> +{
> >>>>>>>>>> +       int nr_pages =3D folio_nr_pages(folio);
> >>>>>>>>>> +       fpb_t flags =3D FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIR=
TY;
> >>>>>>>>>> +
> >>>>>>>>>> +       for (int i =3D 0; i < nr_pages; i++)
> >>>>>>>>>> +               if (page_mapcount(folio_page(folio, i)) !=3D 1=
)
> >>>>>>>>>> +                       return false;
> >>>>>>>>>
> >>>>>>>>> we have moved to folio_estimated_sharers though it is not preci=
se, so
> >>>>>>>>> we don't do
> >>>>>>>>> this check with lots of loops and depending on the subpage's ma=
pcount.
> >>>>>>>>
> >>>>>>>> If we don't check the subpage=E2=80=99s mapcount, and there is a=
 cow folio
> >>>>>>>> associated
> >>>>>>>> with this folio and the cow folio has smaller size than this fol=
io,
> >>>>>>>> should we still
> >>>>>>>> mark this folio as lazyfree?
> >>>>>>>
> >>>>>>> I agree, this is true. However, we've somehow accepted the fact t=
hat
> >>>>>>> folio_likely_mapped_shared
> >>>>>>> can result in false negatives or false positives to balance the
> >>>>>>> overhead.  So I really don't know :-)
> >>>>>>>
> >>>>>>> Maybe David and Vishal can give some comments here.
> >>>>>>>
> >>>>>>>>
> >>>>>>>>> BTW, do we need to rebase our work against David's changes[1]?
> >>>>>>>>> [1]
> >>>>>>>>> https://lore.kernel.org/linux-mm/20240227201548.857831-1-david@=
redhat.com/
> >>>>>>>>
> >>>>>>>> Yes, we should rebase our work against David=E2=80=99s changes.
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>> +
> >>>>>>>>>> +       return nr_pages =3D=3D folio_pte_batch(folio, addr, st=
art_pte,
> >>>>>>>>>> +                                        ptep_get(start_pte), =
nr_pages,
> >>>>>>>>>> flags, NULL);
> >>>>>>>>>> +}
> >>>>>>>>>> +
> >>>>>>>>>>     static int madvise_free_pte_range(pmd_t *pmd, unsigned lon=
g addr,
> >>>>>>>>>>                                    unsigned long end, struct m=
m_walk *walk)
> >>>>>>>>>>
> >>>>>>>>>> @@ -676,11 +690,45 @@ static int madvise_free_pte_range(pmd_t =
*pmd,
> >>>>>>>>>> unsigned long addr,
> >>>>>>>>>>                     */
> >>>>>>>>>>                    if (folio_test_large(folio)) {
> >>>>>>>>>>                            int err;
> >>>>>>>>>> +                       unsigned long next_addr, align;
> >>>>>>>>>>
> >>>>>>>>>> -                       if (folio_estimated_sharers(folio) !=
=3D 1)
> >>>>>>>>>> -                               break;
> >>>>>>>>>> -                       if (!folio_trylock(folio))
> >>>>>>>>>> -                               break;
> >>>>>>>>>> +                       if (folio_estimated_sharers(folio) !=
=3D 1 ||
> >>>>>>>>>> +                           !folio_trylock(folio))
> >>>>>>>>>> +                               goto skip_large_folio;
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> I don't think we can skip all the PTEs for nr_pages, as some of=
 them
> >>>>>>>>> might be
> >>>>>>>>> pointing to other folios.
> >>>>>>>>>
> >>>>>>>>> for example, for a large folio with 16PTEs, you do MADV_DONTNEE=
D(15-16),
> >>>>>>>>> and write the memory of PTE15 and PTE16, you get page faults, t=
hus PTE15
> >>>>>>>>> and PTE16 will point to two different small folios. We can only=
 skip
> >>>>>>>>> when we
> >>>>>>>>> are sure nr_pages =3D=3D folio_pte_batch() is sure.
> >>>>>>>>
> >>>>>>>> Agreed. Thanks for pointing that out.
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>> +
> >>>>>>>>>> +                       align =3D folio_nr_pages(folio) * PAGE=
_SIZE;
> >>>>>>>>>> +                       next_addr =3D ALIGN_DOWN(addr + align,=
 align);
> >>>>>>>>>> +
> >>>>>>>>>> +                       /*
> >>>>>>>>>> +                        * If we mark only the subpages as laz=
yfree, or
> >>>>>>>>>> +                        * cannot mark the entire large folio =
as lazyfree,
> >>>>>>>>>> +                        * then just split it.
> >>>>>>>>>> +                        */
> >>>>>>>>>> +                       if (next_addr > end || next_addr - add=
r !=3D
> >>>>>>>>>> align ||
> >>>>>>>>>> +                           !can_mark_large_folio_lazyfree(add=
r, folio,
> >>>>>>>>>> pte))
> >>>>>>>>>> +                               goto split_large_folio;
> >>>>>>>>>> +
> >>>>>>>>>> +                       /*
> >>>>>>>>>> +                        * Avoid unnecessary folio splitting i=
f the large
> >>>>>>>>>> +                        * folio is entirely within the given =
range.
> >>>>>>>>>> +                        */
> >>>>>>>>>> +                       folio_clear_dirty(folio);
> >>>>>>>>>> +                       folio_unlock(folio);
> >>>>>>>>>> +                       for (; addr !=3D next_addr; pte++, add=
r +=3D
> >>>>>>>>>> PAGE_SIZE) {
> >>>>>>>>>> +                               ptent =3D ptep_get(pte);
> >>>>>>>>>> +                               if (pte_young(ptent) ||
> >>>>>>>>>> pte_dirty(ptent)) {
> >>>>>>>>>> +                                       ptent =3D ptep_get_and=
_clear_full(
> >>>>>>>>>> +                                               mm, addr, pte,
> >>>>>>>>>> tlb->fullmm);
> >>>>>>>>>> +                                       ptent =3D pte_mkold(pt=
ent);
> >>>>>>>>>> +                                       ptent =3D pte_mkclean(=
ptent);
> >>>>>>>>>> +                                       set_pte_at(mm, addr, p=
te, ptent);
> >>>>>>>>>> +                                       tlb_remove_tlb_entry(t=
lb, pte,
> >>>>>>>>>> addr);
> >>>>>>>>>> +                               }
> >>>>>>>>>
> >>>>>>>>> Can we do this in batches? for a CONT-PTE mapped large folio, y=
ou are
> >>>>>>>>> unfolding
> >>>>>>>>> and folding again. It seems quite expensive.
> >>>>>>
> >>>>>> I'm not convinced we should be doing this in batches. We want the =
initial
> >>>>>> folio_pte_batch() to be as loose as possible regarding permissions=
 so that we
> >>>>>> reduce our chances of splitting folios to the min. (e.g. ignore SW=
 bits like
> >>>>>> soft dirty, etc). I think it might be possible that some PTEs are =
RO and other
> >>>>>> RW too (e.g. due to cow - although with the current cow impl, prob=
ably not.
> >>>>>> But
> >>>>>> its fragile to assume that). Anyway, if we do an initial batch tha=
t ignores
> >>>>>> all
> >>>>>
> >>>>> You are correct. I believe this scenario could indeed occur. For in=
stance,
> >>>>> if process A forks process B and then unmaps itself, leaving B as t=
he
> >>>>> sole process owning the large folio.  The current wp_page_reuse() f=
unction
> >>>>> will reuse PTE one by one while the specific subpage is written.
> >>>>
> >>>> Hmm - I thought it would only reuse if the total mapcount for the fo=
lio was 1.
> >>>> And since it is a large folio with each page mapped once in proc B, =
I thought
> >>>> every subpage write would cause a copy except the last one? I haven'=
t looked at
> >>>> the code for a while. But I had it in my head that this is an area w=
e need to
> >>>> improve for mTHP.
> >>>
> >>> wp_page_reuse() will currently reuse a PTE part of a large folio only=
 if
> >>> a single PTE remains mapped (refcount =3D=3D 0).
> >>
> >> ^ =3D=3D 1
> >
> > Ahh yes. That's what I meant. I got the behacviour vagulely right thoug=
h.
> >
> > Anyway, regardless, I'm not sure we want to batch here. Or if we do, we=
 want to
> > batch function that will only clear access and dirty.
>
> We likely want to detect a folio batch the "usual" way (as relaxed as
> possible), then do all the checks (#pte =3D=3D folio_mapcount() under fol=
io
> lock), and finally batch-update the access and dirty only.
>
> --
> Cheers,
>
> David / dhildenb
>

