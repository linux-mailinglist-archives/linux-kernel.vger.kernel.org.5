Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F367F328F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbjKUPmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjKUPmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:42:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A8911A;
        Tue, 21 Nov 2023 07:42:07 -0800 (PST)
Date:   Tue, 21 Nov 2023 15:42:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700581325;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jHI+qNMn4FA7Ege4M3T5evzUTiOoJdjGCcUwPT1romc=;
        b=tYtpqpy8U/rBXZCFt8sF3zhomC+MbW7wI9OIgCVMNKXSfqmoHnH+bOQS5HxJBHLDyddD92
        37utD2wBNM+ayaYebwuhdKdof4BbZJlTRDioxd+DL8Zz8I0m1cDuuZvpcNjXQ2XDOHpNAg
        2ptRtfOaJnIKU3lydrDnsS8A47NT0SCWYhnM8NUYdhHhdoXtz42udgSw3jnsccqM+LqQ/q
        Xl4p7d1uLTiR6B5IB+2IftMCxwYa1jzyft4LNUqfq/huUQre4nP1a3mMk2GRdnCkikcj0X
        EsFRl/CiNyjEdxCml/eZreTLyaikw/6mIdtF+9AGTmK+x6REft6Dj19GxIJOZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700581325;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jHI+qNMn4FA7Ege4M3T5evzUTiOoJdjGCcUwPT1romc=;
        b=Y+erm6NNE6TiIfzHEP+vAuHhEePI8Iqqfk0gPlvWU4XkZh8dlNYBezNiK9Zcc5Tywkm/u7
        iPXtI5plvDQBWdCA==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/microcode: Rework early revisions reporting
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <CAHk-=wg=%2B8rceshMkB4VnKxmRccVLtBLPBawnewZuuqyx5U=3A@mail.gmail.com>
References: <CAHk-=wg=%2B8rceshMkB4VnKxmRccVLtBLPBawnewZuuqyx5U=3A@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <170058132475.398.7556129004653311641.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     080990aa3344123673f686cda2df0d1b0deee046
Gitweb:        https://git.kernel.org/tip/080990aa3344123673f686cda2df0d1b0deee046
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 15 Nov 2023 22:02:12 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 21 Nov 2023 16:35:48 +01:00

x86/microcode: Rework early revisions reporting

The AMD side of the loader issues the microcode revision for each
logical thread on the system, which can become really noisy on huge
machines. And doing that doesn't make a whole lot of sense - the
microcode revision is already in /proc/cpuinfo.

So in case one is interested in the theoretical support of mixed silicon
steppings on AMD, one can check there.

What is also missing on the AMD side - something which people have
requested before - is showing the microcode revision the CPU had
*before* the early update.

So abstract that up in the main code and have the BSP on each vendor
provide those revision numbers.

Then, dump them only once on driver init.

On Intel, do not dump the patch date - it is not needed.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/CAHk-=wg=%2B8rceshMkB4VnKxmRccVLtBLPBawnewZuuqyx5U=3A@mail.gmail.com
---
 arch/x86/kernel/cpu/microcode/amd.c      | 39 ++++++-----------------
 arch/x86/kernel/cpu/microcode/core.c     | 11 ++++--
 arch/x86/kernel/cpu/microcode/intel.c    | 17 ++++------
 arch/x86/kernel/cpu/microcode/internal.h | 14 +++++---
 4 files changed, 37 insertions(+), 44 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 9373ec0..13b45b9 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -104,8 +104,6 @@ struct cont_desc {
 	size_t		     size;
 };
 
-static u32 ucode_new_rev;
-
 /*
  * Microcode patch container file is prepended to the initrd in cpio
  * format. See Documentation/arch/x86/microcode.rst
@@ -442,12 +440,11 @@ static int __apply_microcode_amd(struct microcode_amd *mc)
  *
  * Returns true if container found (sets @desc), false otherwise.
  */
