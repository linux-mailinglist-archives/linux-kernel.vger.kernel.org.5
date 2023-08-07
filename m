Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D4177269C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbjHGNw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbjHGNwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:52:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCA810DB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:52:43 -0700 (PDT)
Message-ID: <20230807135026.698506626@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=WM7FtIAfN5V1o55rfOkqm3mZ5QhFQKaaoxABZtsnb3I=;
        b=yXwPOKLUDuGuTlV2kSMmQ2PSPmAkEdEJeXjPnSP54gdUnf8gf92OSI8qrH8oHPPX37gHF5
        UfuV5Pdvf8OjHzYb49KBwHfLjexvlRcW+CaY4Wr0My3R2U+dkfhCv5dbIKIgDeWVWPP9nC
        Lmof4C1aFxxWsIoYPGFl59mlt40sRnqwpog0JxbXcS6qsdNk40MiJaMzzBhK36o3bNJw0p
        6Z63JOimBkbsgwoJFhE5ZpAFPIiEc5XTaOjpgZZWcIE1Y1Lj3CyGSx+zufzQ7pCV/2dqII
        YyqTCi0HyoGDLUmrPhADen3L5npmc83uvu106Ymx7/mavx+HDn7Ifa6XBlueDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=WM7FtIAfN5V1o55rfOkqm3mZ5QhFQKaaoxABZtsnb3I=;
        b=+gLJP5wwGYhZA8HpB1gp7h5TTQeZmw0R6Z7d+2Jyx1LxCeqlC38ThUHRUR/UhSeR9NRj9a
        9QybTMsH4ocZPADA==
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
Subject: [patch 05/53] x86/apic: Get rid of get_physical_broadcast()
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:52:41 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point for this function. The only case where this is used when
there is no XAPIC available, which means the broadcast address is 0xF.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/apic.c    |   10 ---------
 arch/x86/kernel/apic/io_apic.c |   42 ++++++++++++++++++-----------------------
 2 files changed, 19 insertions(+), 33 deletions(-)

--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -259,16 +259,6 @@ u64 native_apic_icr_read(void)
 	return icr1 | ((u64)icr2 << 32);
 }
 
-#ifdef CONFIG_X86_32
-/**
- * get_physical_broadcast - Get number of physical broadcast IDs
- */
-int get_physical_broadcast(void)
-{
-	return modern_apic() ? 0xff : 0xf;
-}
-#endif
-
 /**
  * lapic_get_maxlvt - get the maximum number of local vector table entries
  */
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1460,12 +1460,12 @@ void restore_boot_irq_mode(void)
  */
 static void __init setup_ioapic_ids_from_mpc_nocheck(void)
 {
-	union IO_APIC_reg_00 reg_00;
 	physid_mask_t phys_id_present_map;
-	int ioapic_idx;
-	int i;
+	const u32 broadcast_id = 0xF;
+	union IO_APIC_reg_00 reg_00;
 	unsigned char old_id;
 	unsigned long flags;
+	int ioapic_idx, i;
 
 	/*
 	 * This is broken; anything with a real cpu count has to
@@ -1484,11 +1484,10 @@ static void __init setup_ioapic_ids_from
 
 		old_id = mpc_ioapic_id(ioapic_idx);
 
-		if (mpc_ioapic_id(ioapic_idx) >= get_physical_broadcast()) {
-			printk(KERN_ERR "BIOS bug, IO-APIC#%d ID is %d in the MPC table!...\n",
-				ioapic_idx, mpc_ioapic_id(ioapic_idx));
-			printk(KERN_ERR "... fixing up to %d. (tell your hw vendor)\n",
-				reg_00.bits.ID);
+		if (mpc_ioapic_id(ioapic_idx) >= broadcast_id) {
+			pr_err("BIOS bug, IO-APIC#%d ID is %d in the MPC table!...\n",
+			       ioapic_idx, mpc_ioapic_id(ioapic_idx));
+			pr_err("... fixing up to %d. (tell your hw vendor)\n", reg_00.bits.ID);
 			ioapics[ioapic_idx].mp_config.apicid = reg_00.bits.ID;
 		}
 
@@ -1499,15 +1498,14 @@ static void __init setup_ioapic_ids_from
 		 */
 		if (apic->check_apicid_used(&phys_id_present_map,
 					    mpc_ioapic_id(ioapic_idx))) {
-			printk(KERN_ERR "BIOS bug, IO-APIC#%d ID %d is already used!...\n",
+			pr_err("BIOS bug, IO-APIC#%d ID %d is already used!...\n",
 				ioapic_idx, mpc_ioapic_id(ioapic_idx));
-			for (i = 0; i < get_physical_broadcast(); i++)
+			for (i = 0; i < broadcast_id; i++)
 				if (!physid_isset(i, phys_id_present_map))
 					break;
-			if (i >= get_physical_broadcast())
+			if (i >= broadcast_id)
 				panic("Max APIC ID exceeded!\n");
-			printk(KERN_ERR "... fixing up to %d. (tell your hw vendor)\n",
-				i);
+			pr_err("... fixing up to %d. (tell your hw vendor)\n", i);
 			physid_set(i, phys_id_present_map);
 			ioapics[ioapic_idx].mp_config.apicid = i;
 		} else {
@@ -2495,6 +2493,7 @@ unsigned int arch_dynirq_lower_bound(uns
 static int io_apic_get_unique_id(int ioapic, int apic_id)
 {
 	static physid_mask_t apic_id_map = PHYSID_MASK_NONE;
+	const u32 broadcast_id = 0xF;
 	union IO_APIC_reg_00 reg_00;
 	unsigned long flags;
 	int i = 0;
@@ -2515,9 +2514,9 @@ static int io_apic_get_unique_id(int ioa
 	reg_00.raw = io_apic_read(ioapic, 0);
 	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
 
-	if (apic_id >= get_physical_broadcast()) {
-		printk(KERN_WARNING "IOAPIC[%d]: Invalid apic_id %d, trying "
-			"%d\n", ioapic, apic_id, reg_00.bits.ID);
+	if (apic_id >= broadcast_id) {
+		pr_warn("IOAPIC[%d]: Invalid apic_id %d, trying %d\n",
+			ioapic, apic_id, reg_00.bits.ID);
 		apic_id = reg_00.bits.ID;
 	}
 
@@ -2527,17 +2526,15 @@ static int io_apic_get_unique_id(int ioa
 	 */
 	if (apic->check_apicid_used(&apic_id_map, apic_id)) {
 
-		for (i = 0; i < get_physical_broadcast(); i++) {
+		for (i = 0; i < broadcast_id; i++) {
 			if (!apic->check_apicid_used(&apic_id_map, i))
 				break;
 		}
 
-		if (i == get_physical_broadcast())
+		if (i == broadcast_id)
 			panic("Max apic_id exceeded!\n");
 
-		printk(KERN_WARNING "IOAPIC[%d]: apic_id %d already used, "
-			"trying %d\n", ioapic, apic_id, i);
-
+		pr_warn("IOAPIC[%d]: apic_id %d already used, trying %d\n", ioapic, apic_id, i);
 		apic_id = i;
 	}
 
@@ -2567,8 +2564,7 @@ static int io_apic_get_unique_id(int ioa
 
 static u8 io_apic_unique_id(int idx, u8 id)
 {
-	if ((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) &&
-	    !APIC_XAPIC(boot_cpu_apic_version))
+	if ((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) && !APIC_XAPIC(boot_cpu_apic_version))
 		return io_apic_get_unique_id(idx, id);
 	else
 		return id;

