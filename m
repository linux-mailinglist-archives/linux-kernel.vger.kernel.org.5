Return-Path: <linux-kernel+bounces-80238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B57B862C67
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 18:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA2371F21EFF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D649518EB0;
	Sun, 25 Feb 2024 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y6MsJnBj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OrM9zNRK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234DD18045;
	Sun, 25 Feb 2024 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708883433; cv=none; b=AhWBaIPKmJvrcaaM9W7AUTj8Q5oInkjC1arGdmTlEufF8mSeSEzcvqxCnOhIzEDsM2uHExEaxsQgGM2KKG2XAEzFnVj8fUcIZhmvIBw4fIGmjwepUHUlHxR43dcGfU1j8x9UhfEiqF0F3LahLFIr8GOPyrNfcKHOWQVQa/ETNBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708883433; c=relaxed/simple;
	bh=hKjDaiAmBsLSksi6PPVIwrSv1B11206xJhwkAlMhZK4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HrKLaK6L2DHGQ+15PHvjLmhsStxuV64Yr0A0sDkfM5uIuBkqVtwSsYrtF1VIp5m//Nw5+glwlGZ5seJWfurudOks7a5w7rbr7Ub7NEGRf0hNV5ougW6dsN/Ms+3OdE4hdZfTiOlY1d+S36wqiyckT3KygeVrmXzFabF2t18ij4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y6MsJnBj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OrM9zNRK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708883429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s4AgxkOV8a1w0nLTDYUiF91kDwuNF+KspPzrm/WXg9U=;
	b=y6MsJnBjlsaP6RXfTagm0XJanqTTETXhEI5yfqKnvd1knMpf1ANPi+/436CbqEmGAYXCQC
	s7rRZ7Eu/URi6bLJuzpZPRR1/LKwjFqq69gBBuL3k1JZ4m8Uz8YKa9i9Z1m85+7Uc3SmbI
	eisP5Bzpd0G4PX4i5wCSwCgxfxFTa58ODGsYeSQPux/phX8OXjPa/smciVvqtSXq+nzoZm
	JfdKiaGxxAGWM5wZ+mUC+E8Rf3yuvtkabByuTh7vDV3kgedY2FPz9+a41YnB9GBFyTIYWT
	uihSoiCdSFlJcp61IioZ8LkRTLF4P1miW7XjIMYhhbW48+C9hAtOsxw5akXp+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708883429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s4AgxkOV8a1w0nLTDYUiF91kDwuNF+KspPzrm/WXg9U=;
	b=OrM9zNRKeV51KC1EcE7alYHbKhU5ehh5F74+AsDHvGoRHCbRNsomUpbIDgH1+MKrj/glJH
	EooABNPGRZc3Q6Bg==
To: Tianyang Zhang <zhangtianyang@loongson.cn>, chenhuacai@kernel.org,
 jiaxun.yang@flygoat.com
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, Baoqi Zhang
 <zhangbaoqi@loongson.cn>, Zhang Tianyang <zhangtianyang@loongson.cn>, Biao
 Dong <dongbiao@loongson.cn>
Subject: Re: [PATCH] irqchip/loongson-pch-pic: Update interrupt registration
 policy
In-Reply-To: <20240223102612.1499-1-zhangtianyang@loongson.cn>
References: <20240223102612.1499-1-zhangtianyang@loongson.cn>
Date: Sun, 25 Feb 2024 18:50:28 +0100
Message-ID: <875xyccu1n.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Feb 23 2024 at 18:26, Tianyang Zhang wrote:
> From: Baoqi Zhang <zhangbaoqi@loongson.cn>
>
> We have removed the fixed mapping between the 7A interrupt source
> and the HT interrupt vector, and replaced it with a dynamically
> allocated approach. This will be more conducive to fully utilizing
> existing vectors to support more devices

You are describing _WHAT_ the patch is doing, but you fail to explain
the context and the _WHY_.

> Signed-off-by: Baoqi Zhang <zhangbaoqi@loongson.cn>
> Signed-off-by: Zhang Tianyang <zhangtianyang@loongson.cn>
> Signed-off-by: Biao Dong <dongbiao@loongson.cn>

This Signed-off-by chain is wrong. You, Tianyang, are sending this,
right?

See

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

and the following chapters.

> ---
>  drivers/irqchip/irq-loongson-pch-pic.c | 64 +++++++++++++++++++-------
>  1 file changed, 47 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
> index 63db8e2172e0..86549356e76e 100644
> --- a/drivers/irqchip/irq-loongson-pch-pic.c
> +++ b/drivers/irqchip/irq-loongson-pch-pic.c

