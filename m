Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3F97D51AD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343508AbjJXNXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbjJXNWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:22:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904B719BD;
        Tue, 24 Oct 2023 06:21:09 -0700 (PDT)
Date:   Tue, 24 Oct 2023 13:21:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698153667;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X1sHc8NoUJDAxlYGlldsKXRT9mT7M2lewUAxiWlXmWU=;
        b=VVPxXL5Q2GX2EamTOIP8hiZs9uCKEWhHVHDl4xsaR3DnZhJnxXYGN2kRL9PihYwkftM830
        fOz5ma7sG+ASbfrrykZUp1vw8HTK4pVqakTO60Ylf5UOpkw+W1SbmJP/wKpNJ3ZQywm8gp
        O+3iUJ5wByGn7vcotjqI+mGlOe+K+nmn3MsHW9UXpcGJm+B7/ecQDmCQHcT5LFBXo9SGnD
        hn288n58KbFI8BmhqBhUTLge7rvRy5pZbExctYp09Q+K5SeAsxYJsCspm2vZavpMCw0Aao
        wdut9DwamSL+QTPlRXteKrHqX1x0gUQUuOGNuIXy3p4+OTbyp7Y9lWJVp0EDlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698153667;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X1sHc8NoUJDAxlYGlldsKXRT9mT7M2lewUAxiWlXmWU=;
        b=Y/ZCfcwJPDA8ZNFqVNOFrxB3bwvObDqlG3OTEJRpHdip2nfulINAv/pyeydllhESS4/LFO
        l8lWgvI4S2WGtBDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/intel: Switch to kvmalloc()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231002115902.564323243@linutronix.de>
References: <20231002115902.564323243@linutronix.de>
MIME-Version: 1.0
Message-ID: <169815366707.3135.12245818937202906457.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     f24f204405f9875bc539c6e88553fd5ac913c867
Gitweb:        https://git.kernel.org/tip/f24f204405f9875bc539c6e88553fd5ac913c867
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 02 Oct 2023 13:59:45 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 24 Oct 2023 15:05:53 +02:00

x86/microcode/intel: Switch to kvmalloc()

Microcode blobs are getting larger and might soon reach the kmalloc()
limit. Switch over kvmalloc().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231002115902.564323243@linutronix.de
---
 arch/x86/kernel/cpu/microcode/intel.c | 48 +++++++++++++-------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 076133b..dd2d3fd 100644
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
@@ -245,7 +244,7 @@ EXPORT_SYMBOL_GPL(intel_microcode_sanity_check);
 
 static void update_ucode_pointer(struct microcode_intel *mc)
 {
-	kfree(ucode_patch_va);
+	kvfree(ucode_patch_va);
 
 	/*
 	 * Save the virtual address for early loading and for eventual free
@@ -256,11 +255,14 @@ static void update_ucode_pointer(struct microcode_intel *mc)
 
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
@@ -539,36 +541,34 @@ static enum ucode_state parse_microcode_blobs(int cpu, struct iov_iter *iter)
 
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
@@ -576,24 +576,26 @@ static enum ucode_state parse_microcode_blobs(int cpu, struct iov_iter *iter)
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
@@ -652,9 +654,9 @@ static enum ucode_state request_microcode_fw(int cpu, struct device *device)
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
 
