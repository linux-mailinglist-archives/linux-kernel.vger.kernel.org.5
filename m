Return-Path: <linux-kernel+bounces-31206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9847A832A8B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47E3A28318E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921E252F81;
	Fri, 19 Jan 2024 13:32:29 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5574B42053;
	Fri, 19 Jan 2024 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705671148; cv=none; b=MzC695vJYiqnsRnJBnnV5W7boDx1jAseLQDUMOL7XRvAOywcvF8UWkzWC+VtAIiS+L3vJDCsXDCt6HY6+sKFYvD2IRziNZOB0NKY4++OYIjdaJBgWb+jb6U570AfVp0xDvdU40RGJUpB6RSFKARHgoMuPW2rWUR2gg/7Z19bqAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705671148; c=relaxed/simple;
	bh=/yT+8yxZAnM2xPj9Zf5XXbIuHimp+ObxlLLeFlaCI9k=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=VLDdUyd6Vwa8AOhbX9Jms23Du6FxAXwpwfRKIXWzXQnyN58WtBCxhSguWMw6CXXvzbexHw2iWLoJ7Haw/0aj+i3Hjn2MJxJ4JU3WOW7ZFzTEqips9BbifKJ3KRQTDGo1yQuR14+wSrM+WD8PqOJGoFDJyjri7Aym/TPB6SJ6qzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=fail smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=alpha.franken.de
Received: from hutton.arch.nue2.suse.org (unknown [10.168.144.140])
	by smtp-out2.suse.de (Postfix) with ESMTP id 3C1681F7F1;
	Fri, 19 Jan 2024 13:32:22 +0000 (UTC)
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: sgi-ip27: Fix missing prototypes
Date: Fri, 19 Jan 2024 14:32:16 +0100
Message-Id: <20240119133216.83220-1-tsbogend@alpha.franken.de>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: *********
X-Spam-Score: 9.02
X-Spamd-Result: default: False [9.02 / 50.00];
	 ARC_NA(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-0.82)[-0.824];
	 NEURAL_HAM_SHORT(-0.15)[-0.767];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+]
X-Spam-Flag: NO

Fix missing prototypes by making not shared functions static and
adding others to ip27-common.h. Also drop ip27-hubio.c as it's
not used for a long time.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/sgi-ip27/Makefile      |   2 +-
 arch/mips/sgi-ip27/ip27-berr.c   |   4 +-
 arch/mips/sgi-ip27/ip27-common.h |   2 +
 arch/mips/sgi-ip27/ip27-hubio.c  | 185 -------------------------------
 arch/mips/sgi-ip27/ip27-irq.c    |   2 +
 arch/mips/sgi-ip27/ip27-memory.c |   1 +
 arch/mips/sgi-ip27/ip27-nmi.c    |  25 ++---
 7 files changed, 17 insertions(+), 204 deletions(-)
 delete mode 100644 arch/mips/sgi-ip27/ip27-hubio.c

diff --git a/arch/mips/sgi-ip27/Makefile b/arch/mips/sgi-ip27/Makefile
index 27c14ede191e..9877fcc512b1 100644
--- a/arch/mips/sgi-ip27/Makefile
+++ b/arch/mips/sgi-ip27/Makefile
@@ -5,7 +5,7 @@
 
 obj-y	:= ip27-berr.o ip27-irq.o ip27-init.o ip27-klconfig.o \
 	   ip27-klnuma.o ip27-memory.o ip27-nmi.o ip27-reset.o ip27-timer.o \
-	   ip27-hubio.o ip27-xtalk.o
+	   ip27-xtalk.o
 
 obj-$(CONFIG_EARLY_PRINTK)	+= ip27-console.o
 obj-$(CONFIG_SMP)		+= ip27-smp.o
diff --git a/arch/mips/sgi-ip27/ip27-berr.c b/arch/mips/sgi-ip27/ip27-berr.c
index 923a63a51cda..9eb497cb5d52 100644
--- a/arch/mips/sgi-ip27/ip27-berr.c
+++ b/arch/mips/sgi-ip27/ip27-berr.c
@@ -22,6 +22,8 @@
 #include <asm/traps.h>
 #include <linux/uaccess.h>
 
