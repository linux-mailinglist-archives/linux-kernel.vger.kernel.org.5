Return-Path: <linux-kernel+bounces-143179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053128A3566
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2901F1C21AA7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA7114F138;
	Fri, 12 Apr 2024 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBD7sbcr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29FB14F10D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 18:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712945442; cv=none; b=PBuIMp0PmJ2jgz3F2sEt4s01/WBEBYfEGU0mD41xCndvb0tsGuRyyLN75rYZaIfQk00PeM3XffatD6I1aAI7elYZy0CHsn3eMwV6ENxj14rgFzcMtti2Ucuhaj4yaw6UQPqPpkfvzHVgkK8O14DaF9cBqXk3XDgZSzeaMgeKLc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712945442; c=relaxed/simple;
	bh=7vkYK4BTMEwDVFhnVwZt5O9MtmurQc2GLFoCzRHFmYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f3SInK2KkGx4VJr431vSeHapUNsj5K945cPkMRwoo/PfZuNqkzju+mTy7s7bdDg3rytzw6J+snM2a/LCstJbXEor8BAK0s7ikFYGTI88DybjPaTGa7NW5T3BXG5XANoVysJGcb1DuqZSqOWi21OOQcGwohnkDSEg5Y9dnI1i+tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBD7sbcr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41F2C4AF0C;
	Fri, 12 Apr 2024 18:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712945441;
	bh=7vkYK4BTMEwDVFhnVwZt5O9MtmurQc2GLFoCzRHFmYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dBD7sbcrZHU5zT220mQihtegh3wkqAGcnNKOU4yiTK3jPgw6OgS8CAHu50ePBOYks
	 /Xkjc0MZAu5BVAXUPLlnoDHXZf7a1cJGHGgMeye/0uDHsfyMGfljKeJcFByOOYWKya
	 6F1j37snWAYZ3fRdyEexqWNpltblJ6LPxf26fAQryg1uqFT13MXvlqE6jx0dzb0Efj
	 QUcG0cWrYun6xWwhnt5CCciF0LpjAXQe6oF6mo4zMTgKjE83Vu8kkpI3jJEdRSIkD2
	 2qkeqzTpkEA245sYTBscHH5iDWtCEwotC6XbBRXz/w3cba6WT8i2KJCGI+MSVpCsoJ
	 sFv/pZMV0BPUw==
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
Subject: [PATCH 3/3] x86/bugs: Remove support for Spectre v2 LFENCE "retpolines"
Date: Fri, 12 Apr 2024 11:10:34 -0700
Message-ID: <e5356c0e018cd0a96aabe719f685c237ac519403.1712944776.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712944776.git.jpoimboe@kernel.org>
References: <cover.1712944776.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I found several bugs where code assumes that X86_FEATURE_RETPOLINE
actually means retpolines (imagine that!).  In fact that feature also
includes the original AMD LFENCE "retpolines", which aren't in fact
retpolines.

Really, those "retpolines" should just be removed.  They're already
considered vulnerable due to the fact that the speculative window after
the indirect branch can still be long enough to do multiple dependent
loads.  And recent tooling makes such gadgets easier to find.

Also, EIBRS_LFENCE tests worse in real-world benchmarks than the actual
BHI mitigations, so it's both slower and less secure.

Specifically this removes support for the following cmdline options:

  - spectre_v2=retpoline,amd
  - spectre_v2=retpoline,lfence
  - spectre_v2=eibrs,lfence

