Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341AB77DB7F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 09:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242605AbjHPHzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 03:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242631AbjHPHzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 03:55:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65B826A1;
        Wed, 16 Aug 2023 00:55:21 -0700 (PDT)
Date:   Wed, 16 Aug 2023 07:55:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692172518;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PPwInwUPbJs6xWHesfZ0ofrfjIhEKh5ZCEFbjCeaqW8=;
        b=y9SVSA7vPQN6ocYVj5Cg7NeFegwbc6P+xT5zuL0RpAni8mmh0g46fyUZdNEP887zI/tbMe
        9YfYvq+ftLZLAnQg1maUvLSGSJ8Hh811EgBqDCLPJ93ieNnUcoNn1+dSeKr+4/gxb0KqaS
        Y1/Teyhpx4Q6J2OF8k/4IXqw8rDptOtLMDprMZnqIERmcLouwQf7eIhHIjeusFP2CBhY6r
        H+8wTCaLHjxOT5g75pJZ2Ff0QJSrxN57YswnnYEAcRSfao0HBAiuhJVHyVTy9ZCYOOx7aJ
        uTrm1HFZutfnkKMvoHICZyxhSrXh1Ns8avGzM4iwWRMpCt3euzVNPTd2nARGdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692172518;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PPwInwUPbJs6xWHesfZ0ofrfjIhEKh5ZCEFbjCeaqW8=;
        b=kP34LGbhfaW8DL9mQgFc4cxUtSxsRlgPJGEJ6+e0NdkpqMSKShrekzhAzp2LefRBuWQUr3
        n1NLPa3PDD42BODg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] objtool/x86: Fix SRSO mess
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230814121148.704502245@infradead.org>
References: <20230814121148.704502245@infradead.org>
MIME-Version: 1.0
Message-ID: <169217251760.27769.15304146275480287222.tip-bot2@tip-bot2>
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

Commit-ID:     4ae68b26c3ab5a82aa271e6e9fc9b1a06e1d6b40
Gitweb:        https://git.kernel.org/tip/4ae68b26c3ab5a82aa271e6e9fc9b1a06e1d6b40
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 14 Aug 2023 13:44:29 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 16 Aug 2023 09:39:16 +02:00

objtool/x86: Fix SRSO mess

Objtool --rethunk does two things:

 - it collects all (tail) call's of __x86_return_thunk and places them
   into .return_sites. These are typically compiler generated, but
   RET also emits this same.

 - it fudges the validation of the __x86_return_thunk symbol; because
   this symbol is inside another instruction, it can't actually find
   the instruction pointed to by the symbol offset and gets upset.

Because these two things pertained to the same symbol, there was no
pressing need to separate these two separate things.

However, alas, along comes SRSO and more crazy things to deal with
appeared.

The SRSO patch itself added the following symbol names to identify as
rethunk:

  'srso_untrain_ret', 'srso_safe_ret' and '__ret'

Where '__ret' is the old retbleed return thunk, 'srso_safe_ret' is a
new similarly embedded return thunk, and 'srso_untrain_ret' is
completely unrelated to anything the above does (and was only included
because of that INT3 vs UD2 issue fixed previous).

Clear things up by adding a second category for the embedded instruction
thing.

Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230814121148.704502245@infradead.org
---
 tools/objtool/arch/x86/decode.c      | 11 +++++++----
 tools/objtool/check.c                | 24 ++++++++++++++++++++++--
 tools/objtool/include/objtool/arch.h |  1 +
 tools/objtool/include/objtool/elf.h  |  1 +
 4 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 2d51fa8..cba8a7b 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -824,8 +824,11 @@ bool arch_is_retpoline(struct symbol *sym)
 
 bool arch_is_rethunk(struct symbol *sym)
 {
-	return !strcmp(sym->name, "__x86_return_thunk") ||
-	       !strcmp(sym->name, "srso_untrain_ret") ||
-	       !strcmp(sym->name, "srso_safe_ret") ||
-	       !strcmp(sym->name, "__ret");
+	return !strcmp(sym->name, "__x86_return_thunk");
+}
+
+bool arch_is_embedded_insn(struct symbol *sym)
+{
+	return !strcmp(sym->name, "__ret") ||
+	       !strcmp(sym->name, "srso_safe_ret");
 }
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e2ee10c..191656e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -455,7 +455,7 @@ static int decode_instructions(struct objtool_file *file)
 				return -1;
 			}
 
-			if (func->return_thunk || func->alias != func)
+			if (func->embedded_insn || func->alias != func)
 				continue;
 
 			if (!find_insn(file, sec, func->offset)) {
@@ -1288,16 +1288,33 @@ static int add_ignore_alternatives(struct objtool_file *file)
 	return 0;
 }
 
+/*
+ * Symbols that replace INSN_CALL_DYNAMIC, every (tail) call to such a symbol
+ * will be added to the .retpoline_sites section.
+ */
 __weak bool arch_is_retpoline(struct symbol *sym)
 {
 	return false;
 }
 
+/*
+ * Symbols that replace INSN_RETURN, every (tail) call to such a symbol
+ * will be added to the .return_sites section.
+ */
 __weak bool arch_is_rethunk(struct symbol *sym)
 {
 	return false;
 }
 
+/*
+ * Symbols that are embedded inside other instructions, because sometimes crazy
+ * code exists. These are mostly ignored for validation purposes.
+ */
+__weak bool arch_is_embedded_insn(struct symbol *sym)
+{
+	return false;
+}
+
 static struct reloc *insn_reloc(struct objtool_file *file, struct instruction *insn)
 {
 	struct reloc *reloc;
@@ -1583,7 +1600,7 @@ static int add_jump_destinations(struct objtool_file *file)
 			 * middle of another instruction.  Objtool only
 			 * knows about the outer instruction.
 			 */
-			if (sym && sym->return_thunk) {
+			if (sym && sym->embedded_insn) {
 				add_return_call(file, insn, false);
 				continue;
 			}
@@ -2502,6 +2519,9 @@ static int classify_symbols(struct objtool_file *file)
 		if (arch_is_rethunk(func))
 			func->return_thunk = true;
 
+		if (arch_is_embedded_insn(func))
+			func->embedded_insn = true;
+
 		if (arch_ftrace_match(func->name))
 			func->fentry = true;
 
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index 2b6d2ce..0b303eb 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -90,6 +90,7 @@ int arch_decode_hint_reg(u8 sp_reg, int *base);
 
 bool arch_is_retpoline(struct symbol *sym);
 bool arch_is_rethunk(struct symbol *sym);
+bool arch_is_embedded_insn(struct symbol *sym);
 
 int arch_rewrite_retpolines(struct objtool_file *file);
 
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index c532d70..9f71e98 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -66,6 +66,7 @@ struct symbol {
 	u8 fentry            : 1;
 	u8 profiling_func    : 1;
 	u8 warned	     : 1;
+	u8 embedded_insn     : 1;
 	struct list_head pv_target;
 	struct reloc *relocs;
 };
