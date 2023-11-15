Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E887A7E5474
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344387AbjKHKtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344404AbjKHKtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:49:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD7D3A80;
        Wed,  8 Nov 2023 02:46:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8FDC433C8;
        Wed,  8 Nov 2023 10:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699440366;
        bh=DFpe7YYfrhDgaLzzfDw996w6Tdt9WxNT+PQ73KLvUkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o+AcP95t17ShOEtpwQ9SxtlBm4aM/GNvV2S/7e7wGWY9ixX314cl2GS/s8BQMLA77
         CEori9Ls+QLb/we+50kV5uppQhBgDZjmmWX7xVEv9s4svGIDykzagWSs4Oq0hruc/2
         k4fKN4tYrsbrnneHRy2pS78KJ1q/JQjDgJm8dT7g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.14.329
Date:   Wed,  8 Nov 2023 11:45:56 +0100
Message-ID: <2023110855-overfed-easiness-7bc0@gregkh>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <2023110855-nebulizer-amuck-3018@gregkh>
References: <2023110855-nebulizer-amuck-3018@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index f0bb45a62374..caffc3b6eb94 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 14
-SUBLEVEL = 328
+SUBLEVEL = 329
 EXTRAVERSION =
 NAME = Petit Gorille
 
diff --git a/arch/arm/boot/bootp/init.S b/arch/arm/boot/bootp/init.S
index 78b508075161..868eeeaaa46e 100644
--- a/arch/arm/boot/bootp/init.S
+++ b/arch/arm/boot/bootp/init.S
@@ -16,7 +16,7 @@
  *  size immediately following the kernel, we could build this into
  *  a binary blob, and concatenate the zImage using the cat command.
  */
-		.section .start,#alloc,#execinstr
+		.section .start, "ax"
 		.type	_start, #function
 		.globl	_start
 
diff --git a/arch/arm/boot/compressed/big-endian.S b/arch/arm/boot/compressed/big-endian.S
index 88e2a88d324b..0e092c36da2f 100644
--- a/arch/arm/boot/compressed/big-endian.S
+++ b/arch/arm/boot/compressed/big-endian.S
@@ -6,7 +6,7 @@
  *  Author: Nicolas Pitre
  */
 
-	.section ".start", #alloc, #execinstr
+	.section ".start", "ax"
 
 	mrc	p15, 0, r0, c1, c0, 0	@ read control reg
 	orr	r0, r0, #(1 << 7)	@ enable big endian mode
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index becd5d4bc3a6..3317b00466ce 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -114,7 +114,7 @@
 #endif
 		.endm
 
-		.section ".start", #alloc, #execinstr
+		.section ".start", "ax"
 /*
  * sort out different calling conventions
  */
diff --git a/arch/arm/boot/compressed/piggy.S b/arch/arm/boot/compressed/piggy.S
index 0284f84dcf38..27577644ee72 100644
--- a/arch/arm/boot/compressed/piggy.S
+++ b/arch/arm/boot/compressed/piggy.S
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-	.section .piggydata,#alloc
+	.section .piggydata, "a"
 	.globl	input_data
 input_data:
 	.incbin	"arch/arm/boot/compressed/piggy_data"
diff --git a/arch/arm/mm/proc-arm1020.S b/arch/arm/mm/proc-arm1020.S
index 774ef1323554..4773490177c9 100644
--- a/arch/arm/mm/proc-arm1020.S
+++ b/arch/arm/mm/proc-arm1020.S
@@ -505,7 +505,7 @@ cpu_arm1020_name:
 
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 	.type	__arm1020_proc_info,#object
 __arm1020_proc_info:
diff --git a/arch/arm/mm/proc-arm1020e.S b/arch/arm/mm/proc-arm1020e.S
index ae3c27b71594..928e8ca58f40 100644
--- a/arch/arm/mm/proc-arm1020e.S
+++ b/arch/arm/mm/proc-arm1020e.S
@@ -463,7 +463,7 @@ arm1020e_crval:
 
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 	.type	__arm1020e_proc_info,#object
 __arm1020e_proc_info:
diff --git a/arch/arm/mm/proc-arm1022.S b/arch/arm/mm/proc-arm1022.S
index dbb2413fe04d..385584c3d222 100644
--- a/arch/arm/mm/proc-arm1022.S
+++ b/arch/arm/mm/proc-arm1022.S
@@ -448,7 +448,7 @@ arm1022_crval:
 
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 	.type	__arm1022_proc_info,#object
 __arm1022_proc_info:
diff --git a/arch/arm/mm/proc-arm1026.S b/arch/arm/mm/proc-arm1026.S
index 0b37b2cef9d3..29cc81857373 100644
--- a/arch/arm/mm/proc-arm1026.S
+++ b/arch/arm/mm/proc-arm1026.S
@@ -442,7 +442,7 @@ arm1026_crval:
 	string	cpu_arm1026_name, "ARM1026EJ-S"
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 	.type	__arm1026_proc_info,#object
 __arm1026_proc_info:
diff --git a/arch/arm/mm/proc-arm720.S b/arch/arm/mm/proc-arm720.S
index 3651cd70e418..c08cd1b0a1d0 100644
--- a/arch/arm/mm/proc-arm720.S
+++ b/arch/arm/mm/proc-arm720.S
@@ -186,7 +186,7 @@ arm720_crval:
  * See <asm/procinfo.h> for a definition of this structure.
  */
 	
-		.section ".proc.info.init", #alloc
+		.section ".proc.info.init", "a"
 
 .macro arm720_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req, cpu_flush:req
 		.type	__\name\()_proc_info,#object
diff --git a/arch/arm/mm/proc-arm740.S b/arch/arm/mm/proc-arm740.S
index 024fb7732407..6eed87103b95 100644
--- a/arch/arm/mm/proc-arm740.S
+++ b/arch/arm/mm/proc-arm740.S
@@ -132,7 +132,7 @@ __arm740_setup:
 
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 	.type	__arm740_proc_info,#object
 __arm740_proc_info:
 	.long	0x41807400
diff --git a/arch/arm/mm/proc-arm7tdmi.S b/arch/arm/mm/proc-arm7tdmi.S
index 25472d94426d..beb64a7ccb38 100644
--- a/arch/arm/mm/proc-arm7tdmi.S
+++ b/arch/arm/mm/proc-arm7tdmi.S
@@ -76,7 +76,7 @@ __arm7tdmi_setup:
 
 		.align
 
-		.section ".proc.info.init", #alloc
+		.section ".proc.info.init", "a"
 
 .macro arm7tdmi_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req, \
 	extra_hwcaps=0
diff --git a/arch/arm/mm/proc-arm920.S b/arch/arm/mm/proc-arm920.S
index 7a14bd4414c9..5d4319708362 100644
--- a/arch/arm/mm/proc-arm920.S
+++ b/arch/arm/mm/proc-arm920.S
@@ -448,7 +448,7 @@ arm920_crval:
 
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 	.type	__arm920_proc_info,#object
 __arm920_proc_info:
diff --git a/arch/arm/mm/proc-arm922.S b/arch/arm/mm/proc-arm922.S
index edccfcdcd551..7e22ca780b36 100644
--- a/arch/arm/mm/proc-arm922.S
+++ b/arch/arm/mm/proc-arm922.S
@@ -426,7 +426,7 @@ arm922_crval:
 
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 	.type	__arm922_proc_info,#object
 __arm922_proc_info:
diff --git a/arch/arm/mm/proc-arm925.S b/arch/arm/mm/proc-arm925.S
index 32a47cc19076..d343e77b8456 100644
--- a/arch/arm/mm/proc-arm925.S
+++ b/arch/arm/mm/proc-arm925.S
@@ -491,7 +491,7 @@ arm925_crval:
 
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 .macro arm925_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req, cache
 	.type	__\name\()_proc_info,#object
diff --git a/arch/arm/mm/proc-arm926.S b/arch/arm/mm/proc-arm926.S
index fb827c633693..8cf78c608c42 100644
--- a/arch/arm/mm/proc-arm926.S
+++ b/arch/arm/mm/proc-arm926.S
@@ -474,7 +474,7 @@ arm926_crval:
 
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 	.type	__arm926_proc_info,#object
 __arm926_proc_info:
diff --git a/arch/arm/mm/proc-arm940.S b/arch/arm/mm/proc-arm940.S
index ee5b66f847c4..631ae64eeccd 100644
--- a/arch/arm/mm/proc-arm940.S
+++ b/arch/arm/mm/proc-arm940.S
@@ -344,7 +344,7 @@ __arm940_setup:
 
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 	.type	__arm940_proc_info,#object
 __arm940_proc_info:
diff --git a/arch/arm/mm/proc-arm946.S b/arch/arm/mm/proc-arm946.S
index 7361837edc31..033ad7402d67 100644
--- a/arch/arm/mm/proc-arm946.S
+++ b/arch/arm/mm/proc-arm946.S
@@ -399,7 +399,7 @@ __arm946_setup:
 
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 	.type	__arm946_proc_info,#object
 __arm946_proc_info:
 	.long	0x41009460
diff --git a/arch/arm/mm/proc-arm9tdmi.S b/arch/arm/mm/proc-arm9tdmi.S
index 7fac8c612134..2195468ccd76 100644
--- a/arch/arm/mm/proc-arm9tdmi.S
+++ b/arch/arm/mm/proc-arm9tdmi.S
@@ -70,7 +70,7 @@ __arm9tdmi_setup:
 
 		.align
 
-		.section ".proc.info.init", #alloc
+		.section ".proc.info.init", "a"
 
 .macro arm9tdmi_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req
 		.type	__\name\()_proc_info, #object
diff --git a/arch/arm/mm/proc-fa526.S b/arch/arm/mm/proc-fa526.S
index 4001b73af4ee..fd3e5dd94e59 100644
--- a/arch/arm/mm/proc-fa526.S
+++ b/arch/arm/mm/proc-fa526.S
@@ -190,7 +190,7 @@ fa526_cr1_set:
 
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 	.type	__fa526_proc_info,#object
 __fa526_proc_info:
diff --git a/arch/arm/mm/proc-feroceon.S b/arch/arm/mm/proc-feroceon.S
index 92e08bf37aad..685d324a74d3 100644
--- a/arch/arm/mm/proc-feroceon.S
+++ b/arch/arm/mm/proc-feroceon.S
@@ -584,7 +584,7 @@ feroceon_crval:
 
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 .macro feroceon_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req, cache:req
 	.type	__\name\()_proc_info,#object
diff --git a/arch/arm/mm/proc-mohawk.S b/arch/arm/mm/proc-mohawk.S
index 6f07d2ef4ff2..9182321a586a 100644
--- a/arch/arm/mm/proc-mohawk.S
+++ b/arch/arm/mm/proc-mohawk.S
@@ -429,7 +429,7 @@ mohawk_crval:
 
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 	.type	__88sv331x_proc_info,#object
 __88sv331x_proc_info:
diff --git a/arch/arm/mm/proc-sa110.S b/arch/arm/mm/proc-sa110.S
index ee2ce496239f..093ad2ceff28 100644
--- a/arch/arm/mm/proc-sa110.S
+++ b/arch/arm/mm/proc-sa110.S
@@ -199,7 +199,7 @@ sa110_crval:
 
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 	.type	__sa110_proc_info,#object
 __sa110_proc_info:
diff --git a/arch/arm/mm/proc-sa1100.S b/arch/arm/mm/proc-sa1100.S
index 222d5836f666..12b8fcab4b59 100644
--- a/arch/arm/mm/proc-sa1100.S
+++ b/arch/arm/mm/proc-sa1100.S
@@ -242,7 +242,7 @@ sa1100_crval:
 
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 .macro sa1100_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req
 	.type	__\name\()_proc_info,#object
diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index 06d890a2342b..32f4df0915ef 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -264,7 +264,7 @@ v6_crval:
 	string	cpu_elf_name, "v6"
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 	/*
 	 * Match any ARMv6 processor core.
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index d8d90cf65b39..87263e003e20 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -636,7 +636,7 @@ __v7_setup_stack:
 	string	cpu_elf_name, "v7"
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 	/*
 	 * Standard v7 proc info content
diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
index c68408d51c4b..4f9c074a460b 100644
--- a/arch/arm/mm/proc-v7m.S
+++ b/arch/arm/mm/proc-v7m.S
@@ -96,7 +96,7 @@ ENTRY(cpu_cm7_proc_fin)
 	ret	lr
 ENDPROC(cpu_cm7_proc_fin)
 
-	.section ".init.text", #alloc, #execinstr
+	.section ".init.text", "ax"
 
 __v7m_cm7_setup:
 	mov	r8, #(V7M_SCB_CCR_DC | V7M_SCB_CCR_IC| V7M_SCB_CCR_BP)
@@ -181,7 +181,7 @@ ENDPROC(__v7m_setup)
 	string cpu_elf_name "v7m"
 	string cpu_v7m_name "ARMv7-M"
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 .macro __v7m_proc name, initfunc, cache_fns = nop_cache_fns, hwcaps = 0,  proc_fns = v7m_processor_functions
 	.long	0			/* proc_info_list.__cpu_mm_mmu_flags */
diff --git a/arch/arm/mm/proc-xsc3.S b/arch/arm/mm/proc-xsc3.S
index 293dcc2c441f..da96e4de1353 100644
--- a/arch/arm/mm/proc-xsc3.S
+++ b/arch/arm/mm/proc-xsc3.S
@@ -499,7 +499,7 @@ xsc3_crval:
 
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 .macro xsc3_proc_info name:req, cpu_val:req, cpu_mask:req
 	.type	__\name\()_proc_info,#object
diff --git a/arch/arm/mm/proc-xscale.S b/arch/arm/mm/proc-xscale.S
index 3d75b7972fd1..c7800c69921b 100644
--- a/arch/arm/mm/proc-xscale.S
+++ b/arch/arm/mm/proc-xscale.S
@@ -613,7 +613,7 @@ xscale_crval:
 
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 .macro xscale_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req, cache
 	.type	__\name\()_proc_info,#object
diff --git a/arch/x86/include/asm/i8259.h b/arch/x86/include/asm/i8259.h
index 89789e8c80f6..e16574c16e93 100644
--- a/arch/x86/include/asm/i8259.h
+++ b/arch/x86/include/asm/i8259.h
@@ -67,6 +67,8 @@ struct legacy_pic {
 	void (*make_irq)(unsigned int irq);
 };
 
+void legacy_pic_pcat_compat(void);
+
 extern struct legacy_pic *legacy_pic;
 extern struct legacy_pic null_legacy_pic;
 
diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index ae13bc974416..c5ed79159975 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -91,27 +91,16 @@ extern unsigned long _brk_end;
 void *extend_brk(size_t size, size_t align);
 
 /*
- * Reserve space in the brk section.  The name must be unique within
- * the file, and somewhat descriptive.  The size is in bytes.  Must be
- * used at file scope.
+ * Reserve space in the .brk section, which is a block of memory from which the
+ * caller is allowed to allocate very early (before even memblock is available)
+ * by calling extend_brk().  All allocated memory will be eventually converted
+ * to memblock.  Any leftover unallocated memory will be freed.
  *
- * (This uses a temp function to wrap the asm so we can pass it the
- * size parameter; otherwise we wouldn't be able to.  We can't use a
- * "section" attribute on a normal variable because it always ends up
- * being @progbits, which ends up allocating space in the vmlinux
- * executable.)
+ * The size is in bytes.
  */
-#define RESERVE_BRK(name,sz)						\
-	static void __section(.discard.text) __used notrace		\
-	__brk_reservation_fn_##name##__(void) {				\
-		asm volatile (						\
-			".pushsection .brk_reservation,\"aw\",@nobits;" \
-			".brk." #name ":"				\
-			" 1:.skip %c0;"					\
-			" .size .brk." #name ", . - 1b;"		\
-			" .popsection"					\
-			: : "i" (sz));					\
-	}
+#define RESERVE_BRK(name, size)					\
+	__section(.bss..brk) __aligned(1) __used	\
+	static char __brk_##name[size]
 
 /* Helper for reserving space for arrays of things */
 #define RESERVE_BRK_ARRAY(type, name, entries)		\
@@ -129,12 +118,19 @@ asmlinkage void __init x86_64_start_reservations(char *real_mode_data);
 
 #endif /* __i386__ */
 #endif /* _SETUP */
-#else
-#define RESERVE_BRK(name,sz)				\
-	.pushsection .brk_reservation,"aw",@nobits;	\
-.brk.name:						\
-1:	.skip sz;					\
-	.size .brk.name,.-1b;				\
+
+#else  /* __ASSEMBLY */
+
+.macro __RESERVE_BRK name, size
+	.pushsection .bss..brk, "aw"
+GLOBAL(__brk_\name)
+	.skip \size
+END(__brk_\name)
 	.popsection
+.endm
+
+#define RESERVE_BRK(name, size) __RESERVE_BRK name, size
+
 #endif /* __ASSEMBLY__ */
+
 #endif /* _ASM_X86_SETUP_H */
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index fd9c4479880d..30a7a12324b9 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -156,6 +156,9 @@ static int __init acpi_parse_madt(struct acpi_table_header *table)
 		       madt->address);
 	}
 
+	if (madt->flags & ACPI_MADT_PCAT_COMPAT)
+		legacy_pic_pcat_compat();
+
 	default_acpi_madt_oem_check(madt->header.oem_id,
 				    madt->header.oem_table_id);
 
diff --git a/arch/x86/kernel/i8259.c b/arch/x86/kernel/i8259.c
index c359b8265ad4..26017ed088cc 100644
--- a/arch/x86/kernel/i8259.c
+++ b/arch/x86/kernel/i8259.c
@@ -32,6 +32,7 @@
  */
 static void init_8259A(int auto_eoi);
 
+static bool pcat_compat __ro_after_init;
 static int i8259A_auto_eoi;
 DEFINE_RAW_SPINLOCK(i8259A_lock);
 
