Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DC7776FD7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjHJFwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjHJFw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:52:28 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553B91704;
        Wed,  9 Aug 2023 22:52:26 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-76cd8dab98fso45155085a.3;
        Wed, 09 Aug 2023 22:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691646745; x=1692251545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTrBc1GZdTvUCrGg7mrJ2oV5mk+NoH24hrlYjRQcJbA=;
        b=L+pX73blKBYIicvxIR0ycxw2iiFr9fVIfhYJJvK2eYeHBXX2S5P/BEdooIjsp+Axmo
         cCqp8hZOv5Va360/7p1Ib4/O5UUDdOO3uQDDx/8LEOUZeATKDnyoWL0U4JF+DlFvWj5Y
         ixY5/ktgTt0vZtK6kCcTqhogfuqO8d7hemroJhWPXiVRNwzdQ2EP5pD4W1OMOA0xZ+Lb
         vivxwHSmI/djXEQyFNZNwkQrxBsPFpekQRag2nM/l+AQmJrhfFnFxfi8FtZei3CxarUn
         ggbJY9DqgGcUAGz8RamBl2aXmoRGgwq4nxb3l+k8TKZ01hZ3Eu8pOirHmqdQfRIYon4c
         4D1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691646745; x=1692251545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTrBc1GZdTvUCrGg7mrJ2oV5mk+NoH24hrlYjRQcJbA=;
        b=Y1Eoyj6MeM2u43buVqxRqd6Gw2ERp4o3yOPxfn1qgA3tIgtNAY8pVPpCBuIRYn5xd9
         os4xE21bl70akMxYxNTwEMS4p8KnTs8YCbhmuG1Q8xSS30q9FWHlJ36yNYaYdG8J6L55
         PUALjWwu86OkNy6gFz7/Q8pJFJ+ipLG5fHpdJ+zx5VH4cJB8WepU7FA/oCEayEK1l8q9
         vAjgzoxot64dEwGYa/FRh5TGMlfTWNOcZ/M0/6fCAHjn6Fl6vn0azKzwyvIkpS2oArXj
         elIx33pKM+MQA6MpZqlAdPrVN5E4rqwdWERxHfwSJbnVphL5R8ovgTS+rg08AaZOV6GN
         n5tQ==
X-Gm-Message-State: AOJu0Yx0N89O95LWzYZhGFkRw8MdMtx0OYqtrnbIxS3PeoRMh9YWbESW
        LlHgsLb5tls/eCUh79afl2I=
X-Google-Smtp-Source: AGHT+IH1tvrM8CLZf+UxpDUzGyreMpr4HWpESxCvkzyoToCCS+vG2oAw4pguF+PWiFBzxb54Gb+VFw==
X-Received: by 2002:a05:620a:f14:b0:76c:d958:d549 with SMTP id v20-20020a05620a0f1400b0076cd958d549mr1258822qkl.11.1691646745384;
        Wed, 09 Aug 2023 22:52:25 -0700 (PDT)
Received: from localhost.localdomain ([43.132.98.47])
        by smtp.googlemail.com with ESMTPSA id u18-20020aa78492000000b00673e652985bsm600901pfn.118.2023.08.09.22.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 22:52:25 -0700 (PDT)
From:   Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To:     rostedt@goodmis.org
Cc:     acme@kernel.org, adrian.hunter@intel.com,
        alexander.shishkin@linux.intel.com, irogers@google.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mark.rutland@arm.com,
        mhiramat@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, zegao2021@gmail.com, zegao@tencent.com
Subject: 
Date:   Thu, 10 Aug 2023 01:50:24 -0400
Message-ID: <20230810055023.67529-2-zegao@tencent.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803234122.19b3d3a4@rorschach.local.home>
References: <20230803234122.19b3d3a4@rorschach.local.home>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

I managed to build task state char map dynamically by parsing
the tracepoint print format from data recorded by perf. And
likewise for libtraceevent.

FYI, I tried TEP_PRINT_INFO but no shot. It turns out TEP_PRINT_INFO
stills relies on libtraceevent (i.e., sched_switch_handler() in 
plugin_sched_switch.c) and we need to parse the print format on our own.

Anyway, it works now and I've tested on some perf.data in old formats
but not cover all the kernel releases.

Thoughts?

Regards,
Ze


From 6b2035494952efb2963e6459ae4dbfce496c3b97 Mon Sep 17 00:00:00 2001
From: Ze Gao <zegao@tencent.com>
Date: Wed, 2 Aug 2023 08:19:54 -0400
Subject: [PATCH] perf sched: parse task state from tracepoint print format

