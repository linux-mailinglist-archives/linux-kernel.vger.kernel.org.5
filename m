Return-Path: <linux-kernel+bounces-91320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49353870E41
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E622228155D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D0B1C6AB;
	Mon,  4 Mar 2024 21:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9A1xiNB"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD948F58
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 21:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588529; cv=none; b=R7U4YeBpP7Gwdfdk+WVDNGHsOWa9KtzDIVQr6uHmaXrPciJxyCDYPsDeiZ8275xsb5AWpuRG/+5rv+pNStihlObmLGf1TweU3TC9v3Ddpkbu8WJYKy4668s/c9Z/xIxwd9nRbKcRTUrGA23tUpPoPLnY4m4IsWq4hn4lyn/ewQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588529; c=relaxed/simple;
	bh=T4C+Kdo3g7wMSr2Sx2//qGL4/LFyS/t5PtI+hkJgvu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4PsKzYVZCqtr3ZVyh/MxL5DoYE4p2yVIcj2RLweu9Jl6OrFsspqzxMtFIoZKYCth63maAOyfbUGcCpy9xujOW+CQEFp7btdet78a8kIhGCtoVDZEK0dRams9zoWWyWJTeiyG8UocgidlKtvpPEXBZnCmmr+afm5lEOJdB9CoqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9A1xiNB; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7d5c40f874aso2858321241.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 13:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709588527; x=1710193327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnQ9TZxK8Utos2QIbLcEX2k1DvVdZ75yY2QmeGXtsJQ=;
        b=N9A1xiNBG6QV2t6aZhLTrEeqRoeUFrQgXtTeB+00YZDZt+KKMP/ui7EHUitVEgDiSr
         KEIuf9uXevkC0OPKH9My7NxLyif/mfOyp2OLbQpoRm+Yw3v4M0DVI3Ejy3RNFGJWkpdI
         NlF56ATtk7Aakm++sAxY0El+9hXXQBFGcGe/8VPxcs/yLsWBTFqTZlM+Ugurhd7mWwe0
         UeYST05W4z9/6dKKvog6s2rPcx9BP4N1+4qjQgYcuZ3hSMBtZ9KMUYt2SgST84NloN+f
         aE0I9GRT4bbbauwg1swfqIi0Btdc7araPeOng05Fn1/xIsJg0DXtGGn4rHb+cKWoz8TF
         sfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709588527; x=1710193327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NnQ9TZxK8Utos2QIbLcEX2k1DvVdZ75yY2QmeGXtsJQ=;
        b=s82QPkhtt8MGapYnICYkrpAryDQH8KvgMctS8gkiKW+7Oo/nM5l5lTj9lMtsacjUng
         diJvlZT8OIc1C7pQPttETuDFAvq+yIfS5Ooyf8n6wUNPPmCLzTBtYZ7nnj+PS9HIDX9z
         bTmO8BG4tdZU5+8t6bJYKnuuyMy54kYaYqg7yPYqlIdxijFEgOQPOaqSTPycGxizDtdm
         I9oyr39SeQLIcLTmGOYQu0j8rWjRVA+RicqtFjy1OS11CRnBqttq9DMV4ZNhUgTU+scV
         xidSZwne6s4ePWOdD5CmO0IglYC9bU8fV7Af8Ok2Os4sHdMTipi6LUlc3KNjTuNm1Tn0
         syig==
X-Forwarded-Encrypted: i=1; AJvYcCXSvMujg2x3N/9N+A5pMta3drAgTff86b7feBQyVau8+X9BYsiOAW7eHPFgG++LRxgC1aYyXk0uXkVLZ+Pu5Sj2bd/DwiM2LoqhQ/mv
X-Gm-Message-State: AOJu0YxGFLAOHII9FVkjBHSqs6Am4utD5viBrOWJCtFg8h5Q48+CzgDb
	AxcS1/4pgGg/PpId8vfv+AbTjRTbERik7oWyFnut148gq5RIvyuIXtdyqS3D0NIjDzjUp9omb2S
	iov5+jW5581RkLVB8CxOcy+F00c8=
