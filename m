Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C70778067
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbjHJSi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235922AbjHJSiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:38:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BED2D4A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:37:49 -0700 (PDT)
Message-ID: <20230810160805.765194207@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691692667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ZFRMFzgOpNSYcs1HlmeI6jZPToCyvM4ul9GaIvD1IMg=;
        b=tyegCHnLUXL2vy/2z0pH1U4qIOyt8zo7A5NfwCS9sPoT93eggmezItUAefyKiZZ4ghdnCH
        n/o21RNBETU0XaUUUHVnuwRTg5Th6ppiANOhNaPieuAXhIh1EUbd4jY/8dwQutqL1Srlru
        E0I5Ev0Nq9lCWiEnweym2ZMz0USOdZpnrhhHOF95IjnFvw9bwQbuTxB7gvvs0vf5cRrkWs
        AvRMgqt+OHSE4pfKJlfZIENSmmJswutEyNFVYtkXyE8J+PT7rR1DhsT2DziI0qCCyOHXQJ
        vozWZ7MFGm8TghIpbhokBd/FyCcHOkcmGUx5GQnBASjeV/iTD6aqJlvE2t2Rwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691692667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ZFRMFzgOpNSYcs1HlmeI6jZPToCyvM4ul9GaIvD1IMg=;
        b=KthiAOxj/iA4QIR9upDFQ0mQJtjA0lh8zEL8I7tQadrc+hSNt8OS+6DYh78KMD3qkDroA8
        cPysuIJT4U0xbxAQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: [patch 14/30] x86/microcode/intel: Simplify early loading
References: <20230810153317.850017756@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 10 Aug 2023 20:37:46 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The early loading code is overly complicated:

  - It scans the builtin/initrd for microcode not only on the BSP, but also
    on all APs during early boot and then later in the boot process it
    scans again to duplicate and save the microcode before initrd goes away.

    That's a pointless exercise because this can be simply done before
    bringing up the APs when the memory allocator is up and running.

 - Saving the microcode from within the scan loop is completely
   non-obvious and a left over of the microcode cache.

   This can be done at the call site now which makes it obvious.

Rework the code so that only the BSP scans the builtin/initrd microcode
once during early boot and save it away in an early initcall for later
use.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/kernel/cpu/microcode/core.c     |    4 
 arch/x86/kernel/cpu/microcode/intel.c    |  191 +++++++++++++------------------
 arch/x86/kernel/cpu/microcode/internal.h |    2 
 3 files changed, 86 insertions(+), 111 deletions(-)
---
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -207,10 +207,6 @@ static int __init save_microcode_in_init
 	int ret = -EINVAL;
 
 	switch (c->x86_vendor) {
-	case X86_VENDOR_INTEL:
-		if (c->x86 >= 6)
-			ret = save_microcode_in_initrd_intel();
-		break;
 	case X86_VENDOR_AMD:
 		if (c->x86 >= 0x10)
 			ret = save_microcode_in_initrd_amd(cpuid_eax(1));
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -33,7 +33,7 @@
 static const char ucode_path[] = "kernel/x86/microcode/GenuineIntel.bin";
 
 /* Current microcode patch used in early patching on the APs. */
-static struct microcode_intel *intel_ucode_patch __read_mostly;
+static struct microcode_intel *ucode_patch_va __read_mostly;
 
 /* last level cache size per core */
 static unsigned int llc_size_per_core __ro_after_init;
@@ -212,31 +212,34 @@ int intel_microcode_sanity_check(void *m
 }
 EXPORT_SYMBOL_GPL(intel_microcode_sanity_check);
 
-static void save_microcode_patch(void *data, unsigned int size)
+static void update_ucode_pointer(struct microcode_intel *mc)
 {
-	struct microcode_header_intel *p;
-
-	kfree(intel_ucode_patch);
-	intel_ucode_patch = NULL;
-
-	p = kmemdup(data, size, GFP_KERNEL);
-	if (!p)
-		return;
+	kfree(ucode_patch_va);
 
 	/*
-	 * Save for early loading. On 32-bit, that needs to be a physical
-	 * address as the APs are running from physical addresses, before
-	 * paging has been enabled.
+	 * Save the virtual address for early loading on 64bit
+	 * and for eventual free on late loading.
+	 *
+	 * On 32-bit, that needs to store the physical address too as the
+	 * APs are loading before paging has been enabled.
 	 */
-	if (IS_ENABLED(CONFIG_X86_32))
-		intel_ucode_patch = (struct microcode_intel *)__pa_nodebug(p);
+	ucode_patch_va = mc;
+}
+
+static void save_microcode_patch(struct microcode_intel *patch)
+{
+	struct microcode_intel *mc;
+
+	mc = kmemdup(patch, get_totalsize(&patch->hdr), GFP_KERNEL);
+	if (mc)
+		update_ucode_pointer(mc);
 	else
-		intel_ucode_patch = (struct microcode_intel *)p;
+		pr_err("Unable to allocate microcode memory\n");
 }
 
 /* Scan CPIO for microcode matching the boot CPUs family, model, stepping */
-static struct microcode_intel *scan_microcode(void *data, size_t size,
-					      struct ucode_cpu_info *uci, bool save)
+static __init struct microcode_intel *scan_microcode(void *data, size_t size,
+						     struct ucode_cpu_info *uci)
 {
 	struct microcode_header_intel *mc_header;
 	struct microcode_intel *patch = NULL;
@@ -254,25 +257,15 @@ static struct microcode_intel *scan_micr
 		if (!intel_find_matching_signature(data, uci->cpu_sig.sig, uci->cpu_sig.pf))
 			continue;
 
-		/* BSP scan: Check whether there is newer microcode */
-		if (save && cur_rev >= mc_header->rev)
-			continue;
-
-		/* Save scan: Check whether there is newer or matching microcode */
-		if (save && cur_rev != mc_header->rev)
+		/* Check whether there is newer microcode */
+		if (cur_rev >= mc_header->rev)
 			continue;
 
 		patch = data;
 		cur_rev = mc_header->rev;
 	}
 
-	if (size)
-		return NULL;
-
-	if (save && patch)
-		save_microcode_patch(patch, mc_size);
-
-	return patch;
+	return size ? NULL : patch;
 }
 
 static void print_ucode_info(int old_rev, int new_rev, unsigned int date)
