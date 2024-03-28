Return-Path: <linux-kernel+bounces-97985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1892E877324
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 19:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827BA1F22066
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 18:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D8D5B692;
	Sat,  9 Mar 2024 18:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qil3HXjw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDE447768;
	Sat,  9 Mar 2024 18:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710008149; cv=none; b=s3ouqB2JOgVQERFIWI+6iu0OcMvPbjzt4jvuLdzn46WDrFyXN5kXT/JsUElNj1VJMGIikFp8F1cxzoTx+r+ZKiehUDjygfsT5pn03/Jlon1priTqr1Hu/oa01aIRKZxwl8LPmk+strbg95xC7c2M73vqh4AOQEIX5Ln6z7K412c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710008149; c=relaxed/simple;
	bh=zdAy0Xr0AnQQ4NyqA4RA58vzeuCeKFwnVIJtR0fcyNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FT6LkxqV420TzIBj94KlhlhjH7r2h6LWwxaImao5480gBO+9AORuK3voczsBB3t4cmee25JzQ2LNHGf0ieZ0ewvdYI2hzmA3roo+vt3mRJb6JqThLVR88FuYPvLBFm0WWzC4sV7A5xjgt6lW+Fsyg5ceH0CDIkmcEp9n9yu+CJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qil3HXjw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3CC6C43143;
	Sat,  9 Mar 2024 18:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710008148;
	bh=zdAy0Xr0AnQQ4NyqA4RA58vzeuCeKFwnVIJtR0fcyNk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Qil3HXjwJsVtA2J/mwV+icSdko3v9L+DFuQGNG6+xk3HKF7a+YzIHglIU4+LtdFDv
	 Wvyr+i7FY5mqnu9OZYDThk+vJRD5GSpO3i/n8gcUmmxu7yjS2cap3gamTwYb8EHnjv
	 jMnkTQ1OaMQBpoggVKqsG57CJI6tDZ8e7kq0gxdNkrEfDOnXx3HLIJJ1Zlzg2+jZsy
	 GJV/6Cw9T2WVdi8JEPQGvWK+O89F2FBmp+1GEI9ds+NzfFatykEi2zPI0y2ASXpK+z
	 Z8qpMmlcTFAcVWY0OA+BgzFIhvxA63CcAawnmXEACF/qEj7vTEwZnrMkN3BMKtnXK0
	 o7OpxlWinzQzg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E7CC54E61;
	Sat,  9 Mar 2024 18:15:48 +0000 (UTC)
From: Sam Ravnborg via B4 Relay <devnull+sam.ravnborg.org@kernel.org>
Date: Sat, 09 Mar 2024 19:15:28 +0100
Subject: [PATCH v2 07/28] sparc32: Drop run-time patching of ipi trap
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240309-sunset-v2-7-f09912574d2c@ravnborg.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710008145; l=7150;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=X8zjXluzKWbFIcpgmaunf+yz3YUUIB2TYhKrHE6RXP4=; =?utf-8?q?b=3DSDqDKVflKSgo?=
 =?utf-8?q?AdqXfmrUT9t+zo9fqC7uIzf3KVyb4ZwXWOxYSYIkTW2AqAknJswhGugjAjeWrHUg?=
 xnEF+e3TCH12GjXjjTc2LJWgIj+CxvXUqgHc/KJR3/75w5xf2WBK
X-Developer-Key: i=sam@ravnborg.org; a=ed25519;
 pk=R0+pqV7BRYOAeOIGkyOrSNke7arx5y3LkEuNi37YEyU=
X-Endpoint-Received: by B4 Relay for sam@ravnborg.org/20230107 with auth_id=22
X-Original-From: Sam Ravnborg <sam@ravnborg.org>
Reply-To: <sam@ravnborg.org>

From: Sam Ravnborg <sam@ravnborg.org>

There is no longer any need for the run-time patching of the ipi trap
with the removal of sun4m and sun4d. Remove the patching and drop the
ipi implementation for the two machines.

The patch includes removal of patching from pcic as this was needed to
fix the build. pcic will be removed in a later commit.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Arnd Bergmann <arnd@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/kernel/entry.S     | 70 ++-----------------------------------------
 arch/sparc/kernel/kernel.h    |  4 ---
 arch/sparc/kernel/leon_smp.c  |  3 --
 arch/sparc/kernel/pcic.c      | 11 -------
 arch/sparc/kernel/sun4d_smp.c |  3 --
 arch/sparc/kernel/ttable_32.S |  9 +++---
 6 files changed, 7 insertions(+), 93 deletions(-)

diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index c6a5cb949381..7cf148a996b9 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -174,32 +174,6 @@ maybe_smp4m_msg_check_resched:
 maybe_smp4m_msg_out:
 	RESTORE_ALL
 
