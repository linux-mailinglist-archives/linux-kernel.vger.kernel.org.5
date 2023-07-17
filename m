Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DD47569FB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjGQRRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjGQRRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:17:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEE919F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 10:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689614186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z93VbPii01qcFcqdbTdmXDRfY7mxwnK6BwZz/0iOPoU=;
        b=PieVCPXeAXjcwQzHTJUV+yfCq971cqbF/6Z4h2AatSe9lOSKtTaI+1+RVJxPV2JJTgV6V/
        +uY1fDO1ylNIf15NZI9LnYb4ujoq733MBRHnMgMRJkUj/TJv4WWzLVhbLW7Jb95mR7bATA
        oxgcPzW4f3no+Xjs0nzpY/5sNQp8Y2E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-2c3X7Id5NfC_wMLcaZJj7w-1; Mon, 17 Jul 2023 13:16:23 -0400
X-MC-Unique: 2c3X7Id5NfC_wMLcaZJj7w-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3143b277985so3059059f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 10:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689614182; x=1692206182;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z93VbPii01qcFcqdbTdmXDRfY7mxwnK6BwZz/0iOPoU=;
        b=X9QR+wNYOA2y7+WWoDqmKOth279aBuIVU5NRyOF47bmKQm/VCz9wOG/KBJv0XG5gh6
         d0R3IQBmYAKfSz1vSLeXEleUVo4G8Blwky1xfgqhrqAxJZ9SHa9s3ncopZMySy+wEJwC
         IyY37mrlTh2IKI+Mh5TTeoI2BaeeNvQx8Hzy3IoU6KV4uGnY+Q9TRrnHMT/alTdD0R/x
         enYWq2ZLkwZOyphkzTbSpaonwctyfOwpcgPiQFQDTXf1IXSpAly2zphWoX0oI2xoOZBX
         k7l+37yF4Q51v+0ZLdPDcEuq5p0gTCPxXZTcKVOhFu6JWLiY/EWSC8oudFWQuvHy2D8a
         MBiQ==
X-Gm-Message-State: ABy/qLYsuXTMGyWerbIB2E6vXCEbZyLMcVZ8zVYh0rRhOeKmIGPs7ReV
        x/7P//otVMVMa+QXk5qDTjd7Nm14rQPlgIMJXN/Cvni9x2Bxdku0mmapNbXH502eThy7wepjYFD
        t/1wA63ljMF58otZ1QgybNlWB
X-Received: by 2002:a05:6000:92:b0:314:1b4d:bb27 with SMTP id m18-20020a056000009200b003141b4dbb27mr11078210wrx.64.1689614182463;
        Mon, 17 Jul 2023 10:16:22 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGgNsttIXjLtwzqBtL5GNsyESvEGI1UI0n6w/ifdIVsxGT4NZG8pq+PeofDnr4R2rgRbGqRYw==
X-Received: by 2002:a05:6000:92:b0:314:1b4d:bb27 with SMTP id m18-20020a056000009200b003141b4dbb27mr11078190wrx.64.1689614182092;
        Mon, 17 Jul 2023 10:16:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:400:2501:5a2e:13c6:88da? (p200300cbc735040025015a2e13c688da.dip0.t-ipconnect.de. [2003:cb:c735:400:2501:5a2e:13c6:88da])
        by smtp.gmail.com with ESMTPSA id c3-20020a5d4cc3000000b00311299df211sm19820659wrt.77.2023.07.17.10.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 10:16:21 -0700 (PDT)
Message-ID: <d1dc902f-0323-e7d8-ec0d-b00047404c04@redhat.com>
Date:   Mon, 17 Jul 2023 19:16:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 3/4] mm: FLEXIBLE_THP for improved performance
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
 <CAOUHufYnVdxoKgvxFmk7e0KqtOV9=zWQ-vjVX7JOLNM-cRKR9Q@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAOUHufYnVdxoKgvxFmk7e0KqtOV9=zWQ-vjVX7JOLNM-cRKR9Q@mail.gmail.com>
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