@@ -300,15 +301,32 @@ static void unmask_8259A(void)
 
 static int probe_8259A(void)
 {
+	unsigned char new_val, probe_val = ~(1 << PIC_CASCADE_IR);
 	unsigned long flags;
-	unsigned char probe_val = ~(1 << PIC_CASCADE_IR);
-	unsigned char new_val;
+
+	/*
+	 * If MADT has the PCAT_COMPAT flag set, then do not bother probing
+	 * for the PIC. Some BIOSes leave the PIC uninitialized and probing
+	 * fails.
+	 *
+	 * Right now this causes problems as quite some code depends on
+	 * nr_legacy_irqs() > 0 or has_legacy_pic() == true. This is silly
+	 * when the system has an IO/APIC because then PIC is not required
+	 * at all, except for really old machines where the timer interrupt
+	 * must be routed through the PIC. So just pretend that the PIC is
+	 * there and let legacy_pic->init() initialize it for nothing.
+	 *
+	 * Alternatively this could just try to initialize the PIC and
+	 * repeat the probe, but for cases where there is no PIC that's
+	 * just pointless.
+	 */
+	if (pcat_compat)
+		return nr_legacy_irqs();
+
 	/*
-	 * Check to see if we have a PIC.
-	 * Mask all except the cascade and read
-	 * back the value we just wrote. If we don't
-	 * have a PIC, we will read 0xff as opposed to the
-	 * value we wrote.
+	 * Check to see if we have a PIC.  Mask all except the cascade and
+	 * read back the value we just wrote. If we don't have a PIC, we
+	 * will read 0xff as opposed to the value we wrote.
 	 */
 	raw_spin_lock_irqsave(&i8259A_lock, flags);
 
@@ -430,5 +448,9 @@ static int __init i8259A_init_ops(void)
 
 	return 0;
 }
-
 device_initcall(i8259A_init_ops);
+
+void __init legacy_pic_pcat_compat(void)
+{
+	pcat_compat = true;
+}
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index d3dc8bc6b3ad..4f274df917f7 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -362,7 +362,7 @@ SECTIONS
 	.brk : AT(ADDR(.brk) - LOAD_OFFSET) {
 		__brk_base = .;
 		. += 64 * 1024;		/* 64k alignment slop space */
-		*(.brk_reservation)	/* areas brk users have reserved */
+		*(.bss..brk)		/* areas brk users have reserved */
 		__brk_limit = .;
 	}
 
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index f41f98626354..a0ad1c30d206 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -40,6 +40,7 @@
 #include <linux/libata.h>
 #include <linux/phy/phy.h>
 #include <linux/regulator/consumer.h>
+#include <linux/bits.h>
 
 /* Enclosure Management Control */
 #define EM_CTRL_MSG_TYPE              0x000f0000
