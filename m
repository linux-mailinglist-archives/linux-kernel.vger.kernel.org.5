Return-Path: <linux-kernel+bounces-82585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 681748686AD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BCD11C22728
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE50D1B28D;
	Tue, 27 Feb 2024 02:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+whmAct"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADFF11CAF
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 02:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709000264; cv=none; b=ZyEVDFRNUVjjyegMLdRENLBfMoaAYcaebMHHU2+euRoGl79SXeFlZz3pRToFy7qigmuhhjMqlJprZNceH2y4jFC3pEBOV5NKDWlW3MPEBb3aOQcll3YOd9yyJsllg4X9yQUUOlOHjWXFhqGt8X0ygKMm+aCZ2dQtRmIja5rRE1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709000264; c=relaxed/simple;
	bh=JR9kUlDXtLnfWUZv6yt+had/5Xksma4HemKo2amFd74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ACawUpQ/2XUaosGRXf3ZjkXAjTZTXbsYAGiR2TMmYfd/dNcXPiYjxeTGs4rK2yHFwHv2ClAx7dsFCltAvcfyRW9Pt6/QN3aTGmOb5gG1ZmG9OdOBN4XDJzXwLu0DpTYhRgVkIFH9sTruiR9T3s/ERv+8dtexVlV2IzrIfwyOpf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+whmAct; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7d643a40a91so2216969241.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 18:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709000261; x=1709605061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ReCSL7lbirgRScT6I2z3qdqNs57J7V9jRqJOBCMvkWQ=;
        b=f+whmActHDWI0MdsomaWl8KQUEi/qLfrhwX5ySp321FGjKX3Pp8ZOU3N/htoA1P3gB
         L8312bGKF/UNQpK6jDQp096xXAV1wQpBf4RhwqSKwN2UI/+OINfip2fyL2J+cbItFBae
         4RRGbqON3+eHchKSyyIypkFL7WUcbLtwoaouFWbTDhfsBBmfwnbR3SApNzWf2yOb1M9B
         0pzHc0JfNR4b+jd/ao/WV/SNyNlEGV/jFzw3EFUzKfMm9Y8Mpx+TjZuphhZUk/PxCfLZ
         DwVt4/bQYb3xUAVQuB7x3wyy8TOw2eJXyHjtsRyRFRqswXmvxNHSdc1SUJhZ8G4HMeWI
         3OxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709000261; x=1709605061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ReCSL7lbirgRScT6I2z3qdqNs57J7V9jRqJOBCMvkWQ=;
        b=S4+P2CypeqB6Epj6GTlhAj5Yi19HZAeEA2f1OUqOFe8aylBiBgYOx7N4RJ7XojQaRs
         v/Simr87U9x3l0R78+GHJyUM5jJou/2TEcLBcRUnqVwXshUkRVy4pM7L9kkG2+CrNJnj
         luvnlYXy+eBGG6BpdHLS2R2IyQKeQWaU8GTBauXG/O+RE6ojzR9pF/LFKZo30Q+isZ7x
         KT4000f1+BOpHUOztU20mt1jY//egIRgQUwfOHor1MBZ2tVA0TgE/KyCJyIM54CS7DpP
         aHKGWejzEmwAP2B1S9m/6IqN1wlUWzcrmWVeBfIQrRt2g5KdnCRyqnEJkzCLaKArLEa0
         8XhA==
X-Forwarded-Encrypted: i=1; AJvYcCVDIk3cVhXPNs27CmqSxCqB9NZtwZkd9dI9zAVicLychAzzDWD5A3UnnQTFzdfXMSWqsk2d/N65odns4COUGu115WgY5fDATfAXxGwU
X-Gm-Message-State: AOJu0YwmB7t0eWPpW91M0V2GGqP69fr96TclwafX9nsCOM5SYbpAFc5R
	rCeFkNBYs8zsL61DtWU2sfXvso7WD+O0Ynbe/m9155JNk0gd2XR6r2jli8ndkEM8Gijt10kiSDL
	1wZAyyX9la48VdqaPmy3JdpXMk4s=
X-Google-Smtp-Source: AGHT+IEk8kkUHQ8MJb1uXCKzpyAgxVOkjWfhWRHsXmy6Twh6aR2kkc//jeCTboYwBMdncRdSMRaUzssHG+fNi+RnZc0=
X-Received: by 2002:a05:6102:809:b0:470:432c:282e with SMTP id
 g9-20020a056102080900b00470432c282emr6224724vsb.18.1709000261519; Mon, 26 Feb
 2024 18:17:41 -0800 (PST)
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
 <19758162-be5f-4dc4-b316-77b0115d12ce@intel.com>
