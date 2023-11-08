Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBD47E5791
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 14:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344668AbjKHNDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 08:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235673AbjKHNDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 08:03:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7DF1FC1;
        Wed,  8 Nov 2023 05:03:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7383C433CD;
        Wed,  8 Nov 2023 13:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699448620;
        bh=bnImJ/ObQ6B/nPGCBESa5sKS25GC8i0wwxIop7YcLiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fB+20slfPiqKAzspVuOp7lysgQWfK95LP/RKlxiC8AEKx8BhFN4kkk4QP6uLjjcZa
         wj1ifWdy+iqHN8jUfTP7LMVixMNQzf+PdxJ5aRFwn8+sF8x5oxrMJ+cw7Tf1SY6evs
         aTHloPIblEvwjvbG5tJspyjJPZMcOELbwuprmNsKC8br0ev0EeD+X5Pv+YyMMBcX7a
         fT29jHc3T0fxWzZcbGd7mitVkS7vZsG9opCG70PpS8kj6ljhs3UbNxZWIByHhdYChg
         /Twm4eSdr3h6kTuBlQTn9xPE9UHRMNkG+6odLROmc+7rhVe0JD5IS0bLdAqqjskcMv
         HeN+BJ0kN316g==
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
Subject: [PATCH 19/22] powerpc: powermac: mark smp_psurge_{give,take}_timebase static
Date:   Wed,  8 Nov 2023 13:58:40 +0100
Message-Id: <20231108125843.3806765-20-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231108125843.3806765-1-arnd@kernel.org>
References: <20231108125843.3806765-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

These functions are only called locally and should be static like the
other corresponding functions are:

arch/powerpc/platforms/powermac/smp.c:416:13: error: no previous prototype for 'smp_psurge_take_timebase' [-Werror=missing-prototypes]
  416 | void __init smp_psurge_take_timebase(void)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/platforms/powermac/smp.c:432:13: error: no previous prototype for 'smp_psurge_give_timebase' [-Werror=missing-prototypes]
  432 | void __init smp_psurge_give_timebase(void)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/powermac/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index c83d1e14077e..15644be31990 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -413,7 +413,7 @@ static void __init smp_psurge_setup_cpu(int cpu_nr)
 		printk(KERN_ERR "Couldn't get primary IPI interrupt");
 }
 
-void __init smp_psurge_take_timebase(void)
+static void __init smp_psurge_take_timebase(void)
 {
 	if (psurge_type != PSURGE_DUAL)
 		return;
@@ -429,7 +429,7 @@ void __init smp_psurge_take_timebase(void)
 	set_dec(tb_ticks_per_jiffy/2);
 }
 
-void __init smp_psurge_give_timebase(void)
+static void __init smp_psurge_give_timebase(void)
 {
 	/* Nothing to do here */
 }
-- 
2.39.2

