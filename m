Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B152780DD74
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 22:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345436AbjLKVjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 16:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjLKVje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 16:39:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F246C4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 13:39:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D657DC433C7;
        Mon, 11 Dec 2023 21:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702330780;
        bh=DJzT/+cc0AJqLW4pldSyhoXC+1cJku2DkenpvUYqIfk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UQBlTVCDf58q07TcrYjQ59xXuTWWfl6Vc6U1nDuWsfcVOavgqyypcqYhpVObRG4OQ
         dx1Y7/wRdLptSr+QtLwviqYjxk81q3yngumwNNl9exR/Fk9rq8lGomGig8+tWo+CWG
         uEbb9Noi21I2XOUk4Wt5Rwsdfb9RA3AOjX3mHdVIZ2cigw9e9xsSNzn9hX4GfFg9cg
         9oQAidAd8l8/3+zTLgguS7nsoiLrNdSIAOy7Nl6mdaSlI4wROhyvDUHo9WYI1wYCTT
         aqSzxiA0in6ktR3FxAoFIylMRdv33A2dbi3By3n/+cs9PsqofjT75rAnbWodoOu3OT
         m6d59NmWGC58Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 76730CE04B6; Mon, 11 Dec 2023 13:39:40 -0800 (PST)
Date:   Mon, 11 Dec 2023 13:39:40 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 0/8] rcu: Fix expedited GP deadlock (and cleanup some
 nocb stuff)
Message-ID: <c429620e-53ab-4cd1-b1c2-ca83f4f3cea7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231208220545.7452-1-frederic@kernel.org>
 <0be847d6-804e-4f9d-9eb4-beee9efb6c78@paulmck-laptop>
 <ZXdrNJFCaXAFMITp@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZXdrNJFCaXAFMITp@localhost.localdomain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 09:04:04PM +0100, Frederic Weisbecker wrote:
> Le Mon, Dec 11, 2023 at 08:38:59AM -0800, Paul E. McKenney a écrit :
> > On Fri, Dec 08, 2023 at 11:05:37PM +0100, Frederic Weisbecker wrote:
> > > TREE04 can trigger a writer stall if run with memory pressure. This
> > > is due to a circular dependency between waiting for expedited grace
> > > period and polling on expedited grace period when workqueues go back
> > > to mayday serialization.
> > > 
> > > Here is a proposal fix.
> > 
> > The torture.sh "acceptance test" with KCSAN and --duration 30 ran
> > fine except for this in TREE09:
> > 
> > kernel/rcu/tree_nocb.h:1785:13: error: unused function '__call_rcu_nocb_wake' [-Werror,-Wunused-function]
> > 
> > My guess is that the declaration of __call_rcu_nocb_wake() in
> > kernel/rcu/tree.h needs an "#ifdef CONFIG_SMP", but you might have a
> > better fix.
> 
> Could be because if CONFIG_RCU_NO_CB_CPU=n, the function is only called
> (though as dead code) from rcutree_migrate_callbacks() which in turn only
> exists if CONFIG_HOTPLUG_CPU=y.
> 
> Something like that then:
> 
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 35f7af331e6c..e1ff53d5084c 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -445,6 +445,8 @@ static void rcu_qs(void);
>  static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp);
>  #ifdef CONFIG_HOTPLUG_CPU
>  static bool rcu_preempt_has_tasks(struct rcu_node *rnp);
> +static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_empty,
> +				 unsigned long flags);
>  #endif /* #ifdef CONFIG_HOTPLUG_CPU */
>  static int rcu_print_task_exp_stall(struct rcu_node *rnp);
>  static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp);
> @@ -466,8 +468,6 @@ static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>  				  unsigned long j, bool lazy);
>  static void call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *head,
>  			  rcu_callback_t func, unsigned long flags, bool lazy);
> -static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_empty,
> -				 unsigned long flags);
>  static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp, int level);
>  static bool do_nocb_deferred_wakeup(struct rcu_data *rdp);
>  static void rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp);

This one passes TREE01 and TINY01, but on TREE09 still gets this:

kernel/rcu/tree_nocb.h:1785:13: error: ‘__call_rcu_nocb_wake’ defined but not used [-Werror=unused-function]

Huh.  I suppose that there is always __maybe_unused?

							Thanx, Paul
