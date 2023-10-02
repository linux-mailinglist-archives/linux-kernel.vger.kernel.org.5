Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36647B5197
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 13:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbjJBLo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 07:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjJBLo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:44:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B556193
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 04:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696247015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LdWQ9z8fOkBkb74XxqcIV2JNA2pnsgRxBSJgOXL/JUc=;
        b=eAAic6Ql4riwEsr9shSxAtzqsETXIEAymMIavoCMz0CaMvQ0CMZUywaHYJUxDhd/iBhj8i
        MaNEtJbnrBd6R4jVoJZ/TkfodNMqWL+aA2YA9KSNNlAH//jWOIXXZjfsx+aHdAbDHauRDw
        C0h0ZO7o0L4+jZa2bIZ3jsBdytKWJxM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-UzFoxvswPTaDJ_-nT4Vo6g-1; Mon, 02 Oct 2023 07:43:33 -0400
X-MC-Unique: UzFoxvswPTaDJ_-nT4Vo6g-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-32172e3679bso12576989f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 04:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696247012; x=1696851812;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LdWQ9z8fOkBkb74XxqcIV2JNA2pnsgRxBSJgOXL/JUc=;
        b=ElSyl42KBdsblUwyFXP30q9azU5DA5YueM6ZTrAph5PEUetK6zdXwpCMWdHabTwGHq
         cNLe0UJ5aDb1oA9FhNlkhCM5hJMqhjxrmOiAPl9cVnCvmtUHx9KeB++nvGTOI2CWN+TH
         XcPLYCDJk3YBKn/jOistkcw8QVMb4IlH7+8x94sH29MLqyO+7owNwxmplq16AGO95DbJ
         +z7DF8gFX9uVnBC7S3yRW80QlIvMejDoXzVksqIHc4t4N7dbuE6XUEEeIgi7wsoMpzZ1
         llv/EN89ENkwOpxZhZzhdmeElELdEcvTzLDuAKgsbhO4d1Npfu5vF/a+FsMGGrcvnxUM
         oRYg==
X-Gm-Message-State: AOJu0Yy8/2Ei2NkjSBcnpfVPtxsKugpf+HB5ai+c2tdHefe3Gr1G6DRX
        +6Qoqtj2unJCvF7MFxr5IV4pMwX7KfHoSkOjjueCU7vqo0Z41MQWdGf6j34GkIa+HXqqGT2ZK0B
        li5EWC3LEfq1o578c5ie715p5
X-Received: by 2002:a05:6000:109:b0:317:f70b:3156 with SMTP id o9-20020a056000010900b00317f70b3156mr9388988wrx.28.1696247012526;
        Mon, 02 Oct 2023 04:43:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2VtYKpfiI7DgOq24joo0XGjgOCqAtFXichvVpOWYSLVbPNVAtso2DOpQ0xzD71nGgtOVKCw==
X-Received: by 2002:a05:6000:109:b0:317:f70b:3156 with SMTP id o9-20020a056000010900b00317f70b3156mr9388972wrx.28.1696247012075;
        Mon, 02 Oct 2023 04:43:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:f200:cb49:cb8f:88fc:9446? (p200300cbc735f200cb49cb8f88fc9446.dip0.t-ipconnect.de. [2003:cb:c735:f200:cb49:cb8f:88fc:9446])
        by smtp.gmail.com with ESMTPSA id o5-20020adfeac5000000b0031984b370f2sm27838751wrn.47.2023.10.02.04.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 04:43:31 -0700 (PDT)
Message-ID: <ac73d772-c585-1d9e-c8ee-36c51b608906@redhat.com>
Date:   Mon, 2 Oct 2023 13:43:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <a88b7339-beab-37c6-7d32-0292b325916d@suse.cz>
 <20230918145204.GB16104@cmpxchg.org> <20230918174037.GA112714@monkey>
 <20230919064914.GA124289@cmpxchg.org> <20230919184731.GC112714@monkey>
 <C416A861-44D3-46E7-B756-63DA3731FC1E@nvidia.com>
 <20230920003239.GD112714@monkey>
 <149ACAE8-D3E4-4009-828A-D3AC881FFB9C@nvidia.com>
 <bc4bd049-1e29-0f23-cca6-493abb5e774f@suse.cz>
 <20230920134811.GB124289@cmpxchg.org> <20230920160400.GC124289@cmpxchg.org>
 <762CA634-053A-41DD-8ED7-895374640858@nvidia.com>
 <D4F59724-61EB-4DA5-94DF-59E79F0F1FB3@nvidia.com>
 <505e7f55-f63a-b33d-aa10-44de16d2d3cc@redhat.com>
 <4466F447-43D3-43CD-8930-FBE9A49028BA@nvidia.com>
 <98f3e433-153d-5dd8-c868-30f703baeb46@redhat.com>
 <6DD1F426-A87D-47B7-B27F-043B399CBEDA@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH V2 0/6] mm: page_alloc: freelist migratetype hygiene
