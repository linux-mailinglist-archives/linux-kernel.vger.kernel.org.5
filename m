Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61947DBBB5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbjJ3O0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbjJ3OZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:25:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF67C11A
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 07:25:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 43C071FE71;
        Mon, 30 Oct 2023 14:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1698675940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Xm3XX0lpogqG4X8OBm0jw7upX4JQzBbrWGV4vURmd8=;
        b=B367c5izNqhlevT5ZziUYl9KghzgVkFfXEMKLDYFKP0ichZbM8O8GWZzHoO0MgTKEuqNsF
        lMRDyd4MN5Wh84wrUMybsEZxSy4sq7668FHRXybQv+cF9uoKIjR5vlEGTqIkAWiXFP1mqC
        gw94y2URnBmB+uazBpE6+3esyaWI8lE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D5584138F8;
        Mon, 30 Oct 2023 14:25:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HPi7MuO8P2UfQQAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 30 Oct 2023 14:25:39 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     Juergen Gross <jgross@suse.com>, Ajay Kaher <akaher@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v4 5/5] x86/paravirt: remove no longer needed paravirt patching code
Date:   Mon, 30 Oct 2023 15:25:08 +0100
Message-Id: <20231030142508.1407-6-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231030142508.1407-1-jgross@suse.com>
References: <20231030142508.1407-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
index 9b0526967d69..15d2b83ce410 100644
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
 
 #define paravirt_nop	((void *)nop_func)
 
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
index dd14db12c573..2474335e264b 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -160,7 +160,6 @@ extern s32 __retpoline_sites[], __retpoline_sites_end[];
 extern s32 __return_sites[], __return_sites_end[];
 extern s32 __cfi_sites[], __cfi_sites_end[];
 extern s32 __ibt_endbr_seal[], __ibt_endbr_seal_end[];
-extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
 extern s32 __smp_locks[], __smp_locks_end[];
 void text_poke_early(void *addr, const void *opcode, size_t len);
 
@@ -1466,46 +1465,6 @@ int alternatives_text_reserved(void *start, void *end)
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
@@ -1641,28 +1600,11 @@ void __init alternative_instructions(void)
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
 
@@ -1673,10 +1615,6 @@ void __init alternative_instructions(void)
 	apply_retpolines(__retpoline_sites, __retpoline_sites_end);
 	apply_returns(__return_sites, __return_sites_end);
 
-	/*
-	 * Then patch alternatives, such that those paravirt calls that are in
-	 * alternatives can be overwritten by their immediate fragments.
-	 */
 	apply_alternatives(__alt_instructions, __alt_instructions_end);
 
 	/*
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index acc5b1004f0f..5358d43886ad 100644
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
-		/* If there's no function, patch it with BUG_func() */
-		ret = paravirt_patch_call(insn_buff, BUG_func, addr, len);
-	else if (opfunc == nop_func)
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

