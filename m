Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8087B51FC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236929AbjJBMAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236954AbjJBMAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:00:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D609D3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 04:59:58 -0700 (PDT)
Message-ID: <20231002115903.087472735@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696247996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=J0zNjtrmxlOZ3cIxLGlZizAd9pmzXfVNcRvGruLfMIs=;
        b=dmi170l6gBazhbvWrscBAf9pb+pU6+AiWqYuoLqZYCH4SdmD2NKvKcbTc4BR3oc9VLhBgt
        qK8gaS3B8MsW0UCiCYql/QOfVeAf/b/o66zfEyOfBiG0bo+Ti5AFNmJYzQjE2E2566+t6a
        7lzzxZL6+MbxVIV+1qlsay1mPfZdZ8puiadZSeyH7YCBbUPmkv10nmgvaFnicNScVCCgvr
        jvy0ZMf5+b7Ikh63hHvOeeJs7jC4loYZC49YfVc08+qcoMaOpQzWPNi9fbW/5YL7hJYZHQ
        1WP2ALrwmofcwvSBoMzHw8ntHqT5aKlKSdl9CSmusX8OjAW7lbp4C5H04ipYTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696247996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=J0zNjtrmxlOZ3cIxLGlZizAd9pmzXfVNcRvGruLfMIs=;
        b=4kHq3rEPUygP1oZu6plB0wbNvgIPljh4xMKiA+rVR9ZPliH4mp9PkgBPHsUueEraPFYNaV
        2g1Tv57piCjW52Dw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V4 18/30] x86/microcode: Handle "nosmt" correctly
References: <20231002115506.217091296@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  2 Oct 2023 13:59:56 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

On CPUs where microcode loading is not NMI safe the SMT siblings which are
parked in one of the play_dead() variants still react on NMIs.

So if a NMI hits while the primary thread updates the microcode the
resulting behaviour is undefined. The default play_dead() implementation on
modern CPUs is using MWAIT, which is not guaranteed to be safe against a
microcode update which affects MWAIT.

Take the cpus_booted_once_mask into account to detect this case and refuse
to load late if the vendor specific driver does not advertise that late
loading is NMI safe.

AMD stated that this is safe, so mark the AMD driver accordingly.

This requirement will be partially lifted in later changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/Kconfig                         |    2 -
 arch/x86/kernel/cpu/microcode/amd.c      |    9 +++--
 arch/x86/kernel/cpu/microcode/core.c     |   51 +++++++++++++++++++------------
 arch/x86/kernel/cpu/microcode/internal.h |   13 +++----
 4 files changed, 44 insertions(+), 31 deletions(-)
---
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1316,7 +1316,7 @@ config MICROCODE
 config MICROCODE_LATE_LOADING
 	bool "Late microcode loading (DANGEROUS)"
 	default n
-	depends on MICROCODE
+	depends on MICROCODE && SMP
 	help
 	  Loading microcode late, when the system is up and executing instructions
 	  is a tricky business and should be avoided if possible. Just the sequence
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -909,10 +909,11 @@ static void microcode_fini_cpu_amd(int c
 }
 
 static struct microcode_ops microcode_amd_ops = {
-	.request_microcode_fw             = request_microcode_amd,
-	.collect_cpu_info                 = collect_cpu_info_amd,
-	.apply_microcode                  = apply_microcode_amd,
-	.microcode_fini_cpu               = microcode_fini_cpu_amd,
+	.request_microcode_fw	= request_microcode_amd,
+	.collect_cpu_info	= collect_cpu_info_amd,
+	.apply_microcode	= apply_microcode_amd,
+	.microcode_fini_cpu	= microcode_fini_cpu_amd,
+	.nmi_safe		= true,
 };
 
 struct microcode_ops * __init init_amd_microcode(void)
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -283,23 +283,6 @@ static struct platform_device	*microcode
  */
 #define SPINUNIT 100 /* 100 nsec */
 
-static int check_online_cpus(void)
-{
-	unsigned int cpu;
-
-	/*
-	 * Make sure all CPUs are online.  It's fine for SMT to be disabled if
-	 * all the primary threads are still online.
-	 */
-	for_each_present_cpu(cpu) {
-		if (topology_is_primary_thread(cpu) && !cpu_online(cpu)) {
-			pr_err("Not all CPUs online, aborting microcode update.\n");
-			return -EINVAL;
-		}
-	}
-
-	return 0;
-}
 
 static atomic_t late_cpus_in;
 static atomic_t late_cpus_out;
@@ -416,6 +399,35 @@ static int microcode_reload_late(void)
 	return ret;
 }
 
+/*
+ *  Ensure that all required CPUs which are present and have been booted
+ *  once are online.
+ *
+ *    To pass this check, all primary threads must be online.
+ *
+ *    If the microcode load is not safe against NMI then all SMT threads
+ *    must be online as well because they still react on NMI when they are
+ *    soft-offlined and parked in one of the play_dead() variants. So if a
+ *    NMI hits while the primary thread updates the microcode the resulting
+ *    behaviour is undefined. The default play_dead() implementation on
+ *    modern CPUs uses MWAIT, which is also not guaranteed to be safe
+ *    against a microcode update which affects MWAIT.
+ */
+static bool ensure_cpus_are_online(void)
+{
+	unsigned int cpu;
+
+	for_each_cpu_and(cpu, cpu_present_mask, &cpus_booted_once_mask) {
+		if (!cpu_online(cpu)) {
+			if (topology_is_primary_thread(cpu) || !microcode_ops->nmi_safe) {
+				pr_err("CPU %u not online\n", cpu);
+				return false;
+			}
+		}
+	}
+	return true;
+}
+
 static ssize_t reload_store(struct device *dev,
 			    struct device_attribute *attr,
 			    const char *buf, size_t size)
@@ -431,9 +443,10 @@ static ssize_t reload_store(struct devic
 
 	cpus_read_lock();
 
-	ret = check_online_cpus();
-	if (ret)
+	if (!ensure_cpus_are_online()) {
+		ret = -EBUSY;
 		goto put;
+	}
 
 	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev);
 	if (tmp_ret != UCODE_NEW)
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -20,18 +20,17 @@ enum ucode_state {
 
 struct microcode_ops {
 	enum ucode_state (*request_microcode_fw)(int cpu, struct device *dev);
-
 	void (*microcode_fini_cpu)(int cpu);
 
 	/*
-	 * The generic 'microcode_core' part guarantees that
-	 * the callbacks below run on a target cpu when they
-	 * are being called.
+	 * The generic 'microcode_core' part guarantees that the callbacks
+	 * below run on a target CPU when they are being called.
 	 * See also the "Synchronization" section in microcode_core.c.
 	 */
-	enum ucode_state (*apply_microcode)(int cpu);
-	int (*collect_cpu_info)(int cpu, struct cpu_signature *csig);
-	void (*finalize_late_load)(int result);
+	enum ucode_state	(*apply_microcode)(int cpu);
+	int			(*collect_cpu_info)(int cpu, struct cpu_signature *csig);
+	void			(*finalize_late_load)(int result);
+	unsigned int		nmi_safe	: 1;
 };
 
 extern struct ucode_cpu_info ucode_cpu_info[];

