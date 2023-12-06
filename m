Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2464180707A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378371AbjLFNCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378112AbjLFNC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:02:29 -0500
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7698D3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 05:02:34 -0800 (PST)
Message-ID: <fdd11528-b0f8-48af-8141-15c4b1b01c65@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701867753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8FwFOjfZZq5xgvqF5C0gDT7tc2X7JK7alFPfrUHoiQ0=;
        b=vT7C/0yE4xhHd76uE8FxiFHCDRwuB1PFnZvw2rVRxXHex0Fyta/ZGufxM7G/qIx3fLna7c
        g+iBR7BCwLm35J7g4Ne3+AhH7g9KKviJ+rpuqp9qFv8nUr5Qokq206sbYOzxgL0uD36pqI
        4G2vAbFoLyXt8hruc8hh1XDfBxYdLHA=
Date:   Wed, 6 Dec 2023 21:01:58 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 4/4] mm/slub: free KFENCE objects in slab_free_hook()
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
References: <20231204-slub-cleanup-hooks-v1-0-88b65f7cd9d5@suse.cz>
 <20231204-slub-cleanup-hooks-v1-4-88b65f7cd9d5@suse.cz>
 <44421a37-4343-46d0-9e5c-17c2cd038cf2@linux.dev>
 <79e29576-12a2-a423-92f3-d8a7bcd2f0ce@suse.cz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <79e29576-12a2-a423-92f3-d8a7bcd2f0ce@suse.cz>
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

On 2023/12/6 17:58, Vlastimil Babka wrote:
> On 12/5/23 14:27, Chengming Zhou wrote:
>> On 2023/12/5 03:34, Vlastimil Babka wrote:
>>> When freeing an object that was allocated from KFENCE, we do that in the
>>> slowpath __slab_free(), relying on the fact that KFENCE "slab" cannot be
>>> the cpu slab, so the fastpath has to fallback to the slowpath.
>>>
>>> This optimization doesn't help much though, because is_kfence_address()
>>> is checked earlier anyway during the free hook processing or detached
>>> freelist building. Thus we can simplify the code by making the
>>> slab_free_hook() free the KFENCE object immediately, similarly to KASAN
>>> quarantine.
>>>
>>> In slab_free_hook() we can place kfence_free() above init processing, as
>>> callers have been making sure to set init to false for KFENCE objects.
>>> This simplifies slab_free(). This places it also above kasan_slab_free()
>>> which is ok as that skips KFENCE objects anyway.
>>>
>>> While at it also determine the init value in slab_free_freelist_hook()
>>> outside of the loop.
>>>
>>> This change will also make introducing per cpu array caches easier.
>>>
>>> Tested-by: Marco Elver <elver@google.com>
>>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>>> ---
>>>  mm/slub.c | 22 ++++++++++------------
>>>  1 file changed, 10 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/mm/slub.c b/mm/slub.c
>>> index ed2fa92e914c..e38c2b712f6c 100644
>>> --- a/mm/slub.c
>>> +++ b/mm/slub.c
>>> @@ -2039,7 +2039,7 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
>>>   * production configuration these hooks all should produce no code at all.
>>>   *
>>>   * Returns true if freeing of the object can proceed, false if its reuse
>>> - * was delayed by KASAN quarantine.
>>> + * was delayed by KASAN quarantine, or it was returned to KFENCE.
>>>   */
>>>  static __always_inline
>>>  bool slab_free_hook(struct kmem_cache *s, void *x, bool init)
>>> @@ -2057,6 +2057,9 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init)
>>>  		__kcsan_check_access(x, s->object_size,
>>>  				     KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT);
>>>  
>>> +	if (kfence_free(kasan_reset_tag(x)))
>>
>> I'm wondering if "kasan_reset_tag()" is needed here?
> 
> I think so, because AFAICS the is_kfence_address() check in kfence_free()
> could be a false negative otherwise. In fact now I even question some of the

Ok.

> other is_kfence_address() checks in mm/slub.c, mainly
> build_detached_freelist() which starts from pointers coming directly from
> slab users. Insight from KASAN/KFENCE folks appreciated :)
> 
I know very little about KASAN/KFENCE, looking forward to their insight. :)

Just saw a check in __kasan_slab_alloc():

	if (is_kfence_address(object))
		return (void *)object;

So thought it seems that a kfence object would be skipped by KASAN.

Thanks!
