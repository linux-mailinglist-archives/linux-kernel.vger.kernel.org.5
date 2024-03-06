Return-Path: <linux-kernel+bounces-94029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 548768738B7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FB131C2074F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50547132C3D;
	Wed,  6 Mar 2024 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFtou2xJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE66D5DF27;
	Wed,  6 Mar 2024 14:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709734527; cv=none; b=cRdJWkNZ123sey69eGXKA5s2ou4WZ5f4YsXIREZ9wQgmqLDk7ZruJ85j5gPoTNGoUJMKjjDwImgz23q0k3mL1Fe7fF/NMJ1Jy4YmxziNl8KCgG4RxLdGTU7jWeS9Ww7AbZVB1iXf/L9tMxmp18Wv5u20SyUtjbm1fT+VOcksOaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709734527; c=relaxed/simple;
	bh=hOwSno67PHn2zRcJm28RRWlgi+crrCtRszztGSsvIq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hJBOWLE9UrtE8YkUQHy2VIlL7HkDhYHQYXblkZgyF9JkAuFOcDRlwIU+Xcc47nRsyyzgWsuD/T+irwt4pEzyiD38DwaIs1QmdZ2RtQAC7I08rZPNtgHP5rjWEaj9G1tjbJ2L0f+DMEG+Srn/dJMYaN+rl9utiYallkDRXDEEpZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFtou2xJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C16C43330;
	Wed,  6 Mar 2024 14:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709734526;
	bh=hOwSno67PHn2zRcJm28RRWlgi+crrCtRszztGSsvIq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gFtou2xJ1+EpNTyiFW8tH80hN8WSoSLJrwrmprE0TG8wu/fNUw726W55nZenOsorD
	 O2z3L6dVpe1AM4kXia2Bj68BawpyAo/kiZB12TFVtz0Pu4j8ln5EdtH54gzRCPRbAS
	 s/u5Dr7ET4GIM4J+SyaNRGcirZTl02W3evP3N+/XlNjCSlpCzfy9YAFp6b+gJqzHcN
	 qfqSdR46EuOdF+T9R/whaeXOInv1H21ORm9dshlUppp1h/E+Ufln/i8RspShmT1D7e
	 tYiL1wXp9oa/HC++eTcHii1rMfDSqsyt72KfIchyVYurnLaVPHjhaQ2+bz3HyDW8Uh
	 KwK39ZSiOtzdQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Kees Cook <keescook@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Matt Turner <mattst88@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Guo Ren <guoren@kernel.org>,
	Brian Cain <bcain@quicinc.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Helge Deller <deller@gmx.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>,
	x86@kernel.org,
	Max Filippov <jcmvbkbc@gmail.com>,
	Andy Lutomirski <luto@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: [PATCH v2 1/3] arch: consolidate existing CONFIG_PAGE_SIZE_*KB definitions
Date: Wed,  6 Mar 2024 15:14:51 +0100
Message-Id: <20240306141453.3900574-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240306141453.3900574-1-arnd@kernel.org>
References: <20240306141453.3900574-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

These four architectures define the same Kconfig symbols for configuring
the page size. Move the logic into a common place where it can be shared
with all other architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Changes from v1:
 - improve Kconfig help texts
 - fix Hexagon Kconfig

 arch/Kconfig                      | 92 ++++++++++++++++++++++++++++++-
 arch/hexagon/Kconfig              | 24 ++------
 arch/hexagon/include/asm/page.h   |  6 +-
 arch/loongarch/Kconfig            | 21 ++-----
 arch/loongarch/include/asm/page.h | 10 +---
 arch/mips/Kconfig                 | 58 ++-----------------
 arch/mips/include/asm/page.h      | 16 +-----
 arch/sh/include/asm/page.h        | 13 +----
 arch/sh/mm/Kconfig                | 42 ++++----------
 9 files changed, 121 insertions(+), 161 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index a5af0edd3eb8..c63034e092d0 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1078,17 +1078,105 @@ config HAVE_ARCH_COMPAT_MMAP_BASES
 	  and vice-versa 32-bit applications to call 64-bit mmap().
 	  Required for applications doing different bitness syscalls.
 
