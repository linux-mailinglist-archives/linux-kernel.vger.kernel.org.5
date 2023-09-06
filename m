Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468B879374E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbjIFIpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjIFIpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:45:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B230E9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 01:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zgIsXo6Khw02yAKfva/Jt4TDjflElpXL3EukZio+TlY=; b=I9Dq5UlYUK/Kpfsi8+4jY2pLs6
        gcKTL0WUHOmKD0FmBnAmdfs7E511mMGllpplRHUwf7NF6KKZibCwXhLkjXnYk4fm6Y/MpRHeDhpEm
        GHm3i+9RwbZl7CHbhr/RdezXuU83ZyPm+u1up7/DSaayUAi/oJzNBy5gWC3jKuS5NCHlY06I3C/Tq
        LQPMl1eh4sgTJ90Apd/DrLytbZ55ELBWvMSR+FD9eSFJhlL6AATZV0bqffYrXL4faE3is9lX8wYuZ
        x3bLj1nYDI2GGDhgNDCbFoECTDtuHPjAoHBJqpIyPK5/RD0hnux+WwbvvregrpTFLTZXUWip2jalR
        IGKptIhg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qdo9g-000on7-10; Wed, 06 Sep 2023 08:44:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id A7D603003F2; Wed,  6 Sep 2023 10:44:55 +0200 (CEST)
Date:   Wed, 6 Sep 2023 10:44:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>, x86@kernel.org
Subject: Re: [RFC PATCH 1/2] sched: Rate limit migrations to 1 per 2ms per
 task
Message-ID: <20230906084455.GD38741@noisy.programming.kicks-ass.net>
References: <20230905171105.1005672-1-mathieu.desnoyers@efficios.com>
 <20230905171105.1005672-2-mathieu.desnoyers@efficios.com>
 <cfc3de8fa3172cedf406ccef8c94ef4da0a00281.camel@linux.intel.com>
 <866f23cc-6725-fc74-099f-450939fc0dc4@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <866f23cc-6725-fc74-099f-450939fc0dc4@efficios.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 05:16:25PM -0400, Mathieu Desnoyers wrote:
> On 9/5/23 16:28, Tim Chen wrote:
> > On Tue, 2023-09-05 at 13:11 -0400, Mathieu Desnoyers wrote:
> > > Rate limit migrations to 1 migration per 2 milliseconds per task. On a
> > > kernel with EEVDF scheduler (commit b97d64c722598ffed42ece814a2cb791336c6679),
> > > this speeds up hackbench from 62s to 45s on AMD EPYC 192-core (over 2 sockets).
> > > 
> > > 
> > > 
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index 479db611f46e..0d294fce261d 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -4510,6 +4510,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
> > >   	p->se.vruntime			= 0;
> > >   	p->se.vlag			= 0;
> > >   	p->se.slice			= sysctl_sched_base_slice;
> > > +	p->se.next_migration_time	= 0;
> > 
> > It seems like the next_migration_time should be initialized to the current time,
> > in case the system run for a long time and clock wrap around could cause problem.
> 
> next_migration_time is a u64, which should "never" overflow. Other scheduler
> code comparing with sched_clock() don't appear to care about u64 overflow.

Much code actually considers overflow. We also have monotonicity filters
where it really matters.
