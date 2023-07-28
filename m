Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19707767581
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 20:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjG1SeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 14:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjG1SeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 14:34:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21946423B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 11:34:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2E15621AD
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 18:34:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1DC1C433C8;
        Fri, 28 Jul 2023 18:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1690569253;
        bh=/ETXr35GlXt0lU8/LQjsLacBjCHt5zwDBcQ0Op7/lFs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YTsH65jzd0Sqntit8sAw82+9M0LlNChQHLbo/BlV9Dry+yXgUbPL84x5DOBlIIWUe
         0yybr65hMII/yjAywfknW/QPYesC8SOU6+XqDz7PCeRev3jPEmqpnJx66bSKtNe3Qz
         FwNrSadjqZD4xnnjrQxT4bRQYjaxVwEJZ3PxUgSs=
Date:   Fri, 28 Jul 2023 11:34:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yin Fengwei <fengwei.yin@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yuzhao@google.com, willy@infradead.org, david@redhat.com,
        ryan.roberts@arm.com, shy828301@gmail.com, hughd@google.com
Subject: Re: [PATCH 1/3] mm: add functions folio_in_range() and
 folio_within_vma()
Message-Id: <20230728113412.65741d2dd23228d0e2c0cb8d@linux-foundation.org>
In-Reply-To: <20230728070929.2487065-2-fengwei.yin@intel.com>
References: <20230728070929.2487065-1-fengwei.yin@intel.com>
        <20230728070929.2487065-2-fengwei.yin@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2023 15:09:27 +0800 Yin Fengwei <fengwei.yin@intel.com> wrote:

> It will be used to check whether the folio is mapped to specific
> VMA and whether the mapping address of folio is in the range.
> 
> Also a helper function folio_within_vma() to check whether folio
> is in the range of vma based on folio_in_range().
> 
> ...
>
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -585,6 +585,75 @@ extern long faultin_vma_page_range(struct vm_area_struct *vma,
>  				   bool write, int *locked);
>  extern bool mlock_future_ok(struct mm_struct *mm, unsigned long flags,
>  			       unsigned long bytes);
> +
> +/*
> + * Check whether the folio is in specific range
> + *
> + * First, check whether the folio is in the range of vma.
> + * Then, check whether the folio is mapped to the range of [start, end].
> + * In the end, check whether the folio is fully mapped to the range.
> + *
> + * @pte page table pointer will be checked whether the large folio
> + *      is fully mapped to. Currently, if mremap in the middle of
> + *      large folio, the large folio could be mapped to to different
> + *      VMA and address check can't identify this situation.
> + */
> +static inline bool
> +folio_in_range(struct folio *folio, struct vm_area_struct *vma,
> +		unsigned long start, unsigned long end, pte_t *pte)
> +{

This looks crazily way too large to be inlined?

> +	pte_t ptent;
> +	unsigned long i, nr = folio_nr_pages(folio);
> +	pgoff_t pgoff, addr;
> +	unsigned long vma_pglen = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
> +
> +	VM_WARN_ON_FOLIO(folio_test_ksm(folio), folio);
> +
> +	if (start < vma->vm_start)
> +		start = vma->vm_start;
> +	if (end > vma->vm_end)
> +		end = vma->vm_end;
> +
> +	pgoff = folio_pgoff(folio);
> +	/* if folio start address is not in vma range */
> +	if (pgoff < vma->vm_pgoff || pgoff > vma->vm_pgoff + vma_pglen)
> +		return false;
> +
> +	addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
> +	if (addr < start || end - addr < folio_size(folio))
> +		return false;
> +
> +	/* not necessary to check pte for none large folio */
> +	if (!folio_test_large(folio))
> +		return true;
> +
> +	if (!pte)
> +		return false;
> +
> +	/* check whether parameter pte is associated with folio */
> +	ptent = ptep_get(pte);
> +	if (pte_none(ptent) || !pte_present(ptent) ||
> +			pte_pfn(ptent) - folio_pfn(folio) >= nr)
> +		return false;
> +
> +	pte -= pte_pfn(ptent) - folio_pfn(folio);
> +	for (i = 0; i < nr; i++, pte++) {
> +		ptent = ptep_get(pte);
> +
> +		if (pte_none(ptent) || !pte_present(ptent) ||
> +				pte_pfn(ptent) - folio_pfn(folio) >= nr)
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +static inline bool
> +folio_within_vma(struct folio *folio, struct vm_area_struct *vma, pte_t *pte)
> +{
> +	return folio_in_range(folio, vma, vma->vm_start, vma->vm_end, pte);
> +}

And this doesn't.
