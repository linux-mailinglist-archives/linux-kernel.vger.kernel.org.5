Return-Path: <linux-kernel+bounces-116762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3D988A37E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 951EC1F3D815
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADAA159904;
	Mon, 25 Mar 2024 10:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kNbIrp1B"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8075176023
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711359649; cv=none; b=NV3TI0T+WYrHETx4zXcV/wXugc/788A8rHRZdbz2+p7dfn/Psz6UnkImtHVBiULVRMM5eU3y+rjVuzC6OIX+9s4WIL3ANObjWdq4fuZeBXczF91gD9HlaRCXnCjEaW6x5xfK2lwwS9kntk8k6ME4sHu+5OGj3F8YxOVU7Jt1ubo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711359649; c=relaxed/simple;
	bh=k/kvwbqjuI6Biup2Czt4MRAGfiEuJJwavDIry0t7w5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ETNNIgQlG3VDaehG2uJCqpmdLAhimQX3JUM0zfq/RNSB9P9RTd5SknKAE7KPn+46GVlxhOtMjNdVV6QB6oatoOlC06h1+7dqhijAuwNjkxToleIB0rVPtFKiY0Y9/zTD/Vu+wDggB2O8QBuIedgELKhDcAP5pkw97pl2XyDLDnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kNbIrp1B; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a4644bde1d4so549431766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 02:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711359646; x=1711964446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWb0tkOtTuLiN7G14PNBlPOOupfOoAoEKqcNpPczYPU=;
        b=kNbIrp1BFBssP3quaFLNHjy77OhxL5ceqzOC9dmrsVmE4fTj3Pw1D8ELMWr25Phafm
         bvPqspS97t+z9iv2tiaXGiB+Xy0Q3bAiGiyRxpph7ZPtEwxuXqEHpFUIFjUQgTZPhBn2
         fhXe10IijG+07dMlgKaJhDqjURzKCsdyAc3z/daL1T8IOCAINGGC6sVDGS1N5Wx8ZmIm
         6RR+N9yhtg4pWRvioPGsaCzt62m/OIMVDRIklsfajRyRRoQIfIL8rA4h51phcF1Tn20e
         yMeSLAfrdWoXpAIFuYkLpeFj0OHgbSf1d79wrkyvY27FRyo7ALWwKG3+iu1vARZOTHvY
         +F8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711359646; x=1711964446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWb0tkOtTuLiN7G14PNBlPOOupfOoAoEKqcNpPczYPU=;
        b=TOim3DqdRPzxDgDLCKhvPIHBkIrmJQgnIs77bO/dy0kJj3n7WxFnPXd+M15ukHVcB3
         wMCH96u5cw4zyxLhA1Oq98//OnGLp8ylTlIO3zL7P54AxcTvKPcn/axuEJf6JPMhMCUs
         r6xVCrmzRp15TdgbRo/rq5MmBe5loMIpAP/EKTOebl177w8/2aUwhsoj3hsZDMO6R7Lp
         AIvYiWAFPoJ2LvKqytX72rLzLvAiYqsZDamtD8MOtlQYRHDT6sFCbRBkGU2ryMueFD3j
         h2o6wQeobA6hoUN6h3u1PIKbww9AG+GBRW2GKYtz4epnk5y5HBTXPpKOSME3J4I8cPIE
         lb1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhAMk6+NqgQseF6TUWAtA0jw0X6xw6nF0FpL9bu4NsaTDwexUYVwIJkX3jVP3xVYEOIpMHDO3caL93ptx26uWZL21l3RXoo6GGHa5M
X-Gm-Message-State: AOJu0Yxw1lIiqNglSPtBadWHnhExjNu5+q43V7DB6L8EbkQWtiI2awMg
	hzN6GfzF5voKmEb6dwFbrfyVbkgvs9+9wtkZGzzHGyGswZpCsVmdiSUDZogd0k8k2bqhNop60c5
	TefoWRGozv2GgbSz0yHWj2p9CWvs6mR8Mw8a5
X-Google-Smtp-Source: AGHT+IEtlmX9IKU2k8X3a1hYN0MJCPSuOw+XaYGopOCUJ55JbRETnjldqTB1OByt1d/JtBkryLPJzQYYGn9eqeZ6m1k=
X-Received: by 2002:a17:906:dfcf:b0:a46:9ae2:1927 with SMTP id
 jt15-20020a170906dfcf00b00a469ae21927mr4464655ejc.67.1711359645679; Mon, 25
 Mar 2024 02:40:45 -0700 (PDT)
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
 <d556ec84-da6a-4486-a68e-5982baf46879@linux.dev>
