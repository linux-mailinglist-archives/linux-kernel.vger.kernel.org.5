Return-Path: <linux-kernel+bounces-167364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0A68BA879
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2A3E1C21C85
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41C3152173;
	Fri,  3 May 2024 08:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJVyxYBi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40F214A0B3;
	Fri,  3 May 2024 08:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714723959; cv=none; b=M/apmOdrFwue0O2h+XGECTlfGvlXvRNqvfRsxJEOWVyTgJwbTJDIVyl7LAz1notOW+1V9hL4lBHrDVSNTzW8vMUps/vpdLZyP2+lrG+ZftUl4I79kQcU2Uxgad9cPGpyNd0c3TtbVm6RdoBBfSeLl/WAwIEJMZ7wkVt7VAINEAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714723959; c=relaxed/simple;
	bh=b/gQQxfoCzoMPB9I+vK77DtVewXMRl8ExmsKKTT3v5g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jIrgr8I68LxIlW73cj5nSF41qJTb4cKhuXbeooJmLVnwh0mxCHg/zQiO9vUXvT56uD2kIabS0TyTwhWB/dtIb14UGl0/BO0LzU1cqXTLvX06Af7bZKl/mJJCgs07MaqnHwA+QkRPTZP8Mw34I180iGC40q26asoYSy9YKyuXyAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJVyxYBi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FA5C4AF18;
	Fri,  3 May 2024 08:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714723958;
	bh=b/gQQxfoCzoMPB9I+vK77DtVewXMRl8ExmsKKTT3v5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MJVyxYBih9CIR5GiL8I52NxnT2hsYIfcczc41Z6SC+Dk32W0byx07BfBZoHfaJdBW
	 favniby4y/GMHiho80wfExgujP0kNteBWR6n3qlqMNuPGY7MmsR/b/JbOn9pvJxvCb
	 SX+Yt+bHP8IVE5rMRrmLhm4D62sSDM82qyqHLhwDSNlmfe4A9Xih1e3mTSLombxo35
	 iF5Ors/yXS8xWV82fzzMuePBBhpp71MgBXbQ7uV7kKYha/6FjhkpiUeKUYnLUkThnF
	 yQ0b92VV+DNKAtvLoLHsl0WXzDede8gkP6BrSVWQ21BuNaOhUaSWwy1v3WutO6x7D3
	 wEwX+nLohluiQ==
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
Subject: [PATCH 12/14] alpha: remove LCA and APECS based machines
Date: Fri,  3 May 2024 10:11:23 +0200
Message-Id: <20240503081125.67990-13-arnd@kernel.org>
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

APECS is the DECchip 21071x chipset for the EV4 and EV45 generation, while
LCA is the integrated I/O support on the corresponding low-cost alpha
machines of that generation.

All of these CPUs lack the BWX extension for byte and word access, so
drop the chipset support and all associated machines.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/Kconfig                  | 114 +-----
 arch/alpha/include/asm/core_apecs.h | 534 ----------------------------
 arch/alpha/include/asm/core_lca.h   | 378 --------------------
 arch/alpha/include/asm/dma.h        |   9 +-
 arch/alpha/include/asm/io.h         |   6 +-
 arch/alpha/include/asm/irq.h        |   8 +-
 arch/alpha/kernel/Makefile          |  19 +-
 arch/alpha/kernel/core_apecs.c      | 420 ----------------------
 arch/alpha/kernel/core_lca.c        | 473 ------------------------
 arch/alpha/kernel/irq_i8259.c       |   4 -
 arch/alpha/kernel/pci_impl.h        |   4 +-
 arch/alpha/kernel/proto.h           |  13 -
 arch/alpha/kernel/setup.c           |  79 +---
 arch/alpha/kernel/sys_cabriolet.c   |  59 ---
 arch/alpha/kernel/sys_eb64p.c       | 238 -------------
 arch/alpha/kernel/sys_mikasa.c      |  57 ---
 arch/alpha/kernel/sys_noritake.c    |  60 ----
 arch/alpha/kernel/sys_sio.c         | 486 -------------------------
 18 files changed, 21 insertions(+), 2940 deletions(-)
 delete mode 100644 arch/alpha/include/asm/core_apecs.h
 delete mode 100644 arch/alpha/include/asm/core_lca.h
 delete mode 100644 arch/alpha/kernel/core_apecs.c
 delete mode 100644 arch/alpha/kernel/core_lca.c
 delete mode 100644 arch/alpha/kernel/sys_eb64p.c
 delete mode 100644 arch/alpha/kernel/sys_sio.c

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 951a9c712361..ee209e895505 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -90,20 +90,12 @@ choice
 	  <http://www.alphalinux.org/>. In summary:
 
 	  Alcor/Alpha-XLT     AS 600, AS 500, XL-300, XL-366
-	  Alpha-XL            XL-233, XL-266
-	  AlphaBook1          Alpha laptop
-	  Avanti              AS 200, AS 205, AS 250, AS 255, AS 300, AS 400
-	  Cabriolet           AlphaPC64, AlphaPCI64
 	  DP264               DP264 / DS20 / ES40 / DS10 / DS10L
 	  EB164               EB164 21164 evaluation board
-	  EB64+               EB64+ 21064 evaluation board
-	  EB66                EB66 21066 evaluation board
-	  EB66+               EB66+ 21066 evaluation board
 	  LX164               AlphaPC164-LX
 	  Miata               Personal Workstation 433/500/600 a/au
 	  Marvel              AlphaServer ES47 / ES80 / GS1280
 	  Mikasa              AS 1000
-	  Noname              AXPpci33, UDB (Multia)
 	  Noritake            AS 1000A, AS 600A, AS 800
 	  PC164               AlphaPC164
 	  Rawhide             AS 1200, AS 4000, AS 4100
@@ -135,27 +127,6 @@ config ALPHA_ALCOR
 	  all the work required to support an external Bcache and to maintain
 	  memory coherence when a PCI device DMAs into (or out of) memory.
 
-config ALPHA_XL
-	bool "Alpha-XL"
-	help
-	  XL-233 and XL-266-based Alpha systems.
-
-config ALPHA_BOOK1
-	bool "AlphaBook1"
-	help
-	  Dec AlphaBook1/Burns Alpha-based laptops.
-
-config ALPHA_AVANTI_CH
-	bool "Avanti"
-
-config ALPHA_CABRIOLET
-	bool "Cabriolet"
-	help
-	  Cabriolet AlphaPC64, AlphaPCI64 systems.  Derived from EB64+ but now
-	  baby-AT with Flash boot ROM, no on-board SCSI or Ethernet. 3 ISA
-	  slots, 4 PCI slots (one pair are on a shared slot), uses plug-in
-	  Bcache SIMMs.  Requires power supply with 3.3V output.
-
 config ALPHA_DP264
 	bool "DP264"
 	help
@@ -173,23 +144,6 @@ config ALPHA_EB164
 	  MOUSE (PS2 style), RTC/NVRAM.  Boot ROM is Flash.  PC-AT-sized
 	  motherboard.  Requires power supply with 3.3V output.
 
-config ALPHA_EB64P_CH
-	bool "EB64+"
-
-config ALPHA_EB66
-	bool "EB66"
-	help
-	  A Digital DS group board.  Uses 21066 or 21066A.  I/O sub-system is
-	  identical to EB64+.  Baby PC-AT size.  Runs from standard PC power
-	  supply.  The EB66 schematic was published as a marketing poster
-	  advertising the 21066 as "the first microprocessor in the world with
-	  embedded PCI".
-
-config ALPHA_EB66P
-	bool "EB66+"
-	help
-	  Later variant of the EB66 board.
-
 config ALPHA_EIGER
 	bool "Eiger"
 	help
@@ -224,9 +178,6 @@ config ALPHA_NAUTILUS
 	help
 	  Alpha systems based on the AMD 751 & ALI 1543C chipsets.
 
-config ALPHA_NONAME_CH
-	bool "Noname"
-
 config ALPHA_NORITAKE
 	bool "Noritake"
 	select HAVE_EISA
@@ -237,9 +188,6 @@ config ALPHA_NORITAKE
 config ALPHA_PC164
 	bool "PC164"
 
-config ALPHA_P2K
-	bool "Platform2000"
-
 config ALPHA_RAWHIDE
 	bool "Rawhide"
 	select HAVE_EISA
@@ -303,53 +251,16 @@ config ISA_DMA_API
 	bool
 	default y
 
-config ALPHA_NONAME
-	bool
-	depends on ALPHA_BOOK1 || ALPHA_NONAME_CH
-	default y
-	help
-	  The AXPpci33 (aka NoName), is based on the EB66 (includes the Multia
-	  UDB).  This design was produced by Digital's Technical OEM (TOEM)
-	  group. It uses the 21066 processor running at 166MHz or 233MHz. It
-	  is a baby-AT size, and runs from a standard PC power supply. It has
-	  5 ISA slots and 3 PCI slots (one pair are a shared slot). There are
-	  2 versions, with either PS/2 or large DIN connectors for the
-	  keyboard.
-
 config ALPHA_EV4
 	bool
-	depends on ALPHA_NORITAKE && !ALPHA_PRIMO || ALPHA_MIKASA && !ALPHA_PRIMO || ALPHA_CABRIOLET || ALPHA_AVANTI_CH || ALPHA_EB64P_CH || ALPHA_XL || ALPHA_NONAME || ALPHA_EB66 || ALPHA_EB66P || ALPHA_P2K
-	default y
-
-config ALPHA_LCA
-	bool
-	depends on ALPHA_NONAME || ALPHA_EB66 || ALPHA_EB66P || ALPHA_P2K
-	default y
-
-config ALPHA_APECS
-	bool
-	depends on !ALPHA_PRIMO && (ALPHA_NORITAKE || ALPHA_MIKASA) || ALPHA_CABRIOLET || ALPHA_AVANTI_CH || ALPHA_EB64P_CH || ALPHA_XL
-	default y
-
-config ALPHA_EB64P
-	bool
-	depends on ALPHA_CABRIOLET || ALPHA_EB64P_CH
-	default y
-	help
-	  Uses 21064 or 21064A and APECs.  Has ISA and PCI expansion (3 ISA,
-	  2 PCI, one pair are on a shared slot). Supports 36-bit DRAM SIMs.
-	  ISA bus generated by Intel SaturnI/O PCI-ISA bridge. On-board SCSI
-	  (NCR 810 on PCI) Ethernet (Digital 21040), KBD, MOUSE (PS2 style),
-	  SuperI/O (2S, 1P, FD), RTC/NVRAM. Boot ROM is EPROM.  PC-AT size.
-	  Runs from standard PC power supply.
 
 config ALPHA_EV5
 	bool
-	default y if ALPHA_RX164 || ALPHA_RAWHIDE || ALPHA_MIATA || ALPHA_LX164 || ALPHA_SX164 || ALPHA_RUFFIAN || ALPHA_SABLE || ALPHA_NORITAKE && ALPHA_PRIMO || ALPHA_MIKASA && ALPHA_PRIMO || ALPHA_PC164 || ALPHA_TAKARA || ALPHA_EB164 || ALPHA_ALCOR
+	default y if ALPHA_RX164 || ALPHA_RAWHIDE || ALPHA_MIATA || ALPHA_LX164 || ALPHA_SX164 || ALPHA_RUFFIAN || ALPHA_SABLE || ALPHA_NORITAKE || ALPHA_MIKASA || ALPHA_PC164 || ALPHA_TAKARA || ALPHA_EB164 || ALPHA_ALCOR
 
 config ALPHA_CIA
 	bool
-	depends on ALPHA_MIATA || ALPHA_LX164 || ALPHA_SX164 || ALPHA_RUFFIAN || ALPHA_NORITAKE && ALPHA_PRIMO || ALPHA_MIKASA && ALPHA_PRIMO || ALPHA_PC164 || ALPHA_TAKARA || ALPHA_EB164 || ALPHA_ALCOR
+	depends on ALPHA_MIATA || ALPHA_LX164 || ALPHA_SX164 || ALPHA_RUFFIAN || ALPHA_NORITAKE || ALPHA_MIKASA || ALPHA_PC164 || ALPHA_TAKARA || ALPHA_EB164 || ALPHA_ALCOR
 	default y
 
 config ALPHA_EV56
@@ -358,18 +269,12 @@ config ALPHA_EV56
 
 config ALPHA_EV56
 	prompt "EV56 CPU (speed >= 333MHz)?"
-	depends on ALPHA_NORITAKE || ALPHA_PRIMO
+	depends on ALPHA_NORITAKE || ALPHA_MIKASA
 
 config ALPHA_EV56
 	prompt "EV56 CPU (speed >= 400MHz)?"
 	depends on ALPHA_RAWHIDE
 
-config ALPHA_PRIMO
-	bool "EV5 CPU daughtercard (model 5/xxx)?"
-	depends on ALPHA_NORITAKE || ALPHA_MIKASA
-	help
-	  Say Y if you have an AS 1000 5/xxx or an AS 1000A 5/xxx.
-
 config ALPHA_T2
 	bool
 	depends on ALPHA_SABLE
@@ -416,15 +321,6 @@ config GENERIC_HWEIGHT
 	bool
 	default y if !ALPHA_EV67
 
-config ALPHA_AVANTI
-	bool
-	depends on ALPHA_XL || ALPHA_AVANTI_CH
-	default y
-	help
-	  Avanti AS 200, AS 205, AS 250, AS 255, AS 300, and AS 400-based
-	  Alphas. Info at
-	  <http://www.unix-ag.org/Linux-Alpha/Architectures/Avanti.html>.
-
 config ALPHA_BROKEN_IRQ_MASK
 	bool
 	depends on ALPHA_GENERIC || ALPHA_PC164
@@ -454,7 +350,7 @@ config ALPHA_QEMU
 
 
 config ALPHA_SRM
-	bool "Use SRM as bootloader" if ALPHA_CABRIOLET || ALPHA_AVANTI_CH || ALPHA_EB64P || ALPHA_PC164 || ALPHA_TAKARA || ALPHA_EB164 || ALPHA_ALCOR || ALPHA_MIATA || ALPHA_LX164 || ALPHA_SX164 || ALPHA_NAUTILUS || ALPHA_NONAME
+	bool "Use SRM as bootloader" if ALPHA_PC164 || ALPHA_TAKARA || ALPHA_EB164 || ALPHA_ALCOR || ALPHA_MIATA || ALPHA_LX164 || ALPHA_SX164 || ALPHA_NAUTILUS
 	depends on TTY
 	default y if ALPHA_MIKASA || ALPHA_SABLE || ALPHA_NORITAKE || ALPHA_DP264 || ALPHA_RAWHIDE || ALPHA_EIGER || ALPHA_WILDFIRE || ALPHA_TITAN || ALPHA_SHARK || ALPHA_MARVEL
 	help
@@ -518,7 +414,7 @@ config ARCH_SPARSEMEM_ENABLE
 config ALPHA_WTINT
 	bool "Use WTINT" if ALPHA_SRM || ALPHA_GENERIC
 	default y if ALPHA_QEMU
-	default n if ALPHA_EV5 || ALPHA_EV56 || (ALPHA_EV4 && !ALPHA_LCA)
+	default n if ALPHA_EV5 || ALPHA_EV56
 	default n if !ALPHA_SRM && !ALPHA_GENERIC
 	default y if SMP
 	help
