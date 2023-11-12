Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE927E926F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 21:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjKLUMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 15:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjKLUMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 15:12:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C182583
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 12:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=7IoGT0pwhX7axnPfvjlRN2Ueix49kn72W2HXHOjg48o=; b=clfnheAjxV2mUSCg8C8qoD0fyx
        DlpJks1tMSZXX8PW4TDzctsvjxyYfY1k8jXMUhVl49vKugKlI+hsoIaUajMWZYEo7RZOq17TBhDse
        7UAh3/iqFU3GchKbUNex/Gy76ZRfBrImmqAem9yxQ7DWlA0+t+Ki87eOiSLwn8EXtLMGgO0OPq1Lj
        HulzGNugyrcJcd16HxqdxtKaDK1KmuHXIwLYyp+uNJXPjucgtj/9QtXz6NBm+WT1rIM8jXwphbIz/
        FqFZyjeLtlxoCabzFZ166gDmU6j5igxGk9Sl2XyvAajTW71tWqZeoAqT53C+d2GNO7UrC6TgfrlkF
        COXDVumg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r2GoP-009z9T-KX; Sun, 12 Nov 2023 20:12:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id F3E6C300427; Sun, 12 Nov 2023 21:12:05 +0100 (CET)
Date:   Sun, 12 Nov 2023 21:12:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [RFC] x86/kvm/emulate: Avoid RET for fastops
Message-ID: <20231112201205.GB9987@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Inspired by the likes of ba5ca5e5e6a1 ("x86/retpoline: Don't clobber
RFLAGS during srso_safe_ret()") I had it on my TODO to look at this,
because the call-depth-tracking rethunk definitely also clobbers flags
and that's a ton harder to fix.

Looking at this recently I noticed that there's really only one callsite
(twice, the testcc thing is basically separate from the rest of the
fastop stuff) and thus CALL+RET is totally silly, we can JMP+JMP.

The below implements this, and aside from objtool going apeshit (it
fails to recognise the fastop JMP_NOSPEC as a jump-table and instead
classifies it as a tail-call), it actually builds and the asm looks
good sensible enough.

I've not yet figured out how to test this stuff, but does something like
this look sane to you guys?

Given that rethunks are quite fat and slow, this could be sold as a
performance optimization I suppose.

---

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index f93e9b96927a..2cd3b5a46e7a 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -412,6 +412,17 @@ static inline void call_depth_return_thunk(void) {}
 	"call *%[thunk_target]\n",				\
 	X86_FEATURE_RETPOLINE_LFENCE)
 
+# define JMP_NOSPEC						\
+	ALTERNATIVE_2(						\
+	ANNOTATE_RETPOLINE_SAFE					\
+	"jmp *%[thunk_target]\n",				\
+	"jmp __x86_indirect_thunk_%V[thunk_target]\n",		\
+	X86_FEATURE_RETPOLINE,					\
+	"lfence;\n"						\
+	ANNOTATE_RETPOLINE_SAFE					\
+	"jmp *%[thunk_target]\n",				\
+	X86_FEATURE_RETPOLINE_LFENCE)
+
 # define THUNK_TARGET(addr) [thunk_target] "r" (addr)
 
 #else /* CONFIG_X86_32 */
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 2673cd5c46cb..9aae15d223a8 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -294,7 +294,6 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
 
 #define __FOP_FUNC(name) \
 	".align " __stringify(FASTOP_SIZE) " \n\t" \
-	".type " name ", @function \n\t" \
 	name ":\n\t" \
 	ASM_ENDBR \
 	IBT_NOSEAL(name)
@@ -302,12 +301,15 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
 #define FOP_FUNC(name) \
 	__FOP_FUNC(#name)
 
-#define __FOP_RET(name) \
-	"11: " ASM_RET \
+#define __FOP_JMP(name, label) \
+	"11: jmp " label " ; int3 \n\t" \
 	".size " name ", .-" name "\n\t"
 
-#define FOP_RET(name) \
-	__FOP_RET(#name)
+#define FOP_JMP(name, label) \
+	__FOP_JMP(#name, #label)
+
+#define __FOP_RET(name) \
+	__FOP_JMP(name, "fastop_return")
 
 #define __FOP_START(op, align) \
 	extern void em_##op(struct fastop *fake); \
@@ -420,7 +422,7 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
 #define FOP_SETCC(op) \
 	FOP_FUNC(op) \
 	#op " %al \n\t" \
-	FOP_RET(op)
+	FOP_JMP(op, setcc_return)
 
 FOP_START(setcc)
 FOP_SETCC(seto)
@@ -444,7 +446,7 @@ FOP_END;
 FOP_START(salc)
 FOP_FUNC(salc)
 "pushf; sbb %al, %al; popf \n\t"
-FOP_RET(salc)
+FOP_JMP(salc, fastop_return)
 FOP_END;
 
 /*
@@ -1061,13 +1063,13 @@ static int em_bsr_c(struct x86_emulate_ctxt *ctxt)
 	return fastop(ctxt, em_bsr);
 }
 
-static __always_inline u8 test_cc(unsigned int condition, unsigned long flags)
+static noinline u8 test_cc(unsigned int condition, unsigned long flags)
 {
 	u8 rc;
 	void (*fop)(void) = (void *)em_setcc + FASTOP_SIZE * (condition & 0xf);
 
 	flags = (flags & EFLAGS_MASK) | X86_EFLAGS_IF;
-	asm("push %[flags]; popf; " CALL_NOSPEC
+	asm("push %[flags]; popf; " JMP_NOSPEC "; setcc_return:"
 	    : "=a"(rc) : [thunk_target]"r"(fop), [flags]"r"(flags));
 	return rc;
 }
@@ -5101,14 +5103,14 @@ static void fetch_possible_mmx_operand(struct operand *op)
 		kvm_read_mmx_reg(op->addr.mm, &op->mm_val);
 }
 
-static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop)
+static noinline int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop)
 {
 	ulong flags = (ctxt->eflags & EFLAGS_MASK) | X86_EFLAGS_IF;
 
 	if (!(ctxt->d & ByteOp))
 		fop += __ffs(ctxt->dst.bytes) * FASTOP_SIZE;
 
-	asm("push %[flags]; popf; " CALL_NOSPEC " ; pushf; pop %[flags]\n"
+	asm("push %[flags]; popf; " JMP_NOSPEC " ; fastop_return: ; pushf; pop %[flags]\n"
 	    : "+a"(ctxt->dst.val), "+d"(ctxt->src.val), [flags]"+D"(flags),
 	      [thunk_target]"+S"(fop), ASM_CALL_CONSTRAINT
 	    : "c"(ctxt->src2.val));
