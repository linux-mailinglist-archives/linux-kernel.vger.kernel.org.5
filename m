Return-Path: <linux-kernel+bounces-124030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C28891163
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4595C1C29AD3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB321DA52;
	Fri, 29 Mar 2024 02:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="0IgbUacF"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15701E504
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 02:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711678097; cv=none; b=lcReeTBxlKOnrNqarZZI4+msLFZ3JF4OtPXqGeaSYjJTAHdh614uoJ4qXAABuuQuF7CuZYi3X0hdw8+Bp1ODe29T+NdLl6biZ0Mbz/T4FPwykqswy/G7qJXTAr7PcsrZ/ZW0ydmPLnQYkpWSwS2bhC0W/k4zQNiFD/TEzENTATA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711678097; c=relaxed/simple;
	bh=dbO+Ap6f46J613uD6nop2tsLtl7Tou++IDmiUyD3GGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EFVMmE7sFkPVNQ9NXN72Xx85x0pNLcjU9TkAP85eoDuJgh4J8r3RnfJ97VtNoFUbxqYASPGcfRHNjHvFzhm5QjmqyE17PpYOhmDgp2tjqGv4i6XRxKe7dd2MJXxiaAxNfzs0E1NxNXIEpI+T6tgFCcDHNuZIaFJvwCFFr3Z+0rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0IgbUacF; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a474c4faf5eso183395766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 19:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711678094; x=1712282894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11c8G8lctTX5FPuHgPoxiYuBMcabHIl74EqlnLaTfGY=;
        b=0IgbUacFX9803zESS/nJkbywaWMz1I1LbQ8OI25l8ODAZ2ndQ1nFYdR4FDEiNGxJNn
         mkwexAHi2om74HsprXTOusxRERAldx1uV8rjEvT8YjBVJbFxK0XcWFG2hKFm7kU3wghb
         y0czcdZXXTI0KmgP2ruyznahtNSt993Kb+qOwXBk2WyTELfwvOUEOKxP/bvln7KDGhPN
         hQiqgwgP4Z0iF0oW5b7S6IlxIFu6B22ZH8bO2y/h9O28jktNtNvyoJicPUUXkblsPcpy
         9/a8FT6/eJlVip57rj1ILFI5BEfDL93/u1O9fyUyem0VF+vnkE7UpMkWUudhlu6JP1Af
         5y0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711678094; x=1712282894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11c8G8lctTX5FPuHgPoxiYuBMcabHIl74EqlnLaTfGY=;
        b=DyySZ6gCE3pV3b/chPflxT1T9oGXyUbBB4h/om4N4vvLh/xtUCy8qPbDB1VluRP8Wm
         09UiBcRPymeihTq/NEF9wNz7NquTXKTFTlWDYAHGQmWNv6r9Ae9OxX6n2c0sZMlt+GHu
         zJ5BdK9smkROSV8rZhipqlJlnfJsOYmFvFWj1NulxBPFxei/KiokVL6D+MmyH77G+93+
         eMDYyx3Ph++SokHvCfTqKNpSkGTsIBlWYzRVZmYEq8s1OMamWMyK1YC1CIkpkSg81p8U
         Gt+kr1VlvrMQsesel8Ba4gFJzoXRtyiilFVUZ/ajxJM5m3NnwHc/NBjg56FaM9RKLN+f
         uhaw==
X-Forwarded-Encrypted: i=1; AJvYcCWcdXAbCODTRVcdO4Lq2v0+xY8kpk38q6o1DGAEzIbq/4vsh6jyHrRHMz/nAEfQR/FBSKm0GkAjiBggL63sq01fs9DgvU90LoBXH6oy
X-Gm-Message-State: AOJu0YzeWwPEfQep93OBSGJvH9FhpvJO0KB1pCj38HlP2YcGpjKlSRhQ
	UEhJCjtPq9ZNHT96mLNmP6zMcQREnxuLY+bgNX9b2EIoPsfC2n4as+8J6dn+33ix9xWAw3op6nj
	oH74SUno/+O505EG1e1G3rEWSzogk4yB3ER3dXQw9q6aC1g7mJQ==
X-Google-Smtp-Source: AGHT+IG0Rm5qu9wJswt12/atXr3sJnHBizAISo0bEl3j1aBkAKeucvrdhtY4eTVd689T82N8PB+fhFFotaWQSZh11+M=
X-Received: by 2002:a17:906:ca0f:b0:a46:e8c1:11ac with SMTP id
 jt15-20020a170906ca0f00b00a46e8c111acmr578332ejb.18.1711678093875; Thu, 28
 Mar 2024 19:08:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325235018.2028408-1-yosryahmed@google.com>
 <20240325235018.2028408-7-yosryahmed@google.com> <20240328193149.GF7597@cmpxchg.org>
 <CAJD7tkaFmbnt4YNWvgGZHo=-JRu-AsUWvCYCRXVZxOPvcSJRDw@mail.gmail.com> <CAKEwX=MTO40L+wVtUzmy24iGKq5FkGnSgYVj+vrcokTnYBE-tg@mail.gmail.com>
In-Reply-To: <CAKEwX=MTO40L+wVtUzmy24iGKq5FkGnSgYVj+vrcokTnYBE-tg@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 28 Mar 2024 19:07:37 -0700
Message-ID: <CAJD7tkbRSiiqe1ZY6_BJBfj=7dM0xHxV3TTTJha9691uCXvWAQ@mail.gmail.com>
Subject: Re: [RFC PATCH 6/9] mm: zswap: drop support for non-zero same-filled
 pages handling
