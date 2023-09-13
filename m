Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D3979EB3F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239768AbjIMOi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjIMOiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:38:55 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6267590
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:38:51 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 69ADA40E01A2;
        Wed, 13 Sep 2023 14:38:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kTyWt9XyEujB; Wed, 13 Sep 2023 14:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1694615926; bh=vAqL8hEhH8kSl1M7fzgcduN9XS62Fh9Otkx5INygC2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C82SBklNvK0ILazsqeKCy8N3loyhztlIwb5gMSdXzCBu2c2My8L6TyYBbwSQ1bJmW
         6dzm2J61Q9eF5z6fKvgHB8zrknJXMpdmcvb6GEjbYsfce+giStOZnE7ulnIxTPKYqu
         GPS0/6pbDr6hQITAXD01mGGRZlPDs3aRPn9VpTOrR52RlbrM5a5lxEg/IXdruMorKL
         /eMeVpFSgr7xlfv05LdKMTDuFGlHqiQhnItCXM2pgIL4RFREwI0b2vS3x3YagAzZ30
         2wPOQfIU/7SOtQMIydMtSVNKOzq8uESdRsTZgRlqZswIPB/sRlY+MkwnlCU+caVcWi
         hZFIlCmjm0qvz5hke7W41pryjbiH/xsDpY8MFC2rcbmBwA/13/hzvJrwL47NoFImQj
         oiZ5m4vaDg+ft0Kx2c3TAo51VJxeJUSdRAWqtdKBkrB8aijasT3G6mLKV3e0zDQ6Ur
         J5TKmBg1IS8MbZ3qJKYrUyQP5WCQd8Y/DETN5D4uiqvdrweY7NkbHb+La0xh3xKtYw
         5CbfFaFFreuzdbFCWUVXCI1KGSmUphXAER6dC3an/XJr/6lH6yBncrCWeSMmobRyZp
         K3ICGL6YsygYZVjTIym8pR2uR4tVkYBqpKkviplKNkUYs8mFIZFDQENRSg7/9gyawY
         5AmB1p3O+nK9jrn/Utfn76QY=