On 17.07.23 19:07, Yu Zhao wrote:
> On Mon, Jul 17, 2023 at 7:06 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 14.07.23 19:17, Yu Zhao wrote:
>>> On Fri, Jul 14, 2023 at 10:17 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>
>>>> Introduce FLEXIBLE_THP feature, which allows anonymous memory to be
>>>> allocated in large folios of a determined order. All pages of the large
>>>> folio are pte-mapped during the same page fault, significantly reducing
>>>> the number of page faults. The number of per-page operations (e.g. ref
>>>> counting, rmap management lru list management) are also significantly
>>>> reduced since those ops now become per-folio.
>>>>
>>>> The new behaviour is hidden behind the new FLEXIBLE_THP Kconfig, which
>>>> defaults to disabled for now; The long term aim is for this to defaut to
>>>> enabled, but there are some risks around internal fragmentation that
>>>> need to be better understood first.
>>>>
>>>> When enabled, the folio order is determined as such: For a vma, process
>>>> or system that has explicitly disabled THP, we continue to allocate
>>>> order-0. THP is most likely disabled to avoid any possible internal
>>>> fragmentation so we honour that request.
>>>>
>>>> Otherwise, the return value of arch_wants_pte_order() is used. For vmas
>>>> that have not explicitly opted-in to use transparent hugepages (e.g.
>>>> where thp=madvise and the vma does not have MADV_HUGEPAGE), then
>>>> arch_wants_pte_order() is limited by the new cmdline parameter,
>>>> `flexthp_unhinted_max`. This allows for a performance boost without
>>>> requiring any explicit opt-in from the workload while allowing the
>>>> sysadmin to tune between performance and internal fragmentation.
>>>>
>>>> arch_wants_pte_order() can be overridden by the architecture if desired.
>>>> Some architectures (e.g. arm64) can coalsece TLB entries if a contiguous
>>>> set of ptes map physically contigious, naturally aligned memory, so this
>>>> mechanism allows the architecture to optimize as required.
>>>>
>>>> If the preferred order can't be used (e.g. because the folio would
>>>> breach the bounds of the vma, or because ptes in the region are already
>>>> mapped) then we fall back to a suitable lower order; first
>>>> PAGE_ALLOC_COSTLY_ORDER, then order-0.
>>>>
>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> ---
>>>>    .../admin-guide/kernel-parameters.txt         |  10 +
>>>>    mm/Kconfig                                    |  10 +
>>>>    mm/memory.c                                   | 187 ++++++++++++++++--
>>>>    3 files changed, 190 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>>> index a1457995fd41..405d624e2191 100644
>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>> @@ -1497,6 +1497,16 @@
>>>>                           See Documentation/admin-guide/sysctl/net.rst for
>>>>                           fb_tunnels_only_for_init_ns
>>>>
>>>> +       flexthp_unhinted_max=
>>>> +                       [KNL] Requires CONFIG_FLEXIBLE_THP enabled. The maximum
>>>> +                       folio size that will be allocated for an anonymous vma
>>>> +                       that has neither explicitly opted in nor out of using
>>>> +                       transparent hugepages. The size must be a power-of-2 in
>>>> +                       the range [PAGE_SIZE, PMD_SIZE). A larger size improves
>>>> +                       performance by reducing page faults, while a smaller
>>>> +                       size reduces internal fragmentation. Default: max(64K,
>>>> +                       PAGE_SIZE). Format: size[KMG].
>>>> +
>>>
>>> Let's split this parameter into a separate patch.
>>>
>>
>> Just a general comment after stumbling over patch #2, let's not start
>> splitting patches into things that don't make any sense on their own;
>> that just makes review a lot harder.
> 
> Sorry to hear this -- but there are also non-subjective reasons we
> split patches this way.
> 
> Initially we had minimum to no common ground, so we had to divide and
> conquer by smallest steps.
> 
> if you look at previous discussions: there was a disagreement on patch
> 2 in v2 -- that's the patch you asked to be squashed into the main
> patch 3. Fortunately we've resolved that. If that disagreement had
> persisted, we would leave patch 2 out rather than let it bog down
> patch 3, which would work indifferently for all arches except arm and
> could be merged separately.

All makes sense to me, and squashing it now is most probably the logical 
step and was different before.

As I said, just a general comment when we talk about splitting stuff out.

-- 
Cheers,

David / dhildenb

