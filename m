Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475F67D3D10
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjJWRIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjJWRIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:08:18 -0400
X-Greylist: delayed 481 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Oct 2023 10:08:14 PDT
Received: from gentwo.org (gentwo.org [62.72.0.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFA694
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:08:14 -0700 (PDT)
Received: by gentwo.org (Postfix, from userid 1003)
        id 5066248F4B; Mon, 23 Oct 2023 10:00:11 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 4D21248F48;
        Mon, 23 Oct 2023 10:00:11 -0700 (PDT)
Date:   Mon, 23 Oct 2023 10:00:11 -0700 (PDT)
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
In-Reply-To: <4134b039-fa99-70cd-3486-3d0c7632e4a3@suse.cz>
Message-ID: <fcb9b7f0-fb21-cce8-d452-766a5cc73d4a@gentwo.org>
References: <20231021144317.3400916-1-chengming.zhou@linux.dev> <4134b039-fa99-70cd-3486-3d0c7632e4a3@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023, Vlastimil Babka wrote:

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
>
> Or more precisely, instead of returning the acquired "object" we would
> return the first slab removed from partial list. I think it would simplify
> the code a bit, and further reduce list_lock holding times.
>
> I'll also point out a few more details, but it's not a full detailed review
> as the suggestion above, and another for 4/5, could mean a rather
> significant change for v3.

This is not that easy. The frozen bit indicates that list management does 
not have to be done for a slab if its processed in free. If you take a 
slab off the list without setting that bit then something else needs to 
provide the information that "frozen" provided.

If the frozen bit changes can be handled in a different way than 
with cmpxchg then that is a good optimization.

For much of the frozen handling we must be holding the node list lock 
anyways in order to add/remove from the list. So we already have a lock 
that could be used to protect flag operations.

