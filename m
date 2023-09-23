Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648E87AC1EB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 14:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjIWMUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 08:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbjIWMU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 08:20:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59A419C;
        Sat, 23 Sep 2023 05:20:11 -0700 (PDT)
Date:   Sat, 23 Sep 2023 12:20:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695471608;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TvOgTPXi9zZcYVCUQO9DnqljTlwl/jLz4Z5xXwlSmh8=;
        b=b0d+247lorUAqx+e7bUkSD3FD2sAMRuqYYsb3a1nynX+FpDOg4mPq8uBavMtV3mZDPqXEi
        o6a2qFCeyC7NZJDydgqy62jg5NbBGCquRDMku+8L+ExfEXgpCwilIqhz3dubwt1Zxr90ez
        jqoHl99XCJNvkOl30GYnPWO+vtTk+M0J+Hw7mHrYO7meX8bk9zbDp5VvVvl6RMmn5Op6NI
        laAdaMh9zByofvQXtbVy5LIsRpJpNSV8M8sBbxKcVh0xAgkmy04QbX8khkooEs2mxy7Dtp
        yUfoQuS8Su4QmwAxl2J2FAVyzRdjJnALnlDBV3n2pkF3VAv0GMe9o4YTbtrKSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695471608;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TvOgTPXi9zZcYVCUQO9DnqljTlwl/jLz4Z5xXwlSmh8=;
        b=0XkSoNe9SbR46HsCFjf9x77ba3sb/DgVDkg1J9+9MIkZMQzd2ipHNSTR+S5U4GMnk6MoaP
        6TXrBlZ0j0MPLhDg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/srso: Disentangle rethunk-dependent options
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <2845084ed303d8384905db3b87b77693945302b4.1693889988.git.jpoimboe@kernel.org>
References: <2845084ed303d8384905db3b87b77693945302b4.1693889988.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <169547160765.27769.15230857470498279403.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     670bf81b24ed688fe77d8cc1ff3a66b409bf6e08
Gitweb:        https://git.kernel.org/tip/670bf81b24ed688fe77d8cc1ff3a66b409bf6e08
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 04 Sep 2023 22:05:00 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 23 Sep 2023 14:13:03 +02:00

x86/srso: Disentangle rethunk-dependent options

CONFIG_RETHUNK, CONFIG_CPU_UNRET_ENTRY and CONFIG_CPU_SRSO are all
tangled up.  De-spaghettify the code a bit.