Now when any of those options are used, it will print an error and fall
back to the defaults (spectre_v2=auto spectre_bhi=on).

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/Makefile                             |  1 -
 arch/x86/include/asm/cpufeatures.h            |  1 -
 arch/x86/include/asm/disabled-features.h      |  3 +-
 arch/x86/include/asm/nospec-branch.h          | 18 ++---
 arch/x86/kernel/alternative.c                 | 17 +----
 arch/x86/kernel/cpu/bugs.c                    | 66 +------------------
 arch/x86/kernel/cpu/cpu.h                     |  3 +-
 arch/x86/lib/retpoline.S                      |  5 +-
 arch/x86/net/bpf_jit_comp.c                   |  5 +-
 tools/arch/x86/include/asm/cpufeatures.h      |  1 -
 .../arch/x86/include/asm/disabled-features.h  |  3 +-
 11 files changed, 15 insertions(+), 108 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 5ab93fcdd691..f0f91810a79e 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -20,7 +20,6 @@ ifdef CONFIG_CC_IS_CLANG
 RETPOLINE_CFLAGS	:= -mretpoline-external-thunk
 RETPOLINE_VDSO_CFLAGS	:= -mretpoline
 endif
-RETPOLINE_CFLAGS	+= $(call cc-option,-mindirect-branch-cs-prefix)
 
 ifdef CONFIG_MITIGATION_RETHUNK
 RETHUNK_CFLAGS		:= -mfunction-return=thunk-extern
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 7c87fe80c696..fccc838ac8ff 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -296,7 +296,6 @@
 #define X86_FEATURE_ENTRY_IBPB		(11*32+10) /* "" Issue an IBPB on kernel entry */
 #define X86_FEATURE_RRSBA_CTRL		(11*32+11) /* "" RET prediction control */
 #define X86_FEATURE_RETPOLINE		(11*32+12) /* "" Generic Retpoline mitigation for Spectre variant 2 */
-#define X86_FEATURE_RETPOLINE_LFENCE	(11*32+13) /* "" Use LFENCE for Spectre variant 2 */
 #define X86_FEATURE_RETHUNK		(11*32+14) /* "" Use REturn THUNK */
 #define X86_FEATURE_UNRET		(11*32+15) /* "" AMD BTB untrain return */
 #define X86_FEATURE_USE_IBPB_FW		(11*32+16) /* "" Use IBPB during runtime firmware calls */
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index c492bdc97b05..e1c421282a78 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -53,8 +53,7 @@
 #ifdef CONFIG_MITIGATION_RETPOLINE
 # define DISABLE_RETPOLINE	0
 #else
-# define DISABLE_RETPOLINE	((1 << (X86_FEATURE_RETPOLINE & 31)) | \
-				 (1 << (X86_FEATURE_RETPOLINE_LFENCE & 31)))
+# define DISABLE_RETPOLINE	(1 << (X86_FEATURE_RETPOLINE & 31)
 #endif
 
 #ifdef CONFIG_MITIGATION_RETHUNK
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index ff5f1ecc7d1e..b98fb18928f6 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -434,15 +434,11 @@ static inline void call_depth_return_thunk(void) {}
  * which is ensured when CONFIG_MITIGATION_RETPOLINE is defined.
  */
 # define CALL_NOSPEC						\
-	ALTERNATIVE_2(						\
+	ALTERNATIVE(						\
 	ANNOTATE_RETPOLINE_SAFE					\
 	"call *%[thunk_target]\n",				\
 	"call __x86_indirect_thunk_%V[thunk_target]\n",		\
-	X86_FEATURE_RETPOLINE,					\
-	"lfence;\n"						\
-	ANNOTATE_RETPOLINE_SAFE					\
-	"call *%[thunk_target]\n",				\
-	X86_FEATURE_RETPOLINE_LFENCE)
+	X86_FEATURE_RETPOLINE)
 
 # define THUNK_TARGET(addr) [thunk_target] "r" (addr)
 
@@ -453,7 +449,7 @@ static inline void call_depth_return_thunk(void) {}
  * here, anyway.
  */
 # define CALL_NOSPEC						\
