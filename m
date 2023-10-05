Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692907BA27B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbjJEPjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbjJEPig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:38:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF317E23B
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:52:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0865C433D9;
        Thu,  5 Oct 2023 05:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696483263;
        bh=Qs4busUPBNGM91WL2UH8yfpZT3a7HgW1HG6pgpfmcRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fNJFsH5p9c+uR7GS34KCmB/3qXqajGl4JgK7gXkzguFeyULnUsIbJpItYLHtlhWcC
         XI2dVoLVmFkeYkynqktUio6MexCUiERvWBlm2Myuu1Pne62gSWUKKVlp5/+N6G+GaB
         DE+nor54oqUJMfivCjzEI733al48+ZDpe17M15URxExTmQhiixC1vWHXF7YMFVf6m8
         Ay1Mr7Ro35G59TP9RL1vI5OsZr/pKUC1D6822PxxA80waokFeIu1Bvm5cYdur9LMwd
         iY0WChPvASZ3UtwvhHr4+gaFghk9/bs9/fFeTzeD6CuExVp76P37tr/kF1yWpWwZTE
         cGH9Aty1Thy0w==
Date:   Thu, 5 Oct 2023 08:19:59 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] memblock: don't run loop in memblock_add_range() twice
Message-ID: <20231005051959.GC3303@kernel.org>
References: <20231003163045.191184-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003163045.191184-1-yajun.deng@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 12:30:45AM +0800, Yajun Deng wrote:
> There is round twice in memblock_add_range(). The first counts the number
> of regions needed to accommodate the new area. The second actually inserts
> them. But the first round isn't really needed, we just need to check the
> counts before inserting them.
> 
> Check the count before memblock_insert_region. If the count is equal to
> the maximum, it needs to resize the array. Otherwise, insert it directly.
> 
> Also, there is a nested call here, we need to reserve the current array
> immediately if slab is unavailable.

I presume this fixes a bug you found in v2, but are you sure it'll _never_
explode on a machine with different memory layout and different sequence of
memblock_reservee() calls?

I don't see this micro-optimization is worth the churn and potential bugs.
NAK.
 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
> v3: reserve the current array immediately if slab is unavailable.
> v2: remove the changes of memblock_double_array.
> v1: https://lore.kernel.org/all/20230927013752.2515238-1-yajun.deng@linux.dev/
> ---
>  mm/memblock.c | 93 +++++++++++++++++++++++----------------------------
>  1 file changed, 41 insertions(+), 52 deletions(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 5a88d6d24d79..71449c0b8bc8 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -588,11 +588,12 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>  				phys_addr_t base, phys_addr_t size,
>  				int nid, enum memblock_flags flags)
>  {
> -	bool insert = false;
>  	phys_addr_t obase = base;
>  	phys_addr_t end = base + memblock_cap_size(base, &size);
> -	int idx, nr_new, start_rgn = -1, end_rgn;
> +	int idx, start_rgn = -1, end_rgn;
>  	struct memblock_region *rgn;
> +	int use_slab = slab_is_available();
> +	unsigned long ocnt = type->cnt;
>  
>  	if (!size)
>  		return 0;
> @@ -608,25 +609,6 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>  		return 0;
>  	}
>  
> -	/*
> -	 * The worst case is when new range overlaps all existing regions,
> -	 * then we'll need type->cnt + 1 empty regions in @type. So if
> -	 * type->cnt * 2 + 1 is less than or equal to type->max, we know
> -	 * that there is enough empty regions in @type, and we can insert
> -	 * regions directly.
> -	 */
> -	if (type->cnt * 2 + 1 <= type->max)
> -		insert = true;
> -
> -repeat:
> -	/*
> -	 * The following is executed twice.  Once with %false @insert and
> -	 * then with %true.  The first counts the number of regions needed
> -	 * to accommodate the new area.  The second actually inserts them.
> -	 */
> -	base = obase;
> -	nr_new = 0;
> -
>  	for_each_memblock_type(idx, type, rgn) {
>  		phys_addr_t rbase = rgn->base;
>  		phys_addr_t rend = rbase + rgn->size;
> @@ -644,15 +626,30 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>  			WARN_ON(nid != memblock_get_region_node(rgn));
>  #endif
>  			WARN_ON(flags != rgn->flags);
> -			nr_new++;
> -			if (insert) {
> -				if (start_rgn == -1)
> -					start_rgn = idx;
> -				end_rgn = idx + 1;
> -				memblock_insert_region(type, idx++, base,
> -						       rbase - base, nid,
> -						       flags);
> +
> +			/*
> +			 * If type->cnt is equal to type->max, it means there's
> +			 * not enough empty region and the array needs to be
> +			 * resized. Otherwise, insert it directly.
> +			 *
> +			 * If slab is unavailable, it means a new array was reserved
> +			 * in memblock_double_array. There is a nested call here, We
> +			 * need to reserve the current array now if its type is
> +			 * reserved.
> +			 */
> +			if (type->cnt == type->max) {
> +				if (memblock_double_array(type, obase, size))
> +					return -ENOMEM;
> +				else if (!use_slab && type == &memblock.reserved)
> +					return memblock_reserve(obase, size);
>  			}
> +
> +			if (start_rgn == -1)
> +				start_rgn = idx;
> +			end_rgn = idx + 1;
> +			memblock_insert_region(type, idx++, base,
> +					       rbase - base, nid,
> +					       flags);
>  		}
>  		/* area below @rend is dealt with, forget about it */
>  		base = min(rend, end);
> @@ -660,33 +657,25 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>  
>  	/* insert the remaining portion */
>  	if (base < end) {
> -		nr_new++;
> -		if (insert) {
> -			if (start_rgn == -1)
> -				start_rgn = idx;
> -			end_rgn = idx + 1;
> -			memblock_insert_region(type, idx, base, end - base,
> -					       nid, flags);
> +
> +		if (type->cnt == type->max) {
> +			if (memblock_double_array(type, obase, size))
> +				return -ENOMEM;
> +			else if (!use_slab && type == &memblock.reserved)
> +				return memblock_reserve(obase, size);
>  		}
> -	}
>  
> -	if (!nr_new)
> -		return 0;
> +		if (start_rgn == -1)
> +			start_rgn = idx;
> +		end_rgn = idx + 1;
> +		memblock_insert_region(type, idx, base, end - base,
> +				       nid, flags);
> +	}
>  
> -	/*
> -	 * If this was the first round, resize array and repeat for actual
> -	 * insertions; otherwise, merge and return.
> -	 */
> -	if (!insert) {
> -		while (type->cnt + nr_new > type->max)
> -			if (memblock_double_array(type, obase, size) < 0)
> -				return -ENOMEM;
> -		insert = true;
> -		goto repeat;
> -	} else {
> +	if (ocnt != type->cnt)
>  		memblock_merge_regions(type, start_rgn, end_rgn);
> -		return 0;
> -	}
> +
> +	return 0;
>  }
>  
>  /**
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
