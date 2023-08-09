Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851347763E7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbjHIPe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbjHIPeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:34:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065DB2112;
        Wed,  9 Aug 2023 08:34:20 -0700 (PDT)
Date:   Wed, 09 Aug 2023 15:34:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691595258;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zMe7Dfts3PsI2fKszh/YDz1MO2PBeWf05s7Jloh8PuQ=;
        b=0UPAzHrOkeLhSVQU0yynLlQilFS2iimrii05qhuC6eER4rFDlA40c4/Xnmx5sgdzG82KSn
        v0eoX8S+p91LtfBAX6nHnfz2Kj242icO4gTSirep8+lHxftseEKtc4p9FzeqLsKtoAONPX
        ZwiPHCFfknzzN9CmQeIEZUwAEmv4MXcbIXMQjV68oNtX/gcgFmfZ8GGBXHsoX/mM0h8k+D
        7ppNioUft9DubTN9deQQ/dXDywfT4GgEL1AAcrVvsI1vlups+ZU6LxbOYs8vIKTTEiFMV5
        eddB7Q0dbHg1+ykau/eR2v7rZQVmS76qoDBh10Fl9YzpSudVZabmrHf21u1Dqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691595258;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zMe7Dfts3PsI2fKszh/YDz1MO2PBeWf05s7Jloh8PuQ=;
        b=hdCEyZeYlVbqfjcpvbJjq8usx3Ecg7YYke+6GZrG/Hx8xnLEdEIvsrFM5+eaFyFUajW4cS
        nqRvB4vJ682XYRDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Get rid of hard_smp_processor_id()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169159525820.27769.2010149765019666160.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     f58f8606b40001eaaee1eb747e06361cf585387a
Gitweb:        https://git.kernel.org/tip/f58f8606b40001eaaee1eb747e06361cf585387a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:43 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 08:10:10 -07:00

x86/apic: Get rid of hard_smp_processor_id()

No point in having a wrapper around read_apic_id().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/apic.h    |  6 +++++-
 arch/x86/include/asm/smp.h     |  7 -------
 arch/x86/kernel/apic/apic.c    |  5 -----
 arch/x86/kernel/apic/io_apic.c |  2 +-
 arch/x86/kernel/apic/ipi.c     |  2 +-
 arch/x86/kernel/apic/vector.c  |  2 +-
 arch/x86/kernel/cpu/amd.c      |  2 +-
 arch/x86/kernel/cpu/hygon.c    |  3 ++-
 arch/x86/kernel/smpboot.c      | 10 +++++-----
 arch/x86/kernel/vsmp_64.c      |  2 +-
 10 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 36f0be7..b591040 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -503,7 +503,11 @@ extern void default_ioapic_phys_id_map(physid_mask_t *phys_map, physid_mask_t *r
 extern int default_cpu_present_to_apicid(int mps_cpu);
 extern int default_check_phys_apicid_present(int phys_apicid);
 
-#endif /* CONFIG_X86_LOCAL_APIC */
+#else /* CONFIG_X86_LOCAL_APIC */
+
+static inline unsigned int read_apic_id(void) { return 0; }
+
+#endif /* !CONFIG_X86_LOCAL_APIC */
 
 #ifdef CONFIG_SMP
 void apic_smt_update(void);
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 1db6faa..8d96d9a 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -185,13 +185,6 @@ static inline struct cpumask *cpu_llc_shared_mask(int cpu)
 
 extern unsigned disabled_cpus;
 
-#ifdef CONFIG_X86_LOCAL_APIC
-extern int hard_smp_processor_id(void);
-
-#else /* CONFIG_X86_LOCAL_APIC */
-#define hard_smp_processor_id()	0
-#endif /* CONFIG_X86_LOCAL_APIC */
-
 #ifdef CONFIG_DEBUG_NMI_SELFTEST
 extern void nmi_selftest(void);
 #else
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 8af0ec8..ee64f8f 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2562,11 +2562,6 @@ int generic_processor_info(int apicid, int version)
 	return cpu;
 }
 
