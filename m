Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6CB77DB75
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 09:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242559AbjHPHzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 03:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242615AbjHPHzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 03:55:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3AA26AA;
        Wed, 16 Aug 2023 00:55:17 -0700 (PDT)
Date:   Wed, 16 Aug 2023 07:55:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692172515;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=igPmhn36L1KqEP/LYyBsGAO/y1ElMV3MkWVAxtjY1Ng=;
        b=Xq7c1kqNKs7jGp1ekumQGVX9pfx7mbA34maWN2daHH0X07aE/s81NZGVfkHPY6fPWpg2xa
        3kQBarj5R3egseTN3DZjGQq9KB9qm5q/eE43rYqhPUPoBFzfl3XHG4uO9qhmgspuSpnGO3
        Z6WT/+8Al1rwEqfR+OAplOD9FPLccOuoowhtCLGDxET4OpHk9kJXDoalg7yDRsMBfK8aAO
        Go6BlUO4qFWh1UGOI+tQRAQPojD798TaZbiW0IqEbqVtw8dJ3xqK/TJhXCweIy1mMsxlaX
        tZg/5wEtKYKjTjsYbAsTwpmiLOpNTZT3ZUl69fDXXkptVL8Lyv8xZnfcS6CyTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692172515;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=igPmhn36L1KqEP/LYyBsGAO/y1ElMV3MkWVAxtjY1Ng=;
        b=110CHZgHvCgL4gvS34fbLEZhGo9ceOy68jvwx0OMVMbgVpkT7MoLwKs2+5YroULPrIR3NQ
        ctAP2ydVgrF7RsCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu: Cleanup the untrain mess
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230814121149.042774962@infradead.org>
References: <20230814121149.042774962@infradead.org>
MIME-Version: 1.0
Message-ID: <169217251522.27769.15630220729423710647.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     4854a36d877a3aef0afdd241cccb68c1825234d0
Gitweb:        https://git.kernel.org/tip/4854a36d877a3aef0afdd241cccb68c1825234d0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 14 Aug 2023 13:44:34 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 16 Aug 2023 09:39:16 +02:00

x86/cpu: Cleanup the untrain mess

Since there can only be one active return_thunk, there only needs be
one (matching) untrain_ret. It fundamentally doesn't make sense to
allow multiple untrain_ret at the same time.

Fold all the 3 different untrain methods into a single (temporary)
helper stub.

Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230814121149.042774962@infradead.org
---
 arch/x86/include/asm/nospec-branch.h | 19 +++++--------------
 arch/x86/kernel/cpu/bugs.c           |  1 +
 arch/x86/lib/retpoline.S             |  7 +++++++
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index f7c3375..5285c8e 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -272,9 +272,9 @@
 .endm
 
 #ifdef CONFIG_CPU_UNRET_ENTRY
-#define CALL_ZEN_UNTRAIN_RET	"call retbleed_untrain_ret"
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
-			  "call srso_alias_untrain_ret", X86_FEATURE_SRSO_ALIAS
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
-			  "call srso_alias_untrain_ret", X86_FEATURE_SRSO_ALIAS
-#endif
 .endm
 
 
@@ -355,6 +345,7 @@ extern void retbleed_untrain_ret(void);
 extern void srso_untrain_ret(void);
 extern void srso_alias_untrain_ret(void);
 
+extern void entry_untrain_ret(void);
 extern void entry_ibpb(void);
 
 extern void (*x86_return_thunk)(void);
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index bbbbda9..6f3e195 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2460,6 +2460,7 @@ static void __init srso_select_mitigation(void)
 			 * like ftrace, static_call, etc.
 			 */
 			setup_force_cpu_cap(X86_FEATURE_RETHUNK);
+			setup_force_cpu_cap(X86_FEATURE_UNRET);
 
 			if (boot_cpu_data.x86 == 0x19) {
 				setup_force_cpu_cap(X86_FEATURE_SRSO_ALIAS);
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index d37e5ab..5e85da1 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -289,6 +289,13 @@ SYM_CODE_START(srso_return_thunk)
 	ud2
 SYM_CODE_END(srso_return_thunk)
 
+SYM_FUNC_START(entry_untrain_ret)
+	ALTERNATIVE_2 "jmp retbleed_untrain_ret", \
+		      "jmp srso_untrain_ret", X86_FEATURE_SRSO, \
+		      "jmp srso_alias_untrain_ret", X86_FEATURE_SRSO_ALIAS
+SYM_FUNC_END(entry_untrain_ret)
+__EXPORT_THUNK(entry_untrain_ret)
+
 SYM_CODE_START(__x86_return_thunk)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
