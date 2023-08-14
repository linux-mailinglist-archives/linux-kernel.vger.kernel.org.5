Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E886377B886
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbjHNMUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbjHNMTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:19:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD78195
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=d6SegL+nYoLh8jug65feyPeZBS++RFW4LBO1LVgSiZQ=; b=u9PDo1PR8M5ZlIrVBEE8OU3DVa
        6uG13G2dAgcE8HtCx9/e+Wugl7jpbBFStGt2VECnTnmgqF0A+2GnQWuOxR/9SoumImJmFkxkpsk3E
        TtlMNxALBA9f9vtc/PrSoi2QGLGWlL438U9DElHZWlkv0Mxo4fMh3Rb43dUoemYs6QowKX24R+TZ8
        FJiSvlZNJUWDUn+gOGejGwqTlDGSUuwSw+Kfbs3QZyewwWAfWdtR8/twjj6EVUBJQOH07in5Kause
        Z54HfX+c8rX8yNVL28kIkToH0AJqCJeS+Y9cMtuEr3USGHIoJW4Dws55/vDFWJBIdt5Jgc5NlwTlX
        FnMLuzGQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qVWXY-001t4D-VY; Mon, 14 Aug 2023 12:19:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E4DF43007FB;
        Mon, 14 Aug 2023 14:19:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C74CB21C1D1B5; Mon, 14 Aug 2023 14:19:19 +0200 (CEST)
Message-ID: <20230814121148.909378169@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 14 Aug 2023 13:44:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        David.Kaplan@amd.com, Andrew.Cooper3@citrix.com,
        jpoimboe@kernel.org, gregkh@linuxfoundation.org,
        nik.borisov@suse.com
Subject: [PATCH v2 06/11] x86/cpu: Rename original retbleed methods
References: <20230814114426.057251214@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the original retbleed return thunk and untrain_ret to
retbleed_return_thunk and retbleed_untrain_ret.

Andrew wants to call this btc_*, do we have a poll?

Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/nospec-branch.h |    8 ++++----
 arch/x86/kernel/cpu/bugs.c           |    2 +-
 arch/x86/kernel/vmlinux.lds.S        |    2 +-
 arch/x86/lib/retpoline.S             |   30 +++++++++++++++---------------
 tools/objtool/arch/x86/decode.c      |    2 +-
 tools/objtool/check.c                |    2 +-
 6 files changed, 23 insertions(+), 23 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -272,7 +272,7 @@
 .endm
 
 #ifdef CONFIG_CPU_UNRET_ENTRY
-#define CALL_ZEN_UNTRAIN_RET	"call zen_untrain_ret"
+#define CALL_ZEN_UNTRAIN_RET	"call retbleed_untrain_ret"
 #else
 #define CALL_ZEN_UNTRAIN_RET	""
 #endif
@@ -282,7 +282,7 @@
  * return thunk isn't mapped into the userspace tables (then again, AMD
  * typically has NO_MELTDOWN).
  *
- * While zen_untrain_ret() doesn't clobber anything but requires stack,
+ * While retbleed_untrain_ret() doesn't clobber anything but requires stack,
  * entry_ibpb() will clobber AX, CX, DX.
  *
  * As such, this must be placed after every *SWITCH_TO_KERNEL_CR3 at a point
@@ -343,11 +343,11 @@ extern retpoline_thunk_t __x86_indirect_
 
 extern void __x86_return_thunk(void);
 
-extern void zen_return_thunk(void);
+extern void retbleed_return_thunk(void);
 extern void srso_return_thunk(void);
 extern void srso_alias_return_thunk(void);
 
-extern void zen_untrain_ret(void);
+extern void retbleed_untrain_ret(void);
 extern void srso_untrain_ret(void);
 extern void srso_untrain_ret_alias(void);
 
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1034,7 +1034,7 @@ static void __init retbleed_select_mitig
 	case RETBLEED_MITIGATION_UNRET:
 		setup_force_cpu_cap(X86_FEATURE_RETHUNK);
 		setup_force_cpu_cap(X86_FEATURE_UNRET);
-		x86_return_thunk = zen_return_thunk;
+		x86_return_thunk = retbleed_return_thunk;
 
 		if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
 		    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -521,7 +521,7 @@ INIT_PER_CPU(irq_stack_backing_store);
 #endif
 
 #ifdef CONFIG_RETHUNK
