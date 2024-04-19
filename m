Return-Path: <linux-kernel+bounces-151956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 971488AB641
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 23:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA3931C21752
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230DF2C19D;
	Fri, 19 Apr 2024 21:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGDWLdKS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286DC13C914
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 21:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713560996; cv=none; b=jNyO3jPkVAaAs87kfGUcNTIJ6Z1TjJhqSN5IJbY1IWLLeH9Rn1A5W/+arUpg+dbf7syZo9bqNKZUT7ULhFF5bDBByUxmW1vF2Ik0UHoU8IjdCv27uOs/y3aaZeivQdvtvCua5Hpxe1C5ieQci2nFDKEM8KUEyIMGCNh8G/oUd4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713560996; c=relaxed/simple;
	bh=UnmwrY9L1QGt9goOz+R6qTzRvwklq16LC96Du7pJ9X0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GY0jL6XOkZbBeCq2D4nRRg8HoUI9vXXJ/FLVa1fLfbQ0k0To/pGBX5UBYyCro2yIwkRyeUsV3j2YS9oz+/blfQTVQnaQVjBH/TO9I7vo2XQ9H0o1GLuing1gTvg/TQY5iUc8lfcntvcjK0Lmo2/Eq4PS2WujZfZSrnhXxs8Kquc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGDWLdKS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF5DC32783;
	Fri, 19 Apr 2024 21:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713560996;
	bh=UnmwrY9L1QGt9goOz+R6qTzRvwklq16LC96Du7pJ9X0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PGDWLdKS/kmO6e+jzlscXX6QirT/C4VX2bTzYrN06jq0OccdxT0OUXZTKLdNzpNHI
	 KaDvIsPyFfkeYFcPdYHbZWjMHzVrmH2me8ydpMYaObZweChvbVeKC/0qlF6+waqQb9
	 IQVEVoBOGpIfEf9XIJIqqdXEgvgy6SEwEzL5w5uIx1haDIe54t2ea5G6ZWJCifcmPh
	 TjxfFeKxBlj0sb3JgLs2nh5wf4lEQt07QtKNZ9qXrq5dUxA9LvUnTLbBS14JrJGfwT
	 boYNE6saVvXJaT2aFOVluJ1sT3BSCAZoFp41oYzKH2ora2/zGs7e758o6t0/+qiTxG
	 ssgb6yQzDPuEA==
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
	Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v4 1/5] x86/bugs: Only harden syscalls when needed
Date: Fri, 19 Apr 2024 14:09:47 -0700
Message-ID: <982d05a2f669140f26500bee643011896d661094.1713559768.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713559768.git.jpoimboe@kernel.org>
References: <cover.1713559768.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syscall hardening (converting the syscall indirect branch to a series of
direct branches) has shown some performance regressions:

- Red Hat internal testing showed up to 12% slowdowns in database
  benchmark testing on Sapphire Rapids when the DB was stressed with 80+
  users to cause contention.

- The kernel test robot's will-it-scale benchmarks showed significant
  regressions on Skylake with IBRS:
  https://lkml.kernel.org/lkml/202404191333.178a0eed-yujie.liu@intel.com

To fix those slowdowns, only use the syscall direct branches when
indirect branches are considered to be "not OK": meaning Spectre v2+BHI
isn't mitigated by HW and the user hasn't disabled mitigations.

Fixes: 1e3ad78334a6 ("x86/syscall: Don't force use of indirect calls for system calls")
Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/entry/common.c            | 15 ++++++++++---
 arch/x86/entry/syscall_32.c        | 11 +---------
 arch/x86/entry/syscall_64.c        |  6 -----
 arch/x86/entry/syscall_x32.c       |  7 +++++-
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/include/asm/syscall.h     |  8 ++++++-
 arch/x86/kernel/cpu/bugs.c         | 35 +++++++++++++++++++++++++++++-
 7 files changed, 61 insertions(+), 22 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 51cc9c7cb9bd..db1ef98da3a4 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -49,7 +49,10 @@ static __always_inline bool do_syscall_x64(struct pt_regs *regs, int nr)
 
 	if (likely(unr < NR_syscalls)) {
 		unr = array_index_nospec(unr, NR_syscalls);
-		regs->ax = x64_sys_call(regs, unr);
+		if (likely(cpu_feature_enabled(X86_FEATURE_INDIRECT_BRANCH_OK)))
+			regs->ax = sys_call_table[unr](regs);
+		else
+			regs->ax = x64_sys_call(regs, unr);
 		return true;
 	}
 	return false;
@@ -66,7 +69,10 @@ static __always_inline bool do_syscall_x32(struct pt_regs *regs, int nr)
 
 	if (IS_ENABLED(CONFIG_X86_X32_ABI) && likely(xnr < X32_NR_syscalls)) {
 		xnr = array_index_nospec(xnr, X32_NR_syscalls);
-		regs->ax = x32_sys_call(regs, xnr);
+		if (likely(cpu_feature_enabled(X86_FEATURE_INDIRECT_BRANCH_OK)))
+			regs->ax = x32_sys_call_table[xnr](regs);
+		else
+			regs->ax = x32_sys_call(regs, xnr);
 		return true;
 	}
 	return false;