X-Google-Smtp-Source: AGHT+IHC7YkwRM7t3tahWO6VJ1kRgg0ana4tHv4S7qTl9rbvdwwNgBdp3Xjy+IxQGVJdebUHmxLS+oFQCd7eJQN7ZDk=
X-Received: by 2002:a05:6102:3748:b0:472:a717:acbf with SMTP id
 u8-20020a056102374800b00472a717acbfmr29273vst.24.1709588526852; Mon, 04 Mar
 2024 13:42:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304103757.235352-1-21cnbao@gmail.com> <706b7129-85f6-4470-9fd9-f955a8e6bd7c@arm.com>
 <37f1e6da-412b-4bb4-88b7-4c49f21f5fe9@redhat.com> <10f9542e-f3d8-42b0-9de4-9867cab997b9@arm.com>
 <17b4527c-3782-4eab-8b33-e0c6ff57139f@redhat.com> <CAGsJ_4wgMtY2=xRFSx8xAgROR97MevAtCYRUG+Xy+n6FUw9a1w@mail.gmail.com>
 <882fcbdd-5392-4dbf-99e4-b35defd9e3dc@redhat.com>
In-Reply-To: <882fcbdd-5392-4dbf-99e4-b35defd9e3dc@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 5 Mar 2024 10:41:55 +1300
Message-ID: <CAGsJ_4z9k+bc0b61BSUz9WTVgRjFYM5BVMtr-Brhcrh7MYjC=w@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: hold PTL from the first PTE while reclaiming a
 large folio
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	chrisl@kernel.org, yuzhao@google.com, hanchuanhua@oppo.com, 
	linux-kernel@vger.kernel.org, willy@infradead.org, ying.huang@intel.com, 
	xiang@kernel.org, mhocko@suse.com, shy828301@gmail.com, 
	wangkefeng.wang@huawei.com, Barry Song <v-songbaohua@oppo.com>, 
	Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 10:02=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 04.03.24 21:42, Barry Song wrote:
> > On Tue, Mar 5, 2024 at 3:27=E2=80=AFAM David Hildenbrand <david@redhat.=
com> wrote:
> >>
> >> On 04.03.24 14:03, Ryan Roberts wrote:
> >>> On 04/03/2024 12:41, David Hildenbrand wrote:
> >>>> On 04.03.24 13:20, Ryan Roberts wrote:
> >>>>> Hi Barry,
> >>>>>
> >>>>> On 04/03/2024 10:37, Barry Song wrote:
> >>>>>> From: Barry Song <v-songbaohua@oppo.com>
> >>>>>>
> >>>>>> page_vma_mapped_walk() within try_to_unmap_one() races with other
> >>>>>> PTEs modification such as break-before-make, while iterating PTEs
> >>>>>> of a large folio, it will only begin to acquire PTL after it gets
> >>>>>> a valid(present) PTE. break-before-make intermediately sets PTEs
> >>>>>> to pte_none. Thus, a large folio's PTEs might be partially skipped
> >>>>>> in try_to_unmap_one().
> >>>>>
> >>>>> I just want to check my understanding here - I think the problem oc=
curs for
> >>>>> PTE-mapped, PMD-sized folios as well as smaller-than-PMD-size large=
 folios? Now
> >>>>> that I've had a look at the code and have a better understanding, I=
 think that
> >>>>> must be the case? And therefore this problem exists independently o=
f my work to
> >>>>> support swap-out of mTHP? (From your previous report I was under th=
e impression
> >>>>> that it only affected mTHP).
> >>>>>
> >>>>> Its just that the problem is becoming more pronounced because with =
mTHP,
> >>>>> PTE-mapped large folios are much more common?
> >>>>
> >>>> That is my understanding.
> >>>>
> >>>>>
> >>>>>> For example, for an anon folio, after try_to_unmap_one(), we may
> >>>>>> have PTE0 present, while PTE1 ~ PTE(nr_pages - 1) are swap entries=
.
> >>>>>> So folio will be still mapped, the folio fails to be reclaimed.
> >>>>>> What=E2=80=99s even more worrying is, its PTEs are no longer in a =
unified
> >>>>>> state. This might lead to accident folio_split() afterwards. And
> >>>>>> since a part of PTEs are now swap entries, accessing them will
> >>>>>> incur page fault - do_swap_page.
> >>>>>> It creates both anxiety and more expense. While we can't avoid
> >>>>>> userspace's unmap to break up unified PTEs such as CONT-PTE for
> >>>>>> a large folio, we can indeed keep away from kernel's breaking up
> >>>>>> them due to its code design.
> >>>>>> This patch is holding PTL from PTE0, thus, the folio will either
> >>>>>> be entirely reclaimed or entirely kept. On the other hand, this
> >>>>>> approach doesn't increase PTL contention. Even w/o the patch,
> >>>>>> page_vma_mapped_walk() will always get PTL after it sometimes
> >>>>>> skips one or two PTEs because intermediate break-before-makes
> >>>>>> are short, according to test. Of course, even w/o this patch,
> >>>>>> the vast majority of try_to_unmap_one still can get PTL from
> >>>>>> PTE0. This patch makes the number 100%.
> >>>>>> The other option is that we can give up in try_to_unmap_one
> >>>>>> once we find PTE0 is not the first entry we get PTL, we call
> >>>>>> page_vma_mapped_walk_done() to end the iteration at this case.
> >>>>>> This will keep the unified PTEs while the folio isn't reclaimed.
> >>>>>> The result is quite similar with small folios with one PTE -
> >>>>>> either entirely reclaimed or entirely kept.
> >>>>>> Reclaiming large folios by holding PTL from PTE0 seems a better
> >>>>>> option comparing to giving up after detecting PTL begins from
> >>>>>> non-PTE0.
> >>>>>>
> >>>>
> >>>> I'm sure that wall of text can be formatted in a better way :) . Als=
o, I think
> >>>> we can drop some of the details,
> >>>>
> >>>> If you need some inspiration, I can give it a shot.
> >>>>
> >>>>>> Cc: Hugh Dickins <hughd@google.com>
> >>>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >>>>>
> >>>>> Do we need a Fixes tag?
> >>>>>
> >>>>
> >>>> What would be the description of the problem we are fixing?
> >>>>
> >>>> 1) failing to unmap?
> >>>>
> >>>> That can happen with small folios as well IIUC.
> >>>>
> >>>> 2) Putting the large folio on the deferred split queue?
> >>>>
> >>>> That sounds more reasonable.
> >>>
> >>> Isn't the real problem today that we can end up writng a THP to the s=
wap file
> >>> (so 2M more IO and space used) but we can't remove it from memory, so=
 no actual
