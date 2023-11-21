Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CB77F340F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjKUQmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjKUQmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:42:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB9CE7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:41:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3CDC433C8;
        Tue, 21 Nov 2023 16:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700584916;
        bh=GA5cVgxVxFnsICwvLexb6iEuW/gfAj83suuz969sIis=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IoHNeeUSDJO1JlkHUfNVI4gvYxREiQjrTPMCpEOjyHuAF9b3xCiEVgxpmx5hSQzjs
         DKWF8JCjAEqAEYMYhYKj4bks9WRYWXzi53pKDF8kVDWQgS9SfovbAsrWWwIHk/xWNn
         h2GETJFxru8kBvRGRo/a2pAtEToSx7NjmuBMAChMQWTXpw8FE3yilI80YBWel6GXJr
         nGg3MZrP2GLAe9veDlXLNj1UUfSCPvlJ1vjB7kIQpIRYy0ot+srfS1J5mwbE5EpS/g
         hYfCGJSYJUij6I/vcbIoi6pS0FBjn5y16vaSjLmjXLIzPlsbZzFssbn+hg3GUhNaTp
         5icqFEcMLJqhQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 164D8CE04C0; Tue, 21 Nov 2023 08:41:56 -0800 (PST)
Date:   Tue, 21 Nov 2023 08:41:56 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org,
        Michael Jeanson <mjeanson@efficios.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v4 1/5] tracing: Introduce faultable tracepoints
Message-ID: <e3721b80-4dfb-4914-acfb-b315b8cc45b8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231120214742.GC8262@noisy.programming.kicks-ass.net>
 <62c6e37c-88cc-43f7-ac3f-1c14059277cc@paulmck-laptop>
 <20231120222311.GE8262@noisy.programming.kicks-ass.net>
 <cfc4b94e-8076-4e44-a8a7-2fd42dd9f2f2@paulmck-laptop>
 <20231121084706.GF8262@noisy.programming.kicks-ass.net>
 <a0ac5f77-411e-4562-9863-81196238f3f5@efficios.com>
 <20231121143647.GI8262@noisy.programming.kicks-ass.net>
 <6f503545-9c42-4d10-aca4-5332fd1097f3@efficios.com>
 <20231121144643.GJ8262@noisy.programming.kicks-ass.net>
 <20231121155256.GN4779@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121155256.GN4779@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 04:52:56PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 21, 2023 at 03:46:43PM +0100, Peter Zijlstra wrote:
> 
> > Why is this such a hard question?

The place to look is here:

https://docs.kernel.org/RCU/Design/Requirements/Requirements.html

Or, if you prefer, Documentation/RCU/Design/Requirements/Requirements.rst.

> Anyway, recapping from IRC:
> 
> preemptible, SRCU:
>   counter-array based, GP advances by increasing array index
>   and waiting for previous index to drop to 0.
> 
>   notably, a GP can pass while a task is preempted but not within a
>   critical section.
> 
>   SRCU has smp_mb() in the critical sections to improve GP.

https://docs.kernel.org/RCU/Design/Requirements/Requirements.html#sleepable-rcu

Allows general blocking in SRCU readers, which it tolerates by giving
each user its own SRCU via DEFINE_SRCU(), DEFINE_STATIC_SRCU() or
a srcu_struct structure.  Users blocking too much in SRCU read-side
critical sections hurt only themselves.  Yes, heavy-weight readers.

> tasks:
>   waits for every task to pass schedule()
> 
>   ensures that any pieces of text rendered unreachable before, is
>   actually unused after.

But does not wait for tasks where RCU is not watching, including the
idle loop.

> tasks-rude:
>   like tasks, but different? build to handle tracing while rcu-idle,
>   even though that was already deemed bad?

This waits for the tasks that RCU Tasks cannot wait for.  If noinstr
is fully fixed, RCU Tasks Rude can go away.

> tasks-tracing-rcu:
>   extention of tasks to have critical-sections ? Should this simply be
>   tasks?

Tasks Trace RCU is its own thing.  It uses rcu_read_lock_trace() and
rcu_read_unlock_trace() to mark its readers.  It can detect quiescent
states even when the task in question does not call schedule().
Unlike Tasks RCU, Tasks Trace RCU does not scan the full task list.
(It used to, but that caused latency blows on non-realtime workloads.)
Tasks Trace RCU allows preemption and blocking for page faults in
its readers.  Also blocking on non-raw spinlocks in PREEMPT_RT, but I
am not sure that anyone cares.  If you want to block on anything else,
you need to talk to the current Tasks Trace RCU users.

							Thanx, Paul

> Can someone complete, please?
> 
> 
> 
