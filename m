Return-Path: <linux-kernel+bounces-130867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B426A897E38
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 06:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11425283B49
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 04:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F7A1BC3E;
	Thu,  4 Apr 2024 04:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZsgUhSHM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA891865
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 04:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712205372; cv=none; b=P+naJVTRAvBtL9SvHoanH3mc36PQ/Td2TQyItc9BvztexDT96OpMyXOzmpVgC94WkxRx1XjRWz8KDebw+KnUvJhdtZsL5dxzTzV99Qg0PALkzozraYMfKnZL3FBSzTUilubvau6+wIE3i9SEbIXAPtnOpW3LDpE6Z0n2m2QPwbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712205372; c=relaxed/simple;
	bh=xqyuKkzQ16jnDykUYIyVzXIyc5drMbtmvBvwcV7Qlek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CNPLagkVNowkDRBkkKt2Qv/kK3sLLaM6e54LLeqCgsFE2eUxrukheZ1T9fXjgB9Alk6eKgG+OEK3PXEdlkArk7Gjv8H2XMVYXdFMZLQmtAnVjN1sZwPFVwCvxa6hH2Y0cCrVJ2DscKCNgPNCAKYjxSf8FvKko11WfKwaAgJESKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZsgUhSHM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712205368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GG5g4/5UnvySMnZ4arpwK8m9tiSirFhJ8yJz3sFpBsA=;
	b=ZsgUhSHM9f/Vs5Rkby6UdRxg2b4fqO0VwfVZFJtInqOT5GigNfKYKQ917hFanfY2hIx3Eb
	+IRyNkENhI9DeUCKt0k6plTB6bCjBih8BFLMBRVceLoIChJBhHnPLCZWwbHOBaBjZUxNiu
	Mu4le7Zk69XXh5kuGbIA6L6pYjeW1Tw=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-dq_S5OjaMLaDFJ3KVmo77A-1; Thu, 04 Apr 2024 00:36:07 -0400
X-MC-Unique: dq_S5OjaMLaDFJ3KVmo77A-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6e6faa457b5so645704a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 21:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712205366; x=1712810166;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GG5g4/5UnvySMnZ4arpwK8m9tiSirFhJ8yJz3sFpBsA=;
        b=XjNrgGJCgcCMAMuC/H/i6PaTJ/LxlfX3YsPfb+wDhbVc+AZdPJWH9WzvsHwwBvDBjO
         sz+V7UezqO+U5DABcVy7wFgShUC0Mjz1kHTjEjHrlSuuCEEC0bSyqYF4CZVRsU6zlcNj
         EXx1ADXRi88QjGuIJm7MQRHCHWVFG4GuKyjdyWK2tDMVzZYPEfxbLZEubVhaf1er9DeO
         dwg9lnP5W06v65FqWmrDk7a+U4qRZVJx87CgbevGVCCUgkWJmmi0Hxt9189MrLzMv4h/
         ng1fyA5+Zypx18OnsqblHfxS84cZHSp1Ws1f7I4oFMEvdu5e5FYG1Cpb9nCYI6MOB9jq
         YT7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVIg45cyLl8GBqpdRpRhauX35aI6lODVHpDOElX5RBQzst3Q/Tdqc1KfTXW7M2o4LO4lrpBxNBSJbPCO8/9HtIZDMov9kPPUEG4E9SS
X-Gm-Message-State: AOJu0YzsXewB2SmwT1vljSFQ1Pbi1smuelkpLa5yURKR237K0yao1Oa8
	9ixzkwb/1xtngBwxvuc+8J9yXKTJVi+7Gh0hmeEzZAbBifuLy+K5gW6D8BNd8M+GccNGynw2bmx
	NMFqDR8TJA/FNnqJPc00kBzQ1EnryypFP/LXX5U1ggrN7mbuWxR7nGokOVheXUA==
X-Received: by 2002:a05:6870:4710:b0:22e:9cc0:4a9b with SMTP id b16-20020a056870471000b0022e9cc04a9bmr1434434oaq.52.1712205366366;
        Wed, 03 Apr 2024 21:36:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5g/Mtw+foI8cnQdrvhdfO4/jQbSglX1umkIY39FMeN/azebI1BPk96Uz9NaAJAotjvThppg==
