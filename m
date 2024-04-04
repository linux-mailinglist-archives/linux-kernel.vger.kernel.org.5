Return-Path: <linux-kernel+bounces-131903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 561AB898D71
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3BD28E8B0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EECD12E1C7;
	Thu,  4 Apr 2024 17:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nw1DW6YC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C68848A;
	Thu,  4 Apr 2024 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712252770; cv=none; b=jE8p+8T55rdf/L/B1rNzP3ZybILzO9pJKGcggOOev7MwZrGV6laLHk8xQ5V8vJ7gaw0iT5tP9ncGAxgQofxtvm325h+z91B64HYy3smyuhi4/7mclLUZrGsamPcNqgGQC+MbLMFYz18HQGQxJoKUN3JHWqTc5FgrwggR68xHFJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712252770; c=relaxed/simple;
	bh=7UwdsAlWPrt4EKzrLi44XH3NHYbA1Alrh9WETpxWTf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsgySFk7thdyNuSgRo2gK0Fw2YF7VcMcyHxCZkmIFUM/EZNFG8PnTTE7kQR4WL2QNPZQXSD/LCWCNoq95AuwYiTBjvBduxNwlXMAAC5zjlwQ6NOCtIN54kVwtLD7cTEoSnlc9R5ZwYqovfNwuLRyNgvYkcqpJuKswy4bTTxzz0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nw1DW6YC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9FDC433F1;
	Thu,  4 Apr 2024 17:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712252770;
	bh=7UwdsAlWPrt4EKzrLi44XH3NHYbA1Alrh9WETpxWTf8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Nw1DW6YCXIsiuXAuv2jlAmIg2MHfAp5cTbvXzB/v6iG4GbqygutIbMkfA9EjE3KyR
	 Cd93D8gNXdZEsid+rua/UZgRotbE3B7lXrj6ICAExXCjwQ/JKKMlteBJOxpLjhrtCm
	 VkBthNAmy5jdvVYlh+SrBI23gJcEYyc5y+1waN3CwXs2/dj+OJMzgGTxkjZv8p2eEg
	 hx2juoiJ5dRCJVRtnxOHJbsDfcHZqEaaAUWvOLgzpl6rMjHhXfYEDZfUv47z54uJml
	 Lz6F+WK/XeABtfuxbv8eYCAdVj10Cu9h8nUvfNhAdwchSw+b1agYn5LDT2L2Cjj9Yv
	 eK8Cc7vIgsF3A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CF8E9CE0D0C; Thu,  4 Apr 2024 10:46:09 -0700 (PDT)
Date: Thu, 4 Apr 2024 10:46:09 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: frederic@kernel.org, joel@joelfernandes.org, urezki@gmail.com,
	josh@joshtriplett.org, boqun.feng@gmail.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org
Subject: Re: [PATCH v2] rcu: Reduce synchronize_rcu() delays when all wait
 heads are in use
Message-ID: <8d4e54ab-07b8-4a9b-a75c-afbe52929214@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240403105212.237354-1-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403105212.237354-1-Neeraj.Upadhyay@amd.com>

On Wed, Apr 03, 2024 at 04:22:12PM +0530, Neeraj Upadhyay wrote:
> When all wait heads are in use, which can happen when
> rcu_sr_normal_gp_cleanup_work()'s callback processing
> is slow, any new synchronize_rcu() user's rcu_synchronize
> node's processing is deferred to future GP periods. This
> can result in long list of synchronize_rcu() invocations
> waiting for full grace period processing, which can delay
> freeing of memory. Mitigate this problem by using first
> node in the list as wait tail when all wait heads are in use.
> While methods to speed up callback processing would be needed
> to recover from this situation, allowing new nodes to complete
> their grace period can help prevent delays due to a fixed
> number of wait head nodes.
> 
> Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>

Seeing no objections, I have queued this for testing and review alongside
the other synchronize_rcu() speedup patches, thank you!

							Thanx, Paul

