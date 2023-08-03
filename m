Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACADD76E456
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbjHCJ3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjHCJ3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:29:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15BDEE;
        Thu,  3 Aug 2023 02:29:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4498561D10;
        Thu,  3 Aug 2023 09:29:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1BBC433C8;
        Thu,  3 Aug 2023 09:29:31 +0000 (UTC)
Date:   Thu, 3 Aug 2023 05:29:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ze Gao <zegao2021@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Subject: Re: [RFC PATCH v6 4/5] sched, tracing: add to report task state in
 symbolic chars
Message-ID: <20230803052930.33337082@gandalf.local.home>
In-Reply-To: <20230803083352.1585-5-zegao@tencent.com>
References: <20230803083352.1585-1-zegao@tencent.com>
        <20230803083352.1585-5-zegao@tencent.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  3 Aug 2023 04:33:51 -0400
Ze Gao <zegao2021@gmail.com> wrote:

> Internal representations of task state are likely to be changed
> or ordered, and reporting them to userspace without exporting
> them as part of API is basically wrong, which can easily break
> a userspace observability tool as kernel evolves. For example,
> perf suffers from this and still reports wrong states as of this
> writing.
> 
> OTOH, some masqueraded states like TASK_REPORT_IDLE and
> TASK_REPORT_MAX are also reported inadvertently, which confuses
> things even more and most userspace tools do not even take them
> into consideration.
> 
> So add a new variable in company with the old raw value to
> report task state in symbolic chars, which are self-explaining
> and no further translation is needed. Of course this does not
> break any userspace tool.
> 
> Note for PREEMPT_ACTIVE, we introduce 'p' to report it and use
> the old conventions for the rest.

The above is actually good.


> 
> Signed-off-by: Ze Gao <zegao@tencent.com>
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Acked-by: Ian Rogers <irogers@google.com>
> ---
>  include/trace/events/sched.h | 44 ++++++++++++++++++++++--------------
>  1 file changed, 27 insertions(+), 17 deletions(-)
> 
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index 43492daefa6f..ae5b486cc969 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -6,6 +6,7 @@
>  #define _TRACE_SCHED_H
>  
>  #include <linux/kthread.h>
> +#include <linux/sched.h>
>  #include <linux/sched/numa_balancing.h>
>  #include <linux/tracepoint.h>
>  #include <linux/binfmts.h>
> @@ -214,6 +215,27 @@ static inline short __trace_sched_switch_state(bool preempt,
>  
>  	return state ? (1 << (state - 1)) : state;
>  }
> +
> +static inline char __trace_sched_switch_state_char(bool preempt,
> +						   unsigned int prev_state,
> +						   struct task_struct *p)
> +{
> +	long state;
> +
> +#ifdef CONFIG_SCHED_DEBUG
> +	WARN_ON_ONCE(p != current);
> +#endif /* CONFIG_SCHED_DEBUG */
> +
> +	/*
> +	 * For PREEMPT_ACTIVE, we introduce 'p' to report it and use the old
> +	 * conventions for the rest.
> +	 */
> +	if (preempt)
> +		return 'p';
> +
> +	state = __task_state_index(prev_state, p->exit_state);
> +	return task_index_to_char(state);
> +}
>  #endif /* CREATE_TRACE_POINTS */
>  
>  /*
> @@ -236,6 +258,7 @@ TRACE_EVENT(sched_switch,
>  		__array(	char,	prev_comm,	TASK_COMM_LEN	)
>  		__array(	char,	next_comm,	TASK_COMM_LEN	)
>  		__field(	short,	prev_state			)
> +		__field(	char,	prev_state_char			)
>  	),
>  
>  	TP_fast_assign(
> @@ -246,26 +269,13 @@ TRACE_EVENT(sched_switch,
>  		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
>  		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
>  		__entry->prev_state		= __trace_sched_switch_state(preempt, prev_state, prev);
> +		__entry->prev_state_char	= __trace_sched_switch_state_char(preempt, prev_state, prev);
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

I just realized, I have user space code that looks at this. As in the format file we have:

print fmt: "prev_comm=%s prev_pid=%d prev_prio=%d prev_state=%s%s ==> next_comm=%s next_pid=%d next_prio=%d", REC->prev_comm, REC->prev_pid, REC->prev_prio, (REC->prev_state & ((((0x00000000 | 0x00000001 | 0x00000002 | 0x00000004 | 0x00000008 | 0x00000010 | 0x00000020 | 0x00000040) + 1) << 1) - 1)) ? __print_flags(REC->prev_state & ((((0x00000000 | 0x00000001 | 0x00000002 | 0x00000004 | 0x00000008 | 0x00000010 | 0x00000020 | 0x00000040) + 1) << 1) - 1), "|", { 0x00000001, "S" }, { 0x00000002, "D" }, { 0x00000004, "T" }, { 0x00000008, "t" }, { 0x00000010, "X" }, { 0x00000020, "Z" }, { 0x00000040, "P" }, { 0x00000080, "I" }) : "R", REC->prev_state & (((0x00000000 | 0x00000001 | 0x00000002 | 0x00000004 | 0x00000008 | 0x00000010 | 0x00000020 | 0x00000040) + 1) << 1) ? "+" : "", REC->next_comm, REC->next_pid, REC->next_prio

And I have used this in applications to find out what values "S" and "D"
are.

So, we need to keep that still. But we can add the prev_state_char to the
output too.

  "prev_comm=%s prev_pid=%d prev_prio=%d prev_state=%s%s[%c] ==> next_comm=%s next_pid=%d next_prio=%d"

> -
> -		__entry->prev_state & TASK_REPORT_MAX ? "+" : "",
> -		__entry->next_comm, __entry->next_pid, __entry->next_prio)
> +	TP_printk("prev_comm=%s prev_pid=%d prev_prio=%d prev_state=%c ==> next_comm=%s next_pid=%d next_prio=%d",
> +		__entry->prev_comm, __entry->prev_pid, __entry->prev_prio, __entry->prev_state_char, __entry->next_comm,
> +		__entry->next_pid, __entry->next_prio)
>  );
>  
>  /*


-- Steve
