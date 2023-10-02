Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553197B4D4A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 10:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbjJBIbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 04:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjJBIbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 04:31:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40294C4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 01:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696235426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BlqC/PzhLroyvC3Upif5X/Cft8kmbeniyvSBVl7WoRA=;
        b=DlejFUAJSOllqf9hlpwrKdBU5o8kLk4TpxhUgtuzFQQFK20xvtI5iFMhrpOJ0/Cw9Fac9M
        aZFsQDoir+z8IJwjH2HyyGqa0qMieCJYYcOEb/A2X/Xwxg89DS30oLCAeW7TZcr6MPLLQX
        GlnE+4l/+d8nifYCscOCmPswm6Mn6fg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-HXMHkGrvOGiYCF-WuMasLA-1; Mon, 02 Oct 2023 04:30:24 -0400
X-MC-Unique: HXMHkGrvOGiYCF-WuMasLA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-402cd372b8bso150595805e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 01:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696235424; x=1696840224;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BlqC/PzhLroyvC3Upif5X/Cft8kmbeniyvSBVl7WoRA=;
        b=LT63Yf4SjIZ5RevrisPJkNXEfd0X+lsueCG9UlIsnG6JyRFq7ODChLJ/mqLxMgKkHA
         3SJPQpP2+wS4ym0T6juKMdiQCKQYsCP8xrDMPyjms2z/vYeZrPld1pwNgL0olszUgwkr
         pNzx/SHBYYbig00+afxTa+u/+fghHs8A6JDbtO4hKoJ9oXnEFU7iXh1zd9kOm07uJC+T
         4ViCt88OmabGImgNay1Cf23Cku/g6cYTWgIVHaBwpMPNlYKdQVMR1x48p7lIO9vnrrI9
         NFdd8/pEYjiSfZxyZR9JkoHtrOIRMAKgMCmrSIrcPf6cUTX0PNNBIv1GXKkMCEo1qp9+
         bhZA==
X-Gm-Message-State: AOJu0YwJ5F/OnLmejVlyxmzhGoVnf93x/pKpKI81rDew0cIUsXS9gZug
        7m8qvxRge8H/2X9jWu13VktGk4/1E15nNIbbZjN5BQ7uPOyZ1kl9LS2IpZReYiyx+NyAK0wQgI+
        HP8XH+vWA09KS+7f90Hz07ZPN6MyglhKk
X-Received: by 2002:a1c:7211:0:b0:405:367d:4656 with SMTP id n17-20020a1c7211000000b00405367d4656mr10028282wmc.29.1696235423756;
        Mon, 02 Oct 2023 01:30:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHG1k3lnvnbpsN4w38eQDYhKPBV+ep78G6Aoul68G3nuonACby2RGLIUkvu563Aim9tyDuDCw==
X-Received: by 2002:a1c:7211:0:b0:405:367d:4656 with SMTP id n17-20020a1c7211000000b00405367d4656mr10028263wmc.29.1696235423208;
        Mon, 02 Oct 2023 01:30:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:f200:cb49:cb8f:88fc:9446? (p200300cbc735f200cb49cb8f88fc9446.dip0.t-ipconnect.de. [2003:cb:c735:f200:cb49:cb8f:88fc:9446])
        by smtp.gmail.com with ESMTPSA id s28-20020adfa29c000000b003232f167df5sm17124815wra.108.2023.10.02.01.30.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 01:30:22 -0700 (PDT)
Message-ID: <f144b910-cd9f-a571-ce9b-a0a8b509c28a@redhat.com>
Date:   Mon, 2 Oct 2023 10:30:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>, Yajun Deng <yajun.deng@linux.dev>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230928083302.386202-1-yajun.deng@linux.dev>
 <20230928083302.386202-3-yajun.deng@linux.dev>
 <20230929083018.GU3303@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4 2/2] mm: Init page count in reserve_bootmem_region when
 MEMINIT_EARLY
