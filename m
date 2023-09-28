Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01917B1286
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjI1GRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjI1GRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:17:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452D9A3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 23:17:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42109C433C7;
        Thu, 28 Sep 2023 06:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695881833;
        bh=ukat4gmI11KeKATmcvfP0ZvCM+9QAk5epXbZZWdQNfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eaKPAt1sY0P8Dj6RhjFZZXKiB73ZiPj1b1lm2m8PR8XRC42+M7Pc2GTSYp7wAo+rL
         c0M/kcy/w/OSYXT9ZjF+s4WfpxwA1l3SDpUfg4pAUSEfz2cdxFsILqvfpfWXznUH77
         icyk50oQLP4a+tcu41CxixgOzv161zjVzt+pbpNbyvor/r5nnpU4H+qPWeEBBCF/U7
         lSV3CZXNeU+xIsD2BByogESSqUb7iQWP55I49Cv6iZoxaAiBe1j1H7qV54zsAGK6Ki
         lgiWxAZjbbhkL4EaDy0tjQEFwjQseM+Ab1rVOK87YhUJTsYM73wSd9TMeAFJilv/Ni
         TIYZETpht74GQ==
Date:   Thu, 28 Sep 2023 09:16:19 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memblock: don't run loop in memblock_add_range() twice
Message-ID: <20230928061619.GS3303@kernel.org>
References: <20230927013752.2515238-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927013752.2515238-1-yajun.deng@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 09:37:52AM +0800, Yajun Deng wrote:
> There is round twice in memblock_add_range(). The first counts the number
> of regions needed to accommodate the new area. The second actually inserts
> them. But the first round isn't really needed, we just need to check the
> counts before inserting them.
> 
> Check the count before calling memblock_insert_region(). If the count is
> equal to the maximum value, it needs to resize the array. Otherwise,
> insert it directly.
> 
> To avoid nested calls to memblock_add_range(), we need to call
> memblock_reserve() out of memblock_double_array().

memblock_add_range() does an extra loop once in a while, but I don't think
removing it will have any actual effect on the boot time.
 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>  mm/memblock.c | 117 ++++++++++++++++++++++++--------------------------
>  1 file changed, 57 insertions(+), 60 deletions(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 5a88d6d24d79..3f44c84f5d0b 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -400,6 +400,8 @@ void __init memblock_discard(void)
>   * @type: memblock type of the regions array being doubled
>   * @new_area_start: starting address of memory range to avoid overlap with
>   * @new_area_size: size of memory range to avoid overlap with
> + * @new_reserve_base: starting address of new array
> + * @new_reserve_size: size of new array
>   *
>   * Double the size of the @type regions array. If memblock is being used to
>   * allocate memory for a new reserved regions array and there is a previously
> @@ -412,7 +414,9 @@ void __init memblock_discard(void)
>   */
>  static int __init_memblock memblock_double_array(struct memblock_type *type,
>  						phys_addr_t new_area_start,
> -						phys_addr_t new_area_size)
> +						phys_addr_t new_area_size,
> +						phys_addr_t *new_reserve_base,
> +						phys_addr_t *new_reserve_size)
>  {
>  	struct memblock_region *new_array, *old_array;
>  	phys_addr_t old_alloc_size, new_alloc_size;
> @@ -490,11 +494,13 @@ static int __init_memblock memblock_double_array(struct memblock_type *type,
>  		memblock_free(old_array, old_alloc_size);
>  
>  	/*
> -	 * Reserve the new array if that comes from the memblock.  Otherwise, we
> -	 * needn't do it
> +	 * Keep the address and size if that comes from the memblock. Otherwise,
> +	 * we needn't do it.
>  	 */
> -	if (!use_slab)
> -		BUG_ON(memblock_reserve(addr, new_alloc_size));
> +	if (!use_slab) {
> +		*new_reserve_base = addr;
> +		*new_reserve_size = new_alloc_size;
> +	}
>  
>  	/* Update slab flag */
>  	*in_slab = use_slab;
> @@ -588,11 +594,12 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>  				phys_addr_t base, phys_addr_t size,
>  				int nid, enum memblock_flags flags)
>  {
> -	bool insert = false;
>  	phys_addr_t obase = base;
>  	phys_addr_t end = base + memblock_cap_size(base, &size);
> -	int idx, nr_new, start_rgn = -1, end_rgn;
> +	phys_addr_t new_base = 0, new_size;
> +	int idx, start_rgn = -1, end_rgn;
>  	struct memblock_region *rgn;
> +	unsigned long ocnt = type->cnt;
>  
>  	if (!size)
>  		return 0;
> @@ -608,25 +615,6 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
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
> @@ -644,15 +632,23 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
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
> -			}
> +
> +			/*
> +			 * If type->cnt is equal to type->max, it means there's
> +			 * not enough empty region and the array needs to be
> +			 * resized. Otherwise, insert it directly.
> +			 */
> +			if ((type->cnt == type->max) &&
> +			    memblock_double_array(type, obase, size,
> +						  &new_base, &new_size))
> +				return -ENOMEM;
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
> @@ -660,33 +656,28 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
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
> -		}
> +		if ((type->cnt == type->max) &&
> +		    memblock_double_array(type, obase, size,
> +					  &new_base, &new_size))
> +			return -ENOMEM;
> +
> +		if (start_rgn == -1)
> +			start_rgn = idx;
> +		end_rgn = idx + 1;
> +		memblock_insert_region(type, idx, base, end - base,
> +				       nid, flags);
>  	}
>  
> -	if (!nr_new)
> +	if (ocnt == type->cnt)
>  		return 0;
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
> -		memblock_merge_regions(type, start_rgn, end_rgn);
> -		return 0;
> -	}
> +	memblock_merge_regions(type, start_rgn, end_rgn);
> +
> +	/* Reserve the new array */
> +	if (new_base)
> +		memblock_reserve(new_base, new_size);
> +
> +	return 0;
>  }
>  
>  /**
> @@ -755,6 +746,7 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
>  					int *start_rgn, int *end_rgn)
>  {
>  	phys_addr_t end = base + memblock_cap_size(base, &size);
> +	phys_addr_t new_base = 0, new_size;
>  	int idx;
>  	struct memblock_region *rgn;
>  
> @@ -764,10 +756,15 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
>  		return 0;
>  
>  	/* we'll create at most two more regions */
> -	while (type->cnt + 2 > type->max)
> -		if (memblock_double_array(type, base, size) < 0)
> +	if (type->cnt + 2 > type->max) {
> +		if (memblock_double_array(type, base, size,
> +					  &new_base, &new_size))
>  			return -ENOMEM;
>  
> +		if (new_base)
> +			memblock_reserve(new_base, new_size);
> +	}
> +
>  	for_each_memblock_type(idx, type, rgn) {
>  		phys_addr_t rbase = rgn->base;
>  		phys_addr_t rend = rbase + rgn->size;
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