Received: from nazgul.tnic (unknown [93.123.97.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B7E9F40E0198;
        Wed, 13 Sep 2023 14:38:37 +0000 (UTC)
Date:   Wed, 13 Sep 2023 16:38:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org, nik.borisov@suse.com
Subject: Re: [PATCH v2 10/11] x86/alternatives: Simplify ALTERNATIVE_n()
Message-ID: <20230913143847.GBZQHJd24PX0l0gLG+@fat_crate.local>
References: <20230907110917.GA10955@noisy.programming.kicks-ass.net>
 <20230907150632.GAZPnm+Ly+Vyt8VPYr@fat_crate.local>
 <20230907153036.GBZPnsnNreLCyGpJFn@fat_crate.local>
 <20230909075009.GAZPwjsYZ4sSALN/5+@fat_crate.local>
 <20230909092554.GC2771@noisy.programming.kicks-ass.net>
 <20230910144227.GAZP3V0/mQ73C2hx/l@fat_crate.local>
 <20230912092709.GE35261@noisy.programming.kicks-ass.net>
 <20230912094441.GA13926@noisy.programming.kicks-ass.net>
 <20230913043738.GCZQE8kuw8p3WsnCXd@fat_crate.local>
 <20230913084658.GA692@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230913084658.GA692@noisy.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 10:46:58AM +0200, Peter Zijlstra wrote:
> We've gone over this multiple times already, also see commit
> 6c480f222128. That made sure the kernel side adhered to this scheme by
> making the tail a single instruction irrespective of the length.

Yes, sorry about that. I've been putting off digging deep into objtool
internals for a while now and there are no more excuses so lemme finally
read that whole thing and what it does in detail. And thanks for
explaining again. :-\

As to the patch at hand, how does the below look like?

Thx.

---

From: Peter Zijlstra <peterz@infradead.org>
Date: Mon, 14 Aug 2023 13:44:36 +0200
Subject: [PATCH] x86/alternatives: Simplify ALTERNATIVE_n()

Instead of making increasingly complicated ALTERNATIVE_n()
implementations, use a nested alternative expression.

The only difference between:

  ALTERNATIVE_2(oldinst, newinst1, flag1, newinst2, flag2)

and

  ALTERNATIVE(ALTERNATIVE(oldinst, newinst1, flag1),
              newinst2, flag2)

is that the outer alternative can add additional padding - padding which
is needed when newinst2 is longer than oldinst and newinst1 combined
- which then results in alt_instr::instrlen being inconsistent.

However, this is easily remedied since the alt_instr entries will be
consecutive and it is trivial to compute the max(alt_instr::instrlen)
at runtime while patching.

The correct max length of all the alternative insn variants is needed
for ORC unwinding CFI tracking data to be correct. For details, see

  6c480f222128 ("x86/alternative: Rewrite optimize_nops() some")

  [ bp: Make labels unique and thus all sizing use unambiguous labels.
    Add more info. ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lkml.kernel.org/r/20230628104952.GA2439977@hirez.programming.kicks-ass.net
---
 arch/x86/include/asm/alternative.h | 226 ++++++++++-------------------
 arch/x86/kernel/alternative.c      |  18 ++-
 arch/x86/kernel/fpu/xstate.h       |   6 +-
 tools/objtool/arch/x86/special.c   |  23 +++
 tools/objtool/special.c            |  16 +-
 5 files changed, 125 insertions(+), 164 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 9c4da699e11a..bcdce6026301 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -150,102 +150,70 @@ static inline int alternatives_text_reserved(void *start, void *end)
 }
 #endif	/* CONFIG_SMP */
 
-#define b_replacement(num)	"664"#num
-#define e_replacement(num)	"665"#num
+#define alt_slen		"662b-6610b"
+#define alt_total_slen		"663b-6610b"
+#define alt_rlen		"665f-664f"
 
-#define alt_end_marker		"663"
-#define alt_slen		"662b-661b"
-#define alt_total_slen		alt_end_marker"b-661b"
-#define alt_rlen(num)		e_replacement(num)"f-"b_replacement(num)"f"
-
-#define OLDINSTR(oldinstr, num)						\
-	"# ALT: oldnstr\n"						\
-	"661:\n\t" oldinstr "\n662:\n"					\
+#define OLDINSTR(oldinstr, n)						\
+	"# ALT: oldinstr\n"						\
+	"661" #n ":\n\t" oldinstr "\n662:\n"					\
 	"# ALT: padding\n"						\
-	".skip -(((" alt_rlen(num) ")-(" alt_slen ")) > 0) * "		\
-		"((" alt_rlen(num) ")-(" alt_slen ")),0x90\n"		\
-	alt_end_marker ":\n"
+	".skip -(((" alt_rlen ")-(" alt_slen ")) > 0) * "		\
+		"((" alt_rlen ")-(" alt_slen ")),0x90\n"		\
+	"663:\n"
+
+#define ALTINSTR_ENTRY(ft_flags)					      \
+	".pushsection .altinstructions,\"a\"\n"				      \
+	" .long 6610b - .\n"				/* label           */ \
+	" .long 664f - .\n"				/* new instruction */ \
+	" .4byte " __stringify(ft_flags) "\n"		/* feature + flags */ \
+	" .byte " alt_total_slen "\n"			/* source len      */ \
+	" .byte " alt_rlen "\n"				/* replacement len */ \
+	".popsection\n"
 
-/*
- * gas compatible max based on the idea from:
- * http://graphics.stanford.edu/~seander/bithacks.html#IntegerMinOrMax
- *
- * The additional "-" is needed because gas uses a "true" value of -1.
- */
-#define alt_max_short(a, b)	"((" a ") ^ (((" a ") ^ (" b ")) & -(-((" a ") < (" b ")))))"
+#define ALTINSTR_REPLACEMENT(newinstr)			/* replacement */	\
+	".pushsection .altinstr_replacement, \"ax\"\n"				\
+	"# ALT: replacement \n"							\
+	"664:\n\t" newinstr "\n 665:\n"						\
+	".popsection\n"
 
 /*
- * Pad the second replacement alternative with additional NOPs if it is
- * additionally longer than the first replacement alternative.
+ * Define an alternative between two instructions. If @ft_flags is
+ * present, early code in apply_alternatives() replaces @oldinstr with
+ * @newinstr. ".skip" directive takes care of proper instruction padding
+ * in case @newinstr is longer than @oldinstr.
+ *
+ * Notably: @oldinstr may be an ALTERNATIVE() itself, also see
+ *          apply_alternatives()
+ *
+ * @n: nesting level. Because those macros can be nested, in order to
+ * compute the source length and the total source length including the
+ * padding, the nesting level is used to define unique labels. The
+ * nesting level increases from the innermost macro invocation outwards,
+ * starting with 0. Thus, the correct starting label of oldinstr is
+ * 6610 which is hardcoded in the macros above.
  */
-#define OLDINSTR_2(oldinstr, num1, num2) \
-	"# ALT: oldinstr2\n"									\
-	"661:\n\t" oldinstr "\n662:\n"								\
-	"# ALT: padding2\n"									\
-	".skip -((" alt_max_short(alt_rlen(num1), alt_rlen(num2)) " - (" alt_slen ")) > 0) * "	\
-		"(" alt_max_short(alt_rlen(num1), alt_rlen(num2)) " - (" alt_slen ")), 0x90\n"	\
-	alt_end_marker ":\n"
-
-#define OLDINSTR_3(oldinsn, n1, n2, n3)								\
-	"# ALT: oldinstr3\n"									\
-	"661:\n\t" oldinsn "\n662:\n"								\
-	"# ALT: padding3\n"									\
-	".skip -((" alt_max_short(alt_max_short(alt_rlen(n1), alt_rlen(n2)), alt_rlen(n3))	\
-		" - (" alt_slen ")) > 0) * "							\
-		"(" alt_max_short(alt_max_short(alt_rlen(n1), alt_rlen(n2)), alt_rlen(n3))	\
-		" - (" alt_slen ")), 0x90\n"							\
-	alt_end_marker ":\n"
-
-#define ALTINSTR_ENTRY(ft_flags, num)					      \
-	" .long 661b - .\n"				/* label           */ \
-	" .long " b_replacement(num)"f - .\n"		/* new instruction */ \
-	" .4byte " __stringify(ft_flags) "\n"		/* feature + flags */ \
-	" .byte " alt_total_slen "\n"			/* source len      */ \
-	" .byte " alt_rlen(num) "\n"			/* replacement len */
+#define __ALTERNATIVE(oldinstr, newinstr, ft_flags, n)			\
+	OLDINSTR(oldinstr, n)						\
+	ALTINSTR_ENTRY(ft_flags)					\
+	ALTINSTR_REPLACEMENT(newinstr)
 
-#define ALTINSTR_REPLACEMENT(newinstr, num)		/* replacement */	\
-	"# ALT: replacement " #num "\n"						\
-	b_replacement(num)":\n\t" newinstr "\n" e_replacement(num) ":\n"
-
-/* alternative assembly primitive: */
 #define ALTERNATIVE(oldinstr, newinstr, ft_flags)			\
-	OLDINSTR(oldinstr, 1)						\
-	".pushsection .altinstructions,\"a\"\n"				\
-	ALTINSTR_ENTRY(ft_flags, 1)					\
-	".popsection\n"							\
-	".pushsection .altinstr_replacement, \"ax\"\n"			\
-	ALTINSTR_REPLACEMENT(newinstr, 1)				\
-	".popsection\n"
+	__ALTERNATIVE(oldinstr, newinstr, ft_flags, 0)
 
-#define ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) \
-	OLDINSTR_2(oldinstr, 1, 2)					\
-	".pushsection .altinstructions,\"a\"\n"				\
-	ALTINSTR_ENTRY(ft_flags1, 1)					\
-	ALTINSTR_ENTRY(ft_flags2, 2)					\
-	".popsection\n"							\
-	".pushsection .altinstr_replacement, \"ax\"\n"			\
-	ALTINSTR_REPLACEMENT(newinstr1, 1)				\
-	ALTINSTR_REPLACEMENT(newinstr2, 2)				\
-	".popsection\n"
+#define ALTERNATIVE_2(oldinst, newinst1, flag1, newinst2, flag2)	\
+	__ALTERNATIVE(ALTERNATIVE(oldinst, newinst1, flag1),		\
+		    newinst2, flag2, 1)
 
 /* If @feature is set, patch in @newinstr_yes, otherwise @newinstr_no. */
 #define ALTERNATIVE_TERNARY(oldinstr, ft_flags, newinstr_yes, newinstr_no) \
 	ALTERNATIVE_2(oldinstr, newinstr_no, X86_FEATURE_ALWAYS,	\
 		      newinstr_yes, ft_flags)
 
-#define ALTERNATIVE_3(oldinsn, newinsn1, ft_flags1, newinsn2, ft_flags2, \
-			newinsn3, ft_flags3)				\
-	OLDINSTR_3(oldinsn, 1, 2, 3)					\
-	".pushsection .altinstructions,\"a\"\n"				\
-	ALTINSTR_ENTRY(ft_flags1, 1)					\
-	ALTINSTR_ENTRY(ft_flags2, 2)					\
-	ALTINSTR_ENTRY(ft_flags3, 3)					\
-	".popsection\n"							\
-	".pushsection .altinstr_replacement, \"ax\"\n"			\
-	ALTINSTR_REPLACEMENT(newinsn1, 1)				\
-	ALTINSTR_REPLACEMENT(newinsn2, 2)				\
-	ALTINSTR_REPLACEMENT(newinsn3, 3)				\
-	".popsection\n"
+#define ALTERNATIVE_3(oldinst, newinst1, flag1, newinst2, flag2,	\
+		      newinst3, flag3)					\
+	__ALTERNATIVE(ALTERNATIVE_2(oldinst, newinst1, flag1, newinst2, flag2), \
+		    newinst3, flag3, 2)
 
 /*
  * Alternative instructions for different CPU types or capabilities.
@@ -370,6 +338,25 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	.byte \alt_len
 .endm
 
+/*
+ * Make sure the innermost macro invocation passes in as label "1400"
+ * as it is used for @oldinst sizing further down here.
+ */
+#define __ALTERNATIVE(oldinst, newinst, flag, label)			\
+label:									\
+	oldinst	;							\
+141:									\
+	.skip -(((144f-143f)-(141b-1400b)) > 0) * ((144f-143f)-(141b-1400b)),0x90	;\
+142:									\
+	.pushsection .altinstructions,"a" ;				\
+	altinstr_entry 1400b,143f,flag,142b-1400b,144f-143f ;		\
+	.popsection ;							\
+	.pushsection .altinstr_replacement,"ax"	;			\
+143:									\
+	newinst	;							\
+144:									\
+	.popsection ;
+
 /*
  * Define an alternative between two instructions. If @feature is
  * present, early code in apply_alternatives() replaces @oldinstr with
@@ -377,88 +364,23 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * in case @newinstr is longer than @oldinstr.
  */
 .macro ALTERNATIVE oldinstr, newinstr, ft_flags
