Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEA37C8246
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjJMJib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjJMJiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:38:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F393BF;
        Fri, 13 Oct 2023 02:38:08 -0700 (PDT)
Date:   Fri, 13 Oct 2023 09:38:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697189886;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sXiauNCXwimX7ZOS4BcnAOq4vrVP6clsJHUG4q5qaG8=;
        b=uJT9O+rJ2SkusXRhvxxsOz+bi5mDQ3XI+gEPJb7LcUIuNtsNE2pe5IXxNZKP9V95UXpK1U
        sFi5hddpjADGxs3+vljETyKpnrtoljQ1ZFUWI/w4KEKxeN5/HbXoiDkFVl/f/9WNP1LfZq
        J/bGhZPoZBT14+tnp1wJfpHRrqhb3Njv9oPeY0p9aGj1vtCKDcGTED1jcKT0HIumgFkryu
        /dDZrPZ/MQprwvqsfar0eIlVIAx8QlOoglhkoJGBASQffCizx9E3QnUyYhZ5tRMMp82PsW
        Fh/eRbZut8rm5D9aSCu9MupYGVnxtDCxpbr45B7Co3coHfE0/IYI3sbIyflODQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697189886;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sXiauNCXwimX7ZOS4BcnAOq4vrVP6clsJHUG4q5qaG8=;
        b=/CeqfHET8+fAkS+qM0bxYHu+JaM/IjAnGvxBWJlg2Jwolp+Xb6tI/HbkHm24NjZ4ASyNrJ
        dyytOUG+GxGtBXAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/apic: Use u32 for cpu_present_to_apicid()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230814085113.054064391@linutronix.de>
References: <20230814085113.054064391@linutronix.de>
MIME-Version: 1.0
Message-ID: <169718988564.3135.18070570630188012488.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     8aa2a4178dc535591ac0c17de45b14fe7f6a05c7
Gitweb:        https://git.kernel.org/tip/8aa2a4178dc535591ac0c17de45b14fe7f6a05c7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 14 Aug 2023 10:18:42 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Oct 2023 14:38:19 +02:00

x86/apic: Use u32 for cpu_present_to_apicid()

APIC IDs are used with random data types u16, u32, int, unsigned int,
unsigned long.

Make it all consistently use u32 because that reflects the hardware
register width and fixup a few related usage sites for consistency sake.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Arjan van de Ven <arjan@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230814085113.054064391@linutronix.de

---
 arch/x86/include/asm/apic.h        |  4 ++--
 arch/x86/kernel/apic/apic_common.c |  2 +-
 arch/x86/kernel/cpu/common.c       |  3 ++-
 arch/x86/kernel/smpboot.c          | 10 +++++-----
 arch/x86/xen/apic.c                |  2 +-
 5 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index e970697..42a6adf 100644
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
@@ -539,7 +539,7 @@ extern u32 apic_default_calc_apicid(unsigned int cpu);
 extern u32 apic_flat_calc_apicid(unsigned int cpu);
 
 extern void default_ioapic_phys_id_map(physid_mask_t *phys_map, physid_mask_t *retmap);
-extern int default_cpu_present_to_apicid(int mps_cpu);
+extern u32 default_cpu_present_to_apicid(int mps_cpu);
 
 #else /* CONFIG_X86_LOCAL_APIC */
 
diff --git a/arch/x86/kernel/apic/apic_common.c b/arch/x86/kernel/apic/apic_common.c
index ca73c3a..8a00141 100644
--- a/arch/x86/kernel/apic/apic_common.c
+++ b/arch/x86/kernel/apic/apic_common.c
@@ -28,7 +28,7 @@ void default_ioapic_phys_id_map(physid_mask_t *phys_map, physid_mask_t *retmap)
 	*retmap = *phys_map;
 }
 
-int default_cpu_present_to_apicid(int mps_cpu)
+u32 default_cpu_present_to_apicid(int mps_cpu)
 {
 	if (mps_cpu < nr_cpu_ids && cpu_present(mps_cpu))
 		return (int)per_cpu(x86_cpu_to_apicid, mps_cpu);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index f73a664..62919ad 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1787,7 +1787,8 @@ static void generic_identify(struct cpuinfo_x86 *c)
 static void validate_apic_and_package_id(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_SMP
-	unsigned int apicid, cpu = smp_processor_id();
+	unsigned int cpu = smp_processor_id();
+	u32 apicid;
 
 	apicid = apic->cpu_present_to_apicid(cpu);
 
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index fa05a63..04a1136 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -803,7 +803,7 @@ static void __init smp_quirk_init_udelay(void)
 /*
  * Wake up AP by INIT, INIT, STARTUP sequence.
  */
-static void send_init_sequence(int phys_apicid)
+static void send_init_sequence(u32 phys_apicid)
 {
 	int maxlvt = lapic_get_maxlvt();
 
@@ -829,7 +829,7 @@ static void send_init_sequence(int phys_apicid)
 /*
  * Wake up AP by INIT, INIT, STARTUP sequence.
  */
-static int wakeup_secondary_cpu_via_init(int phys_apicid, unsigned long start_eip)
+static int wakeup_secondary_cpu_via_init(u32 phys_apicid, unsigned long start_eip)
 {
 	unsigned long send_status = 0, accept_status = 0;
 	int num_starts, j, maxlvt;
@@ -976,7 +976,7 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
  * Returns zero if startup was successfully sent, else error code from
  * ->wakeup_secondary_cpu.
  */
-static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle)
+static int do_boot_cpu(u32 apicid, int cpu, struct task_struct *idle)
 {
 	unsigned long start_ip = real_mode_header->trampoline_start;
 	int ret;
@@ -1044,7 +1044,7 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle)
 
 int native_kick_ap(unsigned int cpu, struct task_struct *tidle)
 {
-	int apicid = apic->cpu_present_to_apicid(cpu);
+	u32 apicid = apic->cpu_present_to_apicid(cpu);
 	int err;
 
 	lockdep_assert_irqs_enabled();
@@ -1237,7 +1237,7 @@ void arch_thaw_secondary_cpus_end(void)
 bool smp_park_other_cpus_in_init(void)
 {
 	unsigned int cpu, this_cpu = smp_processor_id();
-	unsigned int apicid;
+	u32 apicid;
 
 	if (apic->wakeup_secondary_cpu_64 || apic->wakeup_secondary_cpu)
 		return false;
diff --git a/arch/x86/xen/apic.c b/arch/x86/xen/apic.c
index 958b747..c830ad4 100644
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -115,7 +115,7 @@ static int xen_phys_pkg_id(int initial_apic_id, int index_msb)
 	return initial_apic_id >> index_msb;
 }
 
-static int xen_cpu_present_to_apicid(int cpu)
+static u32 xen_cpu_present_to_apicid(int cpu)
 {
 	if (cpu_present(cpu))
 		return cpu_data(cpu).topo.apicid;
