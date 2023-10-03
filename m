Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348857B5E77
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 03:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238913AbjJCBLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 21:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJCBLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 21:11:07 -0400
Received: from out-209.mta0.migadu.com (out-209.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D513DB4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 18:11:02 -0700 (PDT)
Message-ID: <685ece42-e62b-86e9-a4b3-805c5d4b9047@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696295459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Y+M8W22DJ+iYV3T19lMhzDKTMIOgxq9NtsM1yyB2PE=;
        b=QQzvgV4dExR6cGX025t9kOEfoooPBrxNDMn8PwZ9kEnuUxx+9Zz+CU1gvtrzkpvPvihfou
        is6tRTIBu1OqNdCYWOczc5JLOyxpz0cQYX/2FumvjlW+dKqOfoKwZt5CYg++3FiUqCnv2e
        kb9puGjk2ZcfveCW1zBBfWkagVIqLrc=
Date:   Tue, 3 Oct 2023 09:10:53 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2] memblock: don't run loop in memblock_add_range() twice
Content-Language: en-US
To:     rppt@kernel.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20231002105652.2514182-1-yajun.deng@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <20231002105652.2514182-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry, there is a bug in this version, please ignore it.

On 2023/10/2 18:56, Yajun Deng wrote:
> There is round twice in memblock_add_range(). The first counts the number
> of regions needed to accommodate the new area. The second actually inserts
> them. But the first round isn't really needed, we just need to check the
> counts before inserting them.
>
> Check the count before iterate memblock. If the count is equal to the
> maximum, it needs to resize the array. Otherwise, insert it directly.
> After that, it's similar logic to memblock_isolate_range.
>
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
> v2: remove the changes of memblock_double_array.
> v1: https://lore.kernel.org/all/20230927013752.2515238-1-yajun.deng@linux.dev/
> ---
>   mm/memblock.c | 75 +++++++++++++++++----------------------------------
>   1 file changed, 24 insertions(+), 51 deletions(-)
>
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 5a88d6d24d79..655d8e82f90a 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -588,11 +588,11 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>   				phys_addr_t base, phys_addr_t size,
>   				int nid, enum memblock_flags flags)
>   {
> -	bool insert = false;
>   	phys_addr_t obase = base;
>   	phys_addr_t end = base + memblock_cap_size(base, &size);
> -	int idx, nr_new, start_rgn = -1, end_rgn;
> +	int idx, start_rgn = -1, end_rgn;
>   	struct memblock_region *rgn;
> +	unsigned long ocnt = type->cnt;
>   
>   	if (!size)
>   		return 0;
> @@ -609,23 +609,13 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>   	}
>   
>   	/*
> -	 * The worst case is when new range overlaps all existing regions,
> -	 * then we'll need type->cnt + 1 empty regions in @type. So if
> -	 * type->cnt * 2 + 1 is less than or equal to type->max, we know
> -	 * that there is enough empty regions in @type, and we can insert
> -	 * regions directly.
> +	 * If type->cnt is equal to type->max, it means there's
> +	 * not enough empty region and the array needs to be
> +	 * resized. Otherwise, insert it directly.
>   	 */
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
> +	if ((type->cnt == type->max) &&
> +	    memblock_double_array(type, obase, size))
> +		return -ENOMEM;
>   
>   	for_each_memblock_type(idx, type, rgn) {
>   		phys_addr_t rbase = rgn->base;
> @@ -644,15 +634,13 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>   			WARN_ON(nid != memblock_get_region_node(rgn));
>   #endif
>   			WARN_ON(flags != rgn->flags);
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
> +			if (start_rgn == -1)
> +				start_rgn = idx;
> +			end_rgn = idx + 1;
> +			memblock_insert_region(type, idx++, base,
> +					       rbase - base, nid,
> +					       flags);
>   		}
>   		/* area below @rend is dealt with, forget about it */
>   		base = min(rend, end);
> @@ -660,33 +648,18 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>   
>   	/* insert the remaining portion */
>   	if (base < end) {
> -		nr_new++;
> -		if (insert) {
> -			if (start_rgn == -1)
> -				start_rgn = idx;
> -			end_rgn = idx + 1;
> -			memblock_insert_region(type, idx, base, end - base,
> -					       nid, flags);
> -		}
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
>   		memblock_merge_regions(type, start_rgn, end_rgn);
> -		return 0;
> -	}
> +
> +	return 0;
>   }
>   
>   /**
