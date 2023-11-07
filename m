Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADC77E4667
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjKGQx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234891AbjKGQxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:53:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A6893;
        Tue,  7 Nov 2023 08:53:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698A3C433C7;
        Tue,  7 Nov 2023 16:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699376031;
        bh=aiyZY2wnLnS/i8/VawIvUr+uL7/T9VCKCy5RQebT9zM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Ku/XESIBhwhEkBG4HF3U7hMTfFFIzN7tZzAulkHpLv/euR1rMW43+9k/anNilw17Z
         7IK75C613tjsZ/FWu8ytyxjrHznMF6cr+7D/qMDJv/LJCxtYQalElpL64t7ZCB666/
         GLXkTh+pHYjrPpLmKTQQZ0goGXe6LfMcuG+Iv3zqZbiS+GZ8w6oGADFs3cjm/bfydD
         oa+BrRdKtYvl/Yh+6QEqpO9s4XYWAA6omO+uTqi4vrJF3OGBAthPL+HNWsYZfJWV9g
         99Y/ETfokb9TshT9zqxVHxIwe9hLxLUKl5LU+cSQmx7rHG0jO3VS6EUazhpghxttkK
         yFDDSuL+XBgDg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E3FC4CE0B6B; Tue,  7 Nov 2023 08:53:48 -0800 (PST)
Date:   Tue, 7 Nov 2023 08:53:48 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Z qiang <qiang.zhang1211@gmail.com>
Cc:     frederic@kernel.org, joel@joelfernandes.org, boqun.feng@gmail.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Force quiescent states only for ongoing grace period
Message-ID: <3ed2eb7d-a774-4e1f-9dee-ebb3b34192c2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231101033507.21651-1-qiang.zhang1211@gmail.com>
 <9f15280f-45a3-4e3f-832d-cea5c77eb449@paulmck-laptop>
 <CALm+0cULD+R1EmWVRi1RZJJgD=CGb2oxxGMZojU7A9z8Wj_QVQ@mail.gmail.com>
 <b9b3502d-4b45-4bcd-b08a-a177bba80cca@paulmck-laptop>
 <CALm+0cW4Qk74bRkW+B+5AZVLgnphfNSfmVARsUfJ6ueScAZihw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALm+0cW4Qk74bRkW+B+5AZVLgnphfNSfmVARsUfJ6ueScAZihw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 02:30:57PM +0800, Z qiang wrote:
