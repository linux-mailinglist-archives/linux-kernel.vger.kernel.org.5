Return-Path: <linux-kernel+bounces-30401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4C9831E39
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61CD1283523
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539152C841;
	Thu, 18 Jan 2024 17:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZbviJMLc"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028E92C6AA
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705598129; cv=none; b=MrjbhIQFCpBvPO2i45wwcR7ZsEP4t7+Yb0uj3jQU00yKewy2K3LZEyZAbj8GDDfJ2GmT/xi5NmGc7TRgIJgYrYgZsr3SklGumBMScymUpEUMUwUBzCu1HoyMT3T+o8Cbp9sS/Gd98ueIy6aqOxN8Ln1WOeYlgksmLuYO+3JX5tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705598129; c=relaxed/simple;
	bh=lN7vV7/dmKAYamaryRL+nfbnN17C6XVKsy/jV+DrFZc=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=lAG4eP+rSD0KIbrmGd7jnd93y65IRneTi3SJKnChfKLgbn9KztbdnXEg3wuGD+69WUWC3UDCz9GHBvs/F0QT2jlfADej8NlAQu8lvH8DdOSNYsirHivakQum77cliUOUcXCEX/VQopL4/npHmCdtTvGWmBB7nikI2FCrtgEZrzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZbviJMLc; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2c375d2430so1044311566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 09:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705598126; x=1706202926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lN7vV7/dmKAYamaryRL+nfbnN17C6XVKsy/jV+DrFZc=;
        b=ZbviJMLcDH5jR32zPw+S3/Of53IP4St0Olin5ioCbJ0L3C4wdf44Yv3g2aJhMGXLPI
         9lsUishswRb9NaekEjug9MD/Bg3JcJ5NLAvThWaHPB+vtDXVIXlOlwMrQgCIo+xJez7S
         8W9Y3vByD9zlr0xZGTB7eyEc+pDLrYfUZVK4rUGehkjOqZ8vNWiErMVKvMhCeXSNX4aF
         gv2gX3cJKdWCgxyjZyWRGd/k2KnqcsKa+OFTg1IwZ+cc57taVmexwgK7+kF3ZoD9Vruc
         71ifAQXalPuvYCCVSdWpb4i2a7vyJGyI160A4FjWPk6BldnFSJTa8760U0i5lIxSDzUi
         fThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705598126; x=1706202926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lN7vV7/dmKAYamaryRL+nfbnN17C6XVKsy/jV+DrFZc=;
        b=AWtSxau6MhE/TK/qnF3PGEcCVkCKaI3sMSXO4IvW3qvHzbhLSNYDaMotDAWWNSsoNH
         /8YeV0dTGoPi6dteT6Mr9EapX0jTdUdDzx1VqVQ+h9z9b3NuO15KQhXIjmLRNONaNGOB
         zyZuC72+Bi7QnxZan88h5vLxwbH77vPFTs6Qxjpm4MwNjgvMSiCVvewF2DjS0brchw7h
         4epLcQsbxym/YTLVB24p1zu4IB3ipCn3nDjJFAwiqhLCnXr2QO4gOqbzQyjkSxlGHAWX
         0QWC6CrUKLT3aL3S2CNAl/EGmBmVa+iCc5v+b6uSOo58Liqt3E8z3Su0JUBeUMULq3KX
         FP3A==
X-Gm-Message-State: AOJu0YyRv7/Jkuhj3ozBObzaeZddXcgRMHm+cOotZJzRA/1rGFBMUrVB
	YeiBBPeDLot2opEradaX2m4CgMTIYn4/vAnczur2FyJHljX0Uh3Rfk6FSYipzFb7+D3wZLATvPJ
	6bxBiSjS2BXz7XSnBAdIC2IfQyIR1fYJ824kg
