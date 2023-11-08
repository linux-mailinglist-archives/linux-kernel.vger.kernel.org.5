Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B462A7E5726
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 14:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbjKHNBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 08:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235652AbjKHNBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 08:01:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6563A1FD3;
        Wed,  8 Nov 2023 05:01:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F555C433CC;
        Wed,  8 Nov 2023 13:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699448493;
        bh=8DpN0VlV8K0lsnX0jmMrJn6Kymi6tbSMkafnHnRNAHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DibXsoaTqClDsrfxEF6YTCHmf235I4T7HCqVtaKAjpPv8VgPEU3X4AUaF1ASprk/m
         weD+C7Ay/0NB6yjSr50XXvaJ5uTmd+LY00KBbUnVkEX7yF5CwlNDuaqYEOmUpdQRC8
         fx5xBIsRtMo/aqDY0+zoYmD+5w9Fiqhy9IIhFJSgdWz6H2xuqbrvux8ZIcp8+EMwoT
         JpiE4JyUZmE9fBObjEeuKItp5JK71O3s7lLVEvMpV/TsKTME/wbTew8fpQcfi2Rx2b
         5fTvleCWpucJRTv0OM5lInLKMpnGhVyH3Cxd8iUqz4UTYm+qzeRi5SjUZgPgXeaAW+
         aI/4daUSnxQJw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Guo Ren <guoren@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Geoff Levand <geoff@infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Helge Deller <deller@gmx.de>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Timur Tabi <timur@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        David Woodhouse <dwmw2@infradead.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-trace-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        netdev@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-bcachefs@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: [PATCH 10/22] microblaze: include linux/cpu.h for trap_init() prototype
Date:   Wed,  8 Nov 2023 13:58:31 +0100
Message-Id: <20231108125843.3806765-11-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231108125843.3806765-1-arnd@kernel.org>
References: <20231108125843.3806765-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Microblaze runs into a single -Wmissing-prototypes warning when that is
enabled:

arch/microblaze/kernel/traps.c:21:6: warning: no previous prototype for 'trap_init' [-Wmissing-prototypes]

Include the right header to avoid this.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/kernel/traps.c      | 1 +
 arch/csky/include/asm/traps.h  | 2 --
 arch/csky/kernel/traps.c       | 1 +
 arch/m68k/coldfire/vectors.c   | 3 +--
 arch/m68k/coldfire/vectors.h   | 3 ---
 arch/microblaze/kernel/traps.c | 1 +
 arch/sparc/kernel/traps_32.c   | 1 +
 arch/sparc/kernel/traps_64.c   | 1 +
 arch/x86/include/asm/traps.h   | 1 -
 arch/x86/kernel/traps.c        | 1 +
 10 files changed, 7 insertions(+), 8 deletions(-)
 delete mode 100644 arch/m68k/coldfire/vectors.h

diff --git a/arch/alpha/kernel/traps.c b/arch/alpha/kernel/traps.c
index d9a67b370e04..7fc72aeb7398 100644
--- a/arch/alpha/kernel/traps.c
+++ b/arch/alpha/kernel/traps.c
@@ -9,6 +9,7 @@
  * This file initializes the trap entry points
  */
 
+#include <linux/cpu.h>
 #include <linux/jiffies.h>
 #include <linux/mm.h>
 #include <linux/sched/signal.h>
diff --git a/arch/csky/include/asm/traps.h b/arch/csky/include/asm/traps.h
index 732c4aaa2e26..495ce318d569 100644
--- a/arch/csky/include/asm/traps.h
+++ b/arch/csky/include/asm/traps.h
@@ -55,6 +55,4 @@ asmlinkage void trap_c(struct pt_regs *regs);
 asmlinkage void do_notify_resume(struct pt_regs *regs,
 			unsigned long thread_info_flags);
 
-void trap_init(void);
-
 #endif /* __ASM_CSKY_TRAPS_H */
diff --git a/arch/csky/kernel/traps.c b/arch/csky/kernel/traps.c
index 6e426fba0119..c2246b07cc9c 100644
--- a/arch/csky/kernel/traps.c
+++ b/arch/csky/kernel/traps.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
 
+#include <linux/cpu.h>
 #include <linux/sched.h>
 #include <linux/signal.h>
 #include <linux/kernel.h>
diff --git a/arch/m68k/coldfire/vectors.c b/arch/m68k/coldfire/vectors.c
index c26c255b530d..4321fd89d83e 100644
--- a/arch/m68k/coldfire/vectors.c
+++ b/arch/m68k/coldfire/vectors.c
@@ -12,14 +12,13 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/irq.h>
+#include <linux/cpu.h>
 #include <asm/traps.h>
 #include <asm/machdep.h>
 #include <asm/coldfire.h>
 #include <asm/mcfsim.h>
 #include <asm/mcfwdebug.h>
 
-#include "vectors.h"
-
 /***************************************************************************/
 
 #ifdef TRAP_DBG_INTERRUPT
diff --git a/arch/m68k/coldfire/vectors.h b/arch/m68k/coldfire/vectors.h
deleted file mode 100644
index 0b01450a4353..000000000000
--- a/arch/m68k/coldfire/vectors.h
+++ /dev/null
@@ -1,3 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-
-void trap_init(void);
diff --git a/arch/microblaze/kernel/traps.c b/arch/microblaze/kernel/traps.c
index 94b6fe93147d..080aa769218d 100644
--- a/arch/microblaze/kernel/traps.c
+++ b/arch/microblaze/kernel/traps.c
@@ -8,6 +8,7 @@
  * for more details.
  */
 
+#include <linux/cpu.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/kallsyms.h>
diff --git a/arch/sparc/kernel/traps_32.c b/arch/sparc/kernel/traps_32.c
index 179aabfa712e..bb149f6cc34b 100644
--- a/arch/sparc/kernel/traps_32.c
+++ b/arch/sparc/kernel/traps_32.c
@@ -10,6 +10,7 @@
  * I hate traps on the sparc, grrr...
  */
 
+#include <linux/cpu.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/debug.h>
 #include <linux/mm_types.h>
diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 08ffd17d5ec3..3631899f2394 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -9,6 +9,7 @@
  * I like traps on v9, :))))
  */
 
+#include <linux/cpu.h>
 #include <linux/extable.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/debug.h>
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index b1c9cea6ba88..1f1deaecd364 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -14,7 +14,6 @@
 asmlinkage __visible notrace struct pt_regs *sync_regs(struct pt_regs *eregs);
 asmlinkage __visible notrace
 struct pt_regs *fixup_bad_iret(struct pt_regs *bad_regs);
-void __init trap_init(void);
 asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *eregs);
 #endif
 
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c876f1d36a81..b0737a15c470 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -37,6 +37,7 @@
 #include <linux/nmi.h>
 #include <linux/mm.h>
 #include <linux/smp.h>
+#include <linux/cpu.h>
 #include <linux/io.h>
 #include <linux/hardirq.h>
 #include <linux/atomic.h>
-- 
2.39.2

