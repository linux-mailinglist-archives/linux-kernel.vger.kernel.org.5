Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D783A7F547E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbjKVX0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjKVX0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:26:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE521726;
        Wed, 22 Nov 2023 15:26:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9665FC433C7;
        Wed, 22 Nov 2023 23:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700695577;
        bh=PVXV8ubSabnEPRpzDsNj60a/FcsrDe6wHDBID7bC16k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=djTbOinGwJjrnn2Q21rfuDDSa3JMHp1MlgSa9poYV+NmKCHaRxFXM8DAZCDdIA43T
         zbYF1g0C1VhLMol7joIIPUki54wsSMKKo+lcgNDWEpmlayp9tK7OHh49klJLVSm2qc
         GQdyMTw6bzzKSrpx7oBcu+JLdY8VeqWKPTLVFjeCgGeQFYai4/wgvv6gCKziJdvBXv
         S+75Oxkj4GZKm6ZAZzw59StKIQjYJ3DOGhvJPFHUJ8Sxi2GGpl9ShcHBaJzlQuTTW9
         WONIFtLcSUQezWD/GsMheZbqFUrtZUcc3F3WNaThFdbiHhc1sBDHo7SvvrwpGr38aa
         HyloMNMxuuppQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 29E7ECE0BDB; Wed, 22 Nov 2023 15:26:17 -0800 (PST)
Date:   Wed, 22 Nov 2023 15:26:17 -0800
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
Message-ID: <8ad4e628-7a88-490c-a54d-df09f851f189@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231121205304.315146-1-qyousef@layalina.io>
 <811b2157-1009-4339-8ff2-0433512f3094@paulmck-laptop>
 <20231121214415.ovoskvbjarzpxi6e@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121214415.ovoskvbjarzpxi6e@airbuntu>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 09:44:15PM +0000, Qais Yousef wrote:
> On 11/22/23 14:00, Paul E. McKenney wrote:
> > On Tue, Nov 21, 2023 at 08:53:04PM +0000, Qais Yousef wrote:
> > > To allow more flexible opt-in arrangements while still provide a single
> > > kernel for distros, provide a boot time parameter to enable lazy RCU.
> > > 
> > > Specify:
> > > 
> > > 	rcutree.enable_rcu_lazy
> > > 
> > > Which also requires
> > > 
> > > 	rcu_nocbs=all
> > > 
> > > at boot time to enable lazy RCU assuming CONFIG_RCU_LAZY=y. The
> > > parameter will be ignored if CONFIG_RCU_LAZY is not set.
> > > 
> > > With this change now lazy RCU is disabled by default if the boot
> > > parameter is not set even when CONFIG_RCU_LAZY is enabled.
> > > 
> > > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> > > ---
> > > 
> > > Makes sense to remove the CONFIG_RCU_LAZY now we have a boot time param?
> > > 
> > > We can make it a static key too if it *really* matters.
> > > 
> > > Thanks to Joel for helping initially in reviewing this patch which was intended
> > > originally for Android.
> > > 
> > > I got some requests to make this a runtime modifiable for init scripts; but
> > > Paul suggested there shall be dragons. So RO it is.
> > 
> > I must defer to the people using this, but my experience is that kernel
> > boot parameters work for some people but not others.  For example,
> > I tried making rcu_nocbs be the only way to say that all CPUs were
> > going to be offloaded, but popular demand resulted in my adding a
> > CONFIG_RCU_NOCB_CPU_DEFAULT_ALL.
> 
> Speak of pleasing a crowd.. There's always someone who wants something else :-)
> 
> I imagine the difficulty is in some environments it is easier to switch a sysfs
> knob than add a new boot time parameter. And in the absence of a writable sysfs
> node, I can imagine some folks think having a Kconfig to force a default at
> compile time is the 2nd best compared to modifying their boot time parameters..
> 
> Either way; I'll follow what the crowd wants too :-)

Usually a wise choice.  ;-)

But I must defer to the people using it.

> > If we cannot be sure that we know everyone using CONFIG_RCU_LAZY=y
> > and expecting full laziness, the safe approach is to make another
> > Kconfig option that defaults to off, but with either setting allowing
> > rcutree.enable_rcu_lazy to override at boot time.
> > 
> > If you can be sure that you know everyone using CONFIG_RCU_LAZY=y
> > is OK with this change, I must confess that I am curious as to how
> > you found them all.
> 
> If you let it break and no one shouts..
> 
> /me hides

Indeed, sometimes you get lucky.  Sometimes.  ;-)

> Jokes aside, all options work for me. I'll wait to hear from the other rcu
> gurus what they'd like.

Fair enough!

> > Thoughts?
> > 
> > 							Thanx, Paul
> > 
> > >  .../admin-guide/kernel-parameters.txt         |  5 ++++
> > >  kernel/rcu/tree.c                             | 26 ++++++++++++++++++-
> > >  2 files changed, 30 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > index 65731b060e3f..2f0386a12aa7 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -5021,6 +5021,11 @@
> > >  			this kernel boot parameter, forcibly setting it
> > >  			to zero.
> > >  
> > > +	rcutree.enable_rcu_lazy= [KNL]
> > > +			To save power, batch RCU callbacks and flush after
> > > +			delay, memory pressure or callback list growing too
> > > +			big.
> > > +
> > >  	rcuscale.gp_async= [KNL]
> > >  			Measure performance of asynchronous
> > >  			grace-period primitives such as call_rcu().
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 3ac3c846105f..e0885905b3f6 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -2718,7 +2718,30 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
> > >  	}
> > >  }
> > >  
> > > +static bool enable_rcu_lazy;
> > >  #ifdef CONFIG_RCU_LAZY
> > > +/* Enable lazy rcu at boot time */
> > > +static int param_set_rcu_lazy(const char *val, const struct kernel_param *kp)
> > > +{
> > > +	int ret;
> > > +
> > > +	/*
> > > +	 * Make sure a grace period has passed before and after flipping the
> > > +	 * switch.
> > > +	 */
> > > +	rcu_barrier();
> > > +	ret = param_set_bool(val, kp);
> > > +	rcu_barrier();
> > > +
> > > +	return ret;
> > > +}
> > > +static const struct kernel_param_ops rcu_lazy_ops = {
> > > +	.flags = KERNEL_PARAM_OPS_FL_NOARG,
> > > +	.set = param_set_rcu_lazy,
> > > +	.get = param_get_bool,
> > > +};
> > > +module_param_cb(enable_rcu_lazy, &rcu_lazy_ops, &enable_rcu_lazy, 0444);
> > 
> > OK, I will bite...
> > 
> > Given that this is to be set only at boot time, why not replace everything
> > from "#ifdef CONFIG_RCU_LAZY" to here with this?
> > 
> > module_param(enable_rcu_lazy, bool, 0444);
> 
> No need for the rcu_barrier() then? Only reason why we use the _cb flavour

The module_param() parameters are processed during early boot, before
the boot CPU has enabled interrupts.  In fact, before rcu_init()
is invoked, which is in turn long before the scheduler has started.
Calling rcu_barrier() that early is not so good for your kernel's
actuarial statistics.

I am guessing that the module_param_cb() processing happens somewhat
later in the kernel's lifetime.

> > And then maybe also a __read_mostly on the definition of enable_rcu_lazy?
> 
> +1
> 
> I think the READ_ONCE() was unnecessary too.

Good point, and yes, I did miss that one.

							Thanx, Paul
