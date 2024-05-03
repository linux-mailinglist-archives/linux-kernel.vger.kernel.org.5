Return-Path: <linux-kernel+bounces-167362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943228BA872
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B71811C21858
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728C214A094;
	Fri,  3 May 2024 08:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKD/qRnN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA96150997;
	Fri,  3 May 2024 08:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714723953; cv=none; b=RzTdNBa73HchsU4EIbV8Iz1POXM3W7GHWjqdlqSYQFBYrP1Sw4hXGtIV6vqPViIDQMC0GdoiomoZjBzFz9B5Kvuq3PBGkDuXWhhLReo1baXG0UYKKrgQodVfNzXSmf8mWou/KG1jU6MsZjtjWvEblcbhZrfiPoitjh9ayS2AeZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714723953; c=relaxed/simple;
	bh=LnG44BGPQfIYcCadFzWv7fNleeaJnjSqPEMt+/D15bI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=geBlAJY8mx0ZUMRmdbFZbP7T7BE5RNiAuhCSpx+l+rsFZ8UYk7FbR/+3IcKiPzdWZgYJrCJCYQXfDkra7c3QvWSX1EXzohaN9F/Psuo8sK7RgyfPmFL+bVcyBYVYo0tsoTlPstSWp7yw9wcy9TV75iCai2/8uC8h7HtbFVgp50s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKD/qRnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0622C4AF1B;
	Fri,  3 May 2024 08:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714723953;
	bh=LnG44BGPQfIYcCadFzWv7fNleeaJnjSqPEMt+/D15bI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FKD/qRnNRXoEYlztsgmgOURvrntqsBicD2fQW9mumur05kB5O6Q+svuEUD09m7bFZ
	 WFEYMcf77ThdOKejN/sMluO9YpT2XlsOppmYgcC6Yl1dPud7w5ei8mr4ngkE4D+2lw
	 LlrgTeD0HsMDdp83t53LWKD6nHCJC2U13P/HcHGVPVuRlQExUZv8o8NbaWSXhHH43D
	 sLluO/jgvqs7bik7Q1ZWe/jJL1j3VAPEb7kwfiORJ8jAJ+nB8C0m/JHaw7cDboRfjm
	 6YxLuvdtKx0pal1hHs63x9w8LjjJ5i6J9LqzlY0SouFmnDhFGrkzp2SHS+2KcecL8q
	 4NY2C8POPfvJg==
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
Subject: [PATCH 10/14] alpha: remove DECpc AXP150 (Jensen) support
Date: Fri,  3 May 2024 10:11:21 +0200
Message-Id: <20240503081125.67990-11-arnd@kernel.org>
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

This is one of the hackiest Alpha machines, and the only one without
PCI support. Removing this allows cleaning up code in eise and tty
drivers in addition to the architecture code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/driver-api/eisa.rst    |   4 +-
 arch/alpha/Kconfig                   |  18 +-
 arch/alpha/include/asm/dma-mapping.h |   4 -
 arch/alpha/include/asm/io.h          |  20 +-
 arch/alpha/include/asm/jensen.h      | 363 ---------------------------
 arch/alpha/kernel/Makefile           |   3 +-
 arch/alpha/kernel/pci-noop.c         | 114 ---------
 arch/alpha/kernel/setup.c            |  19 +-
 arch/alpha/kernel/sys_jensen.c       | 237 -----------------
 arch/alpha/kernel/traps.c            |  33 ---
 drivers/eisa/Kconfig                 |   9 +-
 drivers/eisa/virtual_root.c          |   2 +-
 drivers/input/serio/i8042-io.h       |   5 +-
 drivers/tty/serial/8250/8250.h       |   3 -
 drivers/tty/serial/8250/8250_alpha.c |  21 --
 drivers/tty/serial/8250/8250_core.c  |   4 -
 drivers/tty/serial/8250/Makefile     |   2 -
 17 files changed, 16 insertions(+), 845 deletions(-)
 delete mode 100644 arch/alpha/include/asm/jensen.h
 delete mode 100644 arch/alpha/kernel/pci-noop.c
 delete mode 100644 arch/alpha/kernel/sys_jensen.c
 delete mode 100644 drivers/tty/serial/8250/8250_alpha.c

diff --git a/Documentation/driver-api/eisa.rst b/Documentation/driver-api/eisa.rst
index 3eac11b7eb01..b33ebe1ec9ed 100644
--- a/Documentation/driver-api/eisa.rst
+++ b/Documentation/driver-api/eisa.rst
@@ -196,8 +196,8 @@ eisa_bus.disable_dev
 virtual_root.force_probe
 	Force the probing code to probe EISA slots even when it cannot find an
 	EISA compliant mainboard (nothing appears on slot 0). Defaults to 0
-	(don't force), and set to 1 (force probing) when either
-	CONFIG_ALPHA_JENSEN or CONFIG_EISA_VLB_PRIMING are set.
+	(don't force), and set to 1 (force probing) when
+	CONFIG_EISA_VLB_PRIMING is set.
 
 Random notes
 ============
diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 3afd042150f8..9b8d3ce40c28 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -10,7 +10,7 @@ config ALPHA
 	select ARCH_NO_SG_CHAIN
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select DMA_OPS if PCI
-	select FORCE_PCI if !ALPHA_JENSEN
+	select FORCE_PCI
 	select PCI_DOMAINS if PCI
 	select PCI_SYSCALL if PCI
 	select HAVE_ASM_MODVERSIONS
@@ -99,7 +99,6 @@ choice
 	  EB64+               EB64+ 21064 evaluation board
 	  EB66                EB66 21066 evaluation board
 	  EB66+               EB66+ 21066 evaluation board
-	  Jensen              DECpc 150, DEC 2000 models 300, 500
 	  LX164               AlphaPC164-LX
 	  Lynx                AS 2100A
 	  Miata               Personal Workstation 433/500/600 a/au
@@ -198,17 +197,6 @@ config ALPHA_EIGER
 	  Apparently an obscure OEM single-board computer based on the
 	  Typhoon/Tsunami chipset family. Information on it is scanty.
 
-config ALPHA_JENSEN
-	bool "Jensen"
-	select HAVE_EISA
-	help
-	  DEC PC 150 AXP (aka Jensen): This is a very old Digital system - one
-	  of the first-generation Alpha systems. A number of these systems
-	  seem to be available on the second- hand market. The Jensen is a
-	  floor-standing tower system which originally used a 150MHz 21064 It
-	  used programmable logic to interface a 486 EISA I/O bridge to the
-	  CPU.
-
 config ALPHA_LX164
 	bool "LX164"
 	help
@@ -337,7 +325,7 @@ config ALPHA_NONAME
 
 config ALPHA_EV4
 	bool
-	depends on ALPHA_JENSEN || (ALPHA_SABLE && !ALPHA_GAMMA) || ALPHA_LYNX || ALPHA_NORITAKE && !ALPHA_PRIMO || ALPHA_MIKASA && !ALPHA_PRIMO || ALPHA_CABRIOLET || ALPHA_AVANTI_CH || ALPHA_EB64P_CH || ALPHA_XL || ALPHA_NONAME || ALPHA_EB66 || ALPHA_EB66P || ALPHA_P2K
+	depends on (ALPHA_SABLE && !ALPHA_GAMMA) || ALPHA_LYNX || ALPHA_NORITAKE && !ALPHA_PRIMO || ALPHA_MIKASA && !ALPHA_PRIMO || ALPHA_CABRIOLET || ALPHA_AVANTI_CH || ALPHA_EB64P_CH || ALPHA_XL || ALPHA_NONAME || ALPHA_EB66 || ALPHA_EB66P || ALPHA_P2K
 	default y if !ALPHA_LYNX
 	default y if !ALPHA_EV5
 
@@ -483,7 +471,7 @@ config ALPHA_QEMU
 config ALPHA_SRM
 	bool "Use SRM as bootloader" if ALPHA_CABRIOLET || ALPHA_AVANTI_CH || ALPHA_EB64P || ALPHA_PC164 || ALPHA_TAKARA || ALPHA_EB164 || ALPHA_ALCOR || ALPHA_MIATA || ALPHA_LX164 || ALPHA_SX164 || ALPHA_NAUTILUS || ALPHA_NONAME
 	depends on TTY
-	default y if ALPHA_JENSEN || ALPHA_MIKASA || ALPHA_SABLE || ALPHA_LYNX || ALPHA_NORITAKE || ALPHA_DP264 || ALPHA_RAWHIDE || ALPHA_EIGER || ALPHA_WILDFIRE || ALPHA_TITAN || ALPHA_SHARK || ALPHA_MARVEL
+	default y if ALPHA_MIKASA || ALPHA_SABLE || ALPHA_LYNX || ALPHA_NORITAKE || ALPHA_DP264 || ALPHA_RAWHIDE || ALPHA_EIGER || ALPHA_WILDFIRE || ALPHA_TITAN || ALPHA_SHARK || ALPHA_MARVEL
 	help
 	  There are two different types of booting firmware on Alphas: SRM,
 	  which is command line driven, and ARC, which uses menus and arrow
diff --git a/arch/alpha/include/asm/dma-mapping.h b/arch/alpha/include/asm/dma-mapping.h
index 6ce7e2041685..ad5a59b035cb 100644
--- a/arch/alpha/include/asm/dma-mapping.h
+++ b/arch/alpha/include/asm/dma-mapping.h
@@ -6,11 +6,7 @@ extern const struct dma_map_ops alpha_pci_ops;
 
 static inline const struct dma_map_ops *get_arch_dma_ops(void)
 {
-#ifdef CONFIG_ALPHA_JENSEN
-	return NULL;
-#else
 	return &alpha_pci_ops;
-#endif
 }
 
 #endif	/* _ALPHA_DMA_MAPPING_H */
diff --git a/arch/alpha/include/asm/io.h b/arch/alpha/include/asm/io.h
index 4f47a5003fe8..0c54ddb5b33e 100644
--- a/arch/alpha/include/asm/io.h
+++ b/arch/alpha/include/asm/io.h
@@ -209,8 +209,6 @@ static inline int generic_is_mmio(const volatile void __iomem *a)
 # include <asm/core_cia.h>
 #elif defined(CONFIG_ALPHA_IRONGATE)
 # include <asm/core_irongate.h>
-#elif defined(CONFIG_ALPHA_JENSEN)
-# include <asm/jensen.h>
 #elif defined(CONFIG_ALPHA_LCA)
 # include <asm/core_lca.h>
 #elif defined(CONFIG_ALPHA_MARVEL)
@@ -631,23 +629,7 @@ extern void outsl (unsigned long port, const void *src, unsigned long count);
 #define outsw outsw
 #define outsl outsl
 
-/*
- * The Alpha Jensen hardware for some rather strange reason puts
- * the RTC clock at 0x170 instead of 0x70. Probably due to some
- * misguided idea about using 0x70 for NMI stuff.
- *
- * These defines will override the defaults when doing RTC queries
- */
-
-#ifdef CONFIG_ALPHA_GENERIC
-# define RTC_PORT(x)	((x) + alpha_mv.rtc_port)
-#else
-# ifdef CONFIG_ALPHA_JENSEN
-#  define RTC_PORT(x)	(0x170+(x))
-# else
-#  define RTC_PORT(x)	(0x70 + (x))
-# endif
-#endif
+#define RTC_PORT(x)	(0x70 + (x))
 #define RTC_ALWAYS_BCD	0
 
 /*
diff --git a/arch/alpha/include/asm/jensen.h b/arch/alpha/include/asm/jensen.h
deleted file mode 100644
index 66eb049eb421..000000000000
--- a/arch/alpha/include/asm/jensen.h
+++ /dev/null
@@ -1,363 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ALPHA_JENSEN_H
-#define __ALPHA_JENSEN_H
-
-#include <asm/compiler.h>
-
-/*
- * Defines for the AlphaPC EISA IO and memory address space.
- */
-
-/*
- * NOTE! The memory operations do not set any memory barriers, as it's
- * not needed for cases like a frame buffer that is essentially memory-like.
- * You need to do them by hand if the operations depend on ordering.
- *
- * Similarly, the port IO operations do a "mb" only after a write operation:
- * if an mb is needed before (as in the case of doing memory mapped IO
- * first, and then a port IO operation to the same device), it needs to be
- * done by hand.
- *
- * After the above has bitten me 100 times, I'll give up and just do the
- * mb all the time, but right now I'm hoping this will work out.  Avoiding
- * mb's may potentially be a noticeable speed improvement, but I can't
- * honestly say I've tested it.
- *
- * Handling interrupts that need to do mb's to synchronize to non-interrupts
- * is another fun race area.  Don't do it (because if you do, I'll have to
- * do *everything* with interrupts disabled, ugh).
- */
-
-/*
- * EISA Interrupt Acknowledge address
- */
-#define EISA_INTA		(IDENT_ADDR + 0x100000000UL)
-
-/*
- * FEPROM addresses
- */
-#define EISA_FEPROM0		(IDENT_ADDR + 0x180000000UL)
-#define EISA_FEPROM1		(IDENT_ADDR + 0x1A0000000UL)
-
-/*
- * VL82C106 base address
- */
-#define EISA_VL82C106		(IDENT_ADDR + 0x1C0000000UL)
-
-/*
- * EISA "Host Address Extension" address (bits 25-31 of the EISA address)
- */
-#define EISA_HAE		(IDENT_ADDR + 0x1D0000000UL)
-
-/*
- * "SYSCTL" register address
- */
-#define EISA_SYSCTL		(IDENT_ADDR + 0x1E0000000UL)
-
-/*
- * "spare" register address
- */
-#define EISA_SPARE		(IDENT_ADDR + 0x1F0000000UL)
-
-/*
- * EISA memory address offset
- */
-#define EISA_MEM		(IDENT_ADDR + 0x200000000UL)
-
-/*
- * EISA IO address offset
- */
-#define EISA_IO			(IDENT_ADDR + 0x300000000UL)
-
-
-#ifdef __KERNEL__
-
-#ifndef __EXTERN_INLINE
-#define __EXTERN_INLINE extern inline
-#define __IO_EXTERN_INLINE
-#endif
-
-/*
- * Handle the "host address register". This needs to be set
- * to the high 7 bits of the EISA address.  This is also needed
- * for EISA IO addresses, which are only 16 bits wide (the
- * hae needs to be set to 0).
- *
- * HAE isn't needed for the local IO operations, though.
- */
-
-#define JENSEN_HAE_ADDRESS	EISA_HAE
-#define JENSEN_HAE_MASK		0x1ffffff
-
-__EXTERN_INLINE void jensen_set_hae(unsigned long addr)
-{
-	/* hae on the Jensen is bits 31:25 shifted right */
-	addr >>= 25;
-	if (addr != alpha_mv.hae_cache)
-		set_hae(addr);
-}
-
-#define vuip	volatile unsigned int *
-#define vulp	volatile unsigned long *
-
-/*
- * IO functions
- *
- * The "local" functions are those that don't go out to the EISA bus,
- * but instead act on the VL82C106 chip directly.. This is mainly the
- * keyboard, RTC,  printer and first two serial lines..
- *
- * The local stuff makes for some complications, but it seems to be
- * gone in the PCI version. I hope I can get DEC suckered^H^H^H^H^H^H^H^H
- * convinced that I need one of the newer machines.
- */
-
-__EXTERN_INLINE unsigned int jensen_local_inb(unsigned long addr)
-{
-	return 0xff & *(vuip)((addr << 9) + EISA_VL82C106);
-}
-
-__EXTERN_INLINE void jensen_local_outb(u8 b, unsigned long addr)
-{
-	*(vuip)((addr << 9) + EISA_VL82C106) = b;
-	mb();
-}
-
-__EXTERN_INLINE unsigned int jensen_bus_inb(unsigned long addr)
-{
-	long result;
-
-	jensen_set_hae(0);
-	result = *(volatile int *)((addr << 7) + EISA_IO + 0x00);
-	return __kernel_extbl(result, addr & 3);
-}
-
-__EXTERN_INLINE void jensen_bus_outb(u8 b, unsigned long addr)
-{
-	jensen_set_hae(0);
-	*(vuip)((addr << 7) + EISA_IO + 0x00) = b * 0x01010101;
-	mb();
-}
-
-/*
- * It seems gcc is not very good at optimizing away logical
- * operations that result in operations across inline functions.
- * Which is why this is a macro.
- */
-
-#define jensen_is_local(addr) ( \
-/* keyboard */	(addr == 0x60 || addr == 0x64) || \
-/* RTC */	(addr == 0x170 || addr == 0x171) || \
-/* mb COM2 */	(addr >= 0x2f8 && addr <= 0x2ff) || \
-/* mb LPT1 */	(addr >= 0x3bc && addr <= 0x3be) || \
-/* mb COM2 */	(addr >= 0x3f8 && addr <= 0x3ff))
-
-__EXTERN_INLINE u8 jensen_inb(unsigned long addr)
-{
-	if (jensen_is_local(addr))
-		return jensen_local_inb(addr);
-	else
-		return jensen_bus_inb(addr);
-}
-
-__EXTERN_INLINE void jensen_outb(u8 b, unsigned long addr)
-{
-	if (jensen_is_local(addr))
-		jensen_local_outb(b, addr);
-	else
-		jensen_bus_outb(b, addr);
-}
-
-__EXTERN_INLINE u16 jensen_inw(unsigned long addr)
-{
-	long result;
-
-	jensen_set_hae(0);
-	result = *(volatile int *) ((addr << 7) + EISA_IO + 0x20);
-	result >>= (addr & 3) * 8;
-	return 0xffffUL & result;
-}
-
-__EXTERN_INLINE u32 jensen_inl(unsigned long addr)
-{
-	jensen_set_hae(0);
-	return *(vuip) ((addr << 7) + EISA_IO + 0x60);
-}
-
-__EXTERN_INLINE u64 jensen_inq(unsigned long addr)
-{
-	jensen_set_hae(0);
-	return *(vulp) ((addr << 7) + EISA_IO + 0x60);
-}
-
-__EXTERN_INLINE void jensen_outw(u16 b, unsigned long addr)
-{
-	jensen_set_hae(0);
-	*(vuip) ((addr << 7) + EISA_IO + 0x20) = b * 0x00010001;
-	mb();
-}
-
-__EXTERN_INLINE void jensen_outl(u32 b, unsigned long addr)
-{
-	jensen_set_hae(0);
-	*(vuip) ((addr << 7) + EISA_IO + 0x60) = b;
-	mb();
-}
-
-__EXTERN_INLINE void jensen_outq(u64 b, unsigned long addr)
-{
-	jensen_set_hae(0);
-	*(vulp) ((addr << 7) + EISA_IO + 0x60) = b;
-	mb();
-}
-
-/*
- * Memory functions.
- */
-
-__EXTERN_INLINE u8 jensen_readb(const volatile void __iomem *xaddr)
-{
-	unsigned long addr = (unsigned long) xaddr;
-	long result;
-
-	jensen_set_hae(addr);
-	addr &= JENSEN_HAE_MASK;
-	result = *(volatile int *) ((addr << 7) + EISA_MEM + 0x00);
-	result >>= (addr & 3) * 8;
-	return 0xffUL & result;
-}
-
-__EXTERN_INLINE u16 jensen_readw(const volatile void __iomem *xaddr)
-{
-	unsigned long addr = (unsigned long) xaddr;
-	long result;
-
-	jensen_set_hae(addr);
-	addr &= JENSEN_HAE_MASK;
-	result = *(volatile int *) ((addr << 7) + EISA_MEM + 0x20);
-	result >>= (addr & 3) * 8;
-	return 0xffffUL & result;
-}
-
-__EXTERN_INLINE u32 jensen_readl(const volatile void __iomem *xaddr)
-{
-	unsigned long addr = (unsigned long) xaddr;
-	jensen_set_hae(addr);
-	addr &= JENSEN_HAE_MASK;
-	return *(vuip) ((addr << 7) + EISA_MEM + 0x60);
-}
-
-__EXTERN_INLINE u64 jensen_readq(const volatile void __iomem *xaddr)
-{
-	unsigned long addr = (unsigned long) xaddr;
-	unsigned long r0, r1;
-
-	jensen_set_hae(addr);
-	addr &= JENSEN_HAE_MASK;
-	addr = (addr << 7) + EISA_MEM + 0x60;
-	r0 = *(vuip) (addr);
-	r1 = *(vuip) (addr + (4 << 7));
-	return r1 << 32 | r0;
-}
-
-__EXTERN_INLINE void jensen_writeb(u8 b, volatile void __iomem *xaddr)
-{
-	unsigned long addr = (unsigned long) xaddr;
-	jensen_set_hae(addr);
-	addr &= JENSEN_HAE_MASK;
-	*(vuip) ((addr << 7) + EISA_MEM + 0x00) = b * 0x01010101;
-}
-
-__EXTERN_INLINE void jensen_writew(u16 b, volatile void __iomem *xaddr)
-{
-	unsigned long addr = (unsigned long) xaddr;
-	jensen_set_hae(addr);
-	addr &= JENSEN_HAE_MASK;
-	*(vuip) ((addr << 7) + EISA_MEM + 0x20) = b * 0x00010001;
-}
-
-__EXTERN_INLINE void jensen_writel(u32 b, volatile void __iomem *xaddr)
-{
-	unsigned long addr = (unsigned long) xaddr;
-	jensen_set_hae(addr);
-	addr &= JENSEN_HAE_MASK;
-	*(vuip) ((addr << 7) + EISA_MEM + 0x60) = b;
-}
-
-__EXTERN_INLINE void jensen_writeq(u64 b, volatile void __iomem *xaddr)
-{
-	unsigned long addr = (unsigned long) xaddr;
-	jensen_set_hae(addr);
-	addr &= JENSEN_HAE_MASK;
-	addr = (addr << 7) + EISA_MEM + 0x60;
-	*(vuip) (addr) = b;
-	*(vuip) (addr + (4 << 7)) = b >> 32;
-}
-
-__EXTERN_INLINE void __iomem *jensen_ioportmap(unsigned long addr)
-{
-	return (void __iomem *)addr;
-}
-
-__EXTERN_INLINE void __iomem *jensen_ioremap(unsigned long addr,
-					     unsigned long size)
-{
-	return (void __iomem *)(addr + 0x100000000ul);
-}
-
-__EXTERN_INLINE int jensen_is_ioaddr(unsigned long addr)
-{
-	return (long)addr >= 0;
-}
-
-__EXTERN_INLINE int jensen_is_mmio(const volatile void __iomem *addr)
-{
-	return (unsigned long)addr >= 0x100000000ul;
-}
-
-/* New-style ioread interface.  All the routines are so ugly for Jensen
-   that it doesn't make sense to merge them.  */
-
-#define IOPORT(OS, NS)							\
-__EXTERN_INLINE u##NS jensen_ioread##NS(const void __iomem *xaddr)	\
-{									\
-	if (jensen_is_mmio(xaddr))					\
-		return jensen_read##OS(xaddr - 0x100000000ul);		\
-	else								\
-		return jensen_in##OS((unsigned long)xaddr);		\
-}									\
-__EXTERN_INLINE void jensen_iowrite##NS(u##NS b, void __iomem *xaddr)	\
-{									\
-	if (jensen_is_mmio(xaddr))					\
-		jensen_write##OS(b, xaddr - 0x100000000ul);		\
-	else								\
-		jensen_out##OS(b, (unsigned long)xaddr);		\
-}
-
-IOPORT(b, 8)
-IOPORT(w, 16)
-IOPORT(l, 32)
-IOPORT(q, 64)
-
-#undef IOPORT
-
-#undef vuip
-#undef vulp
-
-#undef __IO_PREFIX
-#define __IO_PREFIX		jensen
-#define jensen_trivial_rw_bw	0
-#define jensen_trivial_rw_lq	0
-#define jensen_trivial_io_bw	0
-#define jensen_trivial_io_lq	0
-#define jensen_trivial_iounmap	1
-#include <asm/io_trivial.h>
-
-#ifdef __IO_EXTERN_INLINE
-#undef __EXTERN_INLINE
-#undef __IO_EXTERN_INLINE
-#endif
-
-#endif /* __KERNEL__ */
-
-#endif /* __ALPHA_JENSEN_H */
diff --git a/arch/alpha/kernel/Makefile b/arch/alpha/kernel/Makefile
index fb4efec7cbc7..4b31060e1711 100644
--- a/arch/alpha/kernel/Makefile
+++ b/arch/alpha/kernel/Makefile
@@ -27,7 +27,7 @@ obj-y 	 += core_apecs.o core_cia.o core_irongate.o core_lca.o \
 	    core_tsunami.o
 
 obj-y	 += sys_alcor.o sys_cabriolet.o sys_dp264.o sys_eb64p.o sys_eiger.o \
-	    sys_jensen.o sys_miata.o sys_mikasa.o sys_nautilus.o \
+	    sys_miata.o sys_mikasa.o sys_nautilus.o \
 	    sys_noritake.o sys_rawhide.o sys_ruffian.o sys_rx164.o \
 	    sys_sable.o sys_sio.o sys_sx164.o sys_takara.o
 
@@ -78,7 +78,6 @@ obj-$(CONFIG_ALPHA_TITAN)	+= sys_titan.o irq_i8259.o smc37c669.o
 obj-$(CONFIG_ALPHA_EB64P)	+= sys_eb64p.o irq_i8259.o
 obj-$(CONFIG_ALPHA_EB66)	+= sys_eb64p.o irq_i8259.o
 obj-$(CONFIG_ALPHA_EIGER)	+= sys_eiger.o irq_i8259.o
-obj-$(CONFIG_ALPHA_JENSEN)	+= sys_jensen.o pci-noop.o irq_i8259.o
 obj-$(CONFIG_ALPHA_MARVEL)	+= sys_marvel.o 
 obj-$(CONFIG_ALPHA_MIATA)	+= sys_miata.o irq_pyxis.o irq_i8259.o \
 				   es1888.o smc37c669.o
diff --git a/arch/alpha/kernel/pci-noop.c b/arch/alpha/kernel/pci-noop.c
deleted file mode 100644
index 32ca59a5a704..000000000000
--- a/arch/alpha/kernel/pci-noop.c
+++ /dev/null
@@ -1,114 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *	linux/arch/alpha/kernel/pci-noop.c
- *
- * Stub PCI interfaces for Jensen-specific kernels.
- */
-
-#include <linux/pci.h>
-#include <linux/init.h>
-#include <linux/memblock.h>
-#include <linux/gfp.h>
-#include <linux/capability.h>
-#include <linux/mm.h>
-#include <linux/errno.h>
-#include <linux/sched.h>
-#include <linux/dma-mapping.h>
-#include <linux/scatterlist.h>
-#include <linux/syscalls.h>
-
-#include "pci_impl.h"
-#include "proto.h"
-
-
-/*
- * The PCI controller list.
- */
-
-struct pci_controller *hose_head, **hose_tail = &hose_head;
-struct pci_controller *pci_isa_hose;
-
-
-struct pci_controller * __init
-alloc_pci_controller(void)
-{
-	struct pci_controller *hose;
-
-	hose = memblock_alloc(sizeof(*hose), SMP_CACHE_BYTES);
-	if (!hose)
-		panic("%s: Failed to allocate %zu bytes\n", __func__,
-		      sizeof(*hose));
-
-	*hose_tail = hose;
-	hose_tail = &hose->next;
-
-	return hose;
-}
-
-struct resource * __init
-alloc_resource(void)
-{
-	void *ptr = memblock_alloc(sizeof(struct resource), SMP_CACHE_BYTES);
-
-	if (!ptr)
-		panic("%s: Failed to allocate %zu bytes\n", __func__,
-		      sizeof(struct resource));
-
-	return ptr;
-}
-
-SYSCALL_DEFINE3(pciconfig_iobase, long, which, unsigned long, bus,
-		unsigned long, dfn)
-{
-	struct pci_controller *hose;
-
-	/* from hose or from bus.devfn */
-	if (which & IOBASE_FROM_HOSE) {
-		for (hose = hose_head; hose; hose = hose->next)
-			if (hose->index == bus)
-				break;
-		if (!hose)
-			return -ENODEV;
-	} else {
-		/* Special hook for ISA access.  */
-		if (bus == 0 && dfn == 0)
-			hose = pci_isa_hose;
-		else
-			return -ENODEV;
-	}
-
-	switch (which & ~IOBASE_FROM_HOSE) {
-	case IOBASE_HOSE:
-		return hose->index;
-	case IOBASE_SPARSE_MEM:
-		return hose->sparse_mem_base;
-	case IOBASE_DENSE_MEM:
-		return hose->dense_mem_base;
-	case IOBASE_SPARSE_IO:
-		return hose->sparse_io_base;
-	case IOBASE_DENSE_IO:
-		return hose->dense_io_base;
-	case IOBASE_ROOT_BUS:
-		return hose->bus->number;
-	}
-
-	return -EOPNOTSUPP;
-}
-
-SYSCALL_DEFINE5(pciconfig_read, unsigned long, bus, unsigned long, dfn,
-		unsigned long, off, unsigned long, len, void __user *, buf)
-{
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-	else
-		return -ENODEV;
-}
-
-SYSCALL_DEFINE5(pciconfig_write, unsigned long, bus, unsigned long, dfn,
-		unsigned long, off, unsigned long, len, void __user *, buf)
-{
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-	else
-		return -ENODEV;
-}
diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index 0738f9396f95..6e6c842ef07c 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -181,7 +181,6 @@ WEAK(eb64p_mv);
 WEAK(eb66_mv);
 WEAK(eb66p_mv);
 WEAK(eiger_mv);
-WEAK(jensen_mv);
 WEAK(lx164_mv);
 WEAK(lynx_mv);
 WEAK(marvel_ev7_mv);
@@ -224,7 +223,7 @@ static void __init
 reserve_std_resources(void)
 {
 	static struct resource standard_io_resources[] = {
-		{ .name = "rtc", .start = -1, .end = -1 },
+		{ .name = "rtc", .start = 0x70, .end =  0x7f},
         	{ .name = "dma1", .start = 0x00, .end = 0x1f },
         	{ .name = "pic1", .start = 0x20, .end = 0x3f },
         	{ .name = "timer", .start = 0x40, .end = 0x5f },
@@ -246,10 +245,6 @@ reserve_std_resources(void)
 			}
 	}
 
-	/* Fix up for the Jensen's queer RTC placement.  */
-	standard_io_resources[0].start = RTC_PORT(0);
-	standard_io_resources[0].end = RTC_PORT(0) + 0x0f;
-
 	for (i = 0; i < ARRAY_SIZE(standard_io_resources); ++i)
 		request_resource(io, standard_io_resources+i);
 }
@@ -486,14 +481,7 @@ setup_arch(char **cmdline_p)
 	/* 
 	 * Locate the command line.
 	 */
-	/* Hack for Jensen... since we're restricted to 8 or 16 chars for
-	   boot flags depending on the boot mode, we need some shorthand.
-	   This should do for installation.  */
-	if (strcmp(COMMAND_LINE, "INSTALL") == 0) {
-		strscpy(command_line, "root=/dev/fd0 load_ramdisk=1", sizeof(command_line));
-	} else {
-		strscpy(command_line, COMMAND_LINE, sizeof(command_line));
-	}
+	strscpy(command_line, COMMAND_LINE, sizeof(command_line));
 	strcpy(boot_command_line, command_line);
 	*cmdline_p = command_line;
 
@@ -745,7 +733,7 @@ get_sysvec(unsigned long type, unsigned long variation, unsigned long cpu)
 		NULL,		/* Ruby */
 		NULL,		/* Flamingo */
 		NULL,		/* Mannequin */
-		&jensen_mv,
+		NULL,		/* Jensens */
 		NULL, 		/* Pelican */
 		NULL,		/* Morgan */
 		NULL,		/* Sable -- see below.  */
@@ -943,7 +931,6 @@ get_sysvec_byname(const char *name)
 		&eb66_mv,
 		&eb66p_mv,
 		&eiger_mv,