-140:
-	\oldinstr
-141:
-	.skip -(((144f-143f)-(141b-140b)) > 0) * ((144f-143f)-(141b-140b)),0x90
-142:
-
-	.pushsection .altinstructions,"a"
-	altinstr_entry 140b,143f,\ft_flags,142b-140b,144f-143f
-	.popsection
-
-	.pushsection .altinstr_replacement,"ax"
-143:
-	\newinstr
-144:
-	.popsection
+	__ALTERNATIVE(\oldinstr, \newinstr, \ft_flags, 1400)
 .endm
 
-#define old_len			141b-140b
-#define new_len1		144f-143f
-#define new_len2		145f-144f
-#define new_len3		146f-145f
-
-/*
- * gas compatible max based on the idea from:
- * http://graphics.stanford.edu/~seander/bithacks.html#IntegerMinOrMax
- *
- * The additional "-" is needed because gas uses a "true" value of -1.
- */
-#define alt_max_2(a, b)		((a) ^ (((a) ^ (b)) & -(-((a) < (b)))))
-#define alt_max_3(a, b, c)	(alt_max_2(alt_max_2(a, b), c))
-
-
 /*
  * Same as ALTERNATIVE macro above but for two alternatives. If CPU
  * has @feature1, it replaces @oldinstr with @newinstr1. If CPU has
  * @feature2, it replaces @oldinstr with @feature2.
  */
 .macro ALTERNATIVE_2 oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2
