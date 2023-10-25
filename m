Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FD47D707A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344265AbjJYPM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 11:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjJYPMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 11:12:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B5E129
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 08:12:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FF8C433C7;
        Wed, 25 Oct 2023 15:12:49 +0000 (UTC)
Date:   Wed, 25 Oct 2023 11:12:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Joel Fernandes <joel@joelfernandes.org>,
        Youssef Esmat <youssefesmat@chromium.org>,
        Vineeth Pillai <vineethrp@google.com>,
        Suleiman Souhlal <suleiman@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [POC][RFC][PATCH] sched: Extended Scheduler Time Slice
Message-ID: <20231025111247.64d7b653@gandalf.local.home>
In-Reply-To: <20231025054219.1acaa3dd@gandalf.local.home>
References: <20231025054219.1acaa3dd@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2023 05:42:19 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I ran a traceeval tool on it (still work in progress, but I can post when
> it's done), and with the following trace, and the writes to trace-marker
> (tracefs_printf)
> 
>  trace-cmd record -e sched_switch ./extend-sched
> 
> It showed that without the extend, each task was preempted while holding
> the lock around 200 times. With the extend, only one task was ever
> preempted while holding the lock, and it only happened once!

And looking at the trace, it was because it was preempted by an RT task.

    extend-sched-3349  [007]  3309.320747: print:                tracing_mark_write: Have lock!
    extend-sched-3349  [007]  3309.320751: sched_switch:         extend-sched:3349 [120] R ==> migration/7:68 [0]
     migration/7-68    [007]  3309.320754: sched_switch:         migration/7:68 [0] S ==> extend-sched:3349 [120]
    extend-sched-3349  [007]  3309.320756: print:                tracing_mark_write: released lock!

So we know that part of the code works. ;-)

-- Steve
