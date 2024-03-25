Return-Path: <linux-kernel+bounces-117722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D8F88AECE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83B151FA3CB7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EC96FDC;
	Mon, 25 Mar 2024 18:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rGd1qetv"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862954A2D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 18:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711391749; cv=none; b=iigdfDqNQKS9JKyhGgx9X5BiSGdSMVQA3HwXF5pPcu1ys8rlQlZ27gMFLU+QYPYwM3VHijBe1vO+8fberlBwEcTZgjrHLWIMIV3sK3i+2jA8thE2uAhBhxnZnF0c9H9hXSqXxriBF4gSCdTe32dZPHYI9HdRUXyVMvoCktt7+io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711391749; c=relaxed/simple;
	bh=h0yilnZ51BaEqGj5t3UHWGeuntB/GTqaVwYDJFg8lM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qaPHD/wdc40eX4h4bigWJC1wO6TGNOEkVrCEHIWk282aAIqThWpXDU4IoHAumaBViGFTJqldI/4Z4j//i/lVkB0r4GZR/KCKfrzA6w9h8rNIL/HvN7CiuAlvW9aX40PCU+HIZaZVyaRm1o1d+FZBuE50wBkfu+2WMS6lEUZvaQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rGd1qetv; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a47385a4379so495483766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 11:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711391746; x=1711996546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VnaO12DYPd96KK0ZxyUCj9krmBaYuVzmySYDUn5xLRY=;
        b=rGd1qetv55U0qhS2zkCYGtiAr0WqGVBv7A6yL04lXUvlDSyJbk7HBPmuDfBQKXjAKL
         M8z3vPA/puXX3FtQ2mnLh9SjOas+kxuFEHSAD+ldhJyOvmZZ72z3NZyH/wpTZj0mPaOx
         QoFWtRRlW1d4NPptl50n0r3oQAEDPlV7OFX/OlvX9UzxCvbXJ0lv0zh3q9FoBDIc0VKn
         /+12IhHIYbiBiHxX7+/c2VIYusPNhmkuhaYdm8ztBBxw5iIPGLKaS4yHdUYds9fODrq4
         pwCO5cb6ejJqAwyfFCe6wnfGs7CzrQU/PepgToMcjLJENM+6DZIXS8jUhkVCqzyANRVy
         YiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711391746; x=1711996546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VnaO12DYPd96KK0ZxyUCj9krmBaYuVzmySYDUn5xLRY=;
        b=X1hA3syUQ0fr6+ngzY0fCyLS/1gcNOMIkPbawlKTxJ81sau2nlNWe5G+dbFsORHyty
         0xiHrkv9mWXVdId8IKgq/UZsIefqM907GXZexJDn+fbkuBRMqDqPfPJNicKbjT1QTe74
         Ji88q87QIpPUPwSId/VvU9YGklJloQtKWhDMD4tvtYRO174jQfeM9Om9U7IVqI1ywqgS
         DjhljjMgiehEvfGoQib27jvevNuHkJZSbzO9b9YLsWhOeQKnKSfU0oGSJPiLOd9iExlV
         XMZ3RBm9iRPADa5KXzcbtT23DzZGUfqRC1i/CGuDCOSYo3djFKVVy+5y6MLwqv0ULW90
         hX6g==
X-Forwarded-Encrypted: i=1; AJvYcCUYl2i7Rgaw2ZiI3OFWItmlvYVO8dDWSCW+BYm4MulwJvSbIEQS8I/qEZs1GgLpCpP5oq3b1/Fx+c+6qe3muMUK1Qwpj/jCKOulb3PI
X-Gm-Message-State: AOJu0YzUXd1sxCS0Bxyu7ObUW83wx7VOGoMZe5WuOJv6BDgmNb0U/8hW
	px67Ukx9bBQ8ACQZpKdN5V6eVDQ/Lc3yfgE9gdk2/TIpJ0/y6qT1MPx4WRgfBuXnBNaFa66MjlL
	3id35yc2lRg+7VVBmBCd7GL93KInlGk6coQ/yCuRSLZIaEt6WoWTs
