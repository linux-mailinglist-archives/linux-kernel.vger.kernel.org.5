Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772A97569B2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjGQQ4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjGQQz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:55:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11510D1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689612912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SErOCFj4weTS4sZHmIFn/shbKetVUK2uoB7gkNus/es=;
        b=MJaPg87tP7sne1CiFA9/TlF9w4etIoOIQ6RGeHKw2Bux0zLQjh55G1Gl1HP20f90z3r4iM
        K0PkHkuuBURhCh0VcJmk7k0bf9y1+5iHdCmHfArJTuCusYMi30gLImmXXonACxiDY0SMZG
        Ye7hbcF6s4TWztwIf1LAabGKO6lVVPM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-BYEWp_JoMgmdTBB0B_OlGw-1; Mon, 17 Jul 2023 12:55:10 -0400
X-MC-Unique: BYEWp_JoMgmdTBB0B_OlGw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fa8db49267so24915715e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689612909; x=1692204909;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SErOCFj4weTS4sZHmIFn/shbKetVUK2uoB7gkNus/es=;
        b=ZlAuxKrD41iZjH5WIrQ8TZg3x3B+H1WsyEATof8FDr2M/e/3iDOwKHI8TuHpYOwIHy
         IXsBoK+qW0xUY9RDOIC2dkky76sQtEPB1Q6W5snBu+cFW7mGywNvzRX4e2WO4MdUXGkP
         g+RZELodC1W/FVfMgWuovlXYYGzgKBkDzLUtmIybd6mM3Xb37myPlZEHAWORQaMDf8Yx
         ITOjbT0UTkg+NydGlS2GW9GhRJ4Zd8P7K1E5EpUC2y5rFUdIgGducOP0GLauhMiVkbgB
         iW9yrMiWJIbWim4Iire5ORFotXklOy63NjXvlCS8bOqeyWO2c/WjtcpOUdvVTHbhbPnS
         rTwg==
X-Gm-Message-State: ABy/qLYAvaN49B7yvGDkCYT0uLIMCHCESR32VbZMhTFzFiX7wQsBlLEo
        HOZdcNs4f0TT1DHi3XssNdkkmzwmPYLIL26pMtJOSYrPTe1gXaKLnBmk0St7mfL6OnabsSKkNCU
        DhwEBJvqsJa7yqBD4f4J2mhHI
X-Received: by 2002:a05:600c:2041:b0:3f8:b6c:84aa with SMTP id p1-20020a05600c204100b003f80b6c84aamr9635466wmg.24.1689612909602;
        Mon, 17 Jul 2023 09:55:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEdE39kPxCYKcRdmZ/FpMQpE1xk4SUcvmrmq80wEX/xClSUfOnQK/ncVsEXvVceL/eSsATFSw==
X-Received: by 2002:a05:600c:2041:b0:3f8:b6c:84aa with SMTP id p1-20020a05600c204100b003f80b6c84aamr9635448wmg.24.1689612909153;
        Mon, 17 Jul 2023 09:55:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:400:2501:5a2e:13c6:88da? (p200300cbc735040025015a2e13c688da.dip0.t-ipconnect.de. [2003:cb:c735:400:2501:5a2e:13c6:88da])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c020900b003fbc9b9699dsm183220wmi.45.2023.07.17.09.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 09:55:08 -0700 (PDT)
Message-ID: <6d50e339-bdf9-191a-9389-ea0089fa7118@redhat.com>
Date:   Mon, 17 Jul 2023 18:55:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230717143110.260162-1-ryan.roberts@arm.com>
 <20230717143110.260162-2-ryan.roberts@arm.com>
 <ZLVeeDmPDWupYzSH@casper.infradead.org>
 <283e4122-c23f-35a1-4782-fddde32f4ad4@arm.com>
 <c10ae780-c405-b2d2-ecc0-78ef35a892f3@redhat.com>
 <ZLVkUlQXmPH1BXEx@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 1/3] mm: Allow deferred splitting of arbitrary large
 anon folios
In-Reply-To: <ZLVkUlQXmPH1BXEx@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.07.23 17:54, Matthew Wilcox wrote:
> On Mon, Jul 17, 2023 at 05:43:40PM +0200, David Hildenbrand wrote:
>> On 17.07.23 17:41, Ryan Roberts wrote:
>>> On 17/07/2023 16:30, Matthew Wilcox wrote:
>>>> On Mon, Jul 17, 2023 at 03:31:08PM +0100, Ryan Roberts wrote:
>>>>> In preparation for the introduction of large folios for anonymous
>>>>> memory, we would like to be able to split them when they have unmapped
>>>>> subpages, in order to free those unused pages under memory pressure. So
>>>>> remove the artificial requirement that the large folio needed to be at
>>>>> least PMD-sized.
>>>>>
>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>> Reviewed-by: Yu Zhao <yuzhao@google.com>
>>>>> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
>>>>
>>>> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>>>
>>> Thanks!
>>>
>>>>
>>>>>    		 */
>>>>> -		if (folio_test_pmd_mappable(folio) && folio_test_anon(folio))
>>>>> +		if (folio_test_large(folio) && folio_test_anon(folio))
>>>>>    			if (!compound || nr < nr_pmdmapped)
>>>>>    				deferred_split_folio(folio);
>>>>
>>>> I wonder if it's worth introducing a folio_test_deferred_split() (better
>>>> naming appreciated ...) to allow us to allocate order-1 folios and not
>>>> do horrible things.  Maybe it's not worth supporting order-1 folios;
>>>> we're always better off going to order-2 immediately.  Just thinking.
>>>
>>> There is more than just _deferred_list in the 3rd page; you also have _flags_2a
>>> and _head_2a. I guess you know much better than me what they store. But I'm
>>> guessing its harder than jsut not splitting an order-1 page?
> 
> Those are page->flags and page->compound_head for the third page in
> the folio.  They don't really need a name; nothing refers to them,
> but it's important that space not be reused ;-)
> 
> This is slightly different from _flags_1; we do have some flags which
> reuse the bits (they're labelled as PF_SECOND).  Right now, it's only
> PF_has_hwpoisoned, but we used to have PF_double_map.  Others may arise.
> 
>>> With the direction of large anon folios (_not_ retrying with every order down to
>>> 0), I'm not sure what the use case would be for order-1 anyway?
>>
>> Just noting that we might need some struct-page space for better
>> mapcount/shared tracking, which might get hard for order-1 pages.
> 
> My assumption had been that we'd be able to reuse the _entire_mapcount
> and _nr_pages_mapped fields and not spill into the third page, but the

We most likely have to keep _entire_mapcount to keep "PMD mapped" 
working (I don't think we can not account that, some user space relies 
on that). Reusing _nr_pages_mapped for _total_mapcount would work until 
we need more bits.

But once we want to sort out some other questions like "is this folio 
mapped shared or mapped exclusive" we might need more space.

What I am playing with right now to tackle that would most probably not 
fit in there (but I'll keep trying ;) ).

> third page is definitely available today if we want it.  I'm fine with
> disallowing order-1 anon/file folios forever.

Yes, let's first sort out the open issues before going down that path 
(might not really be worth it after all).

-- 
Cheers,

David / dhildenb

