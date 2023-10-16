Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D637CA1C1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjJPIhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjJPIhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:37:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D8BA1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 01:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697445378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9HMKK4q71/SJmVH5IV1VPg5kXvk5AIz/kddYNCFXCGg=;
        b=ZC9errd7TRH5bLRGzio934SxfHEbypOQbm4CFmAqdhEW9z/pfM4WuceOHlRsAihrgMaa49
        jC/69OhDY7OHE5ojhPBWQReuKgIbI5P27dJnmeOrxHMOiflkHcCq5XfzNekYI3GthvBkc1
        YrU4Lq/aoCyzPTCXUCh19y/Mr95Wspo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-DsCCAMSCOqKy7eYw_k0DMw-1; Mon, 16 Oct 2023 04:36:17 -0400
X-MC-Unique: DsCCAMSCOqKy7eYw_k0DMw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4067f186039so30965705e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 01:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697445376; x=1698050176;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9HMKK4q71/SJmVH5IV1VPg5kXvk5AIz/kddYNCFXCGg=;
        b=IpSF5arx8g6M66xL/yg3Y3/4b1wj/1ReaEOfYZaEXVAmpHmblRz+0Nq350BTF2QQx7
         He/IXNMezaJi5GJHLbWLIrDFq/sP97rD2ovhV/e0sKRcn4ZdsdgUxJDGlv+fZm8XXe3t
         nXXh6tbOYvO3ybgSALrOOSNO9+kNaYIvjQxw6DifxhjvrL37Yr5Q8KW4JP432lEKJWZA
         r/MMTwi2oCiysKC3Vbo4FA4wvP7kKKFghw/YY0Mjfo5IfvBqeFo7bQ8Bu9uPYuEZ8Dti
         8QQWZ8MODCT0zhYB7VrVPec7atCQd/rlgwAI052RXnxFIX13yHEFmfByJOahUij55agV
         VPMw==
X-Gm-Message-State: AOJu0YwPoNhOkwuedPmlaA9FzBA7CFvFQuwfxbR94gMTAnPxL3fPTVdR
        C3nDxp7kLQGcTZ4ggx7JCnM/mHmkBOCROkU+3J4Cer2CWwcdVxHGMYjehc7jTSQs+AuPw8ICgAD
        bJpKbNkcR53r0aU0gy1S1xS7G
X-Received: by 2002:a05:600c:b41:b0:3f7:f2d0:b904 with SMTP id k1-20020a05600c0b4100b003f7f2d0b904mr29503295wmr.8.1697445376129;
        Mon, 16 Oct 2023 01:36:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCGcKG9jXgoUykxPTMVFoUwQQAXnZvcaaJ86QHHLdSZ62SKMRNNP5iqqvRkjUHpPXxFMrETA==
X-Received: by 2002:a05:600c:b41:b0:3f7:f2d0:b904 with SMTP id k1-20020a05600c0b4100b003f7f2d0b904mr29503274wmr.8.1697445375714;
        Mon, 16 Oct 2023 01:36:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73c:9300:8903:bf2e:db72:6527? (p200300cbc73c93008903bf2edb726527.dip0.t-ipconnect.de. [2003:cb:c73c:9300:8903:bf2e:db72:6527])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c198f00b004077227bcdesm6564802wmq.26.2023.10.16.01.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 01:36:15 -0700 (PDT)
Message-ID: <23302f67-eb69-265a-ab2d-9c55715e2843@redhat.com>
Date:   Mon, 16 Oct 2023 10:36:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 2/2] mm: Init page count in reserve_bootmem_region when
 MEMINIT_EARLY
Content-Language: en-US
To:     Yajun Deng <yajun.deng@linux.dev>, Mike Rapoport <rppt@kernel.org>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230928083302.386202-1-yajun.deng@linux.dev>
 <20230928083302.386202-3-yajun.deng@linux.dev>
 <20230929083018.GU3303@kernel.org>
 <f144b910-cd9f-a571-ce9b-a0a8b509c28a@redhat.com>
 <2f8c4741-5c7f-272d-9cef-9fda9fbc7ca6@linux.dev>
 <5382bf2d-5aa0-1498-8169-3248be4b5af3@linux.dev>
 <bf7143f4-9d50-cfc4-0ef6-d312a2cc896b@redhat.com>
 <38cd0cb9-efe9-b98a-2768-ccb48da8b812@linux.dev>
 <20231013084827.GT3303@kernel.org>
 <1c91dd62-886d-bb05-8aee-22191a8a2d8e@linux.dev>
 <20231016063357.GU3303@kernel.org>
 <a67fc1bf-64e8-ce6c-f68a-52fe8b942860@linux.dev>
 <abace691-e11f-ec08-a725-9e3b17935d8c@redhat.com>
 <0d890048-be58-5050-02fa-21768059aa0d@linux.dev>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <0d890048-be58-5050-02fa-21768059aa0d@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.10.23 10:32, Yajun Deng wrote:
> 
> On 2023/10/16 16:16, David Hildenbrand wrote:
>> On 16.10.23 10:10, Yajun Deng wrote:
>>>
>>> On 2023/10/16 14:33, Mike Rapoport wrote:
>>>> On Fri, Oct 13, 2023 at 05:29:19PM +0800, Yajun Deng wrote:
>>>>> On 2023/10/13 16:48, Mike Rapoport wrote:
>>>>>> On Thu, Oct 12, 2023 at 05:53:22PM +0800, Yajun Deng wrote:
>>>>>>> On 2023/10/12 17:23, David Hildenbrand wrote:
>>>>>>>> On 10.10.23 04:31, Yajun Deng wrote:
>>>>>>>>> On 2023/10/8 16:57, Yajun Deng wrote:
>>>>>>>>>>> That looks wrong. if the page count would by pure luck be 0
>>>>>>>>>>> already for hotplugged memory, you wouldn't clear the reserved
>>>>>>>>>>> flag.
>>>>>>>>>>>
>>>>>>>>>>> These changes make me a bit nervous.
>>>>>>>>>> Is 'if (page_count(page) || PageReserved(page))' be safer? Or
>>>>>>>>>> do I
>>>>>>>>>> need to do something else?
>>>>>>>>>>
>>>>>>>>> How about the following if statement? But it needs to add more
>>>>>>>>> patch
>>>>>>>>> like v1 ([PATCH 2/4] mm: Introduce MEMINIT_LATE context).
>>>>>>>>>
>>>>>>>>> It'll be safer, but more complex. Please comment...
>>>>>>>>>
>>>>>>>>>         if (context != MEMINIT_EARLY || (page_count(page) ||
>>>>>>>>> PageReserved(page)) {
>>>>>>>>>
>>>>>>>> Ideally we could make initialization only depend on the context,
>>>>>>>> and not
>>>>>>>> check for count or the reserved flag.
>>>>>>>>
>>>>>>> This link is v1,
>>>>>>> https://lore.kernel.org/all/20230922070923.355656-1-yajun.deng@linux.dev/
>>>>>>>
>>>>>>>
>>>>>>> If we could make initialization only depend on the context, I'll
>>>>>>> modify it
>>>>>>> based on v1.
>>>>>> Although ~20% improvement looks impressive, this is only
>>>>>> optimization of a
>>>>>> fraction of the boot time, and realistically, how much 56 msec
>>>>>> saves from
>>>>>> the total boot time when you boot a machine with 190G of RAM?
>>>>> There are a lot of factors that can affect the total boot time. 56
>>>>> msec
>>>>> saves may be insignificant.
>>>>>
>>>>> But if we look at the boot log, we'll see there's a significant
>>>>> time jump.
>>>>>
>>>>> before:
>>>>>
>>>>> [    0.250334] ACPI: PM-Timer IO Port: 0x508
>>>>> [    0.618994] Memory: 173413056K/199884452K available (18440K
>>>>> kernel code,
>>>>>
>>>>> after:
>>>>>
>>>>> [    0.260229] software IO TLB: area num 32.
>>>>> [    0.563497] Memory: 173413056K/199884452K available (18440K
>>>>> kernel code,
>>>>> Memory:
>>>>> Memory initialization is time consuming in the boot log.
>>>> You just confirmed that 56 msec is insignificant and then you send
>>>> again
>>>> the improvement of ~60 msec in memory initialization.
>>>>
>>>> What does this improvement gain in percentage of total boot time?
>>>
>>>
>>> before:
>>>
>>> [   10.692708] Run /init as init process
>>>
>>>
>>> after:
>>>
>>> [   10.666290] Run /init as init process
>>>
>>>
>>> About 0.25%. The total boot time is variable, depending on how many
>>> drivers need to be initialized.
>>>
>>>
>>>>>> I still think the improvement does not justify the churn, added
>>>>>> complexity
>>>>>> and special casing of different code paths of initialization of
>>>>>> struct pages.
>>>>>
>>>>> Because there is a loop, if the order is MAX_ORDER, the loop will
>>>>> run 1024
>>>>> times. The following 'if' would be safer:
>>>>>
>>>>> 'if (context != MEMINIT_EARLY || (page_count(page) || >>
>>>>> PageReserved(page))
>>>>> {'
>>>> No, it will not.
>>>>
>>>> As the matter of fact any condition here won't be 'safer' because it
>>>> makes
>>>> the code more complex and less maintainable.
>>>> Any future change in __free_pages_core() or one of it's callers will
>>>> have
>>>> to reason what will happen with that condition after the change.
>>>
>>>
>>> To avoid introducing MEMINIT_LATE context and make code simpler. This
>>> might be a better option.
>>>
>>> if (page_count(page) || PageReserved(page))
>>
>> I'll have to side with Mike here; this change might not be worth it.
>>
> 
> Okay, I got it. Thanks!

IMHO instead of adding more checks to that code we should try to unify 
that handling such that we can just remove it. As expressed, at least 
from the memory hotplug perspective there are still reasons why we need 
that; I can provide some guidance on how to eventually achieve that, but 
it might end up in a bit of work ...

Anyhow, thanks for bringing up that topic; it reminded me that I still 
have pending cleanups to not rely on PageReserved on the memory hotplug 
path.

-- 
Cheers,

David / dhildenb

