Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5F776F0AC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 19:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbjHCRbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 13:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjHCRbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:31:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3019106;
        Thu,  3 Aug 2023 10:31:36 -0700 (PDT)
Date:   Thu, 03 Aug 2023 17:31:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691083894;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=uFHGqz6Z8BeI8UIbRFTeALT3obNJdgQfXriVoQf/Zxs=;
        b=bl38m1OTX6EHg0AXRTjfADtZ0Xb0AW/dUyX2l7GhMhE+6QjXVaUxiNacD3q4GajbIfJuFf
        NHQ2k2QW2vIcVRVoat8y/EKRwdENoRnu6YcQ/g0ZJ/9ERfYQGITFLDHBgFPGVz+sxLdj9i
        HOu7GirZsTx0MEWN+b9gQTDDh7rpJIe/akLlRFvBNw2e7ZuwcFob6Fgm46HIMdzwvWVGxF
        fOewjYnlmzfdHiKbBc31rDbzzsWLpaAKyW0QGDqfONY2OoQaAbU6nhM9qd4Iwpav3nFzHN
        t7dxn4xYEHd6qSGf1MqNkQCaNSgEuwuOwm7uQ8UZmwa4Hb1yBKjkIK1AM/pvrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691083894;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=uFHGqz6Z8BeI8UIbRFTeALT3obNJdgQfXriVoQf/Zxs=;
        b=3tGB5Lb07Oug4Ei5W0H2N0R2nVXb+CoYeNZ2SiTyzqmiJHjMzAogAYTjMbecyfxvMC9n9c
        AQcVCPg43sZNlXBA==
From:   "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Remove "INVPCID single" feature tracking
Cc:     Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169108389377.28540.1358170196008758927.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     8bf96500d546fdd9fa36dc843b9e16a1c8603fc7
Gitweb:        https://git.kernel.org/tip/8bf96500d546fdd9fa36dc843b9e16a1c8603fc7
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Tue, 18 Jul 2023 10:06:30 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 03 Aug 2023 10:27:17 -07:00

x86/mm: Remove "INVPCID single" feature tracking

Changes from v1:
 * Move both 'cpu_tlbstate' references down in the function.  Neither
   is used in the !PTI path.  The invlpg is both a fully serializing
   instruction and compiler barrier.  The compiler can't optimize
   these references, so do it the hard way instead.

--

From: Dave Hansen <dave.hansen@linux.intel.com>

tl;dr: Replace a synthetic X86_FEATURE with a hardware X86_FEATURE
       and check of existing per-cpu state.

== Background ==

There are three features in play here:
 1. Good old Page Table Isolation (PTI)
 2. Process Context IDentifiers (PCIDs) which allow entries from
    multiple address spaces to be in the TLB at once.
 3. Support for the "Invalidate PCID" (INVPCID) instruction,
    specifically the "individual address" mode (aka. mode 0).

When all *three* of these are in place, INVPCID can and should be used
to flush out individual addresses in the PTI user address space.

But there's a wrinkle or two: First, this INVPCID mode is dependent on
CR4.PCIDE.  Even if X86_FEATURE_INVPCID==1, the instruction may #GP
without setting up CR4.  Second, TLB flushing is done very early, even
before CR4 is fully set up.  That means even if PTI, PCID and INVPCID
are supported, there is *still* a window where INVPCID can #GP.

== Problem ==

The current code seems to work, but mostly by chance and there are a
bunch of ways it can go wrong.  It's also somewhat hard to follow
since X86_FEATURE_INVPCID_SINGLE is set far away from its lone user.

== Solution ==

Make "INVPCID single" more robust and easier to follow by placing all
the logic in one place.  Remove X86_FEATURE_INVPCID_SINGLE.

Make two explicit checks before using INVPCID:
 1. Check that the system supports INVPCID itself (boot_cpu_has())
 2. Then check the CR4.PCIDE shadow to ensures that the CPU
    can safely use INVPCID for individual address invalidation.

The CR4 check *always* works and is not affected by any X86_FEATURE_*
twiddling or inconsistencies between the boot and secondary CPUs.

This has been tested on non-Meltdown hardware by using pti=on and
then flipping PCID and INVPCID support with qemu.

== Aside ==

