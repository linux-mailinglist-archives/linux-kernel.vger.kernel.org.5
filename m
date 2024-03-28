Return-Path: <linux-kernel+bounces-123828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8967890E85
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FCF6297953
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79038134723;
	Thu, 28 Mar 2024 23:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8/Lc54l"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8F2225A8
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 23:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711668851; cv=none; b=M//xgNyHQdRy0AQUM6sy5BaoTi3KwvouRX5dPIXnSKb+7/bfkTK2OPbznHfg0olFyM6xURXyPaxb2sUKzZk6i8XFFCQQYPZO16ceeDUpT6sOX535ljJI+Cnpa0Aa5WoWYsCVDe4oM2ItaTCZ983ckuaTNPFjiPhtxEqSGufOB9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711668851; c=relaxed/simple;
	bh=C0vfLm3NW8ZD1FDyR6caYtL9NDE7pnfmrvQvlrGMuR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K0fipXGpaAZkIP8KSjrLv2/O42BjpZdpVV6ExWj/TU9a1T6lZaelUZGkIhxV1eh++rn2MbzIO6GvsAIA0IOoc9tOnro59gJcuIVrofbSUmbxL0ex4z0ovmdL2MVru/u+3Ca9XQRz4i3OT2d2YR0dgU7GtVnlwh3hjmZHLOnzokE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8/Lc54l; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcbcea9c261so1566164276.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711668848; x=1712273648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lg0vRMRZ2AJ1Ywawe8tBv3q95N1qJc+fec6wM/OwqTk=;
        b=G8/Lc54lO8Ibdn8PDt6XUEREcZbA96d9+9h4I65PF+ikapPvqbJPY5WY88t55S8ogX
         mOZVu8snIXSOpZBuI33Zn0jn5gkpik2tr9KCqFDnlx5hVoWC6dAGREzh9kzrwUmAdg7N
         y0XFqtDO8OCuolcxvz4kq7VhPCGCtiFKDMsNMWt+mYRibncDrco4YnbU+gxBoh1+/FXv
         9H6Tvk1ySaVBBEbeqnwfkPVSex9tpZlBrnA9vOWUQ3TZd6GTlwBr6xrC/3sZKLgblC92
         SESRrdZqKIKSb+aKOWYfd8BzMadJ01BfQ/KtoqW+/3YBosLQqtGtZZHXhkvl3H9kJfA/
         IKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711668848; x=1712273648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lg0vRMRZ2AJ1Ywawe8tBv3q95N1qJc+fec6wM/OwqTk=;
        b=NQs1COCDqgqKPjqccqBCdAkTwa9jI9iawm3ctZBWAupDZ9JUBOTzO/2PbqbNl7lBU6
         ULqrchhXzYc3ALCO252m++YIlFsoxZYGOJeckg0geis0IDdg1b8pBh3UO5jiQ4gF+LWP
         OQRPyDeBKxqETg3sjlGpP7dTnk3cA1OIdn7b4Bv3G5UHICP+8zVxRXRkwgZSG5uhtixn
         H9r4VfyqM1alAaOMDwUcrQF6WpdX8RkENhpBDrKy4Ls6G8Jr5kM/Wy69818tCGD8QKlP
         IB+LRI/JLyrqgkblAnxw2TquqCMmQFab5pCE/angv6rLzRMILOmdP9rE/d8hU0kt+0iQ
         X31g==
X-Forwarded-Encrypted: i=1; AJvYcCUZ8YDMp9jM1/du9oeg5WclaAtv9jxjRj63NrPlydFTNsMSou07HTM7j/3z8DvM6Ov/yTCbzsbl18/Ysoc2Milkp0l/Q/1oX0MJHmLx
X-Gm-Message-State: AOJu0YyeLtgOhZS2BAy3nmjRSwZq5rAJUPgUmXMCKwuiSlPCd4nI6Aal
	XFA0V+zkz3TX8fyMVCTLVRHoj2WozPFUB0buxIqQMPUwkuTFYANo9PEMp2h4pN3cKyYBzAaBJ/w
	5w5alfERl9qVCLWBf8BK1NYmTaheVIKWll9sYYQ==
X-Google-Smtp-Source: AGHT+IFZroKdfdkZ/3TXaihYYF8xDcsSWFc+4SeXofOQvSknJ2YbPbMGwpmIA0VixorTvtOQR+0iLC8GmWBazaMm4BM=
X-Received: by 2002:a25:ab53:0:b0:dcf:f4d3:3a16 with SMTP id
 u77-20020a25ab53000000b00dcff4d33a16mr828266ybi.45.1711668848154; Thu, 28 Mar
 2024 16:34:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325235018.2028408-1-yosryahmed@google.com>
 <20240325235018.2028408-7-yosryahmed@google.com> <20240328193149.GF7597@cmpxchg.org>
 <CAJD7tkaFmbnt4YNWvgGZHo=-JRu-AsUWvCYCRXVZxOPvcSJRDw@mail.gmail.com>
