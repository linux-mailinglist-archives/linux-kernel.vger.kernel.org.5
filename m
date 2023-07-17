Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD71757065
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjGQXQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjGQXQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:16:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D303D8E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:16:00 -0700 (PDT)
Message-ID: <20230717223224.682027281@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=2GgBvlBwBjHxdRJmr9WUDSqYy6anA/COSWCNzKyoDG8=;
        b=2/Vn8u2+5/SRnXwpXbVScxhgRhTVpcYBF1bp0Qm/eorg2zZ10PWEtPP7zC1kuoeejFt4ck
        uHW0cDhYA4ZtpVzipDMw9xmyzIbhck5hWat7PhMZM1CMJXcex/4NkY9R/i8xmzLRdLIZlJ
        wJIk4Yw6zruuwmQxGOZXV2g0EsXQuZgab6O8CHg30q4ycyxMZopKsi9kejHqFHq9j98xjz
        /WPUnck8R3NVqQCVA70OlPpYwjzVhXXo7r+vPqb+orP4GlUq2RvEPTX7tBG98vwDMaZuKQ
        FDeUMaGnmqCWtwAnoZcVKKGYzShPHF+Xr71OQ0E2R3i9OH2ffqQPsClypsVbIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=2GgBvlBwBjHxdRJmr9WUDSqYy6anA/COSWCNzKyoDG8=;
        b=+45cMtNHe2gF+qi3ndt0ELLn3sJ2cayrCo/T3BcL/O6wM4XHQFN8OmK1fLJBTkOsNBlECf
        Tc+s0g0pYK1zSgCQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 27/58] x86/apic: Nuke empty init_apic_ldr() callbacks
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:15:16 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

apic::init_apic_ldr() is only invoked when the APIC is initialized. So
there is really no point in having:

  - Default empty callbacks all over the place

  - Two implementations of the actual LDR init function where one is
    just unreadable gunk but does exactly the same as the other.

Make the apic::init_apic_ldr() invocation conditional, remove the empty
callbacks and consolidate the two implementation into one.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/apic.h          |    2 --
 arch/x86/kernel/apic/apic.c          |    7 +++++--
 arch/x86/kernel/apic/apic_common.c   |   16 ++++++++++++++++
 arch/x86/kernel/apic/apic_flat_64.c  |   32 +-------------------------------
 arch/x86/kernel/apic/apic_noop.c     |    2 --
 arch/x86/kernel/apic/apic_numachip.c |    2 --
 arch/x86/kernel/apic/bigsmp_32.c     |    9 ---------
 arch/x86/kernel/apic/local.h         |    5 ++---
 arch/x86/kernel/apic/probe_32.c      |   15 ---------------
 arch/x86/kernel/apic/x2apic_phys.c   |    5 -----
 arch/x86/kernel/apic/x2apic_uv_x.c   |    5 -----
 arch/x86/xen/apic.c                  |    1 -
 12 files changed, 24 insertions(+), 77 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -445,8 +445,6 @@ extern void generic_bigsmp_probe(void);
 
 #include <asm/smp.h>
 
-#define APIC_DFR_VALUE	(APIC_DFR_FLAT)
-
 extern struct apic apic_noop;
 
 static inline unsigned int read_apic_id(void)
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1578,9 +1578,12 @@ static void setup_local_APIC(void)
 	/*
 	 * Intel recommends to set DFR, LDR and TPR before enabling
 	 * an APIC.  See e.g. "AP-388 82489DX User's Manual" (Intel
-	 * document number 292116).  So here it goes...
+	 * document number 292116).
+	 *
+	 * Except for APICs which operate in physical destination mode.
 	 */
