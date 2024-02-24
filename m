Return-Path: <linux-kernel+bounces-79763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2C8862670
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 18:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 407521C21408
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D514C61B;
	Sat, 24 Feb 2024 17:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHtWOHbP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4134C47A6B;
	Sat, 24 Feb 2024 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708796547; cv=none; b=AHG6tMwUU3gm6AjQe8j5rgFKgjr7LvfshD2v30ZB+EB7UAYbNZpNJ5HOvlv7lxy9WQLAm8o7XVtxK5SDaHFiW8ShHv196IlWmsrJQ+svrII3OalhIgxYHx1emIr6uat+dLk9am70tmMLJNtPFX4y+sIvQI8zYwTjAgxk35SBNok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708796547; c=relaxed/simple;
	bh=bGfNa9P0bcSr1b3FZ6CzcNWFHSx5/mcdtp5dllWw6FY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DCPwkug7Rk1gd32M1GjT9QoAyXfelMJRbrZhZ0WrzB1cqpHQWpMyIP5CgxaDvwm1HGfFogb8PqeGIPOkM16aeJsHGskpeZnnpEwjomH8G+R3M8KWdVDhF33aKnXzhZvB1IwTIw/ob0V5ILpyx6F4jVvE45DifzV6nqAwl5zuDGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHtWOHbP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3FBCC43390;
	Sat, 24 Feb 2024 17:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708796547;
	bh=bGfNa9P0bcSr1b3FZ6CzcNWFHSx5/mcdtp5dllWw6FY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tHtWOHbPkr46dvIZ4Ubq0+uhrNV29D3fsqWKnp0cg3Z62cXU2E7HbP3xQF9F+5He0
	 WhYC8Jh7CyEbv9Y6qbZwMxuS/8WYVu3rs+pRZwmtNoEXp/s+nHWoc4ixzBpWrCHyJN
	 CsJpOzK8wTKUlGXSAEymJj3cfw443AbvgPVBEzPimCMq+1Le5bPHTqSdbMVlV+q0Ap
	 m1MKCftBrWlA+TqQFg9gxkZqKX33doaBgvWHr++KS9902f/TDPQId7U2mkagf1PhKb
	 KJDE7fa8oiBFyUDUmga1t2pbA4ChOgDKrQBQ6XA0yI8gUBTF/Mz634MdGCDsxSBth6
	 Ks4Zu63LwbfCQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3049C54E4F;
	Sat, 24 Feb 2024 17:42:26 +0000 (UTC)
From: Sam Ravnborg via B4 Relay <devnull+sam.ravnborg.org@kernel.org>
Date: Sat, 24 Feb 2024 18:42:23 +0100
Subject: [PATCH v2 2/7] sparc32: Fix build with trapbase
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id:
 <20240224-sam-fix-sparc32-all-builds-v2-2-1f186603c5c4@ravnborg.org>
References:
 <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org>
In-Reply-To:
 <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>, sparclinux@vger.kernel.org, 
 Andreas Larsson <andreas@gaisler.com>, Randy Dunlap <rdunlap@infradead.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 linux-parport@lists.infradead.org, "David S. Miller" <davem@davemloft.net>, 
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 Sam Ravnborg <sam@ravnborg.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708796545; l=4806;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=yODVsKtXRLRL5P00tESgJdJda/SYlfy6l2Y847zfeCU=; =?utf-8?q?b=3D9FtF0vthGV5K?=
 =?utf-8?q?V/hPt5Yc5TbLmZTI0ewIdffIWFA7tPr+zMCJ1cWT6xw/uPgyN67nKD8Ds9tpzUpF?=
 so4wk2r8AiAQBjVYbWLaHrouAw+VOauFmCspxcSiA8y0iTb2VBVv
X-Developer-Key: i=sam@ravnborg.org; a=ed25519;
 pk=R0+pqV7BRYOAeOIGkyOrSNke7arx5y3LkEuNi37YEyU=
X-Endpoint-Received: by B4 Relay for sam@ravnborg.org/20230107 with auth_id=22
X-Original-From: Sam Ravnborg <sam@ravnborg.org>
Reply-To: <sam@ravnborg.org>

From: Sam Ravnborg <sam@ravnborg.org>

Fix the following build errors:
irq_32.c:258:7: error: array subscript [16, 79] is outside array bounds of 'struct tt_entry[1]
irq_32.c:271:14: error: assignment to 'struct tt_entry *' from incompatible pointer type 'struct tt_entry (*)[]