-int hard_smp_processor_id(void)
-{
-	return read_apic_id();
-}
-
 void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg,
 			   bool dmar)
 {
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 48975d5..a8b329a 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2095,7 +2095,7 @@ static inline void __init unlock_ExtINT_logic(void)
 	entry0 = ioapic_read_entry(apic, pin);
 	clear_IO_APIC_pin(apic, pin);
 
-	apic_id = hard_smp_processor_id();
+	apic_id = read_apic_id();
 	memset(&entry1, 0, sizeof(entry1));
 
 	entry1.dest_mode_logical	= true;
diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index 2a6509e..29273e0 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -320,7 +320,7 @@ int safe_smp_processor_id(void)
 	if (!boot_cpu_has(X86_FEATURE_APIC))
 		return 0;
 
-	apicid = hard_smp_processor_id();
+	apicid = read_apic_id();
 	if (apicid == BAD_APICID)
 		return 0;
 
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 04655b7..71feae7 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -1208,7 +1208,7 @@ static void __init print_local_APIC(void *dummy)
 	u64 icr;
 
 	pr_debug("printing local APIC contents on CPU#%d/%d:\n",
-		 smp_processor_id(), hard_smp_processor_id());
+		 smp_processor_id(), read_apic_id());
 	v = apic_read(APIC_ID);
 	pr_info("... APIC ID:      %08x (%01x)\n", v, read_apic_id());
 	v = apic_read(APIC_LVR);
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 26ad7ca..5861eea 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1042,7 +1042,7 @@ static void init_amd(struct cpuinfo_x86 *c)
 		set_cpu_cap(c, X86_FEATURE_FSRS);
 
 	/* get apicid instead of initial apic id from cpuid */
-	c->apicid = hard_smp_processor_id();
+	c->apicid = read_apic_id();
 
 	/* K6s reports MCEs but don't actually have all the MSRs */
 	if (c->x86 < 6)
diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index 5a2962c..defdc59 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -8,6 +8,7 @@
  */
 #include <linux/io.h>
 
+#include <asm/apic.h>
 #include <asm/cpu.h>
 #include <asm/smp.h>
 #include <asm/numa.h>
@@ -300,7 +301,7 @@ static void init_hygon(struct cpuinfo_x86 *c)
 	set_cpu_cap(c, X86_FEATURE_REP_GOOD);
 
 	/* get apicid instead of initial apic id from cpuid */
-	c->apicid = hard_smp_processor_id();
+	c->apicid = read_apic_id();
 
 	/*
 	 * XXX someone from Hygon needs to confirm this DTRT
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index e1aa2cd..8229f41 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1220,11 +1220,11 @@ static void __init smp_sanity_check(void)
 	}
 #endif
 
-	if (!physid_isset(hard_smp_processor_id(), phys_cpu_present_map)) {
+	if (!physid_isset(read_apic_id(), phys_cpu_present_map)) {
 		pr_warn("weird, boot CPU (#%d) not listed by the BIOS\n",
-			hard_smp_processor_id());
+			read_apic_id());
 
-		physid_set(hard_smp_processor_id(), phys_cpu_present_map);
+		physid_set(read_apic_id(), phys_cpu_present_map);
 	}
 
 	/*
@@ -1234,7 +1234,7 @@ static void __init smp_sanity_check(void)
 	if (!apic->check_phys_apicid_present(boot_cpu_physical_apicid)) {
 		pr_notice("weird, boot CPU (#%d) not listed by the BIOS\n",
 			  boot_cpu_physical_apicid);
-		physid_set(hard_smp_processor_id(), phys_cpu_present_map);
+		physid_set(read_apic_id(), phys_cpu_present_map);
 	}
 	preempt_enable();
 }
@@ -1439,7 +1439,7 @@ __init void prefill_possible_map(void)
 	if (!num_processors) {
 		if (boot_cpu_has(X86_FEATURE_APIC)) {
 			int apicid = boot_cpu_physical_apicid;
-			int cpu = hard_smp_processor_id();
+			int cpu = read_apic_id();
 
 			pr_warn("Boot CPU (id %d) not listed by BIOS\n", cpu);
 
diff --git a/arch/x86/kernel/vsmp_64.c b/arch/x86/kernel/vsmp_64.c
index 796cfaa..65e96b7 100644
--- a/arch/x86/kernel/vsmp_64.c
+++ b/arch/x86/kernel/vsmp_64.c
@@ -129,7 +129,7 @@ static void __init vsmp_cap_cpus(void)
 
 static int apicid_phys_pkg_id(int initial_apic_id, int index_msb)
 {
-	return hard_smp_processor_id() >> index_msb;
+	return read_apic_id() >> index_msb;
 }
 
 static void vsmp_apic_post_init(void)