diff --git a/arch/alpha/include/asm/core_apecs.h b/arch/alpha/include/asm/core_apecs.h
deleted file mode 100644
index 69a2fc62c9c3..000000000000
--- a/arch/alpha/include/asm/core_apecs.h
+++ /dev/null
@@ -1,534 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ALPHA_APECS__H__
-#define __ALPHA_APECS__H__
-
-#include <linux/types.h>
-#include <asm/compiler.h>
-
-/*
- * APECS is the internal name for the 2107x chipset which provides
- * memory controller and PCI access for the 21064 chip based systems.
- *
- * This file is based on:
- *
- * DECchip 21071-AA and DECchip 21072-AA Core Logic Chipsets
- * Data Sheet
- *
- * EC-N0648-72
- *
- *
- * david.rusling@reo.mts.dec.com Initial Version.
- *
- */
-
-/*
-   An AVANTI *might* be an XL, and an XL has only 27 bits of ISA address
-   that get passed through the PCI<->ISA bridge chip. So we've gotta use
-   both windows to max out the physical memory we can DMA to. Sigh...
-
-   If we try a window at 0 for 1GB as a work-around, we run into conflicts
-   with ISA/PCI bus memory which can't be relocated, like VGA aperture and
-   BIOS ROMs. So we must put the windows high enough to avoid these areas.
-
-   We put window 1 at BUS 64Mb for 64Mb, mapping physical 0 to 64Mb-1,
-   and window 2 at BUS 1Gb for 1Gb, mapping physical 0 to 1Gb-1.
-   Yes, this does map 0 to 64Mb-1 twice, but only window 1 will actually
-   be used for that range (via virt_to_bus()).
-
-   Note that we actually fudge the window 1 maximum as 48Mb instead of 64Mb,
-   to keep virt_to_bus() from returning an address in the first window, for
-   a data area that goes beyond the 64Mb first DMA window.  Sigh...
-   The fudge factor MUST match with <asm/dma.h> MAX_DMA_ADDRESS, but
-   we can't just use that here, because of header file looping... :-(
-
-   Window 1 will be used for all DMA from the ISA bus; yes, that does
-   limit what memory an ISA floppy or sound card or Ethernet can touch, but
-   it's also a known limitation on other platforms as well. We use the
-   same technique that is used on INTEL platforms with similar limitation:
-   set MAX_DMA_ADDRESS and clear some pages' DMAable flags during mem_init().
-   We trust that any ISA bus device drivers will *always* ask for DMAable
-   memory explicitly via kmalloc()/get_free_pages() flags arguments.
-
-   Note that most PCI bus devices' drivers do *not* explicitly ask for
-   DMAable memory; they count on being able to DMA to any memory they
-   get from kmalloc()/get_free_pages(). They will also use window 1 for
-   any physical memory accesses below 64Mb; the rest will be handled by
-   window 2, maxing out at 1Gb of memory. I trust this is enough... :-)
-
-   We hope that the area before the first window is large enough so that
-   there will be no overlap at the top end (64Mb). We *must* locate the
-   PCI cards' memory just below window 1, so that there's still the
-   possibility of being able to access it via SPARSE space. This is
-   important for cards such as the Matrox Millennium, whose Xserver
-   wants to access memory-mapped registers in byte and short lengths.
-
-   Note that the XL is treated differently from the AVANTI, even though
-   for most other things they are identical. It didn't seem reasonable to
-   make the AVANTI support pay for the limitations of the XL. It is true,
-   however, that an XL kernel will run on an AVANTI without problems.
-
-   %%% All of this should be obviated by the ability to route
-   everything through the iommu.
-*/
-
-/*
- * 21071-DA Control and Status registers.
- * These are used for PCI memory access.
- */
-#define APECS_IOC_DCSR                  (IDENT_ADDR + 0x1A0000000UL)
-#define APECS_IOC_PEAR                  (IDENT_ADDR + 0x1A0000020UL)
-#define APECS_IOC_SEAR                  (IDENT_ADDR + 0x1A0000040UL)
-#define APECS_IOC_DR1                   (IDENT_ADDR + 0x1A0000060UL)
-#define APECS_IOC_DR2                   (IDENT_ADDR + 0x1A0000080UL)
-#define APECS_IOC_DR3                   (IDENT_ADDR + 0x1A00000A0UL)
-
-#define APECS_IOC_TB1R                  (IDENT_ADDR + 0x1A00000C0UL)
-#define APECS_IOC_TB2R                  (IDENT_ADDR + 0x1A00000E0UL)
-
-#define APECS_IOC_PB1R                  (IDENT_ADDR + 0x1A0000100UL)
-#define APECS_IOC_PB2R                  (IDENT_ADDR + 0x1A0000120UL)
-
-#define APECS_IOC_PM1R                  (IDENT_ADDR + 0x1A0000140UL)
-#define APECS_IOC_PM2R                  (IDENT_ADDR + 0x1A0000160UL)
-
-#define APECS_IOC_HAXR0                 (IDENT_ADDR + 0x1A0000180UL)
-#define APECS_IOC_HAXR1                 (IDENT_ADDR + 0x1A00001A0UL)
-#define APECS_IOC_HAXR2                 (IDENT_ADDR + 0x1A00001C0UL)
-
-#define APECS_IOC_PMLT                  (IDENT_ADDR + 0x1A00001E0UL)
-
-#define APECS_IOC_TLBTAG0               (IDENT_ADDR + 0x1A0000200UL)
-#define APECS_IOC_TLBTAG1               (IDENT_ADDR + 0x1A0000220UL)
-#define APECS_IOC_TLBTAG2               (IDENT_ADDR + 0x1A0000240UL)
-#define APECS_IOC_TLBTAG3               (IDENT_ADDR + 0x1A0000260UL)
-#define APECS_IOC_TLBTAG4               (IDENT_ADDR + 0x1A0000280UL)
-#define APECS_IOC_TLBTAG5               (IDENT_ADDR + 0x1A00002A0UL)
-#define APECS_IOC_TLBTAG6               (IDENT_ADDR + 0x1A00002C0UL)
-#define APECS_IOC_TLBTAG7               (IDENT_ADDR + 0x1A00002E0UL)
-
-#define APECS_IOC_TLBDATA0              (IDENT_ADDR + 0x1A0000300UL)
-#define APECS_IOC_TLBDATA1              (IDENT_ADDR + 0x1A0000320UL)
-#define APECS_IOC_TLBDATA2              (IDENT_ADDR + 0x1A0000340UL)
-#define APECS_IOC_TLBDATA3              (IDENT_ADDR + 0x1A0000360UL)
-#define APECS_IOC_TLBDATA4              (IDENT_ADDR + 0x1A0000380UL)
-#define APECS_IOC_TLBDATA5              (IDENT_ADDR + 0x1A00003A0UL)
-#define APECS_IOC_TLBDATA6              (IDENT_ADDR + 0x1A00003C0UL)
-#define APECS_IOC_TLBDATA7              (IDENT_ADDR + 0x1A00003E0UL)
-
-#define APECS_IOC_TBIA                  (IDENT_ADDR + 0x1A0000400UL)
-
-
-/*
- * 21071-CA Control and Status registers.
- * These are used to program memory timing,
- *  configure memory and initialise the B-Cache.
- */
-#define APECS_MEM_GCR		        (IDENT_ADDR + 0x180000000UL)
-#define APECS_MEM_EDSR		        (IDENT_ADDR + 0x180000040UL)
-#define APECS_MEM_TAR  		        (IDENT_ADDR + 0x180000060UL)
-#define APECS_MEM_ELAR		        (IDENT_ADDR + 0x180000080UL)
-#define APECS_MEM_EHAR  		(IDENT_ADDR + 0x1800000a0UL)
-#define APECS_MEM_SFT_RST		(IDENT_ADDR + 0x1800000c0UL)
-#define APECS_MEM_LDxLAR 		(IDENT_ADDR + 0x1800000e0UL)
-#define APECS_MEM_LDxHAR 		(IDENT_ADDR + 0x180000100UL)
-#define APECS_MEM_GTR    		(IDENT_ADDR + 0x180000200UL)
-#define APECS_MEM_RTR    		(IDENT_ADDR + 0x180000220UL)
-#define APECS_MEM_VFPR   		(IDENT_ADDR + 0x180000240UL)
-#define APECS_MEM_PDLDR  		(IDENT_ADDR + 0x180000260UL)
-#define APECS_MEM_PDhDR  		(IDENT_ADDR + 0x180000280UL)
-
-/* Bank x Base Address Register */
-#define APECS_MEM_B0BAR  		(IDENT_ADDR + 0x180000800UL)
-#define APECS_MEM_B1BAR  		(IDENT_ADDR + 0x180000820UL)
-#define APECS_MEM_B2BAR  		(IDENT_ADDR + 0x180000840UL)
-#define APECS_MEM_B3BAR  		(IDENT_ADDR + 0x180000860UL)
-#define APECS_MEM_B4BAR  		(IDENT_ADDR + 0x180000880UL)
-#define APECS_MEM_B5BAR  		(IDENT_ADDR + 0x1800008A0UL)
-#define APECS_MEM_B6BAR  		(IDENT_ADDR + 0x1800008C0UL)
-#define APECS_MEM_B7BAR  		(IDENT_ADDR + 0x1800008E0UL)
-#define APECS_MEM_B8BAR  		(IDENT_ADDR + 0x180000900UL)
-
-/* Bank x Configuration Register */
-#define APECS_MEM_B0BCR  		(IDENT_ADDR + 0x180000A00UL)
-#define APECS_MEM_B1BCR  		(IDENT_ADDR + 0x180000A20UL)
-#define APECS_MEM_B2BCR  		(IDENT_ADDR + 0x180000A40UL)
-#define APECS_MEM_B3BCR  		(IDENT_ADDR + 0x180000A60UL)
-#define APECS_MEM_B4BCR  		(IDENT_ADDR + 0x180000A80UL)
-#define APECS_MEM_B5BCR  		(IDENT_ADDR + 0x180000AA0UL)
-#define APECS_MEM_B6BCR  		(IDENT_ADDR + 0x180000AC0UL)
-#define APECS_MEM_B7BCR  		(IDENT_ADDR + 0x180000AE0UL)
-#define APECS_MEM_B8BCR  		(IDENT_ADDR + 0x180000B00UL)
-
-/* Bank x Timing Register A */
-#define APECS_MEM_B0TRA  		(IDENT_ADDR + 0x180000C00UL)
-#define APECS_MEM_B1TRA  		(IDENT_ADDR + 0x180000C20UL)
-#define APECS_MEM_B2TRA  		(IDENT_ADDR + 0x180000C40UL)
-#define APECS_MEM_B3TRA  		(IDENT_ADDR + 0x180000C60UL)
-#define APECS_MEM_B4TRA  		(IDENT_ADDR + 0x180000C80UL)
-#define APECS_MEM_B5TRA  		(IDENT_ADDR + 0x180000CA0UL)
-#define APECS_MEM_B6TRA  		(IDENT_ADDR + 0x180000CC0UL)
-#define APECS_MEM_B7TRA  		(IDENT_ADDR + 0x180000CE0UL)
-#define APECS_MEM_B8TRA  		(IDENT_ADDR + 0x180000D00UL)
-
-/* Bank x Timing Register B */
-#define APECS_MEM_B0TRB                 (IDENT_ADDR + 0x180000E00UL)
-#define APECS_MEM_B1TRB  		(IDENT_ADDR + 0x180000E20UL)
-#define APECS_MEM_B2TRB  		(IDENT_ADDR + 0x180000E40UL)
-#define APECS_MEM_B3TRB  		(IDENT_ADDR + 0x180000E60UL)
-#define APECS_MEM_B4TRB  		(IDENT_ADDR + 0x180000E80UL)
-#define APECS_MEM_B5TRB  		(IDENT_ADDR + 0x180000EA0UL)
-#define APECS_MEM_B6TRB  		(IDENT_ADDR + 0x180000EC0UL)
-#define APECS_MEM_B7TRB  		(IDENT_ADDR + 0x180000EE0UL)
-#define APECS_MEM_B8TRB  		(IDENT_ADDR + 0x180000F00UL)
-
-
-/*
- * Memory spaces:
- */
-#define APECS_IACK_SC		        (IDENT_ADDR + 0x1b0000000UL)
-#define APECS_CONF		        (IDENT_ADDR + 0x1e0000000UL)
-#define APECS_IO			(IDENT_ADDR + 0x1c0000000UL)
-#define APECS_SPARSE_MEM		(IDENT_ADDR + 0x200000000UL)
-#define APECS_DENSE_MEM		        (IDENT_ADDR + 0x300000000UL)
-
-
-/*
- * Bit definitions for I/O Controller status register 0:
- */
-#define APECS_IOC_STAT0_CMD		0xf
-#define APECS_IOC_STAT0_ERR		(1<<4)
-#define APECS_IOC_STAT0_LOST		(1<<5)
-#define APECS_IOC_STAT0_THIT		(1<<6)
-#define APECS_IOC_STAT0_TREF		(1<<7)
-#define APECS_IOC_STAT0_CODE_SHIFT	8
-#define APECS_IOC_STAT0_CODE_MASK	0x7
-#define APECS_IOC_STAT0_P_NBR_SHIFT	13
-#define APECS_IOC_STAT0_P_NBR_MASK	0x7ffff
-
-#define APECS_HAE_ADDRESS		APECS_IOC_HAXR1
-
-
-/*
- * Data structure for handling APECS machine checks:
- */
-
-struct el_apecs_mikasa_sysdata_mcheck
-{
-	unsigned long coma_gcr;
-	unsigned long coma_edsr;
-	unsigned long coma_ter;
-	unsigned long coma_elar;
-	unsigned long coma_ehar;
-	unsigned long coma_ldlr;
-	unsigned long coma_ldhr;
-	unsigned long coma_base0;
-	unsigned long coma_base1;
-	unsigned long coma_base2;
-	unsigned long coma_base3;
-	unsigned long coma_cnfg0;
-	unsigned long coma_cnfg1;
-	unsigned long coma_cnfg2;
-	unsigned long coma_cnfg3;
-	unsigned long epic_dcsr;
-	unsigned long epic_pear;
-	unsigned long epic_sear;
-	unsigned long epic_tbr1;
-	unsigned long epic_tbr2;
-	unsigned long epic_pbr1;
-	unsigned long epic_pbr2;
-	unsigned long epic_pmr1;
-	unsigned long epic_pmr2;
-	unsigned long epic_harx1;
-	unsigned long epic_harx2;
-	unsigned long epic_pmlt;
-	unsigned long epic_tag0;
-	unsigned long epic_tag1;
-	unsigned long epic_tag2;
-	unsigned long epic_tag3;
-	unsigned long epic_tag4;
-	unsigned long epic_tag5;
-	unsigned long epic_tag6;
-	unsigned long epic_tag7;
-	unsigned long epic_data0;
-	unsigned long epic_data1;
-	unsigned long epic_data2;
-	unsigned long epic_data3;
-	unsigned long epic_data4;
-	unsigned long epic_data5;
-	unsigned long epic_data6;
-	unsigned long epic_data7;
-
-	unsigned long pceb_vid;
-	unsigned long pceb_did;
-	unsigned long pceb_revision;
-	unsigned long pceb_command;
-	unsigned long pceb_status;
-	unsigned long pceb_latency;
-	unsigned long pceb_control;
-	unsigned long pceb_arbcon;
-	unsigned long pceb_arbpri;
-
-	unsigned long esc_id;
-	unsigned long esc_revision;
-	unsigned long esc_int0;
-	unsigned long esc_int1;
-	unsigned long esc_elcr0;
-	unsigned long esc_elcr1;
-	unsigned long esc_last_eisa;
-	unsigned long esc_nmi_stat;
-
-	unsigned long pci_ir;
-	unsigned long pci_imr;
-	unsigned long svr_mgr;
-};
-
-/* This for the normal APECS machines.  */
-struct el_apecs_sysdata_mcheck
-{
-	unsigned long coma_gcr;
-	unsigned long coma_edsr;
-	unsigned long coma_ter;
-	unsigned long coma_elar;
-	unsigned long coma_ehar;
-	unsigned long coma_ldlr;
-	unsigned long coma_ldhr;
-	unsigned long coma_base0;
-	unsigned long coma_base1;
-	unsigned long coma_base2;
-	unsigned long coma_cnfg0;
-	unsigned long coma_cnfg1;
-	unsigned long coma_cnfg2;
-	unsigned long epic_dcsr;
-	unsigned long epic_pear;
-	unsigned long epic_sear;
-	unsigned long epic_tbr1;
-	unsigned long epic_tbr2;
-	unsigned long epic_pbr1;
-	unsigned long epic_pbr2;
-	unsigned long epic_pmr1;
-	unsigned long epic_pmr2;
-	unsigned long epic_harx1;
-	unsigned long epic_harx2;
-	unsigned long epic_pmlt;
-	unsigned long epic_tag0;
-	unsigned long epic_tag1;
-	unsigned long epic_tag2;
-	unsigned long epic_tag3;
-	unsigned long epic_tag4;
-	unsigned long epic_tag5;
-	unsigned long epic_tag6;
-	unsigned long epic_tag7;
-	unsigned long epic_data0;
-	unsigned long epic_data1;
-	unsigned long epic_data2;
-	unsigned long epic_data3;
-	unsigned long epic_data4;
-	unsigned long epic_data5;
-	unsigned long epic_data6;
-	unsigned long epic_data7;
-};
-
-struct el_apecs_procdata
-{
-	unsigned long paltemp[32];  /* PAL TEMP REGS. */
-	/* EV4-specific fields */
-	unsigned long exc_addr;     /* Address of excepting instruction. */
-	unsigned long exc_sum;      /* Summary of arithmetic traps. */
-	unsigned long exc_mask;     /* Exception mask (from exc_sum). */
-	unsigned long iccsr;        /* IBox hardware enables. */
-	unsigned long pal_base;     /* Base address for PALcode. */
-	unsigned long hier;         /* Hardware Interrupt Enable. */
-	unsigned long hirr;         /* Hardware Interrupt Request. */
-	unsigned long csr;          /* D-stream fault info. */
-	unsigned long dc_stat;      /* D-cache status (ECC/Parity Err). */
-	unsigned long dc_addr;      /* EV3 Phys Addr for ECC/DPERR. */
-	unsigned long abox_ctl;     /* ABox Control Register. */
-	unsigned long biu_stat;     /* BIU Status. */
-	unsigned long biu_addr;     /* BUI Address. */
-	unsigned long biu_ctl;      /* BIU Control. */
-	unsigned long fill_syndrome;/* For correcting ECC errors. */
-	unsigned long fill_addr;    /* Cache block which was being read */
-	unsigned long va;           /* Effective VA of fault or miss. */
-	unsigned long bc_tag;       /* Backup Cache Tag Probe Results.*/
-};
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
- * I/O functions:
- *
- * Unlike Jensen, the APECS machines have no concept of local
- * I/O---everything goes over the PCI bus.
- *
- * There is plenty room for optimization here.  In particular,
- * the Alpha's insb/insw/extb/extw should be useful in moving
- * data to/from the right byte-lanes.
- */
-
-#define vip	volatile int __force *
-#define vuip	volatile unsigned int __force *
-#define vulp	volatile unsigned long __force *
-
-#define APECS_SET_HAE						\
-	do {							\
-		if (addr >= (1UL << 24)) {			\
-			unsigned long msb = addr & 0xf8000000;	\
-			addr -= msb;				\
-			set_hae(msb);				\
-		}						\
-	} while (0)
-
-__EXTERN_INLINE u8 apecs_ioread8(const void __iomem *xaddr)
-{
-	unsigned long addr = (unsigned long) xaddr;
-	unsigned long result, base_and_type;
-
-	if (addr >= APECS_DENSE_MEM) {
-		addr -= APECS_DENSE_MEM;
-		APECS_SET_HAE;
-		base_and_type = APECS_SPARSE_MEM + 0x00;
-	} else {
-		addr -= APECS_IO;
-		base_and_type = APECS_IO + 0x00;
-	}
-
-	result = *(vip) ((addr << 5) + base_and_type);
-	return __kernel_extbl(result, addr & 3);
-}
-
-__EXTERN_INLINE void apecs_iowrite8(u8 b, void __iomem *xaddr)
-{
-	unsigned long addr = (unsigned long) xaddr;
-	unsigned long w, base_and_type;
-
-	if (addr >= APECS_DENSE_MEM) {
-		addr -= APECS_DENSE_MEM;
-		APECS_SET_HAE;
-		base_and_type = APECS_SPARSE_MEM + 0x00;
-	} else {
-		addr -= APECS_IO;
-		base_and_type = APECS_IO + 0x00;
-	}
-
-	w = __kernel_insbl(b, addr & 3);
-	*(vuip) ((addr << 5) + base_and_type) = w;
-}
-
-__EXTERN_INLINE u16 apecs_ioread16(const void __iomem *xaddr)
-{
-	unsigned long addr = (unsigned long) xaddr;
-	unsigned long result, base_and_type;
-
-	if (addr >= APECS_DENSE_MEM) {
-		addr -= APECS_DENSE_MEM;
-		APECS_SET_HAE;
-		base_and_type = APECS_SPARSE_MEM + 0x08;
-	} else {
-		addr -= APECS_IO;
-		base_and_type = APECS_IO + 0x08;
-	}
-
-	result = *(vip) ((addr << 5) + base_and_type);
-	return __kernel_extwl(result, addr & 3);
-}
-
-__EXTERN_INLINE void apecs_iowrite16(u16 b, void __iomem *xaddr)
-{
-	unsigned long addr = (unsigned long) xaddr;
-	unsigned long w, base_and_type;
-
-	if (addr >= APECS_DENSE_MEM) {
-		addr -= APECS_DENSE_MEM;
-		APECS_SET_HAE;
-		base_and_type = APECS_SPARSE_MEM + 0x08;
-	} else {
-		addr -= APECS_IO;
-		base_and_type = APECS_IO + 0x08;
-	}
-
-	w = __kernel_inswl(b, addr & 3);
-	*(vuip) ((addr << 5) + base_and_type) = w;
-}
-
-__EXTERN_INLINE u32 apecs_ioread32(const void __iomem *xaddr)
-{
-	unsigned long addr = (unsigned long) xaddr;
-	if (addr < APECS_DENSE_MEM)
-		addr = ((addr - APECS_IO) << 5) + APECS_IO + 0x18;
-	return *(vuip)addr;
-}
-
-__EXTERN_INLINE void apecs_iowrite32(u32 b, void __iomem *xaddr)
-{
-	unsigned long addr = (unsigned long) xaddr;
-	if (addr < APECS_DENSE_MEM)
-		addr = ((addr - APECS_IO) << 5) + APECS_IO + 0x18;
-	*(vuip)addr = b;
-}
-
-__EXTERN_INLINE u64 apecs_ioread64(const void __iomem *xaddr)
-{
-	unsigned long addr = (unsigned long) xaddr;
-	if (addr < APECS_DENSE_MEM)
-		addr = ((addr - APECS_IO) << 5) + APECS_IO + 0x18;
-	return *(vulp)addr;
-}
-
-__EXTERN_INLINE void apecs_iowrite64(u64 b, void __iomem *xaddr)
-{
-	unsigned long addr = (unsigned long) xaddr;
-	if (addr < APECS_DENSE_MEM)
-		addr = ((addr - APECS_IO) << 5) + APECS_IO + 0x18;
-	*(vulp)addr = b;
-}
-
-__EXTERN_INLINE void __iomem *apecs_ioportmap(unsigned long addr)
-{
-	return (void __iomem *)(addr + APECS_IO);
-}
-
-__EXTERN_INLINE void __iomem *apecs_ioremap(unsigned long addr,
-					    unsigned long size)
-{
-	return (void __iomem *)(addr + APECS_DENSE_MEM);
-}
-
-__EXTERN_INLINE int apecs_is_ioaddr(unsigned long addr)
-{
-	return addr >= IDENT_ADDR + 0x180000000UL;
-}
-
-__EXTERN_INLINE int apecs_is_mmio(const volatile void __iomem *addr)
-{
-	return (unsigned long)addr >= APECS_DENSE_MEM;
-}
-
-#undef APECS_SET_HAE
-
-#undef vip
-#undef vuip
-#undef vulp
-
-#undef __IO_PREFIX
-#define __IO_PREFIX		apecs
-#define apecs_trivial_io_bw	0
-#define apecs_trivial_io_lq	0
-#define apecs_trivial_rw_bw	2
-#define apecs_trivial_rw_lq	1
-#define apecs_trivial_iounmap	1
-#include <asm/io_trivial.h>
-
-#ifdef __IO_EXTERN_INLINE
-#undef __EXTERN_INLINE
-#undef __IO_EXTERN_INLINE
-#endif
-
-#endif /* __KERNEL__ */
-
-#endif /* __ALPHA_APECS__H__ */
diff --git a/arch/alpha/include/asm/core_lca.h b/arch/alpha/include/asm/core_lca.h
deleted file mode 100644
index d8c3e72ef8f6..000000000000
--- a/arch/alpha/include/asm/core_lca.h
+++ /dev/null
@@ -1,378 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ALPHA_LCA__H__
-#define __ALPHA_LCA__H__
-
-#include <asm/compiler.h>
-#include <asm/mce.h>
-
-/*
- * Low Cost Alpha (LCA) definitions (these apply to 21066 and 21068,
- * for example).
- *
- * This file is based on:
- *
- *	DECchip 21066 and DECchip 21068 Alpha AXP Microprocessors
- *	Hardware Reference Manual; Digital Equipment Corp.; May 1994;
- *	Maynard, MA; Order Number: EC-N2681-71.
- */
-
-/*
- * NOTE: The LCA uses a Host Address Extension (HAE) register to access
- *	 PCI addresses that are beyond the first 27 bits of address
- *	 space.  Updating the HAE requires an external cycle (and
- *	 a memory barrier), which tends to be slow.  Instead of updating
- *	 it on each sparse memory access, we keep the current HAE value
- *	 cached in variable cache_hae.  Only if the cached HAE differs
- *	 from the desired HAE value do we actually updated HAE register.
- *	 The HAE register is preserved by the interrupt handler entry/exit
- *	 code, so this scheme works even in the presence of interrupts.
- *
- * Dense memory space doesn't require the HAE, but is restricted to
- * aligned 32 and 64 bit accesses.  Special Cycle and Interrupt
- * Acknowledge cycles may also require the use of the HAE.  The LCA
- * limits I/O address space to the bottom 24 bits of address space,
- * but this easily covers the 16 bit ISA I/O address space.
- */
-
-/*
- * NOTE 2! The memory operations do not set any memory barriers, as
- * it's not needed for cases like a frame buffer that is essentially
- * memory-like.  You need to do them by hand if the operations depend
- * on ordering.
- *
- * Similarly, the port I/O operations do a "mb" only after a write
- * operation: if an mb is needed before (as in the case of doing
- * memory mapped I/O first, and then a port I/O operation to the same
- * device), it needs to be done by hand.
- *
- * After the above has bitten me 100 times, I'll give up and just do
- * the mb all the time, but right now I'm hoping this will work out.
- * Avoiding mb's may potentially be a noticeable speed improvement,
- * but I can't honestly say I've tested it.
- *
- * Handling interrupts that need to do mb's to synchronize to
- * non-interrupts is another fun race area.  Don't do it (because if
- * you do, I'll have to do *everything* with interrupts disabled,
- * ugh).
- */
-
-/*
- * Memory Controller registers:
- */
-#define LCA_MEM_BCR0		(IDENT_ADDR + 0x120000000UL)
-#define LCA_MEM_BCR1		(IDENT_ADDR + 0x120000008UL)
-#define LCA_MEM_BCR2		(IDENT_ADDR + 0x120000010UL)
-#define LCA_MEM_BCR3		(IDENT_ADDR + 0x120000018UL)
-#define LCA_MEM_BMR0		(IDENT_ADDR + 0x120000020UL)
-#define LCA_MEM_BMR1		(IDENT_ADDR + 0x120000028UL)
-#define LCA_MEM_BMR2		(IDENT_ADDR + 0x120000030UL)
-#define LCA_MEM_BMR3		(IDENT_ADDR + 0x120000038UL)
-#define LCA_MEM_BTR0		(IDENT_ADDR + 0x120000040UL)
-#define LCA_MEM_BTR1		(IDENT_ADDR + 0x120000048UL)
-#define LCA_MEM_BTR2		(IDENT_ADDR + 0x120000050UL)
-#define LCA_MEM_BTR3		(IDENT_ADDR + 0x120000058UL)
-#define LCA_MEM_GTR		(IDENT_ADDR + 0x120000060UL)
-#define LCA_MEM_ESR		(IDENT_ADDR + 0x120000068UL)
-#define LCA_MEM_EAR		(IDENT_ADDR + 0x120000070UL)
-#define LCA_MEM_CAR		(IDENT_ADDR + 0x120000078UL)
-#define LCA_MEM_VGR		(IDENT_ADDR + 0x120000080UL)
-#define LCA_MEM_PLM		(IDENT_ADDR + 0x120000088UL)
-#define LCA_MEM_FOR		(IDENT_ADDR + 0x120000090UL)
-
-/*
- * I/O Controller registers:
- */
-#define LCA_IOC_HAE		(IDENT_ADDR + 0x180000000UL)
-#define LCA_IOC_CONF		(IDENT_ADDR + 0x180000020UL)
-#define LCA_IOC_STAT0		(IDENT_ADDR + 0x180000040UL)
-#define LCA_IOC_STAT1		(IDENT_ADDR + 0x180000060UL)
-#define LCA_IOC_TBIA		(IDENT_ADDR + 0x180000080UL)
-#define LCA_IOC_TB_ENA		(IDENT_ADDR + 0x1800000a0UL)
-#define LCA_IOC_SFT_RST		(IDENT_ADDR + 0x1800000c0UL)
-#define LCA_IOC_PAR_DIS		(IDENT_ADDR + 0x1800000e0UL)
-#define LCA_IOC_W_BASE0		(IDENT_ADDR + 0x180000100UL)
-#define LCA_IOC_W_BASE1		(IDENT_ADDR + 0x180000120UL)
-#define LCA_IOC_W_MASK0		(IDENT_ADDR + 0x180000140UL)
-#define LCA_IOC_W_MASK1		(IDENT_ADDR + 0x180000160UL)
-#define LCA_IOC_T_BASE0		(IDENT_ADDR + 0x180000180UL)
-#define LCA_IOC_T_BASE1		(IDENT_ADDR + 0x1800001a0UL)
-#define LCA_IOC_TB_TAG0		(IDENT_ADDR + 0x188000000UL)
-#define LCA_IOC_TB_TAG1		(IDENT_ADDR + 0x188000020UL)
-#define LCA_IOC_TB_TAG2		(IDENT_ADDR + 0x188000040UL)
-#define LCA_IOC_TB_TAG3		(IDENT_ADDR + 0x188000060UL)
-#define LCA_IOC_TB_TAG4		(IDENT_ADDR + 0x188000070UL)
-#define LCA_IOC_TB_TAG5		(IDENT_ADDR + 0x1880000a0UL)
-#define LCA_IOC_TB_TAG6		(IDENT_ADDR + 0x1880000c0UL)
-#define LCA_IOC_TB_TAG7		(IDENT_ADDR + 0x1880000e0UL)
-
-/*
- * Memory spaces:
- */
-#define LCA_IACK_SC		(IDENT_ADDR + 0x1a0000000UL)
-#define LCA_CONF		(IDENT_ADDR + 0x1e0000000UL)
-#define LCA_IO			(IDENT_ADDR + 0x1c0000000UL)
-#define LCA_SPARSE_MEM		(IDENT_ADDR + 0x200000000UL)
-#define LCA_DENSE_MEM		(IDENT_ADDR + 0x300000000UL)
-
-/*
- * Bit definitions for I/O Controller status register 0:
- */
-#define LCA_IOC_STAT0_CMD		0xf
-#define LCA_IOC_STAT0_ERR		(1<<4)
-#define LCA_IOC_STAT0_LOST		(1<<5)
-#define LCA_IOC_STAT0_THIT		(1<<6)
-#define LCA_IOC_STAT0_TREF		(1<<7)
-#define LCA_IOC_STAT0_CODE_SHIFT	8
-#define LCA_IOC_STAT0_CODE_MASK		0x7
-#define LCA_IOC_STAT0_P_NBR_SHIFT	13
-#define LCA_IOC_STAT0_P_NBR_MASK	0x7ffff
-
-#define LCA_HAE_ADDRESS		LCA_IOC_HAE
-
-/* LCA PMR Power Management register defines */
-#define LCA_PMR_ADDR	(IDENT_ADDR + 0x120000098UL)
-#define LCA_PMR_PDIV    0x7                     /* Primary clock divisor */
-#define LCA_PMR_ODIV    0x38                    /* Override clock divisor */
-#define LCA_PMR_INTO    0x40                    /* Interrupt override */
-#define LCA_PMR_DMAO    0x80                    /* DMA override */
-#define LCA_PMR_OCCEB   0xffff0000L             /* Override cycle counter - even bits */
-#define LCA_PMR_OCCOB   0xffff000000000000L     /* Override cycle counter - even bits */
-#define LCA_PMR_PRIMARY_MASK    0xfffffffffffffff8L
-
-/* LCA PMR Macros */
-
-#define LCA_READ_PMR        (*(volatile unsigned long *)LCA_PMR_ADDR)
-#define LCA_WRITE_PMR(d)    (*((volatile unsigned long *)LCA_PMR_ADDR) = (d))
-
-#define LCA_GET_PRIMARY(r)  ((r) & LCA_PMR_PDIV)
-#define LCA_GET_OVERRIDE(r) (((r) >> 3) & LCA_PMR_PDIV)
-#define LCA_SET_PRIMARY_CLOCK(r, c) ((r) = (((r) & LCA_PMR_PRIMARY_MASK)|(c)))
-
-/* LCA PMR Divisor values */
-#define LCA_PMR_DIV_1   0x0
-#define LCA_PMR_DIV_1_5 0x1
-#define LCA_PMR_DIV_2   0x2
-#define LCA_PMR_DIV_4   0x3
-#define LCA_PMR_DIV_8   0x4
-#define LCA_PMR_DIV_16  0x5
-#define LCA_PMR_DIV_MIN DIV_1
-#define LCA_PMR_DIV_MAX DIV_16
-
-
-/*
- * Data structure for handling LCA machine checks.  Correctable errors
- * result in a short logout frame, uncorrectable ones in a long one.
- */
-struct el_lca_mcheck_short {
-	struct el_common	h;		/* common logout header */
-	unsigned long		esr;		/* error-status register */
-	unsigned long		ear;		/* error-address register */
-	unsigned long		dc_stat;	/* dcache status register */
-	unsigned long		ioc_stat0;	/* I/O controller status register 0 */
-	unsigned long		ioc_stat1;	/* I/O controller status register 1 */
-};
-
-struct el_lca_mcheck_long {
-	struct el_common	h;		/* common logout header */
-	unsigned long		pt[31];		/* PAL temps */
-	unsigned long		exc_addr;	/* exception address */
-	unsigned long		pad1[3];
-	unsigned long		pal_base;	/* PALcode base address */
-	unsigned long		hier;		/* hw interrupt enable */
-	unsigned long		hirr;		/* hw interrupt request */
-	unsigned long		mm_csr;		/* MMU control & status */
-	unsigned long		dc_stat;	/* data cache status */
-	unsigned long		dc_addr;	/* data cache addr register */
-	unsigned long		abox_ctl;	/* address box control register */
-	unsigned long		esr;		/* error status register */
-	unsigned long		ear;		/* error address register */
-	unsigned long		car;		/* cache control register */
-	unsigned long		ioc_stat0;	/* I/O controller status register 0 */
-	unsigned long		ioc_stat1;	/* I/O controller status register 1 */
-	unsigned long		va;		/* virtual address register */
-};
-
-union el_lca {
-	struct el_common *		c;
-	struct el_lca_mcheck_long *	l;
-	struct el_lca_mcheck_short *	s;
-};
-
-#ifdef __KERNEL__
-
-#ifndef __EXTERN_INLINE
-#define __EXTERN_INLINE extern inline
-#define __IO_EXTERN_INLINE
-#endif
-
-/*
- * I/O functions:
- *
- * Unlike Jensen, the Noname machines have no concept of local
- * I/O---everything goes over the PCI bus.
- *
- * There is plenty room for optimization here.  In particular,
- * the Alpha's insb/insw/extb/extw should be useful in moving
- * data to/from the right byte-lanes.
- */
-
-#define vip	volatile int __force *
-#define vuip	volatile unsigned int __force *
-#define vulp	volatile unsigned long __force *
-
-#define LCA_SET_HAE						\
-	do {							\
-		if (addr >= (1UL << 24)) {			\
-			unsigned long msb = addr & 0xf8000000;	\
-			addr -= msb;				\
-			set_hae(msb);				\
-		}						\
-	} while (0)
-
-
-__EXTERN_INLINE u8 lca_ioread8(const void __iomem *xaddr)
-{
-	unsigned long addr = (unsigned long) xaddr;
-	unsigned long result, base_and_type;
-
-	if (addr >= LCA_DENSE_MEM) {
-		addr -= LCA_DENSE_MEM;
-		LCA_SET_HAE;
-		base_and_type = LCA_SPARSE_MEM + 0x00;
-	} else {
-		addr -= LCA_IO;
-		base_and_type = LCA_IO + 0x00;
-	}
-
-	result = *(vip) ((addr << 5) + base_and_type);
-	return __kernel_extbl(result, addr & 3);
-}
-
-__EXTERN_INLINE void lca_iowrite8(u8 b, void __iomem *xaddr)
-{
-	unsigned long addr = (unsigned long) xaddr;
-	unsigned long w, base_and_type;
-
-	if (addr >= LCA_DENSE_MEM) {
-		addr -= LCA_DENSE_MEM;
-		LCA_SET_HAE;
-		base_and_type = LCA_SPARSE_MEM + 0x00;
-	} else {
-		addr -= LCA_IO;
-		base_and_type = LCA_IO + 0x00;
-	}
-
-	w = __kernel_insbl(b, addr & 3);
-	*(vuip) ((addr << 5) + base_and_type) = w;
-}
-
-__EXTERN_INLINE u16 lca_ioread16(const void __iomem *xaddr)
-{
-	unsigned long addr = (unsigned long) xaddr;
-	unsigned long result, base_and_type;
-
-	if (addr >= LCA_DENSE_MEM) {
-		addr -= LCA_DENSE_MEM;
-		LCA_SET_HAE;
-		base_and_type = LCA_SPARSE_MEM + 0x08;
-	} else {
-		addr -= LCA_IO;
-		base_and_type = LCA_IO + 0x08;
-	}
-
-	result = *(vip) ((addr << 5) + base_and_type);
-	return __kernel_extwl(result, addr & 3);
-}
-
-__EXTERN_INLINE void lca_iowrite16(u16 b, void __iomem *xaddr)
-{
-	unsigned long addr = (unsigned long) xaddr;
-	unsigned long w, base_and_type;
-
-	if (addr >= LCA_DENSE_MEM) {
-		addr -= LCA_DENSE_MEM;
-		LCA_SET_HAE;
-		base_and_type = LCA_SPARSE_MEM + 0x08;
-	} else {
-		addr -= LCA_IO;
-		base_and_type = LCA_IO + 0x08;
-	}
-
-	w = __kernel_inswl(b, addr & 3);
-	*(vuip) ((addr << 5) + base_and_type) = w;
-}
-
-__EXTERN_INLINE u32 lca_ioread32(const void __iomem *xaddr)
-{
-	unsigned long addr = (unsigned long) xaddr;
-	if (addr < LCA_DENSE_MEM)
-		addr = ((addr - LCA_IO) << 5) + LCA_IO + 0x18;
-	return *(vuip)addr;
-}
-
-__EXTERN_INLINE void lca_iowrite32(u32 b, void __iomem *xaddr)
-{
-	unsigned long addr = (unsigned long) xaddr;
-	if (addr < LCA_DENSE_MEM)
-		addr = ((addr - LCA_IO) << 5) + LCA_IO + 0x18;
-	*(vuip)addr = b;
-}
-
-__EXTERN_INLINE u64 lca_ioread64(const void __iomem *xaddr)
-{
-	unsigned long addr = (unsigned long) xaddr;
-	if (addr < LCA_DENSE_MEM)
-		addr = ((addr - LCA_IO) << 5) + LCA_IO + 0x18;
-	return *(vulp)addr;
-}
-
-__EXTERN_INLINE void lca_iowrite64(u64 b, void __iomem *xaddr)
-{
-	unsigned long addr = (unsigned long) xaddr;
-	if (addr < LCA_DENSE_MEM)
-		addr = ((addr - LCA_IO) << 5) + LCA_IO + 0x18;
-	*(vulp)addr = b;
-}
-
-__EXTERN_INLINE void __iomem *lca_ioportmap(unsigned long addr)
-{
-	return (void __iomem *)(addr + LCA_IO);
-}
-
-__EXTERN_INLINE void __iomem *lca_ioremap(unsigned long addr,
-					  unsigned long size)
-{
-	return (void __iomem *)(addr + LCA_DENSE_MEM);
-}
-
-__EXTERN_INLINE int lca_is_ioaddr(unsigned long addr)
-{
-	return addr >= IDENT_ADDR + 0x120000000UL;
-}
-
-__EXTERN_INLINE int lca_is_mmio(const volatile void __iomem *addr)
-{
-	return (unsigned long)addr >= LCA_DENSE_MEM;
-}
-
-#undef vip
-#undef vuip
-#undef vulp
-
-#undef __IO_PREFIX
-#define __IO_PREFIX		lca
-#define lca_trivial_rw_bw	2
-#define lca_trivial_rw_lq	1
-#define lca_trivial_io_bw	0
-#define lca_trivial_io_lq	0
-#define lca_trivial_iounmap	1
-#include <asm/io_trivial.h>
-
-#ifdef __IO_EXTERN_INLINE
-#undef __EXTERN_INLINE
-#undef __IO_EXTERN_INLINE
-#endif
-
-#endif /* __KERNEL__ */
-
-#endif /* __ALPHA_LCA__H__ */
diff --git a/arch/alpha/include/asm/dma.h b/arch/alpha/include/asm/dma.h
index a04d76b96089..3a88812b7165 100644
--- a/arch/alpha/include/asm/dma.h
+++ b/arch/alpha/include/asm/dma.h
@@ -82,11 +82,6 @@
   just a wiring limit.
 */
 
