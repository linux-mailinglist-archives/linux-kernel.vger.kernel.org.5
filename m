Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC05775409
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbjHIH1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjHIH04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:26:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006751FC2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 00:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=QMN+KFisRymU9TcNWqSM8k2+97IHEcssxz44vlKQWWY=; b=E3O8ASWl7q/vnnAL84OuhHQILy
        bPhtSNFIGFdXsVN42ufxc4dm7y7+W+MT70WT8zgsLOaI02dWcrliXIO2jGDgkgyFdfTVXsy8MAmyx
        KSIkVEBmhFvX44dGBy6u8WdZVSOrBqO95B3LJSKNJn39TY7h5FYvSw29PdD0fBtSCG3VMTYxwZx7g
        BNpwbcVISufk6a2cJVRvwTj+ojRyA+6R68Wl3Db2MQiBzaXJUPByWIKzH6bd89cgB2Smubinku013
        GgjBhEOYXJg1mLSm5FfOX9vovd7wdnX9Xp8A17PDp2Gh1UE3f1e2ay9x2mzGW5xYTejS0DdIkLoKE
        1cDmOFmg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTdag-005TeP-1F;
        Wed, 09 Aug 2023 07:26:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A59DC30334C;
        Wed,  9 Aug 2023 09:26:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8B155201A5786; Wed,  9 Aug 2023 09:26:44 +0200 (CEST)
Message-ID: <20230809072201.259675763@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 09 Aug 2023 09:12:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        David.Kaplan@amd.com, Andrew.Cooper3@citrix.com,
        jpoimboe@kernel.org, gregkh@linuxfoundation.org
Subject: [RFC][PATCH 12/17] x86/cpu: Rename original retbleed return thunk
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

Rename the original retbleed return thunk from __x86_return_thunk to
zen_return_thunk, matching zen_untrain_ret.

Pull the dummy __x86_return_thunk from the !CPU_UNRET_ENTRY case and
explicitly set zen_return_thunk in the retbleed=unret case.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/nospec-branch.h |    2 ++
 arch/x86/kernel/cpu/bugs.c           |    1 +
 arch/x86/kernel/vmlinux.lds.S        |    2 +-
 arch/x86/lib/retpoline.S             |   25 +++++++++++--------------
 tools/objtool/check.c                |    9 +++++++--
 5 files changed, 22 insertions(+), 17 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -339,6 +339,8 @@ extern retpoline_thunk_t __x86_indirect_
 extern retpoline_thunk_t __x86_indirect_jump_thunk_array[];
 
 extern void __x86_return_thunk(void);
+
+extern void zen_return_thunk(void);
 extern void srso_return_thunk(void);
 extern void srso_alias_return_thunk(void);
 
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -953,6 +953,7 @@ static void __init retbleed_select_mitig
 
 	case RETBLEED_MITIGATION_UNRET:
 		setup_force_cpu_cap(X86_FEATURE_UNRET);
+		x86_return_thunk = zen_return_thunk;
 do_rethunk:
 		setup_force_cpu_cap(X86_FEATURE_RETHUNK);
 
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -523,7 +523,7 @@ INIT_PER_CPU(irq_stack_backing_store);
 #endif
 
 #ifdef CONFIG_CPU_UNRET_ENTRY
-. = ASSERT((__x86_return_thunk & 0x3f) == 0, "__x86_return_thunk not cacheline-aligned");
+. = ASSERT((zen_return_thunk & 0x3f) == 0, "zen_return_thunk not cacheline-aligned");
 . = ASSERT((srso_safe_ret & 0x3f) == 0, "srso_safe_ret not cacheline-aligned");
 /*
  * GNU ld cannot do XOR so do: (A | B) - (A & B) in order to compute the XOR
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -161,7 +161,7 @@ __EXPORT_THUNK(srso_untrain_ret_alias)
 
 	.section .text.__x86.rethunk_safe
 
-/* Needs a definition for the __x86_return_thunk alternative below. */
+/* Needs a definition for the zen_return_thunk alternative below. */
 SYM_START(srso_safe_ret_alias, SYM_L_GLOBAL, SYM_A_NONE)
 	add $8, %_ASM_SP
 	UNWIND_HINT_FUNC
