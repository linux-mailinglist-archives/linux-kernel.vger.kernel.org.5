Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48BA77A23C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 22:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjHLUBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 16:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjHLUBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 16:01:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18615359D
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 13:00:54 -0700 (PDT)
Message-ID: <20230812195728.475622148@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691870341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=hIX18dJsViRnFjmjnZoQ/63urhaUc4z36vhR8c6ivo4=;
        b=WQV3BgtdOkoLTVcAG/nDZKVh7Rx9IKoBhWvB5SfAS+bJch1XpGSqKX6nrZJAv/AOfWz9Go
        4w73Z9sqG3PoQPpL5u0PJ7vYB2QYfNYM8WIY3Vt3o88ojfgfbbJQ3J1+ezaxPqSReKCxsy
        4IJRT7tKYzt9hTyWpMLYIwNIlGAHe9sTqN6Rp8Flt9wm9/DMNhhNT4KjCoUceYVTDgYSyz
        m7yScmc344zxgL/AJSmClNeRMETwyhJt1vs0sPXSHNOXrisXLBR+cazHu7YpgevXubRo+Q
        84W8KGgzK7MrKzRyOXbDh7FbjewlWMzxJoV5FN+LYG7UNEibLfDe5afalMnLHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691870341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=hIX18dJsViRnFjmjnZoQ/63urhaUc4z36vhR8c6ivo4=;
        b=9jBVKS1KlN1sHwjGgPp/P84e8xNLLGKKkkAlRI1uRJRkyBQMAZl1xFrDLtOeSkmRMo9Qjs
        nea+YAmye3C8LhDQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V2 16/37] x86/microcode/intel: Switch to kvmalloc()
References: <20230812194003.682298127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 12 Aug 2023 21:59:01 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Microcode blobs are getting larger and might soon reach the kmalloc()
limit. Switch over kvmalloc().

32-bit has to stay with kmalloc() as it needs physically contiguous memory
because the early loading runs before paging is enabled, so there is a
sanity check added to ensure that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/kernel/cpu/microcode/intel.c |   55 +++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 23 deletions(-)
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
 	 * Save the virtual address for early loading on 64bit
@@ -257,13 +256,18 @@ static void update_ucode_pointer(struct
 
 static void save_microcode_patch(struct microcode_intel *patch)
 {
-	struct microcode_intel *mc;
+	unsigned int size = get_totalsize(&patch->hdr);
+	struct microcode_intel *mc = NULL;
+
+	if (IS_ENABLED(CONFIG_X86_64))
+		mc = kvmemdup(patch, size, GFP_KERNEL);
+	else
+		mc = kmemdup(patch, size, GFP_KERNEL);
 
-	mc = kmemdup(patch, get_totalsize(&patch->hdr), GFP_KERNEL);
 	if (mc)
 		update_ucode_pointer(mc);
 	else
-		pr_err("Unable to allocate microcode memory\n");
+		pr_err("Unable to allocate microcode memory size: %u\n", size);
 }
 
 /* Scan CPIO for microcode matching the boot CPUs family, model, stepping */
@@ -610,36 +614,34 @@ static enum ucode_state read_ucode_intel
 
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
@@ -647,25 +649,32 @@ static enum ucode_state read_ucode_intel
 		if (!intel_find_matching_signature(mc, uci->cpu_sig.sig, uci->cpu_sig.pf))
 			continue;
 
-		vfree(new_mc);
+		kvfree(new_mc);
 		cur_rev = mc_header.rev;
 		new_mc  = mc;
 		new_mc_size = mc_size;
 		mc = NULL;
 	}
 
-	vfree(mc);
+	if (iov_iter_count(iter))
+		goto fail;
 
-	if (iov_iter_count(iter)) {
-		vfree(new_mc);
-		return UCODE_ERROR;
+	if (IS_ENABLED(CONFIG_X86_32) && new_mc && is_vmalloc_addr(new_mc)) {
+		pr_err("Microcode too large for 32-bit mode\n");
+		goto fail;
 	}
 
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
@@ -724,9 +733,9 @@ static enum ucode_state request_microcod
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
 