> @@ -34,6 +34,8 @@
>  #define PIC_REG_IDX(irq_id)	((irq_id) / PIC_COUNT_PER_REG)
>  #define PIC_REG_BIT(irq_id)	((irq_id) % PIC_COUNT_PER_REG)
>  
> +#define hwirq_to_bit(priv, hirq)	(((priv)->table)[(hirq)])

Make this a static inline please.

>  static int nr_pics;
>  
>  struct pch_pic {
> @@ -46,6 +48,8 @@ struct pch_pic {
>  	u32			saved_vec_en[PIC_REG_COUNT];
>  	u32			saved_vec_pol[PIC_REG_COUNT];
>  	u32			saved_vec_edge[PIC_REG_COUNT];
> +	u8			table[PIC_COUNT];
> +	int			inuse;
>  };
>  
>  static struct pch_pic *pch_pic_priv[MAX_IO_PICS];
> @@ -80,45 +84,47 @@ static void pch_pic_mask_irq(struct irq_data *d)
>  {
>  	struct pch_pic *priv = irq_data_get_irq_chip_data(d);
>  
> -	pch_pic_bitset(priv, PCH_PIC_MASK, d->hwirq);
> +	pch_pic_bitset(priv, PCH_PIC_MASK, hwirq_to_bit(priv, d->hwirq));
>  	irq_chip_mask_parent(d);
>  }
>  
>  static void pch_pic_unmask_irq(struct irq_data *d)
>  {
> +	int bit = hwirq_to_bit(priv, d->hwirq);
>  	struct pch_pic *priv = irq_data_get_irq_chip_data(d);

How does this even compile?

>  
> -	writel(BIT(PIC_REG_BIT(d->hwirq)),
> -			priv->base + PCH_PIC_CLR + PIC_REG_IDX(d->hwirq) * 4);
> +	writel(BIT(PIC_REG_BIT(bit)),
> +			priv->base + PCH_PIC_CLR + PIC_REG_IDX(bit) * 4);
>  
>  	irq_chip_unmask_parent(d);
> -	pch_pic_bitclr(priv, PCH_PIC_MASK, d->hwirq);
> +	pch_pic_bitclr(priv, PCH_PIC_MASK, bit);
>  }
>  
>  static int pch_pic_set_type(struct irq_data *d, unsigned int type)
>  {
> +	int bit = hwirq_to_bit(priv, d->hwirq);
>  	struct pch_pic *priv = irq_data_get_irq_chip_data(d);

And this?

By chance because you used a macro instead of an inline function. But
it's still incorrect and wrong.

> @@ -157,6 +164,7 @@ static int pch_pic_domain_translate(struct irq_domain *d,
>  					unsigned long *hwirq,
>  					unsigned int *type)
>  {
> +	int i;
>  	struct pch_pic *priv = d->host_data;
>  	struct device_node *of_node = to_of_node(fwspec->fwnode);

Please see:

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variable-declarations
  
> @@ -171,6 +179,20 @@ static int pch_pic_domain_translate(struct irq_domain *d,
>  			return -EINVAL;
>  
>  		*hwirq = fwspec->param[0] - priv->gsi_base;
> +
> +		raw_spin_lock(&priv->pic_lock);

This was clearly never tested with lockdep enabled. Why?

Because lockdep would have told you that this takes the spinlock with
interrupts enabled while it is taken in the mask()/unmask() callbacks
from hard interrupt context.

> +		for (i = 0; i < priv->inuse; i++) {
> +			if (priv->table[i] == *hwirq) {
> +				*hwirq = i;
> +				break;
> +			}
> +		}
> +		if (i == priv->inuse && priv->inuse < PIC_COUNT) {
> +			priv->table[priv->inuse] = *hwirq;
> +			*hwirq = priv->inuse++;
> +		}

So in case that priv->inuse == PIC_COUNT this does not set hwirq and
returns with bogus values.

> +		raw_spin_unlock(&priv->pic_lock);
> +
> @@ -294,6 +320,10 @@ static int pch_pic_init(phys_addr_t addr, unsigned long size, int vec_base,
>  	if (!priv->base)
>  		goto free_priv;
>  
> +	priv->inuse = 0;
> +	for (i = 0; i < PIC_COUNT; i++)
> +		priv->table[i] = -1;

table is an array of u8. So how does -1 make sense? Even if it would
make sense, then you can't ever have 256 interrupts in use because the
truncated -1 is equivalent to hwirq 255.

Thanks,

        tglx



