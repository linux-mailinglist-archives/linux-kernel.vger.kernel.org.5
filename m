Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD6A7973C6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242867AbjIGP3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244578AbjIGP1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:27:53 -0400
Received: from riemann.telenet-ops.be (riemann.telenet-ops.be [IPv6:2a02:1800:110:4::f00:10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A3910FC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:27:28 -0700 (PDT)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by riemann.telenet-ops.be (Postfix) with ESMTPS id 4RhL540s8fz4x37j
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 15:42:00 +0200 (CEST)
Received: from ramsan.of.borg ([84.195.187.55])
        by andre.telenet-ops.be with bizsmtp
        id j1hy2A00b1C8whw011hyGH; Thu, 07 Sep 2023 15:42:00 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGR-002mB2-7Q;
        Thu, 07 Sep 2023 15:41:58 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGg-00CMjB-Fk;
        Thu, 07 Sep 2023 15:41:58 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Finn Thain <fthain@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Philip Blundell <philb@gnu.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Sam Creasey <sammy@sammy.net>,
        Laurent Vivier <laurent@vivier.eu>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 52/52] m68k: sun3/3x: Add and use "sun3.h"
Date:   Thu,  7 Sep 2023 15:41:53 +0200
Message-Id: <c9ba16f87e056c53ad0bd0ad6fe79e61b1a2e425.1694093327.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694093327.git.geert@linux-m68k.org>
References: <cover.1694093327.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with W=1:

    arch/m68k/sun3/idprom.c:86:6: warning: no previous prototype for ‘sun3_get_model’ [-Wmissing-prototypes]
       86 | void sun3_get_model(char *model)
	  |      ^~~~~~~~~~~~~~
    arch/m68k/sun3/config.c:53:24: warning: no previous prototype for ‘sun3_init’ [-Wmissing-prototypes]
       53 | asmlinkage void __init sun3_init(void)
	  |                        ^~~~~~~~~
    arch/m68k/sun3/mmu_emu.c:117:6: warning: no previous prototype for ‘print_pte_vaddr’ [-Wmissing-prototypes]
      117 | void print_pte_vaddr (unsigned long vaddr)
	  |      ^~~~~~~~~~~~~~~
    arch/m68k/sun3/mmu_emu.c:126:13: warning: no previous prototype for ‘mmu_emu_init’ [-Wmissing-prototypes]
      126 | void __init mmu_emu_init(unsigned long bootmem_end)
	  |             ^~~~~~~~~~~~
    arch/m68k/sun3/mmu_emu.c:353:5: warning: no previous prototype for ‘mmu_emu_handle_fault’ [-Wmissing-prototypes]
      353 | int mmu_emu_handle_fault (unsigned long vaddr, int read_flag, int kernel_fault)
	  |     ^~~~~~~~~~~~~~~~~~~~
    arch/m68k/sun3/leds.c:6:6: warning: no previous prototype for ‘sun3_leds’ [-Wmissing-prototypes]
	6 | void sun3_leds(unsigned char byte)
	  |      ^~~~~~~~~
    arch/m68k/sun3/intersil.c:27:5: warning: no previous prototype for ‘sun3_hwclk’ [-Wmissing-prototypes]
       27 | int sun3_hwclk(int set, struct rtc_time *t)
	  |     ^~~~~~~~~~
    arch/m68k/sun3x/config.c:30:6: warning: no previous prototype for ‘sun3_leds’ [-Wmissing-prototypes]
       30 | void sun3_leds(unsigned char byte)
	  |      ^~~~~~~~~

Fix this by introducing a new header file "sun3.h" for holding the
prototypes of functions implemented in arch/m68k/sun3/ and
arch/m68k/sun3x/.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/kernel/traps.c  |  2 +-
 arch/m68k/mm/sun3kmap.c   |  6 ++----
 arch/m68k/mm/sun3mmu.c    |  2 +-
 arch/m68k/sun3/config.c   |  4 ++--
 arch/m68k/sun3/idprom.c   |  2 ++
 arch/m68k/sun3/intersil.c |  1 +
 arch/m68k/sun3/leds.c     |  2 ++
 arch/m68k/sun3/mmu_emu.c  |  1 +
 arch/m68k/sun3/sun3.h     | 22 ++++++++++++++++++++++
 arch/m68k/sun3/sun3ints.c |  2 +-
 arch/m68k/sun3x/config.c  |  3 +--
 11 files changed, 36 insertions(+), 11 deletions(-)
 create mode 100644 arch/m68k/sun3/sun3.h

diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
index 129c89349e1a40aa..8ee773d29954921c 100644
--- a/arch/m68k/kernel/traps.c
+++ b/arch/m68k/kernel/traps.c
@@ -364,7 +364,7 @@ static inline void access_error040(struct frame *fp)
 #if defined(CONFIG_SUN3)
 #include <asm/sun3mmu.h>
 
-extern int mmu_emu_handle_fault (unsigned long, int, int);
+#include "../sun3/sun3.h"
 
 /* sun3 version of bus_error030 */
 
diff --git a/arch/m68k/mm/sun3kmap.c b/arch/m68k/mm/sun3kmap.c
index 4f2a7ef8348bc1a6..ac091892d82f8a06 100644
--- a/arch/m68k/mm/sun3kmap.c
+++ b/arch/m68k/mm/sun3kmap.c
@@ -18,11 +18,9 @@
 #include <asm/io.h>
 #include <asm/sun3mmu.h>
 
-#undef SUN3_KMAP_DEBUG
+#include "../sun3/sun3.h"
 
-#ifdef SUN3_KMAP_DEBUG
-extern void print_pte_vaddr(unsigned long vaddr);
-#endif
+#undef SUN3_KMAP_DEBUG
 
 extern void mmu_emu_map_pmeg (int context, int vaddr);
 
diff --git a/arch/m68k/mm/sun3mmu.c b/arch/m68k/mm/sun3mmu.c
index c5e6a23e0262128d..494739c1783e4dea 100644
--- a/arch/m68k/mm/sun3mmu.c
+++ b/arch/m68k/mm/sun3mmu.c
@@ -24,7 +24,7 @@
 #include <asm/machdep.h>
 #include <asm/io.h>
 
-extern void mmu_emu_init (unsigned long bootmem_end);
+#include "../sun3/sun3.h"
 
 const char bad_pmd_string[] = "Bad pmd in pte_alloc: %08lx\n";
 
diff --git a/arch/m68k/sun3/config.c b/arch/m68k/sun3/config.c
index 40796c3e84400def..cd8af809e0cad1e4 100644
--- a/arch/m68k/sun3/config.c
+++ b/arch/m68k/sun3/config.c
@@ -35,11 +35,11 @@
 #include <asm/sun3ints.h>
 #include <asm/config.h>
 
+#include "sun3.h"
+
 char sun3_reserved_pmeg[SUN3_PMEGS_NUM];
 
 static void sun3_sched_init(void);
-extern void sun3_get_model (char* model);
-extern int sun3_hwclk(int set, struct rtc_time *t);
 
 volatile char* clock_va;
 extern unsigned long availmem;
diff --git a/arch/m68k/sun3/idprom.c b/arch/m68k/sun3/idprom.c
index 9ffd6515ad74a7fa..ca633a5f5eb1281a 100644
--- a/arch/m68k/sun3/idprom.c
+++ b/arch/m68k/sun3/idprom.c
@@ -17,6 +17,8 @@
 #include <asm/idprom.h>
 #include <asm/machines.h>  /* Fun with Sun released architectures. */
 
+#include "sun3.h"
+
 struct idprom *idprom;
 EXPORT_SYMBOL(idprom);
 
diff --git a/arch/m68k/sun3/intersil.c b/arch/m68k/sun3/intersil.c
index 8fc74864de81962b..29674cfa9bb3aa35 100644
--- a/arch/m68k/sun3/intersil.c
+++ b/arch/m68k/sun3/intersil.c
@@ -17,6 +17,7 @@
 #include <asm/intersil.h>
 #include <asm/machdep.h>
 
+#include "sun3.h"
 
 /* bits to set for start/run of the intersil */
 #define STOP_VAL (INTERSIL_STOP | INTERSIL_INT_ENABLE | INTERSIL_24H_MODE)
diff --git a/arch/m68k/sun3/leds.c b/arch/m68k/sun3/leds.c
index 7c67b58ebf13fa4a..4bb95318fd548302 100644
--- a/arch/m68k/sun3/leds.c
+++ b/arch/m68k/sun3/leds.c
@@ -3,6 +3,8 @@
 #include <asm/sun3mmu.h>
 #include <asm/io.h>
 
+#include "sun3.h"
+
 void sun3_leds(unsigned char byte)
 {
 	unsigned char dfc;
diff --git a/arch/m68k/sun3/mmu_emu.c b/arch/m68k/sun3/mmu_emu.c
index 7ec9bbf8a3644a10..e5a92da43d1978df 100644
--- a/arch/m68k/sun3/mmu_emu.c
+++ b/arch/m68k/sun3/mmu_emu.c
@@ -27,6 +27,7 @@
 #include <asm/mmu_context.h>
 #include <asm/dvma.h>
 
+#include "sun3.h"
 
 #undef DEBUG_MMU_EMU
 #define DEBUG_PROM_MAPS
diff --git a/arch/m68k/sun3/sun3.h b/arch/m68k/sun3/sun3.h
new file mode 100644
index 0000000000000000..8d98c0aaedc0c686
--- /dev/null
+++ b/arch/m68k/sun3/sun3.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/linkage.h>
+
+struct rtc_time;
+
+/* config.c */
+asmlinkage void sun3_init(void);
+
+/* idprom.c */
+void sun3_get_model(char *model);
+
+/* intersil.c */
+int sun3_hwclk(int set, struct rtc_time *t);
+
+/* leds.c */
+void sun3_leds(unsigned char byte);
+
+/* mmu_emu.c */
+void mmu_emu_init(unsigned long bootmem_end);
+int mmu_emu_handle_fault(unsigned long vaddr, int read_flag, int kernel_fault);
+void print_pte_vaddr(unsigned long vaddr);
diff --git a/arch/m68k/sun3/sun3ints.c b/arch/m68k/sun3/sun3ints.c
index 36cc280a4505f5d2..781e7c0a6f523a2b 100644
--- a/arch/m68k/sun3/sun3ints.c
+++ b/arch/m68k/sun3/sun3ints.c
@@ -17,7 +17,7 @@
 #include <asm/irq_regs.h>
 #include <linux/seq_file.h>
 
-extern void sun3_leds (unsigned char);
+#include "sun3.h"
 
 void sun3_disable_interrupts(void)
 {
diff --git a/arch/m68k/sun3x/config.c b/arch/m68k/sun3x/config.c
index e2a5d84df6d214d1..798ea72a0ea3c3e2 100644
--- a/arch/m68k/sun3x/config.c
+++ b/arch/m68k/sun3x/config.c
@@ -22,11 +22,10 @@
 #include <asm/config.h>
 
 #include "time.h"
+#include "../sun3/sun3.h"
 
 volatile char *clock_va;
 
-extern void sun3_get_model(char *model);
-
 void sun3_leds(unsigned char byte)
 {
 
-- 
2.34.1

