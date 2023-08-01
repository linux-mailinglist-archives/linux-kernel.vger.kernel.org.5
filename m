Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2CD76AB94
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjHAJBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjHAJBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:01:42 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2138DE7;
        Tue,  1 Aug 2023 02:01:41 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-268299d5d9fso3006915a91.1;
        Tue, 01 Aug 2023 02:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690880500; x=1691485300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FyqGyivSWJ8U4X+4ZXNDsrpYxWDLRcGdfTgj5jmwqPU=;
        b=D0xqo6gPUT4pSeEn7VvOYFV5VgXyJV2kvn6SKN1gvF1cV1d8Hr5DTWd59ZmyZxdImf
         F5VgBKMQloXeM/8EYkQVhG/AXGbyZ1X4238jLHC+ZlNF/uRdTus8i1loTTCtTZg21fOF
         u3RVSzW01Q2wfLfjAU09/+QejdCvxXr/KmhO87efJM5L1uQu/jdjgCTFfsOmw4HGI9J0
         ObiZPg3ZRRzs7xWt3lgXtOLQ5WeEDOTxBTuYVEwInXub8c2rmQmqmNiKXYg7OYq5LG03
         nhdad3jJELvzabPCP7blSV7WWnVjnvfnb6PUQ5gcCy7T06VQtOAO+icX3f8N++pFqYQW
         rkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690880500; x=1691485300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FyqGyivSWJ8U4X+4ZXNDsrpYxWDLRcGdfTgj5jmwqPU=;
        b=ZmH2f6MPtOM+MvN8pVfPTTuxXmJQt6H6wLSf/wByIyLnZWeQQSJ3YK45za5HYxxYSB
         Wndv2MkMfBd7GFjUAf8gHdLPAFB1a+0NLpPwzRz+IY94PpxcDwfw4x+1cg+r3UcUVKEj
         95hW/7o5h167gaRIAi7GPWtciYYDt3Gq+PzaO/M+yfYUfcQOAGNVLUiPPrtDbIIWKiqE
         ChkbF2alBmzy7gPdNZM/zVcT77UXDCOLepP457sVI7kmwW5qSIqez0rMRf7rdUl3NTHe
         KLdvJralXLJ4tm5kdeeW1sI3udTvkNTcTRAPq+UPL05I01cxTDgwbB5OhXwUk+84cgdp
         tp4A==
X-Gm-Message-State: ABy/qLYlhESQEZZEG3pF4ZMXnmVc7KBikqboHOxRJHcrKsmLnKAIZ4Q7
        q9lS20UU7H5/QllVaw/3Py0=
X-Google-Smtp-Source: APBJJlEowuQrpkipas305RJSKP6JUFe4LdY1CxvA62HmjQx6UH0kvPkuzKFb9fVhdUX7Pt4bCWBxcw==
X-Received: by 2002:a17:90a:2fcf:b0:268:5fd8:d8ff with SMTP id n15-20020a17090a2fcf00b002685fd8d8ffmr9942593pjm.0.1690880500502;
        Tue, 01 Aug 2023 02:01:40 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.20])
        by smtp.googlemail.com with ESMTPSA id x34-20020a17090a6c2500b00264044cca0fsm1592523pjj.1.2023.08.01.02.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 02:01:40 -0700 (PDT)
From:   Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Subject: [RFC PATCH v3 2/6] perf sched: reorganize sched-out task state report code
Date:   Tue,  1 Aug 2023 17:01:20 +0800
Message-Id: <20230801090124.8050-3-zegao@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230801090124.8050-1-zegao@tencent.com>
References: <20230801090124.8050-1-zegao@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patch mainly does housekeeping work and not
introduce any functional change.