+config HAVE_PAGE_SIZE_4KB
+	bool
+
+config HAVE_PAGE_SIZE_8KB
+	bool
+
+config HAVE_PAGE_SIZE_16KB
+	bool
+
+config HAVE_PAGE_SIZE_32KB
+	bool
+
+config HAVE_PAGE_SIZE_64KB
+	bool
+
+config HAVE_PAGE_SIZE_256KB
+	bool
+
+choice
+	prompt "MMU page size"
+
+config PAGE_SIZE_4KB
+	bool "4KiB pages"
+	depends on HAVE_PAGE_SIZE_4KB
+	help
+	  This option select the standard 4KiB Linux page size and the only
+	  available option on many architectures. Using 4KiB page size will
+	  minimize memory consumption and is therefore recommended for low
+	  memory systems.
+	  Some software that is written for x86 systems makes incorrect
+	  assumptions about the page size and only runs on 4KiB pages.
+
+config PAGE_SIZE_8KB
+	bool "8KiB pages"
+	depends on HAVE_PAGE_SIZE_8KB
+	help
+	  This option is the only supported page size on a few older
+	  processors, and can be slightly faster than 4KiB pages.
+
+config PAGE_SIZE_16KB
+	bool "16KiB pages"
+	depends on HAVE_PAGE_SIZE_16KB
+	help
+	  This option is usually a good compromise between memory
+	  consumption and performance for typical desktop and server
+	  workloads, often saving a level of page table lookups compared
+	  to 4KB pages as well as reducing TLB pressure and overhead of
+	  per-page operations in the kernel at the expense of a larger
+	  page cache.
+
+config PAGE_SIZE_32KB
+	bool "32KiB pages"
+	depends on HAVE_PAGE_SIZE_32KB
+	  Using 32KiB page size will result in slightly higher performance
+	  kernel at the price of higher memory consumption compared to
+	  16KiB pages.	This option is available only on cnMIPS cores.
+	  Note that you will need a suitable Linux distribution to
+	  support this.
+
+config PAGE_SIZE_64KB
+	bool "64KiB pages"
+	depends on HAVE_PAGE_SIZE_64KB
+	  Using 64KiB page size will result in slightly higher performance
+	  kernel at the price of much higher memory consumption compared to
+	  4KiB or 16KiB pages.
+	  This is not suitable for general-purpose workloads but the
+	  better performance may be worth the cost for certain types of
+	  supercomputing or database applications that work mostly with
+	  large in-memory data rather than small files.
+
+config PAGE_SIZE_256KB
+	bool "256KiB pages"
+	depends on HAVE_PAGE_SIZE_256KB
+	help
+	  256KiB pages have little practical value due to their extreme
+	  memory usage.  The kernel will only be able to run applications
+	  that have been compiled with '-zmax-page-size' set to 256KiB
+	  (the default is 64KiB or 4KiB on most architectures).
+
+endchoice
+
 config PAGE_SIZE_LESS_THAN_64KB
 	def_bool y
-	depends on !ARM64_64K_PAGES
 	depends on !PAGE_SIZE_64KB
-	depends on !PARISC_PAGE_SIZE_64KB
 	depends on PAGE_SIZE_LESS_THAN_256KB
 
 config PAGE_SIZE_LESS_THAN_256KB
 	def_bool y
 	depends on !PAGE_SIZE_256KB
 
+config PAGE_SHIFT
+	int
+	default 12 if PAGE_SIZE_4KB
+	default 13 if PAGE_SIZE_8KB
+	default 14 if PAGE_SIZE_16KB
+	default 15 if PAGE_SIZE_32KB
+	default 16 if PAGE_SIZE_64KB
+	default 18 if PAGE_SIZE_256KB
+
 # This allows to use a set of generic functions to determine mmap base
 # address by giving priority to top-down scheme only if the process
 # is not in legacy mode (compat task, unlimited stack size or
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index a880ee067d2e..1414052e7d6b 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -8,6 +8,10 @@ config HEXAGON
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_NO_PREEMPT
 	select DMA_GLOBAL_POOL
+	select HAVE_PAGE_SIZE_4KB
+	select HAVE_PAGE_SIZE_16KB
+	select HAVE_PAGE_SIZE_64KB
+	select HAVE_PAGE_SIZE_256KB
 	# Other pending projects/to-do items.
 	# select HAVE_REGS_AND_STACK_ACCESS_API
 	# select HAVE_HW_BREAKPOINT if PERF_EVENTS
@@ -120,26 +124,6 @@ config NR_CPUS
 	  This is purely to save memory - each supported CPU adds
 	  approximately eight kilobytes to the kernel image.
 
