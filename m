Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D229676B24F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjHAKu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbjHAKtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:49:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37083C13
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:47:59 -0700 (PDT)
Message-ID: <20230801103817.624346203@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690886857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=5u62JLRIdL35F8zaoRJUG8h+QUZ60VbjH6N1PcWK5uo=;
        b=u6ZY9bJrRSQ+k4bJFdZ6OVvjPiJhlQmi3Lr06wKnKrLkURdz73x6LHHg+S1s+iR21/6rKY
        548MTrfGULtmX7NtLYwg6ligD1RZu9piCe3nxAKpmzuw8B3dztSiykcGC1dSU4YvEjJnZF
        deK8o4OtzbuVkiroWJ9NOMkgWlcsb2jCJImbOoaek5606csuk4ebCRVYqNsZn8WpXZ/A1v
        mUh0hDMt/tScqK8Zj1uj+e4quo2Ohp8TCEglDkpVxZUbttZ4OIRIuX+RCqXLKh/NhlRtNZ
        jSOlO+HKIEdAzoDlqyoP/aX3tNqzG65drbylg2MOm/p5A3N9fX7m1SAwZUi8CQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690886857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=5u62JLRIdL35F8zaoRJUG8h+QUZ60VbjH6N1PcWK5uo=;
        b=QqarhKiZOM+665TtSZ3t7LC/Sdx7v610CwwNN3Vd7dXZ64y44nleO0E81WTU3V9Ssgd1Fl
        GskgHNGDVt8zaRDg==
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
Subject: [patch V3 45/60] x86/apic: Sanitize APID ID range validation
References: <20230801103042.936020332@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  1 Aug 2023 12:47:36 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that everything has apic::max_apic_id set and the eventual update for
the x2APIC case is in place, switch the apic_id_valid() helper to use
apic::max_apic_id and remove the apic::apic_id_valid() callback.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/apic.h           |    3 +--
 arch/x86/kernel/apic/apic_common.c    |    5 -----
 arch/x86/kernel/apic/apic_flat_64.c   |    2 --
 arch/x86/kernel/apic/apic_noop.c      |    2 --
 arch/x86/kernel/apic/apic_numachip.c  |    8 --------
 arch/x86/kernel/apic/bigsmp_32.c      |    1 -
 arch/x86/kernel/apic/local.h          |    1 -
 arch/x86/kernel/apic/probe_32.c       |    1 -
 arch/x86/kernel/apic/x2apic_cluster.c |    1 -
 arch/x86/kernel/apic/x2apic_phys.c    |    7 -------
 arch/x86/kernel/apic/x2apic_uv_x.c    |    6 ------
 arch/x86/xen/apic.c                   |    6 ------
 12 files changed, 1 insertion(+), 42 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -284,7 +284,6 @@ struct apic {
 	/* Probe, setup and smpboot functions */
 	int	(*probe)(void);
 	int	(*acpi_madt_oem_check)(char *oem_id, char *oem_table_id);
-	int	(*apic_id_valid)(u32 apicid);
 	bool	(*apic_id_registered)(void);
 
 	bool	(*check_apicid_used)(physid_mask_t *map, int apicid);
@@ -378,7 +377,7 @@ static inline u32 safe_apic_wait_icr_idl
 
 static inline bool apic_id_valid(u32 apic_id)
 {
-	return apic->apic_id_valid(apic_id);
+	return apic_id <= apic->max_apic_id;
 }
 
 extern void __init apic_set_eoi_write(void (*eoi_write)(u32 reg, u32 v));
--- a/arch/x86/kernel/apic/apic_common.c
+++ b/arch/x86/kernel/apic/apic_common.c
@@ -37,11 +37,6 @@ int default_cpu_present_to_apicid(int mp
 }
 EXPORT_SYMBOL_GPL(default_cpu_present_to_apicid);
 
-int default_apic_id_valid(u32 apicid)
-{
-	return (apicid < 255);
-}
-
 bool default_apic_id_registered(void)
 {
 	return physid_isset(read_apic_id(), phys_cpu_present_map);
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -80,7 +80,6 @@ static struct apic apic_flat __ro_after_
 	.name				= "flat",
 	.probe				= flat_probe,
 	.acpi_madt_oem_check		= flat_acpi_madt_oem_check,
-	.apic_id_valid			= default_apic_id_valid,
 	.apic_id_registered		= default_apic_id_registered,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
@@ -158,7 +157,6 @@ static struct apic apic_physflat __ro_af
 	.name				= "physical flat",
 	.probe				= physflat_probe,
 	.acpi_madt_oem_check		= physflat_acpi_madt_oem_check,
-	.apic_id_valid			= default_apic_id_valid,
 	.apic_id_registered		= default_apic_id_registered,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -67,8 +67,6 @@ struct apic apic_noop __ro_after_init =
 	.probe				= noop_probe,
 	.acpi_madt_oem_check		= NULL,
 
-	.apic_id_valid			= default_apic_id_valid,
-
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= true,
 
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -56,12 +56,6 @@ static u32 numachip2_set_apic_id(unsigne
 	return id << 24;
 }
 
-static int numachip_apic_id_valid(u32 apicid)
-{
-	/* Trust what bootloader passes in MADT */
-	return 1;
-}
-
 static int numachip_phys_pkg_id(int initial_apic_id, int index_msb)
 {
 	return initial_apic_id >> index_msb;
@@ -227,7 +221,6 @@ static const struct apic apic_numachip1
 	.name				= "NumaConnect system",
 	.probe				= numachip1_probe,
 	.acpi_madt_oem_check		= numachip1_acpi_madt_oem_check,
-	.apic_id_valid			= numachip_apic_id_valid,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= false,
@@ -267,7 +260,6 @@ static const struct apic apic_numachip2
 	.name				= "NumaConnect2 system",
 	.probe				= numachip2_probe,
 	.acpi_madt_oem_check		= numachip2_acpi_madt_oem_check,
-	.apic_id_valid			= numachip_apic_id_valid,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= false,
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -79,7 +79,6 @@ static struct apic apic_bigsmp __ro_afte
 
 	.name				= "bigsmp",
 	.probe				= probe_bigsmp,
-	.apic_id_valid			= default_apic_id_valid,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= false,
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -14,7 +14,6 @@
 #include <asm/apic.h>
 
 /* X2APIC */
-int x2apic_apic_id_valid(u32 apicid);
 void __x2apic_send_IPI_dest(unsigned int apicid, int vector, unsigned int dest);
 unsigned int x2apic_get_apic_id(unsigned long id);
 u32 x2apic_set_apic_id(unsigned int id);
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -33,7 +33,6 @@ static struct apic apic_default __ro_aft
 
 	.name				= "default",
 	.probe				= probe_default,
-	.apic_id_valid			= default_apic_id_valid,
 	.apic_id_registered		= default_apic_id_registered,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -226,7 +226,6 @@ static struct apic apic_x2apic_cluster _
 	.name				= "cluster x2apic",
 	.probe				= x2apic_cluster_probe,
 	.acpi_madt_oem_check		= x2apic_acpi_madt_oem_check,
-	.apic_id_valid			= x2apic_apic_id_valid,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= true,
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -124,12 +124,6 @@ static int x2apic_phys_probe(void)
 	return apic == &apic_x2apic_phys;
 }
 
-/* Common x2apic functions, also used by x2apic_cluster */
-int x2apic_apic_id_valid(u32 apicid)
-{
-	return apicid <= x2apic_max_apicid;
-}
-
 unsigned int x2apic_get_apic_id(unsigned long id)
 {
 	return id;
@@ -150,7 +144,6 @@ static struct apic apic_x2apic_phys __ro
 	.name				= "physical x2apic",
 	.probe				= x2apic_phys_probe,
 	.acpi_madt_oem_check		= x2apic_acpi_madt_oem_check,
-	.apic_id_valid			= x2apic_apic_id_valid,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= false,
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -780,11 +780,6 @@ static void uv_send_IPI_all(int vector)
 	uv_send_IPI_mask(cpu_online_mask, vector);
 }
 
-static int uv_apic_id_valid(u32 apicid)
-{
-	return 1;
-}
-
 static u32 set_apic_id(unsigned int id)
 {
 	return id;
@@ -810,7 +805,6 @@ static struct apic apic_x2apic_uv_x __ro
 	.name				= "UV large system",
 	.probe				= uv_probe,
 	.acpi_madt_oem_check		= uv_acpi_madt_oem_check,
-	.apic_id_valid			= uv_apic_id_valid,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= false,
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -105,11 +105,6 @@ static int xen_madt_oem_check(char *oem_
 	return xen_pv_domain();
 }
 
-static int xen_id_always_valid(u32 apicid)
-{
-	return 1;
-}
-
 static int xen_phys_pkg_id(int initial_apic_id, int index_msb)
 {
 	return initial_apic_id >> index_msb;
@@ -127,7 +122,6 @@ static struct apic xen_pv_apic = {
 	.name 				= "Xen PV",
 	.probe 				= xen_apic_probe_pv,
 	.acpi_madt_oem_check		= xen_madt_oem_check,
-	.apic_id_valid 			= xen_id_always_valid,
 
 	/* .delivery_mode and .dest_mode_logical not used by XENPV */
 

