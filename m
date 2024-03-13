Return-Path: <linux-kernel+bounces-102247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0358187AFC7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E6091F2D94A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845D37E588;
	Wed, 13 Mar 2024 17:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dC+zXIn5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBAE61695;
	Wed, 13 Mar 2024 17:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710350137; cv=none; b=S5CeyvgWZnJDuMvyTmpIGDZUhFZd4XgndQwQfy8ZMtxvOYVv0Ua0NTxhJAQDekoO06Oyuw9QX/C1jGlX+4KxnNvpIm8XkwBsNoMK9rg/jcp3FbSpFsQiTO5Dl5kDvL7sV2BwoCxy99HVx8uJjspOjLH8L2wonsvf7QngAx+0lKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710350137; c=relaxed/simple;
	bh=VfLLMBYJ7ZbrxzPQlOWmKstL6wQtiNpJGw3g2hYtDYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnxdMnB8B1GMh/4N6lYlrpoxHceQuwTOSl98kVVGsCSFHLqisQTLbVO/KiyrCf2o/aM3pnYyXcuI/g5UyNK9t5Mahyg2IIWgNFZnkdTCXPOZxwiQDpfDtYNpVkg1sKGkMo/hEy5DcbfqGW6eRsXzzPiDjwRZYyjlt5GVaN0CxxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dC+zXIn5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0F3C43390;
	Wed, 13 Mar 2024 17:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710350137;
	bh=VfLLMBYJ7ZbrxzPQlOWmKstL6wQtiNpJGw3g2hYtDYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dC+zXIn5S5zOkwKcgCm+Wg8T/clWgDilAShHsIegkQi7mmJ7xFgmym82oy3nmS97R
	 O9zSDKGQdAxlTJFoWGyaoCzCsFVv6+CpektEekcEODZvGPtHxSMoCTR4t0xRKbtVkE
	 4NdWT69ZvD0mr+4gie+y50f7KTCVPta040Ftod3DLxiVtf0W3PiLxI9PrV/rYnxNfp
	 R0oQa3y5JtzMPjSwKjaziSsDo1Ehh5vLyWKvvLqs31xvKQGEOi4Mh7ADD9zDvNyP0i
	 ik4g6c3YrGEdUlNaTZEnSiNe/4o7lXW5A81f5epJsXj6Wgp1l+6VyBqW8C3c+qJ4yZ
	 hD6NFx7QnJ5wA==
Date: Wed, 13 Mar 2024 18:15:34 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: paulmck@kernel.org, joel@joelfernandes.org, josh@joshtriplett.org,
	boqun.feng@gmail.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org
Subject: Re: [PATCH] rcu: Reduce synchronize_rcu() delays when all wait heads
 are in use
Message-ID: <ZfHfNo_J-XZX0BS3@localhost.localdomain>
References: <20240313083228.233247-1-Neeraj.Upadhyay@amd.com>
 <ZfHDwPkPHulJHrD0@localhost.localdomain>
 <35e009c4-d52c-4b96-ba10-afa0be9dfd5e@amd.com>
 <ZfHXrTUHRhAVjBOE@localhost.localdomain>
 <33ff03f7-0301-42fb-842f-17f21426cdc7@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33ff03f7-0301-42fb-842f-17f21426cdc7@amd.com>

