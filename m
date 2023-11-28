Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3C57FC281
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346128AbjK1OKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346214AbjK1OJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:09:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9473A26AE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701180556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=6rD7l3xgw8qO4YXthzN1zA4kJtJwVsi4uOUnlxHADTI=;
        b=B0YrZUQqJerm5FA2IaLTkezK0/Jm9h5+N/WNtPHkT6XV06wNGNKuWflB8jnJMAqJnjgeQh
        QoA/8B2QmTvkJ267W5ajkOvLSfCisZYz8lvmXQuWk1ahmmBOXNXck5/k7qfOVzXMXPScxT
        JEGsNod/R1NFX8KtdAby5pqHfh8PL7A=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-aSwniaG1NmGeVLUtcVnmjw-1; Tue, 28 Nov 2023 09:09:15 -0500
X-MC-Unique: aSwniaG1NmGeVLUtcVnmjw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50ab7b85b6eso5852561e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:09:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701180554; x=1701785354;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rD7l3xgw8qO4YXthzN1zA4kJtJwVsi4uOUnlxHADTI=;
        b=Gza6DuxUJBiXW7ibQ1nkvAYlIyYawoXv7Hp7/FH7KVOU/UHlwu7Cn3E7tz3/7a8E2r
         cWeJUOKidjldJH3mhutoFrOFRjK/OephNquKCTdIa08KJkjnmfWk2OrSv51d/IoZe/1b
         bKXaS5Jbtd8UCi8L2NrDyycLcVH6GjiPlEvQJuDT0sfymR7obVbpNWY81EjxyvKhVthJ
         azrZrLLEqmgz5l9qi0eZkB7Ae44BcCGT83jQa7AZhRRs7jJuu/dfuXGx4SCTKAs4bk4a
         1v4nXjulCjanpBnhId/cEXh2W6aOoHzqpvw8U7U0jk2dDOp37FqC4zN5GtQ9NAmCVd31
         jQbQ==
X-Gm-Message-State: AOJu0YzruA6SBpRQsO9EpQPyn1Dxc6rD9CpQxigDJ9/48kfvTrl9QXMa
        J4Y8VmGZQAeTZ+h0We0n5BEbYKTGfywm46jHZ0cLXm0XV/kSAVQhrfS453DFU6kjIapSjCEOhbi
        xUjjb6WzmT+7o9AES2QpucyPu
X-Received: by 2002:a05:6512:108f:b0:507:97ca:ec60 with SMTP id j15-20020a056512108f00b0050797caec60mr12722324lfg.3.1701180553683;
        Tue, 28 Nov 2023 06:09:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmzVYh6crZ9BpaUDD0a4jKJChCFBUayhMLyOIQn1Lecptib9b5wTAnopGkdiy8/ge9k54Cdg==
X-Received: by 2002:a05:6512:108f:b0:507:97ca:ec60 with SMTP id j15-20020a056512108f00b0050797caec60mr12722305lfg.3.1701180553216;
        Tue, 28 Nov 2023 06:09:13 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:1d00:99ec:9656:7475:678d? (p200300cbc7081d0099ec96567475678d.dip0.t-ipconnect.de. [2003:cb:c708:1d00:99ec:9656:7475:678d])
        by smtp.gmail.com with ESMTPSA id n44-20020a05600c502c00b004083a105f27sm18382468wmr.26.2023.11.28.06.09.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 06:09:12 -0800 (PST)
Message-ID: <137902b6-24dc-4d51-9be2-6f94aa9dbc3a@redhat.com>
Date:   Tue, 28 Nov 2023 15:09:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v7 00/10] Small-sized THP for anonymous memory
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231122162950.3854897-1-ryan.roberts@arm.com>
 <ZV9267tQEhoPzCru@casper.infradead.org>
 <f8e518f2-fb15-4295-a335-bea5a8010ab2@arm.com>
 <ZWC9lwDAjMZsNzoG@casper.infradead.org>
 <9c8f6d2a-7ed8-45d2-9684-d77489bd99b8@redhat.com>
 <ZWDG6BYqmZVpyTLL@casper.infradead.org>
 <26c361bc-6d87-4a57-9fae-ef635c9039c7@redhat.com>
 <87sf4rppuc.fsf@nvdebian.thelocal>
 <51e6c9f1-e863-464b-b5f3-d7f60a7ebed6@arm.com>
 <b2d19306-0d68-4aef-9b68-15948ddc8ea0@nvidia.com>
 <afb92816-25ed-41c8-a48b-94fb2d885d8e@redhat.com>
 <58af512c-3d7d-4774-88f7-6336c9384b61@arm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <58af512c-3d7d-4774-88f7-6336c9384b61@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.11.23 13:15, Ryan Roberts wrote:
> On 28/11/2023 08:48, David Hildenbrand wrote:
>>
>>>>
>>>> Agreed. We are bikeshedding here. But if we really can't swallow "small-sized
>>>> THP" then perhaps the most efficient way to move this forwards is to review the
>>>> documentation (where "small-sized THP" appears twice in order to differentiate
>>>> from PMD-sized THP) - its in patch 3. Perhaps it will be easier to come up with
>>>> a good description in the context of those prose? Then once we have that,
>>>> hopefully a term will fall out that I'll update the commit logs with.
>>>>
>>>
>>> I will see you over in patch 3, then. I've already looked at it and am going
>>> to suggest a long and a short name. The long name is for use in comments and
>>> documentation, and the short name is for variable fragments:
>>>
>>>        Long name:  "pte-mapped THPs"
>>>        Short names: pte_thp, or pte-thp
>>
>> The issue is that any THP can be pte-mapped, even a PMD-sized THP. However, the
>> "natural" way to map a PMD-sized THP is using a PMD.
>>
> 
> How about we just stop trying to come up with a term for the "small-sized THP"
> vs "PMD-sized THP" and instead invent a name that covers ALL THP:
> 
> "multi-size THP" vs "PMD-sized THP".
> 
> Then in the docs we can talk about how multi-size THP introduces the ability to
> allocate memory in blocks that are bigger than a base page but smaller than
> traditional PMD-size, in increments of a power-of-2 number of pages.

So you're thinking of something like "multi-size THP" as a feature name, 
and stating that for now we limit it to <= PMD size. mTHP would be the 
short name?

For the stats, we'd document that "AnonHugePages" and friends only count 
traditional PMD-sized THP for historical reasons -- and that 
AnonHugePages should have been called AnonHugePmdMapped (which we could 
still add as an alias and document why AnonHugePages is weird).

Regarding new stats, maybe an interface that indicates the actual sizes 
would be best. As discussed, extending the existing single-large-file 
statistics might not be possible and we'd have to come up with a new 
interface, that maybe completely lacks "AnonHugePages" and directly goes 
for the individual sizes.

-- 
Cheers,

David / dhildenb

