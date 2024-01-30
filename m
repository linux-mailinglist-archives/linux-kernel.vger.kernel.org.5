Return-Path: <linux-kernel+bounces-45371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCBD842F61
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91FA11C22830
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD247D407;
	Tue, 30 Jan 2024 22:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hn78ZdwM"
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37507D402
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 22:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706652546; cv=none; b=qPx+quM9rA8EC33I5YZsPGObN33KylKNfqJ2Za7Wt2UXyc6cZSlkDSzKeC+Xq+P3dPQ6LDLVa0ulU9gatzdinL7P5f8QlM/u9Sjz2ePkT/Nv/GzFeJnc/BAqra144sfrL+tfP6jsaHvw79aEUDj2CUrU9dsMMEqiOrCOeGRxc4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706652546; c=relaxed/simple;
	bh=cAGKrm92oVrNmOiOMn8fy23L/TVwM7iclaVD4LZh5WE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J7ge4QXsBcdvYCQcCD1Zr5Iz9UKgKEeMIEt1CsY3U9z86vX2J39lXKd7Au2ZP0/ju7/U8wSJIGG2C4zWh8Fasn/xwVZp490Btq9GG9irQE7utA338NC+6+9U0BF7USY83M9jImPxpiW93DE5Obu5WEkDF/NUuiVX9T8BJ0z+QBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hn78ZdwM; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3637e2a2e5fso1819075ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 14:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706652544; x=1707257344; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v4ZNXq4RV3WjW3eGUbkswFledHjcQCF1i0cLTt8hHb8=;
        b=Hn78ZdwMs71utSRQU1Z9NmIIhovVQoj2G2xhrf3JAzMfUWYyxbas70UCiGQ9pzvoXW
         dRqs/ZQzu2hNmdDX/ka2L22QFIyKf9dOjE2cFdttLM7ko1K4CoRE7Uv7/xfP555i8Z3C
         bWkzYViCmo1O83V1q3XeBFwVMMbMG8lEnjroPjEm01AiNF2O0KN8Qym3TP5jaMLbeDbq
         C2aPDaBUgKX0/pqthQItRI235o0ifB+krmDpyvWLdUge1VqDJyxVHlBfg8CuNQsHBJRQ
         kmHdmkHlISEs4rLXKDfeoe7mrXjuOCp8JBEhfmE1OpA3JcW2QYDibGsF8kxB4FEbYT1o
         PgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706652544; x=1707257344;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v4ZNXq4RV3WjW3eGUbkswFledHjcQCF1i0cLTt8hHb8=;
        b=OygBjauv1nTtLQpICU+WDcKR3V4coZB9ZuROaaJ8g2tUmrDtGHIKGatDLGcmFR/0qY
         YEcZ5TzwmQeqF5tajgTmny9h8nqnM0WsmLVw4VQhm0VbplfBn/j+yX/HDbhqSBBG0xG9
         MUaInOmrFVoqN0gPeRQ+P95oRJ9+dXlVgocg/6ycLxCbg29bP1Fg0IyGHB8jFGDMHjvH
         9z3FEp8WiD565M1ix384LZo7B0e7AX/m60SD4YNaacclZXOfL+6UMAILvkO5gm+Reoyt
         hDOORq0MeooeIaKboe4Rp0EeD0iJOqW3r+dzgahxzJIYjOJzb3glcSnMb2vrr/1iX8ft
         DvUg==
X-Gm-Message-State: AOJu0Yz4gsNeP9TchHV78uSpdCNT4Tl7nEc57pDZHjSs5lSJcsfsI2Hv
	6wCpjGHHhyl6BB6R1pjepi/5SfZ+R9Z37ToVlI3DcPgcz2b94gclIQM38hw6n2MBVQcwHEDcYLJ
	qcMQ2h4xZIsJYdn9muWgO3FWNF6WVqw==
X-Google-Smtp-Source: AGHT+IGLFDGZPeP67g5zfyhIPj2E3tcSBR6QJ4v+rNDYBBTtGTydMOdlEidlwkSIVWN2gnrHVjbqLZp5evEJhBBxyEQp
X-Received: from loughlin00.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:1b6f])
 (user=kevinloughlin job=sendgmr) by 2002:a05:6e02:92d:b0:363:8c76:8741 with
 SMTP id o13-20020a056e02092d00b003638c768741mr50259ilt.0.1706652543762; Tue,
 30 Jan 2024 14:09:03 -0800 (PST)
