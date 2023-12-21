Return-Path: <linux-kernel+bounces-8365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F5D81B647
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAA6F1F239C0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0996EB52;
	Thu, 21 Dec 2023 12:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="OKmNKqwg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209DC7319F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 12:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1703162794; x=1734698794;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=opoE9uZiWFk9LaorxyajJzGvmPeTHusLBPzDmEbOtoM=;
  b=OKmNKqwgFUdUHtc9KqFiLA67+W0fvoP/b6OzyO9RPa72hjet8vPpetIr
   NaoGOOhi7W776gkZfhb3sIu8lZpO4AWG6pYoMT/fGCH+XOfrUAx502OAV
   BCPyhcawYeorHT2IXCXZCHEPtGPTG4eeR4SMH2RsniVKcgXXqquXlG5Ge
   qAMKmnEaxo6iWpp1KOtQAZ1UGlSiJ8Ho3tQHaBaTeCKrS7NMFHzG5mWWW
   tbwSHQkb31M2/VcR12CdQaupOvUqvguQ6HHNzA//tpbgXL+7HncGkbJ4A
   Z0RvGgRK+ZiUS4hyT3d7P2XAOJ8WPq3Gb68TZZrcnh3TqRURSLHFrLsjl
   Q==;
X-IronPort-AV: E=Sophos;i="6.04,293,1695679200"; 
   d="scan'208";a="34634644"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 21 Dec 2023 13:46:24 +0100
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.53.15])
	by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 0CC14280075;
	Thu, 21 Dec 2023 13:46:24 +0100 (CET)
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH] powerpc/6xx: set High BAT Enable flag on G2 cores
Date: Thu, 21 Dec 2023 13:45:38 +0100
Message-ID: <20231221124538.159706-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

MMU_FTR_USE_HIGH_BATS is set for G2-based cores (G2_LE, e300cX), but the
high BATs need to be enabled in HID2 to work. Add register definitions
and introduce a G2 variant of __setup_cpu_603.

This fixes boot on CPUs like the MPC5200B with STRICT_KERNEL_RWX enabled.

Fixes: e4d6654ebe6e ("powerpc/mm/32s: rework mmu_mapin_ram()")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 arch/powerpc/include/asm/cpu_setup.h      |  1 +
 arch/powerpc/include/asm/reg.h            |  2 ++
 arch/powerpc/kernel/cpu_setup_6xx.S       | 25 ++++++++++++++++++++++-
 arch/powerpc/kernel/cpu_specs_book3s_32.h | 10 ++++-----
 4 files changed, 32 insertions(+), 6 deletions(-)


I have only tested this on the MPC5200B (G2_LE), but according to the
e300 manual, e300cX cores should behave the same.

The Fixes tag is the best I could come up with - I believe that the
underlying issue of setting USE_HIGH_BATS without actually enabling them
is as old as Linux's PowerPC implementation, but the specific code
causing the boot failure was added in the mentioned commit.

Another issue I found in the code is that
arch/powerpc/platforms/52xx/lite5200_sleep.S uses the SPRN_HID2 definition
which does not refer to HID2 on the 5200... but that will be for someone
else to fix, if there is still anyone left using that platform.


diff --git a/arch/powerpc/include/asm/cpu_setup.h b/arch/powerpc/include/asm/cpu_setup.h
index 30e2fe3895024..68d804e74d221 100644
--- a/arch/powerpc/include/asm/cpu_setup.h
+++ b/arch/powerpc/include/asm/cpu_setup.h
@@ -35,6 +35,7 @@ void __setup_cpu_750fx(unsigned long offset, struct cpu_spec *spec);
 void __setup_cpu_7400(unsigned long offset, struct cpu_spec *spec);
 void __setup_cpu_7410(unsigned long offset, struct cpu_spec *spec);
 void __setup_cpu_745x(unsigned long offset, struct cpu_spec *spec);
+void __setup_cpu_g2(unsigned long offset, struct cpu_spec *spec);
 
 void __setup_cpu_ppc970(unsigned long offset, struct cpu_spec *spec);
 void __setup_cpu_ppc970MP(unsigned long offset, struct cpu_spec *spec);
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 4ae4ab9090a2d..f5641fcd1da85 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -617,6 +617,8 @@
 #endif
 #define SPRN_HID2	0x3F8		/* Hardware Implementation Register 2 */
 #define SPRN_HID2_GEKKO	0x398		/* Gekko HID2 Register */
+#define SPRN_HID2_G2	0x3F3		/* G2 HID2 Register */
+#define  HID2_HBE_G2	(1<<18)		/* High BAT Enable (G2) */
 #define SPRN_IABR	0x3F2	/* Instruction Address Breakpoint Register */
 #define SPRN_IABR2	0x3FA		/* 83xx */
 #define SPRN_IBCR	0x135		/* 83xx Insn Breakpoint Control Reg */
