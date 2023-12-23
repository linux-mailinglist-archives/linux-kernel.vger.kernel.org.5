Return-Path: <linux-kernel+bounces-10287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB7881D23B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 05:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57289B22569
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79664C6C;
	Sat, 23 Dec 2023 04:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNmwvLao"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304D94A12
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 04:41:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E181BC433C8;
	Sat, 23 Dec 2023 04:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703306463;
	bh=ae+AgZwj/0a4jP0U1bLVGLJHsqDorTg6Qy9O6uB+rqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iNmwvLao+vzaGFtr3bfYb4UMa7V2Dx+mNJqaR30Fz0CuYhClxpasfx688JdlJUHd+
	 eLfxQm88C11jCzjXjkS18qCES2KioeBHwqLJJrpoNFt3ca7SCtfvUGM3U05BTle8eh
	 XdJ709Tb5F9w7ALGuoIT+05SyioKP/387rdbfrionia+82as0TzDvLF7uK3NWtfpaa
	 sDeasWXe010AWGfHAksrkUJ4t71/MNJSE0X6ijj6taINmoLZijCAGACZ5l+oPLlXJS
	 GGyDWT21ucbEaCAw8DEfVw5x3guZ8VT+qxrz0OJjZmhDS92sIz1ZSEOHDSbDwUMVRx
	 yqlHxTfFXAxJQ==
Date: Fri, 22 Dec 2023 20:41:01 -0800
From: Chris Li <chrisl@kernel.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Wei Xu <weixugc@google.com>,
	Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Brain Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Huang Ying <ying.huang@intel.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kairui Song <kasong@tencent.com>,
	Zhongkun He <hezhongkun.hzk@bytedance.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH] mm: swap: async free swap slot cache entries
Message-ID: <ZYZk3dISUtDe-0wT@google.com>
References: <20231221-async-free-v1-1-94b277992cb0@kernel.org>
 <CAKEwX=MNWcADDDWMo_V8V=1snAPKWmcxbnKX8jzt4XdNoXiV3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKEwX=MNWcADDDWMo_V8V=1snAPKWmcxbnKX8jzt4XdNoXiV3Q@mail.gmail.com>

On Fri, Dec 22, 2023 at 05:44:19PM -0800, Nhat Pham wrote:
> On Thu, Dec 21, 2023 at 10:25 PM Chris Li <chrisl@kernel.org> wrote:
> >
> > We discovered that 1% swap page fault is 100us+ while 50% of
> > the swap fault is under 20us.
> >
> > Further investigation show that a large portion of the time
> > spent in the free_swap_slots() function for the long tail case.
> >
> > The percpu cache of swap slots is freed in a batch of 64 entries
> > inside free_swap_slots(). These cache entries are accumulated
> > from previous page faults, which may not be related to the current
> > process.
> >
> > Doing the batch free in the page fault handler causes longer
> > tail latencies and penalizes the current process.
> >
> > Move free_swap_slots() outside of the swapin page fault handler into an
> > async work queue to avoid such long tail latencies.
> >
> > Testing:
> >
> > Chun-Tse did some benchmark in chromebook, showing that
> > zram_wait_metrics improve about 15% with 80% and 95% confidence.

This benchmark result is using zram. There are 3 micro benchmarks of
all showing about 15% improvement with a slightly different confidence
level.  That is where the 80%-90% come from.

> >
> > I recently ran some experiments on about 1000 Google production
> > machines. It shows swapin latency drops in the long tail
> > 100us - 500us bucket dramatically.
> >
> > platform        (100-500us)             (0-100us)
> > A               1.12% -> 0.36%          98.47% -> 99.22%
> > B               0.65% -> 0.15%          98.96% -> 99.46%
> > C               0.61% -> 0.23%          98.96% -> 99.38%
> 
> Nice! Are these values for zram as well, or ordinary (SSD?) swap? I
> imagine it will matter less for swap, right?

Those production servers only use zswap. There is no zram there.
For ordinary SSD swap the latency reduction is also there in terms
of absolute us. However the raw savings get shadowed by the SSD IO
latency, typically in the 100us range. In terms of percentage,
you don't have as dramatica an effect compared to the memory
compression based swapping(zswap and zram).

> > @@ -348,3 +362,10 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
> >         }
> >         return entry;
> >  }
> > +
> > +static int __init async_queue_init(void)
> > +{
> > +       swap_free_queue = create_workqueue("async swap cache");
> 
> nit(?): isn't create_workqueue() deprecated? from:
> 
> https://www.kernel.org/doc/html/latest/core-api/workqueue.html#application-programming-interface-api
> 
> I think there's a zswap patch proposing fixing that on the zswap side.
> 


Yes, I recall I saw that patch. I might acked on it as well.
Very good catch. I will fix it in the V2 spin.
Meanwhile, I will wait on it a bit to collect the other review
feedback.

Thans for catching that.

Chris


