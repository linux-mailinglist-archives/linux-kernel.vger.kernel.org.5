Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E8F812EC0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444044AbjLNLhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444056AbjLNLgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:36:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6AA13A;
        Thu, 14 Dec 2023 03:36:50 -0800 (PST)
Date:   Thu, 14 Dec 2023 11:36:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702553809;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KDZIpcnlZmcB+xloMffXanv/dAFImqDB9yj9wp9lYVg=;
        b=08+/c1nVs4rf5LjuNKIm5/k1ji8AIFfWwkVYi7AUqIlcX9+4bVo5xu0XzCj7phO+fjmqZG
        JzPeQMuhMKAWOM+ZjikRMMdGf09zPO7wiDemgTnTKzxBIMrxKW1l5lNGc5RIVonNDStdN+
        iVGJkp9RKQr/X7oJqtnL2cei5VBvT+EAbCDOjQiUcsvK8khQJH7tncebhH1fZtgWEmnX44
        Y26Q6Cc6iMs9G2eSHXMmDiQYlzACdRIz4WcvSVRfRasgg+vbwtyjLTLLKagcuIsriQOb5J
        oc6Kw1Ty3yRjtcaCjOKqnRFOt99td0rXGlsjV5uHxasTzI5OZNobmdJe81PQRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702553809;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KDZIpcnlZmcB+xloMffXanv/dAFImqDB9yj9wp9lYVg=;
        b=SveBvIeX76NI+hxWpUs9rQEDOFirkML5BnEdGQ8ZxjH6oxkht+zClH4MJgj7DnzedgosIW
        uz5UPdGFlx8ixABw==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/paravirt] x86/paravirt: Switch mixed paravirt/alternative
 calls to alternatives
Cc:     Juergen Gross <jgross@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231210062138.2417-5-jgross@suse.com>
References: <20231210062138.2417-5-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <170255380824.398.13981878523012297866.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     60bc276b129eef8113f9d9b0a5cd5ae7f4c90acb
Gitweb:        https://git.kernel.org/tip/60bc276b129eef8113f9d9b0a5cd5ae7f4c90acb
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Sun, 10 Dec 2023 07:21:37 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 10 Dec 2023 23:33:09 +01:00

x86/paravirt: Switch mixed paravirt/alternative calls to alternatives

Instead of stacking alternative and paravirt patching, use the new
ALT_FLAG_CALL flag to switch those mixed calls to pure alternative
handling.

Eliminate the need to be careful regarding the sequence of alternative
and paravirt patching.

  [ bp: Touch up commit message. ]

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20231210062138.2417-5-jgross@suse.com
---
 arch/x86/include/asm/alternative.h    |  5 +--
 arch/x86/include/asm/paravirt.h       | 12 ++++----
 arch/x86/include/asm/paravirt_types.h | 40 ++++++++++++++------------
 arch/x86/kernel/alternative.c         |  1 +-
 arch/x86/kernel/callthunks.c          | 17 +++++------
 arch/x86/kernel/module.c              | 20 +++----------
 6 files changed, 44 insertions(+), 51 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 472334e..fcd20c6 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -89,6 +89,8 @@ struct alt_instr {
 	u8  replacementlen;	/* length of new instruction */
 } __packed;
 
+extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
+
 /*
  * Debug flag that can be tested to see whether alternative
  * instructions were patched in already:
@@ -104,11 +106,10 @@ extern void apply_fineibt(s32 *start_retpoline, s32 *end_retpoine,
 			  s32 *start_cfi, s32 *end_cfi);
 
 struct module;
-struct paravirt_patch_site;
 
 struct callthunk_sites {
 	s32				*call_start, *call_end;
-	struct paravirt_patch_site	*pv_start, *pv_end;
+	struct alt_instr		*alt_start, *alt_end;
 };
 
 #ifdef CONFIG_CALL_THUNKS
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index f18bfa7..973c2ac 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -738,20 +738,20 @@ void native_pv_lock_init(void) __init;
 
 #ifdef CONFIG_X86_64
 #ifdef CONFIG_PARAVIRT_XXL
+#ifdef CONFIG_DEBUG_ENTRY
 
 #define PARA_PATCH(off)		((off) / 8)
 #define PARA_SITE(ptype, ops)	_PVSITE(ptype, ops)
 #define PARA_INDIRECT(addr)	*addr(%rip)
 
-#ifdef CONFIG_DEBUG_ENTRY
 .macro PARA_IRQ_save_fl
-	PARA_SITE(PARA_PATCH(PV_IRQ_save_fl),
-		  ANNOTATE_RETPOLINE_SAFE;
-		  call PARA_INDIRECT(pv_ops+PV_IRQ_save_fl);)
+	ANNOTATE_RETPOLINE_SAFE;
+	call PARA_INDIRECT(pv_ops+PV_IRQ_save_fl);
 .endm
 
-#define SAVE_FLAGS	ALTERNATIVE "PARA_IRQ_save_fl;", "pushf; pop %rax;", \
-				    ALT_NOT_XEN
+#define SAVE_FLAGS ALTERNATIVE_2 "PARA_IRQ_save_fl;",			\
+				 "ALT_CALL_INSTR;", ALT_CALL_ALWAYS,	\
+				 "pushf; pop %rax;", ALT_NOT_XEN
 #endif
 #endif /* CONFIG_PARAVIRT_XXL */
 #endif	/* CONFIG_X86_64 */
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 166e961..9cad536 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -276,15 +276,11 @@ extern struct paravirt_patch_template pv_ops;
 #define NATIVE_LABEL(a,x,b) "\n\t.globl " a #x "_" #b "\n" a #x "_" #b ":\n\t"
 
 unsigned int paravirt_patch(u8 type, void *insn_buff, unsigned long addr, unsigned int len);
