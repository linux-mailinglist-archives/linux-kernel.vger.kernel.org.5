Return-Path: <linux-kernel+bounces-82833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE23868A40
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC33A1C21CF2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552AC55E5A;
	Tue, 27 Feb 2024 07:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZX5UgahU"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D304652F62
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709020490; cv=none; b=jEsnrRjH6TEJqaoE3y7q5DtftUS48IEIDaC/WggWvX/aw1XcQUgRfyf250b6RjWgLSJWmb1c47LGmmEndKH2QQPZikUiBnIImsTz3+fuQnWiCRjhQIykl/CWCj3VMXK/gHd+Jh9RTIvznbJ9ksjgtyR9DViaOiRUFj9bJyI/I34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709020490; c=relaxed/simple;
	bh=GkZ92CAna9X0NDsm+ZKR/ivReuccpU3/8Dr3mAAHUeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n8RdjVv9lO2BXUnfxhu0d0QMfm8Ve1ME6XaAzfQOsxBmmkw3rgEaOfg4M75sg6Bk1uL+f6/UWW77M17UVrZSN5LPLNWAA3ncybajFUUHFFsYn8Dks5kWplW/lzsX3q5Unvlj4p7g89P6jrsHBAbinrFfdU35dYxyDNoJCsfU6eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZX5UgahU; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-471e395f6baso378819137.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 23:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709020487; x=1709625287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LGdQMg4v/47ebBCPE8p52p0nFqyTAE6s0wWMTEuF4s=;
        b=ZX5UgahUcn3UpxNE9Suga9akeEOZKIa9GQkTuzAeyR6pKE5xC9CDTYrdQ0J70D6PVD
         PWg22ALjE6nhmLwq/Zyxi8elKk7TNhiFvFSOOmQlu2jOwob8HqUm/y41z01CzDIuiLW6
         m6/RicxP5iDXQ1zdjVw55JUtpjmbmcmsWq+QI8e0MDfx6AlEVQtEzxzPZxHh5DuE3CMX
         EHPq8a2kjEJ4fAa49PhPrPajqzxd3yn61oxWBuKEmcZ7uuR789Svpc5dvNNrl2tAXY1J
         /W7nNvlUjLpWCjZ4CMapX63JqUJA00n5GVqe7VIOjKHeUikeAc6+vTJffLpOcEMpfx/j
         UIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709020487; x=1709625287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LGdQMg4v/47ebBCPE8p52p0nFqyTAE6s0wWMTEuF4s=;
        b=S8kfLfru1LzcyHz0UCt1VEjMAUNYiOXmoqmb3t5TcXeeBs55o3lN8qK8HQt78HWhmU
         /+6Hz0cL5DeJ/rRdEeYW2Vj+s9os3xWvHK10E4Wb3P1ZyxA+n7B9z7X/O7fJ1Q5hj4Ol
         eWDsva4VwDuS4GZyTErWTL9o4pudpKQMp8C/O7N0zvJLpVgmMvh8QlMwajKmU/2W+I5d
         VNSwGqk6tO4S4fPqcQUban46rnZDcvZd6ONoRlCoR4TcLAYqSOwTs6FYQmCbkK77mEFj
         phWcZWD1SUSY8rxuDWXB7V+2aBxzbkbOFU5wlZw+dxQ1lJazsgaeuQkMGLroZe9shZ5O
         tm/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/v0DFbL+IJ+4+C5BFIYRTnG8U88S16DhatfAKbanQSK2rwuv4pAsfBI5lY2WLs19J4p8GW9cPh6MqXfASOwBA9n255xh6zvMt5I0l
X-Gm-Message-State: AOJu0Yx/LIOHLqsY0nZMh0+34lqfyx8Xcu3QVhvlPEExij5dBEwMelXX
	FQrZwnJSuzFgm+i1Zbvzot6EaTrsXjHwHC5gOUa2F7c5C06naXs585rxYDirWNQh8unmzbe8gaz
	NqrT5oTPoiXu9Tfj4wMNdkMxS12k=
