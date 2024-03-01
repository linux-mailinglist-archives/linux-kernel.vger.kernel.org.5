Return-Path: <linux-kernel+bounces-87840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF8286D9CD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35D23B2252A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BA33FE23;
	Fri,  1 Mar 2024 02:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ezFreAyj"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A922B9D6
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 02:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709260473; cv=none; b=qST2wBbzCZEa/vpC+uU9/Hk96G4sPj02PagsRW9H9e9dvbD9QTsHURHbuDXNX91RmxI+vmE9mPKY/Nt1hr9YajY9yYG4bvUD3HHj/rQgfDmryVokevlchL2yePkPPqpMX3XB8EtxMX1awEI7tuvWFaHDRTnJaU4nxXMvj5TS24Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709260473; c=relaxed/simple;
	bh=A0aYR0MgzP4toqJvZBrrg0Xefrtv0wFDldailUGrkVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DPYZBjb8j2fWC/NkkUfXCwAZUN8y+Nma5SiypHEV5w/0yepkFJ66HQefpYg1M94CglX84YI6xQxP4fZjxSv1Hlg39swWg7XFdRsrwxXMR45jnoR5VcgocVcb/akWoIcbAz0D8QMPODhpffdZi9EmR+a53Oe4dPrCz5ExL7RMkIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ezFreAyj; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-36576b35951so10052605ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 18:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1709260471; x=1709865271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yAET4leT0nXdUH/7/mbrBgjLpgYR5i4eKJ96mLEVZIk=;
        b=ezFreAyjoL3mKtpce9zpSvyttAGjrjOABNCa6nTHuOI6WhWCgTOqlNeL2l9VLE8pSj
         +86MY/X4zMbIjrNLcE59zm6GvbIAwyki2HS4p/R6ATBeRbS9Ao+r4B313Cj7JBabbu03
         p07bBpaLrS+uOIKMK244+x45+pUbuUrAeVgtU4s8nKDBDXJnYfHdm5yliYKntjgs9Ghs
         1OlGqqv8EtKaBLfYtcEZ24oV4e22tKwywsUzJzpgkoIJfvAprxvHHR2NQtpLN4xcyiaD
         TWJZOFmr4wQBWoWkzaoXlp7CpWkfYijM2a5gkrwo4MoAdDqRAj6cTked4EXxl+tkFjFW
         8mnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709260471; x=1709865271;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yAET4leT0nXdUH/7/mbrBgjLpgYR5i4eKJ96mLEVZIk=;
        b=iPA5vQJ0cH/by1Abl9U3XHb8iEY5xqB1J6uwZkSll4Av9G5vQoqUQ8sBWLCS1CKqgI
         QtO52Wq273Kz4GFTuDuYLPygCs6oZu8tqPw0MwJ+GXMbHN6bMSRsY2sxvAJ5cQ1zIIWA
         lMvHbDZt3PDyBX+41clN27W963euqyl/hNg2jmX6lpYnyuGwkLMTiSKruDs6NhZTq2c1
         rc8j1pUK+pk7LntsYrpciPu+Ls58zbyzuwu/lFg4wuTlyry25E8oLqhu0CKj2yaxVeGV
         CpSxB5WRQEvCyvGQuQftXYQYaJSSxp2dIx77rK/M+T+oHQulSxwpt2BggmPPuUbGusvv
         mkpw==
X-Forwarded-Encrypted: i=1; AJvYcCUjI7y0HVnVa8G+EqCFzPadhtVaxtHiPM9rR95A56AfsLQNhGxM5rY45FK2SgAmG0B0Q/hyGA1IH9zLMH3S1IIOrFgMnREyYRYKpfrY
X-Gm-Message-State: AOJu0Yw9naY0WjPmvI9iFMmY84bR8EIjotTKBpzLklRtZOu5cV/RgTq4
	n14TsfnNtNdu8/QPI2gy1/IjGXeRCy82u5m70LOT2Ta1quA7J52yYFxKf78JoE4=
X-Google-Smtp-Source: AGHT+IHd7NbVyfUVYaIJTDtVo/BZe0JoHEDalKRgzupc9cLRGsTgC4gNqvIlKHujIa4XQO9kGrONMg==
X-Received: by 2002:a05:6e02:160d:b0:365:23fe:12fb with SMTP id t13-20020a056e02160d00b0036523fe12fbmr613992ilu.11.1709260471245;
        Thu, 29 Feb 2024 18:34:31 -0800 (PST)
Received: from [100.64.0.1] ([170.85.6.201])
        by smtp.gmail.com with ESMTPSA id x9-20020a92dc49000000b0036421b06054sm656564ilq.20.2024.02.29.18.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 18:34:30 -0800 (PST)
Message-ID: <952cad64-d022-4ace-8125-3b20d3684348@sifive.com>
Date: Thu, 29 Feb 2024 20:34:29 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] [PATCH v5 06/13] riscv: mm: Combine the SMP and UP TLB
 flush code
Content-Language: en-US
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Jisheng Zhang <jszhang@kernel.org>
References: <20240229232211.161961-1-samuel.holland@sifive.com>
 <20240229232211.161961-7-samuel.holland@sifive.com>
 <CAEEQ3wnCAqPjXEnSXc9Vce-kWETmbUpyzBdXi_2K+h+NZt4SqQ@mail.gmail.com>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <CAEEQ3wnCAqPjXEnSXc9Vce-kWETmbUpyzBdXi_2K+h+NZt4SqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Yunhui,

On 2024-02-29 8:12 PM, yunhui cui wrote:
> On Fri, Mar 1, 2024 at 7:22 AM Samuel Holland <samuel.holland@sifive.com> wrote:
>>
>> In SMP configurations, all TLB flushing narrower than flush_tlb_all()
>> goes through __flush_tlb_range(). Do the same in UP configurations.
>>
>> This allows UP configurations to take advantage of recent improvements
>> to the code in tlbflush.c, such as support for huge pages and flushing
>> multiple-page ranges.
>>
>> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> ---
>>
>> (no changes since v4)
>>
>> Changes in v4:
>>  - Merge the two copies of __flush_tlb_range() and rely on the compiler
>>    to optimize out the broadcast path (both clang and gcc do this)
>>  - Merge the two copies of flush_tlb_all() and rely on constant folding
>>
>> Changes in v2:
>>  - Move the SMP/UP merge earlier in the series to avoid build issues
>>  - Make a copy of __flush_tlb_range() instead of adding ifdefs inside
>>  - local_flush_tlb_all() is the only function used on !MMU (smpboot.c)
>>
>>  arch/riscv/Kconfig                |  2 +-
>>  arch/riscv/include/asm/tlbflush.h | 30 +++---------------------------
>>  arch/riscv/mm/Makefile            |  5 +----
>>  3 files changed, 5 insertions(+), 32 deletions(-)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 0bfcfec67ed5..de9b6f2279ff 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -60,7 +60,7 @@ config RISCV
>>         select ARCH_USE_MEMTEST
>>         select ARCH_USE_QUEUED_RWLOCKS
>>         select ARCH_USES_CFI_TRAPS if CFI_CLANG
>> -       select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH if SMP && MMU
>> +       select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH if MMU
>>         select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
>>         select ARCH_WANT_FRAME_POINTERS
>>         select ARCH_WANT_GENERAL_HUGETLB if !RISCV_ISA_SVNAPOT
>> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
>> index 928f096dca21..4f86424b1ba5 100644
>> --- a/arch/riscv/include/asm/tlbflush.h
>> +++ b/arch/riscv/include/asm/tlbflush.h
>> @@ -27,12 +27,7 @@ static inline void local_flush_tlb_page(unsigned long addr)
>>  {
>>         ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
>>  }
>> -#else /* CONFIG_MMU */
>> -#define local_flush_tlb_all()                  do { } while (0)
>> -#define local_flush_tlb_page(addr)             do { } while (0)
>> -#endif /* CONFIG_MMU */
>>
>> -#if defined(CONFIG_SMP) && defined(CONFIG_MMU)
>>  void flush_tlb_all(void);
>>  void flush_tlb_mm(struct mm_struct *mm);
>>  void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
>> @@ -54,27 +49,8 @@ void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
>>                                unsigned long uaddr);
>>  void arch_flush_tlb_batched_pending(struct mm_struct *mm);
>>  void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
>> -
>> -#else /* CONFIG_SMP && CONFIG_MMU */
>> -
>> -#define flush_tlb_all() local_flush_tlb_all()
>> -#define flush_tlb_page(vma, addr) local_flush_tlb_page(addr)
>> -
>> -static inline void flush_tlb_range(struct vm_area_struct *vma,
>> -               unsigned long start, unsigned long end)
>> -{
>> -       local_flush_tlb_all();
>> -}
>> -
>> -/* Flush a range of kernel pages */
>> -static inline void flush_tlb_kernel_range(unsigned long start,
>> -       unsigned long end)
>> -{
>> -       local_flush_tlb_all();
>> -}
>> -
>> -#define flush_tlb_mm(mm) flush_tlb_all()
>> -#define flush_tlb_mm_range(mm, start, end, page_size) flush_tlb_all()
>> -#endif /* !CONFIG_SMP || !CONFIG_MMU */
>> +#else /* CONFIG_MMU */
>> +#define local_flush_tlb_all()                  do { } while (0)
>> +#endif /* CONFIG_MMU */
>>
>>  #endif /* _ASM_RISCV_TLBFLUSH_H */
>> diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
>> index 2c869f8026a8..cbe4d775ef56 100644
>> --- a/arch/riscv/mm/Makefile
>> +++ b/arch/riscv/mm/Makefile
>> @@ -13,14 +13,11 @@ endif
>>  KCOV_INSTRUMENT_init.o := n
>>
>>  obj-y += init.o
>> -obj-$(CONFIG_MMU) += extable.o fault.o pageattr.o pgtable.o
>> +obj-$(CONFIG_MMU) += extable.o fault.o pageattr.o pgtable.o tlbflush.o
>>  obj-y += cacheflush.o
>>  obj-y += context.o
>>  obj-y += pmem.o
>>
>> -ifeq ($(CONFIG_MMU),y)
>> -obj-$(CONFIG_SMP) += tlbflush.o
>> -endif
>>  obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
>>  obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
>>  obj-$(CONFIG_KASAN)   += kasan_init.o
>> --
>> 2.43.1
>>
> 
> git am the patch failed. Was it a patch based on the top commit of linux-next ?

This series is based on the for-next branch of riscv.git, which is where it
would be applied. There is a conflict with commit d9807d60c145 ("riscv: mm:
execute local TLB flush after populating vmemmap") in the riscv.git fixes
branch, which added a uniprocessor-specific local_flush_tlb_kernel_range()
definition. The appropriate merge conflict resolution is to remove that new
macro, i.e. take the version of the file from this patch series.

Regards,
Samuel


