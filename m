Return-Path: <linux-kernel+bounces-167363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A89EE8BA874
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB7C71C21C98
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1141509A4;
	Fri,  3 May 2024 08:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M67dR80L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D4D14A0A3;
	Fri,  3 May 2024 08:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714723956; cv=none; b=CDJseJ8SqlILjR5X7YNWdJg3bx/oSVe0Zo2lA24LtuM85L0c//s7wuWUepqwy9UMbZidrylVHmpmehBkPbdBjYgCNoTxybaNmhryhi6WrUcIzSSjn6Nkxgf7TgxU1Vs6s8OtdB/GF27bmjS9X0rASFpxaz0hk/2evvMTiHJnFps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714723956; c=relaxed/simple;
	bh=P/Ai9y7DrR1KSw0O9XUzgBbbE+eWJ29tgHRAUzjkaHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jLbF11tbsAuMIUa93WgwdreDjpjnU3vgGV3V3BnwD6YDdVvaIO2YqKXPZ3luNanc2zYq2CnLOXuslWLdv1gUOZdnebOtPjJvTnGRj9BW3/+8FdVtCbnUusCWgkSyBt+kPT0lA14jUv1rsdR+JX5PFlkj7EQrpGAjBhV6XXutvfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M67dR80L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9254C4AF19;
	Fri,  3 May 2024 08:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714723955;
	bh=P/Ai9y7DrR1KSw0O9XUzgBbbE+eWJ29tgHRAUzjkaHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M67dR80LTQYYQWul9iPLcl+MbsmchSRNclNPIe+8rkFz4VcZbRB3OZnpp7QY3i3ke
	 acujkO6BHm4bIc9FY3lT2hsRt2Ui4a3nQGhDYGFS8wfdXmFrcdJ0GDjcP7KvgLiYMM
	 vTYM6mqiuKtAIL+7HU9NXAqp3YjjEMlyspYwuqd1Bfkep/1VgEQkMXxiNoQDLHSbU4
	 dvx147fZd2/O/4QNmo7G2f6VPTNxaVV9Kk5zl3L77wQ8X/TYqOnPqAECi6u3x7b62n
	 Ahqq25CljONXTtcypETvOivgekCh9TZuyIDgreAODYESJr+WsjWgsPcSvEhi7Xrt5c
	 ifG/AyU2LDc2g==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-alpha@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Marc Zyngier <maz@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/14] alpha: sable: remove early machine support
Date: Fri,  3 May 2024 10:11:22 +0200
Message-Id: <20240503081125.67990-12-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240503081125.67990-1-arnd@kernel.org>
References: <20240503081125.67990-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The sable family (Alphaserver 2000 and 2100) comes in variants for
EV4, EV45, EV5 and EV56. Drop support for the earlier ones that
lack support for the BWX extension but keep the later 'gamma'
variant around since that works with EV56 CPUs.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/Kconfig               |  29 +--
 arch/alpha/include/asm/core_t2.h |   8 -
 arch/alpha/include/asm/irq.h     |   1 -
 arch/alpha/kernel/Makefile       |   1 -
 arch/alpha/kernel/setup.c        |  11 +-
 arch/alpha/kernel/sys_sable.c    | 294 +------------------------------
 6 files changed, 11 insertions(+), 333 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 9b8d3ce40c28..951a9c712361 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -100,7 +100,6 @@ choice
 	  EB66                EB66 21066 evaluation board
 	  EB66+               EB66+ 21066 evaluation board
 	  LX164               AlphaPC164-LX
-	  Lynx                AS 2100A
 	  Miata               Personal Workstation 433/500/600 a/au
 	  Marvel              AlphaServer ES47 / ES80 / GS1280
 	  Mikasa              AS 1000
@@ -203,12 +202,6 @@ config ALPHA_LX164
 	  A technical overview of this board is available at
 	  <http://www.unix-ag.org/Linux-Alpha/Architectures/LX164.html>.
 
-config ALPHA_LYNX
-	bool "Lynx"
-	select HAVE_EISA
-	help
-	  AlphaServer 2100A-based systems.
-
 config ALPHA_MARVEL
 	bool "Marvel"
 	help
