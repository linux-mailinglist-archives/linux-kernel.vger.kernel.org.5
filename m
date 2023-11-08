Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6C17E56F4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 14:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344608AbjKHNAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 08:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235628AbjKHNAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 08:00:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9668E1FC2;
        Wed,  8 Nov 2023 05:00:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3C9C43395;
        Wed,  8 Nov 2023 13:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699448431;
        bh=K9YdPzoARD4njnEo80jUrY+DZkb+0aAdqYzClA8UgAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HyUdTwUXtZOlnyvxdNKc+kj+jb0JvSjpSyNuNfinD/hOMX3R5j5WCRvrkFeKCIoaK
         dck1LhuXouzgxrjEZ+GfXmwACWuIHu7Z5T4tv5Ur3mBUern292mV3o4hHeM6goJmTl
         07hDeR7Iqhwa3/f+qzmGQajf1dFdpx/z/q8jYxJI4nnayQSqsNQMlgpL0fthML/+e1
         RUA1p/Ek88IwoPkFfFrEZT9/Y2MOyc8v/2srZE3JErq77d73XQLbdWL9p5SFFwRzqp
         V4Zk/JhktD/mAeNqOSIIMV3pGJDyvfJKmq7usGaEaG4ltRDerYT+4+zq3kRGWGhqoG
         rX6LOl910Dk3Q==
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
Subject: [PATCH 06/22] [RESEND] stackleak: add declarations for global functions
Date:   Wed,  8 Nov 2023 13:58:27 +0100
Message-Id: <20231108125843.3806765-7-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231108125843.3806765-1-arnd@kernel.org>
References: <20231108125843.3806765-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

With -Wmissing-prototypes enabled, the stackleak code produces a couple of
warnings that have no declarations because they are only called from assembler:

stackleak.c:127:25: error: no previous prototype for 'stackleak_erase' [-Werror=missing-prototypes]
stackleak.c:139:25: error: no previous prototype for 'stackleak_erase_on_task_stack' [-Werror=missing-prototypes]
stackleak.c:151:25: error: no previous prototype for 'stackleak_erase_off_task_stack' [-Werror=missing-prototypes]
stackleak.c:159:49: error: no previous prototype for 'stackleak_track_stack' [-Werror=missing-prototypes]

Add declarations to the stackleak header to shut up the warnings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/stackleak.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/stackleak.h b/include/linux/stackleak.h
index c36e7a3b45e7..3be2cb564710 100644
--- a/include/linux/stackleak.h
+++ b/include/linux/stackleak.h
@@ -14,6 +14,7 @@
 
 #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
 #include <asm/stacktrace.h>
+#include <linux/linkage.h>
 
 /*
  * The lowest address on tsk's stack which we can plausibly erase.
@@ -76,6 +77,11 @@ static inline void stackleak_task_init(struct task_struct *t)
 # endif
 }
 
+asmlinkage void noinstr stackleak_erase(void);
+asmlinkage void noinstr stackleak_erase_on_task_stack(void);
+asmlinkage void noinstr stackleak_erase_off_task_stack(void);
+void __no_caller_saved_registers noinstr stackleak_track_stack(void);
+
 #else /* !CONFIG_GCC_PLUGIN_STACKLEAK */
 static inline void stackleak_task_init(struct task_struct *t) { }
 #endif
-- 
2.39.2

