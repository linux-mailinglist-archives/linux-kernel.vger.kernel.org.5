Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8EF802ED5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbjLDJj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234819AbjLDJjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:39:48 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA41D7;
        Mon,  4 Dec 2023 01:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=dYFXJA1/fZVGzxQ5AQj4cq8phZVmCHY7eA+a7xfnNgw=; b=UViUllN2GgMzBFM3XF7KPRY00g
        gP45Jx1xsIlrgGmfRzKuGONtQnc5C+nuQDeZtLxcuyeiXfyJa62wIwK4GwrlE3rd5IliR1jILRQ7F
        69cFXzfDhlRmGLO8idhpw1eZGUftm4/uQkkiI54rs8GQvNVdGbb4cM4ehtU0rL1ZqlpoiSzIz2W/6
        OhFYJ0bq4520m8JqEkRPTo5d8F6TLFuD05vKP2AcrvAMvzQRe7e1VFf8WVr689HlMsh+LXLQ8JkUS
        RJeSarJ9wt9MZ081Cz3YRcI0yBglq18QWBZUeaUi3kMwydt2ms3/y7ZcEeS0S2DGjXUMKRroIyYnN
        5czykVNA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rA5QX-004KSa-31;
        Mon, 04 Dec 2023 09:39:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id 8FD413004AB; Mon,  4 Dec 2023 10:39:45 +0100 (CET)
Message-Id: <20231204093731.465944066@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 04 Dec 2023 10:37:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        kvm@vger.kernel.org
Subject: [PATCH 02/11] objtool: Convert ANNOTATE_NOENDBR to ANNOTATE
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
 include/linux/objtool.h             |   17 ++++-------------
 include/linux/objtool_types.h       |    5 +++++
 tools/include/linux/objtool_types.h |    5 +++++
 tools/objtool/check.c               |   32 +++++---------------------------
 4 files changed, 19 insertions(+), 40 deletions(-)

--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -45,12 +45,6 @@
 #define STACK_FRAME_NON_STANDARD_FP(func)
 #endif
 
-#define ANNOTATE_NOENDBR					\
-	"986: \n\t"						\
-	".pushsection .discard.noendbr\n\t"			\
-	".long 986b\n\t"					\
-	".popsection\n\t"
-
 #define ASM_REACHABLE							\
 	"998:\n\t"							\
 	".pushsection .discard.reachable\n\t"				\
@@ -64,6 +58,8 @@
 	".long " __stringify(x) "\n\t"				\
 	".popsection\n\t"
 
+#define ANNOTATE_NOENDBR	ASM_ANNOTATE(ANNOTYPE_NOENDBR)
+
 #else /* __ASSEMBLY__ */
 
 /*
@@ -122,13 +118,6 @@
 #endif
 .endm
 
-.macro ANNOTATE_NOENDBR
-.Lhere_\@:
-	.pushsection .discard.noendbr
-	.long	.Lhere_\@
-	.popsection
-.endm
-
 /*
  * Use objtool to validate the entry requirement that all code paths do
  * VALIDATE_UNRET_END before RET.
@@ -161,6 +150,8 @@
 	.popsection
 .endm
 
+#define ANNOTATE_NOENDBR	ANNOTATE type=ANNOTYPE_NOENDBR
+
 #endif /* __ASSEMBLY__ */
 
 #else /* !CONFIG_OBJTOOL */
--- a/include/linux/objtool_types.h
+++ b/include/linux/objtool_types.h
@@ -54,4 +54,9 @@ struct unwind_hint {
 #define UNWIND_HINT_TYPE_SAVE		6
 #define UNWIND_HINT_TYPE_RESTORE	7
 
+/*
+ * Annotate types
+ */
+#define ANNOTYPE_NOENDBR		1
+
 #endif /* _LINUX_OBJTOOL_TYPES_H */
--- a/tools/include/linux/objtool_types.h
+++ b/tools/include/linux/objtool_types.h
@@ -54,4 +54,9 @@ struct unwind_hint {
 #define UNWIND_HINT_TYPE_SAVE		6
 #define UNWIND_HINT_TYPE_RESTORE	7
 
+/*
+ * Annotate types
+ */
+#define ANNOTYPE_NOENDBR		1
+
 #endif /* _LINUX_OBJTOOL_TYPES_H */
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2339,32 +2339,12 @@ static int read_annotate(struct objtool_
 	return 0;
 }
 
-static void __annotate_nop(int type, struct instruction *insn)
+static void __annotate_noendbr(int type, struct instruction *insn)
 {
-}
-
-static int read_noendbr_hints(struct objtool_file *file)
-{
-	struct instruction *insn;
-	struct section *rsec;
-	struct reloc *reloc;
-
-	rsec = find_section_by_name(file->elf, ".rela.discard.noendbr");
-	if (!rsec)
-		return 0;
+	if (type != ANNOTYPE_NOENDBR)
+		return;
 
-	for_each_reloc(rsec, reloc) {
-		insn = find_insn(file, reloc->sym->sec,
-				 reloc->sym->offset + reloc_addend(reloc));
-		if (!insn) {
-			WARN("bad .discard.noendbr entry");
-			return -1;
-		}
-
-		insn->noendbr = 1;
-	}
-
-	return 0;
+	insn->noendbr = 1;
 }
 
 static int read_retpoline_hints(struct objtool_file *file)
@@ -2637,12 +2617,10 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
-	ret = read_annotate(file, __annotate_nop);
-
 	/*
 	 * Must be before read_unwind_hints() since that needs insn->noendbr.
 	 */
-	ret = read_noendbr_hints(file);
+	ret = read_annotate(file, __annotate_noendbr);
 	if (ret)
 		return ret;
 


