Return-Path: <linux-kernel+bounces-1540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4158C814FD8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6F291F245B6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0413C6A3;
	Fri, 15 Dec 2023 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3wAzoZX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772E030104;
	Fri, 15 Dec 2023 18:46:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6BE1C433C8;
	Fri, 15 Dec 2023 18:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702665971;
	bh=OtlO0KkedaO7LhwO41A2L9qyGmNp7WBBB4K/0wdOAwA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=h3wAzoZXpKfFodpY8VJ7loDO7mMTsMfNsVU+CLYN0uZKOTXpyDtbZlOaJfKflgrCJ
	 KKqyY7IwbhzfgQEpF4qyUQwsLdt7NjSJ7INWV5Fw7EQ3vVrlayaMVIoLAEc61712Uf
	 gMrwLLRCGzB9i19PJ/Xg3vUloemMFUMkFJqSzaAr79F+ovD5s9iQghgp9YfLQjYzEN
	 fIRQZe4SP1eHW8qMsMBtaUi1gVncZkDvRbPkK+qB8g4WLGBajVGnystrKAYhh8+YyI
	 Gzs4q5+hDr2/3ggcLZpmah+dOF34xzCU8H+OftusJRulX8oiapDvESgWZ/2oIk4cll
	 9JcuuwlDxea2w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 63023CE04E6; Fri, 15 Dec 2023 10:46:11 -0800 (PST)
Date: Fri, 15 Dec 2023 10:46:11 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>,
	Qais Yousef <qyousef@layalina.io>,
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
Subject: Re: [PATCH v2] rcu: Provide a boot time parameter to control lazy RCU
Message-ID: <f1a6e96e-43d7-4872-9db5-c43bc767bf9e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231203011252.233748-1-qyousef@layalina.io>
 <ZXhTjrTqZvMTXKtK@pc636>
 <CAEXW_YSMwmG_joipkK5W1Bdwzdjm_a3f86BijkAkAJTHOWkE0Q@mail.gmail.com>
 <ZXmI9zDW8KlZqQj7@pc636>
 <CAEXW_YRdgQywfJ+A9fa1itDojPDiZ_Xc3M8n6dS=M2LHX9hSFg@mail.gmail.com>
 <ZXyFz1BD6Nh1zsnc@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXyFz1BD6Nh1zsnc@pc636>

On Fri, Dec 15, 2023 at 05:58:55PM +0100, Uladzislau Rezki wrote:
> Hello, Joel!
> 
> > [....]
> > > > > > +       Use rcutree.enable_rcu_lazy=0 to turn it off at boot time.
> > > > > > +
> > > > > > +config RCU_LAZY_DEFAULT_OFF
> > > > > > +     bool "Turn RCU lazy invocation off by default"
> > > > > > +     depends on RCU_LAZY
> > > > > > +     default n
> > > > > > +     help
> > > > > > +       Allows building the kernel with CONFIG_RCU_LAZY=y yet keep it default
> > > > > > +       off. Boot time param rcutree.enable_rcu_lazy=1 can be used to switch
> > > > > > +       it back on.
> > > > > > +
> > > > > >  config RCU_DOUBLE_CHECK_CB_TIME
> > > > > >       bool "RCU callback-batch backup time check"
> > > > > >       depends on RCU_EXPERT
> > > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > > index 3ac3c846105f..8b7675624815 100644
> > > > > > --- a/kernel/rcu/tree.c
> > > > > > +++ b/kernel/rcu/tree.c
> > > > > > @@ -2719,6 +2719,9 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
> > > > > >  }
> > > > > >
> > > > > >  #ifdef CONFIG_RCU_LAZY
> > > > > > +static bool enable_rcu_lazy __read_mostly = !IS_ENABLED(CONFIG_RCU_LAZY_DEFAULT_OFF);
> > > > > > +module_param(enable_rcu_lazy, bool, 0444);
> > > > > > +
> > > > > >  /**
> > > > > >   * call_rcu_hurry() - Queue RCU callback for invocation after grace period, and
> > > > > >   * flush all lazy callbacks (including the new one) to the main ->cblist while
> > > > > > @@ -2744,6 +2747,8 @@ void call_rcu_hurry(struct rcu_head *head, rcu_callback_t func)
> > > > > >       __call_rcu_common(head, func, false);
> > > > > >  }
> > > > > >  EXPORT_SYMBOL_GPL(call_rcu_hurry);
> > > > > > +#else
> > > > > > +#define enable_rcu_lazy              false
> > > > > >  #endif
> > > > > >
> > > > > >  /**
> > > > > > @@ -2792,7 +2797,7 @@ EXPORT_SYMBOL_GPL(call_rcu_hurry);
> > > > > >   */
> > > > > >  void call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > > > >  {
> > > > > > -     __call_rcu_common(head, func, IS_ENABLED(CONFIG_RCU_LAZY));
> > > > > > +     __call_rcu_common(head, func, enable_rcu_lazy);
> > > > > >  }
> > > > > >  EXPORT_SYMBOL_GPL(call_rcu);
> > > > > >
> > > > > I think, it makes sense. Especially for devices/systems where it is hard
> > > > > to recompile the kernel and deploy it. For example, Google and GKI approach.
> > > >
> > > > My concerns had nothing to do with recompiling the kernel. Passing a
> > > > boot parameter (without a kernel compile) can just as well
> > > > default-disable the feature.
> > > >
> > > > I think what Qais is saying is that passing a boot parameter is itself
> > > > a hassle in Android (something I did not know about) because of GKI
> > > > etc.
> > > >
> > > That is true. Doing:
> > >
> > > echo 1 > /sys/.../enable_lazy
> > >
> > > is a way how to make it easy and flexible.
> > 
> > Hey Vlad, are you suggesting that the boot parameter be made to
> > support runtime? We can keep that for later as it may get complicated.
> > Qais's boot parameter is designed only for boot time.
> > 
> No problem. Yes, i meant a runtime one. But as you stated there might
> be hidden issues witch we are not aware of yet.

My current thought is that Qais's version currently in -rcu for
the merge window after next (v6.9) suits our current situation.
But if we are eventually able to support runtime changes to this new
rcutree.enable_rcu_lazy module parameter via simplification to the
rcu_nocb_try_bypass() function (or maybe a better analysis of it),
then at that point it would be good to allow this module parameter to
be changed via sysfs at runtime.

Does that make sense, or am I missing some aspect or use case?

							Thanx, Paul

