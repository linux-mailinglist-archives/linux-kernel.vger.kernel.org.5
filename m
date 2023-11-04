Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB227E0E0F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 07:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjKDGJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 02:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjKDGJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 02:09:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADEBD4C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 23:09:24 -0700 (PDT)
Received: from [100.98.85.67] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9E5826607413;
        Sat,  4 Nov 2023 06:09:21 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699078162;
        bh=G/GaJjDya/fLTXGC5dp+Xj68bRYVj9L1edFwNi6kOkY=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=YrWcctDwO9a7LcfrVPjqGYfnbSiD4y1R209aa9KUFRad6haouajJIZZS4LAFXi4pT
         /7GqdOTSMy4Aag3mxmKaaAeHSDeHamNooVhp7j2adVql6frajEoWmsLBDkENz/KJ+U
         yoPa4sIIKUbmcIZgLiR1jodKXCb123+tALjVJh3BffcJRWkniNfj+CrYIq6akKDUHF
         e2gz9lsXSRJJBXAB3sfqG3KdGSQ+pm0ZkQGwBC2HppP/UUIDFD5dy1uyZ0ruUsdZI2
         eBF6HIRiTI7DMrmjk2RjUIH0hJIk6aQEjDk7Q8xatCYiQwKAW3vdJIgEf0Bi6xvO8I
         fsZbGfvVtaftQ==
Message-ID: <102e7f6c-5c99-407f-8696-dd71efcc16f6@collabora.com>
Date:   Sat, 4 Nov 2023 11:09:17 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH] fs/proc/task_mmu: report SOFT_DIRTY bits through the
 PAGEMAP_SCAN ioctl
To:     Andrei Vagin <avagin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20231102173357.446157-1-avagin@google.com>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20231102173357.446157-1-avagin@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/23 10:33 PM, Andrei Vagin wrote:
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
> ---
>  fs/proc/task_mmu.c      | 13 ++++++++++++-
>  include/uapi/linux/fs.h |  1 +
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index ef2eb12906da..cefa676bd33b 100644
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
> @@ -1853,12 +1853,16 @@ static unsigned long pagemap_thp_category(struct pagemap_scan_private *p,
Probably missed the pagemap_page_category() for normal pages. Add
PAGE_IS_SOFT_DIRTY support for normal pages in pagemap_page_category() just
like pagemap_thp_category().

tools/testing/selftests/mm/soft-dirty.c can be updated to test if we are
getting the exactly same data from the ioctl.

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
> @@ -1905,10 +1909,14 @@ static unsigned long pagemap_hugetlb_category(pte_t pte)
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
> @@ -1991,6 +1999,9 @@ static int pagemap_scan_test_walk(unsigned long start, unsigned long end,
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
Add this identical change in tools/include/uapi/linux/fs.h as well.

> @@ -316,6 +316,7 @@ typedef int __bitwise __kernel_rwf_t;
>  #define PAGE_IS_SWAPPED		(1 << 4)
>  #define PAGE_IS_PFNZERO		(1 << 5)
>  #define PAGE_IS_HUGE		(1 << 6)
> +#define PAGE_IS_SOFT_DIRTY	(1 << 7)
Maybe one or couple of lines about it in the pagemap.rst.

>  
>  /*
>   * struct page_region - Page region with flags

-- 
BR,
Muhammad Usama Anjum
