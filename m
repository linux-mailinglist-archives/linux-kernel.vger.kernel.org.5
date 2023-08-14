Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023FA77B883
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbjHNMUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbjHNMTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:19:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BF0133
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=V9fM2o7mhVY5C/pJpd3IZUYsrW+NYZNMXL2ceFzfrn8=; b=NwWe9FkE7X3q+hcfXBWMgR5r8t
        ezINDHcVB1OaVd5oGEY+P+0vCU5fxn6e6SO2CwOdXM5OHjMJEZToxhvQeCK166rj+0WNTLzjB86Xa
        dtCumrecatJMivYZJkgvhNBOpRJjpUWYOi8mRKPlLva3nAHAGTqaeUU4e00GJ+eZxKsK11sUQ/9/z
        2lnvNbki6pBcjWUPbx1jwBuXaaLLt95S1tSrqOdMJFWcUKrgjQpvywxj4Q1X8GRSQOszGRVM6LB6x
        pM9BaUCGnVmp2SJi6IxpAltSmB715Fm3HeZ/ux7TF/b/L+yiAVj3+kun1Ozd7kBwn8fLe0va5CVWX
        Mn/FUObQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qVWXY-00AaKc-38;
        Mon, 14 Aug 2023 12:19:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E4FB43008CD;
        Mon, 14 Aug 2023 14:19:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C318721C1D1B4; Mon, 14 Aug 2023 14:19:19 +0200 (CEST)
Message-ID: <20230814121148.842775684@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 14 Aug 2023 13:44:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        David.Kaplan@amd.com, Andrew.Cooper3@citrix.com,
        jpoimboe@kernel.org, gregkh@linuxfoundation.org,
        nik.borisov@suse.com
Subject: [PATCH v2 05/11] x86/cpu: Clean up SRSO return thunk mess
References: <20230814114426.057251214@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
(test,movabs) Zen3/4 use instruction aliasing. SRSO adds RSB (RAP in
AMD speak) stuffing to force speculation into a trap an cause a
mis-predict.

Pick one of three options at boot (evey function can only ever return
once).

Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/nospec-branch.h |    6 ++++
 arch/x86/kernel/cpu/bugs.c           |    8 ++++--
 arch/x86/kernel/vmlinux.lds.S        |    2 -
 arch/x86/lib/retpoline.S             |   45 ++++++++++++++++++++++-------------
 tools/objtool/arch/x86/decode.c      |    2 -
 5 files changed, 43 insertions(+), 20 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -342,9 +342,15 @@ extern retpoline_thunk_t __x86_indirect_
 extern retpoline_thunk_t __x86_indirect_jump_thunk_array[];
 
 extern void __x86_return_thunk(void);
+
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
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1034,6 +1034,7 @@ static void __init retbleed_select_mitig
 	case RETBLEED_MITIGATION_UNRET:
 		setup_force_cpu_cap(X86_FEATURE_RETHUNK);
 		setup_force_cpu_cap(X86_FEATURE_UNRET);
+		x86_return_thunk = zen_return_thunk;
 
 		if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
 		    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
@@ -2451,10 +2452,13 @@ static void __init srso_select_mitigatio
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
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -521,7 +521,7 @@ INIT_PER_CPU(irq_stack_backing_store);
 #endif
 
 #ifdef CONFIG_RETHUNK
-. = ASSERT((__ret & 0x3f) == 0, "__ret not cacheline-aligned");
+. = ASSERT((zen_return_thunk & 0x3f) == 0, "zen_return_thunk not cacheline-aligned");
 . = ASSERT((srso_safe_ret & 0x3f) == 0, "srso_safe_ret not cacheline-aligned");
 #endif
 
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -151,22 +151,20 @@ SYM_CODE_END(__x86_indirect_jump_thunk_a
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
@@ -174,9 +172,16 @@ SYM_FUNC_END(srso_safe_ret_alias)
 
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
@@ -184,7 +189,7 @@ SYM_FUNC_END(srso_safe_ret_alias)
  *    from re-poisioning the BTB prediction.
  */
 	.align 64
-	.skip 64 - (__ret - zen_untrain_ret), 0xcc
+	.skip 64 - (zen_return_thunk - zen_untrain_ret), 0xcc
 SYM_START(zen_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	ANNOTATE_NOENDBR
 	/*
@@ -192,16 +197,16 @@ SYM_START(zen_untrain_ret, SYM_L_GLOBAL,
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
@@ -213,13 +218,13 @@ SYM_START(zen_untrain_ret, SYM_L_GLOBAL,
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
@@ -230,7 +235,7 @@ SYM_CODE_END(__ret)
 	 * Jump back and execute the RET in the middle of the TEST instruction.
 	 * INT3 is for SLS protection.
 	 */
-	jmp __ret
+	jmp zen_return_thunk
 	int3
 SYM_FUNC_END(zen_untrain_ret)
 __EXPORT_THUNK(zen_untrain_ret)
@@ -256,6 +261,7 @@ SYM_INNER_LABEL(srso_safe_ret, SYM_L_GLO
 	ret
 	int3
 	int3
+	/* end of movabs */
 	lfence
 	call srso_safe_ret
 	ud2
@@ -263,12 +269,19 @@ SYM_CODE_END(srso_safe_ret)
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
 
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -829,6 +829,6 @@ bool arch_is_rethunk(struct symbol *sym)
 
 bool arch_is_embedded_insn(struct symbol *sym)
 {
-	return !strcmp(sym->name, "__ret") ||
+	return !strcmp(sym->name, "zen_return_thunk") ||
 	       !strcmp(sym->name, "srso_safe_ret");
 }


