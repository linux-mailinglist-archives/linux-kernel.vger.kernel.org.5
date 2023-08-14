Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9536F77B885
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbjHNMUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbjHNMTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:19:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E70F5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=QKrcKC+fz5pTmgDQnsBjyi5G3CXOC+/dSWDSPAW6gBs=; b=OVg8NKHQtT5H6H9wULx8X+67M9
        EjSeq9yBRZs+k7rx8FrbLIIAX9ttDI3xrF7P4TwkL/Jt6nOR3djw1aIO8NaJ1xnaSxhnM6R1chvs/
        zUh2UR2+Jy/kGlj4tZ+94FSiVUOBtJp5xFSmD5CIOonvjOt9pheBYYy9SZJgj1TnABeISJ5/p5tiR
        3eM3hVJO1cGRPDnaPp/g3xreYscpmJNfiCr+Dz6qBE0IyV4sb91kg8uYhdnVpgaZp0PSL86XzypnE
        tIM8SKth2CISswD/0AJbTwZwSeQHduHlNggqpRCgK/8NuF1dx+67b4ARCwTfd7yheN3iT0DfoIqxn
        a53+WypA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qVWXZ-00AaKd-1t;
        Mon, 14 Aug 2023 12:19:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F0F0A301CA0;
        Mon, 14 Aug 2023 14:19:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DC27E20410DA1; Mon, 14 Aug 2023 14:19:19 +0200 (CEST)
Message-ID: <20230814121149.243457126@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 14 Aug 2023 13:44:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        David.Kaplan@amd.com, Andrew.Cooper3@citrix.com,
        jpoimboe@kernel.org, gregkh@linuxfoundation.org,
        nik.borisov@suse.com
Subject: [PATCH v2 11/11] x86/cpu: Use fancy alternatives to get rid of entry_untrain_ret()
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

Use the new nested alternatives to create what is effectively
ALTERNATIVE_5 and merge the dummy entry_untrain_ret stub into
UNTRAIN_RET properly.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/nospec-branch.h |   33 ++++++++++++++++++---------------
 arch/x86/kernel/cpu/bugs.c           |    1 -
 arch/x86/lib/retpoline.S             |    7 -------
 3 files changed, 18 insertions(+), 23 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -272,11 +272,15 @@
 .endm
 
 #ifdef CONFIG_CPU_UNRET_ENTRY
-#define CALL_UNTRAIN_RET	"call entry_untrain_ret"
+#define ALT_UNRET(old)	\
+	__ALTERNATIVE(__ALTERNATIVE(__ALTERNATIVE(old, call retbleed_untrain_ret, X86_FEATURE_UNRET), \
+				    call srso_untrain_ret, X86_FEATURE_SRSO), \
+		      call srso_alias_untrain_ret, X86_FEATURE_SRSO_ALIAS)
 #else
-#define CALL_UNTRAIN_RET	""
+#define ALT_UNRET(old)	old
 #endif
 
+
 /*
  * Mitigate RETBleed for AMD/Hygon Zen uarch. Requires KERNEL CR3 because the
  * return thunk isn't mapped into the userspace tables (then again, AMD
@@ -292,10 +296,10 @@
 #if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_IBPB_ENTRY) || \
 	defined(CONFIG_CALL_DEPTH_TRACKING) || defined(CONFIG_CPU_SRSO)
 	VALIDATE_UNRET_END
-	ALTERNATIVE_3 "",						\
-		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
-		      "call entry_ibpb", X86_FEATURE_ENTRY_IBPB,	\
-		      __stringify(RESET_CALL_DEPTH), X86_FEATURE_CALL_DEPTH
+
+	__ALTERNATIVE(__ALTERNATIVE(ALT_UNRET(;),
+				    call entry_ibpb, X86_FEATURE_ENTRY_IBPB),
+		      RESET_CALL_DEPTH, X86_FEATURE_CALL_DEPTH)
 #endif
 .endm
 
@@ -303,10 +307,10 @@
 #if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_IBPB_ENTRY) || \
 	defined(CONFIG_CALL_DEPTH_TRACKING) || defined(CONFIG_CPU_SRSO)
 	VALIDATE_UNRET_END
-	ALTERNATIVE_3 "",						\
-		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
-		      "call entry_ibpb", X86_FEATURE_IBPB_ON_VMEXIT,	\
-		      __stringify(RESET_CALL_DEPTH), X86_FEATURE_CALL_DEPTH
+
+	__ALTERNATIVE(__ALTERNATIVE(ALT_UNRET(;),
+				    call entry_ibpb, X86_FEATURE_IBPB_ON_VMEXIT),
+		      RESET_CALL_DEPTH, X86_FEATURE_CALL_DEPTH)
 #endif
 .endm
 
@@ -314,10 +318,10 @@
 #if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_IBPB_ENTRY) || \
 	defined(CONFIG_CALL_DEPTH_TRACKING)
 	VALIDATE_UNRET_END
-	ALTERNATIVE_3 "",						\
-		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
-		      "call entry_ibpb", X86_FEATURE_ENTRY_IBPB,	\
-		      __stringify(RESET_CALL_DEPTH_FROM_CALL), X86_FEATURE_CALL_DEPTH
+
+	__ALTERNATIVE(__ALTERNATIVE(ALT_UNRET(;),
+				    call entry_ibpb, X86_FEATURE_ENTRY_IBPB),
+		      RESET_CALL_DEPTH_FROM_CALL, X86_FEATURE_CALL_DEPTH)
 #endif
 .endm
 
@@ -352,7 +356,6 @@ extern void retbleed_untrain_ret(void);
 extern void srso_untrain_ret(void);
 extern void srso_alias_untrain_ret(void);
 
-extern void entry_untrain_ret(void);
 extern void entry_ibpb(void);
 
 extern void (*x86_return_thunk)(void);
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2450,7 +2450,6 @@ static void __init srso_select_mitigatio
 			 * like ftrace, static_call, etc.
 			 */
 			setup_force_cpu_cap(X86_FEATURE_RETHUNK);
-			setup_force_cpu_cap(X86_FEATURE_UNRET);
 
 			if (boot_cpu_data.x86 == 0x19) {
 				setup_force_cpu_cap(X86_FEATURE_SRSO_ALIAS);
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -277,13 +277,6 @@ SYM_CODE_START(srso_return_thunk)
 	ud2
 SYM_CODE_END(srso_return_thunk)
 
-SYM_FUNC_START(entry_untrain_ret)
-	ALTERNATIVE_2 "jmp retbleed_untrain_ret", \
-		      "jmp srso_untrain_ret", X86_FEATURE_SRSO, \
-		      "jmp srso_alias_untrain_ret", X86_FEATURE_SRSO_ALIAS
-SYM_FUNC_END(entry_untrain_ret)
-__EXPORT_THUNK(entry_untrain_ret)
-
 SYM_CODE_START(__x86_return_thunk)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR


