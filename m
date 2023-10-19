Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E747CEFC5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 08:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjJSGBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 02:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjJSGBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 02:01:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3C6171A
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 22:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697695136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OYiNcQwLkcJ0JWlC42a8NTarycDAR71hXESfUG+RdkM=;
        b=d6AoN4cVhnqIFFEq+1tRk5JUrvJURH4OO6VidfywN3QXMq1EK18r+pWxiryP85Ctsx6T4g
        hzST9fdrNjqfDNqSTMMjSBAuCBX20AxV0jpe1cGN4z5qSxWSmPce6TmyuaIXUq5Yjb+OnK
        xqU5IXqWiTnz5AZnVyc4Gl9mnfYgd7U=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-LyaN5KTYPnK05ieYZjio7Q-1; Thu, 19 Oct 2023 01:58:54 -0400
X-MC-Unique: LyaN5KTYPnK05ieYZjio7Q-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-7abacbb76fcso2487311241.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 22:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697695133; x=1698299933;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OYiNcQwLkcJ0JWlC42a8NTarycDAR71hXESfUG+RdkM=;
        b=BqHp+daYd5yFp+yVdK5iRQawWhhhhE2wciqZrSPkJ6hvnT5dnDEAx7MZYPMgKtB32Q
         9Gzagc2CJUnO7FFsATVWxPZUoa+Rbx9w4CyHN25UNeD74oCdZE/hvTIB2e9L34bRHe5a
         QUFYaQRfhoxeB+/mda+rRdJSl8RbasXO+nnE9WM/a85CuMvijDkmJMZ872NeRiEY2+Di
         2GUq1x9xBOKg3aF/x58jFEvWE1dAUSNfqfaz3cJ13x/EZjFUHk0ysk9Qyjn/4C3gKObm
         MIQTOoxuhRapzuYb7cXW65IqCQcH3FXxWbDASlnbeHKjFdXT/SaxkFUMkkCH2/qmgLoR
         Q4gQ==
X-Gm-Message-State: AOJu0YxGXmwJCrHqMzRcamO22cl3hH9K85PCkny9n80r6BCqOft1Y3xt
        LKX4EfFd+P7m3E36AR7CI8NMkRCb0TpB20Wr6Lv3BppTyoE8dg2igoInFhvpUihvAYbvm3TLtGQ
        1eybGWTjM1ARm1WWHooI0oUCI
X-Received: by 2002:a67:ab4f:0:b0:457:adc8:b163 with SMTP id k15-20020a67ab4f000000b00457adc8b163mr1118431vsh.27.1697695133523;
        Wed, 18 Oct 2023 22:58:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiyLmygww0ENS5AhUS3kBqt+gwGtLmYIbLmwqlO+j4nePp4S7H35hIlNeSEhfWNn8yMh+KNg==
X-Received: by 2002:a67:ab4f:0:b0:457:adc8:b163 with SMTP id k15-20020a67ab4f000000b00457adc8b163mr1118421vsh.27.1697695133222;
        Wed, 18 Oct 2023 22:58:53 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15? ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
        by smtp.gmail.com with ESMTPSA id o9-20020a655209000000b005b46e691108sm2226270pgp.68.2023.10.18.22.58.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 22:58:52 -0700 (PDT)
Message-ID: <2ce4b984-b3d6-4c35-96f3-d71d0a7c8ef2@redhat.com>
Date:   Thu, 19 Oct 2023 15:58:47 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: mm: Validate CONFIG_PGTABLE_LEVELS conditionally
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, ryan.roberts@arm.com,
        anshuman.khandual@arm.com, shan.gavin@gmail.com
References: <20231017005300.334140-1-gshan@redhat.com>
 <ZS5qZtcJAjtaKP3X@FVFF77S0Q05N>
 <c383e11e-8067-4350-8a10-ae9c514b222f@redhat.com>
 <ZS-oSirRfxRko9ia@FVFF77S0Q05N>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <ZS-oSirRfxRko9ia@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/23 19:42, Mark Rutland wrote:
