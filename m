Return-Path: <linux-kernel+bounces-10920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AEA81DEC1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 08:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD2B61C20F3D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 07:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5010A15C8;
	Mon, 25 Dec 2023 07:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kzFumd3k"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCDE15A8
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 07:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703488205; x=1735024205;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=dzZ7z0rN7lG5oRVUv+N/PVnDDGgfhgQlgF7xn3bk66Y=;
  b=kzFumd3kXa0yZe4phuN0ozeMKj7dsuTWAUWuOxZQEuusshWZIiJV2gHk
   wzhId5cuPDtzJsQdT9Juyx7rWQygRR9FANU2TUaoDFqgLB1zJgkcLl3Wb
   CbqPVCTJFKR0y0hz2lN3vOvyFZ/Qacws2iqjjzp/FizNYGqLwLlYoLqL4
   k04nLzbUN6ijl9XrSXpwzE7TM0t1g8k+GCRyY0WUbtNnLC3ZXOx0nSE2/
   SL+MmEN5PMnN27EADlNNlWWw0sCNXoEbRJ+KqXzhUBsVPbGUFR8mqDR8N
   ZuNTLLHpSjEP9eiqybvvjmq1KRsAOC+ONfw0jA07TN3w3ThqcRpdc2z2B
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="3105348"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="3105348"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 23:10:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="806604119"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="806604119"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 23:09:58 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  Wei Xu
 <weixugc@google.com>,  Yu Zhao <yuzhao@google.com>,  Greg Thelen
 <gthelen@google.com>,  Chun-Tse Shao <ctshao@google.com>,  Suren
 Baghdasaryan <surenb@google.com>,  Yosry Ahmed <yosryahmed@google.com>,
  Brain Geffon <bgeffon@google.com>,  Minchan Kim <minchan@kernel.org>,
  Michal Hocko <mhocko@suse.com>,  Mel Gorman
 <mgorman@techsingularity.net>,  Nhat Pham <nphamcs@gmail.com>,  Johannes
 Weiner <hannes@cmpxchg.org>,  Kairui Song <kasong@tencent.com>,  Zhongkun
 He <hezhongkun.hzk@bytedance.com>,  Kemeng Shi
 <shikemeng@huaweicloud.com>,  Barry Song <v-songbaohua@oppo.com>,  Hugh
 Dickins <hughd@google.com>, Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH] mm: swap: async free swap slot cache entries
In-Reply-To: <ZYYY1VBKdLHH-Kl3@google.com> (Chris Li's message of "Fri, 22 Dec
	2023 15:16:37 -0800")
References: <20231221-async-free-v1-1-94b277992cb0@kernel.org>
	<20231222115208.ab4d2aeacdafa4158b14e532@linux-foundation.org>
	<ZYYY1VBKdLHH-Kl3@google.com>
Date: Mon, 25 Dec 2023 15:07:59 +0800
Message-ID: <87o7eeg3ow.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Chris Li <chrisl@kernel.org> writes:

> On Fri, Dec 22, 2023 at 11:52:08AM -0800, Andrew Morton wrote:
>> On Thu, 21 Dec 2023 22:25:39 -0800 Chris Li <chrisl@kernel.org> wrote:
>> 
>> > We discovered that 1% swap page fault is 100us+ while 50% of
>> > the swap fault is under 20us.
>> > 
>> > Further investigation show that a large portion of the time
>> > spent in the free_swap_slots() function for the long tail case.
>> > 
>> > The percpu cache of swap slots is freed in a batch of 64 entries
>> > inside free_swap_slots(). These cache entries are accumulated
>> > from previous page faults, which may not be related to the current
>> > process.
>> > 
>> > Doing the batch free in the page fault handler causes longer
>> > tail latencies and penalizes the current process.
>> > 
>> > Move free_swap_slots() outside of the swapin page fault handler into an
>> > async work queue to avoid such long tail latencies.
>> 
>> This will require a larger amount of total work than the current
>
> Yes, there will be a tiny little bit of extra overhead to schedule the job
> on to the other work queue.
>
>> scheme.  So we're trading that off against better latency.
>> 
>> Why is this a good tradeoff?
>
> That is a very good question. Both Hugh and Wei had asked me similar questions
> before. +Hugh.
>
> The TL;DR is that it makes the swap more palleralizedable.
>
> Because morden computers typically have more than one CPU and the CPU utilization
> is rarely reached to 100%. We are actually not trading the latency for some one
> run slower. Most of the time the real impact is that the current swapin page fault
> can return quicker so more work can submit to the kernel sooner, at the same time
> the other idle CPU can pick up the non latency critical work of freeing of the
> swap slot cache entries. The net effect is that we speed things up and increase
> the overall system utilization rather than slow things down.

You solution depends on there is enough idle time in the system.  This
isn't always true.

In general, all async solutions have 2 possible issues.

a) Unrelated applications may be punished.  Because they may wait for
CPU which is running the async operations.  In the original solution,
the application swap more will be punished.

b) The CPU time cannot be charged to appropriate applications.  The
original behavior isn't perfect too.  But it's better than async worker.

Given the runtime of worker is at 100us level, these issues may be not
severe.  But I think that you may need to explain them at least.

And, when swap slots freeing batching was introduced, it was mainly used
to reduce the lock contention of sis->lock (via swap_info_get_cont()).
So, we may move some operations (e.g., mem_cgroup_uncharge_swap,
clear_shadow_from_swap_cache(), etc.) out of batched operation (before
calling free_swap_slot()) to reduce the latency impact.

> The test result of chromebook and Google production server should be able to show
> that it is beneficial to both laptop and server workloads, making them more responsive
> in swap related workload.

--
Best Regards,
Huang, Ying

