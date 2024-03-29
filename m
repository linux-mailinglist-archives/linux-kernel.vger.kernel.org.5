Return-Path: <linux-kernel+bounces-125303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654FC8923BD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 882B81C20DFB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7588286240;
	Fri, 29 Mar 2024 18:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GeLUIJnA"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBC822075
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 18:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711738647; cv=none; b=td1iXlCOfRc0fRmCtACSdce0Dbvp2A4g+DvxJnglPWR0fPLrKGc2cyyghOYiKIxJA7++VD2ZykcYIedrj/0SltBIIuKdWxQPC8f//XAek6ovR+von8OMwc3YEEV5DgaHX+fQhozeR7LueZsP6aW6Y+pGZe/+0Az3RBe9yuPcrOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711738647; c=relaxed/simple;
	bh=F6CwuALbvPL/Ds5m2TaQe9XPx++WAJMjcLA5raQL78c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tviTXQbWAA8VK1IVEn4GIzpZZQuewqeVO8iQHUX8MskHTcp1Jy2kxF1LL0rQ5YhPyzrQ3LafyAxC3cja/URb96YMZmaglzjn072wknDonK7s5tuvpm5ic1FzZZLkIJZm63n2wVds73fKKaYLNFtNy2IhON83yqQH/mT/ZqKHysQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GeLUIJnA; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5688eaf1165so3053192a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 11:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711738643; x=1712343443; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7ThnGNLb7whw9044LonmmdrO8mODL/ogtraEcDhnIGU=;
        b=GeLUIJnA1n9XjLelbenkQ8Eu4OSR2Ui7WjdTK5aU517VsroGc9oZJoXlavVuA+d7HT
         RHYUrBjCzz3jisEKrNB33e6XPBK5HVMruvW+JQiHIVsoNdBbtUNNeAmPeBLQ3bIU0dbK
         7E24PGWewMeW3xhIIG16b0Zn34hMZri5SwKfpF6q4tmUxKpi2W+I+m0vK2Cd/bkysW1u
         gEboidS4YMhPK64Jq4R12FH7Djk16Zi1HRxphKBJM0r4mm9NE1SgNRnPV3SlfjC7fiTb
         KJ1fY0J7v9/A/eh1sMBpy7rl8CbmJlppHKIg/uI5M73cgUhjNxDX9R9Nupxb6bcWndrx
         128w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711738643; x=1712343443;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ThnGNLb7whw9044LonmmdrO8mODL/ogtraEcDhnIGU=;
        b=JxZVtprJXtiagvCd20VVYFcnYQ7aiKYBn1QPwSHkewkQ7gHpM9ZmM/HhdhDbwnhE3p
         MlWEaY0Ru5DgZsjrt7CWrscWjo2jxFPjQ2NGd9k72Mff9pJTJa4dtCU66gjBLTHSHBVe
         +gr5fyWXLuTjhMNMbCF7ybmhikAiwsws21009ikmkQL7aJo/MJ0nC0kFs2RrGusdCXtd
         vJbv7FbGatmRKvw+9iB2s0OeX6pRavU03Cvgy+Qdu4oNnM9v+Uevu33FAj/+PnPGJTxm
         rlZNWLMZJrdkioJCNAVqKub2c8DX4wNOcAMarOkXQC3+qkm1B49EjncS31lQh4JznLyt
         nzxg==
X-Forwarded-Encrypted: i=1; AJvYcCXI4acPnpCQ4bcKHmJ3uLbrQF6urtgl/tkWnF8UJCxbKZ8pXuXVwJc4LMnq2sIKA1hzydxkXo9zLHI0F1+R4B15yi8BHbFRyciegxCQ
X-Gm-Message-State: AOJu0YwgBwOT8FTpC9YKhTgbebRCIQ92aebIqHL+j3UxFPRHuxKnmA0Q
	tJkTEXV/dsz99UjJZwJ3uqZO71kXug/1yMTqGgRZYoYTXi87mM8evAJJRAy82JtqpMf1sDAcy8f
	FMsM3te/Gt/s9TEDLRHHI3JtP/aYQYlyxAt6Q
