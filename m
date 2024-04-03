Return-Path: <linux-kernel+bounces-129674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42050896E51
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C232E1F28B9E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EEA142E9E;
	Wed,  3 Apr 2024 11:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JL8G7nhd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EBE134CCA
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712144264; cv=none; b=FJA1OL2ibCXRAM7VziUoFAzC+yTejqdz58Py45w9ozW9eXaZaFLRrDIetwRz1v3XbH1UhbiR6CIDD6hfslQaXE/z/h1ju4vm3C6CA/1gmEq/m4FvKJHZVFK16wFmhMquLoyD/1q0WGIKY6NTVtAm+J5duqQyPSLDku4uK57PERE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712144264; c=relaxed/simple;
	bh=TXngiNGuK3ZP+MSFC/o4biG/dPkqA1cYF+t83dacKtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fGhk65IJ9I6MqxKcT26QhUVobQm6ixYN6EBd5UYxLs8KkMW6RFtQJDcnzjsRK5OEZE0WZWN45c4TDedY2/hmPpVYUPnzrr43KlaSpUhtDMrbWihwlShdtjpIG4cW7n9Pi9VZWqwkQSWW+bO0LJKeZHZibYzrIuhtKkMP1jcF4cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JL8G7nhd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712144261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ka3wO+uFJaiOkWVZzkF3RFaS1jGes1V5a1fVco4/Jgo=;
	b=JL8G7nhdqmUGF/YY4qJQzFfBo2hJkFGxjPtlx4S73mHDZnFU4KvrUlrQz7YabwjxmrMWxI
	48nl/DEkDpvMfvUlD6tXO+KRefLjk2HSST0MPY3SUVwJs/OEd4wnbkoyxJcauDPcO99d9q
	Wo0mcazTJPKYtULmd+uwIaGUYp5x4jc=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-PiCbeDnWOeaP372DWXZmww-1; Wed, 03 Apr 2024 07:37:39 -0400
X-MC-Unique: PiCbeDnWOeaP372DWXZmww-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5c65e666609so5471370a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 04:37:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712144258; x=1712749058;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ka3wO+uFJaiOkWVZzkF3RFaS1jGes1V5a1fVco4/Jgo=;
        b=Po3xxINFWnfCLwWv3P43Wbc02P6g+TDODLi84ODHJEvb1xn3DUFA9BXClSOo/0QzTT
         v/nHApS2nkvgeixYNgBQpFY8ITXMUDY3BXoBIMaWYnTDeYFGl+198EC/49dymneRDfEo
         /Np5Kr2c7VLis/QTwLUDuAYLRg7xojpJxUnKcALqjnGveRMXkWqSfIQIrba8QfsCRUwJ
         8aIhBQ+j7G91FGeENkqOe4ADytUncJ9ZJytbKDRu2OugCjj2GXvPt8J6bVV+8ieAstya
         v1HdllV7Ea/NxSRWg6scORY48ScbMjSDHglxPtHC96MPRu6W9vdLT1sEqofIs0yoEJ6Z
         +ZBw==
X-Forwarded-Encrypted: i=1; AJvYcCW9IwScj2SniyQgLZ7lhFHPANoDLrvSWEoK/EuQGaPG/EbKgqzi8ZpAno7SVihmyDLkqaHFMex0cEqlFzMZYsgZ7Ei+xDDIE8004m6z
X-Gm-Message-State: AOJu0YxD8zKxsJFYBgDS9ghKGWSw1b6jcCdnjo0PeRUDPSUatQhT9S6k
	Yp4M+PTNMks3/jzTmJ2rKARAtSCQBWFi1QlmKXrOPBAt/JKAb6gtET6e7DQdqhPIu6dwIQAj7C3
	5dJzPjmhKeuE6JeYFIpvr6V1BucVYcuUPhppkKcO1GJyQ2vCnDEeOIF/9ZSSBOQ==
