Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911D980AA72
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574444AbjLHRRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574262AbjLHRRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:17:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B94EAD;
        Fri,  8 Dec 2023 09:17:21 -0800 (PST)
Date:   Fri, 08 Dec 2023 17:17:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702055839;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=CSxnrNUdsiEG1rACaG66Tif9kpZMW1HCVm+scxNDQ5I=;
        b=OZv6AAqox9XBKueLxtTtH/ZcCpEYBJkeTl2C1VNQzMoYG0eiAv0/6AiDjHIBo5btSTKVhu
        saCc9SFfwKI+b4KkAFsqw7T2GxYCq0ZKnp3UV1QI780Hrt6Um2UPdR6piyfGU+ASz9uUNK
        3AKTVlgbbnDKYuyQBCJmu6oVf/uF+8nJodpubcBn/Tv9nyc9PgdGSDUfUfPKYwITm2TwCp
        ApP7vyifkyPAZLX/CI+2vR2epQpSh5LVq0axWiAFViB3ljXwqZJ2DGhVUd2MK/jzJkFO6C
        cmXWoR6K9CIfciiNQ3ZriJ7zmJb9jl/W3Qu7bwNtGXEVZkcuDCeqMK6kf70fNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702055839;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=CSxnrNUdsiEG1rACaG66Tif9kpZMW1HCVm+scxNDQ5I=;
        b=gnvffWZWZMI8kLcdvPaeGc8Z1+0krgjJIHtT42oFcmCFyQoTHpfAwUeSkH/xBjVFr1+q+w
        twSaOokqqcQzE/Dg==
From:   "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/cpu: Detect TDX partial write machine check erratum
Cc:     Kai Huang <kai.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <170205583893.398.6546992564659236657.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     40011858466f0a2cf4366590a09afbfc7ec286c2
Gitweb:        https://git.kernel.org/tip/40011858466f0a2cf4366590a09afbfc7ec286c2
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Fri, 08 Dec 2023 09:07:37 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 08 Dec 2023 09:12:49 -08:00

x86/cpu: Detect TDX partial write machine check erratum

TDX memory has integrity and confidentiality protections.  Violations of
this integrity protection are supposed to only affect TDX operations and
are never supposed to affect the host kernel itself.  In other words,
the host kernel should never, itself, see machine checks induced by the
TDX integrity hardware.

Alas, the first few generations of TDX hardware have an erratum.  A
partial write to a TDX private memory cacheline will silently "poison"
the line.  Subsequent reads will consume the poison and generate a
machine check.  According to the TDX hardware spec, neither of these
things should have happened.

Virtually all kernel memory accesses operations happen in full
cachelines.  In practice, writing a "byte" of memory usually reads a 64
byte cacheline of memory, modifies it, then writes the whole line back.
Those operations do not trigger this problem.

This problem is triggered by "partial" writes where a write transaction
of less than cacheline lands at the memory controller.  The CPU does
these via non-temporal write instructions (like MOVNTI), or through
UC/WC memory mappings.  The issue can also be triggered away from the
CPU by devices doing partial writes via DMA.

With this erratum, there are additional things need to be done.  To
prepare for those changes, add a CPU bug bit to indicate this erratum.
Note this bug reflects the hardware thus it is detected regardless of
whether the kernel is built with TDX support or not.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20231208170740.53979-17-dave.hansen%40intel.com
---
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/virt/vmx/tdx/tdx.c        | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 45ddc6b..dbec4a0 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -496,6 +496,7 @@
 #define X86_BUG_EIBRS_PBRSB		X86_BUG(28) /* EIBRS is vulnerable to Post Barrier RSB Predictions */
 #define X86_BUG_SMT_RSB			X86_BUG(29) /* CPU is vulnerable to Cross-Thread Return Address Predictions */
 #define X86_BUG_GDS			X86_BUG(30) /* CPU is affected by Gather Data Sampling */
+#define X86_BUG_TDX_PW_MCE		X86_BUG(31) /* CPU may incur #MC if non-TD software does partial write to TDX private memory */
 
 /* BUG word 2 */
 #define X86_BUG_SRSO			X86_BUG(1*32 + 0) /* AMD SRSO bug */
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 6d030f6..ae3807f 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -33,6 +33,9 @@
 #include <asm/msr.h>
 #include <asm/cpufeature.h>
 #include <asm/tdx.h>
+#include <asm/cpufeature.h>
+#include <asm/intel-family.h>
+#include <asm/processor.h>
 #include "tdx.h"
 
 static u32 tdx_global_keyid __ro_after_init;
@@ -1308,6 +1311,21 @@ static struct notifier_block tdx_memory_nb = {
 	.notifier_call = tdx_memory_notifier,
 };
 
+static void __init check_tdx_erratum(void)
+{
+	/*
+	 * These CPUs have an erratum.  A partial write from non-TD
+	 * software (e.g. via MOVNTI variants or UC/WC mapping) to TDX
+	 * private memory poisons that memory, and a subsequent read of
+	 * that memory triggers #MC.
+	 */
+	switch (boot_cpu_data.x86_model) {
+	case INTEL_FAM6_SAPPHIRERAPIDS_X:
+	case INTEL_FAM6_EMERALDRAPIDS_X:
+		setup_force_cpu_bug(X86_BUG_TDX_PW_MCE);
+	}
+}
+
 void __init tdx_init(void)
 {
 	u32 tdx_keyid_start, nr_tdx_keyids;
@@ -1361,4 +1379,6 @@ void __init tdx_init(void)
 	tdx_nr_guest_keyids = nr_tdx_keyids - 1;
 
 	setup_force_cpu_cap(X86_FEATURE_TDX_HOST_PLATFORM);
+
+	check_tdx_erratum();
 }
