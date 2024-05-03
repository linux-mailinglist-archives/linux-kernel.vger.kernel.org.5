Return-Path: <linux-kernel+bounces-167365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6EE8BA877
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1FFAB2320F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FB71514EA;
	Fri,  3 May 2024 08:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLycbW+J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85551514D6;
	Fri,  3 May 2024 08:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714723962; cv=none; b=JmQB1TaELBO1Ge0+21KZCGZ7KE9B9zjvpx8e2wyOe8Yvbt+PZRSK/ah1ODJMOsCJIJToOOhhasa4im+nqiOI/wcuFbUH2F6QZyFrYLBy4NbeU5OpRRKBgwkn5WO+p+pctHDXemnLhGxqnK/flCW5+FmXlYUw83TM4jD6ZLfh6AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714723962; c=relaxed/simple;
	bh=1Jm5yhD0oYvK8wQ/XTuXJ1uLBf8+bTXgbsYwdwngoqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A4Lrk3ahPXgop4My9Y/qxnpscjwksiL95vRmulgTFOO7KF0+NkkbGds9vVAxlyPNEJL6n2XXN+xbyHQBJWO9Rs5AwjbyUmry1GeHPS/+OAJ3P3AuNzyE0dxsNUQ+J0CX3bBmizRcAgzANbXY0WV5ykeT8pDHoB0N1XgOIjLn69U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLycbW+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3552EC32789;
	Fri,  3 May 2024 08:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714723961;
	bh=1Jm5yhD0oYvK8wQ/XTuXJ1uLBf8+bTXgbsYwdwngoqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LLycbW+JN/OEobD/qwt25tXpyr0LuFz6xI6Dxih/0rXUYG7CCoGAJUHkGwpt5bC7O
	 yrM6Hem/ZmQgTvhREm3QLrPLUty7URXuQOad9ksTGn3Wgon3d1br4UU7FuSjRQ9yGE
	 wvrV06XFKaxwvxEJ6TAjtUJX6Hv6+/9K4ncTdtsIZmZfHd3kmf2mpsD1uF26h54zgq
	 ePZIUz6tZRt76+UFeWZ4o6JOvY3FvSXCYVoWPQEUClDRxliHLMI/00z3TmSbTrAQoe
	 /BQVEmEWezfr59/l0oZVKEDAm9NLiEUWTCVbYjKY0HYEdZVDSCk4tcP1lACJY8tSbc
	 o8L7t95OEtMUg==
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
Subject: [PATCH 13/14] alpha: cabriolet: remove EV5 CPU support
Date: Fri,  3 May 2024 10:11:24 +0200
Message-Id: <20240503081125.67990-14-arnd@kernel.org>
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

The sys_cabriolet.c file includes support for multiple evaluation
boards. pc164 and lx164 are for ev56 CPUs, while the eb164 is
now the last supported machine that only supports ev5 but not
ev56.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/Kconfig                | 15 ++-------------
 arch/alpha/include/asm/irq.h      |  3 +--
 arch/alpha/kernel/Makefile        |  2 --
 arch/alpha/kernel/sys_cabriolet.c | 28 +---------------------------
 4 files changed, 4 insertions(+), 44 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index ee209e895505..7987bb548652 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -91,7 +91,6 @@ choice
 
 	  Alcor/Alpha-XLT     AS 600, AS 500, XL-300, XL-366
 	  DP264               DP264 / DS20 / ES40 / DS10 / DS10L
-	  EB164               EB164 21164 evaluation board
 	  LX164               AlphaPC164-LX
 	  Miata               Personal Workstation 433/500/600 a/au
 	  Marvel              AlphaServer ES47 / ES80 / GS1280
@@ -134,16 +133,6 @@ config ALPHA_DP264
 	  API Networks: 264DP, UP2000(+), CS20;
 	  Compaq: DS10(E,L), XP900, XP1000, DS20(E), ES40.
 
