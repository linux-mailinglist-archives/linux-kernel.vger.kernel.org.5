Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524CB764F14
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjG0JOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbjG0JN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:13:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8BB420F;
        Thu, 27 Jul 2023 02:05:26 -0700 (PDT)
Date:   Thu, 27 Jul 2023 09:05:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690448724;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FnLObyjMCdqdnKrzpEy/ZyR/PvCbK4jayHFj7eUjbvs=;
        b=rTQHPAwEEDKrAIz1YUXqWWbH9q0Viqex5+xgqMLYq/yXaoUQhqPvCOn+oi/H2N6TY9qvd0
        rH+KQHBupOx+GfWES+LB7uxtN55J3tUvpXGoLHMiqKPK9yssCiyD/O2blhpLcPc4Ub61Pe
        uDeyomk7ZHzTXpNYDJiC5HGUoV6A2LvU7gVF0Fl3qJ7uyUGXIKjzgyfQZE/8EPaW8Ia7Jy
        I8AJefizrDBcBGffOwWXyuWBHQlpd8ZALGxPhgwleEWNBVjIP+JNHIwzzsfjXSnl1Dj1Sh
        CqeP4W5gJjQxthEdzE2iNV7ZVk9ybJahGmougHNFE89/y5YT1lsZzLqJ8U7ZGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690448724;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FnLObyjMCdqdnKrzpEy/ZyR/PvCbK4jayHFj7eUjbvs=;
        b=JpYUuQTWwx7ktB66vCsqwwV1WOw4I21/a/k2gPOF9VFZUUH8zui/jrEsFssyhJ9cBPNqhC
        NsJ/m9eISAkEX0Cg==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/AMD: Rip out static buffers
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230720202813.3269888-1-john.allen@amd.com>
References: <20230720202813.3269888-1-john.allen@amd.com>
MIME-Version: 1.0
Message-ID: <169044872366.28540.16194824117181865838.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     05e91e72113833385fb8c9a33bda9dbd93e27609
Gitweb:        https://git.kernel.org/tip/05e91e72113833385fb8c9a33bda9dbd93e27609
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 07 Jun 2023 21:01:06 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 27 Jul 2023 10:04:54 +02:00

x86/microcode/AMD: Rip out static buffers

Load straight from the containers (initrd or builtin, for example).
There's no need to cache the patch per node.

This even simplifies the code a bit with the opportunity for more
cleanups later.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: John Allen <john.allen@amd.com>
Link: https://lore.kernel.org/r/20230720202813.3269888-1-john.allen@amd.com
---
 arch/x86/include/asm/microcode_amd.h |  6 +--
 arch/x86/kernel/cpu/microcode/amd.c  | 91 ++++++++-------------------
 arch/x86/kernel/cpu/microcode/core.c |  4 +-
 3 files changed, 31 insertions(+), 70 deletions(-)

