Return-Path: <linux-kernel+bounces-125254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D21E78922D3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B19287AD8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6CB12FB27;
	Fri, 29 Mar 2024 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="DYxLI+Qj"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721EB1C0DDB
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 17:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711733890; cv=none; b=MMsyk03IeCY8NQhsq1tMsGc+dQTrdgjh+pnnOtz7LPkwi9il0ciJAM41mKrlSyGnIyhwKhkjvQ6vUREaNk7l3MzdJJ7GcZ5fMVZu5EM0LcywdPWyX9nEvzsrMfEotT/rB5y/P993fVUTPkcPW5/29zDnfHfacdWE0GOgnPZ8fGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711733890; c=relaxed/simple;
	bh=A3T3/NtUbmFZtQ0gW7Fr3BDkUtAI87nAJZ0tD7UCWuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8XohkmnWsJWZXKjIw3loF+aUbUYKkSxwXDgpHj617BUHQi1KvbjZOJTCMX+yCC7j5pzevZ1kSDCcKuvA/2hxYtiEAPioBu1Tuxv7e3KojkSFdO27mSUoEaAMjJU/Vsn1GopQ/7WrcZ8YaB8mcki+GNpOFv8vahP7wCQyzjOrB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=DYxLI+Qj; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7e0f4106a8bso727683241.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 10:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1711733885; x=1712338685; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WlyK0GsgoCgydTuF54QdUy3m/0gMb+bS62Xjc2zqhtc=;
        b=DYxLI+QjO50813Yj6pHL92lkWyHdHdQN2DOEAtAjy/5IGaSwrJnj1+JOf9W2ngt2eM
         H3utuhpTgPaBMVesx4Eg3wjzRNMMEwZPgpo60TSe8NUys0UV/KTMhnrFcFUX/7WJuSdv
         kHukbFWrEAQiFjwsU/YCznNjSI9rojAzxkD0jnYwqv/cJCKZCQmL41BaC4v3o/SS4UIZ
         LGMnggTevVz50CEY3R0HsyozkbGH8ruHnsE5IGHx1ZpGKT9nQFOE4VhogKVY0PGF41F5
         wHCJCKKzeOypbN/ZxxKxSbbMGfOSgugWWfsHq2mZVbrnlVyKQ6wgWKYXwWVB9S2dChXv
         O5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711733885; x=1712338685;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WlyK0GsgoCgydTuF54QdUy3m/0gMb+bS62Xjc2zqhtc=;
        b=K3aE9iiCAhguUfxSirgVxKWoh/S1WkLJNAJXqlMAsWMqaASWjNN1Ztfo1RHVxzs/UN
         IBpnuSJF7ImRPq4cpGUIsV0ODd/Xr9JUd4xTV4LjxQYODBLNN1I/cPayUHXCNdAxkCr0
         cg7mB1+lA6OqKnBVuSEFVWz/zWYa6A8DPB0mwHU3qfCRBnTvTeFljclFLamAQL/USkEv
         dZkfaWPITPrNoT73U3yii6D4PbN3oovXCgzGiIDoNr1ojrKxbjX3lW1UVaVgLm6cEWyn
         Ihldd/vcYVTQySR9SFI0R1/hYMwjjDDuF9/nHgW7YF+DRX0pSWMfbCnQwbenyyzQn/MG
         getw==
X-Forwarded-Encrypted: i=1; AJvYcCWG4wpLqQJYb90n3/K9ItShPgbxuaGO3ABGEyMtH9qVFEL7ZZ4Byz6dztXZ3f54pRvly8VO77KoCrF8ITabXskuMKEr0rMBFFX+Ru17
X-Gm-Message-State: AOJu0YwzuClQuggNmHdpj29S9kQWhtTY61yTEoGV1W4kyACYpgJ0YQEv
	RUN62HBvLKzvZo7ipEl21YaQQFBLCa7RMH28hJneyOyp/o7wXVyaeHICNJUUW/k=