X-Google-Smtp-Source: AGHT+IEG4khKur4No7fwruiwfnOnyHPfaZKYoeBWu8Ce3T4gznyAzpX/p3EocHUe/K7sGfTaoxu9DnIVdLzkNo5JMRA=
X-Received: by 2002:a17:907:9722:b0:a47:48d7:d393 with SMTP id
 jg34-20020a170907972200b00a4748d7d393mr6682243ejc.33.1711391745531; Mon, 25
 Mar 2024 11:35:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324210447.956973-1-hannes@cmpxchg.org> <CAJD7tkaWQAV=X1pzYG=VkWe7Ue9ZFbjt9uQ5m1NJujtLspWJTA@mail.gmail.com>
 <CAGsJ_4yeBmNsMGXEWwC+1Hs5zJUP+becq4wG+6CpU7V1=EOvhg@mail.gmail.com>
 <CAJD7tka5K69q20bxTsBk38JC7mdPr3UsxXpsnggDO_iQA=qxug@mail.gmail.com>
 <1e7ce417-b9dd-4d62-9f54-0adf1ccdae35@linux.dev> <CAJD7tkYc3oFho5eEkS1zmr_+CC-Ag1HucUTyAy2RJbEb4SqRoQ@mail.gmail.com>
 <d556ec84-da6a-4486-a68e-5982baf46879@linux.dev> <CAJD7tkbNWeoNnkB7Q1z9-XdrE1L4_2okdjFGvLjnuwoXT9XmwA@mail.gmail.com>
 <339639f3-4334-44a8-a811-d20b3c578f74@linux.dev>
In-Reply-To: <339639f3-4334-44a8-a811-d20b3c578f74@linux.dev>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 25 Mar 2024 11:35:06 -0700
Message-ID: <CAJD7tkZ=fsBi_t5Hcauty_3YKraJUmGA24tSvz8LjRd=Ao--2w@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: fix data loss on SWP_SYNCHRONOUS_IO devices
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Barry Song <21cnbao@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Zhongkun He <hezhongkun.hzk@bytedance.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Chris Li <chrisl@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Kairui Song <kasong@tencent.com>, Minchan Kim <minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 2:46=E2=80=AFAM Chengming Zhou <chengming.zhou@linu=
x.dev> wrote:
>
> On 2024/3/25 17:40, Yosry Ahmed wrote:
> > On Mon, Mar 25, 2024 at 2:22=E2=80=AFAM Chengming Zhou <chengming.zhou@=
linux.dev> wrote:
> >>
> >> On 2024/3/25 16:38, Yosry Ahmed wrote:
> >>> On Mon, Mar 25, 2024 at 12:33=E2=80=AFAM Chengming Zhou
> >>> <chengming.zhou@linux.dev> wrote:
> >>>>
> >>>> On 2024/3/25 15:06, Yosry Ahmed wrote:
> >>>>> On Sun, Mar 24, 2024 at 9:54=E2=80=AFPM Barry Song <21cnbao@gmail.c=
om> wrote:
> >>>>>>
> >>>>>> On Mon, Mar 25, 2024 at 10:23=E2=80=AFAM Yosry Ahmed <yosryahmed@g=
oogle.com> wrote:
> >>>>>>>
> >>>>>>> On Sun, Mar 24, 2024 at 2:04=E2=80=AFPM Johannes Weiner <hannes@c=
mpxchg.org> wrote:
> >>>>>>>>
> >>>>>>>> Zhongkun He reports data corruption when combining zswap with zr=
am.
> >>>>>>>>
> >>>>>>>> The issue is the exclusive loads we're doing in zswap. They assu=
me
> >>>>>>>> that all reads are going into the swapcache, which can assume
> >>>>>>>> authoritative ownership of the data and so the zswap copy can go=
.
> >>>>>>>>
> >>>>>>>> However, zram files are marked SWP_SYNCHRONOUS_IO, and faults wi=
ll try
> >>>>>>>> to bypass the swapcache. This results in an optimistic read of t=
he
> >>>>>>>> swap data into a page that will be dismissed if the fault fails =
due to
> >>>>>>>> races. In this case, zswap mustn't drop its authoritative copy.
> >>>>>>>>
> >>>>>>>> Link: https://lore.kernel.org/all/CACSyD1N+dUvsu8=3DzV9P691B9bVq=
33erwOXNTmEaUbi9DrDeJzw@mail.gmail.com/
> >>>>>>>> Reported-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
> >>>>>>>> Fixes: b9c91c43412f ("mm: zswap: support exclusive loads")
> >>>>>>>> Cc: stable@vger.kernel.org      [6.5+]
> >>>>>>>> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> >>>>>>>> Tested-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
> >>>>>>
> >>>>>> Acked-by: Barry Song <baohua@kernel.org>
> >>>>>>
> >>>>>>>
> >>>>>>> Do we also want to mention somewhere (commit log or comment) that
> >>>>>>> keeping the entry in the tree is fine because we are still protec=
ted
> >>>>>>> from concurrent loads/invalidations/writeback by swapcache_prepar=
e()
> >>>>>>> setting SWAP_HAS_CACHE or so?
> >>>>>>
> >>>>>> It seems that Kairui's patch comprehensively addresses the issue a=
t hand.
> >>>>>> Johannes's solution, on the other hand, appears to align zswap beh=
avior
> >>>>>> more closely with that of a traditional swap device, only releasin=
g an entry
> >>>>>> when the corresponding swap slot is freed, particularly in the syn=
c-io case.
> >>>>>
> >>>>> It actually worked out quite well that Kairui's fix landed shortly
> >>>>> before this bug was reported, as this fix wouldn't have been possib=
le
> >>>>> without it as far as I can tell.
> >>>>>
> >>>>>>
> >>>>>> Johannes' patch has inspired me to consider whether zRAM could ach=
ieve
> >>>>>> a comparable outcome by immediately releasing objects in swap cach=
e
> >>>>>> scenarios.  When I have the opportunity, I plan to experiment with=
 zRAM.
