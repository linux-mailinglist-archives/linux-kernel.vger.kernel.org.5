Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A197CA831
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 14:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbjJPMkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 08:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbjJPMkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 08:40:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F7210E
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 05:40:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CDC5721C61;
        Mon, 16 Oct 2023 12:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697459998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fqtGDlVsv+HPnyHMeZRSJdJZPMRMb6TxhtmsM5BeVXM=;
        b=GfIv9T7jwnxbbGQPz64adTpb/Gvnf+LJucYa7Q7h7JbMHJraiKus8eV1OZX/j9CAvjn4Z/
        VqrBGIHVOB10GjEP9KgVbQIvJhOBGLB4qOB2oEUiLv6RzwYQXB5CpYaN4gMyyfHjaPyoBo
        ptX09S01nXsHg/O/bViFAK5ZPn1rPxk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 80FE6133B7;
        Mon, 16 Oct 2023 12:39:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id u99MHh4vLWUzIwAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 16 Oct 2023 12:39:58 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     Juergen Gross <jgross@suse.com>, Ajay Kaher <akaher@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 4/4] x86/paravirt: remove no longer needed paravirt patching code
Date:   Mon, 16 Oct 2023 14:39:33 +0200
Message-Id: <20231016123933.17284-5-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231016123933.17284-1-jgross@suse.com>
References: <20231016123933.17284-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -0.09
X-Spamd-Result: default: False [-0.09 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-0.99)[-0.992];
         NEURAL_SPAM_LONG(3.00)[1.000];
         RCPT_COUNT_TWELVE(0.00)[12];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that paravirt is using the alternatives patching infrastructure,
remove the paravirt patching code.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/paravirt.h       | 18 --------
 arch/x86/include/asm/paravirt_types.h | 40 ----------------
 arch/x86/include/asm/text-patching.h  | 12 -----
 arch/x86/kernel/alternative.c         | 66 +--------------------------
 arch/x86/kernel/paravirt.c            | 30 ------------
 arch/x86/kernel/vmlinux.lds.S         | 13 ------
 arch/x86/tools/relocs.c               |  2 +-
 7 files changed, 3 insertions(+), 178 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 9c6c5cfa9fe2..f09acce9432c 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -725,31 +725,13 @@ void native_pv_lock_init(void) __init;
 
 #else  /* __ASSEMBLY__ */
 
-#define _PVSITE(ptype, ops, word, algn)		\
-771:;						\
-	ops;					\
-772:;						\
-	.pushsection .parainstructions,"a";	\
-	 .align	algn;				\
-	 word 771b;				\
-	 .byte ptype;				\
-	 .byte 772b-771b;			\
-	 _ASM_ALIGN;				\
-	.popsection
-
-
 #ifdef CONFIG_X86_64
 #ifdef CONFIG_PARAVIRT_XXL
 #ifdef CONFIG_DEBUG_ENTRY
 
-#define PARA_PATCH(off)		((off) / 8)
-#define PARA_SITE(ptype, ops)	_PVSITE(ptype, ops, .quad, 8)
 #define PARA_INDIRECT(addr)	*addr(%rip)
 
 .macro PARA_IRQ_save_fl
-	PARA_SITE(PARA_PATCH(PV_IRQ_save_fl),
-		  ANNOTATE_RETPOLINE_SAFE;
-		  call PARA_INDIRECT(pv_ops+PV_IRQ_save_fl);)
 	ANNOTATE_RETPOLINE_SAFE;
 	call PARA_INDIRECT(pv_ops+PV_IRQ_save_fl);
 .endm
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 323dca625eea..756cb75d22b5 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -2,15 +2,6 @@
 #ifndef _ASM_X86_PARAVIRT_TYPES_H
 #define _ASM_X86_PARAVIRT_TYPES_H
 
-#ifndef __ASSEMBLY__
-/* These all sit in the .parainstructions section to tell us what to patch. */
-struct paravirt_patch_site {
-	u8 *instr;		/* original instructions */
-	u8 type;		/* type of this instruction */
-	u8 len;			/* length of original instruction */
-};
-#endif
-
 #ifdef CONFIG_PARAVIRT
 
 #ifndef __ASSEMBLY__
