Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C90E757057
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjGQXPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjGQXO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:14:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF88EE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:14:50 -0700 (PDT)
Message-ID: <20230717223223.619742209@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=H5i4GGKgRO3TiiYH+SmmQBdthZUJ+Bs0TnVK3jLC+DU=;
        b=0eEZsi8l3pELHg1uw7TgE6WQyXiehyoMohC4RaoBFxKY6CU6j4nuf87eB8xfx55yfJKbkJ
        cxJHtVLCqxqEQmGdhHUnZTO1Uk68d5btdmFF8GiQDvfoIv/1IxTOd7kllbMBHPc073HUyD
        N1CPQIDbYwq0EspllFFI25M0uWPUVggoolU6+6kk/xbqHW8sZFgjr4u4mWoQZKlNyTcv4Z
        vl2nkNes58MpKh2Y6iwXpscx5unsbgXgnZXuOb/jnRDf6JuHH4cqO6ZSNIvh3I9N1asaMu
        NRPkhwozIg6tCqrhIEikbzoaaCpOju0Ulu6J6LmY4K9yuZC1eb/xo0rsi5VXLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=H5i4GGKgRO3TiiYH+SmmQBdthZUJ+Bs0TnVK3jLC+DU=;
        b=uQDan8++eDr5/q31MdW+XBJjSY5q8cCK5Jhe7aKeuc1TcVbN84ScwI+nxx+mRq5y6eu+r0
        yY5mhplJ7RbBclBQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 09/58] x86/apic: Get rid of boot_cpu_physical_apicid madness
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:14:48 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

boot_cpu_physical_apicid is written in random places and in the last
consequence filled with the APIC ID read from the local APIC. That causes
it to have inconsistent state when the MPTABLE is broken. As a consequence
tons of moronic checks are sprinkled all over the place.

Consolidate the code and read it exactly once when either X2APIC mode is
detected early or when the APIC mapping is established.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/apic.h |    2 
 arch/x86/kernel/apic/apic.c |  102 +++++++++++++-------------------------------
 arch/x86/kernel/mpparse.c   |    4 -
 3 files changed, 34 insertions(+), 74 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -247,7 +247,7 @@ static inline int x2apic_enabled(void)
 #else /* !CONFIG_X86_X2APIC */
 static inline void x2apic_setup(void) { }
 static inline int x2apic_enabled(void) { return 0; }
-
+static inline u32 native_apic_msr_read(u32 reg) { BUG(); }
 #define x2apic_mode		(0)
 #define	x2apic_supported()	(0)
 #endif /* !CONFIG_X86_X2APIC */
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1318,8 +1318,7 @@ static int __init __apic_intr_mode_selec
 	if (!boot_cpu_has(X86_FEATURE_APIC) &&
 		APIC_INTEGRATED(boot_cpu_apic_version)) {
 		apic_is_disabled = true;
-		pr_err(FW_BUG "Local APIC %d not detected, force emulation\n",
-				       boot_cpu_physical_apicid);
+		pr_err(FW_BUG "Local APIC not detected, force emulation\n");
 		return APIC_PIC;
 	}
 #endif
@@ -1340,12 +1339,6 @@ static int __init __apic_intr_mode_selec
 		pr_info("APIC: SMP mode deactivated\n");
 		return APIC_SYMMETRIC_IO_NO_ROUTING;
 	}
-
-	if (read_apic_id() != boot_cpu_physical_apicid) {
-		panic("Boot APIC ID in local APIC unexpected (%d vs %d)",
-		     read_apic_id(), boot_cpu_physical_apicid);
-		/* Or can we switch back to PIC here? */
-	}
 #endif
 
 	return APIC_SYMMETRIC_IO;
@@ -1741,6 +1734,23 @@ void apic_ap_setup(void)
 	end_local_APIC_setup();
 }
 
+static __init void apic_read_boot_cpu_id(bool x2apic)
+{
+	/*
+	 * This can be invoked from check_x2apic() before the APIC has been
+	 * selected. But that code knows for sure that the BIOS enabled
+	 * X2APIC.
+	 */
+	if (x2apic) {
+		boot_cpu_physical_apicid = native_apic_msr_read(APIC_ID);
+		boot_cpu_apic_version = GET_APIC_VERSION(native_apic_msr_read(APIC_LVR));
+	} else {
+		boot_cpu_physical_apicid = read_apic_id();
+		boot_cpu_apic_version = GET_APIC_VERSION(apic_read(APIC_LVR));
+	}
+}
+
+
 #ifdef CONFIG_X86_X2APIC
 int x2apic_mode;
 EXPORT_SYMBOL_GPL(x2apic_mode);
@@ -1921,6 +1931,7 @@ void __init check_x2apic(void)
 			x2apic_state = X2APIC_ON_LOCKED;
 		else
 			x2apic_state = X2APIC_ON;
+		apic_read_boot_cpu_id(true);
 	} else if (!boot_cpu_has(X86_FEATURE_X2APIC)) {
 		x2apic_state = X2APIC_DISABLED;
 	}