@@ -325,9 +318,8 @@ config ALPHA_NONAME
 
 config ALPHA_EV4
 	bool
-	depends on (ALPHA_SABLE && !ALPHA_GAMMA) || ALPHA_LYNX || ALPHA_NORITAKE && !ALPHA_PRIMO || ALPHA_MIKASA && !ALPHA_PRIMO || ALPHA_CABRIOLET || ALPHA_AVANTI_CH || ALPHA_EB64P_CH || ALPHA_XL || ALPHA_NONAME || ALPHA_EB66 || ALPHA_EB66P || ALPHA_P2K
-	default y if !ALPHA_LYNX
-	default y if !ALPHA_EV5
+	depends on ALPHA_NORITAKE && !ALPHA_PRIMO || ALPHA_MIKASA && !ALPHA_PRIMO || ALPHA_CABRIOLET || ALPHA_AVANTI_CH || ALPHA_EB64P_CH || ALPHA_XL || ALPHA_NONAME || ALPHA_EB66 || ALPHA_EB66P || ALPHA_P2K
+	default y
 
 config ALPHA_LCA
 	bool
@@ -352,8 +344,8 @@ config ALPHA_EB64P
 	  Runs from standard PC power supply.
 
 config ALPHA_EV5
-	bool "EV5 CPU(s) (model 5/xxx)?" if ALPHA_LYNX
-	default y if ALPHA_RX164 || ALPHA_RAWHIDE || ALPHA_MIATA || ALPHA_LX164 || ALPHA_SX164 || ALPHA_RUFFIAN || ALPHA_SABLE && ALPHA_GAMMA || ALPHA_NORITAKE && ALPHA_PRIMO || ALPHA_MIKASA && ALPHA_PRIMO || ALPHA_PC164 || ALPHA_TAKARA || ALPHA_EB164 || ALPHA_ALCOR
+	bool
+	default y if ALPHA_RX164 || ALPHA_RAWHIDE || ALPHA_MIATA || ALPHA_LX164 || ALPHA_SX164 || ALPHA_RUFFIAN || ALPHA_SABLE || ALPHA_NORITAKE && ALPHA_PRIMO || ALPHA_MIKASA && ALPHA_PRIMO || ALPHA_PC164 || ALPHA_TAKARA || ALPHA_EB164 || ALPHA_ALCOR
 
 config ALPHA_CIA
 	bool
@@ -378,16 +370,9 @@ config ALPHA_PRIMO
 	help
 	  Say Y if you have an AS 1000 5/xxx or an AS 1000A 5/xxx.
 
-config ALPHA_GAMMA
-	bool "EV5 CPU(s) (model 5/xxx)?" if ALPHA_SABLE
-	depends on ALPHA_SABLE || ALPHA_LYNX
-	default ALPHA_LYNX
-	help
-	  Say Y if you have an AS 2000 5/xxx or an AS 2100 5/xxx.
-
 config ALPHA_T2
 	bool
-	depends on ALPHA_SABLE || ALPHA_LYNX
+	depends on ALPHA_SABLE
 	default y
 
 config ALPHA_PYXIS
@@ -471,7 +456,7 @@ config ALPHA_QEMU
 config ALPHA_SRM
 	bool "Use SRM as bootloader" if ALPHA_CABRIOLET || ALPHA_AVANTI_CH || ALPHA_EB64P || ALPHA_PC164 || ALPHA_TAKARA || ALPHA_EB164 || ALPHA_ALCOR || ALPHA_MIATA || ALPHA_LX164 || ALPHA_SX164 || ALPHA_NAUTILUS || ALPHA_NONAME
 	depends on TTY
