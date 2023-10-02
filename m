Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20657B4E66
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 10:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbjJBI71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 04:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235961AbjJBI7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 04:59:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AE23C31
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 01:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696237015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kZolH99067fvKHUQAUHeclQlPt0YjXr+P4dEn1LOWbQ=;
        b=CXvEsq9VSlASyzVd5KOmW1Bv4g1dE+A8WMIRiyLn0evRBQ66sz71RYQ+xTBPJfsFTSatHZ
        B6RzrNx7/XxLUzP1TqU1PPSbr00aHo51DIeBg/JhHtI3Qkr7LYtXa493fEDL2fAUcJ+Alq
        +vbec04xtvHN0vFwL5vg60kLd8bu8wg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-zxibARMDMNSbqEtobKKvtg-1; Mon, 02 Oct 2023 04:56:54 -0400
X-MC-Unique: zxibARMDMNSbqEtobKKvtg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30e3ee8a42eso12027773f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 01:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696237013; x=1696841813;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZolH99067fvKHUQAUHeclQlPt0YjXr+P4dEn1LOWbQ=;
        b=Epl2AMHD825SJjjoG0o7xWjmpelrEk5DnOzn+34NxijLoxDyF3FjAPvi4jYIglR/kX
         3FHDF/F3zMyLxXKWJPYtcUWHWqDymo3MBkvDLztPbRy/96/bh5YHzLw8MroqYUQxTCWf
         eq99JIGPiQqqzqmfctetNfx46Fg77ZJ2B0U8RdhhyDnoQVsYyeLtz8lMwGedzfR11x2R
         a2jY42zhyVZ3evdI6gMhx9oi3TuXHgPnprtKaqZCZ6L7wFVdDI2hHzSWi3zO+DvvN3KR
         ziOhMp6JWBbveXBdu/iSWrHPjRpnc5KQ6GEjzd0kTpg1tSjpisQqjsRl/boeSvpZWjR5
         LVUg==
X-Gm-Message-State: AOJu0YzMqre9JMxeb9nLMtlDufpZhEq5QazuqbV+ySVUlMry0btD/IUx
        dgwbTXWF+Tcl4J493P3XG3A0O/RTmD+qBZhE8mGmaXXz1cSR61jw8S94H5wI65GcuD/969BR/+y
        a62FBsYKALh/HL0cFf4vurXPL
X-Received: by 2002:a5d:668a:0:b0:321:5969:d465 with SMTP id l10-20020a5d668a000000b003215969d465mr9091194wru.65.1696237013400;
        Mon, 02 Oct 2023 01:56:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNivYmW4PtO+ePKJDFQz9ZH3hXp+F3LiyWwZ9zsgVXl2tVW95sg/9viMCcYxcA7zlnFJjn2Q==
X-Received: by 2002:a5d:668a:0:b0:321:5969:d465 with SMTP id l10-20020a5d668a000000b003215969d465mr9091177wru.65.1696237012975;
        Mon, 02 Oct 2023 01:56:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:f200:cb49:cb8f:88fc:9446? (p200300cbc735f200cb49cb8f88fc9446.dip0.t-ipconnect.de. [2003:cb:c735:f200:cb49:cb8f:88fc:9446])
        by smtp.gmail.com with ESMTPSA id 11-20020a056000156b00b0032485046055sm9783325wrz.5.2023.10.02.01.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 01:56:52 -0700 (PDT)
Message-ID: <f7e6f67a-4cac-73bd-1d5e-5020c6c8423d@redhat.com>
Date:   Mon, 2 Oct 2023 10:56:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 2/2] mm: Init page count in reserve_bootmem_region when
 MEMINIT_EARLY
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>, Yajun Deng <yajun.deng@linux.dev>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230928083302.386202-1-yajun.deng@linux.dev>
 <20230928083302.386202-3-yajun.deng@linux.dev>
 <20230929083018.GU3303@kernel.org>
 <a6a20ff9-385c-639f-75cf-ce73a01d97cf@linux.dev>
 <20230929100252.GW3303@kernel.org>
 <15233624-f32e-172e-b2f6-7ca7bffbc96d@linux.dev>
 <20231001185934.GX3303@kernel.org>
 <90342474-432a-9fe3-2f11-915a04f0053f@linux.dev>
 <20231002084708.GZ3303@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20231002084708.GZ3303@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.10.23 10:47, Mike Rapoport wrote:
> On Mon, Oct 02, 2023 at 03:03:56PM +0800, Yajun Deng wrote:
>>
>> On 2023/10/2 02:59, Mike Rapoport wrote:
>>> On Fri, Sep 29, 2023 at 06:27:25PM +0800, Yajun Deng wrote:
>>>> On 2023/9/29 18:02, Mike Rapoport wrote:
>>>>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>>>>>> index 06be8821d833..b868caabe8dc 100644
>>>>>>>> --- a/mm/page_alloc.c
>>>>>>>> +++ b/mm/page_alloc.c
>>>>>>>> @@ -1285,18 +1285,22 @@ void __free_pages_core(struct page *page, unsigned int order)
>>>>>>>>      	unsigned int loop;
>>>>>>>>      	/*
>>>>>>>> -	 * When initializing the memmap, __init_single_page() sets the refcount
>>>>>>>> -	 * of all pages to 1 ("allocated"/"not free"). We have to set the
>>>>>>>> -	 * refcount of all involved pages to 0.
>>>>>>>> +	 * When initializing the memmap, memmap_init_range sets the refcount
>>>>>>>> +	 * of all pages to 1 ("reserved" and "free") in hotplug context. We
>>>>>>>> +	 * have to set the refcount of all involved pages to 0. Otherwise,
>>>>>>>> +	 * we don't do it, as reserve_bootmem_region only set the refcount on
>>>>>>>> +	 * reserve region ("reserved") in early context.
>>>>>>>>      	 */
>>>>>>> Again, why hotplug and early init should be different?
>>>>>> I will add a comment that describes it will save boot time.
>>>>> But why do we need initialize struct pages differently at boot time vs
>>>>> memory hotplug?
>>>>> Is there a reason memory hotplug cannot have page count set to 0 just like
>>>>> for pages reserved at boot time?
>>>> This patch just save boot time in MEMINIT_EARLY. If someone finds out that
>>>> it can save time in
>>>>
>>>> MEMINIT_HOTPLUG, I think it can be done in another patch later. I just
>>>> keeping it in the same.
>>> But it's not the same. It becomes slower after your patch and the code that
>>> frees the pages for MEMINIT_EARLY and MEMINIT_HOTPLUG becomes non-uniform
>>> for no apparent reason.
>>
>> __free_pages_core will also be called by others, such as:
>> deferred_free_range, do_collection and memblock_free_late.
>>
>> We couldn't remove  'if (page_count(page))' even if we set page count to 0
>> when MEMINIT_HOTPLUG.
> 
> That 'if' breaks the invariant that __free_pages_core is always called for
> pages with initialized page count. Adding it may lead to subtle bugs and
> random memory corruption so we don't want to add it at the first place.

As long as we have to special-case memory hotplug, we know that we are 
always coming via generic_online_page() in that case. We could either 
move some logic over there, or let __free_pages_core() know what it 
should do.

-- 
Cheers,

David / dhildenb