@@ -2109,15 +2120,11 @@ static int __init detect_init_APIC(void)
  */
 void __init init_apic_mappings(void)
 {
-	unsigned int new_apicid;
-
 	if (apic_validate_deadline_timer())
 		pr_info("TSC deadline timer available\n");
 
-	if (x2apic_mode) {
-		boot_cpu_physical_apicid = read_apic_id();
+	if (x2apic_mode)
 		return;
-	}
 
 	/* If no local APIC can be found return early */
 	if (!smp_found_config && detect_init_APIC()) {
@@ -2134,39 +2141,19 @@ void __init init_apic_mappings(void)
 		if (!acpi_lapic && !smp_found_config)
 			register_lapic_address(apic_phys);
 	}
-
-	/*
-	 * Fetch the APIC ID of the BSP in case we have a
-	 * default configuration (or the MP table is broken).
-	 */
-	new_apicid = read_apic_id();
-	if (boot_cpu_physical_apicid != new_apicid) {
-		boot_cpu_physical_apicid = new_apicid;
-		/*
-		 * yeah -- we lie about apic_version
-		 * in case if apic was disabled via boot option
-		 * but it's not a problem for SMP compiled kernel
-		 * since apic_intr_mode_select is prepared for such
-		 * a case and disable smp mode
-		 */
-		boot_cpu_apic_version = GET_APIC_VERSION(apic_read(APIC_LVR));
-	}
 }
 
 void __init register_lapic_address(unsigned long address)
 {
 	mp_lapic_addr = address;
 
-	if (!x2apic_mode) {
-		set_fixmap_nocache(FIX_APIC_BASE, address);
-		apic_mmio_base = APIC_BASE;
-		apic_printk(APIC_VERBOSE, "mapped APIC to %16lx (%16lx)\n",
-			    APIC_BASE, address);
-	}
-	if (boot_cpu_physical_apicid == -1U) {
-		boot_cpu_physical_apicid  = read_apic_id();
-		boot_cpu_apic_version = GET_APIC_VERSION(apic_read(APIC_LVR));
-	}
+	if (x2apic_mode)
+		return;
+
+	set_fixmap_nocache(FIX_APIC_BASE, address);
+	apic_mmio_base = APIC_BASE;
+	apic_printk(APIC_VERBOSE, "mapped APIC to %16lx (%16lx)\n", APIC_BASE, address);
+	apic_read_boot_cpu_id(false);
 }
 
 /*
@@ -2446,31 +2433,15 @@ int generic_processor_info(int apicid, i
 				phys_cpu_present_map);
 
 	/*
-	 * boot_cpu_physical_apicid is designed to have the apicid
-	 * returned by read_apic_id(), i.e, the apicid of the
-	 * currently booting-up processor. However, on some platforms,
-	 * it is temporarily modified by the apicid reported as BSP
-	 * through MP table. Concretely:
-	 *
-	 * - arch/x86/kernel/mpparse.c: MP_processor_info()
-	 * - arch/x86/mm/amdtopology.c: amd_numa_init()
-	 *
-	 * This function is executed with the modified
-	 * boot_cpu_physical_apicid. So, disabled_cpu_apicid kernel
-	 * parameter doesn't work to disable APs on kdump 2nd kernel.
-	 *
-	 * Since fixing handling of boot_cpu_physical_apicid requires
-	 * another discussion and tests on each platform, we leave it
-	 * for now and here we use read_apic_id() directly in this
-	 * function, generic_processor_info().
+	 * boot_cpu_physical_apicid is guaranteed to contain the boot CPU
+	 * APIC ID read from the local APIC when this function is invoked.
 	 */
-	if (disabled_cpu_apicid != BAD_APICID &&
-	    disabled_cpu_apicid != read_apic_id() &&
+	if (disabled_cpu_apicid != boot_cpu_physical_apicid &&
 	    disabled_cpu_apicid == apicid) {
 		int thiscpu = num_processors + disabled_cpus;
 
-		pr_warn("APIC: Disabling requested cpu."
-			" Processor %d/0x%x ignored.\n", thiscpu, apicid);
+		pr_warn("APIC: Disabling requested cpu. Processor %d/0x%x ignored.\n",
+			thiscpu, apicid);
 
 		disabled_cpus++;
 		return -ENODEV;
@@ -2626,15 +2597,6 @@ static void __init apic_bsp_up_setup(voi
 {
 #ifdef CONFIG_X86_64
 	apic_write(APIC_ID, apic->set_apic_id(boot_cpu_physical_apicid));
-#else
-	/*
-	 * Hack: In case of kdump, after a crash, kernel might be booting
-	 * on a cpu with non-zero lapic id. But boot_cpu_physical_apicid
-	 * might be zero if read from MP tables. Get it from LAPIC.
-	 */
-# ifdef CONFIG_CRASH_DUMP
-	boot_cpu_physical_apicid = read_apic_id();
-# endif
 #endif
 	physid_set_mask_of_physid(boot_cpu_physical_apicid, &phys_cpu_present_map);
 }
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -58,10 +58,8 @@ static void __init MP_processor_info(str
 
 	apicid = m->apicid;
 
-	if (m->cpuflag & CPU_BOOTPROCESSOR) {
+	if (m->cpuflag & CPU_BOOTPROCESSOR)
 		bootup_cpu = " (Bootup-CPU)";
-		boot_cpu_physical_apicid = m->apicid;
-	}
 
 	pr_info("Processor #%d%s\n", m->apicid, bootup_cpu);
 	generic_processor_info(apicid, m->apicver);

