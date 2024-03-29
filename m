Return-Path: <linux-kernel+bounces-124027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0067389115D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8336D1F245E9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C933E46D;
	Fri, 29 Mar 2024 02:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ac0fFocJ"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F743D0AD
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 02:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677947; cv=none; b=drx9kOarIEtTEZJe/KGYsyxhWOKcuUN5IC/oiOzKZqUdekKPkM4X8J7YAuG/5/3nSOwKugrwONDxe+uxO/ScD3CFQ8N/FWoW5mH7FlFEfqZPwAXobGTtVMetGp+tuZw9URAq1e9fwC7WMTkeauMi4AtTCRTkJ1hVFpDgHBeqrzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677947; c=relaxed/simple;
	bh=Qii1MidTI3dd4lnGBxJ9nfpVK49lRdwDqn39lax5Vrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d31qXgl0l68+SEDNPSC2ZyTHQXnPCcgu1+LVj55FsKAtOYnkujVGE5wo5XWiepEevuhwrXb/XKzqhyjdq6FC4lGArepdTK22QZbpYAl8ZYME+fxSm2Sit2Z5lgV3/w4fTfSUHMoZLJqHM1IWlCFsWmXzHIn4L5yfwDOHhVWo1eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ac0fFocJ; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d700beb60bso29365651fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 19:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677943; x=1712282743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWzmC2A1K+GOJx5fn1L/D3rGLcK6o/CgnIHLNsZcoy8=;
        b=Ac0fFocJFUEWHcNPr8v8K2XCvMffQDEekZyWHQGnSOfh9m4zKJb9RmjvdOSCnDO1Ou
         NftbC9uiwi7zZLOmzKwa6nFQAJRIuai2C/AfFzkiUtpMzaffSNdJxa6TXkL4yxvJvTFH
         RFpskBFyBWXKMFyVs6yfivljiVtM/5ukEuHZ2OfzlzgeVg8CJiFvVmfXw1uKwqK9qkxg
         L8zSt8Esos9/r5TL+HZWhsG/0M8olAHx9AWJnSpryspeF+1jl5j3Nv/Srka6en7uxYLq
         p0o25oPSyfJ+wOqD3kdR+jr2q/SKTIem/mtvmgZJQVCu+9sKjxwluuaDyzdgsOTaVSil
         aR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677943; x=1712282743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWzmC2A1K+GOJx5fn1L/D3rGLcK6o/CgnIHLNsZcoy8=;
        b=ghA+nRDUWNcycNdk9kuUoZlXzvCo5d0+ojrg5Wt3BD8EkShXE6t3JyW9kEDphG9ekQ
         muwSPDca6A904LfWmgJD5N6O6E7sKDbrrTWZEqI4Io6jGHvOc9Z2/NgDQhAKGXTgDaUO
         VEV48f+VVAK2NeZgvMg8iE/gKw8XbS52LnL7reboHwKwIYyW/HQLDKiGeIqbsLCNy0j9
         WjZCl7Nw5DyRIwSJqkCpyAcBK2WoEdd8tlKQ3UhabOz5gS4cVbhS/AIKZ5xMoZJcjpMw
         0VoXMIFme+1+VMoy7U3K6hCjnPj0QIs+psrZ88fV/cAkdVp93MHZYBAIdXnMEdUEhpU0
         8vCg==
X-Forwarded-Encrypted: i=1; AJvYcCUHNGzVcbKsStJt4VFMa6fR//R1rOYmkyALDI7NzM614M/JbaWOsOGER4tK2GmXoVvnvhskzI5dgihbh8mJccLTH3UE1/um2EZVBc0V
X-Gm-Message-State: AOJu0YzTcZ3tzwMvSMrrJBldiH/7Q+5iE3znLR0BrJ4W8+I1knEXZYd0
	nxMt2CUeubrYa92w5iHnCPzsPcfNAvC2Cgu7JDmfFxxYLB/RZGSDwX+sHESUHKTr+hHo2q4ddwX
	9k1WzaH7kxyFsEyEAHEbKV4KTB3kYK8GpuHWqItiqwewwdyKuX0UF
X-Google-Smtp-Source: AGHT+IHDTcttH8IbbakiTybsSS1ZVJn3oHaZwKKDQLVTfhzexPbVGNlEI8JbSG2UxzyhRDIqXKr/mAUdBdSj4ROe9rI=
X-Received: by 2002:a2e:9659:0:b0:2d6:e148:2463 with SMTP id
 z25-20020a2e9659000000b002d6e1482463mr586069ljh.24.1711677942540; Thu, 28 Mar
 2024 19:05:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325235018.2028408-1-yosryahmed@google.com>
 <20240325235018.2028408-7-yosryahmed@google.com> <20240328193149.GF7597@cmpxchg.org>
 <CAJD7tkaFmbnt4YNWvgGZHo=-JRu-AsUWvCYCRXVZxOPvcSJRDw@mail.gmail.com>
 <20240328210709.GH7597@cmpxchg.org> <CAKEwX=OPDLxH-0-3F+xOc2SL5Ouj-R-HEC5QQrW+Q9Fn8pyeRg@mail.gmail.com>
