Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA56576CBDD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbjHBLhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjHBLhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:37:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218662684
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 04:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690976197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QNipgsMHiGdtUITpPGu3dAw5v0sDpWz2SWPH1sSL1Fw=;
        b=JuTe7Gobgn2ra15deV52HV5YG24WtrNvSZ0Y2xwg8gvBhbDpOuZ13juqUF/7KcWL+wVBu1
        igc96ymQbgturf5VAliLZsd2n3PojXETRWt4p8hHvfE7V/AoC8FO9BnGm+83MW8/bUgJ1D
        AjfrRiZVu96Z2bR2IqmFyeMxUP817FA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393--P2k4d2ePIaMGOJ-z8IiwA-1; Wed, 02 Aug 2023 07:36:31 -0400
X-MC-Unique: -P2k4d2ePIaMGOJ-z8IiwA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fe25f8c4bfso14670655e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 04:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690976190; x=1691580990;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QNipgsMHiGdtUITpPGu3dAw5v0sDpWz2SWPH1sSL1Fw=;
        b=BHD4oXCA1WAn2G2QY8XhwXWJncp0fyM/tbXVZrtduVXOjIo+B7qZd7/4LJ2qYERVwU
         HvUcm+GeFCG1HZGfmr0th5lWKL0Y9bmew8pOsk2j+RPmFsfqfG+AG2e+cew0Ij5ENqie
         uzl678/A6eWiAg+siA4F2c/J8qs4RUjPo1SXDMi9j3M3Sq6NxCFY9mTOgFKL9PfiBP3M
         u2baTBNLREzj7llA+8NSsDPuWtbzb4mI+23GQV28nHuLzJ4PZOwrWj11tqF/sS9B3Mp+
         vraR9iYOaL8CbbSdMQequE+B+7pPlxwGs7fCFz5dDLRMEUfIN8y4Z9/ChHoQ59gSyyLY
         ky/g==
X-Gm-Message-State: ABy/qLYxTJYkblxV3vkVYq5IIC1h5Hc9e389lSYZAhi1uXRMcUP6MtN+
        foa6GJKkNN5+73a9KnKd8ygPRvKLQhYud88zB7j691k9+Q3aJMVGBBrk7dnXNdkacJj1jYmoFIt
        GzDZjT5Fwyd5FPe8O4KWbX1fw
X-Received: by 2002:a1c:7507:0:b0:3fe:111a:d1d9 with SMTP id o7-20020a1c7507000000b003fe111ad1d9mr4766067wmc.25.1690976189783;
        Wed, 02 Aug 2023 04:36:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHZS2OaTjXDVGDs361yJb2dnEvrRsXZqJIy8idD/Yq/NZmIENOwxB1EnvMjWwdyvaoOyqnvTA==
X-Received: by 2002:a1c:7507:0:b0:3fe:111a:d1d9 with SMTP id o7-20020a1c7507000000b003fe111ad1d9mr4766050wmc.25.1690976189418;
        Wed, 02 Aug 2023 04:36:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:e00:b8a4:8613:1529:1caf? (p200300cbc70b0e00b8a4861315291caf.dip0.t-ipconnect.de. [2003:cb:c70b:e00:b8a4:8613:1529:1caf])
        by smtp.gmail.com with ESMTPSA id n7-20020a1c7207000000b003fc00212c1esm1417634wmc.28.2023.08.02.04.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 04:36:28 -0700 (PDT)
Message-ID: <2722c9ad-370a-70ff-c374-90a94eca742a@redhat.com>
Date:   Wed, 2 Aug 2023 13:36:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Yin Fengwei <fengwei.yin@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, willy@infradead.org,
        vishal.moola@gmail.com, wangkefeng.wang@huawei.com,
        minchan@kernel.org, yuzhao@google.com, shy828301@gmail.com
References: <20230728161356.1784568-1-fengwei.yin@intel.com>
 <3bbfde16-ced1-dca8-6a3f-da893e045bc5@arm.com>
 <31093c49-5baa-caed-9871-9503cb89454b@redhat.com>
 <20419779-b5f5-7240-3f90-fe5c4b590e4d@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 0/2] don't use mapcount() to check large folio sharing