-140:
-	\oldinstr
-141:
-	.skip -((alt_max_2(new_len1, new_len2) - (old_len)) > 0) * \
-		(alt_max_2(new_len1, new_len2) - (old_len)),0x90
-142:
-
-	.pushsection .altinstructions,"a"
-	altinstr_entry 140b,143f,\ft_flags1,142b-140b,144f-143f
-	altinstr_entry 140b,144f,\ft_flags2,142b-140b,145f-144f
-	.popsection
-
-	.pushsection .altinstr_replacement,"ax"
-143:
-	\newinstr1
-144:
-	\newinstr2
-145:
-	.popsection
+	__ALTERNATIVE(__ALTERNATIVE(\oldinstr, \newinstr1, \ft_flags1, 1400),
+		      \newinstr2, \ft_flags2, 1401)
 .endm
 
 .macro ALTERNATIVE_3 oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2, newinstr3, ft_flags3
-140:
-	\oldinstr
-141:
-	.skip -((alt_max_3(new_len1, new_len2, new_len3) - (old_len)) > 0) * \
-		(alt_max_3(new_len1, new_len2, new_len3) - (old_len)),0x90
-142:
-
-	.pushsection .altinstructions,"a"
-	altinstr_entry 140b,143f,\ft_flags1,142b-140b,144f-143f
-	altinstr_entry 140b,144f,\ft_flags2,142b-140b,145f-144f
-	altinstr_entry 140b,145f,\ft_flags3,142b-140b,146f-145f
-	.popsection
-
-	.pushsection .altinstr_replacement,"ax"
-143:
-	\newinstr1
-144:
-	\newinstr2
-145:
-	\newinstr3
-146:
-	.popsection
+	__ALTERNATIVE(__ALTERNATIVE(__ALTERNATIVE(\oldinstr, \newinstr1, \ft_flags1, 1400),
+				    \newinstr2, \ft_flags2, 1401),
+		      \newinstr3, \ft_flags3, 1402)
 .endm
 
 /* If @feature is set, patch in @newinstr_yes, otherwise @newinstr_no. */
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index a5ead6a6d233..bcbef8ce9d94 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -398,7 +398,7 @@ apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *src, size_t src_len)
 void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 						  struct alt_instr *end)
 {
-	struct alt_instr *a;
+	struct alt_instr *a, *b;
 	u8 *instr, *replacement;
 	u8 insn_buff[MAX_PATCH_LEN];
 
@@ -415,6 +415,22 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 	for (a = start; a < end; a++) {
 		int insn_buff_sz = 0;
 
+		/*
+		 * In case of nested ALTERNATIVE()s the outer alternative might
+		 * add more padding. To ensure consistent patching find the max
+		 * padding for all alt_instr entries for this site (nested
+		 * alternatives result in consecutive entries).
+		 *
+		 * Patching works even without it but ORC unwinder CFI tracking
+		 * turns the last trailing NOP into a max size instruction
+		 * so that edge data can be kept at a minimum, see
+		 * comment over add_nop().
+		 */
+		for (b = a+1; b < end && b->instr_offset == a->instr_offset; b++) {
+			u8 len = max(a->instrlen, b->instrlen);
+			a->instrlen = b->instrlen = len;
+		}
+
 		instr = (u8 *)&a->instr_offset + a->instr_offset;
 		replacement = (u8 *)&a->repl_offset + a->repl_offset;
 		BUG_ON(a->instrlen > sizeof(insn_buff));
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
index 29e949579ede..7145920a7aba 100644
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -9,6 +9,29 @@
 
 void arch_handle_alternative(unsigned short feature, struct special_alt *alt)
 {
+	static struct special_alt *group, *prev;
+
+	/*
+	 * Recompute orig_len for nested ALTERNATIVE()s.
+	 */
+	if (group && group->orig_sec == alt->orig_sec &&
+	             group->orig_off == alt->orig_off) {
+
+		struct special_alt *iter = group;
+		for (;;) {
+			unsigned int len = max(iter->orig_len, alt->orig_len);
+			iter->orig_len = alt->orig_len = len;
+
+			if (iter == prev)
+				break;
+
+			iter = list_next_entry(iter, list);
+		}
+
+	} else group = alt;
+
+	prev = alt;
+
 	switch (feature) {
 	case X86_FEATURE_SMAP:
 		/*
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index 91b1950f5bd8..097a69db82a0 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -84,6 +84,14 @@ static int get_alt_entry(struct elf *elf, const struct special_entry *entry,
 						  entry->new_len);
 	}
 
+	orig_reloc = find_reloc_by_dest(elf, sec, offset + entry->orig);
+	if (!orig_reloc) {
+		WARN_FUNC("can't find orig reloc", sec, offset + entry->orig);
+		return -1;
+	}
+
+	reloc_to_sec_off(orig_reloc, &alt->orig_sec, &alt->orig_off);
+
 	if (entry->feature) {
 		unsigned short feature;
 
@@ -94,14 +102,6 @@ static int get_alt_entry(struct elf *elf, const struct special_entry *entry,
 		arch_handle_alternative(feature, alt);
 	}
 
-	orig_reloc = find_reloc_by_dest(elf, sec, offset + entry->orig);
-	if (!orig_reloc) {
-		WARN_FUNC("can't find orig reloc", sec, offset + entry->orig);
-		return -1;
-	}
-
-	reloc_to_sec_off(orig_reloc, &alt->orig_sec, &alt->orig_off);
-
 	if (!entry->group || alt->new_len) {
 		new_reloc = find_reloc_by_dest(elf, sec, offset + entry->new);
 		if (!new_reloc) {
-- 
2.23.0


---

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