-choice
-	prompt "Kernel page size"
-	default PAGE_SIZE_4KB
-	help
-	  Changes the default page size; use with caution.
-
-config PAGE_SIZE_4KB
-	bool "4KB"
-
-config PAGE_SIZE_16KB
-	bool "16KB"
-
-config PAGE_SIZE_64KB
-	bool "64KB"
-
-config PAGE_SIZE_256KB
-	bool "256KB"
-
-endchoice
-
 source "kernel/Kconfig.hz"
 
 endmenu
diff --git a/arch/hexagon/include/asm/page.h b/arch/hexagon/include/asm/page.h
index 32394b7e752e..8a6af57274c2 100644
--- a/arch/hexagon/include/asm/page.h
+++ b/arch/hexagon/include/asm/page.h
@@ -13,27 +13,22 @@
 /*  This is probably not the most graceful way to handle this.  */
 
 #ifdef CONFIG_PAGE_SIZE_4KB
-#define PAGE_SHIFT 12
 #define HEXAGON_L1_PTE_SIZE __HVM_PDE_S_4KB
 #endif
 
 #ifdef CONFIG_PAGE_SIZE_16KB
-#define PAGE_SHIFT 14
 #define HEXAGON_L1_PTE_SIZE __HVM_PDE_S_16KB
 #endif
 
 #ifdef CONFIG_PAGE_SIZE_64KB
-#define PAGE_SHIFT 16
 #define HEXAGON_L1_PTE_SIZE __HVM_PDE_S_64KB
 #endif
 
 #ifdef CONFIG_PAGE_SIZE_256KB
-#define PAGE_SHIFT 18
 #define HEXAGON_L1_PTE_SIZE __HVM_PDE_S_256KB
 #endif
 
 #ifdef CONFIG_PAGE_SIZE_1MB
-#define PAGE_SHIFT 20
 #define HEXAGON_L1_PTE_SIZE __HVM_PDE_S_1MB
 #endif
 
@@ -50,6 +45,7 @@
 #define HVM_HUGEPAGE_SIZE 0x5
 #endif
 
+#define PAGE_SHIFT CONFIG_PAGE_SHIFT
 #define PAGE_SIZE  (1UL << PAGE_SHIFT)
 #define PAGE_MASK  (~((1 << PAGE_SHIFT) - 1))
 
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 929f68926b34..b274784c2e26 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -227,15 +227,6 @@ config MACH_LOONGSON64
 config FIX_EARLYCON_MEM
 	def_bool y
 
-config PAGE_SIZE_4KB
-	bool
-
-config PAGE_SIZE_16KB
-	bool
-
-config PAGE_SIZE_64KB
-	bool
-
 config PGTABLE_2LEVEL
 	bool
 
@@ -288,7 +279,7 @@ choice
 
 config 4KB_3LEVEL
 	bool "4KB with 3 levels"
-	select PAGE_SIZE_4KB
+	select HAVE_PAGE_SIZE_4KB
 	select PGTABLE_3LEVEL
 	help
 	  This option selects 4KB page size with 3 level page tables, which
@@ -296,7 +287,7 @@ config 4KB_3LEVEL
 
 config 4KB_4LEVEL
 	bool "4KB with 4 levels"
-	select PAGE_SIZE_4KB
+	select HAVE_PAGE_SIZE_4KB
 	select PGTABLE_4LEVEL
 	help
 	  This option selects 4KB page size with 4 level page tables, which
@@ -304,7 +295,7 @@ config 4KB_4LEVEL
 
 config 16KB_2LEVEL
 	bool "16KB with 2 levels"
-	select PAGE_SIZE_16KB
+	select HAVE_PAGE_SIZE_16KB
 	select PGTABLE_2LEVEL
 	help
 	  This option selects 16KB page size with 2 level page tables, which
@@ -312,7 +303,7 @@ config 16KB_2LEVEL
 
 config 16KB_3LEVEL
 	bool "16KB with 3 levels"
-	select PAGE_SIZE_16KB
+	select HAVE_PAGE_SIZE_16KB
 	select PGTABLE_3LEVEL
 	help
 	  This option selects 16KB page size with 3 level page tables, which
@@ -320,7 +311,7 @@ config 16KB_3LEVEL
 
 config 64KB_2LEVEL
 	bool "64KB with 2 levels"
