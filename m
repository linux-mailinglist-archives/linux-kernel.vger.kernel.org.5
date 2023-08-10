Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9391977721B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjHJIHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjHJIHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:07:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23598F7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:07:12 -0700 (PDT)
Date:   Thu, 10 Aug 2023 10:07:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691654830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=byhvTeVftWnA3njnzkG9bxMKWEmXEW6/8WQvkjYEvpQ=;
        b=Hs4zWaIlwuYV6liu4Tx97x8Hgt404JQEDd/hyGf1UNcke47l7xNdxJN48WC80bd5aNIvY7
        Ww8RxI4TBPxzhSU89xsRkY9uFaMJ0SqXZgMm5YZUsbM1fGta/w9ymtxjR0+yDcwC5Mums6
        N7OsvHRC9Hsy6ewoZJO2f+AmODNfYwDCcSn1Y7KezVFxxp53CDzhwNyx1R1AYxT1c44sGj
        vKBLz9lQskFH+jVHR7MVYZMkfmfwB4jTONP7XSacJUDGJvFa5XaUL2eI8jTTu4Fpyba8L9
        HY/Wc5QBItR4BLRMy3qKzCMgKQTYXvvVTjq4t2uHyi0iLaGqSPq5xXw7WrN9dA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691654830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=byhvTeVftWnA3njnzkG9bxMKWEmXEW6/8WQvkjYEvpQ=;
        b=AkdV8/JRBnt/3WHW6KVtAODScCsMgy+2Mhm2KLXeI7IIhQXpGKO5yNvWAQqO6xm1+IlKgt
        zlt+g6eaRUszzMBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched/rt: Don't try push tasks if there are none.
Message-ID: <20230810080708.L4nV_aKI@linutronix.de>
References: <20230801152648._y603AS_@linutronix.de>
 <xhsmhv8dob13r.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xhsmhv8dob13r.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-09 18:02:32 [+0100], Valentin Schneider wrote:
> On 01/08/23 17:26, Sebastian Andrzej Siewior wrote:
> > I have a RT task X at a high priority and cyclictest on each CPU with
> > lower priority than X's. If X is active and each CPU wakes their own
> > cylictest thread then it ends in a longer rto_push storm.
> > A random CPU determines via balance_rt() that the CPU on which X is
> > running needs to push tasks. X has the highest priority, cyclictest is
> > next in line so there is nothing that can be done since the task with
> > the higher priority is not touched.
> >
> > tell_cpu_to_push() increments rto_loop_next and schedules
> > rto_push_irq_work_func() on X's CPU. The other CPUs also increment the
> > loop counter and do the same. Once rto_push_irq_work_func() is active it
> > does nothing because it has _no_ pushable tasks on its runqueue. Then
> > checks rto_next_cpu() and decides to queue irq_work on the local CPU
> > because another CPU requested a push by incrementing the counter.
> >
> 
> For a CPU to be in the rto_mask, it needs:
> 
>   rt_rq->rt_nr_migratory && rt_rq->rt_nr_total > 1
> 
> But if that CPU has no pushable tasks, then that means only the current
> task has p->nr_cpus_allowed > 1.
> 
> Should we change it so a CPU is only in the rto_mask iff it has pushable
> tasks? AFAICT that should not break the case where we push the current task
> away due to migration_disabled, as that still relies on the
> migration_disabled task to be in the pushable list.

Sounds good. The task with the highest priority becomes pushable if it
gets preempted (by a task with higher priority). This gets considered,
right?

Sebastian
