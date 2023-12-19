Return-Path: <linux-kernel+bounces-6029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17107819350
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C27EB284488
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C84757316;
	Tue, 19 Dec 2023 22:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8k9tG6i"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE1040BFC;
	Tue, 19 Dec 2023 22:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90686C116B6;
	Tue, 19 Dec 2023 22:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703023396;
	bh=Xx5e5JXE5o3eSx1BDCkTaoAn1nu0Tcx74g9aZDg0gdg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=u8k9tG6iBmhBCtOjUZAoi5aPfizQ3FYNoD/I2iLaI20nlTBj0mVS07YAPto+7abY+
	 aQdvyxNU+nsIpscUGSpQ05lqt5JYbMeHh3ZFiNorItQwD8lfq5Zbtlr7xLmrNz+pk1
	 eIHPfRjJTOotDHzAULpIJbx1HIR/5KPbc1Zy5N9C80RBn4cxrk4N6EdIE/C1eOcmJG
	 UurNyNIAzmI9BPdsS8xS/6dY23M1CyWfXEFIft9RTzs+vHvmf4Om/8AkRJOee2ZUQt
	 JwXbAFrqIT39HzdThRb37oV4Ak9nEPJ+zRNfN6By98SdDfVYskgEtJv2Y2wcWHcZMM
	 ENIEQdSNp7KCQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80118C46CD2;
	Tue, 19 Dec 2023 22:03:16 +0000 (UTC)
From: Sam Ravnborg via B4 Relay <devnull+sam.ravnborg.org@kernel.org>
Date: Tue, 19 Dec 2023 23:03:28 +0100
Subject: [PATCH 23/27] sparc32: Drop unused trampoline code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-sam-sparc32-sunset-v3-v1-23-64bb44b598c5@ravnborg.org>
References: <20231219-sam-sparc32-sunset-v3-v1-0-64bb44b598c5@ravnborg.org>
In-Reply-To: <20231219-sam-sparc32-sunset-v3-v1-0-64bb44b598c5@ravnborg.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Arnd Bergmann <arnd@kernel.org>, Andreas Larsson <andreas@gaisler.com>
Cc: Helge Deller <deller@gmx.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Alan Stern <stern@rowland.harvard.edu>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, sparclinux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-sound@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703023392; l=4127;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=uzksINTbhFvBhLNvlUDgb4UOBHR2yU8G2Z2Ss1msiEI=; =?utf-8?q?b=3DIu2To745+yyR?=
 =?utf-8?q?3EXnr2Zb0eY4uBlUFnm81YV0HjegE5uRvg7LKgAC0vaYfDXXenG6hZOVFuslEMQx?=
 fAACjGtqBIxq2YSBw8iT3MawaikYyK0oFDUMkVfpYUZAPSnF0xtb
X-Developer-Key: i=sam@ravnborg.org; a=ed25519;
 pk=R0+pqV7BRYOAeOIGkyOrSNke7arx5y3LkEuNi37YEyU=
X-Endpoint-Received: by B4 Relay for sam@ravnborg.org/20230107 with auth_id=22
X-Original-From: Sam Ravnborg <sam@ravnborg.org>
Reply-To: <sam@ravnborg.org>

From: Sam Ravnborg <sam@ravnborg.org>

Drop the sun4m and sun4d code from trampoline_32

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/kernel/kernel.h        |   3 +-
 arch/sparc/kernel/trampoline_32.S | 127 +-------------------------------------
 2 files changed, 3 insertions(+), 127 deletions(-)

diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index 30adbec894f7..aea96b6b881c 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -112,8 +112,7 @@ extern unsigned int real_irq_entry[];
 extern unsigned int smp4d_ticker[];
 
 /* trampoline_32.S */
-extern unsigned long sun4m_cpu_startup;
-extern unsigned long sun4d_cpu_startup;
+void leon_smp_cpu_startup(int boot_cpu);
 
 /* signal_32.c */
 asmlinkage void do_sigreturn(struct pt_regs *regs);
diff --git a/arch/sparc/kernel/trampoline_32.S b/arch/sparc/kernel/trampoline_32.S
index 82fafeeb3a62..685b20923f6b 100644
--- a/arch/sparc/kernel/trampoline_32.S
+++ b/arch/sparc/kernel/trampoline_32.S
@@ -15,136 +15,12 @@
 #include <asm/contregs.h>
 #include <asm/thread_info.h>
 
-	.globl sun4m_cpu_startup
-	.globl sun4d_cpu_startup
-
-	.align 4
-
 /* When we start up a cpu for the first time it enters this routine.
  * This initializes the chip from whatever state the prom left it
  * in and sets PIL in %psr to 15, no irqs.
  */
