Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5F58053BE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442338AbjLEMEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347038AbjLEMEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:04:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4A2A7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 04:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701777860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=jl52mxiCW+fUQJK9hXkJlcY9UhdIOXKKUh6Z+LnB7Y0=;
        b=cr/Re+N8AthbEDjsJJYjcaE8Tp1ZYMiG8tpPJqGuioS2sFoqzAvglusnrQKRbrGCU6Mpif
        q6S5HrjWTqGkkRyUqxwl8l3MCV5GwKQ93DErCNZh5/NaCaCiMl1cC7sqk9o6BVwZHy7Jrr
        8htO1t//0vTbP+ssldK0c3Yvc3thtxQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-xantePofNd-YVoY22SmLMA-1; Tue, 05 Dec 2023 07:04:18 -0500
X-MC-Unique: xantePofNd-YVoY22SmLMA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33343bb5dc2so1800918f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 04:04:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701777857; x=1702382657;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jl52mxiCW+fUQJK9hXkJlcY9UhdIOXKKUh6Z+LnB7Y0=;
        b=agR7vKJ0h5mqR//Lo/iIn0NzV57REnhWWL2i4KDB2RmddvkD1X9UjJUMeZT+Q6XTSg
         xOlj5n9ipzxuKwo9EfgeT8EL6BjE9u2QhkVSykdeZkD54Lxp93ae4s2nqb2u92+rJPCE
         3yGkCUb40UT5MoGGWh1UG4RvliJg3PIZ6c1pwceR53XNHbVkumLjhA+//zWCetGteZy1
         mACAaesliEMvl8F1Z1JEGo7X/fEX2uhEKtFiuQwN/idG096qBJhd1u6hh9EPVCBzGhia
         8vxYpF+5mWzchG3S+Pg7MSpFQsMkhUzYCXIU9XThitvL8f6CP0zOMh7wQk/zi0x78VWk
         JPyA==
X-Gm-Message-State: AOJu0YwErALYLa0vWbgK+cMS5kyz6uUSATDuiojs+SKLy5noPGX6Qj84
        2MzyreVRsAFTOGojFvbYdCAyJHFIq2ttxKdjfeCLbru2+Ubl/+DikL+t2Ez2Fr2/URZ8XyjnYZX
        nO8f//OlsJZXsT4GNzQjyvKrs
X-Received: by 2002:a05:600c:2186:b0:40b:5e59:ea08 with SMTP id e6-20020a05600c218600b0040b5e59ea08mr414049wme.167.1701777857316;
        Tue, 05 Dec 2023 04:04:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6TKCaPuh4FTLHwBXJWfGIYW8w8wk2Gc1SnoAdJUygGz+sRUpMPphWMfkCi2+CQzdy3mW0TQ==
X-Received: by 2002:a05:600c:2186:b0:40b:5e59:ea08 with SMTP id e6-20020a05600c218600b0040b5e59ea08mr414024wme.167.1701777856853;
        Tue, 05 Dec 2023 04:04:16 -0800 (PST)
Received: from ?IPV6:2003:cb:c72f:300:1ec7:2962:8889:ef6? (p200300cbc72f03001ec7296288890ef6.dip0.t-ipconnect.de. [2003:cb:c72f:300:1ec7:2962:8889:ef6])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c4f8a00b0040b4b2a15ebsm18335786wmq.28.2023.12.05.04.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 04:04:16 -0800 (PST)
Message-ID: <df99bb4e-f69d-4d94-baa5-2fc336df1a7b@redhat.com>
Date:   Tue, 5 Dec 2023 13:04:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/15] mm: Batch-copy PTE ranges during fork()
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231204105440.61448-1-ryan.roberts@arm.com>
 <20231204105440.61448-2-ryan.roberts@arm.com>
 <a12ce4f8-feb0-4e35-8f55-9270fe5a808b@redhat.com>
 <104de2d6-ecf9-4b0c-a982-5bd8e1aea758@redhat.com>
 <5b8b9f8c-8e9b-42a5-b8b2-9b96903f3ada@redhat.com>
 <a81dc390-8b10-4ce9-b72f-57f253e77af3@arm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <a81dc390-8b10-4ce9-b72f-57f253e77af3@arm.com>
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