In-Reply-To: <19758162-be5f-4dc4-b316-77b0115d12ce@intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 27 Feb 2024 15:17:30 +1300
Message-ID: <CAGsJ_4wx72KOazANBvnGcjdZse8W9+PW5_fspP9=QuX3X_7msg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
To: Yin Fengwei <fengwei.yin@intel.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Lance Yang <ioworker0@gmail.com>, 
	David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mhocko@suse.com, minchan@kernel.org, peterx@redhat.com, 
	shy828301@gmail.com, songmuchun@bytedance.com, wangkefeng.wang@huawei.com, 
	zokeefe@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 2:51=E2=80=AFPM Yin Fengwei <fengwei.yin@intel.com>=
 wrote:
>
>
>
> On 2/27/24 04:49, Barry Song wrote:
> > On Tue, Feb 27, 2024 at 2:04=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>
> >> On 26/02/2024 08:55, Lance Yang wrote:
> >>> Hey David,
> >>>
> >>> Thanks for your suggestion!
> >>>
> >>> On Mon, Feb 26, 2024 at 4:41=E2=80=AFPM David Hildenbrand <david@redh=
at.com> wrote:
> >>>>
> >>> [...]
> >>>>> On Mon, Feb 26, 2024 at 12:00=E2=80=AFPM Barry Song <21cnbao@gmail.=
com> wrote:
> >>>>> [...]
> >>>>>> On Mon, Feb 26, 2024 at 1:33=E2=80=AFAM Lance Yang <ioworker0@gmai=
l.com> wrote:
> >>>>> [...]
> >>> [...]
> >>>>> +static inline bool pte_range_cont_mapped(pte_t *pte, unsigned long=
 nr)
> >>>>> +{
> >>>>> +     pte_t pte_val;
> >>>>> +     unsigned long pfn =3D pte_pfn(pte);
> >>>>> +     for (int i =3D 0; i < nr; i++) {
> >>>>> +             pte_val =3D ptep_get(pte + i);
> >>>>> +             if (pte_none(pte_val) || pte_pfn(pte_val) !=3D (pfn +=
 i))
> >>>>> +                     return false;
> >>>>> +     }
> >>>>> +     return true;
> >>>>> +}
> >>>>
> >>>> I dislike the "cont mapped" terminology.
> >>>>
> >>>> Maybe folio_pte_batch() does what you want?
> >>>
> >>> folio_pte_batch() is a good choice. Appreciate it!
> >>
> >> Agreed, folio_pte_batch() is likely to be widely useful for this chang=
e and
> >> others, so suggest exporting it from memory.c and reusing as is if pos=
sible.
> >
> > I actually missed folio_pte_batch() in cont-pte series and re-invented
> > a function
> > to check if a large folio is entirely mapped in MADV_PAGEOUT[1]. export=
ing
> > folio_pte_batch() will also benefit that case. The problem space is sam=
e.
> >
> > [1] https://lore.kernel.org/linux-mm/20240118111036.72641-7-21cnbao@gma=
il.com/
> I am wondering whether we can delay large folio split till page reclaim p=
hase
> for madvise cases.
>
> Like if we hit folio which is partially mapped to the range, don't split =
it but
> just unmap the mapping part from the range. Let page reclaim decide wheth=
er
> split the large folio or not (If it's not mapped to any other range,it wi=
ll be
> freed as whole large folio. If part of it still mapped to other range,pag=
e reclaim
> can decide whether to split it or ignore it for current reclaim cycle).

Yes, we can. but we still have to play the ptes check game to avoid adding
folios multiple times to reclaim the list.

I don't see too much difference between splitting in madvise and splitting
in vmscan.  as our real purpose is avoiding splitting entirely mapped
large folios. for partial mapped large folios, if we split in madvise, then
we don't need to play the game of skipping folios while iterating PTEs.
if we don't split in madvise, we have to make sure the large folio is only
added in reclaimed list one time by checking if PTEs belong to the
previous added folio.

>
> Splitting does work here. But it just drops all the benefits of large fol=
io.
>
>
> Regards
> Yin, Fengwei
>
> >
> >>
> >>>
> >>> Best,
> >>> Lance
> >>>
> >>>>
> >>>> --
> >>>> Cheers,
> >>>>
> >>>> David / dhildenb
> >
Thanks
Barry

