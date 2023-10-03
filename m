Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69ED87B6E3C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240332AbjJCQSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjJCQSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:18:53 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B302FA7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 09:18:47 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99357737980so202643866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 09:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696349926; x=1696954726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e3IAZVAhNGDrAQRqda8leHtR3ZOavaUNDvRo/y1rlfI=;
        b=HgaldzDPHACNBX4cK95/a1cDTgFDAXdYGcviV2cSKoo2tkETOysqBTyX7GeCoGGWNc
         KgFXZRo0ZJESs3BY84zNbF+KCrDL+DAwFtgofzeeFsN4IqsN4NRA5LWrNSAe6tPU41CO
         qddeU6PRLcPbcZG634uGuuHQr4K7iZgpqRjRo2NYPdo1B1k9pDitseiPhhlI7B+lcaoS
         PZju5fXTW1cvmzDkW6qBsNsTZp5B3UlBP+6mhIWMKJ0Otr97N04oDgyWDJn+zvc+7Ssc
         qoXl2YYXJy1psMppj+3RkPnhKSZqw66Gla1f2Y1P8+yul6crF+41Sx/AapIyflHSmbzU
         gvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696349926; x=1696954726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3IAZVAhNGDrAQRqda8leHtR3ZOavaUNDvRo/y1rlfI=;
        b=h+GgKggz/O1r8/nuL8/zK7D+UVVYSedpbhRqAoFPwJliOqE+U/C9O6iJZ/KMSsOFvo
         Dz+H0dQT3V+5JA0PPQxMJGIiyHdqWE5pFijWtSqeWnvbY4oEySelELSINd9mbGqUejZm
         slE/62O3wsX594GbPGVVfLkH2E652kddOtSk9uC7hX/H0iUoUFqr2ZiyyIaV27fSb5QF
         OaJy3l/qqHLQaMUwLgyb0lEFOwFh2kf8AWX1WLd2s71CZq82nMDYJ3g0jrOhWKNEg/r1
         9ztdUz56bU8IoSm8LHYZihTtdpJJZDfVXBpx6g/xKwGw19DBFl4mgwktG0s4lrbdghn9
         UWwA==
X-Gm-Message-State: AOJu0Yzu8qW0LB5540j6AjIe09xcEbzyCdCYEX/t87md1DAhFl+q74B5
        IDIp9i6P9eHBNfby3XkzJw==
X-Google-Smtp-Source: AGHT+IHD6UeDLdPGJK/UZ8BRn7OiJD55r8cal1FzgkTH/Sj6Rv62/z6XnBEHlSG4cr1YWUvL5y9FlQ==
X-Received: by 2002:a17:907:8b8c:b0:9a1:b950:abab with SMTP id tb12-20020a1709078b8c00b009a1b950ababmr16873365ejc.32.1696349925770;
        Tue, 03 Oct 2023 09:18:45 -0700 (PDT)
Received: from p183 ([46.53.254.179])
        by smtp.gmail.com with ESMTPSA id l21-20020a170906231500b009930c80b87csm1315312eja.142.2023.10.03.09.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 09:18:45 -0700 (PDT)
Date:   Tue, 3 Oct 2023 19:18:43 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org
Subject: [PATCH v2] x86: test that userspace stack is in fact NX
Message-ID: <4cef8266-ad6d-48af-a5f1-fc2b6a8eb422@p183>
References: <4b78a714-5ac3-4783-8256-1dda4673db01@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4b78a714-5ac3-4783-8256-1dda4673db01@p183>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is how it works:

* fault and fill the stack from rsp with int3 down until rlimit allows,
* fill upwards with int3 too, overwrite libc stuff, argv, envp,
* try to exec int3 on each page and catch it in either SIGSEGV or
  SIGTRAP handler.

Note: trying to execute _every_ int3 on a 8 MiB stack takes 30-40 seconds
even on fast machine which is too much for kernel selftesting
(not for LTP!) so only 1 int3 per page is tried.

Tested on F37 kernel and on a custom kernel which does

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

Changes since v1:

	i386 support
	nice pretty printing of test result
	cld in the SIGSEGV handler for robustness
	SIGSTKSZ is recommended not MINSIGSTKSZ
	better comments

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 tools/testing/selftests/x86/Makefile   |    4 
 tools/testing/selftests/x86/nx_stack.c |  212 +++++++++++++++++++++++++++++++++
 2 files changed, 216 insertions(+)

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
new file mode 100644
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
+ * Fill the stack with int3's and then try to execute some of them:
+ * SIGSEGV -- good, SIGTRAP -- bad.
+ *
+ * Regular stack is completely overwritten before testing.
+ * Test doesn't exit SIGSEGV handler after first fault at int3.
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
+		/* Stack is faulted and cleared from rsp to the lowest address. */
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
+	 * Unreachable, but if _this_ int3 is ever reached, it's a bug somewhere.
+	 * Fold it into main SIGTRAP pathway.
+	 */
+	__builtin_trap();
+}
