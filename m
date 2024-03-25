Return-Path: <linux-kernel+bounces-117979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A492988B1FC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA03B1C62E87
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7F55C60D;
	Mon, 25 Mar 2024 20:46:09 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024625C613
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399568; cv=none; b=LESjkKtQ/gM7GUOhN4lkm9As3hioB8lAd7anLvS8YWnKpj5IxAWBeJ09CSSrMZnEZO3jxdiJUFgM7APK+jKR7t3iOeCyht9m4rfQGYkNQDys8XygcJjg4t8hEIP5j/y6mlG6x6R5pO3v6AMMfbU1vG74gAiRdYOsVjX+BYHEkQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399568; c=relaxed/simple;
	bh=VFo1mOaMAwLKVHt9nXePQ0nAnhVGcTNZ8psz1WZuNgA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rVlFKAgq/YJun/QF74pyPGqIlYreb1PLg5D/ttCaIKnia+foVTja/NXI54INfpZ4rR1ajztppFf5rJdprqrgjMGt+If7Wk5aUPQJiJGjZWPAeuiGsSTNtuD4Mlx6YobBy7zhEdG44LbD9fiEY52vyfBqlezq/T0szB/l5c+C6X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 612F2E0004;
	Mon, 25 Mar 2024 20:45:59 +0000 (UTC)
Message-ID: <0eeb142e-1c74-44f8-9f58-365bee3a670f@ghiti.fr>
Date: Mon, 25 Mar 2024 21:45:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] irqchip/sifive-plic: Fix error handling of
 of_property_read_u32
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
To: Qingfang Deng <dqfext@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Atish Patra <atishp@atishpatra.org>, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
 Qingfang Deng <qingfang.deng@siflower.com.cn>
References: <20240322090002.311645-1-dqfext@gmail.com>
 <0a1e9afc-e999-451f-8d4f-670f7c15e609@ghiti.fr>
In-Reply-To: <0a1e9afc-e999-451f-8d4f-670f7c15e609@ghiti.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

Hi Qingfang,

On 22/03/2024 18:08, Alexandre Ghiti wrote:
> Hi Qingfang,
>
> On 22/03/2024 10:00, Qingfang Deng wrote:
>> From: Qingfang Deng <qingfang.deng@siflower.com.cn>
>>
>> nr_irqs will not be initialized if of_property_read_u32 returns an
>> error. Check the error first.
>>
>> Fixes: 8237f8bc4f6e ("irqchip: add a SiFive PLIC driver")
>> Signed-off-by: Qingfang Deng <qingfang.deng@siflower.com.cn>
>> ---
>>   drivers/irqchip/irq-sifive-plic.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-sifive-plic.c 
>> b/drivers/irqchip/irq-sifive-plic.c
>> index 5b7bc4fd9517..f436b61d74b0 100644
>> --- a/drivers/irqchip/irq-sifive-plic.c
>> +++ b/drivers/irqchip/irq-sifive-plic.c
>> @@ -428,8 +428,11 @@ static int __init __plic_init(struct device_node 
>> *node,
>>           goto out_free_priv;
>>       }
>>   +    error = of_property_read_u32(node, "riscv,ndev", &nr_irqs);
>> +    if (error)
>> +        goto out_iounmap;
>> +
>>       error = -EINVAL;
>> -    of_property_read_u32(node, "riscv,ndev", &nr_irqs);
>>       if (WARN_ON(!nr_irqs))
>>           goto out_iounmap;
>

So this is actually already fixed in 6.9-rc1 by this commit: 
956521064780 ("irqchip/sifive-plic: Parse number of interrupts and 
contexts early in plic_probe()").

Thanks,

Alex


>
> You can add:
>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>
> Thanks,
>
> Alex
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