X-Google-Smtp-Source: AGHT+IF98DWS9zVjEyWiQ8fTdCdqJFfECqUTHMssPpb3Vg9a44Qi64zbHW9JxYLjN2AEkVeTA8HdDMwtlrl916iEJtM=
X-Received: by 2002:a67:fc84:0:b0:470:3afd:81dd with SMTP id
 x4-20020a67fc84000000b004703afd81ddmr6721902vsp.4.1709020487627; Mon, 26 Feb
 2024 23:54:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGsJ_4zera4+bWuXHKjdU3QdiR3sqcUQB3gF08DPD49OCT4S9w@mail.gmail.com>
 <20240226083714.26187-1-ioworker0@gmail.com> <9bcf5141-7376-441e-bbe3-779956ef28b9@redhat.com>
 <CAK1f24mdwjz2J5VmeYSDwb4jMbrXUVCSF_0pOcWSVt1cfa0FhQ@mail.gmail.com>
 <318be511-06de-423e-8216-af869f27f849@arm.com> <CAGsJ_4z+0yXUDYwxKNAqYwxAAYpfKpKd2u_dVTDP3b-KPOQT1g@mail.gmail.com>
 <19758162-be5f-4dc4-b316-77b0115d12ce@intel.com> <CAGsJ_4wx72KOazANBvnGcjdZse8W9+PW5_fspP9=QuX3X_7msg@mail.gmail.com>
 <3c56d7b8-b76d-4210-b431-ee6431775ba7@intel.com> <CAGsJ_4xu1kz5VD-CcNFvP0A1nPKDojV8Gy1HPvNKuQ_RAw=26g@mail.gmail.com>
 <6ea0020a-8f4b-44d1-a3b2-7c2905d32772@intel.com> <CAGsJ_4x6Otb9LUvnxAaPLnQ2MPPng0xpG-vJmFL7pNm10FDhZA@mail.gmail.com>
 <CAGsJ_4xndYM8=7v+EV_aWX+_qgA1UPmm38n+ujbQXJLzCPKfog@mail.gmail.com> <009e5633-decb-4c21-b5fc-58984fbade96@intel.com>
In-Reply-To: <009e5633-decb-4c21-b5fc-58984fbade96@intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 27 Feb 2024 20:54:36 +1300
Message-ID: <CAGsJ_4yftgfD7MsNd5iej8_wTrYeTsAFfW7xmqrj-Q_w8-oqMg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
To: Yin Fengwei <fengwei.yin@intel.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Lance Yang <ioworker0@gmail.com>, 
	David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mhocko@suse.com, minchan@kernel.org, peterx@redhat.com, 
	shy828301@gmail.com, songmuchun@bytedance.com, wangkefeng.wang@huawei.com, 
	zokeefe@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 8:42=E2=80=AFPM Yin Fengwei <fengwei.yin@intel.com>=
 wrote:
>
>
>
> On 2/27/24 15:21, Barry Song wrote:
> > On Tue, Feb 27, 2024 at 8:11=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> >>
> >> On Tue, Feb 27, 2024 at 8:02=E2=80=AFPM Yin Fengwei <fengwei.yin@intel=
com> wrote:
> >>>
> >>>
> >>>
> >>> On 2/27/24 14:40, Barry Song wrote:
> >>>> On Tue, Feb 27, 2024 at 7:14=E2=80=AFPM Yin Fengwei <fengwei.yin@int=
el.com> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 2/27/24 10:17, Barry Song wrote:
> >>>>>>> Like if we hit folio which is partially mapped to the range, don'=
t split it but
> >>>>>>> just unmap the mapping part from the range. Let page reclaim deci=
de whether
> >>>>>>> split the large folio or not (If it's not mapped to any other ran=
ge,it will be
> >>>>>>> freed as whole large folio. If part of it still mapped to other r=
ange,page reclaim
> >>>>>>> can decide whether to split it or ignore it for current reclaim c=
ycle).
> >>>>>> Yes, we can. but we still have to play the ptes check game to avoi=
d adding
> >>>>>> folios multiple times to reclaim the list.
> >>>>>>
> >>>>>> I don't see too much difference between splitting in madvise and s=
plitting
> >>>>>> in vmscan.  as our real purpose is avoiding splitting entirely map=
ped
> >>>>>> large folios. for partial mapped large folios, if we split in madv=
ise, then
> >>>>>> we don't need to play the game of skipping folios while iterating =
PTEs.
> >>>>>> if we don't split in madvise, we have to make sure the large folio=
 is only
