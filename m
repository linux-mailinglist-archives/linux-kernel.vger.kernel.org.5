Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FD379E59F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239881AbjIMLCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjIMLCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:02:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41CE1726;
        Wed, 13 Sep 2023 04:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ph6IZOjxVfNK0j0D6FBkY/k2VECArBn3iv8gnIxi7NU=; b=LWgmBUtqijN5jZg4OTh3/n7y8S
        CBGYD5upmZC2bNhP4tUBGRgBf/M14Iy7pfwWf1cgDMqKKCRC/khSGyEVbigMwsZOTds2JZHEEZq+b
        RH9NQFMYUhSy04YwqbKDJELCZDNHq6Y+rgXMaaz3bhgyQR9e/oj5CAd7cGNT66jhgBj7xdh6d3JhP
        xzI27FDLWkWJtkgbKZW/TMY5jFuysOyzUYOwZaEASTWhnDRlUwAe2iUrTaxapVtOQ7sv2T6fYkee1
        knclwk/xz098cfRo3p/puWgRPh3Q/KNPo1bdAzBE117ZOMpSAUXMlNTVTZxZnPsZV4VjQF57m6RrP
        jfrJ/K+w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qgNcq-00DQqf-F2; Wed, 13 Sep 2023 11:01:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1CCF4300348; Wed, 13 Sep 2023 13:01:40 +0200 (CEST)
Date:   Wed, 13 Sep 2023 13:01:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20230913110139.GE692@noisy.programming.kicks-ass.net>
References: <20230913005647.1534747-1-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913005647.1534747-1-Liam.Howlett@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 08:56:47PM -0400, Liam R. Howlett wrote:
> Initial booting is setting the task flag to idle (PF_IDLE) by the call
> path sched_init() -> init_idle().  Having the task idle and calling
> call_rcu() in kernel/rcu/tiny.c means that TIF_NEED_RESCHED will be
> set.  Subsequent calls to any cond_resched() will enable IRQs,
> potentially earlier than the IRQ setup has completed.  Recent changes
> have caused just this scenario and IRQs have been enabled early.
> 
> This causes a warning later in start_kernel() as interrupts are enabled
> before they are fully set up.
> 
> Fix this issue by clearing the PF_IDLE flag on return from sched_init()
> and restore the flag in rest_init().  Although the boot task was marked
> as idle since (at least) d80e4fda576d, I am not sure that it is wrong to
> do so.  The forced context-switch on idle task was introduced in the
> tiny_rcu update, so I'm going to claim this fixes 5f6130fa52ee.
> 
> Link: https://lore.kernel.org/linux-mm/87v8cv22jh.fsf@mail.lhotse/
> Link: https://lore.kernel.org/linux-mm/CAMuHMdWpvpWoDa=Ox-do92czYRvkok6_x6pYUH+ZouMcJbXy+Q@mail.gmail.com/
> Fixes: 5f6130fa52ee ("tiny_rcu: Directly force QS when call_rcu_[bh|sched]() on idle_task")
> Cc: stable@vger.kernel.org
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Andreas Schwab <schwab@linux-m68k.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Peng Zhang <zhangpeng.00@bytedance.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  init/main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/init/main.c b/init/main.c
> index ad920fac325c..f74772acf612 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -696,7 +696,7 @@ noinline void __ref __noreturn rest_init(void)
>  	 */
>  	rcu_read_lock();
>  	tsk = find_task_by_pid_ns(pid, &init_pid_ns);
> -	tsk->flags |= PF_NO_SETAFFINITY;
> +	tsk->flags |= PF_NO_SETAFFINITY | PF_IDLE;
>  	set_cpus_allowed_ptr(tsk, cpumask_of(smp_processor_id()));
>  	rcu_read_unlock();
>  
> @@ -938,6 +938,8 @@ void start_kernel(void)
>  	 * time - but meanwhile we still have a functioning scheduler.
>  	 */
>  	sched_init();
> +	/* Avoid early context switch, rest_init() restores PF_IDLE */
> +	current->flags &= ~PF_IDLE;
>  
>  	if (WARN(!irqs_disabled(),
>  		 "Interrupts were enabled *very* early, fixing it\n"))


Hurmph... so since this is about IRQs, would it not make sense to have
the | PF_IDLE near 'early_boot_irqs_disabled = false' ?

Or, alternatively, make the tinyrcu thing check that variable?
