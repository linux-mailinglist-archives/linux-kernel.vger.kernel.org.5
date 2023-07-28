Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EF37665F3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbjG1H6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234552AbjG1H56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:57:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740603584;
        Fri, 28 Jul 2023 00:57:56 -0700 (PDT)
Date:   Fri, 28 Jul 2023 07:57:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690531075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PrZQaTyqf16Vk1Bp57+1OcO8ffAip0BSduKvePpXECI=;
        b=G+D0u944HDJ+BLF91ITXpzSoBsPr4Dlpr5zCw1qfA1NWO8dlUge4LsIn8lZc0aDlwpW2PY
        QObCLuoiyOjoutr1Kwh96od58lMLWzihUKTEtoNGVKTxHqRztPRfV360kW49Z0GzXc8zBI
        G05gvu8UZGpDz18Beze8utQCWE2+vhmb26DYTKSpLDvAVbhBue+ph+0/hAeHbAFFskHG+2
        jpoPyl6HYZPm0ZJcXYNerSbJliMXbAt9BIH3RKl6WPOrEghL3v0xCn0Je2YnVELZ1zDB02
        ORtsky7ifKa0W+ROPPV86lR5SV+iEamBOpDWzMfaWlMK1HMRaWTjRsOiko6t0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690531075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PrZQaTyqf16Vk1Bp57+1OcO8ffAip0BSduKvePpXECI=;
        b=jUUYMbJFZlCGEDOO2Yv0MedDwI82k4dDoAnkAAbvPfePQC1NAEghVhQP7Ot7/RhF1jTHfg
        Yl511IUe4TSXpGCw==
From:   "tip-bot2 for Michael Ellerman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu/SMT: Store the current/max number of threads
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zhang Rui <rui.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230705145143.40545-5-ldufour@linux.ibm.com>
References: <20230705145143.40545-5-ldufour@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <169053107444.28540.6116396316311383462.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     447ae4ac41130a7f127c2581a5e816bb0800b560
Gitweb:        https://git.kernel.org/tip/447ae4ac41130a7f127c2581a5e816bb0800b560
Author:        Michael Ellerman <mpe@ellerman.id.au>
AuthorDate:    Wed, 05 Jul 2023 16:51:37 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 28 Jul 2023 09:53:37 +02:00

cpu/SMT: Store the current/max number of threads

Some architectures allow partial SMT states at boot time, ie. when not all
SMT threads are brought online.

To support that the SMT code needs to know the maximum number of SMT
threads, and also the currently configured number.

The architecture code knows the max number of threads, so have the
architecture code pass that value to cpu_smt_set_num_threads(). Note that
although topology_max_smt_threads() exists, it is not configured early
enough to be used here. As architecture, like PowerPC, allows the threads
number to be set through the kernel command line, also pass that value.

[ ldufour: Slightly reword the commit message ]
[ ldufour: Rename cpu_smt_check_topology and add a num_threads argument ]

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Link: https://lore.kernel.org/r/20230705145143.40545-5-ldufour@linux.ibm.com

---
 arch/x86/kernel/cpu/common.c |  2 +-
 include/linux/cpu_smt.h      |  8 ++++++--
 kernel/cpu.c                 | 21 ++++++++++++++++++++-
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 52683fd..12a48a8 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2317,7 +2317,7 @@ void __init arch_cpu_finalize_init(void)
 	 * identify_boot_cpu() initialized SMT support information, let the
 	 * core code know.
 	 */
-	cpu_smt_check_topology();
+	cpu_smt_set_num_threads(smp_num_siblings, smp_num_siblings);
 
 	if (!IS_ENABLED(CONFIG_SMP)) {
 		pr_info("CPU: ");
diff --git a/include/linux/cpu_smt.h b/include/linux/cpu_smt.h
index 722c2e3..0c16642 100644
--- a/include/linux/cpu_smt.h
+++ b/include/linux/cpu_smt.h
@@ -12,15 +12,19 @@ enum cpuhp_smt_control {
 
 #if defined(CONFIG_SMP) && defined(CONFIG_HOTPLUG_SMT)
 extern enum cpuhp_smt_control cpu_smt_control;
+extern unsigned int cpu_smt_num_threads;
 extern void cpu_smt_disable(bool force);
-extern void cpu_smt_check_topology(void);
+extern void cpu_smt_set_num_threads(unsigned int num_threads,
+				    unsigned int max_threads);
 extern bool cpu_smt_possible(void);
 extern int cpuhp_smt_enable(void);
 extern int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval);
 #else
 # define cpu_smt_control               (CPU_SMT_NOT_IMPLEMENTED)
+# define cpu_smt_num_threads 1
 static inline void cpu_smt_disable(bool force) { }
-static inline void cpu_smt_check_topology(void) { }
+static inline void cpu_smt_set_num_threads(unsigned int num_threads,
+					   unsigned int max_threads) { }
 static inline bool cpu_smt_possible(void) { return false; }
 static inline int cpuhp_smt_enable(void) { return 0; }
 static inline int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval) { return 0; }
diff --git a/kernel/cpu.c b/kernel/cpu.c
index b6fe170..d7dd535 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -594,6 +594,8 @@ void __weak arch_smt_update(void) { }
 #ifdef CONFIG_HOTPLUG_SMT
 
 enum cpuhp_smt_control cpu_smt_control __read_mostly = CPU_SMT_ENABLED;
+static unsigned int cpu_smt_max_threads __ro_after_init;
+unsigned int cpu_smt_num_threads __read_mostly = UINT_MAX;
 
 void __init cpu_smt_disable(bool force)
 {
@@ -607,16 +609,33 @@ void __init cpu_smt_disable(bool force)
 		pr_info("SMT: disabled\n");
 		cpu_smt_control = CPU_SMT_DISABLED;
 	}
+	cpu_smt_num_threads = 1;
 }
 
 /*
  * The decision whether SMT is supported can only be done after the full
  * CPU identification. Called from architecture code.
  */
-void __init cpu_smt_check_topology(void)
+void __init cpu_smt_set_num_threads(unsigned int num_threads,
+				    unsigned int max_threads)
 {
+	WARN_ON(!num_threads || (num_threads > max_threads));
+
 	if (!topology_smt_supported())
 		cpu_smt_control = CPU_SMT_NOT_SUPPORTED;
+
+	cpu_smt_max_threads = max_threads;
+
+	/*
+	 * If SMT has been disabled via the kernel command line or SMT is
+	 * not supported, set cpu_smt_num_threads to 1 for consistency.
+	 * If enabled, take the architecture requested number of threads
+	 * to bring up into account.
+	 */
+	if (cpu_smt_control != CPU_SMT_ENABLED)
+		cpu_smt_num_threads = 1;
+	else if (num_threads < cpu_smt_num_threads)
+		cpu_smt_num_threads = num_threads;
 }
 
 static int __init smt_cmdline_disable(char *str)
