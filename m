Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A27778066
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235732AbjHJSiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235888AbjHJSiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:38:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2B33596
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:37:47 -0700 (PDT)
Message-ID: <20230810160805.710329611@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691692665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=/uSyU9DUMvRJ3IasEYHJrt1TCtvswyOQyFstq2a1UwI=;
        b=FoxF7GUZjtmq1nOsbohNmvQzYt6vpW36RTMQ3QSnKbRkU6LSB7vW1F2eAV6O7/JicwXYxG
        7TLPexovdkbvLOIW4U/vPLd24xnWzPmWmOG3VNxknL9REz1yue6HvUeABmL1FqG88aMgpO
        Rfbbt6LBm69IYOBLF1FyMNDY+NRdkN525DkqeoTtWgxUaT4rWFEnvphBu5dMEu6Nb8aU01
        dUUEgwdE7d+FkHbdn6odM+4SAyUKJjBJoygT8m62ZZ0MNDS/QHxlMkjtO5m9HmmbfA547z
        5jhnx9N9esfXJgKlgrKaYRlLjhEV/P1SR+xlwkSjitOjGOAzJQQr2fr7Zblt4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691692665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=/uSyU9DUMvRJ3IasEYHJrt1TCtvswyOQyFstq2a1UwI=;
        b=S/ysyttf1uE0mdd2AAhUWuwHKtnVaMQhH4B60vLBVgbUbyoQoH+ia86EofzjUbXXAOZo13
        68FIMN4bWGdcycDA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: [patch 13/30] x86/microcode/intel: Cleanup code further
References: <20230810153317.850017756@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 10 Aug 2023 20:37:45 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Sanitize the microcode scan loop, fixup printks and move the initrd loading
function next to the place where it is used and mark it __init. Rename
generic_load_microcode() as that Intel specific function is not generic at
all.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/kernel/cpu/microcode/intel.c |   82 +++++++++++++---------------------
 1 file changed, 33 insertions(+), 49 deletions(-)
---
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -36,7 +36,7 @@ static const char ucode_path[] = "kernel
 static struct microcode_intel *intel_ucode_patch __read_mostly;
 
 /* last level cache size per core */
-static int llc_size_per_core __ro_after_init;
+static unsigned int llc_size_per_core __ro_after_init;
 
 int intel_cpu_collect_info(struct ucode_cpu_info *uci)
 {
@@ -275,37 +275,10 @@ static struct microcode_intel *scan_micr
 	return patch;
 }
 
-static bool load_builtin_intel_microcode(struct cpio_data *cp)
-{
-	unsigned int eax = 1, ebx, ecx = 0, edx;
-	struct firmware fw;
-	char name[30];
-
-	if (IS_ENABLED(CONFIG_X86_32))
-		return false;
-
-	native_cpuid(&eax, &ebx, &ecx, &edx);
-
-	sprintf(name, "intel-ucode/%02x-%02x-%02x",
-		      x86_family(eax), x86_model(eax), x86_stepping(eax));
-
-	if (firmware_request_builtin(&fw, name)) {
-		cp->size = fw.size;
-		cp->data = (void *)fw.data;
-		return true;
-	}
-
-	return false;
-}
-
 static void print_ucode_info(int old_rev, int new_rev, unsigned int date)
 {
 	pr_info_once("updated early: 0x%x -> 0x%x, date = %04x-%02x-%02x\n",
-		     old_rev,
-		     new_rev,
-		     date & 0xffff,
-		     date >> 24,
-		     (date >> 16) & 0xff);
+		     old_rev, new_rev, date & 0xffff, date >> 24, (date >> 16) & 0xff);
 }
 
 #ifdef CONFIG_X86_32
@@ -399,6 +372,28 @@ static int apply_microcode_early(struct
 	return 0;
 }
 
+static bool load_builtin_intel_microcode(struct cpio_data *cp)
+{
+	unsigned int eax = 1, ebx, ecx = 0, edx;
+	struct firmware fw;
+	char name[30];
+
+	if (IS_ENABLED(CONFIG_X86_32))
+		return false;
+
+	native_cpuid(&eax, &ebx, &ecx, &edx);
+
+	sprintf(name, "intel-ucode/%02x-%02x-%02x",
+		x86_family(eax), x86_model(eax), x86_stepping(eax));
+
+	if (firmware_request_builtin(&fw, name)) {
+		cp->size = fw.size;
+		cp->data = (void *)fw.data;
+		return true;
+	}
+	return false;
+}
+
 int __init save_microcode_in_initrd_intel(void)
 {
 	struct ucode_cpu_info uci;
@@ -490,25 +485,16 @@ void load_ucode_intel_ap(void)
 	apply_microcode_early(&uci, true);
 }
 
-/* Accessor for microcode pointer */
-static struct microcode_intel *ucode_get_patch(void)
-{
-	return intel_ucode_patch;
-}
-
 void reload_ucode_intel(void)
 {
-	struct microcode_intel *p;
 	struct ucode_cpu_info uci;
 
 	intel_cpu_collect_info(&uci);
 
-	p = ucode_get_patch();
-	if (!p)
+	uci.mc = intel_ucode_patch;
+	if (!uci.mc)
 		return;
 
-	uci.mc = p;
-
 	apply_microcode_early(&uci, false);
 }
 
@@ -546,8 +532,7 @@ static enum ucode_state apply_microcode_
 	if (WARN_ON(raw_smp_processor_id() != cpu))
 		return UCODE_ERROR;
 
-	/* Look for a newer patch in our cache: */
-	mc = ucode_get_patch();
+	mc = intel_ucode_patch;
 	if (!mc) {
 		mc = uci->mc;
 		if (!mc)
@@ -738,18 +723,17 @@ static enum ucode_state request_microcod
 }
 
 static struct microcode_ops microcode_intel_ops = {
-	.request_microcode_fw             = request_microcode_fw,
-	.collect_cpu_info                 = collect_cpu_info,
-	.apply_microcode                  = apply_microcode_intel,
+	.request_microcode_fw	= request_microcode_fw,
+	.collect_cpu_info	= collect_cpu_info,
+	.apply_microcode	= apply_microcode_intel,
 };
 
-static int __init calc_llc_size_per_core(struct cpuinfo_x86 *c)
+static __init void calc_llc_size_per_core(struct cpuinfo_x86 *c)
 {
 	u64 llc_size = c->x86_cache_size * 1024ULL;
 
 	do_div(llc_size, c->x86_max_cores);
-
-	return (int)llc_size;
+	llc_size_per_core = (unsigned int)llc_size;
 }
 
 struct microcode_ops * __init init_intel_microcode(void)
@@ -762,7 +746,7 @@ struct microcode_ops * __init init_intel
 		return NULL;
 	}
 
-	llc_size_per_core = calc_llc_size_per_core(c);
+	calc_llc_size_per_core(c);
 
 	return &microcode_intel_ops;
 }

