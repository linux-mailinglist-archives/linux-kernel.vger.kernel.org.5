Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21D37726C1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbjHGNzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234644AbjHGNx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:53:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCF11701
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:53:34 -0700 (PDT)
Message-ID: <20230807135028.381851690@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=O995zamcyhYTuo3Kkhh4AKJfSIZvbOUniiR7OEFHzns=;
        b=ooWbvL8Y/LXoIpW3N8w2RajZ1Ijs3j/JUqufRAvJufCPk2pM2E8FLvXynkMXHkFrmL72l0
        qAMj1K/Pof4iUjSLtyU0r8jmkyTlsIZ7m1LJLqXJRSAPx0uhyUZvWeUzhR0ptdNLAuXYn5
        dK+4XtfeVhj462IKUeBO5e6SuX2E+fQwMDf/sGWdwWcPYeMCDyFZ+3A1eEuYZ78hAyQwVn
        m96VSTnxhMK4Jx+kM/3ZDnT6TZiIA+mB84m0A2VLDSA7oKmuyihcJB7StIJLtPBM//1OZs
        9S+AGObmbV001hSU+ea/E4+TaTpYjp9NfdlKKv9ls8JWRxKK5UvDHrEv+YpRTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=O995zamcyhYTuo3Kkhh4AKJfSIZvbOUniiR7OEFHzns=;
        b=DuyhtTc3TpwI0l+Eq/NYUaYB1q5S0VHEyVu4XhTDe2yY2AbAPjoQRWG8Jmo+9krVhSTd1U
        FU/wqnoUMI5V6/AA==
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
Subject: [patch 37/53] x86/cpu: Detect real BSP on crash kernels
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:53:31 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a kdump kernel is started from a crashing CPU then there is no
guarantee that this CPU is the real boot CPU (BSP). If the kdump kernel
tries to online the BSP then the INIT sequence will reset the machine.

There is a command line option to prevent this, but in case of nested kdump
kernels this is wrong.

But that command line option is not required at all because the real BSP
has the lowest local APIC ID in the system. That was not always true, but
support for the only known system which was different (Voyager) got removed
long ago.

Detect whether the boot CPU APIC ID is the lowest APIC ID in the system.
If the lowest registered APIC ID is not the boot CPU APIC ID, then remove
it from the present bitmap and let the possible map initialization ignore
it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 Documentation/admin-guide/kdump/kdump.rst       |    7 --
 Documentation/admin-guide/kernel-parameters.txt |    9 ---
 arch/x86/kernel/cpu/topology.c                  |   59 +++++++++++++++---------
 3 files changed, 39 insertions(+), 36 deletions(-)

