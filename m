Return-Path: <linux-kernel+bounces-131051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 482DF89826C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 090B0287313
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BEB5C903;
	Thu,  4 Apr 2024 07:48:36 +0000 (UTC)
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DF463C7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 07:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712216916; cv=none; b=mNG6tQ0VGQrtohoZ/i5elLSoNgQPovGrlhZ29szuHE47z9ZPJfrbKaE/a0kak0eLOmtxMIZqzJu7EG6SUTSNr9Z7N3Wrkx2ay74MG/nx96XPhjQSUF90pRHcXDTU2LI0G3bteq9EoZkXY2tmhClcIe84TF9zYBfU9VOAa5twrcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712216916; c=relaxed/simple;
	bh=6cuEysdOMQHA78g+8RSnfygXfbIu/BhcdJlH5F4q/VA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qbQftoMb0HHEygN4+GNpXMevm9hKXhNuLqawO/TW+gXpGGxHriMqtN74MgZn6Ra4QRR9kwWByuDgF+HTDz5uPQRnb6GvdS8oHNNREWGuLXXdBdQHyT7b4kGV6QoQwVc5pN5Y0+HtCV7YHIJF6lrtSg6Eu/QH079FMxeZFQWpZJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: from relay7-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::227])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 92DE5C4241
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 07:48:25 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C811E20002;
	Thu,  4 Apr 2024 07:48:18 +0000 (UTC)
Message-ID: <faa34598-7207-45b4-be6a-e37a1fe1d5a3@ghiti.fr>
Date: Thu, 4 Apr 2024 09:48:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/13] riscv: Factor out page table TLB synchronization
Content-Language: en-US
To: Samuel Holland <samuel.holland@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Jisheng Zhang
 <jszhang@kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>
References: <20240327045035.368512-1-samuel.holland@sifive.com>
 <20240327045035.368512-3-samuel.holland@sifive.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240327045035.368512-3-samuel.holland@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr


On 27/03/2024 05:49, Samuel Holland wrote:
> The logic is the same for all page table levels. See commit 69be3fb111e7
> ("riscv: enable MMU_GATHER_RCU_TABLE_FREE for SMP && MMU").
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
> Changes in v6:
>   - Move riscv_tlb_remove_ptdesc() definition to fix 32-bit build
>
> Changes in v5:
>   - New patch for v5
>
>   arch/riscv/include/asm/pgalloc.h | 31 +++++++++++++------------------
>   1 file changed, 13 insertions(+), 18 deletions(-)
>
> diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
> index deaf971253a2..b34587da8882 100644
> --- a/arch/riscv/include/asm/pgalloc.h
> +++ b/arch/riscv/include/asm/pgalloc.h
> @@ -15,6 +15,14 @@
>   #define __HAVE_ARCH_PUD_FREE
>   #include <asm-generic/pgalloc.h>
>   
> +static inline void riscv_tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
> +{
> +	if (riscv_use_ipi_for_rfence())
> +		tlb_remove_page_ptdesc(tlb, pt);
> +	else
> +		tlb_remove_ptdesc(tlb, pt);
> +}
> +
>   static inline void pmd_populate_kernel(struct mm_struct *mm,
>   	pmd_t *pmd, pte_t *pte)
>   {
> @@ -102,10 +110,7 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
>   		struct ptdesc *ptdesc = virt_to_ptdesc(pud);
>   
>   		pagetable_pud_dtor(ptdesc);
> -		if (riscv_use_ipi_for_rfence())
> -			tlb_remove_page_ptdesc(tlb, ptdesc);
> -		else
> -			tlb_remove_ptdesc(tlb, ptdesc);
> +		riscv_tlb_remove_ptdesc(tlb, ptdesc);
>   	}
>   }
>   
> @@ -139,12 +144,8 @@ static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
>   static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
>   				  unsigned long addr)
>   {
> -	if (pgtable_l5_enabled) {
> -		if (riscv_use_ipi_for_rfence())
> -			tlb_remove_page_ptdesc(tlb, virt_to_ptdesc(p4d));
> -		else
> -			tlb_remove_ptdesc(tlb, virt_to_ptdesc(p4d));
> -	}
> +	if (pgtable_l5_enabled)
> +		riscv_tlb_remove_ptdesc(tlb, virt_to_ptdesc(p4d));
>   }
>   #endif /* __PAGETABLE_PMD_FOLDED */
>   
> @@ -176,10 +177,7 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
>   	struct ptdesc *ptdesc = virt_to_ptdesc(pmd);
>   
>   	pagetable_pmd_dtor(ptdesc);
> -	if (riscv_use_ipi_for_rfence())
> -		tlb_remove_page_ptdesc(tlb, ptdesc);
> -	else
> -		tlb_remove_ptdesc(tlb, ptdesc);
> +	riscv_tlb_remove_ptdesc(tlb, ptdesc);
>   }
>   
>   #endif /* __PAGETABLE_PMD_FOLDED */
> @@ -190,10 +188,7 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
>   	struct ptdesc *ptdesc = page_ptdesc(pte);
>   
>   	pagetable_pte_dtor(ptdesc);
> -	if (riscv_use_ipi_for_rfence())
> -		tlb_remove_page_ptdesc(tlb, ptdesc);
> -	else
> -		tlb_remove_ptdesc(tlb, ptdesc);
> +	riscv_tlb_remove_ptdesc(tlb, ptdesc);
>   }
>   #endif /* CONFIG_MMU */
>   


Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>


