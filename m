Return-Path: <linux-kernel+bounces-112524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 699A6887B21
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 00:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8149281DB8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 23:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14595C61C;
	Sat, 23 Mar 2024 23:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmcewiPA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C49B47A6F;
	Sat, 23 Mar 2024 23:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711238003; cv=none; b=FaISh1LdmOEqUf83BLAP5x995HI6kjxdyDnLWxGePTuWqRnwSarZ+3QcAQGgdToelr81Glh4h1JK1VJCJYc+RCNJHn8Z010eMhTJtcpBa7a/7FAmK7xoY4HAenwjr/ybch9Lbslh/Er0aKlkgjIYEzFwTTYi6eTbRbs3/z7qcrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711238003; c=relaxed/simple;
	bh=vmFfvdVj18dU0VJ6Z1xEA713RcZpihuFHhAv0tF42TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NB3K3AvQXNGyKjrLaYri1doA99NcFCuZZ8Lfz1Mz906G1rrxOM/v1UHitEIZl2uHtF1JqTmTj3T58IK9R/5l6ZCq8BIqLJt/WpBoCqoAU22TMNm7uBiwE4l/jVuxw+Bnj5qVWRdQF9qNpC5yFWSAVyCap8iMQUUHdehqZQwpR9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmcewiPA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47FD8C433F1;
	Sat, 23 Mar 2024 23:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711238002;
	bh=vmFfvdVj18dU0VJ6Z1xEA713RcZpihuFHhAv0tF42TU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=DmcewiPAJNssNaXh3O36mkS5ROlx6MavFxQd0xjT68rtGghRsWh1UL4ogi7EEY4O4
	 AZiBifCSWEQ+RAjEswHukfqQMrKeSYpmHqxSnT/PDDKAWtFMF+96ZO6Ua6mPVq5mdz
	 5qVyE+Gwe46zqJevDKswhok98roJJm35xaF47ikfljopfv8ecle6PQK2CA19lsUZN3
	 I07tNDfAJC7t4yqrzayWhXu7sh/IpzT4uhby/pZImQDRofWyIYUhbiK//dyTMVfj7A
	 2H4OFPvJ7VbWQj8ukU0vGxJM8uD98Ahwy09vtouqLqlJkfCxmqVIK9RiW+NB2ixm0m
	 T5ae6vytnszCw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DD192CE0738; Sat, 23 Mar 2024 16:53:21 -0700 (PDT)
Date: Sat, 23 Mar 2024 16:53:21 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Yan Zhai <yan@cloudflare.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@cloudflare.com,
	Joel Fernandes <joel@joelfernandes.org>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com,
	Jesper Dangaard Brouer <hawk@kernel.org>
Subject: Re: [PATCH v5 net 1/3] rcu: add a helper to report consolidated
 flavor QS
Message-ID: <327fa73b-a7b3-4ad4-b170-d642c83e8764@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <cover.1710877680.git.yan@cloudflare.com>
 <90431d46ee112d2b0af04dbfe936faaca11810a5.1710877680.git.yan@cloudflare.com>
 <20240322112413.1UZFdBq5@linutronix.de>
 <123ca494-dc8c-47cc-a6d5-3c529bc7f549@paulmck-laptop>
 <CAO3-PbqRztEC1JFg3SrgUi9a404Xpou_Xx9_mxXoZVY-KVkyGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO3-PbqRztEC1JFg3SrgUi9a404Xpou_Xx9_mxXoZVY-KVkyGg@mail.gmail.com>

On Fri, Mar 22, 2024 at 09:02:02PM -0500, Yan Zhai wrote:
> On Fri, Mar 22, 2024 at 4:31 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Fri, Mar 22, 2024 at 12:24:13PM +0100, Sebastian Andrzej Siewior wrote:
> > > On 2024-03-19 13:44:34 [-0700], Yan Zhai wrote:
> > > > + * The macro is not needed when CONFIG_PREEMPT_RT is defined. RT kernels would
> > > > + * have more chance to invoke schedule() calls and provide necessary quiescent
> > > > + * states. As a contrast, calling cond_resched() only won't achieve the same
> > > > + * effect because cond_resched() does not provide RCU-Tasks quiescent states.
> > > > + */
> > >
> > > Paul, so CONFIG_PREEMPTION is affected but CONFIG_PREEMPT_RT is not.
> > > Why does RT have more scheduling points?
> >
> > In RT, isn't BH-disabled code preemptible?  But yes, this would not help
> > RCU Tasks.
> >
> By "more chance to invoke schedule()", my thought was that
> cond_resched becomes no op on RT or PREEMPT kernel. So it will not
> call __schedule(SM_PEREEMPT), which clears the NEED_RESCHED flag. On a
> normal irq exit like timer, when NEED_RESCHED is on,
> schedule()/__schedule(0) can be called time by time then.
> __schedule(0) is good for RCU tasks, __schedule(SM_PREEMPT) is not.
> 
> But I think this code comment does not take into account frequent
> preempt_schedule and irqentry_exit_cond_resched on a PREEMPT kernel.
> When returning to these busy kthreads, irqentry_exit_cond_resched is
> in fact called now, not schedule(). So likely __schedule(PREEMPT) is
> still called frequently, or even more frequently. So the code comment
> looks incorrect on the RT argument part. We probably should remove the
> "IS_ENABLED" condition really. Paul and Sebastian, does this sound
> reasonable to you?

Removing the "IS_ENABLED(CONFIG_PREEMPT_RT)" condition makes a great deal
of sense to me, but I must defer to Sebastian for any RT implications.

							Thanx, Paul

