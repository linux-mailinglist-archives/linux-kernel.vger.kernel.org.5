Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AF67C6898
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbjJLImQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 04:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235576AbjJLIlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 04:41:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339BAE4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697100055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oUu9gspJCKmtseGxPT5e7VM//lOrd9x+RY45RlgrqZo=;
        b=f87LYifP/I8G1HGoS34o1xbxH5IL+LIZ/IDI//za907i7yePj2T53OaVVJjhk3q4PtgTZr
        YJL5U6thpu0tZWX3KaogvHl6JNZd/YYYGVXYOzjd1dIC27hWFIvca4i3XB2b7fMxQaVWqD
        Iu6ibEqEtc3qH8WdhenVLDQcPiCtj44=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-EzB5mhikO7CeGZGZQEzzhw-1; Thu, 12 Oct 2023 04:40:53 -0400
X-MC-Unique: EzB5mhikO7CeGZGZQEzzhw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-317d5b38194so300280f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:40:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697100052; x=1697704852;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oUu9gspJCKmtseGxPT5e7VM//lOrd9x+RY45RlgrqZo=;
        b=HP6z69323zPfyJhiJNPQHl0DC0zj3EyarL9eHduhjW68m8ofz/sQq9Dyy0OVcqEqAQ
         0klMx7q3sMO3Z802tLaPI6/gkKyyxAp8xrQYTb0c+gdlGKgxg4FFYEm0Ve7JQtoVSMXh
         lKD160nMrW9LcHtADS8CTjubSwoYX+dLveP6OElzYLgY0Y+sWp5YiS8NckprCMwxmlXa
         qsb43Aci4+Kj46szvNSosffdltELzS35bhT9o6fdLLghOjmeNrMG2zePDch04h6vCrb1
         sY4DA/wl/yEJksaq5FVhaJ5gOatVdLaCoimhrqa46h/7ox1xWndRCgbIWyPA1hk+LBXw
         gHog==
X-Gm-Message-State: AOJu0Ywkan8fBOBP1wSRdwEbnkFa2Ydjm5C02E2w4S5fhh9TxsbD6Gix
        qqBsrazn4z8GiiNmXT1zWBpFbDtiVr4sSILJZW8+nqB2Picm2bi/C818vRXw6e9tgyhhqAAe9Ar
        MPp6VxVl5Bptnz6dgbCIDfBky4i7oKOiH
X-Received: by 2002:adf:fd0d:0:b0:32d:92fc:a625 with SMTP id e13-20020adffd0d000000b0032d92fca625mr724709wrr.24.1697100052409;
        Thu, 12 Oct 2023 01:40:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnsVLUc9SJqZHyOsUziQY+Ca/ePvrWEabXeptfmw7K7cVLyJaUKLY9iF+clfj3wVEPiBqd5w==
X-Received: by 2002:adf:fd0d:0:b0:32d:92fc:a625 with SMTP id e13-20020adffd0d000000b0032d92fca625mr724682wrr.24.1697100051973;
        Thu, 12 Oct 2023 01:40:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:ee00:b271:fb6c:a931:4769? (p200300cbc70dee00b271fb6ca9314769.dip0.t-ipconnect.de. [2003:cb:c70d:ee00:b271:fb6c:a931:4769])
        by smtp.gmail.com with ESMTPSA id g8-20020a5d5408000000b0031c5b380291sm17680891wrv.110.2023.10.12.01.40.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 01:40:51 -0700 (PDT)
Message-ID: <748d40cb-35f4-98d6-a940-055de88bbc8b@redhat.com>
Date:   Thu, 12 Oct 2023 10:40:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>
Cc:     "Hocko, Michal" <mhocko@suse.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "jmoyer@redhat.com" <jmoyer@redhat.com>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>
References: <20231005-vv-kmem_memmap-v5-0-a54d1981f0a3@intel.com>
 <20231005-vv-kmem_memmap-v5-1-a54d1981f0a3@intel.com>
 <87jzrylslk.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <831b9b12-08fe-f5dc-f21d-83284b0aee8a@redhat.com>
 <f0d385f1c1961a17499e5acccf3ae7cdadb942cb.camel@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v5 1/2] mm/memory_hotplug: split memmap_on_memory requests
 across memblocks
