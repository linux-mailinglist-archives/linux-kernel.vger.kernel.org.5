Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63CA79C8D5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjILH6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjILH5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:57:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0574F10C6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:57:50 -0700 (PDT)
Message-ID: <20230912065500.948602532@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694505468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=qRYc4KYBL4S/fSkVnA97uBorXZ9Ql1rG09MbkAiu0bU=;
        b=i0oQhWKQFG9kbw5Sz3ZhXMknYYRF2yauDcHZ5bgwhKNJ1YLDClZiedHHt7FM0o707kCQA7
        OnaZh2vF2j9Hk7XXQrcOsFxYhI+o7/92/F6X6RuSTupy6I/A4oIC1XvyrKhtmHdfl8EQVc
        jVlcb/XUg+HVpHQu0KKUU/392Kh7dfUFYlEh9RJUHBd7Cl77khCjhTBofzZynfT9bN4jTP
        /kLmeZEOJmf22h1CIfjxvC1XeNfEZpzYBfLjb1IPPuT41fffeVzM9U3uvN3bdT/b/ewQM8
        2hzsSt31t7t0MNc4wWlPqnoNTVpt7PlrojU6mtKYFf+bnZKNC8PtCKsm/8NvDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694505468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=qRYc4KYBL4S/fSkVnA97uBorXZ9Ql1rG09MbkAiu0bU=;
        b=mbT2ZyvAchIl0ZD8qnVKaUXZVJdAX/92XnGxZ6IWZQ9zdXlrdf2Y605ECHz5mRz+8D4hHW
        4u+bHBQruGVT2oDQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: [patch V3 03/30] x86/microcode/intel: Rip out mixed stepping support
 for Intel CPUs
References: <20230912065249.695681286@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 12 Sep 2023 09:57:48 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ashok Raj <ashok.raj@intel.com>

Mixed steppings aren't supported on Intel CPUs. Only one patch is required
for the entire system. The caching of micro code blobs which match the
family and model is therefore pointless and in fact it is disfunctional as
CPU hotplug updates use only a single microcode blob, i.e. the one where
*intel_ucode_patch points to.

Remove the microcode cache and make it an AMD local feature.

[ tglx: Save only at the end. Otherwise random microcode ends up in the
  	pointer for early loading ]

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Fix the bogus condition - Borislav
---
 arch/x86/kernel/cpu/microcode/amd.c      |   10 ++
 arch/x86/kernel/cpu/microcode/core.c     |    2 
 arch/x86/kernel/cpu/microcode/intel.c    |  133 +++++--------------------------
 arch/x86/kernel/cpu/microcode/internal.h |   10 --
 4 files changed, 35 insertions(+), 120 deletions(-)
---
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -37,6 +37,16 @@
 
 #include "internal.h"
 
+struct ucode_patch {
+	struct list_head plist;
+	void *data;
+	unsigned int size;
+	u32 patch_id;
+	u16 equiv_cpu;
+};
+
+static LIST_HEAD(microcode_cache);
+
 #define UCODE_MAGIC			0x00414d44
 #define UCODE_EQUIV_CPU_TABLE_TYPE	0x00000000
 #define UCODE_UCODE_TYPE		0x00000001
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -46,8 +46,6 @@ static bool dis_ucode_ldr = true;
 
 bool initrd_gone;
 
-LIST_HEAD(microcode_cache);
-
 /*
  * Synchronization.
  *
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -33,10 +33,10 @@
 static const char ucode_path[] = "kernel/x86/microcode/GenuineIntel.bin";
 
 /* Current microcode patch used in early patching on the APs. */
-static struct microcode_intel *intel_ucode_patch;
+static struct microcode_intel *intel_ucode_patch __read_mostly;
 
 /* last level cache size per core */
