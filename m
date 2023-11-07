Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627307E34FE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 06:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbjKGFuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 00:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjKGFuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 00:50:03 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E47A3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 21:49:59 -0800 (PST)
Received: from [100.98.85.67] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2899F6607416;
        Tue,  7 Nov 2023 05:49:49 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699336198;
        bh=a7cbHZCm1c4UiZ5kaQejOf6gAuCYT2P4dGU7Oi3E1L4=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=RWFq5DNsknmMAn8Q3LQ3EGsTXSGbtOISt7jN9sUi7Ir4Jeg1y7yh6QkRunHmbENS0
         K1nrkXz6KU+pe5fnxKCEwuemPR0g4N4H/jj3jCsphJu0l81Gr1Z7sWkvEHZOam/GBk
         65aHPCGcGOoNA0Q4KldeFk2gmY2cCsnDxqNrUZDhPk4IOgL6Y8fuVGNS9e6DxFBGPz
         DDHb9zRQupcmdieY9fddARd1brZhYnPtQq3BmO+iGwCCgpCfqDiSnFsnv2GFs8G/sd
         4KbAXl/14aX7GwnCjCZTRX7YRBdGHqadubp5F/N4CWviWCvZ7TqpEaed35bZIdabkX
         AOB1iJx023DCA==
Message-ID: <cd766ac3-ea80-4445-873a-c03902d579ad@collabora.com>
Date:   Tue, 7 Nov 2023 10:49:42 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH 1/2 v2] fs/proc/task_mmu: report SOFT_DIRTY bits through
 the PAGEMAP_SCAN ioctl
