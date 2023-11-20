Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583C37F0AC1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 03:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbjKTC50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 21:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjKTC5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 21:57:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465C212D;
        Sun, 19 Nov 2023 18:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700449041; x=1731985041;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=sT/vTgYcrOwvk1VNI9b9F4OYgRzQaXbiy9iT8gGQsLs=;
  b=cMp8GbsLe8mFu8lOfyIE2wMml0YNmYjBp4QWJleWKzm+ih+v1OENhUcK
   3Z7mOXtt2bsQLHkgp1ndNAH6LpMi6NXwE1Nn1cSRLA1jrPwnrF943lZE/
   CEqy+YjEaUpL5op2rTpwaGvsvLwVa6IcLOhcmMcvYrmvhxPdu+BhFof6e
   U4Nbeh/IGokCEURZGUzEC3HKmVFkNJmn4WpxW6veW0FYR20lvGu5zRv3P
   xAPytj7hDT34UbctgW7ldhtvW5PWAigHlGC6OUMatCr6OX/R2vgFQv6bD
   9H2eDWffdTtZEHyGIJUIy3A9oLivHLiorEwdtSLBMrn+AyyAnCenfozH2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="477750089"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="477750089"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 18:57:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="742597924"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="742597924"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 18:57:17 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Luo Yuzhang <yuzhang.luo@intel.com>,
        Tony Zhu <tony.zhu@intel.com>, Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix incorrect cache invalidation for mm
 notification
In-Reply-To: <87edgll1up.fsf@nvdebian.thelocal> (Alistair Popple's message of
        "Mon, 20 Nov 2023 10:57:43 +1100")
References: <20231117090933.75267-1-baolu.lu@linux.intel.com>
        <87edgll1up.fsf@nvdebian.thelocal>
Date:   Mon, 20 Nov 2023 10:55:15 +0800
Message-ID: <877cmdcewc.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair Popple <apopple@nvidia.com> writes:

> Lu Baolu <baolu.lu@linux.intel.com> writes:
>
>> Commit 6bbd42e2df8f ("mmu_notifiers: call invalidate_range() when
>> invalidating TLBs") moved the secondary TLB invalidations into the TLB
>> invalidation functions to ensure that all secondary TLB invalidations
>> happen at the same time as the CPU invalidation and added a flush-all
>> type of secondary TLB invalidation for the batched mode, where a range
>> of [0, -1UL) is used to indicates that the range extends to the end of
>> the address space.
>>
>> However, using an end address of -1UL caused an overflow in the Intel
>> IOMMU driver, where the end address was rounded up to the next page.
>> As a result, both the IOTLB and device ATC were not invalidated correctly.
>
> Thanks for catching. This fix looks good so:
>
> Reviewed-by: Alistair Popple <apopple@nvidia.com>
>
> However examining the fixes patch again I note that we are calling
> mmu_notifier_invalidate_range(mm, 0, -1UL) from
> arch_tlbbatch_add_pending() in arch/x86/include/asm/tlbflush.h.
>
> That seems suboptimal because we would be doing an invalidate all for
> every page unmap,

Yes.  This can be performance regression for IOMMU TLB flushing.  For
CPU, it's "flush smaller ranges with more IPI" vs. "flush whole range
with less IPI", and in general the later wins because the high overhead
of IPI.  But, IIUC, for IOMMU TLB, it becomes "flush smaller ranges"
vs. "flush whole range".  That is generally bad.  It may be better to
restore the original behavior.  Can we just pass the size of TLB
flushing in set_tlb_ubc_flush_pending()->arch_tlbbatch_add_pending(),
and flush the IOMMU TLB for the range?

> and as of db6c1f6f236d ("mm/tlbbatch: introduce
> arch_flush_tlb_batched_pending()") arch_flush_tlb_batched_pending()
> calls flush_tlb_mm() anyway. So I think we can probably drop the
> explicit notifier call from arch_flush_tlb_batched_pending().

arch_flush_tlb_batched_pending() is used when we need to change page
table (e.g., munmap()) in parallel with TLB flushing batching (e.g.,
try_to_unmap()).  The actual TLB flushing part for
set_tlb_ubc_flush_pending()->arch_tlbbatch_add_pending() is
try_to_unmap_flush()->arch_tlbbatch_flush().

> Will put togeather a patch for that.
>
>  - Alistair
>
>> Add a flush all helper function and call it when the invalidation range
>> is from 0 to -1UL, ensuring that the entire caches are invalidated
>> correctly.
>>

[snip]

--
Best Regards,
Huang, Ying
