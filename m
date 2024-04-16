Return-Path: <linux-kernel+bounces-147131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BA28A6FE1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA442822A8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D58130E30;
	Tue, 16 Apr 2024 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rz1Szidj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3811CFBC;
	Tue, 16 Apr 2024 15:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713281620; cv=none; b=DRUK/eqv7ejfAIlqPVHNecQAn4BSW5XsFc8BGhgo5r4Cy2crQnuMV1P7v+XFpywc6XyZotGYmjfZ1cmaAqw+6gmtzBWPmecVYlSe8npDwK9ATWptwpgmeBcBUGjYyQI6MiD5vmCoE3VE8o8+8TlIX/ND6SAWa3WKzWthh4qcMaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713281620; c=relaxed/simple;
	bh=KMJrLPwQ9g082JII6rT2LfmDOh7BKYUjdsOItQoJrbA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PNrziygVlTfcBr3SXudU+4v2SFv3sNPFxrjPNHzLQWPDNKKg985W77JhK99h5BdRZwjq0u3JgnFzfMPOnML3IYEsgOqJ0uzqw3dRAsOcBWPhlYW/wjPFwzYuaj81W47xX+ysGrL5uK121cgYpYds0vFwkwJKjm1UvIUPZUrksNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rz1Szidj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E27C113CE;
	Tue, 16 Apr 2024 15:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713281619;
	bh=KMJrLPwQ9g082JII6rT2LfmDOh7BKYUjdsOItQoJrbA=;
	h=From:To:Cc:Subject:Date:From;
	b=rz1SzidjBfUZzeyqxX7pwf2W9793w97eV5Ag4zUuf/4q0uW+dUi0b4LJUuwWkaTkJ
	 1zH2VKTR3L4P2cPrlQ0SNENy4AdjcrlmMcSoXl+x5KMpgWiyj92Y0YyNzT8CDXHJ2m
	 pdPUv6ra+ko40LbtrVW8jNgJvXzZc5ChEsnRYIe8Y+QnDWCXGOrn1bo+bBze6RoHFg
	 htoLEPNxFd9M1fY4OGjFfJWwMwn2w4lURkW85s5MuyGnBbh+HdNav3yFFxmVp7XgEd
	 dLxMkKhOn7lycivhlOPRTqm6zxj8+7WMCB29r9uHPOVFMUV/uO2bo2HA9JOsH/tQNF
	 L1RYfVNjfw7lA==
From: Arnd Bergmann <arnd@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	clang-built-linux <llvm@lists.linux.dev>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Baoquan He <bhe@redhat.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>
Subject: [PATCH] powerpc: drop port I/O helpers for CONFIG_HAS_IOPORT=n
Date: Tue, 16 Apr 2024 17:33:01 +0200
Message-Id: <20240416153331.1617772-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Calling inb()/outb() on powerpc when CONFIG_PCI is disabled causes
a NULL pointer dereference, which is bad for a number of reasons.

After my patch to turn on -Werror in linux-next, this caused a
compiler-time warning with clang:

In file included from arch/powerpc/include/asm/io.h:672:
arch/powerpc/include/asm/io-defs.h:43:1: error: performing pointer
arithmetic on a null pointer has undefined behavior
[-Werror,-Wnull-pointer-arithmetic]
   43 | DEF_PCI_AC_NORET(insb, (unsigned long p, void *b, unsigned long c),
      | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                  (p, b, c), pio, p)
      |                  ~~~~~~~~~~~~~~~~~~

In this configuration, CONFIG_HAS_IOPORT is already disabled, and all
drivers that use inb()/outb() should now depend on that (some patches are
still in the process of getting marged).

Hide all references to inb()/outb() in the powerpc code and the definitions
when HAS_IOPORT is disabled to remove the possible NULL pointer access.
The same should happin in asm-generic in the near future, but for now
the empty inb() macros are still defined to ensure the generic version
does not get pulled in.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
--

Cc: linux-kernel@vger.kernel.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
Cc: Anders Roxell <anders.roxell@linaro.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: clang-built-linux <llvm@lists.linux.dev>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Jeff Xu <jeffxu@chromium.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
---
 arch/powerpc/include/asm/dma.h     | 12 ++++++++----
 arch/powerpc/include/asm/io-defs.h |  4 ++++
 arch/powerpc/include/asm/io.h      | 19 +++++++++++++++----
 arch/powerpc/kernel/iomap.c        |  4 ++++
 arch/powerpc/kernel/traps.c        |  2 +-
 5 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/dma.h b/arch/powerpc/include/asm/dma.h