> >>> reclaim happens? Although I guess your (2) is really just another way=
 of saying
> >>> that.
> >>
> >> The same could happen with small folios I believe? We might end up
> >> running into the
> >>
> >> folio_mapped()
> >>
> >> after the try_to_unmap().
> >>
> >> Note that the actual I/O does not happen during add_to_swap(), but
> >> during the pageout() call when we find the folio to be dirty.
> >>
> >> So there would not actually be more I/O. Only swap space would be
> >> reserved, that would be used later when not running into the race.
> >
> > I am not worried about small folios at all as they have only one PTE.
> > so the PTE is either completely unmapped or completely mapped.
> >
> > In terms of large folios, it is a different story. for example, a large
> > folio with 16 PTEs with CONT-PTE, we will have
> >
> > 1. unfolded CONT-PTE, eg. PTE0 present, PTE1-PTE15 swap entries
> >
> > 2. page faults on PTE1-PTE15 after try_to_unmap if we access them.
> >
> > This is totally useless PF and can be avoided if we can try_to_unmap
> > properly at the beginning.
> >
> > 3. potential need to split a large folio afterwards. for example, MADV_=
PAGEOUT,
> > MADV_FREE might split it after finding it is not completely mapped.
> >
> > For small folios, we don't have any concern on the above issues.
>
> Right, but when we talk about "Fixes:", what exactly are we consider
> "really broken" above and what is "undesired"?
>
> (a) is there a correctness issue? I don't think so.
>
> (b) is there a real performance issue? I'd like to understand.
>
> After all, we've been living with that ever since we supported THP_SWAP,
> correct? "something does not work ideally in some corner cases" might be
> reasonable to handle here (and I really think we should), but might not
> be worth a "Fixes:".
>
> So if we could clarify that, it would be great.

I don't think this needs a fixes tag, and I would think it is an optimizati=
on
on corner cases. And I don't think we will see noticeable performance
improvement as this isn't happening quite often though I believe it does
improve the performance of corner cases. but if the corner case only
takes 0.1% of all try_to_unmap_one, no noticeable performance
improvement will be seen.

I feel it is more of a behavior to kick flies out while flies don't kill pe=
ople
but it can be sometimes quite annoying :-)  I ran into another bug in
large-folio swapin series due to this problem, 16 PTEs had contiguous
swap entries from Ryan's add_to_swap(), but they were splitted in
MADV_PAGEOUT because the folio was not completely mapped after
try_to_unmap_one.

Then after some time, some of the 16 pages were in swapcache, while
others were not in. In this case, I couldn't swap them in together and had =
to
handle PF one by one, but i was incorrectly handling it  and trying to
swap-in them together by reading swapfile. if they were atomically
handled in try_to_unmap_one, we could avoid this.

we may have to cope with this kind of problem from time to time in
future work.

>
> --
> Cheers,
>
> David / dhildenb

Thanks
Barry

