Return-Path: <linux-kernel+bounces-138604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDBE89F450
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C170A1F2E47A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0DC15ECD8;
	Wed, 10 Apr 2024 13:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="NSlvbMzk"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FF415E811
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755814; cv=none; b=W0kTQ/aJ96eZBmWn5ioSyE4G5Z/FWPb6m4H25svQLJVYACcYXCiOQahY/OBgFC1f/60b+ODq4DBzozpPl+E2v2SSo7r5tr6mjuooN0oVm52GDHjIdBkIpDPirIFU89NVSZRoqPtjrNcMHXEPVGtDIuy1PjSOShzmLnhGLhac1NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755814; c=relaxed/simple;
	bh=QeB9OfJMdtuu+MeX+UDHBiMoyw3H56X3ot4ZLiDwEVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iANPelnelnMdoj0aggaZdo9H/41TWDuGwXFVrRgu8YYwLyjN+uaLSOGLd6WVsS5oEj5GxS5aV6ZBeV7nXFH6O3RlIr04NBOVIAD4KeO3VFnlvkHSiR2M8VXe+C/RLHH0W8ExGs8zWJ67GQtkaiz7Z81e5F/s62JGHZkdYjwM/nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=NSlvbMzk; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-346407b8c9aso627971f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712755809; x=1713360609; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=32iJp15PcGuZHbPnwm0RSMu5nUcxak1d7iCEjmrlYwI=;
        b=NSlvbMzkmQoWWCXbPZRcE6/c+z12dgFzN/P7OGjEjqyfESXEtkhzk31bAmMHQWOdiK
         4Qnpsgi+p7NMjNkSEuPtHTOcWpaj4XuOmEEVLFeqJNftZEXKYqw+bXS/6garqXG9RoH7
         3c/mJX5Ou/JbEctxzIRsfjTr2MqoWA5jt+erbYeWVd93x19Mv/I4OlkE0UGS7xbNELDB
         4MaVP+3L37Pxsby2apKh03UQGIksUuwmOGfyJrMtfKK1LpvM6sGiCVv++tdSdvkJf1R/
         tNGnb2pcw/yZDjcLHfF8NEg06SS2MErUl+3h2wyd4Zee8VEQT/oeUz0YWUormlLcAe2o
         k3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712755809; x=1713360609;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=32iJp15PcGuZHbPnwm0RSMu5nUcxak1d7iCEjmrlYwI=;
        b=cG7zdOw+JzxAHYXjQIM4572yq64CWLF1OCy5a+VBNPzA1H9MiDpjHtrSRebQJ/0hqy
         nQ9UXcIygpM3GZaZ6Ue4iWe6+PCdiiONcwukWI8lFuqCheS59IV+W4+Ia9vGow1P/uMs
         E+nvi55sPDJvSvT775m9G8oU4fSvyXbPTNGgohpxNRlbfTB4zMftlytesQd37N3sKbCg
         m5sdpEyGp0jGjPfi8j1y+BfQqDsPKCYOrRt16MK3mlzc6bSmQ3d3NRGT34Fd/CxP23MC
         nYqG+nlK0QuGjuT7yUnwuqkuhxpFYLeKOYXvDialoqLH8MKzcOUfv4dsIQg/sLcsKokP
         i52Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEd0AggZCl2tquUO9pS5LK92q4rjGfhUoz9/8vKSQpBUH934KLgQtea17xv1hEb1wWyxFgOkddJWPqvBBkTZXawp00n2H7+YtcAHSu
X-Gm-Message-State: AOJu0YyETuAa8WLhJIBxd9WpWOrSVKcMpEaihY69wEkLzarLONnUqafD
	frrg/YKpdrquNaiNhvEH4rklGZkOMWBx3U38hlPWtIhMPU2XtSTENm+VkIiRrpk=
X-Google-Smtp-Source: AGHT+IEQhbdT5IHPax2HDjZgCdrhEdBpQ4lhA3SmQHGmfssPRjRA4igWvzVJELZqULIYdxKtSy/7FQ==
X-Received: by 2002:a05:600c:35d5:b0:416:648f:9a6d with SMTP id r21-20020a05600c35d500b00416648f9a6dmr1900769wmq.1.1712755809450;
        Wed, 10 Apr 2024 06:30:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:d4a6:5856:3e6c:3dff? ([2a01:e0a:999:a3a0:d4a6:5856:3e6c:3dff])
        by smtp.gmail.com with ESMTPSA id bd12-20020a05600c1f0c00b00416645e7e47sm2300102wmb.13.2024.04.10.06.30.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 06:30:08 -0700 (PDT)