Date: Tue, 30 Jan 2024 22:08:45 +0000
In-Reply-To: <20240121182040.GBZa1geI5NxWSslvt0@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240121182040.GBZa1geI5NxWSslvt0@fat_crate.local>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240130220845.1978329-3-kevinloughlin@google.com>
Subject: [PATCH v3 2/2] x86/head64: Replace pointer fixups with RIP_RELATIVE_ADDR()
From: Kevin Loughlin <kevinloughlin@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Pankaj Gupta <pankaj.gupta@amd.com>, Hou Wenlong <houwenlong.hwl@antgroup.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Dionna Glaze <dionnaglaze@google.com>, 
	Brijesh Singh <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-coco@lists.linux.dev, 
	Ashish Kalra <ashish.kalra@amd.com>, Andi Kleen <ak@linux.intel.com>
Cc: Adam Dunlap <acdunlap@google.com>, Peter Gonda <pgonda@google.com>, 
	Jacob Xu <jacobhxu@google.com>, Sidharth Telang <sidtelang@google.com>
Content-Type: text/plain; charset="UTF-8"

Now that we have RIP_RELATIVE_ADDR(), we can replace the "fixup_*()"
family of functions in head64.c with the new macro for cleaner code.

Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
---
 arch/x86/kernel/head64.c | 63 +++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 39 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index d159239997f4..e782149eefc4 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -85,23 +85,8 @@ static struct desc_ptr startup_gdt_descr __initdata = {
 	.address = 0,
 };
 
-static void __head *fixup_pointer(void *ptr, unsigned long physaddr)
-{
-	return ptr - (void *)_text + (void *)physaddr;
-}
-
-static unsigned long __head *fixup_long(void *ptr, unsigned long physaddr)
-{
-	return fixup_pointer(ptr, physaddr);
-}
-
 #ifdef CONFIG_X86_5LEVEL
