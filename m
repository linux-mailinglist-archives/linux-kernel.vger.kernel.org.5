Return-Path: <linux-kernel+bounces-30419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2582B831E6B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0051F210A1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8222D047;
	Thu, 18 Jan 2024 17:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HJRezMYj"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00BF2D03D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 17:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705599054; cv=none; b=uMvrNqf7FM5cZw3hVUYBs3ToXqwJEALRVGqHv2/awEqbZVgE1p036/xpQZp34GGwHhICvg8PuLrpZfTkW7uQw9hqOyCw70fErsoU9M57IsgkIP+5FVJcyHezvxUmTK9evRH8TDiK+IUhL11/OmtrR8vTkr97ipo+zCuEEO/xVMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705599054; c=relaxed/simple;
	bh=YVukkp6Ty8xmn33aJ2CAd5z1se/6rMDA1u79jM3rJ6Q=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=ibFg9/csRQrSGiPCdvZ3BPyBv4zAHzKpK8RhX8VTdnkDFNFStn7tvQrEyg8uN7vxETpCsLyk0wYN3S2uP8o01lzw77eLzub5C5NcjW/MzxGrnWOgYGfLCXJ7s6n2ZWnp1eG392dHJfT5am3sPymMxt93cHaC/Vm2KyJel1/l8CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HJRezMYj; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2c375d2430so1046502966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 09:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705599051; x=1706203851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZ8+aWnS6wpwgfnA94ITk/n+W7jq2mwNVOlBfkoNPGg=;
        b=HJRezMYjvD3u32A09tKZXH4iwRd+pipu6x9q2n3l86yBjO8l76NyK3B1IK2ptfo/zN
         VLwJEllWeq2girnqFejvBZKp9f/AMsVITC//xdB8qOJEJT0CEoRTJbfdiKdiz3GelFgR
         4FXCW2Ktq9y+DHswf007owvU7p/PxwnvehacAAhdMGWMjgH3vUeNTLiHm3LKYTaVT5qf
         AXVOKfGKxPM0t3r7o2jhRv4sSNaGfmWmPwjyoHPyrgJJAxKxAWT3+gXsp6DnIFier9kj
         nEPZx2QsYYauGlHlOwtYiW+mo1Sroj3LO1qW9jzCvQT6bUUXgvvryjZR4FZOEvw3GCOW
         rL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705599051; x=1706203851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZ8+aWnS6wpwgfnA94ITk/n+W7jq2mwNVOlBfkoNPGg=;
        b=RLdKy3l/nbgAhDMVNnE8OcZPPtCE8KQxPpA7+8FID7AnpZssX4sMQB91PUTxPOjqB5
         5jfU4IaRHRFo90xdiDc10d/ztVTM1BsBDLtYiEDTBkr7/AByz1QMRNZ03QA/JFVlJmDb
         7pYreFuLAHjnFS1cPUu/3yIp3lQXlWTSp2mnG9QGsDuuTlhhrOtJAP1j1kBgZf7tOcFq
         dvobHFtTKnJNwQf5renK827plI5DbxJ5wyTASh5vqGLkOOq3jZuNi7VzrxBFNDHWUANe
         U6dPeTwXe/uk6jYmEKpXnj7xJe4C2ngy94GeFXBDCWNp2wx14GXdc4cHOZotJ7vK8Qx5
         /DEg==
X-Gm-Message-State: AOJu0YycGBuUGoEqTOr34rNwGVl8h1lygCVY3U8h6CrLjxQ6MhxS/tS0
	umMTciBx2zGfUnT4AQpBJ3DL2RJdC1XXWHmylYUnqCl1cIdOPq5OahaBu7OOJvEeYWiQSpeNUIy
	auLHXC4d8pzcagZi+aBZYW8pUx0cpLwp8A9+y
X-Google-Smtp-Source: AGHT+IG7js52JDOKOth2ogk5zWVsYxaGZLs0gFbl1NLyC22gqAcaQk7pm9ZXvlpEMKYF0N87+x3Ziyr2ZnIXH+7G5dc=
X-Received: by 2002:a17:906:c109:b0:a2a:1343:5b18 with SMTP id
 do9-20020a170906c10900b00a2a13435b18mr822061ejc.86.1705599050944; Thu, 18 Jan
 2024 09:30:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-b4-zswap-lock-optimize-v1-0-23f6effe5775@bytedance.com>
 <CAJD7tkY7Xvjg37EEw2M=uRknphY0pf3ZVpyX2s2QyiJ=Axhihw@mail.gmail.com> <20240118153425.GI939255@cmpxchg.org>