In-Reply-To: <CAJD7tkaFmbnt4YNWvgGZHo=-JRu-AsUWvCYCRXVZxOPvcSJRDw@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 28 Mar 2024 16:33:57 -0700
Message-ID: <CAKEwX=MTO40L+wVtUzmy24iGKq5FkGnSgYVj+vrcokTnYBE-tg@mail.gmail.com>
Subject: Re: [RFC PATCH 6/9] mm: zswap: drop support for non-zero same-filled
 pages handling
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 1:24=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Thu, Mar 28, 2024 at 12:31=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.=
org> wrote:
> >
> > On Mon, Mar 25, 2024 at 11:50:14PM +0000, Yosry Ahmed wrote:
> > > The current same-filled pages handling supports pages filled with any
> > > repeated word-sized pattern. However, in practice, most of these shou=
ld
> > > be zero pages anyway. Other patterns should be nearly as common.
> > >
> > > Drop the support for non-zero same-filled pages, but keep the names o=
f
> > > knobs exposed to userspace as "same_filled", which isn't entirely
> > > inaccurate.
> > >
> > > This yields some nice code simplification and enables a following pat=
ch
> > > that eliminates the need to allocate struct zswap_entry for those pag=
es
> > > completely.
> > >
> > > There is also a very small performance improvement observed over 50 r=
uns
> > > of kernel build test (kernbench) comparing the mean build time on a
> > > skylake machine when building the kernel in a cgroup v1 container wit=
h a
> > > 3G limit:
> > >
> > >               base            patched         % diff
> > > real          70.167          69.915          -0.359%
> > > user          2953.068        2956.147        +0.104%
> > > sys           2612.811        2594.718        -0.692%
> > >
> > > This probably comes from more optimized operations like memchr_inv() =
and
> > > clear_highpage(). Note that the percentage of zero-filled pages durin=
g
> > > this test was only around 1.5% on average, and was not affected by th=
is
> > > patch. Practical workloads could have a larger proportion of such pag=
es
> > > (e.g. Johannes observed around 10% [1]), so the performance improveme=
nt
> > > should be larger.
> > >
> > > [1]https://lore.kernel.org/linux-mm/20240320210716.GH294822@cmpxchg.o=
rg/
> > >
> > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> >
> > This is an interesting direction to pursue, but I actually thinkg it
> > doesn't go far enough. Either way, I think it needs more data.
> >
> > 1) How frequent are non-zero-same-filled pages? Difficult to
> >    generalize, but if you could gather some from your fleet, that
> >    would be useful. If you can devise a portable strategy, I'd also be
> >    more than happy to gather this on ours (although I think you have
> >    more widespread zswap use, whereas we have more disk swap.)
>
> I am trying to collect the data, but there are.. hurdles. It would
> take some time, so I was hoping the data could be collected elsewhere
> if possible.
>
> The idea I had was to hook a BPF program to the entry of
> zswap_fill_page() and create a histogram of the "value" argument. We
> would get more coverage by hooking it to the return of
> zswap_is_page_same_filled() and only updating the histogram if the
> return value is true, as it includes pages in zswap that haven't been
> swapped in.
>
> However, with zswap_is_page_same_filled() the BPF program will run in
> all zswap stores, whereas for zswap_fill_page() it will only run when
> needed. Not sure if this makes a practical difference tbh.
>
> >
> > 2) The fact that we're doing any of this pattern analysis in zswap at
> >    all strikes me as a bit misguided. Being efficient about repetitive
> >    patterns is squarely in the domain of a compression algorithm. Do
> >    we not trust e.g. zstd to handle this properly?
>
> I thought about this briefly, but I didn't follow through. I could try
> to collect some data by swapping out different patterns and observing
> how different compression algorithms react. That would be interesting
> for sure.
>
> >
> >    I'm guessing this goes back to inefficient packing from something
> >    like zbud, which would waste half a page on one repeating byte.
> >
> >    But zsmalloc can do 32 byte objects. It's also a batching slab
> >    allocator, where storing a series of small, same-sized objects is
> >    quite fast.
> >
> >    Add to that the additional branches, the additional kmap, the extra
> >    scanning of every single page for patterns - all in the fast path
> >    of zswap, when we already know that the vast majority of incoming
> >    pages will need to be properly compressed anyway.
> >
> >    Maybe it's time to get rid of the special handling entirely?
>
> We would still be wasting some memory (~96 bytes between zswap_entry
> and zsmalloc object), and wasting cycling allocating them. This could
> be made up for by cycles saved by removing the handling. We will be
> saving some branches for sure. I am not worried about kmap as I think
> it's a noop in most cases.

A secondary effect of the current same-filled page handling is that
we're not considering them for reclaim. Which could potentially be
beneficial, because we're not saving much memory (essentially just the
zswap entry and associated cost of storing them) by writing these
pages back - IOW, the cost / benefit ratio for reclaiming these pages
is quite atrocious.

Again, all of this is just handwaving without numbers. It'd be nice if
we can have more concrete data for this conversation :P

