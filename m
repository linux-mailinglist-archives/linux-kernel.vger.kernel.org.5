Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A95E7E574A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 14:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344728AbjKHNCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 08:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344503AbjKHNCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 08:02:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AADC1BFE;
        Wed,  8 Nov 2023 05:02:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E8DC43397;
        Wed,  8 Nov 2023 13:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699448535;
        bh=UvBPZEJ0GDnePlbmzB0O0cDDu9OzrTkPFQ7DKq1zNkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Epprvhuyn/gmt9yYVzPoCkJkX/4PqBjsFbfCBlqRIyfGB7iy3AzKDVy3tfX2i0XXF
         Uy4x1CCfvni7goWMiP4v7HdeMb5yfs4ydCq+36VNit3V94qDapD8SvovUb+ohVp1et
         UhdhipGmJ7EHGHSkOqI5i8Hak88gF8jqNrCtQpZTJOXqHPzDJ+iCDdgRGZpDIrVPaZ
         ov5jBAtAW7R5L6RqLgkfu5E5wsqOLFuyPmlC3Db/LK9+M2lHinUmbjU0FtGhZLEoPM
         ZbML4CXxxu+staTE/ur5oc+p4xlYSa/kEtSdVRB35t+3iMdtfN2kTDnPjbfH98gprI
         ufK7ZluHODiPw==
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
Subject: [PATCH 13/22] arch: add do_page_fault prototypes
Date:   Wed,  8 Nov 2023 13:58:34 +0100
Message-Id: <20231108125843.3806765-14-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231108125843.3806765-1-arnd@kernel.org>
References: <20231108125843.3806765-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

arch/alpha/mm/fault.c:85:1: error: no previous prototype for 'do_page_fault' [-Werror=missing-prototypes]
arch/csky/mm/fault.c:187:17: error: no previous prototype for 'do_page_fault' [-Werror=missing-prototypes]
arch/mips/mm/fault.c:323:17: error: no previous prototype for 'do_page_fault' [-Werror=missing-prototypes]
arch/nios2/mm/fault.c:43:17: error: no previous prototype for 'do_page_fault' [-Werror=missing-prototypes]
arch/sh/mm/fault.c:389:27: error: no previous prototype for 'do_page_fault' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/include/asm/mmu_context.h | 2 ++
 arch/csky/include/asm/traps.h        | 2 ++
 arch/mips/include/asm/traps.h        | 3 +++
 arch/nios2/include/asm/traps.h       | 2 ++
 arch/sh/include/asm/traps_32.h       | 3 +++
 5 files changed, 12 insertions(+)

diff --git a/arch/alpha/include/asm/mmu_context.h b/arch/alpha/include/asm/mmu_context.h
index 4eea7c616992..29a3e3a1f02b 100644
--- a/arch/alpha/include/asm/mmu_context.h
+++ b/arch/alpha/include/asm/mmu_context.h
@@ -183,6 +183,8 @@ ev4_switch_mm(struct mm_struct *prev_mm, struct mm_struct *next_mm,
 }
 
 extern void __load_new_mm_context(struct mm_struct *);
+asmlinkage void do_page_fault(unsigned long address, unsigned long mmcsr,
+			      long cause, struct pt_regs *regs);
 
 #ifdef CONFIG_SMP
 #define check_mmu_context()					\
diff --git a/arch/csky/include/asm/traps.h b/arch/csky/include/asm/traps.h
index 495ce318d569..6bbbbe43165f 100644
--- a/arch/csky/include/asm/traps.h
+++ b/arch/csky/include/asm/traps.h
@@ -55,4 +55,6 @@ asmlinkage void trap_c(struct pt_regs *regs);
 asmlinkage void do_notify_resume(struct pt_regs *regs,
 			unsigned long thread_info_flags);
 
+asmlinkage void do_page_fault(struct pt_regs *regs);
+
 #endif /* __ASM_CSKY_TRAPS_H */
diff --git a/arch/mips/include/asm/traps.h b/arch/mips/include/asm/traps.h
index 15cde638b407..d4d9f8a8fdea 100644
--- a/arch/mips/include/asm/traps.h
+++ b/arch/mips/include/asm/traps.h
@@ -39,4 +39,7 @@ extern char except_vec_nmi[];
 	register_nmi_notifier(&fn##_nb);				\
 })
 
+asmlinkage void do_page_fault(struct pt_regs *regs,
+	unsigned long write, unsigned long address);
+
 #endif /* _ASM_TRAPS_H */
diff --git a/arch/nios2/include/asm/traps.h b/arch/nios2/include/asm/traps.h
index 82a48473280d..afd77bef01c6 100644
--- a/arch/nios2/include/asm/traps.h
+++ b/arch/nios2/include/asm/traps.h
@@ -14,6 +14,8 @@
 
 #ifndef __ASSEMBLY__
 void _exception(int signo, struct pt_regs *regs, int code, unsigned long addr);
+void do_page_fault(struct pt_regs *regs, unsigned long cause,
+		   unsigned long address);
 #endif
 
 #endif /* _ASM_NIOS2_TRAPS_H */
diff --git a/arch/sh/include/asm/traps_32.h b/arch/sh/include/asm/traps_32.h
index 8c5bbb7b6053..8f14071bea72 100644
--- a/arch/sh/include/asm/traps_32.h
+++ b/arch/sh/include/asm/traps_32.h
@@ -43,6 +43,9 @@ static inline void trigger_address_error(void)
 asmlinkage void do_address_error(struct pt_regs *regs,
 				 unsigned long writeaccess,
 				 unsigned long address);
+asmlinkage void do_page_fault(struct pt_regs *regs,
+			      unsigned long error_code,
+			      unsigned long address);
 asmlinkage void do_divide_error(unsigned long r4);
 asmlinkage void do_reserved_inst(void);
 asmlinkage void do_illegal_slot_inst(void);
-- 
2.39.2

