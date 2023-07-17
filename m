Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8ED75704E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjGQXOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjGQXOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:14:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C81DEE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:14:42 -0700 (PDT)
Message-ID: <20230717223223.317323519@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=F/lkmcLew6wqhkY5nJAZg4imK+gggfMNV+OuyUmPL8o=;
        b=uiFj6CC6v/py1Hit7tvREfXSrDdl8w9xO+wN+Mr35tSIF1WJcillzcqndfYZoFIS0Cq70f
        KknJhHr/Gg0MnpqRg7Y+BKELgG0auUUjoI5EWKq6gya8zPlSk7ItJIJlOjwUa/gJseRkUl
        DFR/Cv6jmYuOGVLd3G8PtS+XoI6wd2XMs5E5Zo++suwaI9psUn/Mw3CJfKX2lvfEyVzGGy
        OAyuzEXqzu/q8ir/hX/zn2Oako1xwQfnIOpFYBQAws1nhDCou1bOAEpznPWAcnvz7/77a3
        GmAsk+/TkC42G7PC4UYZN4FUnY7Y1x1HQC9maw47xRi2e9FmnUk5SLRhhrxdoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=F/lkmcLew6wqhkY5nJAZg4imK+gggfMNV+OuyUmPL8o=;
        b=q2ghj+d5WmJExyAmN1P51i1+vZOwEurdMplxcG6ahp9nlsJkce/+Jg1dyUz0JTjqhDCpi4
        HFhQmyOcsOXn+8Aw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 04/58] x86/apic/ioapic: Rename skip_ioapic_setup
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:14:40 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another variable name which is confusing at best. Convert to bool.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/io_apic.h |    7 ++++---
 arch/x86/kernel/acpi/boot.c    |    2 +-
 arch/x86/kernel/apic/apic.c    |   12 ++++++------
 arch/x86/kernel/apic/io_apic.c |   12 ++++++------
 arch/x86/xen/smp_pv.c          |    2 +-
 5 files changed, 18 insertions(+), 17 deletions(-)

--- a/arch/x86/include/asm/io_apic.h
+++ b/arch/x86/include/asm/io_apic.h
@@ -109,8 +109,8 @@ extern int mp_irq_entries;
 /* MP IRQ source entries */
 extern struct mpc_intsrc mp_irqs[MAX_IRQ_SOURCES];
 
-/* 1 if "noapic" boot option passed */
-extern int skip_ioapic_setup;
+/* True if "noapic" boot option passed */
+extern bool ioapic_is_disabled;
 
 /* 1 if "noapic" boot option passed */
 extern int noioapicquirk;
@@ -129,7 +129,7 @@ extern unsigned long io_apic_irqs;
  * assignment of PCI IRQ's.
  */
 #define io_apic_assign_pci_irqs \
-	(mp_irq_entries && !skip_ioapic_setup && io_apic_irqs)
+	(mp_irq_entries && !ioapic_is_disabled && io_apic_irqs)
 
 struct irq_cfg;
 extern void ioapic_insert_resources(void);
@@ -179,6 +179,7 @@ extern void print_IO_APICs(void);
 #define IO_APIC_IRQ(x)		0
 #define io_apic_assign_pci_irqs 0
 #define setup_ioapic_ids_from_mpc x86_init_noop
+#define nr_ioapics		(0)
 static inline void ioapic_insert_resources(void) { }
 static inline int arch_early_ioapic_init(void) { return 0; }
 static inline void print_IO_APICs(void) {}
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1275,7 +1275,7 @@ static int __init acpi_parse_madt_ioapic
 	/*
 	 * if "noapic" boot option, don't look for IO-APICs
 	 */
