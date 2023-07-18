Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74586757762
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjGRJI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGRJIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:08:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2751DE4F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689671286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BKG9FObck1CdANIm01krXeZUmtZmtC46SVZTLchKt24=;
        b=eyalL0Sr/unflFWHadhbvhmG5oI8tzcrv+vrAlg8nVCwCMcxelqPguF6nmoHQdTJtzQoUu
        KAoMJCOSIqOR1XwRa6ByM1dlg9ijMLxUktBIPPahFACbtcJvCClH+AxgfCjFs4sfFCeBz+
        LL1zX6wbEuC7WxMepaILjzWLNZ2u7J0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-O_G5Qkl6Msm43WWQB4cztA-1; Tue, 18 Jul 2023 05:08:05 -0400
X-MC-Unique: O_G5Qkl6Msm43WWQB4cztA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fbab56aac7so28621985e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689671284; x=1692263284;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BKG9FObck1CdANIm01krXeZUmtZmtC46SVZTLchKt24=;
        b=iNjCAy0DJuaiKCpA3xvSkVUXHf5lGtLAD3lMCPG9jPMqxG7aWMUyS9ohLk/hcIRIf6
         NbhMa4SBuAGLndA6Dl4vPAxBgS992BCNdDvIRQfHMUxuqIitWWS16fnFj7Ix2DdN4QhA
         kCDvXgSpMJ44uG5bZAYymr97uE6el0kfShYT61yYZPc4zmqA0pnk5Fx3NRv/K2EkZmre
         sSp7JrTGOY7K4qIPQSW4Nn/m9lOWc0lhvyHlM+46qZiNkCUUa8owD8q9YOmOq9uvI8Ej
         cAxLW9HHoLMYJsv3AJbnTkoZpD75pTH1X4WaZfyCz8GRLPTzbDY3B7dI0p85KR4XFP6o
         piTQ==
X-Gm-Message-State: ABy/qLYN21Ws3IOJbeuRgsLUwg2/wgNT1A1C+PZjGqVcReewR3bj3ly0
        3Thj2TNKBHyx72uMkiFPX8G+MO9KOtNlPPHbNNgMu/yRc12BvO1Xu8N55I+BzoOca0NfPzcrCVB
        zA+eXfkVzLUvb7u/OAkSFFDNQ
X-Received: by 2002:a05:600c:2057:b0:3fc:80a:9948 with SMTP id p23-20020a05600c205700b003fc080a9948mr1320145wmg.19.1689671284061;
        Tue, 18 Jul 2023 02:08:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH7SJeUnbGe0w78oFImYCchr0ERmP1KcAvy9jAAy3em9znD7MQbhH4aj+QotG8Lb6mQfeoLJg==
X-Received: by 2002:a05:600c:2057:b0:3fc:80a:9948 with SMTP id p23-20020a05600c205700b003fc080a9948mr1320131wmg.19.1689671283656;
        Tue, 18 Jul 2023 02:08:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c740:6200:84e1:eabc:8e2:7429? (p200300cbc740620084e1eabc08e27429.dip0.t-ipconnect.de. [2003:cb:c740:6200:84e1:eabc:8e2:7429])
        by smtp.gmail.com with ESMTPSA id m13-20020a7bce0d000000b003fbaa2903f4sm1625697wmc.19.2023.07.18.02.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 02:08:03 -0700 (PDT)
Message-ID: <7b0e691d-b224-20d0-a90a-bb659fbb3e1a@redhat.com>
Date:   Tue, 18 Jul 2023 11:08:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230717143110.260162-1-ryan.roberts@arm.com>
 <20230717143110.260162-2-ryan.roberts@arm.com>
 <90b406af-9db4-b668-a7a0-e574e104c84c@redhat.com>
 <028c5f5b-b67c-9ccc-bc06-468f47362999@arm.com>
 <0250a2d7-c79b-0e0f-8161-bf475daf1c82@redhat.com>
 <7319a1aa-7c72-82e9-f26d-eeccb6fdf35b@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 1/3] mm: Allow deferred splitting of arbitrary large
 anon folios
In-Reply-To: <7319a1aa-7c72-82e9-f26d-eeccb6fdf35b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 18.07.23 10:58, Ryan Roberts wrote:
> On 17/07/2023 17:48, David Hildenbrand wrote:
>> On 17.07.23 18:01, Ryan Roberts wrote:
>>> On 17/07/2023 16:42, David Hildenbrand wrote:
>>>> On 17.07.23 16:31, Ryan Roberts wrote:
>>>>> In preparation for the introduction of large folios for anonymous
>>>>> memory, we would like to be able to split them when they have unmapped
>>>>> subpages, in order to free those unused pages under memory pressure. So
>>>>> remove the artificial requirement that the large folio needed to be at
>>>>> least PMD-sized.
>>>>>
>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>> Reviewed-by: Yu Zhao <yuzhao@google.com>
>>>>> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
>>>>> ---
>>>>>     mm/rmap.c | 2 +-
>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>> index 0c0d8857dfce..2baf57d65c23 100644
>>>>> --- a/mm/rmap.c
>>>>> +++ b/mm/rmap.c
>>>>> @@ -1430,7 +1430,7 @@ void page_remove_rmap(struct page *page, struct
>>>>> vm_area_struct *vma,
>>>>>              * page of the folio is unmapped and at least one page
>>>>>              * is still mapped.
>>>>>              */
>>>>> -        if (folio_test_pmd_mappable(folio) && folio_test_anon(folio))
>>>>> +        if (folio_test_large(folio) && folio_test_anon(folio))
>>>>>                 if (!compound || nr < nr_pmdmapped)
>>>>>                     deferred_split_folio(folio);
>>>>
>>>> !compound will always be true I guess, so nr_pmdmapped == 0 (which will always
>>>> be the case) will be ignored.
>>>
>>> I don't follow why !compound will always be true. This function is
>>> page_remove_rmap() (not folio_remove_rmap_range() which I add in a later patch).
>>> page_remove_rmap() can work on pmd-mapped pages where compound=true is passed in.
>>
>> I was talking about the folio_test_pmd_mappable() -> folio_test_large() change.
>> For folio_test_large() && !folio_test_pmd_mappable() I expect that we'll never
>> pass in "compound=true".
>>
> 
> Sorry David, I've been staring at the code and your comment, and I still don't
> understand your point. I assumed you were trying to say that compound is always
> false and therefore "if (!compound || nr < nr_pmdmapped)" can be removed? But
> its not the case that compound is always false; it will be true when called to
> remove a pmd-mapped compound page.

Let me try again:

Assume, as I wrote, that we are given a folio that is 
"folio_test_large() && !folio_test_pmd_mappable()". That is, a folio 
that is *not* pmd mappable.

If it's not pmd-mappable, certainly, nr_pmdmapped == 0, and therefore, 
"nr < nr_pmdmapped" will never ever trigger.

The only way to have it added to the deferred split queue is, therefore 
"if (!compound)".

So *for these folios*, we will always pass "compound == false" to make 
that "if (!compound)" succeed.


Does that make sense?

> What change are you suggesting, exactly?

Oh, I never suggested a change (I even gave you my RB). I was just 
thinking out loud.

-- 
Cheers,

David / dhildenb