-static bool early_apply_microcode(u32 cpuid_1_eax, void *ucode, size_t size)
+static bool early_apply_microcode(u32 cpuid_1_eax, u32 old_rev, void *ucode, size_t size)
 {
 	struct cont_desc desc = { 0 };
 	struct microcode_amd *mc;
 	bool ret = false;
-	u32 rev, dummy;
 
 	desc.cpuid_1_eax = cpuid_1_eax;
 
@@ -457,22 +454,15 @@ static bool early_apply_microcode(u32 cpuid_1_eax, void *ucode, size_t size)
 	if (!mc)
 		return ret;
 
-	native_rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
-
 	/*
 	 * Allow application of the same revision to pick up SMT-specific
 	 * changes even if the revision of the other SMT thread is already
 	 * up-to-date.
 	 */
-	if (rev > mc->hdr.patch_id)
+	if (old_rev > mc->hdr.patch_id)
 		return ret;
 
-	if (!__apply_microcode_amd(mc)) {
-		ucode_new_rev = mc->hdr.patch_id;
-		ret = true;
-	}
-
-	return ret;
+	return !__apply_microcode_amd(mc);
 }
 
 static bool get_builtin_microcode(struct cpio_data *cp, unsigned int family)
@@ -506,9 +496,12 @@ static void __init find_blobs_in_containers(unsigned int cpuid_1_eax, struct cpi
 	*ret = cp;
 }
 
-void __init load_ucode_amd_bsp(unsigned int cpuid_1_eax)
+void __init load_ucode_amd_bsp(struct early_load_data *ed, unsigned int cpuid_1_eax)
 {
 	struct cpio_data cp = { };
+	u32 dummy;
+
+	native_rdmsr(MSR_AMD64_PATCH_LEVEL, ed->old_rev, dummy);
 
 	/* Needed in load_microcode_amd() */
 	ucode_cpu_info[0].cpu_sig.sig = cpuid_1_eax;
@@ -517,7 +510,8 @@ void __init load_ucode_amd_bsp(unsigned int cpuid_1_eax)
 	if (!(cp.data && cp.size))
 		return;
 
-	early_apply_microcode(cpuid_1_eax, cp.data, cp.size);
+	if (early_apply_microcode(cpuid_1_eax, ed->old_rev, cp.data, cp.size))
+		native_rdmsr(MSR_AMD64_PATCH_LEVEL, ed->new_rev, dummy);
 }
 
 static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t size);
@@ -625,10 +619,8 @@ void reload_ucode_amd(unsigned int cpu)
 	rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
 
 	if (rev < mc->hdr.patch_id) {
-		if (!__apply_microcode_amd(mc)) {
-			ucode_new_rev = mc->hdr.patch_id;
-			pr_info("reload patch_level=0x%08x\n", ucode_new_rev);
-		}
+		if (!__apply_microcode_amd(mc))
+			pr_info_once("reload revision: 0x%08x\n", mc->hdr.patch_id);
 	}
 }
 
@@ -649,8 +641,6 @@ static int collect_cpu_info_amd(int cpu, struct cpu_signature *csig)
 	if (p && (p->patch_id == csig->rev))
 		uci->mc = p->data;
 
-	pr_info("CPU%d: patch_level=0x%08x\n", cpu, csig->rev);
-
 	return 0;
 }
 
@@ -691,8 +681,6 @@ static enum ucode_state apply_microcode_amd(int cpu)
 	rev = mc_amd->hdr.patch_id;
 	ret = UCODE_UPDATED;
 
-	pr_info("CPU%d: new patch_level=0x%08x\n", cpu, rev);
-
 out:
 	uci->cpu_sig.rev = rev;
 	c->microcode	 = rev;
@@ -935,11 +923,6 @@ struct microcode_ops * __init init_amd_microcode(void)
 		pr_warn("AMD CPU family 0x%x not supported\n", c->x86);
 		return NULL;
 	}
-
-	if (ucode_new_rev)
-		pr_info_once("microcode updated early to new patch_level=0x%08x\n",
-			     ucode_new_rev);
-
 	return &microcode_amd_ops;
 }
 
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index b4be3a2..232026a 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -75,6 +75,8 @@ static u32 final_levels[] = {
 	0, /* T-101 terminator */
 };
 
