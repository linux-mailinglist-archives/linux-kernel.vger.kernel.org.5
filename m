Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177F97D456C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjJXCWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjJXCWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:22:21 -0400
Received: from out-193.mta0.migadu.com (out-193.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12B9B9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 19:22:17 -0700 (PDT)
Message-ID: <72361910-240f-4aa2-a695-117e1b14a804@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698114134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fwaP8TdpUtTLFl5cjIZcASMe6zXr80njnSOmBInx+FU=;
        b=nDy5mvdR7l/4DSwIUlVfnKR937Jbhtx+5RDuxNAoUTLY07J4JPxEkYqo7PKTUyhfNQRcCm
        Nz9cCV0L4s5qNYbiBUno5kw3x6I+Upi3gvESwPgXlKRfWVbqoMAlQrHt8oZmjw+o1h/QQy
        cJT1PFM+Qd4uTANemIuKn0v5xhpA6D0=
Date:   Tue, 24 Oct 2023 10:20:49 +0800
MIME-Version: 1.0
Subject: Re: [RFC PATCH v2 0/6] slub: Delay freezing of CPU partial slabs
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
 <4134b039-fa99-70cd-3486-3d0c7632e4a3@suse.cz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <4134b039-fa99-70cd-3486-3d0c7632e4a3@suse.cz>
Content-Type: text/plain; charset=UTF-8
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

On 2023/10/23 23:46, Vlastimil Babka wrote:
> On 10/21/23 16:43, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Hi!
> 
>> Changes in RFC v2:
>>  - Reuse PG_workingset bit to keep track of whether slub is on the
>>    per-node partial list, as suggested by Matthew Wilcox.
>>  - Fix OOM problem on kernel without CONFIG_SLUB_CPU_PARTIAL, which
>>    is caused by leak of partial slabs when get_partial_node().
>>  - Add a patch to simplify acquire_slab().
>>  - Reorder patches a little.
>>  - v1: https://lore.kernel.org/all/20231017154439.3036608-1-chengming.zhou@linux.dev/
>>
>> 1. Problem
>> ==========
>> Now we have to freeze the slab when get from the node partial list, and
>> unfreeze the slab when put to the node partial list. Because we need to
>> rely on the node list_lock to synchronize the "frozen" bit changes.
>>
>> This implementation has some drawbacks:
>>
>>  - Alloc path: twice cmpxchg_double.
>>    It has to get some partial slabs from node when the allocator has used
>>    up the CPU partial slabs. So it freeze the slab (one cmpxchg_double)
>>    with node list_lock held, put those frozen slabs on its CPU partial
>>    list. Later ___slab_alloc() will cmpxchg_double try-loop again if that
>>    slab is picked to use.
>>
>>  - Alloc path: amplified contention on node list_lock.
>>    Since we have to synchronize the "frozen" bit changes under the node
>>    list_lock, the contention of slab (struct page) can be transferred
>>    to the node list_lock. On machine with many CPUs in one node, the
>>    contention of list_lock will be amplified by all CPUs' alloc path.
>>
>>    The current code has to workaround this problem by avoiding using
>>    cmpxchg_double try-loop, which will just break and return when
>>    contention of page encountered and the first cmpxchg_double failed.
>>    But this workaround has its own problem.
> 
> I'd note here: For more context, see 9b1ea29bc0d7 ("Revert "mm, slub:
> consider rest of partial list if acquire_slab() fails"")

Good, will add it.

> 
>>  - Free path: redundant unfreeze.
>>    __slab_free() will freeze and cache some slabs on its partial list,
>>    and flush them to the node partial list when exceed, which has to
>>    unfreeze those slabs again under the node list_lock. Actually we
>>    don't need to freeze slab on CPU partial list, in which case we
>>    can save the unfreeze cmpxchg_double operations in flush path.
>>
>> 2. Solution
>> ===========
>> We solve these problems by leaving slabs unfrozen when moving out of
>> the node partial list and on CPU partial list, so "frozen" bit is 0.
>>
>> These partial slabs won't be manipulate concurrently by alloc path,
>> the only racer is free path, which may manipulate its list when !inuse.
>> So we need to introduce another synchronization way to avoid it, we
>> reuse PG_workingset to keep track of whether the slab is on node partial
>> list or not, only in that case we can manipulate the slab list.
>>
>> The slab will be delay frozen when it's picked to actively use by the
>> CPU, it becomes full at the same time, in which case we still need to
>> rely on "frozen" bit to avoid manipulating its list. So the slab will
>> be frozen only when activate use and be unfrozen only when deactivate.
> 
> Interesting solution! I wonder if we could go a bit further and remove
> acquire_slab() completely. Because AFAICS even after your changes,
> acquire_slab() is still attempted including freezing the slab, which means
> still doing an cmpxchg_double under the list_lock, and now also handling the
> special case when it failed, but we at least filled percpu partial lists.
> What if we only filled the partial list without freezing, and then froze the
> first slab outside of the list_lock?

Good idea, we can return one slab and put other slabs to the CPU partial list.
So we can remove the acquire_slab() completely and don't need to handle the
fail case. The code will be cleaner, too.

> 
> Or more precisely, instead of returning the acquired "object" we would
> return the first slab removed from partial list. I think it would simplify
> the code a bit, and further reduce list_lock holding times.

Ok, I will do this in the next version. But I find we have to return the object
in the "IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)" case, in which
we need to allocate a single object under the node list_lock.

Maybe we can use "struct partial_context" to return the object in this case?

 struct partial_context {
-       struct slab **slab;
        gfp_t flags;
        unsigned int orig_size;
+       void *object;
 };

Then we can change all get_partial interfaces to return a slab. Do you agree
with this way?

> 
> I'll also point out a few more details, but it's not a full detailed review
> as the suggestion above, and another for 4/5, could mean a rather
> significant change for v3.

Thank you!

> 
> Thanks!
> 
>> 3. Testing
>> ==========
>> We just did some simple testing on a server with 128 CPUs (2 nodes) to
>> compare performance for now.
>>
>>  - perf bench sched messaging -g 5 -t -l 100000
>>    baseline	RFC
>>    7.042s	6.966s
>>    7.022s	7.045s
>>    7.054s	6.985s
>>
>>  - stress-ng --rawpkt 128 --rawpkt-ops 100000000
>>    baseline	RFC
>>    2.42s	2.15s
>>    2.45s	2.16s
>>    2.44s	2.17s
>>
>> It shows above there is about 10% improvement on stress-ng rawpkt
>> testcase, although no much improvement on perf sched bench testcase.
>>
>> Thanks for any comment and code review!
>>
>> Chengming Zhou (6):
>>   slub: Keep track of whether slub is on the per-node partial list
>>   slub: Prepare __slab_free() for unfrozen partial slab out of node
>>     partial list
>>   slub: Don't freeze slabs for cpu partial
>>   slub: Simplify acquire_slab()
>>   slub: Introduce get_cpu_partial()
>>   slub: Optimize deactivate_slab()
>>
>>  include/linux/page-flags.h |   2 +
>>  mm/slab.h                  |  19 +++
>>  mm/slub.c                  | 245 +++++++++++++++++++------------------
>>  3 files changed, 150 insertions(+), 116 deletions(-)
>>
> 