-		&jensen_mv,
 		&lx164_mv,
 		&lynx_mv,
 		&miata_mv,
diff --git a/arch/alpha/kernel/sys_jensen.c b/arch/alpha/kernel/sys_jensen.c
deleted file mode 100644
index a1bb1c4a7e93..000000000000
--- a/arch/alpha/kernel/sys_jensen.c
+++ /dev/null
@@ -1,237 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *	linux/arch/alpha/kernel/sys_jensen.c
- *
- *	Copyright (C) 1995 Linus Torvalds
- *	Copyright (C) 1998, 1999 Richard Henderson
- *
- * Code supporting the Jensen.
- */
-#define __EXTERN_INLINE inline
-#include <asm/io.h>
-#include <asm/jensen.h>
-#undef  __EXTERN_INLINE
-
-#include <linux/interrupt.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/mm.h>
-#include <linux/sched.h>
-#include <linux/pci.h>
-#include <linux/init.h>
-
-#include <asm/ptrace.h>
-
-#include <asm/dma.h>
-#include <asm/irq.h>
-#include <asm/mmu_context.h>
-#include <asm/tlbflush.h>
-
-#include "proto.h"
-#include "irq_impl.h"
-#include "pci_impl.h"
-#include "machvec_impl.h"
-
-
-/*
- * Jensen is special: the vector is 0x8X0 for EISA interrupt X, and
- * 0x9X0 for the local motherboard interrupts.
- *
- * Note especially that those local interrupts CANNOT be masked,
- * which causes much of the pain below...
- *
- *	0x660 - NMI
- *
- *	0x800 - IRQ0  interval timer (not used, as we use the RTC timer)
- *	0x810 - IRQ1  line printer (duh..)
- *	0x860 - IRQ6  floppy disk
- *
- *	0x900 - COM1
- *	0x920 - COM2
- *	0x980 - keyboard
- *	0x990 - mouse
- *
- * PCI-based systems are more sane: they don't have the local
- * interrupts at all, and have only normal PCI interrupts from
- * devices.  Happily it's easy enough to do a sane mapping from the
- * Jensen.
- * 
- * Note that this means that we may have to do a hardware
- * "local_op" to a different interrupt than we report to the rest of the
- * world.
- */
-
-static void
-jensen_local_enable(struct irq_data *d)
-{
-	/* the parport is really hw IRQ 1, silly Jensen.  */
-	if (d->irq == 7)
-		i8259a_enable_irq(d);
-}
-
-static void
-jensen_local_disable(struct irq_data *d)
-{
-	/* the parport is really hw IRQ 1, silly Jensen.  */
-	if (d->irq == 7)
-		i8259a_disable_irq(d);
-}
-
-static void
-jensen_local_mask_ack(struct irq_data *d)
-{
-	/* the parport is really hw IRQ 1, silly Jensen.  */
-	if (d->irq == 7)
-		i8259a_mask_and_ack_irq(d);
-}
-
-static struct irq_chip jensen_local_irq_type = {
-	.name		= "LOCAL",
-	.irq_unmask	= jensen_local_enable,
-	.irq_mask	= jensen_local_disable,
-	.irq_mask_ack	= jensen_local_mask_ack,
-};
-
-static void 
-jensen_device_interrupt(unsigned long vector)
-{
-	int irq;
-
-	switch (vector) {
-	case 0x660:
-		printk("Whee.. NMI received. Probable hardware error\n");
-		printk("61=%02x, 461=%02x\n", inb(0x61), inb(0x461));
-		return;
-
-	/* local device interrupts: */
-	case 0x900: irq = 4; break;		/* com1 -> irq 4 */
-	case 0x920: irq = 3; break;		/* com2 -> irq 3 */
-	case 0x980: irq = 1; break;		/* kbd -> irq 1 */
-	case 0x990: irq = 9; break;		/* mouse -> irq 9 */
-
-	default:
-		if (vector > 0x900) {
-			printk("Unknown local interrupt %lx\n", vector);
-			return;
-		}
-
-		irq = (vector - 0x800) >> 4;
-		if (irq == 1)
-			irq = 7;
-		break;
-	}
-
-	/* If there is no handler yet... */
-	if (!irq_has_action(irq)) {
-	    /* If it is a local interrupt that cannot be masked... */
-	    if (vector >= 0x900)
-	    {
-	        /* Clear keyboard/mouse state */
-	    	inb(0x64);
-		inb(0x60);
-		/* Reset serial ports */
-		inb(0x3fa);
-		inb(0x2fa);
-		outb(0x0c, 0x3fc);
-		outb(0x0c, 0x2fc);
-		/* Clear NMI */
-		outb(0,0x61);
-		outb(0,0x461);
-	    }
-	}
-
-#if 0
-        /* A useful bit of code to find out if an interrupt is going wild.  */
-        {
-          static unsigned int last_msg = 0, last_cc = 0;
-          static int last_irq = -1, count = 0;
-          unsigned int cc;
-
-          __asm __volatile("rpcc %0" : "=r"(cc));
-          ++count;
-#define JENSEN_CYCLES_PER_SEC	(150000000)
-          if (cc - last_msg > ((JENSEN_CYCLES_PER_SEC) * 3) ||
-	      irq != last_irq) {
-                printk(KERN_CRIT " irq %d count %d cc %u @ %lx\n",
-                       irq, count, cc-last_cc, get_irq_regs()->pc);
-                count = 0;
-                last_msg = cc;
-                last_irq = irq;
-          }
-          last_cc = cc;
-        }
-#endif
-
-	handle_irq(irq);
-}
-
-static void __init
-jensen_init_irq(void)
-{
-	init_i8259a_irqs();
-
-	irq_set_chip_and_handler(1, &jensen_local_irq_type, handle_level_irq);
-	irq_set_chip_and_handler(4, &jensen_local_irq_type, handle_level_irq);
-	irq_set_chip_and_handler(3, &jensen_local_irq_type, handle_level_irq);
-	irq_set_chip_and_handler(7, &jensen_local_irq_type, handle_level_irq);
-	irq_set_chip_and_handler(9, &jensen_local_irq_type, handle_level_irq);
-
-	common_init_isa_dma();
-}
-
-static void __init
-jensen_init_arch(void)
-{
-	struct pci_controller *hose;
-#ifdef CONFIG_PCI
-	static struct pci_dev fake_isa_bridge = { .dma_mask = 0xffffffffUL, };
-
-	isa_bridge = &fake_isa_bridge;
-#endif
-
-	/* Create a hose so that we can report i/o base addresses to
-	   userland.  */
-
-	pci_isa_hose = hose = alloc_pci_controller();
-	hose->io_space = &ioport_resource;
-	hose->mem_space = &iomem_resource;
-	hose->index = 0;
-
-	hose->sparse_mem_base = EISA_MEM - IDENT_ADDR;
-	hose->dense_mem_base = 0;
-	hose->sparse_io_base = EISA_IO - IDENT_ADDR;
-	hose->dense_io_base = 0;
-
-	hose->sg_isa = hose->sg_pci = NULL;
-	__direct_map_base = 0;
-	__direct_map_size = 0xffffffff;
-}
-
-static void
-jensen_machine_check(unsigned long vector, unsigned long la)
-{
-	printk(KERN_CRIT "Machine check\n");
-}
-
-/*
- * The System Vector
- */
-
-struct alpha_machine_vector jensen_mv __initmv = {
-	.vector_name		= "Jensen",
-	DO_EV4_MMU,
-	IO_LITE(JENSEN,jensen),
-	.machine_check		= jensen_machine_check,
-	.max_isa_dma_address	= ALPHA_MAX_ISA_DMA_ADDRESS,
-	.rtc_port		= 0x170,
-
-	.nr_irqs		= 16,
-	.device_interrupt	= jensen_device_interrupt,
-
-	.init_arch		= jensen_init_arch,
-	.init_irq		= jensen_init_irq,
-	.init_rtc		= common_init_rtc,
-	.init_pci		= NULL,
-	.kill_arch		= NULL,
-};
-ALIAS_MV(jensen)
diff --git a/arch/alpha/kernel/traps.c b/arch/alpha/kernel/traps.c
index 7fc72aeb7398..a9a8e9ab0f52 100644
--- a/arch/alpha/kernel/traps.c
+++ b/arch/alpha/kernel/traps.c
@@ -30,39 +30,6 @@
 
 #include "proto.h"
 