-	ALTERNATIVE_2(						\
+	ALTERNATIVE(						\
 	ANNOTATE_RETPOLINE_SAFE					\
 	"call *%[thunk_target]\n",				\
 	"       jmp    904f;\n"					\
@@ -468,11 +464,7 @@ static inline void call_depth_return_thunk(void) {}
 	"       ret;\n"						\
 	"       .align 16\n"					\
 	"904:	call   901b;\n",				\
-	X86_FEATURE_RETPOLINE,					\
-	"lfence;\n"						\
-	ANNOTATE_RETPOLINE_SAFE					\
-	"call *%[thunk_target]\n",				\
-	X86_FEATURE_RETPOLINE_LFENCE)
+	X86_FEATURE_RETPOLINE)
 
 # define THUNK_TARGET(addr) [thunk_target] "rm" (addr)
 #endif
@@ -485,10 +477,8 @@ static inline void call_depth_return_thunk(void) {}
 enum spectre_v2_mitigation {
 	SPECTRE_V2_NONE,
 	SPECTRE_V2_RETPOLINE,
-	SPECTRE_V2_LFENCE,
 	SPECTRE_V2_EIBRS,
 	SPECTRE_V2_EIBRS_RETPOLINE,
-	SPECTRE_V2_EIBRS_LFENCE,
 	SPECTRE_V2_IBRS,
 };
 
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 45a280f2161c..a7eb8203a8cd 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -639,8 +639,6 @@ static int emit_call_track_retpoline(void *addr, struct insn *insn, int reg, u8
  * into:
  *
  *   CALL *%\reg
- *
- * It also tries to inline spectre_v2=retpoline,lfence when size permits.
  */
 static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
 {
@@ -657,8 +655,7 @@ static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
 	/* If anyone ever does: CALL/JMP *%rsp, we're in deep trouble. */
 	BUG_ON(reg == 4);
 
-	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE) &&
-	    !cpu_feature_enabled(X86_FEATURE_RETPOLINE_LFENCE)) {
+	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {
 		if (cpu_feature_enabled(X86_FEATURE_CALL_DEPTH))
 			return emit_call_track_retpoline(addr, insn, reg, bytes);
 
@@ -675,9 +672,8 @@ static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
 	 * into:
 	 *
 	 *   Jncc.d8 1f
-	 *   [ LFENCE ]
 	 *   JMP *%\reg
-	 *   [ NOP ]
+	 *   NOP
 	 * 1:
 	 */
 	if (is_jcc32(insn)) {
@@ -691,15 +687,6 @@ static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
 		op = JMP32_INSN_OPCODE;
 	}
 
-	/*
-	 * For RETPOLINE_LFENCE: prepend the indirect CALL/JMP with an LFENCE.
-	 */
-	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_LFENCE)) {
-		bytes[i++] = 0x0f;
-		bytes[i++] = 0xae;
-		bytes[i++] = 0xe8; /* LFENCE */
-	}
-
 	ret = emit_indirect(op, reg, bytes + i);
 	if (ret < 0)
 		return ret;
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index e827613c9e39..2e71bacc8191 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1143,7 +1143,6 @@ static void __init retbleed_select_mitigation(void)
 			break;
 		case SPECTRE_V2_EIBRS:
 		case SPECTRE_V2_EIBRS_RETPOLINE:
-		case SPECTRE_V2_EIBRS_LFENCE:
 			retbleed_mitigation = RETBLEED_MITIGATION_EIBRS;
 			break;
 		default:
@@ -1184,9 +1183,7 @@ static inline const char *spectre_v2_module_string(void)
 static inline const char *spectre_v2_module_string(void) { return ""; }
 #endif
 
-#define SPECTRE_V2_LFENCE_MSG "WARNING: LFENCE mitigation is not recommended for this CPU, data leaks possible!\n"
 #define SPECTRE_V2_EIBRS_EBPF_MSG "WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!\n"
-#define SPECTRE_V2_EIBRS_LFENCE_EBPF_SMT_MSG "WARNING: Unprivileged eBPF is enabled with eIBRS+LFENCE mitigation and SMT, data leaks possible via Spectre v2 BHB attacks!\n"
 #define SPECTRE_V2_IBRS_PERF_MSG "WARNING: IBRS mitigation selected on Enhanced IBRS CPU, this may cause unnecessary performance loss\n"
 
 #ifdef CONFIG_BPF_SYSCALL
