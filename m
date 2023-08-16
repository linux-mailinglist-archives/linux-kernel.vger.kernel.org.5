Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69F477EBA1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346467AbjHPVUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346469AbjHPVUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:20:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D971990;
        Wed, 16 Aug 2023 14:20:12 -0700 (PDT)
Date:   Wed, 16 Aug 2023 21:20:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692220810;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VwQmuKuOD8Sd8O/b9Qh6n2/e+kWSIKQ+7tBHXAn6T30=;
        b=NBXb9TMboxrPZyKJI+FJ76/G+zI/e/ya6Xq/bnkiryRjEr7/ZgspkE+IwSGCfqHvOOHTY5
        lDLv2A0K4of+XKdU2qQNvgIcvbvhdwiytzdJtb/Bp6+kQgvZkxlX8WhRFFTR5Qo+oqTlVd
        DTmi2pgUKp8N6p4Rp4zWKOpiZdBQ10qHdQioahh0fn3nKLRpXY/+Fq2mTjDYIwFHRNtXCw
        A2puHwxU7Ex1aUfN/uXuyii6oNATJdoiNyNy8cN9wq5V7VoTT96JdoJ4TWUd1gzHgEp9H0
        0q9fy2l6/IXy0bjVX748I9jn11Q0XlDxDn8HDakH14uv0UZJ9cCdZ5H4JIANIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692220810;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VwQmuKuOD8Sd8O/b9Qh6n2/e+kWSIKQ+7tBHXAn6T30=;
        b=7EP3iUi2LduRZr7xa2Q3736S+93lSUMuSi0MJGoc9TZ4Z2j36uZFrBSp8ZsO0fYvG04oof
        SsdoTwhPKa3hiWBQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu: Clean up SRSO return thunk mess
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230814121148.842775684@infradead.org>
References: <20230814121148.842775684@infradead.org>
MIME-Version: 1.0
Message-ID: <169222080982.27769.10977793161172942593.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d43490d0ab824023e11d0b57d0aeec17a6e0ca13
Gitweb:        https://git.kernel.org/tip/d43490d0ab824023e11d0b57d0aeec17a6e0ca13
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 14 Aug 2023 13:44:31 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 16 Aug 2023 21:47:24 +02:00

x86/cpu: Clean up SRSO return thunk mess

Use the existing configurable return thunk. There is absolute no
justification for having created this __x86_return_thunk alternative.

To clarify, the whole thing looks like:

Zen3/4 does:

  srso_alias_untrain_ret:
	  nop2
	  lfence
	  jmp srso_alias_return_thunk
	  int3

  srso_alias_safe_ret: // aliasses srso_alias_untrain_ret just so
	  add $8, %rsp
	  ret
	  int3

  srso_alias_return_thunk:
	  call srso_alias_safe_ret
	  ud2

While Zen1/2 does:

  srso_untrain_ret:
	  movabs $foo, %rax
	  lfence
	  call srso_safe_ret           (jmp srso_return_thunk ?)
	  int3

  srso_safe_ret: // embedded in movabs instruction
	  add $8,%rsp
          ret
          int3

  srso_return_thunk:
	  call srso_safe_ret
	  ud2

While retbleed does:

  zen_untrain_ret:
	  test $0xcc, %bl
	  lfence
	  jmp zen_return_thunk
          int3

  zen_return_thunk: // embedded in the test instruction
	  ret
          int3

Where Zen1/2 flush the BTB entry using the instruction decoder trick
(test,movabs) Zen3/4 use BTB aliasing. SRSO adds a return sequence
(srso_safe_ret()) which forces the function return instruction to
speculate into a trap (UD2).  This RET will then mispredict and
execution will continue at the return site read from the top of the
stack.

Pick one of three options at boot (evey function can only ever return
once).

  [ bp: Fixup commit message uarch details and add them in a comment in
    the code too. Add a comment about the srso_select_mitigation()
    dependency on retbleed_select_mitigation(). Add moar ifdeffery for
    32-bit builds. Add a dummy srso_untrain_ret_alias() definition for
    32-bit alternatives needing the symbol. ]

Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230814121148.842775684@infradead.org
---
 arch/x86/include/asm/nospec-branch.h |  5 ++-
 arch/x86/kernel/cpu/bugs.c           | 15 ++++++-
 arch/x86/kernel/vmlinux.lds.S        |  2 +-
 arch/x86/lib/retpoline.S             | 58 +++++++++++++++++++--------
 tools/objtool/arch/x86/decode.c      |  2 +-
 5 files changed, 62 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index b3625cc..5ed78ad 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -347,9 +347,14 @@ extern void __x86_return_thunk(void);
 static inline void __x86_return_thunk(void) {}
 #endif
 
