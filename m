Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81684760BA1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjGYH1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbjGYH00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:26:26 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE78810F8;
        Tue, 25 Jul 2023 00:23:09 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-66767d628e2so2945005b3a.2;
        Tue, 25 Jul 2023 00:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690269789; x=1690874589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8jOqL9nsN3X2QdJmIGhs0fEScdnThT1mzgrts+M8u0c=;
        b=P3uSFiU1A85ZSJW+KDb9oGfLXAkcmTl8KJIjIHI34hO7DMh5CQ8xjVOvFCjugBnao5
         YoeoJgqCFcrBpF4FPxEi9hY5p9j/Ih56nHnaMAYwHzFYN/UCT9PC/DPY2D2jFYembcJh
         Xl0AyJgZa/ji6U2z/EpGxkZ3iOMTsH2YsGVfd/DKUlE1G0DLQJ2B1rsMvHZi2gW7ZmIY
         UfLBfyTZF7h6Md2IZcbw3hu95oeKNqp/9OOVqqEOt2e7urSSFg0wHqzmskEgijgSgTPh
         +0dH0y109s6pCjy0eJcNgBb7u1kxRi2TU05xSiVMn/sqDvIQBMiwdjlMp/3OKqI2v98d
         jMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690269789; x=1690874589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8jOqL9nsN3X2QdJmIGhs0fEScdnThT1mzgrts+M8u0c=;
        b=ER6JJHr1sed9NOcDtF4zuZ20RzLmiO8HeEEnF3SDXEQVnbbDg7CV4ctbWBj69m2f3i
         lvE6Ne9kmFgmpgiMsyPAaqdLcmXGRkIP+r7rPVvKfjgvb5IrCVHNDjaDuQsx/f7kpoB2
         5VTY4twQh1ccpS3bFQ02vdfgg8IkvHAetbHjneR3mbdFUMAwhpuOcRO13uiHi0OQykPw
         O1ljzWGDpx7lpxeiEYZKlhEXoXiEAT/dMApaafws4FB6tLWO/SqVQ9CxjlHs9/OXTbD7
         R9F0B4c9YJ5TvYwZYGheq9H+xAk1LQquxUz79Ast0n8j8RamIscQL13WnTPrTmrDMZky
         6kig==
X-Gm-Message-State: ABy/qLacNpjrY4myBTnVgDuahanKkPcWpmUNDZtHaZfD/kgpQKz+h19s
        NhP3nsLuNjSEhenjrNbhkzM=
X-Google-Smtp-Source: APBJJlE5P3KgIbml3rlumG2mIwCYc1q2G6bn6RD40IAKDiBVKE3ViSGYgMDvR1b5GmMw34nrbunaOw==
X-Received: by 2002:a05:6a00:194c:b0:668:711a:7d93 with SMTP id s12-20020a056a00194c00b00668711a7d93mr7317580pfk.19.1690269789133;
        Tue, 25 Jul 2023 00:23:09 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.82])
        by smtp.googlemail.com with ESMTPSA id d12-20020a63734c000000b0055acfd94c20sm9863908pgn.35.2023.07.25.00.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 00:23:08 -0700 (PDT)
From:   Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Subject: [RFC PATCH 1/3] sched, tracing: report task state in symbolic chars instead
Date:   Tue, 25 Jul 2023 15:22:52 +0800
Message-Id: <20230725072254.32045-2-zegao@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230725072254.32045-1-zegao@tencent.com>
References: <20230725072254.32045-1-zegao@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Internal representations of task state are likely to be changed or ordered,
and reporting them to userspace without exporting them as part of API is not
a good choice, which can easily break a userspace observability tool as kernel
evolves. For example, perf suffers from this and still reports wrong states
by this patch.

OTOH, some masqueraded state like TASK_REPORT_IDLE and TASK_REPORT_MAX are
also reported inadvertently, which confuses things even more.

So report task state in symbolic char instead, which is self-explaining and
no further translation is needed.

Note for PREEMPT_ACTIVE, we introduce 'p' to report it and use the old
conventions for the rest.