Content-Language: en-US
To:     Andrei Vagin <avagin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20231106220959.296568-1-avagin@google.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20231106220959.296568-1-avagin@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/23 3:09 AM, Andrei Vagin wrote:
> The PAGEMAP_SCAN ioctl returns information regarding page table entries.
> It is more efficient compared to reading pagemap files. CRIU can start
> to utilize this ioctl, but it needs info about soft-dirty bits to track
> memory changes.
> 
> We are aware of a new method for tracking memory changes implemented in
> the PAGEMAP_SCAN ioctl. For CRIU, the primary advantage of this method
> is its usability by unprivileged users. However, it is not feasible to
> transparently replace the soft-dirty tracker with the new one. The main
> problem here is userfault descriptors that have to be preserved between
> pre-dump iterations.  It means criu continues supporting the soft-dirty
> method to avoid breakage for current users. The new method will be
> implemented as a separate feature.
> 
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Cc: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Andrei Vagin <avagin@google.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
> v2: check the soft-dirty bit in pagemap_page_category
> 
>  Documentation/admin-guide/mm/pagemap.rst |  1 +
>  fs/proc/task_mmu.c                       | 17 ++++++++++++++++-
>  include/uapi/linux/fs.h                  |  1 +
>  3 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
> index fe17cf210426..f5f065c67615 100644
> --- a/Documentation/admin-guide/mm/pagemap.rst
> +++ b/Documentation/admin-guide/mm/pagemap.rst
> @@ -253,6 +253,7 @@ Following flags about pages are currently supported:
>  - ``PAGE_IS_SWAPPED`` - Page is in swapped
>  - ``PAGE_IS_PFNZERO`` - Page has zero PFN
>  - ``PAGE_IS_HUGE`` - Page is THP or Hugetlb backed
> +- ``PAGE_IS_SOFT_DIRTY`` - Page is soft-dirty
>  
>  The ``struct pm_scan_arg`` is used as the argument of the IOCTL.
>  
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index ef2eb12906da..51e0ec658457 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1761,7 +1761,7 @@ static int pagemap_release(struct inode *inode, struct file *file)
>  #define PM_SCAN_CATEGORIES	(PAGE_IS_WPALLOWED | PAGE_IS_WRITTEN |	\
>  				 PAGE_IS_FILE |	PAGE_IS_PRESENT |	\
>  				 PAGE_IS_SWAPPED | PAGE_IS_PFNZERO |	\
> -				 PAGE_IS_HUGE)
> +				 PAGE_IS_HUGE | PAGE_IS_SOFT_DIRTY)
>  #define PM_SCAN_FLAGS		(PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC)
>  
>  struct pagemap_scan_private {
> @@ -1793,6 +1793,8 @@ static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
>  
>  		if (is_zero_pfn(pte_pfn(pte)))
>  			categories |= PAGE_IS_PFNZERO;
> +		if (pte_soft_dirty(pte))
> +			categories |= PAGE_IS_SOFT_DIRTY;
>  	} else if (is_swap_pte(pte)) {
>  		swp_entry_t swp;
>  
> @@ -1806,6 +1808,8 @@ static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
>  			    !PageAnon(pfn_swap_entry_to_page(swp)))
>  				categories |= PAGE_IS_FILE;
>  		}
> +		if (pte_swp_soft_dirty(pte))
> +			categories |= PAGE_IS_SOFT_DIRTY;
>  	}
>  
>  	return categories;
> @@ -1853,12 +1857,16 @@ static unsigned long pagemap_thp_category(struct pagemap_scan_private *p,
>  
>  		if (is_zero_pfn(pmd_pfn(pmd)))
>  			categories |= PAGE_IS_PFNZERO;
> +		if (pmd_soft_dirty(pmd))
> +			categories |= PAGE_IS_SOFT_DIRTY;
>  	} else if (is_swap_pmd(pmd)) {
>  		swp_entry_t swp;
>  
>  		categories |= PAGE_IS_SWAPPED;
>  		if (!pmd_swp_uffd_wp(pmd))
>  			categories |= PAGE_IS_WRITTEN;
> +		if (pmd_swp_soft_dirty(pmd))
> +			categories |= PAGE_IS_SOFT_DIRTY;
>  
>  		if (p->masks_of_interest & PAGE_IS_FILE) {
>  			swp = pmd_to_swp_entry(pmd);
> @@ -1905,10 +1913,14 @@ static unsigned long pagemap_hugetlb_category(pte_t pte)
>  			categories |= PAGE_IS_FILE;
>  		if (is_zero_pfn(pte_pfn(pte)))
>  			categories |= PAGE_IS_PFNZERO;
> +		if (pte_soft_dirty(pte))
> +			categories |= PAGE_IS_SOFT_DIRTY;
>  	} else if (is_swap_pte(pte)) {
>  		categories |= PAGE_IS_SWAPPED;
>  		if (!pte_swp_uffd_wp_any(pte))
>  			categories |= PAGE_IS_WRITTEN;
> +		if (pte_swp_soft_dirty(pte))
> +			categories |= PAGE_IS_SOFT_DIRTY;
>  	}
>  
>  	return categories;
> @@ -1991,6 +2003,9 @@ static int pagemap_scan_test_walk(unsigned long start, unsigned long end,
>  	if (vma->vm_flags & VM_PFNMAP)
>  		return 1;
>  
> +	if (vma->vm_flags & VM_SOFTDIRTY)
> +		vma_category |= PAGE_IS_SOFT_DIRTY;
> +
>  	if (!pagemap_scan_is_interesting_vma(vma_category, p))
>  		return 1;
>  
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index da43810b7485..48ad69f7722e 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -316,6 +316,7 @@ typedef int __bitwise __kernel_rwf_t;
>  #define PAGE_IS_SWAPPED		(1 << 4)
>  #define PAGE_IS_PFNZERO		(1 << 5)
>  #define PAGE_IS_HUGE		(1 << 6)
> +#define PAGE_IS_SOFT_DIRTY	(1 << 7)
LGTM, other than the missed the identical change in
tools/include/uapi/linux/fs.h as well.

>  
>  /*
>   * struct page_region - Page region with flags

-- 
BR,
Muhammad Usama Anjum
