Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526E1776A3B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbjHIUge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbjHIUgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:36:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01694211B;
        Wed,  9 Aug 2023 13:36:10 -0700 (PDT)
Date:   Wed, 09 Aug 2023 20:36:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691613368;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=bimBVY8RdmfT0LAkUV4jrKBGiIhXO+0jFslavpxZtLs=;
        b=JhYPAI3B6XoED6OHEFgOYbd3MJNhNYzfyQSJ+MOs5V1QzxYyCUg8bsboUYgWzwx+ddtgXR
        UE2HbuVnIwEOE12bGjAANKKGolb5NbOaQoU4YKjyaYNbeoawAW1nz7EaHtzoR5QRHsPX5a
        +ShLBVOqkNn1DT4pXHfm9cMcUxk13KfwQ3ippoP9cykt2y6N39AZ7aVDvBlvXeYsby/x3q
        FcMWGjCqTnk/71MVoVYo8zh+oKBTtlVZ6CEr/nE9S4DUDXebL3mDmEj4nWQloTcGMmax59
        9TOewUSDQnaEknZlZ22s26S4BEf+7pO8xw4GZqQpsICod5MXilxGnXM/DbY8Yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691613368;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=bimBVY8RdmfT0LAkUV4jrKBGiIhXO+0jFslavpxZtLs=;
        b=2LS0jn0TRpUNKHLikt0+qmqL+Jsg21MaLH7JxpGT4fE0V/XU2hHBxOISCIkS6PObxjtdDA
        nTRoEikxOe5WyGCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Provide common init infrastructure
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169161336811.27769.16060148631353900017.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     3af1e415e4d43128b72af615b346b832694377d3
Gitweb:        https://git.kernel.org/tip/3af1e415e4d43128b72af615b346b832694377d3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:04:18 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:34 -07:00

x86/apic: Provide common init infrastructure

In preparation for converting the hotpath APIC callbacks to static keys,
provide common initialization infrastructure.

Lift apic_install_drivers() from probe_64.c and convert all places which
switch the apic instance by storing the pointer to use apic_install_driver()
as a first step.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/include/asm/apic.h         |  2 +-
 arch/x86/kernel/apic/Makefile       |  2 +-
 arch/x86/kernel/apic/apic.c         | 31 +------------------
 arch/x86/kernel/apic/apic_flat_64.c |  6 +----
 arch/x86/kernel/apic/bigsmp_32.c    |  6 +---
 arch/x86/kernel/apic/init.c         | 47 ++++++++++++++++++++++++++++-
 arch/x86/kernel/apic/probe_32.c     |  5 +--
 arch/x86/kernel/apic/probe_64.c     | 13 +--------
 arch/x86/xen/apic.c                 | 10 +-----
 9 files changed, 59 insertions(+), 63 deletions(-)
 create mode 100644 arch/x86/kernel/apic/init.c

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 5d98c4b..90814ec 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -344,6 +344,8 @@ extern int lapic_can_unplug_cpu(void);
 
 #ifdef CONFIG_X86_LOCAL_APIC
 
+void __init apic_install_driver(struct apic *driver);
+
 static inline u32 apic_read(u32 reg)
 {
 	return apic->read(reg);
diff --git a/arch/x86/kernel/apic/Makefile b/arch/x86/kernel/apic/Makefile
index a6fcaf1..2ee867d 100644
--- a/arch/x86/kernel/apic/Makefile
+++ b/arch/x86/kernel/apic/Makefile
@@ -7,7 +7,7 @@
 # In particualr, smp_apic_timer_interrupt() is called in random places.
 KCOV_INSTRUMENT		:= n
 
-obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o apic_common.o apic_noop.o ipi.o vector.o
+obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o apic_common.o apic_noop.o ipi.o vector.o init.o
 obj-y				+= hw_nmi.o
 
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index b8b801e..55f2b96 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -236,8 +236,7 @@ static int modern_apic(void)
  */
 static void __init apic_disable(void)
 {
-	pr_info("APIC: switched to apic NOOP\n");
-	apic = &apic_noop;
+	apic_install_driver(&apic_noop);
 }
 
 void native_apic_icr_write(u32 low, u32 id)
@@ -2486,34 +2485,6 @@ u32 x86_msi_msg_get_destid(struct msi_msg *msg, bool extid)
 }
 EXPORT_SYMBOL_GPL(x86_msi_msg_get_destid);
 
