Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BE2776A58
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbjHIUh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234665AbjHIUgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:36:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C5526B5;
        Wed,  9 Aug 2023 13:36:19 -0700 (PDT)
Date:   Wed, 09 Aug 2023 20:36:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691613378;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=nPI3kt2lKsd9NMUIHnIbzY84qBy8vH+CCa2JzlMF7LA=;
        b=xlUamKAx+vs2DD0IpcSdHAXHXvxYd/R5r0A16tG5FtTS6pbNUPg3zHDMjUm+Z9AdGcIPa+
        JjIq5O+ytQYUMmEUCBTmq6KctACFhZMIFWbBRHEhoSggwLzH6BovjVfwk5x6gJ5dY/p5zo
        wWAdXomDf4ByZ09ncSB2gCYfxk6NXBgFnkzfPcHPjki/GNMphE5oFyytTl54VFpLJ5/ind
        xSJBs90BvKWtuHUsvAfuKV+ATqXaAjRZ19cSbvulHGTl1L5m/DSbEt8XtUo75/vPJfb0uR
        cMmulJeDZ6DcLxNoxMNqj29W5IvEcqx2KthsNd1Q2XEzHP8ccr20Gv+h5Zm+bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691613378;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=nPI3kt2lKsd9NMUIHnIbzY84qBy8vH+CCa2JzlMF7LA=;
        b=tRQSy6dzNSiZ40QV69GzDtDcLtyu+P6u6fJpInwQkZoJoo1GEvRCw+905GsfsrXan5ZFU5
        DOHQAdVgw37Wc5AQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Mop up apic::apic_id_registered()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169161337745.27769.15189641981598455727.tip-bot2@tip-bot2>
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

Commit-ID:     5a3a46bd161d76f117b030ece0eb0de0dfe3ba59
Gitweb:        https://git.kernel.org/tip/5a3a46bd161d76f117b030ece0eb0de0dfe3ba59
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:04:02 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:27 -07:00

x86/apic: Mop up apic::apic_id_registered()

Really not a hotpath and again no reason for having a gazillion of empty
callbacks returning 1. Make it return bool and provide one shared
implementation for the remaining users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/include/asm/apic.h           |  2 +-
 arch/x86/kernel/apic/apic.c           |  7 ++-----
 arch/x86/kernel/apic/apic_common.c    |  5 +++++
 arch/x86/kernel/apic/apic_flat_64.c   | 14 ++------------
 arch/x86/kernel/apic/apic_noop.c      | 12 ------------
 arch/x86/kernel/apic/apic_numachip.c  |  7 -------
 arch/x86/kernel/apic/bigsmp_32.c      |  6 ------
 arch/x86/kernel/apic/local.h          |  3 ++-
 arch/x86/kernel/apic/probe_32.c       |  5 -----
 arch/x86/kernel/apic/x2apic_cluster.c |  1 -
 arch/x86/kernel/apic/x2apic_phys.c    |  6 ------
 arch/x86/kernel/apic/x2apic_uv_x.c    |  6 ------
 arch/x86/xen/apic.c                   |  6 ------
 13 files changed, 12 insertions(+), 68 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 83ecea3..4fb71b7 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -295,7 +295,7 @@ struct apic {
 	int	(*probe)(void);
 	int	(*acpi_madt_oem_check)(char *oem_id, char *oem_table_id);
 	int	(*apic_id_valid)(u32 apicid);
-	int	(*apic_id_registered)(void);
+	bool	(*apic_id_registered)(void);
 
 	bool	(*check_apicid_used)(physid_mask_t *map, int apicid);
 	void	(*init_apic_ldr)(void);
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index c2656a3..4ee95cb 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1571,11 +1571,8 @@ static void setup_local_APIC(void)
 		apic_write(APIC_ESR, 0);
 	}
 #endif
