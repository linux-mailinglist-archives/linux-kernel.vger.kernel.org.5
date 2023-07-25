Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD40760D0E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbjGYIej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjGYIeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:34:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5793DA9;
        Tue, 25 Jul 2023 01:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RgsZVExLjelcR9ibhfRjGswW/e5CUDzPHTBrRqoBktM=; b=T6OmFuB4rZZfXzAIl2KR55THUP
        Y1423xj9m+tcZI4sTWu8eWW9VXgtNIuDWBLp2iCgUeANXAFtXsj/ceIkvJwYBMVIFZvLrwjvqXwCI
        B4uZ5lrSzOMYhH5ZNf6Ok6G+VFsxSrq+GYiHO5dk1h+sNIAhdfb7ybHY1MZBx6Kqk+PezHGSHgPIr
        xKpd293A7jyVpOAuTxJ3ygq66Exf2YEVH0ubWHFKrmaeoEJH2hrO6e23ph5/ZnI743McDs/4qjWwL
        l0i/FaVe/AZtSwq9Kpe8a9oBP327gt/8KaqsF0nGmoPAZz/piHxjNNescVDb7VsOMDnWm3eNwP8sE
        JhF2HekQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qODUW-005HyA-OO; Tue, 25 Jul 2023 08:34:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EA90D3001FD;
        Tue, 25 Jul 2023 10:33:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CEC992B59FE01; Tue, 25 Jul 2023 10:33:57 +0200 (CEST)
Date:   Tue, 25 Jul 2023 10:33:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ze Gao <zegao2021@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <20230725083357.GA3765278@hirez.programming.kicks-ass.net>
References: <20230725072254.32045-1-zegao@tencent.com>
 <20230725072254.32045-2-zegao@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725072254.32045-2-zegao@tencent.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 03:22:52PM +0800, Ze Gao wrote:

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

I don't get this move, why compute state before this return?

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

This is a format change and will likely break a ton of programs :/

