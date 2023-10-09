Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9AD7BDC01
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376655AbjJIMbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376418AbjJIM36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:29:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE4EFC;
        Mon,  9 Oct 2023 05:29:54 -0700 (PDT)
Date:   Mon, 09 Oct 2023 12:29:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696854593;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Qu1sEwHzz3GP9bkI7grxHY1nuNrbtoSOmjrI5deSdg=;
        b=wOCVxtVHilz6v6uN5amrqaGjoWZnbbKmOM3ishIrlAPxS9UI2+pVg4cENZBaMnism4xk4Z
        q1aEL5+ag1khgSX3C/pH35kJrc9ojbT9wYUNzd07/kfRF6YpwNYDUBes/4i773RW/Mqr/1
        ah5VnzGjiNwCrxrApirqssDb4ygWlXke+AeCdKA8/9KGWjWQWrJzIpOTcJ7NCf6gWxW3vo
        OiBMGxieZxTZJVQHzztZC2tT03BFXVj+8dyiChLFVOcJK1U+axDL+ZHlwoiTNgfJSw+z+/
        eicaLDyF5wrqMpDGOVoT8JeUvZzveghUv2hxgILuj0iOTYx6GomOEGxhTRrJRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696854593;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Qu1sEwHzz3GP9bkI7grxHY1nuNrbtoSOmjrI5deSdg=;
        b=59Xi8F+LsTnGZOLjn/MmoTaxK+T2yDqmX/fg8xmxduX59QNqTVFRJnGAjwvLpk4ymRx5dz
        AIGSbuV0RQBWhDAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/intel: Unify microcode apply() functions
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231002115902.625388847@linutronix.de>
References: <20231002115902.625388847@linutronix.de>
MIME-Version: 1.0
Message-ID: <169685459246.3135.11736895885500024488.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     1542922ce22a1da1a8b70b1d6e79cc92d229f061
Gitweb:        https://git.kernel.org/tip/1542922ce22a1da1a8b70b1d6e79cc92d229f061
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 02 Oct 2023 13:59:46 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 03 Oct 2023 16:03:40 +02:00

x86/microcode/intel: Unify microcode apply() functions

Deduplicate the early and late apply() functions.

  [ bp: Rename the function which does the actual application to
    __apply_microcode() to differentiate it from
    microcode_ops.apply_microcode(). ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231002115902.625388847@linutronix.de
---
 arch/x86/kernel/cpu/microcode/intel.c | 104 ++++++++-----------------
 1 file changed, 36 insertions(+), 68 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index f06889e..84d6edf 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -294,12 +294,12 @@ static __init struct microcode_intel *scan_microcode(void *data, size_t size,
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
 
@@ -308,14 +308,12 @@ static enum ucode_state apply_microcode_early(struct ucode_cpu_info *uci)
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
@@ -330,13 +328,24 @@ static enum ucode_state apply_microcode_early(struct ucode_cpu_info *uci)
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
@@ -450,70 +459,29 @@ static int collect_cpu_info(int cpu_num, struct cpu_signature *csig)
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
+	u32 cur_rev;
 
-	/* We should bind the task to the CPU */
-	if (WARN_ON(raw_smp_processor_id() != cpu))
+	if (WARN_ON_ONCE(smp_processor_id() != cpu))
 		return UCODE_ERROR;
 
-	mc = ucode_patch_late;
-	if (!mc)
-		return UCODE_NFOUND;
+	ret = __apply_microcode(uci, mc, &cur_rev);
+	if (ret != UCODE_UPDATED && ret != UCODE_OK)
+		return ret;
 
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
-		return UCODE_ERROR;
-	}
-
-	if (bsp && rev != prev_rev) {
-		pr_info("updated to revision 0x%x, date = %04x-%02x-%02x\n",
-			rev,
-			mc->hdr.date & 0xffff,
-			mc->hdr.date >> 24,
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
@@ -654,7 +622,7 @@ static void finalize_late_load(int result)
 static struct microcode_ops microcode_intel_ops = {
 	.request_microcode_fw	= request_microcode_fw,
 	.collect_cpu_info	= collect_cpu_info,
-	.apply_microcode	= apply_microcode_intel,
+	.apply_microcode	= apply_microcode_late,
 	.finalize_late_load	= finalize_late_load,
 };
 
