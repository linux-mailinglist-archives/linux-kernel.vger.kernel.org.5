Return-Path: <linux-kernel+bounces-51607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABA1848D2C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 12:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC3A81F2240A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 11:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8FE22307;
	Sun,  4 Feb 2024 11:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NqOHQ5PS"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28AC21A0B
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 11:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707046789; cv=none; b=TtDwBLpPQ7t310pp3O4s1aJ0A3G4J3qvroTGYBiclqeaEvUBzCQ1rFBlqj6Lnq30I6A8IyTZ9YV5fjqzNheY909Zgz13uch4rFTfQcvLmDmF7luwFy/6/Os8QiWJu2/qx9JGy4QWgqx18bS2Ic3UcUY/C/QDy7IxqxnMHEmzHbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707046789; c=relaxed/simple;
	bh=4gs25cYQ3zvkoCOJIKXkOvKR/DEOLs+xSJSK7/N5BKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vBNDfOpQ8uNoXFSZq+f+vzsEe2AEux2rNI+4KfVWMj4pOy/m0nWtALFF2hG8N+vNKur6PdrXO42Ut6oNwUtWmuqQyuQxCMZzZdKY4aUNtt0aUYpWyMZP2/cdw671It1Dw37YNPhNKz3TMBEFnvcpz3FpceIlThMQIPFBEA/S3x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NqOHQ5PS; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cfcf509fbdso1027747a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 03:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1707046785; x=1707651585; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+4UlMXgB1iSnvfZPma6T9agF6v1a63qxzKfCzYcsbL8=;
        b=NqOHQ5PSkaxsRFFqnnhySyNcCRfLBeJqXZ8HtG9MyJD83rjAmlr2ocVe2oFYy5N6RK
         +B4MER9Zztsr7xmvOZHLwlNrQxwYZXFHgU1ihFOI9QDzvBiFa5FqSPC7iF6vUnTpLe86
         kxe95j4zKMgrUXVp+tLAT8IHl25sclbfPC694ymms3ZijWiE0BXKyChGgT+es0JaQxVp
         BTL32MFiFszxI8t8DQUbjsH5Itk6ZQtDOuoVsaHGphPGhRjr+/IoMm7yiBi4kgEacuRi
         HwBnyAUfZ9Fdp7cueg3RqNOAvMctxBPIQAMOB4R0SAUY5lxVUXpvyt+5K7PYX/mJGAVO
         Ofhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707046785; x=1707651585;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+4UlMXgB1iSnvfZPma6T9agF6v1a63qxzKfCzYcsbL8=;
        b=FPG+XsExZzQf7TSJNg2IpL4+1mqWK8QIx6jYMQ30kWT0NbDaCdZpNKLXDXFSjMHwfR
         xn2DdFFqALucvhDWR67QUhVThGiltb6xKoIPxy5a4TCXIv9E85YqxVb2Ym7z5ZL0n1s5
         B40bWfzN/xtguwVjT2sTurjVbetT6TDnJibWVvw7k/WMYuN+JFJSjE2LZ/wbXzVi6a+6
         +Gs4sqwQmE6kf688HLtjSD5oIEXTKYGU8+NVTsuee6/sK8BEf0k5LctBwo1jtdd+VLZ8
         o4jlnEtQExbI699ViXAVKy3E0rRGcrdSx6OnXfPcZvW8O+uGtUBR/nKo/6zxpBYDaZfb
         ykmQ==
X-Forwarded-Encrypted: i=0; AJvYcCXVEoIDEinZIe4OKmoBK8U6HIQH3ORwizukgEsHRXJjAwzx3PS42oOH5pRo8ko1XU8hFySAR63/6RfGNTmYzM2GbmdXovsCXyZQsG2s
X-Gm-Message-State: AOJu0YyRzI3W/0BaWill3mxmNJGemVQun+inCxPg0GFe/0Q6AQDzIlUj
	+Xja7mu+fiMFKW9Px8FGPHEy5+M6G8SKeNEaAq9GHSmHcEA2lUzJ3fFnUQhST8c=
X-Google-Smtp-Source: AGHT+IE2DD5V3CgKYDy8mdE5bBy2Gf+zkQGDNsL7UW0p+H2rn/ScLbWb+QgJgAT32mIB+Y/G0mD8ag==
X-Received: by 2002:a17:90b:3506:b0:292:e812:19e8 with SMTP id ls6-20020a17090b350600b00292e81219e8mr11432390pjb.0.1707046785208;
        Sun, 04 Feb 2024 03:39:45 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUPl6IT911qvaWU6uhUXMMaas1HjkIVSffCYjMe+8bBADFT6Nog/Aj0/Alk0iMO8M2MoAZz3bBIYRlCrWf3XeqRt77L2UWDuwuTmLbIpW6ajjZMjTtLf0u4kNXpkX07Op7tpVA2wJlouq8WVLnADwGAwgHC2GA7ltb5UEa5dxDm++e+okbz7/mDKGC0kZG5t6CzaxJgMrKbP0hZGCWR3xU5bnm+sfHn86kFNgIkUQN45trvTbNWv42CmWuXvByjVV5KBVmHtp1vt1M=