How does this code even work today?  By chance, I think.  First, PTI
is initialized around the same time that the boot CPU sets
CR4.PCIDE=1.  There are currently no TLB invalidations when PTI=1 but
CR4.PCIDE=0.  That means that the X86_FEATURE_INVPCID_SINGLE check is
never even reached.

this_cpu_has() is also very nasty to use in this context because the
boot CPU reaches here before cpu_data(0) has been initialized.  It
happens to work for X86_FEATURE_INVPCID_SINGLE since it's a
software-defined feature but it would fall over for a hardware-
derived X86_FEATURE.

Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20230718170630.7922E235%40davehans-spike.ostc.intel.com
---
 arch/x86/include/asm/cpufeatures.h |  1 -
 arch/x86/mm/init.c                 |  9 ---------
 arch/x86/mm/tlb.c                  | 19 +++++++++++++------
 3 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index cb8ca46..ec1bce0 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -198,7 +198,6 @@
 #define X86_FEATURE_CAT_L3		( 7*32+ 4) /* Cache Allocation Technology L3 */
 #define X86_FEATURE_CAT_L2		( 7*32+ 5) /* Cache Allocation Technology L2 */
 #define X86_FEATURE_CDP_L3		( 7*32+ 6) /* Code and Data Prioritization L3 */
-#define X86_FEATURE_INVPCID_SINGLE	( 7*32+ 7) /* Effectively INVPCID && CR4.PCIDE=1 */
 #define X86_FEATURE_HW_PSTATE		( 7*32+ 8) /* AMD HW-PState */
 #define X86_FEATURE_PROC_FEEDBACK	( 7*32+ 9) /* AMD ProcFeedbackInterface */
 #define X86_FEATURE_XCOMPACTED		( 7*32+10) /* "" Use compacted XSTATE (XSAVES or XSAVEC) */
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 8192452..4e152d8 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -307,15 +307,6 @@ static void setup_pcid(void)
 		 * start_secondary().
 		 */
 		cr4_set_bits(X86_CR4_PCIDE);
-
-		/*
-		 * INVPCID's single-context modes (2/3) only work if we set
-		 * X86_CR4_PCIDE, *and* we INVPCID support.  It's unusable
-		 * on systems that have X86_CR4_PCIDE clear, or that have
-		 * no INVPCID support at all.
-		 */
-		if (boot_cpu_has(X86_FEATURE_INVPCID))
-			setup_force_cpu_cap(X86_FEATURE_INVPCID_SINGLE);
 	} else {
 		/*
 		 * flush_tlb_all(), as currently implemented, won't work if
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 267acf2..6982b4f 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1140,21 +1140,28 @@ void flush_tlb_one_kernel(unsigned long addr)
  */
 STATIC_NOPV void native_flush_tlb_one_user(unsigned long addr)
 {
-	u32 loaded_mm_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
+	u32 loaded_mm_asid;
+	bool cpu_pcide;
 
+	/* Flush 'addr' from the kernel PCID: */
 	asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
 
+	/* If PTI is off there is no user PCID and nothing to flush. */
 	if (!static_cpu_has(X86_FEATURE_PTI))
 		return;
 
+	loaded_mm_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
+	cpu_pcide      = this_cpu_read(cpu_tlbstate.cr4) & X86_CR4_PCIDE;
+
 	/*
-	 * Some platforms #GP if we call invpcid(type=1/2) before CR4.PCIDE=1.
-	 * Just use invalidate_user_asid() in case we are called early.
+	 * invpcid_flush_one(pcid>0) will #GP if CR4.PCIDE==0.  Check
+	 * 'cpu_pcide' to ensure that *this* CPU will not trigger those
+	 * #GP's even if called before CR4.PCIDE has been initialized.
 	 */
-	if (!this_cpu_has(X86_FEATURE_INVPCID_SINGLE))
-		invalidate_user_asid(loaded_mm_asid);
-	else
+	if (boot_cpu_has(X86_FEATURE_INVPCID) && cpu_pcide)
 		invpcid_flush_one(user_pcid(loaded_mm_asid), addr);
+	else
+		invalidate_user_asid(loaded_mm_asid);
 }
 
 void flush_tlb_one_user(unsigned long addr)