In-Reply-To: <20419779-b5f5-7240-3f90-fe5c4b590e4d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.08.23 13:20, Ryan Roberts wrote:
> On 02/08/2023 11:48, David Hildenbrand wrote:
>> On 02.08.23 12:27, Ryan Roberts wrote:
>>> On 28/07/2023 17:13, Yin Fengwei wrote:
>>>> In madvise_cold_or_pageout_pte_range() and madvise_free_pte_range(),
>>>> folio_mapcount() is used to check whether the folio is shared. But it's
>>>> not correct as folio_mapcount() returns total mapcount of large folio.
>>>>
>>>> Use folio_estimated_sharers() here as the estimated number is enough.
>>>>
>>>> Yin Fengwei (2):
>>>>     madvise: don't use mapcount() against large folio for sharing check
>>>>     madvise: don't use mapcount() against large folio for sharing check
>>>>
>>>>    mm/huge_memory.c | 2 +-
>>>>    mm/madvise.c     | 6 +++---
>>>>    2 files changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>
>>> As a set of fixes, I agree this is definitely an improvement, so:
>>>
>>> Reviewed-By: Ryan Roberts
>>>
>>>
>>> But I have a couple of comments around further improvements;
>>>
>>> Once we have the scheme that David is working on to be able to provide precise
>>> exclusive vs shared info, we will probably want to move to that. Although that
>>> scheme will need access to the mm_struct of a process known to be mapping the
>>
>> There are probably ways to work around lack of mm_struct, but it would not be
>> completely for free. But passing the mm_struct should probably be an easy
>> refactoring.
>>
>>> folio. We have that info, but its not passed to folio_estimated_sharers() so we
>>> can't just reimplement folio_estimated_sharers() - we will need to rework these
>>> call sites again.
>>
>> We should probably just have a
>>
>> folio_maybe_mapped_shared()
>>
>> with proper documentation. Nobody should care about the exact number.
>>
>>
>> If my scheme for anon pages makes it in, that would be precise for anon pages
>> and we could document that. Once we can handle pagecache pages as well to get a
>> precise answer, we could change to folio_mapped_shared() and adjust the
>> documentation.
> 
> Makes sense to me. I'm assuming your change would allow us to get rid of
> PG_anon_exclusive too? In which case we would also want a precise API
> specifically for anon folios for the CoW case, without waiting for pagecache
> page support.

Not necessarily and I'm currently not planning that

On the COW path, I'm planning on using it only when PG_anon_exclusive is 
clear for a compound page, combined with a check that there are no other 
page references besides from mappings: all mappings from me and #refs == 
#mappings -> reuse (set PG_anon_exclusive). That keeps the default (no 
fork) as fast as possible and simple.

>>
>> I just saw
>>
>> https://lkml.kernel.org/r/20230802095346.87449-1-wangkefeng.wang@huawei.com
>>
>> that converts a lot of code to folio_estimated_sharers().
>>
>>
>> That patchset, for example, also does
>>
>> total_mapcount(page) > 1 -> folio_estimated_sharers(folio) > 1
>>
>> I'm not 100% sure what to think about that at this point. We eventually add
>> false negatives (actually shared but we fail to detect it) all over the place,
>> instead of having false positives (actually exclusive, but we fail to detect it).
>>
>> And that patch set doesn't even spell that out.
>>
>>
>> Maybe it's as good as we will get, especially if my scheme doesn't make it in.
> 
> I've been working on the assumption that your scheme is plan A, and I'm waiting
> for it to unblock forward progress on large anon folios. Is this the right
> approach, or do you think your scheme is sufficiently riskly and/or far out that
> I should aim not to depend on it?

It is plan A. IMHO, it does not feel too risky and/or far out at this 
point -- and the implementation should not end up too complicated. But 
as always, I cannot promise anything before it's been implemented and 
discussed upstream.

Hopefully, we know more soon. I'll get at implementing it fairly soon.

-- 
Cheers,

David / dhildenb

