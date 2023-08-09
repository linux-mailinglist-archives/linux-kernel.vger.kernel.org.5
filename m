Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F97776A57
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbjHIUh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbjHIUgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:36:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96D526B6;
        Wed,  9 Aug 2023 13:36:19 -0700 (PDT)
Date:   Wed, 09 Aug 2023 20:36:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691613378;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2/aaiJDJF2FjIihCljTYyzG6+yo8oWmp+toKiVvIyBY=;
        b=fL0esAf7FYgUdHsIh92dgCcMy4MYFvG6MqW372FLNISLmJp/k0EN8AaFD5gzn1rG5fy7lh
        C4rlenhvZYQsX3wEJUyse7w3RIM/FbA0TaWuzTAd+ddX3OnzsC2ifyj24UU2/c/TUfEX88
        YA+0bQq4h0bG6rjjid6yb4hCkf2k7nTcQ54EkNfpcgbvCRU2mppe8lwVWQ8npS6yA2FY7T
        kVftk/spIUKNW5MgQqvNRPtenomVsOrSzBYI3aUllcv1ez3TApn0ATV6De1CgqLF/fLZse
        sniEkCnd/Lkd1Od753xunodJEmquJQsUfYio9x9V+zJdgiBG2rZa1SzsCmbjNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691613378;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2/aaiJDJF2FjIihCljTYyzG6+yo8oWmp+toKiVvIyBY=;
        b=qQmsQeLflfnm8nKIEh7oUWce9OawvTRSxkSKiIeznvQb2gOLv33oBHlvnw1VEjLA5i7sZ1
        Dcdi0f7gdWnCUnDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Mop up *setup_apic_routing()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169161337792.27769.10215888355750154127.tip-bot2@tip-bot2>
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

Commit-ID:     9d87f5b67e100f253aed995a31fedff2983b7639
Gitweb:        https://git.kernel.org/tip/9d87f5b67e100f253aed995a31fedff2983b7639
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:04:01 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:26 -07:00

x86/apic: Mop up *setup_apic_routing()

default_setup_apic_routing() is a complete misnomer. On 64bit it does the
actual APIC probing and on 32bit it is used to force select the bigsmp APIC
and to emit a redundant message in the apic::setup_apic_routing() callback.

Rename the 64bit and 32bit function so they reflect what they are doing and
remove the useless APIC callback.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/include/asm/apic.h           | 10 ++++------
 arch/x86/kernel/apic/apic.c           |  4 +++-
 arch/x86/kernel/apic/apic_flat_64.c   |  2 --
 arch/x86/kernel/apic/apic_noop.c      |  1 -
 arch/x86/kernel/apic/apic_numachip.c  |  2 --
 arch/x86/kernel/apic/bigsmp_32.c      |  8 --------
 arch/x86/kernel/apic/local.h          |  2 ++
 arch/x86/kernel/apic/probe_32.c       | 17 ++---------------
 arch/x86/kernel/apic/probe_64.c       |  2 +-
 arch/x86/kernel/apic/x2apic_cluster.c |  1 -
 arch/x86/kernel/apic/x2apic_phys.c    |  1 -
 arch/x86/kernel/apic/x2apic_uv_x.c    |  1 -
 arch/x86/kernel/setup.c               |  2 +-
 arch/x86/xen/apic.c                   |  1 -
 14 files changed, 13 insertions(+), 41 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 3932089..83ecea3 100644
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
 
