Return-Path: <linux-kernel+bounces-81045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9636866F6A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBCD61C25446
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0738253397;
	Mon, 26 Feb 2024 09:24:21 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A0E52F7F;
	Mon, 26 Feb 2024 09:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708939460; cv=none; b=Vf/T4Khq2Y9zPQ6WPYYgcVB7+npc0YjdHjUAWJiNPQv/CBsyxZ4EppLDvqSckVS4XrPcAgSO2m1Wlj8lLMZ5X2rc3/TrFweMMll2/tcrMbugCNQmCh1Ls996FZrJckV/RaLBiES1oZqIhCYZvQMp2UHvFzMqzj/Ccb19/FQWUR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708939460; c=relaxed/simple;
	bh=3L3vyjwLUBTxJ8F+6hqzqB6n+xT9bUSLXeQwycOpv64=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=LLLyq8lu1H0z43+b/yEED8POr7nahfHbor5nzdR4FonD88GntyQBsCJwQfz3saplVO8GsUSobmavREisaDrciQuWn4CLJAnVxciQbKJ/3V56k+XvxLFJFUDTCl3XmeTU4cwWCJXBRoRSOBypRLc9dANtP4+hN5+0pbvd4oQ40jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.24])
	by gateway (Coremail) with SMTP id _____8BxefC_WNxlWIoRAA--.45641S3;
	Mon, 26 Feb 2024 17:24:15 +0800 (CST)
Received: from [10.20.42.24] (unknown [10.20.42.24])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxTs28WNxlXABFAA--.48896S3;
	Mon, 26 Feb 2024 17:24:12 +0800 (CST)
Subject: Re: [PATCH] irqchip/loongson-pch-pic: Update interrupt registration
 policy
To: Thomas Gleixner <tglx@linutronix.de>, chenhuacai@kernel.org,
 jiaxun.yang@flygoat.com
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 Baoqi Zhang <zhangbaoqi@loongson.cn>, Biao Dong <dongbiao@loongson.cn>
References: <20240223102612.1499-1-zhangtianyang@loongson.cn>
 <875xyccu1n.ffs@tglx>
From: Tianyang Zhang <zhangtianyang@loongson.cn>
Message-ID: <a1a42903-eac1-0dfd-d500-64a93ea81da3@loongson.cn>
Date: Mon, 26 Feb 2024 17:24:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <875xyccu1n.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:AQAAf8AxTs28WNxlXABFAA--.48896S3
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW3XFyUtr4UWrW7WF13GF43CFX_yoW7KFy3pF
	W8Jw4akFWUJry8W392vw1UZrySva93ta45KF4ft347Xwn0vFykKFWI9ryq9F48ZrZ5Kr1Y
	vw4Ygr909a1DAFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jepB-UUUUU=

Hi Thomas,

Thank you very much for your reply. my response below, please review

