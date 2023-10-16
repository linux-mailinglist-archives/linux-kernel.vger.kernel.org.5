Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436C87CA16A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjJPIRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJPIRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:17:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC43B4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 01:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697444216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gfj3U5z/zcLuOmFD4w+HG/2OK4y9FpD+oBquU9njyE4=;
        b=JKey2q06iyKtDwAOhm9Wvolep9l9WSP83uCxFomaYcHz3+BbkMOUY/wTsIuP5QdIO2xDMu
        UNeu8bPp1SO4/kTCGO2E7bpMWxNMVmo8ZKDmmkISvUozEj87s6loMTsslujfTkexU91Y5H
        69ePZUuwGSgvv2ZdSVL+mQsJXFofDU4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-gGNeWXfvP6OUlwurix15ag-1; Mon, 16 Oct 2023 04:16:55 -0400
X-MC-Unique: gGNeWXfvP6OUlwurix15ag-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4053a5c6a59so27797195e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 01:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697444214; x=1698049014;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gfj3U5z/zcLuOmFD4w+HG/2OK4y9FpD+oBquU9njyE4=;
        b=hdepFhegNnqw+uoMFq7NkzJ0Rob8jGzGmPBkcH54vLfD/iQG+/J8AilRj06UfNotK2
         JKSxOoI+4RtaaqNvWBMLQy+LD3/b/qYeYC1mW8Ry6cGGiR2OcESVgNo6uW1I1/0IUu7u
         uCIm504MHkySuQsmMwccAmjCSk0FOxY5tGIZr4iISwKSu9G3nx1jsETQDcrFVO06eRPL
         qXHSKHa1AZxMPZiil7ylZhqGPdW7NSusxxj9jasSTaLxWfYLWmfBsMxUMgbPqKzJxtoe
         GOCZYJWtgxA8wDZokzEKDzDwSzz8bZuEAk2LDHYP+rZCqKUvC8k9DgD6A7xxjgQdxs0Q
         sekA==
X-Gm-Message-State: AOJu0YyIZ02CMeJWf2hw7MaSqU4/vbIedm1r/i66XhMns7GH2N/9ZIhZ
        M5Nv9jmx7F0xhAmd6n8WoAh6Hd7xyPKgN3gFc5E7hPVP7F+LoIMbrmRvtDQacqZ5bTw1Lz39JIw
        iumGCQ51V4zDQJ1h5lfnUUJp6
X-Received: by 2002:a05:6000:1d84:b0:32d:8982:ff1c with SMTP id bk4-20020a0560001d8400b0032d8982ff1cmr11832996wrb.36.1697444213750;
        Mon, 16 Oct 2023 01:16:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVNqbU/b8Tdf/C/5RrQM3+RaGSFcSyaBIp9+3qGB/fSseBodgkxryiwenCG8CidEHP68lFiQ==
X-Received: by 2002:a05:6000:1d84:b0:32d:8982:ff1c with SMTP id bk4-20020a0560001d8400b0032d8982ff1cmr11832968wrb.36.1697444213332;
        Mon, 16 Oct 2023 01:16:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73c:9300:8903:bf2e:db72:6527? (p200300cbc73c93008903bf2edb726527.dip0.t-ipconnect.de. [2003:cb:c73c:9300:8903:bf2e:db72:6527])
        by smtp.gmail.com with ESMTPSA id bq1-20020a5d5a01000000b0031ad5fb5a0fsm904987wrb.58.2023.10.16.01.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 01:16:52 -0700 (PDT)
