Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811137996C9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 10:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245576AbjIIHu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 03:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240787AbjIIHuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 03:50:24 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B48199F
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 00:50:18 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 890A440E01A4;
        Sat,  9 Sep 2023 07:50:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Z0WcWp5YR-Po; Sat,  9 Sep 2023 07:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1694245813; bh=K5bKpZUUilwegaoHGc+ZiJfKDnoo+m0wf2qVizMpnqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=de02Xm1/isfviUtXETHuqTMpuSnQrZVlqIo5ucLKsbEukmS/c1Z/mBpLU4bRtM9AX
         SLRQVow7Yq0lPh/xuyhE9F7W7o9W7xtjPYLT6vwbgXwwQKuCYodT8JYB+QCvjXJB5u
         v88pyWzAU3OfX/PYJWq1OtllCB//ige2wVznve4iRW7iFy4DQJwlwpSlN29wVhaJpC
         Ga+e68VkhXR+wUHbXzjKLpZzk5RVzCf1LRr4HQWyfLx5AvWIFjy2yOH5cvfh4Vrj17
         EN626NGpP+xn7RTTW6DFU0WslVMfGFzpASoeJCcR4MFEct6Ibewb4l02DNDkZaA6rT
         ktftFO+LY9802TV4KqS2+z1xDzxPmcky3JnO9K2efx2oJGYcgu+XI65eoxFG3y1QHP
         v+koR8c2pYl14AhbUOJCWwKcIv7R8r5QA+CdFsMRJ//sgm1/GxSVaajLzhjjdV52lJ
         ch5xkWN74nDCIHKzNYnVNUP6Rd2dEgElwxfz0evyl+2TbybdsvCQJu5rOeosvhly5c
         mlXPkae5Te6VrxWrMi3zcegvpbUaS2QBOT5v/8FU3VGNisBZCGSL4i6smaNErxCu5e
         DQ1PlHB7RN/EzN7R5ScGXmRZYDn4i7FbfVl7oHlxdIAPZYe1WW6jHoZ65fVSJTePYV
         5erdyDCjO198IoZbJ1x85pQI=
Received: from nazgul.tnic (unknown [93.123.97.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BEC1A40E0140;
        Sat,  9 Sep 2023 07:50:04 +0000 (UTC)
Date:   Sat, 9 Sep 2023 09:50:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org, nik.borisov@suse.com
Subject: Re: [PATCH v2 10/11] x86/alternatives: Simplify ALTERNATIVE_n()
Message-ID: <20230909075009.GAZPwjsYZ4sSALN/5+@fat_crate.local>
References: <20230814114426.057251214@infradead.org>
 <20230814121149.176244760@infradead.org>
 <20230907083158.GBZPmKfjarnaQk1ofB@fat_crate.local>
 <20230907110917.GA10955@noisy.programming.kicks-ass.net>
 <20230907150632.GAZPnm+Ly+Vyt8VPYr@fat_crate.local>
 <20230907153036.GBZPnsnNreLCyGpJFn@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230907153036.GBZPnsnNreLCyGpJFn@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 05:30:36PM +0200, Borislav Petkov wrote:
> But I might be missing something so lemme poke at it more.

So my guest boots with the below diff ontop of yours. That doesn't mean
a whole lot but it looks like it DTRT. (Btw, the DPRINTK hunk is hoisted
up only for debugging - not part of the change).

And I've backed out your handling of the additional padding because, as
we've established, that's not really additional padding but the padding
which is missing when a subsequent sequence is longer.

It all ends up being a single consecutive region of padding as it should
be.

Building that says:

arch/x86/entry/entry_64.o: warning: objtool: entry_SYSCALL_64+0x91: weirdly overlapping alternative! 5 != 16
arch/x86/entry/entry_64_compat.o: warning: objtool: entry_SYSENTER_compat+0x80: weirdly overlapping alternative! 5 != 16

but that warning is bogus because the code in question is the
UNTRAIN_RET macro which has an empty orig insn, then two CALLs of size
5 and then the RESET_CALL_DEPTH sequence which is 16 bytes.

At build time it looks like this:

ffffffff81c000d1:       90                      nop
ffffffff81c000d2:       90                      nop
ffffffff81c000d3:       90                      nop
ffffffff81c000d4:       90                      nop
ffffffff81c000d5:       90                      nop
ffffffff81c000d6:       90                      nop
ffffffff81c000d7:       90                      nop
ffffffff81c000d8:       90                      nop
ffffffff81c000d9:       90                      nop
ffffffff81c000da:       90                      nop
ffffffff81c000db:       90                      nop
ffffffff81c000dc:       90                      nop
ffffffff81c000dd:       90                      nop
ffffffff81c000de:       90                      nop
ffffffff81c000df:       90                      nop
ffffffff81c000e0:       90                      nop

and those are 16 contiguous NOPs of padding.

At boot time, it does:

[    0.679523] SMP alternatives: feat: 11*32+15, old: (entry_SYSCALL_64_after_hwframe+0x59/0xd8 (ffffffff81c000d1) len: 5), repl: (ffffffff833a362b, len: 5)
[    0.683516] SMP alternatives: ffffffff81c000d1: [0:5) optimized NOPs: 0f 1f 44 00 00

That first one is X86_FEATURE_UNRET and the alt_instr descriptor simply
says that the replacement is 5 bytes long, which is the CALL that can
potentially be poked in. It doesn't care about the following 11 bytes of
padding because it doesn't matter - it wants 5 bytes only for the CALL.

[    0.687514] SMP alternatives: feat: 11*32+10, old: (entry_SYSCALL_64_after_hwframe+0x59/0xd8 (ffffffff81c000d1) len: 5), repl: (ffffffff833a3630, len: 5)
[    0.691521] SMP alternatives: ffffffff81c000d1: [0:5) optimized NOPs: 0f 1f 44 00 00

This is X86_FEATURE_ENTRY_IBPB. Same thing.

[    0.695515] SMP alternatives: feat: 11*32+19, old: (entry_SYSCALL_64_after_hwframe+0x59/0xd8 (ffffffff81c000d1) len: 16), repl: (ffffffff833a3635, len: 16)
[    0.699516] SMP alternatives: ffffffff81c000d1: [0:16) optimized NOPs: eb 0e cc cc cc cc cc cc cc cc cc cc cc cc cc cc

And this is X86_FEATURE_CALL_DEPTH and here the alt_instr descriptor has
replacement length of 16 and that is all still ok as it starts at the
same address and contains the first 5 bytes from the previous entries
which overlap here.

So address-wise we're good, the alt_instr patching descriptors are
correct and we should be good.

Thoughts?

---

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index df128ff49d60..de612307ed1e 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -150,13 +150,13 @@ static inline int alternatives_text_reserved(void *start, void *end)
 }
 #endif	/* CONFIG_SMP */
 
-#define alt_slen		"662b-661b"
-#define alt_total_slen		"663b-661b"
+#define alt_slen		"662b-6610b"
+#define alt_total_slen		"663b-6610b"
 #define alt_rlen		"665f-664f"
 
-#define OLDINSTR(oldinstr)						\
-	"# ALT: oldnstr\n"						\
-	"661:\n\t" oldinstr "\n662:\n"					\
+#define OLDINSTR(oldinstr, n)						\
+	"# ALT: oldinstr\n"						\
+	"661" #n ":\n\t" oldinstr "\n662:\n"					\
 	"# ALT: padding\n"						\
 	".skip -(((" alt_rlen ")-(" alt_slen ")) > 0) * "		\
 		"((" alt_rlen ")-(" alt_slen ")),0x90\n"		\
@@ -164,7 +164,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 
 #define ALTINSTR_ENTRY(ft_flags)					      \
 	".pushsection .altinstructions,\"a\"\n"				      \
-	" .long 661b - .\n"				/* label           */ \
+	" .long 6610b - .\n"				/* label           */ \
 	" .long 664f - .\n"				/* new instruction */ \
 	" .4byte " __stringify(ft_flags) "\n"		/* feature + flags */ \
 	" .byte " alt_total_slen "\n"			/* source len      */ \
@@ -185,15 +185,25 @@ static inline int alternatives_text_reserved(void *start, void *end)
  *
  * Notably: @oldinstr may be an ALTERNATIVE() itself, also see
  *          apply_alternatives()
+ *
+ * @n: nesting level. Because those macros are nested, in order to
+ * compute the source length and the total source length including the
+ * padding, the nesting level is used to define unique labels. The
+ * nesting level increases from the innermost macro invocation outwards,
+ * starting with 0. Thus, the correct starting label of oldinstr is
+ * 6610 which is hardcoded in the macros above.
  */
-#define ALTERNATIVE(oldinstr, newinstr, ft_flags)			\
-	OLDINSTR(oldinstr)						\
+#define __ALTERNATIVE(oldinstr, newinstr, ft_flags, n)			\
+	OLDINSTR(oldinstr, n)						\
 	ALTINSTR_ENTRY(ft_flags)					\
 	ALTINSTR_REPLACEMENT(newinstr)
 
+#define ALTERNATIVE(oldinstr, newinstr, ft_flags)			\
+	__ALTERNATIVE(oldinstr, newinstr, ft_flags, 0)
+
 #define ALTERNATIVE_2(oldinst, newinst1, flag1, newinst2, flag2)	\
-	ALTERNATIVE(ALTERNATIVE(oldinst, newinst1, flag1),		\
-		    newinst2, flag2)
+	__ALTERNATIVE(ALTERNATIVE(oldinst, newinst1, flag1),		\
+		    newinst2, flag2, 1)
 
 /* If @feature is set, patch in @newinstr_yes, otherwise @newinstr_no. */
 #define ALTERNATIVE_TERNARY(oldinstr, ft_flags, newinstr_yes, newinstr_no) \
@@ -202,8 +212,8 @@ static inline int alternatives_text_reserved(void *start, void *end)
 
 #define ALTERNATIVE_3(oldinst, newinst1, flag1, newinst2, flag2,	\
 		      newinst3, flag3)					\
-	ALTERNATIVE(ALTERNATIVE_2(oldinst, newinst1, flag1, newinst2, flag2), \
-		    newinst3, flag3)
+	__ALTERNATIVE(ALTERNATIVE_2(oldinst, newinst1, flag1, newinst2, flag2), \
+		    newinst3, flag3, 2)
 
 /*
  * Alternative instructions for different CPU types or capabilities.
@@ -328,14 +338,18 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	.byte \alt_len
 .endm
 
-#define __ALTERNATIVE(oldinst, newinst, flag)				\
-140:									\
+/*
+ * Make sure the innermost macro invocation passes in as label "1400"
+ * as it is used for @oldinst sizing further down here.
+ */
+#define __ALTERNATIVE(oldinst, newinst, flag, label)			\
+label:									\
 	oldinst	;							\
 141:									\
-	.skip -(((144f-143f)-(141b-140b)) > 0) * ((144f-143f)-(141b-140b)),0x90	;\
+	.skip -(((144f-143f)-(141b-1400b)) > 0) * ((144f-143f)-(141b-1400b)),0x90	;\
 142:									\
 	.pushsection .altinstructions,"a" ;				\
-	altinstr_entry 140b,143f,flag,142b-140b,144f-143f ;		\
+	altinstr_entry 1400b,143f,flag,142b-1400b,144f-143f ;		\
 	.popsection ;							\
 	.pushsection .altinstr_replacement,"ax"	;			\
 143:									\
@@ -350,7 +364,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * in case @newinstr is longer than @oldinstr.
  */
 .macro ALTERNATIVE oldinstr, newinstr, ft_flags
-	__ALTERNATIVE(\oldinstr, \newinstr, \ft_flags)
+	__ALTERNATIVE(\oldinstr, \newinstr, \ft_flags, 1400)
 .endm
 
 /*
@@ -359,14 +373,14 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * @feature2, it replaces @oldinstr with @feature2.
  */
 .macro ALTERNATIVE_2 oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2
-	__ALTERNATIVE(__ALTERNATIVE(\oldinstr, \newinstr1, \ft_flags1),
-		      \newinstr2, \ft_flags2)
+	__ALTERNATIVE(__ALTERNATIVE(\oldinstr, \newinstr1, \ft_flags1, 1400),
+		      \newinstr2, \ft_flags2, 1401)
 .endm
 
 .macro ALTERNATIVE_3 oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2, newinstr3, ft_flags3
