Return-Path: <linux-kernel+bounces-101996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B755B87AD6F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E89971C2222B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5769114A4C3;
	Wed, 13 Mar 2024 16:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlAO3/Bw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4B314A0A3;
	Wed, 13 Mar 2024 16:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348208; cv=none; b=hSFv5uvPKnXM1RooC0fOdMbosY2ztKgbQHhUn6wSYVuVM6k9p7PSvjWx/L/Nz7PYlz+HxUcq/fjC6hqhbUfEb/KLYG3yZhXAJyGga/EeDJ98MAtYI2kgF8eVs4LlQ4lCTbxTp9iLD56e0XsPQEbV10ZGUzqh19HahTCevZn7Bso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348208; c=relaxed/simple;
	bh=IDlEN0E8MowaTytU4EKxm/sGXa1OtfRb3YalHLIr5/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9R4UZKN16h2X1CPaJCGmrSZ3T7InBDbfgixjpzYmEL6iAua8OvZUBX3spNMxhJgtY7kcWzo6JkQfDQfXJzHkW9HfTAeEFLSetRSeiFW5TyFySI1C5LcC1LX6iqzJPQwjZyf/TtoBQZjtkovI4rLURUg648zeMv9/aGWw3fYR7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlAO3/Bw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE470C433A6;
	Wed, 13 Mar 2024 16:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348208;
	bh=IDlEN0E8MowaTytU4EKxm/sGXa1OtfRb3YalHLIr5/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IlAO3/BwXxIloSJ6WWq3OX990c6cYuw7j6ytd633qw/SjAAg3xX32lfm+ybZm4x+P
	 rCtBOycAzJD6A5HebnXZGefLMyU7mWMM/C9E29DugrPNpqKI4eCe2J40hz16IpBdx1
	 U8O0qrjnDPBdWqWIgXPwSkh7uQwquAOA8yWw3mrlR6/6OxoVafVioAwKwgt7AgVhjs
	 xPmUrVk4ILAiT8Or+zI2rDZjuL+a+7Kxxt/ZU+7EYe5KeV7/Aakjge200q72sTwCF0
	 Ri0aPRqtfrLxbEv5a+6CdxSMr+eD8DR5Hus9QLg2R158UhBtSH5oFWazly2HKq8pj/
	 9TKwnZI1meTNQ==
Date: Wed, 13 Mar 2024 17:43:25 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: paulmck@kernel.org, joel@joelfernandes.org, josh@joshtriplett.org,
	boqun.feng@gmail.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org
Subject: Re: [PATCH] rcu: Reduce synchronize_rcu() delays when all wait heads
 are in use
Message-ID: <ZfHXrTUHRhAVjBOE@localhost.localdomain>
References: <20240313083228.233247-1-Neeraj.Upadhyay@amd.com>
 <ZfHDwPkPHulJHrD0@localhost.localdomain>
 <35e009c4-d52c-4b96-ba10-afa0be9dfd5e@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35e009c4-d52c-4b96-ba10-afa0be9dfd5e@amd.com>

