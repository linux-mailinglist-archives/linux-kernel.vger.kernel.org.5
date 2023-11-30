Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772CC7FEBA0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjK3JOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjK3JOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:14:01 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C461A8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:14:06 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DAEAE1FBF2;
        Thu, 30 Nov 2023 09:14:04 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBE6D1342E;
        Thu, 30 Nov 2023 09:14:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id jDaELVxSaGUJewAAD6G6ig
        (envelope-from <vbabka@suse.cz>); Thu, 30 Nov 2023 09:14:04 +0000
Message-ID: <dbc38932-8a68-6feb-2148-615f5c2a446e@suse.cz>
Date:   Thu, 30 Nov 2023 10:14:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RFC v3 0/9] SLUB percpu array caches and maple tree nodes
Content-Language: en-US
To:     "Christoph Lameter (Ampere)" <cl@linux.com>
Cc:     Pekka Enberg <penberg@kernel.org>,
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
References: <20231129-slub-percpu-caches-v3-0-6bcf536772bc@suse.cz>
 <b51bfc04-d770-3385-736a-01aa733c4622@linux.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <b51bfc04-d770-3385-736a-01aa733c4622@linux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
        none
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-4.00 / 50.00];
         TAGGED_RCPT(0.00)[];
         REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: DAEAE1FBF2
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/23 21:16, Christoph Lameter (Ampere) wrote:
> On Wed, 29 Nov 2023, Vlastimil Babka wrote:
> 
>> At LSF/MM I've mentioned that I see several use cases for introducing
>> opt-in percpu arrays for caching alloc/free objects in SLUB. This is my
>> first exploration of this idea, speficially for the use case of maple
>> tree nodes. The assumptions are:
> 
> Hohumm... So we are not really removing SLAB but merging SLAB features 
> into SLUB.

Hey, you've tried a similar thing back in 2010 too :)
https://lore.kernel.org/all/20100521211541.003062117@quilx.com/

In addition to per cpu slabs, we now have per cpu queues.

But importantly, it's very consciously opt-in. Whether the caches using
percpu arrays can also skip per cpu (partial) slabs, remains to be seen.

>> - percpu arrays will be faster thank bulk alloc/free which needs
>>  relatively long freelists to work well. Especially in the freeing case
>>  we need the nodes to come from the same slab (or small set of those)
> 
> Percpu arrays require the code to handle individual objects. Handling 
> freelists in partial SLABS means that numerous objects can be handled at 
> once by handling the pointer to the list of objects.
> 
> In order to make the SLUB in page freelists work better you need to have 
> larger freelist and that comes with larger page sizes. I.e. boot with
> slub_min_order=5 or so to increase performance.

In the freeing case, you might still end up with objects mixed from
different slab pages, so the detached freelist building will be inefficient.

> Also this means increasing TLB pressure. The in page freelists of SLUB 
> cause objects from the same page be served. The SLAB queueing approach
> results in objects being mixed from any address and thus neighboring 
> objects may require more TLB entries.

As Willy noted, we have 1GB entries in directmap. Also we found out that
even if there are actions that cause it to fragment, it's not worth trying
to minimize the fragmentations - https://lwn.net/Articles/931406/

>> - preallocation for the worst case of needed nodes for a tree operation
>>  that can't reclaim due to locks is wasteful. We could instead expect
>>  that most of the time percpu arrays would satisfy the constained
>>  allocations, and in the rare cases it does not we can dip into
>>  GFP_ATOMIC reserves temporarily. So instead of preallocation just
>>  prefill the arrays.
> 
> The partial percpu slabs could already do the same.

Possibly for the prefill, but efficient freeing will always be an issue.

>> - NUMA locality of the nodes is not a concern as the nodes of a
>>  process's VMA tree end up all over the place anyway.
> 
> NUMA locality is already controlled by the user through the node 
> specification for percpu slabs. All objects coming from the same in page 
> freelist of SLUB have the same NUMA locality which simplifies things.
> 
> If you would consider NUMA locality for the percpu array then you'd be
> back to my beloved alien caches. We were not able to avoid that when we 
> tuned SLAB for maximum performance.

True, it's easier not to support NUMA locality.

>> Patch 5 adds the per-cpu array caches support. Locking is stolen from
>> Mel's recent page allocator's pcplists implementation so it can avoid
>> disabling IRQs and just disable preemption, but the trylocks can fail in
>> rare situations - in most cases the locks are uncontended so the locking
>> should be cheap.
> 
> Ok the locking is new but the design follows basic SLAB queue handling.

