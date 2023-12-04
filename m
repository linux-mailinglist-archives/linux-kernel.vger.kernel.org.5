Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E5B802ED3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbjLDJjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbjLDJjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:39:48 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DF8CD;
        Mon,  4 Dec 2023 01:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=cKtSfZ5sWaSTj7tZINYGDLIwyP/HVC5Nz5I81xWPCwk=; b=UJ4QbxuBSELUeSrjN4lie1/3Nn
        sLbJRS71hZLDxuqqfx0RU270C87H+Ymw6e3gZXjYlGd71WgXV0HAq4BtolDaoiqcNJFkHY0dKMTG3
        /zeZmKHZGL8lJchX5o+/rizS5A9SMrwY5iIjr8PSuKOAhtNFrTY22O9pFjYU1x33YdR0oVwCWAZjk
        mXcSzUX5aDu58oFsY3OITPf3xQLg3G6yydcoZcaTi0fHwDai0LrRHajnvymn3gIYbMh78WKnm2UFQ
        vECPvLWn/QORqhFYQA/SBQJQVoWs3DywzZmFe3jyjv0Kl/1ZZaUMHVjwGQAV5bdgJ92kTeaHa0F5n
        AgYZ1C6A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rA5QZ-004KSk-1O;
        Mon, 04 Dec 2023 09:39:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id B32B7301C46; Mon,  4 Dec 2023 10:39:45 +0100 (CET)
Message-Id: <20231204093732.580299853@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 04 Dec 2023 10:37:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        kvm@vger.kernel.org
Subject: [PATCH 11/11] x86/kvm/emulate: Avoid RET for fastops
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

Since there is only a single fastop() function, convert the FASTOP
stuff from CALL_NOSPEC+RET to JMP_NOSPEC+JMP, avoiding the return
thunks and all that jazz.

Specifically FASTOPs rely on the return thunk to preserve EFLAGS,
which not all of them can trivially do (call depth tracing suffers
here).

Objtool strenuously complains about this:

 - indirect call without a .rodata, fails to determine JUMP_TABLE,
   annotate
 - fastop functions fall through, exception
 - unreachable instruction after fastop_return, save/restore

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kvm/emulate.c              |   20 +++++++++++++++-----
 include/linux/objtool_types.h       |    1 +
 tools/include/linux/objtool_types.h |    1 +
 tools/objtool/check.c               |   11 ++++++++++-
 4 files changed, 27 insertions(+), 6 deletions(-)

--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -285,8 +285,8 @@ static void invalidate_registers(struct
  * different operand sizes can be reached by calculation, rather than a jump
  * table (which would be bigger than the code).
  *
- * The 16 byte alignment, considering 5 bytes for the RET thunk, 3 for ENDBR
- * and 1 for the straight line speculation INT3, leaves 7 bytes for the
+ * The 16 byte alignment, considering 5 bytes for the JMP, 4 for ENDBR
+ * and 1 for the straight line speculation INT3, leaves 6 bytes for the
  * body of the function.  Currently none is larger than 4.
  */
 static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
@@ -304,7 +304,7 @@ static int fastop(struct x86_emulate_ctx
 	__FOP_FUNC(#name)
 
 #define __FOP_RET(name) \
-	"11: " ASM_RET \
+	"11: jmp fastop_return; int3 \n\t" \
 	".size " name ", .-" name "\n\t"
 
 #define FOP_RET(name) \
@@ -5071,14 +5071,24 @@ static void fetch_possible_mmx_operand(s
 		kvm_read_mmx_reg(op->addr.mm, &op->mm_val);
 }
 
-static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop)
+/*
+ * All the FASTOP magic above relies on there being *one* instance of this
+ * so it can JMP back, avoiding RET and it's various thunks.
+ */
+static noinline int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop)
 {
 	ulong flags = (ctxt->eflags & EFLAGS_MASK) | X86_EFLAGS_IF;
 
 	if (!(ctxt->d & ByteOp))
 		fop += __ffs(ctxt->dst.bytes) * FASTOP_SIZE;
 
-	asm("push %[flags]; popf; " CALL_NOSPEC " ; pushf; pop %[flags]\n"
+	asm("push %[flags]; popf \n\t"
+	    UNWIND_HINT(UNWIND_HINT_TYPE_SAVE, 0, 0, 0)
+	    ASM_ANNOTATE(ANNOTYPE_JUMP_TABLE)
+	    JMP_NOSPEC
+	    "fastop_return: \n\t"
+	    UNWIND_HINT(UNWIND_HINT_TYPE_RESTORE, 0, 0, 0)
+	    "pushf; pop %[flags]\n"
 	    : "+a"(ctxt->dst.val), "+d"(ctxt->src.val), [flags]"+D"(flags),
 	      [thunk_target]"+S"(fop), ASM_CALL_CONSTRAINT
 	    : "c"(ctxt->src2.val));
--- a/include/linux/objtool_types.h
+++ b/include/linux/objtool_types.h
@@ -64,5 +64,6 @@ struct unwind_hint {
 #define ANNOTYPE_UNRET_BEGIN		5
 #define ANNOTYPE_IGNORE_ALTS		6
 #define ANNOTYPE_INTRA_FUNCTION_CALLS	7
+#define ANNOTYPE_JUMP_TABLE		8
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
--- a/tools/include/linux/objtool_types.h
+++ b/tools/include/linux/objtool_types.h
@@ -64,5 +64,6 @@ struct unwind_hint {
 #define ANNOTYPE_UNRET_BEGIN		5
 #define ANNOTYPE_IGNORE_ALTS		6
 #define ANNOTYPE_INTRA_FUNCTION_CALLS	7
+#define ANNOTYPE_JUMP_TABLE		8
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2386,6 +2386,14 @@ static int __annotate_late(struct objtoo
 		insn->unret = 1;
 		break;
 
+	/*
+	 * Must be after add_jump_table(); for it doesn't set a sane
+	 * _jump_table value.
+	 */
+	case ANNOTYPE_JUMP_TABLE:
+		insn->_jump_table = (void *)1;
+		break;
+
 	default:
 		break;
 	}
@@ -3459,7 +3467,8 @@ static int validate_branch(struct objtoo
 		if (func && insn_func(insn) && func != insn_func(insn)->pfunc) {
 			/* Ignore KCFI type preambles, which always fall through */
 			if (!strncmp(func->name, "__cfi_", 6) ||
-			    !strncmp(func->name, "__pfx_", 6))
+			    !strncmp(func->name, "__pfx_", 6) ||
+			    !strcmp(insn_func(insn)->name, "fastop"))
 				return 0;
 
 			WARN("%s() falls through to next function %s()",


