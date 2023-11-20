Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2D37F1E3E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 21:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjKTUyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 15:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjKTUys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 15:54:48 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DC0D8;
        Mon, 20 Nov 2023 12:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1700513680;
        bh=3na0my5GwRzgfHKRZqp6LpzRwS8xt8lVMei987Vc0nU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iC8gJ75TzLrVcTnSXyBAFagP0C4E0+TB/V6nyjfSkVXD0UScwBQyX7EMBOr+Uvm3u
         tkNWPlyNX8MOqlvrTCKQszcxN1KSvfJCtBzXbzn++S2o5qriAyXD3+BzePklOEbkVX
         DsvCQlp07ehlxAgkgOQrFcWBlN4tZyD7pRhIc/7nQfGrk+sVczOBprO2dZ/gXU5Gi3
         qCoSduMVLrRIp7pFD9EcCXG2uOiRSai+9Sl5t50CKJIRNy3fdB7MT/T8J/LxfGdH7t
         sQBF27KRHNSIXkAoVZvUVVHY487bW3hYdU3tbGpELkPblfftAQKkSx2KaWY/+a1Yqc
         strOxkyemhTtg==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SZ0B75Vttz1cX7;
        Mon, 20 Nov 2023 15:54:39 -0500 (EST)
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
Subject: [PATCH v4 2/5] tracing/ftrace: Add support for faultable tracepoints
Date:   Mon, 20 Nov 2023 15:54:15 -0500
Message-Id: <20231120205418.334172-3-mathieu.desnoyers@efficios.com>
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
into faultable tracepoints, make sure that ftrace can handle registering
to such tracepoints by explicitly disabling preemption within the ftrace
tracepoint probes to respect the current expectations within ftrace ring
buffer code.

This change does not yet allow ftrace to take page faults per se within
its probe, but allows its existing probes to connect to faultable
tracepoints.

Link: https://lore.kernel.org/lkml/20231002202531.3160-1-mathieu.desnoyers@efficios.com/
Co-developed-by: Michael Jeanson <mjeanson@efficios.com>
Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
 include/trace/trace_events.h | 69 +++++++++++++++++++++++++++++++++---
 kernel/trace/trace_events.c  | 26 ++++++++++----
 2 files changed, 84 insertions(+), 11 deletions(-)

diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index df590eea8ae4..558af4960157 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -45,6 +45,16 @@
 			     PARAMS(print));		       \
 	DEFINE_EVENT(name, name, PARAMS(proto), PARAMS(args));
 
+#undef TRACE_EVENT_MAY_FAULT
+#define TRACE_EVENT_MAY_FAULT(name, proto, args, tstruct, assign, print) \
+	DECLARE_EVENT_CLASS_MAY_FAULT(name,		       \
+			     PARAMS(proto),		       \
+			     PARAMS(args),		       \
+			     PARAMS(tstruct),		       \
+			     PARAMS(assign),		       \
+			     PARAMS(print));		       \
+	DEFINE_EVENT(name, name, PARAMS(proto), PARAMS(args));
+
 #include "stages/stage1_struct_define.h"
 
 #undef DECLARE_EVENT_CLASS
@@ -57,6 +67,11 @@
 									\
 	static struct trace_event_class event_class_##name;
 
+#undef DECLARE_EVENT_CLASS_MAY_FAULT
+#define DECLARE_EVENT_CLASS_MAY_FAULT(name, proto, args, tstruct, assign, print) \
+	DECLARE_EVENT_CLASS(name, PARAMS(proto), PARAMS(args),		\
+			    PARAMS(tstruct), PARAMS(assign), PARAMS(print))
+
 #undef DEFINE_EVENT
 #define DEFINE_EVENT(template, name, proto, args)	\
 	static struct trace_event_call	__used		\
@@ -80,7 +95,7 @@
 #undef TRACE_EVENT_FN_MAY_FAULT
 #define TRACE_EVENT_FN_MAY_FAULT(name, proto, args, tstruct,		\
 		assign, print, reg, unreg)				\
-	TRACE_EVENT(name, PARAMS(proto), PARAMS(args),			\
+	TRACE_EVENT_MAY_FAULT(name, PARAMS(proto), PARAMS(args),	\
 		PARAMS(tstruct), PARAMS(assign), PARAMS(print))		\
 
 #undef TRACE_EVENT_FN_COND
@@ -123,6 +138,11 @@
 		tstruct;						\
 	};
 
+#undef DECLARE_EVENT_CLASS_MAY_FAULT
+#define DECLARE_EVENT_CLASS_MAY_FAULT(call, proto, args, tstruct, assign, print) \
+	DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args),		\
+			    PARAMS(tstruct), PARAMS(assign), PARAMS(print))
+
 #undef DEFINE_EVENT
 #define DEFINE_EVENT(template, name, proto, args)
 
@@ -214,6 +234,11 @@ static struct trace_event_functions trace_event_type_funcs_##call = {	\
 	.trace			= trace_raw_output_##call,		\
 };
 
+#undef DECLARE_EVENT_CLASS_MAY_FAULT
+#define DECLARE_EVENT_CLASS_MAY_FAULT(call, proto, args, tstruct, assign, print) \
+	DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args),		\
+			    PARAMS(tstruct), PARAMS(assign), PARAMS(print))
+
 #undef DEFINE_EVENT_PRINT
 #define DEFINE_EVENT_PRINT(template, call, proto, args, print)		\
 static notrace enum print_line_t					\
@@ -250,6 +275,11 @@ static struct trace_event_fields trace_event_fields_##call[] = {	\
 	tstruct								\
 	{} };
 
