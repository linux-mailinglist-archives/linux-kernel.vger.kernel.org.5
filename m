Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F06C7DD11F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344886AbjJaQCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344803AbjJaQCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:02:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF37F4;
        Tue, 31 Oct 2023 09:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AxFRKm6HPoBH+ZXu12vS/5bpNGLAyx3w22Bu1ude2cM=; b=vubEH9ftjuQuNiRkV31eAfjf0l
        X/7OHqN7Bw114j76oJUn1aJeLGkfxeFJ6HvMxt14meYZthI/pJtLEKt/MqaUYsD/rCw4hrtDfKEy/
        MpmtouENeJQCjIzT3HpNc9XtUy26QJV0aSbfsdajmhwEymTlRm1uXEq2wWsKZPK7hd9yJj679h+BY
        U5t1scmWDaJ0jFV/o7I1ozZMubGV4HWwYTVKTSEj5Pk3mp9CZH2gUmFPCSZSXzBCoHCKhEpgv2nDe
        +yvxkjP/jBBlhME3dlKfUexxMm9yztZPXwdW4NGdfr82pVIZyvPeTKKlLw2vqQnaXrAwnUWE4KK8T
        O2jFPoLg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qxrBA-00B05n-JP; Tue, 31 Oct 2023 16:01:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3F576300473; Tue, 31 Oct 2023 17:01:20 +0100 (CET)
Date:   Tue, 31 Oct 2023 17:01:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tomas Glozar <tglozar@redhat.com>
Subject: Re: [PATCH] sched/fair: Make the BW replenish timer expire in
 hardirq context for PREEMPT_RT
Message-ID: <20231031160120.GE15024@noisy.programming.kicks-ass.net>
References: <20231030145104.4107573-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030145104.4107573-1-vschneid@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 03:51:04PM +0100, Valentin Schneider wrote:
> Consider the following scenario under PREEMPT_RT:
> o A CFS task p0 gets throttled while holding read_lock(&lock)
> o A task p1 blocks on write_lock(&lock), making further readers enter the
>   slowpath
> o A ktimers or ksoftirqd task blocks on read_lock(&lock)
> 
> If the cfs_bandwidth.period_timer to replenish p0's runtime is enqueued on
> the same CPU as one where ktimers/ksoftirqd is blocked on read_lock(&lock),
> this creates a circular dependency.
> 
> This has been observed to happen with:
> o fs/eventpoll.c::ep->lock
> o net/netlink/af_netlink.c::nl_table_lock (after hand-fixing the above)
> but can trigger with any rwlock that can be acquired in both process and
> softirq contexts.
> 
> The linux-rt tree has had
>   1ea50f9636f0 ("softirq: Use a dedicated thread for timer wakeups.")
> which helped this scenario for non-rwlock locks by ensuring the throttled
> task would get PI'd to FIFO1 (ktimers' default priority). Unfortunately,
> rwlocks cannot sanely do PI as they allow multiple readers.
> 
> Make the period_timer expire in hardirq context under PREEMPT_RT. The
> callback for this timer can end up doing a lot of work, but this is
> mitigated somewhat when using nohz_full / CPU isolation: the timers *are*
> pinned, but on the CPUs the taskgroups are created on, which is usually
> going to be HK CPUs.

Moo... so I think 'people' have been pushing towards changing the
bandwidth thing to only throttle on the return-to-user path. This solves
the kernel side of the lock holder 'preemption' issue.

I'm thinking working on that is saner than adding this O(n) cgroup loop
to hard-irq context. Hmm?