X-Google-Smtp-Source: AGHT+IG4BVJJDWSpoIZFOi88PoJ7B+Bkq7LtBXjIJS3f7jogdS0H1Qb6OAuTw9O4Ar5Gz25tRxJegyW2JcD1MBHudLg=
X-Received: by 2002:a17:907:948b:b0:a2c:3d75:fb7 with SMTP id
 dm11-20020a170907948b00b00a2c3d750fb7mr935754ejc.4.1705598126089; Thu, 18 Jan
 2024 09:15:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org>
 <CAJD7tkbQb5nAQdhHXELQsUWs8KhwnoOZ7C8Eu2o7tCYSKeY9Ug@mail.gmail.com>
 <CANeU7Q=mphnSfiZRwFhqFTy56d2ifa5Pz-aa1h3O1PXUo_cu=Q@mail.gmail.com>
 <CAJD7tkaTZz9-rtYab+pvf31dprjMLstnHeXk6HZ_0C-8Np=06A@mail.gmail.com> <CAF8kJuN0WQ_n0VWub+90rj68UYGoMNG32h8OxbvLgpDrKrB1Hg@mail.gmail.com>
In-Reply-To: <CAF8kJuN0WQ_n0VWub+90rj68UYGoMNG32h8OxbvLgpDrKrB1Hg@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 18 Jan 2024 09:14:50 -0800
Message-ID: <CAJD7tkYe8XaYpCnyJxcg_W7uD2XpEUqO4LVMBCg-7grmU6DB=A@mail.gmail.com>
Subject: Re: [PATCH 0/2] RFC: zswap tree use xarray instead of RB tree
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, =?UTF-8?B?V2VpIFh177+8?= <weixugc@google.com>, 
	Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>, 
	Chun-Tse Shao <ctshao@google.com>, =?UTF-8?Q?Suren_Baghdasaryan=EF=BF=BC?= <surenb@google.com>, 
	Brain Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mel Gorman <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <kasong@tencent.com>, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Barry Song <v-songbaohua@oppo.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 11:28=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote=
:
>
> On Wed, Jan 17, 2024 at 11:05=E2=80=AFPM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> >
> > The name changes from Chris to Christopher are confusing :D
> >
> > >
> > > I think it makes the review easier. The code adding and removing does
> > > not have much overlap. Combining it to a single patch does not save
> > > patch size. Having the assert check would be useful for some bisectin=
g
> > > to narrow down which step causing the problem. I am fine with squash
> > > it to one patch as well.
> >
> > I think having two patches is unnecessarily noisy, and we add some
> > debug code in this patch that we remove in the next patch anyway.
> > Let's see what others think, but personally I prefer a single patch.
> >
> > > >
> > > > >
> > > > > I expect to merge the zswap rb tree spin lock with the xarray
> > > > > lock in the follow up changes.
> > > >
> > > > Shouldn't this simply be changing uses of tree->lock to use
> > > > xa_{lock/unlock}? We also need to make sure we don't try to lock th=
e
> > > > tree when operating on the xarray if the caller is already holding =
the
> > > > lock, but this seems to be straightforward enough to be done as par=
t
> > > > of this patch or this series at least.
> > > >
> > > > Am I missing something?
> > >
> > > Currently the zswap entry refcount is protected by the zswap tree spi=
n
> > > lock as well. Can't remove the tree spin lock without changing the
> > > refcount code. I think the zswap search entry should just return the
> > > entry with refcount atomic increase, inside the RCU read() or xarray
> > > lock. The previous zswap code does the find_and_get entry() which is
> > > closer to what I want.
> >
> > I think this can be done in an RCU read section surrounding xa_load()
>
> xa_load() already has RCU read lock inside. If you do that you might
> just as well use some XAS API to work with the lock directly.

RCU reda locks are nestable, some users of xa_load() do some in an RCU
read section, also for refcounting purposes. Also, I thought the point
was avoiding the lock in this path.

>
> > and the refcount increment. Didn't look closely to check how much
> > complexity this adds to manage refcounts with RCU, but I think there
> > should be a lot of examples all around the kernel.
>
> The complexity is not adding the refcount inside xa_load(). It is on
> the zswap code that calls zswap_search() and zswap_{insert,erase}().
> As far as I can tell, those codes need some tricky changes to go along
> with the refcount change.

I don't think it should be very tricky.
https://docs.kernel.org/RCU/rcuref.html may have relevant examples,
and there should be examples all over the code.

>
> >
> > IIUC, there are no performance benefits from this conversion until we
> > remove the tree spinlock, right?
>
> The original intent is helping the long tail case. RB tree has worse
> long tails than xarray. I expect it will help the page fault long tail
> even without removing the tree spinlock.

I think it would be better if we can remove the tree spinlock as part
of this change.

