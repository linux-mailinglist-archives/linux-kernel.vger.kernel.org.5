Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F266D7CD484
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 08:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344479AbjJRGeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 02:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjJRGeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 02:34:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD345B6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697610808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jZOwWocZpg3TtYCc3lshMN/KmY8LsIsl3wk4sUFMQX0=;
        b=MzQRY1AqX5KS9ws+bA3qG+Ni8vAbiRZzUQrFYx45fl+edZLfNWOeOf10ZtN7udvC1f6/PP
        inQUBB9Is58MwJTLTN+gz6SSYdM54xRHs/xo27vLlsBHY06PZH8DlsJ7gT5GbLLbMM4dvp
        GDIs321FEU7WkLcgKuq0runJi/iZwEI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-h8FWrNGxOD-3og0wONe7fA-1; Wed, 18 Oct 2023 02:33:16 -0400
X-MC-Unique: h8FWrNGxOD-3og0wONe7fA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2775477ddbeso4556023a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:33:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697610795; x=1698215595;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jZOwWocZpg3TtYCc3lshMN/KmY8LsIsl3wk4sUFMQX0=;
        b=kzDOraUMlU/OB6fIyNn2GUYK7BedLuzpNHzQTULYtlTvpHXKAtqndxgWcpkzVhZHVK
         2b8utUnIEs7FURUzVZb9JoXuyIwLgC6MNZ/pfgjscHdU35x319xcK1Z0Lp0gwOeWp7zg
         w4rXPJJHFWgxxkjmPeeidssEc9I9bCY3R/JX0+OVVlEkkQRP/mZFn+SOa8Chp36RYnAt
         ImUIZdzGdVqkx47wkBTSO8ICrP7OVFLS1XxmHwcwSd0kMrEbc2CD+7Nt6WZWaDUlYpaw
         XKkFUzeNNO2Q5U4DvCX/pgPK9yVaiE5OI1SkroBljvOx+joQPizd9v0aiG1wRrVh5sIf
         TJ2w==
X-Gm-Message-State: AOJu0YymZveOeUi4cMUGlmMRNxcsukKCI33LpSis23PXzqbrKPFHfIXa
        BhUfrl1/k4FYeQHspqgLQrDLO39iWMk/W3ifH8XBp+WVmUbncOq0qyVqvg4HiqFWmzhM2Sdbe2W
        uwpA2tHxnXIsvc6l9Wd/ZGiBN
X-Received: by 2002:a17:90a:8a10:b0:27d:5946:5e2c with SMTP id w16-20020a17090a8a1000b0027d59465e2cmr4206113pjn.12.1697610795655;
        Tue, 17 Oct 2023 23:33:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWw4ftwVv6uW+EbPep50kB3uu7hdWqZ6N/43BWsuCBDIhlQAgYu8K5L/FuQYhclRZUt09c0g==
X-Received: by 2002:a17:90a:8a10:b0:27d:5946:5e2c with SMTP id w16-20020a17090a8a1000b0027d59465e2cmr4206100pjn.12.1697610795272;
        Tue, 17 Oct 2023 23:33:15 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15? ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a018500b0027782f611d1sm627549pjc.36.2023.10.17.23.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 23:33:14 -0700 (PDT)
Message-ID: <c383e11e-8067-4350-8a10-ae9c514b222f@redhat.com>
Date:   Wed, 18 Oct 2023 16:33:09 +1000
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
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <ZS5qZtcJAjtaKP3X@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 10/17/23 21:05, Mark Rutland wrote:
> On Tue, Oct 17, 2023 at 10:53:00AM +1000, Gavin Shan wrote:
>> It's allowed for the fixmap virtual address space to span multiple
>> PMD entries. Instead, the address space isn't allowed to span multiple
>> PUD entries. However, PMD entries are folded to PUD and PGD entries
>> in the following combination. In this particular case, the validation
>> on NR_BM_PMD_TABLES should be avoided.
>>
>>    CONFIG_ARM64_PAGE_SHIFT = 14
>>    CONFIG_ARM64_VA_BITS_36 = y
>>    CONFIG_PGTABLE_LEVELS   = 2
> 
> Is this something you found by inspection, or are you hitting a real issue on a
> particular config?
> 
> I built a kernel with:
> 
>    defconfig + CONFIG_ARM64_16K_PAGES=y + CONFIG_ARM64_VA_BITS_36=y
> 
> ... which gives the CONFIG_* configuration you list above, and that works just
> fine.
> 
> For 2-level 16K pages we'd need to reserve more than 32M of fixmap slots for
> the assertion to fire, and we only reserve ~6M of slots in total today, so I
> can't see how this would be a problem unless you have 26M+ of local additions
> to the fixmap?
> 
> Regardless of that, I don't think it's right to elide the check entirely.
> 

