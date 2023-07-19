Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006B9758FF1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjGSIPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjGSIPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:15:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A705A1B9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 01:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689754503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7pDcFJVSgqhv/09OCSqGt7hoNQfzPpxkLUiFvrb0AWY=;
        b=JslZVo5r3Idz6hu5Xf/vrwtuGFEHxbqw9bOyI0jSa8QnH6jhj/Pnrqctu9FrC1VASB+Kpd
        hJsY60nXk3sx13T8JwowAnUxpKR5tnI1LTU78hPq5emH/OpINqcMGWh6WxIfVRRxBEynF6
        sSj3ItzCzgOiEmzPaKJHOUHXqcuSv94=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-UmIgP508MqSablAV_Yf-0w-1; Wed, 19 Jul 2023 04:15:02 -0400
X-MC-Unique: UmIgP508MqSablAV_Yf-0w-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4f84a8b00e3so6032663e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 01:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689754501; x=1692346501;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pDcFJVSgqhv/09OCSqGt7hoNQfzPpxkLUiFvrb0AWY=;
        b=dbpGCrVZWCyAYpM4m17MxcceUpiuEqYpScNfgoo3RVBUvKDYf898qcKCScj+D5z2tA
         ckBNfutQ2kjosrGgh45/0r4CJJOd3TYOzp0b28lFLBo7cAMsJYFHUN8WlARGhvE02BHb
         +jAkm9YWd3CHKs/7O/oPGp61C+boumseiP564VZ9+JApAa7bwaWXTF7B46dCE+mBw8Mh
         DrsrVw9uh9rlX9xhg86AmDuCBjXXsxtnBIBj5DeeIq+He9Wj85oWRT7YG/IGn4IRZesb
         VBno3lqZkE80YW3l4XRa18+HHI23X3bNXQc7MIt/qJra8P518lanb8jQpqwK2MK3YPEo
         rG1Q==
X-Gm-Message-State: ABy/qLZmlmL3fGuXOIUORSMriGceFyegfbsGGf2Irjojm/m7CkVvyEEd
        oeKfteyPJgckuY3+BBOB03Goz1oyEicmsKGyoLrJhBqmk5GWYOYKHwbRLrW+le/oOcm8RZfRXmW
        j/K+rMELv6JlyAQciJkihnCQ0
X-Received: by 2002:ac2:5de2:0:b0:4fb:89f5:f6d2 with SMTP id z2-20020ac25de2000000b004fb89f5f6d2mr11273846lfq.47.1689754501088;
        Wed, 19 Jul 2023 01:15:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlETubtOclNH0gFOjqmVul9NIAAxYsyQG4mcKQRB2xmn+kaOnFCo79bAxf1jWHocdxubjWJdng==
X-Received: by 2002:ac2:5de2:0:b0:4fb:89f5:f6d2 with SMTP id z2-20020ac25de2000000b004fb89f5f6d2mr11273836lfq.47.1689754500622;
        Wed, 19 Jul 2023 01:15:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:4f00:b030:1632:49f2:63? (p200300cbc74b4f00b030163249f20063.dip0.t-ipconnect.de. [2003:cb:c74b:4f00:b030:1632:49f2:63])
        by smtp.gmail.com with ESMTPSA id k15-20020a056000004f00b003143ba62cf4sm4554352wrx.86.2023.07.19.01.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 01:15:00 -0700 (PDT)
Message-ID: <9770454d-f840-c7cf-314e-ce81839393e3@redhat.com>
Date:   Wed, 19 Jul 2023 10:14:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: collision between ZONE_MOVABLE and memblock allocations
To:     Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>
Cc:     Ross Zwisler <zwisler@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>
References: <20230718220106.GA3117638@google.com>
 <ZLd/WEZTH5rlwYjP@dhcp22.suse.cz> <20230719075952.GH1901145@kernel.org>
 <ZLeZaa5LMH1c2zQ3@dhcp22.suse.cz>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZLeZaa5LMH1c2zQ3@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.07.23 10:06, Michal Hocko wrote:
> On Wed 19-07-23 10:59:52, Mike Rapoport wrote:
>> On Wed, Jul 19, 2023 at 08:14:48AM +0200, Michal Hocko wrote:
>>> On Tue 18-07-23 16:01:06, Ross Zwisler wrote:
>>> [...]
>>>> I do think that we need to fix this collision between ZONE_MOVABLE and memmap
>>>> allocations, because this issue essentially makes the movablecore= kernel
>>>> command line parameter useless in many cases, as the ZONE_MOVABLE region it
>>>> creates will often actually be unmovable.
>>>
>>> movablecore is kinda hack and I would be more inclined to get rid of it
>>> rather than build more into it. Could you be more specific about your
>>> use case?
>>>
>>>> Here are the options I currently see for resolution:
>>>>
>>>> 1. Change the way ZONE_MOVABLE memory is allocated so that it is allocated from
>>>> the beginning of the NUMA node instead of the end. This should fix my use case,
>>>> but again is prone to breakage in other configurations (# of NUMA nodes, other
>>>> architectures) where ZONE_MOVABLE and memblock allocations might overlap.  I
>>>> think that this should be relatively straightforward and low risk, though.
>>>>
>>>> 2. Make the code which processes the movablecore= command line option aware of
>>>> the memblock allocations, and have it choose a region for ZONE_MOVABLE which
>>>> does not have these allocations. This might be done by checking for
>>>> PageReserved() as we do with offlining memory, though that will take some boot
>>>> time reordering, or we'll have to figure out the overlap in another way. This
>>>> may also result in us having two ZONE_NORMAL zones for a given NUMA node, with
>>>> a ZONE_MOVABLE section in between them.  I'm not sure if this is allowed?
>>>
>>> Yes, this is no problem. Zones are allowed to be sparse.
>>
>> The current initialization order is roughly
>>
>> * very early initialization with some memblock allocations
>> * determine zone locations and sizes
>> * initialize memory map	
>>    - memblock_alloc(lots of memory)
>> * lots of unrelated initializations that may allocate memory
>> * release free pages from memblock to the buddy allocator
>>
>> With 2) we can make sure the memory map and early allocations won't be in
>> the ZONE_MOVABLE, but we'll still may have reserved pages there.
> 
> Yes this will always be fragile. If the spefic placement of the movable
> memory is not important and the only thing that matters is the size and
> numa locality then an easier to maintain solution would be to simply
> offline enough memory blocks very early in the userspace bring up and
> online it back as movable. If offlining fails just try another
> memblock. This doesn't require any kernel code change.

As an alternative, we might use the "memmap=nn[KMG]!ss[KMG]" [1] 
parameter to mark some memory as protected.

That memory can then be configured as devdax device and online to 
ZONE_MOVABLE (dev/dax).

[1] 
https://docs.pmem.io/persistent-memory/getting-started-guide/creating-development-environments/linux-environments/linux-memmap

-- 
Cheers,

David / dhildenb

