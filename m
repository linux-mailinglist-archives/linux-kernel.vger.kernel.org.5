Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF7D7DEA9D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 03:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348245AbjKBCTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 22:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjKBCTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 22:19:36 -0400
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [IPv6:2001:41d0:1004:224b::bd])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACD7120
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 19:19:30 -0700 (PDT)
Message-ID: <f38c7dd0-deec-4e55-9216-3c39925edef5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698891568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0zc20fVFKy4W9h0KGCjjTFtHtA4V+tYwK8sbCEwSZYE=;
        b=U36CUZibqC0+MoWHyMYJOLWR8uef9oka8hi7CkwX9g6Jt9nGWFsqLqKzQIfIzcGtCue04m
        T8fRH+UBIlJNzkGdenTucm/KMQLemuAym9FKElL1afbOqueynWi2sYN/KEdWjJdBovPjHk
        LJQmbbSGu4LaDJs1Gc/jUOlvi0EspCo=
Date:   Thu, 2 Nov 2023 10:19:18 +0800
MIME-Version: 1.0
Subject: Re: [RFC PATCH v4 0/9] slub: Delay freezing of CPU partial slabs
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, cl@linux.com, penberg@kernel.org,
        willy@infradead.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231031140741.79387-1-chengming.zhou@linux.dev>
 <029f5042-e41d-5079-fdba-fbe3d4e60dcf@suse.cz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <029f5042-e41d-5079-fdba-fbe3d4e60dcf@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/1 21:59, Vlastimil Babka wrote:
>> 3. Testing
>> ==========
>> We just did some simple testing on a server with 128 CPUs (2 nodes) to
>> compare performance for now.
>>
>>  - perf bench sched messaging -g 5 -t -l 100000
>>    baseline	RFC
>>    7.042s	6.966s
>>    7.022s	7.045s
>>    7.054s	6.985s
>>
>>  - stress-ng --rawpkt 128 --rawpkt-ops 100000000
>>    baseline	RFC
>>    2.42s	2.15s
>>    2.45s	2.16s
>>    2.44s	2.17s
> 
> Looks like these numbers are carried over from the first RFC. Could you
> please retest with v4 as there were some bigger changes (i.e. getting
> rid of acquire_slab()).
> 
> Otherwise I think v5 can drop "RFC" and will add it to slab tree after
> the merge window and 6.7-rc1. Thanks!

Ah, yes, I will retest v5 and update the numbers today.

Thanks!

> 
>> It shows above there is about 10% improvement on stress-ng rawpkt
>> testcase, although no much improvement on perf sched bench testcase.
>>
>> Thanks for any comment and code review!
>>
>> Chengming Zhou (9):
>>   slub: Reflow ___slab_alloc()
>>   slub: Change get_partial() interfaces to return slab
>>   slub: Keep track of whether slub is on the per-node partial list
>>   slub: Prepare __slab_free() for unfrozen partial slab out of node
>>     partial list
>>   slub: Introduce freeze_slab()
>>   slub: Delay freezing of partial slabs
>>   slub: Optimize deactivate_slab()
>>   slub: Rename all *unfreeze_partials* functions to *put_partials*
>>   slub: Update frozen slabs documentations in the source
>>
>>  mm/slub.c | 381 ++++++++++++++++++++++++++----------------------------
>>  1 file changed, 180 insertions(+), 201 deletions(-)
>>
