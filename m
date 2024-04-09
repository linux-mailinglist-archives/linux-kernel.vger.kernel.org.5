Return-Path: <linux-kernel+bounces-137573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C29289E421
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFBB31F21949
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30478157E9E;
	Tue,  9 Apr 2024 20:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daqan8zN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A06E566;
	Tue,  9 Apr 2024 20:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712693118; cv=none; b=lMeP9Q0sVIk18Wz7l2GxA4E8rkp1xQEP+U4cT8nuJ76KinUwtiYmCbrWTKrn+a/MNNlFgg4cWh/grlxm3U+6QxvDQsijxsZA2Vj22mNLrBoiyhjzgPwM8vFPfQSLHhifylfJn4Sl5BT+TPi6KuXz09wIlojuHnFg1CARibLn9y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712693118; c=relaxed/simple;
	bh=EMEDkiy24xdD1xBgPZ4U0NiuQEd7Oj7O/uHFBRj/yq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XiAfWQPre9TapyV5XBbYAvZdjlpcFaeuevk2ZA9IG7eO0pFJq1ba4RjSvP+M4cZtE1Km3R8TLB7kgNc+mpSa3sXo1J4m7xPeIZpCooG+6Zgndg4Sc5tNEZ6vdYR9z5fiIhshbWNdV2GQkWGHo81+Y5+KKB8ynsvY7YVANvuOm7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daqan8zN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CA6C433F1;
	Tue,  9 Apr 2024 20:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712693117;
	bh=EMEDkiy24xdD1xBgPZ4U0NiuQEd7Oj7O/uHFBRj/yq0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=daqan8zNDBoK15VbmlIRo7PrcDZTG0EcT8TuNvqUQ35TtmUMf7bejJHI5baNMck77
	 U2a0u06i8gOpxX4CzMaNPG7yX/vgZQircJiWfqk2Au7yWlzYHMEqEGGBWHgf5TU7S+
	 1j+bUiaGlMDP3RDMK+xERaxKRtfExAC4UrZVhbfNgHEoQpvHSvtb70kOQvdyWodQZn
	 SGBAEMPD8DqIW7AMXZh+SsH7kWRDXFGezOPrJNzuxaicBSkYOV3IMwZotXQ3wWw7p7
	 zkrhBY8uypxT046yFgqUPFHg0fFuLs2YvMKbpg5C5bJqoBLZM0vePqYDeBzqk8RNcO
	 o6Uz603WgtDNQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 81434CE2D22; Tue,  9 Apr 2024 13:05:17 -0700 (PDT)
Date: Tue, 9 Apr 2024 13:05:17 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang1211@gmail.com>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcutorture: Make rcutorture support srcu double call
 test
Message-ID: <a511e1a5-9218-4b21-9bb4-72b285397492@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240407112714.24460-1-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407112714.24460-1-qiang.zhang1211@gmail.com>

On Sun, Apr 07, 2024 at 07:27:14PM +0800, Zqiang wrote:
> This commit also allows rcutorture to support srcu double call test
> with CONFIG_DEBUG_OBJECTS_RCU_HEAD option enabled. the non-raw sdp
> structure's->spinlock will be acquired in call_srcu(), in Preempt-RT
> kernels, this spinlock is sleepable, therefore remove disable-irq and
> disable-preempt protection.
> 
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> ---
>  kernel/rcu/rcutorture.c | 46 +++++++++++++++++++++++------------------
>  1 file changed, 26 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 807fbf6123a7..44cc455e1b61 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -390,6 +390,7 @@ struct rcu_torture_ops {
>  	int extendables;
>  	int slow_gps;
>  	int no_pi_lock;
> +	int debug_objects;
>  	const char *name;
>  };
>  
> @@ -577,6 +578,7 @@ static struct rcu_torture_ops rcu_ops = {
>  	.irq_capable		= 1,
>  	.can_boost		= IS_ENABLED(CONFIG_RCU_BOOST),
>  	.extendables		= RCUTORTURE_MAX_EXTEND,
> +	.debug_objects		= 1,
>  	.name			= "rcu"
>  };
>  
> @@ -747,6 +749,7 @@ static struct rcu_torture_ops srcu_ops = {
>  	.cbflood_max	= 50000,
>  	.irq_capable	= 1,
>  	.no_pi_lock	= IS_ENABLED(CONFIG_TINY_SRCU),
> +	.debug_objects	= 1,
>  	.name		= "srcu"
>  };
>  
> @@ -786,6 +789,7 @@ static struct rcu_torture_ops srcud_ops = {
>  	.cbflood_max	= 50000,
>  	.irq_capable	= 1,
>  	.no_pi_lock	= IS_ENABLED(CONFIG_TINY_SRCU),
> +	.debug_objects	= 1,
>  	.name		= "srcud"
>  };
>  
> @@ -3455,7 +3459,6 @@ rcu_torture_cleanup(void)
>  		cur_ops->gp_slow_unregister(NULL);
>  }
>  
> -#ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
>  static void rcu_torture_leak_cb(struct rcu_head *rhp)
>  {
>  }
> @@ -3473,7 +3476,6 @@ static void rcu_torture_err_cb(struct rcu_head *rhp)
>  	 */
>  	pr_alert("%s: duplicated callback was invoked.\n", KBUILD_MODNAME);
>  }
> -#endif /* #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD */
>  
>  /*
>   * Verify that double-free causes debug-objects to complain, but only
> @@ -3482,39 +3484,43 @@ static void rcu_torture_err_cb(struct rcu_head *rhp)
>   */
>  static void rcu_test_debug_objects(void)
>  {
> -#ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
>  	struct rcu_head rh1;
>  	struct rcu_head rh2;
> +	int idx;
> +
> +	if (!IS_ENABLED(CONFIG_DEBUG_OBJECTS_RCU_HEAD)) {
> +		pr_alert("%s: !CONFIG_DEBUG_OBJECTS_RCU_HEAD, not testing duplicate call_%s()\n",
> +					KBUILD_MODNAME, cur_ops->name);
> +		return;
> +	}
> +
> +	if (WARN_ON_ONCE(cur_ops->debug_objects &&
> +			(!cur_ops->call || !cur_ops->cb_barrier)))
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
> -	rcu_read_lock(); /* Make it impossible to finish a grace period. */
> -	call_rcu_hurry(&rh1, rcu_torture_leak_cb); /* Start grace period. */
> -	local_irq_disable(); /* Make it harder to start a new grace period. */
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

This will get us "call_srcud() test", but if there are complaints yet
another string can be added to the nrcu_torture_ops structure.

So I have queued this for testing and further review.

							Thanx, Paul

>  	destroy_rcu_head_on_stack(&rh1);
>  	destroy_rcu_head_on_stack(&rh2);
>  	kfree(rhp);
> -#else /* #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD */
> -	pr_alert("%s: !CONFIG_DEBUG_OBJECTS_RCU_HEAD, not testing duplicate call_rcu()\n", KBUILD_MODNAME);
> -#endif /* #else #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD */
>  }
>  
>  static void rcutorture_sync(void)
> -- 
> 2.17.1
> 