X-Google-Smtp-Source: AGHT+IGzqLzWenW0m8fVk2VN1NboLjmTD5+JYMrdN6AtpN2oBrfl0vU9KSwgdLYKqgnquRBr8cYZWw==
X-Received: by 2002:a05:6122:3982:b0:4d8:7359:4c25 with SMTP id eq2-20020a056122398200b004d873594c25mr2716577vkb.12.1711733885020;
        Fri, 29 Mar 2024 10:38:05 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:bb1f])
        by smtp.gmail.com with ESMTPSA id oj15-20020a056214440f00b00698e65cdfefsm1228931qvb.87.2024.03.29.10.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 10:38:04 -0700 (PDT)
Date: Fri, 29 Mar 2024 13:37:59 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 6/9] mm: zswap: drop support for non-zero same-filled
 pages handling
Message-ID: <20240329173759.GI7597@cmpxchg.org>
References: <20240325235018.2028408-1-yosryahmed@google.com>
 <20240325235018.2028408-7-yosryahmed@google.com>
 <20240328193149.GF7597@cmpxchg.org>
 <CAJD7tkaFmbnt4YNWvgGZHo=-JRu-AsUWvCYCRXVZxOPvcSJRDw@mail.gmail.com>
 <20240328210709.GH7597@cmpxchg.org>
 <CAKEwX=OPDLxH-0-3F+xOc2SL5Ouj-R-HEC5QQrW+Q9Fn8pyeRg@mail.gmail.com>
 <CAJD7tkaGBofWm1eGBffEtpuKUDBVB_6RfHbYKQSKOX3fKn2jeg@mail.gmail.com>
 <CAJD7tkbKY0T6jd5v_GhNFyCO0578SNqfMgs1ZrZiCckY05hzZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkbKY0T6jd5v_GhNFyCO0578SNqfMgs1ZrZiCckY05hzZA@mail.gmail.com>