index d97c66d9ae34..004a868f82c9 100644
--- a/arch/powerpc/include/asm/dma.h
+++ b/arch/powerpc/include/asm/dma.h
@@ -3,6 +3,12 @@
 #define _ASM_POWERPC_DMA_H
 #ifdef __KERNEL__
 
+/* The maximum address that we can perform a DMA transfer to on this platform */
+/* Doesn't really apply... */
+#define MAX_DMA_ADDRESS		(~0UL)
+
+#ifdef CONFIG_HAS_IOPORT
+
 /*
  * Defines for using and allocating dma channels.
  * Written by Hennus Bergman, 1992.
@@ -26,10 +32,6 @@
 #define MAX_DMA_CHANNELS	8
 #endif
 
-/* The maximum address that we can perform a DMA transfer to on this platform */
-/* Doesn't really apply... */
-#define MAX_DMA_ADDRESS		(~0UL)
-
 #ifdef HAVE_REALLY_SLOW_DMA_CONTROLLER
 #define dma_outb	outb_p
 #else
@@ -340,5 +342,7 @@ extern int request_dma(unsigned int dmanr, const char *device_id);
 /* release it again */
 extern void free_dma(unsigned int dmanr);
 
+#endif
+
 #endif /* __KERNEL__ */
 #endif	/* _ASM_POWERPC_DMA_H */
diff --git a/arch/powerpc/include/asm/io-defs.h b/arch/powerpc/include/asm/io-defs.h
index faf8617cc574..8d2209af7759 100644
--- a/arch/powerpc/include/asm/io-defs.h
+++ b/arch/powerpc/include/asm/io-defs.h
@@ -20,12 +20,14 @@ DEF_PCI_AC_NORET(writeq, (u64 val, PCI_IO_ADDR addr), (val, addr), mem, addr)
 DEF_PCI_AC_NORET(writeq_be, (u64 val, PCI_IO_ADDR addr), (val, addr), mem, addr)
 #endif /* __powerpc64__ */
 
+#ifdef CONFIG_HAS_IOPORT
 DEF_PCI_AC_RET(inb, u8, (unsigned long port), (port), pio, port)
 DEF_PCI_AC_RET(inw, u16, (unsigned long port), (port), pio, port)
 DEF_PCI_AC_RET(inl, u32, (unsigned long port), (port), pio, port)
 DEF_PCI_AC_NORET(outb, (u8 val, unsigned long port), (val, port), pio, port)
 DEF_PCI_AC_NORET(outw, (u16 val, unsigned long port), (val, port), pio, port)
 DEF_PCI_AC_NORET(outl, (u32 val, unsigned long port), (val, port), pio, port)
+#endif
 
 DEF_PCI_AC_NORET(readsb, (const PCI_IO_ADDR a, void *b, unsigned long c),
 		 (a, b, c), mem, a)
