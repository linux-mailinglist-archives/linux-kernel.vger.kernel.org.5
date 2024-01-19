Return-Path: <linux-kernel+bounces-31226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 318B3832ACA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEF7B288400
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CE452F8E;
	Fri, 19 Jan 2024 13:52:59 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07A252F6E;
	Fri, 19 Jan 2024 13:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705672378; cv=none; b=LoGYaYnekrhmlOJqdH72ldjbJuIcJ/YKC2kKEiihbsff3GMr/0N501eu52gHKqwG0DIC3nwU9kL+74jJugRhpJL+eEW/SiUVb9xnD0kJwgoYk0N7ED0MwHHSgB91e+mLECPE92OvhdJUGIGzYlkVL+ygmCUHpJywnyt0XXmSh4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705672378; c=relaxed/simple;
	bh=8Nn6GCGORp9/RHlSu4rLSYch3flHwv2TA+p1drrK3T8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=sCqNcWAyOsn/xecDmzdaZZD1PjS9qYE3MD4mSkCnNJg7i2JqQUnhEBsptOnSUeIyWEnwE4YPaCElshYT3/+bJBfP/gye82VjegLzkmU6Gjf+pku2MOJpevWT45zaxKZa8hO9suXZiPGId/0bpn8p3ZZZzR5ER4ne5O9Jn8O1FUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=fail smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=alpha.franken.de
Received: from hutton.arch.nue2.suse.org (unknown [10.168.144.140])
	by smtp-out1.suse.de (Postfix) with ESMTP id 13D7421E98;
	Fri, 19 Jan 2024 13:52:54 +0000 (UTC)
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: sgi-ip32: Fix missing prototypes
Date: Fri, 19 Jan 2024 14:52:51 +0100
Message-Id: <20240119135252.112460-1-tsbogend@alpha.franken.de>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [10.00 / 50.00];
	 ARC_NA(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[franken.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+]
X-Spam-Level: **********
X-Spam-Score: 10.00
X-Spam-Flag: NO

Fix interrupt function prototypes, move all prototypes into a new
file ip32-common.h and include it where needed.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/sgi-ip32/crime.c       |  6 ++++--
 arch/mips/sgi-ip32/ip32-berr.c   |  2 ++
 arch/mips/sgi-ip32/ip32-common.h | 15 +++++++++++++++
 arch/mips/sgi-ip32/ip32-irq.c    |  6 ++----
 arch/mips/sgi-ip32/ip32-memory.c |  1 +
 arch/mips/sgi-ip32/ip32-reset.c  |  2 ++
 arch/mips/sgi-ip32/ip32-setup.c  |  3 +--
 7 files changed, 27 insertions(+), 8 deletions(-)
 create mode 100644 arch/mips/sgi-ip32/ip32-common.h

diff --git a/arch/mips/sgi-ip32/crime.c b/arch/mips/sgi-ip32/crime.c
index a8e0c776ca6c..b8a0e4cfa9ce 100644
--- a/arch/mips/sgi-ip32/crime.c
+++ b/arch/mips/sgi-ip32/crime.c
@@ -18,6 +18,8 @@
 #include <asm/ip32/crime.h>
 #include <asm/ip32/mace.h>
 
+#include "ip32-common.h"
+
 struct sgi_crime __iomem *crime;
 struct sgi_mace __iomem *mace;
 
@@ -39,7 +41,7 @@ void __init crime_init(void)
 	       id, rev, field, (unsigned long) CRIME_BASE);
 }
 
