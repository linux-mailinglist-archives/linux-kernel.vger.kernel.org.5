Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1937F1E3D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 21:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjKTUyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 15:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjKTUys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 15:54:48 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51F2CF;
        Mon, 20 Nov 2023 12:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1700513680;
        bh=T7Nr4r/6B9r8V/IXWfdEL5nzZ2OVp6Lt4IjgQKAxAJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oLQ5Jv2JPcwEa+icp0BZjOHxsNfVcK1LCUYVoZE6SmDGbC4oUBOBiPOLXxmGi1tSE
         TTU0pgrcELQpQZNXJeXv4CTpqZFJHcp1M9apNGovdE+d3p5eYKVkUlA5EG5cyxu5UL
         p4gsrZ6RFVRKcyBBpvaCkTTadHxj81t2Brg5uj9sDR/R7sEBe4EPIGcIFDUV8IfDAp
         a70A5F4j9Fny9L/8f8YtOA7slJQRCi4yiVbOj8gbledJttrdjEBXKMSuX1j02u9uTe
         eMkqMQT8uVVGDjAWOv6dbzwU4Ez0kp/RrMECEjt+0iB337XZoXPL+CrnboG4fquTxp
         QeQa34EMelXAQ==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SZ0B80w7Zz1cy0;
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
Subject: [PATCH v4 3/5] tracing/bpf-trace: add support for faultable tracepoints
Date:   Mon, 20 Nov 2023 15:54:16 -0500
Message-Id: <20231120205418.334172-4-mathieu.desnoyers@efficios.com>
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
into faultable tracepoints, make sure that bpf can handle registering to
such tracepoints by explicitly disabling preemption within the bpf
tracepoint probes to respect the current expectations within bpf tracing
code.

This change does not yet allow bpf to take page faults per se within its
probe, but allows its existing probes to connect to faultable
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
 include/trace/bpf_probe.h | 21 +++++++++++++++++----
 kernel/trace/bpf_trace.c  | 11 ++++++++---
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index e609cd7da47e..dd4b42715e5d 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -42,17 +42,30 @@
 /* tracepoints with more than 12 arguments will hit build error */
 #define CAST_TO_U64(...) CONCATENATE(__CAST, COUNT_ARGS(__VA_ARGS__))(__VA_ARGS__)
 
-#define __BPF_DECLARE_TRACE(call, proto, args)				\
+#define __BPF_DECLARE_TRACE(call, proto, args, tp_flags)		\
 static notrace void							\
 __bpf_trace_##call(void *__data, proto)					\
 {									\
 	struct bpf_prog *prog = __data;					\
+									\
+	if ((tp_flags) & TRACEPOINT_MAY_FAULT) {			\
+		might_fault();						\
+		preempt_disable_notrace();				\
+	}								\
+									\
 	CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_TO_U64(args));	\
+									\
+	if ((tp_flags) & TRACEPOINT_MAY_FAULT)				\
+		preempt_enable_notrace();				\
 }
 
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
-	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args))
+	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args), 0)
+
+#undef DECLARE_EVENT_CLASS_MAY_FAULT
+#define DECLARE_EVENT_CLASS_MAY_FAULT(call, proto, args, tstruct, assign, print) \
+	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args), TRACEPOINT_MAY_FAULT)
 
 /*
  * This part is compiled out, it is only here as a build time check
@@ -106,13 +119,13 @@ static inline void bpf_test_buffer_##call(void)				\
 
 #undef DECLARE_TRACE
 #define DECLARE_TRACE(call, proto, args)				\
-	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args))		\
+	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args), 0)	\
 	__DEFINE_EVENT(call, call, PARAMS(proto), PARAMS(args), 0)
 
 #undef DECLARE_TRACE_WRITABLE
 #define DECLARE_TRACE_WRITABLE(call, proto, args, size) \
 	__CHECK_WRITABLE_BUF_SIZE(call, PARAMS(proto), PARAMS(args), size) \
-	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args)) \
+	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args), 0) \
 	__DEFINE_EVENT(call, call, PARAMS(proto), PARAMS(args), size)
 
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 344a41873445..1eb770dafa8a 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2368,9 +2368,14 @@ static int __bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *
 	if (prog->aux->max_tp_access > btp->writable_size)
 		return -EINVAL;
 
-	return tracepoint_probe_register_prio_flags(tp, (void *)btp->bpf_func,
-						    prog, TRACEPOINT_DEFAULT_PRIO,
-						    TRACEPOINT_MAY_EXIST);
+	if (tp->flags & TRACEPOINT_MAY_FAULT)
+		return tracepoint_probe_register_prio_flags(tp, (void *)btp->bpf_func,
+							    prog, TRACEPOINT_DEFAULT_PRIO,
+							    TRACEPOINT_MAY_EXIST | TRACEPOINT_MAY_FAULT);
+	else
+		return tracepoint_probe_register_prio_flags(tp, (void *)btp->bpf_func,
+							    prog, TRACEPOINT_DEFAULT_PRIO,
+							    TRACEPOINT_MAY_EXIST);
 }
 
 int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
-- 
2.25.1