+#define paravirt_ptr(op)	[paravirt_opptr] "m" (pv_ops.op)
 
 int paravirt_disable_iospace(void);
 
-/*
- * This generates an indirect call based on the operation type number.
- * The type number, computed in PARAVIRT_PATCH, is derived from the
- * offset into the paravirt_patch_template structure, and can therefore be
- * freely converted back into a structure offset.
- */
+/* This generates an indirect call based on the operation type number. */
 #define PARAVIRT_CALL					\
 	ANNOTATE_RETPOLINE_SAFE				\
 	"call *%[paravirt_opptr];"
@@ -317,12 +313,6 @@ int paravirt_disable_iospace(void);
  * However, x86_64 also has to clobber all caller saved registers, which
  * unfortunately, are quite a bit (r8 - r11)
  *
- * The call instruction itself is marked by placing its start address
- * and size into the .parainstructions section, so that
- * apply_paravirt() in arch/i386/kernel/alternative.c can do the
- * appropriate patching under the control of the backend pv_init_ops
- * implementation.
- *
  * Unfortunately there's no way to get gcc to generate the args setup
  * for the call, and then allow the call itself to be generated by an
  * inline asm.  Because of this, we must do the complete arg setup and
@@ -421,14 +411,27 @@ int paravirt_disable_iospace(void);
 		__mask & __eax;						\
 	})
 