@@ -1201,10 +1198,6 @@ void unpriv_ebpf_notify(int new_state)
 	case SPECTRE_V2_EIBRS:
 		pr_err(SPECTRE_V2_EIBRS_EBPF_MSG);
 		break;
-	case SPECTRE_V2_EIBRS_LFENCE:
-		if (sched_smt_active())
-			pr_err(SPECTRE_V2_EIBRS_LFENCE_EBPF_SMT_MSG);
-		break;
 	default:
 		break;
 	}
@@ -1225,10 +1218,8 @@ enum spectre_v2_mitigation_cmd {
 	SPECTRE_V2_CMD_FORCE,
 	SPECTRE_V2_CMD_RETPOLINE,
 	SPECTRE_V2_CMD_RETPOLINE_GENERIC,
-	SPECTRE_V2_CMD_RETPOLINE_LFENCE,
 	SPECTRE_V2_CMD_EIBRS,
 	SPECTRE_V2_CMD_EIBRS_RETPOLINE,
-	SPECTRE_V2_CMD_EIBRS_LFENCE,
 	SPECTRE_V2_CMD_IBRS,
 };
 
@@ -1414,9 +1405,7 @@ spectre_v2_user_select_mitigation(void)
 static const char * const spectre_v2_strings[] = {
 	[SPECTRE_V2_NONE]			= "Vulnerable",
 	[SPECTRE_V2_RETPOLINE]			= "Mitigation: Retpolines",
-	[SPECTRE_V2_LFENCE]			= "Mitigation: LFENCE",
 	[SPECTRE_V2_EIBRS]			= "Mitigation: Enhanced / Automatic IBRS",
-	[SPECTRE_V2_EIBRS_LFENCE]		= "Mitigation: Enhanced / Automatic IBRS + LFENCE",
 	[SPECTRE_V2_EIBRS_RETPOLINE]		= "Mitigation: Enhanced / Automatic IBRS + Retpolines",
 	[SPECTRE_V2_IBRS]			= "Mitigation: IBRS",
 };