It's all about code inspection. When CONFIG_PGTABLE_LEVELS == 2, PGD/PUD/PMD
are equivalent. The following two macros are interchangeable. The forthcoming
static_assert() enforces that the fixmap virtual space can't span multiple
PMD entries, meaning the space is limited to 32MB with above configuration.

   #define NR_BM_PMD_TABLES \
           SPAN_NR_ENTRIES(FIXADDR_TOT_START, FIXADDR_TOP, PUD_SHIFT)
   #define NR_BM_PMD_TABLES \
           SPAN_NR_ENTRIES(FIXADDR_TOT_START, FIXADDR_TOP, PMD_SHIFT)

   static_assert(NR_BM_PMD_TABLES == 1);

However, multiple PTE tables are allowed. It means the fixmap virtual space
can span multiple PMD entries, which is controversial to the above enforcement
from the code level. Hopefully, I understood everything correctly.

   #define NR_BM_PTE_TABLES \
           SPAN_NR_ENTRIES(FIXADDR_TOT_START, FIXADDR_TOP, PMD_SHIFT)
   static pte_t bm_pte[NR_BM_PTE_TABLES][PTRS_PER_PTE] __page_aligned_bss;


You're correct that the following edition is needed to trigger the assert.
The point is to have the fixmap virtual space larger than 32MB.

   enum fixed_addresses {
         FIX_HOLE,
          :
         FIX_PTE,
         FIX_PMD,
         FIX_PUD,
         FIX_PGD,
         
         FIX_DUMMY = FIX_PGD + 2048,

         __end_of_fixed_addresses
};


> The point of the check is to make sure that the fixmap VA range doesn't span
> across multiple PMD/PUD/P4D/PGD entries, as the early_fixmap_init() and
> fixmap_copy() code don't handle that in general. When using 2-level 16K pages,
> we still want to ensure the fixmap is contained within a single PGD, and
> checking that it falls within a single folded PMD will check that.
> 
> See the message for commit:
> 
>    414c109bdf496195 ("arm64: mm: always map fixmap at page granularity")
> 
> ... and the bits that deleted from early_fixmap_init().
> 
> AFAICT this is fine as-is.
> 

As I can see, multiple PMD entries can be handled well in early_fixmap_init().
However, multiple PMD entries aren't handled in fixmap_copy(), as you said.

   early_fixmap_init
     early_fixmap_init_pud
       early_fixmap_init_pmd       // multiple PMD entries handled in the loop

Thanks,
Gavin

>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/mm/fixmap.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
>> index c0a3301203bd..5384e5c3aeaa 100644
>> --- a/arch/arm64/mm/fixmap.c
>> +++ b/arch/arm64/mm/fixmap.c
>> @@ -18,10 +18,11 @@
>>   
>>   #define NR_BM_PTE_TABLES \
>>   	SPAN_NR_ENTRIES(FIXADDR_TOT_START, FIXADDR_TOP, PMD_SHIFT)
>> +#if CONFIG_PGTABLE_LEVELS > 2
>>   #define NR_BM_PMD_TABLES \
>>   	SPAN_NR_ENTRIES(FIXADDR_TOT_START, FIXADDR_TOP, PUD_SHIFT)
>> -
>>   static_assert(NR_BM_PMD_TABLES == 1);
>> +#endif
>>   
>>   #define __BM_TABLE_IDX(addr, shift) \
>>   	(((addr) >> (shift)) - (FIXADDR_TOT_START >> (shift)))
>> -- 
>> 2.41.0
>>
> 