-/* The maximum address for ISA DMA transfer on Alpha XL, due to an
-   hardware SIO limitation, is 64MB.
-*/
-#define ALPHA_XL_MAX_ISA_DMA_ADDRESS		0x04000000UL
-
 /* The maximum address for ISA DMA transfer on RUFFIAN,
    due to an hardware SIO limitation, is 16MB.
 */
@@ -107,9 +102,7 @@
 #ifdef CONFIG_ALPHA_GENERIC
 # define MAX_ISA_DMA_ADDRESS		(alpha_mv.max_isa_dma_address)
 #else
-# if defined(CONFIG_ALPHA_XL)
-#  define MAX_ISA_DMA_ADDRESS		ALPHA_XL_MAX_ISA_DMA_ADDRESS
-# elif defined(CONFIG_ALPHA_RUFFIAN)
+# if defined(CONFIG_ALPHA_RUFFIAN)
 #  define MAX_ISA_DMA_ADDRESS		ALPHA_RUFFIAN_MAX_ISA_DMA_ADDRESS
 # elif defined(CONFIG_ALPHA_SABLE)
 #  define MAX_ISA_DMA_ADDRESS		ALPHA_SABLE_MAX_ISA_DMA_ADDRESS
diff --git a/arch/alpha/include/asm/io.h b/arch/alpha/include/asm/io.h
index 0c54ddb5b33e..2bb8cbeedf91 100644
--- a/arch/alpha/include/asm/io.h
+++ b/arch/alpha/include/asm/io.h
@@ -203,14 +203,10 @@ static inline int generic_is_mmio(const volatile void __iomem *a)
 
 #else
 