+struct early_load_data early_data;
+
 /*
  * Check the current patch level on this CPU.
  *
@@ -153,9 +155,9 @@ void __init load_ucode_bsp(void)
 		return;
 
 	if (intel)
-		load_ucode_intel_bsp();
+		load_ucode_intel_bsp(&early_data);
 	else
-		load_ucode_amd_bsp(cpuid_1_eax);
+		load_ucode_amd_bsp(&early_data, cpuid_1_eax);
 }
 
 void load_ucode_ap(void)
@@ -826,6 +828,11 @@ static int __init microcode_init(void)
 	if (!microcode_ops)
 		return -ENODEV;
 
+	pr_info_once("Current revision: 0x%08x\n", (early_data.new_rev ?: early_data.old_rev));
+
+	if (early_data.new_rev)
+		pr_info_once("Updated early from: 0x%08x\n", early_data.old_rev);
+
 	microcode_pdev = platform_device_register_simple("microcode", -1, NULL, 0);
 	if (IS_ERR(microcode_pdev))
 		return PTR_ERR(microcode_pdev);
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 6024feb..070426b 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -339,16 +339,9 @@ static enum ucode_state __apply_microcode(struct ucode_cpu_info *uci,
 static enum ucode_state apply_microcode_early(struct ucode_cpu_info *uci)
 {
 	struct microcode_intel *mc = uci->mc;
-	enum ucode_state ret;
-	u32 cur_rev, date;
+	u32 cur_rev;
 
-	ret = __apply_microcode(uci, mc, &cur_rev);
-	if (ret == UCODE_UPDATED) {
-		date = mc->hdr.date;
-		pr_info_once("updated early: 0x%x -> 0x%x, date = %04x-%02x-%02x\n",
-			     cur_rev, mc->hdr.rev, date & 0xffff, date >> 24, (date >> 16) & 0xff);
-	}
-	return ret;
+	return __apply_microcode(uci, mc, &cur_rev);
 }
 
 static __init bool load_builtin_intel_microcode(struct cpio_data *cp)
@@ -413,13 +406,17 @@ static int __init save_builtin_microcode(void)
 early_initcall(save_builtin_microcode);
 
 /* Load microcode on BSP from initrd or builtin blobs */
-void __init load_ucode_intel_bsp(void)
+void __init load_ucode_intel_bsp(struct early_load_data *ed)
 {
 	struct ucode_cpu_info uci;
 
+	ed->old_rev = intel_get_microcode_revision();
+
 	uci.mc = get_microcode_blob(&uci, false);
 	if (uci.mc && apply_microcode_early(&uci) == UCODE_UPDATED)
 		ucode_patch_va = UCODE_BSP_LOADED;
+
+	ed->new_rev = uci.cpu_sig.rev;
 }
 
 void load_ucode_intel_ap(void)
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
index f8047b1..21776c5 100644
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -37,6 +37,12 @@ struct microcode_ops {
 				use_nmi		: 1;
 };
 
+struct early_load_data {
+	u32 old_rev;
+	u32 new_rev;
+};
+
+extern struct early_load_data early_data;
 extern struct ucode_cpu_info ucode_cpu_info[];
 struct cpio_data find_microcode_in_initrd(const char *path);
 
@@ -92,14 +98,14 @@ extern bool dis_ucode_ldr;
 extern bool force_minrev;
 
 #ifdef CONFIG_CPU_SUP_AMD
-void load_ucode_amd_bsp(unsigned int family);
+void load_ucode_amd_bsp(struct early_load_data *ed, unsigned int family);
 void load_ucode_amd_ap(unsigned int family);
 int save_microcode_in_initrd_amd(unsigned int family);
 void reload_ucode_amd(unsigned int cpu);
 struct microcode_ops *init_amd_microcode(void);
 void exit_amd_microcode(void);
 #else /* CONFIG_CPU_SUP_AMD */
-static inline void load_ucode_amd_bsp(unsigned int family) { }
+static inline void load_ucode_amd_bsp(struct early_load_data *ed, unsigned int family) { }
 static inline void load_ucode_amd_ap(unsigned int family) { }
 static inline int save_microcode_in_initrd_amd(unsigned int family) { return -EINVAL; }
 static inline void reload_ucode_amd(unsigned int cpu) { }
@@ -108,12 +114,12 @@ static inline void exit_amd_microcode(void) { }
 #endif /* !CONFIG_CPU_SUP_AMD */
 
 #ifdef CONFIG_CPU_SUP_INTEL
-void load_ucode_intel_bsp(void);
+void load_ucode_intel_bsp(struct early_load_data *ed);
 void load_ucode_intel_ap(void);
 void reload_ucode_intel(void);
 struct microcode_ops *init_intel_microcode(void);
 #else /* CONFIG_CPU_SUP_INTEL */
-static inline void load_ucode_intel_bsp(void) { }
+static inline void load_ucode_intel_bsp(struct early_load_data *ed) { }
 static inline void load_ucode_intel_ap(void) { }
 static inline void reload_ucode_intel(void) { }
 static inline struct microcode_ops *init_intel_microcode(void) { return NULL; }
