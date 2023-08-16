Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B8F77DB7B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 09:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242585AbjHPHzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 03:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242623AbjHPHzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 03:55:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7EC2698;
        Wed, 16 Aug 2023 00:55:20 -0700 (PDT)
Date:   Wed, 16 Aug 2023 07:55:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692172517;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N1qxCpSoZbwKEx444taO6+ibnP8DLJbSLXKGjD64LcM=;
        b=AD1zsA8Hhvo/5vRkacyAni3kMaCJzqBCOKCcbZL1VKZe7irOop5YqYR10RhhV0mG9WzoO3
        /QPa1STREqc8mvuEVxE1YAUqtup/j76kL9aJMWxKHlz5FzjgLy7ihDTbE6gWvQO9AsjVco
        w4uEMUZMcutrHyfwP1OnfHQVbMTHsi/UKGgdSLW8Zu7rFfw3nnvGjwd/6s3URJNpNC0QB/
        FXmf6NwfBLrzIM4SpAJGz+bxi3lWOakRSD6/iZ4YDUf5OLYVfpi7PmJNqA4vxipZoHXDyV
        eOaSl91LLpcYJOUI37TBmrhYd+eIlWKPo5y4rUGKrph+Q32n+RBJCfXHrrTE1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692172517;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N1qxCpSoZbwKEx444taO6+ibnP8DLJbSLXKGjD64LcM=;
        b=S6HX1Fk3h489CjDs4LsgKhlnRlePPO5cf9uzB2dU6w7HC2Y3IHvFxyxJ504BKpyfXsaNgL
        P7GHX3uc1KUTywDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/alternative: Make custom return thunk unconditional
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230814121148.775293785@infradead.org>
References: <20230814121148.775293785@infradead.org>
MIME-Version: 1.0
Message-ID: <169217251717.27769.11292596763604303189.tip-bot2@tip-bot2>
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

Commit-ID:     095b8303f3835c68ac4a8b6d754ca1c3b6230711
Gitweb:        https://git.kernel.org/tip/095b8303f3835c68ac4a8b6d754ca1c3b6230711
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 14 Aug 2023 13:44:30 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 16 Aug 2023 09:39:16 +02:00

x86/alternative: Make custom return thunk unconditional

There is infrastructure to rewrite return thunks to point to any
random thunk one desires, unwrap that from CALL_THUNKS, which up to
now was the sole user of that.

  [ bp: Make the thunks visible on 32-bit and add ifdeffery for the
    32-bit builds. ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230814121148.775293785@infradead.org
---
 arch/x86/include/asm/nospec-branch.h |  9 +++++----
 arch/x86/kernel/alternative.c        |  4 ----
 arch/x86/kernel/cpu/bugs.c           |  2 ++
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index e50db53..b3625cc 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -341,17 +341,18 @@ extern retpoline_thunk_t __x86_indirect_thunk_array[];
 extern retpoline_thunk_t __x86_indirect_call_thunk_array[];
 extern retpoline_thunk_t __x86_indirect_jump_thunk_array[];
 
+#ifdef CONFIG_RETHUNK
 extern void __x86_return_thunk(void);
+#else
+static inline void __x86_return_thunk(void) {}
+#endif
+
 extern void zen_untrain_ret(void);
 extern void srso_untrain_ret(void);
 extern void srso_untrain_ret_alias(void);
 extern void entry_ibpb(void);
 
-#ifdef CONFIG_CALL_THUNKS
 extern void (*x86_return_thunk)(void);
-#else
-#define x86_return_thunk	(&__x86_return_thunk)
-#endif
 
 #ifdef CONFIG_CALL_DEPTH_TRACKING
 extern void __x86_return_skl(void);
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 2dcf3a0..099d58d 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -687,10 +687,6 @@ void __init_or_module noinline apply_retpolines(s32 *start, s32 *end)
 
 #ifdef CONFIG_RETHUNK
 
-#ifdef CONFIG_CALL_THUNKS
-void (*x86_return_thunk)(void) __ro_after_init = &__x86_return_thunk;
-#endif
-
 /*
  * Rewrite the compiler generated return thunk tail-calls.
  *
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6c04aef..3bc0d14 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -63,6 +63,8 @@ EXPORT_SYMBOL_GPL(x86_pred_cmd);
 
 static DEFINE_MUTEX(spec_ctrl_mutex);
 
+void (*x86_return_thunk)(void) __ro_after_init = &__x86_return_thunk;
+
 /* Update SPEC_CTRL MSR and its cached copy unconditionally */
 static void update_spec_ctrl(u64 val)
 {
