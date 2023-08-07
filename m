Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A24C7726A8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbjHGNyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbjHGNxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:53:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B34F10DD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:53:05 -0700 (PDT)
Message-ID: <20230807135027.429700142@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=yol4ZyfHQSxZQJA77CTzCpYOMt3ZEt27rTf+TDR+avM=;
        b=Vcymf213KGOEpIrOA4jXGVCsKG7I2hk4jsVwuktIERBGHdS3xzlk58vrIzz6xaznsIPYmr
        s7/v+xs96j1roErVFshAqkagIW5A0hXF7NgrpRnBaItT3PnOPllEJM1aHX/tjn3z0Tfm8P
        kJmidB66Sd8NKH4y3y6+IK6K2AN317Hjx2VyEuRchYrJr0uKafen63AEj6yfhhpUme+GSj
        FsYSe6YpRYJFB9HeoKI6BWD87ns/BTUHQc9KrxJlpeBZc2xHqrn/f/iw4R/kUNEHEbFCcF
        3JJ+MwYEfpjynCO4ohUgYd8ghmM+XBtt6CHaCapxNJ58d0k8Vy1Vm6jDR2mX7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=yol4ZyfHQSxZQJA77CTzCpYOMt3ZEt27rTf+TDR+avM=;
        b=CdhPAx1GgB/JPzjcNuuXv7IFLrdX3A2r3dSOnRGFhC9mLFT7F9xrDrvuH+044l2/OjjW0L
        Aky9N38LTxewZJDQ==
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
Subject: [patch 19/53] x86/mpparse: Remove the physid_t bitmap wrapper
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:53:03 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

physid_t is a wrapper around bitmap. Just remove the onion layer and use
bitmap functionality directly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/mpspec.h      |   32 +++++++++-----------------------
 arch/x86/kernel/apic/apic.c        |   11 +++++------
 arch/x86/kernel/apic/apic_common.c |   12 +-----------
 arch/x86/kernel/apic/io_apic.c     |   24 ++++++++++++------------
 arch/x86/kernel/apic/local.h       |    1 -
 arch/x86/kernel/smpboot.c          |    8 +++-----
 6 files changed, 30 insertions(+), 58 deletions(-)

--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_X86_MPSPEC_H
 #define _ASM_X86_MPSPEC_H
 
+#include <linux/types.h>
 
 #include <asm/mpspec_def.h>
 #include <asm/x86_init.h>
@@ -62,32 +63,17 @@ static inline void e820__memblock_alloc_
 
 int generic_processor_info(int apicid);
 
-#define PHYSID_ARRAY_SIZE	BITS_TO_LONGS(MAX_LOCAL_APIC)
+extern DECLARE_BITMAP(phys_cpu_present_map, MAX_LOCAL_APIC);
 
-struct physid_mask {
-	unsigned long mask[PHYSID_ARRAY_SIZE];
-};
-
-typedef struct physid_mask physid_mask_t;
-
-#define physid_set(physid, map)			set_bit(physid, (map).mask)
-#define physid_isset(physid, map)		test_bit(physid, (map).mask)
-
-#define physids_clear(map)					\
-	bitmap_zero((map).mask, MAX_LOCAL_APIC)
-
-#define physids_empty(map)					\
-	bitmap_empty((map).mask, MAX_LOCAL_APIC)
-
-static inline void physid_set_mask_of_physid(int physid, physid_mask_t *map)
+static inline void reset_phys_cpu_present_map(u32 apicid)
 {
-	physids_clear(*map);
-	physid_set(physid, *map);
+	bitmap_zero(phys_cpu_present_map, MAX_LOCAL_APIC);
+	set_bit(apicid, phys_cpu_present_map);
 }
 
-#define PHYSID_MASK_ALL		{ {[0 ... PHYSID_ARRAY_SIZE-1] = ~0UL} }
-#define PHYSID_MASK_NONE	{ {[0 ... PHYSID_ARRAY_SIZE-1] = 0UL} }
-
-extern physid_mask_t phys_cpu_present_map;
+static inline void copy_phys_cpu_present_map(unsigned long *dst)
+{
+	bitmap_copy(dst, phys_cpu_present_map, MAX_LOCAL_APIC);
+}
 
 #endif /* _ASM_X86_MPSPEC_H */
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -22,6 +22,7 @@
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
 #include <linux/memblock.h>
