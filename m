Return-Path: <linux-kernel+bounces-32482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23075835C32
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0474288396
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A87B1A71B;
	Mon, 22 Jan 2024 07:59:14 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECF53611B;
	Mon, 22 Jan 2024 07:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705910353; cv=none; b=AFBTgWnsuyKbTnDlgP2B5Ukn7eJjPoucF23/GNm6pu7GSnpGotr3tkmNY61dEQLXZrRfFTzHn4Fea7XOnYLedSODsKZssMcqWvWKwIb5bYoMT6Jl1gef8h/hvsgZPgWm0EkkErYKhuPTijAmrSNTYKugf8nzxgYQNosx0LvMUhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705910353; c=relaxed/simple;
	bh=pGlZ3QI3Lga899NkB9oFLprRpavbHJNhgA8T4iPQJlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MCbGGX3d3mL7jYdEeuVGHm/yJLOrjsIXTG78rwgt6J6c1fbfmp8jy/CbXrxKpdlNudH5iSu7H3Ac/R4sd0lvSMFj/IepAnVPzvym5DamzTYFTY5o5YDbcYQ6lg01HK8FP0Nm3ZpFjdE5JWJTiFPIaFdSBKPWjuC51MXNEyBUf2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id A80011BF206;
	Mon, 22 Jan 2024 07:59:00 +0000 (UTC)
Message-ID: <048fc58d-abbb-4696-9ed0-f5a0fadce740@ghiti.fr>
Date: Mon, 22 Jan 2024 08:58:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Use kcalloc() instead of kzalloc()
Content-Language: en-US
To: Erick Archer <erick.archer@gmx.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor.dooley@microchip.com>,
 Andrew Jones <ajones@ventanamicro.com>, Evan Green <evan@rivosinc.com>,
 =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Jisheng Zhang <jszhang@kernel.org>, Charlie Jenkins <charlie@rivosinc.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240120135400.4710-1-erick.archer@gmx.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240120135400.4710-1-erick.archer@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Erick,

On 20/01/2024 14:54, Erick Archer wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
>
> So, use the purpose specific kcalloc() function instead of the argument
> count * size in the kzalloc() function.
>
> Also, it is preferred to use sizeof(*pointer) instead of sizeof(type)
> due to the type of the variable can change and one needs not change the
> former (unlike the latter).
>
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Erick Archer <erick.archer@gmx.com>
> ---
>   arch/riscv/kernel/cpufeature.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 89920f84d0a3..549a76e34c4e 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -901,8 +901,7 @@ static int check_unaligned_access_all_cpus(void)
>   {
>   	unsigned int cpu;
>   	unsigned int cpu_count = num_possible_cpus();
> -	struct page **bufs = kzalloc(cpu_count * sizeof(struct page *),
> -				     GFP_KERNEL);
> +	struct page **bufs = kcalloc(cpu_count, sizeof(*bufs), GFP_KERNEL);
>
>   	if (!bufs) {
>   		pr_warn("Allocation failure, not measuring misaligned performance\n");
> --
> 2.25.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


