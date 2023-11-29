Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5290B7FDABF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbjK2PFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbjK2PFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:05:02 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4667BE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xYpfXEr5oDF3xuFrNicRikWRVjqbNinwQMUs2imXNvE=; b=TsB4JoQ/6oi3l4cnLJt98OtFhx
        /xNBHHdGETsIrLLT56aCF+xABHaGjBiGmOZG3/lX+j4VDGLotfgj7he5duDtSdXoZQBw6WnFYb1HH
        JE3FvCIE5Wmyk+sHq2FPUY8bto6ZHMJvzip3xYGvWga9JWmkRKQ+uB9HePv9EKG6oFC1v75kWeZJc
        vCXiW4pWwebguyDxOlgIB2L95ePzXGh+cYMU2KrvsEKfDlWeXZqAB/szWei7GgCW5t1NUEPkLmwtt
        RrHmL6zlb2+cwj4IsJi06w0K7cgELqULxcEMlsjw1wYFxawun5vo+lJrJ340+NuxsoiRXnMbVSWsY
        IR6uvX0Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r8M7S-000OVM-1b;
        Wed, 29 Nov 2023 15:04:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6310130017D; Wed, 29 Nov 2023 16:04:53 +0100 (CET)
Date:   Wed, 29 Nov 2023 16:04:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC] x86/kvm/emulate: Avoid RET for fastops
Message-ID: <20231129150453.GA23596@noisy.programming.kicks-ass.net>
References: <20231112201205.GB9987@noisy.programming.kicks-ass.net>
 <ZWaV8H9e8ubhFgWJ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWaV8H9e8ubhFgWJ@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 05:37:52PM -0800, Sean Christopherson wrote:
> On Sun, Nov 12, 2023, Peter Zijlstra wrote:
> > Hi,
> > 
> > Inspired by the likes of ba5ca5e5e6a1 ("x86/retpoline: Don't clobber
> > RFLAGS during srso_safe_ret()") I had it on my TODO to look at this,
> > because the call-depth-tracking rethunk definitely also clobbers flags
> > and that's a ton harder to fix.
> > 
> > Looking at this recently I noticed that there's really only one callsite
> > (twice, the testcc thing is basically separate from the rest of the
> > fastop stuff) and thus CALL+RET is totally silly, we can JMP+JMP.
> > 
> > The below implements this, and aside from objtool going apeshit (it
> > fails to recognise the fastop JMP_NOSPEC as a jump-table and instead
> > classifies it as a tail-call), it actually builds and the asm looks
> > good sensible enough.
> > 
> > I've not yet figured out how to test this stuff, but does something like
> > this look sane to you guys?
> 
> Yes?  The idea seems sound, but I haven't thought _that_ hard about whether or not
> there's any possible gotchas.   I did a quick test and nothing exploded (and
> usually when this code breaks, it breaks spectacularly).

Looking at this more, I was wondering if there is something magical
about test_cc(). Both naming and purpose seems to be testing the flags,
but it has a side effect of actually setting the flags too, does
anything rely on that?

That is, we already have code that emulates the condition-codes, might
as well use it here and avoid a bunch of dodgy asm, no?

---
 arch/x86/include/asm/text-patching.h | 20 +++++++++++++-------
 arch/x86/kvm/emulate.c               | 34 ++--------------------------------
 2 files changed, 15 insertions(+), 39 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index 29832c338cdc..7b9d7fe0ab64 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -186,9 +186,9 @@ void int3_emulate_ret(struct pt_regs *regs)
 }
 
 static __always_inline
-void int3_emulate_jcc(struct pt_regs *regs, u8 cc, unsigned long ip, unsigned long disp)
+bool __emulate_cc(unsigned long flags, u8 cc)
 {
-	static const unsigned long jcc_mask[6] = {
+	static const unsigned long cc_mask[6] = {
 		[0] = X86_EFLAGS_OF,
 		[1] = X86_EFLAGS_CF,
 		[2] = X86_EFLAGS_ZF,
@@ -201,15 +201,21 @@ void int3_emulate_jcc(struct pt_regs *regs, u8 cc, unsigned long ip, unsigned lo
 	bool match;
 
 	if (cc < 0xc) {
-		match = regs->flags & jcc_mask[cc >> 1];
+		match = flags & cc_mask[cc >> 1];
 	} else {
-		match = ((regs->flags & X86_EFLAGS_SF) >> X86_EFLAGS_SF_BIT) ^
-			((regs->flags & X86_EFLAGS_OF) >> X86_EFLAGS_OF_BIT);
+		match = ((flags & X86_EFLAGS_SF) >> X86_EFLAGS_SF_BIT) ^
+			((flags & X86_EFLAGS_OF) >> X86_EFLAGS_OF_BIT);
 		if (cc >= 0xe)
-			match = match || (regs->flags & X86_EFLAGS_ZF);
+			match = match || (flags & X86_EFLAGS_ZF);
 	}
 
-	if ((match && !invert) || (!match && invert))
+	return (match && !invert) || (!match && invert);
+}
+
+static __always_inline
+void int3_emulate_jcc(struct pt_regs *regs, u8 cc, unsigned long ip, unsigned long disp)
+{
+	if (__emulate_cc(regs->flags, cc))
 		ip += disp;
 
 	int3_emulate_jmp(regs, ip);
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 2673cd5c46cb..0e971222c1f4 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -26,6 +26,7 @@
 #include <asm/debugreg.h>
 #include <asm/nospec-branch.h>
 #include <asm/ibt.h>
+#include <asm/text-patching.h>
 
 #include "x86.h"
 #include "tss.h"
@@ -416,31 +417,6 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
 	ON64(FOP3E(op##q, rax, rdx, cl)) \
 	FOP_END
 
-/* Special case for SETcc - 1 instruction per cc */
-#define FOP_SETCC(op) \
-	FOP_FUNC(op) \
-	#op " %al \n\t" \
-	FOP_RET(op)
-
-FOP_START(setcc)
-FOP_SETCC(seto)
-FOP_SETCC(setno)
-FOP_SETCC(setc)
-FOP_SETCC(setnc)
-FOP_SETCC(setz)
-FOP_SETCC(setnz)
-FOP_SETCC(setbe)
-FOP_SETCC(setnbe)
-FOP_SETCC(sets)
-FOP_SETCC(setns)
-FOP_SETCC(setp)
-FOP_SETCC(setnp)
-FOP_SETCC(setl)
-FOP_SETCC(setnl)
-FOP_SETCC(setle)
-FOP_SETCC(setnle)
-FOP_END;
-
 FOP_START(salc)
 FOP_FUNC(salc)
 "pushf; sbb %al, %al; popf \n\t"
@@ -1063,13 +1039,7 @@ static int em_bsr_c(struct x86_emulate_ctxt *ctxt)
 
 static __always_inline u8 test_cc(unsigned int condition, unsigned long flags)
 {
-	u8 rc;
-	void (*fop)(void) = (void *)em_setcc + FASTOP_SIZE * (condition & 0xf);
-
-	flags = (flags & EFLAGS_MASK) | X86_EFLAGS_IF;
-	asm("push %[flags]; popf; " CALL_NOSPEC
-	    : "=a"(rc) : [thunk_target]"r"(fop), [flags]"r"(flags));
-	return rc;
+	return __emulate_cc(flags, condition & 0xf);
 }
 
 static void fetch_register_operand(struct operand *op)
