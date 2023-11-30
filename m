Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0657FFD61
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376926AbjK3VQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376859AbjK3VQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:16:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC92610D9;
        Thu, 30 Nov 2023 13:16:34 -0800 (PST)
Date:   Thu, 30 Nov 2023 21:16:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701378992;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bl8RA0BfuW7vlYWghNCY0FMcpqvsacHdKivd0p7LxBw=;
        b=pd09TXUt6HDx+jxSLghOxJjtamtW7+LJf1DcKhUMmDTaFCrTYxMyHppvtcTEmifNEnOqlT
        4XLvgy4XbH93J/r+J6DG0ZYEwGWXkOSUXgp00h+sBvdt5ammlcTZhx0wMPCiy4yFaxlZR5
        c6VwEHpQ9hKGBNMEdzHSB/6saxkIirTi1RsrgjQAqhYd+7gleUtEO3sY5tVedZQDMCePA9
        o8NLn/vmlbtaLsBmP+YtbyRqFAPMEFYP2vg8omLXCmzgDbNdTnQ1rTkmtthYyqMP0n6AH/
        LGb8zJT+DKUtNRePhqz9vg2BmyQDtdTuWWCo1wI8ZBVRwetpsjjgy9vTG4gq1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701378992;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bl8RA0BfuW7vlYWghNCY0FMcpqvsacHdKivd0p7LxBw=;
        b=Nue5eO5qrt/Uj+bhXMM2QLAAic/mFkxzBotxQHfrx9WtknmXiPCHcqte+EGb9WpTU6laGm
        i5TZet/tHNKVeaBA==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/callthunks: Fix and unify call thunks assembly snippets
Cc:     Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231105213731.1878100-4-ubizjak@gmail.com>
References: <20231105213731.1878100-4-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <170137899220.398.1284129355490971042.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     2adeed985a42ff3334e6898c8c0827e7626c1336
Gitweb:        https://git.kernel.org/tip/2adeed985a42ff3334e6898c8c0827e7626c1336
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Sun, 05 Nov 2023 22:34:37 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 30 Nov 2023 20:06:17 +01:00

x86/callthunks: Fix and unify call thunks assembly snippets

Currently thunk debug macros explicitly define %gs: segment register
prefix for their percpu variables. This is not compatible with
!CONFIG_SMP, which requires non-prefixed percpu variables.

Fix call thunks debug macros to use PER_CPU_VAR macro from percpu.h
to conditionally use %gs: segment register prefix, depending on
CONFIG_SMP.

Finally, unify ASM_ prefixed assembly macros with their non-prefixed
variants. With support of %rip-relative relocations in place, call
thunk templates allow %rip-relative addressing, so unified assembly
snippet can be used everywhere.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20231105213731.1878100-4-ubizjak@gmail.com
---
 arch/x86/include/asm/nospec-branch.h | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index c55cc24..65fbf6b 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -59,13 +59,13 @@
 
 #ifdef CONFIG_CALL_THUNKS_DEBUG
 # define CALL_THUNKS_DEBUG_INC_CALLS				\
-	incq	%gs:__x86_call_count;
+	incq	PER_CPU_VAR(__x86_call_count);
 # define CALL_THUNKS_DEBUG_INC_RETS				\
-	incq	%gs:__x86_ret_count;
+	incq	PER_CPU_VAR(__x86_ret_count);
 # define CALL_THUNKS_DEBUG_INC_STUFFS				\
-	incq	%gs:__x86_stuffs_count;
+	incq	PER_CPU_VAR(__x86_stuffs_count);
 # define CALL_THUNKS_DEBUG_INC_CTXSW				\
-	incq	%gs:__x86_ctxsw_count;
+	incq	PER_CPU_VAR(__x86_ctxsw_count);
 #else
 # define CALL_THUNKS_DEBUG_INC_CALLS
 # define CALL_THUNKS_DEBUG_INC_RETS
@@ -80,9 +80,6 @@
 #define CREDIT_CALL_DEPTH					\
 	movq	$-1, PER_CPU_VAR(pcpu_hot + X86_call_depth);
 
-#define ASM_CREDIT_CALL_DEPTH					\
-	movq	$-1, PER_CPU_VAR(pcpu_hot + X86_call_depth);
-
 #define RESET_CALL_DEPTH					\
 	xor	%eax, %eax;					\
 	bts	$63, %rax;					\
@@ -95,20 +92,14 @@
 	CALL_THUNKS_DEBUG_INC_CALLS
 
 #define INCREMENT_CALL_DEPTH					\
-	sarq	$5, %gs:pcpu_hot + X86_call_depth;		\
-	CALL_THUNKS_DEBUG_INC_CALLS
-
-#define ASM_INCREMENT_CALL_DEPTH				\
 	sarq	$5, PER_CPU_VAR(pcpu_hot + X86_call_depth);	\
 	CALL_THUNKS_DEBUG_INC_CALLS
 
 #else
 #define CREDIT_CALL_DEPTH
-#define ASM_CREDIT_CALL_DEPTH
 #define RESET_CALL_DEPTH
-#define INCREMENT_CALL_DEPTH
-#define ASM_INCREMENT_CALL_DEPTH
 #define RESET_CALL_DEPTH_FROM_CALL
+#define INCREMENT_CALL_DEPTH
 #endif
 
 /*
@@ -158,7 +149,7 @@
 	jnz	771b;					\
 	/* barrier for jnz misprediction */		\
 	lfence;						\
-	ASM_CREDIT_CALL_DEPTH				\
+	CREDIT_CALL_DEPTH				\
 	CALL_THUNKS_DEBUG_INC_CTXSW
 #else
 /*
@@ -325,7 +316,7 @@
 .macro CALL_DEPTH_ACCOUNT
 #ifdef CONFIG_CALL_DEPTH_TRACKING
 	ALTERNATIVE "",							\
-		    __stringify(ASM_INCREMENT_CALL_DEPTH), X86_FEATURE_CALL_DEPTH
+		    __stringify(INCREMENT_CALL_DEPTH), X86_FEATURE_CALL_DEPTH
 #endif
 .endm
 
