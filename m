Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A197CCF2B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344334AbjJQVYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344286AbjJQVYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:24:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FC2D4F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:23:46 -0700 (PDT)
Message-ID: <20231017211722.795508212@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697577824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=FE0DpDNtp2Ico6oBJ9Mij9/yYPkvhH9gw/gnV/1rNSg=;
        b=UuNXvB/OaGXH1Srp8kcVCcxiwIzEPMkxKx6knVJ3WURLCoZrLuhU5BRAbX8m5tDl8GPj4c
        B33a5hfF4r1n5QhWvqbOXtDF8RLvDv24T2IEqQIgaMEZv1svsJ2Wd9rTyXht5/vORun9eK
        5y12TBLBZx66Ks65H8Z6YeWNv+r5AyHWdILIQ1U7Ph8IarsYPdPtkSjo4TLKdQeXhoELpH
        1sMRCcfatNK+ngNp+lqI8rIVZabxOhLzCZdpAeavbSQ7GUV/e4gEDB14ZPLespMax7DFCw
        Nvrq4ssFM3VIPR6mdwMP2s4bJdjTz+3v6ZVMNJ87S6lTBYqEABC8nkKUoePZ2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697577824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=FE0DpDNtp2Ico6oBJ9Mij9/yYPkvhH9gw/gnV/1rNSg=;
        b=DoaEDhVSp6lJyl9VlqMUt+dRNgi/qOdbv7Vvm14bgJE+J35SxuttVnRUzTcaW3WSFiMCp3
        fnVfhffxdC0TwPDw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>
Subject: [patch V5 15/39] x86/microcode/intel: Unify microcode apply()
 functions
References: <20231017200758.877560658@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 17 Oct 2023 23:23:44 +0200 (CEST)
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Deduplicate the early and late apply() functions.

[ bp: Rename the function which does the actual application to
      __apply_microcode() to differentiate it from
      microcode_ops.apply_microcode(). ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/kernel/cpu/microcode/intel.c |  106 +++++++++++-----------------------
 1 file changed, 37 insertions(+), 69 deletions(-)
---
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -294,12 +294,12 @@ static __init struct microcode_intel *sc
 	return size ? NULL : patch;
 }
 
-static enum ucode_state apply_microcode_early(struct ucode_cpu_info *uci)
+static enum ucode_state __apply_microcode(struct ucode_cpu_info *uci,
+					  struct microcode_intel *mc,
+					  u32 *cur_rev)
 {
-	struct microcode_intel *mc;
-	u32 rev, old_rev, date;
+	u32 rev;
 
-	mc = uci->mc;
 	if (!mc)
 		return UCODE_NFOUND;
 
@@ -308,14 +308,12 @@ static enum ucode_state apply_microcode_
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
@@ -330,13 +328,24 @@ static enum ucode_state apply_microcode_
 		return UCODE_ERROR;
 
 	uci->cpu_sig.rev = rev;
-
-	date = mc->hdr.date;
-	pr_info_once("updated early: 0x%x -> 0x%x, date = %04x-%02x-%02x\n",
-		     old_rev, rev, date & 0xffff, date >> 24, (date >> 16) & 0xff);
 	return UCODE_UPDATED;
 }
 
+static enum ucode_state apply_microcode_early(struct ucode_cpu_info *uci)
+{
+	struct microcode_intel *mc = uci->mc;
+	enum ucode_state ret;
+	u32 cur_rev, date;
+
+	ret = __apply_microcode(uci, mc, &cur_rev);
+	if (ret == UCODE_UPDATED) {
+		date = mc->hdr.date;
+		pr_info_once("updated early: 0x%x -> 0x%x, date = %04x-%02x-%02x\n",
+			     cur_rev, mc->hdr.rev, date & 0xffff, date >> 24, (date >> 16) & 0xff);
+	}
+	return ret;
+}
+
 static __init bool load_builtin_intel_microcode(struct cpio_data *cp)
 {
 	unsigned int eax = 1, ebx, ecx = 0, edx;
@@ -443,70 +452,29 @@ static int collect_cpu_info(int cpu_num,
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
-
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
+	u32 cur_rev;
 
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
+	ret = __apply_microcode(uci, mc, &cur_rev);
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
@@ -647,7 +615,7 @@ static void finalize_late_load(int resul
 static struct microcode_ops microcode_intel_ops = {
 	.request_microcode_fw	= request_microcode_fw,
 	.collect_cpu_info	= collect_cpu_info,
-	.apply_microcode	= apply_microcode_intel,
+	.apply_microcode	= apply_microcode_late,
 	.finalize_late_load	= finalize_late_load,
 };
 

