Return-Path: <linux-kernel+bounces-115263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D40889A9B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60E841F3402E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68DE128813;
	Mon, 25 Mar 2024 01:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXvAkoRL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C162AE8D5;
	Sun, 24 Mar 2024 23:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324674; cv=none; b=AwlsGYDuZ+jfU4dFK0fbA8c7x0LZhjOB1nnbSGyDoiwIfGHhgOO9xS+c+TB/Rl9Z+ag6bngNNzRQWNLz0efMR0/9KKkr41AmCHwGkVCeH6YXQgODtzN3ywiZaz2kbX4OdhV2bmyVyFl4t8THVkP3NhU17Q+WmWVH1mX+NbxOttk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324674; c=relaxed/simple;
	bh=B+hDJSEtZmTKGwjosQVzHLsZ21o1d5mgFIcyszz+X+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9pBO2gC+l9VIVzf7RkUKV4+QhLuzKlX+FjdjR7LbFwHrSYu0O93hlpZRHa1tnccGF3y5Z2U7dZaWOrSuNqBcdxADTW1hp1Zae0DF5jkMv5DW/G+2qbUD8/Wv24KmgUpJpzt8C3aS4/Gzdr5QZnHQhA3BKT1Nh3s/SZu7KyEl7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXvAkoRL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5BEC433F1;
	Sun, 24 Mar 2024 23:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324672;
	bh=B+hDJSEtZmTKGwjosQVzHLsZ21o1d5mgFIcyszz+X+s=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=VXvAkoRLMY62I9KFD5orWlj59XGpDkzi5cIA2GMV6QI8b6pBSARWzoatAMQ0GvCzn
	 vuHY/3dprYDZHORzohPbl0n+SRwQ1hgBW70KRHkwFrxA1cl8zL1DIZdwAbnHSfrzJ3
	 e04as6W54Iug2x/500OYNiVWMrZFFHWBksdlqRRaXahroHaI/YSuPSQINYeERNE0mx
	 03l13sbMpV0to3E710lPiFc0vzkOJ9iH4NW8XirbabzfczQSIE4/f0A9b4xg352cQc
	 WlnbCdDs2wxSskedMajEpUB6fqmB1OfwrBktVrFzVysV+iak7KdUr8JNCScNQCONYY
	 u5PEGmiByRpXg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2AD25CE11CE; Sun, 24 Mar 2024 16:57:52 -0700 (PDT)
Date: Sun, 24 Mar 2024 16:57:52 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang1211@gmail.com>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Make rcutorture support srcu double call test
Message-ID: <fded324e-19bd-47a0-bd92-f25aaeddfc1f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240324124224.615-1-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324124224.615-1-qiang.zhang1211@gmail.com>

On Sun, Mar 24, 2024 at 08:42:24PM +0800, Zqiang wrote:
> This commit also allows rcutorture to support srcu double call test
> with CONFIG_DEBUG_OBJECTS_RCU_HEAD option enabled. since the spinlock

						   ^ Comma ","?

> will be called in call_srcu(), in RT-kernel, the spinlock is sleepable,

You lost me on "the spinlock will be called in call_srcu()".

> therefore remove disable-irq and disable-preempt protection.
> 
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>

Nice!  A question below.

> ---
>  kernel/rcu/rcutorture.c | 36 +++++++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 3f9c3766f52b..6571a69142f8 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -388,6 +388,7 @@ struct rcu_torture_ops {
>  	int extendables;
>  	int slow_gps;
>  	int no_pi_lock;
> +	int debug_objects;
>  	const char *name;
>  };
>  
> @@ -573,6 +574,7 @@ static struct rcu_torture_ops rcu_ops = {
>  	.irq_capable		= 1,
>  	.can_boost		= IS_ENABLED(CONFIG_RCU_BOOST),
>  	.extendables		= RCUTORTURE_MAX_EXTEND,
> +	.debug_objects		= 1,
>  	.name			= "rcu"
>  };
>  
> @@ -743,6 +745,7 @@ static struct rcu_torture_ops srcu_ops = {
>  	.cbflood_max	= 50000,
>  	.irq_capable	= 1,
>  	.no_pi_lock	= IS_ENABLED(CONFIG_TINY_SRCU),
> +	.debug_objects	= 1,
>  	.name		= "srcu"
>  };
>  
> @@ -782,6 +785,7 @@ static struct rcu_torture_ops srcud_ops = {
>  	.cbflood_max	= 50000,
>  	.irq_capable	= 1,
>  	.no_pi_lock	= IS_ENABLED(CONFIG_TINY_SRCU),
> +	.debug_objects	= 1,
>  	.name		= "srcud"
>  };
>  
> @@ -3481,35 +3485,37 @@ static void rcu_test_debug_objects(void)
>  #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
>  	struct rcu_head rh1;
>  	struct rcu_head rh2;
> +	int idx;
> +
> +	if (!cur_ops->debug_objects || !cur_ops->call ||
> +			!cur_ops->cb_barrier)

