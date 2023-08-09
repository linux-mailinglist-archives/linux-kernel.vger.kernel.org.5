Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F007768CA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjHITe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjHITeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:34:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40A1AC6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 12:34:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C405D75;
        Wed,  9 Aug 2023 12:35:07 -0700 (PDT)
Received: from [10.57.79.142] (unknown [10.57.79.142])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CA3A3F6C4;
        Wed,  9 Aug 2023 12:34:22 -0700 (PDT)
Message-ID: <241cb5d6-0941-4dbb-9d16-9226d34ebaf8@arm.com>
Date:   Wed, 9 Aug 2023 20:34:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mm: add functions folio_in_range() and
 folio_within_vma()
Content-Language: en-GB
To:     Yin Fengwei <fengwei.yin@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        yuzhao@google.com, willy@infradead.org, hughd@google.com,
        yosryahmed@google.com, david@redhat.com, shy828301@gmail.com
References: <20230809061105.3369958-1-fengwei.yin@intel.com>
 <20230809061105.3369958-2-fengwei.yin@intel.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230809061105.3369958-2-fengwei.yin@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2023 07:11, Yin Fengwei wrote:
> It will be used to check whether the folio is mapped to specific
> VMA and whether the mapping address of folio is in the range.
> 
> Also a helper function folio_within_vma() to check whether folio
> is in the range of vma based on folio_in_range().
> 
> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
> ---
>  mm/internal.h | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 154da4f0d557..5d1b71010fd2 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -585,6 +585,41 @@ extern long faultin_vma_page_range(struct vm_area_struct *vma,
>  				   bool write, int *locked);
>  extern bool mlock_future_ok(struct mm_struct *mm, unsigned long flags,
>  			       unsigned long bytes);
> +
> +static inline bool
> +folio_in_range(struct folio *folio, struct vm_area_struct *vma,
> +		unsigned long start, unsigned long end)

I still think it would be beneficial to have a comment block describing the
requirements and behaviour of the function:

 - folio must have at least 1 page that is mapped in vma
 - the result tells you if the folio lies within the range, but it does not tell
you that all of its pages are actually _mapped_ (e.g. they may not have been
faulted in yet).

 - I think [start, end) is intended intersect with the vma too? (although I'm
pretty sure sure the logic works if it doesn't?)

> +{
> +	pgoff_t pgoff, addr;
> +	unsigned long vma_pglen = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
> +
> +	VM_WARN_ON_FOLIO(folio_test_ksm(folio), folio);
> +	if (start > end)
> +		return false;
> +
> +	if (start < vma->vm_start)
> +		start = vma->vm_start;
> +
> +	if (end > vma->vm_end)
> +		end = vma->vm_end;
> +
> +	pgoff = folio_pgoff(folio);
> +
> +	/* if folio start address is not in vma range */
> +	if (!in_range(pgoff, vma->vm_pgoff, vma_pglen))
> +		return false;
> +
> +	addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
> +
> +	return !(addr < start || end - addr < folio_size(folio));
> +}
> +
> +static inline bool
> +folio_within_vma(struct folio *folio, struct vm_area_struct *vma)

why call this *within* but call the folio_in_range() *in*? Feels cleaner to use
the same word for both.

> +{
> +	return folio_in_range(folio, vma, vma->vm_start, vma->vm_end);
> +}
> +
>  /*
>   * mlock_vma_folio() and munlock_vma_folio():
>   * should be called with vma's mmap_lock held for read or write,

