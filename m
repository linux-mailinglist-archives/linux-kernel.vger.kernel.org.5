Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747297726A0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbjHGNxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbjHGNwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:52:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35554199C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:52:50 -0700 (PDT)
Message-ID: <20230807135026.906384570@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=/DR2OONcUrrpFOC5EnxrVQq2tzbpo7dJzpul3Y8MqQY=;
        b=Ggxxph+xB6huRwFVex14SKwImIP+1HUAKvsn/9s/9Rf2zM95rOa8S+fiNCvSVi8jcMMBUe
        1aauBPqsooZBq2jNLD3i9kp+okDoQEfCeER8gCzwUTYrMpsX/x4FGcFhGWPMxsaeofBORf
        7GGMBFCg2HhHGsNn0cCSfKH80T0FyzVt4NbUhNkFzq76BczCZIoNevj1QLuJI4+tEXHKEi
        TVc1BorBB+bmVjiLhf3f9euIX5i8QT4sPY5M1nAcrQZuyMvvN7XL8fPCLx2dCfIC2spOJh
        1aR52Kffnvd1QG4SR5aKvwI07chg28WbS91eDVHTy5s+PgtTngVWbzoLxHoSKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=/DR2OONcUrrpFOC5EnxrVQq2tzbpo7dJzpul3Y8MqQY=;
        b=Mounl2QHL3IJulfH/WvCyDPKfqXww4d3rDp0mRc8KCcYVKFNkd/dDT/DynM50UIgX0yJzQ
        saDKJcW/5b2De6Cw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
Subject: [patch 09/53] x86/mpparse: Rename default_find_smp_config()
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:52:47 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MPTABLE is not longer the default SMP configuration mechanism.
Rename it to mpparse_find_mptable() because that's what it does.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/mpspec.h           |   13 ++++---------
 arch/x86/include/asm/x86_init.h         |    4 ++--
 arch/x86/kernel/mpparse.c               |    2 +-
 arch/x86/kernel/setup.c                 |    6 ++----
 arch/x86/kernel/x86_init.c              |    2 +-
 arch/x86/platform/ce4100/ce4100.c       |    2 +-
 arch/x86/platform/intel-mid/intel-mid.c |    2 +-
 arch/x86/xen/smp_pv.c                   |    2 +-
 8 files changed, 13 insertions(+), 20 deletions(-)

--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -56,21 +56,16 @@ static inline void early_get_smp_config(
 	x86_init.mpparse.get_smp_config(1);
 }
 
-static inline void find_smp_config(void)
-{
-	x86_init.mpparse.find_smp_config();
-}
-
 #ifdef CONFIG_X86_MPPARSE
 extern void e820__memblock_alloc_reserved_mpc_new(void);
 extern int enable_update_mptable;
-extern void default_find_smp_config(void);
+extern void mpparse_find_mptable(void);
 extern void default_get_smp_config(unsigned int early);
 #else
 static inline void e820__memblock_alloc_reserved_mpc_new(void) { }
-#define enable_update_mptable 0
-#define default_find_smp_config x86_init_noop
-#define default_get_smp_config x86_init_uint_noop
+#define enable_update_mptable	(0)
+#define mpparse_find_mptable	x86_init_noop
+#define default_get_smp_config	x86_init_uint_noop
 #endif
 
 int generic_processor_info(int apicid);
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -15,12 +15,12 @@ struct irq_domain;
 /**
  * struct x86_init_mpparse - platform specific mpparse ops
  * @setup_ioapic_ids:		platform specific ioapic id override
- * @find_smp_config:		find the smp configuration
+ * @find_mptable:		Find MPTABLE early to reserve the memory region
  * @get_smp_config:		get the smp configuration
  */
 struct x86_init_mpparse {
 	void (*setup_ioapic_ids)(void);
-	void (*find_smp_config)(void);
+	void (*find_mptable)(void);
 	void (*get_smp_config)(unsigned int early);
 };
 
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -590,7 +590,7 @@ static int __init smp_scan_config(unsign
 	return ret;
 }
 
-void __init default_find_smp_config(void)
+void __init mpparse_find_mptable(void)
 {
 	unsigned int address;
 
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1101,10 +1101,8 @@ void __init setup_arch(char **cmdline_p)
 	high_memory = (void *)__va(max_pfn * PAGE_SIZE - 1) + 1;
 #endif
 
-	/*
-	 * Find and reserve possible boot-time SMP configuration:
-	 */
-	find_smp_config();
+	/* Find and reserve MPTABLE area */
+	x86_init.mpparse.find_mptable();
 
 	early_alloc_pgt_buf();
 
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -70,7 +70,7 @@ struct x86_init_ops x86_init __initdata
 
 	.mpparse = {
 		.setup_ioapic_ids	= x86_init_noop,
-		.find_smp_config	= default_find_smp_config,
+		.find_mptable		= mpparse_find_mptable,
 		.get_smp_config		= default_get_smp_config,
 	},
 
--- a/arch/x86/platform/ce4100/ce4100.c
+++ b/arch/x86/platform/ce4100/ce4100.c
@@ -138,7 +138,7 @@ void __init x86_ce4100_early_setup(void)
 	x86_init.oem.arch_setup = sdv_arch_setup;
 	x86_init.resources.probe_roms = x86_init_noop;
 	x86_init.mpparse.get_smp_config = x86_init_uint_noop;
-	x86_init.mpparse.find_smp_config = x86_init_noop;
+	x86_init.mpparse.find_mptable = x86_init_noop;
 	x86_init.pci.init = ce4100_pci_init;
 	x86_init.pci.init_irq = sdv_pci_init;
 
--- a/arch/x86/platform/intel-mid/intel-mid.c
+++ b/arch/x86/platform/intel-mid/intel-mid.c
@@ -118,7 +118,7 @@ void __init x86_intel_mid_early_setup(vo
 	machine_ops.emergency_restart  = intel_mid_reboot;
 
 	/* Avoid searching for BIOS MP tables */
-	x86_init.mpparse.find_smp_config = x86_init_noop;
+	x86_init.mpparse.find_mptable = x86_init_noop;
 	x86_init.mpparse.get_smp_config = x86_init_uint_noop;
 	set_bit(MP_BUS_ISA, mp_bus_not_pci);
 }
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -455,6 +455,6 @@ void __init xen_smp_init(void)
 	smp_ops = xen_smp_ops;
 
 	/* Avoid searching for BIOS MP tables */
-	x86_init.mpparse.find_smp_config = x86_init_noop;
+	x86_init.mpparse.find_mptable = x86_init_noop;
 	x86_init.mpparse.get_smp_config = _get_smp_config;
 }