-	default y if ALPHA_MIKASA || ALPHA_SABLE || ALPHA_LYNX || ALPHA_NORITAKE || ALPHA_DP264 || ALPHA_RAWHIDE || ALPHA_EIGER || ALPHA_WILDFIRE || ALPHA_TITAN || ALPHA_SHARK || ALPHA_MARVEL
+	default y if ALPHA_MIKASA || ALPHA_SABLE || ALPHA_NORITAKE || ALPHA_DP264 || ALPHA_RAWHIDE || ALPHA_EIGER || ALPHA_WILDFIRE || ALPHA_TITAN || ALPHA_SHARK || ALPHA_MARVEL
 	help
 	  There are two different types of booting firmware on Alphas: SRM,
 	  which is command line driven, and ARC, which uses menus and arrow
@@ -497,7 +482,7 @@ config ARCH_MAY_HAVE_PC_FDC
 
 config SMP
 	bool "Symmetric multi-processing support"
-	depends on ALPHA_SABLE || ALPHA_LYNX || ALPHA_RAWHIDE || ALPHA_DP264 || ALPHA_WILDFIRE || ALPHA_TITAN || ALPHA_GENERIC || ALPHA_SHARK || ALPHA_MARVEL
+	depends on ALPHA_SABLE || ALPHA_RAWHIDE || ALPHA_DP264 || ALPHA_WILDFIRE || ALPHA_TITAN || ALPHA_GENERIC || ALPHA_SHARK || ALPHA_MARVEL
 	help
 	  This enables support for systems with more than one CPU. If you have
 	  a system with only one CPU, say N. If you have a system with more
diff --git a/arch/alpha/include/asm/core_t2.h b/arch/alpha/include/asm/core_t2.h
index ab956b1625b5..ca9b091d9c5f 100644
--- a/arch/alpha/include/asm/core_t2.h
+++ b/arch/alpha/include/asm/core_t2.h
@@ -25,16 +25,8 @@
 #define T2_MEM_R1_MASK 0x07ffffff  /* Mem sparse region 1 mask is 27 bits */
 
 /* GAMMA-SABLE is a SABLE with EV5-based CPUs */
-/* All LYNX machines, EV4 or EV5, use the GAMMA bias also */
 #define _GAMMA_BIAS		0x8000000000UL
-
-#if defined(CONFIG_ALPHA_GENERIC)
-#define GAMMA_BIAS		alpha_mv.sys.t2.gamma_bias
-#elif defined(CONFIG_ALPHA_GAMMA)
 #define GAMMA_BIAS		_GAMMA_BIAS
-#else
-#define GAMMA_BIAS		0
-#endif
 
 /*
  * Memory spaces:
diff --git a/arch/alpha/include/asm/irq.h b/arch/alpha/include/asm/irq.h
index 432402c8e47f..442097c56934 100644
--- a/arch/alpha/include/asm/irq.h
+++ b/arch/alpha/include/asm/irq.h
@@ -55,7 +55,6 @@
 # define NR_IRQS	40
 
 #elif defined(CONFIG_ALPHA_DP264) || \
-      defined(CONFIG_ALPHA_LYNX)  || \
       defined(CONFIG_ALPHA_SHARK)
 # define NR_IRQS	64
 
diff --git a/arch/alpha/kernel/Makefile b/arch/alpha/kernel/Makefile
index 4b31060e1711..706ce8625e35 100644
--- a/arch/alpha/kernel/Makefile
+++ b/arch/alpha/kernel/Makefile
@@ -88,7 +88,6 @@ obj-$(CONFIG_ALPHA_RAWHIDE)	+= sys_rawhide.o irq_i8259.o
 obj-$(CONFIG_ALPHA_RUFFIAN)	+= sys_ruffian.o irq_pyxis.o irq_i8259.o
 obj-$(CONFIG_ALPHA_RX164)	+= sys_rx164.o irq_i8259.o
 obj-$(CONFIG_ALPHA_SABLE)	+= sys_sable.o
-obj-$(CONFIG_ALPHA_LYNX)	+= sys_sable.o
 obj-$(CONFIG_ALPHA_BOOK1)	+= sys_sio.o irq_i8259.o irq_srm.o pc873xx.o
 obj-$(CONFIG_ALPHA_AVANTI)	+= sys_sio.o irq_i8259.o irq_srm.o pc873xx.o
 obj-$(CONFIG_ALPHA_NONAME)	+= sys_sio.o irq_i8259.o irq_srm.o pc873xx.o
diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index 6e6c842ef07c..3b833bd97817 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -182,7 +182,6 @@ WEAK(eb66_mv);
 WEAK(eb66p_mv);
 WEAK(eiger_mv);
 WEAK(lx164_mv);
-WEAK(lynx_mv);
 WEAK(marvel_ev7_mv);
 WEAK(miata_mv);
 WEAK(mikasa_mv);
@@ -198,7 +197,6 @@ WEAK(privateer_mv);
 WEAK(rawhide_mv);
 WEAK(ruffian_mv);
 WEAK(rx164_mv);
-WEAK(sable_mv);
 WEAK(sable_gamma_mv);
 WEAK(shark_mv);
 WEAK(sx164_mv);
@@ -751,7 +749,7 @@ get_sysvec(unsigned long type, unsigned long variation, unsigned long cpu)
 		&alphabook1_mv,
 		&rawhide_mv,
 		NULL,		/* K2 */
