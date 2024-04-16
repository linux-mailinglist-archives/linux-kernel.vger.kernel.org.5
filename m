Return-Path: <linux-kernel+bounces-147729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A44F8A7844
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5AEC1F23D12
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E941513A896;
	Tue, 16 Apr 2024 23:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHWR51lS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F8B13A3EF
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 23:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713308547; cv=none; b=CvKDB3VhIlh7Mw5Yn4NSFkX71iAi4k6s/4cLcwknEyeLxI6HFUgtksEOOzhoBGOuCfOjkbkXJhXTqDpzIaso6z6tSnlz9MDnQJQag8MlBmv80FwYm/fljVwJ5S66Z05uMCWnlf5TQQUgj5B2XzjRb/7N3cD/o+MiTPLspXuOAAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713308547; c=relaxed/simple;
	bh=EJOJeCI3+uMGp9GeIF5xksR9jkzYb+8HMy5HZYqBPKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qAKlhj7+yprsBEoodMUCxV7cVvgafM3qxynxQTFrmja0/fXaoULTvS80MTylGZy/WPQ33m3Mqn7fBZ8s9LvsIbnyPRyoCe/4S7bnabQrc4lWXd8zZ61Y3/pi3FgBQ97Axg9gFCLpghjeHo6EAm6PTyOBtlnSm42/0dZ0Anf+19U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHWR51lS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F0FC3277B;
	Tue, 16 Apr 2024 23:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713308546;
	bh=EJOJeCI3+uMGp9GeIF5xksR9jkzYb+8HMy5HZYqBPKY=;
	h=From:To:Cc:Subject:Date:From;
	b=AHWR51lSkq0KBFbW5Y8s3hfwDCI0HTEOKENoQqfcZjnDCCJrxT8vnOILpYOU/7+da
	 hjIo1yuCSjNGesd6941xgWbUSyn/0olL8glLVjLfO1WJgnAAwbFOB7EfbNptUBJa43
	 y8MTQ6VN5ojNFKNVPy4RMr7z1m/WMYV33naeBltgLh1tErZVZwQug5yrMmQY+paCtB
	 80zSe3Zq9pQOfPviTgdjR4x362llQchV6ImvivyUd2Cmstr9raMgPylr44Vb1QRor8
	 VKuBx5pBCFjcwSdk5ohoXp0qJ+1ewOnjMf2KWEHAPsFLwANC77pYX0g1CRAisYb9zy
	 2TA2fivrhkyjA==
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
Subject: [PATCH v3] x86/bugs: Only harden syscalls when needed
Date: Tue, 16 Apr 2024 16:02:21 -0700
Message-ID: <eda0ec65f4612cc66875aaf76e738643f41fbc01.1713296762.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.44.0
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
Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
v3:
- fix X86_FEATURE_INDIRECT_SAFE value

 arch/x86/entry/common.c            | 15 ++++++++++++---
 arch/x86/entry/syscall_32.c        | 11 +----------
 arch/x86/entry/syscall_64.c        |  6 ------
 arch/x86/entry/syscall_x32.c       |  7 ++++++-
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/include/asm/syscall.h     |  8 +++++++-
 arch/x86/kernel/cpu/bugs.c         | 31 +++++++++++++++++++++++++++++-
 7 files changed, 57 insertions(+), 22 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 6de50b80702e..c0f8116291e4 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -49,7 +49,10 @@ static __always_inline bool do_syscall_x64(struct pt_regs *regs, int nr)
 
 	if (likely(unr < NR_syscalls)) {
 		unr = array_index_nospec(unr, NR_syscalls);
-		regs->ax = x64_sys_call(regs, unr);
+		if (likely(cpu_feature_enabled(X86_FEATURE_INDIRECT_SAFE)))
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
+		if (likely(cpu_feature_enabled(X86_FEATURE_INDIRECT_SAFE)))
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
+		if (likely(cpu_feature_enabled(X86_FEATURE_INDIRECT_SAFE)))
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
index 3c7434329661..f0ea66cbd5f1 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -470,6 +470,7 @@
 #define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* "" BHI_DIS_S HW control available */
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* "" BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* "" Clear branch history at vmexit using SW loop */
+#define X86_FEATURE_INDIRECT_SAFE	(21*32+ 5) /* "" Indirect branches aren't vulnerable to Spectre v2 */
 
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
index ca295b0c1eee..dcb97cc2758f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1664,6 +1664,15 @@ static void __init bhi_select_mitigation(void)
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
@@ -1678,6 +1687,21 @@ static void __init spectre_v2_select_mitigation(void)
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
@@ -1764,11 +1788,16 @@ static void __init spectre_v2_select_mitigation(void)
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


