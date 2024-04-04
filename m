Return-Path: <linux-kernel+bounces-131235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C275E8984F2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19FA4B20BD5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900E876049;
	Thu,  4 Apr 2024 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4jovV4i"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6E959B7F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 10:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712226393; cv=none; b=rioxYKaEL9knPiK5VntS1mrShb9LLAkd5dgGbQN4/czoDDcH14cv/xb35+FC46dTNqAc9vb/oWzLewHv5m8fU1qerRgU4mW7w3jmwx4zIYmIMTgUKfPjAQmxBlsx8BcrESsKvfgIviiqA0vzw35/vG6CScu9pvF23cLoaijBYOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712226393; c=relaxed/simple;
	bh=BGFKlyqDJJNi7NaRva816nxWw971QYe1+UQRvw5Blmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mltwwHD69A/CAeNvEpFTkL2ojkBCIa2uql8gA6N6UfLecBO+HLhVy/obtS69P3TkXO0tFm2XaE6KWH8eTLqek8D+rP5ik+hUhoy7Z6fyLbX574+ouqXfLfO2rcN7BfA/NKdQKV+TKQBpoaQ0LD9K4X4PZF1+z05uJWjyaBrQtBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N4jovV4i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712226390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=88PGylMbEVomBu2mJUOYQi35VTIsjcNQmJ/W4XLtmMs=;
	b=N4jovV4iUbfvdZ54gLuYsWk2wqlHdZ18327aYQEvGMlWXUWKsZxQUd2q2WysZ/rGkwmL6n
	5Vv3d2Sm86fdVU6pwEjHZi44A3uD5NmRg8dlGMiyZHJaV2gvXXvkw7x+GJMch9FKXAUxPx
	lNKVhMZXdkxl18xxBs0Kv45nLOcLlbo=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-xJ9fJA9cPLiJNGnJI-6D1g-1; Thu, 04 Apr 2024 06:26:29 -0400
X-MC-Unique: xJ9fJA9cPLiJNGnJI-6D1g-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1e26d58d36dso6210115ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 03:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712226388; x=1712831188;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=88PGylMbEVomBu2mJUOYQi35VTIsjcNQmJ/W4XLtmMs=;
        b=rx6kutCM7SLUxEfa7kWxskanJRa4fIs4KKHrVZQqYGVVGfbAE5d5BLWsAyA/XwAXle
         XkW9B4QDIotBInRSakESGcmXT0MaQkTtEGNOACouoCkigZMSn33zNExmUSwTZ9u4Fe6x
         lHi85IML74pa0HjlTF5UGZNZxtY+CTXHyTDn4EtJx+YPSj4mkU3mzmzY5M2Ht6YdR+Be
         OIuRtEZzlsDyk7+3X/RszoWV4ffA+LohKw9rJdw2vCSo1xbtHUaDyEupVqPPJQOBY/El
         9UTzVOJt2ML0toFLlyIYwzzzjb/jlB3MGG2WBoxzblUFtzAegv/s/tDjd5xQ185dpSEt
         YVNw==
X-Forwarded-Encrypted: i=1; AJvYcCXUo69se5upf2Oq72WY/OyChqxCu1E5uEYh2eW88JN6c+h2ZcKlELvUNkuCMkIPghFlqMg/YtEAb5la0lojbIceP2MG4zKS7e7UsVlz
X-Gm-Message-State: AOJu0YzP79Lg4CJsxVQrIGOUTA1qBy0qN4RwD6gGRC7SOL8qZJ6fBwT4
	/0KRWFBNfvlgdQhDmmQ2a1U+zs3GrOR4+wGneyzzl5a8YmvP6NPYhLpgiFu4uWt2CbLhFjHFXej
	uNDJD1LpiiHIBAoFW6Y8lROazLA2a8ZuYGX9CHLj5WldxyKBPhu7piCfvnW3dGA==
X-Received: by 2002:a17:902:ca14:b0:1e0:a08e:bd92 with SMTP id w20-20020a170902ca1400b001e0a08ebd92mr1335808pld.58.1712226387946;
        Thu, 04 Apr 2024 03:26:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKKFWdyva6gq20elnS97jA5PyDb+o/LrAWo2xbN3DA/UUlGw7ET9gexnW4ibQYVTnecEwvyA==
