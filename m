Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D19809DC4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573413AbjLHH6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573446AbjLHH6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:58:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3DF1FD9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:57:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40F6C433CB;
        Fri,  8 Dec 2023 07:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702022236;
        bh=vXErCahHzRnfZFxBX2mMb/HGeRZnO3uWpxefJvPE+i8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TZD9nxoqp1Y01tVDCKlMobi0HefLGnRwE76YxUVQnvVBMwFhDEWbvxOhQMBK8nw2R
         dOINVM8B3XjZbhjHAkrmxdYxqhaK8Yy3iJcvFkM0/Yh9ryVn8AZeojQGh4om6qxDMk
         YwrBOabcYdVHaOrqUshO2sL3Y66bDg5D1W15XTBg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.6.5
Date:   Fri,  8 Dec 2023 08:57:05 +0100
Message-ID: <2023120805-santa-scarce-1ba2@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2023120805-abstract-fancy-0ce5@gregkh>
References: <2023120805-abstract-fancy-0ce5@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Documentation/ABI/testing/sysfs-class-led b/Documentation/ABI/testing/sysfs-class-led
index b2ff0012c0f2..2e24ac3bd7ef 100644
--- a/Documentation/ABI/testing/sysfs-class-led
+++ b/Documentation/ABI/testing/sysfs-class-led
@@ -59,15 +59,6 @@ Description:
 		brightness. Reading this file when no hw brightness change
 		event has happened will return an ENODATA error.
 
-What:		/sys/class/leds/<led>/color
-Date:		June 2023
-KernelVersion:	6.5
-Description:
-		Color of the LED.
-
-		This is a read-only file. Reading this file returns the color
-		of the LED as a string (e.g: "red", "green", "multicolor").
-
 What:		/sys/class/leds/<led>/trigger
 Date:		March 2006
 KernelVersion:	2.6.17
diff --git a/Makefile b/Makefile
index cbe63ba9126e..ee4e504a3e78 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 6
-SUBLEVEL = 4
+SUBLEVEL = 5
 EXTRAVERSION =
 NAME = Hurr durr I'ma ninja sloth
 
diff --git a/arch/parisc/include/asm/alternative.h b/arch/parisc/include/asm/alternative.h
index 1ed45fd085d3..1eb488f25b83 100644
--- a/arch/parisc/include/asm/alternative.h
+++ b/arch/parisc/include/asm/alternative.h
@@ -34,7 +34,8 @@ void apply_alternatives(struct alt_instr *start, struct alt_instr *end,
 
 /* Alternative SMP implementation. */
 #define ALTERNATIVE(cond, replacement)		"!0:"	\
-	".section .altinstructions, \"aw\"	!"	\
+	".section .altinstructions, \"a\"	!"	\
+	".align 4				!"	\
 	".word (0b-4-.)				!"	\
 	".hword 1, " __stringify(cond) "	!"	\
 	".word " __stringify(replacement) "	!"	\
@@ -44,7 +45,8 @@ void apply_alternatives(struct alt_instr *start, struct alt_instr *end,
 
 /* to replace one single instructions by a new instruction */
 #define ALTERNATIVE(from, to, cond, replacement)\
-	.section .altinstructions, "aw"	!	\
+	.section .altinstructions, "a"	!	\
+	.align 4			!	\
 	.word (from - .)		!	\
 	.hword (to - from)/4, cond	!	\
 	.word replacement		!	\
@@ -52,7 +54,8 @@ void apply_alternatives(struct alt_instr *start, struct alt_instr *end,
 
 /* to replace multiple instructions by new code */
 #define ALTERNATIVE_CODE(from, num_instructions, cond, new_instr_ptr)\
-	.section .altinstructions, "aw"	!	\
+	.section .altinstructions, "a"	!	\
+	.align 4			!	\
 	.word (from - .)		!	\
 	.hword -num_instructions, cond	!	\
 	.word (new_instr_ptr - .)	!	\
diff --git a/arch/parisc/include/asm/assembly.h b/arch/parisc/include/asm/assembly.h
index 75677b526b2b..74d17d7e759d 100644
--- a/arch/parisc/include/asm/assembly.h
+++ b/arch/parisc/include/asm/assembly.h
@@ -574,6 +574,7 @@
 	 */
 #define ASM_EXCEPTIONTABLE_ENTRY(fault_addr, except_addr)	\
 	.section __ex_table,"aw"			!	\
+	.align 4					!	\
 	.word (fault_addr - .), (except_addr - .)	!	\
 	.previous
 
diff --git a/arch/parisc/include/asm/bug.h b/arch/parisc/include/asm/bug.h
index 4b6d60b94124..b9cad0bb4461 100644
--- a/arch/parisc/include/asm/bug.h
+++ b/arch/parisc/include/asm/bug.h
@@ -28,13 +28,15 @@
 	do {								\
 		asm volatile("\n"					\
 			     "1:\t" PARISC_BUG_BREAK_ASM "\n"		\
-			     "\t.pushsection __bug_table,\"aw\"\n"	\
+			     "\t.pushsection __bug_table,\"a\"\n"	\
+			     "\t.align %4\n"				\
 			     "2:\t" ASM_WORD_INSN "1b, %c0\n"		\
-			     "\t.short %c1, %c2\n"			\
-			     "\t.org 2b+%c3\n"				\
+			     "\t.short %1, %2\n"			\
+			     "\t.blockz %3-2*%4-2*2\n"			\
 			     "\t.popsection"				\
 			     : : "i" (__FILE__), "i" (__LINE__),	\
-			     "i" (0), "i" (sizeof(struct bug_entry)) ); \
+			     "i" (0), "i" (sizeof(struct bug_entry)),	\
+			     "i" (sizeof(long)) );			\
 		unreachable();						\
 	} while(0)
 
@@ -51,27 +53,31 @@
 	do {								\
 		asm volatile("\n"					\
 			     "1:\t" PARISC_BUG_BREAK_ASM "\n"		\
-			     "\t.pushsection __bug_table,\"aw\"\n"	\
+			     "\t.pushsection __bug_table,\"a\"\n"	\
+			     "\t.align %4\n"				\
 			     "2:\t" ASM_WORD_INSN "1b, %c0\n"		\
-			     "\t.short %c1, %c2\n"			\
-			     "\t.org 2b+%c3\n"				\
+			     "\t.short %1, %2\n"			\
+			     "\t.blockz %3-2*%4-2*2\n"			\
 			     "\t.popsection"				\
 			     : : "i" (__FILE__), "i" (__LINE__),	\
 			     "i" (BUGFLAG_WARNING|(flags)),		\
-			     "i" (sizeof(struct bug_entry)) );		\
+			     "i" (sizeof(struct bug_entry)),		\
+			     "i" (sizeof(long)) );			\
 	} while(0)
 #else
 #define __WARN_FLAGS(flags)						\
 	do {								\
 		asm volatile("\n"					\
 			     "1:\t" PARISC_BUG_BREAK_ASM "\n"		\
-			     "\t.pushsection __bug_table,\"aw\"\n"	\
+			     "\t.pushsection __bug_table,\"a\"\n"	\
+			     "\t.align %2\n"				\
 			     "2:\t" ASM_WORD_INSN "1b\n"		\
-			     "\t.short %c0\n"				\
-			     "\t.org 2b+%c1\n"				\
+			     "\t.short %0\n"				\
+			     "\t.blockz %1-%2-2\n"			\
 			     "\t.popsection"				\
 			     : : "i" (BUGFLAG_WARNING|(flags)),		\
-			     "i" (sizeof(struct bug_entry)) );		\
+			     "i" (sizeof(struct bug_entry)),		\
+			     "i" (sizeof(long)) );			\
 	} while(0)
 #endif
 
diff --git a/arch/parisc/include/asm/jump_label.h b/arch/parisc/include/asm/jump_label.h
index af2a598bc0f8..94428798b6aa 100644
--- a/arch/parisc/include/asm/jump_label.h
+++ b/arch/parisc/include/asm/jump_label.h
@@ -15,10 +15,12 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
 	asm_volatile_goto("1:\n\t"
 		 "nop\n\t"
 		 ".pushsection __jump_table,  \"aw\"\n\t"
+		 ".align %1\n\t"
 		 ".word 1b - ., %l[l_yes] - .\n\t"
 		 __stringify(ASM_ULONG_INSN) " %c0 - .\n\t"
 		 ".popsection\n\t"
-		 : :  "i" (&((char *)key)[branch]) :  : l_yes);
+		 : : "i" (&((char *)key)[branch]), "i" (sizeof(long))
+		 : : l_yes);
 
 	return false;
 l_yes:
@@ -30,10 +32,12 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 	asm_volatile_goto("1:\n\t"
 		 "b,n %l[l_yes]\n\t"
 		 ".pushsection __jump_table,  \"aw\"\n\t"
+		 ".align %1\n\t"
 		 ".word 1b - ., %l[l_yes] - .\n\t"
 		 __stringify(ASM_ULONG_INSN) " %c0 - .\n\t"
 		 ".popsection\n\t"
-		 : :  "i" (&((char *)key)[branch]) :  : l_yes);
+		 : : "i" (&((char *)key)[branch]), "i" (sizeof(long))
+		 : : l_yes);
 
 	return false;
 l_yes:
diff --git a/arch/parisc/include/asm/ldcw.h b/arch/parisc/include/asm/ldcw.h
index ee9e071859b2..47ebc4c91eaf 100644
--- a/arch/parisc/include/asm/ldcw.h
+++ b/arch/parisc/include/asm/ldcw.h
@@ -55,7 +55,7 @@
 })
 
 #ifdef CONFIG_SMP
-# define __lock_aligned __section(".data..lock_aligned")
+# define __lock_aligned __section(".data..lock_aligned") __aligned(16)
 #endif
 
 #endif /* __PARISC_LDCW_H */
diff --git a/arch/parisc/include/asm/uaccess.h b/arch/parisc/include/asm/uaccess.h
index 2bf660eabe42..4165079898d9 100644
--- a/arch/parisc/include/asm/uaccess.h
+++ b/arch/parisc/include/asm/uaccess.h
@@ -41,6 +41,7 @@ struct exception_table_entry {
 
 #define ASM_EXCEPTIONTABLE_ENTRY( fault_addr, except_addr )\
 	".section __ex_table,\"aw\"\n"			   \
+	".align 4\n"					   \
 	".word (" #fault_addr " - .), (" #except_addr " - .)\n\t" \
 	".previous\n"
 
diff --git a/arch/parisc/include/uapi/asm/errno.h b/arch/parisc/include/uapi/asm/errno.h
index 87245c584784..8d94739d75c6 100644
--- a/arch/parisc/include/uapi/asm/errno.h
+++ b/arch/parisc/include/uapi/asm/errno.h
@@ -75,7 +75,6 @@
 
 /* We now return you to your regularly scheduled HPUX. */
 
-#define ENOSYM		215	/* symbol does not exist in executable */
 #define	ENOTSOCK	216	/* Socket operation on non-socket */
 #define	EDESTADDRREQ	217	/* Destination address required */
 #define	EMSGSIZE	218	/* Message too long */
@@ -101,7 +100,6 @@
 #define	ETIMEDOUT	238	/* Connection timed out */
 #define	ECONNREFUSED	239	/* Connection refused */
 #define	EREFUSED	ECONNREFUSED	/* for HP's NFS apparently */
-#define	EREMOTERELEASE	240	/* Remote peer released connection */
 #define	EHOSTDOWN	241	/* Host is down */
 #define	EHOSTUNREACH	242	/* No route to host */
 
diff --git a/arch/parisc/kernel/vmlinux.lds.S b/arch/parisc/kernel/vmlinux.lds.S
index 58694d1989c2..548051b0b4af 100644
--- a/arch/parisc/kernel/vmlinux.lds.S
+++ b/arch/parisc/kernel/vmlinux.lds.S
@@ -130,6 +130,7 @@ SECTIONS
 	RO_DATA(8)
 
 	/* unwind info */
+	. = ALIGN(4);
 	.PARISC.unwind : {
 		__start___unwind = .;
 		*(.PARISC.unwind)
diff --git a/arch/powerpc/kernel/fpu.S b/arch/powerpc/kernel/fpu.S
index 6a9acfb690c9..2f8f3f93cbb6 100644
--- a/arch/powerpc/kernel/fpu.S
+++ b/arch/powerpc/kernel/fpu.S
@@ -23,6 +23,15 @@
 #include <asm/feature-fixups.h>
 
 #ifdef CONFIG_VSX
+#define __REST_1FPVSR(n,c,base)						\
+BEGIN_FTR_SECTION							\
+	b	2f;							\
+END_FTR_SECTION_IFSET(CPU_FTR_VSX);					\
+	REST_FPR(n,base);						\
+	b	3f;							\
+2:	REST_VSR(n,c,base);						\
+3:
+
 #define __REST_32FPVSRS(n,c,base)					\
 BEGIN_FTR_SECTION							\
 	b	2f;							\
@@ -41,9 +50,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX);					\
 2:	SAVE_32VSRS(n,c,base);						\
 3:
 #else
+#define __REST_1FPVSR(n,b,base)		REST_FPR(n, base)
 #define __REST_32FPVSRS(n,b,base)	REST_32FPRS(n, base)
 #define __SAVE_32FPVSRS(n,b,base)	SAVE_32FPRS(n, base)
 #endif
+#define REST_1FPVSR(n,c,base)   __REST_1FPVSR(n,__REG_##c,__REG_##base)
 #define REST_32FPVSRS(n,c,base) __REST_32FPVSRS(n,__REG_##c,__REG_##base)
 #define SAVE_32FPVSRS(n,c,base) __SAVE_32FPVSRS(n,__REG_##c,__REG_##base)
 
@@ -67,6 +78,7 @@ _GLOBAL(store_fp_state)
 	SAVE_32FPVSRS(0, R4, R3)
 	mffs	fr0
 	stfd	fr0,FPSTATE_FPSCR(r3)
+	REST_1FPVSR(0, R4, R3)
 	blr
 EXPORT_SYMBOL(store_fp_state)
 
@@ -138,4 +150,5 @@ _GLOBAL(save_fpu)
 2:	SAVE_32FPVSRS(0, R4, R6)
 	mffs	fr0
 	stfd	fr0,FPSTATE_FPSCR(r6)
+	REST_1FPVSR(0, R4, R6)
 	blr
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 392404688cec..9452a54d356c 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1198,11 +1198,11 @@ void kvmppc_save_user_regs(void)
 
 	usermsr = current->thread.regs->msr;
 
+	/* Caller has enabled FP/VEC/VSX/TM in MSR */
 	if (usermsr & MSR_FP)
-		save_fpu(current);
-
+		__giveup_fpu(current);
 	if (usermsr & MSR_VEC)
-		save_altivec(current);
+		__giveup_altivec(current);
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	if (usermsr & MSR_TM) {
diff --git a/arch/powerpc/kernel/vector.S b/arch/powerpc/kernel/vector.S
index 4094e4c4c77a..80b3f6e476b6 100644
--- a/arch/powerpc/kernel/vector.S
+++ b/arch/powerpc/kernel/vector.S
@@ -33,6 +33,7 @@ _GLOBAL(store_vr_state)
 	mfvscr	v0
 	li	r4, VRSTATE_VSCR
 	stvx	v0, r4, r3
+	lvx	v0, 0, r3
 	blr
 EXPORT_SYMBOL(store_vr_state)
 
@@ -109,6 +110,7 @@ _GLOBAL(save_altivec)
 	mfvscr	v0
 	li	r4,VRSTATE_VSCR
 	stvx	v0,r4,r7
+	lvx	v0,0,r7
 	blr
 
 #ifdef CONFIG_VSX
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 16d93b580f61..496e16c588aa 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -914,7 +914,8 @@ static int remove_ddw(struct device_node *np, bool remove_prop, const char *win_
 	return 0;
 }
 
-static bool find_existing_ddw(struct device_node *pdn, u64 *dma_addr, int *window_shift)
+static bool find_existing_ddw(struct device_node *pdn, u64 *dma_addr, int *window_shift,
+			      bool *direct_mapping)
 {
 	struct dma_win *window;
 	const struct dynamic_dma_window_prop *dma64;
@@ -927,6 +928,7 @@ static bool find_existing_ddw(struct device_node *pdn, u64 *dma_addr, int *windo
 			dma64 = window->prop;
 			*dma_addr = be64_to_cpu(dma64->dma_base);
 			*window_shift = be32_to_cpu(dma64->window_shift);
+			*direct_mapping = window->direct;
 			found = true;
 			break;
 		}
@@ -1270,10 +1272,8 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 
 	mutex_lock(&dma_win_init_mutex);
 
-	if (find_existing_ddw(pdn, &dev->dev.archdata.dma_offset, &len)) {
-		direct_mapping = (len >= max_ram_len);
+	if (find_existing_ddw(pdn, &dev->dev.archdata.dma_offset, &len, &direct_mapping))
 		goto out_unlock;
-	}
 
 	/*
 	 * If we already went through this for a previous function of
diff --git a/arch/s390/mm/page-states.c b/arch/s390/mm/page-states.c
index 00e7b0876dc5..79a037f49f70 100644
--- a/arch/s390/mm/page-states.c
+++ b/arch/s390/mm/page-states.c
@@ -181,6 +181,12 @@ void __init cmma_init_nodat(void)
 		return;
 	/* Mark pages used in kernel page tables */
 	mark_kernel_pgd();
+	page = virt_to_page(&swapper_pg_dir);
+	for (i = 0; i < 4; i++)
+		set_bit(PG_arch_1, &page[i].flags);
+	page = virt_to_page(&invalid_pg_dir);
+	for (i = 0; i < 4; i++)
+		set_bit(PG_arch_1, &page[i].flags);
 
 	/* Set all kernel pages not used for page tables to stable/no-dat */
 	for_each_mem_pfn_range(i, MAX_NUMNODES, &start, &end, NULL) {
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 0337392a3121..3c61bb98c10e 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -33,9 +33,12 @@ EXPORT_SYMBOL_GPL(hypercall_page);
  * and xen_vcpu_setup for details. By default it points to share_info->vcpu_info
  * but during boot it is switched to point to xen_vcpu_info.
  * The pointer is used in xen_evtchn_do_upcall to acknowledge pending events.
+ * Make sure that xen_vcpu_info doesn't cross a page boundary by making it
+ * cache-line aligned (the struct is guaranteed to have a size of 64 bytes,
+ * which matches the cache line size of 64-bit x86 processors).
  */
 DEFINE_PER_CPU(struct vcpu_info *, xen_vcpu);
-DEFINE_PER_CPU(struct vcpu_info, xen_vcpu_info);
+DEFINE_PER_CPU_ALIGNED(struct vcpu_info, xen_vcpu_info);
 
 /* Linux <-> Xen vCPU id mapping */
 DEFINE_PER_CPU(uint32_t, xen_vcpu_id);
@@ -160,6 +163,7 @@ void xen_vcpu_setup(int cpu)
 	int err;
 	struct vcpu_info *vcpup;
 
+	BUILD_BUG_ON(sizeof(*vcpup) > SMP_CACHE_BYTES);
 	BUG_ON(HYPERVISOR_shared_info == &xen_dummy_shared_info);
 
 	/*
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index 408a2aa66c69..a87ab36889e7 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -21,7 +21,7 @@ extern void *xen_initial_gdt;
 struct trap_info;
 void xen_copy_trap_info(struct trap_info *traps);
 
-DECLARE_PER_CPU(struct vcpu_info, xen_vcpu_info);
+DECLARE_PER_CPU_ALIGNED(struct vcpu_info, xen_vcpu_info);
 DECLARE_PER_CPU(unsigned long, xen_cr3);
 DECLARE_PER_CPU(unsigned long, xen_current_cr3);
 
diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 4e868454b38d..35f071ad9532 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -253,8 +253,7 @@ static const struct backlight_ops acpi_backlight_ops = {
 static int video_get_max_state(struct thermal_cooling_device *cooling_dev,
 			       unsigned long *state)
 {
-	struct acpi_device *device = cooling_dev->devdata;
-	struct acpi_video_device *video = acpi_driver_data(device);
+	struct acpi_video_device *video = cooling_dev->devdata;
 
 	*state = video->brightness->count - ACPI_VIDEO_FIRST_LEVEL - 1;
 	return 0;
@@ -263,8 +262,7 @@ static int video_get_max_state(struct thermal_cooling_device *cooling_dev,
 static int video_get_cur_state(struct thermal_cooling_device *cooling_dev,
 			       unsigned long *state)
 {
-	struct acpi_device *device = cooling_dev->devdata;
-	struct acpi_video_device *video = acpi_driver_data(device);
+	struct acpi_video_device *video = cooling_dev->devdata;
 	unsigned long long level;
 	int offset;
 
@@ -283,8 +281,7 @@ static int video_get_cur_state(struct thermal_cooling_device *cooling_dev,
 static int
 video_set_cur_state(struct thermal_cooling_device *cooling_dev, unsigned long state)
 {
-	struct acpi_device *device = cooling_dev->devdata;
-	struct acpi_video_device *video = acpi_driver_data(device);
+	struct acpi_video_device *video = cooling_dev->devdata;
 	int level;
 
 	if (state >= video->brightness->count - ACPI_VIDEO_FIRST_LEVEL)
@@ -1125,7 +1122,6 @@ static int acpi_video_bus_get_one_device(struct acpi_device *device, void *arg)
 
 	strcpy(acpi_device_name(device), ACPI_VIDEO_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
-	device->driver_data = data;
 
 	data->device_id = device_id;
 	data->video = video;
@@ -1747,8 +1743,8 @@ static void acpi_video_dev_register_backlight(struct acpi_video_device *device)
 	device->backlight->props.brightness =
 			acpi_video_get_brightness(device->backlight);
 
-	device->cooling_dev = thermal_cooling_device_register("LCD",
-				device->dev, &video_cooling_ops);
+	device->cooling_dev = thermal_cooling_device_register("LCD", device,
+							      &video_cooling_ops);
 	if (IS_ERR(device->cooling_dev)) {
 		/*
 		 * Set cooling_dev to NULL so we don't crash trying to free it.
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 691d4b7686ee..1d249d0f61ae 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1568,17 +1568,22 @@ static const struct iommu_ops *acpi_iommu_configure_id(struct device *dev,
 	int err;
 	const struct iommu_ops *ops;
 
+	/* Serialise to make dev->iommu stable under our potential fwspec */
+	mutex_lock(&iommu_probe_device_lock);
 	/*
 	 * If we already translated the fwspec there is nothing left to do,
 	 * return the iommu_ops.
 	 */
 	ops = acpi_iommu_fwspec_ops(dev);
-	if (ops)
+	if (ops) {
+		mutex_unlock(&iommu_probe_device_lock);
 		return ops;
+	}
 
 	err = iort_iommu_configure_id(dev, id_in);
 	if (err && err != -EPROBE_DEFER)
 		err = viot_iommu_configure(dev);
+	mutex_unlock(&iommu_probe_device_lock);
 
 	/*
 	 * If we have reason to believe the IOMMU driver missed the initial
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 3a957c4da409..4209fb39f644 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1055,9 +1055,14 @@ int ata_scsi_dev_config(struct scsi_device *sdev, struct ata_device *dev)
 		 * Ask the sd driver to issue START STOP UNIT on runtime suspend
 		 * and resume and shutdown only. For system level suspend/resume,
 		 * devices power state is handled directly by libata EH.
+		 * Given that disks are always spun up on system resume, also
+		 * make sure that the sd driver forces runtime suspended disks
+		 * to be resumed to correctly reflect the power state of the
+		 * device.
 		 */
-		sdev->manage_runtime_start_stop = true;
-		sdev->manage_shutdown = true;
+		sdev->manage_runtime_start_stop = 1;
+		sdev->manage_shutdown = 1;
+		sdev->force_runtime_start_on_system_start = 1;
 	}
 
 	/*
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9a1e194d5cf8..1f6186475715 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -307,11 +307,11 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
 		highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
 
 	WRITE_ONCE(cpudata->highest_perf, highest_perf);
-
+	WRITE_ONCE(cpudata->max_limit_perf, highest_perf);
 	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
 	WRITE_ONCE(cpudata->lowest_perf, AMD_CPPC_LOWEST_PERF(cap1));
-
+	WRITE_ONCE(cpudata->min_limit_perf, AMD_CPPC_LOWEST_PERF(cap1));
 	return 0;
 }
 
@@ -329,11 +329,12 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
 		highest_perf = cppc_perf.highest_perf;
 
 	WRITE_ONCE(cpudata->highest_perf, highest_perf);
-
+	WRITE_ONCE(cpudata->max_limit_perf, highest_perf);
 	WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
 		   cppc_perf.lowest_nonlinear_perf);
 	WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
+	WRITE_ONCE(cpudata->min_limit_perf, cppc_perf.lowest_perf);
 
 	if (cppc_state == AMD_PSTATE_ACTIVE)
 		return 0;
@@ -432,6 +433,10 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
 	u64 value = prev;
 
+	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
+			cpudata->max_limit_perf);
+	max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,
+			cpudata->max_limit_perf);
 	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
 
 	if ((cppc_state == AMD_PSTATE_GUIDED) && (gov_flags & CPUFREQ_GOV_DYNAMIC_SWITCHING)) {
@@ -470,6 +475,22 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy)
 	return 0;
 }
 
+static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
+{
+	u32 max_limit_perf, min_limit_perf;
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	max_limit_perf = div_u64(policy->max * cpudata->highest_perf, cpudata->max_freq);
+	min_limit_perf = div_u64(policy->min * cpudata->highest_perf, cpudata->max_freq);
+
+	WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
+	WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
+	WRITE_ONCE(cpudata->max_limit_freq, policy->max);
+	WRITE_ONCE(cpudata->min_limit_freq, policy->min);
+
+	return 0;
+}
+
 static int amd_pstate_update_freq(struct cpufreq_policy *policy,
 				  unsigned int target_freq, bool fast_switch)
 {
@@ -480,6 +501,9 @@ static int amd_pstate_update_freq(struct cpufreq_policy *policy,
 	if (!cpudata->max_freq)
 		return -ENODEV;
 
+	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
+		amd_pstate_update_min_max_limit(policy);
+
 	cap_perf = READ_ONCE(cpudata->highest_perf);
 	min_perf = READ_ONCE(cpudata->lowest_perf);
 	max_perf = cap_perf;
@@ -518,7 +542,9 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
 static unsigned int amd_pstate_fast_switch(struct cpufreq_policy *policy,
 				  unsigned int target_freq)
 {
-	return amd_pstate_update_freq(policy, target_freq, true);
+	if (!amd_pstate_update_freq(policy, target_freq, true))
+		return target_freq;
+	return policy->cur;
 }
 
 static void amd_pstate_adjust_perf(unsigned int cpu,
@@ -532,6 +558,10 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	struct amd_cpudata *cpudata = policy->driver_data;
 	unsigned int target_freq;
 
+	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
+		amd_pstate_update_min_max_limit(policy);
+
+
 	cap_perf = READ_ONCE(cpudata->highest_perf);
 	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
 	max_freq = READ_ONCE(cpudata->max_freq);
@@ -745,6 +775,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	/* Initial processor data capability frequencies */
 	cpudata->max_freq = max_freq;
 	cpudata->min_freq = min_freq;
+	cpudata->max_limit_freq = max_freq;
+	cpudata->min_limit_freq = min_freq;
 	cpudata->nominal_freq = nominal_freq;
 	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
 
@@ -850,11 +882,16 @@ static ssize_t show_energy_performance_available_preferences(
 {
 	int i = 0;
 	int offset = 0;
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
+		return sysfs_emit_at(buf, offset, "%s\n",
+				energy_perf_strings[EPP_INDEX_PERFORMANCE]);
 
 	while (energy_perf_strings[i] != NULL)
 		offset += sysfs_emit_at(buf, offset, "%s ", energy_perf_strings[i++]);
 
-	sysfs_emit_at(buf, offset, "\n");
+	offset += sysfs_emit_at(buf, offset, "\n");
 
 	return offset;
 }
@@ -1183,16 +1220,25 @@ static int amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static void amd_pstate_epp_init(unsigned int cpu)
+static void amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 {
-	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
 	struct amd_cpudata *cpudata = policy->driver_data;
-	u32 max_perf, min_perf;
+	u32 max_perf, min_perf, min_limit_perf, max_limit_perf;
 	u64 value;
 	s16 epp;
 
 	max_perf = READ_ONCE(cpudata->highest_perf);
 	min_perf = READ_ONCE(cpudata->lowest_perf);
+	max_limit_perf = div_u64(policy->max * cpudata->highest_perf, cpudata->max_freq);
+	min_limit_perf = div_u64(policy->min * cpudata->highest_perf, cpudata->max_freq);
+
+	max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,
+			cpudata->max_limit_perf);
+	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
+			cpudata->max_limit_perf);
+
+	WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
+	WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
 
 	value = READ_ONCE(cpudata->cppc_req_cached);
 
@@ -1210,9 +1256,6 @@ static void amd_pstate_epp_init(unsigned int cpu)
 	value &= ~AMD_CPPC_DES_PERF(~0L);
 	value |= AMD_CPPC_DES_PERF(0);
 
-	if (cpudata->epp_policy == cpudata->policy)
-		goto skip_epp;
-
 	cpudata->epp_policy = cpudata->policy;
 
 	/* Get BIOS pre-defined epp value */
@@ -1222,7 +1265,7 @@ static void amd_pstate_epp_init(unsigned int cpu)
 		 * This return value can only be negative for shared_memory
 		 * systems where EPP register read/write not supported.
 		 */
-		goto skip_epp;
+		return;
 	}
 
 	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
@@ -1236,8 +1279,6 @@ static void amd_pstate_epp_init(unsigned int cpu)
 
 	WRITE_ONCE(cpudata->cppc_req_cached, value);
 	amd_pstate_set_epp(cpudata, epp);
-skip_epp:
-	cpufreq_cpu_put(policy);
 }
 
 static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
@@ -1252,7 +1293,7 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 
 	cpudata->policy = policy->policy;
 
-	amd_pstate_epp_init(policy->cpu);
+	amd_pstate_epp_update_limit(policy);
 
 	return 0;
 }
diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 494d044b9e72..33728c242f66 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -327,7 +327,7 @@ static int imx6ul_opp_check_speed_grading(struct device *dev)
 			imx6x_disable_freq_in_opp(dev, 696000000);
 
 	if (of_machine_is_compatible("fsl,imx6ull")) {
-		if (val != OCOTP_CFG3_6ULL_SPEED_792MHZ)
+		if (val < OCOTP_CFG3_6ULL_SPEED_792MHZ)
 			imx6x_disable_freq_in_opp(dev, 792000000);
 
 		if (val != OCOTP_CFG3_6ULL_SPEED_900MHZ)
diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
index 38b4110378de..eb8b733065b2 100644
--- a/drivers/dma-buf/dma-resv.c
+++ b/drivers/dma-buf/dma-resv.c
@@ -301,7 +301,7 @@ void dma_resv_add_fence(struct dma_resv *obj, struct dma_fence *fence,
 
 		dma_resv_list_entry(fobj, i, obj, &old, &old_usage);
 		if ((old->context == fence->context && old_usage >= usage &&
-		     dma_fence_is_later(fence, old)) ||
+		     dma_fence_is_later_or_same(fence, old)) ||
 		    dma_fence_is_signaled(old)) {
 			dma_resv_list_set(fobj, i, fence, usage);
 			dma_fence_put(old);
diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index aa597cda0d88..2828e9573e90 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -717,14 +717,11 @@ static void create_units(struct fw_device *device)
 					fw_unit_attributes,
 					&unit->attribute_group);
 
-		if (device_register(&unit->device) < 0)
-			goto skip_unit;
-
 		fw_device_get(device);
-		continue;
-
-	skip_unit:
-		kfree(unit);
+		if (device_register(&unit->device) < 0) {
+			put_device(&unit->device);
+			continue;
+		}
 	}
 }
 
diff --git a/drivers/firewire/sbp2.c b/drivers/firewire/sbp2.c
index 7edf2c95282f..e779d866022b 100644
--- a/drivers/firewire/sbp2.c
+++ b/drivers/firewire/sbp2.c
@@ -1519,9 +1519,9 @@ static int sbp2_scsi_slave_configure(struct scsi_device *sdev)
 	sdev->use_10_for_rw = 1;
 
 	if (sbp2_param_exclusive_login) {
-		sdev->manage_system_start_stop = true;
-		sdev->manage_runtime_start_stop = true;
-		sdev->manage_shutdown = true;
+		sdev->manage_system_start_stop = 1;
+		sdev->manage_runtime_start_stop = 1;
+		sdev->manage_shutdown = 1;
 	}
 
 	if (sdev->type == TYPE_ROM)
diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
index 135278ddaf62..79fb687bb90f 100644
--- a/drivers/firmware/efi/unaccepted_memory.c
+++ b/drivers/firmware/efi/unaccepted_memory.c
@@ -100,7 +100,7 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
 	 * overlap on physical address level.
 	 */
 	list_for_each_entry(entry, &accepting_list, list) {
-		if (entry->end < range.start)
+		if (entry->end <= range.start)
 			continue;
 		if (entry->start >= range.end)
 			continue;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 363e6a2cad8c..578aeba49ea8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -340,14 +340,11 @@ int amdgpu_display_crtc_set_config(struct drm_mode_set *set,
 		adev->have_disp_power_ref = true;
 		return ret;
 	}
-	/* if we have no active crtcs, then drop the power ref
-	 * we got before
+	/* if we have no active crtcs, then go to
+	 * drop the power ref we got before
 	 */
-	if (!active && adev->have_disp_power_ref) {
-		pm_runtime_put_autosuspend(dev->dev);
+	if (!active && adev->have_disp_power_ref)
 		adev->have_disp_power_ref = false;
-	}
-
 out:
 	/* drop the power reference we got coming in here */
 	pm_runtime_put_autosuspend(dev->dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 81edf66dbea8..2c35036e4ba2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2195,6 +2195,8 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 		pm_runtime_mark_last_busy(ddev->dev);
 		pm_runtime_put_autosuspend(ddev->dev);
 
+		pci_wake_from_d3(pdev, TRUE);
+
 		/*
 		 * For runpm implemented via BACO, PMFW will handle the
 		 * timing for BACO in and out:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 595d5e535aca..9d82701d365b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -214,6 +214,12 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
 			control->i2c_address = EEPROM_I2C_MADDR_0;
 		return true;
 	case IP_VERSION(13, 0, 0):
+		if (strnstr(atom_ctx->vbios_pn, "D707",
+			    sizeof(atom_ctx->vbios_pn)))
+			control->i2c_address = EEPROM_I2C_MADDR_0;
+		else
+			control->i2c_address = EEPROM_I2C_MADDR_4;
+		return true;
 	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 10):
 		control->i2c_address = EEPROM_I2C_MADDR_4;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 43d066bc5245..b346eb0a0db1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -83,6 +83,10 @@ MODULE_FIRMWARE("amdgpu/gc_11_0_4_me.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_4_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_4_rlc.bin");
 
+static const struct soc15_reg_golden golden_settings_gc_11_0[] = {
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CNTL, 0x20000000, 0x20000000)
+};
+
 static const struct soc15_reg_golden golden_settings_gc_11_0_1[] =
 {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, regCGTT_GS_NGG_CLK_CTRL, 0x9fff8fff, 0x00000010),
@@ -275,6 +279,10 @@ static void gfx_v11_0_init_golden_registers(struct amdgpu_device *adev)
 	default:
 		break;
 	}
+	soc15_program_register_sequence(adev,
+					golden_settings_gc_11_0,
+					(const u32)ARRAY_SIZE(golden_settings_gc_11_0));
+
 }
 
 static void gfx_v11_0_write_data_to_reg(struct amdgpu_ring *ring, int eng_sel,
@@ -390,7 +398,7 @@ static int gfx_v11_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
 		cpu_ptr = &adev->wb.wb[index];
 
-		r = amdgpu_ib_get(adev, NULL, 16, AMDGPU_IB_POOL_DIRECT, &ib);
+		r = amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
 		if (r) {
 			DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
 			goto err1;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 885ebd703260..1943beb135c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -883,8 +883,8 @@ static int gfx_v8_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
 	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 16,
-					AMDGPU_IB_POOL_DIRECT, &ib);
+
+	r = amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
 	if (r)
 		goto err1;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index fd61574a737c..2e23d08b45f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1039,8 +1039,8 @@ static int gfx_v9_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
 	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 16,
-					AMDGPU_IB_POOL_DIRECT, &ib);
+
+	r = amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
 	if (r)
 		goto err1;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 18ce5fe45f6f..e481ef73af6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -296,8 +296,8 @@ static int gfx_v9_4_3_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
 	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 16,
-			  AMDGPU_IB_POOL_DIRECT, &ib);
+
+	r = amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
 	if (r)
 		goto err1;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index deedcd997845..f5fdb61c821d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6236,7 +6236,7 @@ int amdgpu_dm_connector_atomic_set_property(struct drm_connector *connector,
 		dm_new_state->underscan_enable = val;
 		ret = 0;
 	} else if (property == adev->mode_info.abm_level_property) {
-		dm_new_state->abm_level = val;
+		dm_new_state->abm_level = val ?: ABM_LEVEL_IMMEDIATE_DISABLE;
 		ret = 0;
 	}
 
@@ -6281,7 +6281,8 @@ int amdgpu_dm_connector_atomic_get_property(struct drm_connector *connector,
 		*val = dm_state->underscan_enable;
 		ret = 0;
 	} else if (property == adev->mode_info.abm_level_property) {
-		*val = dm_state->abm_level;
+		*val = (dm_state->abm_level != ABM_LEVEL_IMMEDIATE_DISABLE) ?
+			dm_state->abm_level : 0;
 		ret = 0;
 	}
 
@@ -6354,7 +6355,8 @@ void amdgpu_dm_connector_funcs_reset(struct drm_connector *connector)
 		state->pbn = 0;
 
 		if (connector->connector_type == DRM_MODE_CONNECTOR_eDP)
-			state->abm_level = amdgpu_dm_abm_level;
+			state->abm_level = amdgpu_dm_abm_level ?:
+				ABM_LEVEL_IMMEDIATE_DISABLE;
 
 		__drm_atomic_helper_connector_reset(connector, &state->base);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 186936ad283a..a1be93f6385c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5254,3 +5254,24 @@ void dc_query_current_properties(struct dc *dc, struct dc_current_properties *pr
 	properties->cursor_size_limit = subvp_in_use ? 64 : dc->caps.max_cursor_size;
 }
 
+/**
+ *****************************************************************************
+ * dc_set_edp_power() - DM controls eDP power to be ON/OFF
+ *
+ * Called when DM wants to power on/off eDP.
+ *     Only work on links with flag skip_implict_edp_power_control is set.
+ *
+ *****************************************************************************
+ */
+void dc_set_edp_power(const struct dc *dc, struct dc_link *edp_link,
+				 bool powerOn)
+{
+	if (edp_link->connector_signal != SIGNAL_TYPE_EDP)
+		return;
+
+	if (edp_link->skip_implict_edp_power_control == false)
+		return;
+
+	edp_link->dc->link_srv->edp_set_panel_power(edp_link, powerOn);
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c05e91b257ac..3f33740e2f65 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1538,7 +1538,6 @@ struct dc_link {
 	enum edp_revision edp_revision;
 	union dpcd_sink_ext_caps dpcd_sink_ext_caps;
 
-	struct backlight_settings backlight_settings;
 	struct psr_settings psr_settings;
 
 	struct replay_settings replay_settings;
@@ -1578,6 +1577,7 @@ struct dc_link {
 	struct phy_state phy_state;
 	// BW ALLOCATON USB4 ONLY
 	struct dc_dpia_bw_alloc dpia_bw_alloc_config;
+	bool skip_implict_edp_power_control;
 };
 
 /* Return an enumerated dc_link.
@@ -1597,6 +1597,9 @@ void dc_get_edp_links(const struct dc *dc,
 		struct dc_link **edp_links,
 		int *edp_num);
 
+void dc_set_edp_power(const struct dc *dc, struct dc_link *edp_link,
+				 bool powerOn);
+
 /* The function initiates detection handshake over the given link. It first
  * determines if there are display connections over the link. If so it initiates
  * detection protocols supported by the connected receiver device. The function
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 3697ea1d14c1..d5b3e3a32cc6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -302,7 +302,6 @@ struct dc_stream_state {
 	bool vblank_synchronized;
 	bool fpo_in_use;
 	struct mall_stream_config mall_stream_config;
-	bool skip_edp_power_down;
 };
 
 #define ABM_LEVEL_IMMEDIATE_DISABLE 255
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index ba900b0a62a8..accffba5a683 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1003,10 +1003,6 @@ struct link_mst_stream_allocation_table {
 	struct link_mst_stream_allocation stream_allocations[MAX_CONTROLLER_NUM];
 };
 
-struct backlight_settings {
-	uint32_t backlight_millinits;
-};
-
 /* PSR feature flags */
 struct psr_settings {
 	bool psr_feature_enabled;		// PSR is supported by sink
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 2a6157555fd1..9c78e42418f3 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1226,7 +1226,7 @@ void dce110_blank_stream(struct pipe_ctx *pipe_ctx)
 	struct dce_hwseq *hws = link->dc->hwseq;
 
 	if (link->local_sink && link->local_sink->sink_signal == SIGNAL_TYPE_EDP) {
-		if (!stream->skip_edp_power_down)
+		if (!link->skip_implict_edp_power_control)
 			hws->funcs.edp_backlight_control(link, false);
 		link->dc->hwss.set_abm_immediate_disable(pipe_ctx);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
index 4d2820ffe468..33a8626bda73 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
@@ -476,7 +476,8 @@ void dcn314_disable_link_output(struct dc_link *link,
 	struct dmcu *dmcu = dc->res_pool->dmcu;
 
 	if (signal == SIGNAL_TYPE_EDP &&
-			link->dc->hwss.edp_backlight_control)
+			link->dc->hwss.edp_backlight_control &&
+			!link->skip_implict_edp_power_control)
 		link->dc->hwss.edp_backlight_control(link, false);
 	else if (dmcu != NULL && dmcu->funcs->lock_phy)
 		dmcu->funcs->lock_phy(dmcu);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 004beed9bd44..3e65e683db0a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -869,7 +869,7 @@ static const struct dc_plane_cap plane_cap = {
 static const struct dc_debug_options debug_defaults_drv = {
 	.disable_z10 = false,
 	.enable_z9_disable_interface = true,
-	.minimum_z8_residency_time = 2000,
+	.minimum_z8_residency_time = 2100,
 	.psr_skip_crtc_disable = true,
 	.replay_skip_crtc_disabled = true,
 	.disable_dmcu = true,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index c9140b50c345..650e1598bddc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -486,8 +486,7 @@ bool dcn32_set_mcm_luts(
 		if (plane_state->blend_tf->type == TF_TYPE_HWPWL)
 			lut_params = &plane_state->blend_tf->pwl;
 		else if (plane_state->blend_tf->type == TF_TYPE_DISTRIBUTED_POINTS) {
-			cm_helper_translate_curve_to_hw_format(plane_state->ctx,
-					plane_state->blend_tf,
+			cm3_helper_translate_curve_to_hw_format(plane_state->blend_tf,
 					&dpp_base->regamma_params, false);
 			lut_params = &dpp_base->regamma_params;
 		}
@@ -501,8 +500,7 @@ bool dcn32_set_mcm_luts(
 		else if (plane_state->in_shaper_func->type == TF_TYPE_DISTRIBUTED_POINTS) {
 			// TODO: dpp_base replace
 			ASSERT(false);
-			cm_helper_translate_curve_to_hw_format(plane_state->ctx,
-					plane_state->in_shaper_func,
+			cm3_helper_translate_curve_to_hw_format(plane_state->in_shaper_func,
 					&dpp_base->shaper_params, true);
 			lut_params = &dpp_base->shaper_params;
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 5805fb02af14..f2de0c758494 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -948,10 +948,8 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 {
 	int plane_count;
 	int i;
-	unsigned int min_dst_y_next_start_us;
 
 	plane_count = 0;
-	min_dst_y_next_start_us = 0;
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		if (context->res_ctx.pipe_ctx[i].plane_state)
 			plane_count++;
@@ -973,26 +971,15 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 	else if (context->stream_count == 1 &&  context->streams[0]->signal == SIGNAL_TYPE_EDP) {
 		struct dc_link *link = context->streams[0]->sink->link;
 		struct dc_stream_status *stream_status = &context->stream_status[0];
-		struct dc_stream_state *current_stream = context->streams[0];
 		int minmum_z8_residency = dc->debug.minimum_z8_residency_time > 0 ? dc->debug.minimum_z8_residency_time : 1000;
 		bool allow_z8 = context->bw_ctx.dml.vba.StutterPeriod > (double)minmum_z8_residency;
 		bool is_pwrseq0 = link->link_index == 0;
-		bool isFreesyncVideo;
-
-		isFreesyncVideo = current_stream->adjust.v_total_min == current_stream->adjust.v_total_max;
-		isFreesyncVideo = isFreesyncVideo && current_stream->timing.v_total < current_stream->adjust.v_total_min;
-		for (i = 0; i < dc->res_pool->pipe_count; i++) {
-			if (context->res_ctx.pipe_ctx[i].stream == current_stream && isFreesyncVideo) {
-				min_dst_y_next_start_us = context->res_ctx.pipe_ctx[i].dlg_regs.min_dst_y_next_start_us;
-				break;
-			}
-		}
 
 		/* Don't support multi-plane configurations */
 		if (stream_status->plane_count > 1)
 			return DCN_ZSTATE_SUPPORT_DISALLOW;
 
-		if (is_pwrseq0 && (context->bw_ctx.dml.vba.StutterPeriod > 5000.0 || min_dst_y_next_start_us > 5000))
+		if (is_pwrseq0 && context->bw_ctx.dml.vba.StutterPeriod > 5000.0)
 			return DCN_ZSTATE_SUPPORT_ALLOW;
 		else if (is_pwrseq0 && link->psr_settings.psr_version == DC_PSR_VERSION_1 && !link->panel_config.psr.disable_psr)
 			return allow_z8 ? DCN_ZSTATE_SUPPORT_ALLOW_Z8_Z10_ONLY : DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 711d4085b33b..cf3b400c8619 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1964,6 +1964,7 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 	int i, pipe_idx, vlevel_temp = 0;
 	double dcfclk = dcn3_2_soc.clock_limits[0].dcfclk_mhz;
 	double dcfclk_from_validation = context->bw_ctx.dml.vba.DCFCLKState[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
+	double dram_speed_from_validation = context->bw_ctx.dml.vba.DRAMSpeed;
 	double dcfclk_from_fw_based_mclk_switching = dcfclk_from_validation;
 	bool pstate_en = context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] !=
 			dm_dram_clock_change_unsupported;
@@ -2151,7 +2152,7 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 	}
 
 	if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].valid) {
-		min_dram_speed_mts = context->bw_ctx.dml.vba.DRAMSpeed;
+		min_dram_speed_mts = dram_speed_from_validation;
 		min_dram_speed_mts_margin = 160;
 
 		context->bw_ctx.dml.soc.dram_clock_change_latency_us =
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link.h b/drivers/gpu/drm/amd/display/dc/inc/link.h
index e3e8c76c17cf..d7685368140a 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link.h
@@ -295,6 +295,7 @@ struct link_service {
 	bool (*edp_receiver_ready_T9)(struct dc_link *link);
 	bool (*edp_receiver_ready_T7)(struct dc_link *link);
 	bool (*edp_power_alpm_dpcd_enable)(struct dc_link *link, bool enable);
+	void (*edp_set_panel_power)(struct dc_link *link, bool powerOn);
 
 
 	/*************************** DP CTS ************************************/
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index e682d27e098f..c7a9e286a5d4 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -876,7 +876,7 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 			(link->dpcd_sink_ext_caps.bits.oled == 1)) {
 			dpcd_set_source_specific_data(link);
 			msleep(post_oui_delay);
-			set_cached_brightness_aux(link);
+			set_default_brightness_aux(link);
 		}
 
 		return true;
@@ -1166,6 +1166,12 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 			dm_helpers_init_panel_settings(dc_ctx, &link->panel_config, sink);
 			// Override dc_panel_config if system has specific settings
 			dm_helpers_override_panel_settings(dc_ctx, &link->panel_config);
+
+			//sink only can use supported link rate table, we are foreced to enable it
+			if (link->reported_link_cap.link_rate == LINK_RATE_UNKNOWN)
+				link->panel_config.ilr.optimize_edp_link_rate = true;
+			if (edp_is_ilr_optimization_enabled(link))
+				link->reported_link_cap.link_rate = get_max_link_rate_from_ilr_table(link);
 		}
 
 	} else {
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 79aef205598b..35d087cf1980 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -1930,7 +1930,7 @@ static void disable_link_dp(struct dc_link *link,
 	dp_disable_link_phy(link, link_res, signal);
 
 	if (link->connector_signal == SIGNAL_TYPE_EDP) {
-		if (!link->dc->config.edp_no_power_sequencing)
+		if (!link->skip_implict_edp_power_control)
 			link->dc->hwss.edp_power_control(link, false);
 	}
 
@@ -2140,8 +2140,7 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 	if (link->dpcd_sink_ext_caps.bits.oled == 1 ||
 		link->dpcd_sink_ext_caps.bits.sdr_aux_backlight_control == 1 ||
 		link->dpcd_sink_ext_caps.bits.hdr_aux_backlight_control == 1) {
-		set_cached_brightness_aux(link);
-
+		set_default_brightness_aux(link);
 		if (link->dpcd_sink_ext_caps.bits.oled == 1)
 			msleep(bl_oled_enable_delay);
 		edp_backlight_enable_aux(link, true);
@@ -2219,7 +2218,7 @@ static enum dc_status enable_link(
 	 * link settings. Need to call disable first before enabling at
 	 * new link settings.
 	 */
-	if (link->link_status.link_active && !stream->skip_edp_power_down)
+	if (link->link_status.link_active)
 		disable_link(link, &pipe_ctx->link_res, pipe_ctx->stream->signal);
 
 	switch (pipe_ctx->stream->signal) {
@@ -2338,9 +2337,7 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 		dc->hwss.disable_stream(pipe_ctx);
 	} else {
 		dc->hwss.disable_stream(pipe_ctx);
-		if (!pipe_ctx->stream->skip_edp_power_down) {
-			disable_link(pipe_ctx->stream->link, &pipe_ctx->link_res, pipe_ctx->stream->signal);
-		}
+		disable_link(pipe_ctx->stream->link, &pipe_ctx->link_res, pipe_ctx->stream->signal);
 	}
 
 	if (pipe_ctx->stream->timing.flags.DSC) {
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 0895742a3102..e406561c2c23 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -223,6 +223,7 @@ static void construct_link_service_edp_panel_control(struct link_service *link_s
 	link_srv->edp_receiver_ready_T9 = edp_receiver_ready_T9;
 	link_srv->edp_receiver_ready_T7 = edp_receiver_ready_T7;
 	link_srv->edp_power_alpm_dpcd_enable = edp_power_alpm_dpcd_enable;
+	link_srv->edp_set_panel_power = edp_set_panel_power;
 }
 
 /* link dp cts implements dp compliance test automation protocols and manual
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 237e0ff955f3..db87aa7b5c90 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -707,8 +707,7 @@ bool edp_decide_link_settings(struct dc_link *link,
 	 * edp_supported_link_rates_count is only valid for eDP v1.4 or higher.
 	 * Per VESA eDP spec, "The DPCD revision for eDP v1.4 is 13h"
 	 */
-	if (link->dpcd_caps.dpcd_rev.raw < DPCD_REV_13 ||
-			link->dpcd_caps.edp_supported_link_rates_count == 0) {
+	if (!edp_is_ilr_optimization_enabled(link)) {
 		*link_setting = link->verified_link_cap;
 		return true;
 	}
@@ -772,8 +771,7 @@ bool decide_edp_link_settings_with_dsc(struct dc_link *link,
 	 * edp_supported_link_rates_count is only valid for eDP v1.4 or higher.
 	 * Per VESA eDP spec, "The DPCD revision for eDP v1.4 is 13h"
 	 */
-	if ((link->dpcd_caps.dpcd_rev.raw < DPCD_REV_13 ||
-			link->dpcd_caps.edp_supported_link_rates_count == 0)) {
+	if (!edp_is_ilr_optimization_enabled(link)) {
 		/* for DSC enabled case, we search for minimum lane count */
 		memset(&initial_link_setting, 0, sizeof(initial_link_setting));
 		initial_link_setting.lane_count = LANE_COUNT_ONE;
@@ -1938,9 +1936,7 @@ void detect_edp_sink_caps(struct dc_link *link)
 	 * edp_supported_link_rates_count is only valid for eDP v1.4 or higher.
 	 * Per VESA eDP spec, "The DPCD revision for eDP v1.4 is 13h"
 	 */
-	if (link->dpcd_caps.dpcd_rev.raw >= DPCD_REV_13 &&
-			(link->panel_config.ilr.optimize_edp_link_rate ||
-			link->reported_link_cap.link_rate == LINK_RATE_UNKNOWN)) {
+	if (link->dpcd_caps.dpcd_rev.raw >= DPCD_REV_13) {
 		// Read DPCD 00010h - 0001Fh 16 bytes at one shot
 		core_link_read_dpcd(link, DP_SUPPORTED_LINK_RATES,
 							supported_link_rates, sizeof(supported_link_rates));
@@ -1958,12 +1954,10 @@ void detect_edp_sink_caps(struct dc_link *link)
 				link_rate = linkRateInKHzToLinkRateMultiplier(link_rate_in_khz);
 				link->dpcd_caps.edp_supported_link_rates[link->dpcd_caps.edp_supported_link_rates_count] = link_rate;
 				link->dpcd_caps.edp_supported_link_rates_count++;
-
-				if (link->reported_link_cap.link_rate < link_rate)
-					link->reported_link_cap.link_rate = link_rate;
 			}
 		}
 	}
+
 	core_link_read_dpcd(link, DP_EDP_BACKLIGHT_ADJUSTMENT_CAP,
 						&backlight_adj_cap, sizeof(backlight_adj_cap));
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
index b7abba55bc2f..0050e0a06cbc 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
@@ -73,7 +73,8 @@ void dp_disable_link_phy(struct dc_link *link,
 {
 	struct dc  *dc = link->ctx->dc;
 
-	if (!link->wa_flags.dp_keep_receiver_powered)
+	if (!link->wa_flags.dp_keep_receiver_powered &&
+		!link->skip_implict_edp_power_control)
 		dpcd_write_rx_power_ctrl(link, false);
 
 	dc->hwss.disable_link_output(link, link_res, signal);
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
index fd8f6f198146..68096d12f52f 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
@@ -115,7 +115,7 @@ static enum link_training_result perform_fixed_vs_pe_nontransparent_training_seq
 		lt_settings->cr_pattern_time = 16000;
 
 	/* Fixed VS/PE specific: Toggle link rate */
-	apply_toggle_rate_wa = (link->vendor_specific_lttpr_link_rate_wa == target_rate);
+	apply_toggle_rate_wa = ((link->vendor_specific_lttpr_link_rate_wa == target_rate) || (link->vendor_specific_lttpr_link_rate_wa == 0));
 	target_rate = get_dpcd_link_rate(&lt_settings->link_settings);
 	toggle_rate = (target_rate == 0x6) ? 0xA : 0x6;
 
@@ -271,7 +271,7 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence_legacy(
 	/* Vendor specific: Toggle link rate */
 	toggle_rate = (rate == 0x6) ? 0xA : 0x6;
 
-	if (link->vendor_specific_lttpr_link_rate_wa == rate) {
+	if (link->vendor_specific_lttpr_link_rate_wa == rate || link->vendor_specific_lttpr_link_rate_wa == 0) {
 		core_link_write_dpcd(
 				link,
 				DP_LINK_BW_SET,
@@ -617,7 +617,7 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence(
 	/* Vendor specific: Toggle link rate */
 	toggle_rate = (rate == 0x6) ? 0xA : 0x6;
 
-	if (link->vendor_specific_lttpr_link_rate_wa == rate) {
+	if (link->vendor_specific_lttpr_link_rate_wa == rate || link->vendor_specific_lttpr_link_rate_wa == 0) {
 		core_link_write_dpcd(
 				link,
 				DP_LINK_BW_SET,
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 98e715aa6d8e..fe74d4252a51 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -33,6 +33,7 @@
 #include "link_dp_capability.h"
 #include "dm_helpers.h"
 #include "dal_asic_id.h"
+#include "link_dp_phy.h"
 #include "dce/dmub_psr.h"
 #include "dc/dc_dmub_srv.h"
 #include "dce/dmub_replay.h"
@@ -167,7 +168,6 @@ bool edp_set_backlight_level_nits(struct dc_link *link,
 	*(uint32_t *)&dpcd_backlight_set.backlight_level_millinits = backlight_millinits;
 	*(uint16_t *)&dpcd_backlight_set.backlight_transition_time_ms = (uint16_t)transition_time_in_ms;
 
-	link->backlight_settings.backlight_millinits = backlight_millinits;
 
 	if (!link->dpcd_caps.panel_luminance_control) {
 		if (core_link_write_dpcd(link, DP_SOURCE_BACKLIGHT_LEVEL,
@@ -280,9 +280,9 @@ bool set_default_brightness_aux(struct dc_link *link)
 	if (link && link->dpcd_sink_ext_caps.bits.oled == 1) {
 		if (!read_default_bl_aux(link, &default_backlight))
 			default_backlight = 150000;
-		// if < 5 nits or > 5000, it might be wrong readback
-		if (default_backlight < 5000 || default_backlight > 5000000)
-			default_backlight = 150000; //
+		// if > 5000, it might be wrong readback
+		if (default_backlight > 5000000)
+			default_backlight = 150000;
 
 		return edp_set_backlight_level_nits(link, true,
 				default_backlight, 0);
@@ -290,14 +290,23 @@ bool set_default_brightness_aux(struct dc_link *link)
 	return false;
 }
 
-bool set_cached_brightness_aux(struct dc_link *link)
+bool edp_is_ilr_optimization_enabled(struct dc_link *link)
 {
-	if (link->backlight_settings.backlight_millinits)
-		return edp_set_backlight_level_nits(link, true,
-						    link->backlight_settings.backlight_millinits, 0);
-	else
-		return set_default_brightness_aux(link);
-	return false;
+	if (link->dpcd_caps.edp_supported_link_rates_count == 0 || !link->panel_config.ilr.optimize_edp_link_rate)
+		return false;
+	return true;
+}
+
+enum dc_link_rate get_max_link_rate_from_ilr_table(struct dc_link *link)
+{
+	enum dc_link_rate link_rate = link->reported_link_cap.link_rate;
+
+	for (int i = 0; i < link->dpcd_caps.edp_supported_link_rates_count; i++) {
+		if (link_rate < link->dpcd_caps.edp_supported_link_rates[i])
+			link_rate = link->dpcd_caps.edp_supported_link_rates[i];
+	}
+
+	return link_rate;
 }
 
 bool edp_is_ilr_optimization_required(struct dc_link *link,
@@ -311,8 +320,7 @@ bool edp_is_ilr_optimization_required(struct dc_link *link,
 
 	ASSERT(link || crtc_timing); // invalid input
 
-	if (link->dpcd_caps.edp_supported_link_rates_count == 0 ||
-			!link->panel_config.ilr.optimize_edp_link_rate)
+	if (!edp_is_ilr_optimization_enabled(link))
 		return false;
 
 
@@ -362,6 +370,34 @@ void edp_panel_backlight_power_on(struct dc_link *link, bool wait_for_hpd)
 		link->dc->hwss.edp_backlight_control(link, true);
 }
 
+void edp_set_panel_power(struct dc_link *link, bool powerOn)
+{
+	if (powerOn) {
+		// 1. panel VDD on
+		if (!link->dc->config.edp_no_power_sequencing)
+			link->dc->hwss.edp_power_control(link, true);
+		link->dc->hwss.edp_wait_for_hpd_ready(link, true);
+
+		// 2. panel BL on
+		if (link->dc->hwss.edp_backlight_control)
+			link->dc->hwss.edp_backlight_control(link, true);
+
+		// 3. Rx power on
+		dpcd_write_rx_power_ctrl(link, true);
+	} else {
+		// 3. Rx power off
+		dpcd_write_rx_power_ctrl(link, false);
+
+		// 2. panel BL off
+		if (link->dc->hwss.edp_backlight_control)
+			link->dc->hwss.edp_backlight_control(link, false);
+
+		// 1. panel VDD off
+		if (!link->dc->config.edp_no_power_sequencing)
+			link->dc->hwss.edp_power_control(link, false);
+	}
+}
+
 bool edp_wait_for_t12(struct dc_link *link)
 {
 	if (link->connector_signal == SIGNAL_TYPE_EDP && link->dc->hwss.edp_wait_for_T12) {
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
index 0a5bbda8c739..a034288ad75d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
@@ -30,7 +30,6 @@
 enum dp_panel_mode dp_get_panel_mode(struct dc_link *link);
 void dp_set_panel_mode(struct dc_link *link, enum dp_panel_mode panel_mode);
 bool set_default_brightness_aux(struct dc_link *link);
-bool set_cached_brightness_aux(struct dc_link *link);
 void edp_panel_backlight_power_on(struct dc_link *link, bool wait_for_hpd);
 int edp_get_backlight_level(const struct dc_link *link);
 bool edp_get_backlight_level_nits(struct dc_link *link,
@@ -64,9 +63,12 @@ bool edp_get_replay_state(const struct dc_link *link, uint64_t *state);
 bool edp_wait_for_t12(struct dc_link *link);
 bool edp_is_ilr_optimization_required(struct dc_link *link,
        struct dc_crtc_timing *crtc_timing);
+bool edp_is_ilr_optimization_enabled(struct dc_link *link);
+enum dc_link_rate get_max_link_rate_from_ilr_table(struct dc_link *link);
 bool edp_backlight_enable_aux(struct dc_link *link, bool enable);
 void edp_add_delay_for_T9(struct dc_link *link);
 bool edp_receiver_ready_T9(struct dc_link *link);
 bool edp_receiver_ready_T7(struct dc_link *link);
 bool edp_power_alpm_dpcd_enable(struct dc_link *link, bool enable);
+void edp_set_panel_power(struct dc_link *link, bool powerOn);
 #endif /* __DC_LINK_EDP_POWER_CONTROL_H__ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index d1922dde5b8b..6c45e216c709 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -997,6 +997,7 @@ enum dmub_status dmub_srv_wait_for_inbox0_ack(struct dmub_srv *dmub, uint32_t ti
 		ack = dmub->hw_funcs.read_inbox0_ack_register(dmub);
 		if (ack)
 			return DMUB_STATUS_OK;
+		udelay(1);
 	}
 	return DMUB_STATUS_TIMEOUT;
 }
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h
index c92c4b83253f..4bff1ef8a9a6 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h
@@ -6369,6 +6369,8 @@
 #define regTCP_INVALIDATE_BASE_IDX                                                                      1
 #define regTCP_STATUS                                                                                   0x19a1
 #define regTCP_STATUS_BASE_IDX                                                                          1
+#define regTCP_CNTL                                                                                     0x19a2
+#define regTCP_CNTL_BASE_IDX                                                                            1
 #define regTCP_CNTL2                                                                                    0x19a3
 #define regTCP_CNTL2_BASE_IDX                                                                           1
 #define regTCP_DEBUG_INDEX                                                                              0x19a5
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index cc3169400c9b..08fff9600bd2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -257,8 +257,11 @@ static int aldebaran_tables_init(struct smu_context *smu)
 	}
 
 	smu_table->ecc_table = kzalloc(tables[SMU_TABLE_ECCINFO].size, GFP_KERNEL);
-	if (!smu_table->ecc_table)
+	if (!smu_table->ecc_table) {
+		kfree(smu_table->metrics_table);
+		kfree(smu_table->gpu_metrics_table);
 		return -ENOMEM;
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index b4583d1f9666..119a4de7fe6f 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -5517,8 +5517,7 @@ static bool intel_edp_init_connector(struct intel_dp *intel_dp,
 	 * (eg. Acer Chromebook C710), so we'll check it only if multiple
 	 * ports are attempting to use the same AUX CH, according to VBT.
 	 */
-	if (intel_bios_dp_has_shared_aux_ch(encoder->devdata) &&
-	    !intel_digital_port_connected(encoder)) {
+	if (intel_bios_dp_has_shared_aux_ch(encoder->devdata)) {
 		/*
 		 * If this fails, presume the DPCD answer came
 		 * from some other port using the same AUX CH.
@@ -5526,10 +5525,27 @@ static bool intel_edp_init_connector(struct intel_dp *intel_dp,
 		 * FIXME maybe cleaner to check this before the
 		 * DPCD read? Would need sort out the VDD handling...
 		 */
-		drm_info(&dev_priv->drm,
-			 "[ENCODER:%d:%s] HPD is down, disabling eDP\n",
-			 encoder->base.base.id, encoder->base.name);
-		goto out_vdd_off;
+		if (!intel_digital_port_connected(encoder)) {
+			drm_info(&dev_priv->drm,
+				 "[ENCODER:%d:%s] HPD is down, disabling eDP\n",
+				 encoder->base.base.id, encoder->base.name);
+			goto out_vdd_off;
+		}
+
+		/*
+		 * Unfortunately even the HPD based detection fails on
+		 * eg. Asus B360M-A (CFL+CNP), so as a last resort fall
+		 * back to checking for a VGA branch device. Only do this
+		 * on known affected platforms to minimize false positives.
+		 */
+		if (DISPLAY_VER(dev_priv) == 9 && drm_dp_is_branch(intel_dp->dpcd) &&
+		    (intel_dp->dpcd[DP_DOWNSTREAMPORT_PRESENT] & DP_DWN_STRM_PORT_TYPE_MASK) ==
+		    DP_DWN_STRM_PORT_TYPE_ANALOG) {
+			drm_info(&dev_priv->drm,
+				 "[ENCODER:%d:%s] VGA converter detected, disabling eDP\n",
+				 encoder->base.base.id, encoder->base.name);
+			goto out_vdd_off;
+		}
 	}
 
 	mutex_lock(&dev_priv->drm.mode_config.mutex);
diff --git a/drivers/gpu/drm/i915/gt/intel_engine_user.c b/drivers/gpu/drm/i915/gt/intel_engine_user.c
index dcedff41a825..d304e0a948f0 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_user.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_user.c
@@ -42,12 +42,15 @@ void intel_engine_add_user(struct intel_engine_cs *engine)
 		  (struct llist_head *)&engine->i915->uabi_engines);
 }
 
-static const u8 uabi_classes[] = {
+#define I915_NO_UABI_CLASS ((u16)(-1))
+
+static const u16 uabi_classes[] = {
 	[RENDER_CLASS] = I915_ENGINE_CLASS_RENDER,
 	[COPY_ENGINE_CLASS] = I915_ENGINE_CLASS_COPY,
 	[VIDEO_DECODE_CLASS] = I915_ENGINE_CLASS_VIDEO,
 	[VIDEO_ENHANCEMENT_CLASS] = I915_ENGINE_CLASS_VIDEO_ENHANCE,
 	[COMPUTE_CLASS] = I915_ENGINE_CLASS_COMPUTE,
+	[OTHER_CLASS] = I915_NO_UABI_CLASS, /* Not exposed to users, no uabi class. */
 };
 
 static int engine_cmp(void *priv, const struct list_head *A,
@@ -202,6 +205,7 @@ static void engine_rename(struct intel_engine_cs *engine, const char *name, u16
 
 void intel_engines_driver_register(struct drm_i915_private *i915)
 {
+	u16 name_instance, other_instance = 0;
 	struct legacy_ring ring = {};
 	struct list_head *it, *next;
 	struct rb_node **p, *prev;
@@ -219,27 +223,28 @@ void intel_engines_driver_register(struct drm_i915_private *i915)
 		if (intel_gt_has_unrecoverable_error(engine->gt))
 			continue; /* ignore incomplete engines */
 
-		/*
-		 * We don't want to expose the GSC engine to the users, but we
-		 * still rename it so it is easier to identify in the debug logs
-		 */
-		if (engine->id == GSC0) {
-			engine_rename(engine, "gsc", 0);
-			continue;
-		}
-
 		GEM_BUG_ON(engine->class >= ARRAY_SIZE(uabi_classes));
 		engine->uabi_class = uabi_classes[engine->class];
+		if (engine->uabi_class == I915_NO_UABI_CLASS) {
+			name_instance = other_instance++;
+		} else {
+			GEM_BUG_ON(engine->uabi_class >=
+				   ARRAY_SIZE(i915->engine_uabi_class_count));
+			name_instance =
+				i915->engine_uabi_class_count[engine->uabi_class]++;
+		}
+		engine->uabi_instance = name_instance;
 
-		GEM_BUG_ON(engine->uabi_class >=
-			   ARRAY_SIZE(i915->engine_uabi_class_count));
-		engine->uabi_instance =
-			i915->engine_uabi_class_count[engine->uabi_class]++;
-
-		/* Replace the internal name with the final user facing name */
+		/*
+		 * Replace the internal name with the final user and log facing
+		 * name.
+		 */
 		engine_rename(engine,
 			      intel_engine_class_repr(engine->class),
-			      engine->uabi_instance);
+			      name_instance);
+
+		if (engine->uabi_class == I915_NO_UABI_CLASS)
+			continue;
 
 		rb_link_node(&engine->uabi_node, prev, p);
 		rb_insert_color(&engine->uabi_node, &i915->uabi_engines);
diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index 0f3bd187ede6..280d1d9a559b 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -318,8 +318,9 @@ nouveau_bo_alloc(struct nouveau_cli *cli, u64 *size, int *align, u32 domain,
 			    (!vmm->page[i].host || vmm->page[i].shift > PAGE_SHIFT))
 				continue;
 
-			if (pi < 0)
-				pi = i;
+			/* pick the last one as it will be smallest. */
+			pi = i;
+
 			/* Stop once the buffer is larger than the current page size. */
 			if (*size >= 1ULL << vmm->page[i].shift)
 				break;
diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index d76a8ca9c40f..29e63cdfb895 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -2104,6 +2104,7 @@ static const struct panel_desc starry_qfh032011_53g_desc = {
 	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
 		      MIPI_DSI_MODE_LPM,
 	.init_cmds = starry_qfh032011_53g_init_cmd,
+	.lp11_before_reset = true,
 };
 
 static const struct drm_display_mode starry_himax83102_j02_default_mode = {
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36523.c b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
index 9632b9e95b71..c4a804c5d6aa 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36523.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
@@ -1266,9 +1266,9 @@ static int nt36523_probe(struct mipi_dsi_device *dsi)
 			return dev_err_probe(dev, -EPROBE_DEFER, "cannot get secondary DSI host\n");
 
 		pinfo->dsi[1] = mipi_dsi_device_register_full(dsi1_host, info);
-		if (!pinfo->dsi[1]) {
+		if (IS_ERR(pinfo->dsi[1])) {
 			dev_err(dev, "cannot get secondary DSI device\n");
-			return -ENODEV;
+			return PTR_ERR(pinfo->dsi[1]);
 		}
 	}
 
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index a3414afe11b0..23cb80d62a9a 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1522,6 +1522,15 @@ void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 {
 	struct qi_desc desc;
 
+	/*
+	 * VT-d spec, section 4.3:
+	 *
+	 * Software is recommended to not submit any Device-TLB invalidation
+	 * requests while address remapping hardware is disabled.
+	 */
+	if (!(iommu->gcmd & DMA_GCMD_TE))
+		return;
+
 	if (mask) {
 		addr |= (1ULL << (VTD_PAGE_SHIFT + mask - 1)) - 1;
 		desc.qw1 = QI_DEV_IOTLB_ADDR(addr) | QI_DEV_IOTLB_SIZE;
@@ -1587,6 +1596,15 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 	unsigned long mask = 1UL << (VTD_PAGE_SHIFT + size_order - 1);
 	struct qi_desc desc = {.qw1 = 0, .qw2 = 0, .qw3 = 0};
 
+	/*
+	 * VT-d spec, section 4.3:
+	 *
+	 * Software is recommended to not submit any Device-TLB invalidation
+	 * requests while address remapping hardware is disabled.
+	 */
+	if (!(iommu->gcmd & DMA_GCMD_TE))
+		return;
+
 	desc.qw0 = QI_DEV_EIOTLB_PASID(pasid) | QI_DEV_EIOTLB_SID(sid) |
 		QI_DEV_EIOTLB_QDEP(qdep) | QI_DEIOTLB_TYPE |
 		QI_DEV_IOTLB_PFSID(pfsid);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 3685ba90ec88..4c3707384bd9 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2487,7 +2487,8 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 		return ret;
 	}
 
-	iommu_enable_pci_caps(info);
+	if (sm_supported(info->iommu) || !domain_type_is_si(info->domain))
+		iommu_enable_pci_caps(info);
 
 	return 0;
 }
@@ -3922,8 +3923,8 @@ static int domain_context_clear_one_cb(struct pci_dev *pdev, u16 alias, void *op
  */
 static void domain_context_clear(struct device_domain_info *info)
 {
-	if (!info->iommu || !info->dev || !dev_is_pci(info->dev))
-		return;
+	if (!dev_is_pci(info->dev))
+		domain_context_clear_one(info, info->bus, info->devfn);
 
 	pci_for_each_dma_alias(to_pci_dev(info->dev),
 			       &domain_context_clear_one_cb, info);
@@ -4928,7 +4929,7 @@ static void quirk_igfx_skip_te_disable(struct pci_dev *dev)
 	ver = (dev->device >> 8) & 0xff;
 	if (ver != 0x45 && ver != 0x46 && ver != 0x4c &&
 	    ver != 0x4e && ver != 0x8a && ver != 0x98 &&
-	    ver != 0x9a && ver != 0xa7)
+	    ver != 0x9a && ver != 0xa7 && ver != 0x7d)
 		return;
 
 	if (risky_device(dev))
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 50a481c895b8..ac12f76c1212 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -216,6 +216,27 @@ static void intel_flush_svm_range(struct intel_svm *svm, unsigned long address,
 	rcu_read_unlock();
 }
 
+static void intel_flush_svm_all(struct intel_svm *svm)
+{
+	struct device_domain_info *info;
+	struct intel_svm_dev *sdev;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(sdev, &svm->devs, list) {
+		info = dev_iommu_priv_get(sdev->dev);
+
+		qi_flush_piotlb(sdev->iommu, sdev->did, svm->pasid, 0, -1UL, 0);
+		if (info->ats_enabled) {
+			qi_flush_dev_iotlb_pasid(sdev->iommu, sdev->sid, info->pfsid,
+						 svm->pasid, sdev->qdep,
+						 0, 64 - VTD_PAGE_SHIFT);
+			quirk_extra_dev_tlb_flush(info, 0, 64 - VTD_PAGE_SHIFT,
+						  svm->pasid, sdev->qdep);
+		}
+	}
+	rcu_read_unlock();
+}
+
 /* Pages have been freed at this point */
 static void intel_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
 					struct mm_struct *mm,
@@ -223,6 +244,11 @@ static void intel_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
 {
 	struct intel_svm *svm = container_of(mn, struct intel_svm, notifier);
 
+	if (start == 0 && end == -1UL) {
+		intel_flush_svm_all(svm);
+		return;
+	}
+
 	intel_flush_svm_range(svm, start,
 			      (end - start + PAGE_SIZE - 1) >> VTD_PAGE_SHIFT, 0);
 }
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c146378c7d03..3a67e636287a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -479,11 +479,12 @@ static void iommu_deinit_device(struct device *dev)
 	dev_iommu_free(dev);
 }
 
+DEFINE_MUTEX(iommu_probe_device_lock);
+
 static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
 	struct iommu_group *group;
-	static DEFINE_MUTEX(iommu_probe_device_lock);
 	struct group_device *gdev;
 	int ret;
 
@@ -496,17 +497,15 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	 * probably be able to use device_lock() here to minimise the scope,
 	 * but for now enforcing a simple global ordering is fine.
 	 */
-	mutex_lock(&iommu_probe_device_lock);
+	lockdep_assert_held(&iommu_probe_device_lock);
 
 	/* Device is probed already if in a group */
-	if (dev->iommu_group) {
-		ret = 0;
-		goto out_unlock;
-	}
+	if (dev->iommu_group)
+		return 0;
 
 	ret = iommu_init_device(dev, ops);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	group = dev->iommu_group;
 	gdev = iommu_group_alloc_device(group, dev);
@@ -542,7 +541,6 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 			list_add_tail(&group->entry, group_list);
 	}
 	mutex_unlock(&group->mutex);
-	mutex_unlock(&iommu_probe_device_lock);
 
 	if (dev_is_pci(dev))
 		iommu_dma_set_pci_32bit_workaround(dev);
@@ -556,8 +554,6 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	iommu_deinit_device(dev);
 	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
-out_unlock:
-	mutex_unlock(&iommu_probe_device_lock);
 
 	return ret;
 }
@@ -567,7 +563,9 @@ int iommu_probe_device(struct device *dev)
 	const struct iommu_ops *ops;
 	int ret;
 
+	mutex_lock(&iommu_probe_device_lock);
 	ret = __iommu_probe_device(dev, NULL);
+	mutex_unlock(&iommu_probe_device_lock);
 	if (ret)
 		return ret;
 
@@ -1783,7 +1781,9 @@ static int probe_iommu_group(struct device *dev, void *data)
 	struct list_head *group_list = data;
 	int ret;
 
+	mutex_lock(&iommu_probe_device_lock);
 	ret = __iommu_probe_device(dev, group_list);
+	mutex_unlock(&iommu_probe_device_lock);
 	if (ret == -ENODEV)
 		ret = 0;
 
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 157b286e36bf..35ba090f3b5e 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -112,16 +112,20 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 					   const u32 *id)
 {
 	const struct iommu_ops *ops = NULL;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct iommu_fwspec *fwspec;
 	int err = NO_IOMMU;
 
 	if (!master_np)
 		return NULL;
 
+	/* Serialise to make dev->iommu stable under our potential fwspec */
+	mutex_lock(&iommu_probe_device_lock);
+	fwspec = dev_iommu_fwspec_get(dev);
 	if (fwspec) {
-		if (fwspec->ops)
+		if (fwspec->ops) {
+			mutex_unlock(&iommu_probe_device_lock);
 			return fwspec->ops;
-
+		}
 		/* In the deferred case, start again from scratch */
 		iommu_fwspec_free(dev);
 	}
@@ -155,6 +159,8 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 		fwspec = dev_iommu_fwspec_get(dev);
 		ops    = fwspec->ops;
 	}
+	mutex_unlock(&iommu_probe_device_lock);
+
 	/*
 	 * If we have reason to believe the IOMMU driver missed the initial
 	 * probe for dev, replay it to get things in order.
@@ -191,7 +197,7 @@ iommu_resv_region_get_type(struct device *dev,
 	if (start == phys->start && end == phys->end)
 		return IOMMU_RESV_DIRECT;
 
-	dev_warn(dev, "treating non-direct mapping [%pr] -> [%pap-%pap] as reservation\n", &phys,
+	dev_warn(dev, "treating non-direct mapping [%pr] -> [%pap-%pap] as reservation\n", phys,
 		 &start, &end);
 	return IOMMU_RESV_RESERVED;
 }
diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index 974b84f6bd6a..ba1be15cfd8e 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -75,19 +75,6 @@ static ssize_t max_brightness_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(max_brightness);
 
-static ssize_t color_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	const char *color_text = "invalid";
-	struct led_classdev *led_cdev = dev_get_drvdata(dev);
-
-	if (led_cdev->color < LED_COLOR_ID_MAX)
-		color_text = led_colors[led_cdev->color];
-
-	return sysfs_emit(buf, "%s\n", color_text);
-}
-static DEVICE_ATTR_RO(color);
-
 #ifdef CONFIG_LEDS_TRIGGERS
 static BIN_ATTR(trigger, 0644, led_trigger_read, led_trigger_write, 0);
 static struct bin_attribute *led_trigger_bin_attrs[] = {
@@ -102,7 +89,6 @@ static const struct attribute_group led_trigger_group = {
 static struct attribute *led_class_attrs[] = {
 	&dev_attr_brightness.attr,
 	&dev_attr_max_brightness.attr,
-	&dev_attr_color.attr,
 	NULL,
 };
 
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 418f85f1114f..3084c57248f6 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -1510,7 +1510,7 @@ static int btree_gc_coalesce(struct btree *b, struct btree_op *op,
 	bch_keylist_free(&keylist);
 
 	for (i = 0; i < nodes; i++)
-		if (!IS_ERR(new_nodes[i])) {
+		if (!IS_ERR_OR_NULL(new_nodes[i])) {
 			btree_node_free(new_nodes[i]);
 			rw_unlock(true, new_nodes[i]);
 		}
diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
index 2099c755119e..b475200d8586 100644
--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -24,7 +24,8 @@ bool verity_fec_is_enabled(struct dm_verity *v)
  */
 static inline struct dm_verity_fec_io *fec_io(struct dm_verity_io *io)
 {
-	return (struct dm_verity_fec_io *) verity_io_digest_end(io->v, io);
+	return (struct dm_verity_fec_io *)
+		((char *)io + io->v->ti->per_io_data_size - sizeof(struct dm_verity_fec_io));
 }
 
 /*
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index e115fcfe723c..14e58ae70521 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -642,7 +642,6 @@ static void verity_work(struct work_struct *w)
 
 	io->in_tasklet = false;
 
-	verity_fec_init_io(io);
 	verity_finish_io(io, errno_to_blk_status(verity_verify_io(io)));
 }
 
@@ -668,7 +667,9 @@ static void verity_end_io(struct bio *bio)
 	struct dm_verity_io *io = bio->bi_private;
 
 	if (bio->bi_status &&
-	    (!verity_fec_is_enabled(io->v) || verity_is_system_shutting_down())) {
+	    (!verity_fec_is_enabled(io->v) ||
+	     verity_is_system_shutting_down() ||
+	     (bio->bi_opf & REQ_RAHEAD))) {
 		verity_finish_io(io, bio->bi_status);
 		return;
 	}
@@ -792,6 +793,8 @@ static int verity_map(struct dm_target *ti, struct bio *bio)
 	bio->bi_private = io;
 	io->iter = bio->bi_iter;
 
+	verity_fec_init_io(io);
+
 	verity_submit_prefetch(v, io);
 
 	submit_bio_noacct(bio);
diff --git a/drivers/md/dm-verity.h b/drivers/md/dm-verity.h
index f96f4e281ee4..f9d522c870e6 100644
--- a/drivers/md/dm-verity.h
+++ b/drivers/md/dm-verity.h
@@ -115,12 +115,6 @@ static inline u8 *verity_io_want_digest(struct dm_verity *v,
 	return (u8 *)(io + 1) + v->ahash_reqsize + v->digest_size;
 }
 
-static inline u8 *verity_io_digest_end(struct dm_verity *v,
-				       struct dm_verity_io *io)
-{
-	return verity_io_want_digest(v, io) + v->digest_size;
-}
-
 extern int verity_for_bv_block(struct dm_verity *v, struct dm_verity_io *io,
 			       struct bvec_iter *iter,
 			       int (*process)(struct dm_verity *v,
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 152dfe593c43..f9a5cffa64b1 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1482,6 +1482,8 @@ static void mmc_blk_cqe_complete_rq(struct mmc_queue *mq, struct request *req)
 			blk_mq_requeue_request(req, true);
 		else
 			__blk_mq_end_request(req, BLK_STS_OK);
+	} else if (mq->in_recovery) {
+		blk_mq_requeue_request(req, true);
 	} else {
 		blk_mq_end_request(req, BLK_STS_OK);
 	}
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 3d3e0ca52614..a8c17b4cd737 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -551,7 +551,9 @@ int mmc_cqe_recovery(struct mmc_host *host)
 	cmd.flags        = MMC_RSP_R1B | MMC_CMD_AC;
 	cmd.flags       &= ~MMC_RSP_CRC; /* Ignore CRC */
 	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT;
-	mmc_wait_for_cmd(host, &cmd, 0);
+	mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
+
+	mmc_poll_for_busy(host->card, MMC_CQE_RECOVERY_TIMEOUT, true, MMC_BUSY_IO);
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.opcode       = MMC_CMDQ_TASK_MGMT;
@@ -559,10 +561,13 @@ int mmc_cqe_recovery(struct mmc_host *host)
 	cmd.flags        = MMC_RSP_R1B | MMC_CMD_AC;
 	cmd.flags       &= ~MMC_RSP_CRC; /* Ignore CRC */
 	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT;
-	err = mmc_wait_for_cmd(host, &cmd, 0);
+	err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
 
 	host->cqe_ops->cqe_recovery_finish(host);
 
+	if (err)
+		err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
+
 	mmc_retune_release(host);
 
 	return err;
diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index b3d7d6d8d654..41e94cd14109 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -942,8 +942,8 @@ static bool cqhci_clear_all_tasks(struct mmc_host *mmc, unsigned int timeout)
 	ret = cqhci_tasks_cleared(cq_host);
 
 	if (!ret)
-		pr_debug("%s: cqhci: Failed to clear tasks\n",
-			 mmc_hostname(mmc));
+		pr_warn("%s: cqhci: Failed to clear tasks\n",
+			mmc_hostname(mmc));
 
 	return ret;
 }
@@ -976,7 +976,7 @@ static bool cqhci_halt(struct mmc_host *mmc, unsigned int timeout)
 	ret = cqhci_halted(cq_host);
 
 	if (!ret)
-		pr_debug("%s: cqhci: Failed to halt\n", mmc_hostname(mmc));
+		pr_warn("%s: cqhci: Failed to halt\n", mmc_hostname(mmc));
 
 	return ret;
 }
@@ -984,10 +984,10 @@ static bool cqhci_halt(struct mmc_host *mmc, unsigned int timeout)
 /*
  * After halting we expect to be able to use the command line. We interpret the
  * failure to halt to mean the data lines might still be in use (and the upper
- * layers will need to send a STOP command), so we set the timeout based on a
- * generous command timeout.
+ * layers will need to send a STOP command), however failing to halt complicates
+ * the recovery, so set a timeout that would reasonably allow I/O to complete.
  */
-#define CQHCI_START_HALT_TIMEOUT	5
+#define CQHCI_START_HALT_TIMEOUT	500
 
 static void cqhci_recovery_start(struct mmc_host *mmc)
 {
@@ -1075,28 +1075,28 @@ static void cqhci_recovery_finish(struct mmc_host *mmc)
 
 	ok = cqhci_halt(mmc, CQHCI_FINISH_HALT_TIMEOUT);
 
-	if (!cqhci_clear_all_tasks(mmc, CQHCI_CLEAR_TIMEOUT))
-		ok = false;
-
 	/*
 	 * The specification contradicts itself, by saying that tasks cannot be
 	 * cleared if CQHCI does not halt, but if CQHCI does not halt, it should
 	 * be disabled/re-enabled, but not to disable before clearing tasks.
 	 * Have a go anyway.
 	 */
-	if (!ok) {
-		pr_debug("%s: cqhci: disable / re-enable\n", mmc_hostname(mmc));
-		cqcfg = cqhci_readl(cq_host, CQHCI_CFG);
-		cqcfg &= ~CQHCI_ENABLE;
-		cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
-		cqcfg |= CQHCI_ENABLE;
-		cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
-		/* Be sure that there are no tasks */
-		ok = cqhci_halt(mmc, CQHCI_FINISH_HALT_TIMEOUT);
-		if (!cqhci_clear_all_tasks(mmc, CQHCI_CLEAR_TIMEOUT))
-			ok = false;
-		WARN_ON(!ok);
-	}
+	if (!cqhci_clear_all_tasks(mmc, CQHCI_CLEAR_TIMEOUT))
+		ok = false;
+
+	/* Disable to make sure tasks really are cleared */
+	cqcfg = cqhci_readl(cq_host, CQHCI_CFG);
+	cqcfg &= ~CQHCI_ENABLE;
+	cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
+
+	cqcfg = cqhci_readl(cq_host, CQHCI_CFG);
+	cqcfg |= CQHCI_ENABLE;
+	cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
+
+	cqhci_halt(mmc, CQHCI_FINISH_HALT_TIMEOUT);
+
+	if (!ok)
+		cqhci_clear_all_tasks(mmc, CQHCI_CLEAR_TIMEOUT);
 
 	cqhci_recover_mrqs(cq_host);
 
diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index d8a991b349a8..77911a57b12c 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -1189,6 +1189,32 @@ static void gl9763e_hs400_enhanced_strobe(struct mmc_host *mmc,
 	sdhci_writel(host, val, SDHCI_GLI_9763E_HS400_ES_REG);
 }
 
+static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slot,
+					      bool enable)
+{
+	struct pci_dev *pdev = slot->chip->pdev;
+	u32 value;
+
+	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
+	value &= ~GLI_9763E_VHS_REV;
+	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_W);
+	pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
+
+	pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG, &value);
+
+	if (enable)
+		value &= ~GLI_9763E_CFG_LPSN_DIS;
+	else
+		value |= GLI_9763E_CFG_LPSN_DIS;
+
+	pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG, value);
+
+	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
+	value &= ~GLI_9763E_VHS_REV;
+	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
+	pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
+}
+
 static void sdhci_set_gl9763e_signaling(struct sdhci_host *host,
 					unsigned int timing)
 {
@@ -1297,6 +1323,9 @@ static int gl9763e_add_host(struct sdhci_pci_slot *slot)
 	if (ret)
 		goto cleanup;
 
+	/* Disable LPM negotiation to avoid entering L1 state. */
+	gl9763e_set_low_power_negotiation(slot, false);
+
 	return 0;
 
 cleanup:
@@ -1340,31 +1369,6 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
 }
 
 #ifdef CONFIG_PM
-static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slot, bool enable)
-{
-	struct pci_dev *pdev = slot->chip->pdev;
-	u32 value;
-
-	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
-	value &= ~GLI_9763E_VHS_REV;
-	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_W);
-	pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
-
-	pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG, &value);
-
-	if (enable)
-		value &= ~GLI_9763E_CFG_LPSN_DIS;
-	else
-		value |= GLI_9763E_CFG_LPSN_DIS;
-
-	pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG, value);
-
-	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
-	value &= ~GLI_9763E_VHS_REV;
-	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
-	pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
-}
-
 static int gl9763e_runtime_suspend(struct sdhci_pci_chip *chip)
 {
 	struct sdhci_pci_slot *slot = chip->slots[0];
diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 6b84ba27e6ab..6b8a57e2d20f 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -416,12 +416,33 @@ static void sdhci_sprd_request_done(struct sdhci_host *host,
 	mmc_request_done(host->mmc, mrq);
 }
 
+static void sdhci_sprd_set_power(struct sdhci_host *host, unsigned char mode,
+				 unsigned short vdd)
+{
+	struct mmc_host *mmc = host->mmc;
+
+	switch (mode) {
+	case MMC_POWER_OFF:
+		mmc_regulator_set_ocr(host->mmc, mmc->supply.vmmc, 0);
+
+		mmc_regulator_disable_vqmmc(mmc);
+		break;
+	case MMC_POWER_ON:
+		mmc_regulator_enable_vqmmc(mmc);
+		break;
+	case MMC_POWER_UP:
+		mmc_regulator_set_ocr(host->mmc, mmc->supply.vmmc, vdd);
+		break;
+	}
+}
+
 static struct sdhci_ops sdhci_sprd_ops = {
 	.read_l = sdhci_sprd_readl,
 	.write_l = sdhci_sprd_writel,
 	.write_w = sdhci_sprd_writew,
 	.write_b = sdhci_sprd_writeb,
 	.set_clock = sdhci_sprd_set_clock,
+	.set_power = sdhci_sprd_set_power,
 	.get_max_clock = sdhci_sprd_get_max_clock,
 	.get_min_clock = sdhci_sprd_get_min_clock,
 	.set_bus_width = sdhci_set_bus_width,
@@ -823,6 +844,10 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 	host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_SDR104 |
 			 SDHCI_SUPPORT_DDR50);
 
+	ret = mmc_regulator_get_supply(host->mmc);
+	if (ret)
+		goto pm_runtime_disable;
+
 	ret = sdhci_setup_host(host);
 	if (ret)
 		goto pm_runtime_disable;
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index ab434a77b059..dc7f9b99f409 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -577,6 +577,18 @@ static void mv88e6250_phylink_get_caps(struct mv88e6xxx_chip *chip, int port,
 	config->mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100;
 }
 
+static void mv88e6351_phylink_get_caps(struct mv88e6xxx_chip *chip, int port,
+				       struct phylink_config *config)
+{
+	unsigned long *supported = config->supported_interfaces;
+
+	/* Translate the default cmode */
+	mv88e6xxx_translate_cmode(chip->ports[port].cmode, supported);
+
+	config->mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100 |
+				   MAC_1000FD;
+}
+
 static int mv88e6352_get_port4_serdes_cmode(struct mv88e6xxx_chip *chip)
 {
 	u16 reg, val;
@@ -3880,7 +3892,8 @@ static int mv88e6xxx_port_setup(struct dsa_switch *ds, int port)
 	struct mv88e6xxx_chip *chip = ds->priv;
 	int err;
 
-	if (chip->info->ops->pcs_ops->pcs_init) {
+	if (chip->info->ops->pcs_ops &&
+	    chip->info->ops->pcs_ops->pcs_init) {
 		err = chip->info->ops->pcs_ops->pcs_init(chip, port);
 		if (err)
 			return err;
@@ -3895,7 +3908,8 @@ static void mv88e6xxx_port_teardown(struct dsa_switch *ds, int port)
 
 	mv88e6xxx_teardown_devlink_regions_port(ds, port);
 
-	if (chip->info->ops->pcs_ops->pcs_teardown)
+	if (chip->info->ops->pcs_ops &&
+	    chip->info->ops->pcs_ops->pcs_teardown)
 		chip->info->ops->pcs_ops->pcs_teardown(chip, port);
 }
 
@@ -4340,7 +4354,7 @@ static const struct mv88e6xxx_ops mv88e6171_ops = {
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
-	.phylink_get_caps = mv88e6185_phylink_get_caps,
+	.phylink_get_caps = mv88e6351_phylink_get_caps,
 };
 
 static const struct mv88e6xxx_ops mv88e6172_ops = {
@@ -4440,7 +4454,7 @@ static const struct mv88e6xxx_ops mv88e6175_ops = {
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
-	.phylink_get_caps = mv88e6185_phylink_get_caps,
+	.phylink_get_caps = mv88e6351_phylink_get_caps,
 };
 
 static const struct mv88e6xxx_ops mv88e6176_ops = {
@@ -5069,7 +5083,7 @@ static const struct mv88e6xxx_ops mv88e6350_ops = {
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
-	.phylink_get_caps = mv88e6185_phylink_get_caps,
+	.phylink_get_caps = mv88e6351_phylink_get_caps,
 };
 
 static const struct mv88e6xxx_ops mv88e6351_ops = {
@@ -5117,7 +5131,7 @@ static const struct mv88e6xxx_ops mv88e6351_ops = {
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
-	.phylink_get_caps = mv88e6185_phylink_get_caps,
+	.phylink_get_caps = mv88e6351_phylink_get_caps,
 };
 
 static const struct mv88e6xxx_ops mv88e6352_ops = {
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 15bab41cee48..888509cf1f21 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -516,8 +516,6 @@ struct sk_buff *dpaa2_eth_alloc_skb(struct dpaa2_eth_priv *priv,
 
 	memcpy(skb->data, fd_vaddr + fd_offset, fd_length);
 
-	dpaa2_eth_recycle_buf(priv, ch, dpaa2_fd_get_addr(fd));
-
 	return skb;
 }
 
@@ -589,6 +587,7 @@ void dpaa2_eth_rx(struct dpaa2_eth_priv *priv,
 	struct rtnl_link_stats64 *percpu_stats;
 	struct dpaa2_eth_drv_stats *percpu_extras;
 	struct device *dev = priv->net_dev->dev.parent;
+	bool recycle_rx_buf = false;
 	void *buf_data;
 	u32 xdp_act;
 
@@ -618,6 +617,8 @@ void dpaa2_eth_rx(struct dpaa2_eth_priv *priv,
 			dma_unmap_page(dev, addr, priv->rx_buf_size,
 				       DMA_BIDIRECTIONAL);
 			skb = dpaa2_eth_build_linear_skb(ch, fd, vaddr);
+		} else {
+			recycle_rx_buf = true;
 		}
 	} else if (fd_format == dpaa2_fd_sg) {
 		WARN_ON(priv->xdp_prog);
@@ -637,6 +638,9 @@ void dpaa2_eth_rx(struct dpaa2_eth_priv *priv,
 		goto err_build_skb;
 
 	dpaa2_eth_receive_skb(priv, ch, fd, vaddr, fq, percpu_stats, skb);
+
+	if (recycle_rx_buf)
+		dpaa2_eth_recycle_buf(priv, ch, dpaa2_fd_get_addr(fd));
 	return;
 
 err_build_skb:
@@ -1073,14 +1077,12 @@ static int dpaa2_eth_build_single_fd(struct dpaa2_eth_priv *priv,
 	dma_addr_t addr;
 
 	buffer_start = skb->data - dpaa2_eth_needed_headroom(skb);
-
-	/* If there's enough room to align the FD address, do it.
-	 * It will help hardware optimize accesses.
-	 */
 	aligned_start = PTR_ALIGN(buffer_start - DPAA2_ETH_TX_BUF_ALIGN,
 				  DPAA2_ETH_TX_BUF_ALIGN);
 	if (aligned_start >= skb->head)
 		buffer_start = aligned_start;
+	else
+		return -ENOMEM;
 
 	/* Store a backpointer to the skb at the beginning of the buffer
 	 * (in the private data area) such that we can release it
@@ -4967,6 +4969,8 @@ static int dpaa2_eth_probe(struct fsl_mc_device *dpni_dev)
 	if (err)
 		goto err_dl_port_add;
 
+	net_dev->needed_headroom = DPAA2_ETH_SWA_SIZE + DPAA2_ETH_TX_BUF_ALIGN;
+
 	err = register_netdev(net_dev);
 	if (err < 0) {
 		dev_err(dev, "register_netdev() failed\n");
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h
index bfb6c96c3b2f..834cba8c3a41 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h
@@ -740,7 +740,7 @@ static inline bool dpaa2_eth_rx_pause_enabled(u64 link_options)
 
 static inline unsigned int dpaa2_eth_needed_headroom(struct sk_buff *skb)
 {
-	unsigned int headroom = DPAA2_ETH_SWA_SIZE;
+	unsigned int headroom = DPAA2_ETH_SWA_SIZE + DPAA2_ETH_TX_BUF_ALIGN;
 
 	/* If we don't have an skb (e.g. XDP buffer), we only need space for
 	 * the software annotation area
diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index fb40ad98e6aa..d86e2460b5a4 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -536,6 +536,50 @@ ice_lag_move_vf_node_tc(struct ice_lag *lag, u8 oldport, u8 newport,
 		dev_dbg(dev, "Problem restarting traffic for LAG node move\n");
 }
 
+/**
+ * ice_lag_build_netdev_list - populate the lag struct's netdev list
+ * @lag: local lag struct
+ * @ndlist: pointer to netdev list to populate
+ */
+static void ice_lag_build_netdev_list(struct ice_lag *lag,
+				      struct ice_lag_netdev_list *ndlist)
+{
+	struct ice_lag_netdev_list *nl;
+	struct net_device *tmp_nd;
+
+	INIT_LIST_HEAD(&ndlist->node);
+	rcu_read_lock();
+	for_each_netdev_in_bond_rcu(lag->upper_netdev, tmp_nd) {
+		nl = kzalloc(sizeof(*nl), GFP_ATOMIC);
+		if (!nl)
+			break;
+
+		nl->netdev = tmp_nd;
+		list_add(&nl->node, &ndlist->node);
+	}
+	rcu_read_unlock();
+	lag->netdev_head = &ndlist->node;
+}
+
+/**
+ * ice_lag_destroy_netdev_list - free lag struct's netdev list
+ * @lag: pointer to local lag struct
+ * @ndlist: pointer to lag struct netdev list
+ */
+static void ice_lag_destroy_netdev_list(struct ice_lag *lag,
+					struct ice_lag_netdev_list *ndlist)
+{
+	struct ice_lag_netdev_list *entry, *n;
+
+	rcu_read_lock();
+	list_for_each_entry_safe(entry, n, &ndlist->node, node) {
+		list_del(&entry->node);
+		kfree(entry);
+	}
+	rcu_read_unlock();
+	lag->netdev_head = NULL;
+}
+
 /**
  * ice_lag_move_single_vf_nodes - Move Tx scheduling nodes for single VF
  * @lag: primary interface LAG struct
@@ -564,7 +608,6 @@ ice_lag_move_single_vf_nodes(struct ice_lag *lag, u8 oldport, u8 newport,
 void ice_lag_move_new_vf_nodes(struct ice_vf *vf)
 {
 	struct ice_lag_netdev_list ndlist;
-	struct list_head *tmp, *n;
 	u8 pri_port, act_port;
 	struct ice_lag *lag;
 	struct ice_vsi *vsi;
@@ -588,38 +631,15 @@ void ice_lag_move_new_vf_nodes(struct ice_vf *vf)
 	pri_port = pf->hw.port_info->lport;
 	act_port = lag->active_port;
 
-	if (lag->upper_netdev) {
-		struct ice_lag_netdev_list *nl;
-		struct net_device *tmp_nd;
-
-		INIT_LIST_HEAD(&ndlist.node);
-		rcu_read_lock();
-		for_each_netdev_in_bond_rcu(lag->upper_netdev, tmp_nd) {
-			nl = kzalloc(sizeof(*nl), GFP_ATOMIC);
-			if (!nl)
-				break;
-
-			nl->netdev = tmp_nd;
-			list_add(&nl->node, &ndlist.node);
-		}
-		rcu_read_unlock();
-	}
-
-	lag->netdev_head = &ndlist.node;
+	if (lag->upper_netdev)
+		ice_lag_build_netdev_list(lag, &ndlist);
 
 	if (ice_is_feature_supported(pf, ICE_F_SRIOV_LAG) &&
 	    lag->bonded && lag->primary && pri_port != act_port &&
 	    !list_empty(lag->netdev_head))
 		ice_lag_move_single_vf_nodes(lag, pri_port, act_port, vsi->idx);
 
-	list_for_each_safe(tmp, n, &ndlist.node) {
-		struct ice_lag_netdev_list *entry;
-
-		entry = list_entry(tmp, struct ice_lag_netdev_list, node);
-		list_del(&entry->node);
-		kfree(entry);
-	}
-	lag->netdev_head = NULL;
+	ice_lag_destroy_netdev_list(lag, &ndlist);
 
 new_vf_unlock:
 	mutex_unlock(&pf->lag_mutex);
@@ -646,6 +666,29 @@ static void ice_lag_move_vf_nodes(struct ice_lag *lag, u8 oldport, u8 newport)
 			ice_lag_move_single_vf_nodes(lag, oldport, newport, i);
 }
 
+/**
+ * ice_lag_move_vf_nodes_cfg - move vf nodes outside LAG netdev event context
+ * @lag: local lag struct
+ * @src_prt: lport value for source port
+ * @dst_prt: lport value for destination port
+ *
+ * This function is used to move nodes during an out-of-netdev-event situation,
+ * primarily when the driver needs to reconfigure or recreate resources.
+ *
+ * Must be called while holding the lag_mutex to avoid lag events from
+ * processing while out-of-sync moves are happening.  Also, paired moves,
+ * such as used in a reset flow, should both be called under the same mutex
+ * lock to avoid changes between start of reset and end of reset.
+ */
+void ice_lag_move_vf_nodes_cfg(struct ice_lag *lag, u8 src_prt, u8 dst_prt)
+{
+	struct ice_lag_netdev_list ndlist;
+
+	ice_lag_build_netdev_list(lag, &ndlist);
+	ice_lag_move_vf_nodes(lag, src_prt, dst_prt);
+	ice_lag_destroy_netdev_list(lag, &ndlist);
+}
+
 #define ICE_LAG_SRIOV_CP_RECIPE		10
 #define ICE_LAG_SRIOV_TRAIN_PKT_LEN	16
 
@@ -2022,7 +2065,6 @@ void ice_lag_rebuild(struct ice_pf *pf)
 {
 	struct ice_lag_netdev_list ndlist;
 	struct ice_lag *lag, *prim_lag;
-	struct list_head *tmp, *n;
 	u8 act_port, loc_port;
 
 	if (!pf->lag || !pf->lag->bonded)
@@ -2034,21 +2076,7 @@ void ice_lag_rebuild(struct ice_pf *pf)
 	if (lag->primary) {
 		prim_lag = lag;
 	} else {
-		struct ice_lag_netdev_list *nl;
-		struct net_device *tmp_nd;
-
-		INIT_LIST_HEAD(&ndlist.node);
-		rcu_read_lock();
-		for_each_netdev_in_bond_rcu(lag->upper_netdev, tmp_nd) {
-			nl = kzalloc(sizeof(*nl), GFP_ATOMIC);
-			if (!nl)
-				break;
-
-			nl->netdev = tmp_nd;
-			list_add(&nl->node, &ndlist.node);
-		}
-		rcu_read_unlock();
-		lag->netdev_head = &ndlist.node;
+		ice_lag_build_netdev_list(lag, &ndlist);
 		prim_lag = ice_lag_find_primary(lag);
 	}
 
@@ -2078,13 +2106,7 @@ void ice_lag_rebuild(struct ice_pf *pf)
 
 	ice_clear_rdma_cap(pf);
 lag_rebuild_out:
-	list_for_each_safe(tmp, n, &ndlist.node) {
-		struct ice_lag_netdev_list *entry;
-
-		entry = list_entry(tmp, struct ice_lag_netdev_list, node);
-		list_del(&entry->node);
-		kfree(entry);
-	}
+	ice_lag_destroy_netdev_list(lag, &ndlist);
 	mutex_unlock(&pf->lag_mutex);
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_lag.h b/drivers/net/ethernet/intel/ice/ice_lag.h
index facb6c894b6d..7f2298767501 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.h
+++ b/drivers/net/ethernet/intel/ice/ice_lag.h
@@ -63,4 +63,5 @@ int ice_init_lag(struct ice_pf *pf);
 void ice_deinit_lag(struct ice_pf *pf);
 void ice_lag_rebuild(struct ice_pf *pf);
 bool ice_lag_is_switchdev_running(struct ice_pf *pf);
+void ice_lag_move_vf_nodes_cfg(struct ice_lag *lag, u8 src_prt, u8 dst_prt);
 #endif /* _ICE_LAG_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index 24e4f4d897b6..d488c7156d09 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -827,12 +827,16 @@ static void ice_notify_vf_reset(struct ice_vf *vf)
 int ice_reset_vf(struct ice_vf *vf, u32 flags)
 {
 	struct ice_pf *pf = vf->pf;
+	struct ice_lag *lag;
 	struct ice_vsi *vsi;
+	u8 act_prt, pri_prt;
 	struct device *dev;
 	int err = 0;
 	bool rsd;
 
 	dev = ice_pf_to_dev(pf);
+	act_prt = ICE_LAG_INVALID_PORT;
+	pri_prt = pf->hw.port_info->lport;
 
 	if (flags & ICE_VF_RESET_NOTIFY)
 		ice_notify_vf_reset(vf);
@@ -843,6 +847,17 @@ int ice_reset_vf(struct ice_vf *vf, u32 flags)
 		return 0;
 	}
 
+	lag = pf->lag;
+	mutex_lock(&pf->lag_mutex);
+	if (lag && lag->bonded && lag->primary) {
+		act_prt = lag->active_port;
+		if (act_prt != pri_prt && act_prt != ICE_LAG_INVALID_PORT &&
+		    lag->upper_netdev)
+			ice_lag_move_vf_nodes_cfg(lag, act_prt, pri_prt);
+		else
+			act_prt = ICE_LAG_INVALID_PORT;
+	}
+
 	if (flags & ICE_VF_RESET_LOCK)
 		mutex_lock(&vf->cfg_lock);
 	else
@@ -935,6 +950,11 @@ int ice_reset_vf(struct ice_vf *vf, u32 flags)
 	if (flags & ICE_VF_RESET_LOCK)
 		mutex_unlock(&vf->cfg_lock);
 
+	if (lag && lag->bonded && lag->primary &&
+	    act_prt != ICE_LAG_INVALID_PORT)
+		ice_lag_move_vf_nodes_cfg(lag, pri_prt, act_prt);
+	mutex_unlock(&pf->lag_mutex);
+
 	return err;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index db97353efd06..62337e6569b2 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -1600,9 +1600,24 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 	    (struct virtchnl_vsi_queue_config_info *)msg;
 	struct virtchnl_queue_pair_info *qpi;
 	struct ice_pf *pf = vf->pf;
+	struct ice_lag *lag;
 	struct ice_vsi *vsi;
+	u8 act_prt, pri_prt;
 	int i = -1, q_idx;
 
+	lag = pf->lag;
+	mutex_lock(&pf->lag_mutex);
+	act_prt = ICE_LAG_INVALID_PORT;
+	pri_prt = pf->hw.port_info->lport;
+	if (lag && lag->bonded && lag->primary) {
+		act_prt = lag->active_port;
+		if (act_prt != pri_prt && act_prt != ICE_LAG_INVALID_PORT &&
+		    lag->upper_netdev)
+			ice_lag_move_vf_nodes_cfg(lag, act_prt, pri_prt);
+		else
+			act_prt = ICE_LAG_INVALID_PORT;
+	}
+
 	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states))
 		goto error_param;
 
@@ -1710,6 +1725,11 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 		}
 	}
 
+	if (lag && lag->bonded && lag->primary &&
+	    act_prt != ICE_LAG_INVALID_PORT)
+		ice_lag_move_vf_nodes_cfg(lag, pri_prt, act_prt);
+	mutex_unlock(&pf->lag_mutex);
+
 	/* send the response to the VF */
 	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_CONFIG_VSI_QUEUES,
 				     VIRTCHNL_STATUS_SUCCESS, NULL, 0);
@@ -1724,6 +1744,11 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 				vf->vf_id, i);
 	}
 
+	if (lag && lag->bonded && lag->primary &&
+	    act_prt != ICE_LAG_INVALID_PORT)
+		ice_lag_move_vf_nodes_cfg(lag, pri_prt, act_prt);
+	mutex_unlock(&pf->lag_mutex);
+
 	ice_lag_move_new_vf_nodes(vf);
 
 	/* send the response to the VF */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 23c2f2ed2fb8..c112c71ff576 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -5505,6 +5505,8 @@ int rvu_mbox_handler_nix_bandprof_free(struct rvu *rvu,
 
 		ipolicer = &nix_hw->ipolicer[layer];
 		for (idx = 0; idx < req->prof_count[layer]; idx++) {
+			if (idx == MAX_BANDPROF_PER_PFFUNC)
+				break;
 			prof_idx = req->prof_idx[layer][idx];
 			if (prof_idx >= ipolicer->band_prof.max ||
 			    ipolicer->pfvf_map[prof_idx] != pcifunc)
@@ -5518,8 +5520,6 @@ int rvu_mbox_handler_nix_bandprof_free(struct rvu *rvu,
 			ipolicer->pfvf_map[prof_idx] = 0x00;
 			ipolicer->match_id[prof_idx] = 0;
 			rvu_free_rsrc(&ipolicer->band_prof, prof_idx);
-			if (idx == MAX_BANDPROF_PER_PFFUNC)
-				break;
 		}
 	}
 	mutex_unlock(&rvu->rsrc_lock);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
index a4a258da8dd5..c1c99d7054f8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
@@ -450,6 +450,9 @@ int cn10k_set_ipolicer_rate(struct otx2_nic *pfvf, u16 profile,
 	aq->prof.pebs_mantissa = 0;
 	aq->prof_mask.pebs_mantissa = 0xFF;
 
+	aq->prof.hl_en = 0;
+	aq->prof_mask.hl_en = 1;
+
 	/* Fill AQ info */
 	aq->qidx = profile;
 	aq->ctype = NIX_AQ_CTYPE_BANDPROF;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index e7c69b57147e..06910307085e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -1070,6 +1070,8 @@ int otx2_init_tc(struct otx2_nic *nic);
 void otx2_shutdown_tc(struct otx2_nic *nic);
 int otx2_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 		  void *type_data);
+void otx2_tc_apply_ingress_police_rules(struct otx2_nic *nic);
+
 /* CGX/RPM DMAC filters support */
 int otx2_dmacflt_get_max_cnt(struct otx2_nic *pf);
 int otx2_dmacflt_add(struct otx2_nic *pf, const u8 *mac, u32 bit_pos);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index ba95ac913274..532e324bdcc8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -566,7 +566,9 @@ static irqreturn_t otx2_pfvf_mbox_intr_handler(int irq, void *pf_irq)
 		otx2_write64(pf, RVU_PF_VFPF_MBOX_INTX(1), intr);
 		otx2_queue_work(mbox, pf->mbox_pfvf_wq, 64, vfs, intr,
 				TYPE_PFVF);
-		vfs -= 64;
+		if (intr)
+			trace_otx2_msg_interrupt(mbox->mbox.pdev, "VF(s) to PF", intr);
+		vfs = 64;
 	}
 
 	intr = otx2_read64(pf, RVU_PF_VFPF_MBOX_INTX(0));
@@ -574,7 +576,8 @@ static irqreturn_t otx2_pfvf_mbox_intr_handler(int irq, void *pf_irq)
 
 	otx2_queue_work(mbox, pf->mbox_pfvf_wq, 0, vfs, intr, TYPE_PFVF);
 
-	trace_otx2_msg_interrupt(mbox->mbox.pdev, "VF(s) to PF", intr);
+	if (intr)
+		trace_otx2_msg_interrupt(mbox->mbox.pdev, "VF(s) to PF", intr);
 
 	return IRQ_HANDLED;
 }
@@ -1870,6 +1873,8 @@ int otx2_open(struct net_device *netdev)
 	if (pf->flags & OTX2_FLAG_DMACFLTR_SUPPORT)
 		otx2_dmacflt_reinstall_flows(pf);
 
+	otx2_tc_apply_ingress_police_rules(pf);
+
 	err = otx2_rxtx_enable(pf, true);
 	/* If a mbox communication error happens at this point then interface
 	 * will end up in a state such that it is in down state but hardware
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index fab9d85bfb37..423ce54eaea6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -45,6 +45,9 @@ struct otx2_tc_flow {
 	bool				is_act_police;
 	u32				prio;
 	struct npc_install_flow_req	req;
+	u64				rate;
+	u32				burst;
+	bool				is_pps;
 };
 
 static void otx2_get_egress_burst_cfg(struct otx2_nic *nic, u32 burst,
@@ -282,21 +285,10 @@ static int otx2_tc_egress_matchall_delete(struct otx2_nic *nic,
 	return err;
 }
 
-static int otx2_tc_act_set_police(struct otx2_nic *nic,
-				  struct otx2_tc_flow *node,
-				  struct flow_cls_offload *f,
-				  u64 rate, u32 burst, u32 mark,
-				  struct npc_install_flow_req *req, bool pps)
+static int otx2_tc_act_set_hw_police(struct otx2_nic *nic,
+				     struct otx2_tc_flow *node)
 {
-	struct netlink_ext_ack *extack = f->common.extack;
-	struct otx2_hw *hw = &nic->hw;
-	int rq_idx, rc;
-
-	rq_idx = find_first_zero_bit(&nic->rq_bmap, hw->rx_queues);
-	if (rq_idx >= hw->rx_queues) {
-		NL_SET_ERR_MSG_MOD(extack, "Police action rules exceeded");
-		return -EINVAL;
-	}
+	int rc;
 
 	mutex_lock(&nic->mbox.lock);
 
@@ -306,23 +298,17 @@ static int otx2_tc_act_set_police(struct otx2_nic *nic,
 		return rc;
 	}
 
-	rc = cn10k_set_ipolicer_rate(nic, node->leaf_profile, burst, rate, pps);
+	rc = cn10k_set_ipolicer_rate(nic, node->leaf_profile,
+				     node->burst, node->rate, node->is_pps);
 	if (rc)
 		goto free_leaf;
 
-	rc = cn10k_map_unmap_rq_policer(nic, rq_idx, node->leaf_profile, true);
+	rc = cn10k_map_unmap_rq_policer(nic, node->rq, node->leaf_profile, true);
 	if (rc)
 		goto free_leaf;
 
 	mutex_unlock(&nic->mbox.lock);
 
-	req->match_id = mark & 0xFFFFULL;
-	req->index = rq_idx;
-	req->op = NIX_RX_ACTIONOP_UCAST;
-	set_bit(rq_idx, &nic->rq_bmap);
-	node->is_act_police = true;
-	node->rq = rq_idx;
-
 	return 0;
 
 free_leaf:
@@ -334,6 +320,39 @@ static int otx2_tc_act_set_police(struct otx2_nic *nic,
 	return rc;
 }
 
+static int otx2_tc_act_set_police(struct otx2_nic *nic,
+				  struct otx2_tc_flow *node,
+				  struct flow_cls_offload *f,
+				  u64 rate, u32 burst, u32 mark,
+				  struct npc_install_flow_req *req, bool pps)
+{
+	struct netlink_ext_ack *extack = f->common.extack;
+	struct otx2_hw *hw = &nic->hw;
+	int rq_idx, rc;
+
+	rq_idx = find_first_zero_bit(&nic->rq_bmap, hw->rx_queues);
+	if (rq_idx >= hw->rx_queues) {
+		NL_SET_ERR_MSG_MOD(extack, "Police action rules exceeded");
+		return -EINVAL;
+	}
+
+	req->match_id = mark & 0xFFFFULL;
+	req->index = rq_idx;
+	req->op = NIX_RX_ACTIONOP_UCAST;
+
+	node->is_act_police = true;
+	node->rq = rq_idx;
+	node->burst = burst;
+	node->rate = rate;
+	node->is_pps = pps;
+
+	rc = otx2_tc_act_set_hw_police(nic, node);
+	if (!rc)
+		set_bit(rq_idx, &nic->rq_bmap);
+
+	return rc;
+}
+
 static int otx2_tc_parse_actions(struct otx2_nic *nic,
 				 struct flow_action *flow_action,
 				 struct npc_install_flow_req *req,
@@ -986,6 +1005,11 @@ static int otx2_tc_del_flow(struct otx2_nic *nic,
 	}
 
 	if (flow_node->is_act_police) {
+		__clear_bit(flow_node->rq, &nic->rq_bmap);
+
+		if (nic->flags & OTX2_FLAG_INTF_DOWN)
+			goto free_mcam_flow;
+
 		mutex_lock(&nic->mbox.lock);
 
 		err = cn10k_map_unmap_rq_policer(nic, flow_node->rq,
@@ -1001,11 +1025,10 @@ static int otx2_tc_del_flow(struct otx2_nic *nic,
 				   "Unable to free leaf bandwidth profile(%d)\n",
 				   flow_node->leaf_profile);
 
-		__clear_bit(flow_node->rq, &nic->rq_bmap);
-
 		mutex_unlock(&nic->mbox.lock);
 	}
 
+free_mcam_flow:
 	otx2_del_mcam_flow_entry(nic, flow_node->entry, NULL);
 	otx2_tc_update_mcam_table(nic, flow_cfg, flow_node, false);
 	kfree_rcu(flow_node, rcu);
@@ -1025,6 +1048,11 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
 	if (!(nic->flags & OTX2_FLAG_TC_FLOWER_SUPPORT))
 		return -ENOMEM;
 
+	if (nic->flags & OTX2_FLAG_INTF_DOWN) {
+		NL_SET_ERR_MSG_MOD(extack, "Interface not initialized");
+		return -EINVAL;
+	}
+
 	if (flow_cfg->nr_flows == flow_cfg->max_flows) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Free MCAM entry not available to add the flow");
@@ -1384,3 +1412,45 @@ void otx2_shutdown_tc(struct otx2_nic *nic)
 	otx2_destroy_tc_flow_list(nic);
 }
 EXPORT_SYMBOL(otx2_shutdown_tc);
+
+static void otx2_tc_config_ingress_rule(struct otx2_nic *nic,
+					struct otx2_tc_flow *node)
+{
+	struct npc_install_flow_req *req;
+
+	if (otx2_tc_act_set_hw_police(nic, node))
+		return;
+
+	mutex_lock(&nic->mbox.lock);
+
+	req = otx2_mbox_alloc_msg_npc_install_flow(&nic->mbox);
+	if (!req)
+		goto err;
+
+	memcpy(req, &node->req, sizeof(struct npc_install_flow_req));
+
+	if (otx2_sync_mbox_msg(&nic->mbox))
+		netdev_err(nic->netdev,
+			   "Failed to install MCAM flow entry for ingress rule");
+err:
+	mutex_unlock(&nic->mbox.lock);
+}
+
+void otx2_tc_apply_ingress_police_rules(struct otx2_nic *nic)
+{
+	struct otx2_flow_config *flow_cfg = nic->flow_cfg;
+	struct otx2_tc_flow *node;
+
+	/* If any ingress policer rules exist for the interface then
+	 * apply those rules. Ingress policer rules depend on bandwidth
+	 * profiles linked to the receive queues. Since no receive queues
+	 * exist when interface is down, ingress policer rules are stored
+	 * and configured in hardware after all receive queues are allocated
+	 * in otx2_open.
+	 */
+	list_for_each_entry(node, &flow_cfg->flow_list_tc, list) {
+		if (node->is_act_police)
+			otx2_tc_config_ingress_rule(nic, node);
+	}
+}
+EXPORT_SYMBOL(otx2_tc_apply_ingress_police_rules);
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 295366a85c63..62cabeeb842a 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -579,6 +579,7 @@ struct rtl8169_tc_offsets {
 enum rtl_flag {
 	RTL_FLAG_TASK_ENABLED = 0,
 	RTL_FLAG_TASK_RESET_PENDING,
+	RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE,
 	RTL_FLAG_TASK_TX_TIMEOUT,
 	RTL_FLAG_MAX
 };
@@ -4582,6 +4583,8 @@ static void rtl_task(struct work_struct *work)
 reset:
 		rtl_reset_work(tp);
 		netif_wake_queue(tp->dev);
+	} else if (test_and_clear_bit(RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE, tp->wk.flags)) {
+		rtl_reset_work(tp);
 	}
 out_unlock:
 	rtnl_unlock();
@@ -4615,7 +4618,7 @@ static void r8169_phylink_handler(struct net_device *ndev)
 	} else {
 		/* In few cases rx is broken after link-down otherwise */
 		if (rtl_is_8125(tp))
-			rtl_reset_work(tp);
+			rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE);
 		pm_runtime_idle(d);
 	}
 
@@ -4691,7 +4694,7 @@ static int rtl8169_close(struct net_device *dev)
 	rtl8169_down(tp);
 	rtl8169_rx_clear(tp);
 
-	cancel_work_sync(&tp->wk.work);
+	cancel_work(&tp->wk.work);
 
 	free_irq(tp->irq, tp);
 
@@ -4925,6 +4928,8 @@ static void rtl_remove_one(struct pci_dev *pdev)
 	if (pci_dev_run_wake(pdev))
 		pm_runtime_get_noresume(&pdev->dev);
 
+	cancel_work_sync(&tp->wk.work);
+
 	unregister_netdev(tp->dev);
 
 	if (tp->dash_type != RTL_DASH_NONE)
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 0ef0b88b7145..bb56cf409042 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -515,6 +515,15 @@ static void ravb_emac_init_gbeth(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 
+	if (priv->phy_interface == PHY_INTERFACE_MODE_MII) {
+		ravb_write(ndev, (1000 << 16) | CXR35_SEL_XMII_MII, CXR35);
+		ravb_modify(ndev, CXR31, CXR31_SEL_LINK0 | CXR31_SEL_LINK1, 0);
+	} else {
+		ravb_write(ndev, (1000 << 16) | CXR35_SEL_XMII_RGMII, CXR35);
+		ravb_modify(ndev, CXR31, CXR31_SEL_LINK0 | CXR31_SEL_LINK1,
+			    CXR31_SEL_LINK0);
+	}
+
 	/* Receive frame limit set register */
 	ravb_write(ndev, GBETH_RX_BUFF_MAX + ETH_FCS_LEN, RFLR);
 
@@ -537,14 +546,6 @@ static void ravb_emac_init_gbeth(struct net_device *ndev)
 
 	/* E-MAC interrupt enable register */
 	ravb_write(ndev, ECSIPR_ICDIP, ECSIPR);
-
-	if (priv->phy_interface == PHY_INTERFACE_MODE_MII) {
-		ravb_modify(ndev, CXR31, CXR31_SEL_LINK0 | CXR31_SEL_LINK1, 0);
-		ravb_write(ndev, (1000 << 16) | CXR35_SEL_XMII_MII, CXR35);
-	} else {
-		ravb_modify(ndev, CXR31, CXR31_SEL_LINK0 | CXR31_SEL_LINK1,
-			    CXR31_SEL_LINK0);
-	}
 }
 
 static void ravb_emac_init_rcar(struct net_device *ndev)
@@ -1811,19 +1812,20 @@ static int ravb_open(struct net_device *ndev)
 	if (info->gptp)
 		ravb_ptp_init(ndev, priv->pdev);
 
-	netif_tx_start_all_queues(ndev);
-
 	/* PHY control start */
 	error = ravb_phy_start(ndev);
 	if (error)
 		goto out_ptp_stop;
 
+	netif_tx_start_all_queues(ndev);
+
 	return 0;
 
 out_ptp_stop:
 	/* Stop PTP Clock driver */
 	if (info->gptp)
 		ravb_ptp_stop(ndev);
+	ravb_stop_dma(ndev);
 out_free_irq_mgmta:
 	if (!info->multi_irqs)
 		goto out_free_irq;
@@ -1874,6 +1876,12 @@ static void ravb_tx_timeout_work(struct work_struct *work)
 	struct net_device *ndev = priv->ndev;
 	int error;
 
+	if (!rtnl_trylock()) {
+		usleep_range(1000, 2000);
+		schedule_work(&priv->work);
+		return;
+	}
+
 	netif_tx_stop_all_queues(ndev);
 
 	/* Stop PTP Clock driver */
@@ -1907,7 +1915,7 @@ static void ravb_tx_timeout_work(struct work_struct *work)
 		 */
 		netdev_err(ndev, "%s: ravb_dmac_init() failed, error %d\n",
 			   __func__, error);
-		return;
+		goto out_unlock;
 	}
 	ravb_emac_init(ndev);
 
@@ -1917,6 +1925,9 @@ static void ravb_tx_timeout_work(struct work_struct *work)
 		ravb_ptp_init(ndev, priv->pdev);
 
 	netif_tx_start_all_queues(ndev);
+
+out_unlock:
+	rtnl_unlock();
 }
 
 /* Packet transmit function for Ethernet AVB */
@@ -2645,9 +2656,14 @@ static int ravb_probe(struct platform_device *pdev)
 	ndev->features = info->net_features;
 	ndev->hw_features = info->net_hw_features;
 
-	reset_control_deassert(rstc);
+	error = reset_control_deassert(rstc);
+	if (error)
+		goto out_free_netdev;
+
 	pm_runtime_enable(&pdev->dev);
-	pm_runtime_get_sync(&pdev->dev);
+	error = pm_runtime_resume_and_get(&pdev->dev);
+	if (error < 0)
+		goto out_rpm_disable;
 
 	if (info->multi_irqs) {
 		if (info->err_mgmt_irqs)
@@ -2872,11 +2888,12 @@ static int ravb_probe(struct platform_device *pdev)
 out_disable_refclk:
 	clk_disable_unprepare(priv->refclk);
 out_release:
-	free_netdev(ndev);
-
 	pm_runtime_put(&pdev->dev);
+out_rpm_disable:
 	pm_runtime_disable(&pdev->dev);
 	reset_control_assert(rstc);
+out_free_netdev:
+	free_netdev(ndev);
 	return error;
 }
 
@@ -2886,22 +2903,26 @@ static int ravb_remove(struct platform_device *pdev)
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
 
-	/* Stop PTP Clock driver */
-	if (info->ccc_gac)
-		ravb_ptp_stop(ndev);
-
-	clk_disable_unprepare(priv->gptp_clk);
-	clk_disable_unprepare(priv->refclk);
-
-	/* Set reset mode */
-	ravb_write(ndev, CCC_OPC_RESET, CCC);
 	unregister_netdev(ndev);
 	if (info->nc_queues)
 		netif_napi_del(&priv->napi[RAVB_NC]);
 	netif_napi_del(&priv->napi[RAVB_BE]);
+
 	ravb_mdio_release(priv);
+
+	/* Stop PTP Clock driver */
+	if (info->ccc_gac)
+		ravb_ptp_stop(ndev);
+
 	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
 			  priv->desc_bat_dma);
+
+	/* Set reset mode */
+	ravb_write(ndev, CCC_OPC_RESET, CCC);
+
+	clk_disable_unprepare(priv->gptp_clk);
+	clk_disable_unprepare(priv->refclk);
+
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	reset_control_assert(priv->rstc);
diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index 0fc0b6bea753..ae9d8722b76f 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1501,8 +1501,8 @@ static netdev_tx_t rswitch_start_xmit(struct sk_buff *skb, struct net_device *nd
 {
 	struct rswitch_device *rdev = netdev_priv(ndev);
 	struct rswitch_gwca_queue *gq = rdev->tx_queue;
+	netdev_tx_t ret = NETDEV_TX_OK;
 	struct rswitch_ext_desc *desc;
-	int ret = NETDEV_TX_OK;
 	dma_addr_t dma_addr;
 
 	if (rswitch_get_num_cur_queues(gq) >= gq->ring_size - 1) {
@@ -1514,10 +1514,8 @@ static netdev_tx_t rswitch_start_xmit(struct sk_buff *skb, struct net_device *nd
 		return ret;
 
 	dma_addr = dma_map_single(ndev->dev.parent, skb->data, skb->len, DMA_TO_DEVICE);
-	if (dma_mapping_error(ndev->dev.parent, dma_addr)) {
-		dev_kfree_skb_any(skb);
-		return ret;
-	}
+	if (dma_mapping_error(ndev->dev.parent, dma_addr))
+		goto err_kfree;
 
 	gq->skbs[gq->cur] = skb;
 	desc = &gq->tx_ring[gq->cur];
@@ -1530,10 +1528,8 @@ static netdev_tx_t rswitch_start_xmit(struct sk_buff *skb, struct net_device *nd
 		struct rswitch_gwca_ts_info *ts_info;
 
 		ts_info = kzalloc(sizeof(*ts_info), GFP_ATOMIC);
-		if (!ts_info) {
-			dma_unmap_single(ndev->dev.parent, dma_addr, skb->len, DMA_TO_DEVICE);
-			return -ENOMEM;
-		}
+		if (!ts_info)
+			goto err_unmap;
 
 		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 		rdev->ts_tag++;
@@ -1555,6 +1551,14 @@ static netdev_tx_t rswitch_start_xmit(struct sk_buff *skb, struct net_device *nd
 	gq->cur = rswitch_next_queue_index(gq, true, 1);
 	rswitch_modify(rdev->addr, GWTRC(gq->index), 0, BIT(gq->index % 32));
 
+	return ret;
+
+err_unmap:
+	dma_unmap_single(ndev->dev.parent, dma_addr, skb->len, DMA_TO_DEVICE);
+
+err_kfree:
+	dev_kfree_skb_any(skb);
+
 	return ret;
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
index ea4910ae0921..6a7c1d325c46 100644
--- a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
@@ -177,8 +177,10 @@
 #define MMC_XGMAC_RX_DISCARD_OCT_GB	0x1b4
 #define MMC_XGMAC_RX_ALIGN_ERR_PKT	0x1bc
 
+#define MMC_XGMAC_TX_FPE_INTR_MASK	0x204
 #define MMC_XGMAC_TX_FPE_FRAG		0x208
 #define MMC_XGMAC_TX_HOLD_REQ		0x20c
+#define MMC_XGMAC_RX_FPE_INTR_MASK	0x224
 #define MMC_XGMAC_RX_PKT_ASSEMBLY_ERR	0x228
 #define MMC_XGMAC_RX_PKT_SMD_ERR	0x22c
 #define MMC_XGMAC_RX_PKT_ASSEMBLY_OK	0x230
@@ -352,6 +354,8 @@ static void dwxgmac_mmc_intr_all_mask(void __iomem *mmcaddr)
 {
 	writel(0x0, mmcaddr + MMC_RX_INTR_MASK);
 	writel(0x0, mmcaddr + MMC_TX_INTR_MASK);
+	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_XGMAC_TX_FPE_INTR_MASK);
+	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_XGMAC_RX_FPE_INTR_MASK);
 	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_XGMAC_RX_IPC_INTR_MASK);
 }
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index e04d4a5eed7b..21505920136c 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1965,11 +1965,11 @@ void wx_reset_interrupt_capability(struct wx *wx)
 	if (!pdev->msi_enabled && !pdev->msix_enabled)
 		return;
 
-	pci_free_irq_vectors(wx->pdev);
 	if (pdev->msix_enabled) {
 		kfree(wx->msix_entries);
 		wx->msix_entries = NULL;
 	}
+	pci_free_irq_vectors(wx->pdev);
 }
 EXPORT_SYMBOL(wx_reset_interrupt_capability);
 
diff --git a/drivers/net/netdevsim/bpf.c b/drivers/net/netdevsim/bpf.c
index f60eb97e3a62..608953d4f98d 100644
--- a/drivers/net/netdevsim/bpf.c
+++ b/drivers/net/netdevsim/bpf.c
@@ -93,7 +93,7 @@ static void nsim_prog_set_loaded(struct bpf_prog *prog, bool loaded)
 {
 	struct nsim_bpf_bound_prog *state;
 
-	if (!prog || !prog->aux->offload)
+	if (!prog || !bpf_prog_is_offloaded(prog->aux))
 		return;
 
 	state = prog->aux->offload->dev_priv;
@@ -311,7 +311,7 @@ nsim_setup_prog_hw_checks(struct netdevsim *ns, struct netdev_bpf *bpf)
 	if (!bpf->prog)
 		return 0;
 
-	if (!bpf->prog->aux->offload) {
+	if (!bpf_prog_is_offloaded(bpf->prog->aux)) {
 		NSIM_EA(bpf->extack, "xdpoffload of non-bound program");
 		return -EINVAL;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 56f51344c193..1ccbe8c1eeb4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -705,8 +705,10 @@ int iwl_mvm_mld_add_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			rcu_dereference_protected(mvm_sta->link[link_id],
 						  lockdep_is_held(&mvm->mutex));
 
-		if (WARN_ON(!link_conf || !mvm_link_sta))
+		if (WARN_ON(!link_conf || !mvm_link_sta)) {
+			ret = -EINVAL;
 			goto err;
+		}
 
 		ret = iwl_mvm_mld_cfg_sta(mvm, sta, vif, link_sta, link_conf,
 					  mvm_link_sta);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 21783aa2ee8e..c09048984a27 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2026,6 +2026,13 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	if (ret)
 		return ret;
 
+	if (id->ncap == 0) {
+		/* namespace not allocated or attached */
+		info->is_removed = true;
+		ret = -ENODEV;
+		goto error;
+	}
+
 	blk_mq_freeze_queue(ns->disk->queue);
 	lbaf = nvme_lbaf_index(id->flbas);
 	ns->lba_shift = id->lbaf[lbaf].ds;
@@ -2083,6 +2090,8 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 		set_bit(NVME_NS_READY, &ns->flags);
 		ret = 0;
 	}
+
+error:
 	kfree(id);
 	return ret;
 }
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index e9dc9638120a..184ec92241ca 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1253,17 +1253,17 @@ static void pinctrl_link_add(struct pinctrl_dev *pctldev,
 static int pinctrl_commit_state(struct pinctrl *p, struct pinctrl_state *state)
 {
 	struct pinctrl_setting *setting, *setting2;
-	struct pinctrl_state *old_state = p->state;
+	struct pinctrl_state *old_state = READ_ONCE(p->state);
 	int ret;
 
-	if (p->state) {
+	if (old_state) {
 		/*
 		 * For each pinmux setting in the old state, forget SW's record
 		 * of mux owner for that pingroup. Any pingroups which are
 		 * still owned by the new state will be re-acquired by the call
 		 * to pinmux_enable_setting() in the loop below.
 		 */
-		list_for_each_entry(setting, &p->state->settings, node) {
+		list_for_each_entry(setting, &old_state->settings, node) {
 			if (setting->type != PIN_MAP_TYPE_MUX_GROUP)
 				continue;
 			pinmux_disable_setting(setting);
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index a73385a431de..346a31f31bba 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -1283,9 +1283,11 @@ static struct stm32_desc_pin *stm32_pctrl_get_desc_pin_from_gpio(struct stm32_pi
 	int i;
 
 	/* With few exceptions (e.g. bank 'Z'), pin number matches with pin index in array */
-	pin_desc = pctl->pins + stm32_pin_nb;
-	if (pin_desc->pin.number == stm32_pin_nb)
-		return pin_desc;
+	if (stm32_pin_nb < pctl->npins) {
+		pin_desc = pctl->pins + stm32_pin_nb;
+		if (pin_desc->pin.number == stm32_pin_nb)
+			return pin_desc;
+	}
 
 	/* Otherwise, loop all array to find the pin with the right number */
 	for (i = 0; i < pctl->npins; i++) {
@@ -1378,6 +1380,11 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl, struct fwnode
 	}
 
 	names = devm_kcalloc(dev, npins, sizeof(char *), GFP_KERNEL);
+	if (!names) {
+		err = -ENOMEM;
+		goto err_clk;
+	}
+
 	for (i = 0; i < npins; i++) {
 		stm32_pin = stm32_pctrl_get_desc_pin_from_gpio(pctl, bank, i);
 		if (stm32_pin && stm32_pin->pin.name)
diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 2ff7717530bf..8a2f18fa3faf 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -24,7 +24,6 @@
 #include <linux/of.h>
 #include <linux/pm_qos.h>
 #include <linux/slab.h>
-#include <linux/units.h>
 
 struct dtpm_cpu {
 	struct dtpm dtpm;
@@ -104,8 +103,7 @@ static u64 get_pd_power_uw(struct dtpm *dtpm)
 		if (pd->table[i].frequency < freq)
 			continue;
 
-		return scale_pd_power_uw(pd_mask, pd->table[i].power *
-					 MICROWATT_PER_MILLIWATT);
+		return scale_pd_power_uw(pd_mask, pd->table[i].power);
 	}
 
 	return 0;
@@ -122,11 +120,9 @@ static int update_pd_power_uw(struct dtpm *dtpm)
 	nr_cpus = cpumask_weight(&cpus);
 
 	dtpm->power_min = em->table[0].power;
-	dtpm->power_min *= MICROWATT_PER_MILLIWATT;
 	dtpm->power_min *= nr_cpus;
 
 	dtpm->power_max = em->table[em->nr_perf_states - 1].power;
-	dtpm->power_max *= MICROWATT_PER_MILLIWATT;
 	dtpm->power_max *= nr_cpus;
 
 	return 0;
diff --git a/drivers/powercap/dtpm_devfreq.c b/drivers/powercap/dtpm_devfreq.c
index 91276761a31d..612c3b59dd5b 100644
--- a/drivers/powercap/dtpm_devfreq.c
+++ b/drivers/powercap/dtpm_devfreq.c
@@ -39,10 +39,8 @@ static int update_pd_power_uw(struct dtpm *dtpm)
 	struct em_perf_domain *pd = em_pd_get(dev);
 
 	dtpm->power_min = pd->table[0].power;
-	dtpm->power_min *= MICROWATT_PER_MILLIWATT;
 
 	dtpm->power_max = pd->table[pd->nr_perf_states - 1].power;
-	dtpm->power_max *= MICROWATT_PER_MILLIWATT;
 
 	return 0;
 }
@@ -54,13 +52,10 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
 	struct device *dev = devfreq->dev.parent;
 	struct em_perf_domain *pd = em_pd_get(dev);
 	unsigned long freq;
-	u64 power;
 	int i;
 
 	for (i = 0; i < pd->nr_perf_states; i++) {
-
-		power = pd->table[i].power * MICROWATT_PER_MILLIWATT;
-		if (power > power_limit)
+		if (pd->table[i].power > power_limit)
 			break;
 	}
 
@@ -68,7 +63,7 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
 
 	dev_pm_qos_update_request(&dtpm_devfreq->qos_req, freq);
 
-	power_limit = pd->table[i - 1].power * MICROWATT_PER_MILLIWATT;
+	power_limit = pd->table[i - 1].power;
 
 	return power_limit;
 }
@@ -110,7 +105,7 @@ static u64 get_pd_power_uw(struct dtpm *dtpm)
 		if (pd->table[i].frequency < freq)
 			continue;
 
-		power = pd->table[i].power * MICROWATT_PER_MILLIWATT;
+		power = pd->table[i].power;
 		power *= status.busy_time;
 		power >>= 10;
 
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 6effa13039f3..e17509f0b3fa 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3953,8 +3953,15 @@ static int sd_resume(struct device *dev, bool runtime)
 
 static int sd_resume_system(struct device *dev)
 {
-	if (pm_runtime_suspended(dev))
+	if (pm_runtime_suspended(dev)) {
+		struct scsi_disk *sdkp = dev_get_drvdata(dev);
+		struct scsi_device *sdp = sdkp ? sdkp->device : NULL;
+
+		if (sdp && sdp->force_runtime_start_on_system_start)
+			pm_request_resume(dev);
+
 		return 0;
+	}
 
 	return sd_resume(dev, false);
 }
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index a4b483a393c9..170fbd5715b2 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -6347,11 +6347,24 @@ static bool ufshcd_abort_one(struct request *rq, void *priv)
 	struct scsi_device *sdev = cmd->device;
 	struct Scsi_Host *shost = sdev->host;
 	struct ufs_hba *hba = shost_priv(shost);
+	struct ufshcd_lrb *lrbp = &hba->lrb[tag];
+	struct ufs_hw_queue *hwq;
+	unsigned long flags;
 
 	*ret = ufshcd_try_to_abort_task(hba, tag);
 	dev_err(hba->dev, "Aborting tag %d / CDB %#02x %s\n", tag,
 		hba->lrb[tag].cmd ? hba->lrb[tag].cmd->cmnd[0] : -1,
 		*ret ? "failed" : "succeeded");
+
+	/* Release cmd in MCQ mode if abort succeeds */
+	if (is_mcq_enabled(hba) && (*ret == 0)) {
+		hwq = ufshcd_mcq_req_to_hwq(hba, scsi_cmd_to_rq(lrbp->cmd));
+		spin_lock_irqsave(&hwq->cq_lock, flags);
+		if (ufshcd_cmd_inflight(lrbp->cmd))
+			ufshcd_release_scsi_cmd(hba, lrbp);
+		spin_unlock_irqrestore(&hwq->cq_lock, flags);
+	}
+
 	return *ret == 0;
 }
 
diff --git a/drivers/vfio/pci/pds/pci_drv.c b/drivers/vfio/pci/pds/pci_drv.c
index ab4b5958e413..caffa1a2cf59 100644
--- a/drivers/vfio/pci/pds/pci_drv.c
+++ b/drivers/vfio/pci/pds/pci_drv.c
@@ -55,10 +55,10 @@ static void pds_vfio_recovery(struct pds_vfio_pci_device *pds_vfio)
 	 * VFIO_DEVICE_STATE_RUNNING.
 	 */
 	if (deferred_reset_needed) {
-		spin_lock(&pds_vfio->reset_lock);
+		mutex_lock(&pds_vfio->reset_mutex);
 		pds_vfio->deferred_reset = true;
 		pds_vfio->deferred_reset_state = VFIO_DEVICE_STATE_ERROR;
-		spin_unlock(&pds_vfio->reset_lock);
+		mutex_unlock(&pds_vfio->reset_mutex);
 	}
 }
 
diff --git a/drivers/vfio/pci/pds/vfio_dev.c b/drivers/vfio/pci/pds/vfio_dev.c
index 649b18ee394b..4c351c59d05a 100644
--- a/drivers/vfio/pci/pds/vfio_dev.c
+++ b/drivers/vfio/pci/pds/vfio_dev.c
@@ -29,7 +29,7 @@ struct pds_vfio_pci_device *pds_vfio_pci_drvdata(struct pci_dev *pdev)
 void pds_vfio_state_mutex_unlock(struct pds_vfio_pci_device *pds_vfio)
 {
 again:
-	spin_lock(&pds_vfio->reset_lock);
+	mutex_lock(&pds_vfio->reset_mutex);
 	if (pds_vfio->deferred_reset) {
 		pds_vfio->deferred_reset = false;
 		if (pds_vfio->state == VFIO_DEVICE_STATE_ERROR) {
@@ -39,23 +39,23 @@ void pds_vfio_state_mutex_unlock(struct pds_vfio_pci_device *pds_vfio)
 		}
 		pds_vfio->state = pds_vfio->deferred_reset_state;
 		pds_vfio->deferred_reset_state = VFIO_DEVICE_STATE_RUNNING;
-		spin_unlock(&pds_vfio->reset_lock);
+		mutex_unlock(&pds_vfio->reset_mutex);
 		goto again;
 	}
 	mutex_unlock(&pds_vfio->state_mutex);
-	spin_unlock(&pds_vfio->reset_lock);
+	mutex_unlock(&pds_vfio->reset_mutex);
 }
 
 void pds_vfio_reset(struct pds_vfio_pci_device *pds_vfio)
 {
-	spin_lock(&pds_vfio->reset_lock);
+	mutex_lock(&pds_vfio->reset_mutex);
 	pds_vfio->deferred_reset = true;
 	pds_vfio->deferred_reset_state = VFIO_DEVICE_STATE_RUNNING;
 	if (!mutex_trylock(&pds_vfio->state_mutex)) {
-		spin_unlock(&pds_vfio->reset_lock);
+		mutex_unlock(&pds_vfio->reset_mutex);
 		return;
 	}
-	spin_unlock(&pds_vfio->reset_lock);
+	mutex_unlock(&pds_vfio->reset_mutex);
 	pds_vfio_state_mutex_unlock(pds_vfio);
 }
 
@@ -155,6 +155,9 @@ static int pds_vfio_init_device(struct vfio_device *vdev)
 
 	pds_vfio->vf_id = vf_id;
 
+	mutex_init(&pds_vfio->state_mutex);
+	mutex_init(&pds_vfio->reset_mutex);
+
 	vdev->migration_flags = VFIO_MIGRATION_STOP_COPY | VFIO_MIGRATION_P2P;
 	vdev->mig_ops = &pds_vfio_lm_ops;
 	vdev->log_ops = &pds_vfio_log_ops;
@@ -168,6 +171,17 @@ static int pds_vfio_init_device(struct vfio_device *vdev)
 	return 0;
 }
 
+static void pds_vfio_release_device(struct vfio_device *vdev)
+{
+	struct pds_vfio_pci_device *pds_vfio =
+		container_of(vdev, struct pds_vfio_pci_device,
+			     vfio_coredev.vdev);
+
+	mutex_destroy(&pds_vfio->state_mutex);
+	mutex_destroy(&pds_vfio->reset_mutex);
+	vfio_pci_core_release_dev(vdev);
+}
+
 static int pds_vfio_open_device(struct vfio_device *vdev)
 {
 	struct pds_vfio_pci_device *pds_vfio =
@@ -179,7 +193,6 @@ static int pds_vfio_open_device(struct vfio_device *vdev)
 	if (err)
 		return err;
 
-	mutex_init(&pds_vfio->state_mutex);
 	pds_vfio->state = VFIO_DEVICE_STATE_RUNNING;
 	pds_vfio->deferred_reset_state = VFIO_DEVICE_STATE_RUNNING;
 
@@ -199,14 +212,13 @@ static void pds_vfio_close_device(struct vfio_device *vdev)
 	pds_vfio_put_save_file(pds_vfio);
 	pds_vfio_dirty_disable(pds_vfio, true);
 	mutex_unlock(&pds_vfio->state_mutex);
-	mutex_destroy(&pds_vfio->state_mutex);
 	vfio_pci_core_close_device(vdev);
 }
 
 static const struct vfio_device_ops pds_vfio_ops = {
 	.name = "pds-vfio",
 	.init = pds_vfio_init_device,
-	.release = vfio_pci_core_release_dev,
+	.release = pds_vfio_release_device,
 	.open_device = pds_vfio_open_device,
 	.close_device = pds_vfio_close_device,
 	.ioctl = vfio_pci_core_ioctl,
diff --git a/drivers/vfio/pci/pds/vfio_dev.h b/drivers/vfio/pci/pds/vfio_dev.h
index b8f2d667608f..e7b01080a1ec 100644
--- a/drivers/vfio/pci/pds/vfio_dev.h
+++ b/drivers/vfio/pci/pds/vfio_dev.h
@@ -18,7 +18,7 @@ struct pds_vfio_pci_device {
 	struct pds_vfio_dirty dirty;
 	struct mutex state_mutex; /* protect migration state */
 	enum vfio_device_mig_state state;
-	spinlock_t reset_lock; /* protect reset_done flow */
+	struct mutex reset_mutex; /* protect reset_done flow */
 	u8 deferred_reset;
 	enum vfio_device_mig_state deferred_reset_state;
 	struct notifier_block nb;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 6b78517b1fd5..71efb6883f30 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3197,6 +3197,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_alloc;
 	}
 
+	btrfs_info(fs_info, "first mount of filesystem %pU", disk_super->fsid);
 	/*
 	 * Verify the type first, if that or the checksum value are
 	 * corrupted, we'll find out
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index caccd0376342..1530df88370c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -675,8 +675,8 @@ static void end_bio_extent_readpage(struct btrfs_bio *bbio)
  * 		the array will be skipped
  *
  * Return: 0        if all pages were able to be allocated;
- *         -ENOMEM  otherwise, and the caller is responsible for freeing all
- *                  non-null page pointers in the array.
+ *         -ENOMEM  otherwise, the partially allocated pages would be freed and
+ *                  the array slots zeroed
  */
 int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array)
 {
@@ -695,8 +695,13 @@ int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array)
 		 * though alloc_pages_bulk_array() falls back to alloc_page()
 		 * if  it could not bulk-allocate. So we must be out of memory.
 		 */
-		if (allocated == last)
+		if (allocated == last) {
+			for (int i = 0; i < allocated; i++) {
+				__free_page(page_array[i]);
+				page_array[i] = NULL;
+			}
 			return -ENOMEM;
+		}
 
 		memalloc_retry_wait(GFP_NOFS);
 	}
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 4cb4065453dd..0b120716aeb9 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4351,6 +4351,7 @@ static int _btrfs_ioctl_send(struct inode *inode, void __user *argp, bool compat
 		arg->clone_sources = compat_ptr(args32.clone_sources);
 		arg->parent_root = args32.parent_root;
 		arg->flags = args32.flags;
+		arg->version = args32.version;
 		memcpy(arg->reserved, args32.reserved,
 		       sizeof(args32.reserved));
 #else
diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 95d28497de7c..e646662e61c6 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -791,6 +791,7 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
 			dump_ref_action(fs_info, ra);
 			kfree(ref);
 			kfree(ra);
+			kfree(re);
 			goto out_unlock;
 		} else if (be->num_refs == 0) {
 			btrfs_err(fs_info,
@@ -800,6 +801,7 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
 			dump_ref_action(fs_info, ra);
 			kfree(ref);
 			kfree(ra);
+			kfree(re);
 			goto out_unlock;
 		}
 
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 3a566150c531..db94eefda27e 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -8158,7 +8158,7 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 	}
 
 	sctx->send_filp = fget(arg->send_fd);
-	if (!sctx->send_filp) {
+	if (!sctx->send_filp || !(sctx->send_filp->f_mode & FMODE_WRITE)) {
 		ret = -EBADF;
 		goto out;
 	}
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 1a093ec0f7e3..de0bfebce126 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -79,7 +79,10 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data);
 
 static void btrfs_put_super(struct super_block *sb)
 {
-	close_ctree(btrfs_sb(sb));
+	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
+
+	btrfs_info(fs_info, "last unmount of filesystem %pU", fs_info->fs_devices->fsid);
+	close_ctree(fs_info);
 }
 
 enum {
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c26d3499a289..722a1dde7563 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3045,15 +3045,16 @@ struct extent_map *btrfs_get_chunk_map(struct btrfs_fs_info *fs_info,
 	read_unlock(&em_tree->lock);
 
 	if (!em) {
-		btrfs_crit(fs_info, "unable to find logical %llu length %llu",
+		btrfs_crit(fs_info,
+			   "unable to find chunk map for logical %llu length %llu",
 			   logical, length);
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (em->start > logical || em->start + em->len < logical) {
+	if (em->start > logical || em->start + em->len <= logical) {
 		btrfs_crit(fs_info,
-			   "found a bad mapping, wanted %llu-%llu, found %llu-%llu",
-			   logical, length, em->start, em->start + em->len);
+			   "found a bad chunk map, wanted %llu-%llu, found %llu-%llu",
+			   logical, logical + length, em->start, em->start + em->len);
 		free_extent_map(em);
 		return ERR_PTR(-EINVAL);
 	}
diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index 1039e5bf90af..4ddc36f4dbd4 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -258,7 +258,6 @@ static ssize_t ext2_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			goto out_unlock;
 		}
 
-		iocb->ki_pos += status;
 		ret += status;
 		endbyte = pos + status - 1;
 		ret2 = filemap_write_and_wait_range(inode->i_mapping, pos,
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index c03a286ed418..d6aa5e474d5e 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -748,7 +748,7 @@ bool cifs_reparse_point_to_fattr(struct cifs_sb_info *cifs_sb,
 	case 0: /* SMB1 symlink */
 	case IO_REPARSE_TAG_SYMLINK:
 	case IO_REPARSE_TAG_NFS:
-		fattr->cf_mode = S_IFLNK;
+		fattr->cf_mode = S_IFLNK | cifs_sb->ctx->file_mode;
 		fattr->cf_dtype = DT_LNK;
 		break;
 	default:
@@ -823,6 +823,8 @@ static void cifs_open_info_to_fattr(struct cifs_fattr *fattr,
 
 out_reparse:
 	if (S_ISLNK(fattr->cf_mode)) {
+		if (likely(data->symlink_target))
+			fattr->cf_eof = strnlen(data->symlink_target, PATH_MAX);
 		fattr->cf_symlink_target = data->symlink_target;
 		data->symlink_target = NULL;
 	}
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 0f8fa78cd47b..b2a60aa6564f 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3305,6 +3305,7 @@ static long smb3_zero_range(struct file *file, struct cifs_tcon *tcon,
 	struct inode *inode = file_inode(file);
 	struct cifsInodeInfo *cifsi = CIFS_I(inode);
 	struct cifsFileInfo *cfile = file->private_data;
+	unsigned long long new_size;
 	long rc;
 	unsigned int xid;
 	__le64 eof;
@@ -3335,10 +3336,15 @@ static long smb3_zero_range(struct file *file, struct cifs_tcon *tcon,
 	/*
 	 * do we also need to change the size of the file?
 	 */
-	if (keep_size == false && i_size_read(inode) < offset + len) {
-		eof = cpu_to_le64(offset + len);
+	new_size = offset + len;
+	if (keep_size == false && (unsigned long long)i_size_read(inode) < new_size) {
+		eof = cpu_to_le64(new_size);
 		rc = SMB2_set_eof(xid, tcon, cfile->fid.persistent_fid,
 				  cfile->fid.volatile_fid, cfile->pid, &eof);
+		if (rc >= 0) {
+			truncate_setsize(inode, new_size);
+			fscache_resize_cookie(cifs_inode_cookie(inode), new_size);
+		}
 	}
 
  zero_range_exit:
@@ -3733,6 +3739,9 @@ static long smb3_insert_range(struct file *file, struct cifs_tcon *tcon,
 	if (rc < 0)
 		goto out_2;
 
+	truncate_setsize(inode, old_eof + len);
+	fscache_resize_cookie(cifs_inode_cookie(inode), i_size_read(inode));
+
 	rc = smb2_copychunk_range(xid, cfile, cfile, off, count, off + len);
 	if (rc < 0)
 		goto out_2;
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 93262ca3f58a..269fbfb3cd67 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2380,7 +2380,8 @@ static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
 			rc = 0;
 		} else {
 			rc = ksmbd_vfs_setxattr(idmap, path, attr_name, value,
-						le16_to_cpu(eabuf->EaValueLength), 0);
+						le16_to_cpu(eabuf->EaValueLength),
+						0, true);
 			if (rc < 0) {
 				ksmbd_debug(SMB,
 					    "ksmbd_vfs_setxattr is failed(%d)\n",
@@ -2443,7 +2444,7 @@ static noinline int smb2_set_stream_name_xattr(const struct path *path,
 		return -EBADF;
 	}
 
-	rc = ksmbd_vfs_setxattr(idmap, path, xattr_stream_name, NULL, 0, 0);
+	rc = ksmbd_vfs_setxattr(idmap, path, xattr_stream_name, NULL, 0, 0, false);
 	if (rc < 0)
 		pr_err("Failed to store XATTR stream name :%d\n", rc);
 	return 0;
@@ -2518,7 +2519,7 @@ static void smb2_new_xattrs(struct ksmbd_tree_connect *tcon, const struct path *
 	da.flags = XATTR_DOSINFO_ATTRIB | XATTR_DOSINFO_CREATE_TIME |
 		XATTR_DOSINFO_ITIME;
 
-	rc = ksmbd_vfs_set_dos_attrib_xattr(mnt_idmap(path->mnt), path, &da);
+	rc = ksmbd_vfs_set_dos_attrib_xattr(mnt_idmap(path->mnt), path, &da, false);
 	if (rc)
 		ksmbd_debug(SMB, "failed to store file attribute into xattr\n");
 }
@@ -2608,7 +2609,7 @@ static int smb2_create_sd_buffer(struct ksmbd_work *work,
 	    sizeof(struct create_sd_buf_req))
 		return -EINVAL;
 	return set_info_sec(work->conn, work->tcon, path, &sd_buf->ntsd,
-			    le32_to_cpu(sd_buf->ccontext.DataLength), true);
+			    le32_to_cpu(sd_buf->ccontext.DataLength), true, false);
 }
 
 static void ksmbd_acls_fattr(struct smb_fattr *fattr,
@@ -3152,7 +3153,8 @@ int smb2_open(struct ksmbd_work *work)
 								    idmap,
 								    &path,
 								    pntsd,
-								    pntsd_size);
+								    pntsd_size,
+								    false);
 					kfree(pntsd);
 					if (rc)
 						pr_err("failed to store ntacl in xattr : %d\n",
@@ -3228,12 +3230,6 @@ int smb2_open(struct ksmbd_work *work)
 	if (req->CreateOptions & FILE_DELETE_ON_CLOSE_LE)
 		ksmbd_fd_set_delete_on_close(fp, file_info);
 
-	if (need_truncate) {
-		rc = smb2_create_truncate(&path);
-		if (rc)
-			goto err_out;
-	}
-
 	if (req->CreateContextsOffset) {
 		struct create_alloc_size_req *az_req;
 
@@ -3398,11 +3394,12 @@ int smb2_open(struct ksmbd_work *work)
 	}
 
 err_out:
-	if (file_present || created) {
-		inode_unlock(d_inode(parent_path.dentry));
-		path_put(&path);
-		path_put(&parent_path);
-	}
+	if (file_present || created)
+		ksmbd_vfs_kern_path_unlock(&parent_path, &path);
+
+	if (fp && need_truncate)
+		rc = smb2_create_truncate(&fp->filp->f_path);
+
 	ksmbd_revert_fsids(work);
 err_out1:
 	if (!rc) {
@@ -5537,7 +5534,7 @@ static int smb2_rename(struct ksmbd_work *work,
 		rc = ksmbd_vfs_setxattr(file_mnt_idmap(fp->filp),
 					&fp->filp->f_path,
 					xattr_stream_name,
-					NULL, 0, 0);
+					NULL, 0, 0, true);
 		if (rc < 0) {
 			pr_err("failed to store stream name in xattr: %d\n",
 			       rc);
@@ -5630,11 +5627,9 @@ static int smb2_create_link(struct ksmbd_work *work,
 	if (rc)
 		rc = -EINVAL;
 out:
-	if (file_present) {
-		inode_unlock(d_inode(parent_path.dentry));
-		path_put(&path);
-		path_put(&parent_path);
-	}
+	if (file_present)
+		ksmbd_vfs_kern_path_unlock(&parent_path, &path);
+
 	if (!IS_ERR(link_name))
 		kfree(link_name);
 	kfree(pathname);
@@ -5701,7 +5696,8 @@ static int set_file_basic_info(struct ksmbd_file *fp,
 		da.flags = XATTR_DOSINFO_ATTRIB | XATTR_DOSINFO_CREATE_TIME |
 			XATTR_DOSINFO_ITIME;
 
-		rc = ksmbd_vfs_set_dos_attrib_xattr(idmap, &filp->f_path, &da);
+		rc = ksmbd_vfs_set_dos_attrib_xattr(idmap, &filp->f_path, &da,
+				true);
 		if (rc)
 			ksmbd_debug(SMB,
 				    "failed to restore file attribute in EA\n");
@@ -6013,7 +6009,7 @@ static int smb2_set_info_sec(struct ksmbd_file *fp, int addition_info,
 	fp->saccess |= FILE_SHARE_DELETE_LE;
 
 	return set_info_sec(fp->conn, fp->tcon, &fp->filp->f_path, pntsd,
-			buf_len, false);
+			buf_len, false, true);
 }
 
 /**
@@ -7582,7 +7578,8 @@ static inline int fsctl_set_sparse(struct ksmbd_work *work, u64 id,
 
 		da.attr = le32_to_cpu(fp->f_ci->m_fattr);
 		ret = ksmbd_vfs_set_dos_attrib_xattr(idmap,
-						     &fp->filp->f_path, &da);
+						     &fp->filp->f_path,
+						     &da, true);
 		if (ret)
 			fp->f_ci->m_fattr = old_fattr;
 	}
diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 51b8bfab7481..1164365533f0 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -1185,7 +1185,7 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 			pntsd_size += sizeof(struct smb_acl) + nt_size;
 		}
 
-		ksmbd_vfs_set_sd_xattr(conn, idmap, path, pntsd, pntsd_size);
+		ksmbd_vfs_set_sd_xattr(conn, idmap, path, pntsd, pntsd_size, false);
 		kfree(pntsd);
 	}
 
@@ -1377,7 +1377,7 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 
 int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
 		 const struct path *path, struct smb_ntsd *pntsd, int ntsd_len,
-		 bool type_check)
+		 bool type_check, bool get_write)
 {
 	int rc;
 	struct smb_fattr fattr = {{0}};
@@ -1437,7 +1437,8 @@ int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
 	if (test_share_config_flag(tcon->share_conf, KSMBD_SHARE_FLAG_ACL_XATTR)) {
 		/* Update WinACL in xattr */
 		ksmbd_vfs_remove_sd_xattrs(idmap, path);
-		ksmbd_vfs_set_sd_xattr(conn, idmap, path, pntsd, ntsd_len);
+		ksmbd_vfs_set_sd_xattr(conn, idmap, path, pntsd, ntsd_len,
+				get_write);
 	}
 
 out:
diff --git a/fs/smb/server/smbacl.h b/fs/smb/server/smbacl.h
index 49a8c292bd2e..2b52861707d8 100644
--- a/fs/smb/server/smbacl.h
+++ b/fs/smb/server/smbacl.h
@@ -207,7 +207,7 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 			__le32 *pdaccess, int uid);
 int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
 		 const struct path *path, struct smb_ntsd *pntsd, int ntsd_len,
-		 bool type_check);
+		 bool type_check, bool get_write);
 void id_to_sid(unsigned int cid, uint sidtype, struct smb_sid *ssid);
 void ksmbd_init_domain(u32 *sub_auth);
 
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 9919c07035d8..5a41c0b4e933 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -97,6 +97,13 @@ static int ksmbd_vfs_path_lookup_locked(struct ksmbd_share_config *share_conf,
 		return -ENOENT;
 	}
 
+	err = mnt_want_write(parent_path->mnt);
+	if (err) {
+		path_put(parent_path);
+		putname(filename);
+		return -ENOENT;
+	}
+
 	inode_lock_nested(parent_path->dentry->d_inode, I_MUTEX_PARENT);
 	d = lookup_one_qstr_excl(&last, parent_path->dentry, 0);
 	if (IS_ERR(d))
@@ -123,6 +130,7 @@ static int ksmbd_vfs_path_lookup_locked(struct ksmbd_share_config *share_conf,
 
 err_out:
 	inode_unlock(d_inode(parent_path->dentry));
+	mnt_drop_write(parent_path->mnt);
 	path_put(parent_path);
 	putname(filename);
 	return -ENOENT;
@@ -451,7 +459,8 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 				 fp->stream.name,
 				 (void *)stream_buf,
 				 size,
-				 0);
+				 0,
+				 true);
 	if (err < 0)
 		goto out;
 
@@ -593,10 +602,6 @@ int ksmbd_vfs_remove_file(struct ksmbd_work *work, const struct path *path)
 		goto out_err;
 	}
 
-	err = mnt_want_write(path->mnt);
-	if (err)
-		goto out_err;
-
 	idmap = mnt_idmap(path->mnt);
 	if (S_ISDIR(d_inode(path->dentry)->i_mode)) {
 		err = vfs_rmdir(idmap, d_inode(parent), path->dentry);
@@ -607,7 +612,6 @@ int ksmbd_vfs_remove_file(struct ksmbd_work *work, const struct path *path)
 		if (err)
 			ksmbd_debug(VFS, "unlink failed, err %d\n", err);
 	}
-	mnt_drop_write(path->mnt);
 
 out_err:
 	ksmbd_revert_fsids(work);
@@ -907,18 +911,22 @@ ssize_t ksmbd_vfs_getxattr(struct mnt_idmap *idmap,
  * @attr_value:	xattr value to set
  * @attr_size:	size of xattr value
  * @flags:	destination buffer length
+ * @get_write:	get write access to a mount
  *
  * Return:	0 on success, otherwise error
  */
 int ksmbd_vfs_setxattr(struct mnt_idmap *idmap,
 		       const struct path *path, const char *attr_name,
-		       void *attr_value, size_t attr_size, int flags)
+		       void *attr_value, size_t attr_size, int flags,
+		       bool get_write)
 {
 	int err;
 
-	err = mnt_want_write(path->mnt);
-	if (err)
-		return err;
+	if (get_write == true) {
+		err = mnt_want_write(path->mnt);
+		if (err)
+			return err;
+	}
 
 	err = vfs_setxattr(idmap,
 			   path->dentry,
@@ -928,7 +936,8 @@ int ksmbd_vfs_setxattr(struct mnt_idmap *idmap,
 			   flags);
 	if (err)
 		ksmbd_debug(VFS, "setxattr failed, err %d\n", err);
-	mnt_drop_write(path->mnt);
+	if (get_write == true)
+		mnt_drop_write(path->mnt);
 	return err;
 }
 
@@ -1251,6 +1260,13 @@ int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
 	}
 
 	if (!err) {
+		err = mnt_want_write(parent_path->mnt);
+		if (err) {
+			path_put(path);
+			path_put(parent_path);
+			return err;
+		}
+
 		err = ksmbd_vfs_lock_parent(parent_path->dentry, path->dentry);
 		if (err) {
 			path_put(path);
@@ -1260,6 +1276,14 @@ int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
 	return err;
 }
 
+void ksmbd_vfs_kern_path_unlock(struct path *parent_path, struct path *path)
+{
+	inode_unlock(d_inode(parent_path->dentry));
+	mnt_drop_write(parent_path->mnt);
+	path_put(path);
+	path_put(parent_path);
+}
+
 struct dentry *ksmbd_vfs_kern_path_create(struct ksmbd_work *work,
 					  const char *name,
 					  unsigned int flags,
@@ -1414,7 +1438,8 @@ static struct xattr_smb_acl *ksmbd_vfs_make_xattr_posix_acl(struct mnt_idmap *id
 int ksmbd_vfs_set_sd_xattr(struct ksmbd_conn *conn,
 			   struct mnt_idmap *idmap,
 			   const struct path *path,
-			   struct smb_ntsd *pntsd, int len)
+			   struct smb_ntsd *pntsd, int len,
+			   bool get_write)
 {
 	int rc;
 	struct ndr sd_ndr = {0}, acl_ndr = {0};
@@ -1474,7 +1499,7 @@ int ksmbd_vfs_set_sd_xattr(struct ksmbd_conn *conn,
 
 	rc = ksmbd_vfs_setxattr(idmap, path,
 				XATTR_NAME_SD, sd_ndr.data,
-				sd_ndr.offset, 0);
+				sd_ndr.offset, 0, get_write);
 	if (rc < 0)
 		pr_err("Failed to store XATTR ntacl :%d\n", rc);
 
@@ -1563,7 +1588,8 @@ int ksmbd_vfs_get_sd_xattr(struct ksmbd_conn *conn,
 
 int ksmbd_vfs_set_dos_attrib_xattr(struct mnt_idmap *idmap,
 				   const struct path *path,
-				   struct xattr_dos_attrib *da)
+				   struct xattr_dos_attrib *da,
+				   bool get_write)
 {
 	struct ndr n;
 	int err;
@@ -1573,7 +1599,7 @@ int ksmbd_vfs_set_dos_attrib_xattr(struct mnt_idmap *idmap,
 		return err;
 
 	err = ksmbd_vfs_setxattr(idmap, path, XATTR_NAME_DOS_ATTRIBUTE,
-				 (void *)n.data, n.offset, 0);
+				 (void *)n.data, n.offset, 0, get_write);
 	if (err)
 		ksmbd_debug(SMB, "failed to store dos attribute in xattr\n");
 	kfree(n.data);
@@ -1845,10 +1871,6 @@ int ksmbd_vfs_set_init_posix_acl(struct mnt_idmap *idmap,
 	}
 	posix_state_to_acl(&acl_state, acls->a_entries);
 
-	rc = mnt_want_write(path->mnt);
-	if (rc)
-		goto out_err;
-
 	rc = set_posix_acl(idmap, dentry, ACL_TYPE_ACCESS, acls);
 	if (rc < 0)
 		ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_ACCESS) failed, rc : %d\n",
@@ -1860,9 +1882,7 @@ int ksmbd_vfs_set_init_posix_acl(struct mnt_idmap *idmap,
 			ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_DEFAULT) failed, rc : %d\n",
 				    rc);
 	}
-	mnt_drop_write(path->mnt);
 
-out_err:
 	free_acl_state(&acl_state);
 	posix_acl_release(acls);
 	return rc;
@@ -1892,10 +1912,6 @@ int ksmbd_vfs_inherit_posix_acl(struct mnt_idmap *idmap,
 		}
 	}
 
-	rc = mnt_want_write(path->mnt);
-	if (rc)
-		goto out_err;
-
 	rc = set_posix_acl(idmap, dentry, ACL_TYPE_ACCESS, acls);
 	if (rc < 0)
 		ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_ACCESS) failed, rc : %d\n",
@@ -1907,9 +1923,7 @@ int ksmbd_vfs_inherit_posix_acl(struct mnt_idmap *idmap,
 			ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_DEFAULT) failed, rc : %d\n",
 				    rc);
 	}
-	mnt_drop_write(path->mnt);
 
-out_err:
 	posix_acl_release(acls);
 	return rc;
 }
diff --git a/fs/smb/server/vfs.h b/fs/smb/server/vfs.h
index 00968081856e..cfe1c8092f23 100644
--- a/fs/smb/server/vfs.h
+++ b/fs/smb/server/vfs.h
@@ -109,7 +109,8 @@ ssize_t ksmbd_vfs_casexattr_len(struct mnt_idmap *idmap,
 				int attr_name_len);
 int ksmbd_vfs_setxattr(struct mnt_idmap *idmap,
 		       const struct path *path, const char *attr_name,
-		       void *attr_value, size_t attr_size, int flags);
+		       void *attr_value, size_t attr_size, int flags,
+		       bool get_write);
 int ksmbd_vfs_xattr_stream_name(char *stream_name, char **xattr_stream_name,
 				size_t *xattr_stream_name_size, int s_type);
 int ksmbd_vfs_remove_xattr(struct mnt_idmap *idmap,
@@ -117,6 +118,7 @@ int ksmbd_vfs_remove_xattr(struct mnt_idmap *idmap,
 int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
 			       unsigned int flags, struct path *parent_path,
 			       struct path *path, bool caseless);
+void ksmbd_vfs_kern_path_unlock(struct path *parent_path, struct path *path);
 struct dentry *ksmbd_vfs_kern_path_create(struct ksmbd_work *work,
 					  const char *name,
 					  unsigned int flags,
@@ -144,14 +146,16 @@ int ksmbd_vfs_remove_sd_xattrs(struct mnt_idmap *idmap, const struct path *path)
 int ksmbd_vfs_set_sd_xattr(struct ksmbd_conn *conn,
 			   struct mnt_idmap *idmap,
 			   const struct path *path,
-			   struct smb_ntsd *pntsd, int len);
+			   struct smb_ntsd *pntsd, int len,
+			   bool get_write);
 int ksmbd_vfs_get_sd_xattr(struct ksmbd_conn *conn,
 			   struct mnt_idmap *idmap,
 			   struct dentry *dentry,
 			   struct smb_ntsd **pntsd);
 int ksmbd_vfs_set_dos_attrib_xattr(struct mnt_idmap *idmap,
 				   const struct path *path,
-				   struct xattr_dos_attrib *da);
+				   struct xattr_dos_attrib *da,
+				   bool get_write);
 int ksmbd_vfs_get_dos_attrib_xattr(struct mnt_idmap *idmap,
 				   struct dentry *dentry,
 				   struct xattr_dos_attrib *da);
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index 446394f84606..6ad02ad9c7b4 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -70,6 +70,10 @@ struct amd_cpudata {
 	u32	nominal_perf;
 	u32	lowest_nonlinear_perf;
 	u32	lowest_perf;
+	u32     min_limit_perf;
+	u32     max_limit_perf;
+	u32     min_limit_freq;
+	u32     max_limit_freq;
 
 	u32	max_freq;
 	u32	min_freq;
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index ebe78bd3d121..b3772edca2e6 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -498,6 +498,21 @@ static inline bool dma_fence_is_later(struct dma_fence *f1,
 	return __dma_fence_is_later(f1->seqno, f2->seqno, f1->ops);
 }
 
+/**
+ * dma_fence_is_later_or_same - return true if f1 is later or same as f2
+ * @f1: the first fence from the same context
+ * @f2: the second fence from the same context
+ *
+ * Returns true if f1 is chronologically later than f2 or the same fence. Both
+ * fences must be from the same context, since a seqno is not re-used across
+ * contexts.
+ */
+static inline bool dma_fence_is_later_or_same(struct dma_fence *f1,
+					      struct dma_fence *f2)
+{
+	return f1 == f2 || dma_fence_is_later(f1, f2);
+}
+
 /**
  * dma_fence_later - return the chronologically later fence
  * @f1:	the first fence from the same context
diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index 13d19b9be9f4..5fd664fb71c8 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -327,6 +327,9 @@ struct io_ring_ctx {
 
 	struct list_head	io_buffers_cache;
 
+	/* deferred free list, protected by ->uring_lock */
+	struct hlist_head	io_buf_list;
+
 	/* Keep this last, we don't need it for the fast path */
 	struct wait_queue_head		poll_wq;
 	struct io_restriction		restrictions;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c50a769d569a..0225cf7445de 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -703,6 +703,7 @@ static inline void dev_iommu_priv_set(struct device *dev, void *priv)
 	dev->iommu->priv = priv;
 }
 
+extern struct mutex iommu_probe_device_lock;
 int iommu_probe_device(struct device *dev);
 
 int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features f);
diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index c1637515a8a4..c953b8c0d2f4 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -106,6 +106,7 @@ struct sk_psock {
 	struct mutex			work_mutex;
 	struct sk_psock_work_state	work_state;
 	struct delayed_work		work;
+	struct sock			*sk_pair;
 	struct rcu_work			rwork;
 };
 
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 454e9295970c..a65b2513f8cd 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -289,16 +289,12 @@ void vfio_combine_iova_ranges(struct rb_root_cached *root, u32 cur_nodes,
 /*
  * External user API
  */
-#if IS_ENABLED(CONFIG_VFIO_GROUP)
 struct iommu_group *vfio_file_iommu_group(struct file *file);
+
+#if IS_ENABLED(CONFIG_VFIO_GROUP)
 bool vfio_file_is_group(struct file *file);
 bool vfio_file_has_dev(struct file *file, struct vfio_device *device);
 #else
-static inline struct iommu_group *vfio_file_iommu_group(struct file *file)
-{
-	return NULL;
-}
-
 static inline bool vfio_file_is_group(struct file *file)
 {
 	return false;
diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 824c258143a3..49c4640027d8 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -75,6 +75,7 @@ struct unix_sock {
 };
 
 #define unix_sk(ptr) container_of_const(ptr, struct unix_sock, sk)
+#define unix_peer(sk) (unix_sk(sk)->peer)
 
 #define peer_wait peer_wq.wait
 
diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 07022bb0d44d..0d28172193fa 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -162,7 +162,7 @@ struct neighbour {
 	struct rcu_head		rcu;
 	struct net_device	*dev;
 	netdevice_tracker	dev_tracker;
-	u8			primary_key[0];
+	u8			primary_key[];
 } __randomize_layout;
 
 struct neigh_ops {
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 65e49fae8da7..8fa1153f37cb 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -167,19 +167,25 @@ struct scsi_device {
 	 * power state for system suspend/resume (suspend to RAM and
 	 * hibernation) operations.
 	 */
-	bool manage_system_start_stop;
+	unsigned manage_system_start_stop:1;
 
 	/*
 	 * If true, let the high-level device driver (sd) manage the device
 	 * power state for runtime device suspand and resume operations.
 	 */
-	bool manage_runtime_start_stop;
+	unsigned manage_runtime_start_stop:1;
 
 	/*
 	 * If true, let the high-level device driver (sd) manage the device
 	 * power state for system shutdown (power off) operations.
 	 */
-	bool manage_shutdown;
+	unsigned manage_shutdown:1;
+
+	/*
+	 * If set and if the device is runtime suspended, ask the high-level
+	 * device driver (sd) to force a runtime resume of the device.
+	 */
+	unsigned force_runtime_start_on_system_start:1;
 
 	unsigned removable:1;
 	unsigned changed:1;	/* Data invalid due to media change */
diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
index 5c6c4269f7ef..2ec6f35cda32 100644
--- a/include/uapi/linux/stddef.h
+++ b/include/uapi/linux/stddef.h
@@ -27,7 +27,7 @@
 	union { \
 		struct { MEMBERS } ATTRS; \
 		struct TAG { MEMBERS } ATTRS NAME; \
-	}
+	} ATTRS
 
 #ifdef __cplusplus
 /* sizeof(struct{}) is 1 in C++, not 0, can't use C version of the macro. */
diff --git a/include/uapi/linux/v4l2-subdev.h b/include/uapi/linux/v4l2-subdev.h
index 4a195b68f28f..b383c2fe0cf3 100644
--- a/include/uapi/linux/v4l2-subdev.h
+++ b/include/uapi/linux/v4l2-subdev.h
@@ -239,7 +239,7 @@ struct v4l2_subdev_routing {
  * set (which is the default), the 'stream' fields will be forced to 0 by the
  * kernel.
  */
- #define V4L2_SUBDEV_CLIENT_CAP_STREAMS		(1U << 0)
+ #define V4L2_SUBDEV_CLIENT_CAP_STREAMS		(1ULL << 0)
 
 /**
  * struct v4l2_subdev_client_capability - Capabilities of the client accessing
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 8d1bc6cdfe71..f09e3ee11229 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -323,6 +323,7 @@ static __cold struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	INIT_LIST_HEAD(&ctx->sqd_list);
 	INIT_LIST_HEAD(&ctx->cq_overflow_list);
 	INIT_LIST_HEAD(&ctx->io_buffers_cache);
+	INIT_HLIST_HEAD(&ctx->io_buf_list);
 	io_alloc_cache_init(&ctx->rsrc_node_cache, IO_NODE_ALLOC_CACHE_MAX,
 			    sizeof(struct io_rsrc_node));
 	io_alloc_cache_init(&ctx->apoll_cache, IO_ALLOC_CACHE_MAX,
@@ -2659,7 +2660,7 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 	return READ_ONCE(rings->cq.head) == READ_ONCE(rings->cq.tail) ? ret : 0;
 }
 
-static void io_mem_free(void *ptr)
+void io_mem_free(void *ptr)
 {
 	if (!ptr)
 		return;
@@ -2690,6 +2691,7 @@ static void *__io_uaddr_map(struct page ***pages, unsigned short *npages,
 {
 	struct page **page_array;
 	unsigned int nr_pages;
+	void *page_addr;
 	int ret, i;
 
 	*npages = 0;
@@ -2711,27 +2713,29 @@ static void *__io_uaddr_map(struct page ***pages, unsigned short *npages,
 		io_pages_free(&page_array, ret > 0 ? ret : 0);
 		return ret < 0 ? ERR_PTR(ret) : ERR_PTR(-EFAULT);
 	}
-	/*
-	 * Should be a single page. If the ring is small enough that we can
-	 * use a normal page, that is fine. If we need multiple pages, then
-	 * userspace should use a huge page. That's the only way to guarantee
-	 * that we get contigious memory, outside of just being lucky or
-	 * (currently) having low memory fragmentation.
-	 */
-	if (page_array[0] != page_array[ret - 1])
-		goto err;
 
-	/*
-	 * Can't support mapping user allocated ring memory on 32-bit archs
-	 * where it could potentially reside in highmem. Just fail those with
-	 * -EINVAL, just like we did on kernels that didn't support this
-	 * feature.
-	 */
+	page_addr = page_address(page_array[0]);
 	for (i = 0; i < nr_pages; i++) {
-		if (PageHighMem(page_array[i])) {
-			ret = -EINVAL;
+		ret = -EINVAL;
+
+		/*
+		 * Can't support mapping user allocated ring memory on 32-bit
+		 * archs where it could potentially reside in highmem. Just
+		 * fail those with -EINVAL, just like we did on kernels that
+		 * didn't support this feature.
+		 */
+		if (PageHighMem(page_array[i]))
 			goto err;
-		}
+
+		/*
+		 * No support for discontig pages for now, should either be a
+		 * single normal page, or a huge page. Later on we can add
+		 * support for remapping discontig pages, for now we will
+		 * just fail them with EINVAL.
+		 */
+		if (page_address(page_array[i]) != page_addr)
+			goto err;
+		page_addr += PAGE_SIZE;
 	}
 
 	*pages = page_array;
@@ -2768,7 +2772,7 @@ static void io_rings_free(struct io_ring_ctx *ctx)
 	}
 }
 
-static void *io_mem_alloc(size_t size)
+void *io_mem_alloc(size_t size)
 {
 	gfp_t gfp = GFP_KERNEL_ACCOUNT | __GFP_ZERO | __GFP_NOWARN | __GFP_COMP;
 	void *ret;
@@ -2939,6 +2943,7 @@ static __cold void io_ring_ctx_free(struct io_ring_ctx *ctx)
 		ctx->mm_account = NULL;
 	}
 	io_rings_free(ctx);
+	io_kbuf_mmap_list_free(ctx);
 
 	percpu_ref_exit(&ctx->refs);
 	free_uid(ctx->user);
@@ -3433,25 +3438,27 @@ static void *io_uring_validate_mmap_request(struct file *file,
 	struct page *page;
 	void *ptr;
 
-	/* Don't allow mmap if the ring was setup without it */
-	if (ctx->flags & IORING_SETUP_NO_MMAP)
-		return ERR_PTR(-EINVAL);
-
 	switch (offset & IORING_OFF_MMAP_MASK) {
 	case IORING_OFF_SQ_RING:
 	case IORING_OFF_CQ_RING:
+		/* Don't allow mmap if the ring was setup without it */
+		if (ctx->flags & IORING_SETUP_NO_MMAP)
+			return ERR_PTR(-EINVAL);
 		ptr = ctx->rings;
 		break;
 	case IORING_OFF_SQES:
+		/* Don't allow mmap if the ring was setup without it */
+		if (ctx->flags & IORING_SETUP_NO_MMAP)
+			return ERR_PTR(-EINVAL);
 		ptr = ctx->sq_sqes;
 		break;
 	case IORING_OFF_PBUF_RING: {
 		unsigned int bgid;
 
 		bgid = (offset & ~IORING_OFF_MMAP_MASK) >> IORING_OFF_PBUF_SHIFT;
-		mutex_lock(&ctx->uring_lock);
+		rcu_read_lock();
 		ptr = io_pbuf_get_address(ctx, bgid);
-		mutex_unlock(&ctx->uring_lock);
+		rcu_read_unlock();
 		if (!ptr)
 			return ERR_PTR(-EINVAL);
 		break;
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index 0bc145614a6e..d2bad1df347d 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -86,6 +86,9 @@ bool __io_alloc_req_refill(struct io_ring_ctx *ctx);
 bool io_match_task_safe(struct io_kiocb *head, struct task_struct *task,
 			bool cancel_all);
 
+void *io_mem_alloc(size_t size);
+void io_mem_free(void *ptr);
+
 #if defined(CONFIG_PROVE_LOCKING)
 static inline void io_lockdep_assert_cq_locked(struct io_ring_ctx *ctx)
 {
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index f6e5ae026e4b..012f62203604 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -31,19 +31,42 @@ struct io_provide_buf {
 	__u16				bid;
 };
 
+static struct io_buffer_list *__io_buffer_get_list(struct io_ring_ctx *ctx,
+						   struct io_buffer_list *bl,
+						   unsigned int bgid)
+{
+	if (bl && bgid < BGID_ARRAY)
+		return &bl[bgid];
+
+	return xa_load(&ctx->io_bl_xa, bgid);
+}
+
+struct io_buf_free {
+	struct hlist_node		list;
+	void				*mem;
+	size_t				size;
+	int				inuse;
+};
+
 static inline struct io_buffer_list *io_buffer_get_list(struct io_ring_ctx *ctx,
 							unsigned int bgid)
 {
-	if (ctx->io_bl && bgid < BGID_ARRAY)
-		return &ctx->io_bl[bgid];
+	lockdep_assert_held(&ctx->uring_lock);
 
-	return xa_load(&ctx->io_bl_xa, bgid);
+	return __io_buffer_get_list(ctx, ctx->io_bl, bgid);
 }
 
 static int io_buffer_add_list(struct io_ring_ctx *ctx,
 			      struct io_buffer_list *bl, unsigned int bgid)
 {
+	/*
+	 * Store buffer group ID and finally mark the list as visible.
+	 * The normal lookup doesn't care about the visibility as we're
+	 * always under the ->uring_lock, but the RCU lookup from mmap does.
+	 */
 	bl->bgid = bgid;
+	smp_store_release(&bl->is_ready, 1);
+
 	if (bgid < BGID_ARRAY)
 		return 0;
 
@@ -194,21 +217,40 @@ void __user *io_buffer_select(struct io_kiocb *req, size_t *len,
 
 static __cold int io_init_bl_list(struct io_ring_ctx *ctx)
 {
+	struct io_buffer_list *bl;
 	int i;
 
-	ctx->io_bl = kcalloc(BGID_ARRAY, sizeof(struct io_buffer_list),
-				GFP_KERNEL);
-	if (!ctx->io_bl)
+	bl = kcalloc(BGID_ARRAY, sizeof(struct io_buffer_list), GFP_KERNEL);
+	if (!bl)
 		return -ENOMEM;
 
 	for (i = 0; i < BGID_ARRAY; i++) {
-		INIT_LIST_HEAD(&ctx->io_bl[i].buf_list);
-		ctx->io_bl[i].bgid = i;
+		INIT_LIST_HEAD(&bl[i].buf_list);
+		bl[i].bgid = i;
 	}
 
+	smp_store_release(&ctx->io_bl, bl);
 	return 0;
 }
 
+/*
+ * Mark the given mapped range as free for reuse
+ */
+static void io_kbuf_mark_free(struct io_ring_ctx *ctx, struct io_buffer_list *bl)
+{
+	struct io_buf_free *ibf;
+
+	hlist_for_each_entry(ibf, &ctx->io_buf_list, list) {
+		if (bl->buf_ring == ibf->mem) {
+			ibf->inuse = 0;
+			return;
+		}
+	}
+
+	/* can't happen... */
+	WARN_ON_ONCE(1);
+}
+
 static int __io_remove_buffers(struct io_ring_ctx *ctx,
 			       struct io_buffer_list *bl, unsigned nbufs)
 {
@@ -221,7 +263,11 @@ static int __io_remove_buffers(struct io_ring_ctx *ctx,
 	if (bl->is_mapped) {
 		i = bl->buf_ring->tail - bl->head;
 		if (bl->is_mmap) {
-			folio_put(virt_to_folio(bl->buf_ring));
+			/*
+			 * io_kbuf_list_free() will free the page(s) at
+			 * ->release() time.
+			 */
+			io_kbuf_mark_free(ctx, bl);
 			bl->buf_ring = NULL;
 			bl->is_mmap = 0;
 		} else if (bl->buf_nr_pages) {
@@ -270,7 +316,7 @@ void io_destroy_buffers(struct io_ring_ctx *ctx)
 	xa_for_each(&ctx->io_bl_xa, index, bl) {
 		xa_erase(&ctx->io_bl_xa, bl->bgid);
 		__io_remove_buffers(ctx, bl, -1U);
-		kfree(bl);
+		kfree_rcu(bl, rcu);
 	}
 
 	while (!list_empty(&ctx->io_buffers_pages)) {
@@ -455,7 +501,16 @@ int io_provide_buffers(struct io_kiocb *req, unsigned int issue_flags)
 		INIT_LIST_HEAD(&bl->buf_list);
 		ret = io_buffer_add_list(ctx, bl, p->bgid);
 		if (ret) {
-			kfree(bl);
+			/*
+			 * Doesn't need rcu free as it was never visible, but
+			 * let's keep it consistent throughout. Also can't
+			 * be a lower indexed array group, as adding one
+			 * where lookup failed cannot happen.
+			 */
+			if (p->bgid >= BGID_ARRAY)
+				kfree_rcu(bl, rcu);
+			else
+				WARN_ON_ONCE(1);
 			goto err;
 		}
 	}
@@ -526,19 +581,63 @@ static int io_pin_pbuf_ring(struct io_uring_buf_reg *reg,
 	return -EINVAL;
 }
 
-static int io_alloc_pbuf_ring(struct io_uring_buf_reg *reg,
+/*
+ * See if we have a suitable region that we can reuse, rather than allocate
+ * both a new io_buf_free and mem region again. We leave it on the list as
+ * even a reused entry will need freeing at ring release.
+ */
+static struct io_buf_free *io_lookup_buf_free_entry(struct io_ring_ctx *ctx,
+						    size_t ring_size)
+{
+	struct io_buf_free *ibf, *best = NULL;
+	size_t best_dist;
+
+	hlist_for_each_entry(ibf, &ctx->io_buf_list, list) {
+		size_t dist;
+
+		if (ibf->inuse || ibf->size < ring_size)
+			continue;
+		dist = ibf->size - ring_size;
+		if (!best || dist < best_dist) {
+			best = ibf;
+			if (!dist)
+				break;
+			best_dist = dist;
+		}
+	}
+
+	return best;
+}
+
+static int io_alloc_pbuf_ring(struct io_ring_ctx *ctx,
+			      struct io_uring_buf_reg *reg,
 			      struct io_buffer_list *bl)
 {
-	gfp_t gfp = GFP_KERNEL_ACCOUNT | __GFP_ZERO | __GFP_NOWARN | __GFP_COMP;
+	struct io_buf_free *ibf;
 	size_t ring_size;
 	void *ptr;
 
 	ring_size = reg->ring_entries * sizeof(struct io_uring_buf_ring);
-	ptr = (void *) __get_free_pages(gfp, get_order(ring_size));
-	if (!ptr)
-		return -ENOMEM;
 
-	bl->buf_ring = ptr;
+	/* Reuse existing entry, if we can */
+	ibf = io_lookup_buf_free_entry(ctx, ring_size);
+	if (!ibf) {
+		ptr = io_mem_alloc(ring_size);
+		if (!ptr)
+			return -ENOMEM;
+
+		/* Allocate and store deferred free entry */
+		ibf = kmalloc(sizeof(*ibf), GFP_KERNEL_ACCOUNT);
+		if (!ibf) {
+			io_mem_free(ptr);
+			return -ENOMEM;
+		}
+		ibf->mem = ptr;
+		ibf->size = ring_size;
+		hlist_add_head(&ibf->list, &ctx->io_buf_list);
+	}
+	ibf->inuse = 1;
+	bl->buf_ring = ibf->mem;
 	bl->is_mapped = 1;
 	bl->is_mmap = 1;
 	return 0;
@@ -550,6 +649,8 @@ int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
 	struct io_buffer_list *bl, *free_bl = NULL;
 	int ret;
 
+	lockdep_assert_held(&ctx->uring_lock);
+
 	if (copy_from_user(&reg, arg, sizeof(reg)))
 		return -EFAULT;
 
@@ -594,7 +695,7 @@ int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
 	if (!(reg.flags & IOU_PBUF_RING_MMAP))
 		ret = io_pin_pbuf_ring(&reg, bl);
 	else
-		ret = io_alloc_pbuf_ring(&reg, bl);
+		ret = io_alloc_pbuf_ring(ctx, &reg, bl);
 
 	if (!ret) {
 		bl->nr_entries = reg.ring_entries;
@@ -604,7 +705,7 @@ int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
 		return 0;
 	}
 
-	kfree(free_bl);
+	kfree_rcu(free_bl, rcu);
 	return ret;
 }
 
@@ -613,6 +714,8 @@ int io_unregister_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
 	struct io_uring_buf_reg reg;
 	struct io_buffer_list *bl;
 
+	lockdep_assert_held(&ctx->uring_lock);
+
 	if (copy_from_user(&reg, arg, sizeof(reg)))
 		return -EFAULT;
 	if (reg.resv[0] || reg.resv[1] || reg.resv[2])
@@ -629,7 +732,7 @@ int io_unregister_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
 	__io_remove_buffers(ctx, bl, -1U);
 	if (bl->bgid >= BGID_ARRAY) {
 		xa_erase(&ctx->io_bl_xa, bl->bgid);
-		kfree(bl);
+		kfree_rcu(bl, rcu);
 	}
 	return 0;
 }
@@ -638,9 +741,33 @@ void *io_pbuf_get_address(struct io_ring_ctx *ctx, unsigned long bgid)
 {
 	struct io_buffer_list *bl;
 
-	bl = io_buffer_get_list(ctx, bgid);
+	bl = __io_buffer_get_list(ctx, smp_load_acquire(&ctx->io_bl), bgid);
+
+	/*
+	 * Ensure the list is fully setup. Only strictly needed for RCU lookup
+	 * via mmap, and in that case only for the array indexed groups. For
+	 * the xarray lookups, it's either visible and ready, or not at all.
+	 */
+	if (!smp_load_acquire(&bl->is_ready))
+		return NULL;
 	if (!bl || !bl->is_mmap)
 		return NULL;
 
 	return bl->buf_ring;
 }
+
+/*
+ * Called at or after ->release(), free the mmap'ed buffers that we used
+ * for memory mapped provided buffer rings.
+ */
+void io_kbuf_mmap_list_free(struct io_ring_ctx *ctx)
+{
+	struct io_buf_free *ibf;
+	struct hlist_node *tmp;
+
+	hlist_for_each_entry_safe(ibf, tmp, &ctx->io_buf_list, list) {
+		hlist_del(&ibf->list);
+		io_mem_free(ibf->mem);
+		kfree(ibf);
+	}
+}
diff --git a/io_uring/kbuf.h b/io_uring/kbuf.h
index d14345ef61fc..3d0cb6b8c1ed 100644
--- a/io_uring/kbuf.h
+++ b/io_uring/kbuf.h
@@ -15,6 +15,7 @@ struct io_buffer_list {
 			struct page **buf_pages;
 			struct io_uring_buf_ring *buf_ring;
 		};
+		struct rcu_head rcu;
 	};
 	__u16 bgid;
 
@@ -28,6 +29,8 @@ struct io_buffer_list {
 	__u8 is_mapped;
 	/* ring mapped provided buffers, but mmap'ed by application */
 	__u8 is_mmap;
+	/* bl is visible from an RCU point of view for lookup */
+	__u8 is_ready;
 };
 
 struct io_buffer {
@@ -51,6 +54,8 @@ int io_provide_buffers(struct io_kiocb *req, unsigned int issue_flags);
 int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg);
 int io_unregister_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg);
 
+void io_kbuf_mmap_list_free(struct io_ring_ctx *ctx);
+
 unsigned int __io_put_kbuf(struct io_kiocb *req, unsigned issue_flags);
 
 void io_kbuf_recycle_legacy(struct io_kiocb *req, unsigned issue_flags);
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index d93ddac283d4..956f80ee6f5c 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -958,6 +958,8 @@ void notrace *bpf_mem_cache_alloc_flags(struct bpf_mem_alloc *ma, gfp_t flags)
 		memcg = get_memcg(c);
 		old_memcg = set_active_memcg(memcg);
 		ret = __alloc(c, NUMA_NO_NODE, GFP_KERNEL | __GFP_NOWARN | __GFP_ACCOUNT);
+		if (ret)
+			*(struct bpf_mem_cache **)ret = c;
 		set_active_memcg(old_memcg);
 		mem_cgroup_put(memcg);
 	}
diff --git a/lib/errname.c b/lib/errname.c
index 67739b174a8c..0c336b0f12f6 100644
--- a/lib/errname.c
+++ b/lib/errname.c
@@ -111,9 +111,6 @@ static const char *names_0[] = {
 	E(ENOSPC),
 	E(ENOSR),
 	E(ENOSTR),
-#ifdef ENOSYM
-	E(ENOSYM),
-#endif
 	E(ENOSYS),
 	E(ENOTBLK),
 	E(ENOTCONN),
@@ -144,9 +141,6 @@ static const char *names_0[] = {
 #endif
 	E(EREMOTE),
 	E(EREMOTEIO),
-#ifdef EREMOTERELEASE
-	E(EREMOTERELEASE),
-#endif
 	E(ERESTART),
 	E(ERFKILL),
 	E(EROFS),
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 6c31eefbd777..93ecfceac1bc 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -826,6 +826,8 @@ static void sk_psock_destroy(struct work_struct *work)
 
 	if (psock->sk_redir)
 		sock_put(psock->sk_redir);
+	if (psock->sk_pair)
+		sock_put(psock->sk_pair);
 	sock_put(psock->sk);
 	kfree(psock);
 }
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 3bbd5afb7b31..fe3553f60bf3 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -505,6 +505,7 @@ static int ethnl_default_dumpit(struct sk_buff *skb,
 				ret = skb->len;
 			break;
 		}
+		ret = 0;
 	}
 	rtnl_unlock();
 
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 418e5fb58fd3..d515881d02a6 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -216,8 +216,10 @@ static void igmp_start_timer(struct ip_mc_list *im, int max_delay)
 	int tv = get_random_u32_below(max_delay);
 
 	im->tm_running = 1;
-	if (!mod_timer(&im->timer, jiffies+tv+2))
-		refcount_inc(&im->refcnt);
+	if (refcount_inc_not_zero(&im->refcnt)) {
+		if (mod_timer(&im->timer, jiffies + tv + 2))
+			ip_ma_put(im);
+	}
 }
 
 static void igmp_gq_start_timer(struct in_device *in_dev)
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index c4505593ba7a..2bc2fbe58f94 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -23,7 +23,7 @@
 static inline struct ieee80211_sub_if_data *
 get_bss_sdata(struct ieee80211_sub_if_data *sdata)
 {
-	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
+	if (sdata && sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 		sdata = container_of(sdata->bss, struct ieee80211_sub_if_data,
 				     u.ap);
 
@@ -638,10 +638,13 @@ static inline void drv_flush(struct ieee80211_local *local,
 			     struct ieee80211_sub_if_data *sdata,
 			     u32 queues, bool drop)
 {
-	struct ieee80211_vif *vif = sdata ? &sdata->vif : NULL;
+	struct ieee80211_vif *vif;
 
 	might_sleep();
 
+	sdata = get_bss_sdata(sdata);
+	vif = sdata ? &sdata->vif : NULL;
+
 	if (sdata && !check_sdata_in_driver(sdata))
 		return;
 
@@ -657,6 +660,8 @@ static inline void drv_flush_sta(struct ieee80211_local *local,
 {
 	might_sleep();
 
+	sdata = get_bss_sdata(sdata);
+
 	if (sdata && !check_sdata_in_driver(sdata))
 		return;
 
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 3e6eeacb13ae..1e1a88bd4e68 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -212,8 +212,6 @@ static inline bool unix_secdata_eq(struct scm_cookie *scm, struct sk_buff *skb)
 }
 #endif /* CONFIG_SECURITY_NETWORK */
 
-#define unix_peer(sk) (unix_sk(sk)->peer)
-
 static inline int unix_our_peer(struct sock *sk, struct sock *osk)
 {
 	return unix_peer(osk) == sk;
diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
index 2f9d8271c6ec..7ea7c3a0d0d0 100644
--- a/net/unix/unix_bpf.c
+++ b/net/unix/unix_bpf.c
@@ -159,12 +159,17 @@ int unix_dgram_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool re
 
 int unix_stream_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
 {
+	struct sock *sk_pair;
+
 	if (restore) {
 		sk->sk_write_space = psock->saved_write_space;
 		sock_replace_proto(sk, psock->sk_proto);
 		return 0;
 	}
 
+	sk_pair = unix_peer(sk);
+	sock_hold(sk_pair);
+	psock->sk_pair = sk_pair;
 	unix_stream_bpf_check_needs_rebuild(psock->sk_proto);
 	sock_replace_proto(sk, &unix_stream_bpf_prot);
 	return 0;
diff --git a/net/wireless/core.h b/net/wireless/core.h
index e536c0b615a0..f0a3a2317638 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -299,6 +299,7 @@ struct cfg80211_cqm_config {
 	u32 rssi_hyst;
 	s32 last_rssi_event_value;
 	enum nl80211_cqm_rssi_threshold_event last_rssi_event_type;
+	bool use_range_api;
 	int n_rssi_thresholds;
 	s32 rssi_thresholds[] __counted_by(n_rssi_thresholds);
 };
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 931a03f4549c..6a82dd876f27 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -12824,10 +12824,6 @@ static int cfg80211_cqm_rssi_update(struct cfg80211_registered_device *rdev,
 	int i, n, low_index;
 	int err;
 
-	/* RSSI reporting disabled? */
-	if (!cqm_config)
-		return rdev_set_cqm_rssi_range_config(rdev, dev, 0, 0);
-
 	/*
 	 * Obtain current RSSI value if possible, if not and no RSSI threshold
 	 * event has been received yet, we should receive an event after a
@@ -12902,18 +12898,6 @@ static int nl80211_set_cqm_rssi(struct genl_info *info,
 	    wdev->iftype != NL80211_IFTYPE_P2P_CLIENT)
 		return -EOPNOTSUPP;
 
-	if (n_thresholds <= 1 && rdev->ops->set_cqm_rssi_config) {
-		if (n_thresholds == 0 || thresholds[0] == 0) /* Disabling */
-			return rdev_set_cqm_rssi_config(rdev, dev, 0, 0);
-
-		return rdev_set_cqm_rssi_config(rdev, dev,
-						thresholds[0], hysteresis);
-	}
-
-	if (!wiphy_ext_feature_isset(&rdev->wiphy,
-				     NL80211_EXT_FEATURE_CQM_RSSI_LIST))
-		return -EOPNOTSUPP;
-
 	if (n_thresholds == 1 && thresholds[0] == 0) /* Disabling */
 		n_thresholds = 0;
 
@@ -12921,6 +12905,20 @@ static int nl80211_set_cqm_rssi(struct genl_info *info,
 	old = rcu_dereference_protected(wdev->cqm_config,
 					lockdep_is_held(&wdev->mtx));
 
+	/* if already disabled just succeed */
+	if (!n_thresholds && !old)
+		return 0;
+
+	if (n_thresholds > 1) {
+		if (!wiphy_ext_feature_isset(&rdev->wiphy,
+					     NL80211_EXT_FEATURE_CQM_RSSI_LIST) ||
+		    !rdev->ops->set_cqm_rssi_range_config)
+			return -EOPNOTSUPP;
+	} else {
+		if (!rdev->ops->set_cqm_rssi_config)
+			return -EOPNOTSUPP;
+	}
+
 	if (n_thresholds) {
 		cqm_config = kzalloc(struct_size(cqm_config, rssi_thresholds,
 						 n_thresholds),
@@ -12935,13 +12933,26 @@ static int nl80211_set_cqm_rssi(struct genl_info *info,
 		memcpy(cqm_config->rssi_thresholds, thresholds,
 		       flex_array_size(cqm_config, rssi_thresholds,
 				       n_thresholds));
+		cqm_config->use_range_api = n_thresholds > 1 ||
+					    !rdev->ops->set_cqm_rssi_config;
 
 		rcu_assign_pointer(wdev->cqm_config, cqm_config);
+
+		if (cqm_config->use_range_api)
+			err = cfg80211_cqm_rssi_update(rdev, dev, cqm_config);
+		else
+			err = rdev_set_cqm_rssi_config(rdev, dev,
+						       thresholds[0],
+						       hysteresis);
 	} else {
 		RCU_INIT_POINTER(wdev->cqm_config, NULL);
+		/* if enabled as range also disable via range */
+		if (old->use_range_api)
+			err = rdev_set_cqm_rssi_range_config(rdev, dev, 0, 0);
+		else
+			err = rdev_set_cqm_rssi_config(rdev, dev, 0, 0);
 	}
 
-	err = cfg80211_cqm_rssi_update(rdev, dev, cqm_config);
 	if (err) {
 		rcu_assign_pointer(wdev->cqm_config, old);
 		kfree_rcu(cqm_config, rcu_head);
@@ -19131,10 +19142,11 @@ void cfg80211_cqm_rssi_notify_work(struct wiphy *wiphy, struct wiphy_work *work)
 	wdev_lock(wdev);
 	cqm_config = rcu_dereference_protected(wdev->cqm_config,
 					       lockdep_is_held(&wdev->mtx));
-	if (!wdev->cqm_config)
+	if (!cqm_config)
 		goto unlock;
 
-	cfg80211_cqm_rssi_update(rdev, wdev->netdev, cqm_config);
+	if (cqm_config->use_range_api)
+		cfg80211_cqm_rssi_update(rdev, wdev->netdev, cqm_config);
 
 	rssi_level = cqm_config->last_rssi_event_value;
 	rssi_event = cqm_config->last_rssi_event_type;
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index ca765ac4765f..75148485b755 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2218,6 +2218,8 @@ static const struct snd_pci_quirk power_save_denylist[] = {
 	SND_PCI_QUIRK(0x17aa, 0x36a7, "Lenovo C50 All in one", 0),
 	/* https://bugs.launchpad.net/bugs/1821663 */
 	SND_PCI_QUIRK(0x1631, 0xe017, "Packard Bell NEC IMEDIA 5204", 0),
+	/* KONTRON SinglePC may cause a stall at runtime resume */
+	SND_PCI_QUIRK(0x1734, 0x1232, "KONTRON SinglePC", 0),
 	{}
 };
 #endif /* CONFIG_PM */
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 87bc1d2f8a43..758abe9dffd6 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1986,6 +1986,7 @@ enum {
 	ALC887_FIXUP_ASUS_AUDIO,
 	ALC887_FIXUP_ASUS_HMIC,
 	ALCS1200A_FIXUP_MIC_VREF,
+	ALC888VD_FIXUP_MIC_100VREF,
 };
 
 static void alc889_fixup_coef(struct hda_codec *codec,
@@ -2539,6 +2540,13 @@ static const struct hda_fixup alc882_fixups[] = {
 			{}
 		}
 	},
+	[ALC888VD_FIXUP_MIC_100VREF] = {
+		.type = HDA_FIXUP_PINCTLS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x18, PIN_VREF100 }, /* headset mic */
+			{}
+		}
+	},
 };
 
 static const struct snd_pci_quirk alc882_fixup_tbl[] = {
@@ -2608,6 +2616,7 @@ static const struct snd_pci_quirk alc882_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x106b, 0x4a00, "Macbook 5,2", ALC889_FIXUP_MBA11_VREF),
 
 	SND_PCI_QUIRK(0x1071, 0x8258, "Evesham Voyaeger", ALC882_FIXUP_EAPD),
+	SND_PCI_QUIRK(0x10ec, 0x12d8, "iBase Elo Touch", ALC888VD_FIXUP_MIC_100VREF),
 	SND_PCI_QUIRK(0x13fe, 0x1009, "Advantech MIT-W101", ALC886_FIXUP_EAPD),
 	SND_PCI_QUIRK(0x1458, 0xa002, "Gigabyte EP45-DS3/Z87X-UD3H", ALC889_FIXUP_FRONT_HP_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1458, 0xa0b8, "Gigabyte AZ370-Gaming", ALC1220_FIXUP_GB_DUAL_CODECS),
@@ -3255,6 +3264,7 @@ static void alc_disable_headset_jack_key(struct hda_codec *codec)
 	case 0x10ec0230:
 	case 0x10ec0236:
 	case 0x10ec0256:
+	case 0x10ec0257:
 	case 0x19e58326:
 		alc_write_coef_idx(codec, 0x48, 0x0);
 		alc_update_coef_idx(codec, 0x49, 0x0045, 0x0);
@@ -3284,6 +3294,7 @@ static void alc_enable_headset_jack_key(struct hda_codec *codec)
 	case 0x10ec0230:
 	case 0x10ec0236:
 	case 0x10ec0256:
+	case 0x10ec0257:
 	case 0x19e58326:
 		alc_write_coef_idx(codec, 0x48, 0xd011);
 		alc_update_coef_idx(codec, 0x49, 0x007f, 0x0045);
@@ -6495,6 +6506,7 @@ static void alc_combo_jack_hp_jd_restart(struct hda_codec *codec)
 	case 0x10ec0236:
 	case 0x10ec0255:
 	case 0x10ec0256:
+	case 0x10ec0257:
 	case 0x19e58326:
 		alc_update_coef_idx(codec, 0x1b, 0x8000, 1 << 15); /* Reset HP JD */
 		alc_update_coef_idx(codec, 0x1b, 0x8000, 0 << 15);
diff --git a/tools/arch/parisc/include/uapi/asm/errno.h b/tools/arch/parisc/include/uapi/asm/errno.h
index 87245c584784..8d94739d75c6 100644
--- a/tools/arch/parisc/include/uapi/asm/errno.h
+++ b/tools/arch/parisc/include/uapi/asm/errno.h
@@ -75,7 +75,6 @@
 
 /* We now return you to your regularly scheduled HPUX. */
 
-#define ENOSYM		215	/* symbol does not exist in executable */
 #define	ENOTSOCK	216	/* Socket operation on non-socket */
 #define	EDESTADDRREQ	217	/* Destination address required */
 #define	EMSGSIZE	218	/* Message too long */
@@ -101,7 +100,6 @@
 #define	ETIMEDOUT	238	/* Connection timed out */
 #define	ECONNREFUSED	239	/* Connection refused */
 #define	EREFUSED	ECONNREFUSED	/* for HP's NFS apparently */
-#define	EREMOTERELEASE	240	/* Remote peer released connection */
 #define	EHOSTDOWN	241	/* Host is down */
 #define	EHOSTUNREACH	242	/* No route to host */
 
diff --git a/tools/testing/selftests/net/af_unix/diag_uid.c b/tools/testing/selftests/net/af_unix/diag_uid.c
index 5b88f7129fea..79a3dd75590e 100644
--- a/tools/testing/selftests/net/af_unix/diag_uid.c
+++ b/tools/testing/selftests/net/af_unix/diag_uid.c
@@ -148,7 +148,6 @@ void receive_response(struct __test_metadata *_metadata,
 		.msg_iov = &iov,
 		.msg_iovlen = 1
 	};
-	struct unix_diag_req *udr;
 	struct nlmsghdr *nlh;
 	int ret;
 
diff --git a/tools/testing/selftests/net/cmsg_sender.c b/tools/testing/selftests/net/cmsg_sender.c
index 24b21b15ed3f..6ff3e732f449 100644
--- a/tools/testing/selftests/net/cmsg_sender.c
+++ b/tools/testing/selftests/net/cmsg_sender.c
@@ -416,9 +416,9 @@ int main(int argc, char *argv[])
 {
 	struct addrinfo hints, *ai;
 	struct iovec iov[1];
+	unsigned char *buf;
 	struct msghdr msg;
 	char cbuf[1024];
-	char *buf;
 	int err;
 	int fd;
 
diff --git a/tools/testing/selftests/net/ipsec.c b/tools/testing/selftests/net/ipsec.c
index 9a8229abfa02..be4a30a0d02a 100644
--- a/tools/testing/selftests/net/ipsec.c
+++ b/tools/testing/selftests/net/ipsec.c
@@ -2263,7 +2263,7 @@ static int check_results(void)
 
 int main(int argc, char **argv)
 {
-	unsigned int nr_process = 1;
+	long nr_process = 1;
 	int route_sock = -1, ret = KSFT_SKIP;
 	int test_desc_fd[2];
 	uint32_t route_seq;
@@ -2284,7 +2284,7 @@ int main(int argc, char **argv)
 			exit_usage(argv);
 		}
 
-		if (nr_process > MAX_PROCESSES || !nr_process) {
+		if (nr_process > MAX_PROCESSES || nr_process < 1) {
 			printk("nr_process should be between [1; %u]",
 					MAX_PROCESSES);
 			exit_usage(argv);
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index c7f9ebeebc2c..d2043ec3bf6d 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -18,6 +18,7 @@
 
 #include <sys/ioctl.h>
 #include <sys/poll.h>
+#include <sys/random.h>
 #include <sys/sendfile.h>
 #include <sys/stat.h>
 #include <sys/socket.h>
@@ -1125,15 +1126,11 @@ int main_loop_s(int listensock)
 
 static void init_rng(void)
 {
-	int fd = open("/dev/urandom", O_RDONLY);
 	unsigned int foo;
 
-	if (fd > 0) {
-		int ret = read(fd, &foo, sizeof(foo));
-
-		if (ret < 0)
-			srand(fd + foo);
-		close(fd);
+	if (getrandom(&foo, sizeof(foo), 0) == -1) {
+		perror("getrandom");
+		exit(1);
 	}
 
 	srand(foo);
diff --git a/tools/testing/selftests/net/mptcp/mptcp_inq.c b/tools/testing/selftests/net/mptcp/mptcp_inq.c
index 8672d898f8cd..218aac467321 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_inq.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_inq.c
@@ -18,6 +18,7 @@
 #include <time.h>
 
 #include <sys/ioctl.h>
+#include <sys/random.h>
 #include <sys/socket.h>
 #include <sys/types.h>
 #include <sys/wait.h>
@@ -519,15 +520,11 @@ static int client(int unixfd)
 
 static void init_rng(void)
 {
-	int fd = open("/dev/urandom", O_RDONLY);
 	unsigned int foo;
 
-	if (fd > 0) {
-		int ret = read(fd, &foo, sizeof(foo));
-
-		if (ret < 0)
-			srand(fd + foo);
-		close(fd);
+	if (getrandom(&foo, sizeof(foo), 0) == -1) {
+		perror("getrandom");
+		exit(1);
 	}
 
 	srand(foo);
