Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591277B5D8E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 01:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237105AbjJBXJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 19:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjJBXJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 19:09:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C957B4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 16:09:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17546C433C7;
        Mon,  2 Oct 2023 23:09:19 +0000 (UTC)
Date:   Mon, 2 Oct 2023 19:10:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Jeanson <mjeanson@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [RFC PATCH v3 1/5] tracing: Introduce faultable tracepoints
 (v3)
Message-ID: <20231002191023.6175294d@gandalf.local.home>
In-Reply-To: <20231002202531.3160-2-mathieu.desnoyers@efficios.com>
References: <20231002202531.3160-1-mathieu.desnoyers@efficios.com>
        <20231002202531.3160-2-mathieu.desnoyers@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  2 Oct 2023 16:25:27 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> @@ -202,8 +198,12 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  		if (WARN_ON_ONCE(RCUIDLE_COND(rcuidle)))		\
>  			return;						\
>  									\
> -		/* keep srcu and sched-rcu usage consistent */		\
> -		preempt_disable_notrace();				\
> +		if (mayfault) {						\
> +			rcu_read_lock_trace();				\

I thought rcu_trace was for the case that a task can not voluntarily call
schedule. If this tracepoint tries to read user space memory that isn't
paged in, and faults, can't the faulting logic call schedule and break this
requirement?

-- Steve


> +		} else {						\
> +			/* keep srcu and sched-rcu usage consistent */	\
> +			preempt_disable_notrace();			\
> +		}							\
>  									\
>  		/*							\
>  		 * For rcuidle callers, use srcu since sched-rcu	\
