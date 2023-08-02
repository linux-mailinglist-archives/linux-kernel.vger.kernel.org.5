Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7158276CC62
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbjHBMMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbjHBMMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:12:05 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D252D4E;
        Wed,  2 Aug 2023 05:11:46 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b8ad356f03so42082075ad.1;
        Wed, 02 Aug 2023 05:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690978305; x=1691583105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CM5cahXoMpsce0ksxrUnsFD5Y5C6ho7KAY2TXexFWA=;
        b=gdF734EWkU9OnMkBaivwtHzXYRbnETPo8fXWApDkqnoLjTTcWM52zjCepXhgLv60rX
         uu+x/g2BUXJVYS4AHV6VldapUIFlSNcOljFQqaMKw0OXopwyC+t07nuB2NQrQrUGwpKP
         3Ba26I0T0zih86GAv8qkWRqlzQH+z8sFvK61LfO5j3JqTDt8klfrTPz+RU80nVnUffd0
         QvRbFRRxg7LKp62u8xqpyHTG9b/hD8GX1fop07TZQfZggg8W0UQ4OSXBZgTQtolVFA4a
         gvHpGxkwcgKxiG1t5NU358WhWE3oGtkMSOGtPTdW28a7NrY5201jmIBcUIY5EcPC0OIn
         uBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690978305; x=1691583105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4CM5cahXoMpsce0ksxrUnsFD5Y5C6ho7KAY2TXexFWA=;
        b=iUq0hEQel3C7sT+VaOqmJE39TWp2PJSD673kKWVgaeHS0rL2eTdLL2zPsWPK2q5Ku+
         tcjgBtza12cpjwTvUhdGF5onTvUw2CrNMczhe8PvNsWmLoUkNdl+b/ESqXB++QHF5GUz
         7ABJYY+fednX1tmq/cMqAo8SyuCAyYlGWzgFWwekBv6kxgKCvw9YGT91mjug1WQy5PK7
         sOEt0gqQFpwY2iVIpTR22BDsFN1NhNTAQdID0MyJba9tl8PtBgqX/hFMhCtkEWbuBfjX
         Z3z8LwTkXyLQ/DwYKJsVnHbBwdS2LHZOsgXIal3ACQOJGIqvEZUumeu0jqh3Sw/QTMwi
         ravw==
X-Gm-Message-State: ABy/qLYrdQpluuCYlUszfqmVRFX1eCqJb5QF47Ee85uF78wY042CmhPR
        QfN8ccNTK2KG7i7IScUnzP8=
X-Google-Smtp-Source: APBJJlEVUkNyVhX5WkJf04Si93Ho7Ne7U3pFFbhVk7WPxbfjWoZHEDISUAcKgSu/O3EmWF5E3lRlAg==
X-Received: by 2002:a17:903:1cb:b0:1b8:9044:9ede with SMTP id e11-20020a17090301cb00b001b890449edemr16848580plh.62.1690978305253;
        Wed, 02 Aug 2023 05:11:45 -0700 (PDT)
Received: from localhost.localdomain ([43.132.98.115])
        by smtp.googlemail.com with ESMTPSA id kx14-20020a170902f94e00b001b890009634sm12293173plb.139.2023.08.02.05.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 05:11:44 -0700 (PDT)
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
        linux-trace-devel@vger.kernel.org, Ze Gao <zegao2021@gmail.com>,
        Ze Gao <zegao@tencent.com>
Subject: [RFC PATCH v4 5/7] sched, tracing: add to report task state in symbolic chars
Date:   Wed,  2 Aug 2023 08:10:00 -0400
Message-ID: <20230802121116.324604-6-zegao@tencent.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802121116.324604-1-zegao@tencent.com>
References: <20230802121116.324604-1-zegao@tencent.com>
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

From: Ze Gao <zegao2021@gmail.com>

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
index 7d34db20b2c6..1c7b94793495 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -6,6 +6,7 @@
 #define _TRACE_SCHED_H
 
 #include <linux/kthread.h>
+#include <linux/sched.h>
 #include <linux/sched/numa_balancing.h>
 #include <linux/tracepoint.h>
 #include <linux/binfmts.h>
@@ -214,6 +215,27 @@ static inline int __trace_sched_switch_state(bool preempt,
 
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
@@ -236,6 +258,7 @@ TRACE_EVENT(sched_switch,
 		__field(	int,	prev_state			)
 		__array(	char,	prev_comm,	TASK_COMM_LEN	)
 		__array(	char,	next_comm,	TASK_COMM_LEN	)
+		__field(	char,	prev_state_char			)
 	),
 
 	TP_fast_assign(
@@ -246,26 +269,13 @@ TRACE_EVENT(sched_switch,
 		__entry->prev_state		= __trace_sched_switch_state(preempt, prev_state, prev);
 		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
 		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
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