-	__ALTERNATIVE(__ALTERNATIVE(__ALTERNATIVE(\oldinstr, \newinstr1, \ft_flags1),
-				    \newinstr2, \ft_flags2),
-		      \newinstr3, \ft_flags3)
+	__ALTERNATIVE(__ALTERNATIVE(__ALTERNATIVE(\oldinstr, \newinstr1, \ft_flags1, 1400),
+				    \newinstr2, \ft_flags2, 1401),
+		      \newinstr3, \ft_flags3, 1402)
 .endm
 
 /* If @feature is set, patch in @newinstr_yes, otherwise @newinstr_no. */
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index fa9eb5f1ff1e..aa0ea0317127 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -398,7 +398,7 @@ apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *src, size_t src_len)
 void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 						  struct alt_instr *end)
 {
-	struct alt_instr *a, *b;
+	struct alt_instr *a;
 	u8 *instr, *replacement;
 	u8 insn_buff[MAX_PATCH_LEN];
 
@@ -415,22 +415,18 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 	for (a = start; a < end; a++) {
 		int insn_buff_sz = 0;
 
-		/*
-		 * In case of nested ALTERNATIVE()s the outer alternative might
-		 * add more padding. To ensure consistent patching find the max
-		 * padding for all alt_instr entries for this site (nested
-		 * alternatives result in consecutive entries).
-		 */
-		for (b = a+1; b < end && b->instr_offset == a->instr_offset; b++) {
-			u8 len = max(a->instrlen, b->instrlen);
-			a->instrlen = b->instrlen = len;
-		}
-
 		instr = (u8 *)&a->instr_offset + a->instr_offset;
 		replacement = (u8 *)&a->repl_offset + a->repl_offset;
 		BUG_ON(a->instrlen > sizeof(insn_buff));
 		BUG_ON(a->cpuid >= (NCAPINTS + NBUGINTS) * 32);
 
+		DPRINTK(ALT, "feat: %s%d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d)",
+			(a->flags & ALT_FLAG_NOT) ? "!" : "",
+			a->cpuid >> 5,
+			a->cpuid & 0x1f,
+			instr, instr, a->instrlen,
+			replacement, a->replacementlen);
+
 		/*
 		 * Patch if either:
 		 * - feature is present
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index a4ecb04d8d64..37328ffc72bb 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -109,7 +109,7 @@ static inline u64 xfeatures_mask_independent(void)
  *
  * We use XSAVE as a fallback.
  *
- * The 661 label is defined in the ALTERNATIVE* macros as the address of the
+ * The 6610 label is defined in the ALTERNATIVE* macros as the address of the
  * original instruction which gets replaced. We need to use it here as the
  * address of the instruction where we might get an exception at.
  */
@@ -121,7 +121,7 @@ static inline u64 xfeatures_mask_independent(void)
 		     "\n"						\
 		     "xor %[err], %[err]\n"				\
 		     "3:\n"						\
-		     _ASM_EXTABLE_TYPE_REG(661b, 3b, EX_TYPE_EFAULT_REG, %[err]) \
+		     _ASM_EXTABLE_TYPE_REG(6610b, 3b, EX_TYPE_EFAULT_REG, %[err]) \
 		     : [err] "=r" (err)					\
 		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
 		     : "memory")
@@ -135,7 +135,7 @@ static inline u64 xfeatures_mask_independent(void)
 				 XRSTORS, X86_FEATURE_XSAVES)		\
 		     "\n"						\
 		     "3:\n"						\
-		     _ASM_EXTABLE_TYPE(661b, 3b, EX_TYPE_FPU_RESTORE)	\
+		     _ASM_EXTABLE_TYPE(6610b, 3b, EX_TYPE_FPU_RESTORE)	\
 		     :							\
 		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
 		     : "memory")
diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
index 7145920a7aba..29e949579ede 100644
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -9,29 +9,6 @@
 
 void arch_handle_alternative(unsigned short feature, struct special_alt *alt)
 {
-	static struct special_alt *group, *prev;
-
-	/*
-	 * Recompute orig_len for nested ALTERNATIVE()s.
-	 */
-	if (group && group->orig_sec == alt->orig_sec &&
-	             group->orig_off == alt->orig_off) {
-
-		struct special_alt *iter = group;
-		for (;;) {
-			unsigned int len = max(iter->orig_len, alt->orig_len);
-			iter->orig_len = alt->orig_len = len;
-
-			if (iter == prev)
-				break;
-
-			iter = list_next_entry(iter, list);
-		}
-
-	} else group = alt;
-
-	prev = alt;
-
 	switch (feature) {
 	case X86_FEATURE_SMAP:
 		/*

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
