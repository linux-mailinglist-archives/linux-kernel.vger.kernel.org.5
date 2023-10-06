Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E654A7BBFF7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbjJFUBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbjJFUBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:01:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87968F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g0vOgBI0lSu8z4FzksLC5Aouy2dLkWy4P2MR/ExznUo=; b=H7TeeRjq1dADiQhh23Cbhv5YqB
        A/VuTJrIq3hHYeoBhFN1XiCmCpa3GLi5z77cI12ce9ooL0FnW+TNSDN+kI9Z5ie3C3Xi50WyHhxxc
        5FROC4k96bftr8WE9zLL2/X6eDRQchwwTnn+4Wli7z6MqCrL6Yce5H16Cz5BUfr8awO1qWCI9btD4
        qs+9/Iork/A3uGL0S1HaHdYqBNpEhdj6z3Tk95ga2+RT6pHOaTSmY8mkCgdA5oP1WgGSt1Ld0Tsfq
        UmpffyTELhNIs0lgySnGtv+u4n04WgbnyHsYeQAJFS4c9XmqkDHe9gz14OqVERmUkItDBsNJ3wlPF
        49rJe/yQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qor0s-00HBlN-1b; Fri, 06 Oct 2023 20:01:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 93DAD300392; Fri,  6 Oct 2023 22:01:29 +0200 (CEST)
Date:   Fri, 6 Oct 2023 22:01:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vineeth Pillai <vineethrp@google.com>,
        Suleiman Souhlal <suleiman@google.com>,
        Hsin Yi <hsinyi@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH RFC] sched/fair: Avoid unnecessary IPIs for ILB
Message-ID: <20231006200129.GJ36277@noisy.programming.kicks-ass.net>
References: <20231005161727.1855004-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005161727.1855004-1-joel@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 04:17:26PM +0000, Joel Fernandes (Google) wrote:
> From: Vineeth Pillai <vineethrp@google.com>
> 
> Whenever a CPU stops its tick, it now requires another idle CPU to handle the
> balancing for it because it can't perform its own periodic load balancing.
> This means it might need to update 'nohz.next_balance' to 'rq->next_balance' if
> the upcoming nohz-idle load balancing is too distant in the future. This update
> process is done by triggering an ILB, as the general ILB handler
> (_nohz_idle_balance) that manages regular nohz balancing also refreshes
> 'nohz.next_balance' by looking at the 'rq->next_balance' of all other idle CPUs
> and selecting the smallest value.
> 
> Triggering this ILB can be achieved by setting the NOHZ_NEXT_KICK flag. This
> primarily results in the ILB handler updating 'nohz.next_balance' while
> possibly not doing any load balancing at all. However, sending an IPI merely to
> refresh 'nohz.next_balance' seems excessive, and there ought to be a more
> efficient method to update 'nohz.next_balance' from the local CPU.
> 
> Fortunately, there already exists a mechanism to directly invoke the ILB
> handler (_nohz_idle_balance) without initiating an IPI. It's accomplished by
> setting the NOHZ_NEWILB_KICK flag. This flag is set during regular "newly idle"
> balancing and solely exists to update a CPU's blocked load if it couldn't pull
> more tasks during regular "newly idle balancing" - and it does so without
> having to send any IPIs. Once the flag is set, the ILB handler is called
> directly from do_idle()-> nohz_run_idle_balance(). While its goal is to update
> the blocked load without an IPI, in our situation, we aim to refresh
> 'nohz.next_balance' without an IPI but we can piggy back on this.
> 
> So in this patch, we reuse this mechanism by also setting the NOHZ_NEXT_KICK to
> indicate nohz.next_balance needs an update via this direct call shortcut. Note
> that we set this flag without knowledge that the tick is about to be stopped,
> because at the point we do it, we have no way of knowing that. However we do
> know that the CPU is about to enter idle. In our testing, the reduction in IPIs
> is well worth updating nohz.next_balance a few more times.
> 
> Also just to note, without this patch we observe the following pattern:
> 
> 1. A CPU is about to stop its tick.
> 2. It sets nohz.needs_update to 1.
> 3. It then stops its tick and goes idle.
> 4. The scheduler tick on another CPU checks this flag and decides an ILB kick is needed.
> 5. The ILB CPU ends up being the one that just stopped its tick!
> 6. This results in an IPI to the tick-stopped CPU which ends up waking it up
>    and disturbing it!
> 
> Testing shows a considerable reduction in IPIs when doing this:
> 
> Running "cyclictest -i 100 -d 100 --latency=1000 -t -m" on a 4vcpu VM
> the IPI call count profiled over 10s period is as follows:
> without fix: ~10500
> with fix: ~1000
> 
> Fixes: 7fd7a9e0caba ("sched/fair: Trigger nohz.next_balance updates when a CPU goes NOHZ-idle")

Hurm.. does this really warrant a Fixes tag? Afaict nothing is currently
broken -- this is a pure optimization question, no?
