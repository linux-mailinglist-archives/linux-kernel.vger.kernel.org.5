Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBD677806B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235887AbjHJSix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235722AbjHJSiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:38:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BC92D76
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:38:04 -0700 (PDT)
Message-ID: <20230810160805.934494281@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691692671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=RyAZdhYUiy48Y/XZU7T04DGYjgBzGOlb8fG6vAh+kH8=;
        b=objlsPC5h9djIldT3K9DGzT6gg0Gle0YRmjhie3pkoZHJ2J+liU8y+mBf3odMvKlaCy5UI
        Y6+thqLLndVAKigGdlGRI5Baokm5s9+H+SO9Q9akkF+UzY74KD1CP6K4fkWlqazTlPSWc9
        ixvambj9dX8vLV/+ghEs8p2bzTofBgsDRc93C1EfBVpXuIc2UNXYyGQexDqaAlbV9/G5CR
        XGJ556PQWbWZVehUtfUZyUIapN4+fXVbZWmV1M6Aqkz2y4hjTmOGg7h0wityLnG5qQ19qF
        Ectzb7jJvOvohZH3H3kCIzf3b7TzJTNq24Pg6DF6Jd3YpFX+AdqGvcNrpFKVrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691692671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=RyAZdhYUiy48Y/XZU7T04DGYjgBzGOlb8fG6vAh+kH8=;
        b=aNLvWxACY/b8sKvBkd5MAE6FupxaDbd0VrSDoAmdtpxcs4HLLKIrJiwdEyiKY/BjIQ/eXW
        9LztDo1ftqSkDlBQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: [patch 17/30] x86/microcode/intel: Unify microcode apply() functions
References: <20230810153317.850017756@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 10 Aug 2023 20:37:51 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
@@ -325,12 +325,11 @@ static inline void print_ucode(int old_r
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
 
@@ -339,14 +338,12 @@ static enum ucode_state apply_microcode_
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
@@ -361,13 +358,23 @@ static enum ucode_state apply_microcode_
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
@@ -508,70 +515,29 @@ static int collect_cpu_info(int cpu_num,
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
@@ -718,7 +684,7 @@ static void finalize_late_load(int resul
 static struct microcode_ops microcode_intel_ops = {
 	.request_microcode_fw	= request_microcode_fw,
 	.collect_cpu_info	= collect_cpu_info,
-	.apply_microcode	= apply_microcode_intel,
+	.apply_microcode	= apply_microcode_late,
 	.finalize_late_load	= finalize_late_load,
 };
 