On Thu, Mar 28, 2024 at 09:27:17PM -0700, Yosry Ahmed wrote:
> On Thu, Mar 28, 2024 at 7:05 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > On Thu, Mar 28, 2024 at 4:19 PM Nhat Pham <nphamcs@gmail.com> wrote:
> > >
> > > On Thu, Mar 28, 2024 at 2:07 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > >
> > > > On Thu, Mar 28, 2024 at 01:23:42PM -0700, Yosry Ahmed wrote:
> > > > > On Thu, Mar 28, 2024 at 12:31 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > > >
> > > > > > On Mon, Mar 25, 2024 at 11:50:14PM +0000, Yosry Ahmed wrote:
> > > > > > > The current same-filled pages handling supports pages filled with any
> > > > > > > repeated word-sized pattern. However, in practice, most of these should
> > > > > > > be zero pages anyway. Other patterns should be nearly as common.
> > > > > > >
> > > > > > > Drop the support for non-zero same-filled pages, but keep the names of
> > > > > > > knobs exposed to userspace as "same_filled", which isn't entirely
> > > > > > > inaccurate.
> > > > > > >
> > > > > > > This yields some nice code simplification and enables a following patch
> > > > > > > that eliminates the need to allocate struct zswap_entry for those pages
> > > > > > > completely.
> > > > > > >
> > > > > > > There is also a very small performance improvement observed over 50 runs
> > > > > > > of kernel build test (kernbench) comparing the mean build time on a
> > > > > > > skylake machine when building the kernel in a cgroup v1 container with a
> > > > > > > 3G limit:
> > > > > > >
> > > > > > >               base            patched         % diff
> > > > > > > real          70.167          69.915          -0.359%
> > > > > > > user          2953.068        2956.147        +0.104%
> > > > > > > sys           2612.811        2594.718        -0.692%
> > > > > > >
> > > > > > > This probably comes from more optimized operations like memchr_inv() and
> > > > > > > clear_highpage(). Note that the percentage of zero-filled pages during
> > > > > > > this test was only around 1.5% on average, and was not affected by this
> > > > > > > patch. Practical workloads could have a larger proportion of such pages
> > > > > > > (e.g. Johannes observed around 10% [1]), so the performance improvement
> > > > > > > should be larger.
> > > > > > >
> > > > > > > [1]https://lore.kernel.org/linux-mm/20240320210716.GH294822@cmpxchg.org/
> > > > > > >
> > > > > > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > > > >
> > > > > > This is an interesting direction to pursue, but I actually thinkg it
> > > > > > doesn't go far enough. Either way, I think it needs more data.
> > > > > >
> > > > > > 1) How frequent are non-zero-same-filled pages? Difficult to
> > > > > >    generalize, but if you could gather some from your fleet, that
> > > > > >    would be useful. If you can devise a portable strategy, I'd also be
> > > > > >    more than happy to gather this on ours (although I think you have
> > > > > >    more widespread zswap use, whereas we have more disk swap.)
> > > > >
> > > > > I am trying to collect the data, but there are.. hurdles. It would
> > > > > take some time, so I was hoping the data could be collected elsewhere
> > > > > if possible.
> > > > >
> > > > > The idea I had was to hook a BPF program to the entry of
> > > > > zswap_fill_page() and create a histogram of the "value" argument. We
> > > > > would get more coverage by hooking it to the return of
> > > > > zswap_is_page_same_filled() and only updating the histogram if the
> > > > > return value is true, as it includes pages in zswap that haven't been
> > > > > swapped in.
> > > > >
> > > > > However, with zswap_is_page_same_filled() the BPF program will run in
> > > > > all zswap stores, whereas for zswap_fill_page() it will only run when
> > > > > needed. Not sure if this makes a practical difference tbh.
> > > > >
> > > > > >
> > > > > > 2) The fact that we're doing any of this pattern analysis in zswap at
> > > > > >    all strikes me as a bit misguided. Being efficient about repetitive
> > > > > >    patterns is squarely in the domain of a compression algorithm. Do
> > > > > >    we not trust e.g. zstd to handle this properly?
> > > > >
> > > > > I thought about this briefly, but I didn't follow through. I could try
> > > > > to collect some data by swapping out different patterns and observing
> > > > > how different compression algorithms react. That would be interesting
> > > > > for sure.
> > > > >
> > > > > >
> > > > > >    I'm guessing this goes back to inefficient packing from something
> > > > > >    like zbud, which would waste half a page on one repeating byte.
> > > > > >
> > > > > >    But zsmalloc can do 32 byte objects. It's also a batching slab
> > > > > >    allocator, where storing a series of small, same-sized objects is
> > > > > >    quite fast.
> > > > > >
> > > > > >    Add to that the additional branches, the additional kmap, the extra
> > > > > >    scanning of every single page for patterns - all in the fast path
> > > > > >    of zswap, when we already know that the vast majority of incoming
> > > > > >    pages will need to be properly compressed anyway.
> > > > > >
> > > > > >    Maybe it's time to get rid of the special handling entirely?
> > > > >
> > > > > We would still be wasting some memory (~96 bytes between zswap_entry
> > > > > and zsmalloc object), and wasting cycling allocating them. This could
> > > > > be made up for by cycles saved by removing the handling. We will be
> > > > > saving some branches for sure. I am not worried about kmap as I think
> > > > > it's a noop in most cases.
> > > >
> > > > Yes, true.
> > > >
> > > > > I am interested to see how much we could save by removing scanning for
> > > > > patterns. We may not save much if we abort after reading a few words
> > > > > in most cases, but I guess we could also be scanning a considerable
> > > > > amount before aborting. On the other hand, we would be reading the
> > > > > page contents into cache anyway for compression, so maybe it doesn't
> > > > > really matter?
> > > > >
> > > > > I will try to collect some data about this. I will start by trying to
> > > > > find out how the compression algorithms handle same-filled pages. If
> > > > > they can compress it efficiently, then I will try to get more data on
> > > > > the tradeoff from removing the handling.
> > > >
> > > > I do wonder if this could be overthinking it, too.
> > > >
> > > > Double checking the numbers on our fleet, a 96 additional bytes for
> > > > each same-filled entry would result in a
> > > >
> > > > 1) p50 waste of 0.008% of total memory, and a
> > > >
> > > > 2) p99 waste of 0.06% of total memory.
> >
> > Right. Assuming the compressors do not surprise us and store
> > same-filled pages in an absurd way, it's not worth it in terms of
> > memory savings.
> >
> > > >
> > > > And this is without us having even thought about trying to make
> > > > zsmalloc more efficient for this particular usecase - which might be
> > > > the better point of attack, if we think it's actually worth it.
> > > >
> > > > So my take is that unless removing it would be outright horrible from
> > > > a %sys POV (which seems pretty unlikely), IMO it would be fine to just
> > > > delete it entirely with a "not worth the maintenance cost" argument.
> > > >
> > > > If you turn the argument around, and somebody would submit the code as
> > > > it is today, with the numbers being what they are above, I'm not sure
> > > > we would even accept it!
> > >
> > > The context guy is here :)
> > >
> > > Not arguing for one way or another, but I did find the original patch
> > > that introduced same filled page handling:
> > >
> > > https://github.com/torvalds/linux/commit/a85f878b443f8d2b91ba76f09da21ac0af22e07f
> > >
> > > https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3d03d1344dde9fce0@epcms5p1/T/#u
> >
> > Thanks for digging this up. I don't know why I didn't start there :)
> >
> > Following in your footsteps, and given that zram has the same feature,
> > I found the patch that added support for non-zero same-filled pages in
> > zram:
> > https://lore.kernel.org/all/1483692145-75357-1-git-send-email-zhouxianrong@huawei.com/#t
> >
> > Both of them confirm that most same-filled pages are zero pages, but
> > they show a more significant portion of same-filled pages being
> > non-zero (17% to 40%). I suspect this will be less in data centers
> > compared to consumer apps.
> >
> > The zswap patch also reports significant performance improvements from
> > the same-filled handling, but this is with 17-22% same-filled pages.
> > Johannes mentioned around 10% in your data centers, so the performance
> > improvement would be less. In the kernel build tests I ran with only
> > around 1.5% same-filled pages I observed 1.4% improvements just by
> > optimizing them (only zero-filled, skipping allocations).
> >
> > So I think removing the same-filled pages handling completely may be
> > too aggressive, because it doesn't only affect the memory efficiency,
> > but also cycles spent when handling those pages. Just avoiding going
> > through the allocator and compressor has to account for something :)
> 
> Here is another data point. I tried removing the same-filled handling
> code completely with the diff Johannes sent upthread. I saw 1.3%
> improvement in the kernel build test, very similar to the improvement
> from this patch series. _However_, the kernel build test only produces
> ~1.5% zero-filled pages in my runs. More realistic workloads have
> significantly higher percentages as demonstrated upthread.
> 
> In other words, the kernel build test (at least in my runs) seems to
> be the worst case scenario for same-filled/zero-filled pages. Since
> the improvement from removing same-filled handling is quite small in
> this case, I suspect there will be no improvement, but possibly a
> regression, on real workloads.
> 
> As the zero-filled pages ratio increases:
> - The performance with this series will improve.
> - The performance with removing same-filled handling completely will
> become worse.