-	/*
-	 * Double-check whether this APIC is really registered.
-	 * This is meaningless in clustered apic mode, so we skip it.
-	 */
-	BUG_ON(!apic->apic_id_registered());
+	/* Validate that the APIC is registered if required */
+	BUG_ON(apic->apic_id_registered && !apic->apic_id_registered());
 
 	/*
 	 * Intel recommends to set DFR, LDR and TPR before enabling
diff --git a/arch/x86/kernel/apic/apic_common.c b/arch/x86/kernel/apic/apic_common.c
index d55fdb3..bbb5d5a 100644
--- a/arch/x86/kernel/apic/apic_common.c
+++ b/arch/x86/kernel/apic/apic_common.c
@@ -42,6 +42,11 @@ int default_apic_id_valid(u32 apicid)
 	return (apicid < 255);
 }
 
+bool default_apic_id_registered(void)
+{
+	return physid_isset(read_apic_id(), phys_cpu_present_map);
+}
+
 /*
  * Set up the logical destination ID when the APIC operates in logical
  * destination mode.
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index 83e02b5..a0c875d 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -66,16 +66,6 @@ static u32 set_apic_id(unsigned int id)
 	return (id & 0xFF) << 24;
 }
 
-static unsigned int read_xapic_id(void)
-{
-	return flat_get_apic_id(apic_read(APIC_ID));
-}
-
-static int flat_apic_id_registered(void)
-{
-	return physid_isset(read_xapic_id(), phys_cpu_present_map);
-}
-
 static int flat_phys_pkg_id(int initial_apic_id, int index_msb)
 {
 	return initial_apic_id >> index_msb;
@@ -91,7 +81,7 @@ static struct apic apic_flat __ro_after_init = {
 	.probe				= flat_probe,
 	.acpi_madt_oem_check		= flat_acpi_madt_oem_check,
 	.apic_id_valid			= default_apic_id_valid,
-	.apic_id_registered		= flat_apic_id_registered,
+	.apic_id_registered		= default_apic_id_registered,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= true,
@@ -168,7 +158,7 @@ static struct apic apic_physflat __ro_after_init = {
 	.probe				= physflat_probe,
 	.acpi_madt_oem_check		= physflat_acpi_madt_oem_check,
 	.apic_id_valid			= default_apic_id_valid,
-	.apic_id_registered		= flat_apic_id_registered,
+	.apic_id_registered		= default_apic_id_registered,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= false,
diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
index e7309fd..c73a7a8 100644
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -57,17 +57,6 @@ static int noop_probe(void)
 	return 0;
 }
 
-static int noop_apic_id_registered(void)
-{
-	/*
-	 * if we would be really "pedantic"
-	 * we should pass read_apic_id() here
-	 * but since NOOP suppose APIC ID = 0
-	 * lets save a few cycles
-	 */
-	return physid_isset(0, phys_cpu_present_map);
-}
-
 static u32 noop_apic_read(u32 reg)
 {
 	WARN_ON_ONCE(boot_cpu_has(X86_FEATURE_APIC) && !apic_is_disabled);
@@ -85,7 +74,6 @@ struct apic apic_noop __ro_after_init = {
 	.acpi_madt_oem_check		= NULL,
 
 	.apic_id_valid			= default_apic_id_valid,
-	.apic_id_registered		= noop_apic_id_registered,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= true,
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index b0d5a6e..e8e13d7 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -62,11 +62,6 @@ static int numachip_apic_id_valid(u32 apicid)
 	return 1;
 }
 
-static int numachip_apic_id_registered(void)
-{
-	return 1;
-}
-
 static int numachip_phys_pkg_id(int initial_apic_id, int index_msb)
 {
 	return initial_apic_id >> index_msb;
@@ -244,7 +239,6 @@ static const struct apic apic_numachip1 __refconst = {
 	.probe				= numachip1_probe,
 	.acpi_madt_oem_check		= numachip1_acpi_madt_oem_check,
 	.apic_id_valid			= numachip_apic_id_valid,
-	.apic_id_registered		= numachip_apic_id_registered,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= false,
@@ -286,7 +280,6 @@ static const struct apic apic_numachip2 __refconst = {
 	.probe				= numachip2_probe,
 	.acpi_madt_oem_check		= numachip2_acpi_madt_oem_check,
 	.apic_id_valid			= numachip_apic_id_valid,
-	.apic_id_registered		= numachip_apic_id_registered,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= false,
diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
index 9bbdd40..ffff294 100644
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -18,11 +18,6 @@ static unsigned bigsmp_get_apic_id(unsigned long x)
 	return (x >> 24) & 0xFF;
 }
 
-static int bigsmp_apic_id_registered(void)
-{
-	return 1;
-}
-
 static bool bigsmp_check_apicid_used(physid_mask_t *map, int apicid)
 {
 	return false;
@@ -85,7 +80,6 @@ static struct apic apic_bigsmp __ro_after_init = {
 	.name				= "bigsmp",
 	.probe				= probe_bigsmp,
 	.apic_id_valid			= default_apic_id_valid,
-	.apic_id_registered		= bigsmp_apic_id_registered,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= false,
diff --git a/arch/x86/kernel/apic/local.h b/arch/x86/kernel/apic/local.h
index 345acde..0c47711 100644
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -15,7 +15,6 @@
 
 /* X2APIC */
 int x2apic_apic_id_valid(u32 apicid);
-int x2apic_apic_id_registered(void);
 void __x2apic_send_IPI_dest(unsigned int apicid, int vector, unsigned int dest);
 unsigned int x2apic_get_apic_id(unsigned long id);
 u32 x2apic_set_apic_id(unsigned int id);
@@ -61,6 +60,8 @@ void default_send_IPI_allbutself(int vector);
 void default_send_IPI_all(int vector);
 void default_send_IPI_self(int vector);
 
+bool default_apic_id_registered(void);
+
 #ifdef CONFIG_X86_32
 void default_send_IPI_mask_sequence_logical(const struct cpumask *mask, int vector);
 void default_send_IPI_mask_allbutself_logical(const struct cpumask *mask, int vector);
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index 3f717f4..81c69d7 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -18,11 +18,6 @@
 
 #include "local.h"
 
-static int default_apic_id_registered(void)
-{
-	return physid_isset(read_apic_id(), phys_cpu_present_map);
-}
-
 static int default_phys_pkg_id(int cpuid_apic, int index_msb)
 {
 	return cpuid_apic >> index_msb;
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index 52d4be1..705b33d 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -237,7 +237,6 @@ static struct apic apic_x2apic_cluster __ro_after_init = {
 	.probe				= x2apic_cluster_probe,
 	.acpi_madt_oem_check		= x2apic_acpi_madt_oem_check,
 	.apic_id_valid			= x2apic_apic_id_valid,
-	.apic_id_registered		= x2apic_apic_id_registered,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= true,
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index c57b5c8..e0fdbf5 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -111,11 +111,6 @@ int x2apic_apic_id_valid(u32 apicid)
 	return 1;
 }
 
-int x2apic_apic_id_registered(void)
-{
-	return 1;
-}
-
 void __x2apic_send_IPI_dest(unsigned int apicid, int vector, unsigned int dest)
 {
 	unsigned long cfg = __prepare_ICR(0, vector, dest);
@@ -157,7 +152,6 @@ static struct apic apic_x2apic_phys __ro_after_init = {
 	.probe				= x2apic_phys_probe,
 	.acpi_madt_oem_check		= x2apic_acpi_madt_oem_check,
 	.apic_id_valid			= x2apic_apic_id_valid,
-	.apic_id_registered		= x2apic_apic_id_registered,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= false,
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index a8caff1..9e25e30 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -783,11 +783,6 @@ static int uv_apic_id_valid(u32 apicid)
 	return 1;
 }
 
-static int uv_apic_id_registered(void)
-{
-	return 1;
-}
-
 static u32 apic_uv_calc_apicid(unsigned int cpu)
 {
 	return apic_default_calc_apicid(cpu);
@@ -829,7 +824,6 @@ static struct apic apic_x2apic_uv_x __ro_after_init = {
 	.probe				= uv_probe,
 	.acpi_madt_oem_check		= uv_acpi_madt_oem_check,
 	.apic_id_valid			= uv_apic_id_valid,
-	.apic_id_registered		= uv_apic_id_registered,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= false,
diff --git a/arch/x86/xen/apic.c b/arch/x86/xen/apic.c
index 4a27f92..f1cd7f2 100644
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -115,11 +115,6 @@ static int xen_id_always_valid(u32 apicid)
 	return 1;
 }
 
-static int xen_id_always_registered(void)
-{
-	return 1;
-}
-
 static int xen_phys_pkg_id(int initial_apic_id, int index_msb)
 {
 	return initial_apic_id >> index_msb;
@@ -142,7 +137,6 @@ static struct apic xen_pv_apic = {
 	.probe 				= xen_apic_probe_pv,
 	.acpi_madt_oem_check		= xen_madt_oem_check,
 	.apic_id_valid 			= xen_id_always_valid,
-	.apic_id_registered 		= xen_id_always_registered,
 
 	/* .delivery_mode and .dest_mode_logical not used by XENPV */
 
