Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09F17BDBCC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376300AbjJIM3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346433AbjJIM3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:29:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC30699;
        Mon,  9 Oct 2023 05:29:45 -0700 (PDT)
Date:   Mon, 09 Oct 2023 12:29:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696854583;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ah6GLEMoXGPelrTlRSD7Pjw3CRT1rp2dzP/AboKmlo0=;
        b=njvSUA64yq4boIXXifOdmU/+9NTiUo88pToPt23mWVQJK5AlaMxvKgbATuJIPrC7aPl5y0
        6+b0/0Zr/xJrAGenED8cAhd0V7M9+bxiZgonHUAdB7PNBHhjZZKFLefm9+DCS/z66fUC1v
        UtwY7jOKJZZ1bGgfGUQkIDA3Mbfs/Iqp+c2wXKuRxtMcLcuSQpJjQQJkerS952M+t/7WEw
        xqOQedaSu2ozuG0X/M+QHDe2SUK9S3S96ao6rhUvfQpz8gnswp6ulVkQd+NlONS2eu/drW
        0Ci79+TZV5gGcVjxS4cG8xr37+hVQM1uWHU8fbAeEevxAx3w61nVTkmmiC4OLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696854583;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ah6GLEMoXGPelrTlRSD7Pjw3CRT1rp2dzP/AboKmlo0=;
        b=w9sb66YN0IVh+UOuUxHDniqT/2PEXLrm/LfZ17Nqhpg/0sQtuUIp3ZEEA9Kt+VL+q69dam
        1EC1Wkg/pcLWmEAg==
From:   "tip-bot2 for Ashok Raj" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/intel: Add a minimum required
 revision for late loading
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ashok Raj <ashok.raj@intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231002115903.776467264@linutronix.de>
References: <20231002115903.776467264@linutronix.de>
MIME-Version: 1.0
Message-ID: <169685458297.3135.13685812754249288504.tip-bot2@tip-bot2>
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

Commit-ID:     9975802d3f7426abc32fd9ac0924a639d11a7c4f
Gitweb:        https://git.kernel.org/tip/9975802d3f7426abc32fd9ac0924a639d11a7c4f
Author:        Ashok Raj <ashok.raj@intel.com>
AuthorDate:    Mon, 02 Oct 2023 14:00:11 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 06 Oct 2023 15:12:25 +02:00

x86/microcode/intel: Add a minimum required revision for late loading

In general users, don't have the necessary information to determine
whether late loading of a new microcode version is safe and does not
modify anything which the currently running kernel uses already, e.g.
removal of CPUID bits or behavioural changes of MSRs.

To address this issue, Intel has added a "minimum required version"
field to a previously reserved field in the microcode header.  Microcode
updates should only be applied if the current microcode version is equal
to, or greater than this minimum required version.

Thomas made some suggestions on how meta-data in the microcode file could
provide Linux with information to decide if the new microcode is suitable
candidate for late loading. But even the "simpler" option requires a lot of
metadata and corresponding kernel code to parse it, so the final suggestion
was to add the 'minimum required version' field in the header.

When microcode changes visible features, microcode will set the minimum
required version to its own revision which prevents late loading.

Old microcode blobs have the minimum revision field always set to 0, which
indicates that there is no information and the kernel considers it
unsafe.

This is a pure OS software mechanism. The hardware/firmware ignores this
header field.

For early loading there is no restriction because OS visible features
are enumerated after the early load and therefore a change has no
effect.

The check is always enabled, but by default not enforced. It can be
enforced via Kconfig or kernel command line.

If enforced, the kernel refuses to late load microcode with a minimum
required version field which is zero or when the currently loaded
microcode revision is smaller than the minimum required revision.

If not enforced the load happens independent of the revision check to
stay compatible with the existing behaviour, but it influences the
decision whether the kernel is tainted or not. If the check signals that
the late load is safe, then the kernel is not tainted.

Early loading is not affected by this.

[ tglx: Massaged changelog and fixed up the implementation ]

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231002115903.776467264@linutronix.de
---
 arch/x86/include/asm/microcode.h      |  3 +-
 arch/x86/kernel/cpu/microcode/intel.c | 37 +++++++++++++++++++++++---
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 1ab475a..7811efe 100644
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
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 0e7ff3e..d6311f0 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -464,16 +464,40 @@ static enum ucode_state apply_microcode_late(int cpu)
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
+	 * Check whether the current revision is either greater or equal to
+	 * to the minimum revision specified in the header.
+	 */
+	if (cur_rev < mc_header->min_req_ver) {
+		pr_info("Unsafe microcode update: Current revision 0x%x too old\n", cur_rev);
+		pr_info("Current should be at 0x%x or higher. Use early loading instead\n", mc_header->min_req_ver);
+		return false;
+	}
+	return true;
+}
+
 static enum ucode_state parse_microcode_blobs(int cpu, struct iov_iter *iter)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
+	bool is_safe, new_is_safe = false;
 	int cur_rev = uci->cpu_sig.rev;
 	unsigned int curr_mc_size = 0;
 	u8 *new_mc = NULL, *mc = NULL;
 
-	if (force_minrev)
-		return UCODE_NFOUND;
-
 	while (iov_iter_count(iter)) {
 		struct microcode_header_intel mc_header;
 		unsigned int mc_size, data_size;
@@ -516,9 +540,14 @@ static enum ucode_state parse_microcode_blobs(int cpu, struct iov_iter *iter)
 		if (!intel_find_matching_signature(mc, &uci->cpu_sig))
 			continue;
 
+		is_safe = ucode_validate_minrev(&mc_header);
+		if (force_minrev && !is_safe)
+			continue;
+
 		kvfree(new_mc);
 		cur_rev = mc_header.rev;
 		new_mc  = mc;
+		new_is_safe = is_safe;
 		mc = NULL;
 	}
 
@@ -530,7 +559,7 @@ static enum ucode_state parse_microcode_blobs(int cpu, struct iov_iter *iter)
 		return UCODE_NFOUND;
 
 	ucode_patch_late = (struct microcode_intel *)new_mc;
-	return UCODE_NEW;
+	return new_is_safe ? UCODE_NEW_SAFE : UCODE_NEW;
 
 fail:
 	kvfree(mc);
