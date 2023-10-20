Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9377D0ED1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377458AbjJTLjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377429AbjJTLi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:38:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DDA1FF1;
        Fri, 20 Oct 2023 04:38:08 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:37:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697801872;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KUGBuTiAUtFdxJ+fiHpOy1c56kl0bFybP+sNJ4nQuK4=;
        b=TQlZmYbn788G2ylUBn0MmKQB9xbtQ6wL+6Vjlu7IHkYThj7pCg1s1FiC+7O4i3br5ykPjE
        WXxuXy36txo/cY2pQcnhZY335KUqCJ2sT0qZbVob6G4M1Whl2zPuw9AKCV/uWOw+39K+jq
        EiGsgZmtCxsm8DcaLHlV+B10YavW4NG/jORFqGv/+wFvtd0+uVhmdqCisAE7/mFZVDS0v2
        9XLVMB/4tHWVHDqHp951d2E97I+2im/wv+pBO878TJviG51sGXIxFJ9yJgkrB2pSvkWRlW
        bI2222p7xUMUA3fd2yn7dS82uDL1SIYPgPHcLmVyWlXEsBI4reXQjAbAuznaUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697801872;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KUGBuTiAUtFdxJ+fiHpOy1c56kl0bFybP+sNJ4nQuK4=;
        b=2lGSre4AwXQQ3RU7gCsuKbA9IXIFGWgtmGtgbREaEa6ZMAxe+a4XZJ5Iv25+AVm1XeHrMu
        lolwNlFHvPSwIGAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Handle "nosmt" correctly
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231002115903.087472735@linutronix.de>
References: <20231002115903.087472735@linutronix.de>
MIME-Version: 1.0
Message-ID: <169780187198.3135.3109001374595114314.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     00627f647ad560222dd9475c194e5bcfd3c6cd30
Gitweb:        https://git.kernel.org/tip/00627f647ad560222dd9475c194e5bcfd3c6cd30
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 02 Oct 2023 13:59:56 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 19 Oct 2023 15:54:42 +02:00

x86/microcode: Handle "nosmt" correctly

On CPUs where microcode loading is not NMI-safe the SMT siblings which
are parked in one of the play_dead() variants still react to NMIs.

So if an NMI hits while the primary thread updates the microcode the
resulting behaviour is undefined. The default play_dead() implementation on
modern CPUs is using MWAIT which is not guaranteed to be safe against
a microcode update which affects MWAIT.

Take the cpus_booted_once_mask into account to detect this case and
refuse to load late if the vendor specific driver does not advertise
that late loading is NMI safe.

AMD stated that this is safe, so mark the AMD driver accordingly.

This requirement will be partially lifted in later changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231002115903.087472735@linutronix.de
---
 arch/x86/Kconfig                         |  2 +-
 arch/x86/kernel/cpu/microcode/amd.c      |  9 ++--
 arch/x86/kernel/cpu/microcode/core.c     | 51 ++++++++++++++---------
 arch/x86/kernel/cpu/microcode/internal.h | 13 ++----
 4 files changed, 44 insertions(+), 31 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 011cb7f..db75120 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1320,7 +1320,7 @@ config MICROCODE_INITRD32
 config MICROCODE_LATE_LOADING
 	bool "Late microcode loading (DANGEROUS)"
 	default n
-	depends on MICROCODE
+	depends on MICROCODE && SMP
 	help
 	  Loading microcode late, when the system is up and executing instructions
 	  is a tricky business and should be avoided if possible. Just the sequence
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 99aa5a8..102aebc 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -917,10 +917,11 @@ static void microcode_fini_cpu_amd(int cpu)
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
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index e306fee..7af1b60 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -254,23 +254,6 @@ static struct platform_device	*microcode_pdev;
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
@@ -387,6 +370,35 @@ static int microcode_reload_late(void)
 	return ret;
 }
 
+/*
+ *  Ensure that all required CPUs which are present and have been booted
+ *  once are online.
+ *
+ *    To pass this check, all primary threads must be online.
+ *
+ *    If the microcode load is not safe against NMI then all SMT threads
+ *    must be online as well because they still react to NMIs when they are
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
@@ -402,9 +414,10 @@ static ssize_t reload_store(struct device *dev,
 
 	cpus_read_lock();
 
-	ret = check_online_cpus();
-	if (ret)
+	if (!ensure_cpus_are_online()) {
+		ret = -EBUSY;
 		goto put;
+	}
 
 	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev);
 	if (tmp_ret != UCODE_NEW)
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
index 4bef216..07aa5f8 100644
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
