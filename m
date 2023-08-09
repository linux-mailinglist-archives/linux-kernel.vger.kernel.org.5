Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E70477658A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjHIQuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjHIQth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:49:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1001BF7;
        Wed,  9 Aug 2023 09:49:36 -0700 (PDT)
Date:   Wed, 09 Aug 2023 16:49:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691599774;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rNeg6CqkiNH6RqCFzSWfDHuR5Q0hXr5uznH6Vji8Rqs=;
        b=Kl1D6JZ1vvCSkCxvsEFK93toeVWvGOHHcD1yJANgOEMlLhyl5RGCtM4KtZaZrhJlhkXj3W
        C6vQzbY7uQOD8SJfwafp7ZLlrJZFAgKwGLdoXRMvZ7YllrszCpaEsxhTz5baPtr2q8HJi4
        Xd1NjCAb/ZtRL+w/c1NLszTDYg26bISJccSaD4scE8KnUPC8rTsD2GjjAA70z1uqboTllS
        zplPBIGezR/qtEu8s4CXR5y4HHQmcvFRcaipzgosRHD41cccrxxikpbieQVql6P12JUNp8
        NVt89nxY9GeSq5FEu5CMuao0qkG42BR0e+zFBm+m8bEcY3S/xmsAOxZuo/oKYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691599774;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rNeg6CqkiNH6RqCFzSWfDHuR5Q0hXr5uznH6Vji8Rqs=;
        b=nMUCbLc+shvPbV89p6F7lXbWvUkx3qRqC4RHRUof78rvtbh57XxituNGgCcoGnC7M3m1F8
        UPZNaere+6taSZDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Nuke empty init_apic_ldr() callbacks
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169159977413.27769.16259599865006899741.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     93e6cd8a6b2ed7e6bd64a957cc9f7442fd363793
Gitweb:        https://git.kernel.org/tip/93e6cd8a6b2ed7e6bd64a957cc9f7442fd363793
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:58 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 08:10:12 -07:00

x86/apic: Nuke empty init_apic_ldr() callbacks

apic::init_apic_ldr() is only invoked when the APIC is initialized. So
there is really no point in having:

  - Default empty callbacks all over the place

  - Two implementations of the actual LDR init function where one is
    just unreadable gunk but does exactly the same as the other.

Make the apic::init_apic_ldr() invocation conditional, remove the empty
callbacks and consolidate the two implementation into one.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/apic.h          |  2 +--
 arch/x86/kernel/apic/apic.c          |  7 ++++--
 arch/x86/kernel/apic/apic_common.c   | 16 ++++++++++++++-
 arch/x86/kernel/apic/apic_flat_64.c  | 32 +---------------------------
 arch/x86/kernel/apic/apic_noop.c     |  2 +--
 arch/x86/kernel/apic/apic_numachip.c |  2 +--
 arch/x86/kernel/apic/bigsmp_32.c     |  9 +--------
 arch/x86/kernel/apic/local.h         |  5 +---
 arch/x86/kernel/apic/probe_32.c      | 15 +-------------
 arch/x86/kernel/apic/x2apic_phys.c   |  5 +----
 arch/x86/kernel/apic/x2apic_uv_x.c   |  5 +----
 arch/x86/xen/apic.c                  |  1 +-
 12 files changed, 24 insertions(+), 77 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index f6541a2..f8a3631 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -445,8 +445,6 @@ extern void generic_bigsmp_probe(void);
 
 #include <asm/smp.h>
 