> >
> > On Fri, Nov 03, 2023 at 03:14:11PM +0800, Z qiang wrote:
> > > >
> > > > On Wed, Nov 01, 2023 at 11:35:07AM +0800, Zqiang wrote:
> > > > > Currently, when running the rcutorture testing, if the fqs_task
> > > > > kthread was created, the periodic fqs operations will be performed,
> > > > > regardless of whether the grace-period is ongoing. however, if there
> > > > > is no ongoing grace-period, invoke the rcu_force_quiescent_state() has
> > > > > no effect, because when the new grace-period starting, will clear all
> > > > > flags int rcu_state.gp_flags in rcu_gp_init(). this commit therefore add
> > > > > rcu_gp_in_progress() check in rcu_force_quiescent_state(), if there is
> > > > > no ongoing grace-period, return directly.
> > > > >
> > > > > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > > >
> > > > Nice optimization, but one question below.
> > > >
> > > >                                                 Thanx, Paul
> > > >
> > > > > ---
> > > > >  kernel/rcu/tree.c | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > > >
> > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > index aa4c808978b8..5b4279ef66da 100644
> > > > > --- a/kernel/rcu/tree.c
> > > > > +++ b/kernel/rcu/tree.c
> > > > > @@ -2338,6 +2338,8 @@ void rcu_force_quiescent_state(void)
> > > > >       struct rcu_node *rnp;
> > > > >       struct rcu_node *rnp_old = NULL;
> > > > >
> > > > > +     if (!rcu_gp_in_progress())
> > > > > +             return;
> > > >
> > > > Suppose that the grace period that was in progress above ends right
> > > > at this point in the code.  We will still do the useless grace
> > > > forcing of quiescent states.  Which means that this code path
> > > > does need to be tested.
> > > >
> > > > So, when you run rcutorture with this change, how often has the
> > > > grace period ended before this function returns?  If that happens
> > > > reasonably often, say more than once per minute or so, then this
> > > > works nicely.  If not, we do need to do something to make sure
> > > > that that code path gets tested.
> > > >
> > > > Thoughts?
> > >
> > > Thanks for the suggestion, I will add some debug information to test again.
> >
> > Very good, and I look forward to seeing what you come up with!
> >
> 
> Hi, Paul
> 
> I added some debug code to run rcu torture tests:
> 
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index 98e13be411af..248e13e1ccd6 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -548,6 +548,9 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
>                                unsigned long c_old,
>                                unsigned long c);
>  void rcu_gp_set_torture_wait(int duration);
> +void rcutorture_fqs_set(bool on);
> +unsigned long rcutorture_fqs_nr(void);
> +unsigned long rcutorture_fqs_valid_nr(void);
>  #else
>  static inline void rcutorture_get_gp_data(enum rcutorture_type test_type,
>                                           int *flags, unsigned long *gp_seq)
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 9bd6856135d7..15f506c26df3 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -1179,6 +1179,7 @@ rcu_torture_fqs(void *arg)
>         int oldnice = task_nice(current);
> 
>         VERBOSE_TOROUT_STRING("rcu_torture_fqs task started");
> +       rcutorture_fqs_set(true);
>         do {
>                 fqs_resume_time = jiffies + fqs_stutter * HZ;
>                 while (time_before(jiffies, fqs_resume_time) &&
> @@ -1195,6 +1196,7 @@ rcu_torture_fqs(void *arg)
>                 if (stutter_wait("rcu_torture_fqs"))
>                         sched_set_normal(current, oldnice);
>         } while (!torture_must_stop());
> +       rcutorture_fqs_set(false);
>         torture_kthread_stopping("rcu_torture_fqs");
>         return 0;
>  }
> @@ -2213,6 +2215,7 @@ rcu_torture_stats_print(void)
>         pr_cont("read-exits: %ld ", data_race(n_read_exits)); // Statistic.
>         pr_cont("nocb-toggles: %ld:%ld\n",
>                 atomic_long_read(&n_nocb_offload),
> atomic_long_read(&n_nocb_deoffload));
> +       pr_cont("nr_fqs: %ld:%ld\n", rcutorture_fqs_valid_nr(),
> rcutorture_fqs_nr());
> 
>         pr_alert("%s%s ", torture_type, TORTURE_FLAG);
>         if (atomic_read(&n_rcu_torture_mberror) ||
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index cb1caefa8bd0..9ae0c442e552 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2299,6 +2299,38 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
>         }
>  }
> 
> +static bool rcu_fqs_enable;
> +static unsigned long fqs_valid_nr;
> +static unsigned long fqs_nr;
> +
> +void rcutorture_fqs_set(bool on)
> +{
> +       WRITE_ONCE(rcu_fqs_enable, on);
> +}
> +EXPORT_SYMBOL_GPL(rcutorture_fqs_set);
> +
> +unsigned long rcutorture_fqs_nr(void)
> +{
> +       return READ_ONCE(fqs_nr);
> +}
> +EXPORT_SYMBOL_GPL(rcutorture_fqs_nr);
> +
> +unsigned long rcutorture_fqs_valid_nr(void)
> +{
> +       return READ_ONCE(fqs_valid_nr);
> +}
> +EXPORT_SYMBOL_GPL(rcutorture_fqs_valid_nr);
> +
> +void rcutorture_fqs_account(void)
> +{
> +       if (rcu_fqs_enable) {
> +               if (READ_ONCE(rcu_state.gp_state) == RCU_GP_WAIT_FQS ||
> +                               READ_ONCE(rcu_state.gp_state) ==
> RCU_GP_DOING_FQS)
> +                       WRITE_ONCE(fqs_valid_nr, fqs_valid_nr + 1);
> +               WRITE_ONCE(fqs_nr, fqs_nr + 1);
> +       }
> +}
> +
>  /*
>   * Force quiescent states on reluctant CPUs, and also detect which
>   * CPUs are in dyntick-idle mode.
> @@ -2333,6 +2365,7 @@ void rcu_force_quiescent_state(void)
>         WRITE_ONCE(rcu_state.gp_flags,
>                    READ_ONCE(rcu_state.gp_flags) | RCU_GP_FLAG_FQS);
>         raw_spin_unlock_irqrestore_rcu_node(rnp_old, flags);
> +       rcutorture_fqs_account();
>         rcu_gp_kthread_wake();
>  }
>  EXPORT_SYMBOL_GPL(rcu_force_quiescent_state);
> 
> runqemu kvm nographic slirp qemuparams="-smp 4 -m 1024"
> bootparams="rcutorture.fqs_duration=6 rcutorture.fqs_holdoff=1
> rcutorture.shutdown_secs=3600" -d
> 
> original
> [ 3603.574361] nr_fqs: 1635:1723
> apply this patch
> [ 3603.990193] nr_fqs: 1787:1795

Very good, then it does appear that we are exercising the code, thank
you for checking!

Let me go find that commit again...

							Thanx, Paul

> Thanks
> Zqiang
> 
> 
> 
> >
> >                                                         Thanx, Paul
> >
> > > Thanks
> > > Zqiang
> > >
> > > >
> > > > >       /* Funnel through hierarchy to reduce memory contention. */
> > > > >       rnp = raw_cpu_read(rcu_data.mynode);
> > > > >       for (; rnp != NULL; rnp = rnp->parent) {
> > > > > --
> > > > > 2.17.1
> > > > >