> >>>>>> added in reclaimed list one time by checking if PTEs belong to the
> >>>>>> previous added folio.
> >>>>>
> >>>>> If the partial mapped large folio is unmapped from the range, the r=
elated PTE
> >>>>> become none. How could the folio be added to reclaimed list multipl=
e times?
> >>>>
> >>>> in case we have 16 PTEs in a large folio.
> >>>> PTE0 present
> >>>> PTE1 present
> >>>> PTE2 present
> >>>> PTE3  none
> >>>> PTE4 present
> >>>> PTE5 none
> >>>> PTE6 present
> >>>> ....
> >>>> the current code is scanning PTE one by one.
> >>>> while scanning PTE0, we have added the folio. then PTE1, PTE2, PTE4,=
 PTE6...
> >>> No. Before detect the folio is fully mapped to the range, we can't ad=
d folio
> >>> to reclaim list because the partial mapped folio shouldn't be added. =
We can
> >>> only scan PTE15 and know it's fully mapped.
> >>
> >> you never know PTE15 is the last one mapping to the large folio, PTE15=
 can
> >> be mapping to a completely different folio with PTE0.
> >>
> >>>
> >>> So, when scanning PTE0, we will not add folio. Then when hit PTE3, we=
 know
> >>> this is a partial mapped large folio. We will unmap it. Then all 16 P=
TEs
> >>> become none.
> >>
> >> I don't understand why all 16PTEs become none as we set PTEs to none.
> >> we set PTEs to swap entries till try_to_unmap_one called by vmscan.
> >>
> >>>
> >>> If the large folio is fully mapped, the folio will be added to reclai=
m list
> >>> after scan PTE15 and know it's fully mapped.
> >>
> >> our approach is calling pte_batch_pte while meeting the first pte, if
> >> pte_batch_pte =3D 16,
> >> then we add this folio to reclaim_list and skip the left 15 PTEs.
> >
> > Let's compare two different implementation, for partial mapped large fo=
lio
> > with 8 PTEs as below,
> >
> > PTE0 present for large folio1
> > PTE1 present for large folio1
> > PTE2 present for another folio2
> > PTE3 present for another folio3
> > PTE4 present for large folio1
> > PTE5 present for large folio1
> > PTE6 present for another folio4
> > PTE7 present for another folio5
> >
> > If we don't split in madvise(depend on vmscan to split after adding
> > folio1), we will have
> Let me clarify something here:
>
> I prefer that we don't split large folio here. Instead, we unmap the
> large folio from this VMA range (I think you missed the unmap operation
> I mentioned).

I don't understand why we unmap as this is a MADV_PAGEOUT not
an unmap. unmapping totally changes the semantics. Would you like
to show pseudo code?

for MADV_PAGEOUT on swap-out, the last step is writing swap entries
to replace PTEs which are present. I don't understand how an unmap
can be involved in this process.

>
> The intention is trying best to avoid splitting the large folio. If
> the folio is only partially mapped to this VMA range, it's likely it
> will be reclaimed as whole large folio. Which brings benefit for lru
> and zone lock contention comparing to splitting large folio.

which also brings negative side effects such as redundant I/O.
For example, if you have only one subpage left in a large folio,
pageout will still write nr_pages subpages into swap, then immediately
free them in swap.

>
> The thing I am not sure is unmapping from specific VMA range is not
> available and whether it's worthy to add it.

I think we might have the possibility to have some complex code to
add folio1, folio2, folio3, folio4 and folio5 in the above example into
reclaim_list while avoiding splitting folio1. but i really don't understand
how unmap will work.

>
> > to make sure folio1, folio2, folio3, folio4, folio5 are added to
> > reclaim_list by doing a complex
> > game while scanning these 8 PTEs.
> >
> > if we split in madvise, they become:
> >
> > PTE0 present for large folioA  - splitted from folio 1
> > PTE1 present for large folioB - splitted from folio 1
> > PTE2 present for another folio2
> > PTE3 present for another folio3
> > PTE4 present for large folioC - splitted from folio 1
> > PTE5 present for large folioD - splitted from folio 1
> > PTE6 present for another folio4
> > PTE7 present for another folio5
> >
> > we simply add the above 8 folios into reclaim_list one by one.
> >
> > I would vote for splitting for partial mapped large folio in madvise.
> >

Thanks
Barry

