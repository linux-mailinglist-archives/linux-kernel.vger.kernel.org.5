Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CA67E388A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbjKGKMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 05:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjKGKMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:12:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E07BD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 02:12:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C351C433CB;
        Tue,  7 Nov 2023 10:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699351947;
        bh=y9FfIgwd+1z4W/hXtdouBcIf3syzmsHUs8UbFh9GrRY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FEMrcBpmVAZPEUpoDRtVydDNhsKOFOzZh59NstRt2tkZ8Vi1A8sjRQDPvCAieE6Ef
         HNyTpNW+M6Lxv7CokklY0WGv33hBj2LS2IjxKca8R6dEL0ffa7S7DodpgrrE1b5OiC
         L7Cn0m9BOFR40PMFSDm85v5nJEy6hMNR166YPfVLiPo5kUFZgCioS2eSZ0IJIK2JYm
         kv8QeKZ4hEn1mhrGnWxc+xtTu8QXzwyF7S84Crt/R6gdI/w/zTWJhUqfbABWTGfSji
         cMzB8QwL0teO+2Zy9IVUTQ9DyGUrmc2ja3ex34h+X6nYFsBQ+1pkLWNb4HoI00hn8m
         e6M6KIK8Ut0xA==
Date:   Tue, 7 Nov 2023 10:12:21 +0000
From:   Will Deacon <will@kernel.org>
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     Barry Song <21cnbao@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        catalin.marinas@arm.com, akpm@linux-foundation.org,
        v-songbaohua@oppo.com, yuzhao@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: drop tlb flush operation when clearing the
 access bit
Message-ID: <20231107101221.GB18944@willie-the-truck>
References: <ae3115778a3fa10ec77152e18beed54fafe0f6e7.1698151516.git.baolin.wang@linux.alibaba.com>
 <CAGsJ_4zgdAmyU-075jd8KfXn=CdAVC8Rs481sCOd5N2a68yPUg@mail.gmail.com>
 <44e32b0e-0e41-4055-bdb9-15bc7d47197c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44e32b0e-0e41-4055-bdb9-15bc7d47197c@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 09:39:19AM +0800, Yin, Fengwei wrote:
> 
> >> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> >> index 0bd18de9fd97..2979d796ba9d 100644
> >> --- a/arch/arm64/include/asm/pgtable.h
> >> +++ b/arch/arm64/include/asm/pgtable.h
> >> @@ -905,21 +905,22 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
> >>  static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
> >>                                          unsigned long address, pte_t *ptep)
> >>  {
> >> -       int young = ptep_test_and_clear_young(vma, address, ptep);
> >> -
> >> -       if (young) {
> >> -               /*
> >> -                * We can elide the trailing DSB here since the worst that can
> >> -                * happen is that a CPU continues to use the young entry in its
> >> -                * TLB and we mistakenly reclaim the associated page. The
> >> -                * window for such an event is bounded by the next
> >> -                * context-switch, which provides a DSB to complete the TLB
> >> -                * invalidation.
> >> -                */
> >> -               flush_tlb_page_nosync(vma, address);
> >> -       }
> >> -
> >> -       return young;
> >> +       /*
> >> +        * This comment is borrowed from x86, but applies equally to ARM64:
> >> +        *
> >> +        * Clearing the accessed bit without a TLB flush doesn't cause
> >> +        * data corruption. [ It could cause incorrect page aging and
> >> +        * the (mistaken) reclaim of hot pages, but the chance of that
> >> +        * should be relatively low. ]
> >> +        *
> >> +        * So as a performance optimization don't flush the TLB when
> >> +        * clearing the accessed bit, it will eventually be flushed by
> >> +        * a context switch or a VM operation anyway. [ In the rare
> >> +        * event of it not getting flushed for a long time the delay
> >> +        * shouldn't really matter because there's no real memory
> >> +        * pressure for swapout to react to. ]
> >> +        */
> >> +       return ptep_test_and_clear_young(vma, address, ptep);
> >>  }
> From https://lore.kernel.org/lkml/20181029105515.GD14127@arm.com/:
> 
> This is blindly copied from x86 and isn't true for us: we don't invalidate
> the TLB on context switch. That means our window for keeping the stale
> entries around is potentially much bigger and might not be a great idea.

I completely agree.

> My understanding is that arm64 doesn't do invalidate the TLB during
> context switch. The flush_tlb_page_nosync() here + DSB during context
> switch make sure the TLB is invalidated during context switch.
> So we can't remove flush_tlb_page_nosync() here? Or something was changed
> for arm64 (I have zero knowledge to TLB on arm64. So some obvious thing
> may be missed)? Thanks.

As you point out, we already elide the DSB here but I don't think we should
remove the TLB invalidation entirely because then we lose the guarantee
that the update ever becomes visible to the page-table walker.

I'm surprised that the TLBI is showing up as a performance issue without
the DSB present. Is it because we're walking over a large VA range and
invalidating on a per-page basis? If so, we'd be better off batching them
up and doing the invalidation at the end (which will be upgraded to a
full-mm invalidation if the range is large enough).

Will
