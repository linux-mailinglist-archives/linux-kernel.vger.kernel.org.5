Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832C5776A51
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbjHIUgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbjHIUgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:36:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71E62130;
        Wed,  9 Aug 2023 13:36:12 -0700 (PDT)
Date:   Wed, 09 Aug 2023 20:36:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691613371;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9bLimK4kVqP2KQvsJ6nDBOrCPtxieZ56URy8/nsIGgs=;
        b=FLPitH38IFECezpgs56lb7JGEXgXor8S3VfV3J486vWXny83ZDLfyMrK/zk1v+nmngPMCT
        0RnsqHPSej+xoNf16KsgGpE5Rznkcw8YLU2S5L6BuFIkxqxzrei+smnqR4ZG1Idxk4cw2Z
        PnMsfbfYCz0SgC2XYN7HPW0NaiboRCfnIuWYuGPgbGsT/bbzArmBJBOoUEQVPNxPUIfkoV
        BqoryFLiGIp8ECKWgFGSjuzm1clOezdtWMz8Zw+LAklnExzY4HwNLHygBQl3grxVq/DgZQ
        4bzFwQKPhVzikBIsCWH5aNZMiNt7yWqC7oJdSZ7YeOG2AEa87dssTwxhruc0VQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691613371;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9bLimK4kVqP2KQvsJ6nDBOrCPtxieZ56URy8/nsIGgs=;
        b=6tZfyM0hqZPP199s0SoH++49egOXH1/dwPUDiyKvZ1vvSpuOg4BlLVqZmupS9mHlf6T9Jo
        cyuAn3O5xcUGhuAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Sanitize APIC ID range validation
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169161337087.27769.17850205653408299323.tip-bot2@tip-bot2>
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

Commit-ID:     d8666cf780203fe016f13e7d5d1af50811dc01b5
Gitweb:        https://git.kernel.org/tip/d8666cf780203fe016f13e7d5d1af50811dc01b5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:04:12 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:32 -07:00

x86/apic: Sanitize APIC ID range validation

Now that everything has apic::max_apic_id set and the eventual update for
the x2APIC case is in place, switch the apic_id_valid() helper to use
apic::max_apic_id and remove the apic::apic_id_valid() callback.

