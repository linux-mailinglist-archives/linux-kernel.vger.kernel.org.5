Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AB27A4FE0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjIRQzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjIRQzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:55:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD589B6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695056054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZjTO4gcP//nadUXVqj2GJXmrM//YlftQ98yc81HL0J0=;
        b=gDfWqxJq5T2t8nTDWEACbpFriqQOzso2z7uTv8rnnryJVTuju6YnCe0ZkqBYMr4lZ+1gr7
        DIPgEZuI22CyuPkbOYDkSsAiEEMAom3VZzsZmbsKgqcuRCvyqrITSMcUguOReIXbOt/TC0
        +BuSQFwzcroKDgjTsGJNG1RW8cyo13o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-TFCmTeYuM-ma6xUxHZ4Nfw-1; Mon, 18 Sep 2023 12:54:12 -0400
X-MC-Unique: TFCmTeYuM-ma6xUxHZ4Nfw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-31aef4011cfso3155225f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:54:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695056051; x=1695660851;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZjTO4gcP//nadUXVqj2GJXmrM//YlftQ98yc81HL0J0=;
        b=gvcOCWST0VecU+Cidld2CSjX7/kILI8Mqcy08M8grhfbxY33YaaDilTHFzrIm3oxbj
         9Ii431hdxkIcSD0DIw5mK69sjiNT8/T8/qC0Vg/5qECp41NtUE1fiG3g57UIAIStsdBp
         PYDxc3kmjfqPetwgp2ooZORtflOKhQ7vOIa7t7CGzCw+UeO9E6wgwwWPtpKPxrNzTYMg
         10JkfEGNZwOM7Ipw1szbvNZt+8LdPxa6Goe9qZ59QqBU4mDlpaDwhXL6DlupP0hmshro
         Xjx0yIv2Y8jzfW7vHTZmtnhnOZ74r/ZvSfMHAj8Z+1wlW72YW6ZnY/gMNM8s+Q14KGIV
         JqTA==
X-Gm-Message-State: AOJu0YyU5kR5HSEWf+46H/AzeNHKapAh1T2yQNsWLiIVIDii51So//tE
        38fyuITq6QjOCtI71s40aP5mLHUHKI8uHBxRrJhG865o3Kaw1KCBnSmwUtC2+5V1r+pEdPvJeW/
        C5Qr6c4Q41Ucbfe/ay4kdZWiF
X-Received: by 2002:adf:f4c4:0:b0:31a:b3aa:d19b with SMTP id h4-20020adff4c4000000b0031ab3aad19bmr7868092wrp.23.1695056051161;
        Mon, 18 Sep 2023 09:54:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSeM+WczwIA0+o+BhBMrxmfrQVLuEo097XU3cOCry/hI/9ThoSt5ebPOS9r5LJ4D6k5M7gTA==
X-Received: by 2002:adf:f4c4:0:b0:31a:b3aa:d19b with SMTP id h4-20020adff4c4000000b0031ab3aad19bmr7868075wrp.23.1695056050706;
        Mon, 18 Sep 2023 09:54:10 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:9d00:cf36:8603:a1f5:d07? (p200300cbc7029d00cf368603a1f50d07.dip0.t-ipconnect.de. [2003:cb:c702:9d00:cf36:8603:a1f5:d07])
        by smtp.gmail.com with ESMTPSA id j3-20020a056000124300b0031fb91f23e9sm13227346wrx.43.2023.09.18.09.54.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 09:54:10 -0700 (PDT)
Message-ID: <5bf3e7ad-b666-ae88-449a-074f17a9cbba@redhat.com>
Date:   Mon, 18 Sep 2023 18:54:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, akpm@linux-foundation.org, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230912175228.952039-1-shr@devkernel.io>
 <20230912175228.952039-2-shr@devkernel.io>
 <6447ab02-1a22-efe4-68c9-4f595e2499fc@redhat.com>
 <qvqwled3jvq2.fsf@devbig1114.prn1.facebook.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 1/4] mm/ksm: add "smart" page scanning mode
