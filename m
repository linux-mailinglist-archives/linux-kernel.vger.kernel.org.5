Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4872E7566E5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjGQOzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjGQOzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:55:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C3B10C0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689605708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p7ysILThYmwPo2e7W26OOfi15jGsDbCppOEO86p+TmM=;
        b=OYH1wHxtcW3ILRa2V7kE8KeJOKN69eJpTRmMrUHgRbfLV21ePq5wfkOGcxJqNoUVAkDFup
        YrJc5ACbmp7FYQOpUS3q85lxpYO31SWSdFbSMMySGuNmWBJ1d8kxc8QpOvTcr4b0P9/KJK
        KLOMlnR/oqLrHZjFQ9Y0Fo+GoS51gNg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-lRnnD6DgNeW3qEzOhh1TBQ-1; Mon, 17 Jul 2023 10:55:06 -0400
X-MC-Unique: lRnnD6DgNeW3qEzOhh1TBQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fc07d4c2f4so27081845e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689605702; x=1692197702;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p7ysILThYmwPo2e7W26OOfi15jGsDbCppOEO86p+TmM=;
        b=jpeITQxF2dobl9YDinkQlRFI63saa1xqGf/LdIJQMWkY9we1B2MievVf7PcGZiQwcP
         jxqaxW339eKbRbeMIE9Z6Gb+HhXDCarNsOyhVHg1rwGOR+a3UOo561RR1VUir9oJTC9p
         IdVIDuxsxjiZ/9OWOMp8wUj3HXmOGsaoNdEAiJCoV8s+cawrmsHbi16PJAVQV+uF6T4N
         XRVJn3nhe43pe/hDiw04ei4vMk8ieQQpj869y5sBI6rAXP2fshsPDV/Eg5hMjuIMtwIx
         Rf4qoVODu1uv0eH/EWQlmOWbtXDO/80sr7gUfjcRK4R2XnR3EaiuB3EmY3sZ+cecU5tu
         zpKw==
X-Gm-Message-State: ABy/qLaadbiI0ToQ8EOc2yCNv3Yy758NOdVn2TDdNbTidP3eZRGJa+gX
        WCa1kUGqsmhyPC2DtaCERQg6eyibPti78oCwORm+/cxPC1h/HRiBOfSatuSGTbXCJ/jfoP5YJjU
        1Kmt+5Y5NAfVeUzlIfX5h+1rf
X-Received: by 2002:a05:600c:286:b0:3fb:a1d9:ede8 with SMTP id 6-20020a05600c028600b003fba1d9ede8mr10441872wmk.10.1689605702634;
        Mon, 17 Jul 2023 07:55:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGc8KK/Y8awGtA4287mNNnPwJsKgJsu1+GjznfksXzwtT/LrPcTQbk8rkbPxRyWx63N/CBNTw==
X-Received: by 2002:a05:600c:286:b0:3fb:a1d9:ede8 with SMTP id 6-20020a05600c028600b003fba1d9ede8mr10441856wmk.10.1689605702205;
        Mon, 17 Jul 2023 07:55:02 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:400:2501:5a2e:13c6:88da? (p200300cbc735040025015a2e13c688da.dip0.t-ipconnect.de. [2003:cb:c735:400:2501:5a2e:13c6:88da])
        by smtp.gmail.com with ESMTPSA id v3-20020a05600c470300b003f7f475c3bcsm15571413wmo.1.2023.07.17.07.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 07:55:01 -0700 (PDT)
Message-ID: <eae81a83-f8df-3619-612c-b74282da1f0b@redhat.com>
Date:   Mon, 17 Jul 2023 16:55:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 3/4] mm: FLEXIBLE_THP for improved performance
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>, Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230714160407.4142030-1-ryan.roberts@arm.com>
 <20230714161733.4144503-3-ryan.roberts@arm.com>
 <CAOUHufacQ8Vx9WQ3BVjGGWKGhcRkL7u79UMX=O7oePDwZ0iNxw@mail.gmail.com>
 <82c934af-a777-3437-8d87-ff453ad94bfd@redhat.com>
 <2c4b2a41-1c98-0782-ac30-80e65bdb2b0c@arm.com>
 <2e7d5692-8ba7-1e56-a03f-449f1671b100@redhat.com>
 <4f89d7bf-2fe2-fa53-c7ca-e4f152ca0edf@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <4f89d7bf-2fe2-fa53-c7ca-e4f152ca0edf@arm.com>
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

