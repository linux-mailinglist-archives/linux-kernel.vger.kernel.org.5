Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56AE7D0B18
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376564AbjJTJGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376552AbjJTJGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:06:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1BF1BF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ioyyHtqaMc24vP/Ebg3Nlc6OBQPrCHn0ttSIqLYUh38=; b=LhoV6eRDt5P/a4jZnj4pPsx8YS
        2Joae+tkXUQF791Z9aF7qXgyBRbyYP5J5xNN9pGtBBPFbvoYeIpVFTGd39IqjZdqJXsYYEZRT66fT
        ctDGY/5jBIpWh6p9CXbBAnhp4FaG2ZEGRc7muMO1M1SJXy5TK95OMMTZUYh0FyBIkNxGjp6UZmvZf
        3KrK7cf60OB9a45gX786F/gVQPeCtK2RA0/ViyVuSSwXjSDZDqxF+Xv17xJ3NJpxrRDUiY2fFoAQz
        PX2brrQJBv8u83c8+wfhZ1kuPA6jJvMwfFadPyNTHnFUGoRevBjJHzziok1XA2fXA/LlvPEUFv3td
        BGzXh9SQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qtlSI-00CEaw-PJ; Fri, 20 Oct 2023 09:06:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 685D0300392; Fri, 20 Oct 2023 11:06:06 +0200 (CEST)
Date:   Fri, 20 Oct 2023 11:06:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     Anna-Maria Behnsen <anna-maria@linutronix.de>,
        linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH v8 00/25] timer: Move from a push remote at enqueue to a
 pull at expiry model
Message-ID: <20231020090606.GA31411@noisy.programming.kicks-ass.net>
References: <20231004123454.15691-1-anna-maria@linutronix.de>
 <f7e9279b-a2dc-1980-4134-c6868b47b4ee@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7e9279b-a2dc-1980-4134-c6868b47b4ee@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 10:35:43AM +0530, K Prateek Nayak wrote:
> Hello Anna-Maria,
> 
> On 10/4/2023 6:04 PM, Anna-Maria Behnsen wrote:
> > [..snip..]
> > 
> > Ping Pong Oberservation
> > ^^^^^^^^^^^^^^^^^^^^^^^
> > 
> > During testing on a mostly idle machine a ping pong game could be observed:
> > a process_timeout timer is expired remotely on a non idle CPU. Then the CPU
> > where the schedule_timeout() was executed to enqueue the timer comes out of
> > idle and restarts the timer using schedule_timeout() and goes back to idle
> > again. This is due to the fair scheduler which tries to keep the task on
> > the CPU which it previously executed on.
> 
> Regarding above, are you referring to "wake_up_process(timeout->task)" in
> "process_timeout()" ends up waking the task on an idle CPU instead of the
> CPU where process_timeout() ran?
> 
> In which case, have you tried using the "WF_CURRENT_CPU" flag for the
> wakeup? (landed upstream in v6.6-rc1) It is only used by wait queues in
> kernel/sched/wait.c currently but perhaps we can have a
> "wake_up_process_on_current_cpu()" that process_timeout() can call.
> 
> Something along the lines of:
> 
> 	int wake_up_process_on_current_cpu(struct task_struct *p)
> 	{
> 		return try_to_wake_up(p, TASK_NORMAL, WF_CURRENT_CPU);
> 	}
> 	EXPORT_SYMBOL(wake_up_process_on_current_cpu);
> 
> Thoughts?

Yeah, we should definitely not export such a function. Also,
WF_CURRENT_CPU should be used sparingly.

So restarting the task on the previous CPU is done because of cache
affinity and is typically the right thing to do if you care about
performance.

The first question to ask is where this schedule_timeout() is coming
from. Is this some daft userspace that is polling on something that
eventually ends up in schedule_timeout() ?

Can we fix the userspace to not do silly things like that?

The alternative is adding heuristics and we all know where that ends :/