-static unsigned int __head *fixup_int(void *ptr, unsigned long physaddr)
-{
-	return fixup_pointer(ptr, physaddr);
-}
-
-static bool __head check_la57_support(unsigned long physaddr)
+static bool __head check_la57_support(void)
 {
 	/*
 	 * 5-level paging is detected and enabled at kernel decompression
@@ -110,17 +95,17 @@ static bool __head check_la57_support(unsigned long physaddr)
 	if (!(native_read_cr4() & X86_CR4_LA57))
 		return false;
 
-	*fixup_int(&__pgtable_l5_enabled, physaddr) = 1;
-	*fixup_int(&pgdir_shift, physaddr) = 48;
-	*fixup_int(&ptrs_per_p4d, physaddr) = 512;
-	*fixup_long(&page_offset_base, physaddr) = __PAGE_OFFSET_BASE_L5;
-	*fixup_long(&vmalloc_base, physaddr) = __VMALLOC_BASE_L5;
-	*fixup_long(&vmemmap_base, physaddr) = __VMEMMAP_BASE_L5;
+	*((unsigned int *)RIP_RELATIVE_ADDR(__pgtable_l5_enabled)) = 1;
+	*((unsigned int *)RIP_RELATIVE_ADDR(pgdir_shift)) = 48;
+	*((unsigned int *)RIP_RELATIVE_ADDR(ptrs_per_p4d)) = 512;
+	*((unsigned long *)RIP_RELATIVE_ADDR(page_offset_base)) = __PAGE_OFFSET_BASE_L5;
+	*((unsigned long *)RIP_RELATIVE_ADDR(vmalloc_base)) = __VMALLOC_BASE_L5;
+	*((unsigned long *)RIP_RELATIVE_ADDR(vmemmap_base)) = __VMEMMAP_BASE_L5;
 
 	return true;
 }
 #else
-static bool __head check_la57_support(unsigned long physaddr)
+static bool __head check_la57_support(void)
 {
 	return false;
 }
@@ -175,8 +160,8 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
  * Code in __startup_64() can be relocated during execution, but the compiler
  * doesn't have to generate PC-relative relocations when accessing globals from
  * that function. Clang actually does not generate them, which leads to
- * boot-time crashes. To work around this problem, every global pointer must
- * be adjusted using fixup_pointer() or RIP_RELATIVE_ADDR().
+ * boot-time crashes. To work around this problem, every global variable access
+ * must be adjusted using RIP_RELATIVE_ADDR().
  */
 unsigned long __head __startup_64(unsigned long physaddr,
 				  struct boot_params *bp)
@@ -194,7 +179,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	int i;
 	unsigned int *next_pgt_ptr;
 
-	la57 = check_la57_support(physaddr);
+	la57 = check_la57_support();
 
 	/* Is the address too large? */
 	if (physaddr >> MAX_PHYSMEM_BITS)
@@ -215,7 +200,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 
 	/* Fixup the physical addresses in the page table */
 
-	pgd = fixup_pointer(early_top_pgt, physaddr);
+	pgd = RIP_RELATIVE_ADDR(early_top_pgt);
 	p = pgd + pgd_index(__START_KERNEL_map);
 	if (la57)
 		*p = (unsigned long)level4_kernel_pgt;
@@ -224,15 +209,15 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	*p += _PAGE_TABLE_NOENC - __START_KERNEL_map + load_delta;
 
 	if (la57) {
-		p4d = fixup_pointer(level4_kernel_pgt, physaddr);
+		p4d = RIP_RELATIVE_ADDR(level4_kernel_pgt);
 		p4d[511] += load_delta;
 	}
 
-	pud = fixup_pointer(level3_kernel_pgt, physaddr);
+	pud = RIP_RELATIVE_ADDR(level3_kernel_pgt);
 	pud[510] += load_delta;
 	pud[511] += load_delta;
 
-	pmd = fixup_pointer(level2_fixmap_pgt, physaddr);
+	pmd = RIP_RELATIVE_ADDR(level2_fixmap_pgt);
 	for (i = FIXMAP_PMD_TOP; i > FIXMAP_PMD_TOP - FIXMAP_PMD_NUM; i--)
 		pmd[i] += load_delta;
 
@@ -243,8 +228,8 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 * it avoids problems around wraparound.
 	 */
 
-	next_pgt_ptr = fixup_pointer(&next_early_pgt, physaddr);
-	early_dynamic_pgts_ptr = fixup_pointer(early_dynamic_pgts, physaddr);
+	early_dynamic_pgts_ptr = RIP_RELATIVE_ADDR(early_dynamic_pgts);
+	next_pgt_ptr = RIP_RELATIVE_ADDR(next_early_pgt);
 	pud = (pudval_t *) early_dynamic_pgts_ptr[(*next_pgt_ptr)++];
 	pmd = (pmdval_t *) early_dynamic_pgts_ptr[(*next_pgt_ptr)++];
 
@@ -272,7 +257,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 
 	pmd_entry = __PAGE_KERNEL_LARGE_EXEC & ~_PAGE_GLOBAL;
 	/* Filter out unsupported __PAGE_KERNEL_* bits: */
-	mask_ptr = fixup_pointer(&__supported_pte_mask, physaddr);
+	mask_ptr = RIP_RELATIVE_ADDR(__supported_pte_mask);
 	pmd_entry &= *mask_ptr;
 	pmd_entry += sme_me_mask_fixed_up;
 	pmd_entry +=  physaddr;
@@ -299,7 +284,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 * error, causing the BIOS to halt the system.
 	 */
 
-	pmd = fixup_pointer(level2_kernel_pgt, physaddr);
+	pmd = RIP_RELATIVE_ADDR(level2_kernel_pgt);
 
 	/* invalidate pages before the kernel image */
 	for (i = 0; i < pmd_index((unsigned long)_text); i++)
@@ -318,7 +303,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 * Fixup phys_base - remove the memory encryption mask to obtain
 	 * the true physical address.
 	 */
-	*fixup_long(&phys_base, physaddr) += load_delta - sme_me_mask_fixed_up;
+	*((unsigned long *)RIP_RELATIVE_ADDR(phys_base)) += load_delta - sme_me_mask_fixed_up;
 
 	return sme_postprocess_startup(bp, pmd);
 }
@@ -594,15 +579,15 @@ static void set_bringup_idt_handler(gate_desc *idt, int n, void *handler)
 /* This runs while still in the direct mapping */
 static void __head startup_64_load_idt(unsigned long physbase)
 {
-	struct desc_ptr *desc = fixup_pointer(&bringup_idt_descr, physbase);
-	gate_desc *idt = fixup_pointer(bringup_idt_table, physbase);
+	struct desc_ptr *desc = RIP_RELATIVE_ADDR(bringup_idt_descr);
+	gate_desc *idt = RIP_RELATIVE_ADDR(bringup_idt_table);
 
 
 	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
 		void *handler;
 
 		/* VMM Communication Exception */
-		handler = fixup_pointer(vc_no_ghcb, physbase);
+		handler = RIP_RELATIVE_ADDR(vc_no_ghcb);
 		set_bringup_idt_handler(idt, X86_TRAP_VC, handler);
 	}
 
@@ -629,7 +614,7 @@ void early_setup_idt(void)
 void __head startup_64_setup_env(unsigned long physbase)
 {
 	/* Load GDT */
-	startup_gdt_descr.address = (unsigned long)fixup_pointer(startup_gdt, physbase);
+	startup_gdt_descr.address = (unsigned long)RIP_RELATIVE_ADDR(startup_gdt);
 	native_load_gdt(&startup_gdt_descr);
 
 	/* New GDT is live - reload data segment registers */
-- 
2.43.0.429.g432eaa2c6b-goog