If this is built-in, could we please WARN if there is a conflict?
Otherwise, it looks like the test succeeded.

> +		return;
> +
>  	struct rcu_head *rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
>  
>  	init_rcu_head_on_stack(&rh1);
>  	init_rcu_head_on_stack(&rh2);
> -	pr_alert("%s: WARN: Duplicate call_rcu() test starting.\n", KBUILD_MODNAME);
> +	pr_alert("%s: WARN: Duplicate call_%s() test starting.\n", KBUILD_MODNAME, cur_ops->name);
>  
>  	/* Try to queue the rh2 pair of callbacks for the same grace period. */
> -	preempt_disable(); /* Prevent preemption from interrupting test. */

What makes us not need this preempt_disable() in the RCU case?

> -	rcu_read_lock(); /* Make it impossible to finish a grace period. */
> -	call_rcu_hurry(&rh1, rcu_torture_leak_cb); /* Start grace period. */
> -	local_irq_disable(); /* Make it harder to start a new grace period. */

Same question for the local_irq_disable()?

> -	call_rcu_hurry(&rh2, rcu_torture_leak_cb);
> -	call_rcu_hurry(&rh2, rcu_torture_err_cb); /* Duplicate callback. */
> +	idx = cur_ops->readlock(); /* Make it impossible to finish a grace period. */
> +	cur_ops->call(&rh1, rcu_torture_leak_cb); /* Start grace period. */
> +	cur_ops->call(&rh2, rcu_torture_leak_cb);
> +	cur_ops->call(&rh2, rcu_torture_err_cb); /* Duplicate callback. */
>  	if (rhp) {
> -		call_rcu_hurry(rhp, rcu_torture_leak_cb);
> -		call_rcu_hurry(rhp, rcu_torture_err_cb); /* Another duplicate callback. */
> +		cur_ops->call(rhp, rcu_torture_leak_cb);
> +		cur_ops->call(rhp, rcu_torture_err_cb); /* Another duplicate callback. */
>  	}
> -	local_irq_enable();
> -	rcu_read_unlock();
> -	preempt_enable();
> +	cur_ops->readunlock(idx);
>  
>  	/* Wait for them all to get done so we can safely return. */
> -	rcu_barrier();
> -	pr_alert("%s: WARN: Duplicate call_rcu() test complete.\n", KBUILD_MODNAME);
> +	cur_ops->cb_barrier();
> +	pr_alert("%s: WARN: Duplicate call_%s() test complete.\n", KBUILD_MODNAME, cur_ops->name);
>  	destroy_rcu_head_on_stack(&rh1);
>  	destroy_rcu_head_on_stack(&rh2);
>  	kfree(rhp);
>  #else /* #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD */
> -	pr_alert("%s: !CONFIG_DEBUG_OBJECTS_RCU_HEAD, not testing duplicate call_rcu()\n", KBUILD_MODNAME);
> +	pr_alert("%s: !CONFIG_DEBUG_OBJECTS_RCU_HEAD, not testing duplicate call_%s()\n", KBUILD_MODNAME, cur_ops->name);
>  #endif /* #else #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD */

It might be possible to simplify the code by turning this #ifdef into
IS_ENABLED().

							Thanx, Paul

>  }
>  
> -- 
> 2.17.1
> 

