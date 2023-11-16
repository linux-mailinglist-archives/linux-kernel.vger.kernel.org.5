Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94C17EE746
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 20:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345495AbjKPTQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 14:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjKPTQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 14:16:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC488B8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 11:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700162167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=3XbgOo5Tg9Qr2gJXryHG6em+2+fgKmTx7tbF1d+WlDc=;
        b=XZ26CMl+KZ7EHJgRGAVDcFjf4wzUTTt6MN8NE12+l8HqtDvlPAr/afvbhPkFyfNcQz8aww
        Jwsmonwq6Tx9AdWiiZF0KMe6qJFpNfcqBYC/zWz0MQxoqwZVA3GmFRumHjuY/Z+58qTe/M
        nJwdGKiy7pppXoFFzY5N4FNVnxDhhJU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-UIRYL5bTPSGoez-pb0rB_Q-1; Thu, 16 Nov 2023 14:16:05 -0500
X-MC-Unique: UIRYL5bTPSGoez-pb0rB_Q-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40a48806258so6943955e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 11:16:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700162164; x=1700766964;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XbgOo5Tg9Qr2gJXryHG6em+2+fgKmTx7tbF1d+WlDc=;
        b=Xy+ELP1e6t82pDYG7dgMD1MY5mxK3g3JTaqZ/P4j5FY4bEyOl2Dtf6LLNXfU1IvN/E
         HXAXbzlrVGJOVwbbPs74x3U3RSFF10kuUoaayuAxK4H4Q0zE2MH+XgsnpQlf6C4dw0G6
         ppVAN+FMLN7a/rZ7V/0oos8uWGhJfcAZIR3+qN1fDzLrINeKhI5yZvdpgltDrgLoMMjJ
         rd/RQp1+6ZRGUgFIr4ZEyLh/xptkLyP3Sa2OxPBC4XlyxZD/MjjhGMworu71fXgf8NMF
         Ptq14uw+xOBtzypFNrkutMJoL0j0tWQNVjlvqEGV7Yxx7a+1zry3ahQ9ShXrCmnSPhwx
         EZ5A==
X-Gm-Message-State: AOJu0YzqijgI+8HglPEhamxODgnLQebBbKv74MVbEaEPc2FQxb9VLwr3
        7jY8xI0YvwNnjy0dNiM2tRhexwlm8ZbZYl6ABw6hblrKHZXTcq5MFLCOzUTVmDxalQYbzyl1pPw
        PLyqs96UeeQAm+JQaxY4qd/HH
X-Received: by 2002:a05:600c:4f4e:b0:405:36d7:4579 with SMTP id m14-20020a05600c4f4e00b0040536d74579mr12604453wmq.28.1700162164267;
        Thu, 16 Nov 2023 11:16:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVw1SDn+TIj7ALUo4c1g991K4Ptho+xz8USNdYBttvqzdybajenErMvwu3K+NlDWkDybjpDw==
X-Received: by 2002:a05:600c:4f4e:b0:405:36d7:4579 with SMTP id m14-20020a05600c4f4e00b0040536d74579mr12604436wmq.28.1700162163869;
        Thu, 16 Nov 2023 11:16:03 -0800 (PST)
Received: from ?IPV6:2003:cb:c714:e000:d929:2324:97c7:112c? (p200300cbc714e000d929232497c7112c.dip0.t-ipconnect.de. [2003:cb:c714:e000:d929:2324:97c7:112c])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c450e00b003fee567235bsm4742099wmo.1.2023.11.16.11.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 11:16:03 -0800 (PST)
Message-ID: <dfa5eb84-270e-4c6b-b9a1-3bb66beed6a4@redhat.com>
Date:   Thu, 16 Nov 2023 20:16:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] s390/mm: implement MEM_PHYS_ONLINE MEM_PHYS_OFFLINE
 memory notifiers
Content-Language: en-US
To:     Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20231114180238.1522782-1-sumanthk@linux.ibm.com>
 <20231114180238.1522782-7-sumanthk@linux.ibm.com>
 <458da84d-3838-4c5d-abda-1aebba676186@redhat.com>
 <ZVTTs2H6DgNGFPkF@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZVTTs2H6DgNGFPkF@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.11.23 15:20, Sumanth Korikkar wrote:
