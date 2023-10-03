Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDDD7B7190
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240891AbjJCTMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjJCTMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:12:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A0DAB;
        Tue,  3 Oct 2023 12:12:07 -0700 (PDT)
Date:   Tue, 03 Oct 2023 19:12:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696360325;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZiuIjzhULYb++Sz/gf3FymRM2kPnoPLrH56y/eRzH6s=;
        b=Evnj5LzqhY5kfveDjv6VsYqH/yYw2XD9gbbWYRD0yGrIgvCG2L1Q3VbtgBBcq1jBuQu7Zu
        doNoMxQODv/D+/upv/TQYRU17J7WkOuCDSBJqZKqkofXHssnbrF1q7ZcFPjYdq70uHOufP
        eMIedQJA/+OmstISvts1fkZvzw32Ag4Iv3ZgJ/I+nmivnpGP5/6yP9FKejfrN1O1ZGdlpA
        eoGcD2BmJRtpaO3/kqrVbl/j84fsvEqzgFI1a6yEYC0PULVb8mpCbaIcYoVccWj9G2N+7e
        g8bEzbmDilds5ToKbuc08jNSiPwKdt/J9mZ9MHomoTG7LhIlS0VtsxnUcQEJWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696360325;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZiuIjzhULYb++Sz/gf3FymRM2kPnoPLrH56y/eRzH6s=;
        b=pfEE9vcUzazGrwte6M4njkYXo9KfyL6l5pgoDaa5XBhjw7av5E3yhAfW7V5LWQk5x9Y5W7
        vdWgfN1VAsQewEAw==
From:   "tip-bot2 for Alexey Dobriyan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] selftests/x86/mm: Add new test that userspace stack is
 in fact NX
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <4cef8266-ad6d-48af-a5f1-fc2b6a8eb422@p183>
References: <4cef8266-ad6d-48af-a5f1-fc2b6a8eb422@p183>
MIME-Version: 1.0
Message-ID: <169636032500.3135.7322500264880076617.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     802e87cc464613441f9098ebf940b1895fe3f5e5
Gitweb:        https://git.kernel.org/tip/802e87cc464613441f9098ebf940b1895fe3f5e5
Author:        Alexey Dobriyan <adobriyan@gmail.com>
AuthorDate:    Tue, 03 Oct 2023 19:18:43 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Oct 2023 21:00:45 +02:00

selftests/x86/mm: Add new test that userspace stack is in fact NX

Here is how it works:

 * fault and fill the stack from RSP with INT3 down until rlimit allows,

 * fill upwards with INT3 too, overwrite libc stuff, argv, envp,

 * try to exec INT3 on each page and catch it in either SIGSEGV or
   SIGTRAP handler.

Note: trying to execute _every_ INT3 on a 8 MiB stack takes 30-40 seconds
even on fast machine which is too much for kernel selftesting
(not for LTP!) so only 1 INT3 per page is tried.

Tested on F37 kernel and on a custom kernel which does:

	vm_flags |= VM_EXEC;

to stack VMA.

Report from the buggy kernel:

	$ ./nx_stack_32
	stack min ff007000
	stack max ff807000
	FAIL    executable page on the stack: eip ff806001

	$ ./nx_stack_64
	stack min 7ffe65bb0000
	stack max 7ffe663b0000
	FAIL    executable page on the stack: rip 7ffe663af001

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/4cef8266-ad6d-48af-a5f1-fc2b6a8eb422@p183
---
 tools/testing/selftests/x86/Makefile   |   4 +-
 tools/testing/selftests/x86/nx_stack.c | 212 ++++++++++++++++++++++++-
 2 files changed, 216 insertions(+)
 create mode 100644 tools/testing/selftests/x86/nx_stack.c

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 7e8c937..0b872c0 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -14,6 +14,7 @@ TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap
 			check_initial_reg_state sigreturn iopl ioperm \
 			test_vsyscall mov_ss_trap \
 			syscall_arg_fault fsgsbase_restore sigaltstack
