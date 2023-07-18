Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F2F75833B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbjGRRGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjGRRGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:06:47 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2E61B6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689699997; x=1721235997;
  h=subject:to:cc:from:date:message-id;
  bh=6W9dgRQIg29x+a1B64mqmcheEofd6Qnr8fs53Afs4Tw=;
  b=GwcNHcmEaEGJeiTaPhWg/AMjk/5c+NVKsI0VYe8O1DHnedblQsLpOCQX
   1RDtoomToIoMjCWO0AI4FO9oBlPqhLQ//R5LJDlnLNKcKR+fp9NvSoLwg
   U1CIjvzNW3BWSl4vbWb/eXV5+b3H6UMoE5Z8Z8iYPhpL9vtOHWyUQe3jQ
   is/VlYrhUtleq/tj1zs5nOZIrelP449+ISdHtjEx2uqEJHKczaAf36FHX
   w4pqtwoMUBdx8VP+/fWDPKJd4/rhnz0eM6akgR3s9zsP+uL58hQl7m919
   jcYU8zyYlMB+4zrQI9kLH1WDrzuf5JtZveO7g/B/w8GhtXoX/DFFn9DWa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="397105368"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="397105368"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 10:06:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="673998968"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="673998968"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orsmga003.jf.intel.com with ESMTP; 18 Jul 2023 10:06:33 -0700
Subject: [PATCH] [v2] x86/mm: Remove "INVPCID single" feature tracking
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, jannh@google.com,
        x86@kernel.org, luto@kernel.org, peterz@infradead.org,
        andrew.cooper3@citrix.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Tue, 18 Jul 2023 10:06:30 -0700
Message-Id: <20230718170630.7922E235@davehans-spike.ostc.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


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

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reported-by: Jann Horn <jannh@google.com>
Cc: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
---

 b/arch/x86/include/asm/cpufeatures.h |    1 -
 b/arch/x86/mm/init.c                 |    9 ---------
 b/arch/x86/mm/tlb.c                  |   19 +++++++++++++------
 3 files changed, 13 insertions(+), 16 deletions(-)

diff -puN arch/x86/include/asm/cpufeatures.h~remove-invpcid-single arch/x86/include/asm/cpufeatures.h
--- a/arch/x86/include/asm/cpufeatures.h~remove-invpcid-single	2023-07-17 17:14:37.509036132 -0700
+++ b/arch/x86/include/asm/cpufeatures.h	2023-07-17 17:14:37.525036135 -0700
@@ -198,7 +198,6 @@
 #define X86_FEATURE_CAT_L3		( 7*32+ 4) /* Cache Allocation Technology L3 */
 #define X86_FEATURE_CAT_L2		( 7*32+ 5) /* Cache Allocation Technology L2 */
 #define X86_FEATURE_CDP_L3		( 7*32+ 6) /* Code and Data Prioritization L3 */
-#define X86_FEATURE_INVPCID_SINGLE	( 7*32+ 7) /* Effectively INVPCID && CR4.PCIDE=1 */
 #define X86_FEATURE_HW_PSTATE		( 7*32+ 8) /* AMD HW-PState */
 #define X86_FEATURE_PROC_FEEDBACK	( 7*32+ 9) /* AMD ProcFeedbackInterface */
 #define X86_FEATURE_XCOMPACTED		( 7*32+10) /* "" Use compacted XSTATE (XSAVES or XSAVEC) */
diff -puN arch/x86/mm/init.c~remove-invpcid-single arch/x86/mm/init.c
--- a/arch/x86/mm/init.c~remove-invpcid-single	2023-07-17 17:14:37.513036133 -0700
+++ b/arch/x86/mm/init.c	2023-07-17 17:14:37.525036135 -0700
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
diff -puN arch/x86/mm/tlb.c~remove-invpcid-single arch/x86/mm/tlb.c
--- a/arch/x86/mm/tlb.c~remove-invpcid-single	2023-07-17 17:14:37.517036133 -0700
+++ b/arch/x86/mm/tlb.c	2023-07-17 17:14:37.525036135 -0700
@@ -1140,21 +1140,28 @@ void flush_tlb_one_kernel(unsigned long
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
_