Signed-off-by: Ze Gao <zegao@tencent.com>
---
 include/trace/events/sched.h | 41 +++++++++++++-----------------------
 1 file changed, 15 insertions(+), 26 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index fbb99a61f714..51102a7c0c2d 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -6,6 +6,7 @@
 #define _TRACE_SCHED_H
 
 #include <linux/kthread.h>
+#include <linux/sched.h>
 #include <linux/sched/numa_balancing.h>
 #include <linux/tracepoint.h>
 #include <linux/binfmts.h>
@@ -187,7 +188,7 @@ DEFINE_EVENT(sched_wakeup_template, sched_wakeup_new,
 	     TP_ARGS(p));
 
 #ifdef CREATE_TRACE_POINTS
-static inline long __trace_sched_switch_state(bool preempt,
+static inline const char __trace_sched_switch_state(bool preempt,
 					      unsigned int prev_state,
 					      struct task_struct *p)
 {
@@ -197,13 +198,6 @@ static inline long __trace_sched_switch_state(bool preempt,
 	BUG_ON(p != current);
 #endif /* CONFIG_SCHED_DEBUG */
 
-	/*
-	 * Preemption ignores task state, therefore preempted tasks are always
-	 * RUNNING (we will not have dequeued if state != RUNNING).
-	 */
-	if (preempt)
-		return TASK_REPORT_MAX;
-
 	/*
 	 * task_state_index() uses fls() and returns a value from 0-8 range.
 	 * Decrement it by 1 (except TASK_RUNNING state i.e 0) before using
@@ -212,7 +206,16 @@ static inline long __trace_sched_switch_state(bool preempt,
 	 */
 	state = __task_state_index(prev_state, p->exit_state);
 
-	return state ? (1 << (state - 1)) : state;
+	/*
+	 * Preemption ignores task state, therefore preempted tasks are always
+	 * RUNNING (we will not have dequeued if state != RUNNING).
+	 * Here, we use 'p' to denote this case and only for this case.
+	 */
+	if (preempt)
+		return 'p';
+
+
+	return task_index_to_char(state);
 }
 #endif /* CREATE_TRACE_POINTS */
 
@@ -232,7 +235,7 @@ TRACE_EVENT(sched_switch,
 		__array(	char,	prev_comm,	TASK_COMM_LEN	)
 		__field(	pid_t,	prev_pid			)
 		__field(	int,	prev_prio			)
-		__field(	long,	prev_state			)
+		__field(	char,	prev_state			)
 		__array(	char,	next_comm,	TASK_COMM_LEN	)
 		__field(	pid_t,	next_pid			)
 		__field(	int,	next_prio			)
@@ -249,22 +252,8 @@ TRACE_EVENT(sched_switch,
 		/* XXX SCHED_DEADLINE */
 	),
 
-	TP_printk("prev_comm=%s prev_pid=%d prev_prio=%d prev_state=%s%s ==> next_comm=%s next_pid=%d next_prio=%d",
-		__entry->prev_comm, __entry->prev_pid, __entry->prev_prio,
-
-		(__entry->prev_state & (TASK_REPORT_MAX - 1)) ?
-		  __print_flags(__entry->prev_state & (TASK_REPORT_MAX - 1), "|",
-				{ TASK_INTERRUPTIBLE, "S" },
-				{ TASK_UNINTERRUPTIBLE, "D" },
-				{ __TASK_STOPPED, "T" },
-				{ __TASK_TRACED, "t" },
-				{ EXIT_DEAD, "X" },
-				{ EXIT_ZOMBIE, "Z" },
-				{ TASK_PARKED, "P" },
-				{ TASK_DEAD, "I" }) :
-		  "R",
-
-		__entry->prev_state & TASK_REPORT_MAX ? "+" : "",
+	TP_printk("prev_comm=%s prev_pid=%d prev_prio=%d prev_state=%c ==> next_comm=%s next_pid=%d next_prio=%d",
+		__entry->prev_comm, __entry->prev_pid, __entry->prev_prio, __entry->prev_state,
 		__entry->next_comm, __entry->next_pid, __entry->next_prio)
 );
 
-- 
2.40.1

