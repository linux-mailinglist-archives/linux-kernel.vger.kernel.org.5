Return-Path: <linux-kernel+bounces-139799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D9F8A07D4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589611F22F53
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DAA13D26F;
	Thu, 11 Apr 2024 05:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuG95pSm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B034613CFA6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 05:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712814121; cv=none; b=MLysz0zZsBUOloFYiKc3Vhr1XYS1nHbRQ+3ic7AApXIeyeo8TECHfYVvepT0Ka2reef6wNZEgwVNPcfyovBHHTTBdVmVDggCPKBQXmLvFx2hVI9+7MCfoHKxMF7iTxVqfR5YeCQw6EkLUEapZ8w3rPqdxMa5AxPmWLfFqpBsmLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712814121; c=relaxed/simple;
	bh=MIxbPiLz3JeRSinxe0pJNrdpV53uSPO0/XHjtw8vB1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IG3eIYRmucsJMquVn28ToOaKSiXRPTchUmlScy2umvcoXVB4VbjFjU0EY/YB3xnRcIaYhn2PkxwFsLtxTwF8EIGqIaDhOOnJRi1k0kA5PsIZ09uyZL6vdkjzUOMAjZnycqmwF9rNVHAAdJ/zYIWDvLD/DZ8wQvasU9w2MTNKQXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuG95pSm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F04FC43390;
	Thu, 11 Apr 2024 05:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712814121;
	bh=MIxbPiLz3JeRSinxe0pJNrdpV53uSPO0/XHjtw8vB1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iuG95pSmtjXcZrq8qawMpbEizgtqbTEE3s3CC8o/Ay5bDNhkzyy8ajX2bEaqlpNQh
	 YSWVk6+YW1H/lyHW3I62fS2JHbnp00UwK+UoPPl7DF+XwPPMIVzA8wy0KO65fwhpnI
	 DceCi2VgDaEVW26xjABIeUfpDyaw0H9/RprJ9LXUihKoiA9o5eyNFhEy+rdZ2NPdr5
	 FBtD1Q/1mDR96rhCQJdsY2Hmq/cdf5DCDxhsU6UjX/p71IYaM6bqdgvczhCe+en8TP
	 AuRmWDH5sXOjV8ln9q1L557ir7gqS0LZ3ZG7M2fMWeLBrUE6MyvVf63N/RkKNG3Q7H
	 PRNlX/3YYlUAw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>
Subject: [PATCH 5/7] x86/bugs: Only harden syscalls when needed
Date: Wed, 10 Apr 2024 22:40:49 -0700
Message-ID: <97befd7c1e008797734dee05181c49056ff6de57.1712813475.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712813475.git.jpoimboe@kernel.org>
References: <cover.1712813475.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syscall hardening (i.e., converting the syscall indirect branch to a
series of direct branches) may cause performance regressions in certain
scenarios.  Only use the syscall hardening when indirect branches are
considered unsafe.

Fixes: 1e3ad78334a6 ("x86/syscall: Don't force use of indirect calls for system calls")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/entry/common.c            | 30 +++++++++++++++++++++++++---
 arch/x86/entry/syscall_32.c        | 11 +---------
 arch/x86/entry/syscall_64.c        |  8 +-------
 arch/x86/entry/syscall_x32.c       |  7 ++++++-
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/include/asm/syscall.h     |  8 +++++++-
 arch/x86/kernel/cpu/bugs.c         | 32 +++++++++++++++++++++++++++++-
 7 files changed, 74 insertions(+), 23 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 6de50b80702e..80d432d2fe44 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -39,6 +39,28 @@
 
 #ifdef CONFIG_X86_64
 