In-Reply-To: <d556ec84-da6a-4486-a68e-5982baf46879@linux.dev>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 25 Mar 2024 02:40:09 -0700
Message-ID: <CAJD7tkbNWeoNnkB7Q1z9-XdrE1L4_2okdjFGvLjnuwoXT9XmwA@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: fix data loss on SWP_SYNCHRONOUS_IO devices
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Barry Song <21cnbao@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Zhongkun He <hezhongkun.hzk@bytedance.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Chris Li <chrisl@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 2:22=E2=80=AFAM Chengming Zhou <chengming.zhou@linu=
x.dev> wrote:
>
> On 2024/3/25 16:38, Yosry Ahmed wrote:
> > On Mon, Mar 25, 2024 at 12:33=E2=80=AFAM Chengming Zhou
> > <chengming.zhou@linux.dev> wrote:
> >>
> >> On 2024/3/25 15:06, Yosry Ahmed wrote:
> >>> On Sun, Mar 24, 2024 at 9:54=E2=80=AFPM Barry Song <21cnbao@gmail.com=
> wrote:
> >>>>
> >>>> On Mon, Mar 25, 2024 at 10:23=E2=80=AFAM Yosry Ahmed <yosryahmed@goo=
gle.com> wrote:
> >>>>>
> >>>>> On Sun, Mar 24, 2024 at 2:04=E2=80=AFPM Johannes Weiner <hannes@cmp=
xchg.org> wrote:
> >>>>>>
> >>>>>> Zhongkun He reports data corruption when combining zswap with zram=
.
> >>>>>>
> >>>>>> The issue is the exclusive loads we're doing in zswap. They assume
> >>>>>> that all reads are going into the swapcache, which can assume
> >>>>>> authoritative ownership of the data and so the zswap copy can go.
> >>>>>>
> >>>>>> However, zram files are marked SWP_SYNCHRONOUS_IO, and faults will=
 try
> >>>>>> to bypass the swapcache. This results in an optimistic read of the
> >>>>>> swap data into a page that will be dismissed if the fault fails du=
e to
> >>>>>> races. In this case, zswap mustn't drop its authoritative copy.
> >>>>>>
> >>>>>> Link: https://lore.kernel.org/all/CACSyD1N+dUvsu8=3DzV9P691B9bVq33=
erwOXNTmEaUbi9DrDeJzw@mail.gmail.com/
> >>>>>> Reported-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
> >>>>>> Fixes: b9c91c43412f ("mm: zswap: support exclusive loads")
> >>>>>> Cc: stable@vger.kernel.org      [6.5+]
> >>>>>> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> >>>>>> Tested-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
> >>>>
> >>>> Acked-by: Barry Song <baohua@kernel.org>
> >>>>
> >>>>>
> >>>>> Do we also want to mention somewhere (commit log or comment) that
> >>>>> keeping the entry in the tree is fine because we are still protecte=
d
> >>>>> from concurrent loads/invalidations/writeback by swapcache_prepare(=
)
> >>>>> setting SWAP_HAS_CACHE or so?
> >>>>
> >>>> It seems that Kairui's patch comprehensively addresses the issue at =
hand.
> >>>> Johannes's solution, on the other hand, appears to align zswap behav=
ior
> >>>> more closely with that of a traditional swap device, only releasing =
an entry
> >>>> when the corresponding swap slot is freed, particularly in the sync-=
io case.
> >>>
> >>> It actually worked out quite well that Kairui's fix landed shortly
> >>> before this bug was reported, as this fix wouldn't have been possible
> >>> without it as far as I can tell.
> >>>
> >>>>
> >>>> Johannes' patch has inspired me to consider whether zRAM could achie=
ve
> >>>> a comparable outcome by immediately releasing objects in swap cache
> >>>> scenarios.  When I have the opportunity, I plan to experiment with z=
RAM.
> >>>
> >>> That would be interesting. I am curious if it would be as
> >>> straightforward in zram to just mark the folio as dirty in this case
> >>> like zswap does, given its implementation as a block device.
> >>>
> >>
> >> This makes me wonder who is responsible for marking folio dirty in thi=
s swapcache
> >> bypass case? Should we call folio_mark_dirty() after the swap_read_fol=
io()?
> >
> > In shrink_folio_list(), we try to add anonymous folios to the
> > swapcache if they are not there before checking if they are dirty.
> > add_to_swap() calls folio_mark_dirty(), so this should take care of
>
> Right, thanks for your clarification, so should be no problem here.
> Although it was a fix just for MADV_FREE case.
>
> > it. There is an interesting comment there though. It says that PTE
> > should be dirty, so unmapping the folio should have already marked it
> > as dirty by the time we are adding it to the swapcache, except for the
> > MADV_FREE case.
>
> It seems to say the folio will be dirtied when unmap later, supposing the
> PTE is dirty.

Oh yeah it could mean that the folio will be dirted later.

>
> >
> > However, I think we actually unmap the folio after we add it to the
> > swapcache in shrink_folio_list(). Also, I don't immediately see why
> > the PTE would be dirty. In do_swap_page(), making the PTE dirty seems
>
> If all anon pages on LRU list are faulted by write, it should be true.
> We could just use the zero page if faulted by read, right?

This applies for the initial fault that creates the folio, but this is
a swap fault. It could be a read fault and in that case we still need
to make the folio dirty because it's not in the swapcache and we need
to write it out if it's reclaimed, right?

>
> > to be conditional on the fault being a write fault, but I didn't look
> > thoroughly, maybe I missed it. It is also possible that the comment is
> > just outdated.
>
> Yeah, dirty is only marked on write fault.
>
> Thanks.

