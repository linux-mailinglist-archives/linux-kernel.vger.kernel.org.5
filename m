Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A84E76D103
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbjHBPG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbjHBPGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:06:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402A630FF;
        Wed,  2 Aug 2023 08:05:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1454619C8;
        Wed,  2 Aug 2023 15:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FCABC433C8;
        Wed,  2 Aug 2023 15:05:54 +0000 (UTC)
Date:   Wed, 2 Aug 2023 11:05:52 -0400
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
Subject: Re: [RFC PATCH v4 4/7] sched, tracing: reorganize fields of switch
 event struct
Message-ID: <20230802110552.768f0487@gandalf.local.home>
In-Reply-To: <20230802121116.324604-5-zegao@tencent.com>
References: <20230802121116.324604-1-zegao@tencent.com>
        <20230802121116.324604-5-zegao@tencent.com>
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

On Wed,  2 Aug 2023 08:09:59 -0400
Ze Gao <zegao2021@gmail.com> wrote:

> From: Ze Gao <zegao2021@gmail.com>
> 
> Report priorities in 'short' and prev_state in 'int' to save
> some buffer space. And also reorder the fields so that we take
> struct alignment into consideration to make the record compact.
> 
> Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Ze Gao <zegao@tencent.com>
> ---
>  include/trace/events/sched.h | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index fbb99a61f714..7d34db20b2c6 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -187,7 +187,7 @@ DEFINE_EVENT(sched_wakeup_template, sched_wakeup_new,
>  	     TP_ARGS(p));
>  
>  #ifdef CREATE_TRACE_POINTS
> -static inline long __trace_sched_switch_state(bool preempt,
> +static inline int __trace_sched_switch_state(bool preempt,
>  					      unsigned int prev_state,
>  					      struct task_struct *p)
>  {
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
> +		__field(	int,	prev_state			)

I was talking with Peter on IRC and since the biggest number that
prev_state can be is TASK_REPORT_MASK which is 0x100, I think we can make
prev_state into a short as well.

-- Steve


> +		__array(	char,	prev_comm,	TASK_COMM_LEN	)
> +		__array(	char,	next_comm,	TASK_COMM_LEN	)
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
> +		__entry->prev_state		= __trace_sched_switch_state(preempt, prev_state, prev);
>  		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
> -		__entry->next_pid	= next->pid;
> -		__entry->next_prio	= next->prio;
> +		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
>  		/* XXX SCHED_DEADLINE */
>  	),
>  

