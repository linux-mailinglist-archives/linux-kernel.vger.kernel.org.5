Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B79770B01
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjHDVby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 17:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjHDVbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:31:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA04110
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 14:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691184654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6xHzxUYjJIdDtURU1S3vX2xZDjMKXI19w61gLbe1Ayo=;
        b=Kei97qZgDtfO8mXMJqpdmXDg1iW54RmC0o25tzkl6VPhMo3nudupCEfPOridZCKiHKuMn4
        F1jd9boqbXOmk3X68/Nx98X94bJDJOoAxv2RQ4BeINVtvk3YcvWJ3duyXgYlgO791BKBQs
        +Qy1ykjJdrTsrTStf2LiQEHkMbczLHA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-5qQanNeXO7O9RfWtkcHLbw-1; Fri, 04 Aug 2023 17:30:53 -0400
X-MC-Unique: 5qQanNeXO7O9RfWtkcHLbw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fe210c47acso14852865e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 14:30:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691184652; x=1691789452;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6xHzxUYjJIdDtURU1S3vX2xZDjMKXI19w61gLbe1Ayo=;
        b=gRKDlOb30ypw2gCSb8tSF+/En7IuC5uDDL2390/2hjeSGBj2f/FxsSSS0AeKG6U3OR
         3aUwHQSsmb1YSE/lT2xq5f1mquhsg/5kX9EfuqhcIHNnIsW+5UfXTq4X2LGr1f59/cbo
         6EMsT+gGphR5p48RE0ZQ3qXHD08RY7irJo+T9U99tGmceOtnl+ITSUtzRmvH3H/bqu37
         +2nfHSsuPkjORIXlcT1rdGxzeJFI8xIJ4uY8Kyy6tsqFN6kd75+P3rRG60TO/WT8W076
         Isgy53kWnzojz/Qmk1n7B2w5oNkGBF+/4bAtUCMVgQmDpMiVatR0lNAB/1pnLcWyMBdk
         vqyw==
X-Gm-Message-State: AOJu0Yzt5iroqLgNyw8GPJV6ytNbMlAqgeSDDF22tsyXhIaMEtUeeskJ
        Uve9heQCuXFHleyYuU8rJmvVFluVZxD9MW5ovOJRvoZx2z+ZOmlB/qq/P/ET9M3XN3SA9TAq6wv
        lSDqstUxhxD4LHSW5TFwMkYR5
X-Received: by 2002:a7b:ce94:0:b0:3f8:2777:15e with SMTP id q20-20020a7bce94000000b003f82777015emr2164962wmj.31.1691184652193;
        Fri, 04 Aug 2023 14:30:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHg76fpCPdISu/CKKhttE0AnUkU9rMMWiHgz3qJGhEnE09KvQCL77IQ1NcO4miQKPYK6bEQ/A==
X-Received: by 2002:a7b:ce94:0:b0:3f8:2777:15e with SMTP id q20-20020a7bce94000000b003f82777015emr2164947wmj.31.1691184651768;
        Fri, 04 Aug 2023 14:30:51 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2d:8e00:a20e:59bc:3c13:4806? (p200300d82f2d8e00a20e59bc3c134806.dip0.t-ipconnect.de. [2003:d8:2f2d:8e00:a20e:59bc:3c13:4806])
        by smtp.gmail.com with ESMTPSA id 25-20020a05600c021900b003fe4ca8decdsm1425819wmi.31.2023.08.04.14.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 14:30:51 -0700 (PDT)