-	apic->init_apic_ldr();
+	if (apic->init_apic_ldr)
+		apic->init_apic_ldr();
 
 	/*
 	 * Set Task Priority to 'accept all except vectors 0-31'.  An APIC
--- a/arch/x86/kernel/apic/apic_common.c
+++ b/arch/x86/kernel/apic/apic_common.c
@@ -6,6 +6,8 @@
 #include <linux/irq.h>
 #include <asm/apic.h>
 
+#include "local.h"
+
 u32 apic_default_calc_apicid(unsigned int cpu)
 {
 	return per_cpu(x86_cpu_to_apicid, cpu);
@@ -39,3 +41,17 @@ int default_apic_id_valid(u32 apicid)
 {
 	return (apicid < 255);
 }
+
+/*
+ * Set up the logical destination ID when the APIC operates in logical
+ * destination mode.
+ */
+void default_init_apic_ldr(void)
+{
+	unsigned long val;
+
+	apic_write(APIC_DFR, APIC_DFR_FLAT);
+	val = apic_read(APIC_LDR) & ~APIC_LDR_MASK;
+	val |= SET_APIC_LOGICAL_ID(1UL << smp_processor_id());
+	apic_write(APIC_LDR, val);
+}
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -28,26 +28,6 @@ static int flat_acpi_madt_oem_check(char
 	return 1;
 }
 