@@ -457,12 +454,13 @@ static inline unsigned int read_apic_id(void)
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
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 622dd60..c2656a3 100644
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
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index 803cf01..83e02b5 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -101,7 +101,6 @@ static struct apic apic_flat __ro_after_init = {
 	.check_apicid_used		= NULL,
 	.init_apic_ldr			= default_init_apic_ldr,
 	.ioapic_phys_id_map		= NULL,
-	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= flat_phys_pkg_id,
 
@@ -178,7 +177,6 @@ static struct apic apic_physflat __ro_after_init = {
 
 	.check_apicid_used		= NULL,
 	.ioapic_phys_id_map		= NULL,
-	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= flat_phys_pkg_id,
 
diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
index 8cab632..e7309fd 100644
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -94,7 +94,6 @@ struct apic apic_noop __ro_after_init = {
 
 	.check_apicid_used		= default_check_apicid_used,
 	.ioapic_phys_id_map		= default_ioapic_phys_id_map,
-	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 
 	.phys_pkg_id			= noop_phys_pkg_id,
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index 8f57155..b0d5a6e 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -253,7 +253,6 @@ static const struct apic apic_numachip1 __refconst = {
 
 	.check_apicid_used		= NULL,
 	.ioapic_phys_id_map		= NULL,
-	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= numachip_phys_pkg_id,
 
@@ -296,7 +295,6 @@ static const struct apic apic_numachip2 __refconst = {
 
 	.check_apicid_used		= NULL,
 	.ioapic_phys_id_map		= NULL,
-	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= numachip_phys_pkg_id,
 
diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
index 099611e..9bbdd40 100644
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -28,13 +28,6 @@ static bool bigsmp_check_apicid_used(physid_mask_t *map, int apicid)
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
@@ -101,7 +94,6 @@ static struct apic apic_bigsmp __ro_after_init = {
 
 	.check_apicid_used		= bigsmp_check_apicid_used,
 	.ioapic_phys_id_map		= bigsmp_ioapic_phys_id_map,
-	.setup_apic_routing		= bigsmp_setup_apic_routing,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= bigsmp_phys_pkg_id,
 
diff --git a/arch/x86/kernel/apic/local.h b/arch/x86/kernel/apic/local.h
index c146741..345acde 100644
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -66,8 +66,10 @@ void default_send_IPI_mask_sequence_logical(const struct cpumask *mask, int vect
 void default_send_IPI_mask_allbutself_logical(const struct cpumask *mask, int vector);
 void default_send_IPI_mask_logical(const struct cpumask *mask, int vector);
 void x86_32_probe_bigsmp_early(void);
+void x86_32_install_bigsmp(void);
 #else
 static inline void x86_32_probe_bigsmp_early(void) { }
+static inline void x86_32_install_bigsmp(void) { }
 #endif
 
 #ifdef CONFIG_X86_BIGSMP
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index c6c3a4b..3f717f4 100644
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
@@ -58,7 +49,6 @@ static struct apic apic_default __ro_after_init = {
 	.check_apicid_used		= default_check_apicid_used,
 	.init_apic_ldr			= default_init_apic_ldr,
 	.ioapic_phys_id_map		= default_ioapic_phys_id_map,
-	.setup_apic_routing		= setup_apic_flat_routing,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= default_phys_pkg_id,
 
@@ -132,16 +122,13 @@ void __init x86_32_probe_bigsmp_early(void)
 	set_nr_cpu_ids(8);
 }
 
-void __init default_setup_apic_routing(void)
+void __init x86_32_install_bigsmp(void)
 {
 	if (nr_cpu_ids > 8 && !xen_pv_domain())
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
diff --git a/arch/x86/kernel/apic/probe_64.c b/arch/x86/kernel/apic/probe_64.c
index 3c0c8d3..7c9f1a8 100644
--- a/arch/x86/kernel/apic/probe_64.c
+++ b/arch/x86/kernel/apic/probe_64.c
@@ -14,7 +14,7 @@
 #include "local.h"
 
 /* Select the appropriate APIC driver */
-void __init default_setup_apic_routing(void)
+void __init x86_64_probe_apic(void)
 {
 	struct apic **drv;
 
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index a8e7a8f..52d4be1 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -247,7 +247,6 @@ static struct apic apic_x2apic_cluster __ro_after_init = {
 	.check_apicid_used		= NULL,
 	.init_apic_ldr			= init_x2apic_ldr,
 	.ioapic_phys_id_map		= NULL,
-	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= x2apic_phys_pkg_id,
 
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index 5ac2129..c57b5c8 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -166,7 +166,6 @@ static struct apic apic_x2apic_phys __ro_after_init = {
 
 	.check_apicid_used		= NULL,
 	.ioapic_phys_id_map		= NULL,
-	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= x2apic_phys_pkg_id,
 
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index d6b98bc..a8caff1 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -838,7 +838,6 @@ static struct apic apic_x2apic_uv_x __ro_after_init = {
 
 	.check_apicid_used		= NULL,
 	.ioapic_phys_id_map		= NULL,
-	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= uv_phys_pkg_id,
 
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 779477d..f83d02b 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1252,7 +1252,7 @@ void __init setup_arch(char **cmdline_p)
 
 	map_vsyscall();
 
-	generic_apic_probe();
+	x86_32_probe_apic();
 
 	early_quirks();
 
diff --git a/arch/x86/xen/apic.c b/arch/x86/xen/apic.c
index 426f4a0..4a27f92 100644
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -150,7 +150,6 @@ static struct apic xen_pv_apic = {
 
 	.check_apicid_used		= default_check_apicid_used, /* Used on 32-bit */
 	.ioapic_phys_id_map		= default_ioapic_phys_id_map, /* Used on 32-bit */
-	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= xen_cpu_present_to_apicid,
 	.phys_pkg_id			= xen_phys_pkg_id, /* detect_ht */
 