Le Wed, Mar 13, 2024 at 09:41:58PM +0530, Neeraj Upadhyay a écrit :
> Hi Frederic,
> 
> On 3/13/2024 8:48 PM, Frederic Weisbecker wrote:
> > Le Wed, Mar 13, 2024 at 02:02:28PM +0530, Neeraj Upadhyay a écrit :
> >> When all wait heads are in use, which can happen when
> >> rcu_sr_normal_gp_cleanup_work()'s callback processing
> >> is slow, any new synchronize_rcu() user's rcu_synchronize
> >> node's processing is deferred to future GP periods. This
> >> can result in long list of synchronize_rcu() invocations
> >> waiting for full grace period processing, which can delay
> >> freeing of memory. Mitigate this problem by using first
> >> node in the list as wait tail when all wait heads are in use.
> >> While methods to speed up callback processing would be needed
> >> to recover from this situation, allowing new nodes to complete
> >> their grace period can help prevent delays due to a fixed
> >> number of wait head nodes.
> >>
> >> Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> >> ---
> >>  kernel/rcu/tree.c | 27 +++++++++++++--------------
> >>  1 file changed, 13 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> >> index 9fbb5ab57c84..bdccce1ed62f 100644
> >> --- a/kernel/rcu/tree.c
> >> +++ b/kernel/rcu/tree.c
> >> @@ -1470,14 +1470,11 @@ static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
> >>   * for this new grace period. Given that there are a fixed
> >>   * number of wait nodes, if all wait nodes are in use
> >>   * (which can happen when kworker callback processing
> >> - * is delayed) and additional grace period is requested.
> >> - * This means, a system is slow in processing callbacks.
> >> - *
> >> - * TODO: If a slow processing is detected, a first node
> >> - * in the llist should be used as a wait-tail for this
> >> - * grace period, therefore users which should wait due
> >> - * to a slow process are handled by _this_ grace period
> >> - * and not next.
> >> + * is delayed), first node in the llist is used as wait
> >> + * tail for this grace period. This means, the first node
> >> + * has to go through additional grace periods before it is
> >> + * part of the wait callbacks. This should be ok, as
> >> + * the system is slow in processing callbacks anyway.
> >>   *
> >>   * Below is an illustration of how the done and wait
> >>   * tail pointers move from one set of rcu_synchronize nodes
> >> @@ -1725,15 +1722,17 @@ static bool rcu_sr_normal_gp_init(void)
> >>  		return start_new_poll;
> >>  
> >>  	wait_head = rcu_sr_get_wait_head();
> >> -	if (!wait_head) {
> >> -		// Kick another GP to retry.
> >> +	if (wait_head) {
> >> +		/* Inject a wait-dummy-node. */
> >> +		llist_add(wait_head, &rcu_state.srs_next);
> >> +	} else {
> >> +		// Kick another GP for first node.
> >>  		start_new_poll = true;
> >> -		return start_new_poll;
> >> +		if (first == rcu_state.srs_done_tail)
> >> +			return start_new_poll;
> >> +		wait_head = first;
> > 
> > This means you're setting a non-wait-head as srs_wait_tail, right?
> > Doesn't it trigger the following warning in rcu_sr_normal_gp_cleanup():
> > 
> > 	WARN_ON_ONCE(!rcu_sr_is_wait_head(wait_tail));
> > 
> 
> Oh I missed it. Will fix it, thanks!
> 
> > Also there is a risk that this non-wait-head gets later assigned as
> > rcu_state.srs_done_tail. And then this pending sr may not be completed
> > until the next grace period calling rcu_sr_normal_gp_cleanup()? (Because
> > the work doesn't take care of rcu_state.srs_done_tail itself). And then
> > the delay can be arbitrary.
> > 
> 
> That is correct. Only the first node suffers from deferred GP.
> If there are large number of callbacks which got added after
> last available wait head was queued, all those callbacks (except one)
> can still have a GP assigned to them.
> 
> > And the next grace period completing this sr (that non-wait-head set
> > as rcu_state.srs_done_tail) and thus allowing its caller to wipe it out
> > of its stack may race with the cleanup work dereferencing it?
> > 
> 
> This sr can only be completed when done tail moves to new node. Till
> then, it gets deferred continuously. So, we won't be entering into
> the situation where the sr processing is complete while done tail is pointing
> to it. Please correct me if I am missing something here.

Ok I'm confused as usual. Let's take a practical case. Is the following
sequence possible?

1) wait_tail = NULL
   done_tail = WH4->SR4->WH3->SR3->WH2->SR2->WH1->SR1...

Initial layout

2) wait_tail = SR5 -> WH4...
   done_tail = WH4->SR4->WH3->SR3->WH2->SR2->WH1->SR1...

New GP

3) wait_tail = NULL
   done_tail = SR5->WH4->SR4->WH3->SR3->WH2->SR2->WH1->SR1...

GP completes, normal cleanup

3) wait_tail = SR6->SR5...
   done_tail = SR5->WH4->SR4->WH3->SR2->WH2->SR1->WH1->SR1...

New GP

4) GP completes and SR5 is completed by rcu_sr_normal_gp_cleanup(). So
   the caller releases it from the stack. But before rcu_sr_normal_gp_cleanup()
   overwrites done_tail to SR6->WH4->SR4.... , the workqueue manages to run
   and concurrently dereferences SR5.

But I bet I'm missing something obvious in the middle, preventing that...

