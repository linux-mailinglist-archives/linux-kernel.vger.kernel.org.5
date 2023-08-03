Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EB976E344
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbjHCIgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjHCIgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:36:21 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E4F122;
        Thu,  3 Aug 2023 01:34:54 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686efb9ee0cso605435b3a.3;
        Thu, 03 Aug 2023 01:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691051694; x=1691656494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kMReHmvqASQi9h76AGb1J6S3mur9uz2u2XL40ZYDh4=;
        b=VVB9J5TldtSc15eRKvxQumCP3QnvCdg5a0fl1cB1K5zggdkWOSGh+96PqR4SxqFVDe
         fvpzIOyv+Aa0WQJopul54plI5TGP97siH5RvMXAvtyzBBvcDZK32toG7bW87qsX9gV/5
         KIuT3KcCAM/FsAQAuTM9baJlPYdC/e7Ym6OJFfpCmHmi8Cd2ltHhlSct8YsXBZeVR7C2
         WsiMZmdl3z1CZTB/lkX5/tdMv/ZrOOH+mj8ED3ObcOSF8qvDDrHk1lOoKcX/EX3nGX6d
         hdbLtKztMLiELfN1j+HlBgXinMVb/QcBf+8h91qGpPzu9qTpfv2RA47cRjWmpkMR5bK+
         awEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691051694; x=1691656494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6kMReHmvqASQi9h76AGb1J6S3mur9uz2u2XL40ZYDh4=;
        b=J9M68V7Wt1nlXCBhE7/7I4lvsoQkUZTXNp82PGWEw2d15o3P4qzZvxWyv+5E+PYOoQ
         UMmDXR5wjoCfglTXkLiIfLvPYOccakiO3/mh5wx/wqNh5uPyCjmIeTVUgBntF6WxJ+9P
         U2c3kjgQw2Y9d0HE0R2NXp5jVfIukslLWUSek7hlFW23iBtrDxKz1GIGiKFQEjSjMZAs
         euSBTTjeLql1DzAFgU3RL2B1SjNXPgdWqnnV+93CuBJut3I7/p4Fjhec0t5LtvZyA+o4
         9DwsEdHltpBzajbPzYc7VIYnmHpAzCsYV+YimgfnZN1GHCIJ2QUmWCDhEmoaJn5GSJd8
         hTLg==
X-Gm-Message-State: ABy/qLZqRiq/i+Vo40otJQCpyo9++ZZy3RiDCiuCSWYZw41jSzlIcVBq
        X1r837KWMrVn52N51x9W+Z8=
X-Google-Smtp-Source: APBJJlElSdDYp/3xKx+PF1BzZ3wqpMKqVpRMewPJoAyuD4GgKGFSGb240pSsKI0qwT+TQ+w5lYbHjw==
X-Received: by 2002:a05:6a20:2c98:b0:134:1011:8582 with SMTP id g24-20020a056a202c9800b0013410118582mr15334413pzj.47.1691051693857;
        Thu, 03 Aug 2023 01:34:53 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.83])
        by smtp.googlemail.com with ESMTPSA id r6-20020a63b106000000b00563feb7113dsm12541876pgf.91.2023.08.03.01.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 01:34:53 -0700 (PDT)
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
        linux-trace-kernel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Subject: [RFC PATCH v6 4/5] sched, tracing: add to report task state in symbolic chars
Date:   Thu,  3 Aug 2023 04:33:51 -0400
Message-ID: <20230803083352.1585-5-zegao@tencent.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803083352.1585-1-zegao@tencent.com>
References: <20230803083352.1585-1-zegao@tencent.com>
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
 include/trace/events/sched.h | 44 ++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 43492daefa6f..ae5b486cc969 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -6,6 +6,7 @@
 #define _TRACE_SCHED_H
 
 #include <linux/kthread.h>
+#include <linux/sched.h>
 #include <linux/sched/numa_balancing.h>
 #include <linux/tracepoint.h>
 #include <linux/binfmts.h>
@@ -214,6 +215,27 @@ static inline short __trace_sched_switch_state(bool preempt,
 
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
+	WARN_ON_ONCE(p != current);
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
@@ -236,6 +258,7 @@ TRACE_EVENT(sched_switch,
 		__array(	char,	prev_comm,	TASK_COMM_LEN	)
 		__array(	char,	next_comm,	TASK_COMM_LEN	)
 		__field(	short,	prev_state			)
+		__field(	char,	prev_state_char			)
 	),
 
 	TP_fast_assign(
@@ -246,26 +269,13 @@ TRACE_EVENT(sched_switch,
 		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
 		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
 		__entry->prev_state		= __trace_sched_switch_state(preempt, prev_state, prev);
+		__entry->prev_state_char	= __trace_sched_switch_state_char(preempt, prev_state, prev);
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
2.41.0

