Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD357C5265
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345936AbjJKLrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjJKLrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:47:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59C18F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=RSsV3tzE81yhMrJ2OAEkPBSGqOhOdmB831LXDp5PvM8=; b=D6O30peoybOa+iTaf2UQhdZU0s
        kpT3cNMQkH2f5dT8iFXvz7/4WP4IAfW+lJe8X38+4NOkKSz9wXr7WTSa+fxGQzUslfvJAhtpwYhOU
        +yhWzE6xPEPeFQieevpx8CZ6ndWYWvw54QGbp52lKRFbp5izL/h1m0mTFrM9UkAFtlIlA7ha9MoMS
        vBMkaBbHH8QUrVWJHye6n5nvlSp2N0P/RhjK6aWuu9pXEa6oAVKOaUVHIQUjLL8S+agrVT1guRgW3
        naz9KZ7wsUwiBDz9XhegVDDSTgenVsITNszY7p59JdrswuJaiAsf9d0W8jHocBu1dSnUmlb6g/Upn
        S9eK0L5A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qqXfl-000BmS-0e;
        Wed, 11 Oct 2023 11:46:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2273130036C; Wed, 11 Oct 2023 13:46:42 +0200 (CEST)
Date:   Wed, 11 Oct 2023 13:46:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ankit Jain <ankitja@vmware.com>
Cc:     yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, qyousef@layalina.io, pjt@google.com,
        joshdon@google.com, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, namit@vmware.com,
        amakhalov@vmware.com, srinidhir@vmware.com, vsirnapalli@vmware.com,
        vbrahmajosyula@vmware.com, akaher@vmware.com,
        srivatsa@csail.mit.edu
Subject: Re: [PATCH RFC] cpumask: Randomly distribute the tasks within
 affinity mask
Message-ID: <20231011114642.GA36521@noisy.programming.kicks-ass.net>
References: <20231011071925.761590-1-ankitja@vmware.com>
 <20231011105329.GA17066@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231011105329.GA17066@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 12:53:29PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 11, 2023 at 12:49:25PM +0530, Ankit Jain wrote:
> > commit 46a87b3851f0 ("sched/core: Distribute tasks within affinity masks")
> > and commit 14e292f8d453 ("sched,rt: Use cpumask_any*_distribute()")
> > introduced the logic to distribute the tasks at initial wakeup on cpus
> > where load balancing works poorly or disabled at all (isolated cpus).
> > 
> > There are cases in which the distribution of tasks
> > that are spawned on isolcpus does not happen properly.
> > In production deployment, initial wakeup of tasks spawn from
> > housekeeping cpus to isolcpus[nohz_full cpu] happens on first cpu
> > within isolcpus range instead of distributed across isolcpus.
> > 
> > Usage of distribute_cpu_mask_prev from one processes group,
> > will clobber previous value of another or other groups and vice-versa.
> > 
> > When housekeeping cpus spawn multiple child tasks to wakeup on
> > isolcpus[nohz_full cpu], using cpusets.cpus/sched_setaffinity(),
> > distribution is currently performed based on per-cpu
> > distribute_cpu_mask_prev counter.
> > At the same time, on housekeeping cpus there are percpu
> > bounded timers interrupt/rcu threads and other system/user tasks
> > would be running with affinity as housekeeping cpus. In a real-life
> > environment, housekeeping cpus are much fewer and are too much loaded.
> > So, distribute_cpu_mask_prev value from these tasks impacts
> > the offset value for the tasks spawning to wakeup on isolcpus and
> > thus most of the tasks end up waking up on first cpu within the
> > isolcpus set.
> > 
> > Steps to reproduce:
> > Kernel cmdline parameters:
> > isolcpus=2-5 skew_tick=1 nohz=on nohz_full=2-5
> > rcu_nocbs=2-5 rcu_nocb_poll idle=poll irqaffinity=0-1
> > 
> > * pid=$(echo $$)
> > * taskset -pc 0 $pid
> > * cat loop-normal.c
> > int main(void)
> > {
> >         while (1)
> >                 ;
> >         return 0;
> > }
> > * gcc -o loop-normal loop-normal.c
> > * for i in {1..50}; do ./loop-normal & done
> > * pids=$(ps -a | grep loop-normal | cut -d' ' -f5)
> > * for i in $pids; do taskset -pc 2-5 $i ; done
> > 
> > Expected output:
> > * All 50 “loop-normal” tasks should wake up on cpu2-5
> > equally distributed.
> > * ps -eLo cpuid,pid,tid,ppid,cls,psr,cls,cmd | grep "^    [2345]"
> > 
> > Actual output:
> > * All 50 “loop-normal” tasks got woken up on cpu2 only
> 
> Your expectation is wrong. Things work as advertised.

That is, isolcpus results in single CPU balance domains and as such we
must not distribute -- there is no load balancing.

Ideally we'd reject setting cpumasks with multi bits set on domains like
that, but alas, that would break historical behaviour :/

Now, looking at the code, I don't think the current code actually
behaves correct in this case :-(, somewhere along the line we should
truncate cpu_valid_mask to a single bit. Let me see where the sane place
is to do that.


