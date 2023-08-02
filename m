Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3333576CD7D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbjHBMtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbjHBMtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:49:09 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFE0212B;
        Wed,  2 Aug 2023 05:49:00 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-56487a5401bso131267a12.3;
        Wed, 02 Aug 2023 05:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690980540; x=1691585340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqGWXQUnHEGIAJjlk8NVej2IuOd14tKht3c5V5V3ivI=;
        b=mtOsLo07GMllEngNvb9+BqwcT7KAe81fbqwVPSDxezQtx9R2AIdEPawGkHCXKfy6EU
         rM8VkRK4Rxt7kcHvnT1IyKrCQMUISW2CKsEevszJxDVwBDTgFZBF6mry0a+5o/N1LQDN
         uC0DKs/PuonpeBIAaFtiX0zSCnljcsy/40Q2fszofzPbTmxwjwFH2ORITr3zwkVMmU2m
         OUJzeFQ0cUqFY2pEMVwouQZCUerqOs4jwfX5n8x+6ABL/ZyYnPsjMnDtJOKiv1hJ7ya1
         wVRggbfxbLJsxFeGYbwuvFM0fjKTdKVQ0ANtzU5dDDsJCuhED4seqnTXBQpU3j3lAw7N
         UPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690980540; x=1691585340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZqGWXQUnHEGIAJjlk8NVej2IuOd14tKht3c5V5V3ivI=;
        b=hjHQI9iG6o1wEvkEJOOmK08ae+N52drb8k/pjP5wXf/6cS7vYaQHIjvH4HMp4VFptJ
         c6L4veXHEV8Fn4wVoD30msPz1z0k1vJzcaGinSuvvY4cN06r7zrFW/c9oCDGDfqyQzoK
         FbefpNv5BozHqsPz2SJ4HCqFdVsHjgwJZ07yjy+niB7zN2G0Ldx6hdX0mObSX8gRHWc3
         H9EYN1UcPw2KAocAD9b1gjs5uXU1i46VIMWNbNWHddQAAQJ5D6QF7wDRuNx6IZMnna6V
         oY4FYRBHXsEzoTpPzaqxOur8V3thB9XFBdUd77QWmU/qg9BmDo3bmf/ROAI3pPtQxW/M
         d8BA==
X-Gm-Message-State: ABy/qLYXBIoD/TJgGWMdj85Cu8Xexr2A/CqQyGaJS636wUeSDbSLs0+R
        lkt/k1XRfM7SkGs22nq8ey4=
X-Google-Smtp-Source: APBJJlFjShZACk6pta2NRgdxfZ8vgVCM/fK1MmgGzGUheTbPNnbnvBCBDQuO9gxgsq8OvyrNiy31ag==
X-Received: by 2002:a17:90a:2a48:b0:263:ac11:c6d2 with SMTP id d8-20020a17090a2a4800b00263ac11c6d2mr13717420pjg.25.1690980539783;
        Wed, 02 Aug 2023 05:48:59 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.17])
        by smtp.googlemail.com with ESMTPSA id x34-20020a17090a6c2500b00264044cca0fsm4811993pjj.1.2023.08.02.05.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 05:48:59 -0700 (PDT)
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
Subject: [RFC PATCH v5 3/7] perf sched: reorganize sched-out task state report code
Date:   Wed,  2 Aug 2023 08:47:26 -0400
Message-ID: <20230802124840.335638-4-zegao@tencent.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802124840.335638-1-zegao@tencent.com>
References: <20230802124840.335638-1-zegao@tencent.com>
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

Mainly does housekeeping work and not introduce any
functional change.

Signed-off-by: Ze Gao <zegao@tencent.com>
---
 tools/perf/builtin-sched.c | 57 ++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 33 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 8dc8f071721c..eb310d1a7625 100644
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
@@ -2022,24 +2025,12 @@ static void timehist_header(struct perf_sched *sched)
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
@@ -2080,7 +2071,7 @@ static void timehist_print_sample(struct perf_sched *sched,
 	print_sched_time(tr->dt_run, 6);
 
 	if (sched->show_state)
-		printf(" %5c ", task_state_char(thread, state));
+		printf(" %5c ", thread->tid == 0 ? 'I' : state);
 
 	if (sched->show_next) {
 		snprintf(nstr, sizeof(nstr), "next: %s[%d]", next_comm, next_pid);
@@ -2152,9 +2143,9 @@ static void timehist_update_runtime_stats(struct thread_runtime *r,
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
@@ -2579,7 +2570,7 @@ static int timehist_sched_change_event(struct perf_tool *tool,
 	struct thread_runtime *tr = NULL;
 	u64 tprev, t = sample->time;
 	int rc = 0;
-	int state = evsel__intval(evsel, sample, "prev_state");
+	const char state = get_task_prev_state(evsel, sample);
 
 	addr_location__init(&al);
 	if (machine__resolve(machine, &al, sample) < 0) {
-- 
2.41.0