On 05.12.23 12:30, Ryan Roberts wrote:
> On 04/12/2023 17:27, David Hildenbrand wrote:
>>>
>>> With rmap batching from [1] -- rebased+changed on top of that -- we could turn
>>> that into an effective (untested):
>>>
>>>            if (page && folio_test_anon(folio)) {
>>> +               nr = folio_nr_pages_cont_mapped(folio, page, src_pte, addr, end,
>>> +                                               pte, enforce_uffd_wp, &nr_dirty,
>>> +                                               &nr_writable);
>>>                    /*
>>>                     * If this page may have been pinned by the parent process,
>>>                     * copy the page immediately for the child so that we'll always
>>>                     * guarantee the pinned page won't be randomly replaced in the
>>>                     * future.
>>>                     */
>>> -               folio_get(folio);
>>> -               if (unlikely(folio_try_dup_anon_rmap_pte(folio, page,
>>> src_vma))) {
>>> +               folio_ref_add(folio, nr);
>>> +               if (unlikely(folio_try_dup_anon_rmap_ptes(folio, page, nr,
>>> src_vma))) {
>>>                            /* Page may be pinned, we have to copy. */
>>> -                       folio_put(folio);
>>> -                       return copy_present_page(dst_vma, src_vma, dst_pte,
>>> src_pte,
>>> -                                                addr, rss, prealloc, page);
>>> +                       folio_ref_sub(folio, nr);
>>> +                       ret = copy_present_page(dst_vma, src_vma, dst_pte,
>>> +                                               src_pte, addr, rss, prealloc,
>>> +                                               page);
>>> +                       return ret == 0 ? 1 : ret;
>>>                    }
>>> -               rss[MM_ANONPAGES]++;
>>> +               rss[MM_ANONPAGES] += nr;
>>>            } else if (page) {
>>> -               folio_get(folio);
>>> -               folio_dup_file_rmap_pte(folio, page);
>>> -               rss[mm_counter_file(page)]++;
>>> +               nr = folio_nr_pages_cont_mapped(folio, page, src_pte, addr, end,
>>> +                                               pte, enforce_uffd_wp, &nr_dirty,
>>> +                                               &nr_writable);
>>> +               folio_ref_add(folio, nr);
>>> +               folio_dup_file_rmap_ptes(folio, page, nr);
>>> +               rss[mm_counter_file(page)] += nr;
>>>            }
>>>
>>>
>>> We'll have to test performance, but it could be that we want to specialize
>>> more on !folio_test_large(). That code is very performance-sensitive.
>>>
>>>
>>> [1] https://lkml.kernel.org/r/20231204142146.91437-1-david@redhat.com
>>
>> So, on top of [1] without rmap batching but with a slightly modified version of
> 
> Can you clarify what you mean by "without rmap batching"? I thought [1]
> implicitly adds rmap batching? (e.g. folio_dup_file_rmap_ptes(), which you've
> added in the code snippet above).

Not calling the batched variants but essentially doing what your code 
does (with some minor improvements, like updating the rss counters only 
once).

The snipped above is only linked below. I had the performance numbers 
for [1] ready, so I gave it a test on top of that.

To keep it simple, you might just benchmark w and w/o your patches.

> 
>> yours (that keeps the existing code structure as pointed out and e.g., updates
>> counter updates), running my fork() microbenchmark with a 1 GiB of memory:
>>
>> Compared to [1], with all order-0 pages it gets 13--14% _slower_ and with all
>> PTE-mapped THP (order-9) it gets ~29--30% _faster_.
> 
> What test are you running - I'd like to reproduce if possible, since it sounds
> like I've got some work to do to remove the order-0 regression.

Essentially just allocating 1 GiB of memory an measuring how long it 
takes to call fork().

order-0 benchmarks:

https://gitlab.com/davidhildenbrand/scratchspace/-/raw/main/order-0-benchmarks.c?ref_type=heads

e.g.,: $ ./order-0-benchmarks fork 100


pte-mapped-thp benchmarks:

https://gitlab.com/davidhildenbrand/scratchspace/-/raw/main/pte-mapped-thp-benchmarks.c?ref_type=heads

e.g.,: $ ./pte-mapped-thp-benchmarks fork 100


Ideally, pin to one CPU and get stable performance numbers by disabling 
SMT+turbo etc.

> 
>>
>> So looks like we really want to have a completely seprate code path for
>> "!folio_test_large()" to keep that case as fast as possible. And "Likely" we
>> want to use "likely(!folio_test_large()". ;)
> 
> Yuk, but fair enough. If I can repro the perf numbers, I'll have a go a
> reworking this.
> 
> I think you're also implicitly suggesting that this change needs to depend on
> [1]? Which is a shame...

Not necessarily. It certainly cleans up the code, but we can do that in 
any order reasonable.

> 
> I guess I should also go through a similar exercise for patch 2 in this series.


Yes. There are "unmap" and "pte-dontneed" benchmarks contained in both 
files above.

-- 
Cheers,

David / dhildenb

