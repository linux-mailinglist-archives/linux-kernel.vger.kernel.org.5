Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07C97CCF28
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344364AbjJQVYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235019AbjJQVYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:24:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70629182
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:23:41 -0700 (PDT)
Message-ID: <20231017211722.629085215@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697577819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=o4wPtZ0zuuS0mqtblAnsQ5W8blhZ2Q+8lWeI4fE1kYo=;
        b=I5fGmp9z3/TtZpdfpanwYaRUTXdSbc7u5IlUrUCPQ4R33joG6eNGSGEaObZEYYcfl0L9Qk
        eGffknl+DunzLcf0+6HHyqcB4Y3oEmwNMzGTXQUsDn1LvXesjZRFlTIqgM0aCZBP17BM/I
        oLaqj9E0xouX2rBhNVhsuK7e07Q3byU9TR3uz0QiPSq4X3G7ckmIKYDFbqG1FIEWRBB0oH
        a7HYtEWi3nzpQpuoFQNSoHuf0ywEu06Wh0Xy8LmBis+3AVaf4vKzxXtRFjirNToRfyq5t6
        6yf+o6rhEwXLl/joZpRW9TopM7LEdUBX0Z+y32YVxbqY2dgpPtHZGRrfXBycIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697577819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=o4wPtZ0zuuS0mqtblAnsQ5W8blhZ2Q+8lWeI4fE1kYo=;
        b=/0LbkxfUvKx9e2t9sP/rqclPBdHX3ZvABakJwB7ZzBwhgDEKDGjQU6hc/h2ej4Fx1d8aXM
        /GXZb7dXwHJoyjAA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>
Subject: [patch V5 12/39] x86/microcode/intel: Simplify early loading
References: <20231017200758.877560658@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 17 Oct 2023 23:23:39 +0200 (CEST)
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
    scans again to duplicate and saves the microcode before initrd goes
    away.

    That's a pointless exercise because this can be simply done before
    bringing up the APs when the memory allocator is up and running.

 - Saving the microcode from within the scan loop is completely
   non-obvious and a left over of the microcode cache.

   This can be done at the call site now which makes it obvious.

Rework the code so that only the BSP scans the builtin/initrd microcode
during early boot and then rescans to save it away in an early initcall for
later use.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V5: Rescan in save_microcode() to handle relocated initrds correctly
---
 arch/x86/kernel/cpu/microcode/core.c     |    6 -
 arch/x86/kernel/cpu/microcode/intel.c    |  149 ++++++++++++-------------------
 arch/x86/kernel/cpu/microcode/internal.h |    3 
 3 files changed, 63 insertions(+), 95 deletions(-)
---
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -42,7 +42,7 @@
 #define DRIVER_VERSION	"2.2"
 
 static struct microcode_ops	*microcode_ops;
-static bool dis_ucode_ldr = true;
+bool dis_ucode_ldr = true;
 
 bool initrd_gone;
 
@@ -186,10 +186,6 @@ static int __init save_microcode_in_init
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
@@ -240,24 +240,29 @@ int intel_microcode_sanity_check(void *m
 }
 EXPORT_SYMBOL_GPL(intel_microcode_sanity_check);
 
-static void save_microcode_patch(void *data, unsigned int size)
+static void update_ucode_pointer(struct microcode_intel *mc)
 {
-	struct microcode_header_intel *p;
+	kfree(ucode_patch_va);
 
-	kfree(intel_ucode_patch);
-	intel_ucode_patch = NULL;
+	/*
+	 * Save the virtual address for early loading and for eventual free
+	 * on late loading.
+	 */
+	ucode_patch_va = mc;
+}
 
-	p = kmemdup(data, size, GFP_KERNEL);
-	if (!p)
-		return;
+static void save_microcode_patch(struct microcode_intel *patch)
+{
+	struct microcode_intel *mc;
 
-	/* Save for early loading */
-	intel_ucode_patch = (struct microcode_intel *)p;
+	mc = kmemdup(patch, get_totalsize(&patch->hdr), GFP_KERNEL);
+	if (mc)
+		update_ucode_pointer(mc);
 }
 