X-Received: by 2002:a17:902:ca14:b0:1e0:a08e:bd92 with SMTP id w20-20020a170902ca1400b001e0a08ebd92mr1335788pld.58.1712226387521;
        Thu, 04 Apr 2024 03:26:27 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id c16-20020a170903235000b001e2a761bfddsm1492568plh.268.2024.04.04.03.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 03:26:27 -0700 (PDT)
Message-ID: <d0b2f9d0-228f-488d-94b8-79f01f17e4e8@redhat.com>
Date: Thu, 4 Apr 2024 20:26:20 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: tlb: Fix TLBI RANGE operand
Content-Language: en-US
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org,
 oliver.upton@linux.dev, mark.rutland@arm.com, ryan.roberts@arm.com,
 apopple@nvidia.com, rananta@google.com, yangyicong@hisilicon.com,
 v-songbaohua@oppo.com, yezhenyu2@huawei.com, yihyu@redhat.com,
 shan.gavin@gmail.com
References: <20240404053624.1485237-1-gshan@redhat.com>
 <87il0xsdc0.wl-maz@kernel.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <87il0xsdc0.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marc,

On 4/4/24 19:10, Marc Zyngier wrote:
> On Thu, 04 Apr 2024 06:36:24 +0100,
> Gavin Shan <gshan@redhat.com> wrote:
>>
>> KVM/arm64 relies on TLBI RANGE feature to flush TLBs when the dirty
>> bitmap is collected by VMM and the corresponding PTEs need to be
>> write-protected during live migration. Unfortunately, the operand
>> passed to the TLBI RANGE instruction isn't correctly sorted out by
>> commit d1d3aa98b1d4 ("arm64: tlb: Use the TLBI RANGE feature in arm64").
> 
> This isn't the offending commit. See below.
> 

Yes, I agree with you and more explanations as below.

>> It leads to crash on the destination VM after live migration because
>> TLBs aren't flushed completely and some of the dirty pages are missed.
>>
>> For example, I have a VM where 8GB memory is assigned, starting from
>> 0x40000000 (1GB). Note that the host has 4KB as the base page size.
>> All TLBs for VM can be covered by one TLBI RANGE operation. However,
>> the operand 0xffff708000040000 is set for scale -9, and  -1 is returned
> 
> It's not scale, as it is limited to 2 bits. It's a random value that
> actively corrupts adjacent fields because it is wrongly sign-extended.
> ASID and TG are now utter bollocks, and the CPU is within its rights
> to totally ignore the TLBI (TG indicates 64kB translation granule...).
> 
> We really should fix __TLBI_VADDR_RANGE() to use proper bit fields
> instead of a bunch of shifts that lead to this mess.
> 

Well, I meant the variable @scale instead of SCALE, part of the operand
to TLBI RANGE instruction. Let me make it clear in next revision.

Yes, __TLBI_VADDR_RANGE() can be improved by masks. However, the source
of the mess is 117940aa6e5f8 ("KVM: arm64: Define kvm_tlb_flush_vmid_range()")
because it can pass @pages (e.g. 0x200000) that __flush_tlb_range_op() can't
handle. It may be another hint to set 117940aa6e5f8 as the fix target.