diff --git a/arch/powerpc/kernel/cpu_setup_6xx.S b/arch/powerpc/kernel/cpu_setup_6xx.S
index f29ce3dd6140f..c67d32e04df9c 100644
--- a/arch/powerpc/kernel/cpu_setup_6xx.S
+++ b/arch/powerpc/kernel/cpu_setup_6xx.S
@@ -81,6 +81,20 @@ _GLOBAL(__setup_cpu_745x)
 	bl	setup_745x_specifics
 	mtlr	r5
 	blr
+_GLOBAL(__setup_cpu_g2)
+	mflr	r5
+BEGIN_MMU_FTR_SECTION
+	li	r10,0
+	mtspr	SPRN_SPRG_603_LRU,r10		/* init SW LRU tracking */
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_NEED_DTLB_SW_LRU)
+
+BEGIN_FTR_SECTION
+	bl	__init_fpu_registers
+END_FTR_SECTION_IFCLR(CPU_FTR_FPU_UNAVAILABLE)
+	bl	setup_common_caches
+	bl	setup_g2_hid2
+	mtlr	r5
+	blr
 
 /* Enable caches for 603's, 604, 750 & 7400 */
 SYM_FUNC_START_LOCAL(setup_common_caches)
@@ -115,6 +129,16 @@ SYM_FUNC_START_LOCAL(setup_604_hid0)
 	blr
 SYM_FUNC_END(setup_604_hid0)
 
+/* Enable high BATs for G2 (G2_LE, e300cX) */
+SYM_FUNC_START_LOCAL(setup_g2_hid2)
+	mfspr	r11,SPRN_HID2_G2
+	oris	r11,r11,HID2_HBE_G2@h
+	mtspr	SPRN_HID2_G2,r11
+	sync
+	isync
+	blr
+SYM_FUNC_END(setup_g2_hid2)
+
 /* 7400 <= rev 2.7 and 7410 rev = 1.0 suffer from some
  * erratas we work around here.
  * Moto MPC710CE.pdf describes them, those are errata
@@ -495,4 +519,3 @@ _GLOBAL(__restore_cpu_setup)
 	mtcr	r7
 	blr
 _ASM_NOKPROBE_SYMBOL(__restore_cpu_setup)
-
diff --git a/arch/powerpc/kernel/cpu_specs_book3s_32.h b/arch/powerpc/kernel/cpu_specs_book3s_32.h
index 3714634d194a1..83f054fcf837c 100644
--- a/arch/powerpc/kernel/cpu_specs_book3s_32.h
+++ b/arch/powerpc/kernel/cpu_specs_book3s_32.h
@@ -69,7 +69,7 @@ static struct cpu_spec cpu_specs[] __initdata = {
 		.mmu_features		= MMU_FTR_USE_HIGH_BATS,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.cpu_setup		= __setup_cpu_603,
+		.cpu_setup		= __setup_cpu_g2,
 		.machine_check		= machine_check_generic,
 		.platform		= "ppc603",
 	},
@@ -83,7 +83,7 @@ static struct cpu_spec cpu_specs[] __initdata = {
 		.mmu_features		= MMU_FTR_USE_HIGH_BATS,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.cpu_setup		= __setup_cpu_603,
+		.cpu_setup		= __setup_cpu_g2,
 		.machine_check		= machine_check_83xx,
 		.platform		= "ppc603",
 	},
@@ -96,7 +96,7 @@ static struct cpu_spec cpu_specs[] __initdata = {
 		.mmu_features		= MMU_FTR_USE_HIGH_BATS | MMU_FTR_NEED_DTLB_SW_LRU,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.cpu_setup		= __setup_cpu_603,
+		.cpu_setup		= __setup_cpu_g2,
 		.machine_check		= machine_check_83xx,
 		.platform		= "ppc603",
 	},
@@ -109,7 +109,7 @@ static struct cpu_spec cpu_specs[] __initdata = {
 		.mmu_features		= MMU_FTR_USE_HIGH_BATS | MMU_FTR_NEED_DTLB_SW_LRU,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.cpu_setup		= __setup_cpu_603,
+		.cpu_setup		= __setup_cpu_g2,
 		.machine_check		= machine_check_83xx,
 		.num_pmcs		= 4,
 		.platform		= "ppc603",
@@ -123,7 +123,7 @@ static struct cpu_spec cpu_specs[] __initdata = {
 		.mmu_features		= MMU_FTR_USE_HIGH_BATS | MMU_FTR_NEED_DTLB_SW_LRU,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.cpu_setup		= __setup_cpu_603,
+		.cpu_setup		= __setup_cpu_g2,
 		.machine_check		= machine_check_83xx,
 		.num_pmcs		= 4,
 		.platform		= "ppc603",
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

