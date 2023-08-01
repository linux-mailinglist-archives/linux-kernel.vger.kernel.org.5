Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83FF76B705
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbjHAOQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjHAOQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:16:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA295B1;
        Tue,  1 Aug 2023 07:16:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4821C615CB;
        Tue,  1 Aug 2023 14:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1A9C433C8;
        Tue,  1 Aug 2023 14:16:13 +0000 (UTC)
Date:   Tue, 1 Aug 2023 10:16:12 -0400
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
Subject: Re: [RFC PATCH v3 4/6] sched, tracing: reorganize fields of switch
 event struct
Message-ID: <20230801101612.0e083e2d@gandalf.local.home>
In-Reply-To: <20230801090124.8050-5-zegao@tencent.com>
References: <20230801090124.8050-1-zegao@tencent.com>
        <20230801090124.8050-5-zegao@tencent.com>
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

On Tue,  1 Aug 2023 17:01:22 +0800
Ze Gao <zegao2021@gmail.com> wrote:

> Report priorities in 'short' and prev_state in 'int' to save
> some buffer space. And also reorder the fields so that we take
> struct alignment into consideration to make the record compact.
> 
> Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Ze Gao <zegao@tencent.com>

I'd swap this patch with patch 3. That is, make the field changes first.
I'd like this to get in regardless of if the state_char is accepted. We may
want to get this in first to see if there's any regressions before we add a
state_char.

-- Steve


> ---
>  include/trace/events/sched.h | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index e507901bcab8..36863ffb00c6 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -188,7 +188,7 @@ DEFINE_EVENT(sched_wakeup_template, sched_wakeup_new,
>  	     TP_ARGS(p));
>  
>  #ifdef CREATE_TRACE_POINTS
> -static inline long __trace_sched_switch_state(bool preempt,
> +static inline int __trace_sched_switch_state(bool preempt,
>  					      unsigned int prev_state,
>  					      struct task_struct *p)
>  {
> @@ -251,25 +251,25 @@ TRACE_EVENT(sched_switch,
>  	TP_ARGS(preempt, prev, next, prev_state),
>  
>  	TP_STRUCT__entry(
> -		__array(	char,	prev_comm,	TASK_COMM_LEN	)
>  		__field(	pid_t,	prev_pid			)
> -		__field(	int,	prev_prio			)
> -		__field(	long,	prev_state			)
> -		__field(	char,	prev_state_char			)
> -		__array(	char,	next_comm,	TASK_COMM_LEN	)
>  		__field(	pid_t,	next_pid			)
> -		__field(	int,	next_prio			)
> +		__field(	short,	prev_prio			)
> +		__field(	short,	next_prio			)
> +		__field(	int,	prev_state			)
> +		__array(	char,	prev_comm,	TASK_COMM_LEN	)
> +		__array(	char,	next_comm,	TASK_COMM_LEN	)
> +		__field(	char,	prev_state_char			)
>  	),
>  
>  	TP_fast_assign(
> -		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
>  		__entry->prev_pid		= prev->pid;
> -		__entry->prev_prio		= prev->prio;
> +		__entry->next_pid		= next->pid;
> +		__entry->prev_prio		= (short) prev->prio;
> +		__entry->next_prio		= (short) next->prio;
>  		__entry->prev_state		= __trace_sched_switch_state(preempt, prev_state, prev);
>  		__entry->prev_state_char	= __trace_sched_switch_state_char(preempt, prev_state, prev);
>  		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
> -		__entry->next_pid		= next->pid;
> -		__entry->next_prio		= next->prio;
> +		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
>  		/* XXX SCHED_DEADLINE */
>  	),
>  

