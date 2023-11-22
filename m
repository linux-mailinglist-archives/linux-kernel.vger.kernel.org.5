Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123877F44F8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343568AbjKVLgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343665AbjKVLgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:36:12 -0500
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ad])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E92C197
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 03:36:06 -0800 (PST)
Message-ID: <b62a6eee-6823-47e0-a18a-964b60d247cd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700652964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A+u2pUc5K7L9escf+xjmfFFM1fdziTV6mQ+Rd8WwzS0=;
        b=fDn25h0qKBHq/fMrjbngwj79njZzsgyV1I4eAKKfA7fRDxCt+V5FniRnClzSsWqG0sBNDa
        3pOVW9X8p35Gpucxvwtf2hlLbVprHTxvgO/jVDWYfZnvz34Gj3b3MY4816lmp2Ly6qbKyn
        SPj7UamJrW+hq9MQ96eyOR2IIyu07/Q=
Date:   Wed, 22 Nov 2023 19:35:56 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v5 6/9] slub: Delay freezing of partial slabs
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, Mark Brown <broonie@kernel.org>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20231102032330.1036151-1-chengming.zhou@linux.dev>
 <20231102032330.1036151-7-chengming.zhou@linux.dev>
 <4f3bc1bd-ea87-465d-b58a-0ed57b15187b@sirena.org.uk>
 <83ff4b9e-94f1-8b35-1233-3dd414ea4dfe@suse.cz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <83ff4b9e-94f1-8b35-1233-3dd414ea4dfe@suse.cz>
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

On 2023/11/22 17:37, Vlastimil Babka wrote:
> On 11/20/23 19:49, Mark Brown wrote:
>> On Thu, Nov 02, 2023 at 03:23:27AM +0000, chengming.zhou@linux.dev wrote:
>>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>>
>>> Now we will freeze slabs when moving them out of node partial list to
>>> cpu partial list, this method needs two cmpxchg_double operations:
>>>
>>> 1. freeze slab (acquire_slab()) under the node list_lock
>>> 2. get_freelist() when pick used in ___slab_alloc()
>>
>> Recently -next has been failing to boot on a Raspberry Pi 3 with an arm
>> multi_v7_defconfig and a NFS rootfs, a bisect appears to point to this
>> patch (in -next as c8d312e039030edab25836a326bcaeb2a3d4db14) as having
>> introduced the issue.  I've included the full bisect log below.
>>
>> When we see problems we see RCU stalls while logging in, for example:
> 
> Can you try this, please?
> 

Great! I manually disabled __CMPXCHG_DOUBLE to reproduce the problem,
and this patch can solve the machine hang problem.

BTW, I also did the performance testcase on the machine with 128 CPUs.

stress-ng --rawpkt 128 --rawpkt-ops 100000000

base    patched
2.22s   2.35s
2.21s   3.14s
2.19s   4.75s

Found this atomic version performance numbers are not stable.

Should I change back to reuse the slab->__unused (mapcount) field?

Or should we check "s->flags & __CMPXCHG_DOUBLE" in slab_set/clear_node_partial()
to avoid using the atomic version?

Thanks!

> ----8<----
> From 000030c1ff055ef6a2ca624d0142f08f3ef19d51 Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Wed, 22 Nov 2023 10:32:41 +0100
> Subject: [PATCH] mm/slub: try to fix hangs without cmpxchg64/128
> 
> If we don't have cmpxchg64/128 and resort to slab_lock()/slab_unlock()
> which uses PG_locked, we can get RMW with the newly introduced
> slab_set/clear_node_partial() operation that modify PG_workingset so all
> the operations have to be atomic now.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index bcb5b2c4e213..f2cdb81ab02e 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -522,7 +522,7 @@ static __always_inline void slab_unlock(struct slab *slab)
>  	struct page *page = slab_page(slab);
>  
>  	VM_BUG_ON_PAGE(PageTail(page), page);
> -	__bit_spin_unlock(PG_locked, &page->flags);
> +	bit_spin_unlock(PG_locked, &page->flags);
>  }
>  
>  static inline bool
> @@ -2127,12 +2127,12 @@ static inline bool slab_test_node_partial(const struct slab *slab)
>  
>  static inline void slab_set_node_partial(struct slab *slab)
>  {
> -	__set_bit(PG_workingset, folio_flags(slab_folio(slab), 0));
> +	set_bit(PG_workingset, folio_flags(slab_folio(slab), 0));
>  }
>  
>  static inline void slab_clear_node_partial(struct slab *slab)
>  {
> -	__clear_bit(PG_workingset, folio_flags(slab_folio(slab), 0));
> +	clear_bit(PG_workingset, folio_flags(slab_folio(slab), 0));
>  }
>  
>  /*