@@ -1429,11 +1418,8 @@ static const struct {
 	{ "off",		SPECTRE_V2_CMD_NONE,		  false },
 	{ "on",			SPECTRE_V2_CMD_FORCE,		  true  },
 	{ "retpoline",		SPECTRE_V2_CMD_RETPOLINE,	  false },
-	{ "retpoline,amd",	SPECTRE_V2_CMD_RETPOLINE_LFENCE,  false },
-	{ "retpoline,lfence",	SPECTRE_V2_CMD_RETPOLINE_LFENCE,  false },
 	{ "retpoline,generic",	SPECTRE_V2_CMD_RETPOLINE_GENERIC, false },
 	{ "eibrs",		SPECTRE_V2_CMD_EIBRS,		  false },
-	{ "eibrs,lfence",	SPECTRE_V2_CMD_EIBRS_LFENCE,	  false },
 	{ "eibrs,retpoline",	SPECTRE_V2_CMD_EIBRS_RETPOLINE,	  false },
 	{ "auto",		SPECTRE_V2_CMD_AUTO,		  false },
 	{ "ibrs",		SPECTRE_V2_CMD_IBRS,              false },
@@ -1472,9 +1458,7 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 	}
 
 	if ((cmd == SPECTRE_V2_CMD_RETPOLINE ||
-	     cmd == SPECTRE_V2_CMD_RETPOLINE_LFENCE ||
 	     cmd == SPECTRE_V2_CMD_RETPOLINE_GENERIC ||
-	     cmd == SPECTRE_V2_CMD_EIBRS_LFENCE ||
 	     cmd == SPECTRE_V2_CMD_EIBRS_RETPOLINE) &&
 	    !IS_ENABLED(CONFIG_MITIGATION_RETPOLINE)) {
 		pr_err("%s selected but not compiled in. Switching to AUTO select\n",
@@ -1483,7 +1467,6 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 	}
 
 	if ((cmd == SPECTRE_V2_CMD_EIBRS ||
-	     cmd == SPECTRE_V2_CMD_EIBRS_LFENCE ||
 	     cmd == SPECTRE_V2_CMD_EIBRS_RETPOLINE) &&
 	    !boot_cpu_has(X86_FEATURE_IBRS_ENHANCED)) {
 		pr_err("%s selected but CPU doesn't have Enhanced or Automatic IBRS. Switching to AUTO select\n",
@@ -1491,14 +1474,6 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 		return SPECTRE_V2_CMD_AUTO;
 	}
 
-	if ((cmd == SPECTRE_V2_CMD_RETPOLINE_LFENCE ||
-	     cmd == SPECTRE_V2_CMD_EIBRS_LFENCE) &&
-	    !boot_cpu_has(X86_FEATURE_LFENCE_RDTSC)) {
-		pr_err("%s selected, but CPU doesn't have a serializing LFENCE. Switching to AUTO select\n",
-		       mitigation_options[i].option);
-		return SPECTRE_V2_CMD_AUTO;
-	}
-
 	if (cmd == SPECTRE_V2_CMD_IBRS && !IS_ENABLED(CONFIG_MITIGATION_IBRS_ENTRY)) {
 		pr_err("%s selected but not compiled in. Switching to AUTO select\n",
 		       mitigation_options[i].option);
@@ -1585,7 +1560,6 @@ static void __init spectre_v2_determine_rsb_fill_type_at_vmexit(enum spectre_v2_
 	case SPECTRE_V2_NONE:
 		return;
 
-	case SPECTRE_V2_EIBRS_LFENCE:
 	case SPECTRE_V2_EIBRS:
 		if (boot_cpu_has_bug(X86_BUG_EIBRS_PBRSB)) {
 			setup_force_cpu_cap(X86_FEATURE_RSB_VMEXIT_LITE);
@@ -1595,7 +1569,6 @@ static void __init spectre_v2_determine_rsb_fill_type_at_vmexit(enum spectre_v2_
 
 	case SPECTRE_V2_EIBRS_RETPOLINE:
 	case SPECTRE_V2_RETPOLINE:
-	case SPECTRE_V2_LFENCE:
 	case SPECTRE_V2_IBRS:
 		setup_force_cpu_cap(X86_FEATURE_RSB_VMEXIT);
 		pr_info("Spectre v2 / SpectreRSB : Filling RSB on VMEXIT\n");
@@ -1652,8 +1625,7 @@ static void __init bhi_select_mitigation(void)
 		return;
 
 	/* Retpoline mitigates against BHI unless the CPU has RRSBA behavior */
-	if (boot_cpu_has(X86_FEATURE_RETPOLINE) &&
-	    !boot_cpu_has(X86_FEATURE_RETPOLINE_LFENCE)) {
+	if (boot_cpu_has(X86_FEATURE_RETPOLINE)) {
 		spec_ctrl_disable_kernel_rrsba();
 		if (rrsba_disabled)
 			return;
@@ -1735,11 +1707,6 @@ static void __init spectre_v2_select_mitigation(void)
 		mode = spectre_v2_select_retpoline();
 		break;
 
-	case SPECTRE_V2_CMD_RETPOLINE_LFENCE:
-		pr_err(SPECTRE_V2_LFENCE_MSG);
-		mode = SPECTRE_V2_LFENCE;
-		break;
-
 	case SPECTRE_V2_CMD_RETPOLINE_GENERIC:
 		mode = SPECTRE_V2_RETPOLINE;
 		break;
@@ -1756,10 +1723,6 @@ static void __init spectre_v2_select_mitigation(void)
 		mode = SPECTRE_V2_EIBRS;
 		break;
 
-	case SPECTRE_V2_CMD_EIBRS_LFENCE:
-		mode = SPECTRE_V2_EIBRS_LFENCE;
-		break;
-
 	case SPECTRE_V2_CMD_EIBRS_RETPOLINE:
 		mode = SPECTRE_V2_EIBRS_RETPOLINE;
 		break;
@@ -1788,14 +1751,6 @@ static void __init spectre_v2_select_mitigation(void)
 			pr_warn(SPECTRE_V2_IBRS_PERF_MSG);
 		break;
 
-	case SPECTRE_V2_LFENCE:
-		setup_clear_cpu_cap(X86_FEATURE_INDIRECT_SAFE);
-		fallthrough;
-	case SPECTRE_V2_EIBRS_LFENCE:
-		setup_force_cpu_cap(X86_FEATURE_RETPOLINE_LFENCE);
-		setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
-		break;
-
 	case SPECTRE_V2_RETPOLINE:
 		setup_clear_cpu_cap(X86_FEATURE_INDIRECT_SAFE);
 		fallthrough;
@@ -1809,9 +1764,7 @@ static void __init spectre_v2_select_mitigation(void)
 	 * JMPs gets protection against BHI and Intramode-BTI, but RET
 	 * prediction from a non-RSB predictor is still a risk.
 	 */
-	if (mode == SPECTRE_V2_EIBRS_LFENCE ||
-	    mode == SPECTRE_V2_EIBRS_RETPOLINE ||
-	    mode == SPECTRE_V2_RETPOLINE)
+	if (boot_cpu_has(X86_FEATURE_RETPOLINE))
 		spec_ctrl_disable_kernel_rrsba();
 
 	if (boot_cpu_has(X86_BUG_BHI))
@@ -1958,10 +1911,6 @@ void cpu_bugs_smt_update(void)
 {
 	mutex_lock(&spec_ctrl_mutex);
 
-	if (sched_smt_active() && unprivileged_ebpf_enabled() &&
-	    spectre_v2_enabled == SPECTRE_V2_EIBRS_LFENCE)
-		pr_warn_once(SPECTRE_V2_EIBRS_LFENCE_EBPF_SMT_MSG);
-
 	switch (spectre_v2_user_stibp) {
 	case SPECTRE_V2_USER_NONE:
 		break;
@@ -2838,9 +2787,7 @@ static const char *spectre_bhi_state(void)
 		return "; BHI: BHI_DIS_S";
 	else if (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP))
 		return "; BHI: SW loop, KVM: SW loop";
-	else if (boot_cpu_has(X86_FEATURE_RETPOLINE) &&
-		 !boot_cpu_has(X86_FEATURE_RETPOLINE_LFENCE) &&
-		 rrsba_disabled)
+	else if (boot_cpu_has(X86_FEATURE_RETPOLINE) && rrsba_disabled)
 		return "; BHI: Retpoline";
 	else if (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT))
 		return "; BHI: Vulnerable, KVM: SW loop";
@@ -2850,16 +2797,9 @@ static const char *spectre_bhi_state(void)
 
 static ssize_t spectre_v2_show_state(char *buf)
 {
-	if (spectre_v2_enabled == SPECTRE_V2_LFENCE)
-		return sysfs_emit(buf, "Vulnerable: LFENCE\n");
-
 	if (spectre_v2_enabled == SPECTRE_V2_EIBRS && unprivileged_ebpf_enabled())
 		return sysfs_emit(buf, "Vulnerable: eIBRS with unprivileged eBPF\n");
 
-	if (sched_smt_active() && unprivileged_ebpf_enabled() &&
-	    spectre_v2_enabled == SPECTRE_V2_EIBRS_LFENCE)
-		return sysfs_emit(buf, "Vulnerable: eIBRS+LFENCE with unprivileged eBPF and SMT\n");
-
 	return sysfs_emit(buf, "%s%s%s%s%s%s%s%s\n",
 			  spectre_v2_strings[spectre_v2_enabled],
 			  ibpb_state(),
diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index ea9e07d57c8d..602318b87bd9 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -93,8 +93,7 @@ extern enum spectre_v2_mitigation spectre_v2_enabled;
 static inline bool spectre_v2_in_eibrs_mode(enum spectre_v2_mitigation mode)
 {
 	return mode == SPECTRE_V2_EIBRS ||
-	       mode == SPECTRE_V2_EIBRS_RETPOLINE ||
-	       mode == SPECTRE_V2_EIBRS_LFENCE;
+	       mode == SPECTRE_V2_EIBRS_RETPOLINE;
 }
 
 #endif /* ARCH_X86_CPU_H */
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index e674ccf720b9..e32199f40c48 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -37,9 +37,8 @@ SYM_INNER_LABEL(__x86_indirect_thunk_\reg, SYM_L_GLOBAL)
 	UNWIND_HINT_UNDEFINED
 	ANNOTATE_NOENDBR
 
-	ALTERNATIVE_2 __stringify(RETPOLINE \reg), \
-		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *%\reg; int3), X86_FEATURE_RETPOLINE_LFENCE, \
-		      __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), ALT_NOT(X86_FEATURE_RETPOLINE)
+	ALTERNATIVE __stringify(RETPOLINE \reg), \
+		    __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), ALT_NOT(X86_FEATURE_RETPOLINE)
 
 .endm
 
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index df5fac428408..39ed0107fb59 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -556,10 +556,7 @@ static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
 {
 	u8 *prog = *pprog;
 
-	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_LFENCE)) {
-		EMIT_LFENCE();
-		EMIT2(0xFF, 0xE0 + reg);
-	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {
+	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {
 		OPTIMIZER_HIDE_VAR(reg);
 		if (cpu_feature_enabled(X86_FEATURE_CALL_DEPTH))
 			emit_jump(&prog, &__x86_indirect_jump_thunk_array[reg], ip);
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 25160d26764b..6627e0d25425 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -298,7 +298,6 @@
 #define X86_FEATURE_ENTRY_IBPB		(11*32+10) /* "" Issue an IBPB on kernel entry */
 #define X86_FEATURE_RRSBA_CTRL		(11*32+11) /* "" RET prediction control */
 #define X86_FEATURE_RETPOLINE		(11*32+12) /* "" Generic Retpoline mitigation for Spectre variant 2 */
-#define X86_FEATURE_RETPOLINE_LFENCE	(11*32+13) /* "" Use LFENCE for Spectre variant 2 */
 #define X86_FEATURE_RETHUNK		(11*32+14) /* "" Use REturn THUNK */
 #define X86_FEATURE_UNRET		(11*32+15) /* "" AMD BTB untrain return */
 #define X86_FEATURE_USE_IBPB_FW		(11*32+16) /* "" Use IBPB during runtime firmware calls */
diff --git a/tools/arch/x86/include/asm/disabled-features.h b/tools/arch/x86/include/asm/disabled-features.h
index 1f23960d2b06..74538147edc8 100644
--- a/tools/arch/x86/include/asm/disabled-features.h
+++ b/tools/arch/x86/include/asm/disabled-features.h
@@ -53,8 +53,7 @@
 #ifdef CONFIG_MITIGATION_RETPOLINE
 # define DISABLE_RETPOLINE	0
 #else
-# define DISABLE_RETPOLINE	((1 << (X86_FEATURE_RETPOLINE & 31)) | \
-				 (1 << (X86_FEATURE_RETPOLINE_LFENCE & 31)))
+# define DISABLE_RETPOLINE	(1 << (X86_FEATURE_RETPOLINE & 31)
 #endif
 
 #ifdef CONFIG_MITIGATION_RETHUNK
-- 
2.44.0


