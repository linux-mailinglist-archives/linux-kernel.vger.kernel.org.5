Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADCF7CCF1A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343896AbjJQVXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjJQVX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:23:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6A9C4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:23:25 -0700 (PDT)
Message-ID: <20231017200758.877560658@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697577803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=bDcptuf6eC5gIcWIQLc4a4fe7FSLAiaOI+OLrRJ3FUA=;
        b=rbwbBSQNnC+gEDbYrwztRCJa40QQeDqvWPvcwpCgfKROVuuyewScqFjWrjGzT1r8z34r5G
        BWl1lNeH5Q5EOhwTmK4q3C6CxDS7LB2shfjxn6Fv5MK59apUhY64y9jcnjNlhjz7MRgkYv
        m1nxiSokbq5ixw0Aj1wMyux4ydU/uWrxt+ezMaacyzgF1kLhcLoAgIDASWivJiyFdHG2Oj
        LL75577N5l97z4M8sJ2TBKRGkgYGx13P6V7hQALu68zjV9vq/0+zfrnv3vk2BcHIhL/60h
        A3hs2+CcE+u7MUIypD7AvumMPUL12ZZ3O/v9EHfw0WkNi3S2hsvQd9FckjuPyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697577803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=bDcptuf6eC5gIcWIQLc4a4fe7FSLAiaOI+OLrRJ3FUA=;
        b=1YrL3xZLhliPjqHZEJ02Q681s+fUw0K0F5+FYpI2XUHOe8kJWis8NwY0niqBp8BCDKgDs8
        uuiNAj55JKlI32DA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>
Subject: [patch V5 00/39] x86/microcode: Cleanup and late loading enhancements
Date:   Tue, 17 Oct 2023 23:23:22 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is is a refresh of the microcode overhaul series V4:

  https://lore.kernel.org/all/20231002115506.217091296@linutronix.de/

combined with the follow up series for AMD:

  https://lore.kernel.org/all/20231010145130.987300357@linutronix.de

This refresh turned out to be necessary as the original series which had
been applied to

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode

turned out to have a serious flaw.

Moving the 32bit early loading after paging enable is broken due to a
combination of a naive brainfart on my side, a test setup failure and the
utter lack of general 32-bit test coverage.

Borislav noticed it by chance end of last week and I was able to cure it
with a series on top, but we deciced to rebase the whole lot for the sake
of bisectability and use the opportunity to fold the fixes and reshuffle
the series so that the AMD cleanups are in front of the late loading
changes.

The problem is simply that contrary to 64-bit, 32-bit cannot establish a
initrd mapping via the early page fault handler and therefore initrd is not
accessible after paging is enabled, especially not if the initrd is placed
outside of the low-mem physical address space.

Bringing the pre paging early load mechanics back was not really an option
as this prevents quite some major cleanups in the microcode loader and
brings back all the undebuggable horrors in the affected code paths.

After debating and exploring some options it turned out that the final
solution is pretty straight forward.

32-bit sets up the initial page tables from physical address 0 up to the
end of the kernel image, which has the .brk section at the end, plus some
extra margin to cover a complete low-mem direct page table. The end of this
mapping space is saved in _brk_end, which is used by the subsequent
initialization code to reserve memory. _brk_end is PMD/PGD (3/2 level)
aligned. Anything after _brk_end is reused as regular memory space.

This part and the _brk_end mechanics are left unmodified. After that the
initial page table setup code establishes a temporary mapping for the
initrd right after _brk_end and stores the resulting virtual address for
the early BSP microcode loader. After the loader completes, the mapping is
zapped by invalidating the related PMD/PGD (3/2 level paging) entries in
the initial page tables. As the actual PTE entries are located past
_brk_end, they are just discarded and therefore is no memory wasted. As
this happens right at the beginning of i386_start_kernel() which is the
transition from ASM to C, the temporarily utilized PTE memory space and the
resulting virtual addresses are not interfering with anything.

This also requires to undo the Intel specific optimization of saving the
microcode blob address for later use in save_builtin_microcode().o That's
required because initrd can be relocated, especially on 32-bit.

The series is also available from git:

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git ucode-v5

The delta patch against 

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode

is below. The head32.c changes in that delta patch are slightly hard to
read, but the actual commits which rework that inital map code are fine
granular and review friendly.

Though the delta shows nicely that the rest of the code, except for the
initrd rescan in save_builtin_microcode() is not affected by these
changes. The rescan change is harmless and has been tested extensively.

Thanks to Borislav for discussing this with me over the weekend and for his
extensive testing on 32-bit (!PAE/PAE) in the past two days!

Thanks,

	tglx
---
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d8ff206e503f..cadea3f3161e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1313,6 +1313,10 @@ config MICROCODE
 	def_bool y
 	depends on CPU_SUP_AMD || CPU_SUP_INTEL
 
+config MICROCODE_INITRD32
+	def_bool y
+	depends on MICROCODE && X86_32 && BLK_DEV_INITRD
+
 config MICROCODE_LATE_LOADING
 	bool "Late microcode loading (DANGEROUS)"
 	default n
diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 7811efe53b5e..695e569159c1 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -23,6 +23,8 @@ static inline void load_ucode_ap(void) { }
 static inline void microcode_bsp_resume(void) { }
 #endif
 
+extern unsigned long initrd_start_early;
+
 #ifdef CONFIG_CPU_SUP_INTEL
 /* Intel specific microcode defines. Public for IFS */
 struct microcode_header_intel {
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 8baa8cebc0b8..07f8ddd9209b 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -530,7 +530,7 @@ static int __init save_microcode_in_initrd(void)
 	enum ucode_state ret;
 	struct cpio_data cp;
 
-	if (c->x86_vendor != X86_VENDOR_AMD || c->x86 < 0x10)
+	if (dis_ucode_ldr || c->x86_vendor != X86_VENDOR_AMD || c->x86 < 0x10)
 		return 0;
 
 	find_blobs_in_containers(cpuid_1_eax, &cp);
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 18e0cdd4f569..666d25bbc5ad 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -44,7 +44,7 @@
 #define DRIVER_VERSION	"2.2"
 
 static struct microcode_ops	*microcode_ops;
-static bool dis_ucode_ldr = true;
+bool dis_ucode_ldr = true;
 
 bool force_minrev = IS_ENABLED(CONFIG_MICROCODE_LATE_FORCE_MINREV);
 module_param(force_minrev, bool, S_IRUSR | S_IWUSR);
@@ -191,12 +191,9 @@ struct cpio_data __init find_microcode_in_initrd(const char *path)
 
 #ifdef CONFIG_X86_32
 	size = boot_params.hdr.ramdisk_size;
-	/*
-	 * Set start only if we have an initrd image. We cannot use initrd_start
-	 * because it is not set that early yet.
-	 */
+	/* Early load on BSP has a temporary mapping. */
 	if (size)
-		start = boot_params.hdr.ramdisk_image;
+		start = initrd_start_early;
 
 #else /* CONFIG_X86_64 */
 	size  = (unsigned long)boot_params.ext_ramdisk_size << 32;
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index d6311f0273fa..e99f129708da 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -375,8 +375,6 @@ static __init struct microcode_intel *get_microcode_blob(struct ucode_cpu_info *
 	return scan_microcode(cp.data, cp.size, uci);
 }
 
-static struct microcode_intel *ucode_early_pa __initdata;
-
 /*
  * Invoked from an early init call to save the microcode blob which was
  * selected during early boot when mm was not usable. The microcode must be
@@ -386,13 +384,14 @@ static struct microcode_intel *ucode_early_pa __initdata;
  */
 static int __init save_builtin_microcode(void)
 {
-	struct microcode_intel *mc;
+	struct ucode_cpu_info uci;
 
-	if (!ucode_early_pa)
+	if (dis_ucode_ldr || boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return 0;
 
-	mc = __va((void *)ucode_early_pa);
-	save_microcode_patch(mc);
+	uci.mc = get_microcode_blob(&uci);
+	if (uci.mc)
+		save_microcode_patch(uci.mc);
 	return 0;
 }
 early_initcall(save_builtin_microcode);
@@ -403,14 +402,8 @@ void __init load_ucode_intel_bsp(void)
 	struct ucode_cpu_info uci;
 
 	uci.mc = get_microcode_blob(&uci);
-	if (!uci.mc)
-		return;
-
-	if (apply_microcode_early(&uci) != UCODE_UPDATED)
-		return;
-
-	/* Store the physical address as KASLR happens after this. */
-	ucode_early_pa = (struct microcode_intel *)__pa_nodebug(uci.mc);
+	if (uci.mc)
+		apply_microcode_early(&uci);
 }
 
 void load_ucode_intel_ap(void)
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
index fc03a7b39f18..f8047b12329a 100644
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -37,8 +37,6 @@ struct microcode_ops {
 				use_nmi		: 1;
 };
 
-extern bool force_minrev;
-
 extern struct ucode_cpu_info ucode_cpu_info[];
 struct cpio_data find_microcode_in_initrd(const char *path);
 
@@ -90,6 +88,9 @@ static inline unsigned int x86_cpuid_family(void)
 	return x86_family(eax);
 }
 
