Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A2777A23A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 22:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjHLUBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 16:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjHLUBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 16:01:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9FC199A
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 13:00:57 -0700 (PDT)
Message-ID: <20230812195728.533966298@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691870343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Qr4AlmFeVzuCfitdDfmm4zZT/Jw8jMZI8/qi5AcNsUA=;
        b=D3X5bNrP2YB3LcxBfXKEs4lfrbjgP1QPdxNsQGYohjGSxfB6JEjbWa/NvQZZP/MZ4BleF+
        bAX31f/Vg4zyWQlvY44qJYyvIncdS2KLlUlAFN6UZk4MTKDQjyRfI2a2eMN6FYXKO0sJoW
        h/JiSVIWy3GyTKXRzc0lnw80G/3LKdmR8eLjkFBrMDHDGMlXJ6vkGqIvTkI/VzUIM4SOfB
        iqI68j4m/CCzZZYqccNIDyL160aS8qCUTpeySkGfBBb/RsWRKgEYJW5pQ16fuivClSRygJ
        1aLv5oD62uagvdChEfaRyxQhtw68SiDGjOkUPQjgbrE4li9sP+I8SYyeeuZeNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691870343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Qr4AlmFeVzuCfitdDfmm4zZT/Jw8jMZI8/qi5AcNsUA=;
        b=C7U9GR0+bssJUJTAReizej2oqUWnPXWAT1XKZjFv7/pIR67xHsk7EyIdszqPiXFr27iNgN
        9Su4eZY5nUp7DyAA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V2 17/37] x86/microcode/intel: Unify microcode apply()
 functions
References: <20230812194003.682298127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 12 Aug 2023 21:59:02 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deduplicate the early and late apply() functions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/microcode/intel.c |  106 +++++++++++-----------------------
 1 file changed, 36 insertions(+), 70 deletions(-)

--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -353,12 +353,11 @@ static inline void print_ucode(int old_r
 }
 #endif
 
-static enum ucode_state apply_microcode_early(struct ucode_cpu_info *uci, bool early)
+static enum ucode_state apply_microcode(struct ucode_cpu_info *uci, struct microcode_intel *mc,
+					u32 *cur_rev)
 {
-	struct microcode_intel *mc;
-	u32 rev, old_rev;
+	u32 rev;
 
-	mc = uci->mc;
 	if (!mc)
 		return UCODE_NFOUND;
 
@@ -367,14 +366,12 @@ static enum ucode_state apply_microcode_
 	 * operation - when the other hyperthread has updated the microcode
 	 * already.
 	 */
-	rev = intel_get_microcode_revision();
-	if (rev >= mc->hdr.rev) {
-		uci->cpu_sig.rev = rev;
+	*cur_rev = intel_get_microcode_revision();
+	if (*cur_rev >= mc->hdr.rev) {
+		uci->cpu_sig.rev = *cur_rev;
 		return UCODE_OK;
 	}
 
-	old_rev = rev;
-
 	/*
 	 * Writeback and invalidate caches before updating microcode to avoid
 	 * internal issues depending on what the microcode is updating.
@@ -389,13 +386,23 @@ static enum ucode_state apply_microcode_
 		return UCODE_ERROR;
 
 	uci->cpu_sig.rev = rev;
+	return UCODE_UPDATED;
+}
 
-	if (early)
-		print_ucode(old_rev, uci->cpu_sig.rev, mc->hdr.date);
-	else
-		print_ucode_info(old_rev, uci->cpu_sig.rev, mc->hdr.date);
+static enum ucode_state apply_microcode_early(struct ucode_cpu_info *uci, bool early)
+{
+	struct microcode_intel *mc = uci->mc;
+	enum ucode_state ret;
+	u32 cur_rev;
 
-	return UCODE_UPDATED;
+	ret = apply_microcode(uci, mc, &cur_rev);
+	if (ret == UCODE_UPDATED) {
+		if (early)
+			print_ucode(cur_rev, uci->cpu_sig.rev, mc->hdr.date);
+		else
+			print_ucode_info(cur_rev, uci->cpu_sig.rev, mc->hdr.date);
+	}
+	return ret;
 }
 
 static __init bool load_builtin_intel_microcode(struct cpio_data *cp)
@@ -532,70 +539,29 @@ static int collect_cpu_info(int cpu_num,
 	return 0;
 }
 
-static enum ucode_state apply_microcode_intel(int cpu)
+static enum ucode_state apply_microcode_late(int cpu)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
-	struct cpuinfo_x86 *c = &cpu_data(cpu);
-	bool bsp = c->cpu_index == boot_cpu_data.cpu_index;
-	struct microcode_intel *mc;
+	struct microcode_intel *mc = ucode_patch_late;
 	enum ucode_state ret;
-	static int prev_rev;
-	u32 rev;
-
-	/* We should bind the task to the CPU */
-	if (WARN_ON(raw_smp_processor_id() != cpu))
-		return UCODE_ERROR;
-
-	mc = ucode_patch_late;
-	if (!mc)
-		return UCODE_NFOUND;
+	u32 cur_rev;
 
-	/*
-	 * Save us the MSR write below - which is a particular expensive
-	 * operation - when the other hyperthread has updated the microcode
-	 * already.
-	 */
-	rev = intel_get_microcode_revision();
-	if (rev >= mc->hdr.rev) {
-		ret = UCODE_OK;
-		goto out;
-	}
-
-	/*
-	 * Writeback and invalidate caches before updating microcode to avoid
-	 * internal issues depending on what the microcode is updating.
-	 */
-	native_wbinvd();
-
-	/* write microcode via MSR 0x79 */
-	wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
-
-	rev = intel_get_microcode_revision();
-
-	if (rev != mc->hdr.rev) {
-		pr_err("CPU%d update to revision 0x%x failed\n",
-		       cpu, mc->hdr.rev);
+	if (WARN_ON_ONCE(smp_processor_id() != cpu))
 		return UCODE_ERROR;
-	}
 
-	if (bsp && rev != prev_rev) {
-		pr_info("updated to revision 0x%x, date = %04x-%02x-%02x\n",
-			rev,
-			mc->hdr.date & 0xffff,
-			mc->hdr.date >> 24,
+	ret = apply_microcode(uci, mc, &cur_rev);
+	if (ret != UCODE_UPDATED && ret != UCODE_OK)
+		return ret;
+
+	if (!cpu && uci->cpu_sig.rev != cur_rev) {
+		pr_info("Updated to revision 0x%x, date = %04x-%02x-%02x\n",
+			uci->cpu_sig.rev, mc->hdr.date & 0xffff, mc->hdr.date >> 24,
 			(mc->hdr.date >> 16) & 0xff);
-		prev_rev = rev;
 	}
 
-	ret = UCODE_UPDATED;
-
-out:
-	uci->cpu_sig.rev = rev;
-	c->microcode	 = rev;
-
-	/* Update boot_cpu_data's revision too, if we're on the BSP: */
-	if (bsp)
-		boot_cpu_data.microcode = rev;
+	cpu_data(cpu).microcode	 = uci->cpu_sig.rev;
+	if (!cpu)
+		boot_cpu_data.microcode = uci->cpu_sig.rev;
 
 	return ret;
 }
@@ -742,7 +708,7 @@ static void finalize_late_load(int resul
 static struct microcode_ops microcode_intel_ops = {
 	.request_microcode_fw	= request_microcode_fw,
 	.collect_cpu_info	= collect_cpu_info,
-	.apply_microcode	= apply_microcode_intel,
+	.apply_microcode	= apply_microcode_late,
 	.finalize_late_load	= finalize_late_load,
 };
 

