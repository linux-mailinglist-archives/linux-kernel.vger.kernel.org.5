Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23270792A18
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236975AbjIEQdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351057AbjIEFFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 01:05:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B973BCC7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 22:05:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34253B810AA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 05:05:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C278C43395;
        Tue,  5 Sep 2023 05:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693890316;
        bh=OTcpk4MOHxISz10qIDR2/2xXRHb7xPwb/6/d1OMiDNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bbI7Ht0LAoAC/LxnslX17UPSxiPrsTMOKW0QHmdcWvo7B/QDdsVzwnyyIAyNWXfYh
         TeyPQ5fZM0ta912UPpI8hXsCuofVZ5QLczk3KkaBCEUaYg0WOEv/mtV5WbtNRdpIb9
         RLc0El26ic2A/793bstT9wRpL/7wcNad1LlM7uXBf/WXl6rc5mzITw4LUCTHYYynFf
         xZCN6lkIXJC7Bkf4WcTgfgnhKWuJmIXlPZurSTznGp6aEESiSXpH6c/y/t3hOnOZka
         bOs9YC4fJBsl+YVd3yD5J+l6ZHXF+k+mqoQcLFCAtLzKj5RIoNft/RKTuMA+ZAKbRh
         9k9p8cAaKd7sA==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3 16/20] x86/srso: Disentangle rethunk-dependent options
Date:   Mon,  4 Sep 2023 22:05:00 -0700
Message-ID: <2845084ed303d8384905db3b87b77693945302b4.1693889988.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693889988.git.jpoimboe@kernel.org>
References: <cover.1693889988.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_RETHUNK, CONFIG_CPU_UNRET_ENTRY and CONFIG_CPU_SRSO are all
tangled up.  De-spaghettify the code a bit.

Some of the rethunk-related code has been shuffled around within the
'.text..__x86.return_thunk' section, but otherwise there are no
functional changes.  srso_alias_untrain_ret() and srso_alias_safe_ret()
((which are very address-sensitive) haven't moved.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/nospec-branch.h |  25 +++--
 arch/x86/kernel/cpu/bugs.c           |   5 +-
 arch/x86/kernel/vmlinux.lds.S        |   7 +-
 arch/x86/lib/retpoline.S             | 157 +++++++++++++++------------
 4 files changed, 109 insertions(+), 85 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 6c14fd1f5912..51e3f1a287d2 100644
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
index 6b443f0fde34..9731e814dcb6 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -63,7 +63,7 @@ EXPORT_SYMBOL_GPL(x86_pred_cmd);
 
 static DEFINE_MUTEX(spec_ctrl_mutex);
 
-void (*x86_return_thunk)(void) __ro_after_init = &__x86_return_thunk;
+void (*x86_return_thunk)(void) __ro_after_init = __x86_return_thunk;
 
 /* Update SPEC_CTRL MSR and its cached copy unconditionally */
 static void update_spec_ctrl(u64 val)
@@ -1041,8 +1041,7 @@ static void __init retbleed_select_mitigation(void)
 		setup_force_cpu_cap(X86_FEATURE_RETHUNK);
 		setup_force_cpu_cap(X86_FEATURE_UNRET);
 
-		if (IS_ENABLED(CONFIG_RETHUNK))
-			x86_return_thunk = retbleed_return_thunk;
+		x86_return_thunk = retbleed_return_thunk;
 
 		if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
 		    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 83d41c2601d7..9188834e56c9 100644
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
index a40ba18610d8..8ba79d2b8997 100644
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
-- 
2.41.0