-/* Scan CPIO for microcode matching the boot CPU's family, model, stepping */
-static struct microcode_intel *scan_microcode(void *data, size_t size,
-					      struct ucode_cpu_info *uci, bool save)
+/* Scan blob for microcode matching the boot CPUs family, model, stepping */
+static __init struct microcode_intel *scan_microcode(void *data, size_t size,
+						     struct ucode_cpu_info *uci)
 {
 	struct microcode_header_intel *mc_header;
 	struct microcode_intel *patch = NULL;
@@ -275,35 +280,25 @@ static struct microcode_intel *scan_micr
 		if (!intel_find_matching_signature(data, uci->cpu_sig.sig, uci->cpu_sig.pf))
 			continue;
 
-		/* BSP scan: Check whether there is newer microcode */
-		if (!save && cur_rev >= mc_header->rev)
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
 
-static int apply_microcode_early(struct ucode_cpu_info *uci)
+static enum ucode_state apply_microcode_early(struct ucode_cpu_info *uci)
 {
 	struct microcode_intel *mc;
 	u32 rev, old_rev, date;
 
 	mc = uci->mc;
 	if (!mc)
-		return 0;
+		return UCODE_NFOUND;
 
 	/*
 	 * Save us the MSR write below - which is a particular expensive
@@ -329,17 +324,17 @@ static int apply_microcode_early(struct
 
 	rev = intel_get_microcode_revision();
 	if (rev != mc->hdr.rev)
-		return -1;
+		return UCODE_ERROR;
 
 	uci->cpu_sig.rev = rev;
 
 	date = mc->hdr.date;
 	pr_info_once("updated early: 0x%x -> 0x%x, date = %04x-%02x-%02x\n",
 		     old_rev, rev, date & 0xffff, date >> 24, (date >> 16) & 0xff);
-	return 0;
+	return UCODE_UPDATED;
 }
 
-static bool load_builtin_intel_microcode(struct cpio_data *cp)
+static __init bool load_builtin_intel_microcode(struct cpio_data *cp)
 {
 	unsigned int eax = 1, ebx, ecx = 0, edx;
 	struct firmware fw;
@@ -361,89 +356,68 @@ static bool load_builtin_intel_microcode
 	return false;
 }
 
-int __init save_microcode_in_initrd_intel(void)
+static __init struct microcode_intel *get_microcode_blob(struct ucode_cpu_info *uci)
 {
-	struct ucode_cpu_info uci;
 	struct cpio_data cp;
 
-	/*
-	 * initrd is going away, clear patch ptr. We will scan the microcode one
-	 * last time before jettisoning and save a patch, if found. Then we will
-	 * update that pointer too, with a stable patch address to use when
-	 * resuming the cores.
-	 */
-	intel_ucode_patch = NULL;
-
 	if (!load_builtin_intel_microcode(&cp))
 		cp = find_microcode_in_initrd(ucode_path);
 
 	if (!(cp.data && cp.size))
-		return 0;
+		return NULL;
 
-	intel_cpu_collect_info(&uci);
+	intel_cpu_collect_info(uci);
 
-	scan_microcode(cp.data, cp.size, &uci, true);
-	return 0;
+	return scan_microcode(cp.data, cp.size, uci);
 }
 
 /*
- * @res_patch, output: a pointer to the patch we found.
+ * Invoked from an early init call to save the microcode blob which was
+ * selected during early boot when mm was not usable. The microcode must be
+ * saved because initrd is going away. It's an early init call so the APs
+ * just can use the pointer and do not have to scan initrd/builtin firmware
+ * again.
  */
-static struct microcode_intel *__load_ucode_intel(struct ucode_cpu_info *uci)
+static int __init save_builtin_microcode(void)
 {
-	struct cpio_data cp;
-
-	/* try built-in microcode first */
-	if (!load_builtin_intel_microcode(&cp))
-		cp = find_microcode_in_initrd(ucode_path);
-
-	if (!(cp.data && cp.size))
-		return NULL;
+	struct ucode_cpu_info uci;
 
-	intel_cpu_collect_info(uci);
+	if (dis_ucode_ldr || boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+		return 0;
 
-	return scan_microcode(cp.data, cp.size, uci, false);
+	uci.mc = get_microcode_blob(&uci);
+	if (uci.mc)
+		save_microcode_patch(uci.mc);
+	return 0;
 }
+early_initcall(save_builtin_microcode);
 
+/* Load microcode on BSP from initrd or builtin blobs */
 void __init load_ucode_intel_bsp(void)
 {
-	struct microcode_intel *patch;
 	struct ucode_cpu_info uci;
 
-	patch = __load_ucode_intel(&uci);
-	if (!patch)
-		return;
-
-	uci.mc = patch;
-
-	apply_microcode_early(&uci);
+	uci.mc = get_microcode_blob(&uci);
+	if (uci.mc)
+		apply_microcode_early(&uci);
 }
 
 void load_ucode_intel_ap(void)
 {
 	struct ucode_cpu_info uci;
 
-	if (!intel_ucode_patch) {
-		intel_ucode_patch = __load_ucode_intel(&uci);
-		if (!intel_ucode_patch)
-			return;
-	}
-
-	uci.mc = intel_ucode_patch;
-	apply_microcode_early(&uci);
+	uci.mc = ucode_patch_va;
+	if (uci.mc)
+		apply_microcode_early(&uci);
 }
 
+/* Reload microcode on resume */
 void reload_ucode_intel(void)
 {
-	struct ucode_cpu_info uci;
-
-	intel_cpu_collect_info(&uci);
-
-	uci.mc = intel_ucode_patch;
-	if (!uci.mc)
-		return;
+	struct ucode_cpu_info uci = { .mc = ucode_patch_va, };
 
-	apply_microcode_early(&uci);
+	if (uci.mc)
+		apply_microcode_early(&uci);
 }
 
 static int collect_cpu_info(int cpu_num, struct cpu_signature *csig)
@@ -480,7 +454,7 @@ static enum ucode_state apply_microcode_
 	if (WARN_ON(raw_smp_processor_id() != cpu))
 		return UCODE_ERROR;
 
-	mc = intel_ucode_patch;
+	mc = ucode_patch_va;
 	if (!mc) {
 		mc = uci->mc;
 		if (!mc)
@@ -540,8 +514,8 @@ static enum ucode_state apply_microcode_
 static enum ucode_state parse_microcode_blobs(int cpu, struct iov_iter *iter)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
-	unsigned int curr_mc_size = 0, new_mc_size = 0;
 	int cur_rev = uci->cpu_sig.rev;
+	unsigned int curr_mc_size = 0;
 	u8 *new_mc = NULL, *mc = NULL;
 
 	while (iov_iter_count(iter)) {
@@ -591,7 +565,6 @@ static enum ucode_state parse_microcode_
 		vfree(new_mc);
 		cur_rev = mc_header.rev;
 		new_mc  = mc;
-		new_mc_size = mc_size;
 		mc = NULL;
 	}
 
@@ -605,11 +578,11 @@ static enum ucode_state parse_microcode_
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
@@ -84,6 +84,7 @@ static inline unsigned int x86_cpuid_fam
 	return x86_family(eax);
 }
 
+extern bool dis_ucode_ldr;
 extern bool initrd_gone;
 
 #ifdef CONFIG_CPU_SUP_AMD
@@ -107,13 +108,11 @@ static inline void exit_amd_microcode(vo
 #ifdef CONFIG_CPU_SUP_INTEL
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

