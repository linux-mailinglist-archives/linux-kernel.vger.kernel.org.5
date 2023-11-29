Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403927FE0DC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 21:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbjK2UQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 15:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjK2UQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 15:16:13 -0500
Received: from gentwo.org (gentwo.org [62.72.0.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7B5D69
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:16:17 -0800 (PST)
Received: by gentwo.org (Postfix, from userid 1003)
        id 5A51448CA3; Wed, 29 Nov 2023 12:16:17 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 5921C430F2;
        Wed, 29 Nov 2023 12:16:17 -0800 (PST)
Date:   Wed, 29 Nov 2023 12:16:17 -0800 (PST)
From:   "Christoph Lameter (Ampere)" <cl@linux.com>
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH RFC v3 0/9] SLUB percpu array caches and maple tree
 nodes
In-Reply-To: <20231129-slub-percpu-caches-v3-0-6bcf536772bc@suse.cz>
Message-ID: <b51bfc04-d770-3385-736a-01aa733c4622@linux.com>
References: <20231129-slub-percpu-caches-v3-0-6bcf536772bc@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023, Vlastimil Babka wrote:

> At LSF/MM I've mentioned that I see several use cases for introducing
> opt-in percpu arrays for caching alloc/free objects in SLUB. This is my
> first exploration of this idea, speficially for the use case of maple
> tree nodes. The assumptions are:

Hohumm... So we are not really removing SLAB but merging SLAB features 
into SLUB. In addition to per cpu slabs, we now have per cpu queues.

> - percpu arrays will be faster thank bulk alloc/free which needs
>  relatively long freelists to work well. Especially in the freeing case
>  we need the nodes to come from the same slab (or small set of those)

Percpu arrays require the code to handle individual objects. Handling 
freelists in partial SLABS means that numerous objects can be handled at 
once by handling the pointer to the list of objects.

In order to make the SLUB in page freelists work better you need to have 
larger freelist and that comes with larger page sizes. I.e. boot with
slub_min_order=5 or so to increase performance.

Also this means increasing TLB pressure. The in page freelists of SLUB 
cause objects from the same page be served. The SLAB queueing approach
results in objects being mixed from any address and thus neighboring 
objects may require more TLB entries.

> - preallocation for the worst case of needed nodes for a tree operation
>  that can't reclaim due to locks is wasteful. We could instead expect
>  that most of the time percpu arrays would satisfy the constained
>  allocations, and in the rare cases it does not we can dip into
>  GFP_ATOMIC reserves temporarily. So instead of preallocation just
>  prefill the arrays.

The partial percpu slabs could already do the same.

> - NUMA locality of the nodes is not a concern as the nodes of a
>  process's VMA tree end up all over the place anyway.

NUMA locality is already controlled by the user through the node 
specification for percpu slabs. All objects coming from the same in page 
freelist of SLUB have the same NUMA locality which simplifies things.

If you would consider NUMA locality for the percpu array then you'd be
back to my beloved alien caches. We were not able to avoid that when we 
tuned SLAB for maximum performance.

> Patch 5 adds the per-cpu array caches support. Locking is stolen from
> Mel's recent page allocator's pcplists implementation so it can avoid
> disabling IRQs and just disable preemption, but the trylocks can fail in
> rare situations - in most cases the locks are uncontended so the locking
> should be cheap.

Ok the locking is new but the design follows basic SLAB queue handling.
