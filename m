Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7711F77540A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjHIH1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjHIH04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:26:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7681FCA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 00:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=pZlFEkDaUQE0a6aJzDwSVKlXzpcaHKgkUuhdNWjjfj0=; b=SSxoAVSLSJu81heACQEUBDZxxQ
        1LTcopPjqD2ruLSsqdmy8ELCfMW6SwibNFJdNKEMx0ZSF8IiQ+SbZA4IithXcXi0+PyV3DcnoYGfi
        z/zhqPQis+oFgotAoUaQWgrbV94KHL7FGZcJGabSBRsIJ3ADN8SjztzrmQv6d8lvviiaIfpmCVNy1
        WmMHyh1ApJyePDwzfy5kaAs/8c6YlbgiGp0J4IHyFeaBptvd+PO8a7Vu0fx/69q6YOHaZ8t7F5wlc
        jEqd7OWBRnpkoqEvvkA0Q+XmqYdBvjHGB8wF9E5B6q7vP5/n2KbN83PtGOVx38E7w1uC2FmZQwT0p
        4KpAD/qg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTdaf-005TeM-2H;
        Wed, 09 Aug 2023 07:26:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 96B6A3006F1;
        Wed,  9 Aug 2023 09:26:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 538EC2C865687; Wed,  9 Aug 2023 09:26:44 +0200 (CEST)
Message-ID: <20230809072200.782716727@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 09 Aug 2023 09:12:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        David.Kaplan@amd.com, Andrew.Cooper3@citrix.com,
        jpoimboe@kernel.org, gregkh@linuxfoundation.org
Subject: [RFC][PATCH 05/17] x86/cpu: Cleanup the untrain mess
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

Since there can only be one active return_thunk, there only needs be
one (matching) untrain_ret. It fundamentally doesn't make sense to
allow multiple untrain_ret at the same time.

Fold all the 3 different untrain methods into a single (temporary)
helper stub.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/nospec-branch.h |   19 +++++--------------
 arch/x86/lib/retpoline.S             |    7 +++++++
 2 files changed, 12 insertions(+), 14 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -272,9 +272,9 @@
 .endm
 
 #ifdef CONFIG_CPU_UNRET_ENTRY
-#define CALL_ZEN_UNTRAIN_RET	"call zen_untrain_ret"
+#define CALL_UNTRAIN_RET	"call entry_untrain_ret"
 #else
-#define CALL_ZEN_UNTRAIN_RET	""
+#define CALL_UNTRAIN_RET	""
 #endif
 
 /*
@@ -293,15 +293,10 @@
 	defined(CONFIG_CALL_DEPTH_TRACKING) || defined(CONFIG_CPU_SRSO)
 	VALIDATE_UNRET_END
 	ALTERNATIVE_3 "",						\
-		      CALL_ZEN_UNTRAIN_RET, X86_FEATURE_UNRET,		\
+		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
 		      "call entry_ibpb", X86_FEATURE_ENTRY_IBPB,	\
 		      __stringify(RESET_CALL_DEPTH), X86_FEATURE_CALL_DEPTH
 #endif
-
-#ifdef CONFIG_CPU_SRSO
-	ALTERNATIVE_2 "", "call srso_untrain_ret", X86_FEATURE_SRSO, \
-			  "call srso_untrain_ret_alias", X86_FEATURE_SRSO_ALIAS
-#endif
 .endm
 
 .macro UNTRAIN_RET_FROM_CALL
@@ -309,15 +304,10 @@
 	defined(CONFIG_CALL_DEPTH_TRACKING)
 	VALIDATE_UNRET_END
 	ALTERNATIVE_3 "",						\
-		      CALL_ZEN_UNTRAIN_RET, X86_FEATURE_UNRET,		\
+		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
 		      "call entry_ibpb", X86_FEATURE_ENTRY_IBPB,	\
 		      __stringify(RESET_CALL_DEPTH_FROM_CALL), X86_FEATURE_CALL_DEPTH
 #endif
-
-#ifdef CONFIG_CPU_SRSO
-	ALTERNATIVE_2 "", "call srso_untrain_ret", X86_FEATURE_SRSO, \
-			  "call srso_untrain_ret_alias", X86_FEATURE_SRSO_ALIAS
-#endif
 .endm
 
 
@@ -349,6 +339,7 @@ extern void zen_untrain_ret(void);
 extern void srso_untrain_ret(void);
 extern void srso_untrain_ret_alias(void);
 
+extern void entry_untrain_ret(void);
 extern void entry_ibpb(void);
 
 extern void (*x86_return_thunk)(void);
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -268,6 +268,13 @@ SYM_CODE_END(srso_safe_ret)
 SYM_FUNC_END(srso_untrain_ret)
 __EXPORT_THUNK(srso_untrain_ret)
 
+SYM_FUNC_START(entry_untrain_ret)
+	ALTERNATIVE_2 "jmp zen_untrain_ret", \
+		      "jmp srso_untrain_ret", X86_FEATURE_SRSO, \
+		      "jmp srso_untrain_ret_alias", X86_FEATURE_SRSO_ALIAS
+SYM_FUNC_END(entry_untrain_ret)
+__EXPORT_THUNK(entry_untrain_ret)
+
 /*
  * Both these do an unbalanced CALL to mess up the RSB, terminate with UD2
  * to indicate noreturn.


