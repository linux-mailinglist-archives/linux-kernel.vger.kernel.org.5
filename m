Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C468A77B4CB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbjHNIzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbjHNIyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:54:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FDA10C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:54:02 -0700 (PDT)
Message-ID: <20230814085113.054064391@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692003241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=0PoVb6rqRl+3XDmFLX4OhuCpuMKU4+OQIAfP3H7EqAk=;
        b=NZ4I7uW72RvN4r52jupLg6yEbY/xeziDeEZ7d0VX5ovMT2oy70KGafFdmRSjVH9r4TPLiS
        9ftDRVMHRn3mA2uunb8yBVMmW5d69q9Cb+Fw3Pbh/qENuRIr7Ckz2jBKVi1I+wZbDQ82Lf
        j01GlWAuzJxAtvlovi/94wQXYbtufy2Q/QOP1Z1zACnjYQtIeKCYZouMAkUhoBspXNv1u5
        zVe4odVYPytqPU5QulPBs7QCMjAd+Ijns5hbeRdjxZv10HX9qkWrMMQhe6vL3A4mY0iYdu
        XL3oGe0y7tTdZLPMWBkuZWccI0pyWPLWKUEL9KUqqb4dCEE10v0KqjebNm5qyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692003241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=0PoVb6rqRl+3XDmFLX4OhuCpuMKU4+OQIAfP3H7EqAk=;
        b=PqMlJ9MHaYDJyJXoDogrDMo8iQLesd+Oaak3bL8C/fyi1ZktkoM7jV5lHKZia2BNpVSDwY
        THS71yiXWrEk76BQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Pu Wen <puwen@hygon.cn>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>
Subject: [patch V4 17/41] x86/apic: Use u32 for cpu_present_to_apicid()
References: <20230814085006.593997112@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 14 Aug 2023 10:54:00 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

APIC IDs are used with random data types u16, u32, int, unsigned int,
unsigned long.

Make it all consistently use u32 because that reflects the hardware
register width and fixup a few related usage sites for consistency sake.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Arjan van de Ven <arjan@linux.intel.com>

---
 arch/x86/include/asm/apic.h        |    4 ++--
 arch/x86/kernel/apic/apic_common.c |    2 +-
 arch/x86/kernel/cpu/common.c       |    3 ++-
 arch/x86/kernel/smpboot.c          |   10 +++++-----
 arch/x86/xen/apic.c                |    2 +-
 5 files changed, 11 insertions(+), 10 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -295,7 +295,7 @@ struct apic {
 	bool	(*check_apicid_used)(physid_mask_t *map, u32 apicid);
 	void	(*init_apic_ldr)(void);
 	void	(*ioapic_phys_id_map)(physid_mask_t *phys_map, physid_mask_t *retmap);
-	int	(*cpu_present_to_apicid)(int mps_cpu);
+	u32	(*cpu_present_to_apicid)(int mps_cpu);
 	int	(*phys_pkg_id)(int cpuid_apic, int index_msb);
 
 	u32	(*get_apic_id)(unsigned long x);
@@ -539,7 +539,7 @@ extern u32 apic_default_calc_apicid(unsi
 extern u32 apic_flat_calc_apicid(unsigned int cpu);
 
 extern void default_ioapic_phys_id_map(physid_mask_t *phys_map, physid_mask_t *retmap);
-extern int default_cpu_present_to_apicid(int mps_cpu);
+extern u32 default_cpu_present_to_apicid(int mps_cpu);
 
 #else /* CONFIG_X86_LOCAL_APIC */
 
--- a/arch/x86/kernel/apic/apic_common.c
+++ b/arch/x86/kernel/apic/apic_common.c
@@ -28,7 +28,7 @@ void default_ioapic_phys_id_map(physid_m
 	*retmap = *phys_map;
 }
 
-int default_cpu_present_to_apicid(int mps_cpu)
+u32 default_cpu_present_to_apicid(int mps_cpu)
 {
 	if (mps_cpu < nr_cpu_ids && cpu_present(mps_cpu))
 		return (int)per_cpu(x86_cpu_to_apicid, mps_cpu);
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1747,7 +1747,8 @@ static void generic_identify(struct cpui
 static void validate_apic_and_package_id(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_SMP
-	unsigned int apicid, cpu = smp_processor_id();
+	unsigned int cpu = smp_processor_id();
+	u32 apicid;
 
 	apicid = apic->cpu_present_to_apicid(cpu);
 
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -816,7 +816,7 @@ static void __init smp_quirk_init_udelay
 /*
  * Wake up AP by INIT, INIT, STARTUP sequence.
  */
-static void send_init_sequence(int phys_apicid)
+static void send_init_sequence(u32 phys_apicid)
 {
 	int maxlvt = lapic_get_maxlvt();
 
@@ -842,7 +842,7 @@ static void send_init_sequence(int phys_
 /*
  * Wake up AP by INIT, INIT, STARTUP sequence.
  */
-static int wakeup_secondary_cpu_via_init(int phys_apicid, unsigned long start_eip)
+static int wakeup_secondary_cpu_via_init(u32 phys_apicid, unsigned long start_eip)
 {
 	unsigned long send_status = 0, accept_status = 0;
 	int num_starts, j, maxlvt;
@@ -989,7 +989,7 @@ int common_cpu_up(unsigned int cpu, stru
  * Returns zero if startup was successfully sent, else error code from
  * ->wakeup_secondary_cpu.
  */
-static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle)
+static int do_boot_cpu(u32 apicid, int cpu, struct task_struct *idle)
 {
 	unsigned long start_ip = real_mode_header->trampoline_start;
 	int ret;
@@ -1057,7 +1057,7 @@ static int do_boot_cpu(int apicid, int c
 
 int native_kick_ap(unsigned int cpu, struct task_struct *tidle)
 {
-	int apicid = apic->cpu_present_to_apicid(cpu);
+	u32 apicid = apic->cpu_present_to_apicid(cpu);
 	int err;
 
 	lockdep_assert_irqs_enabled();
@@ -1250,7 +1250,7 @@ void arch_thaw_secondary_cpus_end(void)
 bool smp_park_other_cpus_in_init(void)
 {
 	unsigned int cpu, this_cpu = smp_processor_id();
-	unsigned int apicid;
+	u32 apicid;
 
 	if (apic->wakeup_secondary_cpu_64 || apic->wakeup_secondary_cpu)
 		return false;
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -115,7 +115,7 @@ static int xen_phys_pkg_id(int initial_a
 	return initial_apic_id >> index_msb;
 }
 
-static int xen_cpu_present_to_apicid(int cpu)
+static u32 xen_cpu_present_to_apicid(int cpu)
 {
 	if (cpu_present(cpu))
 		return cpu_data(cpu).topo.apicid;



