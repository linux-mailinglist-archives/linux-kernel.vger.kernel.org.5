Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71940803346
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbjLDMn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbjLDMn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:43:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED3BA9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701693841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=5JxMYP8OfSesQLX1q9G3uaPEX2MmHHO3AMt7LXXXPw8=;
        b=bZaR5+t2eSfuVLskawSlhCVaa+Lsd9tt5JBvgYnuM++urUnVb9N6JqEX4RL68mRNaxEe/a
        RZpHBwEwv8HUXm27yztNUU7CXcuTS0PC//078BPu9U8cl6+t1N8YeqM8vmWLh2Jp0mUf3d
        yRW9AL7AFTTW9SX4b5Lg0EMIl4gaHf0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-Yh5nqA3PPauYmgKMyWVvrQ-1; Mon, 04 Dec 2023 07:43:57 -0500
X-MC-Unique: Yh5nqA3PPauYmgKMyWVvrQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33349915da5so906101f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 04:43:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701693836; x=1702298636;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JxMYP8OfSesQLX1q9G3uaPEX2MmHHO3AMt7LXXXPw8=;
        b=lMzm6gnBcPxv4wpCiZRGJOgMV/HvbzxkXP+bicMWx7Y+Wm3bAW9CTrTb/7muutV99y
         CQqxB/CnbKS4vM9w0xxS/empK4OZv41VaTh6QoiyfSdii8ZyHHko+ZUrd10vcHoS4rFz
         YBwljmTyFFDaNsRdcyM4G+rPaUnAcScvdR4UAbPBgQJKN/RftE1G0+oISCdrw/wMf6R/
         vm/dtJWCto9fNr6zM3S93ruJUtL0DaSOd+by2vijESd7Omx7hKdhc5Ksl7aizoCjgbUn
         w1NSiTGbQ5LaXfFd0tFo9bUHDwjmn5vq5xQsthGL+wo7loDP8bPZlnWJYnM8QFCovfj5
         39Eg==
X-Gm-Message-State: AOJu0YzpxLa4DgL43UtZi4RFumaXY7fBDfp/g/IR1+PK0SKnp7UBUdF+
        odIM/TYfUcsHY6h+CHRNglJToDT3h3tWttrTJUkI26v7w9aQZ4KLFSwlYvIn6fStbMH/Go9MCt5
        82CVLZhfbl24C1byYd9dhySgI
X-Received: by 2002:adf:f802:0:b0:333:3db2:c3e1 with SMTP id s2-20020adff802000000b003333db2c3e1mr1686045wrp.111.1701693836675;
        Mon, 04 Dec 2023 04:43:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8bQGn0Ci/jT8fvChhmMRFkq2R14onpDlkODa7S2MKJpWX2RD36i4HlpUxaXE7Yj94jnoVEQ==
X-Received: by 2002:adf:f802:0:b0:333:3db2:c3e1 with SMTP id s2-20020adff802000000b003333db2c3e1mr1686032wrp.111.1701693836317;
        Mon, 04 Dec 2023 04:43:56 -0800 (PST)
Received: from ?IPV6:2003:cb:c722:3700:6501:8925:6f9:fcdc? (p200300cbc72237006501892506f9fcdc.dip0.t-ipconnect.de. [2003:cb:c722:3700:6501:8925:6f9:fcdc])
        by smtp.gmail.com with ESMTPSA id a4-20020a056000050400b003334675634bsm3683249wrf.29.2023.12.04.04.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 04:43:55 -0800 (PST)
Message-ID: <635de797-1219-40b0-b4b2-7eba758749a5@redhat.com>
Date:   Mon, 4 Dec 2023 13:43:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] mm/mmu_gather: Store and process pages in contig
 ranges
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>, Zi Yan <ziy@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Yu Zhao <yuzhao@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230810103332.3062143-1-ryan.roberts@arm.com>
 <20230810103332.3062143-5-ryan.roberts@arm.com>
 <800937DA-BAD0-4C60-B155-AECCA21E955E@nvidia.com>
 <1a0f5cb8-421c-4f28-a986-f3c381406e81@arm.com>
 <90EC4C0D-0254-4B93-AFD5-3C09580A77DE@nvidia.com>
 <6dd6164a-1dd5-46e7-bcf7-b62ff5c6e8ec@arm.com>
 <890f4455-bf1b-437b-a355-7895e4dd3085@redhat.com>
 <52b042b9-ec95-4db0-b38a-f7f1cea0b90c@arm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <52b042b9-ec95-4db0-b38a-f7f1cea0b90c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.12.23 13:39, Ryan Roberts wrote:
> On 04/12/2023 12:28, David Hildenbrand wrote:
>> On 04.12.23 13:26, Ryan Roberts wrote:
>>>>>>
>>>>>> Also, struct page (memmap) might not be always contiguous, using struct page
>>>>>> points to represent folio range might not give the result you want.
>>>>>> See nth_page() and folio_page_idx() in include/linux/mm.h.
>>>>>
>>>>> Is that true for pages within the same folio too? Or are all pages in a folio
>>>>> guarranteed contiguous? Perhaps I'm better off using pfn?
>>>>
>>>> folio_page_idx() says not all pages in a folio is guaranteed to be contiguous.
>>>> PFN might be a better choice.
>>>
>>> Hi Zi, Matthew,
>>>
>>> Zi made this comment a couple of months back that it is incorrect to assume that
>>> `struct page`s within a folio are (virtually) contiguous. I'm not sure if that's
>>> really the case though? I see other sites in the source that do page++ when
>>> iterating over a folio. e.g. smaps_account(), splice_folio_into_pipe(),
>>> __collapse_huge_page_copy(), etc.
>>>
>>> Any chance someone could explain the rules?
>>
>> With the vmemmap, they are contiguous. Without a vmemmap, but with sparsemem, we
>> might end up allocating one memmap chunk per memory section (e.g., 128 MiB).
>>
>> So, for example, a 1 GiB hugetlb page could cross multiple 128 MiB sections, and
>> therefore, the memmap might not be virtually consecutive.
> 
> OK, is a "memory section" always 128M or is it variable? If fixed, does that
> mean that it's impossible for a THP to cross section boundaries? (because a THP
> is always smaller than a section?)

Section size is variable (see SECTION_SIZE_BITS), but IIRC, buddy 
allocations will never cross them.

> 
> Trying to figure out why my original usage in this series was wrong, but
> presumably the other places that I mentioned are safe.

If only dealing with buddy allocations, *currently* it might always fall 
into a single memory section.

-- 
Cheers,

David / dhildenb