-		&lynx_mv,	/* Lynx */
+		NULL,		/* Lynx */
 		&xl_mv,
 		NULL,		/* EB164 -- see variation.  */
 		NULL,		/* Noritake -- see below.  */
@@ -905,10 +903,7 @@ get_sysvec(unsigned long type, unsigned long variation, unsigned long cpu)
 				vec = &noritake_mv;
 			break;
 		case ST_DEC_2100_A500:
-			if (cpu == EV5_CPU || cpu == EV56_CPU)
-				vec = &sable_gamma_mv;
-			else
-				vec = &sable_mv;
+			vec = &sable_gamma_mv;
 			break;
 		}
 	}
@@ -932,7 +927,6 @@ get_sysvec_byname(const char *name)
 		&eb66p_mv,
 		&eiger_mv,
 		&lx164_mv,
-		&lynx_mv,
 		&miata_mv,
 		&mikasa_mv,
 		&mikasa_primo_mv,
@@ -947,7 +941,6 @@ get_sysvec_byname(const char *name)
 		&rawhide_mv,
 		&ruffian_mv,
 		&rx164_mv,
-		&sable_mv,
 		&sable_gamma_mv,
 		&shark_mv,
 		&sx164_mv,
diff --git a/arch/alpha/kernel/sys_sable.c b/arch/alpha/kernel/sys_sable.c
index 930005b2f630..49f5c75134ec 100644
--- a/arch/alpha/kernel/sys_sable.c
+++ b/arch/alpha/kernel/sys_sable.c
@@ -212,232 +212,6 @@ sable_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 }
 #endif /* defined(CONFIG_ALPHA_GENERIC) || defined(CONFIG_ALPHA_SABLE) */
 