+extern void zen_return_thunk(void);
+extern void srso_return_thunk(void);
+extern void srso_alias_return_thunk(void);
+
 extern void zen_untrain_ret(void);
 extern void srso_untrain_ret(void);
 extern void srso_untrain_ret_alias(void);
+
 extern void entry_ibpb(void);
 
 extern void (*x86_return_thunk)(void);
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 3bc0d14..56cf250 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -167,6 +167,11 @@ void __init cpu_select_mitigations(void)
 	md_clear_select_mitigation();
 	srbds_select_mitigation();
 	l1d_flush_select_mitigation();
+
+	/*
+	 * srso_select_mitigation() depends and must run after
+	 * retbleed_select_mitigation().
+	 */
 	srso_select_mitigation();
 	gds_select_mitigation();
 }
@@ -1037,6 +1042,9 @@ do_cmd_auto:
 		setup_force_cpu_cap(X86_FEATURE_RETHUNK);
 		setup_force_cpu_cap(X86_FEATURE_UNRET);
 
+		if (IS_ENABLED(CONFIG_RETHUNK))
+			x86_return_thunk = zen_return_thunk;
+
 		if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
 		    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 			pr_err(RETBLEED_UNTRAIN_MSG);
@@ -2453,10 +2461,13 @@ static void __init srso_select_mitigation(void)
 			 */
 			setup_force_cpu_cap(X86_FEATURE_RETHUNK);
 