-. = ASSERT((zen_return_thunk & 0x3f) == 0, "zen_return_thunk not cacheline-aligned");
+. = ASSERT((retbleed_return_thunk & 0x3f) == 0, "retbleed_return_thunk not cacheline-aligned");
 . = ASSERT((srso_safe_ret & 0x3f) == 0, "srso_safe_ret not cacheline-aligned");
 #endif
 
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -181,32 +181,32 @@ SYM_CODE_END(srso_alias_return_thunk)
 
 /*
  * Safety details here pertain to the AMD Zen{1,2} microarchitecture:
- * 1) The RET at zen_return_thunk must be on a 64 byte boundary, for
+ * 1) The RET at retbleed_return_thunk must be on a 64 byte boundary, for
  *    alignment within the BTB.
- * 2) The instruction at zen_untrain_ret must contain, and not
+ * 2) The instruction at retbleed_untrain_ret must contain, and not
  *    end with, the 0xc3 byte of the RET.
  * 3) STIBP must be enabled, or SMT disabled, to prevent the sibling thread
  *    from re-poisioning the BTB prediction.
  */
 	.align 64
-	.skip 64 - (zen_return_thunk - zen_untrain_ret), 0xcc
-SYM_START(zen_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
+	.skip 64 - (retbleed_return_thunk - retbleed_untrain_ret), 0xcc
+SYM_START(retbleed_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	ANNOTATE_NOENDBR
 	/*
-	 * As executed from zen_untrain_ret, this is:
+	 * As executed from retbleed_untrain_ret, this is:
 	 *
 	 *   TEST $0xcc, %bl
 	 *   LFENCE
-	 *   JMP zen_return_thunk
+	 *   JMP retbleed_return_thunk
 	 *
 	 * Executing the TEST instruction has a side effect of evicting any BTB
 	 * prediction (potentially attacker controlled) attached to the RET, as
-	 * zen_return_thunk + 1 isn't an instruction boundary at the moment.
+	 * retbleed_return_thunk + 1 isn't an instruction boundary at the moment.
 	 */
 	.byte	0xf6
 
 	/*
-	 * As executed from zen_return_thunk, this is a plain RET.
+	 * As executed from retbleed_return_thunk, this is a plain RET.
 	 *
 	 * As part of the TEST above, RET is the ModRM byte, and INT3 the imm8.
 	 *
@@ -218,13 +218,13 @@ SYM_START(zen_untrain_ret, SYM_L_GLOBAL,
 	 * With SMT enabled and STIBP active, a sibling thread cannot poison
 	 * RET's prediction to a type of its choice, but can evict the
 	 * prediction due to competitive sharing. If the prediction is
-	 * evicted, zen_return_thunk will suffer Straight Line Speculation
+	 * evicted, retbleed_return_thunk will suffer Straight Line Speculation
 	 * which will be contained safely by the INT3.
 	 */
-SYM_INNER_LABEL(zen_return_thunk, SYM_L_GLOBAL)
+SYM_INNER_LABEL(retbleed_return_thunk, SYM_L_GLOBAL)
 	ret
 	int3
-SYM_CODE_END(zen_return_thunk)
+SYM_CODE_END(retbleed_return_thunk)
 
 	/*
 	 * Ensure the TEST decoding / BTB invalidation is complete.
@@ -235,13 +235,13 @@ SYM_CODE_END(zen_return_thunk)
 	 * Jump back and execute the RET in the middle of the TEST instruction.
 	 * INT3 is for SLS protection.
 	 */
-	jmp zen_return_thunk
+	jmp retbleed_return_thunk
 	int3
-SYM_FUNC_END(zen_untrain_ret)
-__EXPORT_THUNK(zen_untrain_ret)
+SYM_FUNC_END(retbleed_untrain_ret)
+__EXPORT_THUNK(retbleed_untrain_ret)
 
 /*
- * SRSO untraining sequence for Zen1/2, similar to zen_untrain_ret()
+ * SRSO untraining sequence for Zen1/2, similar to retbleed_untrain_ret()
  * above. On kernel entry, srso_untrain_ret() is executed which is a
  *
  * movabs $0xccccc30824648d48,%rax
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -829,6 +829,6 @@ bool arch_is_rethunk(struct symbol *sym)
 
 bool arch_is_embedded_insn(struct symbol *sym)
 {
-	return !strcmp(sym->name, "zen_return_thunk") ||
+	return !strcmp(sym->name, "retbleed_return_thunk") ||
 	       !strcmp(sym->name, "srso_safe_ret");
 }
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1593,7 +1593,7 @@ static int add_jump_destinations(struct
 			struct symbol *sym = find_symbol_by_offset(dest_sec, dest_off);
 
 			/*
-			 * This is a special case for zen_untrain_ret().
+			 * This is a special case for retbleed_untrain_ret().
 			 * It jumps to __x86_return_thunk(), but objtool
 			 * can't find the thunk's starting RET
 			 * instruction, because the RET is also in the


