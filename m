Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D167726C5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbjHGNzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbjHGNxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:53:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E6E10E3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:53:02 -0700 (PDT)
Message-ID: <20230807135027.325035194@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=YQj0mbugupK3s4rnQKmheA6BGCf72U3w0+Zs2FhDv6A=;
        b=ULdCZPdaFlo1JW2L27s8mHzKDfVh2jhr+Gls01doUvEMntO323Nu/G8Cl/BAdNbCMNKRRR
        /t0ItSKzRMeZevIzvA2pnG1Fdr4eehGlpBDZbXkBdB2jXmM/gW3fCTHbUZ4NgEKMxod+2V
        /FeHZKdMNugTIX567QSqEMhkhjBGolerHkNXtQO+3pB3voH6AwSWGBRt32dQTZcd/6dyxv
        aNGrWjjlkPAbiGeQKzewMc9+R6bYJD03seuad1FiIR5xYTriuV53GWOtboXzHTkYymCoAJ
        yzQ4uhnBGmQ0tDthAMdxE9p8BEr/7egmBW+3MZDOdt3ULmDGmuk/xY5OoSeLqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=YQj0mbugupK3s4rnQKmheA6BGCf72U3w0+Zs2FhDv6A=;
        b=QD11Y5qSxj9ajqI/xG8qBcB7MRf+scLbnryYlvCpyD98y4KsLJDEa80APB2QJnyh8WZDGt
        PEA70GosbDsEiXCg==
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
Subject: [patch 17/53] x86/mpparse: Switch to new init callbacks
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:53:00 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all platforms have the new split SMP configuration callbacks set
up, flip the switch and remove the old callback pointer and mop up the
platform code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/mpspec.h           |    9 +--------
 arch/x86/include/asm/x86_init.h         |    2 --
 arch/x86/kernel/jailhouse.c             |    8 +-------
 arch/x86/kernel/mpparse.c               |    2 +-
 arch/x86/kernel/setup.c                 |   10 +++-------
 arch/x86/kernel/x86_init.c              |    3 ++-
 arch/x86/platform/ce4100/ce4100.c       |    1 -
 arch/x86/platform/intel-mid/intel-mid.c |    1 -
 arch/x86/xen/smp_pv.c                   |   11 +----------
 9 files changed, 9 insertions(+), 38 deletions(-)

--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -46,14 +46,9 @@ extern int smp_found_config;
 # define smp_found_config 0
 #endif
 
-static inline void get_smp_config(void)
-{
-	x86_init.mpparse.get_smp_config(0);
-}
-
 static inline void early_get_smp_config(void)
 {
-	x86_init.mpparse.get_smp_config(1);
+	x86_init.mpparse.early_parse_smp_cfg();
 }
 
 #ifdef CONFIG_X86_MPPARSE
@@ -62,14 +57,12 @@ extern int enable_update_mptable;
 extern void mpparse_find_mptable(void);
 extern void mpparse_parse_early_smp_config(void);
 extern void mpparse_parse_smp_config(void);
-extern void mpparse_get_smp_config(unsigned int early);
 #else
 static inline void e820__memblock_alloc_reserved_mpc_new(void) { }
 #define enable_update_mptable		(0)
 #define mpparse_find_mptable		x86_init_noop
 #define mpparse_parse_early_smp_config	x86_init_noop
 #define mpparse_parse_smp_config	x86_init_noop
-#define mpparse_get_smp_config		x86_init_uint_noop
 #endif
 
 int generic_processor_info(int apicid);
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -16,14 +16,12 @@ struct irq_domain;
  * struct x86_init_mpparse - platform specific mpparse ops
  * @setup_ioapic_ids:		platform specific ioapic id override
  * @find_mptable:		Find MPTABLE early to reserve the memory region
- * @get_smp_config:		get the smp configuration
  * @early_parse_smp_cfg:	Parse the SMP configuration data early before initmem_init()
  * @parse_smp_cfg:		Parse the SMP configuration data
  */
 struct x86_init_mpparse {
 	void (*setup_ioapic_ids)(void);
 	void (*find_mptable)(void);
-	void (*get_smp_config)(unsigned int early);
 	void (*early_parse_smp_cfg)(void);
 	void (*parse_smp_cfg)(void);
 };
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -89,7 +89,7 @@ static void __init jailhouse_x2apic_init
 #endif
 }
 
-static void __init jailhouse_get_smp_config(unsigned int early)
+static void __init jailhouse_parse_smp_config(void)
 {
 	struct ioapic_domain_cfg ioapic_cfg = {
 		.type = IOAPIC_DOMAIN_STRICT,
@@ -118,11 +118,6 @@ static void __init jailhouse_get_smp_con
 	}
 }
 
