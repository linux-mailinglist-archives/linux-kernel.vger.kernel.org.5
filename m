Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED087884AB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244372AbjHYKUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244416AbjHYKTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:19:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405C7213C;
        Fri, 25 Aug 2023 03:19:30 -0700 (PDT)
Date:   Fri, 25 Aug 2023 10:19:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692958768;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tJ3sLmm2V7cYTp24FPh8BMp7XmAh+QZzz0PIfsrQhig=;
        b=iy70RIU+ty9o9N4Cq81GtBo+XbbRKirPrUAvuzTklZ/J+Cf9Vq0/Soiv9pB6eUtEIR1cKV
        4gdkAT7ho4ZLLWTHk3G1nJU2hAbU0rCGwJwMFC0LEN6L4dPC06aMp6ybHFh3zA1o6WJtnq
        W32xTkOooJwidJ3qh2M3hET73w+ZOmCpfpBZocQXxPtJhYG+7DrVQUKzXZOfrQVqaXvwxz
        tg6O16a1PXdvxFjjGdzT0ZK3dcIyWOQPaRmt+H2isL8lAQF9DxQaLGzYQ31V0pqVMkkpO2
        v12efopmLdHTdPQZ3TQ7iAcQeO/MUkEVNKQ9iHwaWF1m2PUlBq2Eq+zo/ONnVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692958768;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tJ3sLmm2V7cYTp24FPh8BMp7XmAh+QZzz0PIfsrQhig=;
        b=IUjFe4Q0aFGTXFk4WFgr9c1MNzSRdSX5+c7ZHCk/wrU/gYfuM8/AvEQYLLtPw9sXbvFoeC
        8JhqWwrGmuT9aECw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/rethunk: Use SYM_CODE_START[_LOCAL]_NOALIGN macros
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1ae65b98ddc256ebc446768d9d0c461675dd0437.1692919072.git.jpoimboe@kernel.org>
References: <1ae65b98ddc256ebc446768d9d0c461675dd0437.1692919072.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <169295876809.27769.9815339580520290470.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     03edd09ff88a4ecb6fd5b8c7999e62bf475b4e22
Gitweb:        https://git.kernel.org/tip/03edd09ff88a4ecb6fd5b8c7999e62bf475b4e22
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 25 Aug 2023 00:01:51 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 25 Aug 2023 11:22:01 +02:00

x86/rethunk: Use SYM_CODE_START[_LOCAL]_NOALIGN macros

Macros already exist for unaligned code block symbols.  Use them.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/1ae65b98ddc256ebc446768d9d0c461675dd0437.1692919072.git.jpoimboe@kernel.org
---
 arch/x86/lib/retpoline.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 8ba79d2..415521d 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -149,7 +149,7 @@ SYM_CODE_END(__x86_indirect_jump_thunk_array)
  * As a result, srso_alias_safe_ret() becomes a safe return.
  */
 	.pushsection .text..__x86.rethunk_untrain
-SYM_START(srso_alias_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
+SYM_CODE_START_NOALIGN(srso_alias_untrain_ret)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
 	ASM_NOP2
@@ -159,7 +159,7 @@ SYM_FUNC_END(srso_alias_untrain_ret)
 	.popsection
 
 	.pushsection .text..__x86.rethunk_safe
-SYM_START(srso_alias_safe_ret, SYM_L_GLOBAL, SYM_A_NONE)
+SYM_CODE_START_NOALIGN(srso_alias_safe_ret)
 	lea 8(%_ASM_SP), %_ASM_SP
 	UNWIND_HINT_FUNC
 	ANNOTATE_UNRET_SAFE
@@ -187,7 +187,7 @@ SYM_CODE_END(srso_alias_return_thunk)
  */
 	.align 64
 	.skip 64 - (srso_safe_ret - srso_untrain_ret), 0xcc
-SYM_START(srso_untrain_ret, SYM_L_LOCAL, SYM_A_NONE)
+SYM_CODE_START_LOCAL_NOALIGN(srso_untrain_ret)
 	ANNOTATE_NOENDBR
 	.byte 0x48, 0xb8
 
@@ -255,7 +255,7 @@ SYM_CODE_END(srso_return_thunk)
  */
 	.align 64
 	.skip 64 - (retbleed_return_thunk - retbleed_untrain_ret), 0xcc
-SYM_START(retbleed_untrain_ret, SYM_L_LOCAL, SYM_A_NONE)
+SYM_CODE_START_LOCAL_NOALIGN(retbleed_untrain_ret)
 	ANNOTATE_NOENDBR
 	/*
 	 * As executed from retbleed_untrain_ret, this is:
