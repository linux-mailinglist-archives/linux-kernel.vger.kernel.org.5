Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9387E779D4C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 07:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbjHLFhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 01:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjHLFhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 01:37:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41A42D5B;
        Fri, 11 Aug 2023 22:37:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B5D96405A;
        Sat, 12 Aug 2023 05:37:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11119C433C7;
        Sat, 12 Aug 2023 05:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691818637;
        bh=idoIszjUW0P8tm6vGK/1+jb2ZV7Bg8zd/p0KkM3vUyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T8QpAqBUkuiM8RM10CjO0bt6F+snrisBlXE96ECG4iI7Sklb0ivWpTnhtT34R4+mJ
         O9GxVbEbXVSDQQnr7kMWSewhwrvuBaNn3hM4qhlsIScmNC9B8hkH3X9N3OrVcFQ4aS
         PcJTEabk6rqtNWjvZMDa42EQ+NiKF3C+YPrZlYKaxx1zWWvZTE6nbYg43ULi5GOgQB
         mFUMdD94N66E7kutMiEt4xzugICbCWFsE5r32PgDcj0p88k7EUIdFP6/BWEd0stHvB
         m6BcyjWwM3EUT70bOuy0v4Ir1zV2pBKGpL6NLmxOzbFVkEL4E3BOZYreaVyBUm2PyR
         ZA0NJRoP2bkNw==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>
Cc:     linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3 3/8] tracing: Expose ftrace_regs regardless of CONFIG_FUNCTION_TRACER
Date:   Sat, 12 Aug 2023 14:37:11 +0900
Message-Id: <169181863118.505132.13233554057378608176.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169181859570.505132.10136520092011157898.stgit@devnote2>
References: <169181859570.505132.10136520092011157898.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

In order to be able to use ftrace_regs even from features unrelated to
function tracer (e.g. kretprobe), expose ftrace_regs structures and
APIs even if the CONFIG_FUNCTION_TRACER=n.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - arch/s390/include/asm/ftrace.h: hide ftrace_regs parts if
    CONFIG_FUNCTION_TRACER=n to avoid conflict.
  - Fixed typo.
  - Define accessor macros only if HAVE_REGS_AND_STACK_ACCESS_API=y
---
 arch/s390/include/asm/ftrace.h |    4 +++
 include/linux/ftrace.h         |   51 +++++++++++++++++++++++-----------------
 2 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index e5c5cb1207e2..74cd2e8bf660 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -41,6 +41,8 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 	return addr;
 }
 
+#ifdef CONFIG_FUNCTION_TRACER
+
 struct ftrace_regs {
 	struct pt_regs regs;
 };
@@ -80,6 +82,8 @@ ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
 #define ftrace_regs_query_register_offset(name) \
 	regs_query_register_offset(name)
 
+#endif /* CONFIG_FUNCTION_TRACER */
+
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 /*
  * When an ftrace registered caller is tracing a function that is
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index aad9cf8876b5..fe335d861f08 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -112,24 +112,44 @@ static inline int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *val
 }
 #endif
 
-#ifdef CONFIG_FUNCTION_TRACER
-
-extern int ftrace_enabled;
-
-#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
+/*
+ * If the architecture doesn't support FTRACE_WITH_ARGS or disables function
+ * tracer, define the default(pt_regs compatible) ftrace_regs.
+ */
+#if !defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS) || !defined(CONFIG_FUNCTION_TRACER)
 
 struct ftrace_regs {
 	struct pt_regs		regs;
 };
 #define arch_ftrace_get_regs(fregs) (&(fregs)->regs)
 
+#ifdef CONFIG_HAVE_REGS_AND_STACK_ACCESS_API
+
 /*
  * ftrace_regs_set_instruction_pointer() is to be defined by the architecture
  * if to allow setting of the instruction pointer from the ftrace_regs when
  * HAVE_DYNAMIC_FTRACE_WITH_ARGS is set and it supports live kernel patching.
  */
 #define ftrace_regs_set_instruction_pointer(fregs, ip) do { } while (0)
-#endif /* CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
+
+#define ftrace_regs_get_instruction_pointer(fregs) \
+	instruction_pointer(ftrace_get_regs(fregs))
+#define ftrace_regs_get_argument(fregs, n) \
+	regs_get_kernel_argument(ftrace_get_regs(fregs), n)
+#define ftrace_regs_get_stack_pointer(fregs) \
+	kernel_stack_pointer(ftrace_get_regs(fregs))
+#define ftrace_regs_return_value(fregs) \
+	regs_return_value(ftrace_get_regs(fregs))
+#define ftrace_regs_set_return_value(fregs, ret) \
+	regs_set_return_value(ftrace_get_regs(fregs), ret)
+#define ftrace_override_function_with_return(fregs) \
+	override_function_with_return(ftrace_get_regs(fregs))
+#define ftrace_regs_query_register_offset(name) \
+	regs_query_register_offset(name)
+
+#endif /* CONFIG_HAVE_REGS_AND_STACK_ACCESS_API */
+
+#endif /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS || !CONFIG_FUNCTION_TRACER */
 
 static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs)
 {
@@ -151,22 +171,9 @@ static __always_inline bool ftrace_regs_has_args(struct ftrace_regs *fregs)
 	return ftrace_get_regs(fregs) != NULL;
 }
 
-#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
-#define ftrace_regs_get_instruction_pointer(fregs) \
-	instruction_pointer(ftrace_get_regs(fregs))
-#define ftrace_regs_get_argument(fregs, n) \
-	regs_get_kernel_argument(ftrace_get_regs(fregs), n)
-#define ftrace_regs_get_stack_pointer(fregs) \
-	kernel_stack_pointer(ftrace_get_regs(fregs))
-#define ftrace_regs_return_value(fregs) \
-	regs_return_value(ftrace_get_regs(fregs))
-#define ftrace_regs_set_return_value(fregs, ret) \
-	regs_set_return_value(ftrace_get_regs(fregs), ret)
-#define ftrace_override_function_with_return(fregs) \
-	override_function_with_return(ftrace_get_regs(fregs))
-#define ftrace_regs_query_register_offset(name) \
-	regs_query_register_offset(name)
-#endif
+#ifdef CONFIG_FUNCTION_TRACER
+
+extern int ftrace_enabled;
 
 typedef void (*ftrace_func_t)(unsigned long ip, unsigned long parent_ip,
 			      struct ftrace_ops *op, struct ftrace_regs *fregs);

