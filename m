Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97152802D3A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 09:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjLDIaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLDIai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:30:38 -0500
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB690CB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 00:30:41 -0800 (PST)
Message-ID: <e3e319f5-9bcd-4c35-92e6-6fdb33eaa080@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701678639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9FCmOUDEhk/C/p/K392zgD3slK3uNuip9FSardg1Z7w=;
        b=H7Xe+6ulWDPhZDnQCByRmYdIpY2aXt0AEa5eVX33L9yORgJy4M/sF0isMJ8ajiLMYY0dC8
        +2DHQXuNPGb+doz5220ARXX7sOC6WL8kU5ft2JaRXcjkDC6CcHLAQojNz54+Er26BkcAnQ
        UlwRCkMJY+fOVKmL8YnvcFgjGkxzxIU=
Date:   Mon, 4 Dec 2023 16:30:29 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v8 1/6] list_lru: allows explicit memcg and NUMA node
 selection
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        cerasuolodomenico@gmail.com, yosryahmed@google.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
References: <20231130194023.4102148-1-nphamcs@gmail.com>
 <20231130194023.4102148-2-nphamcs@gmail.com>
 <ZWjpNr3ZzvU4TDC8@casper.infradead.org>
 <CAKEwX=MV-F50i_=sZ0unfbgjrdxSTio00c4xTM19113BAN3-wA@mail.gmail.com>
 <20231130203522.GC543908@cmpxchg.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20231130203522.GC543908@cmpxchg.org>
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

On 2023/12/1 04:35, Johannes Weiner wrote:
> On Thu, Nov 30, 2023 at 12:07:41PM -0800, Nhat Pham wrote:
>> On Thu, Nov 30, 2023 at 11:57 AM Matthew Wilcox <willy@infradead.org> wrote:
>>>
>>> On Thu, Nov 30, 2023 at 11:40:18AM -0800, Nhat Pham wrote:
>>>> This patch changes list_lru interface so that the caller must explicitly
>>>> specify numa node and memcg when adding and removing objects. The old
>>>> list_lru_add() and list_lru_del() are renamed to list_lru_add_obj() and
>>>> list_lru_del_obj(), respectively.
>>>
>>> Wouldn't it be better to add list_lru_add_memcg() and
>>> list_lru_del_memcg() and have:
>>>
>>> +bool list_lru_del(struct list_lru *lru, struct list_head *item)
>>> +{
>>> +       int nid = page_to_nid(virt_to_page(item));
>>> +       struct mem_cgroup *memcg = list_lru_memcg_aware(lru) ?
>>> +               mem_cgroup_from_slab_obj(item) : NULL;
>>> +
>>> +       return list_lru_del_memcg(lru, item, nid, memcg);
>>> +}
>>>
>>> Seems like _most_ callers will want the original versions and only
>>> a few will want the explicit memcg/nid versions.  No?
>>>
>>
>> I actually did something along that line in earlier iterations of this
>> patch series (albeit with poorer naming - __list_lru_add() instead of
>> list_lru_add_memcg()). The consensus after some back and forth was
>> that the original list_lru_add() was not a very good design (the
>> better one was this new version that allows for explicit numa/memcg
>> selection). So I agreed to fix it everywhere as a prep patch.
>>
>> I don't have strong opinions here to be completely honest, but I do
>> think this new API makes more sense (at the cost of quite a bit of
>> elbow grease to fix every callsites and extra reviewing).
> 
> Maybe I can shed some light since I was pushing for doing it this way.
> 
> The quiet assumption that 'struct list_head *item' is (embedded in) a
> slab object that is also charged to a cgroup is a bit much, given that
> nothing in the name or documentation of the function points to that.
> 
> It bit us in the THP shrinker where that list head is embedded in a
> tailpage (virt_to_page(page) is fun to debug). And it caused some
> confusion in this case as well, where the zswap entry is a slab object
> but not charged (the entry descriptor is not attractive for cgroup
> accounting, only the backing memory it points to.)

Hi,

I have a question, maybe I missed something since I haven't read all
the earlier versions.

IIUC, the problem here is that "zswap_entry" has different memcg and node
than the "page", so I wonder if we can just charge "zswap_entry" to the
same memcg of the "page".

Like we can do these when allocating the "zswap_entry":

	old_memcg = set_active_memcg(memcg)
	kmem_cache_alloc_lru(zswap_entry_cache, lru, gfp)
	set_active_memcg(old_memcg)

The good points are:

1. "zswap_entry" is charged to the memcg of "page", which is more sensible?

2. We can reuse the kmem_cache_alloc_lru() interface, which makes code simpler
   since we don't need to manage list_lru_memcg by ourselves.

3. Maybe the new list_lru_add() and list_lru_del() are not needed anymore?
   Since the "zswap_entry" is of the same memcg and node with the "page".
   But don't know if THP shrinker still need it.

Thanks!

> 
> Yes, for most users - at least right now - the current assumption is
> accurate. The thinking was just that if we do have to differentiate
> callers now anyway, we might as well make the interface a bit more
> self-documenting and harder to misuse going forward, even if it's a
> bit more churn now.
> 
> 