In-Reply-To: <f0d385f1c1961a17499e5acccf3ae7cdadb942cb.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.10.23 07:53, Verma, Vishal L wrote:
> On Mon, 2023-10-09 at 17:04 +0200, David Hildenbrand wrote:
>> On 07.10.23 10:55, Huang, Ying wrote:
>>> Vishal Verma <vishal.l.verma@intel.com> writes:
>>>
>>>> @@ -2167,47 +2221,28 @@ static int __ref try_remove_memory(u64 start, u64 size)
>>>>          if (rc)
>>>>                  return rc;
>>>>    
>>>> +       mem_hotplug_begin();
>>>> +
>>>>          /*
>>>> -        * We only support removing memory added with MHP_MEMMAP_ON_MEMORY in
>>>> -        * the same granularity it was added - a single memory block.
>>>> +        * For memmap_on_memory, the altmaps could have been added on
>>>> +        * a per-memblock basis. Loop through the entire range if so,
>>>> +        * and remove each memblock and its altmap.
>>>>           */
>>>>          if (mhp_memmap_on_memory()) {
>>>
>>> IIUC, even if mhp_memmap_on_memory() returns true, it's still possible
>>> that the memmap is put in DRAM after [2/2].  So that,
>>> arch_remove_memory() are called for each memory block unnecessarily.  Can
>>> we detect this (via altmap?) and call remove_memory_block_and_altmap()
>>> for the whole range?
>>
>> Good point. We should handle memblock-per-memblock onny if we have to
>> handle the altmap. Otherwise, just call a separate function that doesn't
>> care about -- e.g., called remove_memory_blocks_no_altmap().
>>
>> We could simply walk all memory blocks and make sure either all have an
>> altmap or none has an altmap. If there is a mix, we should bail out with
>> WARN_ON_ONCE().
>>
> Ok I think I follow - based on both of these threads, here's my
> understanding in an incremental diff from the original patches (may not
> apply directly as I've already committed changes from the other bits of
> feedback - but this should provide an idea of the direction) -
> 
> ---
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 507291e44c0b..30addcb063b4 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -2201,6 +2201,40 @@ static void __ref remove_memory_block_and_altmap(u64 start, u64 size)
>   	}
>   }
>   
> +static bool memblocks_have_altmaps(u64 start, u64 size)
> +{
> +	unsigned long memblock_size = memory_block_size_bytes();
> +	u64 num_altmaps = 0, num_no_altmaps = 0;
> +	struct memory_block *mem;
> +	u64 cur_start;
> +	int rc = 0;
> +
> +	if (!mhp_memmap_on_memory())
> +		return false;

Probably can remove that, checked by the caller. (or drop the one in the 
caller)

> +
> +	for (cur_start = start; cur_start < start + size;
> +	     cur_start += memblock_size) {
> +		if (walk_memory_blocks(cur_start, memblock_size, &mem,
> +				       test_has_altmap_cb))
> +			num_altmaps++;
> +		else
> +			num_no_altmaps++;
> +	}

You should do that without the outer loop, by doing the counting in the 
callback function instead.	

> +
> +	if (!num_altmaps && num_no_altmaps > 0)
> +		return false;
> +
> +	if (!num_no_altmaps && num_altmaps > 0)
> +		return true;
> +
> +	/*
> +	 * If there is a mix of memblocks with and without altmaps,
> +	 * something has gone very wrong. WARN and bail.
> +	 */
> +	WARN_ONCE(1, "memblocks have a mix of missing and present altmaps");

It would be better if we could even make try_remove_memory() fail in 
this case.

> +	return false;
> +}
> +
>   static int __ref try_remove_memory(u64 start, u64 size)
>   {
>   	int rc, nid = NUMA_NO_NODE;
> @@ -2230,7 +2264,7 @@ static int __ref try_remove_memory(u64 start, u64 size)
>   	 * a per-memblock basis. Loop through the entire range if so,
>   	 * and remove each memblock and its altmap.
>   	 */
> -	if (mhp_memmap_on_memory()) {
> +	if (mhp_memmap_on_memory() && memblocks_have_altmaps(start, size)) {
>   		unsigned long memblock_size = memory_block_size_bytes();
>   		u64 cur_start;
>   
> @@ -2239,7 +2273,8 @@ static int __ref try_remove_memory(u64 start, u64 size)
>   			remove_memory_block_and_altmap(cur_start,
>   						       memblock_size);

^ probably cleaner move the loop into remove_memory_block_and_altmap() 
and call it remove_memory_blocks_and_altmaps(start, size) instead.

>   	} else {
> -		remove_memory_block_and_altmap(start, size);
> +		remove_memory_block_devices(start, size);
> +		arch_remove_memory(start, size, NULL);
>   	}
>   
>   	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
> 

-- 
Cheers,

David / dhildenb