diff --git a/arch/x86/include/asm/microcode_amd.h b/arch/x86/include/asm/microcode_amd.h
index e6662ad..a995b76 100644
--- a/arch/x86/include/asm/microcode_amd.h
+++ b/arch/x86/include/asm/microcode_amd.h
@@ -44,13 +44,11 @@ struct microcode_amd {
 #define PATCH_MAX_SIZE (3 * PAGE_SIZE)
 
 #ifdef CONFIG_MICROCODE_AMD
-extern void __init load_ucode_amd_bsp(unsigned int family);
-extern void load_ucode_amd_ap(unsigned int family);
+extern void load_ucode_amd_early(unsigned int cpuid_1_eax);
 extern int __init save_microcode_in_initrd_amd(unsigned int family);
 void reload_ucode_amd(unsigned int cpu);
 #else
-static inline void __init load_ucode_amd_bsp(unsigned int family) {}
-static inline void load_ucode_amd_ap(unsigned int family) {}
+static inline void load_ucode_amd_early(unsigned int cpuid_1_eax) {}
 static inline int __init
 save_microcode_in_initrd_amd(unsigned int family) { return -EINVAL; }
 static inline void reload_ucode_amd(unsigned int cpu) {}
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 87208e4..a28b103 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -56,9 +56,6 @@ struct cont_desc {
 
 static u32 ucode_new_rev;
 
-/* One blob per node. */
-static u8 amd_ucode_patch[MAX_NUMNODES][PATCH_MAX_SIZE];
-
 /*
  * Microcode patch container file is prepended to the initrd in cpio
  * format. See Documentation/arch/x86/microcode.rst
@@ -415,20 +412,17 @@ static int __apply_microcode_amd(struct microcode_amd *mc)
  *
  * Returns true if container found (sets @desc), false otherwise.
  */
-static bool early_apply_microcode(u32 cpuid_1_eax, void *ucode, size_t size, bool save_patch)
+static bool early_apply_microcode(u32 cpuid_1_eax, void *ucode, size_t size)
 {
 	struct cont_desc desc = { 0 };
-	u8 (*patch)[PATCH_MAX_SIZE];
 	struct microcode_amd *mc;
 	u32 rev, dummy, *new_rev;
 	bool ret = false;
 
 #ifdef CONFIG_X86_32
 	new_rev = (u32 *)__pa_nodebug(&ucode_new_rev);
-	patch	= (u8 (*)[PATCH_MAX_SIZE])__pa_nodebug(&amd_ucode_patch);
 #else
 	new_rev = &ucode_new_rev;
-	patch	= &amd_ucode_patch[0];
 #endif
 
 	desc.cpuid_1_eax = cpuid_1_eax;
@@ -452,9 +446,6 @@ static bool early_apply_microcode(u32 cpuid_1_eax, void *ucode, size_t size, boo
 	if (!__apply_microcode_amd(mc)) {
 		*new_rev = mc->hdr.patch_id;
 		ret      = true;
-
-		if (save_patch)
-			memcpy(patch, mc, min_t(u32, desc.psize, PATCH_MAX_SIZE));
 	}
 
 	return ret;
@@ -507,7 +498,7 @@ static void find_blobs_in_containers(unsigned int cpuid_1_eax, struct cpio_data 
 	*ret = cp;
 }
 
-void __init load_ucode_amd_bsp(unsigned int cpuid_1_eax)
+static void apply_ucode_from_containers(unsigned int cpuid_1_eax)
 {
 	struct cpio_data cp = { };
 
@@ -515,42 +506,12 @@ void __init load_ucode_amd_bsp(unsigned int cpuid_1_eax)
 	if (!(cp.data && cp.size))
 		return;
 
-	early_apply_microcode(cpuid_1_eax, cp.data, cp.size, true);
+	early_apply_microcode(cpuid_1_eax, cp.data, cp.size);
 }
 
-void load_ucode_amd_ap(unsigned int cpuid_1_eax)
+void load_ucode_amd_early(unsigned int cpuid_1_eax)
 {
-	struct microcode_amd *mc;
-	struct cpio_data cp;
-	u32 *new_rev, rev, dummy;
-
-	if (IS_ENABLED(CONFIG_X86_32)) {
-		mc	= (struct microcode_amd *)__pa_nodebug(amd_ucode_patch);
-		new_rev = (u32 *)__pa_nodebug(&ucode_new_rev);
-	} else {
-		mc	= (struct microcode_amd *)amd_ucode_patch;
-		new_rev = &ucode_new_rev;
-	}
-
-	native_rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
-
-	/*
-	 * Check whether a new patch has been saved already. Also, allow application of
-	 * the same revision in order to pick up SMT-thread-specific configuration even
-	 * if the sibling SMT thread already has an up-to-date revision.
-	 */
-	if (*new_rev && rev <= mc->hdr.patch_id) {
-		if (!__apply_microcode_amd(mc)) {
-			*new_rev = mc->hdr.patch_id;
-			return;
-		}
-	}
-
-	find_blobs_in_containers(cpuid_1_eax, &cp);
-	if (!(cp.data && cp.size))
-		return;
-
-	early_apply_microcode(cpuid_1_eax, cp.data, cp.size, false);
+	return apply_ucode_from_containers(cpuid_1_eax);
 }
 
 static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t size);
@@ -578,23 +539,6 @@ int __init save_microcode_in_initrd_amd(unsigned int cpuid_1_eax)
 	return 0;
 }
 
-void reload_ucode_amd(unsigned int cpu)
-{
-	u32 rev, dummy __always_unused;
-	struct microcode_amd *mc;
-
-	mc = (struct microcode_amd *)amd_ucode_patch[cpu_to_node(cpu)];
-
-	rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
-
-	if (rev < mc->hdr.patch_id) {
-		if (!__apply_microcode_amd(mc)) {
-			ucode_new_rev = mc->hdr.patch_id;
-			pr_info("reload patch_level=0x%08x\n", ucode_new_rev);
-		}
-	}
-}
-
 /*
  * a small, trivial cache of per-family ucode patches
  */
@@ -655,6 +599,28 @@ static struct ucode_patch *find_patch(unsigned int cpu)
 	return cache_find_patch(equiv_id);
 }
 
+void reload_ucode_amd(unsigned int cpu)
+{
+	u32 rev, dummy __always_unused;
+	struct microcode_amd *mc;
+	struct ucode_patch *p;
+
+	p = find_patch(cpu);
+	if (!p)
+		return;
+
+	mc = p->data;
+
+	rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
+
+	if (rev < mc->hdr.patch_id) {
+		if (!__apply_microcode_amd(mc)) {
+			ucode_new_rev = mc->hdr.patch_id;
+			pr_info("reload patch_level=0x%08x\n", ucode_new_rev);
+		}
+	}
+}
+
 static int collect_cpu_info_amd(int cpu, struct cpu_signature *csig)
 {
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
@@ -875,9 +841,6 @@ static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t siz
 			continue;
 
 		ret = UCODE_NEW;
-
-		memset(&amd_ucode_patch[nid], 0, PATCH_MAX_SIZE);
-		memcpy(&amd_ucode_patch[nid], p->data, min_t(u32, p->size, PATCH_MAX_SIZE));
 	}
 
 	return ret;
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 3afcf3d..192adf5 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -172,7 +172,7 @@ void __init load_ucode_bsp(void)
 	if (intel)
 		load_ucode_intel_bsp();
 	else
-		load_ucode_amd_bsp(cpuid_1_eax);
+		load_ucode_amd_early(cpuid_1_eax);
 }
 
 static bool check_loader_disabled_ap(void)
@@ -200,7 +200,7 @@ void load_ucode_ap(void)
 		break;
 	case X86_VENDOR_AMD:
 		if (x86_family(cpuid_1_eax) >= 0x10)
-			load_ucode_amd_ap(cpuid_1_eax);
+			load_ucode_amd_early(cpuid_1_eax);
 		break;
 	default:
 		break;
