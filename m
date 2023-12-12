Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8C580EA77
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjLLLfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjLLLfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:35:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B353BCD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 03:35:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A08C433C7;
        Tue, 12 Dec 2023 11:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702380926;
        bh=Pob5Ge2gFIJG7Q0aQ/vTG1K/p3ucC0PSIOzsvYWOUOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ChlUuItjd2gyTeqVgCQDk6fs8gtd16Kn8Oa3hq1KQzsfcuMRdXOO94YGbS6d5rrtZ
         BIHf3nUh3dH7CNtKK8gAKoXCsANL6oDpEQ2BhHM6yakdd320Tcejtf3TfUzKQM3gfA
         18OY+N62lKSXe+hmmqQCRvVphdJzXtnDQ8n8izElVjsmny2rNvVd/+ei6Wnkuz6US5
         GTNZvoLtx7xOdkB15mZ1bbde96IYyYuwN/mNJiVxSsw7KC6kAZ5WLZ0eHhrOzRa2X9
         /9RE21fot+BNmpRpDI8ZajgjLklP0liEfU2d8VJ2EEywo6wLZ23gCYIcrY3hy08OMP
         BDjmon0SElTXQ==
Date:   Tue, 12 Dec 2023 11:35:17 +0000
From:   Will Deacon <will@kernel.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
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
Message-ID: <20231212113517.GA28857@willie-the-truck>
References: <20231204105440.61448-1-ryan.roberts@arm.com>
 <20231204105440.61448-13-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204105440.61448-13-ryan.roberts@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 10:54:37AM +0000, Ryan Roberts wrote:
> Split __flush_tlb_range() into __flush_tlb_range_nosync() +
> __flush_tlb_range(), in the same way as the existing flush_tlb_page()
> arrangement. This allows calling __flush_tlb_range_nosync() to elide the
> trailing DSB. Forthcoming "contpte" code will take advantage of this
> when clearing the young bit from a contiguous range of ptes.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  arch/arm64/include/asm/tlbflush.h | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index bb2c2833a987..925ef3bdf9ed 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -399,7 +399,7 @@ do {									\
>  #define __flush_s2_tlb_range_op(op, start, pages, stride, tlb_level) \
>  	__flush_tlb_range_op(op, start, pages, stride, 0, tlb_level, false)
>  
> -static inline void __flush_tlb_range(struct vm_area_struct *vma,
> +static inline void __flush_tlb_range_nosync(struct vm_area_struct *vma,
>  				     unsigned long start, unsigned long end,
>  				     unsigned long stride, bool last_level,
>  				     int tlb_level)
> @@ -431,10 +431,19 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
>  	else
>  		__flush_tlb_range_op(vae1is, start, pages, stride, asid, tlb_level, true);
>  
> -	dsb(ish);
>  	mmu_notifier_arch_invalidate_secondary_tlbs(vma->vm_mm, start, end);
>  }
>  
> +static inline void __flush_tlb_range(struct vm_area_struct *vma,
> +				     unsigned long start, unsigned long end,
> +				     unsigned long stride, bool last_level,
> +				     int tlb_level)
> +{
> +	__flush_tlb_range_nosync(vma, start, end, stride,
> +				 last_level, tlb_level);
> +	dsb(ish);
> +}

Hmm, are you sure it's safe to defer the DSB until after the secondary TLB
invalidation? It will have a subtle effect on e.g. an SMMU participating
in broadcast TLB maintenance, because now the ATC will be invalidated
before completion of the TLB invalidation and it's not obviously safe to me.

Will
