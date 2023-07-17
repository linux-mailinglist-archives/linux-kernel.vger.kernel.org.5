Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C34757067
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjGQXRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjGQXRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:17:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EDE170C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:16:18 -0700 (PDT)
Message-ID: <20230717223224.862165651@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=iXqYtXrlduXImtg8HbwwswgIFt4N10phn1SThuuoL6E=;
        b=0dN0OrCKNxWlr5OUQVlboRcw+6j9f+o+Z+6J+4QtQ3GKT2Cgj0hsFEfQrxu+xACuAcS61S
        jrW2X46+nGZAH1ez5UXmb3euZvH09YDs0h86ztj5vWsD+PglInLBG1bUn7UVP0xq17fjUs
        Ppd2Qr6TZg4jMEIB57MOqiQW6Uk8yKl7eH5movcXVeGxa8G/s5HjeU/NAncBTQCpSqcsay
        wMm9dnBJNheAOXFoRWfXQoPJ0cR2M5R94OHwTqm5yE+f2OETSt6EprXQyDhM7AWbxSD253
        e1hH4ajwe8DVFBURr+tT2Qt3BWVDfLZ6MmhPlgXhI07OeKtlBmi+GywO4FC4dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=iXqYtXrlduXImtg8HbwwswgIFt4N10phn1SThuuoL6E=;
        b=KTUaoc8lM7LP9M80N+0b8tgyPboz6lk8Eo7zzKzV6CRIrHbLn3ug4RN3UiRrj39yEbUU4U
        38HzOpfLbVM0ZzAw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 30/58] x86/apic: Mop up *setup_apic_routing()
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:15:21 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

default_setup_apic_routing() is a complete misnomer. On 64bit it does the
actual APIC probing and on 32bit it is used to force select the bigsmp APIC
and to emit a redundant message in the apic::setup_apic_routing() callback.

Rename the 64bit and 32bit function so they reflect what they are doing and
remove the useless APIC callback.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/apic.h           |   10 ++++------
 arch/x86/kernel/apic/apic.c           |    4 +++-
 arch/x86/kernel/apic/apic_flat_64.c   |    2 --
 arch/x86/kernel/apic/apic_noop.c      |    1 -
 arch/x86/kernel/apic/apic_numachip.c  |    2 --
 arch/x86/kernel/apic/bigsmp_32.c      |    8 --------
 arch/x86/kernel/apic/local.h          |    2 ++
 arch/x86/kernel/apic/probe_32.c       |   17 ++---------------
 arch/x86/kernel/apic/probe_64.c       |    2 +-
 arch/x86/kernel/apic/x2apic_cluster.c |    1 -
 arch/x86/kernel/apic/x2apic_phys.c    |    1 -
 arch/x86/kernel/apic/x2apic_uv_x.c    |    1 -
 arch/x86/kernel/setup.c               |    2 +-
 arch/x86/xen/apic.c                   |    1 -
 14 files changed, 13 insertions(+), 41 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -40,11 +40,9 @@
 
 
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86_32)
-extern void generic_apic_probe(void);
+extern void x86_32_probe_apic(void);
 #else
-static inline void generic_apic_probe(void)
-{
-}
+static inline void x86_32_probe_apic(void) { }
 #endif
 
 #ifdef CONFIG_X86_LOCAL_APIC