Message-ID: <b40ee162-0b65-4259-a14c-e927a4f90ea6@rivosinc.com>
Date: Wed, 10 Apr 2024 15:30:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: Call secondary mmu notifier when flushing the
 tlb
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240328073838.8776-1-alexghiti@rivosinc.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20240328073838.8776-1-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 28/03/2024 08:38, Alexandre Ghiti wrote:
> This is required to allow the IOMMU driver to correctly flush its own
> TLB.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
> 
> Changes in v2:
> - Rebase on top of 6.9-rc1
> 
>  arch/riscv/mm/tlbflush.c | 39 +++++++++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 893566e004b7..854d984deb07 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -4,6 +4,7 @@
>  #include <linux/smp.h>
>  #include <linux/sched.h>
>  #include <linux/hugetlb.h>
> +#include <linux/mmu_notifier.h>
>  #include <asm/sbi.h>
>  #include <asm/mmu_context.h>
>  
> @@ -99,11 +100,19 @@ static void __ipi_flush_tlb_range_asid(void *info)
>  	local_flush_tlb_range_asid(d->start, d->size, d->stride, d->asid);
>  }
>  
> -static void __flush_tlb_range(struct cpumask *cmask, unsigned long asid,
> +static inline unsigned long get_mm_asid(struct mm_struct *mm)

Hi Alex,

Nit: the inline attribute is probably useless.

> +{
> +	return (mm && static_branch_unlikely(&use_asid_allocator)) ?
> +			atomic_long_read(&mm->context.id) & asid_mask : FLUSH_TLB_NO_ASID;
> +}
> +
> +static void __flush_tlb_range(struct mm_struct *mm,
> +			      struct cpumask *cmask,
>  			      unsigned long start, unsigned long size,
>  			      unsigned long stride)
>  {
>  	struct flush_tlb_range_data ftd;
> +	unsigned long asid = get_mm_asid(mm);
>  	bool broadcast;
>  
>  	if (cpumask_empty(cmask))
> @@ -137,31 +146,26 @@ static void __flush_tlb_range(struct cpumask *cmask, unsigned long asid,
>  
>  	if (cmask != cpu_online_mask)
>  		put_cpu();
> -}
>  
> -static inline unsigned long get_mm_asid(struct mm_struct *mm)
> -{
> -	return static_branch_unlikely(&use_asid_allocator) ?
> -			atomic_long_read(&mm->context.id) & asid_mask : FLUSH_TLB_NO_ASID;
> +	if (mm)
> +		mmu_notifier_arch_invalidate_secondary_tlbs(mm, start, start + size);
>  }
>  
>  void flush_tlb_mm(struct mm_struct *mm)
>  {
> -	__flush_tlb_range(mm_cpumask(mm), get_mm_asid(mm),
> -			  0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
> +	__flush_tlb_range(mm, mm_cpumask(mm), 0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
>  }
>  
>  void flush_tlb_mm_range(struct mm_struct *mm,
>  			unsigned long start, unsigned long end,
>  			unsigned int page_size)
>  {
> -	__flush_tlb_range(mm_cpumask(mm), get_mm_asid(mm),
> -			  start, end - start, page_size);
> +	__flush_tlb_range(mm, mm_cpumask(mm), start, end - start, page_size);
>  }
>  
>  void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
>  {
> -	__flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm),
> +	__flush_tlb_range(vma->vm_mm, mm_cpumask(vma->vm_mm),
>  			  addr, PAGE_SIZE, PAGE_SIZE);
>  }
>  
> @@ -194,13 +198,13 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>  		}
>  	}
>  
> -	__flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm),
> +	__flush_tlb_range(vma->vm_mm, mm_cpumask(vma->vm_mm),
>  			  start, end - start, stride_size);
>  }
>  
>  void flush_tlb_kernel_range(unsigned long start, unsigned long end)
>  {
> -	__flush_tlb_range((struct cpumask *)cpu_online_mask, FLUSH_TLB_NO_ASID,
> +	__flush_tlb_range(NULL, (struct cpumask *)cpu_online_mask,
>  			  start, end - start, PAGE_SIZE);
>  }
>  
> @@ -208,7 +212,7 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
>  void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
>  			unsigned long end)
>  {
> -	__flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm),
> +	__flush_tlb_range(vma->vm_mm, mm_cpumask(vma->vm_mm),
>  			  start, end - start, PMD_SIZE);
>  }
>  #endif
> @@ -222,7 +226,10 @@ void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
>  			       struct mm_struct *mm,
>  			       unsigned long uaddr)
>  {
> +	unsigned long start = uaddr & PAGE_MASK;
> +
>  	cpumask_or(&batch->cpumask, &batch->cpumask, mm_cpumask(mm));
> +	mmu_notifier_arch_invalidate_secondary_tlbs(mm, start, start + PAGE_SIZE);
>  }
>  
>  void arch_flush_tlb_batched_pending(struct mm_struct *mm)
> @@ -232,7 +239,7 @@ void arch_flush_tlb_batched_pending(struct mm_struct *mm)
>  
>  void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
>  {
> -	__flush_tlb_range(&batch->cpumask, FLUSH_TLB_NO_ASID, 0,
> -			  FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
> +	__flush_tlb_range(NULL, &batch->cpumask,
> +			  0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
>  	cpumask_clear(&batch->cpumask);
>  }

Other than that, looks good to me,

Reviewed-by: Clément Léger <cleger@rivosinc.com>

Thanks,

Clément