Message-ID: <0d502268-ebdc-8462-d88c-e6a41578d9ae@redhat.com>
Date:   Fri, 4 Aug 2023 23:30:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 2/5] mm: LARGE_ANON_FOLIO for improved performance
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230726095146.2826796-1-ryan.roberts@arm.com>
 <20230726095146.2826796-3-ryan.roberts@arm.com>
 <c02a95e9-b728-ad64-6942-f23dbd66af0c@arm.com>
 <CAOUHufaHH3Ctu3JRHSbmebHJ7XPnBEWTQ4mwOo+MGXU9yKvwbA@mail.gmail.com>
 <5e595904-3dca-0e15-0769-7ed10975fd0d@arm.com>
 <b936041c-08a7-e844-19e7-eafc4ddf63b9@redhat.com>
 <CAOUHufafd4GNna2GKdSyQdW6CLVh0gxhNgeOc6t+ZOphwgw7tw@mail.gmail.com>
 <259ad8fc-c12b-69b9-ba16-adb9e3e6d672@redhat.com>
 <CAOUHufbbrDrSv2Ak0tyyaw7qrekkQ-p2vjCqWsXFG7b-+EP=5g@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAOUHufbbrDrSv2Ak0tyyaw7qrekkQ-p2vjCqWsXFG7b-+EP=5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.08.23 23:26, Yu Zhao wrote:
> On Fri, Aug 4, 2023 at 3:13 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 04.08.23 23:00, Yu Zhao wrote:
>>> On Fri, Aug 4, 2023 at 2:23 PM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 04.08.23 10:27, Ryan Roberts wrote:
>>>>> On 04/08/2023 00:50, Yu Zhao wrote:
>>>>>> On Thu, Aug 3, 2023 at 6:43 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>>>
>>>>>>> + Kirill
>>>>>>>
>>>>>>> On 26/07/2023 10:51, Ryan Roberts wrote:
>>>>>>>> Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory to be
>>>>>>>> allocated in large folios of a determined order. All pages of the large
>>>>>>>> folio are pte-mapped during the same page fault, significantly reducing
>>>>>>>> the number of page faults. The number of per-page operations (e.g. ref
>>>>>>>> counting, rmap management lru list management) are also significantly
>>>>>>>> reduced since those ops now become per-folio.
>>>>>>>>
>>>>>>>> The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfig,
>>>>>>>> which defaults to disabled for now; The long term aim is for this to
>>>>>>>> defaut to enabled, but there are some risks around internal
>>>>>>>> fragmentation that need to be better understood first.
>>>>>>>>
>>>>>>>> When enabled, the folio order is determined as such: For a vma, process
>>>>>>>> or system that has explicitly disabled THP, we continue to allocate
>>>>>>>> order-0. THP is most likely disabled to avoid any possible internal
>>>>>>>> fragmentation so we honour that request.
>>>>>>>>
>>>>>>>> Otherwise, the return value of arch_wants_pte_order() is used. For vmas
>>>>>>>> that have not explicitly opted-in to use transparent hugepages (e.g.
>>>>>>>> where thp=madvise and the vma does not have MADV_HUGEPAGE), then
>>>>>>>> arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whichever is
>>>>>>>> bigger). This allows for a performance boost without requiring any
>>>>>>>> explicit opt-in from the workload while limitting internal
>>>>>>>> fragmentation.
>>>>>>>>
>>>>>>>> If the preferred order can't be used (e.g. because the folio would
>>>>>>>> breach the bounds of the vma, or because ptes in the region are already
>>>>>>>> mapped) then we fall back to a suitable lower order; first
>>>>>>>> PAGE_ALLOC_COSTLY_ORDER, then order-0.
>>>>>>>>
>>>>>>>
>>>>>>> ...
>>>>>>>
>>>>>>>> +#define ANON_FOLIO_MAX_ORDER_UNHINTED \
>>>>>>>> +             (ilog2(max_t(unsigned long, SZ_64K, PAGE_SIZE)) - PAGE_SHIFT)
>>>>>>>> +
>>>>>>>> +static int anon_folio_order(struct vm_area_struct *vma)
>>>>>>>> +{
>>>>>>>> +     int order;
>>>>>>>> +
>>>>>>>> +     /*
>>>>>>>> +      * If THP is explicitly disabled for either the vma, the process or the
>>>>>>>> +      * system, then this is very likely intended to limit internal
>>>>>>>> +      * fragmentation; in this case, don't attempt to allocate a large
>>>>>>>> +      * anonymous folio.
>>>>>>>> +      *
>>>>>>>> +      * Else, if the vma is eligible for thp, allocate a large folio of the
>>>>>>>> +      * size preferred by the arch. Or if the arch requested a very small
>>>>>>>> +      * size or didn't request a size, then use PAGE_ALLOC_COSTLY_ORDER,
>>>>>>>> +      * which still meets the arch's requirements but means we still take
>>>>>>>> +      * advantage of SW optimizations (e.g. fewer page faults).
>>>>>>>> +      *
>>>>>>>> +      * Finally if thp is enabled but the vma isn't eligible, take the
>>>>>>>> +      * arch-preferred size and limit it to ANON_FOLIO_MAX_ORDER_UNHINTED.
>>>>>>>> +      * This ensures workloads that have not explicitly opted-in take benefit
>>>>>>>> +      * while capping the potential for internal fragmentation.
>>>>>>>> +      */
>>>>>>>> +
>>>>>>>> +     if ((vma->vm_flags & VM_NOHUGEPAGE) ||
>>>>>>>> +         test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags) ||
>>>>>>>> +         !hugepage_flags_enabled())
>>>>>>>> +             order = 0;
>>>>>>>> +     else {
>>>>>>>> +             order = max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_ORDER);
>>>>>>>> +
>>>>>>>> +             if (!hugepage_vma_check(vma, vma->vm_flags, false, true, true))
>>>>>>>> +                     order = min(order, ANON_FOLIO_MAX_ORDER_UNHINTED);
>>>>>>>> +     }
>>>>>>>> +
>>>>>>>> +     return order;
>>>>>>>> +}
>>>>>>>
>>>>>>>
>>>>>>> Hi All,
>>>>>>>
>>>>>>> I'm writing up the conclusions that we arrived at during discussion in the THP
>>>>>>> meeting yesterday, regarding linkage with exiting THP ABIs. It would be great if
>>>>>>> I can get explicit "agree" or disagree + rationale from at least David, Yu and
>>>>>>> Kirill.
>>>>>>>
>>>>>>> In summary; I think we are converging on the approach that is already coded, but
>>>>>>> I'd like confirmation.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> The THP situation today
>>>>>>> -----------------------
>>>>>>>
>>>>>>>     - At system level: THP can be set to "never", "madvise" or "always"
>>>>>>>     - At process level: THP can be "never" or "defer to system setting"
>>>>>>>     - At VMA level: no-hint, MADV_HUGEPAGE, MADV_NOHUGEPAGE
>>>>>>>
>>>>>>> That gives us this table to describe how a page fault is handled, according to
>>>>>>> process state (columns) and vma flags (rows):
>>>>>>>
>>>>>>>                    | never     | madvise   | always
>>>>>>> ----------------|-----------|-----------|-----------
>>>>>>> no hint         | S         | S         | THP>S
>>>>>>> MADV_HUGEPAGE   | S         | THP>S     | THP>S
>>>>>>> MADV_NOHUGEPAGE | S         | S         | S
>>>>>>>
>>>>>>> Legend:
>>>>>>> S       allocate single page (PTE-mapped)
>>>>>>> LAF     allocate lage anon folio (PTE-mapped)
>>>>>>> THP     allocate THP-sized folio (PMD-mapped)
>>>>>>>>          fallback (usually because vma size/alignment insufficient for folio)
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Principles for Large Anon Folios (LAF)
>>>>>>> --------------------------------------
>>>>>>>
>>>>>>> David tells us there are use cases today (e.g. qemu live migration) which use
>>>>>>> MADV_NOHUGEPAGE to mean "don't fill any PTEs that are not explicitly faulted"
>>>>>>> and these use cases will break (i.e. functionally incorrect) if this request is
>>>>>>> not honoured.
>>>>>>
>>>>>> I don't remember David saying this. I think he was referring to UFFD,
>>>>>> not MADV_NOHUGEPAGE, when discussing what we need to absolutely
>>>>>> respect.
>>>>>
>>>>> My understanding was that MADV_NOHUGEPAGE was being applied to regions *before*
>>>>> UFFD was being registered, and the app relied on MADV_NOHUGEPAGE to not back any
>>>>> unfaulted pages. It's not completely clear to me how not honouring
>>>>> MADV_NOHUGEPAGE would break things though. David?
>>>>
>>>> Sorry, I'm still lagging behind on some threads.
>>>>
>>>> Imagine the following for VM postcopy live migration:
>>>>
>>>> (1) Set MADV_NOHUGEPAGE on guest memory and discard all memory (e.g.,
>>>>        MADV_DONTNEED), to start with a clean slate.
>>>> (2) Migrates some pages during precopy from the source and stores them
>>>>        into guest memory on the destination. Some of the memory locations
>>>>        will have pages populated.
>>>> (3) At some point, decide to enable postcopy: enable userfaultfd on
>>>>        guest memory.
>>>> (4) Discard *selected* pages again that have been dirtied in the
>>>>        meantime on the source. These are pages that have been migrated
>>>>        previously.
>>>> (5) Start running the VM on the destination.
>>>> (6) Anything that's not populated will trigger userfaultfd missing
>>>>        faults. Then, you can request them from the source and place them.
>>>>
>>>> Assume you would populate more than required during 2), you can end up
>>>> not getting userfaultfd faults during 4) and corrupt your guest state.
>>>> It works if during (2) you migrated all guest memory, or if during 4)
>>>> you zap everything that still needs migr
>>>
>>> I see what you mean now. Thanks.
>>>
>>> Yes, in this case we have to interpret MADV_NOHUGEPAGE as nothing >4KB.
>>
>> Note that it's still even unclear to me why we want to *not* call these
>> things THP. It would certainly make everything less confusing if we call
>> them THP, but with additional attributes.
>>
>> I think that is one of the first things we should figure out because it
>> also indirectly tells us what all these toggles mean and how/if we
>> should redefine them (and if they even apply).
>>
>> Currently THP == PMD size
>>
>> In 2016, Hugh already envisioned PUD/PGD THP (see 49920d28781d ("mm:
>> make transparent hugepage size public")) when he explicitly exposed
>> "hpage_pmd_size". Not "hpage_size".
>>
>> For hugetlb on arm64 we already support various sizes that are < PMD
>> size and *not* call them differently. It's a huge(tlb) page. Sometimes
>> we refer to them as cont-PTE hugetlb pages.
>>
>>
>> So, nowadays we do have "PMD-sized THP", someday we might have
>> "PUD-sized THP". Can't we come up with a name to describe sub-PMD THP?
>>
>> Is it really of value if we invent a new term for them? Yes, I was not
>> enjoying "Flexible THP".
>>
>>
>> Once we figured that out, we should figure out if MADV_HUGEPAGE meant
>> "only PMD-sized THP" or anything else?
>>
>> Also, we can then figure out if MADV_NOHUGEPAGE meant "only PMD-sized
>> THP" or anything else?
>>
>>
>> The simplest approach to me would be "they imply any THP, and once we
>> need more tunables we might add some", similar to what Kirill also raised.
>>
>>
>> Again, it's all unclear to me at this point and I'm happy to hear
>> opinions, because I really don't know.
> 
> I agree these points require more discussion. But I don't think we
> need to conclude them now, unless they cause correctness issues like
> ignoring MADV_NOHUGEPAGE would. My concern is that if we decide to go
> with "they imply any THP" and *expose this to userspace now*, we might
> regret later.

If we don't think they are THP, probably MADV_NOHUGEPAGE should not 
apply and we should be ready to find other ways to deal with the mess we 
eventually create. If we want to go down that path, sure.

If they are THP, to me there is not really a question if MADV_NOHUGEPAGE 
applies to them or not. Unless we want to build a confusing piece of 
software ;)

-- 
Cheers,

David / dhildenb

