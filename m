Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403297DA4D9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 04:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbjJ1Cgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 22:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1Cgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 22:36:51 -0400
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B23590
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 19:36:48 -0700 (PDT)
Message-ID: <1199315b-63ce-4be4-8cde-b8b2fd29f91a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698460606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=etADSky/OaS5gb1oFEUv8DDHiwK9mtB5pub2uxFo0DE=;
        b=JBIXHfvv6v6VjGZ7MkMAqlT/c8McEQ/IlWxR4Vubo0TTQ/milFi/eOpUg+uHg3TYbcYPtW
        9bWPUFozKc1+MLs7/igxV/A4WuSZ2pVqWoracRM2KtpwSAp1kgPzuTZ+b9+LVFdlsNeF8k
        1YqmLMLmk+4UKYC8EEWzyYbJoYVZKYM=
Date:   Sat, 28 Oct 2023 10:36:08 +0800
MIME-Version: 1.0
Subject: Re: [RFC PATCH v3 0/7] slub: Delay freezing of CPU partial slabs
Content-Language: en-US
To:     Christoph Lameter <cl@linux.com>
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231024093345.3676493-1-chengming.zhou@linux.dev>
 <d5e40e42-ad02-e53d-c38f-09a4fdf1be88@linux.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <d5e40e42-ad02-e53d-c38f-09a4fdf1be88@linux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/28 01:57, Christoph Lameter wrote:
> On Tue, 24 Oct 2023, chengming.zhou@linux.dev wrote:
> 
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
> I think we have to clear our terminology a bit about what a "frozen" slab is.

Yes, we need to clean up these inconsistent documentations in the source.

> 
> Before this patch a frozen slab is not on the node partial list and therefore its state on the list does not have to be considered during freeing and other operations. The frozen slab could be actively allocated from.
> 
> From the source:
> 
> *   Frozen slabs
>  *
>  *   If a slab is frozen then it is exempt from list management. It is not
>  *   on any list except per cpu partial list. The processor that froze the

~~ except per cpu partial list ~~

Frozen slab is not on any list, it's actively allocated from by the processor
that froze it. IOW, frozen slab is the cpu slab.

>  *   slab is the one who can perform list operations on the slab. Other
>  *   processors may put objects onto the freelist but the processor that
>  *   froze the slab is the only one that can retrieve the objects from the
>  *   slab's freelist.
>  *

This part I think is unchanged.

> 
> 
> After this patch the PG_workingset indicates the state of being on the partial lists.
> 
> What does "frozen slab" then mean? The slab is being allocated from? Is that information useful or can we drop the frozen flag?

Right, frozen slab is the cpu slab, which is being allocated from by the cpu that froze it.

IMHO, the "frozen" bit is useful because:

1. PG_workingset is only useful on partial slab, which indicates the slab is on the node
   partial list, so we can manipulate its list in the __slab_free() path.

2. But for full slab (slab->freelist == NULL), PG_workingset is not much useful, we don't
   safely know whether it's used as the cpu slab or not just from this flag. So __slab_free()
   still rely on the "frozen" bit to know it.

3. And the maintaining of "frozen" has no extra cost now, since it's changed together with "freelist"
   and other counter using cmpxchg, we already have the cmpxchg when start to use a slab as the cpu slab.

Maybe I missed something, I don't know how to drop the frozen flag.

> 
> Update the definition?
> 

Ok, will add a cleanup patch to update.

Thanks!