@@ -250,34 +241,6 @@ struct paravirt_patch_template {
 extern struct pv_info pv_info;
 extern struct paravirt_patch_template pv_ops;
 
-#define PARAVIRT_PATCH(x)					\
-	(offsetof(struct paravirt_patch_template, x) / sizeof(void *))
-
-#define paravirt_type(op)				\
-	[paravirt_typenum] "i" (PARAVIRT_PATCH(op)),	\
-	[paravirt_opptr] "m" (pv_ops.op)
-/*
- * Generate some code, and mark it as patchable by the
- * apply_paravirt() alternate instruction patcher.
- */
-#define _paravirt_alt(insn_string, type)		\
-	"771:\n\t" insn_string "\n" "772:\n"		\
-	".pushsection .parainstructions,\"a\"\n"	\
-	_ASM_ALIGN "\n"					\
-	_ASM_PTR " 771b\n"				\
-	"  .byte " type "\n"				\
-	"  .byte 772b-771b\n"				\
-	_ASM_ALIGN "\n"					\
-	".popsection\n"
-
-/* Generate patchable code, with the default asm parameters. */
-#define paravirt_alt(insn_string)					\
-	_paravirt_alt(insn_string, "%c[paravirt_typenum]")
-
-/* Simple instruction patching code. */
-#define NATIVE_LABEL(a,x,b) "\n\t.globl " a #x "_" #b "\n" a #x "_" #b ":\n\t"
-
-unsigned int paravirt_patch(u8 type, void *insn_buff, unsigned long addr, unsigned int len);
 #define paravirt_ptr(op)	[paravirt_opptr] "m" (pv_ops.op)
 
 int paravirt_disable_iospace(void);
@@ -545,9 +508,6 @@ unsigned long pv_native_read_cr2(void);
 
 #define paravirt_nop	((void *)x86_nop)
 
-extern struct paravirt_patch_site __parainstructions[],
-	__parainstructions_end[];
-
 #endif	/* __ASSEMBLY__ */
 
 #define ALT_NOT_XEN	ALT_NOT(X86_FEATURE_XENPV)
diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index 29832c338cdc..0b70653a98c1 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -6,18 +6,6 @@
 #include <linux/stddef.h>
 #include <asm/ptrace.h>
 
-struct paravirt_patch_site;
-#ifdef CONFIG_PARAVIRT
-void apply_paravirt(struct paravirt_patch_site *start,
-		    struct paravirt_patch_site *end);
-#else
-static inline void apply_paravirt(struct paravirt_patch_site *start,
-				  struct paravirt_patch_site *end)
-{}
-#define __parainstructions	NULL
-#define __parainstructions_end	NULL
-#endif
-
 /*
  * Currently, the max observed size in the kernel code is
  * JUMP_LABEL_NOP_SIZE/RELATIVEJUMP_SIZE, which are 5.
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 01b89a10d219..48d4bb87dce8 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -160,7 +160,6 @@ extern s32 __retpoline_sites[], __retpoline_sites_end[];
 extern s32 __return_sites[], __return_sites_end[];
 extern s32 __cfi_sites[], __cfi_sites_end[];
 extern s32 __ibt_endbr_seal[], __ibt_endbr_seal_end[];
-extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
 extern s32 __smp_locks[], __smp_locks_end[];
 void text_poke_early(void *addr, const void *opcode, size_t len);
 
@@ -1461,46 +1460,6 @@ int alternatives_text_reserved(void *start, void *end)
 }
 #endif /* CONFIG_SMP */
 
-#ifdef CONFIG_PARAVIRT
-
-/* Use this to add nops to a buffer, then text_poke the whole buffer. */
-static void __init_or_module add_nops(void *insns, unsigned int len)
-{
-	while (len > 0) {
-		unsigned int noplen = len;
-		if (noplen > ASM_NOP_MAX)
-			noplen = ASM_NOP_MAX;
-		memcpy(insns, x86_nops[noplen], noplen);
-		insns += noplen;
-		len -= noplen;
-	}
-}
-
-void __init_or_module apply_paravirt(struct paravirt_patch_site *start,
-				     struct paravirt_patch_site *end)
-{
-	struct paravirt_patch_site *p;
-	char insn_buff[MAX_PATCH_LEN];
-
-	for (p = start; p < end; p++) {
-		unsigned int used;
-
-		BUG_ON(p->len > MAX_PATCH_LEN);
-		/* prep the buffer with the original instructions */
-		memcpy(insn_buff, p->instr, p->len);
-		used = paravirt_patch(p->type, insn_buff, (unsigned long)p->instr, p->len);
-
-		BUG_ON(used > p->len);
-
-		/* Pad the rest with nops */
-		add_nops(insn_buff + used, p->len - used);
-		text_poke_early(p->instr, insn_buff, p->len);
-	}
-}
-extern struct paravirt_patch_site __start_parainstructions[],
-	__stop_parainstructions[];
-#endif	/* CONFIG_PARAVIRT */
-
 /*
  * Self-test for the INT3 based CALL emulation code.
  *
@@ -1636,28 +1595,11 @@ void __init alternative_instructions(void)
 	 */
 
 	/*
-	 * Paravirt patching and alternative patching can be combined to
-	 * replace a function call with a short direct code sequence (e.g.
-	 * by setting a constant return value instead of doing that in an
-	 * external function).
-	 * In order to make this work the following sequence is required:
-	 * 1. set (artificial) features depending on used paravirt
-	 *    functions which can later influence alternative patching
-	 * 2. apply paravirt patching (generally replacing an indirect
-	 *    function call with a direct one)
-	 * 3. apply alternative patching (e.g. replacing a direct function
-	 *    call with a custom code sequence)
-	 * Doing paravirt patching after alternative patching would clobber
-	 * the optimization of the custom code with a function call again.
+	 * Make sure to set (artificial) features depending on used paravirt
+	 * functions which can later influence alternative patching.
 	 */
 	paravirt_set_cap();
 
-	/*
-	 * First patch paravirt functions, such that we overwrite the indirect
-	 * call with the direct call.
-	 */
-	apply_paravirt(__parainstructions, __parainstructions_end);
-
 	__apply_fineibt(__retpoline_sites, __retpoline_sites_end,
 			__cfi_sites, __cfi_sites_end, true);
 
@@ -1668,10 +1610,6 @@ void __init alternative_instructions(void)
 	apply_retpolines(__retpoline_sites, __retpoline_sites_end);
 	apply_returns(__return_sites, __return_sites_end);
 
-	/*
-	 * Then patch alternatives, such that those paravirt calls that are in
-	 * alternatives can be overwritten by their immediate fragments.
-	 */
 	apply_alternatives(__alt_instructions, __alt_instructions_end);
 
 	/*
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 32792b033de2..5358d43886ad 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -43,14 +43,6 @@ void __init default_banner(void)
 	       pv_info.name);
 }
 
-static unsigned paravirt_patch_call(void *insn_buff, const void *target,
-				    unsigned long addr, unsigned len)
-{
-	__text_gen_insn(insn_buff, CALL_INSN_OPCODE,
-			(void *)addr, target, CALL_INSN_SIZE);
-	return CALL_INSN_SIZE;
-}
-
 #ifdef CONFIG_PARAVIRT_XXL
 DEFINE_ASM_FUNC(_paravirt_ident_64, "mov %rdi, %rax", .text);
 DEFINE_ASM_FUNC(pv_native_save_fl, "pushf; pop %rax", .noinstr.text);
@@ -73,28 +65,6 @@ static void native_tlb_remove_table(struct mmu_gather *tlb, void *table)
 	tlb_remove_page(tlb, table);
 }
 
-unsigned int paravirt_patch(u8 type, void *insn_buff, unsigned long addr,
-			    unsigned int len)
-{
-	/*
-	 * Neat trick to map patch type back to the call within the
-	 * corresponding structure.
-	 */
-	void *opfunc = *((void **)&pv_ops + type);
-	unsigned ret;
-
-	if (opfunc == NULL)
-		/* If there's no function, patch it with x86_BUG() */
-		ret = paravirt_patch_call(insn_buff, x86_BUG, addr, len);
-	else if (opfunc == x86_nop)
-		ret = 0;
-	else
-		/* Otherwise call the function. */
-		ret = paravirt_patch_call(insn_buff, opfunc, addr, len);
-
-	return ret;
-}
-
 struct static_key paravirt_steal_enabled;
 struct static_key paravirt_steal_rq_enabled;
 
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index f15fb71f280e..1a3153dfaea8 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -270,19 +270,6 @@ SECTIONS
 	}
 #endif
 
-	/*
-	 * start address and size of operations which during runtime
-	 * can be patched with virtualization friendly instructions or
-	 * baremetal native ones. Think page table operations.
-	 * Details in paravirt_types.h
-	 */
-	. = ALIGN(8);
-	.parainstructions : AT(ADDR(.parainstructions) - LOAD_OFFSET) {
-		__parainstructions = .;
-		*(.parainstructions)
-		__parainstructions_end = .;
-	}
-
 #ifdef CONFIG_RETPOLINE
 	/*
 	 * List of instructions that call/jmp/jcc to retpoline thunks
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index d30949e25ebd..a3bae2b24626 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -66,7 +66,7 @@ static const char * const sym_regex_kernel[S_NSYMTYPES] = {
 	[S_REL] =
 	"^(__init_(begin|end)|"
 	"__x86_cpu_dev_(start|end)|"
-	"(__parainstructions|__alt_instructions)(_end)?|"
+	"__alt_instructions(_end)?|"
 	"(__iommu_table|__apicdrivers|__smp_locks)(_end)?|"
 	"__(start|end)_pci_.*|"
 #if CONFIG_FW_LOADER
-- 
2.35.3

