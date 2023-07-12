Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BF3751322
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 00:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjGLWBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 18:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjGLWBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 18:01:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0926B1FDE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:01:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9056F61964
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 22:00:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E07C433C7;
        Wed, 12 Jul 2023 22:00:58 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qJhtJ-000Qip-0w;
        Wed, 12 Jul 2023 18:00:57 -0400
Message-ID: <20230712220057.107996460@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 12 Jul 2023 17:50:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [for-linus][PATCH 2/5] tracing: arm64: Avoid missing-prototype warnings
References: <20230712215044.496021196@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

These are all tracing W=1 warnings in arm64 allmodconfig about missing
prototypes:

kernel/trace/trace_kprobe_selftest.c:7:5: error: no previous prototype for 'kprobe_trace_selftest_target' [-Werror=missing-pro
totypes]
kernel/trace/ftrace.c:329:5: error: no previous prototype for '__register_ftrace_function' [-Werror=missing-prototypes]
kernel/trace/ftrace.c:372:5: error: no previous prototype for '__unregister_ftrace_function' [-Werror=missing-prototypes]
kernel/trace/ftrace.c:4130:15: error: no previous prototype for 'arch_ftrace_match_adjust' [-Werror=missing-prototypes]
kernel/trace/fgraph.c:243:15: error: no previous prototype for 'ftrace_return_to_handler' [-Werror=missing-prototypes]
kernel/trace/fgraph.c:358:6: error: no previous prototype for 'ftrace_graph_sleep_time_control' [-Werror=missing-prototypes]
arch/arm64/kernel/ftrace.c:460:6: error: no previous prototype for 'prepare_ftrace_return' [-Werror=missing-prototypes]
arch/arm64/kernel/ptrace.c:2172:5: error: no previous prototype for 'syscall_trace_enter' [-Werror=missing-prototypes]
arch/arm64/kernel/ptrace.c:2195:6: error: no previous prototype for 'syscall_trace_exit' [-Werror=missing-prototypes]

Move the declarations to an appropriate header where they can be seen
by the caller and callee, and make sure the headers are included where
needed.

Link: https://lore.kernel.org/linux-trace-kernel/20230517125215.930689-1-arnd@kernel.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Florent Revest <revest@chromium.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
[ Fixed ftrace_return_to_handler() to handle CONFIG_HAVE_FUNCTION_GRAPH_RETVAL case ]
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/arm64/include/asm/ftrace.h      | 4 ++++
 arch/arm64/include/asm/syscall.h     | 3 +++
 arch/arm64/kernel/syscall.c          | 3 ---
 include/linux/ftrace.h               | 9 +++++++++
 kernel/trace/fgraph.c                | 1 +
 kernel/trace/ftrace_internal.h       | 5 +++--
 kernel/trace/trace_kprobe_selftest.c | 3 +++
 7 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index 21ac1c5c71d3..ab158196480c 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -211,6 +211,10 @@ static inline unsigned long fgraph_ret_regs_frame_pointer(struct fgraph_ret_regs
 {
 	return ret_regs->fp;
 }
+
+void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
+			   unsigned long frame_pointer);
+
 #endif /* ifdef CONFIG_FUNCTION_GRAPH_TRACER  */
 #endif
 
diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index 4cfe9b49709b..ab8e14b96f68 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -85,4 +85,7 @@ static inline int syscall_get_arch(struct task_struct *task)
 	return AUDIT_ARCH_AARCH64;
 }
 
+int syscall_trace_enter(struct pt_regs *regs);
+void syscall_trace_exit(struct pt_regs *regs);
+
 #endif	/* __ASM_SYSCALL_H */
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 5a668d7f3c1f..b1ae2f2eaf77 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -75,9 +75,6 @@ static inline bool has_syscall_work(unsigned long flags)
 	return unlikely(flags & _TIF_SYSCALL_WORK);
 }
 
-int syscall_trace_enter(struct pt_regs *regs);
-void syscall_trace_exit(struct pt_regs *regs);
-
 static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 			   const syscall_fn_t syscall_table[])
 {
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 8e59bd954153..ce156c7704ee 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -41,6 +41,15 @@ struct ftrace_ops;
 struct ftrace_regs;
 struct dyn_ftrace;
 
+char *arch_ftrace_match_adjust(char *str, const char *search);
+
+#ifdef CONFIG_HAVE_FUNCTION_GRAPH_RETVAL
+struct fgraph_ret_regs;
+unsigned long ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs);
+#else
+unsigned long ftrace_return_to_handler(unsigned long frame_pointer);
+#endif
+
 #ifdef CONFIG_FUNCTION_TRACER
 /*
  * If the arch's mcount caller does not support all of ftrace's
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index cd2c35b1dd8f..c83c005e654e 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -15,6 +15,7 @@
 #include <trace/events/sched.h>
 
 #include "ftrace_internal.h"
+#include "trace.h"
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 #define ASSIGN_OPS_HASH(opsname, val) \
diff --git a/kernel/trace/ftrace_internal.h b/kernel/trace/ftrace_internal.h
index 382775edf690..5012c04f92c0 100644
--- a/kernel/trace/ftrace_internal.h
+++ b/kernel/trace/ftrace_internal.h
@@ -2,6 +2,9 @@
 #ifndef _LINUX_KERNEL_FTRACE_INTERNAL_H
 #define  _LINUX_KERNEL_FTRACE_INTERNAL_H
 
+int __register_ftrace_function(struct ftrace_ops *ops);
+int __unregister_ftrace_function(struct ftrace_ops *ops);
+
 #ifdef CONFIG_FUNCTION_TRACER
 
 extern struct mutex ftrace_lock;
@@ -15,8 +18,6 @@ int ftrace_ops_test(struct ftrace_ops *ops, unsigned long ip, void *regs);
 
 #else /* !CONFIG_DYNAMIC_FTRACE */
 
-int __register_ftrace_function(struct ftrace_ops *ops);
-int __unregister_ftrace_function(struct ftrace_ops *ops);
 /* Keep as macros so we do not need to define the commands */
 # define ftrace_startup(ops, command)					\
 	({								\
diff --git a/kernel/trace/trace_kprobe_selftest.c b/kernel/trace/trace_kprobe_selftest.c
index 16548ee4c8c6..3851cd1e6a62 100644
--- a/kernel/trace/trace_kprobe_selftest.c
+++ b/kernel/trace/trace_kprobe_selftest.c
@@ -1,4 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+
+#include "trace_kprobe_selftest.h"
+
 /*
  * Function used during the kprobe self test. This function is in a separate
  * compile unit so it can be compile with CC_FLAGS_FTRACE to ensure that it
-- 
2.40.1
