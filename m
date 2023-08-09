Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40272775416
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjHIH1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjHIH1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:27:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A1E172A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 00:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=L6x3kVxUE3s/H9crPlilToHgB3RKOM6Y1VQ2t5HuPBg=; b=ff48PyY6cGaYGqbYYTnJtNwsqX
        YOPcf7DPGcTlNXIpAlmDn07BfSPk3Ic62xo0RE61AwocGMNckO/w1mahe0z9uBxBYYVmjgn1DD8ic
        1yLU6VbiGTudlk1lWRq8EIxne/Uz7CRhSAox0A0oaUwZOiprggyQPxmjFX4Yy5Pba2wdEZVIF4frZ
        H2zOMq1ASh/LUqj82cWy+VHc0H6N05lx5KT6gVfqPctAHQBC8/yNVlk7sVGMfoJo/LVCwKR2XnooN
        uKrdzm41Ql3bYNuA2wiGPWPX1Y/HrCSzc51uzQE6BbA56yrpTa7SR3DaP+cpM4rL2tr6EX8rtKnVw
        hZghvFJw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qTdaf-004olO-Mz; Wed, 09 Aug 2023 07:26:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 96ADF30058D;
        Wed,  9 Aug 2023 09:26:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 70EA82CEC71E1; Wed,  9 Aug 2023 09:26:44 +0200 (CEST)
Message-ID: <20230809072201.058602783@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 09 Aug 2023 09:12:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        David.Kaplan@amd.com, Andrew.Cooper3@citrix.com,
        jpoimboe@kernel.org, gregkh@linuxfoundation.org
Subject: [RFC][PATCH 09/17] x86: Remove CONFIG_CPU_SRSO
References: <20230809071218.000335006@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It doesn't do anything useful anymore (it never really did), remove it
and while at it, put all the untrain and return thunk mess under
CPU_UNRET_ENTRY.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/Kconfig                     |    7 -------
 arch/x86/include/asm/nospec-branch.h |    9 ++++-----
 arch/x86/kernel/vmlinux.lds.S        |    9 +++------
 arch/x86/lib/retpoline.S             |   23 +++++++++++++++++------
 4 files changed, 24 insertions(+), 24 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2593,13 +2593,6 @@ config CPU_IBRS_ENTRY
 	  This mitigates both spectre_v2 and retbleed at great cost to
 	  performance.
 
-config CPU_SRSO
-	bool "Mitigate speculative RAS overflow on AMD"
-	depends on CPU_SUP_AMD && X86_64 && RETHUNK
-	default y
-	help
-	  Enable the SRSO mitigation needed on AMD Zen1-4 machines.
-
 config SLS
 	bool "Mitigate Straight-Line-Speculation"
 	depends on CC_HAS_SLS && X86_64
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -211,8 +211,7 @@
  * eventually turn into it's own annotation.
  */
 .macro VALIDATE_UNRET_END
-#if defined(CONFIG_NOINSTR_VALIDATION) && \
-	(defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_SRSO))
+#if defined(CONFIG_NOINSTR_VALIDATION) && defined(CONFIG_CPU_UNRET_ENTRY)
 	ANNOTATE_RETPOLINE_SAFE
 	nop
 #endif
@@ -290,7 +289,7 @@
  */
 .macro UNTRAIN_RET
 #if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_IBPB_ENTRY) || \
-	defined(CONFIG_CALL_DEPTH_TRACKING) || defined(CONFIG_CPU_SRSO)
+    defined(CONFIG_CALL_DEPTH_TRACKING)
 	VALIDATE_UNRET_END
 	ALTERNATIVE_3 "",						\
 		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
@@ -301,7 +300,7 @@
 
 .macro UNTRAIN_RET_VM
 #if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_IBPB_ENTRY) || \
-	defined(CONFIG_CALL_DEPTH_TRACKING) || defined(CONFIG_CPU_SRSO)
+    defined(CONFIG_CALL_DEPTH_TRACKING)
 	VALIDATE_UNRET_END
 	ALTERNATIVE_3 "",						\
 		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
@@ -312,7 +311,7 @@
 
 .macro UNTRAIN_RET_FROM_CALL
 #if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_IBPB_ENTRY) || \