-	select PAGE_SIZE_64KB
+	select HAVE_PAGE_SIZE_64KB
 	select PGTABLE_2LEVEL
 	help
 	  This option selects 64KB page size with 2 level page tables, which
@@ -328,7 +319,7 @@ config 64KB_2LEVEL
 
 config 64KB_3LEVEL
 	bool "64KB with 3 levels"
-	select PAGE_SIZE_64KB
+	select HAVE_PAGE_SIZE_64KB
 	select PGTABLE_3LEVEL
 	help
 	  This option selects 64KB page size with 3 level page tables, which
diff --git a/arch/loongarch/include/asm/page.h b/arch/loongarch/include/asm/page.h
index 63f137ce82a4..afb6fa16b826 100644
--- a/arch/loongarch/include/asm/page.h
+++ b/arch/loongarch/include/asm/page.h
@@ -11,15 +11,7 @@
 /*
  * PAGE_SHIFT determines the page size
  */
-#ifdef CONFIG_PAGE_SIZE_4KB
-#define PAGE_SHIFT	12
-#endif
-#ifdef CONFIG_PAGE_SIZE_16KB
-#define PAGE_SHIFT	14
-#endif
-#ifdef CONFIG_PAGE_SIZE_64KB
-#define PAGE_SHIFT	16
-#endif
+#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
 #define PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
 #define PAGE_MASK	(~(PAGE_SIZE - 1))
 
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 797ae590ebdb..24bac93affee 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -81,6 +81,9 @@ config MIPS
 	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
+	select HAVE_PAGE_SIZE_4KB if !CPU_LOONGSON2EF && !CPU_LOONGSON64
+	select HAVE_PAGE_SIZE_16KB if !CPU_R3000
+	select HAVE_PAGE_SIZE_64KB if !CPU_R3000
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
@@ -1608,6 +1611,8 @@ config CPU_CAVIUM_OCTEON
 	depends on SYS_HAS_CPU_CAVIUM_OCTEON
 	select CPU_HAS_PREFETCH
 	select CPU_SUPPORTS_64BIT_KERNEL
+	select HAVE_PAGE_SIZE_8KB if !MIPS_VA_BITS_48
+	select HAVE_PAGE_SIZE_32KB if !MIPS_VA_BITS_48
 	select WEAK_ORDERING
 	select CPU_SUPPORTS_HIGHMEM
 	select CPU_SUPPORTS_HUGEPAGES
@@ -2029,59 +2034,6 @@ config ZBOOT_LOAD_ADDRESS
 
 	  This is only used if non-zero.
 
-choice
-	prompt "Kernel page size"
-	default PAGE_SIZE_4KB
-
-config PAGE_SIZE_4KB
-	bool "4kB"
-	depends on !CPU_LOONGSON2EF && !CPU_LOONGSON64
-	help
-	  This option select the standard 4kB Linux page size.  On some
-	  R3000-family processors this is the only available page size.  Using
-	  4kB page size will minimize memory consumption and is therefore
-	  recommended for low memory systems.
-
-config PAGE_SIZE_8KB
-	bool "8kB"
-	depends on CPU_CAVIUM_OCTEON
-	depends on !MIPS_VA_BITS_48
-	help
-	  Using 8kB page size will result in higher performance kernel at
-	  the price of higher memory consumption.  This option is available
-	  only on cnMIPS processors.  Note that you will need a suitable Linux
-	  distribution to support this.
-
-config PAGE_SIZE_16KB
-	bool "16kB"
-	depends on !CPU_R3000
-	help
-	  Using 16kB page size will result in higher performance kernel at
-	  the price of higher memory consumption.  This option is available on
-	  all non-R3000 family processors.  Note that you will need a suitable
-	  Linux distribution to support this.
-
-config PAGE_SIZE_32KB
-	bool "32kB"
-	depends on CPU_CAVIUM_OCTEON
-	depends on !MIPS_VA_BITS_48
-	help
-	  Using 32kB page size will result in higher performance kernel at
-	  the price of higher memory consumption.  This option is available
-	  only on cnMIPS cores.  Note that you will need a suitable Linux
-	  distribution to support this.
-
-config PAGE_SIZE_64KB
-	bool "64kB"
-	depends on !CPU_R3000
-	help
-	  Using 64kB page size will result in higher performance kernel at
-	  the price of higher memory consumption.  This option is available on
-	  all non-R3000 family processor.  Not that at the time of this
-	  writing this option is still high experimental.
-
-endchoice
-
 config ARCH_FORCE_MAX_ORDER
 	int "Maximum zone order"
 	default "13" if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_64KB
diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index ef9585d96f6b..4609cb0326cf 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -17,21 +17,7 @@
 /*
  * PAGE_SHIFT determines the page size
  */
-#ifdef CONFIG_PAGE_SIZE_4KB
-#define PAGE_SHIFT	12
-#endif
-#ifdef CONFIG_PAGE_SIZE_8KB
-#define PAGE_SHIFT	13
-#endif
-#ifdef CONFIG_PAGE_SIZE_16KB
-#define PAGE_SHIFT	14
-#endif
-#ifdef CONFIG_PAGE_SIZE_32KB
-#define PAGE_SHIFT	15
-#endif
-#ifdef CONFIG_PAGE_SIZE_64KB
-#define PAGE_SHIFT	16
-#endif
+#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
 #define PAGE_SIZE	(_AC(1,UL) << PAGE_SHIFT)
 #define PAGE_MASK	(~((1 << PAGE_SHIFT) - 1))
 
diff --git a/arch/sh/include/asm/page.h b/arch/sh/include/asm/page.h
index 62f4b9edcb98..f780b467e75d 100644
--- a/arch/sh/include/asm/page.h
+++ b/arch/sh/include/asm/page.h
@@ -9,18 +9,7 @@
 #include <linux/const.h>
 
 /* PAGE_SHIFT determines the page size */
-#if defined(CONFIG_PAGE_SIZE_4KB)
-# define PAGE_SHIFT	12
-#elif defined(CONFIG_PAGE_SIZE_8KB)
-# define PAGE_SHIFT	13
-#elif defined(CONFIG_PAGE_SIZE_16KB)
-# define PAGE_SHIFT	14
-#elif defined(CONFIG_PAGE_SIZE_64KB)
-# define PAGE_SHIFT	16
-#else
-# error "Bogus kernel page size?"
-#endif
-
+#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
 #define PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
 #define PAGE_MASK	(~(PAGE_SIZE-1))
 #define PTE_MASK	PAGE_MASK
diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
index 455311d9a5e9..f32a1963ff0c 100644
--- a/arch/sh/mm/Kconfig
+++ b/arch/sh/mm/Kconfig
@@ -4,6 +4,9 @@ menu "Memory management options"
 config MMU
         bool "Support for memory management hardware"
 	depends on !CPU_SH2
+	select HAVE_PAGE_SIZE_4KB
+	select HAVE_PAGE_SIZE_8KB if X2TLB
+	select HAVE_PAGE_SIZE_64KB if CPU_SH4
 	default y
 	help
 	  Some SH processors (such as SH-2/SH-2A) lack an MMU. In order to
@@ -13,6 +16,15 @@ config MMU
 	  turning this off will boot the kernel on these machines with the
 	  MMU implicitly switched off.
 
+config NOMMU
+	def_bool !MMU
+	select HAVE_PAGE_SIZE_4KB
+	select HAVE_PAGE_SIZE_8KB
+	select HAVE_PAGE_SIZE_16KB
+	select HAVE_PAGE_SIZE_64KB
+	help
+	  On MMU-less systems, any of these page sizes can be selected
+
 config PAGE_OFFSET
 	hex
 	default "0x80000000" if MMU
@@ -147,36 +159,6 @@ config HAVE_SRAM_POOL
 	bool
 	select GENERIC_ALLOCATOR
 
-choice
-	prompt "Kernel page size"
-	default PAGE_SIZE_4KB
-
-config PAGE_SIZE_4KB
-	bool "4kB"
-	help
-	  This is the default page size used by all SuperH CPUs.
-
-config PAGE_SIZE_8KB
-	bool "8kB"
-	depends on !MMU || X2TLB
-	help
-	  This enables 8kB pages as supported by SH-X2 and later MMUs.
-
-config PAGE_SIZE_16KB
-	bool "16kB"
-	depends on !MMU
-	help
-	  This enables 16kB pages on MMU-less SH systems.
-
-config PAGE_SIZE_64KB
-	bool "64kB"
-	depends on !MMU || CPU_SH4
-	help
-	  This enables support for 64kB pages, possible on all SH-4
-	  CPUs and later.
-
-endchoice
-
 choice
 	prompt "HugeTLB page size"
 	depends on HUGETLB_PAGE
-- 
2.39.2