trapbase is a pointer to an array of tt_entry, but the code declared it
as a pointer so the compiler see a single entry and not an array.
Fix this by modifyinf the declaration to be an array, and modify all
users to take the address of the first member.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: "David S. Miller" <davem@davemloft.net>
---
 arch/sparc/kernel/irq_32.c   | 6 +++---
 arch/sparc/kernel/kernel.h   | 8 ++++----
 arch/sparc/kernel/kgdb_32.c  | 4 ++--
 arch/sparc/kernel/leon_smp.c | 6 +++---
 arch/sparc/kernel/setup_32.c | 4 ++--
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/kernel/irq_32.c b/arch/sparc/kernel/irq_32.c
index e8452be5123b..8605dd710f3c 100644
--- a/arch/sparc/kernel/irq_32.c
+++ b/arch/sparc/kernel/irq_32.c
@@ -268,11 +268,11 @@ int sparc_floppy_request_irq(unsigned int irq, irq_handler_t irq_handler)
 	if (sparc_cpu_model != sparc_leon) {
 		struct tt_entry *trap_table;
 
-		trap_table = &trapbase_cpu1;
+		trap_table = &trapbase_cpu1[0];
 		INSTANTIATE(trap_table)
-		trap_table = &trapbase_cpu2;
+		trap_table = &trapbase_cpu2[0];
 		INSTANTIATE(trap_table)
-		trap_table = &trapbase_cpu3;
+		trap_table = &trapbase_cpu3[0];
 		INSTANTIATE(trap_table)
 	}
 #endif
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index 15da3c0597a5..a8fb7c0bf053 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -138,10 +138,10 @@ extern unsigned int t_nmi[];
 extern unsigned int linux_trap_ipi15_sun4d[];
 extern unsigned int linux_trap_ipi15_sun4m[];
 
-extern struct tt_entry trapbase;
-extern struct tt_entry trapbase_cpu1;
-extern struct tt_entry trapbase_cpu2;
-extern struct tt_entry trapbase_cpu3;
+extern struct tt_entry trapbase[];
+extern struct tt_entry trapbase_cpu1[];
+extern struct tt_entry trapbase_cpu2[];
+extern struct tt_entry trapbase_cpu3[];
 
 extern char cputypval[];
 
diff --git a/arch/sparc/kernel/kgdb_32.c b/arch/sparc/kernel/kgdb_32.c
index 58ad3f7de1fb..3b2c673ec627 100644
--- a/arch/sparc/kernel/kgdb_32.c
+++ b/arch/sparc/kernel/kgdb_32.c
@@ -37,7 +37,7 @@ void pt_regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs *regs)
 	gdb_regs[GDB_Y] = regs->y;
 	gdb_regs[GDB_PSR] = regs->psr;
 	gdb_regs[GDB_WIM] = 0;
-	gdb_regs[GDB_TBR] = (unsigned long) &trapbase;
+	gdb_regs[GDB_TBR] = (unsigned long) &trapbase[0];
 	gdb_regs[GDB_PC] = regs->pc;
 	gdb_regs[GDB_NPC] = regs->npc;
 	gdb_regs[GDB_FSR] = 0;
@@ -72,7 +72,7 @@ void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *p)
 
 	gdb_regs[GDB_PSR] = t->kpsr;
 	gdb_regs[GDB_WIM] = t->kwim;
-	gdb_regs[GDB_TBR] = (unsigned long) &trapbase;
+	gdb_regs[GDB_TBR] = (unsigned long) &trapbase[0];
 	gdb_regs[GDB_PC] = t->kpc;
 	gdb_regs[GDB_NPC] = t->kpc + 4;
 	gdb_regs[GDB_FSR] = 0;
diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index 991e9ad3d3e8..1ee393abc463 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -245,13 +245,13 @@ void __init leon_smp_done(void)
 
 	/* Free unneeded trap tables */
 	if (!cpu_present(1)) {
-		free_reserved_page(virt_to_page(&trapbase_cpu1));
+		free_reserved_page(virt_to_page(&trapbase_cpu1[0]));
 	}
 	if (!cpu_present(2)) {
-		free_reserved_page(virt_to_page(&trapbase_cpu2));
+		free_reserved_page(virt_to_page(&trapbase_cpu2[0]));
 	}
 	if (!cpu_present(3)) {
-		free_reserved_page(virt_to_page(&trapbase_cpu3));
+		free_reserved_page(virt_to_page(&trapbase_cpu3[0]));
 	}
 	/* Ok, they are spinning and ready to go. */
 	smp_processors_ready = 1;
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index e3b72a7b46d3..704375c061e7 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -67,7 +67,7 @@ static void prom_sync_me(void)
 	__asm__ __volatile__("wr %0, 0x0, %%tbr\n\t"
 			     "nop\n\t"
 			     "nop\n\t"
-			     "nop\n\t" : : "r" (&trapbase));
+			     "nop\n\t" : : "r" (&trapbase[0]));
 
 	prom_printf("PROM SYNC COMMAND...\n");
 	show_mem();
@@ -285,7 +285,7 @@ void __init setup_arch(char **cmdline_p)
 	int i;
 	unsigned long highest_paddr;
 
-	sparc_ttable = &trapbase;
+	sparc_ttable = &trapbase[0];
 
 	/* Initialize PROM console and command line. */
 	*cmdline_p = prom_getbootargs();

-- 
2.34.1


