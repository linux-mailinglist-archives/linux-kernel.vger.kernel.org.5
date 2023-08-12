Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDAE77A266
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 22:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjHLURH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 16:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjHLURE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 16:17:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDDC1BFD
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 13:16:46 -0700 (PDT)
Message-ID: <20230812195729.693640265@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691870374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=w1SyTFpa9lrhJ4lGTg0lf2YQXOnASSGU3DRXcCp/oHw=;
        b=lkdpuxaIgkKAw5/H2Cjjkkt3E9IS48OQmBpLVgwS6/4waEGKkgxjV5zag6Av25xXqGHls3
        T+wg6tYpc1Q8KPV0KiL/kvbBkJZj3Pv+mEmIpUG0nw2OhxJ55Rx0F2SqhgvpZy0LYjQYgR
        1LI2B5WVo/34ZrOAnr/H1WR/S3x3unOOz23bvMOMud5iPKI03OuSfKwH4pYd8nt6tmRbSI
        nyHzL4WVXcw7/a6NHGnNEmk/krmItPAOCUkgkM6nvbA7m5/V6gEhYucNFx2bHnJMH5jfj9
        SpCSG4ZF26p21p60IjvgbhyZrfTyd4rZyYys0Ls0H/o1HHzCdmoBaRiLf4z7Yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691870374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=w1SyTFpa9lrhJ4lGTg0lf2YQXOnASSGU3DRXcCp/oHw=;
        b=QYYU2YXfHxQxYyLceD1EhSyLtOtNBnYmAgJCVOHPRNZaMURvzcwfUyLeAPdpLpH6V0hF6s
        GiTOI9G/SE/bbnAQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V2 37/37] x86/microcode/intel: Add a minimum required revision
 for late-loads
References: <20230812194003.682298127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 12 Aug 2023 21:59:34 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ashok Raj <ashok.raj@intel.com>

In general users don't have the necessary information to determine whether
late loading of a new microcode version is safe and does not modify
anything which the currently running kernel uses already, e.g. removal of
CPUID bits or behavioural changes of MSRs.

To address this issue, Intel has added a "minimum required version" field
to a previously reserved field in the microcode header.  Microcode updates
should only be applied if the current microcode version is equal to, or
greater than this minimum required version.

Thomas made some suggestions on how meta-data in the microcode file could
provide Linux with information to decide if the new microcode is suitable
candidate for late loading. But even the "simpler" option requires a lot of
metadata and corresponding kernel code to parse it, so the final suggestion
was to add the 'minimum required version' field in the header.

When microcode changes visible features, microcode will set the minimum
required version to its own revision which prevents late loading.

Old microcode blobs have the minimum revision field always set to 0, which
indicates that there is no information and the kernel considers it as
unsafe.

This is a pure OS software mechanism. The hardware/firmware ignores this
header field.

For early loading there is no restriction because OS visible features are
enumerated after the early load and therefor a change has no effect.

The check is always enabled, but by default not enforced. It can be
enforced via Kconfig or kernel command line.

If enforced, the kernel refuses to late load microcode with a minium
required version field which is zero or when the currently loaded microcode
revision is smaller than the minimum required revision.

If not enforced the load happens independent of the revision check to stay
compatible with the existing behaviour, but it influences the decision
whether the kernel is tainted or not. If the check signals that the late
load is safe, then the kernel is not tainted.

Early loading is not affected by this.

[ tglx: Massaged changelog and fixed up the implementation ]

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


---
 arch/x86/include/asm/microcode.h      |    3 +-
 arch/x86/kernel/cpu/microcode/intel.c |   37 ++++++++++++++++++++++++++++++----
 2 files changed, 35 insertions(+), 5 deletions(-)
---
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -36,7 +36,8 @@ struct microcode_header_intel {
 	unsigned int	datasize;
 	unsigned int	totalsize;
 	unsigned int	metasize;
-	unsigned int	reserved[2];
+	unsigned int	min_req_ver;
+	unsigned int	reserved;
 };
 
 struct microcode_intel {
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -544,16 +544,40 @@ static enum ucode_state apply_microcode_
 	return ret;
 }
 
+static bool ucode_validate_minrev(struct microcode_header_intel *mc_header)
+{
+	int cur_rev = boot_cpu_data.microcode;
+
+	/*
+	 * When late-loading, ensure the header declares a minimum revision
+	 * required to perform a late-load. The previously reserved field
+	 * is 0 in older microcode blobs.
+	 */
+	if (!mc_header->min_req_ver) {
+		pr_info("Unsafe microcode update: Microcode header does not specify a required min version\n");
+		return false;
+	}
+
+	/*
+	 * Check whether the minimum revision specified in the header is either
+	 * greater or equal to the current revision.
+	 */
+	if (cur_rev < mc_header->min_req_ver) {
+		pr_info("Unsafe microcode update: Current revision 0x%x too old\n", cur_rev);
+		pr_info("Current should be at 0x%x or higher. Use early loading instead\n", mc_header->min_req_ver);
+		return false;
+	}
+	return true;
+}
+
 static enum ucode_state read_ucode_intel(int cpu, struct iov_iter *iter)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 	unsigned int curr_mc_size = 0, new_mc_size = 0;
+	bool is_safe, new_is_safe = false;
 	int cur_rev = uci->cpu_sig.rev;
 	u8 *new_mc = NULL, *mc = NULL;
 
-	if (force_minrev)
-		return UCODE_NFOUND;
-
 	while (iov_iter_count(iter)) {
 		struct microcode_header_intel mc_header;
 		unsigned int mc_size, data_size;
@@ -596,10 +620,15 @@ static enum ucode_state read_ucode_intel
 		if (!intel_find_matching_signature(mc, &uci->cpu_sig))
 			continue;
 
+		is_safe = ucode_validate_minrev(&mc_header);
+		if (force_minrev && !is_safe)
+			continue;
+
 		kvfree(new_mc);
 		cur_rev = mc_header.rev;
 		new_mc  = mc;
 		new_mc_size = mc_size;
+		new_is_safe = is_safe;
 		mc = NULL;
 	}
 
@@ -616,7 +645,7 @@ static enum ucode_state read_ucode_intel
 		return UCODE_NFOUND;
 
 	ucode_patch_late = (struct microcode_intel *)new_mc;
-	return UCODE_NEW;
+	return new_is_safe ? UCODE_NEW_SAFE : UCODE_NEW;
 
 fail:
 	kvfree(mc);

