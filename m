Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B6B7BDC03
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376558AbjJIMbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376455AbjJIMaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:30:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D3B100;
        Mon,  9 Oct 2023 05:29:56 -0700 (PDT)
Date:   Mon, 09 Oct 2023 12:29:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696854595;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P54tdTS295Ln306QV3QMwhxhW4kstgOnSFqeZsfErp4=;
        b=CkaZ9MS6FoGFsKWvvZoiHEXP+7osljUdPufst7J2lrumQ2GHxwj7ENJsXB+QDjI73U+gRD
        yY3UVEXW+4guw/Ur1yWTrTcvobgsnvewWySQCjqj46XPQWbjg5tnW2yQm8jgJjECU+rQuz
        9nT3GdTB+XVHgVwbfWhWNubCnllwpJiNehLRh0mgbFLxt0n19yq3/zfVSb1azu2pDWXsFl
        MGa+wexMO64G/JsOE1Pb+ci8XYATSYJYYWeD0K75xwSvv8e3lwKolvnRvhF8J/58SJPZ1Z
        pXQV4FyeJB+/U3gfS4BOONqMhObocBMAG8psU2T6W6+qgPSG5dibm2w7unzPpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696854595;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P54tdTS295Ln306QV3QMwhxhW4kstgOnSFqeZsfErp4=;
        b=C4ikywyoySXxhNDus+SkJJ4U1G5p23/J8aBDGtAJW7jbS8WwW9wsgT2SvgTwTTppgZT4E8
        HMdiXRn2ikFFtFAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/intel: Cleanup code further
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231002115902.389400871@linutronix.de>
References: <20231002115902.389400871@linutronix.de>
MIME-Version: 1.0
Message-ID: <169685459441.3135.17668516189004569186.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     5017d6d28ad46c2ff677d5bea13f4358082cd86f
Gitweb:        https://git.kernel.org/tip/5017d6d28ad46c2ff677d5bea13f4358082cd86f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 02 Oct 2023 13:59:41 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 03 Oct 2023 11:27:27 +02:00

x86/microcode/intel: Cleanup code further

Sanitize the microcode scan loop, fixup printks and move the loading
function for builtin microcode next to the place where it is used and mark
it __init.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231002115902.389400871@linutronix.de
---
 arch/x86/kernel/cpu/microcode/intel.c | 76 ++++++++++----------------
 1 file changed, 32 insertions(+), 44 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 60862f6..bf6e083 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -36,7 +36,7 @@ static const char ucode_path[] = "kernel/x86/microcode/GenuineIntel.bin";
 static struct microcode_intel *intel_ucode_patch __read_mostly;
 
 /* last level cache size per core */
-static int llc_size_per_core __ro_after_init;
+static unsigned int llc_size_per_core __ro_after_init;
 
 /* microcode format is extended from prescott processors */
 struct extended_signature {
@@ -296,29 +296,6 @@ static struct microcode_intel *scan_microcode(void *data, size_t size,
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
@@ -362,6 +339,28 @@ static int apply_microcode_early(struct ucode_cpu_info *uci)
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
 
@@ -490,8 +480,7 @@ static enum ucode_state apply_microcode_intel(int cpu)
 	if (WARN_ON(raw_smp_processor_id() != cpu))
 		return UCODE_ERROR;
 
-	/* Look for a newer patch in our cache: */
-	mc = ucode_get_patch();
+	mc = intel_ucode_patch;
 	if (!mc) {
 		mc = uci->mc;
 		if (!mc)
@@ -682,18 +671,17 @@ static enum ucode_state request_microcode_fw(int cpu, struct device *device)
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
@@ -706,7 +694,7 @@ struct microcode_ops * __init init_intel_microcode(void)
 		return NULL;
 	}
 
-	llc_size_per_core = calc_llc_size_per_core(c);
+	calc_llc_size_per_core(c);
 
 	return &microcode_intel_ops;
 }