> On Wed, Oct 18, 2023 at 04:33:09PM +1000, Gavin Shan wrote:
>> On 10/17/23 21:05, Mark Rutland wrote:
>>> On Tue, Oct 17, 2023 at 10:53:00AM +1000, Gavin Shan wrote:
>>>> It's allowed for the fixmap virtual address space to span multiple
>>>> PMD entries. Instead, the address space isn't allowed to span multiple
>>>> PUD entries. However, PMD entries are folded to PUD and PGD entries
>>>> in the following combination. In this particular case, the validation
>>>> on NR_BM_PMD_TABLES should be avoided.
>>>>
>>>>     CONFIG_ARM64_PAGE_SHIFT = 14
>>>>     CONFIG_ARM64_VA_BITS_36 = y
>>>>     CONFIG_PGTABLE_LEVELS   = 2
>>>
>>> Is this something you found by inspection, or are you hitting a real issue on a
>>> particular config?
>>>
>>> I built a kernel with:
>>>
>>>     defconfig + CONFIG_ARM64_16K_PAGES=y + CONFIG_ARM64_VA_BITS_36=y
>>>
>>> ... which gives the CONFIG_* configuration you list above, and that works just
>>> fine.
>>>
>>> For 2-level 16K pages we'd need to reserve more than 32M of fixmap slots for
>>> the assertion to fire, and we only reserve ~6M of slots in total today, so I
>>> can't see how this would be a problem unless you have 26M+ of local additions
>>> to the fixmap?
>>>
>>> Regardless of that, I don't think it's right to elide the check entirely.
>>>
>>
>> It's all about code inspection. When CONFIG_PGTABLE_LEVELS == 2, PGD/PUD/PMD
>> are equivalent. The following two macros are interchangeable. The forthcoming
>> static_assert() enforces that the fixmap virtual space can't span multiple
>> PMD entries, meaning the space is limited to 32MB with above configuration.
>>
>>    #define NR_BM_PMD_TABLES \
>>            SPAN_NR_ENTRIES(FIXADDR_TOT_START, FIXADDR_TOP, PUD_SHIFT)
>>    #define NR_BM_PMD_TABLES \
>>            SPAN_NR_ENTRIES(FIXADDR_TOT_START, FIXADDR_TOP, PMD_SHIFT)
>>
>>    static_assert(NR_BM_PMD_TABLES == 1);
>>
>> However, multiple PTE tables are allowed. It means the fixmap virtual space
>> can span multiple PMD entries, which is controversial to the above enforcement
>> from the code level. Hopefully, I understood everything correctly.
>>
>>    #define NR_BM_PTE_TABLES \
>>            SPAN_NR_ENTRIES(FIXADDR_TOT_START, FIXADDR_TOP, PMD_SHIFT)
>>    static pte_t bm_pte[NR_BM_PTE_TABLES][PTRS_PER_PTE] __page_aligned_bss;
>>
> 
> The intent is that the fixmap can span multiple PTE tables, but has to fall
> within a single PMD table (and within a single PGD entry). See the next couple
> of lines where we only allocate one PMD table and one PUD table:
> 
>      static pte_t bm_pte[NR_BM_PTE_TABLES][PTRS_PER_PTE] __page_aligned_bss;
>      static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
>      static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
> 
> The NR_BM_PMD_TABLES definition is only there for the static_assert().
> 

Ok, thanks for the hints.

>> You're correct that the following edition is needed to trigger the assert.
>> The point is to have the fixmap virtual space larger than 32MB.
> 
> It's not intended to be more than 32M.
> 
> If we want to support 32M and larger, we'd need to rework the rest of the code,
> allocating more intermediate tables and manipulating multiple PGD entries. As
> we have no need for that, it's simpler to leave it as-is, with the
> static_assert() ther to catch if/when someone tries to expand it beyond what is supported.
> 

Yeah, it's a small space anyway.

>>
>>    enum fixed_addresses {
>>          FIX_HOLE,
>>           :
>>          FIX_PTE,
>>          FIX_PMD,
>>          FIX_PUD,
>>          FIX_PGD,
>>          FIX_DUMMY = FIX_PGD + 2048,
>>
>>          __end_of_fixed_addresses
>> };
>>
>>
>>> The point of the check is to make sure that the fixmap VA range doesn't span
>>> across multiple PMD/PUD/P4D/PGD entries, as the early_fixmap_init() and
>>> fixmap_copy() code don't handle that in general. When using 2-level 16K pages,
>>> we still want to ensure the fixmap is contained within a single PGD, and
>>> checking that it falls within a single folded PMD will check that.
>>>
>>> See the message for commit:
>>>
>>>     414c109bdf496195 ("arm64: mm: always map fixmap at page granularity")
>>>
>>> ... and the bits that deleted from early_fixmap_init().
>>>
>>> AFAICT this is fine as-is.
>>>
>>
>> As I can see, multiple PMD entries can be handled well in early_fixmap_init().
>> However, multiple PMD entries aren't handled in fixmap_copy(), as you said.
>>
>>    early_fixmap_init
>>      early_fixmap_init_pud
>>        early_fixmap_init_pmd       // multiple PMD entries handled in the loop
> 
> If you remove the restriction of a single PMD entry, you also permit multiple
> PUD/P4D/PGD entries, and the early_fixmap_init() code cannot handle that.
> Consider how early_fixmap_init_pud() and early_fixmap_init_pmd() use bm_pud and
> bm_pmd respectively.
> 
> As above, this code doesn't need to change:
> 
> * It works today, there is no configuration where the statis_assert() fires
>    spuriously.
> 
> * If the static_assert() were to fire, we'd need to alter some portion of the
>    code to handle that case (e.g. expanding bm_pmd and/or bm_pud, altering
>    fixmap_copy()).
> 
> * It's simpler and better to have the assertion today rather than making the
>    code handle the currently-impossible cases. That avoids wasting memory on
>    unusable tables, and avoids having code which is never tested.
> 

Agree. Please ignore my patch and lets keep it as-is. Again, it's a small space
and I don't see it needs to be enlarged to hit the limit. Thanks for explaining
everything in a clear way.

Thanks,
Gavin

