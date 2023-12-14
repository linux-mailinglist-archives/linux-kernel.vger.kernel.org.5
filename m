Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4192B812FD9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572952AbjLNMNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572930AbjLNMNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:13:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F08115
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:13:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E84BC433C7;
        Thu, 14 Dec 2023 12:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702556025;
        bh=zGI9MKm0R/y1myqJM3IMh1whT+Jpo0eTry8ctu4P1bE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZIl4tQ4tSkoE1FaBtknKS70y7rg0PHYdhs8pC5K0km1raen4r8b8buSTrlB/cQeS5
         V88CmYspZi4PyQ7fUpZk1k02eq8RZ9Lazj9PQ6GQB3OMdzr5/BWdRoXx4mzwa0Nw2u
         HJLI2chg1HTUpTbbQZNm66O6fqhzGQh4eyeyhZOcU4pbElBM+hwMZXajVWJZzfOZw5
         d8CnikTugVZdXY0UacDQpykecqCZLVHnxOHxyijCDVCzf6o1ioEjtNo/dpj4d3HJbC
         2AeWA7gxst5ON/uHCIS780fqlq6nWAjEExI5RDXm5i/5JQHQfDRf8q9o2JqlWZFm0i
         oVkGVEehtCQRQ==
Date:   Thu, 14 Dec 2023 12:13:36 +0000
From:   Will Deacon <will@kernel.org>
To:     Ryan Roberts <ryan.roberts@arm.com>, robin.murphy@arm.com,
        jean-philippe@linaro.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/15] arm64/mm: Split __flush_tlb_range() to elide
 trailing DSB
Message-ID: <20231214121336.GA1015@willie-the-truck>
References: <20231204105440.61448-1-ryan.roberts@arm.com>
 <20231204105440.61448-13-ryan.roberts@arm.com>
 <20231212113517.GA28857@willie-the-truck>
 <0969c413-bf40-4c46-9f1e-a92101ff2d2e@arm.com>
 <2e6f06d3-6c8e-4b44-b6f2-e55bd5be83d6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e6f06d3-6c8e-4b44-b6f2-e55bd5be83d6@arm.com>
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

On Thu, Dec 14, 2023 at 11:53:52AM +0000, Ryan Roberts wrote:
> On 12/12/2023 11:47, Ryan Roberts wrote:
> > On 12/12/2023 11:35, Will Deacon wrote:
> >> On Mon, Dec 04, 2023 at 10:54:37AM +0000, Ryan Roberts wrote:
> >>> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> >>> index bb2c2833a987..925ef3bdf9ed 100644
> >>> --- a/arch/arm64/include/asm/tlbflush.h
> >>> +++ b/arch/arm64/include/asm/tlbflush.h
> >>> @@ -399,7 +399,7 @@ do {									\
> >>>  #define __flush_s2_tlb_range_op(op, start, pages, stride, tlb_level) \
> >>>  	__flush_tlb_range_op(op, start, pages, stride, 0, tlb_level, false)
> >>>  
> >>> -static inline void __flush_tlb_range(struct vm_area_struct *vma,
> >>> +static inline void __flush_tlb_range_nosync(struct vm_area_struct *vma,
> >>>  				     unsigned long start, unsigned long end,
> >>>  				     unsigned long stride, bool last_level,
> >>>  				     int tlb_level)
> >>> @@ -431,10 +431,19 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
> >>>  	else
> >>>  		__flush_tlb_range_op(vae1is, start, pages, stride, asid, tlb_level, true);
> >>>  
> >>> -	dsb(ish);
> >>>  	mmu_notifier_arch_invalidate_secondary_tlbs(vma->vm_mm, start, end);
> >>>  }
> >>>  
> >>> +static inline void __flush_tlb_range(struct vm_area_struct *vma,
> >>> +				     unsigned long start, unsigned long end,
> >>> +				     unsigned long stride, bool last_level,
> >>> +				     int tlb_level)
> >>> +{
> >>> +	__flush_tlb_range_nosync(vma, start, end, stride,
> >>> +				 last_level, tlb_level);
> >>> +	dsb(ish);
> >>> +}
> >>
> >> Hmm, are you sure it's safe to defer the DSB until after the secondary TLB
> >> invalidation? It will have a subtle effect on e.g. an SMMU participating
> >> in broadcast TLB maintenance, because now the ATC will be invalidated
> >> before completion of the TLB invalidation and it's not obviously safe to me.
> > 
> > I'll be honest; I don't know that it's safe. The notifier calls turned up during
> > a rebase and I stared at it for a while, before eventually concluding that I
> > should just follow the existing pattern in __flush_tlb_page_nosync(): That one
> > calls the mmu notifier without the dsb, then flush_tlb_page() does the dsb
> > after. So I assumed it was safe.
> > 
> > If you think it's not safe, I guess there is a bug to fix in
> > __flush_tlb_page_nosync()?
> 
> Did you have an opinion on this? I'm just putting together a v4 of this series,
> and I'll remove this optimization if you think it's unsound. But in that case, I
> guess we have an existing bug to fix too?

Sorry, Ryan, I've not had a chance to look into it in more detail. But as
you rightly point out, you're not introducing the issue (assuming it is
one), so I don't think it needs to hold you up. Your code just makes the
thing more "obvious" to me.

Robin, Jean-Philippe -- do we need to make sure that the SMMU has completed
its TLB invalidation before issuing an ATC invalidate? My half-baked worry
is whether or not an ATS request could refill the ATC before the TLBI
has completed, therefore rendering the ATC invalidation useless.

Will