-	if (skip_ioapic_setup) {
+	if (ioapic_is_disabled) {
 		pr_info("Skipping IOAPIC probe due to 'noapic' option.\n");
 		return -ENODEV;
 	}
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1691,7 +1691,7 @@ static void setup_local_APIC(void)
 	 * TODO: set up through-local-APIC from through-I/O-APIC? --macro
 	 */
 	value = apic_read(APIC_LVT0) & APIC_LVT_MASKED;
-	if (!cpu && (pic_mode || !value || skip_ioapic_setup)) {
+	if (!cpu && (pic_mode || !value || ioapic_is_disabled)) {
 		value = APIC_DM_EXTINT;
 		apic_printk(APIC_VERBOSE, "enabled ExtINT on CPU#%d\n", cpu);
 	} else {
@@ -1956,7 +1956,7 @@ void __init enable_IR_x2apic(void)
 	unsigned long flags;
 	int ret, ir_stat;
 
-	if (skip_ioapic_setup) {
+	if (ioapic_is_disabled) {
 		pr_info("Not enabling interrupt remapping due to skipped IO-APIC setup\n");
 		return;
 	}
@@ -2956,11 +2956,11 @@ early_param("nolapic_timer", parse_nolap
 static int __init apic_set_verbosity(char *arg)
 {
 	if (!arg)  {
-#ifdef CONFIG_X86_64
-		skip_ioapic_setup = 0;
+		if (IS_ENABLED(CONFIG_X86_32))
+			return -EINVAL;
+
+		ioapic_is_disabled = false;
 		return 0;
-#endif
-		return -EINVAL;
 	}
 
 	if (strcmp("debug", arg) == 0)
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -178,7 +178,7 @@ int mp_bus_id_to_type[MAX_MP_BUSSES];
 
 DECLARE_BITMAP(mp_bus_not_pci, MAX_MP_BUSSES);
 
-int skip_ioapic_setup;
+bool ioapic_is_disabled __ro_after_init;
 
 /**
  * disable_ioapic_support() - disables ioapic support at runtime
@@ -189,7 +189,7 @@ void disable_ioapic_support(void)
 	noioapicquirk = 1;
 	noioapicreroute = -1;
 #endif
-	skip_ioapic_setup = 1;
+	ioapic_is_disabled = true;
 }
 
 static int __init parse_noapic(char *str)
@@ -831,7 +831,7 @@ static int __acpi_get_override_irq(u32 g
 {
 	int ioapic, pin, idx;
 
-	if (skip_ioapic_setup)
+	if (ioapic_is_disabled)
 		return -1;
 
 	ioapic = mp_find_ioapic(gsi);
@@ -1366,7 +1366,7 @@ void __init enable_IO_APIC(void)
 	int i8259_apic, i8259_pin;
 	int apic, pin;
 
-	if (skip_ioapic_setup)
+	if (ioapic_is_disabled)
 		nr_ioapics = 0;
 
 	if (!nr_legacy_irqs() || !nr_ioapics)
@@ -2399,7 +2399,7 @@ void __init setup_IO_APIC(void)
 {
 	int ioapic;
 
-	if (skip_ioapic_setup || !nr_ioapics)
+	if (ioapic_is_disabled || !nr_ioapics)
 		return;
 
 	io_apic_irqs = nr_legacy_irqs() ? ~PIC_IRQS : ~0UL;
@@ -2715,7 +2715,7 @@ void __init io_apic_init_mappings(void)
 				       "address found in MPTABLE, "
 				       "disabling IO/APIC support!\n");
 				smp_found_config = 0;
-				skip_ioapic_setup = 1;
+				ioapic_is_disabled = true;
 				goto fake_ioapic_page;
 			}
 #endif
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -209,7 +209,7 @@ static void __init xen_pv_smp_prepare_cp
 {
 	unsigned cpu;
 
-	if (skip_ioapic_setup) {
+	if (ioapic_is_disabled) {
 		char *m = (max_cpus == 0) ?
 			"The nosmp parameter is incompatible with Xen; " \
 			"use Xen dom0_max_vcpus=1 parameter" :

