Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5E97DA4AB
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 03:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbjJ1Bgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 21:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1Bgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 21:36:39 -0400
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6514E128
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 18:36:35 -0700 (PDT)
Message-ID: <23f21bf1-0f27-4091-b889-bf43290fa6f3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698456993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IELGD68QeWnUvOrfpqSGo2BNQPupvv5ypFkOiDnBJWQ=;
        b=vdsTsXrIyli5JO7yC0/L6twGLUnDhL+qGEMALj5iryqYXHodZr/YFCP2Qr5RSlclXdm6N0
        K0yHT3pifs7mjyUgVX6H6zUSHPFD/zkZ1/zKtGwpPAhI692iMnWsRdC/AVOACw+b4y9C6+
        ERzZ6DkTDqUXy60eJitERlKH9si5UKU=
Date:   Sat, 28 Oct 2023 09:35:55 +0800
MIME-Version: 1.0
Subject: Re: [RFC PATCH v3 2/7] slub: Prepare __slab_free() for unfrozen
 partial slab out of node partial list
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, cl@linux.com, penberg@kernel.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231024093345.3676493-1-chengming.zhou@linux.dev>
 <20231024093345.3676493-3-chengming.zhou@linux.dev>
 <43da5c9a-aeff-1bff-81a8-4611470c2514@suse.cz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <43da5c9a-aeff-1bff-81a8-4611470c2514@suse.cz>
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

On 2023/10/27 23:18, Vlastimil Babka wrote:
> On 10/24/23 11:33, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> Now the partial slub will be frozen when taken out of node partial list,
> 
> 	  partially empty slab
> 
>> so the __slab_free() will know from "was_frozen" that the partial slab
>> is not on node partial list and is used by one kmem_cache_cpu.
> 
> 				... is a cpu or cpu partial slab of some cpu.
> 
>> But we will change this, make partial slabs leave the node partial list
>> with unfrozen state, so we need to change __slab_free() to use the new
>> slab_test_node_partial() we just introduced.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  mm/slub.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 3fad4edca34b..f568a32d7332 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -3610,6 +3610,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>>  	unsigned long counters;
>>  	struct kmem_cache_node *n = NULL;
>>  	unsigned long flags;
>> +	bool on_node_partial;
>>  
>>  	stat(s, FREE_SLOWPATH);
>>  
>> @@ -3657,6 +3658,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>>  				 */
>>  				spin_lock_irqsave(&n->list_lock, flags);
>>  
>> +				on_node_partial = slab_test_node_partial(slab);
>>  			}
>>  		}
>>  
>> @@ -3685,6 +3687,15 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>>  		return;
>>  	}
>>  
>> +	/*
>> +	 * This slab was partial but not on the per-node partial list,
> 
> This slab was partially empty ...
> 
> Otherwise LGTM!

Ok, will fix.

Thanks!

> 
>> +	 * in which case we shouldn't manipulate its list, just return.
>> +	 */
>> +	if (prior && !on_node_partial) {
>> +		spin_unlock_irqrestore(&n->list_lock, flags);
>> +		return;
>> +	}
>> +
>>  	if (unlikely(!new.inuse && n->nr_partial >= s->min_partial))
>>  		goto slab_empty;
>>  
> 