-	defined(CONFIG_CALL_DEPTH_TRACKING)
+    defined(CONFIG_CALL_DEPTH_TRACKING)
 	VALIDATE_UNRET_END
 	ALTERNATIVE_3 "",						\
 		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -141,13 +141,13 @@ SECTIONS
 		STATIC_CALL_TEXT
 
 		ALIGN_ENTRY_TEXT_BEGIN
-#ifdef CONFIG_CPU_SRSO
+#ifdef CONFIG_CPU_UNRET_ENTRY
 		*(.text.__x86.rethunk_untrain)
 #endif
 
 		ENTRY_TEXT
 
-#ifdef CONFIG_CPU_SRSO
+#ifdef CONFIG_CPU_UNRET_ENTRY
 		/*
 		 * See the comment above srso_untrain_ret_alias()'s
 		 * definition.
@@ -522,12 +522,9 @@ INIT_PER_CPU(irq_stack_backing_store);
            "fixed_percpu_data is not at start of per-cpu area");
 #endif
 
-#ifdef CONFIG_RETHUNK
+#ifdef CONFIG_CPU_UNRET_ENTRY
 . = ASSERT((__x86_return_thunk & 0x3f) == 0, "__x86_return_thunk not cacheline-aligned");
 . = ASSERT((srso_safe_ret & 0x3f) == 0, "srso_safe_ret not cacheline-aligned");
-#endif
-
-#ifdef CONFIG_CPU_SRSO
 /*
  * GNU ld cannot do XOR so do: (A | B) - (A & B) in order to compute the XOR
  * of the two function addresses:
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -132,6 +132,7 @@ SYM_CODE_END(__x86_indirect_jump_thunk_a
  */
 #ifdef CONFIG_RETHUNK
 
+#ifdef CONFIG_CPU_UNRET_ENTRY
 /*
  * srso_untrain_ret_alias() and srso_safe_ret_alias() are placed at
  * special addresses:
@@ -147,7 +148,6 @@ SYM_CODE_END(__x86_indirect_jump_thunk_a
  *
  * As a result, srso_safe_ret_alias() becomes a safe return.
  */
-#ifdef CONFIG_CPU_SRSO
 	.section .text.__x86.rethunk_untrain
 
 SYM_START(srso_untrain_ret_alias, SYM_L_GLOBAL, SYM_A_NONE)
@@ -160,14 +160,11 @@ SYM_FUNC_END(srso_untrain_ret_alias)
 __EXPORT_THUNK(srso_untrain_ret_alias)
 
 	.section .text.__x86.rethunk_safe
-#endif
 
 /* Needs a definition for the __x86_return_thunk alternative below. */
 SYM_START(srso_safe_ret_alias, SYM_L_GLOBAL, SYM_A_NONE)
-#ifdef CONFIG_CPU_SRSO
 	add $8, %_ASM_SP
 	UNWIND_HINT_FUNC
-#endif
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3
@@ -236,8 +233,6 @@ SYM_CODE_END(__x86_return_thunk)
 SYM_FUNC_END(zen_untrain_ret)
 __EXPORT_THUNK(zen_untrain_ret)
 
-EXPORT_SYMBOL(__x86_return_thunk)
-
 /*
  * SRSO untraining sequence for Zen1/2, similar to zen_untrain_ret()
  * above. On kernel entry, srso_untrain_ret() is executed which is a
@@ -293,6 +288,22 @@ SYM_CODE_START(srso_alias_return_thunk)
 	ud2
 SYM_CODE_END(srso_alias_return_thunk)
 
+#else /* CONFIG_CPU_UNRET_ENTRY */
+
+	.section .text.__x86.return_thunk
+
+SYM_CODE_START(__x86_return_thunk)
+	UNWIND_HINT_FUNC
+	ANNOTATE_NOENDBR
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+SYM_CODE_END(__x86_return_thunk)
+
+#endif /* CONFIG_CPU_UNRET_ENTRY */
+
+__EXPORT_THUNK(__x86_return_thunk)
+
 #endif /* CONFIG_RETHUNK */
 
 #ifdef CONFIG_CALL_DEPTH_TRACKING