> ---
> Changes since v1:
> * Fix use-after-free issue in rcu_sr_normal_gp_cleanup() (Frederic)
> * Remove WARN_ON_ONCE(!rcu_sr_is_wait_head()) for wait and done tail
>   (Frederic)
> * Rebase on top of commit 1c56d246027f ("rcu/tree: Reduce wake up
>   for synchronize_rcu() common case") (Joel)
> ---
>  kernel/rcu/tree.c | 40 +++++++++++++++++++++++-----------------
>  1 file changed, 23 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index a7c7a2b2b527..fe4a59d7cf61 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1464,14 +1464,11 @@ static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
>   * for this new grace period. Given that there are a fixed
>   * number of wait nodes, if all wait nodes are in use
>   * (which can happen when kworker callback processing
> - * is delayed) and additional grace period is requested.
> - * This means, a system is slow in processing callbacks.
> - *
> - * TODO: If a slow processing is detected, a first node
> - * in the llist should be used as a wait-tail for this
> - * grace period, therefore users which should wait due
> - * to a slow process are handled by _this_ grace period
> - * and not next.
> + * is delayed), first node in the llist is used as wait
> + * tail for this grace period. This means, the first node
> + * has to go through additional grace periods before it is
> + * part of the wait callbacks. This should be ok, as
> + * the system is slow in processing callbacks anyway.
>   *
>   * Below is an illustration of how the done and wait
>   * tail pointers move from one set of rcu_synchronize nodes
> @@ -1642,7 +1639,6 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
>  		return;
>  	}
>  
> -	WARN_ON_ONCE(!rcu_sr_is_wait_head(done));
>  	head = done->next;
>  	done->next = NULL;
>  
> @@ -1682,13 +1678,21 @@ static void rcu_sr_normal_gp_cleanup(void)
>  
>  	rcu_state.srs_wait_tail = NULL;
>  	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_wait_tail);
> -	WARN_ON_ONCE(!rcu_sr_is_wait_head(wait_tail));
>  
>  	/*
>  	 * Process (a) and (d) cases. See an illustration.
>  	 */
>  	llist_for_each_safe(rcu, next, wait_tail->next) {
> -		if (rcu_sr_is_wait_head(rcu))
> +		/*
> +		 * The done tail may reference a rcu_synchronize node.
> +		 * Stop at done tail, as using rcu_sr_normal_complete()
> +		 * from this path can result in use-after-free. This
> +		 * may occur if, following the wake-up of the synchronize_rcu()
> +		 * wait contexts and freeing up of node memory,
> +		 * rcu_sr_normal_gp_cleanup_work() accesses the done tail and
> +		 * its subsequent nodes.
> +		 */
> +		if (wait_tail->next == rcu_state.srs_done_tail)
>  			break;
>  
>  		rcu_sr_normal_complete(rcu);
> @@ -1743,15 +1747,17 @@ static bool rcu_sr_normal_gp_init(void)
>  		return start_new_poll;
>  
>  	wait_head = rcu_sr_get_wait_head();
> -	if (!wait_head) {
> -		// Kick another GP to retry.
> +	if (wait_head) {
> +		/* Inject a wait-dummy-node. */
> +		llist_add(wait_head, &rcu_state.srs_next);
> +	} else {
> +		// Kick another GP for first node.
>  		start_new_poll = true;
> -		return start_new_poll;
> +		if (first == rcu_state.srs_done_tail)
> +			return start_new_poll;
> +		wait_head = first;
>  	}
>  
> -	/* Inject a wait-dummy-node. */
> -	llist_add(wait_head, &rcu_state.srs_next);
> -
>  	/*
>  	 * A waiting list of rcu_synchronize nodes should be empty on
>  	 * this step, since a GP-kthread, rcu_gp_init() -> gp_cleanup(),
> -- 
> 2.34.1
> 