-			if (boot_cpu_data.x86 == 0x19)
+			if (boot_cpu_data.x86 == 0x19) {
 				setup_force_cpu_cap(X86_FEATURE_SRSO_ALIAS);
-			else
+				x86_return_thunk = srso_alias_return_thunk;
+			} else {
 				setup_force_cpu_cap(X86_FEATURE_SRSO);
+				x86_return_thunk = srso_return_thunk;
+			}
 			srso_mitigation = SRSO_MITIGATION_SAFE_RET;
 		} else {
 			pr_err("WARNING: kernel not compiled with CPU_SRSO.\n");
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 8e2a306..d3b02d6 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -521,7 +521,7 @@ INIT_PER_CPU(irq_stack_backing_store);
 #endif
 
 #ifdef CONFIG_RETHUNK
-. = ASSERT((__ret & 0x3f) == 0, "__ret not cacheline-aligned");
+. = ASSERT((zen_return_thunk & 0x3f) == 0, "zen_return_thunk not cacheline-aligned");
 . = ASSERT((srso_safe_ret & 0x3f) == 0, "srso_safe_ret not cacheline-aligned");
 #endif
 
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index a478eb5..7df8582 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -151,22 +151,27 @@ SYM_CODE_END(__x86_indirect_jump_thunk_array)
 	.section .text..__x86.rethunk_untrain
 
 SYM_START(srso_untrain_ret_alias, SYM_L_GLOBAL, SYM_A_NONE)
+	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
 	ASM_NOP2
 	lfence
-	jmp __x86_return_thunk
+	jmp srso_alias_return_thunk
 SYM_FUNC_END(srso_untrain_ret_alias)
 __EXPORT_THUNK(srso_untrain_ret_alias)
 
 	.section .text..__x86.rethunk_safe
+#else
+/* dummy definition for alternatives */
+SYM_START(srso_untrain_ret_alias, SYM_L_GLOBAL, SYM_A_NONE)
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+SYM_FUNC_END(srso_untrain_ret_alias)
 #endif
 
-/* Needs a definition for the __x86_return_thunk alternative below. */
 SYM_START(srso_safe_ret_alias, SYM_L_GLOBAL, SYM_A_NONE)
-#ifdef CONFIG_CPU_SRSO
 	lea 8(%_ASM_SP), %_ASM_SP
 	UNWIND_HINT_FUNC
-#endif
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3
@@ -174,9 +179,16 @@ SYM_FUNC_END(srso_safe_ret_alias)
 
 	.section .text..__x86.return_thunk
 
+SYM_CODE_START(srso_alias_return_thunk)
+	UNWIND_HINT_FUNC
+	ANNOTATE_NOENDBR
+	call srso_safe_ret_alias
+	ud2
+SYM_CODE_END(srso_alias_return_thunk)
+
 /*
  * Safety details here pertain to the AMD Zen{1,2} microarchitecture:
- * 1) The RET at __x86_return_thunk must be on a 64 byte boundary, for
+ * 1) The RET at zen_return_thunk must be on a 64 byte boundary, for
  *    alignment within the BTB.
  * 2) The instruction at zen_untrain_ret must contain, and not
  *    end with, the 0xc3 byte of the RET.
@@ -184,7 +196,7 @@ SYM_FUNC_END(srso_safe_ret_alias)
  *    from re-poisioning the BTB prediction.
  */
 	.align 64
-	.skip 64 - (__ret - zen_untrain_ret), 0xcc
+	.skip 64 - (zen_return_thunk - zen_untrain_ret), 0xcc
 SYM_START(zen_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	ANNOTATE_NOENDBR
 	/*
@@ -192,16 +204,16 @@ SYM_START(zen_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	 *
 	 *   TEST $0xcc, %bl
 	 *   LFENCE
-	 *   JMP __x86_return_thunk
+	 *   JMP zen_return_thunk
 	 *
 	 * Executing the TEST instruction has a side effect of evicting any BTB
 	 * prediction (potentially attacker controlled) attached to the RET, as
-	 * __x86_return_thunk + 1 isn't an instruction boundary at the moment.
+	 * zen_return_thunk + 1 isn't an instruction boundary at the moment.
 	 */
 	.byte	0xf6
 
 	/*
-	 * As executed from __x86_return_thunk, this is a plain RET.
+	 * As executed from zen_return_thunk, this is a plain RET.
 	 *
 	 * As part of the TEST above, RET is the ModRM byte, and INT3 the imm8.
 	 *
@@ -213,13 +225,13 @@ SYM_START(zen_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	 * With SMT enabled and STIBP active, a sibling thread cannot poison
 	 * RET's prediction to a type of its choice, but can evict the
 	 * prediction due to competitive sharing. If the prediction is
-	 * evicted, __x86_return_thunk will suffer Straight Line Speculation
+	 * evicted, zen_return_thunk will suffer Straight Line Speculation
 	 * which will be contained safely by the INT3.
 	 */
-SYM_INNER_LABEL(__ret, SYM_L_GLOBAL)
+SYM_INNER_LABEL(zen_return_thunk, SYM_L_GLOBAL)
 	ret
 	int3
-SYM_CODE_END(__ret)
+SYM_CODE_END(zen_return_thunk)
 
 	/*
 	 * Ensure the TEST decoding / BTB invalidation is complete.
@@ -230,7 +242,7 @@ SYM_CODE_END(__ret)
 	 * Jump back and execute the RET in the middle of the TEST instruction.
 	 * INT3 is for SLS protection.
 	 */
-	jmp __ret
+	jmp zen_return_thunk
 	int3
 SYM_FUNC_END(zen_untrain_ret)
 __EXPORT_THUNK(zen_untrain_ret)
@@ -251,11 +263,18 @@ SYM_START(srso_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	ANNOTATE_NOENDBR
 	.byte 0x48, 0xb8
 
+/*
+ * This forces the function return instruction to speculate into a trap
+ * (UD2 in srso_return_thunk() below).  This RET will then mispredict
+ * and execution will continue at the return site read from the top of
+ * the stack.
+ */
 SYM_INNER_LABEL(srso_safe_ret, SYM_L_GLOBAL)
 	lea 8(%_ASM_SP), %_ASM_SP
 	ret
 	int3
 	int3
+	/* end of movabs */
 	lfence
 	call srso_safe_ret
 	ud2
@@ -263,12 +282,19 @@ SYM_CODE_END(srso_safe_ret)
 SYM_FUNC_END(srso_untrain_ret)
 __EXPORT_THUNK(srso_untrain_ret)
 
-SYM_CODE_START(__x86_return_thunk)
+SYM_CODE_START(srso_return_thunk)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
-	ALTERNATIVE_2 "jmp __ret", "call srso_safe_ret", X86_FEATURE_SRSO, \
-			"call srso_safe_ret_alias", X86_FEATURE_SRSO_ALIAS
+	call srso_safe_ret
 	ud2
+SYM_CODE_END(srso_return_thunk)
+
+SYM_CODE_START(__x86_return_thunk)
+	UNWIND_HINT_FUNC
+	ANNOTATE_NOENDBR
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
 SYM_CODE_END(__x86_return_thunk)
 EXPORT_SYMBOL(__x86_return_thunk)
 
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index cba8a7b..c55f3bb 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -829,6 +829,6 @@ bool arch_is_rethunk(struct symbol *sym)
 
 bool arch_is_embedded_insn(struct symbol *sym)
 {
-	return !strcmp(sym->name, "__ret") ||
+	return !strcmp(sym->name, "zen_return_thunk") ||
 	       !strcmp(sym->name, "srso_safe_ret");
 }
