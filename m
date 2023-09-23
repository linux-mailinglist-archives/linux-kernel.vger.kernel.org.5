Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEF87AC1EA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 14:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjIWMUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 08:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjIWMUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 08:20:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC5D1AB;
        Sat, 23 Sep 2023 05:20:12 -0700 (PDT)
Date:   Sat, 23 Sep 2023 12:20:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695471610;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gf8n8UKovPTgE4ScfY67jkYVoHD50ZARwyIjgGjhiFU=;
        b=X8a5X3qunecEZkb2RjM4jaJR829t05eerzB7tNqSCsmu4xohT8x+jA3Ijr9RPTnlSDhebr
        0hZS99NQLJsQyE1bt4ioGf5soOEIBwmq1VTFrUMXTQifardgctwRAm67rOHVkGEpD8+bR4
        S2ga39s6Mu2r+2LL0/dU2l+j4Z1X/8g3grfm/m1Efy+79/uijX4BNh8+1bbfKSwsflTo4e
        7goOjPVGFwoMKvo5kQhDrgsgAi+I1Dwaa81aNvl8XOQLtVl55RosBNZ4LwusY89ePCVAYO
        u6eLTeWhkmbMAFHspZ24V11xDq+SeaNBpar1OfAanC+JLZY0ZdUGSW4P6i59Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695471610;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gf8n8UKovPTgE4ScfY67jkYVoHD50ZARwyIjgGjhiFU=;
        b=/XfoqgAw30OERnwu6Uvp8cLNj2Lx/ZI4TZC4G/oi4cmkZRiyT7OEmTlqc69eTMWcUwwpcK
        6F2h8CuxUNSZqyBg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/srso: Unexport untraining functions
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1ae080f95ce7266c82cba6d2adde82349b832654.1693889988.git.jpoimboe@kernel.org>
References: <1ae080f95ce7266c82cba6d2adde82349b832654.1693889988.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <169547160980.27769.14687356116320625469.tip-bot2@tip-bot2>
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

Commit-ID:     ee35f33f13f094151794a02fdb0204ce8ca89af9
Gitweb:        https://git.kernel.org/tip/ee35f33f13f094151794a02fdb0204ce8ca89af9
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 04 Sep 2023 22:04:56 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 23 Sep 2023 14:13:03 +02:00

x86/srso: Unexport untraining functions

These functions aren't called outside of retpoline.S.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/1ae080f95ce7266c82cba6d2adde82349b832654.1693889988.git.jpoimboe@kernel.org
---
 arch/x86/include/asm/nospec-branch.h | 4 ----
 arch/x86/lib/retpoline.S             | 7 ++-----
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 197ff4f..6c14fd1 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -352,10 +352,6 @@ extern void retbleed_return_thunk(void);
 extern void srso_return_thunk(void);
 extern void srso_alias_return_thunk(void);
 
-extern void retbleed_untrain_ret(void);
-extern void srso_untrain_ret(void);
-extern void srso_alias_untrain_ret(void);
-
 extern void entry_untrain_ret(void);
 extern void entry_ibpb(void);
 
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 9ab634f..a40ba18 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -157,7 +157,6 @@ SYM_START(srso_alias_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	lfence
 	jmp srso_alias_return_thunk
 SYM_FUNC_END(srso_alias_untrain_ret)
-__EXPORT_THUNK(srso_alias_untrain_ret)
 
 	.section .text..__x86.rethunk_safe
 #else
@@ -215,7 +214,7 @@ SYM_CODE_END(srso_alias_return_thunk)
  */
 	.align 64
 	.skip 64 - (retbleed_return_thunk - retbleed_untrain_ret), 0xcc
-SYM_START(retbleed_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
+SYM_START(retbleed_untrain_ret, SYM_L_LOCAL, SYM_A_NONE)
 	ANNOTATE_NOENDBR
 	/*
 	 * As executed from retbleed_untrain_ret, this is:
@@ -263,7 +262,6 @@ SYM_CODE_END(retbleed_return_thunk)
 	jmp retbleed_return_thunk
 	int3
 SYM_FUNC_END(retbleed_untrain_ret)
-__EXPORT_THUNK(retbleed_untrain_ret)
 
 /*
  * SRSO untraining sequence for Zen1/2, similar to retbleed_untrain_ret()
@@ -277,7 +275,7 @@ __EXPORT_THUNK(retbleed_untrain_ret)
  */
 	.align 64
 	.skip 64 - (srso_safe_ret - srso_untrain_ret), 0xcc
-SYM_START(srso_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
+SYM_START(srso_untrain_ret, SYM_L_LOCAL, SYM_A_NONE)
 	ANNOTATE_NOENDBR
 	.byte 0x48, 0xb8
 
@@ -298,7 +296,6 @@ SYM_INNER_LABEL(srso_safe_ret, SYM_L_GLOBAL)
 	ud2
 SYM_CODE_END(srso_safe_ret)
 SYM_FUNC_END(srso_untrain_ret)
-__EXPORT_THUNK(srso_untrain_ret)
 
 SYM_CODE_START(srso_return_thunk)
 	UNWIND_HINT_FUNC