[ dhansen: Fix subject typo ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/include/asm/apic.h           | 3 +--
 arch/x86/kernel/apic/apic_common.c    | 5 -----
 arch/x86/kernel/apic/apic_flat_64.c   | 2 --
 arch/x86/kernel/apic/apic_noop.c      | 2 --
 arch/x86/kernel/apic/apic_numachip.c  | 8 --------
 arch/x86/kernel/apic/bigsmp_32.c      | 1 -
 arch/x86/kernel/apic/local.h          | 1 -
 arch/x86/kernel/apic/probe_32.c       | 1 -
 arch/x86/kernel/apic/x2apic_cluster.c | 1 -
 arch/x86/kernel/apic/x2apic_phys.c    | 7 -------
 arch/x86/kernel/apic/x2apic_uv_x.c    | 6 ------
 arch/x86/xen/apic.c                   | 6 ------
 12 files changed, 1 insertion(+), 42 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 2e79c13..ccf4e36 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -284,7 +284,6 @@ struct apic {
 	/* Probe, setup and smpboot functions */
 	int	(*probe)(void);
 	int	(*acpi_madt_oem_check)(char *oem_id, char *oem_table_id);
-	int	(*apic_id_valid)(u32 apicid);
 	bool	(*apic_id_registered)(void);
 
 	bool	(*check_apicid_used)(physid_mask_t *map, int apicid);
@@ -378,7 +377,7 @@ static inline u32 safe_apic_wait_icr_idle(void)
 
 static inline bool apic_id_valid(u32 apic_id)
 {
-	return apic->apic_id_valid(apic_id);
+	return apic_id <= apic->max_apic_id;
 }
 
 extern void __init apic_set_eoi_write(void (*eoi_write)(u32 reg, u32 v));
diff --git a/arch/x86/kernel/apic/apic_common.c b/arch/x86/kernel/apic/apic_common.c
index bbb5d5a..7bc5d9b 100644
--- a/arch/x86/kernel/apic/apic_common.c
+++ b/arch/x86/kernel/apic/apic_common.c
@@ -37,11 +37,6 @@ int default_cpu_present_to_apicid(int mps_cpu)
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
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index b5e85bb..1e268a0 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -80,7 +80,6 @@ static struct apic apic_flat __ro_after_init = {
 	.name				= "flat",
 	.probe				= flat_probe,
 	.acpi_madt_oem_check		= flat_acpi_madt_oem_check,
-	.apic_id_valid			= default_apic_id_valid,
 	.apic_id_registered		= default_apic_id_registered,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
@@ -158,7 +157,6 @@ static struct apic apic_physflat __ro_after_init = {
 	.name				= "physical flat",
 	.probe				= physflat_probe,
 	.acpi_madt_oem_check		= physflat_acpi_madt_oem_check,
-	.apic_id_valid			= default_apic_id_valid,
 	.apic_id_registered		= default_apic_id_registered,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
index d49c10d..bd6a95c 100644
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -67,8 +67,6 @@ struct apic apic_noop __ro_after_init = {
 	.probe				= noop_probe,
 	.acpi_madt_oem_check		= NULL,
 
-	.apic_id_valid			= default_apic_id_valid,
-
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= true,
 
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index 43cbc24..39ebe1a 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -56,12 +56,6 @@ static u32 numachip2_set_apic_id(unsigned int id)
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
@@ -227,7 +221,6 @@ static const struct apic apic_numachip1 __refconst = {
 	.name				= "NumaConnect system",
 	.probe				= numachip1_probe,
 	.acpi_madt_oem_check		= numachip1_acpi_madt_oem_check,
-	.apic_id_valid			= numachip_apic_id_valid,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= false,
@@ -267,7 +260,6 @@ static const struct apic apic_numachip2 __refconst = {
 	.name				= "NumaConnect2 system",
 	.probe				= numachip2_probe,
 	.acpi_madt_oem_check		= numachip2_acpi_madt_oem_check,
-	.apic_id_valid			= numachip_apic_id_valid,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= false,
diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
index 5f7a94b..ffcd114 100644
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -79,7 +79,6 @@ static struct apic apic_bigsmp __ro_after_init = {
 
 	.name				= "bigsmp",
 	.probe				= probe_bigsmp,
-	.apic_id_valid			= default_apic_id_valid,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= false,
diff --git a/arch/x86/kernel/apic/local.h b/arch/x86/kernel/apic/local.h
index e576b3a..ec219c6 100644
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -14,7 +14,6 @@
 #include <asm/apic.h>
 
 /* X2APIC */
-int x2apic_apic_id_valid(u32 apicid);
 void __x2apic_send_IPI_dest(unsigned int apicid, int vector, unsigned int dest);
 unsigned int x2apic_get_apic_id(unsigned long id);
 u32 x2apic_set_apic_id(unsigned int id);
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index 7c4b5f7..d9f52f2 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -33,7 +33,6 @@ static struct apic apic_default __ro_after_init = {
 
 	.name				= "default",
 	.probe				= probe_default,
-	.apic_id_valid			= default_apic_id_valid,
 	.apic_id_registered		= default_apic_id_registered,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index a164764..12b9c31 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -226,7 +226,6 @@ static struct apic apic_x2apic_cluster __ro_after_init = {
 	.name				= "cluster x2apic",
 	.probe				= x2apic_cluster_probe,
 	.acpi_madt_oem_check		= x2apic_acpi_madt_oem_check,
-	.apic_id_valid			= x2apic_apic_id_valid,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= true,
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index 3aabfd3..fcb96b9 100644
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
@@ -150,7 +144,6 @@ static struct apic apic_x2apic_phys __ro_after_init = {
 	.name				= "physical x2apic",
 	.probe				= x2apic_phys_probe,
 	.acpi_madt_oem_check		= x2apic_acpi_madt_oem_check,
-	.apic_id_valid			= x2apic_apic_id_valid,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= false,
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 7d4eaa8..26891ac 100644
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
@@ -810,7 +805,6 @@ static struct apic apic_x2apic_uv_x __ro_after_init = {
 	.name				= "UV large system",
 	.probe				= uv_probe,
 	.acpi_madt_oem_check		= uv_acpi_madt_oem_check,
-	.apic_id_valid			= uv_apic_id_valid,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= false,
diff --git a/arch/x86/xen/apic.c b/arch/x86/xen/apic.c
index 572814b..661eecf 100644
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -105,11 +105,6 @@ static int xen_madt_oem_check(char *oem_id, char *oem_table_id)
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
 