-#define APIC_DFR_VALUE	(APIC_DFR_FLAT)
-
 extern struct apic apic_noop;
 
 static inline unsigned int read_apic_id(void)
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 24912b2..622dd60 100644
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
diff --git a/arch/x86/kernel/apic/apic_common.c b/arch/x86/kernel/apic/apic_common.c
index 41528bb..d55fdb3 100644
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
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index 00482cf..4ddced9 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -28,26 +28,6 @@ static int flat_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
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
@@ -119,7 +99,7 @@ static struct apic apic_flat __ro_after_init = {
 	.disable_esr			= 0,
 
 	.check_apicid_used		= NULL,
-	.init_apic_ldr			= flat_init_apic_ldr,
+	.init_apic_ldr			= default_init_apic_ldr,
 	.ioapic_phys_id_map		= NULL,
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
@@ -175,15 +155,6 @@ static int physflat_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
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
@@ -207,7 +178,6 @@ static struct apic apic_physflat __ro_after_init = {
 	.disable_esr			= 0,
 
 	.check_apicid_used		= NULL,
-	.init_apic_ldr			= physflat_init_apic_ldr,
 	.ioapic_phys_id_map		= NULL,
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
index ccd74e8..dee9e9c 100644
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -14,7 +14,6 @@
 
 #include <asm/apic.h>
 
-static void noop_init_apic_ldr(void) { }
 static void noop_send_IPI(int cpu, int vector) { }
 static void noop_send_IPI_mask(const struct cpumask *cpumask, int vector) { }
 static void noop_send_IPI_mask_allbutself(const struct cpumask *cpumask, int vector) { }
@@ -94,7 +93,6 @@ struct apic apic_noop __ro_after_init = {
 	.disable_esr			= 0,
 
 	.check_apicid_used		= default_check_apicid_used,
-	.init_apic_ldr			= noop_init_apic_ldr,
 	.ioapic_phys_id_map		= default_ioapic_phys_id_map,
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index de16fde..d96d74c 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -252,7 +252,6 @@ static const struct apic apic_numachip1 __refconst = {
 	.disable_esr			= 0,
 
 	.check_apicid_used		= NULL,
-	.init_apic_ldr			= flat_init_apic_ldr,
 	.ioapic_phys_id_map		= NULL,
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
@@ -297,7 +296,6 @@ static const struct apic apic_numachip2 __refconst = {
 	.disable_esr			= 0,
 
 	.check_apicid_used		= NULL,
-	.init_apic_ldr			= flat_init_apic_ldr,
 	.ioapic_phys_id_map		= NULL,
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
index aba8ce1..c688af4 100644
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -28,14 +28,6 @@ static bool bigsmp_check_apicid_used(physid_mask_t *map, int apicid)
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
@@ -108,7 +100,6 @@ static struct apic apic_bigsmp __ro_after_init = {
 	.disable_esr			= 1,
 
 	.check_apicid_used		= bigsmp_check_apicid_used,
-	.init_apic_ldr			= bigsmp_init_apic_ldr,
 	.ioapic_phys_id_map		= bigsmp_ioapic_phys_id_map,
 	.setup_apic_routing		= bigsmp_setup_apic_routing,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
diff --git a/arch/x86/kernel/apic/local.h b/arch/x86/kernel/apic/local.h
index ad96c1a..c146741 100644
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
@@ -46,6 +43,8 @@ static inline unsigned int __prepare_ICR(unsigned int shortcut, int vector,
 	return icr;
 }
 
+void default_init_apic_ldr(void);
+
 void __default_send_IPI_shortcut(unsigned int shortcut, int vector);
 
 /*
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index 706a844..68fc220 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -32,21 +32,6 @@ static int default_apic_id_registered(void)
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
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index 9cf32ce..c3c2e98 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -91,10 +91,6 @@ static void x2apic_send_IPI_all(int vector)
 	__x2apic_send_IPI_shorthand(vector, APIC_DEST_ALLINC);
 }
 
-static void init_x2apic_ldr(void)
-{
-}
-
 static int x2apic_phys_probe(void)
 {
 	if (!x2apic_mode)
@@ -169,7 +165,6 @@ static struct apic apic_x2apic_phys __ro_after_init = {
 	.disable_esr			= 0,
 
 	.check_apicid_used		= NULL,
-	.init_apic_ldr			= init_x2apic_ldr,
 	.ioapic_phys_id_map		= NULL,
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 8b14451..ab17e58 100644
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
@@ -841,7 +837,6 @@ static struct apic apic_x2apic_uv_x __ro_after_init = {
 	.disable_esr			= 0,
 
 	.check_apicid_used		= NULL,
-	.init_apic_ldr			= uv_init_apic_ldr,
 	.ioapic_phys_id_map		= NULL,
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
diff --git a/arch/x86/xen/apic.c b/arch/x86/xen/apic.c
index c8240af..1ff8f75 100644
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -149,7 +149,6 @@ static struct apic xen_pv_apic = {
 	.disable_esr			= 0,
 
 	.check_apicid_used		= default_check_apicid_used, /* Used on 32-bit */
-	.init_apic_ldr			= xen_noop, /* setup_local_APIC calls it */
 	.ioapic_phys_id_map		= default_ioapic_phys_id_map, /* Used on 32-bit */
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= xen_cpu_present_to_apicid,
