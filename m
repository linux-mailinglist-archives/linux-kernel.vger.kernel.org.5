Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121467C4DE9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345884AbjJKJBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345790AbjJKJBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:01:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D1C98;
        Wed, 11 Oct 2023 02:01:02 -0700 (PDT)
Date:   Wed, 11 Oct 2023 09:01:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697014861;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PrGhcJKZlzyidO3Ij2IwNP+aZGZ/4oRITox15tAlxY8=;
        b=UF/ObWCRyNGVDEBuDmPjzToF4knsUKguT0+ZtfaZoKEzI6E6q/TYcKh5n27EfGuPEJ6BzR
        z5DtySnV24/6xxBgu/wzCL3Xb1Ppl+dmpb5pJG6/pet8G2FeifSJXXUbbDbk2npNKI5G3y
        euEp+qgaoT7MAfwbimZ/V9wwBDXTvGjzcyRzS2veqGMzhSeBeX+couO2I9BHu4qU90RqcQ
        YWce7Y48+cq5mV9WZ80lSRpJBUb2tpqw2u4P29PUd3FWEoiANMU1w7BdISKRrWRxx3wnZE
        5iU4StRA8HakeMzrF/kQLiN07Vw9EMvWdzHYVWsWV9gBk0lhSoR6ziObTgRkZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697014861;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PrGhcJKZlzyidO3Ij2IwNP+aZGZ/4oRITox15tAlxY8=;
        b=hXdxfxQS/zyYC8VQz3hiTsWNR5TY03RW45u7mG2XT2w4dJ96c0+ycvrkcECvE7scmJD6FK
        ScK1YCOc4LCGdADw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/amd: Use cached microcode for AP load
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231010150702.606691031@linutronix.de>
References: <20231010150702.606691031@linutronix.de>
MIME-Version: 1.0
Message-ID: <169701486052.3135.4421282912332882867.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     1c9faa6577b3230ba62a51dc504d841b5ef630de
Gitweb:        https://git.kernel.org/tip/1c9faa6577b3230ba62a51dc504d841b5ef630de
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 10 Oct 2023 17:08:45 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 10 Oct 2023 21:16:47 +02:00

x86/microcode/amd: Use cached microcode for AP load

Now that the microcode cache is initialized before the APs are brought up,
there is no point in scanning builtin/initrd microcode during AP
loading.

Convert the AP loader to utilize the cache, which in turn makes the CPU
hotplug callback which applies the microcode after initrd/builtin is
gone, obsolete as the early loading during late hotplug operations
including the resume path depends now only on the cache.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231010150702.606691031@linutronix.de
---
 arch/x86/kernel/cpu/microcode/amd.c      | 20 +++++++++++---------
 arch/x86/kernel/cpu/microcode/core.c     | 15 ++-------------
 arch/x86/kernel/cpu/microcode/internal.h |  2 --
 3 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 6a1495a..8baa8ce 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -496,7 +496,7 @@ static bool get_builtin_microcode(struct cpio_data *cp, unsigned int family)
 	return false;
 }
 
-static void find_blobs_in_containers(unsigned int cpuid_1_eax, struct cpio_data *ret)
+static void __init find_blobs_in_containers(unsigned int cpuid_1_eax, struct cpio_data *ret)
 {
 	struct cpio_data cp;
 
@@ -506,12 +506,12 @@ static void find_blobs_in_containers(unsigned int cpuid_1_eax, struct cpio_data 
 	*ret = cp;
 }
 
-static void apply_ucode_from_containers(unsigned int cpuid_1_eax)
+void __init load_ucode_amd_bsp(unsigned int cpuid_1_eax)
 {
 	struct cpio_data cp = { };
 
 	/* Needed in load_microcode_amd() */
-	ucode_cpu_info[smp_processor_id()].cpu_sig.sig = cpuid_1_eax;
+	ucode_cpu_info[0].cpu_sig.sig = cpuid_1_eax;
 
 	find_blobs_in_containers(cpuid_1_eax, &cp);
 	if (!(cp.data && cp.size))
@@ -520,11 +520,6 @@ static void apply_ucode_from_containers(unsigned int cpuid_1_eax)
 	early_apply_microcode(cpuid_1_eax, cp.data, cp.size);
 }
 
-void load_ucode_amd_early(unsigned int cpuid_1_eax)
-{
-	return apply_ucode_from_containers(cpuid_1_eax);
-}
-
 static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t size);
 
 static int __init save_microcode_in_initrd(void)
