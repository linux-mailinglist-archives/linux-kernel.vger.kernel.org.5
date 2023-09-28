Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286D77B1666
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjI1Isf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjI1IsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:48:18 -0400
Received: from out-191.mta1.migadu.com (out-191.mta1.migadu.com [95.215.58.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD371AB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:48:07 -0700 (PDT)
Message-ID: <3ee9c8e4-870c-4ab0-906a-7d214031d1a6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695890885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+EEA0IoyLM9MJW6bKO28aRoeqNlmd1duJHWiiZqz/yg=;
        b=YAMhQ45Bj/uy05JBo0RQYm/3kZjaQm4hC3Rdj6SkYN9dRTWltdHRrVqCwk04/pSOat/oEL
        Xuoejak/dmkC/X98pRIf97no+3bWXf1RN7OmHMM+Yy2SkZqrjMUIfBURA8tCta/8aOEbxP
        MWnIFotEFxWSMfoihPDTZWadkJ1aIE0=
Date:   Thu, 28 Sep 2023 16:47:59 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] memblock: don't run loop in memblock_add_range() twice
To:     Mike Rapoport <rppt@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230927013752.2515238-1-yajun.deng@linux.dev>
 <20230928061619.GS3303@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <20230928061619.GS3303@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/9/28 14:16, Mike Rapoport wrote:
> On Wed, Sep 27, 2023 at 09:37:52AM +0800, Yajun Deng wrote:
>> There is round twice in memblock_add_range(). The first counts the number
>> of regions needed to accommodate the new area. The second actually inserts
>> them. But the first round isn't really needed, we just need to check the
>> counts before inserting them.
>>
>> Check the count before calling memblock_insert_region(). If the count is
>> equal to the maximum value, it needs to resize the array. Otherwise,
>> insert it directly.
>>
>> To avoid nested calls to memblock_add_range(), we need to call
>> memblock_reserve() out of memblock_double_array().
> memblock_add_range() does an extra loop once in a while, but I don't think
> removing it will have any actual effect on the boot time.


Yes, it has no obvious actual effect on the boot time,  but it does 
reduce the number of unnecessary loop.

The actual effect on the boot time should not be the only criterion for 
whether a patch is accepted or not.

Since the comment in the previous code, it tells the user that it would 
be executed twice, this can be

misleading to users.

So the new code will be simpler and clearer. It not just change the 
code, but also remove the comment

about "executed twice",  it obviously tells the user only resize the 
array if it is equal to the maximum value

and doesn't need to be executed twice.

>   
>> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
>> ---
>>   mm/memblock.c | 117 ++++++++++++++++++++++++--------------------------
>>   1 file changed, 57 insertions(+), 60 deletions(-)
>>
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index 5a88d6d24d79..3f44c84f5d0b 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -400,6 +400,8 @@ void __init memblock_discard(void)
>>    * @type: memblock type of the regions array being doubled
>>    * @new_area_start: starting address of memory range to avoid overlap with
>>    * @new_area_size: size of memory range to avoid overlap with
>> + * @new_reserve_base: starting address of new array
>> + * @new_reserve_size: size of new array
>>    *
>>    * Double the size of the @type regions array. If memblock is being used to
>>    * allocate memory for a new reserved regions array and there is a previously
>> @@ -412,7 +414,9 @@ void __init memblock_discard(void)
>>    */
>>   static int __init_memblock memblock_double_array(struct memblock_type *type,
>>   						phys_addr_t new_area_start,
>> -						phys_addr_t new_area_size)
>> +						phys_addr_t new_area_size,
>> +						phys_addr_t *new_reserve_base,
>> +						phys_addr_t *new_reserve_size)
>>   {
>>   	struct memblock_region *new_array, *old_array;
>>   	phys_addr_t old_alloc_size, new_alloc_size;
>> @@ -490,11 +494,13 @@ static int __init_memblock memblock_double_array(struct memblock_type *type,
>>   		memblock_free(old_array, old_alloc_size);
>>   
>>   	/*
>> -	 * Reserve the new array if that comes from the memblock.  Otherwise, we
>> -	 * needn't do it
>> +	 * Keep the address and size if that comes from the memblock. Otherwise,
>> +	 * we needn't do it.
>>   	 */
>> -	if (!use_slab)
>> -		BUG_ON(memblock_reserve(addr, new_alloc_size));
>> +	if (!use_slab) {
>> +		*new_reserve_base = addr;
>> +		*new_reserve_size = new_alloc_size;
>> +	}
>>   
>>   	/* Update slab flag */
>>   	*in_slab = use_slab;
>> @@ -588,11 +594,12 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>>   				phys_addr_t base, phys_addr_t size,
>>   				int nid, enum memblock_flags flags)
>>   {
>> -	bool insert = false;
>>   	phys_addr_t obase = base;
>>   	phys_addr_t end = base + memblock_cap_size(base, &size);
>> -	int idx, nr_new, start_rgn = -1, end_rgn;
>> +	phys_addr_t new_base = 0, new_size;
>> +	int idx, start_rgn = -1, end_rgn;
>>   	struct memblock_region *rgn;
>> +	unsigned long ocnt = type->cnt;
>>   
>>   	if (!size)
>>   		return 0;
>> @@ -608,25 +615,6 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>>   		return 0;
>>   	}
>>   
>> -	/*
>> -	 * The worst case is when new range overlaps all existing regions,
>> -	 * then we'll need type->cnt + 1 empty regions in @type. So if
>> -	 * type->cnt * 2 + 1 is less than or equal to type->max, we know
>> -	 * that there is enough empty regions in @type, and we can insert
>> -	 * regions directly.
>> -	 */
>> -	if (type->cnt * 2 + 1 <= type->max)
>> -		insert = true;
>> -
>> -repeat:
>> -	/*
>> -	 * The following is executed twice.  Once with %false @insert and
>> -	 * then with %true.  The first counts the number of regions needed
>> -	 * to accommodate the new area.  The second actually inserts them.
>> -	 */
>> -	base = obase;
>> -	nr_new = 0;
>> -
>>   	for_each_memblock_type(idx, type, rgn) {
>>   		phys_addr_t rbase = rgn->base;
>>   		phys_addr_t rend = rbase + rgn->size;
>> @@ -644,15 +632,23 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>>   			WARN_ON(nid != memblock_get_region_node(rgn));
>>   #endif
>>   			WARN_ON(flags != rgn->flags);
>> -			nr_new++;
>> -			if (insert) {
>> -				if (start_rgn == -1)
>> -					start_rgn = idx;
>> -				end_rgn = idx + 1;
>> -				memblock_insert_region(type, idx++, base,
>> -						       rbase - base, nid,
>> -						       flags);
>> -			}
>> +
>> +			/*
>> +			 * If type->cnt is equal to type->max, it means there's
>> +			 * not enough empty region and the array needs to be
>> +			 * resized. Otherwise, insert it directly.
>> +			 */
>> +			if ((type->cnt == type->max) &&
>> +			    memblock_double_array(type, obase, size,
>> +						  &new_base, &new_size))
>> +				return -ENOMEM;
>> +
>> +			if (start_rgn == -1)
>> +				start_rgn = idx;
>> +			end_rgn = idx + 1;
>> +			memblock_insert_region(type, idx++, base,
>> +					       rbase - base, nid,
>> +					       flags);
>>   		}
>>   		/* area below @rend is dealt with, forget about it */
>>   		base = min(rend, end);
>> @@ -660,33 +656,28 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>>   
>>   	/* insert the remaining portion */
>>   	if (base < end) {
>> -		nr_new++;
>> -		if (insert) {
>> -			if (start_rgn == -1)
>> -				start_rgn = idx;
>> -			end_rgn = idx + 1;
>> -			memblock_insert_region(type, idx, base, end - base,
>> -					       nid, flags);
>> -		}
>> +		if ((type->cnt == type->max) &&
>> +		    memblock_double_array(type, obase, size,
>> +					  &new_base, &new_size))
>> +			return -ENOMEM;
>> +
>> +		if (start_rgn == -1)
>> +			start_rgn = idx;
>> +		end_rgn = idx + 1;
>> +		memblock_insert_region(type, idx, base, end - base,
>> +				       nid, flags);
>>   	}
>>   
>> -	if (!nr_new)
>> +	if (ocnt == type->cnt)
>>   		return 0;
>>   
>> -	/*
>> -	 * If this was the first round, resize array and repeat for actual
>> -	 * insertions; otherwise, merge and return.
>> -	 */
>> -	if (!insert) {
>> -		while (type->cnt + nr_new > type->max)
>> -			if (memblock_double_array(type, obase, size) < 0)
>> -				return -ENOMEM;
>> -		insert = true;
>> -		goto repeat;
>> -	} else {
>> -		memblock_merge_regions(type, start_rgn, end_rgn);
>> -		return 0;
>> -	}
>> +	memblock_merge_regions(type, start_rgn, end_rgn);
>> +
>> +	/* Reserve the new array */
>> +	if (new_base)
>> +		memblock_reserve(new_base, new_size);
>> +
>> +	return 0;
>>   }
>>   
>>   /**
>> @@ -755,6 +746,7 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
>>   					int *start_rgn, int *end_rgn)
>>   {
>>   	phys_addr_t end = base + memblock_cap_size(base, &size);
>> +	phys_addr_t new_base = 0, new_size;
>>   	int idx;
>>   	struct memblock_region *rgn;
>>   
>> @@ -764,10 +756,15 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
>>   		return 0;
>>   
>>   	/* we'll create at most two more regions */
>> -	while (type->cnt + 2 > type->max)
>> -		if (memblock_double_array(type, base, size) < 0)
>> +	if (type->cnt + 2 > type->max) {
>> +		if (memblock_double_array(type, base, size,
>> +					  &new_base, &new_size))
>>   			return -ENOMEM;
>>   
>> +		if (new_base)
>> +			memblock_reserve(new_base, new_size);
>> +	}
>> +
>>   	for_each_memblock_type(idx, type, rgn) {
>>   		phys_addr_t rbase = rgn->base;
>>   		phys_addr_t rend = rbase + rgn->size;
>> -- 
>> 2.25.1
>>
