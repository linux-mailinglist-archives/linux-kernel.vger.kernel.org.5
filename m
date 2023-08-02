Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7998B76D10B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbjHBPHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbjHBPHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:07:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279F935A4;
        Wed,  2 Aug 2023 08:07:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9B38619C9;
        Wed,  2 Aug 2023 15:07:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5232AC433C7;
        Wed,  2 Aug 2023 15:07:03 +0000 (UTC)
Date:   Wed, 2 Aug 2023 11:07:01 -0400
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
        linux-trace-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Subject: Re: [RFC PATCH v4 5/7] sched, tracing: add to report task state in
 symbolic chars
Message-ID: <20230802110701.5227346d@gandalf.local.home>
In-Reply-To: <20230802121116.324604-6-zegao@tencent.com>
References: <20230802121116.324604-1-zegao@tencent.com>
        <20230802121116.324604-6-zegao@tencent.com>
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

On Wed,  2 Aug 2023 08:10:00 -0400
Ze Gao <zegao2021@gmail.com> wrote:

> From: Ze Gao <zegao2021@gmail.com>
> 
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
> 
> Signed-off-by: Ze Gao <zegao@tencent.com>
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Acked-by: Ian Rogers <irogers@google.com>
> ---
>  include/trace/events/sched.h | 44 ++++++++++++++++++++++--------------
>  1 file changed, 27 insertions(+), 17 deletions(-)
> 
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index 7d34db20b2c6..1c7b94793495 100644
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
> @@ -214,6 +215,27 @@ static inline int __trace_sched_switch_state(bool preempt,
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
> +	BUG_ON(p != current);

BUG? Why not WARN_ON()?

-- Steve

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
>  		__field(	int,	prev_state			)
>  		__array(	char,	prev_comm,	TASK_COMM_LEN	)
>  		__array(	char,	next_comm,	TASK_COMM_LEN	)
> +		__field(	char,	prev_state_char			)
>  	),
>  
>  	TP_fast_assign(
> @@ -246,26 +269,13 @@ TRACE_EVENT(sched_switch,
>  		__entry->prev_state		= __trace_sched_switch_state(preempt, prev_state, prev);
>  		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
>  		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
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
> -
> -		__entry->prev_state & TASK_REPORT_MAX ? "+" : "",
> -		__entry->next_comm, __entry->next_pid, __entry->next_prio)
> +	TP_printk("prev_comm=%s prev_pid=%d prev_prio=%d prev_state=%c ==> next_comm=%s next_pid=%d next_prio=%d",
> +		__entry->prev_comm, __entry->prev_pid, __entry->prev_prio, __entry->prev_state_char, __entry->next_comm,
> +		__entry->next_pid, __entry->next_prio)
>  );
>  
>  /*