@@ -327,14 +320,14 @@ static inline void print_ucode(int old_r
 }
 #endif
 
-static int apply_microcode_early(struct ucode_cpu_info *uci, bool early)
+static enum ucode_state apply_microcode_early(struct ucode_cpu_info *uci, bool early)
 {
 	struct microcode_intel *mc;
 	u32 rev, old_rev;
 
 	mc = uci->mc;
 	if (!mc)
-		return 0;
+		return UCODE_NFOUND;
 
 	/*
 	 * Save us the MSR write below - which is a particular expensive
@@ -360,7 +353,7 @@ static int apply_microcode_early(struct
 
 	rev = intel_get_microcode_revision();
 	if (rev != mc->hdr.rev)
-		return -1;
+		return UCODE_ERROR;
 
 	uci->cpu_sig.rev = rev;
 
@@ -369,10 +362,10 @@ static int apply_microcode_early(struct
 	else
 		print_ucode_info(old_rev, uci->cpu_sig.rev, mc->hdr.date);
 
-	return 0;
+	return UCODE_UPDATED;
 }
 
-static bool load_builtin_intel_microcode(struct cpio_data *cp)
+static __init bool load_builtin_intel_microcode(struct cpio_data *cp)
 {
 	unsigned int eax = 1, ebx, ecx = 0, edx;
 	struct firmware fw;
@@ -394,108 +387,96 @@ static bool load_builtin_intel_microcode
 	return false;
 }
 
-int __init save_microcode_in_initrd_intel(void)
+static __init struct microcode_intel *get_ucode_from_cpio(struct ucode_cpu_info *uci)
 {
-	struct ucode_cpu_info uci;
+	bool use_pa = IS_ENABLED(CONFIG_X86_32);
+	const char *path = ucode_path;
 	struct cpio_data cp;
 
-	/*
-	 * initrd is going away, clear patch ptr. We will scan the microcode one
-	 * last time before jettisoning and save a patch, if found. Then we will
-	 * update that pointer too, with a stable patch address to use when
-	 * resuming the cores.
-	 */
-	intel_ucode_patch = NULL;
+	/* Paging is not yet enabled on 32bit! */
+	if (IS_ENABLED(CONFIG_X86_32))
+		path = (const char *)__pa_nodebug(ucode_path);
 
+	/* Try built-in microcode first */
 	if (!load_builtin_intel_microcode(&cp))
-		cp = find_microcode_in_initrd(ucode_path, false);
+		cp = find_microcode_in_initrd(path, use_pa);
 
 	if (!(cp.data && cp.size))
-		return 0;
+		return NULL;
 
-	intel_cpu_collect_info(&uci);
+	intel_cpu_collect_info(uci);
 
-	scan_microcode(cp.data, cp.size, &uci, true);
-	return 0;
+	return scan_microcode(cp.data, cp.size, uci);
 }
 
+static struct microcode_intel *ucode_early_pa __initdata;
+
 /*
- * @res_patch, output: a pointer to the patch we found.
+ * Invoked from an early init call to save the microcode blob which was
+ * selected during early boot when mm was not usable. The microcode must be
+ * saved because initrd is going away. It's an early init call so the APs
+ * just can use the pointer and do not have to scan initrd/builtin firmware
+ * again.
  */
