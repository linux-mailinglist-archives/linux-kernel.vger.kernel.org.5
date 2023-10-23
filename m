Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6245E7D4152
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 23:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjJWVFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 17:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJWVFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 17:05:13 -0400
X-Greylist: delayed 14699 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Oct 2023 14:05:11 PDT
Received: from gentwo.org (gentwo.org [IPv6:2a02:4780:10:3cd9::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50BD9D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:05:11 -0700 (PDT)
Received: by gentwo.org (Postfix, from userid 1003)
        id CE28448F4B; Mon, 23 Oct 2023 14:05:10 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id CD53748F48;
        Mon, 23 Oct 2023 14:05:10 -0700 (PDT)
Date:   Mon, 23 Oct 2023 14:05:10 -0700 (PDT)
From:   "Christoph Lameter (Ampere)" <cl@gentwo.org>
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     chengming.zhou@linux.dev, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, willy@infradead.org,
        pcc@google.com, tytso@mit.edu, maz@kernel.org,
        ruansy.fnst@fujitsu.com, vishal.moola@gmail.com,
        lrh2000@pku.edu.cn, hughd@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [RFC PATCH v2 0/6] slub: Delay freezing of CPU partial slabs
In-Reply-To: <ba3d6ac7-6900-3e8d-46b5-8302ca61f8ef@suse.cz>
Message-ID: <c6f12967-e7bc-bf36-9c6b-0111dea1f0de@gentwo.org>
References: <20231021144317.3400916-1-chengming.zhou@linux.dev> <4134b039-fa99-70cd-3486-3d0c7632e4a3@suse.cz> <fcb9b7f0-fb21-cce8-d452-766a5cc73d4a@gentwo.org> <ba3d6ac7-6900-3e8d-46b5-8302ca61f8ef@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023, Vlastimil Babka wrote:

>> For much of the frozen handling we must be holding the node list lock
>> anyways in order to add/remove from the list. So we already have a lock
>> that could be used to protect flag operations.
>
> I can see the following differences between the traditional frozen bit and
> the new flag:
>
> frozen bit advantage:
> - __slab_free() on an already-frozen slab can ignore list operations and
> list_lock completely
>
> frozen bit disadvantage:
> - acquire_slab() trying to do cmpxchg_double() under list_lock (see commit
> 9b1ea29bc0d7)


Ok so a slab is frozen if either of those conditions are met. That gets a 
bit complicated to test for. Can we just get away with the 
slab_node_partial flag?

The advantage with the frozen state is that it can be changed with a 
cmpxchg together with some other values (list pointer, counter) that need 
updating at free and allocation.

But frozen updates are rarer so maybe its worth to completely drop the 
frozen bit. If both need to be updates then we would have two atomic ops. 
One is the cmpxchg and the other the operation on the page flag.

