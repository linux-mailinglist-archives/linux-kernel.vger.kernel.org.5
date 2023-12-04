Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA483802EDD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbjLDJkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbjLDJjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:39:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2186F5;
        Mon,  4 Dec 2023 01:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=O8rCIvUkqNpAaMxQiAO/KoN2MOG0w6rqWm9LpswbbCQ=; b=q9R9fx4vg0uquJMFeJdbApPPIs
        jj3YYjiouv/ehAon4kJDHUvxLjVTIC8OrzcWy7fiomAUv1Er/dcezIlQ8DeuS+Y1CyG65cxsxhDwV
        5WDIS9FLy8TwVzDjTXXwn6UYaK18UXcT4+9r+MoR1DKzKY9brq3tZnVXEPVyRcnSZNFdarWKphrlY
        K+kCOQKhbOc4WnO9ZZUCTAuMopdcSwFn9zma0LOdwI4Ug8F+PFzJhSGaQAWOM+gzQLZRsxSNVeW63
        Wa2FwhIuOAUpsfKoAkpRf1h2gd49TvpZrQIe6CWpIVrabOJc2xh+IeHkzEJTUK/sdCt3YK5Au34aW
        07PArYAg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1rA5QY-000X0O-GF; Mon, 04 Dec 2023 09:39:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id 9430E3004D5; Mon,  4 Dec 2023 10:39:45 +0100 (CET)
Message-Id: <20231204093731.574465649@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 04 Dec 2023 10:37:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        kvm@vger.kernel.org
Subject: [PATCH 03/11] objtool: Convert ANNOTATE_RETPOLINE_SAFE to ANNOTATE
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


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/nospec-branch.h |   13 +-------
 include/linux/objtool_types.h        |    1 
 tools/include/linux/objtool_types.h  |    1 
 tools/objtool/check.c                |   52 ++++++++++++-----------------------
 4 files changed, 22 insertions(+), 45 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -193,12 +193,7 @@
  * objtool the subsequent indirect jump/call is vouched safe for retpoline
  * builds.
  */
-.macro ANNOTATE_RETPOLINE_SAFE
-.Lhere_\@:
-	.pushsection .discard.retpoline_safe
-	.long .Lhere_\@
-	.popsection
-.endm
+#define ANNOTATE_RETPOLINE_SAFE	ANNOTATE type=ANNOTYPE_RETPOLINE_SAFE
 
 /*
  * (ab)use RETPOLINE_SAFE on RET to annotate away 'bare' RET instructions
@@ -317,11 +312,7 @@
 
 #else /* __ASSEMBLY__ */
 
-#define ANNOTATE_RETPOLINE_SAFE					\
-	"999:\n\t"						\
-	".pushsection .discard.retpoline_safe\n\t"		\
-	".long 999b\n\t"					\
-	".popsection\n\t"
+#define ANNOTATE_RETPOLINE_SAFE ASM_ANNOTATE(ANNOTYPE_RETPOLINE_SAFE)
 
 typedef u8 retpoline_thunk_t[RETPOLINE_THUNK_SIZE];
 extern retpoline_thunk_t __x86_indirect_thunk_array[];
--- a/include/linux/objtool_types.h
+++ b/include/linux/objtool_types.h
@@ -58,5 +58,6 @@ struct unwind_hint {
  * Annotate types
  */
 #define ANNOTYPE_NOENDBR		1
+#define ANNOTYPE_RETPOLINE_SAFE		2
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
--- a/tools/include/linux/objtool_types.h
+++ b/tools/include/linux/objtool_types.h
@@ -58,5 +58,6 @@ struct unwind_hint {
  * Annotate types
  */
 #define ANNOTYPE_NOENDBR		1
+#define ANNOTYPE_RETPOLINE_SAFE		2
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2308,12 +2308,12 @@ static int read_unwind_hints(struct objt
 	return 0;
 }
 
-static int read_annotate(struct objtool_file *file, void (*func)(int type, struct instruction *insn))
+static int read_annotate(struct objtool_file *file, int (*func)(int type, struct instruction *insn))
 {
 	struct section *rsec, *sec;
 	struct instruction *insn;
 	struct reloc *reloc;
-	int type;
+	int type, ret;
 
 	rsec = find_section_by_name(file->elf, ".rela.discard.annotate");
 	if (!rsec)
@@ -2333,53 +2333,37 @@ static int read_annotate(struct objtool_
 
 		type = *(u32 *)(sec->data->d_buf + (reloc_idx(reloc) * sec->sh.sh_entsize) + 4);
 
-		func(type, insn);
+		ret = func(type, insn);
+		if (ret < 0)
+			return ret;
 	}
 
 	return 0;
 }
 
-static void __annotate_noendbr(int type, struct instruction *insn)
+static int __annotate_noendbr(int type, struct instruction *insn)
 {
 	if (type != ANNOTYPE_NOENDBR)
-		return;
+		return 0;
 
 	insn->noendbr = 1;
+	return 0;
 }
 
-static int read_retpoline_hints(struct objtool_file *file)
+static int __annotate_retpoline_safe(int type, struct instruction *insn)
 {
-	struct section *rsec;
-	struct instruction *insn;
-	struct reloc *reloc;
-
-	rsec = find_section_by_name(file->elf, ".rela.discard.retpoline_safe");
-	if (!rsec)
+	if (type != ANNOTYPE_RETPOLINE_SAFE)
 		return 0;
 
-	for_each_reloc(rsec, reloc) {
-		if (reloc->sym->type != STT_SECTION) {
-			WARN("unexpected relocation symbol type in %s", rsec->name);
-			return -1;
-		}
-
-		insn = find_insn(file, reloc->sym->sec, reloc_addend(reloc));
-		if (!insn) {
-			WARN("bad .discard.retpoline_safe entry");
-			return -1;
-		}
-
-		if (insn->type != INSN_JUMP_DYNAMIC &&
-		    insn->type != INSN_CALL_DYNAMIC &&
-		    insn->type != INSN_RETURN &&
-		    insn->type != INSN_NOP) {
-			WARN_INSN(insn, "retpoline_safe hint not an indirect jump/call/ret/nop");
-			return -1;
-		}
-
-		insn->retpoline_safe = true;
+	if (insn->type != INSN_JUMP_DYNAMIC &&
+	    insn->type != INSN_CALL_DYNAMIC &&
+	    insn->type != INSN_RETURN &&
+	    insn->type != INSN_NOP) {
+		WARN_INSN(insn, "retpoline_safe hint not an indirect jump/call/ret/nop");
+		return -1;
 	}
 
+	insn->retpoline_safe = true;
 	return 0;
 }
 
@@ -2666,7 +2650,7 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
-	ret = read_retpoline_hints(file);
+	ret = read_annotate(file, __annotate_retpoline_safe);
 	if (ret)
 		return ret;
 