In-Reply-To: <20240118153425.GI939255@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 18 Jan 2024 09:30:12 -0800
Message-ID: <CAJD7tkY48=2-4_iG6c-FcbzT3EBriem2spOFTTpGMfqmOmsx2Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm/zswap: optimize the scalability of zswap rb-tree
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Chengming Zhou <zhouchengming@bytedance.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Chris Li <chriscli@google.com>, Nhat Pham <nphamcs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 7:34=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Wed, Jan 17, 2024 at 10:37:22AM -0800, Yosry Ahmed wrote:
> > On Wed, Jan 17, 2024 at 1:23=E2=80=AFAM Chengming Zhou
> > <zhouchengming@bytedance.com> wrote:
> > >
> > > When testing the zswap performance by using kernel build -j32 in a tm=
pfs
> > > directory, I found the scalability of zswap rb-tree is not good, whic=
h
> > > is protected by the only spinlock. That would cause heavy lock conten=
tion
> > > if multiple tasks zswap_store/load concurrently.
> > >
> > > So a simple solution is to split the only one zswap rb-tree into mult=
iple
> > > rb-trees, each corresponds to SWAP_ADDRESS_SPACE_PAGES (64M). This id=
ea is
> > > from the commit 4b3ef9daa4fc ("mm/swap: split swap cache into 64MB tr=
unks").
> > >
> > > Although this method can't solve the spinlock contention completely, =
it
> > > can mitigate much of that contention. Below is the results of kernel =
build
> > > in tmpfs with zswap shrinker enabled:
> > >
> > >      linux-next  zswap-lock-optimize
> > > real 1m9.181s    1m3.820s
> > > user 17m44.036s  17m40.100s
> > > sys  7m37.297s   4m54.622s
> > >
> > > So there are clearly improvements. And it's complementary with the on=
going
> > > zswap xarray conversion by Chris. Anyway, I think we can also merge t=
his
> > > first, it's complementary IMHO. So I just refresh and resend this for
> > > further discussion.
> >
> > The reason why I think we should wait for the xarray patch(es) is
> > there is a chance we may see less improvements from splitting the tree
> > if it was an xarray. If we merge this series first, there is no way to
> > know.
>
> I mentioned this before, but I disagree quite strongly with this
> general sentiment.
>
> Chengming's patches are simple, mature, and have convincing
> numbers. IMO it's poor form to hold something like that for "let's see
> how our other experiment works out". The only exception would be if we
> all agree that the earlier change flies in the face of the overall
> direction we want to pursue, which I don't think is the case here.

My intention was not to delay merging these patches until the xarray
patches are merged in. It was only to wait until the xarray patches
are *posted*, so that we can redo the testing on top of them and
verify that the gains are still there. That should have been around
now, but the xarray patches were posted in a form that does not allow
this testing (because we still have a lock on the read path), so I am
less inclined.

My rationale was that if the gains from splitting the tree become
minimal after we switch to an xarray, we won't know. It's more
difficult to remove optimizations than to add them, because we may
cause a regression. I am kind of paranoid about having code sitting
around that we don't have full information about how much it's needed.

In this case, I suppose we can redo the testing (1 tree vs. split
trees) once the xarray patches are in a testable form, and before we
have formed any strong dependencies on the split trees (we have time
until v6.9 is released, I assume).

How about that?

>
> With the xarray we'll still have a per-swapfile lock for writes. That
> lock is the reason SWAP_ADDRESS_SPACE segmentation was introduced for
> the swapcache in the first place. Lockless reads help of course, but
> read-only access to swap are in the minority - stores will write, and
> loads are commonly followed by invalidations. Somebody already went
> through the trouble of proving that xarrays + segmentation are worth
> it for swap load and store access patterns. Why dismiss that?

Fair point, although I think the swapcache lock may be more contended
than the zswap tree lock.

> So my vote is that we follow the ususal upstreaming process here:
> merge the ready patches now, and rebase future work on top of it.

No objections given the current state of the xarray patches as I
mentioned earlier, but I prefer we redo the testing once possible with
the xarray.

