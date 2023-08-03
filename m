Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8BC76E3FB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbjHCJKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235000AbjHCJKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:10:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D23E46;
        Thu,  3 Aug 2023 02:10:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A09A61CFF;
        Thu,  3 Aug 2023 09:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189DBC433C9;
        Thu,  3 Aug 2023 09:10:13 +0000 (UTC)
Date:   Thu, 3 Aug 2023 05:10:11 -0400
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
Subject: Re: [RFC PATCH v6 2/5] perf sched: reorganize sched-out task state
 report code
Message-ID: <20230803051011.4833785f@gandalf.local.home>
In-Reply-To: <20230803083352.1585-3-zegao@tencent.com>
References: <20230803083352.1585-1-zegao@tencent.com>
        <20230803083352.1585-3-zegao@tencent.com>
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

On Thu,  3 Aug 2023 04:33:49 -0400
Ze Gao <zegao2021@gmail.com> wrote:

> Mainly does housekeeping work and not introduce any
> functional change.

This change log doesn't explain at all why this patch is needed, let alone
what it is even doing.

-- Steve


> 
> Signed-off-by: Ze Gao <zegao@tencent.com>
> ---
>  tools/perf/builtin-sched.c | 59 +++++++++++++++++---------------------
>  1 file changed, 26 insertions(+), 33 deletions(-)
> 
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 8dc8f071721c..5042874ba204 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -94,11 +94,6 @@ struct sched_atom {
>  
>  #define TASK_STATE_TO_CHAR_STR "RSDTtXZPI"
>  
> -/* task state bitmask, copied from include/linux/sched.h */
> -#define TASK_RUNNING		0
> -#define TASK_INTERRUPTIBLE	1
> -#define TASK_UNINTERRUPTIBLE	2
> -
>  enum thread_state {
>  	THREAD_SLEEPING = 0,
>  	THREAD_WAIT_CPU,
> @@ -255,7 +250,7 @@ struct thread_runtime {
>  	u64 total_preempt_time;
>  	u64 total_delay_time;
>  
> -	int last_state;
> +	char last_state;
>  
>  	char shortname[3];
>  	bool comm_changed;
> @@ -425,7 +420,7 @@ static void add_sched_event_wakeup(struct perf_sched *sched, struct task_desc *t
>  }
>  
>  static void add_sched_event_sleep(struct perf_sched *sched, struct task_desc *task,
> -				  u64 timestamp, u64 task_state __maybe_unused)
> +				  u64 timestamp, char task_state __maybe_unused)
>  {
>  	struct sched_atom *event = get_new_event(task, timestamp);
>  
> @@ -840,6 +835,22 @@ replay_wakeup_event(struct perf_sched *sched,
>  	return 0;
>  }
>  
> +static inline char task_state_char(int state)
> +{
> +	static const char state_to_char[] = "RSDTtXZPI";
> +	unsigned int bit = state ? ffs(state) : 0;
> +
> +	return bit < sizeof(state_to_char) - 1 ? state_to_char[bit] : '?';
> +}
> +
> +static inline char get_task_prev_state(struct evsel *evsel,
> +				       struct perf_sample *sample)
> +{
> +	const int prev_state = evsel__intval(evsel, sample, "prev_state");
> +
> +	return task_state_char(prev_state);
> +}
> +
>  static int replay_switch_event(struct perf_sched *sched,
>  			       struct evsel *evsel,
>  			       struct perf_sample *sample,
> @@ -849,7 +860,7 @@ static int replay_switch_event(struct perf_sched *sched,
>  		   *next_comm  = evsel__strval(evsel, sample, "next_comm");
>  	const u32 prev_pid = evsel__intval(evsel, sample, "prev_pid"),
>  		  next_pid = evsel__intval(evsel, sample, "next_pid");
> -	const u64 prev_state = evsel__intval(evsel, sample, "prev_state");
> +	const char prev_state = get_task_prev_state(evsel, sample);
>  	struct task_desc *prev, __maybe_unused *next;
>  	u64 timestamp0, timestamp = sample->time;
>  	int cpu = sample->cpu;
> @@ -1039,12 +1050,6 @@ static int thread_atoms_insert(struct perf_sched *sched, struct thread *thread)
>  	return 0;
>  }
>  
> -static char sched_out_state(u64 prev_state)
> -{
> -	const char *str = TASK_STATE_TO_CHAR_STR;
> -
> -	return str[prev_state];
> -}
>  
>  static int
>  add_sched_out_event(struct work_atoms *atoms,
> @@ -1121,7 +1126,7 @@ static int latency_switch_event(struct perf_sched *sched,
>  {
>  	const u32 prev_pid = evsel__intval(evsel, sample, "prev_pid"),
>  		  next_pid = evsel__intval(evsel, sample, "next_pid");
> -	const u64 prev_state = evsel__intval(evsel, sample, "prev_state");
> +	const char prev_state = get_task_prev_state(evsel, sample);
>  	struct work_atoms *out_events, *in_events;
>  	struct thread *sched_out, *sched_in;
>  	u64 timestamp0, timestamp = sample->time;
> @@ -1157,7 +1162,7 @@ static int latency_switch_event(struct perf_sched *sched,
>  			goto out_put;
>  		}
>  	}
> -	if (add_sched_out_event(out_events, sched_out_state(prev_state), timestamp))
> +	if (add_sched_out_event(out_events, prev_state, timestamp))
>  		return -1;
>  
>  	in_events = thread_atoms_search(&sched->atom_root, sched_in, &sched->cmp_pid);
> @@ -2022,24 +2027,12 @@ static void timehist_header(struct perf_sched *sched)
>  	printf("\n");
>  }
>  
> -static char task_state_char(struct thread *thread, int state)
> -{
> -	static const char state_to_char[] = TASK_STATE_TO_CHAR_STR;
> -	unsigned bit = state ? ffs(state) : 0;
> -
> -	/* 'I' for idle */
> -	if (thread__tid(thread) == 0)
> -		return 'I';
> -
> -	return bit < sizeof(state_to_char) - 1 ? state_to_char[bit] : '?';
> -}
> -
>  static void timehist_print_sample(struct perf_sched *sched,
>  				  struct evsel *evsel,
>  				  struct perf_sample *sample,
>  				  struct addr_location *al,
>  				  struct thread *thread,
> -				  u64 t, int state)
> +				  u64 t, char state)
>  {
>  	struct thread_runtime *tr = thread__priv(thread);
>  	const char *next_comm = evsel__strval(evsel, sample, "next_comm");
> @@ -2080,7 +2073,7 @@ static void timehist_print_sample(struct perf_sched *sched,
>  	print_sched_time(tr->dt_run, 6);
>  
>  	if (sched->show_state)
> -		printf(" %5c ", task_state_char(thread, state));
> +		printf(" %5c ", thread->tid == 0 ? 'I' : state);
>  
>  	if (sched->show_next) {
>  		snprintf(nstr, sizeof(nstr), "next: %s[%d]", next_comm, next_pid);
> @@ -2152,9 +2145,9 @@ static void timehist_update_runtime_stats(struct thread_runtime *r,
>  		else if (r->last_time) {
>  			u64 dt_wait = tprev - r->last_time;
>  
> -			if (r->last_state == TASK_RUNNING)
> +			if (r->last_state == 'R')
>  				r->dt_preempt = dt_wait;
> -			else if (r->last_state == TASK_UNINTERRUPTIBLE)
> +			else if (r->last_state == 'D')
>  				r->dt_iowait = dt_wait;
>  			else
>  				r->dt_sleep = dt_wait;
> @@ -2579,7 +2572,7 @@ static int timehist_sched_change_event(struct perf_tool *tool,
>  	struct thread_runtime *tr = NULL;
>  	u64 tprev, t = sample->time;
>  	int rc = 0;
> -	int state = evsel__intval(evsel, sample, "prev_state");
> +	const char state = get_task_prev_state(evsel, sample);
>  
>  	addr_location__init(&al);
>  	if (machine__resolve(machine, &al, sample) < 0) {

