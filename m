Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5A77AA62C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 02:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjIVAlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 20:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjIVAlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 20:41:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357F0122
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 17:41:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A0BC433C7;
        Fri, 22 Sep 2023 00:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1695343262;
        bh=ExRSCnGt1+LvU7aTW4BdNID7cAJK0i+xGNIGDddqWHg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lOgm4RgGlSadIeaywU2c+CCkhmM7XNG4eiHd0+j/v4dzibaE5OLHscFcAe5/uXvMq
         VohFm2rM4c6LFEt3UOsZK4+t5Kx9PCX+5i5a3LgJNRxhs+n5CL7BmMpR7SPbY2nET0
         teDp0aI5/PzNkAGoSCKNLTaLisOv4NZHEazMfSz8=
Date:   Thu, 21 Sep 2023 17:41:01 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jiexun Wang <wangjiexun@tinylab.org>
Cc:     brauner@kernel.org, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tangjinyu@tinylab.org
Subject: Re: [PATCH v2 1/1] mm/madvise: add cond_resched() in
 madvise_cold_or_pageout_pte_range()
Message-Id: <20230921174101.8e6271422a857af5414ce0a0@linux-foundation.org>
In-Reply-To: <85363861af65fac66c7a98c251906afc0d9c8098.1695291046.git.wangjiexun@tinylab.org>
References: <cover.1695291046.git.wangjiexun@tinylab.org>
        <85363861af65fac66c7a98c251906afc0d9c8098.1695291046.git.wangjiexun@tinylab.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2023 20:27:51 +0800 Jiexun Wang <wangjiexun@tinylab.org> wrote:

> Currently the madvise_cold_or_pageout_pte_range() function exhibits 
> significant latency under memory pressure, which can be effectively 
> reduced by adding cond_resched() within the loop.
> 
> When the batch_count reaches SWAP_CLUSTER_MAX, we reschedule 
> the task to ensure fairness and avoid long lock holding times.
> 
> ...
>
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -354,6 +354,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  	struct folio *folio = NULL;
>  	LIST_HEAD(folio_list);
>  	bool pageout_anon_only_filter;
> +	unsigned int batch_count = 0;
>  
>  	if (fatal_signal_pending(current))
>  		return -EINTR;
> @@ -433,6 +434,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  regular_folio:
>  #endif
>  	tlb_change_page_size(tlb, PAGE_SIZE);
> +restart:
>  	start_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);

The handling of start_pte looks OK.

>  	if (!start_pte)
>  		return 0;
> @@ -441,6 +443,15 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  	for (; addr < end; pte++, addr += PAGE_SIZE) {
>  		ptent = ptep_get(pte);
>  
> +		if (++batch_count == SWAP_CLUSTER_MAX) {
> +			batch_count = 0;
> +			if (need_resched()) {
> +				pte_unmap_unlock(start_pte, ptl);
> +				cond_resched();
> +				goto restart;
> +			}
> +		}
> +
>  		if (pte_none(ptent))
>  			continue;
>  

I think this patch looks OK, but would appreciate careful review from
others, please.