Sorry, this thread is still really lacking practical perspective.

As do the numbers that initially justified the patch. Sure, the stores
of same-filled pages are faster. What's the cost of prechecking 90% of
the other pages that need compression?

Also, this is the swap path we're talking about. There is vmscan, swap
slot allocations, page table walks, TLB flushes, zswap tree inserts;
then a page fault and everything in reverse.

I perf'd zswapping out data that is 10% same-filled and 90% data that
always needs compression. It does nothing but madvise(MADV_PAGEOUT),
and the zswap_store() stack is already only ~60% of the cycles.

Using zsmalloc + zstd, this is the diff between vanilla and my patch:

# Baseline  Delta Abs  Shared Object         Symbol
# ........  .........  ....................  .....................................................
#
     4.34%     -3.02%  [kernel.kallsyms]     [k] zswap_store
    11.07%     +1.41%  [kernel.kallsyms]     [k] ZSTD_compressBlock_doubleFast
    15.55%     +0.91%  [kernel.kallsyms]     [k] FSE_buildCTable_wksp

As expected, we have to compress a bit more; on the other hand we're
removing the content scan for same-filled for 90% of the pages that
don't benefit from it. They almost amortize each other. Let's round it
up and the remaining difference is ~1%.

It's difficult to make the case that this matters to any real
workloads with actual think time in between paging.

But let's say you do make the case that zero-filled pages are worth
optimizing for. Why is this in zswap? Why not do it in vmscan with a
generic zero-swp_entry_t, and avoid the swap backend altogether? No
swap slot allocation, no zswap tree, no *IO on disk swap*.

However you slice it, I fail to see how this has a place in
zswap. It's trying to optimize the slow path of a slow path, at the
wrong layer of the reclaim stack.


