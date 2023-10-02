Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AE37B51F1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236896AbjJBMAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236857AbjJBL77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:59:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14801D7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 04:59:47 -0700 (PDT)
Message-ID: <20231002115902.564323243@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696247985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=zPYr0Ydgl25/awrI3nekKS7noAl2zorfqWbbUsVIQD4=;
        b=yn2ol6kBePK92/CVO9nMPwtwkEEsQY3Ykf51fmhVz3y95uid0YFOPj2S5ujFBTuUOYkvzr
        ImvJGNWM4VNKTgwzrpRYneOdQGi1ftAsPMqiCf3Zf2bQsmr0mHPd3hS744XUe8bcV9JpiF
        7BCHv52nmpt+ZYSH/gp27y3l5Xibzi/QCcggbqYflKVmXeFKdymn7vll3a6DyFGZsL3IF+
        3Vme0ebx3s4wtRhYuLNIwaBrBKJ1tTYB75W9wdc4ixb52Q/pYIR9TV5Pyd9uoH+lRsjzf3
        X4k+s8Nu4jUKIb5c1VFOlo3a8gfxeU/+hnobjQVKCTei5wp8SNJKRksmXwQtTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696247985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=zPYr0Ydgl25/awrI3nekKS7noAl2zorfqWbbUsVIQD4=;
        b=AKn2Ahc995IbJqR7HuqRbyxXslTXz1k/SMqOD4rUDC+9032YVQFBzw0+mmU4uxuekS4Xb/
        hLznSzMLPQSqpwCw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V4 09/30] x86/microcode/intel: Switch to kvmalloc()
References: <20231002115506.217091296@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  2 Oct 2023 13:59:45 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Microcode blobs are getting larger and might soon reach the kmalloc()
limit. Switch over kvmalloc().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/kernel/cpu/microcode/intel.c |   48 +++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 23 deletions(-)
---
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -14,7 +14,6 @@
 #include <linux/earlycpio.h>
 #include <linux/firmware.h>
 #include <linux/uaccess.h>
-#include <linux/vmalloc.h>
 #include <linux/initrd.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -243,7 +242,7 @@ EXPORT_SYMBOL_GPL(intel_microcode_sanity
 
 static void update_ucode_pointer(struct microcode_intel *mc)
 {
-	kfree(ucode_patch_va);
+	kvfree(ucode_patch_va);
 
 	/*
 	 * Save the virtual address for early loading and for eventual free
@@ -254,11 +253,14 @@ static void update_ucode_pointer(struct
 
 static void save_microcode_patch(struct microcode_intel *patch)
 {
+	unsigned int size = get_totalsize(&patch->hdr);
 	struct microcode_intel *mc;
 
-	mc = kmemdup(patch, get_totalsize(&patch->hdr), GFP_KERNEL);
+	mc = kvmemdup(patch, size, GFP_KERNEL);
 	if (mc)
 		update_ucode_pointer(mc);
+	else
+		pr_err("Unable to allocate microcode memory size: %u\n", size);
 }
 
 /* Scan blob for microcode matching the boot CPUs family, model, stepping */
@@ -530,36 +532,34 @@ static enum ucode_state parse_microcode_
 
 		if (!copy_from_iter_full(&mc_header, sizeof(mc_header), iter)) {
 			pr_err("error! Truncated or inaccessible header in microcode data file\n");
-			break;
+			goto fail;
 		}
 
 		mc_size = get_totalsize(&mc_header);
 		if (mc_size < sizeof(mc_header)) {
 			pr_err("error! Bad data in microcode data file (totalsize too small)\n");
-			break;
+			goto fail;
 		}
-
 		data_size = mc_size - sizeof(mc_header);
 		if (data_size > iov_iter_count(iter)) {
 			pr_err("error! Bad data in microcode data file (truncated file?)\n");
-			break;
+			goto fail;
 		}
 
 		/* For performance reasons, reuse mc area when possible */
 		if (!mc || mc_size > curr_mc_size) {
-			vfree(mc);
-			mc = vmalloc(mc_size);
+			kvfree(mc);
+			mc = kvmalloc(mc_size, GFP_KERNEL);
 			if (!mc)
-				break;
+				goto fail;
 			curr_mc_size = mc_size;
 		}
 
 		memcpy(mc, &mc_header, sizeof(mc_header));
 		data = mc + sizeof(mc_header);
 		if (!copy_from_iter_full(data, data_size, iter) ||
-		    intel_microcode_sanity_check(mc, true, MC_HEADER_TYPE_MICROCODE) < 0) {
-			break;
-		}
+		    intel_microcode_sanity_check(mc, true, MC_HEADER_TYPE_MICROCODE) < 0)
+			goto fail;
 
 		if (cur_rev >= mc_header.rev)
 			continue;
@@ -567,24 +567,26 @@ static enum ucode_state parse_microcode_
 		if (!intel_find_matching_signature(mc, uci->cpu_sig.sig, uci->cpu_sig.pf))
 			continue;
 
-		vfree(new_mc);
+		kvfree(new_mc);
 		cur_rev = mc_header.rev;
 		new_mc  = mc;
 		mc = NULL;
 	}
 
-	vfree(mc);
-
-	if (iov_iter_count(iter)) {
-		vfree(new_mc);
-		return UCODE_ERROR;
-	}
+	if (iov_iter_count(iter))
+		goto fail;
 
+	kvfree(mc);
 	if (!new_mc)
 		return UCODE_NFOUND;
 
 	ucode_patch_late = (struct microcode_intel *)new_mc;
 	return UCODE_NEW;
+
+fail:
+	kvfree(mc);
+	kvfree(new_mc);
+	return UCODE_ERROR;
 }
 
 static bool is_blacklisted(unsigned int cpu)
@@ -643,9 +645,9 @@ static enum ucode_state request_microcod
 static void finalize_late_load(int result)
 {
 	if (!result)
-		save_microcode_patch(ucode_patch_late);
-
-	vfree(ucode_patch_late);
+		update_ucode_pointer(ucode_patch_late);
+	else
+		kvfree(ucode_patch_late);
 	ucode_patch_late = NULL;
 }
 

