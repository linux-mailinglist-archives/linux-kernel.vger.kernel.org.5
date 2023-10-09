Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F727BDC0B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376624AbjJIMba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376507AbjJIMaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:30:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423D2113;
        Mon,  9 Oct 2023 05:29:58 -0700 (PDT)
Date:   Mon, 09 Oct 2023 12:29:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696854596;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2djD45p4lJbRMjMBrAuSyV5KIf3VkkCHwifYwvKSw2Q=;
        b=iLZXF27ejYi6Ha/ROLC7Yh5FyEX+tfzVPg+/W45uQ7RG3jjCyfP8iYav/uqiUQCjpUQaLt
        FcS4AzS25vnm9dLnt4Q+qctMGoBP+iUv5JJzR0P3m3QLzbKrNX92KArCb1fsihmDsPISoU
        QLIhQWgNeMYVFp7uQ3X7RmEn8xKsWcnMoF19I5GclLAo0FlYcstJKHqyKFd9DBFy8o5SQ5
        RAbic3qU+lCyEBF0f1RyMBdayuE30sTmqtkuuBy4wxtdqDmiYBKvWkVTVG5WY9V1jWt6eS
        jE8as1pNtDL5XpplbLt4O0fnhEZKVQUDH5yL1EzTea6X+hcJbNl4rD4Ow+Ydkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696854596;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2djD45p4lJbRMjMBrAuSyV5KIf3VkkCHwifYwvKSw2Q=;
        b=Cv0ePf213fY2mRcQq0/OxuWkWT773vjxrGEJwuWmwwvk3BrMoQ+yia9tThHvl52AsM2zeu
        JYqxn4KdUhfHQCAg==
From:   "tip-bot2 for Ashok Raj" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/intel: Rip out mixed stepping
 support for Intel CPUs
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ashok Raj <ashok.raj@intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231002115902.213619654@linutronix.de>
References: <20231002115902.213619654@linutronix.de>
MIME-Version: 1.0
Message-ID: <169685459583.3135.3728432268928893816.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     b06a37b1970f580c05b79465b37913093b62ce0d
Gitweb:        https://git.kernel.org/tip/b06a37b1970f580c05b79465b37913093b62ce0d
Author:        Ashok Raj <ashok.raj@intel.com>
AuthorDate:    Mon, 02 Oct 2023 13:59:38 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 02 Oct 2023 18:28:55 +02:00

x86/microcode/intel: Rip out mixed stepping support for Intel CPUs

Mixed steppings aren't supported on Intel CPUs. Only one microcode patch
is required for the entire system. The caching of microcode blobs which
match the family and model is therefore pointless and in fact is
dysfunctional as CPU hotplug updates use only a single microcode blob,
i.e. the one where *intel_ucode_patch points to.

Remove the microcode cache and make it an AMD local feature.

  [ tglx: Save only at the end. Otherwise random microcode ends up in the
  	  pointer for early loading ]

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231002115902.213619654@linutronix.de
---
 arch/x86/kernel/cpu/microcode/amd.c      |  10 ++-
 arch/x86/kernel/cpu/microcode/core.c     |   2 +-
 arch/x86/kernel/cpu/microcode/intel.c    | 133 ++++------------------
 arch/x86/kernel/cpu/microcode/internal.h |  10 +--
 4 files changed, 35 insertions(+), 120 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index ccca39f..0f15e82 100644
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
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index f76c2c1..4366a33 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -46,8 +46,6 @@ static bool dis_ucode_ldr = true;
 
 bool initrd_gone;
 
-LIST_HEAD(microcode_cache);
-
 /*
  * Synchronization.
  *
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 24a5c8b..1f45f5c 100644
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
@@ -253,74 +253,19 @@ static int has_newer_microcode(void *mc, unsigned int csig, int cpf, int new_rev
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
@@ -332,6 +277,7 @@ scan_microcode(void *data, size_t size, struct ucode_cpu_info *uci, bool save)
 {
 	struct microcode_header_intel *mc_header;
 	struct microcode_intel *patch = NULL;
+	u32 cur_rev = uci->cpu_sig.rev;
 	unsigned int mc_size;
 
 	while (size) {
@@ -341,8 +287,7 @@ scan_microcode(void *data, size_t size, struct ucode_cpu_info *uci, bool save)
 		mc_header = (struct microcode_header_intel *)data;
 
 		mc_size = get_totalsize(mc_header);
-		if (!mc_size ||
-		    mc_size > size ||
+		if (!mc_size || mc_size > size ||
 		    intel_microcode_sanity_check(data, false, MC_HEADER_TYPE_MICROCODE) < 0)
 			break;
 
@@ -354,31 +299,16 @@ scan_microcode(void *data, size_t size, struct ucode_cpu_info *uci, bool save)
 			continue;
 		}
 
-		if (save) {
-			save_microcode_patch(uci, data, mc_size);
+		/* BSP scan: Check whether there is newer microcode */
+		if (!save && cur_rev >= mc_header->rev)
 			goto next;
-		}
-
-
-		if (!patch) {
-			if (!has_newer_microcode(data,
-						 uci->cpu_sig.sig,
-						 uci->cpu_sig.pf,
-						 uci->cpu_sig.rev))
-				goto next;
 
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
@@ -387,6 +317,9 @@ next:
 	if (size)
 		return NULL;
 
+	if (save && patch)
+		save_microcode_patch(patch, mc_size);
+
 	return patch;
 }
 
@@ -528,26 +461,10 @@ void load_ucode_intel_ap(void)
 	apply_microcode_early(&uci);
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
 
@@ -601,7 +518,7 @@ static enum ucode_state apply_microcode_intel(int cpu)
 		return UCODE_ERROR;
 
 	/* Look for a newer patch in our cache: */
-	mc = find_patch(uci);
+	mc = ucode_get_patch();
 	if (!mc) {
 		mc = uci->mc;
 		if (!mc)
@@ -730,7 +647,7 @@ static enum ucode_state generic_load_microcode(int cpu, struct iov_iter *iter)
 	uci->mc = (struct microcode_intel *)new_mc;
 
 	/* Save for CPU hotplug */
-	save_microcode_patch(uci, new_mc, new_mc_size);
+	save_microcode_patch(new_mc, new_mc_size);
 
 	pr_debug("CPU%d found a matching microcode update with version 0x%x (current=0x%x)\n",
 		 cpu, new_rev, uci->cpu_sig.rev);
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
index 8843c32..6001da4 100644
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