+extern bool dis_ucode_ldr;
+extern bool force_minrev;
+
 #ifdef CONFIG_CPU_SUP_AMD
 void load_ucode_amd_bsp(unsigned int family);
 void load_ucode_amd_ap(unsigned int family);
diff --git a/arch/x86/kernel/head32.c b/arch/x86/kernel/head32.c
index f34b15c100d4..cacc6603dadf 100644
--- a/arch/x86/kernel/head32.c
+++ b/arch/x86/kernel/head32.c
@@ -30,12 +30,32 @@ static void __init i386_default_early_setup(void)
 	x86_init.mpparse.setup_ioapic_ids = setup_ioapic_ids_from_mpc;
 }
 
+#ifdef CONFIG_MICROCODE_INITRD32
+unsigned long __initdata initrd_start_early;
+static pte_t __initdata *initrd_pl2p_start, *initrd_pl2p_end;
+
+static void zap_early_initrd_mapping(void)
+{
+	pte_t *pl2p = initrd_pl2p_start;
+
+	for (; pl2p < initrd_pl2p_end; pl2p++) {
+		*pl2p = (pte_t){ .pte = 0 };
+
+		if (!IS_ENABLED(CONFIG_X86_PAE))
+			*(pl2p + ((PAGE_OFFSET >> PGDIR_SHIFT))) = (pte_t) {.pte = 0};
+	}
+}
+#else
+static inline void zap_early_initrd_mapping(void) { }
+#endif
+
 asmlinkage __visible void __init __noreturn i386_start_kernel(void)
 {
 	/* Make sure IDT is set up before any exception happens */
 	idt_setup_early_handler();
 
 	load_ucode_bsp();
+	zap_early_initrd_mapping();
 
 	cr4_init_shadow();
 
@@ -74,51 +94,83 @@ asmlinkage __visible void __init __noreturn i386_start_kernel(void)
  */
 void __init mk_early_pgtbl_32(void);
 
-void __init __no_stack_protector mk_early_pgtbl_32(void)
-{
-#ifdef __pa
-#undef __pa
-#endif
-#define __pa(x)  ((unsigned long)(x) - PAGE_OFFSET)
-	pte_t pte, *ptep;
-	int i;
-	unsigned long *ptr;
-	/* Enough space to fit pagetables for the low memory linear map */
-	const unsigned long limit = __pa(_end) +
-		(PAGE_TABLE_SIZE(LOWMEM_PAGES) << PAGE_SHIFT);
 #ifdef CONFIG_X86_PAE
-	pmd_t pl2, *pl2p = (pmd_t *)__pa(initial_pg_pmd);
-#define SET_PL2(pl2, val)    { (pl2).pmd = (val); }
+typedef pmd_t			pl2_t;
+#define pl2_base		initial_pg_pmd
+#define SET_PL2(val)		{ .pmd = (val), }
 #else
-	pgd_t pl2, *pl2p = (pgd_t *)__pa(initial_page_table);
-#define SET_PL2(pl2, val)   { (pl2).pgd = (val); }
+typedef pgd_t			pl2_t;
+#define pl2_base		initial_page_table
+#define SET_PL2(val)		{ .pgd = (val), }
 #endif
 
-	ptep = (pte_t *)__pa(__brk_base);
-	pte.pte = PTE_IDENT_ATTR;
-
+static __init __no_stack_protector pte_t init_map(pte_t pte, pte_t **ptep, pl2_t **pl2p,
+						  const unsigned long limit)
+{
 	while ((pte.pte & PTE_PFN_MASK) < limit) {
+		pl2_t pl2 = SET_PL2((unsigned long)*ptep | PDE_IDENT_ATTR);
+		int i;
+
+		**pl2p = pl2;
+		if (!IS_ENABLED(CONFIG_X86_PAE)) {
+			/* Kernel PDE entry */
+			*(*pl2p + ((PAGE_OFFSET >> PGDIR_SHIFT))) = pl2;
+		}
 
-		SET_PL2(pl2, (unsigned long)ptep | PDE_IDENT_ATTR);
-		*pl2p = pl2;
-#ifndef CONFIG_X86_PAE
-		/* Kernel PDE entry */
-		*(pl2p +  ((PAGE_OFFSET >> PGDIR_SHIFT))) = pl2;
-#endif
 		for (i = 0; i < PTRS_PER_PTE; i++) {
-			*ptep = pte;
+			**ptep = pte;
 			pte.pte += PAGE_SIZE;
-			ptep++;
+			(*ptep)++;
 		}
-
-		pl2p++;
+		(*pl2p)++;
 	}
+	return pte;
+}
+
+void __init __no_stack_protector mk_early_pgtbl_32(void)
+{
+	/* Enough space to fit pagetables for the low memory linear map */
+	unsigned long limit = __pa_nodebug(_end) + (PAGE_TABLE_SIZE(LOWMEM_PAGES) << PAGE_SHIFT);
+	pte_t pte, *ptep = (pte_t *)__pa_nodebug(__brk_base);
+	struct boot_params __maybe_unused *params;
+	pl2_t *pl2p = (pl2_t *)__pa_nodebug(pl2_base);
+	unsigned long *ptr;
+
+	pte.pte = PTE_IDENT_ATTR;
+	pte = init_map(pte, &ptep, &pl2p, limit);
 
-	ptr = (unsigned long *)__pa(&max_pfn_mapped);
+	ptr = (unsigned long *)__pa_nodebug(&max_pfn_mapped);
 	/* Can't use pte_pfn() since it's a call with CONFIG_PARAVIRT */
 	*ptr = (pte.pte & PTE_PFN_MASK) >> PAGE_SHIFT;
 
-	ptr = (unsigned long *)__pa(&_brk_end);
+	ptr = (unsigned long *)__pa_nodebug(&_brk_end);
 	*ptr = (unsigned long)ptep + PAGE_OFFSET;
-}
 
+#ifdef CONFIG_MICROCODE_INITRD32
+	/* Running on a hypervisor? */
+	if (native_cpuid_ecx(1) & BIT(31))
+		return;
+
+	params = (struct boot_params *)__pa_nodebug(&boot_params);
+	if (!params->hdr.ramdisk_size || !params->hdr.ramdisk_image)
+		return;
+
+	/* Save the virtual start address */
+	ptr = (unsigned long *)__pa_nodebug(&initrd_start_early);
+	*ptr = (pte.pte & PTE_PFN_MASK) + PAGE_OFFSET;
+	*ptr += ((unsigned long)params->hdr.ramdisk_image) & ~PAGE_MASK;
+
+	/* Save PLP2 for cleanup */
+	ptr = (unsigned long *)__pa_nodebug(&initrd_pl2p_start);
+	*ptr = (unsigned long)pl2p + PAGE_OFFSET;
+
+	limit = (unsigned long)params->hdr.ramdisk_image;
+	pte.pte = PTE_IDENT_ATTR | PFN_ALIGN(limit);
+	limit = (unsigned long)params->hdr.ramdisk_image + params->hdr.ramdisk_size;
+
+	init_map(pte, &ptep, &pl2p, limit);
+
+	ptr = (unsigned long *)__pa_nodebug(&initrd_pl2p_end);
+	*ptr = (unsigned long)pl2p + PAGE_OFFSET;
+#endif
+}