In-Reply-To: <6DD1F426-A87D-47B7-B27F-043B399CBEDA@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> I can do it after I fix this. That change might or might not help only if we make
>>> some redesign on how migratetype is managed. If MIGRATE_ISOLATE does not
>>> overwrite existing migratetype, the code might not need to split a page and move
>>> it to MIGRATE_ISOLATE freelist?
>>
>> Did someone test how memory offlining plays along with that? (I can try myself
>> within the next 1-2 weeks)
>>
>> There [mm/memory_hotplug.c:offline_pages] we always cover full MAX_ORDER ranges,
>> though.
>>
>> ret = start_isolate_page_range(start_pfn, end_pfn,
>> 			       MIGRATE_MOVABLE,
>> 			       MEMORY_OFFLINE | REPORT_FAILURE,
>> 			       GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL);
> 
> Since a full MAX_ORDER range is passed, no free page split will happen.

Okay, thanks for verifying that it should not be affected!

> 
>>
>>>
>>> The fundamental issue in alloc_contig_range() is that to work at
>>> pageblock level, a page (>pageblock_order) can have one part is isolated and
>>> the rest is a different migratetype. {add_to,move_to,del_page_from}_free_list()
>>> now checks first pageblock migratetype, so such a page needs to be removed
>>> from its free_list, set MIGRATE_ISOLATE on one of the pageblock, split, and
>>> finally put back to multiple free lists. This needs to be done at isolation stage
>>> before free pages are removed from their free lists (the stage after isolation).
>>
>> One idea was to always isolate larger chunks, and handle movability checks/split/etc
>> at a later stage. Once isolation would be decoupled from the actual/original migratetype,
>> the could have been easier to handle (especially some corner cases I had in mind back then).
> 
> I think it is a good idea. When I coded alloc_contig_range() up, I tried to
> accommodate existing set_migratetype_isolate(), which calls has_unmovable_pages().
> If these two are decoupled, set_migrateype_isolate() can work on MAX_ORDER-aligned
> ranges and has_unmovable_pages() can still work on pageblock-aligned ranges.
> Let me give this a try.
> 

But again, just some thought I had back then, maybe it doesn't help for 
anything; I found more time to look into the whole thing in more detail.

>>
>>> If MIGRATE_ISOLATE is a separate flag and we are OK with leaving isolated pages
>>> in their original migratetype and check migratetype before allocating a page,
>>> that might help. But that might add extra work (e.g., splitting a partially
>>> isolated free page before allocation) in the really hot code path, which is not
>>> desirable.
>>
>> With MIGRATE_ISOLATE being a separate flag, one idea was to have not a single
>> separate isolate list, but one per "proper migratetype". But again, just some random
>> thoughts I had back then, I never had sufficient time to think it all through.
> 
> Got it. I will think about it.
> 
> One question on separate MIGRATE_ISOLATE:
> 
> the implementation I have in mind is that MIGRATE_ISOLATE will need a dedicated flag
> bit instead of being one of migratetype. But now there are 5 migratetypes +

Exactly what I was concerned about back then ...

> MIGRATE_ISOLATE and PB_migratetype_bits is 3, so an extra migratetype_bit is needed.
> But current migratetype implementation is a word-based operation, requiring
> NR_PAGEBLOCK_BITS to be divisor of BITS_PER_LONG. This means NR_PAGEBLOCK_BITS
> needs to be increased from 4 to 8 to meet the requirement, wasting a lot of space.

... until I did the math. Let's assume a pageblock is 2 MiB.

4/(2* 1024 * 1024 * 8) = 0,00002384185791016 %

8/(2* 1024 * 1024 * 8) -> 1 / (2* 1024 * 1024) = 0,00004768371582031 %

For a 1 TiB machine that means 256 KiB vs. 512 KiB

I concluded that "wasting a lot of space" is not really the right word 
to describe that :)

Just to put it into perspective, the memmap (64/4096) for a 1 TiB 
machine is ... 16 GiB.

> An alternative is to have a separate array for MIGRATE_ISOLATE, which requires
> additional changes. Let me know if you have a better idea. Thanks.

It would probably be cleanest to just use one byte per pageblock. That 
would cleanup the whole machinery eventually as well.

-- 
Cheers,

David / dhildenb

