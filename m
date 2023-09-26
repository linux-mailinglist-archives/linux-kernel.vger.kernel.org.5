Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288797AF286
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 20:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbjIZSUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 14:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjIZSUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 14:20:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E72E5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 11:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695752386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X9Od3GBBiFpA3zXzyNR6oM6boLSTS87ppA/tBVrGnKQ=;
        b=InyiX5Vv1DG+5PPrltJg02UuDNSdbeiaZELTeNd3twOL3QZWZjs3yQotgKc8CrVVcIFTdg
        AdY6rY7a3SoWy6Yb3aydhIkEBE+ihvrbDfe5zszuBxS0Csii9AmJNDF6LJi1jzrATN2sqO
        CYy3fFtHCtpZggEo8PzBog9fIxyqp/s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-Z-EtqyDHO_K1EcoTYN3O3A-1; Tue, 26 Sep 2023 14:19:44 -0400
X-MC-Unique: Z-EtqyDHO_K1EcoTYN3O3A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f42bcef2acso80156075e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 11:19:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695752383; x=1696357183;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X9Od3GBBiFpA3zXzyNR6oM6boLSTS87ppA/tBVrGnKQ=;
        b=jQPbco4vIUifVpx82IaTY6RGVFNOD9jHW9pvGuC/U8lldJiMhk3ueUUA/+gwjSN/dp
         X4uXvLkhDhrzNCvUIvdNsuOOpxOxxFHtnWkV3HUbSzxmMKwio5ytEJ3gRXP+NsU8Q7jD
         Jb0szUieGfFrjLhCJNuYjVRx6BPWuRZvgili2b+HtwessOmkTHmZ2Vu4T3szi0Wk3Vdl
         Xb5VelBZpsto6w47WooX3yap7gIQ2vEUG2Ljts6OwarbnxGD2RGLwcYxq7lIj64dWmHY
         iOFtgFisih/RxDgIsOzeK1E3RMMV0TNk79ZeCK0KC9wSLEFFlwlTR1g0q9aqbNo2GM1M
         hUpQ==
X-Gm-Message-State: AOJu0YwlPHYTVgJQwW6T7/v796FiQ2eyid0eXya6s6OpgMwxA/IbiRIk
        NftpLlpAweIcDuyvbmcYz7/4IEAnfOyANHaSF257T6TxQjJYjEBZajGMpZS0lqQiObvyY44YH2P
        AegNhNt/yKBDYmZF28EWX382/
X-Received: by 2002:a1c:6a0c:0:b0:402:8c7e:ba5 with SMTP id f12-20020a1c6a0c000000b004028c7e0ba5mr9417688wmc.18.1695752383261;
        Tue, 26 Sep 2023 11:19:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmhqLCNiRYXEG41MMFujunrgzezSxSvnBsvLDMRqCRPSe56rzeBH0g/lAUjuBkyU8VQ19Jjg==
X-Received: by 2002:a1c:6a0c:0:b0:402:8c7e:ba5 with SMTP id f12-20020a1c6a0c000000b004028c7e0ba5mr9417666wmc.18.1695752382738;
        Tue, 26 Sep 2023 11:19:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73f:600:933b:ca69:5a80:230d? (p200300cbc73f0600933bca695a80230d.dip0.t-ipconnect.de. [2003:cb:c73f:600:933b:ca69:5a80:230d])
        by smtp.gmail.com with ESMTPSA id z4-20020a05600c220400b0040472ad9a3dsm2716493wml.14.2023.09.26.11.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 11:19:42 -0700 (PDT)
