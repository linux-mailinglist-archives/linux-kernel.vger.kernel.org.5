Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F3476E42B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbjHCJTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbjHCJSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:18:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6BE2684;
        Thu,  3 Aug 2023 02:18:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE9BE61CFB;
        Thu,  3 Aug 2023 09:18:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84B6C433C7;
        Thu,  3 Aug 2023 09:18:28 +0000 (UTC)
Date:   Thu, 3 Aug 2023 05:18:26 -0400
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
Subject: Re: [RFC PATCH v6 3/5] sched, tracing: reorganize fields of switch
 event struct
Message-ID: <20230803051826.25ba7973@gandalf.local.home>
In-Reply-To: <20230803083352.1585-4-zegao@tencent.com>
References: <20230803083352.1585-1-zegao@tencent.com>
        <20230803083352.1585-4-zegao@tencent.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  3 Aug 2023 04:33:50 -0400
Ze Gao <zegao2021@gmail.com> wrote:

> Report prioritiy and prev_state in 'short' to save some buffer
> space. And also reorder the fields so that we take struct
> alignment into consideration to make the record compact.

If I were to write this, I would have wrote:

  The prev_state field in the sched_switch event is assigned by
  __trace_sched_switch_state(). The largest number that function will return
  is TASK_REPORT_MAX which is just 0x100. There's no reason that the
  prev_state field is a full 32 bits when it is using just 9 bits max. In
  order to save space on the ring buffer, shrink the prev_state to 16 bits
  (short).

  Also, change the positions of the other fields to accommodate the short
  value of prev_state to eliminate any holes that were created in the
  structure.

See the difference?

>  
>  #ifdef CREATE_TRACE_POINTS
> -static inline long __trace_sched_switch_state(bool preempt,
> +static inline short __trace_sched_switch_state(bool preempt,
>  					      unsigned int prev_state,
>  					      struct task_struct *p)
>  {
>  	unsigned int state;
>  
>  #ifdef CONFIG_SCHED_DEBUG
> -	BUG_ON(p != current);
> +	WARN_ON_ONCE(p != current);
>  #endif /* CONFIG_SCHED_DEBUG */

The above needs to be a separate patch.

-- Steve

>  
>  	/*
> @@ -229,23 +229,23 @@ TRACE_EVENT(sched_switch,
>  	TP_ARGS(preempt, prev, next, prev_state),
>  
>  	TP_STRUCT__entry(
> -		__array(	char,	prev_comm,	TASK_COMM_LEN	)
>  		__field(	pid_t,	prev_pid			)
> -		__field(	int,	prev_prio			)
> -		__field(	long,	prev_state			)
> -		__array(	char,	next_comm,	TASK_COMM_LEN	)
>  		__field(	pid_t,	next_pid			)
> -		__field(	int,	next_prio			)
> +		__field(	short,	prev_prio			)
> +		__field(	short,	next_prio			)
> +		__array(	char,	prev_comm,	TASK_COMM_LEN	)
> +		__array(	char,	next_comm,	TASK_COMM_LEN	)
> +		__field(	short,	prev_state			)
>  	),
>  
>  	TP_fast_assign(
> -		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
> -		__entry->prev_pid	= prev->pid;
> -		__entry->prev_prio	= prev->prio;
> -		__entry->prev_state	= __trace_sched_switch_state(preempt, prev_state, prev);
> +		__entry->prev_pid		= prev->pid;
> +		__entry->next_pid		= next->pid;
> +		__entry->prev_prio		= (short) prev->prio;
> +		__entry->next_prio		= (short) next->prio;
>  		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
> -		__entry->next_pid	= next->pid;
> -		__entry->next_prio	= next->prio;
> +		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
> +		__entry->prev_state		= __trace_sched_switch_state(preempt, prev_state, prev);
>  		/* XXX SCHED_DEADLINE */
>  	),
>  