Some of the rethunk-related code has been shuffled around within the
'.text..__x86.return_thunk' section, but otherwise there are no
functional changes.  srso_alias_untrain_ret() and srso_alias_safe_ret()
((which are very address-sensitive) haven't moved.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/2845084ed303d8384905db3b87b77693945302b4.1693889988.git.jpoimboe@kernel.org
---
 arch/x86/include/asm/nospec-branch.h |  25 ++--
 arch/x86/kernel/cpu/bugs.c           |   5 +-
 arch/x86/kernel/vmlinux.lds.S        |   7 +-
 arch/x86/lib/retpoline.S             | 157 ++++++++++++++------------
 4 files changed, 109 insertions(+), 85 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 6c14fd1..51e3f1a 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -289,19 +289,17 @@
  * where we have a stack but before any RET instruction.
  */
 .macro UNTRAIN_RET
-#if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_IBPB_ENTRY) || \
-	defined(CONFIG_CALL_DEPTH_TRACKING) || defined(CONFIG_CPU_SRSO)
+#if defined(CONFIG_RETHUNK) || defined(CONFIG_CPU_IBPB_ENTRY)
 	VALIDATE_UNRET_END
 	ALTERNATIVE_3 "",						\
 		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
 		      "call entry_ibpb", X86_FEATURE_ENTRY_IBPB,	\
-		      __stringify(RESET_CALL_DEPTH), X86_FEATURE_CALL_DEPTH
+		     __stringify(RESET_CALL_DEPTH), X86_FEATURE_CALL_DEPTH
 #endif
 .endm
 
 .macro UNTRAIN_RET_VM
-#if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_IBPB_ENTRY) || \
-	defined(CONFIG_CALL_DEPTH_TRACKING) || defined(CONFIG_CPU_SRSO)
+#if defined(CONFIG_RETHUNK) || defined(CONFIG_CPU_IBPB_ENTRY)
 	VALIDATE_UNRET_END
 	ALTERNATIVE_3 "",						\
 		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
@@ -311,8 +309,7 @@
 .endm
 
 .macro UNTRAIN_RET_FROM_CALL
-#if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_IBPB_ENTRY) || \
-	defined(CONFIG_CALL_DEPTH_TRACKING) || defined(CONFIG_CPU_SRSO)
+#if defined(CONFIG_RETHUNK) || defined(CONFIG_CPU_IBPB_ENTRY)
 	VALIDATE_UNRET_END
 	ALTERNATIVE_3 "",						\
 		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
@@ -348,6 +345,20 @@ extern void __x86_return_thunk(void);
 static inline void __x86_return_thunk(void) {}
 #endif
 
+#ifdef CONFIG_CPU_UNRET_ENTRY
+extern void retbleed_return_thunk(void);
+#else
+static inline void retbleed_return_thunk(void) {}
+#endif
+
+#ifdef CONFIG_CPU_SRSO
+extern void srso_return_thunk(void);
+extern void srso_alias_return_thunk(void);
+#else
+static inline void srso_return_thunk(void) {}
+static inline void srso_alias_return_thunk(void) {}
+#endif
+
 extern void retbleed_return_thunk(void);
 extern void srso_return_thunk(void);
 extern void srso_alias_return_thunk(void);
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6b443f0..9731e81 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -63,7 +63,7 @@ EXPORT_SYMBOL_GPL(x86_pred_cmd);
 
 static DEFINE_MUTEX(spec_ctrl_mutex);
 
-void (*x86_return_thunk)(void) __ro_after_init = &__x86_return_thunk;
+void (*x86_return_thunk)(void) __ro_after_init = __x86_return_thunk;
 
 /* Update SPEC_CTRL MSR and its cached copy unconditionally */
 static void update_spec_ctrl(u64 val)
@@ -1041,8 +1041,7 @@ do_cmd_auto:
 		setup_force_cpu_cap(X86_FEATURE_RETHUNK);
 		setup_force_cpu_cap(X86_FEATURE_UNRET);
 
-		if (IS_ENABLED(CONFIG_RETHUNK))
-			x86_return_thunk = retbleed_return_thunk;
+		x86_return_thunk = retbleed_return_thunk;
 
 		if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
 		    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index f15fb71..54a5596 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -139,10 +139,7 @@ SECTIONS
 		STATIC_CALL_TEXT
 
 		ALIGN_ENTRY_TEXT_BEGIN
-#ifdef CONFIG_CPU_SRSO
 		*(.text..__x86.rethunk_untrain)
-#endif
-
 		ENTRY_TEXT
 
 #ifdef CONFIG_CPU_SRSO
@@ -520,12 +517,12 @@ INIT_PER_CPU(irq_stack_backing_store);
            "fixed_percpu_data is not at start of per-cpu area");
 #endif
 
-#ifdef CONFIG_RETHUNK
+#ifdef CONFIG_CPU_UNRET_ENTRY
 . = ASSERT((retbleed_return_thunk & 0x3f) == 0, "retbleed_return_thunk not cacheline-aligned");
-. = ASSERT((srso_safe_ret & 0x3f) == 0, "srso_safe_ret not cacheline-aligned");
 #endif
 
 #ifdef CONFIG_CPU_SRSO
+. = ASSERT((srso_safe_ret & 0x3f) == 0, "srso_safe_ret not cacheline-aligned");
 /*
  * GNU ld cannot do XOR until 2.41.
  * https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=f6f78318fca803c4907fb8d7f6ded8295f1947b1
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index a40ba18..8ba79d2 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -126,12 +126,13 @@ SYM_CODE_END(__x86_indirect_jump_thunk_array)
 #include <asm/GEN-for-each-reg.h>
 #undef GEN
 #endif
-/*
- * This function name is magical and is used by -mfunction-return=thunk-extern
- * for the compiler to generate JMPs to it.
- */
+
 #ifdef CONFIG_RETHUNK
 
