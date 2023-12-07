Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC428086AB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379051AbjLGLZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 06:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379020AbjLGLZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:25:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18722AD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 03:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701948315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=K0j7fBT8MBHy9QWJasxgiKZePtCf0WKdwcLYR8W8mIk=;
        b=QQymiAG+BsoXkeWMFlwOOT0hz32PkES7WMFcmGfRBmjaErS1Yd3/Yv1WjW/tUdQgj5N7zm
        0zmEUcETQJolYE2ZQNvf08/DyjWvDuAJJ8vJK1jI/dxHH1dSjFHBaxgtjCkzlYU7aP9/Cz
        PTG1QhjaYIJIwEwBqCfTGVsTiJ9fOiQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-vKSxhMX3NNuT0cejLRCAjg-1; Thu, 07 Dec 2023 06:25:12 -0500
X-MC-Unique: vKSxhMX3NNuT0cejLRCAjg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33344663fbcso742865f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 03:25:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701948312; x=1702553112;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0j7fBT8MBHy9QWJasxgiKZePtCf0WKdwcLYR8W8mIk=;
        b=g5TZ7dPnU7sjZLOQ2jUN1bLfr23fDFqhBM5+YVvkkgUu9g20i1MHt3VpcDvDE8DWH1
         GOslYu0R3XgbByIfdKM/GdlpXLrUI1If2A+ujOzAHaeGBff2KiGgqsLjSx23rdVsK1e0
         GD7KqNXGYJemgQoLNhfAheFmOcZATFuCqQ2qjmgF97gk3FIfLxfIbhFyGdVioFtzZDF0
         01V3TCfct09VgP1TmhZDsTBSc2lzXf5FMIvFAad80FnBvG2fMWVydakjUui/3OfsKMGi
         iSU2ctgF+2YAm86sAniXSHyTVlOgzir1m0krbCillnIwtHBKtWWRQlzM4B5n5znUU2Lw
         mD0g==
X-Gm-Message-State: AOJu0Yxf6L/GVWQFJrdF8HsNue0DaNI2fkqn6mhfElt8Wr3FLjLNTymo
        mj/XqLya2mqRfWpPZ5XLPK2OS3ZYR8bTIu5yt3bvRHZw7FTO/KbWip8zf9Q55A0SRg+USaZEyIe
        +PwbMZ2xjwr/EKYJLHf9dKe7D
X-Received: by 2002:adf:e5c3:0:b0:333:3c4d:7ff5 with SMTP id a3-20020adfe5c3000000b003333c4d7ff5mr659423wrn.26.1701948311791;
        Thu, 07 Dec 2023 03:25:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmWmk5Vyplt95qyM+itfs1NpTj4L+SVTdY4zz6yKXzsR9YO3s0D7m6mkG211G8K2hy+3azWg==
X-Received: by 2002:adf:e5c3:0:b0:333:3c4d:7ff5 with SMTP id a3-20020adfe5c3000000b003333c4d7ff5mr659409wrn.26.1701948311206;
        Thu, 07 Dec 2023 03:25:11 -0800 (PST)
Received: from ?IPV6:2003:cb:c71b:5d00:18d7:1475:24bc:2417? (p200300cbc71b5d0018d7147524bc2417.dip0.t-ipconnect.de. [2003:cb:c71b:5d00:18d7:1475:24bc:2417])
        by smtp.gmail.com with ESMTPSA id q12-20020a5d658c000000b003333298eb4bsm1186219wru.61.2023.12.07.03.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 03:25:10 -0800 (PST)
Message-ID: <44fdd46b-ad46-4ae2-a20f-20374acdf464@redhat.com>
Date:   Thu, 7 Dec 2023 12:25:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/10] mm: thp: Introduce multi-size THP sysfs
 interface
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
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
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20231204102027.57185-1-ryan.roberts@arm.com>
 <20231204102027.57185-4-ryan.roberts@arm.com>
 <004ed23d-5571-4474-b7fe-7bc08817c165@redhat.com>
 <ca3a2b97-f08e-452a-91dc-1a53dece0aa6@arm.com>
 <378afc6b-f93a-48ad-8aa6-ab171f3b9613@redhat.com>
 <4aa520f0-7c84-4e93-88bf-aee6d8d3ea70@arm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <4aa520f0-7c84-4e93-88bf-aee6d8d3ea70@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 07.12.23 12:22, Ryan Roberts wrote:
> On 07/12/2023 11:13, David Hildenbrand wrote:
>>>>
>>>>> +
>>>>>         if (!vma->vm_mm)        /* vdso */
>>>>> -        return false;
>>>>> +        return 0;
>>>>>           /*
>>>>>          * Explicitly disabled through madvise or prctl, or some
>>>>> @@ -88,16 +141,16 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
>>>>> unsigned long vm_flags,
>>>>>          * */
>>>>>         if ((vm_flags & VM_NOHUGEPAGE) ||
>>>>>             test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
>>>>> -        return false;
>>>>> +        return 0;
>>>>>         /*
>>>>>          * If the hardware/firmware marked hugepage support disabled.
>>>>>          */
>>>>>         if (transparent_hugepage_flags & (1 <<
>>>>> TRANSPARENT_HUGEPAGE_UNSUPPORTED))
>>>>> -        return false;
>>>>> +        return 0;
>>>>>           /* khugepaged doesn't collapse DAX vma, but page fault is fine. */
>>>>>         if (vma_is_dax(vma))
>>>>> -        return in_pf;
>>>>> +        return in_pf ? orders : 0;
>>>>>           /*
>>>>>          * khugepaged special VMA and hugetlb VMA.
>>>>> @@ -105,17 +158,29 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
>>>>> unsigned long vm_flags,
>>>>>          * VM_MIXEDMAP set.
>>>>>          */
>>>>>         if (!in_pf && !smaps && (vm_flags & VM_NO_KHUGEPAGED))
>>>>> -        return false;
>>>>> +        return 0;
>>>>>           /*
>>>>> -     * Check alignment for file vma and size for both file and anon vma.
>>>>> +     * Check alignment for file vma and size for both file and anon vma by
>>>>> +     * filtering out the unsuitable orders.
>>>>>          *
>>>>>          * Skip the check for page fault. Huge fault does the check in fault
>>>>> -     * handlers. And this check is not suitable for huge PUD fault.
>>>>> +     * handlers.
>>>>>          */
>>>>> -    if (!in_pf &&
>>>>> -        !transhuge_vma_suitable(vma, (vma->vm_end - HPAGE_PMD_SIZE)))
>>>>> -        return false;
>>>>> +    if (!in_pf) {
>>>>> +        int order = first_order(orders);
>>>>> +        unsigned long addr;
>>>>> +
>>>>> +        while (orders) {
>>>>> +            addr = vma->vm_end - (PAGE_SIZE << order);
>>>>> +            if (thp_vma_suitable_orders(vma, addr, BIT(order)))
>>>>> +                break;
>>>>
>>>> Comment: you'd want a "thp_vma_suitable_order" helper here. But maybe the
>>>> compiler is smart enough to optimize the loop and everyything else out.
>>>
>>> I'm happy to refactor so that thp_vma_suitable_order() is the basic primitive,
>>> then make thp_vma_suitable_orders() a loop that calls thp_vma_suitable_order()
>>> (that's basically how it is laid out already, just all in one function). Is that
>>> what you are requesting?
>>
>> You got the spirit, yes.
>>
>>>>
>>>> [...]
>>>>
>>>>> +
>>>>> +static ssize_t thpsize_enabled_store(struct kobject *kobj,
>>>>> +                     struct kobj_attribute *attr,
>>>>> +                     const char *buf, size_t count)
>>>>> +{
>>>>> +    int order = to_thpsize(kobj)->order;
>>>>> +    ssize_t ret = count;
>>>>> +
>>>>> +    if (sysfs_streq(buf, "always")) {
>>>>> +        set_bit(order, &huge_anon_orders_always);
>>>>> +        clear_bit(order, &huge_anon_orders_inherit);
>>>>> +        clear_bit(order, &huge_anon_orders_madvise);
>>>>> +    } else if (sysfs_streq(buf, "inherit")) {
>>>>> +        set_bit(order, &huge_anon_orders_inherit);
>>>>> +        clear_bit(order, &huge_anon_orders_always);
>>>>> +        clear_bit(order, &huge_anon_orders_madvise);
>>>>> +    } else if (sysfs_streq(buf, "madvise")) {
>>>>> +        set_bit(order, &huge_anon_orders_madvise);
>>>>> +        clear_bit(order, &huge_anon_orders_always);
>>>>> +        clear_bit(order, &huge_anon_orders_inherit);
>>>>> +    } else if (sysfs_streq(buf, "never")) {
>>>>> +        clear_bit(order, &huge_anon_orders_always);
>>>>> +        clear_bit(order, &huge_anon_orders_inherit);
>>>>> +        clear_bit(order, &huge_anon_orders_madvise);
>>>>
>>>> Note: I was wondering for a second if some concurrent cames could lead to an
>>>> inconsistent state. I think in the worst case we'll simply end up with "never"
>>>> on races.
>>>
>>> You mean if different threads try to write different values to this file
>>> concurrently? Or if there is a concurrent fault that tries to read the flags
>>> while they are being modified?
>>
>> I thought about what you said first, but what you said last might also apply. As
>> long as "nothing breaks", all good.
>>
>>>
>>> I thought about this for a long time too and wasn't sure what was best. The
>>> existing global enabled store impl clears the bits first then sets the bit. With
>>> this approach you can end up with multiple bits set if there is a race to set
>>> diffierent values, and you can end up with a faulting thread seeing never if it
>>> reads the bits after they have been cleared but before setting them.
>>
>> Right, but user space is playing stupid games and can win stupid prices. As long
>> as nothing breaks, we're good.
>>
>>>
>>> I decided to set the new bit before clearing the old bits, which is different; A
>>> racing fault will never see "never" but as you say, a race to set the file could
>>> result in "never" being set.
>>>
>>> On reflection, it's probably best to set the bit *last* like the global control
>>> does?
>>
>> Probably might just slap a simple spinlock in there, so at least the writer side
>> is completely serialized. Then you can just set the bit last. It's unlikely that
>> readers will actually run into issues, and if they ever would, we could use some
>> rcu magic to let them read a consistent state.
> 
> I'd prefer to leave it as it is now; clear first, set last without any explicit
> serialization. I've convinced myself that nothing breaks and its the same
> pattern used by the global control so its consistent. Unless you're insisting on
> the spin lock?

No, not at all. But it would certainly remove any possible concerns :)

-- 
Cheers,

David / dhildenb

