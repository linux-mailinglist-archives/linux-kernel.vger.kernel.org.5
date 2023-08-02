Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED4176CC19
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbjHBLxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjHBLxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:53:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC2B2D40
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 04:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690977164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5SbuVFR03MYvfb13U1nMAvAGZ+NkapiDklKoMGko6wE=;
        b=dJ/oqlGa8irg5Q4b8rhkZ1WZJJh+cuf1ulVqLEqiQqLL314DMVR87ysfpvUerK2Cdp/tpk
        5NU/2Iyp/jsFrVBqIDDKxfAQmIk9GgWt7Et8yb0SXR30DIEqCfN/AhwaBsRXub3qglpZST
        eCo60RcK0O/TRGnaZLtJFSP9143It8k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-h1O9bO1eM9GpBbrAHteaBA-1; Wed, 02 Aug 2023 07:52:43 -0400
X-MC-Unique: h1O9bO1eM9GpBbrAHteaBA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30793c16c78so4295075f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 04:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690977162; x=1691581962;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5SbuVFR03MYvfb13U1nMAvAGZ+NkapiDklKoMGko6wE=;
        b=KZzkC32rgG6ix++qIBasN52b6YukW7np1VHzFh6kOPUT//RpWDdNv0pHPRFYqIXXeE
         +HWOqf45z4vMa4EQaV2nLPVdPy/PZAe45hyfvKyzk1p1JaRZmlS4SD/CkP4lw7g57LwY
         U6HGJhkXb6+1kNuqeZ6stA0IHT+9J1zylEC68qQJ9BDkZ7i6Kvjyf/VGiWDlXfATeQFQ
         S93zK5XEUTHKYNqCrTEHb4jHDbpB1yMZM204xZyqzGwBUHXXrRBfu4NYmTEWMwrZ3j5A
         NWKSX7NwNuyqXmRxJRS2KBnrFhKId22Tc3YFz9dpv/Pbq/Czq/U2aG6Q37iQyxLeki61
         /Pqg==
X-Gm-Message-State: ABy/qLYUgEJ8ghc/YNDt9Iu/fffExhKcdgQwEySJausy/9OSqV0PxWlT
        4Al+23ZtDWy/FsVjZ4TEOaLvu9R8CV4B4ll4NlZllqiqr/XxH6B8sMHwGrgI39R/sAMwGmmZgOO
        Zk4FtWaKq6awbJXHIkCFx0gZ1
X-Received: by 2002:adf:e7cb:0:b0:314:2132:a277 with SMTP id e11-20020adfe7cb000000b003142132a277mr5076684wrn.9.1690977161970;
        Wed, 02 Aug 2023 04:52:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEXKitccTNjLbBaunJd/lIcNHXV0fS8ByyqZPsRwUJgtwC37K9kQMbP0eifwf8QDG7nU35foQ==
X-Received: by 2002:adf:e7cb:0:b0:314:2132:a277 with SMTP id e11-20020adfe7cb000000b003142132a277mr5076659wrn.9.1690977161481;
        Wed, 02 Aug 2023 04:52:41 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:e00:b8a4:8613:1529:1caf? (p200300cbc70b0e00b8a4861315291caf.dip0.t-ipconnect.de. [2003:cb:c70b:e00:b8a4:8613:1529:1caf])
        by smtp.gmail.com with ESMTPSA id l9-20020a05600012c900b003143801f8d8sm18828317wrx.103.2023.08.02.04.52.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 04:52:40 -0700 (PDT)
Message-ID: <df78f949-dfaf-7378-fe64-c39235e7afb8@redhat.com>
Date:   Wed, 2 Aug 2023 13:52:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/2] don't use mapcount() to check large folio sharing
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
 <2722c9ad-370a-70ff-c374-90a94eca742a@redhat.com>
 <2d64ca09-06fe-a32f-16f9-c277b7033b57@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <2d64ca09-06fe-a32f-16f9-c277b7033b57@arm.com>
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

