Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A335177B882
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjHNMUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjHNMTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:19:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2196E18B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=MSbD0mrcSH8dRdmwVMp2ZpkoVj+73cEbOOROFTSZaOE=; b=Xc+7xuyes5BTnEkvrWq6InpvIq
        /prorkXQbTxexs20t3eoQnFS29yNZJHIJ3jMndXHLqmOABHqCSAkjZ6nio6Y2taGz1z+zLTkf9d3r
        EhPqEKEC61VDJuTm/PFMSWoB+m/PX2Sh0ei+VWOSXecg9PejGXkUpbdwFV20Ywcyd0nxVE2FHH9az
        hWPvXI5ymDemSilOCjTtysItSkd3/+wobA6r3Itf9g2h/i3eH/2dVksonDGUDXYrU0Rjip0E6mJB7
        5OBryalYhiIH8HncfxWThUUADUx2Y/qRctwvt8IOw0L2KGvWvmbFbUdZN0f/lzY0VnJK9KnGAIcB+
        y7tkk2RA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qVWXY-00AaKY-14;
        Mon, 14 Aug 2023 12:19:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CF9EE3005E3;
        Mon, 14 Aug 2023 14:19:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BA11C20167A97; Mon, 14 Aug 2023 14:19:19 +0200 (CEST)
Message-ID: <20230814121148.704502245@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 14 Aug 2023 13:44:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        David.Kaplan@amd.com, Andrew.Cooper3@citrix.com,
        jpoimboe@kernel.org, gregkh@linuxfoundation.org,
        nik.borisov@suse.com
Subject: [PATCH v2 03/11] objtool/x86: Fix SRSO mess
References: <20230814114426.057251214@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Objtool --rethunk does two things:

 - it collects all (tail) call's of __x86_return_thunk and places them
   into .return_sites. These are typically compiler generated, but
   RET also emits this same.

 - it fudges the validation of the __x86_return_thunk symbol; because
   this symbol is inside another instruction, it can't actually find
   the instruction pointed to by the symbol offset and gets upset.

Because these two things pertained to the same symbol, there was no
pressing need to separate these two separate things.

However, alas, along comes SRSO and we get more crazy things to deal
with.

The SRSO patch itself added the following symbol names to identify as
rethunk:

  'srso_untrain_ret', 'srso_safe_ret' and '__ret'

Where '__ret' is the old retbleed return thunk, 'srso_safe_ret' is a
new similarly embedded return thunk, and 'srso_untrain_ret' is
completely unrelated to anything the above does (and was only included
because of that INT3 vs UD2 issue fixed previous).

Clear things up by adding a second category for the embedded
instruction thing.

Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch/x86/decode.c      |   11 +++++++----
 tools/objtool/check.c                |   24 ++++++++++++++++++++++--
 tools/objtool/include/objtool/arch.h |    1 +
 tools/objtool/include/objtool/elf.h  |    1 +
 4 files changed, 31 insertions(+), 6 deletions(-)

--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -824,8 +824,11 @@ bool arch_is_retpoline(struct symbol *sy
 
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
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -455,7 +455,7 @@ static int decode_instructions(struct ob
 				return -1;
 			}
 
-			if (func->return_thunk || func->alias != func)
+			if (func->embedded_insn || func->alias != func)
 				continue;
 
 			if (!find_insn(file, sec, func->offset)) {
@@ -1288,16 +1288,33 @@ static int add_ignore_alternatives(struc
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
@@ -1583,7 +1600,7 @@ static int add_jump_destinations(struct
 			 * middle of another instruction.  Objtool only
 			 * knows about the outer instruction.
 			 */
-			if (sym && sym->return_thunk) {
+			if (sym && sym->embedded_insn) {
 				add_return_call(file, insn, false);
 				continue;
 			}
@@ -2502,6 +2519,9 @@ static int classify_symbols(struct objto
 		if (arch_is_rethunk(func))
 			func->return_thunk = true;
 
+		if (arch_is_embedded_insn(func))
+			func->embedded_insn = true;
+
 		if (arch_ftrace_match(func->name))
 			func->fentry = true;
 
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -90,6 +90,7 @@ int arch_decode_hint_reg(u8 sp_reg, int
 
 bool arch_is_retpoline(struct symbol *sym);
 bool arch_is_rethunk(struct symbol *sym);
+bool arch_is_embedded_insn(struct symbol *sym);
 
 int arch_rewrite_retpolines(struct objtool_file *file);
 
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


