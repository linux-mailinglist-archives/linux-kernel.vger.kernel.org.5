Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C26D802372
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 12:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjLCLrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 06:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCLrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 06:47:48 -0500
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14CBD0
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 03:47:49 -0800 (PST)
Message-ID: <294cf54b-cdf5-4441-9924-67d934e54883@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701604068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LuXtRobxGFcs62ikNGb7y5LBc2CHQbhGfyI3ae6uq+8=;
        b=BKsjoxakdAFlR9zmabCsFNS0m+wLeqMPXbTs9J7ST29kZalyjB3cvZGsevc6mnxGFdr9/e
        KXkoJtfZFyUc9kyQ2e+VDWLoWrb5XSFl53U569gIgVF+vh2+S/phMRhvutVZoMaHrsF1E7
        nOswtiAgXZLatT8ArpGxcAgqHBJFrAk=
Date:   Sun, 3 Dec 2023 19:47:18 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v5 7/9] slub: Optimize deactivate_slab()
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231102032330.1036151-1-chengming.zhou@linux.dev>
 <20231102032330.1036151-8-chengming.zhou@linux.dev>
 <CAB=+i9RR-n4q5NU6LFqmhM8ys4kM0SPqwj0zYtr4twu=yYmPPA@mail.gmail.com>
 <af74599e-6384-4bcc-9773-d37b061eabdf@linux.dev>
 <CAB=+i9T+aLEj6BHdXXJxqY914O1ZVCbmL8iL_5wiFB3dQN6yUg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <CAB=+i9T+aLEj6BHdXXJxqY914O1ZVCbmL8iL_5wiFB3dQN6yUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 2023/12/3 19:19, Hyeonggon Yoo wrote:
> On Sun, Dec 3, 2023 at 7:26 PM Chengming Zhou <chengming.zhou@linux.dev> wrote:
>>
>> On 2023/12/3 17:23, Hyeonggon Yoo wrote:
>>> On Thu, Nov 2, 2023 at 12:25 PM <chengming.zhou@linux.dev> wrote:
>>>>
>>>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>>>
>>>> Since the introduce of unfrozen slabs on cpu partial list, we don't
>>>> need to synchronize the slab frozen state under the node list_lock.
>>>>
>>>> The caller of deactivate_slab() and the caller of __slab_free() won't
>>>> manipulate the slab list concurrently.
>>>>
>>>> So we can get node list_lock in the last stage if we really need to
>>>> manipulate the slab list in this path.
>>>>
>>>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>>>> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>>>> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>>>> ---
>>>>  mm/slub.c | 79 ++++++++++++++++++-------------------------------------
>>>>  1 file changed, 26 insertions(+), 53 deletions(-)
>>>>
>>>> diff --git a/mm/slub.c b/mm/slub.c
>>>> index bcb5b2c4e213..d137468fe4b9 100644
>>>> --- a/mm/slub.c
>>>> +++ b/mm/slub.c
>>>> @@ -2468,10 +2468,8 @@ static void init_kmem_cache_cpus(struct kmem_cache *s)
>>>>  static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
>>>>                             void *freelist)
>>>>  {
>>>> -       enum slab_modes { M_NONE, M_PARTIAL, M_FREE, M_FULL_NOLIST };
>>>>         struct kmem_cache_node *n = get_node(s, slab_nid(slab));
>>>>         int free_delta = 0;
>>>> -       enum slab_modes mode = M_NONE;
>>>>         void *nextfree, *freelist_iter, *freelist_tail;
>>>>         int tail = DEACTIVATE_TO_HEAD;
>>>>         unsigned long flags = 0;
>>>> @@ -2509,65 +2507,40 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
>>>>         /*
>>>>          * Stage two: Unfreeze the slab while splicing the per-cpu
>>>>          * freelist to the head of slab's freelist.
>>>> -        *
>>>> -        * Ensure that the slab is unfrozen while the list presence
>>>> -        * reflects the actual number of objects during unfreeze.
>>>> -        *
>>>> -        * We first perform cmpxchg holding lock and insert to list
>>>> -        * when it succeed. If there is mismatch then the slab is not
>>>> -        * unfrozen and number of objects in the slab may have changed.
>>>> -        * Then release lock and retry cmpxchg again.
>>>>          */
>>>> -redo:
>>>> -
>>>> -       old.freelist = READ_ONCE(slab->freelist);
>>>> -       old.counters = READ_ONCE(slab->counters);
>>>> -       VM_BUG_ON(!old.frozen);
>>>> -
>>>> -       /* Determine target state of the slab */
>>>> -       new.counters = old.counters;
>>>> -       if (freelist_tail) {
>>>> -               new.inuse -= free_delta;
>>>> -               set_freepointer(s, freelist_tail, old.freelist);
>>>> -               new.freelist = freelist;
>>>> -       } else
>>>> -               new.freelist = old.freelist;
>>>> -
>>>> -       new.frozen = 0;
>>>> +       do {
>>>> +               old.freelist = READ_ONCE(slab->freelist);
>>>> +               old.counters = READ_ONCE(slab->counters);
>>>> +               VM_BUG_ON(!old.frozen);
>>>> +
>>>> +               /* Determine target state of the slab */
>>>> +               new.counters = old.counters;
>>>> +               new.frozen = 0;
>>>> +               if (freelist_tail) {
>>>> +                       new.inuse -= free_delta;
>>>> +                       set_freepointer(s, freelist_tail, old.freelist);
>>>> +                       new.freelist = freelist;
>>>> +               } else {
>>>> +                       new.freelist = old.freelist;
>>>> +               }
>>>> +       } while (!slab_update_freelist(s, slab,
>>>> +               old.freelist, old.counters,
>>>> +               new.freelist, new.counters,
>>>> +               "unfreezing slab"));
>>>>
>>>> +       /*
>>>> +        * Stage three: Manipulate the slab list based on the updated state.
>>>> +        */
>>>
>>> deactivate_slab() might unconsciously put empty slabs into partial list, like:
>>>
>>> deactivate_slab()                    __slab_free()
>>> cmpxchg(), slab's not empty
>>>                                                cmpxchg(), slab's empty
>>> and unfrozen
>>
>> Hi,
>>
>> Sorry, but I don't get it here how __slab_free() can see the slab empty,
>> since the slab is not empty from deactivate_slab() path, and it can't be
>> used by any CPU at that time?
> 
> The scenario is CPU B previously allocated an object from slab X, but
> put it into node partial list and then CPU A have taken slab X into cpu slab.
> 
> While slab X is CPU A's cpu slab, when CPU B frees an object from slab X,
> it puts the object into slab X's freelist using cmpxchg.
> 
> Let's say in CPU A the deactivation path performs cmpxchg and X.inuse was 1,
> and then CPU B frees (__slab_free()) to slab X's freelist using cmpxchg,
> _before_ slab X's put into partial list by CPU A.
> 
> Then CPU A thinks it's not empty so put it into partial list, but by CPU B
> the slab has become empty.
> 
> Maybe I am confused, in that case please tell me I'm wrong :)
> 

Ah, you're right! I misunderstood the slab "empty" with "full". :)

Yes, in this case the "empty" slab would be put into the node partial list,
and it should be fine in the real world as you noted earlier.

Thanks!