Le Wed, Mar 13, 2024 at 10:24:58PM +0530, Neeraj Upadhyay a écrit :
> Hi Frederic,
> 
> On 3/13/2024 10:13 PM, Frederic Weisbecker wrote:
> > Le Wed, Mar 13, 2024 at 09:41:58PM +0530, Neeraj Upadhyay a écrit :
> >> Hi Frederic,
> >>
> >> On 3/13/2024 8:48 PM, Frederic Weisbecker wrote:
> >>> Le Wed, Mar 13, 2024 at 02:02:28PM +0530, Neeraj Upadhyay a écrit :
> >>>> When all wait heads are in use, which can happen when
> >>>> rcu_sr_normal_gp_cleanup_work()'s callback processing
> >>>> is slow, any new synchronize_rcu() user's rcu_synchronize
> >>>> node's processing is deferred to future GP periods. This
> >>>> can result in long list of synchronize_rcu() invocations
> >>>> waiting for full grace period processing, which can delay
> >>>> freeing of memory. Mitigate this problem by using first
> >>>> node in the list as wait tail when all wait heads are in use.
> >>>> While methods to speed up callback processing would be needed
> >>>> to recover from this situation, allowing new nodes to complete
> >>>> their grace period can help prevent delays due to a fixed
> >>>> number of wait head nodes.
> >>>>
> >>>> Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> >>>> ---
> >>>>  kernel/rcu/tree.c | 27 +++++++++++++--------------
> >>>>  1 file changed, 13 insertions(+), 14 deletions(-)
> >>>>
> >>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> >>>> index 9fbb5ab57c84..bdccce1ed62f 100644
> >>>> --- a/kernel/rcu/tree.c
> >>>> +++ b/kernel/rcu/tree.c
> >>>> @@ -1470,14 +1470,11 @@ static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
> >>>>   * for this new grace period. Given that there are a fixed
> >>>>   * number of wait nodes, if all wait nodes are in use
> >>>>   * (which can happen when kworker callback processing
> >>>> - * is delayed) and additional grace period is requested.
> >>>> - * This means, a system is slow in processing callbacks.
> >>>> - *
> >>>> - * TODO: If a slow processing is detected, a first node
> >>>> - * in the llist should be used as a wait-tail for this
> >>>> - * grace period, therefore users which should wait due
> >>>> - * to a slow process are handled by _this_ grace period
> >>>> - * and not next.
> >>>> + * is delayed), first node in the llist is used as wait
> >>>> + * tail for this grace period. This means, the first node
> >>>> + * has to go through additional grace periods before it is
> >>>> + * part of the wait callbacks. This should be ok, as
> >>>> + * the system is slow in processing callbacks anyway.
> >>>>   *
> >>>>   * Below is an illustration of how the done and wait
> >>>>   * tail pointers move from one set of rcu_synchronize nodes
> >>>> @@ -1725,15 +1722,17 @@ static bool rcu_sr_normal_gp_init(void)
> >>>>  		return start_new_poll;
> >>>>  
> >>>>  	wait_head = rcu_sr_get_wait_head();
> >>>> -	if (!wait_head) {
> >>>> -		// Kick another GP to retry.
> >>>> +	if (wait_head) {
> >>>> +		/* Inject a wait-dummy-node. */
> >>>> +		llist_add(wait_head, &rcu_state.srs_next);
> >>>> +	} else {
> >>>> +		// Kick another GP for first node.
> >>>>  		start_new_poll = true;
> >>>> -		return start_new_poll;
> >>>> +		if (first == rcu_state.srs_done_tail)
> >>>> +			return start_new_poll;
> >>>> +		wait_head = first;
> >>>
> >>> This means you're setting a non-wait-head as srs_wait_tail, right?
> >>> Doesn't it trigger the following warning in rcu_sr_normal_gp_cleanup():
> >>>
> >>> 	WARN_ON_ONCE(!rcu_sr_is_wait_head(wait_tail));
> >>>
> >>
> >> Oh I missed it. Will fix it, thanks!
> >>
> >>> Also there is a risk that this non-wait-head gets later assigned as
> >>> rcu_state.srs_done_tail. And then this pending sr may not be completed
> >>> until the next grace period calling rcu_sr_normal_gp_cleanup()? (Because
> >>> the work doesn't take care of rcu_state.srs_done_tail itself). And then
> >>> the delay can be arbitrary.
> >>>
> >>
> >> That is correct. Only the first node suffers from deferred GP.
> >> If there are large number of callbacks which got added after
> >> last available wait head was queued, all those callbacks (except one)
> >> can still have a GP assigned to them.
> >>
> >>> And the next grace period completing this sr (that non-wait-head set
> >>> as rcu_state.srs_done_tail) and thus allowing its caller to wipe it out
> >>> of its stack may race with the cleanup work dereferencing it?
> >>>
> >>
> >> This sr can only be completed when done tail moves to new node. Till
> >> then, it gets deferred continuously. So, we won't be entering into
> >> the situation where the sr processing is complete while done tail is pointing
> >> to it. Please correct me if I am missing something here.
> > 
> > Ok I'm confused as usual. Let's take a practical case. Is the following
> > sequence possible?
> > 
> > 1) wait_tail = NULL
> >    done_tail = WH4->SR4->WH3->SR3->WH2->SR2->WH1->SR1...
> > 
> > Initial layout
> > 
> > 2) wait_tail = SR5 -> WH4...
> >    done_tail = WH4->SR4->WH3->SR3->WH2->SR2->WH1->SR1...
> > 
> > New GP
> > 
> > 3) wait_tail = NULL
> >    done_tail = SR5->WH4->SR4->WH3->SR3->WH2->SR2->WH1->SR1...
> > 
> > GP completes, normal cleanup
> > 
> > 3) wait_tail = SR6->SR5...
> >    done_tail = SR5->WH4->SR4->WH3->SR2->WH2->SR1->WH1->SR1...
> > 
> > New GP
> > 
> > 4) GP completes and SR5 is completed by rcu_sr_normal_gp_cleanup(). So
> >    the caller releases it from the stack. But before rcu_sr_normal_gp_cleanup()
> >    overwrites done_tail to SR6->WH4->SR4.... , the workqueue manages to run
> >    and concurrently dereferences SR5.
> > 
> > But I bet I'm missing something obvious in the middle, preventing that...
> 
> Your analysis looks correct to me. Maybe, one way to fix this can be that
> rcu_sr_normal_gp_cleanup() stops processing nodes in its context,
> when it reaches done tail and done tail is not a wait head. I will
> think more on this, thanks!

That alone is probably not enough. In the end you may end up with a real
pending sr stuck as done tail without completion, until one day a
new real queue comes up, preferably with a real wait head in order not
to get stuck with a new sr as done tail.

> 
> 
> Thanks
> Neeraj

