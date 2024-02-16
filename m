Return-Path: <linux-kernel+bounces-67948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85734857387
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47F56282DEF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7B4DDAD;
	Fri, 16 Feb 2024 01:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cVLZwPDE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387DDD2FE
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 01:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708047522; cv=none; b=tllZlZDvEPNU6/a5X1mWzmY6ytSeyQmRpR83YVNWOrm2Pws7DpyvKOdXtys9mvHjnD1W2ekmJu8eMoJjc0eFgOKhvjI0s4zp2RUXRjNZvaCCl50kA8c56caGzuL59oSo9WN0RIPcq9Oz52R3HzIXh63AlpTmnre+WKJZmjsf7Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708047522; c=relaxed/simple;
	bh=ECAcYS511vqpTAa8SP0coah5nPqPYbFpybo/Wlr6YQM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=au5SQZT3jSTaBI1pIHYVArQumAb9C8YtOqBJzbuJetRXfS2G8MvGM7FioLcvZCHaJ9JT8jlvq/epd6EE8oJ+La9HYVRnT1lOLF8Lt6mi7JMAu7PTjBlhKLkpUV4AMebytTMWrLgNRa3vGBhuf53h58aKtqeBdpUU2Pn5d6Ndlj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cVLZwPDE; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708047521; x=1739583521;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ECAcYS511vqpTAa8SP0coah5nPqPYbFpybo/Wlr6YQM=;
  b=cVLZwPDE+jxJQcXKJtti51W3WnXZJl3VGEzZwGvEoUK7MGI7vW+4JjFd
   krLXibC9TxJnr5AupOnRa6ZsfeJPmraiHoLl3idFVP7+P0p39ZGa4POPZ
   M1s5V94u5e3rjYMZp1QdkUm4UKhIKmjw9siiU+VGAIfSvVRePuj+zzr1u
   iyoFNQAPkB5MqEYjJ/+J5am+PLHO+7I1HqCaSMq2kWwcmTmwg5RjAieDA
   6gTKEaHprvL/sgIUvtsH6ApGOBZPvNu9m4Yk9UC+1OaxprX3+/J/pO91j
   JxQJVPpi7aINm/uYPchj/EXcLHbfMXoH+ksbJwBL9+66LfMkLrqAIRHlq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2076498"
X-IronPort-AV: E=Sophos;i="6.06,163,1705392000"; 
   d="scan'208";a="2076498"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 17:38:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,163,1705392000"; 
   d="scan'208";a="26859403"
Received: from sgafur-mobl1.amr.corp.intel.com (HELO [10.209.97.128]) ([10.209.97.128])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 17:38:39 -0800
Message-ID: <1b9a69d1ecaac45a228eb2993d5d9b8234a84155.camel@linux.intel.com>
Subject: Re: [PATCH v4] mm: swap: async free swap slot cache entries
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Wei Xu
 <weixugc@google.com>,  Yu Zhao <yuzhao@google.com>, Greg Thelen
 <gthelen@google.com>, Chun-Tse Shao <ctshao@google.com>,  Yosry Ahmed
 <yosryahmed@google.com>, Michal Hocko <mhocko@suse.com>, Mel Gorman
 <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, Nhat Pham
 <nphamcs@gmail.com>, Kairui Song <kasong@tencent.com>, Barry Song
 <v-songbaohua@oppo.com>
Date: Thu, 15 Feb 2024 17:38:38 -0800
In-Reply-To: <20240215161114.6bd444ed839f778eefdf6e0a@linux-foundation.org>
References: <20240214-async-free-v4-1-6abe0d59f85f@kernel.org>
	 <20240215161114.6bd444ed839f778eefdf6e0a@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-15 at 16:11 -0800, Andrew Morton wrote:
> On Wed, 14 Feb 2024 17:02:13 -0800 Chris Li <chrisl@kernel.org> wrote:
>=20
> > We discovered that 1% swap page fault is 100us+ while 50% of
> > the swap fault is under 20us.
> >=20
> > Further investigation shows that a large portion of the time
> > spent in the free_swap_slots() function for the long tail case.
> >=20
> > The percpu cache of swap slots is freed in a batch of 64 entries
> > inside free_swap_slots(). These cache entries are accumulated
> > from previous page faults, which may not be related to the current
> > process.
> >=20
> > Doing the batch free in the page fault handler causes longer
> > tail latencies and penalizes the current process.
> >=20
> > When the swap cache slot is full, schedule async free cached
> > swap slots in a work queue,=C2=A0before the next swap fault comes in.
> > If the next swap fault comes in very fast, before the async
> > free gets a chance to run. It will directly free all the swap
> > cache in the swap fault the same way as previously.
> >=20
> > Testing:
> >=20
> > Chun-Tse did some benchmark in chromebook, showing that
> > zram_wait_metrics improve about 15% with 80% and 95% confidence.
> >=20
> > I recently ran some experiments on about 1000 Google production
> > machines. It shows swapin latency drops in the long tail
> > 100us - 500us bucket dramatically.
> >=20
> > platform	(100-500us)	 	(0-100us)
> > A		1.12% -> 0.36%		98.47% -> 99.22%
> > B		0.65% -> 0.15%		98.96% -> 99.46%
> > C		0.61% -> 0.23%		98.96% -> 99.38%
> >=20
>=20
> What this description lacks is any description of why anyone cares.=20
>=20
> The patch clearly decreases overall throughput (speed-vs-latency is a
> common tradeoff).
>=20
> And the "we don't know how to fix this properly so punt it into a
> kernel thread" approach remains lame.  For example, the risk that the
> now-liberated allocator can outpace the async freeing, resulting in
> unlimited object windup.


Andrew,

What you are saying about outpacing asyn free is true for v1 and v2 version=
s of the patch.

But in this latest version, if another reclaim comes in before the async fr=
ee has kicked in,
we would be freeing the whole cache directly, same as original code, withou=
t waiting
for the async free.  It is different from the first version
where you go into the free one at a time mode while waiting for the async f=
ree.=C2=A0
That was also my objection to the first two versions as you could be in thi=
s
slow free one at a time mode for a long time.

So now we should not have unlimited object windup.  And we would be doing f=
ree
in batch of 64, either still in the direct path or in the async path.

>=20
>=20
> And here's a fun one: what happens if the producer of these objects has
> SCHED_FIFO policy and it's a uniprocessor machine?  If the producer sits
> there allocating objects and the freeing thread never executes?  Has
> this been considered, and tested for?

If the free thread did not execute, in this version of the patch, we would
free the full cache directly, should the allocate path see a full cache. Th=
is works
just as before the patch is applied.=20
So I do not forsee current change reducing throughput.

Current patch does allow a chance to do background free, so it cut down the
chances that allocate path needs to free the cache directly.

That should help the tail latency and the number of times where you have to=
 wait for
the free to be complete. And most of the time, we would not have to do dire=
ct free
ourselves.

Tim
=20
>=20
>=20
> All these concerns, risks and complexity and the changelog offers us no
> reason to take any of this on.  What's wrong with the existing code?=20
> Please exhaustively describe the issues which are being seen.  And
> explain why those issues are sufficiently serious to leave the above
> issues and risks unaddressed.
>=20


