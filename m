Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C5C7BE34B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjJIOoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjJIOoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:44:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08D79E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 07:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696862614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=obL8b5QO0r5nb46hgjY2kK9LhSik8vXkxCpK9YUEIMo=;
        b=aj6DZli96IvUkLwYfsikMbISYqlxWn9TdtOsp7J3FYJCqxhTb7IJYMeCDPeTGs26DJZDyM
        ZRpA4L9A9a5X8fBtgHnXWTMs1dX8jkAqvoqYmP3aX6arb2ViQhbkhPnsZ+o4Mby9mlWFtt
        IuColxZVnTXQy/RYWOxo/rc6YyYjgP0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-AGH_5lznNASTtDA2hJWE8w-1; Mon, 09 Oct 2023 10:43:33 -0400
X-MC-Unique: AGH_5lznNASTtDA2hJWE8w-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-31f79595669so2429404f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 07:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696862612; x=1697467412;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=obL8b5QO0r5nb46hgjY2kK9LhSik8vXkxCpK9YUEIMo=;
        b=TfOTKgaKc3gw8mHGDQRFoeAxn5x4TUCpMXEHTieRk+w79Ex9AGkxZlm5Pp6gJbLaLH
         gZgpvFVOLpyoDZtd1n+w0B/sMxa4LMhQGPqdxn87W3MZtWH834aj3FWq9gea3ekHO8TM
         9b01LOPQERWf+6v9a0FORGb8F9oIapKMKMqBg4O/enJG2tFq7wMSkK6pPN8dNIBgJy00
         6bQb/z78iKJjyI0UIA9pDjZGH0Ko0s2EBsNce9I99nQWFObWq3pSg4/iCz0QQzTF9No2
         2pLnGyimBRCUAP17mE2Qg+a1yL/hALjo7qtPeIvt9CtXea7cTCdarj4rXPbCnOKbto46
         fbgQ==
X-Gm-Message-State: AOJu0YynUQ0uep1mj0L4/22OFkwA/dUlZD5XKpgiMSEuToyIB9TAkYGA
        V/LHx+Z0l/7QzSGIySNVokSPTFk+ZemXlyMw8xWQTIJwT/TJiR/+Hym//m8zyd4lIMp+a9pSILJ
        Digxgj/wRlMJ00XrvxkM+c9yd
X-Received: by 2002:a5d:6b11:0:b0:323:1d0a:5562 with SMTP id v17-20020a5d6b11000000b003231d0a5562mr9289933wrw.6.1696862611766;
        Mon, 09 Oct 2023 07:43:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeW4IDETa4hchcyUUnR7dHbiPpRDNVVpvGWn/vW/4fF0rfWQohZnx5d8DvvGGiwUmSto6e3A==
X-Received: by 2002:a5d:6b11:0:b0:323:1d0a:5562 with SMTP id v17-20020a5d6b11000000b003231d0a5562mr9289918wrw.6.1696862611315;
        Mon, 09 Oct 2023 07:43:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c733:6400:ae10:4bb7:9712:8548? (p200300cbc7336400ae104bb797128548.dip0.t-ipconnect.de. [2003:cb:c733:6400:ae10:4bb7:9712:8548])
        by smtp.gmail.com with ESMTPSA id g8-20020a5d5408000000b0031c5b380291sm9838763wrv.110.2023.10.09.07.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 07:43:30 -0700 (PDT)
Message-ID: <f1e24131-07b7-c6bf-10ea-8860f055d131@redhat.com>
Date:   Mon, 9 Oct 2023 16:43:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 6/9] mm: thp: Add "recommend" option for anon_orders
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>, Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <20230929114421.3761121-7-ryan.roberts@arm.com>
 <2f64809e-0d0d-cc61-71ac-8d9b072efc3a@redhat.com>
 <CAOUHufb=qurWDFaX2TPQrsmUpEz+VRwm=SxivYuuDiJ4D-f0+g@mail.gmail.com>
 <25d1cdee-3da8-4728-aa0d-dc07eb28ea95@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <25d1cdee-3da8-4728-aa0d-dc07eb28ea95@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.10.23 13:45, Ryan Roberts wrote:
> On 06/10/2023 23:28, Yu Zhao wrote:
>> On Fri, Oct 6, 2023 at 2:08 PM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> On 29.09.23 13:44, Ryan Roberts wrote:
>>>> In addition to passing a bitfield of folio orders to enable for THP,
>>>> allow the string "recommend" to be written, which has the effect of
>>>> causing the system to enable the orders preferred by the architecture
>>>> and by the mm. The user can see what these orders are by subsequently
>>>> reading back the file.
>>>>
>>>> Note that these recommended orders are expected to be static for a given
>>>> boot of the system, and so the keyword "auto" was deliberately not used,
>>>> as I want to reserve it for a possible future use where the "best" order
>>>> is chosen more dynamically at runtime.
>>>>
>>>> Recommended orders are determined as follows:
>>>>     - PMD_ORDER: The traditional THP size
>>>>     - arch_wants_pte_order() if implemented by the arch
>>>>     - PAGE_ALLOC_COSTLY_ORDER: The largest order kept on per-cpu free list
>>>>
>>>> arch_wants_pte_order() can be overridden by the architecture if desired.
>>>> Some architectures (e.g. arm64) can coalsece TLB entries if a contiguous
>>>> set of ptes map physically contigious, naturally aligned memory, so this
>>>> mechanism allows the architecture to optimize as required.
>>>>
>>>> Here we add the default implementation of arch_wants_pte_order(), used
>>>> when the architecture does not define it, which returns -1, implying
>>>> that the HW has no preference.
>>>>
>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> ---
>>>>    Documentation/admin-guide/mm/transhuge.rst |  4 ++++
>>>>    include/linux/pgtable.h                    | 13 +++++++++++++
>>>>    mm/huge_memory.c                           | 14 +++++++++++---
>>>>    3 files changed, 28 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
>>>> index 732c3b2f4ba8..d6363d4efa3a 100644
>>>> --- a/Documentation/admin-guide/mm/transhuge.rst
>>>> +++ b/Documentation/admin-guide/mm/transhuge.rst
>>>> @@ -187,6 +187,10 @@ pages (=16K if the page size is 4K). The example above enables order-9
>>>>    By enabling multiple orders, allocation of each order will be
>>>>    attempted, highest to lowest, until a successful allocation is made.
>>>>    If the PMD-order is unset, then no PMD-sized THPs will be allocated.
>>>> +It is also possible to enable the recommended set of orders, which
>>>> +will be optimized for the architecture and mm::
>>>> +
>>>> +     echo recommend >/sys/kernel/mm/transparent_hugepage/anon_orders
>>>>
>>>>    The kernel will ignore any orders that it does not support so read the
>>>>    file back to determine which orders are enabled::
>>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>>> index af7639c3b0a3..0e110ce57cc3 100644
>>>> --- a/include/linux/pgtable.h
>>>> +++ b/include/linux/pgtable.h
>>>> @@ -393,6 +393,19 @@ static inline void arch_check_zapped_pmd(struct vm_area_struct *vma,
>>>>    }
>>>>    #endif
>>>>
>>>> +#ifndef arch_wants_pte_order
>>>> +/*
>>>> + * Returns preferred folio order for pte-mapped memory. Must be in range [0,
>>>> + * PMD_ORDER) and must not be order-1 since THP requires large folios to be at
>>>> + * least order-2. Negative value implies that the HW has no preference and mm
>>>> + * will choose it's own default order.
>>>> + */
>>>> +static inline int arch_wants_pte_order(void)
>>>> +{
>>>> +     return -1;
>>>> +}
>>>> +#endif
>>>> +
>>>>    #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
>>>>    static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>>>>                                       unsigned long address,
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index bcecce769017..e2e2d3906a21 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -464,10 +464,18 @@ static ssize_t anon_orders_store(struct kobject *kobj,
>>>>        int err;
>>>>        int ret = count;
>>>>        unsigned int orders;
>>>> +     int arch;
>>>>
>>>> -     err = kstrtouint(buf, 0, &orders);
>>>> -     if (err)
>>>> -             ret = -EINVAL;
>>>> +     if (sysfs_streq(buf, "recommend")) {
>>>> +             arch = max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_ORDER);
>>>> +             orders = BIT(arch);
>>>> +             orders |= BIT(PAGE_ALLOC_COSTLY_ORDER);
>>>> +             orders |= BIT(PMD_ORDER);
>>>> +     } else {
>>>> +             err = kstrtouint(buf, 0, &orders);
>>>> +             if (err)
>>>> +                     ret = -EINVAL;
>>>> +     }
>>>>
>>>>        if (ret > 0) {
>>>>                orders &= THP_ORDERS_ALL_ANON;
>>>
>>> :/ don't really like that. Regarding my proposal, one could have
>>> something like that in an "auto" setting for the "enabled" value, or a
>>> "recommended" setting [not sure].
>>
>> Me either.
>>
>> Again this is something I call random --  we only discussed "auto",
>> and yes, the commit message above explained why "recommended" here but
>> it has never surfaced in previous discussions, has it?
> 
> The context in which we discussed "auto" was for a future aspiration to
> automatically determine the order that should be used for a given allocation to
> balance perf vs internal fragmentation.
> 
> The case we are talking about here is completely different; I had a pre-existing
> feature from previous versions of the series, which would allow the arch to
> specify its preferred order (originally proposed by Yu, IIRC). In moving the
> allocation size decision to user space, I felt that we still needed a mechanism
> whereby the arch could express its preference. And "recommend" is what I came up
> with.
> 
> All of the friction we are currently having is around this feature, I think?
> Certainly all the links you provided in the other thread all point to
> conversations skirting around it. How about I just drop it for this initial
> patch set? Just let user space decide what sizes it wants (per David's interface
> proposal)? I can see I'm trying to get a square peg into a round hole.

Dropping it for the initial patch set sounds like a very good idea. 
Telling people what to enable initially when they want to play with it 
will work out just fine.

[Ideally, we plan ahead to have such "auto" settings in the future, as I 
expressed.]

-- 
Cheers,

David / dhildenb

