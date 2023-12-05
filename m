Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26C180488A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 05:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344112AbjLEE1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 23:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjLEE07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 23:26:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979CD9C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 20:27:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD44C433C8;
        Tue,  5 Dec 2023 04:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701750425;
        bh=Etgekf0ZrWRy/UX6kYpcWzxJxhTWLWEmZUQoTp7t7+0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hjtRZy08etGTrct5yZFp18b0ITpG0KrAxWOHT1LHT7ewS8IvwgRdYE3878TSwokib
         TXjGWublmQAqEbQl4ASY+Czp4rfXt02To7MKM2XaqVh0pmTrxlB+hoL1H9QA3iB2l5
         brvvVHYA9dv83u/Saf6s6ZKYrKPj/o8LKGgxqnSRGM6Sa58iZOie+owjcNLEP7dtvh
         HEHY2ml2saQPp6zK7jdHISQ8zb9q62+TQaqv8UpMe3cWAvwXnYAGcxeOChwyTqwhcU
         busNVg1+AzOt7Tg0MQvy+cSIHJxZDRSO71Eji6d3RE8Izr57VRvL57N0NcMG8daH5f
         IK7H5S3fGzrVA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B4DE4CE1147; Mon,  4 Dec 2023 20:27:04 -0800 (PST)
Date:   Mon, 4 Dec 2023 20:27:04 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Qais Yousef <qyousef@layalina.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        John Stultz <jstultz@google.com>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH v2] rcu: Provide a boot time parameter to control lazy RCU
Message-ID: <eb1619f7-ad15-4c90-91fc-c4e2cee14053@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231203011252.233748-1-qyousef@layalina.io>
 <ZWyAG145F+JWzg7u@gpd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWyAG145F+JWzg7u@gpd>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2023 at 02:18:19PM +0100, Andrea Righi wrote:
> On Sun, Dec 03, 2023 at 01:12:52AM +0000, Qais Yousef wrote:
> > To allow more flexible arrangements while still provide a single kernel
> > for distros, provide a boot time parameter to enable/disable lazy RCU.
> > 
> > Specify:
> > 
> > 	rcutree.enable_rcu_lazy=[y|1|n|0]
> > 
> > Which also requires
> > 
> > 	rcu_nocbs=all
> > 
> > at boot time to enable/disable lazy RCU.
> > 
> > To disable it by default at build time when CONFIG_RCU_LAZY=y, the new
> > CONFIG_RCU_LAZY_DEFAULT_OFF can be used.
> > 
> > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> 
> Thanks! Everything looks good to me and I also verified that
> rcutree.enable_rcu_lazy is enforcing the proper behavior.
> 
> FWIW:
> 
> Tested-by: Andrea Righi <andrea.righi@canonical.com>

Queued for v6.9 and further testing and review, thank you!

							Thanx, Paul

> > ---
> > 
> > Changes since v1:
> > 
> > 	* Use module_param() instead of module_param_cb()
> > 	* Add new CONFIG_RCU_LAZY_DEFAULT_OFF to force default off.
> > 	* Remove unnecessary READ_ONCE()
> > 
> > Tested on qemu only this time with various config/boot configuration to ensure
> > expected values are in sysfs.
> > 
> > Did a bunch of build tests against various configs/archs.
> > 
> >  Documentation/admin-guide/kernel-parameters.txt |  5 +++++
> >  kernel/rcu/Kconfig                              | 13 +++++++++++++
> >  kernel/rcu/tree.c                               |  7 ++++++-
> >  3 files changed, 24 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 65731b060e3f..2f0386a12aa7 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -5021,6 +5021,11 @@
> >  			this kernel boot parameter, forcibly setting it
> >  			to zero.
> >  
> > +	rcutree.enable_rcu_lazy= [KNL]
> > +			To save power, batch RCU callbacks and flush after
> > +			delay, memory pressure or callback list growing too
> > +			big.
> > +
> >  	rcuscale.gp_async= [KNL]
> >  			Measure performance of asynchronous
> >  			grace-period primitives such as call_rcu().
> > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > index bdd7eadb33d8..e7d2dd267593 100644
> > --- a/kernel/rcu/Kconfig
> > +++ b/kernel/rcu/Kconfig
> > @@ -314,6 +314,19 @@ config RCU_LAZY
> >  	  To save power, batch RCU callbacks and flush after delay, memory
> >  	  pressure, or callback list growing too big.
> >  
> > +	  Requires rcu_nocbs=all to be set.
> > +
> > +	  Use rcutree.enable_rcu_lazy=0 to turn it off at boot time.
> > +
> > +config RCU_LAZY_DEFAULT_OFF
> > +	bool "Turn RCU lazy invocation off by default"
> > +	depends on RCU_LAZY
> > +	default n
> > +	help
> > +	  Allows building the kernel with CONFIG_RCU_LAZY=y yet keep it default
> > +	  off. Boot time param rcutree.enable_rcu_lazy=1 can be used to switch
> > +	  it back on.
> > +
> >  config RCU_DOUBLE_CHECK_CB_TIME
> >  	bool "RCU callback-batch backup time check"
> >  	depends on RCU_EXPERT
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 3ac3c846105f..8b7675624815 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2719,6 +2719,9 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
> >  }
> >  
> >  #ifdef CONFIG_RCU_LAZY
> > +static bool enable_rcu_lazy __read_mostly = !IS_ENABLED(CONFIG_RCU_LAZY_DEFAULT_OFF);
> > +module_param(enable_rcu_lazy, bool, 0444);
> > +
> >  /**
> >   * call_rcu_hurry() - Queue RCU callback for invocation after grace period, and
> >   * flush all lazy callbacks (including the new one) to the main ->cblist while
> > @@ -2744,6 +2747,8 @@ void call_rcu_hurry(struct rcu_head *head, rcu_callback_t func)
> >  	__call_rcu_common(head, func, false);
> >  }
> >  EXPORT_SYMBOL_GPL(call_rcu_hurry);
> > +#else
> > +#define enable_rcu_lazy		false
> >  #endif
> >  
> >  /**
> > @@ -2792,7 +2797,7 @@ EXPORT_SYMBOL_GPL(call_rcu_hurry);
> >   */
> >  void call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  {
> > -	__call_rcu_common(head, func, IS_ENABLED(CONFIG_RCU_LAZY));
> > +	__call_rcu_common(head, func, enable_rcu_lazy);
> >  }
> >  EXPORT_SYMBOL_GPL(call_rcu);
> >  
> > -- 
> > 2.34.1
