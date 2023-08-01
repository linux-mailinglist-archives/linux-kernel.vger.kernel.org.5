Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6C976B25F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbjHAKwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjHAKvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:51:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CE22D5F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:49:11 -0700 (PDT)
Message-ID: <20230801103817.944932383@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690886864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=u1MBAiZCltHmWzuaN06FA6y4i5aqgal/njyPH8pNWsw=;
        b=Cw6Qaq9BB9aFNsvc/8cvvK/utELD/Ja3avMU+A1jQW22pN95MwoOKUjSOxPMVPX2xaoBXu
        NPTe/ZlMvpb2qctfHPY1xDfqkT9UZUrhoqTvtY/8skXNiUMpWCFfVA73hm9McSogrFrvww
        8H7e69qyKqWv42joDUkBsylTI9ECagwIG8yMw4p0mGSWVet7PEBWkPGUrs70JgJwhmBtts
        Lq0ZHL4d/IJSNNjqIwZ5daGsd/vnb/HVjGXbq1Kt2e0v6VaBJGu1ZSqnu243OH4lB7c46v
        1GSbZvZpqobEbcX0/5S2MUF1vE4TQnWjLdZsXq5HrETkaPbCtTlEHEYsYlIh6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690886864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=u1MBAiZCltHmWzuaN06FA6y4i5aqgal/njyPH8pNWsw=;
        b=aUCoJnyN0YEVX5l49jigXe6mgQjvNxESR70CN1npaJgsyaNgo2NLZbgRxGu6IS0SrSSLkZ
        ssdyhkQQOh/ivfAg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Peter Keresztes Schmidt <peter@keresztesschmidt.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V3 51/60] x86/apic: Provide common init infrastructure
References: <20230801103042.936020332@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  1 Aug 2023 12:47:44 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for converting the hotpath APIC callbacks to static keys,
provide common initialization inforastructure.

Lift apic_install_drivers() from probe_64.c and convert all places which
switch the apic instance by storing the pointer to use apic_install_driver()
as a first step.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/apic.h         |    2 +
 arch/x86/kernel/apic/Makefile       |    2 -
 arch/x86/kernel/apic/apic.c         |   31 -----------------------
 arch/x86/kernel/apic/apic_flat_64.c |    6 ----
 arch/x86/kernel/apic/bigsmp_32.c    |    6 +---
 arch/x86/kernel/apic/init.c         |   47 ++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/apic/probe_32.c     |    5 +--
 arch/x86/kernel/apic/probe_64.c     |   13 ---------
 arch/x86/xen/apic.c                 |   10 ++-----
 9 files changed, 59 insertions(+), 63 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -344,6 +344,8 @@ extern int lapic_can_unplug_cpu(void);
 
 #ifdef CONFIG_X86_LOCAL_APIC
 
+void __init apic_install_driver(struct apic *driver);
+
 static inline u32 apic_read(u32 reg)
 {
 	return apic->read(reg);
--- a/arch/x86/kernel/apic/Makefile
+++ b/arch/x86/kernel/apic/Makefile
@@ -7,7 +7,7 @@
 # In particualr, smp_apic_timer_interrupt() is called in random places.
 KCOV_INSTRUMENT		:= n
 
-obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o apic_common.o apic_noop.o ipi.o vector.o
+obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o apic_common.o apic_noop.o ipi.o vector.o init.o
 obj-y				+= hw_nmi.o
 
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
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
@@ -2486,34 +2485,6 @@ u32 x86_msi_msg_get_destid(struct msi_ms
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
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -143,11 +143,7 @@ static int physflat_acpi_madt_oem_check(
 
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
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -119,10 +119,8 @@ bool __init apic_bigsmp_possible(bool cm
 
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