On 17.07.23 16:47, Ryan Roberts wrote:
> On 17/07/2023 14:56, David Hildenbrand wrote:
>> On 17.07.23 15:20, Ryan Roberts wrote:
>>> On 17/07/2023 14:06, David Hildenbrand wrote:
>>>> On 14.07.23 19:17, Yu Zhao wrote:
>>>>> On Fri, Jul 14, 2023 at 10:17 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>>
>>>>>> Introduce FLEXIBLE_THP feature, which allows anonymous memory to be
>>>>>> allocated in large folios of a determined order. All pages of the large
>>>>>> folio are pte-mapped during the same page fault, significantly reducing
>>>>>> the number of page faults. The number of per-page operations (e.g. ref
>>>>>> counting, rmap management lru list management) are also significantly
>>>>>> reduced since those ops now become per-folio.
>>>>>>
>>>>>> The new behaviour is hidden behind the new FLEXIBLE_THP Kconfig, which
>>>>>> defaults to disabled for now; The long term aim is for this to defaut to
>>>>>> enabled, but there are some risks around internal fragmentation that
>>>>>> need to be better understood first.
>>>>>>
>>>>>> When enabled, the folio order is determined as such: For a vma, process
>>>>>> or system that has explicitly disabled THP, we continue to allocate
>>>>>> order-0. THP is most likely disabled to avoid any possible internal
>>>>>> fragmentation so we honour that request.
>>>>>>
>>>>>> Otherwise, the return value of arch_wants_pte_order() is used. For vmas
>>>>>> that have not explicitly opted-in to use transparent hugepages (e.g.
>>>>>> where thp=madvise and the vma does not have MADV_HUGEPAGE), then
>>>>>> arch_wants_pte_order() is limited by the new cmdline parameter,
>>>>>> `flexthp_unhinted_max`. This allows for a performance boost without
>>>>>> requiring any explicit opt-in from the workload while allowing the
>>>>>> sysadmin to tune between performance and internal fragmentation.
>>>>>>
>>>>>> arch_wants_pte_order() can be overridden by the architecture if desired.
>>>>>> Some architectures (e.g. arm64) can coalsece TLB entries if a contiguous
>>>>>> set of ptes map physically contigious, naturally aligned memory, so this
>>>>>> mechanism allows the architecture to optimize as required.
>>>>>>
>>>>>> If the preferred order can't be used (e.g. because the folio would
>>>>>> breach the bounds of the vma, or because ptes in the region are already
>>>>>> mapped) then we fall back to a suitable lower order; first
>>>>>> PAGE_ALLOC_COSTLY_ORDER, then order-0.
>>>>>>
>>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>>> ---
>>>>>>     .../admin-guide/kernel-parameters.txt         |  10 +
>>>>>>     mm/Kconfig                                    |  10 +
>>>>>>     mm/memory.c                                   | 187 ++++++++++++++++--
>>>>>>     3 files changed, 190 insertions(+), 17 deletions(-)
>>>>>>
>>>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt
>>>>>> b/Documentation/admin-guide/kernel-parameters.txt
>>>>>> index a1457995fd41..405d624e2191 100644
>>>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>>>> @@ -1497,6 +1497,16 @@
>>>>>>                            See Documentation/admin-guide/sysctl/net.rst for
>>>>>>                            fb_tunnels_only_for_init_ns
>>>>>>
>>>>>> +       flexthp_unhinted_max=
>>>>>> +                       [KNL] Requires CONFIG_FLEXIBLE_THP enabled. The
>>>>>> maximum
>>>>>> +                       folio size that will be allocated for an anonymous vma
>>>>>> +                       that has neither explicitly opted in nor out of using
>>>>>> +                       transparent hugepages. The size must be a
>>>>>> power-of-2 in
>>>>>> +                       the range [PAGE_SIZE, PMD_SIZE). A larger size
>>>>>> improves
>>>>>> +                       performance by reducing page faults, while a smaller
>>>>>> +                       size reduces internal fragmentation. Default: max(64K,
>>>>>> +                       PAGE_SIZE). Format: size[KMG].
>>>>>> +
>>>>>
>>>>> Let's split this parameter into a separate patch.
>>>>>
>>>>
>>>> Just a general comment after stumbling over patch #2, let's not start splitting
>>>> patches into things that don't make any sense on their own; that just makes
>>>> review a lot harder.
>>>
>>> ACK
>>>
>>>>
>>>> For this case here, I'd suggest first adding the general infrastructure and then
>>>> adding tunables we want to have on top.
>>>
>>> OK, so 1 patch for the main infrastructure, then a patch to disable for
>>> MADV_NOHUGEPAGE and friends, then a further patch to set flexthp_unhinted_max
>>> via a sysctl?
>>
>> MADV_NOHUGEPAGE handling for me falls under the category "required for
>> correctness to not break existing workloads" and has to be there initially.
>>
>> Anything that is rather a performance tunable (e.g., a sysctl to optimize) can
>> be added on top and discussed separately.>
>> At least IMHO :)
>>
>>>
>>>>
>>>> I agree that toggling that at runtime (for example via sysfs as raised by me
>>>> previously) would be nicer.
>>>
>>> OK, I clearly misunderstood, I thought you were requesting a boot parameter.
>>
>> Oh, sorry about that. I wanted to actually express
>> "/sys/kernel/mm/transparent_hugepage/" sysctls where we can toggle that later at
>> runtime as well.
>>
>>> What's the ABI compat guarrantee for sysctls? I assumed that for a boot
>>> parameter it would be easier to remove in future if we wanted, but for sysctl,
>>> its there forever?
>>
>> sysctl are hard/impossible to remove, yes. So we better make sure what we add
>> has clear semantics.
>>
>> If we ever want some real auto-tunable mode (and can actually implement it
>> without harming performance; and I am skeptical), we might want to allow for
>> setting such a parameter to "auto", for example.
>>
>>>
>>> Also, how do you feel about the naming and behavior of the parameter?
>>
>> Very good question. "flexthp_unhinted_max" naming is a bit suboptimal.
>>
>> For example, I'm not so sure if we should expose the feature to user space as
>> "flexthp" at all. I think we should find a clearer feature name to begin with.
>>
>> ... maybe we can initially get away with dropping that parameter and default to
>> something reasonably small (i.e., 64k as you have above)?
> 
> That would certainly get my vote. But it was you who was arguing for a tunable
> previously ;-). I propose we use the following as the "unhinted ceiling" for

Yes, I still think having tunables makes sense.


But it's certainly something to add separately, especially if it makes 
your work here easier.

As long as it can be disabled, good enough for me for the initial version.

-- 
Cheers,

David / dhildenb

