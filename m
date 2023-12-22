Return-Path: <linux-kernel+bounces-10110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFFD81D059
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 00:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CFE31C2244E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089F6364AB;
	Fri, 22 Dec 2023 23:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aerR3g1U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFA4364A0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 23:16:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C65BC433C7;
	Fri, 22 Dec 2023 23:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703287000;
	bh=PuoJSH9edJoo7oeOjVNTX3jweEOc6MbjFIsvStWC698=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aerR3g1U+YyKbb3C+3gfRjRJXeoL2jnnN7yfEMpxtc2pkeGswJJCVwAvBrQJf325w
	 hP0/s34sO2lIObDxMgZDVi7h+pjCtDJ33POD3VrEK5BNi6+hJFFwrfIbpZhUloK1ft
	 ldxE2PkNhkeEwtAjAWfSwCuw9lzm2O7zfoAODNydNC4YIGQuL3hsHAx55Dk0FyRuxk
	 dSHrh0EFwzBOIvljHGdywML83g6OJ/AHfs1F4hDMJSbGfgqku8qroP5TfYtDoeqyOB
	 oGLp4yKc9zMXxVp1uoMX9S/5jKVZWbZwquHj7XwlTwqWW31h2YI46+4LsapQRc0hpE
	 8WkWj1uCcXL0A==
Date: Fri, 22 Dec 2023 15:16:37 -0800
From: Chris Li <chrisl@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Wei Xu <weixugc@google.com>, Yu Zhao <yuzhao@google.com>,
	Greg Thelen <gthelen@google.com>, Chun-Tse Shao <ctshao@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Brain Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Huang Ying <ying.huang@intel.com>, Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kairui Song <kasong@tencent.com>,
	Zhongkun He <hezhongkun.hzk@bytedance.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Barry Song <v-songbaohua@oppo.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm: swap: async free swap slot cache entries
Message-ID: <ZYYY1VBKdLHH-Kl3@google.com>
References: <20231221-async-free-v1-1-94b277992cb0@kernel.org>
 <20231222115208.ab4d2aeacdafa4158b14e532@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222115208.ab4d2aeacdafa4158b14e532@linux-foundation.org>

On Fri, Dec 22, 2023 at 11:52:08AM -0800, Andrew Morton wrote:
> On Thu, 21 Dec 2023 22:25:39 -0800 Chris Li <chrisl@kernel.org> wrote:
> 
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
> 
> This will require a larger amount of total work than the current

Yes, there will be a tiny little bit of extra overhead to schedule the job
on to the other work queue.

> scheme.  So we're trading that off against better latency.
> 
> Why is this a good tradeoff?

That is a very good question. Both Hugh and Wei had asked me similar questions
before. +Hugh.

The TL;DR is that it makes the swap more palleralizedable.

Because morden computers typically have more than one CPU and the CPU utilization
is rarely reached to 100%. We are actually not trading the latency for some one
run slower. Most of the time the real impact is that the current swapin page fault
can return quicker so more work can submit to the kernel sooner, at the same time
the other idle CPU can pick up the non latency critical work of freeing of the
swap slot cache entries. The net effect is that we speed things up and increase
the overall system utilization rather than slow things down.

The test result of chromebook and Google production server should be able to show
that it is beneficial to both laptop and server workloads, making them more responsive
in swap related workload.

Chris

