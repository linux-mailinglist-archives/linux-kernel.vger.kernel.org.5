Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAD6802ED2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjLDJju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjLDJjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:39:47 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAF0B2;
        Mon,  4 Dec 2023 01:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=iT8rZBU1kFBBncA0eT4LO89fZPLO0VJsqubseEy0Iso=; b=hp565mu6qAqH0rQKKpsy33mH+O
        VpKF9v1+ZY5Yp+5PFrwbFzKoNR9q9e3UR44zfU8E52uaGpF57V1ZBwk9ex1c/RW5p3Od/YJFqJZz5
        zuiTDQVT9+w7JKjVWBcLB8Vv4+gmq129P9lBr5yg9qvgqBxB4BrFavooC1bGcArbIfucbEELn6o79
        fR1WgLHahQIucmH/dpwTyvpF1k5sfKeNNizLgH/ADqofQuJ1dUJ8NWxTTlHcTWnw15v19iGIQ5nGR
        Kv+xQU8tCFXSNvMjw6+2brg+Q6jtAnzfPE6Nd+wgZr7wajPnlEpn58wxBW181sjQQUqWc1YGByOod
        yXtVUwng==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rA5QY-004KSg-34;
        Mon, 04 Dec 2023 09:39:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id A03D730088E; Mon,  4 Dec 2023 10:39:45 +0100 (CET)
Message-Id: <20231204093731.986118946@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 04 Dec 2023 10:37:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        kvm@vger.kernel.org
Subject: [PATCH 06/11] objtool: Convert ANNOTATE_IGNORE_ALTERNATIVE to ANNOTATE
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
 arch/x86/include/asm/alternative.h  |   14 ++---------
 include/linux/objtool_types.h       |    1 
 tools/include/linux/objtool_types.h |    1 
 tools/objtool/check.c               |   45 ++++++++----------------------------
 4 files changed, 15 insertions(+), 46 deletions(-)

--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/stringify.h>
+#include <linux/objtool.h>
 #include <asm/asm.h>
 
 #define ALT_FLAGS_SHIFT		16
@@ -55,11 +56,7 @@
  * objtool annotation to ignore the alternatives and only consider the original
  * instruction(s).
  */
-#define ANNOTATE_IGNORE_ALTERNATIVE				\
-	"999:\n\t"						\
-	".pushsection .discard.ignore_alts\n\t"			\
-	".long 999b\n\t"					\
-	".popsection\n\t"
+#define ANNOTATE_IGNORE_ALTERNATIVE	ASM_ANNOTATE(ANNOTYPE_IGNORE_ALTS)
 
 /*
  * The patching flags are part of the upper bits of the @ft_flags parameter when
@@ -349,12 +346,7 @@ static inline int alternatives_text_rese
  * objtool annotation to ignore the alternatives and only consider the original
  * instruction(s).
  */
-.macro ANNOTATE_IGNORE_ALTERNATIVE
-	.Lannotate_\@:
-	.pushsection .discard.ignore_alts
-	.long .Lannotate_\@
-	.popsection
-.endm
+#define ANNOTATE_IGNORE_ALTERNATIVE ANNOTATE type=ANNOTYPE_IGNORE_ALTS
 
 /*
  * Issue one struct alt_instr descriptor entry (need to put it into
--- a/include/linux/objtool_types.h
+++ b/include/linux/objtool_types.h
@@ -62,5 +62,6 @@ struct unwind_hint {
 #define ANNOTYPE_INSTR_BEGIN		3
 #define ANNOTYPE_INSTR_END		4
 #define ANNOTYPE_UNRET_BEGIN		5
+#define ANNOTYPE_IGNORE_ALTS		6
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
--- a/tools/include/linux/objtool_types.h
+++ b/tools/include/linux/objtool_types.h
@@ -62,5 +62,6 @@ struct unwind_hint {
 #define ANNOTYPE_INSTR_BEGIN		3
 #define ANNOTYPE_INSTR_END		4
 #define ANNOTYPE_UNRET_BEGIN		5
+#define ANNOTYPE_IGNORE_ALTS		6
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1255,40 +1255,6 @@ static void add_uaccess_safe(struct objt
 }
 
 /*
- * FIXME: For now, just ignore any alternatives which add retpolines.  This is
- * a temporary hack, as it doesn't allow ORC to unwind from inside a retpoline.
- * But it at least allows objtool to understand the control flow *around* the
- * retpoline.
- */
-static int add_ignore_alternatives(struct objtool_file *file)
-{
-	struct section *rsec;
-	struct reloc *reloc;
-	struct instruction *insn;
-
-	rsec = find_section_by_name(file->elf, ".rela.discard.ignore_alts");
-	if (!rsec)
-		return 0;
-
-	for_each_reloc(rsec, reloc) {
-		if (reloc->sym->type != STT_SECTION) {
-			WARN("unexpected relocation symbol type in %s", rsec->name);
-			return -1;
-		}
-
-		insn = find_insn(file, reloc->sym->sec, reloc_addend(reloc));
-		if (!insn) {
-			WARN("bad .discard.ignore_alts entry");
-			return -1;
-		}
-
-		insn->ignore_alts = true;
-	}
-
-	return 0;
-}
-
-/*
  * Symbols that replace INSN_CALL_DYNAMIC, every (tail) call to such a symbol
  * will be added to the .retpoline_sites section.
  */
@@ -2341,6 +2307,15 @@ static int read_annotate(struct objtool_
 	return 0;
 }
 
+static int __annotate_ignore_alts(int type, struct instruction *insn)
+{
+	if (type != ANNOTYPE_IGNORE_ALTS)
+		return 0;
+
+	insn->ignore_alts = true;
+	return 0;
+}
+
 static int __annotate_noendbr(int type, struct instruction *insn)
 {
 	if (type != ANNOTYPE_NOENDBR)
@@ -2550,7 +2525,7 @@ static int decode_sections(struct objtoo
 	add_ignores(file);
 	add_uaccess_safe(file);
 
-	ret = add_ignore_alternatives(file);
+	ret = read_annotate(file, __annotate_ignore_alts);
 	if (ret)
 		return ret;
 