X-Received: by 2002:a05:6a21:1f17:b0:1a7:1d3e:7d5 with SMTP id ry23-20020a056a211f1700b001a71d3e07d5mr2016306pzb.54.1712144258664;
        Wed, 03 Apr 2024 04:37:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiA8ftdCJmfDnZJyWwraAxqZTtCbnuqcIed5bDkZfZED2IyA5GL4pjm5C0NedrIjJDq+1iow==
X-Received: by 2002:a05:6a21:1f17:b0:1a7:1d3e:7d5 with SMTP id ry23-20020a056a211f1700b001a71d3e07d5mr2016281pzb.54.1712144258244;
        Wed, 03 Apr 2024 04:37:38 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id g11-20020a056a0023cb00b006e8f75d3b07sm11506565pfc.181.2024.04.03.04.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 04:37:37 -0700 (PDT)
Message-ID: <20134458-508b-4853-a962-c1b44009e8ed@redhat.com>
Date: Wed, 3 Apr 2024 21:37:30 +1000
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
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <86edbmu8kn.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/24 18:58, Marc Zyngier wrote:
> On Wed, 03 Apr 2024 07:49:29 +0100,
> Gavin Shan <gshan@redhat.com> wrote:
>>
>> KVM/arm64 relies on TLBI RANGE feature to flush TLBs when the dirty
>> bitmap is collected by VMM and the corresponding PTEs need to be
>> write-protected again. Unfortunately, the operand passed to the TLBI
>> RANGE instruction isn't correctly sorted out by commit d1d3aa98b1d4
>> ("arm64: tlb: Use the TLBI RANGE feature in arm64"). It leads to
>> crash on the destination VM after live migration because some of the
>> dirty pages are missed.
>>
>> For example, I have a VM where 8GB memory is assigned, starting from
>> 0x40000000 (1GB). Note that the host has 4KB as the base page size.
>> All TLBs for VM can be covered by one TLBI RANGE operation. However,
>> I receives 0xffff708000040000 as the operand, which is wrong and the
>> correct one should be 0x00007f8000040000. From the wrong operand, we
>> have 3 and 1 for SCALE (bits[45:44) and NUM (bits943:39], only 1GB
>> instead of 8GB memory is covered.
>>
>> Fix the macro __TLBI_RANGE_NUM() so that the correct NUM and TLBI
>> RANGE operand are provided.
>>
>> Fixes: d1d3aa98b1d4 ("arm64: tlb: Use the TLBI RANGE feature in arm64")
>> Cc: stable@kernel.org # v5.10+
>> Reported-by: Yihuang Yu <yihyu@redhat.com>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/include/asm/tlbflush.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
>> index 3b0e8248e1a4..07c4fb4b82b4 100644
>> --- a/arch/arm64/include/asm/tlbflush.h
>> +++ b/arch/arm64/include/asm/tlbflush.h
>> @@ -166,7 +166,7 @@ static inline unsigned long get_trans_granule(void)
>>    */
>>   #define TLBI_RANGE_MASK			GENMASK_ULL(4, 0)
>>   #define __TLBI_RANGE_NUM(pages, scale)	\
>> -	((((pages) >> (5 * (scale) + 1)) & TLBI_RANGE_MASK) - 1)
>> +	((((pages) >> (5 * (scale) + 1)) - 1) & TLBI_RANGE_MASK)
>>   
>>   /*
>>    *	TLB Invalidation
> 
> This looks pretty wrong, by the very definition of the comment that's
> just above:
> 
> <quote>
> /*
>   * Generate 'num' values from -1 to 30 with -1 rejected by the
>   * __flush_tlb_range() loop below.
>   */
> </quote>
> 
> With your change, num can't ever be negative, and that breaks
> __flush_tlb_range_op():
> 
> <quote>
> 		num = __TLBI_RANGE_NUM(pages, scale);			\
> 		if (num >= 0) {						\
> 			addr = __TLBI_VADDR_RANGE(start >> shift, asid, \
> 						scale, num, tlb_level);	\
> 			__tlbi(r##op, addr);				\
> 			if (tlbi_user)					\
> 				__tlbi_user(r##op, addr);		\
> 			start += __TLBI_RANGE_PAGES(num, scale) << PAGE_SHIFT; \
> 			pages -= __TLBI_RANGE_PAGES(num, scale);	\
> 		}							\
> 		scale--;						\
> </quote>
> 
> We'll then shove whatever value we've found in the TLBI operation,
> leading to unknown results instead of properly adjusting the scale to
> issue a smaller invalidation.
> 

Marc, thanks for your review and comments.

Indeed, this patch is incomplete at least. I think we need __TLBI_RANGE_NUM()
to return [-1 31] instead of [-1 30], to be consistent with MAX_TLBI_RANGE_PAGES.
-1 will be rejected in the following loop. I'm not 100% sure if I did the correct
calculation though.

/*
  * Generate 'num' values in range [-1 31], but -1 will be rejected
  * by the __flush_tlb_range() loop below.
  */
#define __TLBI_RANGE_NUM(pages, scale)                                          \
         ({                                                                      \
                 int __next = (pages) & (1ULL << (5 * (scale) + 6));             \
                 int __mask = ((pages) >> (5 * (scale) + 1)) & TLBI_RANGE_MASK;  \
                 int __num = (((pages) >> (5 * (scale) + 1)) - 1) &              \
                             TLBI_RANGE_MASK;                                    \
                 (__next || __mask) ? __num : -1;                                \
         })

Alternatively, we can also limit the number of pages to be invalidated from
arch/arm64/kvm/hyp/pgtable.c::kvm_tlb_flush_vmid_range() because the maximal
capacity is (MAX_TLBI_RANGE_PAGES - 1) instead of MAX_TLBI_RANGE_PAGES, as
the comments for __flush_tlb_range_nosync() say.

-               inval_pages = min(pages, MAX_TLBI_RANGE_PAGES);
+               inval_pages = min(pages, MAX_TLBI_RANGE_PAGES - 1);


static inline void __flush_tlb_range_nosync(...)
{
         :
        /*
          * When not uses TLB range ops, we can handle up to
          * (MAX_DVM_OPS - 1) pages;
          * When uses TLB range ops, we can handle up to
          * (MAX_TLBI_RANGE_PAGES - 1) pages.
          */
         if ((!system_supports_tlb_range() &&
              (end - start) >= (MAX_DVM_OPS * stride)) ||
             pages >= MAX_TLBI_RANGE_PAGES) {
                 flush_tlb_mm(vma->vm_mm);
                 return;
         }
}

Please let me know which way is better.

> I think the problem is that you are triggering NUM=31 and SCALE=3,
> which the current code cannot handle as per the comment above
> __flush_tlb_range_op() (we can't do NUM=30 and SCALE=4, obviously).
> 

Yes, exactly.

> Can you try the untested patch below?
> 
> 
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index 3b0e8248e1a4..b71a1cece802 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -379,10 +379,6 @@ static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
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
> @@ -407,6 +403,7 @@ do {									\
>   									\
>   		num = __TLBI_RANGE_NUM(pages, scale);			\
>   		if (num >= 0) {						\
> +			num += 1;					\
>   			addr = __TLBI_VADDR_RANGE(start >> shift, asid, \
>   						scale, num, tlb_level);	\
>   			__tlbi(r##op, addr);				\
> 

Thanks, but I don't think it's going to work. The loop will be running infinitely
because the condition 'if (num >= 0)' can't be met when @pages is 0x200000 when
@scale is 3/2/1/0 until @scale becomes negative and positive again, but @scale
isn't in range [0 3]. I ported the chunk of code to user-space and I can see this
with added printf() messages.

Thanks,
Gavin