+	.section .text..__x86.return_thunk
+
+#ifdef CONFIG_CPU_SRSO
+
 /*
  * srso_alias_untrain_ret() and srso_alias_safe_ret() are placed at
  * special addresses:
@@ -147,9 +148,7 @@ SYM_CODE_END(__x86_indirect_jump_thunk_array)
  *
  * As a result, srso_alias_safe_ret() becomes a safe return.
  */
-#ifdef CONFIG_CPU_SRSO
-	.section .text..__x86.rethunk_untrain
-
+	.pushsection .text..__x86.rethunk_untrain
 SYM_START(srso_alias_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
@@ -157,17 +156,9 @@ SYM_START(srso_alias_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	lfence
 	jmp srso_alias_return_thunk
 SYM_FUNC_END(srso_alias_untrain_ret)
+	.popsection
 
-	.section .text..__x86.rethunk_safe
-#else
-/* dummy definition for alternatives */
-SYM_START(srso_alias_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
-	ANNOTATE_UNRET_SAFE
-	ret
-	int3
-SYM_FUNC_END(srso_alias_untrain_ret)
-#endif
-
+	.pushsection .text..__x86.rethunk_safe
 SYM_START(srso_alias_safe_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	lea 8(%_ASM_SP), %_ASM_SP
 	UNWIND_HINT_FUNC
@@ -182,8 +173,58 @@ SYM_CODE_START_NOALIGN(srso_alias_return_thunk)
 	call srso_alias_safe_ret
 	ud2
 SYM_CODE_END(srso_alias_return_thunk)
+	.popsection
+
+/*
+ * SRSO untraining sequence for Zen1/2, similar to retbleed_untrain_ret()
+ * above. On kernel entry, srso_untrain_ret() is executed which is a
+ *
+ * movabs $0xccccc30824648d48,%rax
+ *
+ * and when the return thunk executes the inner label srso_safe_ret()
+ * later, it is a stack manipulation and a RET which is mispredicted and
+ * thus a "safe" one to use.
+ */
+	.align 64
+	.skip 64 - (srso_safe_ret - srso_untrain_ret), 0xcc
+SYM_START(srso_untrain_ret, SYM_L_LOCAL, SYM_A_NONE)
+	ANNOTATE_NOENDBR
+	.byte 0x48, 0xb8
+
+/*
+ * This forces the function return instruction to speculate into a trap
+ * (UD2 in srso_return_thunk() below).  This RET will then mispredict
+ * and execution will continue at the return site read from the top of
+ * the stack.
+ */
+SYM_INNER_LABEL(srso_safe_ret, SYM_L_GLOBAL)
+	lea 8(%_ASM_SP), %_ASM_SP
+	ret
+	int3
+	int3
+	/* end of movabs */
+	lfence
+	call srso_safe_ret
+	ud2
+SYM_CODE_END(srso_safe_ret)
+SYM_FUNC_END(srso_untrain_ret)
+
+SYM_CODE_START(srso_return_thunk)
+	UNWIND_HINT_FUNC
+	ANNOTATE_NOENDBR
+	call srso_safe_ret
+	ud2
+SYM_CODE_END(srso_return_thunk)
+
+#define JMP_SRSO_UNTRAIN_RET "jmp srso_untrain_ret"
+#define JMP_SRSO_ALIAS_UNTRAIN_RET "jmp srso_alias_untrain_ret"
+#else /* !CONFIG_CPU_SRSO */
+#define JMP_SRSO_UNTRAIN_RET "ud2"
+#define JMP_SRSO_ALIAS_UNTRAIN_RET "ud2"
+#endif /* CONFIG_CPU_SRSO */
+
+#ifdef CONFIG_CPU_UNRET_ENTRY
 
-	.section .text..__x86.return_thunk
 /*
  * Some generic notes on the untraining sequences:
  *
@@ -263,64 +304,21 @@ SYM_CODE_END(retbleed_return_thunk)
 	int3
 SYM_FUNC_END(retbleed_untrain_ret)
 
-/*
- * SRSO untraining sequence for Zen1/2, similar to retbleed_untrain_ret()
- * above. On kernel entry, srso_untrain_ret() is executed which is a
- *
- * movabs $0xccccc30824648d48,%rax
- *
- * and when the return thunk executes the inner label srso_safe_ret()
- * later, it is a stack manipulation and a RET which is mispredicted and
- * thus a "safe" one to use.
- */
-	.align 64
-	.skip 64 - (srso_safe_ret - srso_untrain_ret), 0xcc
-SYM_START(srso_untrain_ret, SYM_L_LOCAL, SYM_A_NONE)
-	ANNOTATE_NOENDBR
-	.byte 0x48, 0xb8
+#define JMP_RETBLEED_UNTRAIN_RET "jmp retbleed_untrain_ret"
+#else /* !CONFIG_CPU_UNRET_ENTRY */
+#define JMP_RETBLEED_UNTRAIN_RET "ud2"
+#endif /* CONFIG_CPU_UNRET_ENTRY */
 
-/*
- * This forces the function return instruction to speculate into a trap
- * (UD2 in srso_return_thunk() below).  This RET will then mispredict
- * and execution will continue at the return site read from the top of
- * the stack.
- */
-SYM_INNER_LABEL(srso_safe_ret, SYM_L_GLOBAL)
-	lea 8(%_ASM_SP), %_ASM_SP
-	ret
-	int3
-	int3
-	/* end of movabs */
-	lfence
-	call srso_safe_ret
-	ud2
-SYM_CODE_END(srso_safe_ret)
-SYM_FUNC_END(srso_untrain_ret)
-
-SYM_CODE_START(srso_return_thunk)
-	UNWIND_HINT_FUNC
-	ANNOTATE_NOENDBR
-	call srso_safe_ret
-	ud2
-SYM_CODE_END(srso_return_thunk)
+#if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_SRSO)
 
 SYM_FUNC_START(entry_untrain_ret)
-	ALTERNATIVE_2 "jmp retbleed_untrain_ret", \
-		      "jmp srso_untrain_ret", X86_FEATURE_SRSO, \
-		      "jmp srso_alias_untrain_ret", X86_FEATURE_SRSO_ALIAS
+	ALTERNATIVE_2 JMP_RETBLEED_UNTRAIN_RET,				\
+		      JMP_SRSO_UNTRAIN_RET, X86_FEATURE_SRSO,		\
+		      JMP_SRSO_ALIAS_UNTRAIN_RET, X86_FEATURE_SRSO_ALIAS
 SYM_FUNC_END(entry_untrain_ret)
 __EXPORT_THUNK(entry_untrain_ret)
 
-SYM_CODE_START(__x86_return_thunk)
-	UNWIND_HINT_FUNC
-	ANNOTATE_NOENDBR
-	ANNOTATE_UNRET_SAFE
-	ret
-	int3
-SYM_CODE_END(__x86_return_thunk)
-EXPORT_SYMBOL(__x86_return_thunk)
-
-#endif /* CONFIG_RETHUNK */
+#endif /* CONFIG_CPU_UNRET_ENTRY || CONFIG_CPU_SRSO */
 
 #ifdef CONFIG_CALL_DEPTH_TRACKING
 
@@ -355,3 +353,22 @@ SYM_FUNC_START(__x86_return_skl)
 SYM_FUNC_END(__x86_return_skl)
 
 #endif /* CONFIG_CALL_DEPTH_TRACKING */
+
+/*
+ * This function name is magical and is used by -mfunction-return=thunk-extern
+ * for the compiler to generate JMPs to it.
+ *
+ * This code is only used during kernel boot or module init.  All
+ * 'JMP __x86_return_thunk' sites are changed to something else by
+ * apply_returns().
+ */
+SYM_CODE_START(__x86_return_thunk)
+	UNWIND_HINT_FUNC
+	ANNOTATE_NOENDBR
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+SYM_CODE_END(__x86_return_thunk)
+EXPORT_SYMBOL(__x86_return_thunk)
+
+#endif /* CONFIG_RETHUNK */