@@ -40,6 +42,7 @@ DEF_PCI_AC_NORET(writesw, (PCI_IO_ADDR a, const void *b, unsigned long c),
 DEF_PCI_AC_NORET(writesl, (PCI_IO_ADDR a, const void *b, unsigned long c),
 		 (a, b, c), mem, a)
 
+#ifdef CONFIG_HAS_IOPORT
 DEF_PCI_AC_NORET(insb, (unsigned long p, void *b, unsigned long c),
 		 (p, b, c), pio, p)
 DEF_PCI_AC_NORET(insw, (unsigned long p, void *b, unsigned long c),
@@ -52,6 +55,7 @@ DEF_PCI_AC_NORET(outsw, (unsigned long p, const void *b, unsigned long c),
 		 (p, b, c), pio, p)
 DEF_PCI_AC_NORET(outsl, (unsigned long p, const void *b, unsigned long c),
 		 (p, b, c), pio, p)
+#endif
 
 DEF_PCI_AC_NORET(memset_io, (PCI_IO_ADDR a, int c, unsigned long n),
 		 (a, c, n), mem, a)
diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 08c550ed49be..86c212fcbc0c 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -37,7 +37,6 @@ extern struct pci_dev *isa_bridge_pcidev;
  * define properly based on the platform
  */
 #ifndef CONFIG_PCI
-#define _IO_BASE	0
 #define _ISA_MEM_BASE	0
 #define PCI_DRAM_OFFSET 0
 #elif defined(CONFIG_PPC32)
@@ -486,8 +485,7 @@ static inline u64 __raw_rm_readq(volatile void __iomem *paddr)
  * to port it over
  */
 
-#ifdef CONFIG_PPC32
-
+#if defined(CONFIG_PPC32) && defined(CONFIG_HAS_IOPORT)
 #define __do_in_asm(name, op)				\
 static inline unsigned int name(unsigned int port)	\
 {							\
@@ -534,7 +532,7 @@ __do_out_asm(_rec_outb, "stbx")
 __do_out_asm(_rec_outw, "sthbrx")
 __do_out_asm(_rec_outl, "stwbrx")
 
-#endif /* CONFIG_PPC32 */
+#endif /* CONFIG_PPC32 && CONFIG_HAS_IOPORT */
 
 /* The "__do_*" operations below provide the actual "base" implementation
  * for each of the defined accessors. Some of them use the out_* functions
@@ -577,6 +575,7 @@ __do_out_asm(_rec_outl, "stwbrx")
 #define __do_readq_be(addr)	in_be64(PCI_FIX_ADDR(addr))
 #endif /* !defined(CONFIG_EEH) */
 
+#ifdef CONFIG_HAS_IOPORT
 #ifdef CONFIG_PPC32
 #define __do_outb(val, port)	_rec_outb(val, port)
 #define __do_outw(val, port)	_rec_outw(val, port)
@@ -592,6 +591,7 @@ __do_out_asm(_rec_outl, "stwbrx")
 #define __do_inw(port)		readw((PCI_IO_ADDR)_IO_BASE + port);
 #define __do_inl(port)		readl((PCI_IO_ADDR)_IO_BASE + port);
 #endif /* !CONFIG_PPC32 */
+#endif
 
 #ifdef CONFIG_EEH
 #define __do_readsb(a, b, n)	eeh_readsb(PCI_FIX_ADDR(a), (b), (n))
@@ -606,12 +606,14 @@ __do_out_asm(_rec_outl, "stwbrx")
 #define __do_writesw(a, b, n)	_outsw(PCI_FIX_ADDR(a),(b),(n))
 #define __do_writesl(a, b, n)	_outsl(PCI_FIX_ADDR(a),(b),(n))
 
+#ifdef CONFIG_HAS_IOPORT
 #define __do_insb(p, b, n)	readsb((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
 #define __do_insw(p, b, n)	readsw((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
 #define __do_insl(p, b, n)	readsl((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
 #define __do_outsb(p, b, n)	writesb((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
 #define __do_outsw(p, b, n)	writesw((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
 #define __do_outsl(p, b, n)	writesl((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
+#endif
 
 #define __do_memset_io(addr, c, n)	\
 				_memset_io(PCI_FIX_ADDR(addr), c, n)
@@ -689,6 +691,7 @@ static inline void name at					\
 #define writesb writesb
 #define writesw writesw
 #define writesl writesl
+
 #define inb inb
 #define inw inw
 #define inl inl
@@ -848,8 +851,16 @@ static inline void iosync(void)
 #define inl_p(port)             inl(port)
 #define outl_p(val, port)       (udelay(1), outl((val), (port)))
 
+#define insb_p			insb
+#define insw_p			insw
+#define insl_p			insl
+#define outsb_p			outsb
+#define outsw_p			outsw
+#define outsl_p			outsl
 
+#ifdef CONFIG_HAS_IOPORT
 #define IO_SPACE_LIMIT ~(0UL)
+#endif
 
 /**
  * ioremap     -   map bus memory into CPU space
diff --git a/arch/powerpc/kernel/iomap.c b/arch/powerpc/kernel/iomap.c
index 72862a4d3a5d..33e36fda1ea8 100644
--- a/arch/powerpc/kernel/iomap.c
+++ b/arch/powerpc/kernel/iomap.c
@@ -13,7 +13,11 @@
 
 void __iomem *ioport_map(unsigned long port, unsigned int len)
 {
+#ifdef CONFIG_HAS_IOPORT
 	return (void __iomem *) (port + _IO_BASE);
+#else
+	return NULL;
+#endif
 }
 EXPORT_SYMBOL(ioport_map);
 
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index f23430adb68a..b1c34242d394 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -531,7 +531,7 @@ DEFINE_INTERRUPT_HANDLER_NMI(system_reset_exception)
  */
 static inline int check_io_access(struct pt_regs *regs)
 {
-#ifdef CONFIG_PPC32
+#if defined(CONFIG_PPC32) && defined(CONFIG_HAS_IOPORT)
 	unsigned long msr = regs->msr;
 	const struct exception_table_entry *entry;
 	unsigned int *nip = (unsigned int *)regs->nip;
-- 
2.39.2


