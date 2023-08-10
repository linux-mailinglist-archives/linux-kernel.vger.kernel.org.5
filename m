Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DCE77805F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235681AbjHJShw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbjHJShr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:37:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCCD2D4B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:37:39 -0700 (PDT)
Message-ID: <20230810160805.418991257@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691692658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=EOXgyVN41yCAFGpUe+VjUMzw2fD0p6oTWYpHxVlpzMk=;
        b=s2QVDAOxyNGpPQA/aQHUrL225eLnHImX/yChvcPWr7pW1+ntdKyEIjG4CXVopvRkwXJsV9
        vAPVqA9+v2Ld0OaNv8Ue+Scsg2bYAB70ch9GYVVpNig5j0BCatH7gmwtuvrTtOTneGEKAt
        1ncyur9NwBi/LK4F4zanx7MMsQ+X622zIGsj5sxzjYCMNcDJt0+1Z5Pt2I75bXVxYvO6P7
        hvudfxEpDxTWiMDcvFMIxI1a+Vf5N5n+qaANE/qGPdQ6oW98+qTwk13Hi9Yt+LQNN0NJoQ
        EHyQttDEBYkpZSlE/tRrJkL4JfDtt7gVlAqV7jB43EsduUgyokctT5BVbrEZng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691692658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=EOXgyVN41yCAFGpUe+VjUMzw2fD0p6oTWYpHxVlpzMk=;
        b=jUWZ9jzaPOsz2ytlhSj9hda/n/f4KWgdDDtp4pwnz8fN3YhOpdc5y63OC25MIkAx9UTNoU
        GvRThji8HOTd3sCA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: [patch 08/30] x86/microcode/intel: Rip out mixed stepping support for
 Intel CPUs