-irqreturn_t crime_memerr_intr(unsigned int irq, void *dev_id)
+irqreturn_t crime_memerr_intr(int irq, void *dev_id)
 {
 	unsigned long stat, addr;
 	int fatal = 0;
@@ -90,7 +92,7 @@ irqreturn_t crime_memerr_intr(unsigned int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-irqreturn_t crime_cpuerr_intr(unsigned int irq, void *dev_id)
+irqreturn_t crime_cpuerr_intr(int irq, void *dev_id)
 {
 	unsigned long stat = crime->cpu_error_stat & CRIME_CPU_ERROR_MASK;
 	unsigned long addr = crime->cpu_error_addr & CRIME_CPU_ERROR_ADDR_MASK;
diff --git a/arch/mips/sgi-ip32/ip32-berr.c b/arch/mips/sgi-ip32/ip32-berr.c
index 478b63b4c808..7cbc27941f92 100644
--- a/arch/mips/sgi-ip32/ip32-berr.c
+++ b/arch/mips/sgi-ip32/ip32-berr.c
@@ -18,6 +18,8 @@
 #include <asm/ptrace.h>
 #include <asm/tlbdebug.h>
 
+#include "ip32-common.h"
+
 static int ip32_be_handler(struct pt_regs *regs, int is_fixup)
 {
 	int data = regs->cp0_cause & 4;
diff --git a/arch/mips/sgi-ip32/ip32-common.h b/arch/mips/sgi-ip32/ip32-common.h
new file mode 100644
index 000000000000..cfc0225b1419
--- /dev/null
+++ b/arch/mips/sgi-ip32/ip32-common.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __IP32_COMMON_H
+#define __IP32_COMMON_H
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+
+void __init crime_init(void);
+irqreturn_t crime_memerr_intr(int irq, void *dev_id);
+irqreturn_t crime_cpuerr_intr(int irq, void *dev_id);
+void __init ip32_be_init(void);
+void ip32_prepare_poweroff(void);
+
+#endif /* __IP32_COMMON_H */
diff --git a/arch/mips/sgi-ip32/ip32-irq.c b/arch/mips/sgi-ip32/ip32-irq.c
index e21ea1de05e3..29d04468a06b 100644
--- a/arch/mips/sgi-ip32/ip32-irq.c
+++ b/arch/mips/sgi-ip32/ip32-irq.c
@@ -28,6 +28,8 @@
 #include <asm/ip32/mace.h>
 #include <asm/ip32/ip32_ints.h>
 
+#include "ip32-common.h"
+
 /* issue a PIO read to make sure no PIO writes are pending */
 static inline void flush_crime_bus(void)
 {
@@ -107,10 +109,6 @@ static inline void flush_mace_bus(void)
  * is quite different anyway.
  */
 
-/* Some initial interrupts to set up */
-extern irqreturn_t crime_memerr_intr(int irq, void *dev_id);
-extern irqreturn_t crime_cpuerr_intr(int irq, void *dev_id);
-
 /*
  * This is for pure CRIME interrupts - ie not MACE.  The advantage?
  * We get to split the register in half and do faster lookups.
diff --git a/arch/mips/sgi-ip32/ip32-memory.c b/arch/mips/sgi-ip32/ip32-memory.c
index 3fc8d0a0bdfa..5fee33744f67 100644
--- a/arch/mips/sgi-ip32/ip32-memory.c
+++ b/arch/mips/sgi-ip32/ip32-memory.c
@@ -15,6 +15,7 @@
 #include <asm/ip32/crime.h>
 #include <asm/bootinfo.h>
 #include <asm/page.h>
+#include <asm/sgialib.h>
 
 extern void crime_init(void);
 
diff --git a/arch/mips/sgi-ip32/ip32-reset.c b/arch/mips/sgi-ip32/ip32-reset.c
index 18d1c115cd53..6bdc1421cda4 100644
--- a/arch/mips/sgi-ip32/ip32-reset.c
+++ b/arch/mips/sgi-ip32/ip32-reset.c
@@ -29,6 +29,8 @@
 #include <asm/ip32/crime.h>
 #include <asm/ip32/ip32_ints.h>
 
+#include "ip32-common.h"
+
 #define POWERDOWN_TIMEOUT	120
 /*
  * Blink frequency during reboot grace period and when panicked.
diff --git a/arch/mips/sgi-ip32/ip32-setup.c b/arch/mips/sgi-ip32/ip32-setup.c
index 8019dae1721a..aeb0805aae57 100644
--- a/arch/mips/sgi-ip32/ip32-setup.c
+++ b/arch/mips/sgi-ip32/ip32-setup.c
@@ -26,8 +26,7 @@
 #include <asm/ip32/mace.h>
 #include <asm/ip32/ip32_ints.h>
 
-extern void ip32_be_init(void);
-extern void crime_init(void);
+#include "ip32-common.h"
 
 #ifdef CONFIG_SGI_O2MACE_ETH
 /*
-- 
2.35.3


