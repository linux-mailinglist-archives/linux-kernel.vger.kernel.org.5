Return-Path: <linux-kernel+bounces-97999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D9187732F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 19:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B60F28211A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 18:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D2B433BF;
	Sat,  9 Mar 2024 18:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geazRmGB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB744D9E8;
	Sat,  9 Mar 2024 18:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710008150; cv=none; b=U2aKjqI3zqjTd+oDJpGirR9HH8WdL8vwlGrjBsvEmMGDnMicXtASnnu5A7WwNPul4EgKrZVWMoMXoxsKOjKl08CUyQ+LE62q+aPNjh3UDiKwtzyDlCs+8byR58ZBIU5V43WIDf8dxcLns8bLn5BjattVOcg/bPpztdtxXoF4PTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710008150; c=relaxed/simple;
	bh=JLQwl/UHsY+aHo17JEmQzXfnkZwaCG6DW0NVMXTp7mg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aD7HvczJABUlkJ/44WO8QostYsFokS9zRr5krRr3Zn7QCjTg12SkdeJPf4hL5AfwAWRWq4gNq6K0Bvbni6Z/lrsFahoykGLBmtL4iUc5J2Ee4Rso7M9LzgGwSy8UBxoe4IeSlv0BW+Qjmh8Mnb/xs8UElczY12e5R10omsOfDWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geazRmGB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3741CC4163D;
	Sat,  9 Mar 2024 18:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710008150;
	bh=JLQwl/UHsY+aHo17JEmQzXfnkZwaCG6DW0NVMXTp7mg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=geazRmGBfaoPqB1QTazgdlJykm6XcaniAzk1db8E3udmM8vNqdWfpVMb5xQswPt2E
	 qjW2zSojZJXxQei+xhvjGkwgAOeqlPPI2Zl4Zst4bB5N0cQnDi2yfLVhVsRcQSh2j/
	 C1OBvL6V1UTT2pqlTGOQa0C8FH+d7k7KUUQYHyrv1EgDJLN24syfRHD0Ofj+fzB8u3
	 Bep2ALiEMIT7E+PGRJB/BkVhUz7G52L/g1z/+C1eA5WscPrEPgOmv2CW7xlGkP/BBn
	 zMuk1CrIgBnVqFMGyf23zTkSmadnoLPb76bsHBwWxxstuKKAE3LiIB6dqsRtYOsPYE
	 sSuBa/G2/cEXQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDA7C54E60;
	Sat,  9 Mar 2024 18:15:50 +0000 (UTC)
From: Sam Ravnborg via B4 Relay <devnull+sam.ravnborg.org@kernel.org>
Date: Sat, 09 Mar 2024 19:15:45 +0100
Subject: [PATCH v2 24/28] sparc32: Drop unused trampoline code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240309-sunset-v2-24-f09912574d2c@ravnborg.org>
References: <20240309-sunset-v2-0-f09912574d2c@ravnborg.org>
In-Reply-To: <20240309-sunset-v2-0-f09912574d2c@ravnborg.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Arnd Bergmann <arnd@kernel.org>, Andreas Larsson <andreas@gaisler.com>
Cc: Helge Deller <deller@gmx.de>, Randy Dunlap <rdunlap@infradead.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Kjetil Oftedal <oftedal@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Alan Stern <stern@rowland.harvard.edu>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, sparclinux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-sound@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710008145; l=4170;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=c5JlRnNyr4+VYyBORaVjsB7QUl3QI6l2C8IE0ln5DUY=; =?utf-8?q?b=3Dl6EUYlmnUPNt?=
 =?utf-8?q?dsB+bKwXdZOEt8xiJ7SrTLQCr/R6i71EDE1zz9sTLxbAMDlF+UiC0G/sdkvuP+gO?=
 zDbMRTiiAmglyaivSCy9ar3OVriFGdyUlI5ptqSf7QcJ1WsKH4Y1
X-Developer-Key: i=sam@ravnborg.org; a=ed25519;
 pk=R0+pqV7BRYOAeOIGkyOrSNke7arx5y3LkEuNi37YEyU=
X-Endpoint-Received: by B4 Relay for sam@ravnborg.org/20230107 with auth_id=22
X-Original-From: Sam Ravnborg <sam@ravnborg.org>
Reply-To: <sam@ravnborg.org>

From: Sam Ravnborg <sam@ravnborg.org>

Drop the sun4m and sun4d code from trampoline_32

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Arnd Bergmann <arnd@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/kernel/kernel.h        |   3 +-
 arch/sparc/kernel/trampoline_32.S | 127 +-------------------------------------
 2 files changed, 3 insertions(+), 127 deletions(-)

diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index c2aaddedf097..2c57677770ff 100644
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