在 2024/2/26 上午1:50, Thomas Gleixner 写道:
> On Fri, Feb 23 2024 at 18:26, Tianyang Zhang wrote:
>> From: Baoqi Zhang <zhangbaoqi@loongson.cn>
>>
>> We have removed the fixed mapping between the 7A interrupt source
>> and the HT interrupt vector, and replaced it with a dynamically
>> allocated approach. This will be more conducive to fully utilizing
>> existing vectors to support more devices
> You are describing _WHAT_ the patch is doing, but you fail to explain
> the context and the _WHY_.
I will rewrite the commit as required
>> Signed-off-by: Baoqi Zhang <zhangbaoqi@loongson.cn>
>> Signed-off-by: Zhang Tianyang <zhangtianyang@loongson.cn>
>> Signed-off-by: Biao Dong <dongbiao@loongson.cn>
> This Signed-off-by chain is wrong. You, Tianyang, are sending this,
> right?
>
> See
>
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
>
> and the following chapters.
sorry, I will reorganize the Signed-off-by chain
>> ---
>>   drivers/irqchip/irq-loongson-pch-pic.c | 64 +++++++++++++++++++-------
>>   1 file changed, 47 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
>> index 63db8e2172e0..86549356e76e 100644
>> --- a/drivers/irqchip/irq-loongson-pch-pic.c
>> +++ b/drivers/irqchip/irq-loongson-pch-pic.c
>> @@ -34,6 +34,8 @@
>>   #define PIC_REG_IDX(irq_id)	((irq_id) / PIC_COUNT_PER_REG)
>>   #define PIC_REG_BIT(irq_id)	((irq_id) % PIC_COUNT_PER_REG)
>>   
>> +#define hwirq_to_bit(priv, hirq)	(((priv)->table)[(hirq)])
> Make this a static inline please.
Okay, I will follow the suggestions and make the necessary modifications
>>   static int nr_pics;
>>   
>>   struct pch_pic {
>> @@ -46,6 +48,8 @@ struct pch_pic {
>>   	u32			saved_vec_en[PIC_REG_COUNT];
>>   	u32			saved_vec_pol[PIC_REG_COUNT];
>>   	u32			saved_vec_edge[PIC_REG_COUNT];
>> +	u8			table[PIC_COUNT];
>> +	int			inuse;
>>   };
>>   
>>   static struct pch_pic *pch_pic_priv[MAX_IO_PICS];
>> @@ -80,45 +84,47 @@ static void pch_pic_mask_irq(struct irq_data *d)
>>   {
>>   	struct pch_pic *priv = irq_data_get_irq_chip_data(d);
>>   
>> -	pch_pic_bitset(priv, PCH_PIC_MASK, d->hwirq);
>> +	pch_pic_bitset(priv, PCH_PIC_MASK, hwirq_to_bit(priv, d->hwirq));
>>   	irq_chip_mask_parent(d);
>>   }
>>   
>>   static void pch_pic_unmask_irq(struct irq_data *d)
>>   {
>> +	int bit = hwirq_to_bit(priv, d->hwirq);
>>   	struct pch_pic *priv = irq_data_get_irq_chip_data(d);
> How does this even compile?
This is an error that occurred during the patch delivery process. I am 
very sorry and will immediately correct and improve the submission process
>>   
>> -	writel(BIT(PIC_REG_BIT(d->hwirq)),
>> -			priv->base + PCH_PIC_CLR + PIC_REG_IDX(d->hwirq) * 4);
>> +	writel(BIT(PIC_REG_BIT(bit)),
>> +			priv->base + PCH_PIC_CLR + PIC_REG_IDX(bit) * 4);
>>   
>>   	irq_chip_unmask_parent(d);
>> -	pch_pic_bitclr(priv, PCH_PIC_MASK, d->hwirq);
>> +	pch_pic_bitclr(priv, PCH_PIC_MASK, bit);
>>   }
>>   
>>   static int pch_pic_set_type(struct irq_data *d, unsigned int type)
>>   {
>> +	int bit = hwirq_to_bit(priv, d->hwirq);
>>   	struct pch_pic *priv = irq_data_get_irq_chip_data(d);
> And this?
>
> By chance because you used a macro instead of an inline function. But
> it's still incorrect and wrong.
Just like above, I apologize again
>> @@ -157,6 +164,7 @@ static int pch_pic_domain_translate(struct irq_domain *d,
>>   					unsigned long *hwirq,
>>   					unsigned int *type)
>>   {
>> +	int i;
>>   	struct pch_pic *priv = d->host_data;
>>   	struct device_node *of_node = to_of_node(fwspec->fwnode);
> Please see:
>
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variable-declarations
Thanks for reminder, this will be fixed to follow the declaration method 
of the reverse fir tree
>    
>> @@ -171,6 +179,20 @@ static int pch_pic_domain_translate(struct irq_domain *d,
>>   			return -EINVAL;
>>   
>>   		*hwirq = fwspec->param[0] - priv->gsi_base;
>> +
>> +		raw_spin_lock(&priv->pic_lock);
> This was clearly never tested with lockdep enabled. Why?
>
> Because lockdep would have told you that this takes the spinlock with
> interrupts enabled while it is taken in the mask()/unmask() callbacks
> from hard interrupt context.

Thank you for your correction. After using lockdep testing and learning 
the details of spinlock,

I will replace the original function with 
raw_spin_lock_irqsave/raw_spin_lock_irqrestore

>> +		for (i = 0; i < priv->inuse; i++) {
>> +			if (priv->table[i] == *hwirq) {
>> +				*hwirq = i;
>> +				break;
>> +			}
>> +		}
>> +		if (i == priv->inuse && priv->inuse < PIC_COUNT) {
>> +			priv->table[priv->inuse] = *hwirq;
>> +			*hwirq = priv->inuse++;
>> +		}
> So in case that priv->inuse == PIC_COUNT this does not set hwirq and
> returns with bogus values.

We did miss the code for exception handling here, partly because the 
number of interrupt

sources on our device is far less than PIC_COUNT. However, this will 
still cause problems,

and we will add a code to prompt error handling

>> +		raw_spin_unlock(&priv->pic_lock);
>> +
>> @@ -294,6 +320,10 @@ static int pch_pic_init(phys_addr_t addr, unsigned long size, int vec_base,
>>   	if (!priv->base)
>>   		goto free_priv;
>>   
>> +	priv->inuse = 0;
>> +	for (i = 0; i < PIC_COUNT; i++)
>> +		priv->table[i] = -1;
> table is an array of u8. So how does -1 make sense? Even if it would
> make sense, then you can't ever have 256 interrupts in use because the
> truncated -1 is equivalent to hwirq 255.

The original intention of using -1 here was to mark the initialization 
status of a table entry,

For indicating an invalid state, we think -1 is a more prominent 
notation compared to 255

but we overlooked its original type . In next patch, we will replace 
this immediate with a macro

Thanks again

                 Tianyang



