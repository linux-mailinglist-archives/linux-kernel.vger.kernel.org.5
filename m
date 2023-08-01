Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EC976B616
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbjHANmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjHANmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:42:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E76110DB;
        Tue,  1 Aug 2023 06:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kHEuKxJGDY+7U7sNajb0X1Ns5oYmL8eJ2Q/fI659OrA=; b=ZfzWa2Uwxfx+eILLpeM4bZQsyW
        VIHueX5vDEdDRI82cfXR4kQANxgvUU+glgIgqAKKQIrG9bU1HRUdqrb/ektsFIgbG3bvkrj1mZ78W
        Yf4k12V2I+l7HtScf9cbmt+3Lvu9PXMKHZkQSk3eXWQ3GnGTpf6JbbGRdOANcQ5iX+rnEDO9U32Z6
        bbAFtKqNoBfgUd63qSEeQBofnohDAxTBzpWkJ0jarhkLP2AYDpEphQqwExP3pH95RgfJJIpv/HqJu
        uRFH98SVcUHTyuCW7hjAusHnFF2ZBmBb2nK8/kcfMNlHt5tg+EqjSFr0x6J2PEJ5aO4vL0w2LdP8i
        rYx0aHdg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQpdA-00Eh3Q-0t;
        Tue, 01 Aug 2023 13:41:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BF5D33001DD;
        Tue,  1 Aug 2023 15:41:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9EE892066B201; Tue,  1 Aug 2023 15:41:42 +0200 (CEST)
Date:   Tue, 1 Aug 2023 15:41:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ze Gao <zegao2021@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Subject: Re: [RFC PATCH v3 3/6] sched, tracing: add to report task state in
 symbolic chars
Message-ID: <20230801134142.GC11704@hirez.programming.kicks-ass.net>
References: <20230801090124.8050-1-zegao@tencent.com>
 <20230801090124.8050-4-zegao@tencent.com>
 <20230801113401.GC79828@hirez.programming.kicks-ass.net>
 <CAD8CoPA-cqe+hY8dHjO+6WhcL2VKy2Wq=rYSSkwUqBFRJ4ECWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD8CoPA-cqe+hY8dHjO+6WhcL2VKy2Wq=rYSSkwUqBFRJ4ECWg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 09:03:51PM +0800, Ze Gao wrote:

> It's just the design that exporting internal details is fundamentally wrong.

This is tracing... it wasn't supposed to be ABI (although it somehow
ended up being one). But even then, things like PF_foo get exposed in
procfs but even that we change.

The whole point of tracing is to see internals in order to figure out
wth is going wrong.

> And even worse,  I did not see any userspace tool is aware of masqueraded
> states like TASK_REPORT_IDLE and TASK_REPORT_MAX and let alone
> parse it correctly.

That's probably because I never use tools, I just look at the raw trace
output -- sometimes an impromptu awk script. I'm pretty sure I ran with
something like the below when I did the freezer rewrite -- or perhaps I
just stuck in trace_printk() and didn't even bother with the
tracepoints, I can't remember.

> > Why do we need this character anyway, why not just print the state in
> > hex and leave it at that? These single character state things are a
> > relic, please just let them die.
> 
> I believe hex is ok only after having the reported task state mapping
> appear in the uapi headers, otherwise it's still useless to userspace
> especially for value like TASK_REPORT_IDLE and TASK_REPORT_MAX, which
> need to dig into the kernel to see what the hell is going on here.
> 
> Thoughts?

If you're tracing the kernel, you had better know what the kernel is
doing, otherwise you get to keep the pieces.

Anyway, if you're doing BPF then why do you care about the trace event
at all, just attach to the raw tracepoint and consume @preemt, @prev,
@next and @prev_state.

---
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index fbb99a61f714..cb0c1251729e 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -186,36 +186,6 @@ DEFINE_EVENT(sched_wakeup_template, sched_wakeup_new,
 	     TP_PROTO(struct task_struct *p),
 	     TP_ARGS(p));
 
-#ifdef CREATE_TRACE_POINTS
-static inline long __trace_sched_switch_state(bool preempt,
-					      unsigned int prev_state,
-					      struct task_struct *p)
-{
-	unsigned int state;
-
-#ifdef CONFIG_SCHED_DEBUG
-	BUG_ON(p != current);
-#endif /* CONFIG_SCHED_DEBUG */
-
-	/*
-	 * Preemption ignores task state, therefore preempted tasks are always
-	 * RUNNING (we will not have dequeued if state != RUNNING).
-	 */
-	if (preempt)
-		return TASK_REPORT_MAX;
-
-	/*
-	 * task_state_index() uses fls() and returns a value from 0-8 range.
-	 * Decrement it by 1 (except TASK_RUNNING state i.e 0) before using
-	 * it for left shift operation to get the correct task->state
-	 * mapping.
-	 */
-	state = __task_state_index(prev_state, p->exit_state);
-
-	return state ? (1 << (state - 1)) : state;
-}
-#endif /* CREATE_TRACE_POINTS */
-
 /*
  * Tracepoint for task switches, performed by the scheduler:
  */
@@ -242,29 +212,16 @@ TRACE_EVENT(sched_switch,
 		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
 		__entry->prev_pid	= prev->pid;
 		__entry->prev_prio	= prev->prio;
-		__entry->prev_state	= __trace_sched_switch_state(preempt, prev_state, prev);
+		__entry->prev_state	= prev_state | (preempt * TASK_STATE_MAX);
 		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
 		__entry->next_pid	= next->pid;
 		__entry->next_prio	= next->prio;
 		/* XXX SCHED_DEADLINE */
 	),
 
-	TP_printk("prev_comm=%s prev_pid=%d prev_prio=%d prev_state=%s%s ==> next_comm=%s next_pid=%d next_prio=%d",
+	TP_printk("prev_comm=%s prev_pid=%d prev_prio=%d prev_state=%x ==> next_comm=%s next_pid=%d next_prio=%d",
 		__entry->prev_comm, __entry->prev_pid, __entry->prev_prio,
-
-		(__entry->prev_state & (TASK_REPORT_MAX - 1)) ?
-		  __print_flags(__entry->prev_state & (TASK_REPORT_MAX - 1), "|",
-				{ TASK_INTERRUPTIBLE, "S" },
-				{ TASK_UNINTERRUPTIBLE, "D" },
-				{ __TASK_STOPPED, "T" },
-				{ __TASK_TRACED, "t" },
-				{ EXIT_DEAD, "X" },
-				{ EXIT_ZOMBIE, "Z" },
-				{ TASK_PARKED, "P" },
-				{ TASK_DEAD, "I" }) :
-		  "R",
-
-		__entry->prev_state & TASK_REPORT_MAX ? "+" : "",
+		__entry->prev_state,
 		__entry->next_comm, __entry->next_pid, __entry->next_prio)
 );
 
