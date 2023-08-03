Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F4F76E475
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbjHCJep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjHCJem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:34:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D533588;
        Thu,  3 Aug 2023 02:34:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69DBD61D14;
        Thu,  3 Aug 2023 09:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D1AC433CA;
        Thu,  3 Aug 2023 09:34:07 +0000 (UTC)
Date:   Thu, 3 Aug 2023 05:34:05 -0400
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
Subject: Re: [RFC PATCH v6 5/5] perf sched: prefer to use prev_state_char
 introduced in sched_switch
Message-ID: <20230803053405.4d91015d@gandalf.local.home>
In-Reply-To: <20230803083352.1585-6-zegao@tencent.com>
References: <20230803083352.1585-1-zegao@tencent.com>
        <20230803083352.1585-6-zegao@tencent.com>
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

On Thu,  3 Aug 2023 04:33:52 -0400
Ze Gao <zegao2021@gmail.com> wrote:

> Since the sched_switch tracepoint introduces a new variable to
> report sched-out task state in symbolic char, we prefer to use
> it to spare from knowing internal implementations in kernel.

The above needs to be rewritten to be more comprehensive.

Feel free to reply to this thread with new versions of the change log and
such. No need to send a new patch series to fix this before you know that
the new version is acceptable or not.

Replying to a current patch series is fine, but sending out a new one
causes the spam as it's much easier to ignore a thread than to ignore a new
thread with a new series.

Thanks,

-- Steve


> 
> Also we keep the old parsing logic intact but sync the state char
> array with the latest kernel.
> 
> Signed-off-by: Ze Gao <zegao@tencent.com>
> ---
>  tools/perf/builtin-sched.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 5042874ba204..6f99a36206c9 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -837,7 +837,7 @@ replay_wakeup_event(struct perf_sched *sched,
>  
>  static inline char task_state_char(int state)
>  {
> -	static const char state_to_char[] = "RSDTtXZPI";
> +	static const char state_to_char[] = "RSDTtXZPIp";
>  	unsigned int bit = state ? ffs(state) : 0;
>  
>  	return bit < sizeof(state_to_char) - 1 ? state_to_char[bit] : '?';
> @@ -846,9 +846,20 @@ static inline char task_state_char(int state)
>  static inline char get_task_prev_state(struct evsel *evsel,
>  				       struct perf_sample *sample)
>  {
> -	const int prev_state = evsel__intval(evsel, sample, "prev_state");
> +	char prev_state_char;
> +	int prev_state;
>  
> -	return task_state_char(prev_state);
> +	/* prefer to use prev_state_char */
> +	if (evsel__field(evsel, "prev_state_char"))
> +		prev_state_char = (char) evsel__intval(evsel,
> +				sample, "prev_state_char");
> +	else {
> +		prev_state = (int) evsel__intval(evsel,
> +				sample, "prev_state");
> +		prev_state_char = task_state_char(prev_state);
> +	}
> +
> +	return prev_state_char;
>  }
>  
>  static int replay_switch_event(struct perf_sched *sched,
> @@ -2145,7 +2156,7 @@ static void timehist_update_runtime_stats(struct thread_runtime *r,
>  		else if (r->last_time) {
>  			u64 dt_wait = tprev - r->last_time;
>  
> -			if (r->last_state == 'R')
> +			if (r->last_state == 'R' || r->last_state == 'p')
>  				r->dt_preempt = dt_wait;
>  			else if (r->last_state == 'D')
>  				r->dt_iowait = dt_wait;