-static struct microcode_intel *__load_ucode_intel(struct ucode_cpu_info *uci)
+static int __init save_microcode_from_cpio(void)
 {
-	static const char *path;
-	struct cpio_data cp;
-	bool use_pa;
-
-	if (IS_ENABLED(CONFIG_X86_32)) {
-		path	  = (const char *)__pa_nodebug(ucode_path);
-		use_pa	  = true;
-	} else {
-		path	  = ucode_path;
-		use_pa	  = false;
-	}
-
-	/* try built-in microcode first */
-	if (!load_builtin_intel_microcode(&cp))
-		cp = find_microcode_in_initrd(path, use_pa);
-
-	if (!(cp.data && cp.size))
-		return NULL;
+	struct microcode_intel *mc;
 
-	intel_cpu_collect_info(uci);
+	if (!ucode_early_pa)
+		return 0;
 
-	return scan_microcode(cp.data, cp.size, uci, false);
+	mc = __va((void *)ucode_early_pa);
+	save_microcode_patch(mc);
+	return 0;
 }
+early_initcall(save_microcode_from_cpio);
 
+/* Load microcode on BSP from CPIO */
 void __init load_ucode_intel_bsp(void)
 {
-	struct microcode_intel *patch;
 	struct ucode_cpu_info uci;
 
-	patch = __load_ucode_intel(&uci);
-	if (!patch)
+	uci.mc = get_ucode_from_cpio(&uci);
+	if (!uci.mc)
 		return;
 
-	uci.mc = patch;
+	if (apply_microcode_early(&uci, true) != UCODE_UPDATED)
+		return;
 
-	apply_microcode_early(&uci, true);
+	if (IS_ENABLED(CONFIG_X86_64)) {
+		/* Store the physical address as KASLR happens after this. */
+		ucode_early_pa = (struct microcode_intel *)__pa_nodebug(uci.mc);
+	} else {
+		struct microcode_intel **uce;
+
+		/* Physical address pointer required for 32-bit */
+		uce = (struct microcode_intel **)__pa_nodebug(&ucode_early_pa);
+		/* uci.mc is the physical address of the microcode blob */
+		*uce = uci.mc;
+	}
 }
 
+/* Load microcode on AP bringup */
 void load_ucode_intel_ap(void)
 {
-	struct microcode_intel *patch, **iup;
 	struct ucode_cpu_info uci;
 
+	/* Must use physical address on 32bit as paging is not yet enabled */
+	uci.mc = ucode_patch_va;
 	if (IS_ENABLED(CONFIG_X86_32))
-		iup = (struct microcode_intel **) __pa_nodebug(&intel_ucode_patch);
-	else
-		iup = &intel_ucode_patch;
-
-	if (!*iup) {
-		patch = __load_ucode_intel(&uci);
-		if (!patch)
-			return;
-
-		*iup = patch;
-	}
-
-	uci.mc = *iup;
+		uci.mc = (struct microcode_intel *)__pa_nodebug(uci.mc);
 
-	apply_microcode_early(&uci, true);
+	if (uci.mc)
+		apply_microcode_early(&uci, true);
 }
 
+/* Reload microcode on resume */
 void reload_ucode_intel(void)
 {
-	struct ucode_cpu_info uci;
-
-	intel_cpu_collect_info(&uci);
+	struct ucode_cpu_info uci = { .mc = ucode_patch_va, };
 
-	uci.mc = intel_ucode_patch;
-	if (!uci.mc)
-		return;
-
-	apply_microcode_early(&uci, false);
+	if (uci.mc)
+		apply_microcode_early(&uci, false);
 }
 
 static int collect_cpu_info(int cpu_num, struct cpu_signature *csig)
@@ -532,7 +513,7 @@ static enum ucode_state apply_microcode_
 	if (WARN_ON(raw_smp_processor_id() != cpu))
 		return UCODE_ERROR;
 
-	mc = intel_ucode_patch;
+	mc = ucode_patch_va;
 	if (!mc) {
 		mc = uci->mc;
 		if (!mc)
@@ -657,11 +638,11 @@ static enum ucode_state read_ucode_intel
 	if (!new_mc)
 		return UCODE_NFOUND;
 
-	vfree(uci->mc);
-	uci->mc = (struct microcode_intel *)new_mc;
-
 	/* Save for CPU hotplug */
-	save_microcode_patch(new_mc, new_mc_size);
+	save_microcode_patch((struct microcode_intel *)new_mc);
+	uci->mc = ucode_patch_va;
+
+	vfree(new_mc);
 
 	pr_debug("CPU%d found a matching microcode update with version 0x%x (current=0x%x)\n",
 		 cpu, cur_rev, uci->cpu_sig.rev);
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -172,13 +172,11 @@ static inline int get_totalsize(void *mc
 
 void load_ucode_intel_bsp(void);
 void load_ucode_intel_ap(void);
-int save_microcode_in_initrd_intel(void);
 void reload_ucode_intel(void);
 struct microcode_ops *init_intel_microcode(void);
 #else /* CONFIG_CPU_SUP_INTEL */
 static inline void load_ucode_intel_bsp(void) { }
 static inline void load_ucode_intel_ap(void) { }
-static inline int save_microcode_in_initrd_intel(void) { return -EINVAL; }
 static inline void reload_ucode_intel(void) { }
 static inline struct microcode_ops *init_intel_microcode(void) { return NULL; }
 #endif  /* !CONFIG_CPU_SUP_INTEL */

