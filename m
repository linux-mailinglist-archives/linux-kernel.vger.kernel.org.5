Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1965A7726B5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbjHGNyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbjHGNx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:53:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3419E92
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:53:19 -0700 (PDT)
Message-ID: <20230807135027.900644907@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Fs46OBe57ed0poZNxJMiXrzfary3Rr7oc4qtsgbrZ88=;
        b=E3PhyayB0rz1Jvqgj8eCacG0GKqZgtdcsSRnrUvhwGg5GrFidqGHXLk42wNvc9rt7DQPkm
        woXfN+3t5KyGhNa5uQZ490XFzyTQ5xdC7F5KEAtIEC7tYhBo0WQwrydCtE4PcpRZ/Bcq56
        SC/ksjaH4I+GQ7goNa9qjiVnP1ebO1j2B1M22963EZm6WsX4zbjDfj/07NuLGLHZH068h7
        qqyw5EhQMdeS/e5DU1Q16L0tUFhk+tS6EL1JinTPXgIYj+J1gh0wKNyLj7029/LDRyRN1M
        vCPhBLdQqAfX+Ysmx1o4lk4XwLDDVjmY04YQjvy3mebD46SaYoo8HWd+E/YwTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Fs46OBe57ed0poZNxJMiXrzfary3Rr7oc4qtsgbrZ88=;
        b=8WKUlQ12W3KaxWZMVFzvM843Twl4ANWZZTcDYhUYDA7sM6BB/6G1iGABZh8ySwfVb/yQjI
        DKO+q5q6M6uUKfBw==
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
Subject: [patch 28/53] x86/mpparse: Use new APIC registration function
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:53:17 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aside of switching over to the new interface, record the number of
registered CPUs locally, which allows to make num_processors and
disabled_cpus confined to the topology code.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/mpspec.h       |    2 --
 arch/x86/kernel/cpu/topology.c |    2 +-
 arch/x86/kernel/mpparse.c           |   21 ++++++++++-----------
 3 files changed, 11 insertions(+), 14 deletions(-)

--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -61,8 +61,6 @@ static inline void e820__memblock_alloc_
 #define mpparse_parse_smp_config	x86_init_noop
 #endif
 
-int generic_processor_info(int apicid);
-
 extern DECLARE_BITMAP(phys_cpu_present_map, MAX_LOCAL_APIC);
 
 static inline void reset_phys_cpu_present_map(u32 apicid)
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -128,7 +128,7 @@ static void cpu_update_apic(int cpu, u32
 		cpu_mark_primary_thread(cpu, apicid);
 }
 
-int generic_processor_info(int apicid)
+static int generic_processor_info(int apicid)
 {
 	int cpu, max = nr_cpu_ids;
 
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -36,6 +36,8 @@
  * Checksum an MP configuration block.
  */
 
+static unsigned int num_procs __initdata;
+
 static int __init mpf_checksum(unsigned char *mp, int len)
 {
 	int sum = 0;
@@ -48,21 +50,18 @@ static int __init mpf_checksum(unsigned
 
 static void __init MP_processor_info(struct mpc_cpu *m)
 {
-	int apicid;
 	char *bootup_cpu = "";
 
-	if (!(m->cpuflag & CPU_ENABLED)) {
-		disabled_cpus++;
-		return;
-	}
+	topology_register_apic(m->apicid, CPU_ACPIID_INVALID, m->cpuflag & CPU_ENABLED);
 
-	apicid = m->apicid;
+	if (!(m->cpuflag & CPU_ENABLED))
+		return;
 
 	if (m->cpuflag & CPU_BOOTPROCESSOR)
 		bootup_cpu = " (Bootup-CPU)";
 
 	pr_info("Processor #%d%s\n", m->apicid, bootup_cpu);
-	generic_processor_info(apicid);
+	num_procs++;
 }
 
 #ifdef CONFIG_X86_IO_APIC
@@ -239,9 +238,9 @@ static int __init smp_read_mpc(struct mp
 		}
 	}
 
-	if (!num_processors)
+	if (!num_procs && !acpi_lapic)
 		pr_err("MPTABLE: no processors registered!\n");
-	return num_processors;
+	return num_procs || acpi_lapic;
 }
 
 #ifdef CONFIG_X86_IO_APIC
@@ -532,8 +531,8 @@ static __init void mpparse_get_smp_confi
 	} else
 		BUG();
 
-	if (!early)
-		pr_info("Processors: %d\n", num_processors);
+	if (!early && !acpi_lapic)
+		pr_info("Processors: %d\n", num_procs);
 	/*
 	 * Only use the first configuration found.
 	 */

