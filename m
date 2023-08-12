Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79BC77A23F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 22:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjHLUBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 16:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjHLUBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 16:01:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39382D79
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 13:00:49 -0700 (PDT)
Message-ID: <20230812195728.069849788@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691870331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=+LnxIbJSjtZlbYPhhRKT8XWYvPxcIXTNXgcJ6FnPbbM=;
        b=wImgZvYW+RCR1dnDUO7eZWHE2DLP4cQhfOnF7k0UMmMN/5wuwfkhSIZcWVuB/hn6CIKQDx
        930XvbU4zTvV4Jk6bZc8eJKHs74AfAEfvN6g1sAxhH5uaFviw6EdFCmQW3VRgxFV1u9mor
        BDR8A2H+qridCSGYHobKBaIuycn+Oss4y7mYhdfrO1v8FrvE0ynZ6B10g0uEODVzqiKy08
        e23cRolTDf61hOxBFL3JamTHLtJIXP5stDE57kSBR3KZCCblLJFBbOEzkS3Aopcv1kGJDA
        gClGO9sOPG0SeBTYWHvqckTsQjFX7BbjUcHVGP9vaFXvwp3D2N7JRhn8kBDo0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691870331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=+LnxIbJSjtZlbYPhhRKT8XWYvPxcIXTNXgcJ6FnPbbM=;
        b=LskouPJt7WBGAIH/Jb4BEbcZtUi5KSNOgpZ4VmG84w4Yaaw9EX4xYIwpW7f23WDCWlcHb+
        1Rhx/7DZA39X2SAQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V2 09/37] x86/microcode/intel: Remove pointless mutex
References: <20230812194003.682298127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 12 Aug 2023 21:58:50 +0200 (CEST)
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

There is no concurreny.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/kernel/cpu/microcode/intel.c |   24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)
---
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -397,22 +397,6 @@ scan_microcode(void *data, size_t size,
 	return patch;
 }
 
-/*
- * Save this microcode patch. It will be loaded early when a CPU is
- * hot-added or resumes.
- */
-static void save_mc_for_early(struct ucode_cpu_info *uci, u8 *mc, unsigned int size)
-{
-	/* Synchronization during CPU hotplug. */
-	static DEFINE_MUTEX(x86_cpu_microcode_mutex);
-
-	mutex_lock(&x86_cpu_microcode_mutex);
-
-	save_microcode_patch(uci, mc, size);
-
-	mutex_unlock(&x86_cpu_microcode_mutex);
-}
-
 static bool load_builtin_intel_microcode(struct cpio_data *cp)
 {
 	unsigned int eax = 1, ebx, ecx = 0, edx;
@@ -829,12 +813,8 @@ static enum ucode_state generic_load_mic
 	vfree(uci->mc);
 	uci->mc = (struct microcode_intel *)new_mc;
 
-	/*
-	 * If early loading microcode is supported, save this mc into
-	 * permanent memory. So it will be loaded early when a CPU is hot added
-	 * or resumes.
-	 */
-	save_mc_for_early(uci, new_mc, new_mc_size);
+	/* Save for CPU hotplug */
+	save_microcode_patch(uci, new_mc, new_mc_size);
 
 	pr_debug("CPU%d found a matching microcode update with version 0x%x (current=0x%x)\n",
 		 cpu, new_rev, uci->cpu_sig.rev);

