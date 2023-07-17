Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8517F75659E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjGQN5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjGQN5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:57:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74ABDD1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689602215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GsphTJYgogdZknx5waKvWjKpqYHQdCeCkx39zseZOjQ=;
        b=YCzZD/62L7f2GWj3S1gVAZA6D4mBioXJWXFyfp235nrPpb8h++MgOBmeeXU2qJFvY0bYkW
        SEVbzXydswP2I3B6EXHUxV6zeoIKWn8gokVp7YSTc97pUJDLThvVDSCMWPN+tuSPx8+X18
        /Espv+Rj2FCdfouXqETnYEtUuYVa8xg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-hzXB8EByNmW0QqfNRo1wtw-1; Mon, 17 Jul 2023 09:56:53 -0400
X-MC-Unique: hzXB8EByNmW0QqfNRo1wtw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fc0094c1bdso28332965e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:56:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689602212; x=1692194212;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GsphTJYgogdZknx5waKvWjKpqYHQdCeCkx39zseZOjQ=;
        b=Qmpew9TSo6ZTGUFz8Mcuv2D6SBAUg2kKeiHKB2tQDJzelQx8Z9rzC+HLpeagHvUmFC
         mEHO80AFb7EHJdaIktLgjS4dmKVt7l0ifiWhFknB4xBy4AdGbhufESj9aXsK2K1sz9Ur
         UgriaY0AxHSJ6XVxg3o/CUxik9ogc4UfqCVLypND4T3ecOVIO8Ky1YtGDuejyWpSSJ0C
         ordOkx+vR4YkyCIYffUVncg1ov2P/lI0SQSVYP9kl4SEXFCVFhZMtRT2+wJxWEFkKj/T
         iSNLcdZnQJryZbZxarGSpMlfDfx2d55x4WOCgAsQVKYpIbBmpLTGqzOQUYBJW5sOpT2j
         3Asw==
X-Gm-Message-State: ABy/qLZn9j4C82FwRNP7LiEyQrDN3xjimkN+A+wgBCLCgZmS+jx/nkl4
        tVxIXrvAo+u4nwi64bPeKAZH9BQTFYbcsE+GUVeAZmdpYy1BfJHIaaQLjCaXjafpJsrnGdd64Xr
        nMJ3oQvi6PRg6poqDncLgadIy
X-Received: by 2002:a7b:c4c7:0:b0:3fb:40ff:1cba with SMTP id g7-20020a7bc4c7000000b003fb40ff1cbamr10087302wmk.6.1689602212210;
        Mon, 17 Jul 2023 06:56:52 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGR00c8fYjZJK7OqlcVNMfa3sJanSFFtaKVXGrRbtAQl7p9wWGRMrFWUR1qBk9j7m/yMWfr1g==
X-Received: by 2002:a7b:c4c7:0:b0:3fb:40ff:1cba with SMTP id g7-20020a7bc4c7000000b003fb40ff1cbamr10087267wmk.6.1689602211769;
        Mon, 17 Jul 2023 06:56:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:400:2501:5a2e:13c6:88da? (p200300cbc735040025015a2e13c688da.dip0.t-ipconnect.de. [2003:cb:c735:400:2501:5a2e:13c6:88da])
        by smtp.gmail.com with ESMTPSA id t15-20020a1c770f000000b003fb40f5f553sm8112540wmi.31.2023.07.17.06.56.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 06:56:51 -0700 (PDT)
Message-ID: <2e7d5692-8ba7-1e56-a03f-449f1671b100@redhat.com>
Date:   Mon, 17 Jul 2023 15:56:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 3/4] mm: FLEXIBLE_THP for improved performance
In-Reply-To: <2c4b2a41-1c98-0782-ac30-80e65bdb2b0c@arm.com>
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

On 17.07.23 15:20, Ryan Roberts wrote:
> On 17/07/2023 14:06, David Hildenbrand wrote:
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
>>>>    .../admin-guide/kernel-parameters.txt         |  10 +
>>>>    mm/Kconfig                                    |  10 +
>>>>    mm/memory.c                                   | 187 ++++++++++++++++--
>>>>    3 files changed, 190 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt
>>>> b/Documentation/admin-guide/kernel-parameters.txt
>>>> index a1457995fd41..405d624e2191 100644
>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>> @@ -1497,6 +1497,16 @@
>>>>                           See Documentation/admin-guide/sysctl/net.rst for
>>>>                           fb_tunnels_only_for_init_ns
>>>>
>>>> +       flexthp_unhinted_max=
>>>> +                       [KNL] Requires CONFIG_FLEXIBLE_THP enabled. The maximum
>>>> +                       folio size that will be allocated for an anonymous vma
>>>> +                       that has neither explicitly opted in nor out of using
>>>> +                       transparent hugepages. The size must be a power-of-2 in
>>>> +                       the range [PAGE_SIZE, PMD_SIZE). A larger size improves
>>>> +                       performance by reducing page faults, while a smaller
>>>> +                       size reduces internal fragmentation. Default: max(64K,
>>>> +                       PAGE_SIZE). Format: size[KMG].
>>>> +
>>>
>>> Let's split this parameter into a separate patch.
>>>
>>
>> Just a general comment after stumbling over patch #2, let's not start splitting
>> patches into things that don't make any sense on their own; that just makes
>> review a lot harder.
> 
> ACK
> 
>>
>> For this case here, I'd suggest first adding the general infrastructure and then
>> adding tunables we want to have on top.
> 
> OK, so 1 patch for the main infrastructure, then a patch to disable for
> MADV_NOHUGEPAGE and friends, then a further patch to set flexthp_unhinted_max
> via a sysctl?

MADV_NOHUGEPAGE handling for me falls under the category "required for 
correctness to not break existing workloads" and has to be there initially.

Anything that is rather a performance tunable (e.g., a sysctl to 
optimize) can be added on top and discussed separately.

At least IMHO :)

> 
>>
>> I agree that toggling that at runtime (for example via sysfs as raised by me
>> previously) would be nicer.
> 
> OK, I clearly misunderstood, I thought you were requesting a boot parameter.

Oh, sorry about that. I wanted to actually express 
"/sys/kernel/mm/transparent_hugepage/" sysctls where we can toggle that 
later at runtime as well.

> What's the ABI compat guarrantee for sysctls? I assumed that for a boot
> parameter it would be easier to remove in future if we wanted, but for sysctl,
> its there forever?

sysctl are hard/impossible to remove, yes. So we better make sure what 
we add has clear semantics.

If we ever want some real auto-tunable mode (and can actually implement 
it without harming performance; and I am skeptical), we might want to 
allow for setting such a parameter to "auto", for example.

> 
> Also, how do you feel about the naming and behavior of the parameter?

Very good question. "flexthp_unhinted_max" naming is a bit suboptimal.

For example, I'm not so sure if we should expose the feature to user 
space as "flexthp" at all. I think we should find a clearer feature name 
to begin with.

... maybe we can initially get away with dropping that parameter and 
default to something reasonably small (i.e., 64k as you have above)?

/sys/kernel/mm/transparent_hugepage/enabled=never and simply not get any 
thp.

-- 
Cheers,

David / dhildenb

