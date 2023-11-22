Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1D77F48ED
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbjKVO3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjKVO3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:29:14 -0500
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [IPv6:2001:41d0:203:375::bb])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF739A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:29:10 -0800 (PST)
Message-ID: <325f38f2-1c09-49a0-a882-d1818c2312ae@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700663348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=99YWFglF0T2/aZDMEN9bhlwnnr/AzORzK0PTg/nUzUE=;
        b=aYIjIGbN3SLSa2Gq5v9ENCwkTbACZV+mwdLroaKJZGwwO0wU3sqTtLoZznGbA6HpgatXvg
        drDvvQBfLzB9Up75jk1CtDbS99WArG4FvvWlFxMgi5AmB7Umj3ZW1N/DWbXR2MKASeMuoK
        jU1gfaIhSf9nWqMjJ0DFy8PkMfkYwJg=
Date:   Wed, 22 Nov 2023 22:28:37 +0800
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
 <b62a6eee-6823-47e0-a18a-964b60d247cd@linux.dev>
 <4ebc67be-8286-17e9-da33-225ed75509a6@suse.cz>
 <2af8c92f-0de8-4528-af43-6c6e8c1ebdf3@linux.dev>
 <42867716-5d3d-0252-5fd2-0f8b62498523@suse.cz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <42867716-5d3d-0252-5fd2-0f8b62498523@suse.cz>
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

On 2023/11/22 21:19, Vlastimil Babka wrote:
> On 11/22/23 12:54, Chengming Zhou wrote:
>> On 2023/11/22 19:40, Vlastimil Babka wrote:
>>> On 11/22/23 12:35, Chengming Zhou wrote:
>>>> On 2023/11/22 17:37, Vlastimil Babka wrote:
>>>>> On 11/20/23 19:49, Mark Brown wrote:
>>>>>> On Thu, Nov 02, 2023 at 03:23:27AM +0000, chengming.zhou@linux.dev wrote:
>>>>>>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>>>>>>
>>>>>>> Now we will freeze slabs when moving them out of node partial list to
>>>>>>> cpu partial list, this method needs two cmpxchg_double operations:
>>>>>>>
>>>>>>> 1. freeze slab (acquire_slab()) under the node list_lock
>>>>>>> 2. get_freelist() when pick used in ___slab_alloc()
>>>>>>
>>>>>> Recently -next has been failing to boot on a Raspberry Pi 3 with an arm
>>>>>> multi_v7_defconfig and a NFS rootfs, a bisect appears to point to this
>>>>>> patch (in -next as c8d312e039030edab25836a326bcaeb2a3d4db14) as having
>>>>>> introduced the issue.  I've included the full bisect log below.
>>>>>>
>>>>>> When we see problems we see RCU stalls while logging in, for example:
>>>>>
>>>>> Can you try this, please?
>>>>>
>>>>
>>>> Great! I manually disabled __CMPXCHG_DOUBLE to reproduce the problem,
>>>> and this patch can solve the machine hang problem.
>>>>
>>>> BTW, I also did the performance testcase on the machine with 128 CPUs.
>>>>
>>>> stress-ng --rawpkt 128 --rawpkt-ops 100000000
>>>>
>>>> base    patched
>>>> 2.22s   2.35s
>>>> 2.21s   3.14s
>>>> 2.19s   4.75s
>>>>
>>>> Found this atomic version performance numbers are not stable.
>>>
>>> That's weirdly too bad. Is that measured also with __CMPXCHG_DOUBLE
>>> disabled, or just the patch? The PG_workingset flag change should be
>>
>> The performance test is just the patch.
>>
>>> uncontended as we are doing it under list_lock, and with __CMPXCHG_DOUBLE
>>> there should be no interfering PG_locked interference.
>>>
>>
>> Yes, I don't know. Maybe it's related with my kernel config, making the
>> atomic operation much expensive? Will look again..
> 
> I doubt it can explain going from 2.19s to 4.75s, must have been some
> interference on the machine?
> 

Yes, it looks so. There are some background services on the 128 CPUs machine.
Although "stress-ng --rawpkt 128 --rawpkt-ops 100000000" has so much regression,
I tried other less contented testcases:

1. stress-ng --rawpkt 64 --rawpkt-ops 100000000
2. perf bench sched messaging -g 5 -t -l 100000

The performance numbers of this atomic version are pretty much the same.

So this atomic version should be good in most cases IMHO.

>> And I also tested the atomic-optional version like below, found the
>> performance numbers are much stable.
> 
> This gets rather ugly and fragile so I'd maybe rather go back to the
> __unused field approach :/
> 

Agree. If we don't want this atomic version, the __unused field approach
seems better.

Thanks!

