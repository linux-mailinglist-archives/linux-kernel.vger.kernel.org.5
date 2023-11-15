Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB6D7E5495
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344259AbjKHK4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235678AbjKHK4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:56:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A938E26A6;
        Wed,  8 Nov 2023 02:46:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE613C433C8;
        Wed,  8 Nov 2023 10:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699440375;
        bh=IxrrjNjAvbSZt3Gd4VOyjxwzQQ4d5ND+psxPsIZuMCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FAVKYWTy0mtZMNzud8GX+GELL00YnUjskoCpHVkQb+qxpRmoOfDjkoEzhtTI5xnyo
         MjDjsgJwRwgNCdZwgCplTNBBzoy8Odm9mj6Zv6J/ETj3UELu2mCe24uBI3mki8RNs8
         I9jfAiTfXc/AOt9velWKXlpvmZ+tuF3ISdgfWGf4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.19.298
Date:   Wed,  8 Nov 2023 11:46:01 +0100
Message-ID: <2023110801-kept-symptom-b3bc@gregkh>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <2023110800-freedom-unwanted-8384@gregkh>
References: <2023110800-freedom-unwanted-8384@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/MAINTAINERS b/MAINTAINERS
index 59003315a959..446ec6d11af5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -182,7 +182,7 @@ F:	drivers/net/hamradio/6pack.c
 M:	Realtek linux nic maintainers <nic_swsd@realtek.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
-F:	drivers/net/ethernet/realtek/r8169.c
+F:	drivers/net/ethernet/realtek/r8169*
 
 8250/16?50 (AND CLONE UARTS) SERIAL DRIVER
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
diff --git a/Makefile b/Makefile
index 72313a351445..0c2244a514fc 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 19
-SUBLEVEL = 297
+SUBLEVEL = 298
 EXTRAVERSION =
 NAME = "People's Front"
 
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
index 69e661f574a0..e4d1b3d0b7d9 100644
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
index 339eb17c9808..e351d682c2e3 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -637,7 +637,7 @@ __v7_setup_stack:
 	string	cpu_elf_name, "v7"
 	.align
 
-	.section ".proc.info.init", #alloc
+	.section ".proc.info.init", "a"
 
 	/*
 	 * Standard v7 proc info content
diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
index 9c2978c128d9..0be14b64879c 100644
--- a/arch/arm/mm/proc-v7m.S
+++ b/arch/arm/mm/proc-v7m.S
@@ -96,7 +96,7 @@ ENTRY(cpu_cm7_proc_fin)
 	ret	lr
 ENDPROC(cpu_cm7_proc_fin)
 
-	.section ".init.text", #alloc, #execinstr
+	.section ".init.text", "ax"
 
 __v7m_cm7_setup:
 	mov	r8, #(V7M_SCB_CCR_DC | V7M_SCB_CCR_IC| V7M_SCB_CCR_BP)
@@ -180,7 +180,7 @@ ENDPROC(__v7m_setup)
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
diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index 7c69a203cdf8..b8d481c3e26d 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -211,10 +211,12 @@ static int emulation_proc_handler(struct ctl_table *table, int write,
 				  loff_t *ppos)
 {
 	int ret = 0;
-	struct insn_emulation *insn = container_of(table->data, struct insn_emulation, current_mode);
-	enum insn_emulation_mode prev_mode = insn->current_mode;
+	struct insn_emulation *insn;
+	enum insn_emulation_mode prev_mode;
 
 	mutex_lock(&insn_emulation_mutex);
+	insn = container_of(table->data, struct insn_emulation, current_mode);
+	prev_mode = insn->current_mode;
 	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 
 	if (ret || !write || prev_mode == insn->current_mode)
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
index 8b1aa1206d98..2f0fa294d617 100644
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
index 8821d0ab0a08..82753622f489 100644
--- a/arch/x86/kernel/i8259.c
+++ b/arch/x86/kernel/i8259.c
@@ -32,6 +32,7 @@
  */
 static void init_8259A(int auto_eoi);
 
+static bool pcat_compat __ro_after_init;
 static int i8259A_auto_eoi;
 DEFINE_RAW_SPINLOCK(i8259A_lock);
 
@@ -301,15 +302,32 @@ static void unmask_8259A(void)
 
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
 
@@ -431,5 +449,9 @@ static int __init i8259A_init_ops(void)
 
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
index 34c0652ca8b4..20d09355c9e0 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -383,7 +383,7 @@ SECTIONS
 	.brk : AT(ADDR(.brk) - LOAD_OFFSET) {
 		__brk_base = .;
 		. += 64 * 1024;		/* 64k alignment slop space */
-		*(.brk_reservation)	/* areas brk users have reserved */
+		*(.bss..brk)		/* areas brk users have reserved */
 		__brk_limit = .;
 	}
 
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index d5b9f9689877..8cc6cb14767b 100644
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
@@ -213,45 +215,45 @@ enum {
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
-	AHCI_HFLAG_IS_MOBILE		= (1 << 25), /* mobile chipset, use
+	AHCI_HFLAG_WAKE_BEFORE_STOP	= BIT(22), /* wake before DMA stop */
+	AHCI_HFLAG_YES_ALPM		= BIT(23), /* force ALPM cap on */
+	AHCI_HFLAG_NO_WRITE_TO_RO	= BIT(24), /* don't write to read
+						      only registers */
+	AHCI_HFLAG_IS_MOBILE		= BIT(25), /* mobile chipset, use
 							SATA_MOBILE_LPM_POLICY
 							as default lpm_policy */
 
@@ -269,22 +271,22 @@ enum {
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
index 857c8f1b876e..668c6c8c22f1 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -29,6 +29,75 @@ static struct device *next_device(struct klist_iter *i)
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
index 2f89e618b142..a09e7a681f7a 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -891,31 +891,11 @@ static ssize_t driver_override_store(struct device *dev,
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
index 940132e705c1..10637dbc9aac 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -311,15 +311,6 @@ config BLK_DEV_SKD
 
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
 	---help---
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 8566b188368b..1ac5a2bb3158 100644
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
index 4d90e5eba2f5..000000000000
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
-	rq = blk_get_request(host->oob_q, REQ_OP_DRV_OUT, 0);
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
index e9d76113c9e9..d7d3bf7920ea 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3685,6 +3685,7 @@ static int __init d40_probe(struct platform_device *pdev)
 		regulator_disable(base->lcpa_regulator);
 		regulator_put(base->lcpa_regulator);
 	}
+	pm_runtime_disable(base->dev);
 
 	kfree(base->lcla_pool.alloc_map);
 	kfree(base->lookup_log_chans);
diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 603ebaa6a7ed..8b994886e5b1 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -1308,14 +1308,14 @@ static struct drm_dp_mst_branch *get_mst_branch_device_by_guid_helper(
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
diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index e352c16087bb..cbffe303fbc3 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -959,9 +959,10 @@ static int stm32f7_i2c_smbus_xfer_msg(struct stm32f7_i2c_dev *i2c_dev,
 	/* Configure PEC */
 	if ((flags & I2C_CLIENT_PEC) && f7_msg->size != I2C_SMBUS_QUICK) {
 		cr1 |= STM32F7_I2C_CR1_PECEN;
-		cr2 |= STM32F7_I2C_CR2_PECBYTE;
-		if (!f7_msg->read_write)
+		if (!f7_msg->read_write) {
+			cr2 |= STM32F7_I2C_CR2_PECBYTE;
 			f7_msg->count++;
+		}
 	} else {
 		cr1 &= ~STM32F7_I2C_CR1_PECEN;
 		cr2 &= ~STM32F7_I2C_CR2_PECBYTE;
@@ -1049,8 +1050,10 @@ static void stm32f7_i2c_smbus_rep_start(struct stm32f7_i2c_dev *i2c_dev)
 	f7_msg->stop = true;
 
 	/* Add one byte for PEC if needed */
-	if (cr1 & STM32F7_I2C_CR1_PECEN)
+	if (cr1 & STM32F7_I2C_CR1_PECEN) {
+		cr2 |= STM32F7_I2C_CR2_PECBYTE;
 		f7_msg->count++;
+	}
 
 	/* Set number of bytes to be transferred */
 	cr2 &= ~(STM32F7_I2C_CR2_NBYTES_MASK);
diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
index 092ebc08549f..b62b93ecacef 100644
--- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
@@ -64,7 +64,7 @@ static int i2c_demux_activate_master(struct i2c_demux_pinctrl_priv *priv, u32 ne
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
diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 1ca2c4d39f87..7c5ea4ed5332 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -817,6 +817,12 @@ static int exynos_adc_probe(struct platform_device *pdev)
 		}
 	}
 
+	/* leave out any TS related code if unreachable */
+	if (IS_REACHABLE(CONFIG_INPUT)) {
+		has_ts = of_property_read_bool(pdev->dev.of_node,
+					       "has-touchscreen") || pdata;
+	}
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "no irq resource?\n");
@@ -824,11 +830,15 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	}
 	info->irq = irq;
 
-	irq = platform_get_irq(pdev, 1);
-	if (irq == -EPROBE_DEFER)
-		return irq;
+	if (has_ts) {
+		irq = platform_get_irq(pdev, 1);
+		if (irq == -EPROBE_DEFER)
+			return irq;
 
-	info->tsirq = irq;
+		info->tsirq = irq;
+	} else {
+		info->tsirq = -1;
+	}
 
 	info->dev = &pdev->dev;
 
@@ -895,12 +905,6 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	if (info->data->init_hw)
 		info->data->init_hw(info);
 
-	/* leave out any TS related code if unreachable */
-	if (IS_REACHABLE(CONFIG_INPUT)) {
-		has_ts = of_property_read_bool(pdev->dev.of_node,
-					       "has-touchscreen") || pdata;
-	}
-
 	if (pdata)
 		info->delay = pdata->delay;
 	else
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 794a7f17d024..833c54af42c3 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1750,6 +1750,7 @@ static int synaptics_create_intertouch(struct psmouse *psmouse,
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
 
diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 0cf9a3787326..2d4df82d65af 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -613,6 +613,14 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		},
 		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
+	{
+		/* Fujitsu Lifebook E5411 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU CLIENT COMPUTING LIMITED"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E5411"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOAUX)
+	},
 	{
 		/* Gigabyte M912 */
 		.matches = {
diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index f605470855f1..ed7346fb687b 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -365,6 +365,7 @@ static const struct irq_domain_ops irq_exti_domain_ops = {
 	.map	= irq_map_generic_chip,
 	.alloc  = stm32_exti_alloc,
 	.free	= stm32_exti_free,
+	.xlate	= irq_domain_xlate_twocell,
 };
 
 static void stm32_irq_ack(struct irq_data *d)
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
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 5f1ee88aa761..4fdb5dd9748f 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -963,7 +963,11 @@ static int mmc_sdio_resume(struct mmc_host *host)
 	/* Basic card reinitialization. */
 	mmc_claim_host(host);
 
-	/* Restore power if needed */
+	/*
+	 * Restore power and reinitialize the card when needed. Note that a
+	 * removable card is checked from a detect work later on in the resume
+	 * process.
+	 */
 	if (!mmc_card_keep_power(host)) {
 		mmc_power_up(host, host->card->ocr);
 		/*
@@ -977,14 +981,16 @@ static int mmc_sdio_resume(struct mmc_host *host)
 			pm_runtime_set_active(&host->card->dev);
 			pm_runtime_enable(&host->card->dev);
 		}
-	}
-
-	/* No need to reinitialize powered-resumed nonremovable cards */
-	if (mmc_card_is_removable(host) || !mmc_card_keep_power(host)) {
-		err = mmc_sdio_reinit_card(host, mmc_card_keep_power(host));
-	} else if (mmc_card_keep_power(host) && mmc_card_wake_sdio_irq(host)) {
-		/* We may have switched to 1-bit mode during suspend */
+		err = mmc_sdio_reinit_card(host, 0);
+	} else if (mmc_card_wake_sdio_irq(host)) {
+		/*
+		 * We may have switched to 1-bit mode during suspend,
+		 * need to hold retuning, because tuning only supprt
+		 * 4-bit mode or 8 bit mode.
+		 */
+		mmc_retune_hold_now(host);
 		err = sdio_enable_4bit_bus(host->card);
+		mmc_retune_release(host);
 	}
 
 	if (err)
diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
index 812f4b743d97..0e8aa2d803eb 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
@@ -3850,6 +3850,8 @@ int t4_load_phy_fw(struct adapter *adap,
 		 FW_PARAMS_PARAM_Z_V(FW_PARAMS_PARAM_DEV_PHYFW_DOWNLOAD));
 	ret = t4_set_params_timeout(adap, adap->mbox, adap->pf, 0, 1,
 				    &param, &val, 30000);
+	if (ret)
+		return ret;
 
 	/* If we have version number support, then check to see that the new
 	 * firmware got loaded properly.
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 9ccbcd88bf1e..dfce967a066a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2642,7 +2642,7 @@ int i40e_napi_poll(struct napi_struct *napi, int budget)
 		return budget;
 	}
 
-	if (vsi->back->flags & I40E_TXR_FLAGS_WB_ON_ITR)
+	if (q_vector->tx.ring[0].flags & I40E_TXR_FLAGS_WB_ON_ITR)
 		q_vector->arm_wb_state = false;
 
 	/* Work is done so exit the polling mode and re-enable the interrupt */
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index e19fbdf2ff30..f714c85c36c5 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2994,11 +2994,15 @@ static int igb_add_ethtool_nfc_entry(struct igb_adapter *adapter,
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
diff --git a/drivers/net/ethernet/realtek/Makefile b/drivers/net/ethernet/realtek/Makefile
index 71b1da30ecb5..7f68be4b9f51 100644
--- a/drivers/net/ethernet/realtek/Makefile
+++ b/drivers/net/ethernet/realtek/Makefile
@@ -5,4 +5,5 @@
 obj-$(CONFIG_8139CP) += 8139cp.o
 obj-$(CONFIG_8139TOO) += 8139too.o
 obj-$(CONFIG_ATP) += atp.o
+r8169-objs += r8169_main.o
 obj-$(CONFIG_R8169) += r8169.o
diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
deleted file mode 100644
index 523626f2ffbe..000000000000
--- a/drivers/net/ethernet/realtek/r8169.c
+++ /dev/null
@@ -1,7698 +0,0 @@
-/*
- * r8169.c: RealTek 8169/8168/8101 ethernet driver.
- *
- * Copyright (c) 2002 ShuChen <shuchen@realtek.com.tw>
- * Copyright (c) 2003 - 2007 Francois Romieu <romieu@fr.zoreil.com>
- * Copyright (c) a lot of people too. Please respect their work.
- *
- * See MAINTAINERS file for support contact information.
- */
-
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/pci.h>
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/clk.h>
-#include <linux/delay.h>
-#include <linux/ethtool.h>
-#include <linux/phy.h>
-#include <linux/if_vlan.h>
-#include <linux/crc32.h>
-#include <linux/in.h>
-#include <linux/io.h>
-#include <linux/ip.h>
-#include <linux/tcp.h>
-#include <linux/interrupt.h>
-#include <linux/dma-mapping.h>
-#include <linux/pm_runtime.h>
-#include <linux/firmware.h>
-#include <linux/prefetch.h>
-#include <linux/pci-aspm.h>
-#include <linux/ipv6.h>
-#include <net/ip6_checksum.h>
-
-#define MODULENAME "r8169"
-
-#define FIRMWARE_8168D_1	"rtl_nic/rtl8168d-1.fw"
-#define FIRMWARE_8168D_2	"rtl_nic/rtl8168d-2.fw"
-#define FIRMWARE_8168E_1	"rtl_nic/rtl8168e-1.fw"
-#define FIRMWARE_8168E_2	"rtl_nic/rtl8168e-2.fw"
-#define FIRMWARE_8168E_3	"rtl_nic/rtl8168e-3.fw"
-#define FIRMWARE_8168F_1	"rtl_nic/rtl8168f-1.fw"
-#define FIRMWARE_8168F_2	"rtl_nic/rtl8168f-2.fw"
-#define FIRMWARE_8105E_1	"rtl_nic/rtl8105e-1.fw"
-#define FIRMWARE_8402_1		"rtl_nic/rtl8402-1.fw"
-#define FIRMWARE_8411_1		"rtl_nic/rtl8411-1.fw"
-#define FIRMWARE_8411_2		"rtl_nic/rtl8411-2.fw"
-#define FIRMWARE_8106E_1	"rtl_nic/rtl8106e-1.fw"
-#define FIRMWARE_8106E_2	"rtl_nic/rtl8106e-2.fw"
-#define FIRMWARE_8168G_2	"rtl_nic/rtl8168g-2.fw"
-#define FIRMWARE_8168G_3	"rtl_nic/rtl8168g-3.fw"
-#define FIRMWARE_8168H_1	"rtl_nic/rtl8168h-1.fw"
-#define FIRMWARE_8168H_2	"rtl_nic/rtl8168h-2.fw"
-#define FIRMWARE_8107E_1	"rtl_nic/rtl8107e-1.fw"
-#define FIRMWARE_8107E_2	"rtl_nic/rtl8107e-2.fw"
-
-#define R8169_MSG_DEFAULT \
-	(NETIF_MSG_DRV | NETIF_MSG_PROBE | NETIF_MSG_IFUP | NETIF_MSG_IFDOWN)
-
-#define TX_SLOTS_AVAIL(tp) \
-	(tp->dirty_tx + NUM_TX_DESC - tp->cur_tx)
-
-/* A skbuff with nr_frags needs nr_frags+1 entries in the tx queue */
-#define TX_FRAGS_READY_FOR(tp,nr_frags) \
-	(TX_SLOTS_AVAIL(tp) >= (nr_frags + 1))
-
-/* Maximum number of multicast addresses to filter (vs. Rx-all-multicast).
-   The RTL chips use a 64 element hash table based on the Ethernet CRC. */
-static const int multicast_filter_limit = 32;
-
-#define TX_DMA_BURST	7	/* Maximum PCI burst, '7' is unlimited */
-#define InterFrameGap	0x03	/* 3 means InterFrameGap = the shortest one */
-
-#define R8169_REGS_SIZE		256
-#define R8169_RX_BUF_SIZE	(SZ_16K - 1)
-#define NUM_TX_DESC	64	/* Number of Tx descriptor registers */
-#define NUM_RX_DESC	256U	/* Number of Rx descriptor registers */
-#define R8169_TX_RING_BYTES	(NUM_TX_DESC * sizeof(struct TxDesc))
-#define R8169_RX_RING_BYTES	(NUM_RX_DESC * sizeof(struct RxDesc))
-
-#define RTL8169_TX_TIMEOUT	(6*HZ)
-
-/* write/read MMIO register */
-#define RTL_W8(tp, reg, val8)	writeb((val8), tp->mmio_addr + (reg))
-#define RTL_W16(tp, reg, val16)	writew((val16), tp->mmio_addr + (reg))
-#define RTL_W32(tp, reg, val32)	writel((val32), tp->mmio_addr + (reg))
-#define RTL_R8(tp, reg)		readb(tp->mmio_addr + (reg))
-#define RTL_R16(tp, reg)		readw(tp->mmio_addr + (reg))
-#define RTL_R32(tp, reg)		readl(tp->mmio_addr + (reg))
-
-enum mac_version {
-	RTL_GIGA_MAC_VER_01 = 0,
-	RTL_GIGA_MAC_VER_02,
-	RTL_GIGA_MAC_VER_03,
-	RTL_GIGA_MAC_VER_04,
-	RTL_GIGA_MAC_VER_05,
-	RTL_GIGA_MAC_VER_06,
-	RTL_GIGA_MAC_VER_07,
-	RTL_GIGA_MAC_VER_08,
-	RTL_GIGA_MAC_VER_09,
-	RTL_GIGA_MAC_VER_10,
-	RTL_GIGA_MAC_VER_11,
-	RTL_GIGA_MAC_VER_12,
-	RTL_GIGA_MAC_VER_13,
-	RTL_GIGA_MAC_VER_14,
-	RTL_GIGA_MAC_VER_15,
-	RTL_GIGA_MAC_VER_16,
-	RTL_GIGA_MAC_VER_17,
-	RTL_GIGA_MAC_VER_18,
-	RTL_GIGA_MAC_VER_19,
-	RTL_GIGA_MAC_VER_20,
-	RTL_GIGA_MAC_VER_21,
-	RTL_GIGA_MAC_VER_22,
-	RTL_GIGA_MAC_VER_23,
-	RTL_GIGA_MAC_VER_24,
-	RTL_GIGA_MAC_VER_25,
-	RTL_GIGA_MAC_VER_26,
-	RTL_GIGA_MAC_VER_27,
-	RTL_GIGA_MAC_VER_28,
-	RTL_GIGA_MAC_VER_29,
-	RTL_GIGA_MAC_VER_30,
-	RTL_GIGA_MAC_VER_31,
-	RTL_GIGA_MAC_VER_32,
-	RTL_GIGA_MAC_VER_33,
-	RTL_GIGA_MAC_VER_34,
-	RTL_GIGA_MAC_VER_35,
-	RTL_GIGA_MAC_VER_36,
-	RTL_GIGA_MAC_VER_37,
-	RTL_GIGA_MAC_VER_38,
-	RTL_GIGA_MAC_VER_39,
-	RTL_GIGA_MAC_VER_40,
-	RTL_GIGA_MAC_VER_41,
-	RTL_GIGA_MAC_VER_42,
-	RTL_GIGA_MAC_VER_43,
-	RTL_GIGA_MAC_VER_44,
-	RTL_GIGA_MAC_VER_45,
-	RTL_GIGA_MAC_VER_46,
-	RTL_GIGA_MAC_VER_47,
-	RTL_GIGA_MAC_VER_48,
-	RTL_GIGA_MAC_VER_49,
-	RTL_GIGA_MAC_VER_50,
-	RTL_GIGA_MAC_VER_51,
-	RTL_GIGA_MAC_NONE   = 0xff,
-};
-
-#define JUMBO_1K	ETH_DATA_LEN
-#define JUMBO_4K	(4*1024 - ETH_HLEN - 2)
-#define JUMBO_6K	(6*1024 - ETH_HLEN - 2)
-#define JUMBO_7K	(7*1024 - ETH_HLEN - 2)
-#define JUMBO_9K	(9*1024 - ETH_HLEN - 2)
-
-static const struct {
-	const char *name;
-	const char *fw_name;
-} rtl_chip_infos[] = {
-	/* PCI devices. */
-	[RTL_GIGA_MAC_VER_01] = {"RTL8169"				},
-	[RTL_GIGA_MAC_VER_02] = {"RTL8169s"				},
-	[RTL_GIGA_MAC_VER_03] = {"RTL8110s"				},
-	[RTL_GIGA_MAC_VER_04] = {"RTL8169sb/8110sb"			},
-	[RTL_GIGA_MAC_VER_05] = {"RTL8169sc/8110sc"			},
-	[RTL_GIGA_MAC_VER_06] = {"RTL8169sc/8110sc"			},
-	/* PCI-E devices. */
-	[RTL_GIGA_MAC_VER_07] = {"RTL8102e"				},
-	[RTL_GIGA_MAC_VER_08] = {"RTL8102e"				},
-	[RTL_GIGA_MAC_VER_09] = {"RTL8102e"				},
-	[RTL_GIGA_MAC_VER_10] = {"RTL8101e"				},
-	[RTL_GIGA_MAC_VER_11] = {"RTL8168b/8111b"			},
-	[RTL_GIGA_MAC_VER_12] = {"RTL8168b/8111b"			},
-	[RTL_GIGA_MAC_VER_13] = {"RTL8101e"				},
-	[RTL_GIGA_MAC_VER_14] = {"RTL8100e"				},
-	[RTL_GIGA_MAC_VER_15] = {"RTL8100e"				},
-	[RTL_GIGA_MAC_VER_16] = {"RTL8101e"				},
-	[RTL_GIGA_MAC_VER_17] = {"RTL8168b/8111b"			},
-	[RTL_GIGA_MAC_VER_18] = {"RTL8168cp/8111cp"			},
-	[RTL_GIGA_MAC_VER_19] = {"RTL8168c/8111c"			},
-	[RTL_GIGA_MAC_VER_20] = {"RTL8168c/8111c"			},
-	[RTL_GIGA_MAC_VER_21] = {"RTL8168c/8111c"			},
-	[RTL_GIGA_MAC_VER_22] = {"RTL8168c/8111c"			},
-	[RTL_GIGA_MAC_VER_23] = {"RTL8168cp/8111cp"			},
-	[RTL_GIGA_MAC_VER_24] = {"RTL8168cp/8111cp"			},
-	[RTL_GIGA_MAC_VER_25] = {"RTL8168d/8111d",	FIRMWARE_8168D_1},
-	[RTL_GIGA_MAC_VER_26] = {"RTL8168d/8111d",	FIRMWARE_8168D_2},
-	[RTL_GIGA_MAC_VER_27] = {"RTL8168dp/8111dp"			},
-	[RTL_GIGA_MAC_VER_28] = {"RTL8168dp/8111dp"			},
-	[RTL_GIGA_MAC_VER_29] = {"RTL8105e",		FIRMWARE_8105E_1},
-	[RTL_GIGA_MAC_VER_30] = {"RTL8105e",		FIRMWARE_8105E_1},
-	[RTL_GIGA_MAC_VER_31] = {"RTL8168dp/8111dp"			},
-	[RTL_GIGA_MAC_VER_32] = {"RTL8168e/8111e",	FIRMWARE_8168E_1},
-	[RTL_GIGA_MAC_VER_33] = {"RTL8168e/8111e",	FIRMWARE_8168E_2},
-	[RTL_GIGA_MAC_VER_34] = {"RTL8168evl/8111evl",	FIRMWARE_8168E_3},
-	[RTL_GIGA_MAC_VER_35] = {"RTL8168f/8111f",	FIRMWARE_8168F_1},
-	[RTL_GIGA_MAC_VER_36] = {"RTL8168f/8111f",	FIRMWARE_8168F_2},
-	[RTL_GIGA_MAC_VER_37] = {"RTL8402",		FIRMWARE_8402_1 },
-	[RTL_GIGA_MAC_VER_38] = {"RTL8411",		FIRMWARE_8411_1 },
-	[RTL_GIGA_MAC_VER_39] = {"RTL8106e",		FIRMWARE_8106E_1},
-	[RTL_GIGA_MAC_VER_40] = {"RTL8168g/8111g",	FIRMWARE_8168G_2},
-	[RTL_GIGA_MAC_VER_41] = {"RTL8168g/8111g"			},
-	[RTL_GIGA_MAC_VER_42] = {"RTL8168g/8111g",	FIRMWARE_8168G_3},
-	[RTL_GIGA_MAC_VER_43] = {"RTL8106e",		FIRMWARE_8106E_2},
-	[RTL_GIGA_MAC_VER_44] = {"RTL8411",		FIRMWARE_8411_2 },
-	[RTL_GIGA_MAC_VER_45] = {"RTL8168h/8111h",	FIRMWARE_8168H_1},
-	[RTL_GIGA_MAC_VER_46] = {"RTL8168h/8111h",	FIRMWARE_8168H_2},
-	[RTL_GIGA_MAC_VER_47] = {"RTL8107e",		FIRMWARE_8107E_1},
-	[RTL_GIGA_MAC_VER_48] = {"RTL8107e",		FIRMWARE_8107E_2},
-	[RTL_GIGA_MAC_VER_49] = {"RTL8168ep/8111ep"			},
-	[RTL_GIGA_MAC_VER_50] = {"RTL8168ep/8111ep"			},
-	[RTL_GIGA_MAC_VER_51] = {"RTL8168ep/8111ep"			},
-};
-
-enum cfg_version {
-	RTL_CFG_0 = 0x00,
-	RTL_CFG_1,
-	RTL_CFG_2
-};
-
-static const struct pci_device_id rtl8169_pci_tbl[] = {
-	{ PCI_VDEVICE(REALTEK,	0x2502), RTL_CFG_1 },
-	{ PCI_VDEVICE(REALTEK,	0x2600), RTL_CFG_1 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK,	0x8129), 0, 0, RTL_CFG_0 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK,	0x8136), 0, 0, RTL_CFG_2 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK,	0x8161), 0, 0, RTL_CFG_1 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK,	0x8167), 0, 0, RTL_CFG_0 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK,	0x8168), 0, 0, RTL_CFG_1 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_NCUBE,	0x8168), 0, 0, RTL_CFG_1 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK,	0x8169), 0, 0, RTL_CFG_0 },
-	{ PCI_VENDOR_ID_DLINK,			0x4300,
-		PCI_VENDOR_ID_DLINK, 0x4b10,		 0, 0, RTL_CFG_1 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK,	0x4300), 0, 0, RTL_CFG_0 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK,	0x4302), 0, 0, RTL_CFG_0 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AT,		0xc107), 0, 0, RTL_CFG_0 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_USR,		0x0116), 0, 0, RTL_CFG_0 },
-	{ PCI_VENDOR_ID_LINKSYS,		0x1032,
-		PCI_ANY_ID, 0x0024, 0, 0, RTL_CFG_0 },
-	{ 0x0001,				0x8168,
-		PCI_ANY_ID, 0x2410, 0, 0, RTL_CFG_2 },
-	{0,},
-};
-
-MODULE_DEVICE_TABLE(pci, rtl8169_pci_tbl);
-
-static int use_dac = -1;
-static struct {
-	u32 msg_enable;
-} debug = { -1 };
-
-enum rtl_registers {
-	MAC0		= 0,	/* Ethernet hardware address. */
-	MAC4		= 4,
-	MAR0		= 8,	/* Multicast filter. */
-	CounterAddrLow		= 0x10,
-	CounterAddrHigh		= 0x14,
-	TxDescStartAddrLow	= 0x20,
-	TxDescStartAddrHigh	= 0x24,
-	TxHDescStartAddrLow	= 0x28,
-	TxHDescStartAddrHigh	= 0x2c,
-	FLASH		= 0x30,
-	ERSR		= 0x36,
-	ChipCmd		= 0x37,
-	TxPoll		= 0x38,
-	IntrMask	= 0x3c,
-	IntrStatus	= 0x3e,
-
-	TxConfig	= 0x40,
-#define	TXCFG_AUTO_FIFO			(1 << 7)	/* 8111e-vl */
-#define	TXCFG_EMPTY			(1 << 11)	/* 8111e-vl */
-
-	RxConfig	= 0x44,
-#define	RX128_INT_EN			(1 << 15)	/* 8111c and later */
-#define	RX_MULTI_EN			(1 << 14)	/* 8111c only */
-#define	RXCFG_FIFO_SHIFT		13
-					/* No threshold before first PCI xfer */
-#define	RX_FIFO_THRESH			(7 << RXCFG_FIFO_SHIFT)
-#define	RX_EARLY_OFF			(1 << 11)
-#define	RXCFG_DMA_SHIFT			8
-					/* Unlimited maximum PCI burst. */
-#define	RX_DMA_BURST			(7 << RXCFG_DMA_SHIFT)
-
-	RxMissed	= 0x4c,
-	Cfg9346		= 0x50,
-	Config0		= 0x51,
-	Config1		= 0x52,
-	Config2		= 0x53,
-#define PME_SIGNAL			(1 << 5)	/* 8168c and later */
-
-	Config3		= 0x54,
-	Config4		= 0x55,
-	Config5		= 0x56,
-	MultiIntr	= 0x5c,
-	PHYAR		= 0x60,
-	PHYstatus	= 0x6c,
-	RxMaxSize	= 0xda,
-	CPlusCmd	= 0xe0,
-	IntrMitigate	= 0xe2,
-
-#define RTL_COALESCE_MASK	0x0f
-#define RTL_COALESCE_SHIFT	4
-#define RTL_COALESCE_T_MAX	(RTL_COALESCE_MASK)
-#define RTL_COALESCE_FRAME_MAX	(RTL_COALESCE_MASK << 2)
-
-	RxDescAddrLow	= 0xe4,
-	RxDescAddrHigh	= 0xe8,
-	EarlyTxThres	= 0xec,	/* 8169. Unit of 32 bytes. */
-
-#define NoEarlyTx	0x3f	/* Max value : no early transmit. */
-
-	MaxTxPacketSize	= 0xec,	/* 8101/8168. Unit of 128 bytes. */
-
-#define TxPacketMax	(8064 >> 7)
-#define EarlySize	0x27
-
-	FuncEvent	= 0xf0,
-	FuncEventMask	= 0xf4,
-	FuncPresetState	= 0xf8,
-	IBCR0           = 0xf8,
-	IBCR2           = 0xf9,
-	IBIMR0          = 0xfa,
-	IBISR0          = 0xfb,
-	FuncForceEvent	= 0xfc,
-};
-
-enum rtl8168_8101_registers {
-	CSIDR			= 0x64,
-	CSIAR			= 0x68,
-#define	CSIAR_FLAG			0x80000000
-#define	CSIAR_WRITE_CMD			0x80000000
-#define	CSIAR_BYTE_ENABLE		0x0000f000
-#define	CSIAR_ADDR_MASK			0x00000fff
-	PMCH			= 0x6f,
-	EPHYAR			= 0x80,
-#define	EPHYAR_FLAG			0x80000000
-#define	EPHYAR_WRITE_CMD		0x80000000
-#define	EPHYAR_REG_MASK			0x1f
-#define	EPHYAR_REG_SHIFT		16
-#define	EPHYAR_DATA_MASK		0xffff
-	DLLPR			= 0xd0,
-#define	PFM_EN				(1 << 6)
-#define	TX_10M_PS_EN			(1 << 7)
-	DBG_REG			= 0xd1,
-#define	FIX_NAK_1			(1 << 4)
-#define	FIX_NAK_2			(1 << 3)
-	TWSI			= 0xd2,
-	MCU			= 0xd3,
-#define	NOW_IS_OOB			(1 << 7)
-#define	TX_EMPTY			(1 << 5)
-#define	RX_EMPTY			(1 << 4)
-#define	RXTX_EMPTY			(TX_EMPTY | RX_EMPTY)
-#define	EN_NDP				(1 << 3)
-#define	EN_OOB_RESET			(1 << 2)
-#define	LINK_LIST_RDY			(1 << 1)
-	EFUSEAR			= 0xdc,
-#define	EFUSEAR_FLAG			0x80000000
-#define	EFUSEAR_WRITE_CMD		0x80000000
-#define	EFUSEAR_READ_CMD		0x00000000
-#define	EFUSEAR_REG_MASK		0x03ff
-#define	EFUSEAR_REG_SHIFT		8
-#define	EFUSEAR_DATA_MASK		0xff
-	MISC_1			= 0xf2,
-#define	PFM_D3COLD_EN			(1 << 6)
-};
-
-enum rtl8168_registers {
-	LED_FREQ		= 0x1a,
-	EEE_LED			= 0x1b,
-	ERIDR			= 0x70,
-	ERIAR			= 0x74,
-#define ERIAR_FLAG			0x80000000
-#define ERIAR_WRITE_CMD			0x80000000
-#define ERIAR_READ_CMD			0x00000000
-#define ERIAR_ADDR_BYTE_ALIGN		4
-#define ERIAR_TYPE_SHIFT		16
-#define ERIAR_EXGMAC			(0x00 << ERIAR_TYPE_SHIFT)
-#define ERIAR_MSIX			(0x01 << ERIAR_TYPE_SHIFT)
-#define ERIAR_ASF			(0x02 << ERIAR_TYPE_SHIFT)
-#define ERIAR_OOB			(0x02 << ERIAR_TYPE_SHIFT)
-#define ERIAR_MASK_SHIFT		12
-#define ERIAR_MASK_0001			(0x1 << ERIAR_MASK_SHIFT)
-#define ERIAR_MASK_0011			(0x3 << ERIAR_MASK_SHIFT)
-#define ERIAR_MASK_0100			(0x4 << ERIAR_MASK_SHIFT)
-#define ERIAR_MASK_0101			(0x5 << ERIAR_MASK_SHIFT)
-#define ERIAR_MASK_1111			(0xf << ERIAR_MASK_SHIFT)
-	EPHY_RXER_NUM		= 0x7c,
-	OCPDR			= 0xb0,	/* OCP GPHY access */
-#define OCPDR_WRITE_CMD			0x80000000
-#define OCPDR_READ_CMD			0x00000000
-#define OCPDR_REG_MASK			0x7f
-#define OCPDR_GPHY_REG_SHIFT		16
-#define OCPDR_DATA_MASK			0xffff
-	OCPAR			= 0xb4,
-#define OCPAR_FLAG			0x80000000
-#define OCPAR_GPHY_WRITE_CMD		0x8000f060
-#define OCPAR_GPHY_READ_CMD		0x0000f060
-	GPHY_OCP		= 0xb8,
-	RDSAR1			= 0xd0,	/* 8168c only. Undocumented on 8168dp */
-	MISC			= 0xf0,	/* 8168e only. */
-#define TXPLA_RST			(1 << 29)
-#define DISABLE_LAN_EN			(1 << 23) /* Enable GPIO pin */
-#define PWM_EN				(1 << 22)
-#define RXDV_GATED_EN			(1 << 19)
-#define EARLY_TALLY_EN			(1 << 16)
-};
-
-enum rtl_register_content {
-	/* InterruptStatusBits */
-	SYSErr		= 0x8000,
-	PCSTimeout	= 0x4000,
-	SWInt		= 0x0100,
-	TxDescUnavail	= 0x0080,
-	RxFIFOOver	= 0x0040,
-	LinkChg		= 0x0020,
-	RxOverflow	= 0x0010,
-	TxErr		= 0x0008,
-	TxOK		= 0x0004,
-	RxErr		= 0x0002,
-	RxOK		= 0x0001,
-
-	/* RxStatusDesc */
-	RxBOVF	= (1 << 24),
-	RxFOVF	= (1 << 23),
-	RxRWT	= (1 << 22),
-	RxRES	= (1 << 21),
-	RxRUNT	= (1 << 20),
-	RxCRC	= (1 << 19),
-
-	/* ChipCmdBits */
-	StopReq		= 0x80,
-	CmdReset	= 0x10,
-	CmdRxEnb	= 0x08,
-	CmdTxEnb	= 0x04,
-	RxBufEmpty	= 0x01,
-
-	/* TXPoll register p.5 */
-	HPQ		= 0x80,		/* Poll cmd on the high prio queue */
-	NPQ		= 0x40,		/* Poll cmd on the low prio queue */
-	FSWInt		= 0x01,		/* Forced software interrupt */
-
-	/* Cfg9346Bits */
-	Cfg9346_Lock	= 0x00,
-	Cfg9346_Unlock	= 0xc0,
-
-	/* rx_mode_bits */
-	AcceptErr	= 0x20,
-	AcceptRunt	= 0x10,
-	AcceptBroadcast	= 0x08,
-	AcceptMulticast	= 0x04,
-	AcceptMyPhys	= 0x02,
-	AcceptAllPhys	= 0x01,
-#define RX_CONFIG_ACCEPT_MASK		0x3f
-
-	/* TxConfigBits */
-	TxInterFrameGapShift = 24,
-	TxDMAShift = 8,	/* DMA burst value (0-7) is shift this many bits */
-
-	/* Config1 register p.24 */
-	LEDS1		= (1 << 7),
-	LEDS0		= (1 << 6),
-	Speed_down	= (1 << 4),
-	MEMMAP		= (1 << 3),
-	IOMAP		= (1 << 2),
-	VPD		= (1 << 1),
-	PMEnable	= (1 << 0),	/* Power Management Enable */
-
-	/* Config2 register p. 25 */
-	ClkReqEn	= (1 << 7),	/* Clock Request Enable */
-	MSIEnable	= (1 << 5),	/* 8169 only. Reserved in the 8168. */
-	PCI_Clock_66MHz = 0x01,
-	PCI_Clock_33MHz = 0x00,
-
-	/* Config3 register p.25 */
-	MagicPacket	= (1 << 5),	/* Wake up when receives a Magic Packet */
-	LinkUp		= (1 << 4),	/* Wake up when the cable connection is re-established */
-	Jumbo_En0	= (1 << 2),	/* 8168 only. Reserved in the 8168b */
-	Rdy_to_L23	= (1 << 1),	/* L23 Enable */
-	Beacon_en	= (1 << 0),	/* 8168 only. Reserved in the 8168b */
-
-	/* Config4 register */
-	Jumbo_En1	= (1 << 1),	/* 8168 only. Reserved in the 8168b */
-
-	/* Config5 register p.27 */
-	BWF		= (1 << 6),	/* Accept Broadcast wakeup frame */
-	MWF		= (1 << 5),	/* Accept Multicast wakeup frame */
-	UWF		= (1 << 4),	/* Accept Unicast wakeup frame */
-	Spi_en		= (1 << 3),
-	LanWake		= (1 << 1),	/* LanWake enable/disable */
-	PMEStatus	= (1 << 0),	/* PME status can be reset by PCI RST# */
-	ASPM_en		= (1 << 0),	/* ASPM enable */
-
-	/* CPlusCmd p.31 */
-	EnableBist	= (1 << 15),	// 8168 8101
-	Mac_dbgo_oe	= (1 << 14),	// 8168 8101
-	Normal_mode	= (1 << 13),	// unused
-	Force_half_dup	= (1 << 12),	// 8168 8101
-	Force_rxflow_en	= (1 << 11),	// 8168 8101
-	Force_txflow_en	= (1 << 10),	// 8168 8101
-	Cxpl_dbg_sel	= (1 << 9),	// 8168 8101
-	ASF		= (1 << 8),	// 8168 8101
-	PktCntrDisable	= (1 << 7),	// 8168 8101
-	Mac_dbgo_sel	= 0x001c,	// 8168
-	RxVlan		= (1 << 6),
-	RxChkSum	= (1 << 5),
-	PCIDAC		= (1 << 4),
-	PCIMulRW	= (1 << 3),
-#define INTT_MASK	GENMASK(1, 0)
-	INTT_0		= 0x0000,	// 8168
-	INTT_1		= 0x0001,	// 8168
-	INTT_2		= 0x0002,	// 8168
-	INTT_3		= 0x0003,	// 8168
-
-	/* rtl8169_PHYstatus */
-	TBI_Enable	= 0x80,
-	TxFlowCtrl	= 0x40,
-	RxFlowCtrl	= 0x20,
-	_1000bpsF	= 0x10,
-	_100bps		= 0x08,
-	_10bps		= 0x04,
-	LinkStatus	= 0x02,
-	FullDup		= 0x01,
-
-	/* _TBICSRBit */
-	TBILinkOK	= 0x02000000,
-
-	/* ResetCounterCommand */
-	CounterReset	= 0x1,
-
-	/* DumpCounterCommand */
-	CounterDump	= 0x8,
-
-	/* magic enable v2 */
-	MagicPacket_v2	= (1 << 16),	/* Wake up when receives a Magic Packet */
-};
-
-enum rtl_desc_bit {
-	/* First doubleword. */
-	DescOwn		= (1 << 31), /* Descriptor is owned by NIC */
-	RingEnd		= (1 << 30), /* End of descriptor ring */
-	FirstFrag	= (1 << 29), /* First segment of a packet */
-	LastFrag	= (1 << 28), /* Final segment of a packet */
-};
-
-/* Generic case. */
-enum rtl_tx_desc_bit {
-	/* First doubleword. */
-	TD_LSO		= (1 << 27),		/* Large Send Offload */
-#define TD_MSS_MAX			0x07ffu	/* MSS value */
-
-	/* Second doubleword. */
-	TxVlanTag	= (1 << 17),		/* Add VLAN tag */
-};
-
-/* 8169, 8168b and 810x except 8102e. */
-enum rtl_tx_desc_bit_0 {
-	/* First doubleword. */
-#define TD0_MSS_SHIFT			16	/* MSS position (11 bits) */
-	TD0_TCP_CS	= (1 << 16),		/* Calculate TCP/IP checksum */
-	TD0_UDP_CS	= (1 << 17),		/* Calculate UDP/IP checksum */
-	TD0_IP_CS	= (1 << 18),		/* Calculate IP checksum */
-};
-
-/* 8102e, 8168c and beyond. */
-enum rtl_tx_desc_bit_1 {
-	/* First doubleword. */
-	TD1_GTSENV4	= (1 << 26),		/* Giant Send for IPv4 */
-	TD1_GTSENV6	= (1 << 25),		/* Giant Send for IPv6 */
-#define GTTCPHO_SHIFT			18
-#define GTTCPHO_MAX			0x7fU
-
-	/* Second doubleword. */
-#define TCPHO_SHIFT			18
-#define TCPHO_MAX			0x3ffU
-#define TD1_MSS_SHIFT			18	/* MSS position (11 bits) */
-	TD1_IPv6_CS	= (1 << 28),		/* Calculate IPv6 checksum */
-	TD1_IPv4_CS	= (1 << 29),		/* Calculate IPv4 checksum */
-	TD1_TCP_CS	= (1 << 30),		/* Calculate TCP/IP checksum */
-	TD1_UDP_CS	= (1 << 31),		/* Calculate UDP/IP checksum */
-};
-
-enum rtl_rx_desc_bit {
-	/* Rx private */
-	PID1		= (1 << 18), /* Protocol ID bit 1/2 */
-	PID0		= (1 << 17), /* Protocol ID bit 0/2 */
-
-#define RxProtoUDP	(PID1)
-#define RxProtoTCP	(PID0)
-#define RxProtoIP	(PID1 | PID0)
-#define RxProtoMask	RxProtoIP
-
-	IPFail		= (1 << 16), /* IP checksum failed */
-	UDPFail		= (1 << 15), /* UDP/IP checksum failed */
-	TCPFail		= (1 << 14), /* TCP/IP checksum failed */
-	RxVlanTag	= (1 << 16), /* VLAN tag available */
-};
-
-#define RsvdMask	0x3fffc000
-#define CPCMD_QUIRK_MASK	(Normal_mode | RxVlan | RxChkSum | INTT_MASK)
-
-struct TxDesc {
-	__le32 opts1;
-	__le32 opts2;
-	__le64 addr;
-};
-
-struct RxDesc {
-	__le32 opts1;
-	__le32 opts2;
-	__le64 addr;
-};
-
-struct ring_info {
-	struct sk_buff	*skb;
-	u32		len;
-	u8		__pad[sizeof(void *) - sizeof(u32)];
-};
-
-struct rtl8169_counters {
-	__le64	tx_packets;
-	__le64	rx_packets;
-	__le64	tx_errors;
-	__le32	rx_errors;
-	__le16	rx_missed;
-	__le16	align_errors;
-	__le32	tx_one_collision;
-	__le32	tx_multi_collision;
-	__le64	rx_unicast;
-	__le64	rx_broadcast;
-	__le32	rx_multicast;
-	__le16	tx_aborted;
-	__le16	tx_underun;
-};
-
-struct rtl8169_tc_offsets {
-	bool	inited;
-	__le64	tx_errors;
-	__le32	tx_multi_collision;
-	__le16	tx_aborted;
-};
-
-enum rtl_flag {
-	RTL_FLAG_TASK_ENABLED = 0,
-	RTL_FLAG_TASK_SLOW_PENDING,
-	RTL_FLAG_TASK_RESET_PENDING,
-	RTL_FLAG_MAX
-};
-
-struct rtl8169_stats {
-	u64			packets;
-	u64			bytes;
-	struct u64_stats_sync	syncp;
-};
-
-struct rtl8169_private {
-	void __iomem *mmio_addr;	/* memory map physical address */
-	struct pci_dev *pci_dev;
-	struct net_device *dev;
-	struct napi_struct napi;
-	u32 msg_enable;
-	u16 mac_version;
-	u32 cur_rx; /* Index into the Rx descriptor buffer of next Rx pkt. */
-	u32 cur_tx; /* Index into the Tx descriptor buffer of next Rx pkt. */
-	u32 dirty_tx;
-	struct rtl8169_stats rx_stats;
-	struct rtl8169_stats tx_stats;
-	struct TxDesc *TxDescArray;	/* 256-aligned Tx descriptor ring */
-	struct RxDesc *RxDescArray;	/* 256-aligned Rx descriptor ring */
-	dma_addr_t TxPhyAddr;
-	dma_addr_t RxPhyAddr;
-	void *Rx_databuff[NUM_RX_DESC];	/* Rx data buffers */
-	struct ring_info tx_skb[NUM_TX_DESC];	/* Tx data buffers */
-	u16 cp_cmd;
-
-	u16 event_slow;
-	const struct rtl_coalesce_info *coalesce_info;
-	struct clk *clk;
-
-	struct mdio_ops {
-		void (*write)(struct rtl8169_private *, int, int);
-		int (*read)(struct rtl8169_private *, int);
-	} mdio_ops;
-
-	struct jumbo_ops {
-		void (*enable)(struct rtl8169_private *);
-		void (*disable)(struct rtl8169_private *);
-	} jumbo_ops;
-
-	void (*hw_start)(struct rtl8169_private *tp);
-	bool (*tso_csum)(struct rtl8169_private *, struct sk_buff *, u32 *);
-
-	struct {
-		DECLARE_BITMAP(flags, RTL_FLAG_MAX);
-		struct mutex mutex;
-		struct work_struct work;
-	} wk;
-
-	unsigned supports_gmii:1;
-	struct mii_bus *mii_bus;
-	dma_addr_t counters_phys_addr;
-	struct rtl8169_counters *counters;
-	struct rtl8169_tc_offsets tc_offset;
-	u32 saved_wolopts;
-
-	struct rtl_fw {
-		const struct firmware *fw;
-
-#define RTL_VER_SIZE		32
-
-		char version[RTL_VER_SIZE];
-
-		struct rtl_fw_phy_action {
-			__le32 *code;
-			size_t size;
-		} phy_action;
-	} *rtl_fw;
-#define RTL_FIRMWARE_UNKNOWN	ERR_PTR(-EAGAIN)
-
-	u32 ocp_base;
-};
-
-MODULE_AUTHOR("Realtek and the Linux r8169 crew <netdev@vger.kernel.org>");
-MODULE_DESCRIPTION("RealTek RTL-8169 Gigabit Ethernet driver");
-module_param(use_dac, int, 0);
-MODULE_PARM_DESC(use_dac, "Enable PCI DAC. Unsafe on 32 bit PCI slot.");
-module_param_named(debug, debug.msg_enable, int, 0);
-MODULE_PARM_DESC(debug, "Debug verbosity level (0=none, ..., 16=all)");
-MODULE_SOFTDEP("pre: realtek");
-MODULE_LICENSE("GPL");
-MODULE_FIRMWARE(FIRMWARE_8168D_1);
-MODULE_FIRMWARE(FIRMWARE_8168D_2);
-MODULE_FIRMWARE(FIRMWARE_8168E_1);
-MODULE_FIRMWARE(FIRMWARE_8168E_2);
-MODULE_FIRMWARE(FIRMWARE_8168E_3);
-MODULE_FIRMWARE(FIRMWARE_8105E_1);
-MODULE_FIRMWARE(FIRMWARE_8168F_1);
-MODULE_FIRMWARE(FIRMWARE_8168F_2);
-MODULE_FIRMWARE(FIRMWARE_8402_1);
-MODULE_FIRMWARE(FIRMWARE_8411_1);
-MODULE_FIRMWARE(FIRMWARE_8411_2);
-MODULE_FIRMWARE(FIRMWARE_8106E_1);
-MODULE_FIRMWARE(FIRMWARE_8106E_2);
-MODULE_FIRMWARE(FIRMWARE_8168G_2);
-MODULE_FIRMWARE(FIRMWARE_8168G_3);
-MODULE_FIRMWARE(FIRMWARE_8168H_1);
-MODULE_FIRMWARE(FIRMWARE_8168H_2);
-MODULE_FIRMWARE(FIRMWARE_8107E_1);
-MODULE_FIRMWARE(FIRMWARE_8107E_2);
-
-static inline struct device *tp_to_dev(struct rtl8169_private *tp)
-{
-	return &tp->pci_dev->dev;
-}
-
-static void rtl_lock_work(struct rtl8169_private *tp)
-{
-	mutex_lock(&tp->wk.mutex);
-}
-
-static void rtl_unlock_work(struct rtl8169_private *tp)
-{
-	mutex_unlock(&tp->wk.mutex);
-}
-
-static void rtl_tx_performance_tweak(struct rtl8169_private *tp, u16 force)
-{
-	pcie_capability_clear_and_set_word(tp->pci_dev, PCI_EXP_DEVCTL,
-					   PCI_EXP_DEVCTL_READRQ, force);
-}
-
-struct rtl_cond {
-	bool (*check)(struct rtl8169_private *);
-	const char *msg;
-};
-
-static void rtl_udelay(unsigned int d)
-{
-	udelay(d);
-}
-
-static bool rtl_loop_wait(struct rtl8169_private *tp, const struct rtl_cond *c,
-			  void (*delay)(unsigned int), unsigned int d, int n,
-			  bool high)
-{
-	int i;
-
-	for (i = 0; i < n; i++) {
-		delay(d);
-		if (c->check(tp) == high)
-			return true;
-	}
-	netif_err(tp, drv, tp->dev, "%s == %d (loop: %d, delay: %d).\n",
-		  c->msg, !high, n, d);
-	return false;
-}
-
-static bool rtl_udelay_loop_wait_high(struct rtl8169_private *tp,
-				      const struct rtl_cond *c,
-				      unsigned int d, int n)
-{
-	return rtl_loop_wait(tp, c, rtl_udelay, d, n, true);
-}
-
-static bool rtl_udelay_loop_wait_low(struct rtl8169_private *tp,
-				     const struct rtl_cond *c,
-				     unsigned int d, int n)
-{
-	return rtl_loop_wait(tp, c, rtl_udelay, d, n, false);
-}
-
-static bool rtl_msleep_loop_wait_high(struct rtl8169_private *tp,
-				      const struct rtl_cond *c,
-				      unsigned int d, int n)
-{
-	return rtl_loop_wait(tp, c, msleep, d, n, true);
-}
-
-static bool rtl_msleep_loop_wait_low(struct rtl8169_private *tp,
-				     const struct rtl_cond *c,
-				     unsigned int d, int n)
-{
-	return rtl_loop_wait(tp, c, msleep, d, n, false);
-}
-
-#define DECLARE_RTL_COND(name)				\
-static bool name ## _check(struct rtl8169_private *);	\
-							\
-static const struct rtl_cond name = {			\
-	.check	= name ## _check,			\
-	.msg	= #name					\
-};							\
-							\
-static bool name ## _check(struct rtl8169_private *tp)
-
-static bool rtl_ocp_reg_failure(struct rtl8169_private *tp, u32 reg)
-{
-	if (reg & 0xffff0001) {
-		netif_err(tp, drv, tp->dev, "Invalid ocp reg %x!\n", reg);
-		return true;
-	}
-	return false;
-}
-
-DECLARE_RTL_COND(rtl_ocp_gphy_cond)
-{
-	return RTL_R32(tp, GPHY_OCP) & OCPAR_FLAG;
-}
-
-static void r8168_phy_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
-{
-	if (rtl_ocp_reg_failure(tp, reg))
-		return;
-
-	RTL_W32(tp, GPHY_OCP, OCPAR_FLAG | (reg << 15) | data);
-
-	rtl_udelay_loop_wait_low(tp, &rtl_ocp_gphy_cond, 25, 10);
-}
-
-static u16 r8168_phy_ocp_read(struct rtl8169_private *tp, u32 reg)
-{
-	if (rtl_ocp_reg_failure(tp, reg))
-		return 0;
-
-	RTL_W32(tp, GPHY_OCP, reg << 15);
-
-	return rtl_udelay_loop_wait_high(tp, &rtl_ocp_gphy_cond, 25, 10) ?
-		(RTL_R32(tp, GPHY_OCP) & 0xffff) : ~0;
-}
-
-static void r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
-{
-	if (rtl_ocp_reg_failure(tp, reg))
-		return;
-
-	RTL_W32(tp, OCPDR, OCPAR_FLAG | (reg << 15) | data);
-}
-
-static u16 r8168_mac_ocp_read(struct rtl8169_private *tp, u32 reg)
-{
-	if (rtl_ocp_reg_failure(tp, reg))
-		return 0;
-
-	RTL_W32(tp, OCPDR, reg << 15);
-
-	return RTL_R32(tp, OCPDR);
-}
-
-#define OCP_STD_PHY_BASE	0xa400
-
-static void r8168g_mdio_write(struct rtl8169_private *tp, int reg, int value)
-{
-	if (reg == 0x1f) {
-		tp->ocp_base = value ? value << 4 : OCP_STD_PHY_BASE;
-		return;
-	}
-
-	if (tp->ocp_base != OCP_STD_PHY_BASE)
-		reg -= 0x10;
-
-	r8168_phy_ocp_write(tp, tp->ocp_base + reg * 2, value);
-}
-
-static int r8168g_mdio_read(struct rtl8169_private *tp, int reg)
-{
-	if (tp->ocp_base != OCP_STD_PHY_BASE)
-		reg -= 0x10;
-
-	return r8168_phy_ocp_read(tp, tp->ocp_base + reg * 2);
-}
-
-static void mac_mcu_write(struct rtl8169_private *tp, int reg, int value)
-{
-	if (reg == 0x1f) {
-		tp->ocp_base = value << 4;
-		return;
-	}
-
-	r8168_mac_ocp_write(tp, tp->ocp_base + reg, value);
-}
-
-static int mac_mcu_read(struct rtl8169_private *tp, int reg)
-{
-	return r8168_mac_ocp_read(tp, tp->ocp_base + reg);
-}
-
-DECLARE_RTL_COND(rtl_phyar_cond)
-{
-	return RTL_R32(tp, PHYAR) & 0x80000000;
-}
-
-static void r8169_mdio_write(struct rtl8169_private *tp, int reg, int value)
-{
-	RTL_W32(tp, PHYAR, 0x80000000 | (reg & 0x1f) << 16 | (value & 0xffff));
-
-	rtl_udelay_loop_wait_low(tp, &rtl_phyar_cond, 25, 20);
-	/*
-	 * According to hardware specs a 20us delay is required after write
-	 * complete indication, but before sending next command.
-	 */
-	udelay(20);
-}
-
-static int r8169_mdio_read(struct rtl8169_private *tp, int reg)
-{
-	int value;
-
-	RTL_W32(tp, PHYAR, 0x0 | (reg & 0x1f) << 16);
-
-	value = rtl_udelay_loop_wait_high(tp, &rtl_phyar_cond, 25, 20) ?
-		RTL_R32(tp, PHYAR) & 0xffff : ~0;
-
-	/*
-	 * According to hardware specs a 20us delay is required after read
-	 * complete indication, but before sending next command.
-	 */
-	udelay(20);
-
-	return value;
-}
-
-DECLARE_RTL_COND(rtl_ocpar_cond)
-{
-	return RTL_R32(tp, OCPAR) & OCPAR_FLAG;
-}
-
-static void r8168dp_1_mdio_access(struct rtl8169_private *tp, int reg, u32 data)
-{
-	RTL_W32(tp, OCPDR, data | ((reg & OCPDR_REG_MASK) << OCPDR_GPHY_REG_SHIFT));
-	RTL_W32(tp, OCPAR, OCPAR_GPHY_WRITE_CMD);
-	RTL_W32(tp, EPHY_RXER_NUM, 0);
-
-	rtl_udelay_loop_wait_low(tp, &rtl_ocpar_cond, 1000, 100);
-}
-
-static void r8168dp_1_mdio_write(struct rtl8169_private *tp, int reg, int value)
-{
-	r8168dp_1_mdio_access(tp, reg,
-			      OCPDR_WRITE_CMD | (value & OCPDR_DATA_MASK));
-}
-
-static int r8168dp_1_mdio_read(struct rtl8169_private *tp, int reg)
-{
-	r8168dp_1_mdio_access(tp, reg, OCPDR_READ_CMD);
-
-	mdelay(1);
-	RTL_W32(tp, OCPAR, OCPAR_GPHY_READ_CMD);
-	RTL_W32(tp, EPHY_RXER_NUM, 0);
-
-	return rtl_udelay_loop_wait_high(tp, &rtl_ocpar_cond, 1000, 100) ?
-		RTL_R32(tp, OCPDR) & OCPDR_DATA_MASK : ~0;
-}
-
-#define R8168DP_1_MDIO_ACCESS_BIT	0x00020000
-
-static void r8168dp_2_mdio_start(struct rtl8169_private *tp)
-{
-	RTL_W32(tp, 0xd0, RTL_R32(tp, 0xd0) & ~R8168DP_1_MDIO_ACCESS_BIT);
-}
-
-static void r8168dp_2_mdio_stop(struct rtl8169_private *tp)
-{
-	RTL_W32(tp, 0xd0, RTL_R32(tp, 0xd0) | R8168DP_1_MDIO_ACCESS_BIT);
-}
-
-static void r8168dp_2_mdio_write(struct rtl8169_private *tp, int reg, int value)
-{
-	r8168dp_2_mdio_start(tp);
-
-	r8169_mdio_write(tp, reg, value);
-
-	r8168dp_2_mdio_stop(tp);
-}
-
-static int r8168dp_2_mdio_read(struct rtl8169_private *tp, int reg)
-{
-	int value;
-
-	/* Work around issue with chip reporting wrong PHY ID */
-	if (reg == MII_PHYSID2)
-		return 0xc912;
-
-	r8168dp_2_mdio_start(tp);
-
-	value = r8169_mdio_read(tp, reg);
-
-	r8168dp_2_mdio_stop(tp);
-
-	return value;
-}
-
-static void rtl_writephy(struct rtl8169_private *tp, int location, u32 val)
-{
-	tp->mdio_ops.write(tp, location, val);
-}
-
-static int rtl_readphy(struct rtl8169_private *tp, int location)
-{
-	return tp->mdio_ops.read(tp, location);
-}
-
-static void rtl_patchphy(struct rtl8169_private *tp, int reg_addr, int value)
-{
-	rtl_writephy(tp, reg_addr, rtl_readphy(tp, reg_addr) | value);
-}
-
-static void rtl_w0w1_phy(struct rtl8169_private *tp, int reg_addr, int p, int m)
-{
-	int val;
-
-	val = rtl_readphy(tp, reg_addr);
-	rtl_writephy(tp, reg_addr, (val & ~m) | p);
-}
-
-DECLARE_RTL_COND(rtl_ephyar_cond)
-{
-	return RTL_R32(tp, EPHYAR) & EPHYAR_FLAG;
-}
-
-static void rtl_ephy_write(struct rtl8169_private *tp, int reg_addr, int value)
-{
-	RTL_W32(tp, EPHYAR, EPHYAR_WRITE_CMD | (value & EPHYAR_DATA_MASK) |
-		(reg_addr & EPHYAR_REG_MASK) << EPHYAR_REG_SHIFT);
-
-	rtl_udelay_loop_wait_low(tp, &rtl_ephyar_cond, 10, 100);
-
-	udelay(10);
-}
-
-static u16 rtl_ephy_read(struct rtl8169_private *tp, int reg_addr)
-{
-	RTL_W32(tp, EPHYAR, (reg_addr & EPHYAR_REG_MASK) << EPHYAR_REG_SHIFT);
-
-	return rtl_udelay_loop_wait_high(tp, &rtl_ephyar_cond, 10, 100) ?
-		RTL_R32(tp, EPHYAR) & EPHYAR_DATA_MASK : ~0;
-}
-
-DECLARE_RTL_COND(rtl_eriar_cond)
-{
-	return RTL_R32(tp, ERIAR) & ERIAR_FLAG;
-}
-
-static void rtl_eri_write(struct rtl8169_private *tp, int addr, u32 mask,
-			  u32 val, int type)
-{
-	BUG_ON((addr & 3) || (mask == 0));
-	RTL_W32(tp, ERIDR, val);
-	RTL_W32(tp, ERIAR, ERIAR_WRITE_CMD | type | mask | addr);
-
-	rtl_udelay_loop_wait_low(tp, &rtl_eriar_cond, 100, 100);
-}
-
-static u32 rtl_eri_read(struct rtl8169_private *tp, int addr, int type)
-{
-	RTL_W32(tp, ERIAR, ERIAR_READ_CMD | type | ERIAR_MASK_1111 | addr);
-
-	return rtl_udelay_loop_wait_high(tp, &rtl_eriar_cond, 100, 100) ?
-		RTL_R32(tp, ERIDR) : ~0;
-}
-
-static void rtl_w0w1_eri(struct rtl8169_private *tp, int addr, u32 mask, u32 p,
-			 u32 m, int type)
-{
-	u32 val;
-
-	val = rtl_eri_read(tp, addr, type);
-	rtl_eri_write(tp, addr, mask, (val & ~m) | p, type);
-}
-
-static u32 r8168dp_ocp_read(struct rtl8169_private *tp, u8 mask, u16 reg)
-{
-	RTL_W32(tp, OCPAR, ((u32)mask & 0x0f) << 12 | (reg & 0x0fff));
-	return rtl_udelay_loop_wait_high(tp, &rtl_ocpar_cond, 100, 20) ?
-		RTL_R32(tp, OCPDR) : ~0;
-}
-
-static u32 r8168ep_ocp_read(struct rtl8169_private *tp, u8 mask, u16 reg)
-{
-	return rtl_eri_read(tp, reg, ERIAR_OOB);
-}
-
-static u32 ocp_read(struct rtl8169_private *tp, u8 mask, u16 reg)
-{
-	switch (tp->mac_version) {
-	case RTL_GIGA_MAC_VER_27:
-	case RTL_GIGA_MAC_VER_28:
-	case RTL_GIGA_MAC_VER_31:
-		return r8168dp_ocp_read(tp, mask, reg);
-	case RTL_GIGA_MAC_VER_49:
-	case RTL_GIGA_MAC_VER_50:
-	case RTL_GIGA_MAC_VER_51:
-		return r8168ep_ocp_read(tp, mask, reg);
-	default:
-		BUG();
-		return ~0;
-	}
-}
-
-static void r8168dp_ocp_write(struct rtl8169_private *tp, u8 mask, u16 reg,
-			      u32 data)
-{
-	RTL_W32(tp, OCPDR, data);
-	RTL_W32(tp, OCPAR, OCPAR_FLAG | ((u32)mask & 0x0f) << 12 | (reg & 0x0fff));
-	rtl_udelay_loop_wait_low(tp, &rtl_ocpar_cond, 100, 20);
-}
-
-static void r8168ep_ocp_write(struct rtl8169_private *tp, u8 mask, u16 reg,
-			      u32 data)
-{
-	rtl_eri_write(tp, reg, ((u32)mask & 0x0f) << ERIAR_MASK_SHIFT,
-		      data, ERIAR_OOB);
-}
-
-static void ocp_write(struct rtl8169_private *tp, u8 mask, u16 reg, u32 data)
-{
-	switch (tp->mac_version) {
-	case RTL_GIGA_MAC_VER_27:
-	case RTL_GIGA_MAC_VER_28:
-	case RTL_GIGA_MAC_VER_31:
-		r8168dp_ocp_write(tp, mask, reg, data);
-		break;
-	case RTL_GIGA_MAC_VER_49:
-	case RTL_GIGA_MAC_VER_50:
-	case RTL_GIGA_MAC_VER_51:
-		r8168ep_ocp_write(tp, mask, reg, data);
-		break;
-	default:
-		BUG();
-		break;
-	}
-}
-
-static void rtl8168_oob_notify(struct rtl8169_private *tp, u8 cmd)
-{
-	rtl_eri_write(tp, 0xe8, ERIAR_MASK_0001, cmd, ERIAR_EXGMAC);
-
-	ocp_write(tp, 0x1, 0x30, 0x00000001);
-}
-
-#define OOB_CMD_RESET		0x00
-#define OOB_CMD_DRIVER_START	0x05
-#define OOB_CMD_DRIVER_STOP	0x06
-
-static u16 rtl8168_get_ocp_reg(struct rtl8169_private *tp)
-{
-	return (tp->mac_version == RTL_GIGA_MAC_VER_31) ? 0xb8 : 0x10;
-}
-
-DECLARE_RTL_COND(rtl_ocp_read_cond)
-{
-	u16 reg;
-
-	reg = rtl8168_get_ocp_reg(tp);
-
-	return ocp_read(tp, 0x0f, reg) & 0x00000800;
-}
-
-DECLARE_RTL_COND(rtl_ep_ocp_read_cond)
-{
-	return ocp_read(tp, 0x0f, 0x124) & 0x00000001;
-}
-
-DECLARE_RTL_COND(rtl_ocp_tx_cond)
-{
-	return RTL_R8(tp, IBISR0) & 0x20;
-}
-
-static void rtl8168ep_stop_cmac(struct rtl8169_private *tp)
-{
-	RTL_W8(tp, IBCR2, RTL_R8(tp, IBCR2) & ~0x01);
-	rtl_msleep_loop_wait_high(tp, &rtl_ocp_tx_cond, 50, 2000);
-	RTL_W8(tp, IBISR0, RTL_R8(tp, IBISR0) | 0x20);
-	RTL_W8(tp, IBCR0, RTL_R8(tp, IBCR0) & ~0x01);
-}
-
-static void rtl8168dp_driver_start(struct rtl8169_private *tp)
-{
-	rtl8168_oob_notify(tp, OOB_CMD_DRIVER_START);
-	rtl_msleep_loop_wait_high(tp, &rtl_ocp_read_cond, 10, 10);
-}
-
-static void rtl8168ep_driver_start(struct rtl8169_private *tp)
-{
-	ocp_write(tp, 0x01, 0x180, OOB_CMD_DRIVER_START);
-	ocp_write(tp, 0x01, 0x30, ocp_read(tp, 0x01, 0x30) | 0x01);
-	rtl_msleep_loop_wait_high(tp, &rtl_ep_ocp_read_cond, 10, 10);
-}
-
-static void rtl8168_driver_start(struct rtl8169_private *tp)
-{
-	switch (tp->mac_version) {
-	case RTL_GIGA_MAC_VER_27:
-	case RTL_GIGA_MAC_VER_28:
-	case RTL_GIGA_MAC_VER_31:
-		rtl8168dp_driver_start(tp);
-		break;
-	case RTL_GIGA_MAC_VER_49:
-	case RTL_GIGA_MAC_VER_50:
-	case RTL_GIGA_MAC_VER_51:
-		rtl8168ep_driver_start(tp);
-		break;
-	default:
-		BUG();
-		break;
-	}
-}
-
-static void rtl8168dp_driver_stop(struct rtl8169_private *tp)
-{
-	rtl8168_oob_notify(tp, OOB_CMD_DRIVER_STOP);
-	rtl_msleep_loop_wait_low(tp, &rtl_ocp_read_cond, 10, 10);
-}
-
-static void rtl8168ep_driver_stop(struct rtl8169_private *tp)
-{
-	rtl8168ep_stop_cmac(tp);
-	ocp_write(tp, 0x01, 0x180, OOB_CMD_DRIVER_STOP);
-	ocp_write(tp, 0x01, 0x30, ocp_read(tp, 0x01, 0x30) | 0x01);
-	rtl_msleep_loop_wait_low(tp, &rtl_ep_ocp_read_cond, 10, 10);
-}
-
-static void rtl8168_driver_stop(struct rtl8169_private *tp)
-{
-	switch (tp->mac_version) {
-	case RTL_GIGA_MAC_VER_27:
-	case RTL_GIGA_MAC_VER_28:
-	case RTL_GIGA_MAC_VER_31:
-		rtl8168dp_driver_stop(tp);
-		break;
-	case RTL_GIGA_MAC_VER_49:
-	case RTL_GIGA_MAC_VER_50:
-	case RTL_GIGA_MAC_VER_51:
-		rtl8168ep_driver_stop(tp);
-		break;
-	default:
-		BUG();
-		break;
-	}
-}
-
-static bool r8168dp_check_dash(struct rtl8169_private *tp)
-{
-	u16 reg = rtl8168_get_ocp_reg(tp);
-
-	return !!(ocp_read(tp, 0x0f, reg) & 0x00008000);
-}
-
-static bool r8168ep_check_dash(struct rtl8169_private *tp)
-{
-	return !!(ocp_read(tp, 0x0f, 0x128) & 0x00000001);
-}
-
-static bool r8168_check_dash(struct rtl8169_private *tp)
-{
-	switch (tp->mac_version) {
-	case RTL_GIGA_MAC_VER_27:
-	case RTL_GIGA_MAC_VER_28:
-	case RTL_GIGA_MAC_VER_31:
-		return r8168dp_check_dash(tp);
-	case RTL_GIGA_MAC_VER_49:
-	case RTL_GIGA_MAC_VER_50:
-	case RTL_GIGA_MAC_VER_51:
-		return r8168ep_check_dash(tp);
-	default:
-		return false;
-	}
-}
-
-struct exgmac_reg {
-	u16 addr;
-	u16 mask;
-	u32 val;
-};
-
-static void rtl_write_exgmac_batch(struct rtl8169_private *tp,
-				   const struct exgmac_reg *r, int len)
-{
-	while (len-- > 0) {
-		rtl_eri_write(tp, r->addr, r->mask, r->val, ERIAR_EXGMAC);
-		r++;
-	}
-}
-
-DECLARE_RTL_COND(rtl_efusear_cond)
-{
-	return RTL_R32(tp, EFUSEAR) & EFUSEAR_FLAG;
-}
-
-static u8 rtl8168d_efuse_read(struct rtl8169_private *tp, int reg_addr)
-{
-	RTL_W32(tp, EFUSEAR, (reg_addr & EFUSEAR_REG_MASK) << EFUSEAR_REG_SHIFT);
-
-	return rtl_udelay_loop_wait_high(tp, &rtl_efusear_cond, 100, 300) ?
-		RTL_R32(tp, EFUSEAR) & EFUSEAR_DATA_MASK : ~0;
-}
-
-static u16 rtl_get_events(struct rtl8169_private *tp)
-{
-	return RTL_R16(tp, IntrStatus);
-}
-
-static void rtl_ack_events(struct rtl8169_private *tp, u16 bits)
-{
-	RTL_W16(tp, IntrStatus, bits);
-	mmiowb();
-}
-
-static void rtl_irq_disable(struct rtl8169_private *tp)
-{
-	RTL_W16(tp, IntrMask, 0);
-	mmiowb();
-}
-
-static void rtl_irq_enable(struct rtl8169_private *tp, u16 bits)
-{
-	RTL_W16(tp, IntrMask, bits);
-}
-
-#define RTL_EVENT_NAPI_RX	(RxOK | RxErr)
-#define RTL_EVENT_NAPI_TX	(TxOK | TxErr)
-#define RTL_EVENT_NAPI		(RTL_EVENT_NAPI_RX | RTL_EVENT_NAPI_TX)
-
-static void rtl_irq_enable_all(struct rtl8169_private *tp)
-{
-	rtl_irq_enable(tp, RTL_EVENT_NAPI | tp->event_slow);
-}
-
-static void rtl8169_irq_mask_and_ack(struct rtl8169_private *tp)
-{
-	rtl_irq_disable(tp);
-	rtl_ack_events(tp, RTL_EVENT_NAPI | tp->event_slow);
-	RTL_R8(tp, ChipCmd);
-}
-
-static void rtl_link_chg_patch(struct rtl8169_private *tp)
-{
-	struct net_device *dev = tp->dev;
-	struct phy_device *phydev = dev->phydev;
-
-	if (!netif_running(dev))
-		return;
-
-	if (tp->mac_version == RTL_GIGA_MAC_VER_34 ||
-	    tp->mac_version == RTL_GIGA_MAC_VER_38) {
-		if (phydev->speed == SPEED_1000) {
-			rtl_eri_write(tp, 0x1bc, ERIAR_MASK_1111, 0x00000011,
-				      ERIAR_EXGMAC);
-			rtl_eri_write(tp, 0x1dc, ERIAR_MASK_1111, 0x00000005,
-				      ERIAR_EXGMAC);
-		} else if (phydev->speed == SPEED_100) {
-			rtl_eri_write(tp, 0x1bc, ERIAR_MASK_1111, 0x0000001f,
-				      ERIAR_EXGMAC);
-			rtl_eri_write(tp, 0x1dc, ERIAR_MASK_1111, 0x00000005,
-				      ERIAR_EXGMAC);
-		} else {
-			rtl_eri_write(tp, 0x1bc, ERIAR_MASK_1111, 0x0000001f,
-				      ERIAR_EXGMAC);
-			rtl_eri_write(tp, 0x1dc, ERIAR_MASK_1111, 0x0000003f,
-				      ERIAR_EXGMAC);
-		}
-		/* Reset packet filter */
-		rtl_w0w1_eri(tp, 0xdc, ERIAR_MASK_0001, 0x00, 0x01,
-			     ERIAR_EXGMAC);
-		rtl_w0w1_eri(tp, 0xdc, ERIAR_MASK_0001, 0x01, 0x00,
-			     ERIAR_EXGMAC);
-	} else if (tp->mac_version == RTL_GIGA_MAC_VER_35 ||
-		   tp->mac_version == RTL_GIGA_MAC_VER_36) {
-		if (phydev->speed == SPEED_1000) {
-			rtl_eri_write(tp, 0x1bc, ERIAR_MASK_1111, 0x00000011,
-				      ERIAR_EXGMAC);
-			rtl_eri_write(tp, 0x1dc, ERIAR_MASK_1111, 0x00000005,
-				      ERIAR_EXGMAC);
-		} else {
-			rtl_eri_write(tp, 0x1bc, ERIAR_MASK_1111, 0x0000001f,
-				      ERIAR_EXGMAC);
-			rtl_eri_write(tp, 0x1dc, ERIAR_MASK_1111, 0x0000003f,
-				      ERIAR_EXGMAC);
-		}
-	} else if (tp->mac_version == RTL_GIGA_MAC_VER_37) {
-		if (phydev->speed == SPEED_10) {
-			rtl_eri_write(tp, 0x1d0, ERIAR_MASK_0011, 0x4d02,
-				      ERIAR_EXGMAC);
-			rtl_eri_write(tp, 0x1dc, ERIAR_MASK_0011, 0x0060,
-				      ERIAR_EXGMAC);
-		} else {
-			rtl_eri_write(tp, 0x1d0, ERIAR_MASK_0011, 0x0000,
-				      ERIAR_EXGMAC);
-		}
-	}
-}
-
-#define WAKE_ANY (WAKE_PHY | WAKE_MAGIC | WAKE_UCAST | WAKE_BCAST | WAKE_MCAST)
-
-static u32 __rtl8169_get_wol(struct rtl8169_private *tp)
-{
-	u8 options;
-	u32 wolopts = 0;
-
-	options = RTL_R8(tp, Config1);
-	if (!(options & PMEnable))
-		return 0;
-
-	options = RTL_R8(tp, Config3);
-	if (options & LinkUp)
-		wolopts |= WAKE_PHY;
-	switch (tp->mac_version) {
-	case RTL_GIGA_MAC_VER_34 ... RTL_GIGA_MAC_VER_38:
-	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_51:
-		if (rtl_eri_read(tp, 0xdc, ERIAR_EXGMAC) & MagicPacket_v2)
-			wolopts |= WAKE_MAGIC;
-		break;
-	default:
-		if (options & MagicPacket)
-			wolopts |= WAKE_MAGIC;
-		break;
-	}
-
-	options = RTL_R8(tp, Config5);
-	if (options & UWF)
-		wolopts |= WAKE_UCAST;
-	if (options & BWF)
-		wolopts |= WAKE_BCAST;
-	if (options & MWF)
-		wolopts |= WAKE_MCAST;
-
-	return wolopts;
-}
-
-static void rtl8169_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
-{
-	struct rtl8169_private *tp = netdev_priv(dev);
-
-	rtl_lock_work(tp);
-	wol->supported = WAKE_ANY;
-	wol->wolopts = tp->saved_wolopts;
-	rtl_unlock_work(tp);
-}
-
-static void __rtl8169_set_wol(struct rtl8169_private *tp, u32 wolopts)
-{
-	unsigned int i, tmp;
-	static const struct {
-		u32 opt;
-		u16 reg;
-		u8  mask;
-	} cfg[] = {
-		{ WAKE_PHY,   Config3, LinkUp },
-		{ WAKE_UCAST, Config5, UWF },
-		{ WAKE_BCAST, Config5, BWF },
-		{ WAKE_MCAST, Config5, MWF },
-		{ WAKE_ANY,   Config5, LanWake },
-		{ WAKE_MAGIC, Config3, MagicPacket }
-	};
-	u8 options;
-
-	RTL_W8(tp, Cfg9346, Cfg9346_Unlock);
-
-	switch (tp->mac_version) {
-	case RTL_GIGA_MAC_VER_34 ... RTL_GIGA_MAC_VER_38:
-	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_51:
-		tmp = ARRAY_SIZE(cfg) - 1;
-		if (wolopts & WAKE_MAGIC)
-			rtl_w0w1_eri(tp,
-				     0x0dc,
-				     ERIAR_MASK_0100,
-				     MagicPacket_v2,
-				     0x0000,
-				     ERIAR_EXGMAC);
-		else
-			rtl_w0w1_eri(tp,
-				     0x0dc,
-				     ERIAR_MASK_0100,
-				     0x0000,
-				     MagicPacket_v2,
-				     ERIAR_EXGMAC);
-		break;
-	default:
-		tmp = ARRAY_SIZE(cfg);
-		break;
-	}
-
-	for (i = 0; i < tmp; i++) {
-		options = RTL_R8(tp, cfg[i].reg) & ~cfg[i].mask;
-		if (wolopts & cfg[i].opt)
-			options |= cfg[i].mask;
-		RTL_W8(tp, cfg[i].reg, options);
-	}
-
-	switch (tp->mac_version) {
-	case RTL_GIGA_MAC_VER_01 ... RTL_GIGA_MAC_VER_17:
-		options = RTL_R8(tp, Config1) & ~PMEnable;
-		if (wolopts)
-			options |= PMEnable;
-		RTL_W8(tp, Config1, options);
-		break;
-	default:
-		options = RTL_R8(tp, Config2) & ~PME_SIGNAL;
-		if (wolopts)
-			options |= PME_SIGNAL;
-		RTL_W8(tp, Config2, options);
-		break;
-	}
-
-	RTL_W8(tp, Cfg9346, Cfg9346_Lock);
-
-	device_set_wakeup_enable(tp_to_dev(tp), wolopts);
-}
-
-static int rtl8169_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
-{
-	struct rtl8169_private *tp = netdev_priv(dev);
-	struct device *d = tp_to_dev(tp);
-
-	if (wol->wolopts & ~WAKE_ANY)
-		return -EINVAL;
-
-	pm_runtime_get_noresume(d);
-
-	rtl_lock_work(tp);
-
-	tp->saved_wolopts = wol->wolopts;
-
-	if (pm_runtime_active(d))
-		__rtl8169_set_wol(tp, tp->saved_wolopts);
-
-	rtl_unlock_work(tp);
-
-	pm_runtime_put_noidle(d);
-
-	return 0;
-}
-
-static const char *rtl_lookup_firmware_name(struct rtl8169_private *tp)
-{
-	return rtl_chip_infos[tp->mac_version].fw_name;
-}
-
-static void rtl8169_get_drvinfo(struct net_device *dev,
-				struct ethtool_drvinfo *info)
-{
-	struct rtl8169_private *tp = netdev_priv(dev);
-	struct rtl_fw *rtl_fw = tp->rtl_fw;
-
-	strlcpy(info->driver, MODULENAME, sizeof(info->driver));
-	strlcpy(info->bus_info, pci_name(tp->pci_dev), sizeof(info->bus_info));
-	BUILD_BUG_ON(sizeof(info->fw_version) < sizeof(rtl_fw->version));
-	if (!IS_ERR_OR_NULL(rtl_fw))
-		strlcpy(info->fw_version, rtl_fw->version,
-			sizeof(info->fw_version));
-}
-
-static int rtl8169_get_regs_len(struct net_device *dev)
-{
-	return R8169_REGS_SIZE;
-}
-
-static netdev_features_t rtl8169_fix_features(struct net_device *dev,
-	netdev_features_t features)
-{
-	struct rtl8169_private *tp = netdev_priv(dev);
-
-	if (dev->mtu > TD_MSS_MAX)
-		features &= ~NETIF_F_ALL_TSO;
-
-	if (dev->mtu > JUMBO_1K &&
-	    tp->mac_version > RTL_GIGA_MAC_VER_06)
-		features &= ~NETIF_F_IP_CSUM;
-
-	return features;
-}
-
-static int rtl8169_set_features(struct net_device *dev,
-				netdev_features_t features)
-{
-	struct rtl8169_private *tp = netdev_priv(dev);
-	u32 rx_config;
-
-	rtl_lock_work(tp);
-
-	rx_config = RTL_R32(tp, RxConfig);
-	if (features & NETIF_F_RXALL)
-		rx_config |= (AcceptErr | AcceptRunt);
-	else
-		rx_config &= ~(AcceptErr | AcceptRunt);
-
-	RTL_W32(tp, RxConfig, rx_config);
-
-	if (features & NETIF_F_RXCSUM)
-		tp->cp_cmd |= RxChkSum;
-	else
-		tp->cp_cmd &= ~RxChkSum;
-
-	if (features & NETIF_F_HW_VLAN_CTAG_RX)
-		tp->cp_cmd |= RxVlan;
-	else
-		tp->cp_cmd &= ~RxVlan;
-
-	RTL_W16(tp, CPlusCmd, tp->cp_cmd);
-	RTL_R16(tp, CPlusCmd);
-
-	rtl_unlock_work(tp);
-
-	return 0;
-}
-
-static inline u32 rtl8169_tx_vlan_tag(struct sk_buff *skb)
-{
-	return (skb_vlan_tag_present(skb)) ?
-		TxVlanTag | swab16(skb_vlan_tag_get(skb)) : 0x00;
-}
-
-static void rtl8169_rx_vlan_tag(struct RxDesc *desc, struct sk_buff *skb)
-{
-	u32 opts2 = le32_to_cpu(desc->opts2);
-
-	if (opts2 & RxVlanTag)
-		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), swab16(opts2 & 0xffff));
-}
-
-static void rtl8169_get_regs(struct net_device *dev, struct ethtool_regs *regs,
-			     void *p)
-{
-	struct rtl8169_private *tp = netdev_priv(dev);
-	u32 __iomem *data = tp->mmio_addr;
-	u32 *dw = p;
-	int i;
-
-	rtl_lock_work(tp);
-	for (i = 0; i < R8169_REGS_SIZE; i += 4)
-		memcpy_fromio(dw++, data++, 4);
-	rtl_unlock_work(tp);
-}
-
-static u32 rtl8169_get_msglevel(struct net_device *dev)
-{
-	struct rtl8169_private *tp = netdev_priv(dev);
-
-	return tp->msg_enable;
-}
-
-static void rtl8169_set_msglevel(struct net_device *dev, u32 value)
-{
-	struct rtl8169_private *tp = netdev_priv(dev);
-
-	tp->msg_enable = value;
-}
-
-static const char rtl8169_gstrings[][ETH_GSTRING_LEN] = {
-	"tx_packets",
-	"rx_packets",
-	"tx_errors",
-	"rx_errors",
-	"rx_missed",
-	"align_errors",
-	"tx_single_collisions",
-	"tx_multi_collisions",
-	"unicast",
-	"broadcast",
-	"multicast",
-	"tx_aborted",
-	"tx_underrun",
-};
-
-static int rtl8169_get_sset_count(struct net_device *dev, int sset)
-{
-	switch (sset) {
-	case ETH_SS_STATS:
-		return ARRAY_SIZE(rtl8169_gstrings);
-	default:
-		return -EOPNOTSUPP;
-	}
-}
-
-DECLARE_RTL_COND(rtl_counters_cond)
-{
-	return RTL_R32(tp, CounterAddrLow) & (CounterReset | CounterDump);
-}
-
-static bool rtl8169_do_counters(struct rtl8169_private *tp, u32 counter_cmd)
-{
-	dma_addr_t paddr = tp->counters_phys_addr;
-	u32 cmd;
-
-	RTL_W32(tp, CounterAddrHigh, (u64)paddr >> 32);
-	RTL_R32(tp, CounterAddrHigh);
-	cmd = (u64)paddr & DMA_BIT_MASK(32);
-	RTL_W32(tp, CounterAddrLow, cmd);
-	RTL_W32(tp, CounterAddrLow, cmd | counter_cmd);
-
-	return rtl_udelay_loop_wait_low(tp, &rtl_counters_cond, 10, 1000);
-}
-
-static bool rtl8169_reset_counters(struct rtl8169_private *tp)
-{
-	/*
-	 * Versions prior to RTL_GIGA_MAC_VER_19 don't support resetting the
-	 * tally counters.
-	 */
-	if (tp->mac_version < RTL_GIGA_MAC_VER_19)
-		return true;
-
-	return rtl8169_do_counters(tp, CounterReset);
-}
-
-static bool rtl8169_update_counters(struct rtl8169_private *tp)
-{
-	u8 val = RTL_R8(tp, ChipCmd);
-
-	/*
-	 * Some chips are unable to dump tally counters when the receiver
-	 * is disabled. If 0xff chip may be in a PCI power-save state.
-	 */
-	if (!(val & CmdRxEnb) || val == 0xff)
-		return true;
-
-	return rtl8169_do_counters(tp, CounterDump);
-}
-
-static bool rtl8169_init_counter_offsets(struct rtl8169_private *tp)
-{
-	struct rtl8169_counters *counters = tp->counters;
-	bool ret = false;
-
-	/*
-	 * rtl8169_init_counter_offsets is called from rtl_open.  On chip
-	 * versions prior to RTL_GIGA_MAC_VER_19 the tally counters are only
-	 * reset by a power cycle, while the counter values collected by the
-	 * driver are reset at every driver unload/load cycle.
-	 *
-	 * To make sure the HW values returned by @get_stats64 match the SW
-	 * values, we collect the initial values at first open(*) and use them
-	 * as offsets to normalize the values returned by @get_stats64.
-	 *
-	 * (*) We can't call rtl8169_init_counter_offsets from rtl_init_one
-	 * for the reason stated in rtl8169_update_counters; CmdRxEnb is only
-	 * set at open time by rtl_hw_start.
-	 */
-
-	if (tp->tc_offset.inited)
-		return true;
-
-	/* If both, reset and update fail, propagate to caller. */
-	if (rtl8169_reset_counters(tp))
-		ret = true;
-
-	if (rtl8169_update_counters(tp))
-		ret = true;
-
-	tp->tc_offset.tx_errors = counters->tx_errors;
-	tp->tc_offset.tx_multi_collision = counters->tx_multi_collision;
-	tp->tc_offset.tx_aborted = counters->tx_aborted;
-	tp->tc_offset.inited = true;
-
-	return ret;
-}
-
-static void rtl8169_get_ethtool_stats(struct net_device *dev,
-				      struct ethtool_stats *stats, u64 *data)
-{
-	struct rtl8169_private *tp = netdev_priv(dev);
-	struct device *d = tp_to_dev(tp);
-	struct rtl8169_counters *counters = tp->counters;
-
-	ASSERT_RTNL();
-
-	pm_runtime_get_noresume(d);
-
-	if (pm_runtime_active(d))
-		rtl8169_update_counters(tp);
-
-	pm_runtime_put_noidle(d);
-
-	data[0] = le64_to_cpu(counters->tx_packets);
-	data[1] = le64_to_cpu(counters->rx_packets);
-	data[2] = le64_to_cpu(counters->tx_errors);
-	data[3] = le32_to_cpu(counters->rx_errors);
-	data[4] = le16_to_cpu(counters->rx_missed);
-	data[5] = le16_to_cpu(counters->align_errors);
-	data[6] = le32_to_cpu(counters->tx_one_collision);
-	data[7] = le32_to_cpu(counters->tx_multi_collision);
-	data[8] = le64_to_cpu(counters->rx_unicast);
-	data[9] = le64_to_cpu(counters->rx_broadcast);
-	data[10] = le32_to_cpu(counters->rx_multicast);
-	data[11] = le16_to_cpu(counters->tx_aborted);
-	data[12] = le16_to_cpu(counters->tx_underun);
-}
-
-static void rtl8169_get_strings(struct net_device *dev, u32 stringset, u8 *data)
-{
-	switch(stringset) {
-	case ETH_SS_STATS:
-		memcpy(data, rtl8169_gstrings, sizeof(rtl8169_gstrings));
-		break;
-	}
-}
-
-/*
- * Interrupt coalescing
- *
- * > 1 - the availability of the IntrMitigate (0xe2) register through the
- * >     8169, 8168 and 810x line of chipsets
- *
- * 8169, 8168, and 8136(810x) serial chipsets support it.
- *
- * > 2 - the Tx timer unit at gigabit speed
- *
- * The unit of the timer depends on both the speed and the setting of CPlusCmd
- * (0xe0) bit 1 and bit 0.
- *
- * For 8169
- * bit[1:0] \ speed        1000M           100M            10M
- * 0 0                     320ns           2.56us          40.96us
- * 0 1                     2.56us          20.48us         327.7us
- * 1 0                     5.12us          40.96us         655.4us
- * 1 1                     10.24us         81.92us         1.31ms
- *
- * For the other
- * bit[1:0] \ speed        1000M           100M            10M
- * 0 0                     5us             2.56us          40.96us
- * 0 1                     40us            20.48us         327.7us
- * 1 0                     80us            40.96us         655.4us
- * 1 1                     160us           81.92us         1.31ms
- */
-
-/* rx/tx scale factors for one particular CPlusCmd[0:1] value */
-struct rtl_coalesce_scale {
-	/* Rx / Tx */
-	u32 nsecs[2];
-};
-
-/* rx/tx scale factors for all CPlusCmd[0:1] cases */
-struct rtl_coalesce_info {
-	u32 speed;
-	struct rtl_coalesce_scale scalev[4];	/* each CPlusCmd[0:1] case */
-};
-
-/* produce (r,t) pairs with each being in series of *1, *8, *8*2, *8*2*2 */
-#define rxtx_x1822(r, t) {		\
-	{{(r),		(t)}},		\
-	{{(r)*8,	(t)*8}},	\
-	{{(r)*8*2,	(t)*8*2}},	\
-	{{(r)*8*2*2,	(t)*8*2*2}},	\
-}
-static const struct rtl_coalesce_info rtl_coalesce_info_8169[] = {
-	/* speed	delays:     rx00   tx00	*/
-	{ SPEED_10,	rxtx_x1822(40960, 40960)	},
-	{ SPEED_100,	rxtx_x1822( 2560,  2560)	},
-	{ SPEED_1000,	rxtx_x1822(  320,   320)	},
-	{ 0 },
-};
-
-static const struct rtl_coalesce_info rtl_coalesce_info_8168_8136[] = {
-	/* speed	delays:     rx00   tx00	*/
-	{ SPEED_10,	rxtx_x1822(40960, 40960)	},
-	{ SPEED_100,	rxtx_x1822( 2560,  2560)	},
-	{ SPEED_1000,	rxtx_x1822( 5000,  5000)	},
-	{ 0 },
-};
-#undef rxtx_x1822
-
-/* get rx/tx scale vector corresponding to current speed */
-static const struct rtl_coalesce_info *rtl_coalesce_info(struct net_device *dev)
-{
-	struct rtl8169_private *tp = netdev_priv(dev);
-	struct ethtool_link_ksettings ecmd;
-	const struct rtl_coalesce_info *ci;
-	int rc;
-
-	rc = phy_ethtool_get_link_ksettings(dev, &ecmd);
-	if (rc < 0)
-		return ERR_PTR(rc);
-
-	for (ci = tp->coalesce_info; ci->speed != 0; ci++) {
-		if (ecmd.base.speed == ci->speed) {
-			return ci;
-		}
-	}
-
-	return ERR_PTR(-ELNRNG);
-}
-
-static int rtl_get_coalesce(struct net_device *dev, struct ethtool_coalesce *ec)
-{
-	struct rtl8169_private *tp = netdev_priv(dev);
-	const struct rtl_coalesce_info *ci;
-	const struct rtl_coalesce_scale *scale;
-	struct {
-		u32 *max_frames;
-		u32 *usecs;
-	} coal_settings [] = {
-		{ &ec->rx_max_coalesced_frames, &ec->rx_coalesce_usecs },
-		{ &ec->tx_max_coalesced_frames, &ec->tx_coalesce_usecs }
-	}, *p = coal_settings;
-	int i;
-	u16 w;
-
-	memset(ec, 0, sizeof(*ec));
-
-	/* get rx/tx scale corresponding to current speed and CPlusCmd[0:1] */
-	ci = rtl_coalesce_info(dev);
-	if (IS_ERR(ci))
-		return PTR_ERR(ci);
-
-	scale = &ci->scalev[tp->cp_cmd & INTT_MASK];
-
-	/* read IntrMitigate and adjust according to scale */
-	for (w = RTL_R16(tp, IntrMitigate); w; w >>= RTL_COALESCE_SHIFT, p++) {
-		*p->max_frames = (w & RTL_COALESCE_MASK) << 2;
-		w >>= RTL_COALESCE_SHIFT;
-		*p->usecs = w & RTL_COALESCE_MASK;
-	}
-
-	for (i = 0; i < 2; i++) {
-		p = coal_settings + i;
-		*p->usecs = (*p->usecs * scale->nsecs[i]) / 1000;
-
-		/*
-		 * ethtool_coalesce says it is illegal to set both usecs and
-		 * max_frames to 0.
-		 */
-		if (!*p->usecs && !*p->max_frames)
-			*p->max_frames = 1;
-	}
-
-	return 0;
-}
-
-/* choose appropriate scale factor and CPlusCmd[0:1] for (speed, nsec) */
-static const struct rtl_coalesce_scale *rtl_coalesce_choose_scale(
-			struct net_device *dev, u32 nsec, u16 *cp01)
-{
-	const struct rtl_coalesce_info *ci;
-	u16 i;
-
-	ci = rtl_coalesce_info(dev);
-	if (IS_ERR(ci))
-		return ERR_CAST(ci);
-
-	for (i = 0; i < 4; i++) {
-		u32 rxtx_maxscale = max(ci->scalev[i].nsecs[0],
-					ci->scalev[i].nsecs[1]);
-		if (nsec <= rxtx_maxscale * RTL_COALESCE_T_MAX) {
-			*cp01 = i;
-			return &ci->scalev[i];
-		}
-	}
-
-	return ERR_PTR(-EINVAL);
-}
-
-static int rtl_set_coalesce(struct net_device *dev, struct ethtool_coalesce *ec)
-{
-	struct rtl8169_private *tp = netdev_priv(dev);
-	const struct rtl_coalesce_scale *scale;
-	struct {
-		u32 frames;
-		u32 usecs;
-	} coal_settings [] = {
-		{ ec->rx_max_coalesced_frames, ec->rx_coalesce_usecs },
-		{ ec->tx_max_coalesced_frames, ec->tx_coalesce_usecs }
-	}, *p = coal_settings;
-	u16 w = 0, cp01;
-	int i;
-
-	scale = rtl_coalesce_choose_scale(dev,
-			max(p[0].usecs, p[1].usecs) * 1000, &cp01);
-	if (IS_ERR(scale))
-		return PTR_ERR(scale);
-
-	for (i = 0; i < 2; i++, p++) {
-		u32 units;
-
-		/*
-		 * accept max_frames=1 we returned in rtl_get_coalesce.
-		 * accept it not only when usecs=0 because of e.g. the following scenario:
-		 *
-		 * - both rx_usecs=0 & rx_frames=0 in hardware (no delay on RX)
-		 * - rtl_get_coalesce returns rx_usecs=0, rx_frames=1
-		 * - then user does `ethtool -C eth0 rx-usecs 100`
-		 *
-		 * since ethtool sends to kernel whole ethtool_coalesce
-		 * settings, if we do not handle rx_usecs=!0, rx_frames=1
-		 * we'll reject it below in `frames % 4 != 0`.
-		 */
-		if (p->frames == 1) {
-			p->frames = 0;
-		}
-
-		units = p->usecs * 1000 / scale->nsecs[i];
-		if (p->frames > RTL_COALESCE_FRAME_MAX || p->frames % 4)
-			return -EINVAL;
-
-		w <<= RTL_COALESCE_SHIFT;
-		w |= units;
-		w <<= RTL_COALESCE_SHIFT;
-		w |= p->frames >> 2;
-	}
-
-	rtl_lock_work(tp);
-
-	RTL_W16(tp, IntrMitigate, swab16(w));
-
-	tp->cp_cmd = (tp->cp_cmd & ~INTT_MASK) | cp01;
-	RTL_W16(tp, CPlusCmd, tp->cp_cmd);
-	RTL_R16(tp, CPlusCmd);
-
-	rtl_unlock_work(tp);
-
-	return 0;
-}
-
-static const struct ethtool_ops rtl8169_ethtool_ops = {
-	.get_drvinfo		= rtl8169_get_drvinfo,
-	.get_regs_len		= rtl8169_get_regs_len,
-	.get_link		= ethtool_op_get_link,
-	.get_coalesce		= rtl_get_coalesce,
-	.set_coalesce		= rtl_set_coalesce,
-	.get_msglevel		= rtl8169_get_msglevel,
-	.set_msglevel		= rtl8169_set_msglevel,
-	.get_regs		= rtl8169_get_regs,
-	.get_wol		= rtl8169_get_wol,
-	.set_wol		= rtl8169_set_wol,
-	.get_strings		= rtl8169_get_strings,
-	.get_sset_count		= rtl8169_get_sset_count,
-	.get_ethtool_stats	= rtl8169_get_ethtool_stats,
-	.get_ts_info		= ethtool_op_get_ts_info,
-	.nway_reset		= phy_ethtool_nway_reset,
-	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
-	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
-};
-
-static void rtl8169_get_mac_version(struct rtl8169_private *tp,
-				    u8 default_version)
-{
-	/*
-	 * The driver currently handles the 8168Bf and the 8168Be identically
-	 * but they can be identified more specifically through the test below
-	 * if needed:
-	 *
-	 * (RTL_R32(tp, TxConfig) & 0x700000) == 0x500000 ? 8168Bf : 8168Be
-	 *
-	 * Same thing for the 8101Eb and the 8101Ec:
-	 *
-	 * (RTL_R32(tp, TxConfig) & 0x700000) == 0x200000 ? 8101Eb : 8101Ec
-	 */
-	static const struct rtl_mac_info {
-		u32 mask;
-		u32 val;
-		int mac_version;
-	} mac_info[] = {
-		/* 8168EP family. */
-		{ 0x7cf00000, 0x50200000,	RTL_GIGA_MAC_VER_51 },
-		{ 0x7cf00000, 0x50100000,	RTL_GIGA_MAC_VER_50 },
-		{ 0x7cf00000, 0x50000000,	RTL_GIGA_MAC_VER_49 },
-
-		/* 8168H family. */
-		{ 0x7cf00000, 0x54100000,	RTL_GIGA_MAC_VER_46 },
-		{ 0x7cf00000, 0x54000000,	RTL_GIGA_MAC_VER_45 },
-
-		/* 8168G family. */
-		{ 0x7cf00000, 0x5c800000,	RTL_GIGA_MAC_VER_44 },
-		{ 0x7cf00000, 0x50900000,	RTL_GIGA_MAC_VER_42 },
-		{ 0x7cf00000, 0x4c100000,	RTL_GIGA_MAC_VER_41 },
-		{ 0x7cf00000, 0x4c000000,	RTL_GIGA_MAC_VER_40 },
-
-		/* 8168F family. */
-		{ 0x7c800000, 0x48800000,	RTL_GIGA_MAC_VER_38 },
-		{ 0x7cf00000, 0x48100000,	RTL_GIGA_MAC_VER_36 },
-		{ 0x7cf00000, 0x48000000,	RTL_GIGA_MAC_VER_35 },
-
-		/* 8168E family. */
-		{ 0x7c800000, 0x2c800000,	RTL_GIGA_MAC_VER_34 },
-		{ 0x7cf00000, 0x2c100000,	RTL_GIGA_MAC_VER_32 },
-		{ 0x7c800000, 0x2c000000,	RTL_GIGA_MAC_VER_33 },
-
-		/* 8168D family. */
-		{ 0x7cf00000, 0x28100000,	RTL_GIGA_MAC_VER_25 },
-		{ 0x7c800000, 0x28000000,	RTL_GIGA_MAC_VER_26 },
-
-		/* 8168DP family. */
-		{ 0x7cf00000, 0x28800000,	RTL_GIGA_MAC_VER_27 },
-		{ 0x7cf00000, 0x28a00000,	RTL_GIGA_MAC_VER_28 },
-		{ 0x7cf00000, 0x28b00000,	RTL_GIGA_MAC_VER_31 },
-
-		/* 8168C family. */
-		{ 0x7cf00000, 0x3c900000,	RTL_GIGA_MAC_VER_23 },
-		{ 0x7cf00000, 0x3c800000,	RTL_GIGA_MAC_VER_18 },
-		{ 0x7c800000, 0x3c800000,	RTL_GIGA_MAC_VER_24 },
-		{ 0x7cf00000, 0x3c000000,	RTL_GIGA_MAC_VER_19 },
-		{ 0x7cf00000, 0x3c200000,	RTL_GIGA_MAC_VER_20 },
-		{ 0x7cf00000, 0x3c300000,	RTL_GIGA_MAC_VER_21 },
-		{ 0x7c800000, 0x3c000000,	RTL_GIGA_MAC_VER_22 },
-
-		/* 8168B family. */
-		{ 0x7cf00000, 0x38000000,	RTL_GIGA_MAC_VER_12 },
-		{ 0x7c800000, 0x38000000,	RTL_GIGA_MAC_VER_17 },
-		{ 0x7c800000, 0x30000000,	RTL_GIGA_MAC_VER_11 },
-
-		/* 8101 family. */
-		{ 0x7c800000, 0x44800000,	RTL_GIGA_MAC_VER_39 },
-		{ 0x7c800000, 0x44000000,	RTL_GIGA_MAC_VER_37 },
-		{ 0x7cf00000, 0x40900000,	RTL_GIGA_MAC_VER_29 },
-		{ 0x7c800000, 0x40800000,	RTL_GIGA_MAC_VER_30 },
-		{ 0x7cf00000, 0x34900000,	RTL_GIGA_MAC_VER_08 },
-		{ 0x7cf00000, 0x24900000,	RTL_GIGA_MAC_VER_08 },
-		{ 0x7cf00000, 0x34800000,	RTL_GIGA_MAC_VER_07 },
-		{ 0x7cf00000, 0x24800000,	RTL_GIGA_MAC_VER_07 },
-		{ 0x7cf00000, 0x34000000,	RTL_GIGA_MAC_VER_13 },
-		{ 0x7cf00000, 0x34300000,	RTL_GIGA_MAC_VER_10 },
-		{ 0x7cf00000, 0x34200000,	RTL_GIGA_MAC_VER_16 },
-		{ 0x7c800000, 0x34800000,	RTL_GIGA_MAC_VER_09 },
-		{ 0x7c800000, 0x24800000,	RTL_GIGA_MAC_VER_09 },
-		{ 0x7c800000, 0x34000000,	RTL_GIGA_MAC_VER_16 },
-		/* FIXME: where did these entries come from ? -- FR */
-		{ 0xfc800000, 0x38800000,	RTL_GIGA_MAC_VER_15 },
-		{ 0xfc800000, 0x30800000,	RTL_GIGA_MAC_VER_14 },
-
-		/* 8110 family. */
-		{ 0xfc800000, 0x98000000,	RTL_GIGA_MAC_VER_06 },
-		{ 0xfc800000, 0x18000000,	RTL_GIGA_MAC_VER_05 },
-		{ 0xfc800000, 0x10000000,	RTL_GIGA_MAC_VER_04 },
-		{ 0xfc800000, 0x04000000,	RTL_GIGA_MAC_VER_03 },
-		{ 0xfc800000, 0x00800000,	RTL_GIGA_MAC_VER_02 },
-		{ 0xfc800000, 0x00000000,	RTL_GIGA_MAC_VER_01 },
-
-		/* Catch-all */
-		{ 0x00000000, 0x00000000,	RTL_GIGA_MAC_NONE   }
-	};
-	const struct rtl_mac_info *p = mac_info;
-	u32 reg;
-
-	reg = RTL_R32(tp, TxConfig);
-	while ((reg & p->mask) != p->val)
-		p++;
-	tp->mac_version = p->mac_version;
-
-	if (tp->mac_version == RTL_GIGA_MAC_NONE) {
-		dev_notice(tp_to_dev(tp),
-			   "unknown MAC, using family default\n");
-		tp->mac_version = default_version;
-	} else if (tp->mac_version == RTL_GIGA_MAC_VER_42) {
-		tp->mac_version = tp->supports_gmii ?
-				  RTL_GIGA_MAC_VER_42 :
-				  RTL_GIGA_MAC_VER_43;
-	} else if (tp->mac_version == RTL_GIGA_MAC_VER_45) {
-		tp->mac_version = tp->supports_gmii ?
-				  RTL_GIGA_MAC_VER_45 :
-				  RTL_GIGA_MAC_VER_47;
-	} else if (tp->mac_version == RTL_GIGA_MAC_VER_46) {
-		tp->mac_version = tp->supports_gmii ?
-				  RTL_GIGA_MAC_VER_46 :
-				  RTL_GIGA_MAC_VER_48;
-	}
-}
-
-static void rtl8169_print_mac_version(struct rtl8169_private *tp)
-{
-	netif_dbg(tp, drv, tp->dev, "mac_version = 0x%02x\n", tp->mac_version);
-}
-
-struct phy_reg {
-	u16 reg;
-	u16 val;
-};
-
-static void rtl_writephy_batch(struct rtl8169_private *tp,
-			       const struct phy_reg *regs, int len)
-{
-	while (len-- > 0) {
-		rtl_writephy(tp, regs->reg, regs->val);
-		regs++;
-	}
-}
-
-#define PHY_READ		0x00000000
-#define PHY_DATA_OR		0x10000000
-#define PHY_DATA_AND		0x20000000
-#define PHY_BJMPN		0x30000000
-#define PHY_MDIO_CHG		0x40000000
-#define PHY_CLEAR_READCOUNT	0x70000000
-#define PHY_WRITE		0x80000000
-#define PHY_READCOUNT_EQ_SKIP	0x90000000
-#define PHY_COMP_EQ_SKIPN	0xa0000000
-#define PHY_COMP_NEQ_SKIPN	0xb0000000
-#define PHY_WRITE_PREVIOUS	0xc0000000
-#define PHY_SKIPN		0xd0000000
-#define PHY_DELAY_MS		0xe0000000
-
-struct fw_info {
-	u32	magic;
-	char	version[RTL_VER_SIZE];
-	__le32	fw_start;
-	__le32	fw_len;
-	u8	chksum;
-} __packed;
-
-#define FW_OPCODE_SIZE	sizeof(typeof(*((struct rtl_fw_phy_action *)0)->code))
-
-static bool rtl_fw_format_ok(struct rtl8169_private *tp, struct rtl_fw *rtl_fw)
-{
-	const struct firmware *fw = rtl_fw->fw;
-	struct fw_info *fw_info = (struct fw_info *)fw->data;
-	struct rtl_fw_phy_action *pa = &rtl_fw->phy_action;
-	char *version = rtl_fw->version;
-	bool rc = false;
-
-	if (fw->size < FW_OPCODE_SIZE)
-		goto out;
-
-	if (!fw_info->magic) {
-		size_t i, size, start;
-		u8 checksum = 0;
-
-		if (fw->size < sizeof(*fw_info))
-			goto out;
-
-		for (i = 0; i < fw->size; i++)
-			checksum += fw->data[i];
-		if (checksum != 0)
-			goto out;
-
-		start = le32_to_cpu(fw_info->fw_start);
-		if (start > fw->size)
-			goto out;
-
-		size = le32_to_cpu(fw_info->fw_len);
-		if (size > (fw->size - start) / FW_OPCODE_SIZE)
-			goto out;
-
-		memcpy(version, fw_info->version, RTL_VER_SIZE);
-
-		pa->code = (__le32 *)(fw->data + start);
-		pa->size = size;
-	} else {
-		if (fw->size % FW_OPCODE_SIZE)
-			goto out;
-
-		strlcpy(version, rtl_lookup_firmware_name(tp), RTL_VER_SIZE);
-
-		pa->code = (__le32 *)fw->data;
-		pa->size = fw->size / FW_OPCODE_SIZE;
-	}
-	version[RTL_VER_SIZE - 1] = 0;
-
-	rc = true;
-out:
-	return rc;
-}
-
-static bool rtl_fw_data_ok(struct rtl8169_private *tp, struct net_device *dev,
-			   struct rtl_fw_phy_action *pa)
-{
-	bool rc = false;
-	size_t index;
-
-	for (index = 0; index < pa->size; index++) {
-		u32 action = le32_to_cpu(pa->code[index]);
-		u32 regno = (action & 0x0fff0000) >> 16;
-
-		switch(action & 0xf0000000) {
-		case PHY_READ:
-		case PHY_DATA_OR:
-		case PHY_DATA_AND:
-		case PHY_MDIO_CHG:
-		case PHY_CLEAR_READCOUNT:
-		case PHY_WRITE:
-		case PHY_WRITE_PREVIOUS:
-		case PHY_DELAY_MS:
-			break;
-
-		case PHY_BJMPN:
-			if (regno > index) {
-				netif_err(tp, ifup, tp->dev,
-					  "Out of range of firmware\n");
-				goto out;
-			}
-			break;
-		case PHY_READCOUNT_EQ_SKIP:
-			if (index + 2 >= pa->size) {
-				netif_err(tp, ifup, tp->dev,
-					  "Out of range of firmware\n");
-				goto out;
-			}
-			break;
-		case PHY_COMP_EQ_SKIPN:
-		case PHY_COMP_NEQ_SKIPN:
-		case PHY_SKIPN:
-			if (index + 1 + regno >= pa->size) {
-				netif_err(tp, ifup, tp->dev,
-					  "Out of range of firmware\n");
-				goto out;
-			}
-			break;
-
-		default:
-			netif_err(tp, ifup, tp->dev,
-				  "Invalid action 0x%08x\n", action);
-			goto out;
-		}
-	}
-	rc = true;
-out:
-	return rc;
-}
-
-static int rtl_check_firmware(struct rtl8169_private *tp, struct rtl_fw *rtl_fw)
-{
-	struct net_device *dev = tp->dev;
-	int rc = -EINVAL;
-
-	if (!rtl_fw_format_ok(tp, rtl_fw)) {
-		netif_err(tp, ifup, dev, "invalid firmware\n");
-		goto out;
-	}
-
-	if (rtl_fw_data_ok(tp, dev, &rtl_fw->phy_action))
-		rc = 0;
-out:
-	return rc;
-}
-
-static void rtl_phy_write_fw(struct rtl8169_private *tp, struct rtl_fw *rtl_fw)
-{
-	struct rtl_fw_phy_action *pa = &rtl_fw->phy_action;
-	struct mdio_ops org, *ops = &tp->mdio_ops;
-	u32 predata, count;
-	size_t index;
-
-	predata = count = 0;
-	org.write = ops->write;
-	org.read = ops->read;
-
-	for (index = 0; index < pa->size; ) {
-		u32 action = le32_to_cpu(pa->code[index]);
-		u32 data = action & 0x0000ffff;
-		u32 regno = (action & 0x0fff0000) >> 16;
-
-		if (!action)
-			break;
-
-		switch(action & 0xf0000000) {
-		case PHY_READ:
-			predata = rtl_readphy(tp, regno);
-			count++;
-			index++;
-			break;
-		case PHY_DATA_OR:
-			predata |= data;
-			index++;
-			break;
-		case PHY_DATA_AND:
-			predata &= data;
-			index++;
-			break;
-		case PHY_BJMPN:
-			index -= regno;
-			break;
-		case PHY_MDIO_CHG:
-			if (data == 0) {
-				ops->write = org.write;
-				ops->read = org.read;
-			} else if (data == 1) {
-				ops->write = mac_mcu_write;
-				ops->read = mac_mcu_read;
-			}
-
-			index++;
-			break;
-		case PHY_CLEAR_READCOUNT:
-			count = 0;
-			index++;
-			break;
-		case PHY_WRITE:
-			rtl_writephy(tp, regno, data);
-			index++;
-			break;
-		case PHY_READCOUNT_EQ_SKIP:
-			index += (count == data) ? 2 : 1;
-			break;
-		case PHY_COMP_EQ_SKIPN:
-			if (predata == data)
-				index += regno;
-			index++;
-			break;
-		case PHY_COMP_NEQ_SKIPN:
-			if (predata != data)
-				index += regno;
-			index++;
-			break;
-		case PHY_WRITE_PREVIOUS:
-			rtl_writephy(tp, regno, predata);
-			index++;
-			break;
-		case PHY_SKIPN:
-			index += regno + 1;
-			break;
-		case PHY_DELAY_MS:
-			mdelay(data);
-			index++;
-			break;
-
-		default:
-			BUG();
-		}
-	}
-
-	ops->write = org.write;
-	ops->read = org.read;
-}
-
-static void rtl_release_firmware(struct rtl8169_private *tp)
-{
-	if (!IS_ERR_OR_NULL(tp->rtl_fw)) {
-		release_firmware(tp->rtl_fw->fw);
-		kfree(tp->rtl_fw);
-	}
-	tp->rtl_fw = RTL_FIRMWARE_UNKNOWN;
-}
-
-static void rtl_apply_firmware(struct rtl8169_private *tp)
-{
-	struct rtl_fw *rtl_fw = tp->rtl_fw;
-
-	/* TODO: release firmware once rtl_phy_write_fw signals failures. */
-	if (!IS_ERR_OR_NULL(rtl_fw))
-		rtl_phy_write_fw(tp, rtl_fw);
-}
-
-static void rtl_apply_firmware_cond(struct rtl8169_private *tp, u8 reg, u16 val)
-{
-	if (rtl_readphy(tp, reg) != val)
-		netif_warn(tp, hw, tp->dev, "chipset not ready for firmware\n");
-	else
-		rtl_apply_firmware(tp);
-}
-
-static void rtl8169s_hw_phy_config(struct rtl8169_private *tp)
-{
-	static const struct phy_reg phy_reg_init[] = {
-		{ 0x1f, 0x0001 },
-		{ 0x06, 0x006e },
-		{ 0x08, 0x0708 },
-		{ 0x15, 0x4000 },
-		{ 0x18, 0x65c7 },
-
-		{ 0x1f, 0x0001 },
-		{ 0x03, 0x00a1 },
-		{ 0x02, 0x0008 },
-		{ 0x01, 0x0120 },
-		{ 0x00, 0x1000 },
-		{ 0x04, 0x0800 },
-		{ 0x04, 0x0000 },
-
-		{ 0x03, 0xff41 },
-		{ 0x02, 0xdf60 },
-		{ 0x01, 0x0140 },
-		{ 0x00, 0x0077 },
-		{ 0x04, 0x7800 },
-		{ 0x04, 0x7000 },
-
-		{ 0x03, 0x802f },
-		{ 0x02, 0x4f02 },
-		{ 0x01, 0x0409 },
-		{ 0x00, 0xf0f9 },
-		{ 0x04, 0x9800 },
-		{ 0x04, 0x9000 },
-
-		{ 0x03, 0xdf01 },
-		{ 0x02, 0xdf20 },
-		{ 0x01, 0xff95 },
-		{ 0x00, 0xba00 },
-		{ 0x04, 0xa800 },
-		{ 0x04, 0xa000 },
-
-		{ 0x03, 0xff41 },
-		{ 0x02, 0xdf20 },
-		{ 0x01, 0x0140 },
-		{ 0x00, 0x00bb },
-		{ 0x04, 0xb800 },
-		{ 0x04, 0xb000 },
-
-		{ 0x03, 0xdf41 },
-		{ 0x02, 0xdc60 },
-		{ 0x01, 0x6340 },
-		{ 0x00, 0x007d },
-		{ 0x04, 0xd800 },
-		{ 0x04, 0xd000 },
-
-		{ 0x03, 0xdf01 },
-		{ 0x02, 0xdf20 },
-		{ 0x01, 0x100a },
-		{ 0x00, 0xa0ff },
-		{ 0x04, 0xf800 },
-		{ 0x04, 0xf000 },
-
-		{ 0x1f, 0x0000 },
-		{ 0x0b, 0x0000 },
-		{ 0x00, 0x9200 }
-	};
-
-	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
-}
-
-static void rtl8169sb_hw_phy_config(struct rtl8169_private *tp)
-{
-	static const struct phy_reg phy_reg_init[] = {
-		{ 0x1f, 0x0002 },
-		{ 0x01, 0x90d0 },
-		{ 0x1f, 0x0000 }
-	};
-
-	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
-}
-
-static void rtl8169scd_hw_phy_config_quirk(struct rtl8169_private *tp)
-{
-	struct pci_dev *pdev = tp->pci_dev;
-
-	if ((pdev->subsystem_vendor != PCI_VENDOR_ID_GIGABYTE) ||
-	    (pdev->subsystem_device != 0xe000))
-		return;
-
-	rtl_writephy(tp, 0x1f, 0x0001);
-	rtl_writephy(tp, 0x10, 0xf01b);
-	rtl_writephy(tp, 0x1f, 0x0000);
-}
-
-static void rtl8169scd_hw_phy_config(struct rtl8169_private *tp)
-{
-	static const struct phy_reg phy_reg_init[] = {
-		{ 0x1f, 0x0001 },
-		{ 0x04, 0x0000 },
-		{ 0x03, 0x00a1 },
-		{ 0x02, 0x0008 },
-		{ 0x01, 0x0120 },
-		{ 0x00, 0x1000 },
-		{ 0x04, 0x0800 },
-		{ 0x04, 0x9000 },
-		{ 0x03, 0x802f },
-		{ 0x02, 0x4f02 },
-		{ 0x01, 0x0409 },
-		{ 0x00, 0xf099 },
-		{ 0x04, 0x9800 },
-		{ 0x04, 0xa000 },
-		{ 0x03, 0xdf01 },
-		{ 0x02, 0xdf20 },
-		{ 0x01, 0xff95 },
-		{ 0x00, 0xba00 },
-		{ 0x04, 0xa800 },
-		{ 0x04, 0xf000 },
-		{ 0x03, 0xdf01 },
-		{ 0x02, 0xdf20 },
-		{ 0x01, 0x101a },
-		{ 0x00, 0xa0ff },
-		{ 0x04, 0xf800 },
-		{ 0x04, 0x0000 },
-		{ 0x1f, 0x0000 },
-
-		{ 0x1f, 0x0001 },
-		{ 0x10, 0xf41b },
-		{ 0x14, 0xfb54 },
-		{ 0x18, 0xf5c7 },
-		{ 0x1f, 0x0000 },
-
-		{ 0x1f, 0x0001 },
-		{ 0x17, 0x0cc0 },
-		{ 0x1f, 0x0000 }
-	};
-
-	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
-
-	rtl8169scd_hw_phy_config_quirk(tp);
-}
-
-static void rtl8169sce_hw_phy_config(struct rtl8169_private *tp)
-{
-	static const struct phy_reg phy_reg_init[] = {
-		{ 0x1f, 0x0001 },
-		{ 0x04, 0x0000 },
-		{ 0x03, 0x00a1 },
-		{ 0x02, 0x0008 },
-		{ 0x01, 0x0120 },
-		{ 0x00, 0x1000 },
-		{ 0x04, 0x0800 },
-		{ 0x04, 0x9000 },
-		{ 0x03, 0x802f },
-		{ 0x02, 0x4f02 },
-		{ 0x01, 0x0409 },
-		{ 0x00, 0xf099 },
-		{ 0x04, 0x9800 },
-		{ 0x04, 0xa000 },
-		{ 0x03, 0xdf01 },
-		{ 0x02, 0xdf20 },
-		{ 0x01, 0xff95 },
-		{ 0x00, 0xba00 },
-		{ 0x04, 0xa800 },
-		{ 0x04, 0xf000 },
-		{ 0x03, 0xdf01 },
-		{ 0x02, 0xdf20 },
-		{ 0x01, 0x101a },
-		{ 0x00, 0xa0ff },
-		{ 0x04, 0xf800 },
-		{ 0x04, 0x0000 },
-		{ 0x1f, 0x0000 },
-
-		{ 0x1f, 0x0001 },
-		{ 0x0b, 0x8480 },
-		{ 0x1f, 0x0000 },
-
-		{ 0x1f, 0x0001 },
-		{ 0x18, 0x67c7 },
-		{ 0x04, 0x2000 },
-		{ 0x03, 0x002f },
-		{ 0x02, 0x4360 },
-		{ 0x01, 0x0109 },
-		{ 0x00, 0x3022 },
-		{ 0x04, 0x2800 },
-		{ 0x1f, 0x0000 },
-
-		{ 0x1f, 0x0001 },
-		{ 0x17, 0x0cc0 },
-		{ 0x1f, 0x0000 }
-	};
-
-	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
-}
-
-static void rtl8168bb_hw_phy_config(struct rtl8169_private *tp)
-{
-	static const struct phy_reg phy_reg_init[] = {
-		{ 0x10, 0xf41b },
-		{ 0x1f, 0x0000 }
-	};
-
-	rtl_writephy(tp, 0x1f, 0x0001);
-	rtl_patchphy(tp, 0x16, 1 << 0);
-
-	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
-}
-
-static void rtl8168bef_hw_phy_config(struct rtl8169_private *tp)
-{
-	static const struct phy_reg phy_reg_init[] = {
-		{ 0x1f, 0x0001 },
-		{ 0x10, 0xf41b },
-		{ 0x1f, 0x0000 }
-	};
-
-	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
-}
-
-static void rtl8168cp_1_hw_phy_config(struct rtl8169_private *tp)
-{
-	static const struct phy_reg phy_reg_init[] = {
-		{ 0x1f, 0x0000 },
-		{ 0x1d, 0x0f00 },
-		{ 0x1f, 0x0002 },
-		{ 0x0c, 0x1ec8 },
-		{ 0x1f, 0x0000 }
-	};
-
-	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
-}
-
-static void rtl8168cp_2_hw_phy_config(struct rtl8169_private *tp)
-{
-	static const struct phy_reg phy_reg_init[] = {
-		{ 0x1f, 0x0001 },
-		{ 0x1d, 0x3d98 },
-		{ 0x1f, 0x0000 }
-	};
-
-	rtl_writephy(tp, 0x1f, 0x0000);
-	rtl_patchphy(tp, 0x14, 1 << 5);
-	rtl_patchphy(tp, 0x0d, 1 << 5);
-
-	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
-}
-
-static void rtl8168c_1_hw_phy_config(struct rtl8169_private *tp)
-{
-	static const struct phy_reg phy_reg_init[] = {
-		{ 0x1f, 0x0001 },
-		{ 0x12, 0x2300 },
-		{ 0x1f, 0x0002 },
-		{ 0x00, 0x88d4 },
-		{ 0x01, 0x82b1 },
-		{ 0x03, 0x7002 },
-		{ 0x08, 0x9e30 },
-		{ 0x09, 0x01f0 },
-		{ 0x0a, 0x5500 },
-		{ 0x0c, 0x00c8 },
-		{ 0x1f, 0x0003 },
-		{ 0x12, 0xc096 },
-		{ 0x16, 0x000a },
-		{ 0x1f, 0x0000 },
-		{ 0x1f, 0x0000 },
-		{ 0x09, 0x2000 },
-		{ 0x09, 0x0000 }
-	};
-
-	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
-
-	rtl_patchphy(tp, 0x14, 1 << 5);
-	rtl_patchphy(tp, 0x0d, 1 << 5);
-	rtl_writephy(tp, 0x1f, 0x0000);
-}
-
-static void rtl8168c_2_hw_phy_config(struct rtl8169_private *tp)
-{
-	static const struct phy_reg phy_reg_init[] = {
-		{ 0x1f, 0x0001 },
-		{ 0x12, 0x2300 },
-		{ 0x03, 0x802f },
-		{ 0x02, 0x4f02 },
-		{ 0x01, 0x0409 },
-		{ 0x00, 0xf099 },
-		{ 0x04, 0x9800 },
-		{ 0x04, 0x9000 },
-		{ 0x1d, 0x3d98 },
-		{ 0x1f, 0x0002 },
-		{ 0x0c, 0x7eb8 },
-		{ 0x06, 0x0761 },
-		{ 0x1f, 0x0003 },
-		{ 0x16, 0x0f0a },
-		{ 0x1f, 0x0000 }
-	};
-
-	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
-
-	rtl_patchphy(tp, 0x16, 1 << 0);
-	rtl_patchphy(tp, 0x14, 1 << 5);
-	rtl_patchphy(tp, 0x0d, 1 << 5);
-	rtl_writephy(tp, 0x1f, 0x0000);
-}
-
-static void rtl8168c_3_hw_phy_config(struct rtl8169_private *tp)
-{
-	static const struct phy_reg phy_reg_init[] = {
-		{ 0x1f, 0x0001 },
-		{ 0x12, 0x2300 },
-		{ 0x1d, 0x3d98 },
-		{ 0x1f, 0x0002 },
-		{ 0x0c, 0x7eb8 },
-		{ 0x06, 0x5461 },
-		{ 0x1f, 0x0003 },
-		{ 0x16, 0x0f0a },
-		{ 0x1f, 0x0000 }
-	};
-
-	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
-
-	rtl_patchphy(tp, 0x16, 1 << 0);
-	rtl_patchphy(tp, 0x14, 1 << 5);
-	rtl_patchphy(tp, 0x0d, 1 << 5);
-	rtl_writephy(tp, 0x1f, 0x0000);
-}
-
-static void rtl8168c_4_hw_phy_config(struct rtl8169_private *tp)
-{
-	rtl8168c_3_hw_phy_config(tp);
-}
-
-static void rtl8168d_1_hw_phy_config(struct rtl8169_private *tp)
-{
-	static const struct phy_reg phy_reg_init_0[] = {
-		/* Channel Estimation */
-		{ 0x1f, 0x0001 },
-		{ 0x06, 0x4064 },
-		{ 0x07, 0x2863 },
-		{ 0x08, 0x059c },
-		{ 0x09, 0x26b4 },
-		{ 0x0a, 0x6a19 },
-		{ 0x0b, 0xdcc8 },
-		{ 0x10, 0xf06d },
-		{ 0x14, 0x7f68 },
-		{ 0x18, 0x7fd9 },
-		{ 0x1c, 0xf0ff },
-		{ 0x1d, 0x3d9c },
-		{ 0x1f, 0x0003 },
-		{ 0x12, 0xf49f },
-		{ 0x13, 0x070b },
-		{ 0x1a, 0x05ad },
-		{ 0x14, 0x94c0 },
-
-		/*
-		 * Tx Error Issue
-		 * Enhance line driver power
-		 */
-		{ 0x1f, 0x0002 },
-		{ 0x06, 0x5561 },
-		{ 0x1f, 0x0005 },
-		{ 0x05, 0x8332 },
-		{ 0x06, 0x5561 },
-
-		/*
-		 * Can not link to 1Gbps with bad cable
-		 * Decrease SNR threshold form 21.07dB to 19.04dB
-		 */
-		{ 0x1f, 0x0001 },
-		{ 0x17, 0x0cc0 },
-
-		{ 0x1f, 0x0000 },
-		{ 0x0d, 0xf880 }
-	};
-
-	rtl_writephy_batch(tp, phy_reg_init_0, ARRAY_SIZE(phy_reg_init_0));
-
-	/*
-	 * Rx Error Issue
-	 * Fine Tune Switching regulator parameter
-	 */
-	rtl_writephy(tp, 0x1f, 0x0002);
-	rtl_w0w1_phy(tp, 0x0b, 0x0010, 0x00ef);
-	rtl_w0w1_phy(tp, 0x0c, 0xa200, 0x5d00);
-
-	if (rtl8168d_efuse_read(tp, 0x01) == 0xb1) {
-		static const struct phy_reg phy_reg_init[] = {
-			{ 0x1f, 0x0002 },
-			{ 0x05, 0x669a },
-			{ 0x1f, 0x0005 },
-			{ 0x05, 0x8330 },
-			{ 0x06, 0x669a },
-			{ 0x1f, 0x0002 }
-		};
-		int val;
-
-		rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
-
-		val = rtl_readphy(tp, 0x0d);
-
-		if ((val & 0x00ff) != 0x006c) {
-			static const u32 set[] = {
-				0x0065, 0x0066, 0x0067, 0x0068,
-				0x0069, 0x006a, 0x006b, 0x006c
-			};
-			int i;
-
-			rtl_writephy(tp, 0x1f, 0x0002);
-
-			val &= 0xff00;
-			for (i = 0; i < ARRAY_SIZE(set); i++)
-				rtl_writephy(tp, 0x0d, val | set[i]);
-		}
-	} else {
-		static const struct phy_reg phy_reg_init[] = {
-			{ 0x1f, 0x0002 },
-			{ 0x05, 0x6662 },
-			{ 0x1f, 0x0005 },
-			{ 0x05, 0x8330 },
-			{ 0x06, 0x6662 }
-		};
-
-		rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
-	}
-
-	/* RSET couple improve */
-	rtl_writephy(tp, 0x1f, 0x0002);
-	rtl_patchphy(tp, 0x0d, 0x0300);
-	rtl_patchphy(tp, 0x0f, 0x0010);
-
-	/* Fine tune PLL performance */
-	rtl_writephy(tp, 0x1f, 0x0002);
-	rtl_w0w1_phy(tp, 0x02, 0x0100, 0x0600);
-	rtl_w0w1_phy(tp, 0x03, 0x0000, 0xe000);
-
-	rtl_writephy(tp, 0x1f, 0x0005);
-	rtl_writephy(tp, 0x05, 0x001b);
-
-	rtl_apply_firmware_cond(tp, MII_EXPANSION, 0xbf00);
-
-	rtl_writephy(tp, 0x1f, 0x0000);
-}
-
-static void rtl8168d_2_hw_phy_config(struct rtl8169_private *tp)
-{
-	static const struct phy_reg phy_reg_init_0[] = {
-		/* Channel Estimation */
-		{ 0x1f, 0x0001 },
-		{ 0x06, 0x4064 },
-		{ 0x07, 0x2863 },
-		{ 0x08, 0x059c },
-		{ 0x09, 0x26b4 },
-		{ 0x0a, 0x6a19 },
-		{ 0x0b, 0xdcc8 },
-		{ 0x10, 0xf06d },
-		{ 0x14, 0x7f68 },
-		{ 0x18, 0x7fd9 },
-		{ 0x1c, 0xf0ff },
-		{ 0x1d, 0x3d9c },
-		{ 0x1f, 0x0003 },
-		{ 0x12, 0xf49f },
-		{ 0x13, 0x070b },
-		{ 0x1a, 0x05ad },
-		{ 0x14, 0x94c0 },
-
-		/*
-		 * Tx Error Issue
-		 * Enhance line driver power
-		 */
-		{ 0x1f, 0x0002 },
-		{ 0x06, 0x5561 },
-		{ 0x1f, 0x0005 },
-		{ 0x05, 0x8332 },
-		{ 0x06, 0x5561 },
-
-		/*
-		 * Can not link to 1Gbps with bad cable
-		 * Decrease SNR threshold form 21.07dB to 19.04dB
-		 */
-		{ 0x1f, 0x0001 },
-		{ 0x17, 0x0cc0 },
-
-		{ 0x1f, 0x0000 },
-		{ 0x0d, 0xf880 }
-	};
-
-	rtl_writephy_batch(tp, phy_reg_init_0, ARRAY_SIZE(phy_reg_init_0));
-
-	if (rtl8168d_efuse_read(tp, 0x01) == 0xb1) {
-		static const struct phy_reg phy_reg_init[] = {
-			{ 0x1f, 0x0002 },
-			{ 0x05, 0x669a },
-			{ 0x1f, 0x0005 },
-			{ 0x05, 0x8330 },
-			{ 0x06, 0x669a },
-
-			{ 0x1f, 0x0002 }
-		};
-		int val;
-
-		rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
-
-		val = rtl_readphy(tp, 0x0d);
-		if ((val & 0x00ff) != 0x006c) {
-			static const u32 set[] = {
-				0x0065, 0x0066, 0x0067, 0x0068,
-				0x0069, 0x006a, 0x006b, 0x006c
-			};
-			int i;
-
-			rtl_writephy(tp, 0x1f, 0x0002);
-
-			val &= 0xff00;
-			for (i = 0; i < ARRAY_SIZE(set); i++)
-				rtl_writephy(tp, 0x0d, val | set[i]);
-		}
-	} else {
-		static const struct phy_reg phy_reg_init[] = {
-			{ 0x1f, 0x0002 },
-			{ 0x05, 0x2642 },
-			{ 0x1f, 0x0005 },
-			{ 0x05, 0x8330 },
-			{ 0x06, 0x2642 }
-		};
-
-		rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
-	}
-
-	/* Fine tune PLL performance */
-	rtl_writephy(tp, 0x1f, 0x0002);
-	rtl_w0w1_phy(tp, 0x02, 0x0100, 0x0600);
-	rtl_w0w1_phy(tp, 0x03, 0x0000, 0xe000);
-
-	/* Switching regulator Slew rate */
-	rtl_writephy(tp, 0x1f, 0x0002);
-	rtl_patchphy(tp, 0x0f, 0x0017);
-
-	rtl_writephy(tp, 0x1f, 0x0005);
-	rtl_writephy(tp, 0x05, 0x001b);
-
-	rtl_apply_firmware_cond(tp, MII_EXPANSION, 0xb300);
-
-	rtl_writephy(tp, 0x1f, 0x0000);
-}
-
-static void rtl8168d_3_hw_phy_config(struct rtl8169_private *tp)
-{
-	static const struct phy_reg phy_reg_init[] = {
-		{ 0x1f, 0x0002 },
-		{ 0x10, 0x0008 },
-		{ 0x0d, 0x006c },
-
-		{ 0x1f, 0x0000 },
-		{ 0x0d, 0xf880 },
-
-		{ 0x1f, 0x0001 },
-		{ 0x17, 0x0cc0 },
-
-		{ 0x1f, 0x0001 },
-		{ 0x0b, 0xa4d8 },
-		{ 0x09, 0x281c },
-		{ 0x07, 0x2883 },
-		{ 0x0a, 0x6b35 },
-		{ 0x1d, 0x3da4 },
-		{ 0x1c, 0xeffd },
-		{ 0x14, 0x7f52 },
-		{ 0x18, 0x7fc6 },
-		{ 0x08, 0x0601 },
-		{ 0x06, 0x4063 },
-		{ 0x10, 0xf074 },
-		{ 0x1f, 0x0003 },
-		{ 0x13, 0x0789 },
-		{ 0x12, 0xf4bd },
-		{ 0x1a, 0x04fd },
-		{ 0x14, 0x84b0 },
-		{ 0x1f, 0x0000 },
-		{ 0x00, 0x9200 },
-
-		{ 0x1f, 0x0005 },
-		{ 0x01, 0x0340 },
-		{ 0x1f, 0x0001 },
-		{ 0x04, 0x4000 },
-		{ 0x03, 0x1d21 },
-		{ 0x02, 0x0c32 },
-		{ 0x01, 0x0200 },
-		{ 0x00, 0x5554 },
-		{ 0x04, 0x4800 },
-		{ 0x04, 0x4000 },
-		{ 0x04, 0xf000 },
-		{ 0x03, 0xdf01 },
-		{ 0x02, 0xdf20 },
-		{ 0x01, 0x101a },
-		{ 0x00, 0xa0ff },
-		{ 0x04, 0xf800 },
-		{ 0x04, 0xf000 },
-		{ 0x1f, 0x0000 },
-
-		{ 0x1f, 0x0007 },
-		{ 0x1e, 0x0023 },
-		{ 0x16, 0x0000 },
-		{ 0x1f, 0x0000 }
-	};
-
-	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
-}
-
-static void rtl8168d_4_hw_phy_config(struct rtl8169_private *tp)
-{
-	static const struct phy_reg phy_reg_init[] = {
-		{ 0x1f, 0x0001 },
-		{ 0x17, 0x0cc0 },
-
-		{ 0x1f, 0x0007 },
-		{ 0x1e, 0x002d },
-		{ 0x18, 0x0040 },
-		{ 0x1f, 0x0000 }
-	};
-
-	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
-	rtl_patchphy(tp, 0x0d, 1 << 5);
-}
-
-static void rtl8168e_1_hw_phy_config(struct rtl8169_private *tp)
-{
-	static const struct phy_reg phy_reg_init[] = {
-		/* Enable Delay cap */
-		{ 0x1f, 0x0005 },
-		{ 0x05, 0x8b80 },
-		{ 0x06, 0xc896 },
-		{ 0x1f, 0x0000 },
-
-		/* Channel estimation fine tune */
-		{ 0x1f, 0x0001 },
-		{ 0x0b, 0x6c20 },
-		{ 0x07, 0x2872 },
-		{ 0x1c, 0xefff },
-		{ 0x1f, 0x0003 },
-		{ 0x14, 0x6420 },
-		{ 0x1f, 0x0000 },
-
-		/* Update PFM & 10M TX idle timer */
-		{ 0x1f, 0x0007 },
-		{ 0x1e, 0x002f },
-		{ 0x15, 0x1919 },
-		{ 0x1f, 0x0000 },
-
-		{ 0x1f, 0x0007 },
-		{ 0x1e, 0x00ac },
-		{ 0x18, 0x0006 },
-		{ 0x1f, 0x0000 }
-	};
-
-	rtl_apply_firmware(tp);
-
-	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
-
-	/* DCO enable for 10M IDLE Power */
-	rtl_writephy(tp, 0x1f, 0x0007);
-	rtl_writephy(tp, 0x1e, 0x0023);
-	rtl_w0w1_phy(tp, 0x17, 0x0006, 0x0000);
-	rtl_writephy(tp, 0x1f, 0x0000);
-
-	/* For impedance matching */
-	rtl_writephy(tp, 0x1f, 0x0002);
-	rtl_w0w1_phy(tp, 0x08, 0x8000, 0x7f00);
-	rtl_writephy(tp, 0x1f, 0x0000);
-
-	/* PHY auto speed down */
-	rtl_writephy(tp, 0x1f, 0x0007);
-	rtl_writephy(tp, 0x1e, 0x002d);
-	rtl_w0w1_phy(tp, 0x18, 0x0050, 0x0000);
-	rtl_writephy(tp, 0x1f, 0x0000);
-	rtl_w0w1_phy(tp, 0x14, 0x8000, 0x0000);
-
-	rtl_writephy(tp, 0x1f, 0x0005);
-	rtl_writephy(tp, 0x05, 0x8b86);
-	rtl_w0w1_phy(tp, 0x06, 0x0001, 0x0000);
-	rtl_writephy(tp, 0x1f, 0x0000);
-
-	rtl_writephy(tp, 0x1f, 0x0005);
-	rtl_writephy(tp, 0x05, 0x8b85);
-	rtl_w0w1_phy(tp, 0x06, 0x0000, 0x2000);
-	rtl_writephy(tp, 0x1f, 0x0007);
-	rtl_writephy(tp, 0x1e, 0x0020);
-	rtl_w0w1_phy(tp, 0x15, 0x0000, 0x1100);
-	rtl_writephy(tp, 0x1f, 0x0006);
-	rtl_writephy(tp, 0x00, 0x5a00);
-	rtl_writephy(tp, 0x1f, 0x0000);
-	rtl_writephy(tp, 0x0d, 0x0007);
-	rtl_writephy(tp, 0x0e, 0x003c);
-	rtl_writephy(tp, 0x0d, 0x4007);
-	rtl_writephy(tp, 0x0e, 0x0000);
-	rtl_writephy(tp, 0x0d, 0x0000);
-}
-
-static void rtl_rar_exgmac_set(struct rtl8169_private *tp, u8 *addr)
-{
-	const u16 w[] = {
-		addr[0] | (addr[1] << 8),
-		addr[2] | (addr[3] << 8),
-		addr[4] | (addr[5] << 8)
-	};
-	const struct exgmac_reg e[] = {
-		{ .addr = 0xe0, ERIAR_MASK_1111, .val = w[0] | (w[1] << 16) },
-		{ .addr = 0xe4, ERIAR_MASK_1111, .val = w[2] },
-		{ .addr = 0xf0, ERIAR_MASK_1111, .val = w[0] << 16 },
-		{ .addr = 0xf4, ERIAR_MASK_1111, .val = w[1] | (w[2] << 16) }
-	};
-
-	rtl_write_exgmac_batch(tp, e, ARRAY_SIZE(e));
-}
-
-static void rtl8168e_2_hw_phy_config(struct rtl8169_private *tp)
-{
-	static const struct phy_reg phy_reg_init[] = {
-		/* Enable Delay cap */
-		{ 0x1f, 0x0004 },
-		{ 0x1f, 0x0007 },
-		{ 0x1e, 0x00ac },
-		{ 0x18, 0x0006 },
-		{ 0x1f, 0x0002 },
-		{ 0x1f, 0x0000 },
-		{ 0x1f, 0x0000 },
-
-		/* Channel estimation fine tune */
-		{ 0x1f, 0x0003 },
-		{ 0x09, 0xa20f },
-		{ 0x1f, 0x0000 },
-		{ 0x1f, 0x0000 },
-
-		/* Green Setting */
-		{ 0x1f, 0x0005 },
-		{ 0x05, 0x8b5b },
-		{ 0x06, 0x9222 },
-		{ 0x05, 0x8b6d },
-		{ 0x06, 0x8000 },
-		{ 0x05, 0x8b76 },
-		{ 0x06, 0x8000 },
-		{ 0x1f, 0x0000 }
-	};
-
-	rtl_apply_firmware(tp);
-
-	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
-
-	/* For 4-corner performance improve */
-	rtl_writephy(tp, 0x1f, 0x0005);
-	rtl_writephy(tp, 0x05, 0x8b80);
-	rtl_w0w1_phy(tp, 0x17, 0x0006, 0x0000);
-	rtl_writephy(tp, 0x1f, 0x0000);
-
-	/* PHY auto speed down */
-	rtl_writephy(tp, 0x1f, 0x0004);
-	rtl_writephy(tp, 0x1f, 0x0007);
-	rtl_writephy(tp, 0x1e, 0x002d);
-	rtl_w0w1_phy(tp, 0x18, 0x0010, 0x0000);
-	rtl_writephy(tp, 0x1f, 0x0002);
-	rtl_writephy(tp, 0x1f, 0x0000);
-	rtl_w0w1_phy(tp, 0x14, 0x8000, 0x0000);
-
-	/* improve 10M EEE waveform */
-	rtl_writephy(tp, 0x1f, 0x0005);
-	rtl_writephy(tp, 0x05, 0x8b86);
-	rtl_w0w1_phy(tp, 0x06, 0x0001, 0x0000);
-	rtl_writephy(tp, 0x1f, 0x0000);
-
-	/* Improve 2-pair detection performance */
-	rtl_writephy(tp, 0x1f, 0x0005);
-	rtl_writephy(tp, 0x05, 0x8b85);
-	rtl_w0w1_phy(tp, 0x06, 0x4000, 0x0000);
-	rtl_writephy(tp, 0x1f, 0x0000);
-
-	/* EEE setting */
-	rtl_w0w1_eri(tp, 0x1b0, ERIAR_MASK_1111, 0x0003, 0x0000, ERIAR_EXGMAC);
-	rtl_writephy(tp, 0x1f, 0x0005);
-	rtl_writephy(tp, 0x05, 0x8b85);
-	rtl_w0w1_phy(tp, 0x06, 0x2000, 0x0000);
-	rtl_writephy(tp, 0x1f, 0x0004);
-	rtl_writephy(tp, 0x1f, 0x0007);
-	rtl_writephy(tp, 0x1e, 0x0020);
-	rtl_w0w1_phy(tp, 0x15, 0x0100, 0x0000);
-	rtl_writephy(tp, 0x1f, 0x0002);
-	rtl_writephy(tp, 0x1f, 0x0000);
-	rtl_writephy(tp, 0x0d, 0x0007);
-	rtl_writephy(tp, 0x0e, 0x003c);
-	rtl_writephy(tp, 0x0d, 0x4007);
-	rtl_writephy(tp, 0x0e, 0x0006);
-	rtl_writephy(tp, 0x0d, 0x0000);
-
-	/* Green feature */
-	rtl_writephy(tp, 0x1f, 0x0003);
-	rtl_w0w1_phy(tp, 0x19, 0x0001, 0x0000);
-	rtl_w0w1_phy(tp, 0x10, 0x0400, 0x0000);
-	rtl_writephy(tp, 0x1f, 0x0000);
-	rtl_writephy(tp, 0x1f, 0x0005);
-	rtl_w0w1_phy(tp, 0x01, 0x0100, 0x0000);
-	rtl_writephy(tp, 0x1f, 0x0000);
-
-	/* Broken BIOS workaround: feed GigaMAC registers with MAC address. */
-	rtl_rar_exgmac_set(tp, tp->dev->dev_addr);
-}
-
-static void rtl8168f_hw_phy_config(struct rtl8169_private *tp)
-{
-	/* For 4-corner performance improve */
-	rtl_writephy(tp, 0x1f, 0x0005);
-	rtl_writephy(tp, 0x05, 0x8b80);
-	rtl_w0w1_phy(tp, 0x06, 0x0006, 0x0000);
-	rtl_writephy(tp, 0x1f, 0x0000);
-
-	/* PHY auto speed down */
-	rtl_writephy(tp, 0x1f, 0x0007);
-	rtl_writephy(tp, 0x1e, 0x002d);
-	rtl_w0w1_phy(tp, 0x18, 0x0010, 0x0000);
-	rtl_writephy(tp, 0x1f, 0x0000);
-	rtl_w0w1_phy(tp, 0x14, 0x8000, 0x0000);
-
-	/* Improve 10M EEE waveform */
-	rtl_writephy(tp, 0x1f, 0x0005);
-	rtl_writephy(tp, 0x05, 0x8b86);
-	rtl_w0w1_phy(tp, 0x06, 0x0001, 0x0000);
-	rtl_writephy(tp, 0x1f, 0x0000);
-}
-
-static void rtl8168f_1_hw_phy_config(struct rtl8169_private *tp)
-{
-	static const struct phy_reg phy_reg_init[] = {
-		/* Channel estimation fine tune */
-		{ 0x1f, 0x0003 },
-		{ 0x09, 0xa20f },
-		{ 0x1f, 0x0000 },
-
-		/* Modify green table for giga & fnet */
-		{ 0x1f, 0x0005 },
-		{ 0x05, 0x8b55 },
-		{ 0x06, 0x0000 },
-		{ 0x05, 0x8b5e },
-		{ 0x06, 0x0000 },
-		{ 0x05, 0x8b67 },
-		{ 0x06, 0x0000 },
-		{ 0x05, 0x8b70 },
-		{ 0x06, 0x0000 },
-		{ 0x1f, 0x0000 },
-		{ 0x1f, 0x0007 },
-		{ 0x1e, 0x0078 },
-		{ 0x17, 0x0000 },
-		{ 0x19, 0x00fb },
-		{ 0x1f, 0x0000 },
-
-		/* Modify green table for 10M */
-		{ 0x1f, 0x0005 },
-		{ 0x05, 0x8b79 },
-		{ 0x06, 0xaa00 },
-		{ 0x1f, 0x0000 },
-
-		/* Disable hiimpedance detection (RTCT) */
-		{ 0x1f, 0x0003 },
-		{ 0x01, 0x328a },
-		{ 0x1f, 0x0000 }
-	};
-
-	rtl_apply_firmware(tp);
-
-	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
-
-	rtl8168f_hw_phy_config(tp);
-
-	/* Improve 2-pair detection performance */
-	rtl_writephy(tp, 0x1f, 0x0005);
-	rtl_writephy(tp, 0x05, 0x8b85);
-	rtl_w0w1_phy(tp, 0x06, 0x4000, 0x0000);
-	rtl_writephy(tp, 0x1f, 0x0000);
-}
-
-static void rtl8168f_2_hw_phy_config(struct rtl8169_private *tp)
-{
-	rtl_apply_firmware(tp);
-
-	rtl8168f_hw_phy_config(tp);
-}
-
-static void rtl8411_hw_phy_config(struct rtl8169_private *tp)
-{
-	static const struct phy_reg phy_reg_init[] = {
-		/* Channel estimation fine tune */
-		{ 0x1f, 0x0003 },
-		{ 0x09, 0xa20f },
-		{ 0x1f, 0x0000 },
-
-		/* Modify green table for giga & fnet */
-		{ 0x1f, 0x0005 },
-		{ 0x05, 0x8b55 },
-		{ 0x06, 0x0000 },
-		{ 0x05, 0x8b5e },
-		{ 0x06, 0x0000 },
-		{ 0x05, 0x8b67 },
-		{ 0x06, 0x0000 },
-		{ 0x05, 0x8b70 },
-		{ 0x06, 0x0000 },
-		{ 0x1f, 0x0000 },
-		{ 0x1f, 0x0007 },
-		{ 0x1e, 0x0078 },
-		{ 0x17, 0x0000 },
-		{ 0x19, 0x00aa },
-		{ 0x1f, 0x0000 },
-
-		/* Modify green table for 10M */
-		{ 0x1f, 0x0005 },
-		{ 0x05, 0x8b79 },
-		{ 0x06, 0xaa00 },
-		{ 0x1f, 0x0000 },
-
-		/* Disable hiimpedance detection (RTCT) */
-		{ 0x1f, 0x0003 },
-		{ 0x01, 0x328a },
-		{ 0x1f, 0x0000 }
-	};
-
-
-	rtl_apply_firmware(tp);
-
-	rtl8168f_hw_phy_config(tp);
-
-	/* Improve 2-pair detection performance */
-	rtl_writephy(tp, 0x1f, 0x0005);
-	rtl_writephy(tp, 0x05, 0x8b85);
-	rtl_w0w1_phy(tp, 0x06, 0x4000, 0x0000);
-	rtl_writephy(tp, 0x1f, 0x0000);
-
-	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
-
-	/* Modify green table for giga */
-	rtl_writephy(tp, 0x1f, 0x0005);
-	rtl_writephy(tp, 0x05, 0x8b54);
-	rtl_w0w1_phy(tp, 0x06, 0x0000, 0x0800);
-	rtl_writephy(tp, 0x05, 0x8b5d);
-	rtl_w0w1_phy(tp, 0x06, 0x0000, 0x0800);
-	rtl_writephy(tp, 0x05, 0x8a7c);
-	rtl_w0w1_phy(tp, 0x06, 0x0000, 0x0100);
-	rtl_writephy(tp, 0x05, 0x8a7f);
-	rtl_w0w1_phy(tp, 0x06, 0x0100, 0x0000);
-	rtl_writephy(tp, 0x05, 0x8a82);
-	rtl_w0w1_phy(tp, 0x06, 0x0000, 0x0100);
-	rtl_writephy(tp, 0x05, 0x8a85);
-	rtl_w0w1_phy(tp, 0x06, 0x0000, 0x0100);
-	rtl_writephy(tp, 0x05, 0x8a88);
-	rtl_w0w1_phy(tp, 0x06, 0x0000, 0x0100);
-	rtl_writephy(tp, 0x1f, 0x0000);
-
-	/* uc same-seed solution */
-	rtl_writephy(tp, 0x1f, 0x0005);
-	rtl_writephy(tp, 0x05, 0x8b85);
-	rtl_w0w1_phy(tp, 0x06, 0x8000, 0x0000);
-	rtl_writephy(tp, 0x1f, 0x0000);
-
-	/* eee setting */
-	rtl_w0w1_eri(tp, 0x1b0, ERIAR_MASK_0001, 0x00, 0x03, ERIAR_EXGMAC);
-	rtl_writephy(tp, 0x1f, 0x0005);
-	rtl_writephy(tp, 0x05, 0x8b85);
-	rtl_w0w1_phy(tp, 0x06, 0x0000, 0x2000);
-	rtl_writephy(tp, 0x1f, 0x0004);
-	rtl_writephy(tp, 0x1f, 0x0007);
-	rtl_writephy(tp, 0x1e, 0x0020);
-	rtl_w0w1_phy(tp, 0x15, 0x0000, 0x0100);
-	rtl_writephy(tp, 0x1f, 0x0000);
-	rtl_writephy(tp, 0x0d, 0x0007);
-	rtl_writephy(tp, 0x0e, 0x003c);
-	rtl_writephy(tp, 0x0d, 0x4007);
-	rtl_writephy(tp, 0x0e, 0x0000);
-	rtl_writephy(tp, 0x0d, 0x0000);
-
-	/* Green feature */
-	rtl_writephy(tp, 0x1f, 0x0003);
-	rtl_w0w1_phy(tp, 0x19, 0x0000, 0x0001);
-	rtl_w0w1_phy(tp, 0x10, 0x0000, 0x0400);
-	rtl_writephy(tp, 0x1f, 0x0000);
-}
-
-static void rtl8168g_1_hw_phy_config(struct rtl8169_private *tp)
-{
-	rtl_apply_firmware(tp);
-
-	rtl_writephy(tp, 0x1f, 0x0a46);
-	if (rtl_readphy(tp, 0x10) & 0x0100) {
-		rtl_writephy(tp, 0x1f, 0x0bcc);
-		rtl_w0w1_phy(tp, 0x12, 0x0000, 0x8000);
-	} else {
-		rtl_writephy(tp, 0x1f, 0x0bcc);
-		rtl_w0w1_phy(tp, 0x12, 0x8000, 0x0000);
-	}
-
-	rtl_writephy(tp, 0x1f, 0x0a46);
-	if (rtl_readphy(tp, 0x13) & 0x0100) {
-		rtl_writephy(tp, 0x1f, 0x0c41);
-		rtl_w0w1_phy(tp, 0x15, 0x0002, 0x0000);
-	} else {
-		rtl_writephy(tp, 0x1f, 0x0c41);
-		rtl_w0w1_phy(tp, 0x15, 0x0000, 0x0002);
-	}
-
-	/* Enable PHY auto speed down */
-	rtl_writephy(tp, 0x1f, 0x0a44);
-	rtl_w0w1_phy(tp, 0x11, 0x000c, 0x0000);
-
-	rtl_writephy(tp, 0x1f, 0x0bcc);
-	rtl_w0w1_phy(tp, 0x14, 0x0100, 0x0000);
-	rtl_writephy(tp, 0x1f, 0x0a44);
-	rtl_w0w1_phy(tp, 0x11, 0x00c0, 0x0000);
-	rtl_writephy(tp, 0x1f, 0x0a43);
-	rtl_writephy(tp, 0x13, 0x8084);
-	rtl_w0w1_phy(tp, 0x14, 0x0000, 0x6000);
-	rtl_w0w1_phy(tp, 0x10, 0x1003, 0x0000);
-
-	/* EEE auto-fallback function */
-	rtl_writephy(tp, 0x1f, 0x0a4b);
-	rtl_w0w1_phy(tp, 0x11, 0x0004, 0x0000);
-
-	/* Enable UC LPF tune function */
-	rtl_writephy(tp, 0x1f, 0x0a43);
-	rtl_writephy(tp, 0x13, 0x8012);
-	rtl_w0w1_phy(tp, 0x14, 0x8000, 0x0000);
-
-	rtl_writephy(tp, 0x1f, 0x0c42);
-	rtl_w0w1_phy(tp, 0x11, 0x4000, 0x2000);
-
-	/* Improve SWR Efficiency */
-	rtl_writephy(tp, 0x1f, 0x0bcd);
-	rtl_writephy(tp, 0x14, 0x5065);
-	rtl_writephy(tp, 0x14, 0xd065);
-	rtl_writephy(tp, 0x1f, 0x0bc8);
-	rtl_writephy(tp, 0x11, 0x5655);
-	rtl_writephy(tp, 0x1f, 0x0bcd);
-	rtl_writephy(tp, 0x14, 0x1065);
-	rtl_writephy(tp, 0x14, 0x9065);
-	rtl_writephy(tp, 0x14, 0x1065);
-
-	/* Check ALDPS bit, disable it if enabled */
-	rtl_writephy(tp, 0x1f, 0x0a43);
-	if (rtl_readphy(tp, 0x10) & 0x0004)
-		rtl_w0w1_phy(tp, 0x10, 0x0000, 0x0004);
-
-	rtl_writephy(tp, 0x1f, 0x0000);
-}
-
-static void rtl8168g_2_hw_phy_config(struct rtl8169_private *tp)
-{
-	rtl_apply_firmware(tp);
-}
-
-static void rtl8168h_1_hw_phy_config(struct rtl8169_private *tp)
-{
-	u16 dout_tapbin;
-	u32 data;
-
-	rtl_apply_firmware(tp);
-
-	/* CHN EST parameters adjust - giga master */
-	rtl_writephy(tp, 0x1f, 0x0a43);
-	rtl_writephy(tp, 0x13, 0x809b);
-	rtl_w0w1_phy(tp, 0x14, 0x8000, 0xf800);
-	rtl_writephy(tp, 0x13, 0x80a2);
-	rtl_w0w1_phy(tp, 0x14, 0x8000, 0xff00);
-	rtl_writephy(tp, 0x13, 0x80a4);
-	rtl_w0w1_phy(tp, 0x14, 0x8500, 0xff00);
-	rtl_writephy(tp, 0x13, 0x809c);
-	rtl_w0w1_phy(tp, 0x14, 0xbd00, 0xff00);
-	rtl_writephy(tp, 0x1f, 0x0000);
-
-	/* CHN EST parameters adjust - giga slave */
-	rtl_writephy(tp, 0x1f, 0x0a43);
-	rtl_writephy(tp, 0x13, 0x80ad);
-	rtl_w0w1_phy(tp, 0x14, 0x7000, 0xf800);
-	rtl_writephy(tp, 0x13, 0x80b4);
-	rtl_w0w1_phy(tp, 0x14, 0x5000, 0xff00);
-	rtl_writephy(tp, 0x13, 0x80ac);
-	rtl_w0w1_phy(tp, 0x14, 0x4000, 0xff00);
-	rtl_writephy(tp, 0x1f, 0x0000);
-
-	/* CHN EST parameters adjust - fnet */
-	rtl_writephy(tp, 0x1f, 0x0a43);
-	rtl_writephy(tp, 0x13, 0x808e);
-	rtl_w0w1_phy(tp, 0x14, 0x1200, 0xff00);
-	rtl_writephy(tp, 0x13, 0x8090);
-	rtl_w0w1_phy(tp, 0x14, 0xe500, 0xff00);
-	rtl_writephy(tp, 0x13, 0x8092);
-	rtl_w0w1_phy(tp, 0x14, 0x9f00, 0xff00);
-	rtl_writephy(tp, 0x1f, 0x0000);
-
-	/* enable R-tune & PGA-retune function */
-	dout_tapbin = 0;
-	rtl_writephy(tp, 0x1f, 0x0a46);
-	data = rtl_readphy(tp, 0x13);
-	data &= 3;
-	data <<= 2;
-	dout_tapbin |= data;
-	data = rtl_readphy(tp, 0x12);
-	data &= 0xc000;
-	data >>= 14;
-	dout_tapbin |= data;
-	dout_tapbin = ~(dout_tapbin^0x08);
-	dout_tapbin <<= 12;
-	dout_tapbin &= 0xf000;
-	rtl_writephy(tp, 0x1f, 0x0a43);
-	rtl_writephy(tp, 0x13, 0x827a);
-	rtl_w0w1_phy(tp, 0x14, dout_tapbin, 0xf000);
-	rtl_writephy(tp, 0x13, 0x827b);
-	rtl_w0w1_phy(tp, 0x14, dout_tapbin, 0xf000);
-	rtl_writephy(tp, 0x13, 0x827c);
-	rtl_w0w1_phy(tp, 0x14, dout_tapbin, 0xf000);
-	rtl_writephy(tp, 0x13, 0x827d);
-	rtl_w0w1_phy(tp, 0x14, dout_tapbin, 0xf000);
-
-	rtl_writephy(tp, 0x1f, 0x0a43);
-	rtl_writephy(tp, 0x13, 0x0811);
-	rtl_w0w1_phy(tp, 0x14, 0x0800, 0x0000);
-	rtl_writephy(tp, 0x1f, 0x0a42);
-	rtl_w0w1_phy(tp, 0x16, 0x0002, 0x0000);
-	rtl_writephy(tp, 0x1f, 0x0000);
-
-	/* enable GPHY 10M */
-	rtl_writephy(tp, 0x1f, 0x0a44);
-	rtl_w0w1_phy(tp, 0x11, 0x0800, 0x0000);
-	rtl_writephy(tp, 0x1f, 0x0000);
-
-	/* SAR ADC performance */
-	rtl_writephy(tp, 0x1f, 0x0bca);
-	rtl_w0w1_phy(tp, 0x17, 0x4000, 0x3000);
-	rtl_writephy(tp, 0x1f, 0x0000);
-
-	rtl_writephy(tp, 0x1f, 0x0a43);
-	rtl_writephy(tp, 0x13, 0x803f);
-	rtl_w0w1_phy(tp, 0x14, 0x0000, 0x3000);
-	rtl_writephy(tp, 0x13, 0x8047);
-	rtl_w0w1_phy(tp, 0x14, 0x0000, 0x3000);
-	rtl_writephy(tp, 0x13, 0x804f);
-	rtl_w0w1_phy(tp, 0x14, 0x0000, 0x3000);
-	rtl_writephy(tp, 0x13, 0x8057);
-	rtl_w0w1_phy(tp, 0x14, 0x0000, 0x3000);
-	rtl_writephy(tp, 0x13, 0x805f);
-	rtl_w0w1_phy(tp, 0x14, 0x0000, 0x3000);
-	rtl_writephy(tp, 0x13, 0x8067);
-	rtl_w0w1_phy(tp, 0x14, 0x0000, 0x3000);
-	rtl_writephy(tp, 0x13, 0x806f);
-	rtl_w0w1_phy(tp, 0x14, 0x0000, 0x3000);
-	rtl_writephy(tp, 0x1f, 0x0000);
-
-	/* disable phy pfm mode */
-	rtl_writephy(tp, 0x1f, 0x0a44);
-	rtl_w0w1_phy(tp, 0x11, 0x0000, 0x0080);
-	rtl_writephy(tp, 0x1f, 0x0000);
-
-	/* Check ALDPS bit, disable it if enabled */
-	rtl_writephy(tp, 0x1f, 0x0a43);
-	if (rtl_readphy(tp, 0x10) & 0x0004)
-		rtl_w0w1_phy(tp, 0x10, 0x0000, 0x0004);
-
-	rtl_writephy(tp, 0x1f, 0x0000);
-}
-
-static void rtl8168h_2_hw_phy_config(struct rtl8169_private *tp)
-{
-	u16 ioffset_p3, ioffset_p2, ioffset_p1, ioffset_p0;
-	u16 rlen;
-	u32 data;
-
-	rtl_apply_firmware(tp);
-
-	/* CHIN EST parameter update */
-	rtl_writephy(tp, 0x1f, 0x0a43);
-	rtl_writephy(tp, 0x13, 0x808a);
-	rtl_w0w1_phy(tp, 0x14, 0x000a, 0x003f);
-	rtl_writephy(tp, 0x1f, 0x0000);
-
-	/* enable R-tune & PGA-retune function */
-	rtl_writephy(tp, 0x1f, 0x0a43);
-	rtl_writephy(tp, 0x13, 0x0811);
-	rtl_w0w1_phy(tp, 0x14, 0x0800, 0x0000);
-	rtl_writephy(tp, 0x1f, 0x0a42);
-	rtl_w0w1_phy(tp, 0x16, 0x0002, 0x0000);
-	rtl_writephy(tp, 0x1f, 0x0000);
-
-	/* enable GPHY 10M */
-	rtl_writephy(tp, 0x1f, 0x0a44);
-	rtl_w0w1_phy(tp, 0x11, 0x0800, 0x0000);
-	rtl_writephy(tp, 0x1f, 0x0000);
-
-	r8168_mac_ocp_write(tp, 0xdd02, 0x807d);
-	data = r8168_mac_ocp_read(tp, 0xdd02);
-	ioffset_p3 = ((data & 0x80)>>7);
-	ioffset_p3 <<= 3;
-
-	data = r8168_mac_ocp_read(tp, 0xdd00);
-	ioffset_p3 |= ((data & (0xe000))>>13);
-	ioffset_p2 = ((data & (0x1e00))>>9);
-	ioffset_p1 = ((data & (0x01e0))>>5);
-	ioffset_p0 = ((data & 0x0010)>>4);
-	ioffset_p0 <<= 3;
-	ioffset_p0 |= (data & (0x07));
-	data = (ioffset_p3<<12)|(ioffset_p2<<8)|(ioffset_p1<<4)|(ioffset_p0);
-
-	if ((ioffset_p3 != 0x0f) || (ioffset_p2 != 0x0f) ||
-	    (ioffset_p1 != 0x0f) || (ioffset_p0 != 0x0f)) {
-		rtl_writephy(tp, 0x1f, 0x0bcf);
-		rtl_writephy(tp, 0x16, data);
-		rtl_writephy(tp, 0x1f, 0x0000);
-	}
-
-	/* Modify rlen (TX LPF corner frequency) level */
-	rtl_writephy(tp, 0x1f, 0x0bcd);
-	data = rtl_readphy(tp, 0x16);
-	data &= 0x000f;
-	rlen = 0;
-	if (data > 3)
-		rlen = data - 3;
-	data = rlen | (rlen<<4) | (rlen<<8) | (rlen<<12);
-	rtl_writephy(tp, 0x17, data);
-	rtl_writephy(tp, 0x1f, 0x0bcd);
-	rtl_writephy(tp, 0x1f, 0x0000);
-
-	/* disable phy pfm mode */
-	rtl_writephy(tp, 0x1f, 0x0a44);
-	rtl_w0w1_phy(tp, 0x11, 0x0000, 0x0080);
-	rtl_writephy(tp, 0x1f, 0x0000);
-
-	/* Check ALDPS bit, disable it if enabled */
-	rtl_writephy(tp, 0x1f, 0x0a43);
-	if (rtl_readphy(tp, 0x10) & 0x0004)
-		rtl_w0w1_phy(tp, 0x10, 0x0000, 0x0004);
-
-	rtl_writephy(tp, 0x1f, 0x0000);
-}
-
-static void rtl8168ep_1_hw_phy_config(struct rtl8169_private *tp)
-{
-	/* Enable PHY auto speed down */
-	rtl_writephy(tp, 0x1f, 0x0a44);
-	rtl_w0w1_phy(tp, 0x11, 0x000c, 0x0000);
-	rtl_writephy(tp, 0x1f, 0x0000);
-
-	/* patch 10M & ALDPS */
-	rtl_writephy(tp, 0x1f, 0x0bcc);
-	rtl_w0w1_phy(tp, 0x14, 0x0000, 0x0100);
-	rtl_writephy(tp, 0x1f, 0x0a44);
-	rtl_w0w1_phy(tp, 0x11, 0x00c0, 0x0000);
-	rtl_writephy(tp, 0x1f, 0x0a43);
-	rtl_writephy(tp, 0x13, 0x8084);
-	rtl_w0w1_phy(tp, 0x14, 0x0000, 0x6000);
-	rtl_w0w1_phy(tp, 0x10, 0x1003, 0x0000);
-	rtl_writephy(tp, 0x1f, 0x0000);
-
-	/* Enable EEE auto-fallback function */
-	rtl_writephy(tp, 0x1f, 0x0a4b);
-	rtl_w0w1_phy(tp, 0x11, 0x0004, 0x0000);
-	rtl_writephy(tp, 0x1f, 0x0000);
-
-	/* Enable UC LPF tune function */
-	rtl_writephy(tp, 0x1f, 0x0a43);
-	rtl_writephy(tp, 0x13, 0x8012);
-	rtl_w0w1_phy(tp, 0x14, 0x8000, 0x0000);
-	rtl_writephy(tp, 0x1f, 0x0000);
-
-	/* set rg_sel_sdm_rate */
-	rtl_writephy(tp, 0x1f, 0x0c42);
-	rtl_w0w1_phy(tp, 0x11, 0x4000, 0x2000);
-	rtl_writephy(tp, 0x1f, 0x0000);
-
-	/* Check ALDPS bit, disable it if enabled */
-	rtl_writephy(tp, 0x1f, 0x0a43);
-	if (rtl_readphy(tp, 0x10) & 0x0004)
-		rtl_w0w1_phy(tp, 0x10, 0x0000, 0x0004);
-
-	rtl_writephy(tp, 0x1f, 0x0000);
-}
-
-static void rtl8168ep_2_hw_phy_config(struct rtl8169_private *tp)
-{
-	/* patch 10M & ALDPS */
-	rtl_writephy(tp, 0x1f, 0x0bcc);
-	rtl_w0w1_phy(tp, 0x14, 0x0000, 0x0100);
-	rtl_writephy(tp, 0x1f, 0x0a44);
-	rtl_w0w1_phy(tp, 0x11, 0x00c0, 0x0000);
-	rtl_writephy(tp, 0x1f, 0x0a43);
-	rtl_writephy(tp, 0x13, 0x8084);
-	rtl_w0w1_phy(tp, 0x14, 0x0000, 0x6000);
-	rtl_w0w1_phy(tp, 0x10, 0x1003, 0x0000);
-	rtl_writephy(tp, 0x1f, 0x0000);
-
-	/* Enable UC LPF tune function */
-	rtl_writephy(tp, 0x1f, 0x0a43);
-	rtl_writephy(tp, 0x13, 0x8012);
-	rtl_w0w1_phy(tp, 0x14, 0x8000, 0x0000);
-	rtl_writephy(tp, 0x1f, 0x0000);
-
-	/* Set rg_sel_sdm_rate */
-	rtl_writephy(tp, 0x1f, 0x0c42);
-	rtl_w0w1_phy(tp, 0x11, 0x4000, 0x2000);
-	rtl_writephy(tp, 0x1f, 0x0000);
-
-	/* Channel estimation parameters */
-	rtl_writephy(tp, 0x1f, 0x0a43);
-	rtl_writephy(tp, 0x13, 0x80f3);
-	rtl_w0w1_phy(tp, 0x14, 0x8b00, ~0x8bff);
-	rtl_writephy(tp, 0x13, 0x80f0);
-	rtl_w0w1_phy(tp, 0x14, 0x3a00, ~0x3aff);
-	rtl_writephy(tp, 0x13, 0x80ef);
-	rtl_w0w1_phy(tp, 0x14, 0x0500, ~0x05ff);
-	rtl_writephy(tp, 0x13, 0x80f6);
-	rtl_w0w1_phy(tp, 0x14, 0x6e00, ~0x6eff);
-	rtl_writephy(tp, 0x13, 0x80ec);
-	rtl_w0w1_phy(tp, 0x14, 0x6800, ~0x68ff);
-	rtl_writephy(tp, 0x13, 0x80ed);
-	rtl_w0w1_phy(tp, 0x14, 0x7c00, ~0x7cff);
-	rtl_writephy(tp, 0x13, 0x80f2);
-	rtl_w0w1_phy(tp, 0x14, 0xf400, ~0xf4ff);
-	rtl_writephy(tp, 0x13, 0x80f4);
-	rtl_w0w1_phy(tp, 0x14, 0x8500, ~0x85ff);
-	rtl_writephy(tp, 0x1f, 0x0a43);
-	rtl_writephy(tp, 0x13, 0x8110);
-	rtl_w0w1_phy(tp, 0x14, 0xa800, ~0xa8ff);
-	rtl_writephy(tp, 0x13, 0x810f);
-	rtl_w0w1_phy(tp, 0x14, 0x1d00, ~0x1dff);
-	rtl_writephy(tp, 0x13, 0x8111);
-	rtl_w0w1_phy(tp, 0x14, 0xf500, ~0xf5ff);
-	rtl_writephy(tp, 0x13, 0x8113);
-	rtl_w0w1_phy(tp, 0x14, 0x6100, ~0x61ff);
-	rtl_writephy(tp, 0x13, 0x8115);
-	rtl_w0w1_phy(tp, 0x14, 0x9200, ~0x92ff);
-	rtl_writephy(tp, 0x13, 0x810e);
-	rtl_w0w1_phy(tp, 0x14, 0x0400, ~0x04ff);
-	rtl_writephy(tp, 0x13, 0x810c);
-	rtl_w0w1_phy(tp, 0x14, 0x7c00, ~0x7cff);
-	rtl_writephy(tp, 0x13, 0x810b);
-	rtl_w0w1_phy(tp, 0x14, 0x5a00, ~0x5aff);
-	rtl_writephy(tp, 0x1f, 0x0a43);
-	rtl_writephy(tp, 0x13, 0x80d1);
-	rtl_w0w1_phy(tp, 0x14, 0xff00, ~0xffff);
-	rtl_writephy(tp, 0x13, 0x80cd);
-	rtl_w0w1_phy(tp, 0x14, 0x9e00, ~0x9eff);
-	rtl_writephy(tp, 0x13, 0x80d3);
-	rtl_w0w1_phy(tp, 0x14, 0x0e00, ~0x0eff);
-	rtl_writephy(tp, 0x13, 0x80d5);
-	rtl_w0w1_phy(tp, 0x14, 0xca00, ~0xcaff);
-	rtl_writephy(tp, 0x13, 0x80d7);
-	rtl_w0w1_phy(tp, 0x14, 0x8400, ~0x84ff);
-
-	/* Force PWM-mode */
-	rtl_writephy(tp, 0x1f, 0x0bcd);
-	rtl_writephy(tp, 0x14, 0x5065);
-	rtl_writephy(tp, 0x14, 0xd065);
-	rtl_writephy(tp, 0x1f, 0x0bc8);
-	rtl_writephy(tp, 0x12, 0x00ed);
-	rtl_writephy(tp, 0x1f, 0x0bcd);
-	rtl_writephy(tp, 0x14, 0x1065);
-	rtl_writephy(tp, 0x14, 0x9065);
-	rtl_writephy(tp, 0x14, 0x1065);
-	rtl_writephy(tp, 0x1f, 0x0000);
-
-	/* Check ALDPS bit, disable it if enabled */
-	rtl_writephy(tp, 0x1f, 0x0a43);
-	if (rtl_readphy(tp, 0x10) & 0x0004)
-		rtl_w0w1_phy(tp, 0x10, 0x0000, 0x0004);
-
-	rtl_writephy(tp, 0x1f, 0x0000);
-}
-
-static void rtl8102e_hw_phy_config(struct rtl8169_private *tp)
-{
-	static const struct phy_reg phy_reg_init[] = {
-		{ 0x1f, 0x0003 },
-		{ 0x08, 0x441d },
-		{ 0x01, 0x9100 },
-		{ 0x1f, 0x0000 }
-	};
-
-	rtl_writephy(tp, 0x1f, 0x0000);
-	rtl_patchphy(tp, 0x11, 1 << 12);
-	rtl_patchphy(tp, 0x19, 1 << 13);
-	rtl_patchphy(tp, 0x10, 1 << 15);
-
-	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
-}
-
-static void rtl8105e_hw_phy_config(struct rtl8169_private *tp)
-{
-	static const struct phy_reg phy_reg_init[] = {
-		{ 0x1f, 0x0005 },
-		{ 0x1a, 0x0000 },
-		{ 0x1f, 0x0000 },
-
-		{ 0x1f, 0x0004 },
-		{ 0x1c, 0x0000 },
-		{ 0x1f, 0x0000 },
-
-		{ 0x1f, 0x0001 },
-		{ 0x15, 0x7701 },
-		{ 0x1f, 0x0000 }
-	};
-
-	/* Disable ALDPS before ram code */
-	rtl_writephy(tp, 0x1f, 0x0000);
-	rtl_writephy(tp, 0x18, 0x0310);
-	msleep(100);
-
-	rtl_apply_firmware(tp);
-
-	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
-}
-
-static void rtl8402_hw_phy_config(struct rtl8169_private *tp)
-{
-	/* Disable ALDPS before setting firmware */
-	rtl_writephy(tp, 0x1f, 0x0000);
-	rtl_writephy(tp, 0x18, 0x0310);
-	msleep(20);
-
-	rtl_apply_firmware(tp);
-
-	/* EEE setting */
-	rtl_eri_write(tp, 0x1b0, ERIAR_MASK_0011, 0x0000, ERIAR_EXGMAC);
-	rtl_writephy(tp, 0x1f, 0x0004);
-	rtl_writephy(tp, 0x10, 0x401f);
-	rtl_writephy(tp, 0x19, 0x7030);
-	rtl_writephy(tp, 0x1f, 0x0000);
-}
-
-static void rtl8106e_hw_phy_config(struct rtl8169_private *tp)
-{
-	static const struct phy_reg phy_reg_init[] = {
-		{ 0x1f, 0x0004 },
-		{ 0x10, 0xc07f },
-		{ 0x19, 0x7030 },
-		{ 0x1f, 0x0000 }
-	};
-
-	/* Disable ALDPS before ram code */
-	rtl_writephy(tp, 0x1f, 0x0000);
-	rtl_writephy(tp, 0x18, 0x0310);
-	msleep(100);
-
-	rtl_apply_firmware(tp);
-
-	rtl_eri_write(tp, 0x1b0, ERIAR_MASK_0011, 0x0000, ERIAR_EXGMAC);
-	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
-
-	rtl_eri_write(tp, 0x1d0, ERIAR_MASK_0011, 0x0000, ERIAR_EXGMAC);
-}
-
-static void rtl_hw_phy_config(struct net_device *dev)
-{
-	struct rtl8169_private *tp = netdev_priv(dev);
-
-	rtl8169_print_mac_version(tp);
-
-	switch (tp->mac_version) {
-	case RTL_GIGA_MAC_VER_01:
-		break;
-	case RTL_GIGA_MAC_VER_02:
-	case RTL_GIGA_MAC_VER_03:
-		rtl8169s_hw_phy_config(tp);
-		break;
-	case RTL_GIGA_MAC_VER_04:
-		rtl8169sb_hw_phy_config(tp);
-		break;
-	case RTL_GIGA_MAC_VER_05:
-		rtl8169scd_hw_phy_config(tp);
-		break;
-	case RTL_GIGA_MAC_VER_06:
-		rtl8169sce_hw_phy_config(tp);
-		break;
-	case RTL_GIGA_MAC_VER_07:
-	case RTL_GIGA_MAC_VER_08:
-	case RTL_GIGA_MAC_VER_09:
-		rtl8102e_hw_phy_config(tp);
-		break;
-	case RTL_GIGA_MAC_VER_11:
-		rtl8168bb_hw_phy_config(tp);
-		break;
-	case RTL_GIGA_MAC_VER_12:
-		rtl8168bef_hw_phy_config(tp);
-		break;
-	case RTL_GIGA_MAC_VER_17:
-		rtl8168bef_hw_phy_config(tp);
-		break;
-	case RTL_GIGA_MAC_VER_18:
-		rtl8168cp_1_hw_phy_config(tp);
-		break;
-	case RTL_GIGA_MAC_VER_19:
-		rtl8168c_1_hw_phy_config(tp);
-		break;
-	case RTL_GIGA_MAC_VER_20:
-		rtl8168c_2_hw_phy_config(tp);
-		break;
-	case RTL_GIGA_MAC_VER_21:
-		rtl8168c_3_hw_phy_config(tp);
-		break;
-	case RTL_GIGA_MAC_VER_22:
-		rtl8168c_4_hw_phy_config(tp);
-		break;
-	case RTL_GIGA_MAC_VER_23:
-	case RTL_GIGA_MAC_VER_24:
-		rtl8168cp_2_hw_phy_config(tp);
-		break;
-	case RTL_GIGA_MAC_VER_25:
-		rtl8168d_1_hw_phy_config(tp);
-		break;
-	case RTL_GIGA_MAC_VER_26:
-		rtl8168d_2_hw_phy_config(tp);
-		break;
-	case RTL_GIGA_MAC_VER_27:
-		rtl8168d_3_hw_phy_config(tp);
-		break;
-	case RTL_GIGA_MAC_VER_28:
-		rtl8168d_4_hw_phy_config(tp);
-		break;
-	case RTL_GIGA_MAC_VER_29:
-	case RTL_GIGA_MAC_VER_30:
-		rtl8105e_hw_phy_config(tp);
-		break;
-	case RTL_GIGA_MAC_VER_31:
-		/* None. */
-		break;
-	case RTL_GIGA_MAC_VER_32:
-	case RTL_GIGA_MAC_VER_33:
-		rtl8168e_1_hw_phy_config(tp);
-		break;
-	case RTL_GIGA_MAC_VER_34:
-		rtl8168e_2_hw_phy_config(tp);
-		break;
-	case RTL_GIGA_MAC_VER_35:
-		rtl8168f_1_hw_phy_config(tp);
-		break;
-	case RTL_GIGA_MAC_VER_36:
-		rtl8168f_2_hw_phy_config(tp);
-		break;
-
-	case RTL_GIGA_MAC_VER_37:
-		rtl8402_hw_phy_config(tp);
-		break;
-
-	case RTL_GIGA_MAC_VER_38:
-		rtl8411_hw_phy_config(tp);
-		break;
-
-	case RTL_GIGA_MAC_VER_39:
-		rtl8106e_hw_phy_config(tp);
-		break;
-
-	case RTL_GIGA_MAC_VER_40:
-		rtl8168g_1_hw_phy_config(tp);
-		break;
-	case RTL_GIGA_MAC_VER_42:
-	case RTL_GIGA_MAC_VER_43:
-	case RTL_GIGA_MAC_VER_44:
-		rtl8168g_2_hw_phy_config(tp);
-		break;
-	case RTL_GIGA_MAC_VER_45:
-	case RTL_GIGA_MAC_VER_47:
-		rtl8168h_1_hw_phy_config(tp);
-		break;
-	case RTL_GIGA_MAC_VER_46:
-	case RTL_GIGA_MAC_VER_48:
-		rtl8168h_2_hw_phy_config(tp);
-		break;
-
-	case RTL_GIGA_MAC_VER_49:
-		rtl8168ep_1_hw_phy_config(tp);
-		break;
-	case RTL_GIGA_MAC_VER_50:
-	case RTL_GIGA_MAC_VER_51:
-		rtl8168ep_2_hw_phy_config(tp);
-		break;
-
-	case RTL_GIGA_MAC_VER_41:
-	default:
-		break;
-	}
-}
-
-static void rtl_schedule_task(struct rtl8169_private *tp, enum rtl_flag flag)
-{
-	if (!test_and_set_bit(flag, tp->wk.flags))
-		schedule_work(&tp->wk.work);
-}
-
-static bool rtl_tbi_enabled(struct rtl8169_private *tp)
-{
-	return (tp->mac_version == RTL_GIGA_MAC_VER_01) &&
-	       (RTL_R8(tp, PHYstatus) & TBI_Enable);
-}
-
-static void rtl8169_init_phy(struct net_device *dev, struct rtl8169_private *tp)
-{
-	rtl_hw_phy_config(dev);
-
-	if (tp->mac_version <= RTL_GIGA_MAC_VER_06) {
-		netif_dbg(tp, drv, dev,
-			  "Set MAC Reg C+CR Offset 0x82h = 0x01h\n");
-		RTL_W8(tp, 0x82, 0x01);
-	}
-
-	pci_write_config_byte(tp->pci_dev, PCI_LATENCY_TIMER, 0x40);
-
-	if (tp->mac_version <= RTL_GIGA_MAC_VER_06)
-		pci_write_config_byte(tp->pci_dev, PCI_CACHE_LINE_SIZE, 0x08);
-
-	if (tp->mac_version == RTL_GIGA_MAC_VER_02) {
-		netif_dbg(tp, drv, dev,
-			  "Set MAC Reg C+CR Offset 0x82h = 0x01h\n");
-		RTL_W8(tp, 0x82, 0x01);
-		netif_dbg(tp, drv, dev,
-			  "Set PHY Reg 0x0bh = 0x00h\n");
-		rtl_writephy(tp, 0x0b, 0x0000); //w 0x0b 15 0 0
-	}
-
-	/* We may have called phy_speed_down before */
-	phy_speed_up(dev->phydev);
-
-	genphy_soft_reset(dev->phydev);
-
-	/* It was reported that several chips end up with 10MBit/Half on a
-	 * 1GBit link after resuming from S3. For whatever reason the PHY on
-	 * these chips doesn't properly start a renegotiation when soft-reset.
-	 * Explicitly requesting a renegotiation fixes this.
-	 */
-	if (dev->phydev->autoneg == AUTONEG_ENABLE)
-		phy_restart_aneg(dev->phydev);
-}
-
-static void rtl_rar_set(struct rtl8169_private *tp, u8 *addr)
-{
-	rtl_lock_work(tp);
-
-	RTL_W8(tp, Cfg9346, Cfg9346_Unlock);
-
-	RTL_W32(tp, MAC4, addr[4] | addr[5] << 8);
-	RTL_R32(tp, MAC4);
-
-	RTL_W32(tp, MAC0, addr[0] | addr[1] << 8 | addr[2] << 16 | addr[3] << 24);
-	RTL_R32(tp, MAC0);
-
-	if (tp->mac_version == RTL_GIGA_MAC_VER_34)
-		rtl_rar_exgmac_set(tp, addr);
-
-	RTL_W8(tp, Cfg9346, Cfg9346_Lock);
-
-	rtl_unlock_work(tp);
-}
-
-static void rtl_init_rxcfg(struct rtl8169_private *tp)
-{
-	switch (tp->mac_version) {
-	case RTL_GIGA_MAC_VER_01 ... RTL_GIGA_MAC_VER_06:
-	case RTL_GIGA_MAC_VER_10 ... RTL_GIGA_MAC_VER_17:
-		RTL_W32(tp, RxConfig, RX_FIFO_THRESH | RX_DMA_BURST);
-		break;
-	case RTL_GIGA_MAC_VER_18 ... RTL_GIGA_MAC_VER_24:
-	case RTL_GIGA_MAC_VER_34 ... RTL_GIGA_MAC_VER_36:
-	case RTL_GIGA_MAC_VER_38:
-		RTL_W32(tp, RxConfig, RX128_INT_EN | RX_MULTI_EN | RX_DMA_BURST);
-		break;
-	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_51:
-		RTL_W32(tp, RxConfig, RX128_INT_EN | RX_MULTI_EN | RX_DMA_BURST | RX_EARLY_OFF);
-		break;
-	default:
-		RTL_W32(tp, RxConfig, RX128_INT_EN | RX_DMA_BURST);
-		break;
-	}
-}
-
-static int rtl_set_mac_address(struct net_device *dev, void *p)
-{
-	struct rtl8169_private *tp = netdev_priv(dev);
-	struct device *d = tp_to_dev(tp);
-	int ret;
-
-	ret = eth_mac_addr(dev, p);
-	if (ret)
-		return ret;
-
-	pm_runtime_get_noresume(d);
-
-	if (pm_runtime_active(d))
-		rtl_rar_set(tp, dev->dev_addr);
-
-	pm_runtime_put_noidle(d);
-
-	/* Reportedly at least Asus X453MA truncates packets otherwise */
-	if (tp->mac_version == RTL_GIGA_MAC_VER_37)
-		rtl_init_rxcfg(tp);
-
-	return 0;
-}
-
-static int rtl8169_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
-{
-	if (!netif_running(dev))
-		return -ENODEV;
-
-	return phy_mii_ioctl(dev->phydev, ifr, cmd);
-}
-
-static void rtl_init_mdio_ops(struct rtl8169_private *tp)
-{
-	struct mdio_ops *ops = &tp->mdio_ops;
-
-	switch (tp->mac_version) {
-	case RTL_GIGA_MAC_VER_27:
-		ops->write	= r8168dp_1_mdio_write;
-		ops->read	= r8168dp_1_mdio_read;
-		break;
-	case RTL_GIGA_MAC_VER_28:
-	case RTL_GIGA_MAC_VER_31:
-		ops->write	= r8168dp_2_mdio_write;
-		ops->read	= r8168dp_2_mdio_read;
-		break;
-	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_51:
-		ops->write	= r8168g_mdio_write;
-		ops->read	= r8168g_mdio_read;
-		break;
-	default:
-		ops->write	= r8169_mdio_write;
-		ops->read	= r8169_mdio_read;
-		break;
-	}
-}
-
-static void rtl_wol_suspend_quirk(struct rtl8169_private *tp)
-{
-	switch (tp->mac_version) {
-	case RTL_GIGA_MAC_VER_25:
-	case RTL_GIGA_MAC_VER_26:
-	case RTL_GIGA_MAC_VER_29:
-	case RTL_GIGA_MAC_VER_30:
-	case RTL_GIGA_MAC_VER_32:
-	case RTL_GIGA_MAC_VER_33:
-	case RTL_GIGA_MAC_VER_34:
-	case RTL_GIGA_MAC_VER_37 ... RTL_GIGA_MAC_VER_51:
-		RTL_W32(tp, RxConfig, RTL_R32(tp, RxConfig) |
-			AcceptBroadcast | AcceptMulticast | AcceptMyPhys);
-		break;
-	default:
-		break;
-	}
-}
-
-static bool rtl_wol_pll_power_down(struct rtl8169_private *tp)
-{
-	struct phy_device *phydev;
-
-	if (!__rtl8169_get_wol(tp))
-		return false;
-
-	/* phydev may not be attached to netdevice */
-	phydev = mdiobus_get_phy(tp->mii_bus, 0);
-
-	phy_speed_down(phydev, false);
-	rtl_wol_suspend_quirk(tp);
-
-	return true;
-}
-
-static void r8168_pll_power_down(struct rtl8169_private *tp)
-{
-	if (r8168_check_dash(tp))
-		return;
-
-	if (tp->mac_version == RTL_GIGA_MAC_VER_32 ||
-	    tp->mac_version == RTL_GIGA_MAC_VER_33)
-		rtl_ephy_write(tp, 0x19, 0xff64);
-
-	if (rtl_wol_pll_power_down(tp))
-		return;
-
-	switch (tp->mac_version) {
-	case RTL_GIGA_MAC_VER_25 ... RTL_GIGA_MAC_VER_26:
-	case RTL_GIGA_MAC_VER_29 ... RTL_GIGA_MAC_VER_30:
-	case RTL_GIGA_MAC_VER_32 ... RTL_GIGA_MAC_VER_33:
-	case RTL_GIGA_MAC_VER_37:
-	case RTL_GIGA_MAC_VER_39:
-	case RTL_GIGA_MAC_VER_43:
-	case RTL_GIGA_MAC_VER_44:
-	case RTL_GIGA_MAC_VER_45:
-	case RTL_GIGA_MAC_VER_46:
-	case RTL_GIGA_MAC_VER_47:
-	case RTL_GIGA_MAC_VER_48:
-	case RTL_GIGA_MAC_VER_50:
-	case RTL_GIGA_MAC_VER_51:
-		RTL_W8(tp, PMCH, RTL_R8(tp, PMCH) & ~0x80);
-		break;
-	case RTL_GIGA_MAC_VER_40:
-	case RTL_GIGA_MAC_VER_41:
-	case RTL_GIGA_MAC_VER_49:
-		rtl_w0w1_eri(tp, 0x1a8, ERIAR_MASK_1111, 0x00000000,
-			     0xfc000000, ERIAR_EXGMAC);
-		RTL_W8(tp, PMCH, RTL_R8(tp, PMCH) & ~0x80);
-		break;
-	}
-}
-
-static void r8168_pll_power_up(struct rtl8169_private *tp)
-{
-	switch (tp->mac_version) {
-	case RTL_GIGA_MAC_VER_25 ... RTL_GIGA_MAC_VER_26:
-	case RTL_GIGA_MAC_VER_29 ... RTL_GIGA_MAC_VER_30:
-	case RTL_GIGA_MAC_VER_32 ... RTL_GIGA_MAC_VER_33:
-	case RTL_GIGA_MAC_VER_37:
-	case RTL_GIGA_MAC_VER_39:
-	case RTL_GIGA_MAC_VER_43:
-		RTL_W8(tp, PMCH, RTL_R8(tp, PMCH) | 0x80);
-		break;
-	case RTL_GIGA_MAC_VER_44:
-	case RTL_GIGA_MAC_VER_45:
-	case RTL_GIGA_MAC_VER_46:
-	case RTL_GIGA_MAC_VER_47:
-	case RTL_GIGA_MAC_VER_48:
-	case RTL_GIGA_MAC_VER_50:
-	case RTL_GIGA_MAC_VER_51:
-		RTL_W8(tp, PMCH, RTL_R8(tp, PMCH) | 0xc0);
-		break;
-	case RTL_GIGA_MAC_VER_40:
-	case RTL_GIGA_MAC_VER_41:
-	case RTL_GIGA_MAC_VER_49:
-		RTL_W8(tp, PMCH, RTL_R8(tp, PMCH) | 0xc0);
-		rtl_w0w1_eri(tp, 0x1a8, ERIAR_MASK_1111, 0xfc000000,
-			     0x00000000, ERIAR_EXGMAC);
-		break;
-	}
-
-	phy_resume(tp->dev->phydev);
-	/* give MAC/PHY some time to resume */
-	msleep(20);
-}
-
-static void rtl_pll_power_down(struct rtl8169_private *tp)
-{
-	switch (tp->mac_version) {
-	case RTL_GIGA_MAC_VER_01 ... RTL_GIGA_MAC_VER_06:
-	case RTL_GIGA_MAC_VER_13 ... RTL_GIGA_MAC_VER_15:
-		break;
-	default:
-		r8168_pll_power_down(tp);
-	}
-}
-
-static void rtl_pll_power_up(struct rtl8169_private *tp)
-{
-	switch (tp->mac_version) {
-	case RTL_GIGA_MAC_VER_01 ... RTL_GIGA_MAC_VER_06:
-	case RTL_GIGA_MAC_VER_13 ... RTL_GIGA_MAC_VER_15:
-		break;
-	default:
-		r8168_pll_power_up(tp);
-	}
-}
-
-static void rtl8169_init_ring_indexes(struct rtl8169_private *tp)
-{
-	tp->dirty_tx = tp->cur_tx = tp->cur_rx = 0;
-}
-
-static void rtl_hw_jumbo_enable(struct rtl8169_private *tp)
-{
-	if (tp->jumbo_ops.enable) {
-		RTL_W8(tp, Cfg9346, Cfg9346_Unlock);
-		tp->jumbo_ops.enable(tp);
-		RTL_W8(tp, Cfg9346, Cfg9346_Lock);
-	}
-}
-
-static void rtl_hw_jumbo_disable(struct rtl8169_private *tp)
-{
-	if (tp->jumbo_ops.disable) {
-		RTL_W8(tp, Cfg9346, Cfg9346_Unlock);
-		tp->jumbo_ops.disable(tp);
-		RTL_W8(tp, Cfg9346, Cfg9346_Lock);
-	}
-}
-
-static void r8168c_hw_jumbo_enable(struct rtl8169_private *tp)
-{
-	RTL_W8(tp, Config3, RTL_R8(tp, Config3) | Jumbo_En0);
-	RTL_W8(tp, Config4, RTL_R8(tp, Config4) | Jumbo_En1);
-	rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_512B);
-}
-
-static void r8168c_hw_jumbo_disable(struct rtl8169_private *tp)
-{
-	RTL_W8(tp, Config3, RTL_R8(tp, Config3) & ~Jumbo_En0);
-	RTL_W8(tp, Config4, RTL_R8(tp, Config4) & ~Jumbo_En1);
-	rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
-}
-
-static void r8168dp_hw_jumbo_enable(struct rtl8169_private *tp)
-{
-	RTL_W8(tp, Config3, RTL_R8(tp, Config3) | Jumbo_En0);
-}
-
-static void r8168dp_hw_jumbo_disable(struct rtl8169_private *tp)
-{
-	RTL_W8(tp, Config3, RTL_R8(tp, Config3) & ~Jumbo_En0);
-}
-
-static void r8168e_hw_jumbo_enable(struct rtl8169_private *tp)
-{
-	RTL_W8(tp, MaxTxPacketSize, 0x24);
-	RTL_W8(tp, Config3, RTL_R8(tp, Config3) | Jumbo_En0);
-	RTL_W8(tp, Config4, RTL_R8(tp, Config4) | 0x01);
-	rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_512B);
-}
-
-static void r8168e_hw_jumbo_disable(struct rtl8169_private *tp)
-{
-	RTL_W8(tp, MaxTxPacketSize, 0x3f);
-	RTL_W8(tp, Config3, RTL_R8(tp, Config3) & ~Jumbo_En0);
-	RTL_W8(tp, Config4, RTL_R8(tp, Config4) & ~0x01);
-	rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
-}
-
-static void r8168b_0_hw_jumbo_enable(struct rtl8169_private *tp)
-{
-	rtl_tx_performance_tweak(tp,
-		PCI_EXP_DEVCTL_READRQ_512B | PCI_EXP_DEVCTL_NOSNOOP_EN);
-}
-
-static void r8168b_0_hw_jumbo_disable(struct rtl8169_private *tp)
-{
-	rtl_tx_performance_tweak(tp,
-		PCI_EXP_DEVCTL_READRQ_4096B | PCI_EXP_DEVCTL_NOSNOOP_EN);
-}
-
-static void r8168b_1_hw_jumbo_enable(struct rtl8169_private *tp)
-{
-	r8168b_0_hw_jumbo_enable(tp);
-
-	RTL_W8(tp, Config4, RTL_R8(tp, Config4) | (1 << 0));
-}
-
-static void r8168b_1_hw_jumbo_disable(struct rtl8169_private *tp)
-{
-	r8168b_0_hw_jumbo_disable(tp);
-
-	RTL_W8(tp, Config4, RTL_R8(tp, Config4) & ~(1 << 0));
-}
-
-static void rtl_init_jumbo_ops(struct rtl8169_private *tp)
-{
-	struct jumbo_ops *ops = &tp->jumbo_ops;
-
-	switch (tp->mac_version) {
-	case RTL_GIGA_MAC_VER_11:
-		ops->disable	= r8168b_0_hw_jumbo_disable;
-		ops->enable	= r8168b_0_hw_jumbo_enable;
-		break;
-	case RTL_GIGA_MAC_VER_12:
-	case RTL_GIGA_MAC_VER_17:
-		ops->disable	= r8168b_1_hw_jumbo_disable;
-		ops->enable	= r8168b_1_hw_jumbo_enable;
-		break;
-	case RTL_GIGA_MAC_VER_18: /* Wild guess. Needs info from Realtek. */
-	case RTL_GIGA_MAC_VER_19:
-	case RTL_GIGA_MAC_VER_20:
-	case RTL_GIGA_MAC_VER_21: /* Wild guess. Needs info from Realtek. */
-	case RTL_GIGA_MAC_VER_22:
-	case RTL_GIGA_MAC_VER_23:
-	case RTL_GIGA_MAC_VER_24:
-	case RTL_GIGA_MAC_VER_25:
-	case RTL_GIGA_MAC_VER_26:
-		ops->disable	= r8168c_hw_jumbo_disable;
-		ops->enable	= r8168c_hw_jumbo_enable;
-		break;
-	case RTL_GIGA_MAC_VER_27:
-	case RTL_GIGA_MAC_VER_28:
-		ops->disable	= r8168dp_hw_jumbo_disable;
-		ops->enable	= r8168dp_hw_jumbo_enable;
-		break;
-	case RTL_GIGA_MAC_VER_31: /* Wild guess. Needs info from Realtek. */
-	case RTL_GIGA_MAC_VER_32:
-	case RTL_GIGA_MAC_VER_33:
-	case RTL_GIGA_MAC_VER_34:
-		ops->disable	= r8168e_hw_jumbo_disable;
-		ops->enable	= r8168e_hw_jumbo_enable;
-		break;
-
-	/*
-	 * No action needed for jumbo frames with 8169.
-	 * No jumbo for 810x at all.
-	 */
-	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_51:
-	default:
-		ops->disable	= NULL;
-		ops->enable	= NULL;
-		break;
-	}
-}
-
-DECLARE_RTL_COND(rtl_chipcmd_cond)
-{
-	return RTL_R8(tp, ChipCmd) & CmdReset;
-}
-
-static void rtl_hw_reset(struct rtl8169_private *tp)
-{
-	RTL_W8(tp, ChipCmd, CmdReset);
-
-	rtl_udelay_loop_wait_low(tp, &rtl_chipcmd_cond, 100, 100);
-}
-
-static void rtl_request_uncached_firmware(struct rtl8169_private *tp)
-{
-	struct rtl_fw *rtl_fw;
-	const char *name;
-	int rc = -ENOMEM;
-
-	name = rtl_lookup_firmware_name(tp);
-	if (!name)
-		goto out_no_firmware;
-
-	rtl_fw = kzalloc(sizeof(*rtl_fw), GFP_KERNEL);
-	if (!rtl_fw)
-		goto err_warn;
-
-	rc = request_firmware(&rtl_fw->fw, name, tp_to_dev(tp));
-	if (rc < 0)
-		goto err_free;
-
-	rc = rtl_check_firmware(tp, rtl_fw);
-	if (rc < 0)
-		goto err_release_firmware;
-
-	tp->rtl_fw = rtl_fw;
-out:
-	return;
-
-err_release_firmware:
-	release_firmware(rtl_fw->fw);
-err_free:
-	kfree(rtl_fw);
-err_warn:
-	netif_warn(tp, ifup, tp->dev, "unable to load firmware patch %s (%d)\n",
-		   name, rc);
-out_no_firmware:
-	tp->rtl_fw = NULL;
-	goto out;
-}
-
-static void rtl_request_firmware(struct rtl8169_private *tp)
-{
-	if (IS_ERR(tp->rtl_fw))
-		rtl_request_uncached_firmware(tp);
-}
-
-static void rtl_rx_close(struct rtl8169_private *tp)
-{
-	RTL_W32(tp, RxConfig, RTL_R32(tp, RxConfig) & ~RX_CONFIG_ACCEPT_MASK);
-}
-
-DECLARE_RTL_COND(rtl_npq_cond)
-{
-	return RTL_R8(tp, TxPoll) & NPQ;
-}
-
-DECLARE_RTL_COND(rtl_txcfg_empty_cond)
-{
-	return RTL_R32(tp, TxConfig) & TXCFG_EMPTY;
-}
-
-static void rtl8169_hw_reset(struct rtl8169_private *tp)
-{
-	/* Disable interrupts */
-	rtl8169_irq_mask_and_ack(tp);
-
-	rtl_rx_close(tp);
-
-	switch (tp->mac_version) {
-	case RTL_GIGA_MAC_VER_27:
-	case RTL_GIGA_MAC_VER_28:
-	case RTL_GIGA_MAC_VER_31:
-		rtl_udelay_loop_wait_low(tp, &rtl_npq_cond, 20, 42*42);
-		break;
-	case RTL_GIGA_MAC_VER_34 ... RTL_GIGA_MAC_VER_38:
-	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_51:
-		RTL_W8(tp, ChipCmd, RTL_R8(tp, ChipCmd) | StopReq);
-		rtl_udelay_loop_wait_high(tp, &rtl_txcfg_empty_cond, 100, 666);
-		break;
-	default:
-		RTL_W8(tp, ChipCmd, RTL_R8(tp, ChipCmd) | StopReq);
-		udelay(100);
-		break;
-	}
-
-	rtl_hw_reset(tp);
-}
-
-static void rtl_set_tx_config_registers(struct rtl8169_private *tp)
-{
-	u32 val = TX_DMA_BURST << TxDMAShift |
-		  InterFrameGap << TxInterFrameGapShift;
-
-	if (tp->mac_version >= RTL_GIGA_MAC_VER_34 &&
-	    tp->mac_version != RTL_GIGA_MAC_VER_39)
-		val |= TXCFG_AUTO_FIFO;
-
-	RTL_W32(tp, TxConfig, val);
-}
-
-static void rtl_set_rx_max_size(struct rtl8169_private *tp)
-{
-	/* Low hurts. Let's disable the filtering. */
-	RTL_W16(tp, RxMaxSize, R8169_RX_BUF_SIZE + 1);
-}
-
-static void rtl_set_rx_tx_desc_registers(struct rtl8169_private *tp)
-{
-	/*
-	 * Magic spell: some iop3xx ARM board needs the TxDescAddrHigh
-	 * register to be written before TxDescAddrLow to work.
-	 * Switching from MMIO to I/O access fixes the issue as well.
-	 */
-	RTL_W32(tp, TxDescStartAddrHigh, ((u64) tp->TxPhyAddr) >> 32);
-	RTL_W32(tp, TxDescStartAddrLow, ((u64) tp->TxPhyAddr) & DMA_BIT_MASK(32));
-	RTL_W32(tp, RxDescAddrHigh, ((u64) tp->RxPhyAddr) >> 32);
-	RTL_W32(tp, RxDescAddrLow, ((u64) tp->RxPhyAddr) & DMA_BIT_MASK(32));
-}
-
-static void rtl8169_set_magic_reg(struct rtl8169_private *tp, unsigned mac_version)
-{
-	static const struct rtl_cfg2_info {
-		u32 mac_version;
-		u32 clk;
-		u32 val;
-	} cfg2_info [] = {
-		{ RTL_GIGA_MAC_VER_05, PCI_Clock_33MHz, 0x000fff00 }, // 8110SCd
-		{ RTL_GIGA_MAC_VER_05, PCI_Clock_66MHz, 0x000fffff },
-		{ RTL_GIGA_MAC_VER_06, PCI_Clock_33MHz, 0x00ffff00 }, // 8110SCe
-		{ RTL_GIGA_MAC_VER_06, PCI_Clock_66MHz, 0x00ffffff }
-	};
-	const struct rtl_cfg2_info *p = cfg2_info;
-	unsigned int i;
-	u32 clk;
-
-	clk = RTL_R8(tp, Config2) & PCI_Clock_66MHz;
-	for (i = 0; i < ARRAY_SIZE(cfg2_info); i++, p++) {
-		if ((p->mac_version == mac_version) && (p->clk == clk)) {
-			RTL_W32(tp, 0x7c, p->val);
-			break;
-		}
-	}
-}
-
-static void rtl_set_rx_mode(struct net_device *dev)
-{
-	struct rtl8169_private *tp = netdev_priv(dev);
-	u32 mc_filter[2];	/* Multicast hash filter */
-	int rx_mode;
-	u32 tmp = 0;
-
-	if (dev->flags & IFF_PROMISC) {
-		/* Unconditionally log net taps. */
-		netif_notice(tp, link, dev, "Promiscuous mode enabled\n");
-		rx_mode =
-		    AcceptBroadcast | AcceptMulticast | AcceptMyPhys |
-		    AcceptAllPhys;
-		mc_filter[1] = mc_filter[0] = 0xffffffff;
-	} else if ((netdev_mc_count(dev) > multicast_filter_limit) ||
-		   (dev->flags & IFF_ALLMULTI)) {
-		/* Too many to filter perfectly -- accept all multicasts. */
-		rx_mode = AcceptBroadcast | AcceptMulticast | AcceptMyPhys;
-		mc_filter[1] = mc_filter[0] = 0xffffffff;
-	} else {
-		struct netdev_hw_addr *ha;
-
-		rx_mode = AcceptBroadcast | AcceptMyPhys;
-		mc_filter[1] = mc_filter[0] = 0;
-		netdev_for_each_mc_addr(ha, dev) {
-			int bit_nr = ether_crc(ETH_ALEN, ha->addr) >> 26;
-			mc_filter[bit_nr >> 5] |= 1 << (bit_nr & 31);
-			rx_mode |= AcceptMulticast;
-		}
-	}
-
-	if (dev->features & NETIF_F_RXALL)
-		rx_mode |= (AcceptErr | AcceptRunt);
-
-	tmp = (RTL_R32(tp, RxConfig) & ~RX_CONFIG_ACCEPT_MASK) | rx_mode;
-
-	if (tp->mac_version > RTL_GIGA_MAC_VER_06) {
-		u32 data = mc_filter[0];
-
-		mc_filter[0] = swab32(mc_filter[1]);
-		mc_filter[1] = swab32(data);
-	}
-
-	if (tp->mac_version == RTL_GIGA_MAC_VER_35)
-		mc_filter[1] = mc_filter[0] = 0xffffffff;
-
-	RTL_W32(tp, MAR0 + 4, mc_filter[1]);
-	RTL_W32(tp, MAR0 + 0, mc_filter[0]);
-
-	RTL_W32(tp, RxConfig, tmp);
-}
-
-static void rtl_hw_start(struct  rtl8169_private *tp)
-{
-	RTL_W8(tp, Cfg9346, Cfg9346_Unlock);
-
-	tp->hw_start(tp);
-
-	rtl_set_rx_max_size(tp);
-	rtl_set_rx_tx_desc_registers(tp);
-	RTL_W8(tp, Cfg9346, Cfg9346_Lock);
-
-	/* Initially a 10 us delay. Turned it into a PCI commit. - FR */
-	RTL_R8(tp, IntrMask);
-	RTL_W8(tp, ChipCmd, CmdTxEnb | CmdRxEnb);
-	rtl_init_rxcfg(tp);
-	rtl_set_tx_config_registers(tp);
-
-	rtl_set_rx_mode(tp->dev);
-	/* no early-rx interrupts */
-	RTL_W16(tp, MultiIntr, RTL_R16(tp, MultiIntr) & 0xf000);
-	rtl_irq_enable_all(tp);
-}
-
-static void rtl_hw_start_8169(struct rtl8169_private *tp)
-{
-	if (tp->mac_version == RTL_GIGA_MAC_VER_05)
-		pci_write_config_byte(tp->pci_dev, PCI_CACHE_LINE_SIZE, 0x08);
-
-	RTL_W8(tp, EarlyTxThres, NoEarlyTx);
-
-	tp->cp_cmd |= PCIMulRW;
-
-	if (tp->mac_version == RTL_GIGA_MAC_VER_02 ||
-	    tp->mac_version == RTL_GIGA_MAC_VER_03) {
-		netif_dbg(tp, drv, tp->dev,
-			  "Set MAC Reg C+CR Offset 0xe0. Bit 3 and Bit 14 MUST be 1\n");
-		tp->cp_cmd |= (1 << 14);
-	}
-
-	RTL_W16(tp, CPlusCmd, tp->cp_cmd);
-
-	rtl8169_set_magic_reg(tp, tp->mac_version);
-
-	/*
-	 * Undocumented corner. Supposedly:
-	 * (TxTimer << 12) | (TxPackets << 8) | (RxTimer << 4) | RxPackets
-	 */
-	RTL_W16(tp, IntrMitigate, 0x0000);
-
-	RTL_W32(tp, RxMissed, 0);
-}
-
-DECLARE_RTL_COND(rtl_csiar_cond)
-{
-	return RTL_R32(tp, CSIAR) & CSIAR_FLAG;
-}
-
-static void rtl_csi_write(struct rtl8169_private *tp, int addr, int value)
-{
-	u32 func = PCI_FUNC(tp->pci_dev->devfn);
-
-	RTL_W32(tp, CSIDR, value);
-	RTL_W32(tp, CSIAR, CSIAR_WRITE_CMD | (addr & CSIAR_ADDR_MASK) |
-		CSIAR_BYTE_ENABLE | func << 16);
-
-	rtl_udelay_loop_wait_low(tp, &rtl_csiar_cond, 10, 100);
-}
-
-static u32 rtl_csi_read(struct rtl8169_private *tp, int addr)
-{
-	u32 func = PCI_FUNC(tp->pci_dev->devfn);
-
-	RTL_W32(tp, CSIAR, (addr & CSIAR_ADDR_MASK) | func << 16 |
-		CSIAR_BYTE_ENABLE);
-
-	return rtl_udelay_loop_wait_high(tp, &rtl_csiar_cond, 10, 100) ?
-		RTL_R32(tp, CSIDR) : ~0;
-}
-
-static void rtl_csi_access_enable(struct rtl8169_private *tp, u8 val)
-{
-	struct pci_dev *pdev = tp->pci_dev;
-	u32 csi;
-
-	/* According to Realtek the value at config space address 0x070f
-	 * controls the L0s/L1 entrance latency. We try standard ECAM access
-	 * first and if it fails fall back to CSI.
-	 */
-	if (pdev->cfg_size > 0x070f &&
-	    pci_write_config_byte(pdev, 0x070f, val) == PCIBIOS_SUCCESSFUL)
-		return;
-
-	netdev_notice_once(tp->dev,
-		"No native access to PCI extended config space, falling back to CSI\n");
-	csi = rtl_csi_read(tp, 0x070c) & 0x00ffffff;
-	rtl_csi_write(tp, 0x070c, csi | val << 24);
-}
-
-static void rtl_set_def_aspm_entry_latency(struct rtl8169_private *tp)
-{
-	rtl_csi_access_enable(tp, 0x27);
-}
-
-struct ephy_info {
-	unsigned int offset;
-	u16 mask;
-	u16 bits;
-};
-
-static void rtl_ephy_init(struct rtl8169_private *tp, const struct ephy_info *e,
-			  int len)
-{
-	u16 w;
-
-	while (len-- > 0) {
-		w = (rtl_ephy_read(tp, e->offset) & ~e->mask) | e->bits;
-		rtl_ephy_write(tp, e->offset, w);
-		e++;
-	}
-}
-
-static void rtl_disable_clock_request(struct rtl8169_private *tp)
-{
-	pcie_capability_clear_word(tp->pci_dev, PCI_EXP_LNKCTL,
-				   PCI_EXP_LNKCTL_CLKREQ_EN);
-}
-
-static void rtl_enable_clock_request(struct rtl8169_private *tp)
-{
-	pcie_capability_set_word(tp->pci_dev, PCI_EXP_LNKCTL,
-				 PCI_EXP_LNKCTL_CLKREQ_EN);
-}
-
-static void rtl_pcie_state_l2l3_enable(struct rtl8169_private *tp, bool enable)
-{
-	u8 data;
-
-	data = RTL_R8(tp, Config3);
-
-	if (enable)
-		data |= Rdy_to_L23;
-	else
-		data &= ~Rdy_to_L23;
-
-	RTL_W8(tp, Config3, data);
-}
-
-static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
-{
-	if (enable) {
-		RTL_W8(tp, Config5, RTL_R8(tp, Config5) | ASPM_en);
-		RTL_W8(tp, Config2, RTL_R8(tp, Config2) | ClkReqEn);
-	} else {
-		RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
-		RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
-	}
-
-	udelay(10);
-}
-
-static void rtl_hw_start_8168bb(struct rtl8169_private *tp)
-{
-	RTL_W8(tp, Config3, RTL_R8(tp, Config3) & ~Beacon_en);
-
-	tp->cp_cmd &= CPCMD_QUIRK_MASK;
-	RTL_W16(tp, CPlusCmd, tp->cp_cmd);
-
-	if (tp->dev->mtu <= ETH_DATA_LEN) {
-		rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B |
-					 PCI_EXP_DEVCTL_NOSNOOP_EN);
-	}
-}
-
-static void rtl_hw_start_8168bef(struct rtl8169_private *tp)
-{
-	rtl_hw_start_8168bb(tp);
-
-	RTL_W8(tp, MaxTxPacketSize, TxPacketMax);
-
-	RTL_W8(tp, Config4, RTL_R8(tp, Config4) & ~(1 << 0));
-}
-
-static void __rtl_hw_start_8168cp(struct rtl8169_private *tp)
-{
-	RTL_W8(tp, Config1, RTL_R8(tp, Config1) | Speed_down);
-
-	RTL_W8(tp, Config3, RTL_R8(tp, Config3) & ~Beacon_en);
-
-	if (tp->dev->mtu <= ETH_DATA_LEN)
-		rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
-
-	rtl_disable_clock_request(tp);
-
-	tp->cp_cmd &= CPCMD_QUIRK_MASK;
-	RTL_W16(tp, CPlusCmd, tp->cp_cmd);
-}
-
-static void rtl_hw_start_8168cp_1(struct rtl8169_private *tp)
-{
-	static const struct ephy_info e_info_8168cp[] = {
-		{ 0x01, 0,	0x0001 },
-		{ 0x02, 0x0800,	0x1000 },
-		{ 0x03, 0,	0x0042 },
-		{ 0x06, 0x0080,	0x0000 },
-		{ 0x07, 0,	0x2000 }
-	};
-
-	rtl_set_def_aspm_entry_latency(tp);
-
-	rtl_ephy_init(tp, e_info_8168cp, ARRAY_SIZE(e_info_8168cp));
-
-	__rtl_hw_start_8168cp(tp);
-}
-
-static void rtl_hw_start_8168cp_2(struct rtl8169_private *tp)
-{
-	rtl_set_def_aspm_entry_latency(tp);
-
-	RTL_W8(tp, Config3, RTL_R8(tp, Config3) & ~Beacon_en);
-
-	if (tp->dev->mtu <= ETH_DATA_LEN)
-		rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
-
-	tp->cp_cmd &= CPCMD_QUIRK_MASK;
-	RTL_W16(tp, CPlusCmd, tp->cp_cmd);
-}
-
-static void rtl_hw_start_8168cp_3(struct rtl8169_private *tp)
-{
-	rtl_set_def_aspm_entry_latency(tp);
-
-	RTL_W8(tp, Config3, RTL_R8(tp, Config3) & ~Beacon_en);
-
-	/* Magic. */
-	RTL_W8(tp, DBG_REG, 0x20);
-
-	RTL_W8(tp, MaxTxPacketSize, TxPacketMax);
-
-	if (tp->dev->mtu <= ETH_DATA_LEN)
-		rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
-
-	tp->cp_cmd &= CPCMD_QUIRK_MASK;
-	RTL_W16(tp, CPlusCmd, tp->cp_cmd);
-}
-
-static void rtl_hw_start_8168c_1(struct rtl8169_private *tp)
-{
-	static const struct ephy_info e_info_8168c_1[] = {
-		{ 0x02, 0x0800,	0x1000 },
-		{ 0x03, 0,	0x0002 },
-		{ 0x06, 0x0080,	0x0000 }
-	};
-
-	rtl_set_def_aspm_entry_latency(tp);
-
-	RTL_W8(tp, DBG_REG, 0x06 | FIX_NAK_1 | FIX_NAK_2);
-
-	rtl_ephy_init(tp, e_info_8168c_1, ARRAY_SIZE(e_info_8168c_1));
-
-	__rtl_hw_start_8168cp(tp);
-}
-
-static void rtl_hw_start_8168c_2(struct rtl8169_private *tp)
-{
-	static const struct ephy_info e_info_8168c_2[] = {
-		{ 0x01, 0,	0x0001 },
-		{ 0x03, 0x0400,	0x0220 }
-	};
-
-	rtl_set_def_aspm_entry_latency(tp);
-
-	rtl_ephy_init(tp, e_info_8168c_2, ARRAY_SIZE(e_info_8168c_2));
-
-	__rtl_hw_start_8168cp(tp);
-}
-
-static void rtl_hw_start_8168c_3(struct rtl8169_private *tp)
-{
-	rtl_hw_start_8168c_2(tp);
-}
-
-static void rtl_hw_start_8168c_4(struct rtl8169_private *tp)
-{
-	rtl_set_def_aspm_entry_latency(tp);
-
-	__rtl_hw_start_8168cp(tp);
-}
-
-static void rtl_hw_start_8168d(struct rtl8169_private *tp)
-{
-	rtl_set_def_aspm_entry_latency(tp);
-
-	rtl_disable_clock_request(tp);
-
-	RTL_W8(tp, MaxTxPacketSize, TxPacketMax);
-
-	if (tp->dev->mtu <= ETH_DATA_LEN)
-		rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
-
-	tp->cp_cmd &= CPCMD_QUIRK_MASK;
-	RTL_W16(tp, CPlusCmd, tp->cp_cmd);
-}
-
-static void rtl_hw_start_8168dp(struct rtl8169_private *tp)
-{
-	rtl_set_def_aspm_entry_latency(tp);
-
-	if (tp->dev->mtu <= ETH_DATA_LEN)
-		rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
-
-	RTL_W8(tp, MaxTxPacketSize, TxPacketMax);
-
-	rtl_disable_clock_request(tp);
-}
-
-static void rtl_hw_start_8168d_4(struct rtl8169_private *tp)
-{
-	static const struct ephy_info e_info_8168d_4[] = {
-		{ 0x0b, 0x0000,	0x0048 },
-		{ 0x19, 0x0020,	0x0050 },
-		{ 0x0c, 0x0100,	0x0020 }
-	};
-
-	rtl_set_def_aspm_entry_latency(tp);
-
-	rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
-
-	RTL_W8(tp, MaxTxPacketSize, TxPacketMax);
-
-	rtl_ephy_init(tp, e_info_8168d_4, ARRAY_SIZE(e_info_8168d_4));
-
-	rtl_enable_clock_request(tp);
-}
-
-static void rtl_hw_start_8168e_1(struct rtl8169_private *tp)
-{
-	static const struct ephy_info e_info_8168e_1[] = {
-		{ 0x00, 0x0200,	0x0100 },
-		{ 0x00, 0x0000,	0x0004 },
-		{ 0x06, 0x0002,	0x0001 },
-		{ 0x06, 0x0000,	0x0030 },
-		{ 0x07, 0x0000,	0x2000 },
-		{ 0x00, 0x0000,	0x0020 },
-		{ 0x03, 0x5800,	0x2000 },
-		{ 0x03, 0x0000,	0x0001 },
-		{ 0x01, 0x0800,	0x1000 },
-		{ 0x07, 0x0000,	0x4000 },
-		{ 0x1e, 0x0000,	0x2000 },
-		{ 0x19, 0xffff,	0xfe6c },
-		{ 0x0a, 0x0000,	0x0040 }
-	};
-
-	rtl_set_def_aspm_entry_latency(tp);
-
-	rtl_ephy_init(tp, e_info_8168e_1, ARRAY_SIZE(e_info_8168e_1));
-
-	if (tp->dev->mtu <= ETH_DATA_LEN)
-		rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
-
-	RTL_W8(tp, MaxTxPacketSize, TxPacketMax);
-
-	rtl_disable_clock_request(tp);
-
-	/* Reset tx FIFO pointer */
-	RTL_W32(tp, MISC, RTL_R32(tp, MISC) | TXPLA_RST);
-	RTL_W32(tp, MISC, RTL_R32(tp, MISC) & ~TXPLA_RST);
-
-	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~Spi_en);
-}
-
-static void rtl_hw_start_8168e_2(struct rtl8169_private *tp)
-{
-	static const struct ephy_info e_info_8168e_2[] = {
-		{ 0x09, 0x0000,	0x0080 },
-		{ 0x19, 0x0000,	0x0224 }
-	};
-
-	rtl_set_def_aspm_entry_latency(tp);
-
-	rtl_ephy_init(tp, e_info_8168e_2, ARRAY_SIZE(e_info_8168e_2));
-
-	if (tp->dev->mtu <= ETH_DATA_LEN)
-		rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
-
-	rtl_eri_write(tp, 0xc0, ERIAR_MASK_0011, 0x0000, ERIAR_EXGMAC);
-	rtl_eri_write(tp, 0xb8, ERIAR_MASK_0011, 0x0000, ERIAR_EXGMAC);
-	rtl_eri_write(tp, 0xc8, ERIAR_MASK_1111, 0x00100002, ERIAR_EXGMAC);
-	rtl_eri_write(tp, 0xe8, ERIAR_MASK_1111, 0x00100006, ERIAR_EXGMAC);
-	rtl_eri_write(tp, 0xcc, ERIAR_MASK_1111, 0x00000050, ERIAR_EXGMAC);
-	rtl_eri_write(tp, 0xd0, ERIAR_MASK_1111, 0x07ff0060, ERIAR_EXGMAC);
-	rtl_w0w1_eri(tp, 0x1b0, ERIAR_MASK_0001, 0x10, 0x00, ERIAR_EXGMAC);
-	rtl_w0w1_eri(tp, 0x0d4, ERIAR_MASK_0011, 0x0c00, 0xff00, ERIAR_EXGMAC);
-
-	RTL_W8(tp, MaxTxPacketSize, EarlySize);
-
-	rtl_disable_clock_request(tp);
-
-	RTL_W8(tp, MCU, RTL_R8(tp, MCU) & ~NOW_IS_OOB);
-
-	/* Adjust EEE LED frequency */
-	RTL_W8(tp, EEE_LED, RTL_R8(tp, EEE_LED) & ~0x07);
-
-	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) | PFM_EN);
-	RTL_W32(tp, MISC, RTL_R32(tp, MISC) | PWM_EN);
-	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~Spi_en);
-
-	rtl_hw_aspm_clkreq_enable(tp, true);
-}
-
-static void rtl_hw_start_8168f(struct rtl8169_private *tp)
-{
-	rtl_set_def_aspm_entry_latency(tp);
-
-	rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
-
-	rtl_eri_write(tp, 0xc0, ERIAR_MASK_0011, 0x0000, ERIAR_EXGMAC);
-	rtl_eri_write(tp, 0xb8, ERIAR_MASK_0011, 0x0000, ERIAR_EXGMAC);
-	rtl_eri_write(tp, 0xc8, ERIAR_MASK_1111, 0x00100002, ERIAR_EXGMAC);
-	rtl_eri_write(tp, 0xe8, ERIAR_MASK_1111, 0x00100006, ERIAR_EXGMAC);
-	rtl_w0w1_eri(tp, 0xdc, ERIAR_MASK_0001, 0x00, 0x01, ERIAR_EXGMAC);
-	rtl_w0w1_eri(tp, 0xdc, ERIAR_MASK_0001, 0x01, 0x00, ERIAR_EXGMAC);
-	rtl_w0w1_eri(tp, 0x1b0, ERIAR_MASK_0001, 0x10, 0x00, ERIAR_EXGMAC);
-	rtl_w0w1_eri(tp, 0x1d0, ERIAR_MASK_0001, 0x10, 0x00, ERIAR_EXGMAC);
-	rtl_eri_write(tp, 0xcc, ERIAR_MASK_1111, 0x00000050, ERIAR_EXGMAC);
-	rtl_eri_write(tp, 0xd0, ERIAR_MASK_1111, 0x00000060, ERIAR_EXGMAC);
-
-	RTL_W8(tp, MaxTxPacketSize, EarlySize);
-
-	rtl_disable_clock_request(tp);
-
-	RTL_W8(tp, MCU, RTL_R8(tp, MCU) & ~NOW_IS_OOB);
-	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) | PFM_EN);
-	RTL_W32(tp, MISC, RTL_R32(tp, MISC) | PWM_EN);
-	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~Spi_en);
-}
-
-static void rtl_hw_start_8168f_1(struct rtl8169_private *tp)
-{
-	static const struct ephy_info e_info_8168f_1[] = {
-		{ 0x06, 0x00c0,	0x0020 },
-		{ 0x08, 0x0001,	0x0002 },
-		{ 0x09, 0x0000,	0x0080 },
-		{ 0x19, 0x0000,	0x0224 }
-	};
-
-	rtl_hw_start_8168f(tp);
-
-	rtl_ephy_init(tp, e_info_8168f_1, ARRAY_SIZE(e_info_8168f_1));
-
-	rtl_w0w1_eri(tp, 0x0d4, ERIAR_MASK_0011, 0x0c00, 0xff00, ERIAR_EXGMAC);
-
-	/* Adjust EEE LED frequency */
-	RTL_W8(tp, EEE_LED, RTL_R8(tp, EEE_LED) & ~0x07);
-}
-
-static void rtl_hw_start_8411(struct rtl8169_private *tp)
-{
-	static const struct ephy_info e_info_8168f_1[] = {
-		{ 0x06, 0x00c0,	0x0020 },
-		{ 0x0f, 0xffff,	0x5200 },
-		{ 0x1e, 0x0000,	0x4000 },
-		{ 0x19, 0x0000,	0x0224 }
-	};
-
-	rtl_hw_start_8168f(tp);
-	rtl_pcie_state_l2l3_enable(tp, false);
-
-	rtl_ephy_init(tp, e_info_8168f_1, ARRAY_SIZE(e_info_8168f_1));
-
-	rtl_w0w1_eri(tp, 0x0d4, ERIAR_MASK_0011, 0x0c00, 0x0000, ERIAR_EXGMAC);
-}
-
-static void rtl_hw_start_8168g(struct rtl8169_private *tp)
-{
-	rtl_eri_write(tp, 0xc8, ERIAR_MASK_0101, 0x080002, ERIAR_EXGMAC);
-	rtl_eri_write(tp, 0xcc, ERIAR_MASK_0001, 0x38, ERIAR_EXGMAC);
-	rtl_eri_write(tp, 0xd0, ERIAR_MASK_0001, 0x48, ERIAR_EXGMAC);
-	rtl_eri_write(tp, 0xe8, ERIAR_MASK_1111, 0x00100006, ERIAR_EXGMAC);
-
-	rtl_set_def_aspm_entry_latency(tp);
-
-	rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
-
-	rtl_w0w1_eri(tp, 0xdc, ERIAR_MASK_0001, 0x00, 0x01, ERIAR_EXGMAC);
-	rtl_w0w1_eri(tp, 0xdc, ERIAR_MASK_0001, 0x01, 0x00, ERIAR_EXGMAC);
-	rtl_eri_write(tp, 0x2f8, ERIAR_MASK_0011, 0x1d8f, ERIAR_EXGMAC);
-
-	RTL_W32(tp, MISC, RTL_R32(tp, MISC) & ~RXDV_GATED_EN);
-	RTL_W8(tp, MaxTxPacketSize, EarlySize);
-
-	rtl_eri_write(tp, 0xc0, ERIAR_MASK_0011, 0x0000, ERIAR_EXGMAC);
-	rtl_eri_write(tp, 0xb8, ERIAR_MASK_0011, 0x0000, ERIAR_EXGMAC);
-
-	/* Adjust EEE LED frequency */
-	RTL_W8(tp, EEE_LED, RTL_R8(tp, EEE_LED) & ~0x07);
-
-	rtl_w0w1_eri(tp, 0x2fc, ERIAR_MASK_0001, 0x01, 0x06, ERIAR_EXGMAC);
-	rtl_w0w1_eri(tp, 0x1b0, ERIAR_MASK_0011, 0x0000, 0x1000, ERIAR_EXGMAC);
-
-	rtl_pcie_state_l2l3_enable(tp, false);
-}
-
-static void rtl_hw_start_8168g_1(struct rtl8169_private *tp)
-{
-	static const struct ephy_info e_info_8168g_1[] = {
-		{ 0x00, 0x0000,	0x0008 },
-		{ 0x0c, 0x37d0,	0x0820 },
-		{ 0x1e, 0x0000,	0x0001 },
-		{ 0x19, 0x8000,	0x0000 }
-	};
-
-	rtl_hw_start_8168g(tp);
-
-	/* disable aspm and clock request before access ephy */
-	rtl_hw_aspm_clkreq_enable(tp, false);
-	rtl_ephy_init(tp, e_info_8168g_1, ARRAY_SIZE(e_info_8168g_1));
-	rtl_hw_aspm_clkreq_enable(tp, true);
-}
-
-static void rtl_hw_start_8168g_2(struct rtl8169_private *tp)
-{
-	static const struct ephy_info e_info_8168g_2[] = {
-		{ 0x00, 0x0000,	0x0008 },
-		{ 0x0c, 0x3df0,	0x0200 },
-		{ 0x19, 0xffff,	0xfc00 },
-		{ 0x1e, 0xffff,	0x20eb }
-	};
-
-	rtl_hw_start_8168g(tp);
-
-	/* disable aspm and clock request before access ephy */
-	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
-	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
-	rtl_ephy_init(tp, e_info_8168g_2, ARRAY_SIZE(e_info_8168g_2));
-}
-
-static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
-{
-	static const struct ephy_info e_info_8411_2[] = {
-		{ 0x00, 0x0000,	0x0008 },
-		{ 0x0c, 0x3df0,	0x0200 },
-		{ 0x0f, 0xffff,	0x5200 },
-		{ 0x19, 0x0020,	0x0000 },
-		{ 0x1e, 0x0000,	0x2000 }
-	};
-
-	rtl_hw_start_8168g(tp);
-
-	/* disable aspm and clock request before access ephy */
-	rtl_hw_aspm_clkreq_enable(tp, false);
-	rtl_ephy_init(tp, e_info_8411_2, ARRAY_SIZE(e_info_8411_2));
-
-	/* The following Realtek-provided magic fixes an issue with the RX unit
-	 * getting confused after the PHY having been powered-down.
-	 */
-	r8168_mac_ocp_write(tp, 0xFC28, 0x0000);
-	r8168_mac_ocp_write(tp, 0xFC2A, 0x0000);
-	r8168_mac_ocp_write(tp, 0xFC2C, 0x0000);
-	r8168_mac_ocp_write(tp, 0xFC2E, 0x0000);
-	r8168_mac_ocp_write(tp, 0xFC30, 0x0000);
-	r8168_mac_ocp_write(tp, 0xFC32, 0x0000);
-	r8168_mac_ocp_write(tp, 0xFC34, 0x0000);
-	r8168_mac_ocp_write(tp, 0xFC36, 0x0000);
-	mdelay(3);
-	r8168_mac_ocp_write(tp, 0xFC26, 0x0000);
-
-	r8168_mac_ocp_write(tp, 0xF800, 0xE008);
-	r8168_mac_ocp_write(tp, 0xF802, 0xE00A);
-	r8168_mac_ocp_write(tp, 0xF804, 0xE00C);
-	r8168_mac_ocp_write(tp, 0xF806, 0xE00E);
-	r8168_mac_ocp_write(tp, 0xF808, 0xE027);
-	r8168_mac_ocp_write(tp, 0xF80A, 0xE04F);
-	r8168_mac_ocp_write(tp, 0xF80C, 0xE05E);
-	r8168_mac_ocp_write(tp, 0xF80E, 0xE065);
-	r8168_mac_ocp_write(tp, 0xF810, 0xC602);
-	r8168_mac_ocp_write(tp, 0xF812, 0xBE00);
-	r8168_mac_ocp_write(tp, 0xF814, 0x0000);
-	r8168_mac_ocp_write(tp, 0xF816, 0xC502);
-	r8168_mac_ocp_write(tp, 0xF818, 0xBD00);
-	r8168_mac_ocp_write(tp, 0xF81A, 0x074C);
-	r8168_mac_ocp_write(tp, 0xF81C, 0xC302);
-	r8168_mac_ocp_write(tp, 0xF81E, 0xBB00);
-	r8168_mac_ocp_write(tp, 0xF820, 0x080A);
-	r8168_mac_ocp_write(tp, 0xF822, 0x6420);
-	r8168_mac_ocp_write(tp, 0xF824, 0x48C2);
-	r8168_mac_ocp_write(tp, 0xF826, 0x8C20);
-	r8168_mac_ocp_write(tp, 0xF828, 0xC516);
-	r8168_mac_ocp_write(tp, 0xF82A, 0x64A4);
-	r8168_mac_ocp_write(tp, 0xF82C, 0x49C0);
-	r8168_mac_ocp_write(tp, 0xF82E, 0xF009);
-	r8168_mac_ocp_write(tp, 0xF830, 0x74A2);
-	r8168_mac_ocp_write(tp, 0xF832, 0x8CA5);
-	r8168_mac_ocp_write(tp, 0xF834, 0x74A0);
-	r8168_mac_ocp_write(tp, 0xF836, 0xC50E);
-	r8168_mac_ocp_write(tp, 0xF838, 0x9CA2);
-	r8168_mac_ocp_write(tp, 0xF83A, 0x1C11);
-	r8168_mac_ocp_write(tp, 0xF83C, 0x9CA0);
-	r8168_mac_ocp_write(tp, 0xF83E, 0xE006);
-	r8168_mac_ocp_write(tp, 0xF840, 0x74F8);
-	r8168_mac_ocp_write(tp, 0xF842, 0x48C4);
-	r8168_mac_ocp_write(tp, 0xF844, 0x8CF8);
-	r8168_mac_ocp_write(tp, 0xF846, 0xC404);
-	r8168_mac_ocp_write(tp, 0xF848, 0xBC00);
-	r8168_mac_ocp_write(tp, 0xF84A, 0xC403);
-	r8168_mac_ocp_write(tp, 0xF84C, 0xBC00);
-	r8168_mac_ocp_write(tp, 0xF84E, 0x0BF2);
-	r8168_mac_ocp_write(tp, 0xF850, 0x0C0A);
-	r8168_mac_ocp_write(tp, 0xF852, 0xE434);
-	r8168_mac_ocp_write(tp, 0xF854, 0xD3C0);
-	r8168_mac_ocp_write(tp, 0xF856, 0x49D9);
-	r8168_mac_ocp_write(tp, 0xF858, 0xF01F);
-	r8168_mac_ocp_write(tp, 0xF85A, 0xC526);
-	r8168_mac_ocp_write(tp, 0xF85C, 0x64A5);
-	r8168_mac_ocp_write(tp, 0xF85E, 0x1400);
-	r8168_mac_ocp_write(tp, 0xF860, 0xF007);
-	r8168_mac_ocp_write(tp, 0xF862, 0x0C01);
-	r8168_mac_ocp_write(tp, 0xF864, 0x8CA5);
-	r8168_mac_ocp_write(tp, 0xF866, 0x1C15);
-	r8168_mac_ocp_write(tp, 0xF868, 0xC51B);
-	r8168_mac_ocp_write(tp, 0xF86A, 0x9CA0);
-	r8168_mac_ocp_write(tp, 0xF86C, 0xE013);
-	r8168_mac_ocp_write(tp, 0xF86E, 0xC519);
-	r8168_mac_ocp_write(tp, 0xF870, 0x74A0);
-	r8168_mac_ocp_write(tp, 0xF872, 0x48C4);
-	r8168_mac_ocp_write(tp, 0xF874, 0x8CA0);
-	r8168_mac_ocp_write(tp, 0xF876, 0xC516);
-	r8168_mac_ocp_write(tp, 0xF878, 0x74A4);
-	r8168_mac_ocp_write(tp, 0xF87A, 0x48C8);
-	r8168_mac_ocp_write(tp, 0xF87C, 0x48CA);
-	r8168_mac_ocp_write(tp, 0xF87E, 0x9CA4);
-	r8168_mac_ocp_write(tp, 0xF880, 0xC512);
-	r8168_mac_ocp_write(tp, 0xF882, 0x1B00);
-	r8168_mac_ocp_write(tp, 0xF884, 0x9BA0);
-	r8168_mac_ocp_write(tp, 0xF886, 0x1B1C);
-	r8168_mac_ocp_write(tp, 0xF888, 0x483F);
-	r8168_mac_ocp_write(tp, 0xF88A, 0x9BA2);
-	r8168_mac_ocp_write(tp, 0xF88C, 0x1B04);
-	r8168_mac_ocp_write(tp, 0xF88E, 0xC508);
-	r8168_mac_ocp_write(tp, 0xF890, 0x9BA0);
-	r8168_mac_ocp_write(tp, 0xF892, 0xC505);
-	r8168_mac_ocp_write(tp, 0xF894, 0xBD00);
-	r8168_mac_ocp_write(tp, 0xF896, 0xC502);
-	r8168_mac_ocp_write(tp, 0xF898, 0xBD00);
-	r8168_mac_ocp_write(tp, 0xF89A, 0x0300);
-	r8168_mac_ocp_write(tp, 0xF89C, 0x051E);
-	r8168_mac_ocp_write(tp, 0xF89E, 0xE434);
-	r8168_mac_ocp_write(tp, 0xF8A0, 0xE018);
-	r8168_mac_ocp_write(tp, 0xF8A2, 0xE092);
-	r8168_mac_ocp_write(tp, 0xF8A4, 0xDE20);
-	r8168_mac_ocp_write(tp, 0xF8A6, 0xD3C0);
-	r8168_mac_ocp_write(tp, 0xF8A8, 0xC50F);
-	r8168_mac_ocp_write(tp, 0xF8AA, 0x76A4);
-	r8168_mac_ocp_write(tp, 0xF8AC, 0x49E3);
-	r8168_mac_ocp_write(tp, 0xF8AE, 0xF007);
-	r8168_mac_ocp_write(tp, 0xF8B0, 0x49C0);
-	r8168_mac_ocp_write(tp, 0xF8B2, 0xF103);
-	r8168_mac_ocp_write(tp, 0xF8B4, 0xC607);
-	r8168_mac_ocp_write(tp, 0xF8B6, 0xBE00);
-	r8168_mac_ocp_write(tp, 0xF8B8, 0xC606);
-	r8168_mac_ocp_write(tp, 0xF8BA, 0xBE00);
-	r8168_mac_ocp_write(tp, 0xF8BC, 0xC602);
-	r8168_mac_ocp_write(tp, 0xF8BE, 0xBE00);
-	r8168_mac_ocp_write(tp, 0xF8C0, 0x0C4C);
-	r8168_mac_ocp_write(tp, 0xF8C2, 0x0C28);
-	r8168_mac_ocp_write(tp, 0xF8C4, 0x0C2C);
-	r8168_mac_ocp_write(tp, 0xF8C6, 0xDC00);
-	r8168_mac_ocp_write(tp, 0xF8C8, 0xC707);
-	r8168_mac_ocp_write(tp, 0xF8CA, 0x1D00);
-	r8168_mac_ocp_write(tp, 0xF8CC, 0x8DE2);
-	r8168_mac_ocp_write(tp, 0xF8CE, 0x48C1);
-	r8168_mac_ocp_write(tp, 0xF8D0, 0xC502);
-	r8168_mac_ocp_write(tp, 0xF8D2, 0xBD00);
-	r8168_mac_ocp_write(tp, 0xF8D4, 0x00AA);
-	r8168_mac_ocp_write(tp, 0xF8D6, 0xE0C0);
-	r8168_mac_ocp_write(tp, 0xF8D8, 0xC502);
-	r8168_mac_ocp_write(tp, 0xF8DA, 0xBD00);
-	r8168_mac_ocp_write(tp, 0xF8DC, 0x0132);
-
-	r8168_mac_ocp_write(tp, 0xFC26, 0x8000);
-
-	r8168_mac_ocp_write(tp, 0xFC2A, 0x0743);
-	r8168_mac_ocp_write(tp, 0xFC2C, 0x0801);
-	r8168_mac_ocp_write(tp, 0xFC2E, 0x0BE9);
-	r8168_mac_ocp_write(tp, 0xFC30, 0x02FD);
-	r8168_mac_ocp_write(tp, 0xFC32, 0x0C25);
-	r8168_mac_ocp_write(tp, 0xFC34, 0x00A9);
-	r8168_mac_ocp_write(tp, 0xFC36, 0x012D);
-
-	rtl_hw_aspm_clkreq_enable(tp, true);
-}
-
-static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
-{
-	int rg_saw_cnt;
-	u32 data;
-	static const struct ephy_info e_info_8168h_1[] = {
-		{ 0x1e, 0x0800,	0x0001 },
-		{ 0x1d, 0x0000,	0x0800 },
-		{ 0x05, 0xffff,	0x2089 },
-		{ 0x06, 0xffff,	0x5881 },
-		{ 0x04, 0xffff,	0x154a },
-		{ 0x01, 0xffff,	0x068b }
-	};
-
-	/* disable aspm and clock request before access ephy */
-	rtl_hw_aspm_clkreq_enable(tp, false);
-	rtl_ephy_init(tp, e_info_8168h_1, ARRAY_SIZE(e_info_8168h_1));
-
-	rtl_eri_write(tp, 0xc8, ERIAR_MASK_0101, 0x00080002, ERIAR_EXGMAC);
-	rtl_eri_write(tp, 0xcc, ERIAR_MASK_0001, 0x38, ERIAR_EXGMAC);
-	rtl_eri_write(tp, 0xd0, ERIAR_MASK_0001, 0x48, ERIAR_EXGMAC);
-	rtl_eri_write(tp, 0xe8, ERIAR_MASK_1111, 0x00100006, ERIAR_EXGMAC);
-
-	rtl_set_def_aspm_entry_latency(tp);
-
-	rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
-
-	rtl_w0w1_eri(tp, 0xdc, ERIAR_MASK_0001, 0x00, 0x01, ERIAR_EXGMAC);
-	rtl_w0w1_eri(tp, 0xdc, ERIAR_MASK_0001, 0x01, 0x00, ERIAR_EXGMAC);
-
-	rtl_w0w1_eri(tp, 0xdc, ERIAR_MASK_1111, 0x0010, 0x00, ERIAR_EXGMAC);
-
-	rtl_w0w1_eri(tp, 0xd4, ERIAR_MASK_1111, 0x1f00, 0x00, ERIAR_EXGMAC);
-
-	rtl_eri_write(tp, 0x5f0, ERIAR_MASK_0011, 0x4f87, ERIAR_EXGMAC);
-
-	RTL_W32(tp, MISC, RTL_R32(tp, MISC) & ~RXDV_GATED_EN);
-	RTL_W8(tp, MaxTxPacketSize, EarlySize);
-
-	rtl_eri_write(tp, 0xc0, ERIAR_MASK_0011, 0x0000, ERIAR_EXGMAC);
-	rtl_eri_write(tp, 0xb8, ERIAR_MASK_0011, 0x0000, ERIAR_EXGMAC);
-
-	/* Adjust EEE LED frequency */
-	RTL_W8(tp, EEE_LED, RTL_R8(tp, EEE_LED) & ~0x07);
-
-	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) & ~PFM_EN);
-	RTL_W8(tp, MISC_1, RTL_R8(tp, MISC_1) & ~PFM_D3COLD_EN);
-
-	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) & ~TX_10M_PS_EN);
-
-	rtl_w0w1_eri(tp, 0x1b0, ERIAR_MASK_0011, 0x0000, 0x1000, ERIAR_EXGMAC);
-
-	rtl_pcie_state_l2l3_enable(tp, false);
-
-	rtl_writephy(tp, 0x1f, 0x0c42);
-	rg_saw_cnt = (rtl_readphy(tp, 0x13) & 0x3fff);
-	rtl_writephy(tp, 0x1f, 0x0000);
-	if (rg_saw_cnt > 0) {
-		u16 sw_cnt_1ms_ini;
-
-		sw_cnt_1ms_ini = 16000000/rg_saw_cnt;
-		sw_cnt_1ms_ini &= 0x0fff;
-		data = r8168_mac_ocp_read(tp, 0xd412);
-		data &= ~0x0fff;
-		data |= sw_cnt_1ms_ini;
-		r8168_mac_ocp_write(tp, 0xd412, data);
-	}
-
-	data = r8168_mac_ocp_read(tp, 0xe056);
-	data &= ~0xf0;
-	data |= 0x70;
-	r8168_mac_ocp_write(tp, 0xe056, data);
-
-	data = r8168_mac_ocp_read(tp, 0xe052);
-	data &= ~0x6000;
-	data |= 0x8008;
-	r8168_mac_ocp_write(tp, 0xe052, data);
-
-	data = r8168_mac_ocp_read(tp, 0xe0d6);
-	data &= ~0x01ff;
-	data |= 0x017f;
-	r8168_mac_ocp_write(tp, 0xe0d6, data);
-
-	data = r8168_mac_ocp_read(tp, 0xd420);
-	data &= ~0x0fff;
-	data |= 0x047f;
-	r8168_mac_ocp_write(tp, 0xd420, data);
-
-	r8168_mac_ocp_write(tp, 0xe63e, 0x0001);
-	r8168_mac_ocp_write(tp, 0xe63e, 0x0000);
-	r8168_mac_ocp_write(tp, 0xc094, 0x0000);
-	r8168_mac_ocp_write(tp, 0xc09e, 0x0000);
-
-	rtl_hw_aspm_clkreq_enable(tp, true);
-}
-
-static void rtl_hw_start_8168ep(struct rtl8169_private *tp)
-{
-	rtl8168ep_stop_cmac(tp);
-
-	rtl_eri_write(tp, 0xc8, ERIAR_MASK_0101, 0x00080002, ERIAR_EXGMAC);
-	rtl_eri_write(tp, 0xcc, ERIAR_MASK_0001, 0x2f, ERIAR_EXGMAC);
-	rtl_eri_write(tp, 0xd0, ERIAR_MASK_0001, 0x5f, ERIAR_EXGMAC);
-	rtl_eri_write(tp, 0xe8, ERIAR_MASK_1111, 0x00100006, ERIAR_EXGMAC);
-
-	rtl_set_def_aspm_entry_latency(tp);
-
-	rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
-
-	rtl_w0w1_eri(tp, 0xdc, ERIAR_MASK_0001, 0x00, 0x01, ERIAR_EXGMAC);
-	rtl_w0w1_eri(tp, 0xdc, ERIAR_MASK_0001, 0x01, 0x00, ERIAR_EXGMAC);
-
-	rtl_w0w1_eri(tp, 0xd4, ERIAR_MASK_1111, 0x1f80, 0x00, ERIAR_EXGMAC);
-
-	rtl_eri_write(tp, 0x5f0, ERIAR_MASK_0011, 0x4f87, ERIAR_EXGMAC);
-
-	RTL_W32(tp, MISC, RTL_R32(tp, MISC) & ~RXDV_GATED_EN);
-	RTL_W8(tp, MaxTxPacketSize, EarlySize);
-
-	rtl_eri_write(tp, 0xc0, ERIAR_MASK_0011, 0x0000, ERIAR_EXGMAC);
-	rtl_eri_write(tp, 0xb8, ERIAR_MASK_0011, 0x0000, ERIAR_EXGMAC);
-
-	/* Adjust EEE LED frequency */
-	RTL_W8(tp, EEE_LED, RTL_R8(tp, EEE_LED) & ~0x07);
-
-	rtl_w0w1_eri(tp, 0x2fc, ERIAR_MASK_0001, 0x01, 0x06, ERIAR_EXGMAC);
-
-	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) & ~TX_10M_PS_EN);
-
-	rtl_pcie_state_l2l3_enable(tp, false);
-}
-
-static void rtl_hw_start_8168ep_1(struct rtl8169_private *tp)
-{
-	static const struct ephy_info e_info_8168ep_1[] = {
-		{ 0x00, 0xffff,	0x10ab },
-		{ 0x06, 0xffff,	0xf030 },
-		{ 0x08, 0xffff,	0x2006 },
-		{ 0x0d, 0xffff,	0x1666 },
-		{ 0x0c, 0x3ff0,	0x0000 }
-	};
-
-	/* disable aspm and clock request before access ephy */
-	rtl_hw_aspm_clkreq_enable(tp, false);
-	rtl_ephy_init(tp, e_info_8168ep_1, ARRAY_SIZE(e_info_8168ep_1));
-
-	rtl_hw_start_8168ep(tp);
-
-	rtl_hw_aspm_clkreq_enable(tp, true);
-}
-
-static void rtl_hw_start_8168ep_2(struct rtl8169_private *tp)
-{
-	static const struct ephy_info e_info_8168ep_2[] = {
-		{ 0x00, 0xffff,	0x10a3 },
-		{ 0x19, 0xffff,	0xfc00 },
-		{ 0x1e, 0xffff,	0x20ea }
-	};
-
-	/* disable aspm and clock request before access ephy */
-	rtl_hw_aspm_clkreq_enable(tp, false);
-	rtl_ephy_init(tp, e_info_8168ep_2, ARRAY_SIZE(e_info_8168ep_2));
-
-	rtl_hw_start_8168ep(tp);
-
-	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) & ~PFM_EN);
-	RTL_W8(tp, MISC_1, RTL_R8(tp, MISC_1) & ~PFM_D3COLD_EN);
-
-	rtl_hw_aspm_clkreq_enable(tp, true);
-}
-
-static void rtl_hw_start_8168ep_3(struct rtl8169_private *tp)
-{
-	u32 data;
-	static const struct ephy_info e_info_8168ep_3[] = {
-		{ 0x00, 0xffff,	0x10a3 },
-		{ 0x19, 0xffff,	0x7c00 },
-		{ 0x1e, 0xffff,	0x20eb },
-		{ 0x0d, 0xffff,	0x1666 }
-	};
-
-	/* disable aspm and clock request before access ephy */
-	rtl_hw_aspm_clkreq_enable(tp, false);
-	rtl_ephy_init(tp, e_info_8168ep_3, ARRAY_SIZE(e_info_8168ep_3));
-
-	rtl_hw_start_8168ep(tp);
-
-	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) & ~PFM_EN);
-	RTL_W8(tp, MISC_1, RTL_R8(tp, MISC_1) & ~PFM_D3COLD_EN);
-
-	data = r8168_mac_ocp_read(tp, 0xd3e2);
-	data &= 0xf000;
-	data |= 0x0271;
-	r8168_mac_ocp_write(tp, 0xd3e2, data);
-
-	data = r8168_mac_ocp_read(tp, 0xd3e4);
-	data &= 0xff00;
-	r8168_mac_ocp_write(tp, 0xd3e4, data);
-
-	data = r8168_mac_ocp_read(tp, 0xe860);
-	data |= 0x0080;
-	r8168_mac_ocp_write(tp, 0xe860, data);
-
-	rtl_hw_aspm_clkreq_enable(tp, true);
-}
-
-static void rtl_hw_start_8168(struct rtl8169_private *tp)
-{
-	RTL_W8(tp, MaxTxPacketSize, TxPacketMax);
-
-	tp->cp_cmd &= ~INTT_MASK;
-	tp->cp_cmd |= PktCntrDisable | INTT_1;
-	RTL_W16(tp, CPlusCmd, tp->cp_cmd);
-
-	RTL_W16(tp, IntrMitigate, 0x5100);
-
-	/* Work around for RxFIFO overflow. */
-	if (tp->mac_version == RTL_GIGA_MAC_VER_11) {
-		tp->event_slow |= RxFIFOOver | PCSTimeout;
-		tp->event_slow &= ~RxOverflow;
-	}
-
-	switch (tp->mac_version) {
-	case RTL_GIGA_MAC_VER_11:
-		rtl_hw_start_8168bb(tp);
-		break;
-
-	case RTL_GIGA_MAC_VER_12:
-	case RTL_GIGA_MAC_VER_17:
-		rtl_hw_start_8168bef(tp);
-		break;
-
-	case RTL_GIGA_MAC_VER_18:
-		rtl_hw_start_8168cp_1(tp);
-		break;
-
-	case RTL_GIGA_MAC_VER_19:
-		rtl_hw_start_8168c_1(tp);
-		break;
-
-	case RTL_GIGA_MAC_VER_20:
-		rtl_hw_start_8168c_2(tp);
-		break;
-
-	case RTL_GIGA_MAC_VER_21:
-		rtl_hw_start_8168c_3(tp);
-		break;
-
-	case RTL_GIGA_MAC_VER_22:
-		rtl_hw_start_8168c_4(tp);
-		break;
-
-	case RTL_GIGA_MAC_VER_23:
-		rtl_hw_start_8168cp_2(tp);
-		break;
-
-	case RTL_GIGA_MAC_VER_24:
-		rtl_hw_start_8168cp_3(tp);
-		break;
-
-	case RTL_GIGA_MAC_VER_25:
-	case RTL_GIGA_MAC_VER_26:
-	case RTL_GIGA_MAC_VER_27:
-		rtl_hw_start_8168d(tp);
-		break;
-
-	case RTL_GIGA_MAC_VER_28:
-		rtl_hw_start_8168d_4(tp);
-		break;
-
-	case RTL_GIGA_MAC_VER_31:
-		rtl_hw_start_8168dp(tp);
-		break;
-
-	case RTL_GIGA_MAC_VER_32:
-	case RTL_GIGA_MAC_VER_33:
-		rtl_hw_start_8168e_1(tp);
-		break;
-	case RTL_GIGA_MAC_VER_34:
-		rtl_hw_start_8168e_2(tp);
-		break;
-
-	case RTL_GIGA_MAC_VER_35:
-	case RTL_GIGA_MAC_VER_36:
-		rtl_hw_start_8168f_1(tp);
-		break;
-
-	case RTL_GIGA_MAC_VER_38:
-		rtl_hw_start_8411(tp);
-		break;
-
-	case RTL_GIGA_MAC_VER_40:
-	case RTL_GIGA_MAC_VER_41:
-		rtl_hw_start_8168g_1(tp);
-		break;
-	case RTL_GIGA_MAC_VER_42:
-		rtl_hw_start_8168g_2(tp);
-		break;
-
-	case RTL_GIGA_MAC_VER_44:
-		rtl_hw_start_8411_2(tp);
-		break;
-
-	case RTL_GIGA_MAC_VER_45:
-	case RTL_GIGA_MAC_VER_46:
-		rtl_hw_start_8168h_1(tp);
-		break;
-
-	case RTL_GIGA_MAC_VER_49:
-		rtl_hw_start_8168ep_1(tp);
-		break;
-
-	case RTL_GIGA_MAC_VER_50:
-		rtl_hw_start_8168ep_2(tp);
-		break;
-
-	case RTL_GIGA_MAC_VER_51:
-		rtl_hw_start_8168ep_3(tp);
-		break;
-
-	default:
-		netif_err(tp, drv, tp->dev,
-			  "unknown chipset (mac_version = %d)\n",
-			  tp->mac_version);
-		break;
-	}
-}
-
-static void rtl_hw_start_8102e_1(struct rtl8169_private *tp)
-{
-	static const struct ephy_info e_info_8102e_1[] = {
-		{ 0x01,	0, 0x6e65 },
-		{ 0x02,	0, 0x091f },
-		{ 0x03,	0, 0xc2f9 },
-		{ 0x06,	0, 0xafb5 },
-		{ 0x07,	0, 0x0e00 },
-		{ 0x19,	0, 0xec80 },
-		{ 0x01,	0, 0x2e65 },
-		{ 0x01,	0, 0x6e65 }
-	};
-	u8 cfg1;
-
-	rtl_set_def_aspm_entry_latency(tp);
-
-	RTL_W8(tp, DBG_REG, FIX_NAK_1);
-
-	rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
-
-	RTL_W8(tp, Config1,
-	       LEDS1 | LEDS0 | Speed_down | MEMMAP | IOMAP | VPD | PMEnable);
-	RTL_W8(tp, Config3, RTL_R8(tp, Config3) & ~Beacon_en);
-
-	cfg1 = RTL_R8(tp, Config1);
-	if ((cfg1 & LEDS0) && (cfg1 & LEDS1))
-		RTL_W8(tp, Config1, cfg1 & ~LEDS0);
-
-	rtl_ephy_init(tp, e_info_8102e_1, ARRAY_SIZE(e_info_8102e_1));
-}
-
-static void rtl_hw_start_8102e_2(struct rtl8169_private *tp)
-{
-	rtl_set_def_aspm_entry_latency(tp);
-
-	rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
-
-	RTL_W8(tp, Config1, MEMMAP | IOMAP | VPD | PMEnable);
-	RTL_W8(tp, Config3, RTL_R8(tp, Config3) & ~Beacon_en);
-}
-
-static void rtl_hw_start_8102e_3(struct rtl8169_private *tp)
-{
-	rtl_hw_start_8102e_2(tp);
-
-	rtl_ephy_write(tp, 0x03, 0xc2f9);
-}
-
-static void rtl_hw_start_8105e_1(struct rtl8169_private *tp)
-{
-	static const struct ephy_info e_info_8105e_1[] = {
-		{ 0x07,	0, 0x4000 },
-		{ 0x19,	0, 0x0200 },
-		{ 0x19,	0, 0x0020 },
-		{ 0x1e,	0, 0x2000 },
-		{ 0x03,	0, 0x0001 },
-		{ 0x19,	0, 0x0100 },
-		{ 0x19,	0, 0x0004 },
-		{ 0x0a,	0, 0x0020 }
-	};
-
-	/* Force LAN exit from ASPM if Rx/Tx are not idle */
-	RTL_W32(tp, FuncEvent, RTL_R32(tp, FuncEvent) | 0x002800);
-
-	/* Disable Early Tally Counter */
-	RTL_W32(tp, FuncEvent, RTL_R32(tp, FuncEvent) & ~0x010000);
-
-	RTL_W8(tp, MCU, RTL_R8(tp, MCU) | EN_NDP | EN_OOB_RESET);
-	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) | PFM_EN);
-
-	rtl_ephy_init(tp, e_info_8105e_1, ARRAY_SIZE(e_info_8105e_1));
-
-	rtl_pcie_state_l2l3_enable(tp, false);
-}
-
-static void rtl_hw_start_8105e_2(struct rtl8169_private *tp)
-{
-	rtl_hw_start_8105e_1(tp);
-	rtl_ephy_write(tp, 0x1e, rtl_ephy_read(tp, 0x1e) | 0x8000);
-}
-
-static void rtl_hw_start_8402(struct rtl8169_private *tp)
-{
-	static const struct ephy_info e_info_8402[] = {
-		{ 0x19,	0xffff, 0xff64 },
-		{ 0x1e,	0, 0x4000 }
-	};
-
-	rtl_set_def_aspm_entry_latency(tp);
-
-	/* Force LAN exit from ASPM if Rx/Tx are not idle */
-	RTL_W32(tp, FuncEvent, RTL_R32(tp, FuncEvent) | 0x002800);
-
-	RTL_W8(tp, MCU, RTL_R8(tp, MCU) & ~NOW_IS_OOB);
-
-	rtl_ephy_init(tp, e_info_8402, ARRAY_SIZE(e_info_8402));
-
-	rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
-
-	rtl_eri_write(tp, 0xc8, ERIAR_MASK_1111, 0x00000002, ERIAR_EXGMAC);
-	rtl_eri_write(tp, 0xe8, ERIAR_MASK_1111, 0x00000006, ERIAR_EXGMAC);
-	rtl_w0w1_eri(tp, 0xdc, ERIAR_MASK_0001, 0x00, 0x01, ERIAR_EXGMAC);
-	rtl_w0w1_eri(tp, 0xdc, ERIAR_MASK_0001, 0x01, 0x00, ERIAR_EXGMAC);
-	rtl_eri_write(tp, 0xc0, ERIAR_MASK_0011, 0x0000, ERIAR_EXGMAC);
-	rtl_eri_write(tp, 0xb8, ERIAR_MASK_0011, 0x0000, ERIAR_EXGMAC);
-	rtl_w0w1_eri(tp, 0x0d4, ERIAR_MASK_0011, 0x0e00, 0xff00, ERIAR_EXGMAC);
-
-	rtl_pcie_state_l2l3_enable(tp, false);
-}
-
-static void rtl_hw_start_8106(struct rtl8169_private *tp)
-{
-	rtl_hw_aspm_clkreq_enable(tp, false);
-
-	/* Force LAN exit from ASPM if Rx/Tx are not idle */
-	RTL_W32(tp, FuncEvent, RTL_R32(tp, FuncEvent) | 0x002800);
-
-	RTL_W32(tp, MISC, (RTL_R32(tp, MISC) | DISABLE_LAN_EN) & ~EARLY_TALLY_EN);
-	RTL_W8(tp, MCU, RTL_R8(tp, MCU) | EN_NDP | EN_OOB_RESET);
-	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) & ~PFM_EN);
-
-	rtl_pcie_state_l2l3_enable(tp, false);
-	rtl_hw_aspm_clkreq_enable(tp, true);
-}
-
-static void rtl_hw_start_8101(struct rtl8169_private *tp)
-{
-	if (tp->mac_version >= RTL_GIGA_MAC_VER_30)
-		tp->event_slow &= ~RxFIFOOver;
-
-	if (tp->mac_version == RTL_GIGA_MAC_VER_13 ||
-	    tp->mac_version == RTL_GIGA_MAC_VER_16)
-		pcie_capability_set_word(tp->pci_dev, PCI_EXP_DEVCTL,
-					 PCI_EXP_DEVCTL_NOSNOOP_EN);
-
-	RTL_W8(tp, MaxTxPacketSize, TxPacketMax);
-
-	tp->cp_cmd &= CPCMD_QUIRK_MASK;
-	RTL_W16(tp, CPlusCmd, tp->cp_cmd);
-
-	switch (tp->mac_version) {
-	case RTL_GIGA_MAC_VER_07:
-		rtl_hw_start_8102e_1(tp);
-		break;
-
-	case RTL_GIGA_MAC_VER_08:
-		rtl_hw_start_8102e_3(tp);
-		break;
-
-	case RTL_GIGA_MAC_VER_09:
-		rtl_hw_start_8102e_2(tp);
-		break;
-
-	case RTL_GIGA_MAC_VER_29:
-		rtl_hw_start_8105e_1(tp);
-		break;
-	case RTL_GIGA_MAC_VER_30:
-		rtl_hw_start_8105e_2(tp);
-		break;
-
-	case RTL_GIGA_MAC_VER_37:
-		rtl_hw_start_8402(tp);
-		break;
-
-	case RTL_GIGA_MAC_VER_39:
-		rtl_hw_start_8106(tp);
-		break;
-	case RTL_GIGA_MAC_VER_43:
-		rtl_hw_start_8168g_2(tp);
-		break;
-	case RTL_GIGA_MAC_VER_47:
-	case RTL_GIGA_MAC_VER_48:
-		rtl_hw_start_8168h_1(tp);
-		break;
-	}
-
-	RTL_W16(tp, IntrMitigate, 0x0000);
-}
-
-static int rtl8169_change_mtu(struct net_device *dev, int new_mtu)
-{
-	struct rtl8169_private *tp = netdev_priv(dev);
-
-	if (new_mtu > ETH_DATA_LEN)
-		rtl_hw_jumbo_enable(tp);
-	else
-		rtl_hw_jumbo_disable(tp);
-
-	dev->mtu = new_mtu;
-	netdev_update_features(dev);
-
-	return 0;
-}
-
-static inline void rtl8169_make_unusable_by_asic(struct RxDesc *desc)
-{
-	desc->addr = cpu_to_le64(0x0badbadbadbadbadull);
-	desc->opts1 &= ~cpu_to_le32(DescOwn | RsvdMask);
-}
-
-static void rtl8169_free_rx_databuff(struct rtl8169_private *tp,
-				     void **data_buff, struct RxDesc *desc)
-{
-	dma_unmap_single(tp_to_dev(tp), le64_to_cpu(desc->addr),
-			 R8169_RX_BUF_SIZE, DMA_FROM_DEVICE);
-
-	kfree(*data_buff);
-	*data_buff = NULL;
-	rtl8169_make_unusable_by_asic(desc);
-}
-
-static inline void rtl8169_mark_to_asic(struct RxDesc *desc)
-{
-	u32 eor = le32_to_cpu(desc->opts1) & RingEnd;
-
-	/* Force memory writes to complete before releasing descriptor */
-	dma_wmb();
-
-	desc->opts1 = cpu_to_le32(DescOwn | eor | R8169_RX_BUF_SIZE);
-}
-
-static inline void *rtl8169_align(void *data)
-{
-	return (void *)ALIGN((long)data, 16);
-}
-
-static struct sk_buff *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
-					     struct RxDesc *desc)
-{
-	void *data;
-	dma_addr_t mapping;
-	struct device *d = tp_to_dev(tp);
-	int node = dev_to_node(d);
-
-	data = kmalloc_node(R8169_RX_BUF_SIZE, GFP_KERNEL, node);
-	if (!data)
-		return NULL;
-
-	if (rtl8169_align(data) != data) {
-		kfree(data);
-		data = kmalloc_node(R8169_RX_BUF_SIZE + 15, GFP_KERNEL, node);
-		if (!data)
-			return NULL;
-	}
-
-	mapping = dma_map_single(d, rtl8169_align(data), R8169_RX_BUF_SIZE,
-				 DMA_FROM_DEVICE);
-	if (unlikely(dma_mapping_error(d, mapping))) {
-		if (net_ratelimit())
-			netif_err(tp, drv, tp->dev, "Failed to map RX DMA!\n");
-		goto err_out;
-	}
-
-	desc->addr = cpu_to_le64(mapping);
-	rtl8169_mark_to_asic(desc);
-	return data;
-
-err_out:
-	kfree(data);
-	return NULL;
-}
-
-static void rtl8169_rx_clear(struct rtl8169_private *tp)
-{
-	unsigned int i;
-
-	for (i = 0; i < NUM_RX_DESC; i++) {
-		if (tp->Rx_databuff[i]) {
-			rtl8169_free_rx_databuff(tp, tp->Rx_databuff + i,
-					    tp->RxDescArray + i);
-		}
-	}
-}
-
-static inline void rtl8169_mark_as_last_descriptor(struct RxDesc *desc)
-{
-	desc->opts1 |= cpu_to_le32(RingEnd);
-}
-
-static int rtl8169_rx_fill(struct rtl8169_private *tp)
-{
-	unsigned int i;
-
-	for (i = 0; i < NUM_RX_DESC; i++) {
-		void *data;
-
-		data = rtl8169_alloc_rx_data(tp, tp->RxDescArray + i);
-		if (!data) {
-			rtl8169_make_unusable_by_asic(tp->RxDescArray + i);
-			goto err_out;
-		}
-		tp->Rx_databuff[i] = data;
-	}
-
-	rtl8169_mark_as_last_descriptor(tp->RxDescArray + NUM_RX_DESC - 1);
-	return 0;
-
-err_out:
-	rtl8169_rx_clear(tp);
-	return -ENOMEM;
-}
-
-static int rtl8169_init_ring(struct rtl8169_private *tp)
-{
-	rtl8169_init_ring_indexes(tp);
-
-	memset(tp->tx_skb, 0, sizeof(tp->tx_skb));
-	memset(tp->Rx_databuff, 0, sizeof(tp->Rx_databuff));
-
-	return rtl8169_rx_fill(tp);
-}
-
-static void rtl8169_unmap_tx_skb(struct device *d, struct ring_info *tx_skb,
-				 struct TxDesc *desc)
-{
-	unsigned int len = tx_skb->len;
-
-	dma_unmap_single(d, le64_to_cpu(desc->addr), len, DMA_TO_DEVICE);
-
-	desc->opts1 = 0x00;
-	desc->opts2 = 0x00;
-	desc->addr = 0x00;
-	tx_skb->len = 0;
-}
-
-static void rtl8169_tx_clear_range(struct rtl8169_private *tp, u32 start,
-				   unsigned int n)
-{
-	unsigned int i;
-
-	for (i = 0; i < n; i++) {
-		unsigned int entry = (start + i) % NUM_TX_DESC;
-		struct ring_info *tx_skb = tp->tx_skb + entry;
-		unsigned int len = tx_skb->len;
-
-		if (len) {
-			struct sk_buff *skb = tx_skb->skb;
-
-			rtl8169_unmap_tx_skb(tp_to_dev(tp), tx_skb,
-					     tp->TxDescArray + entry);
-			if (skb) {
-				dev_consume_skb_any(skb);
-				tx_skb->skb = NULL;
-			}
-		}
-	}
-}
-
-static void rtl8169_tx_clear(struct rtl8169_private *tp)
-{
-	rtl8169_tx_clear_range(tp, tp->dirty_tx, NUM_TX_DESC);
-	tp->cur_tx = tp->dirty_tx = 0;
-}
-
-static void rtl_reset_work(struct rtl8169_private *tp)
-{
-	struct net_device *dev = tp->dev;
-	int i;
-
-	napi_disable(&tp->napi);
-	netif_stop_queue(dev);
-	synchronize_sched();
-
-	rtl8169_hw_reset(tp);
-
-	for (i = 0; i < NUM_RX_DESC; i++)
-		rtl8169_mark_to_asic(tp->RxDescArray + i);
-
-	rtl8169_tx_clear(tp);
-	rtl8169_init_ring_indexes(tp);
-
-	napi_enable(&tp->napi);
-	rtl_hw_start(tp);
-	netif_wake_queue(dev);
-}
-
-static void rtl8169_tx_timeout(struct net_device *dev)
-{
-	struct rtl8169_private *tp = netdev_priv(dev);
-
-	rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
-}
-
-static int rtl8169_xmit_frags(struct rtl8169_private *tp, struct sk_buff *skb,
-			      u32 *opts)
-{
-	struct skb_shared_info *info = skb_shinfo(skb);
-	unsigned int cur_frag, entry;
-	struct TxDesc *uninitialized_var(txd);
-	struct device *d = tp_to_dev(tp);
-
-	entry = tp->cur_tx;
-	for (cur_frag = 0; cur_frag < info->nr_frags; cur_frag++) {
-		const skb_frag_t *frag = info->frags + cur_frag;
-		dma_addr_t mapping;
-		u32 status, len;
-		void *addr;
-
-		entry = (entry + 1) % NUM_TX_DESC;
-
-		txd = tp->TxDescArray + entry;
-		len = skb_frag_size(frag);
-		addr = skb_frag_address(frag);
-		mapping = dma_map_single(d, addr, len, DMA_TO_DEVICE);
-		if (unlikely(dma_mapping_error(d, mapping))) {
-			if (net_ratelimit())
-				netif_err(tp, drv, tp->dev,
-					  "Failed to map TX fragments DMA!\n");
-			goto err_out;
-		}
-
-		/* Anti gcc 2.95.3 bugware (sic) */
-		status = opts[0] | len |
-			(RingEnd * !((entry + 1) % NUM_TX_DESC));
-
-		txd->opts1 = cpu_to_le32(status);
-		txd->opts2 = cpu_to_le32(opts[1]);
-		txd->addr = cpu_to_le64(mapping);
-
-		tp->tx_skb[entry].len = len;
-	}
-
-	if (cur_frag) {
-		tp->tx_skb[entry].skb = skb;
-		txd->opts1 |= cpu_to_le32(LastFrag);
-	}
-
-	return cur_frag;
-
-err_out:
-	rtl8169_tx_clear_range(tp, tp->cur_tx + 1, cur_frag);
-	return -EIO;
-}
-
-static bool rtl_test_hw_pad_bug(struct rtl8169_private *tp, struct sk_buff *skb)
-{
-	return skb->len < ETH_ZLEN && tp->mac_version == RTL_GIGA_MAC_VER_34;
-}
-
-static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
-				      struct net_device *dev);
-/* r8169_csum_workaround()
- * The hw limites the value the transport offset. When the offset is out of the
- * range, calculate the checksum by sw.
- */
-static void r8169_csum_workaround(struct rtl8169_private *tp,
-				  struct sk_buff *skb)
-{
-	if (skb_shinfo(skb)->gso_size) {
-		netdev_features_t features = tp->dev->features;
-		struct sk_buff *segs, *nskb;
-
-		features &= ~(NETIF_F_SG | NETIF_F_IPV6_CSUM | NETIF_F_TSO6);
-		segs = skb_gso_segment(skb, features);
-		if (IS_ERR(segs) || !segs)
-			goto drop;
-
-		do {
-			nskb = segs;
-			segs = segs->next;
-			nskb->next = NULL;
-			rtl8169_start_xmit(nskb, tp->dev);
-		} while (segs);
-
-		dev_consume_skb_any(skb);
-	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
-		if (skb_checksum_help(skb) < 0)
-			goto drop;
-
-		rtl8169_start_xmit(skb, tp->dev);
-	} else {
-		struct net_device_stats *stats;
-
-drop:
-		stats = &tp->dev->stats;
-		stats->tx_dropped++;
-		dev_kfree_skb_any(skb);
-	}
-}
-
-/* msdn_giant_send_check()
- * According to the document of microsoft, the TCP Pseudo Header excludes the
- * packet length for IPv6 TCP large packets.
- */
-static int msdn_giant_send_check(struct sk_buff *skb)
-{
-	const struct ipv6hdr *ipv6h;
-	struct tcphdr *th;
-	int ret;
-
-	ret = skb_cow_head(skb, 0);
-	if (ret)
-		return ret;
-
-	ipv6h = ipv6_hdr(skb);
-	th = tcp_hdr(skb);
-
-	th->check = 0;
-	th->check = ~tcp_v6_check(0, &ipv6h->saddr, &ipv6h->daddr, 0);
-
-	return ret;
-}
-
-static bool rtl8169_tso_csum_v1(struct rtl8169_private *tp,
-				struct sk_buff *skb, u32 *opts)
-{
-	u32 mss = skb_shinfo(skb)->gso_size;
-
-	if (mss) {
-		opts[0] |= TD_LSO;
-		opts[0] |= min(mss, TD_MSS_MAX) << TD0_MSS_SHIFT;
-	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
-		const struct iphdr *ip = ip_hdr(skb);
-
-		if (ip->protocol == IPPROTO_TCP)
-			opts[0] |= TD0_IP_CS | TD0_TCP_CS;
-		else if (ip->protocol == IPPROTO_UDP)
-			opts[0] |= TD0_IP_CS | TD0_UDP_CS;
-		else
-			WARN_ON_ONCE(1);
-	}
-
-	return true;
-}
-
-static bool rtl8169_tso_csum_v2(struct rtl8169_private *tp,
-				struct sk_buff *skb, u32 *opts)
-{
-	u32 transport_offset = (u32)skb_transport_offset(skb);
-	u32 mss = skb_shinfo(skb)->gso_size;
-
-	if (mss) {
-		if (transport_offset > GTTCPHO_MAX) {
-			netif_warn(tp, tx_err, tp->dev,
-				   "Invalid transport offset 0x%x for TSO\n",
-				   transport_offset);
-			return false;
-		}
-
-		switch (vlan_get_protocol(skb)) {
-		case htons(ETH_P_IP):
-			opts[0] |= TD1_GTSENV4;
-			break;
-
-		case htons(ETH_P_IPV6):
-			if (msdn_giant_send_check(skb))
-				return false;
-
-			opts[0] |= TD1_GTSENV6;
-			break;
-
-		default:
-			WARN_ON_ONCE(1);
-			break;
-		}
-
-		opts[0] |= transport_offset << GTTCPHO_SHIFT;
-		opts[1] |= min(mss, TD_MSS_MAX) << TD1_MSS_SHIFT;
-	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
-		u8 ip_protocol;
-
-		if (unlikely(rtl_test_hw_pad_bug(tp, skb)))
-			return !(skb_checksum_help(skb) || eth_skb_pad(skb));
-
-		if (transport_offset > TCPHO_MAX) {
-			netif_warn(tp, tx_err, tp->dev,
-				   "Invalid transport offset 0x%x\n",
-				   transport_offset);
-			return false;
-		}
-
-		switch (vlan_get_protocol(skb)) {
-		case htons(ETH_P_IP):
-			opts[1] |= TD1_IPv4_CS;
-			ip_protocol = ip_hdr(skb)->protocol;
-			break;
-
-		case htons(ETH_P_IPV6):
-			opts[1] |= TD1_IPv6_CS;
-			ip_protocol = ipv6_hdr(skb)->nexthdr;
-			break;
-
-		default:
-			ip_protocol = IPPROTO_RAW;
-			break;
-		}
-
-		if (ip_protocol == IPPROTO_TCP)
-			opts[1] |= TD1_TCP_CS;
-		else if (ip_protocol == IPPROTO_UDP)
-			opts[1] |= TD1_UDP_CS;
-		else
-			WARN_ON_ONCE(1);
-
-		opts[1] |= transport_offset << TCPHO_SHIFT;
-	} else {
-		if (unlikely(rtl_test_hw_pad_bug(tp, skb)))
-			/* eth_skb_pad would free the skb on error */
-			return !__skb_put_padto(skb, ETH_ZLEN, false);
-	}
-
-	return true;
-}
-
-static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
-				      struct net_device *dev)
-{
-	struct rtl8169_private *tp = netdev_priv(dev);
-	unsigned int entry = tp->cur_tx % NUM_TX_DESC;
-	struct TxDesc *txd = tp->TxDescArray + entry;
-	struct device *d = tp_to_dev(tp);
-	dma_addr_t mapping;
-	u32 status, len;
-	u32 opts[2];
-	int frags;
-
-	if (unlikely(!TX_FRAGS_READY_FOR(tp, skb_shinfo(skb)->nr_frags))) {
-		netif_err(tp, drv, dev, "BUG! Tx Ring full when queue awake!\n");
-		goto err_stop_0;
-	}
-
-	if (unlikely(le32_to_cpu(txd->opts1) & DescOwn))
-		goto err_stop_0;
-
-	opts[1] = cpu_to_le32(rtl8169_tx_vlan_tag(skb));
-	opts[0] = DescOwn;
-
-	if (!tp->tso_csum(tp, skb, opts)) {
-		r8169_csum_workaround(tp, skb);
-		return NETDEV_TX_OK;
-	}
-
-	len = skb_headlen(skb);
-	mapping = dma_map_single(d, skb->data, len, DMA_TO_DEVICE);
-	if (unlikely(dma_mapping_error(d, mapping))) {
-		if (net_ratelimit())
-			netif_err(tp, drv, dev, "Failed to map TX DMA!\n");
-		goto err_dma_0;
-	}
-
-	tp->tx_skb[entry].len = len;
-	txd->addr = cpu_to_le64(mapping);
-
-	frags = rtl8169_xmit_frags(tp, skb, opts);
-	if (frags < 0)
-		goto err_dma_1;
-	else if (frags)
-		opts[0] |= FirstFrag;
-	else {
-		opts[0] |= FirstFrag | LastFrag;
-		tp->tx_skb[entry].skb = skb;
-	}
-
-	txd->opts2 = cpu_to_le32(opts[1]);
-
-	skb_tx_timestamp(skb);
-
-	/* Force memory writes to complete before releasing descriptor */
-	dma_wmb();
-
-	/* Anti gcc 2.95.3 bugware (sic) */
-	status = opts[0] | len | (RingEnd * !((entry + 1) % NUM_TX_DESC));
-	txd->opts1 = cpu_to_le32(status);
-
-	/* Force all memory writes to complete before notifying device */
-	wmb();
-
-	tp->cur_tx += frags + 1;
-
-	RTL_W8(tp, TxPoll, NPQ);
-
-	mmiowb();
-
-	if (!TX_FRAGS_READY_FOR(tp, MAX_SKB_FRAGS)) {
-		/* Avoid wrongly optimistic queue wake-up: rtl_tx thread must
-		 * not miss a ring update when it notices a stopped queue.
-		 */
-		smp_wmb();
-		netif_stop_queue(dev);
-		/* Sync with rtl_tx:
-		 * - publish queue status and cur_tx ring index (write barrier)
-		 * - refresh dirty_tx ring index (read barrier).
-		 * May the current thread have a pessimistic view of the ring
-		 * status and forget to wake up queue, a racing rtl_tx thread
-		 * can't.
-		 */
-		smp_mb();
-		if (TX_FRAGS_READY_FOR(tp, MAX_SKB_FRAGS))
-			netif_wake_queue(dev);
-	}
-
-	return NETDEV_TX_OK;
-
-err_dma_1:
-	rtl8169_unmap_tx_skb(d, tp->tx_skb + entry, txd);
-err_dma_0:
-	dev_kfree_skb_any(skb);
-	dev->stats.tx_dropped++;
-	return NETDEV_TX_OK;
-
-err_stop_0:
-	netif_stop_queue(dev);
-	dev->stats.tx_dropped++;
-	return NETDEV_TX_BUSY;
-}
-
-static void rtl8169_pcierr_interrupt(struct net_device *dev)
-{
-	struct rtl8169_private *tp = netdev_priv(dev);
-	struct pci_dev *pdev = tp->pci_dev;
-	u16 pci_status, pci_cmd;
-
-	pci_read_config_word(pdev, PCI_COMMAND, &pci_cmd);
-	pci_read_config_word(pdev, PCI_STATUS, &pci_status);
-
-	netif_err(tp, intr, dev, "PCI error (cmd = 0x%04x, status = 0x%04x)\n",
-		  pci_cmd, pci_status);
-
-	/*
-	 * The recovery sequence below admits a very elaborated explanation:
-	 * - it seems to work;
-	 * - I did not see what else could be done;
-	 * - it makes iop3xx happy.
-	 *
-	 * Feel free to adjust to your needs.
-	 */
-	if (pdev->broken_parity_status)
-		pci_cmd &= ~PCI_COMMAND_PARITY;
-	else
-		pci_cmd |= PCI_COMMAND_SERR | PCI_COMMAND_PARITY;
-
-	pci_write_config_word(pdev, PCI_COMMAND, pci_cmd);
-
-	pci_write_config_word(pdev, PCI_STATUS,
-		pci_status & (PCI_STATUS_DETECTED_PARITY |
-		PCI_STATUS_SIG_SYSTEM_ERROR | PCI_STATUS_REC_MASTER_ABORT |
-		PCI_STATUS_REC_TARGET_ABORT | PCI_STATUS_SIG_TARGET_ABORT));
-
-	/* The infamous DAC f*ckup only happens at boot time */
-	if ((tp->cp_cmd & PCIDAC) && !tp->cur_rx) {
-		netif_info(tp, intr, dev, "disabling PCI DAC\n");
-		tp->cp_cmd &= ~PCIDAC;
-		RTL_W16(tp, CPlusCmd, tp->cp_cmd);
-		dev->features &= ~NETIF_F_HIGHDMA;
-	}
-
-	rtl8169_hw_reset(tp);
-
-	rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
-}
-
-static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp)
-{
-	unsigned int dirty_tx, tx_left;
-
-	dirty_tx = tp->dirty_tx;
-	smp_rmb();
-	tx_left = tp->cur_tx - dirty_tx;
-
-	while (tx_left > 0) {
-		unsigned int entry = dirty_tx % NUM_TX_DESC;
-		struct ring_info *tx_skb = tp->tx_skb + entry;
-		u32 status;
-
-		status = le32_to_cpu(tp->TxDescArray[entry].opts1);
-		if (status & DescOwn)
-			break;
-
-		/* This barrier is needed to keep us from reading
-		 * any other fields out of the Tx descriptor until
-		 * we know the status of DescOwn
-		 */
-		dma_rmb();
-
-		rtl8169_unmap_tx_skb(tp_to_dev(tp), tx_skb,
-				     tp->TxDescArray + entry);
-		if (status & LastFrag) {
-			u64_stats_update_begin(&tp->tx_stats.syncp);
-			tp->tx_stats.packets++;
-			tp->tx_stats.bytes += tx_skb->skb->len;
-			u64_stats_update_end(&tp->tx_stats.syncp);
-			dev_consume_skb_any(tx_skb->skb);
-			tx_skb->skb = NULL;
-		}
-		dirty_tx++;
-		tx_left--;
-	}
-
-	if (tp->dirty_tx != dirty_tx) {
-		tp->dirty_tx = dirty_tx;
-		/* Sync with rtl8169_start_xmit:
-		 * - publish dirty_tx ring index (write barrier)
-		 * - refresh cur_tx ring index and queue status (read barrier)
-		 * May the current thread miss the stopped queue condition,
-		 * a racing xmit thread can only have a right view of the
-		 * ring status.
-		 */
-		smp_mb();
-		if (netif_queue_stopped(dev) &&
-		    TX_FRAGS_READY_FOR(tp, MAX_SKB_FRAGS)) {
-			netif_wake_queue(dev);
-		}
-		/*
-		 * 8168 hack: TxPoll requests are lost when the Tx packets are
-		 * too close. Let's kick an extra TxPoll request when a burst
-		 * of start_xmit activity is detected (if it is not detected,
-		 * it is slow enough). -- FR
-		 */
-		if (tp->cur_tx != dirty_tx)
-			RTL_W8(tp, TxPoll, NPQ);
-	}
-}
-
-static inline int rtl8169_fragmented_frame(u32 status)
-{
-	return (status & (FirstFrag | LastFrag)) != (FirstFrag | LastFrag);
-}
-
-static inline void rtl8169_rx_csum(struct sk_buff *skb, u32 opts1)
-{
-	u32 status = opts1 & RxProtoMask;
-
-	if (((status == RxProtoTCP) && !(opts1 & TCPFail)) ||
-	    ((status == RxProtoUDP) && !(opts1 & UDPFail)))
-		skb->ip_summed = CHECKSUM_UNNECESSARY;
-	else
-		skb_checksum_none_assert(skb);
-}
-
-static struct sk_buff *rtl8169_try_rx_copy(void *data,
-					   struct rtl8169_private *tp,
-					   int pkt_size,
-					   dma_addr_t addr)
-{
-	struct sk_buff *skb;
-	struct device *d = tp_to_dev(tp);
-
-	data = rtl8169_align(data);
-	dma_sync_single_for_cpu(d, addr, pkt_size, DMA_FROM_DEVICE);
-	prefetch(data);
-	skb = napi_alloc_skb(&tp->napi, pkt_size);
-	if (skb)
-		skb_copy_to_linear_data(skb, data, pkt_size);
-	dma_sync_single_for_device(d, addr, pkt_size, DMA_FROM_DEVICE);
-
-	return skb;
-}
-
-static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, u32 budget)
-{
-	unsigned int cur_rx, rx_left;
-	unsigned int count;
-
-	cur_rx = tp->cur_rx;
-
-	for (rx_left = min(budget, NUM_RX_DESC); rx_left > 0; rx_left--, cur_rx++) {
-		unsigned int entry = cur_rx % NUM_RX_DESC;
-		struct RxDesc *desc = tp->RxDescArray + entry;
-		u32 status;
-
-		status = le32_to_cpu(desc->opts1);
-		if (status & DescOwn)
-			break;
-
-		/* This barrier is needed to keep us from reading
-		 * any other fields out of the Rx descriptor until
-		 * we know the status of DescOwn
-		 */
-		dma_rmb();
-
-		if (unlikely(status & RxRES)) {
-			netif_info(tp, rx_err, dev, "Rx ERROR. status = %08x\n",
-				   status);
-			dev->stats.rx_errors++;
-			if (status & (RxRWT | RxRUNT))
-				dev->stats.rx_length_errors++;
-			if (status & RxCRC)
-				dev->stats.rx_crc_errors++;
-			/* RxFOVF is a reserved bit on later chip versions */
-			if (tp->mac_version == RTL_GIGA_MAC_VER_01 &&
-			    status & RxFOVF) {
-				rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
-				dev->stats.rx_fifo_errors++;
-			} else if (status & (RxRUNT | RxCRC) &&
-				   !(status & RxRWT) &&
-				   dev->features & NETIF_F_RXALL) {
-				goto process_pkt;
-			}
-		} else {
-			struct sk_buff *skb;
-			dma_addr_t addr;
-			int pkt_size;
-
-process_pkt:
-			addr = le64_to_cpu(desc->addr);
-			if (likely(!(dev->features & NETIF_F_RXFCS)))
-				pkt_size = (status & 0x00003fff) - 4;
-			else
-				pkt_size = status & 0x00003fff;
-
-			/*
-			 * The driver does not support incoming fragmented
-			 * frames. They are seen as a symptom of over-mtu
-			 * sized frames.
-			 */
-			if (unlikely(rtl8169_fragmented_frame(status))) {
-				dev->stats.rx_dropped++;
-				dev->stats.rx_length_errors++;
-				goto release_descriptor;
-			}
-
-			skb = rtl8169_try_rx_copy(tp->Rx_databuff[entry],
-						  tp, pkt_size, addr);
-			if (!skb) {
-				dev->stats.rx_dropped++;
-				goto release_descriptor;
-			}
-
-			rtl8169_rx_csum(skb, status);
-			skb_put(skb, pkt_size);
-			skb->protocol = eth_type_trans(skb, dev);
-
-			rtl8169_rx_vlan_tag(desc, skb);
-
-			if (skb->pkt_type == PACKET_MULTICAST)
-				dev->stats.multicast++;
-
-			napi_gro_receive(&tp->napi, skb);
-
-			u64_stats_update_begin(&tp->rx_stats.syncp);
-			tp->rx_stats.packets++;
-			tp->rx_stats.bytes += pkt_size;
-			u64_stats_update_end(&tp->rx_stats.syncp);
-		}
-release_descriptor:
-		desc->opts2 = 0;
-		rtl8169_mark_to_asic(desc);
-	}
-
-	count = cur_rx - tp->cur_rx;
-	tp->cur_rx = cur_rx;
-
-	return count;
-}
-
-static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
-{
-	struct rtl8169_private *tp = dev_instance;
-	u16 status = rtl_get_events(tp);
-
-	if (status == 0xffff || !(status & (RTL_EVENT_NAPI | tp->event_slow)))
-		return IRQ_NONE;
-
-	rtl_irq_disable(tp);
-	napi_schedule(&tp->napi);
-
-	return IRQ_HANDLED;
-}
-
-/*
- * Workqueue context.
- */
-static void rtl_slow_event_work(struct rtl8169_private *tp)
-{
-	struct net_device *dev = tp->dev;
-	u16 status;
-
-	status = rtl_get_events(tp) & tp->event_slow;
-	rtl_ack_events(tp, status);
-
-	if (unlikely(status & RxFIFOOver)) {
-		switch (tp->mac_version) {
-		/* Work around for rx fifo overflow */
-		case RTL_GIGA_MAC_VER_11:
-			netif_stop_queue(dev);
-			/* XXX - Hack alert. See rtl_task(). */
-			set_bit(RTL_FLAG_TASK_RESET_PENDING, tp->wk.flags);
-		default:
-			break;
-		}
-	}
-
-	if (unlikely(status & SYSErr))
-		rtl8169_pcierr_interrupt(dev);
-
-	if (status & LinkChg)
-		phy_mac_interrupt(dev->phydev);
-
-	rtl_irq_enable_all(tp);
-}
-
-static void rtl_task(struct work_struct *work)
-{
-	static const struct {
-		int bitnr;
-		void (*action)(struct rtl8169_private *);
-	} rtl_work[] = {
-		/* XXX - keep rtl_slow_event_work() as first element. */
-		{ RTL_FLAG_TASK_SLOW_PENDING,	rtl_slow_event_work },
-		{ RTL_FLAG_TASK_RESET_PENDING,	rtl_reset_work },
-	};
-	struct rtl8169_private *tp =
-		container_of(work, struct rtl8169_private, wk.work);
-	struct net_device *dev = tp->dev;
-	int i;
-
-	rtl_lock_work(tp);
-
-	if (!netif_running(dev) ||
-	    !test_bit(RTL_FLAG_TASK_ENABLED, tp->wk.flags))
-		goto out_unlock;
-
-	for (i = 0; i < ARRAY_SIZE(rtl_work); i++) {
-		bool pending;
-
-		pending = test_and_clear_bit(rtl_work[i].bitnr, tp->wk.flags);
-		if (pending)
-			rtl_work[i].action(tp);
-	}
-
-out_unlock:
-	rtl_unlock_work(tp);
-}
-
-static int rtl8169_poll(struct napi_struct *napi, int budget)
-{
-	struct rtl8169_private *tp = container_of(napi, struct rtl8169_private, napi);
-	struct net_device *dev = tp->dev;
-	u16 enable_mask = RTL_EVENT_NAPI | tp->event_slow;
-	int work_done;
-	u16 status;
-
-	status = rtl_get_events(tp);
-	rtl_ack_events(tp, status & ~tp->event_slow);
-
-	work_done = rtl_rx(dev, tp, (u32) budget);
-
-	rtl_tx(dev, tp);
-
-	if (status & tp->event_slow) {
-		enable_mask &= ~tp->event_slow;
-
-		rtl_schedule_task(tp, RTL_FLAG_TASK_SLOW_PENDING);
-	}
-
-	if (work_done < budget) {
-		napi_complete_done(napi, work_done);
-
-		rtl_irq_enable(tp, enable_mask);
-		mmiowb();
-	}
-
-	return work_done;
-}
-
-static void rtl8169_rx_missed(struct net_device *dev)
-{
-	struct rtl8169_private *tp = netdev_priv(dev);
-
-	if (tp->mac_version > RTL_GIGA_MAC_VER_06)
-		return;
-
-	dev->stats.rx_missed_errors += RTL_R32(tp, RxMissed) & 0xffffff;
-	RTL_W32(tp, RxMissed, 0);
-}
-
-static void r8169_phylink_handler(struct net_device *ndev)
-{
-	struct rtl8169_private *tp = netdev_priv(ndev);
-
-	if (netif_carrier_ok(ndev)) {
-		rtl_link_chg_patch(tp);
-		pm_request_resume(&tp->pci_dev->dev);
-	} else {
-		pm_runtime_idle(&tp->pci_dev->dev);
-	}
-
-	if (net_ratelimit())
-		phy_print_status(ndev->phydev);
-}
-
-static int r8169_phy_connect(struct rtl8169_private *tp)
-{
-	struct phy_device *phydev = mdiobus_get_phy(tp->mii_bus, 0);
-	phy_interface_t phy_mode;
-	int ret;
-
-	phy_mode = tp->supports_gmii ? PHY_INTERFACE_MODE_GMII :
-		   PHY_INTERFACE_MODE_MII;
-
-	ret = phy_connect_direct(tp->dev, phydev, r8169_phylink_handler,
-				 phy_mode);
-	if (ret)
-		return ret;
-
-	if (!tp->supports_gmii)
-		phy_set_max_speed(phydev, SPEED_100);
-
-	/* Ensure to advertise everything, incl. pause */
-	phydev->advertising = phydev->supported;
-
-	phy_attached_info(phydev);
-
-	return 0;
-}
-
-static void rtl8169_down(struct net_device *dev)
-{
-	struct rtl8169_private *tp = netdev_priv(dev);
-
-	phy_stop(dev->phydev);
-
-	napi_disable(&tp->napi);
-	netif_stop_queue(dev);
-
-	rtl8169_hw_reset(tp);
-	/*
-	 * At this point device interrupts can not be enabled in any function,
-	 * as netif_running is not true (rtl8169_interrupt, rtl8169_reset_task)
-	 * and napi is disabled (rtl8169_poll).
-	 */
-	rtl8169_rx_missed(dev);
-
-	/* Give a racing hard_start_xmit a few cycles to complete. */
-	synchronize_sched();
-
-	rtl8169_tx_clear(tp);
-
-	rtl8169_rx_clear(tp);
-
-	rtl_pll_power_down(tp);
-}
-
-static int rtl8169_close(struct net_device *dev)
-{
-	struct rtl8169_private *tp = netdev_priv(dev);
-	struct pci_dev *pdev = tp->pci_dev;
-
-	pm_runtime_get_sync(&pdev->dev);
-
-	/* Update counters before going down */
-	rtl8169_update_counters(tp);
-
-	rtl_lock_work(tp);
-	/* Clear all task flags */
-	bitmap_zero(tp->wk.flags, RTL_FLAG_MAX);
-
-	rtl8169_down(dev);
-	rtl_unlock_work(tp);
-
-	cancel_work_sync(&tp->wk.work);
-
-	phy_disconnect(dev->phydev);
-
-	free_irq(pci_irq_vector(pdev, 0), tp);
-
-	dma_free_coherent(&pdev->dev, R8169_RX_RING_BYTES, tp->RxDescArray,
-			  tp->RxPhyAddr);
-	dma_free_coherent(&pdev->dev, R8169_TX_RING_BYTES, tp->TxDescArray,
-			  tp->TxPhyAddr);
-	tp->TxDescArray = NULL;
-	tp->RxDescArray = NULL;
-
-	pm_runtime_put_sync(&pdev->dev);
-
-	return 0;
-}
-
-#ifdef CONFIG_NET_POLL_CONTROLLER
-static void rtl8169_netpoll(struct net_device *dev)
-{
-	struct rtl8169_private *tp = netdev_priv(dev);
-
-	rtl8169_interrupt(pci_irq_vector(tp->pci_dev, 0), tp);
-}
-#endif
-
-static int rtl_open(struct net_device *dev)
-{
-	struct rtl8169_private *tp = netdev_priv(dev);
-	struct pci_dev *pdev = tp->pci_dev;
-	int retval = -ENOMEM;
-
-	pm_runtime_get_sync(&pdev->dev);
-
-	/*
-	 * Rx and Tx descriptors needs 256 bytes alignment.
-	 * dma_alloc_coherent provides more.
-	 */
-	tp->TxDescArray = dma_alloc_coherent(&pdev->dev, R8169_TX_RING_BYTES,
-					     &tp->TxPhyAddr, GFP_KERNEL);
-	if (!tp->TxDescArray)
-		goto err_pm_runtime_put;
-
-	tp->RxDescArray = dma_alloc_coherent(&pdev->dev, R8169_RX_RING_BYTES,
-					     &tp->RxPhyAddr, GFP_KERNEL);
-	if (!tp->RxDescArray)
-		goto err_free_tx_0;
-
-	retval = rtl8169_init_ring(tp);
-	if (retval < 0)
-		goto err_free_rx_1;
-
-	INIT_WORK(&tp->wk.work, rtl_task);
-
-	smp_mb();
-
-	rtl_request_firmware(tp);
-
-	retval = request_irq(pci_irq_vector(pdev, 0), rtl8169_interrupt,
-			     IRQF_SHARED, dev->name, tp);
-	if (retval < 0)
-		goto err_release_fw_2;
-
-	retval = r8169_phy_connect(tp);
-	if (retval)
-		goto err_free_irq;
-
-	rtl_lock_work(tp);
-
-	set_bit(RTL_FLAG_TASK_ENABLED, tp->wk.flags);
-
-	napi_enable(&tp->napi);
-
-	rtl8169_init_phy(dev, tp);
-
-	rtl_pll_power_up(tp);
-
-	rtl_hw_start(tp);
-
-	if (!rtl8169_init_counter_offsets(tp))
-		netif_warn(tp, hw, dev, "counter reset/update failed\n");
-
-	phy_start(dev->phydev);
-	netif_start_queue(dev);
-
-	rtl_unlock_work(tp);
-
-	pm_runtime_put_sync(&pdev->dev);
-out:
-	return retval;
-
-err_free_irq:
-	free_irq(pci_irq_vector(pdev, 0), tp);
-err_release_fw_2:
-	rtl_release_firmware(tp);
-	rtl8169_rx_clear(tp);
-err_free_rx_1:
-	dma_free_coherent(&pdev->dev, R8169_RX_RING_BYTES, tp->RxDescArray,
-			  tp->RxPhyAddr);
-	tp->RxDescArray = NULL;
-err_free_tx_0:
-	dma_free_coherent(&pdev->dev, R8169_TX_RING_BYTES, tp->TxDescArray,
-			  tp->TxPhyAddr);
-	tp->TxDescArray = NULL;
-err_pm_runtime_put:
-	pm_runtime_put_noidle(&pdev->dev);
-	goto out;
-}
-
-static void
-rtl8169_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
-{
-	struct rtl8169_private *tp = netdev_priv(dev);
-	struct pci_dev *pdev = tp->pci_dev;
-	struct rtl8169_counters *counters = tp->counters;
-	unsigned int start;
-
-	pm_runtime_get_noresume(&pdev->dev);
-
-	if (netif_running(dev) && pm_runtime_active(&pdev->dev))
-		rtl8169_rx_missed(dev);
-
-	do {
-		start = u64_stats_fetch_begin_irq(&tp->rx_stats.syncp);
-		stats->rx_packets = tp->rx_stats.packets;
-		stats->rx_bytes	= tp->rx_stats.bytes;
-	} while (u64_stats_fetch_retry_irq(&tp->rx_stats.syncp, start));
-
-	do {
-		start = u64_stats_fetch_begin_irq(&tp->tx_stats.syncp);
-		stats->tx_packets = tp->tx_stats.packets;
-		stats->tx_bytes	= tp->tx_stats.bytes;
-	} while (u64_stats_fetch_retry_irq(&tp->tx_stats.syncp, start));
-
-	stats->rx_dropped	= dev->stats.rx_dropped;
-	stats->tx_dropped	= dev->stats.tx_dropped;
-	stats->rx_length_errors = dev->stats.rx_length_errors;
-	stats->rx_errors	= dev->stats.rx_errors;
-	stats->rx_crc_errors	= dev->stats.rx_crc_errors;
-	stats->rx_fifo_errors	= dev->stats.rx_fifo_errors;
-	stats->rx_missed_errors = dev->stats.rx_missed_errors;
-	stats->multicast	= dev->stats.multicast;
-
-	/*
-	 * Fetch additonal counter values missing in stats collected by driver
-	 * from tally counters.
-	 */
-	if (pm_runtime_active(&pdev->dev))
-		rtl8169_update_counters(tp);
-
-	/*
-	 * Subtract values fetched during initalization.
-	 * See rtl8169_init_counter_offsets for a description why we do that.
-	 */
-	stats->tx_errors = le64_to_cpu(counters->tx_errors) -
-		le64_to_cpu(tp->tc_offset.tx_errors);
-	stats->collisions = le32_to_cpu(counters->tx_multi_collision) -
-		le32_to_cpu(tp->tc_offset.tx_multi_collision);
-	stats->tx_aborted_errors = le16_to_cpu(counters->tx_aborted) -
-		le16_to_cpu(tp->tc_offset.tx_aborted);
-
-	pm_runtime_put_noidle(&pdev->dev);
-}
-
-static void rtl8169_net_suspend(struct net_device *dev)
-{
-	struct rtl8169_private *tp = netdev_priv(dev);
-
-	if (!netif_running(dev))
-		return;
-
-	phy_stop(dev->phydev);
-	netif_device_detach(dev);
-	netif_stop_queue(dev);
-
-	rtl_lock_work(tp);
-	napi_disable(&tp->napi);
-	/* Clear all task flags */
-	bitmap_zero(tp->wk.flags, RTL_FLAG_MAX);
-
-	rtl_unlock_work(tp);
-
-	rtl_pll_power_down(tp);
-}
-
-#ifdef CONFIG_PM
-
-static int rtl8169_suspend(struct device *device)
-{
-	struct pci_dev *pdev = to_pci_dev(device);
-	struct net_device *dev = pci_get_drvdata(pdev);
-	struct rtl8169_private *tp = netdev_priv(dev);
-
-	rtl8169_net_suspend(dev);
-	clk_disable_unprepare(tp->clk);
-
-	return 0;
-}
-
-static void __rtl8169_resume(struct net_device *dev)
-{
-	struct rtl8169_private *tp = netdev_priv(dev);
-
-	netif_device_attach(dev);
-
-	rtl_pll_power_up(tp);
-	rtl8169_init_phy(dev, tp);
-
-	phy_start(tp->dev->phydev);
-
-	rtl_lock_work(tp);
-	napi_enable(&tp->napi);
-	set_bit(RTL_FLAG_TASK_ENABLED, tp->wk.flags);
-	rtl_unlock_work(tp);
-
-	rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
-}
-
-static int rtl8169_resume(struct device *device)
-{
-	struct pci_dev *pdev = to_pci_dev(device);
-	struct net_device *dev = pci_get_drvdata(pdev);
-	struct rtl8169_private *tp = netdev_priv(dev);
-
-	clk_prepare_enable(tp->clk);
-
-	if (netif_running(dev))
-		__rtl8169_resume(dev);
-
-	return 0;
-}
-
-static int rtl8169_runtime_suspend(struct device *device)
-{
-	struct pci_dev *pdev = to_pci_dev(device);
-	struct net_device *dev = pci_get_drvdata(pdev);
-	struct rtl8169_private *tp = netdev_priv(dev);
-
-	if (!tp->TxDescArray)
-		return 0;
-
-	rtl_lock_work(tp);
-	__rtl8169_set_wol(tp, WAKE_ANY);
-	rtl_unlock_work(tp);
-
-	rtl8169_net_suspend(dev);
-
-	/* Update counters before going runtime suspend */
-	rtl8169_rx_missed(dev);
-	rtl8169_update_counters(tp);
-
-	return 0;
-}
-
-static int rtl8169_runtime_resume(struct device *device)
-{
-	struct pci_dev *pdev = to_pci_dev(device);
-	struct net_device *dev = pci_get_drvdata(pdev);
-	struct rtl8169_private *tp = netdev_priv(dev);
-	rtl_rar_set(tp, dev->dev_addr);
-
-	if (!tp->TxDescArray)
-		return 0;
-
-	rtl_lock_work(tp);
-	__rtl8169_set_wol(tp, tp->saved_wolopts);
-	rtl_unlock_work(tp);
-
-	__rtl8169_resume(dev);
-
-	return 0;
-}
-
-static int rtl8169_runtime_idle(struct device *device)
-{
-	struct pci_dev *pdev = to_pci_dev(device);
-	struct net_device *dev = pci_get_drvdata(pdev);
-
-	if (!netif_running(dev) || !netif_carrier_ok(dev))
-		pm_schedule_suspend(device, 10000);
-
-	return -EBUSY;
-}
-
-static const struct dev_pm_ops rtl8169_pm_ops = {
-	.suspend		= rtl8169_suspend,
-	.resume			= rtl8169_resume,
-	.freeze			= rtl8169_suspend,
-	.thaw			= rtl8169_resume,
-	.poweroff		= rtl8169_suspend,
-	.restore		= rtl8169_resume,
-	.runtime_suspend	= rtl8169_runtime_suspend,
-	.runtime_resume		= rtl8169_runtime_resume,
-	.runtime_idle		= rtl8169_runtime_idle,
-};
-
-#define RTL8169_PM_OPS	(&rtl8169_pm_ops)
-
-#else /* !CONFIG_PM */
-
-#define RTL8169_PM_OPS	NULL
-
-#endif /* !CONFIG_PM */
-
-static void rtl_wol_shutdown_quirk(struct rtl8169_private *tp)
-{
-	/* WoL fails with 8168b when the receiver is disabled. */
-	switch (tp->mac_version) {
-	case RTL_GIGA_MAC_VER_11:
-	case RTL_GIGA_MAC_VER_12:
-	case RTL_GIGA_MAC_VER_17:
-		pci_clear_master(tp->pci_dev);
-
-		RTL_W8(tp, ChipCmd, CmdRxEnb);
-		/* PCI commit */
-		RTL_R8(tp, ChipCmd);
-		break;
-	default:
-		break;
-	}
-}
-
-static void rtl_shutdown(struct pci_dev *pdev)
-{
-	struct net_device *dev = pci_get_drvdata(pdev);
-	struct rtl8169_private *tp = netdev_priv(dev);
-
-	rtl8169_net_suspend(dev);
-
-	/* Restore original MAC address */
-	rtl_rar_set(tp, dev->perm_addr);
-
-	rtl8169_hw_reset(tp);
-
-	if (system_state == SYSTEM_POWER_OFF) {
-		if (tp->saved_wolopts) {
-			rtl_wol_suspend_quirk(tp);
-			rtl_wol_shutdown_quirk(tp);
-		}
-
-		pci_wake_from_d3(pdev, true);
-		pci_set_power_state(pdev, PCI_D3hot);
-	}
-}
-
-static void rtl_remove_one(struct pci_dev *pdev)
-{
-	struct net_device *dev = pci_get_drvdata(pdev);
-	struct rtl8169_private *tp = netdev_priv(dev);
-
-	if (r8168_check_dash(tp))
-		rtl8168_driver_stop(tp);
-
-	netif_napi_del(&tp->napi);
-
-	unregister_netdev(dev);
-	mdiobus_unregister(tp->mii_bus);
-
-	rtl_release_firmware(tp);
-
-	if (pci_dev_run_wake(pdev))
-		pm_runtime_get_noresume(&pdev->dev);
-
-	/* restore original MAC address */
-	rtl_rar_set(tp, dev->perm_addr);
-}
-
-static const struct net_device_ops rtl_netdev_ops = {
-	.ndo_open		= rtl_open,
-	.ndo_stop		= rtl8169_close,
-	.ndo_get_stats64	= rtl8169_get_stats64,
-	.ndo_start_xmit		= rtl8169_start_xmit,
-	.ndo_tx_timeout		= rtl8169_tx_timeout,
-	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_change_mtu		= rtl8169_change_mtu,
-	.ndo_fix_features	= rtl8169_fix_features,
-	.ndo_set_features	= rtl8169_set_features,
-	.ndo_set_mac_address	= rtl_set_mac_address,
-	.ndo_do_ioctl		= rtl8169_ioctl,
-	.ndo_set_rx_mode	= rtl_set_rx_mode,
-#ifdef CONFIG_NET_POLL_CONTROLLER
-	.ndo_poll_controller	= rtl8169_netpoll,
-#endif
-
-};
-
-static const struct rtl_cfg_info {
-	void (*hw_start)(struct rtl8169_private *tp);
-	u16 event_slow;
-	unsigned int has_gmii:1;
-	const struct rtl_coalesce_info *coalesce_info;
-	u8 default_ver;
-} rtl_cfg_infos [] = {
-	[RTL_CFG_0] = {
-		.hw_start	= rtl_hw_start_8169,
-		.event_slow	= SYSErr | LinkChg | RxOverflow | RxFIFOOver,
-		.has_gmii	= 1,
-		.coalesce_info	= rtl_coalesce_info_8169,
-		.default_ver	= RTL_GIGA_MAC_VER_01,
-	},
-	[RTL_CFG_1] = {
-		.hw_start	= rtl_hw_start_8168,
-		.event_slow	= SYSErr | LinkChg | RxOverflow,
-		.has_gmii	= 1,
-		.coalesce_info	= rtl_coalesce_info_8168_8136,
-		.default_ver	= RTL_GIGA_MAC_VER_11,
-	},
-	[RTL_CFG_2] = {
-		.hw_start	= rtl_hw_start_8101,
-		.event_slow	= SYSErr | LinkChg | RxOverflow | RxFIFOOver |
-				  PCSTimeout,
-		.coalesce_info	= rtl_coalesce_info_8168_8136,
-		.default_ver	= RTL_GIGA_MAC_VER_13,
-	}
-};
-
-static int rtl_alloc_irq(struct rtl8169_private *tp)
-{
-	unsigned int flags;
-
-	switch (tp->mac_version) {
-	case RTL_GIGA_MAC_VER_02 ... RTL_GIGA_MAC_VER_06:
-		RTL_W8(tp, Cfg9346, Cfg9346_Unlock);
-		RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~MSIEnable);
-		RTL_W8(tp, Cfg9346, Cfg9346_Lock);
-		/* fall through */
-	case RTL_GIGA_MAC_VER_07 ... RTL_GIGA_MAC_VER_17:
-		flags = PCI_IRQ_LEGACY;
-		break;
-	default:
-		flags = PCI_IRQ_ALL_TYPES;
-		break;
-	}
-
-	return pci_alloc_irq_vectors(tp->pci_dev, 1, 1, flags);
-}
-
-DECLARE_RTL_COND(rtl_link_list_ready_cond)
-{
-	return RTL_R8(tp, MCU) & LINK_LIST_RDY;
-}
-
-DECLARE_RTL_COND(rtl_rxtx_empty_cond)
-{
-	return (RTL_R8(tp, MCU) & RXTX_EMPTY) == RXTX_EMPTY;
-}
-
-static int r8169_mdio_read_reg(struct mii_bus *mii_bus, int phyaddr, int phyreg)
-{
-	struct rtl8169_private *tp = mii_bus->priv;
-
-	if (phyaddr > 0)
-		return -ENODEV;
-
-	return rtl_readphy(tp, phyreg);
-}
-
-static int r8169_mdio_write_reg(struct mii_bus *mii_bus, int phyaddr,
-				int phyreg, u16 val)
-{
-	struct rtl8169_private *tp = mii_bus->priv;
-
-	if (phyaddr > 0)
-		return -ENODEV;
-
-	rtl_writephy(tp, phyreg, val);
-
-	return 0;
-}
-
-static int r8169_mdio_register(struct rtl8169_private *tp)
-{
-	struct pci_dev *pdev = tp->pci_dev;
-	struct phy_device *phydev;
-	struct mii_bus *new_bus;
-	int ret;
-
-	new_bus = devm_mdiobus_alloc(&pdev->dev);
-	if (!new_bus)
-		return -ENOMEM;
-
-	new_bus->name = "r8169";
-	new_bus->priv = tp;
-	new_bus->parent = &pdev->dev;
-	new_bus->irq[0] = PHY_IGNORE_INTERRUPT;
-	snprintf(new_bus->id, MII_BUS_ID_SIZE, "r8169-%x",
-		 PCI_DEVID(pdev->bus->number, pdev->devfn));
-
-	new_bus->read = r8169_mdio_read_reg;
-	new_bus->write = r8169_mdio_write_reg;
-
-	ret = mdiobus_register(new_bus);
-	if (ret)
-		return ret;
-
-	phydev = mdiobus_get_phy(new_bus, 0);
-	if (!phydev) {
-		mdiobus_unregister(new_bus);
-		return -ENODEV;
-	}
-
-	/* PHY will be woken up in rtl_open() */
-	phy_suspend(phydev);
-
-	tp->mii_bus = new_bus;
-
-	return 0;
-}
-
-static void rtl_hw_init_8168g(struct rtl8169_private *tp)
-{
-	u32 data;
-
-	tp->ocp_base = OCP_STD_PHY_BASE;
-
-	RTL_W32(tp, MISC, RTL_R32(tp, MISC) | RXDV_GATED_EN);
-
-	if (!rtl_udelay_loop_wait_high(tp, &rtl_txcfg_empty_cond, 100, 42))
-		return;
-
-	if (!rtl_udelay_loop_wait_high(tp, &rtl_rxtx_empty_cond, 100, 42))
-		return;
-
-	RTL_W8(tp, ChipCmd, RTL_R8(tp, ChipCmd) & ~(CmdTxEnb | CmdRxEnb));
-	msleep(1);
-	RTL_W8(tp, MCU, RTL_R8(tp, MCU) & ~NOW_IS_OOB);
-
-	data = r8168_mac_ocp_read(tp, 0xe8de);
-	data &= ~(1 << 14);
-	r8168_mac_ocp_write(tp, 0xe8de, data);
-
-	if (!rtl_udelay_loop_wait_high(tp, &rtl_link_list_ready_cond, 100, 42))
-		return;
-
-	data = r8168_mac_ocp_read(tp, 0xe8de);
-	data |= (1 << 15);
-	r8168_mac_ocp_write(tp, 0xe8de, data);
-
-	if (!rtl_udelay_loop_wait_high(tp, &rtl_link_list_ready_cond, 100, 42))
-		return;
-}
-
-static void rtl_hw_init_8168ep(struct rtl8169_private *tp)
-{
-	rtl8168ep_stop_cmac(tp);
-	rtl_hw_init_8168g(tp);
-}
-
-static void rtl_hw_initialize(struct rtl8169_private *tp)
-{
-	switch (tp->mac_version) {
-	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_48:
-		rtl_hw_init_8168g(tp);
-		break;
-	case RTL_GIGA_MAC_VER_49 ... RTL_GIGA_MAC_VER_51:
-		rtl_hw_init_8168ep(tp);
-		break;
-	default:
-		break;
-	}
-}
-
-/* Versions RTL8102e and from RTL8168c onwards support csum_v2 */
-static bool rtl_chip_supports_csum_v2(struct rtl8169_private *tp)
-{
-	switch (tp->mac_version) {
-	case RTL_GIGA_MAC_VER_01 ... RTL_GIGA_MAC_VER_06:
-	case RTL_GIGA_MAC_VER_10 ... RTL_GIGA_MAC_VER_17:
-		return false;
-	default:
-		return true;
-	}
-}
-
-static int rtl_jumbo_max(struct rtl8169_private *tp)
-{
-	/* Non-GBit versions don't support jumbo frames */
-	if (!tp->supports_gmii)
-		return JUMBO_1K;
-
-	switch (tp->mac_version) {
-	/* RTL8169 */
-	case RTL_GIGA_MAC_VER_01 ... RTL_GIGA_MAC_VER_06:
-		return JUMBO_7K;
-	/* RTL8168b */
-	case RTL_GIGA_MAC_VER_11:
-	case RTL_GIGA_MAC_VER_12:
-	case RTL_GIGA_MAC_VER_17:
-		return JUMBO_4K;
-	/* RTL8168c */
-	case RTL_GIGA_MAC_VER_18 ... RTL_GIGA_MAC_VER_24:
-		return JUMBO_6K;
-	default:
-		return JUMBO_9K;
-	}
-}
-
-static void rtl_disable_clk(void *data)
-{
-	clk_disable_unprepare(data);
-}
-
-static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
-{
-	const struct rtl_cfg_info *cfg = rtl_cfg_infos + ent->driver_data;
-	struct rtl8169_private *tp;
-	struct net_device *dev;
-	int chipset, region, i;
-	int jumbo_max, rc;
-
-	dev = devm_alloc_etherdev(&pdev->dev, sizeof (*tp));
-	if (!dev)
-		return -ENOMEM;
-
-	SET_NETDEV_DEV(dev, &pdev->dev);
-	dev->netdev_ops = &rtl_netdev_ops;
-	tp = netdev_priv(dev);
-	tp->dev = dev;
-	tp->pci_dev = pdev;
-	tp->msg_enable = netif_msg_init(debug.msg_enable, R8169_MSG_DEFAULT);
-	tp->supports_gmii = cfg->has_gmii;
-
-	/* Get the *optional* external "ether_clk" used on some boards */
-	tp->clk = devm_clk_get(&pdev->dev, "ether_clk");
-	if (IS_ERR(tp->clk)) {
-		rc = PTR_ERR(tp->clk);
-		if (rc == -ENOENT) {
-			/* clk-core allows NULL (for suspend / resume) */
-			tp->clk = NULL;
-		} else if (rc == -EPROBE_DEFER) {
-			return rc;
-		} else {
-			dev_err(&pdev->dev, "failed to get clk: %d\n", rc);
-			return rc;
-		}
-	} else {
-		rc = clk_prepare_enable(tp->clk);
-		if (rc) {
-			dev_err(&pdev->dev, "failed to enable clk: %d\n", rc);
-			return rc;
-		}
-
-		rc = devm_add_action_or_reset(&pdev->dev, rtl_disable_clk,
-					      tp->clk);
-		if (rc)
-			return rc;
-	}
-
-	/* Disable ASPM completely as that cause random device stop working
-	 * problems as well as full system hangs for some PCIe devices users.
-	 */
-	pci_disable_link_state(pdev, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1);
-
-	/* enable device (incl. PCI PM wakeup and hotplug setup) */
-	rc = pcim_enable_device(pdev);
-	if (rc < 0) {
-		dev_err(&pdev->dev, "enable failure\n");
-		return rc;
-	}
-
-	if (pcim_set_mwi(pdev) < 0)
-		dev_info(&pdev->dev, "Mem-Wr-Inval unavailable\n");
-
-	/* use first MMIO region */
-	region = ffs(pci_select_bars(pdev, IORESOURCE_MEM)) - 1;
-	if (region < 0) {
-		dev_err(&pdev->dev, "no MMIO resource found\n");
-		return -ENODEV;
-	}
-
-	/* check for weird/broken PCI region reporting */
-	if (pci_resource_len(pdev, region) < R8169_REGS_SIZE) {
-		dev_err(&pdev->dev, "Invalid PCI region size(s), aborting\n");
-		return -ENODEV;
-	}
-
-	rc = pcim_iomap_regions(pdev, BIT(region), MODULENAME);
-	if (rc < 0) {
-		dev_err(&pdev->dev, "cannot remap MMIO, aborting\n");
-		return rc;
-	}
-
-	tp->mmio_addr = pcim_iomap_table(pdev)[region];
-
-	if (!pci_is_pcie(pdev))
-		dev_info(&pdev->dev, "not PCI Express\n");
-
-	/* Identify chip attached to board */
-	rtl8169_get_mac_version(tp, cfg->default_ver);
-
-	if (rtl_tbi_enabled(tp)) {
-		dev_err(&pdev->dev, "TBI fiber mode not supported\n");
-		return -ENODEV;
-	}
-
-	tp->cp_cmd = RTL_R16(tp, CPlusCmd);
-
-	if ((sizeof(dma_addr_t) > 4) &&
-	    (use_dac == 1 || (use_dac == -1 && pci_is_pcie(pdev) &&
-			      tp->mac_version >= RTL_GIGA_MAC_VER_18)) &&
-	    !pci_set_dma_mask(pdev, DMA_BIT_MASK(64)) &&
-	    !pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64))) {
-
-		/* CPlusCmd Dual Access Cycle is only needed for non-PCIe */
-		if (!pci_is_pcie(pdev))
-			tp->cp_cmd |= PCIDAC;
-		dev->features |= NETIF_F_HIGHDMA;
-	} else {
-		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
-		if (rc < 0) {
-			dev_err(&pdev->dev, "DMA configuration failed\n");
-			return rc;
-		}
-	}
-
-	rtl_init_rxcfg(tp);
-
-	rtl_irq_disable(tp);
-
-	rtl_hw_initialize(tp);
-
-	rtl_hw_reset(tp);
-
-	rtl_ack_events(tp, 0xffff);
-
-	pci_set_master(pdev);
-
-	rtl_init_mdio_ops(tp);
-	rtl_init_jumbo_ops(tp);
-
-	rtl8169_print_mac_version(tp);
-
-	chipset = tp->mac_version;
-
-	rc = rtl_alloc_irq(tp);
-	if (rc < 0) {
-		dev_err(&pdev->dev, "Can't allocate interrupt\n");
-		return rc;
-	}
-
-	tp->saved_wolopts = __rtl8169_get_wol(tp);
-
-	mutex_init(&tp->wk.mutex);
-	u64_stats_init(&tp->rx_stats.syncp);
-	u64_stats_init(&tp->tx_stats.syncp);
-
-	/* Get MAC address */
-	switch (tp->mac_version) {
-		u8 mac_addr[ETH_ALEN] __aligned(4);
-	case RTL_GIGA_MAC_VER_35 ... RTL_GIGA_MAC_VER_38:
-	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_51:
-		*(u32 *)&mac_addr[0] = rtl_eri_read(tp, 0xe0, ERIAR_EXGMAC);
-		*(u16 *)&mac_addr[4] = rtl_eri_read(tp, 0xe4, ERIAR_EXGMAC);
-
-		if (is_valid_ether_addr(mac_addr))
-			rtl_rar_set(tp, mac_addr);
-		break;
-	default:
-		break;
-	}
-	for (i = 0; i < ETH_ALEN; i++)
-		dev->dev_addr[i] = RTL_R8(tp, MAC0 + i);
-
-	dev->ethtool_ops = &rtl8169_ethtool_ops;
-	dev->watchdog_timeo = RTL8169_TX_TIMEOUT;
-
-	netif_napi_add(dev, &tp->napi, rtl8169_poll, NAPI_POLL_WEIGHT);
-
-	/* don't enable SG, IP_CSUM and TSO by default - it might not work
-	 * properly for all devices */
-	dev->features |= NETIF_F_RXCSUM |
-		NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX;
-
-	dev->hw_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_TSO |
-		NETIF_F_RXCSUM | NETIF_F_HW_VLAN_CTAG_TX |
-		NETIF_F_HW_VLAN_CTAG_RX;
-	dev->vlan_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_TSO |
-		NETIF_F_HIGHDMA;
-	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
-
-	tp->cp_cmd |= RxChkSum | RxVlan;
-
-	/*
-	 * Pretend we are using VLANs; This bypasses a nasty bug where
-	 * Interrupts stop flowing on high load on 8110SCd controllers.
-	 */
-	if (tp->mac_version == RTL_GIGA_MAC_VER_05)
-		/* Disallow toggling */
-		dev->hw_features &= ~NETIF_F_HW_VLAN_CTAG_RX;
-
-	if (rtl_chip_supports_csum_v2(tp)) {
-		tp->tso_csum = rtl8169_tso_csum_v2;
-		dev->hw_features |= NETIF_F_IPV6_CSUM | NETIF_F_TSO6;
-	} else {
-		tp->tso_csum = rtl8169_tso_csum_v1;
-	}
-
-	dev->hw_features |= NETIF_F_RXALL;
-	dev->hw_features |= NETIF_F_RXFCS;
-
-	/* MTU range: 60 - hw-specific max */
-	dev->min_mtu = ETH_ZLEN;
-	jumbo_max = rtl_jumbo_max(tp);
-	dev->max_mtu = jumbo_max;
-
-	tp->hw_start = cfg->hw_start;
-	tp->event_slow = cfg->event_slow;
-	tp->coalesce_info = cfg->coalesce_info;
-
-	tp->rtl_fw = RTL_FIRMWARE_UNKNOWN;
-
-	tp->counters = dmam_alloc_coherent (&pdev->dev, sizeof(*tp->counters),
-					    &tp->counters_phys_addr,
-					    GFP_KERNEL);
-	if (!tp->counters)
-		return -ENOMEM;
-
-	pci_set_drvdata(pdev, dev);
-
-	rc = r8169_mdio_register(tp);
-	if (rc)
-		return rc;
-
-	/* chip gets powered up in rtl_open() */
-	rtl_pll_power_down(tp);
-
-	rc = register_netdev(dev);
-	if (rc)
-		goto err_mdio_unregister;
-
-	netif_info(tp, probe, dev, "%s, %pM, XID %08x, IRQ %d\n",
-		   rtl_chip_infos[chipset].name, dev->dev_addr,
-		   (u32)(RTL_R32(tp, TxConfig) & 0xfcf0f8ff),
-		   pci_irq_vector(pdev, 0));
-
-	if (jumbo_max > JUMBO_1K)
-		netif_info(tp, probe, dev,
-			   "jumbo features [frames: %d bytes, tx checksumming: %s]\n",
-			   jumbo_max, tp->mac_version <= RTL_GIGA_MAC_VER_06 ?
-			   "ok" : "ko");
-
-	if (r8168_check_dash(tp))
-		rtl8168_driver_start(tp);
-
-	if (pci_dev_run_wake(pdev))
-		pm_runtime_put_sync(&pdev->dev);
-
-	return 0;
-
-err_mdio_unregister:
-	mdiobus_unregister(tp->mii_bus);
-	return rc;
-}
-
-static struct pci_driver rtl8169_pci_driver = {
-	.name		= MODULENAME,
-	.id_table	= rtl8169_pci_tbl,
-	.probe		= rtl_init_one,
-	.remove		= rtl_remove_one,
-	.shutdown	= rtl_shutdown,
-	.driver.pm	= RTL8169_PM_OPS,
-};
-
-module_pci_driver(rtl8169_pci_driver);
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
new file mode 100644
index 000000000000..92875a935eb1
--- /dev/null
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -0,0 +1,7698 @@
+/*
+ * r8169.c: RealTek 8169/8168/8101 ethernet driver.
+ *
+ * Copyright (c) 2002 ShuChen <shuchen@realtek.com.tw>
+ * Copyright (c) 2003 - 2007 Francois Romieu <romieu@fr.zoreil.com>
+ * Copyright (c) a lot of people too. Please respect their work.
+ *
+ * See MAINTAINERS file for support contact information.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/pci.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/ethtool.h>
+#include <linux/phy.h>
+#include <linux/if_vlan.h>
+#include <linux/crc32.h>
+#include <linux/in.h>
+#include <linux/io.h>
+#include <linux/ip.h>
+#include <linux/tcp.h>
+#include <linux/interrupt.h>
+#include <linux/dma-mapping.h>
+#include <linux/pm_runtime.h>
+#include <linux/firmware.h>
+#include <linux/prefetch.h>
+#include <linux/pci-aspm.h>
+#include <linux/ipv6.h>
+#include <net/ip6_checksum.h>
+
+#define MODULENAME "r8169"
+
+#define FIRMWARE_8168D_1	"rtl_nic/rtl8168d-1.fw"
+#define FIRMWARE_8168D_2	"rtl_nic/rtl8168d-2.fw"
+#define FIRMWARE_8168E_1	"rtl_nic/rtl8168e-1.fw"
+#define FIRMWARE_8168E_2	"rtl_nic/rtl8168e-2.fw"
+#define FIRMWARE_8168E_3	"rtl_nic/rtl8168e-3.fw"
+#define FIRMWARE_8168F_1	"rtl_nic/rtl8168f-1.fw"
+#define FIRMWARE_8168F_2	"rtl_nic/rtl8168f-2.fw"
+#define FIRMWARE_8105E_1	"rtl_nic/rtl8105e-1.fw"
+#define FIRMWARE_8402_1		"rtl_nic/rtl8402-1.fw"
+#define FIRMWARE_8411_1		"rtl_nic/rtl8411-1.fw"
+#define FIRMWARE_8411_2		"rtl_nic/rtl8411-2.fw"
+#define FIRMWARE_8106E_1	"rtl_nic/rtl8106e-1.fw"
+#define FIRMWARE_8106E_2	"rtl_nic/rtl8106e-2.fw"
+#define FIRMWARE_8168G_2	"rtl_nic/rtl8168g-2.fw"
+#define FIRMWARE_8168G_3	"rtl_nic/rtl8168g-3.fw"
+#define FIRMWARE_8168H_1	"rtl_nic/rtl8168h-1.fw"
+#define FIRMWARE_8168H_2	"rtl_nic/rtl8168h-2.fw"
+#define FIRMWARE_8107E_1	"rtl_nic/rtl8107e-1.fw"
+#define FIRMWARE_8107E_2	"rtl_nic/rtl8107e-2.fw"
+
+#define R8169_MSG_DEFAULT \
+	(NETIF_MSG_DRV | NETIF_MSG_PROBE | NETIF_MSG_IFUP | NETIF_MSG_IFDOWN)
+
+#define TX_SLOTS_AVAIL(tp) \
+	(tp->dirty_tx + NUM_TX_DESC - tp->cur_tx)
+
+/* A skbuff with nr_frags needs nr_frags+1 entries in the tx queue */
+#define TX_FRAGS_READY_FOR(tp,nr_frags) \
+	(TX_SLOTS_AVAIL(tp) >= (nr_frags + 1))
+
+/* Maximum number of multicast addresses to filter (vs. Rx-all-multicast).
+   The RTL chips use a 64 element hash table based on the Ethernet CRC. */
+static const int multicast_filter_limit = 32;
+
+#define TX_DMA_BURST	7	/* Maximum PCI burst, '7' is unlimited */
+#define InterFrameGap	0x03	/* 3 means InterFrameGap = the shortest one */
+
+#define R8169_REGS_SIZE		256
+#define R8169_RX_BUF_SIZE	(SZ_16K - 1)
+#define NUM_TX_DESC	64	/* Number of Tx descriptor registers */
+#define NUM_RX_DESC	256U	/* Number of Rx descriptor registers */
+#define R8169_TX_RING_BYTES	(NUM_TX_DESC * sizeof(struct TxDesc))
+#define R8169_RX_RING_BYTES	(NUM_RX_DESC * sizeof(struct RxDesc))
+
+#define RTL8169_TX_TIMEOUT	(6*HZ)
+
+/* write/read MMIO register */
+#define RTL_W8(tp, reg, val8)	writeb((val8), tp->mmio_addr + (reg))
+#define RTL_W16(tp, reg, val16)	writew((val16), tp->mmio_addr + (reg))
+#define RTL_W32(tp, reg, val32)	writel((val32), tp->mmio_addr + (reg))
+#define RTL_R8(tp, reg)		readb(tp->mmio_addr + (reg))
+#define RTL_R16(tp, reg)		readw(tp->mmio_addr + (reg))
+#define RTL_R32(tp, reg)		readl(tp->mmio_addr + (reg))
+
+enum mac_version {
+	RTL_GIGA_MAC_VER_01 = 0,
+	RTL_GIGA_MAC_VER_02,
+	RTL_GIGA_MAC_VER_03,
+	RTL_GIGA_MAC_VER_04,
+	RTL_GIGA_MAC_VER_05,
+	RTL_GIGA_MAC_VER_06,
+	RTL_GIGA_MAC_VER_07,
+	RTL_GIGA_MAC_VER_08,
+	RTL_GIGA_MAC_VER_09,
+	RTL_GIGA_MAC_VER_10,
+	RTL_GIGA_MAC_VER_11,
+	RTL_GIGA_MAC_VER_12,
+	RTL_GIGA_MAC_VER_13,
+	RTL_GIGA_MAC_VER_14,
+	RTL_GIGA_MAC_VER_15,
+	RTL_GIGA_MAC_VER_16,
+	RTL_GIGA_MAC_VER_17,
+	RTL_GIGA_MAC_VER_18,
+	RTL_GIGA_MAC_VER_19,
+	RTL_GIGA_MAC_VER_20,
+	RTL_GIGA_MAC_VER_21,
+	RTL_GIGA_MAC_VER_22,
+	RTL_GIGA_MAC_VER_23,
+	RTL_GIGA_MAC_VER_24,
+	RTL_GIGA_MAC_VER_25,
+	RTL_GIGA_MAC_VER_26,
+	RTL_GIGA_MAC_VER_27,
+	RTL_GIGA_MAC_VER_28,
+	RTL_GIGA_MAC_VER_29,
+	RTL_GIGA_MAC_VER_30,
+	RTL_GIGA_MAC_VER_31,
+	RTL_GIGA_MAC_VER_32,
+	RTL_GIGA_MAC_VER_33,
+	RTL_GIGA_MAC_VER_34,
+	RTL_GIGA_MAC_VER_35,
+	RTL_GIGA_MAC_VER_36,
+	RTL_GIGA_MAC_VER_37,
+	RTL_GIGA_MAC_VER_38,
+	RTL_GIGA_MAC_VER_39,
+	RTL_GIGA_MAC_VER_40,
+	RTL_GIGA_MAC_VER_41,
+	RTL_GIGA_MAC_VER_42,
+	RTL_GIGA_MAC_VER_43,
+	RTL_GIGA_MAC_VER_44,
+	RTL_GIGA_MAC_VER_45,
+	RTL_GIGA_MAC_VER_46,
+	RTL_GIGA_MAC_VER_47,
+	RTL_GIGA_MAC_VER_48,
+	RTL_GIGA_MAC_VER_49,
+	RTL_GIGA_MAC_VER_50,
+	RTL_GIGA_MAC_VER_51,
+	RTL_GIGA_MAC_NONE   = 0xff,
+};
+
+#define JUMBO_1K	ETH_DATA_LEN
+#define JUMBO_4K	(4*1024 - ETH_HLEN - 2)
+#define JUMBO_6K	(6*1024 - ETH_HLEN - 2)
+#define JUMBO_7K	(7*1024 - ETH_HLEN - 2)
+#define JUMBO_9K	(9*1024 - ETH_HLEN - 2)
+
+static const struct {
+	const char *name;
+	const char *fw_name;
+} rtl_chip_infos[] = {
+	/* PCI devices. */
+	[RTL_GIGA_MAC_VER_01] = {"RTL8169"				},
+	[RTL_GIGA_MAC_VER_02] = {"RTL8169s"				},
+	[RTL_GIGA_MAC_VER_03] = {"RTL8110s"				},
+	[RTL_GIGA_MAC_VER_04] = {"RTL8169sb/8110sb"			},
+	[RTL_GIGA_MAC_VER_05] = {"RTL8169sc/8110sc"			},
+	[RTL_GIGA_MAC_VER_06] = {"RTL8169sc/8110sc"			},
+	/* PCI-E devices. */
+	[RTL_GIGA_MAC_VER_07] = {"RTL8102e"				},
+	[RTL_GIGA_MAC_VER_08] = {"RTL8102e"				},
+	[RTL_GIGA_MAC_VER_09] = {"RTL8102e"				},
+	[RTL_GIGA_MAC_VER_10] = {"RTL8101e"				},
+	[RTL_GIGA_MAC_VER_11] = {"RTL8168b/8111b"			},
+	[RTL_GIGA_MAC_VER_12] = {"RTL8168b/8111b"			},
+	[RTL_GIGA_MAC_VER_13] = {"RTL8101e"				},
+	[RTL_GIGA_MAC_VER_14] = {"RTL8100e"				},
+	[RTL_GIGA_MAC_VER_15] = {"RTL8100e"				},
+	[RTL_GIGA_MAC_VER_16] = {"RTL8101e"				},
+	[RTL_GIGA_MAC_VER_17] = {"RTL8168b/8111b"			},
+	[RTL_GIGA_MAC_VER_18] = {"RTL8168cp/8111cp"			},
+	[RTL_GIGA_MAC_VER_19] = {"RTL8168c/8111c"			},
+	[RTL_GIGA_MAC_VER_20] = {"RTL8168c/8111c"			},
+	[RTL_GIGA_MAC_VER_21] = {"RTL8168c/8111c"			},
+	[RTL_GIGA_MAC_VER_22] = {"RTL8168c/8111c"			},
+	[RTL_GIGA_MAC_VER_23] = {"RTL8168cp/8111cp"			},
+	[RTL_GIGA_MAC_VER_24] = {"RTL8168cp/8111cp"			},
+	[RTL_GIGA_MAC_VER_25] = {"RTL8168d/8111d",	FIRMWARE_8168D_1},
+	[RTL_GIGA_MAC_VER_26] = {"RTL8168d/8111d",	FIRMWARE_8168D_2},
+	[RTL_GIGA_MAC_VER_27] = {"RTL8168dp/8111dp"			},
+	[RTL_GIGA_MAC_VER_28] = {"RTL8168dp/8111dp"			},
+	[RTL_GIGA_MAC_VER_29] = {"RTL8105e",		FIRMWARE_8105E_1},
+	[RTL_GIGA_MAC_VER_30] = {"RTL8105e",		FIRMWARE_8105E_1},
+	[RTL_GIGA_MAC_VER_31] = {"RTL8168dp/8111dp"			},
+	[RTL_GIGA_MAC_VER_32] = {"RTL8168e/8111e",	FIRMWARE_8168E_1},
+	[RTL_GIGA_MAC_VER_33] = {"RTL8168e/8111e",	FIRMWARE_8168E_2},
+	[RTL_GIGA_MAC_VER_34] = {"RTL8168evl/8111evl",	FIRMWARE_8168E_3},
+	[RTL_GIGA_MAC_VER_35] = {"RTL8168f/8111f",	FIRMWARE_8168F_1},
+	[RTL_GIGA_MAC_VER_36] = {"RTL8168f/8111f",	FIRMWARE_8168F_2},
+	[RTL_GIGA_MAC_VER_37] = {"RTL8402",		FIRMWARE_8402_1 },
+	[RTL_GIGA_MAC_VER_38] = {"RTL8411",		FIRMWARE_8411_1 },
+	[RTL_GIGA_MAC_VER_39] = {"RTL8106e",		FIRMWARE_8106E_1},
+	[RTL_GIGA_MAC_VER_40] = {"RTL8168g/8111g",	FIRMWARE_8168G_2},
+	[RTL_GIGA_MAC_VER_41] = {"RTL8168g/8111g"			},
+	[RTL_GIGA_MAC_VER_42] = {"RTL8168g/8111g",	FIRMWARE_8168G_3},
+	[RTL_GIGA_MAC_VER_43] = {"RTL8106e",		FIRMWARE_8106E_2},
+	[RTL_GIGA_MAC_VER_44] = {"RTL8411",		FIRMWARE_8411_2 },
+	[RTL_GIGA_MAC_VER_45] = {"RTL8168h/8111h",	FIRMWARE_8168H_1},
+	[RTL_GIGA_MAC_VER_46] = {"RTL8168h/8111h",	FIRMWARE_8168H_2},
+	[RTL_GIGA_MAC_VER_47] = {"RTL8107e",		FIRMWARE_8107E_1},
+	[RTL_GIGA_MAC_VER_48] = {"RTL8107e",		FIRMWARE_8107E_2},
+	[RTL_GIGA_MAC_VER_49] = {"RTL8168ep/8111ep"			},
+	[RTL_GIGA_MAC_VER_50] = {"RTL8168ep/8111ep"			},
+	[RTL_GIGA_MAC_VER_51] = {"RTL8168ep/8111ep"			},
+};
+
+enum cfg_version {
+	RTL_CFG_0 = 0x00,
+	RTL_CFG_1,
+	RTL_CFG_2
+};
+
+static const struct pci_device_id rtl8169_pci_tbl[] = {
+	{ PCI_VDEVICE(REALTEK,	0x2502), RTL_CFG_1 },
+	{ PCI_VDEVICE(REALTEK,	0x2600), RTL_CFG_1 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK,	0x8129), 0, 0, RTL_CFG_0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK,	0x8136), 0, 0, RTL_CFG_2 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK,	0x8161), 0, 0, RTL_CFG_1 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK,	0x8167), 0, 0, RTL_CFG_0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK,	0x8168), 0, 0, RTL_CFG_1 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NCUBE,	0x8168), 0, 0, RTL_CFG_1 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK,	0x8169), 0, 0, RTL_CFG_0 },
+	{ PCI_VENDOR_ID_DLINK,			0x4300,
+		PCI_VENDOR_ID_DLINK, 0x4b10,		 0, 0, RTL_CFG_1 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK,	0x4300), 0, 0, RTL_CFG_0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK,	0x4302), 0, 0, RTL_CFG_0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AT,		0xc107), 0, 0, RTL_CFG_0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_USR,		0x0116), 0, 0, RTL_CFG_0 },
+	{ PCI_VENDOR_ID_LINKSYS,		0x1032,
+		PCI_ANY_ID, 0x0024, 0, 0, RTL_CFG_0 },
+	{ 0x0001,				0x8168,
+		PCI_ANY_ID, 0x2410, 0, 0, RTL_CFG_2 },
+	{0,},
+};
+
+MODULE_DEVICE_TABLE(pci, rtl8169_pci_tbl);
+
+static int use_dac = -1;
+static struct {
+	u32 msg_enable;
+} debug = { -1 };
+
+enum rtl_registers {
+	MAC0		= 0,	/* Ethernet hardware address. */
+	MAC4		= 4,
+	MAR0		= 8,	/* Multicast filter. */
+	CounterAddrLow		= 0x10,
+	CounterAddrHigh		= 0x14,
+	TxDescStartAddrLow	= 0x20,
+	TxDescStartAddrHigh	= 0x24,
+	TxHDescStartAddrLow	= 0x28,
+	TxHDescStartAddrHigh	= 0x2c,
+	FLASH		= 0x30,
+	ERSR		= 0x36,
+	ChipCmd		= 0x37,
+	TxPoll		= 0x38,
+	IntrMask	= 0x3c,
+	IntrStatus	= 0x3e,
+
+	TxConfig	= 0x40,
+#define	TXCFG_AUTO_FIFO			(1 << 7)	/* 8111e-vl */
+#define	TXCFG_EMPTY			(1 << 11)	/* 8111e-vl */
+
+	RxConfig	= 0x44,
+#define	RX128_INT_EN			(1 << 15)	/* 8111c and later */
+#define	RX_MULTI_EN			(1 << 14)	/* 8111c only */
+#define	RXCFG_FIFO_SHIFT		13
+					/* No threshold before first PCI xfer */
+#define	RX_FIFO_THRESH			(7 << RXCFG_FIFO_SHIFT)
+#define	RX_EARLY_OFF			(1 << 11)
+#define	RXCFG_DMA_SHIFT			8
+					/* Unlimited maximum PCI burst. */
+#define	RX_DMA_BURST			(7 << RXCFG_DMA_SHIFT)
+
+	RxMissed	= 0x4c,
+	Cfg9346		= 0x50,
+	Config0		= 0x51,
+	Config1		= 0x52,
+	Config2		= 0x53,
+#define PME_SIGNAL			(1 << 5)	/* 8168c and later */
+
+	Config3		= 0x54,
+	Config4		= 0x55,
+	Config5		= 0x56,
+	MultiIntr	= 0x5c,
+	PHYAR		= 0x60,
+	PHYstatus	= 0x6c,
+	RxMaxSize	= 0xda,
+	CPlusCmd	= 0xe0,
+	IntrMitigate	= 0xe2,
+
+#define RTL_COALESCE_MASK	0x0f
+#define RTL_COALESCE_SHIFT	4
+#define RTL_COALESCE_T_MAX	(RTL_COALESCE_MASK)
+#define RTL_COALESCE_FRAME_MAX	(RTL_COALESCE_MASK << 2)
+
+	RxDescAddrLow	= 0xe4,
+	RxDescAddrHigh	= 0xe8,
+	EarlyTxThres	= 0xec,	/* 8169. Unit of 32 bytes. */
+
+#define NoEarlyTx	0x3f	/* Max value : no early transmit. */
+
+	MaxTxPacketSize	= 0xec,	/* 8101/8168. Unit of 128 bytes. */
+
+#define TxPacketMax	(8064 >> 7)
+#define EarlySize	0x27
+
+	FuncEvent	= 0xf0,
+	FuncEventMask	= 0xf4,
+	FuncPresetState	= 0xf8,
+	IBCR0           = 0xf8,
+	IBCR2           = 0xf9,
+	IBIMR0          = 0xfa,
+	IBISR0          = 0xfb,
+	FuncForceEvent	= 0xfc,
+};
+
+enum rtl8168_8101_registers {
+	CSIDR			= 0x64,
+	CSIAR			= 0x68,
+#define	CSIAR_FLAG			0x80000000
+#define	CSIAR_WRITE_CMD			0x80000000
+#define	CSIAR_BYTE_ENABLE		0x0000f000
+#define	CSIAR_ADDR_MASK			0x00000fff
+	PMCH			= 0x6f,
+	EPHYAR			= 0x80,
+#define	EPHYAR_FLAG			0x80000000
+#define	EPHYAR_WRITE_CMD		0x80000000
+#define	EPHYAR_REG_MASK			0x1f
+#define	EPHYAR_REG_SHIFT		16
+#define	EPHYAR_DATA_MASK		0xffff
+	DLLPR			= 0xd0,
+#define	PFM_EN				(1 << 6)
+#define	TX_10M_PS_EN			(1 << 7)
+	DBG_REG			= 0xd1,
+#define	FIX_NAK_1			(1 << 4)
+#define	FIX_NAK_2			(1 << 3)
+	TWSI			= 0xd2,
+	MCU			= 0xd3,
+#define	NOW_IS_OOB			(1 << 7)
+#define	TX_EMPTY			(1 << 5)
+#define	RX_EMPTY			(1 << 4)
+#define	RXTX_EMPTY			(TX_EMPTY | RX_EMPTY)
+#define	EN_NDP				(1 << 3)
+#define	EN_OOB_RESET			(1 << 2)
+#define	LINK_LIST_RDY			(1 << 1)
+	EFUSEAR			= 0xdc,
+#define	EFUSEAR_FLAG			0x80000000
+#define	EFUSEAR_WRITE_CMD		0x80000000
+#define	EFUSEAR_READ_CMD		0x00000000
+#define	EFUSEAR_REG_MASK		0x03ff
+#define	EFUSEAR_REG_SHIFT		8
+#define	EFUSEAR_DATA_MASK		0xff
+	MISC_1			= 0xf2,
+#define	PFM_D3COLD_EN			(1 << 6)
+};
+
+enum rtl8168_registers {
+	LED_FREQ		= 0x1a,
+	EEE_LED			= 0x1b,
+	ERIDR			= 0x70,
+	ERIAR			= 0x74,
+#define ERIAR_FLAG			0x80000000
+#define ERIAR_WRITE_CMD			0x80000000
+#define ERIAR_READ_CMD			0x00000000
+#define ERIAR_ADDR_BYTE_ALIGN		4
+#define ERIAR_TYPE_SHIFT		16
+#define ERIAR_EXGMAC			(0x00 << ERIAR_TYPE_SHIFT)
+#define ERIAR_MSIX			(0x01 << ERIAR_TYPE_SHIFT)
+#define ERIAR_ASF			(0x02 << ERIAR_TYPE_SHIFT)
+#define ERIAR_OOB			(0x02 << ERIAR_TYPE_SHIFT)
+#define ERIAR_MASK_SHIFT		12
+#define ERIAR_MASK_0001			(0x1 << ERIAR_MASK_SHIFT)
+#define ERIAR_MASK_0011			(0x3 << ERIAR_MASK_SHIFT)
+#define ERIAR_MASK_0100			(0x4 << ERIAR_MASK_SHIFT)
+#define ERIAR_MASK_0101			(0x5 << ERIAR_MASK_SHIFT)
+#define ERIAR_MASK_1111			(0xf << ERIAR_MASK_SHIFT)
+	EPHY_RXER_NUM		= 0x7c,
+	OCPDR			= 0xb0,	/* OCP GPHY access */
+#define OCPDR_WRITE_CMD			0x80000000
+#define OCPDR_READ_CMD			0x00000000
+#define OCPDR_REG_MASK			0x7f
+#define OCPDR_GPHY_REG_SHIFT		16
+#define OCPDR_DATA_MASK			0xffff
+	OCPAR			= 0xb4,
+#define OCPAR_FLAG			0x80000000
+#define OCPAR_GPHY_WRITE_CMD		0x8000f060
+#define OCPAR_GPHY_READ_CMD		0x0000f060
+	GPHY_OCP		= 0xb8,
+	RDSAR1			= 0xd0,	/* 8168c only. Undocumented on 8168dp */
+	MISC			= 0xf0,	/* 8168e only. */
+#define TXPLA_RST			(1 << 29)
+#define DISABLE_LAN_EN			(1 << 23) /* Enable GPIO pin */
+#define PWM_EN				(1 << 22)
+#define RXDV_GATED_EN			(1 << 19)
+#define EARLY_TALLY_EN			(1 << 16)
+};
+
+enum rtl_register_content {
+	/* InterruptStatusBits */
+	SYSErr		= 0x8000,
+	PCSTimeout	= 0x4000,
+	SWInt		= 0x0100,
+	TxDescUnavail	= 0x0080,
+	RxFIFOOver	= 0x0040,
+	LinkChg		= 0x0020,
+	RxOverflow	= 0x0010,
+	TxErr		= 0x0008,
+	TxOK		= 0x0004,
+	RxErr		= 0x0002,
+	RxOK		= 0x0001,
+
+	/* RxStatusDesc */
+	RxBOVF	= (1 << 24),
+	RxFOVF	= (1 << 23),
+	RxRWT	= (1 << 22),
+	RxRES	= (1 << 21),
+	RxRUNT	= (1 << 20),
+	RxCRC	= (1 << 19),
+
+	/* ChipCmdBits */
+	StopReq		= 0x80,
+	CmdReset	= 0x10,
+	CmdRxEnb	= 0x08,
+	CmdTxEnb	= 0x04,
+	RxBufEmpty	= 0x01,
+
+	/* TXPoll register p.5 */
+	HPQ		= 0x80,		/* Poll cmd on the high prio queue */
+	NPQ		= 0x40,		/* Poll cmd on the low prio queue */
+	FSWInt		= 0x01,		/* Forced software interrupt */
+
+	/* Cfg9346Bits */
+	Cfg9346_Lock	= 0x00,
+	Cfg9346_Unlock	= 0xc0,
+
+	/* rx_mode_bits */
+	AcceptErr	= 0x20,
+	AcceptRunt	= 0x10,
+	AcceptBroadcast	= 0x08,
+	AcceptMulticast	= 0x04,
+	AcceptMyPhys	= 0x02,
+	AcceptAllPhys	= 0x01,
+#define RX_CONFIG_ACCEPT_MASK		0x3f
+
+	/* TxConfigBits */
+	TxInterFrameGapShift = 24,
+	TxDMAShift = 8,	/* DMA burst value (0-7) is shift this many bits */
+
+	/* Config1 register p.24 */
+	LEDS1		= (1 << 7),
+	LEDS0		= (1 << 6),
+	Speed_down	= (1 << 4),
+	MEMMAP		= (1 << 3),
+	IOMAP		= (1 << 2),
+	VPD		= (1 << 1),
+	PMEnable	= (1 << 0),	/* Power Management Enable */
+
+	/* Config2 register p. 25 */
+	ClkReqEn	= (1 << 7),	/* Clock Request Enable */
+	MSIEnable	= (1 << 5),	/* 8169 only. Reserved in the 8168. */
+	PCI_Clock_66MHz = 0x01,
+	PCI_Clock_33MHz = 0x00,
+
+	/* Config3 register p.25 */
+	MagicPacket	= (1 << 5),	/* Wake up when receives a Magic Packet */
+	LinkUp		= (1 << 4),	/* Wake up when the cable connection is re-established */
+	Jumbo_En0	= (1 << 2),	/* 8168 only. Reserved in the 8168b */
+	Rdy_to_L23	= (1 << 1),	/* L23 Enable */
+	Beacon_en	= (1 << 0),	/* 8168 only. Reserved in the 8168b */
+
+	/* Config4 register */
+	Jumbo_En1	= (1 << 1),	/* 8168 only. Reserved in the 8168b */
+
+	/* Config5 register p.27 */
+	BWF		= (1 << 6),	/* Accept Broadcast wakeup frame */
+	MWF		= (1 << 5),	/* Accept Multicast wakeup frame */
+	UWF		= (1 << 4),	/* Accept Unicast wakeup frame */
+	Spi_en		= (1 << 3),
+	LanWake		= (1 << 1),	/* LanWake enable/disable */
+	PMEStatus	= (1 << 0),	/* PME status can be reset by PCI RST# */
+	ASPM_en		= (1 << 0),	/* ASPM enable */
+
+	/* CPlusCmd p.31 */
+	EnableBist	= (1 << 15),	// 8168 8101
+	Mac_dbgo_oe	= (1 << 14),	// 8168 8101
+	Normal_mode	= (1 << 13),	// unused
+	Force_half_dup	= (1 << 12),	// 8168 8101
+	Force_rxflow_en	= (1 << 11),	// 8168 8101
+	Force_txflow_en	= (1 << 10),	// 8168 8101
+	Cxpl_dbg_sel	= (1 << 9),	// 8168 8101
+	ASF		= (1 << 8),	// 8168 8101
+	PktCntrDisable	= (1 << 7),	// 8168 8101
+	Mac_dbgo_sel	= 0x001c,	// 8168
+	RxVlan		= (1 << 6),
+	RxChkSum	= (1 << 5),
+	PCIDAC		= (1 << 4),
+	PCIMulRW	= (1 << 3),
+#define INTT_MASK	GENMASK(1, 0)
+	INTT_0		= 0x0000,	// 8168
+	INTT_1		= 0x0001,	// 8168
+	INTT_2		= 0x0002,	// 8168
+	INTT_3		= 0x0003,	// 8168
+
+	/* rtl8169_PHYstatus */
+	TBI_Enable	= 0x80,
+	TxFlowCtrl	= 0x40,
+	RxFlowCtrl	= 0x20,
+	_1000bpsF	= 0x10,
+	_100bps		= 0x08,
+	_10bps		= 0x04,
+	LinkStatus	= 0x02,
+	FullDup		= 0x01,
+
+	/* _TBICSRBit */
+	TBILinkOK	= 0x02000000,
+
+	/* ResetCounterCommand */
+	CounterReset	= 0x1,
+
+	/* DumpCounterCommand */
+	CounterDump	= 0x8,
+
+	/* magic enable v2 */
+	MagicPacket_v2	= (1 << 16),	/* Wake up when receives a Magic Packet */
+};
+
+enum rtl_desc_bit {
+	/* First doubleword. */
+	DescOwn		= (1 << 31), /* Descriptor is owned by NIC */
+	RingEnd		= (1 << 30), /* End of descriptor ring */
+	FirstFrag	= (1 << 29), /* First segment of a packet */
+	LastFrag	= (1 << 28), /* Final segment of a packet */
+};
+
+/* Generic case. */
+enum rtl_tx_desc_bit {
+	/* First doubleword. */
+	TD_LSO		= (1 << 27),		/* Large Send Offload */
+#define TD_MSS_MAX			0x07ffu	/* MSS value */
+
+	/* Second doubleword. */
+	TxVlanTag	= (1 << 17),		/* Add VLAN tag */
+};
+
+/* 8169, 8168b and 810x except 8102e. */
+enum rtl_tx_desc_bit_0 {
+	/* First doubleword. */
+#define TD0_MSS_SHIFT			16	/* MSS position (11 bits) */
+	TD0_TCP_CS	= (1 << 16),		/* Calculate TCP/IP checksum */
+	TD0_UDP_CS	= (1 << 17),		/* Calculate UDP/IP checksum */
+	TD0_IP_CS	= (1 << 18),		/* Calculate IP checksum */
+};
+
+/* 8102e, 8168c and beyond. */
+enum rtl_tx_desc_bit_1 {
+	/* First doubleword. */
+	TD1_GTSENV4	= (1 << 26),		/* Giant Send for IPv4 */
+	TD1_GTSENV6	= (1 << 25),		/* Giant Send for IPv6 */
+#define GTTCPHO_SHIFT			18
+#define GTTCPHO_MAX			0x7fU
+
+	/* Second doubleword. */
+#define TCPHO_SHIFT			18
+#define TCPHO_MAX			0x3ffU
+#define TD1_MSS_SHIFT			18	/* MSS position (11 bits) */
+	TD1_IPv6_CS	= (1 << 28),		/* Calculate IPv6 checksum */
+	TD1_IPv4_CS	= (1 << 29),		/* Calculate IPv4 checksum */
+	TD1_TCP_CS	= (1 << 30),		/* Calculate TCP/IP checksum */
+	TD1_UDP_CS	= (1 << 31),		/* Calculate UDP/IP checksum */
+};
+
+enum rtl_rx_desc_bit {
+	/* Rx private */
+	PID1		= (1 << 18), /* Protocol ID bit 1/2 */
+	PID0		= (1 << 17), /* Protocol ID bit 0/2 */
+
+#define RxProtoUDP	(PID1)
+#define RxProtoTCP	(PID0)
+#define RxProtoIP	(PID1 | PID0)
+#define RxProtoMask	RxProtoIP
+
+	IPFail		= (1 << 16), /* IP checksum failed */
+	UDPFail		= (1 << 15), /* UDP/IP checksum failed */
+	TCPFail		= (1 << 14), /* TCP/IP checksum failed */
+	RxVlanTag	= (1 << 16), /* VLAN tag available */
+};
+
+#define RsvdMask	0x3fffc000
+#define CPCMD_QUIRK_MASK	(Normal_mode | RxVlan | RxChkSum | INTT_MASK)
+
+struct TxDesc {
+	__le32 opts1;
+	__le32 opts2;
+	__le64 addr;
+};
+
+struct RxDesc {
+	__le32 opts1;
+	__le32 opts2;
+	__le64 addr;
+};
+
+struct ring_info {
+	struct sk_buff	*skb;
+	u32		len;
+	u8		__pad[sizeof(void *) - sizeof(u32)];
+};
+
+struct rtl8169_counters {
+	__le64	tx_packets;
+	__le64	rx_packets;
+	__le64	tx_errors;
+	__le32	rx_errors;
+	__le16	rx_missed;
+	__le16	align_errors;
+	__le32	tx_one_collision;
+	__le32	tx_multi_collision;
+	__le64	rx_unicast;
+	__le64	rx_broadcast;
+	__le32	rx_multicast;
+	__le16	tx_aborted;
+	__le16	tx_underun;
+};
+
+struct rtl8169_tc_offsets {
+	bool	inited;
+	__le64	tx_errors;
+	__le32	tx_multi_collision;
+	__le16	tx_aborted;
+};
+
+enum rtl_flag {
+	RTL_FLAG_TASK_ENABLED = 0,
+	RTL_FLAG_TASK_SLOW_PENDING,
+	RTL_FLAG_TASK_RESET_PENDING,
+	RTL_FLAG_MAX
+};
+
+struct rtl8169_stats {
+	u64			packets;
+	u64			bytes;
+	struct u64_stats_sync	syncp;
+};
+
+struct rtl8169_private {
+	void __iomem *mmio_addr;	/* memory map physical address */
+	struct pci_dev *pci_dev;
+	struct net_device *dev;
+	struct napi_struct napi;
+	u32 msg_enable;
+	u16 mac_version;
+	u32 cur_rx; /* Index into the Rx descriptor buffer of next Rx pkt. */
+	u32 cur_tx; /* Index into the Tx descriptor buffer of next Rx pkt. */
+	u32 dirty_tx;
+	struct rtl8169_stats rx_stats;
+	struct rtl8169_stats tx_stats;
+	struct TxDesc *TxDescArray;	/* 256-aligned Tx descriptor ring */
+	struct RxDesc *RxDescArray;	/* 256-aligned Rx descriptor ring */
+	dma_addr_t TxPhyAddr;
+	dma_addr_t RxPhyAddr;
+	void *Rx_databuff[NUM_RX_DESC];	/* Rx data buffers */
+	struct ring_info tx_skb[NUM_TX_DESC];	/* Tx data buffers */
+	u16 cp_cmd;
+
+	u16 event_slow;
+	const struct rtl_coalesce_info *coalesce_info;
+	struct clk *clk;
+
+	struct mdio_ops {
+		void (*write)(struct rtl8169_private *, int, int);
+		int (*read)(struct rtl8169_private *, int);
+	} mdio_ops;
+
+	struct jumbo_ops {
+		void (*enable)(struct rtl8169_private *);
+		void (*disable)(struct rtl8169_private *);
+	} jumbo_ops;
+
+	void (*hw_start)(struct rtl8169_private *tp);
+	bool (*tso_csum)(struct rtl8169_private *, struct sk_buff *, u32 *);
+
+	struct {
+		DECLARE_BITMAP(flags, RTL_FLAG_MAX);
+		struct mutex mutex;
+		struct work_struct work;
+	} wk;
+
+	unsigned supports_gmii:1;
+	struct mii_bus *mii_bus;
+	dma_addr_t counters_phys_addr;
+	struct rtl8169_counters *counters;
+	struct rtl8169_tc_offsets tc_offset;
+	u32 saved_wolopts;
+
+	struct rtl_fw {
+		const struct firmware *fw;
+
+#define RTL_VER_SIZE		32
+
+		char version[RTL_VER_SIZE];
+
+		struct rtl_fw_phy_action {
+			__le32 *code;
+			size_t size;
+		} phy_action;
+	} *rtl_fw;
+#define RTL_FIRMWARE_UNKNOWN	ERR_PTR(-EAGAIN)
+
+	u32 ocp_base;
+};
+
+MODULE_AUTHOR("Realtek and the Linux r8169 crew <netdev@vger.kernel.org>");
+MODULE_DESCRIPTION("RealTek RTL-8169 Gigabit Ethernet driver");
+module_param(use_dac, int, 0);
+MODULE_PARM_DESC(use_dac, "Enable PCI DAC. Unsafe on 32 bit PCI slot.");
+module_param_named(debug, debug.msg_enable, int, 0);
+MODULE_PARM_DESC(debug, "Debug verbosity level (0=none, ..., 16=all)");
+MODULE_SOFTDEP("pre: realtek");
+MODULE_LICENSE("GPL");
+MODULE_FIRMWARE(FIRMWARE_8168D_1);
+MODULE_FIRMWARE(FIRMWARE_8168D_2);
+MODULE_FIRMWARE(FIRMWARE_8168E_1);
+MODULE_FIRMWARE(FIRMWARE_8168E_2);
+MODULE_FIRMWARE(FIRMWARE_8168E_3);
+MODULE_FIRMWARE(FIRMWARE_8105E_1);
+MODULE_FIRMWARE(FIRMWARE_8168F_1);
+MODULE_FIRMWARE(FIRMWARE_8168F_2);
+MODULE_FIRMWARE(FIRMWARE_8402_1);
+MODULE_FIRMWARE(FIRMWARE_8411_1);
+MODULE_FIRMWARE(FIRMWARE_8411_2);
+MODULE_FIRMWARE(FIRMWARE_8106E_1);
+MODULE_FIRMWARE(FIRMWARE_8106E_2);
+MODULE_FIRMWARE(FIRMWARE_8168G_2);
+MODULE_FIRMWARE(FIRMWARE_8168G_3);
+MODULE_FIRMWARE(FIRMWARE_8168H_1);
+MODULE_FIRMWARE(FIRMWARE_8168H_2);
+MODULE_FIRMWARE(FIRMWARE_8107E_1);
+MODULE_FIRMWARE(FIRMWARE_8107E_2);
+
+static inline struct device *tp_to_dev(struct rtl8169_private *tp)
+{
+	return &tp->pci_dev->dev;
+}
+
+static void rtl_lock_work(struct rtl8169_private *tp)
+{
+	mutex_lock(&tp->wk.mutex);
+}
+
+static void rtl_unlock_work(struct rtl8169_private *tp)
+{
+	mutex_unlock(&tp->wk.mutex);
+}
+
+static void rtl_tx_performance_tweak(struct rtl8169_private *tp, u16 force)
+{
+	pcie_capability_clear_and_set_word(tp->pci_dev, PCI_EXP_DEVCTL,
+					   PCI_EXP_DEVCTL_READRQ, force);
+}
+
+struct rtl_cond {
+	bool (*check)(struct rtl8169_private *);
+	const char *msg;
+};
+
+static void rtl_udelay(unsigned int d)
+{
+	udelay(d);
+}
+
+static bool rtl_loop_wait(struct rtl8169_private *tp, const struct rtl_cond *c,
+			  void (*delay)(unsigned int), unsigned int d, int n,
+			  bool high)
+{
+	int i;
+
+	for (i = 0; i < n; i++) {
+		delay(d);
+		if (c->check(tp) == high)
+			return true;
+	}
+	netif_err(tp, drv, tp->dev, "%s == %d (loop: %d, delay: %d).\n",
+		  c->msg, !high, n, d);
+	return false;
+}
+
+static bool rtl_udelay_loop_wait_high(struct rtl8169_private *tp,
+				      const struct rtl_cond *c,
+				      unsigned int d, int n)
+{
+	return rtl_loop_wait(tp, c, rtl_udelay, d, n, true);
+}
+
+static bool rtl_udelay_loop_wait_low(struct rtl8169_private *tp,
+				     const struct rtl_cond *c,
+				     unsigned int d, int n)
+{
+	return rtl_loop_wait(tp, c, rtl_udelay, d, n, false);
+}
+
+static bool rtl_msleep_loop_wait_high(struct rtl8169_private *tp,
+				      const struct rtl_cond *c,
+				      unsigned int d, int n)
+{
+	return rtl_loop_wait(tp, c, msleep, d, n, true);
+}
+
+static bool rtl_msleep_loop_wait_low(struct rtl8169_private *tp,
+				     const struct rtl_cond *c,
+				     unsigned int d, int n)
+{
+	return rtl_loop_wait(tp, c, msleep, d, n, false);
+}
+
+#define DECLARE_RTL_COND(name)				\
+static bool name ## _check(struct rtl8169_private *);	\
+							\
+static const struct rtl_cond name = {			\
+	.check	= name ## _check,			\
+	.msg	= #name					\
+};							\
+							\
+static bool name ## _check(struct rtl8169_private *tp)
+
+static bool rtl_ocp_reg_failure(struct rtl8169_private *tp, u32 reg)
+{
+	if (reg & 0xffff0001) {
+		netif_err(tp, drv, tp->dev, "Invalid ocp reg %x!\n", reg);
+		return true;
+	}
+	return false;
+}
+
+DECLARE_RTL_COND(rtl_ocp_gphy_cond)
+{
+	return RTL_R32(tp, GPHY_OCP) & OCPAR_FLAG;
+}
+
+static void r8168_phy_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
+{
+	if (rtl_ocp_reg_failure(tp, reg))
+		return;
+
+	RTL_W32(tp, GPHY_OCP, OCPAR_FLAG | (reg << 15) | data);
+
+	rtl_udelay_loop_wait_low(tp, &rtl_ocp_gphy_cond, 25, 10);
+}
+
+static u16 r8168_phy_ocp_read(struct rtl8169_private *tp, u32 reg)
+{
+	if (rtl_ocp_reg_failure(tp, reg))
+		return 0;
+
+	RTL_W32(tp, GPHY_OCP, reg << 15);
+
+	return rtl_udelay_loop_wait_high(tp, &rtl_ocp_gphy_cond, 25, 10) ?
+		(RTL_R32(tp, GPHY_OCP) & 0xffff) : ~0;
+}
+
+static void r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
+{
+	if (rtl_ocp_reg_failure(tp, reg))
+		return;
+
+	RTL_W32(tp, OCPDR, OCPAR_FLAG | (reg << 15) | data);
+}
+
+static u16 r8168_mac_ocp_read(struct rtl8169_private *tp, u32 reg)
+{
+	if (rtl_ocp_reg_failure(tp, reg))
+		return 0;
+
+	RTL_W32(tp, OCPDR, reg << 15);
+
+	return RTL_R32(tp, OCPDR);
+}
+
+#define OCP_STD_PHY_BASE	0xa400
+
+static void r8168g_mdio_write(struct rtl8169_private *tp, int reg, int value)
+{
+	if (reg == 0x1f) {
+		tp->ocp_base = value ? value << 4 : OCP_STD_PHY_BASE;
+		return;
+	}
+
+	if (tp->ocp_base != OCP_STD_PHY_BASE)
+		reg -= 0x10;
+
+	r8168_phy_ocp_write(tp, tp->ocp_base + reg * 2, value);
+}
+
+static int r8168g_mdio_read(struct rtl8169_private *tp, int reg)
+{
+	if (tp->ocp_base != OCP_STD_PHY_BASE)
+		reg -= 0x10;
+
+	return r8168_phy_ocp_read(tp, tp->ocp_base + reg * 2);
+}
+
+static void mac_mcu_write(struct rtl8169_private *tp, int reg, int value)
+{
+	if (reg == 0x1f) {
+		tp->ocp_base = value << 4;
+		return;
+	}
+
+	r8168_mac_ocp_write(tp, tp->ocp_base + reg, value);
+}
+
+static int mac_mcu_read(struct rtl8169_private *tp, int reg)
+{
+	return r8168_mac_ocp_read(tp, tp->ocp_base + reg);
+}
+
+DECLARE_RTL_COND(rtl_phyar_cond)
+{
+	return RTL_R32(tp, PHYAR) & 0x80000000;
+}
+
+static void r8169_mdio_write(struct rtl8169_private *tp, int reg, int value)
+{
+	RTL_W32(tp, PHYAR, 0x80000000 | (reg & 0x1f) << 16 | (value & 0xffff));
+
+	rtl_udelay_loop_wait_low(tp, &rtl_phyar_cond, 25, 20);
+	/*
+	 * According to hardware specs a 20us delay is required after write
+	 * complete indication, but before sending next command.
+	 */
+	udelay(20);
+}
+
+static int r8169_mdio_read(struct rtl8169_private *tp, int reg)
+{
+	int value;
+
+	RTL_W32(tp, PHYAR, 0x0 | (reg & 0x1f) << 16);
+
+	value = rtl_udelay_loop_wait_high(tp, &rtl_phyar_cond, 25, 20) ?
+		RTL_R32(tp, PHYAR) & 0xffff : ~0;
+
+	/*
+	 * According to hardware specs a 20us delay is required after read
+	 * complete indication, but before sending next command.
+	 */
+	udelay(20);
+
+	return value;
+}
+
+DECLARE_RTL_COND(rtl_ocpar_cond)
+{
+	return RTL_R32(tp, OCPAR) & OCPAR_FLAG;
+}
+
+static void r8168dp_1_mdio_access(struct rtl8169_private *tp, int reg, u32 data)
+{
+	RTL_W32(tp, OCPDR, data | ((reg & OCPDR_REG_MASK) << OCPDR_GPHY_REG_SHIFT));
+	RTL_W32(tp, OCPAR, OCPAR_GPHY_WRITE_CMD);
+	RTL_W32(tp, EPHY_RXER_NUM, 0);
+
+	rtl_udelay_loop_wait_low(tp, &rtl_ocpar_cond, 1000, 100);
+}
+
+static void r8168dp_1_mdio_write(struct rtl8169_private *tp, int reg, int value)
+{
+	r8168dp_1_mdio_access(tp, reg,
+			      OCPDR_WRITE_CMD | (value & OCPDR_DATA_MASK));
+}
+
+static int r8168dp_1_mdio_read(struct rtl8169_private *tp, int reg)
+{
+	r8168dp_1_mdio_access(tp, reg, OCPDR_READ_CMD);
+
+	mdelay(1);
+	RTL_W32(tp, OCPAR, OCPAR_GPHY_READ_CMD);
+	RTL_W32(tp, EPHY_RXER_NUM, 0);
+
+	return rtl_udelay_loop_wait_high(tp, &rtl_ocpar_cond, 1000, 100) ?
+		RTL_R32(tp, OCPDR) & OCPDR_DATA_MASK : ~0;
+}
+
+#define R8168DP_1_MDIO_ACCESS_BIT	0x00020000
+
+static void r8168dp_2_mdio_start(struct rtl8169_private *tp)
+{
+	RTL_W32(tp, 0xd0, RTL_R32(tp, 0xd0) & ~R8168DP_1_MDIO_ACCESS_BIT);
+}
+
+static void r8168dp_2_mdio_stop(struct rtl8169_private *tp)
+{
+	RTL_W32(tp, 0xd0, RTL_R32(tp, 0xd0) | R8168DP_1_MDIO_ACCESS_BIT);
+}
+
+static void r8168dp_2_mdio_write(struct rtl8169_private *tp, int reg, int value)
+{
+	r8168dp_2_mdio_start(tp);
+
+	r8169_mdio_write(tp, reg, value);
+
+	r8168dp_2_mdio_stop(tp);
+}
+
+static int r8168dp_2_mdio_read(struct rtl8169_private *tp, int reg)
+{
+	int value;
+
+	/* Work around issue with chip reporting wrong PHY ID */
+	if (reg == MII_PHYSID2)
+		return 0xc912;
+
+	r8168dp_2_mdio_start(tp);
+
+	value = r8169_mdio_read(tp, reg);
+
+	r8168dp_2_mdio_stop(tp);
+
+	return value;
+}
+
+static void rtl_writephy(struct rtl8169_private *tp, int location, u32 val)
+{
+	tp->mdio_ops.write(tp, location, val);
+}
+
+static int rtl_readphy(struct rtl8169_private *tp, int location)
+{
+	return tp->mdio_ops.read(tp, location);
+}
+
+static void rtl_patchphy(struct rtl8169_private *tp, int reg_addr, int value)
+{
+	rtl_writephy(tp, reg_addr, rtl_readphy(tp, reg_addr) | value);
+}
+
+static void rtl_w0w1_phy(struct rtl8169_private *tp, int reg_addr, int p, int m)
+{
+	int val;
+
+	val = rtl_readphy(tp, reg_addr);
+	rtl_writephy(tp, reg_addr, (val & ~m) | p);
+}
+
+DECLARE_RTL_COND(rtl_ephyar_cond)
+{
+	return RTL_R32(tp, EPHYAR) & EPHYAR_FLAG;
+}
+
+static void rtl_ephy_write(struct rtl8169_private *tp, int reg_addr, int value)
+{
+	RTL_W32(tp, EPHYAR, EPHYAR_WRITE_CMD | (value & EPHYAR_DATA_MASK) |
+		(reg_addr & EPHYAR_REG_MASK) << EPHYAR_REG_SHIFT);
+
+	rtl_udelay_loop_wait_low(tp, &rtl_ephyar_cond, 10, 100);
+
+	udelay(10);
+}
+
+static u16 rtl_ephy_read(struct rtl8169_private *tp, int reg_addr)
+{
+	RTL_W32(tp, EPHYAR, (reg_addr & EPHYAR_REG_MASK) << EPHYAR_REG_SHIFT);
+
+	return rtl_udelay_loop_wait_high(tp, &rtl_ephyar_cond, 10, 100) ?
+		RTL_R32(tp, EPHYAR) & EPHYAR_DATA_MASK : ~0;
+}
+
+DECLARE_RTL_COND(rtl_eriar_cond)
+{
+	return RTL_R32(tp, ERIAR) & ERIAR_FLAG;
+}
+
+static void rtl_eri_write(struct rtl8169_private *tp, int addr, u32 mask,
+			  u32 val, int type)
+{
+	BUG_ON((addr & 3) || (mask == 0));
+	RTL_W32(tp, ERIDR, val);
+	RTL_W32(tp, ERIAR, ERIAR_WRITE_CMD | type | mask | addr);
+
+	rtl_udelay_loop_wait_low(tp, &rtl_eriar_cond, 100, 100);
+}
+
+static u32 rtl_eri_read(struct rtl8169_private *tp, int addr, int type)
+{
+	RTL_W32(tp, ERIAR, ERIAR_READ_CMD | type | ERIAR_MASK_1111 | addr);
+
+	return rtl_udelay_loop_wait_high(tp, &rtl_eriar_cond, 100, 100) ?
+		RTL_R32(tp, ERIDR) : ~0;
+}
+
+static void rtl_w0w1_eri(struct rtl8169_private *tp, int addr, u32 mask, u32 p,
+			 u32 m, int type)
+{
+	u32 val;
+
+	val = rtl_eri_read(tp, addr, type);
+	rtl_eri_write(tp, addr, mask, (val & ~m) | p, type);
+}
+
+static u32 r8168dp_ocp_read(struct rtl8169_private *tp, u8 mask, u16 reg)
+{
+	RTL_W32(tp, OCPAR, ((u32)mask & 0x0f) << 12 | (reg & 0x0fff));
+	return rtl_udelay_loop_wait_high(tp, &rtl_ocpar_cond, 100, 20) ?
+		RTL_R32(tp, OCPDR) : ~0;
+}
+
+static u32 r8168ep_ocp_read(struct rtl8169_private *tp, u8 mask, u16 reg)
+{
+	return rtl_eri_read(tp, reg, ERIAR_OOB);
+}
+
+static u32 ocp_read(struct rtl8169_private *tp, u8 mask, u16 reg)
+{
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_27:
+	case RTL_GIGA_MAC_VER_28:
+	case RTL_GIGA_MAC_VER_31:
+		return r8168dp_ocp_read(tp, mask, reg);
+	case RTL_GIGA_MAC_VER_49:
+	case RTL_GIGA_MAC_VER_50:
+	case RTL_GIGA_MAC_VER_51:
+		return r8168ep_ocp_read(tp, mask, reg);
+	default:
+		BUG();
+		return ~0;
+	}
+}
+
+static void r8168dp_ocp_write(struct rtl8169_private *tp, u8 mask, u16 reg,
+			      u32 data)
+{
+	RTL_W32(tp, OCPDR, data);
+	RTL_W32(tp, OCPAR, OCPAR_FLAG | ((u32)mask & 0x0f) << 12 | (reg & 0x0fff));
+	rtl_udelay_loop_wait_low(tp, &rtl_ocpar_cond, 100, 20);
+}
+
+static void r8168ep_ocp_write(struct rtl8169_private *tp, u8 mask, u16 reg,
+			      u32 data)
+{
+	rtl_eri_write(tp, reg, ((u32)mask & 0x0f) << ERIAR_MASK_SHIFT,
+		      data, ERIAR_OOB);
+}
+
+static void ocp_write(struct rtl8169_private *tp, u8 mask, u16 reg, u32 data)
+{
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_27:
+	case RTL_GIGA_MAC_VER_28:
+	case RTL_GIGA_MAC_VER_31:
+		r8168dp_ocp_write(tp, mask, reg, data);
+		break;
+	case RTL_GIGA_MAC_VER_49:
+	case RTL_GIGA_MAC_VER_50:
+	case RTL_GIGA_MAC_VER_51:
+		r8168ep_ocp_write(tp, mask, reg, data);
+		break;
+	default:
+		BUG();
+		break;
+	}
+}
+
+static void rtl8168_oob_notify(struct rtl8169_private *tp, u8 cmd)
+{
+	rtl_eri_write(tp, 0xe8, ERIAR_MASK_0001, cmd, ERIAR_EXGMAC);
+
+	ocp_write(tp, 0x1, 0x30, 0x00000001);
+}
+
+#define OOB_CMD_RESET		0x00
+#define OOB_CMD_DRIVER_START	0x05
+#define OOB_CMD_DRIVER_STOP	0x06
+
+static u16 rtl8168_get_ocp_reg(struct rtl8169_private *tp)
+{
+	return (tp->mac_version == RTL_GIGA_MAC_VER_31) ? 0xb8 : 0x10;
+}
+
+DECLARE_RTL_COND(rtl_ocp_read_cond)
+{
+	u16 reg;
+
+	reg = rtl8168_get_ocp_reg(tp);
+
+	return ocp_read(tp, 0x0f, reg) & 0x00000800;
+}
+
+DECLARE_RTL_COND(rtl_ep_ocp_read_cond)
+{
+	return ocp_read(tp, 0x0f, 0x124) & 0x00000001;
+}
+
+DECLARE_RTL_COND(rtl_ocp_tx_cond)
+{
+	return RTL_R8(tp, IBISR0) & 0x20;
+}
+
+static void rtl8168ep_stop_cmac(struct rtl8169_private *tp)
+{
+	RTL_W8(tp, IBCR2, RTL_R8(tp, IBCR2) & ~0x01);
+	rtl_msleep_loop_wait_high(tp, &rtl_ocp_tx_cond, 50, 2000);
+	RTL_W8(tp, IBISR0, RTL_R8(tp, IBISR0) | 0x20);
+	RTL_W8(tp, IBCR0, RTL_R8(tp, IBCR0) & ~0x01);
+}
+
+static void rtl8168dp_driver_start(struct rtl8169_private *tp)
+{
+	rtl8168_oob_notify(tp, OOB_CMD_DRIVER_START);
+	rtl_msleep_loop_wait_high(tp, &rtl_ocp_read_cond, 10, 10);
+}
+
+static void rtl8168ep_driver_start(struct rtl8169_private *tp)
+{
+	ocp_write(tp, 0x01, 0x180, OOB_CMD_DRIVER_START);
+	ocp_write(tp, 0x01, 0x30, ocp_read(tp, 0x01, 0x30) | 0x01);
+	rtl_msleep_loop_wait_high(tp, &rtl_ep_ocp_read_cond, 10, 10);
+}
+
+static void rtl8168_driver_start(struct rtl8169_private *tp)
+{
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_27:
+	case RTL_GIGA_MAC_VER_28:
+	case RTL_GIGA_MAC_VER_31:
+		rtl8168dp_driver_start(tp);
+		break;
+	case RTL_GIGA_MAC_VER_49:
+	case RTL_GIGA_MAC_VER_50:
+	case RTL_GIGA_MAC_VER_51:
+		rtl8168ep_driver_start(tp);
+		break;
+	default:
+		BUG();
+		break;
+	}
+}
+
+static void rtl8168dp_driver_stop(struct rtl8169_private *tp)
+{
+	rtl8168_oob_notify(tp, OOB_CMD_DRIVER_STOP);
+	rtl_msleep_loop_wait_low(tp, &rtl_ocp_read_cond, 10, 10);
+}
+
+static void rtl8168ep_driver_stop(struct rtl8169_private *tp)
+{
+	rtl8168ep_stop_cmac(tp);
+	ocp_write(tp, 0x01, 0x180, OOB_CMD_DRIVER_STOP);
+	ocp_write(tp, 0x01, 0x30, ocp_read(tp, 0x01, 0x30) | 0x01);
+	rtl_msleep_loop_wait_low(tp, &rtl_ep_ocp_read_cond, 10, 10);
+}
+
+static void rtl8168_driver_stop(struct rtl8169_private *tp)
+{
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_27:
+	case RTL_GIGA_MAC_VER_28:
+	case RTL_GIGA_MAC_VER_31:
+		rtl8168dp_driver_stop(tp);
+		break;
+	case RTL_GIGA_MAC_VER_49:
+	case RTL_GIGA_MAC_VER_50:
+	case RTL_GIGA_MAC_VER_51:
+		rtl8168ep_driver_stop(tp);
+		break;
+	default:
+		BUG();
+		break;
+	}
+}
+
+static bool r8168dp_check_dash(struct rtl8169_private *tp)
+{
+	u16 reg = rtl8168_get_ocp_reg(tp);
+
+	return !!(ocp_read(tp, 0x0f, reg) & 0x00008000);
+}
+
+static bool r8168ep_check_dash(struct rtl8169_private *tp)
+{
+	return !!(ocp_read(tp, 0x0f, 0x128) & 0x00000001);
+}
+
+static bool r8168_check_dash(struct rtl8169_private *tp)
+{
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_27:
+	case RTL_GIGA_MAC_VER_28:
+	case RTL_GIGA_MAC_VER_31:
+		return r8168dp_check_dash(tp);
+	case RTL_GIGA_MAC_VER_49:
+	case RTL_GIGA_MAC_VER_50:
+	case RTL_GIGA_MAC_VER_51:
+		return r8168ep_check_dash(tp);
+	default:
+		return false;
+	}
+}
+
+struct exgmac_reg {
+	u16 addr;
+	u16 mask;
+	u32 val;
+};
+
+static void rtl_write_exgmac_batch(struct rtl8169_private *tp,
+				   const struct exgmac_reg *r, int len)
+{
+	while (len-- > 0) {
+		rtl_eri_write(tp, r->addr, r->mask, r->val, ERIAR_EXGMAC);
+		r++;
+	}
+}
+
+DECLARE_RTL_COND(rtl_efusear_cond)
+{
+	return RTL_R32(tp, EFUSEAR) & EFUSEAR_FLAG;
+}
+
+static u8 rtl8168d_efuse_read(struct rtl8169_private *tp, int reg_addr)
+{
+	RTL_W32(tp, EFUSEAR, (reg_addr & EFUSEAR_REG_MASK) << EFUSEAR_REG_SHIFT);
+
+	return rtl_udelay_loop_wait_high(tp, &rtl_efusear_cond, 100, 300) ?
+		RTL_R32(tp, EFUSEAR) & EFUSEAR_DATA_MASK : ~0;
+}
+
+static u16 rtl_get_events(struct rtl8169_private *tp)
+{
+	return RTL_R16(tp, IntrStatus);
+}
+
+static void rtl_ack_events(struct rtl8169_private *tp, u16 bits)
+{
+	RTL_W16(tp, IntrStatus, bits);
+	mmiowb();
+}
+
+static void rtl_irq_disable(struct rtl8169_private *tp)
+{
+	RTL_W16(tp, IntrMask, 0);
+	mmiowb();
+}
+
+static void rtl_irq_enable(struct rtl8169_private *tp, u16 bits)
+{
+	RTL_W16(tp, IntrMask, bits);
+}
+
+#define RTL_EVENT_NAPI_RX	(RxOK | RxErr)
+#define RTL_EVENT_NAPI_TX	(TxOK | TxErr)
+#define RTL_EVENT_NAPI		(RTL_EVENT_NAPI_RX | RTL_EVENT_NAPI_TX)
+
+static void rtl_irq_enable_all(struct rtl8169_private *tp)
+{
+	rtl_irq_enable(tp, RTL_EVENT_NAPI | tp->event_slow);
+}
+
+static void rtl8169_irq_mask_and_ack(struct rtl8169_private *tp)
+{
+	rtl_irq_disable(tp);
+	rtl_ack_events(tp, RTL_EVENT_NAPI | tp->event_slow);
+	RTL_R8(tp, ChipCmd);
+}
+
+static void rtl_link_chg_patch(struct rtl8169_private *tp)
+{
+	struct net_device *dev = tp->dev;
+	struct phy_device *phydev = dev->phydev;
+
+	if (!netif_running(dev))
+		return;
+
+	if (tp->mac_version == RTL_GIGA_MAC_VER_34 ||
+	    tp->mac_version == RTL_GIGA_MAC_VER_38) {
+		if (phydev->speed == SPEED_1000) {
+			rtl_eri_write(tp, 0x1bc, ERIAR_MASK_1111, 0x00000011,
+				      ERIAR_EXGMAC);
+			rtl_eri_write(tp, 0x1dc, ERIAR_MASK_1111, 0x00000005,
+				      ERIAR_EXGMAC);
+		} else if (phydev->speed == SPEED_100) {
+			rtl_eri_write(tp, 0x1bc, ERIAR_MASK_1111, 0x0000001f,
+				      ERIAR_EXGMAC);
+			rtl_eri_write(tp, 0x1dc, ERIAR_MASK_1111, 0x00000005,
+				      ERIAR_EXGMAC);
+		} else {
+			rtl_eri_write(tp, 0x1bc, ERIAR_MASK_1111, 0x0000001f,
+				      ERIAR_EXGMAC);
+			rtl_eri_write(tp, 0x1dc, ERIAR_MASK_1111, 0x0000003f,
+				      ERIAR_EXGMAC);
+		}
+		/* Reset packet filter */
+		rtl_w0w1_eri(tp, 0xdc, ERIAR_MASK_0001, 0x00, 0x01,
+			     ERIAR_EXGMAC);
+		rtl_w0w1_eri(tp, 0xdc, ERIAR_MASK_0001, 0x01, 0x00,
+			     ERIAR_EXGMAC);
+	} else if (tp->mac_version == RTL_GIGA_MAC_VER_35 ||
+		   tp->mac_version == RTL_GIGA_MAC_VER_36) {
+		if (phydev->speed == SPEED_1000) {
+			rtl_eri_write(tp, 0x1bc, ERIAR_MASK_1111, 0x00000011,
+				      ERIAR_EXGMAC);
+			rtl_eri_write(tp, 0x1dc, ERIAR_MASK_1111, 0x00000005,
+				      ERIAR_EXGMAC);
+		} else {
+			rtl_eri_write(tp, 0x1bc, ERIAR_MASK_1111, 0x0000001f,
+				      ERIAR_EXGMAC);
+			rtl_eri_write(tp, 0x1dc, ERIAR_MASK_1111, 0x0000003f,
+				      ERIAR_EXGMAC);
+		}
+	} else if (tp->mac_version == RTL_GIGA_MAC_VER_37) {
+		if (phydev->speed == SPEED_10) {
+			rtl_eri_write(tp, 0x1d0, ERIAR_MASK_0011, 0x4d02,
+				      ERIAR_EXGMAC);
+			rtl_eri_write(tp, 0x1dc, ERIAR_MASK_0011, 0x0060,
+				      ERIAR_EXGMAC);
+		} else {
+			rtl_eri_write(tp, 0x1d0, ERIAR_MASK_0011, 0x0000,
+				      ERIAR_EXGMAC);
+		}
+	}
+}
+
+#define WAKE_ANY (WAKE_PHY | WAKE_MAGIC | WAKE_UCAST | WAKE_BCAST | WAKE_MCAST)
+
+static u32 __rtl8169_get_wol(struct rtl8169_private *tp)
+{
+	u8 options;
+	u32 wolopts = 0;
+
+	options = RTL_R8(tp, Config1);
+	if (!(options & PMEnable))
+		return 0;
+
+	options = RTL_R8(tp, Config3);
+	if (options & LinkUp)
+		wolopts |= WAKE_PHY;
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_34 ... RTL_GIGA_MAC_VER_38:
+	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_51:
+		if (rtl_eri_read(tp, 0xdc, ERIAR_EXGMAC) & MagicPacket_v2)
+			wolopts |= WAKE_MAGIC;
+		break;
+	default:
+		if (options & MagicPacket)
+			wolopts |= WAKE_MAGIC;
+		break;
+	}
+
+	options = RTL_R8(tp, Config5);
+	if (options & UWF)
+		wolopts |= WAKE_UCAST;
+	if (options & BWF)
+		wolopts |= WAKE_BCAST;
+	if (options & MWF)
+		wolopts |= WAKE_MCAST;
+
+	return wolopts;
+}
+
+static void rtl8169_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+
+	rtl_lock_work(tp);
+	wol->supported = WAKE_ANY;
+	wol->wolopts = tp->saved_wolopts;
+	rtl_unlock_work(tp);
+}
+
+static void __rtl8169_set_wol(struct rtl8169_private *tp, u32 wolopts)
+{
+	unsigned int i, tmp;
+	static const struct {
+		u32 opt;
+		u16 reg;
+		u8  mask;
+	} cfg[] = {
+		{ WAKE_PHY,   Config3, LinkUp },
+		{ WAKE_UCAST, Config5, UWF },
+		{ WAKE_BCAST, Config5, BWF },
+		{ WAKE_MCAST, Config5, MWF },
+		{ WAKE_ANY,   Config5, LanWake },
+		{ WAKE_MAGIC, Config3, MagicPacket }
+	};
+	u8 options;
+
+	RTL_W8(tp, Cfg9346, Cfg9346_Unlock);
+
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_34 ... RTL_GIGA_MAC_VER_38:
+	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_51:
+		tmp = ARRAY_SIZE(cfg) - 1;
+		if (wolopts & WAKE_MAGIC)
+			rtl_w0w1_eri(tp,
+				     0x0dc,
+				     ERIAR_MASK_0100,
+				     MagicPacket_v2,
+				     0x0000,
+				     ERIAR_EXGMAC);
+		else
+			rtl_w0w1_eri(tp,
+				     0x0dc,
+				     ERIAR_MASK_0100,
+				     0x0000,
+				     MagicPacket_v2,
+				     ERIAR_EXGMAC);
+		break;
+	default:
+		tmp = ARRAY_SIZE(cfg);
+		break;
+	}
+
+	for (i = 0; i < tmp; i++) {
+		options = RTL_R8(tp, cfg[i].reg) & ~cfg[i].mask;
+		if (wolopts & cfg[i].opt)
+			options |= cfg[i].mask;
+		RTL_W8(tp, cfg[i].reg, options);
+	}
+
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_01 ... RTL_GIGA_MAC_VER_17:
+		options = RTL_R8(tp, Config1) & ~PMEnable;
+		if (wolopts)
+			options |= PMEnable;
+		RTL_W8(tp, Config1, options);
+		break;
+	default:
+		options = RTL_R8(tp, Config2) & ~PME_SIGNAL;
+		if (wolopts)
+			options |= PME_SIGNAL;
+		RTL_W8(tp, Config2, options);
+		break;
+	}
+
+	RTL_W8(tp, Cfg9346, Cfg9346_Lock);
+
+	device_set_wakeup_enable(tp_to_dev(tp), wolopts);
+}
+
+static int rtl8169_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+	struct device *d = tp_to_dev(tp);
+
+	if (wol->wolopts & ~WAKE_ANY)
+		return -EINVAL;
+
+	pm_runtime_get_noresume(d);
+
+	rtl_lock_work(tp);
+
+	tp->saved_wolopts = wol->wolopts;
+
+	if (pm_runtime_active(d))
+		__rtl8169_set_wol(tp, tp->saved_wolopts);
+
+	rtl_unlock_work(tp);
+
+	pm_runtime_put_noidle(d);
+
+	return 0;
+}
+
+static const char *rtl_lookup_firmware_name(struct rtl8169_private *tp)
+{
+	return rtl_chip_infos[tp->mac_version].fw_name;
+}
+
+static void rtl8169_get_drvinfo(struct net_device *dev,
+				struct ethtool_drvinfo *info)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+	struct rtl_fw *rtl_fw = tp->rtl_fw;
+
+	strlcpy(info->driver, MODULENAME, sizeof(info->driver));
+	strlcpy(info->bus_info, pci_name(tp->pci_dev), sizeof(info->bus_info));
+	BUILD_BUG_ON(sizeof(info->fw_version) < sizeof(rtl_fw->version));
+	if (!IS_ERR_OR_NULL(rtl_fw))
+		strlcpy(info->fw_version, rtl_fw->version,
+			sizeof(info->fw_version));
+}
+
+static int rtl8169_get_regs_len(struct net_device *dev)
+{
+	return R8169_REGS_SIZE;
+}
+
+static netdev_features_t rtl8169_fix_features(struct net_device *dev,
+	netdev_features_t features)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+
+	if (dev->mtu > TD_MSS_MAX)
+		features &= ~NETIF_F_ALL_TSO;
+
+	if (dev->mtu > JUMBO_1K &&
+	    tp->mac_version > RTL_GIGA_MAC_VER_06)
+		features &= ~NETIF_F_IP_CSUM;
+
+	return features;
+}
+
+static int rtl8169_set_features(struct net_device *dev,
+				netdev_features_t features)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+	u32 rx_config;
+
+	rtl_lock_work(tp);
+
+	rx_config = RTL_R32(tp, RxConfig);
+	if (features & NETIF_F_RXALL)
+		rx_config |= (AcceptErr | AcceptRunt);
+	else
+		rx_config &= ~(AcceptErr | AcceptRunt);
+
+	RTL_W32(tp, RxConfig, rx_config);
+
+	if (features & NETIF_F_RXCSUM)
+		tp->cp_cmd |= RxChkSum;
+	else
+		tp->cp_cmd &= ~RxChkSum;
+
+	if (features & NETIF_F_HW_VLAN_CTAG_RX)
+		tp->cp_cmd |= RxVlan;
+	else
+		tp->cp_cmd &= ~RxVlan;
+
+	RTL_W16(tp, CPlusCmd, tp->cp_cmd);
+	RTL_R16(tp, CPlusCmd);
+
+	rtl_unlock_work(tp);
+
+	return 0;
+}
+
+static inline u32 rtl8169_tx_vlan_tag(struct sk_buff *skb)
+{
+	return (skb_vlan_tag_present(skb)) ?
+		TxVlanTag | swab16(skb_vlan_tag_get(skb)) : 0x00;
+}
+
+static void rtl8169_rx_vlan_tag(struct RxDesc *desc, struct sk_buff *skb)
+{
+	u32 opts2 = le32_to_cpu(desc->opts2);
+
+	if (opts2 & RxVlanTag)
+		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), swab16(opts2 & 0xffff));
+}
+
+static void rtl8169_get_regs(struct net_device *dev, struct ethtool_regs *regs,
+			     void *p)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+	u32 __iomem *data = tp->mmio_addr;
+	u32 *dw = p;
+	int i;
+
+	rtl_lock_work(tp);
+	for (i = 0; i < R8169_REGS_SIZE; i += 4)
+		memcpy_fromio(dw++, data++, 4);
+	rtl_unlock_work(tp);
+}
+
+static u32 rtl8169_get_msglevel(struct net_device *dev)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+
+	return tp->msg_enable;
+}
+
+static void rtl8169_set_msglevel(struct net_device *dev, u32 value)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+
+	tp->msg_enable = value;
+}
+
+static const char rtl8169_gstrings[][ETH_GSTRING_LEN] = {
+	"tx_packets",
+	"rx_packets",
+	"tx_errors",
+	"rx_errors",
+	"rx_missed",
+	"align_errors",
+	"tx_single_collisions",
+	"tx_multi_collisions",
+	"unicast",
+	"broadcast",
+	"multicast",
+	"tx_aborted",
+	"tx_underrun",
+};
+
+static int rtl8169_get_sset_count(struct net_device *dev, int sset)
+{
+	switch (sset) {
+	case ETH_SS_STATS:
+		return ARRAY_SIZE(rtl8169_gstrings);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+DECLARE_RTL_COND(rtl_counters_cond)
+{
+	return RTL_R32(tp, CounterAddrLow) & (CounterReset | CounterDump);
+}
+
+static bool rtl8169_do_counters(struct rtl8169_private *tp, u32 counter_cmd)
+{
+	dma_addr_t paddr = tp->counters_phys_addr;
+	u32 cmd;
+
+	RTL_W32(tp, CounterAddrHigh, (u64)paddr >> 32);
+	RTL_R32(tp, CounterAddrHigh);
+	cmd = (u64)paddr & DMA_BIT_MASK(32);
+	RTL_W32(tp, CounterAddrLow, cmd);
+	RTL_W32(tp, CounterAddrLow, cmd | counter_cmd);
+
+	return rtl_udelay_loop_wait_low(tp, &rtl_counters_cond, 10, 1000);
+}
+
+static bool rtl8169_reset_counters(struct rtl8169_private *tp)
+{
+	/*
+	 * Versions prior to RTL_GIGA_MAC_VER_19 don't support resetting the
+	 * tally counters.
+	 */
+	if (tp->mac_version < RTL_GIGA_MAC_VER_19)
+		return true;
+
+	return rtl8169_do_counters(tp, CounterReset);
+}
+
+static bool rtl8169_update_counters(struct rtl8169_private *tp)
+{
+	u8 val = RTL_R8(tp, ChipCmd);
+
+	/*
+	 * Some chips are unable to dump tally counters when the receiver
+	 * is disabled. If 0xff chip may be in a PCI power-save state.
+	 */
+	if (!(val & CmdRxEnb) || val == 0xff)
+		return true;
+
+	return rtl8169_do_counters(tp, CounterDump);
+}
+
+static bool rtl8169_init_counter_offsets(struct rtl8169_private *tp)
+{
+	struct rtl8169_counters *counters = tp->counters;
+	bool ret = false;
+
+	/*
+	 * rtl8169_init_counter_offsets is called from rtl_open.  On chip
+	 * versions prior to RTL_GIGA_MAC_VER_19 the tally counters are only
+	 * reset by a power cycle, while the counter values collected by the
+	 * driver are reset at every driver unload/load cycle.
+	 *
+	 * To make sure the HW values returned by @get_stats64 match the SW
+	 * values, we collect the initial values at first open(*) and use them
+	 * as offsets to normalize the values returned by @get_stats64.
+	 *
+	 * (*) We can't call rtl8169_init_counter_offsets from rtl_init_one
+	 * for the reason stated in rtl8169_update_counters; CmdRxEnb is only
+	 * set at open time by rtl_hw_start.
+	 */
+
+	if (tp->tc_offset.inited)
+		return true;
+
+	/* If both, reset and update fail, propagate to caller. */
+	if (rtl8169_reset_counters(tp))
+		ret = true;
+
+	if (rtl8169_update_counters(tp))
+		ret = true;
+
+	tp->tc_offset.tx_errors = counters->tx_errors;
+	tp->tc_offset.tx_multi_collision = counters->tx_multi_collision;
+	tp->tc_offset.tx_aborted = counters->tx_aborted;
+	tp->tc_offset.inited = true;
+
+	return ret;
+}
+
+static void rtl8169_get_ethtool_stats(struct net_device *dev,
+				      struct ethtool_stats *stats, u64 *data)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+	struct device *d = tp_to_dev(tp);
+	struct rtl8169_counters *counters = tp->counters;
+
+	ASSERT_RTNL();
+
+	pm_runtime_get_noresume(d);
+
+	if (pm_runtime_active(d))
+		rtl8169_update_counters(tp);
+
+	pm_runtime_put_noidle(d);
+
+	data[0] = le64_to_cpu(counters->tx_packets);
+	data[1] = le64_to_cpu(counters->rx_packets);
+	data[2] = le64_to_cpu(counters->tx_errors);
+	data[3] = le32_to_cpu(counters->rx_errors);
+	data[4] = le16_to_cpu(counters->rx_missed);
+	data[5] = le16_to_cpu(counters->align_errors);
+	data[6] = le32_to_cpu(counters->tx_one_collision);
+	data[7] = le32_to_cpu(counters->tx_multi_collision);
+	data[8] = le64_to_cpu(counters->rx_unicast);
+	data[9] = le64_to_cpu(counters->rx_broadcast);
+	data[10] = le32_to_cpu(counters->rx_multicast);
+	data[11] = le16_to_cpu(counters->tx_aborted);
+	data[12] = le16_to_cpu(counters->tx_underun);
+}
+
+static void rtl8169_get_strings(struct net_device *dev, u32 stringset, u8 *data)
+{
+	switch(stringset) {
+	case ETH_SS_STATS:
+		memcpy(data, rtl8169_gstrings, sizeof(rtl8169_gstrings));
+		break;
+	}
+}
+
+/*
+ * Interrupt coalescing
+ *
+ * > 1 - the availability of the IntrMitigate (0xe2) register through the
+ * >     8169, 8168 and 810x line of chipsets
+ *
+ * 8169, 8168, and 8136(810x) serial chipsets support it.
+ *
+ * > 2 - the Tx timer unit at gigabit speed
+ *
+ * The unit of the timer depends on both the speed and the setting of CPlusCmd
+ * (0xe0) bit 1 and bit 0.
+ *
+ * For 8169
+ * bit[1:0] \ speed        1000M           100M            10M
+ * 0 0                     320ns           2.56us          40.96us
+ * 0 1                     2.56us          20.48us         327.7us
+ * 1 0                     5.12us          40.96us         655.4us
+ * 1 1                     10.24us         81.92us         1.31ms
+ *
+ * For the other
+ * bit[1:0] \ speed        1000M           100M            10M
+ * 0 0                     5us             2.56us          40.96us
+ * 0 1                     40us            20.48us         327.7us
+ * 1 0                     80us            40.96us         655.4us
+ * 1 1                     160us           81.92us         1.31ms
+ */
+
+/* rx/tx scale factors for one particular CPlusCmd[0:1] value */
+struct rtl_coalesce_scale {
+	/* Rx / Tx */
+	u32 nsecs[2];
+};
+
+/* rx/tx scale factors for all CPlusCmd[0:1] cases */
+struct rtl_coalesce_info {
+	u32 speed;
+	struct rtl_coalesce_scale scalev[4];	/* each CPlusCmd[0:1] case */
+};
+
+/* produce (r,t) pairs with each being in series of *1, *8, *8*2, *8*2*2 */
+#define rxtx_x1822(r, t) {		\
+	{{(r),		(t)}},		\
+	{{(r)*8,	(t)*8}},	\
+	{{(r)*8*2,	(t)*8*2}},	\
+	{{(r)*8*2*2,	(t)*8*2*2}},	\
+}
+static const struct rtl_coalesce_info rtl_coalesce_info_8169[] = {
+	/* speed	delays:     rx00   tx00	*/
+	{ SPEED_10,	rxtx_x1822(40960, 40960)	},
+	{ SPEED_100,	rxtx_x1822( 2560,  2560)	},
+	{ SPEED_1000,	rxtx_x1822(  320,   320)	},
+	{ 0 },
+};
+
+static const struct rtl_coalesce_info rtl_coalesce_info_8168_8136[] = {
+	/* speed	delays:     rx00   tx00	*/
+	{ SPEED_10,	rxtx_x1822(40960, 40960)	},
+	{ SPEED_100,	rxtx_x1822( 2560,  2560)	},
+	{ SPEED_1000,	rxtx_x1822( 5000,  5000)	},
+	{ 0 },
+};
+#undef rxtx_x1822
+
+/* get rx/tx scale vector corresponding to current speed */
+static const struct rtl_coalesce_info *rtl_coalesce_info(struct net_device *dev)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+	struct ethtool_link_ksettings ecmd;
+	const struct rtl_coalesce_info *ci;
+	int rc;
+
+	rc = phy_ethtool_get_link_ksettings(dev, &ecmd);
+	if (rc < 0)
+		return ERR_PTR(rc);
+
+	for (ci = tp->coalesce_info; ci->speed != 0; ci++) {
+		if (ecmd.base.speed == ci->speed) {
+			return ci;
+		}
+	}
+
+	return ERR_PTR(-ELNRNG);
+}
+
+static int rtl_get_coalesce(struct net_device *dev, struct ethtool_coalesce *ec)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+	const struct rtl_coalesce_info *ci;
+	const struct rtl_coalesce_scale *scale;
+	struct {
+		u32 *max_frames;
+		u32 *usecs;
+	} coal_settings [] = {
+		{ &ec->rx_max_coalesced_frames, &ec->rx_coalesce_usecs },
+		{ &ec->tx_max_coalesced_frames, &ec->tx_coalesce_usecs }
+	}, *p = coal_settings;
+	int i;
+	u16 w;
+
+	memset(ec, 0, sizeof(*ec));
+
+	/* get rx/tx scale corresponding to current speed and CPlusCmd[0:1] */
+	ci = rtl_coalesce_info(dev);
+	if (IS_ERR(ci))
+		return PTR_ERR(ci);
+
+	scale = &ci->scalev[tp->cp_cmd & INTT_MASK];
+
+	/* read IntrMitigate and adjust according to scale */
+	for (w = RTL_R16(tp, IntrMitigate); w; w >>= RTL_COALESCE_SHIFT, p++) {
+		*p->max_frames = (w & RTL_COALESCE_MASK) << 2;
+		w >>= RTL_COALESCE_SHIFT;
+		*p->usecs = w & RTL_COALESCE_MASK;
+	}
+
+	for (i = 0; i < 2; i++) {
+		p = coal_settings + i;
+		*p->usecs = (*p->usecs * scale->nsecs[i]) / 1000;
+
+		/*
+		 * ethtool_coalesce says it is illegal to set both usecs and
+		 * max_frames to 0.
+		 */
+		if (!*p->usecs && !*p->max_frames)
+			*p->max_frames = 1;
+	}
+
+	return 0;
+}
+
+/* choose appropriate scale factor and CPlusCmd[0:1] for (speed, nsec) */
+static const struct rtl_coalesce_scale *rtl_coalesce_choose_scale(
+			struct net_device *dev, u32 nsec, u16 *cp01)
+{
+	const struct rtl_coalesce_info *ci;
+	u16 i;
+
+	ci = rtl_coalesce_info(dev);
+	if (IS_ERR(ci))
+		return ERR_CAST(ci);
+
+	for (i = 0; i < 4; i++) {
+		u32 rxtx_maxscale = max(ci->scalev[i].nsecs[0],
+					ci->scalev[i].nsecs[1]);
+		if (nsec <= rxtx_maxscale * RTL_COALESCE_T_MAX) {
+			*cp01 = i;
+			return &ci->scalev[i];
+		}
+	}
+
+	return ERR_PTR(-EINVAL);
+}
+
+static int rtl_set_coalesce(struct net_device *dev, struct ethtool_coalesce *ec)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+	const struct rtl_coalesce_scale *scale;
+	struct {
+		u32 frames;
+		u32 usecs;
+	} coal_settings [] = {
+		{ ec->rx_max_coalesced_frames, ec->rx_coalesce_usecs },
+		{ ec->tx_max_coalesced_frames, ec->tx_coalesce_usecs }
+	}, *p = coal_settings;
+	u16 w = 0, cp01;
+	int i;
+
+	scale = rtl_coalesce_choose_scale(dev,
+			max(p[0].usecs, p[1].usecs) * 1000, &cp01);
+	if (IS_ERR(scale))
+		return PTR_ERR(scale);
+
+	for (i = 0; i < 2; i++, p++) {
+		u32 units;
+
+		/*
+		 * accept max_frames=1 we returned in rtl_get_coalesce.
+		 * accept it not only when usecs=0 because of e.g. the following scenario:
+		 *
+		 * - both rx_usecs=0 & rx_frames=0 in hardware (no delay on RX)
+		 * - rtl_get_coalesce returns rx_usecs=0, rx_frames=1
+		 * - then user does `ethtool -C eth0 rx-usecs 100`
+		 *
+		 * since ethtool sends to kernel whole ethtool_coalesce
+		 * settings, if we do not handle rx_usecs=!0, rx_frames=1
+		 * we'll reject it below in `frames % 4 != 0`.
+		 */
+		if (p->frames == 1) {
+			p->frames = 0;
+		}
+
+		units = p->usecs * 1000 / scale->nsecs[i];
+		if (p->frames > RTL_COALESCE_FRAME_MAX || p->frames % 4)
+			return -EINVAL;
+
+		w <<= RTL_COALESCE_SHIFT;
+		w |= units;
+		w <<= RTL_COALESCE_SHIFT;
+		w |= p->frames >> 2;
+	}
+
+	rtl_lock_work(tp);
+
+	RTL_W16(tp, IntrMitigate, swab16(w));
+
+	tp->cp_cmd = (tp->cp_cmd & ~INTT_MASK) | cp01;
+	RTL_W16(tp, CPlusCmd, tp->cp_cmd);
+	RTL_R16(tp, CPlusCmd);
+
+	rtl_unlock_work(tp);
+
+	return 0;
+}
+
+static const struct ethtool_ops rtl8169_ethtool_ops = {
+	.get_drvinfo		= rtl8169_get_drvinfo,
+	.get_regs_len		= rtl8169_get_regs_len,
+	.get_link		= ethtool_op_get_link,
+	.get_coalesce		= rtl_get_coalesce,
+	.set_coalesce		= rtl_set_coalesce,
+	.get_msglevel		= rtl8169_get_msglevel,
+	.set_msglevel		= rtl8169_set_msglevel,
+	.get_regs		= rtl8169_get_regs,
+	.get_wol		= rtl8169_get_wol,
+	.set_wol		= rtl8169_set_wol,
+	.get_strings		= rtl8169_get_strings,
+	.get_sset_count		= rtl8169_get_sset_count,
+	.get_ethtool_stats	= rtl8169_get_ethtool_stats,
+	.get_ts_info		= ethtool_op_get_ts_info,
+	.nway_reset		= phy_ethtool_nway_reset,
+	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
+	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
+};
+
+static void rtl8169_get_mac_version(struct rtl8169_private *tp,
+				    u8 default_version)
+{
+	/*
+	 * The driver currently handles the 8168Bf and the 8168Be identically
+	 * but they can be identified more specifically through the test below
+	 * if needed:
+	 *
+	 * (RTL_R32(tp, TxConfig) & 0x700000) == 0x500000 ? 8168Bf : 8168Be
+	 *
+	 * Same thing for the 8101Eb and the 8101Ec:
+	 *
+	 * (RTL_R32(tp, TxConfig) & 0x700000) == 0x200000 ? 8101Eb : 8101Ec
+	 */
+	static const struct rtl_mac_info {
+		u32 mask;
+		u32 val;
+		int mac_version;
+	} mac_info[] = {
+		/* 8168EP family. */
+		{ 0x7cf00000, 0x50200000,	RTL_GIGA_MAC_VER_51 },
+		{ 0x7cf00000, 0x50100000,	RTL_GIGA_MAC_VER_50 },
+		{ 0x7cf00000, 0x50000000,	RTL_GIGA_MAC_VER_49 },
+
+		/* 8168H family. */
+		{ 0x7cf00000, 0x54100000,	RTL_GIGA_MAC_VER_46 },
+		{ 0x7cf00000, 0x54000000,	RTL_GIGA_MAC_VER_45 },
+
+		/* 8168G family. */
+		{ 0x7cf00000, 0x5c800000,	RTL_GIGA_MAC_VER_44 },
+		{ 0x7cf00000, 0x50900000,	RTL_GIGA_MAC_VER_42 },
+		{ 0x7cf00000, 0x4c100000,	RTL_GIGA_MAC_VER_41 },
+		{ 0x7cf00000, 0x4c000000,	RTL_GIGA_MAC_VER_40 },
+
+		/* 8168F family. */
+		{ 0x7c800000, 0x48800000,	RTL_GIGA_MAC_VER_38 },
+		{ 0x7cf00000, 0x48100000,	RTL_GIGA_MAC_VER_36 },
+		{ 0x7cf00000, 0x48000000,	RTL_GIGA_MAC_VER_35 },
+
+		/* 8168E family. */
+		{ 0x7c800000, 0x2c800000,	RTL_GIGA_MAC_VER_34 },
+		{ 0x7cf00000, 0x2c100000,	RTL_GIGA_MAC_VER_32 },
+		{ 0x7c800000, 0x2c000000,	RTL_GIGA_MAC_VER_33 },
+
+		/* 8168D family. */
+		{ 0x7cf00000, 0x28100000,	RTL_GIGA_MAC_VER_25 },
+		{ 0x7c800000, 0x28000000,	RTL_GIGA_MAC_VER_26 },
+
+		/* 8168DP family. */
+		{ 0x7cf00000, 0x28800000,	RTL_GIGA_MAC_VER_27 },
+		{ 0x7cf00000, 0x28a00000,	RTL_GIGA_MAC_VER_28 },
+		{ 0x7cf00000, 0x28b00000,	RTL_GIGA_MAC_VER_31 },
+
+		/* 8168C family. */
+		{ 0x7cf00000, 0x3c900000,	RTL_GIGA_MAC_VER_23 },
+		{ 0x7cf00000, 0x3c800000,	RTL_GIGA_MAC_VER_18 },
+		{ 0x7c800000, 0x3c800000,	RTL_GIGA_MAC_VER_24 },
+		{ 0x7cf00000, 0x3c000000,	RTL_GIGA_MAC_VER_19 },
+		{ 0x7cf00000, 0x3c200000,	RTL_GIGA_MAC_VER_20 },
+		{ 0x7cf00000, 0x3c300000,	RTL_GIGA_MAC_VER_21 },
+		{ 0x7c800000, 0x3c000000,	RTL_GIGA_MAC_VER_22 },
+
+		/* 8168B family. */
+		{ 0x7cf00000, 0x38000000,	RTL_GIGA_MAC_VER_12 },
+		{ 0x7c800000, 0x38000000,	RTL_GIGA_MAC_VER_17 },
+		{ 0x7c800000, 0x30000000,	RTL_GIGA_MAC_VER_11 },
+
+		/* 8101 family. */
+		{ 0x7c800000, 0x44800000,	RTL_GIGA_MAC_VER_39 },
+		{ 0x7c800000, 0x44000000,	RTL_GIGA_MAC_VER_37 },
+		{ 0x7cf00000, 0x40900000,	RTL_GIGA_MAC_VER_29 },
+		{ 0x7c800000, 0x40800000,	RTL_GIGA_MAC_VER_30 },
+		{ 0x7cf00000, 0x34900000,	RTL_GIGA_MAC_VER_08 },
+		{ 0x7cf00000, 0x24900000,	RTL_GIGA_MAC_VER_08 },
+		{ 0x7cf00000, 0x34800000,	RTL_GIGA_MAC_VER_07 },
+		{ 0x7cf00000, 0x24800000,	RTL_GIGA_MAC_VER_07 },
+		{ 0x7cf00000, 0x34000000,	RTL_GIGA_MAC_VER_13 },
+		{ 0x7cf00000, 0x34300000,	RTL_GIGA_MAC_VER_10 },
+		{ 0x7cf00000, 0x34200000,	RTL_GIGA_MAC_VER_16 },
+		{ 0x7c800000, 0x34800000,	RTL_GIGA_MAC_VER_09 },
+		{ 0x7c800000, 0x24800000,	RTL_GIGA_MAC_VER_09 },
+		{ 0x7c800000, 0x34000000,	RTL_GIGA_MAC_VER_16 },
+		/* FIXME: where did these entries come from ? -- FR */
+		{ 0xfc800000, 0x38800000,	RTL_GIGA_MAC_VER_15 },
+		{ 0xfc800000, 0x30800000,	RTL_GIGA_MAC_VER_14 },
+
+		/* 8110 family. */
+		{ 0xfc800000, 0x98000000,	RTL_GIGA_MAC_VER_06 },
+		{ 0xfc800000, 0x18000000,	RTL_GIGA_MAC_VER_05 },
+		{ 0xfc800000, 0x10000000,	RTL_GIGA_MAC_VER_04 },
+		{ 0xfc800000, 0x04000000,	RTL_GIGA_MAC_VER_03 },
+		{ 0xfc800000, 0x00800000,	RTL_GIGA_MAC_VER_02 },
+		{ 0xfc800000, 0x00000000,	RTL_GIGA_MAC_VER_01 },
+
+		/* Catch-all */
+		{ 0x00000000, 0x00000000,	RTL_GIGA_MAC_NONE   }
+	};
+	const struct rtl_mac_info *p = mac_info;
+	u32 reg;
+
+	reg = RTL_R32(tp, TxConfig);
+	while ((reg & p->mask) != p->val)
+		p++;
+	tp->mac_version = p->mac_version;
+
+	if (tp->mac_version == RTL_GIGA_MAC_NONE) {
+		dev_notice(tp_to_dev(tp),
+			   "unknown MAC, using family default\n");
+		tp->mac_version = default_version;
+	} else if (tp->mac_version == RTL_GIGA_MAC_VER_42) {
+		tp->mac_version = tp->supports_gmii ?
+				  RTL_GIGA_MAC_VER_42 :
+				  RTL_GIGA_MAC_VER_43;
+	} else if (tp->mac_version == RTL_GIGA_MAC_VER_45) {
+		tp->mac_version = tp->supports_gmii ?
+				  RTL_GIGA_MAC_VER_45 :
+				  RTL_GIGA_MAC_VER_47;
+	} else if (tp->mac_version == RTL_GIGA_MAC_VER_46) {
+		tp->mac_version = tp->supports_gmii ?
+				  RTL_GIGA_MAC_VER_46 :
+				  RTL_GIGA_MAC_VER_48;
+	}
+}
+
+static void rtl8169_print_mac_version(struct rtl8169_private *tp)
+{
+	netif_dbg(tp, drv, tp->dev, "mac_version = 0x%02x\n", tp->mac_version);
+}
+
+struct phy_reg {
+	u16 reg;
+	u16 val;
+};
+
+static void rtl_writephy_batch(struct rtl8169_private *tp,
+			       const struct phy_reg *regs, int len)
+{
+	while (len-- > 0) {
+		rtl_writephy(tp, regs->reg, regs->val);
+		regs++;
+	}
+}
+
+#define PHY_READ		0x00000000
+#define PHY_DATA_OR		0x10000000
+#define PHY_DATA_AND		0x20000000
+#define PHY_BJMPN		0x30000000
+#define PHY_MDIO_CHG		0x40000000
+#define PHY_CLEAR_READCOUNT	0x70000000
+#define PHY_WRITE		0x80000000
+#define PHY_READCOUNT_EQ_SKIP	0x90000000
+#define PHY_COMP_EQ_SKIPN	0xa0000000
+#define PHY_COMP_NEQ_SKIPN	0xb0000000
+#define PHY_WRITE_PREVIOUS	0xc0000000
+#define PHY_SKIPN		0xd0000000
+#define PHY_DELAY_MS		0xe0000000
+
+struct fw_info {
+	u32	magic;
+	char	version[RTL_VER_SIZE];
+	__le32	fw_start;
+	__le32	fw_len;
+	u8	chksum;
+} __packed;
+
+#define FW_OPCODE_SIZE	sizeof(typeof(*((struct rtl_fw_phy_action *)0)->code))
+
+static bool rtl_fw_format_ok(struct rtl8169_private *tp, struct rtl_fw *rtl_fw)
+{
+	const struct firmware *fw = rtl_fw->fw;
+	struct fw_info *fw_info = (struct fw_info *)fw->data;
+	struct rtl_fw_phy_action *pa = &rtl_fw->phy_action;
+	char *version = rtl_fw->version;
+	bool rc = false;
+
+	if (fw->size < FW_OPCODE_SIZE)
+		goto out;
+
+	if (!fw_info->magic) {
+		size_t i, size, start;
+		u8 checksum = 0;
+
+		if (fw->size < sizeof(*fw_info))
+			goto out;
+
+		for (i = 0; i < fw->size; i++)
+			checksum += fw->data[i];
+		if (checksum != 0)
+			goto out;
+
+		start = le32_to_cpu(fw_info->fw_start);
+		if (start > fw->size)
+			goto out;
+
+		size = le32_to_cpu(fw_info->fw_len);
+		if (size > (fw->size - start) / FW_OPCODE_SIZE)
+			goto out;
+
+		memcpy(version, fw_info->version, RTL_VER_SIZE);
+
+		pa->code = (__le32 *)(fw->data + start);
+		pa->size = size;
+	} else {
+		if (fw->size % FW_OPCODE_SIZE)
+			goto out;
+
+		strlcpy(version, rtl_lookup_firmware_name(tp), RTL_VER_SIZE);
+
+		pa->code = (__le32 *)fw->data;
+		pa->size = fw->size / FW_OPCODE_SIZE;
+	}
+	version[RTL_VER_SIZE - 1] = 0;
+
+	rc = true;
+out:
+	return rc;
+}
+
+static bool rtl_fw_data_ok(struct rtl8169_private *tp, struct net_device *dev,
+			   struct rtl_fw_phy_action *pa)
+{
+	bool rc = false;
+	size_t index;
+
+	for (index = 0; index < pa->size; index++) {
+		u32 action = le32_to_cpu(pa->code[index]);
+		u32 regno = (action & 0x0fff0000) >> 16;
+
+		switch(action & 0xf0000000) {
+		case PHY_READ:
+		case PHY_DATA_OR:
+		case PHY_DATA_AND:
+		case PHY_MDIO_CHG:
+		case PHY_CLEAR_READCOUNT:
+		case PHY_WRITE:
+		case PHY_WRITE_PREVIOUS:
+		case PHY_DELAY_MS:
+			break;
+
+		case PHY_BJMPN:
+			if (regno > index) {
+				netif_err(tp, ifup, tp->dev,
+					  "Out of range of firmware\n");
+				goto out;
+			}
+			break;
+		case PHY_READCOUNT_EQ_SKIP:
+			if (index + 2 >= pa->size) {
+				netif_err(tp, ifup, tp->dev,
+					  "Out of range of firmware\n");
+				goto out;
+			}
+			break;
+		case PHY_COMP_EQ_SKIPN:
+		case PHY_COMP_NEQ_SKIPN:
+		case PHY_SKIPN:
+			if (index + 1 + regno >= pa->size) {
+				netif_err(tp, ifup, tp->dev,
+					  "Out of range of firmware\n");
+				goto out;
+			}
+			break;
+
+		default:
+			netif_err(tp, ifup, tp->dev,
+				  "Invalid action 0x%08x\n", action);
+			goto out;
+		}
+	}
+	rc = true;
+out:
+	return rc;
+}
+
+static int rtl_check_firmware(struct rtl8169_private *tp, struct rtl_fw *rtl_fw)
+{
+	struct net_device *dev = tp->dev;
+	int rc = -EINVAL;
+
+	if (!rtl_fw_format_ok(tp, rtl_fw)) {
+		netif_err(tp, ifup, dev, "invalid firmware\n");
+		goto out;
+	}
+
+	if (rtl_fw_data_ok(tp, dev, &rtl_fw->phy_action))
+		rc = 0;
+out:
+	return rc;
+}
+
+static void rtl_phy_write_fw(struct rtl8169_private *tp, struct rtl_fw *rtl_fw)
+{
+	struct rtl_fw_phy_action *pa = &rtl_fw->phy_action;
+	struct mdio_ops org, *ops = &tp->mdio_ops;
+	u32 predata, count;
+	size_t index;
+
+	predata = count = 0;
+	org.write = ops->write;
+	org.read = ops->read;
+
+	for (index = 0; index < pa->size; ) {
+		u32 action = le32_to_cpu(pa->code[index]);
+		u32 data = action & 0x0000ffff;
+		u32 regno = (action & 0x0fff0000) >> 16;
+
+		if (!action)
+			break;
+
+		switch(action & 0xf0000000) {
+		case PHY_READ:
+			predata = rtl_readphy(tp, regno);
+			count++;
+			index++;
+			break;
+		case PHY_DATA_OR:
+			predata |= data;
+			index++;
+			break;
+		case PHY_DATA_AND:
+			predata &= data;
+			index++;
+			break;
+		case PHY_BJMPN:
+			index -= regno;
+			break;
+		case PHY_MDIO_CHG:
+			if (data == 0) {
+				ops->write = org.write;
+				ops->read = org.read;
+			} else if (data == 1) {
+				ops->write = mac_mcu_write;
+				ops->read = mac_mcu_read;
+			}
+
+			index++;
+			break;
+		case PHY_CLEAR_READCOUNT:
+			count = 0;
+			index++;
+			break;
+		case PHY_WRITE:
+			rtl_writephy(tp, regno, data);
+			index++;
+			break;
+		case PHY_READCOUNT_EQ_SKIP:
+			index += (count == data) ? 2 : 1;
+			break;
+		case PHY_COMP_EQ_SKIPN:
+			if (predata == data)
+				index += regno;
+			index++;
+			break;
+		case PHY_COMP_NEQ_SKIPN:
+			if (predata != data)
+				index += regno;
+			index++;
+			break;
+		case PHY_WRITE_PREVIOUS:
+			rtl_writephy(tp, regno, predata);
+			index++;
+			break;
+		case PHY_SKIPN:
+			index += regno + 1;
+			break;
+		case PHY_DELAY_MS:
+			mdelay(data);
+			index++;
+			break;
+
+		default:
+			BUG();
+		}
+	}
+
+	ops->write = org.write;
+	ops->read = org.read;
+}
+
+static void rtl_release_firmware(struct rtl8169_private *tp)
+{
+	if (!IS_ERR_OR_NULL(tp->rtl_fw)) {
+		release_firmware(tp->rtl_fw->fw);
+		kfree(tp->rtl_fw);
+	}
+	tp->rtl_fw = RTL_FIRMWARE_UNKNOWN;
+}
+
+static void rtl_apply_firmware(struct rtl8169_private *tp)
+{
+	struct rtl_fw *rtl_fw = tp->rtl_fw;
+
+	/* TODO: release firmware once rtl_phy_write_fw signals failures. */
+	if (!IS_ERR_OR_NULL(rtl_fw))
+		rtl_phy_write_fw(tp, rtl_fw);
+}
+
+static void rtl_apply_firmware_cond(struct rtl8169_private *tp, u8 reg, u16 val)
+{
+	if (rtl_readphy(tp, reg) != val)
+		netif_warn(tp, hw, tp->dev, "chipset not ready for firmware\n");
+	else
+		rtl_apply_firmware(tp);
+}
+
+static void rtl8169s_hw_phy_config(struct rtl8169_private *tp)
+{
+	static const struct phy_reg phy_reg_init[] = {
+		{ 0x1f, 0x0001 },
+		{ 0x06, 0x006e },
+		{ 0x08, 0x0708 },
+		{ 0x15, 0x4000 },
+		{ 0x18, 0x65c7 },
+
+		{ 0x1f, 0x0001 },
+		{ 0x03, 0x00a1 },
+		{ 0x02, 0x0008 },
+		{ 0x01, 0x0120 },
+		{ 0x00, 0x1000 },
+		{ 0x04, 0x0800 },
+		{ 0x04, 0x0000 },
+
+		{ 0x03, 0xff41 },
+		{ 0x02, 0xdf60 },
+		{ 0x01, 0x0140 },
+		{ 0x00, 0x0077 },
+		{ 0x04, 0x7800 },
+		{ 0x04, 0x7000 },
+
+		{ 0x03, 0x802f },
+		{ 0x02, 0x4f02 },
+		{ 0x01, 0x0409 },
+		{ 0x00, 0xf0f9 },
+		{ 0x04, 0x9800 },
+		{ 0x04, 0x9000 },
+
+		{ 0x03, 0xdf01 },
+		{ 0x02, 0xdf20 },
+		{ 0x01, 0xff95 },
+		{ 0x00, 0xba00 },
+		{ 0x04, 0xa800 },
+		{ 0x04, 0xa000 },
+
+		{ 0x03, 0xff41 },
+		{ 0x02, 0xdf20 },
+		{ 0x01, 0x0140 },
+		{ 0x00, 0x00bb },
+		{ 0x04, 0xb800 },
+		{ 0x04, 0xb000 },
+
+		{ 0x03, 0xdf41 },
+		{ 0x02, 0xdc60 },
+		{ 0x01, 0x6340 },
+		{ 0x00, 0x007d },
+		{ 0x04, 0xd800 },
+		{ 0x04, 0xd000 },
+
+		{ 0x03, 0xdf01 },
+		{ 0x02, 0xdf20 },
+		{ 0x01, 0x100a },
+		{ 0x00, 0xa0ff },
+		{ 0x04, 0xf800 },
+		{ 0x04, 0xf000 },
+
+		{ 0x1f, 0x0000 },
+		{ 0x0b, 0x0000 },
+		{ 0x00, 0x9200 }
+	};
+
+	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
+}
+
+static void rtl8169sb_hw_phy_config(struct rtl8169_private *tp)
+{
+	static const struct phy_reg phy_reg_init[] = {
+		{ 0x1f, 0x0002 },
+		{ 0x01, 0x90d0 },
+		{ 0x1f, 0x0000 }
+	};
+
+	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
+}
+
+static void rtl8169scd_hw_phy_config_quirk(struct rtl8169_private *tp)
+{
+	struct pci_dev *pdev = tp->pci_dev;
+
+	if ((pdev->subsystem_vendor != PCI_VENDOR_ID_GIGABYTE) ||
+	    (pdev->subsystem_device != 0xe000))
+		return;
+
+	rtl_writephy(tp, 0x1f, 0x0001);
+	rtl_writephy(tp, 0x10, 0xf01b);
+	rtl_writephy(tp, 0x1f, 0x0000);
+}
+
+static void rtl8169scd_hw_phy_config(struct rtl8169_private *tp)
+{
+	static const struct phy_reg phy_reg_init[] = {
+		{ 0x1f, 0x0001 },
+		{ 0x04, 0x0000 },
+		{ 0x03, 0x00a1 },
+		{ 0x02, 0x0008 },
+		{ 0x01, 0x0120 },
+		{ 0x00, 0x1000 },
+		{ 0x04, 0x0800 },
+		{ 0x04, 0x9000 },
+		{ 0x03, 0x802f },
+		{ 0x02, 0x4f02 },
+		{ 0x01, 0x0409 },
+		{ 0x00, 0xf099 },
+		{ 0x04, 0x9800 },
+		{ 0x04, 0xa000 },
+		{ 0x03, 0xdf01 },
+		{ 0x02, 0xdf20 },
+		{ 0x01, 0xff95 },
+		{ 0x00, 0xba00 },
+		{ 0x04, 0xa800 },
+		{ 0x04, 0xf000 },
+		{ 0x03, 0xdf01 },
+		{ 0x02, 0xdf20 },
+		{ 0x01, 0x101a },
+		{ 0x00, 0xa0ff },
+		{ 0x04, 0xf800 },
+		{ 0x04, 0x0000 },
+		{ 0x1f, 0x0000 },
+
+		{ 0x1f, 0x0001 },
+		{ 0x10, 0xf41b },
+		{ 0x14, 0xfb54 },
+		{ 0x18, 0xf5c7 },
+		{ 0x1f, 0x0000 },
+
+		{ 0x1f, 0x0001 },
+		{ 0x17, 0x0cc0 },
+		{ 0x1f, 0x0000 }
+	};
+
+	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
+
+	rtl8169scd_hw_phy_config_quirk(tp);
+}
+
+static void rtl8169sce_hw_phy_config(struct rtl8169_private *tp)
+{
+	static const struct phy_reg phy_reg_init[] = {
+		{ 0x1f, 0x0001 },
+		{ 0x04, 0x0000 },
+		{ 0x03, 0x00a1 },
+		{ 0x02, 0x0008 },
+		{ 0x01, 0x0120 },
+		{ 0x00, 0x1000 },
+		{ 0x04, 0x0800 },
+		{ 0x04, 0x9000 },
+		{ 0x03, 0x802f },
+		{ 0x02, 0x4f02 },
+		{ 0x01, 0x0409 },
+		{ 0x00, 0xf099 },
+		{ 0x04, 0x9800 },
+		{ 0x04, 0xa000 },
+		{ 0x03, 0xdf01 },
+		{ 0x02, 0xdf20 },
+		{ 0x01, 0xff95 },
+		{ 0x00, 0xba00 },
+		{ 0x04, 0xa800 },
+		{ 0x04, 0xf000 },
+		{ 0x03, 0xdf01 },
+		{ 0x02, 0xdf20 },
+		{ 0x01, 0x101a },
+		{ 0x00, 0xa0ff },
+		{ 0x04, 0xf800 },
+		{ 0x04, 0x0000 },
+		{ 0x1f, 0x0000 },
+
+		{ 0x1f, 0x0001 },
+		{ 0x0b, 0x8480 },
+		{ 0x1f, 0x0000 },
+
+		{ 0x1f, 0x0001 },
+		{ 0x18, 0x67c7 },
+		{ 0x04, 0x2000 },
+		{ 0x03, 0x002f },
+		{ 0x02, 0x4360 },
+		{ 0x01, 0x0109 },
+		{ 0x00, 0x3022 },
+		{ 0x04, 0x2800 },
+		{ 0x1f, 0x0000 },
+
+		{ 0x1f, 0x0001 },
+		{ 0x17, 0x0cc0 },
+		{ 0x1f, 0x0000 }
+	};
+
+	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
+}
+
+static void rtl8168bb_hw_phy_config(struct rtl8169_private *tp)
+{
+	static const struct phy_reg phy_reg_init[] = {
+		{ 0x10, 0xf41b },
+		{ 0x1f, 0x0000 }
+	};
+
+	rtl_writephy(tp, 0x1f, 0x0001);
+	rtl_patchphy(tp, 0x16, 1 << 0);
+
+	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
+}
+
+static void rtl8168bef_hw_phy_config(struct rtl8169_private *tp)
+{
+	static const struct phy_reg phy_reg_init[] = {
+		{ 0x1f, 0x0001 },
+		{ 0x10, 0xf41b },
+		{ 0x1f, 0x0000 }
+	};
+
+	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
+}
+
+static void rtl8168cp_1_hw_phy_config(struct rtl8169_private *tp)
+{
+	static const struct phy_reg phy_reg_init[] = {
+		{ 0x1f, 0x0000 },
+		{ 0x1d, 0x0f00 },
+		{ 0x1f, 0x0002 },
+		{ 0x0c, 0x1ec8 },
+		{ 0x1f, 0x0000 }
+	};
+
+	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
+}
+
+static void rtl8168cp_2_hw_phy_config(struct rtl8169_private *tp)
+{
+	static const struct phy_reg phy_reg_init[] = {
+		{ 0x1f, 0x0001 },
+		{ 0x1d, 0x3d98 },
+		{ 0x1f, 0x0000 }
+	};
+
+	rtl_writephy(tp, 0x1f, 0x0000);
+	rtl_patchphy(tp, 0x14, 1 << 5);
+	rtl_patchphy(tp, 0x0d, 1 << 5);
+
+	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
+}
+
+static void rtl8168c_1_hw_phy_config(struct rtl8169_private *tp)
+{
+	static const struct phy_reg phy_reg_init[] = {
+		{ 0x1f, 0x0001 },
+		{ 0x12, 0x2300 },
+		{ 0x1f, 0x0002 },
+		{ 0x00, 0x88d4 },
+		{ 0x01, 0x82b1 },
+		{ 0x03, 0x7002 },
+		{ 0x08, 0x9e30 },
+		{ 0x09, 0x01f0 },
+		{ 0x0a, 0x5500 },
+		{ 0x0c, 0x00c8 },
+		{ 0x1f, 0x0003 },
+		{ 0x12, 0xc096 },
+		{ 0x16, 0x000a },
+		{ 0x1f, 0x0000 },
+		{ 0x1f, 0x0000 },
+		{ 0x09, 0x2000 },
+		{ 0x09, 0x0000 }
+	};
+
+	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
+
+	rtl_patchphy(tp, 0x14, 1 << 5);
+	rtl_patchphy(tp, 0x0d, 1 << 5);
+	rtl_writephy(tp, 0x1f, 0x0000);
+}
+
+static void rtl8168c_2_hw_phy_config(struct rtl8169_private *tp)
+{
+	static const struct phy_reg phy_reg_init[] = {
+		{ 0x1f, 0x0001 },
+		{ 0x12, 0x2300 },
+		{ 0x03, 0x802f },
+		{ 0x02, 0x4f02 },
+		{ 0x01, 0x0409 },
+		{ 0x00, 0xf099 },
+		{ 0x04, 0x9800 },
+		{ 0x04, 0x9000 },
+		{ 0x1d, 0x3d98 },
+		{ 0x1f, 0x0002 },
+		{ 0x0c, 0x7eb8 },
+		{ 0x06, 0x0761 },
+		{ 0x1f, 0x0003 },
+		{ 0x16, 0x0f0a },
+		{ 0x1f, 0x0000 }
+	};
+
+	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
+
+	rtl_patchphy(tp, 0x16, 1 << 0);
+	rtl_patchphy(tp, 0x14, 1 << 5);
+	rtl_patchphy(tp, 0x0d, 1 << 5);
+	rtl_writephy(tp, 0x1f, 0x0000);
+}
+
+static void rtl8168c_3_hw_phy_config(struct rtl8169_private *tp)
+{
+	static const struct phy_reg phy_reg_init[] = {
+		{ 0x1f, 0x0001 },
+		{ 0x12, 0x2300 },
+		{ 0x1d, 0x3d98 },
+		{ 0x1f, 0x0002 },
+		{ 0x0c, 0x7eb8 },
+		{ 0x06, 0x5461 },
+		{ 0x1f, 0x0003 },
+		{ 0x16, 0x0f0a },
+		{ 0x1f, 0x0000 }
+	};
+
+	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
+
+	rtl_patchphy(tp, 0x16, 1 << 0);
+	rtl_patchphy(tp, 0x14, 1 << 5);
+	rtl_patchphy(tp, 0x0d, 1 << 5);
+	rtl_writephy(tp, 0x1f, 0x0000);
+}
+
+static void rtl8168c_4_hw_phy_config(struct rtl8169_private *tp)
+{
+	rtl8168c_3_hw_phy_config(tp);
+}
+
+static void rtl8168d_1_hw_phy_config(struct rtl8169_private *tp)
+{
+	static const struct phy_reg phy_reg_init_0[] = {
+		/* Channel Estimation */
+		{ 0x1f, 0x0001 },
+		{ 0x06, 0x4064 },
+		{ 0x07, 0x2863 },
+		{ 0x08, 0x059c },
+		{ 0x09, 0x26b4 },
+		{ 0x0a, 0x6a19 },
+		{ 0x0b, 0xdcc8 },
+		{ 0x10, 0xf06d },
+		{ 0x14, 0x7f68 },
+		{ 0x18, 0x7fd9 },
+		{ 0x1c, 0xf0ff },
+		{ 0x1d, 0x3d9c },
+		{ 0x1f, 0x0003 },
+		{ 0x12, 0xf49f },
+		{ 0x13, 0x070b },
+		{ 0x1a, 0x05ad },
+		{ 0x14, 0x94c0 },
+
+		/*
+		 * Tx Error Issue
+		 * Enhance line driver power
+		 */
+		{ 0x1f, 0x0002 },
+		{ 0x06, 0x5561 },
+		{ 0x1f, 0x0005 },
+		{ 0x05, 0x8332 },
+		{ 0x06, 0x5561 },
+
+		/*
+		 * Can not link to 1Gbps with bad cable
+		 * Decrease SNR threshold form 21.07dB to 19.04dB
+		 */
+		{ 0x1f, 0x0001 },
+		{ 0x17, 0x0cc0 },
+
+		{ 0x1f, 0x0000 },
+		{ 0x0d, 0xf880 }
+	};
+
+	rtl_writephy_batch(tp, phy_reg_init_0, ARRAY_SIZE(phy_reg_init_0));
+
+	/*
+	 * Rx Error Issue
+	 * Fine Tune Switching regulator parameter
+	 */
+	rtl_writephy(tp, 0x1f, 0x0002);
+	rtl_w0w1_phy(tp, 0x0b, 0x0010, 0x00ef);
+	rtl_w0w1_phy(tp, 0x0c, 0xa200, 0x5d00);
+
+	if (rtl8168d_efuse_read(tp, 0x01) == 0xb1) {
+		static const struct phy_reg phy_reg_init[] = {
+			{ 0x1f, 0x0002 },
+			{ 0x05, 0x669a },
+			{ 0x1f, 0x0005 },
+			{ 0x05, 0x8330 },
+			{ 0x06, 0x669a },
+			{ 0x1f, 0x0002 }
+		};
+		int val;
+
+		rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
+
+		val = rtl_readphy(tp, 0x0d);
+
+		if ((val & 0x00ff) != 0x006c) {
+			static const u32 set[] = {
+				0x0065, 0x0066, 0x0067, 0x0068,
+				0x0069, 0x006a, 0x006b, 0x006c
+			};
+			int i;
+
+			rtl_writephy(tp, 0x1f, 0x0002);
+
+			val &= 0xff00;
+			for (i = 0; i < ARRAY_SIZE(set); i++)
+				rtl_writephy(tp, 0x0d, val | set[i]);
+		}
+	} else {
+		static const struct phy_reg phy_reg_init[] = {
+			{ 0x1f, 0x0002 },
+			{ 0x05, 0x6662 },
+			{ 0x1f, 0x0005 },
+			{ 0x05, 0x8330 },
+			{ 0x06, 0x6662 }
+		};
+
+		rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
+	}
+
+	/* RSET couple improve */
+	rtl_writephy(tp, 0x1f, 0x0002);
+	rtl_patchphy(tp, 0x0d, 0x0300);
+	rtl_patchphy(tp, 0x0f, 0x0010);
+
+	/* Fine tune PLL performance */
+	rtl_writephy(tp, 0x1f, 0x0002);
+	rtl_w0w1_phy(tp, 0x02, 0x0100, 0x0600);
+	rtl_w0w1_phy(tp, 0x03, 0x0000, 0xe000);
+
+	rtl_writephy(tp, 0x1f, 0x0005);
+	rtl_writephy(tp, 0x05, 0x001b);
+
+	rtl_apply_firmware_cond(tp, MII_EXPANSION, 0xbf00);
+
+	rtl_writephy(tp, 0x1f, 0x0000);
+}
+
+static void rtl8168d_2_hw_phy_config(struct rtl8169_private *tp)
+{
+	static const struct phy_reg phy_reg_init_0[] = {
+		/* Channel Estimation */
+		{ 0x1f, 0x0001 },
+		{ 0x06, 0x4064 },
+		{ 0x07, 0x2863 },
+		{ 0x08, 0x059c },
+		{ 0x09, 0x26b4 },
+		{ 0x0a, 0x6a19 },
+		{ 0x0b, 0xdcc8 },
+		{ 0x10, 0xf06d },
+		{ 0x14, 0x7f68 },
+		{ 0x18, 0x7fd9 },
+		{ 0x1c, 0xf0ff },
+		{ 0x1d, 0x3d9c },
+		{ 0x1f, 0x0003 },
+		{ 0x12, 0xf49f },
+		{ 0x13, 0x070b },
+		{ 0x1a, 0x05ad },
+		{ 0x14, 0x94c0 },
+
+		/*
+		 * Tx Error Issue
+		 * Enhance line driver power
+		 */
+		{ 0x1f, 0x0002 },
+		{ 0x06, 0x5561 },
+		{ 0x1f, 0x0005 },
+		{ 0x05, 0x8332 },
+		{ 0x06, 0x5561 },
+
+		/*
+		 * Can not link to 1Gbps with bad cable
+		 * Decrease SNR threshold form 21.07dB to 19.04dB
+		 */
+		{ 0x1f, 0x0001 },
+		{ 0x17, 0x0cc0 },
+
+		{ 0x1f, 0x0000 },
+		{ 0x0d, 0xf880 }
+	};
+
+	rtl_writephy_batch(tp, phy_reg_init_0, ARRAY_SIZE(phy_reg_init_0));
+
+	if (rtl8168d_efuse_read(tp, 0x01) == 0xb1) {
+		static const struct phy_reg phy_reg_init[] = {
+			{ 0x1f, 0x0002 },
+			{ 0x05, 0x669a },
+			{ 0x1f, 0x0005 },
+			{ 0x05, 0x8330 },
+			{ 0x06, 0x669a },
+
+			{ 0x1f, 0x0002 }
+		};
+		int val;
+
+		rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
+
+		val = rtl_readphy(tp, 0x0d);
+		if ((val & 0x00ff) != 0x006c) {
+			static const u32 set[] = {
+				0x0065, 0x0066, 0x0067, 0x0068,
+				0x0069, 0x006a, 0x006b, 0x006c
+			};
+			int i;
+
+			rtl_writephy(tp, 0x1f, 0x0002);
+
+			val &= 0xff00;
+			for (i = 0; i < ARRAY_SIZE(set); i++)
+				rtl_writephy(tp, 0x0d, val | set[i]);
+		}
+	} else {
+		static const struct phy_reg phy_reg_init[] = {
+			{ 0x1f, 0x0002 },
+			{ 0x05, 0x2642 },
+			{ 0x1f, 0x0005 },
+			{ 0x05, 0x8330 },
+			{ 0x06, 0x2642 }
+		};
+
+		rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
+	}
+
+	/* Fine tune PLL performance */
+	rtl_writephy(tp, 0x1f, 0x0002);
+	rtl_w0w1_phy(tp, 0x02, 0x0100, 0x0600);
+	rtl_w0w1_phy(tp, 0x03, 0x0000, 0xe000);
+
+	/* Switching regulator Slew rate */
+	rtl_writephy(tp, 0x1f, 0x0002);
+	rtl_patchphy(tp, 0x0f, 0x0017);
+
+	rtl_writephy(tp, 0x1f, 0x0005);
+	rtl_writephy(tp, 0x05, 0x001b);
+
+	rtl_apply_firmware_cond(tp, MII_EXPANSION, 0xb300);
+
+	rtl_writephy(tp, 0x1f, 0x0000);
+}
+
+static void rtl8168d_3_hw_phy_config(struct rtl8169_private *tp)
+{
+	static const struct phy_reg phy_reg_init[] = {
+		{ 0x1f, 0x0002 },
+		{ 0x10, 0x0008 },
+		{ 0x0d, 0x006c },
+
+		{ 0x1f, 0x0000 },
+		{ 0x0d, 0xf880 },
+
+		{ 0x1f, 0x0001 },
+		{ 0x17, 0x0cc0 },
+
+		{ 0x1f, 0x0001 },
+		{ 0x0b, 0xa4d8 },
+		{ 0x09, 0x281c },
+		{ 0x07, 0x2883 },
+		{ 0x0a, 0x6b35 },
+		{ 0x1d, 0x3da4 },
+		{ 0x1c, 0xeffd },
+		{ 0x14, 0x7f52 },
+		{ 0x18, 0x7fc6 },
+		{ 0x08, 0x0601 },
+		{ 0x06, 0x4063 },
+		{ 0x10, 0xf074 },
+		{ 0x1f, 0x0003 },
+		{ 0x13, 0x0789 },
+		{ 0x12, 0xf4bd },
+		{ 0x1a, 0x04fd },
+		{ 0x14, 0x84b0 },
+		{ 0x1f, 0x0000 },
+		{ 0x00, 0x9200 },
+
+		{ 0x1f, 0x0005 },
+		{ 0x01, 0x0340 },
+		{ 0x1f, 0x0001 },
+		{ 0x04, 0x4000 },
+		{ 0x03, 0x1d21 },
+		{ 0x02, 0x0c32 },
+		{ 0x01, 0x0200 },
+		{ 0x00, 0x5554 },
+		{ 0x04, 0x4800 },
+		{ 0x04, 0x4000 },
+		{ 0x04, 0xf000 },
+		{ 0x03, 0xdf01 },
+		{ 0x02, 0xdf20 },
+		{ 0x01, 0x101a },
+		{ 0x00, 0xa0ff },
+		{ 0x04, 0xf800 },
+		{ 0x04, 0xf000 },
+		{ 0x1f, 0x0000 },
+
+		{ 0x1f, 0x0007 },
+		{ 0x1e, 0x0023 },
+		{ 0x16, 0x0000 },
+		{ 0x1f, 0x0000 }
+	};
+
+	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
+}
+
+static void rtl8168d_4_hw_phy_config(struct rtl8169_private *tp)
+{
+	static const struct phy_reg phy_reg_init[] = {
+		{ 0x1f, 0x0001 },
+		{ 0x17, 0x0cc0 },
+
+		{ 0x1f, 0x0007 },
+		{ 0x1e, 0x002d },
+		{ 0x18, 0x0040 },
+		{ 0x1f, 0x0000 }
+	};
+
+	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
+	rtl_patchphy(tp, 0x0d, 1 << 5);
+}
+
+static void rtl8168e_1_hw_phy_config(struct rtl8169_private *tp)
+{
+	static const struct phy_reg phy_reg_init[] = {
+		/* Enable Delay cap */
+		{ 0x1f, 0x0005 },
+		{ 0x05, 0x8b80 },
+		{ 0x06, 0xc896 },
+		{ 0x1f, 0x0000 },
+
+		/* Channel estimation fine tune */
+		{ 0x1f, 0x0001 },
+		{ 0x0b, 0x6c20 },
+		{ 0x07, 0x2872 },
+		{ 0x1c, 0xefff },
+		{ 0x1f, 0x0003 },
+		{ 0x14, 0x6420 },
+		{ 0x1f, 0x0000 },
+
+		/* Update PFM & 10M TX idle timer */
+		{ 0x1f, 0x0007 },
+		{ 0x1e, 0x002f },
+		{ 0x15, 0x1919 },
+		{ 0x1f, 0x0000 },
+
+		{ 0x1f, 0x0007 },
+		{ 0x1e, 0x00ac },
+		{ 0x18, 0x0006 },
+		{ 0x1f, 0x0000 }
+	};
+
+	rtl_apply_firmware(tp);
+
+	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
+
+	/* DCO enable for 10M IDLE Power */
+	rtl_writephy(tp, 0x1f, 0x0007);
+	rtl_writephy(tp, 0x1e, 0x0023);
+	rtl_w0w1_phy(tp, 0x17, 0x0006, 0x0000);
+	rtl_writephy(tp, 0x1f, 0x0000);
+
+	/* For impedance matching */
+	rtl_writephy(tp, 0x1f, 0x0002);
+	rtl_w0w1_phy(tp, 0x08, 0x8000, 0x7f00);
+	rtl_writephy(tp, 0x1f, 0x0000);
+
+	/* PHY auto speed down */
+	rtl_writephy(tp, 0x1f, 0x0007);
+	rtl_writephy(tp, 0x1e, 0x002d);
+	rtl_w0w1_phy(tp, 0x18, 0x0050, 0x0000);
+	rtl_writephy(tp, 0x1f, 0x0000);
+	rtl_w0w1_phy(tp, 0x14, 0x8000, 0x0000);
+
+	rtl_writephy(tp, 0x1f, 0x0005);
+	rtl_writephy(tp, 0x05, 0x8b86);
+	rtl_w0w1_phy(tp, 0x06, 0x0001, 0x0000);
+	rtl_writephy(tp, 0x1f, 0x0000);
+
+	rtl_writephy(tp, 0x1f, 0x0005);
+	rtl_writephy(tp, 0x05, 0x8b85);
+	rtl_w0w1_phy(tp, 0x06, 0x0000, 0x2000);
+	rtl_writephy(tp, 0x1f, 0x0007);
+	rtl_writephy(tp, 0x1e, 0x0020);
+	rtl_w0w1_phy(tp, 0x15, 0x0000, 0x1100);
+	rtl_writephy(tp, 0x1f, 0x0006);
+	rtl_writephy(tp, 0x00, 0x5a00);
+	rtl_writephy(tp, 0x1f, 0x0000);
+	rtl_writephy(tp, 0x0d, 0x0007);
+	rtl_writephy(tp, 0x0e, 0x003c);
+	rtl_writephy(tp, 0x0d, 0x4007);
+	rtl_writephy(tp, 0x0e, 0x0000);
+	rtl_writephy(tp, 0x0d, 0x0000);
+}
+
+static void rtl_rar_exgmac_set(struct rtl8169_private *tp, u8 *addr)
+{
+	const u16 w[] = {
+		addr[0] | (addr[1] << 8),
+		addr[2] | (addr[3] << 8),
+		addr[4] | (addr[5] << 8)
+	};
+	const struct exgmac_reg e[] = {
+		{ .addr = 0xe0, ERIAR_MASK_1111, .val = w[0] | (w[1] << 16) },
+		{ .addr = 0xe4, ERIAR_MASK_1111, .val = w[2] },
+		{ .addr = 0xf0, ERIAR_MASK_1111, .val = w[0] << 16 },
+		{ .addr = 0xf4, ERIAR_MASK_1111, .val = w[1] | (w[2] << 16) }
+	};
+
+	rtl_write_exgmac_batch(tp, e, ARRAY_SIZE(e));
+}
+
+static void rtl8168e_2_hw_phy_config(struct rtl8169_private *tp)
+{
+	static const struct phy_reg phy_reg_init[] = {
+		/* Enable Delay cap */
+		{ 0x1f, 0x0004 },
+		{ 0x1f, 0x0007 },
+		{ 0x1e, 0x00ac },
+		{ 0x18, 0x0006 },
+		{ 0x1f, 0x0002 },
+		{ 0x1f, 0x0000 },
+		{ 0x1f, 0x0000 },
+
+		/* Channel estimation fine tune */
+		{ 0x1f, 0x0003 },
+		{ 0x09, 0xa20f },
+		{ 0x1f, 0x0000 },
+		{ 0x1f, 0x0000 },
+
+		/* Green Setting */
+		{ 0x1f, 0x0005 },
+		{ 0x05, 0x8b5b },
+		{ 0x06, 0x9222 },
+		{ 0x05, 0x8b6d },
+		{ 0x06, 0x8000 },
+		{ 0x05, 0x8b76 },
+		{ 0x06, 0x8000 },
+		{ 0x1f, 0x0000 }
+	};
+
+	rtl_apply_firmware(tp);
+
+	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
+
+	/* For 4-corner performance improve */
+	rtl_writephy(tp, 0x1f, 0x0005);
+	rtl_writephy(tp, 0x05, 0x8b80);
+	rtl_w0w1_phy(tp, 0x17, 0x0006, 0x0000);
+	rtl_writephy(tp, 0x1f, 0x0000);
+
+	/* PHY auto speed down */
+	rtl_writephy(tp, 0x1f, 0x0004);
+	rtl_writephy(tp, 0x1f, 0x0007);
+	rtl_writephy(tp, 0x1e, 0x002d);
+	rtl_w0w1_phy(tp, 0x18, 0x0010, 0x0000);
+	rtl_writephy(tp, 0x1f, 0x0002);
+	rtl_writephy(tp, 0x1f, 0x0000);
+	rtl_w0w1_phy(tp, 0x14, 0x8000, 0x0000);
+
+	/* improve 10M EEE waveform */
+	rtl_writephy(tp, 0x1f, 0x0005);
+	rtl_writephy(tp, 0x05, 0x8b86);
+	rtl_w0w1_phy(tp, 0x06, 0x0001, 0x0000);
+	rtl_writephy(tp, 0x1f, 0x0000);
+
+	/* Improve 2-pair detection performance */
+	rtl_writephy(tp, 0x1f, 0x0005);
+	rtl_writephy(tp, 0x05, 0x8b85);
+	rtl_w0w1_phy(tp, 0x06, 0x4000, 0x0000);
+	rtl_writephy(tp, 0x1f, 0x0000);
+
+	/* EEE setting */
+	rtl_w0w1_eri(tp, 0x1b0, ERIAR_MASK_1111, 0x0003, 0x0000, ERIAR_EXGMAC);
+	rtl_writephy(tp, 0x1f, 0x0005);
+	rtl_writephy(tp, 0x05, 0x8b85);
+	rtl_w0w1_phy(tp, 0x06, 0x2000, 0x0000);
+	rtl_writephy(tp, 0x1f, 0x0004);
+	rtl_writephy(tp, 0x1f, 0x0007);
+	rtl_writephy(tp, 0x1e, 0x0020);
+	rtl_w0w1_phy(tp, 0x15, 0x0100, 0x0000);
+	rtl_writephy(tp, 0x1f, 0x0002);
+	rtl_writephy(tp, 0x1f, 0x0000);
+	rtl_writephy(tp, 0x0d, 0x0007);
+	rtl_writephy(tp, 0x0e, 0x003c);
+	rtl_writephy(tp, 0x0d, 0x4007);
+	rtl_writephy(tp, 0x0e, 0x0006);
+	rtl_writephy(tp, 0x0d, 0x0000);
+
+	/* Green feature */
+	rtl_writephy(tp, 0x1f, 0x0003);
+	rtl_w0w1_phy(tp, 0x19, 0x0001, 0x0000);
+	rtl_w0w1_phy(tp, 0x10, 0x0400, 0x0000);
+	rtl_writephy(tp, 0x1f, 0x0000);
+	rtl_writephy(tp, 0x1f, 0x0005);
+	rtl_w0w1_phy(tp, 0x01, 0x0100, 0x0000);
+	rtl_writephy(tp, 0x1f, 0x0000);
+
+	/* Broken BIOS workaround: feed GigaMAC registers with MAC address. */
+	rtl_rar_exgmac_set(tp, tp->dev->dev_addr);
+}
+
+static void rtl8168f_hw_phy_config(struct rtl8169_private *tp)
+{
+	/* For 4-corner performance improve */
+	rtl_writephy(tp, 0x1f, 0x0005);
+	rtl_writephy(tp, 0x05, 0x8b80);
+	rtl_w0w1_phy(tp, 0x06, 0x0006, 0x0000);
+	rtl_writephy(tp, 0x1f, 0x0000);
+
+	/* PHY auto speed down */
+	rtl_writephy(tp, 0x1f, 0x0007);
+	rtl_writephy(tp, 0x1e, 0x002d);
+	rtl_w0w1_phy(tp, 0x18, 0x0010, 0x0000);
+	rtl_writephy(tp, 0x1f, 0x0000);
+	rtl_w0w1_phy(tp, 0x14, 0x8000, 0x0000);
+
+	/* Improve 10M EEE waveform */
+	rtl_writephy(tp, 0x1f, 0x0005);
+	rtl_writephy(tp, 0x05, 0x8b86);
+	rtl_w0w1_phy(tp, 0x06, 0x0001, 0x0000);
+	rtl_writephy(tp, 0x1f, 0x0000);
+}
+
+static void rtl8168f_1_hw_phy_config(struct rtl8169_private *tp)
+{
+	static const struct phy_reg phy_reg_init[] = {
+		/* Channel estimation fine tune */
+		{ 0x1f, 0x0003 },
+		{ 0x09, 0xa20f },
+		{ 0x1f, 0x0000 },
+
+		/* Modify green table for giga & fnet */
+		{ 0x1f, 0x0005 },
+		{ 0x05, 0x8b55 },
+		{ 0x06, 0x0000 },
+		{ 0x05, 0x8b5e },
+		{ 0x06, 0x0000 },
+		{ 0x05, 0x8b67 },
+		{ 0x06, 0x0000 },
+		{ 0x05, 0x8b70 },
+		{ 0x06, 0x0000 },
+		{ 0x1f, 0x0000 },
+		{ 0x1f, 0x0007 },
+		{ 0x1e, 0x0078 },
+		{ 0x17, 0x0000 },
+		{ 0x19, 0x00fb },
+		{ 0x1f, 0x0000 },
+
+		/* Modify green table for 10M */
+		{ 0x1f, 0x0005 },
+		{ 0x05, 0x8b79 },
+		{ 0x06, 0xaa00 },
+		{ 0x1f, 0x0000 },
+
+		/* Disable hiimpedance detection (RTCT) */
+		{ 0x1f, 0x0003 },
+		{ 0x01, 0x328a },
+		{ 0x1f, 0x0000 }
+	};
+
+	rtl_apply_firmware(tp);
+
+	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
+
+	rtl8168f_hw_phy_config(tp);
+
+	/* Improve 2-pair detection performance */
+	rtl_writephy(tp, 0x1f, 0x0005);
+	rtl_writephy(tp, 0x05, 0x8b85);
+	rtl_w0w1_phy(tp, 0x06, 0x4000, 0x0000);
+	rtl_writephy(tp, 0x1f, 0x0000);
+}
+
+static void rtl8168f_2_hw_phy_config(struct rtl8169_private *tp)
+{
+	rtl_apply_firmware(tp);
+
+	rtl8168f_hw_phy_config(tp);
+}
+
+static void rtl8411_hw_phy_config(struct rtl8169_private *tp)
+{
+	static const struct phy_reg phy_reg_init[] = {
+		/* Channel estimation fine tune */
+		{ 0x1f, 0x0003 },
+		{ 0x09, 0xa20f },
+		{ 0x1f, 0x0000 },
+
+		/* Modify green table for giga & fnet */
+		{ 0x1f, 0x0005 },
+		{ 0x05, 0x8b55 },
+		{ 0x06, 0x0000 },
+		{ 0x05, 0x8b5e },
+		{ 0x06, 0x0000 },
+		{ 0x05, 0x8b67 },
+		{ 0x06, 0x0000 },
+		{ 0x05, 0x8b70 },
+		{ 0x06, 0x0000 },
+		{ 0x1f, 0x0000 },
+		{ 0x1f, 0x0007 },
+		{ 0x1e, 0x0078 },
+		{ 0x17, 0x0000 },
+		{ 0x19, 0x00aa },
+		{ 0x1f, 0x0000 },
+
+		/* Modify green table for 10M */
+		{ 0x1f, 0x0005 },
+		{ 0x05, 0x8b79 },
+		{ 0x06, 0xaa00 },
+		{ 0x1f, 0x0000 },
+
+		/* Disable hiimpedance detection (RTCT) */
+		{ 0x1f, 0x0003 },
+		{ 0x01, 0x328a },
+		{ 0x1f, 0x0000 }
+	};
+
+
+	rtl_apply_firmware(tp);
+
+	rtl8168f_hw_phy_config(tp);
+
+	/* Improve 2-pair detection performance */
+	rtl_writephy(tp, 0x1f, 0x0005);
+	rtl_writephy(tp, 0x05, 0x8b85);
+	rtl_w0w1_phy(tp, 0x06, 0x4000, 0x0000);
+	rtl_writephy(tp, 0x1f, 0x0000);
+
+	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
+
+	/* Modify green table for giga */
+	rtl_writephy(tp, 0x1f, 0x0005);
+	rtl_writephy(tp, 0x05, 0x8b54);
+	rtl_w0w1_phy(tp, 0x06, 0x0000, 0x0800);
+	rtl_writephy(tp, 0x05, 0x8b5d);
+	rtl_w0w1_phy(tp, 0x06, 0x0000, 0x0800);
+	rtl_writephy(tp, 0x05, 0x8a7c);
+	rtl_w0w1_phy(tp, 0x06, 0x0000, 0x0100);
+	rtl_writephy(tp, 0x05, 0x8a7f);
+	rtl_w0w1_phy(tp, 0x06, 0x0100, 0x0000);
+	rtl_writephy(tp, 0x05, 0x8a82);
+	rtl_w0w1_phy(tp, 0x06, 0x0000, 0x0100);
+	rtl_writephy(tp, 0x05, 0x8a85);
+	rtl_w0w1_phy(tp, 0x06, 0x0000, 0x0100);
+	rtl_writephy(tp, 0x05, 0x8a88);
+	rtl_w0w1_phy(tp, 0x06, 0x0000, 0x0100);
+	rtl_writephy(tp, 0x1f, 0x0000);
+
+	/* uc same-seed solution */
+	rtl_writephy(tp, 0x1f, 0x0005);
+	rtl_writephy(tp, 0x05, 0x8b85);
+	rtl_w0w1_phy(tp, 0x06, 0x8000, 0x0000);
+	rtl_writephy(tp, 0x1f, 0x0000);
+
+	/* eee setting */
+	rtl_w0w1_eri(tp, 0x1b0, ERIAR_MASK_0001, 0x00, 0x03, ERIAR_EXGMAC);
+	rtl_writephy(tp, 0x1f, 0x0005);
+	rtl_writephy(tp, 0x05, 0x8b85);
+	rtl_w0w1_phy(tp, 0x06, 0x0000, 0x2000);
+	rtl_writephy(tp, 0x1f, 0x0004);
+	rtl_writephy(tp, 0x1f, 0x0007);
+	rtl_writephy(tp, 0x1e, 0x0020);
+	rtl_w0w1_phy(tp, 0x15, 0x0000, 0x0100);
+	rtl_writephy(tp, 0x1f, 0x0000);
+	rtl_writephy(tp, 0x0d, 0x0007);
+	rtl_writephy(tp, 0x0e, 0x003c);
+	rtl_writephy(tp, 0x0d, 0x4007);
+	rtl_writephy(tp, 0x0e, 0x0000);
+	rtl_writephy(tp, 0x0d, 0x0000);
+
+	/* Green feature */
+	rtl_writephy(tp, 0x1f, 0x0003);
+	rtl_w0w1_phy(tp, 0x19, 0x0000, 0x0001);
+	rtl_w0w1_phy(tp, 0x10, 0x0000, 0x0400);
+	rtl_writephy(tp, 0x1f, 0x0000);
+}
+
+static void rtl8168g_1_hw_phy_config(struct rtl8169_private *tp)
+{
+	rtl_apply_firmware(tp);
+
+	rtl_writephy(tp, 0x1f, 0x0a46);
+	if (rtl_readphy(tp, 0x10) & 0x0100) {
+		rtl_writephy(tp, 0x1f, 0x0bcc);
+		rtl_w0w1_phy(tp, 0x12, 0x0000, 0x8000);
+	} else {
+		rtl_writephy(tp, 0x1f, 0x0bcc);
+		rtl_w0w1_phy(tp, 0x12, 0x8000, 0x0000);
+	}
+
+	rtl_writephy(tp, 0x1f, 0x0a46);
+	if (rtl_readphy(tp, 0x13) & 0x0100) {
+		rtl_writephy(tp, 0x1f, 0x0c41);
+		rtl_w0w1_phy(tp, 0x15, 0x0002, 0x0000);
+	} else {
+		rtl_writephy(tp, 0x1f, 0x0c41);
+		rtl_w0w1_phy(tp, 0x15, 0x0000, 0x0002);
+	}
+
+	/* Enable PHY auto speed down */
+	rtl_writephy(tp, 0x1f, 0x0a44);
+	rtl_w0w1_phy(tp, 0x11, 0x000c, 0x0000);
+
+	rtl_writephy(tp, 0x1f, 0x0bcc);
+	rtl_w0w1_phy(tp, 0x14, 0x0100, 0x0000);
+	rtl_writephy(tp, 0x1f, 0x0a44);
+	rtl_w0w1_phy(tp, 0x11, 0x00c0, 0x0000);
+	rtl_writephy(tp, 0x1f, 0x0a43);
+	rtl_writephy(tp, 0x13, 0x8084);
+	rtl_w0w1_phy(tp, 0x14, 0x0000, 0x6000);
+	rtl_w0w1_phy(tp, 0x10, 0x1003, 0x0000);
+
+	/* EEE auto-fallback function */
+	rtl_writephy(tp, 0x1f, 0x0a4b);
+	rtl_w0w1_phy(tp, 0x11, 0x0004, 0x0000);
+
+	/* Enable UC LPF tune function */
+	rtl_writephy(tp, 0x1f, 0x0a43);
+	rtl_writephy(tp, 0x13, 0x8012);
+	rtl_w0w1_phy(tp, 0x14, 0x8000, 0x0000);
+
+	rtl_writephy(tp, 0x1f, 0x0c42);
+	rtl_w0w1_phy(tp, 0x11, 0x4000, 0x2000);
+
+	/* Improve SWR Efficiency */
+	rtl_writephy(tp, 0x1f, 0x0bcd);
+	rtl_writephy(tp, 0x14, 0x5065);
+	rtl_writephy(tp, 0x14, 0xd065);
+	rtl_writephy(tp, 0x1f, 0x0bc8);
+	rtl_writephy(tp, 0x11, 0x5655);
+	rtl_writephy(tp, 0x1f, 0x0bcd);
+	rtl_writephy(tp, 0x14, 0x1065);
+	rtl_writephy(tp, 0x14, 0x9065);
+	rtl_writephy(tp, 0x14, 0x1065);
+
+	/* Check ALDPS bit, disable it if enabled */
+	rtl_writephy(tp, 0x1f, 0x0a43);
+	if (rtl_readphy(tp, 0x10) & 0x0004)
+		rtl_w0w1_phy(tp, 0x10, 0x0000, 0x0004);
+
+	rtl_writephy(tp, 0x1f, 0x0000);
+}
+
+static void rtl8168g_2_hw_phy_config(struct rtl8169_private *tp)
+{
+	rtl_apply_firmware(tp);
+}
+
+static void rtl8168h_1_hw_phy_config(struct rtl8169_private *tp)
+{
+	u16 dout_tapbin;
+	u32 data;
+
+	rtl_apply_firmware(tp);
+
+	/* CHN EST parameters adjust - giga master */
+	rtl_writephy(tp, 0x1f, 0x0a43);
+	rtl_writephy(tp, 0x13, 0x809b);
+	rtl_w0w1_phy(tp, 0x14, 0x8000, 0xf800);
+	rtl_writephy(tp, 0x13, 0x80a2);
+	rtl_w0w1_phy(tp, 0x14, 0x8000, 0xff00);
+	rtl_writephy(tp, 0x13, 0x80a4);
+	rtl_w0w1_phy(tp, 0x14, 0x8500, 0xff00);
+	rtl_writephy(tp, 0x13, 0x809c);
+	rtl_w0w1_phy(tp, 0x14, 0xbd00, 0xff00);
+	rtl_writephy(tp, 0x1f, 0x0000);
+
+	/* CHN EST parameters adjust - giga slave */
+	rtl_writephy(tp, 0x1f, 0x0a43);
+	rtl_writephy(tp, 0x13, 0x80ad);
+	rtl_w0w1_phy(tp, 0x14, 0x7000, 0xf800);
+	rtl_writephy(tp, 0x13, 0x80b4);
+	rtl_w0w1_phy(tp, 0x14, 0x5000, 0xff00);
+	rtl_writephy(tp, 0x13, 0x80ac);
+	rtl_w0w1_phy(tp, 0x14, 0x4000, 0xff00);
+	rtl_writephy(tp, 0x1f, 0x0000);
+
+	/* CHN EST parameters adjust - fnet */
+	rtl_writephy(tp, 0x1f, 0x0a43);
+	rtl_writephy(tp, 0x13, 0x808e);
+	rtl_w0w1_phy(tp, 0x14, 0x1200, 0xff00);
+	rtl_writephy(tp, 0x13, 0x8090);
+	rtl_w0w1_phy(tp, 0x14, 0xe500, 0xff00);
+	rtl_writephy(tp, 0x13, 0x8092);
+	rtl_w0w1_phy(tp, 0x14, 0x9f00, 0xff00);
+	rtl_writephy(tp, 0x1f, 0x0000);
+
+	/* enable R-tune & PGA-retune function */
+	dout_tapbin = 0;
+	rtl_writephy(tp, 0x1f, 0x0a46);
+	data = rtl_readphy(tp, 0x13);
+	data &= 3;
+	data <<= 2;
+	dout_tapbin |= data;
+	data = rtl_readphy(tp, 0x12);
+	data &= 0xc000;
+	data >>= 14;
+	dout_tapbin |= data;
+	dout_tapbin = ~(dout_tapbin^0x08);
+	dout_tapbin <<= 12;
+	dout_tapbin &= 0xf000;
+	rtl_writephy(tp, 0x1f, 0x0a43);
+	rtl_writephy(tp, 0x13, 0x827a);
+	rtl_w0w1_phy(tp, 0x14, dout_tapbin, 0xf000);
+	rtl_writephy(tp, 0x13, 0x827b);
+	rtl_w0w1_phy(tp, 0x14, dout_tapbin, 0xf000);
+	rtl_writephy(tp, 0x13, 0x827c);
+	rtl_w0w1_phy(tp, 0x14, dout_tapbin, 0xf000);
+	rtl_writephy(tp, 0x13, 0x827d);
+	rtl_w0w1_phy(tp, 0x14, dout_tapbin, 0xf000);
+
+	rtl_writephy(tp, 0x1f, 0x0a43);
+	rtl_writephy(tp, 0x13, 0x0811);
+	rtl_w0w1_phy(tp, 0x14, 0x0800, 0x0000);
+	rtl_writephy(tp, 0x1f, 0x0a42);
+	rtl_w0w1_phy(tp, 0x16, 0x0002, 0x0000);
+	rtl_writephy(tp, 0x1f, 0x0000);
+
+	/* enable GPHY 10M */
+	rtl_writephy(tp, 0x1f, 0x0a44);
+	rtl_w0w1_phy(tp, 0x11, 0x0800, 0x0000);
+	rtl_writephy(tp, 0x1f, 0x0000);
+
+	/* SAR ADC performance */
+	rtl_writephy(tp, 0x1f, 0x0bca);
+	rtl_w0w1_phy(tp, 0x17, 0x4000, 0x3000);
+	rtl_writephy(tp, 0x1f, 0x0000);
+
+	rtl_writephy(tp, 0x1f, 0x0a43);
+	rtl_writephy(tp, 0x13, 0x803f);
+	rtl_w0w1_phy(tp, 0x14, 0x0000, 0x3000);
+	rtl_writephy(tp, 0x13, 0x8047);
+	rtl_w0w1_phy(tp, 0x14, 0x0000, 0x3000);
+	rtl_writephy(tp, 0x13, 0x804f);
+	rtl_w0w1_phy(tp, 0x14, 0x0000, 0x3000);
+	rtl_writephy(tp, 0x13, 0x8057);
+	rtl_w0w1_phy(tp, 0x14, 0x0000, 0x3000);
+	rtl_writephy(tp, 0x13, 0x805f);
+	rtl_w0w1_phy(tp, 0x14, 0x0000, 0x3000);
+	rtl_writephy(tp, 0x13, 0x8067);
+	rtl_w0w1_phy(tp, 0x14, 0x0000, 0x3000);
+	rtl_writephy(tp, 0x13, 0x806f);
+	rtl_w0w1_phy(tp, 0x14, 0x0000, 0x3000);
+	rtl_writephy(tp, 0x1f, 0x0000);
+
+	/* disable phy pfm mode */
+	rtl_writephy(tp, 0x1f, 0x0a44);
+	rtl_w0w1_phy(tp, 0x11, 0x0000, 0x0080);
+	rtl_writephy(tp, 0x1f, 0x0000);
+
+	/* Check ALDPS bit, disable it if enabled */
+	rtl_writephy(tp, 0x1f, 0x0a43);
+	if (rtl_readphy(tp, 0x10) & 0x0004)
+		rtl_w0w1_phy(tp, 0x10, 0x0000, 0x0004);
+
+	rtl_writephy(tp, 0x1f, 0x0000);
+}
+
+static void rtl8168h_2_hw_phy_config(struct rtl8169_private *tp)
+{
+	u16 ioffset_p3, ioffset_p2, ioffset_p1, ioffset_p0;
+	u16 rlen;
+	u32 data;
+
+	rtl_apply_firmware(tp);
+
+	/* CHIN EST parameter update */
+	rtl_writephy(tp, 0x1f, 0x0a43);
+	rtl_writephy(tp, 0x13, 0x808a);
+	rtl_w0w1_phy(tp, 0x14, 0x000a, 0x003f);
+	rtl_writephy(tp, 0x1f, 0x0000);
+
+	/* enable R-tune & PGA-retune function */
+	rtl_writephy(tp, 0x1f, 0x0a43);
+	rtl_writephy(tp, 0x13, 0x0811);
+	rtl_w0w1_phy(tp, 0x14, 0x0800, 0x0000);
+	rtl_writephy(tp, 0x1f, 0x0a42);
+	rtl_w0w1_phy(tp, 0x16, 0x0002, 0x0000);
+	rtl_writephy(tp, 0x1f, 0x0000);
+
+	/* enable GPHY 10M */
+	rtl_writephy(tp, 0x1f, 0x0a44);
+	rtl_w0w1_phy(tp, 0x11, 0x0800, 0x0000);
+	rtl_writephy(tp, 0x1f, 0x0000);
+
+	r8168_mac_ocp_write(tp, 0xdd02, 0x807d);
+	data = r8168_mac_ocp_read(tp, 0xdd02);
+	ioffset_p3 = ((data & 0x80)>>7);
+	ioffset_p3 <<= 3;
+
+	data = r8168_mac_ocp_read(tp, 0xdd00);
+	ioffset_p3 |= ((data & (0xe000))>>13);
+	ioffset_p2 = ((data & (0x1e00))>>9);
+	ioffset_p1 = ((data & (0x01e0))>>5);
+	ioffset_p0 = ((data & 0x0010)>>4);
+	ioffset_p0 <<= 3;
+	ioffset_p0 |= (data & (0x07));
+	data = (ioffset_p3<<12)|(ioffset_p2<<8)|(ioffset_p1<<4)|(ioffset_p0);
+
+	if ((ioffset_p3 != 0x0f) || (ioffset_p2 != 0x0f) ||
+	    (ioffset_p1 != 0x0f) || (ioffset_p0 != 0x0f)) {
+		rtl_writephy(tp, 0x1f, 0x0bcf);
+		rtl_writephy(tp, 0x16, data);
+		rtl_writephy(tp, 0x1f, 0x0000);
+	}
+
+	/* Modify rlen (TX LPF corner frequency) level */
+	rtl_writephy(tp, 0x1f, 0x0bcd);
+	data = rtl_readphy(tp, 0x16);
+	data &= 0x000f;
+	rlen = 0;
+	if (data > 3)
+		rlen = data - 3;
+	data = rlen | (rlen<<4) | (rlen<<8) | (rlen<<12);
+	rtl_writephy(tp, 0x17, data);
+	rtl_writephy(tp, 0x1f, 0x0bcd);
+	rtl_writephy(tp, 0x1f, 0x0000);
+
+	/* disable phy pfm mode */
+	rtl_writephy(tp, 0x1f, 0x0a44);
+	rtl_w0w1_phy(tp, 0x11, 0x0000, 0x0080);
+	rtl_writephy(tp, 0x1f, 0x0000);
+
+	/* Check ALDPS bit, disable it if enabled */
+	rtl_writephy(tp, 0x1f, 0x0a43);
+	if (rtl_readphy(tp, 0x10) & 0x0004)
+		rtl_w0w1_phy(tp, 0x10, 0x0000, 0x0004);
+
+	rtl_writephy(tp, 0x1f, 0x0000);
+}
+
+static void rtl8168ep_1_hw_phy_config(struct rtl8169_private *tp)
+{
+	/* Enable PHY auto speed down */
+	rtl_writephy(tp, 0x1f, 0x0a44);
+	rtl_w0w1_phy(tp, 0x11, 0x000c, 0x0000);
+	rtl_writephy(tp, 0x1f, 0x0000);
+
+	/* patch 10M & ALDPS */
+	rtl_writephy(tp, 0x1f, 0x0bcc);
+	rtl_w0w1_phy(tp, 0x14, 0x0000, 0x0100);
+	rtl_writephy(tp, 0x1f, 0x0a44);
+	rtl_w0w1_phy(tp, 0x11, 0x00c0, 0x0000);
+	rtl_writephy(tp, 0x1f, 0x0a43);
+	rtl_writephy(tp, 0x13, 0x8084);
+	rtl_w0w1_phy(tp, 0x14, 0x0000, 0x6000);
+	rtl_w0w1_phy(tp, 0x10, 0x1003, 0x0000);
+	rtl_writephy(tp, 0x1f, 0x0000);
+
+	/* Enable EEE auto-fallback function */
+	rtl_writephy(tp, 0x1f, 0x0a4b);
+	rtl_w0w1_phy(tp, 0x11, 0x0004, 0x0000);
+	rtl_writephy(tp, 0x1f, 0x0000);
+
+	/* Enable UC LPF tune function */
+	rtl_writephy(tp, 0x1f, 0x0a43);
+	rtl_writephy(tp, 0x13, 0x8012);
+	rtl_w0w1_phy(tp, 0x14, 0x8000, 0x0000);
+	rtl_writephy(tp, 0x1f, 0x0000);
+
+	/* set rg_sel_sdm_rate */
+	rtl_writephy(tp, 0x1f, 0x0c42);
+	rtl_w0w1_phy(tp, 0x11, 0x4000, 0x2000);
+	rtl_writephy(tp, 0x1f, 0x0000);
+
+	/* Check ALDPS bit, disable it if enabled */
+	rtl_writephy(tp, 0x1f, 0x0a43);
+	if (rtl_readphy(tp, 0x10) & 0x0004)
+		rtl_w0w1_phy(tp, 0x10, 0x0000, 0x0004);
+
+	rtl_writephy(tp, 0x1f, 0x0000);
+}
+
+static void rtl8168ep_2_hw_phy_config(struct rtl8169_private *tp)
+{
+	/* patch 10M & ALDPS */
+	rtl_writephy(tp, 0x1f, 0x0bcc);
+	rtl_w0w1_phy(tp, 0x14, 0x0000, 0x0100);
+	rtl_writephy(tp, 0x1f, 0x0a44);
+	rtl_w0w1_phy(tp, 0x11, 0x00c0, 0x0000);
+	rtl_writephy(tp, 0x1f, 0x0a43);
+	rtl_writephy(tp, 0x13, 0x8084);
+	rtl_w0w1_phy(tp, 0x14, 0x0000, 0x6000);
+	rtl_w0w1_phy(tp, 0x10, 0x1003, 0x0000);
+	rtl_writephy(tp, 0x1f, 0x0000);
+
+	/* Enable UC LPF tune function */
+	rtl_writephy(tp, 0x1f, 0x0a43);
+	rtl_writephy(tp, 0x13, 0x8012);
+	rtl_w0w1_phy(tp, 0x14, 0x8000, 0x0000);
+	rtl_writephy(tp, 0x1f, 0x0000);
+
+	/* Set rg_sel_sdm_rate */
+	rtl_writephy(tp, 0x1f, 0x0c42);
+	rtl_w0w1_phy(tp, 0x11, 0x4000, 0x2000);
+	rtl_writephy(tp, 0x1f, 0x0000);
+
+	/* Channel estimation parameters */
+	rtl_writephy(tp, 0x1f, 0x0a43);
+	rtl_writephy(tp, 0x13, 0x80f3);
+	rtl_w0w1_phy(tp, 0x14, 0x8b00, ~0x8bff);
+	rtl_writephy(tp, 0x13, 0x80f0);
+	rtl_w0w1_phy(tp, 0x14, 0x3a00, ~0x3aff);
+	rtl_writephy(tp, 0x13, 0x80ef);
+	rtl_w0w1_phy(tp, 0x14, 0x0500, ~0x05ff);
+	rtl_writephy(tp, 0x13, 0x80f6);
+	rtl_w0w1_phy(tp, 0x14, 0x6e00, ~0x6eff);
+	rtl_writephy(tp, 0x13, 0x80ec);
+	rtl_w0w1_phy(tp, 0x14, 0x6800, ~0x68ff);
+	rtl_writephy(tp, 0x13, 0x80ed);
+	rtl_w0w1_phy(tp, 0x14, 0x7c00, ~0x7cff);
+	rtl_writephy(tp, 0x13, 0x80f2);
+	rtl_w0w1_phy(tp, 0x14, 0xf400, ~0xf4ff);
+	rtl_writephy(tp, 0x13, 0x80f4);
+	rtl_w0w1_phy(tp, 0x14, 0x8500, ~0x85ff);
+	rtl_writephy(tp, 0x1f, 0x0a43);
+	rtl_writephy(tp, 0x13, 0x8110);
+	rtl_w0w1_phy(tp, 0x14, 0xa800, ~0xa8ff);
+	rtl_writephy(tp, 0x13, 0x810f);
+	rtl_w0w1_phy(tp, 0x14, 0x1d00, ~0x1dff);
+	rtl_writephy(tp, 0x13, 0x8111);
+	rtl_w0w1_phy(tp, 0x14, 0xf500, ~0xf5ff);
+	rtl_writephy(tp, 0x13, 0x8113);
+	rtl_w0w1_phy(tp, 0x14, 0x6100, ~0x61ff);
+	rtl_writephy(tp, 0x13, 0x8115);
+	rtl_w0w1_phy(tp, 0x14, 0x9200, ~0x92ff);
+	rtl_writephy(tp, 0x13, 0x810e);
+	rtl_w0w1_phy(tp, 0x14, 0x0400, ~0x04ff);
+	rtl_writephy(tp, 0x13, 0x810c);
+	rtl_w0w1_phy(tp, 0x14, 0x7c00, ~0x7cff);
+	rtl_writephy(tp, 0x13, 0x810b);
+	rtl_w0w1_phy(tp, 0x14, 0x5a00, ~0x5aff);
+	rtl_writephy(tp, 0x1f, 0x0a43);
+	rtl_writephy(tp, 0x13, 0x80d1);
+	rtl_w0w1_phy(tp, 0x14, 0xff00, ~0xffff);
+	rtl_writephy(tp, 0x13, 0x80cd);
+	rtl_w0w1_phy(tp, 0x14, 0x9e00, ~0x9eff);
+	rtl_writephy(tp, 0x13, 0x80d3);
+	rtl_w0w1_phy(tp, 0x14, 0x0e00, ~0x0eff);
+	rtl_writephy(tp, 0x13, 0x80d5);
+	rtl_w0w1_phy(tp, 0x14, 0xca00, ~0xcaff);
+	rtl_writephy(tp, 0x13, 0x80d7);
+	rtl_w0w1_phy(tp, 0x14, 0x8400, ~0x84ff);
+
+	/* Force PWM-mode */
+	rtl_writephy(tp, 0x1f, 0x0bcd);
+	rtl_writephy(tp, 0x14, 0x5065);
+	rtl_writephy(tp, 0x14, 0xd065);
+	rtl_writephy(tp, 0x1f, 0x0bc8);
+	rtl_writephy(tp, 0x12, 0x00ed);
+	rtl_writephy(tp, 0x1f, 0x0bcd);
+	rtl_writephy(tp, 0x14, 0x1065);
+	rtl_writephy(tp, 0x14, 0x9065);
+	rtl_writephy(tp, 0x14, 0x1065);
+	rtl_writephy(tp, 0x1f, 0x0000);
+
+	/* Check ALDPS bit, disable it if enabled */
+	rtl_writephy(tp, 0x1f, 0x0a43);
+	if (rtl_readphy(tp, 0x10) & 0x0004)
+		rtl_w0w1_phy(tp, 0x10, 0x0000, 0x0004);
+
+	rtl_writephy(tp, 0x1f, 0x0000);
+}
+
+static void rtl8102e_hw_phy_config(struct rtl8169_private *tp)
+{
+	static const struct phy_reg phy_reg_init[] = {
+		{ 0x1f, 0x0003 },
+		{ 0x08, 0x441d },
+		{ 0x01, 0x9100 },
+		{ 0x1f, 0x0000 }
+	};
+
+	rtl_writephy(tp, 0x1f, 0x0000);
+	rtl_patchphy(tp, 0x11, 1 << 12);
+	rtl_patchphy(tp, 0x19, 1 << 13);
+	rtl_patchphy(tp, 0x10, 1 << 15);
+
+	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
+}
+
+static void rtl8105e_hw_phy_config(struct rtl8169_private *tp)
+{
+	static const struct phy_reg phy_reg_init[] = {
+		{ 0x1f, 0x0005 },
+		{ 0x1a, 0x0000 },
+		{ 0x1f, 0x0000 },
+
+		{ 0x1f, 0x0004 },
+		{ 0x1c, 0x0000 },
+		{ 0x1f, 0x0000 },
+
+		{ 0x1f, 0x0001 },
+		{ 0x15, 0x7701 },
+		{ 0x1f, 0x0000 }
+	};
+
+	/* Disable ALDPS before ram code */
+	rtl_writephy(tp, 0x1f, 0x0000);
+	rtl_writephy(tp, 0x18, 0x0310);
+	msleep(100);
+
+	rtl_apply_firmware(tp);
+
+	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
+}
+
+static void rtl8402_hw_phy_config(struct rtl8169_private *tp)
+{
+	/* Disable ALDPS before setting firmware */
+	rtl_writephy(tp, 0x1f, 0x0000);
+	rtl_writephy(tp, 0x18, 0x0310);
+	msleep(20);
+
+	rtl_apply_firmware(tp);
+
+	/* EEE setting */
+	rtl_eri_write(tp, 0x1b0, ERIAR_MASK_0011, 0x0000, ERIAR_EXGMAC);
+	rtl_writephy(tp, 0x1f, 0x0004);
+	rtl_writephy(tp, 0x10, 0x401f);
+	rtl_writephy(tp, 0x19, 0x7030);
+	rtl_writephy(tp, 0x1f, 0x0000);
+}
+
+static void rtl8106e_hw_phy_config(struct rtl8169_private *tp)
+{
+	static const struct phy_reg phy_reg_init[] = {
+		{ 0x1f, 0x0004 },
+		{ 0x10, 0xc07f },
+		{ 0x19, 0x7030 },
+		{ 0x1f, 0x0000 }
+	};
+
+	/* Disable ALDPS before ram code */
+	rtl_writephy(tp, 0x1f, 0x0000);
+	rtl_writephy(tp, 0x18, 0x0310);
+	msleep(100);
+
+	rtl_apply_firmware(tp);
+
+	rtl_eri_write(tp, 0x1b0, ERIAR_MASK_0011, 0x0000, ERIAR_EXGMAC);
+	rtl_writephy_batch(tp, phy_reg_init, ARRAY_SIZE(phy_reg_init));
+
+	rtl_eri_write(tp, 0x1d0, ERIAR_MASK_0011, 0x0000, ERIAR_EXGMAC);
+}
+
+static void rtl_hw_phy_config(struct net_device *dev)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+
+	rtl8169_print_mac_version(tp);
+
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_01:
+		break;
+	case RTL_GIGA_MAC_VER_02:
+	case RTL_GIGA_MAC_VER_03:
+		rtl8169s_hw_phy_config(tp);
+		break;
+	case RTL_GIGA_MAC_VER_04:
+		rtl8169sb_hw_phy_config(tp);
+		break;
+	case RTL_GIGA_MAC_VER_05:
+		rtl8169scd_hw_phy_config(tp);
+		break;
+	case RTL_GIGA_MAC_VER_06:
+		rtl8169sce_hw_phy_config(tp);
+		break;
+	case RTL_GIGA_MAC_VER_07:
+	case RTL_GIGA_MAC_VER_08:
+	case RTL_GIGA_MAC_VER_09:
+		rtl8102e_hw_phy_config(tp);
+		break;
+	case RTL_GIGA_MAC_VER_11:
+		rtl8168bb_hw_phy_config(tp);
+		break;
+	case RTL_GIGA_MAC_VER_12:
+		rtl8168bef_hw_phy_config(tp);
+		break;
+	case RTL_GIGA_MAC_VER_17:
+		rtl8168bef_hw_phy_config(tp);
+		break;
+	case RTL_GIGA_MAC_VER_18:
+		rtl8168cp_1_hw_phy_config(tp);
+		break;
+	case RTL_GIGA_MAC_VER_19:
+		rtl8168c_1_hw_phy_config(tp);
+		break;
+	case RTL_GIGA_MAC_VER_20:
+		rtl8168c_2_hw_phy_config(tp);
+		break;
+	case RTL_GIGA_MAC_VER_21:
+		rtl8168c_3_hw_phy_config(tp);
+		break;
+	case RTL_GIGA_MAC_VER_22:
+		rtl8168c_4_hw_phy_config(tp);
+		break;
+	case RTL_GIGA_MAC_VER_23:
+	case RTL_GIGA_MAC_VER_24:
+		rtl8168cp_2_hw_phy_config(tp);
+		break;
+	case RTL_GIGA_MAC_VER_25:
+		rtl8168d_1_hw_phy_config(tp);
+		break;
+	case RTL_GIGA_MAC_VER_26:
+		rtl8168d_2_hw_phy_config(tp);
+		break;
+	case RTL_GIGA_MAC_VER_27:
+		rtl8168d_3_hw_phy_config(tp);
+		break;
+	case RTL_GIGA_MAC_VER_28:
+		rtl8168d_4_hw_phy_config(tp);
+		break;
+	case RTL_GIGA_MAC_VER_29:
+	case RTL_GIGA_MAC_VER_30:
+		rtl8105e_hw_phy_config(tp);
+		break;
+	case RTL_GIGA_MAC_VER_31:
+		/* None. */
+		break;
+	case RTL_GIGA_MAC_VER_32:
+	case RTL_GIGA_MAC_VER_33:
+		rtl8168e_1_hw_phy_config(tp);
+		break;
+	case RTL_GIGA_MAC_VER_34:
+		rtl8168e_2_hw_phy_config(tp);
+		break;
+	case RTL_GIGA_MAC_VER_35:
+		rtl8168f_1_hw_phy_config(tp);
+		break;
+	case RTL_GIGA_MAC_VER_36:
+		rtl8168f_2_hw_phy_config(tp);
+		break;
+
+	case RTL_GIGA_MAC_VER_37:
+		rtl8402_hw_phy_config(tp);
+		break;
+
+	case RTL_GIGA_MAC_VER_38:
+		rtl8411_hw_phy_config(tp);
+		break;
+
+	case RTL_GIGA_MAC_VER_39:
+		rtl8106e_hw_phy_config(tp);
+		break;
+
+	case RTL_GIGA_MAC_VER_40:
+		rtl8168g_1_hw_phy_config(tp);
+		break;
+	case RTL_GIGA_MAC_VER_42:
+	case RTL_GIGA_MAC_VER_43:
+	case RTL_GIGA_MAC_VER_44:
+		rtl8168g_2_hw_phy_config(tp);
+		break;
+	case RTL_GIGA_MAC_VER_45:
+	case RTL_GIGA_MAC_VER_47:
+		rtl8168h_1_hw_phy_config(tp);
+		break;
+	case RTL_GIGA_MAC_VER_46:
+	case RTL_GIGA_MAC_VER_48:
+		rtl8168h_2_hw_phy_config(tp);
+		break;
+
+	case RTL_GIGA_MAC_VER_49:
+		rtl8168ep_1_hw_phy_config(tp);
+		break;
+	case RTL_GIGA_MAC_VER_50:
+	case RTL_GIGA_MAC_VER_51:
+		rtl8168ep_2_hw_phy_config(tp);
+		break;
+
+	case RTL_GIGA_MAC_VER_41:
+	default:
+		break;
+	}
+}
+
+static void rtl_schedule_task(struct rtl8169_private *tp, enum rtl_flag flag)
+{
+	if (!test_and_set_bit(flag, tp->wk.flags))
+		schedule_work(&tp->wk.work);
+}
+
+static bool rtl_tbi_enabled(struct rtl8169_private *tp)
+{
+	return (tp->mac_version == RTL_GIGA_MAC_VER_01) &&
+	       (RTL_R8(tp, PHYstatus) & TBI_Enable);
+}
+
+static void rtl8169_init_phy(struct net_device *dev, struct rtl8169_private *tp)
+{
+	rtl_hw_phy_config(dev);
+
+	if (tp->mac_version <= RTL_GIGA_MAC_VER_06) {
+		netif_dbg(tp, drv, dev,
+			  "Set MAC Reg C+CR Offset 0x82h = 0x01h\n");
+		RTL_W8(tp, 0x82, 0x01);
+	}
+
+	pci_write_config_byte(tp->pci_dev, PCI_LATENCY_TIMER, 0x40);
+
+	if (tp->mac_version <= RTL_GIGA_MAC_VER_06)
+		pci_write_config_byte(tp->pci_dev, PCI_CACHE_LINE_SIZE, 0x08);
+
+	if (tp->mac_version == RTL_GIGA_MAC_VER_02) {
+		netif_dbg(tp, drv, dev,
+			  "Set MAC Reg C+CR Offset 0x82h = 0x01h\n");
+		RTL_W8(tp, 0x82, 0x01);
+		netif_dbg(tp, drv, dev,
+			  "Set PHY Reg 0x0bh = 0x00h\n");
+		rtl_writephy(tp, 0x0b, 0x0000); //w 0x0b 15 0 0
+	}
+
+	/* We may have called phy_speed_down before */
+	phy_speed_up(dev->phydev);
+
+	genphy_soft_reset(dev->phydev);
+
+	/* It was reported that several chips end up with 10MBit/Half on a
+	 * 1GBit link after resuming from S3. For whatever reason the PHY on
+	 * these chips doesn't properly start a renegotiation when soft-reset.
+	 * Explicitly requesting a renegotiation fixes this.
+	 */
+	if (dev->phydev->autoneg == AUTONEG_ENABLE)
+		phy_restart_aneg(dev->phydev);
+}
+
+static void rtl_rar_set(struct rtl8169_private *tp, u8 *addr)
+{
+	rtl_lock_work(tp);
+
+	RTL_W8(tp, Cfg9346, Cfg9346_Unlock);
+
+	RTL_W32(tp, MAC4, addr[4] | addr[5] << 8);
+	RTL_R32(tp, MAC4);
+
+	RTL_W32(tp, MAC0, addr[0] | addr[1] << 8 | addr[2] << 16 | addr[3] << 24);
+	RTL_R32(tp, MAC0);
+
+	if (tp->mac_version == RTL_GIGA_MAC_VER_34)
+		rtl_rar_exgmac_set(tp, addr);
+
+	RTL_W8(tp, Cfg9346, Cfg9346_Lock);
+
+	rtl_unlock_work(tp);
+}
+
+static void rtl_init_rxcfg(struct rtl8169_private *tp)
+{
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_01 ... RTL_GIGA_MAC_VER_06:
+	case RTL_GIGA_MAC_VER_10 ... RTL_GIGA_MAC_VER_17:
+		RTL_W32(tp, RxConfig, RX_FIFO_THRESH | RX_DMA_BURST);
+		break;
+	case RTL_GIGA_MAC_VER_18 ... RTL_GIGA_MAC_VER_24:
+	case RTL_GIGA_MAC_VER_34 ... RTL_GIGA_MAC_VER_36:
+	case RTL_GIGA_MAC_VER_38:
+		RTL_W32(tp, RxConfig, RX128_INT_EN | RX_MULTI_EN | RX_DMA_BURST);
+		break;
+	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_51:
+		RTL_W32(tp, RxConfig, RX128_INT_EN | RX_MULTI_EN | RX_DMA_BURST | RX_EARLY_OFF);
+		break;
+	default:
+		RTL_W32(tp, RxConfig, RX128_INT_EN | RX_DMA_BURST);
+		break;
+	}
+}
+
+static int rtl_set_mac_address(struct net_device *dev, void *p)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+	struct device *d = tp_to_dev(tp);
+	int ret;
+
+	ret = eth_mac_addr(dev, p);
+	if (ret)
+		return ret;
+
+	pm_runtime_get_noresume(d);
+
+	if (pm_runtime_active(d))
+		rtl_rar_set(tp, dev->dev_addr);
+
+	pm_runtime_put_noidle(d);
+
+	/* Reportedly at least Asus X453MA truncates packets otherwise */
+	if (tp->mac_version == RTL_GIGA_MAC_VER_37)
+		rtl_init_rxcfg(tp);
+
+	return 0;
+}
+
+static int rtl8169_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
+{
+	if (!netif_running(dev))
+		return -ENODEV;
+
+	return phy_mii_ioctl(dev->phydev, ifr, cmd);
+}
+
+static void rtl_init_mdio_ops(struct rtl8169_private *tp)
+{
+	struct mdio_ops *ops = &tp->mdio_ops;
+
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_27:
+		ops->write	= r8168dp_1_mdio_write;
+		ops->read	= r8168dp_1_mdio_read;
+		break;
+	case RTL_GIGA_MAC_VER_28:
+	case RTL_GIGA_MAC_VER_31:
+		ops->write	= r8168dp_2_mdio_write;
+		ops->read	= r8168dp_2_mdio_read;
+		break;
+	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_51:
+		ops->write	= r8168g_mdio_write;
+		ops->read	= r8168g_mdio_read;
+		break;
+	default:
+		ops->write	= r8169_mdio_write;
+		ops->read	= r8169_mdio_read;
+		break;
+	}
+}
+
+static void rtl_wol_suspend_quirk(struct rtl8169_private *tp)
+{
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_25:
+	case RTL_GIGA_MAC_VER_26:
+	case RTL_GIGA_MAC_VER_29:
+	case RTL_GIGA_MAC_VER_30:
+	case RTL_GIGA_MAC_VER_32:
+	case RTL_GIGA_MAC_VER_33:
+	case RTL_GIGA_MAC_VER_34:
+	case RTL_GIGA_MAC_VER_37 ... RTL_GIGA_MAC_VER_51:
+		RTL_W32(tp, RxConfig, RTL_R32(tp, RxConfig) |
+			AcceptBroadcast | AcceptMulticast | AcceptMyPhys);
+		break;
+	default:
+		break;
+	}
+}
+
+static bool rtl_wol_pll_power_down(struct rtl8169_private *tp)
+{
+	struct phy_device *phydev;
+
+	if (!__rtl8169_get_wol(tp))
+		return false;
+
+	/* phydev may not be attached to netdevice */
+	phydev = mdiobus_get_phy(tp->mii_bus, 0);
+
+	phy_speed_down(phydev, false);
+	rtl_wol_suspend_quirk(tp);
+
+	return true;
+}
+
+static void r8168_pll_power_down(struct rtl8169_private *tp)
+{
+	if (r8168_check_dash(tp))
+		return;
+
+	if (tp->mac_version == RTL_GIGA_MAC_VER_32 ||
+	    tp->mac_version == RTL_GIGA_MAC_VER_33)
+		rtl_ephy_write(tp, 0x19, 0xff64);
+
+	if (rtl_wol_pll_power_down(tp))
+		return;
+
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_25 ... RTL_GIGA_MAC_VER_26:
+	case RTL_GIGA_MAC_VER_29 ... RTL_GIGA_MAC_VER_30:
+	case RTL_GIGA_MAC_VER_32 ... RTL_GIGA_MAC_VER_33:
+	case RTL_GIGA_MAC_VER_37:
+	case RTL_GIGA_MAC_VER_39:
+	case RTL_GIGA_MAC_VER_43:
+	case RTL_GIGA_MAC_VER_44:
+	case RTL_GIGA_MAC_VER_45:
+	case RTL_GIGA_MAC_VER_46:
+	case RTL_GIGA_MAC_VER_47:
+	case RTL_GIGA_MAC_VER_48:
+	case RTL_GIGA_MAC_VER_50:
+	case RTL_GIGA_MAC_VER_51:
+		RTL_W8(tp, PMCH, RTL_R8(tp, PMCH) & ~0x80);
+		break;
+	case RTL_GIGA_MAC_VER_40:
+	case RTL_GIGA_MAC_VER_41:
+	case RTL_GIGA_MAC_VER_49:
+		rtl_w0w1_eri(tp, 0x1a8, ERIAR_MASK_1111, 0x00000000,
+			     0xfc000000, ERIAR_EXGMAC);
+		RTL_W8(tp, PMCH, RTL_R8(tp, PMCH) & ~0x80);
+		break;
+	}
+}
+
+static void r8168_pll_power_up(struct rtl8169_private *tp)
+{
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_25 ... RTL_GIGA_MAC_VER_26:
+	case RTL_GIGA_MAC_VER_29 ... RTL_GIGA_MAC_VER_30:
+	case RTL_GIGA_MAC_VER_32 ... RTL_GIGA_MAC_VER_33:
+	case RTL_GIGA_MAC_VER_37:
+	case RTL_GIGA_MAC_VER_39:
+	case RTL_GIGA_MAC_VER_43:
+		RTL_W8(tp, PMCH, RTL_R8(tp, PMCH) | 0x80);
+		break;
+	case RTL_GIGA_MAC_VER_44:
+	case RTL_GIGA_MAC_VER_45:
+	case RTL_GIGA_MAC_VER_46:
+	case RTL_GIGA_MAC_VER_47:
+	case RTL_GIGA_MAC_VER_48:
+	case RTL_GIGA_MAC_VER_50:
+	case RTL_GIGA_MAC_VER_51:
+		RTL_W8(tp, PMCH, RTL_R8(tp, PMCH) | 0xc0);
+		break;
+	case RTL_GIGA_MAC_VER_40:
+	case RTL_GIGA_MAC_VER_41:
+	case RTL_GIGA_MAC_VER_49:
+		RTL_W8(tp, PMCH, RTL_R8(tp, PMCH) | 0xc0);
+		rtl_w0w1_eri(tp, 0x1a8, ERIAR_MASK_1111, 0xfc000000,
+			     0x00000000, ERIAR_EXGMAC);
+		break;
+	}
+
+	phy_resume(tp->dev->phydev);
+	/* give MAC/PHY some time to resume */
+	msleep(20);
+}
+
+static void rtl_pll_power_down(struct rtl8169_private *tp)
+{
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_01 ... RTL_GIGA_MAC_VER_06:
+	case RTL_GIGA_MAC_VER_13 ... RTL_GIGA_MAC_VER_15:
+		break;
+	default:
+		r8168_pll_power_down(tp);
+	}
+}
+
+static void rtl_pll_power_up(struct rtl8169_private *tp)
+{
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_01 ... RTL_GIGA_MAC_VER_06:
+	case RTL_GIGA_MAC_VER_13 ... RTL_GIGA_MAC_VER_15:
+		break;
+	default:
+		r8168_pll_power_up(tp);
+	}
+}
+
+static void rtl8169_init_ring_indexes(struct rtl8169_private *tp)
+{
+	tp->dirty_tx = tp->cur_tx = tp->cur_rx = 0;
+}
+
+static void rtl_hw_jumbo_enable(struct rtl8169_private *tp)
+{
+	if (tp->jumbo_ops.enable) {
+		RTL_W8(tp, Cfg9346, Cfg9346_Unlock);
+		tp->jumbo_ops.enable(tp);
+		RTL_W8(tp, Cfg9346, Cfg9346_Lock);
+	}
+}
+
+static void rtl_hw_jumbo_disable(struct rtl8169_private *tp)
+{
+	if (tp->jumbo_ops.disable) {
+		RTL_W8(tp, Cfg9346, Cfg9346_Unlock);
+		tp->jumbo_ops.disable(tp);
+		RTL_W8(tp, Cfg9346, Cfg9346_Lock);
+	}
+}
+
+static void r8168c_hw_jumbo_enable(struct rtl8169_private *tp)
+{
+	RTL_W8(tp, Config3, RTL_R8(tp, Config3) | Jumbo_En0);
+	RTL_W8(tp, Config4, RTL_R8(tp, Config4) | Jumbo_En1);
+	rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_512B);
+}
+
+static void r8168c_hw_jumbo_disable(struct rtl8169_private *tp)
+{
+	RTL_W8(tp, Config3, RTL_R8(tp, Config3) & ~Jumbo_En0);
+	RTL_W8(tp, Config4, RTL_R8(tp, Config4) & ~Jumbo_En1);
+	rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
+}
+
+static void r8168dp_hw_jumbo_enable(struct rtl8169_private *tp)
+{
+	RTL_W8(tp, Config3, RTL_R8(tp, Config3) | Jumbo_En0);
+}
+
+static void r8168dp_hw_jumbo_disable(struct rtl8169_private *tp)
+{
+	RTL_W8(tp, Config3, RTL_R8(tp, Config3) & ~Jumbo_En0);
+}
+
+static void r8168e_hw_jumbo_enable(struct rtl8169_private *tp)
+{
+	RTL_W8(tp, MaxTxPacketSize, 0x24);
+	RTL_W8(tp, Config3, RTL_R8(tp, Config3) | Jumbo_En0);
+	RTL_W8(tp, Config4, RTL_R8(tp, Config4) | 0x01);
+	rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_512B);
+}
+
+static void r8168e_hw_jumbo_disable(struct rtl8169_private *tp)
+{
+	RTL_W8(tp, MaxTxPacketSize, 0x3f);
+	RTL_W8(tp, Config3, RTL_R8(tp, Config3) & ~Jumbo_En0);
+	RTL_W8(tp, Config4, RTL_R8(tp, Config4) & ~0x01);
+	rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
+}
+
+static void r8168b_0_hw_jumbo_enable(struct rtl8169_private *tp)
+{
+	rtl_tx_performance_tweak(tp,
+		PCI_EXP_DEVCTL_READRQ_512B | PCI_EXP_DEVCTL_NOSNOOP_EN);
+}
+
+static void r8168b_0_hw_jumbo_disable(struct rtl8169_private *tp)
+{
+	rtl_tx_performance_tweak(tp,
+		PCI_EXP_DEVCTL_READRQ_4096B | PCI_EXP_DEVCTL_NOSNOOP_EN);
+}
+
+static void r8168b_1_hw_jumbo_enable(struct rtl8169_private *tp)
+{
+	r8168b_0_hw_jumbo_enable(tp);
+
+	RTL_W8(tp, Config4, RTL_R8(tp, Config4) | (1 << 0));
+}
+
+static void r8168b_1_hw_jumbo_disable(struct rtl8169_private *tp)
+{
+	r8168b_0_hw_jumbo_disable(tp);
+
+	RTL_W8(tp, Config4, RTL_R8(tp, Config4) & ~(1 << 0));
+}
+
+static void rtl_init_jumbo_ops(struct rtl8169_private *tp)
+{
+	struct jumbo_ops *ops = &tp->jumbo_ops;
+
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_11:
+		ops->disable	= r8168b_0_hw_jumbo_disable;
+		ops->enable	= r8168b_0_hw_jumbo_enable;
+		break;
+	case RTL_GIGA_MAC_VER_12:
+	case RTL_GIGA_MAC_VER_17:
+		ops->disable	= r8168b_1_hw_jumbo_disable;
+		ops->enable	= r8168b_1_hw_jumbo_enable;
+		break;
+	case RTL_GIGA_MAC_VER_18: /* Wild guess. Needs info from Realtek. */
+	case RTL_GIGA_MAC_VER_19:
+	case RTL_GIGA_MAC_VER_20:
+	case RTL_GIGA_MAC_VER_21: /* Wild guess. Needs info from Realtek. */
+	case RTL_GIGA_MAC_VER_22:
+	case RTL_GIGA_MAC_VER_23:
+	case RTL_GIGA_MAC_VER_24:
+	case RTL_GIGA_MAC_VER_25:
+	case RTL_GIGA_MAC_VER_26:
+		ops->disable	= r8168c_hw_jumbo_disable;
+		ops->enable	= r8168c_hw_jumbo_enable;
+		break;
+	case RTL_GIGA_MAC_VER_27:
+	case RTL_GIGA_MAC_VER_28:
+		ops->disable	= r8168dp_hw_jumbo_disable;
+		ops->enable	= r8168dp_hw_jumbo_enable;
+		break;
+	case RTL_GIGA_MAC_VER_31: /* Wild guess. Needs info from Realtek. */
+	case RTL_GIGA_MAC_VER_32:
+	case RTL_GIGA_MAC_VER_33:
+	case RTL_GIGA_MAC_VER_34:
+		ops->disable	= r8168e_hw_jumbo_disable;
+		ops->enable	= r8168e_hw_jumbo_enable;
+		break;
+
+	/*
+	 * No action needed for jumbo frames with 8169.
+	 * No jumbo for 810x at all.
+	 */
+	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_51:
+	default:
+		ops->disable	= NULL;
+		ops->enable	= NULL;
+		break;
+	}
+}
+
+DECLARE_RTL_COND(rtl_chipcmd_cond)
+{
+	return RTL_R8(tp, ChipCmd) & CmdReset;
+}
+
+static void rtl_hw_reset(struct rtl8169_private *tp)
+{
+	RTL_W8(tp, ChipCmd, CmdReset);
+
+	rtl_udelay_loop_wait_low(tp, &rtl_chipcmd_cond, 100, 100);
+}
+
+static void rtl_request_uncached_firmware(struct rtl8169_private *tp)
+{
+	struct rtl_fw *rtl_fw;
+	const char *name;
+	int rc = -ENOMEM;
+
+	name = rtl_lookup_firmware_name(tp);
+	if (!name)
+		goto out_no_firmware;
+
+	rtl_fw = kzalloc(sizeof(*rtl_fw), GFP_KERNEL);
+	if (!rtl_fw)
+		goto err_warn;
+
+	rc = request_firmware(&rtl_fw->fw, name, tp_to_dev(tp));
+	if (rc < 0)
+		goto err_free;
+
+	rc = rtl_check_firmware(tp, rtl_fw);
+	if (rc < 0)
+		goto err_release_firmware;
+
+	tp->rtl_fw = rtl_fw;
+out:
+	return;
+
+err_release_firmware:
+	release_firmware(rtl_fw->fw);
+err_free:
+	kfree(rtl_fw);
+err_warn:
+	netif_warn(tp, ifup, tp->dev, "unable to load firmware patch %s (%d)\n",
+		   name, rc);
+out_no_firmware:
+	tp->rtl_fw = NULL;
+	goto out;
+}
+
+static void rtl_request_firmware(struct rtl8169_private *tp)
+{
+	if (IS_ERR(tp->rtl_fw))
+		rtl_request_uncached_firmware(tp);
+}
+
+static void rtl_rx_close(struct rtl8169_private *tp)
+{
+	RTL_W32(tp, RxConfig, RTL_R32(tp, RxConfig) & ~RX_CONFIG_ACCEPT_MASK);
+}
+
+DECLARE_RTL_COND(rtl_npq_cond)
+{
+	return RTL_R8(tp, TxPoll) & NPQ;
+}
+
+DECLARE_RTL_COND(rtl_txcfg_empty_cond)
+{
+	return RTL_R32(tp, TxConfig) & TXCFG_EMPTY;
+}
+
+static void rtl8169_hw_reset(struct rtl8169_private *tp)
+{
+	/* Disable interrupts */
+	rtl8169_irq_mask_and_ack(tp);
+
+	rtl_rx_close(tp);
+
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_27:
+	case RTL_GIGA_MAC_VER_28:
+	case RTL_GIGA_MAC_VER_31:
+		rtl_udelay_loop_wait_low(tp, &rtl_npq_cond, 20, 42*42);
+		break;
+	case RTL_GIGA_MAC_VER_34 ... RTL_GIGA_MAC_VER_38:
+	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_51:
+		RTL_W8(tp, ChipCmd, RTL_R8(tp, ChipCmd) | StopReq);
+		rtl_udelay_loop_wait_high(tp, &rtl_txcfg_empty_cond, 100, 666);
+		break;
+	default:
+		RTL_W8(tp, ChipCmd, RTL_R8(tp, ChipCmd) | StopReq);
+		udelay(100);
+		break;
+	}
+
+	rtl_hw_reset(tp);
+}
+
+static void rtl_set_tx_config_registers(struct rtl8169_private *tp)
+{
+	u32 val = TX_DMA_BURST << TxDMAShift |
+		  InterFrameGap << TxInterFrameGapShift;
+
+	if (tp->mac_version >= RTL_GIGA_MAC_VER_34 &&
+	    tp->mac_version != RTL_GIGA_MAC_VER_39)
+		val |= TXCFG_AUTO_FIFO;
+
+	RTL_W32(tp, TxConfig, val);
+}
+
+static void rtl_set_rx_max_size(struct rtl8169_private *tp)
+{
+	/* Low hurts. Let's disable the filtering. */
+	RTL_W16(tp, RxMaxSize, R8169_RX_BUF_SIZE + 1);
+}
+
+static void rtl_set_rx_tx_desc_registers(struct rtl8169_private *tp)
+{
+	/*
+	 * Magic spell: some iop3xx ARM board needs the TxDescAddrHigh
+	 * register to be written before TxDescAddrLow to work.
+	 * Switching from MMIO to I/O access fixes the issue as well.
+	 */
+	RTL_W32(tp, TxDescStartAddrHigh, ((u64) tp->TxPhyAddr) >> 32);
+	RTL_W32(tp, TxDescStartAddrLow, ((u64) tp->TxPhyAddr) & DMA_BIT_MASK(32));
+	RTL_W32(tp, RxDescAddrHigh, ((u64) tp->RxPhyAddr) >> 32);
+	RTL_W32(tp, RxDescAddrLow, ((u64) tp->RxPhyAddr) & DMA_BIT_MASK(32));
+}
+
+static void rtl8169_set_magic_reg(struct rtl8169_private *tp, unsigned mac_version)
+{
+	static const struct rtl_cfg2_info {
+		u32 mac_version;
+		u32 clk;
+		u32 val;
+	} cfg2_info [] = {
+		{ RTL_GIGA_MAC_VER_05, PCI_Clock_33MHz, 0x000fff00 }, // 8110SCd
+		{ RTL_GIGA_MAC_VER_05, PCI_Clock_66MHz, 0x000fffff },
+		{ RTL_GIGA_MAC_VER_06, PCI_Clock_33MHz, 0x00ffff00 }, // 8110SCe
+		{ RTL_GIGA_MAC_VER_06, PCI_Clock_66MHz, 0x00ffffff }
+	};
+	const struct rtl_cfg2_info *p = cfg2_info;
+	unsigned int i;
+	u32 clk;
+
+	clk = RTL_R8(tp, Config2) & PCI_Clock_66MHz;
+	for (i = 0; i < ARRAY_SIZE(cfg2_info); i++, p++) {
+		if ((p->mac_version == mac_version) && (p->clk == clk)) {
+			RTL_W32(tp, 0x7c, p->val);
+			break;
+		}
+	}
+}
+
+static void rtl_set_rx_mode(struct net_device *dev)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+	u32 mc_filter[2];	/* Multicast hash filter */
+	int rx_mode;
+	u32 tmp = 0;
+
+	if (dev->flags & IFF_PROMISC) {
+		/* Unconditionally log net taps. */
+		netif_notice(tp, link, dev, "Promiscuous mode enabled\n");
+		rx_mode =
+		    AcceptBroadcast | AcceptMulticast | AcceptMyPhys |
+		    AcceptAllPhys;
+		mc_filter[1] = mc_filter[0] = 0xffffffff;
+	} else if ((netdev_mc_count(dev) > multicast_filter_limit) ||
+		   (dev->flags & IFF_ALLMULTI)) {
+		/* Too many to filter perfectly -- accept all multicasts. */
+		rx_mode = AcceptBroadcast | AcceptMulticast | AcceptMyPhys;
+		mc_filter[1] = mc_filter[0] = 0xffffffff;
+	} else {
+		struct netdev_hw_addr *ha;
+
+		rx_mode = AcceptBroadcast | AcceptMyPhys;
+		mc_filter[1] = mc_filter[0] = 0;
+		netdev_for_each_mc_addr(ha, dev) {
+			int bit_nr = ether_crc(ETH_ALEN, ha->addr) >> 26;
+			mc_filter[bit_nr >> 5] |= 1 << (bit_nr & 31);
+			rx_mode |= AcceptMulticast;
+		}
+	}
+
+	if (dev->features & NETIF_F_RXALL)
+		rx_mode |= (AcceptErr | AcceptRunt);
+
+	tmp = (RTL_R32(tp, RxConfig) & ~RX_CONFIG_ACCEPT_MASK) | rx_mode;
+
+	if (tp->mac_version > RTL_GIGA_MAC_VER_06) {
+		u32 data = mc_filter[0];
+
+		mc_filter[0] = swab32(mc_filter[1]);
+		mc_filter[1] = swab32(data);
+	}
+
+	if (tp->mac_version == RTL_GIGA_MAC_VER_35)
+		mc_filter[1] = mc_filter[0] = 0xffffffff;
+
+	RTL_W32(tp, MAR0 + 4, mc_filter[1]);
+	RTL_W32(tp, MAR0 + 0, mc_filter[0]);
+
+	RTL_W32(tp, RxConfig, tmp);
+}
+
+static void rtl_hw_start(struct  rtl8169_private *tp)
+{
+	RTL_W8(tp, Cfg9346, Cfg9346_Unlock);
+
+	tp->hw_start(tp);
+
+	rtl_set_rx_max_size(tp);
+	rtl_set_rx_tx_desc_registers(tp);
+	RTL_W8(tp, Cfg9346, Cfg9346_Lock);
+
+	/* Initially a 10 us delay. Turned it into a PCI commit. - FR */
+	RTL_R8(tp, IntrMask);
+	RTL_W8(tp, ChipCmd, CmdTxEnb | CmdRxEnb);
+	rtl_init_rxcfg(tp);
+	rtl_set_tx_config_registers(tp);
+
+	rtl_set_rx_mode(tp->dev);
+	/* no early-rx interrupts */
+	RTL_W16(tp, MultiIntr, RTL_R16(tp, MultiIntr) & 0xf000);
+	rtl_irq_enable_all(tp);
+}
+
+static void rtl_hw_start_8169(struct rtl8169_private *tp)
+{
+	if (tp->mac_version == RTL_GIGA_MAC_VER_05)
+		pci_write_config_byte(tp->pci_dev, PCI_CACHE_LINE_SIZE, 0x08);
+
+	RTL_W8(tp, EarlyTxThres, NoEarlyTx);
+
+	tp->cp_cmd |= PCIMulRW;
+
+	if (tp->mac_version == RTL_GIGA_MAC_VER_02 ||
+	    tp->mac_version == RTL_GIGA_MAC_VER_03) {
+		netif_dbg(tp, drv, tp->dev,
+			  "Set MAC Reg C+CR Offset 0xe0. Bit 3 and Bit 14 MUST be 1\n");
+		tp->cp_cmd |= (1 << 14);
+	}
+
+	RTL_W16(tp, CPlusCmd, tp->cp_cmd);
+
+	rtl8169_set_magic_reg(tp, tp->mac_version);
+
+	/*
+	 * Undocumented corner. Supposedly:
+	 * (TxTimer << 12) | (TxPackets << 8) | (RxTimer << 4) | RxPackets
+	 */
+	RTL_W16(tp, IntrMitigate, 0x0000);
+
+	RTL_W32(tp, RxMissed, 0);
+}
+
+DECLARE_RTL_COND(rtl_csiar_cond)
+{
+	return RTL_R32(tp, CSIAR) & CSIAR_FLAG;
+}
+
+static void rtl_csi_write(struct rtl8169_private *tp, int addr, int value)
+{
+	u32 func = PCI_FUNC(tp->pci_dev->devfn);
+
+	RTL_W32(tp, CSIDR, value);
+	RTL_W32(tp, CSIAR, CSIAR_WRITE_CMD | (addr & CSIAR_ADDR_MASK) |
+		CSIAR_BYTE_ENABLE | func << 16);
+
+	rtl_udelay_loop_wait_low(tp, &rtl_csiar_cond, 10, 100);
+}
+
+static u32 rtl_csi_read(struct rtl8169_private *tp, int addr)
+{
+	u32 func = PCI_FUNC(tp->pci_dev->devfn);
+
+	RTL_W32(tp, CSIAR, (addr & CSIAR_ADDR_MASK) | func << 16 |
+		CSIAR_BYTE_ENABLE);
+
+	return rtl_udelay_loop_wait_high(tp, &rtl_csiar_cond, 10, 100) ?
+		RTL_R32(tp, CSIDR) : ~0;
+}
+
+static void rtl_csi_access_enable(struct rtl8169_private *tp, u8 val)
+{
+	struct pci_dev *pdev = tp->pci_dev;
+	u32 csi;
+
+	/* According to Realtek the value at config space address 0x070f
+	 * controls the L0s/L1 entrance latency. We try standard ECAM access
+	 * first and if it fails fall back to CSI.
+	 */
+	if (pdev->cfg_size > 0x070f &&
+	    pci_write_config_byte(pdev, 0x070f, val) == PCIBIOS_SUCCESSFUL)
+		return;
+
+	netdev_notice_once(tp->dev,
+		"No native access to PCI extended config space, falling back to CSI\n");
+	csi = rtl_csi_read(tp, 0x070c) & 0x00ffffff;
+	rtl_csi_write(tp, 0x070c, csi | val << 24);
+}
+
+static void rtl_set_def_aspm_entry_latency(struct rtl8169_private *tp)
+{
+	rtl_csi_access_enable(tp, 0x27);
+}
+
+struct ephy_info {
+	unsigned int offset;
+	u16 mask;
+	u16 bits;
+};
+
+static void rtl_ephy_init(struct rtl8169_private *tp, const struct ephy_info *e,
+			  int len)
+{
+	u16 w;
+
+	while (len-- > 0) {
+		w = (rtl_ephy_read(tp, e->offset) & ~e->mask) | e->bits;
+		rtl_ephy_write(tp, e->offset, w);
+		e++;
+	}
+}
+
+static void rtl_disable_clock_request(struct rtl8169_private *tp)
+{
+	pcie_capability_clear_word(tp->pci_dev, PCI_EXP_LNKCTL,
+				   PCI_EXP_LNKCTL_CLKREQ_EN);
+}
+
+static void rtl_enable_clock_request(struct rtl8169_private *tp)
+{
+	pcie_capability_set_word(tp->pci_dev, PCI_EXP_LNKCTL,
+				 PCI_EXP_LNKCTL_CLKREQ_EN);
+}
+
+static void rtl_pcie_state_l2l3_enable(struct rtl8169_private *tp, bool enable)
+{
+	u8 data;
+
+	data = RTL_R8(tp, Config3);
+
+	if (enable)
+		data |= Rdy_to_L23;
+	else
+		data &= ~Rdy_to_L23;
+
+	RTL_W8(tp, Config3, data);
+}
+
+static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
+{
+	if (enable) {
+		RTL_W8(tp, Config5, RTL_R8(tp, Config5) | ASPM_en);
+		RTL_W8(tp, Config2, RTL_R8(tp, Config2) | ClkReqEn);
+	} else {
+		RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
+		RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
+	}
+
+	udelay(10);
+}
+
+static void rtl_hw_start_8168bb(struct rtl8169_private *tp)
+{
+	RTL_W8(tp, Config3, RTL_R8(tp, Config3) & ~Beacon_en);
+
+	tp->cp_cmd &= CPCMD_QUIRK_MASK;
+	RTL_W16(tp, CPlusCmd, tp->cp_cmd);
+
+	if (tp->dev->mtu <= ETH_DATA_LEN) {
+		rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B |
+					 PCI_EXP_DEVCTL_NOSNOOP_EN);
+	}
+}
+
+static void rtl_hw_start_8168bef(struct rtl8169_private *tp)
+{
+	rtl_hw_start_8168bb(tp);
+
+	RTL_W8(tp, MaxTxPacketSize, TxPacketMax);
+
+	RTL_W8(tp, Config4, RTL_R8(tp, Config4) & ~(1 << 0));
+}
+
+static void __rtl_hw_start_8168cp(struct rtl8169_private *tp)
+{
+	RTL_W8(tp, Config1, RTL_R8(tp, Config1) | Speed_down);
+
+	RTL_W8(tp, Config3, RTL_R8(tp, Config3) & ~Beacon_en);
+
+	if (tp->dev->mtu <= ETH_DATA_LEN)
+		rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
+
+	rtl_disable_clock_request(tp);
+
+	tp->cp_cmd &= CPCMD_QUIRK_MASK;
+	RTL_W16(tp, CPlusCmd, tp->cp_cmd);
+}
+
+static void rtl_hw_start_8168cp_1(struct rtl8169_private *tp)
+{
+	static const struct ephy_info e_info_8168cp[] = {
+		{ 0x01, 0,	0x0001 },
+		{ 0x02, 0x0800,	0x1000 },
+		{ 0x03, 0,	0x0042 },
+		{ 0x06, 0x0080,	0x0000 },
+		{ 0x07, 0,	0x2000 }
+	};
+
+	rtl_set_def_aspm_entry_latency(tp);
+
+	rtl_ephy_init(tp, e_info_8168cp, ARRAY_SIZE(e_info_8168cp));
+
+	__rtl_hw_start_8168cp(tp);
+}
+
+static void rtl_hw_start_8168cp_2(struct rtl8169_private *tp)
+{
+	rtl_set_def_aspm_entry_latency(tp);
+
+	RTL_W8(tp, Config3, RTL_R8(tp, Config3) & ~Beacon_en);
+
+	if (tp->dev->mtu <= ETH_DATA_LEN)
+		rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
+
+	tp->cp_cmd &= CPCMD_QUIRK_MASK;
+	RTL_W16(tp, CPlusCmd, tp->cp_cmd);
+}
+
+static void rtl_hw_start_8168cp_3(struct rtl8169_private *tp)
+{
+	rtl_set_def_aspm_entry_latency(tp);
+
+	RTL_W8(tp, Config3, RTL_R8(tp, Config3) & ~Beacon_en);
+
+	/* Magic. */
+	RTL_W8(tp, DBG_REG, 0x20);
+
+	RTL_W8(tp, MaxTxPacketSize, TxPacketMax);
+
+	if (tp->dev->mtu <= ETH_DATA_LEN)
+		rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
+
+	tp->cp_cmd &= CPCMD_QUIRK_MASK;
+	RTL_W16(tp, CPlusCmd, tp->cp_cmd);
+}
+
+static void rtl_hw_start_8168c_1(struct rtl8169_private *tp)
+{
+	static const struct ephy_info e_info_8168c_1[] = {
+		{ 0x02, 0x0800,	0x1000 },
+		{ 0x03, 0,	0x0002 },
+		{ 0x06, 0x0080,	0x0000 }
+	};
+
+	rtl_set_def_aspm_entry_latency(tp);
+
+	RTL_W8(tp, DBG_REG, 0x06 | FIX_NAK_1 | FIX_NAK_2);
+
+	rtl_ephy_init(tp, e_info_8168c_1, ARRAY_SIZE(e_info_8168c_1));
+
+	__rtl_hw_start_8168cp(tp);
+}
+
+static void rtl_hw_start_8168c_2(struct rtl8169_private *tp)
+{
+	static const struct ephy_info e_info_8168c_2[] = {
+		{ 0x01, 0,	0x0001 },
+		{ 0x03, 0x0400,	0x0220 }
+	};
+
+	rtl_set_def_aspm_entry_latency(tp);
+
+	rtl_ephy_init(tp, e_info_8168c_2, ARRAY_SIZE(e_info_8168c_2));
+
+	__rtl_hw_start_8168cp(tp);
+}
+
+static void rtl_hw_start_8168c_3(struct rtl8169_private *tp)
+{
+	rtl_hw_start_8168c_2(tp);
+}
+
+static void rtl_hw_start_8168c_4(struct rtl8169_private *tp)
+{
+	rtl_set_def_aspm_entry_latency(tp);
+
+	__rtl_hw_start_8168cp(tp);
+}
+
+static void rtl_hw_start_8168d(struct rtl8169_private *tp)
+{
+	rtl_set_def_aspm_entry_latency(tp);
+
+	rtl_disable_clock_request(tp);
+
+	RTL_W8(tp, MaxTxPacketSize, TxPacketMax);
+
+	if (tp->dev->mtu <= ETH_DATA_LEN)
+		rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
+
+	tp->cp_cmd &= CPCMD_QUIRK_MASK;
+	RTL_W16(tp, CPlusCmd, tp->cp_cmd);
+}
+
+static void rtl_hw_start_8168dp(struct rtl8169_private *tp)
+{
+	rtl_set_def_aspm_entry_latency(tp);
+
+	if (tp->dev->mtu <= ETH_DATA_LEN)
+		rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
+
+	RTL_W8(tp, MaxTxPacketSize, TxPacketMax);
+
+	rtl_disable_clock_request(tp);
+}
+
+static void rtl_hw_start_8168d_4(struct rtl8169_private *tp)
+{
+	static const struct ephy_info e_info_8168d_4[] = {
+		{ 0x0b, 0x0000,	0x0048 },
+		{ 0x19, 0x0020,	0x0050 },
+		{ 0x0c, 0x0100,	0x0020 }
+	};
+
+	rtl_set_def_aspm_entry_latency(tp);
+
+	rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
+
+	RTL_W8(tp, MaxTxPacketSize, TxPacketMax);
+
+	rtl_ephy_init(tp, e_info_8168d_4, ARRAY_SIZE(e_info_8168d_4));
+
+	rtl_enable_clock_request(tp);
+}
+
+static void rtl_hw_start_8168e_1(struct rtl8169_private *tp)
+{
+	static const struct ephy_info e_info_8168e_1[] = {
+		{ 0x00, 0x0200,	0x0100 },
+		{ 0x00, 0x0000,	0x0004 },
+		{ 0x06, 0x0002,	0x0001 },
+		{ 0x06, 0x0000,	0x0030 },
+		{ 0x07, 0x0000,	0x2000 },
+		{ 0x00, 0x0000,	0x0020 },
+		{ 0x03, 0x5800,	0x2000 },
+		{ 0x03, 0x0000,	0x0001 },
+		{ 0x01, 0x0800,	0x1000 },
+		{ 0x07, 0x0000,	0x4000 },
+		{ 0x1e, 0x0000,	0x2000 },
+		{ 0x19, 0xffff,	0xfe6c },
+		{ 0x0a, 0x0000,	0x0040 }
+	};
+
+	rtl_set_def_aspm_entry_latency(tp);
+
+	rtl_ephy_init(tp, e_info_8168e_1, ARRAY_SIZE(e_info_8168e_1));
+
+	if (tp->dev->mtu <= ETH_DATA_LEN)
+		rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
+
+	RTL_W8(tp, MaxTxPacketSize, TxPacketMax);
+
+	rtl_disable_clock_request(tp);
+
+	/* Reset tx FIFO pointer */
+	RTL_W32(tp, MISC, RTL_R32(tp, MISC) | TXPLA_RST);
+	RTL_W32(tp, MISC, RTL_R32(tp, MISC) & ~TXPLA_RST);
+
+	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~Spi_en);
+}
+
+static void rtl_hw_start_8168e_2(struct rtl8169_private *tp)
+{
+	static const struct ephy_info e_info_8168e_2[] = {
+		{ 0x09, 0x0000,	0x0080 },
+		{ 0x19, 0x0000,	0x0224 }
+	};
+
+	rtl_set_def_aspm_entry_latency(tp);
+
+	rtl_ephy_init(tp, e_info_8168e_2, ARRAY_SIZE(e_info_8168e_2));
+
+	if (tp->dev->mtu <= ETH_DATA_LEN)
+		rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
+
+	rtl_eri_write(tp, 0xc0, ERIAR_MASK_0011, 0x0000, ERIAR_EXGMAC);
+	rtl_eri_write(tp, 0xb8, ERIAR_MASK_0011, 0x0000, ERIAR_EXGMAC);
+	rtl_eri_write(tp, 0xc8, ERIAR_MASK_1111, 0x00100002, ERIAR_EXGMAC);
+	rtl_eri_write(tp, 0xe8, ERIAR_MASK_1111, 0x00100006, ERIAR_EXGMAC);
+	rtl_eri_write(tp, 0xcc, ERIAR_MASK_1111, 0x00000050, ERIAR_EXGMAC);
+	rtl_eri_write(tp, 0xd0, ERIAR_MASK_1111, 0x07ff0060, ERIAR_EXGMAC);
+	rtl_w0w1_eri(tp, 0x1b0, ERIAR_MASK_0001, 0x10, 0x00, ERIAR_EXGMAC);
+	rtl_w0w1_eri(tp, 0x0d4, ERIAR_MASK_0011, 0x0c00, 0xff00, ERIAR_EXGMAC);
+
+	RTL_W8(tp, MaxTxPacketSize, EarlySize);
+
+	rtl_disable_clock_request(tp);
+
+	RTL_W8(tp, MCU, RTL_R8(tp, MCU) & ~NOW_IS_OOB);
+
+	/* Adjust EEE LED frequency */
+	RTL_W8(tp, EEE_LED, RTL_R8(tp, EEE_LED) & ~0x07);
+
+	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) | PFM_EN);
+	RTL_W32(tp, MISC, RTL_R32(tp, MISC) | PWM_EN);
+	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~Spi_en);
+
+	rtl_hw_aspm_clkreq_enable(tp, true);
+}
+
+static void rtl_hw_start_8168f(struct rtl8169_private *tp)
+{
+	rtl_set_def_aspm_entry_latency(tp);
+
+	rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
+
+	rtl_eri_write(tp, 0xc0, ERIAR_MASK_0011, 0x0000, ERIAR_EXGMAC);
+	rtl_eri_write(tp, 0xb8, ERIAR_MASK_0011, 0x0000, ERIAR_EXGMAC);
+	rtl_eri_write(tp, 0xc8, ERIAR_MASK_1111, 0x00100002, ERIAR_EXGMAC);
+	rtl_eri_write(tp, 0xe8, ERIAR_MASK_1111, 0x00100006, ERIAR_EXGMAC);
+	rtl_w0w1_eri(tp, 0xdc, ERIAR_MASK_0001, 0x00, 0x01, ERIAR_EXGMAC);
+	rtl_w0w1_eri(tp, 0xdc, ERIAR_MASK_0001, 0x01, 0x00, ERIAR_EXGMAC);
+	rtl_w0w1_eri(tp, 0x1b0, ERIAR_MASK_0001, 0x10, 0x00, ERIAR_EXGMAC);
+	rtl_w0w1_eri(tp, 0x1d0, ERIAR_MASK_0001, 0x10, 0x00, ERIAR_EXGMAC);
+	rtl_eri_write(tp, 0xcc, ERIAR_MASK_1111, 0x00000050, ERIAR_EXGMAC);
+	rtl_eri_write(tp, 0xd0, ERIAR_MASK_1111, 0x00000060, ERIAR_EXGMAC);
+
+	RTL_W8(tp, MaxTxPacketSize, EarlySize);
+
+	rtl_disable_clock_request(tp);
+
+	RTL_W8(tp, MCU, RTL_R8(tp, MCU) & ~NOW_IS_OOB);
+	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) | PFM_EN);
+	RTL_W32(tp, MISC, RTL_R32(tp, MISC) | PWM_EN);
+	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~Spi_en);
+}
+
+static void rtl_hw_start_8168f_1(struct rtl8169_private *tp)
+{
+	static const struct ephy_info e_info_8168f_1[] = {
+		{ 0x06, 0x00c0,	0x0020 },
+		{ 0x08, 0x0001,	0x0002 },
+		{ 0x09, 0x0000,	0x0080 },
+		{ 0x19, 0x0000,	0x0224 }
+	};
+
+	rtl_hw_start_8168f(tp);
+
+	rtl_ephy_init(tp, e_info_8168f_1, ARRAY_SIZE(e_info_8168f_1));
+
+	rtl_w0w1_eri(tp, 0x0d4, ERIAR_MASK_0011, 0x0c00, 0xff00, ERIAR_EXGMAC);
+
+	/* Adjust EEE LED frequency */
+	RTL_W8(tp, EEE_LED, RTL_R8(tp, EEE_LED) & ~0x07);
+}
+
+static void rtl_hw_start_8411(struct rtl8169_private *tp)
+{
+	static const struct ephy_info e_info_8168f_1[] = {
+		{ 0x06, 0x00c0,	0x0020 },
+		{ 0x0f, 0xffff,	0x5200 },
+		{ 0x1e, 0x0000,	0x4000 },
+		{ 0x19, 0x0000,	0x0224 }
+	};
+
+	rtl_hw_start_8168f(tp);
+	rtl_pcie_state_l2l3_enable(tp, false);
+
+	rtl_ephy_init(tp, e_info_8168f_1, ARRAY_SIZE(e_info_8168f_1));
+
+	rtl_w0w1_eri(tp, 0x0d4, ERIAR_MASK_0011, 0x0c00, 0x0000, ERIAR_EXGMAC);
+}
+
+static void rtl_hw_start_8168g(struct rtl8169_private *tp)
+{
+	rtl_eri_write(tp, 0xc8, ERIAR_MASK_0101, 0x080002, ERIAR_EXGMAC);
+	rtl_eri_write(tp, 0xcc, ERIAR_MASK_0001, 0x38, ERIAR_EXGMAC);
+	rtl_eri_write(tp, 0xd0, ERIAR_MASK_0001, 0x48, ERIAR_EXGMAC);
+	rtl_eri_write(tp, 0xe8, ERIAR_MASK_1111, 0x00100006, ERIAR_EXGMAC);
+
+	rtl_set_def_aspm_entry_latency(tp);
+
+	rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
+
+	rtl_w0w1_eri(tp, 0xdc, ERIAR_MASK_0001, 0x00, 0x01, ERIAR_EXGMAC);
+	rtl_w0w1_eri(tp, 0xdc, ERIAR_MASK_0001, 0x01, 0x00, ERIAR_EXGMAC);
+	rtl_eri_write(tp, 0x2f8, ERIAR_MASK_0011, 0x1d8f, ERIAR_EXGMAC);
+
+	RTL_W32(tp, MISC, RTL_R32(tp, MISC) & ~RXDV_GATED_EN);
+	RTL_W8(tp, MaxTxPacketSize, EarlySize);
+
+	rtl_eri_write(tp, 0xc0, ERIAR_MASK_0011, 0x0000, ERIAR_EXGMAC);
+	rtl_eri_write(tp, 0xb8, ERIAR_MASK_0011, 0x0000, ERIAR_EXGMAC);
+
+	/* Adjust EEE LED frequency */
+	RTL_W8(tp, EEE_LED, RTL_R8(tp, EEE_LED) & ~0x07);
+
+	rtl_w0w1_eri(tp, 0x2fc, ERIAR_MASK_0001, 0x01, 0x06, ERIAR_EXGMAC);
+	rtl_w0w1_eri(tp, 0x1b0, ERIAR_MASK_0011, 0x0000, 0x1000, ERIAR_EXGMAC);
+
+	rtl_pcie_state_l2l3_enable(tp, false);
+}
+
+static void rtl_hw_start_8168g_1(struct rtl8169_private *tp)
+{
+	static const struct ephy_info e_info_8168g_1[] = {
+		{ 0x00, 0x0000,	0x0008 },
+		{ 0x0c, 0x37d0,	0x0820 },
+		{ 0x1e, 0x0000,	0x0001 },
+		{ 0x19, 0x8000,	0x0000 }
+	};
+
+	rtl_hw_start_8168g(tp);
+
+	/* disable aspm and clock request before access ephy */
+	rtl_hw_aspm_clkreq_enable(tp, false);
+	rtl_ephy_init(tp, e_info_8168g_1, ARRAY_SIZE(e_info_8168g_1));
+	rtl_hw_aspm_clkreq_enable(tp, true);
+}
+
+static void rtl_hw_start_8168g_2(struct rtl8169_private *tp)
+{
+	static const struct ephy_info e_info_8168g_2[] = {
+		{ 0x00, 0x0000,	0x0008 },
+		{ 0x0c, 0x3df0,	0x0200 },
+		{ 0x19, 0xffff,	0xfc00 },
+		{ 0x1e, 0xffff,	0x20eb }
+	};
+
+	rtl_hw_start_8168g(tp);
+
+	/* disable aspm and clock request before access ephy */
+	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
+	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
+	rtl_ephy_init(tp, e_info_8168g_2, ARRAY_SIZE(e_info_8168g_2));
+}
+
+static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
+{
+	static const struct ephy_info e_info_8411_2[] = {
+		{ 0x00, 0x0000,	0x0008 },
+		{ 0x0c, 0x3df0,	0x0200 },
+		{ 0x0f, 0xffff,	0x5200 },
+		{ 0x19, 0x0020,	0x0000 },
+		{ 0x1e, 0x0000,	0x2000 }
+	};
+
+	rtl_hw_start_8168g(tp);
+
+	/* disable aspm and clock request before access ephy */
+	rtl_hw_aspm_clkreq_enable(tp, false);
+	rtl_ephy_init(tp, e_info_8411_2, ARRAY_SIZE(e_info_8411_2));
+
+	/* The following Realtek-provided magic fixes an issue with the RX unit
+	 * getting confused after the PHY having been powered-down.
+	 */
+	r8168_mac_ocp_write(tp, 0xFC28, 0x0000);
+	r8168_mac_ocp_write(tp, 0xFC2A, 0x0000);
+	r8168_mac_ocp_write(tp, 0xFC2C, 0x0000);
+	r8168_mac_ocp_write(tp, 0xFC2E, 0x0000);
+	r8168_mac_ocp_write(tp, 0xFC30, 0x0000);
+	r8168_mac_ocp_write(tp, 0xFC32, 0x0000);
+	r8168_mac_ocp_write(tp, 0xFC34, 0x0000);
+	r8168_mac_ocp_write(tp, 0xFC36, 0x0000);
+	mdelay(3);
+	r8168_mac_ocp_write(tp, 0xFC26, 0x0000);
+
+	r8168_mac_ocp_write(tp, 0xF800, 0xE008);
+	r8168_mac_ocp_write(tp, 0xF802, 0xE00A);
+	r8168_mac_ocp_write(tp, 0xF804, 0xE00C);
+	r8168_mac_ocp_write(tp, 0xF806, 0xE00E);
+	r8168_mac_ocp_write(tp, 0xF808, 0xE027);
+	r8168_mac_ocp_write(tp, 0xF80A, 0xE04F);
+	r8168_mac_ocp_write(tp, 0xF80C, 0xE05E);
+	r8168_mac_ocp_write(tp, 0xF80E, 0xE065);
+	r8168_mac_ocp_write(tp, 0xF810, 0xC602);
+	r8168_mac_ocp_write(tp, 0xF812, 0xBE00);
+	r8168_mac_ocp_write(tp, 0xF814, 0x0000);
+	r8168_mac_ocp_write(tp, 0xF816, 0xC502);
+	r8168_mac_ocp_write(tp, 0xF818, 0xBD00);
+	r8168_mac_ocp_write(tp, 0xF81A, 0x074C);
+	r8168_mac_ocp_write(tp, 0xF81C, 0xC302);
+	r8168_mac_ocp_write(tp, 0xF81E, 0xBB00);
+	r8168_mac_ocp_write(tp, 0xF820, 0x080A);
+	r8168_mac_ocp_write(tp, 0xF822, 0x6420);
+	r8168_mac_ocp_write(tp, 0xF824, 0x48C2);
+	r8168_mac_ocp_write(tp, 0xF826, 0x8C20);
+	r8168_mac_ocp_write(tp, 0xF828, 0xC516);
+	r8168_mac_ocp_write(tp, 0xF82A, 0x64A4);
+	r8168_mac_ocp_write(tp, 0xF82C, 0x49C0);
+	r8168_mac_ocp_write(tp, 0xF82E, 0xF009);
+	r8168_mac_ocp_write(tp, 0xF830, 0x74A2);
+	r8168_mac_ocp_write(tp, 0xF832, 0x8CA5);
+	r8168_mac_ocp_write(tp, 0xF834, 0x74A0);
+	r8168_mac_ocp_write(tp, 0xF836, 0xC50E);
+	r8168_mac_ocp_write(tp, 0xF838, 0x9CA2);
+	r8168_mac_ocp_write(tp, 0xF83A, 0x1C11);
+	r8168_mac_ocp_write(tp, 0xF83C, 0x9CA0);
+	r8168_mac_ocp_write(tp, 0xF83E, 0xE006);
+	r8168_mac_ocp_write(tp, 0xF840, 0x74F8);
+	r8168_mac_ocp_write(tp, 0xF842, 0x48C4);
+	r8168_mac_ocp_write(tp, 0xF844, 0x8CF8);
+	r8168_mac_ocp_write(tp, 0xF846, 0xC404);
+	r8168_mac_ocp_write(tp, 0xF848, 0xBC00);
+	r8168_mac_ocp_write(tp, 0xF84A, 0xC403);
+	r8168_mac_ocp_write(tp, 0xF84C, 0xBC00);
+	r8168_mac_ocp_write(tp, 0xF84E, 0x0BF2);
+	r8168_mac_ocp_write(tp, 0xF850, 0x0C0A);
+	r8168_mac_ocp_write(tp, 0xF852, 0xE434);
+	r8168_mac_ocp_write(tp, 0xF854, 0xD3C0);
+	r8168_mac_ocp_write(tp, 0xF856, 0x49D9);
+	r8168_mac_ocp_write(tp, 0xF858, 0xF01F);
+	r8168_mac_ocp_write(tp, 0xF85A, 0xC526);
+	r8168_mac_ocp_write(tp, 0xF85C, 0x64A5);
+	r8168_mac_ocp_write(tp, 0xF85E, 0x1400);
+	r8168_mac_ocp_write(tp, 0xF860, 0xF007);
+	r8168_mac_ocp_write(tp, 0xF862, 0x0C01);
+	r8168_mac_ocp_write(tp, 0xF864, 0x8CA5);
+	r8168_mac_ocp_write(tp, 0xF866, 0x1C15);
+	r8168_mac_ocp_write(tp, 0xF868, 0xC51B);
+	r8168_mac_ocp_write(tp, 0xF86A, 0x9CA0);
+	r8168_mac_ocp_write(tp, 0xF86C, 0xE013);
+	r8168_mac_ocp_write(tp, 0xF86E, 0xC519);
+	r8168_mac_ocp_write(tp, 0xF870, 0x74A0);
+	r8168_mac_ocp_write(tp, 0xF872, 0x48C4);
+	r8168_mac_ocp_write(tp, 0xF874, 0x8CA0);
+	r8168_mac_ocp_write(tp, 0xF876, 0xC516);
+	r8168_mac_ocp_write(tp, 0xF878, 0x74A4);
+	r8168_mac_ocp_write(tp, 0xF87A, 0x48C8);
+	r8168_mac_ocp_write(tp, 0xF87C, 0x48CA);
+	r8168_mac_ocp_write(tp, 0xF87E, 0x9CA4);
+	r8168_mac_ocp_write(tp, 0xF880, 0xC512);
+	r8168_mac_ocp_write(tp, 0xF882, 0x1B00);
+	r8168_mac_ocp_write(tp, 0xF884, 0x9BA0);
+	r8168_mac_ocp_write(tp, 0xF886, 0x1B1C);
+	r8168_mac_ocp_write(tp, 0xF888, 0x483F);
+	r8168_mac_ocp_write(tp, 0xF88A, 0x9BA2);
+	r8168_mac_ocp_write(tp, 0xF88C, 0x1B04);
+	r8168_mac_ocp_write(tp, 0xF88E, 0xC508);
+	r8168_mac_ocp_write(tp, 0xF890, 0x9BA0);
+	r8168_mac_ocp_write(tp, 0xF892, 0xC505);
+	r8168_mac_ocp_write(tp, 0xF894, 0xBD00);
+	r8168_mac_ocp_write(tp, 0xF896, 0xC502);
+	r8168_mac_ocp_write(tp, 0xF898, 0xBD00);
+	r8168_mac_ocp_write(tp, 0xF89A, 0x0300);
+	r8168_mac_ocp_write(tp, 0xF89C, 0x051E);
+	r8168_mac_ocp_write(tp, 0xF89E, 0xE434);
+	r8168_mac_ocp_write(tp, 0xF8A0, 0xE018);
+	r8168_mac_ocp_write(tp, 0xF8A2, 0xE092);
+	r8168_mac_ocp_write(tp, 0xF8A4, 0xDE20);
+	r8168_mac_ocp_write(tp, 0xF8A6, 0xD3C0);
+	r8168_mac_ocp_write(tp, 0xF8A8, 0xC50F);
+	r8168_mac_ocp_write(tp, 0xF8AA, 0x76A4);
+	r8168_mac_ocp_write(tp, 0xF8AC, 0x49E3);
+	r8168_mac_ocp_write(tp, 0xF8AE, 0xF007);
+	r8168_mac_ocp_write(tp, 0xF8B0, 0x49C0);
+	r8168_mac_ocp_write(tp, 0xF8B2, 0xF103);
+	r8168_mac_ocp_write(tp, 0xF8B4, 0xC607);
+	r8168_mac_ocp_write(tp, 0xF8B6, 0xBE00);
+	r8168_mac_ocp_write(tp, 0xF8B8, 0xC606);
+	r8168_mac_ocp_write(tp, 0xF8BA, 0xBE00);
+	r8168_mac_ocp_write(tp, 0xF8BC, 0xC602);
+	r8168_mac_ocp_write(tp, 0xF8BE, 0xBE00);
+	r8168_mac_ocp_write(tp, 0xF8C0, 0x0C4C);
+	r8168_mac_ocp_write(tp, 0xF8C2, 0x0C28);
+	r8168_mac_ocp_write(tp, 0xF8C4, 0x0C2C);
+	r8168_mac_ocp_write(tp, 0xF8C6, 0xDC00);
+	r8168_mac_ocp_write(tp, 0xF8C8, 0xC707);
+	r8168_mac_ocp_write(tp, 0xF8CA, 0x1D00);
+	r8168_mac_ocp_write(tp, 0xF8CC, 0x8DE2);
+	r8168_mac_ocp_write(tp, 0xF8CE, 0x48C1);
+	r8168_mac_ocp_write(tp, 0xF8D0, 0xC502);
+	r8168_mac_ocp_write(tp, 0xF8D2, 0xBD00);
+	r8168_mac_ocp_write(tp, 0xF8D4, 0x00AA);
+	r8168_mac_ocp_write(tp, 0xF8D6, 0xE0C0);
+	r8168_mac_ocp_write(tp, 0xF8D8, 0xC502);
+	r8168_mac_ocp_write(tp, 0xF8DA, 0xBD00);
+	r8168_mac_ocp_write(tp, 0xF8DC, 0x0132);
+
+	r8168_mac_ocp_write(tp, 0xFC26, 0x8000);
+
+	r8168_mac_ocp_write(tp, 0xFC2A, 0x0743);
+	r8168_mac_ocp_write(tp, 0xFC2C, 0x0801);
+	r8168_mac_ocp_write(tp, 0xFC2E, 0x0BE9);
+	r8168_mac_ocp_write(tp, 0xFC30, 0x02FD);
+	r8168_mac_ocp_write(tp, 0xFC32, 0x0C25);
+	r8168_mac_ocp_write(tp, 0xFC34, 0x00A9);
+	r8168_mac_ocp_write(tp, 0xFC36, 0x012D);
+
+	rtl_hw_aspm_clkreq_enable(tp, true);
+}
+
+static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
+{
+	int rg_saw_cnt;
+	u32 data;
+	static const struct ephy_info e_info_8168h_1[] = {
+		{ 0x1e, 0x0800,	0x0001 },
+		{ 0x1d, 0x0000,	0x0800 },
+		{ 0x05, 0xffff,	0x2089 },
+		{ 0x06, 0xffff,	0x5881 },
+		{ 0x04, 0xffff,	0x154a },
+		{ 0x01, 0xffff,	0x068b }
+	};
+
+	/* disable aspm and clock request before access ephy */
+	rtl_hw_aspm_clkreq_enable(tp, false);
+	rtl_ephy_init(tp, e_info_8168h_1, ARRAY_SIZE(e_info_8168h_1));
+
+	rtl_eri_write(tp, 0xc8, ERIAR_MASK_0101, 0x00080002, ERIAR_EXGMAC);
+	rtl_eri_write(tp, 0xcc, ERIAR_MASK_0001, 0x38, ERIAR_EXGMAC);
+	rtl_eri_write(tp, 0xd0, ERIAR_MASK_0001, 0x48, ERIAR_EXGMAC);
+	rtl_eri_write(tp, 0xe8, ERIAR_MASK_1111, 0x00100006, ERIAR_EXGMAC);
+
+	rtl_set_def_aspm_entry_latency(tp);
+
+	rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
+
+	rtl_w0w1_eri(tp, 0xdc, ERIAR_MASK_0001, 0x00, 0x01, ERIAR_EXGMAC);
+	rtl_w0w1_eri(tp, 0xdc, ERIAR_MASK_0001, 0x01, 0x00, ERIAR_EXGMAC);
+
+	rtl_w0w1_eri(tp, 0xdc, ERIAR_MASK_1111, 0x0010, 0x00, ERIAR_EXGMAC);
+
+	rtl_w0w1_eri(tp, 0xd4, ERIAR_MASK_1111, 0x1f00, 0x00, ERIAR_EXGMAC);
+
+	rtl_eri_write(tp, 0x5f0, ERIAR_MASK_0011, 0x4f87, ERIAR_EXGMAC);
+
+	RTL_W32(tp, MISC, RTL_R32(tp, MISC) & ~RXDV_GATED_EN);
+	RTL_W8(tp, MaxTxPacketSize, EarlySize);
+
+	rtl_eri_write(tp, 0xc0, ERIAR_MASK_0011, 0x0000, ERIAR_EXGMAC);
+	rtl_eri_write(tp, 0xb8, ERIAR_MASK_0011, 0x0000, ERIAR_EXGMAC);
+
+	/* Adjust EEE LED frequency */
+	RTL_W8(tp, EEE_LED, RTL_R8(tp, EEE_LED) & ~0x07);
+
+	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) & ~PFM_EN);
+	RTL_W8(tp, MISC_1, RTL_R8(tp, MISC_1) & ~PFM_D3COLD_EN);
+
+	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) & ~TX_10M_PS_EN);
+
+	rtl_w0w1_eri(tp, 0x1b0, ERIAR_MASK_0011, 0x0000, 0x1000, ERIAR_EXGMAC);
+
+	rtl_pcie_state_l2l3_enable(tp, false);
+
+	rtl_writephy(tp, 0x1f, 0x0c42);
+	rg_saw_cnt = (rtl_readphy(tp, 0x13) & 0x3fff);
+	rtl_writephy(tp, 0x1f, 0x0000);
+	if (rg_saw_cnt > 0) {
+		u16 sw_cnt_1ms_ini;
+
+		sw_cnt_1ms_ini = 16000000/rg_saw_cnt;
+		sw_cnt_1ms_ini &= 0x0fff;
+		data = r8168_mac_ocp_read(tp, 0xd412);
+		data &= ~0x0fff;
+		data |= sw_cnt_1ms_ini;
+		r8168_mac_ocp_write(tp, 0xd412, data);
+	}
+
+	data = r8168_mac_ocp_read(tp, 0xe056);
+	data &= ~0xf0;
+	data |= 0x70;
+	r8168_mac_ocp_write(tp, 0xe056, data);
+
+	data = r8168_mac_ocp_read(tp, 0xe052);
+	data &= ~0x6000;
+	data |= 0x8008;
+	r8168_mac_ocp_write(tp, 0xe052, data);
+
+	data = r8168_mac_ocp_read(tp, 0xe0d6);
+	data &= ~0x01ff;
+	data |= 0x017f;
+	r8168_mac_ocp_write(tp, 0xe0d6, data);
+
+	data = r8168_mac_ocp_read(tp, 0xd420);
+	data &= ~0x0fff;
+	data |= 0x047f;
+	r8168_mac_ocp_write(tp, 0xd420, data);
+
+	r8168_mac_ocp_write(tp, 0xe63e, 0x0001);
+	r8168_mac_ocp_write(tp, 0xe63e, 0x0000);
+	r8168_mac_ocp_write(tp, 0xc094, 0x0000);
+	r8168_mac_ocp_write(tp, 0xc09e, 0x0000);
+
+	rtl_hw_aspm_clkreq_enable(tp, true);
+}
+
+static void rtl_hw_start_8168ep(struct rtl8169_private *tp)
+{
+	rtl8168ep_stop_cmac(tp);
+
+	rtl_eri_write(tp, 0xc8, ERIAR_MASK_0101, 0x00080002, ERIAR_EXGMAC);
+	rtl_eri_write(tp, 0xcc, ERIAR_MASK_0001, 0x2f, ERIAR_EXGMAC);
+	rtl_eri_write(tp, 0xd0, ERIAR_MASK_0001, 0x5f, ERIAR_EXGMAC);
+	rtl_eri_write(tp, 0xe8, ERIAR_MASK_1111, 0x00100006, ERIAR_EXGMAC);
+
+	rtl_set_def_aspm_entry_latency(tp);
+
+	rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
+
+	rtl_w0w1_eri(tp, 0xdc, ERIAR_MASK_0001, 0x00, 0x01, ERIAR_EXGMAC);
+	rtl_w0w1_eri(tp, 0xdc, ERIAR_MASK_0001, 0x01, 0x00, ERIAR_EXGMAC);
+
+	rtl_w0w1_eri(tp, 0xd4, ERIAR_MASK_1111, 0x1f80, 0x00, ERIAR_EXGMAC);
+
+	rtl_eri_write(tp, 0x5f0, ERIAR_MASK_0011, 0x4f87, ERIAR_EXGMAC);
+
+	RTL_W32(tp, MISC, RTL_R32(tp, MISC) & ~RXDV_GATED_EN);
+	RTL_W8(tp, MaxTxPacketSize, EarlySize);
+
+	rtl_eri_write(tp, 0xc0, ERIAR_MASK_0011, 0x0000, ERIAR_EXGMAC);
+	rtl_eri_write(tp, 0xb8, ERIAR_MASK_0011, 0x0000, ERIAR_EXGMAC);
+
+	/* Adjust EEE LED frequency */
+	RTL_W8(tp, EEE_LED, RTL_R8(tp, EEE_LED) & ~0x07);
+
+	rtl_w0w1_eri(tp, 0x2fc, ERIAR_MASK_0001, 0x01, 0x06, ERIAR_EXGMAC);
+
+	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) & ~TX_10M_PS_EN);
+
+	rtl_pcie_state_l2l3_enable(tp, false);
+}
+
+static void rtl_hw_start_8168ep_1(struct rtl8169_private *tp)
+{
+	static const struct ephy_info e_info_8168ep_1[] = {
+		{ 0x00, 0xffff,	0x10ab },
+		{ 0x06, 0xffff,	0xf030 },
+		{ 0x08, 0xffff,	0x2006 },
+		{ 0x0d, 0xffff,	0x1666 },
+		{ 0x0c, 0x3ff0,	0x0000 }
+	};
+
+	/* disable aspm and clock request before access ephy */
+	rtl_hw_aspm_clkreq_enable(tp, false);
+	rtl_ephy_init(tp, e_info_8168ep_1, ARRAY_SIZE(e_info_8168ep_1));
+
+	rtl_hw_start_8168ep(tp);
+
+	rtl_hw_aspm_clkreq_enable(tp, true);
+}
+
+static void rtl_hw_start_8168ep_2(struct rtl8169_private *tp)
+{
+	static const struct ephy_info e_info_8168ep_2[] = {
+		{ 0x00, 0xffff,	0x10a3 },
+		{ 0x19, 0xffff,	0xfc00 },
+		{ 0x1e, 0xffff,	0x20ea }
+	};
+
+	/* disable aspm and clock request before access ephy */
+	rtl_hw_aspm_clkreq_enable(tp, false);
+	rtl_ephy_init(tp, e_info_8168ep_2, ARRAY_SIZE(e_info_8168ep_2));
+
+	rtl_hw_start_8168ep(tp);
+
+	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) & ~PFM_EN);
+	RTL_W8(tp, MISC_1, RTL_R8(tp, MISC_1) & ~PFM_D3COLD_EN);
+
+	rtl_hw_aspm_clkreq_enable(tp, true);
+}
+
+static void rtl_hw_start_8168ep_3(struct rtl8169_private *tp)
+{
+	u32 data;
+	static const struct ephy_info e_info_8168ep_3[] = {
+		{ 0x00, 0xffff,	0x10a3 },
+		{ 0x19, 0xffff,	0x7c00 },
+		{ 0x1e, 0xffff,	0x20eb },
+		{ 0x0d, 0xffff,	0x1666 }
+	};
+
+	/* disable aspm and clock request before access ephy */
+	rtl_hw_aspm_clkreq_enable(tp, false);
+	rtl_ephy_init(tp, e_info_8168ep_3, ARRAY_SIZE(e_info_8168ep_3));
+
+	rtl_hw_start_8168ep(tp);
+
+	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) & ~PFM_EN);
+	RTL_W8(tp, MISC_1, RTL_R8(tp, MISC_1) & ~PFM_D3COLD_EN);
+
+	data = r8168_mac_ocp_read(tp, 0xd3e2);
+	data &= 0xf000;
+	data |= 0x0271;
+	r8168_mac_ocp_write(tp, 0xd3e2, data);
+
+	data = r8168_mac_ocp_read(tp, 0xd3e4);
+	data &= 0xff00;
+	r8168_mac_ocp_write(tp, 0xd3e4, data);
+
+	data = r8168_mac_ocp_read(tp, 0xe860);
+	data |= 0x0080;
+	r8168_mac_ocp_write(tp, 0xe860, data);
+
+	rtl_hw_aspm_clkreq_enable(tp, true);
+}
+
+static void rtl_hw_start_8168(struct rtl8169_private *tp)
+{
+	RTL_W8(tp, MaxTxPacketSize, TxPacketMax);
+
+	tp->cp_cmd &= ~INTT_MASK;
+	tp->cp_cmd |= PktCntrDisable | INTT_1;
+	RTL_W16(tp, CPlusCmd, tp->cp_cmd);
+
+	RTL_W16(tp, IntrMitigate, 0x5100);
+
+	/* Work around for RxFIFO overflow. */
+	if (tp->mac_version == RTL_GIGA_MAC_VER_11) {
+		tp->event_slow |= RxFIFOOver | PCSTimeout;
+		tp->event_slow &= ~RxOverflow;
+	}
+
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_11:
+		rtl_hw_start_8168bb(tp);
+		break;
+
+	case RTL_GIGA_MAC_VER_12:
+	case RTL_GIGA_MAC_VER_17:
+		rtl_hw_start_8168bef(tp);
+		break;
+
+	case RTL_GIGA_MAC_VER_18:
+		rtl_hw_start_8168cp_1(tp);
+		break;
+
+	case RTL_GIGA_MAC_VER_19:
+		rtl_hw_start_8168c_1(tp);
+		break;
+
+	case RTL_GIGA_MAC_VER_20:
+		rtl_hw_start_8168c_2(tp);
+		break;
+
+	case RTL_GIGA_MAC_VER_21:
+		rtl_hw_start_8168c_3(tp);
+		break;
+
+	case RTL_GIGA_MAC_VER_22:
+		rtl_hw_start_8168c_4(tp);
+		break;
+
+	case RTL_GIGA_MAC_VER_23:
+		rtl_hw_start_8168cp_2(tp);
+		break;
+
+	case RTL_GIGA_MAC_VER_24:
+		rtl_hw_start_8168cp_3(tp);
+		break;
+
+	case RTL_GIGA_MAC_VER_25:
+	case RTL_GIGA_MAC_VER_26:
+	case RTL_GIGA_MAC_VER_27:
+		rtl_hw_start_8168d(tp);
+		break;
+
+	case RTL_GIGA_MAC_VER_28:
+		rtl_hw_start_8168d_4(tp);
+		break;
+
+	case RTL_GIGA_MAC_VER_31:
+		rtl_hw_start_8168dp(tp);
+		break;
+
+	case RTL_GIGA_MAC_VER_32:
+	case RTL_GIGA_MAC_VER_33:
+		rtl_hw_start_8168e_1(tp);
+		break;
+	case RTL_GIGA_MAC_VER_34:
+		rtl_hw_start_8168e_2(tp);
+		break;
+
+	case RTL_GIGA_MAC_VER_35:
+	case RTL_GIGA_MAC_VER_36:
+		rtl_hw_start_8168f_1(tp);
+		break;
+
+	case RTL_GIGA_MAC_VER_38:
+		rtl_hw_start_8411(tp);
+		break;
+
+	case RTL_GIGA_MAC_VER_40:
+	case RTL_GIGA_MAC_VER_41:
+		rtl_hw_start_8168g_1(tp);
+		break;
+	case RTL_GIGA_MAC_VER_42:
+		rtl_hw_start_8168g_2(tp);
+		break;
+
+	case RTL_GIGA_MAC_VER_44:
+		rtl_hw_start_8411_2(tp);
+		break;
+
+	case RTL_GIGA_MAC_VER_45:
+	case RTL_GIGA_MAC_VER_46:
+		rtl_hw_start_8168h_1(tp);
+		break;
+
+	case RTL_GIGA_MAC_VER_49:
+		rtl_hw_start_8168ep_1(tp);
+		break;
+
+	case RTL_GIGA_MAC_VER_50:
+		rtl_hw_start_8168ep_2(tp);
+		break;
+
+	case RTL_GIGA_MAC_VER_51:
+		rtl_hw_start_8168ep_3(tp);
+		break;
+
+	default:
+		netif_err(tp, drv, tp->dev,
+			  "unknown chipset (mac_version = %d)\n",
+			  tp->mac_version);
+		break;
+	}
+}
+
+static void rtl_hw_start_8102e_1(struct rtl8169_private *tp)
+{
+	static const struct ephy_info e_info_8102e_1[] = {
+		{ 0x01,	0, 0x6e65 },
+		{ 0x02,	0, 0x091f },
+		{ 0x03,	0, 0xc2f9 },
+		{ 0x06,	0, 0xafb5 },
+		{ 0x07,	0, 0x0e00 },
+		{ 0x19,	0, 0xec80 },
+		{ 0x01,	0, 0x2e65 },
+		{ 0x01,	0, 0x6e65 }
+	};
+	u8 cfg1;
+
+	rtl_set_def_aspm_entry_latency(tp);
+
+	RTL_W8(tp, DBG_REG, FIX_NAK_1);
+
+	rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
+
+	RTL_W8(tp, Config1,
+	       LEDS1 | LEDS0 | Speed_down | MEMMAP | IOMAP | VPD | PMEnable);
+	RTL_W8(tp, Config3, RTL_R8(tp, Config3) & ~Beacon_en);
+
+	cfg1 = RTL_R8(tp, Config1);
+	if ((cfg1 & LEDS0) && (cfg1 & LEDS1))
+		RTL_W8(tp, Config1, cfg1 & ~LEDS0);
+
+	rtl_ephy_init(tp, e_info_8102e_1, ARRAY_SIZE(e_info_8102e_1));
+}
+
+static void rtl_hw_start_8102e_2(struct rtl8169_private *tp)
+{
+	rtl_set_def_aspm_entry_latency(tp);
+
+	rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
+
+	RTL_W8(tp, Config1, MEMMAP | IOMAP | VPD | PMEnable);
+	RTL_W8(tp, Config3, RTL_R8(tp, Config3) & ~Beacon_en);
+}
+
+static void rtl_hw_start_8102e_3(struct rtl8169_private *tp)
+{
+	rtl_hw_start_8102e_2(tp);
+
+	rtl_ephy_write(tp, 0x03, 0xc2f9);
+}
+
+static void rtl_hw_start_8105e_1(struct rtl8169_private *tp)
+{
+	static const struct ephy_info e_info_8105e_1[] = {
+		{ 0x07,	0, 0x4000 },
+		{ 0x19,	0, 0x0200 },
+		{ 0x19,	0, 0x0020 },
+		{ 0x1e,	0, 0x2000 },
+		{ 0x03,	0, 0x0001 },
+		{ 0x19,	0, 0x0100 },
+		{ 0x19,	0, 0x0004 },
+		{ 0x0a,	0, 0x0020 }
+	};
+
+	/* Force LAN exit from ASPM if Rx/Tx are not idle */
+	RTL_W32(tp, FuncEvent, RTL_R32(tp, FuncEvent) | 0x002800);
+
+	/* Disable Early Tally Counter */
+	RTL_W32(tp, FuncEvent, RTL_R32(tp, FuncEvent) & ~0x010000);
+
+	RTL_W8(tp, MCU, RTL_R8(tp, MCU) | EN_NDP | EN_OOB_RESET);
+	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) | PFM_EN);
+
+	rtl_ephy_init(tp, e_info_8105e_1, ARRAY_SIZE(e_info_8105e_1));
+
+	rtl_pcie_state_l2l3_enable(tp, false);
+}
+
+static void rtl_hw_start_8105e_2(struct rtl8169_private *tp)
+{
+	rtl_hw_start_8105e_1(tp);
+	rtl_ephy_write(tp, 0x1e, rtl_ephy_read(tp, 0x1e) | 0x8000);
+}
+
+static void rtl_hw_start_8402(struct rtl8169_private *tp)
+{
+	static const struct ephy_info e_info_8402[] = {
+		{ 0x19,	0xffff, 0xff64 },
+		{ 0x1e,	0, 0x4000 }
+	};
+
+	rtl_set_def_aspm_entry_latency(tp);
+
+	/* Force LAN exit from ASPM if Rx/Tx are not idle */
+	RTL_W32(tp, FuncEvent, RTL_R32(tp, FuncEvent) | 0x002800);
+
+	RTL_W8(tp, MCU, RTL_R8(tp, MCU) & ~NOW_IS_OOB);
+
+	rtl_ephy_init(tp, e_info_8402, ARRAY_SIZE(e_info_8402));
+
+	rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
+
+	rtl_eri_write(tp, 0xc8, ERIAR_MASK_1111, 0x00000002, ERIAR_EXGMAC);
+	rtl_eri_write(tp, 0xe8, ERIAR_MASK_1111, 0x00000006, ERIAR_EXGMAC);
+	rtl_w0w1_eri(tp, 0xdc, ERIAR_MASK_0001, 0x00, 0x01, ERIAR_EXGMAC);
+	rtl_w0w1_eri(tp, 0xdc, ERIAR_MASK_0001, 0x01, 0x00, ERIAR_EXGMAC);
+	rtl_eri_write(tp, 0xc0, ERIAR_MASK_0011, 0x0000, ERIAR_EXGMAC);
+	rtl_eri_write(tp, 0xb8, ERIAR_MASK_0011, 0x0000, ERIAR_EXGMAC);
+	rtl_w0w1_eri(tp, 0x0d4, ERIAR_MASK_0011, 0x0e00, 0xff00, ERIAR_EXGMAC);
+
+	rtl_pcie_state_l2l3_enable(tp, false);
+}
+
+static void rtl_hw_start_8106(struct rtl8169_private *tp)
+{
+	rtl_hw_aspm_clkreq_enable(tp, false);
+
+	/* Force LAN exit from ASPM if Rx/Tx are not idle */
+	RTL_W32(tp, FuncEvent, RTL_R32(tp, FuncEvent) | 0x002800);
+
+	RTL_W32(tp, MISC, (RTL_R32(tp, MISC) | DISABLE_LAN_EN) & ~EARLY_TALLY_EN);
+	RTL_W8(tp, MCU, RTL_R8(tp, MCU) | EN_NDP | EN_OOB_RESET);
+	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) & ~PFM_EN);
+
+	rtl_pcie_state_l2l3_enable(tp, false);
+	rtl_hw_aspm_clkreq_enable(tp, true);
+}
+
+static void rtl_hw_start_8101(struct rtl8169_private *tp)
+{
+	if (tp->mac_version >= RTL_GIGA_MAC_VER_30)
+		tp->event_slow &= ~RxFIFOOver;
+
+	if (tp->mac_version == RTL_GIGA_MAC_VER_13 ||
+	    tp->mac_version == RTL_GIGA_MAC_VER_16)
+		pcie_capability_set_word(tp->pci_dev, PCI_EXP_DEVCTL,
+					 PCI_EXP_DEVCTL_NOSNOOP_EN);
+
+	RTL_W8(tp, MaxTxPacketSize, TxPacketMax);
+
+	tp->cp_cmd &= CPCMD_QUIRK_MASK;
+	RTL_W16(tp, CPlusCmd, tp->cp_cmd);
+
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_07:
+		rtl_hw_start_8102e_1(tp);
+		break;
+
+	case RTL_GIGA_MAC_VER_08:
+		rtl_hw_start_8102e_3(tp);
+		break;
+
+	case RTL_GIGA_MAC_VER_09:
+		rtl_hw_start_8102e_2(tp);
+		break;
+
+	case RTL_GIGA_MAC_VER_29:
+		rtl_hw_start_8105e_1(tp);
+		break;
+	case RTL_GIGA_MAC_VER_30:
+		rtl_hw_start_8105e_2(tp);
+		break;
+
+	case RTL_GIGA_MAC_VER_37:
+		rtl_hw_start_8402(tp);
+		break;
+
+	case RTL_GIGA_MAC_VER_39:
+		rtl_hw_start_8106(tp);
+		break;
+	case RTL_GIGA_MAC_VER_43:
+		rtl_hw_start_8168g_2(tp);
+		break;
+	case RTL_GIGA_MAC_VER_47:
+	case RTL_GIGA_MAC_VER_48:
+		rtl_hw_start_8168h_1(tp);
+		break;
+	}
+
+	RTL_W16(tp, IntrMitigate, 0x0000);
+}
+
+static int rtl8169_change_mtu(struct net_device *dev, int new_mtu)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+
+	if (new_mtu > ETH_DATA_LEN)
+		rtl_hw_jumbo_enable(tp);
+	else
+		rtl_hw_jumbo_disable(tp);
+
+	dev->mtu = new_mtu;
+	netdev_update_features(dev);
+
+	return 0;
+}
+
+static inline void rtl8169_make_unusable_by_asic(struct RxDesc *desc)
+{
+	desc->addr = cpu_to_le64(0x0badbadbadbadbadull);
+	desc->opts1 &= ~cpu_to_le32(DescOwn | RsvdMask);
+}
+
+static void rtl8169_free_rx_databuff(struct rtl8169_private *tp,
+				     void **data_buff, struct RxDesc *desc)
+{
+	dma_unmap_single(tp_to_dev(tp), le64_to_cpu(desc->addr),
+			 R8169_RX_BUF_SIZE, DMA_FROM_DEVICE);
+
+	kfree(*data_buff);
+	*data_buff = NULL;
+	rtl8169_make_unusable_by_asic(desc);
+}
+
+static inline void rtl8169_mark_to_asic(struct RxDesc *desc)
+{
+	u32 eor = le32_to_cpu(desc->opts1) & RingEnd;
+
+	/* Force memory writes to complete before releasing descriptor */
+	dma_wmb();
+
+	desc->opts1 = cpu_to_le32(DescOwn | eor | R8169_RX_BUF_SIZE);
+}
+
+static inline void *rtl8169_align(void *data)
+{
+	return (void *)ALIGN((long)data, 16);
+}
+
+static struct sk_buff *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
+					     struct RxDesc *desc)
+{
+	void *data;
+	dma_addr_t mapping;
+	struct device *d = tp_to_dev(tp);
+	int node = dev_to_node(d);
+
+	data = kmalloc_node(R8169_RX_BUF_SIZE, GFP_KERNEL, node);
+	if (!data)
+		return NULL;
+
+	if (rtl8169_align(data) != data) {
+		kfree(data);
+		data = kmalloc_node(R8169_RX_BUF_SIZE + 15, GFP_KERNEL, node);
+		if (!data)
+			return NULL;
+	}
+
+	mapping = dma_map_single(d, rtl8169_align(data), R8169_RX_BUF_SIZE,
+				 DMA_FROM_DEVICE);
+	if (unlikely(dma_mapping_error(d, mapping))) {
+		if (net_ratelimit())
+			netif_err(tp, drv, tp->dev, "Failed to map RX DMA!\n");
+		goto err_out;
+	}
+
+	desc->addr = cpu_to_le64(mapping);
+	rtl8169_mark_to_asic(desc);
+	return data;
+
+err_out:
+	kfree(data);
+	return NULL;
+}
+
+static void rtl8169_rx_clear(struct rtl8169_private *tp)
+{
+	unsigned int i;
+
+	for (i = 0; i < NUM_RX_DESC; i++) {
+		if (tp->Rx_databuff[i]) {
+			rtl8169_free_rx_databuff(tp, tp->Rx_databuff + i,
+					    tp->RxDescArray + i);
+		}
+	}
+}
+
+static inline void rtl8169_mark_as_last_descriptor(struct RxDesc *desc)
+{
+	desc->opts1 |= cpu_to_le32(RingEnd);
+}
+
+static int rtl8169_rx_fill(struct rtl8169_private *tp)
+{
+	unsigned int i;
+
+	for (i = 0; i < NUM_RX_DESC; i++) {
+		void *data;
+
+		data = rtl8169_alloc_rx_data(tp, tp->RxDescArray + i);
+		if (!data) {
+			rtl8169_make_unusable_by_asic(tp->RxDescArray + i);
+			goto err_out;
+		}
+		tp->Rx_databuff[i] = data;
+	}
+
+	rtl8169_mark_as_last_descriptor(tp->RxDescArray + NUM_RX_DESC - 1);
+	return 0;
+
+err_out:
+	rtl8169_rx_clear(tp);
+	return -ENOMEM;
+}
+
+static int rtl8169_init_ring(struct rtl8169_private *tp)
+{
+	rtl8169_init_ring_indexes(tp);
+
+	memset(tp->tx_skb, 0, sizeof(tp->tx_skb));
+	memset(tp->Rx_databuff, 0, sizeof(tp->Rx_databuff));
+
+	return rtl8169_rx_fill(tp);
+}
+
+static void rtl8169_unmap_tx_skb(struct device *d, struct ring_info *tx_skb,
+				 struct TxDesc *desc)
+{
+	unsigned int len = tx_skb->len;
+
+	dma_unmap_single(d, le64_to_cpu(desc->addr), len, DMA_TO_DEVICE);
+
+	desc->opts1 = 0x00;
+	desc->opts2 = 0x00;
+	desc->addr = 0x00;
+	tx_skb->len = 0;
+}
+
+static void rtl8169_tx_clear_range(struct rtl8169_private *tp, u32 start,
+				   unsigned int n)
+{
+	unsigned int i;
+
+	for (i = 0; i < n; i++) {
+		unsigned int entry = (start + i) % NUM_TX_DESC;
+		struct ring_info *tx_skb = tp->tx_skb + entry;
+		unsigned int len = tx_skb->len;
+
+		if (len) {
+			struct sk_buff *skb = tx_skb->skb;
+
+			rtl8169_unmap_tx_skb(tp_to_dev(tp), tx_skb,
+					     tp->TxDescArray + entry);
+			if (skb) {
+				dev_consume_skb_any(skb);
+				tx_skb->skb = NULL;
+			}
+		}
+	}
+}
+
+static void rtl8169_tx_clear(struct rtl8169_private *tp)
+{
+	rtl8169_tx_clear_range(tp, tp->dirty_tx, NUM_TX_DESC);
+	tp->cur_tx = tp->dirty_tx = 0;
+}
+
+static void rtl_reset_work(struct rtl8169_private *tp)
+{
+	struct net_device *dev = tp->dev;
+	int i;
+
+	napi_disable(&tp->napi);
+	netif_stop_queue(dev);
+	synchronize_sched();
+
+	rtl8169_hw_reset(tp);
+
+	for (i = 0; i < NUM_RX_DESC; i++)
+		rtl8169_mark_to_asic(tp->RxDescArray + i);
+
+	rtl8169_tx_clear(tp);
+	rtl8169_init_ring_indexes(tp);
+
+	napi_enable(&tp->napi);
+	rtl_hw_start(tp);
+	netif_wake_queue(dev);
+}
+
+static void rtl8169_tx_timeout(struct net_device *dev)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+
+	rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
+}
+
+static int rtl8169_xmit_frags(struct rtl8169_private *tp, struct sk_buff *skb,
+			      u32 *opts)
+{
+	struct skb_shared_info *info = skb_shinfo(skb);
+	unsigned int cur_frag, entry;
+	struct TxDesc *uninitialized_var(txd);
+	struct device *d = tp_to_dev(tp);
+
+	entry = tp->cur_tx;
+	for (cur_frag = 0; cur_frag < info->nr_frags; cur_frag++) {
+		const skb_frag_t *frag = info->frags + cur_frag;
+		dma_addr_t mapping;
+		u32 status, len;
+		void *addr;
+
+		entry = (entry + 1) % NUM_TX_DESC;
+
+		txd = tp->TxDescArray + entry;
+		len = skb_frag_size(frag);
+		addr = skb_frag_address(frag);
+		mapping = dma_map_single(d, addr, len, DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(d, mapping))) {
+			if (net_ratelimit())
+				netif_err(tp, drv, tp->dev,
+					  "Failed to map TX fragments DMA!\n");
+			goto err_out;
+		}
+
+		/* Anti gcc 2.95.3 bugware (sic) */
+		status = opts[0] | len |
+			(RingEnd * !((entry + 1) % NUM_TX_DESC));
+
+		txd->opts1 = cpu_to_le32(status);
+		txd->opts2 = cpu_to_le32(opts[1]);
+		txd->addr = cpu_to_le64(mapping);
+
+		tp->tx_skb[entry].len = len;
+	}
+
+	if (cur_frag) {
+		tp->tx_skb[entry].skb = skb;
+		txd->opts1 |= cpu_to_le32(LastFrag);
+	}
+
+	return cur_frag;
+
+err_out:
+	rtl8169_tx_clear_range(tp, tp->cur_tx + 1, cur_frag);
+	return -EIO;
+}
+
+static bool rtl_test_hw_pad_bug(struct rtl8169_private *tp, struct sk_buff *skb)
+{
+	return skb->len < ETH_ZLEN && tp->mac_version == RTL_GIGA_MAC_VER_34;
+}
+
+static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
+				      struct net_device *dev);
+/* r8169_csum_workaround()
+ * The hw limites the value the transport offset. When the offset is out of the
+ * range, calculate the checksum by sw.
+ */
+static void r8169_csum_workaround(struct rtl8169_private *tp,
+				  struct sk_buff *skb)
+{
+	if (skb_shinfo(skb)->gso_size) {
+		netdev_features_t features = tp->dev->features;
+		struct sk_buff *segs, *nskb;
+
+		features &= ~(NETIF_F_SG | NETIF_F_IPV6_CSUM | NETIF_F_TSO6);
+		segs = skb_gso_segment(skb, features);
+		if (IS_ERR(segs) || !segs)
+			goto drop;
+
+		do {
+			nskb = segs;
+			segs = segs->next;
+			nskb->next = NULL;
+			rtl8169_start_xmit(nskb, tp->dev);
+		} while (segs);
+
+		dev_consume_skb_any(skb);
+	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		if (skb_checksum_help(skb) < 0)
+			goto drop;
+
+		rtl8169_start_xmit(skb, tp->dev);
+	} else {
+		struct net_device_stats *stats;
+
+drop:
+		stats = &tp->dev->stats;
+		stats->tx_dropped++;
+		dev_kfree_skb_any(skb);
+	}
+}
+
+/* msdn_giant_send_check()
+ * According to the document of microsoft, the TCP Pseudo Header excludes the
+ * packet length for IPv6 TCP large packets.
+ */
+static int msdn_giant_send_check(struct sk_buff *skb)
+{
+	const struct ipv6hdr *ipv6h;
+	struct tcphdr *th;
+	int ret;
+
+	ret = skb_cow_head(skb, 0);
+	if (ret)
+		return ret;
+
+	ipv6h = ipv6_hdr(skb);
+	th = tcp_hdr(skb);
+
+	th->check = 0;
+	th->check = ~tcp_v6_check(0, &ipv6h->saddr, &ipv6h->daddr, 0);
+
+	return ret;
+}
+
+static bool rtl8169_tso_csum_v1(struct rtl8169_private *tp,
+				struct sk_buff *skb, u32 *opts)
+{
+	u32 mss = skb_shinfo(skb)->gso_size;
+
+	if (mss) {
+		opts[0] |= TD_LSO;
+		opts[0] |= min(mss, TD_MSS_MAX) << TD0_MSS_SHIFT;
+	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		const struct iphdr *ip = ip_hdr(skb);
+
+		if (ip->protocol == IPPROTO_TCP)
+			opts[0] |= TD0_IP_CS | TD0_TCP_CS;
+		else if (ip->protocol == IPPROTO_UDP)
+			opts[0] |= TD0_IP_CS | TD0_UDP_CS;
+		else
+			WARN_ON_ONCE(1);
+	}
+
+	return true;
+}
+
+static bool rtl8169_tso_csum_v2(struct rtl8169_private *tp,
+				struct sk_buff *skb, u32 *opts)
+{
+	u32 transport_offset = (u32)skb_transport_offset(skb);
+	u32 mss = skb_shinfo(skb)->gso_size;
+
+	if (mss) {
+		if (transport_offset > GTTCPHO_MAX) {
+			netif_warn(tp, tx_err, tp->dev,
+				   "Invalid transport offset 0x%x for TSO\n",
+				   transport_offset);
+			return false;
+		}
+
+		switch (vlan_get_protocol(skb)) {
+		case htons(ETH_P_IP):
+			opts[0] |= TD1_GTSENV4;
+			break;
+
+		case htons(ETH_P_IPV6):
+			if (msdn_giant_send_check(skb))
+				return false;
+
+			opts[0] |= TD1_GTSENV6;
+			break;
+
+		default:
+			WARN_ON_ONCE(1);
+			break;
+		}
+
+		opts[0] |= transport_offset << GTTCPHO_SHIFT;
+		opts[1] |= min(mss, TD_MSS_MAX) << TD1_MSS_SHIFT;
+	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		u8 ip_protocol;
+
+		if (unlikely(rtl_test_hw_pad_bug(tp, skb)))
+			return !(skb_checksum_help(skb) || eth_skb_pad(skb));
+
+		if (transport_offset > TCPHO_MAX) {
+			netif_warn(tp, tx_err, tp->dev,
+				   "Invalid transport offset 0x%x\n",
+				   transport_offset);
+			return false;
+		}
+
+		switch (vlan_get_protocol(skb)) {
+		case htons(ETH_P_IP):
+			opts[1] |= TD1_IPv4_CS;
+			ip_protocol = ip_hdr(skb)->protocol;
+			break;
+
+		case htons(ETH_P_IPV6):
+			opts[1] |= TD1_IPv6_CS;
+			ip_protocol = ipv6_hdr(skb)->nexthdr;
+			break;
+
+		default:
+			ip_protocol = IPPROTO_RAW;
+			break;
+		}
+
+		if (ip_protocol == IPPROTO_TCP)
+			opts[1] |= TD1_TCP_CS;
+		else if (ip_protocol == IPPROTO_UDP)
+			opts[1] |= TD1_UDP_CS;
+		else
+			WARN_ON_ONCE(1);
+
+		opts[1] |= transport_offset << TCPHO_SHIFT;
+	} else {
+		if (unlikely(rtl_test_hw_pad_bug(tp, skb)))
+			/* eth_skb_pad would free the skb on error */
+			return !__skb_put_padto(skb, ETH_ZLEN, false);
+	}
+
+	return true;
+}
+
+static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
+				      struct net_device *dev)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+	unsigned int entry = tp->cur_tx % NUM_TX_DESC;
+	struct TxDesc *txd = tp->TxDescArray + entry;
+	struct device *d = tp_to_dev(tp);
+	dma_addr_t mapping;
+	u32 status, len;
+	u32 opts[2];
+	int frags;
+
+	if (unlikely(!TX_FRAGS_READY_FOR(tp, skb_shinfo(skb)->nr_frags))) {
+		netif_err(tp, drv, dev, "BUG! Tx Ring full when queue awake!\n");
+		goto err_stop_0;
+	}
+
+	if (unlikely(le32_to_cpu(txd->opts1) & DescOwn))
+		goto err_stop_0;
+
+	opts[1] = cpu_to_le32(rtl8169_tx_vlan_tag(skb));
+	opts[0] = DescOwn;
+
+	if (!tp->tso_csum(tp, skb, opts)) {
+		r8169_csum_workaround(tp, skb);
+		return NETDEV_TX_OK;
+	}
+
+	len = skb_headlen(skb);
+	mapping = dma_map_single(d, skb->data, len, DMA_TO_DEVICE);
+	if (unlikely(dma_mapping_error(d, mapping))) {
+		if (net_ratelimit())
+			netif_err(tp, drv, dev, "Failed to map TX DMA!\n");
+		goto err_dma_0;
+	}
+
+	tp->tx_skb[entry].len = len;
+	txd->addr = cpu_to_le64(mapping);
+
+	frags = rtl8169_xmit_frags(tp, skb, opts);
+	if (frags < 0)
+		goto err_dma_1;
+	else if (frags)
+		opts[0] |= FirstFrag;
+	else {
+		opts[0] |= FirstFrag | LastFrag;
+		tp->tx_skb[entry].skb = skb;
+	}
+
+	txd->opts2 = cpu_to_le32(opts[1]);
+
+	skb_tx_timestamp(skb);
+
+	/* Force memory writes to complete before releasing descriptor */
+	dma_wmb();
+
+	/* Anti gcc 2.95.3 bugware (sic) */
+	status = opts[0] | len | (RingEnd * !((entry + 1) % NUM_TX_DESC));
+	txd->opts1 = cpu_to_le32(status);
+
+	/* Force all memory writes to complete before notifying device */
+	wmb();
+
+	tp->cur_tx += frags + 1;
+
+	RTL_W8(tp, TxPoll, NPQ);
+
+	mmiowb();
+
+	if (!TX_FRAGS_READY_FOR(tp, MAX_SKB_FRAGS)) {
+		/* Avoid wrongly optimistic queue wake-up: rtl_tx thread must
+		 * not miss a ring update when it notices a stopped queue.
+		 */
+		smp_wmb();
+		netif_stop_queue(dev);
+		/* Sync with rtl_tx:
+		 * - publish queue status and cur_tx ring index (write barrier)
+		 * - refresh dirty_tx ring index (read barrier).
+		 * May the current thread have a pessimistic view of the ring
+		 * status and forget to wake up queue, a racing rtl_tx thread
+		 * can't.
+		 */
+		smp_mb();
+		if (TX_FRAGS_READY_FOR(tp, MAX_SKB_FRAGS))
+			netif_wake_queue(dev);
+	}
+
+	return NETDEV_TX_OK;
+
+err_dma_1:
+	rtl8169_unmap_tx_skb(d, tp->tx_skb + entry, txd);
+err_dma_0:
+	dev_kfree_skb_any(skb);
+	dev->stats.tx_dropped++;
+	return NETDEV_TX_OK;
+
+err_stop_0:
+	netif_stop_queue(dev);
+	dev->stats.tx_dropped++;
+	return NETDEV_TX_BUSY;
+}
+
+static void rtl8169_pcierr_interrupt(struct net_device *dev)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+	struct pci_dev *pdev = tp->pci_dev;
+	u16 pci_status, pci_cmd;
+
+	pci_read_config_word(pdev, PCI_COMMAND, &pci_cmd);
+	pci_read_config_word(pdev, PCI_STATUS, &pci_status);
+
+	netif_err(tp, intr, dev, "PCI error (cmd = 0x%04x, status = 0x%04x)\n",
+		  pci_cmd, pci_status);
+
+	/*
+	 * The recovery sequence below admits a very elaborated explanation:
+	 * - it seems to work;
+	 * - I did not see what else could be done;
+	 * - it makes iop3xx happy.
+	 *
+	 * Feel free to adjust to your needs.
+	 */
+	if (pdev->broken_parity_status)
+		pci_cmd &= ~PCI_COMMAND_PARITY;
+	else
+		pci_cmd |= PCI_COMMAND_SERR | PCI_COMMAND_PARITY;
+
+	pci_write_config_word(pdev, PCI_COMMAND, pci_cmd);
+
+	pci_write_config_word(pdev, PCI_STATUS,
+		pci_status & (PCI_STATUS_DETECTED_PARITY |
+		PCI_STATUS_SIG_SYSTEM_ERROR | PCI_STATUS_REC_MASTER_ABORT |
+		PCI_STATUS_REC_TARGET_ABORT | PCI_STATUS_SIG_TARGET_ABORT));
+
+	/* The infamous DAC f*ckup only happens at boot time */
+	if ((tp->cp_cmd & PCIDAC) && !tp->cur_rx) {
+		netif_info(tp, intr, dev, "disabling PCI DAC\n");
+		tp->cp_cmd &= ~PCIDAC;
+		RTL_W16(tp, CPlusCmd, tp->cp_cmd);
+		dev->features &= ~NETIF_F_HIGHDMA;
+	}
+
+	rtl8169_hw_reset(tp);
+
+	rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
+}
+
+static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp)
+{
+	unsigned int dirty_tx, tx_left;
+
+	dirty_tx = tp->dirty_tx;
+	smp_rmb();
+	tx_left = tp->cur_tx - dirty_tx;
+
+	while (tx_left > 0) {
+		unsigned int entry = dirty_tx % NUM_TX_DESC;
+		struct ring_info *tx_skb = tp->tx_skb + entry;
+		u32 status;
+
+		status = le32_to_cpu(READ_ONCE(tp->TxDescArray[entry].opts1));
+		if (status & DescOwn)
+			break;
+
+		/* This barrier is needed to keep us from reading
+		 * any other fields out of the Tx descriptor until
+		 * we know the status of DescOwn
+		 */
+		dma_rmb();
+
+		rtl8169_unmap_tx_skb(tp_to_dev(tp), tx_skb,
+				     tp->TxDescArray + entry);
+		if (status & LastFrag) {
+			u64_stats_update_begin(&tp->tx_stats.syncp);
+			tp->tx_stats.packets++;
+			tp->tx_stats.bytes += tx_skb->skb->len;
+			u64_stats_update_end(&tp->tx_stats.syncp);
+			dev_consume_skb_any(tx_skb->skb);
+			tx_skb->skb = NULL;
+		}
+		dirty_tx++;
+		tx_left--;
+	}
+
+	if (tp->dirty_tx != dirty_tx) {
+		tp->dirty_tx = dirty_tx;
+		/* Sync with rtl8169_start_xmit:
+		 * - publish dirty_tx ring index (write barrier)
+		 * - refresh cur_tx ring index and queue status (read barrier)
+		 * May the current thread miss the stopped queue condition,
+		 * a racing xmit thread can only have a right view of the
+		 * ring status.
+		 */
+		smp_mb();
+		if (netif_queue_stopped(dev) &&
+		    TX_FRAGS_READY_FOR(tp, MAX_SKB_FRAGS)) {
+			netif_wake_queue(dev);
+		}
+		/*
+		 * 8168 hack: TxPoll requests are lost when the Tx packets are
+		 * too close. Let's kick an extra TxPoll request when a burst
+		 * of start_xmit activity is detected (if it is not detected,
+		 * it is slow enough). -- FR
+		 */
+		if (tp->cur_tx != dirty_tx)
+			RTL_W8(tp, TxPoll, NPQ);
+	}
+}
+
+static inline int rtl8169_fragmented_frame(u32 status)
+{
+	return (status & (FirstFrag | LastFrag)) != (FirstFrag | LastFrag);
+}
+
+static inline void rtl8169_rx_csum(struct sk_buff *skb, u32 opts1)
+{
+	u32 status = opts1 & RxProtoMask;
+
+	if (((status == RxProtoTCP) && !(opts1 & TCPFail)) ||
+	    ((status == RxProtoUDP) && !(opts1 & UDPFail)))
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+	else
+		skb_checksum_none_assert(skb);
+}
+
+static struct sk_buff *rtl8169_try_rx_copy(void *data,
+					   struct rtl8169_private *tp,
+					   int pkt_size,
+					   dma_addr_t addr)
+{
+	struct sk_buff *skb;
+	struct device *d = tp_to_dev(tp);
+
+	data = rtl8169_align(data);
+	dma_sync_single_for_cpu(d, addr, pkt_size, DMA_FROM_DEVICE);
+	prefetch(data);
+	skb = napi_alloc_skb(&tp->napi, pkt_size);
+	if (skb)
+		skb_copy_to_linear_data(skb, data, pkt_size);
+	dma_sync_single_for_device(d, addr, pkt_size, DMA_FROM_DEVICE);
+
+	return skb;
+}
+
+static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, u32 budget)
+{
+	unsigned int cur_rx, rx_left;
+	unsigned int count;
+
+	cur_rx = tp->cur_rx;
+
+	for (rx_left = min(budget, NUM_RX_DESC); rx_left > 0; rx_left--, cur_rx++) {
+		unsigned int entry = cur_rx % NUM_RX_DESC;
+		struct RxDesc *desc = tp->RxDescArray + entry;
+		u32 status;
+
+		status = le32_to_cpu(READ_ONCE(desc->opts1));
+		if (status & DescOwn)
+			break;
+
+		/* This barrier is needed to keep us from reading
+		 * any other fields out of the Rx descriptor until
+		 * we know the status of DescOwn
+		 */
+		dma_rmb();
+
+		if (unlikely(status & RxRES)) {
+			netif_info(tp, rx_err, dev, "Rx ERROR. status = %08x\n",
+				   status);
+			dev->stats.rx_errors++;
+			if (status & (RxRWT | RxRUNT))
+				dev->stats.rx_length_errors++;
+			if (status & RxCRC)
+				dev->stats.rx_crc_errors++;
+			/* RxFOVF is a reserved bit on later chip versions */
+			if (tp->mac_version == RTL_GIGA_MAC_VER_01 &&
+			    status & RxFOVF) {
+				rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
+				dev->stats.rx_fifo_errors++;
+			} else if (status & (RxRUNT | RxCRC) &&
+				   !(status & RxRWT) &&
+				   dev->features & NETIF_F_RXALL) {
+				goto process_pkt;
+			}
+		} else {
+			struct sk_buff *skb;
+			dma_addr_t addr;
+			int pkt_size;
+
+process_pkt:
+			addr = le64_to_cpu(desc->addr);
+			if (likely(!(dev->features & NETIF_F_RXFCS)))
+				pkt_size = (status & 0x00003fff) - 4;
+			else
+				pkt_size = status & 0x00003fff;
+
+			/*
+			 * The driver does not support incoming fragmented
+			 * frames. They are seen as a symptom of over-mtu
+			 * sized frames.
+			 */
+			if (unlikely(rtl8169_fragmented_frame(status))) {
+				dev->stats.rx_dropped++;
+				dev->stats.rx_length_errors++;
+				goto release_descriptor;
+			}
+
+			skb = rtl8169_try_rx_copy(tp->Rx_databuff[entry],
+						  tp, pkt_size, addr);
+			if (!skb) {
+				dev->stats.rx_dropped++;
+				goto release_descriptor;
+			}
+
+			rtl8169_rx_csum(skb, status);
+			skb_put(skb, pkt_size);
+			skb->protocol = eth_type_trans(skb, dev);
+
+			rtl8169_rx_vlan_tag(desc, skb);
+
+			if (skb->pkt_type == PACKET_MULTICAST)
+				dev->stats.multicast++;
+
+			napi_gro_receive(&tp->napi, skb);
+
+			u64_stats_update_begin(&tp->rx_stats.syncp);
+			tp->rx_stats.packets++;
+			tp->rx_stats.bytes += pkt_size;
+			u64_stats_update_end(&tp->rx_stats.syncp);
+		}
+release_descriptor:
+		desc->opts2 = 0;
+		rtl8169_mark_to_asic(desc);
+	}
+
+	count = cur_rx - tp->cur_rx;
+	tp->cur_rx = cur_rx;
+
+	return count;
+}
+
+static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
+{
+	struct rtl8169_private *tp = dev_instance;
+	u16 status = rtl_get_events(tp);
+
+	if (status == 0xffff || !(status & (RTL_EVENT_NAPI | tp->event_slow)))
+		return IRQ_NONE;
+
+	rtl_irq_disable(tp);
+	napi_schedule(&tp->napi);
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * Workqueue context.
+ */
+static void rtl_slow_event_work(struct rtl8169_private *tp)
+{
+	struct net_device *dev = tp->dev;
+	u16 status;
+
+	status = rtl_get_events(tp) & tp->event_slow;
+	rtl_ack_events(tp, status);
+
+	if (unlikely(status & RxFIFOOver)) {
+		switch (tp->mac_version) {
+		/* Work around for rx fifo overflow */
+		case RTL_GIGA_MAC_VER_11:
+			netif_stop_queue(dev);
+			/* XXX - Hack alert. See rtl_task(). */
+			set_bit(RTL_FLAG_TASK_RESET_PENDING, tp->wk.flags);
+		default:
+			break;
+		}
+	}
+
+	if (unlikely(status & SYSErr))
+		rtl8169_pcierr_interrupt(dev);
+
+	if (status & LinkChg)
+		phy_mac_interrupt(dev->phydev);
+
+	rtl_irq_enable_all(tp);
+}
+
+static void rtl_task(struct work_struct *work)
+{
+	static const struct {
+		int bitnr;
+		void (*action)(struct rtl8169_private *);
+	} rtl_work[] = {
+		/* XXX - keep rtl_slow_event_work() as first element. */
+		{ RTL_FLAG_TASK_SLOW_PENDING,	rtl_slow_event_work },
+		{ RTL_FLAG_TASK_RESET_PENDING,	rtl_reset_work },
+	};
+	struct rtl8169_private *tp =
+		container_of(work, struct rtl8169_private, wk.work);
+	struct net_device *dev = tp->dev;
+	int i;
+
+	rtl_lock_work(tp);
+
+	if (!netif_running(dev) ||
+	    !test_bit(RTL_FLAG_TASK_ENABLED, tp->wk.flags))
+		goto out_unlock;
+
+	for (i = 0; i < ARRAY_SIZE(rtl_work); i++) {
+		bool pending;
+
+		pending = test_and_clear_bit(rtl_work[i].bitnr, tp->wk.flags);
+		if (pending)
+			rtl_work[i].action(tp);
+	}
+
+out_unlock:
+	rtl_unlock_work(tp);
+}
+
+static int rtl8169_poll(struct napi_struct *napi, int budget)
+{
+	struct rtl8169_private *tp = container_of(napi, struct rtl8169_private, napi);
+	struct net_device *dev = tp->dev;
+	u16 enable_mask = RTL_EVENT_NAPI | tp->event_slow;
+	int work_done;
+	u16 status;
+
+	status = rtl_get_events(tp);
+	rtl_ack_events(tp, status & ~tp->event_slow);
+
+	work_done = rtl_rx(dev, tp, (u32) budget);
+
+	rtl_tx(dev, tp);
+
+	if (status & tp->event_slow) {
+		enable_mask &= ~tp->event_slow;
+
+		rtl_schedule_task(tp, RTL_FLAG_TASK_SLOW_PENDING);
+	}
+
+	if (work_done < budget) {
+		napi_complete_done(napi, work_done);
+
+		rtl_irq_enable(tp, enable_mask);
+		mmiowb();
+	}
+
+	return work_done;
+}
+
+static void rtl8169_rx_missed(struct net_device *dev)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+
+	if (tp->mac_version > RTL_GIGA_MAC_VER_06)
+		return;
+
+	dev->stats.rx_missed_errors += RTL_R32(tp, RxMissed) & 0xffffff;
+	RTL_W32(tp, RxMissed, 0);
+}
+
+static void r8169_phylink_handler(struct net_device *ndev)
+{
+	struct rtl8169_private *tp = netdev_priv(ndev);
+
+	if (netif_carrier_ok(ndev)) {
+		rtl_link_chg_patch(tp);
+		pm_request_resume(&tp->pci_dev->dev);
+	} else {
+		pm_runtime_idle(&tp->pci_dev->dev);
+	}
+
+	if (net_ratelimit())
+		phy_print_status(ndev->phydev);
+}
+
+static int r8169_phy_connect(struct rtl8169_private *tp)
+{
+	struct phy_device *phydev = mdiobus_get_phy(tp->mii_bus, 0);
+	phy_interface_t phy_mode;
+	int ret;
+
+	phy_mode = tp->supports_gmii ? PHY_INTERFACE_MODE_GMII :
+		   PHY_INTERFACE_MODE_MII;
+
+	ret = phy_connect_direct(tp->dev, phydev, r8169_phylink_handler,
+				 phy_mode);
+	if (ret)
+		return ret;
+
+	if (!tp->supports_gmii)
+		phy_set_max_speed(phydev, SPEED_100);
+
+	/* Ensure to advertise everything, incl. pause */
+	phydev->advertising = phydev->supported;
+
+	phy_attached_info(phydev);
+
+	return 0;
+}
+
+static void rtl8169_down(struct net_device *dev)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+
+	phy_stop(dev->phydev);
+
+	napi_disable(&tp->napi);
+	netif_stop_queue(dev);
+
+	rtl8169_hw_reset(tp);
+	/*
+	 * At this point device interrupts can not be enabled in any function,
+	 * as netif_running is not true (rtl8169_interrupt, rtl8169_reset_task)
+	 * and napi is disabled (rtl8169_poll).
+	 */
+	rtl8169_rx_missed(dev);
+
+	/* Give a racing hard_start_xmit a few cycles to complete. */
+	synchronize_sched();
+
+	rtl8169_tx_clear(tp);
+
+	rtl8169_rx_clear(tp);
+
+	rtl_pll_power_down(tp);
+}
+
+static int rtl8169_close(struct net_device *dev)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+	struct pci_dev *pdev = tp->pci_dev;
+
+	pm_runtime_get_sync(&pdev->dev);
+
+	/* Update counters before going down */
+	rtl8169_update_counters(tp);
+
+	rtl_lock_work(tp);
+	/* Clear all task flags */
+	bitmap_zero(tp->wk.flags, RTL_FLAG_MAX);
+
+	rtl8169_down(dev);
+	rtl_unlock_work(tp);
+
+	cancel_work_sync(&tp->wk.work);
+
+	phy_disconnect(dev->phydev);
+
+	free_irq(pci_irq_vector(pdev, 0), tp);
+
+	dma_free_coherent(&pdev->dev, R8169_RX_RING_BYTES, tp->RxDescArray,
+			  tp->RxPhyAddr);
+	dma_free_coherent(&pdev->dev, R8169_TX_RING_BYTES, tp->TxDescArray,
+			  tp->TxPhyAddr);
+	tp->TxDescArray = NULL;
+	tp->RxDescArray = NULL;
+
+	pm_runtime_put_sync(&pdev->dev);
+
+	return 0;
+}
+
+#ifdef CONFIG_NET_POLL_CONTROLLER
+static void rtl8169_netpoll(struct net_device *dev)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+
+	rtl8169_interrupt(pci_irq_vector(tp->pci_dev, 0), tp);
+}
+#endif
+
+static int rtl_open(struct net_device *dev)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+	struct pci_dev *pdev = tp->pci_dev;
+	int retval = -ENOMEM;
+
+	pm_runtime_get_sync(&pdev->dev);
+
+	/*
+	 * Rx and Tx descriptors needs 256 bytes alignment.
+	 * dma_alloc_coherent provides more.
+	 */
+	tp->TxDescArray = dma_alloc_coherent(&pdev->dev, R8169_TX_RING_BYTES,
+					     &tp->TxPhyAddr, GFP_KERNEL);
+	if (!tp->TxDescArray)
+		goto err_pm_runtime_put;
+
+	tp->RxDescArray = dma_alloc_coherent(&pdev->dev, R8169_RX_RING_BYTES,
+					     &tp->RxPhyAddr, GFP_KERNEL);
+	if (!tp->RxDescArray)
+		goto err_free_tx_0;
+
+	retval = rtl8169_init_ring(tp);
+	if (retval < 0)
+		goto err_free_rx_1;
+
+	INIT_WORK(&tp->wk.work, rtl_task);
+
+	smp_mb();
+
+	rtl_request_firmware(tp);
+
+	retval = request_irq(pci_irq_vector(pdev, 0), rtl8169_interrupt,
+			     IRQF_SHARED, dev->name, tp);
+	if (retval < 0)
+		goto err_release_fw_2;
+
+	retval = r8169_phy_connect(tp);
+	if (retval)
+		goto err_free_irq;
+
+	rtl_lock_work(tp);
+
+	set_bit(RTL_FLAG_TASK_ENABLED, tp->wk.flags);
+
+	napi_enable(&tp->napi);
+
+	rtl8169_init_phy(dev, tp);
+
+	rtl_pll_power_up(tp);
+
+	rtl_hw_start(tp);
+
+	if (!rtl8169_init_counter_offsets(tp))
+		netif_warn(tp, hw, dev, "counter reset/update failed\n");
+
+	phy_start(dev->phydev);
+	netif_start_queue(dev);
+
+	rtl_unlock_work(tp);
+
+	pm_runtime_put_sync(&pdev->dev);
+out:
+	return retval;
+
+err_free_irq:
+	free_irq(pci_irq_vector(pdev, 0), tp);
+err_release_fw_2:
+	rtl_release_firmware(tp);
+	rtl8169_rx_clear(tp);
+err_free_rx_1:
+	dma_free_coherent(&pdev->dev, R8169_RX_RING_BYTES, tp->RxDescArray,
+			  tp->RxPhyAddr);
+	tp->RxDescArray = NULL;
+err_free_tx_0:
+	dma_free_coherent(&pdev->dev, R8169_TX_RING_BYTES, tp->TxDescArray,
+			  tp->TxPhyAddr);
+	tp->TxDescArray = NULL;
+err_pm_runtime_put:
+	pm_runtime_put_noidle(&pdev->dev);
+	goto out;
+}
+
+static void
+rtl8169_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+	struct pci_dev *pdev = tp->pci_dev;
+	struct rtl8169_counters *counters = tp->counters;
+	unsigned int start;
+
+	pm_runtime_get_noresume(&pdev->dev);
+
+	if (netif_running(dev) && pm_runtime_active(&pdev->dev))
+		rtl8169_rx_missed(dev);
+
+	do {
+		start = u64_stats_fetch_begin_irq(&tp->rx_stats.syncp);
+		stats->rx_packets = tp->rx_stats.packets;
+		stats->rx_bytes	= tp->rx_stats.bytes;
+	} while (u64_stats_fetch_retry_irq(&tp->rx_stats.syncp, start));
+
+	do {
+		start = u64_stats_fetch_begin_irq(&tp->tx_stats.syncp);
+		stats->tx_packets = tp->tx_stats.packets;
+		stats->tx_bytes	= tp->tx_stats.bytes;
+	} while (u64_stats_fetch_retry_irq(&tp->tx_stats.syncp, start));
+
+	stats->rx_dropped	= dev->stats.rx_dropped;
+	stats->tx_dropped	= dev->stats.tx_dropped;
+	stats->rx_length_errors = dev->stats.rx_length_errors;
+	stats->rx_errors	= dev->stats.rx_errors;
+	stats->rx_crc_errors	= dev->stats.rx_crc_errors;
+	stats->rx_fifo_errors	= dev->stats.rx_fifo_errors;
+	stats->rx_missed_errors = dev->stats.rx_missed_errors;
+	stats->multicast	= dev->stats.multicast;
+
+	/*
+	 * Fetch additonal counter values missing in stats collected by driver
+	 * from tally counters.
+	 */
+	if (pm_runtime_active(&pdev->dev))
+		rtl8169_update_counters(tp);
+
+	/*
+	 * Subtract values fetched during initalization.
+	 * See rtl8169_init_counter_offsets for a description why we do that.
+	 */
+	stats->tx_errors = le64_to_cpu(counters->tx_errors) -
+		le64_to_cpu(tp->tc_offset.tx_errors);
+	stats->collisions = le32_to_cpu(counters->tx_multi_collision) -
+		le32_to_cpu(tp->tc_offset.tx_multi_collision);
+	stats->tx_aborted_errors = le16_to_cpu(counters->tx_aborted) -
+		le16_to_cpu(tp->tc_offset.tx_aborted);
+
+	pm_runtime_put_noidle(&pdev->dev);
+}
+
+static void rtl8169_net_suspend(struct net_device *dev)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+
+	if (!netif_running(dev))
+		return;
+
+	phy_stop(dev->phydev);
+	netif_device_detach(dev);
+	netif_stop_queue(dev);
+
+	rtl_lock_work(tp);
+	napi_disable(&tp->napi);
+	/* Clear all task flags */
+	bitmap_zero(tp->wk.flags, RTL_FLAG_MAX);
+
+	rtl_unlock_work(tp);
+
+	rtl_pll_power_down(tp);
+}
+
+#ifdef CONFIG_PM
+
+static int rtl8169_suspend(struct device *device)
+{
+	struct pci_dev *pdev = to_pci_dev(device);
+	struct net_device *dev = pci_get_drvdata(pdev);
+	struct rtl8169_private *tp = netdev_priv(dev);
+
+	rtl8169_net_suspend(dev);
+	clk_disable_unprepare(tp->clk);
+
+	return 0;
+}
+
+static void __rtl8169_resume(struct net_device *dev)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+
+	netif_device_attach(dev);
+
+	rtl_pll_power_up(tp);
+	rtl8169_init_phy(dev, tp);
+
+	phy_start(tp->dev->phydev);
+
+	rtl_lock_work(tp);
+	napi_enable(&tp->napi);
+	set_bit(RTL_FLAG_TASK_ENABLED, tp->wk.flags);
+	rtl_unlock_work(tp);
+
+	rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
+}
+
+static int rtl8169_resume(struct device *device)
+{
+	struct pci_dev *pdev = to_pci_dev(device);
+	struct net_device *dev = pci_get_drvdata(pdev);
+	struct rtl8169_private *tp = netdev_priv(dev);
+
+	clk_prepare_enable(tp->clk);
+
+	if (netif_running(dev))
+		__rtl8169_resume(dev);
+
+	return 0;
+}
+
+static int rtl8169_runtime_suspend(struct device *device)
+{
+	struct pci_dev *pdev = to_pci_dev(device);
+	struct net_device *dev = pci_get_drvdata(pdev);
+	struct rtl8169_private *tp = netdev_priv(dev);
+
+	if (!tp->TxDescArray)
+		return 0;
+
+	rtl_lock_work(tp);
+	__rtl8169_set_wol(tp, WAKE_ANY);
+	rtl_unlock_work(tp);
+
+	rtl8169_net_suspend(dev);
+
+	/* Update counters before going runtime suspend */
+	rtl8169_rx_missed(dev);
+	rtl8169_update_counters(tp);
+
+	return 0;
+}
+
+static int rtl8169_runtime_resume(struct device *device)
+{
+	struct pci_dev *pdev = to_pci_dev(device);
+	struct net_device *dev = pci_get_drvdata(pdev);
+	struct rtl8169_private *tp = netdev_priv(dev);
+	rtl_rar_set(tp, dev->dev_addr);
+
+	if (!tp->TxDescArray)
+		return 0;
+
+	rtl_lock_work(tp);
+	__rtl8169_set_wol(tp, tp->saved_wolopts);
+	rtl_unlock_work(tp);
+
+	__rtl8169_resume(dev);
+
+	return 0;
+}
+
+static int rtl8169_runtime_idle(struct device *device)
+{
+	struct pci_dev *pdev = to_pci_dev(device);
+	struct net_device *dev = pci_get_drvdata(pdev);
+
+	if (!netif_running(dev) || !netif_carrier_ok(dev))
+		pm_schedule_suspend(device, 10000);
+
+	return -EBUSY;
+}
+
+static const struct dev_pm_ops rtl8169_pm_ops = {
+	.suspend		= rtl8169_suspend,
+	.resume			= rtl8169_resume,
+	.freeze			= rtl8169_suspend,
+	.thaw			= rtl8169_resume,
+	.poweroff		= rtl8169_suspend,
+	.restore		= rtl8169_resume,
+	.runtime_suspend	= rtl8169_runtime_suspend,
+	.runtime_resume		= rtl8169_runtime_resume,
+	.runtime_idle		= rtl8169_runtime_idle,
+};
+
+#define RTL8169_PM_OPS	(&rtl8169_pm_ops)
+
+#else /* !CONFIG_PM */
+
+#define RTL8169_PM_OPS	NULL
+
+#endif /* !CONFIG_PM */
+
+static void rtl_wol_shutdown_quirk(struct rtl8169_private *tp)
+{
+	/* WoL fails with 8168b when the receiver is disabled. */
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_11:
+	case RTL_GIGA_MAC_VER_12:
+	case RTL_GIGA_MAC_VER_17:
+		pci_clear_master(tp->pci_dev);
+
+		RTL_W8(tp, ChipCmd, CmdRxEnb);
+		/* PCI commit */
+		RTL_R8(tp, ChipCmd);
+		break;
+	default:
+		break;
+	}
+}
+
+static void rtl_shutdown(struct pci_dev *pdev)
+{
+	struct net_device *dev = pci_get_drvdata(pdev);
+	struct rtl8169_private *tp = netdev_priv(dev);
+
+	rtl8169_net_suspend(dev);
+
+	/* Restore original MAC address */
+	rtl_rar_set(tp, dev->perm_addr);
+
+	rtl8169_hw_reset(tp);
+
+	if (system_state == SYSTEM_POWER_OFF) {
+		if (tp->saved_wolopts) {
+			rtl_wol_suspend_quirk(tp);
+			rtl_wol_shutdown_quirk(tp);
+		}
+
+		pci_wake_from_d3(pdev, true);
+		pci_set_power_state(pdev, PCI_D3hot);
+	}
+}
+
+static void rtl_remove_one(struct pci_dev *pdev)
+{
+	struct net_device *dev = pci_get_drvdata(pdev);
+	struct rtl8169_private *tp = netdev_priv(dev);
+
+	if (r8168_check_dash(tp))
+		rtl8168_driver_stop(tp);
+
+	netif_napi_del(&tp->napi);
+
+	unregister_netdev(dev);
+	mdiobus_unregister(tp->mii_bus);
+
+	rtl_release_firmware(tp);
+
+	if (pci_dev_run_wake(pdev))
+		pm_runtime_get_noresume(&pdev->dev);
+
+	/* restore original MAC address */
+	rtl_rar_set(tp, dev->perm_addr);
+}
+
+static const struct net_device_ops rtl_netdev_ops = {
+	.ndo_open		= rtl_open,
+	.ndo_stop		= rtl8169_close,
+	.ndo_get_stats64	= rtl8169_get_stats64,
+	.ndo_start_xmit		= rtl8169_start_xmit,
+	.ndo_tx_timeout		= rtl8169_tx_timeout,
+	.ndo_validate_addr	= eth_validate_addr,
+	.ndo_change_mtu		= rtl8169_change_mtu,
+	.ndo_fix_features	= rtl8169_fix_features,
+	.ndo_set_features	= rtl8169_set_features,
+	.ndo_set_mac_address	= rtl_set_mac_address,
+	.ndo_do_ioctl		= rtl8169_ioctl,
+	.ndo_set_rx_mode	= rtl_set_rx_mode,
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	.ndo_poll_controller	= rtl8169_netpoll,
+#endif
+
+};
+
+static const struct rtl_cfg_info {
+	void (*hw_start)(struct rtl8169_private *tp);
+	u16 event_slow;
+	unsigned int has_gmii:1;
+	const struct rtl_coalesce_info *coalesce_info;
+	u8 default_ver;
+} rtl_cfg_infos [] = {
+	[RTL_CFG_0] = {
+		.hw_start	= rtl_hw_start_8169,
+		.event_slow	= SYSErr | LinkChg | RxOverflow | RxFIFOOver,
+		.has_gmii	= 1,
+		.coalesce_info	= rtl_coalesce_info_8169,
+		.default_ver	= RTL_GIGA_MAC_VER_01,
+	},
+	[RTL_CFG_1] = {
+		.hw_start	= rtl_hw_start_8168,
+		.event_slow	= SYSErr | LinkChg | RxOverflow,
+		.has_gmii	= 1,
+		.coalesce_info	= rtl_coalesce_info_8168_8136,
+		.default_ver	= RTL_GIGA_MAC_VER_11,
+	},
+	[RTL_CFG_2] = {
+		.hw_start	= rtl_hw_start_8101,
+		.event_slow	= SYSErr | LinkChg | RxOverflow | RxFIFOOver |
+				  PCSTimeout,
+		.coalesce_info	= rtl_coalesce_info_8168_8136,
+		.default_ver	= RTL_GIGA_MAC_VER_13,
+	}
+};
+
+static int rtl_alloc_irq(struct rtl8169_private *tp)
+{
+	unsigned int flags;
+
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_02 ... RTL_GIGA_MAC_VER_06:
+		RTL_W8(tp, Cfg9346, Cfg9346_Unlock);
+		RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~MSIEnable);
+		RTL_W8(tp, Cfg9346, Cfg9346_Lock);
+		/* fall through */
+	case RTL_GIGA_MAC_VER_07 ... RTL_GIGA_MAC_VER_17:
+		flags = PCI_IRQ_LEGACY;
+		break;
+	default:
+		flags = PCI_IRQ_ALL_TYPES;
+		break;
+	}
+
+	return pci_alloc_irq_vectors(tp->pci_dev, 1, 1, flags);
+}
+
+DECLARE_RTL_COND(rtl_link_list_ready_cond)
+{
+	return RTL_R8(tp, MCU) & LINK_LIST_RDY;
+}
+
+DECLARE_RTL_COND(rtl_rxtx_empty_cond)
+{
+	return (RTL_R8(tp, MCU) & RXTX_EMPTY) == RXTX_EMPTY;
+}
+
+static int r8169_mdio_read_reg(struct mii_bus *mii_bus, int phyaddr, int phyreg)
+{
+	struct rtl8169_private *tp = mii_bus->priv;
+
+	if (phyaddr > 0)
+		return -ENODEV;
+
+	return rtl_readphy(tp, phyreg);
+}
+
+static int r8169_mdio_write_reg(struct mii_bus *mii_bus, int phyaddr,
+				int phyreg, u16 val)
+{
+	struct rtl8169_private *tp = mii_bus->priv;
+
+	if (phyaddr > 0)
+		return -ENODEV;
+
+	rtl_writephy(tp, phyreg, val);
+
+	return 0;
+}
+
+static int r8169_mdio_register(struct rtl8169_private *tp)
+{
+	struct pci_dev *pdev = tp->pci_dev;
+	struct phy_device *phydev;
+	struct mii_bus *new_bus;
+	int ret;
+
+	new_bus = devm_mdiobus_alloc(&pdev->dev);
+	if (!new_bus)
+		return -ENOMEM;
+
+	new_bus->name = "r8169";
+	new_bus->priv = tp;
+	new_bus->parent = &pdev->dev;
+	new_bus->irq[0] = PHY_IGNORE_INTERRUPT;
+	snprintf(new_bus->id, MII_BUS_ID_SIZE, "r8169-%x",
+		 PCI_DEVID(pdev->bus->number, pdev->devfn));
+
+	new_bus->read = r8169_mdio_read_reg;
+	new_bus->write = r8169_mdio_write_reg;
+
+	ret = mdiobus_register(new_bus);
+	if (ret)
+		return ret;
+
+	phydev = mdiobus_get_phy(new_bus, 0);
+	if (!phydev) {
+		mdiobus_unregister(new_bus);
+		return -ENODEV;
+	}
+
+	/* PHY will be woken up in rtl_open() */
+	phy_suspend(phydev);
+
+	tp->mii_bus = new_bus;
+
+	return 0;
+}
+
+static void rtl_hw_init_8168g(struct rtl8169_private *tp)
+{
+	u32 data;
+
+	tp->ocp_base = OCP_STD_PHY_BASE;
+
+	RTL_W32(tp, MISC, RTL_R32(tp, MISC) | RXDV_GATED_EN);
+
+	if (!rtl_udelay_loop_wait_high(tp, &rtl_txcfg_empty_cond, 100, 42))
+		return;
+
+	if (!rtl_udelay_loop_wait_high(tp, &rtl_rxtx_empty_cond, 100, 42))
+		return;
+
+	RTL_W8(tp, ChipCmd, RTL_R8(tp, ChipCmd) & ~(CmdTxEnb | CmdRxEnb));
+	msleep(1);
+	RTL_W8(tp, MCU, RTL_R8(tp, MCU) & ~NOW_IS_OOB);
+
+	data = r8168_mac_ocp_read(tp, 0xe8de);
+	data &= ~(1 << 14);
+	r8168_mac_ocp_write(tp, 0xe8de, data);
+
+	if (!rtl_udelay_loop_wait_high(tp, &rtl_link_list_ready_cond, 100, 42))
+		return;
+
+	data = r8168_mac_ocp_read(tp, 0xe8de);
+	data |= (1 << 15);
+	r8168_mac_ocp_write(tp, 0xe8de, data);
+
+	if (!rtl_udelay_loop_wait_high(tp, &rtl_link_list_ready_cond, 100, 42))
+		return;
+}
+
+static void rtl_hw_init_8168ep(struct rtl8169_private *tp)
+{
+	rtl8168ep_stop_cmac(tp);
+	rtl_hw_init_8168g(tp);
+}
+
+static void rtl_hw_initialize(struct rtl8169_private *tp)
+{
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_48:
+		rtl_hw_init_8168g(tp);
+		break;
+	case RTL_GIGA_MAC_VER_49 ... RTL_GIGA_MAC_VER_51:
+		rtl_hw_init_8168ep(tp);
+		break;
+	default:
+		break;
+	}
+}
+
+/* Versions RTL8102e and from RTL8168c onwards support csum_v2 */
+static bool rtl_chip_supports_csum_v2(struct rtl8169_private *tp)
+{
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_01 ... RTL_GIGA_MAC_VER_06:
+	case RTL_GIGA_MAC_VER_10 ... RTL_GIGA_MAC_VER_17:
+		return false;
+	default:
+		return true;
+	}
+}
+
+static int rtl_jumbo_max(struct rtl8169_private *tp)
+{
+	/* Non-GBit versions don't support jumbo frames */
+	if (!tp->supports_gmii)
+		return JUMBO_1K;
+
+	switch (tp->mac_version) {
+	/* RTL8169 */
+	case RTL_GIGA_MAC_VER_01 ... RTL_GIGA_MAC_VER_06:
+		return JUMBO_7K;
+	/* RTL8168b */
+	case RTL_GIGA_MAC_VER_11:
+	case RTL_GIGA_MAC_VER_12:
+	case RTL_GIGA_MAC_VER_17:
+		return JUMBO_4K;
+	/* RTL8168c */
+	case RTL_GIGA_MAC_VER_18 ... RTL_GIGA_MAC_VER_24:
+		return JUMBO_6K;
+	default:
+		return JUMBO_9K;
+	}
+}
+
+static void rtl_disable_clk(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
+static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	const struct rtl_cfg_info *cfg = rtl_cfg_infos + ent->driver_data;
+	struct rtl8169_private *tp;
+	struct net_device *dev;
+	int chipset, region, i;
+	int jumbo_max, rc;
+
+	dev = devm_alloc_etherdev(&pdev->dev, sizeof (*tp));
+	if (!dev)
+		return -ENOMEM;
+
+	SET_NETDEV_DEV(dev, &pdev->dev);
+	dev->netdev_ops = &rtl_netdev_ops;
+	tp = netdev_priv(dev);
+	tp->dev = dev;
+	tp->pci_dev = pdev;
+	tp->msg_enable = netif_msg_init(debug.msg_enable, R8169_MSG_DEFAULT);
+	tp->supports_gmii = cfg->has_gmii;
+
+	/* Get the *optional* external "ether_clk" used on some boards */
+	tp->clk = devm_clk_get(&pdev->dev, "ether_clk");
+	if (IS_ERR(tp->clk)) {
+		rc = PTR_ERR(tp->clk);
+		if (rc == -ENOENT) {
+			/* clk-core allows NULL (for suspend / resume) */
+			tp->clk = NULL;
+		} else if (rc == -EPROBE_DEFER) {
+			return rc;
+		} else {
+			dev_err(&pdev->dev, "failed to get clk: %d\n", rc);
+			return rc;
+		}
+	} else {
+		rc = clk_prepare_enable(tp->clk);
+		if (rc) {
+			dev_err(&pdev->dev, "failed to enable clk: %d\n", rc);
+			return rc;
+		}
+
+		rc = devm_add_action_or_reset(&pdev->dev, rtl_disable_clk,
+					      tp->clk);
+		if (rc)
+			return rc;
+	}
+
+	/* Disable ASPM completely as that cause random device stop working
+	 * problems as well as full system hangs for some PCIe devices users.
+	 */
+	pci_disable_link_state(pdev, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1);
+
+	/* enable device (incl. PCI PM wakeup and hotplug setup) */
+	rc = pcim_enable_device(pdev);
+	if (rc < 0) {
+		dev_err(&pdev->dev, "enable failure\n");
+		return rc;
+	}
+
+	if (pcim_set_mwi(pdev) < 0)
+		dev_info(&pdev->dev, "Mem-Wr-Inval unavailable\n");
+
+	/* use first MMIO region */
+	region = ffs(pci_select_bars(pdev, IORESOURCE_MEM)) - 1;
+	if (region < 0) {
+		dev_err(&pdev->dev, "no MMIO resource found\n");
+		return -ENODEV;
+	}
+
+	/* check for weird/broken PCI region reporting */
+	if (pci_resource_len(pdev, region) < R8169_REGS_SIZE) {
+		dev_err(&pdev->dev, "Invalid PCI region size(s), aborting\n");
+		return -ENODEV;
+	}
+
+	rc = pcim_iomap_regions(pdev, BIT(region), MODULENAME);
+	if (rc < 0) {
+		dev_err(&pdev->dev, "cannot remap MMIO, aborting\n");
+		return rc;
+	}
+
+	tp->mmio_addr = pcim_iomap_table(pdev)[region];
+
+	if (!pci_is_pcie(pdev))
+		dev_info(&pdev->dev, "not PCI Express\n");
+
+	/* Identify chip attached to board */
+	rtl8169_get_mac_version(tp, cfg->default_ver);
+
+	if (rtl_tbi_enabled(tp)) {
+		dev_err(&pdev->dev, "TBI fiber mode not supported\n");
+		return -ENODEV;
+	}
+
+	tp->cp_cmd = RTL_R16(tp, CPlusCmd);
+
+	if ((sizeof(dma_addr_t) > 4) &&
+	    (use_dac == 1 || (use_dac == -1 && pci_is_pcie(pdev) &&
+			      tp->mac_version >= RTL_GIGA_MAC_VER_18)) &&
+	    !pci_set_dma_mask(pdev, DMA_BIT_MASK(64)) &&
+	    !pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64))) {
+
+		/* CPlusCmd Dual Access Cycle is only needed for non-PCIe */
+		if (!pci_is_pcie(pdev))
+			tp->cp_cmd |= PCIDAC;
+		dev->features |= NETIF_F_HIGHDMA;
+	} else {
+		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+		if (rc < 0) {
+			dev_err(&pdev->dev, "DMA configuration failed\n");
+			return rc;
+		}
+	}
+
+	rtl_init_rxcfg(tp);
+
+	rtl_irq_disable(tp);
+
+	rtl_hw_initialize(tp);
+
+	rtl_hw_reset(tp);
+
+	rtl_ack_events(tp, 0xffff);
+
+	pci_set_master(pdev);
+
+	rtl_init_mdio_ops(tp);
+	rtl_init_jumbo_ops(tp);
+
+	rtl8169_print_mac_version(tp);
+
+	chipset = tp->mac_version;
+
+	rc = rtl_alloc_irq(tp);
+	if (rc < 0) {
+		dev_err(&pdev->dev, "Can't allocate interrupt\n");
+		return rc;
+	}
+
+	tp->saved_wolopts = __rtl8169_get_wol(tp);
+
+	mutex_init(&tp->wk.mutex);
+	u64_stats_init(&tp->rx_stats.syncp);
+	u64_stats_init(&tp->tx_stats.syncp);
+
+	/* Get MAC address */
+	switch (tp->mac_version) {
+		u8 mac_addr[ETH_ALEN] __aligned(4);
+	case RTL_GIGA_MAC_VER_35 ... RTL_GIGA_MAC_VER_38:
+	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_51:
+		*(u32 *)&mac_addr[0] = rtl_eri_read(tp, 0xe0, ERIAR_EXGMAC);
+		*(u16 *)&mac_addr[4] = rtl_eri_read(tp, 0xe4, ERIAR_EXGMAC);
+
+		if (is_valid_ether_addr(mac_addr))
+			rtl_rar_set(tp, mac_addr);
+		break;
+	default:
+		break;
+	}
+	for (i = 0; i < ETH_ALEN; i++)
+		dev->dev_addr[i] = RTL_R8(tp, MAC0 + i);
+
+	dev->ethtool_ops = &rtl8169_ethtool_ops;
+	dev->watchdog_timeo = RTL8169_TX_TIMEOUT;
+
+	netif_napi_add(dev, &tp->napi, rtl8169_poll, NAPI_POLL_WEIGHT);
+
+	/* don't enable SG, IP_CSUM and TSO by default - it might not work
+	 * properly for all devices */
+	dev->features |= NETIF_F_RXCSUM |
+		NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX;
+
+	dev->hw_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_TSO |
+		NETIF_F_RXCSUM | NETIF_F_HW_VLAN_CTAG_TX |
+		NETIF_F_HW_VLAN_CTAG_RX;
+	dev->vlan_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_TSO |
+		NETIF_F_HIGHDMA;
+	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
+
+	tp->cp_cmd |= RxChkSum | RxVlan;
+
+	/*
+	 * Pretend we are using VLANs; This bypasses a nasty bug where
+	 * Interrupts stop flowing on high load on 8110SCd controllers.
+	 */
+	if (tp->mac_version == RTL_GIGA_MAC_VER_05)
+		/* Disallow toggling */
+		dev->hw_features &= ~NETIF_F_HW_VLAN_CTAG_RX;
+
+	if (rtl_chip_supports_csum_v2(tp)) {
+		tp->tso_csum = rtl8169_tso_csum_v2;
+		dev->hw_features |= NETIF_F_IPV6_CSUM | NETIF_F_TSO6;
+	} else {
+		tp->tso_csum = rtl8169_tso_csum_v1;
+	}
+
+	dev->hw_features |= NETIF_F_RXALL;
+	dev->hw_features |= NETIF_F_RXFCS;
+
+	/* MTU range: 60 - hw-specific max */
+	dev->min_mtu = ETH_ZLEN;
+	jumbo_max = rtl_jumbo_max(tp);
+	dev->max_mtu = jumbo_max;
+
+	tp->hw_start = cfg->hw_start;
+	tp->event_slow = cfg->event_slow;
+	tp->coalesce_info = cfg->coalesce_info;
+
+	tp->rtl_fw = RTL_FIRMWARE_UNKNOWN;
+
+	tp->counters = dmam_alloc_coherent (&pdev->dev, sizeof(*tp->counters),
+					    &tp->counters_phys_addr,
+					    GFP_KERNEL);
+	if (!tp->counters)
+		return -ENOMEM;
+
+	pci_set_drvdata(pdev, dev);
+
+	rc = r8169_mdio_register(tp);
+	if (rc)
+		return rc;
+
+	/* chip gets powered up in rtl_open() */
+	rtl_pll_power_down(tp);
+
+	rc = register_netdev(dev);
+	if (rc)
+		goto err_mdio_unregister;
+
+	netif_info(tp, probe, dev, "%s, %pM, XID %08x, IRQ %d\n",
+		   rtl_chip_infos[chipset].name, dev->dev_addr,
+		   (u32)(RTL_R32(tp, TxConfig) & 0xfcf0f8ff),
+		   pci_irq_vector(pdev, 0));
+
+	if (jumbo_max > JUMBO_1K)
+		netif_info(tp, probe, dev,
+			   "jumbo features [frames: %d bytes, tx checksumming: %s]\n",
+			   jumbo_max, tp->mac_version <= RTL_GIGA_MAC_VER_06 ?
+			   "ok" : "ko");
+
+	if (r8168_check_dash(tp))
+		rtl8168_driver_start(tp);
+
+	if (pci_dev_run_wake(pdev))
+		pm_runtime_put_sync(&pdev->dev);
+
+	return 0;
+
+err_mdio_unregister:
+	mdiobus_unregister(tp->mii_bus);
+	return rc;
+}
+
+static struct pci_driver rtl8169_pci_driver = {
+	.name		= MODULENAME,
+	.id_table	= rtl8169_pci_tbl,
+	.probe		= rtl_init_one,
+	.remove		= rtl_remove_one,
+	.shutdown	= rtl_shutdown,
+	.driver.pm	= RTL8169_PM_OPS,
+};
+
+module_pci_driver(rtl8169_pci_driver);
diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c b/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c
index 302079e22b06..186f35b2b182 100644
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
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 2718b0507f71..615edcb88037 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -548,8 +548,9 @@ static int gtp_build_skb_ip4(struct sk_buff *skb, struct net_device *dev,
 
 	rt->dst.ops->update_pmtu(&rt->dst, NULL, skb, mtu, false);
 
-	if (!skb_is_gso(skb) && (iph->frag_off & htons(IP_DF)) &&
-	    mtu < ntohs(iph->tot_len)) {
+	if (iph->frag_off & htons(IP_DF) &&
+	    ((!skb_is_gso(skb) && skb->len > mtu) ||
+	     (skb_is_gso(skb) && !skb_gso_validate_network_len(skb, mtu)))) {
 		netdev_dbg(dev, "packet too big, fragmentation needed\n");
 		icmp_ndo_send(skb, ICMP_DEST_UNREACH, ICMP_FRAG_NEEDED,
 			      htonl(mtu));
diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 09281aca86c2..74397381e7d7 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -439,7 +439,7 @@ static const struct ocotp_params imx6sl_params = {
 };
 
 static const struct ocotp_params imx6sll_params = {
-	.nregs = 128,
+	.nregs = 80,
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 };
@@ -451,7 +451,7 @@ static const struct ocotp_params imx6sx_params = {
 };
 
 static const struct ocotp_params imx6ul_params = {
-	.nregs = 128,
+	.nregs = 144,
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 };
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index fa9d6c8f1cf8..3a165710fbb8 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -599,7 +599,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,	PCI_DEVICE_ID_ATI_RS100,   quirk_ati_
 /*
  * In the AMD NL platform, this device ([1022:7912]) has a class code of
  * PCI_CLASS_SERIAL_USB_XHCI (0x0c0330), which means the xhci driver will
- * claim it.
+ * claim it. The same applies on the VanGogh platform device ([1022:163a]).
  *
  * But the dwc3 driver is a more specific driver for this device, and we'd
  * prefer to use it instead of xhci. To prevent xhci from claiming the
@@ -607,7 +607,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,	PCI_DEVICE_ID_ATI_RS100,   quirk_ati_
  * defines as "USB device (not host controller)". The dwc3 driver can then
  * claim it based on its Vendor and Device ID.
  */
-static void quirk_amd_nl_class(struct pci_dev *pdev)
+static void quirk_amd_dwc_class(struct pci_dev *pdev)
 {
 	u32 class = pdev->class;
 
@@ -617,7 +617,9 @@ static void quirk_amd_nl_class(struct pci_dev *pdev)
 		 class, pdev->class);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_NL_USB,
-		quirk_amd_nl_class);
+		quirk_amd_dwc_class);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VANGOGH_USB,
+		quirk_amd_dwc_class);
 
 /*
  * Let's make the southbridge information explicit instead of having to
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
index 02e39778d3c6..48d2fb187a1b 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1379,6 +1379,7 @@ static void qcom_glink_rpdev_release(struct device *dev)
 	struct glink_channel *channel = to_glink_channel(rpdev->ept);
 
 	channel->rpdev = NULL;
+	kfree(rpdev->driver_override);
 	kfree(rpdev);
 }
 
diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 65834153ba97..880c7c4deec3 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -332,7 +332,8 @@ field##_store(struct device *dev, struct device_attribute *attr,	\
 	      const char *buf, size_t sz)				\
 {									\
 	struct rpmsg_device *rpdev = to_rpmsg_device(dev);		\
-	char *new, *old;						\
+	const char *old;						\
+	char *new;							\
 									\
 	new = kstrndup(buf, sz, GFP_KERNEL);				\
 	if (!new)							\
@@ -524,24 +525,52 @@ static struct bus_type rpmsg_bus = {
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
index 0d791c30b7ea..ebd53616ef5d 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -83,10 +83,7 @@ struct device *rpmsg_find_device(struct device *parent,
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
index c8d97dc2ca63..bf659bc466dc 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -11182,8 +11182,10 @@ _mpt3sas_init(void)
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
index 2c224bf70cfd..d05b155b4867 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -4771,6 +4771,12 @@ static const struct pci_device_id serial_pci_tbl[] = {
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
@@ -4798,10 +4804,14 @@ static const struct pci_device_id serial_pci_tbl[] = {
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
@@ -4837,6 +4847,14 @@ static const struct pci_device_id serial_pci_tbl[] = {
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
@@ -4847,6 +4865,14 @@ static const struct pci_device_id serial_pci_tbl[] = {
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
@@ -4861,6 +4887,10 @@ static const struct pci_device_id serial_pci_tbl[] = {
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
@@ -4872,6 +4902,10 @@ static const struct pci_device_id serial_pci_tbl[] = {
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
@@ -4884,12 +4918,94 @@ static const struct pci_device_id serial_pci_tbl[] = {
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
diff --git a/drivers/usb/storage/unusual_cypress.h b/drivers/usb/storage/unusual_cypress.h
index fb99e526cd48..7f7534098d53 100644
--- a/drivers/usb/storage/unusual_cypress.h
+++ b/drivers/usb/storage/unusual_cypress.h
@@ -19,7 +19,7 @@ UNUSUAL_DEV(  0x04b4, 0x6831, 0x0000, 0x9999,
 		"Cypress ISD-300LP",
 		USB_SC_CYP_ATACB, USB_PR_DEVICE, NULL, 0),
 
-UNUSUAL_DEV( 0x14cd, 0x6116, 0x0160, 0x0160,
+UNUSUAL_DEV( 0x14cd, 0x6116, 0x0150, 0x0160,
 		"Super Top",
 		"USB 2.0  SATA BRIDGE",
 		USB_SC_CYP_ATACB, USB_PR_DEVICE, NULL, 0),
diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index 05111e90f168..5ef008e9c61c 100644
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
index f6ebca883912..1ded93f106f0 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -1932,10 +1932,10 @@ static void uvesafb_exit(void)
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
index 1afcbef397ab..017444b3f745 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -345,7 +345,11 @@ static inline s64 towards_target(struct virtio_balloon *vb)
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
 
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 07be3a374efb..3597d7b7feda 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -561,14 +561,17 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 	spin_lock_init(&vm_dev->lock);
 
 	vm_dev->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(vm_dev->base))
-		return PTR_ERR(vm_dev->base);
+	if (IS_ERR(vm_dev->base)) {
+		rc = PTR_ERR(vm_dev->base);
+		goto free_vm_dev;
+	}
 
 	/* Check magic value */
 	magic = readl(vm_dev->base + VIRTIO_MMIO_MAGIC_VALUE);
 	if (magic != ('v' | 'i' << 8 | 'r' << 16 | 't' << 24)) {
 		dev_warn(&pdev->dev, "Wrong magic value 0x%08lx!\n", magic);
-		return -ENODEV;
+		rc = -ENODEV;
+		goto free_vm_dev;
 	}
 
 	/* Check device version */
@@ -576,7 +579,8 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 	if (vm_dev->version < 1 || vm_dev->version > 2) {
 		dev_err(&pdev->dev, "Version %ld not supported!\n",
 				vm_dev->version);
-		return -ENXIO;
+		rc = -ENXIO;
+		goto free_vm_dev;
 	}
 
 	vm_dev->vdev.id.device = readl(vm_dev->base + VIRTIO_MMIO_DEVICE_ID);
@@ -585,7 +589,8 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 		 * virtio-mmio device with an ID 0 is a (dummy) placeholder
 		 * with no function. End probing now with no error reported.
 		 */
-		return -ENODEV;
+		rc = -ENODEV;
+		goto free_vm_dev;
 	}
 	vm_dev->vdev.id.vendor = readl(vm_dev->base + VIRTIO_MMIO_VENDOR_ID);
 
@@ -615,6 +620,10 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 		put_device(&vm_dev->vdev.dev);
 
 	return rc;
+
+free_vm_dev:
+	kfree(vm_dev);
+	return rc;
 }
 
 static int virtio_mmio_remove(struct platform_device *pdev)
diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index ea1d8cfab430..117dc475bea8 100644
--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -706,8 +706,13 @@ static struct rdma_cm_id *smbd_create_id(
 		log_rdma_event(ERR, "rdma_resolve_addr() failed %i\n", rc);
 		goto out;
 	}
-	wait_for_completion_interruptible_timeout(
+	rc = wait_for_completion_interruptible_timeout(
 		&info->ri_done, msecs_to_jiffies(RDMA_RESOLVE_TIMEOUT));
+	/* e.g. if interrupted returns -ERESTARTSYS */
+	if (rc < 0) {
+		log_rdma_event(ERR, "rdma_resolve_addr timeout rc: %i\n", rc);
+		goto out;
+	}
 	rc = info->ri_rc;
 	if (rc) {
 		log_rdma_event(ERR, "rdma_resolve_addr() completed %i\n", rc);
@@ -720,8 +725,13 @@ static struct rdma_cm_id *smbd_create_id(
 		log_rdma_event(ERR, "rdma_resolve_route() failed %i\n", rc);
 		goto out;
 	}
-	wait_for_completion_interruptible_timeout(
+	rc = wait_for_completion_interruptible_timeout(
 		&info->ri_done, msecs_to_jiffies(RDMA_RESOLVE_TIMEOUT));
+	/* e.g. if interrupted returns -ERESTARTSYS */
+	if (rc < 0)  {
+		log_rdma_event(ERR, "rdma_resolve_addr timeout rc: %i\n", rc);
+		goto out;
+	}
 	rc = info->ri_rc;
 	if (rc) {
 		log_rdma_event(ERR, "rdma_resolve_route() completed %i\n", rc);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index ff447bbb5248..fb4494c54484 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -958,7 +958,8 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 
 		if (phase == 3) {
 			inode = f2fs_iget(sb, dni.ino);
-			if (IS_ERR(inode) || is_bad_inode(inode))
+			if (IS_ERR(inode) || is_bad_inode(inode) ||
+					special_file(inode->i_mode))
 				continue;
 
 			if (!down_write_trylock(
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index ec0fd6b3d185..65aaa6eaad2c 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -598,9 +598,8 @@ nfs_lock_and_join_requests(struct page *page)
 
 static void nfs_write_error_remove_page(struct nfs_page *req)
 {
+	SetPageError(req->wb_page);
 	nfs_end_page_writeback(req);
-	generic_error_remove_page(page_file_mapping(req->wb_page),
-				  req->wb_page);
 	nfs_release_request(req);
 }
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 28e7f86c8c94..a7231d17e359 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1691,6 +1691,12 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
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
@@ -1724,12 +1730,6 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
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
index 37e359d81a86..bccd367c11de 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -330,6 +330,8 @@ extern int __must_check driver_create_file(struct device_driver *driver,
 extern void driver_remove_file(struct device_driver *driver,
 			       const struct driver_attribute *attr);
 
+int driver_set_override(struct device *dev, const char **override,
+			const char *s, size_t len);
 extern int __must_check driver_for_each_device(struct device_driver *drv,
 					       struct device *start,
 					       void *data,
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 78c1cd4dfdc0..76d5490231a7 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -553,6 +553,7 @@
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F3 0x15eb
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F3 0x1493
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
+#define PCI_DEVICE_ID_AMD_VANGOGH_USB	0x163a
 #define PCI_DEVICE_ID_AMD_19H_DF_F3	0x1653
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 9e5c98fcea8c..8268439975b2 100644
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
index a68972b097b7..267533fecbdd 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -41,7 +41,9 @@ struct rpmsg_channel_info {
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
@@ -50,7 +52,7 @@ struct rpmsg_channel_info {
 struct rpmsg_device {
 	struct device dev;
 	struct rpmsg_device_id id;
-	char *driver_override;
+	const char *driver_override;
 	u32 src;
 	u32 dst;
 	struct rpmsg_endpoint *ept;
@@ -113,6 +115,8 @@ struct rpmsg_driver {
 
 #if IS_ENABLED(CONFIG_RPMSG)
 
+int rpmsg_register_device_override(struct rpmsg_device *rpdev,
+				   const char *driver_override);
 int register_rpmsg_device(struct rpmsg_device *dev);
 void unregister_rpmsg_device(struct rpmsg_device *dev);
 int __register_rpmsg_driver(struct rpmsg_driver *drv, struct module *owner);
@@ -137,6 +141,12 @@ __poll_t rpmsg_poll(struct rpmsg_endpoint *ept, struct file *filp,
 
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
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8f3f3cc08496..3c8eb5d84214 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11629,7 +11629,8 @@ static int inherit_group(struct perf_event *parent_event,
 		if (IS_ERR(child_ctr))
 			return PTR_ERR(child_ctr);
 	}
-	leader->group_generation = parent_event->group_generation;
+	if (leader)
+		leader->group_generation = parent_event->group_generation;
 	return 0;
 }
 
diff --git a/lib/kobject.c b/lib/kobject.c
index 2bab65232925..a45eb05c79fe 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -135,7 +135,7 @@ static int get_kobj_path_length(struct kobject *kobj)
 	return length;
 }
 
-static void fill_kobj_path(struct kobject *kobj, char *path, int length)
+static int fill_kobj_path(struct kobject *kobj, char *path, int length)
 {
 	struct kobject *parent;
 
@@ -144,12 +144,16 @@ static void fill_kobj_path(struct kobject *kobj, char *path, int length)
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
@@ -165,13 +169,17 @@ char *kobject_get_path(struct kobject *kobj, gfp_t gfp_mask)
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
diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index da05c4d82b94..1735bcb07381 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -631,8 +631,8 @@ nfulnl_log_packet(struct net *net,
 	unsigned int plen = 0;
 	struct nfnl_log_net *log = nfnl_log_pernet(net);
 	const struct nfnl_ct_hook *nfnl_ct = NULL;
+	enum ip_conntrack_info ctinfo = 0;
 	struct nf_conn *ct = NULL;
-	enum ip_conntrack_info ctinfo;
 
 	if (li_user && li_user->type == NF_LOG_TYPE_ULOG)
 		li = li_user;
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index d34000182f67..a713e9649b56 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3278,6 +3278,8 @@ int rt5645_set_jack_detect(struct snd_soc_component *component,
 				RT5645_GP1_PIN_IRQ, RT5645_GP1_PIN_IRQ);
 		regmap_update_bits(rt5645->regmap, RT5645_GEN_CTRL1,
 				RT5645_DIG_GATE_CTRL, RT5645_DIG_GATE_CTRL);
+		regmap_update_bits(rt5645->regmap, RT5645_DEPOP_M1,
+				RT5645_HP_CB_MASK, RT5645_HP_CB_PU);
 	}
 	rt5645_irq(0, rt5645);
 
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 64bf3560c1d1..7567ee380283 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -404,10 +404,12 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
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
@@ -416,7 +418,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 		    !cinfo->platform ||
 		    !cinfo->cpu_dai.name) {
 			dev_err(dev, "insufficient asoc_simple_card_info settings\n");
-			return -EINVAL;
+			goto err;
 		}
 
 		card->name		= (cinfo->card) ? cinfo->card : cinfo->name;
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc
new file mode 100644
index 000000000000..bc9514428dba
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc
@@ -0,0 +1,13 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test failure of registering kprobe on non unique symbol
+# requires: kprobe_events
+
+SYMBOL='name_show'
+
+# We skip this test on kernel where SYMBOL is unique or does not exist.
+if [ "$(grep -c -E "[[:alnum:]]+ t ${SYMBOL}" /proc/kallsyms)" -le '1' ]; then
+	exit_unsupported
+fi
+
+! echo "p:test_non_unique ${SYMBOL}" > kprobe_events
