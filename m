Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164C87D4E7F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 13:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjJXLDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 07:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjJXLDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 07:03:22 -0400
Received: from out-209.mta1.migadu.com (out-209.mta1.migadu.com [95.215.58.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B1F109
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 04:03:20 -0700 (PDT)
Message-ID: <f4739117-ac81-4831-820b-60b496c7dd61@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698145398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pnFxFP6a7DC4iJ/6GwDjjDb4geFq6Fz2jY2wNEaiS7k=;
        b=jKwIBvyPM2uA62TA6wyKo/Lq3aaRaNCjr9vCoIifxAicQgMoTLgsuSkuh0uK10cuL7URWL
        FJsiTWdcjjlZq/hXmcivjEyoRlXg9Ba5f8aPyRNoEhvnDOj9YuwSsQWeULiMBB/yoLNFcP
        aaHspv/BG+IAoOZdZ0ILwo4e4by/JlE=
Date:   Tue, 24 Oct 2023 19:03:10 +0800
MIME-Version: 1.0
Subject: Re: [RFC PATCH v2 0/6] slub: Delay freezing of CPU partial slabs
Content-Language: en-US
To:     "Christoph Lameter (Ampere)" <cl@gentwo.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, willy@infradead.org, pcc@google.com,
        tytso@mit.edu, maz@kernel.org, ruansy.fnst@fujitsu.com,
        vishal.moola@gmail.com, lrh2000@pku.edu.cn, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231021144317.3400916-1-chengming.zhou@linux.dev>
 <4134b039-fa99-70cd-3486-3d0c7632e4a3@suse.cz>
 <fcb9b7f0-fb21-cce8-d452-766a5cc73d4a@gentwo.org>
 <ba3d6ac7-6900-3e8d-46b5-8302ca61f8ef@suse.cz>
 <c6f12967-e7bc-bf36-9c6b-0111dea1f0de@gentwo.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <c6f12967-e7bc-bf36-9c6b-0111dea1f0de@gentwo.org>
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

On 2023/10/24 05:05, Christoph Lameter (Ampere) wrote:
> On Mon, 23 Oct 2023, Vlastimil Babka wrote:
> 
>>> For much of the frozen handling we must be holding the node list lock
>>> anyways in order to add/remove from the list. So we already have a lock
>>> that could be used to protect flag operations.
>>
>> I can see the following differences between the traditional frozen bit and
>> the new flag:
>>
>> frozen bit advantage:
>> - __slab_free() on an already-frozen slab can ignore list operations and
>> list_lock completely
>>
>> frozen bit disadvantage:
>> - acquire_slab() trying to do cmpxchg_double() under list_lock (see commit
>> 9b1ea29bc0d7)
> 
> 
> Ok so a slab is frozen if either of those conditions are met. That gets a bit complicated to test for. Can we just get away with the slab_node_partial flag?
> 
> The advantage with the frozen state is that it can be changed with a cmpxchg together with some other values (list pointer, counter) that need updating at free and allocation.
> 
> But frozen updates are rarer so maybe its worth to completely drop the frozen bit. If both need to be updates then we would have two atomic ops. One is the cmpxchg and the other the operation on the page flag.
> 

This introduced page flag bit is using non-atomic operations, which is protected
by the node list_lock.

As for completely dropping the "frozen" bit, I find it hard because we have the
DEACTIVATE_BYPASS optimization in get_freelist(), which clear the "frozen" bit
without the synchronization of node list_lock. So __slab_free() still need to
rely on the "frozen" bit for CPU active slab.

This patch series mainly optimize the cmpxchg cost in moving partial slabs
between node partial list and CPU partial list, and alleviate the contention
of node list_lock meanwhile.

Thanks!
