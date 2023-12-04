Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B63802EDA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbjLDJkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234849AbjLDJjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:39:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A305B2;
        Mon,  4 Dec 2023 01:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=3hjZXdVdAqYrfJGPL+xc1qQwDrkxAo6hzBpHpkHpUzk=; b=VhetepAFNhvW4k2HRO7V2nJ4vR
        yfQoimIyxY33PBF6OS0Gxx7UpZ6oYKJsHjx3CObRPboc8sMlMCepKgG9lqgqSLxCut+k0ZvQa0fc9
        6c16CXtFn64ZgJzQ2HWq6vDQ7hc7W4ABXFJffLvRaLN+ekyOulZg4NTXqizEi0tbi6Su+cfJp9TNP
        4jehR/v76SFY3vQtk2AbojhYeerO2qs7aXUZy/F4Ial8uKLGrAOzpYTIsvsUhZhyDhg/nbwzKvMUx
        GNInGk9bmIS6JI0CCwlJFBdouQ/XZ5ee/BTOCuhHJEerstoW9kLt+t7t/GCOUPIcsuf0li8qkLuBu
        qydLDGfQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1rA5QY-000X0N-GA; Mon, 04 Dec 2023 09:39:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id 8BBD3300472; Mon,  4 Dec 2023 10:39:45 +0100 (CET)
Message-Id: <20231204093731.356358182@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 04 Dec 2023 10:37:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        kvm@vger.kernel.org
Subject: [PATCH 01/11] objtool: Generic annotation infrastructure
References: <20231204093702.989848513@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid endless .discard.foo sections for each annotation, create a
single .discard.annotate section that takes an annotation type along
with the instruction.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -57,6 +57,13 @@
 	".long 998b\n\t"						\
 	".popsection\n\t"
 
+#define ASM_ANNOTATE(x)						\
+	"911:\n\t"						\
+	".pushsection .discard.annotate,\"M\",@progbits,8\n\t"	\
+	".long 911b - .\n\t"					\
+	".long " __stringify(x) "\n\t"				\
+	".popsection\n\t"
+
 #else /* __ASSEMBLY__ */
 
 /*
@@ -146,6 +153,14 @@
 	.popsection
 .endm
 
+.macro ANNOTATE type:req
+.Lhere_\@:
+	.pushsection .discard.annotate,"M",@progbits,8
+	.long	.Lhere_\@ - .
+	.long	\type
+	.popsection
+.endm
+
 #endif /* __ASSEMBLY__ */
 
 #else /* !CONFIG_OBJTOOL */
@@ -167,6 +182,8 @@
 .endm
 .macro REACHABLE
 .endm
+.macro ANNOTATE
+.endm
 #endif
 
 #endif /* CONFIG_OBJTOOL */
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2308,6 +2308,41 @@ static int read_unwind_hints(struct objt
 	return 0;
 }
 
+static int read_annotate(struct objtool_file *file, void (*func)(int type, struct instruction *insn))
+{
+	struct section *rsec, *sec;
+	struct instruction *insn;
+	struct reloc *reloc;
+	int type;
+
+	rsec = find_section_by_name(file->elf, ".rela.discard.annotate");
+	if (!rsec)
+		return 0;
+
+	sec = find_section_by_name(file->elf, ".discard.annotate");
+	if (!sec)
+		return 0;
+
+	for_each_reloc(rsec, reloc) {
+		insn = find_insn(file, reloc->sym->sec,
+				 reloc->sym->offset + reloc_addend(reloc));
+		if (!insn) {
+			WARN("bad .discard.annotate entry: %d", reloc_idx(reloc));
+			return -1;
+		}
+
+		type = *(u32 *)(sec->data->d_buf + (reloc_idx(reloc) * sec->sh.sh_entsize) + 4);
+
+		func(type, insn);
+	}
+
+	return 0;
+}
+
+static void __annotate_nop(int type, struct instruction *insn)
+{
+}
+
 static int read_noendbr_hints(struct objtool_file *file)
 {
 	struct instruction *insn;
@@ -2602,6 +2637,8 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
+	ret = read_annotate(file, __annotate_nop);
+
 	/*
 	 * Must be before read_unwind_hints() since that needs insn->noendbr.
 	 */