@@ -70,12 +71,12 @@ enum {
 	AHCI_PORT_PRIV_FBS_DMA_SZ	= AHCI_CMD_SLOT_SZ +
 					  AHCI_CMD_TBL_AR_SZ +
 					  (AHCI_RX_FIS_SZ * 16),
-	AHCI_IRQ_ON_SG		= (1 << 31),
-	AHCI_CMD_ATAPI		= (1 << 5),
-	AHCI_CMD_WRITE		= (1 << 6),
-	AHCI_CMD_PREFETCH	= (1 << 7),
-	AHCI_CMD_RESET		= (1 << 8),
-	AHCI_CMD_CLR_BUSY	= (1 << 10),
+	AHCI_IRQ_ON_SG		= BIT(31),
+	AHCI_CMD_ATAPI		= BIT(5),
+	AHCI_CMD_WRITE		= BIT(6),
+	AHCI_CMD_PREFETCH	= BIT(7),
+	AHCI_CMD_RESET		= BIT(8),
+	AHCI_CMD_CLR_BUSY	= BIT(10),
 
 	RX_FIS_PIO_SETUP	= 0x20,	/* offset of PIO Setup FIS data */
 	RX_FIS_D2H_REG		= 0x40,	/* offset of D2H Register FIS data */
@@ -93,37 +94,37 @@ enum {
 	HOST_CAP2		= 0x24, /* host capabilities, extended */
 
 	/* HOST_CTL bits */
-	HOST_RESET		= (1 << 0),  /* reset controller; self-clear */
-	HOST_IRQ_EN		= (1 << 1),  /* global IRQ enable */
-	HOST_MRSM		= (1 << 2),  /* MSI Revert to Single Message */
-	HOST_AHCI_EN		= (1 << 31), /* AHCI enabled */
+	HOST_RESET		= BIT(0),  /* reset controller; self-clear */
+	HOST_IRQ_EN		= BIT(1),  /* global IRQ enable */
+	HOST_MRSM		= BIT(2),  /* MSI Revert to Single Message */
+	HOST_AHCI_EN		= BIT(31), /* AHCI enabled */
 
 	/* HOST_CAP bits */
-	HOST_CAP_SXS		= (1 << 5),  /* Supports External SATA */
-	HOST_CAP_EMS		= (1 << 6),  /* Enclosure Management support */
-	HOST_CAP_CCC		= (1 << 7),  /* Command Completion Coalescing */
-	HOST_CAP_PART		= (1 << 13), /* Partial state capable */
-	HOST_CAP_SSC		= (1 << 14), /* Slumber state capable */
-	HOST_CAP_PIO_MULTI	= (1 << 15), /* PIO multiple DRQ support */
-	HOST_CAP_FBS		= (1 << 16), /* FIS-based switching support */
-	HOST_CAP_PMP		= (1 << 17), /* Port Multiplier support */
-	HOST_CAP_ONLY		= (1 << 18), /* Supports AHCI mode only */
-	HOST_CAP_CLO		= (1 << 24), /* Command List Override support */
-	HOST_CAP_LED		= (1 << 25), /* Supports activity LED */
-	HOST_CAP_ALPM		= (1 << 26), /* Aggressive Link PM support */
-	HOST_CAP_SSS		= (1 << 27), /* Staggered Spin-up */
-	HOST_CAP_MPS		= (1 << 28), /* Mechanical presence switch */
-	HOST_CAP_SNTF		= (1 << 29), /* SNotification register */
-	HOST_CAP_NCQ		= (1 << 30), /* Native Command Queueing */
-	HOST_CAP_64		= (1 << 31), /* PCI DAC (64-bit DMA) support */
+	HOST_CAP_SXS		= BIT(5),  /* Supports External SATA */
+	HOST_CAP_EMS		= BIT(6),  /* Enclosure Management support */
+	HOST_CAP_CCC		= BIT(7),  /* Command Completion Coalescing */
+	HOST_CAP_PART		= BIT(13), /* Partial state capable */
+	HOST_CAP_SSC		= BIT(14), /* Slumber state capable */
+	HOST_CAP_PIO_MULTI	= BIT(15), /* PIO multiple DRQ support */
+	HOST_CAP_FBS		= BIT(16), /* FIS-based switching support */
+	HOST_CAP_PMP		= BIT(17), /* Port Multiplier support */
+	HOST_CAP_ONLY		= BIT(18), /* Supports AHCI mode only */
+	HOST_CAP_CLO		= BIT(24), /* Command List Override support */
+	HOST_CAP_LED		= BIT(25), /* Supports activity LED */
+	HOST_CAP_ALPM		= BIT(26), /* Aggressive Link PM support */
+	HOST_CAP_SSS		= BIT(27), /* Staggered Spin-up */
+	HOST_CAP_MPS		= BIT(28), /* Mechanical presence switch */
+	HOST_CAP_SNTF		= BIT(29), /* SNotification register */
+	HOST_CAP_NCQ		= BIT(30), /* Native Command Queueing */
+	HOST_CAP_64		= BIT(31), /* PCI DAC (64-bit DMA) support */
 
 	/* HOST_CAP2 bits */
-	HOST_CAP2_BOH		= (1 << 0),  /* BIOS/OS handoff supported */
-	HOST_CAP2_NVMHCI	= (1 << 1),  /* NVMHCI supported */
-	HOST_CAP2_APST		= (1 << 2),  /* Automatic partial to slumber */
-	HOST_CAP2_SDS		= (1 << 3),  /* Support device sleep */
-	HOST_CAP2_SADM		= (1 << 4),  /* Support aggressive DevSlp */
-	HOST_CAP2_DESO		= (1 << 5),  /* DevSlp from slumber only */
+	HOST_CAP2_BOH		= BIT(0),  /* BIOS/OS handoff supported */
+	HOST_CAP2_NVMHCI	= BIT(1),  /* NVMHCI supported */
+	HOST_CAP2_APST		= BIT(2),  /* Automatic partial to slumber */
+	HOST_CAP2_SDS		= BIT(3),  /* Support device sleep */
+	HOST_CAP2_SADM		= BIT(4),  /* Support aggressive DevSlp */
+	HOST_CAP2_DESO		= BIT(5),  /* DevSlp from slumber only */
 
 	/* registers for each SATA port */
 	PORT_LST_ADDR		= 0x00, /* command list DMA addr */
@@ -145,24 +146,25 @@ enum {
 	PORT_DEVSLP		= 0x44, /* device sleep */
 
 	/* PORT_IRQ_{STAT,MASK} bits */
-	PORT_IRQ_COLD_PRES	= (1 << 31), /* cold presence detect */
-	PORT_IRQ_TF_ERR		= (1 << 30), /* task file error */
-	PORT_IRQ_HBUS_ERR	= (1 << 29), /* host bus fatal error */
-	PORT_IRQ_HBUS_DATA_ERR	= (1 << 28), /* host bus data error */
-	PORT_IRQ_IF_ERR		= (1 << 27), /* interface fatal error */
-	PORT_IRQ_IF_NONFATAL	= (1 << 26), /* interface non-fatal error */
-	PORT_IRQ_OVERFLOW	= (1 << 24), /* xfer exhausted available S/G */
-	PORT_IRQ_BAD_PMP	= (1 << 23), /* incorrect port multiplier */
-
-	PORT_IRQ_PHYRDY		= (1 << 22), /* PhyRdy changed */
-	PORT_IRQ_DEV_ILCK	= (1 << 7), /* device interlock */
-	PORT_IRQ_CONNECT	= (1 << 6), /* port connect change status */
-	PORT_IRQ_SG_DONE	= (1 << 5), /* descriptor processed */
-	PORT_IRQ_UNK_FIS	= (1 << 4), /* unknown FIS rx'd */
-	PORT_IRQ_SDB_FIS	= (1 << 3), /* Set Device Bits FIS rx'd */
-	PORT_IRQ_DMAS_FIS	= (1 << 2), /* DMA Setup FIS rx'd */
-	PORT_IRQ_PIOS_FIS	= (1 << 1), /* PIO Setup FIS rx'd */
-	PORT_IRQ_D2H_REG_FIS	= (1 << 0), /* D2H Register FIS rx'd */
+	PORT_IRQ_COLD_PRES	= BIT(31), /* cold presence detect */
+	PORT_IRQ_TF_ERR		= BIT(30), /* task file error */
+	PORT_IRQ_HBUS_ERR	= BIT(29), /* host bus fatal error */
+	PORT_IRQ_HBUS_DATA_ERR	= BIT(28), /* host bus data error */
+	PORT_IRQ_IF_ERR		= BIT(27), /* interface fatal error */
+	PORT_IRQ_IF_NONFATAL	= BIT(26), /* interface non-fatal error */
+	PORT_IRQ_OVERFLOW	= BIT(24), /* xfer exhausted available S/G */
+	PORT_IRQ_BAD_PMP	= BIT(23), /* incorrect port multiplier */
+
+	PORT_IRQ_PHYRDY		= BIT(22), /* PhyRdy changed */
+	PORT_IRQ_DEV_ILCK	= BIT(7),  /* device interlock */
+	PORT_IRQ_DMPS		= BIT(7),  /* mechanical presence status */
+	PORT_IRQ_CONNECT	= BIT(6),  /* port connect change status */
+	PORT_IRQ_SG_DONE	= BIT(5),  /* descriptor processed */
+	PORT_IRQ_UNK_FIS	= BIT(4),  /* unknown FIS rx'd */
+	PORT_IRQ_SDB_FIS	= BIT(3),  /* Set Device Bits FIS rx'd */
+	PORT_IRQ_DMAS_FIS	= BIT(2),  /* DMA Setup FIS rx'd */
+	PORT_IRQ_PIOS_FIS	= BIT(1),  /* PIO Setup FIS rx'd */
+	PORT_IRQ_D2H_REG_FIS	= BIT(0),  /* D2H Register FIS rx'd */
 
 	PORT_IRQ_FREEZE		= PORT_IRQ_HBUS_ERR |
 				  PORT_IRQ_IF_ERR |
@@ -178,34 +180,34 @@ enum {
 				  PORT_IRQ_PIOS_FIS | PORT_IRQ_D2H_REG_FIS,
 
 	/* PORT_CMD bits */
-	PORT_CMD_ASP		= (1 << 27), /* Aggressive Slumber/Partial */
-	PORT_CMD_ALPE		= (1 << 26), /* Aggressive Link PM enable */
-	PORT_CMD_ATAPI		= (1 << 24), /* Device is ATAPI */
-	PORT_CMD_FBSCP		= (1 << 22), /* FBS Capable Port */
-	PORT_CMD_ESP		= (1 << 21), /* External Sata Port */
-	PORT_CMD_HPCP		= (1 << 18), /* HotPlug Capable Port */
-	PORT_CMD_PMP		= (1 << 17), /* PMP attached */
-	PORT_CMD_LIST_ON	= (1 << 15), /* cmd list DMA engine running */
-	PORT_CMD_FIS_ON		= (1 << 14), /* FIS DMA engine running */
-	PORT_CMD_FIS_RX		= (1 << 4), /* Enable FIS receive DMA engine */
-	PORT_CMD_CLO		= (1 << 3), /* Command list override */
-	PORT_CMD_POWER_ON	= (1 << 2), /* Power up device */
-	PORT_CMD_SPIN_UP	= (1 << 1), /* Spin up device */
-	PORT_CMD_START		= (1 << 0), /* Enable port DMA engine */
-
-	PORT_CMD_ICC_MASK	= (0xf << 28), /* i/f ICC state mask */
-	PORT_CMD_ICC_ACTIVE	= (0x1 << 28), /* Put i/f in active state */
-	PORT_CMD_ICC_PARTIAL	= (0x2 << 28), /* Put i/f in partial state */
-	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */
+	PORT_CMD_ASP		= BIT(27), /* Aggressive Slumber/Partial */
+	PORT_CMD_ALPE		= BIT(26), /* Aggressive Link PM enable */
+	PORT_CMD_ATAPI		= BIT(24), /* Device is ATAPI */
+	PORT_CMD_FBSCP		= BIT(22), /* FBS Capable Port */
+	PORT_CMD_ESP		= BIT(21), /* External Sata Port */
+	PORT_CMD_HPCP		= BIT(18), /* HotPlug Capable Port */
+	PORT_CMD_PMP		= BIT(17), /* PMP attached */
+	PORT_CMD_LIST_ON	= BIT(15), /* cmd list DMA engine running */
+	PORT_CMD_FIS_ON		= BIT(14), /* FIS DMA engine running */
+	PORT_CMD_FIS_RX		= BIT(4),  /* Enable FIS receive DMA engine */
+	PORT_CMD_CLO		= BIT(3),  /* Command list override */
+	PORT_CMD_POWER_ON	= BIT(2),  /* Power up device */
+	PORT_CMD_SPIN_UP	= BIT(1),  /* Spin up device */
+	PORT_CMD_START		= BIT(0),  /* Enable port DMA engine */
+
+	PORT_CMD_ICC_MASK	= (0xfu << 28), /* i/f ICC state mask */
+	PORT_CMD_ICC_ACTIVE	= (0x1u << 28), /* Put i/f in active state */
+	PORT_CMD_ICC_PARTIAL	= (0x2u << 28), /* Put i/f in partial state */
+	PORT_CMD_ICC_SLUMBER	= (0x6u << 28), /* Put i/f in slumber state */
 
 	/* PORT_FBS bits */
 	PORT_FBS_DWE_OFFSET	= 16, /* FBS device with error offset */
 	PORT_FBS_ADO_OFFSET	= 12, /* FBS active dev optimization offset */
 	PORT_FBS_DEV_OFFSET	= 8,  /* FBS device to issue offset */
 	PORT_FBS_DEV_MASK	= (0xf << PORT_FBS_DEV_OFFSET),  /* FBS.DEV */
-	PORT_FBS_SDE		= (1 << 2), /* FBS single device error */
-	PORT_FBS_DEC		= (1 << 1), /* FBS device error clear */
-	PORT_FBS_EN		= (1 << 0), /* Enable FBS */
+	PORT_FBS_SDE		= BIT(2), /* FBS single device error */
+	PORT_FBS_DEC		= BIT(1), /* FBS device error clear */
+	PORT_FBS_EN		= BIT(0), /* Enable FBS */
 
 	/* PORT_DEVSLP bits */
 	PORT_DEVSLP_DM_OFFSET	= 25,             /* DITO multiplier offset */
@@ -213,44 +215,44 @@ enum {
 	PORT_DEVSLP_DITO_OFFSET	= 15,             /* DITO offset */
 	PORT_DEVSLP_MDAT_OFFSET	= 10,             /* Minimum assertion time */
 	PORT_DEVSLP_DETO_OFFSET	= 2,              /* DevSlp exit timeout */
-	PORT_DEVSLP_DSP		= (1 << 1),       /* DevSlp present */
-	PORT_DEVSLP_ADSE	= (1 << 0),       /* Aggressive DevSlp enable */
+	PORT_DEVSLP_DSP		= BIT(1),         /* DevSlp present */
+	PORT_DEVSLP_ADSE	= BIT(0),         /* Aggressive DevSlp enable */
 
 	/* hpriv->flags bits */
 
 #define AHCI_HFLAGS(flags)		.private_data	= (void *)(flags)
 
-	AHCI_HFLAG_NO_NCQ		= (1 << 0),
-	AHCI_HFLAG_IGN_IRQ_IF_ERR	= (1 << 1), /* ignore IRQ_IF_ERR */
-	AHCI_HFLAG_IGN_SERR_INTERNAL	= (1 << 2), /* ignore SERR_INTERNAL */
-	AHCI_HFLAG_32BIT_ONLY		= (1 << 3), /* force 32bit */
-	AHCI_HFLAG_MV_PATA		= (1 << 4), /* PATA port */
-	AHCI_HFLAG_NO_MSI		= (1 << 5), /* no PCI MSI */
-	AHCI_HFLAG_NO_PMP		= (1 << 6), /* no PMP */
-	AHCI_HFLAG_SECT255		= (1 << 8), /* max 255 sectors */
-	AHCI_HFLAG_YES_NCQ		= (1 << 9), /* force NCQ cap on */
-	AHCI_HFLAG_NO_SUSPEND		= (1 << 10), /* don't suspend */
-	AHCI_HFLAG_SRST_TOUT_IS_OFFLINE	= (1 << 11), /* treat SRST timeout as
-							link offline */
-	AHCI_HFLAG_NO_SNTF		= (1 << 12), /* no sntf */
-	AHCI_HFLAG_NO_FPDMA_AA		= (1 << 13), /* no FPDMA AA */
-	AHCI_HFLAG_YES_FBS		= (1 << 14), /* force FBS cap on */
-	AHCI_HFLAG_DELAY_ENGINE		= (1 << 15), /* do not start engine on
-						        port start (wait until
-						        error-handling stage) */
-	AHCI_HFLAG_NO_DEVSLP		= (1 << 17), /* no device sleep */
-	AHCI_HFLAG_NO_FBS		= (1 << 18), /* no FBS */
+	AHCI_HFLAG_NO_NCQ		= BIT(0),
+	AHCI_HFLAG_IGN_IRQ_IF_ERR	= BIT(1), /* ignore IRQ_IF_ERR */
+	AHCI_HFLAG_IGN_SERR_INTERNAL	= BIT(2), /* ignore SERR_INTERNAL */
+	AHCI_HFLAG_32BIT_ONLY		= BIT(3), /* force 32bit */
+	AHCI_HFLAG_MV_PATA		= BIT(4), /* PATA port */
+	AHCI_HFLAG_NO_MSI		= BIT(5), /* no PCI MSI */
+	AHCI_HFLAG_NO_PMP		= BIT(6), /* no PMP */
+	AHCI_HFLAG_SECT255		= BIT(8), /* max 255 sectors */
+	AHCI_HFLAG_YES_NCQ		= BIT(9), /* force NCQ cap on */
+	AHCI_HFLAG_NO_SUSPEND		= BIT(10), /* don't suspend */
+	AHCI_HFLAG_SRST_TOUT_IS_OFFLINE	= BIT(11), /* treat SRST timeout as
+						      link offline */
+	AHCI_HFLAG_NO_SNTF		= BIT(12), /* no sntf */
+	AHCI_HFLAG_NO_FPDMA_AA		= BIT(13), /* no FPDMA AA */
+	AHCI_HFLAG_YES_FBS		= BIT(14), /* force FBS cap on */
+	AHCI_HFLAG_DELAY_ENGINE		= BIT(15), /* do not start engine on
+						      port start (wait until
+						      error-handling stage) */
+	AHCI_HFLAG_NO_DEVSLP		= BIT(17), /* no device sleep */
+	AHCI_HFLAG_NO_FBS		= BIT(18), /* no FBS */
 
 #ifdef CONFIG_PCI_MSI
-	AHCI_HFLAG_MULTI_MSI		= (1 << 20), /* per-port MSI(-X) */
+	AHCI_HFLAG_MULTI_MSI		= BIT(20), /* per-port MSI(-X) */
 #else
 	/* compile out MSI infrastructure */
 	AHCI_HFLAG_MULTI_MSI		= 0,
 #endif
-	AHCI_HFLAG_WAKE_BEFORE_STOP	= (1 << 22), /* wake before DMA stop */
-	AHCI_HFLAG_YES_ALPM		= (1 << 23), /* force ALPM cap on */
-	AHCI_HFLAG_NO_WRITE_TO_RO	= (1 << 24), /* don't write to read
-							only registers */
+	AHCI_HFLAG_WAKE_BEFORE_STOP	= BIT(22), /* wake before DMA stop */
+	AHCI_HFLAG_YES_ALPM		= BIT(23), /* force ALPM cap on */
+	AHCI_HFLAG_NO_WRITE_TO_RO	= BIT(24), /* don't write to read
+						      only registers */
 
 	/* ap->flags bits */
 
@@ -264,22 +266,22 @@ enum {
 	EM_MAX_RETRY			= 5,
 
 	/* em_ctl bits */
-	EM_CTL_RST		= (1 << 9), /* Reset */
-	EM_CTL_TM		= (1 << 8), /* Transmit Message */
-	EM_CTL_MR		= (1 << 0), /* Message Received */
-	EM_CTL_ALHD		= (1 << 26), /* Activity LED */
-	EM_CTL_XMT		= (1 << 25), /* Transmit Only */
-	EM_CTL_SMB		= (1 << 24), /* Single Message Buffer */
-	EM_CTL_SGPIO		= (1 << 19), /* SGPIO messages supported */
-	EM_CTL_SES		= (1 << 18), /* SES-2 messages supported */
-	EM_CTL_SAFTE		= (1 << 17), /* SAF-TE messages supported */
-	EM_CTL_LED		= (1 << 16), /* LED messages supported */
+	EM_CTL_RST		= BIT(9), /* Reset */
+	EM_CTL_TM		= BIT(8), /* Transmit Message */
+	EM_CTL_MR		= BIT(0), /* Message Received */
+	EM_CTL_ALHD		= BIT(26), /* Activity LED */
+	EM_CTL_XMT		= BIT(25), /* Transmit Only */
+	EM_CTL_SMB		= BIT(24), /* Single Message Buffer */
+	EM_CTL_SGPIO		= BIT(19), /* SGPIO messages supported */
+	EM_CTL_SES		= BIT(18), /* SES-2 messages supported */
+	EM_CTL_SAFTE		= BIT(17), /* SAF-TE messages supported */
+	EM_CTL_LED		= BIT(16), /* LED messages supported */
 
 	/* em message type */
-	EM_MSG_TYPE_LED		= (1 << 0), /* LED */
-	EM_MSG_TYPE_SAFTE	= (1 << 1), /* SAF-TE */
-	EM_MSG_TYPE_SES2	= (1 << 2), /* SES-2 */
-	EM_MSG_TYPE_SGPIO	= (1 << 3), /* SGPIO */
+	EM_MSG_TYPE_LED		= BIT(0), /* LED */
+	EM_MSG_TYPE_SAFTE	= BIT(1), /* SAF-TE */
+	EM_MSG_TYPE_SES2	= BIT(2), /* SES-2 */
+	EM_MSG_TYPE_SGPIO	= BIT(3), /* SGPIO */
 };
 
 struct ahci_cmd_hdr {
diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index 4eabfe28d2b3..9fb57df44c77 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -31,6 +31,75 @@ static struct device *next_device(struct klist_iter *i)
 	return dev;
 }
 
+/**
+ * driver_set_override() - Helper to set or clear driver override.
+ * @dev: Device to change
+ * @override: Address of string to change (e.g. &device->driver_override);
+ *            The contents will be freed and hold newly allocated override.
+ * @s: NUL-terminated string, new driver name to force a match, pass empty
+ *     string to clear it ("" or "\n", where the latter is only for sysfs
+ *     interface).
+ * @len: length of @s
+ *
+ * Helper to set or clear driver override in a device, intended for the cases
+ * when the driver_override field is allocated by driver/bus code.
+ *
+ * Returns: 0 on success or a negative error code on failure.
+ */
+int driver_set_override(struct device *dev, const char **override,
+			const char *s, size_t len)
+{
+	const char *new, *old;
+	char *cp;
+
+	if (!override || !s)
+		return -EINVAL;
+
+	/*
+	 * The stored value will be used in sysfs show callback (sysfs_emit()),
+	 * which has a length limit of PAGE_SIZE and adds a trailing newline.
+	 * Thus we can store one character less to avoid truncation during sysfs
+	 * show.
+	 */
+	if (len >= (PAGE_SIZE - 1))
+		return -EINVAL;
+
+	if (!len) {
+		/* Empty string passed - clear override */
+		device_lock(dev);
+		old = *override;
+		*override = NULL;
+		device_unlock(dev);
+		kfree(old);
+
+		return 0;
+	}
+
+	cp = strnchr(s, len, '\n');
+	if (cp)
+		len = cp - s;
+
+	new = kstrndup(s, len, GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+
+	device_lock(dev);
+	old = *override;
+	if (cp != s) {
+		*override = new;
+	} else {
+		/* "\n" passed - clear override */
+		kfree(new);
+		*override = NULL;
+	}
+	device_unlock(dev);
+
+	kfree(old);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(driver_set_override);
+
 /**
  * driver_for_each_device - Iterator for devices bound to a driver.
  * @drv: Driver we're iterating.
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 0ee3cab88f70..f2273655284f 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -873,31 +873,11 @@ static ssize_t driver_override_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-	char *driver_override, *old, *cp;
-
-	/* We need to keep extra room for a newline */
-	if (count >= (PAGE_SIZE - 1))
-		return -EINVAL;
-
-	driver_override = kstrndup(buf, count, GFP_KERNEL);
-	if (!driver_override)
-		return -ENOMEM;
-
-	cp = strchr(driver_override, '\n');
-	if (cp)
-		*cp = '\0';
-
-	device_lock(dev);
-	old = pdev->driver_override;
-	if (strlen(driver_override)) {
-		pdev->driver_override = driver_override;
-	} else {
-		kfree(driver_override);
-		pdev->driver_override = NULL;
-	}
-	device_unlock(dev);
+	int ret;
 
-	kfree(old);
+	ret = driver_set_override(dev, &pdev->driver_override, buf, count);
+	if (ret)
+		return ret;
 
 	return count;
 }
diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 6c60b1a63cc6..45aaeada8161 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -303,15 +303,6 @@ config BLK_DEV_SKD
 
 	Use device /dev/skd$N amd /dev/skd$Np$M.
 
-config BLK_DEV_SX8
-	tristate "Promise SATA SX8 support"
-	depends on PCI
-	---help---
-	  Saying Y or M here will enable support for the 
-	  Promise SATA SX8 controllers.
-
-	  Use devices /dev/sx8/$N and /dev/sx8/$Np$M.
-
 config BLK_DEV_RAM
 	tristate "RAM block device support"
 	select DAX if BLK_DEV_RAM_DAX
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index dc061158b403..af75f0c0c337 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -27,8 +27,6 @@ obj-$(CONFIG_BLK_DEV_NBD)	+= nbd.o
 obj-$(CONFIG_BLK_DEV_CRYPTOLOOP) += cryptoloop.o
 obj-$(CONFIG_VIRTIO_BLK)	+= virtio_blk.o
 
-obj-$(CONFIG_BLK_DEV_SX8)	+= sx8.o
-
 obj-$(CONFIG_XEN_BLKDEV_FRONTEND)	+= xen-blkfront.o
 obj-$(CONFIG_XEN_BLKDEV_BACKEND)	+= xen-blkback/
 obj-$(CONFIG_BLK_DEV_DRBD)     += drbd/
diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
deleted file mode 100644
index 08586dc14e85..000000000000
--- a/drivers/block/sx8.c
+++ /dev/null
@@ -1,1746 +0,0 @@
-/*
- *  sx8.c: Driver for Promise SATA SX8 looks-like-I2O hardware
- *
- *  Copyright 2004-2005 Red Hat, Inc.
- *
- *  Author/maintainer:  Jeff Garzik <jgarzik@pobox.com>
- *
- *  This file is subject to the terms and conditions of the GNU General Public
- *  License.  See the file "COPYING" in the main directory of this archive
- *  for more details.
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
-#include <linux/blkdev.h>
-#include <linux/sched.h>
-#include <linux/interrupt.h>
-#include <linux/compiler.h>
-#include <linux/workqueue.h>
-#include <linux/bitops.h>
-#include <linux/delay.h>
-#include <linux/ktime.h>
-#include <linux/hdreg.h>
-#include <linux/dma-mapping.h>
-#include <linux/completion.h>
-#include <linux/scatterlist.h>
-#include <asm/io.h>
-#include <linux/uaccess.h>
-
-#if 0
-#define CARM_DEBUG
-#define CARM_VERBOSE_DEBUG
-#else
-#undef CARM_DEBUG
-#undef CARM_VERBOSE_DEBUG
-#endif
-#undef CARM_NDEBUG
-
-#define DRV_NAME "sx8"
-#define DRV_VERSION "1.0"
-#define PFX DRV_NAME ": "
-
-MODULE_AUTHOR("Jeff Garzik");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Promise SATA SX8 block driver");
-MODULE_VERSION(DRV_VERSION);
-
-/*
- * SX8 hardware has a single message queue for all ATA ports.
- * When this driver was written, the hardware (firmware?) would
- * corrupt data eventually, if more than one request was outstanding.
- * As one can imagine, having 8 ports bottlenecking on a single
- * command hurts performance.
- *
- * Based on user reports, later versions of the hardware (firmware?)
- * seem to be able to survive with more than one command queued.
- *
- * Therefore, we default to the safe option -- 1 command -- but
- * allow the user to increase this.
- *
- * SX8 should be able to support up to ~60 queued commands (CARM_MAX_REQ),
- * but problems seem to occur when you exceed ~30, even on newer hardware.
- */
-static int max_queue = 1;
-module_param(max_queue, int, 0444);
-MODULE_PARM_DESC(max_queue, "Maximum number of queued commands. (min==1, max==30, safe==1)");
-
-
-#define NEXT_RESP(idx)	((idx + 1) % RMSG_Q_LEN)
-
-/* 0xf is just arbitrary, non-zero noise; this is sorta like poisoning */
-#define TAG_ENCODE(tag)	(((tag) << 16) | 0xf)
-#define TAG_DECODE(tag)	(((tag) >> 16) & 0x1f)
-#define TAG_VALID(tag)	((((tag) & 0xf) == 0xf) && (TAG_DECODE(tag) < 32))
-
-/* note: prints function name for you */
-#ifdef CARM_DEBUG
-#define DPRINTK(fmt, args...) printk(KERN_ERR "%s: " fmt, __func__, ## args)
-#ifdef CARM_VERBOSE_DEBUG
-#define VPRINTK(fmt, args...) printk(KERN_ERR "%s: " fmt, __func__, ## args)
-#else
-#define VPRINTK(fmt, args...)
-#endif	/* CARM_VERBOSE_DEBUG */
-#else
-#define DPRINTK(fmt, args...)
-#define VPRINTK(fmt, args...)
-#endif	/* CARM_DEBUG */
-
-#ifdef CARM_NDEBUG
-#define assert(expr)
-#else
-#define assert(expr) \
-        if(unlikely(!(expr))) {                                   \
-        printk(KERN_ERR "Assertion failed! %s,%s,%s,line=%d\n", \
-	#expr, __FILE__, __func__, __LINE__);          \
-        }
-#endif
-
-/* defines only for the constants which don't work well as enums */
-struct carm_host;
-
-enum {
-	/* adapter-wide limits */
-	CARM_MAX_PORTS		= 8,
-	CARM_SHM_SIZE		= (4096 << 7),
-	CARM_MINORS_PER_MAJOR	= 256 / CARM_MAX_PORTS,
-	CARM_MAX_WAIT_Q		= CARM_MAX_PORTS + 1,
-
-	/* command message queue limits */
-	CARM_MAX_REQ		= 64,	       /* max command msgs per host */
-	CARM_MSG_LOW_WATER	= (CARM_MAX_REQ / 4),	     /* refill mark */
-
-	/* S/G limits, host-wide and per-request */
-	CARM_MAX_REQ_SG		= 32,	     /* max s/g entries per request */
-	CARM_MAX_HOST_SG	= 600,		/* max s/g entries per host */
-	CARM_SG_LOW_WATER	= (CARM_MAX_HOST_SG / 4),   /* re-fill mark */
-
-	/* hardware registers */
-	CARM_IHQP		= 0x1c,
-	CARM_INT_STAT		= 0x10, /* interrupt status */
-	CARM_INT_MASK		= 0x14, /* interrupt mask */
-	CARM_HMUC		= 0x18, /* host message unit control */
-	RBUF_ADDR_LO		= 0x20, /* response msg DMA buf low 32 bits */
-	RBUF_ADDR_HI		= 0x24, /* response msg DMA buf high 32 bits */
-	RBUF_BYTE_SZ		= 0x28,
-	CARM_RESP_IDX		= 0x2c,
-	CARM_CMS0		= 0x30, /* command message size reg 0 */
-	CARM_LMUC		= 0x48,
-	CARM_HMPHA		= 0x6c,
-	CARM_INITC		= 0xb5,
-
-	/* bits in CARM_INT_{STAT,MASK} */
-	INT_RESERVED		= 0xfffffff0,
-	INT_WATCHDOG		= (1 << 3),	/* watchdog timer */
-	INT_Q_OVERFLOW		= (1 << 2),	/* cmd msg q overflow */
-	INT_Q_AVAILABLE		= (1 << 1),	/* cmd msg q has free space */
-	INT_RESPONSE		= (1 << 0),	/* response msg available */
-	INT_ACK_MASK		= INT_WATCHDOG | INT_Q_OVERFLOW,
-	INT_DEF_MASK		= INT_RESERVED | INT_Q_OVERFLOW |
-				  INT_RESPONSE,
-
-	/* command messages, and related register bits */
-	CARM_HAVE_RESP		= 0x01,
-	CARM_MSG_READ		= 1,
-	CARM_MSG_WRITE		= 2,
-	CARM_MSG_VERIFY		= 3,
-	CARM_MSG_GET_CAPACITY	= 4,
-	CARM_MSG_FLUSH		= 5,
-	CARM_MSG_IOCTL		= 6,
-	CARM_MSG_ARRAY		= 8,
-	CARM_MSG_MISC		= 9,
-	CARM_CME		= (1 << 2),
-	CARM_RME		= (1 << 1),
-	CARM_WZBC		= (1 << 0),
-	CARM_RMI		= (1 << 0),
-	CARM_Q_FULL		= (1 << 3),
-	CARM_MSG_SIZE		= 288,
-	CARM_Q_LEN		= 48,
-
-	/* CARM_MSG_IOCTL messages */
-	CARM_IOC_SCAN_CHAN	= 5,	/* scan channels for devices */
-	CARM_IOC_GET_TCQ	= 13,	/* get tcq/ncq depth */
-	CARM_IOC_SET_TCQ	= 14,	/* set tcq/ncq depth */
-
-	IOC_SCAN_CHAN_NODEV	= 0x1f,
-	IOC_SCAN_CHAN_OFFSET	= 0x40,
-
-	/* CARM_MSG_ARRAY messages */
-	CARM_ARRAY_INFO		= 0,
-
-	ARRAY_NO_EXIST		= (1 << 31),
-
-	/* response messages */
-	RMSG_SZ			= 8,	/* sizeof(struct carm_response) */
-	RMSG_Q_LEN		= 48,	/* resp. msg list length */
-	RMSG_OK			= 1,	/* bit indicating msg was successful */
-					/* length of entire resp. msg buffer */
-	RBUF_LEN		= RMSG_SZ * RMSG_Q_LEN,
-
-	PDC_SHM_SIZE		= (4096 << 7), /* length of entire h/w buffer */
-
-	/* CARM_MSG_MISC messages */
-	MISC_GET_FW_VER		= 2,
-	MISC_ALLOC_MEM		= 3,
-	MISC_SET_TIME		= 5,
-
-	/* MISC_GET_FW_VER feature bits */
-	FW_VER_4PORT		= (1 << 2), /* 1=4 ports, 0=8 ports */
-	FW_VER_NON_RAID		= (1 << 1), /* 1=non-RAID firmware, 0=RAID */
-	FW_VER_ZCR		= (1 << 0), /* zero channel RAID (whatever that is) */
-
-	/* carm_host flags */
-	FL_NON_RAID		= FW_VER_NON_RAID,
-	FL_4PORT		= FW_VER_4PORT,
-	FL_FW_VER_MASK		= (FW_VER_NON_RAID | FW_VER_4PORT),
-	FL_DAC			= (1 << 16),
-	FL_DYN_MAJOR		= (1 << 17),
-};
-
-enum {
-	CARM_SG_BOUNDARY	= 0xffffUL,	    /* s/g segment boundary */
-};
-
-enum scatter_gather_types {
-	SGT_32BIT		= 0,
-	SGT_64BIT		= 1,
-};
-
-enum host_states {
-	HST_INVALID,		/* invalid state; never used */
-	HST_ALLOC_BUF,		/* setting up master SHM area */
-	HST_ERROR,		/* we never leave here */
-	HST_PORT_SCAN,		/* start dev scan */
-	HST_DEV_SCAN_START,	/* start per-device probe */
-	HST_DEV_SCAN,		/* continue per-device probe */
-	HST_DEV_ACTIVATE,	/* activate devices we found */
-	HST_PROBE_FINISHED,	/* probe is complete */
-	HST_PROBE_START,	/* initiate probe */
-	HST_SYNC_TIME,		/* tell firmware what time it is */
-	HST_GET_FW_VER,		/* get firmware version, adapter port cnt */
-};
-
-#ifdef CARM_DEBUG
-static const char *state_name[] = {
-	"HST_INVALID",
-	"HST_ALLOC_BUF",
-	"HST_ERROR",
-	"HST_PORT_SCAN",
-	"HST_DEV_SCAN_START",
-	"HST_DEV_SCAN",
-	"HST_DEV_ACTIVATE",
-	"HST_PROBE_FINISHED",
-	"HST_PROBE_START",
-	"HST_SYNC_TIME",
-	"HST_GET_FW_VER",
-};
-#endif
-
-struct carm_port {
-	unsigned int			port_no;
-	struct gendisk			*disk;
-	struct carm_host		*host;
-
-	/* attached device characteristics */
-	u64				capacity;
-	char				name[41];
-	u16				dev_geom_head;
-	u16				dev_geom_sect;
-	u16				dev_geom_cyl;
-};
-
-struct carm_request {
-	unsigned int			tag;
-	int				n_elem;
-	unsigned int			msg_type;
-	unsigned int			msg_subtype;
-	unsigned int			msg_bucket;
-	struct request			*rq;
-	struct carm_port		*port;
-	struct scatterlist		sg[CARM_MAX_REQ_SG];
-};
-
-struct carm_host {
-	unsigned long			flags;
-	void				__iomem *mmio;
-	void				*shm;
-	dma_addr_t			shm_dma;
-
-	int				major;
-	int				id;
-	char				name[32];
-
-	spinlock_t			lock;
-	struct pci_dev			*pdev;
-	unsigned int			state;
-	u32				fw_ver;
-
-	struct request_queue		*oob_q;
-	unsigned int			n_oob;
-
-	unsigned int			hw_sg_used;
-
-	unsigned int			resp_idx;
-
-	unsigned int			wait_q_prod;
-	unsigned int			wait_q_cons;
-	struct request_queue		*wait_q[CARM_MAX_WAIT_Q];
-
-	unsigned int			n_msgs;
-	u64				msg_alloc;
-	struct carm_request		req[CARM_MAX_REQ];
-	void				*msg_base;
-	dma_addr_t			msg_dma;
-
-	int				cur_scan_dev;
-	unsigned long			dev_active;
-	unsigned long			dev_present;
-	struct carm_port		port[CARM_MAX_PORTS];
-
-	struct work_struct		fsm_task;
-
-	struct completion		probe_comp;
-};
-
-struct carm_response {
-	__le32 ret_handle;
-	__le32 status;
-}  __attribute__((packed));
-
-struct carm_msg_sg {
-	__le32 start;
-	__le32 len;
-}  __attribute__((packed));
-
-struct carm_msg_rw {
-	u8 type;
-	u8 id;
-	u8 sg_count;
-	u8 sg_type;
-	__le32 handle;
-	__le32 lba;
-	__le16 lba_count;
-	__le16 lba_high;
-	struct carm_msg_sg sg[32];
-}  __attribute__((packed));
-
-struct carm_msg_allocbuf {
-	u8 type;
-	u8 subtype;
-	u8 n_sg;
-	u8 sg_type;
-	__le32 handle;
-	__le32 addr;
-	__le32 len;
-	__le32 evt_pool;
-	__le32 n_evt;
-	__le32 rbuf_pool;
-	__le32 n_rbuf;
-	__le32 msg_pool;
-	__le32 n_msg;
-	struct carm_msg_sg sg[8];
-}  __attribute__((packed));
-
-struct carm_msg_ioctl {
-	u8 type;
-	u8 subtype;
-	u8 array_id;
-	u8 reserved1;
-	__le32 handle;
-	__le32 data_addr;
-	u32 reserved2;
-}  __attribute__((packed));
-
-struct carm_msg_sync_time {
-	u8 type;
-	u8 subtype;
-	u16 reserved1;
-	__le32 handle;
-	u32 reserved2;
-	__le32 timestamp;
-}  __attribute__((packed));
-
-struct carm_msg_get_fw_ver {
-	u8 type;
-	u8 subtype;
-	u16 reserved1;
-	__le32 handle;
-	__le32 data_addr;
-	u32 reserved2;
-}  __attribute__((packed));
-
-struct carm_fw_ver {
-	__le32 version;
-	u8 features;
-	u8 reserved1;
-	u16 reserved2;
-}  __attribute__((packed));
-
-struct carm_array_info {
-	__le32 size;
-
-	__le16 size_hi;
-	__le16 stripe_size;
-
-	__le32 mode;
-
-	__le16 stripe_blk_sz;
-	__le16 reserved1;
-
-	__le16 cyl;
-	__le16 head;
-
-	__le16 sect;
-	u8 array_id;
-	u8 reserved2;
-
-	char name[40];
-
-	__le32 array_status;
-
-	/* device list continues beyond this point? */
-}  __attribute__((packed));
-
-static int carm_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
-static void carm_remove_one (struct pci_dev *pdev);
-static int carm_bdev_getgeo(struct block_device *bdev, struct hd_geometry *geo);
-
-static const struct pci_device_id carm_pci_tbl[] = {
-	{ PCI_VENDOR_ID_PROMISE, 0x8000, PCI_ANY_ID, PCI_ANY_ID, 0, 0, },
-	{ PCI_VENDOR_ID_PROMISE, 0x8002, PCI_ANY_ID, PCI_ANY_ID, 0, 0, },
-	{ }	/* terminate list */
-};
-MODULE_DEVICE_TABLE(pci, carm_pci_tbl);
-
-static struct pci_driver carm_driver = {
-	.name		= DRV_NAME,
-	.id_table	= carm_pci_tbl,
-	.probe		= carm_init_one,
-	.remove		= carm_remove_one,
-};
-
-static const struct block_device_operations carm_bd_ops = {
-	.owner		= THIS_MODULE,
-	.getgeo		= carm_bdev_getgeo,
-};
-
-static unsigned int carm_host_id;
-static unsigned long carm_major_alloc;
-
-
-
-static int carm_bdev_getgeo(struct block_device *bdev, struct hd_geometry *geo)
-{
-	struct carm_port *port = bdev->bd_disk->private_data;
-
-	geo->heads = (u8) port->dev_geom_head;
-	geo->sectors = (u8) port->dev_geom_sect;
-	geo->cylinders = port->dev_geom_cyl;
-	return 0;
-}
-
-static const u32 msg_sizes[] = { 32, 64, 128, CARM_MSG_SIZE };
-
-static inline int carm_lookup_bucket(u32 msg_size)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(msg_sizes); i++)
-		if (msg_size <= msg_sizes[i])
-			return i;
-
-	return -ENOENT;
-}
-
-static void carm_init_buckets(void __iomem *mmio)
-{
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(msg_sizes); i++)
-		writel(msg_sizes[i], mmio + CARM_CMS0 + (4 * i));
-}
-
-static inline void *carm_ref_msg(struct carm_host *host,
-				 unsigned int msg_idx)
-{
-	return host->msg_base + (msg_idx * CARM_MSG_SIZE);
-}
-
-static inline dma_addr_t carm_ref_msg_dma(struct carm_host *host,
-					  unsigned int msg_idx)
-{
-	return host->msg_dma + (msg_idx * CARM_MSG_SIZE);
-}
-
-static int carm_send_msg(struct carm_host *host,
-			 struct carm_request *crq)
-{
-	void __iomem *mmio = host->mmio;
-	u32 msg = (u32) carm_ref_msg_dma(host, crq->tag);
-	u32 cm_bucket = crq->msg_bucket;
-	u32 tmp;
-	int rc = 0;
-
-	VPRINTK("ENTER\n");
-
-	tmp = readl(mmio + CARM_HMUC);
-	if (tmp & CARM_Q_FULL) {
-#if 0
-		tmp = readl(mmio + CARM_INT_MASK);
-		tmp |= INT_Q_AVAILABLE;
-		writel(tmp, mmio + CARM_INT_MASK);
-		readl(mmio + CARM_INT_MASK);	/* flush */
-#endif
-		DPRINTK("host msg queue full\n");
-		rc = -EBUSY;
-	} else {
-		writel(msg | (cm_bucket << 1), mmio + CARM_IHQP);
-		readl(mmio + CARM_IHQP);	/* flush */
-	}
-
-	return rc;
-}
-
-static struct carm_request *carm_get_request(struct carm_host *host)
-{
-	unsigned int i;
-
-	/* obey global hardware limit on S/G entries */
-	if (host->hw_sg_used >= (CARM_MAX_HOST_SG - CARM_MAX_REQ_SG))
-		return NULL;
-
-	for (i = 0; i < max_queue; i++)
-		if ((host->msg_alloc & (1ULL << i)) == 0) {
-			struct carm_request *crq = &host->req[i];
-			crq->port = NULL;
-			crq->n_elem = 0;
-
-			host->msg_alloc |= (1ULL << i);
-			host->n_msgs++;
-
-			assert(host->n_msgs <= CARM_MAX_REQ);
-			sg_init_table(crq->sg, CARM_MAX_REQ_SG);
-			return crq;
-		}
-
-	DPRINTK("no request available, returning NULL\n");
-	return NULL;
-}
-
-static int carm_put_request(struct carm_host *host, struct carm_request *crq)
-{
-	assert(crq->tag < max_queue);
-
-	if (unlikely((host->msg_alloc & (1ULL << crq->tag)) == 0))
-		return -EINVAL; /* tried to clear a tag that was not active */
-
-	assert(host->hw_sg_used >= crq->n_elem);
-
-	host->msg_alloc &= ~(1ULL << crq->tag);
-	host->hw_sg_used -= crq->n_elem;
-	host->n_msgs--;
-
-	return 0;
-}
-
-static struct carm_request *carm_get_special(struct carm_host *host)
-{
-	unsigned long flags;
-	struct carm_request *crq = NULL;
-	struct request *rq;
-	int tries = 5000;
-
-	while (tries-- > 0) {
-		spin_lock_irqsave(&host->lock, flags);
-		crq = carm_get_request(host);
-		spin_unlock_irqrestore(&host->lock, flags);
-
-		if (crq)
-			break;
-		msleep(10);
-	}
-
-	if (!crq)
-		return NULL;
-
-	rq = blk_get_request(host->oob_q, REQ_OP_DRV_OUT, GFP_KERNEL);
-	if (IS_ERR(rq)) {
-		spin_lock_irqsave(&host->lock, flags);
-		carm_put_request(host, crq);
-		spin_unlock_irqrestore(&host->lock, flags);
-		return NULL;
-	}
-
-	crq->rq = rq;
-	return crq;
-}
-
-static int carm_array_info (struct carm_host *host, unsigned int array_idx)
-{
-	struct carm_msg_ioctl *ioc;
-	unsigned int idx;
-	u32 msg_data;
-	dma_addr_t msg_dma;
-	struct carm_request *crq;
-	int rc;
-
-	crq = carm_get_special(host);
-	if (!crq) {
-		rc = -ENOMEM;
-		goto err_out;
-	}
-
-	idx = crq->tag;
-
-	ioc = carm_ref_msg(host, idx);
-	msg_dma = carm_ref_msg_dma(host, idx);
-	msg_data = (u32) (msg_dma + sizeof(struct carm_array_info));
-
-	crq->msg_type = CARM_MSG_ARRAY;
-	crq->msg_subtype = CARM_ARRAY_INFO;
-	rc = carm_lookup_bucket(sizeof(struct carm_msg_ioctl) +
-				sizeof(struct carm_array_info));
-	BUG_ON(rc < 0);
-	crq->msg_bucket = (u32) rc;
-
-	memset(ioc, 0, sizeof(*ioc));
-	ioc->type	= CARM_MSG_ARRAY;
-	ioc->subtype	= CARM_ARRAY_INFO;
-	ioc->array_id	= (u8) array_idx;
-	ioc->handle	= cpu_to_le32(TAG_ENCODE(idx));
-	ioc->data_addr	= cpu_to_le32(msg_data);
-
-	spin_lock_irq(&host->lock);
-	assert(host->state == HST_DEV_SCAN_START ||
-	       host->state == HST_DEV_SCAN);
-	spin_unlock_irq(&host->lock);
-
-	DPRINTK("blk_execute_rq_nowait, tag == %u\n", idx);
-	crq->rq->special = crq;
-	blk_execute_rq_nowait(host->oob_q, NULL, crq->rq, true, NULL);
-
-	return 0;
-
-err_out:
-	spin_lock_irq(&host->lock);
-	host->state = HST_ERROR;
-	spin_unlock_irq(&host->lock);
-	return rc;
-}
-
-typedef unsigned int (*carm_sspc_t)(struct carm_host *, unsigned int, void *);
-
-static int carm_send_special (struct carm_host *host, carm_sspc_t func)
-{
-	struct carm_request *crq;
-	struct carm_msg_ioctl *ioc;
-	void *mem;
-	unsigned int idx, msg_size;
-	int rc;
-
-	crq = carm_get_special(host);
-	if (!crq)
-		return -ENOMEM;
-
-	idx = crq->tag;
-
-	mem = carm_ref_msg(host, idx);
-
-	msg_size = func(host, idx, mem);
-
-	ioc = mem;
-	crq->msg_type = ioc->type;
-	crq->msg_subtype = ioc->subtype;
-	rc = carm_lookup_bucket(msg_size);
-	BUG_ON(rc < 0);
-	crq->msg_bucket = (u32) rc;
-
-	DPRINTK("blk_execute_rq_nowait, tag == %u\n", idx);
-	crq->rq->special = crq;
-	blk_execute_rq_nowait(host->oob_q, NULL, crq->rq, true, NULL);
-
-	return 0;
-}
-
-static unsigned int carm_fill_sync_time(struct carm_host *host,
-					unsigned int idx, void *mem)
-{
-	struct carm_msg_sync_time *st = mem;
-
-	time64_t tv = ktime_get_real_seconds();
-
-	memset(st, 0, sizeof(*st));
-	st->type	= CARM_MSG_MISC;
-	st->subtype	= MISC_SET_TIME;
-	st->handle	= cpu_to_le32(TAG_ENCODE(idx));
-	st->timestamp	= cpu_to_le32(tv);
-
-	return sizeof(struct carm_msg_sync_time);
-}
-
-static unsigned int carm_fill_alloc_buf(struct carm_host *host,
-					unsigned int idx, void *mem)
-{
-	struct carm_msg_allocbuf *ab = mem;
-
-	memset(ab, 0, sizeof(*ab));
-	ab->type	= CARM_MSG_MISC;
-	ab->subtype	= MISC_ALLOC_MEM;
-	ab->handle	= cpu_to_le32(TAG_ENCODE(idx));
-	ab->n_sg	= 1;
-	ab->sg_type	= SGT_32BIT;
-	ab->addr	= cpu_to_le32(host->shm_dma + (PDC_SHM_SIZE >> 1));
-	ab->len		= cpu_to_le32(PDC_SHM_SIZE >> 1);
-	ab->evt_pool	= cpu_to_le32(host->shm_dma + (16 * 1024));
-	ab->n_evt	= cpu_to_le32(1024);
-	ab->rbuf_pool	= cpu_to_le32(host->shm_dma);
-	ab->n_rbuf	= cpu_to_le32(RMSG_Q_LEN);
-	ab->msg_pool	= cpu_to_le32(host->shm_dma + RBUF_LEN);
-	ab->n_msg	= cpu_to_le32(CARM_Q_LEN);
-	ab->sg[0].start	= cpu_to_le32(host->shm_dma + (PDC_SHM_SIZE >> 1));
-	ab->sg[0].len	= cpu_to_le32(65536);
-
-	return sizeof(struct carm_msg_allocbuf);
-}
-
-static unsigned int carm_fill_scan_channels(struct carm_host *host,
-					    unsigned int idx, void *mem)
-{
-	struct carm_msg_ioctl *ioc = mem;
-	u32 msg_data = (u32) (carm_ref_msg_dma(host, idx) +
-			      IOC_SCAN_CHAN_OFFSET);
-
-	memset(ioc, 0, sizeof(*ioc));
-	ioc->type	= CARM_MSG_IOCTL;
-	ioc->subtype	= CARM_IOC_SCAN_CHAN;
-	ioc->handle	= cpu_to_le32(TAG_ENCODE(idx));
-	ioc->data_addr	= cpu_to_le32(msg_data);
-
-	/* fill output data area with "no device" default values */
-	mem += IOC_SCAN_CHAN_OFFSET;
-	memset(mem, IOC_SCAN_CHAN_NODEV, CARM_MAX_PORTS);
-
-	return IOC_SCAN_CHAN_OFFSET + CARM_MAX_PORTS;
-}
-
-static unsigned int carm_fill_get_fw_ver(struct carm_host *host,
-					 unsigned int idx, void *mem)
-{
-	struct carm_msg_get_fw_ver *ioc = mem;
-	u32 msg_data = (u32) (carm_ref_msg_dma(host, idx) + sizeof(*ioc));
-
-	memset(ioc, 0, sizeof(*ioc));
-	ioc->type	= CARM_MSG_MISC;
-	ioc->subtype	= MISC_GET_FW_VER;
-	ioc->handle	= cpu_to_le32(TAG_ENCODE(idx));
-	ioc->data_addr	= cpu_to_le32(msg_data);
-
-	return sizeof(struct carm_msg_get_fw_ver) +
-	       sizeof(struct carm_fw_ver);
-}
-
-static inline void carm_end_request_queued(struct carm_host *host,
-					   struct carm_request *crq,
-					   blk_status_t error)
-{
-	struct request *req = crq->rq;
-	int rc;
-
-	__blk_end_request_all(req, error);
-
-	rc = carm_put_request(host, crq);
-	assert(rc == 0);
-}
-
-static inline void carm_push_q (struct carm_host *host, struct request_queue *q)
-{
-	unsigned int idx = host->wait_q_prod % CARM_MAX_WAIT_Q;
-
-	blk_stop_queue(q);
-	VPRINTK("STOPPED QUEUE %p\n", q);
-
-	host->wait_q[idx] = q;
-	host->wait_q_prod++;
-	BUG_ON(host->wait_q_prod == host->wait_q_cons); /* overrun */
-}
-
-static inline struct request_queue *carm_pop_q(struct carm_host *host)
-{
-	unsigned int idx;
-
-	if (host->wait_q_prod == host->wait_q_cons)
-		return NULL;
-
-	idx = host->wait_q_cons % CARM_MAX_WAIT_Q;
-	host->wait_q_cons++;
-
-	return host->wait_q[idx];
-}
-
-static inline void carm_round_robin(struct carm_host *host)
-{
-	struct request_queue *q = carm_pop_q(host);
-	if (q) {
-		blk_start_queue(q);
-		VPRINTK("STARTED QUEUE %p\n", q);
-	}
-}
-
-static inline void carm_end_rq(struct carm_host *host, struct carm_request *crq,
-			       blk_status_t error)
-{
-	carm_end_request_queued(host, crq, error);
-	if (max_queue == 1)
-		carm_round_robin(host);
-	else if ((host->n_msgs <= CARM_MSG_LOW_WATER) &&
-		 (host->hw_sg_used <= CARM_SG_LOW_WATER)) {
-		carm_round_robin(host);
-	}
-}
-
-static void carm_oob_rq_fn(struct request_queue *q)
-{
-	struct carm_host *host = q->queuedata;
-	struct carm_request *crq;
-	struct request *rq;
-	int rc;
-
-	while (1) {
-		DPRINTK("get req\n");
-		rq = blk_fetch_request(q);
-		if (!rq)
-			break;
-
-		crq = rq->special;
-		assert(crq != NULL);
-		assert(crq->rq == rq);
-
-		crq->n_elem = 0;
-
-		DPRINTK("send req\n");
-		rc = carm_send_msg(host, crq);
-		if (rc) {
-			blk_requeue_request(q, rq);
-			carm_push_q(host, q);
-			return;		/* call us again later, eventually */
-		}
-	}
-}
-
-static void carm_rq_fn(struct request_queue *q)
-{
-	struct carm_port *port = q->queuedata;
-	struct carm_host *host = port->host;
-	struct carm_msg_rw *msg;
-	struct carm_request *crq;
-	struct request *rq;
-	struct scatterlist *sg;
-	int writing = 0, pci_dir, i, n_elem, rc;
-	u32 tmp;
-	unsigned int msg_size;
-
-queue_one_request:
-	VPRINTK("get req\n");
-	rq = blk_peek_request(q);
-	if (!rq)
-		return;
-
-	crq = carm_get_request(host);
-	if (!crq) {
-		carm_push_q(host, q);
-		return;		/* call us again later, eventually */
-	}
-	crq->rq = rq;
-
-	blk_start_request(rq);
-
-	if (rq_data_dir(rq) == WRITE) {
-		writing = 1;
-		pci_dir = PCI_DMA_TODEVICE;
-	} else {
-		pci_dir = PCI_DMA_FROMDEVICE;
-	}
-
-	/* get scatterlist from block layer */
-	sg = &crq->sg[0];
-	n_elem = blk_rq_map_sg(q, rq, sg);
-	if (n_elem <= 0) {
-		carm_end_rq(host, crq, BLK_STS_IOERR);
-		return;		/* request with no s/g entries? */
-	}
-
-	/* map scatterlist to PCI bus addresses */
-	n_elem = pci_map_sg(host->pdev, sg, n_elem, pci_dir);
-	if (n_elem <= 0) {
-		carm_end_rq(host, crq, BLK_STS_IOERR);
-		return;		/* request with no s/g entries? */
-	}
-	crq->n_elem = n_elem;
-	crq->port = port;
-	host->hw_sg_used += n_elem;
-
-	/*
-	 * build read/write message
-	 */
-
-	VPRINTK("build msg\n");
-	msg = (struct carm_msg_rw *) carm_ref_msg(host, crq->tag);
-
-	if (writing) {
-		msg->type = CARM_MSG_WRITE;
-		crq->msg_type = CARM_MSG_WRITE;
-	} else {
-		msg->type = CARM_MSG_READ;
-		crq->msg_type = CARM_MSG_READ;
-	}
-
-	msg->id		= port->port_no;
-	msg->sg_count	= n_elem;
-	msg->sg_type	= SGT_32BIT;
-	msg->handle	= cpu_to_le32(TAG_ENCODE(crq->tag));
-	msg->lba	= cpu_to_le32(blk_rq_pos(rq) & 0xffffffff);
-	tmp		= (blk_rq_pos(rq) >> 16) >> 16;
-	msg->lba_high	= cpu_to_le16( (u16) tmp );
-	msg->lba_count	= cpu_to_le16(blk_rq_sectors(rq));
-
-	msg_size = sizeof(struct carm_msg_rw) - sizeof(msg->sg);
-	for (i = 0; i < n_elem; i++) {
-		struct carm_msg_sg *carm_sg = &msg->sg[i];
-		carm_sg->start = cpu_to_le32(sg_dma_address(&crq->sg[i]));
-		carm_sg->len = cpu_to_le32(sg_dma_len(&crq->sg[i]));
-		msg_size += sizeof(struct carm_msg_sg);
-	}
-
-	rc = carm_lookup_bucket(msg_size);
-	BUG_ON(rc < 0);
-	crq->msg_bucket = (u32) rc;
-
-	/*
-	 * queue read/write message to hardware
-	 */
-
-	VPRINTK("send msg, tag == %u\n", crq->tag);
-	rc = carm_send_msg(host, crq);
-	if (rc) {
-		carm_put_request(host, crq);
-		blk_requeue_request(q, rq);
-		carm_push_q(host, q);
-		return;		/* call us again later, eventually */
-	}
-
-	goto queue_one_request;
-}
-
-static void carm_handle_array_info(struct carm_host *host,
-				   struct carm_request *crq, u8 *mem,
-				   blk_status_t error)
-{
-	struct carm_port *port;
-	u8 *msg_data = mem + sizeof(struct carm_array_info);
-	struct carm_array_info *desc = (struct carm_array_info *) msg_data;
-	u64 lo, hi;
-	int cur_port;
-	size_t slen;
-
-	DPRINTK("ENTER\n");
-
-	carm_end_rq(host, crq, error);
-
-	if (error)
-		goto out;
-	if (le32_to_cpu(desc->array_status) & ARRAY_NO_EXIST)
-		goto out;
-
-	cur_port = host->cur_scan_dev;
-
-	/* should never occur */
-	if ((cur_port < 0) || (cur_port >= CARM_MAX_PORTS)) {
-		printk(KERN_ERR PFX "BUG: cur_scan_dev==%d, array_id==%d\n",
-		       cur_port, (int) desc->array_id);
-		goto out;
-	}
-
-	port = &host->port[cur_port];
-
-	lo = (u64) le32_to_cpu(desc->size);
-	hi = (u64) le16_to_cpu(desc->size_hi);
-
-	port->capacity = lo | (hi << 32);
-	port->dev_geom_head = le16_to_cpu(desc->head);
-	port->dev_geom_sect = le16_to_cpu(desc->sect);
-	port->dev_geom_cyl = le16_to_cpu(desc->cyl);
-
-	host->dev_active |= (1 << cur_port);
-
-	strncpy(port->name, desc->name, sizeof(port->name));
-	port->name[sizeof(port->name) - 1] = 0;
-	slen = strlen(port->name);
-	while (slen && (port->name[slen - 1] == ' ')) {
-		port->name[slen - 1] = 0;
-		slen--;
-	}
-
-	printk(KERN_INFO DRV_NAME "(%s): port %u device %Lu sectors\n",
-	       pci_name(host->pdev), port->port_no,
-	       (unsigned long long) port->capacity);
-	printk(KERN_INFO DRV_NAME "(%s): port %u device \"%s\"\n",
-	       pci_name(host->pdev), port->port_no, port->name);
-
-out:
-	assert(host->state == HST_DEV_SCAN);
-	schedule_work(&host->fsm_task);
-}
-
-static void carm_handle_scan_chan(struct carm_host *host,
-				  struct carm_request *crq, u8 *mem,
-				  blk_status_t error)
-{
-	u8 *msg_data = mem + IOC_SCAN_CHAN_OFFSET;
-	unsigned int i, dev_count = 0;
-	int new_state = HST_DEV_SCAN_START;
-
-	DPRINTK("ENTER\n");
-
-	carm_end_rq(host, crq, error);
-
-	if (error) {
-		new_state = HST_ERROR;
-		goto out;
-	}
-
-	/* TODO: scan and support non-disk devices */
-	for (i = 0; i < 8; i++)
-		if (msg_data[i] == 0) { /* direct-access device (disk) */
-			host->dev_present |= (1 << i);
-			dev_count++;
-		}
-
-	printk(KERN_INFO DRV_NAME "(%s): found %u interesting devices\n",
-	       pci_name(host->pdev), dev_count);
-
-out:
-	assert(host->state == HST_PORT_SCAN);
-	host->state = new_state;
-	schedule_work(&host->fsm_task);
-}
-
-static void carm_handle_generic(struct carm_host *host,
-				struct carm_request *crq, blk_status_t error,
-				int cur_state, int next_state)
-{
-	DPRINTK("ENTER\n");
-
-	carm_end_rq(host, crq, error);
-
-	assert(host->state == cur_state);
-	if (error)
-		host->state = HST_ERROR;
-	else
-		host->state = next_state;
-	schedule_work(&host->fsm_task);
-}
-
-static inline void carm_handle_rw(struct carm_host *host,
-				  struct carm_request *crq, blk_status_t error)
-{
-	int pci_dir;
-
-	VPRINTK("ENTER\n");
-
-	if (rq_data_dir(crq->rq) == WRITE)
-		pci_dir = PCI_DMA_TODEVICE;
-	else
-		pci_dir = PCI_DMA_FROMDEVICE;
-
-	pci_unmap_sg(host->pdev, &crq->sg[0], crq->n_elem, pci_dir);
-
-	carm_end_rq(host, crq, error);
-}
-
-static inline void carm_handle_resp(struct carm_host *host,
-				    __le32 ret_handle_le, u32 status)
-{
-	u32 handle = le32_to_cpu(ret_handle_le);
-	unsigned int msg_idx;
-	struct carm_request *crq;
-	blk_status_t error = (status == RMSG_OK) ? 0 : BLK_STS_IOERR;
-	u8 *mem;
-
-	VPRINTK("ENTER, handle == 0x%x\n", handle);
-
-	if (unlikely(!TAG_VALID(handle))) {
-		printk(KERN_ERR DRV_NAME "(%s): BUG: invalid tag 0x%x\n",
-		       pci_name(host->pdev), handle);
-		return;
-	}
-
-	msg_idx = TAG_DECODE(handle);
-	VPRINTK("tag == %u\n", msg_idx);
-
-	crq = &host->req[msg_idx];
-
-	/* fast path */
-	if (likely(crq->msg_type == CARM_MSG_READ ||
-		   crq->msg_type == CARM_MSG_WRITE)) {
-		carm_handle_rw(host, crq, error);
-		return;
-	}
-
-	mem = carm_ref_msg(host, msg_idx);
-
-	switch (crq->msg_type) {
-	case CARM_MSG_IOCTL: {
-		switch (crq->msg_subtype) {
-		case CARM_IOC_SCAN_CHAN:
-			carm_handle_scan_chan(host, crq, mem, error);
-			break;
-		default:
-			/* unknown / invalid response */
-			goto err_out;
-		}
-		break;
-	}
-
-	case CARM_MSG_MISC: {
-		switch (crq->msg_subtype) {
-		case MISC_ALLOC_MEM:
-			carm_handle_generic(host, crq, error,
-					    HST_ALLOC_BUF, HST_SYNC_TIME);
-			break;
-		case MISC_SET_TIME:
-			carm_handle_generic(host, crq, error,
-					    HST_SYNC_TIME, HST_GET_FW_VER);
-			break;
-		case MISC_GET_FW_VER: {
-			struct carm_fw_ver *ver = (struct carm_fw_ver *)
-				(mem + sizeof(struct carm_msg_get_fw_ver));
-			if (!error) {
-				host->fw_ver = le32_to_cpu(ver->version);
-				host->flags |= (ver->features & FL_FW_VER_MASK);
-			}
-			carm_handle_generic(host, crq, error,
-					    HST_GET_FW_VER, HST_PORT_SCAN);
-			break;
-		}
-		default:
-			/* unknown / invalid response */
-			goto err_out;
-		}
-		break;
-	}
-
-	case CARM_MSG_ARRAY: {
-		switch (crq->msg_subtype) {
-		case CARM_ARRAY_INFO:
-			carm_handle_array_info(host, crq, mem, error);
-			break;
-		default:
-			/* unknown / invalid response */
-			goto err_out;
-		}
-		break;
-	}
-
-	default:
-		/* unknown / invalid response */
-		goto err_out;
-	}
-
-	return;
-
-err_out:
-	printk(KERN_WARNING DRV_NAME "(%s): BUG: unhandled message type %d/%d\n",
-	       pci_name(host->pdev), crq->msg_type, crq->msg_subtype);
-	carm_end_rq(host, crq, BLK_STS_IOERR);
-}
-
-static inline void carm_handle_responses(struct carm_host *host)
-{
-	void __iomem *mmio = host->mmio;
-	struct carm_response *resp = (struct carm_response *) host->shm;
-	unsigned int work = 0;
-	unsigned int idx = host->resp_idx % RMSG_Q_LEN;
-
-	while (1) {
-		u32 status = le32_to_cpu(resp[idx].status);
-
-		if (status == 0xffffffff) {
-			VPRINTK("ending response on index %u\n", idx);
-			writel(idx << 3, mmio + CARM_RESP_IDX);
-			break;
-		}
-
-		/* response to a message we sent */
-		else if ((status & (1 << 31)) == 0) {
-			VPRINTK("handling msg response on index %u\n", idx);
-			carm_handle_resp(host, resp[idx].ret_handle, status);
-			resp[idx].status = cpu_to_le32(0xffffffff);
-		}
-
-		/* asynchronous events the hardware throws our way */
-		else if ((status & 0xff000000) == (1 << 31)) {
-			u8 *evt_type_ptr = (u8 *) &resp[idx];
-			u8 evt_type = *evt_type_ptr;
-			printk(KERN_WARNING DRV_NAME "(%s): unhandled event type %d\n",
-			       pci_name(host->pdev), (int) evt_type);
-			resp[idx].status = cpu_to_le32(0xffffffff);
-		}
-
-		idx = NEXT_RESP(idx);
-		work++;
-	}
-
-	VPRINTK("EXIT, work==%u\n", work);
-	host->resp_idx += work;
-}
-
-static irqreturn_t carm_interrupt(int irq, void *__host)
-{
-	struct carm_host *host = __host;
-	void __iomem *mmio;
-	u32 mask;
-	int handled = 0;
-	unsigned long flags;
-
-	if (!host) {
-		VPRINTK("no host\n");
-		return IRQ_NONE;
-	}
-
-	spin_lock_irqsave(&host->lock, flags);
-
-	mmio = host->mmio;
-
-	/* reading should also clear interrupts */
-	mask = readl(mmio + CARM_INT_STAT);
-
-	if (mask == 0 || mask == 0xffffffff) {
-		VPRINTK("no work, mask == 0x%x\n", mask);
-		goto out;
-	}
-
-	if (mask & INT_ACK_MASK)
-		writel(mask, mmio + CARM_INT_STAT);
-
-	if (unlikely(host->state == HST_INVALID)) {
-		VPRINTK("not initialized yet, mask = 0x%x\n", mask);
-		goto out;
-	}
-
-	if (mask & CARM_HAVE_RESP) {
-		handled = 1;
-		carm_handle_responses(host);
-	}
-
-out:
-	spin_unlock_irqrestore(&host->lock, flags);
-	VPRINTK("EXIT\n");
-	return IRQ_RETVAL(handled);
-}
-
-static void carm_fsm_task (struct work_struct *work)
-{
-	struct carm_host *host =
-		container_of(work, struct carm_host, fsm_task);
-	unsigned long flags;
-	unsigned int state;
-	int rc, i, next_dev;
-	int reschedule = 0;
-	int new_state = HST_INVALID;
-
-	spin_lock_irqsave(&host->lock, flags);
-	state = host->state;
-	spin_unlock_irqrestore(&host->lock, flags);
-
-	DPRINTK("ENTER, state == %s\n", state_name[state]);
-
-	switch (state) {
-	case HST_PROBE_START:
-		new_state = HST_ALLOC_BUF;
-		reschedule = 1;
-		break;
-
-	case HST_ALLOC_BUF:
-		rc = carm_send_special(host, carm_fill_alloc_buf);
-		if (rc) {
-			new_state = HST_ERROR;
-			reschedule = 1;
-		}
-		break;
-
-	case HST_SYNC_TIME:
-		rc = carm_send_special(host, carm_fill_sync_time);
-		if (rc) {
-			new_state = HST_ERROR;
-			reschedule = 1;
-		}
-		break;
-
-	case HST_GET_FW_VER:
-		rc = carm_send_special(host, carm_fill_get_fw_ver);
-		if (rc) {
-			new_state = HST_ERROR;
-			reschedule = 1;
-		}
-		break;
-
-	case HST_PORT_SCAN:
-		rc = carm_send_special(host, carm_fill_scan_channels);
-		if (rc) {
-			new_state = HST_ERROR;
-			reschedule = 1;
-		}
-		break;
-
-	case HST_DEV_SCAN_START:
-		host->cur_scan_dev = -1;
-		new_state = HST_DEV_SCAN;
-		reschedule = 1;
-		break;
-
-	case HST_DEV_SCAN:
-		next_dev = -1;
-		for (i = host->cur_scan_dev + 1; i < CARM_MAX_PORTS; i++)
-			if (host->dev_present & (1 << i)) {
-				next_dev = i;
-				break;
-			}
-
-		if (next_dev >= 0) {
-			host->cur_scan_dev = next_dev;
-			rc = carm_array_info(host, next_dev);
-			if (rc) {
-				new_state = HST_ERROR;
-				reschedule = 1;
-			}
-		} else {
-			new_state = HST_DEV_ACTIVATE;
-			reschedule = 1;
-		}
-		break;
-
-	case HST_DEV_ACTIVATE: {
-		int activated = 0;
-		for (i = 0; i < CARM_MAX_PORTS; i++)
-			if (host->dev_active & (1 << i)) {
-				struct carm_port *port = &host->port[i];
-				struct gendisk *disk = port->disk;
-
-				set_capacity(disk, port->capacity);
-				add_disk(disk);
-				activated++;
-			}
-
-		printk(KERN_INFO DRV_NAME "(%s): %d ports activated\n",
-		       pci_name(host->pdev), activated);
-
-		new_state = HST_PROBE_FINISHED;
-		reschedule = 1;
-		break;
-	}
-
-	case HST_PROBE_FINISHED:
-		complete(&host->probe_comp);
-		break;
-
-	case HST_ERROR:
-		/* FIXME: TODO */
-		break;
-
-	default:
-		/* should never occur */
-		printk(KERN_ERR PFX "BUG: unknown state %d\n", state);
-		assert(0);
-		break;
-	}
-
-	if (new_state != HST_INVALID) {
-		spin_lock_irqsave(&host->lock, flags);
-		host->state = new_state;
-		spin_unlock_irqrestore(&host->lock, flags);
-	}
-	if (reschedule)
-		schedule_work(&host->fsm_task);
-}
-
-static int carm_init_wait(void __iomem *mmio, u32 bits, unsigned int test_bit)
-{
-	unsigned int i;
-
-	for (i = 0; i < 50000; i++) {
-		u32 tmp = readl(mmio + CARM_LMUC);
-		udelay(100);
-
-		if (test_bit) {
-			if ((tmp & bits) == bits)
-				return 0;
-		} else {
-			if ((tmp & bits) == 0)
-				return 0;
-		}
-
-		cond_resched();
-	}
-
-	printk(KERN_ERR PFX "carm_init_wait timeout, bits == 0x%x, test_bit == %s\n",
-	       bits, test_bit ? "yes" : "no");
-	return -EBUSY;
-}
-
-static void carm_init_responses(struct carm_host *host)
-{
-	void __iomem *mmio = host->mmio;
-	unsigned int i;
-	struct carm_response *resp = (struct carm_response *) host->shm;
-
-	for (i = 0; i < RMSG_Q_LEN; i++)
-		resp[i].status = cpu_to_le32(0xffffffff);
-
-	writel(0, mmio + CARM_RESP_IDX);
-}
-
-static int carm_init_host(struct carm_host *host)
-{
-	void __iomem *mmio = host->mmio;
-	u32 tmp;
-	u8 tmp8;
-	int rc;
-
-	DPRINTK("ENTER\n");
-
-	writel(0, mmio + CARM_INT_MASK);
-
-	tmp8 = readb(mmio + CARM_INITC);
-	if (tmp8 & 0x01) {
-		tmp8 &= ~0x01;
-		writeb(tmp8, mmio + CARM_INITC);
-		readb(mmio + CARM_INITC);	/* flush */
-
-		DPRINTK("snooze...\n");
-		msleep(5000);
-	}
-
-	tmp = readl(mmio + CARM_HMUC);
-	if (tmp & CARM_CME) {
-		DPRINTK("CME bit present, waiting\n");
-		rc = carm_init_wait(mmio, CARM_CME, 1);
-		if (rc) {
-			DPRINTK("EXIT, carm_init_wait 1 failed\n");
-			return rc;
-		}
-	}
-	if (tmp & CARM_RME) {
-		DPRINTK("RME bit present, waiting\n");
-		rc = carm_init_wait(mmio, CARM_RME, 1);
-		if (rc) {
-			DPRINTK("EXIT, carm_init_wait 2 failed\n");
-			return rc;
-		}
-	}
-
-	tmp &= ~(CARM_RME | CARM_CME);
-	writel(tmp, mmio + CARM_HMUC);
-	readl(mmio + CARM_HMUC);	/* flush */
-
-	rc = carm_init_wait(mmio, CARM_RME | CARM_CME, 0);
-	if (rc) {
-		DPRINTK("EXIT, carm_init_wait 3 failed\n");
-		return rc;
-	}
-
-	carm_init_buckets(mmio);
-
-	writel(host->shm_dma & 0xffffffff, mmio + RBUF_ADDR_LO);
-	writel((host->shm_dma >> 16) >> 16, mmio + RBUF_ADDR_HI);
-	writel(RBUF_LEN, mmio + RBUF_BYTE_SZ);
-
-	tmp = readl(mmio + CARM_HMUC);
-	tmp |= (CARM_RME | CARM_CME | CARM_WZBC);
-	writel(tmp, mmio + CARM_HMUC);
-	readl(mmio + CARM_HMUC);	/* flush */
-
-	rc = carm_init_wait(mmio, CARM_RME | CARM_CME, 1);
-	if (rc) {
-		DPRINTK("EXIT, carm_init_wait 4 failed\n");
-		return rc;
-	}
-
-	writel(0, mmio + CARM_HMPHA);
-	writel(INT_DEF_MASK, mmio + CARM_INT_MASK);
-
-	carm_init_responses(host);
-
-	/* start initialization, probing state machine */
-	spin_lock_irq(&host->lock);
-	assert(host->state == HST_INVALID);
-	host->state = HST_PROBE_START;
-	spin_unlock_irq(&host->lock);
-	schedule_work(&host->fsm_task);
-
-	DPRINTK("EXIT\n");
-	return 0;
-}
-
-static int carm_init_disks(struct carm_host *host)
-{
-	unsigned int i;
-	int rc = 0;
-
-	for (i = 0; i < CARM_MAX_PORTS; i++) {
-		struct gendisk *disk;
-		struct request_queue *q;
-		struct carm_port *port;
-
-		port = &host->port[i];
-		port->host = host;
-		port->port_no = i;
-
-		disk = alloc_disk(CARM_MINORS_PER_MAJOR);
-		if (!disk) {
-			rc = -ENOMEM;
-			break;
-		}
-
-		port->disk = disk;
-		sprintf(disk->disk_name, DRV_NAME "/%u",
-			(unsigned int) (host->id * CARM_MAX_PORTS) + i);
-		disk->major = host->major;
-		disk->first_minor = i * CARM_MINORS_PER_MAJOR;
-		disk->fops = &carm_bd_ops;
-		disk->private_data = port;
-
-		q = blk_init_queue(carm_rq_fn, &host->lock);
-		if (!q) {
-			rc = -ENOMEM;
-			break;
-		}
-		disk->queue = q;
-		blk_queue_max_segments(q, CARM_MAX_REQ_SG);
-		blk_queue_segment_boundary(q, CARM_SG_BOUNDARY);
-
-		q->queuedata = port;
-	}
-
-	return rc;
-}
-
-static void carm_free_disks(struct carm_host *host)
-{
-	unsigned int i;
-
-	for (i = 0; i < CARM_MAX_PORTS; i++) {
-		struct gendisk *disk = host->port[i].disk;
-		if (disk) {
-			struct request_queue *q = disk->queue;
-
-			if (disk->flags & GENHD_FL_UP)
-				del_gendisk(disk);
-			if (q)
-				blk_cleanup_queue(q);
-			put_disk(disk);
-		}
-	}
-}
-
-static int carm_init_shm(struct carm_host *host)
-{
-	host->shm = pci_alloc_consistent(host->pdev, CARM_SHM_SIZE,
-					 &host->shm_dma);
-	if (!host->shm)
-		return -ENOMEM;
-
-	host->msg_base = host->shm + RBUF_LEN;
-	host->msg_dma = host->shm_dma + RBUF_LEN;
-
-	memset(host->shm, 0xff, RBUF_LEN);
-	memset(host->msg_base, 0, PDC_SHM_SIZE - RBUF_LEN);
-
-	return 0;
-}
-
-static int carm_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
-{
-	struct carm_host *host;
-	unsigned int pci_dac;
-	int rc;
-	struct request_queue *q;
-	unsigned int i;
-
-	printk_once(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
-
-	rc = pci_enable_device(pdev);
-	if (rc)
-		return rc;
-
-	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc)
-		goto err_out;
-
-#ifdef IF_64BIT_DMA_IS_POSSIBLE /* grrrr... */
-	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
-	if (!rc) {
-		rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
-		if (rc) {
-			printk(KERN_ERR DRV_NAME "(%s): consistent DMA mask failure\n",
-				pci_name(pdev));
-			goto err_out_regions;
-		}
-		pci_dac = 1;
-	} else {
-#endif
-		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
-		if (rc) {
-			printk(KERN_ERR DRV_NAME "(%s): DMA mask failure\n",
-				pci_name(pdev));
-			goto err_out_regions;
-		}
-		pci_dac = 0;
-#ifdef IF_64BIT_DMA_IS_POSSIBLE /* grrrr... */
-	}
-#endif
-
-	host = kzalloc(sizeof(*host), GFP_KERNEL);
-	if (!host) {
-		printk(KERN_ERR DRV_NAME "(%s): memory alloc failure\n",
-		       pci_name(pdev));
-		rc = -ENOMEM;
-		goto err_out_regions;
-	}
-
-	host->pdev = pdev;
-	host->flags = pci_dac ? FL_DAC : 0;
-	spin_lock_init(&host->lock);
-	INIT_WORK(&host->fsm_task, carm_fsm_task);
-	init_completion(&host->probe_comp);
-
-	for (i = 0; i < ARRAY_SIZE(host->req); i++)
-		host->req[i].tag = i;
-
-	host->mmio = ioremap(pci_resource_start(pdev, 0),
-			     pci_resource_len(pdev, 0));
-	if (!host->mmio) {
-		printk(KERN_ERR DRV_NAME "(%s): MMIO alloc failure\n",
-		       pci_name(pdev));
-		rc = -ENOMEM;
-		goto err_out_kfree;
-	}
-
-	rc = carm_init_shm(host);
-	if (rc) {
-		printk(KERN_ERR DRV_NAME "(%s): DMA SHM alloc failure\n",
-		       pci_name(pdev));
-		goto err_out_iounmap;
-	}
-
-	q = blk_init_queue(carm_oob_rq_fn, &host->lock);
-	if (!q) {
-		printk(KERN_ERR DRV_NAME "(%s): OOB queue alloc failure\n",
-		       pci_name(pdev));
-		rc = -ENOMEM;
-		goto err_out_pci_free;
-	}
-	host->oob_q = q;
-	q->queuedata = host;
-
-	/*
-	 * Figure out which major to use: 160, 161, or dynamic
-	 */
-	if (!test_and_set_bit(0, &carm_major_alloc))
-		host->major = 160;
-	else if (!test_and_set_bit(1, &carm_major_alloc))
-		host->major = 161;
-	else
-		host->flags |= FL_DYN_MAJOR;
-
-	host->id = carm_host_id;
-	sprintf(host->name, DRV_NAME "%d", carm_host_id);
-
-	rc = register_blkdev(host->major, host->name);
-	if (rc < 0)
-		goto err_out_free_majors;
-	if (host->flags & FL_DYN_MAJOR)
-		host->major = rc;
-
-	rc = carm_init_disks(host);
-	if (rc)
-		goto err_out_blkdev_disks;
-
-	pci_set_master(pdev);
-
-	rc = request_irq(pdev->irq, carm_interrupt, IRQF_SHARED, DRV_NAME, host);
-	if (rc) {
-		printk(KERN_ERR DRV_NAME "(%s): irq alloc failure\n",
-		       pci_name(pdev));
-		goto err_out_blkdev_disks;
-	}
-
-	rc = carm_init_host(host);
-	if (rc)
-		goto err_out_free_irq;
-
-	DPRINTK("waiting for probe_comp\n");
-	wait_for_completion(&host->probe_comp);
-
-	printk(KERN_INFO "%s: pci %s, ports %d, io %llx, irq %u, major %d\n",
-	       host->name, pci_name(pdev), (int) CARM_MAX_PORTS,
-	       (unsigned long long)pci_resource_start(pdev, 0),
-		   pdev->irq, host->major);
-
-	carm_host_id++;
-	pci_set_drvdata(pdev, host);
-	return 0;
-
-err_out_free_irq:
-	free_irq(pdev->irq, host);
-err_out_blkdev_disks:
-	carm_free_disks(host);
-	unregister_blkdev(host->major, host->name);
-err_out_free_majors:
-	if (host->major == 160)
-		clear_bit(0, &carm_major_alloc);
-	else if (host->major == 161)
-		clear_bit(1, &carm_major_alloc);
-	blk_cleanup_queue(host->oob_q);
-err_out_pci_free:
-	pci_free_consistent(pdev, CARM_SHM_SIZE, host->shm, host->shm_dma);
-err_out_iounmap:
-	iounmap(host->mmio);
-err_out_kfree:
-	kfree(host);
-err_out_regions:
-	pci_release_regions(pdev);
-err_out:
-	pci_disable_device(pdev);
-	return rc;
-}
-
-static void carm_remove_one (struct pci_dev *pdev)
-{
-	struct carm_host *host = pci_get_drvdata(pdev);
-
-	if (!host) {
-		printk(KERN_ERR PFX "BUG: no host data for PCI(%s)\n",
-		       pci_name(pdev));
-		return;
-	}
-
-	free_irq(pdev->irq, host);
-	carm_free_disks(host);
-	unregister_blkdev(host->major, host->name);
-	if (host->major == 160)
-		clear_bit(0, &carm_major_alloc);
-	else if (host->major == 161)
-		clear_bit(1, &carm_major_alloc);
-	blk_cleanup_queue(host->oob_q);
-	pci_free_consistent(pdev, CARM_SHM_SIZE, host->shm, host->shm_dma);
-	iounmap(host->mmio);
-	kfree(host);
-	pci_release_regions(pdev);
-	pci_disable_device(pdev);
-}
-
-module_pci_driver(carm_driver);
diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 498d9886ed9b..bb39b04d67d7 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3678,6 +3678,7 @@ static int __init d40_probe(struct platform_device *pdev)
 		regulator_disable(base->lcpa_regulator);
 		regulator_put(base->lcpa_regulator);
 	}
+	pm_runtime_disable(base->dev);
 
 	kfree(base->lcla_pool.alloc_map);
 	kfree(base->lookup_log_chans);
diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 64faa70a9dd9..879638e6bea4 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -1268,14 +1268,14 @@ static struct drm_dp_mst_branch *get_mst_branch_device_by_guid_helper(
 	struct drm_dp_mst_branch *found_mstb;
 	struct drm_dp_mst_port *port;
 
+	if (!mstb)
+		return NULL;
+
 	if (memcmp(mstb->guid, guid, 16) == 0)
 		return mstb;
 
 
 	list_for_each_entry(port, &mstb->ports, next) {
-		if (!port->mstb)
-			continue;
-
 		found_mstb = get_mst_branch_device_by_guid_helper(port->mstb, guid);
 
 		if (found_mstb)
diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
index 647b5ff69a9c..d5be02267060 100644
--- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
@@ -63,7 +63,7 @@ static int i2c_demux_activate_master(struct i2c_demux_pinctrl_priv *priv, u32 ne
 	if (ret)
 		goto err;
 
-	adap = of_find_i2c_adapter_by_node(priv->chan[new_chan].parent_np);
+	adap = of_get_i2c_adapter_by_node(priv->chan[new_chan].parent_np);
 	if (!adap) {
 		ret = -ENODEV;
 		goto err_with_revert;
diff --git a/drivers/i2c/muxes/i2c-mux-gpmux.c b/drivers/i2c/muxes/i2c-mux-gpmux.c
index 5053f1675a29..04133c973c15 100644
--- a/drivers/i2c/muxes/i2c-mux-gpmux.c
+++ b/drivers/i2c/muxes/i2c-mux-gpmux.c
@@ -55,7 +55,7 @@ static struct i2c_adapter *mux_parent_adapter(struct device *dev)
 		dev_err(dev, "Cannot parse i2c-parent\n");
 		return ERR_PTR(-ENODEV);
 	}
-	parent = of_find_i2c_adapter_by_node(parent_np);
+	parent = of_get_i2c_adapter_by_node(parent_np);
 	of_node_put(parent_np);
 	if (!parent)
 		return ERR_PTR(-EPROBE_DEFER);
diff --git a/drivers/i2c/muxes/i2c-mux-pinctrl.c b/drivers/i2c/muxes/i2c-mux-pinctrl.c
index cc6818aabab5..821e5cd49757 100644
--- a/drivers/i2c/muxes/i2c-mux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-mux-pinctrl.c
@@ -73,7 +73,7 @@ static struct i2c_adapter *i2c_mux_pinctrl_parent_adapter(struct device *dev)
 		dev_err(dev, "Cannot parse i2c-parent\n");
 		return ERR_PTR(-ENODEV);
 	}
-	parent = of_find_i2c_adapter_by_node(parent_np);
+	parent = of_get_i2c_adapter_by_node(parent_np);
 	of_node_put(parent_np);
 	if (!parent)
 		return ERR_PTR(-EPROBE_DEFER);
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 0714d572e49a..ec4ae34b3914 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1735,6 +1735,7 @@ static int synaptics_create_intertouch(struct psmouse *psmouse,
 		psmouse_matches_pnp_id(psmouse, topbuttonpad_pnp_ids) &&
 		!SYN_CAP_EXT_BUTTONS_STICK(info->ext_cap_10);
 	const struct rmi_device_platform_data pdata = {
+		.reset_delay_ms = 30,
 		.sensor_pdata = {
 			.sensor_type = rmi_sensor_touchpad,
 			.axis_align.flip_y = true,
diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
index b6ccf39c6a7b..e5b0109a4d15 100644
--- a/drivers/input/rmi4/rmi_smbus.c
+++ b/drivers/input/rmi4/rmi_smbus.c
@@ -238,12 +238,29 @@ static void rmi_smb_clear_state(struct rmi_smb_xport *rmi_smb)
 
 static int rmi_smb_enable_smbus_mode(struct rmi_smb_xport *rmi_smb)
 {
-	int retval;
+	struct i2c_client *client = rmi_smb->client;
+	int smbus_version;
+
+	/*
+	 * psmouse driver resets the controller, we only need to wait
+	 * to give the firmware chance to fully reinitialize.
+	 */
+	if (rmi_smb->xport.pdata.reset_delay_ms)
+		msleep(rmi_smb->xport.pdata.reset_delay_ms);
 
 	/* we need to get the smbus version to activate the touchpad */
-	retval = rmi_smb_get_version(rmi_smb);
-	if (retval < 0)
-		return retval;
+	smbus_version = rmi_smb_get_version(rmi_smb);
+	if (smbus_version < 0)
+		return smbus_version;
+
+	rmi_dbg(RMI_DEBUG_XPORT, &client->dev, "Smbus version is %d",
+		smbus_version);
+
+	if (smbus_version != 2 && smbus_version != 3) {
+		dev_err(&client->dev, "Unrecognized SMB version %d\n",
+				smbus_version);
+		return -ENODEV;
+	}
 
 	return 0;
 }
@@ -256,11 +273,10 @@ static int rmi_smb_reset(struct rmi_transport_dev *xport, u16 reset_addr)
 	rmi_smb_clear_state(rmi_smb);
 
 	/*
-	 * we do not call the actual reset command, it has to be handled in
-	 * PS/2 or there will be races between PS/2 and SMBus.
-	 * PS/2 should ensure that a psmouse_reset is called before
-	 * intializing the device and after it has been removed to be in a known
-	 * state.
+	 * We do not call the actual reset command, it has to be handled in
+	 * PS/2 or there will be races between PS/2 and SMBus. PS/2 should
+	 * ensure that a psmouse_reset is called before initializing the
+	 * device and after it has been removed to be in a known state.
 	 */
 	return rmi_smb_enable_smbus_mode(rmi_smb);
 }
@@ -276,7 +292,6 @@ static int rmi_smb_probe(struct i2c_client *client,
 {
 	struct rmi_device_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct rmi_smb_xport *rmi_smb;
-	int smbus_version;
 	int error;
 
 	if (!pdata) {
@@ -315,18 +330,9 @@ static int rmi_smb_probe(struct i2c_client *client,
 	rmi_smb->xport.proto_name = "smb";
 	rmi_smb->xport.ops = &rmi_smb_ops;
 
-	smbus_version = rmi_smb_get_version(rmi_smb);
-	if (smbus_version < 0)
-		return smbus_version;
-
-	rmi_dbg(RMI_DEBUG_XPORT, &client->dev, "Smbus version is %d",
-		smbus_version);
-
-	if (smbus_version != 2 && smbus_version != 3) {
-		dev_err(&client->dev, "Unrecognized SMB version %d\n",
-				smbus_version);
-		return -ENODEV;
-	}
+	error = rmi_smb_enable_smbus_mode(rmi_smb);
+	if (error)
+		return error;
 
 	i2c_set_clientdata(client, rmi_smb);
 
diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 45363ff8d06f..1b55199ea1b4 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -127,6 +127,7 @@ struct irq_domain_ops irq_exti_domain_ops = {
 	.xlate	= irq_domain_xlate_onetwocell,
 	.alloc  = stm32_exti_alloc,
 	.free	= stm32_exti_free,
+	.xlate	= irq_domain_xlate_twocell,
 };
 
 static int __init stm32_exti_init(struct device_node *node,
diff --git a/drivers/mcb/mcb-lpc.c b/drivers/mcb/mcb-lpc.c
index 945091a88354..7d292acbba53 100644
--- a/drivers/mcb/mcb-lpc.c
+++ b/drivers/mcb/mcb-lpc.c
@@ -26,7 +26,7 @@ static int mcb_lpc_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct priv *priv;
-	int ret = 0;
+	int ret = 0, table_size;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -61,16 +61,43 @@ static int mcb_lpc_probe(struct platform_device *pdev)
 
 	ret = chameleon_parse_cells(priv->bus, priv->mem->start, priv->base);
 	if (ret < 0) {
-		mcb_release_bus(priv->bus);
-		return ret;
+		goto out_mcb_bus;
 	}
 
-	dev_dbg(&pdev->dev, "Found %d cells\n", ret);
+	table_size = ret;
+
+	if (table_size < CHAM_HEADER_SIZE) {
+		/* Release the previous resources */
+		devm_iounmap(&pdev->dev, priv->base);
+		devm_release_mem_region(&pdev->dev, priv->mem->start, resource_size(priv->mem));
+
+		/* Then, allocate it again with the actual chameleon table size */
+		res = devm_request_mem_region(&pdev->dev, priv->mem->start,
+					      table_size,
+					      KBUILD_MODNAME);
+		if (!res) {
+			dev_err(&pdev->dev, "Failed to request PCI memory\n");
+			ret = -EBUSY;
+			goto out_mcb_bus;
+		}
+
+		priv->base = devm_ioremap(&pdev->dev, priv->mem->start, table_size);
+		if (!priv->base) {
+			dev_err(&pdev->dev, "Cannot ioremap\n");
+			ret = -ENOMEM;
+			goto out_mcb_bus;
+		}
+
+		platform_set_drvdata(pdev, priv);
+	}
 
 	mcb_bus_add_devices(priv->bus);
 
 	return 0;
 
+out_mcb_bus:
+	mcb_release_bus(priv->bus);
+	return ret;
 }
 
 static int mcb_lpc_remove(struct platform_device *pdev)
diff --git a/drivers/mcb/mcb-parse.c b/drivers/mcb/mcb-parse.c
index 08a85e43ef88..b7354232221e 100644
--- a/drivers/mcb/mcb-parse.c
+++ b/drivers/mcb/mcb-parse.c
@@ -127,7 +127,7 @@ static void chameleon_parse_bar(void __iomem *base,
 	}
 }
 
-static int chameleon_get_bar(char __iomem **base, phys_addr_t mapbase,
+static int chameleon_get_bar(void __iomem **base, phys_addr_t mapbase,
 			     struct chameleon_bar **cb)
 {
 	struct chameleon_bar *c;
@@ -176,12 +176,13 @@ int chameleon_parse_cells(struct mcb_bus *bus, phys_addr_t mapbase,
 {
 	struct chameleon_fpga_header *header;
 	struct chameleon_bar *cb;
-	char __iomem *p = base;
+	void __iomem *p = base;
 	int num_cells = 0;
 	uint32_t dtype;
 	int bar_count;
 	int ret;
 	u32 hsize;
+	u32 table_size;
 
 	hsize = sizeof(struct chameleon_fpga_header);
 
@@ -236,12 +237,16 @@ int chameleon_parse_cells(struct mcb_bus *bus, phys_addr_t mapbase,
 		num_cells++;
 	}
 
-	if (num_cells == 0)
-		num_cells = -EINVAL;
+	if (num_cells == 0) {
+		ret = -EINVAL;
+		goto free_bar;
+	}
 
+	table_size = p - base;
+	pr_debug("%d cell(s) found. Chameleon table size: 0x%04x bytes\n", num_cells, table_size);
 	kfree(cb);
 	kfree(header);
-	return num_cells;
+	return table_size;
 
 free_bar:
 	kfree(cb);
diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
index ecb8ef4a756f..6ffd5f3dcf05 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
@@ -3710,6 +3710,8 @@ int t4_load_phy_fw(struct adapter *adap,
 		 FW_PARAMS_PARAM_Z_V(FW_PARAMS_PARAM_DEV_PHYFW_DOWNLOAD));
 	ret = t4_set_params_timeout(adap, adap->mbox, adap->pf, 0, 1,
 				    &param, &val, 30000);
+	if (ret)
+		return ret;
 
 	/* If we have version number support, then check to see that the new
 	 * firmware got loaded properly.
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index d79a2c8175c4..02871e0e2024 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2401,7 +2401,7 @@ int i40e_napi_poll(struct napi_struct *napi, int budget)
 		return budget;
 	}
 
-	if (vsi->back->flags & I40E_TXR_FLAGS_WB_ON_ITR)
+	if (q_vector->tx.ring[0].flags & I40E_TXR_FLAGS_WB_ON_ITR)
 		q_vector->arm_wb_state = false;
 
 	/* Work is done so exit the polling mode and re-enable the interrupt */
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 77108b0a07f5..c8b5650b7eac 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2951,11 +2951,15 @@ static int igb_add_ethtool_nfc_entry(struct igb_adapter *adapter,
 	if (err)
 		goto err_out_w_lock;
 
-	igb_update_ethtool_nfc_entry(adapter, input, input->sw_idx);
+	err = igb_update_ethtool_nfc_entry(adapter, input, input->sw_idx);
+	if (err)
+		goto err_out_input_filter;
 
 	spin_unlock(&adapter->nfc_lock);
 	return 0;
 
+err_out_input_filter:
+	igb_erase_filter(adapter, input);
 err_out_w_lock:
 	spin_unlock(&adapter->nfc_lock);
 err_out:
diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c b/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c
index eed18f88bdff..e70175f40a82 100644
--- a/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c
+++ b/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c
@@ -1232,7 +1232,7 @@ static int gelic_wl_set_encodeext(struct net_device *netdev,
 		key_index = wl->current_key;
 
 	if (!enc->length && (ext->ext_flags & IW_ENCODE_EXT_SET_TX_KEY)) {
-		/* reques to change default key index */
+		/* request to change default key index */
 		pr_debug("%s: request to change default key to %d\n",
 			 __func__, key_index);
 		wl->current_key = key_index;
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index d17d125a3454..a0b40bdbdd84 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -786,7 +786,7 @@ int get_registers(struct r8152 *tp, u16 value, u16 index, u16 size, void *data)
 
 	ret = usb_control_msg(tp->udev, usb_rcvctrlpipe(tp->udev, 0),
 			      RTL8152_REQ_GET_REGS, RTL8152_REQT_READ,
-			      value, index, tmp, size, 500);
+			      value, index, tmp, size, USB_CTRL_GET_TIMEOUT);
 	if (ret < 0)
 		memset(data, 0xff, size);
 	else
@@ -809,7 +809,7 @@ int set_registers(struct r8152 *tp, u16 value, u16 index, u16 size, void *data)
 
 	ret = usb_control_msg(tp->udev, usb_sndctrlpipe(tp->udev, 0),
 			      RTL8152_REQ_SET_REGS, RTL8152_REQT_WRITE,
-			      value, index, tmp, size, 500);
+			      value, index, tmp, size, USB_CTRL_SET_TIMEOUT);
 
 	kfree(tmp);
 
@@ -5084,7 +5084,8 @@ static u8 rtl_get_version(struct usb_interface *intf)
 
 	ret = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
 			      RTL8152_REQ_GET_REGS, RTL8152_REQT_READ,
-			      PLA_TCR0, MCU_TYPE_PLA, tmp, sizeof(*tmp), 500);
+			      PLA_TCR0, MCU_TYPE_PLA, tmp, sizeof(*tmp),
+			      USB_CTRL_GET_TIMEOUT);
 	if (ret > 0)
 		ocp_data = (__le32_to_cpu(*tmp) >> 16) & VERSION_MASK;
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7ca82b8c5c37..e32147929cf3 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -429,14 +429,15 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,	PCI_DEVICE_ID_ATI_RS100,   quirk_ati_
 /*
  * In the AMD NL platform, this device ([1022:7912]) has a class code of
  * PCI_CLASS_SERIAL_USB_XHCI (0x0c0330), which means the xhci driver will
- * claim it.
+ * claim it. The same applies on the VanGogh platform device ([1022:163a]).
+ *
  * But the dwc3 driver is a more specific driver for this device, and we'd
  * prefer to use it instead of xhci. To prevent xhci from claiming the
  * device, change the class code to 0x0c03fe, which the PCI r3.0 spec
  * defines as "USB device (not host controller)". The dwc3 driver can then
  * claim it based on its Vendor and Device ID.
  */
-static void quirk_amd_nl_class(struct pci_dev *pdev)
+static void quirk_amd_dwc_class(struct pci_dev *pdev)
 {
 	u32 class = pdev->class;
 
@@ -446,7 +447,9 @@ static void quirk_amd_nl_class(struct pci_dev *pdev)
 		 class, pdev->class);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_NL_USB,
-		quirk_amd_nl_class);
+		quirk_amd_dwc_class);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VANGOGH_USB,
+		quirk_amd_dwc_class);
 
 /*
  * Let's make the southbridge information explicit instead
diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
index 57a79bddb286..95612878a841 100644
--- a/drivers/platform/x86/asus-wmi.h
+++ b/drivers/platform/x86/asus-wmi.h
@@ -31,7 +31,7 @@
 #include <linux/i8042.h>
 
 #define ASUS_WMI_KEY_IGNORE (-1)
-#define ASUS_WMI_BRN_DOWN	0x20
+#define ASUS_WMI_BRN_DOWN	0x2e
 #define ASUS_WMI_BRN_UP		0x2f
 
 struct module;
diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index c1dfad298685..8ee814d6dddc 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1354,6 +1354,7 @@ static void qcom_glink_rpdev_release(struct device *dev)
 	struct glink_channel *channel = to_glink_channel(rpdev->ept);
 
 	channel->rpdev = NULL;
+	kfree(rpdev->driver_override);
 	kfree(rpdev);
 }
 
diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index dffa3aab7178..1389a32fdea3 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -474,24 +474,52 @@ static struct bus_type rpmsg_bus = {
 	.remove		= rpmsg_dev_remove,
 };
 
-int rpmsg_register_device(struct rpmsg_device *rpdev)
+/*
+ * A helper for registering rpmsg device with driver override and name.
+ * Drivers should not be using it, but instead rpmsg_register_device().
+ */
+int rpmsg_register_device_override(struct rpmsg_device *rpdev,
+				   const char *driver_override)
 {
 	struct device *dev = &rpdev->dev;
 	int ret;
 
+	if (driver_override)
+		strcpy(rpdev->id.name, driver_override);
+
 	dev_set_name(&rpdev->dev, "%s.%s.%d.%d", dev_name(dev->parent),
 		     rpdev->id.name, rpdev->src, rpdev->dst);
 
 	rpdev->dev.bus = &rpmsg_bus;
 
-	ret = device_register(&rpdev->dev);
+	device_initialize(dev);
+	if (driver_override) {
+		ret = driver_set_override(dev, &rpdev->driver_override,
+					  driver_override,
+					  strlen(driver_override));
+		if (ret) {
+			dev_err(dev, "device_set_override failed: %d\n", ret);
+			put_device(dev);
+			return ret;
+		}
+	}
+
+	ret = device_add(dev);
 	if (ret) {
-		dev_err(dev, "device_register failed: %d\n", ret);
+		dev_err(dev, "device_add failed: %d\n", ret);
+		kfree(rpdev->driver_override);
+		rpdev->driver_override = NULL;
 		put_device(&rpdev->dev);
 	}
 
 	return ret;
 }
+EXPORT_SYMBOL(rpmsg_register_device_override);
+
+int rpmsg_register_device(struct rpmsg_device *rpdev)
+{
+	return rpmsg_register_device_override(rpdev, NULL);
+}
 EXPORT_SYMBOL(rpmsg_register_device);
 
 /*
diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
index 0cf9c7e2ee83..868698a3d4c2 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -91,10 +91,7 @@ struct device *rpmsg_find_device(struct device *parent,
  */
 static inline int rpmsg_chrdev_register_device(struct rpmsg_device *rpdev)
 {
-	strcpy(rpdev->id.name, "rpmsg_chrdev");
-	rpdev->driver_override = "rpmsg_chrdev";
-
-	return rpmsg_register_device(rpdev);
+	return rpmsg_register_device_override(rpdev, "rpmsg_ctrl");
 }
 
 #endif
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 8fb7491c5bc0..0bccc4a12e53 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -9482,8 +9482,10 @@ _mpt3sas_init(void)
 	mpt3sas_ctl_init(hbas_to_enumerate);
 
 	error = pci_register_driver(&mpt3sas_driver);
-	if (error)
+	if (error) {
+		mpt3sas_ctl_exit(hbas_to_enumerate);
 		scsih_exit();
+	}
 
 	return error;
 }
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 51d3859f8f91..244177e8b2ba 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -4782,6 +4782,12 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		0, 0,
 		pbn_b1_bt_1_115200 },
 
+	/*
+	 * IntaShield IS-100
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0D60,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b2_1_115200 },
 	/*
 	 * IntaShield IS-200
 	 */
@@ -4809,10 +4815,14 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_1_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0AA2,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_1_115200 },
 	/*
-	 * Brainboxes UC-257
+	 * Brainboxes UC-253/UC-734
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0861,
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0CA1,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_2_115200 },
@@ -4848,6 +4858,14 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x08E2,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x08E3,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
 	/*
 	 * Brainboxes UC-310
 	 */
@@ -4858,6 +4876,14 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	/*
 	 * Brainboxes UC-313
 	 */
+	{       PCI_VENDOR_ID_INTASHIELD, 0x08A1,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{       PCI_VENDOR_ID_INTASHIELD, 0x08A2,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
 	{       PCI_VENDOR_ID_INTASHIELD, 0x08A3,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
@@ -4872,6 +4898,10 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	/*
 	 * Brainboxes UC-346
 	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0B01,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_4_115200 },
 	{	PCI_VENDOR_ID_INTASHIELD, 0x0B02,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
@@ -4883,6 +4913,10 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0A82,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
 	{	PCI_VENDOR_ID_INTASHIELD, 0x0A83,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
@@ -4895,12 +4929,94 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		0, 0,
 		pbn_b2_4_115200 },
 	/*
-	 * Brainboxes UC-420/431
+	 * Brainboxes UC-420
 	 */
 	{       PCI_VENDOR_ID_INTASHIELD, 0x0921,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_4_115200 },
+	/*
+	 * Brainboxes UC-607
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x09A1,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x09A2,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x09A3,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	/*
+	 * Brainboxes UC-836
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0D41,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_4_115200 },
+	/*
+	 * Brainboxes UP-189
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0AC1,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0AC2,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0AC3,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	/*
+	 * Brainboxes UP-200
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0B21,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0B22,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0B23,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	/*
+	 * Brainboxes UP-869
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C01,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C02,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C03,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	/*
+	 * Brainboxes UP-880
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C21,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C22,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C23,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
 	/*
 	 * Perle PCI-RAS cards
 	 */
diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 42c9ef64108f..aa67730f5cc6 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -219,10 +219,6 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	console_lock();
 
 	attr = (currcons & 128);
-	ret = -ENXIO;
-	vc = vcs_vc(inode, &viewed);
-	if (!vc)
-		goto unlock_out;
 
 	ret = -EINVAL;
 	if (pos < 0)
@@ -238,6 +234,11 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		ssize_t orig_count;
 		long p = pos;
 
+		ret = -ENXIO;
+		vc = vcs_vc(inode, &viewed);
+		if (!vc)
+			goto unlock_out;
+
 		/* Check whether we are above size each round,
 		 * as copy_to_user at the end of this loop
 		 * could sleep.
diff --git a/drivers/usb/storage/unusual_cypress.h b/drivers/usb/storage/unusual_cypress.h
index e9a2eb88869a..5e02face63c4 100644
--- a/drivers/usb/storage/unusual_cypress.h
+++ b/drivers/usb/storage/unusual_cypress.h
@@ -32,7 +32,7 @@ UNUSUAL_DEV(  0x04b4, 0x6831, 0x0000, 0x9999,
 		"Cypress ISD-300LP",
 		USB_SC_CYP_ATACB, USB_PR_DEVICE, NULL, 0),
 
-UNUSUAL_DEV( 0x14cd, 0x6116, 0x0160, 0x0160,
+UNUSUAL_DEV( 0x14cd, 0x6116, 0x0150, 0x0160,
 		"Super Top",
 		"USB 2.0  SATA BRIDGE",
 		USB_SC_CYP_ATACB, USB_PR_DEVICE, NULL, 0),
diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index d4b938276d23..71e95533613c 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -3435,11 +3435,15 @@ static int atyfb_setup_generic(struct pci_dev *pdev, struct fb_info *info,
 	}
 
 	info->fix.mmio_start = raddr;
+#if defined(__i386__) || defined(__ia64__)
 	/*
 	 * By using strong UC we force the MTRR to never have an
 	 * effect on the MMIO region on both non-PAT and PAT systems.
 	 */
 	par->ati_regbase = ioremap_uc(info->fix.mmio_start, 0x1000);
+#else
+	par->ati_regbase = ioremap(info->fix.mmio_start, 0x1000);
+#endif
 	if (par->ati_regbase == NULL)
 		return -ENOMEM;
 
diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index ee86c62e3672..72255715bbee 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -1931,10 +1931,10 @@ static void uvesafb_exit(void)
 		}
 	}
 
-	cn_del_callback(&uvesafb_cn_id);
 	driver_remove_file(&uvesafb_driver.driver, &driver_attr_v86d);
 	platform_device_unregister(uvesafb_device);
 	platform_driver_unregister(&uvesafb_driver);
+	cn_del_callback(&uvesafb_cn_id);
 }
 
 module_exit(uvesafb_exit);
diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 71970773aad1..db35a9da06dd 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -341,7 +341,11 @@ static inline s64 towards_target(struct virtio_balloon *vb)
 	if (!virtio_has_feature(vb->vdev, VIRTIO_F_VERSION_1))
 		num_pages = le32_to_cpu((__force __le32)num_pages);
 
-	target = num_pages;
+	/*
+	 * Aligned up to guest page size to avoid inflating and deflating
+	 * balloon endlessly.
+	 */
+	target = ALIGN(num_pages, VIRTIO_BALLOON_PAGES_PER_PAGE);
 	return target - vb->num_pages;
 }
 
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index c2e4c6ce2cf7..1f86b456ba7a 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -841,7 +841,8 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 
 		if (phase == 3) {
 			inode = f2fs_iget(sb, dni.ino);
-			if (IS_ERR(inode) || is_bad_inode(inode))
+			if (IS_ERR(inode) || is_bad_inode(inode) ||
+					special_file(inode->i_mode))
 				continue;
 
 			/* if encrypted inode, let's go phase 3 */
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 010733c8bdcd..1b5791d5537a 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -587,9 +587,8 @@ nfs_lock_and_join_requests(struct page *page)
 
 static void nfs_write_error_remove_page(struct nfs_page *req)
 {
+	SetPageError(req->wb_page);
 	nfs_end_page_writeback(req);
-	generic_error_remove_page(page_file_mapping(req->wb_page),
-				  req->wb_page);
 	nfs_release_request(req);
 }
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index a64065ad8851..43bfdbb9a601 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1665,6 +1665,12 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	if (!flen || isdotent(fname, flen) || !tlen || isdotent(tname, tlen))
 		goto out;
 
+	err = (rqstp->rq_vers == 2) ? nfserr_acces : nfserr_xdev;
+	if (ffhp->fh_export->ex_path.mnt != tfhp->fh_export->ex_path.mnt)
+		goto out;
+	if (ffhp->fh_export->ex_path.dentry != tfhp->fh_export->ex_path.dentry)
+		goto out;
+
 	host_err = fh_want_write(ffhp);
 	if (host_err) {
 		err = nfserrno(host_err);
@@ -1698,12 +1704,6 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	if (ndentry == trap)
 		goto out_dput_new;
 
-	host_err = -EXDEV;
-	if (ffhp->fh_export->ex_path.mnt != tfhp->fh_export->ex_path.mnt)
-		goto out_dput_new;
-	if (ffhp->fh_export->ex_path.dentry != tfhp->fh_export->ex_path.dentry)
-		goto out_dput_new;
-
 	host_err = vfs_rename(fdir, odentry, tdir, ndentry, NULL, 0);
 	if (!host_err) {
 		host_err = commit_metadata(tfhp);
diff --git a/include/linux/device.h b/include/linux/device.h
index fab5798a47fd..65e06a066b67 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -319,6 +319,8 @@ extern int __must_check driver_create_file(struct device_driver *driver,
 extern void driver_remove_file(struct device_driver *driver,
 			       const struct driver_attribute *attr);
 
+int driver_set_override(struct device *dev, const char **override,
+			const char *s, size_t len);
 extern int __must_check driver_for_each_device(struct device_driver *drv,
 					       struct device *start,
 					       void *data,
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 0122286beda5..83f576d45d78 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -541,6 +541,7 @@
 #define PCI_DEVICE_ID_AMD_16H_NB_F4	0x1534
 #define PCI_DEVICE_ID_AMD_16H_M30H_NB_F3 0x1583
 #define PCI_DEVICE_ID_AMD_16H_M30H_NB_F4 0x1584
+#define PCI_DEVICE_ID_AMD_VANGOGH_USB	0x163a
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
 #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 49f634d96118..8fdd3290072b 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -29,7 +29,11 @@ struct platform_device {
 	struct resource	*resource;
 
 	const struct platform_device_id	*id_entry;
-	char *driver_override; /* Driver name to force a match */
+	/*
+	 * Driver name to force a match.  Do not set directly, because core
+	 * frees it.  Use driver_set_override() to set or clear it.
+	 */
+	const char *driver_override;
 
 	/* MFD cell pointer */
 	struct mfd_cell *mfd_cell;
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index 1ab79e8dc0b8..650ebbd35b0c 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -66,7 +66,9 @@ struct rpmsg_channel_info {
  * rpmsg_device - device that belong to the rpmsg bus
  * @dev: the device struct
  * @id: device id (used to match between rpmsg drivers and devices)
- * @driver_override: driver name to force a match
+ * @driver_override: driver name to force a match; do not set directly,
+ *                   because core frees it; use driver_set_override() to
+ *                   set or clear it.
  * @src: local address
  * @dst: destination address
  * @ept: the rpmsg endpoint of this channel
@@ -75,7 +77,7 @@ struct rpmsg_channel_info {
 struct rpmsg_device {
 	struct device dev;
 	struct rpmsg_device_id id;
-	char *driver_override;
+	const char *driver_override;
 	u32 src;
 	u32 dst;
 	struct rpmsg_endpoint *ept;
@@ -138,6 +140,8 @@ struct rpmsg_driver {
 
 #if IS_ENABLED(CONFIG_RPMSG)
 
+int rpmsg_register_device_override(struct rpmsg_device *rpdev,
+				   const char *driver_override);
 int register_rpmsg_device(struct rpmsg_device *dev);
 void unregister_rpmsg_device(struct rpmsg_device *dev);
 int __register_rpmsg_driver(struct rpmsg_driver *drv, struct module *owner);
@@ -162,6 +166,12 @@ unsigned int rpmsg_poll(struct rpmsg_endpoint *ept, struct file *filp,
 
 #else
 
+static inline int rpmsg_register_device_override(struct rpmsg_device *rpdev,
+						 const char *driver_override)
+{
+	return -ENXIO;
+}
+
 static inline int register_rpmsg_device(struct rpmsg_device *dev)
 {
 	return -ENXIO;
diff --git a/include/uapi/linux/gtp.h b/include/uapi/linux/gtp.h
index c7d66755d212..78bd62014efd 100644
--- a/include/uapi/linux/gtp.h
+++ b/include/uapi/linux/gtp.h
@@ -30,6 +30,6 @@ enum gtp_attrs {
 	GTPA_PAD,
 	__GTPA_MAX,
 };
-#define GTPA_MAX (__GTPA_MAX + 1)
+#define GTPA_MAX (__GTPA_MAX - 1)
 
 #endif /* _UAPI_LINUX_GTP_H_ */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7ece49c14b74..262079890b13 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11059,7 +11059,8 @@ static int inherit_group(struct perf_event *parent_event,
 		if (IS_ERR(child_ctr))
 			return PTR_ERR(child_ctr);
 	}
-	leader->group_generation = parent_event->group_generation;
+	if (leader)
+		leader->group_generation = parent_event->group_generation;
 	return 0;
 }
 
diff --git a/lib/kobject.c b/lib/kobject.c
index b908655c5812..1a7c67d94f09 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -118,7 +118,7 @@ static int get_kobj_path_length(struct kobject *kobj)
 	return length;
 }
 
-static void fill_kobj_path(struct kobject *kobj, char *path, int length)
+static int fill_kobj_path(struct kobject *kobj, char *path, int length)
 {
 	struct kobject *parent;
 
@@ -127,12 +127,16 @@ static void fill_kobj_path(struct kobject *kobj, char *path, int length)
 		int cur = strlen(kobject_name(parent));
 		/* back up enough to print this name with '/' */
 		length -= cur;
+		if (length <= 0)
+			return -EINVAL;
 		memcpy(path + length, kobject_name(parent), cur);
 		*(path + --length) = '/';
 	}
 
 	pr_debug("kobject: '%s' (%p): %s: path = '%s'\n", kobject_name(kobj),
 		 kobj, __func__, path);
+
+	return 0;
 }
 
 /**
@@ -148,13 +152,17 @@ char *kobject_get_path(struct kobject *kobj, gfp_t gfp_mask)
 	char *path;
 	int len;
 
+retry:
 	len = get_kobj_path_length(kobj);
 	if (len == 0)
 		return NULL;
 	path = kzalloc(len, gfp_mask);
 	if (!path)
 		return NULL;
-	fill_kobj_path(kobj, path, len);
+	if (fill_kobj_path(kobj, path, len)) {
+		kfree(path);
+		goto retry;
+	}
 
 	return path;
 }
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 491c16d8e9dd..e65daf71a52d 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -2069,16 +2069,17 @@ void tcp_enter_loss(struct sock *sk)
  * restore sanity to the SACK scoreboard. If the apparent reneging
  * persists until this RTO then we'll clear the SACK scoreboard.
  */
-static bool tcp_check_sack_reneging(struct sock *sk, int flag)
+static bool tcp_check_sack_reneging(struct sock *sk, int *ack_flag)
 {
-	if (flag & FLAG_SACK_RENEGING &&
-	    flag & FLAG_SND_UNA_ADVANCED) {
+	if (*ack_flag & FLAG_SACK_RENEGING &&
+	    *ack_flag & FLAG_SND_UNA_ADVANCED) {
 		struct tcp_sock *tp = tcp_sk(sk);
 		unsigned long delay = max(usecs_to_jiffies(tp->srtt_us >> 4),
 					  msecs_to_jiffies(10));
 
 		inet_csk_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
 					  delay, TCP_RTO_MAX);
+		*ack_flag &= ~FLAG_SET_XMIT_TIMER;
 		return true;
 	}
 	return false;
@@ -2870,7 +2871,7 @@ static void tcp_fastretrans_alert(struct sock *sk, const int acked,
 		tp->prior_ssthresh = 0;
 
 	/* B. In all the states check for reneging SACKs. */
-	if (tcp_check_sack_reneging(sk, flag))
+	if (tcp_check_sack_reneging(sk, ack_flag))
 		return;
 
 	/* C. Check consistency of the current state. */
diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index 40ba9c8e3c07..7d7a94e3fc50 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -637,8 +637,8 @@ nfulnl_log_packet(struct net *net,
 	unsigned int plen;
 	struct nfnl_log_net *log = nfnl_log_pernet(net);
 	const struct nfnl_ct_hook *nfnl_ct = NULL;
+	enum ip_conntrack_info ctinfo = 0;
 	struct nf_conn *ct = NULL;
-	enum ip_conntrack_info ctinfo;
 
 	if (li_user && li_user->type == NF_LOG_TYPE_ULOG)
 		li = li_user;
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 01de25813c72..822c42101c3f 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3220,6 +3220,8 @@ int rt5645_set_jack_detect(struct snd_soc_codec *codec,
 				RT5645_GP1_PIN_IRQ, RT5645_GP1_PIN_IRQ);
 		regmap_update_bits(rt5645->regmap, RT5645_GEN_CTRL1,
 				RT5645_DIG_GATE_CTRL, RT5645_DIG_GATE_CTRL);
+		regmap_update_bits(rt5645->regmap, RT5645_DEPOP_M1,
+				RT5645_HP_CB_MASK, RT5645_HP_CB_PU);
 	}
 	rt5645_irq(0, rt5645);
 
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 6959a74a6f49..c5db2d9d44ed 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -441,10 +441,12 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	} else {
 		struct asoc_simple_card_info *cinfo;
 
+		ret = -EINVAL;
+
 		cinfo = dev->platform_data;
 		if (!cinfo) {
 			dev_err(dev, "no info for asoc-simple-card\n");
-			return -EINVAL;
+			goto err;
 		}
 
 		if (!cinfo->name ||
@@ -453,7 +455,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 		    !cinfo->platform ||
 		    !cinfo->cpu_dai.name) {
 			dev_err(dev, "insufficient asoc_simple_card_info settings\n");
-			return -EINVAL;
+			goto err;
 		}
 
 		card->name		= (cinfo->card) ? cinfo->card : cinfo->name;