-static int llc_size_per_core;
+static int llc_size_per_core __ro_after_init;
 
 /* microcode format is extended from prescott processors */
 struct extended_signature {
@@ -253,74 +253,19 @@ static int has_newer_microcode(void *mc,
 	return intel_find_matching_signature(mc, csig, cpf);
 }
 
-static struct ucode_patch *memdup_patch(void *data, unsigned int size)
+static void save_microcode_patch(void *data, unsigned int size)
 {
-	struct ucode_patch *p;
+	struct microcode_header_intel *p;
 
-	p = kzalloc(sizeof(struct ucode_patch), GFP_KERNEL);
-	if (!p)
-		return NULL;
-
-	p->data = kmemdup(data, size, GFP_KERNEL);
-	if (!p->data) {
-		kfree(p);
-		return NULL;
-	}
-
-	return p;
-}
-
-static void save_microcode_patch(struct ucode_cpu_info *uci, void *data, unsigned int size)
-{
-	struct microcode_header_intel *mc_hdr, *mc_saved_hdr;
-	struct ucode_patch *iter, *tmp, *p = NULL;
-	bool prev_found = false;
-	unsigned int sig, pf;
-
-	mc_hdr = (struct microcode_header_intel *)data;
-
-	list_for_each_entry_safe(iter, tmp, &microcode_cache, plist) {
-		mc_saved_hdr = (struct microcode_header_intel *)iter->data;
-		sig	     = mc_saved_hdr->sig;
-		pf	     = mc_saved_hdr->pf;
-
-		if (intel_find_matching_signature(data, sig, pf)) {
-			prev_found = true;
-
-			if (mc_hdr->rev <= mc_saved_hdr->rev)
-				continue;
-
-			p = memdup_patch(data, size);
-			if (!p)
-				pr_err("Error allocating buffer %p\n", data);
-			else {
-				list_replace(&iter->plist, &p->plist);
-				kfree(iter->data);
-				kfree(iter);
-			}
-		}
-	}
-
-	/*
-	 * There weren't any previous patches found in the list cache; save the
-	 * newly found.
-	 */
-	if (!prev_found) {
-		p = memdup_patch(data, size);
-		if (!p)
-			pr_err("Error allocating buffer for %p\n", data);
-		else
-			list_add_tail(&p->plist, &microcode_cache);
-	}
+	kfree(intel_ucode_patch);
+	intel_ucode_patch = NULL;
 
+	p = kmemdup(data, size, GFP_KERNEL);
 	if (!p)
 		return;
 
-	if (!intel_find_matching_signature(p->data, uci->cpu_sig.sig, uci->cpu_sig.pf))
-		return;
-
 	/* Save for early loading */
-	intel_ucode_patch = p->data;
+	intel_ucode_patch = (struct microcode_intel *)p;
 }
 
 /*
@@ -332,6 +277,7 @@ scan_microcode(void *data, size_t size,
 {
 	struct microcode_header_intel *mc_header;
 	struct microcode_intel *patch = NULL;
+	u32 cur_rev = uci->cpu_sig.rev;
 	unsigned int mc_size;
 
 	while (size) {
@@ -341,8 +287,7 @@ scan_microcode(void *data, size_t size,
 		mc_header = (struct microcode_header_intel *)data;
 
 		mc_size = get_totalsize(mc_header);
-		if (!mc_size ||
-		    mc_size > size ||
+		if (!mc_size || mc_size > size ||
 		    intel_microcode_sanity_check(data, false, MC_HEADER_TYPE_MICROCODE) < 0)
 			break;
 
@@ -354,31 +299,16 @@ scan_microcode(void *data, size_t size,
 			continue;
 		}
 
-		if (save) {
-			save_microcode_patch(uci, data, mc_size);
+		/* BSP scan: Check whether there is newer microcode */
+		if (!save && cur_rev >= mc_header->rev)
 			goto next;
-		}
-
 
-		if (!patch) {
-			if (!has_newer_microcode(data,
-						 uci->cpu_sig.sig,
-						 uci->cpu_sig.pf,
-						 uci->cpu_sig.rev))
-				goto next;
-
-		} else {
-			struct microcode_header_intel *phdr = &patch->hdr;
-
-			if (!has_newer_microcode(data,
-						 phdr->sig,
-						 phdr->pf,
-						 phdr->rev))
-				goto next;
-		}
+		/* Save scan: Check whether there is newer or matching microcode */
+		if (save && cur_rev != mc_header->rev)
+			goto next;
 
-		/* We have a newer patch, save it. */
 		patch = data;
+		cur_rev = mc_header->rev;
 
 next:
 		data += mc_size;
@@ -387,6 +317,9 @@ scan_microcode(void *data, size_t size,
 	if (size)
 		return NULL;
 
+	if (save && patch)
+		save_microcode_patch(patch, mc_size);
+
 	return patch;
 }
 
@@ -528,26 +461,10 @@ void load_ucode_intel_ap(void)
 	apply_microcode_early(&uci, true);
 }
 
-static struct microcode_intel *find_patch(struct ucode_cpu_info *uci)
+/* Accessor for microcode pointer */
+static struct microcode_intel *ucode_get_patch(void)
 {
-	struct microcode_header_intel *phdr;
-	struct ucode_patch *iter, *tmp;
-
-	list_for_each_entry_safe(iter, tmp, &microcode_cache, plist) {
-
-		phdr = (struct microcode_header_intel *)iter->data;
-
-		if (phdr->rev <= uci->cpu_sig.rev)
-			continue;
-
-		if (!intel_find_matching_signature(phdr,
-						   uci->cpu_sig.sig,
-						   uci->cpu_sig.pf))
-			continue;
-
-		return iter->data;
-	}
-	return NULL;
+	return intel_ucode_patch;
 }
 
 void reload_ucode_intel(void)
@@ -557,7 +474,7 @@ void reload_ucode_intel(void)
 
 	intel_cpu_collect_info(&uci);
 
-	p = find_patch(&uci);
+	p = ucode_get_patch();
 	if (!p)
 		return;
 
@@ -601,7 +518,7 @@ static enum ucode_state apply_microcode_
 		return UCODE_ERROR;
 
 	/* Look for a newer patch in our cache: */
-	mc = find_patch(uci);
+	mc = ucode_get_patch();
 	if (!mc) {
 		mc = uci->mc;
 		if (!mc)
@@ -730,7 +647,7 @@ static enum ucode_state generic_load_mic
 	uci->mc = (struct microcode_intel *)new_mc;
 
 	/* Save for CPU hotplug */
-	save_microcode_patch(uci, new_mc, new_mc_size);
+	save_microcode_patch(new_mc, new_mc_size);
 
 	pr_debug("CPU%d found a matching microcode update with version 0x%x (current=0x%x)\n",
 		 cpu, new_rev, uci->cpu_sig.rev);
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -8,16 +8,6 @@
 #include <asm/cpu.h>
 #include <asm/microcode.h>
 
-struct ucode_patch {
-	struct list_head plist;
-	void *data;		/* Intel uses only this one */
-	unsigned int size;
-	u32 patch_id;
-	u16 equiv_cpu;
-};
-
-extern struct list_head microcode_cache;
-
 struct device;
 
 enum ucode_state {

