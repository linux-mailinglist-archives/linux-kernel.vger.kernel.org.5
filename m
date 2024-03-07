Return-Path: <linux-kernel+bounces-94860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B3D87460D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 658B11F218A3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6EA611E;
	Thu,  7 Mar 2024 02:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ng26Bvvf"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028994C8B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 02:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709777851; cv=none; b=YQyzceJ40yANYZB1zBA6J7gUhEA0b2OgZm19boioznPm2WLKXLiUtmfK/JGSvsvxlez8gupJ0gYaqyDN7SRgb0Pi6tMl2/r5xYsCe8Q0cp47kAmJWf+gmzilV3Ejuw0buybadJfGKrHYwp5gfHsisxA6Zt4QziW+fgzHocrM+mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709777851; c=relaxed/simple;
	bh=aFu4YL6lK3K9KevCkte/apdg+absxttVWpiuTL5ABew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hxIo5+rbpHhguY27dxeBL6rv0t7J0D/3zHeqhLlQEajQh2mT0/Tzratq4VtwdzE7eGqAXEwGJyPpkfE3hDvkbwUHHLdRcDtxjH0w/zMw5AYdE1ru3d3Wj72ceogeJ6/sJrh3Q4dvWOuGyT2fW6J6XfYKfcxS8d9Wy5w8QqP4z+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ng26Bvvf; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-29a5f100c1aso189864a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 18:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709777848; x=1710382648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zh+BLBA/5W+m6OdKvw3MFrvOs9dYu4ONkOQWKZRMgtY=;
        b=Ng26BvvfIZSp1O+Ck8/d9YDM8wIqgROE6fnTmU8F2lb64aXEzHX+KwUstbivxp5gDk
         iN2Ch05TkAQ64FNcRdf0a/lo7egoMV/2nHJC82xqE2PIuLIY/HHDmg1/qAK5cVIhY24L
         xfd143PkM77FigSqcOTocv9nz8hHlqJcT4f44DZn/qZr7Q6EyYO3QXFeyAn1PlTmq+if
         xJ1Zr4MxgyHDf0VK70tjFjjRM2ov1gYnkDQ6QnibcGUOL2hdVCb3qXGh1lJehOBxEvEU
         FX9fKden95IKieIeBpxHvXz9w/lS4Xq6U3nM+MMwaDywIN0MV31JNbcrL0rhrBeJGuQf
         Z9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709777848; x=1710382648;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zh+BLBA/5W+m6OdKvw3MFrvOs9dYu4ONkOQWKZRMgtY=;
        b=Nm23bnM1Y3T2SIlG70/yy+A4745hbGUyn9A2cpDqfxbjwN6Qwms/wSWw4YjrrSNuh1
         5A+ImRvrExD0Z8euDeuC26s0pP1BHUmwmenDCj2ITLhclHc3PBmCK16g0IveXcZA1c6W
         7KIEUfZymuP7q54PlrVz6bAvkFWzgBZ+gqWmerp3yFuKy2iDPY9BS/NKDMdTiRVZonnk
         TtQvbOnN+Obm10QYUvXIsGT7BJChVv2H1RSTBbDpUqGGvJ9UCW69aMICaN3tTy40/hAX
         54yNg86h7HECfaIjP+kRCtxs39/kyDc60ui/DKH8wOsox1ZBcp/YxRjA+xS7UEi20AD6
         CwnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx0P2sSj+XztN7HfMqDjLYsvv+cPSE5p3ro7HjuJAoOPwIIYwbFazDHEDjx/S0BGLo1b8hRsMHLUUswkLy2IaGesvrbgxANbNQpefF
X-Gm-Message-State: AOJu0Yw3Ge+uKLVZCZBgKtm7y1Hd6gfJg2FMZK7rw5EoWIZ89bWpH8dV
	jGVn6svfib0L55E8veuvMnO69qYAtfcBky3RCzNLGRZ00jHWlBwI5allgY5JiDA=