-#if defined(CONFIG_ALPHA_GENERIC) || defined(CONFIG_ALPHA_LYNX)
-
-/***********************************************************************/
-/* LYNX hardware specifics
- */
-/*
- *   For LYNX, which is also baroque, we manage 64 IRQs, via a custom IC.
- *
- * Bit      Meaning               Kernel IRQ
- *------------------------------------------
- * 0        
- * 1        
- * 2        
- * 3        mouse			12
- * 4        
- * 5        
- * 6        keyboard			1
- * 7        floppy			6
- * 8        COM2			3
- * 9        parallel port		7
- *10        EISA irq 3			-
- *11        EISA irq 4			-
- *12        EISA irq 5			5
- *13        EISA irq 6			-
- *14        EISA irq 7			-
- *15        COM1			4
- *16        EISA irq 9			9
- *17        EISA irq 10			10
- *18        EISA irq 11			11
- *19        EISA irq 12			-
- *20        
- *21        EISA irq 14			14
- *22        EISA irq 15			15
- *23        IIC				-
- *24        VGA (builtin)               -
- *25
- *26
- *27
- *28        NCR810 (builtin)		28
- *29
- *30
- *31
- *32        PCI 0 slot 4 A primary bus  32
- *33        PCI 0 slot 4 B primary bus  33
- *34        PCI 0 slot 4 C primary bus  34
- *35        PCI 0 slot 4 D primary bus
- *36        PCI 0 slot 5 A primary bus
- *37        PCI 0 slot 5 B primary bus
- *38        PCI 0 slot 5 C primary bus
- *39        PCI 0 slot 5 D primary bus
- *40        PCI 0 slot 6 A primary bus
- *41        PCI 0 slot 6 B primary bus
- *42        PCI 0 slot 6 C primary bus
- *43        PCI 0 slot 6 D primary bus
- *44        PCI 0 slot 7 A primary bus
- *45        PCI 0 slot 7 B primary bus
- *46        PCI 0 slot 7 C primary bus
- *47        PCI 0 slot 7 D primary bus
- *48        PCI 0 slot 0 A secondary bus
- *49        PCI 0 slot 0 B secondary bus
- *50        PCI 0 slot 0 C secondary bus
- *51        PCI 0 slot 0 D secondary bus
- *52        PCI 0 slot 1 A secondary bus
- *53        PCI 0 slot 1 B secondary bus
- *54        PCI 0 slot 1 C secondary bus
- *55        PCI 0 slot 1 D secondary bus
- *56        PCI 0 slot 2 A secondary bus
- *57        PCI 0 slot 2 B secondary bus
- *58        PCI 0 slot 2 C secondary bus
- *59        PCI 0 slot 2 D secondary bus
- *60        PCI 0 slot 3 A secondary bus
- *61        PCI 0 slot 3 B secondary bus
- *62        PCI 0 slot 3 C secondary bus
- *63        PCI 0 slot 3 D secondary bus
- */
-
-static void
-lynx_update_irq_hw(unsigned long bit, unsigned long mask)
-{
-	/*
-	 * Write the AIR register on the T3/T4 with the
-	 * address of the IC mask register (offset 0x40)
-	 */
-	*(vulp)T2_AIR = 0x40;
-	mb();
-	*(vulp)T2_AIR; /* re-read to force write */
-	mb();
-	*(vulp)T2_DIR = mask;    
-	mb();
-	mb();
-}
-
-static void
-lynx_ack_irq_hw(unsigned long bit)
-{
-	*(vulp)T2_VAR = (u_long) bit;
-	mb();
-	mb();
-}
-
-static irq_swizzle_t lynx_irq_swizzle = {
-	{ /* irq_to_mask */
-		-1,  6, -1,  8, 15, 12,  7,  9,	/* pseudo PIC  0-7  */
-		-1, 16, 17, 18,  3, -1, 21, 22,	/* pseudo PIC  8-15 */
-		-1, -1, -1, -1, -1, -1, -1, -1,	/* pseudo */
-		-1, -1, -1, -1, 28, -1, -1, -1,	/* pseudo */
-		32, 33, 34, 35, 36, 37, 38, 39,	/* mask 32-39 */
-		40, 41, 42, 43, 44, 45, 46, 47,	/* mask 40-47 */
-		48, 49, 50, 51, 52, 53, 54, 55,	/* mask 48-55 */
-		56, 57, 58, 59, 60, 61, 62, 63	/* mask 56-63 */
-	},
-	{ /* mask_to_irq */
-		-1, -1, -1, 12, -1, -1,  1,  6,	/* mask 0-7   */
-		 3,  7, -1, -1,  5, -1, -1,  4,	/* mask 8-15  */
-		 9, 10, 11, -1, -1, 14, 15, -1,	/* mask 16-23 */
-		-1, -1, -1, -1, 28, -1, -1, -1,	/* mask 24-31 */
-		32, 33, 34, 35, 36, 37, 38, 39,	/* mask 32-39 */
-		40, 41, 42, 43, 44, 45, 46, 47,	/* mask 40-47 */
-		48, 49, 50, 51, 52, 53, 54, 55,	/* mask 48-55 */
-		56, 57, 58, 59, 60, 61, 62, 63	/* mask 56-63 */
-	},
-	-1,
-	lynx_update_irq_hw,
-	lynx_ack_irq_hw
-};
-
-static void __init
-lynx_init_irq(void)
-{
-	sable_lynx_irq_swizzle = &lynx_irq_swizzle;
-	sable_lynx_init_irq(64);
-}
-
-/*
- * PCI Fixup configuration for ALPHA LYNX (2100A)
- *
- * The device to slot mapping looks like:
- *
- * Slot     Device
- *  0       none
- *  1       none
- *  2       PCI-EISA bridge
- *  3       PCI-PCI bridge
- *  4       NCR 810 (Demi-Lynx only)
- *  5       none
- *  6       PCI on board slot 4
- *  7       PCI on board slot 5
- *  8       PCI on board slot 6
- *  9       PCI on board slot 7
- *
- * And behind the PPB we have:
- *
- * 11       PCI on board slot 0
- * 12       PCI on board slot 1
- * 13       PCI on board slot 2
- * 14       PCI on board slot 3
- */
-/*
- * NOTE: the IRQ assignments below are arbitrary, but need to be consistent
- * with the values in the irq swizzling tables above.
- */
-
-static int
-lynx_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	static char irq_tab[19][5] = {
-		/*INT    INTA   INTB   INTC   INTD */
-		{   -1,    -1,    -1,    -1,    -1},  /* IdSel 13,  PCEB   */
-		{   -1,    -1,    -1,    -1,    -1},  /* IdSel 14,  PPB    */
-		{   28,    28,    28,    28,    28},  /* IdSel 15,  NCR demi */
-		{   -1,    -1,    -1,    -1,    -1},  /* IdSel 16,  none   */
-		{   32,    32,    33,    34,    35},  /* IdSel 17,  slot 4 */
-		{   36,    36,    37,    38,    39},  /* IdSel 18,  slot 5 */
-		{   40,    40,    41,    42,    43},  /* IdSel 19,  slot 6 */
-		{   44,    44,    45,    46,    47},  /* IdSel 20,  slot 7 */
-		{   -1,    -1,    -1,    -1,    -1},  /* IdSel 22,  none   */
-		/* The following are actually behind the PPB. */
-		{   -1,    -1,    -1,    -1,    -1},  /* IdSel 16   none */
-		{   28,    28,    28,    28,    28},  /* IdSel 17   NCR lynx */
-		{   -1,    -1,    -1,    -1,    -1},  /* IdSel 18   none */
-		{   -1,    -1,    -1,    -1,    -1},  /* IdSel 19   none */
-		{   -1,    -1,    -1,    -1,    -1},  /* IdSel 20   none */
-		{   -1,    -1,    -1,    -1,    -1},  /* IdSel 21   none */
-		{   48,    48,    49,    50,    51},  /* IdSel 22   slot 0 */
-		{   52,    52,    53,    54,    55},  /* IdSel 23   slot 1 */
-		{   56,    56,    57,    58,    59},  /* IdSel 24   slot 2 */
-		{   60,    60,    61,    62,    63}   /* IdSel 25   slot 3 */
-	};
-	const long min_idsel = 2, max_idsel = 20, irqs_per_slot = 5;
-	return COMMON_TABLE_LOOKUP;
-}
-
-static u8
-lynx_swizzle(struct pci_dev *dev, u8 *pinp)
-{
-	int slot, pin = *pinp;
-
-	if (dev->bus->number == 0) {
-		slot = PCI_SLOT(dev->devfn);
-	}
-	/* Check for the built-in bridge */
-	else if (PCI_SLOT(dev->bus->self->devfn) == 3) {
-		slot = PCI_SLOT(dev->devfn) + 11;
-	}
-	else
-	{
-		/* Must be a card-based bridge.  */
-		do {
-			if (PCI_SLOT(dev->bus->self->devfn) == 3) {
-				slot = PCI_SLOT(dev->devfn) + 11;
-				break;
-			}
-			pin = pci_swizzle_interrupt_pin(dev, pin);
-
-			/* Move up the chain of bridges.  */
-			dev = dev->bus->self;
-			/* Slot of the next bridge.  */
-			slot = PCI_SLOT(dev->devfn);
-		} while (dev->bus->self);
-	}
-	*pinp = pin;
-	return slot;
-}
-
-#endif /* defined(CONFIG_ALPHA_GENERIC) || defined(CONFIG_ALPHA_LYNX) */
-
 /***********************************************************************/
 /* GENERIC irq routines */
 