-#if defined(CONFIG_ALPHA_APECS)
-# include <asm/core_apecs.h>
-#elif defined(CONFIG_ALPHA_CIA)
+#if defined(CONFIG_ALPHA_CIA)
 # include <asm/core_cia.h>
 #elif defined(CONFIG_ALPHA_IRONGATE)
 # include <asm/core_irongate.h>
-#elif defined(CONFIG_ALPHA_LCA)
-# include <asm/core_lca.h>
 #elif defined(CONFIG_ALPHA_MARVEL)
 # include <asm/core_marvel.h>
 #elif defined(CONFIG_ALPHA_MCPCIA)
diff --git a/arch/alpha/include/asm/irq.h b/arch/alpha/include/asm/irq.h
index 442097c56934..e7d22357a5a6 100644
--- a/arch/alpha/include/asm/irq.h
+++ b/arch/alpha/include/asm/irq.h
@@ -31,16 +31,12 @@
 #  define NR_IRQS      (32768 + 16)    /* marvel - 32 pids */
 # endif
 
-#elif defined(CONFIG_ALPHA_CABRIOLET) || \
-      defined(CONFIG_ALPHA_EB66P)     || \
-      defined(CONFIG_ALPHA_EB164)     || \
+#elif defined(CONFIG_ALPHA_EB164)     || \
       defined(CONFIG_ALPHA_PC164)     || \
       defined(CONFIG_ALPHA_LX164)
 # define NR_IRQS	35
 
-#elif defined(CONFIG_ALPHA_EB66)      || \
-      defined(CONFIG_ALPHA_EB64P)     || \
-      defined(CONFIG_ALPHA_MIKASA)
+#elif defined(CONFIG_ALPHA_MIKASA)
 # define NR_IRQS	32
 
 #elif defined(CONFIG_ALPHA_ALCOR)     || \
diff --git a/arch/alpha/kernel/Makefile b/arch/alpha/kernel/Makefile
index 706ce8625e35..bd5d62fa4a9a 100644
--- a/arch/alpha/kernel/Makefile
+++ b/arch/alpha/kernel/Makefile
@@ -22,14 +22,14 @@ obj-$(CONFIG_AUDIT)	+= audit.o
 
 ifdef CONFIG_ALPHA_GENERIC
 
-obj-y 	 += core_apecs.o core_cia.o core_irongate.o core_lca.o \
+obj-y 	 += core_cia.o core_irongate.o \
 	    core_mcpcia.o core_polaris.o core_t2.o \
 	    core_tsunami.o
 
-obj-y	 += sys_alcor.o sys_cabriolet.o sys_dp264.o sys_eb64p.o sys_eiger.o \
+obj-y	 += sys_alcor.o sys_cabriolet.o sys_dp264.o sys_eiger.o \
 	    sys_miata.o sys_mikasa.o sys_nautilus.o \
 	    sys_noritake.o sys_rawhide.o sys_ruffian.o sys_rx164.o \
-	    sys_sable.o sys_sio.o sys_sx164.o sys_takara.o
+	    sys_sable.o sys_sx164.o sys_takara.o
 
 ifndef CONFIG_ALPHA_LEGACY_START_ADDRESS
 obj-y	 += core_marvel.o core_titan.o core_wildfire.o
@@ -48,10 +48,8 @@ else
 obj-$(CONFIG_ALPHA_SRM)		+= srmcons.o
 
 # Core logic support
-obj-$(CONFIG_ALPHA_APECS)	+= core_apecs.o
 obj-$(CONFIG_ALPHA_CIA)		+= core_cia.o
 obj-$(CONFIG_ALPHA_IRONGATE)	+= core_irongate.o
-obj-$(CONFIG_ALPHA_LCA)		+= core_lca.o
 obj-$(CONFIG_ALPHA_MARVEL)	+= core_marvel.o gct.o
 obj-$(CONFIG_ALPHA_MCPCIA)	+= core_mcpcia.o
 obj-$(CONFIG_ALPHA_POLARIS)	+= core_polaris.o
@@ -62,12 +60,8 @@ obj-$(CONFIG_ALPHA_WILDFIRE)	+= core_wildfire.o
 
 # Board support
 obj-$(CONFIG_ALPHA_ALCOR)	+= sys_alcor.o irq_i8259.o irq_srm.o
-obj-$(CONFIG_ALPHA_CABRIOLET)	+= sys_cabriolet.o irq_i8259.o irq_srm.o \
-				   pc873xx.o
 obj-$(CONFIG_ALPHA_EB164)	+= sys_cabriolet.o irq_i8259.o irq_srm.o \
 				   pc873xx.o
-obj-$(CONFIG_ALPHA_EB66P)	+= sys_cabriolet.o irq_i8259.o irq_srm.o \
-				   pc873xx.o
 obj-$(CONFIG_ALPHA_LX164)	+= sys_cabriolet.o irq_i8259.o irq_srm.o \
 				   smc37c93x.o
 obj-$(CONFIG_ALPHA_PC164)	+= sys_cabriolet.o irq_i8259.o irq_srm.o \
@@ -75,8 +69,6 @@ obj-$(CONFIG_ALPHA_PC164)	+= sys_cabriolet.o irq_i8259.o irq_srm.o \
 obj-$(CONFIG_ALPHA_DP264)	+= sys_dp264.o irq_i8259.o es1888.o smc37c669.o
 obj-$(CONFIG_ALPHA_SHARK)	+= sys_dp264.o irq_i8259.o es1888.o smc37c669.o
 obj-$(CONFIG_ALPHA_TITAN)	+= sys_titan.o irq_i8259.o smc37c669.o
-obj-$(CONFIG_ALPHA_EB64P)	+= sys_eb64p.o irq_i8259.o
-obj-$(CONFIG_ALPHA_EB66)	+= sys_eb64p.o irq_i8259.o
 obj-$(CONFIG_ALPHA_EIGER)	+= sys_eiger.o irq_i8259.o
 obj-$(CONFIG_ALPHA_MARVEL)	+= sys_marvel.o 
 obj-$(CONFIG_ALPHA_MIATA)	+= sys_miata.o irq_pyxis.o irq_i8259.o \
@@ -88,11 +80,6 @@ obj-$(CONFIG_ALPHA_RAWHIDE)	+= sys_rawhide.o irq_i8259.o
 obj-$(CONFIG_ALPHA_RUFFIAN)	+= sys_ruffian.o irq_pyxis.o irq_i8259.o
 obj-$(CONFIG_ALPHA_RX164)	+= sys_rx164.o irq_i8259.o
 obj-$(CONFIG_ALPHA_SABLE)	+= sys_sable.o
-obj-$(CONFIG_ALPHA_BOOK1)	+= sys_sio.o irq_i8259.o irq_srm.o pc873xx.o
-obj-$(CONFIG_ALPHA_AVANTI)	+= sys_sio.o irq_i8259.o irq_srm.o pc873xx.o
-obj-$(CONFIG_ALPHA_NONAME)	+= sys_sio.o irq_i8259.o irq_srm.o pc873xx.o
-obj-$(CONFIG_ALPHA_P2K)		+= sys_sio.o irq_i8259.o irq_srm.o pc873xx.o
-obj-$(CONFIG_ALPHA_XL)		+= sys_sio.o irq_i8259.o irq_srm.o pc873xx.o
 obj-$(CONFIG_ALPHA_SX164)	+= sys_sx164.o irq_pyxis.o irq_i8259.o \
 				   irq_srm.o smc37c669.o
 obj-$(CONFIG_ALPHA_TAKARA)	+= sys_takara.o irq_i8259.o pc873xx.o