-
-sun4m_cpu_startup:
-cpu1_startup:
-	sethi	%hi(trapbase_cpu1), %g3
-	b	1f
-	 or	%g3, %lo(trapbase_cpu1), %g3
-
-cpu2_startup:
-	sethi	%hi(trapbase_cpu2), %g3
-	b	1f
-	 or	%g3, %lo(trapbase_cpu2), %g3
-
-cpu3_startup:
-	sethi	%hi(trapbase_cpu3), %g3
-	b	1f
-	 or	%g3, %lo(trapbase_cpu3), %g3
-
-1:
-	/* Set up a sane %psr -- PIL<0xf> S<0x1> PS<0x1> CWP<0x0> */
-	set	(PSR_PIL | PSR_S | PSR_PS), %g1
-	wr	%g1, 0x0, %psr		! traps off though
-	WRITE_PAUSE
-
-	/* Our %wim is one behind CWP */
-	mov	2, %g1
-	wr	%g1, 0x0, %wim
-	WRITE_PAUSE
-
-	/* This identifies "this cpu". */
-	wr	%g3, 0x0, %tbr
-	WRITE_PAUSE
-
-	/* Give ourselves a stack and curptr. */
-	set	current_set, %g5
-	srl	%g3, 10, %g4
-	and	%g4, 0xc, %g4
-	ld	[%g5 + %g4], %g6
-
-	sethi	%hi(THREAD_SIZE - STACKFRAME_SZ), %sp
-	or	%sp, %lo(THREAD_SIZE - STACKFRAME_SZ), %sp
-	add	%g6, %sp, %sp
-
-	/* Turn on traps (PSR_ET). */
-	rd	%psr, %g1
-	wr	%g1, PSR_ET, %psr	! traps on
-	WRITE_PAUSE
-
-	/* Init our caches, etc. */
-	set	poke_srmmu, %g5
-	ld	[%g5], %g5
-	call	%g5
-	 nop
-
-	/* Start this processor. */
-	call	smp_callin
-	 nop
-
-	b,a	smp_panic
-
 	.text
 	.align	4
-
-smp_panic:
-	call	cpu_panic
-	 nop
-
-/* CPUID in bootbus can be found at PA 0xff0140000 */
-#define SUN4D_BOOTBUS_CPUID	0xf0140000
-
-	.align	4
-
-sun4d_cpu_startup:
-	/* Set up a sane %psr -- PIL<0xf> S<0x1> PS<0x1> CWP<0x0> */
-	set	(PSR_PIL | PSR_S | PSR_PS), %g1
-	wr	%g1, 0x0, %psr		! traps off though
-	WRITE_PAUSE
-
-	/* Our %wim is one behind CWP */
-	mov	2, %g1
-	wr	%g1, 0x0, %wim
-	WRITE_PAUSE
-
-	/* Set tbr - we use just one trap table. */
-	set	trapbase, %g1
-	wr	%g1, 0x0, %tbr
-	WRITE_PAUSE
-
-	/* Get our CPU id out of bootbus */
-	set	SUN4D_BOOTBUS_CPUID, %g3
-	lduba	[%g3] ASI_M_CTL, %g3
-	and	%g3, 0xf8, %g3
-	srl	%g3, 3, %g1
-	sta	%g1, [%g0] ASI_M_VIKING_TMP1
-
-	/* Give ourselves a stack and curptr. */
-	set	current_set, %g5
-	srl	%g3, 1, %g4
-	ld	[%g5 + %g4], %g6
-
-	sethi	%hi(THREAD_SIZE - STACKFRAME_SZ), %sp
-	or	%sp, %lo(THREAD_SIZE - STACKFRAME_SZ), %sp
-	add	%g6, %sp, %sp
-
-	/* Turn on traps (PSR_ET). */
-	rd	%psr, %g1
-	wr	%g1, PSR_ET, %psr	! traps on
-	WRITE_PAUSE
-
-	/* Init our caches, etc. */
-	set	poke_srmmu, %g5
-	ld	[%g5], %g5
-	call	%g5
-	 nop
-
-	/* Start this processor. */
-	call	smp_callin
-	 nop
-
-	b,a	smp_panic
-
-	.align	4
         .global leon_smp_cpu_startup, smp_penguin_ctable
 
 leon_smp_cpu_startup:
@@ -198,4 +74,5 @@ leon_smp_cpu_startup:
 	call	smp_callin
 	 nop
 
-	b,a	smp_panic
+	b,a	cpu_panic
+	 nop

-- 
2.34.1


