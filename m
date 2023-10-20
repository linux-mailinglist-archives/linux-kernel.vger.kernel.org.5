Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9DC7D0EF0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377426AbjJTLlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377315AbjJTLl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:41:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961C61BC7;
        Fri, 20 Oct 2023 04:38:30 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:37:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697801879;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vLisiNuRcOdx1PvKIed+7J4nphOseo/dBUJoR9Hc4no=;
        b=37zQa5Ce7DlWFFMyQzkZ3LAFi69u9/glUqsG9rfZI/z/Wx1T0069JoA1NcV0KrSCLg3X2z
        V2BkLAEw27RlYFu+KPkmib4S9SOyTdjbp5jb/j7+2ybCqyoCVlb31OAR/q2o4bMeow3zzy
        QwNdLBZvXr1oFHwJJr9DMvYieqzsF32u8totXnV1TqnS11UKQPa9s1gUkZ3uRjfNrKN9EX
        i3otWT7cLrMszHOTLRZcZbFaAg7Ai8UfpnNESt5LQ5Q0OdMHgn5xV+Yb7JB3zVrNq1TWFL
        mtBV3PEZaxAdikzq+z4EeayLjGFdJb7eJoGueeYwGJtc721Is7ZOTX1y73lMkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697801879;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vLisiNuRcOdx1PvKIed+7J4nphOseo/dBUJoR9Hc4no=;
        b=IbsD6LcSdfGkup1Fv+7BGDnUaWVch33SQScjeIMG1vcmXBPLxJDbF8yfdXfSzgupY9TViS
        lbviAmirBWtt1SAw==
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
Message-ID: <169780187899.3135.10026772228174280984.tip-bot2@tip-bot2>
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

Commit-ID:     afa939303a913c522152617563152e7387ee7b26
Gitweb:        https://git.kernel.org/tip/afa939303a913c522152617563152e7387ee7b26
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 02 Oct 2023 13:59:45 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 19 Oct 2023 14:22:54 +02:00

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
index c587b67..304a7a9 100644
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
@@ -243,7 +242,7 @@ EXPORT_SYMBOL_GPL(intel_microcode_sanity_check);
 
 static void update_ucode_pointer(struct microcode_intel *mc)
 {
-	kfree(ucode_patch_va);
+	kvfree(ucode_patch_va);
 
 	/*
 	 * Save the virtual address for early loading and for eventual free
@@ -254,11 +253,14 @@ static void update_ucode_pointer(struct microcode_intel *mc)
 
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
@@ -523,36 +525,34 @@ static enum ucode_state parse_microcode_blobs(int cpu, struct iov_iter *iter)
 
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
@@ -560,24 +560,26 @@ static enum ucode_state parse_microcode_blobs(int cpu, struct iov_iter *iter)
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
@@ -636,9 +638,9 @@ static enum ucode_state request_microcode_fw(int cpu, struct device *device)
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
 
