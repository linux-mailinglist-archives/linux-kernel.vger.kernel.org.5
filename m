Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EF4775410
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjHIH1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjHIH1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:27:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA743172A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 00:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=exUBzq/dF7lmdYkBLNsZoUkJD4k+zb5rOeJWW508skg=; b=JxDWLZvMnGQatlKLB+c3K0MQdb
        pfOc2Hs9/KVby/P2OhY7l1hl2dly5eJptfTxkQD/guGWDDsjS2VBNff9JEch82WMG3B2XQiB+gVBW
        6TW0+mLoyygAskPidPOQMyn/mh1Im8yjMujHVFoCCeZS70FW3pjBwts0cnIJ4rIGdPqnzYsu6Td3G
        MumArwqbWMUv/rcRe9U6X/8xEXSIdWTjQgXRaMGZQa9NHsTzQjP2B28CYTLVxQ+DuRJ3aRij2HmV1
        1JXAs31lA+mURcNYJUARJ/9S5AVpNjMjfnuwYEYSxEhrzWTVx+hfgvyxkBCDHdNNKH/eJpN3Zf4MX
        3uPg5XmA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qTdae-004olM-Ro; Wed, 09 Aug 2023 07:26:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 60E623003F1;
        Wed,  9 Aug 2023 09:26:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 439E8201D9950; Wed,  9 Aug 2023 09:26:44 +0200 (CEST)
Message-ID: <20230809072200.543939260@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 09 Aug 2023 09:12:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        David.Kaplan@amd.com, Andrew.Cooper3@citrix.com,
        jpoimboe@kernel.org, gregkh@linuxfoundation.org
Subject: [RFC][PATCH 02/17] x86/cpu: Clean up SRSO return thunk mess
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

  srso_safe_ret: // embedded in movabs immediate
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

Where Zen1/2 flush the BTB using the instruction decoder trick
(test,movabs) Zen3/4 use instruction aliasing. SRSO adds RSB (RAP in
AMD speak) stuffing to force a return mis-predict.

That is; the AMD retbleed is a form of Speculative-Type-Confusion
where the branch predictor is trained to use the BTB to predict the
RET address, while AMD inception/SRSO is a form of
Speculative-Type-Confusion where another instruction is trained to be
treated like a CALL instruction and poison the RSB (RAP).

Pick one of three options at boot.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/nospec-branch.h |    4 +++
 arch/x86/kernel/cpu/bugs.c           |    7 ++++--
 arch/x86/kernel/vmlinux.lds.S        |    2 -
 arch/x86/lib/retpoline.S             |   37 ++++++++++++++++++++++++-----------
 4 files changed, 36 insertions(+), 14 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -342,9 +342,13 @@ extern retpoline_thunk_t __x86_indirect_
 extern retpoline_thunk_t __x86_indirect_jump_thunk_array[];
 
 extern void __x86_return_thunk(void);
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
@@ -2305,10 +2305,13 @@ static void __init srso_select_mitigatio
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
@@ -523,7 +523,7 @@ INIT_PER_CPU(irq_stack_backing_store);
 #endif
 
 #ifdef CONFIG_RETHUNK
-. = ASSERT((__ret & 0x3f) == 0, "__ret not cacheline-aligned");
+. = ASSERT((__x86_return_thunk & 0x3f) == 0, "__x86_return_thunk not cacheline-aligned");
 . = ASSERT((srso_safe_ret & 0x3f) == 0, "srso_safe_ret not cacheline-aligned");
 #endif
 
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -151,10 +151,11 @@ SYM_CODE_END(__x86_indirect_jump_thunk_a
 	.section .text.__x86.rethunk_untrain
 
 SYM_START(srso_untrain_ret_alias, SYM_L_GLOBAL, SYM_A_NONE)
+	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
 	ASM_NOP2
 	lfence
-	jmp __x86_return_thunk
+	jmp srso_alias_return_thunk
 SYM_FUNC_END(srso_untrain_ret_alias)
 __EXPORT_THUNK(srso_untrain_ret_alias)
 
@@ -184,7 +185,7 @@ SYM_FUNC_END(srso_safe_ret_alias)
  *    from re-poisioning the BTB prediction.
  */
 	.align 64
-	.skip 64 - (__ret - zen_untrain_ret), 0xcc
+	.skip 64 - (__x86_return_thunk - zen_untrain_ret), 0xcc
 SYM_START(zen_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	ANNOTATE_NOENDBR
 	/*
@@ -216,10 +217,10 @@ SYM_START(zen_untrain_ret, SYM_L_GLOBAL,
 	 * evicted, __x86_return_thunk will suffer Straight Line Speculation
 	 * which will be contained safely by the INT3.
 	 */
-SYM_INNER_LABEL(__ret, SYM_L_GLOBAL)
+SYM_INNER_LABEL(__x86_return_thunk, SYM_L_GLOBAL)
 	ret
 	int3
-SYM_CODE_END(__ret)
+SYM_CODE_END(__x86_return_thunk)
 
 	/*
 	 * Ensure the TEST decoding / BTB invalidation is complete.
@@ -230,11 +231,13 @@ SYM_CODE_END(__ret)
 	 * Jump back and execute the RET in the middle of the TEST instruction.
 	 * INT3 is for SLS protection.
 	 */
-	jmp __ret
+	jmp __x86_return_thunk
 	int3
 SYM_FUNC_END(zen_untrain_ret)
 __EXPORT_THUNK(zen_untrain_ret)
 
+EXPORT_SYMBOL(__x86_return_thunk)
+
 /*
  * SRSO untraining sequence for Zen1/2, similar to zen_untrain_ret()
  * above. On kernel entry, srso_untrain_ret() is executed which is a
@@ -257,6 +260,7 @@ SYM_INNER_LABEL(srso_safe_ret, SYM_L_GLO
 	int3
 	int3
 	int3
+	/* end of movabs */
 	lfence
 	call srso_safe_ret
 	int3
@@ -264,12 +268,23 @@ SYM_CODE_END(srso_safe_ret)
 SYM_FUNC_END(srso_untrain_ret)
 __EXPORT_THUNK(srso_untrain_ret)
 
-SYM_FUNC_START(__x86_return_thunk)
-	ALTERNATIVE_2 "jmp __ret", "call srso_safe_ret", X86_FEATURE_SRSO, \
-			"call srso_safe_ret_alias", X86_FEATURE_SRSO_ALIAS
-	int3
-SYM_CODE_END(__x86_return_thunk)
-EXPORT_SYMBOL(__x86_return_thunk)
+/*
+ * Both these do an unbalanced CALL to mess up the RSB, terminate with UD2
+ * to indicate noreturn.
+ */
+SYM_CODE_START(srso_return_thunk)
+	UNWIND_HINT_FUNC
+	ANNOTATE_NOENDBR
+	call srso_safe_ret
+	ud2
+SYM_CODE_END(srso_return_thunk)
+
+SYM_CODE_START(srso_alias_return_thunk)
+	UNWIND_HINT_FUNC
+	ANNOTATE_NOENDBR
+	call srso_safe_ret_alias
+	ud2
+SYM_CODE_END(srso_alias_return_thunk)
 
 #endif /* CONFIG_RETHUNK */
 


