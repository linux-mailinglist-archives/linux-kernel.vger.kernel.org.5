Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBB17BFFF2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbjJJPIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbjJJPIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:08:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7267D93
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 08:08:47 -0700 (PDT)
Message-ID: <20231010150702.606691031@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696950525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=t0IcpvLhad8KFsm8A/vXcS685lwQ2BubUPwtUH49A0A=;
        b=YeLPjQGzO30pqfs82S6WkphU4cPRx9OxHauEEpFZAEsberhwcFY2WbiV//Z/WLUvM7+D3w
        q5H6iiOf+zXGMTiqvihrBchAF7Yih6fHlPJlvsRAB9hbi5UGLLpjTrUz/hFhekh2rcFZLQ
        knUGZj+9RUcNbcZUud5vKbIvdd1Pey+JH8q0CuFVz0dop+8lK6Xh5QojLjz2BYC3jBHfe5
        pj/epnmqP63XcAdirJdlPCvrWVCBGjyNbI0vquMUfaieDtGXQFaxDN2Ytl/5nZyUPXFzw8
        9wJ0P9jabCz0nYy08Zl8MARJIpOdVNHELTkZRQTiJbavwu1qyD3oSbeDn3jPeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696950525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=t0IcpvLhad8KFsm8A/vXcS685lwQ2BubUPwtUH49A0A=;
        b=NkF8O8ydvZvVzah70iFyiWGa/+4tmn/Pn9r0lhEnV78FI9SD0U8zSau/8SB8etkOzhIx2O
        Y778RGSRJhE1WUAQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>
Subject: [patch 4/5] x86/microcode/amd: Use cached microcode for AP load
References: <20231010145130.987300357@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 10 Oct 2023 17:08:45 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the microcode cache is initialized before the APs are brought up,
there is no point to scan builtin/initrd microcode during AP loading.

Convert the AP loader to utilize the cache, which in turn makes the CPU
hotplug callback which applies the microcode after initrd/builtin is gone
obsolete as the early loading during late hotplug operations including the
resume path depends now only on the cache.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/microcode/amd.c      |   20 +++++++++++---------
 arch/x86/kernel/cpu/microcode/core.c     |   15 ++-------------
 arch/x86/kernel/cpu/microcode/internal.h |    2 --
 3 files changed, 13 insertions(+), 24 deletions(-)

--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -496,7 +496,7 @@ static bool get_builtin_microcode(struct
 	return false;
 }
 
-static void find_blobs_in_containers(unsigned int cpuid_1_eax, struct cpio_data *ret)
+static void __init find_blobs_in_containers(unsigned int cpuid_1_eax, struct cpio_data *ret)
 {
 	struct cpio_data cp;
 
@@ -506,12 +506,12 @@ static void find_blobs_in_containers(uns
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
@@ -520,11 +520,6 @@ static void apply_ucode_from_containers(
 	early_apply_microcode(cpuid_1_eax, cp.data, cp.size);
 }
 
-void load_ucode_amd_early(unsigned int cpuid_1_eax)
-{
-	return apply_ucode_from_containers(cpuid_1_eax);
-}
-
 static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t size);
 
 static int __init save_microcode_in_initrd(void)
@@ -608,7 +603,6 @@ static struct ucode_patch *find_patch(un
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 	u16 equiv_id;
 
-
 	equiv_id = find_equiv_id(&equiv_table, uci->cpu_sig.sig);
 	if (!equiv_id)
 		return NULL;
@@ -710,6 +704,14 @@ static enum ucode_state apply_microcode_
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
@@ -789,15 +789,6 @@ static struct syscore_ops mc_syscore_ops
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