Message-ID: <abace691-e11f-ec08-a725-9e3b17935d8c@redhat.com>
Date:   Mon, 16 Oct 2023 10:16:52 +0200
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <a67fc1bf-64e8-ce6c-f68a-52fe8b942860@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.10.23 10:10, Yajun Deng wrote:
> 
> On 2023/10/16 14:33, Mike Rapoport wrote:
>> On Fri, Oct 13, 2023 at 05:29:19PM +0800, Yajun Deng wrote:
>>> On 2023/10/13 16:48, Mike Rapoport wrote:
>>>> On Thu, Oct 12, 2023 at 05:53:22PM +0800, Yajun Deng wrote:
>>>>> On 2023/10/12 17:23, David Hildenbrand wrote:
>>>>>> On 10.10.23 04:31, Yajun Deng wrote:
>>>>>>> On 2023/10/8 16:57, Yajun Deng wrote:
>>>>>>>>> That looks wrong. if the page count would by pure luck be 0
>>>>>>>>> already for hotplugged memory, you wouldn't clear the reserved
>>>>>>>>> flag.
>>>>>>>>>
>>>>>>>>> These changes make me a bit nervous.
>>>>>>>> Is 'if (page_count(page) || PageReserved(page))' be safer? Or do I
>>>>>>>> need to do something else?
>>>>>>>>
>>>>>>> How about the following if statement? But it needs to add more patch
>>>>>>> like v1 ([PATCH 2/4] mm: Introduce MEMINIT_LATE context).
>>>>>>>
>>>>>>> It'll be safer, but more complex. Please comment...
>>>>>>>
>>>>>>>        if (context != MEMINIT_EARLY || (page_count(page) ||
>>>>>>> PageReserved(page)) {
>>>>>>>
>>>>>> Ideally we could make initialization only depend on the context, and not
>>>>>> check for count or the reserved flag.
>>>>>>
>>>>> This link is v1,
>>>>> https://lore.kernel.org/all/20230922070923.355656-1-yajun.deng@linux.dev/
>>>>>
>>>>> If we could make initialization only depend on the context, I'll modify it
>>>>> based on v1.
>>>> Although ~20% improvement looks impressive, this is only optimization of a
>>>> fraction of the boot time, and realistically, how much 56 msec saves from
>>>> the total boot time when you boot a machine with 190G of RAM?
>>> There are a lot of factors that can affect the total boot time. 56 msec
>>> saves may be insignificant.
>>>
>>> But if we look at the boot log, we'll see there's a significant time jump.
>>>
>>> before:
>>>
>>> [    0.250334] ACPI: PM-Timer IO Port: 0x508
>>> [    0.618994] Memory: 173413056K/199884452K available (18440K kernel code,
>>>
>>> after:
>>>
>>> [    0.260229] software IO TLB: area num 32.
>>> [    0.563497] Memory: 173413056K/199884452K available (18440K kernel code,
>>> Memory:
>>> Memory initialization is time consuming in the boot log.
>> You just confirmed that 56 msec is insignificant and then you send again
>> the improvement of ~60 msec in memory initialization.
>>
>> What does this improvement gain in percentage of total boot time?
> 
> 
> before:
> 
> [   10.692708] Run /init as init process
> 
> 
> after:
> 
> [   10.666290] Run /init as init process
> 
> 
> About 0.25%. The total boot time is variable, depending on how many
> drivers need to be initialized.
> 
> 
>>    
>>>> I still think the improvement does not justify the churn, added complexity
>>>> and special casing of different code paths of initialization of struct pages.
>>>
>>> Because there is a loop, if the order is MAX_ORDER, the loop will run 1024
>>> times. The following 'if' would be safer:
>>>
>>> 'if (context != MEMINIT_EARLY || (page_count(page) || >> PageReserved(page))
>>> {'
>> No, it will not.
>>
>> As the matter of fact any condition here won't be 'safer' because it makes
>> the code more complex and less maintainable.
>> Any future change in __free_pages_core() or one of it's callers will have
>> to reason what will happen with that condition after the change.
> 
> 
> To avoid introducing MEMINIT_LATE context and make code simpler. This
> might be a better option.
> 
> if (page_count(page) || PageReserved(page))

I'll have to side with Mike here; this change might not be worth it.

-- 
Cheers,

David / dhildenb