Message-ID: <98f3e433-153d-5dd8-c868-30f703baeb46@redhat.com>
Date:   Tue, 26 Sep 2023 20:19:41 +0200
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH V2 0/6] mm: page_alloc: freelist migratetype hygiene
In-Reply-To: <4466F447-43D3-43CD-8930-FBE9A49028BA@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.09.23 16:47, Zi Yan wrote:
> On 21 Sep 2023, at 6:19, David Hildenbrand wrote:
> 
>> On 21.09.23 04:31, Zi Yan wrote:
>>> On 20 Sep 2023, at 13:23, Zi Yan wrote:
>>>
>>>> On 20 Sep 2023, at 12:04, Johannes Weiner wrote:
>>>>
>>>>> On Wed, Sep 20, 2023 at 09:48:12AM -0400, Johannes Weiner wrote:
>>>>>> On Wed, Sep 20, 2023 at 08:07:53AM +0200, Vlastimil Babka wrote:
>>>>>>> On 9/20/23 03:38, Zi Yan wrote:
>>>>>>>> On 19 Sep 2023, at 20:32, Mike Kravetz wrote:
>>>>>>>>
>>>>>>>>> On 09/19/23 16:57, Zi Yan wrote:
>>>>>>>>>> On 19 Sep 2023, at 14:47, Mike Kravetz wrote:
>>>>>>>>>>
>>>>>>>>>>> 	--- a/mm/page_alloc.c
>>>>>>>>>>> 	+++ b/mm/page_alloc.c
>>>>>>>>>>> 	@@ -1651,8 +1651,13 @@ static bool prep_move_freepages_block(struct zone *zone, struct page *page,
>>>>>>>>>>>    		end = pageblock_end_pfn(pfn) - 1;
>>>>>>>>>>>
>>>>>>>>>>>    		/* Do not cross zone boundaries */
>>>>>>>>>>> 	+#if 0
>>>>>>>>>>>    		if (!zone_spans_pfn(zone, start))
>>>>>>>>>>> 			start = zone->zone_start_pfn;
>>>>>>>>>>> 	+#else
>>>>>>>>>>> 	+	if (!zone_spans_pfn(zone, start))
>>>>>>>>>>> 	+		start = pfn;
>>>>>>>>>>> 	+#endif
>>>>>>>>>>> 	 	if (!zone_spans_pfn(zone, end))
>>>>>>>>>>> 	 		return false;
>>>>>>>>>>> 	I can still trigger warnings.
>>>>>>>>>>
>>>>>>>>>> OK. One thing to note is that the page type in the warning changed from
>>>>>>>>>> 5 (MIGRATE_ISOLATE) to 0 (MIGRATE_UNMOVABLE) with my suggested change.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Just to be really clear,
>>>>>>>>> - the 5 (MIGRATE_ISOLATE) warning was from the __alloc_pages call path.
>>>>>>>>> - the 0 (MIGRATE_UNMOVABLE) as above was from the alloc_contig_range call
>>>>>>>>>     path WITHOUT your change.
>>>>>>>>>
>>>>>>>>> I am guessing the difference here has more to do with the allocation path?
>>>>>>>>>
>>>>>>>>> I went back and reran focusing on the specific migrate type.
>>>>>>>>> Without your patch, and coming from the alloc_contig_range call path,
>>>>>>>>> I got two warnings of 'page type is 0, passed migratetype is 1' as above.
>>>>>>>>> With your patch I got one 'page type is 0, passed migratetype is 1'
>>>>>>>>> warning and one 'page type is 1, passed migratetype is 0' warning.
>>>>>>>>>
>>>>>>>>> I could be wrong, but I do not think your patch changes things.
>>>>>>>>
>>>>>>>> Got it. Thanks for the clarification.
>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> One idea about recreating the issue is that it may have to do with size
>>>>>>>>>>> of my VM (16G) and the requested allocation sizes 4G.  However, I tried
>>>>>>>>>>> to really stress the allocations by increasing the number of hugetlb
>>>>>>>>>>> pages requested and that did not help.  I also noticed that I only seem
>>>>>>>>>>> to get two warnings and then they stop, even if I continue to run the
>>>>>>>>>>> script.
>>>>>>>>>>>
>>>>>>>>>>> Zi asked about my config, so it is attached.
>>>>>>>>>>
>>>>>>>>>> With your config, I still have no luck reproducing the issue. I will keep
>>>>>>>>>> trying. Thanks.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Perhaps try running both scripts in parallel?
>>>>>>>>
>>>>>>>> Yes. It seems to do the trick.
>>>>>>>>
>>>>>>>>> Adjust the number of hugetlb pages allocated to equal 25% of memory?
>>>>>>>>
>>>>>>>> I am able to reproduce it with the script below:
>>>>>>>>
>>>>>>>> while true; do
>>>>>>>>    echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages&
>>>>>>>>    echo 2048 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages&
>>>>>>>>    wait
>>>>>>>>    echo 0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
>>>>>>>>    echo 0 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
>>>>>>>> done
>>>>>>>>
>>>>>>>> I will look into the issue.
>>>>>>
>>>>>> Nice!
>>>>>>
>>>>>> I managed to reproduce it ONCE, triggering it not even a second after
>>>>>> starting the script. But I can't seem to do it twice, even after
>>>>>> several reboots and letting it run for minutes.
>>>>>
>>>>> I managed to reproduce it reliably by cutting the nr_hugepages
>>>>> parameters respectively in half.
>>>>>
>>>>> The one that triggers for me is always MIGRATE_ISOLATE. With some
>>>>> printk-tracing, the scenario seems to be this:
>>>>>
>>>>> #0                                                   #1
>>>>> start_isolate_page_range()
>>>>>     isolate_single_pageblock()
>>>>>       set_migratetype_isolate(tail)
>>>>>         lock zone->lock
>>>>>         move_freepages_block(tail) // nop
>>>>>         set_pageblock_migratetype(tail)
>>>>>         unlock zone->lock
>>>>>                                                        del_page_from_freelist(head)
>>>>>                                                        expand(head, head_mt)
>>>>>                                                          WARN(head_mt != tail_mt)
>>>>>       start_pfn = ALIGN_DOWN(MAX_ORDER_NR_PAGES)
>>>>>       for (pfn = start_pfn, pfn < end_pfn)
>>>>>         if (PageBuddy())
>>>>>           split_free_page(head)
>>>>>
>>>>> IOW, we update a pageblock that isn't MAX_ORDER aligned, then drop the
>>>>> lock. The move_freepages_block() does nothing because the PageBuddy()
>>>>> is set on the pageblock to the left. Once we drop the lock, the buddy
>>>>> gets allocated and the expand() puts things on the wrong list. The
>>>>> splitting code that handles MAX_ORDER blocks runs *after* the tail
>>>>> type is set and the lock has been dropped, so it's too late.
>>>>
>>>> Yes, this is the issue I can confirm as well. But it is intentional to enable
>>>> allocating a contiguous range at pageblock granularity instead of MAX_ORDER
>>>> granularity. With your changes below, it no longer works, because if there
>>>> is an unmovable page in
>>>> [ALIGN_DOWN(start_pfn, MAX_ORDER_NR_PAGES), pageblock_start_pfn(start_pfn)),
>>>> the allocation fails but it would succeed in current implementation.
>>>>
>>>> I think a proper fix would be to make move_freepages_block() split the
>>>> MAX_ORDER page and put the split pages in the right migratetype free lists.
>>>>
>>>> I am working on that.
>>>
>>> After spending half a day on this, I think it is much harder than I thought
>>> to get alloc_contig_range() working with the freelist migratetype hygiene
>>> patchset. Because alloc_contig_range() relies on racy migratetype changes:
>>>
>>> 1. pageblocks in the range are first marked as MIGRATE_ISOLATE to prevent
>>> another parallel isolation, but they are not moved to the MIGRATE_ISOLATE
>>> free list yet.
>>>
>>> 2. later in the process, isolate_freepages_range() is used to actually grab
>>> the free pages.
>>>
>>> 3. there was no problem when alloc_contig_range() works on MAX_ORDER aligned
>>> ranges, since MIGRATE_ISOLATE cannot be set in the middle of free pages or
>>> in-use pages. But it is not the case when alloc_contig_range() work on
>>> pageblock aligned ranges. Now during isolation phase, free or in-use pages
>>> will need to be split to get their subpages into the right free lists.
>>>
>>> 4. the hardest case is when a in-use page sits across two pageblocks, currently,
>>> the code just isolate one pageblock, migrate the page, and let split_free_page()
>>> to correct the free list later. But to strictly enforce freelist migratetype
>>> hygiene, extra work is needed at free page path to split the free page into
>>> the right freelists.
>>>
>>> I need more time to think about how to get alloc_contig_range() properly.
>>> Help is needed for the bullet point 4.
>>
>>
>> I once raised that we should maybe try making MIGRATE_ISOLATE a flag that preserves the original migratetype. Not sure if that would help here in any way.
> 
> I have that in my backlog since you asked and have been delaying it. ;) Hopefully

