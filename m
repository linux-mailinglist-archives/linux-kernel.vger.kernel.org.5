Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2111C80640E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 02:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjLFBSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjLFBSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:18:52 -0500
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [IPv6:2a0c:5a00:149::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AC4196
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 17:18:56 -0800 (PST)
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
        by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <mhal@rbox.co>)
        id 1rAg7y-0004wB-53; Wed, 06 Dec 2023 01:51:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
        s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-ID:Date:Subject:Cc:To:From;
        bh=Pn5v9Z8G6zUgpoZNzeWfUK7alja667jHMj5wvmPffj4=; b=BLg2ii/rrg5SUedqEdYHf54ZlB
        +4gVnppHffYjk66SpEswkt8Y17gCg07aE/71985CBUnuF/SBU3bHB4rmV7OHJaitFeHEiMrfk03MO
        M/mtC0SuxyHTrSn64YAKwqxEKAHR1bW1vKqbot6cG8fUFgvhTn+jGWVwKbf/CbuckZUOgJSicsznq
        C9N8kbRFlnOljdIf5MeJtCdUGcDS+5DSu0DJbT+8x6rvkQAqqdjjvo4sD05zsiUkwRO1YPC0IewH0
        sna9gShCoys9nKQ92sJMiDAVgqXcj5ZlHwsdXjusbHcD1l1sv5mEGHkAugeTyMKh5ootzlpfYL9zm
        Kc+kir2A==;
Received: from [10.9.9.74] (helo=submission03.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <mhal@rbox.co>)
        id 1rAg7w-0001zV-SM; Wed, 06 Dec 2023 01:51:01 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        id 1rAg7k-00CFCn-N4; Wed, 06 Dec 2023 01:50:48 +0100
From:   Michal Luczaj <mhal@rbox.co>
To:     x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, shuah@kernel.org, luto@kernel.org,
        torvalds@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Michal Luczaj <mhal@rbox.co>
Subject: [PATCH 2/2] selftests/x86: UMIP DPL=0 segment base address info leak test
Date:   Wed,  6 Dec 2023 01:43:45 +0100
Message-ID: <20231206004654.2986026-3-mhal@rbox.co>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206004654.2986026-1-mhal@rbox.co>
References: <20231206004654.2986026-1-mhal@rbox.co>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test for UMIP-related opcode emulation revealing the base address of
DPL=0 segments.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
I understand that code quoted in comments tend to bit rot badly. Feel free
to chop it off.

 tools/testing/selftests/x86/Makefile        |   6 +-
 tools/testing/selftests/x86/umip_leak_seg.c | 249 ++++++++++++++++++++
 2 files changed, 254 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/umip_leak_seg.c

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 0b872c0a42d2..262cda802c87 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -19,7 +19,8 @@ TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
 TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering \
-			corrupt_xstate_header amx lam test_shadow_stack
+			corrupt_xstate_header amx lam test_shadow_stack \
+			umip_leak_seg
 # Some selftests require 32bit support enabled also on 64bit systems
 TARGETS_C_32BIT_NEEDED := ldt_gdt ptrace_syscall
 
@@ -113,3 +114,6 @@ $(OUTPUT)/check_initial_reg_state_64: CFLAGS += -Wl,-ereal_start -static
 
 $(OUTPUT)/nx_stack_32: CFLAGS += -Wl,-z,noexecstack
 $(OUTPUT)/nx_stack_64: CFLAGS += -Wl,-z,noexecstack