+/*
+ * Do either a direct or an indirect call, depending on whether indirect calls
+ * are considered safe.
+ */
+#define __do_syscall(table, func_direct, nr, regs)			\
+({									\
+	unsigned long __rax, __rdi, __rsi;				\
+									\
+	asm_inline volatile(						\
+		ALTERNATIVE("call " __stringify(func_direct) "\n\t",	\
+			    ANNOTATE_RETPOLINE_SAFE			\
+			    "call *%[func_ptr]\n\t",			\
+			    X86_FEATURE_INDIRECT_SAFE)			\
+		: "=D" (__rdi), "=S" (__rsi), "=a" (__rax),		\
+		  ASM_CALL_CONSTRAINT					\
+		: "0" (regs), "1" (nr), [func_ptr] "r" (table[nr])	\
+		: "rdx", "rcx", "r8", "r9", "r10", "r11",		\
+		  "cc", "memory");					\
+									\
+	__rax;								\
+})
+
 static __always_inline bool do_syscall_x64(struct pt_regs *regs, int nr)
 {
 	/*
@@ -49,7 +71,7 @@ static __always_inline bool do_syscall_x64(struct pt_regs *regs, int nr)
 
 	if (likely(unr < NR_syscalls)) {
 		unr = array_index_nospec(unr, NR_syscalls);
-		regs->ax = x64_sys_call(regs, unr);
+		regs->ax = __do_syscall(sys_call_table, x64_sys_call, unr, regs);
 		return true;
 	}
 	return false;
@@ -66,7 +88,7 @@ static __always_inline bool do_syscall_x32(struct pt_regs *regs, int nr)
 
 	if (IS_ENABLED(CONFIG_X86_X32_ABI) && likely(xnr < X32_NR_syscalls)) {
 		xnr = array_index_nospec(xnr, X32_NR_syscalls);
-		regs->ax = x32_sys_call(regs, xnr);
+		regs->ax = __do_syscall(x32_sys_call_table, x32_sys_call, xnr, regs);
 		return true;
 	}
 	return false;
@@ -147,6 +169,8 @@ static int ia32_emulation_override_cmdline(char *arg)
 	return kstrtobool(arg, &__ia32_enabled);
 }
 early_param("ia32_emulation", ia32_emulation_override_cmdline);
+#else
+#define __do_syscall(table, func_direct, nr, regs) table[nr](regs)
 #endif
 
 /*
@@ -162,7 +186,7 @@ static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs, int nr)
 
 	if (likely(unr < IA32_NR_syscalls)) {
 		unr = array_index_nospec(unr, IA32_NR_syscalls);
-		regs->ax = ia32_sys_call(regs, unr);
+		regs->ax = __do_syscall(ia32_sys_call_table, ia32_sys_call, unr, regs);
 	} else if (nr != -1) {
 		regs->ax = __ia32_sys_ni_syscall(regs);
 	}
diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index c2235bae17ef..9185870a3ab3 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -14,25 +14,16 @@
 #endif
 
 #define __SYSCALL(nr, sym) extern long __ia32_##sym(const struct pt_regs *);
-
 #include <asm/syscalls_32.h>
 #undef __SYSCALL
 
-/*
- * The sys_call_table[] is no longer used for system calls, but
- * kernel/trace/trace_syscalls.c still wants to know the system
- * call address.
- */
-#ifdef CONFIG_X86_32
 #define __SYSCALL(nr, sym) __ia32_##sym,
-const sys_call_ptr_t sys_call_table[] = {
+__visible const sys_call_ptr_t ia32_sys_call_table[] = {
 #include <asm/syscalls_32.h>
 };
 #undef __SYSCALL
-#endif
 
 #define __SYSCALL(nr, sym) case nr: return __ia32_##sym(regs);
-
 long ia32_sys_call(const struct pt_regs *regs, unsigned int nr)
 {
 	switch (nr) {
diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index 33b3f09e6f15..c368048efa41 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -11,19 +11,13 @@
 #include <asm/syscalls_64.h>
 #undef __SYSCALL
 
-/*
- * The sys_call_table[] is no longer used for system calls, but
- * kernel/trace/trace_syscalls.c still wants to know the system
- * call address.
- */
 #define __SYSCALL(nr, sym) __x64_##sym,
-const sys_call_ptr_t sys_call_table[] = {
+asmlinkage const sys_call_ptr_t sys_call_table[] = {
 #include <asm/syscalls_64.h>
 };
 #undef __SYSCALL
 
 #define __SYSCALL(nr, sym) case nr: return __x64_##sym(regs);
-
 long x64_sys_call(const struct pt_regs *regs, unsigned int nr)
 {
 	switch (nr) {
diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
index 03de4a932131..89a717267fab 100644
--- a/arch/x86/entry/syscall_x32.c
+++ b/arch/x86/entry/syscall_x32.c
@@ -11,8 +11,13 @@
 #include <asm/syscalls_x32.h>
 #undef __SYSCALL
 
-#define __SYSCALL(nr, sym) case nr: return __x64_##sym(regs);
+#define __SYSCALL(nr, sym) __x64_##sym,
+asmlinkage const sys_call_ptr_t x32_sys_call_table[] = {
+#include <asm/syscalls_x32.h>
+};
+#undef __SYSCALL
 
+#define __SYSCALL(nr, sym) case nr: return __x64_##sym(regs);
 long x32_sys_call(const struct pt_regs *regs, unsigned int nr)
 {
 	switch (nr) {
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 3c7434329661..7c87fe80c696 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -470,6 +470,7 @@
 #define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* "" BHI_DIS_S HW control available */
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* "" BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* "" Clear branch history at vmexit using SW loop */
+#define X86_FEATURE_INDIRECT_SAFE	(21*32+ 4) /* "" Indirect branches aren't vulnerable to Spectre v2 */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index 2fc7bc3863ff..dfb59521244c 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -16,14 +16,20 @@
 #include <asm/thread_info.h>	/* for TS_COMPAT */
 #include <asm/unistd.h>
 
-/* This is used purely for kernel/trace/trace_syscalls.c */
 typedef long (*sys_call_ptr_t)(const struct pt_regs *);
 extern const sys_call_ptr_t sys_call_table[];
 
+#if defined(CONFIG_X86_32)
+#define ia32_sys_call_table sys_call_table
+#else
 /*
  * These may not exist, but still put the prototypes in so we
  * can use IS_ENABLED().
  */
+extern const sys_call_ptr_t ia32_sys_call_table[];
+extern const sys_call_ptr_t x32_sys_call_table[];
+#endif
+
 extern long ia32_sys_call(const struct pt_regs *, unsigned int nr);
 extern long x32_sys_call(const struct pt_regs *, unsigned int nr);
 extern long x64_sys_call(const struct pt_regs *, unsigned int nr);
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index a65c70709bb5..efffd87381b1 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1669,6 +1669,15 @@ static void __init bhi_select_mitigation(void)
 	if (!IS_ENABLED(CONFIG_X86_64))
 		return;
 
+	/*
+	 * There's no hardware mitigation in place, so mark indirect branches
+	 * as unsafe.
+	 *
+	 * One could argue the SW loop makes indirect branches safe again, but
+	 * Linus prefers it this way.
+	 */
+	setup_clear_cpu_cap(X86_FEATURE_INDIRECT_SAFE);
+
 	/* Mitigate KVM by default */
 	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
 	pr_info("Spectre BHI mitigation: SW BHB clearing on vm exit\n");
@@ -1686,6 +1695,21 @@ static void __init spectre_v2_select_mitigation(void)
 	enum spectre_v2_mitigation_cmd cmd = spectre_v2_parse_cmdline();
 	enum spectre_v2_mitigation mode = SPECTRE_V2_NONE;
 
+	/*
+	 * X86_FEATURE_INDIRECT_SAFE indicates whether indirect calls can be
+	 * considered safe.  That means either:
+	 *
+	 *   - the CPU isn't vulnerable to Spectre v2 or its variants;
+	 *
+	 *   - a hardware mitigation is in place (e.g., IBRS, BHI_DIS_S); or
+	 *
+	 *   - the user turned off mitigations altogether.
+	 *
+	 * Assume innocence until proven guilty: set the cap bit now, then
+	 * clear it later if/when needed.
+	 */
+	setup_force_cpu_cap(X86_FEATURE_INDIRECT_SAFE);
+
 	/*
 	 * If the CPU is not affected and the command line mode is NONE or AUTO
 	 * then nothing to do.
@@ -1720,6 +1744,7 @@ static void __init spectre_v2_select_mitigation(void)
 
 	case SPECTRE_V2_CMD_RETPOLINE_LFENCE:
 		pr_err(SPECTRE_V2_LFENCE_MSG);
+		setup_clear_cpu_cap(X86_FEATURE_INDIRECT_SAFE);
 		mode = SPECTRE_V2_LFENCE;
 		break;
 
@@ -1772,11 +1797,16 @@ static void __init spectre_v2_select_mitigation(void)
 		break;
 
 	case SPECTRE_V2_LFENCE:
+		setup_clear_cpu_cap(X86_FEATURE_INDIRECT_SAFE);
+		fallthrough;
 	case SPECTRE_V2_EIBRS_LFENCE:
 		setup_force_cpu_cap(X86_FEATURE_RETPOLINE_LFENCE);
-		fallthrough;
+		setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
+		break;
 
 	case SPECTRE_V2_RETPOLINE:
+		setup_clear_cpu_cap(X86_FEATURE_INDIRECT_SAFE);
+		fallthrough;
 	case SPECTRE_V2_EIBRS_RETPOLINE:
 		setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
 		break;
-- 
2.44.0


