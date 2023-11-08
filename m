Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACD77E5718
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 14:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344738AbjKHNBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 08:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344701AbjKHNBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 08:01:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A421BFF;
        Wed,  8 Nov 2023 05:01:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBCE6C433C8;
        Wed,  8 Nov 2023 13:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699448477;
        bh=+ok2KiNpPUMGFu8Hb2aaGxbpAXXqdF0nd2Kz+6ZsY30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZHXtATMuavdncqkz87p+2tvJYAeqnoXQjQs5NE1bsCCOtbQdulJkAhoQ125PPohOz
         JhoB5oZ+lcpGsix9e17Q+ywyhAQ/oxjlmWB04WHi+5RV5DE/3JW1588ZlT0gC+91PI
         9bbRHw+timWeM1qty7E7aah+l9eyIkhUOTIIUGfQXNjJjdaPJb6An1/cy5mCl2SG8N
         clXs12SEadbHQWq+FTm4drR1JP6LZdB+NroSIF501ylowL0AoCsuwTPnL6UYPR5bKI
         LqWgv5tSTcSLAJc47F2i6FBa6cfKr3InGHxmZ66g1vbpQhxNObrMJJKegEsQWjlYxy
         XtBY3J7JluUkg==
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
Subject: [PATCH 09/22] [v2] arch: fix asm-offsets.c building with -Wmissing-prototypes
Date:   Wed,  8 Nov 2023 13:58:30 +0100
Message-Id: <20231108125843.3806765-10-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231108125843.3806765-1-arnd@kernel.org>
References: <20231108125843.3806765-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When -Wmissing-prototypes is enabled, the some asm-offsets.c files fail
to build, even when this warning is disabled in the Makefile for normal
files:

arch/sparc/kernel/asm-offsets.c:22:5: error: no previous prototype for 'sparc32_foo' [-Werror=missing-prototypes]
arch/sparc/kernel/asm-offsets.c:48:5: error: no previous prototype for 'foo' [-Werror=missing-prototypes]

Address this by making use of the same trick as x86, marking these
functions as 'static __used' to avoid the need for a prototype
by not drop them in dead-code elimination.

Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Link: https://lore.kernel.org/lkml/CAK7LNARfEmFk0Du4Hed19eX_G6tUC5wG0zP+L1AyvdpOF4ybXQ@mail.gmail.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: rewrite using a different approach
---
 arch/alpha/kernel/asm-offsets.c     |  2 +-
 arch/loongarch/kernel/asm-offsets.c | 26 +++++++++++++-------------
 arch/sparc/kernel/asm-offsets.c     |  6 +++---
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/alpha/kernel/asm-offsets.c b/arch/alpha/kernel/asm-offsets.c
index b121294bee26..bf1eedd27cf7 100644
--- a/arch/alpha/kernel/asm-offsets.c
+++ b/arch/alpha/kernel/asm-offsets.c
@@ -12,7 +12,7 @@
 #include <linux/kbuild.h>
 #include <asm/io.h>
 
