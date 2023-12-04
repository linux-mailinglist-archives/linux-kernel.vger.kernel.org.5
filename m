Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25892802ED1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbjLDJjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjLDJjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:39:47 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B86D2;
        Mon,  4 Dec 2023 01:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=g0iuyQNisDJC7BhdoXr7Rs7MdGYNzIIaLt95P6Iehys=; b=Rgb1sTCnRXLp1JXvxpNMSDS/1Z
        mIlwpaJ5yxcl7ADLIOhucqUrAEp0vm0h502BryZed9fq+raHpUTD06iVrwRkDVKZUj40MSRckEJgU
        7MIqcb0uwH63f0WuPRUSVFkK4NNHQCKRp1GMY3nqKMgEPxuP3NWjf1ma/XmwpA1Rxe4sApMJIlTF7
        pG7TeZv7icS38Q7qGYlXNqrJ04SJZZoqdiuc5rqRgl8BYUagwDU7t9cCcqgfDIG22izfvK+0sMBqq
        rd51IgIfKKvvRyhd56KWi+xXipG1WtvGZ/KLyVCjEjXzWjz8TgFv1AFtqWboNrrI1RkPb+DVuUEhY
        GEDJLQlA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rA5QZ-004KSf-0G;
        Mon, 04 Dec 2023 09:39:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id 9C995300665; Mon,  4 Dec 2023 10:39:45 +0100 (CET)
Message-Id: <20231204093731.812275775@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 04 Dec 2023 10:37:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        kvm@vger.kernel.org
Subject: [PATCH 05/11] objtool: Convert VALIDATE_UNRET_BEGIN to ANNOTATE
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
 include/linux/objtool.h             |    9 +++------
 include/linux/objtool_types.h       |    1 +
 tools/include/linux/objtool_types.h |    1 +
 tools/objtool/check.c               |   28 +++++-----------------------
 4 files changed, 10 insertions(+), 29 deletions(-)

--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -128,15 +128,12 @@
  * NOTE: The macro must be used at the beginning of a global symbol, otherwise
  * it will be ignored.
  */
-.macro VALIDATE_UNRET_BEGIN
 #if defined(CONFIG_NOINSTR_VALIDATION) && \
 	(defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_SRSO))
-.Lhere_\@:
-	.pushsection .discard.validate_unret
-	.long	.Lhere_\@ - .
-	.popsection
+#define VALIDATE_UNRET_BEGIN	ANNOTATE type=ANNOTYPE_UNRET_BEGIN
+#else
+#define VALIDATE_UNRET_BEGIN
 #endif
-.endm
 
 .macro REACHABLE
 .Lhere_\@:
--- a/include/linux/objtool_types.h
+++ b/include/linux/objtool_types.h
@@ -61,5 +61,6 @@ struct unwind_hint {
 #define ANNOTYPE_RETPOLINE_SAFE		2
 #define ANNOTYPE_INSTR_BEGIN		3
 #define ANNOTYPE_INSTR_END		4
+#define ANNOTYPE_UNRET_BEGIN		5
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
--- a/tools/include/linux/objtool_types.h
+++ b/tools/include/linux/objtool_types.h
@@ -61,5 +61,6 @@ struct unwind_hint {
 #define ANNOTYPE_RETPOLINE_SAFE		2
 #define ANNOTYPE_INSTR_BEGIN		3
 #define ANNOTYPE_INSTR_END		4
+#define ANNOTYPE_UNRET_BEGIN		5
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2385,33 +2385,15 @@ static int __annotate_instr(int type, st
 	return 0;
 }
 
-static int read_validate_unret_hints(struct objtool_file *file)
+static int __annotate_unret(int type, struct instruction *insn)
 {
-	struct section *rsec;
-	struct instruction *insn;
-	struct reloc *reloc;
-
-	rsec = find_section_by_name(file->elf, ".rela.discard.validate_unret");
-	if (!rsec)
+	if (type != ANNOTYPE_UNRET_BEGIN)
 		return 0;
 
-	for_each_reloc(rsec, reloc) {
-		if (reloc->sym->type != STT_SECTION) {
-			WARN("unexpected relocation symbol type in %s", rsec->name);
-			return -1;
-		}
-
-		insn = find_insn(file, reloc->sym->sec, reloc_addend(reloc));
-		if (!insn) {
-			WARN("bad .discard.instr_end entry");
-			return -1;
-		}
-		insn->unret = 1;
-	}
-
+	insn->unret = 1;
 	return 0;
-}
 
+}
 
 static int read_intra_function_calls(struct objtool_file *file)
 {
@@ -2629,7 +2611,7 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
-	ret = read_validate_unret_hints(file);
+	ret = read_annotate(file, __annotate_unret);
 	if (ret)
 		return ret;
 


