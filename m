Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D1B7F1E3F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 21:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjKTUyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 15:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjKTUys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 15:54:48 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F2DDC;
        Mon, 20 Nov 2023 12:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1700513680;
        bh=Daj+/1NhYCfniiA2tUuq6iASXun5yE8kO5F1mYx3zX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UVLZmdzA+6t/55WMLsBXzqGOH8ntevxRZQqooyook/p6evO7BV6kRTHOkHQSjrDyh
         sgj8aO9h/0cs/5EmYRRmMU+kJLDaFW2SgpvGgEOIBgiEXZTnSylEfkU0GuZIOZMkNb
         E1JKWFH4vgz4bgrLhBUih5or6T0ROIy4GtJAoVxvnPgYdwBS0MF9VDjU2mtNI9ExGT
         CUUTDmJeyPtUKOrDfSkGlB/e977Z9bUpqJSVAKZSlPZnyCRPi7kX5e0cLMm/pPXN+k
         VfGPh9tcOOJ1RZaPQVb6xxx4DzDe7YDytJvsIjmuxUkk94Rjn+DJY/yMvpjjEqDMoZ
         /ebfrTLj3uixQ==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SZ0B83q4Sz1cb0;
        Mon, 20 Nov 2023 15:54:40 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
Subject: [PATCH v4 4/5] tracing/perf: add support for faultable tracepoints
Date:   Mon, 20 Nov 2023 15:54:17 -0500
Message-Id: <20231120205418.334172-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231120205418.334172-1-mathieu.desnoyers@efficios.com>
References: <20231120205418.334172-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for converting system call enter/exit instrumentation
into faultable tracepoints, make sure that perf can handle registering
to such tracepoints by explicitly disabling preemption within the perf
tracepoint probes to respect the current expectations within perf ring
buffer code.

This change does not yet allow perf to take page faults per se within
its probe, but allows its existing probes to connect to faultable
tracepoints.

Link: https://lore.kernel.org/lkml/20231002202531.3160-1-mathieu.desnoyers@efficios.com/
Co-developed-by: Michael Jeanson <mjeanson@efficios.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: bpf@vger.kernel.org
Cc: Joel Fernandes <joel@joelfernandes.org>
---
 include/trace/perf.h | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/include/trace/perf.h b/include/trace/perf.h
index 2c11181c82e0..fb47815f6eff 100644
--- a/include/trace/perf.h
+++ b/include/trace/perf.h
@@ -12,8 +12,8 @@
 #undef __perf_task
 #define __perf_task(t)	(__task = (t))
 
-#undef DECLARE_EVENT_CLASS
-#define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
+#undef _DECLARE_EVENT_CLASS
+#define _DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print, tp_flags) \
 static notrace void							\
 perf_trace_##call(void *__data, proto)					\
 {									\
@@ -28,13 +28,18 @@ perf_trace_##call(void *__data, proto)					\
 	int __data_size;						\
 	int rctx;							\
 									\
+	if ((tp_flags) & TRACEPOINT_MAY_FAULT) {			\
+		might_fault();						\
+		preempt_disable_notrace();				\
+	}								\
+									\
 	__data_size = trace_event_get_offsets_##call(&__data_offsets, args); \
 									\
 	head = this_cpu_ptr(event_call->perf_events);			\
 	if (!bpf_prog_array_valid(event_call) &&			\
 	    __builtin_constant_p(!__task) && !__task &&			\
 	    hlist_empty(head))						\
-		return;							\
+		goto end;						\
 									\
 	__entry_size = ALIGN(__data_size + sizeof(*entry) + sizeof(u32),\
 			     sizeof(u64));				\
@@ -42,7 +47,7 @@ perf_trace_##call(void *__data, proto)					\
 									\
 	entry = perf_trace_buf_alloc(__entry_size, &__regs, &rctx);	\
 	if (!entry)							\
-		return;							\
+		goto end;						\
 									\
 	perf_fetch_caller_regs(__regs);					\
 									\
@@ -53,8 +58,22 @@ perf_trace_##call(void *__data, proto)					\
 	perf_trace_run_bpf_submit(entry, __entry_size, rctx,		\
 				  event_call, __count, __regs,		\
 				  head, __task);			\
+end:									\
+	if ((tp_flags) & TRACEPOINT_MAY_FAULT)				\
+		preempt_enable_notrace();				\
 }
 
+#undef DECLARE_EVENT_CLASS
+#define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
+	_DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args),		\
+			     PARAMS(tstruct), PARAMS(assign), PARAMS(print), 0)
+
+#undef DECLARE_EVENT_CLASS_MAY_FAULT
+#define DECLARE_EVENT_CLASS_MAY_FAULT(call, proto, args, tstruct, assign, print) \
+	_DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args),		\
+			     PARAMS(tstruct), PARAMS(assign), PARAMS(print), \
+			     TRACEPOINT_MAY_FAULT)
+
 /*
  * This part is compiled out, it is only here as a build time check
  * to make sure that if the tracepoint handling changes, the
-- 
2.25.1