+
+# umip_leak_seg expects the first 4GiB of address space to be non-writable
+$(OUTPUT)/umip_leak_seg_64: CFLAGS += -pie -fPIE -Wl,-Ttext-segment=0x100000000
diff --git a/tools/testing/selftests/x86/umip_leak_seg.c b/tools/testing/selftests/x86/umip_leak_seg.c
new file mode 100644
index 000000000000..422d63c0ac50
--- /dev/null
+++ b/tools/testing/selftests/x86/umip_leak_seg.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * umip_leak_seg.c - Test for user space retrieving a DPL=0 segment base
+ * address via UMIP instruction decoding/emulation.
+ *
+ * User space executing opcode SGDT on a UMIP-enabled CPU results in
+ * #GP(0). In an effort to support legacy applications, #GP handler calls
+ * fixup_umip_exception() to patch up the exception and return a dummy
+ * value.
+ *
+ * SGDT is emulated by decoding the instruction and copying dummy data to
+ * the memory address specified by the operand:
+ *
+ *	uaddr = insn_get_addr_ref(&insn, regs);
+ *	if ((unsigned long)uaddr == -1L)
+ *		return false;
+ *
+ *	nr_copied = copy_to_user(uaddr, dummy_data, dummy_data_size);
+ *	if (nr_copied  > 0) {
+ *		/ *
+ *		 * If copy fails, send a signal and tell caller that
+ *		 * fault was fixed up.
+ *		 * /
+ *		force_sig_info_umip_fault(uaddr, regs);
+ *		return true;
+ *	}
+ *
+ * Decoder handles segmentation, so for "sgdt %ss:(%rax)" the value of
+ * `uaddr` will be correctly (in compatibility mode) shifted by the base
+ * address of the segment. There's a catch though: decoder does not check
+ * segment's DPL, nor its type.
+ *
+ * ptrace() can be used to prepare a RPL=3 selector for a S=0/DPL=0
+ * segment, potentially one with a kernel space base address. On return to
+ * user space, CPU will reject such selector load; exception will be
+ * raised. But because the #GP handler sees no distinction between
+ * SGDT-induced #GP(0) and IRET-induced #GP(selector), emulator will kick
+ * in and process the malformed @regs->ss.
+ *
+ * If the first 4 GiB of user space are unmapped or non-writable,
+ * copy_to_user() will fail, and signal to user will reveal `uaddr` -- i.e.
+ * the (part of) kernel address. On x86_64, addresses of GDT_ENTRY_TSS (for
+ * each CPU) and GDT_ENTRY_LDT (when in use) can be fully leaked in a few
+ * steps.
+ *
+ * This selftest makes sure that selectors belonging to kernel are not
+ * passed to UMIP emulation logic on #GP. CPU#0's TSS and the current
+ * task's LDT are tried for that. Code is compiled with
+ * -Ttext-segment=0x100000000 to reserve the initial 4 GiB, so that
+ * SIGSEGV's siginfo_t::si_addr can be reliably caught. As an alternative
+ * to ptrace(), sigreturn() is used for setting illegal selector value.
+ */
+#define _GNU_SOURCE
+
+#include <stdio.h>
+#include <stdint.h>
+#include <string.h>
+#include <signal.h>
+#include <setjmp.h>
+#include <assert.h>
+#include <sched.h>
+#include <errno.h>
+#include <err.h>
+
+#include <sys/syscall.h>
+#include <sys/user.h>
+#include <asm/ldt.h>
+
+/* grep arch/x86/include/asm/segment.h */
+#define GDT_ENTRY_DEFAULT_USER32_CS	4
+#define GDT_ENTRY_TSS			8
+#define GDT_ENTRY_LDT			10
+
+#define USER_RPL	3
+
+static int umip_leak_seg;
+static int umip_leak_ax;
+static long umip_leak_kmem;
+static sigjmp_buf buf;
+
+static __attribute__((naked)) void sgdt(void)
+{
+	asm volatile ("sgdt %ss:(%rax)");
+}
+
+/*
+ * Make sure the first 4 GiB are not mapped.
+ */
+static void check_vm(void)
+{
+	unsigned long start;
+	FILE *f;
+
+	f = fopen("/proc/self/maps", "r");
+	if (!f)
+		err(1, "fopen");
+
+	if (fscanf(f, "%lx-", &start) != 1 || start < (1UL << 32))
+		errx(1, "First 4 GiB need to be unmapped");
+
+	fclose(f);
+}
+
+/*
+ * arch/x86/kernel/ldt.c:
+ *	if (alloc_size > PAGE_SIZE)
+ *		new_ldt->entries = __vmalloc(alloc_size, GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+ *	else
+ *		new_ldt->entries = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
+ */
+static void force_ldt_vmalloc(void)
+{
+	struct user_desc desc = { .entry_number = LDT_ENTRIES - 1 };
+	int ret;
+
+	ret = syscall(SYS_modify_ldt, 1, &desc, sizeof(desc));
+	if (ret) {
+		errno = -ret;
+		err(1, "modify_ldt");
+	}
+}
+
+static void set_handler(int sig, void (*handler)(int, siginfo_t *, void *))
+{
+	struct sigaction sa;
+
+	memset(&sa, 0, sizeof(sa));
+
+	sa.sa_sigaction = handler;
+	sa.sa_flags = SA_SIGINFO;
+	sigemptyset(&sa.sa_mask);
+
+	if (sigaction(sig, &sa, 0))
+		err(1, "sigaction");
+}
+
+static void sigusr1(int sig, siginfo_t *info, void *ctx_void)
+{
+	ucontext_t *ctx = (ucontext_t *)ctx_void;
+	struct selectors {
+		unsigned short cs, gs, fs, ss;
+	} *sel = (void *)&ctx->uc_mcontext.gregs[REG_CSGSFS];
+
+	sel->cs = (GDT_ENTRY_DEFAULT_USER32_CS << 3) | USER_RPL;
+	sel->ss = (umip_leak_seg << 3) | USER_RPL;
+	ctx->uc_mcontext.gregs[REG_RAX] = umip_leak_ax;
+	ctx->uc_mcontext.gregs[REG_RIP] = (greg_t)&sgdt;
+}
+
+static void sigsegv(int sig, siginfo_t *info, void *ctx_void)
+{
+	assert((intptr_t)info->si_addr >> 32 == 0);
+
+	if (info->si_code & SI_KERNEL)
+		umip_leak_kmem = -1L;
+	else
+		umip_leak_kmem = (intptr_t)info->si_addr;
+
+	siglongjmp(buf, 1);
+}
+
+static long leak(int seg, int ax)
+{
+	umip_leak_seg = seg;
+	umip_leak_ax = ax;
+
+	if (sigsetjmp(buf, 1))
+		return umip_leak_kmem;
+
+	raise(SIGUSR1);
+	assert(!"unreachable");
+}
+
+static long find_limit(int seg)
+{
+	int limit = 0xffff;
+
+	/* Assuming desc::g and desc::limit1 are zero. */
+	while (limit >= 0 && leak(seg, limit) < 0)
+		limit--;
+
+	return limit;
+}
+
+static int fetch_base(char *seg_name, int seg)
+{
+	long base = leak(seg, 0);
+
+	if (base != -1) {
+		/*
+		 * We're aiming here at a long mode segment descriptor that's
+		 * taking two legacy-mode-sized entries in the GDT.
+		 * Base Address[63:32] of n-th entry will be leaked in two
+		 * steps: from Segment Limit[15:0] and Base Address[15:0] of
+		 * (n+1)-th entry.
+		 */
+		base |= find_limit(seg + 1) << 32;
+		base |= leak(seg + 1, 0) << 48;
+
+		printf("[FAIL]\t%s base leaked: %#zx\n", seg_name, base);
+		return 1;
+	}
+
+	printf("[OK]\t%s base: no leaks\n", seg_name);
+	return 0;
+}
+
+static int dump_TSS(void)
+{
+	cpu_set_t old, new;
+	int ret;
+
+	if (sched_getaffinity(0, sizeof(old), &old))
+		err(1, "sched_getaffinity");
+
+	CPU_ZERO(&new);
+	CPU_SET(0, &new);
+
+	if (sched_setaffinity(0, sizeof(new), &new))
+		err(1, "sched_setaffinity");
+
+	ret = fetch_base("CPU#0 TSS", GDT_ENTRY_TSS);
+
+	if (sched_setaffinity(0, sizeof(old), &old))
+		err(1, "sched_setaffinity restore");
+
+	return ret;
+}
+
+static int dump_LDT(void)
+{
+	force_ldt_vmalloc();
+	return fetch_base("LDT", GDT_ENTRY_LDT);
+}
+
+int main(void)
+{
+	int status;
+
+	check_vm();
+
+	set_handler(SIGUSR1, sigusr1);
+	set_handler(SIGSEGV, sigsegv);
+
+	status  = dump_TSS();
+	status |= dump_LDT();
+
+	return status;
+}
-- 
2.43.0