In-Reply-To: <CAKEwX=OPDLxH-0-3F+xOc2SL5Ouj-R-HEC5QQrW+Q9Fn8pyeRg@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 28 Mar 2024 19:05:04 -0700
Message-ID: <CAJD7tkaGBofWm1eGBffEtpuKUDBVB_6RfHbYKQSKOX3fKn2jeg@mail.gmail.com>
Subject: Re: [RFC PATCH 6/9] mm: zswap: drop support for non-zero same-filled
 pages handling
To: Nhat Pham <nphamcs@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 4:19=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Thu, Mar 28, 2024 at 2:07=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
> >
> > On Thu, Mar 28, 2024 at 01:23:42PM -0700, Yosry Ahmed wrote:
> > > On Thu, Mar 28, 2024 at 12:31=E2=80=AFPM Johannes Weiner <hannes@cmpx=
chg.org> wrote:
> > > >
> > > > On Mon, Mar 25, 2024 at 11:50:14PM +0000, Yosry Ahmed wrote:
> > > > > The current same-filled pages handling supports pages filled with=
 any
> > > > > repeated word-sized pattern. However, in practice, most of these =
should
> > > > > be zero pages anyway. Other patterns should be nearly as common.
> > > > >
> > > > > Drop the support for non-zero same-filled pages, but keep the nam=
es of
> > > > > knobs exposed to userspace as "same_filled", which isn't entirely
> > > > > inaccurate.
> > > > >
> > > > > This yields some nice code simplification and enables a following=
 patch
> > > > > that eliminates the need to allocate struct zswap_entry for those=
 pages
> > > > > completely.
> > > > >
> > > > > There is also a very small performance improvement observed over =
50 runs
> > > > > of kernel build test (kernbench) comparing the mean build time on=
 a
> > > > > skylake machine when building the kernel in a cgroup v1 container=
 with a
> > > > > 3G limit:
> > > > >
> > > > >               base            patched         % diff
> > > > > real          70.167          69.915          -0.359%
> > > > > user          2953.068        2956.147        +0.104%
> > > > > sys           2612.811        2594.718        -0.692%
> > > > >
> > > > > This probably comes from more optimized operations like memchr_in=
v() and
> > > > > clear_highpage(). Note that the percentage of zero-filled pages d=
uring
> > > > > this test was only around 1.5% on average, and was not affected b=
y this
> > > > > patch. Practical workloads could have a larger proportion of such=
 pages
> > > > > (e.g. Johannes observed around 10% [1]), so the performance impro=
vement
> > > > > should be larger.
> > > > >
> > > > > [1]https://lore.kernel.org/linux-mm/20240320210716.GH294822@cmpxc=
hg.org/
> > > > >
> > > > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > >
> > > > This is an interesting direction to pursue, but I actually thinkg i=
t
> > > > doesn't go far enough. Either way, I think it needs more data.
> > > >
> > > > 1) How frequent are non-zero-same-filled pages? Difficult to
> > > >    generalize, but if you could gather some from your fleet, that
> > > >    would be useful. If you can devise a portable strategy, I'd also=
 be
> > > >    more than happy to gather this on ours (although I think you hav=
e
> > > >    more widespread zswap use, whereas we have more disk swap.)
> > >
> > > I am trying to collect the data, but there are.. hurdles. It would
> > > take some time, so I was hoping the data could be collected elsewhere
> > > if possible.
> > >
> > > The idea I had was to hook a BPF program to the entry of
> > > zswap_fill_page() and create a histogram of the "value" argument. We
> > > would get more coverage by hooking it to the return of
> > > zswap_is_page_same_filled() and only updating the histogram if the
> > > return value is true, as it includes pages in zswap that haven't been
> > > swapped in.
> > >
> > > However, with zswap_is_page_same_filled() the BPF program will run in
> > > all zswap stores, whereas for zswap_fill_page() it will only run when
> > > needed. Not sure if this makes a practical difference tbh.
> > >
> > > >
> > > > 2) The fact that we're doing any of this pattern analysis in zswap =
at
> > > >    all strikes me as a bit misguided. Being efficient about repetit=
ive
> > > >    patterns is squarely in the domain of a compression algorithm. D=
o
> > > >    we not trust e.g. zstd to handle this properly?
> > >
> > > I thought about this briefly, but I didn't follow through. I could tr=
y
> > > to collect some data by swapping out different patterns and observing
> > > how different compression algorithms react. That would be interesting
> > > for sure.
> > >
> > > >
> > > >    I'm guessing this goes back to inefficient packing from somethin=
g
> > > >    like zbud, which would waste half a page on one repeating byte.
> > > >
> > > >    But zsmalloc can do 32 byte objects. It's also a batching slab
> > > >    allocator, where storing a series of small, same-sized objects i=
s
> > > >    quite fast.
> > > >
> > > >    Add to that the additional branches, the additional kmap, the ex=
tra
> > > >    scanning of every single page for patterns - all in the fast pat=
h
> > > >    of zswap, when we already know that the vast majority of incomin=
g
> > > >    pages will need to be properly compressed anyway.
> > > >
> > > >    Maybe it's time to get rid of the special handling entirely?
> > >
> > > We would still be wasting some memory (~96 bytes between zswap_entry
> > > and zsmalloc object), and wasting cycling allocating them. This could
> > > be made up for by cycles saved by removing the handling. We will be
> > > saving some branches for sure. I am not worried about kmap as I think
> > > it's a noop in most cases.
> >
> > Yes, true.
> >
> > > I am interested to see how much we could save by removing scanning fo=
r
> > > patterns. We may not save much if we abort after reading a few words
> > > in most cases, but I guess we could also be scanning a considerable
> > > amount before aborting. On the other hand, we would be reading the
> > > page contents into cache anyway for compression, so maybe it doesn't
> > > really matter?
> > >
> > > I will try to collect some data about this. I will start by trying to
> > > find out how the compression algorithms handle same-filled pages. If
> > > they can compress it efficiently, then I will try to get more data on
> > > the tradeoff from removing the handling.
> >
> > I do wonder if this could be overthinking it, too.
> >
> > Double checking the numbers on our fleet, a 96 additional bytes for
> > each same-filled entry would result in a
> >
> > 1) p50 waste of 0.008% of total memory, and a
> >
> > 2) p99 waste of 0.06% of total memory.

