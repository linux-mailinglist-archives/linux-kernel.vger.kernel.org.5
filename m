Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8E97DCC03
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343986AbjJaLmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343751AbjJaLmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:42:01 -0400
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE0E97
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 04:41:55 -0700 (PDT)
Message-ID: <057353e0-7000-4fe5-a64c-092001ae3883@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698752513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V76Lq4/to2avfqg3j/SuDvEqroCLg6n33KMDEeYM7Y8=;
        b=XJ9H5E4idUHxUYq+YkvPLwK1jcW5HcAqSBHMhQlJPY+Y5N6LAqRNDy1G5mYS3Lz8XkIihY
        2Y++ZScfA2T8HG+BfAuGezU8z3EuqNtYg7dePzjAaxFe/ItvvSVXN8blVvzDdid/HNh1z5
        aXSdP0iDFo1EhlGnCaSkdrktBYSrdSo=
Date:   Tue, 31 Oct 2023 19:41:22 +0800
MIME-Version: 1.0
Subject: Re: [RFC PATCH v3 7/7] slub: Optimize deactivate_slab()
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, cl@linux.com, penberg@kernel.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231024093345.3676493-1-chengming.zhou@linux.dev>
 <20231024093345.3676493-8-chengming.zhou@linux.dev>
 <9db65a8d-9f0d-e8ab-55e4-4197dfc54032@suse.cz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <9db65a8d-9f0d-e8ab-55e4-4197dfc54032@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/31 19:15, Vlastimil Babka wrote:
> On 10/24/23 11:33, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> Since the introduce of unfrozen slabs on cpu partial list, we don't
>> need to synchronize the slab frozen state under the node list_lock.
>>
>> The caller of deactivate_slab() and the caller of __slab_free() won't
>> manipulate the slab list concurrently.
>>
>> So we can get node list_lock in the last stage if we really need to
>> manipulate the slab list in this path.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Nice simplification!
> 
>> ---
>>  mm/slub.c | 70 ++++++++++++++++++++-----------------------------------
>>  1 file changed, 25 insertions(+), 45 deletions(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 486d44421432..64d550e415eb 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -2449,10 +2449,8 @@ static void init_kmem_cache_cpus(struct kmem_cache *s)
>>  static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
>>  			    void *freelist)
>>  {
>> -	enum slab_modes { M_NONE, M_PARTIAL, M_FREE, M_FULL_NOLIST };
>>  	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
>>  	int free_delta = 0;
>> -	enum slab_modes mode = M_NONE;
>>  	void *nextfree, *freelist_iter, *freelist_tail;
>>  	int tail = DEACTIVATE_TO_HEAD;
>>  	unsigned long flags = 0;
>> @@ -2499,58 +2497,40 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
>>  	 * unfrozen and number of objects in the slab may have changed.
>>  	 * Then release lock and retry cmpxchg again.
>>  	 */
> 
> This comment above (including parts not visible here) should be updated as
> there is no more list manipulation during unfreeze.

Right!

> 
>> -redo:
>> -
>> -	old.freelist = READ_ONCE(slab->freelist);
>> -	old.counters = READ_ONCE(slab->counters);
>> -	VM_BUG_ON(!old.frozen);
>> -
>> -	/* Determine target state of the slab */
>> -	new.counters = old.counters;
>> -	if (freelist_tail) {
>> -		new.inuse -= free_delta;
>> -		set_freepointer(s, freelist_tail, old.freelist);
>> -		new.freelist = freelist;
>> -	} else
>> -		new.freelist = old.freelist;
>> +	do {
>> +		old.freelist = READ_ONCE(slab->freelist);
>> +		old.counters = READ_ONCE(slab->counters);
>> +		VM_BUG_ON(!old.frozen);
>> +
>> +		/* Determine target state of the slab */
>> +		new.counters = old.counters;
>> +		new.frozen = 0;
>> +		if (freelist_tail) {
>> +			new.inuse -= free_delta;
>> +			set_freepointer(s, freelist_tail, old.freelist);
>> +			new.freelist = freelist;
>> +		} else
>> +			new.freelist = old.freelist;
> 
> Per coding style we should have the else with { } even if it's one line, to
> match the if branch. Since we touch the code that was previously violating
> the style, we can fix up.

Ok, I will fix all these.

Big thanks for your review!

> 
>>  
>> -	new.frozen = 0;
>> +	} while (!slab_update_freelist(s, slab,
>> +		old.freelist, old.counters,
>> +		new.freelist, new.counters,
>> +		"unfreezing slab"));
>>  
>> +	/*
>> +	 * Stage three: Manipulate the slab list based on the updated state.
>> +	 */
>>  	if (!new.inuse && n->nr_partial >= s->min_partial) {
>> -		mode = M_FREE;
>> +		stat(s, DEACTIVATE_EMPTY);
>> +		discard_slab(s, slab);
>> +		stat(s, FREE_SLAB);
>>  	} else if (new.freelist) {
>> -		mode = M_PARTIAL;
>> -		/*
>> -		 * Taking the spinlock removes the possibility that
>> -		 * acquire_slab() will see a slab that is frozen
>> -		 */
>>  		spin_lock_irqsave(&n->list_lock, flags);
>> -	} else {
>> -		mode = M_FULL_NOLIST;
>> -	}
>> -
>> -
>> -	if (!slab_update_freelist(s, slab,
>> -				old.freelist, old.counters,
>> -				new.freelist, new.counters,
>> -				"unfreezing slab")) {
>> -		if (mode == M_PARTIAL)
>> -			spin_unlock_irqrestore(&n->list_lock, flags);
>> -		goto redo;
>> -	}
>> -
>> -
>> -	if (mode == M_PARTIAL) {
>>  		add_partial(n, slab, tail);
>>  		spin_unlock_irqrestore(&n->list_lock, flags);
>>  		stat(s, tail);
>> -	} else if (mode == M_FREE) {
>> -		stat(s, DEACTIVATE_EMPTY);
>> -		discard_slab(s, slab);
>> -		stat(s, FREE_SLAB);
>> -	} else if (mode == M_FULL_NOLIST) {
>> +	} else
>>  		stat(s, DEACTIVATE_FULL);
>> -	}
> 
> Same here.
> 
> Thanks!
> 
>>  }
>>  
>>  #ifdef CONFIG_SLUB_CPU_PARTIAL
> 
