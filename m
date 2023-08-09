Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF16775415
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjHIH1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjHIH1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:27:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8321BCF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 00:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=3qHmhbedZGQrUvNcB5QFGejIHcjKQE+IRBHE5HncEQA=; b=o2350Sz8u8TIGwaeLH9K65GAcm
        fwlLebK4iHEW77ml2f5A3LZwbpEcVX8YHdOfx8JVGYLH1jxGie7eB/VtSxBF0wXEbY3+7ILzXnaxu
        pD5dF2zbTxaCo1WWvhT+wF8bcdV61XNZd0hNyLMIKmKBtUwBBeFYB6O9j0TRyC20Mn08aQhaS5R9d
        zKNpKdl63BgGhEJgrhvNWUFu5FceZ/0qtTVZgVrC8ydTyNlWTBzCBtEMIChxu9+fuw6JIvIkDcinA
        Ai16spGKxABjdMS7tfkH6flf7ZxPnCTf8aqjCX4Kbco7pVKyk0mtRjjqAPUScnrQc8q7+EW8tHpPB
        G//qdjiQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qTdag-004oln-MS; Wed, 09 Aug 2023 07:26:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B23C23033FE;
        Wed,  9 Aug 2023 09:26:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A34E12C865678; Wed,  9 Aug 2023 09:26:44 +0200 (CEST)
Message-ID: <20230809072201.596268530@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 09 Aug 2023 09:12:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        David.Kaplan@amd.com, Andrew.Cooper3@citrix.com,
        jpoimboe@kernel.org, gregkh@linuxfoundation.org
Subject: [RFC][PATCH 17/17] x86/cpu: Use fancy alternatives to get rid of entry_untrain_ret()
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

Use the new nested alternatives to create what is effectively
ALTERNATIVE_5 and merge the dummy entry_untrain_ret stub into
UNTRAIN_RET properly.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/nospec-branch.h |   33 ++++++++++++++++++---------------
 arch/x86/lib/retpoline.S             |    7 -------
 2 files changed, 18 insertions(+), 22 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -271,11 +271,15 @@
 .endm
 
 #ifdef CONFIG_CPU_UNRET_ENTRY
-#define CALL_UNTRAIN_RET	"call entry_untrain_ret"
+#define ALT_UNRET(old)	\
+	__ALTERNATIVE(__ALTERNATIVE(__ALTERNATIVE(old, call zen_untrain_ret, X86_FEATURE_UNRET), \
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
@@ -290,30 +294,30 @@
 .macro UNTRAIN_RET
 #if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CALL_DEPTH_TRACKING)
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
 
 .macro UNTRAIN_RET_VM
 #if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CALL_DEPTH_TRACKING)
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
 
 .macro UNTRAIN_RET_FROM_CALL
 #if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CALL_DEPTH_TRACKING)
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
 
@@ -348,7 +352,6 @@ extern void zen_untrain_ret(void);
 extern void srso_untrain_ret(void);
 extern void srso_alias_untrain_ret(void);
 
-extern void entry_untrain_ret(void);
 extern void entry_ibpb(void);
 
 extern void (*x86_return_thunk)(void);
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -263,13 +263,6 @@ SYM_CODE_END(srso_safe_ret)
 SYM_FUNC_END(srso_untrain_ret)
 __EXPORT_THUNK(srso_untrain_ret)
 
-SYM_FUNC_START(entry_untrain_ret)
-	ALTERNATIVE_2 "jmp zen_untrain_ret", \
-		      "jmp srso_untrain_ret", X86_FEATURE_SRSO, \
-		      "jmp srso_alias_untrain_ret", X86_FEATURE_SRSO_ALIAS
-SYM_FUNC_END(entry_untrain_ret)
-__EXPORT_THUNK(entry_untrain_ret)
-
 /*
  * Both these do an unbalanced CALL to mess up the RSB, terminate with UD2
  * to indicate noreturn.