X-Google-Smtp-Source: AGHT+IE7ZEmDbKxjJT2MfgJ82YDUlNYG2SOco8RkNyq3EjZ8JKESLgiky0azfOPnbeno1yGqJk2g3DLjrYgDipUMI9U=
X-Received: by 2002:a17:906:c12:b0:a4a:3441:2e2a with SMTP id
 s18-20020a1709060c1200b00a4a34412e2amr2097433ejf.55.1711738642697; Fri, 29
 Mar 2024 11:57:22 -0700 (PDT)
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
 <CAJD7tkaGBofWm1eGBffEtpuKUDBVB_6RfHbYKQSKOX3fKn2jeg@mail.gmail.com>
 <CAJD7tkbKY0T6jd5v_GhNFyCO0578SNqfMgs1ZrZiCckY05hzZA@mail.gmail.com> <20240329173759.GI7597@cmpxchg.org>
In-Reply-To: <20240329173759.GI7597@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 29 Mar 2024 11:56:46 -0700
Message-ID: <CAJD7tkaySFP2hBQw4pnZHJJwe3bMdjJ1t9VC2VJd=khn1_TXvA@mail.gmail.com>
Subject: Re: [RFC PATCH 6/9] mm: zswap: drop support for non-zero same-filled
 pages handling
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Nhat Pham <nphamcs@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Srividya Desireddy <srividya.desireddy@gmail.com>
Content-Type: text/plain; charset="UTF-8"

[..]
> > > > The context guy is here :)
> > > >
> > > > Not arguing for one way or another, but I did find the original patch
> > > > that introduced same filled page handling:
> > > >
> > > > https://github.com/torvalds/linux/commit/a85f878b443f8d2b91ba76f09da21ac0af22e07f
> > > >
> > > > https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3d03d1344dde9fce0@epcms5p1/T/#u
> > >
> > > Thanks for digging this up. I don't know why I didn't start there :)
> > >
> > > Following in your footsteps, and given that zram has the same feature,
> > > I found the patch that added support for non-zero same-filled pages in
> > > zram:
> > > https://lore.kernel.org/all/1483692145-75357-1-git-send-email-zhouxianrong@huawei.com/#t
> > >
> > > Both of them confirm that most same-filled pages are zero pages, but
> > > they show a more significant portion of same-filled pages being
> > > non-zero (17% to 40%). I suspect this will be less in data centers
> > > compared to consumer apps.
> > >
> > > The zswap patch also reports significant performance improvements from
> > > the same-filled handling, but this is with 17-22% same-filled pages.
> > > Johannes mentioned around 10% in your data centers, so the performance
> > > improvement would be less. In the kernel build tests I ran with only
> > > around 1.5% same-filled pages I observed 1.4% improvements just by
> > > optimizing them (only zero-filled, skipping allocations).
> > >
> > > So I think removing the same-filled pages handling completely may be
> > > too aggressive, because it doesn't only affect the memory efficiency,
> > > but also cycles spent when handling those pages. Just avoiding going
> > > through the allocator and compressor has to account for something :)
> >
> > Here is another data point. I tried removing the same-filled handling
> > code completely with the diff Johannes sent upthread. I saw 1.3%
> > improvement in the kernel build test, very similar to the improvement
> > from this patch series. _However_, the kernel build test only produces
> > ~1.5% zero-filled pages in my runs. More realistic workloads have
> > significantly higher percentages as demonstrated upthread.
> >
> > In other words, the kernel build test (at least in my runs) seems to
> > be the worst case scenario for same-filled/zero-filled pages. Since
> > the improvement from removing same-filled handling is quite small in
> > this case, I suspect there will be no improvement, but possibly a
> > regression, on real workloads.
> >
> > As the zero-filled pages ratio increases:
> > - The performance with this series will improve.
> > - The performance with removing same-filled handling completely will
> > become worse.
>
> Sorry, this thread is still really lacking practical perspective.
>
> As do the numbers that initially justified the patch. Sure, the stores
> of same-filled pages are faster. What's the cost of prechecking 90% of
> the other pages that need compression?

Well, that's exactly what I was trying to find out :)

The kernel build test has over 98% pages that are not same-filled in
my runs, so we are paying the cost of prechecking 98% of pages for
same-filled contents needlessly. However, removing same-filled
handling only resulted in a 1.4% performance improvement. We should
expect even less for workloads that have 90% non-same-filled pages,
right?

It seems like the cost of prechecking is not that bad at all,
potentially because the page contents are read into cache anyway. Did
I miss something?

>
> Also, this is the swap path we're talking about. There is vmscan, swap
> slot allocations, page table walks, TLB flushes, zswap tree inserts;
> then a page fault and everything in reverse.
>
> I perf'd zswapping out data that is 10% same-filled and 90% data that
> always needs compression. It does nothing but madvise(MADV_PAGEOUT),
> and the zswap_store() stack is already only ~60% of the cycles.
>
> Using zsmalloc + zstd, this is the diff between vanilla and my patch:
>
> # Baseline  Delta Abs  Shared Object         Symbol
> # ........  .........  ....................  .....................................................
> #
>      4.34%     -3.02%  [kernel.kallsyms]     [k] zswap_store
>     11.07%     +1.41%  [kernel.kallsyms]     [k] ZSTD_compressBlock_doubleFast
>     15.55%     +0.91%  [kernel.kallsyms]     [k] FSE_buildCTable_wksp
>
> As expected, we have to compress a bit more; on the other hand we're
> removing the content scan for same-filled for 90% of the pages that
> don't benefit from it. They almost amortize each other. Let's round it
> up and the remaining difference is ~1%.

Thanks for the data, this is very useful.

There is also the load path. The original patch that introduced
same-filled pages reports more gains on the load side, which also
happens to be more latency-sensitive. Of course, the data could be
outdated -- but it's a different type of workload than what will be
running in a data center fleet AFAICT.

Is there also no noticeable difference on the load side in your data?

Also, how much increase did you observe in the size of compressed data
with your patch? Just curious about how zstd ended up handling those
pages.

>
> It's difficult to make the case that this matters to any real
> workloads with actual think time in between paging.

If the difference in performance is 1%, I surely agree.

The patch reported 19-32% improvement in store time for same-filled
pages depending on the workload and platform. For 10% same-filled
pages, this should roughly correspond to 2-3% overall improvement,
which is not too far from the 1% you observed.

The patch reported much larger improvement for load times (which
matters more), 49-85% for same-filled pages. If this corresponds to
5-8% overall improvement in zswap load time for a workload with 10%
same-filled pages, that would be very significant. I don't expect to
see such improvements tbh, but we should check.

Let's CC Srividya here for visibility.

>
> But let's say you do make the case that zero-filled pages are worth
> optimizing for.

I am not saying they are for sure, but removing the same-filled
checking didn't seem to improve performance much in my testing, so the
cost seems to be mostly in maintenance. This makes it seem to me that
it *could* be a good tradeoff to only handle zero-filled pages. We can
make them slightly faster and we can trim the complexity -- as shown
by this patch.

> Why is this in zswap? Why not do it in vmscan with a
> generic zero-swp_entry_t, and avoid the swap backend altogether? No
> swap slot allocation, no zswap tree, no *IO on disk swap*.

That part I definitely agree with, especially that the logic is
duplicated in zram.

>
> However you slice it, I fail to see how this has a place in
> zswap. It's trying to optimize the slow path of a slow path, at the
> wrong layer of the reclaim stack.

Agreeing for the store path, we still need some clarity on the load
path. But yeah all-in-all zswap is not the correct place for such
optimizations, but it's the way the handling currently lives.

