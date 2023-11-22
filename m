Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C3D7F52E4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343587AbjKVWAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjKVWAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:00:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC6310C;
        Wed, 22 Nov 2023 14:00:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E49C433C7;
        Wed, 22 Nov 2023 22:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700690412;
        bh=ZiMYxOQFb+TDdnQ6v43qXplIgnPy8bym53lENqByhY4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=R4ZpUYg3J2Dwk6dweZsS3DYZOUwu7ZkMQdvOcpOWaEezJCOmZ67x7a+WxlGtJYlmt
         5UjLKjuN2tnbwFMYDjS6VQHoMYeyA3qWDu2v6CnVzhiWjhlmQuM4H2zUu9EEOaU+2K
         4ObHXiIFwQde9PWu3pJSBDc54vkXfdg/fFgpkHgm5T1YtPZCTkncEkEtkC3CKbvs1k
         mgnqQK1peWldufOVhoMgePwKnBWzAuCd4+dcFWpspYXpxJUFc9N8ubVe7xhIg7JSGx
         O0pCENp/qWoYXN48AIIBhUarhBDFe2jW9/p6Yj7ggBPByuYw2UR6n8SDjUCDEWCqbC
         ammX87lqC2UqQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 84245CE1B87; Wed, 22 Nov 2023 14:00:11 -0800 (PST)
Date:   Wed, 22 Nov 2023 14:00:11 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        John Stultz <jstultz@google.com>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Provide a boot time parameter to enable lazy RCU
Message-ID: <811b2157-1009-4339-8ff2-0433512f3094@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231121205304.315146-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121205304.315146-1-qyousef@layalina.io>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 08:53:04PM +0000, Qais Yousef wrote:
> To allow more flexible opt-in arrangements while still provide a single
> kernel for distros, provide a boot time parameter to enable lazy RCU.
> 
> Specify:
> 
> 	rcutree.enable_rcu_lazy
> 
> Which also requires
> 
> 	rcu_nocbs=all
> 
> at boot time to enable lazy RCU assuming CONFIG_RCU_LAZY=y. The
> parameter will be ignored if CONFIG_RCU_LAZY is not set.
> 
> With this change now lazy RCU is disabled by default if the boot
> parameter is not set even when CONFIG_RCU_LAZY is enabled.
> 
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
> 
> Makes sense to remove the CONFIG_RCU_LAZY now we have a boot time param?
> 
> We can make it a static key too if it *really* matters.
> 
> Thanks to Joel for helping initially in reviewing this patch which was intended
> originally for Android.
> 
> I got some requests to make this a runtime modifiable for init scripts; but
> Paul suggested there shall be dragons. So RO it is.

I must defer to the people using this, but my experience is that kernel
boot parameters work for some people but not others.  For example,
I tried making rcu_nocbs be the only way to say that all CPUs were
going to be offloaded, but popular demand resulted in my adding a
CONFIG_RCU_NOCB_CPU_DEFAULT_ALL.

If we cannot be sure that we know everyone using CONFIG_RCU_LAZY=y
and expecting full laziness, the safe approach is to make another
Kconfig option that defaults to off, but with either setting allowing
rcutree.enable_rcu_lazy to override at boot time.

If you can be sure that you know everyone using CONFIG_RCU_LAZY=y
is OK with this change, I must confess that I am curious as to how
you found them all.

Thoughts?

							Thanx, Paul

>  .../admin-guide/kernel-parameters.txt         |  5 ++++
>  kernel/rcu/tree.c                             | 26 ++++++++++++++++++-
>  2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 65731b060e3f..2f0386a12aa7 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5021,6 +5021,11 @@
>  			this kernel boot parameter, forcibly setting it
>  			to zero.
>  
> +	rcutree.enable_rcu_lazy= [KNL]
> +			To save power, batch RCU callbacks and flush after
> +			delay, memory pressure or callback list growing too
> +			big.
> +
>  	rcuscale.gp_async= [KNL]
>  			Measure performance of asynchronous
>  			grace-period primitives such as call_rcu().
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 3ac3c846105f..e0885905b3f6 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2718,7 +2718,30 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
>  	}
>  }
>  
> +static bool enable_rcu_lazy;
>  #ifdef CONFIG_RCU_LAZY
> +/* Enable lazy rcu at boot time */
> +static int param_set_rcu_lazy(const char *val, const struct kernel_param *kp)
> +{
> +	int ret;
> +
> +	/*
> +	 * Make sure a grace period has passed before and after flipping the
> +	 * switch.
> +	 */
> +	rcu_barrier();
> +	ret = param_set_bool(val, kp);
> +	rcu_barrier();
> +
> +	return ret;
> +}
> +static const struct kernel_param_ops rcu_lazy_ops = {
> +	.flags = KERNEL_PARAM_OPS_FL_NOARG,
> +	.set = param_set_rcu_lazy,
> +	.get = param_get_bool,
> +};
> +module_param_cb(enable_rcu_lazy, &rcu_lazy_ops, &enable_rcu_lazy, 0444);

OK, I will bite...

Given that this is to be set only at boot time, why not replace everything
from "#ifdef CONFIG_RCU_LAZY" to here with this?

module_param(enable_rcu_lazy, bool, 0444);

And then maybe also a __read_mostly on the definition of enable_rcu_lazy?

> +
>  /**
>   * call_rcu_hurry() - Queue RCU callback for invocation after grace period, and
>   * flush all lazy callbacks (including the new one) to the main ->cblist while
> @@ -2792,7 +2815,8 @@ EXPORT_SYMBOL_GPL(call_rcu_hurry);
>   */
>  void call_rcu(struct rcu_head *head, rcu_callback_t func)
>  {
> -	__call_rcu_common(head, func, IS_ENABLED(CONFIG_RCU_LAZY));
> +	__call_rcu_common(head, func, IS_ENABLED(CONFIG_RCU_LAZY) &&
> +			  READ_ONCE(enable_rcu_lazy));
>  }
>  EXPORT_SYMBOL_GPL(call_rcu);
>  
> -- 
> 2.34.1
> 