-void foo(void)
+static void __used foo(void)
 {
 	DEFINE(TI_TASK, offsetof(struct thread_info, task));
 	DEFINE(TI_FLAGS, offsetof(struct thread_info, flags));
diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-offsets.c
index 173fe514fc9e..bee9f7a3108f 100644
--- a/arch/loongarch/kernel/asm-offsets.c
+++ b/arch/loongarch/kernel/asm-offsets.c
@@ -15,7 +15,7 @@
 #include <asm/processor.h>
 #include <asm/ftrace.h>
 
-void output_ptreg_defines(void)
+static void __used output_ptreg_defines(void)
 {
 	COMMENT("LoongArch pt_regs offsets.");
 	OFFSET(PT_R0, pt_regs, regs[0]);
@@ -62,7 +62,7 @@ void output_ptreg_defines(void)
 	BLANK();
 }
 
-void output_task_defines(void)
+static void __used output_task_defines(void)
 {
 	COMMENT("LoongArch task_struct offsets.");
 	OFFSET(TASK_STATE, task_struct, __state);
@@ -77,7 +77,7 @@ void output_task_defines(void)
 	BLANK();
 }
 
-void output_thread_info_defines(void)
+static void __used output_thread_info_defines(void)
 {
 	COMMENT("LoongArch thread_info offsets.");
 	OFFSET(TI_TASK, thread_info, task);
@@ -93,7 +93,7 @@ void output_thread_info_defines(void)
 	BLANK();
 }
 
-void output_thread_defines(void)
+static void __used output_thread_defines(void)
 {
 	COMMENT("LoongArch specific thread_struct offsets.");
 	OFFSET(THREAD_REG01, task_struct, thread.reg01);
@@ -129,7 +129,7 @@ void output_thread_defines(void)
 	BLANK();
 }
 
-void output_thread_fpu_defines(void)
+static void __used output_thread_fpu_defines(void)
 {
 	OFFSET(THREAD_FPR0, loongarch_fpu, fpr[0]);
 	OFFSET(THREAD_FPR1, loongarch_fpu, fpr[1]);
@@ -170,7 +170,7 @@ void output_thread_fpu_defines(void)
 	BLANK();
 }
 
-void output_thread_lbt_defines(void)
+static void __used output_thread_lbt_defines(void)
 {
 	OFFSET(THREAD_SCR0,  loongarch_lbt, scr0);
 	OFFSET(THREAD_SCR1,  loongarch_lbt, scr1);
@@ -180,7 +180,7 @@ void output_thread_lbt_defines(void)
 	BLANK();
 }
 
-void output_mm_defines(void)
+static void __used output_mm_defines(void)
 {
 	COMMENT("Size of struct page");
 	DEFINE(STRUCT_PAGE_SIZE, sizeof(struct page));
@@ -212,7 +212,7 @@ void output_mm_defines(void)
 	BLANK();
 }
 
-void output_sc_defines(void)
+static void __used output_sc_defines(void)
 {
 	COMMENT("Linux sigcontext offsets.");
 	OFFSET(SC_REGS, sigcontext, sc_regs);
@@ -220,7 +220,7 @@ void output_sc_defines(void)
 	BLANK();
 }
 
-void output_signal_defines(void)
+static void __used output_signal_defines(void)
 {
 	COMMENT("Linux signal numbers.");
 	DEFINE(_SIGHUP, SIGHUP);
@@ -258,7 +258,7 @@ void output_signal_defines(void)
 }
 
 #ifdef CONFIG_SMP
-void output_smpboot_defines(void)
+static void __used output_smpboot_defines(void)
 {
 	COMMENT("Linux smp cpu boot offsets.");
 	OFFSET(CPU_BOOT_STACK, secondary_data, stack);
@@ -268,7 +268,7 @@ void output_smpboot_defines(void)
 #endif
 
 #ifdef CONFIG_HIBERNATION
-void output_pbe_defines(void)
+static void __used output_pbe_defines(void)
 {
 	COMMENT("Linux struct pbe offsets.");
 	OFFSET(PBE_ADDRESS, pbe, address);
@@ -280,7 +280,7 @@ void output_pbe_defines(void)
 #endif
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-void output_fgraph_ret_regs_defines(void)
+static void __used output_fgraph_ret_regs_defines(void)
 {
 	COMMENT("LoongArch fgraph_ret_regs offsets.");
 	OFFSET(FGRET_REGS_A0, fgraph_ret_regs, regs[0]);
@@ -291,7 +291,7 @@ void output_fgraph_ret_regs_defines(void)
 }
 #endif
 
-void output_kvm_defines(void)
+static void __used output_kvm_defines(void)
 {
 	COMMENT("KVM/LoongArch Specific offsets.");
 
diff --git a/arch/sparc/kernel/asm-offsets.c b/arch/sparc/kernel/asm-offsets.c
index 5784f2df489a..3d9b9855dce9 100644
--- a/arch/sparc/kernel/asm-offsets.c
+++ b/arch/sparc/kernel/asm-offsets.c
@@ -19,14 +19,14 @@
 #include <asm/hibernate.h>
 
 #ifdef CONFIG_SPARC32
-int sparc32_foo(void)
+static int __used sparc32_foo(void)
 {
 	DEFINE(AOFF_thread_fork_kpsr,
 			offsetof(struct thread_struct, fork_kpsr));
 	return 0;
 }
 #else
-int sparc64_foo(void)
+static int __used sparc64_foo(void)
 {
 #ifdef CONFIG_HIBERNATION
 	BLANK();
@@ -45,7 +45,7 @@ int sparc64_foo(void)
 }
 #endif
 
-int foo(void)
+static int __used foo(void)
 {
 	BLANK();
 	DEFINE(AOFF_task_thread, offsetof(struct task_struct, thread));
-- 
2.39.2