-#ifdef CONFIG_X86_64
-void __init acpi_wake_cpu_handler_update(wakeup_cpu_handler handler)
-{
-	struct apic **drv;
-
-	for (drv = __apicdrivers; drv < __apicdrivers_end; drv++)
-		(*drv)->wakeup_secondary_cpu_64 = handler;
-}
-#endif
-
-/*
- * Override the generic EOI implementation with an optimized version.
- * Only called during early boot when only one CPU is active and with
- * interrupts disabled, so we know this does not race with actual APIC driver
- * use.
- */
-void __init apic_set_eoi_cb(void (*eoi)(void))
-{
-	struct apic **drv;
-
-	for (drv = __apicdrivers; drv < __apicdrivers_end; drv++) {
-		/* Should happen once for each apic */
-		WARN_ON((*drv)->eoi == eoi);
-		(*drv)->native_eoi = (*drv)->eoi;
-		(*drv)->eoi = eoi;
-	}
-}
-
 static void __init apic_bsp_up_setup(void)
 {
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index 5ce1b37..032a84e 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -143,11 +143,7 @@ static int physflat_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 
 static int physflat_probe(void)
 {
-	if (apic == &apic_physflat || num_possible_cpus() > 8 ||
-	    jailhouse_paravirt())
-		return 1;
-
-	return 0;
+	return apic == &apic_physflat || num_possible_cpus() > 8 || jailhouse_paravirt();
 }
 
 static struct apic apic_physflat __ro_after_init = {
diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
index 23c29a0..0e5535a 100644
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -119,10 +119,8 @@ bool __init apic_bigsmp_possible(bool cmdline_override)
 
 void __init apic_bigsmp_force(void)
 {
-	if (apic != &apic_bigsmp) {
-		apic = &apic_bigsmp;
-		pr_info("Overriding APIC driver with bigsmp\n");
-	}
+	if (apic != &apic_bigsmp)
+		apic_install_driver(&apic_bigsmp);
 }
 
 apic_driver(apic_bigsmp);
diff --git a/arch/x86/kernel/apic/init.c b/arch/x86/kernel/apic/init.c
new file mode 100644
index 0000000..25cf39b
--- /dev/null
+++ b/arch/x86/kernel/apic/init.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#define pr_fmt(fmt) "APIC: " fmt
+
+#include <asm/apic.h>
+
+#include "local.h"
+
+void __init apic_install_driver(struct apic *driver)
+{
+	if (apic == driver)
+		return;
+
+	apic = driver;
+
+	if (IS_ENABLED(CONFIG_X86_X2APIC) && apic->x2apic_set_max_apicid)
+		apic->max_apic_id = x2apic_max_apicid;
+
+	pr_info("Switched APIC routing to: %s\n", driver->name);
+}
+
+#ifdef CONFIG_X86_64
+void __init acpi_wake_cpu_handler_update(wakeup_cpu_handler handler)
+{
+	struct apic **drv;
+
+	for (drv = __apicdrivers; drv < __apicdrivers_end; drv++)
+		(*drv)->wakeup_secondary_cpu_64 = handler;
+}
+#endif
+
+/*
+ * Override the generic EOI implementation with an optimized version.
+ * Only called during early boot when only one CPU is active and with
+ * interrupts disabled, so we know this does not race with actual APIC driver
+ * use.
+ */
+void __init apic_set_eoi_cb(void (*eoi)(void))
+{
+	struct apic **drv;
+
+	for (drv = __apicdrivers; drv < __apicdrivers_end; drv++) {
+		/* Should happen once for each apic */
+		WARN_ON((*drv)->eoi == eoi);
+		(*drv)->native_eoi = (*drv)->eoi;
+		(*drv)->eoi = eoi;
+	}
+}
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index 3671cc1..9a06df6 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -82,7 +82,7 @@ static int __init parse_apic(char *arg)
 
 	for (drv = __apicdrivers; drv < __apicdrivers_end; drv++) {
 		if (!strcmp((*drv)->name, arg)) {
-			apic = *drv;
+			apic_install_driver(*drv);
 			cmdline_apic = 1;
 			return 0;
 		}
@@ -129,7 +129,7 @@ void __init x86_32_probe_apic(void)
 
 		for (drv = __apicdrivers; drv < __apicdrivers_end; drv++) {
 			if ((*drv)->probe()) {
-				apic = *drv;
+				apic_install_driver(*drv);
 				break;
 			}
 		}
@@ -137,5 +137,4 @@ void __init x86_32_probe_apic(void)
 		if (drv == __apicdrivers_end)
 			panic("Didn't find an APIC driver");
 	}
-	printk(KERN_INFO "Using APIC driver %s\n", apic->name);
 }
diff --git a/arch/x86/kernel/apic/probe_64.c b/arch/x86/kernel/apic/probe_64.c
index a12a379..ecdf0c4 100644
--- a/arch/x86/kernel/apic/probe_64.c
+++ b/arch/x86/kernel/apic/probe_64.c
@@ -13,19 +13,6 @@
 
 #include "local.h"
 
-static __init void apic_install_driver(struct apic *driver)
-{
-	if (apic == driver)
-		return;
-
-	apic = driver;
-
-	if (IS_ENABLED(CONFIG_X86_X2APIC) && apic->x2apic_set_max_apicid)
-		apic->max_apic_id = x2apic_max_apicid;
-
-	pr_info("Switched APIC routing to %s:\n", apic->name);
-}
-
 /* Select the appropriate APIC driver */
 void __init x86_64_probe_apic(void)
 {
diff --git a/arch/x86/xen/apic.c b/arch/x86/xen/apic.c
index 804a26b..1838aef 100644
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -160,20 +160,16 @@ static struct apic xen_pv_apic = {
 
 static void __init xen_apic_check(void)
 {
-	if (apic == &xen_pv_apic)
-		return;
-
-	pr_info("Switched APIC routing from %s to %s.\n", apic->name,
-		xen_pv_apic.name);
-	apic = &xen_pv_apic;
+	apic_install_driver(&xen_pv_apic);
 }
+
 void __init xen_init_apic(void)
 {
 	x86_apic_ops.io_apic_read = xen_io_apic_read;
 	/* On PV guests the APIC CPUID bit is disabled so none of the
 	 * routines end up executing. */
 	if (!xen_initial_domain())
-		apic = &xen_pv_apic;
+		apic_install_driver(&xen_pv_apic);
 
 	x86_platform.apic_post_init = xen_apic_check;
 }