In-Reply-To: <qvqwled3jvq2.fsf@devbig1114.prn1.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.09.23 18:18, Stefan Roesch wrote:
> 
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 12.09.23 19:52, Stefan Roesch wrote:
>>> This change adds a "smart" page scanning mode for KSM. So far all the
>>> candidate pages are continuously scanned to find candidates for
>>> de-duplication. There are a considerably number of pages that cannot be
>>> de-duplicated. This is costly in terms of CPU. By using smart scanning
>>> considerable CPU savings can be achieved.
>>> This change takes the history of scanning pages into account and skips
>>> the page scanning of certain pages for a while if de-deduplication for
>>> this page has not been successful in the past.
>>> To do this it introduces two new fields in the ksm_rmap_item structure:
>>> age and skip_age. age, is the KSM age and skip_page is the age for how
>>> long page scanning of this page is skipped. The age field is incremented
>>> each time the page is scanned and the page cannot be de-duplicated.
>>> How often a page is skipped is dependent how often de-duplication has
>>> been tried so far and the number of skips is currently limited to 8.
>>> This value has shown to be effective with different workloads.
>>> The feature is currently disable by default and can be enabled with the
>>> new smart_scan knob.
>>> The feature has shown to be very effective: upt to 25% of the page scans
>>> can be eliminated; the pages_to_scan rate can be reduced by 40 - 50% and
>>> a similar de-duplication rate can be maintained.
>>> Signed-off-by: Stefan Roesch <shr@devkernel.io>
>>> ---
>>>    mm/ksm.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 75 insertions(+)
>>> diff --git a/mm/ksm.c b/mm/ksm.c
>>> index 981af9c72e7a..bfd5087c7d5a 100644
>>> --- a/mm/ksm.c
>>> +++ b/mm/ksm.c
>>> @@ -56,6 +56,8 @@
>>>    #define DO_NUMA(x)	do { } while (0)
>>>    #endif
>>>    +typedef u8 rmap_age_t;
>>> +
>>>    /**
>>>     * DOC: Overview
>>>     *
>>> @@ -193,6 +195,8 @@ struct ksm_stable_node {
>>>     * @node: rb node of this rmap_item in the unstable tree
>>>     * @head: pointer to stable_node heading this list in the stable tree
>>>     * @hlist: link into hlist of rmap_items hanging off that stable_node
>>> + * @age: number of scan iterations since creation
>>> + * @skip_age: skip rmap item until age reaches skip_age
>>>     */
>>>    struct ksm_rmap_item {
>>>    	struct ksm_rmap_item *rmap_list;
>>> @@ -212,6 +216,8 @@ struct ksm_rmap_item {
>>>    			struct hlist_node hlist;
>>>    		};
>>>    	};
>>> +	rmap_age_t age;
>>> +	rmap_age_t skip_age;
>>>    };
>>>      #define SEQNR_MASK	0x0ff	/* low bits of unstable tree seqnr */
>>> @@ -281,6 +287,9 @@ static unsigned int zero_checksum __read_mostly;
>>>    /* Whether to merge empty (zeroed) pages with actual zero pages */
>>>    static bool ksm_use_zero_pages __read_mostly;
>>>    +/* Skip pages that couldn't be de-duplicated previously  */
>>> +static bool ksm_smart_scan;
>>> +
>>>    /* The number of zero pages which is placed by KSM */
>>>    unsigned long ksm_zero_pages;
>>>    @@ -2305,6 +2314,45 @@ static struct ksm_rmap_item
>>> *get_next_rmap_item(struct ksm_mm_slot *mm_slot,
>>>    	return rmap_item;
>>>    }
>>>    +static unsigned int inc_skip_age(rmap_age_t age)
>>> +{
>>> +	if (age <= 3)
>>> +		return 1;
>>> +	if (age <= 5)
>>> +		return 2;
>>> +	if (age <= 8)
>>> +		return 4;
>>> +
>>> +	return 8;
>>> +}
>>> +
>>> +static bool skip_rmap_item(struct page *page, struct ksm_rmap_item *rmap_item)
>>> +{
>>> +	rmap_age_t age;
>>> +
>>> +	if (!ksm_smart_scan)
>>> +		return false;
>>> +
>>> +	if (PageKsm(page))
>>> +		return false;
>>
>>
>> I'm a bit confused about this check here. scan_get_next_rmap_item() would return
>> a PageKsm() page and call cmp_and_merge_page().
>>
>> cmp_and_merge_page() says: "first see if page can be merged into the stable
>> tree"
>>
>> ... but shouldn't a PageKsm page *already* be in the stable tree?
>>
>> Maybe that's what cmp_and_merge_page() does via:
>>
>> 	kpage = stable_tree_search(page);
>> 	if (kpage == page && rmap_item->head == stable_node) {
>> 		put_page(kpage);
>> 		return;
>> 	}
>>
>>
>> Hoping you can enlighten me :)
>>
> 
> The above description sounds correct. During each scan we go through all
> the candidate pages and this includes rmap_items that maps to KSM pages.
> The above check simply skips these pages.

Can we add a comment why we don't skip them? Like

/*
  * Never skip pages that are already KSM; pages cmp_and_merge_page()
  * will essentially ignore them, but we still have to process them
  * properly.
  */

> 
>>> +
>>> +	age = rmap_item->age++;
>>
>> Can't we overflow here? Is that desired, or would you want to stop at the
>> maximum you can store?
>>
> 
> Yes, we can overflow here and it was a deliberate choice. If we overflow
> after we tried unsuccessfully for 255 times, we re-start with shorter
> skip values, but that should be fine. In return we avoid an if statement.
> The age is defined as unsigned.

Can we make that explicit instead? Dealing with implicit overflows 
really makes the code harder to grasp.

> 
>>> +	if (age < 3)
>>> +		return false;
>>> +
>>> +	if (rmap_item->skip_age == age) {
>>> +		rmap_item->skip_age = 0;
>>> +		return false;
>>> +	}
>>> +
>>> +	if (rmap_item->skip_age == 0) {
>>> +		rmap_item->skip_age = age + inc_skip_age(age);
>>
>> Can't you overflow here as well?
>>
> 
> Yes, you can. See the above discussion. This skip_age is also an
> unsigned value.

Dito.

> 
>>> +		remove_rmap_item_from_tree(rmap_item);
>>
>>
>> Can you enlighten me why that is required?
>>
> 
> This is required for age calculation and BUG_ON check in
> remove_rmap_item_from_tree. If we don't call remove_rmap_item_from_tree,
> we will hit the BUG_ON for the skipped pages later on.

I see, thanks!


-- 
Cheers,

David / dhildenb