X-Google-Smtp-Source: AGHT+IGhZYrrNBTYWYJEVpQvf0o3njWdoyLvrvWhUO2Ur6EiItk4/Pxxi3+uSfDoyywgLfeD4NG5fw==
X-Received: by 2002:a17:90a:4615:b0:29b:a59:a12d with SMTP id w21-20020a17090a461500b0029b0a59a12dmr13038209pjg.25.1709777848051;
        Wed, 06 Mar 2024 18:17:28 -0800 (PST)
Received: from [10.254.1.224] ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id e8-20020a170902784800b001dcc7795524sm13531279pln.24.2024.03.06.18.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 18:17:27 -0800 (PST)
Message-ID: <000b8cee-79cc-4f28-b180-105f2abe6b82@bytedance.com>
Date: Thu, 7 Mar 2024 10:17:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] zswap: replace RB tree with xarray
Content-Language: en-US
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Yosry Ahmed <yosryahmed@google.com>,
 Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Barry Song <v-songbaohua@oppo.com>
References: <20240304-zswap-xarray-v4-1-c4b45670cc30@kernel.org>
 <05cbfe34-bac1-4c16-92fa-f38b09160458@bytedance.com>
 <CAF8kJuPaW51+K5JAT4CzQg7QFWXz5WCc_=MbYN5OYAAYrcRR1w@mail.gmail.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAF8kJuPaW51+K5JAT4CzQg7QFWXz5WCc_=MbYN5OYAAYrcRR1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/3/7 05:12, Chris Li wrote:
> Hi Chengming,
> 
> On Mon, Mar 4, 2024 at 6:52 PM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> Hi Chris,
>>
>> On 2024/3/5 05:32, Chris Li wrote:
>>> Very deep RB tree requires rebalance at times. That
>>> contributes to the zswap fault latencies. Xarray does not
>>> need to perform tree rebalance. Replacing RB tree to xarray
>>> can have some small performance gain.
>>>
>>> One small difference is that xarray insert might fail with
>>> ENOMEM, while RB tree insert does not allocate additional
>>> memory.
>>>
>>> The zswap_entry size will reduce a bit due to removing the
>>> RB node, which has two pointers and a color field. Xarray
>>> store the pointer in the xarray tree rather than the
>>> zswap_entry. Every entry has one pointer from the xarray
>>> tree. Overall, switching to xarray should save some memory,
>>> if the swap entries are densely packed.
>>>
>>> Notice the zswap_rb_search and zswap_rb_insert always
>>> followed by zswap_rb_erase. Use xa_erase directly. The entry
>>> erase into zswap_xa_insert as well. That saves one tree
>>> lookup as well.
>>>
>>> Remove zswap_invalidate_entry due to no need to call
>>> zswap_rb_erase any more. Use zswap_free_entry instead.
>>>
>>> The "struct zswap_tree" has been replaced by "struct xarray".
>>> The tree spin lock has transferred to the xarray lock.
>>>
>>> Run the kernel build testing 10 times for each version, averages:
>>> (memory.max=2GB, zswap shrinker and writeback enabled, one 50GB swapfile.)
>>>
>>> mm-9a0181a3710eb                    xarray v4
>>> user       3526.829                            3526.930
>>> sys        532.754                             526.525
>>> real       198.748                             198.850
>>>
>>> ---
>>>
>>>
>>> Signed-off-by: Chris Li <chrisl@kernel.org>
>>> ---
>>> Changes in v4:
>>> - Remove zswap_xa_search_and_earse, use xa_erase directly.
>>> - Move charge of objcg after zswap_xa_insert.
>>> - Avoid erase old entry on insert fail error path.
>>> - Remove not needed swap_zswap_tree change
>>> - Link to v3: https://lore.kernel.org/r/20240302-zswap-xarray-v3-1-5900252f2302@kernel.org
>>>
>>> Changes in v3:
>>> - Use xa_cmpxchg instead of zswap_xa_search_and_delete in zswap_writeback_entry.
>>> - Use xa_store in zswap_xa_insert directly. Reduce the scope of spinlock.
>>> - Fix xa_store error handling for same page fill case.
>>> - Link to v2: https://lore.kernel.org/r/20240229-zswap-xarray-v2-1-e50284dfcdb1@kernel.org
>>>
>>> Changes in v2:
>>> - Replace struct zswap_tree with struct xarray.
>>> - Remove zswap_tree spinlock, use xarray lock instead.
>>> - Fold zswap_rb_erase() into zswap_xa_search_and_delete() and zswap_xa_insert().
>>> - Delete zswap_invalidate_entry(), use zswap_free_entry() instead.
>>> - Link to v1: https://lore.kernel.org/r/20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org
>>> ---
>>>  mm/zswap.c | 186 ++++++++++++++++++++++++-------------------------------------
>>>  1 file changed, 72 insertions(+), 114 deletions(-)
>>>
>>> diff --git a/mm/zswap.c b/mm/zswap.c
>>> index 011e068eb355..4f4a3f452b76 100644
>>> --- a/mm/zswap.c
>>> +++ b/mm/zswap.c
>>> @@ -20,7 +20,6 @@
>>>  #include <linux/spinlock.h>
>>>  #include <linux/types.h>
>>>  #include <linux/atomic.h>
>>> -#include <linux/rbtree.h>
>>>  #include <linux/swap.h>
>>>  #include <linux/crypto.h>
>>>  #include <linux/scatterlist.h>
>>> @@ -71,6 +70,8 @@ static u64 zswap_reject_compress_poor;
>>>  static u64 zswap_reject_alloc_fail;
>>>  /* Store failed because the entry metadata could not be allocated (rare) */
>>>  static u64 zswap_reject_kmemcache_fail;
>>> +/* Store failed because xarray can't insert the entry*/
>>> +static u64 zswap_reject_xarray_fail;
>>>
>>>  /* Shrinker work queue */
>>>  static struct workqueue_struct *shrink_wq;
>>> @@ -196,7 +197,6 @@ static struct {
>>>   * This structure contains the metadata for tracking a single compressed
>>>   * page within zswap.
>>>   *
>>> - * rbnode - links the entry into red-black tree for the appropriate swap type
>>>   * swpentry - associated swap entry, the offset indexes into the red-black tree
>>>   * length - the length in bytes of the compressed page data.  Needed during
>>>   *          decompression. For a same value filled page length is 0, and both
>>> @@ -208,7 +208,6 @@ static struct {
>>>   * lru - handle to the pool's lru used to evict pages.
>>>   */
>>>  struct zswap_entry {
>>> -     struct rb_node rbnode;
>>>       swp_entry_t swpentry;
>>>       unsigned int length;
>>>       struct zswap_pool *pool;
>>> @@ -220,12 +219,7 @@ struct zswap_entry {
>>>       struct list_head lru;
>>>  };
>>>
>>> -struct zswap_tree {
>>> -     struct rb_root rbroot;
>>> -     spinlock_t lock;
>>> -};
>>> -
>>> -static struct zswap_tree *zswap_trees[MAX_SWAPFILES];
>>> +static struct xarray *zswap_trees[MAX_SWAPFILES];
>>>  static unsigned int nr_zswap_trees[MAX_SWAPFILES];
>>>
>>>  /* RCU-protected iteration */
>>> @@ -253,7 +247,7 @@ static bool zswap_has_pool;
>>>  * helpers and fwd declarations
>>>  **********************************/
>>>
>>> -static inline struct zswap_tree *swap_zswap_tree(swp_entry_t swp)
>>> +static inline struct xarray *swap_zswap_tree(swp_entry_t swp)
>>>  {
>>>       return &zswap_trees[swp_type(swp)][swp_offset(swp)
>>>               >> SWAP_ADDRESS_SPACE_SHIFT];
>>> @@ -805,60 +799,33 @@ void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
>>>  }
>>>
>>>  /*********************************
>>> -* rbtree functions
>>> +* xarray functions
>>>  **********************************/
>>> -static struct zswap_entry *zswap_rb_search(struct rb_root *root, pgoff_t offset)
>>> -{
>>> -     struct rb_node *node = root->rb_node;
>>> -     struct zswap_entry *entry;
>>> -     pgoff_t entry_offset;
>>> -
>>> -     while (node) {
>>> -             entry = rb_entry(node, struct zswap_entry, rbnode);
>>> -             entry_offset = swp_offset(entry->swpentry);
>>> -             if (entry_offset > offset)
>>> -                     node = node->rb_left;
>>> -             else if (entry_offset < offset)
>>> -                     node = node->rb_right;
>>> -             else
>>> -                     return entry;
>>> -     }
>>> -     return NULL;
>>> -}
>>>
>>>  /*
>>>   * In the case that a entry with the same offset is found, a pointer to
>>> - * the existing entry is stored in dupentry and the function returns -EEXIST
>>> + * the existing entry is stored in old and erased from the tree.
>>> + * Function return error on insert.
>>>   */
>>> -static int zswap_rb_insert(struct rb_root *root, struct zswap_entry *entry,
>>> -                     struct zswap_entry **dupentry)
>>> +static int zswap_xa_insert(struct xarray *tree, struct zswap_entry *entry,
>>> +                        struct zswap_entry **old)
>>>  {
>>> -     struct rb_node **link = &root->rb_node, *parent = NULL;
>>> -     struct zswap_entry *myentry;
>>> -     pgoff_t myentry_offset, entry_offset = swp_offset(entry->swpentry);
>>> -
>>> -     while (*link) {
>>> -             parent = *link;
>>> -             myentry = rb_entry(parent, struct zswap_entry, rbnode);
>>> -             myentry_offset = swp_offset(myentry->swpentry);
>>> -             if (myentry_offset > entry_offset)
>>> -                     link = &(*link)->rb_left;
>>> -             else if (myentry_offset < entry_offset)
>>> -                     link = &(*link)->rb_right;
>>> -             else {
>>> -                     *dupentry = myentry;
>>> -                     return -EEXIST;
>>> -             }
>>> -     }
>>> -     rb_link_node(&entry->rbnode, parent, link);
>>> -     rb_insert_color(&entry->rbnode, root);
>>> -     return 0;
>>> -}
>>> +     int err;
>>> +     struct zswap_entry *e;
>>> +     pgoff_t offset = swp_offset(entry->swpentry);
>>>
>>> -static void zswap_rb_erase(struct rb_root *root, struct zswap_entry *entry)
>>> -{
>>> -     rb_erase(&entry->rbnode, root);
>>> -     RB_CLEAR_NODE(&entry->rbnode);
>>> +     e = xa_store(tree, offset, entry, GFP_KERNEL);
>>> +     err = xa_err(e);
>>> +
>>> +     if (err) {
>>> +             e = xa_erase(tree, offset);
>>> +             if (err == -ENOMEM)
>>> +                     zswap_reject_alloc_fail++;
>>> +             else
>>> +                     zswap_reject_xarray_fail++;
>>> +     }
>>> +     *old = e;
>>> +     return err;
>>>  }
>>>
>>>  /*********************************
>>> @@ -872,7 +839,6 @@ static struct zswap_entry *zswap_entry_cache_alloc(gfp_t gfp, int nid)
>>>       entry = kmem_cache_alloc_node(zswap_entry_cache, gfp, nid);
>>>       if (!entry)
>>>               return NULL;
>>> -     RB_CLEAR_NODE(&entry->rbnode);
>>>       return entry;
>>>  }
>>>
>>> @@ -914,17 +880,6 @@ static void zswap_entry_free(struct zswap_entry *entry)
>>>       zswap_update_total_size();
>>>  }
>>>
>>> -/*
>>> - * The caller hold the tree lock and search the entry from the tree,
>>> - * so it must be on the tree, remove it from the tree and free it.
>>> - */
>>> -static void zswap_invalidate_entry(struct zswap_tree *tree,
>>> -                                struct zswap_entry *entry)
>>> -{
>>> -     zswap_rb_erase(&tree->rbroot, entry);
>>> -     zswap_entry_free(entry);
>>> -}
>>> -
>>>  /*********************************
>>>  * compressed storage functions
>>>  **********************************/
>>> @@ -1113,7 +1068,9 @@ static void zswap_decompress(struct zswap_entry *entry, struct page *page)
>>>  static int zswap_writeback_entry(struct zswap_entry *entry,
>>>                                swp_entry_t swpentry)
>>>  {
>>> -     struct zswap_tree *tree;
>>> +     struct xarray *tree;
>>> +     pgoff_t offset = swp_offset(swpentry);
>>> +     struct zswap_entry *e;
>>>       struct folio *folio;
>>>       struct mempolicy *mpol;
>>>       bool folio_was_allocated;
>>> @@ -1150,19 +1107,14 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>>>        * be dereferenced.
>>>        */
>>>       tree = swap_zswap_tree(swpentry);
>>> -     spin_lock(&tree->lock);
>>> -     if (zswap_rb_search(&tree->rbroot, swp_offset(swpentry)) != entry) {
>>> -             spin_unlock(&tree->lock);
>>> +     e = xa_cmpxchg(tree, offset, entry, NULL, GFP_KERNEL);
>>> +     if (e != entry) {
>>
>> Maybe "if (xa_cmpxchg() != entry)" look better, so "e" variable can be removed,
>> since we don't use it.
> 
> I thought about that. The main reason "if (xa_cmpxchg(tree, offset,
> entry, NULL, GFP_KERNEL) != entry)" is a long expression. Having
> != entry at the end of the expression makes it harder to read. Have
> the temporary variable IMHO help reading the comparison.
> 
> Not sure I understand the motivation to save a temporary variable. The
> compiler always generates temporary variables internally. Having one
> here does not affect the compiling result at all. It is just there to
> help reading. If you still think it has the reverse effect on reading
> I can of course remove it. It generates the same code anyway.
You are right, just a minor type suggestion, no much difference if you keep it.

> 
>>
>>>               delete_from_swap_cache(folio);
>>>               folio_unlock(folio);
>>>               folio_put(folio);
>>>               return -ENOMEM;
>>>       }
>>>
>>> -     /* Safe to deref entry after the entry is verified above. */
>>> -     zswap_rb_erase(&tree->rbroot, entry);
>>> -     spin_unlock(&tree->lock);
>>> -
>>>       zswap_decompress(entry, &folio->page);
>>>
>>>       count_vm_event(ZSWPWB);
>>> @@ -1471,10 +1423,12 @@ bool zswap_store(struct folio *folio)
>>>  {
>>>       swp_entry_t swp = folio->swap;
>>>       pgoff_t offset = swp_offset(swp);
>>> -     struct zswap_tree *tree = swap_zswap_tree(swp);
>>> -     struct zswap_entry *entry, *dupentry;
>>> +     struct xarray *tree = swap_zswap_tree(swp);
>>> +     struct zswap_entry *entry, *old;
>>>       struct obj_cgroup *objcg = NULL;
>>>       struct mem_cgroup *memcg = NULL;
>>> +     int err;
>>> +     bool old_erased = false;
>>>
>>>       VM_WARN_ON_ONCE(!folio_test_locked(folio));
>>>       VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
>>> @@ -1526,6 +1480,7 @@ bool zswap_store(struct folio *folio)
>>>                       kunmap_local(src);
>>>                       entry->length = 0;
>>>                       entry->value = value;
>>> +                     entry->pool = NULL;
>>>                       atomic_inc(&zswap_same_filled_pages);
>>>                       goto insert_entry;
>>>               }
>>> @@ -1555,28 +1510,31 @@ bool zswap_store(struct folio *folio)
>>>  insert_entry:
>>>       entry->swpentry = swp;
>>>       entry->objcg = objcg;
>>> -     if (objcg) {
>>> -             obj_cgroup_charge_zswap(objcg, entry->length);
>>> -             /* Account before objcg ref is moved to tree */
>>> -             count_objcg_event(objcg, ZSWPOUT);
>>> -     }
>>>
>>>       /* map */
>>> -     spin_lock(&tree->lock);
>>>       /*
>>>        * The folio may have been dirtied again, invalidate the
>>>        * possibly stale entry before inserting the new entry.
>>>        */
>>> -     if (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST) {
>>> -             zswap_invalidate_entry(tree, dupentry);
>>> -             WARN_ON(zswap_rb_insert(&tree->rbroot, entry, &dupentry));
>>> +     err = zswap_xa_insert(tree, entry, &old);
>>> +     if (old)
>>> +             zswap_entry_free(old);
>>> +     if (err) {
>>> +             old_erased = true;
>>> +             goto insert_failed;
>>>       }
>>
>> It looks a little complicated for me :( How do you think this like below?
>>
>> old = xa_store(tree, offset, entry, GFP_KERNEL);
>> if (xa_is_err(old))
> 
> Might want to bump up the ENOMEM error count if it is out of memory
> since zswap tracks it.

Right.

> 
>>         goto store_failed;
>>
>> if (old)
>>         zswap_entry_free(old);
>>
>> Then zswap_xa_insert() wrapper can be removed since no use elsewhere.
>> So the error handling path is kept much the same as before and simpler.
> 
> Sure.
> 
>>
>>> +
>>> +     if (objcg) {
>>> +             obj_cgroup_charge_zswap(objcg, entry->length);
>>> +             /* Account before objcg ref is moved to tree */
>>> +             count_objcg_event(objcg, ZSWPOUT);
>>> +     }
>>> +
>>>       if (entry->length) {
>>>               INIT_LIST_HEAD(&entry->lru);
>>>               zswap_lru_add(&zswap.list_lru, entry);
>>>               atomic_inc(&zswap.nr_stored);
>>>       }
>>> -     spin_unlock(&tree->lock);
>>>
>>>       /* update stats */
>>>       atomic_inc(&zswap_stored_pages);
>>> @@ -1585,6 +1543,12 @@ bool zswap_store(struct folio *folio)
>>>
>>>       return true;
>>>
>>> +insert_failed:
>>> +     if (!entry->length) {
>>> +             atomic_dec(&zswap_same_filled_pages);
>>> +             goto freepage;
>>> +     }
>>> +     zpool_free(zswap_find_zpool(entry), entry->handle);
>>
>> entry->pool can be used here instead of zswap_find_zpool().
> 
> Ack.
> 
> I was following the code in zswap_entry_free(). Does it mean the
> zswap_find_zpool(entry) can also use entry->pool?

Ah, I just see your other email, you are right, this is zpool.

Thanks.

> 
> Thanks for the feedback.
> 
> Chris
> 
>>
>> Thanks!
>>
>>>  put_pool:
>>>       zswap_pool_put(entry->pool);
>>>  freepage:
>>> @@ -1592,17 +1556,19 @@ bool zswap_store(struct folio *folio)
>>>  reject:
>>>       if (objcg)
>>>               obj_cgroup_put(objcg);
>>> +
>>> +     if (old_erased)
>>> +             goto failed;
>>>  check_old:
>>>       /*
>>>        * If the zswap store fails or zswap is disabled, we must invalidate the
>>>        * possibly stale entry which was previously stored at this offset.
>>>        * Otherwise, writeback could overwrite the new data in the swapfile.
>>>        */
>>> -     spin_lock(&tree->lock);
>>> -     entry = zswap_rb_search(&tree->rbroot, offset);
>>> +     entry = xa_erase(tree, offset);
>>>       if (entry)
>>> -             zswap_invalidate_entry(tree, entry);
>>> -     spin_unlock(&tree->lock);
>>> +             zswap_entry_free(entry);
>>> +failed:
>>>       return false;
>>>
>>>  shrink:
>>> @@ -1615,20 +1581,15 @@ bool zswap_load(struct folio *folio)
>>>       swp_entry_t swp = folio->swap;
>>>       pgoff_t offset = swp_offset(swp);
>>>       struct page *page = &folio->page;
>>> -     struct zswap_tree *tree = swap_zswap_tree(swp);
>>> +     struct xarray *tree = swap_zswap_tree(swp);
>>>       struct zswap_entry *entry;
>>>       u8 *dst;
>>>
>>>       VM_WARN_ON_ONCE(!folio_test_locked(folio));
>>>
>>> -     spin_lock(&tree->lock);
>>> -     entry = zswap_rb_search(&tree->rbroot, offset);
>>> -     if (!entry) {
>>> -             spin_unlock(&tree->lock);
>>> +     entry = xa_erase(tree, offset);
>>> +     if (!entry)
>>>               return false;
>>> -     }
>>> -     zswap_rb_erase(&tree->rbroot, entry);
>>> -     spin_unlock(&tree->lock);
>>>
>>>       if (entry->length)
>>>               zswap_decompress(entry, page);
>>> @@ -1652,19 +1613,17 @@ bool zswap_load(struct folio *folio)
>>>  void zswap_invalidate(swp_entry_t swp)
>>>  {
>>>       pgoff_t offset = swp_offset(swp);
>>> -     struct zswap_tree *tree = swap_zswap_tree(swp);
>>> +     struct xarray *tree = swap_zswap_tree(swp);
>>>       struct zswap_entry *entry;
>>>
>>> -     spin_lock(&tree->lock);
>>> -     entry = zswap_rb_search(&tree->rbroot, offset);
>>> +     entry = xa_erase(tree, offset);
>>>       if (entry)
>>> -             zswap_invalidate_entry(tree, entry);
>>> -     spin_unlock(&tree->lock);
>>> +             zswap_entry_free(entry);
>>>  }
>>>
>>>  int zswap_swapon(int type, unsigned long nr_pages)
>>>  {
>>> -     struct zswap_tree *trees, *tree;
>>> +     struct xarray *trees, *tree;
>>>       unsigned int nr, i;
>>>
>>>       nr = DIV_ROUND_UP(nr_pages, SWAP_ADDRESS_SPACE_PAGES);
>>> @@ -1674,11 +1633,8 @@ int zswap_swapon(int type, unsigned long nr_pages)
>>>               return -ENOMEM;
>>>       }
>>>
>>> -     for (i = 0; i < nr; i++) {
>>> -             tree = trees + i;
>>> -             tree->rbroot = RB_ROOT;
>>> -             spin_lock_init(&tree->lock);
>>> -     }
>>> +     for (i = 0; i < nr; i++)
>>> +             xa_init(trees + i);
>>>
>>>       nr_zswap_trees[type] = nr;
>>>       zswap_trees[type] = trees;
>>> @@ -1687,7 +1643,7 @@ int zswap_swapon(int type, unsigned long nr_pages)
>>>
>>>  void zswap_swapoff(int type)
>>>  {
>>> -     struct zswap_tree *trees = zswap_trees[type];
>>> +     struct xarray *trees = zswap_trees[type];
>>>       unsigned int i;
>>>
>>>       if (!trees)
>>> @@ -1695,7 +1651,7 @@ void zswap_swapoff(int type)
>>>
>>>       /* try_to_unuse() invalidated all the entries already */
>>>       for (i = 0; i < nr_zswap_trees[type]; i++)
>>> -             WARN_ON_ONCE(!RB_EMPTY_ROOT(&trees[i].rbroot));
>>> +             WARN_ON_ONCE(!xa_empty(trees + i));
>>>
>>>       kvfree(trees);
>>>       nr_zswap_trees[type] = 0;
>>> @@ -1727,6 +1683,8 @@ static int zswap_debugfs_init(void)
>>>                          zswap_debugfs_root, &zswap_reject_kmemcache_fail);
>>>       debugfs_create_u64("reject_compress_fail", 0444,
>>>                          zswap_debugfs_root, &zswap_reject_compress_fail);
>>> +     debugfs_create_u64("reject_xarray_fail", 0444,
>>> +                        zswap_debugfs_root, &zswap_reject_xarray_fail);
>>>       debugfs_create_u64("reject_compress_poor", 0444,
>>>                          zswap_debugfs_root, &zswap_reject_compress_poor);
>>>       debugfs_create_u64("written_back_pages", 0444,
>>>
>>> ---
>>> base-commit: 9a0181a3710eba1f5c6d19eadcca888be3d54e4f
>>> change-id: 20240104-zswap-xarray-716260e541e3
>>>
>>> Best regards,
>>