-
+/*
+ * Use alternative patching for paravirt calls:
+ * - For replacing an indirect call with a direct one, use the "normal"
+ *   ALTERNATIVE() macro with the indirect call as the initial code sequence,
+ *   which will be replaced with the related direct call by using the
+ *   ALT_FLAG_DIRECT_CALL special case and the "always on" feature.
+ * - In case the replacement is either a direct call or a short code sequence
+ *   depending on a feature bit, the ALTERNATIVE_2() macro is being used.
+ *   The indirect call is the initial code sequence again, while the special
+ *   code sequence is selected with the specified feature bit. In case the
+ *   feature is not active, the direct call is used as above via the
+ *   ALT_FLAG_DIRECT_CALL special case and the "always on" feature.
+ */
 #define ____PVOP_CALL(ret, op, call_clbr, extra_clbr, ...)	\
 	({								\
 		PVOP_CALL_ARGS;						\
 		PVOP_TEST_NULL(op);					\
-		asm volatile(paravirt_alt(PARAVIRT_CALL)		\
+		asm volatile(ALTERNATIVE(PARAVIRT_CALL, ALT_CALL_INSTR,	\
+				ALT_CALL_ALWAYS)			\
 			     : call_clbr, ASM_CALL_CONSTRAINT		\
-			     : paravirt_type(op),			\
+			     : paravirt_ptr(op),			\
 			       ##__VA_ARGS__				\
 			     : "memory", "cc" extra_clbr);		\
 		ret;							\
@@ -439,10 +442,11 @@ int paravirt_disable_iospace(void);
 	({								\
 		PVOP_CALL_ARGS;						\
 		PVOP_TEST_NULL(op);					\
-		asm volatile(ALTERNATIVE(paravirt_alt(PARAVIRT_CALL),	\
-					 alt, cond)			\
+		asm volatile(ALTERNATIVE_2(PARAVIRT_CALL,		\
+				 ALT_CALL_INSTR, ALT_CALL_ALWAYS,	\
+				 alt, cond)				\
 			     : call_clbr, ASM_CALL_CONSTRAINT		\
-			     : paravirt_type(op),			\
+			     : paravirt_ptr(op),			\
 			       ##__VA_ARGS__				\
 			     : "memory", "cc" extra_clbr);		\
 		ret;							\
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 6573051..48938bc 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -160,7 +160,6 @@ extern s32 __retpoline_sites[], __retpoline_sites_end[];
 extern s32 __return_sites[], __return_sites_end[];
 extern s32 __cfi_sites[], __cfi_sites_end[];
 extern s32 __ibt_endbr_seal[], __ibt_endbr_seal_end[];
-extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
 extern s32 __smp_locks[], __smp_locks_end[];
 void text_poke_early(void *addr, const void *opcode, size_t len);
 
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index 57e5c2e..64ad2dd 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -233,14 +233,13 @@ patch_call_sites(s32 *start, s32 *end, const struct core_text *ct)
 }
 
 static __init_or_module void
-patch_paravirt_call_sites(struct paravirt_patch_site *start,
-			  struct paravirt_patch_site *end,
-			  const struct core_text *ct)
+patch_alt_call_sites(struct alt_instr *start, struct alt_instr *end,
+		     const struct core_text *ct)
 {
-	struct paravirt_patch_site *p;
+	struct alt_instr *a;
 
-	for (p = start; p < end; p++)
-		patch_call((void *)&p->instr_offset + p->instr_offset, ct);
+	for (a = start; a < end; a++)
+		patch_call((void *)&a->instr_offset + a->instr_offset, ct);
 }
 
 static __init_or_module void
@@ -248,7 +247,7 @@ callthunks_setup(struct callthunk_sites *cs, const struct core_text *ct)
 {
 	prdbg("Patching call sites %s\n", ct->name);
 	patch_call_sites(cs->call_start, cs->call_end, ct);
-	patch_paravirt_call_sites(cs->pv_start, cs->pv_end, ct);
+	patch_alt_call_sites(cs->alt_start, cs->alt_end, ct);
 	prdbg("Patching call sites done%s\n", ct->name);
 }
 
@@ -257,8 +256,8 @@ void __init callthunks_patch_builtin_calls(void)
 	struct callthunk_sites cs = {
 		.call_start	= __call_sites,
 		.call_end	= __call_sites_end,
-		.pv_start	= __parainstructions,
-		.pv_end		= __parainstructions_end
+		.alt_start	= __alt_instructions,
+		.alt_end	= __alt_instructions_end
 	};
 
 	if (!cpu_feature_enabled(X86_FEATURE_CALL_DEPTH))
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 5f71a0c..e18914c 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -276,7 +276,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 		    struct module *me)
 {
 	const Elf_Shdr *s, *alt = NULL, *locks = NULL,
-		*para = NULL, *orc = NULL, *orc_ip = NULL,
+		*orc = NULL, *orc_ip = NULL,
 		*retpolines = NULL, *returns = NULL, *ibt_endbr = NULL,
 		*calls = NULL, *cfi = NULL;
 	char *secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
@@ -286,8 +286,6 @@ int module_finalize(const Elf_Ehdr *hdr,
 			alt = s;
 		if (!strcmp(".smp_locks", secstrings + s->sh_name))
 			locks = s;
-		if (!strcmp(".parainstructions", secstrings + s->sh_name))
-			para = s;
 		if (!strcmp(".orc_unwind", secstrings + s->sh_name))
 			orc = s;
 		if (!strcmp(".orc_unwind_ip", secstrings + s->sh_name))
@@ -304,14 +302,6 @@ int module_finalize(const Elf_Ehdr *hdr,
 			ibt_endbr = s;
 	}
 
-	/*
-	 * See alternative_instructions() for the ordering rules between the
-	 * various patching types.
-	 */
-	if (para) {
-		void *pseg = (void *)para->sh_addr;
-		apply_paravirt(pseg, pseg + para->sh_size);
-	}
 	if (retpolines || cfi) {
 		void *rseg = NULL, *cseg = NULL;
 		unsigned int rsize = 0, csize = 0;
@@ -341,7 +331,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 		void *aseg = (void *)alt->sh_addr;
 		apply_alternatives(aseg, aseg + alt->sh_size);
 	}
-	if (calls || para) {
+	if (calls || alt) {
 		struct callthunk_sites cs = {};
 
 		if (calls) {
@@ -349,9 +339,9 @@ int module_finalize(const Elf_Ehdr *hdr,
 			cs.call_end = (void *)calls->sh_addr + calls->sh_size;
 		}
 
-		if (para) {
-			cs.pv_start = (void *)para->sh_addr;
-			cs.pv_end = (void *)para->sh_addr + para->sh_size;
+		if (alt) {
+			cs.alt_start = (void *)alt->sh_addr;
+			cs.alt_end = (void *)alt->sh_addr + alt->sh_size;
 		}
 
 		callthunks_patch_module_calls(&cs, me);
