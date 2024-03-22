Return-Path: <linux-kernel+bounces-111849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F4B8871A8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C11C1C22035
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E6E5F84F;
	Fri, 22 Mar 2024 17:09:09 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7465D8F0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 17:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711127349; cv=none; b=f+Du17/Mw81ElUdE4GTwko9SSajwQLlLLLAs0CPMSqZ8rV5asHlS5mlkXx9KcCD1FKYKTcvQ1GL3djIn/DFo5pYSOrO/yLiBmJHj+2Wdgo2h604YqdctXjxZQQ7UxVGrT26B2DuYgUvIYSLtGqUMnCH1S5834R0fSRrECz/fZwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711127349; c=relaxed/simple;
	bh=e6nWyD6TjJq8QDK1Xb2Y39EeCBOjqWyjA8FxmeUfZ3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EoLxPnOyvZNkHbc4h2uv/SRV2FmAm9SQEKAKo9WCQHk1ml6B3+P4F5ODw0/IQ6rvNSIx5bZv5WaBX15Vg05VJ92cotsVXLWBhQu1HhRdkpN2Cflu5wgF3uj5TOYDGDaIMQG1NaBPXnz6e+9oMe9ge64yxefZk9gJJ9lSZG2QwiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7849F40007;
	Fri, 22 Mar 2024 17:08:55 +0000 (UTC)
Message-ID: <0a1e9afc-e999-451f-8d4f-670f7c15e609@ghiti.fr>
Date: Fri, 22 Mar 2024 18:08:55 +0100
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
To: Qingfang Deng <dqfext@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Atish Patra <atishp@atishpatra.org>, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
 Qingfang Deng <qingfang.deng@siflower.com.cn>
References: <20240322090002.311645-1-dqfext@gmail.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240322090002.311645-1-dqfext@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Qingfang,

On 22/03/2024 10:00, Qingfang Deng wrote:
> From: Qingfang Deng <qingfang.deng@siflower.com.cn>
>
> nr_irqs will not be initialized if of_property_read_u32 returns an
> error. Check the error first.
>
> Fixes: 8237f8bc4f6e ("irqchip: add a SiFive PLIC driver")
> Signed-off-by: Qingfang Deng <qingfang.deng@siflower.com.cn>
> ---
>   drivers/irqchip/irq-sifive-plic.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index 5b7bc4fd9517..f436b61d74b0 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -428,8 +428,11 @@ static int __init __plic_init(struct device_node *node,
>   		goto out_free_priv;
>   	}
>   
> +	error = of_property_read_u32(node, "riscv,ndev", &nr_irqs);
> +	if (error)
> +		goto out_iounmap;
> +
>   	error = -EINVAL;
> -	of_property_read_u32(node, "riscv,ndev", &nr_irqs);
>   	if (WARN_ON(!nr_irqs))
>   		goto out_iounmap;
>   


You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