+#include "ip27-common.h"
+
 static void dump_hub_information(unsigned long errst0, unsigned long errst1)
 {
 	static char *err_type[2][8] = {
@@ -57,7 +59,7 @@ static void dump_hub_information(unsigned long errst0, unsigned long errst1)
 	       [st0.pi_stat0_fmt.s0_err_type] ? : "invalid");
 }
 
-int ip27_be_handler(struct pt_regs *regs, int is_fixup)
+static int ip27_be_handler(struct pt_regs *regs, int is_fixup)
 {
 	unsigned long errst0, errst1;
 	int data = regs->cp0_cause & 4;
diff --git a/arch/mips/sgi-ip27/ip27-common.h b/arch/mips/sgi-ip27/ip27-common.h
index ed008a08464c..a0059fa13934 100644
--- a/arch/mips/sgi-ip27/ip27-common.h
+++ b/arch/mips/sgi-ip27/ip27-common.h
@@ -10,6 +10,7 @@ extern void hub_rt_clock_event_init(void);
 extern void hub_rtc_init(nasid_t nasid);
 extern void install_cpu_nmi_handler(int slice);
 extern void install_ipi(void);
+extern void ip27_be_init(void);
 extern void ip27_reboot_setup(void);
 extern const struct plat_smp_ops ip27_smp_ops;
 extern unsigned long node_getfirstfree(nasid_t nasid);
@@ -17,4 +18,5 @@ extern void per_cpu_init(void);
 extern void replicate_kernel_text(void);
 extern void setup_replication_mask(void);
 
+
 #endif /* __IP27_COMMON_H */
diff --git a/arch/mips/sgi-ip27/ip27-hubio.c b/arch/mips/sgi-ip27/ip27-hubio.c
deleted file mode 100644
index c57f0d8f3218..000000000000
--- a/arch/mips/sgi-ip27/ip27-hubio.c
+++ /dev/null
@@ -1,185 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 1992-1997, 2000-2003 Silicon Graphics, Inc.
- * Copyright (C) 2004 Christoph Hellwig.
- *
- * Support functions for the HUB ASIC - mostly PIO mapping related.
- */
-
-#include <linux/bitops.h>
-#include <linux/string.h>
-#include <linux/mmzone.h>
-#include <asm/sn/addrs.h>
-#include <asm/sn/arch.h>
-#include <asm/sn/agent.h>
-#include <asm/sn/io.h>
-#include <asm/xtalk/xtalk.h>
-
-
-static int force_fire_and_forget = 1;
-
-/**
- * hub_pio_map	-  establish a HUB PIO mapping
- *
- * @nasid:	nasid to perform PIO mapping on
- * @widget:	widget ID to perform PIO mapping for
- * @xtalk_addr: xtalk_address that needs to be mapped
- * @size:	size of the PIO mapping
- *
- **/
-unsigned long hub_pio_map(nasid_t nasid, xwidgetnum_t widget,
-			  unsigned long xtalk_addr, size_t size)
-{
-	unsigned i;
-
-	/* use small-window mapping if possible */
-	if ((xtalk_addr % SWIN_SIZE) + size <= SWIN_SIZE)
-		return NODE_SWIN_BASE(nasid, widget) + (xtalk_addr % SWIN_SIZE);
-
-	if ((xtalk_addr % BWIN_SIZE) + size > BWIN_SIZE) {
-		printk(KERN_WARNING "PIO mapping at hub %d widget %d addr 0x%lx"
-				" too big (%ld)\n",
-				nasid, widget, xtalk_addr, size);
-		return 0;
-	}
-
-	xtalk_addr &= ~(BWIN_SIZE-1);
-	for (i = 0; i < HUB_NUM_BIG_WINDOW; i++) {
-		if (test_and_set_bit(i, hub_data(nasid)->h_bigwin_used))
-			continue;
-
-		/*
-		 * The code below does a PIO write to setup an ITTE entry.
-		 *
-		 * We need to prevent other CPUs from seeing our updated
-		 * memory shadow of the ITTE (in the piomap) until the ITTE
-		 * entry is actually set up; otherwise, another CPU might
-		 * attempt a PIO prematurely.
-		 *
-		 * Also, the only way we can know that an entry has been
-		 * received  by the hub and can be used by future PIO reads/
-		 * writes is by reading back the ITTE entry after writing it.
-		 *
-		 * For these two reasons, we PIO read back the ITTE entry
-		 * after we write it.
-		 */
-		IIO_ITTE_PUT(nasid, i, HUB_PIO_MAP_TO_MEM, widget, xtalk_addr);
-		__raw_readq(IIO_ITTE_GET(nasid, i));
-
-		return NODE_BWIN_BASE(nasid, widget) + (xtalk_addr % BWIN_SIZE);
-	}
-
-	printk(KERN_WARNING "unable to establish PIO mapping for at"
-			" hub %d widget %d addr 0x%lx\n",
-			nasid, widget, xtalk_addr);
-	return 0;
-}
-
-
-/*
- * hub_setup_prb(nasid, prbnum, credits, conveyor)
- *
- *	Put a PRB into fire-and-forget mode if conveyor isn't set.  Otherwise,
- *	put it into conveyor belt mode with the specified number of credits.
- */
-static void hub_setup_prb(nasid_t nasid, int prbnum, int credits)
-{
-	union iprb_u prb;
-	int prb_offset;
-
-	/*
-	 * Get the current register value.
-	 */
-	prb_offset = IIO_IOPRB(prbnum);
-	prb.iprb_regval = REMOTE_HUB_L(nasid, prb_offset);
-
-	/*
-	 * Clear out some fields.
-	 */
-	prb.iprb_ovflow = 1;
-	prb.iprb_bnakctr = 0;
-	prb.iprb_anakctr = 0;
-
-	/*
-	 * Enable or disable fire-and-forget mode.
-	 */
-	prb.iprb_ff = force_fire_and_forget ? 1 : 0;
-
-	/*
-	 * Set the appropriate number of PIO credits for the widget.
-	 */
-	prb.iprb_xtalkctr = credits;
-
-	/*
-	 * Store the new value to the register.
-	 */
-	REMOTE_HUB_S(nasid, prb_offset, prb.iprb_regval);
-}
-
-/**
- * hub_set_piomode  -  set pio mode for a given hub
- *
- * @nasid:	physical node ID for the hub in question
- *
- * Put the hub into either "PIO conveyor belt" mode or "fire-and-forget" mode.
- * To do this, we have to make absolutely sure that no PIOs are in progress
- * so we turn off access to all widgets for the duration of the function.
- *
- * XXX - This code should really check what kind of widget we're talking
- * to.	Bridges can only handle three requests, but XG will do more.
- * How many can crossbow handle to widget 0?  We're assuming 1.
- *
- * XXX - There is a bug in the crossbow that link reset PIOs do not
- * return write responses.  The easiest solution to this problem is to
- * leave widget 0 (xbow) in fire-and-forget mode at all times.	This
- * only affects pio's to xbow registers, which should be rare.
- **/
-static void hub_set_piomode(nasid_t nasid)
-{
-	u64 ii_iowa;
-	union hubii_wcr_u ii_wcr;
-	unsigned i;
-
-	ii_iowa = REMOTE_HUB_L(nasid, IIO_OUTWIDGET_ACCESS);
-	REMOTE_HUB_S(nasid, IIO_OUTWIDGET_ACCESS, 0);
-
-	ii_wcr.wcr_reg_value = REMOTE_HUB_L(nasid, IIO_WCR);
-
-	if (ii_wcr.iwcr_dir_con) {
-		/*
-		 * Assume a bridge here.
-		 */
-		hub_setup_prb(nasid, 0, 3);
-	} else {
-		/*
-		 * Assume a crossbow here.
-		 */
-		hub_setup_prb(nasid, 0, 1);
-	}
-
-	/*
-	 * XXX - Here's where we should take the widget type into
-	 * when account assigning credits.
-	 */
-	for (i = HUB_WIDGET_ID_MIN; i <= HUB_WIDGET_ID_MAX; i++)
-		hub_setup_prb(nasid, i, 3);
-
-	REMOTE_HUB_S(nasid, IIO_OUTWIDGET_ACCESS, ii_iowa);
-}
-
-/*
- * hub_pio_init	 -  PIO-related hub initialization
- *
- * @hub:	hubinfo structure for our hub
- */
-void hub_pio_init(nasid_t nasid)
-{
-	unsigned i;
-
-	/* initialize big window piomaps for this hub */
-	bitmap_zero(hub_data(nasid)->h_bigwin_used, HUB_NUM_BIG_WINDOW);
-	for (i = 0; i < HUB_NUM_BIG_WINDOW; i++)
-		IIO_ITTE_DISABLE(nasid, i);
-
-	hub_set_piomode(nasid);
-}
diff --git a/arch/mips/sgi-ip27/ip27-irq.c b/arch/mips/sgi-ip27/ip27-irq.c
index a0dd3bd2b81b..8f5299b269e7 100644
--- a/arch/mips/sgi-ip27/ip27-irq.c
+++ b/arch/mips/sgi-ip27/ip27-irq.c
@@ -23,6 +23,8 @@
 #include <asm/sn/intr.h>
 #include <asm/sn/irq_alloc.h>
 
+#include "ip27-common.h"
+
 struct hub_irq_data {
 	u64	*irq_mask[2];
 	cpuid_t	cpu;
diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
index f79c48393716..b8ca94cfb4fe 100644
--- a/arch/mips/sgi-ip27/ip27-memory.c
+++ b/arch/mips/sgi-ip27/ip27-memory.c
@@ -23,6 +23,7 @@
 #include <asm/page.h>
 #include <asm/pgalloc.h>
 #include <asm/sections.h>
+#include <asm/sgialib.h>
 
 #include <asm/sn/arch.h>
 #include <asm/sn/agent.h>
diff --git a/arch/mips/sgi-ip27/ip27-nmi.c b/arch/mips/sgi-ip27/ip27-nmi.c
index 84889b57d5ff..fc2816398d0c 100644
--- a/arch/mips/sgi-ip27/ip27-nmi.c
+++ b/arch/mips/sgi-ip27/ip27-nmi.c
@@ -11,6 +11,8 @@
 #include <asm/sn/arch.h>
 #include <asm/sn/agent.h>
 
+#include "ip27-common.h"
+
 #if 0
 #define NODE_NUM_CPUS(n)	CNODE_NUM_CPUS(n)
 #else
@@ -23,16 +25,7 @@
 typedef unsigned long machreg_t;
 
 static arch_spinlock_t nmi_lock = __ARCH_SPIN_LOCK_UNLOCKED;
-
-/*
- * Let's see what else we need to do here. Set up sp, gp?
- */
-void nmi_dump(void)
-{
-	void cont_nmi_dump(void);
-
-	cont_nmi_dump();
-}
+static void nmi_dump(void);
 
 void install_cpu_nmi_handler(int slice)
 {
@@ -53,7 +46,7 @@ void install_cpu_nmi_handler(int slice)
  * into the eframe format for the node under consideration.
  */
 
-void nmi_cpu_eframe_save(nasid_t nasid, int slice)
+static void nmi_cpu_eframe_save(nasid_t nasid, int slice)
 {
 	struct reg_struct *nr;
 	int		i;
@@ -129,7 +122,7 @@ void nmi_cpu_eframe_save(nasid_t nasid, int slice)
 	pr_emerg("\n");
 }
 
-void nmi_dump_hub_irq(nasid_t nasid, int slice)
+static void nmi_dump_hub_irq(nasid_t nasid, int slice)
 {
 	u64 mask0, mask1, pend0, pend1;
 
@@ -153,7 +146,7 @@ void nmi_dump_hub_irq(nasid_t nasid, int slice)
  * Copy the cpu registers which have been saved in the IP27prom format
  * into the eframe format for the node under consideration.
  */
-void nmi_node_eframe_save(nasid_t nasid)
+static void nmi_node_eframe_save(nasid_t nasid)
 {
 	int slice;
 
@@ -170,8 +163,7 @@ void nmi_node_eframe_save(nasid_t nasid)
 /*
  * Save the nmi cpu registers for all cpus in the system.
  */
-void
-nmi_eframes_save(void)
+static void nmi_eframes_save(void)
 {
 	nasid_t nasid;
 
@@ -179,8 +171,7 @@ nmi_eframes_save(void)
 		nmi_node_eframe_save(nasid);
 }
 
-void
-cont_nmi_dump(void)
+static void nmi_dump(void)
 {
 #ifndef REAL_NMI_SIGNAL
 	static atomic_t nmied_cpus = ATOMIC_INIT(0);
-- 
2.35.3