Signed-off-by: Ze Gao <zegao@tencent.com>
---
 tools/perf/builtin-sched.c | 57 ++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 33 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index c0d0ad18fc76..275da655b67a 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -94,11 +94,6 @@ struct sched_atom {
 
 #define TASK_STATE_TO_CHAR_STR "RSDTtXZPI"
 
-/* task state bitmask, copied from include/linux/sched.h */
-#define TASK_RUNNING		0
-#define TASK_INTERRUPTIBLE	1
-#define TASK_UNINTERRUPTIBLE	2
-
 enum thread_state {
 	THREAD_SLEEPING = 0,
 	THREAD_WAIT_CPU,
@@ -255,7 +250,7 @@ struct thread_runtime {
 	u64 total_preempt_time;
 	u64 total_delay_time;
 
-	int last_state;
+	char last_state;
 
 	char shortname[3];
 	bool comm_changed;
@@ -425,7 +420,7 @@ static void add_sched_event_wakeup(struct perf_sched *sched, struct task_desc *t
 }
 
 static void add_sched_event_sleep(struct perf_sched *sched, struct task_desc *task,
-				  u64 timestamp, u64 task_state __maybe_unused)
+				  u64 timestamp, char task_state __maybe_unused)
 {
 	struct sched_atom *event = get_new_event(task, timestamp);
 
@@ -840,6 +835,20 @@ replay_wakeup_event(struct perf_sched *sched,
 	return 0;
 }
 
+static inline char task_state_char(int state)
+{
+	static const char state_to_char[] = "RSDTtXZPI";
+	unsigned bit = state ? ffs(state) : 0;
+	return bit < sizeof(state_to_char) - 1 ? state_to_char[bit] : '?';
+}
+
+static inline char get_task_prev_state(struct evsel *evsel,
+				       struct perf_sample *sample)
+{
+	const int prev_state = evsel__intval(evsel, sample, "prev_state");
+	return task_state_char(prev_state);
+}
+
 static int replay_switch_event(struct perf_sched *sched,
 			       struct evsel *evsel,
 			       struct perf_sample *sample,
@@ -849,7 +858,7 @@ static int replay_switch_event(struct perf_sched *sched,
 		   *next_comm  = evsel__strval(evsel, sample, "next_comm");
 	const u32 prev_pid = evsel__intval(evsel, sample, "prev_pid"),
 		  next_pid = evsel__intval(evsel, sample, "next_pid");
-	const u64 prev_state = evsel__intval(evsel, sample, "prev_state");
+	const char prev_state = get_task_prev_state(evsel, sample);
 	struct task_desc *prev, __maybe_unused *next;
 	u64 timestamp0, timestamp = sample->time;
 	int cpu = sample->cpu;
@@ -1039,12 +1048,6 @@ static int thread_atoms_insert(struct perf_sched *sched, struct thread *thread)
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
@@ -1121,7 +1124,7 @@ static int latency_switch_event(struct perf_sched *sched,
 {
 	const u32 prev_pid = evsel__intval(evsel, sample, "prev_pid"),
 		  next_pid = evsel__intval(evsel, sample, "next_pid");
-	const u64 prev_state = evsel__intval(evsel, sample, "prev_state");
+	const char prev_state = get_task_prev_state(evsel, sample);
 	struct work_atoms *out_events, *in_events;
 	struct thread *sched_out, *sched_in;
 	u64 timestamp0, timestamp = sample->time;
@@ -1157,7 +1160,7 @@ static int latency_switch_event(struct perf_sched *sched,
 			goto out_put;
 		}
 	}
-	if (add_sched_out_event(out_events, sched_out_state(prev_state), timestamp))
+	if (add_sched_out_event(out_events, prev_state, timestamp))
 		return -1;
 
 	in_events = thread_atoms_search(&sched->atom_root, sched_in, &sched->cmp_pid);
@@ -2015,24 +2018,12 @@ static void timehist_header(struct perf_sched *sched)
 	printf("\n");
 }
 
-static char task_state_char(struct thread *thread, int state)
-{
-	static const char state_to_char[] = TASK_STATE_TO_CHAR_STR;
-	unsigned bit = state ? ffs(state) : 0;
-
-	/* 'I' for idle */
-	if (thread->tid == 0)
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
@@ -2073,7 +2064,7 @@ static void timehist_print_sample(struct perf_sched *sched,
 	print_sched_time(tr->dt_run, 6);
 
 	if (sched->show_state)
-		printf(" %5c ", task_state_char(thread, state));
+		printf(" %5c ", thread->tid == 0 ? 'I' : state);
 
 	if (sched->show_next) {
 		snprintf(nstr, sizeof(nstr), "next: %s[%d]", next_comm, next_pid);
@@ -2145,9 +2136,9 @@ static void timehist_update_runtime_stats(struct thread_runtime *r,
 		else if (r->last_time) {
 			u64 dt_wait = tprev - r->last_time;
 
-			if (r->last_state == TASK_RUNNING)
+			if (r->last_state == 'R' || r->last_state == 'p')
 				r->dt_preempt = dt_wait;
-			else if (r->last_state == TASK_UNINTERRUPTIBLE)
+			else if (r->last_state == 'D')
 				r->dt_iowait = dt_wait;
 			else
 				r->dt_sleep = dt_wait;
@@ -2564,7 +2555,7 @@ static int timehist_sched_change_event(struct perf_tool *tool,
 	struct thread_runtime *tr = NULL;
 	u64 tprev, t = sample->time;
 	int rc = 0;
-	int state = evsel__intval(evsel, sample, "prev_state");
+	char state = get_task_prev_state(evsel, sample);
 
 	if (machine__resolve(machine, &al, sample) < 0) {
 		pr_err("problem processing %d event. skipping it\n",
-- 
2.40.1

