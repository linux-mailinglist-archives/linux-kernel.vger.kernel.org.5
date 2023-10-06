Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98537BB6AA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjJFLlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbjJFLlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:41:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11B5DB
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 04:41:00 -0700 (PDT)
Received: from [192.168.100.7] (unknown [39.34.184.141])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4D75C6612A7A;
        Fri,  6 Oct 2023 12:40:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696592459;
        bh=ZDyYuG9iSvl4sm1CTET1n1lNwYdeHLIPj4SXX+NUK/4=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=hTcn1xm8hsOadKSXGJ7C16RQBesuRfTM+rbFhkg0MhpPV7TbjMG82uTihjmH4Iqmb
         wktBPSS7ZVIab05IHstdZaZCxO0HC+yV0VGAhknzWhXW/UHDe6dvHR75bgW4J0jsiQ
         DsfIahZU0ggwi1WUFXVgohISM4URzSgWLlT1P0JFIUXRQfhhAe2N1AJ9UlGeSeBJDG
         0YxwHUYaDMxRTJA1EHeAUuIO2hgmyjcGBIraZcVtXz5KxMnZeDEKjho0e2dML78f3f
         fP2/Ggmzw8Fsyaz2b3i2UlWRCsyTQX/QkhdyOAbTrTU7Bwva98IQqTGjb5tNK2hVEl
         q5EkrWCFTkuQg==
Message-ID: <6cee3838-1807-4983-9d7f-b3a30ee30563@collabora.com>
Date:   Fri, 6 Oct 2023 16:40:53 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel@collabora.com, Paul Gofman <pgofman@codeweavers.com>
Subject: Re: [PATCH v33 3/6] fs/proc/task_mmu: Add fast paths to get/clear
 PAGE_IS_WRITTEN flag
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>
References: <20230821141518.870589-1-usama.anjum@collabora.com>
 <20230821141518.870589-4-usama.anjum@collabora.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20230821141518.870589-4-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

You picked up all the other patches in this series except this one. Thank
you so much. I'm unable to find any comment on why this wasn't picked or
maybe you missed it?

Please let me know what you think.

Regards,
Usama

On 8/21/23 7:15 PM, Muhammad Usama Anjum wrote:
> Adding fast code paths to handle specifically only get and/or clear
> operation of PAGE_IS_WRITTEN, increases its performance by 0-35%.
> The results of some test cases are given below:
> 
> Test-case-1
> t1 = (Get + WP) time
> t2 = WP time
>                        t1            t2
> Without this patch:    140-170mcs    90-115mcs
> With this patch:       110mcs        80mcs
> Worst case diff:       35% faster    30% faster
> 
> Test-case-2
> t3 = atomic Get and WP
>                       t3
> Without this patch:   120-140mcs
> With this patch:      100-110mcs
> Worst case diff:      21% faster
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> The test to measure the performance can be found: https://is.gd/FtSKcD
> 8 8192 3 1 0 and 8 8192 3 1 1 arguments have been used to produce the
> above mentioned results.
> 
> Changes in v29:
> - Minor updates in flush logic following the original patch
> ---
>  fs/proc/task_mmu.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 6e6261e8b91b1..79cf023148b28 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -2138,6 +2138,41 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
>  		return 0;
>  	}
>  
> +	if (!p->vec_out) {
> +		/* Fast path for performing exclusive WP */
> +		for (addr = start; addr != end; pte++, addr += PAGE_SIZE) {
> +			if (pte_uffd_wp(ptep_get(pte)))
> +				continue;
> +			make_uffd_wp_pte(vma, addr, pte);
> +			if (!flush_end)
> +				start = addr;
> +			flush_end = addr + PAGE_SIZE;
> +		}
> +		goto flush_and_return;
> +	}
> +
> +	if (!p->arg.category_anyof_mask && !p->arg.category_inverted &&
> +	    p->arg.category_mask == PAGE_IS_WRITTEN &&
> +	    p->arg.return_mask == PAGE_IS_WRITTEN) {
> +		for (addr = start; addr < end; pte++, addr += PAGE_SIZE) {
> +			unsigned long next = addr + PAGE_SIZE;
> +
> +			if (pte_uffd_wp(ptep_get(pte)))
> +				continue;
> +			ret = pagemap_scan_output(p->cur_vma_category | PAGE_IS_WRITTEN,
> +						  p, addr, &next);
> +			if (next == addr)
> +				break;
> +			if (~p->arg.flags & PM_SCAN_WP_MATCHING)
> +				continue;
> +			make_uffd_wp_pte(vma, addr, pte);
> +			if (!flush_end)
> +				start = addr;
> +			flush_end = next;
> +		}
> +		goto flush_and_return;
> +	}
> +
>  	for (addr = start; addr != end; pte++, addr += PAGE_SIZE) {
>  		unsigned long categories = p->cur_vma_category |
>  					   pagemap_page_category(p, vma, addr, ptep_get(pte));
> @@ -2161,6 +2196,7 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
>  		flush_end = next;
>  	}
>  
> +flush_and_return:
>  	if (flush_end)
>  		flush_tlb_range(vma, start, addr);
>  

-- 
BR,
Muhammad Usama Anjum