Right. Assuming the compressors do not surprise us and store
same-filled pages in an absurd way, it's not worth it in terms of
memory savings.

> >
> > And this is without us having even thought about trying to make
> > zsmalloc more efficient for this particular usecase - which might be
> > the better point of attack, if we think it's actually worth it.
> >
> > So my take is that unless removing it would be outright horrible from
> > a %sys POV (which seems pretty unlikely), IMO it would be fine to just
> > delete it entirely with a "not worth the maintenance cost" argument.
> >
> > If you turn the argument around, and somebody would submit the code as
> > it is today, with the numbers being what they are above, I'm not sure
> > we would even accept it!
>
> The context guy is here :)
>
> Not arguing for one way or another, but I did find the original patch
> that introduced same filled page handling:
>
> https://github.com/torvalds/linux/commit/a85f878b443f8d2b91ba76f09da21ac0=
af22e07f
>
> https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3d03d134=
4dde9fce0@epcms5p1/T/#u

Thanks for digging this up. I don't know why I didn't start there :)

Following in your footsteps, and given that zram has the same feature,
I found the patch that added support for non-zero same-filled pages in
zram:
https://lore.kernel.org/all/1483692145-75357-1-git-send-email-zhouxianrong@=
huawei.com/#t

Both of them confirm that most same-filled pages are zero pages, but
they show a more significant portion of same-filled pages being
non-zero (17% to 40%). I suspect this will be less in data centers
compared to consumer apps.

The zswap patch also reports significant performance improvements from
the same-filled handling, but this is with 17-22% same-filled pages.
Johannes mentioned around 10% in your data centers, so the performance
improvement would be less. In the kernel build tests I ran with only
around 1.5% same-filled pages I observed 1.4% improvements just by
optimizing them (only zero-filled, skipping allocations).

So I think removing the same-filled pages handling completely may be
too aggressive, because it doesn't only affect the memory efficiency,
but also cycles spent when handling those pages. Just avoiding going
through the allocator and compressor has to account for something :)

>
> The number looks impressive, and there is some detail about the
> experiment setup, but I can't seem to find what the allocator +
> compressor used.

I would assume it was zbud because it was the default then, but as I
mentioned zram had similar patches and it uses zsmalloc. I suspect
zsmalloc would have changed since then tho, and compressors as well.
With zram there, is also the point that metadata is allocated
statically AFAICT, so there is very little cost to supporting all
same-filled pages if you already support zero-filled pages.

>
> Which, as Johannes has pointed out, matters a lot. A good compressor
> (which should work on arguably the most trivial data pattern there is)
> + a backend allocator that is capable of handling small objects well
> could make this case really efficient, without resorting to special
> handling at the zswap level.

All in all, I think there are three aspects here:
(1) Cycles saved by avoiding going through the compressor and
allocator, and potentially allocating zswap_entry as well the metadata
with this series.

(2) Memory saved by storing same-filled pages in zswap instead of
compressing them. This will ultimately depend on the compressor and
allocator as has been established.

(3) Memory saved on metadata in zswap by avoiding the zswap_entry
allocation. This is probably too small to matter.

I think (1) may be the major factor here, and (2) could be a factor if
the compressors surprise us (and would always be a factor for zbud and
z3fold due to bin packing).

Focusing on just (1), supporting zero-filled pages only may be a good
tradeoff. We get slightly less complicated and potentially faster
handling in zswap without losing a lot. Did I capture the discussion
so far correctly?