As of this writing, we use prev_state to report task state,
which relies on both the task state macros and
TASK_STATE_TO_CHAR_STR in kernel to interpret its actual
meaning. In this way, perf gets broken literally each time
TASK_STATE_TO_CHAR_STR changes as kernel evolves. Counting
on TASK_STATE_TO_CHAR_STR gurantees no backward compatibilty.

To fix this, we build the state char map from the print
format parsed from perf.data on the fly and removes
dependencies on these internal kernel definitions.

Note that we provide an intended helper get_task_prev_state()
for extracting task state from perf record and passing task
state in char elsewhere, which helps to eliminate the need to
know task state macros further.

Signed-off-by: Ze Gao <zegao@tencent.com>
---
 tools/perf/builtin-sched.c | 126 +++++++++++++++++++++++--------------
 1 file changed, 80 insertions(+), 46 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 9ab300b6f131..9366bc0a991d 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -52,6 +52,10 @@
 #define SYM_LEN			129
 #define MAX_PID			1024000
 
+#define TASK_STATE_MAX 16
+static char state_to_char[TASK_STATE_MAX];
+static unsigned int num_sleep_states = 0;
+
 static const char *cpu_list;
 static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
 
@@ -92,24 +96,6 @@ struct sched_atom {
 	struct task_desc	*wakee;
 };
 