--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -191,9 +191,7 @@ Dump-capture kernel config options (Arch
    CPU is enough for kdump kernel to dump vmcore on most of systems.
 
    However, you can also specify nr_cpus=X to enable multiple processors
-   in kdump kernel. In this case, "disable_cpu_apicid=" is needed to
-   tell kdump kernel which cpu is 1st kernel's BSP. Please refer to
-   admin-guide/kernel-parameters.txt for more details.
+   in kdump kernel.
 
    With CONFIG_SMP=n, the above things are not related.
 
@@ -485,8 +483,7 @@ loading dump-capture kernel.
   to use multi-thread programs with it, such as parallel dump feature of
   makedumpfile. Otherwise, the multi-thread program may have a great
   performance degradation. To enable multi-cpu support, you should bring up an
-  SMP dump-capture kernel and specify maxcpus/nr_cpus, disable_cpu_apicid=[X]
-  options while loading it.
+  SMP dump-capture kernel and specify maxcpus/nr_cpus options while loading it.
 
 * For s390x there are two kdump modes: If a ELF header is specified with
   the elfcorehdr= kernel parameter, it is used by the kdump kernel as it
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1071,15 +1071,6 @@
 			Disable TLBIE instruction. Currently does not work
 			with KVM, with HASH MMU, or with coherent accelerators.
 
-	disable_cpu_apicid= [X86,APIC,SMP]
-			Format: <int>
-			The number of initial APIC ID for the
-			corresponding CPU to be disabled at boot,
-			mostly used for the kdump 2nd kernel to
-			disable BSP to wake up multiple CPUs without
-			causing system reset or hang due to sending
-			INIT from AP to BSP.
-
 	disable_ddw	[PPC/PSERIES]
 			Disable Dynamic DMA Window support. Use this
 			to workaround buggy firmware.
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -32,18 +32,13 @@ struct {
 	unsigned int		nr_disabled_cpus;
 	unsigned int		nr_rejected_cpus;
 	u32			boot_cpu_apic_id;
+	u32			real_bsp_apic_id;
 } topo_info __read_mostly = {
 	.nr_assigned_cpus	= 1,
 	.boot_cpu_apic_id	= BAD_APICID,
+	.real_bsp_apic_id	= BAD_APICID,
 };
 
-/*
- * Processor to be disabled specified by kernel parameter
- * disable_cpu_apicid=<int>, mostly used for the kdump 2nd kernel to
- * avoid undefined behaviour caused by sending INIT from AP to BSP.
- */
-static u32 disabled_cpu_apicid __ro_after_init = BAD_APICID;
-
 bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
 {
 	return phys_id == (u64)cpuid_to_apicid[cpu];
@@ -146,12 +141,6 @@ void __init topology_register_apic(u32 a
 		return;
 	}
 
-	if (disabled_cpu_apicid == apic_id) {
-		pr_info("Disabling CPU as requested via 'disable_cpu_apicid=0x%x'.\n", apic_id);
-		topo_info.nr_rejected_cpus++;
-		return;
-	}
-
 	if (present) {
 		/*
 		 * Prevent double registration, which is valid in case of
@@ -270,6 +259,30 @@ static __init bool restrict_to_up(void)
 	return apic_is_disabled;
 }
 
+static __init void check_for_kdump_kernel(void)
+{
+	u32 bsp_apicid;
+
+	/*
+	 * There is no real good way to detect whether this a kdump()
+	 * kernel, but except on the Voyager SMP monstrosity which is not
+	 * longer supported, the real BSP has always the lowest numbered
+	 * APIC ID. If a crash happened on an AP, which then ends up as
+	 * boot CPU in the kdump() kernel, then sending INIT to the real
+	 * BSP would reset the whole system.
+	 */
+	bsp_apicid = find_first_bit(phys_cpu_present_map, MAX_LOCAL_APIC);
+	if (bsp_apicid == topo_info.boot_cpu_apic_id)
+		return;
+
+	pr_warn("Boot CPU APIC ID not the lowest APIC ID: %x > %x\n",
+		topo_info.boot_cpu_apic_id, bsp_apicid);
+	pr_warn("Crash kernel detected. Disabling real BSP to prevent machine INIT\n");
+
+	topo_info.real_bsp_apic_id = bsp_apicid;
+	clear_bit(bsp_apicid, phys_cpu_present_map);
+}
+
 void __init topology_init_possible_cpus(void)
 {
 	unsigned int assigned = topo_info.nr_assigned_cpus;
@@ -278,6 +291,9 @@ void __init topology_init_possible_cpus(
 	unsigned int cpu, allowed = 1;
 
 	if (!restrict_to_up()) {
+		if (total > 1)
+			check_for_kdump_kernel();
+
 		if (WARN_ON_ONCE(assigned > nr_cpu_ids)) {
 			disabled += assigned - nr_cpu_ids;
 			assigned = nr_cpu_ids;
@@ -308,6 +324,14 @@ void __init topology_init_possible_cpus(
 	for (cpu = 0; cpu < allowed; cpu++) {
 		u32 apicid = cpuid_to_apicid[cpu];
 
+		/*
+		 * In case of a kdump() kernel, don't mark the real BSP in
+		 * the present and possible maps. Sending INIT to it resets
+		 * the machine.
+		 */
+		if (apicid != BAD_APICID && apicid == topo_info.real_bsp_apic_id)
+			continue;
+
 		set_cpu_possible(cpu, true);
 
 		if (apicid == BAD_APICID)
@@ -337,12 +361,3 @@ static int __init setup_possible_cpus(ch
 }
 early_param("possible_cpus", setup_possible_cpus);
 #endif
-
-static int __init apic_set_disabled_cpu_apicid(char *arg)
-{
-	if (!arg || !get_option(&arg, &disabled_cpu_apicid))
-		return -EINVAL;
-
-	return 0;
-}
-early_param("disable_cpu_apicid", apic_set_disabled_cpu_apicid);

