Return-Path: <linux-kernel+bounces-135102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6BE89BB33
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A427283C5D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA833BB50;
	Mon,  8 Apr 2024 09:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dt7IdZ7J"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6494F2B9B3
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712567217; cv=none; b=TH/BQ8PrqQCVEbf8w6R2D1z8w9kGymXrlwDVeEIk54bjYunX+D318uzk60UfakY84qZjY1HqME8jwkRJ+5YNSUP6aZp8L41NjTmKImC92FoKhLvC6h/m8gxgSUH0VLGSw+qlzTR94h9930LvFegFejRfkYhZb0IB3zgyZjhKb08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712567217; c=relaxed/simple;
	bh=WX2clcqIapiLgV4kd+/kSbDTwYbN0xY2asa6XDOMkPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INgQ9smA65Ctv9d3UbtkG0Ud8pN2OkvL6kAB0kDgwgN9R4Jbm/BMEVLmvvkGrpYz0jtKtkA+gTSe9Yyq+1pO5BZkaJGweodPGmVJoesCanB6BQvl8HJzm8bUHD4FFBBYg6bxofkWNC58SgVAkUblBqZLT09w3Rb/Lg5OEYJ8v5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Dt7IdZ7J; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sm9Wn29IGquX2zaks5ZMVq/SXQDZ+cbatvHLSoHIGg4=; b=Dt7IdZ7JyAWYarzPj/osEMPqJ8
	99+FQ7bd/eN8iP3Ooq1m2/xU88WLpO/ByvFCZf4f8EaJ/MC94CZg5S1B3yiC63ys++2DEFoxxSy3e
	NsYY4lmtt5KuX1MNrBZuAjZECWsgm2xVngDIsHd4gNNbze0LxeYxUKnXwhTSPQ6J7ESthdE/hjjtX
	wh3iTvikK42VXINv4alqcWqWh1XYXLA25M8RMxrMylwVDBEHPizo4NhgerUyztyH652q5uqvH9RmX
	mTlEXSyZWvIcGQiMjVGZhz3TDJsgIiDbbjf5T1m/iGXzP1AX0hHtH4uS4ECAhY3bc8Z40P7Dqn5Sg
	0Kz6QtAw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtkxc-0000000H6cQ-0enP;
	Mon, 08 Apr 2024 09:06:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C958430046F; Mon,  8 Apr 2024 11:06:39 +0200 (CEST)
Date: Mon, 8 Apr 2024 11:06:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Chen Yu <yu.c.chen@intel.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
	wuyun.abel@bytedance.com, tglx@linutronix.de, efault@gmx.de,
	yu.chen.surf@gmail.com
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
Message-ID: <20240408090639.GD21904@noisy.programming.kicks-ass.net>
References: <20240405102754.435410987@infradead.org>
 <20240405110010.631664251@infradead.org>
 <ZhEUjX1Nw0y2eJ1o@chenyu5-mobl2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhEUjX1Nw0y2eJ1o@chenyu5-mobl2>

On Sat, Apr 06, 2024 at 05:23:25PM +0800, Chen Yu wrote:

> The 99th wakeup latency increases a little bit, and should be in the acceptible
> range(25 -> 31 us).

Ah, my test runs haven't been stable enough to observe that.

> Meanwhile the throughput increases accordingly. Here are
> the possible reason I can think of:
> 
> 1. wakeup latency: The time to find an eligible entity in the tree
>    during wakeup might take longer - if there are more delayed-dequeue
>    tasks in the tree.

Another possible cause might be that previously a schedule() would be
1 dequeue, 1 pick.

But now it can be much more variable, a pick can basically do N dequeues
and N+1 picks.

So not only do we do more picks, but if you're focussed on worst case
latency, it goes up, because we can do multiple dequeues for a single
pick.

If we find this to really be a problem, I had some half baked ideas to
fix it, but it added significant complexity, so keep it simple until
need proves we need more etc.

> 2. throughput: Inhibit task dequeue can decrease the ratio to touch the
>    task group's load_avg: dequeue_entity()-> { update_load_avg(), update_cfs_group()),
>    which reduces the cache contention among CPUs, and improves throughput.

Ah, yes, there's that.

> > +	} else {
> > +		bool sleep = flags & DEQUEUE_SLEEP;
> > +
> > +		SCHED_WARN_ON(sleep && se->sched_delayed);
> > +		update_curr(cfs_rq);
> > +
> > +		if (sched_feat(DELAY_DEQUEUE) && sleep &&
> > +		    !entity_eligible(cfs_rq, se)) {
> 
> Regarding the elibigle check, it was found that there could be an overflow
> issue, and it brings false negative of entity_eligible(), which was described here:
> https://lore.kernel.org/lkml/20240226082349.302363-1-yu.c.chen@intel.com/
> and also reported on another machine
> https://lore.kernel.org/lkml/ZeCo7STWxq+oyN2U@gmail.com/
> I don't have good idea to avoid that overflow properly, while I'm trying to
> reproduce it locally, do you have any guidance on how to address it?

I have not yet seen those, let me go stare at them now. Thanks!

