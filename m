Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4122C802EE4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbjLDJk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235298AbjLDJkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:40:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D5511F;
        Mon,  4 Dec 2023 01:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=8ZmAUMpjWfI1B/Ma4euS1POKJrZM+zq/pwDtgORWvEc=; b=FC/UR0CiYDmD1lg2YNafE0u8li
        V7kroPRWHIgQ2/E/iiUueEIj1uUgoAEPxumPvomDI6eB1boaDNpS+xHF8wBxJZQpBWsZpXaJrm6Cc
        cK825dGuTUbyp02KfhCJtl+XVWRJws9bjmZLPmB1Z4y9uL4QVqNOm+XJaLk45wagD56VsPcIRzCXf
        zF3DadFti78h/5AlaHjW0ncY33DERXcbn0t3HXKvRF7BKgDDRUMUUKbQpiN7VZyL//20MiE6J8YHc
        nB22u8bGlf/mkrq8eV9wrtG3b4DseXA8uT1Kvzg7L+7BCOJ4P4H7KUoxUNV60xmQpTD43+sWYE8Qe
        YY8dUfaQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1rA5QZ-000X0a-66; Mon, 04 Dec 2023 09:39:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id A8328300FAE; Mon,  4 Dec 2023 10:39:45 +0100 (CET)
Message-Id: <20231204093732.204792131@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 04 Dec 2023 10:37:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        kvm@vger.kernel.org
Subject: [PATCH 08/11] objtool: Collapse annotate sequences
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

Reduce read_annotate() runs by collapsing subsequent runs into a
single call.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |   87 ++++++++++++++++++--------------------------------
 1 file changed, 32 insertions(+), 55 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2308,21 +2308,24 @@ static int read_annotate(struct objtool_
 	return 0;
 }
 
-static int __annotate_ignore_alts(struct objtool_file *file, int type, struct instruction *insn)
+static int __annotate_early(struct objtool_file *file, int type, struct instruction *insn)
 {
-	if (type != ANNOTYPE_IGNORE_ALTS)
-		return 0;
+	switch (type) {
+	case ANNOTYPE_IGNORE_ALTS:
+		insn->ignore_alts = true;
+		break;
 
-	insn->ignore_alts = true;
-	return 0;
-}
+	/*
+	 * Must be before read_unwind_hints() since that needs insn->noendbr.
+	 */
+	case ANNOTYPE_NOENDBR:
+		insn->noendbr = 1;
+		break;
 
-static int __annotate_noendbr(struct objtool_file *file, int type, struct instruction *insn)
-{
-	if (type != ANNOTYPE_NOENDBR)
-		return 0;
+	default:
+		break;
+	}
 
-	insn->noendbr = 1;
 	return 0;
 }
 
@@ -2356,26 +2359,21 @@ static int __annotate_ifc(struct objtool
 	return 0;
 }
 
-static int __annotate_retpoline_safe(struct objtool_file *file, int type, struct instruction *insn)
+static int __annotate_late(struct objtool_file *file, int type, struct instruction *insn)
 {
-	if (type != ANNOTYPE_RETPOLINE_SAFE)
-		return 0;
-
-	if (insn->type != INSN_JUMP_DYNAMIC &&
-	    insn->type != INSN_CALL_DYNAMIC &&
-	    insn->type != INSN_RETURN &&
-	    insn->type != INSN_NOP) {
-		WARN_INSN(insn, "retpoline_safe hint not an indirect jump/call/ret/nop");
-		return -1;
-	}
+	switch (type) {
+	case ANNOTYPE_RETPOLINE_SAFE:
+		if (insn->type != INSN_JUMP_DYNAMIC &&
+		    insn->type != INSN_CALL_DYNAMIC &&
+		    insn->type != INSN_RETURN &&
+		    insn->type != INSN_NOP) {
+			WARN_INSN(insn, "retpoline_safe hint not an indirect jump/call/ret/nop");
+			return -1;
+		}
 
-	insn->retpoline_safe = true;
-	return 0;
-}
+		insn->retpoline_safe = true;
+		break;
 
-static int __annotate_instr(struct objtool_file *file, int type, struct instruction *insn)
-{
-	switch (type) {
 	case ANNOTYPE_INSTR_BEGIN:
 		insn->instr++;
 		break;
@@ -2384,6 +2382,10 @@ static int __annotate_instr(struct objto
 		insn->instr--;
 		break;
 
+	case ANNOTYPE_UNRET_BEGIN:
+		insn->unret = 1;
+		break;
+
 	default:
 		break;
 	}
@@ -2391,16 +2393,6 @@ static int __annotate_instr(struct objto
 	return 0;
 }
 
-static int __annotate_unret(struct objtool_file *file, int type, struct instruction *insn)
-{
-	if (type != ANNOTYPE_UNRET_BEGIN)
-		return 0;
-
-	insn->unret = 1;
-	return 0;
-
-}
-
 /*
  * Return true if name matches an instrumentation function, where calls to that
  * function from noinstr code can safely be removed, but compilers won't do so.
@@ -2507,14 +2499,7 @@ static int decode_sections(struct objtoo
 	add_ignores(file);
 	add_uaccess_safe(file);
 
-	ret = read_annotate(file, __annotate_ignore_alts);
-	if (ret)
-		return ret;
-
-	/*
-	 * Must be before read_unwind_hints() since that needs insn->noendbr.
-	 */
-	ret = read_annotate(file, __annotate_noendbr);
+	ret = read_annotate(file, __annotate_early);
 	if (ret)
 		return ret;
 
@@ -2560,15 +2545,7 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
-	ret = read_annotate(file, __annotate_retpoline_safe);
-	if (ret)
-		return ret;
-
-	ret = read_annotate(file, __annotate_instr);
-	if (ret)
-		return ret;
-
-	ret = read_annotate(file, __annotate_unret);
+	ret = read_annotate(file, __annotate_late);
 	if (ret)
 		return ret;
 