+#undef DECLARE_EVENT_CLASS_MAY_FAULT
+#define DECLARE_EVENT_CLASS_MAY_FAULT(call, proto, args, tstruct, assign, print) \
+	DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args),		\
+			    PARAMS(tstruct), PARAMS(assign), PARAMS(print))
+
 #undef DEFINE_EVENT_PRINT
 #define DEFINE_EVENT_PRINT(template, name, proto, args, print)
 
@@ -271,6 +301,11 @@ static inline notrace int trace_event_get_offsets_##call(		\
 	return __data_size;						\
 }
 
+#undef DECLARE_EVENT_CLASS_MAY_FAULT
+#define DECLARE_EVENT_CLASS_MAY_FAULT(call, proto, args, tstruct, assign, print) \
+	DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args),		\
+			    PARAMS(tstruct), PARAMS(assign), PARAMS(print))
+
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
 
 /*
@@ -380,8 +415,8 @@ static inline notrace int trace_event_get_offsets_##call(		\
 
 #include "stages/stage6_event_callback.h"
 
-#undef DECLARE_EVENT_CLASS
-#define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
+#undef _DECLARE_EVENT_CLASS
+#define _DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print, tp_flags) \
 									\
 static notrace void							\
 trace_event_raw_event_##call(void *__data, proto)			\
@@ -392,8 +427,13 @@ trace_event_raw_event_##call(void *__data, proto)			\
 	struct trace_event_raw_##call *entry;				\
 	int __data_size;						\
 									\
+	if ((tp_flags) & TRACEPOINT_MAY_FAULT) {			\
+		might_fault();						\
+		preempt_disable_notrace();				\
+	}								\
+									\
 	if (trace_trigger_soft_disabled(trace_file))			\
-		return;							\
+		goto end;						\
 									\
 	__data_size = trace_event_get_offsets_##call(&__data_offsets, args); \
 									\
@@ -401,14 +441,28 @@ trace_event_raw_event_##call(void *__data, proto)			\
 				 sizeof(*entry) + __data_size);		\
 									\
 	if (!entry)							\
-		return;							\
+		goto end;						\
 									\
 	tstruct								\
 									\
 	{ assign; }							\
 									\
 	trace_event_buffer_commit(&fbuffer);				\
+end:									\
+	if ((tp_flags) & TRACEPOINT_MAY_FAULT)				\
+		preempt_enable_notrace();				\
 }
+
+#undef DECLARE_EVENT_CLASS
+#define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
+	_DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args),		\
+			    PARAMS(tstruct), PARAMS(assign), PARAMS(print), 0)
+
+#undef DECLARE_EVENT_CLASS_MAY_FAULT
+#define DECLARE_EVENT_CLASS_MAY_FAULT(call, proto, args, tstruct, assign, print) \
+	_DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args),		\
+			    PARAMS(tstruct), PARAMS(assign), PARAMS(print), TRACEPOINT_MAY_FAULT)
+
 /*
  * The ftrace_test_probe is compiled out, it is only here as a build time check
  * to make sure that if the tracepoint handling changes, the ftrace probe will
@@ -440,6 +494,11 @@ static struct trace_event_class __used __refdata event_class_##call = { \
 	_TRACE_PERF_INIT(call)						\
 };
 
+#undef DECLARE_EVENT_CLASS_MAY_FAULT
+#define DECLARE_EVENT_CLASS_MAY_FAULT(call, proto, args, tstruct, assign, print) \
+	DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args),		\
+			    PARAMS(tstruct), PARAMS(assign), PARAMS(print))
+
 #undef DEFINE_EVENT
 #define DEFINE_EVENT(template, call, proto, args)			\
 									\
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 82cb22ad6d61..954f87515668 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -532,9 +532,16 @@ int trace_event_reg(struct trace_event_call *call,
 	WARN_ON(!(call->flags & TRACE_EVENT_FL_TRACEPOINT));
 	switch (type) {
 	case TRACE_REG_REGISTER:
-		return tracepoint_probe_register(call->tp,
-						 call->class->probe,
-						 file);
+		if (call->tp->flags & TRACEPOINT_MAY_FAULT)
+			return tracepoint_probe_register_prio_flags(call->tp,
+								    call->class->probe,
+								    file,
+								    TRACEPOINT_DEFAULT_PRIO,
+								    TRACEPOINT_MAY_FAULT);
+		else
+			return tracepoint_probe_register(call->tp,
+							 call->class->probe,
+							 file);
 	case TRACE_REG_UNREGISTER:
 		tracepoint_probe_unregister(call->tp,
 					    call->class->probe,
@@ -543,9 +550,16 @@ int trace_event_reg(struct trace_event_call *call,
 
 #ifdef CONFIG_PERF_EVENTS
 	case TRACE_REG_PERF_REGISTER:
-		return tracepoint_probe_register(call->tp,
-						 call->class->perf_probe,
-						 call);
+		if (call->tp->flags & TRACEPOINT_MAY_FAULT)
+			return tracepoint_probe_register_prio_flags(call->tp,
+								    call->class->perf_probe,
+								    call,
+								    TRACEPOINT_DEFAULT_PRIO,
+								    TRACEPOINT_MAY_FAULT);
+		else
+			return tracepoint_probe_register(call->tp,
+							 call->class->perf_probe,
+							 call);
 	case TRACE_REG_PERF_UNREGISTER:
 		tracepoint_probe_unregister(call->tp,
 					    call->class->perf_probe,
-- 
2.25.1