X-Received: by 2002:a05:6870:4710:b0:22e:9cc0:4a9b with SMTP id b16-20020a056870471000b0022e9cc04a9bmr1434414oaq.52.1712205366037;
        Wed, 03 Apr 2024 21:36:06 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id t4-20020a62ea04000000b006e6bda407b6sm12580478pfh.202.2024.04.03.21.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 21:36:05 -0700 (PDT)
Message-ID: <bd502c7a-e2bf-4cb3-b432-7dd472f1c82e@redhat.com>
Date: Thu, 4 Apr 2024 14:35:58 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: tlb: Fix TLBI RANGE operand
Content-Language: en-US
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org,
 apopple@nvidia.com, mark.rutland@arm.com, ryan.roberts@arm.com,
 rananta@google.com, yangyicong@hisilicon.com, v-songbaohua@oppo.com,
 yezhenyu2@huawei.com, yihyu@redhat.com, shan.gavin@gmail.com
References: <20240403064929.1438475-1-gshan@redhat.com>
 <86edbmu8kn.wl-maz@kernel.org>
 <20134458-508b-4853-a962-c1b44009e8ed@redhat.com>
 <87jzlesgqy.wl-maz@kernel.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <87jzlesgqy.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/24 23:44, Marc Zyngier wrote:
> On Wed, 03 Apr 2024 12:37:30 +0100,
> Gavin Shan <gshan@redhat.com> wrote:
>>
>> On 4/3/24 18:58, Marc Zyngier wrote:
>>> On Wed, 03 Apr 2024 07:49:29 +0100,
>>> Gavin Shan <gshan@redhat.com> wrote:
>>>>
>>>> KVM/arm64 relies on TLBI RANGE feature to flush TLBs when the dirty
>>>> bitmap is collected by VMM and the corresponding PTEs need to be
>>>> write-protected again. Unfortunately, the operand passed to the TLBI
>>>> RANGE instruction isn't correctly sorted out by commit d1d3aa98b1d4
>>>> ("arm64: tlb: Use the TLBI RANGE feature in arm64"). It leads to
>>>> crash on the destination VM after live migration because some of the
>>>> dirty pages are missed.
>>>>
>>>> For example, I have a VM where 8GB memory is assigned, starting from
>>>> 0x40000000 (1GB). Note that the host has 4KB as the base page size.
>>>> All TLBs for VM can be covered by one TLBI RANGE operation. However,
>>>> I receives 0xffff708000040000 as the operand, which is wrong and the
>>>> correct one should be 0x00007f8000040000. From the wrong operand, we
>>>> have 3 and 1 for SCALE (bits[45:44) and NUM (bits943:39], only 1GB
>>>> instead of 8GB memory is covered.
>>>>
>>>> Fix the macro __TLBI_RANGE_NUM() so that the correct NUM and TLBI
>>>> RANGE operand are provided.
>>>>
>>>> Fixes: d1d3aa98b1d4 ("arm64: tlb: Use the TLBI RANGE feature in arm64")
>>>> Cc: stable@kernel.org # v5.10+
>>>> Reported-by: Yihuang Yu <yihyu@redhat.com>
>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>> ---
>>>>    arch/arm64/include/asm/tlbflush.h | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
>>>> index 3b0e8248e1a4..07c4fb4b82b4 100644
>>>> --- a/arch/arm64/include/asm/tlbflush.h
>>>> +++ b/arch/arm64/include/asm/tlbflush.h
>>>> @@ -166,7 +166,7 @@ static inline unsigned long get_trans_granule(void)
>>>>     */
>>>>    #define TLBI_RANGE_MASK			GENMASK_ULL(4, 0)
>>>>    #define __TLBI_RANGE_NUM(pages, scale)	\
>>>> -	((((pages) >> (5 * (scale) + 1)) & TLBI_RANGE_MASK) - 1)
>>>> +	((((pages) >> (5 * (scale) + 1)) - 1) & TLBI_RANGE_MASK)
>>>>      /*
>>>>     *	TLB Invalidation
>>>
>>> This looks pretty wrong, by the very definition of the comment that's
>>> just above:
>>>
>>> <quote>
>>> /*
>>>    * Generate 'num' values from -1 to 30 with -1 rejected by the
>>>    * __flush_tlb_range() loop below.
>>>    */
>>> </quote>
>>>
>>> With your change, num can't ever be negative, and that breaks
>>> __flush_tlb_range_op():
>>>
>>> <quote>
>>> 		num = __TLBI_RANGE_NUM(pages, scale);			\
>>> 		if (num >= 0) {						\
>>> 			addr = __TLBI_VADDR_RANGE(start >> shift, asid, \
>>> 						scale, num, tlb_level);	\
>>> 			__tlbi(r##op, addr);				\
>>> 			if (tlbi_user)					\
>>> 				__tlbi_user(r##op, addr);		\
>>> 			start += __TLBI_RANGE_PAGES(num, scale) << PAGE_SHIFT; \
>>> 			pages -= __TLBI_RANGE_PAGES(num, scale);	\
>>> 		}							\
>>> 		scale--;						\
>>> </quote>
>>>
>>> We'll then shove whatever value we've found in the TLBI operation,
>>> leading to unknown results instead of properly adjusting the scale to
>>> issue a smaller invalidation.
>>>
>>
>> Marc, thanks for your review and comments.
>>
>> Indeed, this patch is incomplete at least. I think we need __TLBI_RANGE_NUM()
>> to return [-1 31] instead of [-1 30], to be consistent with MAX_TLBI_RANGE_PAGES.
>> -1 will be rejected in the following loop. I'm not 100% sure if I did the correct
>> calculation though.
>>
>> /*
>>   * Generate 'num' values in range [-1 31], but -1 will be rejected
>>   * by the __flush_tlb_range() loop below.
>>   */
>> #define __TLBI_RANGE_NUM(pages, scale)                                          \
>>          ({                                                                      \
>>                  int __next = (pages) & (1ULL << (5 * (scale) + 6));             \
>>                  int __mask = ((pages) >> (5 * (scale) + 1)) & TLBI_RANGE_MASK;  \
>>                  int __num = (((pages) >> (5 * (scale) + 1)) - 1) &              \
>>                              TLBI_RANGE_MASK;                                    \
>>                  (__next || __mask) ? __num : -1;                                \
>>          })
> 
> I'm afraid I don't follow the logic here, and it looks awfully
> complex.  I came up with something simpler with this:
> 
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index 3b0e8248e1a4..b3f1a9c61189 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -161,12 +161,18 @@ static inline unsigned long get_trans_granule(void)
>   #define MAX_TLBI_RANGE_PAGES		__TLBI_RANGE_PAGES(31, 3)
>   
>   /*
> - * Generate 'num' values from -1 to 30 with -1 rejected by the
> + * Generate 'num' values from -1 to 31 with -1 rejected by the
>    * __flush_tlb_range() loop below.
>    */
>   #define TLBI_RANGE_MASK			GENMASK_ULL(4, 0)
> -#define __TLBI_RANGE_NUM(pages, scale)	\
> -	((((pages) >> (5 * (scale) + 1)) & TLBI_RANGE_MASK) - 1)
> +#define __TLBI_RANGE_NUM(pages, scale)					\
> +	({								\
> +		int __pages = min((pages),				\
> +				  __TLBI_RANGE_PAGES(31, (scale)));	\
> +		int __numplus1 = __pages >> (5 * (scale) + 1);		\
> +									\
> +		(__numplus1 - 1);					\
> +	})
>   

Thanks, Marc. Both your changes and mine worked, my issue can be fixed at least.
Your version is certainly simpler and clearer. I will integrate your changes to
v2 with TLB_RANGE_MASK dropped since no one will uses it any more.

>   /*
>    *	TLB Invalidation
> @@ -379,10 +385,6 @@ static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
>    * 3. If there is 1 page remaining, flush it through non-range operations. Range
>    *    operations can only span an even number of pages. We save this for last to
>    *    ensure 64KB start alignment is maintained for the LPA2 case.
> - *
> - * Note that certain ranges can be represented by either num = 31 and
> - * scale or num = 0 and scale + 1. The loop below favours the latter
> - * since num is limited to 30 by the __TLBI_RANGE_NUM() macro.
>    */
>   #define __flush_tlb_range_op(op, start, pages, stride,			\
>   				asid, tlb_level, tlbi_user, lpa2)	\
> 
>>
>> Alternatively, we can also limit the number of pages to be invalidated from
>> arch/arm64/kvm/hyp/pgtable.c::kvm_tlb_flush_vmid_range() because the maximal
>> capacity is (MAX_TLBI_RANGE_PAGES - 1) instead of MAX_TLBI_RANGE_PAGES, as
>> the comments for __flush_tlb_range_nosync() say.
>>
>> -               inval_pages = min(pages, MAX_TLBI_RANGE_PAGES);
>> +               inval_pages = min(pages, MAX_TLBI_RANGE_PAGES - 1);
>>
>>
>> static inline void __flush_tlb_range_nosync(...)
>> {
>>          :
>>         /*
>>           * When not uses TLB range ops, we can handle up to
>>           * (MAX_DVM_OPS - 1) pages;
>>           * When uses TLB range ops, we can handle up to
>>           * (MAX_TLBI_RANGE_PAGES - 1) pages.
>>           */
>>          if ((!system_supports_tlb_range() &&
>>               (end - start) >= (MAX_DVM_OPS * stride)) ||
>>              pages >= MAX_TLBI_RANGE_PAGES) {
>>                  flush_tlb_mm(vma->vm_mm);
>>                  return;
>>          }
>> }
>>
>> Please let me know which way is better.
> 
> I would really prefer to fix the range stuff itself instead of
> papering over the problem by reducing the reach of the range
> invalidation.
> 

Yes, Agreed.

>>
>>> I think the problem is that you are triggering NUM=31 and SCALE=3,
>>> which the current code cannot handle as per the comment above
>>> __flush_tlb_range_op() (we can't do NUM=30 and SCALE=4, obviously).
>>>
>>
>> Yes, exactly.
>>
>>> Can you try the untested patch below?
>>>
>>>
>>> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
>>> index 3b0e8248e1a4..b71a1cece802 100644
>>> --- a/arch/arm64/include/asm/tlbflush.h
>>> +++ b/arch/arm64/include/asm/tlbflush.h
>>> @@ -379,10 +379,6 @@ static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
>>>     * 3. If there is 1 page remaining, flush it through non-range operations. Range
>>>     *    operations can only span an even number of pages. We save this for last to
>>>     *    ensure 64KB start alignment is maintained for the LPA2 case.
>>> - *
>>> - * Note that certain ranges can be represented by either num = 31 and
>>> - * scale or num = 0 and scale + 1. The loop below favours the latter
>>> - * since num is limited to 30 by the __TLBI_RANGE_NUM() macro.
>>>     */
>>>    #define __flush_tlb_range_op(op, start, pages, stride,			\
>>>    				asid, tlb_level, tlbi_user, lpa2)	\
>>> @@ -407,6 +403,7 @@ do {									\
>>>    									\
>>>    		num = __TLBI_RANGE_NUM(pages, scale);			\
>>>    		if (num >= 0) {						\
>>> +			num += 1;					\
>>>    			addr = __TLBI_VADDR_RANGE(start >> shift, asid, \
>>>    						scale, num, tlb_level);	\
>>>    			__tlbi(r##op, addr);				\
>>>
>>
>> Thanks, but I don't think it's going to work. The loop will be running infinitely
>> because the condition 'if (num >= 0)' can't be met when @pages is 0x200000 when
>> @scale is 3/2/1/0 until @scale becomes negative and positive again, but @scale
>> isn't in range [0 3]. I ported the chunk of code to user-space and I can see this
>> with added printf() messages.
> 
> Yeah, we lose num==0, which is silly. Hopefully the hack above helps a
> bit.
> 

Yes, the hack works. Thank you again.

Thanks,
Gavin