In-Reply-To: <20230929083018.GU3303@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.09.23 10:30, Mike Rapoport wrote:
> On Thu, Sep 28, 2023 at 04:33:02PM +0800, Yajun Deng wrote:
>> memmap_init_range() would init page count of all pages, but the free
>> pages count would be reset in __free_pages_core(). There are opposite
>> operations. It's unnecessary and time-consuming when it's MEMINIT_EARLY
>> context.
>>
>> Init page count in reserve_bootmem_region when in MEMINIT_EARLY context,
>> and check the page count before reset it.
>>
>> At the same time, the INIT_LIST_HEAD in reserve_bootmem_region isn't
>> need, as it already done in __init_single_page.
>>
>> The following data was tested on an x86 machine with 190GB of RAM.
>>
>> before:
>> free_low_memory_core_early()    341ms
>>
>> after:
>> free_low_memory_core_early()    285ms
>>
>> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
>> ---
>> v4: same with v2.
>> v3: same with v2.
>> v2: check page count instead of check context before reset it.
>> v1: https://lore.kernel.org/all/20230922070923.355656-1-yajun.deng@linux.dev/
>> ---
>>   mm/mm_init.c    | 18 +++++++++++++-----
>>   mm/page_alloc.c | 20 ++++++++++++--------
>>   2 files changed, 25 insertions(+), 13 deletions(-)
>>
>> diff --git a/mm/mm_init.c b/mm/mm_init.c
>> index 9716c8a7ade9..3ab8861e1ef3 100644
>> --- a/mm/mm_init.c
>> +++ b/mm/mm_init.c
>> @@ -718,7 +718,7 @@ static void __meminit init_reserved_page(unsigned long pfn, int nid)
>>   		if (zone_spans_pfn(zone, pfn))
>>   			break;
>>   	}
>> -	__init_single_page(pfn_to_page(pfn), pfn, zid, nid, INIT_PAGE_COUNT);
>> +	__init_single_page(pfn_to_page(pfn), pfn, zid, nid, 0);
>>   }
>>   #else
>>   static inline void pgdat_set_deferred_range(pg_data_t *pgdat) {}
>> @@ -756,8 +756,8 @@ void __meminit reserve_bootmem_region(phys_addr_t start,
>>   
>>   			init_reserved_page(start_pfn, nid);
>>   
>> -			/* Avoid false-positive PageTail() */
>> -			INIT_LIST_HEAD(&page->lru);
>> +			/* Init page count for reserved region */
> 
> Please add a comment that describes _why_ we initialize the page count here.
> 
>> +			init_page_count(page);
>>   
>>   			/*
>>   			 * no need for atomic set_bit because the struct
>> @@ -888,9 +888,17 @@ void __meminit memmap_init_range(unsigned long size, int nid, unsigned long zone
>>   		}
>>   
>>   		page = pfn_to_page(pfn);
>> -		__init_single_page(page, pfn, zone, nid, INIT_PAGE_COUNT);
>> -		if (context == MEMINIT_HOTPLUG)
>> +
>> +		/* If the context is MEMINIT_EARLY, we will init page count and
>> +		 * mark page reserved in reserve_bootmem_region, the free region
>> +		 * wouldn't have page count and we will check the pages count
>> +		 * in __free_pages_core.
>> +		 */
>> +		__init_single_page(page, pfn, zone, nid, 0);
>> +		if (context == MEMINIT_HOTPLUG) {
>> +			init_page_count(page);
>>   			__SetPageReserved(page);
> 
> Rather than calling init_page_count() and __SetPageReserved() for
> MEMINIT_HOTPLUG you can set flags to INIT_PAGE_COUNT | INIT_PAGE_RESERVED
> an call __init_single_page() after the check for MEMINIT_HOTPLUG.
> 
> But more generally, I wonder if we have to differentiate HOTPLUG here at all.
> @David, can you comment please?

There are a lot of details to that, and I'll share some I can briefly think of.

1) __SetPageReserved()

I tried removing that a while ago, but there was a blocker (IIRC something about
ZONE_DEVICE). I still have the patches at [1] and I could probably take a look
if that blocker still exists (I recall that something changed at some point, but
I never had the time to follow up).

But once we stop setting the pages reserved, we might run into issues with ...


2) init_page_count()

virtio-mem, XEN balloon and HV-balloon add memory blocks that can contain holes.
set_online_page_callback() is used to intercept memory onlining and to expose
only the pages that are not holes to the buddy: calling generic_online_page() on !hole.

Holes are PageReserved but with an initialized page count. Memory offlining will fail on
PageReserved pages -- has_unmovable_pages().


At least virtio-mem clears the PageReserved flag of holes when onlining memory,
and currently relies in the page count to be reasonable (so memory offlining can work).

static void virtio_mem_set_fake_offline(unsigned long pfn,
					unsigned long nr_pages, bool onlined)
{
	page_offline_begin();
	for (; nr_pages--; pfn++) {
		struct page *page = pfn_to_page(pfn);

		__SetPageOffline(page);
		if (!onlined) {
			SetPageDirty(page);
			/* FIXME: remove after cleanups */
			ClearPageReserved(page);
		}
	}
	page_offline_end();
}


For virtio-mem, we could initialize the page count there instead. The other PV drivers
might require a bit more thought.


[1] https://github.com/davidhildenbrand/linux/tree/online_reserved_cleanup

> 
>> +		}
>>   
>>   		/*
>>   		 * Usually, we want to mark the pageblock MIGRATE_MOVABLE,
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 06be8821d833..b868caabe8dc 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1285,18 +1285,22 @@ void __free_pages_core(struct page *page, unsigned int order)
>>   	unsigned int loop;
>>   
>>   	/*
>> -	 * When initializing the memmap, __init_single_page() sets the refcount
>> -	 * of all pages to 1 ("allocated"/"not free"). We have to set the
>> -	 * refcount of all involved pages to 0.
>> +	 * When initializing the memmap, memmap_init_range sets the refcount
>> +	 * of all pages to 1 ("reserved" and "free") in hotplug context. We
>> +	 * have to set the refcount of all involved pages to 0. Otherwise,
>> +	 * we don't do it, as reserve_bootmem_region only set the refcount on
>> +	 * reserve region ("reserved") in early context.
>>   	 */
> 
> Again, why hotplug and early init should be different?
> 
>> -	prefetchw(p);
>> -	for (loop = 0; loop < (nr_pages - 1); loop++, p++) {
>> -		prefetchw(p + 1);
>> +	if (page_count(page)) {
>> +		prefetchw(p);
>> +		for (loop = 0; loop < (nr_pages - 1); loop++, p++) {
>> +			prefetchw(p + 1);
>> +			__ClearPageReserved(p);
>> +			set_page_count(p, 0);
>> +		}
>>   		__ClearPageReserved(p);
>>   		set_page_count(p, 0);

That looks wrong. if the page count would by pure luck be 0 already for hotplugged memory,
you wouldn't clear the reserved flag.

These changes make me a bit nervous.

-- 
Cheers,

David / dhildenb

