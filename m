Return-Path: <linux-kernel+bounces-79034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03935861CAD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 279DE1C2318E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1411468FA;
	Fri, 23 Feb 2024 19:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyWv7HLw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1791448DD;
	Fri, 23 Feb 2024 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708717025; cv=none; b=XYbxQaUYvUlqXbEQSSii4Y1ynKPeMhwEQiJx/r/TOV6gfQnzpdbRlgWI8KT7RTM0Q7zBDKSdAcZj4j7y4uBECcqragwXvirN6gJvFzTTFMIqDU/FL7rjz3xzFe8x8b6paoF/1D4KG/7LSAMhpcPf94AG0V3hR7kAm4J4t/ljObY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708717025; c=relaxed/simple;
	bh=we3L75CQ79HHxOvSb1ZZJI5S6/Ad+/lQv5goB0IX45s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I1u0oDx70yT5Z/P/M8yPiD9B09WmsJTGThIps0DXh+uQND3wvnS4Zku15mdVjDvZsQfUeJuqFEgOT5ENd25E8cig1Y/LBwaj+fTzaqMirr2oL5nP2LRWU3+hXCPek5/uDYY4BvBeKV607WHQ32+aPwz5kw1NcC1ewitdkJdwhOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyWv7HLw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE9B1C43394;
	Fri, 23 Feb 2024 19:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708717024;
	bh=we3L75CQ79HHxOvSb1ZZJI5S6/Ad+/lQv5goB0IX45s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qyWv7HLwUdJobDp+rcgORDpNZbn/BnrOtGZ6ogh6/kR+HAygNGI1dAu/Mz84iLcEz
	 wRWaojWZQrnVGD53lJEe4/cxKeRf57Y8SuQ+CTMeds03vs945ZAEJ7apsPLrEzCJHa
	 itb/qvDY93DOS18oZDoBWFBMBLaKGkzU/VHAchZq9ymmZ86S84XCTVhGCFnaRBNTJe
	 xY8cOzxDlrMkKVHz/cjOaNPogl7jTN7eF5UoAgojRBldvtcicudC9/++VboDhuTdwl
	 Vv06E+qNkuWNu6SCXsbZiPbeterlwWd0KIEuw+dhhDaLPPFHcs3xG+DTgWThv1yrur
	 6RHd+SekPft1g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0803C54798;
	Fri, 23 Feb 2024 19:37:04 +0000 (UTC)
From: Sam Ravnborg via B4 Relay <devnull+sam.ravnborg.org@kernel.org>
Date: Fri, 23 Feb 2024 20:36:48 +0100
Subject: [PATCH 2/6] sparc32: Fix build with trapbase
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id:
 <20240223-sam-fix-sparc32-all-builds-v1-2-5c60fd5c9250@ravnborg.org>
References:
 <20240223-sam-fix-sparc32-all-builds-v1-0-5c60fd5c9250@ravnborg.org>
In-Reply-To:
 <20240223-sam-fix-sparc32-all-builds-v1-0-5c60fd5c9250@ravnborg.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: sparclinux@vger.kernel.org, linux-parport@lists.infradead.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Randy Dunlap <rdunlap@infradead.org>, 
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 Sam Ravnborg <sam@ravnborg.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708717023; l=4694;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=ZFfHXtKyLf8xDM6mY7aG00HWuxPLFS499lQmLEdt+Es=; =?utf-8?q?b=3DPc7hW34245wR?=
 =?utf-8?q?Lxl7Y/2gnc2urS4zef2lni6AkzWyk2fehxpPdPJSehnCfeZ6zvi2vOxP8eEv8OQI?=
 8ZBP7NUTCWw17kwSaTtMcu0xbiUBk8WF4LjqybQlHUQkxTTesgdM
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


