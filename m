Return-Path: <linux-kernel+bounces-94918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDB88746B5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ED0A1C233C7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC40AFBE1;
	Thu,  7 Mar 2024 03:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gII1qw7/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE61256A;
	Thu,  7 Mar 2024 03:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709781675; cv=none; b=JL/wJKK6Ctz/tF4ptFOlH1uTEVZ6fOLRWopxMuHZyY18xuKcFfIE0As9LWCKTvBPo9qr69V1C2fxXavb+5HK0erdGO8SZp3J+WMWZUjuLIOW+jaDFBs3wvTJjK9Cu1e/J01L8zThIEJV8XE1dx9srWq4PCt6OWJSSpFuTQbBv/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709781675; c=relaxed/simple;
	bh=R3r8aed7QQnLsT5x8UC68VMocsgE4tGhtiF86qynzQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbT9hcAQzuib7q1UnXRcvGX8zHH3A4rfHiACP/xnukopjsPQeuzDgAuAIqPCop7j5LZ208qVrz6Rn7XFd/2nylz4STPPUufMd0GhliUXeH7OqWn8sR5bVo+Luqeh7sDibXrCY153qg86sJs48AYkcoiRPbjZWiPM4rId7CXshzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gII1qw7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D695C433F1;
	Thu,  7 Mar 2024 03:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709781674;
	bh=R3r8aed7QQnLsT5x8UC68VMocsgE4tGhtiF86qynzQk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=gII1qw7/OvK7H92us4PBqkvP5TNQeqHnPIhAzmlWivD5rKSkuKVHTDVUiZ8s5Htl6
	 /iony4IiJIYFjJY7uID2fRIef0BxEOoqT+ZUatPu50ppz5qwHCBDW0ye4sA4Hdc4E/
	 02V0yVXS0456PzIM20hJ7DHT+ZaNi2ndnZfAc+KWtM/xPBHE/DNO214sIS/FNQJiSG
	 +EyLCCe4BVffCDyaD/9BEIS6JiFm6x4hjvpVPf4pqjcsSKBHyuEfAlFKmJL/0gCrrf
	 lx9ZNeCWindjbgm3NAUHbmwjIDnoGhxHjkPb5vUTly1uO7IklXFRIBrxFkcBiLTr4d
	 5r7W+8Sxc1mdQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2C449CE10B8; Wed,  6 Mar 2024 19:21:14 -0800 (PST)
Date: Wed, 6 Mar 2024 19:21:14 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linke li <lilinke99@qq.com>,
	joel@joelfernandes.org, boqun.feng@gmail.com, dave@stgolabs.net,
	frederic@kernel.org, jiangshanlai@gmail.com, josh@joshtriplett.org,
	linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	qiang.zhang1211@gmail.com, quic_neeraju@quicinc.com,
	rcu@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Fix
 rcu_torture_pipe_update_one()/rcu_torture_writer() data race and concurrency
 bug
Message-ID: <29a20fd4-ac5e-44a3-bc8a-9f77aa6a3cf9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <27665890-8314-4252-8622-1e019fee27e4@paulmck-laptop>
 <20240306130103.6da71ddf@gandalf.local.home>
 <CAHk-=wgG6Dmt1JTXDbrbXh_6s2yLjL=9pHo7uv0==LHFD+aBtg@mail.gmail.com>
 <20240306135504.2b3872ef@gandalf.local.home>
 <CAHk-=wjbDgMKLgxbV+yK4LKZ+2Qj6zVL_sHeb+L9KDia980Q8Q@mail.gmail.com>
 <20240306142738.7b66a716@rorschach.local.home>
 <CAHk-=wgPAZ4KnCQergqAOUypwinYh=gZ0q4EQbwvuUcJ_8UK+Q@mail.gmail.com>
 <83b47424-e5e0-46de-aa63-d413a5aa6cec@paulmck-laptop>
 <CAHk-=wiX_zF5Mpt8kUm_LFQpYY-mshrXJPOe+wKNwiVhEUcU9g@mail.gmail.com>
 <CAHk-=wi7rJ-eGq+xaxVfzFEgbL9tdf6Kc8Z89rCpfcQOKm74Tw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi7rJ-eGq+xaxVfzFEgbL9tdf6Kc8Z89rCpfcQOKm74Tw@mail.gmail.com>

On Wed, Mar 06, 2024 at 06:49:38PM -0800, Linus Torvalds wrote:
> On Wed, 6 Mar 2024 at 18:43, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I dunno.
> 
> Oh, and just looking at that patch, I still think the code is confused.
> 
> On the reading side, we have:
> 
>     pipe_count = smp_load_acquire(&p->rtort_pipe_count);
>     if (pipe_count > RCU_TORTURE_PIPE_LEN) {
>         /* Should not happen, but... */
> 
> where that comment clearly says that the pipe_count we read (whether
> with READ_ONCE() or with my smp_load_acquire() suggestion) should
> never be larger than RCU_TORTURE_PIPE_LEN.

I will fix that comment.  It should not happen *if* RCU is working
correctly.  It can happen if you have an RCU that is so broken that a
single RCU reader can span more than ten grace periods.  An example of
an RCU that really is this broken can be selected using rcutorture's
torture_type=busted module parameter.  No surprise, given that its
implementation of call_rcu() invokes the callback function directly and
its implementation of synchronize_rcu() is a complete no-op.  ;-)

Of course, the purpose of that value of the torture_type module parameter
(along with all other possible values containing the string "busted")
is to test rcutorture itself.

> But the writing side very clearly did:
> 
>     i = rp->rtort_pipe_count;
>     if (i > RCU_TORTURE_PIPE_LEN)
>         i = RCU_TORTURE_PIPE_LEN;
>     ...
>     smp_store_release(&rp->rtort_pipe_count, ++i);
> 
> (again, syntactically it could have been "i + 1" instead of my "++i" -
> same value), so clearly the writing side *can* write a value that is >
> RCU_TORTURE_PIPE_LEN.
> 
> So while the whole READ/WRITE_ONCE vs smp_load_acquire/store_release
> is one thing that might be worth looking at, I think there are other
> very confusing aspects here.

With this change in that comment, are things better?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 6b821a7037b03..0cb5452ecd945 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2000,7 +2000,8 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 	preempt_disable();
 	pipe_count = READ_ONCE(p->rtort_pipe_count);
 	if (pipe_count > RCU_TORTURE_PIPE_LEN) {
-		/* Should not happen, but... */
+		// Should not happen in a correct RCU implementation,
+		// happens quite often for torture_type=busted.
 		pipe_count = RCU_TORTURE_PIPE_LEN;
 	}
 	completed = cur_ops->get_gp_seq();

