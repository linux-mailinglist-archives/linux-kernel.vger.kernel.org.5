Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63099775413
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjHIH1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjHIH1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:27:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0A91BFE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 00:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=9++fJwb0WIVH7sC2LRJApi6BbZiu3wA5bopP2QtPAEU=; b=WJcEUOMG4dlOgFQoGg/sVYODAg
        8AizDoGFIfPhu69yxS8yJyLe6DvjzfjmguH3gKllCNKZ4Kcd3/SlvJn7uX90RvtFfbPeq9HkaiXnU
        rf7chfchoN9Bes6G+vz+IS2zUNjdKv1rK3xLUkx+6Zu/WfJ2To45py0yDxsQ0stHXrCQg0nSNvkWU
        osSrAsckSHWWaYZ5gKHeaNkbEMxjI8xgB/QyBUW+40/5lNvdirqOYQQsz0g8xMRN/iV8vCrT6kAj8
        N02ywy1EbFxWn5zY4D7fn8kMOSFeI9Sglar+34/MleBPUCyCKpGWjvjTQLuaO0HNmmiFO/KRPI7eV
        sO7cqVMg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qTdag-004olY-C9; Wed, 09 Aug 2023 07:26:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A576B302DFC;
        Wed,  9 Aug 2023 09:26:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 90948201D9950; Wed,  9 Aug 2023 09:26:44 +0200 (CEST)
Message-ID: <20230809072201.326960605@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 09 Aug 2023 09:12:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        David.Kaplan@amd.com, Andrew.Cooper3@citrix.com,
        jpoimboe@kernel.org, gregkh@linuxfoundation.org
Subject: [RFC][PATCH 13/17] objtool/x86: Add arch_is_offset_insn()
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

Add a little wrappery to identify the magic symbols that are actually
inside another instruction -- yay for variable length instruction
encoding.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch/x86/decode.c      |    6 ++++++
 tools/objtool/check.c                |   13 ++++++++++---
 tools/objtool/include/objtool/arch.h |    1 +
 tools/objtool/include/objtool/elf.h  |    1 +
 4 files changed, 18 insertions(+), 3 deletions(-)

--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -826,3 +826,9 @@ bool arch_is_rethunk(struct symbol *sym)
 {
 	return !strcmp(sym->name, "__x86_return_thunk");
 }
+
+bool arch_is_offset_insn(struct symbol *sym)
+{
+	return !strcmp(sym->name, "zen_return_thunk") ||
+	       !strcmp(sym->name, "srso_safe_ret");
+}
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -459,8 +459,7 @@ static int decode_instructions(struct ob
 			 * Both zen_return_thunk() and srso_safe_ret() are embedded inside
 			 * another instruction and objtool doesn't grok that. Skip validating them.
 			 */
-			if (!strcmp(func->name, "zen_return_thunk") ||
-			    !strcmp(func->name, "srso_safe_ret") || func->alias != func)
+			if (func->offset_insn || func->alias != func)
 				continue;
 
 			if (!find_insn(file, sec, func->offset)) {
@@ -1303,6 +1302,11 @@ __weak bool arch_is_rethunk(struct symbo
 	return false;
 }
 
+__weak bool arch_is_offset_insn(struct symbol *sym)
+{
+	return false;
+}
+
 static struct reloc *insn_reloc(struct objtool_file *file, struct instruction *insn)
 {
 	struct reloc *reloc;
@@ -1588,7 +1592,7 @@ static int add_jump_destinations(struct
 			 * middle of another instruction.  Objtool only
 			 * knows about the outer instruction.
 			 */
-			if (sym && !strcmp(sym->name, "zen_return_thunk")) {
+			if (sym && sym->offset_insn) {
 				add_return_call(file, insn, false);
 				continue;
 			}
@@ -2507,6 +2511,9 @@ static int classify_symbols(struct objto
 		if (arch_is_rethunk(func))
 			func->return_thunk = true;
 
+		if (arch_is_offset_insn(func))
+			func->offset_insn = true;
+
 		if (arch_ftrace_match(func->name))
 			func->fentry = true;
 
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -90,6 +90,7 @@ int arch_decode_hint_reg(u8 sp_reg, int
 
 bool arch_is_retpoline(struct symbol *sym);
 bool arch_is_rethunk(struct symbol *sym);
+bool arch_is_offset_insn(struct symbol *sym);
 
 int arch_rewrite_retpolines(struct objtool_file *file);
 
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -66,6 +66,7 @@ struct symbol {
 	u8 fentry            : 1;
 	u8 profiling_func    : 1;
 	u8 warned	     : 1;
+	u8 offset_insn       : 1;
 	struct list_head pv_target;
 	struct reloc *relocs;
 };