>> from __TLBI_RANGE_NUM() for scale 3/2/1/0 and rejected by the loop in
>> __flush_tlb_range_op(). __TLBI_RANGE_NUM() isn't expected to work
>> like this because all the pages should be covered by scale 3/2/1/0,
>> plus an additional page if needed.
>>
>> Fix the macro __TLBI_RANGE_NUM() so that the correct NUM and TLBI RANGE
>> operand are provided for each scale level. With the changes, [-1 31]
>> instead of [-1 30] can be returned from the macro, meaning the TLBs for
>> 0x200000 pages (8GB memory) can be flushed in one shoot at scale 3. The
>> macro TLBI_RANGE_MASK is dropped since no one uses it any more.
>>
>> Fixes: d1d3aa98b1d4 ("arm64: tlb: Use the TLBI RANGE feature in arm64")
>> Cc: stable@kernel.org # v5.10+
> 
> I don't think this is right. The problem only occurs since
> 117940aa6e5f8 ("KVM: arm64: Define kvm_tlb_flush_vmid_range()"), which
> is the only case where we try to use NUM=31 (the rest of the kernel is
> using (MAX_TLBI_RANGE_PAGES - 1), which results in NUM=30 at most).
> 
> Also, before e2768b798a19 ("arm64/mm: Modify range-based tlbi to
> decrement scale"), we used a different algorithm to perform the
> invalidation (increasing scale instead of decreasing), so this
> probably doesn't hit the same way.
> 
> In any case, this is a KVM-only problem that will never show before
> v6.6. So 5.10 really isn't a place where we need to backport anything.
> 

Agreed. It's more precise to set 117940aa6e5f8 as the fix target. I will
correct it in v3.

Fixes: 117940aa6e5f ("KVM: arm64: Define kvm_tlb_flush_vmid_range()")

>> Reported-by: Yihuang Yu <yihyu@redhat.com>
>> Suggested-by: Marc Zyngier <maz@kernel.org>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>> v2: Improve __TLBI_RANGE_NUM() as Marc suggested
>> ---
>>   arch/arm64/include/asm/tlbflush.h | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
>> index 3b0e8248e1a4..cd9b71c30366 100644
>> --- a/arch/arm64/include/asm/tlbflush.h
>> +++ b/arch/arm64/include/asm/tlbflush.h
>> @@ -161,12 +161,17 @@ static inline unsigned long get_trans_granule(void)
>>   #define MAX_TLBI_RANGE_PAGES		__TLBI_RANGE_PAGES(31, 3)
>>   
>>   /*
>> - * Generate 'num' values from -1 to 30 with -1 rejected by the
>> + * Generate 'num' values from -1 to 31 with -1 rejected by the
>>    * __flush_tlb_range() loop below.
>>    */
>> -#define TLBI_RANGE_MASK			GENMASK_ULL(4, 0)
>> -#define __TLBI_RANGE_NUM(pages, scale)	\
>> -	((((pages) >> (5 * (scale) + 1)) & TLBI_RANGE_MASK) - 1)
>> +#define __TLBI_RANGE_NUM(pages, scale)					\
>> +	({								\
>> +		int __pages = min((pages),				\
>> +				  __TLBI_RANGE_PAGES(31, (scale)));	\
>> +		int __numplus1 = __pages >> (5 * (scale) + 1);		\
>> +									\
>> +		(__numplus1 - 1);					\
>> +	})
> 
> This was only intended as a way to convey the general idea. __numplus1
> can obviously be removed and the right-shifting expression promoted as
> the return value.
> 
> Next, the comments in this file need adjustments to reflect the
> supported invalidation range, as my original patch did (plus some
> more).
> 
> Finally, and since we can now handle the full range of invalidation,
> it would make sense to fix __flush_tlb_range_nosync() to allow
> MAX_TLBI_RANGE_PAGES ranges (potentially in a separate patch).
> 
> In the end, my sandbox contains the following, which should probably
> be split in 3 patches:
> 

Ok, I thought @__numplus1 was there for better code readability since it's
likely opted out by GCC's optimization. I will drop @__numplus1 anyway. And
the comments need to be improved for sure.

Yeah, I've noticed that __flush_tlb_range_nosync() needs to allow
MAX_TLBI_RANGE_PAGES to do range based TLB flush.

In summary, we need 3 patches but the one fixing __TLBI_RANGE_NUM needs to be
PATCH[1/3] so that it can be easily picked by stable kernel. PATCH[2/3] would
be to improve __TLBI_VADDR_RANGE with masks. PATCH[3/3] will allow __flush_tlb_range_nosync()
to do range-based TLB flush for MAX_TLBI_RANGE_PAGES.

> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index 3b0e8248e1a4..bcbe697ed191 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -142,16 +142,22 @@ static inline unsigned long get_trans_granule(void)
>    * EL1, Inner Shareable".
>    *
>    */
> +#define TLBIR_ASID_MASK		GENMASK_ULL(63, 48)
> +#define TLBIR_TG_MASK		GENMASK_ULL(47, 46)
> +#define TLBIR_SCALE_MASK	GENMASK_ULL(45, 44)
> +#define TLBIR_NUM_MASK		GENMASK_ULL(43, 39)
> +#define TLBIR_TTL_MASK		GENMASK_ULL(38, 37)
> +#define TLBIR_BADDR_MASK	GENMASK_ULL(36,  0)
> +
>   #define __TLBI_VADDR_RANGE(baddr, asid, scale, num, ttl)			\
>   	({									\
> -		unsigned long __ta = (baddr);					\
> +		unsigned long __ta = FIELD_PREP(TLBIR_BADDR_MASK, (baddr)); 	\
>   		unsigned long __ttl = (ttl >= 1 && ttl <= 3) ? ttl : 0;		\
> -		__ta &= GENMASK_ULL(36, 0);					\
> -		__ta |= __ttl << 37;						\
> -		__ta |= (unsigned long)(num) << 39;				\
> -		__ta |= (unsigned long)(scale) << 44;				\
> -		__ta |= get_trans_granule() << 46;				\
> -		__ta |= (unsigned long)(asid) << 48;				\
> +		__ta |= FIELD_PREP(TLBIR_TTL_MASK, __ttl);			\
> +		__ta |= FIELD_PREP(TLBIR_NUM_MASK, (unsigned long)(num));	\
> +		__ta |= FIELD_PREP(TLBIR_SCALE_MASK, (unsigned long)(scale));	\
> +		__ta |= FIELD_PREP(TLBIR_TG_MASK, get_trans_granule());		\
> +		__ta |= FIELD_PREP(TLBIR_ASID_MASK, (unsigned long)(asid));	\
>   		__ta;								\
>   	})
>   
> @@ -161,12 +167,17 @@ static inline unsigned long get_trans_granule(void)
>   #define MAX_TLBI_RANGE_PAGES		__TLBI_RANGE_PAGES(31, 3)
>   
>   /*
> - * Generate 'num' values from -1 to 30 with -1 rejected by the
> - * __flush_tlb_range() loop below.
> + * Generate 'num' values from -1 to 31 with -1 rejected by the
> + * __flush_tlb_range() loop below. Its return value is only
> + * significant for a maximum of MAX_TLBI_RANGE_PAGES pages. If 'pages'
> + * is more than that, you must iterate over the overall range.
>    */
> -#define TLBI_RANGE_MASK			GENMASK_ULL(4, 0)
> -#define __TLBI_RANGE_NUM(pages, scale)	\
> -	((((pages) >> (5 * (scale) + 1)) & TLBI_RANGE_MASK) - 1)
> +#define __TLBI_RANGE_NUM(pages, scale)					\
> +	({								\
> +		int __pages = min((pages),				\
> +				  __TLBI_RANGE_PAGES(31, (scale)));	\
> +		(__pages >> (5 * (scale) + 1)) - 1;			\
> +	})
>   
>   /*
>    *	TLB Invalidation
> @@ -379,10 +390,6 @@ static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
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
> @@ -437,11 +444,11 @@ static inline void __flush_tlb_range_nosync(struct vm_area_struct *vma,
>   	 * When not uses TLB range ops, we can handle up to
>   	 * (MAX_DVM_OPS - 1) pages;
>   	 * When uses TLB range ops, we can handle up to
> -	 * (MAX_TLBI_RANGE_PAGES - 1) pages.
> +	 * MAX_TLBI_RANGE_PAGES pages.
>   	 */
>   	if ((!system_supports_tlb_range() &&
>   	     (end - start) >= (MAX_DVM_OPS * stride)) ||
> -	    pages >= MAX_TLBI_RANGE_PAGES) {
> +	    pages > MAX_TLBI_RANGE_PAGES) {
>   		flush_tlb_mm(vma->vm_mm);
>   		return;
>   	}
> 

Thanks,
Gavin