-/* Work-around for some SRMs which mishandle opDEC faults.  */
-
-static int opDEC_fix;
-
-static void
-opDEC_check(void)
-{
-	__asm__ __volatile__ (
-	/* Load the address of... */
-	"	br	$16, 1f\n"
-	/* A stub instruction fault handler.  Just add 4 to the
-	   pc and continue.  */
-	"	ldq	$16, 8($sp)\n"
-	"	addq	$16, 4, $16\n"
-	"	stq	$16, 8($sp)\n"
-	"	call_pal %[rti]\n"
-	/* Install the instruction fault handler.  */
-	"1:	lda	$17, 3\n"
-	"	call_pal %[wrent]\n"
-	/* With that in place, the fault from the round-to-minf fp
-	   insn will arrive either at the "lda 4" insn (bad) or one
-	   past that (good).  This places the correct fixup in %0.  */
-	"	lda %[fix], 0\n"
-	"	cvttq/svm $f31,$f31\n"
-	"	lda %[fix], 4"
-	: [fix] "=r" (opDEC_fix)
-	: [rti] "n" (PAL_rti), [wrent] "n" (PAL_wrent)
-	: "$0", "$1", "$16", "$17", "$22", "$23", "$24", "$25");
-
-	if (opDEC_fix)
-		printk("opDEC fixup enabled.\n");
-}
-
 void
 dik_show_regs(struct pt_regs *regs, unsigned long *r9_15)
 {
diff --git a/drivers/eisa/Kconfig b/drivers/eisa/Kconfig
index c8bbf90209f5..a66b3be502a9 100644
--- a/drivers/eisa/Kconfig
+++ b/drivers/eisa/Kconfig
@@ -44,17 +44,16 @@ config EISA_PCI_EISA
 
 	  When in doubt, say Y.
 
-# Using EISA_VIRTUAL_ROOT on something other than an Alpha or
-# an X86 may lead to crashes...
+# Using EISA_VIRTUAL_ROOT on something other than an X86 may lead
+# to crashes...
 
 config EISA_VIRTUAL_ROOT
 	bool "EISA virtual root device"
-	depends on EISA && (ALPHA || X86)
+	depends on EISA && X86
 	default y
 	help
 	  Activate this option if your system only have EISA bus
-	  (no PCI slots). The Alpha Jensen is an example of such
-	  a system.
+	  (no PCI slots).
 
 	  When in doubt, say Y.
 
diff --git a/drivers/eisa/virtual_root.c b/drivers/eisa/virtual_root.c
index 37e6dd219c37..cd9515d9d8f0 100644
--- a/drivers/eisa/virtual_root.c
+++ b/drivers/eisa/virtual_root.c
@@ -13,7 +13,7 @@
 #include <linux/moduleparam.h>
 #include <linux/init.h>
 
-#if defined(CONFIG_ALPHA_JENSEN) || defined(CONFIG_EISA_VLB_PRIMING)
+#if defined(CONFIG_EISA_VLB_PRIMING)
 #define EISA_FORCE_PROBE_DEFAULT 1
 #else
 #define EISA_FORCE_PROBE_DEFAULT 0
diff --git a/drivers/input/serio/i8042-io.h b/drivers/input/serio/i8042-io.h
index 64590b86eb37..a8f4b2d70e59 100644
--- a/drivers/input/serio/i8042-io.h
+++ b/drivers/input/serio/i8042-io.h
@@ -15,10 +15,7 @@
  * IRQs.
  */
 
-#ifdef __alpha__
-# define I8042_KBD_IRQ	1
-# define I8042_AUX_IRQ	(RTC_PORT(0) == 0x170 ? 9 : 12)	/* Jensen is special */
-#elif defined(__arm__)
+#if defined(__arm__)
 /* defined in include/asm-arm/arch-xxx/irqs.h */
 #include <asm/irq.h>
 #elif defined(CONFIG_PPC)
diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 1aa3e55c8b47..6a7b286f6f5a 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -293,9 +293,6 @@ static inline int serial8250_in_MCR(struct uart_8250_port *up)
 	return mctrl;
 }
 
