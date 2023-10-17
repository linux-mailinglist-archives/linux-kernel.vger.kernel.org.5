Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AB07CCF29
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344254AbjJQVYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344105AbjJQVYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:24:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82361B8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:23:45 -0700 (PDT)
Message-ID: <20231017211722.739983189@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697577823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=VA3GjOwSQakWu1mfAzsmut9V6c1bKPim6FgZiDMaO9A=;
        b=wL6Uez1dTKOYzx6VLXpSfhhaXgs1ie2maErFqXjfHjrh391LQuEhtrlQlVZTaLh9WwHRCM
        93cV0+UWr0GZkBRg0Fu4lOg1r7861vH6ffW8OHutpCrNNSQoZ4v62qF+On367/6XQuwEi6
        Rxoc1eHMMuGSKCTPKGbbKPYdwGdMOTDO3S+aEQ/9Aw6swylYcpdjTR6m5kJOmQCIisi8wj
        ehK4z1YKfRMQiZChLNFi2OKOZIOALa6SaMs9BTjYHTEPaFFPIztv+6ZWtAlZHIYo7unZFd
        Qj6ihRJjSxeJ8YF5bmZv2U/EkRFxo+Gbh6d6cizug3NsiDdW7V6OpicHTqRo/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697577823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=VA3GjOwSQakWu1mfAzsmut9V6c1bKPim6FgZiDMaO9A=;
        b=Zggs9U2uUhKbekNtn746/6GRIfgG6oAB26+VB9l644K9W+2HVIQ63SXIziK/1ehKeb9RWV
        lCG+IerfpT2R0xDw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>
Subject: [patch V5 14/39] x86/microcode/intel: Switch to kvmalloc()
References: <20231017200758.877560658@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 17 Oct 2023 23:23:42 +0200 (CEST)
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
@@ -523,36 +525,34 @@ static enum ucode_state parse_microcode_
 
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
@@ -560,24 +560,26 @@ static enum ucode_state parse_microcode_
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
@@ -636,9 +638,9 @@ static enum ucode_state request_microcod
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
 

