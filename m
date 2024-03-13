Return-Path: <linux-kernel+bounces-101671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBE287AA4E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CC6C1C21CE9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39EF46430;
	Wed, 13 Mar 2024 15:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ud2ecvH/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256E73F8C7;
	Wed, 13 Mar 2024 15:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710343108; cv=none; b=ESURjys6a8bEdfITyhI9PSB+Kj77Zw+mFmbrLOQTcD855rUACdWJNluLCEojt0cY9p1tq/IwzS53g3cSiXXghdFzwPhMpg1K+5jjB9osSmPqGBr38y+1jWNKIwCRaWiVyqZqCDM6k1vHpq2bOzQrcxI36tddjrxBvCgwOFuZ608=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710343108; c=relaxed/simple;
	bh=Z528Xo5dsSsoRUGneFhVFcADkvoiGBl2t/0/fSOZ5dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oW3vWJU2hvVq3D5Y4JbtPE3kxQVkGGHa0lE+OlgGSvU/RLMYRe83RzRuJmpuMTvx/O5aAG76kldAHjyJ+A2NQxjRnhcZVCwIlh61HpUH9tcaXC9k89+S0w9h4+9K2XpgLIw84iDoHteW6JjzXwSO87upI/MaV3h+qqBIBJbOtxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ud2ecvH/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B1CC433F1;
	Wed, 13 Mar 2024 15:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710343107;
	bh=Z528Xo5dsSsoRUGneFhVFcADkvoiGBl2t/0/fSOZ5dI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ud2ecvH/0lsRmBHEiyRX9B6D9Ka0jj+dX8PEt8vbN41LQkhWQozAhXfSkUz7dbv6U
	 Diyql6DDpS6wzTcQMATzW0lP/xD72KXzolqm01WcRwOIBNh2Qk2en7GzfOeGO3X/VW
	 JJpkO0IXbpvQvUUDt8k0s2Ji8yB3gYecRgdXdWtQAYXHXxQKuO5InONBRBH7gX43q0
	 DQFYlNBqkzynrFbSHnZHeWC5G6oq5MmNKBawohKQhs3ruKjieWYDixS8vZeb1MnGON
	 +cv5hpnBcuPyfpa7iWcldOB+gBgCICaieKH3V8Jb4tgjpyoHFT9bNGNUmD6OVKKVDX
	 0zPQCR8XuSJgw==
Date: Wed, 13 Mar 2024 16:18:24 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: paulmck@kernel.org, joel@joelfernandes.org, josh@joshtriplett.org,
	boqun.feng@gmail.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org
Subject: Re: [PATCH] rcu: Reduce synchronize_rcu() delays when all wait heads
 are in use
Message-ID: <ZfHDwPkPHulJHrD0@localhost.localdomain>
References: <20240313083228.233247-1-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240313083228.233247-1-Neeraj.Upadhyay@amd.com>

Le Wed, Mar 13, 2024 at 02:02:28PM +0530, Neeraj Upadhyay a écrit :
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
> ---
>  kernel/rcu/tree.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 9fbb5ab57c84..bdccce1ed62f 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1470,14 +1470,11 @@ static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
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
> @@ -1725,15 +1722,17 @@ static bool rcu_sr_normal_gp_init(void)
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

This means you're setting a non-wait-head as srs_wait_tail, right?
Doesn't it trigger the following warning in rcu_sr_normal_gp_cleanup():

	WARN_ON_ONCE(!rcu_sr_is_wait_head(wait_tail));

Also there is a risk that this non-wait-head gets later assigned as
rcu_state.srs_done_tail. And then this pending sr may not be completed
until the next grace period calling rcu_sr_normal_gp_cleanup()? (Because
the work doesn't take care of rcu_state.srs_done_tail itself). And then
the delay can be arbitrary.

And the next grace period completing this sr (that non-wait-head set
as rcu_state.srs_done_tail) and thus allowing its caller to wipe it out
of its stack may race with the cleanup work dereferencing it?

Thanks.



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
> 