@@ -174,7 +174,7 @@ SYM_FUNC_END(srso_safe_ret_alias)
 
 /*
  * Safety details here pertain to the AMD Zen{1,2} microarchitecture:
- * 1) The RET at __x86_return_thunk must be on a 64 byte boundary, for
+ * 1) The RET at zen_return_thunk must be on a 64 byte boundary, for
  *    alignment within the BTB.
  * 2) The instruction at zen_untrain_ret must contain, and not
  *    end with, the 0xc3 byte of the RET.
@@ -182,7 +182,7 @@ SYM_FUNC_END(srso_safe_ret_alias)
  *    from re-poisioning the BTB prediction.
  */
 	.align 64
-	.skip 64 - (__x86_return_thunk - zen_untrain_ret), 0xcc
+	.skip 64 - (zen_return_thunk - zen_untrain_ret), 0xcc
 SYM_START(zen_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	ANNOTATE_NOENDBR
 	/*
@@ -190,16 +190,16 @@ SYM_START(zen_untrain_ret, SYM_L_GLOBAL,
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
@@ -211,13 +211,13 @@ SYM_START(zen_untrain_ret, SYM_L_GLOBAL,
 	 * With SMT enabled and STIBP active, a sibling thread cannot poison
 	 * RET's prediction to a type of its choice, but can evict the
 	 * prediction due to competitive sharing. If the prediction is
-	 * evicted, __x86_return_thunk will suffer Straight Line Speculation
+	 * evicted, zen_return_thunk will suffer Straight Line Speculation
 	 * which will be contained safely by the INT3.
 	 */
-SYM_INNER_LABEL(__x86_return_thunk, SYM_L_GLOBAL)
+SYM_INNER_LABEL(zen_return_thunk, SYM_L_GLOBAL)
 	ret
 	int3
-SYM_CODE_END(__x86_return_thunk)
+SYM_CODE_END(zen_return_thunk)
 
 	/*
 	 * Ensure the TEST decoding / BTB invalidation is complete.
@@ -228,7 +228,7 @@ SYM_CODE_END(__x86_return_thunk)
 	 * Jump back and execute the RET in the middle of the TEST instruction.
 	 * INT3 is for SLS protection.
 	 */
-	jmp __x86_return_thunk
+	jmp zen_return_thunk
 	int3
 SYM_FUNC_END(zen_untrain_ret)
 __EXPORT_THUNK(zen_untrain_ret)
@@ -288,7 +288,7 @@ SYM_CODE_START(srso_alias_return_thunk)
 	ud2
 SYM_CODE_END(srso_alias_return_thunk)
 
-#else /* CONFIG_CPU_UNRET_ENTRY */
+#endif /* CONFIG_CPU_UNRET_ENTRY */
 
 	.section .text.__x86.return_thunk
 
@@ -299,9 +299,6 @@ SYM_CODE_START(__x86_return_thunk)
 	ret
 	int3
 SYM_CODE_END(__x86_return_thunk)
-
-#endif /* CONFIG_CPU_UNRET_ENTRY */
-
 __EXPORT_THUNK(__x86_return_thunk)
 
 #endif /* CONFIG_RETHUNK */
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -455,7 +455,12 @@ static int decode_instructions(struct ob
 				return -1;
 			}
 
-			if (func->return_thunk || !strcmp(func->name, "srso_safe_ret") || func->alias != func)
+			/*
+			 * Both zen_return_thunk() and srso_safe_ret() are embedded inside
+			 * another instruction and objtool doesn't grok that. Skip validating them.
+			 */
+			if (!strcmp(func->name, "zen_return_thunk") ||
+			    !strcmp(func->name, "srso_safe_ret") || func->alias != func)
 				continue;
 
 			if (!find_insn(file, sec, func->offset)) {
@@ -1583,7 +1588,7 @@ static int add_jump_destinations(struct
 			 * middle of another instruction.  Objtool only
 			 * knows about the outer instruction.
 			 */
-			if (sym && sym->return_thunk) {
+			if (sym && !strcmp(sym->name, "zen_return_thunk")) {
 				add_return_call(file, insn, false);
 				continue;
 			}