> On Tue, Nov 14, 2023 at 07:39:40PM +0100, David Hildenbrand wrote:
>> On 14.11.23 19:02, Sumanth Korikkar wrote:
>>> Implement MEM_PHYS_ONLINE and MEM_PHYS_OFFLINE memory notifiers on s390
>>>
> ...
>>>    arch/s390/mm/init.c          | 16 +++++++++++++++-
>>>    drivers/s390/char/sclp_cmd.c | 33 ++++++++++++++++++++++++++++++---
>>>    2 files changed, 45 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
>>> index 8d9a60ccb777..db505ed590b2 100644
>>> --- a/arch/s390/mm/init.c
>>> +++ b/arch/s390/mm/init.c
>>> @@ -288,6 +288,12 @@ int arch_add_memory(int nid, u64 start, u64 size,
>>>    	rc = vmem_add_mapping(start, size);
>>>    	if (rc)
>>>    		return rc;
>>> +	/*
>>> +	 * If MHP_MEMMAP_ON_MEMORY is enabled, perform __add_pages() during memory
>>> +	 * onlining phase
>>> +	 */
>>> +	if (params->altmap)
>>> +		return 0;
>>
>>
>> So we'd have added memory blocks without a memmap? Sorry, but this seems to
>> further hack into the s390x direction.
> 
> This new approach has the advantage that we do not need to allocate any
> additional memory during online phase, neither for direct mapping page
> tables nor struct pages, so that memory hotplug can never fail.

Right, just like any other architecture that (triggered by whatever 
mechanism) ends up calling add_memory() and friends.

> 
> The old approach (without altmap) is already a hack, because we add
> the memmap / struct pages, but for memory that is not really accessible.

Yes, it's disgusting. And you still allocate other things like memory 
block devices or the identify map.

> And with all the disadvantage of pre-allocating struct pages from system
> memory.

Jep. It never should have been done like that.

> 
> The new approach allows to better integrate s390 to the existing
> interface, and also make use of altmap support, which would eliminate
> the major disadvantage of the old behaviour. So from s390 perspective,
> this new mechanism would be preferred, provided that there is no
> functional issue with the "added memory blocks without a memmap"
> approach.

It achieves that by s390x specific hacks in common code :) Instead of 
everybody else that simply uses add_memory() and friends.

> 
> Do you see any functional issues, e.g. conflict with common
> code?

I don't see functional issues right now, just the way it is done to 
implement support for a new feature is a hack IMHO. Replacing hack #1 by 
hack #2 is not really something reasonable. Let's try to remove hacks.

>>
>> Maybe s390x should just provide a dedicate interface to add these memory
>> blocks instead of adding them during boot and then relying on the old way of
>> using online/offline set them online/offline.
> 
> Existing behavior:
> The current 'lsmem -a' command displays both online and standby memory.
> 
> interface changes:
> If a new interface is introduced and standby memory is no longer listed,
> the following consequences might occur:
> 
> 1. Running 'lsmem -a' would only show online memory, potentially leading
>     to user complaints.

That's why the new, clean way of doing it will require a world switch. 
If the admin wants the benefits of altmap/memmap allocation, it can be 
enabled.

> 2. standby memory addition would need:
>     * echo "standby memory addr" > /sys/devices/system/memory/probe
>     As far as I understand, this interface is already deprecated.

It should actually be an s390x specific interface where people are able 
to query the standby ranges, and request to add/remove them. There, 
s390x can perform checks and setup everything accordingly before calling 
add_memory() and have the memory onlined.

We do have something comparable with the dax/kmem infrastructure: users 
configure the available memory to hotplug, and then hotplug it. Tooling 
onlines that memory automatically.

Ideally they will add ranges, not memory blocks.

> 
> 3. To remove standby memory, a new interface probe_remove is needed
>     * echo "standby memory addr" > /sys/devices/system/memory/probe_remove
> 

Similarly, an s390x specific interface that performs checks and properly 
tears everything s390x-specifc down -- for example, turning system RAM 
into standby RAM again.


> 4. Users may express a need to identify standby memory addresses,
> resulting in the creation of another interface to list these standby
> memory ranges.

Exactly. Memory that is not added to the system that does not consume 
any resources, but can be added on demand using an interface that is not 
the second stage (onlining/offlining) of memory hot(un)plug.

-- 
Cheers,

David / dhildenb

