Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CABC7F3155
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbjKUOmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbjKUOmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:42:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E6690
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700577768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=DdxnmvZDYmQvHG+DxJ7ogeAEklZKmOfYMtYsB3kIukc=;
        b=dATabKomI6/CZ9q/jT/S1NGu/VzibRTnbOd6J7dED+nDbXL0EmBv5ho9bigVG2YMYa1mFP
        evXY5/z+sqQwRbLtCWaxX+/Z4zNRjA99hljEMD033Le0Ia/5c2QeYVpoRlw04eG5cFOVAe
        oLNwXWE2116nQBUemW0LYcjxNRTETBI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-efrRlcdVN2GzCUl1_taA9Q-1; Tue, 21 Nov 2023 09:42:46 -0500
X-MC-Unique: efrRlcdVN2GzCUl1_taA9Q-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4084d0b171eso16954245e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:42:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700577766; x=1701182566;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdxnmvZDYmQvHG+DxJ7ogeAEklZKmOfYMtYsB3kIukc=;
        b=KOiAm3J7z38QEyMKYT6/wxdnXQinxbPgTapGMPLrgyIG61g91xhye3NUEVVXYaAcFc
         4pKrdcBcoQyTOYwSrRVXNeEMZ2+M0+5h27o090UZgLTVCLjjcgBlrX+pRurSjCEBHRoR
         9jVrj+P8+o2+RPZCgMOcHtfhY+Gvem/w6rMjcCxFAtO/+Qt7zNHNbVaBdXQNkGoNzLgM
         jeEddK7DYk+tk7wtc9vF6LHzrUFOrymtVRpSXhBffdAciukDqbJ4A48PvM1H1PV/7sP8
         GY6NNTQ4PyzSJfgirIx2S6i80BGMqU81IMEquI4qNVoYf+UzbfouRHqLeikXRTZzorSJ
         LT4A==
X-Gm-Message-State: AOJu0YyHE+E/kTcYqhYGLv8l/98cNYpkqVQnmbVlw9mSvjlIrBWvaUBh
        YYPNQPMIONijfW8iwumyt49DBFoJQ8m4Txc+3fhfQ7naXBYSnqvXfq63GAxREIUEFvNcBsKfFqA
        9XUaf3mNuyk56RKGxla0QkdDE
X-Received: by 2002:a05:600c:4c22:b0:408:37aa:774a with SMTP id d34-20020a05600c4c2200b0040837aa774amr2456247wmp.17.1700577765557;
        Tue, 21 Nov 2023 06:42:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDj07/EV1JP7k2BEHgelkxQq1zqCiLxvySrjBNa5Z+tqRsanvTj3Pjn6+jhSGRsixyeP8Vjg==
X-Received: by 2002:a05:600c:4c22:b0:408:37aa:774a with SMTP id d34-20020a05600c4c2200b0040837aa774amr2456223wmp.17.1700577765135;
        Tue, 21 Nov 2023 06:42:45 -0800 (PST)
Received: from ?IPV6:2003:cb:c722:be00:f0e5:e79a:9640:afaa? (p200300cbc722be00f0e5e79a9640afaa.dip0.t-ipconnect.de. [2003:cb:c722:be00:f0e5:e79a:9640:afaa])
        by smtp.gmail.com with ESMTPSA id o7-20020a05600c510700b0040b2ae9ef5dsm1927628wms.36.2023.11.21.06.42.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 06:42:44 -0800 (PST)
Message-ID: <920bb896-ee9e-4124-a4fc-f22d1439c95b@redhat.com>
Date:   Tue, 21 Nov 2023 15:42:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] implement "memmap on memory" feature on s390
Content-Language: en-US
To:     Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20231114180238.1522782-1-sumanthk@linux.ibm.com>
 <ec3fcd7d-17a0-4901-9261-a204c2c50c52@redhat.com>
 <20231117140009.5d8a509c@thinkpad-T15>
 <ee492da8-74b4-4a97-8b24-73e07257f01d@redhat.com>
 <ZVys8HF1lgbA8u0c@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <ZVyu1gAinLEtg5RR@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZVyu1gAinLEtg5RR@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.11.23 14:21, Sumanth Korikkar wrote:
> On Tue, Nov 21, 2023 at 02:13:22PM +0100, Sumanth Korikkar wrote:
>> Approach 2:
>> ===========
>> Shouldnt kasan zero shadow mapping performed first before
>> accessing/initializing memmap via page_init_poisining()?  If that is
>> true, then it is a problem for all architectures and should could be
>> fixed like:
>>
>>
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index 7a5fc89a8652..eb3975740537 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -1093,6 +1093,7 @@ int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
>>   	if (ret)
>>   		return ret;
>>
>> +	page_init_poison(pfn_to_page(pfn), sizeof(struct page) * nr_pages);
>>   	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL, MIGRATE_UNMOVABLE);
>>
>>   	for (i = 0; i < nr_pages; i++)
>> diff --git a/mm/sparse.c b/mm/sparse.c
>> index 77d91e565045..4ddf53f52075 100644
>> --- a/mm/sparse.c
>> +++ b/mm/sparse.c
>> @@ -906,8 +906,11 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>>   	/*
>>   	 * Poison uninitialized struct pages in order to catch invalid flags
>>   	 * combinations.
>> +	 * For altmap, do this later when onlining the memory, as it might
>> +	 * not be accessible at this point.
>>   	 */
>> -	page_init_poison(memmap, sizeof(struct page) * nr_pages);
>> +	if (!altmap)
>> +		page_init_poison(memmap, sizeof(struct page) * nr_pages);
>>
>>   	ms = __nr_to_section(section_nr);
>>   	set_section_nid(section_nr, nid);
>>
>>
>>
>> Also, if this approach is taken, should page_init_poison() be performed
>> with cond_resched() as mentioned in commit d33695b16a9f
>> ("mm/memory_hotplug: poison memmap in remove_pfn_range_from_zone()") ?
> 
> Sorry, wrong commit id.
> 
> should page_init_poison() be performed with cond_resched() as mentioned in
> Commit b7e3debdd040 ("mm/memory_hotplug.c: fix false softlockup
> during pfn range removal") ?

I think people are currently looking into removing all that cond_resched():

https://lore.kernel.org/all/20231107230822.371443-29-ankur.a.arora@oracle.com/T/#mda52da685a142bec9607625386b0b660e5470abe
-- 
Cheers,

David / dhildenb