It's complicated and I wish I would have had more time to review it
back then ... or now to clean it up later.

Unfortunately, nobody else did have the time to review it back then ... maybe we can
do better next time. David doesn't scale.

Doing page migration from inside start_isolate_page_range()->isolate_single_pageblock()
really is sub-optimal (and mostly code duplication from alloc_contig_range).

> I can do it after I fix this. That change might or might not help only if we make
> some redesign on how migratetype is managed. If MIGRATE_ISOLATE does not
> overwrite existing migratetype, the code might not need to split a page and move
> it to MIGRATE_ISOLATE freelist?

Did someone test how memory offlining plays along with that? (I can try myself
within the next 1-2 weeks)

There [mm/memory_hotplug.c:offline_pages] we always cover full MAX_ORDER ranges,
though.

ret = start_isolate_page_range(start_pfn, end_pfn,
			       MIGRATE_MOVABLE,
			       MEMORY_OFFLINE | REPORT_FAILURE,
			       GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL);

> 
> The fundamental issue in alloc_contig_range() is that to work at
> pageblock level, a page (>pageblock_order) can have one part is isolated and
> the rest is a different migratetype. {add_to,move_to,del_page_from}_free_list()
> now checks first pageblock migratetype, so such a page needs to be removed
> from its free_list, set MIGRATE_ISOLATE on one of the pageblock, split, and
> finally put back to multiple free lists. This needs to be done at isolation stage
> before free pages are removed from their free lists (the stage after isolation).

One idea was to always isolate larger chunks, and handle movability checks/split/etc
at a later stage. Once isolation would be decoupled from the actual/original migratetype,
the could have been easier to handle (especially some corner cases I had in mind back then).

> If MIGRATE_ISOLATE is a separate flag and we are OK with leaving isolated pages
> in their original migratetype and check migratetype before allocating a page,
> that might help. But that might add extra work (e.g., splitting a partially
> isolated free page before allocation) in the really hot code path, which is not
> desirable.

With MIGRATE_ISOLATE being a separate flag, one idea was to have not a single
separate isolate list, but one per "proper migratetype". But again, just some random
thoughts I had back then, I never had sufficient time to think it all through.

-- 
Cheers,

David / dhildenb

