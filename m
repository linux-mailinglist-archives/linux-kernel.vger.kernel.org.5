Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7178C76AB96
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbjHAJB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjHAJBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:01:49 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1425E1996;
        Tue,  1 Aug 2023 02:01:45 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bbdc05a93bso33066885ad.0;
        Tue, 01 Aug 2023 02:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690880504; x=1691485304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBxCbacsLX6m7o32e5QWwMlB/3bI1PwM+xCI9ISuc6o=;
        b=eZn7HUGdRY0o+oSO7rF5Pch85mgNf4Y/292AsG/gybfExewTsCGLCO3KLIeVP3cDn3
         wkKZ1f3YHvWHzpdzWJXNmRqahVWImESo2wNDUDvjUVmHYvtarL2Y6b9qB5KRzOcwVZvc
         mpiLj/BFpjrOBNA41rHxf8YSE7ACPQzxyIPu+g5s4/jK+vX1cp1p3ZwhhUg1VfFOnPgE
         UzhHsqB3a1WYWpJOfq4o3HPa1tL3tmpuLHO5jkWZN+nrEOizwlk6MNVydcHPGi4ZgYAl
         xootA5r0isHTNLsL5E9/XNIC93uG6VArfY/ZA1/v2RCpcvFO2NWu7XCXHItMEfvWQSm7
         eobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690880504; x=1691485304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBxCbacsLX6m7o32e5QWwMlB/3bI1PwM+xCI9ISuc6o=;
        b=lXgYiRCrTKJieo5FvvUAhba5byX7V7wHE2IrBtkVci9nKoopYPqwt/ZYetipXweL+P
         85jC690noIPOLrzjhFecxSCC4XelByuLSftdTmhoElsp68+Rt8LWhrbs1Yyw0Da19OLw
         9BQRJO2+aiKFxh6pcJV9kf74A4bidCzTKtmNPzQJ4pqRdMOxWSn+j7Hb1A6M5D+3XBC8
         /r1ht36ZdxanxzPn9n/+RK9r/O2B/+WMiEUvy0P1zv5cpJwcDPsKpewZTHJJXUuKSyWj
         cPZYoapQiL1/30Xl2KXi+1taaNB7h4MX/m3F5LXONlE+8U6BbMbPKOP3IolO5/sd/6jE
         S9LA==
X-Gm-Message-State: ABy/qLaaT0dIIrutKmifz5yCjjxXUDgr/1GkZfGpbmzPaYc3WCxVb5p2
        tySPXAJyB0cyPaDOm1BJMTQ=
X-Google-Smtp-Source: APBJJlGNAFkldW0pFDmQA6SMOwnw+zJDxri1fsp82e+tU2NsdUEA7z8xoSGFUv31M8l9BiIiYyOqBQ==
X-Received: by 2002:a17:90b:4b4c:b0:268:31f3:79d6 with SMTP id mi12-20020a17090b4b4c00b0026831f379d6mr9635389pjb.36.1690880504352;
        Tue, 01 Aug 2023 02:01:44 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.20])
        by smtp.googlemail.com with ESMTPSA id x34-20020a17090a6c2500b00264044cca0fsm1592523pjj.1.2023.08.01.02.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 02:01:44 -0700 (PDT)
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
Subject: [RFC PATCH v3 3/6] sched, tracing: add to report task state in symbolic chars
Date:   Tue,  1 Aug 2023 17:01:21 +0800
Message-Id: <20230801090124.8050-4-zegao@tencent.com>
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

Internal representations of task state are likely to be changed
or ordered, and reporting them to userspace without exporting
them as part of API is basically wrong, which can easily break
a userspace observability tool as kernel evolves. For example,
perf suffers from this and still reports wrong states as of this
writing.

OTOH, some masqueraded states like TASK_REPORT_IDLE and
TASK_REPORT_MAX are also reported inadvertently, which confuses
things even more and most userspace tools do not even take them
into consideration.

So add a new variable in company with the old raw value to
report task state in symbolic chars, which are self-explaining
and no further translation is needed. Of course this does not
break any userspace tool.

Note for PREEMPT_ACTIVE, we introduce 'p' to report it and use
the old conventions for the rest.

Signed-off-by: Ze Gao <zegao@tencent.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Ian Rogers <irogers@google.com>
---
 include/trace/events/sched.h | 54 +++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index fbb99a61f714..e507901bcab8 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -6,6 +6,7 @@
 #define _TRACE_SCHED_H
 
 #include <linux/kthread.h>
+#include <linux/sched.h>
 #include <linux/sched/numa_balancing.h>
 #include <linux/tracepoint.h>
 #include <linux/binfmts.h>
@@ -214,6 +215,27 @@ static inline long __trace_sched_switch_state(bool preempt,
 
 	return state ? (1 << (state - 1)) : state;
 }
+
+static inline char __trace_sched_switch_state_char(bool preempt,
+						   unsigned int prev_state,
+						   struct task_struct *p)
+{
+	long state;
+
+#ifdef CONFIG_SCHED_DEBUG
+	BUG_ON(p != current);
+#endif /* CONFIG_SCHED_DEBUG */
+
+	/*
+	 * For PREEMPT_ACTIVE, we introduce 'p' to report it and use the old
+	 * conventions for the rest.
+	 */
+	if (preempt)
+		return 'p';
+
+	state = __task_state_index(prev_state, p->exit_state);
+	return task_index_to_char(state);
+}
 #endif /* CREATE_TRACE_POINTS */
 
 /*
@@ -233,6 +255,7 @@ TRACE_EVENT(sched_switch,
 		__field(	pid_t,	prev_pid			)
 		__field(	int,	prev_prio			)
 		__field(	long,	prev_state			)
+		__field(	char,	prev_state_char			)
 		__array(	char,	next_comm,	TASK_COMM_LEN	)
 		__field(	pid_t,	next_pid			)
 		__field(	int,	next_prio			)
@@ -240,32 +263,19 @@ TRACE_EVENT(sched_switch,
 
 	TP_fast_assign(
 		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
-		__entry->prev_pid	= prev->pid;
-		__entry->prev_prio	= prev->prio;
-		__entry->prev_state	= __trace_sched_switch_state(preempt, prev_state, prev);
+		__entry->prev_pid		= prev->pid;
+		__entry->prev_prio		= prev->prio;
+		__entry->prev_state		= __trace_sched_switch_state(preempt, prev_state, prev);
+		__entry->prev_state_char	= __trace_sched_switch_state_char(preempt, prev_state, prev);
 		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
-		__entry->next_pid	= next->pid;
-		__entry->next_prio	= next->prio;
+		__entry->next_pid		= next->pid;
+		__entry->next_prio		= next->prio;
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
-		__entry->next_comm, __entry->next_pid, __entry->next_prio)
+	TP_printk("prev_comm=%s prev_pid=%d prev_prio=%d prev_state=%c ==> next_comm=%s next_pid=%d next_prio=%d",
+		__entry->prev_comm, __entry->prev_pid, __entry->prev_prio, __entry->prev_state_char, __entry->next_comm,
+		__entry->next_pid, __entry->next_prio)
 );
 
 /*
-- 
2.40.1

