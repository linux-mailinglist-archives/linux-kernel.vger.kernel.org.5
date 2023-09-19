Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874447A5EC2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjISJxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjISJxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:53:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD741AE;
        Tue, 19 Sep 2023 02:53:11 -0700 (PDT)
Date:   Tue, 19 Sep 2023 09:53:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695117190;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aGVlqKFzgo65AbrTfbSUR8Y88ex0vT2Ng5LjMyGtvPM=;
        b=XHuL6qFmlb6eRhCRhaxpJkwC6Ok2rGEFLjw5ogz6JkjfdSZl8nFKm4Wqn+jiFhRRPVCp27
        Vdr0HNN2ScYcWKd4gbK/sP/bRj+Q9K3E+Y5tp7M8Zn8R+vUsVkYv+LEXzwbd+tmUIfARPQ
        TiT9Z6xRhhoV0qIgGWuUlKSBEI68FTtXNk6K+1qG+aU5zpl0n1bTTC5kn4VpjxqO9FcvYD
        sKfdWRRIQ8wl5vk/PYpxEYjkv7fZwl6eL19JaDEzuWTLZKe496dk98wG5j+UX3bB3z3MCI
        XG10Eb5lSJkJ+bZMf4ImKrfsM3U5kX/U1rxeiCtjmoMnUEAT1Ap3jz4VWjmzbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695117190;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aGVlqKFzgo65AbrTfbSUR8Y88ex0vT2Ng5LjMyGtvPM=;
        b=LdBp08GW72RG8h7UHlp4OaD+M9QmOooGuRCa2IZMMg36GzavTRWWFJyEI1hXHcJ51wCLOu
        Rj1HKscRdIJ2cDAA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/rethunk: Use SYM_CODE_START[_LOCAL]_NOALIGN macros
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <26d461bd509cc840af24c94586561c06d39812b2.1693889988.git.jpoimboe@kernel.org>
References: <26d461bd509cc840af24c94586561c06d39812b2.1693889988.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <169511718956.27769.4103210416462777327.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     ff72a720fbaef33896043fa66043772d0cc3142b
Gitweb:        https://git.kernel.org/tip/ff72a720fbaef33896043fa66043772d0cc3142b
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 04 Sep 2023 22:05:01 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 19 Sep 2023 11:42:48 +02:00

x86/rethunk: Use SYM_CODE_START[_LOCAL]_NOALIGN macros

Macros already exist for unaligned code block symbols.  Use them.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/26d461bd509cc840af24c94586561c06d39812b2.1693889988.git.jpoimboe@kernel.org
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