-/*
- * Set up the logical destination ID.
- *
- * Intel recommends to set DFR, LDR and TPR before enabling
- * an APIC.  See e.g. "AP-388 82489DX User's Manual" (Intel
- * document number 292116).  So here it goes...
- */
-void flat_init_apic_ldr(void)
-{
-	unsigned long val;
-	unsigned long num, id;
-
-	num = smp_processor_id();
-	id = 1UL << num;
-	apic_write(APIC_DFR, APIC_DFR_FLAT);
-	val = apic_read(APIC_LDR) & ~APIC_LDR_MASK;
-	val |= SET_APIC_LOGICAL_ID(id);
-	apic_write(APIC_LDR, val);
-}
-
 static void _flat_send_IPI_mask(unsigned long mask, int vector)
 {
 	unsigned long flags;
@@ -119,7 +99,7 @@ static struct apic apic_flat __ro_after_
 	.disable_esr			= 0,
 
 	.check_apicid_used		= NULL,
-	.init_apic_ldr			= flat_init_apic_ldr,
+	.init_apic_ldr			= default_init_apic_ldr,
 	.ioapic_phys_id_map		= NULL,
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
@@ -175,15 +155,6 @@ static int physflat_acpi_madt_oem_check(
 	return 0;
 }
 
-static void physflat_init_apic_ldr(void)
-{
-	/*
-	 * LDR and DFR are not involved in physflat mode, rather:
-	 * "In physical destination mode, the destination processor is
-	 * specified by its local APIC ID [...]." (Intel SDM, 10.6.2.1)
-	 */
-}
-
 static int physflat_probe(void)
 {
 	if (apic == &apic_physflat || num_possible_cpus() > 8 ||
@@ -207,7 +178,6 @@ static struct apic apic_physflat __ro_af
 	.disable_esr			= 0,
 
 	.check_apicid_used		= NULL,
-	.init_apic_ldr			= physflat_init_apic_ldr,
 	.ioapic_phys_id_map		= NULL,
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -14,7 +14,6 @@
 
 #include <asm/apic.h>
 
-static void noop_init_apic_ldr(void) { }
 static void noop_send_IPI(int cpu, int vector) { }
 static void noop_send_IPI_mask(const struct cpumask *cpumask, int vector) { }
 static void noop_send_IPI_mask_allbutself(const struct cpumask *cpumask, int vector) { }
@@ -94,7 +93,6 @@ struct apic apic_noop __ro_after_init =
 	.disable_esr			= 0,
 
 	.check_apicid_used		= default_check_apicid_used,
-	.init_apic_ldr			= noop_init_apic_ldr,
 	.ioapic_phys_id_map		= default_ioapic_phys_id_map,
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -252,7 +252,6 @@ static const struct apic apic_numachip1
 	.disable_esr			= 0,
 
 	.check_apicid_used		= NULL,
-	.init_apic_ldr			= flat_init_apic_ldr,
 	.ioapic_phys_id_map		= NULL,
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
@@ -297,7 +296,6 @@ static const struct apic apic_numachip2
 	.disable_esr			= 0,
 
 	.check_apicid_used		= NULL,
-	.init_apic_ldr			= flat_init_apic_ldr,
 	.ioapic_phys_id_map		= NULL,
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -28,14 +28,6 @@ static bool bigsmp_check_apicid_used(phy
 	return false;
 }
 
-/*
- * bigsmp enables physical destination mode
- * and doesn't use LDR and DFR
- */
-static void bigsmp_init_apic_ldr(void)
-{
-}
-
 static void bigsmp_setup_apic_routing(void)
 {
 	printk(KERN_INFO
@@ -108,7 +100,6 @@ static struct apic apic_bigsmp __ro_afte
 	.disable_esr			= 1,
 
 	.check_apicid_used		= bigsmp_check_apicid_used,
-	.init_apic_ldr			= bigsmp_init_apic_ldr,
 	.ioapic_phys_id_map		= bigsmp_ioapic_phys_id_map,
 	.setup_apic_routing		= bigsmp_setup_apic_routing,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -13,9 +13,6 @@
 #include <asm/irq_vectors.h>
 #include <asm/apic.h>
 
-/* APIC flat 64 */
-void flat_init_apic_ldr(void);
-
 /* X2APIC */
 int x2apic_apic_id_valid(u32 apicid);
 int x2apic_apic_id_registered(void);
@@ -46,6 +43,8 @@ static inline unsigned int __prepare_ICR
 	return icr;
 }
 
+void default_init_apic_ldr(void);
+
 void __default_send_IPI_shortcut(unsigned int shortcut, int vector);
 
 /*
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -32,21 +32,6 @@ static int default_apic_id_registered(vo
 	return physid_isset(read_apic_id(), phys_cpu_present_map);
 }
 
-/*
- * Set up the logical destination ID.  Intel recommends to set DFR, LDR and
- * TPR before enabling an APIC.  See e.g. "AP-388 82489DX User's Manual"
- * (Intel document number 292116).
- */
-static void default_init_apic_ldr(void)
-{
-	unsigned long val;
-
-	apic_write(APIC_DFR, APIC_DFR_VALUE);
-	val = apic_read(APIC_LDR) & ~APIC_LDR_MASK;
-	val |= SET_APIC_LOGICAL_ID(1UL << smp_processor_id());
-	apic_write(APIC_LDR, val);
-}
-
 static int default_phys_pkg_id(int cpuid_apic, int index_msb)
 {
 	return cpuid_apic >> index_msb;
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -91,10 +91,6 @@ static void x2apic_send_IPI_all(int vect
 	__x2apic_send_IPI_shorthand(vector, APIC_DEST_ALLINC);
 }
 
-static void init_x2apic_ldr(void)
-{
-}
-
 static int x2apic_phys_probe(void)
 {
 	if (!x2apic_mode)
@@ -169,7 +165,6 @@ static struct apic apic_x2apic_phys __ro
 	.disable_esr			= 0,
 
 	.check_apicid_used		= NULL,
-	.init_apic_ldr			= init_x2apic_ldr,
 	.ioapic_phys_id_map		= NULL,
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -788,10 +788,6 @@ static int uv_apic_id_registered(void)
 	return 1;
 }
 
-static void uv_init_apic_ldr(void)
-{
-}
-
 static u32 apic_uv_calc_apicid(unsigned int cpu)
 {
 	return apic_default_calc_apicid(cpu);
@@ -841,7 +837,6 @@ static struct apic apic_x2apic_uv_x __ro
 	.disable_esr			= 0,
 
 	.check_apicid_used		= NULL,
-	.init_apic_ldr			= uv_init_apic_ldr,
 	.ioapic_phys_id_map		= NULL,
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -149,7 +149,6 @@ static struct apic xen_pv_apic = {
 	.disable_esr			= 0,
 
 	.check_apicid_used		= default_check_apicid_used, /* Used on 32-bit */
-	.init_apic_ldr			= xen_noop, /* setup_local_APIC calls it */
 	.ioapic_phys_id_map		= default_ioapic_phys_id_map, /* Used on 32-bit */
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= xen_cpu_present_to_apicid,