+#include <linux/bitmap.h>
 #include <linux/ftrace.h>
 #include <linux/ioport.h>
 #include <linux/export.h>
@@ -77,10 +78,8 @@ EXPORT_SYMBOL_GPL(boot_cpu_physical_apic
 
 u8 boot_cpu_apic_version __ro_after_init;
 
-/*
- * Bitmask of physically existing CPUs:
- */
-physid_mask_t phys_cpu_present_map;
+/* Bitmap of physically present CPUs. */
+DECLARE_BITMAP(phys_cpu_present_map, MAX_LOCAL_APIC);
 
 /*
  * Processor to be disabled specified by kernel parameter
@@ -2387,7 +2386,7 @@ static void cpu_update_apic(int cpu, u32
 	early_per_cpu(x86_cpu_to_apicid, cpu) = apicid;
 #endif
 	set_cpu_possible(cpu, true);
-	physid_set(apicid, phys_cpu_present_map);
+	set_bit(apicid, phys_cpu_present_map);
 	set_cpu_present(cpu, true);
 	num_processors++;
 
@@ -2489,7 +2488,7 @@ static void __init apic_bsp_up_setup(voi
 #ifdef CONFIG_X86_64
 	apic_write(APIC_ID, apic->set_apic_id(boot_cpu_physical_apicid));
 #endif
-	physid_set_mask_of_physid(boot_cpu_physical_apicid, &phys_cpu_present_map);
+	reset_phys_cpu_present_map(boot_cpu_physical_apicid);
 }
 
 /**
--- a/arch/x86/kernel/apic/apic_common.c
+++ b/arch/x86/kernel/apic/apic_common.c
@@ -18,16 +18,6 @@ u32 apic_flat_calc_apicid(unsigned int c
 	return 1U << cpu;
 }
 
-bool default_check_apicid_used(physid_mask_t *map, u32 apicid)
-{
-	return physid_isset(apicid, *map);
-}
-
-void default_ioapic_phys_id_map(physid_mask_t *phys_map, physid_mask_t *retmap)
-{
-	*retmap = *phys_map;
-}
-
 u32 default_cpu_present_to_apicid(int mps_cpu)
 {
 	if (mps_cpu < nr_cpu_ids && cpu_present(mps_cpu))
@@ -39,7 +29,7 @@ EXPORT_SYMBOL_GPL(default_cpu_present_to
 
 bool default_apic_id_registered(void)
 {
-	return physid_isset(read_apic_id(), phys_cpu_present_map);
+	return test_bit(read_apic_id(), phys_cpu_present_map);
 }
 
 /*
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1460,7 +1460,7 @@ void restore_boot_irq_mode(void)
  */
 static void __init setup_ioapic_ids_from_mpc_nocheck(void)
 {
-	physid_mask_t phys_id_present_map;
+	DECLARE_BITMAP(phys_id_present_map, MAX_LOCAL_APIC);
 	const u32 broadcast_id = 0xF;
 	union IO_APIC_reg_00 reg_00;
 	unsigned char old_id;
@@ -1471,7 +1471,7 @@ static void __init setup_ioapic_ids_from
 	 * This is broken; anything with a real cpu count has to
 	 * circumvent this idiocy regardless.
 	 */
-	phys_id_present_map = phys_cpu_present_map;
+	copy_phys_cpu_present_map(phys_id_present_map);
 
 	/*
 	 * Set the IOAPIC ID to the value stored in the MPC table.
@@ -1496,21 +1496,21 @@ static void __init setup_ioapic_ids_from
 		 * system must have a unique ID or we get lots of nice
 		 * 'stuck on smp_invalidate_needed IPI wait' messages.
 		 */
-		if (physid_isset(mpc_ioapic_id(ioapic_idx), phys_id_present_map)) {
+		if (test_bit(mpc_ioapic_id(ioapic_idx), phys_id_present_map)) {
 			pr_err("BIOS bug, IO-APIC#%d ID %d is already used!...\n",
 				ioapic_idx, mpc_ioapic_id(ioapic_idx));
 			for (i = 0; i < broadcast_id; i++)
-				if (!physid_isset(i, phys_id_present_map))
+				if (!test_bit(i, phys_id_present_map))
 					break;
 			if (i >= broadcast_id)
 				panic("Max APIC ID exceeded!\n");
 			pr_err("... fixing up to %d. (tell your hw vendor)\n", i);
-			physid_set(i, phys_id_present_map);
+			set_bit(i, phys_id_present_map);
 			ioapics[ioapic_idx].mp_config.apicid = i;
 		} else {
 			apic_printk(APIC_VERBOSE, "Setting %d in the phys_id_present_map\n",
 				    mpc_ioapic_id(ioapic_idx));
-			physid_set(mpc_ioapic_id(ioapic_idx), phys_id_present_map);
+			set_bit(mpc_ioapic_id(ioapic_idx), phys_id_present_map);
 		}
 
 		/*
@@ -2491,15 +2491,15 @@ unsigned int arch_dynirq_lower_bound(uns
 #ifdef CONFIG_X86_32
 static int io_apic_get_unique_id(int ioapic, int apic_id)
 {
-	static physid_mask_t apic_id_map = PHYSID_MASK_NONE;
+	static DECLARE_BITMAP(apic_id_map, MAX_LOCAL_APIC);
 	const u32 broadcast_id = 0xF;
 	union IO_APIC_reg_00 reg_00;
 	unsigned long flags;
 	int i = 0;
 
 	/* Initialize the ID map */
-	if (physids_empty(apic_id_map))
-		apic_id_map = phys_cpu_present_map;
+	if (bitmap_empty(apic_id_map, MAX_LOCAL_APIC))
+		copy_phys_cpu_present_map(apic_id_map);
 
 	raw_spin_lock_irqsave(&ioapic_lock, flags);
 	reg_00.raw = io_apic_read(ioapic, 0);
@@ -2512,9 +2512,9 @@ static int io_apic_get_unique_id(int ioa
 	}
 
 	/* Every APIC in a system must have a unique ID */
-	if (physid_isset(apic_id, apic_id_map)) {
+	if (test_bit(apic_id, apic_id_map)) {
 		for (i = 0; i < broadcast_id; i++) {
-			if (!physid_isset(i, apic_id_map))
+			if (!test_bit(i, apic_id_map))
 				break;
 		}
 
@@ -2525,7 +2525,7 @@ static int io_apic_get_unique_id(int ioa
 		apic_id = i;
 	}
 
-	physid_set(apic_id, apic_id_map);
+	set_bit(apic_id, apic_id_map);
 
 	if (reg_00.bits.ID != apic_id) {
 		reg_00.bits.ID = apic_id;
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -63,7 +63,6 @@ void default_send_IPI_all(int vector);
 void default_send_IPI_self(int vector);
 
 bool default_apic_id_registered(void);
-bool default_check_apicid_used(physid_mask_t *map, u32 apicid);
 
 #ifdef CONFIG_X86_32
 void default_send_IPI_mask_sequence_logical(const struct cpumask *mask, int vector);
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1081,7 +1081,7 @@ int native_kick_ap(unsigned int cpu, str
 
 	pr_debug("++++++++++++++++++++=_---CPU UP  %u\n", cpu);
 
-	if (apicid == BAD_APICID || !physid_isset(apicid, phys_cpu_present_map) ||
+	if (apicid == BAD_APICID || !test_bit(apicid, phys_cpu_present_map) ||
 	    !apic_id_valid(apicid)) {
 		pr_err("%s: bad cpu %d\n", __func__, cpu);
 		return -EINVAL;
@@ -1156,10 +1156,8 @@ static __init void disable_smp(void)
 	init_cpu_present(cpumask_of(0));
 	init_cpu_possible(cpumask_of(0));
 
-	if (smp_found_config)
-		physid_set_mask_of_physid(boot_cpu_physical_apicid, &phys_cpu_present_map);
-	else
-		physid_set_mask_of_physid(0, &phys_cpu_present_map);
+	reset_phys_cpu_present_map(smp_found_config ? boot_cpu_physical_apicid : 0);
+
 	cpumask_set_cpu(0, topology_sibling_cpumask(0));
 	cpumask_set_cpu(0, topology_core_cpumask(0));
 	cpumask_set_cpu(0, topology_die_cpumask(0));