-bool alpha_jensen(void);
-void alpha_jensen_set_mctrl(struct uart_port *port, unsigned int mctrl);
-
 #ifdef CONFIG_SERIAL_8250_PNP
 int serial8250_pnp_init(void);
 void serial8250_pnp_exit(void);
diff --git a/drivers/tty/serial/8250/8250_alpha.c b/drivers/tty/serial/8250/8250_alpha.c
deleted file mode 100644
index 58e70328aa4d..000000000000
--- a/drivers/tty/serial/8250/8250_alpha.c
+++ /dev/null
@@ -1,21 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-
-#include <asm/machvec.h>
-#include "8250.h"
-
-bool alpha_jensen(void)
-{
-	return !strcmp(alpha_mv.vector_name, "Jensen");
-}
-
-void alpha_jensen_set_mctrl(struct uart_port *port, unsigned int mctrl)
-{
-	/*
-	 * Digital did something really horribly wrong with the OUT1 and OUT2
-	 * lines on Alpha Jensen.  The failure mode is that if either is
-	 * cleared, the machine locks up with endless interrupts.
-	 */
-	mctrl |= TIOCM_OUT1 | TIOCM_OUT2;
-
-	serial8250_do_set_mctrl(port, mctrl);
-}
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index b62ad9006780..2504e0455875 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -508,10 +508,6 @@ static struct uart_8250_port *serial8250_setup_port(int index)
 
 	up->ops = &univ8250_driver_ops;
 
-	if (IS_ENABLED(CONFIG_ALPHA_JENSEN) ||
-	    (IS_ENABLED(CONFIG_ALPHA_GENERIC) && alpha_jensen()))
-		up->port.set_mctrl = alpha_jensen_set_mctrl;
-
 	serial8250_set_defaults(up);
 
 	return up;
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index ea2e81f58eac..69ac00270547 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -5,8 +5,6 @@
 
 obj-$(CONFIG_SERIAL_8250)		+= 8250.o 8250_base.o
 8250-y					:= 8250_core.o
-8250-$(CONFIG_ALPHA_GENERIC)		+= 8250_alpha.o
-8250-$(CONFIG_ALPHA_JENSEN)		+= 8250_alpha.o
 8250-$(CONFIG_SERIAL_8250_PNP)		+= 8250_pnp.o
 8250_base-y				:= 8250_port.o
 8250_base-$(CONFIG_SERIAL_8250_DMA)	+= 8250_dma.o
-- 
2.39.2