> >>>>>
> >>>>> That would be interesting. I am curious if it would be as
> >>>>> straightforward in zram to just mark the folio as dirty in this cas=
e
> >>>>> like zswap does, given its implementation as a block device.
> >>>>>
> >>>>
> >>>> This makes me wonder who is responsible for marking folio dirty in t=
his swapcache
> >>>> bypass case? Should we call folio_mark_dirty() after the swap_read_f=
olio()?
> >>>
> >>> In shrink_folio_list(), we try to add anonymous folios to the
> >>> swapcache if they are not there before checking if they are dirty.
> >>> add_to_swap() calls folio_mark_dirty(), so this should take care of
> >>
> >> Right, thanks for your clarification, so should be no problem here.
> >> Although it was a fix just for MADV_FREE case.
> >>
> >>> it. There is an interesting comment there though. It says that PTE
> >>> should be dirty, so unmapping the folio should have already marked it
> >>> as dirty by the time we are adding it to the swapcache, except for th=
e
> >>> MADV_FREE case.
> >>
> >> It seems to say the folio will be dirtied when unmap later, supposing =
the
> >> PTE is dirty.
> >
> > Oh yeah it could mean that the folio will be dirted later.
> >
> >>
> >>>
> >>> However, I think we actually unmap the folio after we add it to the
> >>> swapcache in shrink_folio_list(). Also, I don't immediately see why
> >>> the PTE would be dirty. In do_swap_page(), making the PTE dirty seems
> >>
> >> If all anon pages on LRU list are faulted by write, it should be true.
> >> We could just use the zero page if faulted by read, right?
> >
> > This applies for the initial fault that creates the folio, but this is
> > a swap fault. It could be a read fault and in that case we still need
> > to make the folio dirty because it's not in the swapcache and we need
> > to write it out if it's reclaimed, right?
>
> Yes, IMHO I think it should be marked as dirty here.
>
> But it should be no problem with that unconditional folio_mark_dirty()
> in add_to_swap(). Not sure if there are other issues.

I don't believe there are any issues now. Dirtying the folio in
add_to_swap() was introduced before SWP_SYNCHRONOUS_IO, so I guess
things have always worked.

I think we should update the comment there though to mention that
dirtying the folio is also needed for this case (not just MADV_FREE),
or dirty the PTE during the fault. Otherwise, if someone is making
MADV_FREE changes they could end up breaking SWP_SYNCHRONOUS_IO
faults.

Adding Minchan here in case he can confirm that we in fact rely on
add_to_swap()->folio_mark_dirty() for SWP_SYNCHRONOUS_IO to work as
intended.