-config ALPHA_EB164
-	bool "EB164"
-	help
-	  EB164 21164 evaluation board from DEC.  Uses 21164 and ALCOR.  Has
-	  ISA and PCI expansion (3 ISA slots, 2 64-bit PCI slots (one is
-	  shared with an ISA slot) and 2 32-bit PCI slots.  Uses plus-in
-	  Bcache SIMMs. I/O sub-system provides SuperI/O (2S, 1P, FD), KBD,
-	  MOUSE (PS2 style), RTC/NVRAM.  Boot ROM is Flash.  PC-AT-sized
-	  motherboard.  Requires power supply with 3.3V output.
-
 config ALPHA_EIGER
 	bool "Eiger"
 	help
@@ -260,7 +249,7 @@ config ALPHA_EV5
 
 config ALPHA_CIA
 	bool
-	depends on ALPHA_MIATA || ALPHA_LX164 || ALPHA_SX164 || ALPHA_RUFFIAN || ALPHA_NORITAKE || ALPHA_MIKASA || ALPHA_PC164 || ALPHA_TAKARA || ALPHA_EB164 || ALPHA_ALCOR
+	depends on ALPHA_MIATA || ALPHA_LX164 || ALPHA_SX164 || ALPHA_RUFFIAN || ALPHA_NORITAKE || ALPHA_MIKASA || ALPHA_PC164 || ALPHA_TAKARA || ALPHA_ALCOR
 	default y
 
 config ALPHA_EV56
@@ -350,7 +339,7 @@ config ALPHA_QEMU
 
 
 config ALPHA_SRM
-	bool "Use SRM as bootloader" if ALPHA_PC164 || ALPHA_TAKARA || ALPHA_EB164 || ALPHA_ALCOR || ALPHA_MIATA || ALPHA_LX164 || ALPHA_SX164 || ALPHA_NAUTILUS
+	bool "Use SRM as bootloader" if ALPHA_PC164 || ALPHA_TAKARA || ALPHA_ALCOR || ALPHA_MIATA || ALPHA_LX164 || ALPHA_SX164 || ALPHA_NAUTILUS
 	depends on TTY
 	default y if ALPHA_MIKASA || ALPHA_SABLE || ALPHA_NORITAKE || ALPHA_DP264 || ALPHA_RAWHIDE || ALPHA_EIGER || ALPHA_WILDFIRE || ALPHA_TITAN || ALPHA_SHARK || ALPHA_MARVEL
 	help
diff --git a/arch/alpha/include/asm/irq.h b/arch/alpha/include/asm/irq.h
index e7d22357a5a6..d83b26b6660f 100644
--- a/arch/alpha/include/asm/irq.h
+++ b/arch/alpha/include/asm/irq.h
@@ -31,8 +31,7 @@
 #  define NR_IRQS      (32768 + 16)    /* marvel - 32 pids */
 # endif
 
-#elif defined(CONFIG_ALPHA_EB164)     || \
-      defined(CONFIG_ALPHA_PC164)     || \
+#elif defined(CONFIG_ALPHA_PC164)     || \
       defined(CONFIG_ALPHA_LX164)
 # define NR_IRQS	35
 
diff --git a/arch/alpha/kernel/Makefile b/arch/alpha/kernel/Makefile
index bd5d62fa4a9a..b6c862dff1f6 100644
--- a/arch/alpha/kernel/Makefile
+++ b/arch/alpha/kernel/Makefile
@@ -60,8 +60,6 @@ obj-$(CONFIG_ALPHA_WILDFIRE)	+= core_wildfire.o
 
 # Board support
 obj-$(CONFIG_ALPHA_ALCOR)	+= sys_alcor.o irq_i8259.o irq_srm.o
-obj-$(CONFIG_ALPHA_EB164)	+= sys_cabriolet.o irq_i8259.o irq_srm.o \
-				   pc873xx.o
 obj-$(CONFIG_ALPHA_LX164)	+= sys_cabriolet.o irq_i8259.o irq_srm.o \
 				   smc37c93x.o
 obj-$(CONFIG_ALPHA_PC164)	+= sys_cabriolet.o irq_i8259.o irq_srm.o \
diff --git a/arch/alpha/kernel/sys_cabriolet.c b/arch/alpha/kernel/sys_cabriolet.c
index 06a950072f82..54e75d4fdbe3 100644
--- a/arch/alpha/kernel/sys_cabriolet.c
+++ b/arch/alpha/kernel/sys_cabriolet.c
@@ -6,8 +6,7 @@
  *	Copyright (C) 1996 Jay A Estabrook
  *	Copyright (C) 1998, 1999, 2000 Richard Henderson
  *
- * Code supporting the Cabriolet (AlphaPC64), EB66+, and EB164,
- * PC164 and LX164.
+ * Code supporting the PC164 and LX164.
  */
 
 #include <linux/kernel.h>
@@ -308,31 +307,6 @@ alphapc164_init_pci(void)
  * The System Vector
  */
 
-#if defined(CONFIG_ALPHA_GENERIC) || defined(CONFIG_ALPHA_EB164)
-struct alpha_machine_vector eb164_mv __initmv = {
-	.vector_name		= "EB164",
-	DO_EV5_MMU,
-	DO_DEFAULT_RTC,
-	DO_CIA_IO,
-	.machine_check		= cia_machine_check,
-	.max_isa_dma_address	= ALPHA_MAX_ISA_DMA_ADDRESS,
-	.min_io_address		= DEFAULT_IO_BASE,
-	.min_mem_address	= CIA_DEFAULT_MEM_BASE,
-
-	.nr_irqs		= 35,
-	.device_interrupt	= cabriolet_device_interrupt,
-
-	.init_arch		= cia_init_arch,
-	.init_irq		= cabriolet_init_irq,
-	.init_rtc		= common_init_rtc,
-	.init_pci		= cia_cab_init_pci,
-	.kill_arch		= cia_kill_arch,
-	.pci_map_irq		= cabriolet_map_irq,
-	.pci_swizzle		= common_swizzle,
-};
-ALIAS_MV(eb164)
-#endif
-
 #if defined(CONFIG_ALPHA_GENERIC) || defined(CONFIG_ALPHA_LX164)
 struct alpha_machine_vector lx164_mv __initmv = {
 	.vector_name		= "LX164",
-- 
2.39.2