diff --git a/arch/alpha/kernel/core_apecs.c b/arch/alpha/kernel/core_apecs.c
deleted file mode 100644
index 6df765ff2b10..000000000000
--- a/arch/alpha/kernel/core_apecs.c
+++ /dev/null
@@ -1,420 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *	linux/arch/alpha/kernel/core_apecs.c
- *
- * Rewritten for Apecs from the lca.c from:
- *
- * Written by David Mosberger (davidm@cs.arizona.edu) with some code
- * taken from Dave Rusling's (david.rusling@reo.mts.dec.com) 32-bit
- * bios code.
- *
- * Code common to all APECS core logic chips.
- */
-
-#define __EXTERN_INLINE inline
-#include <asm/io.h>
-#include <asm/core_apecs.h>
-#undef __EXTERN_INLINE
-
-#include <linux/types.h>
-#include <linux/pci.h>
-#include <linux/init.h>
-
-#include <asm/ptrace.h>
-#include <asm/smp.h>
-#include <asm/mce.h>
-
-#include "proto.h"
-#include "pci_impl.h"
-
-/*
- * NOTE: Herein lie back-to-back mb instructions.  They are magic. 
- * One plausible explanation is that the i/o controller does not properly
- * handle the system transaction.  Another involves timing.  Ho hum.
- */
-
-/*
- * BIOS32-style PCI interface:
- */
-
-#define DEBUG_CONFIG 0
-
-#if DEBUG_CONFIG
-# define DBGC(args)	printk args
-#else
-# define DBGC(args)
-#endif
-
-#define vuip	volatile unsigned int  *
-
-/*
- * Given a bus, device, and function number, compute resulting
- * configuration space address and setup the APECS_HAXR2 register
- * accordingly.  It is therefore not safe to have concurrent
- * invocations to configuration space access routines, but there
- * really shouldn't be any need for this.
- *
- * Type 0:
- *
- *  3 3|3 3 2 2|2 2 2 2|2 2 2 2|1 1 1 1|1 1 1 1|1 1 
- *  3 2|1 0 9 8|7 6 5 4|3 2 1 0|9 8 7 6|5 4 3 2|1 0 9 8|7 6 5 4|3 2 1 0
- * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
- * | | | | | | | | | | | | | | | | | | | | | | | |F|F|F|R|R|R|R|R|R|0|0|
- * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
- *
- *	31:11	Device select bit.
- * 	10:8	Function number
- * 	 7:2	Register number
- *
- * Type 1:
- *
- *  3 3|3 3 2 2|2 2 2 2|2 2 2 2|1 1 1 1|1 1 1 1|1 1 
- *  3 2|1 0 9 8|7 6 5 4|3 2 1 0|9 8 7 6|5 4 3 2|1 0 9 8|7 6 5 4|3 2 1 0
- * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
- * | | | | | | | | | | |B|B|B|B|B|B|B|B|D|D|D|D|D|F|F|F|R|R|R|R|R|R|0|1|
- * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
- *
- *	31:24	reserved
- *	23:16	bus number (8 bits = 128 possible buses)
- *	15:11	Device number (5 bits)
- *	10:8	function number
- *	 7:2	register number
- *  
- * Notes:
- *	The function number selects which function of a multi-function device 
- *	(e.g., SCSI and Ethernet).
- * 
- *	The register selects a DWORD (32 bit) register offset.  Hence it
- *	doesn't get shifted by 2 bits as we want to "drop" the bottom two
- *	bits.
- */
-
-static int
-mk_conf_addr(struct pci_bus *pbus, unsigned int device_fn, int where,
-	     unsigned long *pci_addr, unsigned char *type1)
-{
-	unsigned long addr;
-	u8 bus = pbus->number;
-
-	DBGC(("mk_conf_addr(bus=%d ,device_fn=0x%x, where=0x%x,"
-	      " pci_addr=0x%p, type1=0x%p)\n",
-	      bus, device_fn, where, pci_addr, type1));
-
-	if (bus == 0) {
-		int device = device_fn >> 3;
-
-		/* type 0 configuration cycle: */
-
-		if (device > 20) {
-			DBGC(("mk_conf_addr: device (%d) > 20, returning -1\n",
-			      device));
-			return -1;
-		}
-
-		*type1 = 0;
-		addr = (device_fn << 8) | (where);
-	} else {
-		/* type 1 configuration cycle: */
-		*type1 = 1;
-		addr = (bus << 16) | (device_fn << 8) | (where);
-	}
-	*pci_addr = addr;
-	DBGC(("mk_conf_addr: returning pci_addr 0x%lx\n", addr));
-	return 0;
-}
-
-static unsigned int
-conf_read(unsigned long addr, unsigned char type1)
-{
-	unsigned long flags;
-	unsigned int stat0, value;
-	unsigned int haxr2 = 0;
-
-	local_irq_save(flags);	/* avoid getting hit by machine check */
-
-	DBGC(("conf_read(addr=0x%lx, type1=%d)\n", addr, type1));
-
-	/* Reset status register to avoid losing errors.  */
-	stat0 = *(vuip)APECS_IOC_DCSR;
-	*(vuip)APECS_IOC_DCSR = stat0;
-	mb();
-	DBGC(("conf_read: APECS DCSR was 0x%x\n", stat0));
-
-	/* If Type1 access, must set HAE #2. */
-	if (type1) {
-		haxr2 = *(vuip)APECS_IOC_HAXR2;
-		mb();
-		*(vuip)APECS_IOC_HAXR2 = haxr2 | 1;
-		DBGC(("conf_read: TYPE1 access\n"));
-	}
-
-	draina();
-	mcheck_expected(0) = 1;
-	mcheck_taken(0) = 0;
-	mb();
-
-	/* Access configuration space.  */
-
-	/* Some SRMs step on these registers during a machine check.  */
-	asm volatile("ldl %0,%1; mb; mb" : "=r"(value) : "m"(*(vuip)addr)
-		     : "$9", "$10", "$11", "$12", "$13", "$14", "memory");
-
-	if (mcheck_taken(0)) {
-		mcheck_taken(0) = 0;
-		value = 0xffffffffU;
-		mb();
-	}
-	mcheck_expected(0) = 0;
-	mb();
-
-#if 1
-	/*
-	 * david.rusling@reo.mts.dec.com.  This code is needed for the
-	 * EB64+ as it does not generate a machine check (why I don't
-	 * know).  When we build kernels for one particular platform
-	 * then we can make this conditional on the type.
-	 */
-	draina();
-
-	/* Now look for any errors.  */
-	stat0 = *(vuip)APECS_IOC_DCSR;
-	DBGC(("conf_read: APECS DCSR after read 0x%x\n", stat0));
-
-	/* Is any error bit set? */
-	if (stat0 & 0xffe0U) {
-		/* If not NDEV, print status.  */
-		if (!(stat0 & 0x0800)) {
-			printk("apecs.c:conf_read: got stat0=%x\n", stat0);
-		}
-
-		/* Reset error status.  */
-		*(vuip)APECS_IOC_DCSR = stat0;
-		mb();
-		wrmces(0x7);			/* reset machine check */
-		value = 0xffffffff;
-	}
-#endif
-
-	/* If Type1 access, must reset HAE #2 so normal IO space ops work.  */
-	if (type1) {
-		*(vuip)APECS_IOC_HAXR2 = haxr2 & ~1;
-		mb();
-	}
-	local_irq_restore(flags);
-
-	return value;
-}
-
-static void
-conf_write(unsigned long addr, unsigned int value, unsigned char type1)
-{
-	unsigned long flags;
-	unsigned int stat0;
-	unsigned int haxr2 = 0;
-
-	local_irq_save(flags);	/* avoid getting hit by machine check */
-
-	/* Reset status register to avoid losing errors.  */
-	stat0 = *(vuip)APECS_IOC_DCSR;
-	*(vuip)APECS_IOC_DCSR = stat0;
-	mb();
-
-	/* If Type1 access, must set HAE #2. */
-	if (type1) {
-		haxr2 = *(vuip)APECS_IOC_HAXR2;
-		mb();
-		*(vuip)APECS_IOC_HAXR2 = haxr2 | 1;
-	}
-
-	draina();
-	mcheck_expected(0) = 1;
-	mb();
-
-	/* Access configuration space.  */
-	*(vuip)addr = value;
-	mb();
-	mb();  /* magic */
-	mcheck_expected(0) = 0;
-	mb();
-
-#if 1
-	/*
-	 * david.rusling@reo.mts.dec.com.  This code is needed for the
-	 * EB64+ as it does not generate a machine check (why I don't
-	 * know).  When we build kernels for one particular platform
-	 * then we can make this conditional on the type.
-	 */
-	draina();
-
-	/* Now look for any errors.  */
-	stat0 = *(vuip)APECS_IOC_DCSR;
-
-	/* Is any error bit set? */
-	if (stat0 & 0xffe0U) {
-		/* If not NDEV, print status.  */
-		if (!(stat0 & 0x0800)) {
-			printk("apecs.c:conf_write: got stat0=%x\n", stat0);
-		}
-
-		/* Reset error status.  */
-		*(vuip)APECS_IOC_DCSR = stat0;
-		mb();
-		wrmces(0x7);			/* reset machine check */
-	}
-#endif
-
-	/* If Type1 access, must reset HAE #2 so normal IO space ops work.  */
-	if (type1) {
-		*(vuip)APECS_IOC_HAXR2 = haxr2 & ~1;
-		mb();
-	}
-	local_irq_restore(flags);
-}
-
-static int
-apecs_read_config(struct pci_bus *bus, unsigned int devfn, int where,
-		  int size, u32 *value)
-{
-	unsigned long addr, pci_addr;
-	unsigned char type1;
-	long mask;
-	int shift;
-
-	if (mk_conf_addr(bus, devfn, where, &pci_addr, &type1))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	mask = (size - 1) * 8;
-	shift = (where & 3) * 8;
-	addr = (pci_addr << 5) + mask + APECS_CONF;
-	*value = conf_read(addr, type1) >> (shift);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int
-apecs_write_config(struct pci_bus *bus, unsigned int devfn, int where,
-		   int size, u32 value)
-{
-	unsigned long addr, pci_addr;
-	unsigned char type1;
-	long mask;
-
-	if (mk_conf_addr(bus, devfn, where, &pci_addr, &type1))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	mask = (size - 1) * 8;
-	addr = (pci_addr << 5) + mask + APECS_CONF;
-	conf_write(addr, value << ((where & 3) * 8), type1);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-struct pci_ops apecs_pci_ops = 
-{
-	.read =		apecs_read_config,
-	.write =	apecs_write_config,
-};
-
-void
-apecs_pci_tbi(struct pci_controller *hose, dma_addr_t start, dma_addr_t end)
-{
-	wmb();
-	*(vip)APECS_IOC_TBIA = 0;
-	mb();
-}
-
-void __init
-apecs_init_arch(void)
-{
-	struct pci_controller *hose;
-
-	/*
-	 * Create our single hose.
-	 */
-
-	pci_isa_hose = hose = alloc_pci_controller();
-	hose->io_space = &ioport_resource;
-	hose->mem_space = &iomem_resource;
-	hose->index = 0;
-
-	hose->sparse_mem_base = APECS_SPARSE_MEM - IDENT_ADDR;
-	hose->dense_mem_base = APECS_DENSE_MEM - IDENT_ADDR;
-	hose->sparse_io_base = APECS_IO - IDENT_ADDR;
-	hose->dense_io_base = 0;
-
-	/*
-	 * Set up the PCI to main memory translation windows.
-	 *
-	 * Window 1 is direct access 1GB at 1GB
-	 * Window 2 is scatter-gather 8MB at 8MB (for isa)
-	 */
-	hose->sg_isa = iommu_arena_new(hose, 0x00800000, 0x00800000,
-				       SMP_CACHE_BYTES);
-	hose->sg_pci = NULL;
-	__direct_map_base = 0x40000000;
-	__direct_map_size = 0x40000000;
-
-	*(vuip)APECS_IOC_PB1R = __direct_map_base | 0x00080000;
-	*(vuip)APECS_IOC_PM1R = (__direct_map_size - 1) & 0xfff00000U;
-	*(vuip)APECS_IOC_TB1R = 0;
-
-	*(vuip)APECS_IOC_PB2R = hose->sg_isa->dma_base | 0x000c0000;
-	*(vuip)APECS_IOC_PM2R = (hose->sg_isa->size - 1) & 0xfff00000;
-	*(vuip)APECS_IOC_TB2R = virt_to_phys(hose->sg_isa->ptes) >> 1;
-
-	apecs_pci_tbi(hose, 0, -1);
-
-	/*
-	 * Finally, clear the HAXR2 register, which gets used
-	 * for PCI Config Space accesses. That is the way
-	 * we want to use it, and we do not want to depend on
-	 * what ARC or SRM might have left behind...
-	 */
-	*(vuip)APECS_IOC_HAXR2 = 0;
-	mb();
-}
-
-void
-apecs_pci_clr_err(void)
-{
-	unsigned int jd;
-
-	jd = *(vuip)APECS_IOC_DCSR;
-	if (jd & 0xffe0L) {
-		*(vuip)APECS_IOC_SEAR;
-		*(vuip)APECS_IOC_DCSR = jd | 0xffe1L;
-		mb();
-		*(vuip)APECS_IOC_DCSR;
-	}
-	*(vuip)APECS_IOC_TBIA = (unsigned int)APECS_IOC_TBIA;
-	mb();
-	*(vuip)APECS_IOC_TBIA;
-}
-
-void
-apecs_machine_check(unsigned long vector, unsigned long la_ptr)
-{
-	struct el_common *mchk_header;
-	struct el_apecs_procdata *mchk_procdata;
-	struct el_apecs_sysdata_mcheck *mchk_sysdata;
-
-	mchk_header = (struct el_common *)la_ptr;
-
-	mchk_procdata = (struct el_apecs_procdata *)
-		(la_ptr + mchk_header->proc_offset
-		 - sizeof(mchk_procdata->paltemp));
-
-	mchk_sysdata = (struct el_apecs_sysdata_mcheck *)
-		(la_ptr + mchk_header->sys_offset);
-
-
-	/* Clear the error before any reporting.  */
-	mb();
-	mb(); /* magic */
-	draina();
-	apecs_pci_clr_err();
-	wrmces(0x7);		/* reset machine check pending flag */
-	mb();
-
-	process_mcheck_info(vector, la_ptr, "APECS",
-			    (mcheck_expected(0)
-			     && (mchk_sysdata->epic_dcsr & 0x0c00UL)));
-}
diff --git a/arch/alpha/kernel/core_lca.c b/arch/alpha/kernel/core_lca.c
deleted file mode 100644
index 4616b11643d5..000000000000
--- a/arch/alpha/kernel/core_lca.c
+++ /dev/null
@@ -1,473 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *	linux/arch/alpha/kernel/core_lca.c
- *
- * Written by David Mosberger (davidm@cs.arizona.edu) with some code
- * taken from Dave Rusling's (david.rusling@reo.mts.dec.com) 32-bit
- * bios code.
- *
- * Code common to all LCA core logic chips.
- */
-
-#define __EXTERN_INLINE inline
-#include <asm/io.h>
-#include <asm/core_lca.h>
-#undef __EXTERN_INLINE
-
-#include <linux/types.h>
-#include <linux/pci.h>
-#include <linux/init.h>
-#include <linux/tty.h>
-
-#include <asm/ptrace.h>
-#include <asm/irq_regs.h>
-#include <asm/smp.h>
-
-#include "proto.h"
-#include "pci_impl.h"
-
-
-/*
- * BIOS32-style PCI interface:
- */
-
-/*
- * Machine check reasons.  Defined according to PALcode sources
- * (osf.h and platform.h).
- */
-#define MCHK_K_TPERR		0x0080
-#define MCHK_K_TCPERR		0x0082
-#define MCHK_K_HERR		0x0084
-#define MCHK_K_ECC_C		0x0086
-#define MCHK_K_ECC_NC		0x0088
-#define MCHK_K_UNKNOWN		0x008A
-#define MCHK_K_CACKSOFT		0x008C
-#define MCHK_K_BUGCHECK		0x008E
-#define MCHK_K_OS_BUGCHECK	0x0090
-#define MCHK_K_DCPERR		0x0092
-#define MCHK_K_ICPERR		0x0094
-
-
-/*
- * Platform-specific machine-check reasons:
- */
-#define MCHK_K_SIO_SERR		0x204	/* all platforms so far */
-#define MCHK_K_SIO_IOCHK	0x206	/* all platforms so far */
-#define MCHK_K_DCSR		0x208	/* all but Noname */
-
-
-/*
- * Given a bus, device, and function number, compute resulting
- * configuration space address and setup the LCA_IOC_CONF register
- * accordingly.  It is therefore not safe to have concurrent
- * invocations to configuration space access routines, but there
- * really shouldn't be any need for this.
- *
- * Type 0:
- *
- *  3 3|3 3 2 2|2 2 2 2|2 2 2 2|1 1 1 1|1 1 1 1|1 1 
- *  3 2|1 0 9 8|7 6 5 4|3 2 1 0|9 8 7 6|5 4 3 2|1 0 9 8|7 6 5 4|3 2 1 0
- * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
- * | | | | | | | | | | | | | | | | | | | | | | | |F|F|F|R|R|R|R|R|R|0|0|
- * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
- *
- *	31:11	Device select bit.
- * 	10:8	Function number
- * 	 7:2	Register number
- *
- * Type 1:
- *
- *  3 3|3 3 2 2|2 2 2 2|2 2 2 2|1 1 1 1|1 1 1 1|1 1 
- *  3 2|1 0 9 8|7 6 5 4|3 2 1 0|9 8 7 6|5 4 3 2|1 0 9 8|7 6 5 4|3 2 1 0
- * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
- * | | | | | | | | | | |B|B|B|B|B|B|B|B|D|D|D|D|D|F|F|F|R|R|R|R|R|R|0|1|
- * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
- *
- *	31:24	reserved
- *	23:16	bus number (8 bits = 128 possible buses)
- *	15:11	Device number (5 bits)
- *	10:8	function number
- *	 7:2	register number
- *  
- * Notes:
- *	The function number selects which function of a multi-function device 
- *	(e.g., SCSI and Ethernet).
- * 
- *	The register selects a DWORD (32 bit) register offset.  Hence it
- *	doesn't get shifted by 2 bits as we want to "drop" the bottom two
- *	bits.
- */
-
-static int
-mk_conf_addr(struct pci_bus *pbus, unsigned int device_fn, int where,
-	     unsigned long *pci_addr)
-{
-	unsigned long addr;
-	u8 bus = pbus->number;
-
-	if (bus == 0) {
-		int device = device_fn >> 3;
-		int func = device_fn & 0x7;
-
-		/* Type 0 configuration cycle.  */
-
-		if (device > 12) {
-			return -1;
-		}
-
-		*(vulp)LCA_IOC_CONF = 0;
-		addr = (1 << (11 + device)) | (func << 8) | where;
-	} else {
-		/* Type 1 configuration cycle.  */
-		*(vulp)LCA_IOC_CONF = 1;
-		addr = (bus << 16) | (device_fn << 8) | where;
-	}
-	*pci_addr = addr;
-	return 0;
-}
-
-static unsigned int
-conf_read(unsigned long addr)
-{
-	unsigned long flags, code, stat0;
-	unsigned int value;
-
-	local_irq_save(flags);
-
-	/* Reset status register to avoid losing errors.  */
-	stat0 = *(vulp)LCA_IOC_STAT0;
-	*(vulp)LCA_IOC_STAT0 = stat0;
-	mb();
-
-	/* Access configuration space.  */
-	value = *(vuip)addr;
-	draina();
-
-	stat0 = *(vulp)LCA_IOC_STAT0;
-	if (stat0 & LCA_IOC_STAT0_ERR) {
-		code = ((stat0 >> LCA_IOC_STAT0_CODE_SHIFT)
-			& LCA_IOC_STAT0_CODE_MASK);
-		if (code != 1) {
-			printk("lca.c:conf_read: got stat0=%lx\n", stat0);
-		}
-
-		/* Reset error status.  */
-		*(vulp)LCA_IOC_STAT0 = stat0;
-		mb();
-
-		/* Reset machine check.  */
-		wrmces(0x7);
-
-		value = 0xffffffff;
-	}
-	local_irq_restore(flags);
-	return value;
-}
-
-static void
-conf_write(unsigned long addr, unsigned int value)
-{
-	unsigned long flags, code, stat0;
-
-	local_irq_save(flags);	/* avoid getting hit by machine check */
-
-	/* Reset status register to avoid losing errors.  */
-	stat0 = *(vulp)LCA_IOC_STAT0;
-	*(vulp)LCA_IOC_STAT0 = stat0;
-	mb();
-
-	/* Access configuration space.  */
-	*(vuip)addr = value;
-	draina();
-
-	stat0 = *(vulp)LCA_IOC_STAT0;
-	if (stat0 & LCA_IOC_STAT0_ERR) {
-		code = ((stat0 >> LCA_IOC_STAT0_CODE_SHIFT)
-			& LCA_IOC_STAT0_CODE_MASK);
-		if (code != 1) {
-			printk("lca.c:conf_write: got stat0=%lx\n", stat0);
-		}
-
-		/* Reset error status.  */
-		*(vulp)LCA_IOC_STAT0 = stat0;
-		mb();
-
-		/* Reset machine check. */
-		wrmces(0x7);
-	}
-	local_irq_restore(flags);
-}
-
-static int
-lca_read_config(struct pci_bus *bus, unsigned int devfn, int where,
-		int size, u32 *value)
-{
-	unsigned long addr, pci_addr;
-	long mask;
-	int shift;
-
-	if (mk_conf_addr(bus, devfn, where, &pci_addr))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	shift = (where & 3) * 8;
-	mask = (size - 1) * 8;
-	addr = (pci_addr << 5) + mask + LCA_CONF;
-	*value = conf_read(addr) >> (shift);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int 
-lca_write_config(struct pci_bus *bus, unsigned int devfn, int where, int size,
-		 u32 value)
-{
-	unsigned long addr, pci_addr;
-	long mask;
-
-	if (mk_conf_addr(bus, devfn, where, &pci_addr))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	mask = (size - 1) * 8;
-	addr = (pci_addr << 5) + mask + LCA_CONF;
-	conf_write(addr, value << ((where & 3) * 8));
-	return PCIBIOS_SUCCESSFUL;
-}
-
-struct pci_ops lca_pci_ops = 
-{
-	.read =		lca_read_config,
-	.write =	lca_write_config,
-};
-
-void
-lca_pci_tbi(struct pci_controller *hose, dma_addr_t start, dma_addr_t end)
-{
-	wmb();
-	*(vulp)LCA_IOC_TBIA = 0;
-	mb();
-}
-
-void __init
-lca_init_arch(void)
-{
-	struct pci_controller *hose;
-
-	/*
-	 * Create our single hose.
-	 */
-
-	pci_isa_hose = hose = alloc_pci_controller();
-	hose->io_space = &ioport_resource;
-	hose->mem_space = &iomem_resource;
-	hose->index = 0;
-
-	hose->sparse_mem_base = LCA_SPARSE_MEM - IDENT_ADDR;
-	hose->dense_mem_base = LCA_DENSE_MEM - IDENT_ADDR;
-	hose->sparse_io_base = LCA_IO - IDENT_ADDR;
-	hose->dense_io_base = 0;
-
-	/*
-	 * Set up the PCI to main memory translation windows.
-	 *
-	 * Mimic the SRM settings for the direct-map window.
-	 *   Window 0 is scatter-gather 8MB at 8MB (for isa).
-	 *   Window 1 is direct access 1GB at 1GB.
-	 *
-	 * Note that we do not try to save any of the DMA window CSRs
-	 * before setting them, since we cannot read those CSRs on LCA.
-	 */
-	hose->sg_isa = iommu_arena_new(hose, 0x00800000, 0x00800000,
-				       SMP_CACHE_BYTES);
-	hose->sg_pci = NULL;
-	__direct_map_base = 0x40000000;
-	__direct_map_size = 0x40000000;
-
-	*(vulp)LCA_IOC_W_BASE0 = hose->sg_isa->dma_base | (3UL << 32);
-	*(vulp)LCA_IOC_W_MASK0 = (hose->sg_isa->size - 1) & 0xfff00000;
-	*(vulp)LCA_IOC_T_BASE0 = virt_to_phys(hose->sg_isa->ptes);
-
-	*(vulp)LCA_IOC_W_BASE1 = __direct_map_base | (2UL << 32);
-	*(vulp)LCA_IOC_W_MASK1 = (__direct_map_size - 1) & 0xfff00000;
-	*(vulp)LCA_IOC_T_BASE1 = 0;
-
-	*(vulp)LCA_IOC_TB_ENA = 0x80;
-
-	lca_pci_tbi(hose, 0, -1);
-
-	/*
-	 * Disable PCI parity for now.  The NCR53c810 chip has
-	 * troubles meeting the PCI spec which results in
-	 * data parity errors.
-	 */
-	*(vulp)LCA_IOC_PAR_DIS = 1UL<<5;
-
-	/*
-	 * Finally, set up for restoring the correct HAE if using SRM.
-	 * Again, since we cannot read many of the CSRs on the LCA,
-	 * one of which happens to be the HAE, we save the value that
-	 * the SRM will expect...
-	 */
-	if (alpha_using_srm)
-		srm_hae = 0x80000000UL;
-}
-
-/*
- * Constants used during machine-check handling.  I suppose these
- * could be moved into lca.h but I don't see much reason why anybody
- * else would want to use them.
- */
-
-#define ESR_EAV		(1UL<< 0)	/* error address valid */
-#define ESR_CEE		(1UL<< 1)	/* correctable error */
-#define ESR_UEE		(1UL<< 2)	/* uncorrectable error */
-#define ESR_WRE		(1UL<< 3)	/* write-error */
-#define ESR_SOR		(1UL<< 4)	/* error source */
-#define ESR_CTE		(1UL<< 7)	/* cache-tag error */
-#define ESR_MSE		(1UL<< 9)	/* multiple soft errors */
-#define ESR_MHE		(1UL<<10)	/* multiple hard errors */
-#define ESR_NXM		(1UL<<12)	/* non-existent memory */
-
-#define IOC_ERR		(  1<<4)	/* ioc logs an error */
-#define IOC_CMD_SHIFT	0
-#define IOC_CMD		(0xf<<IOC_CMD_SHIFT)
-#define IOC_CODE_SHIFT	8
-#define IOC_CODE	(0xf<<IOC_CODE_SHIFT)
-#define IOC_LOST	(  1<<5)
-#define IOC_P_NBR	((__u32) ~((1<<13) - 1))
-
-static void
-mem_error(unsigned long esr, unsigned long ear)
-{
-	printk("    %s %s error to %s occurred at address %x\n",
-	       ((esr & ESR_CEE) ? "Correctable" :
-		(esr & ESR_UEE) ? "Uncorrectable" : "A"),
-	       (esr & ESR_WRE) ? "write" : "read",
-	       (esr & ESR_SOR) ? "memory" : "b-cache",
-	       (unsigned) (ear & 0x1ffffff8));
-	if (esr & ESR_CTE) {
-		printk("    A b-cache tag parity error was detected.\n");
-	}
-	if (esr & ESR_MSE) {
-		printk("    Several other correctable errors occurred.\n");
-	}
-	if (esr & ESR_MHE) {
-		printk("    Several other uncorrectable errors occurred.\n");
-	}
-	if (esr & ESR_NXM) {
-		printk("    Attempted to access non-existent memory.\n");
-	}
-}
-
-static void
-ioc_error(__u32 stat0, __u32 stat1)
-{
-	static const char * const pci_cmd[] = {
-		"Interrupt Acknowledge", "Special", "I/O Read", "I/O Write",
-		"Rsvd 1", "Rsvd 2", "Memory Read", "Memory Write", "Rsvd3",
-		"Rsvd4", "Configuration Read", "Configuration Write",
-		"Memory Read Multiple", "Dual Address", "Memory Read Line",
-		"Memory Write and Invalidate"
-	};
-	static const char * const err_name[] = {
-		"exceeded retry limit", "no device", "bad data parity",
-		"target abort", "bad address parity", "page table read error",
-		"invalid page", "data error"
-	};
-	unsigned code = (stat0 & IOC_CODE) >> IOC_CODE_SHIFT;
-	unsigned cmd  = (stat0 & IOC_CMD)  >> IOC_CMD_SHIFT;
-
-	printk("    %s initiated PCI %s cycle to address %x"
-	       " failed due to %s.\n",
-	       code > 3 ? "PCI" : "CPU", pci_cmd[cmd], stat1, err_name[code]);
-
-	if (code == 5 || code == 6) {
-		printk("    (Error occurred at PCI memory address %x.)\n",
-		       (stat0 & ~IOC_P_NBR));
-	}
-	if (stat0 & IOC_LOST) {
-		printk("    Other PCI errors occurred simultaneously.\n");
-	}
-}
-
-void
-lca_machine_check(unsigned long vector, unsigned long la_ptr)
-{
-	const char * reason;
-	union el_lca el;
-
-	el.c = (struct el_common *) la_ptr;
-
-	wrmces(rdmces());	/* reset machine check pending flag */
-
-	printk(KERN_CRIT "LCA machine check: vector=%#lx pc=%#lx code=%#x\n",
-	       vector, get_irq_regs()->pc, (unsigned int) el.c->code);
-
-	/*
-	 * The first quadword after the common header always seems to
-	 * be the machine check reason---don't know why this isn't
-	 * part of the common header instead.  In the case of a long
-	 * logout frame, the upper 32 bits is the machine check
-	 * revision level, which we ignore for now.
-	 */
-	switch ((unsigned int) el.c->code) {
-	case MCHK_K_TPERR:	reason = "tag parity error"; break;
-	case MCHK_K_TCPERR:	reason = "tag control parity error"; break;
-	case MCHK_K_HERR:	reason = "access to non-existent memory"; break;
-	case MCHK_K_ECC_C:	reason = "correctable ECC error"; break;
-	case MCHK_K_ECC_NC:	reason = "non-correctable ECC error"; break;
-	case MCHK_K_CACKSOFT:	reason = "MCHK_K_CACKSOFT"; break;
-	case MCHK_K_BUGCHECK:	reason = "illegal exception in PAL mode"; break;
-	case MCHK_K_OS_BUGCHECK: reason = "callsys in kernel mode"; break;
-	case MCHK_K_DCPERR:	reason = "d-cache parity error"; break;
-	case MCHK_K_ICPERR:	reason = "i-cache parity error"; break;
-	case MCHK_K_SIO_SERR:	reason = "SIO SERR occurred on PCI bus"; break;
-	case MCHK_K_SIO_IOCHK:	reason = "SIO IOCHK occurred on ISA bus"; break;
-	case MCHK_K_DCSR:	reason = "MCHK_K_DCSR"; break;
-	case MCHK_K_UNKNOWN:
-	default:		reason = "unknown"; break;
-	}
-
-	switch (el.c->size) {
-	case sizeof(struct el_lca_mcheck_short):
-		printk(KERN_CRIT
-		       "  Reason: %s (short frame%s, dc_stat=%#lx):\n",
-		       reason, el.c->retry ? ", retryable" : "",
-		       el.s->dc_stat);
-		if (el.s->esr & ESR_EAV) {
-			mem_error(el.s->esr, el.s->ear);
-		}
-		if (el.s->ioc_stat0 & IOC_ERR) {
-			ioc_error(el.s->ioc_stat0, el.s->ioc_stat1);
-		}
-		break;
-
-	case sizeof(struct el_lca_mcheck_long):
-		printk(KERN_CRIT "  Reason: %s (long frame%s):\n",
-		       reason, el.c->retry ? ", retryable" : "");
-		printk(KERN_CRIT
-		       "    reason: %#lx  exc_addr: %#lx  dc_stat: %#lx\n", 
-		       el.l->pt[0], el.l->exc_addr, el.l->dc_stat);
-		printk(KERN_CRIT "    car: %#lx\n", el.l->car);
-		if (el.l->esr & ESR_EAV) {
-			mem_error(el.l->esr, el.l->ear);
-		}
-		if (el.l->ioc_stat0 & IOC_ERR) {
-			ioc_error(el.l->ioc_stat0, el.l->ioc_stat1);
-		}
-		break;
-
-	default:
-		printk(KERN_CRIT "  Unknown errorlog size %d\n", el.c->size);
-	}
-
-	/* Dump the logout area to give all info.  */
-#ifdef CONFIG_VERBOSE_MCHECK
-	if (alpha_verbose_mcheck > 1) {
-		unsigned long * ptr = (unsigned long *) la_ptr;
-		long i;
-		for (i = 0; i < el.c->size / sizeof(long); i += 2) {
-			printk(KERN_CRIT " +%8lx %016lx %016lx\n",
-			       i*sizeof(long), ptr[i], ptr[i+1]);
-		}
-	}
-#endif /* CONFIG_VERBOSE_MCHECK */
-}
diff --git a/arch/alpha/kernel/irq_i8259.c b/arch/alpha/kernel/irq_i8259.c
index 1dcf0d9038fd..29c6c477ac35 100644
--- a/arch/alpha/kernel/irq_i8259.c
+++ b/arch/alpha/kernel/irq_i8259.c
@@ -98,10 +98,6 @@ init_i8259a_irqs(void)
 
 #if defined(CONFIG_ALPHA_GENERIC)
 # define IACK_SC	alpha_mv.iack_sc
-#elif defined(CONFIG_ALPHA_APECS)
-# define IACK_SC	APECS_IACK_SC
-#elif defined(CONFIG_ALPHA_LCA)
-# define IACK_SC	LCA_IACK_SC
 #elif defined(CONFIG_ALPHA_CIA)
 # define IACK_SC	CIA_IACK_SC
 #elif defined(CONFIG_ALPHA_PYXIS)
diff --git a/arch/alpha/kernel/pci_impl.h b/arch/alpha/kernel/pci_impl.h
index 18043af45e2b..a16325ce21c4 100644
--- a/arch/alpha/kernel/pci_impl.h
+++ b/arch/alpha/kernel/pci_impl.h
@@ -143,9 +143,7 @@ struct pci_iommu_arena
 	unsigned int align_entry;
 };
 
-#if defined(CONFIG_ALPHA_SRM) && \
-    (defined(CONFIG_ALPHA_CIA) || defined(CONFIG_ALPHA_LCA) || \
-     defined(CONFIG_ALPHA_AVANTI))
+#if defined(CONFIG_ALPHA_SRM) && defined(CONFIG_ALPHA_CIA)
 # define NEED_SRM_SAVE_RESTORE
 #else
 # undef NEED_SRM_SAVE_RESTORE
diff --git a/arch/alpha/kernel/proto.h b/arch/alpha/kernel/proto.h
index 5b1d0d71d479..a8bc3ead776b 100644
--- a/arch/alpha/kernel/proto.h
+++ b/arch/alpha/kernel/proto.h
@@ -17,13 +17,6 @@ struct pci_dev;
 struct pci_controller;
 struct pci_bus;
 
-/* core_apecs.c */
-extern struct pci_ops apecs_pci_ops;
-extern void apecs_init_arch(void);
-extern void apecs_pci_clr_err(void);
-extern void apecs_machine_check(unsigned long vector, unsigned long la_ptr);
-extern void apecs_pci_tbi(struct pci_controller *, dma_addr_t, dma_addr_t);
-
 /* core_cia.c */
 extern struct pci_ops cia_pci_ops;
 extern void cia_init_pci(void);
@@ -39,12 +32,6 @@ extern int irongate_pci_clr_err(void);
 extern void irongate_init_arch(void);
 #define irongate_pci_tbi ((void *)0)
 
-/* core_lca.c */
-extern struct pci_ops lca_pci_ops;
-extern void lca_init_arch(void);
-extern void lca_machine_check(unsigned long vector, unsigned long la_ptr);
-extern void lca_pci_tbi(struct pci_controller *, dma_addr_t, dma_addr_t);
-
 /* core_marvel.c */
 extern struct pci_ops marvel_pci_ops;
 extern void marvel_init_arch(void);
diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index 3b833bd97817..bebdffafaee8 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -171,27 +171,17 @@ EXPORT_SYMBOL(__direct_map_size);
 	asm(".weak "#X)
 
 WEAK(alcor_mv);
-WEAK(alphabook1_mv);
-WEAK(avanti_mv);
-WEAK(cabriolet_mv);
 WEAK(clipper_mv);
 WEAK(dp264_mv);
 WEAK(eb164_mv);
-WEAK(eb64p_mv);
-WEAK(eb66_mv);
-WEAK(eb66p_mv);
 WEAK(eiger_mv);
 WEAK(lx164_mv);
 WEAK(marvel_ev7_mv);
 WEAK(miata_mv);
-WEAK(mikasa_mv);
 WEAK(mikasa_primo_mv);
 WEAK(monet_mv);
 WEAK(nautilus_mv);
-WEAK(noname_mv);
-WEAK(noritake_mv);
 WEAK(noritake_primo_mv);
-WEAK(p2k_mv);
 WEAK(pc164_mv);
 WEAK(privateer_mv);
 WEAK(rawhide_mv);
@@ -204,7 +194,6 @@ WEAK(takara_mv);
 WEAK(titan_mv);
 WEAK(webbrick_mv);
 WEAK(wildfire_mv);
-WEAK(xl_mv);
 WEAK(xlt_mv);
 
 #undef WEAK
@@ -692,12 +681,6 @@ static int eb164_indices[] = {0,0,0,1,1,1,1,1,2,2,2,2,3,3,3,3,4};
 static char alcor_names[][16] = {"Alcor", "Maverick", "Bret"};
 static int alcor_indices[] = {0,0,0,1,1,1,0,0,0,0,0,0,2,2,2,2,2,2};
 
-static char eb64p_names[][16] = {"EB64+", "Cabriolet", "AlphaPCI64"};
-static int eb64p_indices[] = {0,0,1,2};
-
-static char eb66_names[][8] = {"EB66", "EB66+"};
-static int eb66_indices[] = {0,0,1};
-
 static char marvel_names[][16] = {
 	"Marvel/EV7"
 };
@@ -736,21 +719,21 @@ get_sysvec(unsigned long type, unsigned long variation, unsigned long cpu)
 		NULL,		/* Morgan */
 		NULL,		/* Sable -- see below.  */
 		NULL,		/* Medulla */
-		&noname_mv,
+		NULL,		/* Noname */
 		NULL,		/* Turbolaser */
-		&avanti_mv,
+		NULL,		/* Avanti */
 		NULL,		/* Mustang */
 		NULL,		/* Alcor, Bret, Maverick. HWRPB inaccurate? */
 		NULL,		/* Tradewind */
 		NULL,		/* Mikasa -- see below.  */
 		NULL,		/* EB64 */
-		NULL,		/* EB66 -- see variation.  */
-		NULL,		/* EB64+ -- see variation.  */
-		&alphabook1_mv,
+		NULL,		/* EB66 */
+		NULL,		/* EB64+ */
+		NULL,		/* Alphabook1 */
 		&rawhide_mv,
 		NULL,		/* K2 */
 		NULL,		/* Lynx */
-		&xl_mv,
+		NULL,		/* XL */
 		NULL,		/* EB164 -- see variation.  */
 		NULL,		/* Noritake -- see below.  */
 		NULL,		/* Cortex */
@@ -789,19 +772,6 @@ get_sysvec(unsigned long type, unsigned long variation, unsigned long cpu)
 		&eb164_mv, &pc164_mv, &lx164_mv, &sx164_mv, &rx164_mv
 	};
 
-	static struct alpha_machine_vector *eb64p_vecs[] __initdata =
-	{
-		&eb64p_mv,
-		&cabriolet_mv,
-		&cabriolet_mv		/* AlphaPCI64 */
-	};
-
-	static struct alpha_machine_vector *eb66_vecs[] __initdata =
-	{
-		&eb66_mv,
-		&eb66p_mv
-	};
-
 	static struct alpha_machine_vector *marvel_vecs[] __initdata =
 	{
 		&marvel_ev7_mv,
@@ -869,14 +839,6 @@ get_sysvec(unsigned long type, unsigned long variation, unsigned long cpu)
 			if (vec == &eb164_mv && cpu == EV56_CPU)
 				vec = &pc164_mv;
 			break;
-		case ST_DEC_EB64P:
-			if (member < ARRAY_SIZE(eb64p_indices))
-				vec = eb64p_vecs[eb64p_indices[member]];
-			break;
-		case ST_DEC_EB66:
-			if (member < ARRAY_SIZE(eb66_indices))
-				vec = eb66_vecs[eb66_indices[member]];
-			break;
 		case ST_DEC_MARVEL:
 			if (member < ARRAY_SIZE(marvel_indices))
 				vec = marvel_vecs[marvel_indices[member]];
@@ -891,16 +853,10 @@ get_sysvec(unsigned long type, unsigned long variation, unsigned long cpu)
 				vec = tsunami_vecs[tsunami_indices[member]];
 			break;
 		case ST_DEC_1000:
-			if (cpu == EV5_CPU || cpu == EV56_CPU)
-				vec = &mikasa_primo_mv;
-			else
-				vec = &mikasa_mv;
+			vec = &mikasa_primo_mv;
 			break;
 		case ST_DEC_NORITAKE:
-			if (cpu == EV5_CPU || cpu == EV56_CPU)
-				vec = &noritake_primo_mv;
-			else
-				vec = &noritake_mv;
+			vec = &noritake_primo_mv;
 			break;
 		case ST_DEC_2100_A500:
 			vec = &sable_gamma_mv;
@@ -916,26 +872,16 @@ get_sysvec_byname(const char *name)
 	static struct alpha_machine_vector *all_vecs[] __initdata =
 	{
 		&alcor_mv,
-		&alphabook1_mv,
-		&avanti_mv,
-		&cabriolet_mv,
 		&clipper_mv,
 		&dp264_mv,
 		&eb164_mv,
-		&eb64p_mv,
-		&eb66_mv,
-		&eb66p_mv,
 		&eiger_mv,
 		&lx164_mv,
 		&miata_mv,
-		&mikasa_mv,
 		&mikasa_primo_mv,
 		&monet_mv,
 		&nautilus_mv,
-		&noname_mv,
-		&noritake_mv,
 		&noritake_primo_mv,
-		&p2k_mv,
 		&pc164_mv,
 		&privateer_mv,
 		&rawhide_mv,
@@ -947,7 +893,6 @@ get_sysvec_byname(const char *name)
 		&takara_mv,
 		&webbrick_mv,
 		&wildfire_mv,
-		&xl_mv,
 		&xlt_mv
 	};
 
@@ -1009,14 +954,6 @@ get_sysnames(unsigned long type, unsigned long variation, unsigned long cpu,
 		if (member < ARRAY_SIZE(alcor_indices))
 			*variation_name = alcor_names[alcor_indices[member]];
 		break;
-	case ST_DEC_EB64P:
-		if (member < ARRAY_SIZE(eb64p_indices))
-			*variation_name = eb64p_names[eb64p_indices[member]];
-		break;
-	case ST_DEC_EB66:
-		if (member < ARRAY_SIZE(eb66_indices))
-			*variation_name = eb66_names[eb66_indices[member]];
-		break;
 	case ST_DEC_MARVEL:
 		if (member < ARRAY_SIZE(marvel_indices))
 			*variation_name = marvel_names[marvel_indices[member]];
diff --git a/arch/alpha/kernel/sys_cabriolet.c b/arch/alpha/kernel/sys_cabriolet.c
index 47459b73cdb7..06a950072f82 100644
--- a/arch/alpha/kernel/sys_cabriolet.c
+++ b/arch/alpha/kernel/sys_cabriolet.c
@@ -23,9 +23,7 @@
 #include <asm/irq.h>
 #include <asm/mmu_context.h>
 #include <asm/io.h>
-#include <asm/core_apecs.h>
 #include <asm/core_cia.h>
-#include <asm/core_lca.h>
 #include <asm/tlbflush.h>
 
 #include "proto.h"
@@ -232,13 +230,6 @@ cabriolet_enable_ide(void)
 	}
 }
 
-static inline void __init
-cabriolet_init_pci(void)
-{
-	common_init_pci();
-	cabriolet_enable_ide();
-}
-
 static inline void __init
 cia_cab_init_pci(void)
 {
@@ -317,32 +308,6 @@ alphapc164_init_pci(void)
  * The System Vector
  */
 
-#if defined(CONFIG_ALPHA_GENERIC) || defined(CONFIG_ALPHA_CABRIOLET)
-struct alpha_machine_vector cabriolet_mv __initmv = {
-	.vector_name		= "Cabriolet",
-	DO_EV4_MMU,
-	DO_DEFAULT_RTC,
-	DO_APECS_IO,
-	.machine_check		= apecs_machine_check,
-	.max_isa_dma_address	= ALPHA_MAX_ISA_DMA_ADDRESS,
-	.min_io_address		= DEFAULT_IO_BASE,
-	.min_mem_address	= APECS_AND_LCA_DEFAULT_MEM_BASE,
-
-	.nr_irqs		= 35,
-	.device_interrupt	= cabriolet_device_interrupt,
-
-	.init_arch		= apecs_init_arch,
-	.init_irq		= cabriolet_init_irq,
-	.init_rtc		= common_init_rtc,
-	.init_pci		= cabriolet_init_pci,
-	.pci_map_irq		= cabriolet_map_irq,
-	.pci_swizzle		= common_swizzle,
-};
-#ifndef CONFIG_ALPHA_EB64P
-ALIAS_MV(cabriolet)
-#endif
-#endif
-
 #if defined(CONFIG_ALPHA_GENERIC) || defined(CONFIG_ALPHA_EB164)
 struct alpha_machine_vector eb164_mv __initmv = {
 	.vector_name		= "EB164",
@@ -368,30 +333,6 @@ struct alpha_machine_vector eb164_mv __initmv = {
 ALIAS_MV(eb164)
 #endif
 
-#if defined(CONFIG_ALPHA_GENERIC) || defined(CONFIG_ALPHA_EB66P)
-struct alpha_machine_vector eb66p_mv __initmv = {
-	.vector_name		= "EB66+",
-	DO_EV4_MMU,
-	DO_DEFAULT_RTC,
-	DO_LCA_IO,
-	.machine_check		= lca_machine_check,
-	.max_isa_dma_address	= ALPHA_MAX_ISA_DMA_ADDRESS,
-	.min_io_address		= DEFAULT_IO_BASE,
-	.min_mem_address	= APECS_AND_LCA_DEFAULT_MEM_BASE,
-
-	.nr_irqs		= 35,
-	.device_interrupt	= cabriolet_device_interrupt,
-
-	.init_arch		= lca_init_arch,
-	.init_irq		= cabriolet_init_irq,
-	.init_rtc		= common_init_rtc,
-	.init_pci		= cabriolet_init_pci,
-	.pci_map_irq		= eb66p_map_irq,
-	.pci_swizzle		= common_swizzle,
-};
-ALIAS_MV(eb66p)
-#endif
-
 #if defined(CONFIG_ALPHA_GENERIC) || defined(CONFIG_ALPHA_LX164)
 struct alpha_machine_vector lx164_mv __initmv = {
 	.vector_name		= "LX164",
diff --git a/arch/alpha/kernel/sys_eb64p.c b/arch/alpha/kernel/sys_eb64p.c
deleted file mode 100644
index 3c43fd347526..000000000000
--- a/arch/alpha/kernel/sys_eb64p.c
+++ /dev/null
@@ -1,238 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *	linux/arch/alpha/kernel/sys_eb64p.c
- *
- *	Copyright (C) 1995 David A Rusling
- *	Copyright (C) 1996 Jay A Estabrook
- *	Copyright (C) 1998, 1999 Richard Henderson
- *
- * Code supporting the EB64+ and EB66.
- */
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/mm.h>
-#include <linux/sched.h>
-#include <linux/pci.h>
-#include <linux/init.h>
-#include <linux/bitops.h>
-
-#include <asm/ptrace.h>
-#include <asm/dma.h>
-#include <asm/irq.h>
-#include <asm/mmu_context.h>
-#include <asm/io.h>
-#include <asm/core_apecs.h>
-#include <asm/core_lca.h>
-#include <asm/hwrpb.h>
-#include <asm/tlbflush.h>
-
-#include "proto.h"
-#include "irq_impl.h"
-#include "pci_impl.h"
-#include "machvec_impl.h"
-
-
-/* Note mask bit is true for DISABLED irqs.  */
-static unsigned int cached_irq_mask = -1;
-
-static inline void
-eb64p_update_irq_hw(unsigned int irq, unsigned long mask)
-{
-	outb(mask >> (irq >= 24 ? 24 : 16), (irq >= 24 ? 0x27 : 0x26));
-}
-
-static inline void
-eb64p_enable_irq(struct irq_data *d)
-{
-	eb64p_update_irq_hw(d->irq, cached_irq_mask &= ~(1 << d->irq));
-}
-
-static void
-eb64p_disable_irq(struct irq_data *d)
-{
-	eb64p_update_irq_hw(d->irq, cached_irq_mask |= 1 << d->irq);
-}
-
-static struct irq_chip eb64p_irq_type = {
-	.name		= "EB64P",
-	.irq_unmask	= eb64p_enable_irq,
-	.irq_mask	= eb64p_disable_irq,
-	.irq_mask_ack	= eb64p_disable_irq,
-};
-
-static void 
-eb64p_device_interrupt(unsigned long vector)
-{
-	unsigned long pld;
-	unsigned int i;
-
-	/* Read the interrupt summary registers */
-	pld = inb(0x26) | (inb(0x27) << 8);
-
-	/*
-	 * Now, for every possible bit set, work through
-	 * them and call the appropriate interrupt handler.
-	 */
-	while (pld) {
-		i = ffz(~pld);
-		pld &= pld - 1;	/* clear least bit set */
-
-		if (i == 5) {
-			isa_device_interrupt(vector);
-		} else {
-			handle_irq(16 + i);
-		}
-	}
-}
-
-static void __init
-eb64p_init_irq(void)
-{
-	long i;
-
-#if defined(CONFIG_ALPHA_GENERIC) || defined(CONFIG_ALPHA_CABRIOLET)
-	/*
-	 * CABRIO SRM may not set variation correctly, so here we test
-	 * the high word of the interrupt summary register for the RAZ
-	 * bits, and hope that a true EB64+ would read all ones...
-	 */
-	if (inw(0x806) != 0xffff) {
-		extern struct alpha_machine_vector cabriolet_mv;
-
-		printk("Detected Cabriolet: correcting HWRPB.\n");
-
-		hwrpb->sys_variation |= 2L << 10;
-		hwrpb_update_checksum(hwrpb);
-
-		alpha_mv = cabriolet_mv;
-		alpha_mv.init_irq();
-		return;
-	}
-#endif /* GENERIC */
-
-	outb(0xff, 0x26);
-	outb(0xff, 0x27);
-
-	init_i8259a_irqs();
-
-	for (i = 16; i < 32; ++i) {
-		irq_set_chip_and_handler(i, &eb64p_irq_type, handle_level_irq);
-		irq_set_status_flags(i, IRQ_LEVEL);
-	}
-
-	common_init_isa_dma();
-	if (request_irq(16 + 5, no_action, 0, "isa-cascade", NULL))
-		pr_err("Failed to register isa-cascade interrupt\n");
-}
-
-/*
- * PCI Fixup configuration.
- *
- * There are two 8 bit external summary registers as follows:
- *
- * Summary @ 0x26:
- * Bit      Meaning
- * 0        Interrupt Line A from slot 0
- * 1        Interrupt Line A from slot 1
- * 2        Interrupt Line B from slot 0
- * 3        Interrupt Line B from slot 1
- * 4        Interrupt Line C from slot 0
- * 5        Interrupt line from the two ISA PICs
- * 6        Tulip
- * 7        NCR SCSI
- *
- * Summary @ 0x27
- * Bit      Meaning
- * 0        Interrupt Line C from slot 1
- * 1        Interrupt Line D from slot 0
- * 2        Interrupt Line D from slot 1
- * 3        RAZ
- * 4        RAZ
- * 5        RAZ
- * 6        RAZ
- * 7        RAZ
- *
- * The device to slot mapping looks like:
- *
- * Slot     Device
- *  5       NCR SCSI controller
- *  6       PCI on board slot 0
- *  7       PCI on board slot 1
- *  8       Intel SIO PCI-ISA bridge chip
- *  9       Tulip - DECchip 21040 Ethernet controller
- *   
- *
- * This two layered interrupt approach means that we allocate IRQ 16 and 
- * above for PCI interrupts.  The IRQ relates to which bit the interrupt
- * comes in on.  This makes interrupt processing much easier.
- */
-
-static int
-eb64p_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	static char irq_tab[5][5] = {
-		/*INT  INTA  INTB  INTC   INTD */
-		{16+7, 16+7, 16+7, 16+7,  16+7},  /* IdSel 5,  slot ?, ?? */
-		{16+0, 16+0, 16+2, 16+4,  16+9},  /* IdSel 6,  slot ?, ?? */
-		{16+1, 16+1, 16+3, 16+8, 16+10},  /* IdSel 7,  slot ?, ?? */
-		{  -1,   -1,   -1,   -1,    -1},  /* IdSel 8,  SIO */
-		{16+6, 16+6, 16+6, 16+6,  16+6},  /* IdSel 9,  TULIP */
-	};
-	const long min_idsel = 5, max_idsel = 9, irqs_per_slot = 5;
-	return COMMON_TABLE_LOOKUP;
-}
-
-
-/*
- * The System Vector
- */
-
-#if defined(CONFIG_ALPHA_GENERIC) || defined(CONFIG_ALPHA_EB64P)
-struct alpha_machine_vector eb64p_mv __initmv = {
-	.vector_name		= "EB64+",
-	DO_EV4_MMU,
-	DO_DEFAULT_RTC,
-	DO_APECS_IO,
-	.machine_check		= apecs_machine_check,
-	.max_isa_dma_address	= ALPHA_MAX_ISA_DMA_ADDRESS,
-	.min_io_address		= DEFAULT_IO_BASE,
-	.min_mem_address	= APECS_AND_LCA_DEFAULT_MEM_BASE,
-
-	.nr_irqs		= 32,
-	.device_interrupt	= eb64p_device_interrupt,
-
-	.init_arch		= apecs_init_arch,
-	.init_irq		= eb64p_init_irq,
-	.init_rtc		= common_init_rtc,
-	.init_pci		= common_init_pci,
-	.kill_arch		= NULL,
-	.pci_map_irq		= eb64p_map_irq,
-	.pci_swizzle		= common_swizzle,
-};
-ALIAS_MV(eb64p)
-#endif
-
-#if defined(CONFIG_ALPHA_GENERIC) || defined(CONFIG_ALPHA_EB66)
-struct alpha_machine_vector eb66_mv __initmv = {
-	.vector_name		= "EB66",
-	DO_EV4_MMU,
-	DO_DEFAULT_RTC,
-	DO_LCA_IO,
-	.machine_check		= lca_machine_check,
-	.max_isa_dma_address	= ALPHA_MAX_ISA_DMA_ADDRESS,
-	.min_io_address		= DEFAULT_IO_BASE,
-	.min_mem_address	= APECS_AND_LCA_DEFAULT_MEM_BASE,
-
-	.nr_irqs		= 32,
-	.device_interrupt	= eb64p_device_interrupt,
-
-	.init_arch		= lca_init_arch,
-	.init_irq		= eb64p_init_irq,
-	.init_rtc		= common_init_rtc,
-	.init_pci		= common_init_pci,
-	.pci_map_irq		= eb64p_map_irq,
-	.pci_swizzle		= common_swizzle,
-};
-ALIAS_MV(eb66)
-#endif
diff --git a/arch/alpha/kernel/sys_mikasa.c b/arch/alpha/kernel/sys_mikasa.c
index 7690dfd57cb6..557802398231 100644
--- a/arch/alpha/kernel/sys_mikasa.c
+++ b/arch/alpha/kernel/sys_mikasa.c
@@ -23,7 +23,6 @@
 #include <asm/irq.h>
 #include <asm/mmu_context.h>
 #include <asm/io.h>
-#include <asm/core_apecs.h>
 #include <asm/core_cia.h>
 #include <asm/tlbflush.h>
 
@@ -164,64 +163,9 @@ mikasa_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 }
 
 
-#if defined(CONFIG_ALPHA_GENERIC) || !defined(CONFIG_ALPHA_PRIMO)
-static void
-mikasa_apecs_machine_check(unsigned long vector, unsigned long la_ptr)
-{
-#define MCHK_NO_DEVSEL 0x205U
-#define MCHK_NO_TABT 0x204U
-
-	struct el_common *mchk_header;
-	unsigned int code;
-
-	mchk_header = (struct el_common *)la_ptr;
-
-	/* Clear the error before any reporting.  */
-	mb();
-	mb(); /* magic */
-	draina();
-	apecs_pci_clr_err();
-	wrmces(0x7);
-	mb();
-
-	code = mchk_header->code;
-	process_mcheck_info(vector, la_ptr, "MIKASA APECS",
-			    (mcheck_expected(0)
-			     && (code == MCHK_NO_DEVSEL
-			         || code == MCHK_NO_TABT)));
-}
-#endif
-
-
 /*
  * The System Vector
  */
-
-#if defined(CONFIG_ALPHA_GENERIC) || !defined(CONFIG_ALPHA_PRIMO)
-struct alpha_machine_vector mikasa_mv __initmv = {
-	.vector_name		= "Mikasa",
-	DO_EV4_MMU,
-	DO_DEFAULT_RTC,
-	DO_APECS_IO,
-	.machine_check		= mikasa_apecs_machine_check,
-	.max_isa_dma_address	= ALPHA_MAX_ISA_DMA_ADDRESS,
-	.min_io_address		= DEFAULT_IO_BASE,
-	.min_mem_address	= APECS_AND_LCA_DEFAULT_MEM_BASE,
-
-	.nr_irqs		= 32,
-	.device_interrupt	= mikasa_device_interrupt,
-
-	.init_arch		= apecs_init_arch,
-	.init_irq		= mikasa_init_irq,
-	.init_rtc		= common_init_rtc,
-	.init_pci		= common_init_pci,
-	.pci_map_irq		= mikasa_map_irq,
-	.pci_swizzle		= common_swizzle,
-};
-ALIAS_MV(mikasa)
-#endif
-
-#if defined(CONFIG_ALPHA_GENERIC) || defined(CONFIG_ALPHA_PRIMO)
 struct alpha_machine_vector mikasa_primo_mv __initmv = {
 	.vector_name		= "Mikasa-Primo",
 	DO_EV5_MMU,
@@ -244,4 +188,3 @@ struct alpha_machine_vector mikasa_primo_mv __initmv = {
 	.pci_swizzle		= common_swizzle,
 };
 ALIAS_MV(mikasa_primo)
-#endif
diff --git a/arch/alpha/kernel/sys_noritake.c b/arch/alpha/kernel/sys_noritake.c
index 47f3ce4f719a..eed3f16561c0 100644
--- a/arch/alpha/kernel/sys_noritake.c
+++ b/arch/alpha/kernel/sys_noritake.c
@@ -24,7 +24,6 @@
 #include <asm/irq.h>
 #include <asm/mmu_context.h>
 #include <asm/io.h>
-#include <asm/core_apecs.h>
 #include <asm/core_cia.h>
 #include <asm/tlbflush.h>
 
@@ -253,64 +252,6 @@ noritake_swizzle(struct pci_dev *dev, u8 *pinp)
 	return slot;
 }
 
-#if defined(CONFIG_ALPHA_GENERIC) || !defined(CONFIG_ALPHA_PRIMO)
-static void
-noritake_apecs_machine_check(unsigned long vector, unsigned long la_ptr)
-{
-#define MCHK_NO_DEVSEL 0x205U
-#define MCHK_NO_TABT 0x204U
-
-        struct el_common *mchk_header;
-        unsigned int code;
-
-        mchk_header = (struct el_common *)la_ptr;
-
-        /* Clear the error before any reporting.  */
-        mb();
-        mb(); /* magic */
-        draina();
-        apecs_pci_clr_err();
-        wrmces(0x7);
-        mb();
-
-        code = mchk_header->code;
-        process_mcheck_info(vector, la_ptr, "NORITAKE APECS",
-                            (mcheck_expected(0)
-                             && (code == MCHK_NO_DEVSEL
-                                 || code == MCHK_NO_TABT)));
-}
-#endif
-
-
-/*
- * The System Vectors
- */
-
-#if defined(CONFIG_ALPHA_GENERIC) || !defined(CONFIG_ALPHA_PRIMO)
-struct alpha_machine_vector noritake_mv __initmv = {
-	.vector_name		= "Noritake",
-	DO_EV4_MMU,
-	DO_DEFAULT_RTC,
-	DO_APECS_IO,
-	.machine_check		= noritake_apecs_machine_check,
-	.max_isa_dma_address	= ALPHA_MAX_ISA_DMA_ADDRESS,
-	.min_io_address		= EISA_DEFAULT_IO_BASE,
-	.min_mem_address	= APECS_AND_LCA_DEFAULT_MEM_BASE,
-
-	.nr_irqs		= 48,
-	.device_interrupt	= noritake_device_interrupt,
-
-	.init_arch		= apecs_init_arch,
-	.init_irq		= noritake_init_irq,
-	.init_rtc		= common_init_rtc,
-	.init_pci		= common_init_pci,
-	.pci_map_irq		= noritake_map_irq,
-	.pci_swizzle		= noritake_swizzle,
-};
-ALIAS_MV(noritake)
-#endif
-
-#if defined(CONFIG_ALPHA_GENERIC) || defined(CONFIG_ALPHA_PRIMO)
 struct alpha_machine_vector noritake_primo_mv __initmv = {
 	.vector_name		= "Noritake-Primo",
 	DO_EV5_MMU,
@@ -333,4 +274,3 @@ struct alpha_machine_vector noritake_primo_mv __initmv = {
 	.pci_swizzle		= noritake_swizzle,
 };
 ALIAS_MV(noritake_primo)
-#endif
diff --git a/arch/alpha/kernel/sys_sio.c b/arch/alpha/kernel/sys_sio.c
deleted file mode 100644
index c28a6ae1d989..000000000000
--- a/arch/alpha/kernel/sys_sio.c
+++ /dev/null
@@ -1,486 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *	linux/arch/alpha/kernel/sys_sio.c
- *
- *	Copyright (C) 1995 David A Rusling
- *	Copyright (C) 1996 Jay A Estabrook
- *	Copyright (C) 1998, 1999 Richard Henderson
- *
- * Code for all boards that route the PCI interrupts through the SIO
- * PCI/ISA bridge.  This includes Noname (AXPpci33), Multia (UDB),
- * Kenetics's Platform 2000, Avanti (AlphaStation), XL, and AlphaBook1.
- */
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/mm.h>
-#include <linux/sched.h>
-#include <linux/pci.h>
-#include <linux/init.h>
-#include <linux/screen_info.h>
-
-#include <asm/compiler.h>
-#include <asm/ptrace.h>
-#include <asm/dma.h>
-#include <asm/irq.h>
-#include <asm/mmu_context.h>
-#include <asm/io.h>
-#include <asm/core_apecs.h>
-#include <asm/core_lca.h>
-#include <asm/tlbflush.h>
-
-#include "proto.h"
-#include "irq_impl.h"
-#include "pci_impl.h"
-#include "machvec_impl.h"
-#include "pc873xx.h"
-
-#if defined(ALPHA_RESTORE_SRM_SETUP)
-/* Save LCA configuration data as the console had it set up.  */
-struct 
-{
-	unsigned int orig_route_tab; /* for SAVE/RESTORE */
-} saved_config __attribute((common));
-#endif
-
-
-static void __init
-sio_init_irq(void)
-{
-	if (alpha_using_srm)
-		alpha_mv.device_interrupt = srm_device_interrupt;
-
-	init_i8259a_irqs();
-	common_init_isa_dma();
-}
-
-static inline void __init
-alphabook1_init_arch(void)
-{
-#ifdef CONFIG_VGA_CONSOLE
-	/* The AlphaBook1 has LCD video fixed at 800x600,
-	   37 rows and 100 cols. */
-	vgacon_screen_info.orig_y = 37;
-	vgacon_screen_info.orig_video_cols = 100;
-	vgacon_screen_info.orig_video_lines = 37;
-#endif
-
-	lca_init_arch();
-}
-
-
-/*
- * sio_route_tab selects irq routing in PCI/ISA bridge so that:
- *		PIRQ0 -> irq 15
- *		PIRQ1 -> irq  9
- *		PIRQ2 -> irq 10
- *		PIRQ3 -> irq 11
- *
- * This probably ought to be configurable via MILO.  For
- * example, sound boards seem to like using IRQ 9.
- *
- * This is NOT how we should do it. PIRQ0-X should have
- * their own IRQs, the way intel uses the IO-APIC IRQs.
- */
-
-static void __init
-sio_pci_route(void)
-{
-	unsigned int orig_route_tab;
-
-	/* First, ALWAYS read and print the original setting. */
-	pci_bus_read_config_dword(pci_isa_hose->bus, PCI_DEVFN(7, 0), 0x60,
-				  &orig_route_tab);
-	printk("%s: PIRQ original 0x%x new 0x%x\n", __func__,
-	       orig_route_tab, alpha_mv.sys.sio.route_tab);
-
-#if defined(ALPHA_RESTORE_SRM_SETUP)
-	saved_config.orig_route_tab = orig_route_tab;
-#endif
-
-	/* Now override with desired setting. */
-	pci_bus_write_config_dword(pci_isa_hose->bus, PCI_DEVFN(7, 0), 0x60,
-				   alpha_mv.sys.sio.route_tab);
-}
-
-static bool sio_pci_dev_irq_needs_level(const struct pci_dev *dev)
-{
-	if ((dev->class >> 16 == PCI_BASE_CLASS_BRIDGE) &&
-	    (dev->class >> 8 != PCI_CLASS_BRIDGE_PCMCIA))
-		return false;
-
-	return true;
-}
-
-static unsigned int __init
-sio_collect_irq_levels(void)
-{
-	unsigned int level_bits = 0;
-	struct pci_dev *dev = NULL;
-
-	/* Iterate through the devices, collecting IRQ levels.  */
-	for_each_pci_dev(dev) {
-		if (!sio_pci_dev_irq_needs_level(dev))
-			continue;
-
-		if (dev->irq)
-			level_bits |= (1 << dev->irq);
-	}
-	return level_bits;
-}
-
-static void __sio_fixup_irq_levels(unsigned int level_bits, bool reset)
-{
-	unsigned int old_level_bits;
-
-	/*
-	 * Now, make all PCI interrupts level sensitive.  Notice:
-	 * these registers must be accessed byte-wise.  inw()/outw()
-	 * don't work.
-	 *
-	 * Make sure to turn off any level bits set for IRQs 9,10,11,15,
-	 *  so that the only bits getting set are for devices actually found.
-	 * Note that we do preserve the remainder of the bits, which we hope
-	 *  will be set correctly by ARC/SRM.
-	 *
-	 * Note: we at least preserve any level-set bits on AlphaBook1
-	 */
-	old_level_bits = inb(0x4d0) | (inb(0x4d1) << 8);
-
-	if (reset)
-		old_level_bits &= 0x71ff;
-
-	level_bits |= old_level_bits;
-
-	outb((level_bits >> 0) & 0xff, 0x4d0);
-	outb((level_bits >> 8) & 0xff, 0x4d1);
-}
-
-static inline void
-sio_fixup_irq_levels(unsigned int level_bits)
-{
-	__sio_fixup_irq_levels(level_bits, true);
-}
-
-static inline int
-noname_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	/*
-	 * The Noname board has 5 PCI slots with each of the 4
-	 * interrupt pins routed to different pins on the PCI/ISA
-	 * bridge (PIRQ0-PIRQ3).  The table below is based on
-	 * information available at:
-	 *
-	 *   http://ftp.digital.com/pub/DEC/axppci/ref_interrupts.txt
-	 *
-	 * I have no information on the Avanti interrupt routing, but
-	 * the routing seems to be identical to the Noname except
-	 * that the Avanti has an additional slot whose routing I'm
-	 * unsure of.
-	 *
-	 * pirq_tab[0] is a fake entry to deal with old PCI boards
-	 * that have the interrupt pin number hardwired to 0 (meaning
-	 * that they use the default INTA line, if they are interrupt
-	 * driven at all).
-	 */
-	static char irq_tab[][5] = {
-		/*INT A   B   C   D */
-		{ 3,  3,  3,  3,  3}, /* idsel  6 (53c810) */ 
-		{-1, -1, -1, -1, -1}, /* idsel  7 (SIO: PCI/ISA bridge) */
-		{ 2,  2, -1, -1, -1}, /* idsel  8 (Hack: slot closest ISA) */
-		{-1, -1, -1, -1, -1}, /* idsel  9 (unused) */
-		{-1, -1, -1, -1, -1}, /* idsel 10 (unused) */
-		{ 0,  0,  2,  1,  0}, /* idsel 11 KN25_PCI_SLOT0 */
-		{ 1,  1,  0,  2,  1}, /* idsel 12 KN25_PCI_SLOT1 */
-		{ 2,  2,  1,  0,  2}, /* idsel 13 KN25_PCI_SLOT2 */
-		{ 0,  0,  0,  0,  0}, /* idsel 14 AS255 TULIP */
-	};
-	const long min_idsel = 6, max_idsel = 14, irqs_per_slot = 5;
-	int irq = COMMON_TABLE_LOOKUP, tmp;
-	tmp = __kernel_extbl(alpha_mv.sys.sio.route_tab, irq);
-
-	irq = irq >= 0 ? tmp : -1;
-
-	/* Fixup IRQ level if an actual IRQ mapping is detected */
-	if (sio_pci_dev_irq_needs_level(dev) && irq >= 0)
-		__sio_fixup_irq_levels(1 << irq, false);
-
-	return irq;
-}
-
-static inline int
-p2k_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	static char irq_tab[][5] = {
-		/*INT A   B   C   D */
-		{ 0,  0, -1, -1, -1}, /* idsel  6 (53c810) */
-		{-1, -1, -1, -1, -1}, /* idsel  7 (SIO: PCI/ISA bridge) */
-		{ 1,  1,  2,  3,  0}, /* idsel  8 (slot A) */
-		{ 2,  2,  3,  0,  1}, /* idsel  9 (slot B) */
-		{-1, -1, -1, -1, -1}, /* idsel 10 (unused) */
-		{-1, -1, -1, -1, -1}, /* idsel 11 (unused) */
-		{ 3,  3, -1, -1, -1}, /* idsel 12 (CMD0646) */
-	};
-	const long min_idsel = 6, max_idsel = 12, irqs_per_slot = 5;
-	int irq = COMMON_TABLE_LOOKUP, tmp;
-	tmp = __kernel_extbl(alpha_mv.sys.sio.route_tab, irq);
-	return irq >= 0 ? tmp : -1;
-}
-
-static inline void __init
-noname_init_pci(void)
-{
-	common_init_pci();
-	sio_pci_route();
-	sio_fixup_irq_levels(sio_collect_irq_levels());
-
-	if (pc873xx_probe() == -1) {
-		printk(KERN_ERR "Probing for PC873xx Super IO chip failed.\n");
-	} else {
-		printk(KERN_INFO "Found %s Super IO chip at 0x%x\n",
-			pc873xx_get_model(), pc873xx_get_base());
-
-		/* Enabling things in the Super IO chip doesn't actually
-		 * configure and enable things, the legacy drivers still
-		 * need to do the actual configuration and enabling.
-		 * This only unblocks them.
-		 */
-
-#if !defined(CONFIG_ALPHA_AVANTI)
-		/* Don't bother on the Avanti family.
-		 * None of them had on-board IDE.
-		 */
-		pc873xx_enable_ide();
-#endif
-		pc873xx_enable_epp19();
-	}
-}
-
-static inline void __init
-alphabook1_init_pci(void)
-{
-	struct pci_dev *dev;
-	unsigned char orig, config;
-
-	common_init_pci();
-	sio_pci_route();
-
-	/*
-	 * On the AlphaBook1, the PCMCIA chip (Cirrus 6729)
-	 * is sensitive to PCI bus bursts, so we must DISABLE
-	 * burst mode for the NCR 8xx SCSI... :-(
-	 *
-	 * Note that the NCR810 SCSI driver must preserve the
-	 * setting of the bit in order for this to work.  At the
-	 * moment (2.0.29), ncr53c8xx.c does NOT do this, but
-	 * 53c7,8xx.c DOES.
-	 */
-
-	dev = NULL;
-	while ((dev = pci_get_device(PCI_VENDOR_ID_NCR, PCI_ANY_ID, dev))) {
-		if (dev->device == PCI_DEVICE_ID_NCR_53C810
-		    || dev->device == PCI_DEVICE_ID_NCR_53C815
-		    || dev->device == PCI_DEVICE_ID_NCR_53C820
-		    || dev->device == PCI_DEVICE_ID_NCR_53C825) {
-			unsigned long io_port;
-			unsigned char ctest4;
-
-			io_port = dev->resource[0].start;
-			ctest4 = inb(io_port+0x21);
-			if (!(ctest4 & 0x80)) {
-				printk("AlphaBook1 NCR init: setting"
-				       " burst disable\n");
-				outb(ctest4 | 0x80, io_port+0x21);
-			}
-                }
-	}
-
-	/* Do not set *ANY* level triggers for AlphaBook1. */
-	sio_fixup_irq_levels(0);
-
-	/* Make sure that register PR1 indicates 1Mb mem */
-	outb(0x0f, 0x3ce); orig = inb(0x3cf);   /* read PR5  */
-	outb(0x0f, 0x3ce); outb(0x05, 0x3cf);   /* unlock PR0-4 */
-	outb(0x0b, 0x3ce); config = inb(0x3cf); /* read PR1 */
-	if ((config & 0xc0) != 0xc0) {
-		printk("AlphaBook1 VGA init: setting 1Mb memory\n");
-		config |= 0xc0;
-		outb(0x0b, 0x3ce); outb(config, 0x3cf); /* write PR1 */
-	}
-	outb(0x0f, 0x3ce); outb(orig, 0x3cf); /* (re)lock PR0-4 */
-}
-
-static void
-sio_kill_arch(int mode)
-{
-#if defined(ALPHA_RESTORE_SRM_SETUP)
-	/* Since we cannot read the PCI DMA Window CSRs, we
-	 * cannot restore them here.
-	 *
-	 * However, we CAN read the PIRQ route register, so restore it
-	 * now...
-	 */
- 	pci_bus_write_config_dword(pci_isa_hose->bus, PCI_DEVFN(7, 0), 0x60,
-				   saved_config.orig_route_tab);
-#endif
-}
-
-
-/*
- * The System Vectors
- */
-
-#if defined(CONFIG_ALPHA_GENERIC) || defined(CONFIG_ALPHA_BOOK1)
-struct alpha_machine_vector alphabook1_mv __initmv = {
-	.vector_name		= "AlphaBook1",
-	DO_EV4_MMU,
-	DO_DEFAULT_RTC,
-	DO_LCA_IO,
-	.machine_check		= lca_machine_check,
-	.max_isa_dma_address	= ALPHA_MAX_ISA_DMA_ADDRESS,
-	.min_io_address		= DEFAULT_IO_BASE,
-	.min_mem_address	= APECS_AND_LCA_DEFAULT_MEM_BASE,
-
-	.nr_irqs		= 16,
-	.device_interrupt	= isa_device_interrupt,
-
-	.init_arch		= alphabook1_init_arch,
-	.init_irq		= sio_init_irq,
-	.init_rtc		= common_init_rtc,
-	.init_pci		= alphabook1_init_pci,
-	.kill_arch		= sio_kill_arch,
-	.pci_map_irq		= noname_map_irq,
-	.pci_swizzle		= common_swizzle,
-
-	.sys = { .sio = {
-		/* NCR810 SCSI is 14, PCMCIA controller is 15.  */
-		.route_tab	= 0x0e0f0a0a,
-	}}
-};
-ALIAS_MV(alphabook1)
-#endif
-
-#if defined(CONFIG_ALPHA_GENERIC) || defined(CONFIG_ALPHA_AVANTI_CH)
-struct alpha_machine_vector avanti_mv __initmv = {
-	.vector_name		= "Avanti",
-	DO_EV4_MMU,
-	DO_DEFAULT_RTC,
-	DO_APECS_IO,
-	.machine_check		= apecs_machine_check,
-	.max_isa_dma_address	= ALPHA_MAX_ISA_DMA_ADDRESS,
-	.min_io_address		= DEFAULT_IO_BASE,
-	.min_mem_address	= APECS_AND_LCA_DEFAULT_MEM_BASE,
-
-	.nr_irqs		= 16,
-	.device_interrupt	= isa_device_interrupt,
-
-	.init_arch		= apecs_init_arch,
-	.init_irq		= sio_init_irq,
-	.init_rtc		= common_init_rtc,
-	.init_pci		= noname_init_pci,
-	.kill_arch		= sio_kill_arch,
-	.pci_map_irq		= noname_map_irq,
-	.pci_swizzle		= common_swizzle,
-
-	.sys = { .sio = {
-		.route_tab	= 0x0b0a050f, /* leave 14 for IDE, 9 for SND */
-	}}
-};
-ALIAS_MV(avanti)
-#endif
-
-#if defined(CONFIG_ALPHA_GENERIC) || defined(CONFIG_ALPHA_NONAME_CH)
-struct alpha_machine_vector noname_mv __initmv = {
-	.vector_name		= "Noname",
-	DO_EV4_MMU,
-	DO_DEFAULT_RTC,
-	DO_LCA_IO,
-	.machine_check		= lca_machine_check,
-	.max_isa_dma_address	= ALPHA_MAX_ISA_DMA_ADDRESS,
-	.min_io_address		= DEFAULT_IO_BASE,
-	.min_mem_address	= APECS_AND_LCA_DEFAULT_MEM_BASE,
-
-	.nr_irqs		= 16,
-	.device_interrupt	= srm_device_interrupt,
-
-	.init_arch		= lca_init_arch,
-	.init_irq		= sio_init_irq,
-	.init_rtc		= common_init_rtc,
-	.init_pci		= noname_init_pci,
-	.kill_arch		= sio_kill_arch,
-	.pci_map_irq		= noname_map_irq,
-	.pci_swizzle		= common_swizzle,
-
-	.sys = { .sio = {
-		/* For UDB, the only available PCI slot must not map to IRQ 9,
-		   since that's the builtin MSS sound chip. That PCI slot
-		   will map to PIRQ1 (for INTA at least), so we give it IRQ 15
-		   instead.
-
-		   Unfortunately we have to do this for NONAME as well, since
-		   they are co-indicated when the platform type "Noname" is
-		   selected... :-(  */
-
-		.route_tab	= 0x0b0a0f0d,
-	}}
-};
-ALIAS_MV(noname)
-#endif
-
-#if defined(CONFIG_ALPHA_GENERIC) || defined(CONFIG_ALPHA_P2K)
-struct alpha_machine_vector p2k_mv __initmv = {
-	.vector_name		= "Platform2000",
-	DO_EV4_MMU,
-	DO_DEFAULT_RTC,
-	DO_LCA_IO,
-	.machine_check		= lca_machine_check,
-	.max_isa_dma_address	= ALPHA_MAX_ISA_DMA_ADDRESS,
-	.min_io_address		= DEFAULT_IO_BASE,
-	.min_mem_address	= APECS_AND_LCA_DEFAULT_MEM_BASE,
-
-	.nr_irqs		= 16,
-	.device_interrupt	= srm_device_interrupt,
-
-	.init_arch		= lca_init_arch,
-	.init_irq		= sio_init_irq,
-	.init_rtc		= common_init_rtc,
-	.init_pci		= noname_init_pci,
-	.kill_arch		= sio_kill_arch,
-	.pci_map_irq		= p2k_map_irq,
-	.pci_swizzle		= common_swizzle,
-
-	.sys = { .sio = {
-		.route_tab	= 0x0b0a090f,
-	}}
-};
-ALIAS_MV(p2k)
-#endif
-
-#if defined(CONFIG_ALPHA_GENERIC) || defined(CONFIG_ALPHA_XL)
-struct alpha_machine_vector xl_mv __initmv = {
-	.vector_name		= "XL",
-	DO_EV4_MMU,
-	DO_DEFAULT_RTC,
-	DO_APECS_IO,
-	.machine_check		= apecs_machine_check,
-	.max_isa_dma_address	= ALPHA_XL_MAX_ISA_DMA_ADDRESS,
-	.min_io_address		= DEFAULT_IO_BASE,
-	.min_mem_address	= XL_DEFAULT_MEM_BASE,
-
-	.nr_irqs		= 16,
-	.device_interrupt	= isa_device_interrupt,
-
-	.init_arch		= apecs_init_arch,
-	.init_irq		= sio_init_irq,
-	.init_rtc		= common_init_rtc,
-	.init_pci		= noname_init_pci,
-	.kill_arch		= sio_kill_arch,
-	.pci_map_irq		= noname_map_irq,
-	.pci_swizzle		= common_swizzle,
-
-	.sys = { .sio = {
-		.route_tab	= 0x0b0a090f,
-	}}
-};
-ALIAS_MV(xl)
-#endif
-- 
2.39.2


