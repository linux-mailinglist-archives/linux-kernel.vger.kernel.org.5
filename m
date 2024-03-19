Return-Path: <linux-kernel+bounces-107535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E84687FDC6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DDBE1C21D56
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A91B405FC;
	Tue, 19 Mar 2024 12:48:44 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC0740842
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710852522; cv=none; b=DJCTHEVM3pgTvamVoXOMN4xQIdzr7xgUsRLIVzphIPouxyAl5RmNhX5CpXCe8TXfzoL1rYNo+9MBqO8IeqD2o1OCMhUZQvkxWZ74cGG3MiF+5pT0Yx+zWYw3awT34M88yYJviun2iJJFbmOH3uA5mXJoYAtR3LYtxqqEfb5SXJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710852522; c=relaxed/simple;
	bh=eaVhfJvGv/hDmpx/njYgkJ4X//xScrjZU2TF4zYPJAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ky8cjz+E8Os8sdy/pJuftJ3B5owQLN3p7kw+Tqhhbjq+IhvAGhJpIfir3In3DYMsnS8DtPLDmU7s4S5+tmdzo2cilBr9PCWaMSL37VlxrPWZPMPVQJ+6xmmPWWiAsuvaoH0cuFXvbsoCtxGftgKSmM79+IojLSPhEhjVORV36vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id E316920004;
	Tue, 19 Mar 2024 12:48:12 +0000 (UTC)
Message-ID: <5c900e62-2101-4862-93cf-06292deccabf@ghiti.fr>
Date: Tue, 19 Mar 2024 13:48:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: mm: Fix prototype to avoid discarding const
Content-Language: en-US
To: Samuel Holland <samuel.holland@sifive.com>,
 linux-riscv@lists.infradead.org
Cc: Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 Andrew Jones <ajones@ventanamicro.com>, Anup Patel
 <apatel@ventanamicro.com>, Dylan Jhong <dylan@andestech.com>,
 Jisheng Zhang <jszhang@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Sergey Matyukevich <sergey.matyukevich@syntacore.com>,
 linux-kernel@vger.kernel.org
References: <20240301201837.2826172-1-samuel.holland@sifive.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240301201837.2826172-1-samuel.holland@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Samuel,

On 01/03/2024 21:18, Samuel Holland wrote:
> __flush_tlb_range() does not modify the provided cpumask, so its cmask
> parameter can be pointer-to-const. This avoids the unsafe cast of
> cpu_online_mask.
>
> Fixes: 54d7431af73e ("riscv: Add support for BATCHED_UNMAP_TLB_FLUSH")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
>   arch/riscv/mm/tlbflush.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 893566e004b7..07d743f87b3f 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -99,7 +99,7 @@ static void __ipi_flush_tlb_range_asid(void *info)
>   	local_flush_tlb_range_asid(d->start, d->size, d->stride, d->asid);
>   }
>   
> -static void __flush_tlb_range(struct cpumask *cmask, unsigned long asid,
> +static void __flush_tlb_range(const struct cpumask *cmask, unsigned long asid,
>   			      unsigned long start, unsigned long size,
>   			      unsigned long stride)
>   {
> @@ -200,7 +200,7 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>   
>   void flush_tlb_kernel_range(unsigned long start, unsigned long end)
>   {
> -	__flush_tlb_range((struct cpumask *)cpu_online_mask, FLUSH_TLB_NO_ASID,
> +	__flush_tlb_range(cpu_online_mask, FLUSH_TLB_NO_ASID,
>   			  start, end - start, PAGE_SIZE);
>   }
>   


Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


