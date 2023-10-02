Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10C17B51ED
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236882AbjJBL76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 07:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236857AbjJBL7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:59:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3B2DD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 04:59:43 -0700 (PDT)
Message-ID: <20231002115902.389400871@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696247982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=CL8Mt93Hk88+MM0PiUaqDK+zdUWvTsAJgc1nd1BOMcc=;
        b=1ZR90HunL9z5eJ6ksvZnLxRCkDP6aHy7OvvfxSMM9OVjgGH0+MEbvcxfJ3fmeIwrow8ofh
        tWnQz+KToKu4IXT3FLnOJOTnj/o4snGqbAeeCcE02mxt6HxRV5qFqI1ylt0/6nzmpgTCLf
        e9NII/4aI0iw1sFRiz89MgNP+njjYSarHXxcZQZK0Cvvig4ghVj4aoa6SQwCghEKMgSwYm
        WWJ1TZTeXZyZt1zOAY/CnyJMCZXJ+65Xn5uYyfwqfkl2N3H+xdSUxb5ZmaK8LEPRGNgLbX
        DcJ/HFEJur/QqSjHaZNPfD/nwp+WrEq5tyfiaE8uRnk4BNRjI8X5hLRImYGb3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696247982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=CL8Mt93Hk88+MM0PiUaqDK+zdUWvTsAJgc1nd1BOMcc=;
        b=e1fd2q/aWoqUYauDcuakBc68T6pPCnXcRcOBJ0Ol6ItZqqtV/IwBxs4E10STFLIgeloruX
        Y4zcjwAQo1fuwVCQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V4 06/30] x86/microcode/intel: Cleanup code further
References: <20231002115506.217091296@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  2 Oct 2023 13:59:41 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Sanitize the microcode scan loop, fixup printks and move the loading
function for builtin microcode next to the place where it is used and mark
it __init.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Fix changelog - Nikolay
---
 arch/x86/kernel/cpu/microcode/intel.c |   76 ++++++++++++++--------------------
 1 file changed, 32 insertions(+), 44 deletions(-)
---
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -36,7 +36,7 @@ static const char ucode_path[] = "kernel
 static struct microcode_intel *intel_ucode_patch __read_mostly;
 
 /* last level cache size per core */
-static int llc_size_per_core __ro_after_init;
+static unsigned int llc_size_per_core __ro_after_init;
 
 /* microcode format is extended from prescott processors */
 struct extended_signature {
@@ -296,29 +296,6 @@ static struct microcode_intel *scan_micr
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
 static int apply_microcode_early(struct ucode_cpu_info *uci)
 {
 	struct microcode_intel *mc;
@@ -362,6 +339,28 @@ static int apply_microcode_early(struct
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
@@ -434,25 +433,16 @@ void load_ucode_intel_ap(void)
 	apply_microcode_early(&uci);
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
 	apply_microcode_early(&uci);
 }
 
@@ -490,8 +480,7 @@ static enum ucode_state apply_microcode_
 	if (WARN_ON(raw_smp_processor_id() != cpu))
 		return UCODE_ERROR;
 
-	/* Look for a newer patch in our cache: */
-	mc = ucode_get_patch();
+	mc = intel_ucode_patch;
 	if (!mc) {
 		mc = uci->mc;
 		if (!mc)
@@ -682,18 +671,17 @@ static enum ucode_state request_microcod
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
@@ -706,7 +694,7 @@ struct microcode_ops * __init init_intel
 		return NULL;
 	}
 
-	llc_size_per_core = calc_llc_size_per_core(c);
+	calc_llc_size_per_core(c);
 
 	return &microcode_intel_ops;
 }