-static void __init jailhouse_parse_smp_config(void)
-{
-	jailhouse_get_smp_config(false);
-}
-
 static void jailhouse_no_restart(void)
 {
 	pr_notice("Jailhouse: Restart not supported, halting\n");
@@ -211,7 +206,6 @@ static void __init jailhouse_init_platfo
 	x86_init.mpparse.find_mptable		= x86_init_noop;
 	x86_init.mpparse.early_parse_smp_cfg	= x86_init_noop;
 	x86_init.mpparse.parse_smp_cfg		= jailhouse_parse_smp_config;
-	x86_init.mpparse.get_smp_config		= jailhouse_get_smp_config;
 	x86_init.pci.arch_init			= jailhouse_pci_arch_init;
 
 	x86_platform.calibrate_cpu		= jailhouse_get_tsc;
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -476,7 +476,7 @@ static int __init check_physptr(struct m
 /*
  * Scan the memory blocks for an SMP configuration block.
  */
-void __init mpparse_get_smp_config(unsigned int early)
+static __init void mpparse_get_smp_config(unsigned int early)
 {
 	struct mpf_intel *mpf;
 
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1257,15 +1257,11 @@ void __init setup_arch(char **cmdline_p)
 	early_quirks();
 
 	/*
-	 * Read APIC and some other early information from ACPI tables.
+	 * Parse SMP configuration. Try ACPI first and then the platform
+	 * specific parser.
 	 */
 	acpi_boot_init();
-	x86_dtb_parse_smp_config();
-
-	/*
-	 * get boot-time SMP configuration:
-	 */
-	get_smp_config();
+	x86_init.mpparse.parse_smp_cfg();
 
 	/*
 	 * Systems w/o ACPI and mptables might not have it mapped the local
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -71,7 +71,8 @@ struct x86_init_ops x86_init __initdata
 	.mpparse = {
 		.setup_ioapic_ids	= x86_init_noop,
 		.find_mptable		= mpparse_find_mptable,
-		.get_smp_config		= mpparse_get_smp_config,
+		.early_parse_smp_cfg	= mpparse_parse_early_smp_config,
+		.parse_smp_cfg		= mpparse_parse_smp_config,
 	},
 
 	.irqs = {
--- a/arch/x86/platform/ce4100/ce4100.c
+++ b/arch/x86/platform/ce4100/ce4100.c
@@ -140,7 +140,6 @@ void __init x86_ce4100_early_setup(void)
 	x86_init.mpparse.find_mptable		= x86_init_noop;
 	x86_init.mpparse.early_parse_smp_cfg	= x86_init_noop;
 	x86_init.mpparse.parse_smp_cfg		= x86_dtb_parse_smp_config;
-	x86_init.mpparse.get_smp_config		= x86_init_uint_noop;
 	x86_init.pci.init			= ce4100_pci_init;
 	x86_init.pci.init_irq			= sdv_pci_init;
 
--- a/arch/x86/platform/intel-mid/intel-mid.c
+++ b/arch/x86/platform/intel-mid/intel-mid.c
@@ -121,6 +121,5 @@ void __init x86_intel_mid_early_setup(vo
 	x86_init.mpparse.find_mptable		= x86_init_noop;
 	x86_init.mpparse.early_parse_smp_cfg	= x86_init_noop;
 	x86_init.mpparse.parse_smp_cfg		= x86_init_noop;
-	x86_init.mpparse.get_smp_config		= x86_init_uint_noop;
 	set_bit(MP_BUS_ISA, mp_bus_not_pci);
 }
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -148,14 +148,11 @@ int xen_smp_intr_init_pv(unsigned int cp
 	return rc;
 }
 
-static void __init _get_smp_config(unsigned int early)
+static void __init xen_pv_smp_config(void)
 {
 	int i, rc;
 	unsigned int subtract = 0;
 
-	if (early)
-		return;
-
 	num_processors = 0;
 	disabled_cpus = 0;
 	for (i = 0; i < nr_cpu_ids; i++) {
@@ -185,11 +182,6 @@ static void __init _get_smp_config(unsig
 	smp_found_config = 1;
 }
 
-static void __init xen_pv_smp_config(void)
-{
-	_get_smp_config(false);
-}
-
 static void __init xen_pv_smp_prepare_boot_cpu(void)
 {
 	BUG_ON(smp_processor_id() != 0);
@@ -463,5 +455,4 @@ void __init xen_smp_init(void)
 	x86_init.mpparse.find_mptable		= x86_init_noop;
 	x86_init.mpparse.early_parse_smp_cfg	= x86_init_noop;
 	x86_init.mpparse.parse_smp_cfg		= xen_pv_smp_config;
-	x86_init.mpparse.get_smp_config		= _get_smp_config;
 }