-#define TASK_STATE_TO_CHAR_STR "RSDTtZXxKWP"
-
-/* task state bitmask, copied from include/linux/sched.h */
-#define TASK_RUNNING		0
-#define TASK_INTERRUPTIBLE	1
-#define TASK_UNINTERRUPTIBLE	2
-#define __TASK_STOPPED		4
-#define __TASK_TRACED		8
-/* in tsk->exit_state */
-#define EXIT_DEAD		16
-#define EXIT_ZOMBIE		32
-#define EXIT_TRACE		(EXIT_ZOMBIE | EXIT_DEAD)
-/* in tsk->state again */
-#define TASK_DEAD		64
-#define TASK_WAKEKILL		128
-#define TASK_WAKING		256
-#define TASK_PARKED		512
-
 enum thread_state {
 	THREAD_SLEEPING = 0,
 	THREAD_WAIT_CPU,
@@ -266,7 +252,7 @@ struct thread_runtime {
 	u64 total_preempt_time;
 	u64 total_delay_time;
 
-	int last_state;
+	char last_state;
 
 	char shortname[3];
 	bool comm_changed;
@@ -436,7 +422,7 @@ static void add_sched_event_wakeup(struct perf_sched *sched, struct task_desc *t
 }
 
 static void add_sched_event_sleep(struct perf_sched *sched, struct task_desc *task,
-				  u64 timestamp, u64 task_state __maybe_unused)
+				  u64 timestamp, char task_state __maybe_unused)
 {
 	struct sched_atom *event = get_new_event(task, timestamp);
 
@@ -851,6 +837,72 @@ replay_wakeup_event(struct perf_sched *sched,
 	return 0;
 }
 
+static struct tep_print_arg* task_state_print_flag(struct tep_event *event)
+{
+       struct tep_print_arg* args = event->print_fmt.args;
+
+       while(args)
+       {
+               if (args->type == TEP_PRINT_FLAGS)
+                       return args;
+               if (args->type == TEP_PRINT_OP) {
+                       args = args->op.right;
+                       args = args->op.left;
+                       continue;
+               }
+               args = args->next;
+       }
+       return NULL;
+}
+
+static void __parse_print_flag(struct tep_print_flag_sym *field)
+{
+
+       long val = strtol(field->value, NULL, 0);
+       unsigned int bit = val ? ffs(val) : 0;
+
+       state_to_char[bit] = field->str[0];
+       num_sleep_states++;
+       if(num_sleep_states > TASK_STATE_MAX - 1) {
+               pr_warning("too many states parsed, possibly bad format\n");
+               return;
+       }
+       if (field->next) {
+               __parse_print_flag(field->next);
+       }
+}
+
+static inline void parse_print_flag(struct tep_print_arg* args)
+{
+       __parse_print_flag(args->flags.flags);
+}
+
+static void build_task_state_arr(struct tep_event *event)
+{
+       struct tep_print_arg* args;
+
+       args = task_state_print_flag(event);
+       if (!args)
+               pr_warning("print flag not found, possibly bad format\n");
+       else
+               parse_print_flag(args);
+}
+
+static inline char get_prev_task_state(struct evsel *evsel,
+		struct perf_sample *sample)
+{
+	int prev_state = evsel__intval(evsel, sample, "prev_state");
+	unsigned int bit = prev_state ? ffs(prev_state) : 0;
+	char state;
+
+	if(!num_sleep_states)
+		build_task_state_arr(evsel->tp_format);
+
+	state = (!bit || bit > num_sleep_states) ? 'R' : state_to_char[bit];
+
+	return state;
+}
+
 static int replay_switch_event(struct perf_sched *sched,
 			       struct evsel *evsel,
 			       struct perf_sample *sample,
@@ -860,7 +912,7 @@ static int replay_switch_event(struct perf_sched *sched,
 		   *next_comm  = evsel__strval(evsel, sample, "next_comm");
 	const u32 prev_pid = evsel__intval(evsel, sample, "prev_pid"),
 		  next_pid = evsel__intval(evsel, sample, "next_pid");
-	const u64 prev_state = evsel__intval(evsel, sample, "prev_state");
+	const char prev_state = get_prev_task_state(evsel, sample);
 	struct task_desc *prev, __maybe_unused *next;
 	u64 timestamp0, timestamp = sample->time;
 	int cpu = sample->cpu;
@@ -1050,12 +1102,6 @@ static int thread_atoms_insert(struct perf_sched *sched, struct thread *thread)
 	return 0;
 }
 
-static char sched_out_state(u64 prev_state)
-{
-	const char *str = TASK_STATE_TO_CHAR_STR;
-
-	return str[prev_state];
-}
 
 static int
 add_sched_out_event(struct work_atoms *atoms,
@@ -1132,7 +1178,7 @@ static int latency_switch_event(struct perf_sched *sched,
 {
 	const u32 prev_pid = evsel__intval(evsel, sample, "prev_pid"),
 		  next_pid = evsel__intval(evsel, sample, "next_pid");
-	const u64 prev_state = evsel__intval(evsel, sample, "prev_state");
+	const char prev_state = get_prev_task_state(evsel, sample);
 	struct work_atoms *out_events, *in_events;
 	struct thread *sched_out, *sched_in;
 	u64 timestamp0, timestamp = sample->time;
@@ -1168,7 +1214,7 @@ static int latency_switch_event(struct perf_sched *sched,
 			goto out_put;
 		}
 	}
-	if (add_sched_out_event(out_events, sched_out_state(prev_state), timestamp))
+	if (add_sched_out_event(out_events, prev_state, timestamp))
 		return -1;
 
 	in_events = thread_atoms_search(&sched->atom_root, sched_in, &sched->cmp_pid);
@@ -2033,24 +2079,12 @@ static void timehist_header(struct perf_sched *sched)
 	printf("\n");
 }
 
-static char task_state_char(struct thread *thread, int state)
-{
-	static const char state_to_char[] = TASK_STATE_TO_CHAR_STR;
-	unsigned bit = state ? ffs(state) : 0;
-
-	/* 'I' for idle */
-	if (thread__tid(thread) == 0)
-		return 'I';
-
-	return bit < sizeof(state_to_char) - 1 ? state_to_char[bit] : '?';
-}
-
 static void timehist_print_sample(struct perf_sched *sched,
 				  struct evsel *evsel,
 				  struct perf_sample *sample,
 				  struct addr_location *al,
 				  struct thread *thread,
-				  u64 t, int state)
+				  u64 t, char state)
 {
 	struct thread_runtime *tr = thread__priv(thread);
 	const char *next_comm = evsel__strval(evsel, sample, "next_comm");
@@ -2091,7 +2125,7 @@ static void timehist_print_sample(struct perf_sched *sched,
 	print_sched_time(tr->dt_run, 6);
 
 	if (sched->show_state)
-		printf(" %5c ", task_state_char(thread, state));
+		printf(" %5c ", thread->tid == 0 ? 'I' : state);
 
 	if (sched->show_next) {
 		snprintf(nstr, sizeof(nstr), "next: %s[%d]", next_comm, next_pid);
@@ -2163,9 +2197,9 @@ static void timehist_update_runtime_stats(struct thread_runtime *r,
 		else if (r->last_time) {
 			u64 dt_wait = tprev - r->last_time;
 
-			if (r->last_state == TASK_RUNNING)
+			if (r->last_state == 'R')
 				r->dt_preempt = dt_wait;
-			else if (r->last_state == TASK_UNINTERRUPTIBLE)
+			else if (r->last_state == 'D')
 				r->dt_iowait = dt_wait;
 			else
 				r->dt_sleep = dt_wait;
@@ -2590,7 +2624,7 @@ static int timehist_sched_change_event(struct perf_tool *tool,
 	struct thread_runtime *tr = NULL;
 	u64 tprev, t = sample->time;
 	int rc = 0;
-	int state = evsel__intval(evsel, sample, "prev_state");
+	const char state = get_prev_task_state(evsel, sample);
 
 	addr_location__init(&al);
 	if (machine__resolve(machine, &al, sample) < 0) {
-- 
2.41.0