@@ -302,7 +300,6 @@ struct apic {
 	bool	(*check_apicid_used)(physid_mask_t *map, int apicid);
 	void	(*init_apic_ldr)(void);
 	void	(*ioapic_phys_id_map)(physid_mask_t *phys_map, physid_mask_t *retmap);
-	void	(*setup_apic_routing)(void);
 	int	(*cpu_present_to_apicid)(int mps_cpu);
 	int	(*phys_pkg_id)(int cpuid_apic, int index_msb);
 
@@ -457,12 +454,13 @@ static inline unsigned int read_apic_id(
 typedef int (*wakeup_cpu_handler)(int apicid, unsigned long start_eip);
 extern void acpi_wake_cpu_handler_update(wakeup_cpu_handler handler);
 extern int default_acpi_madt_oem_check(char *, char *);
+extern void x86_64_probe_apic(void);
 #else
 static inline int default_acpi_madt_oem_check(char *a, char *b) { return 0; }
+static inline void x86_64_probe_apic(void) { }
 #endif
 
 extern int default_apic_id_valid(u32 apicid);
-extern void default_setup_apic_routing(void);
 
 extern u32 apic_default_calc_apicid(unsigned int cpu);
 extern u32 apic_flat_calc_apicid(unsigned int cpu);
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1419,7 +1419,9 @@ void __init apic_intr_mode_init(void)
 		break;
 	}
 
-	default_setup_apic_routing();
+	x86_64_probe_apic();
+
+	x86_32_install_bigsmp();
 
 	if (x86_platform.apic_post_init)
 		x86_platform.apic_post_init();
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -101,7 +101,6 @@ static struct apic apic_flat __ro_after_
 	.check_apicid_used		= NULL,
 	.init_apic_ldr			= default_init_apic_ldr,
 	.ioapic_phys_id_map		= NULL,
-	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= flat_phys_pkg_id,
 
@@ -178,7 +177,6 @@ static struct apic apic_physflat __ro_af
 
 	.check_apicid_used		= NULL,
 	.ioapic_phys_id_map		= NULL,
-	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= flat_phys_pkg_id,
 
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -94,7 +94,6 @@ struct apic apic_noop __ro_after_init =
 
 	.check_apicid_used		= default_check_apicid_used,
 	.ioapic_phys_id_map		= default_ioapic_phys_id_map,
-	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 
 	.phys_pkg_id			= noop_phys_pkg_id,
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -253,7 +253,6 @@ static const struct apic apic_numachip1
 
 	.check_apicid_used		= NULL,
 	.ioapic_phys_id_map		= NULL,
-	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= numachip_phys_pkg_id,
 
@@ -296,7 +295,6 @@ static const struct apic apic_numachip2
 
 	.check_apicid_used		= NULL,
 	.ioapic_phys_id_map		= NULL,
-	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= numachip_phys_pkg_id,
 
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -28,13 +28,6 @@ static bool bigsmp_check_apicid_used(phy
 	return false;
 }
 
-static void bigsmp_setup_apic_routing(void)
-{
-	printk(KERN_INFO
-		"Enabling APIC mode:  Physflat.  Using %d I/O APICs\n",
-		nr_ioapics);
-}
-
 static void bigsmp_ioapic_phys_id_map(physid_mask_t *phys_map, physid_mask_t *retmap)
 {
 	/* For clustered we don't have a good way to do this yet - hack */
@@ -101,7 +94,6 @@ static struct apic apic_bigsmp __ro_afte
 
 	.check_apicid_used		= bigsmp_check_apicid_used,
 	.ioapic_phys_id_map		= bigsmp_ioapic_phys_id_map,
-	.setup_apic_routing		= bigsmp_setup_apic_routing,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= bigsmp_phys_pkg_id,
 
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -66,8 +66,10 @@ void default_send_IPI_mask_sequence_logi
 void default_send_IPI_mask_allbutself_logical(const struct cpumask *mask, int vector);
 void default_send_IPI_mask_logical(const struct cpumask *mask, int vector);
 void x86_32_probe_bigsmp_early(void);
+void x86_32_install_bigsmp(void);
 #else
 static inline void x86_32_probe_bigsmp_early(void) { }
+static inline void x86_32_install_bigsmp(void) { }
 #endif
 
 #ifdef CONFIG_X86_BIGSMP
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -18,15 +18,6 @@
 
 #include "local.h"
 
-static void setup_apic_flat_routing(void)
-{
-#ifdef CONFIG_X86_IO_APIC
-	printk(KERN_INFO
-		"Enabling APIC mode:  Flat.  Using %d I/O APICs\n",
-		nr_ioapics);
-#endif
-}
-
 static int default_apic_id_registered(void)
 {
 	return physid_isset(read_apic_id(), phys_cpu_present_map);
@@ -58,7 +49,6 @@ static struct apic apic_default __ro_aft
 	.check_apicid_used		= default_check_apicid_used,
 	.init_apic_ldr			= default_init_apic_ldr,
 	.ioapic_phys_id_map		= default_ioapic_phys_id_map,
-	.setup_apic_routing		= setup_apic_flat_routing,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= default_phys_pkg_id,
 
@@ -132,16 +122,13 @@ void __init x86_32_probe_bigsmp_early(vo
 	set_nr_cpu_ids(8);
 }
 
-void __init default_setup_apic_routing(void)
+void __init x86_32_install_bigsmp(void)
 {
 	if (nr_cpu_ids >= 8 && !xen_pv_domain())
 		apic_bigsmp_force();
-
-	if (apic->setup_apic_routing)
-		apic->setup_apic_routing();
 }
 
-void __init generic_apic_probe(void)
+void __init x86_32_probe_apic(void)
 {
 	if (!cmdline_apic) {
 		struct apic **drv;
--- a/arch/x86/kernel/apic/probe_64.c
+++ b/arch/x86/kernel/apic/probe_64.c
@@ -14,7 +14,7 @@
 #include "local.h"
 
 /* Select the appropriate APIC driver */
-void __init default_setup_apic_routing(void)
+void __init x86_64_probe_apic(void)
 {
 	struct apic **drv;
 
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -247,7 +247,6 @@ static struct apic apic_x2apic_cluster _
 	.check_apicid_used		= NULL,
 	.init_apic_ldr			= init_x2apic_ldr,
 	.ioapic_phys_id_map		= NULL,
-	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= x2apic_phys_pkg_id,
 
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -166,7 +166,6 @@ static struct apic apic_x2apic_phys __ro
 
 	.check_apicid_used		= NULL,
 	.ioapic_phys_id_map		= NULL,
-	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= x2apic_phys_pkg_id,
 
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -838,7 +838,6 @@ static struct apic apic_x2apic_uv_x __ro
 
 	.check_apicid_used		= NULL,
 	.ioapic_phys_id_map		= NULL,
-	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= uv_phys_pkg_id,
 
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1253,7 +1253,7 @@ void __init setup_arch(char **cmdline_p)
 
 	map_vsyscall();
 
-	generic_apic_probe();
+	x86_32_probe_apic();
 
 	early_quirks();
 
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -150,7 +150,6 @@ static struct apic xen_pv_apic = {
 
 	.check_apicid_used		= default_check_apicid_used, /* Used on 32-bit */
 	.ioapic_phys_id_map		= default_ioapic_phys_id_map, /* Used on 32-bit */
-	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= xen_cpu_present_to_apicid,
 	.phys_pkg_id			= xen_phys_pkg_id, /* detect_ht */
 