@@ -539,40 +313,7 @@ sable_lynx_init_pci(void)
  * these games with GAMMA_BIAS.
  */
 
-#if defined(CONFIG_ALPHA_GENERIC) || \
-    (defined(CONFIG_ALPHA_SABLE) && !defined(CONFIG_ALPHA_GAMMA))
-#undef GAMMA_BIAS
-#define GAMMA_BIAS 0
-struct alpha_machine_vector sable_mv __initmv = {
-	.vector_name		= "Sable",
-	DO_EV4_MMU,
-	DO_DEFAULT_RTC,
-	DO_T2_IO,
-	.machine_check		= t2_machine_check,
-	.max_isa_dma_address	= ALPHA_SABLE_MAX_ISA_DMA_ADDRESS,
-	.min_io_address		= EISA_DEFAULT_IO_BASE,
-	.min_mem_address	= T2_DEFAULT_MEM_BASE,
-
-	.nr_irqs		= 40,
-	.device_interrupt	= sable_lynx_srm_device_interrupt,
-
-	.init_arch		= t2_init_arch,
-	.init_irq		= sable_init_irq,
-	.init_rtc		= common_init_rtc,
-	.init_pci		= sable_lynx_init_pci,
-	.kill_arch		= t2_kill_arch,
-	.pci_map_irq		= sable_map_irq,
-	.pci_swizzle		= common_swizzle,
-
-	.sys = { .t2 = {
-	    .gamma_bias		= 0
-	} }
-};
-ALIAS_MV(sable)
-#endif /* GENERIC || (SABLE && !GAMMA) */
-
-#if defined(CONFIG_ALPHA_GENERIC) || \
-    (defined(CONFIG_ALPHA_SABLE) && defined(CONFIG_ALPHA_GAMMA))
+#if defined(CONFIG_ALPHA_GENERIC) || defined(CONFIG_ALPHA_SABLE)
 #undef GAMMA_BIAS
 #define GAMMA_BIAS _GAMMA_BIAS
 struct alpha_machine_vector sable_gamma_mv __initmv = {
@@ -601,35 +342,4 @@ struct alpha_machine_vector sable_gamma_mv __initmv = {
 	} }
 };
 ALIAS_MV(sable_gamma)
