Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60F279EA19
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236088AbjIMNxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjIMNxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:53:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B7A19B6;
        Wed, 13 Sep 2023 06:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HBGkdRgqPXI4bHcmCrKt82K03JWpt+6ZAQAiRZJ7acE=; b=Mi4UuSRD2ivRV5Q2hqAggIYI1z
        k3GbBEZ14lnReEsSNnZm9fAYEZ+KIzLh80yw1vsU9aUJjqKk4R0S90mQ5zOT9hXmfJwZNiVkHaTol
        Shy0DdygOKgcpxDo4AueJUNmxDm2peQ4gGUNLYtX5qjvM0MB/dedxiUR9U+kjNjbXbM0mikAmF/ut
        JB1BgzgQHXcMH2DKXmbEb0vdOpetaicthLGORK2lwmY3EJNlXHP2iPi7jcAagXpl35oZcoRom77yv
        y4XWVjuid309Cn25/5+rVLJa3eWYC/ZmzEHxhOOtHxg0IRYyXXdyJXyWOdHCrl8J2/qhJi0LATG5t
        V1p/5q6Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qgQIQ-00EDF7-Jd; Wed, 13 Sep 2023 13:52:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 466A9300348; Wed, 13 Sep 2023 15:52:46 +0200 (CEST)
Date:   Wed, 13 Sep 2023 15:52:46 +0200
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
Message-ID: <20230913135246.GH692@noisy.programming.kicks-ass.net>
References: <20230913005647.1534747-1-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913005647.1534747-1-Liam.Howlett@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 08:56:47PM -0400, Liam R. Howlett wrote:

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

Hmm, isn't that pid-1 you're setting PF_IDLE on?

The task becoming idle is 'current' at this point, see the
cpu_startup_entry() call below.

Would not something like so be the right thing?


diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2299a5cfbfb9..802551e0009b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9269,7 +9269,7 @@ void __init init_idle(struct task_struct *idle, int cpu)
 	 * PF_KTHREAD should already be set at this point; regardless, make it
 	 * look like a proper per-CPU kthread.
 	 */
-	idle->flags |= PF_IDLE | PF_KTHREAD | PF_NO_SETAFFINITY;
+	idle->flags |= PF_KTHREAD | PF_NO_SETAFFINITY;
 	kthread_set_per_cpu(idle, cpu);
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 342f58a329f5..5007b25c5bc6 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -373,6 +373,7 @@ EXPORT_SYMBOL_GPL(play_idle_precise);
 
 void cpu_startup_entry(enum cpuhp_state state)
 {
+	current->flags |= PF_IDLE;
 	arch_cpu_idle_prepare();
 	cpuhp_online_idle(state);
 	while (1)
