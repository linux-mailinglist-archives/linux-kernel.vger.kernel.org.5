Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62EBB7DEAD0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 03:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbjKBCss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 22:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjKBCsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 22:48:47 -0400
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6280D8E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 19:48:41 -0700 (PDT)
Message-ID: <b8a5cba5-e01e-4627-b775-85928edb1722@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698893319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kchOEnv+0+G+NTW2ZTXj19K8ovH9eGO5OxgkkLRBKSc=;
        b=s3TDnI7NaTzsW5+1iIijs5G+fJJjdXby6MT2LJOvjPjIVlcKzEVEwIjZd5Q9tC2k5Vofn7
        luHa3KYhVXZ/wGRAx8/pcgiJj3WYKgqWAXfDOTePM56UBpJEdDLQlSbe3wJfNtDPtfbjvI
        UJPZ8YE7YSeIlEthD2kYj34DgLsU5NU=
Date:   Thu, 2 Nov 2023 10:48:10 +0800
MIME-Version: 1.0
Subject: Re: [RFC PATCH v4 9/9] slub: Update frozen slabs documentations in
 the source
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, cl@linux.com, penberg@kernel.org,
        willy@infradead.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231031140741.79387-1-chengming.zhou@linux.dev>
 <20231031140741.79387-10-chengming.zhou@linux.dev>
 <211ac705-5972-9b39-73f1-a608e65b6de3@suse.cz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <211ac705-5972-9b39-73f1-a608e65b6de3@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/1 21:51, Vlastimil Babka wrote:
> On 10/31/23 15:07, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> The current updated scheme (which this series implemented) is:
>>  - node partial slabs: PG_Workingset && !frozen
>>  - cpu partial slabs: !PG_Workingset && !frozen
>>  - cpu slabs: !PG_Workingset && frozen
>>  - full slabs: !PG_Workingset && !frozen
> 
> It could be useful to put this also to the initial comment description.
> Towards the end of the comment, there's a block explaining
> "slab->frozen". It could be extended to cover all 4 combination (but not
> all of them need such long explanation).
> 

Ok, I will extend it and put in the cover letter of v5.

>>
>> The most important change is that "frozen" bit is not set for the
>> cpu partial slabs anymore, __slab_free() will grab node list_lock
>> then check by !PG_Workingset that it's not on a node partial list.
>>
>> And the "frozen" bit is still kept for the cpu slabs for performance,
>> since we don't need to grab node list_lock to check whether the
>> PG_Workingset is set or not if the "frozen" bit is set in __slab_free().
>>
>> Update related documentations and comments in the source.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  mm/slub.c | 16 ++++++++++++----
>>  1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index bb7368047103..89d3f7a18a73 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -76,13 +76,22 @@
>>   *
>>   *   Frozen slabs
>>   *
>> - *   If a slab is frozen then it is exempt from list management. It is not
>> - *   on any list except per cpu partial list. The processor that froze the
>> + *   If a slab is frozen then it is exempt from list management. It is
>> + *   the cpu slab which is actively allocated from by the processor that
>> + *   froze it and it is not on any list. The processor that froze the
>>   *   slab is the one who can perform list operations on the slab. Other
>>   *   processors may put objects onto the freelist but the processor that
>>   *   froze the slab is the only one that can retrieve the objects from the
>>   *   slab's freelist.
>>   *
>> + *   CPU partial slabs
>> + *
>> + *   The partially empty slabs cached on the CPU partial list are used
>> + *   for performance reasons, which speeds up the allocation process.
>> + *   These slabs are not frozen, but also exempt from list management,
> 
> 					^ are also
> 
> (otherwise somebody could read it as "also are not")
> 

Ah, will fix.

Thanks!