On 02.08.23 13:51, Ryan Roberts wrote:
> On 02/08/2023 12:36, David Hildenbrand wrote:
>> On 02.08.23 13:20, Ryan Roberts wrote:
>>> On 02/08/2023 11:48, David Hildenbrand wrote:
>>>> On 02.08.23 12:27, Ryan Roberts wrote:
>>>>> On 28/07/2023 17:13, Yin Fengwei wrote:
>>>>>> In madvise_cold_or_pageout_pte_range() and madvise_free_pte_range(),
>>>>>> folio_mapcount() is used to check whether the folio is shared. But it's
>>>>>> not correct as folio_mapcount() returns total mapcount of large folio.
>>>>>>
>>>>>> Use folio_estimated_sharers() here as the estimated number is enough.
>>>>>>
>>>>>> Yin Fengwei (2):
>>>>>>      madvise: don't use mapcount() against large folio for sharing check
>>>>>>      madvise: don't use mapcount() against large folio for sharing check
>>>>>>
>>>>>>     mm/huge_memory.c | 2 +-
>>>>>>     mm/madvise.c     | 6 +++---
>>>>>>     2 files changed, 4 insertions(+), 4 deletions(-)
>>>>>>
>>>>>
>>>>> As a set of fixes, I agree this is definitely an improvement, so:
>>>>>
>>>>> Reviewed-By: Ryan Roberts
>>>>>
>>>>>
>>>>> But I have a couple of comments around further improvements;
>>>>>
>>>>> Once we have the scheme that David is working on to be able to provide precise
>>>>> exclusive vs shared info, we will probably want to move to that. Although that
>>>>> scheme will need access to the mm_struct of a process known to be mapping the
>>>>
>>>> There are probably ways to work around lack of mm_struct, but it would not be
>>>> completely for free. But passing the mm_struct should probably be an easy
>>>> refactoring.
>>>>
>>>>> folio. We have that info, but its not passed to folio_estimated_sharers() so we
>>>>> can't just reimplement folio_estimated_sharers() - we will need to rework these
>>>>> call sites again.
>>>>
>>>> We should probably just have a
>>>>
>>>> folio_maybe_mapped_shared()
>>>>
>>>> with proper documentation. Nobody should care about the exact number.
>>>>
>>>>
>>>> If my scheme for anon pages makes it in, that would be precise for anon pages
>>>> and we could document that. Once we can handle pagecache pages as well to get a
>>>> precise answer, we could change to folio_mapped_shared() and adjust the
>>>> documentation.
>>>
>>> Makes sense to me. I'm assuming your change would allow us to get rid of
>>> PG_anon_exclusive too? In which case we would also want a precise API
>>> specifically for anon folios for the CoW case, without waiting for pagecache
>>> page support.
>>
>> Not necessarily and I'm currently not planning that
>>
>> On the COW path, I'm planning on using it only when PG_anon_exclusive is clear
>> for a compound page, combined with a check that there are no other page
>> references besides from mappings: all mappings from me and #refs == #mappings ->
>> reuse (set PG_anon_exclusive). That keeps the default (no fork) as fast as
>> possible and simple.
>>
>>>>
>>>> I just saw
>>>>
>>>> https://lkml.kernel.org/r/20230802095346.87449-1-wangkefeng.wang@huawei.com
>>>>
>>>> that converts a lot of code to folio_estimated_sharers().
>>>>
>>>>
>>>> That patchset, for example, also does
>>>>
>>>> total_mapcount(page) > 1 -> folio_estimated_sharers(folio) > 1
>>>>
>>>> I'm not 100% sure what to think about that at this point. We eventually add
>>>> false negatives (actually shared but we fail to detect it) all over the place,
>>>> instead of having false positives (actually exclusive, but we fail to detect
>>>> it).
>>>>
>>>> And that patch set doesn't even spell that out.
>>>>
>>>>
>>>> Maybe it's as good as we will get, especially if my scheme doesn't make it in.
>>>
>>> I've been working on the assumption that your scheme is plan A, and I'm waiting
>>> for it to unblock forward progress on large anon folios. Is this the right
>>> approach, or do you think your scheme is sufficiently riskly and/or far out that
>>> I should aim not to depend on it?
>>
>> It is plan A. IMHO, it does not feel too risky and/or far out at this point --
>> and the implementation should not end up too complicated. But as always, I
>> cannot promise anything before it's been implemented and discussed upstream.
> 
> OK, good we are on the same folio... (stolen from Hugh; if a joke is worth
> telling once, its worth telling 1000 times ;-)

Heard it first the time :))

-- 
Cheers,

David / dhildenb