+TARGETS_C_BOTHBITS += nx_stack
 TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
@@ -109,3 +110,6 @@ $(OUTPUT)/test_syscall_vdso_32: thunks_32.S
 # state.
 $(OUTPUT)/check_initial_reg_state_32: CFLAGS += -Wl,-ereal_start -static
 $(OUTPUT)/check_initial_reg_state_64: CFLAGS += -Wl,-ereal_start -static
+
+$(OUTPUT)/nx_stack_32: CFLAGS += -Wl,-z,noexecstack
+$(OUTPUT)/nx_stack_64: CFLAGS += -Wl,-z,noexecstack
diff --git a/tools/testing/selftests/x86/nx_stack.c b/tools/testing/selftests/x86/nx_stack.c
new file mode 100644
index 0000000..ea4a4e2
--- /dev/null
+++ b/tools/testing/selftests/x86/nx_stack.c
@@ -0,0 +1,212 @@
+/*
+ * Copyright (c) 2023 Alexey Dobriyan <adobriyan@gmail.com>
+ *
+ * Permission to use, copy, modify, and distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ */
+/*
+ * Test that userspace stack is NX. Requires linking with -Wl,-z,noexecstack
+ * because I don't want to bother with PT_GNU_STACK detection.
+ *
+ * Fill the stack with INT3's and then try to execute some of them:
+ * SIGSEGV -- good, SIGTRAP -- bad.
+ *
+ * Regular stack is completely overwritten before testing.
+ * Test doesn't exit SIGSEGV handler after first fault at INT3.
+ */
+#undef _GNU_SOURCE
+#define _GNU_SOURCE
+#undef NDEBUG
+#include <assert.h>
+#include <signal.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/mman.h>
+#include <sys/resource.h>
+#include <unistd.h>
+
+#define PAGE_SIZE 4096
+
+/*
+ * This is memset(rsp, 0xcc, -1); but down.
+ * It will SIGSEGV when bottom of the stack is reached.
+ * Byte-size access is important! (see rdi tweak in the signal handler).
+ */
+void make_stack1(void);
+asm(
+".pushsection .text\n"
+".globl make_stack1\n"
+".align 16\n"
+"make_stack1:\n"
+	"mov $0xcc, %al\n"
+#if defined __amd64__
+	"mov %rsp, %rdi\n"
+	"mov $-1, %rcx\n"
+#elif defined __i386__
+	"mov %esp, %edi\n"
+	"mov $-1, %ecx\n"
+#else
+#error
+#endif
+	"std\n"
+	"rep stosb\n"
+	/* unreachable */
+	"hlt\n"
+".type make_stack1,@function\n"
+".size make_stack1,.-make_stack1\n"
+".popsection\n"
+);
+
+/*
+ * memset(p, 0xcc, -1);
+ * It will SIGSEGV when top of the stack is reached.
+ */
+void make_stack2(uint64_t p);
+asm(
+".pushsection .text\n"
+".globl make_stack2\n"
+".align 16\n"
+"make_stack2:\n"
+	"mov $0xcc, %al\n"
+#if defined __amd64__
+	"mov $-1, %rcx\n"
+#elif defined __i386__
+	"mov $-1, %ecx\n"
+#else
+#error
+#endif
+	"cld\n"
+	"rep stosb\n"
+	/* unreachable */
+	"hlt\n"
+".type make_stack2,@function\n"
+".size make_stack2,.-make_stack2\n"
+".popsection\n"
+);
+
+static volatile int test_state = 0;
+static volatile unsigned long stack_min_addr;
+
+#if defined __amd64__
+#define RDI	REG_RDI
+#define RIP	REG_RIP
+#define RIP_STRING "rip"
+#elif defined __i386__
+#define RDI	REG_EDI
+#define RIP	REG_EIP
+#define RIP_STRING "eip"
+#else
+#error
+#endif
+
+static void sigsegv(int _, siginfo_t *__, void *uc_)
+{
+	/*
+	 * Some Linux versions didn't clear DF before entering signal
+	 * handler. make_stack1() doesn't have a chance to clear DF
+	 * either so we clear it by hand here.
+	 */
+	asm volatile ("cld" ::: "memory");
+
+	ucontext_t *uc = uc_;
+
+	if (test_state == 0) {
+		/* Stack is faulted and cleared from RSP to the lowest address. */
+		stack_min_addr = ++uc->uc_mcontext.gregs[RDI];
+		if (1) {
+			printf("stack min %lx\n", stack_min_addr);
+		}
+		uc->uc_mcontext.gregs[RIP] = (uintptr_t)&make_stack2;
+		test_state = 1;
+	} else if (test_state == 1) {
+		/* Stack has been cleared from top to bottom. */
+		unsigned long stack_max_addr = uc->uc_mcontext.gregs[RDI];
+		if (1) {
+			printf("stack max %lx\n", stack_max_addr);
+		}
+		/* Start faulting pages on stack and see what happens. */
+		uc->uc_mcontext.gregs[RIP] = stack_max_addr - PAGE_SIZE;
+		test_state = 2;
+	} else if (test_state == 2) {
+		/* Stack page is NX -- good, test next page. */
+		uc->uc_mcontext.gregs[RIP] -= PAGE_SIZE;
+		if (uc->uc_mcontext.gregs[RIP] == stack_min_addr) {
+			/* One more SIGSEGV and test ends. */
+			test_state = 3;
+		}
+	} else {
+		printf("PASS\tAll stack pages are NX\n");
+		_exit(EXIT_SUCCESS);
+	}
+}
+
+static void sigtrap(int _, siginfo_t *__, void *uc_)
+{
+	const ucontext_t *uc = uc_;
+	unsigned long rip = uc->uc_mcontext.gregs[RIP];
+	printf("FAIL\texecutable page on the stack: " RIP_STRING " %lx\n", rip);
+	_exit(EXIT_FAILURE);
+}
+
+int main(void)
+{
+	{
+		struct sigaction act = {};
+		sigemptyset(&act.sa_mask);
+		act.sa_flags = SA_SIGINFO;
+		act.sa_sigaction = &sigsegv;
+		int rv = sigaction(SIGSEGV, &act, NULL);
+		assert(rv == 0);
+	}
+	{
+		struct sigaction act = {};
+		sigemptyset(&act.sa_mask);
+		act.sa_flags = SA_SIGINFO;
+		act.sa_sigaction = &sigtrap;
+		int rv = sigaction(SIGTRAP, &act, NULL);
+		assert(rv == 0);
+	}
+	{
+		struct rlimit rlim;
+		int rv = getrlimit(RLIMIT_STACK, &rlim);
+		assert(rv == 0);
+		/* Cap stack at time-honored 8 MiB value. */
+		rlim.rlim_max = rlim.rlim_cur;
+		if (rlim.rlim_max > 8 * 1024 * 1024) {
+			rlim.rlim_max = 8 * 1024 * 1024;
+		}
+		rv = setrlimit(RLIMIT_STACK, &rlim);
+		assert(rv == 0);
+	}
+	{
+		/*
+		 * We don't know now much stack SIGSEGV handler uses.
+		 * Bump this by 1 page every time someone complains,
+		 * or rewrite it in assembly.
+		 */
+		const size_t len = SIGSTKSZ;
+		void *p = mmap(NULL, len, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
+		assert(p != MAP_FAILED);
+		stack_t ss = {};
+		ss.ss_sp = p;
+		ss.ss_size = len;
+		int rv = sigaltstack(&ss, NULL);
+		assert(rv == 0);
+	}
+	make_stack1();
+	/*
+	 * Unreachable, but if _this_ INT3 is ever reached, it's a bug somewhere.
+	 * Fold it into main SIGTRAP pathway.
+	 */
+	__builtin_trap();
+}
