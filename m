Return-Path: <linux-kernel+bounces-67881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB26857249
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 085CA281B3A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250A6819;
	Fri, 16 Feb 2024 00:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="2JnqoC7T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6607F9
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 00:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708042276; cv=none; b=kktg2yVEHW6CQZHAxhz/qayRXhihM/9I2nnAYziD7NIVcAaidVDXLn5+W+NmBcNmkUyZK82SZI7+oiVdXkY9rpdYGomEjiOpF08sHOTS0hi1Bg4ai0V29af8T8MgkoLLlEHZoMiShBkF28NtShBO5EMC/hq682dA0nrSXupEoHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708042276; c=relaxed/simple;
	bh=Fn3qWD1l8WtNeMT36sgkXFrzcnjkumD5gzR7J9xNGow=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZjcSxhPQ5h2iU0VpTH/sSX3LqVwB9+fleaGTzx0p2SgfiNzH5CcYtcaMcereSSAbpEyY70S7lUR8iL4KaL+cW+eXxiTCdO+rHtqbGebmiM+mgcaEpH8QlzHFjT7889QiXImnaeYFG5dvwpwcirzybrbD35ULu6k7adjnYanV02E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=2JnqoC7T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9F0C433F1;
	Fri, 16 Feb 2024 00:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708042275;
	bh=Fn3qWD1l8WtNeMT36sgkXFrzcnjkumD5gzR7J9xNGow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=2JnqoC7T7PFPayFBUfvmx2p43g3EwjuraCfHTdMXSi8hUfbXagstUKaiPR3VI9B9z
	 eNZeJKcSNM+64t+t+STnMcoNdQD2nTDhc0G0pClYP0t32vtXILpxlQ0PiPFoxhbPVC
	 xdL5h7l70ILmglM4+2wQS0EztFTId16TUkja23S0=
Date: Thu, 15 Feb 2024 16:11:14 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Chris Li <chrisl@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Wei Xu
 <weixugc@google.com>, Yu Zhao <yuzhao@google.com>, Greg Thelen
 <gthelen@google.com>, Chun-Tse Shao <ctshao@google.com>, Yosry Ahmed
 <yosryahmed@google.com>, Michal Hocko <mhocko@suse.com>, Mel Gorman
 <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, Nhat Pham
 <nphamcs@gmail.com>, Kairui Song <kasong@tencent.com>, Barry Song
 <v-songbaohua@oppo.com>, Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v4] mm: swap: async free swap slot cache entries
Message-Id: <20240215161114.6bd444ed839f778eefdf6e0a@linux-foundation.org>
In-Reply-To: <20240214-async-free-v4-1-6abe0d59f85f@kernel.org>
References: <20240214-async-free-v4-1-6abe0d59f85f@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Feb 2024 17:02:13 -0800 Chris Li <chrisl@kernel.org> wrote:

> We discovered that 1% swap page fault is 100us+ while 50% of
> the swap fault is under 20us.
>=20
> Further investigation shows that a large portion of the time
> spent in the free_swap_slots() function for the long tail case.
>=20
> The percpu cache of swap slots is freed in a batch of 64 entries
> inside free_swap_slots(). These cache entries are accumulated
> from previous page faults, which may not be related to the current
> process.
>=20
> Doing the batch free in the page fault handler causes longer
> tail latencies and penalizes the current process.
>=20
> When the swap cache slot is full, schedule async free cached
> swap slots in a work queue,=A0before the next swap fault comes in.
> If the next swap fault comes in very fast, before the async
> free gets a chance to run. It will directly free all the swap
> cache in the swap fault the same way as previously.
>=20
> Testing:
>=20
> Chun-Tse did some benchmark in chromebook, showing that
> zram_wait_metrics improve about 15% with 80% and 95% confidence.
>=20
> I recently ran some experiments on about 1000 Google production
> machines. It shows swapin latency drops in the long tail
> 100us - 500us bucket dramatically.
>=20
> platform	(100-500us)	 	(0-100us)
> A		1.12% -> 0.36%		98.47% -> 99.22%
> B		0.65% -> 0.15%		98.96% -> 99.46%
> C		0.61% -> 0.23%		98.96% -> 99.38%
>=20

What this description lacks is any description of why anyone cares.=20

The patch clearly decreases overall throughput (speed-vs-latency is a
common tradeoff).

And the "we don't know how to fix this properly so punt it into a
kernel thread" approach remains lame.  For example, the risk that the
now-liberated allocator can outpace the async freeing, resulting in
unlimited object windup.

And here's a fun one: what happens if the producer of these objects has
SCHED_FIFO policy and it's a uniprocessor machine?  If the producer sits
there allocating objects and the freeing thread never executes?  Has
this been considered, and tested for?


All these concerns, risks and complexity and the changelog offers us no
reason to take any of this on.  What's wrong with the existing code?=20
Please exhaustively describe the issues which are being seen.  And
explain why those issues are sufficiently serious to leave the above
issues and risks unaddressed.


