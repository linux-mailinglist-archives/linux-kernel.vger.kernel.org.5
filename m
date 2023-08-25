Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AE57884CC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244548AbjHYKU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244405AbjHYKUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:20:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773E11997;
        Fri, 25 Aug 2023 03:19:51 -0700 (PDT)
Date:   Fri, 25 Aug 2023 10:19:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692958771;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k/LYP/WkHyF1OcBAMPdskRj3/h9Rc31AHxOZJiK5r0U=;
        b=nZtqttD+1iEQS+RhaengtqgDqhUBW/Xg62dSIC2uyn4I5gB2kIZ1l/ZGLMLKWX/sxt9Dml
        Vl4SNXAz9OrtdpQnMDsN9GA4UsiYDHMw4rEdwC1+ukZA7jRjV93ZIqIRoMr3/GxUS4zLTm
        wzc5XQTPWesJoglfIJ73SotrjG6gHeYXgIoHV1nhbQVIs3D/+57LMnA8zn5VTWmdvmyoKJ
        4mp6S6SID1ZaJDkQLdHj8p7IDuk+JALFOdv8cQ9o8KsQzAxjv+Y6QOqLgUWEI44o9pNBHz
        pus5ecq9WkeC/bATmffsb8/h1FK9Uere1TAlFvQQIqZUTJa8829vcJ/Zhup2JQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692958771;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k/LYP/WkHyF1OcBAMPdskRj3/h9Rc31AHxOZJiK5r0U=;
        b=qebd2urDjSgFKCFiD3w1XBrdspa8LmqKPu65EUKhm8kimU5azrDKC2va8b3+Z43KZd6pZ6
        R0xxAhkrPGuhfzCw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/srso: Unexport untraining functions
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <94caf421d80924666be921e387851665054ba9b7.1692919072.git.jpoimboe@kernel.org>
References: <94caf421d80924666be921e387851665054ba9b7.1692919072.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <169295877071.27769.7307607315923724485.tip-bot2@tip-bot2>
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

Commit-ID:     c55f644e022eb9ddc199bcca6d945d820bce4c06
Gitweb:        https://git.kernel.org/tip/c55f644e022eb9ddc199bcca6d945d820bce4c06
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 25 Aug 2023 00:01:45 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 25 Aug 2023 11:22:00 +02:00

x86/srso: Unexport untraining functions

These functions aren't called outside of retpoline.S.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/94caf421d80924666be921e387851665054ba9b7.1692919072.git.jpoimboe@kernel.org
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