-#endif /* GENERIC || (SABLE && GAMMA) */
-
-#if defined(CONFIG_ALPHA_GENERIC) || defined(CONFIG_ALPHA_LYNX)
-#undef GAMMA_BIAS
-#define GAMMA_BIAS _GAMMA_BIAS
-struct alpha_machine_vector lynx_mv __initmv = {
-	.vector_name		= "Lynx",
-	DO_EV4_MMU,
-	DO_DEFAULT_RTC,
-	DO_T2_IO,
-	.machine_check		= t2_machine_check,
-	.max_isa_dma_address	= ALPHA_SABLE_MAX_ISA_DMA_ADDRESS,
-	.min_io_address		= EISA_DEFAULT_IO_BASE,
-	.min_mem_address	= T2_DEFAULT_MEM_BASE,
-
-	.nr_irqs		= 64,
-	.device_interrupt	= sable_lynx_srm_device_interrupt,
-
-	.init_arch		= t2_init_arch,
-	.init_irq		= lynx_init_irq,
-	.init_rtc		= common_init_rtc,
-	.init_pci		= sable_lynx_init_pci,
-	.kill_arch		= t2_kill_arch,
-	.pci_map_irq		= lynx_map_irq,
-	.pci_swizzle		= lynx_swizzle,
-
-	.sys = { .t2 = {
-	    .gamma_bias		= _GAMMA_BIAS
-	} }
-};
-ALIAS_MV(lynx)
-#endif /* GENERIC || LYNX */
+#endif /* GENERIC || SABLE */
-- 
2.39.2