@@ -162,7 +168,10 @@ static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs, int nr)
 
 	if (likely(unr < IA32_NR_syscalls)) {
 		unr = array_index_nospec(unr, IA32_NR_syscalls);
-		regs->ax = ia32_sys_call(regs, unr);
+		if (likely(cpu_feature_enabled(X86_FEATURE_INDIRECT_BRANCH_OK)))
+			regs->ax = ia32_sys_call_table[unr](regs);
+		else
+			regs->ax = ia32_sys_call(regs, unr);
 	} else if (nr != -1) {
 		regs->ax = __ia32_sys_ni_syscall(regs);
 	}
diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index c2235bae17ef..aab31760b4e3 100644
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
+const sys_call_ptr_t ia32_sys_call_table[] = {
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
index 33b3f09e6f15..96ea1f8a1d3f 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -11,11 +11,6 @@
 #include <asm/syscalls_64.h>
 #undef __SYSCALL
 
-/*
- * The sys_call_table[] is no longer used for system calls, but
- * kernel/trace/trace_syscalls.c still wants to know the system
- * call address.
- */
 #define __SYSCALL(nr, sym) __x64_##sym,
 const sys_call_ptr_t sys_call_table[] = {
 #include <asm/syscalls_64.h>
@@ -23,7 +18,6 @@ const sys_call_ptr_t sys_call_table[] = {
 #undef __SYSCALL
 
 #define __SYSCALL(nr, sym) case nr: return __x64_##sym(regs);
-
 long x64_sys_call(const struct pt_regs *regs, unsigned int nr)
 {
 	switch (nr) {
diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
index 03de4a932131..5aef4230faca 100644
--- a/arch/x86/entry/syscall_x32.c
+++ b/arch/x86/entry/syscall_x32.c
@@ -11,8 +11,13 @@
 #include <asm/syscalls_x32.h>
 #undef __SYSCALL
 
-#define __SYSCALL(nr, sym) case nr: return __x64_##sym(regs);
+#define __SYSCALL(nr, sym) __x64_##sym,
+const sys_call_ptr_t x32_sys_call_table[] = {
+#include <asm/syscalls_x32.h>
+};
+#undef __SYSCALL
 
+#define __SYSCALL(nr, sym) case nr: return __x64_##sym(regs);
 long x32_sys_call(const struct pt_regs *regs, unsigned int nr)
 {
 	switch (nr) {
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 3c7434329661..d64b0a5291f1 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -470,6 +470,7 @@
 #define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* "" BHI_DIS_S HW control available */
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* "" BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* "" Clear branch history at vmexit using SW loop */
+#define X86_FEATURE_INDIRECT_BRANCH_OK	(21*32+ 5) /* "" It's OK to use indirect branches */
 
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
index ab18185894df..5fca46c78daf 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1665,6 +1665,12 @@ static void __init bhi_select_mitigation(void)
 	if (!IS_ENABLED(CONFIG_X86_64))
 		return;
 
+	/*
+	 * There's no HW mitigation in place.  Mark indirect branches as
+	 * "not OK".
+	 */
+	setup_clear_cpu_cap(X86_FEATURE_INDIRECT_BRANCH_OK);
+
 	/* Mitigate KVM by default */
 	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
 	pr_info("Spectre BHI mitigation: SW BHB clearing on vm exit\n");
@@ -1679,6 +1685,28 @@ static void __init spectre_v2_select_mitigation(void)
 	enum spectre_v2_mitigation_cmd cmd = spectre_v2_parse_cmdline();
 	enum spectre_v2_mitigation mode = SPECTRE_V2_NONE;
 
+	/*
+	 * X86_FEATURE_INDIRECT_BRANCH_OK indicates that indirect calls are
+	 * "OK" to use due to (at least) one of the following being true:
+	 *
+	 *   - the CPU isn't vulnerable to Spectre v2, BHI, etc;
+	 *
+	 *   - a HW mitigation is in place (e.g., IBRS, eIBRS+BHI_DIS_S); or
+	 *
+	 *   - the user disabled mitigations.
+	 *
+	 * Clearing the bit enables certain indirect branch "easy targets" [*]
+	 * to be converted to a series of direct branches.
+	 *
+	 * Assume innocence until proven guilty: set it now and clear it later
+	 * if/when needed.
+	 *
+	 * [*] The closer the indirect branch is to kernel entry, and the more
+	 *     user-controlled registers there are, the easier target it may be
+	 *     for future Spectre v2 variants.
+	 */
+	setup_force_cpu_cap(X86_FEATURE_INDIRECT_BRANCH_OK);
+
 	/*
 	 * If the CPU is not affected and the command line mode is NONE or AUTO
 	 * then nothing to do.
@@ -1765,11 +1793,16 @@ static void __init spectre_v2_select_mitigation(void)
 		break;
 
 	case SPECTRE_V2_LFENCE:
+		setup_clear_cpu_cap(X86_FEATURE_INDIRECT_BRANCH_OK);
+		fallthrough;
 	case SPECTRE_V2_EIBRS_LFENCE:
 		setup_force_cpu_cap(X86_FEATURE_RETPOLINE_LFENCE);
-		fallthrough;
+		setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
+		break;
 
 	case SPECTRE_V2_RETPOLINE:
+		setup_clear_cpu_cap(X86_FEATURE_INDIRECT_BRANCH_OK);
+		fallthrough;
 	case SPECTRE_V2_EIBRS_RETPOLINE:
 		setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
 		break;
-- 
2.44.0