@@ -608,7 +603,6 @@ static struct ucode_patch *find_patch(unsigned int cpu)
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 	u16 equiv_id;
 
-
 	equiv_id = find_equiv_id(&equiv_table, uci->cpu_sig.sig);
 	if (!equiv_id)
 		return NULL;
@@ -710,6 +704,14 @@ out:
 	return ret;
 }
 
+void load_ucode_amd_ap(unsigned int cpuid_1_eax)
+{
+	unsigned int cpu = smp_processor_id();
+
+	ucode_cpu_info[cpu].cpu_sig.sig = cpuid_1_eax;
+	apply_microcode_amd(cpu);
+}
+
 static size_t install_equiv_cpu_table(const u8 *buf, size_t buf_size)
 {
 	u32 equiv_tbl_len;
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index b71bac0..57dde24 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -159,7 +159,7 @@ void __init load_ucode_bsp(void)
 	if (intel)
 		load_ucode_intel_bsp();
 	else
-		load_ucode_amd_early(cpuid_1_eax);
+		load_ucode_amd_bsp(cpuid_1_eax);
 }
 
 void load_ucode_ap(void)
@@ -178,7 +178,7 @@ void load_ucode_ap(void)
 		break;
 	case X86_VENDOR_AMD:
 		if (x86_family(cpuid_1_eax) >= 0x10)
-			load_ucode_amd_early(cpuid_1_eax);
+			load_ucode_amd_ap(cpuid_1_eax);
 		break;
 	default:
 		break;
@@ -789,15 +789,6 @@ static struct syscore_ops mc_syscore_ops = {
 	.resume	= microcode_bsp_resume,
 };
 
-static int mc_cpu_starting(unsigned int cpu)
-{
-	enum ucode_state err = microcode_ops->apply_microcode(cpu);
-
-	pr_debug("%s: CPU%d, err: %d\n", __func__, cpu, err);
-
-	return err == UCODE_ERROR;
-}
-
 static int mc_cpu_online(unsigned int cpu)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
@@ -870,8 +861,6 @@ static int __init microcode_init(void)
 	}
 
 	register_syscore_ops(&mc_syscore_ops);
-	cpuhp_setup_state_nocalls(CPUHP_AP_MICROCODE_LOADER, "x86/microcode:starting",
-				  mc_cpu_starting, NULL);
 	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/microcode:online",
 			  mc_cpu_online, mc_cpu_down_prep);
 
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
index de37255..9930788 100644
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -95,7 +95,6 @@ extern bool initrd_gone;
 #ifdef CONFIG_CPU_SUP_AMD
 void load_ucode_amd_bsp(unsigned int family);
 void load_ucode_amd_ap(unsigned int family);
-void load_ucode_amd_early(unsigned int cpuid_1_eax);
 int save_microcode_in_initrd_amd(unsigned int family);
 void reload_ucode_amd(unsigned int cpu);
 struct microcode_ops *init_amd_microcode(void);
@@ -103,7 +102,6 @@ void exit_amd_microcode(void);
 #else /* CONFIG_CPU_SUP_AMD */
 static inline void load_ucode_amd_bsp(unsigned int family) { }
 static inline void load_ucode_amd_ap(unsigned int family) { }
-static inline void load_ucode_amd_early(unsigned int family) { }
 static inline int save_microcode_in_initrd_amd(unsigned int family) { return -EINVAL; }
 static inline void reload_ucode_amd(unsigned int cpu) { }
 static inline struct microcode_ops *init_amd_microcode(void) { return NULL; }
