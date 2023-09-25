Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D8D7ACEB5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 05:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjIYDZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 23:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjIYDZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 23:25:44 -0400
Received: from out-197.mta0.migadu.com (out-197.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D58FA3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 20:25:37 -0700 (PDT)
Message-ID: <798ddb57-ba09-e337-01b3-c80711f1e277@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695612335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m6vPV8LMOzVMcoIBD4Pznx00zoA77Ft1Xl6It5vC6EA=;
        b=vKoj5PBKW1/qs/WVw0zO5MFXtb0jRZYZ0zYB7KwBrpF4QYevBdIrdHLqkd+S+dldpHi49H
        jkog9OtlQFsd2mLAXFNIXg/LY7Vkyydiyr6PobeljxqEN9FUCE+1OkKFrqx2sq8BRnmv03
        TTlr02kB7HTHv9DZ+K0mdTBxtYMIXjg=
Date:   Mon, 25 Sep 2023 11:23:03 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] mm: pass set_count and set_reserved to
 __init_single_page
To:     Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, muchun.song@linux.dev, glider@google.com,
        elver@google.com, dvyukov@google.com, osalvador@suse.de,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
References: <20230922070923.355656-1-yajun.deng@linux.dev>
 <20230922070923.355656-2-yajun.deng@linux.dev>
 <ZQ1Gg533lODfqvWd@casper.infradead.org>
 <2ed9a6c5-bd36-9b9b-7022-34e7ae894f3a@redhat.com>
 <20230922080831.GH3303@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <20230922080831.GH3303@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 2023/9/22 16:08, Mike Rapoport wrote:
> On Fri, Sep 22, 2023 at 09:48:59AM +0200, David Hildenbrand wrote:
>> On 22.09.23 09:47, Matthew Wilcox wrote:
>>> On Fri, Sep 22, 2023 at 03:09:20PM +0800, Yajun Deng wrote:
>>>> -		__init_single_page(page, pfn, zone, nid);
>>>> +		__init_single_page(page, pfn, zone, nid, true, false);
>>> So Linus has just had a big rant about not doing bool flags to
>>> functions.  And in particular _multiple_ bool flags to functions.
>>>
>>> ie this should be:
>>>
>>> #define INIT_PAGE_COUNT		(1 << 0)
>>> #define INIT_PAGE_RESERVED	(1 << 1)
>>>
>>> 		__init_single_page(page, pfn, zone, nid, INIT_PAGE_COUNT);
>>>
>>> or something similar.
>>>
>>> I have no judgement on the merits of this patch so far.  Do you have
>>> performance numbers for each of these patches?  Some of them seem quite
>>> unlikely to actually help, at least on a machine which is constrained
>>> by cacheline fetches.
>> The last patch contains
>>
>> before:
>> node 0 deferred pages initialised in 78ms
>>
>> after:
>> node 0 deferred pages initialised in 72ms
>>
>> Not earth-shattering :D Maybe with much bigger machines relevant?
> Patch 3 contains
>
> The following data was tested on an x86 machine with 190GB of RAM.
>
> before:
> free_low_memory_core_early()    342ms
>
> after:
> free_low_memory_core_early()    286ms
>
> Which is more impressive, but still I'm not convinced that it's worth the
> added complexity and potential subtle bugs.
>
I will send v2.  It will be simpler and safer.
>> -- 
>> Cheers,
>>
>> David / dhildenb
>>
