Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281987D45A4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjJXCla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjJXCl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:41:29 -0400
Received: from out-205.mta1.migadu.com (out-205.mta1.migadu.com [95.215.58.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB9D11A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 19:41:23 -0700 (PDT)
Message-ID: <217c52ba-3b06-488d-b21a-3d2dd62438a8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698115281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DTMaBMJj10j72PXuCPyuHbqbaXnXbH7yMFP0YeQy5dU=;
        b=F7ahZY0dgoGIXkXYwFWekobD2zj7iTWYeiV7CLbeNV3qlWmjg9gT2ga1RcqKl5j3b8qvfE
        3wzHyH9RmBW5BAPpvmLdu1339yHmL7YU9Lek9g/ptbinj3bWPwyT0hlYQqv8+0pqATAK5+
        xxx08X/QjBGzzhxEWrbW0wWTekZ67kw=
Date:   Tue, 24 Oct 2023 10:39:37 +0800
MIME-Version: 1.0
Subject: Re: [RFC PATCH v2 3/6] slub: Don't freeze slabs for cpu partial
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, cl@linux.com, penberg@kernel.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, willy@infradead.org, pcc@google.com,
        tytso@mit.edu, maz@kernel.org, ruansy.fnst@fujitsu.com,
        vishal.moola@gmail.com, lrh2000@pku.edu.cn, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231021144317.3400916-1-chengming.zhou@linux.dev>
 <20231021144317.3400916-4-chengming.zhou@linux.dev>
 <79a879cc-f5f8-08ef-0afa-3688d433a756@suse.cz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <79a879cc-f5f8-08ef-0afa-3688d433a756@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/24 00:00, Vlastimil Babka wrote:
> On 10/21/23 16:43, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> Now we will freeze slabs when moving them out of node partial list to
>> cpu partial list, this method needs two cmpxchg_double operations:
>>
>> 1. freeze slab (acquire_slab()) under the node list_lock
>> 2. get_freelist() when pick used in ___slab_alloc()
>>
>> Actually we don't need to freeze when moving slabs out of node partial
>> list, we can delay freeze to use slab freelist in ___slab_alloc(), so
>> we can save one cmpxchg_double().
>>
>> And there are other good points:
>>
>> 1. The moving of slabs between node partial list and cpu partial list
>>    becomes simpler, since we don't need to freeze or unfreeze at all.
>>
>> 2. The node list_lock contention would be less, since we only need to
>>    freeze one slab under the node list_lock. (In fact, we can first
>>    move slabs out of node partial list, don't need to freeze any slab
>>    at all, so the contention on slab won't transfer to the node list_lock
>>    contention.)
>>
>> We can achieve this because there is no concurrent path would manipulate
>> the partial slab list except the __slab_free() path, which is serialized
>> now.
>>
>> Note this patch just change the parts of moving the partial slabs for
>> easy code review, we will fix other parts in the following patches.
>> Specifically this patch change three paths:
>> 1. get partial slab from node: get_partial_node()
>> 2. put partial slab to node: __unfreeze_partials()
>> 3. cache partail slab on cpu when __slab_free()
> 
> So the problem with this approach that one patch breaks things and another
> one fixes them up, is that git bisect becomes problematic, so we shouldn't
> do that and instead bite the bullet and deal with a potentially large patch.
> At some level it's unavoidable as one has to grasp all the moving pieces
> anyway to see e.g. if the changes in allocation path are compatible with the
> changes in freeing.
> When possible, we can do preparatory stuff that doesn't break things like in
> patches 1 and 2, maybe get_cpu_partial() could also be introduced (even if
> unused) before switching the world over to the new scheme in a single patch
> (and possible cleanups afterwards). So would it be possible to redo it in
> such way please?

Ok, I will change to this way. I didn't know how to handle this potentially
large patch gracefully at first. Your detailed advice is very helpful to me,
I will prepare all possible preparatory stuff, then change all parts over
in one patch.

> 
> <snip>
> 
>> @@ -2621,23 +2622,7 @@ static void __unfreeze_partials(struct kmem_cache *s, struct slab *partial_slab)
>>  			spin_lock_irqsave(&n->list_lock, flags);
>>  		}
>>  
>> -		do {
>> -
>> -			old.freelist = slab->freelist;
>> -			old.counters = slab->counters;
>> -			VM_BUG_ON(!old.frozen);
>> -
>> -			new.counters = old.counters;
>> -			new.freelist = old.freelist;
>> -
>> -			new.frozen = 0;
>> -
>> -		} while (!__slab_update_freelist(s, slab,
>> -				old.freelist, old.counters,
>> -				new.freelist, new.counters,
>> -				"unfreezing slab"));
>> -
>> -		if (unlikely(!new.inuse && n->nr_partial >= s->min_partial)) {
>> +		if (unlikely(!slab->inuse && n->nr_partial >= s->min_partial)) {
>>  			slab->next = slab_to_discard;
>>  			slab_to_discard = slab;
>>  		} else {
>> @@ -3634,18 +3619,8 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>>  		was_frozen = new.frozen;
>>  		new.inuse -= cnt;
>>  		if ((!new.inuse || !prior) && !was_frozen) {
>> -
>> -			if (kmem_cache_has_cpu_partial(s) && !prior) {
>> -
>> -				/*
>> -				 * Slab was on no list before and will be
>> -				 * partially empty
>> -				 * We can defer the list move and instead
>> -				 * freeze it.
>> -				 */
>> -				new.frozen = 1;
>> -
>> -			} else { /* Needs to be taken off a list */
>> +			/* Needs to be taken off a list */
>> +			if (!kmem_cache_has_cpu_partial(s) || prior) {
>>  
>>  				n = get_node(s, slab_nid(slab));
>>  				/*
>> @@ -3675,7 +3650,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>>  			 * activity can be necessary.
>>  			 */
>>  			stat(s, FREE_FROZEN);
>> -		} else if (new.frozen) {
>> +		} else if (kmem_cache_has_cpu_partial(s) && !prior) {
>>  			/*
>>  			 * If we just froze the slab then put it onto the
>>  			 * per cpu partial list.
> 
> I think this comment is now misleading, we didn't freeze the slab, so it's
> now something like "if we started with a full slab...".

Ok, will check and change these inconsistent comments by the way.

Thanks!