-	.align	4
-	.globl	linux_trap_ipi15_sun4m
-linux_trap_ipi15_sun4m:
-	SAVE_ALL
-	sethi	%hi(0x80000000), %o2
-	GET_PROCESSOR4M_ID(o0)
-	sethi	%hi(sun4m_irq_percpu), %l5
-	or	%l5, %lo(sun4m_irq_percpu), %o5
-	sll	%o0, 2, %o0
-	ld	[%o5 + %o0], %o5
-	ld	[%o5 + 0x00], %o3	! sun4m_irq_percpu[cpu]->pending
-	andcc	%o3, %o2, %g0
-	be	sun4m_nmi_error		! Must be an NMI async memory error
-	 st	%o2, [%o5 + 0x04]	! sun4m_irq_percpu[cpu]->clear=0x80000000
-	WRITE_PAUSE
-	ld	[%o5 + 0x00], %g0	! sun4m_irq_percpu[cpu]->pending
-	WRITE_PAUSE
-	or	%l0, PSR_PIL, %l4
-	wr	%l4, 0x0, %psr
-	WRITE_PAUSE
-	wr	%l4, PSR_ET, %psr
-	WRITE_PAUSE
-	call	smp4m_cross_call_irq
-	 nop
-	b	ret_trap_lockless_ipi
-	 clr	%l6
 
 	.globl	smp4d_ticker
 	/* SMP per-cpu ticker interrupts are handled specially. */
@@ -220,44 +194,6 @@ smp4d_ticker:
 	WRITE_PAUSE
 	RESTORE_ALL
 
-	.align	4
-	.globl	linux_trap_ipi15_sun4d
-linux_trap_ipi15_sun4d:
-	SAVE_ALL
-	sethi	%hi(CC_BASE), %o4
-	sethi	%hi(MXCC_ERR_ME|MXCC_ERR_PEW|MXCC_ERR_ASE|MXCC_ERR_PEE), %o2
-	or	%o4, (CC_EREG - CC_BASE), %o0
-	ldda	[%o0] ASI_M_MXCC, %o0
-	andcc	%o0, %o2, %g0
-	bne	1f
-	 sethi	%hi(BB_STAT2), %o2
-	lduba	[%o2] ASI_M_CTL, %o2
-	andcc	%o2, BB_STAT2_MASK, %g0
-	bne	2f
-	 or	%o4, (CC_ICLR - CC_BASE), %o0
-	sethi	%hi(1 << 15), %o1
-	stha	%o1, [%o0] ASI_M_MXCC	/* Clear PIL 15 in MXCC's ICLR */
-	or	%l0, PSR_PIL, %l4
-	wr	%l4, 0x0, %psr
-	WRITE_PAUSE
-	wr	%l4, PSR_ET, %psr
-	WRITE_PAUSE
-	call	smp4d_cross_call_irq
-	 nop
-	b	ret_trap_lockless_ipi
-	 clr	%l6
-
-1:	/* MXCC error */
-2:	/* BB error */
-	/* Disable PIL 15 */
-	set	CC_IMSK, %l4
-	lduha	[%l4] ASI_M_MXCC, %l5
-	sethi	%hi(1 << 15), %l7
-	or	%l5, %l7, %l5
-	stha	%l5, [%l4] ASI_M_MXCC
-	/* FIXME */
-1:	b,a	1b
-
 	.globl	smpleon_ipi
 	.extern leon_ipi_interrupt
 	/* SMP per-cpu IPI interrupts are handled specially. */
@@ -618,11 +554,11 @@ sun4m_nmi_error:
 
 #ifndef CONFIG_SMP
 	.align	4
-	.globl	linux_trap_ipi15_sun4m
-linux_trap_ipi15_sun4m:
+	.globl	linux_trap_ipi15_leon
+linux_trap_ipi15_leon:
 	SAVE_ALL
 
-	ba	sun4m_nmi_error
+	ba      sun4m_nmi_error
 	 nop
 #endif /* CONFIG_SMP */
 
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index 64703be6c015..3ba842c6b6da 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -134,10 +134,6 @@ void leonsmp_ipi_interrupt(void);
 void leon_cross_call_irq(void);
 
 /* head_32.S */
-extern unsigned int t_nmi[];
-extern unsigned int linux_trap_ipi15_sun4d[];
-extern unsigned int linux_trap_ipi15_sun4m[];
-
 extern struct tt_entry trapbase[];
 extern struct tt_entry trapbase_cpu1[];
 extern struct tt_entry trapbase_cpu2[];
diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index 1ee393abc463..7d5e423c186d 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -463,8 +463,5 @@ static const struct sparc32_ipi_ops leon_ipi_ops = {
 
 void __init leon_init_smp(void)
 {
-	/* Patch ipi15 trap table */
-	t_nmi[1] = t_nmi[1] + (linux_trap_ipi15_leon - linux_trap_ipi15_sun4m);
-
 	sparc32_ipi_ops = &leon_ipi_ops;
 }
diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index 25fe0a061732..d952bcbbc395 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -354,17 +354,6 @@ int __init pcic_probe(void)
 	prom_getstring(node, "name", namebuf, 63);  namebuf[63] = 0;
 	strcpy(pbm->prom_name, namebuf);
 
-	{
-		extern int pcic_nmi_trap_patch[4];
-
-		t_nmi[0] = pcic_nmi_trap_patch[0];
-		t_nmi[1] = pcic_nmi_trap_patch[1];
-		t_nmi[2] = pcic_nmi_trap_patch[2];
-		t_nmi[3] = pcic_nmi_trap_patch[3];
-		swift_flush_dcache();
-		pcic_regs = pcic->pcic_regs;
-	}
-
 	prom_getstring(prom_root_node, "name", namebuf, 63);  namebuf[63] = 0;
 	{
 		struct pcic_sn2list *p;
diff --git a/arch/sparc/kernel/sun4d_smp.c b/arch/sparc/kernel/sun4d_smp.c
index 9a62a5cf3337..be5bcbee1af4 100644
--- a/arch/sparc/kernel/sun4d_smp.c
+++ b/arch/sparc/kernel/sun4d_smp.c
@@ -403,9 +403,6 @@ void __init sun4d_init_smp(void)
 {
 	int i;
 
-	/* Patch ipi15 trap table */
-	t_nmi[1] = t_nmi[1] + (linux_trap_ipi15_sun4d - linux_trap_ipi15_sun4m);
-
 	sparc32_ipi_ops = &sun4d_ipi_ops;
 
 	for (i = 0; i < NR_CPUS; i++) {
diff --git a/arch/sparc/kernel/ttable_32.S b/arch/sparc/kernel/ttable_32.S
index e79fd786fbbb..78bbf2548e1f 100644
--- a/arch/sparc/kernel/ttable_32.S
+++ b/arch/sparc/kernel/ttable_32.S
@@ -43,8 +43,7 @@ t_irq12:TRAP_ENTRY_INTERRUPT(12)            /* IRQ Zilog serial chip         */
 t_irq13:TRAP_ENTRY_INTERRUPT(13)            /* IRQ Audio Intr.               */
 t_irq14:TRAP_ENTRY_INTERRUPT(14)            /* IRQ Timer #2                  */
 
-	.globl	t_nmi
-t_nmi:	TRAP_ENTRY(0x1f, linux_trap_ipi15_sun4m)
+t_nmi:	TRAP_ENTRY(0x1f, linux_trap_ipi15_leon)
 
 t_racc:	TRAP_ENTRY(0x20, do_reg_access)     /* General Register Access Error */
 t_iacce:BAD_TRAP(0x21)                      /* Instr Access Error            */
@@ -146,7 +145,7 @@ trapbase_cpu1:
 	TRAP_ENTRY_INTERRUPT(9) TRAP_ENTRY_INTERRUPT(10)
 	TRAP_ENTRY_INTERRUPT(11) TRAP_ENTRY_INTERRUPT(12)
 	TRAP_ENTRY_INTERRUPT(13) TRAP_ENTRY_INTERRUPT(14)
-	TRAP_ENTRY(0x1f, linux_trap_ipi15_sun4m)
+	TRAP_ENTRY(0x1f, linux_trap_ipi15_leon)
 	TRAP_ENTRY(0x20, do_reg_access)
 	BAD_TRAP(0x21)
 	BAD_TRAP(0x22)
@@ -245,7 +244,7 @@ trapbase_cpu2:
 	TRAP_ENTRY_INTERRUPT(12)
 	TRAP_ENTRY_INTERRUPT(13)
 	TRAP_ENTRY_INTERRUPT(14)
-	TRAP_ENTRY(0x1f, linux_trap_ipi15_sun4m)
+	TRAP_ENTRY(0x1f, linux_trap_ipi15_leon)
 	TRAP_ENTRY(0x20, do_reg_access)
 	BAD_TRAP(0x21)
 	BAD_TRAP(0x22)
@@ -345,7 +344,7 @@ trapbase_cpu3:
 	TRAP_ENTRY_INTERRUPT(12)
 	TRAP_ENTRY_INTERRUPT(13)
 	TRAP_ENTRY_INTERRUPT(14)
-	TRAP_ENTRY(0x1f, linux_trap_ipi15_sun4m)
+	TRAP_ENTRY(0x1f, linux_trap_ipi15_leon)
 	TRAP_ENTRY(0x20, do_reg_access)
 	BAD_TRAP(0x21)
 	BAD_TRAP(0x22)

-- 
2.34.1