References: <20230810153317.850017756@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 10 Aug 2023 20:37:38 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Originally-From: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/microcode/amd.c      |   10 +
 arch/x86/kernel/cpu/microcode/core.c     |    2 
 arch/x86/kernel/cpu/microcode/intel.c    |  201 ++++++++-----------------------
 arch/x86/kernel/cpu/microcode/internal.h |   10 -
 4 files changed, 64 insertions(+), 159 deletions(-)
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
 static struct equiv_cpu_table {
 	unsigned int num_entries;
 	struct equiv_cpu_entry *entry;
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
@@ -41,10 +41,10 @@
 static const char ucode_path[] = "kernel/x86/microcode/GenuineIntel.bin";
 
 /* Current microcode patch used in early patching on the APs. */
-static struct microcode_intel *intel_ucode_patch;
+static struct microcode_intel *intel_ucode_patch __read_mostly;
 
 /* last level cache size per core */
-static int llc_size_per_core;
+static int llc_size_per_core __ro_after_init;
 
 int intel_cpu_collect_info(struct ucode_cpu_info *uci)
 {
@@ -233,81 +233,26 @@ static int has_newer_microcode(void *mc,
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
 	/*
 	 * Save for early loading. On 32-bit, that needs to be a physical
 	 * address as the APs are running from physical addresses, before
 	 * paging has been enabled.
 	 */
 	if (IS_ENABLED(CONFIG_X86_32))
-		intel_ucode_patch = (struct microcode_intel *)__pa_nodebug(p->data);
+		intel_ucode_patch = (struct microcode_intel *)__pa_nodebug(p);
 	else
-		intel_ucode_patch = p->data;
+		intel_ucode_patch = (struct microcode_intel *)p;
 }
 
 /*
@@ -319,6 +264,7 @@ scan_microcode(void *data, size_t size,
 {
 	struct microcode_header_intel *mc_header;
 	struct microcode_intel *patch = NULL;
+	u32 cur_rev = uci->cpu_sig.rev;
 	unsigned int mc_size;
 
 	while (size) {
@@ -328,8 +274,7 @@ scan_microcode(void *data, size_t size,
 		mc_header = (struct microcode_header_intel *)data;
 
 		mc_size = get_totalsize(mc_header);
-		if (!mc_size ||
-		    mc_size > size ||
+		if (!mc_size || mc_size > size ||
 		    intel_microcode_sanity_check(data, false, MC_HEADER_TYPE_MICROCODE) < 0)
 			break;
 
@@ -341,31 +286,16 @@ scan_microcode(void *data, size_t size,
 			continue;
 		}
 
-		if (save) {
-			save_microcode_patch(uci, data, mc_size);
+		/* BSP scan: Check whether there is newer microcode */
+		if (save && cur_rev >= mc_header->rev)
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
@@ -374,18 +304,22 @@ scan_microcode(void *data, size_t size,
 	if (size)
 		return NULL;
 
+	if (save && patch)
+		save_microcode_patch(patch, mc_size);
+
 	return patch;
 }
 
 static void show_saved_mc(void)
 {
 #ifdef DEBUG
-	int i = 0, j;
 	unsigned int sig, pf, rev, total_size, data_size, date;
+	struct extended_sigtable *ext_header;
+	struct extended_signature *ext_sig;
 	struct ucode_cpu_info uci;
-	struct ucode_patch *p;
+	int j, ext_sigcount;
 
-	if (list_empty(&microcode_cache)) {
+	if (!intel_ucode_patch) {
 		pr_debug("no microcode data saved.\n");
 		return;
 	}
@@ -397,45 +331,34 @@ static void show_saved_mc(void)
 	rev	= uci.cpu_sig.rev;
 	pr_debug("CPU: sig=0x%x, pf=0x%x, rev=0x%x\n", sig, pf, rev);
 
-	list_for_each_entry(p, &microcode_cache, plist) {
-		struct microcode_header_intel *mc_saved_header;
-		struct extended_sigtable *ext_header;
-		struct extended_signature *ext_sig;
-		int ext_sigcount;
-
-		mc_saved_header = (struct microcode_header_intel *)p->data;
-
-		sig	= mc_saved_header->sig;
-		pf	= mc_saved_header->pf;
-		rev	= mc_saved_header->rev;
-		date	= mc_saved_header->date;
-
-		total_size	= get_totalsize(mc_saved_header);
-		data_size	= intel_microcode_get_datasize(mc_saved_header);
-
-		pr_debug("mc_saved[%d]: sig=0x%x, pf=0x%x, rev=0x%x, total size=0x%x, date = %04x-%02x-%02x\n",
-			 i++, sig, pf, rev, total_size,
-			 date & 0xffff,
-			 date >> 24,
-			 (date >> 16) & 0xff);
-
-		/* Look for ext. headers: */
-		if (total_size <= data_size + MC_HEADER_SIZE)
-			continue;
+	sig	= intel_ucode_patch->hdr.sig;
+	pf	= intel_ucode_patch->hdr.pf;
+	rev	= intel_ucode_patch->hdr.rev;
+	date	= intel_ucode_patch->hdr.date;
+
+	total_size	= get_totalsize(mc_saved_header);
+	data_size	= intel_microcode_get_datasize(mc_saved_header);
+
+	pr_debug("mc_saved: sig=0x%x, pf=0x%x, rev=0x%x, total size=0x%x, date = %04x-%02x-%02x\n",
+		 sig, pf, rev, total_size, date & 0xffff,
+		 date >> 24, (date >> 16) & 0xff);
 
-		ext_header = (void *)mc_saved_header + data_size + MC_HEADER_SIZE;
-		ext_sigcount = ext_header->count;
-		ext_sig = (void *)ext_header + EXT_HEADER_SIZE;
+	/* Look for ext. headers: */
+	if (total_size <= data_size + MC_HEADER_SIZE)
+		return;
 
-		for (j = 0; j < ext_sigcount; j++) {
-			sig = ext_sig->sig;
-			pf = ext_sig->pf;
+	ext_header = (void *)intel_ucode_patch + data_size + MC_HEADER_SIZE;
+	ext_sigcount = ext_header->count;
+	ext_sig = (void *)ext_header + EXT_HEADER_SIZE;
+
+	for (j = 0; j < ext_sigcount; j++) {
+		sig = ext_sig->sig;
+		pf = ext_sig->pf;
 
-			pr_debug("\tExtended[%d]: sig=0x%x, pf=0x%x\n",
-				 j, sig, pf);
+		pr_debug("\tExtended[%d]: sig=0x%x, pf=0x%x\n",
+			 j, sig, pf);
 
-			ext_sig++;
-		}
+		ext_sig++;
 	}
 #endif
 }
@@ -451,7 +374,7 @@ static void save_mc_for_early(struct uco
 
 	mutex_lock(&x86_cpu_microcode_mutex);
 
-	save_microcode_patch(uci, mc, size);
+	save_microcode_patch(mc, size);
 	show_saved_mc();
 
 	mutex_unlock(&x86_cpu_microcode_mutex);
@@ -675,26 +598,10 @@ void load_ucode_intel_ap(void)
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
@@ -704,7 +611,7 @@ void reload_ucode_intel(void)
 
 	intel_cpu_collect_info(&uci);
 
-	p = find_patch(&uci);
+	p = ucode_get_patch();
 	if (!p)
 		return;
 
@@ -748,7 +655,7 @@ static enum ucode_state apply_microcode_
 		return UCODE_ERROR;
 
 	/* Look for a newer patch in our cache: */
-	mc = find_patch(uci);
+	mc = ucode_get_patch();
 	if (!mc) {
 		mc = uci->mc;
 		if (!mc)
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

