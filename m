Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B1D7912E5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 10:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343841AbjIDIFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 04:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjIDIFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 04:05:02 -0400
Received: from out-224.mta0.migadu.com (out-224.mta0.migadu.com [IPv6:2001:41d0:1004:224b::e0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90480AF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 01:04:58 -0700 (PDT)
Date:   Mon, 4 Sep 2023 01:04:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693814695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0c78/Vw77wG1oSc9kfQWh12B2uzKbfL46NwHOfEcqkI=;
        b=pUIrlFOxEJrFZ8QSNBEkyNhbSL0JC3kvm/0brqPSiL/ExEMtm5n7qNMJCKs8NFpEiYR1im
        /wDTA4KI1fNMHpLZ4sWgg6h0+uqsrv86vqTdGZ53WOMMDQloIs4nsDfC61MYJoZIhAK4wk
        rzbrOYexXn1edtJgXOVgeCYRkS9fdyE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
        maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org,
        qperret@google.com, ricarkol@google.com, tabba@google.com,
        bgardon@google.com, zhenyzha@redhat.com, yihyu@redhat.com,
        shan.gavin@gmail.com
Subject: Re: [PATCH] KVM: arm64: Fix soft-lockup on relaxing PTE permission
Message-ID: <ZPWPoEgBETeI1um1@linux.dev>
References: <20230904072826.1468907-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904072826.1468907-1-gshan@redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gavin,

On Mon, Sep 04, 2023 at 05:28:26PM +1000, Gavin Shan wrote:
> We observed soft-lockup on the host in a specific scenario where
> the host on Ampere's Altra Max CPU has 64KB base page size and the
> guest has 4KB base page size, 64 vCPUs and 13GB memory. The guest's
> memory is backed by 512MB huge pages via hugetlbfs. All the 64 vCPUs
> are simultaneously trapped into the host due to permission page faults,
> to request adding the execution permission to the corresponding PMD
> entry, before the soft-lockup is raised on the host. On handling the
> parallel requests, the instruction cache for the 512MB huge page is
> invalidated by mm_ops->icache_inval_pou() in stage2_attr_walker() on
> 64 hardware CPUs. Unfortunately, the instruction cache invalidation
> on one CPU interfere with that on another CPU in the hardware level.
> It takes 37 seconds for mm_ops->icache_inval_pou() to finish in the
> worst case.
> 
> So we can't scale out to handle the permission faults at will. They
> need to be serialized to some extent with the help of a interval tree,

Parallel permission faults is not the cause of the soft lockups
you observe. The real issue is the volume of invalidations that are
happening under the hood.

Take a look at __invalidate_icache_guest_page() -- we invalidate the
icache by VA regardless of the size of the range. 512M / 64b = 8388608
invalidation operations. Yes, multiple threads doing these invalidations
in parallel makes the issue more pronounced as they bottleneck at the
Miscellaneous node in the interconnect, but we should really do
something about our invalidation strategy instead.

The approach you propose adds a fairly complex serialization mechanic
_and_ unfairly penalizes systems that do not require explicit icache
invalidation (i.e. FEAT_DIC).

I have a patch for the invalidation issue that I've been needing to
send out for a while, could you please give this a go and see if it
addresses the soft lockups you observe? If so, I can clean it up and
send it as a patch. At minimum, MAX_TLBI_OPS needs to be renamed to hint
at the common thread (DVM) between I$ and TLB invalidations.

--
Thanks,
Oliver

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 96a80e8f6226..fd23644c9988 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -117,6 +117,7 @@ alternative_cb_end
 #include <asm/cache.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
+#include <asm/tlbflush.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_host.h>
 
@@ -224,15 +225,38 @@ static inline void __clean_dcache_guest_page(void *va, size_t size)
 	kvm_flush_dcache_to_poc(va, size);
 }
 
+static inline u32 __icache_line_size(void)
+{
+	u8 iminline;
+	u64 ctr;
+
+	asm volatile(ALTERNATIVE_CB("movz %0, #0\n"
+				    "movk %0, #0, lsl #16\n"
+				    "movk %0, #0, lsl #32\n"
+				    "movk %0, #0, lsl #48\n",
+				    ARM64_ALWAYS_SYSTEM,
+				    kvm_compute_final_ctr_el0)
+		     : "=r" (ctr));
+
+	iminline = SYS_FIELD_GET(CTR_EL0, IminLine, ctr);
+	return 4 << iminline;
+}
+
 static inline void __invalidate_icache_guest_page(void *va, size_t size)
 {
+	size_t nr_lines = size / __icache_line_size();
+
 	if (icache_is_aliasing()) {
 		/* any kind of VIPT cache */
 		icache_inval_all_pou();
 	} else if (read_sysreg(CurrentEL) != CurrentEL_EL1 ||
 		   !icache_is_vpipt()) {
 		/* PIPT or VPIPT at EL2 (see comment in __kvm_tlb_flush_vmid_ipa) */
-		icache_inval_pou((unsigned long)va, (unsigned long)va + size);
+		if (nr_lines > MAX_TLBI_OPS)
+			icache_inval_all_pou();
+		else
+			icache_inval_pou((unsigned long)va,
+					 (unsigned long)va + size);
 	}
 }
 
