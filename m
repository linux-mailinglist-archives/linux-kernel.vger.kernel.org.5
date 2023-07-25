Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255457620C5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 19:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjGYR7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 13:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjGYR7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 13:59:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44A9BB;
        Tue, 25 Jul 2023 10:59:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5976661851;
        Tue, 25 Jul 2023 17:59:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66C2C433C7;
        Tue, 25 Jul 2023 17:59:40 +0000 (UTC)
Date:   Tue, 25 Jul 2023 13:59:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ze Gao <zegao2021@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Subject: Re: [RFC PATCH 1/3] sched, tracing: report task state in symbolic
 chars instead
Message-ID: <20230725135938.1e056a02@rorschach.local.home>
In-Reply-To: <20230725072254.32045-2-zegao@tencent.com>
References: <20230725072254.32045-1-zegao@tencent.com>
        <20230725072254.32045-2-zegao@tencent.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 15:22:52 +0800
Ze Gao <zegao2021@gmail.com> wrote:

>  #ifdef CREATE_TRACE_POINTS
> -static inline long __trace_sched_switch_state(bool preempt,
> +static inline const char __trace_sched_switch_state(bool preempt,

Does it really need to be "const"?

>  					      unsigned int prev_state,
>  					      struct task_struct *p)
>  {
> @@ -197,13 +198,6 @@ static inline long __trace_sched_switch_state(bool preempt,
>  	BUG_ON(p != current);
>  #endif /* CONFIG_SCHED_DEBUG */
>  
> -	/*
> -	 * Preemption ignores task state, therefore preempted tasks are always
> -	 * RUNNING (we will not have dequeued if state != RUNNING).
> -	 */
> -	if (preempt)
> -		return TASK_REPORT_MAX;
> -
>  	/*
>  	 * task_state_index() uses fls() and returns a value from 0-8 range.
>  	 * Decrement it by 1 (except TASK_RUNNING state i.e 0) before using
> @@ -212,7 +206,16 @@ static inline long __trace_sched_switch_state(bool preempt,
>  	 */
>  	state = __task_state_index(prev_state, p->exit_state);
>  
> -	return state ? (1 << (state - 1)) : state;
> +	/*
> +	 * Preemption ignores task state, therefore preempted tasks are always
> +	 * RUNNING (we will not have dequeued if state != RUNNING).
> +	 * Here, we use 'p' to denote this case and only for this case.
> +	 */
> +	if (preempt)
> +		return 'p';
> +
> +
> +	return task_index_to_char(state);
>  }
>  #endif /* CREATE_TRACE_POINTS */
>  
> @@ -232,7 +235,7 @@ TRACE_EVENT(sched_switch,
>  		__array(	char,	prev_comm,	TASK_COMM_LEN	)
>  		__field(	pid_t,	prev_pid			)
>  		__field(	int,	prev_prio			)
> -		__field(	long,	prev_state			)
> +		__field(	char,	prev_state			)
>  		__array(	char,	next_comm,	TASK_COMM_LEN	)
>  		__field(	pid_t,	next_pid			)
>  		__field(	int,	next_prio			)

This will break userspace. Just because you update libtraceevent
doesn't mean that it will get to all the users of it. There's still
tools that have the old method hard coded and doesn't use the library.

Now, because the old tools still do the parsing of this format, we can
add a new field called prev_state_char that will give you this. Now to
save space, we should change prev_state to int (can't make it short as
there's that test for "+" which does sometimes happen). I believe we
can make prev_prio and next prio into shorts (and possibly chars!).

-- Steve


> @@ -249,22 +252,8 @@ TRACE_EVENT(sched_switch,
>  		/* XXX SCHED_DEADLINE */
>  	),
>  
> -	TP_printk("prev_comm=%s prev_pid=%d prev_prio=%d prev_state=%s%s ==> next_comm=%s next_pid=%d next_prio=%d",
> -		__entry->prev_comm, __entry->prev_pid, __entry->prev_prio,
> -
> -		(__entry->prev_state & (TASK_REPORT_MAX - 1)) ?
> -		  __print_flags(__entry->prev_state & (TASK_REPORT_MAX - 1), "|",
> -				{ TASK_INTERRUPTIBLE, "S" },
> -				{ TASK_UNINTERRUPTIBLE, "D" },
> -				{ __TASK_STOPPED, "T" },
> -				{ __TASK_TRACED, "t" },
> -				{ EXIT_DEAD, "X" },
> -				{ EXIT_ZOMBIE, "Z" },
> -				{ TASK_PARKED, "P" },
> -				{ TASK_DEAD, "I" }) :
> -		  "R",
> -
> -		__entry->prev_state & TASK_REPORT_MAX ? "+" : "",
> +	TP_printk("prev_comm=%s prev_pid=%d prev_prio=%d prev_state=%c ==> next_comm=%s next_pid=%d next_prio=%d",
> +		__entry->prev_comm, __entry->prev_pid, __entry->prev_prio, __entry->prev_state,
>  		__entry->next_comm, __entry->next_pid, __entry->next_prio)
