Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB9479EE15
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbjIMQNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjIMQNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:13:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B839B8;
        Wed, 13 Sep 2023 09:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0VGAAv8ocSEF1ZOwAo/WgYtVv+nBuEUSgAp5uPu6Sb8=; b=LQWTxO3HhrMARS7xqTbvzbxQOz
        yN1wUFLAnZTtILBMCVmzs4KTKpNxytMcYL9+20TSLB939unr63etm2+8nit/maRGfWRxHkAWpzztp
        WShYWB5ItaMsRA+r1bG2AqHkjTWW34t+8880LEgkM6eF9lfVYLQE/+SgNVRrpzXay0nmEdt1H86PQ
        0YJ/tZ+etTc1wwIBaUlbdu7+ydyW4PXcb8VPy7vudja4W16MAFxxEwNrl3j5tmjn+wP59QX/j3dvf
        TdM0pIp3tBIEKz38NfFLVLoIBbn2NrDRM2ACmCXadCONfCxogkSkAgfw1+7w13WKLMEStQNGVLo6I
        6cYOcvQQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qgSTk-00Eogb-Nt; Wed, 13 Sep 2023 16:12:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 62888300348; Wed, 13 Sep 2023 18:12:36 +0200 (CEST)
Date:   Wed, 13 Sep 2023 18:12:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <20230913161236.GI692@noisy.programming.kicks-ass.net>
References: <20230913005647.1534747-1-Liam.Howlett@oracle.com>
 <20230913135246.GH692@noisy.programming.kicks-ass.net>
 <20230913145125.xssion4ygykunzrc@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913145125.xssion4ygykunzrc@revolver>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 10:51:25AM -0400, Liam R. Howlett wrote:
> * Peter Zijlstra <peterz@infradead.org> [230913 09:53]:
> > On Tue, Sep 12, 2023 at 08:56:47PM -0400, Liam R. Howlett wrote:
> > 
> > > diff --git a/init/main.c b/init/main.c
> > > index ad920fac325c..f74772acf612 100644
> > > --- a/init/main.c
> > > +++ b/init/main.c
> > > @@ -696,7 +696,7 @@ noinline void __ref __noreturn rest_init(void)
> > >  	 */
> > >  	rcu_read_lock();
> > >  	tsk = find_task_by_pid_ns(pid, &init_pid_ns);
> > > -	tsk->flags |= PF_NO_SETAFFINITY;
> > > +	tsk->flags |= PF_NO_SETAFFINITY | PF_IDLE;
> > >  	set_cpus_allowed_ptr(tsk, cpumask_of(smp_processor_id()));
> > >  	rcu_read_unlock();
> > >  
> > 
> > Hmm, isn't that pid-1 you're setting PF_IDLE on?
> 
> Yes, thanks.  I think that is what Geert is hitting with my patch.
> 
> debug __might_resched() in kernel/sched/core.c is failing to return in
> that first (complex) if statement.  His report says pid 1 so this is
> likely the issue.
> 
> > 
> > The task becoming idle is 'current' at this point, see the
> > cpu_startup_entry() call below.
> > 
> > Would not something like so be the right thing?
> > 
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 2299a5cfbfb9..802551e0009b 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -9269,7 +9269,7 @@ void __init init_idle(struct task_struct *idle, int cpu)
> >  	 * PF_KTHREAD should already be set at this point; regardless, make it
> >  	 * look like a proper per-CPU kthread.
> >  	 */
> > -	idle->flags |= PF_IDLE | PF_KTHREAD | PF_NO_SETAFFINITY;
> > +	idle->flags |= PF_KTHREAD | PF_NO_SETAFFINITY;
> 
> I am concerned this will alter more than just the current task, which
> would mean more modifications later.  There is a comment about it being
> called 'more than once' and 'per cpu' so I am hesitant to change the
> function itself.
> 
> Although I am unsure of the call path.. fork_idle() -> init_idle() I
> guess?

There's only 2 ways to get into do_idle(), through cpu_startup_entry()
and play_idle_precise(). The latter already frobs PF_IDLE since it is
the forced idle path, this then leaves cpu_startup_entry() which is the
regular idle path.

All idle threads will end up calling into it, the boot CPU through the
rest_init() and the SMP cpus through arch SMP bringup.

IOW, this ensures all idle loops will have PF_IDLE set but not the
pre-idle loop setup code these threads run.