Received: from [10.255.145.2] ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id pw2-20020a17090b278200b00295fdf538e1sm3250889pjb.12.2024.02.04.03.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 03:39:44 -0800 (PST)
Message-ID: <3b7e9435-d78e-4430-98d1-f4a839899425@bytedance.com>
Date: Sun, 4 Feb 2024 19:39:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: pgtable: add missing flag and statistics for
 kernel PTE page
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, arnd@arndb.de, muchun.song@linux.dev,
 david@redhat.com, willy@infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <f023a6687b9f2109401e7522b727aa4708dc05f1.1706774109.git.zhengqi.arch@bytedance.com>
 <Zb9t7WtFbZofN5WZ@kernel.org>
From: Qi Zheng <zhengqi.arch@bytedance.com>
Content-Language: en-US
In-Reply-To: <Zb9t7WtFbZofN5WZ@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mike,

On 2024/2/4 18:58, Mike Rapoport wrote:
> On Thu, Feb 01, 2024 at 04:05:40PM +0800, Qi Zheng wrote:
>> For kernel PTE page, we do not need to allocate and initialize its split
>> ptlock, but as a page table page, it's still necessary to add PG_table
>> flag and NR_PAGETABLE statistics for it.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   include/asm-generic/pgalloc.h |  7 ++++++-
>>   include/linux/mm.h            | 21 ++++++++++++++++-----
>>   2 files changed, 22 insertions(+), 6 deletions(-)
> 
> This should also update the architectures that define
> __HAVE_ARCH_PTE_ALLOC_ONE_KERNEL, otherwise NR_PAGETABLE counts will get
> wrong.

Yes, this patchset only focuses on the generic implementation. For those
architectures that define __HAVE_ARCH_PTE_ALLOC_ONE_KERNEL, some reuse
the generic __pte_alloc_one_kernel(), but some have their own customized
implementations, which indeed need to be fixed.

I wasn't familiar with those architectures and didn't investigate why
they couldn't reuse the generic __pte_alloc_one_kernel(), so I didn't
fix them. It would be better if there are maintainers corresponding to
the architecture who can help fix it. After all, they have a better
understanding of the historical background and have a testing
environment. ;)

> 
> Another related thing is that many architectures have custom allocations
> for early page tables and these would also benefit form NR_PAGETABLE
> accounting.

Indeed, this is also a point that can be optimized.

Thanks.

>   
>> diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
>> index 879e5f8aa5e9..908bd9140ac2 100644
>> --- a/include/asm-generic/pgalloc.h
>> +++ b/include/asm-generic/pgalloc.h
>> @@ -23,6 +23,8 @@ static inline pte_t *__pte_alloc_one_kernel(struct mm_struct *mm)
>>   
>>   	if (!ptdesc)
>>   		return NULL;
>> +
>> +	__pagetable_pte_ctor(ptdesc);
>>   	return ptdesc_address(ptdesc);
>>   }
>>   
>> @@ -46,7 +48,10 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>>    */
>>   static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
>>   {
>> -	pagetable_free(virt_to_ptdesc(pte));
>> +	struct ptdesc *ptdesc = virt_to_ptdesc(pte);
>> +
>> +	__pagetable_pte_dtor(ptdesc);
>> +	pagetable_free(ptdesc);
>>   }
>>   
>>   /**
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index e442fd0efdd9..e37db032764e 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -2922,26 +2922,37 @@ static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
>>   static inline void ptlock_free(struct ptdesc *ptdesc) {}
>>   #endif /* USE_SPLIT_PTE_PTLOCKS */
>>   
>> -static inline bool pagetable_pte_ctor(struct ptdesc *ptdesc)
>> +static inline void __pagetable_pte_ctor(struct ptdesc *ptdesc)
>>   {
>>   	struct folio *folio = ptdesc_folio(ptdesc);
>>   
>> -	if (!ptlock_init(ptdesc))
>> -		return false;
>>   	__folio_set_pgtable(folio);
>>   	lruvec_stat_add_folio(folio, NR_PAGETABLE);
>> +}
>> +
>> +static inline bool pagetable_pte_ctor(struct ptdesc *ptdesc)
>> +{
>> +	if (!ptlock_init(ptdesc))
>> +		return false;
>> +
>> +	__pagetable_pte_ctor(ptdesc);
>>   	return true;
>>   }
>>   
>> -static inline void pagetable_pte_dtor(struct ptdesc *ptdesc)
>> +static inline void __pagetable_pte_dtor(struct ptdesc *ptdesc)
>>   {
>>   	struct folio *folio = ptdesc_folio(ptdesc);
>>   
>> -	ptlock_free(ptdesc);
>>   	__folio_clear_pgtable(folio);
>>   	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
>>   }
>>   
>> +static inline void pagetable_pte_dtor(struct ptdesc *ptdesc)
>> +{
>> +	ptlock_free(ptdesc);
>> +	__pagetable_pte_dtor(ptdesc);
>> +}
>> +
>>   pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp);
>>   static inline pte_t *pte_offset_map(pmd_t *pmd, unsigned long addr)
>>   {
>> -- 
>> 2.30.2
>>
>>
> 