To: Nhat Pham <nphamcs@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 4:34=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Thu, Mar 28, 2024 at 1:24=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Thu, Mar 28, 2024 at 12:31=E2=80=AFPM Johannes Weiner <hannes@cmpxch=
g.org> wrote:
> > >
> > > On Mon, Mar 25, 2024 at 11:50:14PM +0000, Yosry Ahmed wrote:
> > > > The current same-filled pages handling supports pages filled with a=
ny
> > > > repeated word-sized pattern. However, in practice, most of these sh=
ould
> > > > be zero pages anyway. Other patterns should be nearly as common.
> > > >
> > > > Drop the support for non-zero same-filled pages, but keep the names=
 of
> > > > knobs exposed to userspace as "same_filled", which isn't entirely
> > > > inaccurate.
> > > >
> > > > This yields some nice code simplification and enables a following p=
atch
> > > > that eliminates the need to allocate struct zswap_entry for those p=
ages
> > > > completely.
> > > >
> > > > There is also a very small performance improvement observed over 50=
 runs
> > > > of kernel build test (kernbench) comparing the mean build time on a
> > > > skylake machine when building the kernel in a cgroup v1 container w=
ith a
> > > > 3G limit:
> > > >
> > > >               base            patched         % diff
> > > > real          70.167          69.915          -0.359%
> > > > user          2953.068        2956.147        +0.104%
> > > > sys           2612.811        2594.718        -0.692%
> > > >
> > > > This probably comes from more optimized operations like memchr_inv(=
) and
> > > > clear_highpage(). Note that the percentage of zero-filled pages dur=
ing
> > > > this test was only around 1.5% on average, and was not affected by =
this
> > > > patch. Practical workloads could have a larger proportion of such p=
ages
> > > > (e.g. Johannes observed around 10% [1]), so the performance improve=
ment
> > > > should be larger.
> > > >
> > > > [1]https://lore.kernel.org/linux-mm/20240320210716.GH294822@cmpxchg=
org/
> > > >
> > > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > >
> > > This is an interesting direction to pursue, but I actually thinkg it
> > > doesn't go far enough. Either way, I think it needs more data.
> > >
> > > 1) How frequent are non-zero-same-filled pages? Difficult to
> > >    generalize, but if you could gather some from your fleet, that
> > >    would be useful. If you can devise a portable strategy, I'd also b=
e
> > >    more than happy to gather this on ours (although I think you have
> > >    more widespread zswap use, whereas we have more disk swap.)
> >
> > I am trying to collect the data, but there are.. hurdles. It would
> > take some time, so I was hoping the data could be collected elsewhere
> > if possible.
> >
> > The idea I had was to hook a BPF program to the entry of
> > zswap_fill_page() and create a histogram of the "value" argument. We
> > would get more coverage by hooking it to the return of
> > zswap_is_page_same_filled() and only updating the histogram if the
> > return value is true, as it includes pages in zswap that haven't been
> > swapped in.
> >
> > However, with zswap_is_page_same_filled() the BPF program will run in
> > all zswap stores, whereas for zswap_fill_page() it will only run when
> > needed. Not sure if this makes a practical difference tbh.
> >
> > >
> > > 2) The fact that we're doing any of this pattern analysis in zswap at
> > >    all strikes me as a bit misguided. Being efficient about repetitiv=
e
> > >    patterns is squarely in the domain of a compression algorithm. Do
> > >    we not trust e.g. zstd to handle this properly?
> >
> > I thought about this briefly, but I didn't follow through. I could try
> > to collect some data by swapping out different patterns and observing
> > how different compression algorithms react. That would be interesting
> > for sure.
> >
> > >
> > >    I'm guessing this goes back to inefficient packing from something
> > >    like zbud, which would waste half a page on one repeating byte.
> > >
> > >    But zsmalloc can do 32 byte objects. It's also a batching slab
> > >    allocator, where storing a series of small, same-sized objects is
> > >    quite fast.
> > >
> > >    Add to that the additional branches, the additional kmap, the extr=
a
> > >    scanning of every single page for patterns - all in the fast path
> > >    of zswap, when we already know that the vast majority of incoming
> > >    pages will need to be properly compressed anyway.
> > >
> > >    Maybe it's time to get rid of the special handling entirely?
> >
> > We would still be wasting some memory (~96 bytes between zswap_entry
> > and zsmalloc object), and wasting cycling allocating them. This could
> > be made up for by cycles saved by removing the handling. We will be
> > saving some branches for sure. I am not worried about kmap as I think
> > it's a noop in most cases.
>
> A secondary effect of the current same-filled page handling is that
> we're not considering them for reclaim. Which could potentially be
> beneficial, because we're not saving much memory (essentially just the
> zswap entry and associated cost of storing them) by writing these
> pages back - IOW, the cost / benefit ratio for reclaiming these pages
> is quite atrocious.

Yes, but I think this applies even without same-filled pages. Johannes
mentioned that zsmalloc could store compressed pages down to 32 bytes
in size. If these are common, it would be absurd to them out too. We
already have some kind of heuristic in the shrinker to slowdown
writeback if the compression ratio is high. Perhaps it's worth
skipping writeback completely for some pages on the LRU, even if this
means we violate the LRU ordering. We already do this for same-filled
pages, so it may make sense to generalize it.

>
> Again, all of this is just handwaving without numbers. It'd be nice if
> we can have more concrete data for this conversation :P

