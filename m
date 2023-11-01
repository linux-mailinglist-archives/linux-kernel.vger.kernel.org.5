Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766967DE4D9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 17:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344263AbjKAQwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 12:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjKAQwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 12:52:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EDEFD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 09:52:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8E3C433C8;
        Wed,  1 Nov 2023 16:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698857526;
        bh=37fVDxsD1+ndH1KEv7ub60E4WjDu9EIb5gu6BqidoUk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Dv5heqTElz4Np+THPwEwudsnZwZSqzUNhq/tXu0yVGRESGMKuj4YnVuMSIOEzpOoG
         yBO9GF5FWtXKx3mCyMAr4sHXZ1ydAnUuD+sZGgXp2rNS6dtAVJz+SEUWZm0Hej2O9N
         9Zq0JoX53w/QYj7R4kzsEPWrcbfRXnRYslGPLORZh6Oo6/b6V//kyZgTvQSV5YnABn
         Etlb2ZG/2CdOCdryc3SSNdzn7DR1IFhLym/NVeVlbBPwOOlxSe+rx2kbOskVDrCdd/
         +bxRwk5Ga2QRN9bEOmzPjYXmYLHwh2Wz3lyHU7XCa55nv4lk+fPcASiYQ6tN4aAgQR
         qI6ukAU1hluxQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A12B4CE09BE; Wed,  1 Nov 2023 09:52:05 -0700 (PDT)
Date:   Wed, 1 Nov 2023 09:52:05 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Z qiang <qiang.zhang1211@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        kernel test robot <oliver.sang@intel.com>,
        aubrey.li@linux.intel.com, yu.c.chen@intel.com,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        boqun.feng@gmail.com, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com
Subject: Re: [PATCH] rcu: Break rcu_node_0 --> &rq->__lock order
Message-ID: <827b1dbc-beff-4b81-a90e-3bcc7c3b3a30@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231031001418.274187-1-longman@redhat.com>
 <20231031085308.GB35651@noisy.programming.kicks-ass.net>
 <a46f5614-53ec-49fb-86d0-fa5aea4d0a42@paulmck-laptop>
 <20231031200228.GG15024@noisy.programming.kicks-ass.net>
 <CALm+0cWuZZLWkwMPS6n1YyTWzkex9=c1E9CB-m6e_F38MNLVqw@mail.gmail.com>
 <20231101143814.GL15024@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101143814.GL15024@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 03:38:14PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 01, 2023 at 07:21:09PM +0800, Z qiang wrote:
> 
> > >  static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
> > >  {
> > >         unsigned long jtsq;
> > > +       int ret = 0;
> > >         struct rcu_node *rnp = rdp->mynode;
> > >
> > >         /*
> > > @@ -847,8 +852,8 @@ static int rcu_implicit_dynticks_qs(stru
> > >             (time_after(jiffies, READ_ONCE(rdp->last_fqs_resched) + jtsq * 3) ||
> > >              rcu_state.cbovld)) {
> > >                 WRITE_ONCE(rdp->rcu_urgent_qs, true);
> > > -               resched_cpu(rdp->cpu);
> > >                 WRITE_ONCE(rdp->last_fqs_resched, jiffies);
> > > +               ret = -1;
> > >         }
> > >
> > 
> > 
> > Maybe some modifications are missing here:
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index aa4c808978b8..77e7a0dc722a 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -867,8 +867,8 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
> >         if (time_after(jiffies, rcu_state.jiffies_resched)) {
> >                 if (time_after(jiffies,
> >                                READ_ONCE(rdp->last_fqs_resched) + jtsq)) {
> > -                       resched_cpu(rdp->cpu);
> >                         WRITE_ONCE(rdp->last_fqs_resched, jiffies);
> > +                       ret = -1;
> >                 }
> >                 if (IS_ENABLED(CONFIG_IRQ_WORK) &&
> >                     !rdp->rcu_iw_pending && rdp->rcu_iw_gp_seq != rnp->gp_seq &&
> > 
> > 
> 
> Bah, you're quite right, I missed that there were two sites calling
> resched_cpu().
> 
> Paul, do you want a fixed up version or will you fold in the fix?

I can fold it in.  I also clearly need to add a 15-second stall to at
least one of the rcutorture scenarios to exercise this code path...

(And Frederic might be pushing this one, his choice.)

							Thanx, Paul
