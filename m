Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E257A79E6B5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240161AbjIML2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240021AbjIML2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:28:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C39B173E;
        Wed, 13 Sep 2023 04:28:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAC0C433C7;
        Wed, 13 Sep 2023 11:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694604507;
        bh=TgkMDTSkKvv4v8TszdJrmsSFRm605JoHp3AjwV4m+9c=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=scWKfvGSzlV8VbrgFExT/iBiV7p7Hm6NS/oiTwWinIkZ9EX3STfSnMhxsJujgFxZe
         E37E8lYZFibj9+PWgHBsuqs2YPfibAqF3dcIgMwA+SWX1l2E3PQtcBy2C2Sfh8roFs
         9wO9N/KcqF5zt3T2o8es07/Xx7Qa73nwFd+pVP1xHzcW49Wka47WiKwY2SaQsAg6Dh
         pvrVBbl7OS8+FepotpWFQDIW7XK3weNVf7u/gEQqUHns8UHeKFslc7zA7g/UOidjNl
         mDSOpKqbyPolRFeafKOAZ6tXJektNF90u43Wb4odCg/MKdf82eXVuNQwqn0tYWc1Z6
         jpeowzaDppzOg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6AE58CE093C; Wed, 13 Sep 2023 04:28:27 -0700 (PDT)
Date:   Wed, 13 Sep 2023 04:28:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Matthew Wilcox <willy@infradead.org>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] init/main: Clear boot task idle flag
Message-ID: <14620af6-7315-4de3-ac7f-5bb51f773397@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230913005647.1534747-1-Liam.Howlett@oracle.com>
 <20230913110139.GE692@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913110139.GE692@noisy.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 01:01:39PM +0200, Peter Zijlstra wrote:
> On Tue, Sep 12, 2023 at 08:56:47PM -0400, Liam R. Howlett wrote:
> > Initial booting is setting the task flag to idle (PF_IDLE) by the call
> > path sched_init() -> init_idle().  Having the task idle and calling
> > call_rcu() in kernel/rcu/tiny.c means that TIF_NEED_RESCHED will be
> > set.  Subsequent calls to any cond_resched() will enable IRQs,
> > potentially earlier than the IRQ setup has completed.  Recent changes
> > have caused just this scenario and IRQs have been enabled early.
> > 
> > This causes a warning later in start_kernel() as interrupts are enabled
> > before they are fully set up.
> > 
> > Fix this issue by clearing the PF_IDLE flag on return from sched_init()
> > and restore the flag in rest_init().  Although the boot task was marked
> > as idle since (at least) d80e4fda576d, I am not sure that it is wrong to
> > do so.  The forced context-switch on idle task was introduced in the
> > tiny_rcu update, so I'm going to claim this fixes 5f6130fa52ee.
> > 
> > Link: https://lore.kernel.org/linux-mm/87v8cv22jh.fsf@mail.lhotse/
> > Link: https://lore.kernel.org/linux-mm/CAMuHMdWpvpWoDa=Ox-do92czYRvkok6_x6pYUH+ZouMcJbXy+Q@mail.gmail.com/
> > Fixes: 5f6130fa52ee ("tiny_rcu: Directly force QS when call_rcu_[bh|sched]() on idle_task")
> > Cc: stable@vger.kernel.org
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> > Cc: Andreas Schwab <schwab@linux-m68k.org>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Peng Zhang <zhangpeng.00@bytedance.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >  init/main.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/init/main.c b/init/main.c
> > index ad920fac325c..f74772acf612 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -696,7 +696,7 @@ noinline void __ref __noreturn rest_init(void)
> >  	 */
> >  	rcu_read_lock();
> >  	tsk = find_task_by_pid_ns(pid, &init_pid_ns);
> > -	tsk->flags |= PF_NO_SETAFFINITY;
> > +	tsk->flags |= PF_NO_SETAFFINITY | PF_IDLE;
> >  	set_cpus_allowed_ptr(tsk, cpumask_of(smp_processor_id()));
> >  	rcu_read_unlock();
> >  
> > @@ -938,6 +938,8 @@ void start_kernel(void)
> >  	 * time - but meanwhile we still have a functioning scheduler.
> >  	 */
> >  	sched_init();
> > +	/* Avoid early context switch, rest_init() restores PF_IDLE */
> > +	current->flags &= ~PF_IDLE;
> >  
> >  	if (WARN(!irqs_disabled(),
> >  		 "Interrupts were enabled *very* early, fixing it\n"))
> 
> Hurmph... so since this is about IRQs, would it not make sense to have
> the | PF_IDLE near 'early_boot_irqs_disabled = false' ?
> 
> Or, alternatively, make the tinyrcu thing check that variable?

We could do that, but do we really the decidedly non-idle early boot
sequence designated as idle?

What surprises me is that this is just now showing up.  The ingredients
for this one have been in place for almost 10 years.

							Thanx, Paul
